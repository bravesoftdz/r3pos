unit ZClient;

interface
uses
  VarUtils, Variants, Windows, Messages, Classes, SysUtils,DB,RTLConsts,
  ScktComp, ZWSock2,MidConst, WinInet,ComObj,ZPacket,ZConst,ZIntf,
  ActiveX,DSIntf,ZdbHelp,ZBase,ZDataSet;
const
  IOC_IN               =$80000000;
  IOC_VENDOR           =$18000000;
  IOC_out              =$40000000;
  SIO_KEEPALIVE_VALS   =IOC_IN or IOC_VENDOR or 4;
type
  TTCP_KEEPALIVE = packed record
    onoff             : integer;
    keepalivetime     : integer;
    keepaliveinterval : integer;
  end;

  EInvokeDispatchError =class(Exception);
  TZClient=class;

  TDoInvokeClientDispatch = class(TInterfacedObject, IDoInvokeDispatch)
  private
    FParant: TZClient;
  protected
    //接收服务端发来的数据
    function DoInvoke(Token,LocaleID: Integer;
      Flags: Word;var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;stdcall;
  public
    property  Parant:TZClient read FParant write FParant;
  end;
  TZClient = class(TCustomdbResolver,ISendDataBlock)
  private
    FInterpreter: TZDataBlockInterpreter;
    FTransIntf: ITransport;
    FTransport: TZTransportThread;
    FSupportCallbacks:Boolean;
    FHandle:THandle;
    FEnabledBanlace: Boolean;
    FPort: Integer;
    FHost: string;
    FAddress: string;
    FServerGuid: WideString;
    FThreadLock:TRTLCriticalSection;
    FInWorking: Integer;
    FDisp:TDoInvokeClientDispatch;
    function GetHandle: THandle;
    function GetInterpreter: TZCustomDataBlockInterpreter;
    procedure SetEnabledBanlace(const Value: Boolean);
    procedure SetSupportCallbacks(const Value: Boolean);
    procedure TransportTerminated(Sender: TObject);
    function GetInWorking: Boolean;
  protected
    FList:TList;
    LocaliDbType:integer;
    LocalInTransaction:boolean;
    { ISendDataBlock }
    procedure Enter;
    procedure Leave;
    procedure KeepAlive(Socket:integer);
    function  Send(const Data: IDataBlock; WaitForResult: Boolean): IDataBlock; stdcall;

    function  CreateTransport: ITransport; virtual;
    procedure ThreadReceivedStream(var Message: TMessage); message THREAD_RECEIVEDSTREAM;
    procedure ThreadException(var Message: TMessage); message THREAD_EXCEPTION;
    procedure ThreadSendNotify(var Message: TMessage); message THREAD_SENDNOTIFY;
    procedure WndProc(var Message: TMessage);
    procedure InternalOpen; virtual;
    procedure InternalClose; virtual;
    procedure DoError(E: Exception); virtual;
    procedure CheckSocketConnected;

    property Handle: THandle read GetHandle;
    property Interpreter: TZCustomDataBlockInterpreter read GetInterpreter;
  protected
    crUserId,crUserName:string;
    procedure DoSKTParameter;
  public
    constructor Create;
    destructor Destroy; override;

    //设置连接参数< hostname=192.168.0.1;port=1024;dbid=1>
    function  Initialize(Const ConnStr:WideString):boolean;override;
    //读取连接串
    function  GetConnectionString:WideString;override;
    //连接数据库
    function  Connect:boolean;override;
    //检测通讯连接状态
    function  Connected:boolean;override;
    //关闭数据库
    function  DisConnect:boolean;override;

    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);override;
    //提交事务
    procedure CommitTrans;override;
    //回滚事务
    procedure RollbackTrans;override;
    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;override;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;override;

    //数据包组织
    function BeginBatch:Boolean;override;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;override;
    function OpenBatch:Boolean;override;
    function CommitBatch:Boolean;override;
    function CancelBatch:Boolean;override;

    //查询数据;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload; override;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload; override;
    function Open(DataSet:TDataSet):Boolean;overload;override;
    //提交数据
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload; override;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload; override;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;override;

    //返回执行影响记录数
    function ExecSQL(const SQL:WideString;ObjectFactory:TObject=nil):Integer;override;

    //执行远程方式，返回结果
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;override;

    //用户登录
    procedure GqqLogin(UserId:string;UserName:string);override;

    //锁定数据连接
    procedure DBLock(Locked:boolean);override;

    property Host: string read FHost write FHost;
    property Address: string read FAddress write FAddress;
    property Port:Integer read FPort write FPort;
    property EnabledBanlace:Boolean read FEnabledBanlace write SetEnabledBanlace;
    property InWorkIng:Boolean Read GetInWorking;
    property SupportCallbacks:Boolean read FSupportCallbacks write SetSupportCallbacks;
  end;
implementation
uses Forms,Registry;
{ TZClient }

function TZClient.Connect:boolean;
begin
  InternalOpen;
  DoSKTParameter;
end;

function TZClient.Connected: Boolean;
begin
  if FSupportCallbacks then
     Result := Assigned(FTransport)
  else
     Result := Assigned(FTransIntf) and FTransIntf.Connected;
end;

constructor TZClient.Create;
var
  Obj: ISendDataBlock;
begin
  FList := TList.Create;
  InitializeCriticalSection(FThreadLock);
  inherited Create;
  GetInterface(ISendDataBlock, Obj);
  FInterpreter := TZDataBlockInterpreter.Create(Obj,SSockets);
  FDisp := TDoInvokeClientDispatch.Create;
  FDisp.Parant := Self;
  FInterpreter.DoInvokeDispatch := FDisp;
  FSupportCallbacks := false;
  FInWorking := 0;
  LocaliDbType := -1;
end;


function TZClient.CreateTransport: ITransport;
var
  SocketTransport: TZSocketTransport;
begin
  if SupportCallbacks then
    if not LoadWinSock2 then raise Exception.CreateRes(@SNoWinSock2);
  if (FAddress = '') and (FHost = '') then
    raise ESocketConnectionError.CreateRes(@SNoAddress);
  SocketTransport := TZSocketTransport.Create;
  SocketTransport.Host := FHost;
  SocketTransport.Address := FAddress;
  SocketTransport.Port := FPort;
  Result := SocketTransport as ITransport;
end;

destructor TZClient.Destroy;
var
  i:integer;
begin
  Enter;
  try
     for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
     FList.Free;
     InternalClose;
     FInterpreter.DoInvokeDispatch := nil;
     FInterpreter.Free;
     if FHandle <> 0 then DeallocateHWnd(FHandle);
     if Assigned(FTransport) then FTransport.OnTerminate := nil;
     FTransIntf := nil;
     inherited Destroy;
     FDisp := nil;
  finally
     Leave;
     DeleteCriticalSection(FThreadLock);
  end;
end;

function TZClient.DisConnect:boolean;
begin
  InternalClose;
end;

procedure TZClient.DoError(E: Exception);
begin
  if not Connected or (E.Message=SSocketReadError)
     or (E.Message=SysErrorMessage(10054)) then
     begin
       if InWorking then
          Raise Exception.CreateRes(@SIdDisconnection)
     end
  else
     raise E;
end;

function TZClient.GetHandle: THandle;
begin
  if FHandle = 0 then
    FHandle := AllocateHwnd(WndProc);
  Result := FHandle;
end;

function TZClient.GetInterpreter: TZCustomDataBlockInterpreter;
begin
  if not Assigned(FInterpreter) then
    FInterpreter := TZDataBlockInterpreter.Create(Self, SSockets);
  Result := FInterpreter;
end;

procedure TZClient.InternalClose;
begin
  if Assigned(FTransport) then
  begin
    FTransport.OnTerminate := nil;
    FTransport.Terminate;
    PostThreadMessage(FTransport.ThreadID, WM_USER, 0, 0);
    if Assigned(FTransport.ParentTransport) then
       WaitForSingleObject(FTransport.Handle, 180000);
    FTransport := nil;
  end else
  if Assigned(FTransIntf) then
  begin
    FTransIntf.Connected := False;
    FTransIntf := nil;
  end;
end;

procedure TZClient.InternalOpen;
var
  SendException: TObject;
begin
  InternalClose;
  if FSupportCallbacks then
  begin
    FTransport := TZTransportThread.Create(Handle, CreateTransport);
    FTransport.OnTerminate := TransportTerminated;
    WaitForSingleObject(FTransport.Semaphore, INFINITE);
    if FTransport.hEventMsg=THREAD_EXCEPTION then
       DoError(Exception(FTransport.GetEventData));
    KeepAlive(FTransport.Transport.GetSocketHandle);
  end else
  begin
    FTransIntf := CreateTransport;
    FTransIntf.SetConnected(True);
    KeepAlive(FTransIntf.GetSocketHandle);
  end;

end;


function TZClient.Send(const Data: IDataBlock;
  WaitForResult: Boolean): IDataBlock;
var
  Msg: TMsg;
  Context: Integer;
  P:Pointer;
begin
  if FSupportCallbacks then
  begin
    if not Assigned(FTransport) then Exit;
    if (FTransport.Transport=nil)
       or
       not FTransport.Transport.Connected then
    begin
       Raise Exception.Create('网络连接已经断开无法继续，请确认网络正常后重试此操作...'); 
    end;
    FTransport.ResetThreadEvent;
    FTransport.hEventMsg := 0;
    FTransport.hEventData := nil;
    Data._AddRef;
    PostThreadMessage(FTransport.ThreadID, THREAD_SENDSTREAM, Ord(WaitForResult),
      Integer(Pointer(Data)));
    if (Data.Signature and ResultSig) = ResultSig then exit;
    if WaitForResult then
      begin
        while True do
          begin
           WaitForSingleObject(FTransport.hEvent, INFINITE);
           FTransport.ResetThreadEvent;
           case FTransport.hEventMsg of
             THREAD_RECEIVEDSTREAM:begin
                Result := IDataBlock(FTransport.GetEventData);
                if (Result.Signature and ResultSig) = ResultSig then
                  begin
                    Result._Release;
                    Break;
                  end
                else
                  PostMessage(Handle, THREAD_RECEIVEDSTREAM, 0, Integer(Pointer(Result)));
              end
             else
              begin
                P := FTransport.GetEventData;
                if (FTransport.hEventMsg=THREAD_EXCEPTION) and (P<>nil) then
                   DoError(Exception(P))
                else
                   raise Exception.CreateRes(@SReturnError);
              end;
           end;
         end;
      end
    else
      begin
        while True do
          begin
            WaitForSingleObject(FTransport.hEvent, INFINITE);
            FTransport.ResetThreadEvent;
            case FTransport.hEventMsg of
               THREAD_RECEIVEDSTREAM:begin
                  Result := IDataBlock(FTransport.GetEventData);
                  if (Result.Signature and ResultSig) = ResultSig then
                     begin
                       Result._Release;
                       Break;
                     end
                  else
                    PostMessage(Handle, THREAD_RECEIVEDSTREAM, 0, Integer(Pointer(Result)));
                  end;
               THREAD_SENDNOTIFY:
                  begin
                      FTransport.GetEventData;
                      Break;
                  end;
               else
                  begin
                    P := FTransport.GetEventData;
                    if (FTransport.hEventMsg=THREAD_EXCEPTION) and (P<>nil) then
                       DoError(Exception(P))
                    else
                       raise Exception.CreateRes(@SReturnError);
                  end;
            end;
          end;
      end;
  end else
  begin
    if not Assigned(FTransIntf) then Raise Exception.CreateRes(@SIdInvalidSocketConnection);
    Context := FTransIntf.Send(Data);
    Result := FTransIntf.Receive(WaitForResult, Context);
  end;
  if Result=nil then Exception.CreateRes(@SReturnError);
  if Assigned(Result) and ((Result.Signature and asMask) = asError) then
    Interpreter.InterpretData(Result);
end;

procedure TZClient.SetEnabledBanlace(const Value: Boolean);
begin
  FEnabledBanlace := Value;
end;

procedure TZClient.SetSupportCallbacks(const Value: Boolean);
begin
  FSupportCallbacks := Value;
end;

procedure TZClient.ThreadException(var Message: TMessage);
begin
  if FTransport=nil then Exit;
  DoError(Exception(Message.lParam));
end;

procedure TZClient.ThreadReceivedStream(var Message: TMessage);
var
  Data: IDataBlock;
begin
  if FTransport=nil then Exit;
  Data := IDataBlock(Message.lParam);
  if InWorking then
     PostMessage(Handle, THREAD_RECEIVEDSTREAM, 0, Integer(Pointer(Data)))
  else
  begin
    Data._Release;
    if ((Data.Signature and ResultSig) <> ResultSig) then
       begin
         Interpreter.InterpretData(Data);
       end;
  end;
end;

procedure TZClient.TransportTerminated(Sender: TObject);
begin
  FTransport := nil;
end;

procedure TZClient.WndProc(var Message: TMessage);
begin
  try
    Dispatch(Message);
  except
    if Assigned(ApplicationHandleException) then
       ApplicationHandleException(Self);
  end;
end;


procedure TZClient.Enter;
begin
  InterlockedIncrement(FInWorking);
  EnterCriticalSection(FThreadLock);
end;

procedure TZClient.Leave;
begin
  LeaveCriticalSection(FThreadLock);
  InterlockedDecrement(FInWorking);
end;

procedure TZClient.ThreadSendNotify(var Message: TMessage);
begin
  FTransport.SetReadEvent;
end;

function TZClient.GetInWorking: Boolean;
begin
  Result := (FInWorkIng>0);
end;

function TZClient.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
var
  Factory:TZFactory;
begin
  Factory := TZFactory.Create(DataSet);
  FList.Add(Factory);
  Factory.ZClassName := AClassName;
  Factory.DataSet := DataSet;
  if Assigned(Params) then  Factory.Params.Assign(Params);
end;

function TZClient.BeginBatch: Boolean;
begin
  if FList.Count > 0 then Raise Exception.Create('正在组织数据包，无法开始新的数据包。');
end;

procedure TZClient.BeginTrans(TimeOut: integer);
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  R:LongWord;
begin
  CheckSocketConnected;

  DispParams.cArgs := 1;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;
  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varInteger;
    TVarData(DispParams.rgvarg[0]).VInteger := TimeOut;
    R := FInterpreter.CallInvoke(Ord(SKTBeginTrans),0,0,DispParams,nil, @ExcepInfo,nil);
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);
    LocalInTransaction := true;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

function TZClient.CancelBatch: Boolean;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Clear;
end;

function TZClient.CommitBatch: Boolean;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  V:OleVariant;
  R:LongWord;
  i:integer;
begin
  Result := false;
  if FList.Count = 0 then Raise Exception.Create('没有组合数据包..');
  CheckSocketConnected;
  
  //数据打包说明
  //1:组合个数
  //2:组合对象 * 个数
  //3:组合参数 * 个数
  DispParams.cArgs := FList.Count*2+1;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varInteger;
    TVarData(DispParams.rgvarg[0]).VInteger := FList.Count;
    
    //传入对象名
    for i:=1 to FList.Count do
    begin
      with TZFactory(FList[i-1]) do
        begin
          DispParams.rgvarg[i].vt := varString;
          TVarData(DispParams.rgvarg[i]).VString := PChar(ZClassName);
        end;
    end;
    //传入参数值
    for i:=1 to FList.Count do
    begin
      with TZFactory(FList[i-1]) do
        begin
          DispParams.rgvarg[i+FList.Count].vt := varOleStr;
          if Params.Count=0 then
             ZParamWStr := TftParamList.Encode(TZQuery(DataSet).Params)
          else
             ZParamWStr := TftParamList.Encode(Params);
          TVarData(DispParams.rgvarg[i+FList.Count]).VOleStr := PWideChar(ZParamWStr);
        end;
    end;
    
    //把数据集记录打包成数值
    V:=VarArrayCreate([0,FList.Count-1],varVariant);
    for i:=0 to FList.Count -1 do
        V[i] := TZQuery(TZFactory(FList[i]).DataSet).Delta;

    R := FInterpreter.CallInvoke(Ord(SKTUpdateBatchCombination),0,0,DispParams,@V, @ExcepInfo,nil);
    
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);

    for i:=0 to FList.Count -1 do
       TZQuery(TZFactory(FList[i]).DataSet).CommitUpdates;
    CancelBatch;
    Result := true;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

procedure TZClient.CommitTrans;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  R:LongWord;
begin
  CheckSocketConnected;

  DispParams.cArgs := 0;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  R := FInterpreter.CallInvoke(Ord(SKTCommitTrans),0,0,DispParams,nil, @ExcepInfo,nil);
  if R = DISP_E_EXCEPTION then
     Raise Exception.Create(ExcepInfo.bstrDescription);
  LocalInTransaction := false;
end;

function TZClient.ExecProc(AClassName: String;
  Params: TftParamList): String;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  ZClassName,ParamStr :WideString;
  V:OleVariant;
  R:LongWord;
begin
  Result := '';
  CheckSocketConnected;

  DispParams.cArgs := 2;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varOleStr;
    ZClassName := AClassName;
    TVarData(DispParams.rgvarg[0]).VOleStr := PWideChar(ZClassName);
    DispParams.rgvarg[1].vt := varOleStr;
    if Params<>nil then
    ParamStr := TftParamList.Encode(Params)
    else
    ParamStr := '';
    TVarData(DispParams.rgvarg[1]).VOleStr := PWideChar(ParamStr);
    V := null;
    R := FInterpreter.CallInvoke(Ord(SKTExecProc),0,0,DispParams,@V, @ExcepInfo,nil);

    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);
    result := V;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

function TZClient.ExecSQL(const SQL: WideString;
  ObjectFactory: TObject): Integer;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  VarList: PVariantArray;
  R:LongWord;
begin
  Result := 0;
  if ObjectFactory<>nil then Raise Exception.Create('客户端不支持ObjectFactory对象.');
  CheckSocketConnected;

  DispParams.cArgs := 2;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  GetMem(VarList, DispParams.cArgs * SizeOf(OleVariant));
  System.Initialize(VarList^, DispParams.cArgs);
  try
    DispParams.rgvarg[0].vt := varByRef or varVariant;
    VarList[0] := 0;
    TVarData(DispParams.rgvarg[0]).VPointer := @VarList[0];

    TVarData(DispParams.rgvarg[1]).vType := varOleStr;
    TVarData(DispParams.rgvarg[1]).VOleStr := PWideChar(SQL);

    R := FInterpreter.CallInvoke(Ord(SKTExecSQL),0,0,DispParams,nil, @ExcepInfo,nil);
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);
    Result := OleVariant(VarList[0]);
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
end;

function TZClient.GetConnectionString: WideString;
begin
  result := 'hostname='+host+';port='+inttostr(port)+';dbid='+inttostr(dbid);
end;

function TZClient.iDbType: Integer;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  VarList: PVariantArray;
  R:LongWord;
begin
  result := LocaliDbType;
  if LocaliDbType>=0 then Exit;

  CheckSocketConnected;

  DispParams.cArgs := 1;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  GetMem(VarList, DispParams.cArgs * SizeOf(OleVariant));
  System.Initialize(VarList^, DispParams.cArgs);
  try
    DispParams.rgvarg[0].vt := varByRef or varVariant;
    VarList[0] := 0;
    TVarData(DispParams.rgvarg[0]).VPointer := @VarList[0];

    R := FInterpreter.CallInvoke(Ord(SKTGetiDbType),0,0,DispParams,nil, @ExcepInfo,nil);
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);
    LocaliDbType := OleVariant(VarList[0]);
    Result := LocaliDbType;
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
end;

function TZClient.Initialize(const ConnStr: WideString): boolean;
var
  vList:TStringList;
begin
  Disconnect;
  vList := TStringList.Create;
  try
    vList.Delimiter := ';';
    vList.DelimitedText := lowercase(ConnStr);
    Host := vList.Values['hostname'];
    Port := StrtoIntDef(vList.Values['port'],1024);
    dbid := StrtoIntDef(vList.Values['dbid'],1);
  finally
    vList.Free;
  end;
end;

function TZClient.InTransaction: boolean;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  VarList: PVariantArray;
  R:LongWord;
begin
  CheckSocketConnected;

  DispParams.cArgs := 1;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  GetMem(VarList, DispParams.cArgs * SizeOf(OleVariant));
  System.Initialize(VarList^, DispParams.cArgs);
  try
    DispParams.rgvarg[0].vt := varByRef or varVariant;
    VarList[0] := False;
    TVarData(DispParams.rgvarg[0]).VPointer := @VarList[0];

    R := FInterpreter.CallInvoke(Ord(SKTInTransaction),0,0,DispParams,nil, @ExcepInfo,nil);
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);
    Result := OleVariant(VarList[0]);
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
end;

function TZClient.Open(DataSet: TDataSet): Boolean;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  CommandText,ParamsStr:WideString;
  V:OleVariant;
  R:LongWord;
begin
  Result := false;
  CheckSocketConnected;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       TZQuery(DataSet).CachedUpdates := true;
     end
  else
     Raise Exception.Create('不支持的数据集类型:'+DataSet.ClassName);

  DispParams.cArgs := 2;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varOleStr;
    CommandText := TZQuery(DataSet).SQL.Text;
    TVarData(DispParams.rgvarg[0]).VOleStr := PWideChar(CommandText);

    DispParams.rgvarg[1].vt := varOleStr;
    ParamsStr := TftParamList.Encode(TZQuery(DataSet).Params);
    TVarData(DispParams.rgvarg[1]).VOleStr := PWideChar(ParamsStr);

    R := FInterpreter.CallInvoke(Ord(SKTOpenCommandText),0,0,DispParams,@V, @ExcepInfo,nil);
    
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);


    TZQuery(DataSet).Data := V;
    Result := true;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

function TZClient.Open(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  ZClassName,ParamsStr:WideString;
  V:OleVariant;
  R:LongWord;
begin
  Result := false;
  CheckSocketConnected;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       TZQuery(DataSet).CachedUpdates := true;
     end
  else
     Raise Exception.Create('不支持的数据集类型:'+DataSet.ClassName);

  DispParams.cArgs := 2;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varOleStr;
    ZClassName := AClassName;
    TVarData(DispParams.rgvarg[0]).VOleStr := PWideChar(ZClassName);

    DispParams.rgvarg[1].vt := varOleStr;
    if Params=nil then
       ParamsStr := TftParamList.Encode(TZQuery(DataSet).Params)
    else
       ParamsStr := TftParamList.Encode(Params);
    TVarData(DispParams.rgvarg[1]).VOleStr := PWideChar(ParamsStr);
    
    R := FInterpreter.CallInvoke(Ord(SKTOpenClassName),0,0,DispParams,@V, @ExcepInfo,nil);
    
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);


    TZQuery(DataSet).Data := V;
    Result := true;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

function TZClient.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  result := Open(DataSet,AClassName,nil);
end;

function TZClient.OpenBatch: Boolean;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  V:OleVariant;
  R:LongWord;
  i:integer;
begin
  Result := false;
  if FList.Count = 0 then Raise Exception.Create('没有组合数据包..');
  CheckSocketConnected;

  //数据打包说明
  //1:组合个数
  //2:组合对象 * 个数
  //3:组合参数 * 个数
  DispParams.cArgs := FList.Count*2+1;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varInteger;
    TVarData(DispParams.rgvarg[0]).VInteger := FList.Count;
    //传入对象名
    for i:=1 to FList.Count do
    begin
      with TZFactory(FList[i-1]) do
        begin
          DispParams.rgvarg[i].vt := varString;
          TVarData(DispParams.rgvarg[i]).VString := PChar(ZClassName);
        end;
    end;
    //传入参数值
    for i:=1 to FList.Count do
    begin
      with TZFactory(FList[i-1]) do
        begin
          DispParams.rgvarg[i+FList.Count].vt := varOleStr;
          if Params.Count=0 then
             ZParamWStr := TftParamList.Encode(TZQuery(DataSet).Params)
          else
             ZParamWStr := TftParamList.Encode(Params);
          TVarData(DispParams.rgvarg[i+FList.Count]).VOleStr := PWideChar(ZParamWStr);
        end;
    end;
    
    //把数据集记录打包成数值
    V:=VarArrayCreate([0,FList.Count-1],varVariant);
    for i:=0 to FList.Count -1 do
        V[i] := null;

    R := FInterpreter.CallInvoke(Ord(SKTOpenCombination),0,0,DispParams,@V, @ExcepInfo,nil);
    
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);

    for i:=0 to FList.Count -1 do
       TZQuery(TZFactory(FList[i]).DataSet).Data := V[i];
    CancelBatch;
    Result := true;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

procedure TZClient.RollbackTrans;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  R:LongWord;
begin
  CheckSocketConnected;

  DispParams.cArgs := 0;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  R := FInterpreter.CallInvoke(Ord(SKTRollbackTrans),0,0,DispParams,nil, @ExcepInfo,nil);
  if R = DISP_E_EXCEPTION then
     Raise Exception.Create(ExcepInfo.bstrDescription);

  LocalInTransaction := false;
end;

function TZClient.UpdateBatch(DataSet: TDataSet): Boolean;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  CommandText,ParamsStr:WideString;
  V:OleVariant;
  R:LongWord;
begin

  Result := false;
  CheckSocketConnected;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       if not TZQuery(DataSet).Changed then Exit;
     end
  else
     Raise Exception.Create('不支持的数据集类型:'+DataSet.ClassName);

  DispParams.cArgs := 2;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varOleStr;
    CommandText := TZQuery(DataSet).SQL.Text;
    TVarData(DispParams.rgvarg[0]).VOleStr := PWideChar(CommandText);


    DispParams.rgvarg[1].vt := varOleStr;
    ParamsStr := TftParamList.Encode(TZQuery(DataSet).Params);
    TVarData(DispParams.rgvarg[1]).VOleStr := PWideChar(ParamsStr);

    V := TZQuery(DataSet).Delta;

    R := FInterpreter.CallInvoke(Ord(SKTUpdateBatchCommandText),0,0,DispParams,@V, @ExcepInfo,nil);

    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);

    TZQuery(DataSet).CommitUpdates;
    Result := result;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

function TZClient.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  result := UpdateBatch(DataSet,AClassName,nil);
end;

function TZClient.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  ZClassName,ParamsStr:WideString;
  V:OleVariant;
  R:LongWord;
begin

  Result := false;
  CheckSocketConnected;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       if not TZQuery(DataSet).Changed then Exit;
     end
  else
     Raise Exception.Create('不支持的数据集类型:'+DataSet.ClassName);

  DispParams.cArgs := 2;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varOleStr;
    ZClassName := AClassName;
    TVarData(DispParams.rgvarg[0]).VOleStr := PWideChar(ZClassName);


    DispParams.rgvarg[1].vt := varOleStr;
    if Params=nil then
       ParamsStr := TftParamList.Encode(TZQuery(DataSet).Params)
    else
       ParamsStr := TftParamList.Encode(Params);
    TVarData(DispParams.rgvarg[1]).VOleStr := PWideChar(ParamsStr);

    V := TZQuery(DataSet).Delta;

    R := FInterpreter.CallInvoke(Ord(SKTUpdateBatchClassName),0,0,DispParams,@V, @ExcepInfo,nil);

    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);

    TZQuery(DataSet).CommitUpdates;
    Result := true;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

procedure TZClient.KeepAlive(Socket:integer);
var
  inKeepAlive,OutKeepAlive:TTCP_KEEPALIVE;
  opt ,insize,outsize: Integer;
begin
  Exit;
  //加入心跳代码
  opt:=1;
  if setsockopt(Socket,SOL_SOCKET,SO_KEEPALIVE,@opt,sizeof(opt))=SOCKET_ERROR then
  begin
    Exit;
  end;
  inKeepAlive.onoff:=1;
  //设置３秒钟时间间隔

  inKeepAlive.keepalivetime:=10000;
  //设置每３秒中发送１次的心跳
  inKeepAlive.keepaliveinterval:=3;
  insize:=sizeof(TTCP_KEEPALIVE);
  outsize:=sizeof(TTCP_KEEPALIVE);
  if WSAIoctl(Socket,SIO_KEEPALIVE_VALS,@inKeepAlive,insize,@outKeepAlive,outsize,@opt,nil,nil)=SOCKET_ERROR then
  begin
  end; 
end;

procedure TZClient.CheckSocketConnected;
begin
  if not Connected then
    begin
       Connect;
       DoSKTParameter;
       if crUserId<>'' then GqqLogin(crUserId,crUserName);
    end;
end;

procedure TZClient.GqqLogin(UserId, UserName: string);
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  UID,UNM:widestring;
  R:LongWord;
begin
  CheckSocketConnected;

  DispParams.cArgs := 2;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;
  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varOleStr;
    UID := UserId;
    TVarData(DispParams.rgvarg[0]).VOleStr := PWideChar(UID);

    DispParams.rgvarg[1].vt := varOleStr;
    UNM := UserName;
    TVarData(DispParams.rgvarg[1]).VOleStr := PWideChar(UNM);

    R := FInterpreter.CallInvoke(Ord(SKTLogin),0,0,DispParams,nil, @ExcepInfo,nil);
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);
    crUserId := UserId;
    crUserName := UserName;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

procedure TZClient.DoSKTParameter;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  R:LongWord;
begin
  CheckSocketConnected;
  DispParams.cArgs := 1;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;

  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varInteger;
    TVarData(DispParams.rgvarg[0]).VInteger := dbid;

    try
       R := FInterpreter.CallInvoke(Ord(SKTParameter),0,0,DispParams,nil, @ExcepInfo,nil);

       if R = DISP_E_EXCEPTION then
          Raise Exception.Create(ExcepInfo.bstrDescription);
    except
      DisConnect;
      Raise;
    end;
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

procedure TZClient.DBLock(Locked: boolean);
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  R:LongWord;
begin
  CheckSocketConnected;

  DispParams.cArgs := 1;
  DispParams.rgdispidNamedArgs := nil;
  DispParams.cNamedArgs := 0;
  DispParams.rgvarg := nil;
  GetMem(DispParams.rgvarg, DispParams.cArgs * SizeOf(TVariantArg));
  try
    DispParams.rgvarg[0].vt := varBoolean;
    TVarData(DispParams.rgvarg[0]).VBoolean := Locked;

    R := FInterpreter.CallInvoke(Ord(SKTDBLock),0,0,DispParams,nil, @ExcepInfo,nil);
    if R = DISP_E_EXCEPTION then
       Raise Exception.Create(ExcepInfo.bstrDescription);
  finally
    if DispParams.rgdispidNamedArgs <> nil then
      FreeMem(DispParams.rgdispidNamedArgs);
    if DispParams.rgvarg <> nil then
      FreeMem(DispParams.rgvarg);
  end;
end;

{ TDoInvokeClientDispatch }

function TDoInvokeClientDispatch.DoInvoke(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := 0;
end;

end.
