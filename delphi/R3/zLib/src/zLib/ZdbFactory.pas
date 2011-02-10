//***********************************************************//
//        设计:张森荣     编码：张森荣
//        版本:5.0        修改日期:2011-01-10
//        R3项目组
//***********************************************************//
unit ZdbFactory;

interface
uses SysUtils,Classes,Windows,DB,ZIntf,ZdbHelp,ZBase,ZAbstractDataset;
type
  TdbFactory = class(TComponent)
  private
    dbResolver:TdbResolver;
  public
    constructor Create;
    destructor  Destroy;override;

    //设置连接参数
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
  end;
implementation

{ TdbFactory }

procedure TdbFactory.BeginTrans(TimeOut: integer);
begin
  dbResolver.BeginTrans(TimeOut); 
end;

procedure TdbFactory.CommitTrans;
begin
  dbResolver.CommitTrans;
end;

function TdbFactory.Connect: boolean;
begin
  result := dbResolver.Connect;
end;

function TdbFactory.Connected: boolean;
begin
  result := dbResolver.Connected;
end;

constructor TdbFactory.Create;
begin
  dbResolver := TdbResolver.Create;
end;

destructor TdbFactory.Destroy;
begin
  dbResolver := nil;
  inherited;
end;

function TdbFactory.Open(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  result := dbResolver.Open(DataSet,AClassName,Params)
end;

function TdbFactory.DisConnect: boolean;
begin
  result := dbResolver.DisConnect;
end;

function TdbFactory.ExecSQL(const SQL: WideString;
  ObjectFactory: TZFactory): Integer;
begin
  result := dbResolver.ExecSQL(SQL,ObjectFactory);
end;

function TdbFactory.GetConnectionString: WideString;
begin
  result := dbResolver.GetConnectionString;
end;

function TdbFactory.iDbType: Integer;
begin
  result := dbResolver.iDbType;
end;

function TdbFactory.Initialize(const ConnStr: WideString): boolean;
begin
  result := dbResolver.Initialize(ConnStr);
end;

function TdbFactory.InTransaction: boolean;
begin
  result := dbResolver.InTransaction;
end;

function TdbFactory.Open(DataSet: TDataSet): Boolean;
begin
  result := dbResolver.Open(DataSet); 
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  result := dbResolver.UpdateBatch(DataSet,AClassName,Params);
  if result then TZAbstractDataset(DataSet).CommitUpdates;

end;

procedure TdbFactory.RollbackTrans;
begin
  dbResolver.RollbackTrans;
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet): Boolean;
begin
  result := dbResolver.UpdateBatch(DataSet); 
  if result then TZAbstractDataset(DataSet).CommitUpdates;
end;

function TdbFactory.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
begin
  result := dbResolver.AddBatch(DataSet,AClassName,Params);
end;

function TdbFactory.BeginBatch: Boolean;
begin
  result := dbResolver.BeginBatch;
end;

function TdbFactory.CancelBatch: Boolean;
begin
  result := dbResolver.CancelBatch;
end;

function TdbFactory.CommitBatch: Boolean;
begin
  result := dbResolver.CommitBatch;
end;

function TdbFactory.OpenBatch: Boolean;
begin
  result := dbResolver.OpenBatch;
end;

function TdbFactory.ExecProc(AClassName: String;
  Params: TftParamList): String;
begin
  result := dbResolver.ExecProc(AClassName,Params);
end;

function TdbFactory.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  result := Open(DataSet,AClassName,nil);
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  result := UpdateBatch(DataSet,AClassName,nil);
end;

end.
