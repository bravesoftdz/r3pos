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
    edtSRVR_USER: TzrComboBoxList;
    edtSRVR_DATE: TcxDateEdit;
    edtSRVR_DESC: TcxMemo;
    edtSERIAL_NO: TcxTextEdit;
    edtFEE_FLAG: TRadioGroup;
    BtnUserInfo: TRzBitBtn;
    RzLabel1: TRzLabel;
    RzLabel3: TRzLabel;
    edtRECV_CLASS: TzrComboBoxList;
    edtSRVR_CLASS: TzrComboBoxList;
    edtSATI_DEGR: TzrComboBoxList;
    cdsRecvClass: TZQuery;
    cdsSrvrClass: TZQuery;
    cdsSatiDegr: TZQuery;
    procedure Btn_CloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure edtFEE_FLAGClick(Sender: TObject);
    procedure edtRECV_CLASSAddClick(Sender: TObject);
    procedure edtSRVR_CLASSAddClick(Sender: TObject);
    procedure edtSATI_DEGRAddClick(Sender: TObject);
    procedure BtnUserInfoClick(Sender: TObject);
  private
    FClientId: String;
    FGodsName: String;
    FAddress: String;
    FLinkMan: String;
    FTelephone: String;
    procedure SetClientId(const Value: String);
    procedure SetGodsName(const Value: String);
    procedure LoadParams;
    procedure SetAddress(const Value: String);
    procedure SetLinkMan(const Value: String);
    procedure SetTelephone(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    SalesId,GodsId:string;
    Aobj:TRecord_;
    Saved:Boolean;
    procedure GetInfo(Aobj_:TRecord_);
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
    property LinkMan:String read FLinkMan write SetLinkMan;
    property Telephone:String read FTelephone write SetTelephone;
    property Address:String read FAddress write SetAddress;
  end;

implementation
uses uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,uShopGlobal,ufrmCodeInfo,ufrmFilterUser,
  StdConvs,ObjCommon;//
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
    if Aobj.FieldByName('FEE_FLAG').AsString = '1' then edtFEE_FLAG.ItemIndex := 1 else edtFEE_FLAG.ItemIndex := 0;
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
    if edtCLIENT_ID.CanFocus then edtCLIENT_ID.SetFocus;
    Raise Exception.Create('客户名称不能为空！');
  end;
  if Trim(edtGODS_NAME.Text) = '' then
  begin
     if edtGODS_NAME.CanFocus then edtGODS_NAME.SetFocus;
     Raise Exception.Create('商品名称不能为空！');
  end;
  if Trim(edtSERIAL_NO.Text) = '' then
  begin
     if edtSERIAL_NO.CanFocus then edtSERIAL_NO.SetFocus;
     Raise Exception.Create('序列号不能为空！');
  end;
  if edtRECV_CLASS.AsString = '' then
  begin
    if edtRECV_CLASS.CanFocus then edtRECV_CLASS.SetFocus;
    Raise Exception.Create('受理类型不能为空！');
  end; 
  if edtSRVR_CLASS.AsString = '' then
  begin
    if edtSRVR_CLASS.CanFocus then edtSRVR_CLASS.SetFocus;
    Raise Exception.Create('服务方式不能为空！');
  end; 

  WriteToObject(Aobj,self);
  if edtFEE_FLAG.ItemIndex = 0 then
     Aobj.FieldByName('FEE_FLAG').AsString := '0'
  else
     Aobj.FieldByName('FEE_FLAG').AsString := '1';
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
  edtSRVR_CLASS.KeyValue := edtSRVR_CLASS.DataSet.FieldByName('CODE_ID').AsString;
  edtSRVR_CLASS.Text := edtSRVR_CLASS.DataSet.FieldByName('CODE_NAME').AsString;
  
  edtRECV_CLASS.KeyValue := edtRECV_CLASS.DataSet.FieldByName('CODE_ID').AsString;
  edtRECV_CLASS.Text := edtRECV_CLASS.DataSet.FieldByName('CODE_NAME').AsString;

  edtSATI_DEGR.KeyValue := edtSATI_DEGR.DataSet.FieldByName('CODE_ID').AsString;
  edtSATI_DEGR.Text := edtSATI_DEGR.DataSet.FieldByName('CODE_NAME').AsString;
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
  rs := ShopGlobal.GetZQueryFromName('PUB_CUSTOMER');
  if rs.Locate('CLIENT_ID',Value,[]) then
  begin
     edtCLIENT_CODE.Text := rs.FieldByName('CLIENT_CODE').AsString;
     if Trim(edtLINKMAN.Text) = '' then
        edtLINKMAN.Text := rs.FieldByName('LINKMAN').AsString;
     if Trim(edtTELEPHONE.Text) = '' then
        edtTELEPHONE.Text := rs.FieldByName('TELEPHONE2').AsString;
     if Trim(edtADDRESS.Text) = '' then
        edtADDRESS.Text := rs.FieldByName('ADDRESS').AsString;
     edtCLIENT_ID.KeyValue := FClientId;
     edtCLIENT_ID.Text := rs.FieldByName('CLIENT_NAME').AsString;
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
     //edtFEE_MNY.Text := '0';
     edtFEE_MNY.Enabled := True;
  end;
end;

procedure TfrmSvcServiceInfo.LoadParams;
var str:String;
begin
  Factor.Open(cdsRecvClass);
  if cdsRecvClass.IsEmpty then
  begin
     //数据集为空,对"受理类型"进行初始化
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''20'',''00'',5497000,1,'''+NewId(Global.SHOP_ID)+''',''安装'',''AZ'') ';
     Factor.ExecSQL(str);
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''20'',''00'',5497000,2,'''+NewId(Global.SHOP_ID)+''',''维修'',''WX'') ';
     Factor.ExecSQL(str);
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''20'',''00'',5497000,3,'''+NewId(Global.SHOP_ID)+''',''保养'',''BY'') ';
     Factor.ExecSQL(str);
     //初始化后,重新打开数据集
     Factor.Open(cdsRecvClass);
  end;

  Factor.Open(cdsSrvrClass);
  if cdsSrvrClass.IsEmpty then
  begin
     //数据集为空,对"服务方式"进行初始化
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''21'',''00'',5497000,1,'''+NewId(Global.SHOP_ID)+''',''热线服务'',''RXFF'') ';
     Factor.ExecSQL(str);
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''21'',''00'',5497000,2,'''+NewId(Global.SHOP_ID)+''',''接待服务'',''JDFF'') ';
     Factor.ExecSQL(str);
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''21'',''00'',5497000,3,'''+NewId(Global.SHOP_ID)+''',''上门服务'',''SMFF'') ';
     Factor.ExecSQL(str);
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''21'',''00'',5497000,4,'''+NewId(Global.SHOP_ID)+''',''其它'',''QT'') ';
     Factor.ExecSQL(str);
     //初始化后,重新打开数据集
     Factor.Open(cdsSrvrClass);
  end;

  Factor.Open(cdsSatiDegr);
  if cdsSatiDegr.IsEmpty then
  begin
     //数据集为空,对"服务质量"进行初始化
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''22'',''00'',5497000,1,'''+NewId(Global.SHOP_ID)+''',''满意'',''MY'') ';
     Factor.ExecSQL(str);
     str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_TYPE,COMM,TIME_STAMP,SEQ_NO,CODE_ID,CODE_NAME,CODE_SPELL) values(0,''22'',''00'',5497000,2,'''+NewId(Global.SHOP_ID)+''',''不满意'',''BMY'') ';
     Factor.ExecSQL(str);
     //初始化后,重新打开数据集
     Factor.Open(cdsSatiDegr);
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

procedure TfrmSvcServiceInfo.edtRECV_CLASSAddClick(Sender: TObject);
var Aobj_1:TRecord_;
begin
  inherited;
  //if not ShopGlobal.GetChkRight('31100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  Try
    Aobj_1 := TRecord_.Create;
    if TfrmCodeInfo.AddDialog(Self,Aobj_1,20) then
      begin
        edtRECV_CLASS.KeyValue := Aobj_1.FieldbyName('CODE_ID').AsString;
        edtRECV_CLASS.Text := Aobj_1.FieldbyName('CODE_NAME').AsString;
      end;
  finally
    Aobj_1.Free;
  end;
end;

procedure TfrmSvcServiceInfo.edtSRVR_CLASSAddClick(Sender: TObject);
var Aobj_2:TRecord_;
begin
  inherited;
  //if not ShopGlobal.GetChkRight('31100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  Try
    Aobj_2 := TRecord_.Create;
    if TfrmCodeInfo.AddDialog(Self,Aobj_2,21) then
      begin
        edtSRVR_CLASS.KeyValue := Aobj_2.FieldbyName('CODE_ID').AsString;
        edtSRVR_CLASS.Text := Aobj_2.FieldbyName('CODE_NAME').AsString;
      end;
  finally
    Aobj_2.Free;
  end;
end;

procedure TfrmSvcServiceInfo.edtSATI_DEGRAddClick(Sender: TObject);
var Aobj_3:TRecord_;
begin
  inherited;
  //if not ShopGlobal.GetChkRight('31100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  Try
    Aobj_3 := TRecord_.Create;
    if TfrmCodeInfo.AddDialog(Self,Aobj_3,22) then
      begin
        edtSATI_DEGR.KeyValue := Aobj_3.FieldbyName('CODE_ID').AsString;
        edtSATI_DEGR.Text := Aobj_3.FieldbyName('CODE_NAME').AsString;
      end;
  finally
    Aobj_3.Free;
  end;
end;

procedure TfrmSvcServiceInfo.BtnUserInfoClick(Sender: TObject);
begin
  inherited;
  with TfrmFilterUser.Create(Self) do
  begin
    try
      OnGetUserInfo := GetInfo;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmSvcServiceInfo.GetInfo(Aobj_: TRecord_);
begin
  if Aobj_.FieldByName('YQDZ_USERID_OLD').AsString = '' then Exit;
  edtLINKMAN.Text := Aobj_.FieldByName('YQDZ_HZ_MC').AsString;
  edtTELEPHONE.Text := Aobj_.FieldByName('YQDZ_LXDH').AsString;
  edtADDRESS.Text := Aobj_.FieldByName('YQDZ_SM').AsString;
  edtCLIENT_CODE.Text := Aobj_.FieldByName('YQDZ_USERID_OLD').AsString;
end;

procedure TfrmSvcServiceInfo.SetAddress(const Value: String);
begin
  FAddress := Value;
  edtADDRESS.Text := Value;
end;

procedure TfrmSvcServiceInfo.SetLinkMan(const Value: String);
begin
  FLinkMan := Value;
  edtLINKMAN.Text := Value;
end;

procedure TfrmSvcServiceInfo.SetTelephone(const Value: String);
begin
  FTelephone := Value;
  edtTELEPHONE.Text := Value;
end;

end.
