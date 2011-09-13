unit ufrmMMMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMain, ExtCtrls, Menus, ActnList, ComCtrls, uMMUtil, uMMServer ,ShellApi,
  ZBase, RzTray, StdCtrls, Mask, RzEdit, RzBmpBtn, RzLabel, jpeg, RzPanel;

type
  TfrmMMMain = class(TfrmMain)
    RzTrayIcon1: TRzTrayIcon;
    RzPanel1: TRzPanel;
    Panel4: TPanel;
    Image5: TImage;
    Image6: TImage;
    Panel2: TPanel;
    Image4: TImage;
    Image2: TImage;
    lblDayInfo: TRzLabel;
    Image9: TImage;
    lblNetStatus: TRzLabel;
    lblUserInfo: TLabel;
    imgOffline: TImage;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzPanel9: TRzPanel;
    Panel9: TPanel;
    rzTool: TPanel;
    Image21: TImage;
    Panel12: TPanel;
    Image14: TImage;
    Panel3: TPanel;
    rzToolButton: TPanel;
    Image12: TImage;
    RzPanel3: TRzPanel;
    Image10: TImage;
    tbDesktop: TRzBmpButton;
    Panel1: TPanel;
    RzPanel4: TRzPanel;
    Image1: TImage;
    Panel10: TPanel;
    rzLeft: TRzPanel;
    RzPanel2: TRzPanel;
    split: TImage;
    Panel11: TPanel;
    RzPanel5: TRzPanel;
    page_01: TRzBmpButton;
    page_02: TRzBmpButton;
    page_03: TRzBmpButton;
    page_04: TRzBmpButton;
    page_11: TRzBmpButton;
    page_12: TRzBmpButton;
    page_13: TRzBmpButton;
    page_14: TRzBmpButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RzTrayIcon1RestoreApp(Sender: TObject);
    procedure RzTrayIcon1MinimizeApp(Sender: TObject);
    procedure RzTrayIcon1LButtonDown(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
  private
    { Private declarations }
    procedure wm_Login(var Message: TMessage); message MM_LOGIN;
    procedure wm_Sign(var Message: TMessage); message MM_SIGN;
    procedure wm_SessionFail(var Message: TMessage); message MM_SESSION_FAIL;
  public
    { Public declarations }
    procedure ConnectToSQLite;
    function CreateMMLogin: TftParamList;
    procedure Init;
    function Login: boolean;
    procedure OpenMc(pid: string; mid:integer=0);
    procedure ShowMMList;
    procedure HideMMList;
  end;

var
  frmMMMain: TfrmMMMain;

implementation
uses
  ufrmMMLogin, uCaFactory, ummGlobal, uGlobal, ufrmLogo, uSyncFactory, ufrmMMList;

{$R *.dfm}

function TfrmMMMain.Login: boolean;
begin
  with TfrmMMLogin.Create(self) do
    begin
      try
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmMMMain.FormDestroy(Sender: TObject);
begin
  freeandnil(frmLogo);
  inherited;

end;

procedure TfrmMMMain.FormCreate(Sender: TObject);
begin
  inherited;
  frmLogo := TfrmLogo.create(self);
  ConnectToSQLite;

end;

procedure TfrmMMMain.ConnectToSQLite;
begin
  Global.MoveToLocal;
  Global.Connect;
end;
procedure TfrmMMMain.wm_Login(var Message: TMessage);
begin
  if Login then
     begin
        Init;
     end
  else
     Application.Terminate;
end;
procedure TfrmMMMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  CanClose := (MessageBox(Handle,'是否退出盟盟？','友情提示...',MB_YESNO+MB_ICONQUESTION)=6);

end;

procedure TfrmMMMain.Init;
begin
  try
   try
     if mmGlobal.Logined then mmGlobal.getAllfriends;
   except
     on E:Exception do
        MessageBox(Handle,Pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
   end;
   frmMMList.LoadFriends;
   if CaFactory.Audited and not mmGlobal.ONLVersion then
      begin
        if not Global.RemoteFactory.Connected and not mmGlobal.NetVersion then
           begin
             frmLogo.Label1.Caption := '正在连接远程服务...';
             frmLogo.Label1.Update;
             Global.MoveToRemate;
             try
               try
                 Global.Connect;
               except
                 MessageBox(Handle,'连接远程服务器失败，系统无法同步到最新资料..','友情提示...',MB_OK+MB_ICONWARNING);
               end;
             finally
               Global.MoveToLocal;
             end;
           end;
        if CaFactory.Audited and CaFactory.CheckInitSync then CaFactory.SyncAll(1);
        if Global.RemoteFactory.Connected and SyncFactory.CheckDBVersion then
           begin
             if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
           end;
      end
   else
      begin
        if CaFactory.Audited and CaFactory.CheckInitSync then CaFactory.SyncAll(1);
        if CaFactory.Audited and Global.RemoteFactory.Connected then //管理什么版本，有连接到服务器时，必须先同步数据
           begin
             if mmGlobal.ONLVersion then //在线版只需同步注册数据
                begin
                  if Global.RemoteFactory.ConnString<>Global.LocalFactory.ConnString then //调试模式时，不同步
                  begin
                    SyncFactory.SyncTimeStamp := CaFactory.TimeStamp;
                    SyncFactory.SyncComm := SyncFactory.CheckRemeteData;
                    SyncFactory.SyncSingleTable('SYS_DEFINE','TENANT_ID;DEFINE','TSyncSingleTable',0);
                    SyncFactory.SyncSingleTable('CA_SHOP_INFO','TENANT_ID;SHOP_ID','TSyncSingleTable',0);
                    SyncFactory.SyncSingleTable('ACC_ACCOUNT_INFO','TENANT_ID;ACCOUNT_ID','TSyncAccountInfo',0);
                  end;
                end
             else
                begin
                  if SyncFactory.CheckInitSync then SyncFactory.SyncBasic(true);
                end;
           end;
     end;

  finally
    ShowMMList;
  end;
end;

procedure TfrmMMMain.OpenMc(pid: string;mid:integer=0);
var
  Params:TftParamList;
  MMLogin:TMMLogin;
  w:Integer;
begin
   Params := CreateMMLogin;
   try
      if not MMServer.MCExists then
       begin
         ShellExecute(Handle,'open',pchar(ExtractFilePath(ParamStr(0))+pid),'-mmc',pchar(ExtractFilePath(ParamStr(0))),0);
       end;
      w := 0;
      while not MMServer.MCExists do
       begin
         sleep(500);
         inc(w);
         if w>4 then Raise Exception.Create('打开目标应用超时...');
       end;
     Params.ParamByName('fn').AsInteger := mid;
     MMServer.coLogin(Params);
   finally
     Params.free;
   end;
end;

function TfrmMMMain.CreateMMLogin: TftParamList;
var
   Params:TftParamList;
begin
   Params := TftParamList.Create(nil);
   result := Params;
   Params.ParambyName('TENANT_ID').AsInteger := mmGlobal.TENANT_ID;
   Params.ParambyName('TENANT_NAME').AsString := mmGlobal.TENANT_NAME ;
   Params.ParambyName('SHORT_TENANT_NAME').AsString := mmGlobal.SHORT_TENANT_NAME;
   Params.ParambyName('SHOP_ID').AsString := mmGlobal.SHOP_ID;
   Params.ParambyName('SHOP_NAME').AsString := mmGlobal.SHOP_NAME;
   Params.ParambyName('USER_ID').AsString := mmGlobal.UserID;
   Params.ParambyName('USER_NAME').AsString := mmGlobal.UserName;
   if CaFactory.Audited then
      Params.ParambyName('LOGIN_STATUS').AsInteger := 1
   else
      Params.ParambyName('LOGIN_STATUS').AsInteger := 2;
   Params.ParambyName('XSM_USERNAME').AsString := mmGlobal.xsm_username;
   Params.ParambyName('XSM_PASSWORD').AsString := mmGlobal.xsm_password;
   Params.ParambyName('XSM_SIGNATURE').AsString := mmGlobal.xsm_signature;
   Params.ParambyName('XSM_CHALLENGE').AsString := mmGlobal.xsm_challenge;
   Params.ParambyName('XSM_LOGINED').asBoolean := mmGlobal.Logined;
   Params.ParambyName('fn').asInteger := 0;
end;

procedure TfrmMMMain.wm_Sign(var Message: TMessage);
var Params:TftParamList;
begin
  if not mmGlobal.Logined then
     begin
      if not mmGlobal.coLogin(mmGlobal.xsm_username,mmGlobal.xsm_password) then Exit;
     end
  else
     begin
      if not mmGlobal.getSignature then Exit;
     end;
  Params := CreateMMLogin;
  try
    MMServer.coSign(Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmMMMain.wm_SessionFail(var Message: TMessage);
var Params:TftParamList;
begin
  if not mmGlobal.coLogin(mmGlobal.xsm_username,mmGlobal.xsm_password) then Exit;
  Params := CreateMMLogin;
  try
    MMServer.coSessionFail(Params);
  finally
    Params.Free;
  end;
end;

procedure TfrmMMMain.HideMMList;
begin
  frmMMList.Close;
end;

procedure TfrmMMMain.ShowMMList;
begin
  frmMMList.Show;
  frmMMList.BringToFront;
end;

procedure TfrmMMMain.RzTrayIcon1RestoreApp(Sender: TObject);
begin
  inherited;
  Visible := true;
end;

procedure TfrmMMMain.RzTrayIcon1MinimizeApp(Sender: TObject);
begin
  inherited;
  Visible := false;
  ShowMMList;

end;

procedure TfrmMMMain.RzTrayIcon1LButtonDown(Sender: TObject);
begin
  inherited;
  ShowMMList;

end;

procedure TfrmMMMain.miCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMMMain.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  Close;

end;

end.
