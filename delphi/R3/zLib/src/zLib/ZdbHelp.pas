//***********************************************************//
//        设计:张森荣     编码：张森荣
//        版本:5.0        修改日期:2011-01-10
//        R3项目组
//***********************************************************//
unit ZdbHelp;

interface
uses Classes,SysUtils,Windows,DB,Variants,ZIntf,ZAbstractRODataset, ZDbcCache,
     ZAbstractDataset, ZDataset, ZConnection, ZDbcIntfs, ZBase, ZSqlUpdate, ComObj;
type
  TdbHelp=class(TInterfacedObject, IdbHelp)
  private
    ZConn:TZConnection;
    ZConnStr:string;
    function CheckError(s:string):boolean;
    function CheckConnection:boolean;
  protected
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

    //HRESULT 返回值说明 =0表示执行成功 否则为错误代码
    function Open(DataSet:TDataSet):boolean;OverLoad;stdcall;
    //提交数据集
    function UpdateBatch(DataSet:TDataSet):boolean;OverLoad;stdcall;
    //返回执行影响记录数
    function ExecSQL(const SQL:WideString;ObjectFactory:TObject=nil):Integer;stdcall;
    //数据集执行Query 返回执行影响记录数
    function ExecQuery(DataSet:TDataSet):Integer;stdcall;
  public
    constructor Create;
    destructor Destroy;override;
  end;

  TZdbUpdate = class(TZUpdateSQL)
  private
    FdbHelp: IdbHelp;
    FFactory: TZFactory;
    idx:array of Integer;
    FColumnCount: integer;
    procedure SetColumnCount(const Value: integer);
  protected
    procedure DoBeforeApplyUpdate(Sender: TObject);override;
    procedure PSBeforeDeleteSQL(Sender: TObject);
    procedure PSBeforeInsertSQL(Sender: TObject);
    procedure PSBeforeModifySQL(Sender: TObject);
    procedure PSAfterDeleteSQL(Sender: TObject);
    procedure PSAfterInsertSQL(Sender: TObject);
    procedure PSAfterModifySQL(Sender: TObject);
    procedure SetdbHelp(const Value: IdbHelp);
    procedure SetFactory(const Value: TZFactory);

    procedure ReadData;
    procedure WriteData;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    property dbHelp:IdbHelp read FdbHelp write SetdbHelp;
    property Factory:TZFactory read FFactory write SetFactory;
    property ColumnCount:integer read FColumnCount write SetColumnCount;
  end;

  TCustomdbResolver=class(TInterfacedPersistent)
  private
    Fdbid: integer;
    FThreadId: Integer;
    FdbLocked: boolean;
    procedure Setdbid(const Value: integer);
    procedure SetThreadId(const Value: Integer);
    procedure SetdbLocked(const Value: boolean);
  public
    //设置连接参数
    function  Initialize(Const ConnStr:WideString):boolean;virtual;abstract;
    //读取连接串
    function  GetConnectionString:WideString;virtual;abstract;
    //连接数据库
    function  Connect:boolean;virtual;abstract;
    //检测通讯连接状态
    function  Connected:boolean;virtual;abstract;
    //关闭数据库
    function  DisConnect:boolean;virtual;abstract;

    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);virtual;abstract;
    //提交事务
    procedure CommitTrans;virtual;abstract;
    //回滚事务
    procedure RollbackTrans;virtual;abstract;
    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;virtual;abstract;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;virtual;abstract;

    //数据包组织
    function BeginBatch:Boolean;virtual;abstract;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;virtual;abstract;
    function OpenBatch:Boolean;virtual;abstract;
    function CommitBatch:Boolean;virtual;abstract;
    function CancelBatch:Boolean;virtual;abstract;

    //查询数据;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;virtual;abstract;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload;virtual;abstract;
    function Open(DataSet:TDataSet):Boolean;overload;virtual;abstract;
    //提交数据
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;virtual;abstract;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload;virtual;abstract;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;virtual;abstract;

    //返回执行影响记录数
    function ExecSQL(const SQL:WideString;ObjectFactory:TObject=nil):Integer;virtual;abstract;

    //执行远程方式，返回结果
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;virtual;abstract;

    //用户登录
    procedure GqqLogin(UserId:string;UserName:string);virtual;abstract;
    //锁定数据连接
    procedure DBLock(Locked:boolean);virtual;abstract;

    property dbid:integer read Fdbid write Setdbid;
    //锁定线程ID号
    property ThreadId:Integer read FThreadId write SetThreadId;
    //连接是否锁定
    property dbLocked:boolean read FdbLocked;
  end;
  TdbResolver=class(TCustomdbResolver)
  private
    dbHelp:IdbHelp;
    FList:TList;
  protected
    function CreateFactory(AClassName:string):TZFactory;
  public
    constructor Create;
    destructor Destroy;override;

    //设置连接参数
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
  end;

implementation
uses ZLogFile;
{ TdbHelp }

procedure TdbHelp.BeginTrans(TimeOut: integer);
begin
  CheckConnection;
  try
    if ZConn.InTransaction then Raise Exception.Create('当前连接已经启动事务了,不能BeginTrans');
    ZConn.TransactIsolationLevel := tiReadCommitted;
    ZConn.StartTransaction;
  except
    on E:Exception do
      begin
        if CheckError(E.Message) then ZConn.Disconnect;
        Raise;
      end;
  end;
end;

function TdbHelp.CheckConnection: boolean;
begin
  result := Connected;
  if not result then
     begin
       Initialize(ZConnStr);
       result := Connect;
     end;
end;

function TdbHelp.CheckError(s:string): boolean;
begin
  result := false;
//  if ZConn.Protocol='sqlite-3' then exit;
  result := not ZConn.InTransaction and (
     (pos('网络错误',s)>0) or
     (pos('连接断开',s)>0) or
     (pos('连接关闭',s)>0) or
     (pos('通信链路故障',s)>0) or
     (pos('ORA-12170',s)>0) or
     (pos('SQL0952N',s)>0) or
     (pos('SQL30081N',s)>0) or
     (pos('CLI0106E',s)>0) or
     (pos('database is locked',s)>0)
  );
end;

procedure TdbHelp.CommitTrans;
begin
  try
    if not ZConn.InTransaction then Raise Exception.Create('当前连接不在事务状态,不能commit'); 
    ZConn.Commit;
    ZConn.TransactIsolationLevel := tiNone;
  except
    on E:Exception do
      begin
        if CheckError(E.Message) then ZConn.Disconnect;
        Raise;
      end;
  end;
end;

function TdbHelp.Connect: boolean;
begin
  LogFile.AddLogFile(0,'ZConn.Connect to '+ZConn.Database);
  ZConn.Connect;
  LogFile.AddLogFile(0,'ZConn.Connect finish');
end;

function TdbHelp.Connected: boolean;
begin
  result := ZConn.Connected;
end;

constructor TdbHelp.Create;
begin
  ZConn := TZConnection.Create(nil);
end;

destructor TdbHelp.Destroy;
begin
  FreeAndNil(ZConn);
  inherited;
end;

function TdbHelp.DisConnect: boolean;
begin
  ZConn.Disconnect;
end;

function TdbHelp.ExecQuery(DataSet: TDataSet): Integer;
var ZQuery:TZQuery;
begin
  CheckConnection;
  try
    result := -1;
    ZQuery := TZQuery(DataSet);
    ZQuery.Connection := ZConn;
    ZQuery.ExecSQL;
    result := ZQuery.RowsAffected;
  except
    on E:Exception do
      begin
        if CheckError(E.Message) then ZConn.Disconnect;
        Raise;
      end;
  end;
end;

function TdbHelp.ExecSQL(const SQL: WideString;
  ObjectFactory: TObject): Integer;
var
  ZQuery:TZQuery;
  i:integer;
begin
  CheckConnection;
  try
  result := -1;
  ZQuery := TZQuery.Create(nil);
  try
    ZQuery.Connection := ZConn;
    ZQuery.SQL.Text := SQL;
    if ObjectFactory<>nil then
       begin
           if ObjectFactory is TParams then
              ZQuery.Params.AssignValues(TParams(ObjectFactory))
           else
           begin
           for i:=0 to ZQuery.Params.Count -1 do
              begin
                if copy(ZQuery.Params[i].Name,1,4)='OLD_' then
                   begin
                     ZQuery.Params[i].DataType := TZFactory(ObjectFactory).FieldbyName(copy(ZQuery.Params[i].Name,5,50)).DataType;
                     ZQuery.Params[i].Value := TZFactory(ObjectFactory).FieldbyName(copy(ZQuery.Params[i].Name,5,50)).OldValue;
                   end
                else
                   begin
                     ZQuery.Params[i].DataType := TZFactory(ObjectFactory).FieldbyName(ZQuery.Params[i].Name).DataType;
                     ZQuery.Params[i].Value := TZFactory(ObjectFactory).FieldbyName(ZQuery.Params[i].Name).NewValue;
                   end;
              end;
           end;
       end;
    ZQuery.ExecSQL;
    result := ZQuery.RowsAffected;
  finally
    ZQuery.Free;
  end;
  except
    on E:Exception do
      begin
        if CheckError(E.Message) then ZConn.Disconnect;
        Raise;
      end;
  end;
end;

function TdbHelp.GetConnectionString: WideString;
begin
  result := 'Provider='+ZConn.Protocol+';HostName='+ZConn.HostName+';DatabaseName='+ZConn.Database+';UID='+ZConn.User+';Password='+ZConn.Password;
end;

function TdbHelp.iDbType: Integer;
begin
  if copy(ZConn.Protocol,1,6) = 'mssql' then
     result := 0
  else
  if copy(ZConn.Protocol,1,6) = 'oracle' then
     result := 1
  else
  if copy(ZConn.Protocol,1,6) = 'oracle-9i' then
     result := 1
  else
   if copy(ZConn.Protocol,1,6) = 'ado' then
     result := 4
  else
  if copy(ZConn.Protocol,1,6) = 'sqlite' then
     result := 5;
end;

function TdbHelp.Initialize(const ConnStr: WideString): boolean;
var
  vList:TStringList;
begin
  ZConn.Disconnect;
  vList := TStringList.Create;
  try
    vList.Delimiter := ';';
    vList.QuoteChar := '"';
    vList.DelimitedText := ConnStr;
    ZConn.HostName := vList.Values['hostname'];
    ZConn.Database := vList.Values['databasename'];
    if vList.Values['uid']<>'' then ZConn.User := vList.Values['uid'];
    if vList.Values['password']<>'' then ZConn.Password := vList.Values['password'];
    ZConn.Protocol := vList.Values['provider'];
  finally
    vList.Free;
  end;
  ZConnStr := ConnStr;
end;

function TdbHelp.InTransaction: boolean;
begin
  try
    result := zConn.InTransaction;
  except
    on E:Exception do
      begin
        if CheckError(E.Message) then ZConn.Disconnect;
        Raise;
      end;
  end;
end;

function TdbHelp.Open(DataSet: TDataSet): boolean;
begin
  CheckConnection;
  try
  result := false;
  DataSet.Close;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       TZQuery(DataSet).CachedUpdates := true;
       TZQuery(DataSet).Connection := ZConn;
     end;
  if DataSet.ClassNameIs('TZReadonlyQuery') then
     begin
       TZQuery(DataSet).CachedUpdates := true;
       TZQuery(DataSet).Connection := ZConn;
     end;
  if DataSet.ClassNameIs('TZTable') then
     begin
       TZTable(DataSet).CachedUpdates := true;
       TZTable(DataSet).Connection := ZConn;
     end;
  try
    DataSet.Open;
    result := true;
  finally
    if DataSet.ClassNameIs('TZQuery') then
       begin
         TZQuery(DataSet).Connection := nil;
       end;
    if DataSet.ClassNameIs('TZReadonlyQuery') then
       begin
         TZQuery(DataSet).Connection := nil;
       end;
    if DataSet.ClassNameIs('TZTable') then
       begin
         TZTable(DataSet).Connection := nil;
       end;
  end;
  except
    on E:Exception do
      begin
        if CheckError(E.Message) then ZConn.Disconnect;
        Raise;
      end;
  end;
end;

procedure TdbHelp.RollbackTrans;
begin
  try
    if not ZConn.InTransaction then Raise Exception.Create('当前连接不在事务状态,不能rollback'); 
    ZConn.Rollback;
    ZConn.TransactIsolationLevel := tiNone;
  except
    on E:Exception do
      begin
        if CheckError(E.Message) then ZConn.Disconnect;
        Raise;
      end;
  end;
end;

function TdbHelp.UpdateBatch(DataSet: TDataSet): boolean;
begin
  CheckConnection;
  try
  result := false;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       TZQuery(DataSet).Connection := ZConn;
     end;
  if DataSet.ClassNameIs('TZTable') then
     begin
       TZTable(DataSet).Connection := ZConn;
     end;
  try
    with TZAbstractDataset(DataSet) do
      begin
        ApplyUpdates;
        result := true;
      end;
  finally
    if DataSet.ClassNameIs('TZQuery') then
       begin
         TZQuery(DataSet).Connection := nil;
       end;
    if DataSet.ClassNameIs('TZTable') then
       begin
         TZTable(DataSet).Connection := nil;
       end;
  end;
  except
    on E:Exception do
      begin
        if CheckError(E.Message) then ZConn.Disconnect;
        Raise;
      end;
  end;
end;

{ TdbResolver }

procedure TdbResolver.BeginTrans(TimeOut: integer);
begin
  dbHelp.BeginTrans(TimeOut);
end;

procedure TdbResolver.CommitTrans;
begin
  dbHelp.CommitTrans;
end;

function TdbResolver.Connect: boolean;
begin
  result := dbHelp.Connect;
end;

function TdbResolver.Connected: boolean;
begin
  result := dbHelp.Connected;
end;

constructor TdbResolver.Create;
begin
  dbHelp := TdbHelp.Create;
  FList := TList.Create;
end;

function TdbResolver.CreateFactory(AClassName: string): TZFactory;
var
  FactoryClass:TPersistentClass;
begin
  if AClassName<>'' then
  begin
    FactoryClass := GetClass(AClassName);
    if FactoryClass = nil then Raise Exception.Create(AClassName+'对象名没有找到.');
    result := TZFactoryClass(FactoryClass).Create;
    result.iDbType := dbHelp.iDbType;
    result.ZClassName:=AClassName;  //类名AClassName传入
  end
  else
  begin
    result := TZFactory.Create;
    result.iDbType := dbHelp.iDbType;
    result.ZClassName:=''; 
  end;
end;

destructor TdbResolver.Destroy;
var
  i:integer;
begin
  dbHelp := nil;
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Free;
  inherited;
end;

function TdbResolver.Open(DataSet: TDataSet; AClassName: String;
  Params:TftParamList): Boolean;
var
  Factory:TZFactory;
begin
  Factory := CreateFactory(AClassName);
  try
    Factory.DataSet := DataSet;
    if Assigned(Params) then Factory.Params.Assign(Params);
    Factory.InitClass;
    DataSet.Close;
//    Factory.ReadFromDataSet(DataSet);
    Factory.BeforeOpenRecord(dbHelp);
    if not DataSet.Active then
      begin
        if DataSet.ClassNameIs('TZQuery') then
           begin
             TZQuery(DataSet).SQL.Text := Factory.SelectSQL.Text;
             if Assigned(Params) then TZQuery(DataSet).Params.AssignValues(Params);
           end
        else
        if DataSet.ClassNameIs('TZReadOnlyQuery') then
           begin
             TZReadOnlyQuery(DataSet).SQL.Text := Factory.SelectSQL.Text;
             if Assigned(Params) then TZReadOnlyQuery(DataSet).Params.AssignValues(Params);
           end
        else
           Raise Exception.Create('不支持的数据集.');
        result := Open(DataSet);
      end;
  finally
    Factory.Free;
  end;
end;

function TdbResolver.DisConnect: boolean;
begin
  result := dbHelp.DisConnect;
end;

function TdbResolver.ExecSQL(const SQL: WideString;
  ObjectFactory: TObject): Integer;
begin
  if Assigned(ObjectFactory) then
     result := dbHelp.ExecSQL(SQL,ObjectFactory)
  else
     result := dbHelp.ExecSQL(SQL);
end;

function TdbResolver.GetConnectionString: WideString;
begin
  result := dbHelp.GetConnectionString;
end;

function TdbResolver.iDbType: Integer;
begin
  result := dbHelp.iDbType;
end;

function TdbResolver.Initialize(const ConnStr: WideString): boolean;
begin
  result := dbHelp.Initialize(ConnStr);
end;

function TdbResolver.InTransaction: boolean;
begin
  result := dbHelp.InTransaction;
end;

function TdbResolver.Open(DataSet: TDataSet): Boolean;
begin
  result := dbHelp.Open(DataSet);
end;

function TdbResolver.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
var
  Factory:TZFactory;
  SaveTrans:Boolean;
  UpdateSQL:TZdbUpdate;
begin
  Factory := CreateFactory(AClassName);
  UpdateSQL := TZdbUpdate.Create(nil);
  try
    UpdateSQL.dbHelp := dbHelp;
    UpdateSQL.Factory := Factory;
    Factory.DataSet := DataSet;
    if Assigned(Params) then Factory.Params.Assign(Params);
    Factory.InitClass;
    SaveTrans := dbHelp.InTransaction;
    if not SaveTrans then dbHelp.BeginTrans;
    try
      //改由SQLUpdate完成
      //Factory.ReadFromDataSet(DataSet);
      //Factory.BeforeUpdateRecord(dbHelp);
      if Factory.Count = 0 then Factory.ReadField(DataSet); 
      UpdateSQL.DataSet := DataSet;
      UpdateSQL.DeleteSQL.Text := Factory.DeleteSQL.Text;
      UpdateSQL.ModifySQL.Text := Factory.UpdateSQL.Text;
      UpdateSQL.InsertSQL.Text := Factory.InsertSQL.Text;
      if DataSet.ClassNameIs('TZQuery') then
         begin
           TZQuery(DataSet).UpdateObject := UpdateSQL;
           if Params<>nil then TZQuery(DataSet).Params.AssignValues(Params);
         end
      else
         Raise Exception.Create('不支持的数据集.');

      result := UpdateBatch(DataSet);
      Factory.BeforeCommitRecord(dbHelp); 
      if not SaveTrans then dbHelp.CommitTrans;
    except
      if not SaveTrans then dbHelp.RollbackTrans;
      Raise;
    end;
  finally
    TZQuery(DataSet).UpdateObject := nil;
    UpdateSQL.Free;
    Factory.Free;
  end;
end;

procedure TdbResolver.RollbackTrans;
begin
  dbHelp.RollbackTrans;
end;

function TdbResolver.UpdateBatch(DataSet: TDataSet): Boolean;
begin
  result := dbHelp.UpdateBatch(DataSet);
end;

function TdbResolver.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
var
  Factory:TZFactory;
begin
  Factory := CreateFactory(AClassName);
  FList.Add(Factory);
  Factory.DataSet := DataSet;
  if Assigned(Params) then  Factory.Params.Assign(Params);
  Factory.InitClass;
  if DataSet.ClassNameIs('TZQuery') then
     begin
       if not TZQuery(DataSet).Active then   //要判断，CommitBatch前进行打包时，会把数据集给关闭掉
          TZQuery(DataSet).SQL.Text := Factory.SelectSQL.Text;
       if Assigned(Params) then TZQuery(DataSet).Params.AssignValues(Params);
     end
  else
  if DataSet.ClassNameIs('TZReadOnlyQuery') then
     begin
       TZReadOnlyQuery(DataSet).SQL.Text := Factory.SelectSQL.Text;
       if Assigned(Params) then TZReadOnlyQuery(DataSet).Params.AssignValues(Params);
     end
  else
     Raise Exception.Create('不支持的数据集.');
end;

function TdbResolver.BeginBatch: Boolean;
begin
  if FList.Count > 0 then Raise Exception.Create('正在组织数据包，无法开始新的数据包。'); 
end;

function TdbResolver.CancelBatch: Boolean;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Clear;
end;

function TdbResolver.CommitBatch: Boolean;
var
  i:integer;
  SQLUpdate:TZdbUpdate;
  SaveTrans:boolean;
begin
  if FList.Count = 0 then Raise Exception.Create('没有组合数据包..');
  SaveTrans := dbHelp.InTransaction;
  if not SaveTrans then dbHelp.BeginTrans;
  SQLUpdate := TZdbUpdate.Create(nil);
  try
    //更新记录
    for i:=0 to FList.Count -1 do
      begin
        SQLUpdate.dbHelp := dbHelp;
        SQLUpdate.Factory := TZFactory(FList[i]);
        with TZFactory(FList[i]) do
          begin
            if ZClassName='' then
               begin
                 dbHelp.UpdateBatch(DataSet);
               end
            else
               begin
                 TZQuery(DataSet).UpdateObject := SQLUpdate;
                 try
                   SQLUpdate.DataSet := DataSet;
                   if Count=0 then ReadField(DataSet);
                   SQLUpdate.DeleteSQL.Text := DeleteSQL.Text;
                   SQLUpdate.ModifySQL.Text := UpdateSQL.Text;
                   SQLUpdate.InsertSQL.Text := InsertSQL.Text;
                   dbHelp.UpdateBatch(DataSet);
                 finally
                   TZQuery(DataSet).UpdateObject := nil;
                 end;
               end;
          end;
      end;
    //更新记录后
    for i:=0 to FList.Count -1 do
      begin
        SQLUpdate.dbHelp := dbHelp;
        SQLUpdate.Factory := TZFactory(FList[i]);
        with TZFactory(FList[i]) do
          begin
            if ZClassName<>'' then
               begin
//                 ReadFromDataSet(DataSet);
                 BeforeCommitRecord(dbHelp);
               end;
          end;
      end;
    for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
    FList.Clear;
    SQLUpdate.Free;
    if not SaveTrans then dbHelp.CommitTrans;
    result := true;
  except
    if not SaveTrans then dbHelp.RollbackTrans;
    SQLUpdate.Free;
    result := false;
    Raise;
  end;
end;

function TdbResolver.OpenBatch: Boolean;
var
  i:integer;
begin
  if FList.Count = 0 then Raise Exception.Create('没有组合数据包..');
  result := false;
  try
    for i:=0 to FList.Count -1 do
      begin
        with TZFactory(FList[i]) do
          begin
            //ReadFromDataSet(DataSet);
            DataSet.Close;
            BeforeOpenRecord(dbHelp);
            if not DataSet.Active then
              begin
                if ZClassName<>'' then
                   begin
                     if SelectSQL.Text<>'' then TZQuery(DataSet).SQL.Text := SelectSQL.Text;
                     if Assigned(Params) then TZQuery(DataSet).Params.AssignValues(Params);
                   end;
                result := dbHelp.Open(DataSet);
              end;
          end;
      end;
    for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
    FList.Clear;
    result := true;
  except
    result := false;
    Raise;
  end;
end;

function TdbResolver.ExecProc(AClassName: String;
  Params: TftParamList): String;
function CreateFactory(AClassName: string): TZProcFactory;
var
  FactoryClass:TPersistentClass;
begin
  FactoryClass := GetClass(AClassName);
  if FactoryClass = nil then Raise Exception.Create(AClassName+'对象名没有找到.');
  result := TZProcFactoryClass(FactoryClass).Create(dbHelp,Params);
end;
var
  Factory:TZProcFactory;
  V:oleVariant;
begin
  Factory := CreateFactory(AClassName);
  try
    if Assigned(Params) then Factory.Params.Assign(Params);
    Factory.Execute(dbHelp,Params,V);
    result := V;
  finally
    Factory.Free;
  end;
end;

function TdbResolver.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  result := Open(DataSet,AClassName,nil);
end;

function TdbResolver.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  result := UpdateBatch(DataSet,AClassName,nil);
end;

procedure TdbResolver.GqqLogin(UserId, UserName: string);
begin
  inherited;

end;

procedure TdbResolver.DBLock(Locked: boolean);
begin
  inherited;
  FdbLocked := Locked;
end;

{ TZdbUpdate }

constructor TZdbUpdate.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AfterDeleteSQL := PSAfterDeleteSQL;
  AfterInsertSQL := PSAfterInsertSQL;
  AfterModifySQL := PSAfterModifySQL;
  BeforeDeleteSQL := PSBeforeDeleteSQL;
  BeforeInsertSQL := PSBeforeInsertSQL;
  BeforeModifySQL := PSBeforeModifySQL;
  ColumnCount := 0;
end;

destructor TZdbUpdate.Destroy;
begin

  inherited;
end;

procedure TZdbUpdate.DoBeforeApplyUpdate(Sender: TObject);
begin
  inherited;
  ReadData;
  Factory.BeforeUpdateRecord(dbHelp);
end;

procedure TZdbUpdate.PSAfterDeleteSQL;
begin

end;

procedure TZdbUpdate.PSAfterInsertSQL;
begin

end;

procedure TZdbUpdate.PSAfterModifySQL;
begin

end;

procedure TZdbUpdate.PSBeforeDeleteSQL;
begin
  ReadData;
  Factory.BeforeDeleteRecord(dbHelp);
  WriteData;
end;

procedure TZdbUpdate.PSBeforeInsertSQL;
begin
  ReadData;
  Factory.BeforeInsertRecord(dbHelp);
  WriteData;
end;

procedure TZdbUpdate.PSBeforeModifySQL;
begin
  ReadData;
  Factory.BeforeModifyRecord(dbHelp);
  WriteData;
end;

procedure TZdbUpdate.ReadData;
var
  i:integer;
  WasNull:boolean;
begin
  if ColumnCount=0 then
     begin
       ColumnCount := FNewRowAccessor.ColumnCount;
       setLength(idx,FNewRowAccessor.ColumnCount);
       for i:=0 to FNewRowAccessor.ColumnCount -1 do
         begin
           idx[i] :=Factory.FindField(FNewRowAccessor.GetColumnName(i+1)).Index;
         end;
     end;
  for i:=0 to FNewRowAccessor.ColumnCount -1 do
     begin
      case FNewRowAccessor.GetColumnType(i+1)  of
        stBoolean:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetBoolean(i+1, WasNull);
        stByte:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetByte(i+1, WasNull);
        stShort:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetShort(i+1, WasNull);
        stInteger:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetInt(i+1, WasNull);
        stLong:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetLong(i+1, WasNull);
        stFloat:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetFloat(i+1, WasNull);
        stDouble:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetDouble(i+1, WasNull);
        stBigDecimal:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetBigDecimal(i+1, WasNull);
        stString, stUnicodeString,stUnicodeStream,stAsciiStream,stBinaryStream:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetString(i+1, WasNull);
        stBytes:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetBytes(i+1, WasNull);
        stDate:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetDate(i+1, WasNull);
        stTime:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetTime(i+1, WasNull);
        stTimestamp:
          Factory.Fields[idx[i]].NewValue := FNewRowAccessor.GetTimestamp(i+1, WasNull);
      end;
      if WasNull then Factory.Fields[idx[i]].NewValue := null;
      if FNewRowAccessor.RowBuffer.UpdateType in [utModified,utDeleted] then
         begin
            case FNewRowAccessor.GetColumnType(i+1)  of
              stBoolean:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetBoolean(i+1, WasNull);
              stByte:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetByte(i+1, WasNull);
              stShort:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetShort(i+1, WasNull);
              stInteger:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetInt(i+1, WasNull);
              stLong:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetLong(i+1, WasNull);
              stFloat:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetFloat(i+1, WasNull);
              stDouble:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetDouble(i+1, WasNull);
              stBigDecimal:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetBigDecimal(i+1, WasNull);
              stString, stUnicodeString,stUnicodeStream,stAsciiStream,stBinaryStream:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetString(i+1, WasNull);
              stBytes:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetBytes(i+1, WasNull);
              stDate:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetDate(i+1, WasNull);
              stTime:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetTime(i+1, WasNull);
              stTimestamp:
                Factory.Fields[idx[i]].OldValue := FOldRowAccessor.GetTimestamp(i+1, WasNull);
            end;
            if WasNull then Factory.Fields[idx[i]].OldValue := null;
         end;
      //为了容错，加入默认值
      if FNewRowAccessor.RowBuffer.UpdateType in [utDeleted] then
         Factory.Fields[idx[i]].NewValue := Factory.Fields[idx[i]].OldValue
      else
      if FNewRowAccessor.RowBuffer.UpdateType in [utUnmodified,utInserted] then
         Factory.Fields[idx[i]].OldValue := Factory.Fields[idx[i]].NewValue;
     end;
end;

procedure TZdbUpdate.SetColumnCount(const Value: integer);
begin
  FColumnCount := Value;
end;

procedure TZdbUpdate.SetdbHelp(const Value: IdbHelp);
begin
  FdbHelp := Value;
end;

procedure TZdbUpdate.SetFactory(const Value: TZFactory);
begin
  FFactory := Value;
  FColumnCount := 0;
end;

procedure TZdbUpdate.WriteData;
var
  i:integer;
  WasNull:boolean;
begin
  for i:=0 to FNewRowAccessor.ColumnCount-1 do
     begin
      if VarIsClear(Factory.Fields[idx[i]].NewValue) or VarIsNull(Factory.Fields[idx[i]].NewValue) then
         FNewRowAccessor.SetNull(i+1)
      else
      case FNewRowAccessor.GetColumnType(i+1)  of
        stBoolean:
          FNewRowAccessor.SetBoolean(i+1,Factory.Fields[idx[i]].NewValue);
        stByte:
          FNewRowAccessor.SetByte(i+1,Factory.Fields[idx[i]].NewValue);
        stShort:
          FNewRowAccessor.SetShort(i+1,Factory.Fields[idx[i]].NewValue);
        stInteger:
          FNewRowAccessor.SetInt(i+1,Factory.Fields[idx[i]].NewValue);
        stLong:
          FNewRowAccessor.SetLong(i+1,Factory.Fields[idx[i]].NewValue);
        stFloat:
          FNewRowAccessor.SetFloat(i+1,Factory.Fields[idx[i]].NewValue);
        stDouble:
          FNewRowAccessor.SetDouble(i+1,Factory.Fields[idx[i]].NewValue);
        stBigDecimal:
          FNewRowAccessor.SetBigDecimal(i+1,Factory.Fields[idx[i]].NewValue);
        stString, stUnicodeString,stUnicodeStream,stAsciiStream,stBinaryStream:
          FNewRowAccessor.SetString(i+1,Factory.Fields[idx[i]].NewValue);
        stBytes:
          FNewRowAccessor.SetBytes(i+1,Factory.Fields[idx[i]].NewValue);
        stDate:
          FNewRowAccessor.SetDate(i+1,Factory.Fields[idx[i]].NewValue);
        stTime:
          FNewRowAccessor.SetTime(i+1,Factory.Fields[idx[i]].NewValue);
        stTimestamp:
          FNewRowAccessor.SetTimestamp(i+1,Factory.Fields[idx[i]].NewValue);
      end;
     end;
end;

{ TCustomdbResolver }

procedure TCustomdbResolver.Setdbid(const Value: integer);
begin
  Fdbid := Value;
end;

procedure TCustomdbResolver.SetdbLocked(const Value: boolean);
begin
  FdbLocked := Value;
end;

procedure TCustomdbResolver.SetThreadId(const Value: Integer);
begin
  FThreadId := Value;
end;

end.
