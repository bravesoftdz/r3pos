program Upgrade;

uses
  Forms,
  uGlobal in '..\..\Basic\uGlobal.pas' {Global: TDataModule},
  ufrmBasic in '..\..\Basic\ufrmBasic.pas' {frmBasic},
  ufrmTenant in '..\Shop5\App\ufrmTenant.pas' {frmTenant},
  ObjTenant in '..\Shop5\Obj\ObjTenant.pas',
  ufrmUpgrade in 'ufrmUpgrade.pas' {frmUpgrade},
  CaProductService in '..\Shop5\App\CaProductService.pas',
  CaServiceLineService in '..\Shop5\App\CaServiceLineService.pas',
  CaTenantService in '..\Shop5\App\CaTenantService.pas',
  RspDownloadService in '..\Shop5\App\RspDownloadService.pas',
  uCaFactory in '..\Shop5\App\uCaFactory.pas',
  uShopGlobal in '..\Shop5\uShopGlobal.pas' {ShopGlobal: TDataModule},
  uShopUtil in '..\Shop5\Frame\uShopUtil.pas',
  uXDictFactory in '..\Shop5\Frame\uXDictFactory.pas',
  ObjCommon in '..\Shop5\Obj\ObjCommon.pas',
  udbUtil in '..\..\Pub\udbUtil.pas',
  PubMemberService in '..\Shop5\App\PubMemberService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TShopGlobal, ShopGlobal);
  Application.CreateForm(TfrmUpgrade, frmUpgrade);
  Application.Run;
end.
