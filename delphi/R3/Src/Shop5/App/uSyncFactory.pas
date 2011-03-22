unit uSyncFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,ZDataSet,ZBase,ObjCommon;
type
  PSynTableInfo=^TSynTableInfo;
  TSynTableInfo=record
    tbname:string;//表名
    tbtitle:string;//说明
    keyFields:string;//关健字段
    synFlag:integer;
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

    function GetFactoryName(node:PSynTableInfo):string;

    //检测数据库版本.
    function CheckDBVersion:boolean;
    //初始化同步队列
    procedure InitList;

    function GetSynTimeStamp(tbName:string):int64;
    procedure SetSynTimeStamp(tbName:string;TimeStamp:int64);
    //双同同步
    procedure SyncSingleTable(tbName,KeyFields,ZClassName:string);
    //开始同步数据
    procedure SyncAll;

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

function TSyncFactory.GetFactoryName(node: PSynTableInfo): string;
begin
  case node^.synFlag of
  1:result := 'TSyncCaRelations';
  2:result := 'TSyncCaRelationInfo';
  3:result := 'TSyncPubBarcode';
  else
    result := 'TSyncSingleTable';
  end;
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
  i:integer;
begin
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Clear;
  new(n);
  n^.tbname := 'CA_TENANT';
  n^.keyFields := 'TENANT_ID';
  n^.synFlag := 0;
  n^.tbtitle := '企业资料';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_SHOP_INFO';
  n^.keyFields := 'TENANT_ID;SHOP_ID';
  n^.synFlag := 0;
  n^.tbtitle := '门店资料';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_DEPT_INFO';
  n^.keyFields := 'TENANT_ID;DEPT_ID';
  n^.synFlag := 0;
  n^.tbtitle := '部门资料';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_DUTY_INFO';
  n^.keyFields := 'TENANT_ID;DUTY_ID';
  n^.synFlag := 0;
  n^.tbtitle := '职务资料';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_ROLE_INFO';
  n^.keyFields := 'TENANT_ID;ROLE_ID';
  n^.synFlag := 0;
  n^.tbtitle := '角色资料';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_USERS';
  n^.keyFields := 'TENANT_ID;USER_ID';
  n^.synFlag := 0;
  n^.tbtitle := '用户资料';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RELATIONS';
  n^.keyFields := 'TENANT_ID;RELATIONS_ID';
  n^.synFlag := 1;
  n^.tbtitle := '供应关系';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RELATION';
  n^.keyFields := 'TENANT_ID;RELATION_ID';
  n^.synFlag := 2;
  n^.tbtitle := '供应链';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RELATION';
  n^.keyFields := 'TENANT_ID;RELATION_ID';
  n^.synFlag := 0;
  n^.tbtitle := '供应链';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CODE_INFO';
  n^.keyFields := 'TENANT_ID;CODE_ID;CODE_TYPE';
  n^.synFlag := 0;
  n^.tbtitle := '其他编码';
  FList.Add(n);
  new(n);
  n^.tbname := 'SYS_SEQUENCE';
  n^.keyFields := 'TENANT_ID;SEQU_ID';
  n^.synFlag := 0;
  n^.tbtitle := '序号控制表';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RIGHTS';
  n^.keyFields := 'TENANT_ID;ROWS_ID';
  n^.synFlag := 0;
  n^.tbtitle := '操作权限';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSSORT';
  n^.keyFields := 'TENANT_ID;SORT_ID;SORT_TYPE';
  n^.synFlag := 0;
  n^.tbtitle := '货品分类';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSSORT';
  n^.keyFields := 'TENANT_ID;SORT_ID;SORT_TYPE';
  n^.synFlag := 2;
  n^.tbtitle := '货品分类';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_COLOR_INFO';
  n^.keyFields := 'TENANT_ID;COLOR_ID';
  n^.synFlag := 0;
  n^.tbtitle := '颜色档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_COLOR_INFO';
  n^.keyFields := 'TENANT_ID;COLOR_ID';
  n^.synFlag := 2;
  n^.tbtitle := '颜色档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_SIZE_INFO';
  n^.keyFields := 'TENANT_ID;SIZE_ID';
  n^.synFlag := 0;
  n^.tbtitle := '尺码档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_SIZE_INFO';
  n^.keyFields := 'TENANT_ID;SIZE_ID';
  n^.synFlag := 2;
  n^.tbtitle := '尺码档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_MEAUNITS';
  n^.keyFields := 'TENANT_ID;UNIT_ID';
  n^.synFlag := 0;
  n^.tbtitle := '计量单位';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_MEAUNITS';
  n^.keyFields := 'TENANT_ID;UNIT_ID';
  n^.synFlag := 2;
  n^.tbtitle := '计量单位';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSINFO';
  n^.keyFields := 'TENANT_ID;GODS_ID';
  n^.synFlag := 0;
  n^.tbtitle := '商品档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSINFO';
  n^.keyFields := 'TENANT_ID;GODS_ID';
  n^.synFlag := 2;
  n^.tbtitle := '商品档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODS_RELATION';
  n^.keyFields := 'TENANT_ID;ROWS_ID';
  n^.synFlag := 0;
  n^.tbtitle := '商品档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODS_RELATION';
  n^.keyFields := 'TENANT_ID;ROWS_ID';
  n^.synFlag := 2;
  n^.tbtitle := '商品档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_BARCODE';
  n^.keyFields := 'TENANT_ID;ROWS_ID';
  n^.synFlag := 0;
  n^.tbtitle := '条码表';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_BARCODE';
  n^.keyFields := 'TENANT_ID;ROWS_ID';
  n^.synFlag := 3;
  n^.tbtitle := '条码表';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_PRICEGRADE';
  n^.keyFields := 'TENANT_ID;PRICE_ID';
  n^.synFlag := 0;
  n^.tbtitle := '客户等级';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_UNION_INFO';
  n^.keyFields := 'TENANT_ID;UNION_ID';
  n^.synFlag := 0;
  n^.tbtitle := '商盟档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_UNION_INDEX';
  n^.keyFields := 'TENANT_ID;UNION_ID;INDEX_ID';
  n^.synFlag := 0;
  n^.tbtitle := '商盟指标';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CLIENTINFO';
  n^.keyFields := 'TENANT_ID;CLIENT_ID';
  n^.synFlag := 0;
  n^.tbtitle := '客户档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CUSTOMER';
  n^.keyFields := 'TENANT_ID;CUST_ID';
  n^.synFlag := 0;
  n^.tbtitle := '会员档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CUSTOMER_EXT';
  n^.keyFields := 'TENANT_ID;UNION_ID;CUST_ID;INDEX_ID';
  n^.synFlag := 0;
  n^.tbtitle := '会员档案';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_IC_INFO';
  n^.keyFields := 'TENANT_ID;UNION_ID;IC_CARDNO';
  n^.synFlag := 0;
  n^.tbtitle := 'IC档案';
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

procedure TSyncFactory.SyncAll;
var
  i:integer;
begin
  frmLogo.Show;
  try
  SyncFactory.InitList;
  frmLogo.ProgressBar1.Max := FList.Count;
  for i:=0 to FList.Count -1 do
    begin
      frmLogo.Label1.Caption := '正在同步<'+PSynTableInfo(FList[i])^.tbtitle+'>...';
      frmLogo.Label1.Update;
      case PSynTableInfo(FList[i])^.synFlag of
      0,1,2,3:SyncSingleTable(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])));
      end;
      frmLogo.ProgressBar1.Position := i;
    end;
  finally
    frmLogo.Close;
  end;
end;

procedure TSyncFactory.SyncSingleTable(tbName, KeyFields,ZClassName: string);
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
    cs.Close;
    rs.Close;
    Global.RemoteFactory.Open(rs,ZClassName,Params);
    cs.SyncDelta := rs.SyncDelta;
    Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
  finally
    rs.Free;
    cs.Free;
  end;
  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    //上传本机数据
    cs.Close;
    rs.Close;
    Global.LocalFactory.Open(cs,ZClassName,Params);
    rs.SyncDelta := cs.SyncDelta;
    Global.RemoteFactory.UpdateBatch(rs,ZClassName,Params);
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
