unit ufrmSalInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxDropDownEdit, cxTextEdit, cxCalendar, cxControls, ZBase,
  cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, StdCtrls,
  Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmSalInvoice = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    cdsDetail: TZQuery;
    cdsHeader: TZQuery;
    CdsInvoice: TZQuery;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label17: TLabel;
    Label3: TLabel;
    Label40: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    edtINVH_ID: TzrComboBoxList;
    edtCREA_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    RzPanel4: TRzPanel;
    Image1: TImage;
    Label14: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtINVOICE_FLAG: TcxComboBox;
    edtSHOP_ID: TzrComboBoxList;
    edtINVOICE_NO: TcxTextEdit;
    edtINVOICE_MNY: TcxTextEdit;
    edtDEPT_ID: TzrComboBoxList;
    edtCREA_USER: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    FisAudit: boolean;
    Fcid: string;
    FInvoiceMny: Real;
    FClientId: String;
    FInvoiceId: String;
    { Private declarations }
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Setcid(const Value: string);
    procedure SetisAudit(const Value: boolean);
    procedure SetClientId(const Value: String);
    procedure SetInvoiceMny(const Value: Real);
    procedure SetInvoiceId(const Value: String);
  public
    { Public declarations }
    AObj:TRecord_;
    locked:Boolean;
    procedure Open(id:string);
    procedure Append;
    procedure Edit(id:string);
    procedure SaveOrder;
    procedure CancelOrder;
    procedure DeleteOrder;
    property cid:string read Fcid write Setcid;
    property ClientId:String read FClientId write SetClientId;
    property InvoiceId:String read FInvoiceId write SetInvoiceId;
    property InvoiceMny:Real read FInvoiceMny write SetInvoiceMny;
    property isAudit:boolean read FisAudit write SetisAudit;
  end;

implementation
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal, ufrmBasic;
{$R *.dfm}

{ TfrmSalInvoice }

procedure TfrmSalInvoice.Append;
var
  rs:TZQuery;
  i: Integer;
begin
  Open('');
  dbState := dsInsert;
  edtCREA_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  rs := Global.GetZQueryFromName('PUB_CUSTOMER');
  rs.Locate('CLIENT_ID',ClientId,[]);
  edtCLIENT_ID.KeyValue := rs.FieldByName('CLIENT_ID').AsString;
  edtCLIENT_ID.Text := rs.FieldByName('CLIENT_NAME').AsString;
  if edtINVOICE_FLAG.ItemIndex<0 then edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',InvoiceId);
  edtCREA_USER.KeyValue := Global.UserID;
  edtCREA_USER.Text := Global.UserName;
  edtINVOICE_MNY.Text := FloatToStr(InvoiceMny);
  AObj.FieldbyName('INVD_ID').asString := TSequence.NewId();
  AObj.FieldByName('INVOICE_STATUS').AsString := '1';
  edtCLIENT_IDSaveValue(nil);

  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
end;

procedure TfrmSalInvoice.CancelOrder;
begin

end;

procedure TfrmSalInvoice.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除一张空单...');
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TInvoiceOrder');
    Factor.AddBatch(cdsDetail,'TInvoiceData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
end;

procedure TfrmSalInvoice.Edit(id: string);
begin
  Open(id);
  dbState := dsEdit;
  //btnOk.Enabled:=False;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;
end;

procedure TfrmSalInvoice.Open(id: string);
var Params:TftParamList;
begin
  locked:=True;
  try
    Params := TftParamList.Create(nil);
    try
      Factor.BeginBatch;
      try
        Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
        Params.ParamByName('INVD_ID').asString := id;
        Factor.AddBatch(cdsHeader,'TInvoiceOrder',Params);
        Factor.AddBatch(cdsDetail,'TInvoiceData',Params);
        Factor.OpenBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;
      //edtSHOP_ID.Properties.ReadOnly := False;
      AObj.ReadFromDataSet(cdsHeader);
      ReadFromObject(AObj,self);
      dbState := dsBrowse;
      //isAudit := (AObj.FieldByName('CHK_DATE').AsString <> '');
    finally
      Params.Free;
    end;
  finally
    locked:=False;
  end;
end;

procedure TfrmSalInvoice.SaveOrder;
var
  n:integer;
  rs:TZQuery;
  r:real;
begin
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('请选择开票客户');
  if Trim(edtINVOICE_NO.Text) = '' then Raise Exception.Create('发票号不能为空');
  if edtCREA_DATE.EditValue = null then Raise Exception.Create('请选择开票日期');
  if edtCREA_USER.AsString = '' then Raise Exception.Create('开票人不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('开票部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create('开票门店不能为空');
  WriteToObject(AObj,self);
  cdsHeader.Edit;
  AObj.WriteToDataSet(cdsHeader);
  //cdsHeader.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cdsHeader.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsHeader.Post;
  cdsDetail.First;
  while not cdsDetail.Eof do
  begin
    cdsDetail.Edit;
    cdsDetail.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsDetail.FieldByName('INVD_ID').AsString := cdsHeader.FieldByName('INVD_ID').AsString;
    cdsDetail.Post;
    cdsDetail.Next;
  end;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TInvoiceOrder');
    Factor.AddBatch(cdsDetail,'TInvoiceData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
  if Assigned(OnSave) then OnSave(AObj);
end;

procedure TfrmSalInvoice.Setcid(const Value: string);
begin
  Fcid := Value;
end;

procedure TfrmSalInvoice.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnOk.Visible:=(dbState<>dsBrowse);
  case Value of
  dsInsert:begin
     Caption := '开票单--(新增)';
     Label14.Caption := '状态:新增';
  end;
  dsEdit:begin
     Caption := '开票单--(修改)';
     Label14.Caption := '状态:修改';
  end;
  else
      begin
        Caption := '开票单';
        Label14.Caption := '状态:查看';
      end;
  end;
end;

procedure TfrmSalInvoice.SetisAudit(const Value: boolean);
begin
  FisAudit := Value;
end;

procedure TfrmSalInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtCREA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  CdsInvoice.Close;
  CdsInvoice.SQL.Text := ' select INVH_ID,INVH_NO,INVOICE_FLAG from SAL_INVOICE_BOOK where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') ';
  CdsInvoice.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Factor.Open(CdsInvoice);

end;

procedure TfrmSalInvoice.edtCLIENT_IDSaveValue(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  rs := Global.GetZQueryFromName('PUB_CUSTOMER');
  if not rs.Locate('CLIENT_ID',edtCLIENT_ID.AsString,[]) then Raise Exception.Create('选择的客户没找到,异常错误.');
  AObj.FieldByName('INVO_NAME').AsString := rs.FieldByName('CLIENT_NAME').AsString;
  AObj.FieldByName('ADDR_NAME').AsString := rs.FieldByName('ADDRESS').AsString;
  if AObj.FieldByName('ADDR_NAME').AsString = '' then AObj.FieldByName('ADDR_NAME').AsString := '无';
end;

procedure TfrmSalInvoice.SetClientId(const Value: String);
begin
  FClientId := Value;
end;

procedure TfrmSalInvoice.SetInvoiceMny(const Value: Real);
begin
  FInvoiceMny := Value;
end;

procedure TfrmSalInvoice.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSalInvoice.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveOrder;
  ModalResult := MROK;
end;

procedure TfrmSalInvoice.SetInvoiceId(const Value: String);
begin
  FInvoiceId := Value;
end;

end.
