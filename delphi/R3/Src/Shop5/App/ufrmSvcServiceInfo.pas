unit ufrmSvcServiceInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, RzLabel, RzButton, cxMemo, cxControls, cxContainer, cxEdit,
  cxTextEdit, ZBase, cxRadioGroup, DB, cxDropDownEdit,
  cxCalendar, cxMaskEdit, cxButtonEdit, zrComboBoxList, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmSvcServiceInfo = class(TframeDialogForm)
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    lab_PROB_DESC: TRzLabel;
    lab_RECV_USER: TRzLabel;
    lab_CLIENT_ID: TRzLabel;
    lab_GODS_NAME: TRzLabel;
    edtGODS_NAME: TcxTextEdit;
    lab_CLIENT_CODE: TRzLabel;
    edtCLIENT_CODE: TcxTextEdit;
    edtPROB_DESC: TcxMemo;
    RzLabel2: TRzLabel;
    cdsTable: TZQuery;
    lab_SERIAL_NO: TRzLabel;
    lab_RECV_DATE: TRzLabel;
    edtRECV_DATE: TcxDateEdit;
    lab_RECV_CLASS: TRzLabel;
    edtRECV_CLASS: TcxComboBox;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    lab_SATI_DEGR: TRzLabel;
    lab_FEE_FLAG: TRzLabel;
    lab_SRVR_DATE: TRzLabel;
    lab_SRVR_CLASS: TRzLabel;
    lab_SRVR_USER: TRzLabel;
    lab_SRVR_DESC: TRzLabel;
    lab_FEE_MNY: TRzLabel;
    edtFEE_MNY: TcxTextEdit;
    edtCLIENT_ID: TzrComboBoxList;
    lab_LINKMAN: TRzLabel;
    edtLINKMAN: TcxTextEdit;
    lab_TELEPHONE: TRzLabel;
    edtTELEPHONE: TcxTextEdit;
    lab_ADDRESS: TRzLabel;
    edtADDRESS: TcxTextEdit;
    edtRECV_USER: TzrComboBoxList;
    edtSRVR_CLASS: TcxComboBox;
    edtSRVR_USER: TzrComboBoxList;
    edtSRVR_DATE: TcxDateEdit;
    edtSRVR_DESC: TcxMemo;
    edtSERIAL_NO: TcxTextEdit;
    edtFEE_FLAG: TRadioGroup;
    edtSATI_DEGR: TcxComboBox;
    RzBitBtn1: TRzBitBtn;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure edtFEE_FLAGClick(Sender: TObject);
  private
    FClientId: String;
    FGodsName: String;
    procedure SetClientId(const Value: String);
    procedure SetGodsName(const Value: String);
    procedure LoadParams;
    { Private declarations }
  public
    { Public declarations }
    SalesId,GodsId:string;
    Aobj:TRecord_;
    Saved:Boolean;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(code:string);
    procedure Append;
    procedure Edit(code:string);
    procedure Save;
    procedure Writeto(Aobj:TRecord_);
    constructor Create(AOwner: TComponent); override;
    function  IsEdit(Aobj:TRecord_;cdsTable:TZQuery):Boolean;//判断安装及维保档案是否有修改
    property ClientId:String read FClientId write SetClientId;
    property GodsName:String read FGodsName write SetGodsName;
  end;

implementation
uses uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,EncDec,uShopGlobal,
  StdConvs;//
{$R *.dfm}

procedure TfrmSvcServiceInfo.Append;
begin
  Open('');
  edtRECV_DATE.Date := Global.SysDate;
  edtSRVR_DATE.Date := Global.SysDate;
  edtFEE_FLAG.ItemIndex := 1;
  Aobj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Aobj.FieldByName('GODS_ID').AsString := GodsId;
  Aobj.FieldByName('SALES_ID').AsString := SalesId;
  Aobj.FieldByName('SRVR_ID').AsString := TSequence.NewId;
  dbState := dsInsert;

end;

procedure TfrmSvcServiceInfo.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSvcServiceInfo.Edit(code: string);
begin
  Open(code);
  dbState := dsEdit;

end;

procedure TfrmSvcServiceInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
  Freeform(Self);
end;

procedure TfrmSvcServiceInfo.Open(code: string);
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('SRVR_ID').asString := code;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TSvcServiceInfo',Params);
    Aobj.ReadFromDataSet(cdsTable);
    ReadFromObject(Aobj,Self);

    dbState := dsBrowse;

  finally
    Params.Free;
  end;
end;

procedure TfrmSvcServiceInfo.Save;
var temp,tmp,tmp1:TZQuery;
    j:integer;
begin
  if dbState=dsBrowse then exit;
  if edtCLIENT_ID.AsString = '' then
  begin
    edtCLIENT_ID.SetFocus;
    Raise Exception.Create('客户名称不能为空！');
  end;
  if edtRECV_CLASS.ItemIndex = -1 then
  begin
    edtRECV_CLASS.SetFocus;
    Raise Exception.Create('受理类型不能为空！');
  end;
  if edtSRVR_CLASS.ItemIndex = -1 then
  begin
    edtSRVR_CLASS.SetFocus;
    Raise Exception.Create('服务方式不能为空！');
  end; 

  WriteToObject(Aobj,self);
  Aobj.FieldByName('CREA_USER').AsString := Global.UserID;
  Aobj.FieldByName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD HH:NN:SS',Now());


  if not IsEdit(Aobj,cdsTable) then exit;

  if dbState=dsInsert then
    cdsTable.Append
  else if dbState=dsEdit then
    cdsTable.Edit;
  Aobj.WriteToDataSet(cdsTable);
  cdsTable.Post;
  Factor.UpdateBatch(cdsTable,'TSvcServiceInfo',nil);
  dbState:=dsBrowse;
  Saved:=True;
end;

procedure TfrmSvcServiceInfo.Btn_SaveClick(Sender: TObject);
var bl:boolean;
begin
  inherited;
  bl:=(dbState<>dsEdit);
  Save;
  If Saved and Assigned(OnSave) then OnSave(Aobj);
  If Saved and Assigned(OnSave) and bl then
  begin
    if MessageBox(Handle,'是否继续新增安装及维保档案?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
      Append
    else
      ModalResult := MROK;
  end
  else
    ModalResult := MROK;
end;

procedure TfrmSvcServiceInfo.FormShow(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmSvcServiceInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Btn_Save.Visible := (value<>dsBrowse);
  edtFEE_FLAG.Enabled := (Value <>dsBrowse);
  case dbState of
  dsInsert:Caption:='安装及维护档案--(新增)';
  dsEdit:Caption:='安装及维护档案--(修改)';
  else
    begin
      Caption:='安装及维护档案';
    end;
  end;
end;

function TfrmSvcServiceInfo.IsEdit(Aobj: TRecord_;
  cdsTable: TZQuery): Boolean;
var i:integer;
begin
  Result:=False;
  for i:=0 to cdsTable.FieldCount-1 do
  begin
    if AObj.Fields[i].AsString<>cdsTable.Fields[i].AsString then
    begin
      Result:=True;
      break;
    end;
  end;
end;

procedure TfrmSvcServiceInfo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  try
   if not(dbState = dsInsert) then
   begin
    WriteTo(AObj);
    if not IsEdit(Aobj,cdsTable) then Exit;
    i:=MessageBox(Handle,'安装及维护档案有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
    if i=6 then
       begin
         Save;
         if Saved and Assigned(OnSave) then OnSave(AObj);
       end;
    if i=2 then abort;
   end;
  except
    CanClose := false;
    Raise;
  end;
end;

procedure TfrmSvcServiceInfo.Writeto(Aobj: TRecord_);
begin
  WriteToObject(Aobj,self);
end;

procedure TfrmSvcServiceInfo.SetClientId(const Value: String);
var rs:TZQuery;
begin
  FClientId := Value;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CLIENT_ID,CLIENT_CODE,CLIENT_NAME,LINKMAN,TELEPHONE1,ADDRESS from VIW_CUSTOMER where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('CLIENT_ID').AsString := Value;
    Factor.Open(rs);
    if not rs.IsEmpty then
    begin
       edtCLIENT_CODE.Text := rs.FieldByName('CLIENT_CODE').AsString;
       edtLINKMAN.Text := rs.FieldByName('LINKMAN').AsString;
       edtTELEPHONE.Text := rs.FieldByName('TELEPHONE1').AsString;
       edtADDRESS.Text := rs.FieldByName('ADDRESS').AsString;
       edtCLIENT_ID.KeyValue := FClientId;
       edtCLIENT_ID.Text := rs.FieldByName('CLIENT_NAME').AsString;
    end
    else
    begin
       edtCLIENT_CODE.Text := rs.FieldByName('CLIENT_CODE').AsString;
       edtLINKMAN.Text := rs.FieldByName('LINKMAN').AsString;
       edtTELEPHONE.Text := rs.FieldByName('TELEPHONE1').AsString;
       edtADDRESS.Text := rs.FieldByName('ADDRESS').AsString;
    end;
  finally
    rs.Free;
  end;
end;

procedure TfrmSvcServiceInfo.SetGodsName(const Value: String);
begin
  FGodsName := Value;
  edtGODS_NAME.Text := Value;
end;

procedure TfrmSvcServiceInfo.edtCLIENT_IDSaveValue(Sender: TObject);
begin
  inherited;
  ClientId := edtCLIENT_ID.AsString;
end;

procedure TfrmSvcServiceInfo.edtFEE_FLAGClick(Sender: TObject);
begin
  inherited;
  if edtFEE_FLAG.ItemIndex = 0 then
  begin
     edtFEE_MNY.Text := '';
     edtFEE_MNY.Enabled := False;
  end
  else
  begin
     edtFEE_MNY.Text := '0';
     edtFEE_MNY.Enabled := True;
  end;
end;

procedure TfrmSvcServiceInfo.LoadParams;
var rs:TZQuery;
    Aobj_1:TRecord_;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=  'select CODE_ID,CODE_NAME from PUB_CODE_INFO where CODE_TYPE in (''19'',''20'',''21'') and TENANT_ID=0 order by SEQ_NO';
    Factor.Open(rs);
    rs.Filtered := False;
    rs.Filter := ' CODE_TYPE=''19'' ';
    rs.Filtered := True;
    ClearCbxPickList(edtRECV_CLASS);
    rs.First;
    while not rs.Eof do
    begin
      Aobj_1 := TRecord_.Create;
      Aobj_1.ReadFromDataSet(rs);
      edtRECV_CLASS.Properties.Items.AddObject(rs.FieldByName('CODE_NAME').AsString,Aobj_1);
      rs.Next;
    end;
    rs.Filtered := False;
    rs.Filter := ' CODE_TYPE=''20'' ';
    rs.Filtered := True;
    ClearCbxPickList(edtSRVR_CLASS);
    rs.First;
    while not rs.Eof do
    begin
      Aobj_1 := TRecord_.Create;
      Aobj_1.ReadFromDataSet(rs);
      edtSRVR_CLASS.Properties.Items.AddObject(rs.FieldByName('CODE_NAME').AsString,Aobj_1);
      rs.Next;
    end;
    rs.Filtered := False;
    rs.Filter := ' CODE_TYPE=''21'' ';
    rs.Filtered := True;
    ClearCbxPickList(edtSATI_DEGR);
    rs.First;
    while not rs.Eof do
    begin
      Aobj_1 := TRecord_.Create;
      Aobj_1.ReadFromDataSet(rs);
      edtSATI_DEGR.Properties.Items.AddObject(rs.FieldByName('CODE_NAME').AsString,Aobj_1);
      rs.Next;
    end;
  finally
    rs.Free;
  end;

end;

constructor TfrmSvcServiceInfo.Create(AOwner: TComponent);
begin
  inherited;
  Aobj := TRecord_.Create;
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  edtRECV_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtSRVR_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  LoadParams;
end;

end.
