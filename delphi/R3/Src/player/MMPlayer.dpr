program MMPlayer;

uses
  Forms,
  Windows,
  Messages,
  ufrmMMPlayer in 'ufrmMMPlayer.pas' {frmMMPlayer},
  ufrmColorCtrl in 'ufrmColorCtrl.pas' {ColorControlForm},
  ufrmMMUrlDown in 'ufrmMMUrlDown.pas' {frmMMUrlDown};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMMPlayer, frmMMPlayer);
  Application.CreateForm(TColorControlForm, ColorControlForm);
  Application.CreateForm(TfrmMMUrlDown, frmMMUrlDown);
  PostMessage(frmMMPlayer.Handle,WM_PLAYLIST_REFRESH,0,0);
  Application.Run;
end.
