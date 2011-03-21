unit uSyncFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,ZDataSet,ZBase,ObjCommon;
type
  PSynTableInfo=^TSynTableInfo;
  TSynTableInfo=record
    tbname:string;//表名
    keyFields:string;//关健字段
    synFlag:integer;//0简单表 1主从单据表
  end;
  TSyncFactory=class
  private
    FParams: TftParamList;
    FList:TList;
    FSyncTimeStamp: int64;
    procedure SetParams(const Value: TftParamList);
    procedure SetSyncTimeStamp(const Value: int64);
  public
    constructor Create;
    destructor Destroy;override;

    //检测数据库版本.
    function CheckDBVersion:boolean;
    //初始化同步队列
    procedure InitList;

    function GetSynTimeStamp(tbName:string):int64;
    procedure SetSynTimeStamp(tbName:string;TimeStamp:int64);
    //双同同步
    procedure SyncSingleTable(tbName,KeyFields:string);

    property Params:TftParamList read FParams write SetParams;
    property SyncTimeStamp:int64 read FSyncTimeStamp write SetSyncTimeStamp;
  end;
var
  SyncFactory:TSyncFactory;
implementation
uses uGlobal,ufrmLogo;
{ TCaFactory }

function TSyncFactory.CheckDBVersion: boolean;
var
  LocalVersion,RemoteVersion:string;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''DBVERSION'' and TENANT_ID=0';
    Global.LocalFactory.Open(rs);
    LocalVersion := rs.Fields[0].AsString;
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''DBVERSION'' and TENANT_ID=0';
    Global.RemoteFactory.Open(rs);
    RemoteVersion := rs.Fields[0].AsString;
    result := (LocalVersion=RemoteVersion);
  finally
    rs.Free;
  end;
end;

constructor TSyncFactory.Create;
begin
  FParams := TftParamList.Create(nil);
  FList := TList.Create;
end;

destructor TSyncFactory.Destroy;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Free;
  FParams.Free;
  inherited;
end;

function TSyncFactory.GetSynTimeStamp(tbName: string): int64;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE';
    rs.ParambyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('DEFINE').AsString := 'SYN_'+tbName;
    Global.LocalFactory.Open(rs);
    if rs.IsEmpty then result := 0 else StrtoInt64(rs.Fields[0].AsString);
  finally
    rs.Free;
  end;
end;

procedure TSyncFactory.InitList;
var
  n:PSynTableInfo;
begin
  new(n);
  n^.tbname := 'CA_TENANT';
  n^.keyFields := 'TENANT_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_SHOP_INFO';
  n^.keyFields := 'TENANT_ID;SHOP_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_DEPT_INFO';
  n^.keyFields := 'TENANT_ID;DEPT_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_DUTY_INFO';
  n^.keyFields := 'TENANT_ID;DUTY_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_ROLE_INFO';
  n^.keyFields := 'TENANT_ID;ROLE_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_USERS';
  n^.keyFields := 'TENANT_ID;USER_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RELATION';
  n^.keyFields := 'TENANT_ID;RELATION_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RELATIONS';
  n^.keyFields := 'TENANT_ID;RELATIONS_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CODE_INFO';
  n^.keyFields := 'TENANT_ID;CODE_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'SYS_SEQUENCE';
  n^.keyFields := 'TENANT_ID;SEQU_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RIGHTS';
  n^.keyFields := 'TENANT_ID;ROWS_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSSORT';
  n^.keyFields := 'TENANT_ID;SORT_ID;SORT_TYPE';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_COLOR_INFO';
  n^.keyFields := 'TENANT_ID;COLOR_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_SIZE_INFO';
  n^.keyFields := 'TENANT_ID;SIZE_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_SIZE_INFO';
  n^.keyFields := 'TENANT_ID;SIZE_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_MEAUNITS';
  n^.keyFields := 'TENANT_ID;UNIT_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSINFO';
  n^.keyFields := 'TENANT_ID;GODS_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODS_RELATION';
  n^.keyFields := 'TENANT_ID;ROWS_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_BARCODE';
  n^.keyFields := 'TENANT_ID;ROWS_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_PRICEGRADE';
  n^.keyFields := 'TENANT_ID;PRICE_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_UNION_INFO';
  n^.keyFields := 'TENANT_ID;UNION_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_UNION_INDEX';
  n^.keyFields := 'TENANT_ID;UNION_ID;INDEX_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CLIENTINFO';
  n^.keyFields := 'TENANT_ID;CLIENT_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CUSTOMER';
  n^.keyFields := 'TENANT_ID;CUST_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CUSTOMER_EXT';
  n^.keyFields := 'TENANT_ID;UNION_ID;CUST_ID;INDEX_ID';
  n^.synFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_IC_INFO';
  n^.keyFields := 'TENANT_ID;UNION_ID;IC_CARDNO';
  n^.synFlag := 0;
  FList.Add(n);
end;

procedure TSyncFactory.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

procedure TSyncFactory.SetSyncTimeStamp(const Value: int64);
begin
  FSyncTimeStamp := Value;
end;

procedure TSyncFactory.SetSynTimeStamp(tbName: string; TimeStamp: int64);
var
  r:integer;
begin
  r := Global.LocalFactory.ExecSQL('update SYS_DEFINE set VALUE='''+inttostr(TimeStamp)+''' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and DEFINE=''SYN_'+tbName+'''');
  if r=0 then
     Global.LocalFactory.ExecSQL('insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,COMM,TIME_STAMP,VALUE_TYPE) values('+inttostr(Global.TENANT_ID)+',''SYN_'+tbName+''','''+inttostr(TimeStamp)+''',''00'','+GetTimeStamp(Global.LocalFactory.iDbType)+',0)');
end;

procedure TSyncFactory.SyncSingleTable(tbName, KeyFields: string);
var
  cs,rs:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName);
  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    //以服务器为优先下载
    Global.RemoteFactory.Open(rs,'TSyncSingleTable',Params);
    cs.Delta := rs.SyncDelta;
    Global.LocalFactory.UpdateBatch(cs,'TSyncSingleTable',Params);
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    //上传本机数据
    Global.LocalFactory.Open(cs,'TSyncSingleTable',Params);
    rs.Delta := cs.SyncDelta;
    Global.RemoteFactory.UpdateBatch(rs,'TSyncSingleTable',Params);
    SetSynTimeStamp(tbName,SyncTimeStamp);
  finally
    rs.Free;
    cs.Free;
  end;
end;

initialization
  SyncFactory := TSyncFactory.Create;
finalization
  SyncFactory.Free;
end.
