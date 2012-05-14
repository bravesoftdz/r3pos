unit ufrmRzPlayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack, DirectShow9, StdCtrls, ActiveX, DSUtil, Menus, rzCtrls,
  ExtCtrls, ComCtrls, Buttons, ImgList, RzTray, RzStatus, RzPanel,ufrmRzMonitor,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

const
  RZ_PLAYER = '{878F551E-FE1B-4A89-B6BF-A49B300882A6}';
  
type
  TfrmRzPlayer = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Panel1: TPanel;
    ImageList1: TImageList;
    ImageList2: TImageList;
    RzTrayIcon1: TRzTrayIcon;
    Bkg: TPanel;
    Memo1: TMemo;
    N4: TMenuItem;
    Timer1: TTimer;
    N3: TMenuItem;
    N6: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N7: TMenuItem;
    N5: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    IdHTTP1: TIdHTTP;
    N10: TMenuItem;
    FATAL1: TMenuItem;
    ERROR1: TMenuItem;
    WARN1: TMenuItem;
    INFO1: TMenuItem;
    DEBUG1: TMenuItem;
    RACE1: TMenuItem;
    procedure Fullscreen1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N9Click(Sender: TObject);
    procedure RACE1Click(Sender: TObject);
  private
    FdefaultMonitor: integer;
    OsdChanged : Boolean;
    Shut:boolean;
    LogDate:string;
    Keyid:integer;
    procedure SetdefaultMonitor(const Value: integer);
    { Private declarations }
    procedure AppExecption(Sender: TObject; E: Exception);
  protected
    procedure RzInit(var Message: TMessage); message WM_PLAY_INIT;
    procedure RzLogFile(var Message: TMessage); message WM_LOGFILE_MSG;
    procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY;
    procedure RzPlayStart(var Message: TMessage); message WM_PLAY_START;
    procedure Show;
    //清理资源
    procedure ClearRes;
  public
    { Public declarations }
    frmRzMonitor:TfrmRzMonitor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property defaultMonitor:integer read FdefaultMonitor write SetdefaultMonitor;
  end;

var
  frmRzPlayer: TfrmRzPlayer;
  hExists:boolean;
implementation

uses IniFiles,rzXmlDown,ufrmPassword,ipc,ScrnCtrl,ssCtrl;

{$R *.dfm}
const
  WH_MOUSE_LL=14;
var
  MutHandle:THandle;
  whMouse: HHook;
  whMessage: HHook;
  sLeft,sTop,sWidth,sHeight:integer;
function MouseHookCallBack(Code: integer; Msg: WPARAM;
  MouseHook: LPARAM): LRESULT; stdcall;
var
   pt: TPoint;
begin
  if Code >= 0 then
     begin
       if(Msg=WM_MOUSEMOVE) or (Msg=WM_NCMOUSEMOVE) then
          begin
            pt := PMouseHookStruct(MouseHook)^.pt;
            if (pt.X>(sLeft+sWidth))
               or
               (pt.X<sLeft)
               or
               (pt.Y>(sTop+sHeight))
               or
               (pt.Y<sTop)
            then
               begin
                 result := 1;
                 Exit;
               end;
          end;
       Result := CallNextHookEx(whMouse, Code, Msg, MouseHook);
     end;
end;

function HookWinProc(nCode:integer;wParam:Integer;lParam:Integer): LRESULT; stdcall;
begin
 if nCode >= 0 then
    begin
      if (nCode=WM_SYSCOMMAND) and ((wParam = SC_SCREENSAVE) or (wParam = SC_MONITORPOWER)) then
         result := 0
      else
         Result := CallNextHookEx(whMessage, nCode, wParam, lParam);
    end;
end;
constructor TfrmRzPlayer.Create(AOwner: TComponent);
var
  i:Integer;
  F:TIniFile;
  Buf:array [0..255] of char;
begin
  inherited;
  AppPath := ExtractFilePath(ParamStr(0));
  fillchar(Buf,256,0);
  GetEnvironmentVariable('APPDATA',Buf,256);
  AppData := Buf+'\rzico';
  if AppData='' then AppData := AppPath;
  ForceDirectories(AppData+'\logs');
  ForceDirectories(AppData+'\adv');
  ForceDirectories(AppData+'\res');
  ForceDirectories(AppData+'\temp');
  F := TIniFile.Create(AppData+'\rzPlayer.ini');
  try
    //F.WriteInteger('config','Handle',Handle);
    defaultMonitor := F.ReadInteger('config','Monitor',-1);
  finally
    F.Free;
  end;
  Shut := false;
  frmRzMonitor := TfrmRzMonitor.Create(nil);
  Application.OnException := AppExecption;
  Keyid:=GlobalAddAtom('playStore');
  RegisterHotKey(Handle,Keyid,MOD_CONTROL+MOD_SHIFT,VK_F12);
  whMouse := SetWindowsHookEx(WH_MOUSE_LL, MouseHookCallBack,
    hInstance,
    0
    );
  whMessage := SetWindowsHookEx(WH_GETMESSAGE, HookWinProc,
    hInstance,
    0
    );

  MMonitor := MonitorfromWindow(Application.Handle);
  MIndex := FindMonitorIndex(MMonitor);
  sTop := MMonitor.Top;
  sLeft := MMonitor.Left;
  sWidth := MMonitor.Width;
  sHeight := MMonitor.Height;
end;

destructor TfrmRzPlayer.Destroy;
begin
  Timer1.Enabled := false;
  UnhookWindowsHookEx(whMouse);
  UnhookWindowsHookEx(whMessage);
  UnRegisterHotKey(handle,Keyid);
  frmRzMonitor.Free;
//  if Memo1.Lines.Count > 0 then SaveLogFile;
  inherited;
end;

procedure TfrmRzPlayer.Fullscreen1Click(Sender: TObject);
begin
  Show;
end;

procedure TfrmRzPlayer.RzInit(var Message: TMessage);
begin
  InitIpc;
  frmRzMonitor.Load;
  frmRzMonitor.Monitor := defaultMonitor;
  frmRzMonitor.StartFullScreen;
  frmRzMonitor.Play;
  LogDate := formatdatetime('YYYYMMDD',now());
  ShowWindow( Application.Handle, sw_Hide );
  XmlDown.Resume;
  Timer1.Enabled := true;
  SetScreenSaverActive(0);
end;

procedure TfrmRzPlayer.SetdefaultMonitor(const Value: integer);
begin
  FdefaultMonitor := Value;
end;

procedure TfrmRzPlayer.AppExecption(Sender: TObject; E: Exception);
begin
  SendDebug(E.Message,0);
end;

procedure TfrmRzPlayer.RzLogFile(var Message: TMessage);
var
  buf:pchar;
  s:string;
begin
  buf := pchar(Message.LParam);
  try
    SetLength(s,Message.WParam);
    Move(Buf^,pchar(s)^,Message.WParam);
    Memo1.Lines.Add(s);
  finally
    freemem(buf,Message.WParam);
  end;
end;

procedure TfrmRzPlayer.N4Click(Sender: TObject);
var
  s:string;
begin
  if InputRzBox('下载节目','请输入节目url:',s) then
     begin
       XmlDown.DownSrc(s,'','');
     end;
end;

procedure TfrmRzPlayer.WMHotKey(var Msg: TWMHotKey);
begin
  if (msg.HotKey = Keyid) then
     begin
       if not Visible then
          begin
            Show;
            BringtoFront;
          end
       else
          begin
            Hide;
            ShowWindow( Application.Handle, sw_Hide );
          end;
     end;
end;

procedure TfrmRzPlayer.Timer1Timer(Sender: TObject);
begin
//  SetThreadExecutionState( ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED );
  if GetScreenSaverRunning then
     begin
       KillScreenSaver;
       SetScreenSaverActive(0);
     end;
  if (formatdatetime('YYYYMMDD',now())<>LogDate) then
     begin
       Memo1.Lines.Clear;
//       SaveLogFile;
       LogDate := formatdatetime('YYYYMMDD',now());
       frmRzMonitor.Load;
       frmRzMonitor.Play;
       ClearRes;
     end;
end;

procedure TfrmRzPlayer.Show;
begin
  inherited Show;
  BoundsRect := rect(MMonitor.Left,
                     MMonitor.Top,
                     Width,
                     Height);
end;

procedure TfrmRzPlayer.N6Click(Sender: TObject);
var
  s:string;
begin
  if InputRzBox('IPC调用','请输入IPC命令:',s) then
     begin
       XmlDown.DownXml(s);
     end;
end;

procedure TfrmRzPlayer.N2Click(Sender: TObject);
var
  s:string;
begin
  if InputRzBox('上传信息','请输入发送内容:',s) then
     begin
       client_server_send(pchar(s),length(s));
     end;
end;

procedure TfrmRzPlayer.RzPlayStart(var Message: TMessage);
begin
  XmlDown.Play;
end;

procedure TfrmRzPlayer.N7Click(Sender: TObject);
var
  s:string;
begin
  if (ParamStr(1)<>'-debug') then
     begin
       if InputPsBox('用户认证','请输入管理员密码:',s) then
          begin
            if s<>('rzplayer'+formatDatetime('YYMMDD',now())+inttostr(strtoint(formatDatetime('DD',now())) mod 7)) then
               begin
                 messagebox(handle,'输入的管理员密码无效.','友情提示...',MB_OK+MB_ICONINFORMATION);
                 Exit;
               end;
          end
       else
          Exit;
     end;
  Shut := true;
  Application.MainForm.Close;
end;

procedure TfrmRzPlayer.N5Click(Sender: TObject);
begin
  Hide;
  ShowWindow( Application.Handle, sw_Hide );
end;

procedure TfrmRzPlayer.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not Shut then
     begin
       CanClose := false;
       Hide;
       ShowWindow( Application.Handle, sw_Hide );
     end;
end;

procedure TfrmRzPlayer.ClearRes;
begin

end;

procedure TfrmRzPlayer.N9Click(Sender: TObject);
begin
  with TrzXmlDown.Create do
    begin
      try
        msgId := 'dewewewewew';
        pid := 'ba9790bd3640715e01365822f2070052';
        SendStatus(1,'zhangsr我的测试');
      finally
        free;
      end;
    end;
end;

procedure TfrmRzPlayer.RACE1Click(Sender: TObject);
begin
  TMenuItem(Sender).Checked := not TMenuItem(Sender).Checked;
  if TMenuItem(Sender).Checked then
     LogFlag[TMenuItem(Sender).Tag] := '1'
  else
     LogFlag[TMenuItem(Sender).Tag] := '0';
end;

initialization
  //打开互斥对象
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, RZ_PLAYER);
  if MutHandle = 0 then
  begin
    //建立互斥对象
    MutHandle := CreateMutex(nil, False, RZ_PLAYER);
    hExists := false;
  end
  else
    hExists := true;
finalization
  if MutHandle<>0 then  CloseHandle(MutHandle);
end.
