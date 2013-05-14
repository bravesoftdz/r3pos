unit uSyncFactory;

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase, ObjCommon, ZLogFile,
  Dialogs, DB, uFnUtil, math;

const
  MSC_SET_MAX=WM_USER+1;
  MSC_SET_POSITION=WM_USER+2;
  MSC_SET_CAPTION=WM_USER+3;
  MSC_SET_CLOSE=WM_USER+4;

type
  PSynTableInfo=^TSynTableInfo;

  TSynTableInfo=record
    tbName:string;//表名
    tbTitle:string;//说明
    keyFields:string;//关健字段
    tableFields:string;//同步字段
    selectLocalSQL:string;//本地openSQL，用于上传下载SQL不一致的情况
    selectRemoteSQL:string;//服务端openSQL，用于上传下载SQL不一致的情况
    selectSQL:string;//默认openSQL
    whereStr:string;//where条件
    synFlag:integer;
    keyFlag:integer; //0是按表结构关健字 1是按业务关健字
    syncTenantId:string;//时间戳控制TENANT_ID
    syncShopId:string;//时间戳控制SHOP_ID
    isSyncUp:string;//是否上传
    isSyncDown:string;//是否下载
  end;

  TSyncFactory=class
  protected
    _Start:Int64;
    FList:TList;
    FStoped: boolean;
    FProHandle:Hwnd;
    FProTitle:string;
    FSyncTimeStamp: int64;
    FParams: TftParamList;
    FinishIndex:integer;
    procedure SetTicket;
    function  GetTicket:Int64;
    procedure ClearSyncList;
    procedure ReadTimeStamp;
    function  GetFactoryName(node:PSynTableInfo):string;
    function  GetTableFields(tbName:string;alias:string=''):string;

    procedure SetParams(const Value: TftParamList);
    procedure SetSyncTimeStamp(const Value: int64);
    procedure SetStoped(const Value: boolean);
    procedure SetProHandle(const Value: Hwnd);
    procedure SetProTitle(const Value: string);
    procedure SetProCaption;
    procedure SetProMax(max:integer);
    procedure SetProPosition(position:integer);
  private
    CloseAccDate:integer;
    LoginSyncDate:integer;
    LastLoginSyncDate,LastLogoutSyncDate:integer;
    procedure InitTenant;
    procedure InitSyncList1;
    procedure InitSyncList;
    procedure SyncList;
    procedure SyncBasic;
    procedure SyncBizData(SyncFlag:integer=0;BeginDate:string='');
    procedure SyncSingleTable(n:PSynTableInfo;timeStampNoChg:integer=1);
    procedure BeforeSyncBiz(DataSet:TZQuery;FieldName:string;SyncFlag:integer);
    procedure SyncStockOrder(SyncFlag:integer=0;BeginDate:string='');// 0:上传 1:下载
    procedure SyncSalesOrder(SyncFlag:integer=0;BeginDate:string='');
    procedure SyncChangeOrder(SyncFlag:integer=0;BeginDate:string='');
    procedure SyncRckDays(SyncFlag:integer=0;BeginDate:string='');
    procedure GetCloseAccDate;
    function  CheckNeedLoginSync:boolean;
    function  CheckNeedLoginSyncBizData:boolean;
  public
    constructor Create;
    destructor  Destroy;override;
    // 登录时同步
    procedure LoginSync(PHWnd:THandle);
    // 退出时同步
    procedure LogoutSync(PHWnd:THandle);
    // 数据恢复时同步
    procedure RecoverySync(PHWnd:THandle;BeginDate:string='');
    // 注册时同步
    procedure RegisterSync(PHWnd:THandle);
    // 灾难恢复时关账
    procedure RecoveryClose(CloseDate:string);
    function  GetSynTimeStamp(tenantId,tbName:string;SHOP_ID:string='#'):int64;
    procedure SetSynTimeStamp(tenantId,tbName:string;TimeStamp:int64;SHOP_ID:string='#');
    property  Params:TftParamList read FParams write SetParams;
    property  SyncTimeStamp:int64 read FSyncTimeStamp write SetSyncTimeStamp;
    property  Stoped:boolean read FStoped write SetStoped;
    property  ProHandle:Hwnd read FProHandle write SetProHandle;
    property  ProTitle:string read FProTitle write SetProTitle;
  end; 

var SyncFactory:TSyncFactory;

implementation

uses udllDsUtil,udllGlobal,uTokenFactory,udataFactory,IniFiles,ufrmSyncData,uRspSyncFactory,
     uRightsFactory,dllApi,ufrmSysDefine,uRtcSyncFactory;

constructor TSyncFactory.Create;
begin
  CloseAccDate := -1;
  LoginSyncDate := 0;
  LastLoginSyncDate := 0;
  LastLogoutSyncDate := 0;
  FParams := TftParamList.Create(nil);
  FList := TList.Create;
end;

destructor TSyncFactory.Destroy;
var i:integer;
begin
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Free;
  FParams.Free;
  inherited;
end;

function TSyncFactory.GetFactoryName(node: PSynTableInfo): string;
begin
  result := 'TSyncSingleTableV60';
end;

function TSyncFactory.GetTicket:int64;
begin
  result := GetTickCount - _Start;
end;

procedure TSyncFactory.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

procedure TSyncFactory.SetSyncTimeStamp(const Value: int64);
begin
  FSyncTimeStamp := Value;
end;

procedure TSyncFactory.SetTicket;
begin
  _Start := GetTickCount;
end;

procedure TSyncFactory.ReadTimeStamp;
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    if not (dataFactory.iDbType = 5) then
      begin
        try
          dataFactory.MoveToSqlite;
          dataFactory.ExecProc('TGetSyncTimeStamp',Params);
        finally
          dataFactory.MoveToDefault;
        end;
      end;
    dataFactory.ExecProc('TGetSyncTimeStamp',Params);
  finally
    Params.free;
  end;
end;

function TSyncFactory.GetSynTimeStamp(tenantId,tbName:string;SHOP_ID:string='#'):int64;
var rs:TZQuery;
begin
  if SHOP_ID='' then SHOP_ID:='#';
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
    rs.ParambyName('TENANT_ID').AsInteger := strtoint(tenantId);
    rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
    rs.ParamByName('TABLE_NAME').AsString := tbName;
    dataFactory.MoveToSqlite;
    try
      dataFactory.Open(rs);
    finally
      dataFactory.MoveToDefault;
    end;
    if rs.IsEmpty then result := 5497000 else result := rs.Fields[0].Value;
  finally
    rs.Free;
  end;
end;

procedure TSyncFactory.SetSynTimeStamp(tenantId,tbName:string;TimeStamp:int64;SHOP_ID:string='#');
var
  r:integer;
  rs:TZQuery;
begin
  if SHOP_ID='' then SHOP_ID:='#';
  try
    dataFactory.MoveToSqlite;
    r := dataFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+tenantId+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+'''');
    if r=0 then
      dataFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+tenantId+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
  finally
    dataFactory.MoveToDefault;
  end;

  //更新服务端时间戳
  rs := TZQuery.Create(nil);
  dataFactory.MoveToRemote;
  try
    r := dataFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+token.tenantId+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+''' and TIME_STAMP<'+inttostr(TimeStamp));
    if r=0 then
      begin
        rs.SQL.Text := 'select 1 from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
        rs.Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
        rs.Params.ParamByName('SHOP_ID').AsString := SHOP_ID;
        rs.Params.ParamByName('TABLE_NAME').AsString := tbName;
        dataFactory.Open(rs);
        if rs.IsEmpty then
          dataFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+token.tenantId+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
      end;
  finally
    rs.Free;
    dataFactory.MoveToDefault;
  end;
end;

function TSyncFactory.GetTableFields(tbName:string;alias:string=''):string;
var
  ls:TZQuery;
  i:integer;
  selectFields:string;
begin
  ls := TZQuery.Create(nil);
  try
    ls.SQL.Text := 'select * from '+tbName+' limit 1';
    dllGlobal.OpenSqlite(ls);
    for i:=0 to ls.FieldList.Count - 1 do
      begin
        if selectFields<>'' then selectFields := selectFields + ',';
        if alias = '' then
           selectFields := selectFields + ls.FieldList.Fields[i].FieldName
        else
           selectFields := selectFields + alias + '.' + ls.FieldList.Fields[i].FieldName
      end;
    result := selectFields;
  finally
    ls.Free;
  end;
end;

procedure TSyncFactory.SyncSingleTable(n:PSynTableInfo;timeStampNoChg:integer=1);
  procedure UploadSingleTable(rs_l:TZQuery;ZClassName:string;n:PSynTableInfo);
  var ss:TZQuery;
  begin
    ss := TZQuery.Create(nil);
    try
      ss.Close;
      if not rs_l.IsEmpty then
         begin
           SetTicket;
           ss.SyncDelta := rs_l.SyncDelta;
           if not ss.IsEmpty then
              begin
                dataFactory.MoveToRemote;
                try
                  dataFactory.UpdateBatch(ss,ZClassName,Params);
                finally
                  dataFactory.MoveToDefault;
                end;
              end;

           rs_l.Delete;
           dataFactory.MoveToSqlite;
           try
             dataFactory.UpdateBatch(rs_l,ZClassName,Params);
           finally
             dataFactory.MoveToDefault;
           end;

           LogFile.AddLogFile(0,'上传<'+n^.tbName+'><'+n^.syncTenantId+' '+n^.syncShopId+'>保存时长:'+inttostr(GetTicket));
         end;
    finally
      ss.Free;
    end;
  end;

  procedure DownloadSingleTable(rs_r:TZQuery;ZClassName:string;n:PSynTableInfo);
  var ss:TZQuery;
  begin
    ss := TZQuery.Create(nil);
    try
      ss.Close;
      if not rs_r.IsEmpty then
         begin
           SetTicket;
           ss.SyncDelta := rs_r.SyncDelta;
           if not ss.IsEmpty then
              begin
                dataFactory.MoveToSqlite;
                try
                  dataFactory.UpdateBatch(ss,ZClassName,Params);
                finally
                  dataFactory.MoveToDefault;
                end;
              end;
           LogFile.AddLogFile(0,'下载<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>保存时长:'+inttostr(GetTicket));
         end;
    finally
      ss.Free;
    end;
  end;
var
  SFVersion:string;
  rs_l,rs_r:TZQuery;
  LCLVersion:boolean;
  MaxTimeStamp:int64;
  ZClassName:string;
  openSQL:string;
begin
  SFVersion := dllGlobal.GetSFVersion;
  LCLVersion := (SFVersion = '.LCL');

  if trim(n^.syncTenantId) = '' then n^.syncTenantId := token.tenantId;
  if trim(n^.syncShopId) = '' then n^.syncShopId := '#';

  ZClassName := GetFactoryName(n);
  SyncTimeStamp := GetSynTimeStamp(n^.syncTenantId,n^.tbName,n^.syncShopId);
  MaxTimeStamp := SyncTimeStamp;

  Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  Params.ParamByName('SHOP_ID').AsString := token.shopId;
  Params.ParamByName('KEY_FLAG').AsInteger := n^.keyFlag;
  Params.ParamByName('TABLE_NAME').AsString := n^.tbName;
  Params.ParamByName('KEY_FIELDS').AsString := n^.keyFields;
  Params.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := timeStampNoChg;
  Params.ParamByName('WHERE_STR').AsString := n^.whereStr;
  if trim(n^.tableFields) <> '' then
     Params.ParamByName('TABLE_FIELDS').AsString := n^.tableFields
  else
     Params.ParamByName('TABLE_FIELDS').AsString := GetTableFields(n^.tbName);

  rs_l := TZQuery.Create(nil);
  rs_r := TZQuery.Create(nil);
  try
    rs_l.Close;
    rs_r.Close;

    if n^.isSyncUp = '1' then
       begin
         LogFile.AddLogFile(0,'开始上传<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>上次时间:'+Params.ParamByName('TIME_STAMP').AsString+'  本次时间:'+inttostr(SyncTimeStamp));
         Params.ParamByName('SYN_COMM').AsBoolean := false;
         SetTicket;
         dataFactory.MoveToSqlite;
         try
           if (trim(n^.selectSQL) = '') and (trim(n^.selectLocalSQL) = '') then
              dataFactory.Open(rs_l,ZClassName,Params)
           else
             begin
               if trim(n^.selectLocalSQL) <> '' then
                  openSQL := n^.selectLocalSQL
               else
                  openSQL := n^.selectSQL;
               rs_l.SQL.Text := openSQL;
               rs_l.Params := Params;
               dataFactory.Open(rs_l);
             end;
         finally
           dataFactory.MoveToDefault;
         end;
         LogFile.AddLogFile(0,'上传<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(rs_l.RecordCount));

         if not rs_l.IsEmpty then
            begin
              rs_l.Last;
              if StrtoInt64(rs_l.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
                 MaxTimeStamp := StrtoInt64(rs_l.FieldByName('TIME_STAMP').AsString);
            end;
       end;

    if n^.isSyncDown = '1' then
       begin
         LogFile.AddLogFile(0,'开始下载<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>上次时间:'+Params.ParamByName('TIME_STAMP').AsString+'  本次时间:'+inttostr(SyncTimeStamp));
         Params.ParamByName('SYN_COMM').AsBoolean := false;
         SetTicket;
         dataFactory.MoveToRemote;
         try
           if (trim(n^.selectSQL) = '') and (trim(n^.selectRemoteSQL) = '') then
              dataFactory.Open(rs_r,ZClassName,Params)
           else
             begin
               if trim(n^.selectRemoteSQL) <> '' then
                  openSQL := n^.selectRemoteSQL
               else
                  openSQL := n^.selectSQL;
               rs_r.SQL.Text := openSQL;
               rs_r.Params := Params;
               dataFactory.Open(rs_r);
             end;
         finally
           dataFactory.MoveToDefault;
         end;
         LogFile.AddLogFile(0,'下载<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(rs_r.RecordCount));

         if not rs_r.IsEmpty then
            begin
              rs_r.Last;
              if StrtoInt64(rs_r.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
                 MaxTimeStamp := StrtoInt64(rs_r.FieldByName('TIME_STAMP').AsString);
            end;
       end;

     if LCLVersion then
        begin
          if n^.isSyncUp = '1' then
             begin
               UploadSingleTable(rs_l,ZClassName,n);
               SetProPosition(FinishIndex * 100 + 50);
             end;
          if n^.isSyncDown = '1' then
             begin
               DownloadSingleTable(rs_r,ZClassName,n);
               SetProPosition(FinishIndex * 100 + 100);
             end;
        end
     else
        begin
          if n^.isSyncDown = '1' then
             begin
               DownloadSingleTable(rs_r,ZClassName,n);
               SetProPosition(FinishIndex * 100 + 50);
             end;
          if n^.isSyncUp = '1' then
             begin
               UploadSingleTable(rs_l,ZClassName,n);
               SetProPosition(FinishIndex * 100 + 100);
             end;
        end;

    if MaxTimeStamp > SyncTimeStamp then
       SetSynTimeStamp(n^.syncTenantId,n^.tbName,MaxTimeStamp,n^.syncShopId);
  finally
    rs_l.Free;
    rs_r.Free;
  end;
end;

procedure TSyncFactory.SetStoped(const Value: boolean);
begin
  FStoped := Value;
end;

procedure TSyncFactory.SyncList;
var i:integer;
begin
  SetProMax(FList.Count * 100);
  FinishIndex := 0;
  SetProPosition(0);
  for i:=0 to FList.Count -1 do
  begin
    case PSynTableInfo(FList[i])^.synFlag of
    0,1,2,3,4,10,20,21,22,23,29:
      begin
        ProTitle := '正在同步<'+PSynTableInfo(FList[i])^.tbtitle+'>...';
        SyncSingleTable(FList[i]);
        inc(FinishIndex);
        SetProPosition(FinishIndex * 100);
      end;
    end;
  end;
end;

procedure TSyncFactory.SyncBasic;
begin
  try
    InitSyncList1;
    SyncList;
    dllGlobal.GetZQueryFromName('CA_RELATIONS').Close;

    InitSyncList;
    SyncList;
  finally
    ReadTimeStamp;
  end
end;

procedure TSyncFactory.ClearSyncList;
var i:integer;
begin
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Clear;
end;

procedure TSyncFactory.InitSyncList1;
var n:PSynTableInfo;
begin
  ClearSyncList;

  new(n);
  n^.tbname := 'CA_RELATIONS';
  n^.keyFields := 'RELATION_ID;RELATI_ID';
  n^.whereStr := '(TENANT_ID = :TENANT_ID or RELATI_ID = :TENANT_ID) and TIME_STAMP > :TIME_STAMP';
  n^.synFlag := 1;
  n^.keyFlag := 1;
  n^.tbtitle := '供应关系';
  n^.isSyncUp := '1';
  n^.isSyncDown := '1';
  FList.Add(n);
end;

procedure TSyncFactory.InitSyncList;
  procedure InitList0;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'CA_SHOP_INFO';
    n^.keyFields := 'TENANT_ID;SHOP_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '门店资料';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_DEPT_INFO';
    n^.keyFields := 'TENANT_ID;DEPT_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '部门资料';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_DUTY_INFO';
    n^.keyFields := 'TENANT_ID;DUTY_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '职务资料';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_ROLE_INFO';
    n^.keyFields := 'TENANT_ID;ROLE_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '角色资料';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_USERS';
    n^.keyFields := 'TENANT_ID;USER_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '用户资料';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_RIGHTS';
    n^.keyFields := 'TENANT_ID;MODU_ID;ROLE_ID;ROLE_TYPE';
    n^.synFlag := 0;
    n^.keyFlag := 1;
    n^.tbtitle := '操作权限';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_PRICEGRADE';
    n^.keyFields := 'TENANT_ID;PRICE_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '客户等级';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_UNION_INFO';
    n^.keyFields := 'TENANT_ID;UNION_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '商盟档案';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_UNION_INDEX';
    n^.keyFields := 'TENANT_ID;UNION_ID;INDEX_ID';
    n^.keyFlag := 0;
    n^.synFlag := 0;
    n^.tbtitle := '商盟指标';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CLIENTINFO';
    n^.keyFields := 'TENANT_ID;CLIENT_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '客户档案';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CUSTOMER';
    n^.keyFields := 'TENANT_ID;CUST_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '会员档案';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CUSTOMER_EXT';
    n^.keyFields := 'TENANT_ID;UNION_ID;CUST_ID;INDEX_ID';
    n^.synFlag := 0;
    n^.keyFlag := 1;
    n^.tbtitle := '会员档案';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_GOODSINFOEXT';
    n^.keyFields := 'TENANT_ID;GODS_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '最新进价';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList00;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_GOODSPRICE';
    n^.keyFields := 'TENANT_ID;GODS_ID;SHOP_ID;PRICE_ID';
    n^.whereStr := 'TENANT_ID=:TENANT_ID and (SHOP_ID=:SHOP_ID or SHOP_ID='''+token.tenantId+'0001'') and TIME_STAMP>:TIME_STAMP';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.syncShopId := token.shopId;
    n^.tbtitle := '最新售价';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList2(whereStr:string;syncTenantId:string);
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'CA_RELATION';
    n^.keyFields := 'TENANT_ID;RELATION_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '供应链';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CODE_INFO';
    n^.keyFields := 'TENANT_ID;CODE_ID;CODE_TYPE';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '其他编码';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_GOODSSORT';
    n^.keyFields := 'TENANT_ID;SORT_ID;SORT_TYPE';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '货品分类';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_COLOR_INFO';
    n^.keyFields := 'TENANT_ID;COLOR_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '颜色档案';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_SIZE_INFO';
    n^.keyFields := 'TENANT_ID;SIZE_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '尺码档案';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_MEAUNITS';
    n^.keyFields := 'TENANT_ID;UNIT_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '计量单位';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList3;
  var n:PSynTableInfo;
      str_l,str_r:string;
  begin
    str_l :=
      'select b.ROWS_ID,b.TENANT_ID,b.GODS_ID,b.PROPERTY_01,b.PROPERTY_02,b.UNIT_ID,b.BARCODE_TYPE,b.BATCH_NO,b.BARCODE,b.COMM,b.TIME_STAMP '+
      'from   PUB_BARCODE b '+
      'where  TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP ';

    str_r :=
      'select b.ROWS_ID,b.TENANT_ID,b.GODS_ID,b.PROPERTY_01,b.PROPERTY_02,b.UNIT_ID,b.BARCODE_TYPE,b.BATCH_NO,b.BARCODE,b.COMM,b.TIME_STAMP '+
      'from   PUB_BARCODE b '+
      'where  TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+
      'union all '+
      'select b.ROWS_ID,b.TENANT_ID,b.GODS_ID,b.PROPERTY_01,b.PROPERTY_02,b.UNIT_ID,b.BARCODE_TYPE,b.BATCH_NO,b.BARCODE,b.COMM, '+
      '       case '+
      '         when b.TIME_STAMP >= c.TIME_STAMP and b.TIME_STAMP >= s.TIME_STAMP then b.TIME_STAMP '+
      '         when c.TIME_STAMP >= b.TIME_STAMP and c.TIME_STAMP >= s.TIME_STAMP then c.TIME_STAMP '+
      '         when s.TIME_STAMP >= b.TIME_STAMP and s.TIME_STAMP >= c.TIME_STAMP then s.TIME_STAMP '+
      '         else b.TIME_STAMP '+
      '       end TIME_STAMP '+
      'from   PUB_BARCODE b,PUB_GOODS_RELATION c,CA_RELATION j,CA_RELATIONS s '+
      'where  b.TENANT_ID=j.TENANT_ID '+
      '       and b.GODS_ID=c.GODS_ID '+
      '       and c.RELATION_ID=j.RELATION_ID '+
      '       and c.RELATION_ID=s.RELATION_ID '+
      '       and j.RELATION_ID=s.RELATION_ID '+
      '       and '+
      '       ( '+
      '        (c.TENANT_ID=s.TENANT_ID and s.RELATION_TYPE<>''1'') '+
      '         or '+
      '        (c.TENANT_ID=s.RELATI_ID and s.RELATION_TYPE=''1'') '+
      '       ) '+
      '       and s.RELATI_ID=:TENANT_ID '+
      '       and (b.TIME_STAMP>:TIME_STAMP or c.TIME_STAMP>:TIME_STAMP or s.TIME_STAMP>:TIME_STAMP) ';
    new(n);
    n^.tbname := 'PUB_BARCODE';
    n^.keyFields := 'ROWS_ID';
    n^.selectLocalSQL := str_l;
    n^.selectRemoteSQL := str_r;
    n^.synFlag := 3;
    n^.keyFlag := 0;
    n^.tbtitle := '条码表';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList4;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_IC_INFO';
    n^.keyFields := 'TENANT_ID;UNION_ID;CLIENT_ID';
    n^.tableFields := 'CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,PASSWRD,USING_DATE,COMM,TIME_STAMP';
    n^.synFlag := 4;
    n^.keyFlag := 1;
    n^.tbtitle := 'IC档案';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList10;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'ACC_ACCOUNT_INFO';
    n^.keyFields := 'TENANT_ID;ACCOUNT_ID';
    n^.tableFields := 'TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,COMM,TIME_STAMP';
    n^.synFlag := 10;
    n^.keyFlag := 0;
    n^.tbtitle := '账户资料';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList20;
  var n:PSynTableInfo;
      str_l,str_r:string;
  begin
    str_l :=
      'select  i.TENANT_ID,i.LOGIN_NAME,i.LICENSE_CODE,i.TENANT_NAME,i.TENANT_TYPE,i.SHORT_TENANT_NAME,i.TENANT_SPELL,i.LEGAL_REPR, '+
      '        i.LINKMAN,i.TELEPHONE,i.FAXES,i.HOMEPAGE,i.ADDRESS,i.QQ,i.MSN,i.POSTALCODE,i.REMARK,i.PASSWRD,i.REGION_ID,i.SRVR_ID, '+
      '        i.AUDIT_STATUS,i.PROD_ID,i.DB_ID,i.CREA_DATE,i.COMM,i.TIME_STAMP '+
      'from    CA_TENANT i '+
      'where   TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP ';

    str_r :=
      'select  i.TENANT_ID,i.LOGIN_NAME,i.LICENSE_CODE,i.TENANT_NAME,i.TENANT_TYPE,i.SHORT_TENANT_NAME,i.TENANT_SPELL,i.LEGAL_REPR, '+
      '        i.LINKMAN,i.TELEPHONE,i.FAXES,i.HOMEPAGE,i.ADDRESS,i.QQ,i.MSN,i.POSTALCODE,i.REMARK,i.PASSWRD,i.REGION_ID,i.SRVR_ID, '+
      '        i.AUDIT_STATUS,i.PROD_ID,i.DB_ID,i.CREA_DATE,i.COMM, '+
      '        case when i.TIME_STAMP > r.TIME_STAMP then i.TIME_STAMP else r.TIME_STAMP end TIME_STAMP '+
      'from    CA_TENANT i, '+
      '        ( '+
      '        select j.TENANT_ID as TENANT_ID,s.TIME_STAMP as TIME_STAMP from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID '+
      '        union all '+
      '        select TENANT_ID,TIME_STAMP from CA_RELATIONS s where s.RELATI_ID=:TENANT_ID '+
      '        union all '+
      '        select RELATI_ID as TENANT_ID,TIME_STAMP from CA_RELATIONS s where s.TENANT_ID=:TENANT_ID '+
      '        ) r '+
      'where   i.TENANT_ID=r.TENANT_ID and (i.TIME_STAMP>:TIME_STAMP or r.TIME_STAMP>:TIME_STAMP) '+
      'union all '+
      'select  i.TENANT_ID,i.LOGIN_NAME,i.LICENSE_CODE,i.TENANT_NAME,i.TENANT_TYPE,i.SHORT_TENANT_NAME,i.TENANT_SPELL,i.LEGAL_REPR, '+
      '        i.LINKMAN,i.TELEPHONE,i.FAXES,i.HOMEPAGE,i.ADDRESS,i.QQ,i.MSN,i.POSTALCODE,i.REMARK,i.PASSWRD,i.REGION_ID,i.SRVR_ID, '+
      '        i.AUDIT_STATUS,i.PROD_ID,i.DB_ID,i.CREA_DATE,i.COMM,i.TIME_STAMP '+
      'from    CA_TENANT i '+
      'where   TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP ';
    new(n);
    n^.tbname := 'CA_TENANT';
    n^.keyFields := 'TENANT_ID';
    n^.selectLocalSQL := str_l;
    n^.selectRemoteSQL := str_r;
    n^.synFlag := 20;
    n^.keyFlag := 0;
    n^.tbtitle := '企业资料';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList21(whereStr:string;syncTenantId,SyncUp,SyncDown:string);
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_GOODS_RELATION';
    n^.keyFields := 'TENANT_ID;GODS_ID;RELATION_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 21;
    n^.keyFlag := 1;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '供应链商品';
    n^.isSyncUp := SyncUp;
    n^.isSyncDown := SyncDown;
    FList.Add(n);
  end;

  procedure InitList22;
  var n:PSynTableInfo;
      str_l,str_r:string;
  begin
     str_l :=
      'select b.GODS_ID,b.TENANT_ID,b.GODS_CODE,b.GODS_NAME,b.GODS_SPELL,b.GODS_TYPE,b.SORT_ID1, '+
      '       b.SORT_ID2,b.SORT_ID3,b.SORT_ID4,b.SORT_ID5,b.SORT_ID6,b.SORT_ID7,b.SORT_ID8,b.SORT_ID9, '+
      '       b.SORT_ID10,b.SORT_ID11,b.SORT_ID12,b.SORT_ID13,b.SORT_ID14,b.SORT_ID15,b.SORT_ID16,b.SORT_ID17, '+
      '       b.SORT_ID18,b.SORT_ID19,b.SORT_ID20,b.BARCODE,b.UNIT_ID,b.CALC_UNITS,b.SMALL_UNITS,b.BIG_UNITS, '+
      '       b.SMALLTO_CALC,b.BIGTO_CALC,b.NEW_INPRICE,b.NEW_OUTPRICE,b.NEW_LOWPRICE,b.USING_PRICE,b.HAS_INTEGRAL, '+
      '       b.USING_BATCH_NO,b.USING_BARTER,b.USING_LOCUS_NO,b.BARTER_INTEGRAL,b.REMARK,b.COMM,b.TIME_STAMP, '+
      '       b.SHORT_GODS_NAME,b.CREA_DATE '+
      'from   PUB_GOODSINFO b where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP ';

     str_r :=
      'select b.GODS_ID,b.TENANT_ID,b.GODS_CODE,b.GODS_NAME,b.GODS_SPELL,b.GODS_TYPE,b.SORT_ID1, '+
      '       b.SORT_ID2,b.SORT_ID3,b.SORT_ID4,b.SORT_ID5,b.SORT_ID6,b.SORT_ID7,b.SORT_ID8,b.SORT_ID9, '+
      '       b.SORT_ID10,b.SORT_ID11,b.SORT_ID12,b.SORT_ID13,b.SORT_ID14,b.SORT_ID15,b.SORT_ID16,b.SORT_ID17, '+
      '       b.SORT_ID18,b.SORT_ID19,b.SORT_ID20,b.BARCODE,b.UNIT_ID,b.CALC_UNITS,b.SMALL_UNITS,b.BIG_UNITS, '+
      '       b.SMALLTO_CALC,b.BIGTO_CALC,b.NEW_INPRICE,b.NEW_OUTPRICE,b.NEW_LOWPRICE,b.USING_PRICE,b.HAS_INTEGRAL, '+
      '       b.USING_BATCH_NO,b.USING_BARTER,b.USING_LOCUS_NO,b.BARTER_INTEGRAL,b.REMARK,b.COMM,b.TIME_STAMP, '+
      '       b.SHORT_GODS_NAME,b.CREA_DATE '+
      'from   PUB_GOODSINFO b where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+
      'union all '+
      'select b.GODS_ID,b.TENANT_ID,b.GODS_CODE,b.GODS_NAME,b.GODS_SPELL,b.GODS_TYPE,b.SORT_ID1, '+
      '       b.SORT_ID2,b.SORT_ID3,b.SORT_ID4,b.SORT_ID5,b.SORT_ID6,b.SORT_ID7,b.SORT_ID8,b.SORT_ID9, '+
      '       b.SORT_ID10,b.SORT_ID11,b.SORT_ID12,b.SORT_ID13,b.SORT_ID14,b.SORT_ID15,b.SORT_ID16,b.SORT_ID17, '+
      '       b.SORT_ID18,b.SORT_ID19,b.SORT_ID20,b.BARCODE,b.UNIT_ID,b.CALC_UNITS,b.SMALL_UNITS,b.BIG_UNITS, '+
      '       b.SMALLTO_CALC,b.BIGTO_CALC,b.NEW_INPRICE,b.NEW_OUTPRICE,b.NEW_LOWPRICE,b.USING_PRICE,b.HAS_INTEGRAL, '+
      '       b.USING_BATCH_NO,b.USING_BARTER,b.USING_LOCUS_NO,b.BARTER_INTEGRAL,b.REMARK,b.COMM, '+
      '       case '+
      '         when b.TIME_STAMP >= c.TIME_STAMP and b.TIME_STAMP >= s.TIME_STAMP then b.TIME_STAMP '+
      '         when c.TIME_STAMP >= b.TIME_STAMP and c.TIME_STAMP >= s.TIME_STAMP then c.TIME_STAMP '+
      '         when s.TIME_STAMP >= b.TIME_STAMP and s.TIME_STAMP >= c.TIME_STAMP then s.TIME_STAMP '+
      '         else b.TIME_STAMP '+
      '       end TIME_STAMP, '+
      '       b.SHORT_GODS_NAME,b.CREA_DATE '+
      'from   PUB_GOODSINFO b,PUB_GOODS_RELATION c,CA_RELATION j,CA_RELATIONS s '+
      'where  b.TENANT_ID=j.TENANT_ID '+
      '       and b.GODS_ID=c.GODS_ID '+
      '       and c.RELATION_ID=j.RELATION_ID '+
      '       and c.RELATION_ID=s.RELATION_ID '+
      '       and j.RELATION_ID=s.RELATION_ID '+
      '       and '+
      '       ( '+
      '        (c.TENANT_ID=s.TENANT_ID and s.RELATION_TYPE<>''1'') '+
      '         or '+
      '        (c.TENANT_ID=s.RELATI_ID and s.RELATION_TYPE=''1'') '+
      '       ) '+
      '       and s.RELATI_ID=:TENANT_ID '+
      '       and (b.TIME_STAMP>:TIME_STAMP or c.TIME_STAMP>:TIME_STAMP or s.TIME_STAMP>:TIME_STAMP)';
    new(n);
    n^.tbname := 'PUB_GOODSINFO';
    n^.keyFields := 'TENANT_ID;GODS_ID';
    n^.selectLocalSQL := str_l;
    n^.selectRemoteSQL := str_r;
    n^.synFlag := 22;
    n^.keyFlag := 0;
    n^.tbtitle := '商品档案';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList23;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'SYS_SEQUENCE';
    n^.keyFields := 'TENANT_ID;SEQU_ID';
    n^.synFlag := 23;
    n^.keyFlag := 0;
    n^.tbtitle := '序列号控制表';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList29;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'SYS_DEFINE';
    n^.keyFields := 'TENANT_ID;DEFINE';
    n^.synFlag := 29;
    n^.keyFlag := 0;
    n^.tbtitle := '参数定义表';
    n^.isSyncUp := '1';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;
var
  str:string;
  rs:TZQuery;
begin
  ClearSyncList;

  InitList0;

  InitList00;

  InitList2('TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP',token.tenantId);
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  rs.First;
  while not rs.Eof do
  begin
    InitList2('TENANT_ID='+rs.FieldByName('TENANT_ID').AsString+' and TIME_STAMP>:TIME_STAMP ',rs.FieldByName('TENANT_ID').AsString);
    rs.Next;
  end;

  InitList3;

  InitList4;

  InitList10;

  InitList20;

  InitList21('TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP',token.tenantId,'1','1');
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  rs.First;
  while not rs.Eof do
  begin
    str := 'TENANT_ID='+rs.FieldByName('P_TENANT_ID').AsString+' and TIME_STAMP>:TIME_STAMP';
    InitList21(str,rs.FieldByName('P_TENANT_ID').AsString,'0','1');
    rs.Next;
  end;

  InitList22;

  InitList23;

  InitList29;
end;

function TSyncFactory.CheckNeedLoginSync: boolean;
var timestamp:int64;
begin
  result := true;
  if LoginSyncDate = 0 then
     timestamp := GetSynTimeStamp(token.tenantId,'LOGIN_SYNC','#')
  else
     timestamp := LoginSyncDate;

  if token.lDate <> timestamp then
     result := true
  else
     result := false; 
end;

function TSyncFactory.CheckNeedLoginSyncBizData: boolean;
begin
  result := false;
  LastLoginSyncDate  := GetSynTimeStamp(token.tenantId,'LOGIN_SYNC','#');
  LastLogoutSyncDate := GetSynTimeStamp(token.tenantId,'LOGOUT_SYNC','#');
  if LastLoginSyncDate  = 5497000 then Exit;
  if LastLogoutSyncDate = 5497000 then Exit;
  if LastLoginSyncDate  = token.lDate then Exit;
  if LastLogoutSyncDate = token.lDate then Exit;
  if LastLogoutSyncDate < LastLoginSyncDate then result := true;
end;

procedure TSyncFactory.InitTenant;
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    dataFactory.ExecProc('TTenantInitV60',Params);
  finally
    Params.Free;
  end;
  RightsFactory.InitialRights;
end;

procedure TSyncFactory.LoginSync(PHWnd: THandle);
begin
  if dllApplication.mode = 'demo' then Exit;
  with TfrmSyncData.CreateParented(PHWnd) do
  begin
    try
      hWnd := PHWnd;
      ShowForm;
      BringToFront;
      Update;
      if not token.online then Exit;
      if token.tenantId = '' then
         begin
           TfrmSysDefine.AutoRegister;
           if token.tenantId = '' then Exit;
           if not CheckNeedLoginSync then Exit;
           RspSyncFactory.SyncAll;
           RspSyncFactory.copyGoodsSort;
           SyncFactory.InitTenant;
           SyncFactory.SyncBasic;
           TfrmSysDefine.SaveRegister;
         end
      else
         begin
           if not CheckNeedLoginSync then Exit;
           SyncFactory.SyncBasic;
           if CheckNeedLoginSyncBizData then
              begin
                if MessageBox(PHWnd,'系统检测到上次未进行数据同步，是否立即执行?','友情提醒',MB_YESNO+MB_ICONQUESTION) = 6 then
                   begin
                     SyncFactory.SyncBizData;
                     SyncFactory.SetSynTimeStamp(token.tenantId,'LOGOUT_SYNC',LastLoginSyncDate,'#');
                   end;
              end;
         end;
      SyncFactory.LoginSyncDate := token.lDate;
      SyncFactory.SetSynTimeStamp(token.tenantId,'LOGIN_SYNC',token.lDate,'#');
    finally
      Free;
    end;
  end;
end;

procedure TSyncFactory.LogoutSync(PHWnd: THandle);
begin
  if dllApplication.mode = 'demo' then Exit;
  if token.tenantId = '' then Exit;
  if not token.online then Exit;
  with TfrmSyncData.CreateParented(PHWnd) do
  begin
    try
      hWnd := PHWnd;
      ShowForm;
      BringToFront;
      Update;
      SyncFactory.SyncBasic;
      SyncFactory.SyncBizData;
      SyncFactory.SetSynTimeStamp(token.tenantId,'LOGOUT_SYNC',token.lDate,'#');
      RtcSyncFactory.SyncRtcData;
    finally
      Free;
    end;
  end;
end;

procedure TSyncFactory.RecoverySync(PHWnd:THandle;BeginDate:string='');
begin
  if dllApplication.mode = 'demo' then Exit;
  if token.tenantId = '' then Exit;
  if not token.online then Exit;
  with TfrmSyncData.CreateParented(PHWnd) do
  begin
    try
      hWnd := PHWnd;
      ShowForm;
      BringToFront;
      Update;
      SyncFactory.SyncBizData(1,BeginDate);
    finally
      Free;
    end;
  end;
end;

procedure TSyncFactory.RegisterSync(PHWnd: THandle);
begin
  if dllApplication.mode = 'demo' then Exit;
  if token.tenantId = '' then Exit;
  if not CheckNeedLoginSync then Exit;
  with TfrmSyncData.CreateParented(PHWnd) do
  begin
    try
      hWnd := PHWnd;
      ShowForm;
      BringToFront;
      Update;
      RspSyncFactory.SyncAll;
      RspSyncFactory.copyGoodsSort;
      SyncFactory.InitTenant;
      SyncFactory.SyncBasic;
      SyncFactory.LoginSyncDate := token.lDate;
      SyncFactory.SetSynTimeStamp(token.tenantId,'LOGIN_SYNC',token.lDate,'#');
    finally
      Free;
    end;
  end;
end;

procedure TSyncFactory.SyncStockOrder(SyncFlag:integer=0;BeginDate:string='');
var
  tbName,orderFields,dataFields:string;
  MaxTimeStamp:int64;
  ls,rs_h,rs_d,cs_h,cs_d:TZQuery;
begin
  if (SyncFlag <> 0) and (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'STK_STOCKORDER';
  SyncTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  MaxTimeStamp := SyncTimeStamp;

  Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  Params.ParamByName('SHOP_ID').AsString := token.shopId;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('KEY_FLAG').AsInteger := 0;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if SyncFlag = 0 then
     Params.ParamByName('SYN_COMM').AsBoolean := true
  else
     Params.ParamByName('SYN_COMM').AsBoolean := false;

  if (SyncFlag <> 0) and (BeginDate <> '') then
     Params.ParamByName('BEGIN_DATE').AsInteger := strtoint(BeginDate);

  LogFile.AddLogFile(0,'开始<'+tbName+'>上次时间:'+Params.ParamByName('TIME_STAMP').AsString+'  本次时间:'+inttostr(SyncTimeStamp));

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  try
    SetTicket;
    if SyncFlag = 0 then
       dataFactory.MoveToSqlite
    else
       dataFactory.MoveToRemote;
    try
      dataFactory.Open(ls,'TSyncStockOrderListV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'上传<'+tbName+'>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(ls.RecordCount));
    BeforeSyncBiz(ls,'STOCK_DATE',SyncFlag);
    SetTicket;
    ls.First;
    while not ls.Eof do
    begin
      ProTitle := '正在同步<进货单>...共'+inttostr(ls.RecordCount)+'笔，当前第'+inttostr(ls.RecNo)+'笔';
      SetProPosition(100 div ls.RecordCount * ls.RecNo);

      // 小于关账日期的单据不下载
      if (SyncFlag <> 0) and (CloseAccDate > 0) and (ls.FieldByName('STOCK_DATE').AsInteger < CloseAccDate) then
         begin
           ls.Next;
           Continue;
         end;

      rs_h.Close;
      rs_d.Close;
      cs_h.Close;
      cs_d.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;STOCK_ID';
      Params.ParamByName('STOCK_ID').AsString := ls.FieldbyName('STOCK_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('STK_STOCKORDER');
      if dataFields = ''  then dataFields  := GetTableFields('STK_STOCKDATA','a');

      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
          dataFactory.AddBatch(rs_h,'TSyncStockOrderV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
          dataFactory.AddBatch(rs_d,'TSyncStockDataV60',Params);
          dataFactory.OpenBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;

      if SyncFlag = 0 then
         dataFactory.MoveToRemote
      else
         dataFactory.MoveToSqlite;
      try
        dataFactory.BeginBatch;
        try
          dataFactory.AddBatch(cs_h,'TSyncStockOrderV60',Params);
          dataFactory.AddBatch(cs_d,'TSyncStockDataV60',Params);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      if StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);

      if SyncFlag = 0 then
      begin
        rs_h.Delete;
        dataFactory.MoveToSqlite;
        try
          dataFactory.UpdateBatch(rs_h,'TSyncStockOrderV60',Params);
        finally
          dataFactory.MoveToDefault;
        end;
      end;

      ls.Next;
    end;
    if not ls.IsEmpty then SetSynTimeStamp(token.tenantId,tbName,MaxTimeStamp,token.shopId);
    LogFile.AddLogFile(0,'上传<'+tbName+'>保存时长:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    cs_h.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncSalesOrder(SyncFlag:integer=0;BeginDate:string='');
var
  tbName,orderFields,dataFields,glideFields:string;
  MaxTimeStamp:int64;
  ls,rs_h,rs_d,rs_s,cs_h,cs_d,cs_s:TZQuery;
begin
  if (SyncFlag <> 0) and (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'SAL_SALESORDER';
  SyncTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  MaxTimeStamp := SyncTimeStamp;

  Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  Params.ParamByName('SHOP_ID').AsString := token.shopId;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('KEY_FLAG').AsInteger := 0;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if SyncFlag = 0 then
     Params.ParamByName('SYN_COMM').AsBoolean := true
  else
     Params.ParamByName('SYN_COMM').AsBoolean := false;

  if (SyncFlag <> 0) and (BeginDate <> '') then
     Params.ParamByName('BEGIN_DATE').AsInteger := strtoint(BeginDate);

  LogFile.AddLogFile(0,'开始<'+tbName+'>上次时间:'+Params.ParamByName('TIME_STAMP').AsString+'  本次时间:'+inttostr(SyncTimeStamp));

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  try
    SetTicket;
    if SyncFlag = 0 then
       dataFactory.MoveToSqlite
    else
       dataFactory.MoveToRemote;
    try
      dataFactory.Open(ls,'TSyncSalesOrderListV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'上传<'+tbName+'>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(ls.RecordCount));
    BeforeSyncBiz(ls,'SALES_DATE',SyncFlag);
    SetTicket;
    ls.First;
    while not ls.Eof do
    begin
      ProTitle := '正在同步<销售单>...共'+inttostr(ls.RecordCount)+'笔，当前第'+inttostr(ls.RecNo)+'笔';
      SetProPosition(100+(100 div ls.RecordCount * ls.RecNo));

      // 小于关账日期的单据不下载
      if (SyncFlag <> 0) and (CloseAccDate > 0) and (ls.FieldByName('SALES_DATE').AsInteger < CloseAccDate) then
         begin
           ls.Next;
           Continue;
         end;

      rs_h.Close;
      rs_d.Close;
      rs_s.Close;
      cs_h.Close;
      cs_d.Close;
      cs_s.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SALES_ID';
      Params.ParamByName('SALES_ID').AsString := ls.FieldbyName('SALES_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('SAL_SALESORDER');
      if dataFields = ''  then dataFields  := GetTableFields('SAL_SALESDATA');
      if glideFields = '' then glideFields := GetTableFields('SAL_IC_GLIDE');

      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
          dataFactory.AddBatch(rs_h,'TSyncSalesOrderV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
          dataFactory.AddBatch(rs_d,'TSyncSalesDataV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := glideFields;
          dataFactory.AddBatch(rs_s,'TSyncSalesICDataV60',Params);
          dataFactory.OpenBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;
      cs_s.SyncDelta := rs_s.SyncDelta;

      if SyncFlag = 0 then
         dataFactory.MoveToRemote
      else
         dataFactory.MoveToSqlite;
      try
        dataFactory.BeginBatch;
        try
          dataFactory.AddBatch(cs_h,'TSyncSalesOrderV60',Params);
          dataFactory.AddBatch(cs_d,'TSyncSalesDataV60',Params);
          dataFactory.AddBatch(cs_s,'TSyncSalesICDataV60',Params);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      if StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);

      if SyncFlag = 0 then
      begin
        rs_h.Delete;
        dataFactory.MoveToSqlite;
        try
          dataFactory.BeginBatch;
          try
            dataFactory.AddBatch(rs_h,'TSyncSalesOrderV60',Params);
            if not rs_s.IsEmpty then
               begin
                 rs_s.Delete;
                 dataFactory.AddBatch(rs_s,'TSyncSalesICDataV60',Params);
               end;
            dataFactory.CommitBatch;
          except
            dataFactory.CancelBatch;
            Raise;
          end;
        finally
          dataFactory.MoveToDefault;
        end;
      end;

      ls.Next;
    end;
    if not ls.IsEmpty then SetSynTimeStamp(token.tenantId,tbName,MaxTimeStamp,token.shopId);
    LogFile.AddLogFile(0,'上传<'+tbName+'>保存时长:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    rs_s.Free;
    cs_h.Free;
    cs_d.Free;
    cs_s.Free;
  end;
end;

procedure TSyncFactory.SyncChangeOrder(SyncFlag:integer=0;BeginDate:string='');
var
  tbName,orderFields,dataFields:string;
  MaxTimeStamp:int64;
  ls,rs_h,rs_d,cs_h,cs_d:TZQuery;
begin
  if (SyncFlag <> 0) and (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'STO_CHANGEORDER';
  SyncTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  MaxTimeStamp := SyncTimeStamp;

  Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  Params.ParamByName('SHOP_ID').AsString := token.shopId;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('KEY_FLAG').AsInteger := 0;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if SyncFlag = 0 then
     Params.ParamByName('SYN_COMM').AsBoolean := true
  else
     Params.ParamByName('SYN_COMM').AsBoolean := false;

  if (SyncFlag <> 0) and (BeginDate <> '') then
     Params.ParamByName('BEGIN_DATE').AsInteger := strtoint(BeginDate);

  LogFile.AddLogFile(0,'开始<'+tbName+'>上次时间:'+Params.ParamByName('TIME_STAMP').AsString+'  本次时间:'+inttostr(SyncTimeStamp));

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  try
    SetTicket;
    if SyncFlag = 0 then
       dataFactory.MoveToSqlite
    else
       dataFactory.MoveToRemote;
    try
      dataFactory.Open(ls,'TSyncChangeOrderListV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'上传<'+tbName+'>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(ls.RecordCount));
    BeforeSyncBiz(ls,'CHANGE_DATE',SyncFlag);
    SetTicket;
    ls.First;
    while not ls.Eof do
    begin
      ProTitle := '正在同步<损益单>...共'+inttostr(ls.RecordCount)+'笔，当前第'+inttostr(ls.RecNo)+'笔';
      SetProPosition(200+(100 div ls.RecordCount * ls.RecNo));

      // 小于关账日期的单据不下载
      if (SyncFlag <> 0) and (CloseAccDate > 0) and (ls.FieldByName('CHANGE_DATE').AsInteger < CloseAccDate) then
         begin
           ls.Next;
           Continue;
         end;

      rs_h.Close;
      rs_d.Close;
      cs_h.Close;
      cs_d.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;CHANGE_ID';
      Params.ParamByName('CHANGE_ID').AsString := ls.FieldbyName('CHANGE_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('STO_CHANGEORDER');
      if dataFields = ''  then dataFields  := GetTableFields('STO_CHANGEDATA','a');

      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
          dataFactory.AddBatch(rs_h,'TSyncChangeOrderV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
          dataFactory.AddBatch(rs_d,'TSyncChangeDataV60',Params);
          dataFactory.OpenBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;

      if SyncFlag = 0 then
         dataFactory.MoveToRemote
      else
         dataFactory.MoveToSqlite;
      try
        dataFactory.BeginBatch;
        try
          dataFactory.AddBatch(cs_h,'TSyncChangeOrderV60',Params);
          dataFactory.AddBatch(cs_d,'TSyncChangeDataV60',Params);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      if StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);

      if SyncFlag = 0 then
      begin
        rs_h.Delete;
        dataFactory.MoveToSqlite;
        try
          dataFactory.UpdateBatch(rs_h,'TSyncChangeOrderV60',Params);
        finally
          dataFactory.MoveToDefault;
        end;
      end;

      ls.Next;
    end;
    if not ls.IsEmpty then SetSynTimeStamp(token.tenantId,tbName,MaxTimeStamp,token.shopId);
    LogFile.AddLogFile(0,'上传<'+tbName+'>保存时长:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    cs_h.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncRckDays(SyncFlag:integer=0;BeginDate:string='');
var
  tbName,orderFields,dataFields:string;
  MaxTimeStamp:int64;
  ls,rs_h,rs_d,cs_h,cs_d:TZQuery;
begin
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;

  tbName := 'RCK_DAYS_CLOSE';
  SyncTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  MaxTimeStamp := SyncTimeStamp; 

  Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  Params.ParamByName('SHOP_ID').AsString := token.shopId;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('KEY_FLAG').AsInteger := 0;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if SyncFlag = 0 then
     Params.ParamByName('SYN_COMM').AsBoolean := true
  else
     Params.ParamByName('SYN_COMM').AsBoolean := false;

  if (SyncFlag <> 0) and (BeginDate <> '') then
     Params.ParamByName('BEGIN_DATE').AsInteger := strtoint(BeginDate);

  LogFile.AddLogFile(0,'开始<'+tbName+'>上次时间:'+Params.ParamByName('TIME_STAMP').AsString+'  本次时间:'+inttostr(SyncTimeStamp));

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  try
    SetTicket;
    if SyncFlag = 0 then
       dataFactory.MoveToSqlite
    else
       dataFactory.MoveToRemote;
    try
      dataFactory.Open(ls,'TSyncRckDaysCloseListV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'上传<'+tbName+'>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
    begin
      ProTitle := '正在同步<日台账>...共'+inttostr(ls.RecordCount)+'笔，当前第'+inttostr(ls.RecNo)+'笔';
      SetProPosition(300+(100 div ls.RecordCount * ls.RecNo));

      // 小于关账日期的数据不下载
      if (SyncFlag <> 0) and (CloseAccDate > 0) and (ls.FieldByName('CREA_DATE').AsInteger < CloseAccDate) then
         begin
           ls.Next;
           Continue;
         end;

      rs_h.Close;
      rs_d.Close;

      Params.ParamByName('CREA_DATE').AsInteger := ls.FieldbyName('CREA_DATE').AsInteger;

      if orderFields = '' then orderFields := GetTableFields('RCK_DAYS_CLOSE');
      if dataFields = ''  then dataFields  := GetTableFields('RCK_STOCKS_DATA');

      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
          dataFactory.AddBatch(rs_h,'TSyncRckDaysCloseV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
          dataFactory.AddBatch(rs_d,'TSyncRckStocksDataV60',Params);
          dataFactory.OpenBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;

      if SyncFlag = 0 then
         dataFactory.MoveToRemote
      else
         dataFactory.MoveToSqlite;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SHOP_ID;CREA_DATE';
          dataFactory.AddBatch(cs_h,'TSyncRckDaysCloseV60',Params);
          Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SHOP_ID;BILL_DATE';
          dataFactory.AddBatch(cs_d,'TSyncRckStocksDataV60',Params);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      if StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);

      if SyncFlag = 0 then
      begin
        rs_h.Delete;
        dataFactory.MoveToSqlite;
        try
          dataFactory.UpdateBatch(rs_h,'TSyncRckDaysCloseV60',Params);
        finally
          dataFactory.MoveToDefault;
        end;
      end;

      ls.Next;
    end;
    if not ls.IsEmpty then SetSynTimeStamp(token.tenantId,tbName,MaxTimeStamp,token.shopId);
    LogFile.AddLogFile(0,'上传<'+tbName+'>保存时长:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    cs_h.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncBizData(SyncFlag:integer=0;BeginDate:string='');
begin
  try
    SetProMax(400);
    ProTitle := '正在准备数据...';
    GetCloseAccDate;
    ProTitle := '正在同步<进货单>...';
    SyncStockOrder(SyncFlag,BeginDate);
    SetProPosition(100);
    ProTitle := '正在同步<销售单>...';
    SyncSalesOrder(SyncFlag,BeginDate);
    SetProPosition(200);
    ProTitle := '正在同步<损益单>...';
    SyncChangeOrder(SyncFlag,BeginDate);
    SetProPosition(300);
    ProTitle := '正在同步<日台账>...';
    SyncRckDays(SyncFlag,BeginDate);
    SetProPosition(400);
  finally
    ReadTimeStamp;
  end
end;

procedure TSyncFactory.BeforeSyncBiz(DataSet:TZQuery;FieldName:string;SyncFlag:integer);
var
  rDate:integer;
  isUpdate:boolean;
begin
  rDate := 99999999;
  isUpdate := false;
  DataSet.First;
  while not DataSet.Eof do
  begin
    if DataSet.FieldByName(FieldName).AsInteger < rDate then
       begin
         rDate := DataSet.FieldByName(FieldName).AsInteger;
         isUpdate := true;
       end;
    DataSet.Next;
  end;
  if isUpdate then
  begin
    if SyncFlag = 0 then
       dataFactory.MoveToRemote
    else
       dataFactory.MoveToSqlite;
    try
      Params.ParamByName('CLSE_DATE').AsInteger := rDate;
      Params.ParamByName('MOTH_DATE').AsString := formatDatetime('YYYY-MM-DD',FnTime.fnStrtoDate(inttostr(rDate)));
      dataFactory.ExecProc('TSyncDeleteRckCloseV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
  end;
end;

procedure TSyncFactory.RecoveryClose(CloseDate: string);
var str:string;
begin
  dataFactory.MoveToSqlite;
  try
    dataFactory.BeginTrans;
    try
      dataFactory.ExecSQL('delete from SYS_DEFINE where TENANT_ID='+token.tenantId+' and DEFINE in (''USED_IMP_ACCDATE'',''CLOSE_IMP_ACCDATE'')');

      str := ' insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values '+
           ' ('+token.tenantId+',''USED_IMP_ACCDATE'',''1'',0,''00'',0)';
      dataFactory.ExecSQL(str);

      str := ' insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values '+
           ' ('+token.tenantId+',''CLOSE_IMP_ACCDATE'','''+CloseDate+''',0,''00'',0)';
      dataFactory.ExecSQL(str);

      dataFactory.CommitTrans;
    except
      dataFactory.RollbackTrans;
      Raise;
    end;
  finally
    dataFactory.MoveToDefault;
  end;
  CloseAccDate := strtoint(CloseDate);
end;

procedure TSyncFactory.GetCloseAccDate;
var rs:TZQuery;
begin
  if CloseAccDate >= 0 then Exit;
  rs := TZQuery.Create(nil);
  dataFactory.MoveToSqlite;
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('DEFINE').AsString := 'CLOSE_IMP_ACCDATE';
    dataFactory.Open(rs);
    if rs.IsEmpty then
       CloseAccDate := 0
    else
       CloseAccDate := rs.Fields[0].AsInteger;
  finally
    dataFactory.MoveToDefault;
  end;
end;

procedure TSyncFactory.SetProTitle(const Value: string);
begin
  FProTitle := Value;
  SetProCaption;
end;

procedure TSyncFactory.SetProHandle(const Value: Hwnd);
begin
  FProHandle := Value;
end;

procedure TSyncFactory.SetProCaption;
begin
  PostMessage(ProHandle, MSC_SET_CAPTION, 0, 0);
  Application.ProcessMessages;
end;

procedure TSyncFactory.SetProMax(max: integer);
begin
  PostMessage(ProHandle, MSC_SET_MAX, max, 0);
  Application.ProcessMessages;
end;

procedure TSyncFactory.SetProPosition(position: integer);
begin
  PostMessage(ProHandle, MSC_SET_POSITION, position, 0);
  Application.ProcessMessages;
end;

initialization
  SyncFactory := TSyncFactory.Create;
finalization
  if Assigned(SyncFactory) then FreeAndNil(SyncFactory);
end.
