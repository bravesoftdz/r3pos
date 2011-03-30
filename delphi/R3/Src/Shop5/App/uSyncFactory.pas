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

    function GetSynTimeStamp(tbName:string;SHOP_ID:string='#'):int64;
    procedure SetSynTimeStamp(tbName:string;TimeStamp:int64;SHOP_ID:string='#');
    //双同同步
    procedure SyncSingleTable(tbName,KeyFields,ZClassName:string);
    //同步入库类单据
    procedure SyncStockOrder(tbName,KeyFields,ZClassName:string);
    //同步出库类单据
    procedure SyncSalesOrder(tbName,KeyFields,ZClassName:string);
    //同步库存类单据
    procedure SyncChangeOrder(tbName,KeyFields,ZClassName:string);
    //进货订单单据
    procedure SyncStkIndentOrder(tbName,KeyFields,ZClassName:string);
    //销售订单单据
    procedure SyncSalIndentOrder(tbName,KeyFields,ZClassName:string);
    //开始同步数据
    procedure SyncAll;
    //开始基础数据
    procedure SyncBasic;

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
  4:result := 'TSyncPubIcInfo';
  5:result := 'TSyncStockOrderList';
  6:result := 'TSyncSalesOrderList';
  7:result := 'TSyncChangeOrderList';
  8:result := 'TSyncStkIndentOrderList';
  9:result := 'TSyncSalIndentOrderList';
  10:result := 'TSyncAccountInfo';
  else
    result := 'TSyncSingleTable';
  end;
end;

function TSyncFactory.GetSynTimeStamp(tbName: string;SHOP_ID:string='#'): int64;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
    rs.ParambyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
    rs.ParamByName('TABLE_NAME').AsString := tbName;
    Global.LocalFactory.Open(rs);
    if rs.IsEmpty then result := 0 else result := rs.Fields[0].Value;
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
  n^.tbname := 'SYS_DEFINE';
  n^.keyFields := 'TENANT_ID;DEFINE';
  n^.synFlag := 0;
  n^.tbtitle := '参数定义表';
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
  n^.synFlag := 4;
  n^.tbtitle := 'IC档案';
  FList.Add(n);

  new(n);
  n^.tbname := 'PUB_GOODSPRICE';
  n^.keyFields := 'TENANT_ID;GODS_ID;SHOP_ID;PRICE_ID';
  n^.synFlag := 0;
  n^.tbtitle := '最新售价';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSINFOEXT';
  n^.keyFields := 'TENANT_ID;GODS_ID';
  n^.synFlag := 0;
  n^.tbtitle := '最新进价';
  FList.Add(n);
  new(n);
  n^.tbname := 'LOG_PRICING_INFO';
  n^.keyFields := 'ROWS_ID';
  n^.synFlag := 0;
  n^.tbtitle := '变价日志';
  FList.Add(n);
  
  new(n);
  n^.tbname := 'ACC_ACCOUNT_INFO';
  n^.keyFields := 'TENANT_ID;ACCOUNT_ID';
  n^.synFlag := 10;
  n^.tbtitle := '账户资料';
  FList.Add(n);

  //同步业务数据
  new(n);
  n^.tbname := 'STK_STOCKORDER';
  n^.keyFields := 'TENANT_ID;STOCK_ID';
  n^.synFlag := 5;
  n^.tbtitle := '入库单据';
  FList.Add(n);
  
  new(n);
  n^.tbname := 'SAL_SALESORDER';
  n^.keyFields := 'TENANT_ID;SALES_ID';
  n^.synFlag := 6;
  n^.tbtitle := '出库单据';
  FList.Add(n);
  
  new(n);
  n^.tbname := 'STO_CHANGEORDER';
  n^.keyFields := 'TENANT_ID;CHANGE_ID';
  n^.synFlag := 7;
  n^.tbtitle := '存货单据';
  FList.Add(n);

  new(n);
  n^.tbname := 'STK_INDENTORDER';
  n^.keyFields := 'TENANT_ID;INDE_ID';
  n^.synFlag := 8;
  n^.tbtitle := '进货订单';
  FList.Add(n);

  new(n);
  n^.tbname := 'SAL_INDENTORDER';
  n^.keyFields := 'TENANT_ID;INDE_ID';
  n^.synFlag := 9;
  n^.tbtitle := '销售订单';
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

procedure TSyncFactory.SetSynTimeStamp(tbName: string; TimeStamp: int64;SHOP_ID:string='#');
var
  r:integer;
begin
  r := Global.LocalFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+'''');
  if r=0 then
     Global.LocalFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+inttostr(Global.TENANT_ID)+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
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
      0,1,2,3,4,10:SyncSingleTable(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])));
      5:SyncStockOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])));
      6:SyncSalesOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])));
      7:SyncChangeOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])));
      8:SyncStkIndentOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])));
      9:SyncSalIndentOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])));
      end;
      frmLogo.ProgressBar1.Position := i;
    end;
  finally
    frmLogo.Close;
  end;
end;

procedure TSyncFactory.SyncBasic;
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
      0,1,2,3,4,10:SyncSingleTable(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])));
      end;
      frmLogo.ProgressBar1.Position := i;
    end;
  finally
    frmLogo.Close;
  end;
end;

procedure TSyncFactory.SyncChangeOrder(tbName, KeyFields,
  ZClassName: string);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         //以服务器为优先下载
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('CHANGE_ID').AsString := ls.FieldbyName('CHANGE_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncChangeOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncChangeData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncChangeOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncChangeData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //下传
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('CHANGE_ID').AsString := ls.FieldbyName('CHANGE_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncChangeOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncChangeData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncChangeOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncChangeData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncSalesOrder(tbName, KeyFields,
  ZClassName: string);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         //以服务器为优先下载
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('SALES_ID').AsString := ls.FieldbyName('SALES_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncSalesOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncSalesData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncSalesOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncSalesData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //下传
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('SALES_ID').AsString := ls.FieldbyName('SALES_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncSalesOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncSalesData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncSalesOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncSalesData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncSalIndentOrder(tbName, KeyFields,
  ZClassName: string);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         //以服务器为优先下载
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('INDE_ID').AsString := ls.FieldbyName('INDE_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncSalIndentOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncSalIndentData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncSalIndentOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncSalIndentData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //下传
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('INDE_ID').AsString := ls.FieldbyName('INDE_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncSalIndentOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncSalIndentData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncSalIndentOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncSalIndentData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
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
    Global.LocalFactory.BeginTrans;
    try
      Global.LocalFactory.Open(cs,ZClassName,Params);
      if not cs.IsEmpty then
      begin
        rs.SyncDelta := cs.SyncDelta;
        cs.Delete;
        Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);

        SetSynTimeStamp(tbName,SyncTimeStamp);
        Global.RemoteFactory.UpdateBatch(rs,ZClassName,Params);
      end;
      Global.LocalFactory.CommitTrans;
    except
      Global.LocalFactory.RollbackTrans;
      Raise;
    end;
  finally
    rs.Free;
    cs.Free;
  end;
end;

procedure TSyncFactory.SyncStkIndentOrder(tbName, KeyFields,
  ZClassName: string);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         //以服务器为优先下载
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('INDE_ID').AsString := ls.FieldbyName('INDE_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncStkIndentOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncStkIndentData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncStkIndentOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncStkIndentData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //下传
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('INDE_ID').AsString := ls.FieldbyName('INDE_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncStkIndentOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncStkIndentData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncStkIndentOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncStkIndentData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncStockOrder(tbName,KeyFields,ZClassName:string);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         //以服务器为优先下载
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('STOCK_ID').AsString := ls.FieldbyName('STOCK_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncStockOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncStockData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncStockOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncStockData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //下传
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    ls.First;
    while not ls.Eof do
       begin
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('STOCK_ID').AsString := ls.FieldbyName('STOCK_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncStockOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncStockData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncStockOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncStockData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

initialization
  SyncFactory := TSyncFactory.Create;
finalization
  SyncFactory.Free;
end.
