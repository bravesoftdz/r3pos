unit ufrmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxControls, cxContainer, cxEdit, cxCheckBox, RzButton,
  jpeg, ExtCtrls, StdCtrls, cxSpinEdit, IniFiles, cxButtonEdit,
  zrComboBoxList, DB, cxCalendar, ZAbstractRODataset, ZDataset,
  Grids, DBGridEh, ZAbstractDataset;
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
    lblTenantName: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxBtnOkClick(Sender: TObject);
    procedure cxcbxLoginParamPropertiesChange(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FLoginParam:TLoginParam;
    FSysID: TGuid;
    lock:boolean;
    procedure SetSysID(const Value: TGuid);
    { Private declarations }
  public
    function Connect:boolean;
    class function doLogin(pSysID:TGuid;Locked:boolean;Var LoginParam:TLoginParam;var lDate:TDate):Boolean;overload;
    class function doLogin(Var LoginParam:TLoginParam):Boolean;overload;
    property SysID:TGuid read FSysID write SetSysID;
    { Public declarations }
  end;

implementation
uses ZBase,ufnUtil,ufrmLogo,uGlobal,EncDec,ufrmPswModify,uShopGlobal,uDsUtil;
{$R *.dfm}

{ TfrmLogin }

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
var F:TIniFile;
begin
  inherited;
  if cxcbSave.Checked then
     begin
       F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.Ini');
       try
//         F.WriteString('Login','CompanyID',cxcbxCompany.AsString);
         F.WriteString('Login','Account',cxedtUsers.Text);
         F.WriteBool('Login','SaveLogin',cxcbSave.Checked);
//         F.WriteBool('Login','Locked',edtLocked.Checked);
       finally
         F.Free;
       end;
     end;

end;

procedure TfrmLogin.cxBtnOkClick(Sender: TObject);
var
  temp:TZQuery;
  cId,cName:string;
   st: TSYSTEMTIME;
begin
  getlocaltime(st);
  if EnCodeDate(st.wYear,st.wMonth,st.wDay)<fnTime.fnStrtoDate('2010-01-01') then
     begin
       Raise Exception.Create('当前计算机时间不正确，请检查服务器时间及本地计算机时间...');
     end;
  if edtOPER_DATE.Date < Date() then Raise Exception.Create('业务日期不能小于今天...');
  if trim(cxedtUsers.Text)='' then
     begin
       cxedtUsers.SetFocus;
       Raise Exception.Create('请输入用户账号。');
     end;
  temp := TZQuery.Create(nil);
  try
     if not cxedtUsers.Enabled then
        temp.SQL.Text := 'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME from VIW_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.USER_ID='''+Global.UserID+''' and A.TENANT_ID='+inttostr(Global.TENANT_ID)
     else
        temp.SQL.Text := 'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME from VIW_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT='''+trim(cxedtUsers.Text)+''' and A.TENANT_ID='+inttostr(Global.TENANT_ID);
     Factor.Open(temp);
     if temp.IsEmpty then Raise Exception.Create(cxedtUsers.Text+'无效用户账号。');
     if UpperCase(cxedtPasswrd.Text) <> UpperCase(DecStr(temp.FieldbyName('PASS_WRD').AsString,ENC_KEY)) then
        begin
          cxedtPasswrd.SetFocus;
          Raise Exception.Create('输入的密码无效,请重新输入。');
        end;
     FLoginParam.UserID := temp.FieldbyName('USER_ID').asString;
     FLoginParam.ShopId := temp.FieldbyName('SHOP_ID').asString;
     FLoginParam.UserName  := temp.FieldbyName('USER_NAME').asString;
     FLoginParam.ShopName := temp.FieldbyName('SHOP_NAME').asString;
     FLoginParam.Roles := temp.FieldbyName('ROLE_IDS').AsString;
     Factor.GqqLogin(FLoginParam.UserID,FLoginParam.ShopName+'('+FLoginParam.UserName+')');
     ModalResult := MROK;
     if trim(cxedtPasswrd.Text)='1234' then TfrmPswModify.ShowExecute(FLoginParam.UserID,cxedtUsers.Text);
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
    s,chk:string;
begin
  result := false;
  s := ParamStr(1);
  if (s<>'') and (copy(s,1,3)='-mm') then
     begin
       rs := Global.GetZQueryFromName('CA_USERS');
       chk := copy(ParamStr(2),6,255);
       if rs.Locate('MM',lowercase(copy(s,5,255)),[]) or rs.Locate('MM',uppercase(copy(s,5,255)),[]) then
          begin
            lDate := Date();
            LoginParam.UserID := rs.FieldbyName('USER_ID').AsString;
            LoginParam.ShopId := rs.FieldbyName('SHOP_ID').AsString;
            LoginParam.Roles  := rs.FieldbyName('ROLE_IDS').AsString;
            LoginParam.ShopName := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_SHOP_INFO'),'SHOP_ID','SHOP_NAME',rs.FieldbyName('SHOP_ID').AsString);
            LoginParam.UserName := rs.FieldbyName('USER_NAME').AsString;
            if chk<>md5Encode(copy(s,5,255)) then
               begin
                 MessageBox(Application.Handle,'登录校验码不正确，无法完成自动登录,请输入用户密码...','友情提示...',MB_OK+MB_ICONINFORMATION);
               end
            else
               begin
                 result := true;
                 Exit;
               end;
          end;
     end;
  with TfrmLogin.Create(Application) do
    begin
      try
        Label6.Visible := _ok;
        FSysID := pSysID;
        if Locked then cxBtnOk.Caption := '解锁';
        if Locked then Caption := '屏幕解锁';
        if not Locked then
        begin
           if not Connect then Exit;
        end;
        cxbtnCancel.Enabled := not Locked;
        cxedtUsers.Enabled := not Locked;
        edtOPER_DATE.Enabled := not Locked;
        cxcbSave.Visible := not Locked;
        if Locked then
           begin
             cxedtUsers.Text := Global.UserID;
             cxedtUsers.Text := Global.UserName;
           end;
        if ShowModal=MROK then
          begin
            LoginParam := FLoginParam;
            lDate := edtOPER_DATE.Date;
            Result := True;
          end
        else
           Result := False;
      finally
        Free;
      end;
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

  TfrmPswModify.ShowExecute(cxedtUsers.Text,cxedtUsers.Text);

end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  inherited;
  lock := false;
  edtOPER_DATE.Date := Date();
  if FileExists(ExtractFilePath(ParamStr(0))+'login.jpg') then
     imgLogin.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'login.jpg');
  lblTenantName.Caption := '当前企业:'+Global.TENANT_NAME;
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
               cxedtUsers.Text := F.ReadString('Login','Account','');
             end;
        finally
          Lock := false;
          F.Free;
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

end.
