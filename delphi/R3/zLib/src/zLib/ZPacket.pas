unit ZPacket;

{$R-}

interface

uses
  VarUtils, Variants, Windows, Messages, Classes, SysUtils,ZConst,
  ScktComp, WinInet, ComObj,zLib,SyncObjs,ZIntf,WinSock;

type
  EInvokeDispatchError =class(Exception)
  private
    FbstrSource: WideString;
    procedure SetbstrSource(const Value: WideString);
  public
    constructor CreateDispatchError(const Msg: string;const SourceInfo:string);
    property bstrSource: WideString read FbstrSource write SetbstrSource;
  end;

  {$HPPEMIT '#pragma link "wininet.lib"'}
  { IDataBlock }

  IDataBlock = interface(IUnknown)
  ['{CA6564C2-4683-11D1-88D4-00A0248E5091}']
    function GetBytesReserved: Integer; stdcall;
    function GetMemory: Pointer; stdcall;
    function GetSize: Integer; stdcall;
    procedure SetSize(Value: Integer); stdcall;
    function GetStream: TStream; stdcall;
    function GetSignature: Integer; stdcall;
    procedure SetSignature(Value: Integer); stdcall;
    procedure Clear; stdcall;
    function Write(const Buffer; Count: Integer): Integer; stdcall;
    function Read(var Buffer; Count: Integer): Integer; stdcall;
    procedure IgnoreStream; stdcall;
    function InitData(Data: Pointer; DataLen: Integer; CheckLen: Boolean): Integer; stdcall;
    property BytesReserved: Integer read GetBytesReserved;
    property Memory: Pointer read GetMemory;
    property Signature: Integer read GetSignature write SetSignature;
    property Size: Integer read GetSize write SetSize;
    property Stream: TStream read GetStream;
  end;

  { ISendDataBlock }

  ISendDataBlock = interface
  ['{87AD1043-470E-11D1-88D5-00A0248E5091}']
    function Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock; stdcall;
  end;

  { ITransport }

  ITransport = interface(IUnknown)
  ['{CA6564C1-4683-11D1-88D4-00A0248E5091}']
    function GetWaitEvent: THandle; stdcall;
    function GetConnected: Boolean; stdcall;
    procedure SetConnected(Value: Boolean); stdcall;
    function Receive(WaitForInput: Boolean; Context: Integer): IDataBlock; stdcall;
    function Send(const Data: IDataBlock): Integer; stdcall;
    function GetSocketHandle:THandle; stdcall;
    property Connected: Boolean read GetConnected write SetConnected;

  end;

  IDoInvokeDispatch = interface(IUnknown)
  ['{FFE2E097-685A-41C5-ADF4-B010721C3B12}']
    function  DoInvoke(Token,LocaleID: Integer;
      Flags: Word;var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;stdcall;
  end;
  { TDataBlock }

  TDataBlock = class(TInterfacedObject, IDataBlock)
  private
    FStream: TMemoryStream;
    FReadPos: Integer;
    FWritePos: Integer;
    FIgnoreStream: Boolean;
  protected
    { IDataBlock }
    function GetBytesReserved: Integer; stdcall;
    function GetMemory: Pointer; stdcall;
    function GetSize: Integer; stdcall;
    procedure SetSize(Value: Integer); stdcall;
    function GetStream: TStream; stdcall;
    function GetSignature: Integer; stdcall;
    procedure SetSignature(Value: Integer); stdcall;
    procedure Clear; stdcall;
    function Write(const Buffer; Count: Integer): Integer; stdcall;
    function Read(var Buffer; Count: Integer): Integer; stdcall;
    procedure IgnoreStream; stdcall;
    function InitData(Data: Pointer; DataLen: Integer; CheckLen: Boolean): Integer; stdcall;
    property BytesReserved: Integer read GetBytesReserved;
    property Memory: Pointer read GetMemory;
    property Signature: Integer read GetSignature write SetSignature;
    property Size: Integer read GetSize write SetSize;
    property Stream: TStream read GetStream;
  public
    constructor Create;
    destructor Destroy; override;
  end;
  
  { IDataIntercept }

  IDataIntercept = interface
  ['{B249776B-E429-11D1-AAA4-00C04FA35CFA}']
    procedure DataIn(const Data: IDataBlock); stdcall;
    procedure DataOut(const Data: IDataBlock); stdcall;
  end;
  
  TZDataCompressor = class(TInterfacedObject, IDataIntercept)
  protected
    procedure DataIn(const Data: IDataBlock); stdcall;
    procedure DataOut(const Data: IDataBlock); stdcall;
  end;

type
  PIntArray = ^TIntArray;
  TIntArray = array[0..0] of Integer;

  PVariantArray = ^TVariantArray;
  TVariantArray = array[0..0] of OleVariant;

  TVarFlag = (vfByRef, vfVariant);
  TVarFlags = set of TVarFlag;

  EInterpreterError = class(Exception);

  TZToken=(
            SKTOpenCommandText,
            SKTOpenClassName,
            SKTOpenCombination,
            SKTUpdateBatchCommandText,
            SKTUpdateBatchClassName,
            SKTUpdateBatchCombination,
            SKTBeginTrans,
            SKTCommitTrans,
            SKTRollbackTrans,
            SKTGetiDbType,
            SKTInTransaction,
            SKTExecSQL,
            SKTExecProc,
            SKTParameter,     //设置参数
            SKTLogin,         //登录服务器
            SKTDBLock         //锁定数据库连接
           );

  TZCustomDataBlockInterpreter = class
  private
  public
    function GetVariantPointer(const Value: OleVariant): Pointer;
    procedure CopyDataByRef(const Source: TVarData; var Dest: TVarData);

    function ReadArray(VType: Integer; const Data: IDataBlock): OleVariant;
    procedure WriteArray(const Value: OleVariant; const Data: IDataBlock);
    function ReadVariant(out Flags: TVarFlags; const Data: IDataBlock): OleVariant;
    procedure WriteVariant(const Value: OleVariant; const Data: IDataBlock);
    procedure DoException(const Data: IDataBlock);
    function  CallInvoke(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; abstract;
    procedure InterpretData(const Data: IDataBlock); virtual; abstract;

  end;

  TZDataBlockInterpreter = class(TZCustomDataBlockInterpreter)
  private
    FSendDataBlock: ISendDataBlock;
    Disp:IDoInvokeDispatch;
    FLock: TCriticalSection;
    procedure SetDoInvokeDispatch(const Value: IDoInvokeDispatch);
  protected
    procedure DoInvoke(const Data: IDataBlock);
  public
    procedure InterpretData(const Data: IDataBlock); override;
    function  CallInvoke(Token,LocaleID: Integer;
      Flags: Word;Var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; override;

    procedure Lock;
    procedure UnLock;
    constructor Create(SendDataBlock: ISendDataBlock; CheckRegValue: string);
    destructor Destroy; override;
    property DoInvokeDispatch:IDoInvokeDispatch read Disp write SetDoInvokeDispatch;
  end;

const

  { Action Signatures }

  CallSig         = $DA00; // Call signature
  ResultSig       = $DB00; // Result signature
  asError         = $01;   // Specify an exception was raised
  asInvoke        = $02;   // Specify a call to Invoke
  asMask          = $FF;   // Mask for action

  { TTransportThread }

const
  THREAD_SENDSTREAM       = WM_USER + 1;
  THREAD_RECEIVEDSTREAM   = THREAD_SENDSTREAM + 1;
  THREAD_EXCEPTION        = THREAD_RECEIVEDSTREAM + 1;
  THREAD_SENDNOTIFY       = THREAD_EXCEPTION + 1;
  THREAD_REPLACETRANSPORT = THREAD_SENDNOTIFY + 1;
  THREAD_DISCONNECT = THREAD_REPLACETRANSPORT + 1;
type

  TZTransportThread = class(TThread)
  private
    FParentHandle: THandle;
    FSemaphore: THandle;
    FTransport: ITransport;
    FhEvent: THandle;
    FReadEvent: THandle;
    FData: Pointer;
    FMsg: UINT;
    procedure SethEvent(const Value: THandle);
    procedure SetData(const Value: Pointer);
    procedure SetMsg(const Value: UINT);
    function GetMsg: UINT;
  public
    constructor Create(AHandle: THandle; Transport: ITransport); virtual;
    destructor Destroy; override;
    property Semaphore: THandle read FSemaphore;
    procedure Execute; override;
    procedure SetThreadEvent;
    procedure ResetThreadEvent;
    procedure SetReadEvent;
    procedure ResetReadEvent;
    function GetEventData: Pointer;

    property ParentTransport:ITransport read FTransport;
    property hEvent:THandle read FhEvent write SethEvent;
    property hReadEvent:THandle read FReadEvent;
    property hEventData:Pointer read GetEventData write SetData;
    property hEventMsg:UINT read GetMsg write SetMsg;
    property Transport:ITransport read FTransport;
  end;
  { TSocketTransport }

  ESocketConnectionError = class(Exception);

  TZSocketTransport = class(TInterfacedObject, ITransport)
  private
    FEvent: THandle;
    FAddress: string;
    FHost: string;
    FPort: Integer;
    FClientSocket: TClientSocket;
    FSocket: TCustomWinSocket;
    FInterceptor: IDataIntercept;
    FCreateAttempted: Boolean;
    FThreadLock:TRTLCriticalSection;
    function CheckInterceptor: Boolean;
    procedure InterceptIncoming(const Data: IDataBlock);
    procedure InterceptOutgoing(const Data: IDataBlock);
    procedure SetSocket(const Value: TCustomWinSocket);
  protected
    { ITransport }
    function CheckClientSocket(S: TSocket): Boolean;
    function GetWaitEvent: THandle; stdcall;
    function GetConnected: Boolean; stdcall;
    procedure SetConnected(Value: Boolean); stdcall;
    function Receive(WaitForInput: Boolean; Context: Integer): IDataBlock; stdcall;
    function Send(const Data: IDataBlock): Integer; stdcall;
    function GetSocketHandle:THandle; stdcall;

    procedure Enter;
    procedure Leave;
  public
    constructor Create;
    destructor Destroy; override;

    property Host: string read FHost write FHost;
    property Address: string read FAddress write FAddress;
    property Port: Integer read FPort write FPort;
    property Socket: TCustomWinSocket read FSocket write SetSocket;
  end;

{ Utility functions }

function LoadWinSock2: Boolean;
procedure CheckSignature(Sig: Integer);

var
  WSACreateEvent: function: THandle stdcall;
  WSAResetEvent: function(hEvent: THandle): Boolean stdcall;
  WSACloseEvent: function(hEvent: THandle): Boolean stdcall;
  WSAEventSelect: function(s: TSocket; hEventObject: THandle; lNetworkEvents: Integer): Integer stdcall;
implementation
uses
  ActiveX, MidConst, RTLConsts,ZLogFile;
const

  EasyArrayTypes = [varSmallInt, varInteger, varSingle, varDouble, varCurrency,
                    varDate, varBoolean, varShortInt, varByte, varWord, varLongWord];

  VariantSize: array[0..varLongWord] of Word  = (0, 0, SizeOf(SmallInt), SizeOf(Integer),
    SizeOf(Single), SizeOf(Double), SizeOf(Currency), SizeOf(TDateTime), 0, 0,
    SizeOf(Integer), SizeOf(WordBool), 0, 0, 0, 0, SizeOf(ShortInt), SizeOf(Byte),
    SizeOf(Word), SizeOf(LongWord));
var
  hWinSock2: THandle;

{ Utility functions }

procedure CheckSignature(Sig: Integer);
begin
  if (Sig and $FF00 <> CallSig) and
     (Sig and $FF00 <> ResultSig) then
  begin
    raise Exception.CreateFmt('Invalid data packet Sig=%d',[Sig]);
  end;
end;

function LoadWinSock2: Boolean;
const
  DLLName = 'ws2_32.dll';
begin
  Result := hWinSock2 > 0;
  if Result then Exit;
  hWinSock2 := LoadLibrary(PChar(DLLName));
  Result := hWinSock2 > 0;
  if Result then
  begin
    WSACreateEvent := GetProcAddress(hWinSock2, 'WSACreateEvent');
    WSAResetEvent := GetProcAddress(hWinSock2, 'WSAResetEvent');
    WSACloseEvent := GetProcAddress(hWinSock2, 'WSACloseEvent');
    WSAEventSelect := GetProcAddress(hWinSock2, 'WSAEventSelect');
  end;
end;
procedure FreeWinSock2;
begin
  if hWinSock2 > 0 then
  begin
    WSACreateEvent := nil;
    WSAResetEvent := nil;
    WSACloseEvent := nil;
    WSAEventSelect := nil;
    FreeLibrary(hWinSock2);
  end;
  hWinSock2 := 0;
end;

{ TDataBlock }

constructor TDataBlock.Create;
begin
  inherited Create;
  FIgnoreStream := False;
  FStream := TMemoryStream.Create;
  Clear;
end;

destructor TDataBlock.Destroy;
begin
  if not FIgnoreStream then
    FStream.Free;
  inherited Destroy;
end;

{ TDataBlock.IDataBlock }

function TDataBlock.GetBytesReserved: Integer;
begin
  Result := SizeOf(Integer) * 2;
end;

function TDataBlock.GetMemory: Pointer;
var
  DataSize: Integer;
begin
  FStream.Position := 4;
  DataSize := FStream.Size - BytesReserved;
  FStream.Write(DataSize, SizeOf(DataSize));
  Result := FStream.Memory;
end;

function TDataBlock.GetSize: Integer;
begin
  Result := FStream.Size - BytesReserved;
end;

procedure TDataBlock.SetSize(Value: Integer);
begin
  FStream.Size := Value + BytesReserved;
end;

function TDataBlock.GetStream: TStream;
var
  DataSize: Integer;
begin
  FStream.Position := 4;
  DataSize := FStream.Size - BytesReserved;
  FStream.Write(DataSize, SizeOf(DataSize));
  FStream.Position := 0;
  Result := FStream;
end;

function TDataBlock.GetSignature: Integer;
begin
  FStream.Position := 0;
  FStream.Read(Result, SizeOf(Result));
end;

procedure TDataBlock.SetSignature(Value: Integer);
begin
  FStream.Position := 0;
  FStream.Write(Value, SizeOf(Value));
end;

procedure TDataBlock.Clear;
begin
  FStream.Size := BytesReserved;
  FReadPos := BytesReserved;
  FWritePos := BytesReserved;
end;

function TDataBlock.Write(const Buffer; Count: Integer): Integer;
begin
  FStream.Position := FWritePos;
  Result := FStream.Write(Buffer, Count);
  FWritePos := FStream.Position;
end;

function TDataBlock.Read(var Buffer; Count: Integer): Integer;
begin
  FStream.Position := FReadPos;
  Result := FStream.Read(Buffer, Count);
  FReadPos := FStream.Position;
end;

procedure TDataBlock.IgnoreStream;
begin
  FIgnoreStream := True;
end;

function TDataBlock.InitData(Data: Pointer; DataLen: Integer; CheckLen: Boolean): Integer; stdcall;
var
  Sig: Integer;
  P: Pointer;
begin
  P := Data;
  if DataLen < MINDATAPACKETSIZE then
    raise Exception.CreateRes(@SInvalidDataPacket);
  Sig := Integer(P^);
  P := Pointer(Integer(Data) + SizeOf(Sig));
  CheckSignature(Sig);
  Signature := Sig;
  Result := Integer(P^);
  P := Pointer(Integer(P) + SizeOf(Result));
  if CheckLen then
  begin
    if (Result <> DataLen - MINDATAPACKETSIZE) then
      raise Exception.CreateRes(@SInvalidDataPacket);
    Size := Result;
    if Result > 0 then
      Write(P^, Result);
  end else
  begin
    Size := DataLen - MINDATAPACKETSIZE;
    if Size > 0 then
      Write(P^, Size);
  end;
end;

{ TZTransportThread }

constructor TZTransportThread.Create(AHandle: THandle; Transport: ITransport);
begin
  hEvent := CreateEvent(nil, True, False, nil);
  FReadEvent := CreateEvent(nil, True, False, nil);
  SetReadEvent;
  FParentHandle := AHandle;
  FTransport := Transport;
  FreeOnTerminate := false;
  FSemaphore := CreateSemaphore(nil, 0, 1, nil);
  FData := nil;
  FMsg  := 0;
  inherited Create(False);
end;

destructor TZTransportThread.Destroy;
begin
  FData := nil;
  FTransport := nil;
  CloseHandle(FSemaphore);
  if hEvent<>0 then CloseHandle(hEvent);
  if FReadEvent<>0 then CloseHandle(FReadEvent);
  inherited Destroy;
end;

procedure TZTransportThread.Execute;

  procedure SynchronizeException;
  var
    SendException: TObject;
  begin
    SendException := AcquireExceptionObject;
    hEventMsg := THREAD_EXCEPTION;
    if SendException<>nil then
       begin
         if Assigned(FTransport) and (SendException is ESocketConnectionError) then
            FTransport.Connected := False;
         hEventData := Pointer(SendException);
       end
    else
       hEventData := Exception.Create('Socket通讯错误，服务端强行关闭');
    SetThreadEvent;
  end;

var
  msg: TMsg;
  Data: IDataBlock;
  Event: THandle;
  Context: Integer;
begin
  CoInitialize(nil);
  try
    PeekMessage(msg, 0, WM_USER, WM_USER, PM_NOREMOVE);
    try
      try
        try
          try
            FTransport.Connected := True;
          except
            SynchronizeException;
          end;
        finally
          ReleaseSemaphore(FSemaphore, 1, nil);
        end;
        Event := FTransport.GetWaitEvent;
        while not Terminated and FTransport.Connected do
        try
          case MsgWaitForMultipleObjects(1, Event, False, INFINITE, QS_ALLINPUT) of
            WAIT_OBJECT_0:
            begin
              WSAResetEvent(Event);
              Data := FTransport.Receive(False, 0);
              if Assigned(Data) then
              begin
                Data._AddRef;
                if (Data.Signature and ResultSig) <> ResultSig then
                   PostMessage(FParentHandle, THREAD_RECEIVEDSTREAM, 0, Integer(Pointer(Data)))
                else
                   begin
                     hEventMsg := THREAD_RECEIVEDSTREAM;
                     hEventData := Pointer(Data);
                     SetThreadEvent;
                   end;
                Data := nil;
              end;
            end;
            WAIT_OBJECT_0 + 1:
            begin
              while PeekMessage(msg, 0, 0, 0, PM_REMOVE) do
              begin
                if (msg.hwnd = 0) then
                  case msg.message of
                    THREAD_SENDSTREAM:
                    begin
                      Data := IDataBlock(msg.lParam);
                      Data._Release;
                      Context := FTransport.Send(Data);
                      if Boolean(msg.wParam) then
                      begin
                        Data := FTransport.Receive(True, Context);
                        Data._AddRef;
                        hEventMsg := THREAD_RECEIVEDSTREAM;
                        hEventData := Pointer(Data);
                        SetThreadEvent;
                        Data := nil;
                      end else
                      begin
                        if (Data.Signature and ResultSig) <> ResultSig then
                           begin
                             hEventMsg := THREAD_SENDNOTIFY;
                             hEventData := nil;
                             SetThreadEvent;
                           end;
                        Data := nil;
                      end;
                    end;
                    THREAD_REPLACETRANSPORT:
                    begin
                      FTransport := ITransport(msg.lParam);
                      FTransport._Release;
                    end;
                  else
                    DispatchMessage(msg);
                  end
                else
                  DispatchMessage(msg);
              end;
            end;
          end;   
        except
          SynchronizeException;
        end;
      finally
        Data := nil;
        if FTransport<>nil then
        FTransport.Connected := False;
        PostMessage(FParentHandle, THREAD_DISCONNECT, 0, 0);
      end;
    except
      SynchronizeException;
    end;
finally
    FTransport := nil;
    CoUninitialize();
  end;
end;

function TZTransportThread.GetEventData: Pointer;
begin
  Result := FData;
  FData := nil;
//  SetReadEvent;
end;

function TZTransportThread.GetMsg: UINT;
begin
  result := FMsg;
end;

procedure TZTransportThread.ResetReadEvent;
begin
  ResetEvent(FReadEvent);
end;

procedure TZTransportThread.ResetThreadEvent;
begin
  ResetEvent(hEvent);
end;

procedure TZTransportThread.SetData(const Value: Pointer);
begin
  FData := Value;
end;

procedure TZTransportThread.SethEvent(const Value: THandle);
begin
  FhEvent := Value;
end;

procedure TZTransportThread.SetMsg(const Value: UINT);
begin
//  WaitForSingleObject(hReadEvent, INFINITE);
//  ResetReadEvent;
  FMsg := Value;
end;

procedure TZTransportThread.SetReadEvent;
begin
  SetEvent(FReadEvent);
end;

procedure TZTransportThread.SetThreadEvent;
begin
  SetEvent(hEvent);
end;

{ TZSocketTransport }

constructor TZSocketTransport.Create;
begin
  InitializeCriticalSection(FThreadLock);
  FInterceptor := nil;
  inherited Create;
  FEvent := 0;
end;

destructor TZSocketTransport.Destroy;
begin
  Enter;
  try
     FInterceptor := nil;
     SetConnected(False);
     inherited Destroy;
  finally
     Leave;
     DeleteCriticalSection(FThreadLock);
  end;
end;

function TZSocketTransport.GetWaitEvent: THandle;
begin
  FEvent := WSACreateEvent;
  WSAEventSelect(FSocket.SocketHandle, FEvent, FD_READ or FD_CLOSE);
  Result := FEvent;
end;

function TZSocketTransport.GetConnected: Boolean;
begin
  Result := (FSocket <> nil) and (FSocket.Connected);// and CheckClientSocket(FSocket.SocketHandle);
end;

procedure TZSocketTransport.SetConnected(Value: Boolean);
var
  Addr: TSockAddrIn;
  AddrLen, Ret, ErrCode, opt ,insize,outsize: Integer;
begin
  if GetConnected = Value then Exit;
  if Value then
  begin
    if (FAddress = '') and (FHost = '') then
      raise ESocketConnectionError.CreateRes(@SNoAddress);
    FClientSocket := TClientSocket.Create(nil);
    FClientSocket.ClientType := ctBlocking;
    FSocket := FClientSocket.Socket;
    FClientSocket.Port := FPort;
    if FAddress <> '' then
      FClientSocket.Address := FAddress
    else
      FClientSocket.Host := FHost;
    FClientSocket.Open;
  end else
  begin
    if FSocket <> nil then FSocket.Close;
    FSocket := nil;
    FreeAndNil(FClientSocket);
    if FEvent <> 0 then WSACloseEvent(FEvent);
    FEvent := 0;
  end;
end;

function TZSocketTransport.Receive(WaitForInput: Boolean; Context: Integer): IDataBlock;
var
  RetLen, Sig, StreamLen: Integer;
  P: Pointer;
  FDSet: TFDSet;
  TimeVal: PTimeVal;
  RetVal: Integer;
  _Start:int64;
begin
  Enter;
  try
    Result := nil;
    TimeVal := nil;
    FD_ZERO(FDSet);
    FD_SET(FSocket.SocketHandle, FDSet);
    if not WaitForInput then
    begin
      New(TimeVal);
      TimeVal.tv_sec := 0;
      TimeVal.tv_usec := 1;
    end;
    RetVal := select(0, @FDSet, nil, nil, TimeVal);
    if Assigned(TimeVal) then
       FreeMem(TimeVal);
    if RetVal = SOCKET_ERROR then
      raise ESocketConnectionError.Create(SysErrorMessage(WSAGetLastError));
    if (RetVal = 0) then Exit;
    RetLen := FSocket.ReceiveBuf(Sig, SizeOf(Sig));
    if RetLen <> SizeOf(Sig) then
      raise Exception.Create('服务器发送无效数据包。');
    CheckSignature(Sig);
    RetLen := FSocket.ReceiveBuf(StreamLen, SizeOf(StreamLen));
    if RetLen = 0 then
      raise Exception.Create('远程服务器已断开连接。');
    if RetLen <> SizeOf(StreamLen) then
      raise Exception.Create('服务器发送无效数据包。');
    Result := TDataBlock.Create as IDataBlock;
    Result.Size := StreamLen;
    Result.Signature := Sig;
    P := Result.Memory;
    Inc(Integer(P), Result.BytesReserved);
    _Start := GetTickCount;
    while (StreamLen > 0) and FSocket.Connected do
    begin
      RetLen := FSocket.ReceiveBuf(P^, StreamLen);
      if RetLen<=0 then
        begin
           if ((GetTickCount-_Start)>5000) then
            begin
              FSocket.Close;
              raise ESocketConnectionError.Create('Socket连接被断开了，请重试吧');
            end;
        end
      else
        begin
          _Start := GetTickCount;
          Dec(StreamLen, RetLen);
          Inc(Integer(P), RetLen);
        end;
    end;
    if StreamLen <> 0 then
       raise ESocketConnectionError.CreateRes(@SInvalidDataPacket);
    InterceptIncoming(Result);
  finally
    Leave;
  end;
end;

function TZSocketTransport.Send(const Data: IDataBlock): Integer;
var
  P: Pointer;
  AmountSent,Amount:Integer;
  _Start:int64;
begin
  Enter;
  try
     Result := 0;
     InterceptOutgoing(Data);
     P := Data.Memory;
     Amount := Data.Size + Data.BytesReserved;
     _Start := GetTickCount;
     while (Amount>0) and FSocket.Connected do
       begin
         AmountSent := FSocket.SendBuf(P^, Amount);
         if AmountSent<=0 then
            begin
               if ((GetTickCount-_Start)>5000) then
               begin
                  FSocket.Close;
                  raise ESocketConnectionError.Create('Socket连接被断开了，请重试吧');
               end;
            end
         else
            begin
              _Start := GetTickCount;
              Dec(Amount,AmountSent);
              Inc(Result,AmountSent);
              P := Pointer(Integer(P) + AmountSent);
            end;
       end;
    if Amount <> 0 then raise ESocketConnectionError.CreateRes(@SInvalidDataPacket);
  finally
     Leave;
  end;
end;

function TZSocketTransport.CheckInterceptor: Boolean;
var
  GUID: TGUID;
begin
  if not Assigned(FInterceptor) then
    if not FCreateAttempted then
    try
      FCreateAttempted := True;
      FInterceptor := TZDataCompressor.Create;
    except
      { raise no exception if the creating failed }
    end;
  Result := Assigned(FInterceptor);
end;

procedure TZSocketTransport.InterceptIncoming(const Data: IDataBlock);
begin
  if CheckInterceptor then
    FInterceptor.DataIn(Data);
end;

procedure TZSocketTransport.InterceptOutgoing(const Data: IDataBlock);
begin
  if CheckInterceptor then
    FInterceptor.DataOut(Data);
end;

{ TZDataCompressor }
{
  DataIn is called whenever data is coming into the client or server.  Use this
  procedure to uncompress or decrypt data.
}
procedure TZDataCompressor.DataIn(const Data: IDataBlock);
var
  Size: Integer;
  InStream, OutStream: TMemoryStream;
  ZStream: TDecompressionStream;
  p: Pointer;
begin
  InStream := TMemoryStream.Create;
  try
    { Skip BytesReserved bytes of data }
    p := Pointer(Integer(Data.Memory) + Data.BytesReserved);
    Size := PInteger(p)^;
    if Size = 0 then Exit; 
    p := Pointer(Integer(p) + SizeOf(Size));
    InStream.Write(p^, Data.Size - SizeOf(Size));
    OutStream := TMemoryStream.Create;
    try
      InStream.Position := 0;
      ZStream := TDecompressionStream.Create(InStream);
      try
        OutStream.CopyFrom(ZStream, Size);
      finally
        ZStream.Free;
      end;
      { Clear the datablock, then write the uncompressed data back into the
        datablock }
      Data.Clear;
      Data.Write(OutStream.Memory^, OutStream.Size);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

{
  DataOut is called whenever data is leaving the client or server.  Use this
  procedure to compress or encrypt data.
}
procedure TZDataCompressor.DataOut(const Data: IDataBlock);
var
  InStream, OutStream: TMemoryStream;
  ZStream: TCompressionStream;
  Size: Integer;
begin
  InStream := TMemoryStream.Create;
  try
    { Skip BytesReserved bytes of data }
    InStream.Write(Pointer(Integer(Data.Memory) + Data.BytesReserved)^, Data.Size);
    Size := InStream.Size;
    if Size = 0 then Exit; 
    OutStream := TMemoryStream.Create;
    try
      ZStream := TCompressionStream.Create(clFastest, OutStream);
      try
        ZStream.CopyFrom(InStream, 0);
      finally
        ZStream.Free;
      end;
      { Clear the datablock, then write the compressed data back into the
        datablock }
      Data.Clear;
      Data.Write(Size, SizeOf(Integer));
      Data.Write(OutStream.Memory^, OutStream.Size);
    finally
      OutStream.Free;
    end;
  finally
    InStream.Free;
  end;
end;

procedure TZSocketTransport.Enter;
begin
  EnterCriticalSection(FThreadLock);

end;

procedure TZSocketTransport.Leave;
begin
  LeaveCriticalSection(FThreadLock);

end;

procedure TZSocketTransport.SetSocket(const Value: TCustomWinSocket);
begin
  FSocket := Value;
  //FSocket.OnSocketEvent := DoSocketEvent;
end;

function TZSocketTransport.CheckClientSocket(S: TSocket): Boolean;
var
  FdSet: TFdSet;
  Chk,
    Size: integer;
  Time: TTimeVal;
begin
  Result := false;
  Fillchar(Time, SizeOf(TTimeVal), 0);
  { clear the set }
  Fd_Zero(FdSet);
  { add in the socket to test }
  Fd_Set(S, FdSet);
  { poll the socket }
  Chk := Select(0, @FdSet, nil, nil, @Time);

  if Chk > 0 then begin
    Chk := IoCtlSocket(FdSet.Fd_Array[0], FIONREAD, Size);
    if Chk < 0 then Result := False else if Size = 0 then Result := False else Result := true;
  end else if Chk = 0 then Result := true else Result := False;
end;

function TZSocketTransport.GetSocketHandle: THandle;
begin
  Result := Socket.SocketHandle;
end;

{ TZDataBlockInterpreter }

procedure TZDataBlockInterpreter.InterpretData(const Data: IDataBlock);
var
  Action: Integer;
begin
  Action := Data.Signature;
  if (Action and asMask) = asError then
     begin
       DoException(Data);
     end;
  try
    case (Action and asMask) of
      asInvoke: DoInvoke(Data);
    else
      raise EInterpreterError.CreateResFmt(@SInvalidAction, [Action and asMask]);
    end;
  except
    on E: EInvokeDispatchError do
    begin
      Data.Clear;
      WriteVariant(E.Message, Data);
      Data.Signature := ResultSig or asError;
      if FSendDataBlock<>nil then
         FSendDataBlock.Send(Data, False);
      LogFile.AddLogFile(2,E.Message,E.bstrSource);
    end;
    on E: Exception do
    begin
      Data.Clear;
      WriteVariant(E.Message, Data);
      Data.Signature := ResultSig or asError;
      if (FSendDataBlock<>nil) then
         FSendDataBlock.Send(Data, False);
      LogFile.AddLogFile(2,E.Message,'TZDataBlockInterpreter.InterpretData');
    end;
  end;
end;

constructor TZDataBlockInterpreter.Create(SendDataBlock: ISendDataBlock;
  CheckRegValue: string);
begin
  inherited Create;
  FLock := TCriticalSection.Create;
  FSendDataBlock := SendDataBlock;
  Disp := nil;
end;

destructor TZDataBlockInterpreter.Destroy;
begin
  Lock;
  try
    FSendDataBlock := nil;
    Disp := nil;
    DoInvokeDispatch := nil;
  finally
    UnLock;
  end;
  FLock.Free;
  inherited Destroy;
end;

procedure TZDataBlockInterpreter.DoInvoke(const Data: IDataBlock);
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  Token,LocaleID,Flags, i: Integer;
  RetVal: HRESULT;
  ExpectResult: Boolean;
  VarFlags: TVarFlags;
  VarList: PVariantArray;
  V: OleVariant;
begin
  if Disp=nil then
     Raise Exception.CreateResfmt(@SIdQuarrelWith,['DataBase']);
  VarList := nil;
  FillChar(ExcepInfo, SizeOf(ExcepInfo), 0);
  FillChar(DispParams, SizeOf(DispParams), 0);
  try
    Token := ReadVariant(VarFlags, Data);
    LocaleID := ReadVariant(VarFlags, Data);
    Flags := ReadVariant(VarFlags, Data);
    ExpectResult := ReadVariant(VarFlags, Data);
    DispParams.cArgs := ReadVariant(VarFlags, Data);
    DispParams.cNamedArgs := ReadVariant(VarFlags, Data);
    try
      DispParams.rgdispidNamedArgs := nil;
      if DispParams.cNamedArgs > 0 then
      begin
        GetMem(DispParams.rgdispidNamedArgs, DispParams.cNamedArgs * SizeOf(Integer));
        for i := 0 to DispParams.cNamedArgs - 1 do
          DispParams.rgdispidNamedArgs[i] := ReadVariant(VarFlags, Data);
      end;
      if DispParams.cArgs > 0 then
      begin
        GetMem(DispParams.rgvarg, (DispParams.cArgs+1) * SizeOf(TVariantArg));
        GetMem(VarList, DispParams.cArgs * SizeOf(OleVariant));
        Initialize(VarList^, DispParams.cArgs);
        DispParams.rgvarg[DispParams.cArgs].vt := varVariant or varByRef;
        TVarData(DispParams.rgvarg[DispParams.cArgs]).VPointer := @VarList[0];
        for i := 0 to DispParams.cArgs - 1 do
        begin
          VarList[i] := ReadVariant(VarFlags, Data);
          if vfByRef in VarFlags then
          begin
            if vfVariant in VarFlags then
            begin
              DispParams.rgvarg[i].vt := varVariant or varByRef;
              TVarData(DispParams.rgvarg[i]).VPointer := @VarList[i];
            end else
            begin
              DispParams.rgvarg[i].vt := VarType(VarList[i]) or varByRef;
              TVarData(DispParams.rgvarg[i]).VPointer := GetVariantPointer(VarList[i]);
            end;
          end else
            DispParams.rgvarg[i] := TVariantArg(VarList[i]);
        end;
      end;
      if ExpectResult then V := ReadVariant(VarFlags, Data);
      Data.Clear;
      RetVal := Disp.DoInvoke(Token, LocaleID, Flags, DispParams, @V, @ExcepInfo, nil);
      WriteVariant(RetVal, Data);
      if RetVal = DISP_E_EXCEPTION then
      begin
        WriteVariant(ExcepInfo.scode, Data);
        WriteVariant(ExcepInfo.bstrDescription, Data);
      end;
      if DispParams.rgvarg <> nil then
      begin
        for i := 0 to DispParams.cArgs - 1 do
          if DispParams.rgvarg[i].vt and varByRef = varByRef then
            WriteVariant(OleVariant(DispParams.rgvarg[i]), Data);
      end;
      if ExpectResult then WriteVariant(V, Data);
      Data.Signature := ResultSig or asInvoke;
      if FSendDataBlock<>nil then
         FSendDataBlock.Send(Data, False);
    finally
      if DispParams.rgdispidNamedArgs <> nil then
        FreeMem(DispParams.rgdispidNamedArgs);
      if VarList <> nil then
      begin
        Finalize(VarList^, DispParams.cArgs);
        FreeMem(VarList);
      end;
      if DispParams.rgvarg <> nil then
        FreeMem(DispParams.rgvarg);
    end;
  finally
  end;
end;

function  TZDataBlockInterpreter.CallInvoke(Token,LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; 
var
  VarFlags: TVarFlags;
  PDest: PVarData;
  i: Integer;
  Data: IDataBlock;
begin
  Data := TDataBlock.Create as IDataBlock;
  WriteVariant(Token, Data);
  WriteVariant(LocaleID, Data);
  WriteVariant(Flags, Data);
  WriteVariant(VarResult <> nil, Data);
  WriteVariant(PDispParams(@Params).cArgs, Data);
  WriteVariant(PDispParams(@Params).cNamedArgs, Data);
  for i := 0 to PDispParams(@Params).cNamedArgs - 1 do
    WriteVariant(PDispParams(@Params).rgdispidNamedArgs[i], Data);
  for i := 0 to PDispParams(@Params).cArgs - 1 do
    WriteVariant(OleVariant(PDispParams(@Params).rgvarg^[i]), Data);
  if VarResult<>nil then
    WriteVariant(PVariant(VarResult)^,Data);
  Data.Signature := CallSig or asInvoke;
  Data := FSendDataBlock.Send(Data, True);
  if Data=nil then
  begin
    Result := DISP_E_EXCEPTION;
    PExcepInfo(ExcepInfo).scode := 9999999;
    PExcepInfo(ExcepInfo).bstrDescription := LoadResString(@SIdInvalidDataBlock);
  end;
  Result := ReadVariant(VarFlags, Data);
  if (Result = DISP_E_EXCEPTION) then
  begin
    PExcepInfo(ExcepInfo).scode := ReadVariant(VarFlags, Data);
    PExcepInfo(ExcepInfo).bstrDescription := ReadVariant(VarFlags, Data);
  end;
  for i := 0 to PDispParams(@Params).cArgs - 1 do
    with PDispParams(@Params)^ do
      if rgvarg^[i].vt and varByRef = varByRef then
      begin
        if rgvarg^[i].vt = (varByRef or varVariant) then
          PDest := @TVarData(TVarData(rgvarg^[i]).VPointer^)
        else
          PDest := @TVarData(rgvarg^[i]);
        CopyDataByRef(TVarData(ReadVariant(VarFlags, Data)), PDest^);
      end;
  if VarResult <> nil then
    PVariant(VarResult)^ := ReadVariant(VarFlags, Data);
end;

procedure TZDataBlockInterpreter.SetDoInvokeDispatch(
  const Value: IDoInvokeDispatch);
begin
  Disp := Value;
end;

procedure TZDataBlockInterpreter.Lock;
begin
  FLock.Enter;
end;

procedure TZDataBlockInterpreter.UnLock;
begin
  FLock.Leave;
end;

{ TZCustomDataBlockInterpreter }

procedure TZCustomDataBlockInterpreter.CopyDataByRef(const Source: TVarData;
  var Dest: TVarData);
var
  VType: Integer;
begin
  VType := Source.VType;
  if Source.VType and varArray = varArray then
  begin
    VarClear(OleVariant(Dest));
    SafeArrayCheck(SafeArrayCopy(PSafeArray(Source.VArray), PSafeArray(Dest.VArray)));
  end else
    case Source.VType and varTypeMask of
      varEmpty, varNull: ;
      varOleStr:
      begin
        if (Dest.VType and varTypeMask) <> varOleStr then
          Dest.VOleStr := SysAllocString(Source.VOleStr)
        else if (Dest.VType and varByRef) = varByRef then
          SysReallocString(PBStr(Dest.VOleStr)^,Source.VOleStr)
        else
          SysReallocString(Dest.VOleStr,Source.VOleStr);
      end;
      varDispatch: Dest.VDispatch := Source.VDispatch;
      varVariant: CopyDataByRef(PVarData(Source.VPointer)^, Dest);
      varUnknown: Dest.VUnknown := Source.VUnknown;
    else
      if Dest.VType = 0 then
        OleVariant(Dest) := OleVariant(Source)
      else if Dest.VType and varByRef = varByRef then
      begin
        VType := VType or varByRef;
        Move(Source.VPointer, Dest.VPointer^, VariantSize[Source.VType and varTypeMask]);
      end
      else
        Move(Source.VPointer, Dest.VPointer, VariantSize[Source.VType and varTypeMask]);
    end;
  Dest.VType := VType;
end;

procedure TZCustomDataBlockInterpreter.DoException(const Data: IDataBlock);
var
  VarFlags: TVarFlags;
begin
  raise Exception.Create(ReadVariant(VarFlags, Data));
end;

function TZCustomDataBlockInterpreter.GetVariantPointer(
  const Value: OleVariant): Pointer;
begin
  case VarType(Value) of
    varEmpty, varNull: Result := nil;
    varDispatch: Result := TVarData(Value).VDispatch;
    varVariant: Result := @Value;
    varUnknown: Result := TVarData(Value).VUnknown;
  else
    Result := @TVarData(Value).VPointer;
  end;
end;

function TZCustomDataBlockInterpreter.ReadArray(VType: Integer;
  const Data: IDataBlock): OleVariant;
var
  Flags: TVarFlags;
  LoDim, HiDim, Indices, Bounds: PIntArray;
  DimCount, VSize, i: Integer;
  {P: Pointer;}
  V: OleVariant;
  LSafeArray: PSafeArray;
  P: Pointer;
begin
  VarClear(Result);
  Data.Read(DimCount, SizeOf(DimCount));
  VSize := DimCount * SizeOf(Integer);
  GetMem(LoDim, VSize);
  try
    GetMem(HiDim, VSize);
    try
      Data.Read(LoDim^, VSize);
      Data.Read(HiDim^, VSize);
      GetMem(Bounds, VSize * 2);
      try
        for i := 0 to DimCount - 1 do
        begin
          Bounds[i * 2] := LoDim[i];
          Bounds[i * 2 + 1] := HiDim[i];
        end;
        Result := VarArrayCreate(Slice(Bounds^,DimCount * 2), VType and varTypeMask);
      finally
        FreeMem(Bounds);
      end;
      if VType and varTypeMask in EasyArrayTypes then
      begin
        Data.Read(VSize, SizeOf(VSize));
        P := VarArrayLock(Result);
        try
          Data.Read(P^, VSize);
        finally
          VarArrayUnlock(Result);
        end;
      end else
      begin
        LSafeArray := PSafeArray(TVarData(Result).VArray);
        GetMem(Indices, VSize);
        try
          FillChar(Indices^, VSize, 0);
          for I := 0 to DimCount - 1 do
            Indices[I] := LoDim[I];
          while True do
          begin
            V := ReadVariant(Flags, Data);
            if VType and varTypeMask = varVariant then
              SafeArrayCheck(SafeArrayPutElement(LSafeArray, Indices^, V))
            else
              SafeArrayCheck(SafeArrayPutElement(LSafeArray, Indices^, TVarData(V).VPointer^));
            Inc(Indices[DimCount - 1]);
            if Indices[DimCount - 1] > HiDim[DimCount - 1] then
              for i := DimCount - 1 downto 0 do
                if Indices[i] > HiDim[i] then
                begin
                  if i = 0 then Exit;
                  Inc(Indices[i - 1]);
                  Indices[i] := LoDim[i];
                end;
          end;
        finally
          FreeMem(Indices);
        end;
      end;
    finally
      FreeMem(HiDim);
    end;
  finally
    FreeMem(LoDim);
  end;
end;

function TZCustomDataBlockInterpreter.ReadVariant(out Flags: TVarFlags;
  const Data: IDataBlock): OleVariant;
var
  I, VType: Integer;
  W: WideString;
  S: String;
  TmpFlags: TVarFlags;
begin
  VarClear(Result);
  Flags := [];
  Data.Read(VType, SizeOf(VType));
  if VType and varByRef = varByRef then
    Include(Flags, vfByRef);
  if VType = varByRef then
  begin
    Include(Flags, vfVariant);
    Result := ReadVariant(TmpFlags, Data);
    Exit;
  end;
  if vfByRef in Flags then
    VType := VType xor varByRef;
  if (VType and varArray) = varArray then
    Result := ReadArray(VType, Data) else
  case VType and varTypeMask of
    varEmpty: VarClear(Result);
    varNull: Result := NULL;
    varOleStr:
    begin
      Data.Read(I, SizeOf(Integer));
      SetLength(W, I);
      Data.Read(W[1], I * 2);
      Result := W;
    end;
    varString:
    begin
      Data.Read(I, SizeOf(Integer));
      SetLength(S, I);
      Data.Read(S[1], I);
      Result := S;
    end;
    varDispatch:
    begin
      raise EInterpreterError.CreateResFmt(@SBadVariantType,['varDispatch']);
      {Data.Read(I, SizeOf(Integer));
      Result := TDataDispatch.Create(Self, I) as IDispatch; }
    end;
    varUnknown:
      raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
  else
    TVarData(Result).VType := VType;
    Data.Read(TVarData(Result).VPointer, VariantSize[VType and varTypeMask]);
  end;
end;

procedure TZCustomDataBlockInterpreter.WriteArray(const Value: OleVariant;
  const Data: IDataBlock);
var
  LVarData: TVarData;
  VType: Integer;
  VSize, i, DimCount, ElemSize: Integer;
  LSafeArray: PSafeArray;
  LoDim, HiDim, Indices: PIntArray;
  V: OleVariant;
  P: Pointer;
begin
  LVarData := FindVarData(Value)^;
  VType := LVarData.VType;
  LSafeArray := PSafeArray(LVarData.VPointer);
                         
  Data.Write(VType, SizeOf(Integer));
  DimCount := VarArrayDimCount(Value);
  Data.Write(DimCount, SizeOf(DimCount));
  VSize := SizeOf(Integer) * DimCount;
  GetMem(LoDim, VSize);
  try
    GetMem(HiDim, VSize);
    try
      for i := 1 to DimCount do
      begin
        LoDim[i - 1] := VarArrayLowBound(Value, i);
        HiDim[i - 1] := VarArrayHighBound(Value, i);
      end;
      Data.Write(LoDim^,VSize);
      Data.Write(HiDim^,VSize);
      if VType and varTypeMask in EasyArrayTypes then
      begin
        ElemSize := SafeArrayGetElemSize(LSafeArray);
        VSize := 1;
        for i := 0 to DimCount - 1 do
          VSize := (HiDim[i] - LoDim[i] + 1) * VSize;
        VSize := VSize * ElemSize;
        P := VarArrayLock(Value);
        try
          Data.Write(VSize, SizeOf(VSize));
          Data.Write(P^,VSize);
        finally
          VarArrayUnlock(Value);
        end;
      end else
      begin
        GetMem(Indices, VSize);
        try
          for I := 0 to DimCount - 1 do
            Indices[I] := LoDim[I];
          while True do
          begin
            if VType and varTypeMask <> varVariant then
            begin
              SafeArrayCheck(SafeArrayGetElement(LSafeArray, Indices^, TVarData(V).VPointer));
              TVarData(V).VType := VType and varTypeMask;
            end else
              SafeArrayCheck(SafeArrayGetElement(LSafeArray, Indices^, V));
            WriteVariant(V, Data);
            Inc(Indices[DimCount - 1]);
            if Indices[DimCount - 1] > HiDim[DimCount - 1] then
              for i := DimCount - 1 downto 0 do
                if Indices[i] > HiDim[i] then
                begin
                  if i = 0 then Exit;
                  Inc(Indices[i - 1]);
                  Indices[i] := LoDim[i];
                end;
          end;
        finally
          FreeMem(Indices);
        end;
      end;
    finally
      FreeMem(HiDim);
    end;
  finally
    FreeMem(LoDim);
  end;
end;

procedure TZCustomDataBlockInterpreter.WriteVariant(const Value: OleVariant;
  const Data: IDataBlock);
var
  I, VType: Integer;
  W: WideString;
  S: string;
begin
  VType := VarType(Value);
  if VType and varArray <> 0 then
    WriteArray(Value, Data)
  else
    case (VType and varTypeMask) of
      varEmpty, varNull:
        Data.Write(VType, SizeOf(Integer));
      varOleStr:
      begin
        W := WideString(Value);
        I := Length(W);
        Data.Write(VType, SizeOf(Integer));
        Data.Write(I,SizeOf(Integer));
        Data.Write(W[1], I * 2);
      end;
      varString:
      begin
        S := Value;
        I := Length(S);
        Data.Write(VType, SizeOf(Integer));
        Data.Write(I,SizeOf(Integer));
        Data.Write(S[1], I);
      end;
      varDispatch:
      begin
        Raise Exception.CreateResFmt(@SBadVariantType,['varDispatch']);
        {if VType and varByRef = varByRef then
          raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
        I := StoreObject(Value);
        Data.Write(VType, SizeOf(Integer));
        Data.Write(I, SizeOf(Integer)); }
      end;
      varVariant:
      begin
        if VType and varByRef <> varByRef then
          raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
        I := varByRef;
        Data.Write(I, SizeOf(Integer));
        WriteVariant(Variant(TVarData(Value).VPointer^), Data);
      end;
      varUnknown:
        raise EInterpreterError.CreateResFmt(@SBadVariantType,[IntToHex(VType,4)]);
    else
      Data.Write(VType, SizeOf(Integer));
      if VType and varByRef = varByRef then
        Data.Write(TVarData(Value).VPointer^, VariantSize[VType and varTypeMask])
      else
        Data.Write(TVarData(Value).VPointer, VariantSize[VType and varTypeMask]);
    end;
end;

{ EInvokeDispatchError }

constructor EInvokeDispatchError.CreateDispatchError(const Msg,
  SourceInfo: string);
begin
  inherited Create(Msg);
  bstrSource := SourceInfo;
end;

procedure EInvokeDispatchError.SetbstrSource(const Value: WideString);
begin
  FbstrSource := Value;
end;

end.







