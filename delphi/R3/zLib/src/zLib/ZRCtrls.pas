{==  ����˿��ƹ���  ==}

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
    //�жϹ���ģ���Ƿ�����
    class function CheckSvcMgrRun(InstCode: string=''): Boolean;
    //��ȡIni�ļ�
    class function ReadIniFile(FileName,Section,Ident: string): string;
    //��ȡIni�ļ�
    class function ReadIniFileInt(FileName,Section,Ident: string): integer;
    //��ȡIni�ļ�
    class function ReadIniFileBool(FileName,Section,Ident: string): Boolean;
    //д��Ini�ļ�
    class function WriteIniFile(FileName,Section,Ident,Value: string): Boolean;
    //д��Ini�ļ�
    class function WriteIniFileInt(FileName,Section,Ident: string; Value: integer): Boolean;
    //д��Ini�ļ�
    class function WriteIniFileBool(FileName,Section,Ident: string; Value: Boolean): Boolean;
    //��ȡIni�ļ�Section:
    class function ReadIniFileSection(FileName: string;var Section: TStringList): Boolean;
    //ɾ��Ini�ļ�Section:
    class function DeleteIniFileSection(FileName,Section: string): Boolean;
  end;

  {==�������: DoTaskCmd:(0:��ѯ����;1:���÷���;2:ֹͣ����;3:����Ado����); ==}
  TSrvrService=class(TZFactory)
  private
    { Cmd���ⲿ����̨�����ļ���������·��;
      ExitCode������ִ��״̬���룬����ɹ������� 0 ������� 0;
      ErrMessage��ִ�г��ִ���ʱ���ش�����Ϣ;
      OutMessage������̨�����Ϣ  }
    procedure RunCmdLine(const Cmd: String; var ExitCode: DWORD; var ErrMessage, OutMessage: String);
  public
    //��ѯ����
    function QueryService(AServName: string): integer;
    //��������
    function StartService(AServName: string): Boolean;
    //ֹͣ����
    function StopService(AServName: string): Boolean;
    //����������
    function ReStartService(AServName: string): Boolean;
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {==����״̬: DoTaskCmd:(0:��ѯ���ݿ�Ϳͻ�������;1:��ѯ���ݿ�����;2:��ѯ�ͻ�������;3:�Ͽ��ͻ�������); ==}
  TSrvrConnetion=class(TZFactory)
  private
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
  public
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {==����Socket���Ӳ���==}
  TSrvrParamInfo=class(TZFactory)
  private
    FIsFlag: integer;  //���б��λ
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
  public
    //����֮ǰ�������ļ�����
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //��ʼ����
    procedure InitClass; override;
  end;

  {==������Ȳ���==}
  TSrvrPlugInInfo=class(TZFactory)
  private
    FIsFlag: integer;  //���б��λ
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
  public
    //����֮ǰ�������ļ�����
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //��ʼ����
    procedure InitClass; override;
  end;
  

  {==�������: DoTaskCmd:(0:ˢ�²�ѯ�����б�;1:���������б����;2:����ִ�������б�) ==}
  TSrvrTask=class(TZFactory)
  private
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
  public
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {==��־����: DoTaskCmd:(0:ˢ�²�ѯ��־����б�;1:��ѯ��ʷ�ļ���־;) ==}
  TSrvrLog=class(TZFactory)
  private
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
  public
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {===========Զ��ִ��===========}
  //Զ�̵�������(DoTaskCmd):
  // 1���������(1..10); 2���������(11..20); 3��
  TRemoteTask=class(TZProcFactory)
  private
    //���
    function Plug_AddTask(AGlobal:IdbHelp; Params:TftParamList): Boolean; //����ִ�в��
    function Plug_SaveTask(Params:TftParamList): Boolean;  //������Ȳ�������
    //����
    function Params_CheckPortDispatcher(Params:TftParamList): Boolean; //���˿��Ƿ�����
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;




implementation

uses
  uSrvrServer,ZLogFile;

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
      //���������������:SvcMgr.exe
      StrCode:=TSrvrCtrl.GetPath+'SvcMgr.exe';
      if FileExists(StrCode) then
        WINEXEC(pChar(StrCode), SW_NORMAL);
    end;
    MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, Pchar(StrCode));
    result:=(MutHandle>0);  //��������
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
        //ֹͣ��ж�ط���;
        QueryServiceStatus(hService,SvcStatus);
        result:=SvcStatus.dwCurrentState; {SERVICE_STOPPED: ֹͣ; SERVICE_RUNNING: ����}
      finally
        CloseServiceHandle(hService);
      end;
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

function TSrvrService.StartService(AServName: string): Boolean;
var
  lpServiceArgVectors: PChar;
  SCManager, hService: SC_HANDLE;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_ALL_ACCESS);
    Result := hService <> 0;
    if (hService = 0) and (GetLastError = ERROR_SERVICE_DOES_NOT_EXIST) then
      Exception.Create('The specified service['+AServName+'] does not exist');
    if hService <> 0 then
    try
      lpServiceArgVectors := nil;
      Result := WinSvc.StartService(hService, 0, PChar(lpServiceArgVectors));
      if not Result and (GetLastError = ERROR_SERVICE_ALREADY_RUNNING) then
        Result := True;
    finally
      CloseServiceHandle(hService);
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
      //ֹͣ��ж�ط���;
      Result := ControlService(hService, SERVICE_CONTROL_STOP, SvcStatus);
      //ɾ��������һ����Բ�Ҫ;
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
    result:=(ExitCode=0); //ִ�д���
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
     1:
      begin
        ReRun:=StartService('RSPScktSrvr');
        if ReRun then result:=1;
      end;
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

procedure TSrvrService.InitClass;
begin
  inherited;

end;         

function TSrvrService.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Rs: TZQuery;
  vPercent: integer;
  SrvrState: integer;
begin
  //ִ�к�ָ̨��
  SrvrState:=DoTaskCommand(AGlobal);
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('DoTaskCmd',ftInteger,0,true);  //ָ������
  Rs.FieldDefs.Add('SrvrState',ftInteger,0,true);  //ָ��ִ�з���ֵ
  //�߳���:
  Rs.FieldDefs.Add('WorkThreadCount',ftInteger,0,False);     //�����߳���
  Rs.FieldDefs.Add('ExecThreadCount',ftInteger,0,False);     //ִ���߳���
  Rs.FieldDefs.Add('MaxThreadCount',ftInteger,0,False);      //����߳���
  Rs.FieldDefs.Add('WorkPercent',ftInteger,0,False);         //ִ��Ч��ֵ
  //������
  Rs.FieldDefs.Add('ConnCacheCount',ftInteger,0,False);      //����������
  Rs.FieldDefs.Add('ConnCacheLockCount',ftInteger,0,False);  //����������
  Rs.FieldDefs.Add('ConnCacheWaitCount',ftInteger,0,False);  //�ȴ�ָ����
  Rs.FieldDefs.Add('ConnCacheMaxCount',ftInteger,0,False);   //��󲢷���
  Rs.FieldDefs.Add('SessionCount',ftInteger,0,False);        //����������
  Rs.FieldDefs.Add('SessionMaxCount',ftInteger,0,False);     //���������
  //ָ����
  Rs.FieldDefs.Add('CmdCount',ftInteger,0,False);            //����ָ������
  Rs.FieldDefs.Add('CmdMaxWaitTime',ftInteger,0,False);      //ָ��ȴ���ʱ
  Rs.CreateDataSet;
  if (GetTickCount-StartServiceTickCount)>0 then
    vPercent:=round((DataBlockCount-WaitDataBlockCount) / (GetTickCount-StartServiceTickCount)*(1000*60))
  else
    vPercent:=0;
  Rs.Append;
  Rs.FieldByName('DoTaskCmd').AsInteger:=Params.ParamByName('DoTaskCmd').AsInteger; //ָ������
  Rs.FieldByName('SrvrState').AsInteger:=SrvrState;               //ָ��ִ�з���ֵ
  Rs.FieldByName('WorkThreadCount').AsInteger:=WorkThreadCount;   //�����߳���
  Rs.FieldByName('ExecThreadCount').AsInteger:=ExecThreadCount;   //ִ���߳���
  Rs.FieldByName('MaxThreadCount').AsInteger:=MaxThreadCount;     //����߳���
  Rs.FieldByName('WorkPercent').AsInteger:=vPercent;              //ִ��Ч��ֵ
  Rs.FieldByName('ConnCacheCount').AsInteger:=ConnCache.Count;    //����������
  Rs.FieldByName('ConnCacheLockCount').AsInteger:=ConnCache.DBCacheLockCount;  //����������
  Rs.FieldByName('ConnCacheWaitCount').AsInteger:=WaitDataBlockCount;     //�ȴ�ָ����
  Rs.FieldByName('ConnCacheMaxCount').AsInteger:=MaxSyncRequestCount;     //��󲢷���
  Rs.FieldByName('SessionCount').AsInteger:=Sessions.Count;               //����������
  Rs.FieldByName('SessionMaxCount').AsInteger:=Sessions.MaxSessionCount;  //���������
  Rs.FieldByName('CmdCount').AsInteger:=DataBlockCount;                   //����ָ������
  Rs.FieldByName('CmdMaxWaitTime').AsInteger:=DataBlockMaxWaitTime;       //ָ��ȴ���ʱ(΢��)
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

function TSrvrConnetion.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  i: integer;
  Rs: TZQuery;
  vObj: TRecord_;
  DBFlag,ClientFlag: Boolean;
  StrList: TStringList;
  vSession: TZSession;
begin
  DBFlag:=False;      //���ݿ�
  ClientFlag:=False;  //�ͻ���
  if Params.FindParam('Con_Type')<>nil then
  begin
    case Params.FindParam('Con_Type').AsInteger of
      1: DBFlag:=true;      //���ݿ�
      2: ClientFlag:=true;  //�ͻ���
     else
      begin
        DBFlag:=true;       //���ݿ�
        ClientFlag:=true;   //�ͻ���
      end;
    end;
  end;
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('Con_Type',ftInteger,0,true);    //����:1��DB;2�ǿͻ���
  Rs.FieldDefs.Add('Con_ID',ftstring,30,False);      //����ID(SESION_ID,SRVR_ID)
  Rs.FieldDefs.Add('Con_DB_ID',ftstring,30,False);   //����ID(DB_ID)
  Rs.FieldDefs.Add('Con_PROT',ftstring,10,False);    //���Ӷ˿ں�
  Rs.FieldDefs.Add('Con_HostName',ftstring,100,False);  //����������
  Rs.FieldDefs.Add('Con_PARAMS',ftstring,60,False);  //����������
  Rs.FieldDefs.Add('Con_UPTIME',ftstring,40,False);      //���Ӹ���ʱ��
  Rs.CreateDataSet;
  //�������ݿ�����
  if DBFlag then
  begin
    StrList:=SrvrObj.DBList;
    for i:=0 to StrList.Count-1 do
    begin
      vObj:=TRecord_(StrList.Objects[i]);
      if (vObj<>nil) and (vObj.FieldByName('DB_ID').AsString<>'') then
      begin
        Rs.Append;
        Rs.FieldByName('Con_Type').AsInteger:=1; //DB
        Rs.FieldByName('Con_ID').AsString:=vObj.fieldbyName('DB_ID').AsString;
        Rs.FieldByName('Con_DB_ID').AsString:='';
        Rs.FieldByName('Con_PROT').AsString:='';
        Rs.FieldByName('Con_HostName').AsString:=vObj.fieldbyName('DB_HostName').AsString;
        Rs.FieldByName('Con_PARAMS').AsString:='';
        Rs.FieldByName('Con_UPTIME').AsString:=vObj.fieldbyName('DB_Provider').AsString;
        Rs.Post;
      end;
    end;
  end;
  //����ͻ�������
  if ClientFlag then
  begin
    for i:=0 to Sessions.Count-1 do
    begin
      vSession:=Sessions.Sessions[i];
      if vSession<>nil then
      begin
        Rs.Append;
        Rs.FieldByName('Con_Type').AsInteger:=2; //Client
        Rs.FieldByName('Con_ID').AsString:=IntToStr(vSession.SessionID);
        Rs.FieldByName('Con_DB_ID').AsString:=IntToStr(vSession.dbid);
        Rs.FieldByName('Con_PROT').AsString:=vSession.Port;
        Rs.FieldByName('Con_HostName').AsString:=vSession.IPAddress;
        Rs.FieldByName('Con_PARAMS').AsString:=vSession.UserName;
        Rs.FieldByName('Con_UPTIME').AsString:=DateTimeToStr(now());
        Rs.Post;
      end;
    end;
  end;
end;

function TSrvrConnetion.DoTaskCommand(ObjectFactory: IdbHelp): integer;
begin

end;

procedure TSrvrConnetion.InitClass;
begin
  inherited;

end;


{ TSrvrParamInfo }

function TSrvrParamInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Rs,EditTable: TZQuery;
  FileName,PortNum: string;
begin
  FileName:=TSrvrCtrl.GetPath+'sckt.cfg';
  Rs:=TZQuery(DataSet);
  if (Rs<>nil) and (FIsFlag<>1) then
  begin
    EditTable:=TZQuery.Create(nil);
    EditTable.Data:=Rs.Data;
    try
      EditTable.First;
      while not EditTable.Eof do
      begin
        PortNum:=EditTable.FieldByName('SRVR_PORT').AsString;
        case EditTable.FieldByName('SRVR_STATE').AsInteger of
         1,2:
          begin
            TSrvrCtrl.WriteIniFileInt(FileName,PortNum,'ckThreadCacheSize',EditTable.FieldByName('SRVR_ThreadCacheSize').AsInteger);
            TSrvrCtrl.WriteIniFileInt(FileName,PortNum,'ckTimeout',EditTable.FieldByName('SRVR_TIMEOUT').AsInteger);
            TSrvrCtrl.WriteIniFileBool(FileName,PortNum,'ckKeepAlive',EditTable.FieldByName('SRVR_KeepActive').AsBoolean);
          end;
         3: TSrvrCtrl.DeleteIniFileSection(FileName,PortNum);
        end;
        EditTable.Next; 
      end;
    finally
      EditTable.Free;
    end;
    FIsFlag:=1; //���ϱ��λ
  end;
end;

function TSrvrParamInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  i: integer;
  Rs: TZQuery;
  PortNum,FileName: string;
  SectionList: TStringList;
begin
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('SRVR_PORT_OLD',ftInteger,0,true); //ԭ�˿ں�(����ʹ��)
  Rs.FieldDefs.Add('SRVR_PORT',ftInteger,0,true);     //�˿ں�
  Rs.FieldDefs.Add('SRVR_ThreadCacheSize',ftInteger,0,False);   //�̻߳�����
  Rs.FieldDefs.Add('SRVR_TIMEOUT',ftInteger,0,False);     //���������
  Rs.FieldDefs.Add('SRVR_KeepActive',ftBoolean,0,False);  //��������(0:������;1:����)
  Rs.FieldDefs.Add('SRVR_STATE',ftInteger,0,False);       //��¼״̬(0:����; 1:���; 2:�޸�; 2:ɾ��)
  Rs.CreateDataSet;
  //�������ݿ�����
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
      Rs.FieldByName('SRVR_STATE').AsInteger:=0;
      Rs.Post;
    end;
  finally
    SectionList.Free;
  end;
end;

function TSrvrParamInfo.DoTaskCommand(ObjectFactory: IdbHelp): integer;
begin

end;

procedure TSrvrParamInfo.InitClass;
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
   //�ص�ǰ���ַ�
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
  //�ȼ���жϷ�����Ƿ����й������
  TSrvrCtrl.CheckSvcMgrRun(vInstCode);
  Rs:=TZQuery(DataSet);
  Rs.Close;
  Rs.FieldDefs.Add('PlugIn_Id',ftstring,10,true);     //���ID
  Rs.FieldDefs.Add('PlugIn_NAME',ftstring,30,False);  //�������
  Rs.FieldDefs.Add('PlugIn_TIME',ftstring,30,False);  //�������ʱ��
  Rs.FieldDefs.Add('Update_TIME',ftstring,20,False);  //������ִ��ʱ��
  Rs.FieldDefs.Add('PlugIn_TIMER',ftstring,250,False);  //�������TIMER  
  Rs.CreateDataSet;
  try
    StrList:=TStringList.Create;
    //�������ݿ�����
    if FileExists(TSrvrCtrl.GetPath+'pluglist.cfg') then
    begin
      StrList.LoadFromFile(TSrvrCtrl.GetPath+'pluglist.cfg');
      for i:=0 to StrList.Count-1 do
      begin
        PlugStr:=trim(StrList.Strings[i]);
        Rs.Append;
        PlugID:=GetValue('plugin_id=',PlugStr);
        PlugTimer:=TSrvrCtrl.ReadIniFile(TSrvrCtrl.GetPath+'rsp.cfg','PlugIn'+PlugID,'Timer');
        Rs.FieldByName('PlugIn_Id').AsString:=PlugID;  //���Id
        Rs.FieldByName('PlugIn_NAME').AsString:=GetValue('plugin_name=',PlugStr); //���Name
        Rs.FieldByName('PlugIn_TIME').AsString:=GetValue('plugin_time=',PlugStr); //�������Time
        Rs.FieldByName('Update_TIME').AsString:=GetValue('update_time=',PlugStr); //������ִ��Time
        Rs.FieldByName('PlugIn_TIMER').AsString:=PlugTimer;  //������ִ��Time
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
  LogFile: string; //��־�ļ���
  sm: TMemoryStream; //�ļ�������
begin
  try
    Rs:=TZQuery(DataSet);
    Rs.Close;
    Rs.FieldDefs.Add('LOG_File',ftBlob,0,False);     //��־�ļ�
    Rs.CreateDataSet;
    LogFile:=TSrvrCtrl.GetPath+'CurLog.Log';
    SrvrObj.LogList.SaveToFile(LogFile);
    SrvrObj.LogList.Clear;
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
      //��ɾ��ǰһ����������ʷ��¼
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
  //1���ж�SvcMgr�Ƿ�����:
  InstCode:='{A16ABE7C-AEEA-4BAB-B2E0-DB9D097D5E9B}';
  if (Params<>nil) and (Params.FindParam('INSTCODE')<>nil) then
    InstCode:=Params.FindParam('INSTCODE').AsString;
  TSrvrCtrl.CheckSvcMgrRun(InstCode);

  //2���ֽ�Task��������
  if Params.FindParam('DoTaskCmd')<>nil then
  begin
    {== 1:��ʼִ��; 2:�������; 3:������==}
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
    FIsFlag:=1; //���ϱ��λ
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
  Rs.FieldDefs.Add('PLUG_NO',ftInteger,0,true); //�������Section
  Rs.FieldDefs.Add('PLUG_Value',ftstring,255,False);  //�������Ident
  Rs.CreateDataSet;
  //�������ݿ�����                 
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

initialization
  RegisterClass(TSrvrService);
  RegisterClass(TSrvrConnetion);
  RegisterClass(TSrvrParamInfo);
  RegisterClass(TSrvrTask);
  RegisterClass(TSrvrLog);

  RegisterClass(TRemoteTask);
finalization
  UnRegisterClass(TSrvrService);
  UnRegisterClass(TSrvrConnetion);
  UnRegisterClass(TSrvrParamInfo); 
  UnRegisterClass(TSrvrTask);
  UnRegisterClass(TSrvrLog);
  
  UnRegisterClass(TRemoteTask);
end.

end.
