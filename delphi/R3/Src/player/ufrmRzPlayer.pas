unit ufrmRzPlayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack, DirectShow9, StdCtrls, ActiveX, DSUtil, Menus, rzCtrls,
  ExtCtrls, ComCtrls, Buttons, ImgList, RzTray, RzStatus, RzPanel,ufrmRzMonitor,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  MPlayer;

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
    Bkg: TPanel;
    Memo1: TMemo;
    N4: TMenuItem;
    Timer1: TTimer;
    N3: TMenuItem;
    N6: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    FATAL1: TMenuItem;
    ERROR1: TMenuItem;
    WARN1: TMenuItem;
    INFO1: TMenuItem;
    DEBUG1: TMenuItem;
    RACE1: TMenuItem;
    N11: TMenuItem;
    Timer2: TTimer;
    N12: TMenuItem;
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
    procedure N1Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure vmrWindowed1Click(Sender: TObject);
    procedure vmrWindowless1Click(Sender: TObject);
    procedure vmrRenderless1Click(Sender: TObject);
  private
    FdefaultMonitor: integer;
    OsdChanged : Boolean;
    LogDate:string;
    Keyid:integer;
    locked,lockLogfile:boolean;
    ShutSystem:boolean;
    procedure SetdefaultMonitor(const Value: integer);
    { Private declarations }
    procedure AppExecption(Sender: TObject; E: Exception);
  protected
    procedure RzInit(var Message: TMessage); message WM_PLAY_INIT;
    procedure RzLogFile(var Message: TMessage); message WM_LOGFILE_MSG;
    procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY;
    procedure RzPlayStart(var Message: TMessage); message WM_PLAY_START;
    procedure RzPlayClose(var Message: TMessage); message WM_PLAY_CLOSE;
    procedure WMDisplayChange(var Message: TMessage); message WM_DISPLAYCHANGE;

    procedure Show;
    //������Դ
    procedure ClearRes;
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
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
type
  PKBDLLHOOKSTRUCT = ^KBDLLHOOKSTRUCT;
  KBDLLHOOKSTRUCT = record
    vkCode: DWORD;
    scanCode: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: DWORD;
  end;

const
  WH_MOUSE_LL=14;
  WH_KEYBOARD_LL=13;
var
  whMouse: HHook;
  whKeyboard: HHook;
  whMessage: HHook;
  sLeft,sTop,sWidth,sHeight:integer;
function MouseHookCallBack(Code: integer; Msg: WPARAM;
  MouseHook: LPARAM): LRESULT; stdcall;
var
   pt: TPoint;
begin
  if Code >= 0 then
     begin
       case Msg of
       WM_MOUSEMOVE,WM_NCMOUSEMOVE:
          begin
            pt := PMouseHookStruct(MouseHook)^.pt;
            if (pt.X>(sLeft+sWidth))
               or
               (pt.X<sLeft)
              // or
              // (pt.Y>(sTop+sHeight))
              // or
              // (pt.Y<sTop)
            then
               begin
                 if (pt.X>(sLeft+sWidth)) then
                    setcursorpos((sLeft+sWidth),pt.Y)
                 else
                    setcursorpos((sLeft),pt.Y);
                 result := 1;
                 Exit;
               end;
          end;
       end;
       Result := CallNextHookEx(whMouse, Code, Msg, MouseHook);
     end;
end;

{$IFDEF WIN32}

function KeyboardHookCallBack(Code: integer; Msg: WPARAM;
  KeyboardHook: LPARAM): LRESULT; stdcall;
{$ELSE}

function KeyboardHookCallBack(Code: integer; Msg: word;
  KeyboardHook: longint): longint; export;
{$ENDIF}
const LLKHF_ALTDOWN = $20;
var
   p: PKBDLLHOOKSTRUCT;

begin
  Result := 0;
  if Code>=0 then
     begin
       case Msg of
       WM_KEYDOWN,
       WM_SYSKEYDOWN,
       WM_KEYUP,
       WM_SYSKEYUP:
         begin
           //p := PKBDLLHOOKSTRUCT(KeyboardHook);
            {
           if (((p^.vkCode = VK_TAB) and ((p^.flags and LLKHF_ALTDOWN) <> 0)) or
              ((p^.vkCode = VK_ESCAPE) and ((p^.flags and LLKHF_ALTDOWN) <> 0)) or
              ((p^.vkCode = VK_ESCAPE) and ((GetKeyState(VK_CONTROL) and $8000) <> 0)) or
              ((p^.vkCode = VK_DELETE) and ((p^.flags and LLKHF_ALTDOWN) <> 0) and ((GetKeyState(VK_CONTROL) and $8000) <> 0)))
           then
              begin
                 result := 1;
                 Exit;
              end;   }
         end;
       end;
       Result := CallNextHookEx(whKeyboard, Code, Msg, KeyboardHook);
     end;
end;

function HookWinProc(nCode:integer;wParam:Integer;lParam:Integer): LRESULT; stdcall;
begin
 if nCode >= 0 then
    begin
      if (nCode=WM_POWERBROADCAST) then
         begin
           result := 0;
         end
      else
         Result := CallNextHookEx(whMessage, nCode, wParam, lParam);
    end;
end;
constructor TfrmRzPlayer.Create(AOwner: TComponent);
var
  i:Integer;
  F:TIniFile;
  Buf:array [0..255] of char;
  hWnd:THandle;
begin
  inherited;
  lockLogfile := false;
  ShutSystem := false;
  Application.OnMessage := AppMessage;
  AppPath := ExtractFileDir(ParamStr(0));
  fillchar(Buf,256,0);
  GetEnvironmentVariable('ALLUSERSPROFILE',Buf,256);
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

  MMonitor := MonitorfromWindow(Application.Handle);
  MIndex := FindMonitorIndex(MMonitor);
  sTop := MMonitor.Top;
  sLeft := MMonitor.Left;
  sWidth := MMonitor.Width;
  sHeight := MMonitor.Height;


  frmRzMonitor := TfrmRzMonitor.Create(nil);
  Application.OnException := AppExecption;
  Keyid:=GlobalAddAtom('playStore');
  RegisterHotKey(Handle,Keyid,MOD_CONTROL+MOD_SHIFT,VK_F12);
{
  whMouse := SetWindowsHookEx(WH_MOUSE_LL, MouseHookCallBack,
    hInstance,
    0
    );
}
{  whKeyboard := SetWindowsHookEx(WH_KEYBOARD_LL, KeyboardHookCallBack,
    hInstance,
    0);
}
//  whMessage := SetWindowsHookEx(WH_GETMESSAGE, HookWinProc,
//    hInstance,
//    0
//    );

  Assert(SystemParametersInfo (SPI_SETLOWPOWERTIMEOUT, 0, nil, SPIF_SENDWININICHANGE));
  Assert(SystemParametersInfo (SPI_SETPOWEROFFTIMEOUT, 0, nil, SPIF_SENDWININICHANGE));
//  Assert(SystemParametersInfo (SPI_SETSCREENSAVETIMEOUT, 0, nil, SPIF_SENDWININICHANGE));


  hWnd := FindWindow('Shell_TrayWnd',nil);
  hWnd := FindWindowEx(hWnd,0,'TrayNotifyWnd',nil);
  hWnd := FindWindowEx(hWnd,0,'TrayShowDesktopButtonWClass',nil);
  EnableWindow(hWnd, false);
  ShowWindow(hWnd, sw_Hide );
//  hWnd := FindWindow('TaskSwitcherWnd',nil);
//  EnableWindow(hWnd, false);
//  SetWindowPos(Handle,HWND_TOPMOST,0,0,0,0,SWP_NOMOVE or SWP_NOSIZE);
end;

destructor TfrmRzPlayer.Destroy;
begin
  Timer2.Enabled := false;
  Timer1.Enabled := false;
//  UnhookWindowsHookEx(whMouse);
//  UnhookWindowsHookEx(whKeyboard);
//  UnhookWindowsHookEx(whMessage);
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
//  ParentWindow := FindWindow('Progman',nil);
  InitIpc;
  frmRzMonitor.Load;
  frmRzMonitor.Monitor := defaultMonitor;
  frmRzMonitor.StartFullScreen;
  frmRzMonitor.Play;
  LogDate := formatdatetime('YYYYMMDD',now());
  ShowWindow( Application.Handle, sw_Hide );
  XmlDown.Resume;
  Timer1.Enabled := true;
  Timer2.Enabled := true;
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
    if lockLogfile then Exit;
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
  if InputRzBox('���ؽ�Ŀ','�������Ŀurl:',s) then
     begin
       XmlDown.DownSrc(1,s,'','','','');
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
  if lockLogfile then Exit;
  if ShutSystem then Exit;

  if username='' then Subscribe;
//  if GetScreenSaverRunning then
//     begin
//       KillScreenSaver;
//       SetScreenSaverActive(0);
//     end;
  if (formatdatetime('YYYYMMDD',now())<>LogDate) then
     begin
       lockLogfile := true;
       Memo1.Lines.BeginUpdate;
       try
         Memo1.Lines.Clear;
         if IsWorkStationLocked then Exit;
         LogDate := formatdatetime('YYYYMMDD',now());
         frmRzMonitor.Load;
         frmRzMonitor.Play;
         ClearRes;
       finally
         Memo1.Lines.EndUpdate;
         lockLogfile := false;
       end;
     end;
end;

procedure TfrmRzPlayer.Show;
begin
  inherited Show;
  BoundsRect := rect(MMonitor.Left,
                     MMonitor.Top,
                     MMonitor.Left+Width,
                     MMonitor.Top+Height);
end;

procedure TfrmRzPlayer.N6Click(Sender: TObject);
var
  s:string;
begin
  if InputRzBox('IPC����','������IPC����:',s) then
     begin
       XmlDown.DownXml(s);
     end;
end;

procedure TfrmRzPlayer.N2Click(Sender: TObject);
var
  s:string;
begin
  ClearRes;
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
       if InputPsBox('�û���֤','���������Ա����:',s) then
          begin
            if s<>('rzico'+formatDatetime('YYMMDD',now())+inttostr(strtoint(formatDatetime('DD',now())) mod 7)) then
               begin
                 messagebox(handle,'����Ĺ���Ա������Ч.','������ʾ...',MB_OK+MB_ICONINFORMATION);
                 Exit;
               end;
          end
       else
          Exit;
     end;
  ShutSystem := true;
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
{  if not ShutSystem then
     begin
       CanClose := false;
       Hide;
       ShowWindow( Application.Handle, sw_Hide );
     end
  else
     XmlDown.CloseThread;    }
end;

procedure TfrmRzPlayer.ClearRes;
var
  sr: TSearchRec;
  FileAttrs,w: Integer;
  s,p:string;
begin
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(appdata+'\res\photo\*.*', FileAttrs, sr) = 0 then
    begin
      repeat
        begin
          s := sr.Name;
          w := length(ExtractFileExt(sr.Name));
          delete(s,length(s)-w+1,w);
          if (s<>'') and (s<>'.') and (s<>'..') then
             begin
                p := copy(Plays.readString('res',s,''),1,8);
                if p<>'' then
                   begin
                     if p<formatDatetime('YYYYMMDD',now()-resDay) then
                        begin
                          if deletefile(appdata+'\res\photo\'+sr.Name) then
                          plays.DeleteKey('res',s);
                        end;
                   end;
             end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(appdata+'\res\vedio\*.*', FileAttrs, sr) = 0 then
    begin
      repeat
        begin
          s := sr.Name;
          w := length(ExtractFileExt(sr.Name));
          delete(s,length(s)-w+1,w);
          if (s<>'') and (s<>'.') and (s<>'..') then
             begin
                p := copy(Plays.readString('res',s,''),1,8);
                if p<>'' then
                   begin
                     if p<formatDatetime('YYYYMMDD',now()-resDay) then
                        begin
                          if deletefile(appdata+'\res\vedio\'+sr.Name) then
                          plays.DeleteKey('res',s);
                        end;
                   end;
             end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  SendDebug('----------������Դ����-------------',4);
end;

procedure TfrmRzPlayer.N9Click(Sender: TObject);
begin
  with TrzXmlDown.Create do
    begin
      try
        msgId := 'dewewewewew';
        pid := 'ba9790bd3640715e01365822f2070052';
        SendStatus(1,'zhangsr�ҵĲ���');
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

procedure TfrmRzPlayer.N1Click(Sender: TObject);
var
  s:string;
begin
  if InputRzBox('�ϴ���־','���ϴ���ַurl:',s) then
     begin
       XmlDown.DownSrc(6,s,'','','','');
     end;
end;

procedure TfrmRzPlayer.N11Click(Sender: TObject);
var
  s:string;
begin
  if InputRzBox('�ϴ�����','���ϴ���ַurl:',s) then
     begin
       XmlDown.DownSrc(7,s,'','','','');
     end;
end;

procedure TfrmRzPlayer.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if(Msg.message=WM_SYSCOMMAND) and (Msg.wParam=SC_SCREENSAVE) then
     begin
       Handled:=true;  //��ֹ��Ļ����������
       SendDebug('��ֹ��Ļ����������',4);
     end
  else
  if(Msg.message=WM_SYSCOMMAND) and (Msg.wParam=SC_MONITORPOWER) then
     begin
       Handled:=true;  //��ֹ��Ļ����������
       SendDebug('��ֹ��Դѡ�������',4);
     end
  else
  if (Msg.message=SC_SCREENSAVE) or (Msg.message=SC_MONITORPOWER) then
     begin
       Handled:=true;  //��ֹ��Ļ����������
       SendDebug('��ֹ��Ļ����Դѡ�������',4);
     end
  else
     Handled:=false; //���и���Ϣ��ȱʡ����
end;

procedure TfrmRzPlayer.Button1Click(Sender: TObject);
begin
  frmRzMonitor.playFile.rePlay;
end;

procedure TfrmRzPlayer.Timer2Timer(Sender: TObject);
var
  lpRect:PRect;
begin
  if lockLogfile then Exit;
  if ShutSystem then Exit;

  if IsWorkStationLocked then
     begin
       locked := true;
     end
  else
     begin
       new(lpRect);
       try
         lpRect^  := MMonitor.BoundsRect;
         ClipCursor(lpRect);
       finally
         dispose(lpRect);
       end;
       if locked then
          begin
            if Assigned(frmRzMonitor.playFile) then
               frmRzMonitor.playFile.rePlay;
            Senddebug('+++++++++++++�����ز�++++++++++++++',4);
          end;
       locked := false;
     end;
end;

procedure TfrmRzPlayer.RzPlayClose(var Message: TMessage);
begin
  frmRzMonitor.close;
  frmRzMonitor.clear;
end;

procedure TfrmRzPlayer.N12Click(Sender: TObject);
var
  s:string;
begin
  if InputRzBox('�ϵ�����','�������ļ�url:',s) then
     begin
       XmlDown.DownFile_Test(s,appdata+'\downfile.test');
     end;
end;

procedure TfrmRzPlayer.vmrWindowed1Click(Sender: TObject);
begin
  DefVMRVideoMode := vmrWindowed;
end;

procedure TfrmRzPlayer.vmrWindowless1Click(Sender: TObject);
begin
  DefVMRVideoMode := vmrWindowless;

end;

procedure TfrmRzPlayer.vmrRenderless1Click(Sender: TObject);
begin
  DefVMRVideoMode := vmrRenderless;

end;

procedure TfrmRzPlayer.WMDisplayChange(var Message: TMessage);
begin
  if Assigned(frmRzMonitor.playFile) then
     frmRzMonitor.playFile.rePlay;
  Senddebug('+++++++++++++��Ļ����++++++++++++++',4);
end;

end.
