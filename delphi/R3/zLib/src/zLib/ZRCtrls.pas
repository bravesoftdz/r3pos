{==  服务端控制功能  ==}

unit ZRCtrls;

interface

uses
  Windows,SysUtils,zBase,Variants,Classes,Forms,DB,ZIntf,ZDataset,IniFiles,
  ZdbHelp,ObjCommon,ZDbcCache,ZDbcIntfs,Math,WinSvc,ZServer,ZConst,ZIocp,
  ScktCnst;

type
  TSrvrCtrl=class
  public
    class function GetPath: string;
    //判断管理模块是否运行
    class function CheckSvcMgrRun(InstCode: string=''): Boolean;
    //读取Ini文件
    class function ReadIniFile(FileName,Section,Ident: string): string;
    //读取Ini文件
    class function ReadIniFileInt(FileName,Section,Ident: string): integer;
    //读取Ini文件
    class function ReadIniFileBool(FileName,Section,Ident: string): Boolean;
    //写入Ini文件
    class function WriteIniFile(FileName,Section,Ident,Value: string): Boolean;
    //写入Ini文件
    class function WriteIniFileInt(FileName,Section,Ident: string; Value: integer): Boolean;
    //写入Ini文件
    class function WriteIniFileBool(FileName,Section,Ident: string; Value: Boolean): Boolean;
    //读取Ini文件Section:
    class function ReadIniFileSection(FileName: string;var Section: TStringList): Boolean;
    //删除Ini文件Section:
    class function DeleteIniFileSection(FileName,Section: string): Boolean;
    //返回字符值
    class function GetParamValue(var LStr: string; CodeStr,FlagStr: string): string;
    class function GetParamValueInt(var LStr: string; CodeStr,FlagStr: string): integer;
  end;

  {==服务管理: DoTaskCmd:(0:查询服务;1:启用服务;2:停止服务;3:重启Ado服务); ==}
  TSrvrService=class(TZFactory)
  private
    { Cmd：外部控制台程序文件名，包含路径;
      ExitCode：程序执行状态代码，如果成功，返回 0 ，否则非 0;
      ErrMessage：执行出现错误时返回错误信息;
      OutMessage：控制台输出信息  }
    procedure RunCmdLine(const Cmd: String; var ExitCode: DWORD; var ErrMessage, OutMessage: String);
  public
    //查询服务
    function QueryService(AServName: string): integer;
    //停止服务
    function StopService(AServName: string): Boolean;
    //重启动服务
    function ReStartService(AServName: string): Boolean;
    //根据客户端传入参数值：执行相应指令
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  {==服务Socket连接参数==}
  TSrvrPortInfo=class(TZFactory)
  private
    DoTaskIdx: integer;
    function CheckSrvrPort:Boolean;     //判断端口是否占用
    function OpenSrvrPortList: Boolean; //返回SrvrPortList
    function SaveSrvrPortList: Boolean; //保存SrvrPortList
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  {==连接状态: DoTaskCmd:(0:查询数据库连接); ==}
  TSrvrDBConnetion=class(TZFactory)
  private
    DoTaskIdx: integer;
    FDBList: TStringList;
    function OpenDBList: Boolean;  //打开返回DBList
    function CheckDBConnect: Boolean;  //保存连接DBList
    function SaveDBList: Boolean;  //保存连接DBList
  public
    constructor Create(ADataSet: TDataSet);override;
    destructor  Destroy;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  {==连接状态: DoTaskCmd:(0:查询数据库和客户端连接;1:查询数据库连接;2:查询客户端连接;3:断开客户端连接); ==}
  TClientConnetion=class(TZFactory)
  private
    DoTaskIdx: integer;
    //根据客户端传入参数值：执行相应指令
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
    //正常刷新数据(返回客户端连接List)
    function OpenClientConnectionList: Boolean;
    //移除客户端连接
    function RemoveClientConnected: Boolean;  
  public
    //插入之前处理保存文件内容
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {==插件调度参数==}
  TSrvrPlugInInfo=class(TZFactory)
  private
    FIsFlag: integer;  //运行标记位
    //根据客户端传入参数值：执行相应指令
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
    function BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //初始化类
    procedure InitClass; override;
  end;
  

  {==任务管理: DoTaskCmd:(0:刷新查询任务列表;1:设置任务列表参数;2:调度执行任务列表) ==}
  TSrvrTask=class(TZFactory)
  private
    //根据客户端传入参数值：执行相应指令
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {==日志管理: DoTaskCmd:(0:刷新查询日志面板列表;1:查询历史文件日志;) ==}
  TSrvrLog=class(TZFactory)
  private
    //根据客户端传入参数值：执行相应指令
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {===========远程执行===========}
  //远程调度任务(DoTaskCmd):
  // 1、插件任务(1..10); 2、插件参数(11..20); 3、
  TRemoteTask=class(TZProcFactory)
  private
    //插件
    function Plug_AddTask(AGlobal:IdbHelp; Params:TftParamList): Boolean; //立即执行插件
    function Plug_SaveTask(Params:TftParamList): Boolean;  //插件调度参数设置
    //参数
    function Params_CheckPortDispatcher(Params:TftParamList): Boolean; //检查端口是否正常
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;




implementation

uses
  ZLogFile,EncDec;

{ TSrvrCtrl }

class function TSrvrCtrl.CheckSvcMgrRun(InstCode: string): Boolean;
var
  StrCode: string;
  MutHandle: THandle;
begin
  result:=False;
  try
    StrCode:=InstCode;
    if StrCode='' then StrCode:='{A16ABE7C-AEEA-4BAB-B2E0-DB9D097D5E9B}';
    MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, Pchar(StrCode));
    if MutHandle = 0 then
    begin
      //不存在则调用运行:SvcMgr.exe
      StrCode:=TSrvrCtrl.GetPath+'SvcMgr.exe';
      if FileExists(StrCode) then
        WINEXEC(pChar(StrCode), SW_NORMAL);
    end;
    MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, Pchar(StrCode));
    result:=(MutHandle>0);  //已在运行
  except
  end;
end;

class function TSrvrCtrl.DeleteIniFileSection(FileName,Section: string): Boolean;
var
  F:TIniFile;
begin
  F := TIniFile.Create(FileName);
  try
    F.EraseSection(Section);
  finally
    F.Free;
  end;
end;

class function TSrvrCtrl.GetPath: string;
begin
  result:=trim(ExtractFilePath(ParamStr(0)));
end;

class function TSrvrCtrl.ReadIniFile(FileName, Section, Ident: string): string;
var
  F:TIniFile;
begin
  result:='';
  F := TIniFile.Create(FileName);
  try
    result := F.ReadString(Section,Ident,'');
  finally
    F.Free;
  end;
end;

class function TSrvrCtrl.ReadIniFileInt(FileName, Section,Ident: string): integer;
var
  F:TIniFile;
begin
  result:=0;
  F := TIniFile.Create(FileName);
  try
    result := F.ReadInteger(Section,Ident,0);
  finally
    F.Free;
  end;
end;

class function TSrvrCtrl.ReadIniFileBool(FileName, Section, Ident: string): Boolean;
var
  F:TIniFile;
begin
  result:=False;
  F := TIniFile.Create(FileName);
  try
    result := F.ReadBool(Section,Ident,False);
  finally
    F.Free;
  end;
end;

class function TSrvrCtrl.ReadIniFileSection(FileName: string; var Section: TStringList): Boolean;
var
  F:TIniFile;
begin
  result:=False;
  F := TIniFile.Create(FileName);
  try
    F.ReadSections(Section);
    result:=true;
  finally
    F.Free;
  end;
end;

class function TSrvrCtrl.WriteIniFile(FileName, Section, Ident, Value: string): Boolean;
var
  F:TIniFile;
begin
  F := TIniFile.Create(FileName);
  try
    F.WriteString(Section, Ident, Value);
  finally
    F.Free;
  end;
end;

class function TSrvrCtrl.WriteIniFileInt(FileName, Section, Ident: string; Value: integer): Boolean;
var
  F:TIniFile;
begin
  F := TIniFile.Create(FileName);
  try
    F.WriteInteger(Section, Ident, Value);
  finally
    F.Free;
  end;
end;

class function TSrvrCtrl.WriteIniFileBool(FileName, Section, Ident: string; Value: Boolean): Boolean;
var
  F:TIniFile;
begin
  F := TIniFile.Create(FileName);
  try
    F.WriteBool(Section, Ident, Value);
  finally
    F.Free;
  end;
end;

class function TSrvrCtrl.GetParamValue(var LStr: string; CodeStr, FlagStr: string): string;
var
  Idx1,Idx2,vLen: integer;
begin
  Idx1:=Pos(CodeStr,LStr)+1;
  Idx2:=Pos(FlagStr,LStr);
  if (Idx1>0) and (Idx2>0) and (Idx2>Idx1)then
  begin
    result:=Copy(LStr,Idx1,Idx2-Idx1+1);
    LStr:=Copy(LStr,Idx2+1,length(LStr));
  end;
end;

class function TSrvrCtrl.GetParamValueInt(var LStr: string; CodeStr, FlagStr: string): integer;
var
  Idx1,Idx2,vLen: integer;
begin
  Idx1:=Pos(CodeStr,LStr)+1;
  Idx2:=Pos(FlagStr,LStr);
  if (Idx1>0) and (Idx2>0) and (Idx2>Idx1)then
  begin
    result:=StrtoIntDef(Copy(LStr,Idx1,Idx2-Idx1+1),0);
    LStr:=Copy(LStr,Idx2+1,length(LStr));
  end;
end;

{ TSrvrService }

function TSrvrService.QueryService(AServName: string): integer;
var
  SvcStatus: TServiceStatus;
  SCManager, hService: SC_HANDLE; 
begin
  result:=-1;
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if SCManager <> 0 then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_QUERY_STATUS);
    if hService <> 0 then
    begin
      try
        //停止并卸载服务;
        QueryServiceStatus(hService,SvcStatus);
        result:=SvcStatus.dwCurrentState; {SERVICE_STOPPED: 停止; SERVICE_RUNNING: 运行}
      finally
        CloseServiceHandle(hService);
      end;
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

function TSrvrService.StopService(AServName: string): Boolean;
var
  RunFlag: Boolean;
  SvcStatus: TServiceStatus;
  SCManager, hService: SC_HANDLE;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_ALL_ACCESS);
    Result := hService <> 0;
    if Result then
    try
      //停止并卸载服务;
      Result := ControlService(hService, SERVICE_CONTROL_STOP, SvcStatus);
      //删除服务，这一句可以不要;
      //DeleteService(hService);
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

function TSrvrService.ReStartService(AServName: string): Boolean;
var
  PathDir: string;
  ExitCode: DWORD;
  CmdList: TStringList;
  ErrMessage, OutMessage: String;
begin
  result:=False;
  PathDir:=ExtractFilePath(Application.ExeName);
  try
    CmdList:=TStringList.Create;
    CmdList.Clear;
    CmdList.Add('net stop '+AServName);
    CmdList.Add('net start '+AServName);
    CmdList.Add('exit ');
    CmdList.SaveToFile(PathDir+'ReStartService.bat');
    RunCmdLine('cmd '+PathDir+'ReStartService.bat', ExitCode, ErrMessage, OutMessage);
    result:=(ExitCode=0); //执行错误
  finally
    FreeAndNil(CmdList);
  end;
end;

function TSrvrService.DoTaskCommand(ObjectFactory: IdbHelp): integer;
var
  ReRun: Boolean;
  DoTaskIdx: integer;
begin
  result:=-1;
  if Params.FindParam('DoTaskCmd')<>nil then
  begin
    DoTaskIdx:=StrToIntDef(Params.FindParam('DoTaskCmd').AsString,0);
    case DoTaskIdx of
     0: result:=QueryService('RSPScktSrvr');
     2:
      begin
        ReRun:=StopService('RSPScktSrvr');
        if ReRun then result:=1;
      end;
     3:
      begin
        ReRun:=ReStartService('RSPScktSrvr');
        if ReRun then result:=1;
      end;
    end;
  end;
end;

function TSrvrService.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Rs: TZQuery;
  vPercent: integer;
  SrvrState: integer;
begin
  //执行后台指令
  SrvrState:=DoTaskCommand(AGlobal);
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('DoTaskCmd',ftInteger,0,true);  //指令类型
  Rs.FieldDefs.Add('SrvrState',ftInteger,0,true);  //指令执行返回值
  //线程数:
  Rs.FieldDefs.Add('WorkThreadCount',ftInteger,0,False);     //工作线程数
  Rs.FieldDefs.Add('ExecThreadCount',ftInteger,0,False);     //执行线程数
  Rs.FieldDefs.Add('MaxThreadCount',ftInteger,0,False);      //最大线程数
  Rs.FieldDefs.Add('WorkPercent',ftInteger,0,False);         //执行效率值
  //连接数
  Rs.FieldDefs.Add('ConnCacheCount',ftInteger,0,False);      //缓冲连接数
  Rs.FieldDefs.Add('ConnCacheLockCount',ftInteger,0,False);  //锁定连接数
  Rs.FieldDefs.Add('ConnCacheWaitCount',ftInteger,0,False);  //等待指令数
  Rs.FieldDefs.Add('ConnCacheMaxCount',ftInteger,0,False);   //最大并发数
  Rs.FieldDefs.Add('SessionCount',ftInteger,0,False);        //在线连接数
  Rs.FieldDefs.Add('SessionMaxCount',ftInteger,0,False);     //最大连接数
  //指令数
  Rs.FieldDefs.Add('CmdCount',ftInteger,0,False);            //请求指令总数
  Rs.FieldDefs.Add('CmdMaxWaitTime',ftInteger,0,False);      //指令等待延时
  Rs.CreateDataSet;
  if (GetTickCount-StartServiceTickCount)>0 then
    vPercent:=round((DataBlockCount-WaitDataBlockCount) / (GetTickCount-StartServiceTickCount)*(1000*60))
  else
    vPercent:=0;
  Rs.Append;
  Rs.FieldByName('DoTaskCmd').AsInteger:=Params.ParamByName('DoTaskCmd').AsInteger; //指令类型
  Rs.FieldByName('SrvrState').AsInteger:=SrvrState;               //指令执行返回值
  Rs.FieldByName('WorkThreadCount').AsInteger:=WorkThreadCount;   //工作线程数
  Rs.FieldByName('ExecThreadCount').AsInteger:=ExecThreadCount;   //执行线程数
  Rs.FieldByName('MaxThreadCount').AsInteger:=MaxThreadCount;     //最大线程数
  Rs.FieldByName('WorkPercent').AsInteger:=vPercent;              //执行效率值
  Rs.FieldByName('ConnCacheCount').AsInteger:=ConnCache.Count;    //缓冲连接数
  Rs.FieldByName('ConnCacheLockCount').AsInteger:=ConnCache.DBCacheLockCount;  //锁定连接数
  Rs.FieldByName('ConnCacheWaitCount').AsInteger:=WaitDataBlockCount;     //等待指令数
  Rs.FieldByName('ConnCacheMaxCount').AsInteger:=MaxSyncRequestCount;     //最大并发数
  Rs.FieldByName('SessionCount').AsInteger:=Sessions.Count;               //在线连接数
  Rs.FieldByName('SessionMaxCount').AsInteger:=Sessions.MaxSessionCount;  //最大连接数
  Rs.FieldByName('CmdCount').AsInteger:=DataBlockCount;                   //请求指令总数
  Rs.FieldByName('CmdMaxWaitTime').AsInteger:=DataBlockMaxWaitTime;       //指令等待延时(微秒)
  Rs.Post;
end;

procedure TSrvrService.RunCmdLine(const Cmd: String; var ExitCode: DWORD; var ErrMessage, OutMessage: String);
var
  HReadPipe, HWritePipe: THandle;
  SI: STARTUPINFO;
  SA: SECURITY_ATTRIBUTES;
  PI: PROCESS_INFORMATION;
  CchReadBuffer: DWORD;
  PChr: PChar;
  StrTemp: String;
  FileName: PChar;
begin
  FileName := AllocMem(Length(Cmd) + 1);
  StrPCopy(FileName, Cmd);
  PChr := AllocMem(5000);
  SA.nLength := SizeOf(SECURITY_ATTRIBUTES);
  SA.lpSecurityDescriptor := nil;
  SA.bInheritHandle := True;

  if CreatePipe(HReadPipe, HWritePipe, @SA, 0) = False then
  begin
    ErrMessage := 'Can not create pipe!';
    Exit;
  end;
  fillchar(SI, SizeOf(STARTUPINFO), 0);
  SI.cb := SizeOf(STARTUPINFO);
  SI.dwFlags := (STARTF_USESTDHANDLES or STARTF_USESHOWWINDOW);
  SI.wShowWindow := SW_HIDE;
  SI.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
  SI.hStdOutput := HWritePipe;
  SI.hStdError := HWritePipe;
  if CreateProcess( nil, FileName, nil, nil, true, 0, nil, nil, SI, PI) = False  then
  begin
    ErrMessage := 'can not create process!';
    FreeMem(PChr);
    FreeMem(FileName);
    Exit;
  end;
  
  while (True) do
  begin
    if not PeekNamedPipe(HReadPipe, PChr, 1, @CchReadBuffer, nil, nil) then Break;
    if CchReadBuffer <> 0 then
    begin
      if ReadFile(HReadPipe, PChr^, 4096, CchReadBuffer, nil) = False then Break;
      PChr[CchReadBuffer] := Chr(0);
      StrTemp := PChr;
      OutMessage := OutMessage + StrTemp;
    end
    else if (WaitForSingleObject(PI.hProcess ,0) = WAIT_OBJECT_0) then Break;
    Sleep(100);
  end;

  PChr[CchReadBuffer] := Chr(0);
  OutMessage := OutMessage + PChr;
  GetExitCodeProcess(PI.hProcess, ExitCode);
  CloseHandle(HReadPipe);
  CloseHandle(PI.hThread);
  CloseHandle(PI.hProcess);
  CloseHandle(hWritePipe);
  FreeMem(PChr);
  FreeMem(FileName);
end;

{ TSrvrConnetion }

function TClientConnetion.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TClientConnetion.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  DoTaskIdx:=0;
  if Params.FindParam('DoTaskCmd')<>nil then
    DoTaskIdx:=StrToIntDef(Params.FindParam('DoTaskCmd').AsString,0);
  case DoTaskIdx of
   0: result:=OpenClientConnectionList;  //只返回刷新列表
   1: result:=RemoveClientConnected;     //移除客户端连接
  end;
end;

function TClientConnetion.DoTaskCommand(ObjectFactory: IdbHelp): integer;
begin

end;

procedure TClientConnetion.InitClass;
begin
  inherited;

end;

{ TSrvrTask }

function TSrvrTask.DoTaskCommand(ObjectFactory:IdbHelp): integer;
begin

end;

function TSrvrTask.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
 function GetValue(Flag: string; var PlugStr: string): string;
 var
   Idx1,Idx2: integer; Str: string;  
 begin
   result:='';
   Idx1:=Pos(Flag,PlugStr)+Length(Flag);
   Idx2:=Pos(';',PlugStr);
   result:=Copy(PlugStr,Idx1,Idx2-Idx1);
   //截掉前面字符
   PlugStr:=Copy(PlugStr,Idx2+1,Length(PlugStr));
 end;
var
  i: integer;
  Rs: TZQuery;
  vInstCode,PlugStr,PlugID,PlugTimer: string;
  StrList: TStringList;
begin
  vInstCode:='{A16ABE7C-AEEA-4BAB-B2E0-DB9D097D5E9B}';
  if Params.FindParam('INSTCODE')<>nil then
    vInstCode:=Params.FindParam('INSTCODE').AsString;
  //先检测判断服务端是否运行管理程序
  TSrvrCtrl.CheckSvcMgrRun(vInstCode);
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('PlugIn_Id',ftstring,10,true);     //插件ID
  Rs.FieldDefs.Add('PlugIn_NAME',ftstring,30,False);  //插件名称
  Rs.FieldDefs.Add('PlugIn_TIME',ftstring,30,False);  //插件调度时间
  Rs.FieldDefs.Add('Update_TIME',ftstring,20,False);  //插件最后执行时间
  Rs.FieldDefs.Add('PlugIn_TIMER',ftstring,250,False);  //插件调度TIMER  
  Rs.CreateDataSet;
  try
    StrList:=TStringList.Create;
    //插入数据库连接
    if FileExists(TSrvrCtrl.GetPath+'pluglist.cfg') then
    begin
      StrList.LoadFromFile(TSrvrCtrl.GetPath+'pluglist.cfg');
      for i:=0 to StrList.Count-1 do
      begin
        PlugStr:=trim(StrList.Strings[i]);
        Rs.Append;
        PlugID:=GetValue('plugin_id=',PlugStr);
        PlugTimer:=TSrvrCtrl.ReadIniFile(TSrvrCtrl.GetPath+'rsp.cfg','PlugIn'+PlugID,'Timer');
        Rs.FieldByName('PlugIn_Id').AsString:=PlugID;  //插件Id
        Rs.FieldByName('PlugIn_NAME').AsString:=GetValue('plugin_name=',PlugStr); //插件Name
        Rs.FieldByName('PlugIn_TIME').AsString:=GetValue('plugin_time=',PlugStr); //插件调度Time
        Rs.FieldByName('Update_TIME').AsString:=GetValue('update_time=',PlugStr); //插件最后执行Time
        Rs.FieldByName('PlugIn_TIMER').AsString:=PlugTimer;  //插件最后执行Time
        Rs.Post;
      end;
    end;
  finally
    StrList.Free;
  end;
end;

procedure TSrvrTask.InitClass;
begin
  inherited;

end;

{ TSrvrLog }

function TSrvrLog.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Rs: TZQuery;
  LogFile: string; //日志文件名
  sm: TMemoryStream; //文件流变量
begin
  try
    Rs:=TZQuery(DataSet);
    Rs.Close;
    Rs.FieldDefs.Add('LOG_File',ftBlob,0,False);     //日志文件
    Rs.CreateDataSet;
    LogFile:=TSrvrCtrl.GetPath+'CurLog.Log';
 //   SrvrObj.LogList.SaveToFile(LogFile);
 //   SrvrObj.LogList.Clear;
    sm:=TMemoryStream.Create;
    sm.LoadFromFile(LogFile);
    Rs.Append;
    TBlobField(rs.FieldbyName('LOG_File')).LoadFromStream(sm);
    Rs.Post;
  finally
    sm.Free; 
  end;
end;

function TSrvrLog.DoTaskCommand(ObjectFactory:IdbHelp): integer;
begin

end;

procedure TSrvrLog.InitClass;
begin
  inherited;

end;

{ TPlugTask }

function TRemoteTask.Plug_AddTask(AGlobal: IdbHelp; Params:TftParamList): Boolean;
var
  rs: TZQuery;
  dbHelp: IdbHelp;
  Str,TenID,PlugID: string;
begin
  result:=False;
  if Params<>nil then
  begin
    dbHelp := TdbHelp.Create;
    rs := TZQuery.Create(nil);
    try
      dbHelp.Initialize('provider=sqlite-3;databasename='+ExtractShortPathName(TSrvrCtrl.GetPath)+'data\r3.db');
      dbHelp.Connect;
      if Params.FindParam('TENANT_ID')<>nil then TenID:=Params.FindParam('TENANT_ID').AsString;
      if Params.FindParam('PLUG_ID')<>nil then PlugID:=Params.FindParam('PLUG_ID').AsString;
      //先删除前一天插件调度历史记录
      Str:='delete from sys_define where TENANT_ID='+TenID+' and DEFINE='''+PlugID+''' and VALUE<='''+FormatDatetime('YYYYMMDD',Date()-2)+''' ';
      dbHelp.ExecSQL(Str);
      rs.Close;
      rs.SQL.Text:='select TENANT_ID from sys_define where TENANT_ID='+TenID+' and DEFINE='''+PlugID+''' and VALUE='''+FormatDatetime('YYYYMMDD',Date())+''' ';
      if dbHelp.Open(rs) then
      begin
        if rs.RecordCount=0 then
        begin
          Str:='insert into sys_define(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) '+
               'values ('+TenID+','''+PlugID+''','''+FormatDatetime('YYYYMMDD',Date())+''',0,''00'',1)';
          LogFile.AddLogFile(0,Str);
          dbHelp.ExecSQL(Str);      
        end;
      end;
      result:=true;
    finally
      rs.free;
      dbHelp:= nil;   
    end;
  end;
end;

function TRemoteTask.Plug_SaveTask(Params: TftParamList): Boolean;
begin

end;

function TRemoteTask.Params_CheckPortDispatcher(Params: TftParamList): Boolean;
var
  PortNum: integer;
  PortDisp: TSocketDispatcher;
begin
  result:=False;
  PortNum:=0;
  if Params.FindParam('SRVR_PORT')<>nil then
    PortNum:=Params.FindParam('SRVR_PORT').AsInteger;

  if PortNum>0 then
  begin
    PortDisp := TSocketDispatcher.Create(nil);
    try
      PortDisp.Port:=PortNum;
      try
        PortDisp.Open;
        result:=PortDisp.Active;
      except
        on E: Exception do
          raise Exception.CreateResFmt(@SOpenError, [PortDisp.Port, E.Message]);
      end;
    finally
      PortDisp.Free;
    end;
  end;
end;

function TRemoteTask.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  InstCode: string;
begin
  result:=False;
  //1、判断SvcMgr是否运行:
  InstCode:='{A16ABE7C-AEEA-4BAB-B2E0-DB9D097D5E9B}';
  if (Params<>nil) and (Params.FindParam('INSTCODE')<>nil) then
    InstCode:=Params.FindParam('INSTCODE').AsString;
  TSrvrCtrl.CheckSvcMgrRun(InstCode);

  //2、分解Task命令类型
  if Params.FindParam('DoTaskCmd')<>nil then
  begin
    {== 1:开始执行; 2:插件调度; 3:管理插件==}
    case Params.FindParam('DoTaskCmd').AsInteger of
     1: result:=Plug_AddTask(AGlobal,Params);
     2: result:=Plug_SaveTask(Params);
     11: result:=Params_CheckPortDispatcher(Params);
    end;
  end;
end;
 

{ TSrvrPlugInInfo }

function TSrvrPlugInInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Rs: TZQuery;
  FileName: string;
  StrList: TStringList;
begin
  FileName:=TSrvrCtrl.GetPath+'PlugIn.cfg';
  Rs:=TZQuery(DataSet);
  if (Rs<>nil) and (FIsFlag<>1) then
  begin
    StrList:=TStringList.Create;
    try
      Rs.First;
      while not Rs.Eof do
      begin
        StrList.Add(Rs.fieldbyName('PLUG_Value').AsString); 
        Rs.Next;
      end;
      StrList.SaveToFile(FileName); 
    finally
      StrList.Free;
    end;
    FIsFlag:=1; //打上标记位
  end;
end;

function TSrvrPlugInInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  i: integer;
  Rs: TZQuery;
  PortNum,FileName: string;
  StrList: TStringList;
begin
  Rs:=TZQuery(DataSet);  
  Rs.Close;
  Rs.FieldDefs.Add('PLUG_NO',ftInteger,0,true); //插件参数Section
  Rs.FieldDefs.Add('PLUG_Value',ftstring,255,False);  //插件参数Ident
  Rs.CreateDataSet;
  //插入数据库连接                 
  try
    FileName:=TSrvrCtrl.GetPath+'PlugIn.cfg';
    StrList:=TStringList.Create;
    StrList.LoadFromFile(FileName);
    for i:=0 to StrList.Count-1 do         
    begin
      Rs.Append;
      Rs.FieldByName('PLUG_NO').AsInteger:=i+1;
      Rs.FieldByName('PLUG_Value').AsString:=StrList.Strings[i];
      Rs.Post;
    end;
  finally
    StrList.Free;
  end;  
end;

function TSrvrPlugInInfo.DoTaskCommand(ObjectFactory: IdbHelp): integer;
begin

end;

procedure TSrvrPlugInInfo.InitClass;
begin
  inherited;

end;

{ TSrvrDBConnetion }

function TSrvrDBConnetion.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  DoTaskIdx:=0;
  if Params.FindParam('DoTaskCmd')<>nil then
    DoTaskIdx:=StrToIntDef(Params.FindParam('DoTaskCmd').AsString,0);
  case DoTaskIdx of
   0: OpenDBList;  //只返回
   1: CheckDBConnect; 
   2: SaveDBList;  //先判断是否能连接在保存
  end;
end;

function TSrvrDBConnetion.CheckDBConnect: Boolean;
var
  DBCon: string;
  Rs: TZQuery;
  dbHelp: IdbHelp;
begin
  result:=False;
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('ReRun',ftBoolean,0,true);        //连接DB_ID
  Rs.CreateDataSet;
  Rs.Append;
  Rs.FieldByName('ReRun').AsBoolean:=False;
  Rs.Post;

  if Params.FindParam('DB_CONSTR')<>nil then DBCon:=Params.FindParam('DB_CONSTR').AsString;   //数据库登录密码
  if DBCon<>'' then
  begin
    try
      dbHelp := TdbHelp.Create;
      dbHelp.Initialize(DecStr(DBCon,ENC_KEY));
      dbHelp.Connect;
      //连接上保存参数
      if dbHelp.Connected then
      begin
        try
          Rs.Edit;
          Rs.FieldByName('ReRun').AsBoolean:=true;
          Rs.Post;
        except
        end;
      end;
    finally
      dbHelp:=nil;
    end;
  end;
end;

constructor TSrvrDBConnetion.Create(ADataSet: TDataSet);
var
  i: integer;
  F: TIniFile;
  CusStr: string;
begin
  FDBList:=TStringList.Create;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  try
    F.ReadSections(FDBList);
    for i:=FDBList.Count-1 to 0 do
    begin
      CusStr:=trim(LowerCase(FDBList.Strings[i]));
      if not ((length(CusStr)>2) and (copy(CusStr,1,2)='db')) then
      begin
        FDBList.Delete(i);
      end;
    end;
  finally
    F.Free;
  end;   
end;

destructor TSrvrDBConnetion.Destroy;
begin
  FDBList.Free;
  inherited;
end;

function TSrvrDBConnetion.OpenDBList: Boolean;
var
  i: integer;
  Rs: TZQuery;
  DBID,FileName,DbHost: string;
begin
  result:=false;
  FileName:=TSrvrCtrl.GetPath+'db.cfg';
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('DB_ID',ftstring,20,False);        //连接DB_ID
  Rs.FieldDefs.Add('DB_TYPE',ftstring,20,False);      //数据库类型
  Rs.FieldDefs.Add('DB_HOSTNAME',ftstring,50,False);  //数据库主机名
  Rs.FieldDefs.Add('DB_DBNAME',ftstring,50,False);    //数据库库名
  Rs.FieldDefs.Add('DB_USERID',ftstring,50,False);    //数据库登录用户名
  Rs.FieldDefs.Add('DB_PWD',ftstring,60,False);       //数据库登录密码
  Rs.FieldDefs.Add('DB_STATUS',ftInteger,0,False);       //数据库登录密码
  Rs.CreateDataSet;
  //插入数据库连接
  for i:=0 to FDBList.Count-1 do
  begin
    DBID:=trim(FDBList.Strings[i]);
    DbHost:=TSrvrCtrl.ReadIniFile(FileName,DBID,'hostname');
    Rs.Append;
    Rs.FieldByName('DB_ID').AsString:=Copy(DBID,3,20); 
    Rs.FieldByName('DB_TYPE').AsString:=TSrvrCtrl.ReadIniFile(FileName,DBID,'provider');
    Rs.FieldByName('DB_HOSTNAME').AsString:=DbHost;
    Rs.FieldByName('DB_DBNAME').AsString:=TSrvrCtrl.ReadIniFile(FileName,DBID,'databasename');
    Rs.FieldByName('DB_USERID').AsString:=TSrvrCtrl.ReadIniFile(FileName,DBID,'uid');
    Rs.FieldByName('DB_PWD').AsString:=TSrvrCtrl.ReadIniFile(FileName,DBID,'password');
    Rs.FieldByName('DB_STATUS').AsInteger:=0;
    Rs.Post;
  end;
  result:=true;
end;

function TSrvrDBConnetion.SaveDBList: Boolean;
var
  Rs: TZQuery;
  FileName,DBID,DbType,DbHost,DbPort,DBName,DBUID,DBPwd,DBCon: string;
  dbHelp: IdbHelp;
begin
  result:=False;
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('ReRun',ftBoolean,0,true);        //连接DB_ID
  Rs.CreateDataSet;
  Rs.Append;
  Rs.FieldByName('ReRun').AsBoolean:=False;
  Rs.Post;

  FileName:=TSrvrCtrl.GetPath+'db.cfg';
  DBID:='';
  DbType:='';
  DbHost:='';
  DbPort:='';
  DBName:='';
  DBUID:='';
  DBPwd:='';
  DBCon:='';
  if Params.FindParam('DB_ID')<>nil then DBID:=Params.FindParam('DB_ID').AsString;  //连接DB_ID
  if Params.FindParam('DB_TYPE')<>nil then DbType:=Params.FindParam('DB_TYPE').AsString;  //数据库类型
  if Params.FindParam('DB_HOSTNAME')<>nil then DbHost:=Params.FindParam('DB_HOSTNAME').AsString;  //数据库主机名
  if Params.FindParam('DB_DBNAME')<>nil then DBName:=Params.FindParam('DB_DBNAME').AsString;  //数据库库名
  if Params.FindParam('DB_USERID')<>nil then DBUID:=Params.FindParam('DB_USERID').AsString;   //数据库登录用户名
  if Params.FindParam('DB_PWD')<>nil then DBPwd:=Params.FindParam('DB_PWD').AsString;    //数据库登录密码
  if Params.FindParam('DB_CONSTR')<>nil then DBCon:=Params.FindParam('DB_CONSTR').AsString;   //数据库登录密码
  if (DBID<>'') and (DbHost<>'') then
  begin
    try
      dbHelp := TdbHelp.Create;
      dbHelp.Initialize(DecStr(DBCon,ENC_KEY));
      dbHelp.Connect;
      //连接上保存参数
      if dbHelp.Connected then
      begin
        try
          TSrvrCtrl.WriteIniFile(FileName,'db'+DBID,'dbid',DBID);
          TSrvrCtrl.WriteIniFile(FileName,'db'+DBID,'hostname',DbHost);
          TSrvrCtrl.WriteIniFile(FileName,'db'+DBID,'databasename',DBName);
          TSrvrCtrl.WriteIniFile(FileName,'db'+DBID,'password',DBPwd);
          TSrvrCtrl.WriteIniFile(FileName,'db'+DBID,'provider',DbType);
          TSrvrCtrl.WriteIniFile(FileName,'db'+DBID,'connstr',DBCon);
          Rs.Edit;
          Rs.FieldByName('ReRun').AsBoolean:=true;
          Rs.Post;
        except
        end;
      end;
    finally
      dbHelp:=nil;
    end;
  end;
end;

function TClientConnetion.OpenClientConnectionList: Boolean;
var
  i: integer;
  Rs: TZQuery;
  vSession: TZSession;
begin
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('Con_ID',ftstring,30,False);         //连接ID(SESION_ID,SRVR_ID)
  Rs.FieldDefs.Add('Con_DB_ID',ftstring,30,False);      //连接ID(DB_ID)
  Rs.FieldDefs.Add('Con_PROT',ftstring,10,False);       //连接端口号
  Rs.FieldDefs.Add('Con_HOSTNAME',ftstring,60,False);   //连接主机名
  Rs.FieldDefs.Add('Con_USERNAME',ftstring,40,False);   //连接用户名
  Rs.FieldDefs.Add('Con_UPTIME',ftstring,30,False);     //连接更新时间
  Rs.CreateDataSet;
  //插入客户端连接
  for i:=0 to Sessions.Count-1 do
  begin
    vSession:=Sessions.Sessions[i];
    if vSession<>nil then
    begin
      Rs.Append;
      Rs.FieldByName('Con_ID').AsString:=IntToStr(vSession.SessionID);
      Rs.FieldByName('Con_DB_ID').AsString:=IntToStr(vSession.dbid);
      Rs.FieldByName('Con_PROT').AsString:=vSession.Port;
      Rs.FieldByName('Con_HOSTNAME').AsString:=vSession.IPAddress;
      Rs.FieldByName('Con_USERNAME').AsString:=vSession.UserName;
      Rs.FieldByName('Con_UPTIME').AsString:=DateTimeToStr(now());
      Rs.Post;
    end;
  end;
end;

function TClientConnetion.RemoveClientConnected: Boolean;
var
  i: integer;
  Rs: TZQuery;
  vSession: TZSession;
begin
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('Con_ID',ftstring,30,True);          //连接ID(SESION_ID,SRVR_ID)
  Rs.FieldDefs.Add('Con_STATUS',ftInteger,0,False);      //连接状态
  Rs.CreateDataSet;
  //执行移除连接
  Rs.Append;
  Rs.FieldByName('Con_ID').AsString:=Params.ParamByName('Con_ID').AsString;
  Rs.FieldByName('Con_STATUS').AsInteger:=0;
  Rs.Post;
end;



{ TSrvrPortInfo }

function TSrvrPortInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  i: integer;
  Rs: TZQuery;
  PortNum,FileName: string;
  SectionList: TStringList;
begin
  DoTaskIdx:=0;
  if Params.FindParam('DoTaskCmd')<>nil then
    DoTaskIdx:=StrToIntDef(Params.FindParam('DoTaskCmd').AsString,0);
  case DoTaskIdx of
   0: result:=OpenSrvrPortList;  //只返回刷新列表
   1: result:=CheckSrvrPort;     //判断端口是否被占用
   2: result:=SaveSrvrPortList;  //保存端口参数
  end;
end;

function TSrvrPortInfo.CheckSrvrPort: Boolean;
var
  PortNum: integer;
  Rs: TZQuery;
  PortDisp: TSocketDispatcher;
begin
  result:=False;
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('ReRun',ftBoolean,0,true); //原端口号(更新使用)
  Rs.CreateDataSet;
  Rs.Append;
  Rs.FieldByName('ReRun').AsBoolean:=False;
  Rs.Post;

  PortNum:=0;
  if Params.FindParam('SRVR_PORT')<>nil then
    PortNum:=Params.FindParam('SRVR_PORT').AsInteger;

  if PortNum>0 then
  begin
    PortDisp := TSocketDispatcher.Create(nil);
    try
      PortDisp.Port:=PortNum;
      try
        PortDisp.Open;
        Rs.Edit;
        Rs.FieldByName('ReRun').AsBoolean:=PortDisp.Active;
        Rs.Post;
      except
        on E: Exception do
          raise Exception.CreateResFmt(@SOpenError, [PortDisp.Port, E.Message]);
      end;
    finally
      PortDisp.Free;
    end;
  end;
end;
 
function TSrvrPortInfo.OpenSrvrPortList: Boolean;
var
  i: integer;
  Rs: TZQuery;
  PortNum,FileName: string;
  SectionList: TStringList;
begin
  result:=False;
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('SRVR_PORT_OLD',ftInteger,0,true); //原端口号(更新使用)
  Rs.FieldDefs.Add('SRVR_PORT',ftInteger,0,true);     //端口号
  Rs.FieldDefs.Add('SRVR_ThreadCacheSize',ftInteger,0,False);   //线程缓冲数
  Rs.FieldDefs.Add('SRVR_TIMEOUT',ftInteger,0,False);     //不活动分钟数
  Rs.FieldDefs.Add('SRVR_KeepActive',ftBoolean,0,False);  //心跳机制(0:不启用;1:启用)
  Rs.FieldDefs.Add('SRVR_STATUS',ftInteger,0,False);       //记录状态(0:不变; 1:添加; 2:修改; 2:删除)
  Rs.CreateDataSet;
  //插入数据库连接
  try
    FileName:=TSrvrCtrl.GetPath+'sckt.cfg';
    SectionList:=TStringList.Create;
    TSrvrCtrl.ReadIniFileSection(FileName,SectionList);
    for i:=0 to SectionList.Count-1 do
    begin
      PortNum:=trim(SectionList.Strings[i]);
      Rs.Append;
      Rs.FieldByName('SRVR_PORT_OLD').AsInteger:=StrToInt(PortNum);
      Rs.FieldByName('SRVR_PORT').AsInteger:=StrToInt(PortNum);
      Rs.FieldByName('SRVR_ThreadCacheSize').AsInteger:=TSrvrCtrl.ReadIniFileInt(FileName,PortNum,'ckThreadCacheSize');
      Rs.FieldByName('SRVR_TIMEOUT').AsInteger:=TSrvrCtrl.ReadIniFileInt(FileName,PortNum,'ckTimeout');
      Rs.FieldByName('SRVR_KeepActive').AsBoolean:=TSrvrCtrl.ReadIniFileBool(FileName,PortNum,'ckKeepAlive');
      Rs.FieldByName('SRVR_STATUS').AsInteger:=0;
      Rs.Post;
    end;
    result:=true;
  finally
    SectionList.Free;
  end;
end;

function TSrvrPortInfo.SaveSrvrPortList: Boolean;
var
  i,IsRun: integer;
  Rs: TZQuery;
  FileName,ParamValue: string;
  PortNum,KeepActive: string;
  ThreadCacheSize,TIMEOUT,PortState: integer;
begin
  IsRun:=0;
  FileName:=TSrvrCtrl.GetPath+'sckt.cfg';
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('ReRun',ftBoolean,0,true); //原端口号(更新使用)
  Rs.CreateDataSet;
  Rs.Append;
  Rs.FieldByName('ReRun').AsBoolean:=False;
  Rs.Post;
  for i:=1 to Params.Count do
  begin
    if Params.FindParam('PORTNUM'+InttoStr(i))<>nil then
      ParamValue:=trim(Params.FindParam('PORTNUM'+InttoStr(i)).AsString);
    if ParamValue<>'' then
    begin
      PortNum:=TSrvrCtrl.GetParamValue(ParamValue,'PORT=',';');
      ThreadCacheSize:=TSrvrCtrl.GetParamValueInt(ParamValue,'CACHE=',';');
      TIMEOUT:=TSrvrCtrl.GetParamValueInt(ParamValue,'TIME=',';');
      KeepActive:=TSrvrCtrl.GetParamValue(ParamValue,'ACTIVE=',';');
      PortState:=TSrvrCtrl.GetParamValueInt(ParamValue,'STATUS=',';');
      if (PortNum<>'') and (PortState>0) then
      begin
        case PortState of
         1,2:
          begin
            TSrvrCtrl.WriteIniFileInt(FileName,PortNum,'ckThreadCacheSize',ThreadCacheSize);
            TSrvrCtrl.WriteIniFileInt(FileName,PortNum,'ckTimeout',TIMEOUT);
            TSrvrCtrl.WriteIniFileBool(FileName,PortNum,'ckKeepAlive',(trim(KeepActive)<>'0'));
          end;
         3: TSrvrCtrl.DeleteIniFileSection(FileName,PortNum);
        end;
      end;
    end;
    Inc(IsRun);
  end;
  Rs.Edit;
  Rs.FieldByName('ReRun').AsBoolean:=(IsRun>0);
  Rs.Post;
end;

initialization
  RegisterClass(TSrvrService);
  RegisterClass(TSrvrDBConnetion);
  RegisterClass(TClientConnetion);
  RegisterClass(TSrvrPortInfo);
  RegisterClass(TSrvrTask);
  RegisterClass(TSrvrLog);

  RegisterClass(TRemoteTask);
finalization
  UnRegisterClass(TSrvrService);
  UnRegisterClass(TSrvrDBConnetion);
  UnRegisterClass(TClientConnetion);
  UnRegisterClass(TSrvrPortInfo);
  UnRegisterClass(TSrvrTask);
  UnRegisterClass(TSrvrLog);
  
  UnRegisterClass(TRemoteTask);
end.

end.
