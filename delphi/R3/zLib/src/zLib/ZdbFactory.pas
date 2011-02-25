//***********************************************************//
//        设计:张森荣     编码：张森荣
//        版本:5.0        修改日期:2011-01-10
//        R3项目组
//***********************************************************//
unit ZdbFactory;

interface
uses SysUtils,Classes,Windows,DB,ZIntf,ZdbHelp,ZBase,ZAbstractDataset,ZClient;
type
  TdbFactory = class(TComponent)
  private
    FThreadLock:TRTLCriticalSection;
    dbResolver:TCustomdbResolver;
    FConnMode: integer;
    FConnStr: string;
    procedure SetConnMode(const Value: integer);
    procedure SetConnStr(const Value: string);
  protected
    procedure Enter;
    procedure Leave;
  public
    constructor Create;
    destructor  Destroy;override;

    //设置连接参数 connmode=1 本地连接 2 Rsp服务连接
    function  Initialize(Const ConnStr:WideString):boolean;stdcall;
    //读取连接串
    function  GetConnectionString:WideString;stdcall;
    //连接数据库
    function  Connect:boolean;stdcall;
    //检测通讯连接状态
    function  Connected:boolean;stdcall;
    //关闭数据库
    function  DisConnect:boolean;stdcall;

    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);stdcall;
    //提交事务
    procedure CommitTrans;stdcall;
    //回滚事务
    procedure RollbackTrans;stdcall;
    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;stdcall;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;stdcall;

    //数据包组织
    function BeginBatch:Boolean;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;
    function OpenBatch:Boolean;
    function CommitBatch:Boolean;
    function CancelBatch:Boolean;

    //查询数据;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload; stdcall;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload; stdcall;
    function Open(DataSet:TDataSet):Boolean;overload;stdcall;

    //提交数据
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload; stdcall;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload; stdcall;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;stdcall;

    //返回执行影响记录数
    function ExecSQL(const SQL:WideString;ObjectFactory:TZFactory=nil):Integer;stdcall;

    //执行远程方式，返回结果
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;stdcall;

    //连接模式 1 是本地连接  2 RSP通讯连接
    property ConnMode:integer read FConnMode write SetConnMode;
    //连接字符串
    property ConnString:string read FConnStr write SetConnStr;
  end;
implementation

{ TdbFactory }

procedure TdbFactory.BeginTrans(TimeOut: integer);
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    dbResolver.BeginTrans(TimeOut);
  finally
    Leave;
  end;
end;

procedure TdbFactory.CommitTrans;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    dbResolver.CommitTrans;
  finally
    Leave;
  end;
end;

function TdbFactory.Connect: boolean;
begin
  DisConnect;
  Enter;
  try
    case ConnMode of
    2:dbResolver := TZClient.Create;
    else
      dbResolver := TdbResolver.Create;
    end;
    dbResolver.Initialize(ConnString); 
    result := dbResolver.Connect;
  finally
    Leave;
  end;
end;

function TdbFactory.Connected: boolean;
begin
  result := assigned(dbResolver) and dbResolver.Connected;
end;

constructor TdbFactory.Create;
begin
  InitializeCriticalSection(FThreadLock);
  dbResolver := nil;
end;

destructor TdbFactory.Destroy;
begin
  DisConnect;
  Enter;
  try
    inherited;
  finally
     Leave;
     DeleteCriticalSection(FThreadLock);
  end;
end;

function TdbFactory.Open(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.Open(DataSet,AClassName,Params)
  finally
    Leave;
  end;
end;

function TdbFactory.DisConnect: boolean;
begin
  Enter;
  try
    if assigned(dbResolver) then freeandnil(dbResolver);
  finally
    Leave;
  end;
end;

function TdbFactory.ExecSQL(const SQL: WideString;
  ObjectFactory: TZFactory): Integer;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.ExecSQL(SQL,ObjectFactory);
  finally
    Leave;
  end;
end;

function TdbFactory.GetConnectionString: WideString;
begin
  result := ConnString;
end;

function TdbFactory.iDbType: Integer;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.iDbType;
  finally
    Leave;
  end;
end;

function TdbFactory.Initialize(const ConnStr: WideString): boolean;
var
  vList:TStringList;
begin
  Disconnect;
  vList := TStringList.Create;
  try
    vList.Delimiter := ';';
    vList.DelimitedText := ConnStr;
    ConnMode := StrtoIntDef(vList.Values['connmode'],1);
    FConnStr := ConnStr;
  finally
    vList.Free;
  end;
end;

function TdbFactory.InTransaction: boolean;
begin
  result := Assigned(dbResolver) and dbResolver.InTransaction;
end;

function TdbFactory.Open(DataSet: TDataSet): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.Open(DataSet);
  finally
    Leave;
  end;
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.UpdateBatch(DataSet,AClassName,Params);
    if result then TZAbstractDataset(DataSet).CommitUpdates;
  finally
    Leave;
  end;
end;

procedure TdbFactory.RollbackTrans;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    dbResolver.RollbackTrans;
  finally
    Leave;
  end;
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.UpdateBatch(DataSet);
    if result then TZAbstractDataset(DataSet).CommitUpdates;
  finally
    Leave;
  end;
end;

function TdbFactory.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.AddBatch(DataSet,AClassName,Params);
  finally
    Leave;
  end;
end;

function TdbFactory.BeginBatch: Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.BeginBatch;
  finally
    Leave;
  end;
end;

function TdbFactory.CancelBatch: Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.CancelBatch;
  finally
    Leave;
  end;
end;

function TdbFactory.CommitBatch: Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.CommitBatch;
  finally
    Leave;
  end;
end;

function TdbFactory.OpenBatch: Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.OpenBatch;
  finally
    Leave;
  end;
end;

function TdbFactory.ExecProc(AClassName: String;
  Params: TftParamList): String;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.ExecProc(AClassName,Params);
  finally
    Leave;
  end;
end;

function TdbFactory.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := Open(DataSet,AClassName,nil);
  finally
    Leave;
  end;
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := UpdateBatch(DataSet,AClassName,nil);
  finally
    Leave;
  end;
end;

procedure TdbFactory.SetConnMode(const Value: integer);
begin
  FConnMode := Value;
  
end;

procedure TdbFactory.SetConnStr(const Value: string);
begin
  FConnStr := Value;
  Initialize(ConnString);
end;

procedure TdbFactory.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

procedure TdbFactory.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

end.
