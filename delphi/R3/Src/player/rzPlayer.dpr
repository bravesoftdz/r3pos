program rzPlayer;

uses
  Forms,
  Windows,
  Messages,
  SysUtils,
  ufrmRzPlayer in 'ufrmRzPlayer.pas' {frmRzPlayer},
  ufrmRzMonitor in 'ufrmRzMonitor.pas' {frmRzMonitor},
  RzCtrls in 'RzCtrls.pas',
  rzXmlDown in 'rzXmlDown.pas',
  ipc in 'ipc.pas',
  ufrmPassword in 'ufrmPassword.pas' {frmPassword},
  ssCtrl in 'ssCtrl.pas',
  ScrnCtrl in 'ScrnCtrl.pas',
  md5 in 'md5.pas';

{$R *.res}
//{$R ..\..\Pub\UAC.res}
var
  MutHandle:THandle;
begin
  //打开互斥对象
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, RZ_PLAYER);
  if MutHandle = 0 then
  begin
    //建立互斥对象
    MutHandle := CreateMutex(nil, False, RZ_PLAYER);
    hExists := false;
  end
  else
    begin
      hExists := true;
    end;
  try
    Application.Initialize;
    if not hExists then
    begin
      Application.ShowMainForm := false;
      Application.CreateForm(TfrmRzPlayer, frmRzPlayer);
      PostMessage(frmRzPlayer.Handle,WM_PLAY_INIT,0,0);
      Application.Run;
    end
    else
    begin
      Application.Terminate;
      Application.Run;
    end;
  finally
    if MutHandle <> 0 then CloseHandle(MutHandle);
  end;
end.
