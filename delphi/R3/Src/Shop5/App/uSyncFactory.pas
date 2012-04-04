unit uSyncFactory;

interface
uses
  Windows, Messages, Forms, SysUtils, Classes,ZDataSet,ZdbFactory,ZBase,ObjCommon, ZLogFile;
type
  PSynTableInfo=^TSynTableInfo;
  TSynTableInfo=record
    tbname:string;//����
    tbtitle:string;//˵��
    keyFields:string;//�ؽ��ֶ�
    synFlag:integer;
    KeyFlag:integer; //0�ǰ���ṹ�ؽ��� 1�ǰ�ҵ��ؽ���
  end;
  TSyncFactory=class
  private
    FParams: TftParamList;
    FList:TList;
    _Start:Int64;
    FSyncTimeStamp: int64;
    FSyncComm: boolean;
    Ffirsted: boolean;
    FEndTimeStamp: int64;
    FStoped: boolean;
    FWorking: boolean;
    procedure SetParams(const Value: TftParamList);
    procedure SetSyncTimeStamp(const Value: int64);
    procedure SetSyncComm(const Value: boolean);
    procedure Setfirsted(const Value: boolean);
    procedure SetEndTimeStamp(const Value: int64);
    procedure SetStoped(const Value: boolean);
    procedure SetWorking(const Value: boolean);
  protected
    rDate,lDate:integer;
    procedure SetTicket;
    function GetTicket:Int64;
  public
    Locked:integer;

    constructor Create;
    destructor Destroy;override;

    function GetFactoryName(node:PSynTableInfo):string;

    //�������ʱ�Ƿ�ͬ��
    function CheckInitSync:boolean;
    //�������ʱ�Ƿ�ͬ��
    function CheckThreadSync:boolean;

    //������ݿ�汾.
    function CheckDBVersion:boolean;
    //��ʼ��ͬ������
    procedure InitList;

    procedure SyncRckClose(DataSet:TZQuery;FieldName:string;lFactor:TdbFactory);

    function GetSynTimeStamp(tbName:string;SHOP_ID:string='#'):int64;
    procedure SetSynTimeStamp(tbName:string;TimeStamp:int64;SHOP_ID:string='#');
    //˫ͬͬ��
    procedure SyncSingleTable(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0;onlyDown:boolean=false;timeStampNoChg:integer=1);
    //ֻ�ϴ�ͬ��
    procedure SendSingleTable(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0;onlyDown:boolean=false;timeStampNoChg:integer=1);
    //ͬ������൥��
    procedure SyncStockOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //ͬ�������൥��
    procedure SyncSalesOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //ͬ������൥��
    procedure SyncChangeOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //������������
    procedure SyncStkIndentOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //���۶�������
    procedure SyncSalIndentOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //����֧������
    procedure SyncIoroOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //��ȡ�����
    procedure SyncTransOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //IC����ˮ��¼
    procedure SyncIcGlideOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //�տ����
    procedure SyncRecvOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //�������
    procedure SyncPayOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //��̨�˵���
    procedure SyncDaysCloseOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //��̨�˵���
    procedure SyncMonthCloseOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //���Ž���
    procedure SyncCloseForDay(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //������
    procedure SyncPriceOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //��е�
    procedure SyncBomOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //�̵㵥
    procedure SyncCheckOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //ͬ���ʴ��
    procedure SyncQuestion(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //ͬ��ģ���
    procedure SyncCaModule(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //ͬ���Զ��屨��
    procedure SyncSysReport(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //ͬ����־
    procedure SyncCaLoginInfo(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
    //��ʼͬ������
    procedure SyncAll;
    //��ʼ��������
    procedure SyncBasic(gbl:boolean=true);
    //��Ӷ���ͬ������
    procedure SyncThread(Sender: TObject);
    //����ͬ����Rim
    procedure SyncRim;
    //ֻͬ���ս�����������
    procedure SyncForDay;

    procedure ReadTimeStamp;

    //�����������
    function SyncLockCheck:boolean;
    function SyncLockDb:boolean;
    function SyncUnLockDb:boolean;

    //��������Ƿ�û�����ݣ�
    function CheckRemeteData:boolean;
    property Params:TftParamList read FParams write SetParams;
    property SyncTimeStamp:int64 read FSyncTimeStamp write SetSyncTimeStamp;
    //���ƽ�������
    property EndTimeStamp:int64 read FEndTimeStamp write SetEndTimeStamp;
    property SyncComm:boolean read FSyncComm write SetSyncComm;
    property firsted:boolean read Ffirsted write Setfirsted;
    //Ϊ�Զ��ϴ�����ؿ��Ʊ���
    property Stoped:boolean read FStoped write SetStoped;
    property Working:boolean read FWorking write SetWorking;
  end;
  
var
  SyncFactory:TSyncFactory;
implementation
uses uGlobal,ufrmLogo,ufrmDesk,uFnUtil,uMsgBox,uDsUtil,uCaFactory,uSyncThread,uCommand;
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

function TSyncFactory.CheckInitSync: boolean;
var
  timestamp:int64;
  cDate:Currency;
  CurDate:Currency;
begin
  result := true;
  if Global.debug then Exit;
  timestamp := GetSynTimeStamp('#','#');
  if timestamp=0 then Exit;
  cDate := trunc(timestamp/86400.0+40542.0);
  CurDate := date();
  CurDate := trunc(CurDate)-2;
  result := cDate<CurDate;
end;

function TSyncFactory.CheckRemeteData: boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select TENANT_ID from SYS_SYNC_CTRL where TENANT_ID='+inttostr(Global.TENANT_ID);
    Global.RemoteFactory.Open(rs);
    SyncComm := not rs.IsEmpty;
    rs.Close;
    rs.SQL.Text := 'select TENANT_ID from SYS_SYNC_CTRL where TENANT_ID='+inttostr(Global.TENANT_ID)+ ' and SHOP_ID<>''#'' and not (TABLE_NAME like ''RSP_%'')';
    Global.LocalFactory.Open(rs);
    firsted := rs.IsEmpty;   //û��ͬ����ҵ������
  finally
    rs.free;
  end;
  result := SyncComm;
end;

function TSyncFactory.CheckThreadSync: boolean;
var
  timestamp:int64;
  cDate:Currency;
  CurDate:Currency;
begin
  result := true;
  if Global.debug then Exit;
  timestamp := GetSynTimeStamp('AUTO','#');
  if timestamp=0 then Exit;
  cDate := trunc(timestamp/86400.0+40542.0);
  CurDate := date();
  CurDate := trunc(CurDate)-2;
  result := cDate<CurDate;
end;

constructor TSyncFactory.Create;
begin
  Locked := 0;
  FParams := TftParamList.Create(nil);
  FList := TList.Create;
  SyncComm := true;
  firsted := false;
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
  11:result := 'TSyncIoroOrderList';
  12:result := 'TSyncTransOrder';
  13:result := 'TSyncRecvOrderList';
  14:result := 'TSyncPayOrderList';
  15:result := 'TSyncRckDaysCloseList';
  16:result := 'TSyncRckMonthCloseList';
  17:result := 'TSyncCloseForDayList';
  18:result := 'TSyncPriceOrderList';
  19:result := 'TSyncCheckOrderList';
  20:result := 'TSyncCaTenant';
  21:result := 'TSyncGodsRelation';
  22:result := 'TSyncGodsInfo';
  23:result := 'TSyncSequence';
  25:result := 'TSyncCaModule';
  26:result := 'TSyncSysReportList';
  27:result := 'TSyncICGlideInfo';
  29:result := 'TSyncSysDefine';
  30:result := 'TSyncBomOrderList';
  else
    result := 'TSyncSingleTable';
  end;
end;

function TSyncFactory.GetSynTimeStamp(tbName: string;SHOP_ID:string='#'): int64;
var
  rs:TZQuery;
begin
  if SHOP_ID='' then SHOP_ID:='#';
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
    rs.ParambyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
    rs.ParamByName('TABLE_NAME').AsString := tbName;
    Global.LocalFactory.Open(rs);
    if rs.IsEmpty or not SyncComm then result := 0 else result := rs.Fields[0].Value;
  finally
    rs.Free;
  end;
end;

function TSyncFactory.GetTicket:int64;
begin
  result := GetTickCount-_Start;
end;

procedure TSyncFactory.InitList;
var
  n:PSynTableInfo;
  i:integer;
begin
  lDate := 99999999;
  rDate := 99999999;
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Clear;
  new(n);
  n^.tbname := 'CA_RELATIONS';
  n^.keyFields := 'RELATION_ID;RELATI_ID';
  n^.synFlag := 1;
  n^.KeyFlag := 1;
  n^.tbtitle := '��Ӧ��ϵ';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RELATION';
  n^.keyFields := 'TENANT_ID;RELATION_ID';
  n^.synFlag := 2;
  n^.KeyFlag := 0;
  n^.tbtitle := '��Ӧ��';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_TENANT';
  n^.keyFields := 'TENANT_ID';
  n^.synFlag := 20;
  n^.KeyFlag := 0;
  n^.tbtitle := '��ҵ����';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_SHOP_INFO';
  n^.keyFields := 'TENANT_ID;SHOP_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '�ŵ�����';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_DEPT_INFO';
  n^.keyFields := 'TENANT_ID;DEPT_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '��������';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_DUTY_INFO';
  n^.keyFields := 'TENANT_ID;DUTY_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := 'ְ������';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_ROLE_INFO';
  n^.keyFields := 'TENANT_ID;ROLE_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '��ɫ����';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_USERS';
  n^.keyFields := 'TENANT_ID;USER_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '�û�����';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CODE_INFO';
  n^.keyFields := 'TENANT_ID;CODE_ID;CODE_TYPE';
  n^.synFlag := 2;
  n^.KeyFlag := 0;
  n^.tbtitle := '��������';
  FList.Add(n);
  new(n);
  n^.tbname := 'SYS_DEFINE';
  n^.keyFields := 'TENANT_ID;DEFINE';
  n^.synFlag := 29;
  n^.KeyFlag := 0;
  n^.tbtitle := '���������';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_MODULE';
  n^.keyFields := 'PROD_ID;MODU_ID';
  n^.synFlag := 25;
  n^.KeyFlag := 0;
  n^.tbtitle := '����ģ��';
  FList.Add(n);
  new(n);
  n^.tbname := 'SYS_SEQUENCE';
  n^.keyFields := 'TENANT_ID;SEQU_ID';
  n^.synFlag := 23;
  n^.KeyFlag := 0;
  n^.tbtitle := '���кſ��Ʊ�';
  FList.Add(n);
  new(n);
  n^.tbname := 'CA_RIGHTS';
  n^.keyFields := 'TENANT_ID;MODU_ID;ROLE_ID;ROLE_TYPE';
  n^.synFlag := 0;
  n^.KeyFlag := 1;
  n^.tbtitle := '����Ȩ��';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSSORT';
  n^.keyFields := 'TENANT_ID;SORT_ID;SORT_TYPE';
  n^.synFlag := 2;
  n^.KeyFlag := 0;
  n^.tbtitle := '��Ʒ����';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_COLOR_INFO';
  n^.keyFields := 'TENANT_ID;COLOR_ID';
  n^.synFlag := 2;
  n^.KeyFlag := 0;
  n^.tbtitle := '��ɫ����';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_SIZE_INFO';
  n^.keyFields := 'TENANT_ID;SIZE_ID';
  n^.synFlag := 2;
  n^.KeyFlag := 0;
  n^.tbtitle := '���뵵��';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_MEAUNITS';
  n^.keyFields := 'TENANT_ID;UNIT_ID';
  n^.synFlag := 2;
  n^.KeyFlag := 0;
  n^.tbtitle := '������λ';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSINFO';
  n^.keyFields := 'TENANT_ID;GODS_ID';
  n^.synFlag := 22;
  n^.KeyFlag := 0;
  n^.tbtitle := '��Ʒ����';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODS_RELATION';
  n^.keyFields := 'TENANT_ID;GODS_ID;RELATION_ID';
  n^.synFlag := 21;
  n^.KeyFlag := 1;
  n^.tbtitle := '��Ӧ����Ʒ';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_BARCODE';
  n^.keyFields := 'TENANT_ID;GODS_ID;UNIT_ID;PROPERTY_01;PROPERTY_02;BARCODE_TYPE';
  n^.synFlag := 3;
  n^.KeyFlag := 1;
  n^.tbtitle := '�����';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_PRICEGRADE';
  n^.keyFields := 'TENANT_ID;PRICE_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '�ͻ��ȼ�';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_UNION_INFO';
  n^.keyFields := 'TENANT_ID;UNION_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '���˵���';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_UNION_INDEX';
  n^.keyFields := 'TENANT_ID;UNION_ID;INDEX_ID';
  n^.KeyFlag := 0;
  n^.synFlag := 0;
  n^.tbtitle := '����ָ��';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CLIENTINFO';
  n^.keyFields := 'TENANT_ID;CLIENT_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '�ͻ�����';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CUSTOMER';
  n^.keyFields := 'TENANT_ID;CUST_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '��Ա����';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_CUSTOMER_EXT';
  n^.keyFields := 'TENANT_ID;UNION_ID;CUST_ID;INDEX_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 1;
  n^.tbtitle := '��Ա����';
  FList.Add(n);
  
  new(n);
  n^.tbname := 'PUB_IC_INFO';
  n^.keyFields := 'TENANT_ID;UNION_ID;CLIENT_ID';
  n^.synFlag := 4;
  n^.KeyFlag := 1;
  n^.tbtitle := 'IC����';
  FList.Add(n);

  new(n);
  n^.tbname := 'PUB_GOODSPRICE';
  n^.keyFields := 'TENANT_ID;GODS_ID;SHOP_ID;PRICE_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '�����ۼ�';
  FList.Add(n);
  new(n);
  n^.tbname := 'PUB_GOODSINFOEXT';
  n^.keyFields := 'TENANT_ID;GODS_ID';
  n^.synFlag := 0;
  n^.tbtitle := '���½���';
  n^.KeyFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'LOG_PRICING_INFO';
  n^.keyFields := 'ROWS_ID';
  n^.synFlag := 0;
  n^.tbtitle := '�����־';
  n^.KeyFlag := 0;
  FList.Add(n);
  new(n);
  n^.tbname := 'SAL_PRICEORDER';
  n^.keyFields := 'TENANT_ID;PROM_ID';
  n^.synFlag := 18;
  n^.KeyFlag := 0;
  n^.tbtitle := '��������';
  FList.Add(n);
  n^.tbname := 'SAL_BOMORDER';
  n^.keyFields := 'TENANT_ID;BOM_ID';
  n^.synFlag := 30;
  n^.KeyFlag := 0;
  n^.tbtitle := '��е�';
  FList.Add(n);

  new(n);
  n^.tbname := 'ACC_ACCOUNT_INFO';
  n^.keyFields := 'TENANT_ID;ACCOUNT_ID';
  n^.synFlag := 10;
  n^.tbtitle := '�˻�����';
  n^.KeyFlag := 0;
  FList.Add(n);

  //ͬ��ҵ������
  new(n);
  n^.tbname := 'STK_STOCKORDER';
  n^.keyFields := 'TENANT_ID;STOCK_ID';
  n^.synFlag := 5;
  n^.tbtitle := '��ⵥ��';
  n^.KeyFlag := 0;
  FList.Add(n);

  new(n);
  n^.tbname := 'SAL_SALESORDER';
  n^.keyFields := 'TENANT_ID;SALES_ID';
  n^.synFlag := 6;
  n^.KeyFlag := 0;
  n^.tbtitle := '���ⵥ��';
  FList.Add(n);

  new(n);
  n^.tbname := 'STO_CHANGEORDER';
  n^.keyFields := 'TENANT_ID;CHANGE_ID';
  n^.synFlag := 7;
  n^.KeyFlag := 0;
  n^.tbtitle := '�������';
  FList.Add(n);

  new(n);
  n^.tbname := 'STK_INDENTORDER';
  n^.keyFields := 'TENANT_ID;INDE_ID';
  n^.KeyFlag := 0;
  n^.synFlag := 8;
  n^.tbtitle := '��������';
  FList.Add(n);

  new(n);
  n^.tbname := 'SAL_INDENTORDER';
  n^.keyFields := 'TENANT_ID;INDE_ID';
  n^.synFlag := 9;
  n^.KeyFlag := 0;
  n^.tbtitle := '���۶���';
  FList.Add(n);

  new(n);
  n^.tbname := 'ACC_IOROORDER';
  n^.keyFields := 'TENANT_ID;IORO_ID';
  n^.synFlag := 11;
  n^.KeyFlag := 0;
  n^.tbtitle := '����֧��';
  FList.Add(n);

  new(n);
  n^.tbname := 'ACC_TRANSORDER';
  n^.keyFields := 'TENANT_ID;TRANS_ID';
  n^.synFlag := 12;
  n^.KeyFlag := 0;
  n^.tbtitle := '��ȡ�';
  FList.Add(n);

  new(n);
  n^.tbname := 'SAL_IC_GLIDE';
  n^.keyFields := 'TENANT_ID;GLIDE_ID';
  n^.synFlag := 27;
  n^.KeyFlag := 0;
  n^.tbtitle := 'IC����ˮ';
  FList.Add(n);
  
  new(n);
  n^.tbname := 'ACC_CLOSE_FORDAY';
  n^.keyFields := 'TENANT_ID;SHOP_ID;CLSE_DATE;CLSE_TYPE;CREA_USER';
  n^.synFlag := 17;
  n^.KeyFlag := 1;
  n^.tbtitle := '�������';
  FList.Add(n);

  new(n);
  n^.tbname := 'ACC_RECVORDER';
  n^.keyFields := 'TENANT_ID;RECV_ID';
  n^.synFlag := 13;
  n^.tbtitle := '�տ';
  n^.KeyFlag := 0;
  FList.Add(n);


  new(n);
  n^.tbname := 'ACC_PAYORDER';
  n^.keyFields := 'TENANT_ID;PAY_ID';
  n^.synFlag := 14;
  n^.tbtitle := '���';
  n^.KeyFlag := 0;
  FList.Add(n);

  new(n);
  n^.tbname := 'STO_PRINTORDER';
  n^.keyFields := 'TENANT_ID;SHOP_ID;PRINT_DATE';
  n^.synFlag := 19;
  n^.tbtitle := '�̵㵥';
  n^.KeyFlag := 0;
  FList.Add(n);

  new(n);
  n^.tbname := 'RCK_DAYS_CLOSE';
  n^.keyFields := 'TENANT_ID;SHOP_ID;CREA_DATE';
  n^.synFlag := 15;
  n^.tbtitle := '��̨��';
  n^.KeyFlag := 0;
  FList.Add(n);
  

  new(n);
  n^.tbname := 'RCK_MONTH_CLOSE';
  n^.keyFields := 'TENANT_ID;SHOP_ID;MONTH';
  n^.synFlag := 16;
  n^.tbtitle := '��̨��';
  n^.KeyFlag := 0;
  FList.Add(n);

  new(n);
  n^.tbname := 'MSC_MESSAGE';
  n^.keyFields := 'TENANT_ID;MSG_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '��Ϣ����';
  FList.Add(n);

  new(n);
  n^.tbname := 'MSC_MESSAGE_LIST';
  n^.keyFields := 'TENANT_ID;MSG_ID;SHOP_ID';
  n^.synFlag := 0;
  n^.KeyFlag := 0;
  n^.tbtitle := '��Ϣ����';
  FList.Add(n);

  new(n);
  n^.tbname := 'SYS_REPORT';
  n^.keyFields := 'TENANT_ID;REPORT_ID';
  n^.synFlag := 26;
  n^.KeyFlag := 0;
  n^.tbtitle := '����ģ��';
  FList.Add(n);

  new(n);
  n^.tbname := 'CA_LOGIN_INFO';
  n^.keyFields := 'TENANT_ID;LOGIN_ID';
  n^.synFlag := 28;
  n^.KeyFlag := 0;
  n^.tbtitle := '��¼��־';
  FList.Add(n);
end;

procedure TSyncFactory.ReadTimeStamp;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    if not (Factor=Global.LocalFactory) then Global.LocalFactory.ExecProc('TGetSyncTimeStamp',Params); 
    Factor.ExecProc('TGetSyncTimeStamp',Params);
  finally
    Params.free;
  end;
end;

procedure TSyncFactory.SendSingleTable(tbName, KeyFields,
  ZClassName: string; KeyFlag: integer; onlyDown: boolean;
  timeStampNoChg: integer);
var
  cs,rs:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName);
  Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := timeStampNoChg;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('PROD_ID').AsString := ProductId;
  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    //�ϴ���������
    cs.Close;
    rs.Close;
    SetTicket;
    Global.LocalFactory.Open(cs,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(cs.RecordCount));
    if not cs.IsEmpty then
    begin
      //Global.LocalFactory.BeginTrans;
      //try
        SetTicket;
        rs.SyncDelta := cs.SyncDelta;
        cs.Delete;
        if not rs.IsEmpty then
           Global.RemoteFactory.UpdateBatch(rs,ZClassName,Params);
        Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
        LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
      //  Global.LocalFactory.CommitTrans;
      //except
      //  Global.LocalFactory.RollbackTrans;
      //  Raise;
      //end;
    end;
    SetSynTimeStamp(tbName,SyncTimeStamp);
  finally
    rs.Free;
    cs.Free;
  end;
end;

procedure TSyncFactory.SetEndTimeStamp(const Value: int64);
begin
  FEndTimeStamp := Value;
end;

procedure TSyncFactory.Setfirsted(const Value: boolean);
begin
  Ffirsted := Value;
end;

procedure TSyncFactory.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

procedure TSyncFactory.SetStoped(const Value: boolean);
begin
  FStoped := Value;
end;

procedure TSyncFactory.SetSyncComm(const Value: boolean);
begin
  FSyncComm := Value;
end;

procedure TSyncFactory.SetSyncTimeStamp(const Value: int64);
begin
  FSyncTimeStamp := Value;
end;

procedure TSyncFactory.SetSynTimeStamp(tbName: string; TimeStamp: int64;SHOP_ID:string='#');
var
  r:integer;
begin
  //����н�ֹʱ�䣬Ҫд���ֹʱ�䲻���õ�ǰʱ��
  if EndTimeStamp>0 then TimeStamp := EndTimeStamp;
  if SHOP_ID='' then SHOP_ID:='#';
  r := Global.LocalFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+'''');
  if r=0 then
     Global.LocalFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+inttostr(Global.TENANT_ID)+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
  r := Global.RemoteFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+'''');
  if r=0 then
     Global.RemoteFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+inttostr(Global.TENANT_ID)+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
end;

procedure TSyncFactory.SetTicket;
begin
  _Start := GetTickCount;
end;

procedure TSyncFactory.SetWorking(const Value: boolean);
begin
  FWorking := Value;
end;

procedure TSyncFactory.SyncAll;
var
  i:integer;
begin
  StopSyncTask;
  if CaFactory.CheckDebugSync then Exit;
  EndTimeStamp := 0;
  CommandPush.ExecuteCommand;
  InterlockedIncrement(Locked);
  Working := true;
  try
  frmLogo.Show;
  frmDesk.Waited := true;
  try
  try
    CaFactory.AutoCoLogo;
  except
    on E:Exception do
      begin
        LogFile.AddLogFile(0,'ͬ��������֤ʧ��,����:'+E.Message);
        Raise;
      end;
  end;
  SyncComm := CheckRemeteData;
  SyncTimeStamp := CaFactory.TimeStamp;
  SyncFactory.InitList;
  frmLogo.ProgressBar1.Max := FList.Count;
  for i:=0 to FList.Count -1 do
    begin
      frmLogo.ShowTitle := '����ͬ��<'+PSynTableInfo(FList[i])^.tbtitle+'>...';
      Application.ProcessMessages;
      frmLogo.BringToFront;
      case PSynTableInfo(FList[i])^.synFlag of
      0,1,2,3,4,10,20,21,22,23,29:SyncSingleTable(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      5:SyncStockOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      6:SyncSalesOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      7:SyncChangeOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      8:SyncStkIndentOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      9:SyncSalIndentOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      11:SyncIoroOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      12:SyncTransOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      13:SyncRecvOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      14:SyncPayOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      15:SyncDaysCloseOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      16:SyncMonthCloseOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      17:SyncCloseForDay(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      18:SyncPriceOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      19:SyncCheckOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      25:SyncCaModule(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      26:SyncSysReport(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      27:SyncIcGlideOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      28:SyncCaLoginInfo(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      30:SyncBomOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      end;
      frmLogo.Position := i;
    end;
    SetSynTimeStamp('#',SyncTimeStamp,'#');
    SetSynTimeStamp('AUTO',SyncTimeStamp,'#');
    frmLogo.ShowTitle := '����ͬ��<Rim��ز���>...';
    SyncRim;
  finally
    frmLogo.Close;
    frmDesk.Waited := false;
  end;
  finally
    Working := false;
    InterlockedDecrement(Locked);
    ReadTimeStamp;
  end;
end;

procedure TSyncFactory.SyncBasic(gbl:boolean=true);
var
  i:integer;
begin
  if CaFactory.CheckDebugSync then Exit;
  EndTimeStamp := 0;
  CommandPush.ExecuteCommand;
  Working := true;
  InterlockedIncrement(Locked);
  try
  if gbl then SyncComm := CheckRemeteData;
  frmLogo.Show;
  frmDesk.Waited := true;
  try
  SyncTimeStamp := CaFactory.TimeStamp;
  SyncFactory.InitList;
  frmLogo.ProgressBar1.Max := FList.Count;
  for i:=0 to FList.Count -1 do
    begin
      frmLogo.ShowTitle := '����ͬ��<'+PSynTableInfo(FList[i])^.tbtitle+'>...';
      Application.ProcessMessages;
      frmLogo.BringToFront;
      case PSynTableInfo(FList[i])^.synFlag of
      0,1,2,3,4,10,20,21,22,23,29:
        begin
          if gbl then SyncSingleTable(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
        end;
      18:if not gbl then SyncPriceOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      25:if gbl then SyncCaModule(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      26:if gbl then SyncSysReport(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      30:if not gbl then SyncBomOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      end;
      frmLogo.Position := i;
    end;
    SetSynTimeStamp('#',SyncTimeStamp,'#');
  finally
    frmDesk.Waited := false;
    frmLogo.Close;
  end;
  finally
    InterlockedDecrement(Locked);
    ReadTimeStamp;
    Working := false;
  end;
end;

procedure TSyncFactory.SyncCaLoginInfo(tbName, KeyFields,
  ZClassName: string; KeyFlag: integer);
begin
  SendSingleTable('CA_LOGIN_INFO','TENANT_ID;LOGIN_ID',ZClassName);
  SendSingleTable('CA_MODULE_CLICK','TENANT_ID;ROWS_ID',ZClassName);
end;

procedure TSyncFactory.SyncCaModule(tbName, KeyFields, ZClassName: string;
  KeyFlag: integer);
var
  cs,rs:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName);
  Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 1;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('PROD_ID').AsString := ProductId;
  if not (Factor=Global.LocalFactory) then
  begin
    LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
    cs := TZQuery.Create(nil);
    rs := TZQuery.Create(nil);
    try
      Params.ParamByName('SYN_COMM').AsBoolean := false;
      //�Է�����Ϊ��������
      cs.Close;
      rs.Close;
      SetTicket;
      Global.RemoteFactory.Open(rs,ZClassName,Params);
      LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(rs.RecordCount));
      SetTicket;
      cs.SyncDelta := rs.SyncDelta;
      if not cs.IsEmpty then
      Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
      LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    finally
      rs.Free;
      cs.Free;
    end;
  end;
  if (Factor=Global.LocalFactory) then
  begin
    cs := TZQuery.Create(nil);
    rs := TZQuery.Create(nil);
    try
      Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
      //�ϴ���������
      cs.Close;
      rs.Close;
      SetTicket;
      Global.LocalFactory.Open(cs,ZClassName,Params);
      LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(cs.RecordCount));
      SetTicket;
      rs.SyncDelta := cs.SyncDelta;
      if not rs.IsEmpty then
      Global.RemoteFactory.UpdateBatch(rs,ZClassName,Params);
      LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    finally
      rs.Free;
      cs.Free;
    end;
  end;
  SetSynTimeStamp(tbName,SyncTimeStamp);
end;

procedure TSyncFactory.SyncChangeOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,cs_l,rs_h,rs_d,rs_l:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_l := TZQuery.Create(nil);
  rs_l := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'CHANGE_DATE',Global.LocalFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<��������>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         cs_l.Close;
         rs_h.Close;
         rs_d.Close;
         rs_l.Close;

         Params.ParamByName('CHANGE_ID').AsString := ls.FieldbyName('CHANGE_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncChangeOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncChangeData',Params);
           Global.RemoteFactory.AddBatch(rs_l,'TSyncLocusForChagData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;
         cs_l.SyncDelta := rs_l.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncChangeOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncChangeData',Params);
           Global.LocalFactory.AddBatch(cs_l,'TSyncLocusForChagData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_l.Free;
    cs_l.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_l := TZQuery.Create(nil);
  rs_l := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'CHANGE_DATE',Global.RemoteFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<��������>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         cs_l.Close;
         rs_h.Close;
         rs_d.Close;
         rs_l.Close;

         Params.ParamByName('CHANGE_ID').AsString := ls.FieldbyName('CHANGE_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncChangeOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncChangeData',Params);
           Global.LocalFactory.AddBatch(cs_l,'TSyncLocusForChagData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;
         rs_l.SyncDelta := cs_l.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncChangeOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncChangeData',Params);
           Global.RemoteFactory.AddBatch(rs_l,'TSyncLocusForChagData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_l.Free;
    cs_l.Free;
  end;
end;

procedure TSyncFactory.SyncCheckOrder(tbName, KeyFields,
  ZClassName: string; KeyFlag: integer);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<�̵㵥��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('PRINT_DATE').AsInteger := ls.FieldbyName('PRINT_DATE').AsInteger;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncCheckOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncCheckData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncCheckOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncCheckData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<�̵㵥��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('PRINT_DATE').AsInteger := ls.FieldbyName('PRINT_DATE').AsInteger;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncCheckOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncCheckData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncCheckOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncCheckData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncCloseForDay(tbName, KeyFields,
  ZClassName: string; KeyFlag:integer=0);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         //�Է�����Ϊ��������
         frmLogo.ShowTitle := '��������<�������>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('CLSE_DATE').AsInteger := ls.FieldbyName('CLSE_DATE').AsInteger;
         Params.ParamByName('CREA_USER').AsString := ls.FieldbyName('CREA_USER').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncCloseForDay',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncCloseForDayAble',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncCloseForDay',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncCloseForDayAble',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<�������>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('CLSE_DATE').AsInteger := ls.FieldbyName('CLSE_DATE').AsInteger;
         Params.ParamByName('CREA_USER').AsString := ls.FieldbyName('CREA_USER').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncCloseForDay',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncCloseForDayAble',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncCloseForDay',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncCloseForDayAble',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncForDay;
var
  i:integer;
begin
  StopSyncTask;
  if CaFactory.CheckDebugSync then Exit;
  EndTimeStamp := 0;
  InterlockedIncrement(Locked);
  Working := true;
  try
  frmLogo.Show;
  frmDesk.Waited := true;
  try
  try
    CaFactory.AutoCoLogo;
  except
    on E:Exception do
      begin
        LogFile.AddLogFile(0,'ͬ��������֤ʧ��,����:'+E.Message);
        Raise;
      end;
  end;
  SyncComm := CheckRemeteData;
  SyncTimeStamp := CaFactory.TimeStamp;
  SyncFactory.InitList;
  frmLogo.ProgressBar1.Max := FList.Count;
  CommandPush.ExecuteCommand;
  for i:=0 to FList.Count -1 do
    begin
      frmLogo.ShowTitle := '����ͬ��<'+PSynTableInfo(FList[i])^.tbtitle+'>...';
      Application.ProcessMessages;
      frmLogo.BringToFront;
      case PSynTableInfo(FList[i])^.synFlag of
      6:SyncSalesOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      end;
      frmLogo.Position := i;
    end;
  finally
    frmLogo.Close;
    frmDesk.Waited := false;
  end;
  finally
    Working := false;
    InterlockedDecrement(Locked);
    ReadTimeStamp;
  end;
end;

procedure TSyncFactory.SyncDaysCloseOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,cs_s,cs_c,rs_h,rs_d,rs_s,rs_c:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  cs_c := TZQuery.Create(nil);
  rs_c := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<��̨��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;
         cs_s.Close;
         rs_s.Close;
         cs_c.Close;
         rs_c.Close;

         Params.ParamByName('CREA_DATE').AsInteger := ls.FieldbyName('CREA_DATE').AsInteger;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncRckDaysClose',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncRckGodsDaysOrder',Params);
           Global.RemoteFactory.AddBatch(rs_s,'TSyncRckAcctDaysOrder',Params);
           Global.RemoteFactory.AddBatch(rs_c,'TSyncRckCGodsDays',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;
         cs_s.SyncDelta := rs_s.SyncDelta;
         cs_c.SyncDelta := rs_c.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncRckDaysClose',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncRckGodsDaysOrder',Params);
           Global.LocalFactory.AddBatch(cs_s,'TSyncRckAcctDaysOrder',Params);
           Global.LocalFactory.AddBatch(cs_c,'TSyncRckCGodsDays',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_s.Free;
    cs_s.Free;
    rs_c.Free;
    cs_c.Free;
  end;

  if (SFVersion='.NET') and not Global.Debug then //������ֻ�������ˣ����ϴ�
     begin
       SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
       Exit;
     end;
  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  cs_c := TZQuery.Create(nil);
  rs_c := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<��̨��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;
         cs_s.Close;
         rs_s.Close;
         cs_c.Close;
         rs_c.Close;

         Params.ParamByName('CREA_DATE').AsInteger := ls.FieldbyName('CREA_DATE').AsInteger;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncRckDaysClose',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncRckGodsDaysOrder',Params);
           Global.LocalFactory.AddBatch(cs_s,'TSyncRckAcctDaysOrder',Params);
           Global.LocalFactory.AddBatch(cs_c,'TSyncRckCGodsDays',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;
         rs_s.SyncDelta := cs_s.SyncDelta;
         rs_c.SyncDelta := cs_c.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncRckDaysClose',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncRckGodsDaysOrder',Params);
           Global.RemoteFactory.AddBatch(rs_s,'TSyncRckAcctDaysOrder',Params);
           Global.RemoteFactory.AddBatch(rs_c,'TSyncRckCGodsDays',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_s.Free;
    cs_s.Free;
    rs_c.Free;
    cs_c.Free;
  end;
end;

procedure TSyncFactory.SyncIcGlideOrder(tbName, KeyFields,
  ZClassName: string; KeyFlag: integer);
var
  cs,rs:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('PROD_ID').AsString := ProductId;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    //�Է�����Ϊ��������
    cs.Close;
    rs.Close;
    SetTicket;
    Global.RemoteFactory.Open(rs,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(rs.RecordCount));
    SetTicket;
    cs.SyncDelta := rs.SyncDelta;
    if not cs.IsEmpty then
    Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    rs.Free;
    cs.Free;
  end;

  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    //�ϴ���������
    cs.Close;
    rs.Close;
//    Global.LocalFactory.BeginTrans;
//    try
      SetTicket;
      Global.LocalFactory.Open(cs,ZClassName,Params);
      LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(cs.RecordCount));
      if not cs.IsEmpty then
      begin
        SetTicket;
        rs.SyncDelta := cs.SyncDelta;
        cs.Delete;
        if not rs.IsEmpty then
           Global.RemoteFactory.UpdateBatch(rs,ZClassName,Params);
        Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
        LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
      end;
      SetSynTimeStamp(tbName,SyncTimeStamp);
//      Global.LocalFactory.CommitTrans;
//    except
//      Global.LocalFactory.RollbackTrans;
//      Raise;
//    end;
  finally
    rs.Free;
    cs.Free;
  end;
end;

procedure TSyncFactory.SyncIoroOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'IORO_DATE',Global.LocalFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<����֧��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('IORO_ID').AsString := ls.FieldbyName('IORO_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncIoroOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncIoroData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncIoroOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncIoroData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'IORO_DATE',Global.RemoteFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<����֧��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('IORO_ID').AsString := ls.FieldbyName('IORO_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncIoroOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncIoroData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncIoroOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncIoroData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

function TSyncFactory.SyncLockCheck: boolean;
var
  rs:TZQuery;
  rid,cid:string;
begin
  result := true;
  if (SFVersion='.ONL') or Global.Debug then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE='''+'DBKEY_'+Global.SHOP_ID+''' and TENANT_ID='+inttostr(Global.TENANT_ID);
    Global.LocalFactory.Open(rs);
    cid := rs.Fields[0].AsString;
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE='''+'DBKEY_'+Global.SHOP_ID+''' and TENANT_ID='+inttostr(Global.TENANT_ID);
    Global.RemoteFactory.Open(rs);
    rid := rs.Fields[0].AsString;
    result := (rid=cid) or (rid='');
  finally
    rs.Free;
  end;
end;

function TSyncFactory.SyncLockDb: boolean;
var
  id:string;
  rs:TZQuery;
begin
  result := true;
  if (SFVersion='.ONL') or Global.Debug then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE='''+'DBKEY_'+Global.SHOP_ID+''' and TENANT_ID='+inttostr(Global.TENANT_ID);
    Global.RemoteFactory.Open(rs);
    if rs.Fields[0].AsString<>'' then Exit;
  finally
    rs.Free;
  end;
  if not CaFactory.Audited then Raise Exception.Create('ֻ������ģʽ���ܲ������ݿ��������ܡ�');
  if ShowMsgBox('�Ƿ�������ǰ����Ϊ���ŵ�ר�õ��ԣ�','������ʾ...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  id := TSequence.NewId;
  Global.RemoteFactory.BeginTrans;
  Global.LocalFactory.BeginTrans;
  try
    Global.RemoteFactory.ExecSQL('delete from SYS_DEFINE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and DEFINE = '''+'DBKEY_'+Global.SHOP_ID+'''');
    Global.RemoteFactory.ExecSQL('insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values('+inttostr(Global.TENANT_ID)+','''+'DBKEY_'+Global.SHOP_ID+''','''+id+''',0,''00'',0)');
    Global.LocalFactory.ExecSQL('delete from SYS_DEFINE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and DEFINE = '''+'DBKEY_'+Global.SHOP_ID+'''');
    Global.LocalFactory.ExecSQL('insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values('+inttostr(Global.TENANT_ID)+','''+'DBKEY_'+Global.SHOP_ID+''','''+id+''',0,''00'',0)');
    Global.RemoteFactory.CommitTrans;
    Global.LocalFactory.CommitTrans;
  except
    Global.RemoteFactory.RollbackTrans;
    Global.LocalFactory.RollbackTrans;
    Raise;
  end;
end;

procedure TSyncFactory.SyncMonthCloseOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,cs_s,rs_h,rs_d,rs_s:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<��̨��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;
         cs_s.Close;
         rs_s.Close;

         Params.ParamByName('MONTH').AsInteger := ls.FieldbyName('MONTH').AsInteger;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncRckMonthClose',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncRckGodsMonthOrder',Params);
           Global.RemoteFactory.AddBatch(rs_s,'TSyncRckAcctMonthOrder',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;
         cs_s.SyncDelta := rs_s.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncRckMonthClose',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncRckGodsMonthOrder',Params);
           Global.LocalFactory.AddBatch(cs_s,'TSyncRckAcctMonthOrder',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_s.Free;
    cs_s.Free;
  end;

  if (SFVersion='.NET') and not Global.Debug then //������ֻ�������ˣ����ϴ�
     begin
       SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
       Exit;
     end;
  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<��̨��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;
         cs_s.Close;
         rs_s.Close;

         Params.ParamByName('MONTH').AsInteger := ls.FieldbyName('MONTH').AsInteger;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncRckMonthClose',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncRckGodsMonthOrder',Params);
           Global.LocalFactory.AddBatch(cs_s,'TSyncRckAcctMonthOrder',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;
         rs_s.SyncDelta := cs_s.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncRckMonthClose',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncRckGodsMonthOrder',Params);
           Global.RemoteFactory.AddBatch(rs_s,'TSyncRckAcctMonthOrder',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_s.Free;
    cs_s.Free;
  end;
end;

procedure TSyncFactory.SyncPayOrder(tbName, KeyFields, ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'PAY_DATE',Global.LocalFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<���>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('PAY_ID').AsString := ls.FieldbyName('PAY_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncPayOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncPayData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncPayOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncPayData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'PAY_DATE',Global.RemoteFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<���>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('PAY_ID').AsString := ls.FieldbyName('PAY_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncPayOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncPayData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncPayOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncPayData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncPriceOrder(tbName, KeyFields,
  ZClassName: string; KeyFlag: integer);
var
  ls,cs_h,cs_d,cs_s,rs_h,rs_d,rs_s:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<��������>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;
         cs_s.Close;
         rs_s.Close;

         Params.ParamByName('PROM_ID').AsString := ls.FieldbyName('PROM_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncPriceOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncPriceData',Params);
           Global.RemoteFactory.AddBatch(rs_s,'TSyncPromShop',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;
         cs_s.SyncDelta := rs_s.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncPriceOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncPriceData',Params);
           Global.LocalFactory.AddBatch(cs_s,'TSyncPromShop',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_s.Free;
    cs_s.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<��������>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;
         cs_s.Close;
         rs_s.Close;

         Params.ParamByName('PROM_ID').AsString := ls.FieldbyName('PROM_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncPriceOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncPriceData',Params);
           Global.LocalFactory.AddBatch(cs_s,'TSyncPromShop',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;
         rs_s.SyncDelta := cs_s.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncPriceOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncPriceData',Params);
           Global.RemoteFactory.AddBatch(rs_s,'TSyncPromShop',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_s.Free;
    cs_s.Free;
  end;
end;

procedure TSyncFactory.SyncQuestion(tbName, KeyFields, ZClassName: string;
  KeyFlag: integer);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 1;
  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<�ʾ����>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('QUESTION_ID').AsString := ls.FieldbyName('QUESTION_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncMscQuestion',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncMscQuestionItem',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncMscQuestion',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncMscQuestionItem',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<�ʾ����>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('QUESTION_ID').AsString := ls.FieldbyName('QUESTION_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncMscQuestion',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncMscQuestionItem',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncMscQuestion',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncMscQuestionItem',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncRckClose(DataSet: TZQuery; FieldName: string;
  lFactor: TdbFactory);
var isUpdate:boolean;
begin
    isUpdate := false;
    DataSet.First;
    while not DataSet.Eof do
      begin
        if lFactor=Global.LocalFactory then
           begin
             if DataSet.FieldByName(FieldName).AsInteger < rDate then
                begin
                   rDate := DataSet.FieldByName(FieldName).AsInteger;
                   isUpdate := true;
                end;
           end
        else
           begin
             if DataSet.FieldByName(FieldName).AsInteger < lDate then
                begin
                   lDate := DataSet.FieldByName(FieldName).AsInteger;
                   isUpdate := true;
                end;
           end;
        DataSet.Next;
      end;
    if isUpdate then
      begin
        if lFactor=Global.LocalFactory then
           begin
             Params.ParamByName('CLSE_DATE').AsInteger := rDate;
             Params.ParamByName('MOTH_DATE').AsString := formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(inttostr(rDate)));
           end
        else
           begin
             Params.ParamByName('CLSE_DATE').AsInteger := lDate;
             Params.ParamByName('MOTH_DATE').AsString := formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(inttostr(lDate)));
           end;
        lFactor.ExecProc('TSyncDeleteRckClose',Params);
      end;
      
end;

procedure TSyncFactory.SyncRecvOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'RECV_DATE',Global.LocalFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<�տ>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('RECV_ID').AsString := ls.FieldbyName('RECV_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncRecvOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncRecvData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncRecvOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncRecvData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'RECV_DATE',Global.RemoteFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<�տ>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('RECV_ID').AsString := ls.FieldbyName('RECV_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncRecvOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncRecvData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncRecvOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncRecvData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncRim;
var
  Params:TftParamList;
begin
  if CaFactory.CheckDebugSync then Exit;
  //��������ʱ����ͬ��
  if Global.RemoteFactory.ConnMode = 1 then Exit;
  if not CaFactory.Audited then Exit;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    Params.ParamByName('SALES_DATE').AsString := formatDatetime('YYYYMMDD',Date());
    Params.ParamByName('flag').AsInteger := 3;
    try
      Global.RemoteFactory.ExecProc('TSyncRimInfo',Params);
    except
      on E:Exception do
         ShowMsgBox(pchar('�����޷�ͬ����RIMƽ̨,��֪ͨ�ͷ���Ա,����:'+E.Message),'������ʾ...',MB_OK+MB_ICONINFORMATION);
    end;
  finally
    Params.Free;
  end;
end;

procedure TSyncFactory.SyncSalesOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,cs_l,rs_h,rs_d,rs_l:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_l := TZQuery.Create(nil);
  rs_l := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'SALES_DATE',Global.LocalFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         //�Է�����Ϊ��������
         frmLogo.ShowTitle := '��������<���ⵥ��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         cs_l.Close;
         rs_h.Close;
         rs_d.Close;
         rs_l.Close;

         Params.ParamByName('SALES_ID').AsString := ls.FieldbyName('SALES_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncSalesOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncSalesData',Params);
           Global.RemoteFactory.AddBatch(rs_l,'TSyncLocusForSaleData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;
         cs_l.SyncDelta := rs_l.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncSalesOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncSalesData',Params);
           Global.LocalFactory.AddBatch(cs_l,'TSyncLocusForSaleData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_l.Free;
    cs_l.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_l := TZQuery.Create(nil);
  rs_l := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'SALES_DATE',Global.RemoteFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<���ⵥ��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         cs_l.Close;
         rs_h.Close;
         rs_d.Close;
         rs_l.Close;

         Params.ParamByName('SALES_ID').AsString := ls.FieldbyName('SALES_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncSalesOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncSalesData',Params);
           Global.LocalFactory.AddBatch(cs_l,'TSyncLocusForSaleData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;
         rs_l.SyncDelta := cs_l.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncSalesOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncSalesData',Params);
           Global.RemoteFactory.AddBatch(rs_l,'TSyncLocusForSaleData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_l.Free;
    cs_l.Free;
  end;
end;

procedure TSyncFactory.SyncSalIndentOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<���۶���>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
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
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<���۶���>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
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
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncSingleTable(tbName, KeyFields,ZClassName: string;KeyFlag:integer=0;onlyDown:boolean=false;timeStampNoChg:integer=1);
var
  cs,rs:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName);
  Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := timeStampNoChg;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('PROD_ID').AsString := ProductId;
  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    //�Է�����Ϊ��������
    cs.Close;
    rs.Close;
    SetTicket;
    Global.RemoteFactory.Open(rs,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(rs.RecordCount));
    SetTicket;
    cs.SyncDelta := rs.SyncDelta;
    if not cs.IsEmpty then
    Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    rs.Free;
    cs.Free;
  end;
  if onlyDown then
     begin
       SetSynTimeStamp(tbName,SyncTimeStamp);
       Exit;
     end;
  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    //�ϴ���������
    cs.Close;
    rs.Close;
    SetTicket;
    Global.LocalFactory.Open(cs,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(cs.RecordCount));
    if not cs.IsEmpty then
    begin
      //Global.LocalFactory.BeginTrans;
      //try
        SetTicket;
        rs.SyncDelta := cs.SyncDelta;
        cs.Delete;
        if not rs.IsEmpty then
           Global.RemoteFactory.UpdateBatch(rs,ZClassName,Params);
        Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
        LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
      //  Global.LocalFactory.CommitTrans;
      //except
      //  Global.LocalFactory.RollbackTrans;
      //  Raise;
      //end;
    end;
    SetSynTimeStamp(tbName,SyncTimeStamp);
  finally
    rs.Free;
    cs.Free;
  end;
end;

procedure TSyncFactory.SyncStkIndentOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<�ɹ�����>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
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
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<�ɹ�����>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
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
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncStockOrder(tbName,KeyFields,ZClassName:string;KeyFlag:integer=0);
var
  ls,cs_h,cs_d,cs_l,rs_h,rs_d,rs_l:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_l := TZQuery.Create(nil);
  rs_l := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'STOCK_DATE',Global.LocalFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<��ⵥ��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         cs_l.Close;
         rs_h.Close;
         rs_d.Close;
         rs_l.Close;

         Params.ParamByName('STOCK_ID').AsString := ls.FieldbyName('STOCK_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncStockOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncStockData',Params);
           Global.RemoteFactory.AddBatch(rs_l,'TSyncLocusForStckData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;
         cs_l.SyncDelta := rs_l.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncStockOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncStockData',Params);
           Global.LocalFactory.AddBatch(cs_l,'TSyncLocusForStckData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_l.Free;
    cs_l.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_l := TZQuery.Create(nil);
  rs_l := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SyncRckClose(ls,'STOCK_DATE',Global.RemoteFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<��ⵥ��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         cs_l.Close;
         rs_h.Close;
         rs_d.Close;
         rs_l.Close;

         Params.ParamByName('STOCK_ID').AsString := ls.FieldbyName('STOCK_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncStockOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncStockData',Params);
           Global.LocalFactory.AddBatch(cs_l,'TSyncLocusForStckData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;
         rs_l.SyncDelta := cs_l.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncStockOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncStockData',Params);
           Global.RemoteFactory.AddBatch(rs_l,'TSyncLocusForStckData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
    rs_l.Free;
    cs_l.Free;
  end;
end;

procedure TSyncFactory.SyncSysReport(tbName, KeyFields, ZClassName: string;
  KeyFlag: integer);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<����ģ��>'+inttostr(ls.RecNo)+'��';
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('REPORT_ID').AsString := ls.FieldbyName('REPORT_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncSysReport',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncSysReportTemplate',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;
         if not cs_h.IsEmpty then
         begin
           Global.LocalFactory.BeginBatch;
           try
             Global.LocalFactory.AddBatch(cs_h,'TSyncSysReport',Params);
             Global.LocalFactory.AddBatch(cs_d,'TSyncSysReportTemplate',Params);
             Global.LocalFactory.CommitBatch;
           except
             Global.LocalFactory.CancelBatch;
             Raise;
           end;
         end;
         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<����ģ��>'+inttostr(ls.RecNo)+'��';
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('REPORT_ID').AsString := ls.FieldbyName('REPORT_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncSysReport',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncSysReportTemplate',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;
         if not rs_h.IsEmpty then
         begin
           Global.RemoteFactory.BeginBatch;
           try
             Global.RemoteFactory.AddBatch(rs_h,'TSyncSysReport',Params);
             Global.RemoteFactory.AddBatch(rs_d,'TSyncSysReportTemplate',Params);
             Global.RemoteFactory.CommitBatch;
           except
             Global.RemoteFactory.CancelBatch;
             Raise;
           end;
         end;
         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
    SetSynTimeStamp(tbName,SyncTimeStamp,Global.SHOP_ID);
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncThread(Sender: TObject);
var
  i:integer;
  sdate:Tdatetime;
begin
  if Working then Exit;
  Stoped := false;
  Working := true;
  if Sender=nil then frmLogo.Show;
  InterlockedIncrement(Locked);
  try
    try
      CaFactory.AutoCoLogo;
    except
      on E:Exception do
        begin
          LogFile.AddLogFile(0,'ͬ��������֤ʧ��,����:'+E.Message);
          Raise;
        end;
    end;

  sdate := CaFactory.TimeStamp / 86400.0+40542.0 +2;  //delphi �µ�date����01��ʼ�㣬����Ҫ��2
  sdate := fnTime.fnStrtoDate(formatDatetime('YYYYMMDD',sdate));  {�µ�ʱ�䣬ת���㳿ʱ��}
  EndTimeStamp := round(( (sdate-2) -40542)*86400);

  SyncComm := CheckRemeteData;
  SyncTimeStamp := CaFactory.TimeStamp;
  SyncFactory.InitList;
  if Sender=nil then frmLogo.ProgressBar1.Max := FList.Count;
  for i:=0 to FList.Count -1 do
    begin
      if Sender=nil then
         begin
           frmLogo.ShowTitle := '����ͬ��<'+PSynTableInfo(FList[i])^.tbtitle+'>...';
           Application.ProcessMessages;
           frmLogo.BringToFront;
         end;
      if Stoped then Exit;
      case PSynTableInfo(FList[i])^.synFlag of
      5:SyncStockOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      6:SyncSalesOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      7:SyncChangeOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      8:SyncStkIndentOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      9:SyncSalIndentOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      11:SyncIoroOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      12:SyncTransOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      13:SyncRecvOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      14:SyncPayOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      15:SyncDaysCloseOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      16:SyncMonthCloseOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      17:SyncCloseForDay(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      18:SyncPriceOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      19:SyncCheckOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      27:SyncIcGlideOrder(PSynTableInfo(FList[i])^.tbname,PSynTableInfo(FList[i])^.keyFields,GetFactoryName(PSynTableInfo(FList[i])),PSynTableInfo(FList[i])^.KeyFlag);
      end;
      if Sender=nil then frmLogo.Position := i;
    end;
    SetSynTimeStamp('AUTO',EndTimeStamp,'#');
  finally
    InterlockedDecrement(Locked);
    ReadTimeStamp;
    Working := false;
    EndTimeStamp := 0;
    if Sender=nil then frmLogo.Close;
  end;
end;

procedure TSyncFactory.SyncTransOrder(tbName, KeyFields,
  ZClassName: string;KeyFlag:integer=0);
var
  cs,rs:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('PROD_ID').AsString := ProductId;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    //�Է�����Ϊ��������
    cs.Close;
    rs.Close;
    SetTicket;
    Global.RemoteFactory.Open(rs,ZClassName,Params);
    SyncRckClose(rs,'TRANS_DATE',Global.LocalFactory);

    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(rs.RecordCount));
    SetTicket;
    cs.SyncDelta := rs.SyncDelta;
    if not cs.IsEmpty then
    Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    rs.Free;
    cs.Free;
  end;

  cs := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    //�ϴ���������
    cs.Close;
    rs.Close;
    SetTicket;
    Global.LocalFactory.Open(cs,ZClassName,Params);
    SyncRckClose(cs,'TRANS_DATE',Global.RemoteFactory);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(cs.RecordCount));
    if not cs.IsEmpty then
    begin
      SetTicket;
      rs.SyncDelta := cs.SyncDelta;
      cs.Delete;
      //Global.LocalFactory.BeginTrans;
      //try
        if not rs.IsEmpty then
           Global.RemoteFactory.UpdateBatch(rs,ZClassName,Params);
        Global.LocalFactory.UpdateBatch(cs,ZClassName,Params);
        LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
      //  Global.LocalFactory.CommitTrans;
      //except
      //  Global.LocalFactory.RollbackTrans;
      //  Raise;
      //end;
    end;
    SetSynTimeStamp(tbName,SyncTimeStamp);
  finally
    rs.Free;
    cs.Free;
  end;
end;

function TSyncFactory.SyncUnLockDb: boolean;
begin
  if (SFVersion='.ONL') or Global.Debug then Exit;
  if Global.UserID<>'system' then Raise Exception.Create('ֻ�г�������Ա����Զ�����ݿ���н���');
  if not CaFactory.Audited then Raise Exception.Create('ֻ������ģʽ���ܲ������ݿ�������ܡ�');
  if ShowMsgBox('���Ƿ���Ҫ�Ա���ҵ�������ŵ����׽��н�����','������ʾ...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  Global.RemoteFactory.ExecSQL('delete from SYS_DEFINE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and DEFINE like ''DBKEY_%''');
  ShowMsgBox('�����ɹ���','������ʾ...',MB_OK+MB_ICONINFORMATION);
end;

procedure TSyncFactory.SyncBomOrder(tbName, KeyFields, ZClassName: string;
  KeyFlag: integer);
var
  ls,cs_h,cs_d,rs_h,rs_d:TZQuery;
begin
  Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Params.ParamByName('KEY_FLAG').AsInteger := KeyFlag;
  Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Params.ParamByName('TABLE_NAME').AsString := tbName;
  Params.ParamByName('KEY_FIELDS').AsString := KeyFields;
  Params.ParamByName('TIME_STAMP').Value := GetSynTimeStamp(tbName,Global.SHOP_ID);
  Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

  if EndTimeStamp>0 then //���ý�ֹʱ�䣬��EndTimeStamp
     Params.ParamByName('SYN_TIME_STAMP').Value := EndTimeStamp
  else
     Params.ParamByName('SYN_TIME_STAMP').Value := SyncTimeStamp;
  Params.ParamByName('END_TIME_STAMP').Value := EndTimeStamp;
  //����ϴ��ϱ�ʱ�䣬���ڵȽ�ֹʱ���ʱ������Ҫͬ��
  if (EndTimeStamp>0) and (Params.ParamByName('TIME_STAMP').Value>=EndTimeStamp) then Exit;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+Params.ParamByName('TIME_STAMP').asString+'  ����ʱ��:'+inttostr(SyncTimeStamp));
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := false;
    SetTicket;
    Global.RemoteFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'����<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    //SyncRckClose(ls,'BOM_DATE',Global.LocalFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '��������<����֧��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         //�Է�����Ϊ��������
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('BOM_ID').AsString := ls.FieldbyName('BOM_ID').AsString;
         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncBomOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncBomData',Params);
           Global.RemoteFactory.OpenBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         cs_h.SyncDelta := rs_h.SyncDelta;
         cs_d.SyncDelta := rs_d.SyncDelta;

         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncBomOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncBomData',Params);
           Global.LocalFactory.CommitBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'����<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    ls.Free;
    rs_h.Free;
    cs_h.Free;
    rs_d.Free;
    cs_d.Free;
  end;

  //�´�
  ls := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  try
    Params.ParamByName('SYN_COMM').AsBoolean := SyncComm;
    SetTicket;
    Global.LocalFactory.Open(ls,ZClassName,Params);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    //SyncRckClose(ls,'BOM_DATE',Global.RemoteFactory);
    SetTicket;
    ls.First;
    while not ls.Eof do
       begin
         frmLogo.ShowTitle := '�����ϴ�<����֧��>'+inttostr(ls.RecNo)+'��';
         Application.ProcessMessages;
         cs_h.Close;
         cs_d.Close;
         rs_h.Close;
         rs_d.Close;

         Params.ParamByName('BOM_ID').AsString := ls.FieldbyName('BOM_ID').AsString;
         Global.LocalFactory.BeginBatch;
         try
           Global.LocalFactory.AddBatch(cs_h,'TSyncBomOrder',Params);
           Global.LocalFactory.AddBatch(cs_d,'TSyncBomData',Params);
           Global.LocalFactory.OpenBatch;
         except
           Global.LocalFactory.CancelBatch;
           Raise;
         end;

         rs_h.SyncDelta := cs_h.SyncDelta;
         rs_d.SyncDelta := cs_d.SyncDelta;

         Global.RemoteFactory.BeginBatch;
         try
           Global.RemoteFactory.AddBatch(rs_h,'TSyncBomOrder',Params);
           Global.RemoteFactory.AddBatch(rs_d,'TSyncBomData',Params);
           Global.RemoteFactory.CommitBatch;
         except
           Global.RemoteFactory.CancelBatch;
           Raise;
         end;

         ls.Next;
       end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
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
