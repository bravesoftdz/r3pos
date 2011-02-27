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
    procedure Enter;
    procedure Leave;
    procedure SetDefaultPath(const Value: string);
  public
    procedure Clear;
    procedure AddLogFile(InfoType: Integer;Information:WideString;InfoSource:Widestring='';Operation:Widestring='';InfoID:Integer=-1;ComputerName:WideString='');
    function ReadLogFile:string;
    constructor Create;
    destructor Destroy; override;
    property  DefaultPath:string read FDefaultPath write SetDefaultPath;
  end;
var LogFile:TZLogFilePool;
implementation
uses Forms;
{ TZLogFilePool }

procedure TZLogFilePool.AddLogFile(InfoType: Integer;Information:WideString;InfoSource:Widestring;Operation:Widestring;InfoID:Integer;ComputerName:WideString);
begin
   Enter;
   try
     Flist.Add('<'+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+'>'+#13+Information);
     if MainFormHandle>0 then PostMessage(MainFormHandle,WM_LOGFILE_UPDATE,0,0);
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

constructor TZLogFilePool.Create;
begin
  DefaultPath := ExtractFilePath(ParamStr(0))+'\log\';
  InitializeCriticalSection(FThreadLock);
  FList := TStringList.Create;
end;

destructor TZLogFilePool.Destroy;
begin
  Enter;
  try
    inherited;
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

initialization
  LogFile := TZLogFilePool.Create;
finalization
  LogFile.Free;
end.
