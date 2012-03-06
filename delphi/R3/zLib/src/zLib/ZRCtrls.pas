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
    //�����ַ�ֵ
    class function GetParamValue(var LStr: string; CodeStr,FlagStr: string): string;
    class function GetParamValueInt(var LStr: string; CodeStr,FlagStr: string): integer;
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
    //ֹͣ����
    function StopService(AServName: string): Boolean;
    //����������
    function ReStartService(AServName: string): Boolean;
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  {==����Socket���Ӳ���==}
  TSrvrPortInfo=class(TZFactory)
  private
    DoTaskIdx: integer;
    function CheckSrvrPort:Boolean;     //�ж϶˿��Ƿ�ռ��
    function OpenSrvrPortList: Boolean; //����SrvrPortList
    function SaveSrvrPortList: Boolean; //����SrvrPortList
  public
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  {==����״̬: DoTaskCmd:(0:��ѯ���ݿ�����); ==}
  TSrvrDBConnetion=class(TZFactory)
  private
    DoTaskIdx: integer;
    FDBList: TStringList;
    function OpenDBList: Boolean;  //�򿪷���DBList
    function CheckDBConnect: Boolean;  //��������DBList
    function SaveDBList: Boolean;  //��������DBList
  public
    constructor Create(ADataSet: TDataSet);override;
    destructor  Destroy;override;
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  {==����״̬: DoTaskCmd:(0:��ѯ���ݿ�Ϳͻ�������;1:��ѯ���ݿ�����;2:��ѯ�ͻ�������;3:�Ͽ��ͻ�������); ==}
  TClientConnetion=class(TZFactory)
  private
    DoTaskIdx: integer;
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
    //����ˢ������(���ؿͻ�������List)
    function OpenClientConnectionList: Boolean;
    //�Ƴ��ͻ�������
    function RemoveClientConnected: Boolean;  
  public
    //����֮ǰ�������ļ�����
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��ȡSelectSQL֮ǰ��ͨ�����ڴ��� SelectSQL  ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {==������Ȳ���==}
  TSrvrPlugInInfo=class(TZFactory)
  private
    FIsFlag: integer;  //���б��λ
    //���ݿͻ��˴������ֵ��ִ����Ӧָ��
    function DoTaskCommand(ObjectFactory:IdbHelp): integer;
    function BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
  public
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

function TClientConnetion.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TClientConnetion.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  DoTaskIdx:=0;
  if Params.FindParam('DoTaskCmd')<>nil then
    DoTaskIdx:=StrToIntDef(Params.FindParam('DoTaskCmd').AsString,0);
  case DoTaskIdx of
   0: result:=OpenClientConnectionList;  //ֻ����ˢ���б�
   1: result:=RemoveClientConnected;     //�Ƴ��ͻ�������
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

{ TSrvrDBConnetion }

function TSrvrDBConnetion.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  DoTaskIdx:=0;
  if Params.FindParam('DoTaskCmd')<>nil then
    DoTaskIdx:=StrToIntDef(Params.FindParam('DoTaskCmd').AsString,0);
  case DoTaskIdx of
   0: OpenDBList;  //ֻ����
   1: CheckDBConnect; 
   2: SaveDBList;  //���ж��Ƿ��������ڱ���
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
  Rs.FieldDefs.Add('ReRun',ftBoolean,0,true);        //����DB_ID
  Rs.CreateDataSet;
  Rs.Append;
  Rs.FieldByName('ReRun').AsBoolean:=False;
  Rs.Post;

  if Params.FindParam('DB_CONSTR')<>nil then DBCon:=Params.FindParam('DB_CONSTR').AsString;   //���ݿ��¼����
  if DBCon<>'' then
  begin
    try
      dbHelp := TdbHelp.Create;
      dbHelp.Initialize(DecStr(DBCon,ENC_KEY));
      dbHelp.Connect;
      //�����ϱ������
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
  Rs.FieldDefs.Add('DB_ID',ftstring,20,False);        //����DB_ID
  Rs.FieldDefs.Add('DB_TYPE',ftstring,20,False);      //���ݿ�����
  Rs.FieldDefs.Add('DB_HOSTNAME',ftstring,50,False);  //���ݿ�������
  Rs.FieldDefs.Add('DB_DBNAME',ftstring,50,False);    //���ݿ����
  Rs.FieldDefs.Add('DB_USERID',ftstring,50,False);    //���ݿ��¼�û���
  Rs.FieldDefs.Add('DB_PWD',ftstring,60,False);       //���ݿ��¼����
  Rs.FieldDefs.Add('DB_STATUS',ftInteger,0,False);       //���ݿ��¼����
  Rs.CreateDataSet;
  //�������ݿ�����
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
  Rs.FieldDefs.Add('ReRun',ftBoolean,0,true);        //����DB_ID
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
  if Params.FindParam('DB_ID')<>nil then DBID:=Params.FindParam('DB_ID').AsString;  //����DB_ID
  if Params.FindParam('DB_TYPE')<>nil then DbType:=Params.FindParam('DB_TYPE').AsString;  //���ݿ�����
  if Params.FindParam('DB_HOSTNAME')<>nil then DbHost:=Params.FindParam('DB_HOSTNAME').AsString;  //���ݿ�������
  if Params.FindParam('DB_DBNAME')<>nil then DBName:=Params.FindParam('DB_DBNAME').AsString;  //���ݿ����
  if Params.FindParam('DB_USERID')<>nil then DBUID:=Params.FindParam('DB_USERID').AsString;   //���ݿ��¼�û���
  if Params.FindParam('DB_PWD')<>nil then DBPwd:=Params.FindParam('DB_PWD').AsString;    //���ݿ��¼����
  if Params.FindParam('DB_CONSTR')<>nil then DBCon:=Params.FindParam('DB_CONSTR').AsString;   //���ݿ��¼����
  if (DBID<>'') and (DbHost<>'') then
  begin
    try
      dbHelp := TdbHelp.Create;
      dbHelp.Initialize(DecStr(DBCon,ENC_KEY));
      dbHelp.Connect;
      //�����ϱ������
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
  Rs.FieldDefs.Add('Con_ID',ftstring,30,False);         //����ID(SESION_ID,SRVR_ID)
  Rs.FieldDefs.Add('Con_DB_ID',ftstring,30,False);      //����ID(DB_ID)
  Rs.FieldDefs.Add('Con_PROT',ftstring,10,False);       //���Ӷ˿ں�
  Rs.FieldDefs.Add('Con_HOSTNAME',ftstring,60,False);   //����������
  Rs.FieldDefs.Add('Con_USERNAME',ftstring,40,False);   //�����û���
  Rs.FieldDefs.Add('Con_UPTIME',ftstring,30,False);     //���Ӹ���ʱ��
  Rs.CreateDataSet;
  //����ͻ�������
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
  Rs.FieldDefs.Add('Con_ID',ftstring,30,True);          //����ID(SESION_ID,SRVR_ID)
  Rs.FieldDefs.Add('Con_STATUS',ftInteger,0,False);      //����״̬
  Rs.CreateDataSet;
  //ִ���Ƴ�����
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
   0: result:=OpenSrvrPortList;  //ֻ����ˢ���б�
   1: result:=CheckSrvrPort;     //�ж϶˿��Ƿ�ռ��
   2: result:=SaveSrvrPortList;  //����˿ڲ���
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
  Rs.FieldDefs.Add('ReRun',ftBoolean,0,true); //ԭ�˿ں�(����ʹ��)
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
  Rs.FieldDefs.Add('SRVR_PORT_OLD',ftInteger,0,true); //ԭ�˿ں�(����ʹ��)
  Rs.FieldDefs.Add('SRVR_PORT',ftInteger,0,true);     //�˿ں�
  Rs.FieldDefs.Add('SRVR_ThreadCacheSize',ftInteger,0,False);   //�̻߳�����
  Rs.FieldDefs.Add('SRVR_TIMEOUT',ftInteger,0,False);     //���������
  Rs.FieldDefs.Add('SRVR_KeepActive',ftBoolean,0,False);  //��������(0:������;1:����)
  Rs.FieldDefs.Add('SRVR_STATUS',ftInteger,0,False);       //��¼״̬(0:����; 1:���; 2:�޸�; 2:ɾ��)
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
  Rs.FieldDefs.Add('ReRun',ftBoolean,0,true); //ԭ�˿ں�(����ʹ��)
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
