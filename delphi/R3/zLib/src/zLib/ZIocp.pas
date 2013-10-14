unit ZIocp;

interface
uses
  SvcMgr, Windows, Messages, SysUtils, Classes, Graphics, Controls, ExtCtrls,Forms, StdCtrls,
  ComCtrls, ScktComp, Registry,SyncObjs,ScktCnst,RTLConsts,MidConst,
  DB, ZIntf, ZPacket,ZServer, OleServer,ZLogFile,ZWSock2,ZConst, ActiveX;

const
  SHUTDOWN_FLAG = WM_USER + 3;
  WM_CLIENTSOCKET =  WM_USER + 5;
  WM_UPDATESTATUS = WM_USER + 4;
  IOIDLE=0;
  IORecvBytesReserved=1;
  IORecv=2;
  IOSendBytesReserved=3;
  IOSend=4;


type

  PPER_IO_OPERATION_DATA = ^PER_IO_OPERATION_DATA;
  PER_IO_OPERATION_DATA = packed record
    Overlapped: OVERLAPPED;
    DataBuf:TWSABUF;
    BytesReserved:array [0..7] of char;
    StreamLen:integer; //待读取长度
    Postion:Pointer;
    Buffer:IDataBlock;
    IOMode:dword;
  end;
const
  IOC_IN               =$80000000;
  IOC_VENDOR           =$18000000;
  IOC_out              =$40000000;
  SIO_KEEPALIVE_VALS   =IOC_IN or IOC_VENDOR or 4;
{ TSocketDispatcherThread }

type
  TTCP_KEEPALIVE = packed record
    onoff             : integer;
    keepalivetime     : integer;
    keepaliveinterval : integer;
  end;

  TSocketDispatcher=class;
  TServerClientSocket=class;

  TSocketDispatcherThread = class(TThread)
  private
    FTimeout: Integer;
    siocp:THandle;
    SocketDispatcher:TSocketDispatcher;
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean; iocp: THandle;Timeout: Integer;ASocketDispatcher:TSocketDispatcher);
    destructor Destroy; override;
  end;
  TSocketAcceptThread=class(TThread)
  private
    SocketDispatcher:TSocketDispatcher;
  protected
    procedure Execute; override;
    constructor Create(AOwner: TSocketDispatcher);
    destructor Destroy; override;
  end;
  TSocketWorkerThread=class(TThread)
  private
    FhEvent: THandle;
    SocketDispatcher:TSocketDispatcher;
    FWorking: Boolean;
  protected
    procedure Execute; override;
    constructor Create(AOwner: TSocketDispatcher);
    destructor Destroy; override;

    property Working:boolean read FWorking write FWorking;
  end;
  TServerClientSocket=class(TComponent,ISendDataBlock)
  private
    FhEvent: THandle;
    FInterpreter: TZDataBlockInterpreter;
    GZip:IDataIntercept;
    SocketDispatcher:TSocketDispatcher;
    FRecvBuffer : PPER_IO_OPERATION_DATA;
    FSendBuffer : PPER_IO_OPERATION_DATA;
    FSocket: TSocket;
    FSession: TZSession;
    FLastActivity: TDateTime;
    FLockThread: boolean;
    FWorkThread: TSocketWorkerThread;
    procedure SetSession(const Value: TZSession);
    function GetRemoteAddress: string;
    function GetRemotePort: integer;
    procedure SetLastActivity(const Value: TDateTime);
    procedure SetLockThread(const Value: boolean);
    function GetRemoteHost: string;
    procedure SetWorkThread(const Value: TSocketWorkerThread);
  protected
    SocktLock: TCriticalSection;
    RecvLock: TCriticalSection;
    SendLock: TCriticalSection;
    //对接收资源进行保护
    procedure RecvEnter;
    procedure RecvLeave;
    //对发送资源进行保护
    procedure SendEnter;
    procedure SendLeave;

    function Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock; stdcall;
  public
    constructor Create(ASocket: TSocket;ASocketDispatcher:TSocketDispatcher);
    destructor Destroy; override;

    procedure Close(locked:boolean=true);
    procedure AddBlock(DataBlock:IDataBlock);
    procedure StartListen;
    function Connected:boolean;
    procedure WorkRecv(IOData: PPER_IO_OPERATION_DATA;BytesReaded:integer);
    procedure WorkSend(IOData: PPER_IO_OPERATION_DATA;BytesReaded:integer);
    procedure WriteBuffer(IOData:PPER_IO_OPERATION_DATA;DataBlock:IDataBlock=nil);
    procedure ReadBuffer(IOData:PPER_IO_OPERATION_DATA;DataBlock:IDataBlock=nil);
    property Session:TZSession read FSession write SetSession;
    property RemoteAddress:string read GetRemoteAddress;
    property RemoteHost:string read GetRemoteHost;
    property RemotePort:integer read GetRemotePort;
    property LastActivity:TDateTime read FLastActivity write SetLastActivity;
    property LockThread:boolean read FLockThread write SetLockThread;
    property WorkThread:TSocketWorkerThread read FWorkThread write SetWorkThread;
  end;
{ TSocketDispatcher }
  TSocketDispatcher = class(TComponent)
  private
    FInterceptGUID:string;
    FTimeout:integer;
    FVSS: Boolean;
    FPort: Integer;
    FActive: boolean;
    FAddr: TSockAddr;
    FSocket: TSocket;
    FListenThread:TSocketAcceptThread;
    FThreadCacheSize: integer;
    FLock: TCriticalSection;
    FWaitTime:int64;
    FWorkerCount:integer;
    FHandle: THandle;
    FKeepAlive: Boolean;
    procedure SetVSS(const Value: Boolean);
    procedure SetPort(const Value: Integer);
    procedure WMClientClose(var Message: TMessage);
    procedure WndProc(var Msg: TMessage);
    procedure SetThreadCacheSize(const Value: integer);
    function GetActiveConnections: integer;
    function SocketLock(Socket: integer): boolean;
    procedure SetHandle(const Value: THandle);
    procedure SetKeepAlive(const Value: Boolean);
  protected
    iocp:THandle;
    AcceptPool:TList;
    DataCache:TZDataCache;
    WorkerPool:TThreadList;
    SocketCache:TList;
    SystemInfo: SYSTEM_INFO;
    procedure InternalOpen;
    procedure InternalClose;
    procedure SetActive(Value: Boolean);
    procedure CreateAcceptThread;
    procedure CloseAcceptThread;
  public
    procedure Accept(ASocket: TSocket; Aiocp: THandle);

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    //客户端Scoket队例
    procedure Lock;
    procedure UnLock;
    procedure AddClient(ASocket:TServerClientSocket);
    procedure RemoveClient(ASocket:TServerClientSocket);
    function FindClient(SessionId:Integer): TServerClientSocket;

    function LockClient(SessionId:Integer;WorkThread:TSocketWorkerThread):boolean;
    procedure CloseSocket(SessionId:Integer);
    procedure UnLockClient(SessionId:Integer;WorkThread:TSocketWorkerThread);
    //===========
    //数据队列处理
    procedure AddBlock(DataBlock:IDataBlock;ClientSocket:TServerClientSocket;IsCallWorker:boolean=true);
    function GetBlock:PZDataBlock;
    //===========

    procedure Open;
    procedure Close;

    //工作线程分配
    //procedure CheckWorker;
    procedure CallWorker(SessionId:integer=0);
    //===========

    procedure ReadSettings(PortNo: Integer);
    procedure WriteSettings;

    property Port: Integer read FPort write SetPort;

    property InterceptGUID: string read FInterceptGUID write FInterceptGUID;
    property Timeout: integer read FTimeout write FTimeout;
    property VSS:Boolean read FVSS write SetVSS;
    property Active:boolean read FActive write SetActive;
    property Socket:TSocket read FSocket;
    property ThreadCacheSize:integer read FThreadCacheSize write SetThreadCacheSize;
    property ActiveConnections:integer read GetActiveConnections;
    property Handle:THandle read FHandle write SetHandle;
    property KeepAlive:Boolean read FKeepAlive write SetKeepAlive;
  end;

var
  WorkThreadCount:integer;//线程数
  MaxThreadCount:integer; //最大线程数
  ExecThreadCount:integer;//工作中线程
implementation
uses IniFiles;
type
  TDllRegisterServer=function:HResult;
  TDllUnregisterServer=function:HResult;
var
  WSAData: TWSAData;
procedure Startup;
var
  ErrorCode: Integer;
begin
  ErrorCode := WSAStartup($0202, WSAData);
  if ErrorCode <> 0 then
    raise ESocketError.CreateResFmt(@sWindowsSocketError,
      [SysErrorMessage(ErrorCode), ErrorCode, 'WSAStartup']);
end;

procedure Cleanup;
var
  ErrorCode: Integer;
begin
  ErrorCode := WSACleanup();
  if ErrorCode <> 0 then
    raise ESocketError.CreateResFmt(@sWindowsSocketError,
      [SysErrorMessage(ErrorCode), ErrorCode, 'WSACleanup']);
end;

procedure CheckError(ResultCode: Integer; const OP: string);
var
  ErrCode: Integer;
begin
  if ResultCode <> 0 then
  begin
    ErrCode := WSAGetLastError;
    if (ErrCode <> WSAEWOULDBLOCK) and (ErrCode <> ERROR_IO_PENDING) then
      raise ESocketError.CreateFmt(SWindowsSocketError,[SysErrorMessage(ErrCode), ErrCode, Op]);
  end;
end;

constructor TSocketDispatcherThread.Create(CreateSuspended: Boolean; iocp: THandle; Timeout: Integer;ASocketDispatcher:TSocketDispatcher);
begin
  FTimeout := Timeout;
  siocp := iocp;
  SocketDispatcher := ASocketDispatcher;
  inherited Create(CreateSuspended);
  FreeOnTerminate := false;
end;

procedure TSocketDispatcherThread.Execute;
var BytesTransd:cardinal;
    Overlapped: POVERLAPPED;
    Buf:PPER_IO_OPERATION_DATA;
    ASocket:TServerClientSocket;
begin
  while (not Terminated) do
    begin
      BytesTransd := 0;
      ASocket := nil;
      Overlapped := nil;
      try
        //查询IOCP状态（数据读写操作是否完成）
        if not GetQueuedCompletionStatus(siocp,BytesTransd,dword(ASocket),Overlapped, INFINITE) then
           begin
              if Assigned(ASocket) then ASocket.Close; //只能关闭连接不能FREE对象，可能还有工作线程在使用它
              continue;
           end;
           
         if Cardinal(Overlapped) = SHUTDOWN_FLAG then
           begin
              if Assigned(ASocket) then ASocket.Close; //只能关闭连接不能FREE对象，可能还有工作线程在使用它
              break;
           end;

         if BytesTransd = 0  then
           begin
              if Assigned(ASocket) then ASocket.Close; //只能关闭连接不能FREE对象，可能还有工作线程在使用它
              continue;
           end;
          if ASocket.Connected then
             begin
                try
                  Buf := PPER_IO_OPERATION_DATA(Overlapped);
                  if (Buf=ASocket.FSendBuffer) then
                     ASocket.WorkSend(Buf,BytesTransd)
                  else
                  if (Buf=ASocket.FRecvBuffer) then
                     ASocket.WorkRecv(Buf,BytesTransd)
                  else
                     Raise Exception.Create('无效的数据请求');
                except
                  on E:Exception do
                  begin
                    try
                      if Assigned(ASocket) then ASocket.Close; //只能关闭连接不能FREE对象，可能还有工作线程在使用它
                    finally
                      LogFile.AddLogFile(0,E.Message,'DispatcherThread','CallWork');
                    end;
                  end;
                end;
            end;
      except
        on E:Exception do
           begin
             if not assigned(ASocket) then
                LogFile.AddLogFile(0,E.Message,'DispatcherThread','Listen');
           end;
      end;
    end;
end;

procedure TSocketDispatcher.Accept(ASocket: TSocket; Aiocp: THandle);
var
  Addr: TSockAddrIn;
  AddrLen, Ret, ErrCode, opt ,insize,outsize: Integer;
  ClientWinSocket: TSocket;
  ClientSocket: TServerClientSocket;
  inKeepAlive,OutKeepAlive:TTCP_KEEPALIVE;
begin
  if ASocket = INVALID_SOCKET then Exit;
  AddrLen := SizeOf(Addr);
  ClientWinSocket := ZWSock2.accept(ASocket,@Addr,AddrLen);
  if ClientWinSocket <> INVALID_SOCKET then
  begin
    if not Active then
    begin
      Closesocket(ClientWinSocket);
      Exit;
    end;
    if KeepAlive then //启用心跳保活机制
    begin
      //加入心跳代码
      opt:=1;
      if setsockopt(ClientWinSocket,SOL_SOCKET,SO_KEEPALIVE,@opt,sizeof(opt))=SOCKET_ERROR then
      begin
        Closesocket(ClientWinSocket);
        Exit;
      end;
      inKeepAlive.onoff:=1;
      inKeepAlive.keepalivetime:=20000;
      inKeepAlive.keepaliveinterval:=1000;
      insize:=sizeof(TTCP_KEEPALIVE);
      outsize:=sizeof(TTCP_KEEPALIVE);
      if WSAIoctl(ClientWinSocket,SIO_KEEPALIVE_VALS,@inKeepAlive,insize,@inKeepAlive,outsize,@OutKeepAlive,nil,nil)=SOCKET_ERROR then
      begin
        Closesocket(ClientWinSocket);
        Exit;
      end;
    end;
    if FSocket = INVALID_SOCKET then
    begin
      Closesocket(ClientWinSocket);
      Exit;
    end;
    //心跳设置结束

    try
      ClientSocket := TServerClientSocket.Create(ClientWinSocket,self);
    except
      AddBlock(nil,ClientSocket);
      //RemoveClient(ClientSocket);
      Exit;
    end;

    if CreateIoCompletionPort(ClientWinSocket,iocp,dword(ClientSocket),0) = 0 then
       begin
         AddBlock(nil,ClientSocket);
         //RemoveClient(ClientSocket);
       end
    else
       begin
         try
           ClientSocket.RecvEnter;
           try
             ClientSocket.StartListen;
           finally
             ClientSocket.RecvLeave;
           end;
         except
           AddBlock(nil,ClientSocket);
           //RemoveClient(ClientSocket);
           Raise;
         end;
       end;
  end;
end;

procedure TSocketDispatcher.AddBlock(DataBlock:IDataBlock;ClientSocket:TServerClientSocket;IsCallWorker:boolean=true);
begin
//  if FSocket = INVALID_SOCKET then Exit;
  DataCache.Add(integer(ClientSocket),DataBlock);
  FWaitTime := DataCache.Wait;
  if IsCallWorker then CallWorker(0);
end;

procedure TSocketDispatcher.AddClient(ASocket: TServerClientSocket);
var Session:TZSession;
begin
  if FSocket = INVALID_SOCKET then Exit;
  Lock;
  try
//    WSAAsyncSelect(ASocket.FSocket, FHandle, WM_CLIENTSOCKET, FD_CLOSE);
    SocketCache.Add(Pointer(ASocket));
    Session := TZSession.Create;
    Session.Port := inttostr(Port);
    Session.IPAddress := ASocket.RemoteAddress +':'+inttostr(ASocket.RemotePort);
    //  Session.Host := ASocket.RemoteHost;
    Session.SessionID := Integer(ASocket);
    ASocket.Session := Session;
    Sessions.Add(Session);
  finally
    UnLock;
  end;
end;

procedure TSocketDispatcher.CallWorker(SessionId:integer=0);
var
  i,c:integer;
  List:TList;
  Worker:TSocketWorkerThread;
begin
  if FSocket = INVALID_SOCKET then Exit;
  List := WorkerPool.LockList;
  Lock;
  try
    Worker := nil;
//    c := 0;
    for i:=List.Count-1 downto 0 do
      begin
//        inc(c);
        if not TSocketWorkerThread(List[i]).Working and not TSocketWorkerThread(List[i]).Terminated then
           begin
             if Worker=nil then
                begin
                  Worker := TSocketWorkerThread(List[i]);
                  SetEvent(Worker.FhEvent);
                end
             else
                begin
                  if List.Count>ThreadCacheSize then
                     begin
                       with TSocketWorkerThread(List[i]) do
                         begin
                           FreeOnTerminate := true;
                           Terminate;
                           SetEvent(Worker.FhEvent);
                         end;
                       List.Delete(i);
//                       Dec(c);
                     end;
                end;
           end;
      end;
    if (Worker=nil) and (List.Count < (ThreadCacheSize*2)) then
      begin
        //if (List.Count=0) or ((List.Count > 0) and (FWaitTime>500)) then
        //begin
           Worker := TSocketWorkerThread.Create(self);
           List.Add(Worker);
        //end;
      end;
    if Worker<>nil then SetEvent(Worker.FhEvent);
  finally
    FWorkerCount := List.Count;
    WorkerPool.UnlockList;
    UnLock;
  end;
end;

procedure TSocketDispatcher.Close;
begin
  InternalClose;
end;

procedure TSocketDispatcher.CloseAcceptThread;
var
  i,j:integer;
begin
  for i:=0 to AcceptPool.Count -1 do
    begin
      with TSocketDispatcherThread(AcceptPool[i]) do
        begin
          Terminate;
        end;
    end;
  for i:=0 to AcceptPool.Count -1 do
    begin
      for j:=0 to AcceptPool.Count -1 do
      begin
         PostQueuedCompletionStatus(iocp, 0, 0, Pointer(SHUTDOWN_FLAG));
      end;
      with TSocketDispatcherThread(AcceptPool[i]) do
        begin
          WaitFor;
          free;
        end;
    end;

end;

constructor TSocketDispatcher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DataCache := TZDataCache.Create;
  FKeepAlive := true;
  Startup;
  FListenThread := nil;
  FLock := TCriticalSection.Create;
  FPort := 1024;
  iocp := 0;
  ThreadCacheSize := 10;
  GetSystemInfo(SystemInfo);
  AcceptPool := TList.Create;
  WorkerPool := TThreadList.Create;
  SocketCache := TList.Create;
end;

procedure TSocketDispatcher.CreateAcceptThread;
var
  SocketThread:TSocketDispatcherThread;
  i:integer;
begin
  for i:=1 to SystemInfo.dwNumberOfProcessors*2 do
     begin
        SocketThread := TSocketDispatcherThread.Create(False, iocp, 0,self);
        AcceptPool.Add(SocketThread);
     end;
end;

destructor TSocketDispatcher.Destroy;
begin
  SetActive(False);
  AcceptPool.Free;
  DataCache.Free;
  WorkerPool.Free;
  SocketCache.Free;
  FLock.Free;
  Cleanup;
  inherited;
end;

function TSocketDispatcher.GetActiveConnections: integer;
begin
  Lock;
  try
    result := SocketCache.Count ;
  finally
    UnLock;
  end;
end;

function TSocketDispatcher.GetBlock:PZDataBlock;
begin
  result := DataCache.GetFirst;
end;

procedure TSocketDispatcher.InternalClose;
  procedure CloseObject(var Handle: THandle);
  begin
    if Handle <> 0 then
    begin
      CloseHandle(Handle);
      Handle := 0;
    end;
  end;

var
  i: Integer;
  List:TList;
begin
  if FSocket <> INVALID_SOCKET then
  begin
    closesocket(FSocket);
    FSocket := INVALID_SOCKET;
  end;
  CloseObject(iocp);
  
  if FListenThread<>nil then FListenThread.Terminate;

  Classes.DeallocateHWnd(FHandle);
  CloseAcceptThread;
  List := WorkerPool.LockList;
  try
  while List.Count>0 do
    begin
      with TSocketWorkerThread(List.Last) do
         begin
           FreeOnTerminate := False;
           Terminate;
           SetEvent(FhEvent);
           Waitfor;
           free;
           List.Remove(List.Last);
         end;
    end;
  finally
    WorkerPool.UnlockList;
  end;

  DataCache.Clear;
  Lock;
  try
    for i:=SocketCache.Count -1 downto 0 do
       begin
         TObject(SocketCache[i]).Free;
       end;
    SocketCache.Clear;
  finally
    UnLock;
  end;
//  if FListenThread<>nil then FListenThread.Free;
end;

procedure TSocketDispatcher.InternalOpen;
var
  I: Integer;
  Thread: TThread;
begin
  try
    FHandle := Classes.AllocateHWnd(WndProc);
    iocp := CreateIoCompletionPort(INVALID_HANDLE_VALUE, 0, 0, 0);
    if iocp = 0 then
       raise ESocketError.Create(SysErrorMessage(GetLastError));

    CreateAcceptThread;

    FSocket := WSASocket(PF_INET, SOCK_STREAM, IPPROTO_TCP, nil, 0, WSA_FLAG_OVERLAPPED);
    if FSocket = INVALID_SOCKET then
       raise ESocketError.Create(SysErrorMessage(GetLastError));

    FillChar(FAddr, SizeOf(FAddr), 0);
    FAddr.sin_family := AF_INET;
    FAddr.sin_port := htons(FPort);
    FAddr.sin_addr.S_addr := INADDR_ANY;
    CheckError(bind(FSocket, @FAddr, SizeOf(FAddr)), 'bind');

    CheckError(listen(FSocket, SOMAXCONN), 'listen');
    FListenThread := TSocketAcceptThread.Create(Self);
    FActive := true;
  except
    InternalClose;
    raise;
  end;
end;

procedure TSocketDispatcher.Lock;
begin
  FLock.Enter;
end;

procedure TSocketDispatcher.Open;
begin
  InternalOpen;
end;

procedure TSocketDispatcher.ReadSettings(PortNo: Integer);
var
  Section: string;
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'sckt.cfg');
  try
    if PortNo = -1 then
    begin
      Section := '1024';
      Port := 1024;
    end else
    begin
      Section := IntToStr(PortNo);
      Port := PortNo;
    end;
    ThreadCacheSize := F.ReadInteger(Section, 'ckThreadCacheSize', 10);
    FTimeout := F.ReadInteger(Section, 'ckTimeout', 0);
    FKeepAlive := F.ReadBool(Section, 'ckKeepAlive', true);
  finally
    F.Free;
  end;
end;

procedure TSocketDispatcher.RemoveClient(ASocket: TServerClientSocket);
var
  i:integer;
begin
  Lock;
  try
    DataCache.Delete(integer(ASocket));
    if SocketCache.IndexOf(Pointer(ASocket))>=0 then
       begin
          try
            ASocket.Free;
          finally
            SocketCache.Remove(Pointer(ASocket));
          end;
       end;
  finally
    UnLock;
  end;
end;

procedure TSocketDispatcher.SetActive(Value: Boolean);
begin
  if FActive=Value then Exit;
  if Value then InternalOpen else InternalClose;
  FActive := Value;
end;

procedure TSocketDispatcher.SetPort(const Value: Integer);
begin
  FPort := Value;
end;

procedure TSocketDispatcher.SetThreadCacheSize(const Value: integer);
begin
  FThreadCacheSize := Value;
end;

procedure TSocketDispatcher.SetVSS(const Value: Boolean);
begin
  FVSS := Value;
end;

function TSocketDispatcher.SocketLock(Socket: integer): boolean;
begin

end;

procedure TSocketDispatcher.UnLock;
begin
  FLock.Leave;
end;

function TSocketDispatcher.FindClient(SessionId:integer): TServerClientSocket;
var
  I: Integer;
begin
  Lock;
  try
    result := nil;
    for I := 0 to SocketCache.Count - 1 do
    begin
      if SessionId= integer(SocketCache[I]) then
         begin
           Result := TServerClientSocket(SocketCache[I]);
           break;
         end;
    end;
  finally
    UnLock;
  end;
end;

procedure TSocketDispatcher.WriteSettings;
var
  Section: string;
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'sckt.cfg');
  try
    Section := IntToStr(Port);
    F.WriteInteger(Section, 'ckThreadCacheSize', ThreadCacheSize);
    F.WriteInteger(Section, 'ckTimeout', Timeout);
    F.WriteBool(Section, 'ckKeepAlive', FKeepAlive);
  finally
    F.Free;
  end;
end;

procedure TSocketDispatcher.SetHandle(const Value: THandle);
begin
  FHandle := Value;
end;

procedure TSocketDispatcher.WndProc(var Msg: TMessage);
begin
  if Msg.Msg = WM_CLIENTSOCKET then WMClientClose(Msg);
end;

procedure TSocketDispatcher.SetKeepAlive(const Value: Boolean);
begin
  FKeepAlive := Value;
end;

destructor TSocketDispatcherThread.Destroy;
begin
  inherited;
end;

{ TSocketAcceptThread }

constructor TSocketAcceptThread.Create(AOwner: TSocketDispatcher);
begin
  FreeOnTerminate := true;
  inherited Create(false);
  SocketDispatcher := AOwner;
end;

destructor TSocketAcceptThread.Destroy;
begin

  inherited;
end;

procedure TSocketAcceptThread.Execute;
begin
  while not Terminated do
    begin
      try
        SocketDispatcher.Accept(SocketDispatcher.Socket,SocketDispatcher.iocp);
      except
        on E:Exception do
           LogFile.AddLogFile(0,E.Message,'TSocketAcceptThread','Accept');
      end;
    end;
end;

{ TServerClientSocket }

procedure TServerClientSocket.AddBlock(DataBlock: IDataBlock);
begin
  if (FSocket = INVALID_SOCKET) then exit;
  try
    GZip.DataIn(DataBlock);
    SocketDispatcher.AddBlock(DataBlock,self);
  finally
    StartListen;
  end;
end;

procedure TServerClientSocket.Close(locked:boolean=true);
var
  skt: TSocket;
begin
  SocktLock.Enter;
  try
    if (FSocket <> INVALID_SOCKET) then
    begin
      RecvEnter;
      SendEnter;
      try
        skt := FSocket;
        FSocket := INVALID_SOCKET;
        CheckError(closesocket(skt), 'closesocket');
        FRecvBuffer^.Buffer := nil;
        FSendBuffer^.Buffer := nil;
      finally
        RecvLeave;
        SendLeave;
      end;
    end;
    try
      if Assigned(Session) and Assigned(Session.dbResolver) then
         Session.dbResolver.KillDbConnect;
    except
      on E:Exception do
         LogFile.AddLogFile(0,E.Message,'TServerClientSocket','Close');
    end; 
  finally
    SocktLock.Leave;
//    SocketDispatcher.DataCache.Delete(Integer(self));
    if locked then SocketDispatcher.AddBlock(nil,self);
  end;
end;

function TServerClientSocket.Connected: boolean;
begin
  result := (FSocket<>INVALID_SOCKET);
end;

constructor TServerClientSocket.Create(ASocket: TSocket;ASocketDispatcher:TSocketDispatcher);
var
  ISend: ISendDataBlock;
begin
  RecvLock := TCriticalSection.Create;
  SendLock := TCriticalSection.Create;
  SocktLock := TCriticalSection.Create;
  GZip := TZDataCompressor.Create;
  LockThread := false;
  WorkThread := nil;
  inherited Create(nil);
  FhEvent := CreateEvent(nil, True, False, nil);
  FSession := nil;
  GetInterface(ISendDataBlock, ISend);
  FInterpreter:= TZDataBlockInterpreter.Create(ISend,'');
  FInterpreter.DoInvokeDispatch := TDoInvokeDispatch.Create(Integer(self),FInterpreter);
  SocketDispatcher := ASocketDispatcher;
  new(FRecvBuffer);
  ZeroMemory(FRecvBuffer,sizeof(PER_IO_OPERATION_DATA));
  new(FSendBuffer);
  ZeroMemory(FSendBuffer,sizeof(PER_IO_OPERATION_DATA));
  FSocket := ASocket;
  SocketDispatcher.AddClient(self);
end;

destructor TServerClientSocket.Destroy;
var
  skt: TSocket;
begin
  SocktLock.Enter;
  try
    LockThread := false;
    WorkThread := nil;
    if (FSocket <> INVALID_SOCKET) then
    begin
      skt := FSocket;
      FSocket := INVALID_SOCKET;
      try
        CheckError(closesocket(skt), 'closesocket');
      except
        on E:Exception do
           LogFile.AddLogFile(0,E.Message,'TServerClientSocket','DoInvokeDispatch');
      end;
    end;
    FRecvBuffer^.Buffer := nil;
    FSendBuffer^.Buffer := nil;
    Dispose(FRecvBuffer);
    Dispose(FSendBuffer);
    try
       FInterpreter.DoInvokeDispatch := nil;
    except
      on E:Exception do
         LogFile.AddLogFile(0,E.Message,'TServerClientSocket','DoInvokeDispatch');
    end;
    try
       FInterpreter.Free;
    except
      on E:Exception do
         LogFile.AddLogFile(0,E.Message,'TServerClientSocket','FInterpreter');
    end;
    try
      if Assigned(Session) then
         begin
           Sessions.Delete(Session);
           Session := nil;
         end;
    except
      on E:Exception do
         LogFile.AddLogFile(0,E.Message,'TServerClientSocket','Session');
    end;
    if FhEvent<>0 then CloseHandle(FhEvent);
    GZip := nil;
  finally
    SocktLock.Leave;
    RecvLock.Free;
    SendLock.Free;
    SocktLock.Free;
  end;
  inherited;
end;

function TServerClientSocket.GetRemoteAddress: string;
var
  SockAddrIn: TSockAddrIn;
  Size: Integer;
begin
  Result := '';
  if FSocket=INVALID_SOCKET then Exit;
  Size := SizeOf(SockAddrIn);
  CheckError(getpeername(FSocket, SockAddrIn, Size), 'getpeername');
  Result := inet_ntoa(SockAddrIn.sin_addr);
end;

function TServerClientSocket.GetRemoteHost: string;
var
  SockAddrIn: TSockAddrIn;
  Size: Integer;
  HostEnt: PHostEnt;
begin
  Result := '';
  if FSocket=INVALID_SOCKET then Exit;
  Size := SizeOf(SockAddrIn);
  CheckError(getpeername(FSocket, SockAddrIn, Size), 'getpeername');
  HostEnt := gethostbyaddr(@SockAddrIn.sin_addr.s_addr, 4, PF_INET);
  if HostEnt <> nil then Result := HostEnt.h_name;
end;

function TServerClientSocket.GetRemotePort: integer;
var
  SockAddrIn: TSockAddrIn;
  Size: Integer;
begin
  Result := 0;
  if FSocket=INVALID_SOCKET then Exit;

  Size := SizeOf(SockAddrIn);
  CheckError(getpeername(FSocket, SockAddrIn, Size), 'getpeername');
  Result := ntohs(SockAddrIn.sin_port);
end;

procedure TServerClientSocket.ReadBuffer(IOData:PPER_IO_OPERATION_DATA;DataBlock: IDataBlock=nil);
var
  Flags, Transfer: DWORD;
  ErrCode:integer;
begin
  LastActivity := now();
  case IOData.IOMode of
  IORecvBytesReserved:begin
       IOData^.DataBuf.len := 8;
       FillChar(IOData^.BytesReserved, SizeOf(IOData^.BytesReserved), 0);
       IOData^.Postion := @IOData^.BytesReserved[0];
       IOData^.DataBuf.buf := IOData^.Postion;
       IOData^.Buffer := DataBlock;
     end;
  IORecv:begin
//       if FRecvBuffer.Buffer<>nil then FRecvBuffer.Buffer := nil;
//       FRecvBuffer.Buffer := DataBlock;
       if IOData^.StreamLen>(1024*8) then
          IOData^.DataBuf.len := (1024*8)
       else
          IOData^.DataBuf.len :=  IOData^.StreamLen;
       IOData^.DataBuf.buf := IOData^.Postion;
     end;
  end;
  Flags := 0;
  ZeroMemory(@IOData^.Overlapped, sizeof(Overlapped));
  if ZWSock2.WSARecv(FSocket, PWSABUF(@IOData^.DataBuf), 1, @Transfer, @Flags, @IOData^.Overlapped, nil)=SOCKET_ERROR then
    begin
      ErrCode := WSAGetLastError;
      if (ErrCode <> WSAEWOULDBLOCK) and (ErrCode <> ERROR_IO_PENDING) then
      begin
         IOData^.Buffer := nil;
         raise ESocketError.CreateFmt(SWindowsSocketError,[SysErrorMessage(ErrCode), ErrCode, 'WSARecv n='+inttostr(IOData^.StreamLen)]);
      end;
    end;
end;
procedure TServerClientSocket.RecvEnter;
begin
  RecvLock.Enter;
end;

procedure TServerClientSocket.RecvLeave;
begin
  RecvLock.Leave;
end;

function TServerClientSocket.Send(const Data: IDataBlock;
  WaitForResult: Boolean): IDataBlock;
begin
  if FSocket=INVALID_SOCKET then Raise Exception.Create('Send数据失败，客户端已经断开连接了.');
  GZip.DataOut(Data);
  SendEnter;
  try
    while (FSendBuffer^.IOMode <> IOIDLE) do
      begin
        if FSocket=INVALID_SOCKET then Raise Exception.Create('Send数据失败，客户端已经断开连接了.');
        WaitForSingleObject(FhEvent, 50);
      end;
  finally
    SendLeave;
  end;
  SendEnter;
  try
    FSendBuffer^.Buffer := nil;
    ZeroMemory(FSendBuffer,sizeof(PER_IO_OPERATION_DATA));
    FSendBuffer^.IOMode := IOSendBytesReserved;
    WriteBuffer(FSendBuffer,Data);
  finally
    SendLeave;
  end;
end;

procedure TServerClientSocket.SendEnter;
begin
  SendLock.Enter;
end;

procedure TServerClientSocket.SendLeave;
begin
  SendLock.Leave;
end;

procedure TServerClientSocket.SetLastActivity(const Value: TDateTime);
begin
  FLastActivity := Value;
end;

procedure TServerClientSocket.SetLockThread(const Value: boolean);
begin
  FLockThread := Value;
end;

procedure TServerClientSocket.SetSession(const Value: TZSession);
begin
  FSession := Value;
end;

procedure TServerClientSocket.SetWorkThread(
  const Value: TSocketWorkerThread);
begin
  FWorkThread := Value;
end;

procedure TServerClientSocket.StartListen;
begin
  if FSocket=INVALID_SOCKET then Exit;
  FRecvBuffer^.Buffer := nil;
  ZeroMemory(FRecvBuffer,sizeof(PER_IO_OPERATION_DATA));
  FRecvBuffer^.IOMode := IORecvBytesReserved;
  ReadBuffer(FRecvBuffer);
end;

procedure TServerClientSocket.WorkRecv(IOData: PPER_IO_OPERATION_DATA;BytesReaded:integer);
var
  Data:IDataBlock;
  Sig,StreamLen:integer;
  s:string;
begin
  RecvEnter;
  try
      case IOData^.IOMode of
      IORecvBytesReserved:begin
          if BytesReaded<>8 then raise ESocketConnectionError.CreateRes(@SInvalidDataPacket);
          Sig := 0;
          StreamLen := 0;
          Move(IOData^.BytesReserved[0],Pointer(Sig),4);
          CheckSignature(Sig);
          Move(IOData^.BytesReserved[4],Pointer(StreamLen),4);
          if StreamLen>(1024*1024*10) then raise ESocketConnectionError.CreateRes(@SInvalidDataPacket);
          Data := TDataBlock.Create as IDataBlock;
          Data.Size := StreamLen;
          Data.Signature := Sig;
          IOData^.StreamLen := StreamLen;
          IOData^.Buffer := Data;
          IOData^.Postion := Pointer(integer(Data.Memory)+Data.BytesReserved);
          IOData^.IOMode := IORecv;
          ReadBuffer(IOData,Data);
        end;
      IORecv:begin
          Data := IOData^.Buffer;
          IOData^.StreamLen := IOData^.StreamLen - BytesReaded;
          IOData^.Postion := Pointer(Integer(IOData^.Postion) + BytesReaded);
          if IOData^.StreamLen = 0 then
             begin
               AddBlock(Data);
             end;
          if IOData^.StreamLen > 0 then
             begin
               ReadBuffer(IOData,Data);
             end
          else
             if IOData^.StreamLen < 0 then
                begin
                   case IOData^.IOMode of
                   1:s := 'IOMode=IORecvBytesReserved';
                   2:s := 'IOMode=IORecv';
                   3:s := 'IOMode=IOSendBytesReserved';
                   4:s := 'IOMode=IOSend';
                   end;
                   s := s+';StreamLen='+Inttostr(IOData^.StreamLen)+';BytesReaded='+inttostr(BytesReaded);
                   raise ESocketConnectionError.Create('无效数据包'+s);
                end;
        end;
      end;
  finally
    RecvLeave;
  end;
end;

procedure TServerClientSocket.WorkSend(IOData: PPER_IO_OPERATION_DATA;
  BytesReaded: integer);
var
  Data:IDataBlock;
  s:string;
begin
  SendEnter;
  try
    Data := IOData^.Buffer;
    IOData^.StreamLen := IOData^.StreamLen - BytesReaded;
    IOData^.Postion := Pointer(Integer(IOData^.Postion) + BytesReaded);
    if IOData^.StreamLen > 0 then
       begin
          WriteBuffer(IOData,Data);
       end
    else
    if IOData^.StreamLen = 0 then //发送完毕后
       begin
          IOData^.Buffer := nil;
          IOData^.IOMode := IOIDLE;
       end
    else
    if IOData^.StreamLen < 0 then
       begin
         case IOData^.IOMode of
         1:s := 'IOMode=IORecvBytesReserved';
         2:s := 'IOMode=IORecv';
         3:s := 'IOMode=IOSendBytesReserved';
         4:s := 'IOMode=IOSend';
         end;
         s := s+';StreamLen='+Inttostr(IOData^.StreamLen)+';BytesReaded='+inttostr(BytesReaded);
         raise ESocketConnectionError.Create('无效数据包'+s);
       end;
  finally
    SendLeave;
  end;
end;

procedure TServerClientSocket.WriteBuffer(IOData: PPER_IO_OPERATION_DATA;
  DataBlock: IDataBlock);
var
  Flags: DWord;
  Transfer:DWord;
  ErrCode: Integer;
begin
  LastActivity := now();
  case IOData.IOMode of
  IOSendBytesReserved:begin
       IOData^.Buffer := DataBlock;
       IOData^.StreamLen := DataBlock.Size+DataBlock.BytesReserved;
       IOData^.DataBuf.len := IOData^.StreamLen;
       IOData^.Postion := DataBlock.Memory;
       IOData^.DataBuf.buf := IOData^.Postion;
     end;
  IOSend:begin
       if IOData^.StreamLen>(1024*8) then
          IOData^.DataBuf.len := (1024*8)
       else
          IOData^.DataBuf.len :=  IOData^.StreamLen;
//       IOData^.DataBuf.len := IOData^.StreamLen;
       IOData^.DataBuf.buf := IOData^.Postion;
     end;
  end;
  Flags := 0;
  ZeroMemory(@IOData^.Overlapped, sizeof(Overlapped));
  IOData^.IOMode := IOSend;
  if ZWSock2.WSASend(FSocket, PWSABUF(@IOData^.DataBuf), 1 , @Transfer, Flags, @IOData^.Overlapped, nil)=SOCKET_ERROR then
    begin
      ErrCode := WSAGetLastError;
      if (ErrCode <> WSAEWOULDBLOCK) and (ErrCode <> ERROR_IO_PENDING) then
      begin
         IOData^.Buffer := nil;
         raise ESocketError.CreateFmt(SWindowsSocketError,[SysErrorMessage(ErrCode), ErrCode, 'WSASend n='+inttostr(IOData^.StreamLen)]);
      end;
    end;
end;
{ TSocketWorkerThread }

constructor TSocketWorkerThread.Create(AOwner: TSocketDispatcher);
begin
  inherited Create(false);
  InterlockedIncrement(WorkThreadCount);
  if WorkThreadCount>MaxThreadCount then MaxThreadCount := WorkThreadCount;
  FhEvent := CreateEvent(nil, True, False, nil);
  FreeOnTerminate := false;
  SocketDispatcher := AOwner;
  FWorking := false;
  if MainFormHandle>0 then PostMessage(MainFormHandle,WM_WORK_THREAD_UPDATE,0,0);
end;

destructor TSocketWorkerThread.Destroy;
begin
  if FhEvent<>0 then CloseHandle(FhEvent);
  InterlockedDecrement(WorkThreadCount);
  inherited;
  if MainFormHandle>0 then PostMessage(MainFormHandle,WM_WORK_THREAD_UPDATE,0,0);
end;

procedure TSocketWorkerThread.Execute;
var
  sdb:PZDataBlock;
  n,c:integer;
  _Start:int64;
begin
  CoInitialize(nil);
  ResetEvent(FhEvent);
  try
  while not Terminated do
    begin
      FWorking := true;
      sdb := SocketDispatcher.GetBlock;
      try
        while (sdb<>nil) and not Terminated do
          begin
            InterlockedIncrement(ExecThreadCount);
            _Start := GetTickCount;
            if ExecThreadCount + WaitDataBlockCount> MaxSyncRequestCount then MaxSyncRequestCount := ExecThreadCount + WaitDataBlockCount;
            try
              if SocketDispatcher.LockClient(sdb.SessionId,self) then
              begin
                 try
                    try
                       if sdb^.Data = nil then //为空时，代表关闭SOCKET请求包
                          begin
                            //SocketDispatcher.CloseSocket(sdb^.SessionId);
                          end
                       else
                          begin
                            if not Terminated then
                               begin
                                  TServerClientSocket(sdb^.SessionId).FInterpreter.InterpretData(sdb^.Data);
                               end;
                          end;
                    except
                       on E:Exception do
                       begin
                         try
                           LogFile.AddLogFile(0,'<'+inttostr(sdb.SessionId)+'>未知异常强行关闭客户端，错误:'+E.Message,'WorkerThread','InterpretData');
                           SocketDispatcher.CloseSocket(sdb^.SessionId);
                         finally
                         end;
                       end;
                    end;
                 finally
                    SocketDispatcher.UnLockClient(sdb.SessionId,self);
                 end;
              end
              else //客户端忙，等待处理
              begin
                 if Assigned(SocketDispatcher.FindClient(sdb.SessionId)) then
                    SocketDispatcher.AddBlock(sdb.Data,TServerClientSocket(sdb.SessionId),false);
              end;
            finally
               InterlockedDecrement(ExecThreadCount);
               sdb.Data := nil;
               dispose(sdb);
            end;
            sdb := SocketDispatcher.GetBlock;
          end;
      finally
        FWorking := false;
      end;
      WaitForSingleObject(FhEvent, 50);
      if not Terminated then
         begin
           ResetEvent(FhEvent);
         end;
    end;
  finally
    CoUninitialize;
  end;
end;

function TSocketDispatcher.LockClient(SessionId: Integer;WorkThread:TSocketWorkerThread): boolean;
var
  i:integer;
begin
  Lock;
  try
    result := (SocketCache.IndexOf(Pointer(SessionId))>=0);
    if result then
       begin
         if not TServerClientSocket(SessionId).LockThread or (TServerClientSocket(SessionId).WorkThread=WorkThread) then
            begin
              TServerClientSocket(SessionId).LockThread := true;
              TServerClientSocket(SessionId).WorkThread := WorkThread;
            end
         else
            result := false;
       end;
  finally
    UnLock;
  end;
end;

procedure TSocketDispatcher.UnLockClient(SessionId: Integer;WorkThread:TSocketWorkerThread);
var
  i:integer;
begin
  Lock;
  try
     try
        if SocketCache.IndexOf(Pointer(SessionId))<0 then
           begin
             DataCache.Delete(SessionId);
             exit;
           end;
        if (TServerClientSocket(SessionId).Connected) then
            begin
              TServerClientSocket(SessionId).LockThread := false;
              TServerClientSocket(SessionId).WorkThread := nil;
            end
        else
          begin
            DataCache.Delete(SessionId);
            if TServerClientSocket(SessionId).LockThread and (TServerClientSocket(SessionId).WorkThread<>WorkThread) then
               begin
                 AddBlock(nil,TServerClientSocket(SessionId),false);
                 Exit;
               end;
            try
              TServerClientSocket(SessionId).Free;
            finally
              SocketCache.Remove(Pointer(SessionId));
            end;
          end;
     except
        on E:Exception do
           LogFile.AddLogFile(0,E.Message,'SocketDispatcher','UnLockClient');
     end;
  finally
    UnLock;
  end;
end;

procedure TSocketDispatcher.WMClientClose(var Message: TMessage);
begin
  
end;

//procedure TSocketDispatcher.CheckWorker;
//begin
//  WorkerPool.LockList;
//  WorkerPool.UnlockList;
//end;

procedure TSocketDispatcher.CloseSocket(SessionId: Integer);
var
  i:integer;
begin
  Lock;
  try
    if SocketCache.IndexOf(Pointer(SessionId))<0 then exit;
    try
       TServerClientSocket(SessionId).Close(false);
    except
       on E:Exception do
          LogFile.AddLogFile(0,E.Message,'SocketDispatcher','CloseSocket');
    end;
  finally
    UnLock;
  end;
end;

initialization
  WorkThreadCount := 0;
  MaxThreadCount := 0;
  ExecThreadCount := 0;
end.

