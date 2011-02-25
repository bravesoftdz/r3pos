unit ZServer;

interface
uses
  VarUtils, Variants, Windows, Messages, Classes, SysUtils,
  ScktComp, WinSock, WinInet, ComObj,zPacket,ZConst,ZIntf,ActiveX,
  ZDataSet,ZdbHelp;
type
  TDoInvokeDispatch = class(TInterfacedObject, IDoInvokeDispatch)
  private
    FInterpreter:TZCustomDataBlockInterpreter;
    FSessionID: Integer;
    procedure SetSessionID(const Value: Integer);
  protected
  public
    constructor Create(ASessionID:Integer;AInterpreter:TZCustomDataBlockInterpreter);
    destructor Destroy; override;
    //接收客户端发来的数据
    function DoInvoke(Token,LocaleID: Integer;
      Flags: Word;var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;stdcall;
    //对应SessionId
    property SessionID:Integer read FSessionID write SetSessionID;
  end;
type
  TZSession=class
  private
    FActivity: Boolean;
    FPort: string;
    FHost: string;
    FUserCode: WideString;
    FIPAddress: WideString;
    FUserName: WideString;
    FSessionID: Integer;
    FSend: ISendDataBlock;
    Fdbid: integer;
    FdbResolver: TdbResolver;
    procedure SetActivity(const Value: Boolean);
    procedure SetHost(const Value: string);
    procedure SetIPAddress(const Value: WideString);
    procedure SetPort(const Value: string);
    procedure SetUserCode(const Value: WideString);
    procedure SetUserName(const Value: WideString);
    procedure SetSend(const Value: ISendDataBlock);
    procedure Setdbid(const Value: integer);
    procedure SetdbResolver(const Value: TdbResolver);
  public
    constructor Create;
    destructor Destroy; override;
    property Activity:Boolean read FActivity write SetActivity;
    property Host:string read FHost write SetHost;
    property IPAddress:WideString read FIPAddress write SetIPAddress;
    property Port:string read FPort write SetPort;
    property UserCode:WideString read FUserCode write SetUserCode;
    property UserName:WideString read FUserName write SetUserName;

    property SessionID:Integer read FSessionID write FSessionID;
    property Send:ISendDataBlock read FSend write SetSend;
    property dbid:integer read Fdbid write Setdbid;
    property dbResolver:TdbResolver read FdbResolver write SetdbResolver;
  end;

  TZSessions=class
  private
    FList:TList;
    FThreadLock:TRTLCriticalSection;
    function GetCount: Integer;
    function GetSessions(ItemIndex: Integer): TZSession;

    procedure Enter;
    procedure Leave;

  public

    constructor Create;
    destructor Destroy; override;
    //线程安装方法
    procedure Clear;
    procedure Add(Session:TZSession);
    procedure Delete(Session:TZSession);overload;
    procedure Delete(i:Integer);overload;
    function  Find(SessionID:Integer):TZSession;
    function  FindPointer(P:Pointer):TZSession;
    //============
    property Count:Integer read GetCount;
    property Sessions[ItemIndex:Integer]:TZSession read GetSessions;
  end;

  PZDataBlock=^TZDataBlock;
  TZDataBlock=packed record
    //数据块
    Data:IDataBlock;
    //对应Session号
    SessionId:integer;
    //数据块时间
    TimeStamp:Int64;
  end;

  TZDataCache=class
  private
    FList:TList;
    FThreadLock:TRTLCriticalSection;
    Intercept: IDataIntercept;
  protected
    procedure Enter;
    procedure Leave;

    procedure FreeCache(i:integer);
  public

    constructor Create;
    destructor Destroy; override;
    function Wait:Int64;
    //线程安全方法
    procedure Add(SessionID:Integer;Data:IDataBlock);
    procedure Delete(SessionID:Integer);
    procedure Clear;
    function  Get(SessionID:Integer):IDataBlock;
    function  GetFirst:PZDataBlock;
  end;

  TZConnCache=class
  private
    FList:TList;
    FThreadLock:TRTLCriticalSection;
    FMaxCache: integer;
    procedure SetMaxCache(const Value: integer);
  protected
    procedure Enter;
    procedure Leave;

    function CreatedbResolver:TdbResolver;
    procedure FreeCache(i:integer);

  public

    constructor Create;
    destructor Destroy; override;
    //线程安全方法
    function  Get(dbid:Integer):TdbResolver;
    procedure Push(Conn:TdbResolver);
    //最大保留缓冲数
    property MaxCache:integer read FMaxCache write SetMaxCache;
  end;

var
  //Sessions 队例
  Sessions:TZSessions;
implementation
uses EncDec,Registry,IniFiles;

{ TDoInvokeDispatch }
constructor TDoInvokeDispatch.Create(ASessionID:Integer;AInterpreter:TZCustomDataBlockInterpreter);
begin
  FInterpreter:=AInterpreter;
  inherited Create;
  SessionID := ASessionID;
end;

destructor TDoInvokeDispatch.Destroy;
begin
  inherited;
end;

function TDoInvokeDispatch.DoInvoke(Token, LocaleID: Integer; Flags: Word;
  var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
{  case TSocketToken(Token) of
//    SKTLogin:Result := DoSKTLogin(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
  else
    raise EInvokeDispatchError.CreateResFmt(@SIdInvalidToken, [Token]);
  end; }
end;

procedure TDoInvokeDispatch.SetSessionID(const Value: Integer);
begin
  FSessionID := Value;
end;

{ TZSession }

constructor TZSession.Create;
begin
  dbResolver := nil;
end;

destructor TZSession.Destroy;
begin

  inherited;
end;

procedure TZSession.SetActivity(const Value: Boolean);
begin
  FActivity := Value;
end;

procedure TZSession.Setdbid(const Value: integer);
begin
  Fdbid := Value;
end;

procedure TZSession.SetdbResolver(const Value: TdbResolver);
begin
  FdbResolver := Value;
end;

procedure TZSession.SetHost(const Value: string);
begin
  FHost := Value;
end;

procedure TZSession.SetIPAddress(const Value: WideString);
begin
  FIPAddress := Value;
end;

procedure TZSession.SetPort(const Value: string);
begin
  FPort := Value;
end;

procedure TZSession.SetSend(const Value: ISendDataBlock);
begin
  FSend := Value;
end;

procedure TZSession.SetUserCode(const Value: WideString);
begin
  FUserCode := Value;
end;

procedure TZSession.SetUserName(const Value: WideString);
begin
  FUserName := Value;
end;

{ TZSessions }

procedure TZSessions.Add(Session:TZSession);
begin
  Enter;
  try
    FList.Add(Session);
  finally
    Leave;
  end;
end;

procedure TZSessions.Clear;
var i:Integer;
begin
  Enter;
  try
    for i:=0 to FList.Count -1 do
      TObject(FList[i]).Free;
    FList.Clear;
  finally
    Leave;
  end;
end;

constructor TZSessions.Create;
begin
  InitializeCriticalSection(FThreadLock);
  FList := TList.Create;
end;

procedure TZSessions.Delete(Session: TZSession);
var i:Integer;
begin
  Enter;
  try
    i := FList.IndexOf(Session);
    if i=-1 then Exit;
    TObject(FList[i]).Free;
    FList.Delete(i);
  finally
    Leave;
  end;
end;

procedure TZSessions.Delete(i: Integer);
begin
  Enter;
  try
    TObject(FList[i]).Free;
    FList.Delete(i);
  finally
    Leave;
  end;
end;

destructor TZSessions.Destroy;
begin
  Clear;
  Enter;
  try
     FList.Free;
     inherited;
  finally
     Leave;
     DeleteCriticalSection(FThreadLock);
  end;
end;

procedure TZSessions.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

function TZSessions.Find(SessionID: Integer): TZSession;
var i:Integer;
begin
  Result := nil;
  Enter;
  try
    for i:=0 to FList.Count -1 do
      begin
        if Sessions[i].SessionID = SessionID then
           begin
             Result := Sessions[i];
             Exit;
           end;
      end;
  finally
    Leave;
  end;
end;

function TZSessions.FindPointer(P: Pointer): TZSession;
var i:Integer;
begin
  Result := nil;
  Enter;
  try
    for i:=0 to FList.Count -1 do
      begin
        if Pointer(Sessions[i]) = P then
           begin
             Result := Sessions[i];
             Exit;
           end;
      end;
  finally
    Leave;
  end;
end;

function TZSessions.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TZSessions.GetSessions(ItemIndex: Integer): TZSession;
begin
  Result := TZSession(FList[ItemIndex]);
end;

procedure TZSessions.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

{ TZDataCache }

procedure TZDataCache.Add(SessionID:Integer;Data: IDataBlock);
var
  ZDataBlock:PZDataBlock;
begin
  Enter;
  try
// 接收的数据包已经压缩的
//    Intercept.DataOut(Data);
    new(ZDataBlock);
    ZDataBlock^.Data := Data;
    ZDataBlock^.SessionId := SessionID;
    ZDataBlock^.TimeStamp := GetTickCount;
    FList.Add(ZDataBlock);
  finally
    Leave;
  end;
end;

procedure TZDataCache.Clear;
var i:integer;
begin
  Enter;
  try
    for i:=FList.Count-1 downto 0 do
      begin
        FreeCache(i);
      end;
    FList.Clear;
  finally
    Leave;
  end;
end;

constructor TZDataCache.Create;
begin
  InitializeCriticalSection(FThreadLock);
  FList := TList.Create;
  Intercept := TZDataCompressor.Create;
end;

procedure TZDataCache.Delete(SessionID:Integer);
var i:integer;
begin
  Enter;
  try
    for i:=FList.Count-1 downto 0 do
      begin
        if PZDataBlock(FList[i])^.SessionId = SessionID then
           begin
             FreeCache(i);
           end;
      end;
  finally
    Leave;
  end;
end;

destructor TZDataCache.Destroy;
var i:integer;
begin
  Enter;
  try
     Intercept := nil;
     for i:=FList.Count-1 downto 0 do
        begin
          FreeCache(i);
        end;
     FList.Free;
     inherited;
  finally
     Leave;
     DeleteCriticalSection(FThreadLock);
  end;
  inherited;
end;

procedure TZDataCache.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

procedure TZDataCache.FreeCache(i: integer);
begin
  PZDataBlock(FList[i])^.Data := nil;
  Dispose(PZDataBlock(FList[i]));
  FList.Delete(i); 
end;

function TZDataCache.Get(SessionID: Integer): IDataBlock;
var
  i:integer;
begin
  Enter;
  try
    for i:=0 to FList.Count -1 do
      begin
        if PZDataBlock(FList[i])^.SessionId=SessionID then
           begin
             result := PZDataBlock(FList[i])^.Data;
             FreeCache(i);
             Intercept.DataIn(result);
           end;
      end;
  finally
    Leave;
  end;
end;

function TZDataCache.GetFirst: PZDataBlock;
var
  mm:TMemoryStream;
begin
  Enter;
  try
    result := nil;
    if FList.Count = 0 then Exit;
    result := PZDataBlock(FList[0]);
    FList.Delete(0);
    Intercept.DataIn(result^.Data);
  finally
    Leave;
  end;
  mm := TMemoryStream.Create;
  try
    mm.CopyFrom(result^.Data.Stream,result^.Data.Stream.Size);
    mm.SaveToFile('d:\debug\recv.txt');
  finally
    mm.Free;
  end;
end;

procedure TZDataCache.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

function TZDataCache.Wait: Int64;
begin
  Enter;
  try
    result := 0;
    if FList.Count < 2 then exit;
    result := GetTickCount - PZDataBlock(FList[0])^.TimeStamp;
  finally
    Leave;
  end;
end;

{ TZConnCache }

procedure TZConnCache.Push(Conn: TdbResolver);
begin
  Enter;
  try
    if FList.Count>=MaxCache then
       begin
         Conn.Free;
       end
    else
       FList.Add(Conn);
  finally
    Leave;
  end;
end;

constructor TZConnCache.Create;
begin
  InitializeCriticalSection(FThreadLock);
  FList := TList.Create;
end;

destructor TZConnCache.Destroy;
var i:integer;
begin
  Enter;
  try
     for i:=FList.Count-1 downto 0 do
        begin
          FreeCache(i);
        end;
     FList.Free;
     inherited;
  finally
     Leave;
     DeleteCriticalSection(FThreadLock);
  end;
  inherited;
end;

procedure TZConnCache.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

procedure TZConnCache.FreeCache(i: integer);
begin
  TdbResolver(FList[i]).Free;
  FList.Delete(i); 
end;

function TZConnCache.Get(dbid: Integer): TdbResolver;
var i:integer;
begin
  Enter;
  try
    result := nil;
    for i:=0 to FList.Count-1 do
       begin
         if TdbResolver(FList[i]).dbid = dbid then
            begin
              result := TdbResolver(FList[i]);
              break;
            end;
       end;
    if result=nil then
       result := CreatedbResolver;
  finally
    Leave;
  end;
end;

procedure TZConnCache.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

procedure TZConnCache.SetMaxCache(const Value: integer);
begin
  FMaxCache := Value;
end;

function TZConnCache.CreatedbResolver: TdbResolver;
begin
  result := TdbResolver.Create;
  try
    result.Initialize('Provider=sqlite-3;DatabaseName=D:\Delphi\R3\Src\Shop5\Data\R3.db');
    result.Connect;
  except
    result.Free;
    Raise;
  end;
end;

initialization
  Sessions := TZSessions.Create;
finalization
  FreeAndNil(Sessions);
end.
