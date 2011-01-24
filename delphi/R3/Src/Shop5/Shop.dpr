program Shop;
uses
  Forms,
  Windows,
  SysUtils,
  uGlobal in '..\..\BASIC\uGlobal.pas' {Global: TDataModule},
  ufrmBasic in '..\..\BASIC\ufrmBasic.pas' {frmBasic},
  ufrmMain in '..\..\BASIC\ufrmMain.pas' {frmMain},
  ufrmDesk in '..\..\BASIC\ufrmDesk.pas' {frmDesk},
  udmIcon in '..\..\BASIC\udmIcon.pas' {dmIcon: TDataModule},
  uResOpr in '..\..\PUB\uResOpr.pas',
  GIFImage in '..\..\PUB\GIFIMAGE.PAS',
  uShopGlobal in 'uShopGlobal.pas' {ShopGlobal: TDataModule},
  uframeMDForm in 'Frame\uframeMDForm.pas' {frameMDForm},
  uframeDialogForm in 'Frame\uframeDialogForm.pas' {frameDialogForm},
  uShopUtil in 'Frame\uShopUtil.pas',
  ufrmShopMain in 'ufrmShopMain.pas' {frmShopMain},
  ufrmShopDesk in 'ufrmShopDesk.pas' {frmShopDesk},
  uXDictFactory in 'Frame\uXDictFactory.pas',
  uframeToolForm in 'Frame\uframeToolForm.pas' {frameToolForm},
  ObjCommon in 'Obj\ObjCommon.pas',
  uDownByHttp in 'Update\uDownByHttp.pas',
  ufrmInstall in 'Update\ufrmInstall.pas' {frmInstall},
  uDevFactory in 'App\uDevFactory.pas',
  ufrmPswModify in 'ufrmPswModify.pas' {frmPswModify},
  ufrmLogin in 'ufrmLogin.pas' {frmLogin},
  ObjMeaUnits in 'Obj\ObjMeaUnits.pas',
  ufrmMeaUnits in 'App\ufrmMeaUnits.pas' {frmMeaUnits},
  ufrmTenant in 'App\ufrmTenant.pas' {frmTenant},
  ufrmDutyInfo in 'App\ufrmDutyInfo.pas' {frmDutyInfo},
  ufrmDutyInfoList in 'App\ufrmDutyInfoList.pas' {frmDutyInfoList},
  ufrmRoleInfo in 'App\ufrmRoleInfo.pas' {frmRoleInfo},
  ufrmRoleInfoList in 'App\ufrmRoleInfoList.pas' {frmRoleInfoList},
  ufrmUsers in 'App\ufrmUsers.pas' {frmUsers},
  ufrmUsersInfo in 'App\ufrmUsersInfo.pas' {frmUsersInfo},
  ObjDutyInfo in 'Obj\ObjDutyInfo.pas',
  ObjRoleInfo in 'Obj\ObjRoleInfo.pas',
  ObjUsers in 'Obj\ObjUsers.pas',
  ObjTenant in 'Obj\ObjTenant.pas',
  uCaFactory in 'App\uCaFactory.pas';

{$R *.res}
var
  f:TextFile;
  handle:THandle;
  Msg:Integer;
begin
  Application.Initialize;
  SFVersion := '.NET';
  DBVersion := 'DB1.0.0.1';
  Application.CreateForm(TdmIcon, dmIcon);
  Application.CreateForm(TShopGlobal, ShopGlobal);
  Application.CreateForm(TfrmShopMain, frmShopMain);
  Application.CreateForm(TfrmShopDesk, frmShopDesk);
  Application.ShowMainForm := false;
  PostMessage(frmShopMain.Handle,WM_LOGIN_REQUEST,1,1);
  Application.Run;

end.
