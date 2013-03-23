unit ZServer;

interface
uses
  VarUtils, Variants, Windows, Messages, Classes, SysUtils,
  ScktComp, WinSock, WinInet, ComObj,zPacket,ZConst,ZIntf,ActiveX,
  ZDataSet,ZdbHelp, ZBase, IniFiles;
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
    Fdbid: integer;
    FdbResolver: TdbResolver;
    procedure SetActivity(const Value: Boolean);
    procedure SetHost(const Value: string);
    procedure SetIPAddress(const Value: WideString);
    procedure SetPort(const Value: string);
    procedure SetUserCode(const Value: WideString);
    procedure SetUserName(const Value: WideString);
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
    property dbid:integer read Fdbid write Setdbid;
    property dbResolver:TdbResolver read FdbResolver write SetdbResolver;
  end;

  TDoInvokeDispatch = class(TInterfacedObject, IDoInvokeDispatch)
  private
    FInterpreter:TZCustomDataBlockInterpreter;
    FSession: TZSession;
    FSessionId:Integer;
    FdbLock: boolean;
    procedure SetSession(const Value: TZSession);
    procedure SetdbLock(const Value: boolean);
  protected
    function CheckIdTransact:boolean;
    procedure PushCache;

    function  DoSKTOpenCommandText(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTOpenClassName(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTOpenCombination(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTUpdateBatchCommandText(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTUpdateBatchClassName(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTUpdateBatchCombination(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;

    function  DoSKTBeginTrans(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTCommitTrans(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTRollbackTrans(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTInTransaction(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;

    function  DoSKTGetiDbType(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTExecSQL(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
    function  DoSKTExecProc(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;

    function  DoSKTParameter(Token,LocaleID: Integer;
      Flags: Word;var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;stdcall;
    function  DoSKTLogin(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;stdcall;

    function  DoSKTDBLock(Token,LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;stdcall;
  public
    constructor Create(ASessionId:integer;AInterpreter:TZCustomDataBlockInterpreter);
    destructor Destroy; override;


    //接收客户端发来的数据
    function DoInvoke(Token,LocaleID: Integer;
      Flags: Word;var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;stdcall;
    property Session:TZSession read FSession write SetSession;
    property SessionId:Integer read FSessionId write FSessionId;

    property dbLock:boolean read FdbLock write SetdbLock;
  end;

  TZSessions=class
  private
    FList:TList;
    FThreadLock:TRTLCriticalSection;
    FMaxSessionCount: integer;
    function GetCount: Integer;
    function GetSessions(ItemIndex: Integer): TZSession;

    procedure Enter;
    procedure Leave;
    procedure SetMaxSessionCount(const Value: integer);

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
    property MaxSessionCount:integer read FMaxSessionCount write SetMaxSessionCount;
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
    FDBCacheLockCount: integer;
    FTimerOut: integer;
    procedure SetMaxCache(const Value: integer);
    procedure SetDBCacheLockCount(const Value: integer);
    function GetCount: integer;
    procedure SetTimerOut(const Value: integer);
  protected
    F:TIniFile;
    procedure Enter;
    procedure Leave;

    function CreatedbResolver(dbid:Integer):TdbResolver;
    procedure FreeCache(i:integer);
    procedure CheckConnected(Conn:TdbResolver);
    procedure Clear;
  public

    constructor Create;
    destructor Destroy; override;
    //线程安全方法
    function  Get(dbid:Integer):TdbResolver;
    procedure Push(Conn:TdbResolver);
    //最大保留缓冲数
    property MaxCache:integer read FMaxCache write SetMaxCache;
    property DBCacheLockCount:integer read FDBCacheLockCount write SetDBCacheLockCount;
    property Count:integer read GetCount;
    property TimerOut:integer read FTimerOut write SetTimerOut;
  end;

var
  //Sessions 队例
  Sessions:TZSessions;
  ConnCache:TZConnCache;

  DataBlockCount:int64;
  WaitDataBlockCount:int64;
  DataBlockMaxWaitTime:int64;
  MaxSyncRequestCount:integer;
implementation
uses EncDec;

{ TDoInvokeDispatch }
function TDoInvokeDispatch.CheckIdTransact: boolean;
begin
  if not Assigned(Session) then Raise Exception.Create('dbid连接参数没有设置，无法找到对应的Session');
  if not assigned(Session.dbResolver) and (Session.dbid>0) then
     begin
       Session.dbResolver := ConnCache.Get(Session.dbid);
     end;
  result := true;
end;

constructor TDoInvokeDispatch.Create(ASessionId:integer;AInterpreter:TZCustomDataBlockInterpreter);
begin
  FInterpreter:=AInterpreter;
  inherited Create;
  Session := nil;
  FSessionId := ASessionId;
  dbLock := false;
end;

destructor TDoInvokeDispatch.Destroy;
begin
  if Assigned(Session) and Assigned(Session.dbResolver) then
     ConnCache.Push(Session.dbResolver);
  inherited;
end;

function TDoInvokeDispatch.DoInvoke(Token, LocaleID: Integer; Flags: Word;
  var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  case TZToken(Token) of
    SKTOpenCommandText:Result := DoSKTOpenCommandText(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTOpenClassName:Result := DoSKTOpenClassName(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTOpenCombination:Result := DoSKTOpenCombination(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTUpdateBatchCommandText:Result := DoSKTUpdateBatchCommandText(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTUpdateBatchClassName:Result := DoSKTUpdateBatchClassName(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTUpdateBatchCombination:Result := DoSKTUpdateBatchCombination(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTBeginTrans:Result := DoSKTBeginTrans(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTCommitTrans:Result := DoSKTCommitTrans(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTRollbackTrans:Result := DoSKTRollbackTrans(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTGetiDbType:Result := DoSKTGetiDbType(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTInTransaction:Result := DoSKTInTransaction(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTExecSQL:Result := DoSKTExecSQL(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTExecProc:Result := DoSKTExecProc(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTParameter:Result := DoSKTParameter(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTLogin:Result := DoSKTLogin(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
    SKTDBLock:Result := DoSKTDBLock(Token,LocaleID,Flags,Params,VarResult,ExcepInfo,ArgErr);
  else
    raise EInvokeDispatchError.CreateResFmt(@SIdInvalidToken, [Token]);
  end; 
end;

function TDoInvokeDispatch.DoSKTBeginTrans(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var TimeOut:Integer;
begin
  TimeOut := OleVariant(PDispParams(@Params).rgvarg^[0]);
  if CheckIdTransact then
     begin
       try
         Session.dbResolver.BeginTrans(TimeOut);
       finally
         PushCache;
       end;
     end;
end;

function TDoInvokeDispatch.DoSKTCommitTrans(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if CheckIdTransact then
     begin
       try
         Session.dbResolver.CommitTrans;
       finally
         PushCache;
       end;
     end;
end;

function TDoInvokeDispatch.DoSKTDBLock(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if CheckIdTransact then
     begin
       try
         DBLock := OleVariant(PDispParams(@Params).rgvarg^[0]);
         Session.dbResolver.DBLock(dbLock);
       finally
         PushCache;
       end;
     end;
end;

function TDoInvokeDispatch.DoSKTExecProc(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  ZClassName,ParamsStr:WideString;
  DataSet:TZQuery;
  V:OleVariant;
  ftParams:TftParamList;
begin
  try
  ZClassName := OleVariant(PDispParams(@Params).rgvarg^[0]);
  ParamsStr := OleVariant(PDispParams(@Params).rgvarg^[1]);

  if CheckIdTransact then
     begin
       try
          DataSet := TZQuery.Create(nil);
          ftParams := TftParamList.Create(nil);
          try
            TftParamList.Decode(ftParams,ParamsStr);
            if ftParams.Count =0 then
               V := Session.dbResolver.ExecProc(ZClassName,nil)
            else
               V := Session.dbResolver.ExecProc(ZClassName,ftParams);
            PVariant(VarResult)^ := V;
          finally
            ftParams.Free;
            DataSet.Free;
          end;
       finally
         PushCache;
       end;
     end;
  except
     on E:Exception do
        Raise EInvokeDispatchError.CreateDispatchError(E.Message,ZClassName);
  end;
end;

function TDoInvokeDispatch.DoSKTExecSQL(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  CommandText:Widestring;
  ParamPtr: PVarData;
  r:integer;
  ftParams:TftParamList;
begin
  try
  CommandText := OleVariant(PDispParams(@Params).rgvarg^[1]);
  if CheckIdTransact then
     begin
       try
         r := Session.dbResolver.ExecSQL(CommandText);
         ParamPtr := TVarData(PDispParams(@Params).rgvarg^[PDispParams(@Params).cArgs]).VPointer;

         ParamPtr^.VType := varInteger;
         ParamPtr^.VInteger := r;
         TVarData(PDispParams(@Params).rgvarg^[0]).VType := varVariant or varByRef;
         TVarData(PDispParams(@Params).rgvarg^[0]).VPointer := ParamPtr;
       finally
         PushCache;
       end;
     end;
  except
     on E:Exception do
        Raise EInvokeDispatchError.CreateDispatchError(E.Message,CommandText);
  end;
end;

function TDoInvokeDispatch.DoSKTGetiDbType(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  ParamPtr: PVarData;
  iDbType:Integer;
begin
  if CheckIdTransact then
     begin
       try
         iDbType := Session.dbResolver.iDbType;
         ParamPtr := TVarData(PDispParams(@Params).rgvarg^[PDispParams(@Params).cArgs]).VPointer;

         ParamPtr^.VType := varInteger;
         ParamPtr^.VInteger := iDbType;
         TVarData(PDispParams(@Params).rgvarg^[0]).VType := varVariant or varByRef;
         TVarData(PDispParams(@Params).rgvarg^[0]).VPointer := ParamPtr;
       finally
         PushCache;
       end;
     end;
end;

function TDoInvokeDispatch.DoSKTInTransaction(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  ParamPtr: PVarData;
  InTransaction:boolean;
begin
  if CheckIdTransact then
     begin
       try
         InTransaction := Session.dbResolver.InTransaction;
         ParamPtr := TVarData(PDispParams(@Params).rgvarg^[PDispParams(@Params).cArgs]).VPointer;

         ParamPtr^.VType := varBoolean;
         ParamPtr^.VBoolean := InTransaction;
         TVarData(PDispParams(@Params).rgvarg^[0]).VType := varVariant or varByRef;
         TVarData(PDispParams(@Params).rgvarg^[0]).VPointer := ParamPtr;
       finally
         PushCache;
       end;
     end;
end;

function TDoInvokeDispatch.DoSKTLogin(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if CheckIdTransact then
     begin
       try
         Session.UserCode := OleVariant(PDispParams(@Params).rgvarg^[0]);;
         Session.UserName := OleVariant(PDispParams(@Params).rgvarg^[1]);;
         SendMessage(MainFormHandle,WM_SESSION_UPDATE,integer(Session),3);
       finally
         PushCache;
       end;
     end;
end;

function TDoInvokeDispatch.DoSKTOpenClassName(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  ZClassName,ParamsStr:WideString;
  DataSet:TZQuery;
  V:OleVariant;
  ftParams:TftParamList;
begin
  try
  ZClassName := OleVariant(PDispParams(@Params).rgvarg^[0]);
  ParamsStr := OleVariant(PDispParams(@Params).rgvarg^[1]);

  if CheckIdTransact then
     begin
       try
          DataSet := TZQuery.Create(nil);
          ftParams := TftParamList.Create(nil);
          try
            TftParamList.Decode(ftParams,ParamsStr);
            if ftParams.Count =0 then
               Session.dbResolver.Open(DataSet,ZClassName,nil)
            else
               Session.dbResolver.Open(DataSet,ZClassName,ftParams);
            V := DataSet.Data;
            PVariant(VarResult)^ := V;
          finally
            ftParams.Free;
            DataSet.Free;
          end;
       finally
         PushCache;
       end;
     end;
  except
     on E:Exception do
        Raise EInvokeDispatchError.CreateDispatchError(E.Message,ZClassName);
  end;
end;

function TDoInvokeDispatch.DoSKTOpenCombination(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  ZClassName,ParamsStr:WideString;
  n,i:integer;
  FList:TList;
  FParams:TList;
  V:OleVariant;
  DataSet:TZQuery;
  ftParams:TftParamList;
begin
  try
  n := OleVariant(PDispParams(@Params).rgvarg^[0]);

  if CheckIdTransact then
     begin
       FList := TList.Create;
       FParams := TList.Create;
       try
          Session.dbResolver.BeginBatch;
          try
            for i:= 1 to n do
            begin
              ZClassName := OleVariant(PDispParams(@Params).rgvarg^[i]);
              ParamsStr := OleVariant(PDispParams(@Params).rgvarg^[i+n]);
              
              DataSet := TZQuery.Create(nil);
              FList.Add(DataSet);

              ftParams := TftParamList.Create(nil);
              FParams.Add(ftParams);
              TftParamList.Decode(ftParams,ParamsStr); 
              if ftParams.Count =0 then
                 Session.dbResolver.AddBatch(DataSet,ZClassName,nil)
              else
                 Session.dbResolver.AddBatch(DataSet,ZClassName,ftParams);
            end;
            Session.dbResolver.OpenBatch;
            
            //把数据集记录打包成数值
            V:=VarArrayCreate([0,n-1],varVariant);
            for i:=0 to n -1 do
                V[i] := TZQuery(FList[i]).Data;

            PVariant(VarResult)^ := V;
          except
            Session.dbResolver.CancelBatch;
            Raise;
          end;
       finally
         PushCache;
         for i:=0 to FList.Count-1 do TObject(FList[i]).Free;
         FList.Free;
         for i:=0 to FParams.Count-1 do TObject(FParams[i]).Free;
         FParams.Free;
       end;
     end;
  except
     on E:Exception do
        Raise EInvokeDispatchError.CreateDispatchError(E.Message,ZClassName);
  end;
end;

function TDoInvokeDispatch.DoSKTOpenCommandText(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
var
  CommandText,ParamsStr:Widestring;
  DataSet:TZQuery;
  ftParams:TftParamList;
  V:OleVariant;
begin
  try
  CommandText := OleVariant(PDispParams(@Params).rgvarg^[0]);
  ParamsStr := OleVariant(PDispParams(@Params).rgvarg^[1]);
  if CheckIdTransact then
     begin
       try
          DataSet := TZQuery.Create(nil);
          ftParams := TftParamList.Create(nil);
          try
            DataSet.SQL.Text := CommandText;
            TftParamList.Decode(ftParams,ParamsStr);
            DataSet.Params.AssignValues(ftParams);
            Session.dbResolver.Open(DataSet);
            V := DataSet.Data;
            PVariant(VarResult)^ := V;
          finally
            ftParams.Free;
            DataSet.Free;
          end;
       finally
         PushCache;
       end;
     end;
  except
     on E:Exception do
        Raise EInvokeDispatchError.CreateDispatchError(E.Message,CommandText);
  end;
end;

function TDoInvokeDispatch.DoSKTParameter(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if not assigned(Session) then Session := Sessions.Find(SessionId);
  if Session=nil then Raise Exception.Create(inttostr(SessionId)+'是无效的SessionID号');
  Session.dbid := OleVariant(PDispParams(@Params).rgvarg^[0]);
  //测试数据库连接
  CheckIdTransact;
  PushCache;
end;

function TDoInvokeDispatch.DoSKTRollbackTrans(Token, LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if CheckIdTransact then
     begin
       try
         Session.dbResolver.RollbackTrans;
       finally
         PushCache;
       end;
     end;
end;

function TDoInvokeDispatch.DoSKTUpdateBatchClassName(Token,
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  ZClassName,ParamsStr:Widestring;
  DataSet:TZQuery;
  ftParams:TftParamList;
begin
  try
  ZClassName := OleVariant(PDispParams(@Params).rgvarg^[0]);
  ParamsStr := OleVariant(PDispParams(@Params).rgvarg^[1]);

  if CheckIdTransact then
     begin
       try
          DataSet := TZQuery.Create(nil);
          ftParams := TftParamList.Create(nil);
          try
            TftParamList.Decode(ftParams,ParamsStr);
            DataSet.Params.AssignValues(ftParams);

            DataSet.Data := PVariant(VarResult)^;
            if ftParams.Count = 0 then
               Session.dbResolver.UpdateBatch(DataSet,ZClassName,nil)
            else
               Session.dbResolver.UpdateBatch(DataSet,ZClassName,ftParams);
            PVariant(VarResult)^ := null;
          finally
            ftParams.Free;
            DataSet.Free;
          end;
       finally
         PushCache;
       end;
     end;
  except
     on E:Exception do
        Raise EInvokeDispatchError.CreateDispatchError(E.Message,ZClassName);
  end;
end;

function TDoInvokeDispatch.DoSKTUpdateBatchCombination(Token,
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  ZClassName,ParamsStr:WideString;
  n,i:integer;
  FList:TList;
  FParams:TList;
  V:OleVariant;
  DataSet:TZQuery;
  ftParams:TftParamList;
begin
  try
  n := OleVariant(PDispParams(@Params).rgvarg^[0]);
  V := PVariant(VarResult)^;

  if CheckIdTransact then
     begin
       FList := TList.Create;
       FParams := TList.Create;
       try
          Session.dbResolver.BeginBatch;
          try
            for i:= 1 to n do
            begin
              ZClassName := OleVariant(PDispParams(@Params).rgvarg^[i]);
              ParamsStr := OleVariant(PDispParams(@Params).rgvarg^[i+n]);
              
              DataSet := TZQuery.Create(nil);
              FList.Add(DataSet);
              DataSet.Delta := V[i-1];
              ftParams := TftParamList.Create(nil);
              FParams.Add(ftParams);
              TftParamList.Decode(ftParams,ParamsStr); 
              if ftParams.Count =0 then
                 Session.dbResolver.AddBatch(DataSet,ZClassName,nil)
              else
                 Session.dbResolver.AddBatch(DataSet,ZClassName,ftParams);
            end;
            Session.dbResolver.CommitBatch;
            
            //把数据集记录打包成数值
            for i:=0 to n -1 do V[i] := null;

            PVariant(VarResult)^ := V;
          except
            Session.dbResolver.CancelBatch;
            Raise;
          end;
       finally
         PushCache;
         for i:=0 to FList.Count-1 do TObject(FList[i]).Free;
         FList.Free;
         for i:=0 to FParams.Count-1 do TObject(FParams[i]).Free;
         FParams.Free;
       end;
     end;
  except
     on E:Exception do
        Raise EInvokeDispatchError.CreateDispatchError(E.Message,ZClassName);
  end;
end;

function TDoInvokeDispatch.DoSKTUpdateBatchCommandText(Token,
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
var
  CommandText,ParamsStr:Widestring;
  DataSet:TZQuery;
  ftParams:TftParamList;
begin
  try
  CommandText := OleVariant(PDispParams(@Params).rgvarg^[0]);
  ParamsStr := OleVariant(PDispParams(@Params).rgvarg^[1]);

  if CheckIdTransact then
     begin
       try
          DataSet := TZQuery.Create(nil);
          ftParams := TftParamList.Create(nil);
          try
            DataSet.SQL.Text := CommandText;
            TftParamList.Decode(ftParams,ParamsStr);
            DataSet.Params.AssignValues(ftParams);

            DataSet.Data := PVariant(VarResult)^;
            Session.dbResolver.UpdateBatch(DataSet);
            PVariant(VarResult)^ := null;
          finally
            ftParams.Free;
            DataSet.Free;
          end;
       finally
         PushCache;
       end;
     end;
  except
     on E:Exception do
        Raise EInvokeDispatchError.CreateDispatchError(E.Message,CommandText);
  end;
end;

procedure TDoInvokeDispatch.PushCache;
begin
  if not Assigned(Session) then Raise Exception.Create('dbid连接参数没有设置，无法找到对应的Session');
  if not Assigned(Session.dbResolver) then Exit;
  if (not Session.dbResolver.InTransaction and not dbLock) or not Session.dbResolver.Connected then
     begin
       try
         ConnCache.Push(Session.dbResolver);
       finally
         Session.dbResolver := nil;
         dbLock := false;
       end;
     end;
end;

procedure TDoInvokeDispatch.SetdbLock(const Value: boolean);
begin
  FdbLock := Value;
end;

procedure TDoInvokeDispatch.SetSession(const Value: TZSession);
begin
  FSession := Value;
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
    if MainFormHandle>0 then SendMessage(MainFormHandle,WM_SESSION_UPDATE,Integer(Session),0);
    if FList.Count > MaxSessionCount then MaxSessionCount := FList.Count;
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
  if MainFormHandle>0 then PostMessage(MainFormHandle,WM_SESSION_UPDATE,0,2);
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
  if MainFormHandle>0 then PostMessage(MainFormHandle,WM_SESSION_UPDATE,Integer(Session),1);
end;

procedure TZSessions.Delete(i: Integer);
begin
  Enter;
  try
    if MainFormHandle>0 then PostMessage(MainFormHandle,WM_SESSION_UPDATE,Integer(FList[i]),1);
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

procedure TZSessions.SetMaxSessionCount(const Value: integer);
begin
  FMaxSessionCount := Value;
end;

{ TZDataCache }

procedure TZDataCache.Add(SessionID:Integer;Data: IDataBlock);
var
  ZDataBlock:PZDataBlock;
begin
  Enter;
  try
    new(ZDataBlock);
    ZDataBlock^.Data := Data;
    ZDataBlock^.SessionId := SessionID;
    ZDataBlock^.TimeStamp := GetTickCount;
    FList.Add(ZDataBlock);
    inc(DataBlockCount);
    inc(WaitDataBlockCount);
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
    WaitDataBlockCount := 0;
  finally
    Leave;
  end;
end;

constructor TZDataCache.Create;
begin
  InitializeCriticalSection(FThreadLock);
  FList := TList.Create;
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
             dec(WaitDataBlockCount);
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
     for i:=FList.Count-1 downto 0 do
        begin
          FreeCache(i);
        end;
     FList.Free;
     WaitDataBlockCount := 0;
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
             dec(WaitDataBlockCount);
           end;
      end;
  finally
    Leave;
  end;
end;

function TZDataCache.GetFirst: PZDataBlock;
var wait:int64;
begin
  Enter;
  try
    result := nil;
    if FList.Count = 0 then Exit;
    result := PZDataBlock(FList[0]);
    FList.Delete(0);
    dec(WaitDataBlockCount);
    wait := GetTickCount-result^.TimeStamp;
    if wait>DataBlockMaxWaitTime then DataBlockMaxWaitTime := wait;
  finally
    Leave;
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
    if FList.Count < 1 then exit;
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
    if not Conn.Connected then
       begin
         Clear;
       end;
    if (FList.Count>=MaxCache) or not Conn.Connected then
       begin
         Conn.Free;
       end
    else
       begin
         FList.Add(Conn);
         if Conn.InTransaction then Conn.RollbackTrans;
         Conn.ThreadId := 0;
       end;
  finally
    InterlockedDecrement(FDBCacheLockCount);
    Leave;
  end;
  if MainFormHandle>0 then PostMessage(MainFormHandle,WM_DB_CACHE_UPDATE,0,0);
end;

constructor TZConnCache.Create;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  InitializeCriticalSection(FThreadLock);
  FList := TList.Create;
  MaxCache := 10;
  TimerOut := 30;
end;

destructor TZConnCache.Destroy;
var i:integer;
begin
  Enter;
  try
     Clear;
     FList.Free;
     inherited;
  finally
     Leave;
     DeleteCriticalSection(FThreadLock);
  end;
  F.Free;
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
    try
      for i:=FList.Count-1 downto 0 do
         begin
           if TdbResolver(FList[i]).dbid = dbid then
              begin
                result := TdbResolver(FList[i]);
                FList.Delete(i);
                break;
              end;
         end;
      if result=nil then
         result := CreatedbResolver(dbid)
      else
         CheckConnected(result);
      InterlockedIncrement(FDBCacheLockCount);
    except
      if result<>nil then FreeAndNil(result);
      Raise;
    end;
  finally
    Leave;
  end;
  if MainFormHandle>0 then PostMessage(MainFormHandle,WM_DB_CACHE_UPDATE,0,0);
end;

procedure TZConnCache.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

procedure TZConnCache.SetMaxCache(const Value: integer);
begin
  FMaxCache := Value;
end;

function TZConnCache.CreatedbResolver(dbid:Integer): TdbResolver;
begin
  result := TdbResolver.Create;
  try
    result.dbid := dbid;
    result.Initialize(DecStr(F.ReadString('db'+inttostr(dbid),'connstr',''),ENC_KEY));
    result.Connect;
  except
    result.Free;
    Raise;
  end;
end;

procedure TZConnCache.SetDBCacheLockCount(const Value: integer);
begin
  FDBCacheLockCount := Value;
end;

function TZConnCache.GetCount: integer;
begin
  result := FList.Count;
end;

procedure TZConnCache.CheckConnected(Conn: TdbResolver);
begin
  if not Conn.Connected then
     begin
       Conn.DisConnect;
       Conn.Initialize(DecStr(F.ReadString('db'+inttostr(Conn.dbid),'connstr',''),ENC_KEY));
       Conn.Connect;
     end;
end;

procedure TZConnCache.Clear;
var
  i:integer;
begin
  for i:=FList.Count -1 downto 0 do
    begin
      FreeCache(i);
    end;
end;

procedure TZConnCache.SetTimerOut(const Value: integer);
begin
  FTimerOut := Value;
end;

initialization
  Sessions := TZSessions.Create;
  ConnCache := TZConnCache.Create;
  DataBlockCount := 0;
  WaitDataBlockCount := 0;
  DataBlockMaxWaitTime := 0;
finalization
  FreeAndNil(Sessions);
  FreeAndNil(ConnCache);
end.
