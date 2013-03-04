library shop;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Forms,
  Windows,
  Messages,
  Classes,
  ufrmWebForm in 'ufrmWebForm.pas' {frmWebForm},
  uTokenFactory in '..\uTokenFactory.pas',
  dllApi in 'dllApi.pas',
  udataFactory in 'udataFactory.pas' {dataFactory: TDataModule},
  rspcn_TLB in '..\rspcn_TLB.pas',
  dllIntf in '..\dllIntf.pas',
  uRspFactory in '..\uRspFactory.pas' {rspFactory: TDataModule},
  ufrmWebToolForm in 'ufrmWebToolForm.pas' {frmWebToolForm},
  ufrmWebDialogForm in 'ufrmWebDialogForm.pas' {frmWebDialogForm},
  ufrmOrderForm in 'app\ufrmOrderForm.pas' {frmOrderForm},
  ufrmSaleOrder in 'app\ufrmSaleOrder.pas' {frmSaleOrder},
  udllGlobal in 'app\udllGlobal.pas' {dllGlobal: TDataModule},
  ufrmInitGoods in 'app\ufrmInitGoods.pas' {frmInitGoods},
  ObjGoodsRelation in 'obj\ObjGoodsRelation.pas',
  ObjCommon in 'obj\ObjCommon.pas',
  ufrmWebDialog in '..\common\ufrmWebDialog.pas' {frmWebDialog},
  ufrmFindDialog in 'ufrmFindDialog.pas' {frmFindDialog},
  udllDsUtil in 'utils\udllDsUtil.pas',
  udllFnUtil in 'utils\udllFnUtil.pas',
  udllShopUtil in 'utils\udllShopUtil.pas',
  udllXDictFactory in 'utils\udllXDictFactory.pas',
  ObjSalesOrderV60 in 'obj\ObjSalesOrderV60.pas',
  ufrmDialogProperty in 'app\ufrmDialogProperty.pas' {frmDialogProperty},
  ObjGetPrice in 'obj\ObjGetPrice.pas';

{$R *.res}
exports
  initApp,openApp,closeApp,eraseApp,getLastError,getModuleName,resize;
begin
end.
