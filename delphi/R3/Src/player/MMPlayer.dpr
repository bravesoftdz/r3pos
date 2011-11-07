program MMPlayer;

uses
  Forms,Windows,Messages,
  ufrmMMPlayer in 'ufrmMMPlayer.pas' {frmMMPlayer},
  ufrmColorCtrl in 'ufrmColorCtrl.pas' {ColorControlForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMMPlayer, frmMMPlayer);
  Application.CreateForm(TColorControlForm, ColorControlForm);
  PostMessage(frmMMPlayer.Handle,WM_PLAYLIST_REFRESH,0,0);
  Application.Run;
end.
