unit ufrmTransOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxCurrencyEdit, Grids, DBGridEh, zBase, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmTransOrder = class(TframeDialogForm)
    Panel1: TPanel;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label6: TLabel;
    edtTRANS_DATE: TcxDateEdit;
    actAddRecvAbleInfo: TAction;
    RzPanel4: TRzPanel;
    Shape1: TShape;
    lblCaption: TLabel;
    Image1: TImage;
    Label14: TLabel;
    cdsHeader: TZQuery;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    LabOUT_ACCOUNT_ID: TLabel;
    LabIN_ACCOUNT_ID: TLabel;
    edtOUT_ACCOUNT_ID: TzrComboBoxList;
    edtIN_ACCOUNT_ID: TzrComboBoxList;
    Label17: TLabel;
    Label4: TLabel;
    edtTRANS_MNY: TcxTextEdit;
    Label7: TLabel;
    edtREMARK: TcxTextEdit;
    labOUT: TLabel;
    edtTRANS_USER: TzrComboBoxList;
    labIN: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cdsDetailBeforeEdit(DataSet: TDataSet);
    procedure edtTRANS_DATEPropertiesChange(Sender: TObject);
    procedure edtSHOP_IDPropertiesChange(Sender: TObject);
    procedure edtTRANS_USERPropertiesChange(Sender: TObject);
    procedure edtTRANS_MNYPropertiesChange(Sender: TObject);
    procedure edtREMARKPropertiesChange(Sender: TObject);
    procedure edtOUT_ACCOUNT_IDSaveValue(Sender: TObject);
    procedure edtIN_ACCOUNT_IDSaveValue(Sender: TObject);
  private
    Fcid: string;
    FisAudit: boolean;
    procedure Setcid(const Value: string);
    procedure SetisAudit(const Value: boolean);
    { Private declarations }
  protected
    procedure SetdbState(const Value: TDataSetState); override;
  public
    { Public declarations }
    AObj:TRecord_;
    locked:Boolean;
    procedure Open(id:string);
    procedure Append;
    procedure Edit(id:string);
    procedure SaveOrder;
    property cid:string read Fcid write Setcid;
    property isAudit:boolean read FisAudit write SetisAudit;
  end;

implementation
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal, ufrmBasic;
  
{$R *.dfm}

procedure TfrmTransOrder.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmTransOrder.Open(id: string);
var Params:TftParamList;
begin
  locked := True;
  try
    Params := TftParamList.Create(nil);
    Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('TRANS_ID').AsString := id;
    Factor.Open(cdsHeader,'TTransOrder',Params);
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,Self);
    if AObj.FieldbyName('GLIDE_NO').AsString<>'' then
      lblCaption.Caption := '单号:'+AObj.FieldbyName('GLIDE_NO').AsString;

    labOUT.Caption := '余额:'+AObj.FieldbyName('OUT_BALANCE').AsString;
    labIN.Caption := '余额:'+AObj.FieldbyName('IN_BALANCE').AsString;
    
//    edtIN_ACCOUNT_ID.KeyValue := AObj.FieldByName('IN_ACCOUNT_ID').AsString;
//    edtIN_ACCOUNT_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('ACC_ACCOUNT_INFO'),'ACCOUNT_ID','ACCT_NAME',AObj.FieldByName('IN_ACCOUNT_ID').AsString);
//    edtOUT_ACCOUNT_ID.KeyValue := AObj.FieldByName('OUT_ACCOUNT_ID').AsString;
//    edtOUT_ACCOUNT_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('ACC_ACCOUNT_INFO'),'ACCOUNT_ID','ACCT_NAME',AObj.FieldByName('OUT_ACCOUNT_ID').AsString);
//    edtSHOP_ID.KeyValue := AObj.FieldByName('SHOP_ID').AsString;
//    edtSHOP_ID.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',AObj.FieldByName('SHOP_ID').AsString);
//    edtTRANS_USER.KeyValue := AObj.FieldByName('TRANS_USER').AsString;
//    edtTRANS_USER.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',AObj.FieldByName('TRANS_USER').AsString);
    isAudit := (AObj.FieldByName('CHK_DATE').AsString <> '');
    dbState := dsBrowse;
    locked := False;
  finally
    Params.Free;
  end;
end;

procedure TfrmTransOrder.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  edtIN_ACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  edtOUT_ACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  edtTRANS_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
end;

procedure TfrmTransOrder.FormDestroy(Sender: TObject);
begin
  AObj.free;
  inherited;

end;

procedure TfrmTransOrder.Append;
var
  rs:TZQuery;
begin
  Open('');
  edtTRANS_DATE.Date := Date();
  edtTRANS_USER.KeyValue := Global.UserID;
  edtTRANS_USER.Text := Global.UserName;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  AObj.FieldByName('TRANS_ID').AsString := TSequence.NewId;
  AObj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  dbState := dsInsert;
end;

procedure TfrmTransOrder.Edit(id: string);
begin
  Open(id);
  dbState := dsEdit;
  
  btnOk.Enabled:=False;
end;

procedure TfrmTransOrder.SaveOrder;
begin
  if edtTRANS_DATE.EditValue = null then Raise Exception.Create('请选择存取款日期');
  if edtIN_ACCOUNT_ID.AsString = '' then Raise Exception.Create('请选择转入账号');
  if edtOUT_ACCOUNT_ID.AsString = '' then Raise Exception.Create('请选择转出账号');
  if edtIN_ACCOUNT_ID.AsString = edtOUT_ACCOUNT_ID.AsString then Raise Exception.Create('“转入账号”和“转出账号”不能相同');
  if edtTRANS_USER.AsString = '' then Raise Exception.Create('请选择负责人');
  if Trim(edtTRANS_MNY.Text) = '' then Raise Exception.Create('请输入金额');

  WriteToObject(AObj,Self);
  
  AObj.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD HH:NN:SS',Now);
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  cdsHeader.Edit;
  AObj.WriteToDataSet(cdsHeader);
  cdsHeader.Post;
  Factor.UpdateBatch(cdsHeader,'TTransOrder');
  dbState := dsBrowse;
  if Assigned(Onsave) then OnSave(AObj);
end;

procedure TfrmTransOrder.Setcid(const Value: string);
begin
  Fcid := Value;
end;

procedure TfrmTransOrder.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveOrder;
  ModalResult := MROK;
end;

procedure TfrmTransOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnOk.Visible:=(dbState<>dsBrowse);
  case Value of
  dsInsert:begin
     Caption := '存取款单--(新增)';
     Label14.Caption := '状态:新增';
  end;
  dsEdit:begin
     Caption := '存取款单--(修改)';
     Label14.Caption := '状态:修改';
  end;
  else
      begin
        Caption := '存取款单';
        Label14.Caption := '状态:查看';
      end;
  end;
end;

procedure TfrmTransOrder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  if btnOk.Enabled then
  begin
    try
      i:=MessageBox(Handle,'收款单有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
      if i=6 then
         begin
            SaveOrder;
            OnSave(AObj);
            ModalResult := MROK;
         end;
      if i=7 then ModalResult := MROK;
      if i=2 then abort;
    except
      CanClose := false;
      Raise;
    end;
  end;
end;

procedure TfrmTransOrder.cdsDetailBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmTransOrder.SetisAudit(const Value: boolean);
begin
  FisAudit := Value;
  Image1.Visible := Value;
  if dbState = dsBrowse then
     begin
       if Value then Label14.Caption := '状态:审核' else Label14.Caption := '状态:待审';
     end;
end;

procedure TfrmTransOrder.edtTRANS_DATEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  btnOk.Enabled := True;
end;

procedure TfrmTransOrder.edtSHOP_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  btnOk.Enabled := True;
end;

procedure TfrmTransOrder.edtTRANS_USERPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  btnOk.Enabled := True;
end;

procedure TfrmTransOrder.edtTRANS_MNYPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  btnOk.Enabled := True;
end;

procedure TfrmTransOrder.edtREMARKPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then Exit;
  btnOk.Enabled := True;
end;

procedure TfrmTransOrder.edtOUT_ACCOUNT_IDSaveValue(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select BALANCE from ACC_ACCOUNT_INFO where TENANT_ID='+inttostr(Global.TENANT_ID)+' and ACCOUNT_ID='''+edtOUT_ACCOUNT_ID.AsString+'''';
    Factor.Open(rs);
    labOUT.Caption := '余额:'+rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
  btnOk.Enabled := True;
end;

procedure TfrmTransOrder.edtIN_ACCOUNT_IDSaveValue(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select BALANCE from ACC_ACCOUNT_INFO where TENANT_ID='+inttostr(Global.TENANT_ID)+' and ACCOUNT_ID='''+edtIN_ACCOUNT_ID.AsString+'''';
    Factor.Open(rs);
    labIN.Caption := '余额:'+rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
  btnOk.Enabled := True;
end;

end.
