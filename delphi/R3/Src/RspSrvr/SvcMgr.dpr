program SvcMgr;

uses
  Forms,
  ufrmSvcMgr in 'ufrmSvcMgr.pas' {frmSvcMgr},
  MultInst in 'MultInst.pas';

{$R *.res}
{$R JclCommCtrlAdmin.RES}

begin
  Application.Initialize;
  Application.Title := '�������';
  Application.CreateForm(TfrmSvcMgr, frmSvcMgr);
  Application.Run;
end.
