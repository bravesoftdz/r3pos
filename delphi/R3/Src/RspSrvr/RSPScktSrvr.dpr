program RSPScktSrvr;

uses
  SvcMgr,
  Forms,
  Windows,
  SysUtils,
  WinSvc,
  ScktCnst,
  uSrvrMain in 'uSrvrMain.pas' {SocketForm},
  ufrmDbSetup in '..\..\Basic\ufrmDbSetup.pas' {frmDBSetup},
  ObjAccount in '..\Shop5\Obj\ObjAccount.pas',
  ObjChangeOrder in '..\Shop5\Obj\ObjChangeOrder.pas',
  ObjClient in '..\Shop5\Obj\ObjClient.pas',
  ObjCloseForDay in '..\Shop5\Obj\ObjCloseForDay.pas',
  ObjCodeInfo in '..\Shop5\Obj\ObjCodeInfo.pas',
  ObjCommon in '..\Shop5\Obj\ObjCommon.pas',
  ObjCustomer in '..\Shop5\Obj\ObjCustomer.pas',
  ObjDbOrder in '..\Shop5\Obj\ObjDbOrder.pas',
  ObjDeptInfo in '..\Shop5\Obj\ObjDeptInfo.pas',
  ObjDutyInfo in '..\Shop5\Obj\ObjDutyInfo.pas',
  ObjGetPrice in '..\Shop5\Obj\ObjGetPrice.pas',
  ObjGoodsInfo in '..\Shop5\Obj\ObjGoodsInfo.pas',
  ObjGoodsSort in '..\Shop5\Obj\ObjGoodsSort.pas',
  ObjInvoice in '..\Shop5\Obj\ObjInvoice.pas',
  ObjIoroOrder in '..\Shop5\Obj\ObjIoroOrder.pas',
  ObjMeaUnits in '..\Shop5\Obj\ObjMeaUnits.pas',
  ObjPayOrder in '..\Shop5\Obj\ObjPayOrder.pas',
  ObjPRICEGRADEInfo in '..\Shop5\Obj\ObjPriceGradeInfo.pas',
  ObjPriceOrder in '..\Shop5\Obj\ObjPriceOrder.pas',
  ObjPrintOrder in '..\Shop5\Obj\ObjPrintOrder.pas',
  ObjBondOrder in '..\Shop5\Obj\ObjBondOrder.pas',
  ObjRoleInfo in '..\Shop5\Obj\ObjRoleInfo.pas',
  ObjRoleRights in '..\Shop5\Obj\ObjRoleRights.pas',
  ObjSalesOrder in '..\Shop5\Obj\ObjSalesOrder.pas',
  ObjSalIndentOrder in '..\Shop5\Obj\ObjSalIndentOrder.pas',
  ObjSalRetuOrder in '..\Shop5\Obj\ObjSalRetuOrder.pas',
  ObjShop in '..\Shop5\Obj\ObjShop.pas',
  ObjStkIndentOrder in '..\Shop5\Obj\ObjStkIndentOrder.pas',
  ObjStkRetuOrder in '..\Shop5\Obj\ObjStkRetuOrder.pas',
  ObjStockOrder in '..\Shop5\Obj\ObjStockOrder.pas',
  ObjSupplier in '..\Shop5\Obj\ObjSupplier.pas',
  ObjSysDefine in '..\Shop5\Obj\ObjSysDefine.pas',
  ObjTenant in '..\Shop5\Obj\ObjTenant.pas',
  ObjTransOrder in '..\Shop5\Obj\ObjTransOrder.pas',
  ObjUserRights in '..\Shop5\Obj\ObjUserRights.pas',
  ObjUsers in '..\Shop5\Obj\ObjUsers.pas',
  objRelation in '..\Shop5\Obj\objRelation.pas',
  ObjSyncFactory in '..\Shop5\Obj\ObjSyncFactory.pas',
  uTask in 'uTask.pas',
  ZPlugIn in '..\..\zLib\src\zLib\ZPlugIn.pas',
  ufrmTimer in 'ufrmTimer.pas' {frmTimer},
  TrayDesktop in 'TrayDesktop.pas',
  objMessage in '..\Shop5\Obj\objMessage.pas',
  objSyncRelation in '..\PlugIn\obj\objSyncRelation.pas',
  ObjImpeach in '..\Shop5\Obj\ObjImpeach.pas',
  ObjQuestionnaire in '..\Shop5\Obj\ObjQuestionnaire.pas',
  objDownOrder in '..\PlugIn\obj\objDownOrder.pas',
  ObjSyncMessage in '..\PlugIn\obj\ObjSyncMessage.pas',
  ObjDefineGodsState in '..\Shop5\Obj\ObjDefineGodsState.pas',
  ObjDefineReport in '..\Shop5\Obj\ObjDefineReport.pas',
  objHandSetRelation in '..\Shop5\Obj\objHandSetRelation.pas',
  ObjDemandOrder in '..\Shop5\Obj\ObjDemandOrder.pas',
  objGoodsMonth in '..\Shop5\Obj\objGoodsMonth.pas',
  objPlugInSyncData in '..\PlugIn\obj\objPlugInSyncData.pas',
  objCaFactory in 'obj\objCaFactory.pas',
  ObjChatInfo in '..\Shop5\Obj\ObjChatInfo.pas',
  ObjKpiIndex in '..\Shop5\Obj\ObjKpiIndex.pas',
  ObjMktKpiResult in '..\Shop5\Obj\ObjMktKpiResult.pas',
  ObjMktPlanOrder in '..\Shop5\Obj\ObjMktPlanOrder.pas',
  ObjMktRequOrder in '..\Shop5\Obj\ObjMktRequOrder.pas',
  ObjMktTaskOrder in '..\Shop5\Obj\ObjMktTaskOrder.pas',
  ObjRecvOrder in '..\Shop5\Obj\ObjRecvOrder.pas',
  ObjCostCalc in '..\Shop5\Obj\ObjCostCalc.pas',
  ZRCtrls in '..\..\zLib\src\zLib\ZRCtrls.pas',
  ObjBomOrder in '..\Shop5\Obj\ObjBomOrder.pas',
  ObjInvoiceOrder in '..\Shop5\Obj\ObjInvoiceOrder.pas',
  ObjMktActiveList in '..\Shop5\Obj\ObjMktActiveList.pas',
  ObjNoteBook in '..\Shop5\Obj\ObjNoteBook.pas',
  ObjMktBudgOrder in '..\Shop5\Obj\ObjMktBudgOrder.pas',
  ObjMktAtthOrder in '..\Shop5\Obj\ObjMktAtthOrder.pas',
  ObjMktPlanOrder3 in '..\Shop5\Obj\ObjMktPlanOrder3.pas',
  ObjStkInvoiceOrder in '..\Shop5\Obj\ObjStkInvoiceOrder.pas',
  ObjVoucherOrder in '..\Shop5\Obj\ObjVoucherOrder.pas',
  ObjMktKpiModify in '..\Shop5\Obj\ObjMktKpiModify.pas',
  ObjFvchFrame in '..\Shop5\Obj\ObjFvchFrame.pas',
  ObjFvchIntfSet in '..\Shop5\Obj\ObjFvchIntfSet.pas',
  ObjFvchOrder in '..\Shop5\Obj\ObjFvchOrder.pas',
  ObjFvchPosting in '..\Shop5\Obj\ObjFvchPosting.pas',
  ObjSvcServiceInfo in '..\Shop5\Obj\ObjSvcServiceInfo.pas',
  ObjVhLeadOrder in '..\Shop5\Obj\ObjVhLeadOrder.pas',
  ObjVhPayGlide in '..\Shop5\Obj\ObjVhPayGlide.pas',
  ObjVhSendOrder in '..\Shop5\Obj\ObjVhSendOrder.pas',
  ObjColorInfo in '..\Shop5\Obj\ObjColorInfo.pas',
  ObjLocationInfo in '..\Shop5\Obj\ObjLocationInfo.pas',
  ObjSizeInfo in '..\Shop5\Obj\ObjSizeInfo.pas';

{$R *.res}
//{$R JclCommCtrlAdmin.RES}

function Installing: Boolean;
begin
  Result := FindCmdLineSwitch('INSTALL',['-','\','/'], True) or
            FindCmdLineSwitch('UNINSTALL',['-','\','/'], True);
end;

function StartService: Boolean;
var
  Mgr, Svc: Integer;
  UserName, ServiceStartName: string;
  Config: Pointer;
  Size: DWord;
begin
  Result := False;
  Mgr := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if Mgr <> 0 then
  begin
    Svc := OpenService(Mgr, PChar('RSPScktSrvr'), SERVICE_ALL_ACCESS);
    Result := Svc <> 0;
    if Result then
    begin
      QueryServiceConfig(Svc, nil, 0, Size);
      Config := AllocMem(Size);
      try
        QueryServiceConfig(Svc, Config, Size, Size);
        ServiceStartName := PQueryServiceConfig(Config)^.lpServiceStartName;
        if CompareText(ServiceStartName, 'LocalSystem') = 0 then
           ServiceStartName := 'SYSTEM';
      finally
        Dispose(Config);
      end;
      CloseServiceHandle(Svc);
    end;
    CloseServiceHandle(Mgr);
  end;
  if Result then
  begin
    Size := 256;
    SetLength(UserName, Size);
    GetUserName(PChar(UserName), Size);
    SetLength(UserName, StrLen(PChar(UserName)));
    Result := CompareText(UserName, ServiceStartName) = 0;
  end;
end;
var FromService:boolean;
begin
  FromService := StartService;
  if not Installing and not FromService then
  begin
    CreateMutex(nil, True, 'RSPSCKTSRVR');
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      MessageBox(0, PChar('RSP Socket Service 已经运行，不能重复执行.'), SApplicationName, MB_ICONERROR);
      Halt;
      Exit;
    end;
  end;
  if Installing or FromService then
  begin
    SvcMgr.Application.Initialize;
    SvcMgr.Application.Title := '通讯服务器';
    SocketService := TSocketService.CreateNew(SvcMgr.Application, 0);
    SvcMgr.Application.CreateForm(TSocketForm, SocketForm);
  SvcMgr.Application.Run;
  end else
  begin
    Forms.Application.Initialize;
    SocketService := nil;
    Forms.Application.Title := '通讯服务器';
    Forms.Application.CreateForm(TSocketForm, SocketForm);
    SocketForm.Initialize(False);
    Forms.Application.Run;
  end;
end.
