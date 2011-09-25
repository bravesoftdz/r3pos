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
  uSyncFactory in 'App\uSyncFactory.pas',
  ObjSyncFactory in 'Obj\ObjSyncFactory.pas',
  uShopGlobal in 'uShopGlobal.pas' {ShopGlobal: TDataModule},
  ufrmDesk in '..\..\Basic\ufrmDesk.pas' {frmDesk},
  ufrmMain in '..\..\Basic\ufrmMain.pas' {frmMain},
  ufrmMMMain in 'MM\ufrmMMMain.pas' {frmMMMain},
  ufrmMMDesk in 'MM\ufrmMMDesk.pas' {frmMMDesk},
  ObjChatInfo in 'Obj\ObjChatInfo.pas',
  ufrmMMDialog in 'MM\ufrmMMDialog.pas' {frmMMDialog},
  CaProductService in 'App\CaProductService.pas',
  CaServiceLineService in 'App\CaServiceLineService.pas',
  CaTenantService in 'App\CaTenantService.pas',
  LCContrllerLib in 'App\LCContrllerLib.pas',
  PubMemberService in 'App\PubMemberService.pas',
  RspDownloadService in 'App\RspDownloadService.pas',
  uAdvFactory in 'App\uAdvFactory.pas',
  uCommand in 'App\uCommand.pas',
  uDevFactory in 'App\uDevFactory.pas',
  ufrmAccount in 'App\ufrmAccount.pas' {frmAccount},
  ufrmAccountInfo in 'App\ufrmAccountInfo.pas' {frmAccountInfo},
  ufrmBarCodePrint in 'App\ufrmBarCodePrint.pas' {frmBarCodePrint},
  ufrmBatchCloseForDay in 'App\ufrmBatchCloseForDay.pas' {frmBatchCloseForDay},
  ufrmBatchPmdPrice in 'App\ufrmBatchPmdPrice.pas' {frmBatchPmdPrice},
  ufrmBomOrderList in 'App\ufrmBomOrderList.pas' {frmBomOrderList},
  ufrmCancelCard in 'App\ufrmCancelCard.pas' {frmCancelCard},
  ufrmCardNoInput in 'App\ufrmCardNoInput.pas' {frmCardNoInput},
  ufrmChangeDayReport in 'App\ufrmChangeDayReport.pas' {frmChangeDayReport},
  ufrmChangeLocusOrder in 'App\ufrmChangeLocusOrder.pas' {frmChangeLocusOrder},
  ufrmChangeOrder in 'App\ufrmChangeOrder.pas' {frmChangeOrder},
  ufrmChangeOrderList in 'App\ufrmChangeOrderList.pas' {frmChangeOrderList},
  ufrmCheckAudit in 'App\ufrmCheckAudit.pas' {frmCheckAudit},
  ufrmCheckOrder in 'App\ufrmCheckOrder.pas' {frmCheckOrder},
  ufrmCheckOrderList in 'App\ufrmCheckOrderList.pas' {frmCheckOrderList},
  ufrmCheckTablePrint in 'App\ufrmCheckTablePrint.pas' {frmCheckTablePrint},
  ufrmCheckTask in 'App\ufrmCheckTask.pas' {frmCheckTask},
  ufrmClearData in 'App\ufrmClearData.pas' {frmClearData},
  ufrmClient in 'App\ufrmClient.pas' {frmClient},
  ufrmClientInfo in 'App\ufrmClientInfo.pas' {frmClientInfo},
  ufrmClientSaleReport in 'App\ufrmClientSaleReport.pas' {frmClientSaleReport},
  ufrmClientSort in 'App\ufrmClientSort.pas' {frmClientSort},
  ufrmCloseForDay in 'App\ufrmCloseForDay.pas' {frmCloseForDay},
  ufrmCodeInfo in 'App\ufrmCodeInfo.pas' {frmCodeInfo},
  ufrmControlMenu in 'App\ufrmControlMenu.pas' {frmControlMenu},
  ufrmCostCalc in 'App\ufrmCostCalc.pas' {frmCostCalc},
  ufrmCustomer in 'App\ufrmCustomer.pas' {frmCustomer},
  ufrmCustomerExt in 'App\ufrmCustomerExt.pas' {frmCustomerExt: TFrame},
  ufrmCustomerInfo in 'App\ufrmCustomerInfo.pas' {frmCustomerInfo},
  ufrmDbDayReport in 'App\ufrmDbDayReport.pas' {frmDbDayReport},
  ufrmDbInLocusOrder in 'App\ufrmDbInLocusOrder.pas' {frmDbInLocusOrder},
  ufrmDbLocusOrder in 'App\ufrmDbLocusOrder.pas' {frmDbLocusOrder},
  ufrmDbOkDialog in 'App\ufrmDbOkDialog.pas' {frmDbOkDialog},
  ufrmDbOrder in 'App\ufrmDbOrder.pas' {frmDbOrder},
  ufrmDbOrderList in 'App\ufrmDbOrderList.pas' {frmDbOrderList},
  ufrmDefineReport in 'App\ufrmDefineReport.pas' {frmDefineReport},
  ufrmDefineStateInfo in 'App\ufrmDefineStateInfo.pas' {frmDefineStateInfo},
  ufrmDemandOrder in 'App\ufrmDemandOrder.pas' {frmDemandOrder},
  ufrmDemandOrderList in 'App\ufrmDemandOrderList.pas' {frmDemandOrderList},
  ufrmDeposit in 'App\ufrmDeposit.pas' {frmDeposit},
  ufrmDeptInfo in 'App\ufrmDeptInfo.pas' {frmDeptInfo},
  ufrmDeptInfoList in 'App\ufrmDeptInfoList.pas' {frmDeptInfoList},
  ufrmDeskGuide in 'App\ufrmDeskGuide.pas' {frmDeskGuide},
  ufrmDevFactory in 'App\ufrmDevFactory.pas' {frmDevFactory},
  ufrmDibsOption in 'App\ufrmDibsOption.pas' {frmDibsOption},
  ufrmDownStockOrder in 'App\ufrmDownStockOrder.pas' {frmDownStockOrder},
  ufrmDutyInfo in 'App\ufrmDutyInfo.pas' {frmDutyInfo},
  ufrmDutyInfoList in 'App\ufrmDutyInfoList.pas' {frmDutyInfoList},
  ufrmExcelFactory in 'App\ufrmExcelFactory.pas' {frmExcelFactory},
  ufrmFieldSort in 'App\ufrmFieldSort.pas' {frmFieldSort},
  ufrmFindOrder in 'App\ufrmFindOrder.pas' {frmFindOrder},
  ufrmGodsRunningReport in 'App\ufrmGodsRunningReport.pas' {frmGodsRunningReport},
  ufrmGoodsInfo in 'App\ufrmGoodsInfo.pas' {frmGoodsInfo},
  ufrmGoodsInfoList in 'App\ufrmGoodsInfoList.pas' {frmGoodsInfoList},
  ufrmGoodsMonth in 'App\ufrmGoodsMonth.pas' {frmGoodsMonth},
  ufrmGoodssort in 'App\ufrmGoodssort.pas' {frmGoodssort},
  ufrmGoodsSortTree in 'App\ufrmGoodsSortTree.pas' {frmGoodsSortTree},
  ufrmHangUpFile in 'App\ufrmHangUpFile.pas' {frmHangUpFile},
  ufrmHintMsg in 'App\ufrmHintMsg.pas' {frmHintMsg},
  ufrmHostDialog in 'App\ufrmHostDialog.pas' {frmHostDialog},
  ufrmIcInfo in 'App\ufrmIcInfo.pas' {frmIcInfo},
  ufrmIEWebForm in 'App\ufrmIEWebForm.pas' {frmIEWebForm},
  ufrmImpeach in 'App\ufrmImpeach.pas' {frmImpeach},
  ufrmInitGuide in 'App\ufrmInitGuide.pas' {frmInitGuide},
  ufrmInitialRights in 'App\ufrmInitialRights.pas' {frmInitialRights},
  ufrmInLocusOrderList in 'App\ufrmInLocusOrderList.pas' {frmInLocusOrderList},
  ufrmIntegralGlide in 'App\ufrmIntegralGlide.pas' {frmIntegralGlide},
  ufrmIntegralGlide_Add in 'App\ufrmIntegralGlide_Add.pas' {frmIntegralGlide_Add},
  ufrmInvoice in 'App\ufrmInvoice.pas' {frmInvoice},
  ufrmInvoiceInfo in 'App\ufrmInvoiceInfo.pas' {frmInvoiceInfo},
  ufrmIORODayReport in 'App\ufrmIORODayReport.pas' {frmIORODayReport},
  ufrmIoroOrder in 'App\ufrmIoroOrder.pas' {frmIoroOrder},
  ufrmIoroOrderList in 'App\ufrmIoroOrderList.pas' {frmIoroOrderList},
  ufrmJoinRelation in 'App\ufrmJoinRelation.pas' {frmJoinRelation},
  ufrmJxcTotalReport in 'App\ufrmJxcTotalReport.pas' {frmJxcTotalReport},
  ufrmLocusNoProperty in 'App\ufrmLocusNoProperty.pas' {frmLocusNoProperty},
  ufrmLossCard in 'App\ufrmLossCard.pas' {frmLossCard},
  ufrmMeaUnits in 'App\ufrmMeaUnits.pas' {frmMeaUnits},
  ufrmMessage in 'App\ufrmMessage.pas' {frmMessage},
  ufrmMessageInfo in 'App\ufrmMessageInfo.pas' {frmMessageInfo},
  ufrmN26Browser in 'App\ufrmN26Browser.pas' {frmN26Browser},
  ufrmNetLogin in 'App\ufrmNetLogin.pas' {frmNetLogin},
  ufrmNewCard in 'App\ufrmNewCard.pas' {frmNewCard},
  ufrmNewsPaperReader in 'App\ufrmNewsPaperReader.pas' {frmNewPaperReader},
  ufrmOptionDefine in 'App\ufrmOptionDefine.pas' {frmOptionDefine},
  ufrmOutLocusOrderList in 'App\ufrmOutLocusOrderList.pas' {frmOutLocusOrderList},
  ufrmPassWord in 'App\ufrmPassWord.pas' {frmPassWord},
  ufrmPayAbleReport in 'App\ufrmPayAbleReport.pas' {frmPayAbleReport},
  ufrmPayDayReport in 'App\ufrmPayDayReport.pas' {frmPayDayReport},
  ufrmPayOrder in 'App\ufrmPayOrder.pas' {frmPayOrder},
  ufrmPayOrderList in 'App\ufrmPayOrderList.pas' {frmPayOrderList},
  ufrmPosMain in 'App\ufrmPosMain.pas' {frmPosMain},
  ufrmPosMainList in 'App\ufrmPosMainList.pas' {frmPosMainList},
  ufrmPosMenu in 'App\ufrmPosMenu.pas' {frmPosMenu},
  ufrmPosPrice in 'App\ufrmPosPrice.pas' {frmPosPrice},
  ufrmPotenAnaly in 'App\ufrmPotenAnaly.pas' {frmPotenAnaly: TFrame},
  ufrmPrcCompList in 'App\ufrmPrcCompList.pas' {frmPrcCompList},
  ufrmPriceGradeInfo in 'App\ufrmPriceGradeInfo.pas' {frmPriceGradeInfo},
  ufrmPriceOrder in 'App\ufrmPriceOrder.pas' {frmPriceOrder},
  ufrmPriceOrderList in 'App\ufrmPriceOrderList.pas' {frmPriceOrderList},
  ufrmProfitAnaly in 'App\ufrmProfitAnaly.pas' {frmProfitAnaly: TFrame},
  ufrmPublishMessage in 'App\ufrmPublishMessage.pas' {frmPublishMessage},
  ufrmQuestionnaire in 'App\ufrmQuestionnaire.pas' {frmQuestionnaire},
  ufrmRckDayReport in 'App\ufrmRckDayReport.pas' {frmRckDayReport},
  ufrmRckMng in 'App\ufrmRckMng.pas' {frmRckMng},
  ufrmRecvAbleReport in 'App\ufrmRecvAbleReport.pas' {frmRecvAbleReport},
  ufrmRecvDayReport in 'App\ufrmRecvDayReport.pas' {frmRecvDayReport},
  ufrmRecvOrder in 'App\ufrmRecvOrder.pas' {frmRecvOrder},
  ufrmRecvOrderList in 'App\ufrmRecvOrderList.pas' {frmRecvOrderList},
  ufrmRecvPosList in 'App\ufrmRecvPosList.pas' {frmRecvPosList},
  ufrmRecvPosOrder in 'App\ufrmRecvPosOrder.pas' {frmRecvPosOrder},
  ufrmRelation in 'App\ufrmRelation.pas' {frmRelation},
  ufrmRelationHandSet in 'App\ufrmRelationHandSet.pas' {frmRelationHandSet},
  ufrmRelationInfo in 'App\ufrmRelationInfo.pas' {frmRelationInfo},
  ufrmRelationUpdateMode in 'App\ufrmRelationUpdateMode.pas' {frmRelationUpdateMode},
  ufrmReturn in 'App\ufrmReturn.pas' {frmReturn},
  ufrmRoleInfo in 'App\ufrmRoleInfo.pas' {frmRoleInfo},
  ufrmRoleInfoList in 'App\ufrmRoleInfoList.pas' {frmRoleInfoList},
  ufrmRoleRights in 'App\ufrmRoleRights.pas' {frmRoleRights},
  ufrmSaleAnaly in 'App\ufrmSaleAnaly.pas' {frmSaleAnaly},
  ufrmSaleDayReport in 'App\ufrmSaleDayReport.pas' {frmSaleDayReport},
  ufrmSaleManSaleReport in 'App\ufrmSaleManSaleReport.pas' {frmSaleManSaleReport},
  ufrmSaleMonthTotalReport in 'App\ufrmSaleMonthTotalReport.pas' {frmSaleMonthTotalReport},
  ufrmSalesOrder in 'App\ufrmSalesOrder.pas' {frmSalesOrder},
  ufrmSalesOrderList in 'App\ufrmSalesOrderList.pas' {frmSalesOrderList},
  ufrmSaleTotalReport in 'App\ufrmSaleTotalReport.pas' {frmSaleTotalReport},
  ufrmSalIndentOrder in 'App\ufrmSalIndentOrder.pas' {frmSalIndentOrder},
  ufrmSalIndentOrderList in 'App\ufrmSalIndentOrderList.pas' {frmSalIndentOrderList},
  ufrmSalLocusOrder in 'App\ufrmSalLocusOrder.pas' {frmSalLocusOrder},
  ufrmSalRetuLocusOrder in 'App\ufrmSalRetuLocusOrder.pas' {frmSalRetuLocusOrder},
  ufrmSalRetuOrder in 'App\ufrmSalRetuOrder.pas' {frmSalRetuOrder},
  ufrmSalRetuOrderList in 'App\ufrmSalRetuOrderList.pas' {frmSalRetuOrderList},
  ufrmSelectCheckGoods in 'App\ufrmSelectCheckGoods.pas' {frmSelectCheckGoods},
  ufrmSelectGoodSort in 'App\ufrmSelectGoodSort.pas' {frmSelectGoodSort},
  ufrmShopInfo in 'App\ufrmShopInfo.pas' {frmShopInfo},
  ufrmShopInfoList in 'App\ufrmShopInfoList.pas' {frmShopInfoList},
  ufrmShowDibs in 'App\ufrmShowDibs.pas' {frmShowDibs},
  ufrmStgTotalReport in 'App\ufrmStgTotalReport.pas' {frmStgTotalReport},
  ufrmStkIndentOrder in 'App\ufrmStkIndentOrder.pas' {frmStkIndentOrder},
  ufrmStkIndentOrderList in 'App\ufrmStkIndentOrderList.pas' {frmStkIndentOrderList},
  ufrmStkLocusOrder in 'App\ufrmStkLocusOrder.pas' {frmStkLocusOrder},
  ufrmStkRetuLocusOrder in 'App\ufrmStkRetuLocusOrder.pas' {frmStkRetuLocusOrder},
  ufrmStkRetuOrder in 'App\ufrmStkRetuOrder.pas' {frmStkRetuOrder},
  ufrmStkRetuOrderList in 'App\ufrmStkRetuOrderList.pas' {frmStkRetuOrderList},
  ufrmStockDayReport in 'App\ufrmStockDayReport.pas' {frmStockDayReport},
  ufrmStockOrder in 'App\ufrmStockOrder.pas' {frmStockOrder},
  ufrmStockOrderList in 'App\ufrmStockOrderList.pas' {frmStockOrderList},
  ufrmStockTotalReport in 'App\ufrmStockTotalReport.pas' {frmStockTotalReport},
  ufrmStorageDayReport in 'App\ufrmStorageDayReport.pas' {frmStorageDayReport},
  ufrmStorageTracking in 'App\ufrmStorageTracking.pas' {frmStorageTracking},
  ufrmSupplier in 'App\ufrmSupplier.pas' {frmSupplier},
  ufrmSupplierInfo in 'App\ufrmSupplierInfo.pas' {frmSupplierInfo},
  ufrmSysDefine in 'App\ufrmSysDefine.pas' {frmSysDefine},
  ufrmTenant in 'App\ufrmTenant.pas' {frmTenant},
  ufrmTenantInfo in 'App\ufrmTenantInfo.pas' {frmTenantInfo},
  ufrmTicketPrint in 'App\ufrmTicketPrint.pas' {frmTicketPrint},
  ufrmTransOrder in 'App\ufrmTransOrder.pas' {frmTransOrder},
  ufrmTransOrderList in 'App\ufrmTransOrderList.pas' {frmTransOrderList},
  ufrmUserRights in 'App\ufrmUserRights.pas' {frmUserRights},
  ufrmUsers in 'App\ufrmUsers.pas' {frmUsers},
  ufrmUsersInfo in 'App\ufrmUsersInfo.pas' {frmUsersInfo},
  uGodsFactory in 'App\uGodsFactory.pas',
  uPrainpowerJudge in 'App\uPrainpowerJudge.pas',
  uReportFactory in 'App\uReportFactory.pas',
  uSyncThread in 'App\uSyncThread.pas',
  uTimerFactory in 'App\uTimerFactory.pas',
  ObjAccount in 'Obj\ObjAccount.pas',
  ObjChangeOrder in 'Obj\ObjChangeOrder.pas',
  ObjClient in 'Obj\ObjClient.pas',
  ObjCloseForDay in 'Obj\ObjCloseForDay.pas',
  ObjCodeInfo in 'Obj\ObjCodeInfo.pas',
  ObjCustomer in 'Obj\ObjCustomer.pas',
  ObjDbOrder in 'Obj\ObjDbOrder.pas',
  ObjDefineGodsState in 'Obj\ObjDefineGodsState.pas',
  ObjDefineReport in 'Obj\ObjDefineReport.pas',
  ObjDemandOrder in 'Obj\ObjDemandOrder.pas',
  ObjDeptInfo in 'Obj\ObjDeptInfo.pas',
  ObjDutyInfo in 'Obj\ObjDutyInfo.pas',
  ObjGetPrice in 'Obj\ObjGetPrice.pas',
  ObjGoodsInfo in 'Obj\ObjGoodsInfo.pas',
  objGoodsMonth in 'Obj\objGoodsMonth.pas',
  ObjGoodsSort in 'Obj\ObjGoodsSort.pas',
  objHandSetRelation in 'Obj\objHandSetRelation.pas',
  ObjImpeach in 'Obj\ObjImpeach.pas',
  ObjInvoice in 'Obj\ObjInvoice.pas',
  ObjIoroOrder in 'Obj\ObjIoroOrder.pas',
  ObjMeaUnits in 'Obj\ObjMeaUnits.pas',
  objMessage in 'Obj\objMessage.pas',
  ObjPayOrder in 'Obj\ObjPayOrder.pas',
  ObjPRICEGRADEInfo in 'Obj\ObjPriceGradeInfo.pas',
  ObjPriceOrder in 'Obj\ObjPriceOrder.pas',
  ObjPrintOrder in 'Obj\ObjPrintOrder.pas',
  ObjQuestionnaire in 'Obj\ObjQuestionnaire.pas',
  ObjRecvOrder in 'Obj\ObjRecvOrder.pas',
  objRelation in 'Obj\objRelation.pas',
  ObjRoleInfo in 'Obj\ObjRoleInfo.pas',
  ObjRoleRights in 'Obj\ObjRoleRights.pas',
  ObjSalesOrder in 'Obj\ObjSalesOrder.pas',
  ObjSalIndentOrder in 'Obj\ObjSalIndentOrder.pas',
  ObjSalRetuOrder in 'Obj\ObjSalRetuOrder.pas',
  ObjShop in 'Obj\ObjShop.pas',
  ObjStkIndentOrder in 'Obj\ObjStkIndentOrder.pas',
  ObjStkRetuOrder in 'Obj\ObjStkRetuOrder.pas',
  ObjStockOrder in 'Obj\ObjStockOrder.pas',
  ObjSupplier in 'Obj\ObjSupplier.pas',
  ObjSysDefine in 'Obj\ObjSysDefine.pas',
  ObjTransOrder in 'Obj\ObjTransOrder.pas',
  ObjUserRights in 'Obj\ObjUserRights.pas',
  ObjUsers in 'Obj\ObjUsers.pas',
  uframeBaseAnaly in 'Frame\uframeBaseAnaly.pas' {frameBaseAnaly},
  uframeBaseReport in 'Frame\uframeBaseReport.pas' {frameBaseReport},
  uframeDialogForm in 'Frame\uframeDialogForm.pas' {frameDialogForm},
  uframeDialogProperty in 'Frame\uframeDialogProperty.pas' {frameDialogProperty},
  uframeFindDialog in 'Frame\uframeFindDialog.pas' {frameFindDialog},
  uframeListDialog in 'Frame\uframeListDialog.pas' {frameListDialog},
  uframeMDForm in 'Frame\uframeMDForm.pas' {frameMDForm},
  uframeOrderForm in 'Frame\uframeOrderForm.pas' {frameOrderForm},
  uframeOrderToolForm in 'Frame\uframeOrderToolForm.pas' {frameOrderToolForm},
  uframeSelectCompany in 'Frame\uframeSelectCompany.pas' {frameSelectCompany},
  uframeSelectCustomer in 'Frame\uframeSelectCustomer.pas' {frameSelectCustomer},
  uframeSelectGoods in 'Frame\uframeSelectGoods.pas' {frameSelectGoods},
  uframeToolForm in 'Frame\uframeToolForm.pas' {frameToolForm},
  uframeTreeFindDialog in 'Frame\uframeTreeFindDialog.pas' {frameTreeFindDialog},
  uShopUtil in 'Frame\uShopUtil.pas',
  uXDictFactory in 'Frame\uXDictFactory.pas',
  uDownByHttp in 'Update\uDownByHttp.pas',
  ufrmInstall in 'Update\ufrmInstall.pas' {frmInstall},
  uMMServer in 'MM\uMMServer.pas',
  uMMUtil in 'MM\uMMUtil.pas',
  ufrmMMFindBox in 'MM\ufrmMMFindBox.pas' {frmMMFindBox},
  ufrmMMBrowser in 'App\ufrmMMBrowser.pas' {frmMMBrowser},
  udmIcon in '..\..\Basic\udmIcon.pas' {dmIcon: TDataModule},
  ufrmMMToolBox in 'MM\ufrmMMToolBox.pas' {frmMMToolBox},
  SHDocVw in '..\..\Pub\SHDocVw.pas';

{$R *.res}

begin
  Application.Initialize;
  DBVersion := '1.0.2.1';
  Application.ShowMainForm := false;
  Application.Title := 'MM2011';
  Application.CreateForm(TmmGlobal, mmGlobal);
  Application.CreateForm(TdmIcon, dmIcon);
  Application.CreateForm(TfrmMMMain, frmMMMain);
  Application.CreateForm(TfrmMMDesk, frmMMDesk);
  Application.CreateForm(TfrmMMList, frmMMList);
  if not MMServer.MMExists then
     PostMessage(frmMMMain.Handle,MM_LOGIN,0,0);
  Application.Run;
end.
