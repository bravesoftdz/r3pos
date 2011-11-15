unit ufrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxControls, cxContainer, cxEdit, cxCheckBox, RzButton,
  jpeg, ExtCtrls, StdCtrls, cxSpinEdit, IniFiles, cxButtonEdit,
  zrComboBoxList, DB, cxCalendar, ZAbstractRODataset, ZDataset,
  Grids, DBGridEh, ZAbstractDataset, RzLabel, RzBckgnd;
type
  TLoginParam=Record
    UserID:String;
    ShopId:String;
    UserName:String;
    ShopName:string;
    Roles:string;
    AccountName:string;
    RemoteConnnect:boolean;
  end;

type
  TXsmCheckPassWord=function(uid,pwd:string):boolean;
  TfrmLogin = class(TfrmBasic)
    imgLogin: TImage;
    cxBtnOk: TRzBitBtn;
    cxbtnCancel: TRzBitBtn;
    cxcbSave: TcxCheckBox;
    lblName: TLabel;
    lblPass: TLabel;
    cxedtPasswrd: TcxTextEdit;
    Label3: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    edtOPER_DATE: TcxDateEdit;
    cxedtUsers: TcxTextEdit;
    RzLabel1: TRzLabel;
    Label1: TLabel;
    cbxTenant: TcxComboBox;
    RzBackground1: TRzBackground;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxBtnOkClick(Sender: TObject);
    procedure cxcbxLoginParamPropertiesChange(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RzLabel1Click(Sender: TObject);
    procedure cbxTenantPropertiesChange(Sender: TObject);
    procedure cxedtPasswrdKeyPress(Sender: TObject; var Key: Char);
    procedure cxbtnCancelClick(Sender: TObject);
  private
    FLoginParam:TLoginParam;
    FSysID: TGuid;
    lock:boolean;
    procedure SetSysID(const Value: TGuid);
    { Private declarations }
  public
    procedure LoadTenant;
    function Connect:boolean;
    class function doLogin(pSysID:TGuid;Locked:boolean;Var LoginParam:TLoginParam;var lDate:TDate):Boolean;overload;
    class function doLogin(Var LoginParam:TLoginParam):Boolean;overload;
    property SysID:TGuid read FSysID write SetSysID;
    { Public declarations }
  end;
var
  XsmCheckPassWord:TXsmCheckPassWord;
implementation
uses uCaFactory,ObjCommon,ZBase,uMsgBox,uLoginFactory,ufnUtil,ufrmLogo,uGlobal,EncDec,ufrmPswModify,uShopGlobal,uDsUtil,ufrmHostDialog,ufrmTenant;
{$R *.dfm}

{ TfrmLogin }

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
var F:TIniFile;
begin
  inherited;
  if cxcbSave.Checked and cxedtUsers.Enabled then
     begin
       F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.Ini');
       try
//         F.WriteString('Login','CompanyID',cxcbxCompany.AsString);
         F.WriteString('Login','Account',cxedtUsers.Text);
         F.WriteBool('Login','SaveLogin',cxcbSave.Checked);
//         F.WriteBool('Login','Locked',edtLocked.Checked);
       finally
          try
            F.Free;
          except
          end;
       end;
     end;

end;

procedure TfrmLogin.cxBtnOkClick(Sender: TObject);
procedure CheckSysDate;
var
  CurDate: TDate;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :='select max(END_DATE) as CREA_DATE from RCK_MONTH_CLOSE where TENANT_ID='+inttostr(Global.TENANT_ID);
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
    begin
      CurDate:=FnTime.fnStrtoDate(rs.Fields[0].AsString);
      if FormatDatetime('YYYYMMDD',edtOPER_DATE.Date) <FormatDatetime('YYYYMMDD',CurDate) then Raise Exception.Create('业务日期不能小于已关账日期...');
    end;
  finally
    rs.Free;
  end;
end;
var
  temp,rs:TZQuery;
  cId,cName:string;
   st: TSYSTEMTIME;
begin
  getlocaltime(st);
  if EnCodeDate(st.wYear,st.wMonth,st.wDay)<fnTime.fnStrtoDate('2010-01-01') then
     begin
       Raise Exception.Create('当前计算机时间不正确，请检查服务器时间及本地计算机时间...');
     end;
  CheckSysDate;
  if trim(cxedtUsers.Text)='' then
     begin
       cxedtUsers.SetFocus;
       Raise Exception.Create('请输入用户账号。');
     end;
  temp := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
     if not cxedtUsers.Enabled then
        temp.SQL.Text := 'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT from VIW_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.USER_ID='''+Global.UserID+''' and A.TENANT_ID='+inttostr(Global.TENANT_ID)
     else
        temp.SQL.Text := 'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT from VIW_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT in ('''+trim(cxedtUsers.Text)+''','''+lowercase(trim(cxedtUsers.Text))+''','''+uppercase(trim(cxedtUsers.Text))+''') and A.TENANT_ID='+inttostr(Global.TENANT_ID);
     Factor.Open(temp);
     if temp.IsEmpty then Raise Exception.Create(cxedtUsers.Text+'无效用户账号。');
     
//  Begin
     if not ((temp.FieldByName('ACCOUNT').AsString = 'admin') or (temp.FieldByName('ACCOUNT').AsString = 'system') or (temp.FieldByName('ROLE_IDS').AsString = 'xsm')) then
        begin
          rs.SQL.Text := 'select DIMI_DATE from CA_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT='+QuotedStr(temp.FieldByName('ACCOUNT').AsString)+
          ' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.DIMI_DATE<='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()))+' and A.DIMI_DATE is not null ';
          Factor.Open(rs);
          if not rs.IsEmpty then Raise Exception.Create(cxedtUsers.Text+'用户账号已经离职。');
        end;
//  End; 2011-09-03 17 时 ： 加入对已经离职用户的判断

     if cxedtUsers.Text='system' then
        begin
          if lowerCase(cxedtPasswrd.Text)<>('rspcn.com@'+formatdatetime('YYMMDD',date())+inttostr(strtoint(formatDatetime('DD',Date())) mod 7 )) then
             begin
                cxedtPasswrd.SetFocus;
                Raise Exception.Create('输入的密码无效,请重新输入。');
             end;
        end
     else
        begin
          if UpperCase(cxedtPasswrd.Text) <> UpperCase(DecStr(temp.FieldbyName('PASS_WRD').AsString,ENC_KEY)) then
             begin
                cxedtPasswrd.SetFocus;
                if (temp.FieldbyName('ROLE_IDS').AsString='xsm') and Assigned(XsmCheckPassWord) then
                   begin
                     if CaFactory.Audited then
                        begin
                          if XsmCheckPassWord(temp.FieldbyName('ACCOUNT').asString,cxedtPasswrd.Text) then
                             begin
                               Factor.ExecSQL('update CA_SHOP_INFO set XSM_PSWD='''+EncStr(cxedtPasswrd.Text,ENC_KEY)+''',COMM='+GetCommStr(Factor.idbType)+',TIME_STAMP='+GetTimeStamp(Factor.idbType)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+temp.FieldbyName('SHOP_ID').asString+'''');
                             end
                          else
                             Exit;
                        end
                     else
                        Raise Exception.Create('输入的密码无效,请使用在线模式重试。');
                   end
                else
                   begin
                     Raise Exception.Create('输入的密码无效,请重新输入。');
                   end;
             end;
        end;
     FLoginParam.UserID := temp.FieldbyName('USER_ID').asString;
     FLoginParam.ShopId := temp.FieldbyName('SHOP_ID').asString;
     FLoginParam.UserName  := temp.FieldbyName('USER_NAME').asString;
     if FLoginParam.UserName='' then FLoginParam.UserName := cxedtUsers.Text;
     FLoginParam.ShopName := temp.FieldbyName('SHOP_NAME').asString;
     FLoginParam.Roles := temp.FieldbyName('ROLE_IDS').AsString;
     Factor.GqqLogin(FLoginParam.UserID,FLoginParam.ShopName+'('+FLoginParam.UserName+')');
     if trim(cxedtPasswrd.Text)='1234' then TfrmPswModify.ShowExecute(FLoginParam.UserID,cxedtUsers.Text);
     ModalResult := MROK;
  finally
     temp.Free;
  end;
  
end;

class function TfrmLogin.doLogin(pSysID:TGuid;Locked:boolean;Var LoginParam:TLoginParam;var lDate:TDate): Boolean;
var
    sn,cId,cName:String;
    f:TIniFile;
    offline:boolean;
    _ok:boolean;
    rs:TZQuery;
begin
result := false;
LoginFactory.Logout;
try
  with TfrmLogin.Create(Application) do
    begin
      try
        //Label6.Visible := _ok;
        FSysID := pSysID;
        if Locked then cxBtnOk.Caption := '解锁';
        if Locked then Caption := '屏幕解锁';
        if not Locked then
        begin
           if not Connect then Exit;
        end;
        LoadTenant;
        cbxTenant.Enabled := not Locked and not CaFactory.Auto;
        cxbtnCancel.Enabled := not Locked;
        cxedtUsers.Enabled := not Locked;
        edtOPER_DATE.Enabled := not Locked;
        cxcbSave.Visible := not Locked;
        RzLabel1.Visible := not Locked;
        Label6.Visible := not Locked and not CaFactory.Auto;
        if Locked then
           begin
             cxedtUsers.Text := Global.UserID;
             cxedtUsers.Text := Global.UserName;
           end;
        case ShowModal of
        MROK:
          begin
            LoginParam := FLoginParam;
            lDate := edtOPER_DATE.Date;
            Result := True;
          end;
        mrRetry:
          begin
            Global.TENANT_ID := 0;
            Result := False;
          end;
        else
           Result := False;
        end;
      finally
        Free;
      end;
    end;
finally
   if result then LoginFactory.Login(LoginParam.UserID,LoginParam.ShopId);
end;
end;

procedure TfrmLogin.SetSysID(const Value: TGuid);
begin
  FSysID := Value;

end;

procedure TfrmLogin.cxcbxLoginParamPropertiesChange(Sender: TObject);
begin
  if not Visible or lock then Exit;
  Connect;

end;

procedure TfrmLogin.Label3Click(Sender: TObject);
begin
  inherited;
//  if cxcbxCompany.AsString = '' then
//     Raise Exception.Create('请选择你所属公司。');
  if cxedtUsers.Text = '' then
     Raise Exception.Create('请输入用户名。');
  if cxedtUsers.Text = 'system' then
     Raise Exception.Create('超级管理员密码不能修改。');
  TfrmPswModify.ShowExecute(cxedtUsers.Text,cxedtUsers.Text);

end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  inherited;
  lock := false;
  edtOPER_DATE.Date := Date();
  if FileExists(ExtractFilePath(ParamStr(0))+'login.jpg') then
     imgLogin.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'login.jpg');
end;

function WinExecAndWait32V2(FileName: string; Visibility: integer): DWORD;
  procedure WaitFor(processHandle: THandle);
  var
    msg: TMsg;
    ret: DWORD;
  begin
    repeat
      ret := MsgWaitForMultipleObjects(
        1, { 1 handle to wait on }
        processHandle, { the handle }
        False, { wake on any event }
        INFINITE, { wait without timeout }
        QS_PAINT or { wake on paint messages }
        QS_SENDMESSAGE { or messages from other threads }
        );
      if ret = WAIT_FAILED then
        Exit; { can do little here }
      if ret = (WAIT_OBJECT_0 + 1) then
      begin
        { Woke on a message, process paint messages only. Calling
          PeekMessage gets messages send from other threads processed. }
        while PeekMessage(msg, 0, WM_PAINT, WM_PAINT, PM_REMOVE) do
          DispatchMessage(msg);
      end;
    until ret = WAIT_OBJECT_0;
  end; { Waitfor }
var { V1 by Pat Ritchey, V2 by P.Below }
  zAppName: array[0..512] of char;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin { WinExecAndWait32V2 }
  StrPCopy(zAppName, FileName);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName, { pointer to command line string }
    nil, { pointer to process security attributes }
    nil, { pointer to thread security attributes }
    false, { handle inheritance flag }
    CREATE_NEW_CONSOLE or { creation flags }
    NORMAL_PRIORITY_CLASS,
    nil, { pointer to new environment block }
    nil, { pointer to current directory name }
    StartupInfo, { pointer to STARTUPINFO }
    ProcessInfo) { pointer to PROCESS_INF } then
    Result := DWORD(-1) { failed, GetLastError has error code }
  else
  begin
    Waitfor(ProcessInfo.hProcess);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end; { Else }
end;
function TfrmLogin.Connect:boolean;
var
  F:TIniFile;
  r:boolean;
begin
  result := true;
  r := true;
  edtOPER_DATE.Date := Date();
  if r then
     begin
        F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.Ini');
        Lock := true;
        try
          cxcbSave.Checked := F.ReadBool('Login','SaveLogin',True);
          //edtLocked.Checked := F.ReadBool('Login','Locked',false);
          if cxcbSave.Checked then
             begin
               if CaFactory.Auto then
                  cxedtUsers.Text := F.ReadString('Login','Account',xsm_username)
               else
                  cxedtUsers.Text := F.ReadString('Login','Account','');
             end;
        finally
          Lock := false;
          try
            F.Free;
          except
          end;
        end;
     end;

end;

procedure TfrmLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  if ModalResult <> MROK then
     CanClose := cxbtnCancel.Enabled;
end;

class function TfrmLogin.doLogin(var LoginParam: TLoginParam): Boolean;
var
    sn,cId,cName:String;
    f:TIniFile;
    offline:boolean;
    _ok:boolean;
begin
  result := false;
  with TfrmLogin.Create(Application) do
    begin
      try
        LoadTenant;
        Label6.Visible := _ok;
        cxBtnOk.Caption := '确认(&O)';
        Caption := '用户认证';
        cxbtnCancel.Caption := '取消(&C)';
        edtOPER_DATE.Enabled := false;
        edtOPER_DATE.Date := Global.SysDate;
        cxcbSave.Visible := false;
        cxcbSave.Checked := false;
        if ShowModal=MROK then
          begin
            LoginParam := FLoginParam;
            Result := True;
          end
        else
           Result := False;
      finally
        Free;
      end;
    end;
end;

procedure TfrmLogin.RzLabel1Click(Sender: TObject);
begin
  inherited;
  case TfrmHostDialog.HostDialog(self) of
  MROK:ShowMsgBox('设置连接主机成功，请退出软件重新登录后生效.','友情提示..',MB_OK+MB_ICONINFORMATION);
  mrRetry:self.ModalResult := mrRetry;
  end;
end;

procedure TfrmLogin.LoadTenant;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :='select TENANT_ID,TENANT_NAME from CA_TENANT where TENANT_ID in (select VALUE from SYS_DEFINE where DEFINE=''TENANT_ID'')';
    Global.LocalFactory.Open(rs);
    TdsItems.AddDataSetToItems(rs,cbxTenant.Properties.Items,'TENANT_NAME');
    cbxTenant.ItemIndex := TdsItems.FindItems(cbxTenant.Properties.Items,'TENANT_ID',inttostr(Global.TENANT_ID));
  finally
    rs.Free;
  end;
end;

procedure TfrmLogin.cbxTenantPropertiesChange(Sender: TObject);
begin
  inherited;
  if cbxTenant.ItemIndex <0 then Exit;
  if TRecord_(cbxTenant.Properties.Items.Objects[cbxTenant.ItemIndex]).FieldByName('TENANT_ID').AsInteger<>Global.TENANT_ID then
     begin
       Global.LocalFactory.ExecSQL('update SYS_DEFINE set VALUE='''+TRecord_(cbxTenant.Properties.Items.Objects[cbxTenant.ItemIndex]).FieldByName('TENANT_ID').AsString+''' where TENANT_ID=0 and DEFINE=''TENANT_ID''');
       self.ModalResult := mrRetry;
     end;
end;

procedure TfrmLogin.cxedtPasswrdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then cxBtnOk.OnClick(cxBtnOk);
end;

procedure TfrmLogin.cxbtnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

initialization
  XsmCheckPassWord := nil;
finalization
  XsmCheckPassWord := nil;
end.
