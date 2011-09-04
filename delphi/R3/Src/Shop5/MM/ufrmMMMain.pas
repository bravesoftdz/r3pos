unit ufrmMMMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, ImgList, RzTray, Menus, ExtCtrls, RzForms,ZBase,
  RzBckgnd, RzPanel, RzBmpBtn, StdCtrls, uMMUtil, uMMServer ,ShellApi,
  RzButton;
type
  TfrmMMMain = class(TfrmMMBasic)
    RzTrayIcon1: TRzTrayIcon;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    RzButton1: TRzButton;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
  private
    { Private declarations }
    procedure wm_Login(var Message: TMessage); message MM_LOGIN;
    procedure wm_Sign(var Message: TMessage); message MM_SIGN;
  public
    { Public declarations }
    procedure ConnectToSQLite;
    procedure Init;
    function CreateMMLogin:TftParamList;
    procedure OpenMc(pid:string;mid:integer=0);
    function Login:boolean;
  end;

var
  frmMMMain: TfrmMMMain;

implementation
uses ufrmMMLogin, uCaFactory, ummGlobal, uGlobal, ufrmLogo;
{$R *.dfm}

{ TfrmMMMain }

procedure TfrmMMMain.ConnectToSQLite;
begin
  Global.MoveToLocal;
  Global.Connect;
end;

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

procedure TfrmMMMain.wm_Login(var Message: TMessage);
begin
  if Login then
     begin
        Show;
        Init;
     end
  else
     Application.Terminate;
end;

procedure TfrmMMMain.FormCreate(Sender: TObject);
begin
  inherited;
  frmLogo := TfrmLogo.create(self);
  ConnectToSQLite;
  left := Screen.Width-width-1;
  top := (Screen.Height - Height) div 2 -1;
end;

procedure TfrmMMMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if MessageBox(Handle,'是否退出盟盟？','友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
end;

procedure TfrmMMMain.FormDestroy(Sender: TObject);
begin
  freeandnil(frmLogo);
  inherited;

end;

procedure TfrmMMMain.Init;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'shop.exe') then //检测是否有安装终端系统。
     OpenMc('shop.exe');
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

procedure TfrmMMMain.RzButton1Click(Sender: TObject);
begin
  inherited;
  openmc('shop.exe');
end;

function TfrmMMMain.CreateMMLogin: TftParamList;
var Params:TftParamList;
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

end.
