unit uSyncFactory;

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase, ObjCommon, ZLogFile,
  Dialogs;

const
  MSC_SET_MAX=WM_USER+1;
  MSC_SET_POSITION=WM_USER+2;
  MSC_SET_CAPTION=WM_USER+3;
  MSC_SET_CLOSE=WM_USER+4;

type
  PSynTableInfo=^TSynTableInfo;

  TSynTableInfo=record
    tbName:string;//����
    tbTitle:string;//˵��
    keyFields:string;//�ؽ��ֶ�
    tableFields:string;//ͬ���ֶ�
    selectSQL:string;
    whereStr:string;//where����
    synFlag:integer;
    keyFlag:integer; //0�ǰ���ṹ�ؽ��� 1�ǰ�ҵ��ؽ���
    tableFlag:integer;
    syncTenantId:string;//ʱ�������TENANT_ID
    syncShopId:string;//ʱ�������SHOP_ID
    syncUpAndDown:string;//�Ƿ�˫��ͬ�� 1:��
  end;

  TSyncFactory=class
  protected
    _Start:Int64;
    FList:TList;
    FStoped: boolean;
    FProHandle:Hwnd;
    FSyncTimeStamp: int64;
    FParams: TftParamList;
    SubmitRecordNum:integer;
    FinishIndex:integer;
    procedure SetTicket;
    function  GetTicket:Int64;
    procedure SetParams(const Value: TftParamList);
    procedure SetSyncTimeStamp(const Value: int64);
    procedure SetStoped(const Value: boolean);
    procedure SetProHandle(const Value: Hwnd);
  private
    LoginSyncDate:integer;
    procedure InitTenant;
    procedure InitSyncList1;
    procedure InitSyncList;
    procedure SyncList;
    procedure SyncBasic;
    procedure SyncSingleTable(n:PSynTableInfo;timeStampNoChg:integer=1);
    function  CheckInitSync:boolean;
    function  SyncData(n:PSynTableInfo;Params:TftParamList;SyncFlag:integer;maxTime:int64=0):int64;//0:�ϴ� 1:����  �������ʱ���
  protected
    procedure ClearSyncList;
    procedure ReadTimeStamp;
    function  GetSynTimeStamp(tenantId,tbName:string;SHOP_ID:string='#'):int64;
    procedure SetSynTimeStamp(tenantId,tbName:string;TimeStamp:int64;SHOP_ID:string='#');
    function  GetFactoryName(node:PSynTableInfo):string;
    function  GetTableFields(tbName:string):string;
    // ����������
    procedure SetProMax(max:integer);
    procedure SetProPosition(position:integer);
    procedure SetProCaption(caption:integer);
  public
    constructor Create;
    destructor  Destroy;override;
    // ��¼ͬ��
    procedure LoginSync(PHWnd:THandle);
    function  GetTableName(tableFlag:integer):string;
    property  Params:TftParamList read FParams write SetParams;
    property  SyncTimeStamp:int64 read FSyncTimeStamp write SetSyncTimeStamp;
    property  Stoped:boolean read FStoped write SetStoped;
    property  ProHandle:Hwnd read FProHandle write SetProHandle;
  end; 

var SyncFactory:TSyncFactory;

implementation

uses udllDsUtil,udllGlobal,uTokenFactory,udataFactory,IniFiles,ufrmSyncData,uRspSyncFactory,uRightsFactory;

constructor TSyncFactory.Create;
begin
  SubmitRecordNum := 500;
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
var
  Params:TftParamList;
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
var
  rs:TZQuery;
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
    if rs.IsEmpty then result := 0 else result := rs.Fields[0].Value;
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

  //���·����ʱ���
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

function TSyncFactory.GetTableFields(tbName:string):string;
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
        selectFields := selectFields + ls.FieldList.Fields[i].FieldName;
      end;
    result := selectFields;
  finally
    ls.Free;
  end;
end;

function TSyncFactory.SyncData(n:PSynTableInfo;Params:TftParamList;SyncFlag:integer;maxTime:int64=0):int64;//0:�ϴ� 1:����
var
  cs,rs:TZQuery;
  ZClassName:string;
  tmpObj:TRecord_;
  i,j:integer;
  maxTimeStamp:int64;
begin
  LogFile.AddLogFile(0,'��ʼ<'+n^.tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').AsString+'  ����ʱ��:'+inttostr(SyncTimeStamp));

  maxTimeStamp := 0;
  ZClassName := GetFactoryName(n);

  //�������ϴ�������������
  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  tmpObj := TRecord_.Create;
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    cs.Close;
    rs.Close;
    SetTicket;
    try
      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      if trim(n^.selectSQL) = '' then // OBJ Open
        dataFactory.Open(rs,ZClassName,Params)
      else // SQL Open
        begin
          rs.SQL.Text := n^.selectSQL;
          rs.Params := Params;
          dataFactory.Open(rs);
        end;
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'����<'+n^.tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(rs.RecordCount));

    SetTicket;

    cs.FieldDefs := rs.FieldDefs;
    cs.CreateDataSet;
    //�ְ�ͬ��
    i := 1;
    j := 0;
    rs.First;
    while (not rs.Eof) and (not Stoped) do
      begin
        cs.Append;
        tmpObj.ReadFromDataSet(rs);
        tmpObj.WriteToDataSet(cs);
        maxTimeStamp := rs.FieldByName('TIME_STAMP').AsInteger;
        inc(i);
        rs.Next;
        if ((i > SubmitRecordNum) and (rs.FieldByName('TIME_STAMP').AsInteger > maxTimeStamp)) or (rs.Eof) then
          begin
            //�ύ
            if not cs.IsEmpty then
              try
                if SyncFlag = 0 then
                   dataFactory.MoveToRemote
                else
                   dataFactory.MoveToSqlite;
                dataFactory.UpdateBatch(cs,ZClassName,Params);
              finally
                dataFactory.MoveToDefault;
              end;
            if maxTimeStamp > maxTime then
               SetSynTimeStamp(n^.syncTenantId,n^.tbName,maxTimeStamp,n^.syncShopId);
            cs.Close;
            cs.FieldDefs := rs.FieldDefs;
            cs.CreateDataSet;
            i := 1;
            inc(j);
            Application.ProcessMessages;
            SetProPosition(FinishIndex * 100 + (100 div (rs.RecordCount div SubmitRecordNum + 1) * j) );
          end;
      end;
    LogFile.AddLogFile(0,'����<'+n^.tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    rs.Free;
    cs.Free;
    tmpObj.Free;
  end;
  result := maxTimeStamp;
end;

procedure TSyncFactory.SyncSingleTable(n:PSynTableInfo;timeStampNoChg:integer=1);
var
  SFVersion:string;
  LCLVersion:boolean;
  maxTimeStamp:int64;
begin
  SFVersion := dllGlobal.GetSFVersion;
  LCLVersion := (SFVersion = '.LCL');

  if trim(n^.syncTenantId) = '' then n^.syncTenantId := token.tenantId;
  if trim(n^.syncShopId) = '' then n^.syncShopId := '#';

  SyncTimeStamp := GetSynTimeStamp(n^.syncTenantId,n^.tbName,n^.syncShopId);

  Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  Params.ParamByName('SHOP_ID').AsString := token.shopId;
  Params.ParamByName('KEY_FLAG').AsInteger := n^.keyFlag;
  Params.ParamByName('TABLE_NAME').AsString := n^.tbName;
  Params.ParamByName('KEY_FIELDS').AsString := n^.keyFields;
  Params.ParamByName('TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := timeStampNoChg;
  Params.ParamByName('WHERE_STR').AsString := n^.whereStr;
  if trim(n^.tableFields) <> '' then
     Params.ParamByName('TABLE_FIELDS').AsString := n^.tableFields
  else
     Params.ParamByName('TABLE_FIELDS').AsString := GetTableFields(n^.tbName);

  if n^.syncUpAndDown = '1' then
     begin
       maxTimeStamp := SyncData(n,Params,1); //����
       SyncData(n,Params,0,maxTimeStamp); //�ϴ�
     end
  else
     begin
       if LCLVersion then
          SyncData(n,Params,0)  //�ϴ�
       else
          SyncData(n,Params,1); //����
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
  for i:=0 to FList.Count -1 do
  begin
    case PSynTableInfo(FList[i])^.synFlag of
    0,1,2,3,4,10,20,21,22,23,29:
      begin
        Application.ProcessMessages;
        SetProCaption(PSynTableInfo(FList[i])^.tableFlag);
        SyncSingleTable(FList[i]);
        FinishIndex := (i+1);
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
  n^.tableFlag := 0;
  n^.tbtitle := '��Ӧ��ϵ';
  n^.syncUpAndDown := '1';
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
    n^.tableFlag := 0;
    n^.tbtitle := '�ŵ�����';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_DEPT_INFO';
    n^.keyFields := 'TENANT_ID;DEPT_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 1;
    n^.tbtitle := '��������';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_DUTY_INFO';
    n^.keyFields := 'TENANT_ID;DUTY_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 2;
    n^.tbtitle := 'ְ������';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_ROLE_INFO';
    n^.keyFields := 'TENANT_ID;ROLE_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 3;
    n^.tbtitle := '��ɫ����';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_USERS';
    n^.keyFields := 'TENANT_ID;USER_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 4;
    n^.tbtitle := '�û�����';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_RIGHTS';
    n^.keyFields := 'TENANT_ID;MODU_ID;ROLE_ID;ROLE_TYPE';
    n^.synFlag := 0;
    n^.keyFlag := 1;
    n^.tableFlag := 5;
    n^.tbtitle := '����Ȩ��';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_PRICEGRADE';
    n^.keyFields := 'TENANT_ID;PRICE_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 6;
    n^.tbtitle := '�ͻ��ȼ�';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_UNION_INFO';
    n^.keyFields := 'TENANT_ID;UNION_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 7;
    n^.tbtitle := '���˵���';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_UNION_INDEX';
    n^.keyFields := 'TENANT_ID;UNION_ID;INDEX_ID';
    n^.keyFlag := 0;
    n^.synFlag := 0;
    n^.tableFlag := 8;
    n^.tbtitle := '����ָ��';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CLIENTINFO';
    n^.keyFields := 'TENANT_ID;CLIENT_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 9;
    n^.tbtitle := '�ͻ�����';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CUSTOMER';
    n^.keyFields := 'TENANT_ID;CUST_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 10;
    n^.tbtitle := '��Ա����';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CUSTOMER_EXT';
    n^.keyFields := 'TENANT_ID;UNION_ID;CUST_ID;INDEX_ID';
    n^.synFlag := 0;
    n^.keyFlag := 1;
    n^.tableFlag := 11;
    n^.tbtitle := '��Ա����';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_GOODSINFOEXT';
    n^.keyFields := 'TENANT_ID;GODS_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tableFlag := 12;
    n^.tbtitle := '���½���';
    n^.syncUpAndDown := '1';
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
    n^.tableFlag := 13;
    n^.tbtitle := '�����ۼ�';
    n^.syncUpAndDown := '1';
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
    n^.tableFlag := 14;
    n^.tbtitle := '��Ӧ��';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CODE_INFO';
    n^.keyFields := 'TENANT_ID;CODE_ID;CODE_TYPE';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tableFlag := 15;
    n^.tbtitle := '��������';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_GOODSSORT';
    n^.keyFields := 'TENANT_ID;SORT_ID;SORT_TYPE';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tableFlag := 16;
    n^.tbtitle := '��Ʒ����';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_COLOR_INFO';
    n^.keyFields := 'TENANT_ID;COLOR_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tableFlag := 17;
    n^.tbtitle := '��ɫ����';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_SIZE_INFO';
    n^.keyFields := 'TENANT_ID;SIZE_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tableFlag := 18;
    n^.tbtitle := '���뵵��';
    n^.syncUpAndDown := '1';
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_MEAUNITS';
    n^.keyFields := 'TENANT_ID;UNIT_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tableFlag := 19;
    n^.tbtitle := '������λ';
    n^.syncUpAndDown := '1';
    FList.Add(n);
  end;

  procedure InitList3;
  var n:PSynTableInfo;
      str:string;
  begin
    str :=
      'select b.ROWS_ID,b.TENANT_ID,b.GODS_ID,b.PROPERTY_01,b.PROPERTY_02,b.UNIT_ID,b.BARCODE_TYPE,b.BATCH_NO,b.BARCODE,b.COMM,b.TIME_STAMP '+
      'from   PUB_BARCODE b '+
      'where  TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+
      'union all '+
      'select b.ROWS_ID,b.TENANT_ID,b.GODS_ID,b.PROPERTY_01,b.PROPERTY_02,b.UNIT_ID,b.BARCODE_TYPE,b.BATCH_NO,b.BARCODE,b.COMM, '+
      '       case '+
      '         when b.TIME_STAMP > c.TIME_STAMP and b.TIME_STAMP > s.TIME_STAMP then b.TIME_STAMP '+
      '         when c.TIME_STAMP > b.TIME_STAMP and c.TIME_STAMP > s.TIME_STAMP then c.TIME_STAMP '+
      '         when s.TIME_STAMP > b.TIME_STAMP and s.TIME_STAMP > c.TIME_STAMP then s.TIME_STAMP '+
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
    n^.selectSQL := str;
    n^.synFlag := 3;
    n^.keyFlag := 0;
    n^.tableFlag := 20;
    n^.tbtitle := '�����';
    n^.syncUpAndDown := '1';
    FList.Add(n);
  end;

  procedure InitList4;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_IC_INFO';
    n^.keyFields := 'TENANT_ID;UNION_ID;CLIENT_ID';
    n^.tableFields := 'CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,PASSWRD,USING_DATE,NEAR_BUY_DATE,FREQUENCY,COMM,TIME_STAMP';
    n^.synFlag := 4;
    n^.keyFlag := 1;
    n^.tableFlag := 21;
    n^.tbtitle := 'IC����';
    n^.syncUpAndDown := '1';
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
    n^.tableFlag := 22;
    n^.tbtitle := '�˻�����';
    n^.syncUpAndDown := '1';
    n^.keyFlag := 0;
    FList.Add(n);
  end;

  procedure InitList20;
  var n:PSynTableInfo;
      str:string;
  begin
    str :=
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
    n^.selectSQL := str;
    n^.synFlag := 20;
    n^.keyFlag := 0;
    n^.tableFlag := 23;
    n^.tbtitle := '��ҵ����';
    n^.syncUpAndDown := '1';
    FList.Add(n);
  end;

  procedure InitList21(whereStr:string;syncTenantId:string);
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_GOODS_RELATION';
    n^.keyFields := 'TENANT_ID;GODS_ID;RELATION_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 21;
    n^.keyFlag := 1;
    n^.syncTenantId := syncTenantId;
    n^.tableFlag := 24;
    n^.tbtitle := '��Ӧ����Ʒ';
    n^.syncUpAndDown := '1';
    FList.Add(n);
  end;

  procedure InitList22;
  var n:PSynTableInfo;
      str:string;
  begin
     str :=
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
      '         when b.TIME_STAMP > c.TIME_STAMP and b.TIME_STAMP > s.TIME_STAMP then b.TIME_STAMP '+
      '         when c.TIME_STAMP > b.TIME_STAMP and c.TIME_STAMP > s.TIME_STAMP then c.TIME_STAMP '+
      '         when s.TIME_STAMP > b.TIME_STAMP and s.TIME_STAMP > c.TIME_STAMP then s.TIME_STAMP '+
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
    n^.selectSQL := str;
    n^.synFlag := 22;
    n^.keyFlag := 0;
    n^.tableFlag := 25;
    n^.tbtitle := '��Ʒ����';
    n^.syncUpAndDown := '1';
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
    n^.tableFlag := 26;
    n^.tbtitle := '���кſ��Ʊ�';
    n^.syncUpAndDown := '1';
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
    n^.tableFlag := 27;
    n^.tbtitle := '���������';
    n^.syncUpAndDown := '1';
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

  InitList21('TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP',token.tenantId);
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  rs.First;
  while not rs.Eof do
  begin
    str := 'TENANT_ID='+rs.FieldByName('P_TENANT_ID').AsString+' and TIME_STAMP>:TIME_STAMP';
    InitList21(str,rs.FieldByName('P_TENANT_ID').AsString);
    rs.Next;
  end;

  InitList22;

  InitList23;

  InitList29;
end;

function TSyncFactory.GetTableName(tableFlag: integer): string;
var i:integer;
begin
  for i:=0 to FList.Count -1 do
  begin
    if PSynTableInfo(FList[i])^.tableFlag = tableFlag then
    begin
      result := PSynTableInfo(FList[i])^.tbTitle;
      break;
    end;
  end;
end;

procedure TSyncFactory.SetProHandle(const Value: Hwnd);
begin
  FProHandle := Value;
end;

procedure TSyncFactory.SetProCaption(caption: integer);
begin
  PostMessage(ProHandle, MSC_SET_CAPTION, caption, 0);
end;

procedure TSyncFactory.SetProMax(max: integer);
begin
  PostMessage(ProHandle, MSC_SET_MAX, max, 0);
end;

procedure TSyncFactory.SetProPosition(position: integer);
begin
  PostMessage(ProHandle, MSC_SET_POSITION, position, 0);
end;

function TSyncFactory.CheckInitSync: boolean;
var timestamp:int64;
begin
  result := true;
  if LoginSyncDate = 0 then
     timestamp := GetSynTimeStamp(token.tenantId,'LOGIN_SYNC','#')
  else
     timestamp := LoginSyncDate;

  if timestamp = 0 then Exit;

  if token.lDate > timestamp then
     result := true
  else
     result := false; 
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
  if not CheckInitSync then Exit;
  with TfrmSyncData.CreateParented(PHWnd) do
  begin
    try
      hWnd := PHWnd;
      ShowForm;
      BringToFront;
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

initialization
  SyncFactory := TSyncFactory.Create;
finalization
  SyncFactory.Free;
end.
