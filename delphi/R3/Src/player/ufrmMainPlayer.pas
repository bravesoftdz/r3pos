unit ufrmMainPlayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ufrmMMPlayer, ExtCtrls;
  
const
  MM_PLAYER = '{D51AB2C4-FFEE-414B-890B-30071D941E97}';
  
type
  TfrmMainPlayer = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    Keyid:integer;
  public
    { Public declarations }
    procedure WMHotKey(var Msg : TWMHotKey); message WM_HOTKEY;
    procedure WMTPosDisplay(var Message: TMessage); message WM_TPOS_DISPLAY;
  end;

var
  frmMainPlayer: TfrmMainPlayer;
  hExists:boolean;

implementation
uses IniFiles,ScrnCtrl;
{$R *.dfm}
const
  WH_MOUSE_LL=14;
var
  MutHandle:THandle;
  whMouse: HHook;
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
                 if (pt.X>(sLeft+sWidth)) then
                    setcursorpos((sLeft+sWidth),pt.Y)
                 else
                    setcursorpos((sLeft),pt.Y);
                 result := 1;
                 Exit;
               end;
          end;
       Result := CallNextHookEx(whMouse, Code, Msg, MouseHook);
     end;
end;

procedure TfrmMainPlayer.FormCreate(Sender: TObject);
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'\mmPlayer.ini');
  try
    F.WriteInteger('config','Handle',Handle);
  finally
    F.Free;
  end;
  Keyid:=GlobalAddAtom('playStore');
  RegisterHotKey(Handle,Keyid,MOD_CONTROL+MOD_SHIFT,VK_F12);
//  whMouse := SetWindowsHookEx(WH_MOUSE_LL, MouseHookCallBack,
//    hInstance,
//    0
//    );
  MMonitor := MonitorfromWindow(Application.Handle);
  MIndex := FindMonitorIndex(MMonitor);
  sTop := MMonitor.Top;
  sLeft := MMonitor.Left;
  sWidth := MMonitor.Width;
  sHeight := MMonitor.Height;
end;

procedure TfrmMainPlayer.WMTPosDisplay(var Message: TMessage);
begin
  PostMessage(frmMMPlayer.Handle,WM_TPOS_DISPLAY,Message.WParam,Message.LParam);
end;

procedure TfrmMainPlayer.FormDestroy(Sender: TObject);
begin
//  UnhookWindowsHookEx(whMouse);
  UnRegisterHotKey(handle,Keyid);

end;

procedure TfrmMainPlayer.Timer1Timer(Sender: TObject);
var
  lpRect:PRect;
begin
       new(lpRect);
       try
         lpRect^  := MMonitor.BoundsRect;
         ClipCursor(lpRect);
       finally
         dispose(lpRect);
       end;
end;

procedure TfrmMainPlayer.WMHotKey(var Msg: TWMHotKey);
begin
  if (msg.HotKey = Keyid) then
     begin
       frmMMPlayer.Show;
     end;
end;

initialization
  //打开互斥对象
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, MM_PLAYER);
  if MutHandle = 0 then
  begin
    //建立互斥对象
    MutHandle := CreateMutex(nil, False, MM_PLAYER);
    hExists := false;
  end
  else
    hExists := true;
finalization
  if MutHandle<>0 then  CloseHandle(MutHandle);
  
end.
