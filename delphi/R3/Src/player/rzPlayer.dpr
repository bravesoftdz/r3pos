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
  MultPlayer in 'MultPlayer.pas';

{$R *.res}
//{$R ..\..\Pub\UAC.res}

begin
  if not hExists then
  begin
    Application.Initialize;
    Application.ShowMainForm := false;
    Application.CreateForm(TfrmRzPlayer, frmRzPlayer);
  PostMessage(frmRzPlayer.Handle,WM_PLAY_INIT,0,0);
    Application.Run;
  end;
end.
