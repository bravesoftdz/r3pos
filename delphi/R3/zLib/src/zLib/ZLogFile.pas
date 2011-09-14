unit ZLogFile;

interface
uses
  VarUtils, Variants, Windows, Messages, Classes, SysUtils,ZConst,
  ZIntf;
type
TZLogFilePool=class
  private
    FList:TStringList;
    FThreadLock:TRTLCriticalSection;
    FDefaultPath: string;
    F:TextFile;
    Ffilename: string;
    FShowing: boolean;
    procedure Enter;
    procedure Leave;
    procedure SetDefaultPath(const Value: string);
    procedure Setfilename(const Value: string);
    procedure SetShowing(const Value: boolean);
  protected
    function OpenLogFile:boolean;
    procedure CloseLogFile;
  public
    NoLog:boolean;
    procedure Clear;
    procedure AddLogFile(InfoType: Integer;Information:string;InfoSource:string='';Operation:string='';InfoID:Integer=-1;ComputerName:string='');
    function ReadLogFile:string;
    constructor Create;
    destructor Destroy; override;
    property DefaultPath:string read FDefaultPath write SetDefaultPath;
    property filename:string read Ffilename write Setfilename;
    property Showing:boolean read FShowing write SetShowing;
  end;
var LogFile:TZLogFilePool;
implementation
uses Forms;
{ TZLogFilePool }

procedure TZLogFilePool.AddLogFile(InfoType: Integer;Information:string;InfoSource:string;Operation:string;InfoID:Integer;ComputerName:string);
var myFile:string;
begin
   if NoLog then Exit;
   Enter;
   try
     //if FindCmdLineSwitch('DEBUG',['-','+'],false) then //调试模式
     //if not OpenLogFile then Exit;
     try
       myFile := DefaultPath+'log\log'+formatDatetime('YYYYMMDD',date)+'.log';
       AssignFile(F,myFile);
       if FileExists(myFile) then Append(F) else rewrite(F);
       try
         Writeln(F,'<'+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+'>'+Information);
       finally
         CloseFile(F);
       end;
     except
     end;
     if (MainFormHandle>0) and Showing then
        begin
          Flist.Add('<'+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+'>'+Information);
          PostMessage(MainFormHandle,WM_LOGFILE_UPDATE,0,0);
        end;
   finally
     Leave;
   end;
end;

procedure TZLogFilePool.Clear;
var i:Integer;
begin
  Enter;
  try
    FList.Clear;
  finally
    Leave;
  end;
end;

procedure TZLogFilePool.CloseLogFile;
begin
//  if FileName<>'' then CloseFile(F);
  FileName := '';
end;

constructor TZLogFilePool.Create;
begin
  DefaultPath := ExtractShortPathName(ExtractFilePath(ParamStr(0)));
  ForceDirectories(DefaultPath+'log');
//  if FindCmdLineSwitch('DEBUG',['-','+'],false) then //调试模式
//  begin
//    AssignFile(F,DefaultPath+'debug\debug.txt');
//    rewrite(f);
//  end;
//  OpenLogFile;
  Showing := false;
  NoLog := false;
  InitializeCriticalSection(FThreadLock);
  FList := TStringList.Create;
end;

destructor TZLogFilePool.Destroy;
begin
  Enter;
  try
    inherited;
//    if FindCmdLineSwitch('DEBUG',['-','+'],false) then //调试模式
//       CloseFile(F);
    CloseLogFile;
    LogFile := nil;
  finally
    Leave;
    DeleteCriticalSection(FThreadLock);
  end;
end;

procedure TZLogFilePool.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

procedure TZLogFilePool.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

function TZLogFilePool.OpenLogFile:boolean;
var
  myFile:string;
  s:string;
begin
  s:= ExtractFileName(ParamStr(0));
  delete(s,pos('.',s),255);
  result := not NoLog;
  if NoLog then Exit;
  try
    myFile := DefaultPath+'log\'+s+formatDatetime('YYYYMMDD',date)+'.log';
    if myFile=FileName then Exit else CloseLogFile;
    AssignFile(F,myFile);
    if FileExists(myFile) then Append(F) else rewrite(F);
    FileName := myFile;
    NoLog := false;
    result := true;
  except
    NoLog := true;
    result := not NoLog;
  end;
end;

function TZLogFilePool.ReadLogFile: string;
begin
 Enter;
 try
   result := '';
   if FList.Count > 0 then
      begin
        result := FList[0];
        FList.Delete(0); 
      end;
 finally
   Leave;
 end;
end;

procedure TZLogFilePool.SetDefaultPath(const Value: string);
begin
  FDefaultPath := Value;
end;

procedure TZLogFilePool.Setfilename(const Value: string);
begin
  Ffilename := Value;
end;

procedure TZLogFilePool.SetShowing(const Value: boolean);
begin
  FShowing := Value;
end;

initialization
  LogFile := TZLogFilePool.Create;
finalization
  LogFile.Free;
end.
