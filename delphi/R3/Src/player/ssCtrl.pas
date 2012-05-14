unit ssCtrl;

interface
uses
  Windows, Messages, SysUtils, Classes, ActiveX;
function GetScreenSaverActive:boolean;
procedure SetScreenSaverActive(Active:integer);
function GetScreenSaverTimeout:integer;
function GetScreenSaverRunning:boolean;
procedure KillScreenSaver;

implementation
function KillScreenSaverFunc(hWnd:HWND;lParam:LPARAM):boolean;    //ע��ص���������Ϊ��ͨ��Ա����������Ϊ��̬��Ա����
begin
  if(IsWindowVisible(hWnd)) then PostMessage( hWnd, WM_CLOSE, 0, 0 );
  result := true;
end;

function GetScreenSaverActive:boolean;
var
  isActive:bool;
begin
  isActive := false;   //һ����BOOL������bool��������ʱ����
  if not SystemParametersInfo(SPI_GETSCREENSAVEACTIVE,0,@isActive, 0) then Raise Exception.Create('fail');
  result := isActive;
end;
procedure SetScreenSaverActive(Active:integer);
var
  nullVar:integer;
begin
  nullVar := 0;
  if not SystemParametersInfo(SPI_SETSCREENSAVEACTIVE,0,0, SPIF_SENDWININICHANGE ) then
     Raise Exception.Create('fail');
end;

function GetScreenSaverTimeout:integer;
var
  value:integer;
begin
  value := 0;
  if not SystemParametersInfo(SPI_GETSCREENSAVETIMEOUT, 0,@value, 0 ) then Raise Exception.Create('fail');
  result := value;
end;
function GetScreenSaverRunning:boolean;
var
  isRunning:bool;
begin
  isRunning := false;
  if not SystemParametersInfo(SPI_GETSCREENSAVERRUNNING, 0,@isRunning, 0 ) then Raise Exception.Create('fail');
  result := isRunning;
end;

procedure KillScreenSaver;
var
  hDesktop:HDESK;
begin
  hDesktop := OpenDesktop('Screen-saver', 0,false,DESKTOP_READOBJECTS or DESKTOP_WRITEOBJECTS);
  if( hDesktop <> 0) then
  begin
     EnumDesktopWindows(hDesktop,@KillScreenSaverFunc,0);
     CloseDesktop(hDesktop);
  end
  else
  begin
     PostMessage(GetForegroundWindow(), WM_CLOSE, 0, 0 );
  end;
end;

end.
