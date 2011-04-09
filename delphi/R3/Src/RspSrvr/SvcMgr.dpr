program SvcMgr;

uses
  Forms,
  ufrmSvcMgr in 'ufrmSvcMgr.pas' {frmSvcMgr},
  MultInst in 'MultInst.pas';

{$R *.res}
{$R JclCommCtrlAdmin.RES}

begin
  Application.Initialize;
  Application.Title := '服务管理';
  Application.CreateForm(TfrmSvcMgr, frmSvcMgr);
  Application.Run;
end.
