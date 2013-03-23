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
  ufrmPosInOrder in 'app\ufrmPosInOrder.pas' {frmPosInOrder},
  udllGlobal in 'app\udllGlobal.pas' {dllGlobal: TDataModule},
  ObjCommon in 'obj\ObjCommon.pas',
  ufrmWebDialog in '..\common\ufrmWebDialog.pas' {frmWebDialog},
  ufrmFindDialog in 'ufrmFindDialog.pas' {frmFindDialog},
  udllDsUtil in 'utils\udllDsUtil.pas',
  udllFnUtil in 'utils\udllFnUtil.pas',
  udllShopUtil in 'utils\udllShopUtil.pas',
  udllXDictFactory in 'utils\udllXDictFactory.pas',
  ObjSalesOrderV60 in 'obj\ObjSalesOrderV60.pas',
  ufrmDialogProperty in 'app\ufrmDialogProperty.pas' {frmDialogProperty},
  ObjGetPrice in 'obj\ObjGetPrice.pas',
  ufrmPosOutOrder in 'app\ufrmPosOutOrder.pas' {frmPosOutOrder},
  ObjStockOrderV60 in 'obj\ObjStockOrderV60.pas',
  ObjGoodsInfoV60 in 'obj\ObjGoodsInfoV60.pas',
  ufrmGoodsStorage in 'app\ufrmGoodsStorage.pas' {frmGoodsStorage},
  ufrmDropForm in 'app\ufrmDropForm.pas' {frmDropForm},
  ufrmSortDropFrom in 'app\ufrmSortDropFrom.pas' {frmSortDropFrom},
  ufrmGoodsInfoDropForm in 'app\ufrmGoodsInfoDropForm.pas' {frmGoodsInfoDropForm},
  ObjChangeOrderV60 in 'obj\ObjChangeOrderV60.pas',
  uCacheFactory in 'app\uCacheFactory.pas',
  ufrmGoodsSort in 'app\ufrmGoodsSort.pas' {frmGoodsSort},
  ufrmCustomer in 'app\ufrmCustomer.pas' {frmCustomer},
  ufrmDownStockOrder in 'app\ufrmDownStockOrder.pas' {frmDownStockOrder},
  ufrmShopReport in 'app\ufrmShopReport.pas' {frmShopReport},
  ufrmReportForm in 'app\ufrmReportForm.pas' {frmReportForm},
  ufrmSaleReport in 'app\ufrmSaleReport.pas' {frmSaleReport},
  ufrmStockReport in 'app\ufrmStockReport.pas' {frmStockReport},
  ufrmStocksCalc in 'app\ufrmStocksCalc.pas' {frmStocksCalc},
  ufrmProfitReport in 'app\ufrmProfitReport.pas' {frmProfitReport},
  uSyncFactory in 'app\uSyncFactory.pas',
  ObjMeaUnitsV60 in 'obj\ObjMeaUnitsV60.pas',
  ObjShopInfoV60 in 'obj\ObjShopInfoV60.pas',
  ObjSyncFactoryV60 in 'obj\ObjSyncFactoryV60.pas',
  ObjSysDefineV60 in 'obj\ObjSysDefineV60.pas',
  ObjTenantV60 in 'obj\ObjTenantV60.pas',
  ufrmStorageReport in 'app\ufrmStorageReport.pas' {frmStorageReport},
  uRspSyncFactory in 'app\uRspSyncFactory.pas',
  ufrmSysDefine in 'app\ufrmSysDefine.pas' {frmSysDefine},
  ufrmSyncData in 'app\ufrmSyncData.pas' {frmSyncData},
  ufrmInitGoods in 'app\ufrmInitGoods.pas' {frmInitGoods},
  ObjCustomerV60 in 'obj\ObjCustomerV60.pas',
  uRightsFactory in 'app\uRightsFactory.pas',
  ufrmUserRights in 'app\ufrmUserRights.pas' {frmUserRights},
  ufrmSaleOrder in 'app\ufrmSaleOrder.pas' {frmSaleOrder},
  ufrmStockOrder in 'app\ufrmStockOrder.pas' {frmStockOrder},
  ObjGoodsSortV60 in 'obj\ObjGoodsSortV60.pas',
  ObjUserRightsV60 in 'obj\ObjUserRightsV60.pas',
  ObjUsersV60 in 'obj\ObjUsersV60.pas';

{$R *.res}
exports
  initApp,openApp,closeApp,eraseApp,getLastError,getModuleName,resize;
begin
end.
