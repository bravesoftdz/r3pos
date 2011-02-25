unit uTask;

interface
uses
  Windows, Messages, SysUtils, Classes, DateUtils, ActiveX, Forms, Registry,EncDec;
type
ITaskCallBack = interface(IUnknown)
  ['{F1CAB69E-F292-4EC2-9DAF-CE7D24A242C3}']
    //读取帐套配置数
    function GetConnectCount:integer;stdcall;
    //按下标读取数据库连接字符串
    function GetConnectString(idx:integer):Pchar;stdcall;
    //按在线Session数
    function GetSessionCount:integer;stdcall;
    //按下标读取SessionID号
    function GetSessionID(idx:integer):integer;stdcall;
    //向指定Session客户端发送信息服务
    function SendMsgToSession(SessionID:integer;Msg:Pchar):boolean;stdcall;
    //回写日志服务
    function WriteLogFile(Msg:Pchar):boolean;stdcall;
    //写配置文件
    function WriteConfig(Header:Pchar;Ident:Pchar;Value:Pchar):boolean;stdcall;
    //读配置文件
    function ReadConfig(Header:Pchar;Ident:Pchar):Pchar;stdcall;
    //读主程序Handle
    function GetWndHandle:Integer;stdcall;
  end ;
  TDoTaskCallBack = class(TInterfacedObject, ITaskCallBack)
  private
    FSysId: string;
    r1:string;
    r2:string;
    procedure SetSysId(const Value: string);
  private
    constructor Create(SysId:string);
    destructor Destroy; override;
    //读取帐套配置数
    function GetConnectCount:integer;stdcall;
    //按下标读取数据库连接字符串
    function GetConnectString(idx:integer):Pchar;stdcall;
    //按在线Session数
    function GetSessionCount:integer;stdcall;
    //按下标读取SessionID号
    function GetSessionID(idx:integer):integer;stdcall;
    //向指定Session客户端发送信息服务
    function SendMsgToSession(SessionID:integer;Msg:Pchar):boolean;stdcall;
    //回写日志服务
    function WriteLogFile(Msg:Pchar):boolean;stdcall;
    //写配置文件
    function WriteConfig(Header:Pchar;Ident:Pchar;Value:Pchar):boolean;stdcall;
    //读配置文件
    function ReadConfig(Header:Pchar;Ident:Pchar):Pchar;stdcall;
    //读主程序Handle
    function GetWndHandle:Integer;stdcall;
    property SysId:string read FSysId write SetSysId;
  end;
  
  TGetTaskName=function :Pchar; stdcall;
  TExecute=function :integer; stdcall;
  TUserExecute=function :integer; stdcall;
  TGetErrInfo=function(ErrID:integer):Pchar; stdcall;
  TTaskConfig=procedure ; stdcall;
  TSetCallBack=procedure(CallBack:ITaskCallBack); stdcall;
  TGetTaskSysId=function :Pchar; stdcall;

  TTimerType=(ttNone,ttDay,ttWeek,ttMonth);
  TTaskTimer=class
  private
    FTimerType: TTimerType;
    FWeekIntrl: Integer;
    FMonthDay: Integer;
    FMonthWeek: Integer;
    FDayIntrl: Integer;
    FMonthType: Integer;
    FMonthEntr: Integer;
    FTime: string;
    FWeeks: string;
    FOneDay: string;
    FTimeIntrl: integer;
    FNearTime: string;
    procedure SetTimerType(const Value: TTimerType);
    procedure SetDayIntrl(const Value: Integer);
    procedure SetMonthDay(const Value: Integer);
    procedure SetMonthEntr(const Value: Integer);
    procedure SetMonthType(const Value: Integer);
    procedure SetMonthWeek(const Value: Integer);
    procedure SetOneDay(const Value: string);
    procedure SetTime(const Value: string);
    procedure SetWeekIntrl(const Value: Integer);
    procedure SetWeeks(const Value: string);
    procedure SetTimeIntrl(const Value: integer);
    procedure SetNearTime(const Value: string);
  public
    procedure Decode(Str:string);
    function  EnCode:string;
    function  Checked: Boolean;

    property TimerType:TTimerType read FTimerType write SetTimerType;
    //按天时，每几天执行
    property DayIntrl:Integer read FDayIntrl write SetDayIntrl;
    //按周时,间隔几周执行
    property WeekIntrl:Integer read FWeekIntrl write SetWeekIntrl;
    //按周时，执行周次 1111111 第一位表示周日
    property Weeks:string read FWeeks write SetWeeks;
    //0 指定几号  1 按周执行
    property MonthType:Integer read FMonthType write SetMonthType;
    //按月指定几号执行
    property MonthDay:Integer read FMonthDay write SetMonthDay;
    //按月指定第几周执行
    property MonthEntr:Integer read FMonthEntr write SetMonthEntr;
    //按月指定的周几执行
    property MonthWeek:Integer read FMonthWeek write SetMonthWeek;
    //执行时间
    property Time:string read FTime write SetTime;
    //执行间隔时间 分
    property TimeIntrl:integer read FTimeIntrl write SetTimeIntrl;
    //最近执行时间
    property NearTime:string read FNearTime write SetNearTime;
    
  end;
  TTaskLogFile=class
  private
    FsTaskName: string;
    FsTime: string;
    FsMsg: string;
    procedure SetsMsg(const Value: string);
    procedure SetsTaskName(const Value: string);
    procedure SetsTime(const Value: string);
  public
    property sTime:string read FsTime write SetsTime;
    property sTaskName:string read FsTaskName write SetsTaskName;
    property sMsg:string read FsMsg write SetsMsg;
  end;

  TTaskFactory=class
  private
    FHandle: THandle;
    FTaskTimer: TTaskTimer;
    FFileName: string;
    FLogList:TList;
    FTaskName:string;
    FlPostion: integer;
    procedure SetHandle(const Value: THandle);
    function GetTaskName: string;
    procedure SetTaskTimer(const Value: TTaskTimer);
    procedure SetFileName(const Value: string);
    procedure SetlPostion(const Value: integer);
    function GetLogCount: integer;
    function GetLogs(itemindex: integer): TTaskLogFile;
    procedure SetLogs(itemindex: integer; const Value: TTaskLogFile);
  public
    FCallBack:ITaskCallBack;
    DllGetTaskName:TGetTaskName;
    DllExecute:TExecute;
    DllUserExecute:TUserExecute;
    DllGetErrInfo:TGetErrInfo;
    DllTaskConfig:TTaskConfig;
    DllSetCallBack:TSetCallBack;
    DllGetTaskSysId:TGetTaskSysId;
    procedure LoadLogFile;
    procedure WriteLogFile(s:string);
    procedure ResetLogFile;
    constructor Create;
    destructor Destroy; override;
    procedure ReadConfig;
    procedure WriteConfig(flag:integer=0);
    property TaskName:string read GetTaskName;
    procedure Load(_FileName:string);
    property Handle:THandle read FHandle write SetHandle;
    property TaskTimer:TTaskTimer read FTaskTimer write SetTaskTimer;
    property FileName:string read FFileName write SetFileName;
    property lPostion:integer read FlPostion write SetlPostion;
    property LogCount:integer read GetLogCount;
    property Logs[itemindex:integer]:TTaskLogFile read GetLogs write SetLogs;
  end;
  TTaskContainer=class
  private
    FList:TList;
    function GetCount: integer;
    function GetTask(ItemIndex: integer): TTaskFactory;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Load;
    procedure Clear;
    property Task[ItemIndex:integer]:TTaskFactory read GetTask;
    property Count:integer read GetCount;
  end;
  TTaskThread=class(TThread)
  private
    FhEvent: THandle;
    FWorking: boolean;
    FTaskFactory: TTaskFactory;
    FStartTime: Int64;
    FStoped: boolean;
    procedure SetWorking(const Value: boolean);
    procedure SetTaskFactory(const Value: TTaskFactory);
    procedure SetStartTime(const Value: Int64);
    procedure SetStoped(const Value: boolean);
  public
    procedure WriteLogFile(s:string);
    procedure TaskSetEvent;
    procedure Execute; override;
    constructor Create;
    destructor Destroy; override;
    property Working:boolean read FWorking write SetWorking;
    property TaskFactory:TTaskFactory read FTaskFactory write SetTaskFactory;
    property StartTime:Int64 read FStartTime write SetStartTime;
    property Stoped:boolean read FStoped write SetStoped;
  end;
var Tasks:TTaskContainer;
    TaskThread:TTaskThread;
implementation
uses IniFiles,uFnUtil,uIdComm,uIdLogFile;
{ TTaskTimer }

procedure TTaskTimer.Decode(Str: string);
var s:string;
  Size:Integer;
  sm:TStringStream;
  tt:TTimerType;
begin
  if Str='' then Exit;
  s := gsmString2Bytes(Str);
  sm := TStringStream.Create(s);
  try
    sm.ReadBuffer(tt,SizeOf(TimerType));
    TimerType := tt;
    sm.ReadBuffer(Size,SizeOf(DayIntrl));
    DayIntrl := Size;
    sm.ReadBuffer(Size,SizeOf(WeekIntrl));
    WeekIntrl := Size;
    sm.ReadBuffer(Size,SizeOf(Size));
    if Size<>0 then
       begin
         SetLength(s,Size);
         sm.ReadBuffer(Pchar(s)^,Size);
         Weeks := s;
       end;
    sm.ReadBuffer(Size,SizeOf(MonthType));
    MonthType := Size;
    sm.ReadBuffer(Size,SizeOf(MonthDay));
    MonthDay := Size;
    sm.ReadBuffer(Size,SizeOf(MonthEntr));
    MonthEntr := Size;
    sm.ReadBuffer(Size,SizeOf(MonthWeek));
    MonthWeek := Size;

    sm.ReadBuffer(Size,SizeOf(Size));
    if Size<>0 then
       begin
         SetLength(s,Size);
         sm.ReadBuffer(Pchar(s)^,Size);
         Time := s;
       end;
    sm.ReadBuffer(Size,SizeOf(TimeIntrl));
    TimeIntrl := Size;
  finally
    sm.Free;
  end;
end;

function TTaskTimer.EnCode: string;
var sm:TStringStream;
  Size:Integer;
  s:string;
begin
  sm := TStringStream.Create('');
  try
    sm.Write(TimerType,SizeOf(TimerType));

    sm.Write(DayIntrl,SizeOf(DayIntrl));
    sm.Write(WeekIntrl,SizeOf(WeekIntrl));

    Size := length(Weeks);
    sm.Write(Size,SizeOf(Size));
    if Size<>0 then
       sm.Write(Pchar(Weeks)^,Size);

    sm.Write(MonthType,SizeOf(MonthType));
    sm.Write(MonthDay,SizeOf(MonthDay));
    sm.Write(MonthEntr,SizeOf(MonthEntr));
    sm.Write(MonthWeek,SizeOf(MonthWeek));
    Size := length(Time);
    sm.Write(Size,SizeOf(Size));
    if Size<>0 then
       sm.Write(Pchar(Time)^,Size);
    sm.Write(TimeIntrl,SizeOf(TimeIntrl));

    s := sm.DataString;

    result := gsmBytes2String(s);
  finally
    sm.Free;
  end;
end;

function TTaskTimer.Checked: Boolean;
var aDate:string;
  t:real;
begin
  result := false;
  if NearTime='' then NearTime := '20000101010000';
  aDate := copy(NearTime,1,8);
  if aDate<>formatDatetime('YYYYMMDD',date()) then
     NearTime := aDate + '000000';
  case TimerType of
  ttNone:Exit;
  ttDay:begin
      if DayIntrl=0 then Exit;
      Result := ((trunc(Date()-fnTime.fnStrtoDate(aDate)) mod DayIntrl)=0);
    end;
  ttWeek:begin
      if WeekIntrl=0 then Exit;
      result := (trunc((WeekOfTheYear(Date())-WeekOfTheYear(fnTime.fnStrtoDate(aDate))) mod WeekIntrl)=0);
      result := result and (Weeks[DayOfWeek(Date())]='1');
    end;
  ttMonth:begin
      case MonthType of
      0:begin
          if MonthDay=0 then Exit;
          result := (DayOf(Date())=MonthDay);
        end;
      1:begin
          if MonthEntr=0 then Exit;
          result := ((WeekOfTheYear(Date())-WeekOfTheYear(EncodeDate(YearOf(Date()),MonthOf(Date()),1))+1)=MonthEntr);
          result := result and (DayOfWeek(Date())=MonthWeek);
        end;
      end;
    end;
  end;
  if Time<> '00:00:00' then
     Result := Result
               and (Time<=formatDatetime('HH:NN:SS',now()))
               and (Time>formatdatetime('HH:NN:SS',fnTime.fnStrToDatetime(NearTime)))
  else
     begin
       if TimeIntrl>0 then
       begin
         t := now()-fnTime.fnStrToDatetime(NearTime);
         Result := Result
                 and (trunc(t*24*60) >=TimeIntrl)
       end
       else
         result := false;
     end;
  if result then
     NearTime := formatdatetime('YYYYMMDDHHNNSS',now());
end;

procedure TTaskTimer.SetDayIntrl(const Value: Integer);
begin
  FDayIntrl := Value;
end;

procedure TTaskTimer.SetMonthDay(const Value: Integer);
begin
  FMonthDay := Value;
end;

procedure TTaskTimer.SetMonthEntr(const Value: Integer);
begin
  FMonthEntr := Value;
end;

procedure TTaskTimer.SetMonthType(const Value: Integer);
begin
  FMonthType := Value;
end;

procedure TTaskTimer.SetMonthWeek(const Value: Integer);
begin
  FMonthWeek := Value;
end;

procedure TTaskTimer.SetOneDay(const Value: string);
begin
  FOneDay := Value;
end;

procedure TTaskTimer.SetTime(const Value: string);
begin
  FTime := Value;
end;

procedure TTaskTimer.SetTimerType(const Value: TTimerType);
begin
  FTimerType := Value;
end;

procedure TTaskTimer.SetWeekIntrl(const Value: Integer);
begin
  FWeekIntrl := Value;
end;

procedure TTaskTimer.SetWeeks(const Value: string);
begin
  FWeeks := Value;
end;

procedure TTaskTimer.SetTimeIntrl(const Value: integer);
begin
  FTimeIntrl := Value;
end;

procedure TTaskTimer.SetNearTime(const Value: string);
begin
  FNearTime := Value;
end;

{ TTaskFactory }

constructor TTaskFactory.Create;
begin
  FTaskTimer := TTaskTimer.Create;
  FLogList := TList.Create;
end;

destructor TTaskFactory.Destroy;
var i:integer;
begin
  ResetLogFile;
  for i:=0 to FLogList.Count -1 do TObject(FLogList[i]).Free;
  FLogList.Free;
  FTaskTimer.Free;
  if Handle<>0 then
     begin
       DllSetCallBack(nil);
       FreeLibrary(Handle);
     end;
  FCallBack := nil;
  inherited;
end;

function TTaskFactory.GetLogCount: integer;
begin
  result := FLogList.Count;
end;

function TTaskFactory.GetLogs(itemindex: integer): TTaskLogFile;
begin
  result := TTaskLogFile(FLogList[itemindex]);
end;

function TTaskFactory.GetTaskName: string;
begin
  if FTaskName= '' then
     result := StrPas(DllGetTaskName)
  else
     result := FTaskName;
  FTaskName := result;
end;

procedure TTaskFactory.Load(_FileName: string);
begin
  FileName := _FileName;
  FHandle := LoadLibrary(Pchar(FileName));
  if Handle=0 then Raise Exception.Create('无效插件文件'+FileName);
  try
    @DllGetTaskName := GetProcAddress(Handle, 'GetTaskName');
    if @DllGetTaskName=nil then Raise Exception.Create('GetTaskName方法没有实现');
    @DllExecute := GetProcAddress(Handle, 'Execute');
    if @DllExecute=nil then Raise Exception.Create('Execute方法没有实现');
    @DllUserExecute := GetProcAddress(Handle, 'UserExecute');
    if @DllUserExecute=nil then Raise Exception.Create('UserExecute方法没有实现');
    @DllGetErrInfo := GetProcAddress(Handle, 'GetErrInfo');
    if @DllGetErrInfo=nil then Raise Exception.Create('GetErrInfo方法没有实现');
    @DllTaskConfig := GetProcAddress(Handle, 'TaskConfig');
    if @DllTaskConfig=nil then Raise Exception.Create('TaskConfig方法没有实现');
    @DllSetCallBack := GetProcAddress(Handle, 'SetCallBack');
    if @DllSetCallBack=nil then Raise Exception.Create('SetCallBack方法没有实现');
    @DllGetTaskSysId := GetProcAddress(Handle, 'GetTaskSysId');
    if @DllGetTaskSysId=nil then Raise Exception.Create('GetTaskSysId方法没有实现');
    FCallBack := TDoTaskCallBack.Create(DllGetTaskSysId);
    DllSetCallBack(FCallBack);
    ReadConfig;
  except
    FreeLibrary(Handle);
    Handle := 0;
    Raise;
  end;
end;

procedure TTaskFactory.LoadLogFile;
var F:TextFile;
  s:string;
  TaskLogFile:TTaskLogFile;
begin
  if not FileExists(FileName+'.log') then Exit;
  AssignFile(F,FileName+'.log');
  reset(f);
  try
    while not eof(f) do
    begin
      readln(f,s);
      if s<>'' then
         begin
           TaskLogFile := TTaskLogFile.Create;
           TaskLogFile.sTaskName := TaskName;
           TaskLogFile.sTime := copy(s,1,19);
           TaskLogFile.sMsg := copy(s,20,255);
           FLogList.Add(TaskLogFile);
         end;
    end;
    FlPostion := 0;
  finally
    closefile(f);
  end;
end;

procedure TTaskFactory.ReadConfig;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(FileName)+'config.ini');
  try
    FTaskTimer.Decode(F.ReadString(ExtractFileName(FileName),'Timer',''));
    FTaskTimer.NearTime := F.ReadString(ExtractFileName(FileName),'NearTime',FTaskTimer.NearTime);
  finally
    F.Free;
  end;
end;

procedure TTaskFactory.ResetLogFile;
var F:TextFile;
  i:integer;
begin
  if FileName='' then Exit;
  if FLogList.Count > 100 then
     begin
        while FLogList.Count > 100 do
           begin
              TObject(FLogList[0]).Free;
              FLogList.Delete(0);
           end;
        AssignFile(F,FileName+'.log');
        rewrite(f);
        try
          for i:=0 to FLogList.Count -1 do
             writeln(f,TTaskLogFile(FLogList[i]).sTime+TTaskLogFile(FLogList[i]).sMsg);
        finally
          closefile(f);
        end;
     end;
end;

procedure TTaskFactory.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TTaskFactory.SetHandle(const Value: THandle);
begin
  FHandle := Value;
end;

procedure TTaskFactory.SetLogs(itemindex: integer;
  const Value: TTaskLogFile);
begin

end;

procedure TTaskFactory.SetlPostion(const Value: integer);
begin
  FlPostion := Value;
end;

procedure TTaskFactory.SetTaskTimer(const Value: TTaskTimer);
begin
  FTaskTimer := Value;
end;

procedure TTaskFactory.WriteConfig(flag:integer=0);
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(FileName)+'config.ini');
  try
    if flag=0 then
       F.WriteString(ExtractFileName(FileName),'Timer',FTaskTimer.EnCode);
    F.WriteString(ExtractFileName(FileName),'NearTime',FTaskTimer.NearTime);
  finally
    F.Free;
  end;
end;

procedure TTaskFactory.WriteLogFile(s: string);
var
  TaskLogFile:TTaskLogFile;
  F:TextFile;
begin
  TaskLogFile := TTaskLogFile.Create;
  TaskLogFile.sTaskName := TaskName;
  TaskLogFile.sTime := formatDatetime('YYYY/MM/DD HH:NN:SS',now());
  TaskLogFile.sMsg := s;
  FLogList.Add(TaskLogFile);
  AssignFile(F,FileName+'.log');
  if fileExists(FileName+'.log') then append(f) else rewrite(f);
  try
    writeln(f,TaskLogFile.sTime+TaskLogFile.sMsg);
  finally
    closefile(f);
  end;
end;

{ TTaskContainer }

procedure TTaskContainer.Clear;
var i:integer;
begin
  for i:=0 to FList.Count -1 do
    TObject(FList[i]).Free;
  FList.Clear;
end;

constructor TTaskContainer.Create;
begin
  FList := TList.Create;
end;

destructor TTaskContainer.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;
function TTaskContainer.GetCount: integer;
begin
  result := FList.Count;
end;

function TTaskContainer.GetTask(ItemIndex: integer): TTaskFactory;
begin
  result := TTaskFactory(FList[ItemIndex]);
end;

procedure TTaskContainer.Load;
var
  sr: TSearchRec;
  FileAttrs: Integer;
  Factory:TTaskFactory;
begin
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(ExtractFilePath(ParamStr(0))+'task\*.dll', FileAttrs, sr) = 0 then
    begin
      repeat
        if (sr.Attr and FileAttrs) = sr.Attr then
        begin
           Factory := TTaskFactory.Create;
           try
             Factory.Load(ExtractFilePath(ParamStr(0))+'task\'+sr.Name);
             FList.Add(Factory);
             Factory.LoadLogFile;
           except
             Factory.Free;
           end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
end;

{ TDoTaskCallBack }

constructor TDoTaskCallBack.Create(SysId:string);
begin
  inherited Create;
  FSysId := SysId;
end;

destructor TDoTaskCallBack.Destroy;
begin

  inherited;
end;

function TDoTaskCallBack.GetConnectCount: integer;
var
  Reg:TRegistry;
  vDb:TStrings;
begin
  Reg := TRegistry.Create;
  vDb := TStringList.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey('SOFTWARE\Classes\Srvr\'+SysId, False);
    Reg.GetKeyNames(vDb);
    result := vDb.Count;
  finally
    vDb.Free;
    Reg.Free;
  end;
end;

function TDoTaskCallBack.GetConnectString(idx: integer): Pchar;
var
  Reg:TRegistry;
  vDb:TStrings;
  vName:string;
  s:string;
  w:integer;
begin
  result := '';
  vDb := TStringList.Create;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey('SOFTWARE\Classes\Srvr\'+SysId, False);
    Reg.GetKeyNames(vDb);
    vName := vDb[idx];
    Reg.CloseKey;
    Reg.OpenKey('SOFTWARE\Classes\Srvr\'+SysId+'\'+vName, False);
    s := Reg.ReadString('ConnStr');
    s := DecStr(s,ENC_KEY);
    w := length(s);
    r2 := s;
    SetLength(r2,w+1);
    r2[w+1] := #0;
    result := Pchar(r2);
  finally
    Reg.Free;
    vDb.Free;
  end;
end;

function TDoTaskCallBack.GetSessionCount: integer;
begin

end;

function TDoTaskCallBack.GetSessionID(idx: integer): integer;
begin

end;

function TDoTaskCallBack.GetWndHandle: Integer;
begin
  result := Application.Handle;
end;

function TDoTaskCallBack.ReadConfig(Header, Ident: Pchar): Pchar;
var F:TIniFile;
  w:integer;
begin
  try
    result := '';
    F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'task\config.ini');
    try
    r1 := F.ReadString(StrPas(Header),StrPas(Ident),'');
    w := length(r1);
    SetLength(r1,w+1);
    r1[w+1] := #0;
    result := Pchar(r1);
    finally
      F.Free;
    end;
  except
  end;
end;

function TDoTaskCallBack.SendMsgToSession(SessionID: integer;
  Msg: Pchar): boolean;
begin

end;

procedure TDoTaskCallBack.SetSysId(const Value: string);
begin
  FSysId := Value;
end;

function TDoTaskCallBack.WriteConfig(Header, Ident, Value: Pchar): boolean;
var F:TIniFile;
begin
  try
    F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'task\config.ini');
    try
      F.WriteString(StrPas(Header),StrPas(Ident),StrPas(Value));
    finally
      F.Free;
    end;
    result := true;
  except
    result := false;
  end;
end;

function TDoTaskCallBack.WriteLogFile(Msg: Pchar): boolean;
begin

end;

{ TTaskThread }

constructor TTaskThread.Create;
begin
  TaskFactory := nil;
  FhEvent := CreateEvent(nil, True, False, nil);
  inherited Create(false);
  FreeOnTerminate := false;
end;

destructor TTaskThread.Destroy;
begin
  if FhEvent<>0 then CloseHandle(FhEvent);
  inherited;
end;

procedure TTaskThread.Execute;
var n:integer;
  ErrId:integer;
begin
  inherited;
  CoInitializeEx(nil,COINIT_MULTITHREADED);
  try
  ResetEvent(FhEvent);
  n := 0;
  while not Terminated do
    begin
      WaitForSingleObject(FhEvent, 5000);
      ResetEvent(FhEvent);
      if Stoped then continue;
      if TaskFactory=nil then
         begin
           if Tasks.Count = 0 then Exit;
           if n>(Tasks.Count-1) then n := 0;
           TaskFactory := Tasks.Task[n];
           inc(n);
           if not TaskFactory.TaskTimer.Checked then
              begin
                TaskFactory := nil;
                Continue;
              end;
         end;
      Working := true;
      try
        StartTime := GetTickCount;
        try
          ErrId := TaskFactory.DllExecute;
          if ErrId = 0 then
             WriteLogFile('执行完毕,总用时:'+inttostr((GetTickCount-StartTime) div 1000)+'秒')
          else
             WriteLogFile('执行失败,原因:'+StrPas(TaskFactory.DllGetErrInfo(ErrId)));
          TaskFactory.TaskTimer.NearTime := formatdatetime('YYYYMMDDHHNNSS',now());
          TaskFactory.WriteConfig(1);
        except
          on E:Exception do
             WriteLogFile('执行失败,原因:未知错误类型"'+E.Message+'"');
        end;
      finally
        TaskFactory := nil;
        Working := false;
      end;
    end;
  finally
    CoUninitialize;
  end;
end;

procedure TTaskThread.TaskSetEvent;
begin
  SetEvent(FhEvent);
end;

procedure TTaskThread.SetTaskFactory(const Value: TTaskFactory);
begin
  FTaskFactory := Value;
end;

procedure TTaskThread.SetWorking(const Value: boolean);
begin
  FWorking := Value;
end;

procedure TTaskThread.WriteLogFile(s:string);
begin
  FTaskFactory.WriteLogFile(s); 
end;

procedure TTaskThread.SetStartTime(const Value: Int64);
begin
  FStartTime := Value;
end;

procedure TTaskThread.SetStoped(const Value: boolean);
begin
  FStoped := Value;
end;

{ TTaskLogFile }

procedure TTaskLogFile.SetsMsg(const Value: string);
begin
  FsMsg := Value;
end;

procedure TTaskLogFile.SetsTaskName(const Value: string);
begin
  FsTaskName := Value;
end;

procedure TTaskLogFile.SetsTime(const Value: string);
begin
  FsTime := Value;
end;

initialization
  TaskThread := nil;
  Tasks := TTaskContainer.Create;
  Tasks.Load;
finalization
  Tasks.Free;
end.
