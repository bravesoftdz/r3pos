program RSPScktSrvr;

uses
  SvcMgr,
  Forms,
  Windows,
  SysUtils,
  WinSvc,
  ScktCnst,
  uSrvrMain in 'uSrvrMain.pas' {SocketForm};

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
