unit uTask;

interface
uses
  Windows, Messages, SysUtils, Classes, DateUtils, ActiveX, Forms, Registry,EncDec,ZLogFile,ZPlugIn,ZBase;
type

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
  
  TTaskThread=class(TThread)
  private
    FhEvent: THandle;
    FWorking: boolean;
    FStartTime: Int64;
    FStoped: boolean;
    FTenantName: string;
    FTenantId: string;
    procedure SetWorking(const Value: boolean);
    procedure SetStartTime(const Value: Int64);
    procedure SetStoped(const Value: boolean);
    procedure SetTenantId(const Value: string);
    procedure SetTenantName(const Value: string);
  public
    procedure WriteLogFile(s:string);
    procedure TaskSetEvent;
    function CheckTimer(PlugIn:TPlugIn):boolean;
    procedure WriteTimer(PlugIn:TPlugIn);
    function GetTimer(PlugIn:TPlugIn):TTaskTimer;
    procedure Execute; override;
    constructor Create;
    destructor Destroy; override;
    property Working:boolean read FWorking write SetWorking;
    property StartTime:Int64 read FStartTime write SetStartTime;
    property Stoped:boolean read FStoped write SetStoped;
    property TenantId:string read FTenantId write SetTenantId;
    property TenantName:string read FTenantName write SetTenantName;
  end;
var
  TaskThread:TTaskThread;
implementation
uses IniFiles,uFnUtil,encddecd;
{ TTaskTimer }

procedure TTaskTimer.Decode(Str: string);
var s:string;
  Size:Integer;
  sm:TStringStream;
  tt:TTimerType;
begin
  if Str='' then
     begin
       TimerType := ttNone;
       Exit;
     end;
  s := DecodeString(Str);
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

    result := EncodeString(s);
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

{ TTaskThread }

constructor TTaskThread.Create;
begin
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
var
  n:integer;
  ErrId:integer;
  PlugIn:TPlugIn;
  StartTime:Int64;
  V:OleVariant;
  Params:TftParamList;
begin
  inherited;
  PlugIn := nil;
  CoInitializeEx(nil,COINIT_MULTITHREADED);
  Params := TftParamList.Create(nil);
  try
  ResetEvent(FhEvent);
  n := 0;
  while not Terminated do
    begin
      WaitForSingleObject(FhEvent, 5000);
      ResetEvent(FhEvent);
      if Stoped then continue;
      if PlugIn=nil then
         begin
           if n>(PlugInList.Count-1) then n := 0;
           if PlugInList.Items[n].Working=0 then
              PlugIn := PlugInList.Items[n];
           inc(n);
           if (PlugIn<>nil) and not CheckTimer(PlugIn) then
              begin
                PlugIn := nil;
                Continue;
              end;
         end;
      Working := true;
      try
        StartTime := GetTickCount;
        try
          Params.ParamByName('TENANT_ID').AsString := TenantId; 
          Params.ParamByName('flag').AsInteger := -1;
          PlugIn.DLLDoExecute(TftParamList.Encode(Params),V);
          WriteLogFile('<'+PlugIn.PlugInDisplayName+'>执行完毕,总用时:'+inttostr((GetTickCount-StartTime) div 1000)+'秒');
        except
          on E:Exception do
             begin
               WriteLogFile('<'+PlugIn.PlugInDisplayName+'>执行失败,原因:未知错误类型"'+E.Message+'"');
             end;
        end;
      finally
        GetTimer(PlugIn).NearTime := formatdatetime('YYYYMMDDHHNNSS',now());
        WriteTimer(PlugIn);
        PlugIn := nil;
        Working := false;
      end;
    end;
  finally
    Params.Free;
    CoUninitialize;
  end;
end;

procedure TTaskThread.TaskSetEvent;
begin
  SetEvent(FhEvent);
end;

procedure TTaskThread.SetWorking(const Value: boolean);
begin
  FWorking := Value;
end;

procedure TTaskThread.WriteLogFile(s:string);
begin
  LogFile.AddLogFile(0,s,'任务');  
end;

procedure TTaskThread.SetStartTime(const Value: Int64);
begin
  FStartTime := Value;
end;

procedure TTaskThread.SetStoped(const Value: boolean);
begin
  FStoped := Value;
end;

function TTaskThread.CheckTimer(PlugIn:TPlugIn): boolean;
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'rsp.cfg');
  try
    if PlugIn.Data=nil then PlugIn.Data := TTaskTimer.Create;
    GetTimer(PlugIn).Decode(F.ReadString('PlugIn'+inttostr(PlugIn.PlugInId),'Timer',''));
    GetTimer(PlugIn).NearTime := F.ReadString('PlugIn'+inttostr(PlugIn.PlugInId),'NearTime',GetTimer(PlugIn).NearTime);
    result := GetTimer(PlugIn).Checked;
  finally
    F.Free;
  end;
end;

function TTaskThread.GetTimer(PlugIn: TPlugIn): TTaskTimer;
begin
  result := TTaskTimer(PlugIn.Data);
end;

procedure TTaskThread.WriteTimer(PlugIn: TPlugIn);
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'rsp.cfg');
  try
    F.WriteString('PlugIn'+inttostr(PlugIn.PlugInId),'NearTime',GetTimer(PlugIn).NearTime);
  finally
    F.Free;
  end;
end;

procedure TTaskThread.SetTenantId(const Value: string);
begin
  FTenantId := Value;
end;

procedure TTaskThread.SetTenantName(const Value: string);
begin
  FTenantName := Value;
end;

initialization
  TaskThread := nil;
finalization
end.
