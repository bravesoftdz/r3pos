unit ufrmStkInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxDropDownEdit, cxTextEdit, cxCalendar, cxControls, ZBase,
  cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, StdCtrls,
  Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxCheckBox, RzLabel;

type
  TfrmStkInvoice = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    cdsDetail: TZQuery;
    cdsHeader: TZQuery;
    RzPanel4: TRzPanel;
    Image1: TImage;
    Label14: TLabel;
    RzPanel1: TRzPanel;
    Label7: TLabel;
    Label17: TLabel;
    Label40: TLabel;
    Label5: TLabel;
    edtREMARK: TcxTextEdit;
    edtCLIENT_ID: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtDEPT_ID: TzrComboBoxList;
    RzPanel3: TRzPanel;
    RzLabel1: TRzLabel;
    Label6: TLabel;
    edtCREA_DATE: TcxDateEdit;
    RzLabel2: TRzLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtINVOICE_NO: TcxTextEdit;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    edtINVOICE_MNY: TcxTextEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    RzPanel8: TRzPanel;
    RzLabel3: TRzLabel;
    edtIfDuplicate: TcxCheckBox;
    edtCREA_USER: TzrComboBoxList;
    Label3: TLabel;
    edtINVOICE_FLAG: TcxComboBox;
    RzPanel9: TRzPanel;
    Label1: TLabel;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    edtINVH_ID: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    FisAudit: boolean;
    Fcid: string;
    FInvoiceMny: Real;
    FClientId: String;
    FInvoiceId: String;
    FIvioType: String;
    Tax_Rate:Currency;
    { Private declarations }
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Setcid(const Value: string);
    procedure SetisAudit(const Value: boolean);
    procedure SetClientId(const Value: String);
    procedure SetInvoiceMny(const Value: Real);
    procedure SetInvoiceId(const Value: String);
    function ReadInvoiceNo(Flag:String):String;
    function ReadInvoiceId:String;
    procedure WriteInvoiceNo(Flag,InvoiceNo:String);
    procedure WriteInvoiceId(InvoiceId:String);
    function IncInvoiceNo(InvoiceNo:String):String;
    procedure SetIvioType(const Value: String);
    procedure LoadFormat;override;
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
    property IvioType:String read FIvioType write SetIvioType;
  end;

implementation
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal, IniFiles, ufrmBasic,
  Math;
{$R *.dfm}

{ TfrmSalInvoice }

procedure TfrmStkInvoice.Append;
var
  rs:TZQuery;
  i: Integer;
  Invoice_Id:String;
begin
  Open('');
  dbState := dsInsert;
  edtCREA_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  rs := Global.GetZQueryFromName('PUB_CLIENTINFO');
  if rs.Locate('CLIENT_ID',ClientId,[]) then
  begin
     edtCLIENT_ID.KeyValue := rs.FieldByName('CLIENT_ID').AsString;
     edtCLIENT_ID.Text := rs.FieldByName('CLIENT_NAME').AsString;
  end;
  if (edtINVOICE_FLAG.ItemIndex<0) and (InvoiceId <> '') then
  begin
     edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',InvoiceId);
      if InvoiceId='1' then
         Tax_Rate := 0
      else if InvoiceId = '2' then
         Tax_Rate := StrToFloatDef(ShopGlobal.GetParameter('IN_RATE2'),0.05)
      else if InvoiceId = '3' then
         Tax_Rate := StrToFloatDef(ShopGlobal.GetParameter('IN_RATE3'),0.17);
  end;
  edtCREA_USER.KeyValue := Global.UserID;
  edtCREA_USER.Text := Global.UserName;
  edtINVOICE_MNY.Text := FormatFloat('#0.00',InvoiceMny);
  AObj.FieldbyName('INVD_ID').asString := TSequence.NewId();
  AObj.FieldByName('INVOICE_STATUS').AsString := '1';
  AObj.FieldByName('EXPORT_STATUS').AsString := '1';
  edtCLIENT_IDSaveValue(nil);
  Invoice_Id := ReadInvoiceId;

  {if edtINVOICE_FLAG.ItemIndex >= 0 then
     edtINVOICE_NO.Text := ReadInvoiceNo(TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsString)
  else
     edtINVOICE_FLAG.Enabled := True;}
  if edtINVOICE_FLAG.ItemIndex < 0 then edtINVOICE_FLAG.Enabled := True;

  if edtINVH_ID.CanFocus and Visible then edtINVH_ID.SetFocus;
end;

procedure TfrmStkInvoice.CancelOrder;
begin

end;

procedure TfrmStkInvoice.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除一张空单...');
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TStkInvoiceOrder');
    Factor.AddBatch(cdsDetail,'TStkInvoiceData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
end;

procedure TfrmStkInvoice.Edit(id: string);
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

procedure TfrmStkInvoice.Open(id: string);
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
        Factor.AddBatch(cdsHeader,'TStkInvoiceOrder',Params);
        Factor.AddBatch(cdsDetail,'TStkInvoiceData',Params);
        Factor.OpenBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;
      //edtSHOP_ID.Properties.ReadOnly := False;
      AObj.ReadFromDataSet(cdsHeader);
      ReadFromObject(AObj,self);
      if (Length(Trim(edtINVOICE_NO.Text))<8) and (Trim(edtINVOICE_NO.Text)<>'') then
         edtINVOICE_NO.Text := FnString.FormatStringEx(Trim(edtINVOICE_NO.Text),8);
      dbState := dsBrowse;
      //isAudit := (AObj.FieldByName('CHK_DATE').AsString <> '');
    finally
      Params.Free;
    end;
  finally
    locked:=False;
  end;
end;

procedure TfrmStkInvoice.SaveOrder;
var Params:TftParamList;
    rs:TZQuery;
    n:Integer;
    totalmny:real;
begin
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('请选择开票客户');
  if Trim(edtINVOICE_NO.Text) = '' then Raise Exception.Create('发票号不能为空');
  if edtCREA_DATE.EditValue = null then Raise Exception.Create('请选择开票日期');
  if edtCREA_USER.AsString = '' then Raise Exception.Create('开票人不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('开票部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create('开票门店不能为空');
  if not edtIfDuplicate.Checked then
  begin
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.SQL.Text :=
      ' select INVD_ID from SAL_INVOICE_INFO where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID and INVOICE_NO=:INVOICE_NO ';
      rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
      rs.ParamByName('INVOICE_NO').AsString := Trim(edtINVOICE_NO.Text);
      Factor.Open(rs);
      if not rs.IsEmpty then
      begin
         if dbState = dsInsert then
            Raise Exception.Create('发票号"'+Trim(edtINVOICE_NO.Text)+'"已经存在!');
         if dbState = dsEdit then
         begin
            rs.First;
            while not rs.Eof do
            begin
              if rs.FieldByName('INVD_ID').AsString <> AObj.FieldByName('INVD_ID').AsString then
                 Raise Exception.Create('发票号"'+Trim(edtINVOICE_NO.Text)+'"已经存在!');
              rs.Next;
            end;
         end;
      end;
    finally
      rs.Free;
    end;
  end;
  n := 1;
  cdsDetail.First;
  while not cdsDetail.Eof do
  begin
    cdsDetail.Edit;
    cdsDetail.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsDetail.FieldByName('INVD_ID').AsString := cdsHeader.FieldByName('INVD_ID').AsString;
    cdsDetail.FieldByName('SEQNO').AsInteger := n;
    totalmny := totalmny + cdsDetail.FieldByName('NOTAX_MNY').AsFloat+cdsDetail.FieldByName('TAX_MNY').AsFloat;
    Inc(n);
    cdsDetail.Post;
    cdsDetail.Next;
  end;

  WriteToObject(AObj,self);
  if AObj.FieldByName('ADDR_NAME').AsString = '' then AObj.FieldByName('ADDR_NAME').AsString := '无';
  AObj.FieldByName('INVOICE_MNY').AsFloat := totalmny; 
  cdsHeader.Edit;
  AObj.WriteToDataSet(cdsHeader);
  cdsHeader.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  if dbState = dsInsert then
     cdsHeader.FieldByName('IVIO_TYPE').AsString := IvioType;
  cdsHeader.Post;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TStkInvoiceOrder');
    Factor.AddBatch(cdsDetail,'TStkInvoiceData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
  if Assigned(OnSave) then OnSave(AObj);
end;

procedure TfrmStkInvoice.Setcid(const Value: string);
begin
  Fcid := Value;
end;

procedure TfrmStkInvoice.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnOk.Visible:=(dbState<>dsBrowse);
  DBGridEh1.Readonly := (dbState=dsBrowse);
  case Value of
  dsInsert:begin
     Caption := '进项发票--(新增)';
     Label14.Caption := '状态:新增';
  end;
  dsEdit:begin
     Caption := '进项发票--(修改)';
     Label14.Caption := '状态:修改';
     edtINVOICE_NO.Enabled := False;
  end;
  else
      begin
        Caption := '进项发票';
        Label14.Caption := '状态:查看';
        btnOk.Visible := False;
      end;
  end;
end;

procedure TfrmStkInvoice.SetisAudit(const Value: boolean);
begin
  FisAudit := Value;
end;

procedure TfrmStkInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtCREA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');

end;

procedure TfrmStkInvoice.edtCLIENT_IDSaveValue(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if edtCLIENT_ID.AsString = '' then Exit;
  rs := Global.GetZQueryFromName('PUB_CLIENTINFO');
  if not rs.Locate('CLIENT_ID',edtCLIENT_ID.AsString,[]) then Raise Exception.Create('选择的供应商没找到,异常错误.');
  AObj.FieldByName('INVO_NAME').AsString := rs.FieldByName('CLIENT_NAME').AsString;
  AObj.FieldByName('ADDR_NAME').AsString := rs.FieldByName('ADDRESS').AsString;

end;

procedure TfrmStkInvoice.SetClientId(const Value: String);
begin
  FClientId := Value;
end;

procedure TfrmStkInvoice.SetInvoiceMny(const Value: Real);
begin
  FInvoiceMny := Value;
end;

procedure TfrmStkInvoice.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmStkInvoice.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveOrder;
  ModalResult := MROK;
end;

procedure TfrmStkInvoice.SetInvoiceId(const Value: String);
begin
  FInvoiceId := Value;
end;

procedure TfrmStkInvoice.FormShow(Sender: TObject);
begin
  inherited;
  if edtINVH_ID.CanFocus then edtINVH_ID.SetFocus;
  cdsDetail.First;
  while not cdsDetail.Eof do
  begin
    cdsDetail.Edit;
    cdsDetail.FieldByName('TAX_MNY').AsString :=  formatFloat('#0.00',(cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat)*(1+Tax_Rate)/Tax_Rate);
    cdsDetail.FieldByName('NOTAX_MNY').AsFloat := (cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat)-cdsDetail.FieldByName('TAX_MNY').AsFloat;
    cdsDetail.Post;
    cdsDetail.Next;
  end;
  if TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsString <> '3' then
     DBGridEh1.Columns[6].Visible := False;
end;

function TfrmStkInvoice.ReadInvoiceNo(Flag: String): String;
var F:TIniFile;
    L,InvoiceNo:Integer;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.ini');
  try
    Result := F.ReadString('INVOICE','NO'+Flag+'_'+Global.UserID,'');
    L := length(Result);
    if Trim(Result) <> '' then
    begin
       InvoiceNo := StrToIntDef(Result,0)+1;
       if L < 8 then
          Result := FnString.FormatStringEx(IntToStr(InvoiceNo),8,'0')
       else
          Result := IntToStr(InvoiceNo);
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmStkInvoice.WriteInvoiceNo(Flag, InvoiceNo: String);
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.ini');
  try
    F.WriteString('INVOICE','NO'+Flag+'_'+Global.UserID,InvoiceNo);
  finally
    F.Free;
  end;
end;

function TfrmStkInvoice.IncInvoiceNo(InvoiceNo: String): String;
var
  Number: string;
  vNo,i,vLen,vLen1: integer;
begin
  result:='';
  Number:=trim(InvoiceNo);
  vLen:=8;
  vNo:=strtoInt(Number)+1;
  i:=Length(inttoStr(vNo));
  if i<8 then
     result:=FnString.FormatStringEx(IntToStr(vNo),8);
end;

procedure TfrmStkInvoice.SetIvioType(const Value: String);
begin
  FIvioType := Value;
end;

function TfrmStkInvoice.ReadInvoiceId: String;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.ini');
  try
    Result := F.ReadString('INVOICE',Global.UserID,'');
  finally
    F.Free;
  end;
end;

procedure TfrmStkInvoice.WriteInvoiceId(InvoiceId: String);
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.ini');
  try
    F.WriteString('INVOICE',Global.UserID,InvoiceId);
  finally
    F.Free;
  end;

end;

procedure TfrmStkInvoice.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsDetail.RecNo)),length(Inttostr(cdsDetail.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  //DBGridEh1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  with (Sender as TDBGridEh).Canvas do
  begin
    Pen.Color := clGreen;
    MoveTo(Rect.Left,Rect.Bottom);
    LineTo(Rect.Right,Rect.Bottom);
    MoveTo(Rect.Right,Rect.Top);
    LineTo(Rect.Right,Rect.Bottom);
  end;
end;

procedure TfrmStkInvoice.LoadFormat;
begin
//  inherited;

end;

end.
