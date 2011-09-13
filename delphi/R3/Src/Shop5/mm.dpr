program mm;

uses
  Forms,
  Windows,
  Messages,
  ufrmMMBasic in 'MM\ufrmMMBasic.pas' {frmMMBasic},
  ufrmMMList in 'MM\ufrmMMList.pas' {frmMMList},
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
  uMMServer in 'MM\uMMServer.pas',
  uSyncFactory in 'App\uSyncFactory.pas',
  ObjSyncFactory in 'Obj\ObjSyncFactory.pas',
  uShopGlobal in 'uShopGlobal.pas' {ShopGlobal: TDataModule},
  ufrmDesk in '..\..\Basic\ufrmDesk.pas' {frmDesk},
  ufrmMain in '..\..\Basic\ufrmMain.pas' {frmMain},
  ufrmMMMain in 'MM\ufrmMMMain.pas' {frmMMMain},
  ufrmMMDesk in 'MM\ufrmMMDesk.pas' {frmMMDesk},
  ObjChatInfo in 'Obj\ObjChatInfo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := false;
  Application.CreateForm(TmmGlobal, mmGlobal);
  Application.CreateForm(TfrmMMMain, frmMMMain);
  Application.CreateForm(TfrmMMDesk, frmMMDesk);
  Application.CreateForm(TfrmMMList, frmMMList);
  if not MMServer.MMExists then
     PostMessage(frmMMMain.Handle,MM_LOGIN,0,0);
  Application.Run;
end.
