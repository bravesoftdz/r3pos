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
  ObjRecvOrder in '..\Shop5\Obj\ObjRecvOrder.pas',
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
  ObjSyncFactory in '..\Shop5\Obj\ObjSyncFactory.pas';

{$R *.res}

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
    Svc := OpenService(Mgr, PChar('ADOScktSrvr'), SERVICE_ALL_ACCESS);
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

begin
  if not Installing then
  begin
    CreateMutex(nil, True, 'ADOSCKTSRVR');
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      MessageBox(0, PChar(SAlreadyRunning), SApplicationName, MB_ICONERROR);
      Halt;
    end;
  end;
  if Installing or StartService then
  begin
    SvcMgr.Application.Initialize;
    SvcMgr.Application.Title := '数据访问服务组件(DAS)';
    SocketService := TSocketService.CreateNew(SvcMgr.Application, 0);
    SvcMgr.Application.CreateForm(TSocketForm, SocketForm);
  SvcMgr.Application.Run;
  end else
  begin
    Forms.Application.Initialize;
    SocketService := nil;
    Forms.Application.ShowMainForm := False;
    Forms.Application.Title := '数据访问服务组件(DAS)';
    Forms.Application.CreateForm(TSocketForm, SocketForm);
    SocketForm.Initialize(False);
    Forms.Application.Run;
  end;
end.
