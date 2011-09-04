program mm;

uses
  Forms,
  Windows,
  Messages,
  ufrmMMBasic in 'MM\ufrmMMBasic.pas' {frmMMBasic},
  ufrmMMMain in 'MM\ufrmMMMain.pas' {frmMMMain},
  uGlobal in '..\..\Basic\uGlobal.pas' {Global: TDataModule},
  uLoginFactory in 'App\uLoginFactory.pas',
  ummGlobal in 'ummGlobal.pas' {mmGlobal: TDataModule},
  ummFactory in 'MM\ummFactory.pas',
  uCaFactory in 'App\uCaFactory.pas',
  ufrmMMLogin in 'MM\ufrmMMLogin.pas' {frmMMLogin},
  ObjTenant in 'Obj\ObjTenant.pas',
  ufrmBasic in '..\..\Basic\ufrmBasic.pas' {frmBasic},
  ObjCommon in 'Obj\ObjCommon.pas',
  ufrmLogo in '..\..\Basic\ufrmLogo.pas' {frmLogo},
  uMMUtil in 'MM\uMMUtil.pas',
  uMMServer in 'MM\uMMServer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := false;
  Application.CreateForm(TmmGlobal, mmGlobal);
  Application.CreateForm(TfrmMMMain, frmMMMain);
  if not MMServer.MMExists then
     PostMessage(frmMMMain.Handle,MM_LOGIN,0,0);
  Application.Run;
end.
