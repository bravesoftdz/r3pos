unit udataFactory;

interface

uses
  SysUtils, Classes,ZdbFactory,DB,ZBase,Forms,IniFiles,ZDataset,Windows;

type
  TdataFactory = class(TDataModule)
  private
    Fsqlite: TdbFactory;
    Fremote: TdbFactory;
    FdbFlag: integer;
    FconnStr: string;
    dataset:TThreadList;
    FsignIned: boolean;
    Fonline: boolean;
    procedure Setsqlite(const Value: TdbFactory);
    procedure Setremote(const Value: TdbFactory);
    function getdb: TdbFactory;
    procedure SetdbFlag(const Value: integer);
    procedure SetconnStr(const Value: string);
    procedure SetsignIned(const Value: boolean);
    procedure Setonline(const Value: boolean);
    { Private declarations }
  protected
    property db:TdbFactory read getdb;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure connect;
    procedure disConnect;
    procedure MoveToDefault;
    procedure MoveToRemote;
    procedure MoveToSqlite;
    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);
    //提交事务
    procedure CommitTrans;
    //回滚事务
    procedure RollbackTrans;

    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;
    //数据包组织
    function BeginBatch:Boolean;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;
    function OpenBatch:Boolean;
    function CommitBatch:Boolean;
    function CancelBatch:Boolean;

    //查询数据;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload;
    function Open(DataSet:TDataSet):Boolean;overload;

    //提交数据
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;

    //返回执行影响记录数
    function ExecSQL(const SQL:WideString;ObjectFactory:TZFactory=nil):Integer;

    //执行远程方式，返回结果
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;

    //用户登录
    procedure GqqLogin(UserId:string;UserName:string);
    //锁定数据连接 <当用到Seesion级操作时，指定一个SESSION对数据进行操作，用完必须解锁>
    procedure DBLock(Locked:boolean);

    //数据集管理
    function createDataSet:THandle;
    procedure eraseDataSet(ds:THandle);
    function findDataSet(handle:THandle):TZQuery;
    
    property sqlite:TdbFactory read Fsqlite write Setsqlite;
    property remote:TdbFactory read Fremote write Setremote;
    property dbFlag:integer read FdbFlag write SetdbFlag;
    property connStr:string read FconnStr write SetconnStr;
    property signined:boolean read FsignIned write SetsignIned;
    property online:boolean read Fonline write Setonline;
  end;

var
  dataFactory: TdataFactory;

implementation
uses uTokenFactory;
{$R *.dfm}

{ TdbFactory }

function TdataFactory.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
begin
  result := db.AddBatch(DataSet,AClassName,Params); 
end;

function TdataFactory.BeginBatch: Boolean;
begin
  result := db.BeginBatch;
end;

procedure TdataFactory.BeginTrans(TimeOut: integer);
begin
  db.BeginTrans(TimeOut);
end;

function TdataFactory.CancelBatch: Boolean;
begin
  result := db.CancelBatch;
end;

function TdataFactory.CommitBatch: Boolean;
begin
  result := db.CommitBatch;
end;

procedure TdataFactory.CommitTrans;
begin
  db.CommitTrans;
end;

procedure TdataFactory.connect;
var
  F:TIniFile;
begin
  case dbflag of
  0:begin
      if not fileExists(ExtractShortPathName(ExtractFilePath(Application.ExeName))+'data\r3.db') then
         CopyFile(pchar(ExtractFilePath(Application.ExeName)+'\sqlite.db'),pchar(ExtractShortPathName(ExtractFilePath(Application.ExeName))+'data\r3.db'),false);
      sqlite.Initialize('provider=sqlite-3;databasename='+ExtractShortPathName(ExtractFilePath(Application.ExeName))+'data\r3.db');
      sqlite.connect;
    end;
  else
    begin
      try
        F := TIniFile.Create(ExtractShortPathName(ExtractFilePath(Application.ExeName))+'db.cfg');
        try
          remote.Initialize(F.ReadString('db','Connstr',''));
          remote.connect;
        finally
          F.Free;
        end;
        online := true;
      except
        online := false;
        Raise;
      end;
    end;
  end;
end;

constructor TdataFactory.Create(AOwner: TComponent);
begin
  inherited;
  remote := TdbFactory.Create;
  sqlite := TdbFactory.Create;
  dataset := TThreadList.Create;
  dbFlag := 0;
  connect;
end;

function TdataFactory.createDataSet: THandle;
var
  ds:TZQuery;
  list:TList;
begin
  ds := TZQuery.Create(nil);
  result := THandle(Pointer(ds));
  list := dataset.LockList;
  try
    list.Add(ds);
  finally
    dataset.UnlockList;
  end;
end;

procedure TdataFactory.DBLock(Locked: boolean);
begin
  db.DBLock(Locked); 
end;

destructor TdataFactory.Destroy;
var
  i:integer;
  list:TList;
begin
  list := dataset.LockList;
  try
    for i:=0 to list.Count-1 do
      tobject(list[i]).Free;
    list.Clear;
  finally
    dataset.UnlockList;
  end;
  dataset.Free;
  sqlite.Free;
  remote.Free;
  inherited;
end;

procedure TdataFactory.disConnect;
begin
  case dbFlag of
  0:sqlite.DisConnect;
  else remote.DisConnect;
  end;
end;

procedure TdataFactory.eraseDataSet(ds: THandle);
var
  list:TList;
  idx:integer;
begin
  list := dataset.LockList;
  try
    idx := list.IndexOf(Pointer(ds));
    if idx>=0 then
       begin
         TObject(list[idx]).free;
         list.Delete(idx); 
       end;
  finally
    dataset.UnlockList;
  end;
end;

function TdataFactory.ExecProc(AClassName: String;
  Params: TftParamList): String;
begin
  result := db.ExecProc(AClassName,Params); 
end;

function TdataFactory.ExecSQL(const SQL: WideString;
  ObjectFactory: TZFactory): Integer;
begin
  result := db.ExecSQL(SQL,ObjectFactory); 
end;

function TdataFactory.findDataSet(handle: THandle): TZQuery;
var
  list:TList;
  idx:integer;
begin
  list := dataset.LockList;
  try
    idx := list.IndexOf(Pointer(handle));
    if idx>=0 then
       begin
         result := TZQuery(list[idx]);
       end else Raise Exception.Create('not find dataset address:'+inttostr(handle));
  finally
    dataset.UnlockList;
  end;
end;

function TdataFactory.getdb: TdbFactory;
begin
  case dbFlag of
  0:result := sqlite;
  else
    result := remote;
  end;
end;

procedure TdataFactory.GqqLogin(UserId, UserName: string);
begin
  db.GqqLogin(UserId,UserName); 
end;

function TdataFactory.iDbType: Integer;
begin
  result := db.iDbType;
end;

function TdataFactory.InTransaction: boolean;
begin
  result := db.InTransaction;
end;

procedure TdataFactory.MoveToDefault;
var
  f:TIniFile;
begin
  if db.InTransaction then Raise Exception.Create('在事务中，不能切换连接');
  if not token.online then
     begin
       dbFlag := 0;
       Exit;
     end;
  F := TIniFile.Create(ExtractShortPathName(ExtractFilePath(Application.ExeName))+'r3.cfg');
  try
    if (F.ReadString('db','SFVersion','.LCL')='.LCL') then
       dbFlag := 0
    else
       dbFlag := 1;
  finally
    F.Free;
  end;
  if not db.Connected then connect; 
end;

procedure TdataFactory.MoveToRemote;
begin
  if db.InTransaction then Raise Exception.Create('在事务中，不能切换连接');
  dbFlag := 1;
  if not db.Connected then connect; 
end;

procedure TdataFactory.MoveToSqlite;
begin
  if db.InTransaction then Raise Exception.Create('在事务中，不能切换连接'); 
  dbFlag := 0;
  if not db.Connected then connect; 
end;

function TdataFactory.Open(DataSet: TDataSet): Boolean;
begin
  result := db.Open(DataSet); 
end;

function TdataFactory.Open(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  result := db.Open(DataSet,AClassName,Params);
end;

function TdataFactory.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  result := db.Open(DataSet,AClassName);
end;

function TdataFactory.OpenBatch: Boolean;
begin
  result := db.OpenBatch;
end;

procedure TdataFactory.RollbackTrans;
begin
  db.RollbackTrans;
end;

procedure TdataFactory.SetconnStr(const Value: string);
begin
  FconnStr := Value;
end;

procedure TdataFactory.SetdbFlag(const Value: integer);
begin
  FdbFlag := Value;
end;

procedure TdataFactory.Setonline(const Value: boolean);
begin
  Fonline := Value;
end;

procedure TdataFactory.Setremote(const Value: TdbFactory);
begin
  Fremote := Value;
end;

procedure TdataFactory.SetsignIned(const Value: boolean);
begin
  FsignIned := Value;
end;

procedure TdataFactory.Setsqlite(const Value: TdbFactory);
begin
  Fsqlite := Value;
end;

function TdataFactory.UpdateBatch(DataSet: TDataSet): Boolean;
begin
  result := db.UpdateBatch(DataSet);
end;

function TdataFactory.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  result := db.UpdateBatch(DataSet,AClassName);
end;

function TdataFactory.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  result := db.UpdateBatch(DataSet,AClassName,Params);
end;

initialization
  dataFactory := TdataFactory.create(nil);
finalization
  dataFactory.Free;
end.
