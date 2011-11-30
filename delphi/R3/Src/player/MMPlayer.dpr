program MMPlayer;

uses
  Forms,
  Windows,
  Messages,
  SysUtils,
  ufrmMMPlayer in 'ufrmMMPlayer.pas' {frmMMPlayer},
  ufrmColorCtrl in 'ufrmColorCtrl.pas' {ColorControlForm},
  ufrmMMUrlDown in 'ufrmMMUrlDown.pas' {frmMMUrlDown},
  ufrmMainPlayer in 'ufrmMainPlayer.pas' {frmMainPlayer};

{$R *.res}
begin
  if not hExists then
  begin
    Application.Initialize;
    Application.ShowMainForm := false;
    Application.CreateForm(TfrmMainPlayer, frmMainPlayer);
  Application.CreateForm(TfrmMMUrlDown, frmMMUrlDown);
  Application.CreateForm(TfrmMMPlayer, frmMMPlayer);
  Application.CreateForm(TColorControlForm, ColorControlForm);
  PostMessage(frmMMPlayer.Handle,WM_PLAYLIST_REFRESH,0,0);
    Application.Run;
  end;
end.
