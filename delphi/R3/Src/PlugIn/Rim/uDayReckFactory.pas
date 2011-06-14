unit uDayReckFactory;

interface

uses
  SysUtils, Variants, Classes,  Windows, Controls, Dialogs, DB, zDataSet, zIntf,
  zBase, uBaseSyncFactory, uRimSyncFactory;


//������Ʒ��̨��
type
  TGodsDayReck=class
  private
    tempTableName: string; //��ʱ����
    pt,pc:integer;
    isfirst:boolean;
    reck_flag:integer;
    reck_day:integer;
    //���Ա���
    Fcflag: integer;
    FcDate: TDate;
    FbDate: TDate;
    FeDate: TDate;
    FmDate: TDate;
    FuDate: TDate;
    FTENANT_ID: string;
    FDBFactory: TRimSyncFactory;
    procedure Setcflag(const Value: integer);
    procedure SetcDate(const Value: TDate);
    procedure SetbDate(const Value: TDate);
    procedure SeteDate(const Value: TDate);
    procedure SetmDate(const Value: TDate);
    procedure SetuDate(const Value: TDate);
    procedure SetTENANT_ID(const Value: string);
    procedure SetDBFactory(const Value: TRimSyncFactory);
    function  GetDBType: integer;  //���ݿ�����
    function  GetPlugIntf: IPlugIn; //����ӿ�
    
    //����ǰ׼��
    procedure Prepare;
    procedure CreateTempTable;
    procedure PrepareDataForRck;

    //�ƶ�ƽ���ɱ�����<������ʱ��ƽ���Ӽ���>
    procedure Calc0;
    //�ռ�Ȩ�ƶ�ƽ���ɱ�����
    procedure Calc1;
    //�¼�Ȩ�ƶ�ƽ���ɱ�����
    procedure Calc2;

    function BeginTrans(TimeOut:integer=-1): Boolean; //��ʼ����
    function CommitTrans: Boolean;   //�ύ����
    function RollbackTrans: Boolean; //�ع�����
    function Open(DataSet: TDataSet):Boolean;  //ȡ����
  public
    //������̨�˹���:
    procedure CalcDayReck(TENANT_ID: string);
        
    //�ϴ��ս�����
    property cDate:TDate read FcDate write SetcDate;
    //���ν�������
    property eDate:TDate read FeDate write SeteDate;
    //�ϴ��½�����
    property bDate:TDate read FbDate write SetbDate;
    //�������
    property mDate:TDate read FmDate write SetmDate;
    //�����ݵ��������
    property uDate:TDate read FuDate write SetuDate;         
    //���㷽ʽ:1�ռ�Ȩ�ƶ�ƽ��; 2�¼�Ȩ��ƽ��; 3�Ƚ��ȳ�;
    property calc_flag:integer read Fcflag write Setcflag;
    //����ӿ�
    property PlugIntf: IPlugIn read GetPlugIntf; //����ӿ�
    //���ݿ�����
    property DBType: integer read GetDBType;
    //��ҵID
    property TENANT_ID: string Read FTENANT_ID write SetTENANT_ID;
    //���÷������ݶ���
    property DBFactory: TRimSyncFactory read FDBFactory write SetDBFactory; 
  end;

//������ϵͳ���ݶԽӵĻ���
type
  TDayReckSyncFactory=class(TRimSyncFactory)
  private
    DayReck: TGodsDayReck;
    //�ϱ�1�����ۻ���������̨������
    function GodsDayReckSync(vRimParam: TRimParams): integer;
  public
    constructor Create; override;
    destructor Destroy;override;
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;


implementation

uses uFnUtil;
  

{ TGodsDayReck }

procedure TGodsDayReck.Prepare;
var
  e: TDate;
  rs: TZQuery;
  flag: integer;
begin
  flag:=4; //����
  rs:= TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :='select * from sys_define where DEFINE in (''RECK_OPTION'',''RECK_DAY'',''CALC_FLAG'') ';
    Open(rs);
    if rs.Locate('DEFINE','RECK_OPTION',[]) then
      reck_flag := StrtoIntDef(rs.fieldbyName('VALUE').AsString,1);
    if rs.Locate('DEFINE','RECK_DAY',[]) then
      reck_day := StrtoIntDef(rs.fieldbyName('VALUE').AsString,28);
    if rs.Locate('DEFINE','CALC_FLAG',[]) then
      calc_flag := StrtoIntDef(rs.fieldbyName('VALUE').AsString,0);

    pc := 0;
    rs.Close;
    rs.SQL.Text := 'select max(CREA_DATE) from RCK_DAYS_CLOSE where TENANT_ID='+TENANT_ID+' ';
    Open(rs);
    isfirst := false;
    if rs.Fields[0].asString<>'' then
      cDate := fnTime.fnStrtoDate(rs.Fields[0].asString)
    else
    begin
      rs.Close;
      rs.SQL.Text :=  'select value from SYS_DEFINE where TENANT_ID='+TENANT_ID+' and DEFINE=''USING_DATE'' ';
      Open(rs);
      if rs.Fields[0].asString<>'' then
        cDate := fnTime.fnStrtoDate(rs.Fields[0].asString)-1
      else
        cDate := Date()-1;
      isfirst := true;
    end;

    rs.Close;
    rs.SQL.Text := 'select max(END_DATE) from RCK_MONTH_CLOSE where TENANT_ID='+TENANT_ID+'';
    Open(rs);
    if rs.Fields[0].asString<>'' then
       bDate := fnTime.fnStrtoDate(rs.Fields[0].asString)
    else
    begin
      rs.Close;
      rs.SQL.Text :=  'select value from SYS_DEFINE where TENANT_ID='+TENANT_ID+' and DEFINE=''USING_DATE'' ';
      Open(rs);
      if rs.Fields[0].asString<>'' then
        bDate := fnTime.fnStrtoDate(rs.Fields[0].asString)-1
      else
        bDate := Date()-1;
     isfirst := true;
    end;
    //û�ô���ɾ��
  finally
    rs.free;
  end;
end;

procedure TGodsDayReck.CreateTempTable;
var
  iRet: integer;
  SQL:string;
begin
  case DbType of
   0: tempTableName := '#TMP_GOODS_DAYS';
   5: begin tempTableName := 'TMP_GOODS_DAYS'; end;
   1: begin tempTableName := 'TMP_GOODS_DAYS'; end;
   4: tempTableName := 'session.TMP_GOODS_DAYS';
  end;

  case DbType of
   0:
    begin
      SQL :=
      'if OBJECT_ID(N''tempdb..'+tempTableName+''') is null '+
      'CREATE TABLE '+tempTableName+' ('+
      '	TENANT_ID int NOT NULL ,'+
      '	SHOP_ID varchar (13) NOT NULL ,'+
      '	CREA_DATE int NOT NULL ,'+
      '	GODS_ID varchar (36)  NOT NULL ,'+
      '	BATCH_NO varchar (36) NOT NULL ,'+
      '	NEW_INPRICE decimal(18, 3) NULL ,'+
      '	NEW_OUTPRICE decimal(18, 3) NULL ,'+
      '	ORG_AMT decimal(18, 3) NULL ,'+
      '	ORG_MNY decimal(18, 3) NULL ,'+
      '	ORG_RTL decimal(18, 3) NULL ,'+
      '	ORG_CST decimal(18, 3) NULL ,'+
      '	STOCK_AMT decimal(18, 3) NULL ,'+
      '	STOCK_MNY decimal(18, 3) NULL ,'+
      '	STOCK_TAX decimal(18, 3) NULL ,'+
      '	STOCK_RTL decimal(18, 3) NULL ,'+
      '	STOCK_AGO decimal(18, 3) NULL ,'+
      '	STKRT_AMT decimal(18, 3) NULL ,'+
      '	STKRT_MNY decimal(18, 3) NULL ,'+
      '	STKRT_TAX decimal(18, 3) NULL ,'+
      '	SALE_AMT decimal(18, 3) NULL ,'+
      '	SALE_RTL decimal(18, 3) NULL ,'+
      '	SALE_AGO decimal(18, 3) NULL ,'+
      '	SALE_MNY decimal(18, 3) NULL ,'+
      '	SALE_TAX decimal(18, 3) NULL ,'+
      '	SALE_CST decimal(18, 3) NULL ,'+
      '	COST_PRICE decimal(18, 6) NULL ,'+
      '	SALE_PRF decimal(18, 3) NULL ,'+
      '	SALRT_AMT decimal(18, 3) NULL ,'+
      '	SALRT_MNY decimal(18, 3) NULL ,'+
      '	SALRT_TAX decimal(18, 3) NULL ,'+
      '	SALRT_CST decimal(18, 3) NULL ,'+
      '	DBIN_AMT decimal(18, 3) NULL ,'+
      '	DBIN_MNY decimal(18, 3) NULL ,'+
      '	DBIN_RTL decimal(18, 3) NULL ,'+
      '	DBIN_CST decimal(18, 3) NULL ,'+
      '	DBOUT_AMT decimal(18, 3) NULL ,'+
      '	DBOUT_MNY decimal(18, 3) NULL ,'+
      '	DBOUT_RTL decimal(18, 3) NULL ,'+
      '	DBOUT_CST decimal(18, 3) NULL ,'+
      '	CHANGE1_AMT decimal(18, 3) NULL ,'+
      '	CHANGE1_MNY decimal(18, 3) NULL ,'+
      '	CHANGE1_RTL decimal(18, 3) NULL ,'+
      '	CHANGE1_CST decimal(18, 3) NULL ,'+
      '	CHANGE2_AMT decimal(18, 3) NULL ,'+
      '	CHANGE2_MNY decimal(18, 3) NULL ,'+
      '	CHANGE2_RTL decimal(18, 3) NULL ,'+
      '	CHANGE2_CST decimal(18, 3) NULL ,'+
      '	CHANGE3_AMT decimal(18, 3) NULL ,'+
      '	CHANGE3_MNY decimal(18, 3) NULL ,'+
      '	CHANGE3_RTL decimal(18, 3) NULL ,'+
      '	CHANGE3_CST decimal(18, 3) NULL ,'+
      '	CHANGE4_AMT decimal(18, 3) NULL ,'+
      '	CHANGE4_MNY decimal(18, 3) NULL ,'+
      '	CHANGE4_RTL decimal(18, 3) NULL ,'+
      '	CHANGE4_CST decimal(18, 3) NULL ,'+
      '	CHANGE5_AMT decimal(18, 3) NULL ,'+
      '	CHANGE5_MNY decimal(18, 3) NULL ,'+
      '	CHANGE5_RTL decimal(18, 3) NULL ,'+
      '	CHANGE5_CST decimal(18, 3) NULL ,'+
      '	BAL_AMT decimal(18, 3) NULL ,'+
      '	BAL_MNY decimal(18, 3) NULL ,'+
      '	BAL_RTL decimal(18, 3) NULL ,'+
      '	BAL_CST decimal(18, 3) NULL '+
      ')'
   end;
  4:
   begin
      SQL :=
      'declare global temporary table '+tempTableName+' ('+
      '	TENANT_ID int NOT NULL ,'+
      '	SHOP_ID varchar (13) NOT NULL ,'+
      '	CREA_DATE int NOT NULL ,'+
      '	GODS_ID varchar (36)  NOT NULL ,'+
      '	BATCH_NO varchar (36) NOT NULL ,'+
      '	NEW_INPRICE decimal(18, 3) ,'+
      '	NEW_OUTPRICE decimal(18, 3) ,'+
      '	ORG_AMT decimal(18, 3) ,'+
      '	ORG_MNY decimal(18, 3) ,'+
      '	ORG_RTL decimal(18, 3) ,'+
      '	ORG_CST decimal(18, 3) ,'+
      '	STOCK_AMT decimal(18, 3) ,'+
      '	STOCK_MNY decimal(18, 3) ,'+
      '	STOCK_TAX decimal(18, 3) ,'+
      '	STOCK_RTL decimal(18, 3) ,'+
      '	STOCK_AGO decimal(18, 3) ,'+
      '	STKRT_AMT decimal(18, 3) ,'+
      '	STKRT_MNY decimal(18, 3) ,'+
      '	STKRT_TAX decimal(18, 3) ,'+
      '	SALE_AMT decimal(18, 3) ,'+
      '	SALE_RTL decimal(18, 3) ,'+
      '	SALE_AGO decimal(18, 3) ,'+
      '	SALE_MNY decimal(18, 3) ,'+
      '	SALE_TAX decimal(18, 3) ,'+
      '	SALE_CST decimal(18, 3) ,'+
      '	COST_PRICE decimal(18, 6) ,'+
      '	SALE_PRF decimal(18, 3) ,'+
      '	SALRT_AMT decimal(18, 3) ,'+
      '	SALRT_MNY decimal(18, 3) ,'+
      '	SALRT_TAX decimal(18, 3) ,'+
      '	SALRT_CST decimal(18, 3) ,'+
      '	DBIN_AMT decimal(18, 3) ,'+
      '	DBIN_MNY decimal(18, 3) ,'+
      '	DBIN_RTL decimal(18, 3) ,'+
      '	DBIN_CST decimal(18, 3) ,'+
      '	DBOUT_AMT decimal(18, 3) ,'+
      '	DBOUT_MNY decimal(18, 3) ,'+
      '	DBOUT_RTL decimal(18, 3) ,'+
      '	DBOUT_CST decimal(18, 3) ,'+
      '	CHANGE1_AMT decimal(18, 3) ,'+
      '	CHANGE1_MNY decimal(18, 3) ,'+
      '	CHANGE1_RTL decimal(18, 3) ,'+
      '	CHANGE1_CST decimal(18, 3) ,'+
      '	CHANGE2_AMT decimal(18, 3) ,'+
      '	CHANGE2_MNY decimal(18, 3) ,'+
      '	CHANGE2_RTL decimal(18, 3) ,'+
      '	CHANGE2_CST decimal(18, 3) ,'+
      '	CHANGE3_AMT decimal(18, 3) ,'+
      '	CHANGE3_MNY decimal(18, 3) ,'+
      '	CHANGE3_RTL decimal(18, 3) ,'+
      '	CHANGE3_CST decimal(18, 3) ,'+
      '	CHANGE4_AMT decimal(18, 3) ,'+
      '	CHANGE4_MNY decimal(18, 3) ,'+
      '	CHANGE4_RTL decimal(18, 3) ,'+
      '	CHANGE4_CST decimal(18, 3) ,'+
      '	CHANGE5_AMT decimal(18, 3) ,'+
      '	CHANGE5_MNY decimal(18, 3) ,'+
      '	CHANGE5_RTL decimal(18, 3) ,'+
      '	CHANGE5_CST decimal(18, 3) ,'+
      '	BAL_AMT decimal(18, 3) ,'+
      '	BAL_MNY decimal(18, 3) ,'+
      '	BAL_RTL decimal(18, 3) ,'+
      '	BAL_CST decimal(18, 3) '+
      ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
    end;
  end;
  if DbType in [0,4] then
  begin
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then
      Raise Exception.Create('������ʱ�����'+PlugIntf.GetLastError);
  end;

  case DbType of
  0,1:
   begin
     if PlugIntf.ExecSQL(Pchar('truncate table '+tempTableName),iRet)<>0 then
       Raise Exception.Create('�����ʱ�����'+PlugIntf.GetLastError);
   end;
  5:
   begin
     if PlugIntf.ExecSQL(Pchar('delete table '+tempTableName),iRet)<>0 then
       Raise Exception.Create('�����ʱ�����'+PlugIntf.GetLastError);
   end;
  end;
end;

procedure TGodsDayReck.CalcDayReck(TENANT_ID: string);
begin
  //��ʼ������ʶ������ҵID
  self.TENANT_ID:=TENANT_ID;

  //��ȡ����
  Prepare;
  DBFactory.DBLock(true); //������������
  try
    if DbType=5 then BeginTrans; //��SQLite�������񣬼���IO [SQLITE����д����㣬������д���ӹ�����]
    try
      CreateTempTable; //������ʱ��
      PrepareDataForRck;  //����׼��
      //����ɱ�
      case calc_flag of
       0: Calc0;
       1: Calc1;
       2: Calc2;
      end;
    finally
      if DbType=5 then CommitTrans;  //��SQLite�������񣬼���IO
    end;
  finally
    DBFactory.DBLock(False); //������������
  end;
end;

procedure TGodsDayReck.PrepareDataForRck;
var
  iRet: integer;
  SQL: string;
  rs: TZQuery;
  myDate: TDate;
begin
  myDate := cDate;
  if (calc_flag=2) then myDate := bDate;
  SQL :=
    'insert into '+tempTableName+'('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
    'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
    'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
    'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
    'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
    'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
    'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
    'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
    'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
    'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
    'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST '+
    ') '+
    'select '+
    'A.TENANT_ID,A.SHOP_ID,A.CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
    'max(B.NEW_INPRICE),max(B.NEW_OUTPRICE),'+
    '0,0,0,0,'+
    'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
    'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),case when sum(SALE_AMT)<>0 then sum(SALE_CST)/(sum(SALE_AMT)*1.0) else 0 end,sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
    'sum(DBIN_AMT),sum(round(DBIN_AMT*B.NEW_INPRICE,2)),sum(DBIN_RTL),sum(DBIN_CST),'+
    'sum(DBOUT_AMT),sum(round(DBOUT_AMT*B.NEW_INPRICE,2)),sum(DBOUT_RTL),sum(DBOUT_CST),'+
    'sum(CHANGE1_AMT),sum(round(CHANGE1_AMT*B.NEW_INPRICE,2)),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
    'sum(CHANGE2_AMT),sum(round(CHANGE2_AMT*B.NEW_INPRICE,2)),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
    'sum(CHANGE3_AMT),sum(round(CHANGE3_AMT*B.NEW_INPRICE,2)),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
    'sum(CHANGE4_AMT),sum(round(CHANGE4_AMT*B.NEW_INPRICE,2)),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
    'sum(CHANGE5_AMT),sum(round(CHANGE5_AMT*B.NEW_INPRICE,2)),sum(CHANGE5_RTL),sum(CHANGE5_CST) '+
    'from VIW_GOODS_DAYS A,VIW_GOODSPRICEEXT B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE>'+formatDatetime('YYYYMMDD',myDate)+' '+
    'group by A.TENANT_ID,A.SHOP_ID,A.CREA_DATE,A.GODS_ID,A.BATCH_NO ';
  if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then
    Raise Exception.Create('������ʱ�����'+PlugIntf.GetLastError);

  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(CREA_DATE) from '+tempTableName+' where TENANT_ID='+TENANT_ID+' ';
    if not Open(rs) then Raise Exception.Create('��ȡ������ڳ���'+PlugIntf.GetLastError);
    if rs.Fields[0].asString<>'' then
      myDate := fnTime.fnStrtoDate(rs.Fields[0].asString);
    if (myDate>eDate) and (eDate=0) then eDate := myDate;

    mDate := myDate;
    uDate := mDate;

    //ÿ�μ��㶼�㵽���һ��
    if mDate<eDate then mDate := eDate;
    pt := round(mDate-cDate);
  finally
    rs.Free;
  end;
end;

procedure TGodsDayReck.Setcflag(const Value: integer);
begin
  Fcflag := Value;
end;

procedure TGodsDayReck.SetcDate(const Value: TDate);
begin
  FcDate := Value;
end;

procedure TGodsDayReck.SetbDate(const Value: TDate);
begin
  FbDate := Value;
end;

procedure TGodsDayReck.SeteDate(const Value: TDate);
begin
  FeDate := Value;
end;

procedure TGodsDayReck.SetmDate(const Value: TDate);
begin
  FmDate := Value;
end;

procedure TGodsDayReck.SetuDate(const Value: TDate);
begin
  FuDate := Value;
end;

procedure TGodsDayReck.Calc0;
var
  i, iRet:integer;
  SQL,u:string;
begin
  //��ʼ���ڳ�
  SQL :=
    'insert into '+tempTableName+'('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
    'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST'+
    ') '+
    'select '+
    '0 as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+0)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
    'B.NEW_INPRICE,B.NEW_OUTPRICE,'+
    'A.BAL_AMT,A.BAL_MNY,A.BAL_RTL,A.BAL_CST '+
    'from RCK_GOODS_DAYS A Left outer join VIW_GOODSPRICEEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate)+' ';
  if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('��ʼ���ڳ�����'+PlugIntf.GetLastError);

  for i:= 1 to pt do
    begin
      //��������
      SQL :=
        'insert into '+tempTableName+'('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST '+
        ') '+
        'select '+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'max(NEW_INPRICE),max(NEW_OUTPRICE),'+
        'sum(ORG_AMT),sum(ORG_AMT)*max(NEW_INPRICE),sum(ORG_AMT)*max(NEW_OUTPRICE),sum(ORG_CST),'+
        'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
        'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),'+
        'round(case when sum(SALE_AMT)<>0 then cast(sum(SALE_CST) as decimal(18,3))/(cast(sum(SALE_AMT) as decimal(18,3))*1.0) else 0 end,6),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
        'sum(DBIN_AMT),sum(DBIN_MNY),sum(DBIN_RTL),sum(DBIN_CST),'+
        'sum(DBOUT_AMT),sum(DBOUT_MNY),sum(DBOUT_RTL),sum(DBOUT_CST),'+
        'sum(CHANGE1_AMT),sum(CHANGE1_MNY),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
        'sum(CHANGE2_AMT),sum(CHANGE2_MNY),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
        'sum(CHANGE3_AMT),sum(CHANGE3_MNY),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
        'sum(CHANGE4_AMT),sum(CHANGE4_MNY),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
        'sum(CHANGE5_AMT),sum(CHANGE5_MNY),sum(CHANGE5_RTL),sum(CHANGE5_CST),'+
        '0 as BAL_AMT,0 as BAL_MNY,0 as BAL_RTL,0 as BAL_CST '+
        'from('+
        'select '+
        '0 as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        '0 as ORG_AMT,0 as ORG_MNY,0 as ORG_RTL,0 as ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST '+
        'from '+tempTableName+' A where A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
        'union all '+
        'select '+
        '0 as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
        'A.NEW_INPRICE,A.NEW_OUTPRICE,'+
        'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
        '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
        '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
        '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
        '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
        '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
        '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
        '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
        '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
        '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
        'from '+tempTableName+' A where A.TENANT_ID=0 and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i-1)+' '+
        ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ';
      if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('�������ݳ���'+PlugIntf.GetLastError);

      //�������
      SQL :=
        'update '+tempTableName+' set '+
        'BAL_AMT=ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT,'+
        'BAL_MNY=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_INPRICE,'+
        'BAL_RTL=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_OUTPRICE,'+
        'BAL_CST=ORG_CST+STOCK_MNY-SALE_CST+DBIN_CST-DBOUT_CST+'+
        'CHANGE1_CST+CHANGE2_CST+CHANGE3_CST+CHANGE4_CST+CHANGE5_CST '+
        'where TENANT_ID=0 and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+'';
      if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('����������'+PlugIntf.GetLastError);
    end;

  if DbType <> 5 then BeginTrans;
  try
    SQL:='delete from RCK_GOODS_DAYS where TENANT_ID='+TENANT_ID+' and CREA_DATE>'+formatDatetime('YYYYMMDD',cDate);
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('����������'+PlugIntf.GetLastError);
    SQL :=
        'insert into RCK_GOODS_DAYS('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,COMM,TIME_STAMP '+
        ') '+
        'select '+
        ''+TENANT_ID+' as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,''00'','+DBFactory.GetTimeStamp(DbType)+' '+
        'from '+tempTableName+' where TENANT_ID=0 and CREA_DATE>'+formatDatetime('YYYYMMDD',bDate);
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('������̨�˳���'+PlugIntf.GetLastError);
    if DbType <> 5 then CommitTrans;
  except
    if DbType <> 5 then RollbackTrans;
    Raise;
  end;
end;

procedure TGodsDayReck.Calc1;
var
  i,iRet:integer;
  SQL:string;
begin
  //��ʼ���ڳ�
  SQL :=
    'insert into '+tempTableName+'('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
    'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST'+
    ') '+
    'select '+
    '0 as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+0)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
    'B.NEW_INPRICE,B.NEW_OUTPRICE,'+
    'A.BAL_AMT,A.BAL_MNY,A.BAL_RTL,A.BAL_CST '+
    'from RCK_GOODS_DAYS A Left outer join VIW_GOODSPRICEEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate)+' ';
  if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('��ʼ���ڳ�����'+PlugIntf.GetLastError);

  for i:= 1 to pt do
  begin
    //��������
    SQL :=
      'insert into '+tempTableName+'('+
      'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      'NEW_INPRICE,NEW_OUTPRICE,'+
      'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
      'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
      'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
      'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
      'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
      'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
      'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
      'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
      'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
      'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
      'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST '+
      ') '+
      'select '+
      'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      'max(NEW_INPRICE),max(NEW_OUTPRICE),'+
      'sum(ORG_AMT),sum(ORG_AMT)*max(NEW_INPRICE),sum(ORG_AMT)*max(NEW_OUTPRICE),sum(ORG_CST),'+
      'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
      'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),max(COST_PRICE),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
      'sum(DBIN_AMT),sum(DBIN_MNY),sum(DBIN_RTL),sum(DBIN_CST),'+
      'sum(DBOUT_AMT),sum(DBOUT_MNY),sum(DBOUT_RTL),sum(DBOUT_CST),'+
      'sum(CHANGE1_AMT),sum(CHANGE1_MNY),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
      'sum(CHANGE2_AMT),sum(CHANGE2_MNY),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
      'sum(CHANGE3_AMT),sum(CHANGE3_MNY),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
      'sum(CHANGE4_AMT),sum(CHANGE4_MNY),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
      'sum(CHANGE5_AMT),sum(CHANGE5_MNY),sum(CHANGE5_RTL),sum(CHANGE5_CST),'+
      '0 as BAL_AMT,0 as BAL_MNY,0 as BAL_RTL,0 as BAL_CST '+
      'from('+
      'select '+
      '0 as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      'NEW_INPRICE,NEW_OUTPRICE,'+
      '0 as ORG_AMT,0 as ORG_MNY,0 as ORG_RTL,0 as ORG_CST,'+
      'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
      'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
      'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
      'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
      'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
      'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
      'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
      'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
      'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST '+
      'from '+tempTableName+' A where A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+' '+
      'union all '+
      'select '+
      '0 as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',cDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
      'A.NEW_INPRICE,A.NEW_OUTPRICE,'+
      'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
      '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
      '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
      '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
      '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
      '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
      '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
      '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
      '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
      '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
      'from '+tempTableName+' A where A.TENANT_ID=0 and A.CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i-1)+' '+
      ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ';
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('�������ݳ���'+PlugIntf.GetLastError);

    //����ɱ�
    SQL :=
      'update '+tempTableName+' set '+
      'COST_PRICE=(select case when sum(ORG_AMT+STOCK_AMT)<>0 then round(cast(sum(ORG_CST+STOCK_MNY) as decimal(18,3))/(cast(sum(ORG_AMT+STOCK_AMT) as decimal(18,3))*1.0),6) else 0 end '+
      'from '+tempTableName+' A where A.TENANT_ID='+tempTableName+'.TENANT_ID and A.GODS_ID='+tempTableName+'.GODS_ID and A.BATCH_NO='+tempTableName+'.BATCH_NO and A.CREA_DATE='+tempTableName+'.CREA_DATE) '+
      'where TENANT_ID=0 and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+'';
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('����ɱ�����'+PlugIntf.GetLastError);

    //�������
    SQL :=
      'update '+tempTableName+' set '+
      'SALE_CST=round(SALE_AMT*COST_PRICE,2),'+
      'SALE_PRF=SALE_MNY - round(SALE_AMT*COST_PRICE,2),'+
      'DBIN_CST=round(DBIN_AMT*COST_PRICE,2),'+
      'DBOUT_CST=round(DBOUT_AMT*COST_PRICE,2),'+
      'CHANGE1_CST=round(CHANGE1_AMT*COST_PRICE,2),'+
      'CHANGE2_CST=round(CHANGE2_AMT*COST_PRICE,2),'+
      'CHANGE3_CST=round(CHANGE3_AMT*COST_PRICE,2),'+
      'CHANGE4_CST=round(CHANGE4_AMT*COST_PRICE,2),'+
      'CHANGE5_CST=round(CHANGE5_AMT*COST_PRICE,2),'+
      'BAL_AMT=ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT,'+
      'BAL_MNY=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_INPRICE,'+
      'BAL_RTL=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_OUTPRICE,'+
      'BAL_CST=ORG_CST+STOCK_MNY-round(SALE_AMT*COST_PRICE,2)+round(DBIN_AMT*COST_PRICE,2)-round(DBOUT_AMT*COST_PRICE,2)+'+
      'round(CHANGE1_AMT*COST_PRICE,2)+round(CHANGE2_AMT*COST_PRICE,2)+round(CHANGE3_AMT*COST_PRICE,2)+round(CHANGE4_AMT*COST_PRICE,2)+round(CHANGE5_AMT*COST_PRICE,2) '+
      'where TENANT_ID=0 and CREA_DATE='+formatDatetime('YYYYMMDD',cDate+i)+'';
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('����������'+PlugIntf.GetLastError);
  end;

  if DbType <> 5 then BeginTrans;
  try
    SQL:='delete from RCK_GOODS_DAYS where TENANT_ID='+TENANT_ID+' and CREA_DATE>'+formatDatetime('YYYYMMDD',cDate);
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��̨�˳���'+PlugIntf.GetLastError);
    SQL :=
        'insert into RCK_GOODS_DAYS('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,COMM,TIME_STAMP '+
        ') '+
        'select '+
        ''+TENANT_ID+' as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,''00'','+DBFactory.GetTimeStamp(DbType)+' '+
        'from '+tempTableName+' where TENANT_ID=0 and CREA_DATE>'+formatDatetime('YYYYMMDD',bDate);
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('������̨�˳���'+PlugIntf.GetLastError);
    if DbType <> 5 then CommitTrans;
  except
    if DbType <> 5 then RollbackTrans;
    Raise;
  end;
end;

procedure TGodsDayReck.Calc2;
var
  i,b,iRet:integer;
  SQL:string;
  e:TDate;
begin
  //׼���ڳ�
  SQL :=
    'insert into '+tempTableName+'('+
    'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
    'NEW_INPRICE,NEW_OUTPRICE,'+
    'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST'+
    ') '+
    'select '+
    '0 as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',bDate+0)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
    'B.NEW_INPRICE,B.NEW_OUTPRICE,'+
    'A.BAL_AMT,A.BAL_MNY,A.BAL_RTL,A.BAL_CST '+
    'from RCK_GOODS_DAYS A Left outer join VIW_GOODSPRICEEXT B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SHOP_ID=B.SHOP_ID '+
    'where (A.BAL_AMT<>0 or A.BAL_MNY<>0) and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate)+' ';
  if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('�����ڳ�����'+PlugIntf.GetLastError);

  b := 1;
  while true do
  begin
    if reck_flag=1 then
    begin
      if isfirst and (b=1) then
      begin
        e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,1))+'01')-1;
        if e<(bDate+1) then e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate,2))+'01')-1;
      end else
        e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,2))+'01')-1
    end else
    begin
      e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',bDate+b-1)+formatfloat('00',reck_day));
      if e<=(bDate+b-1) then
        e := fnTime.fnStrtoDate(formatDatetime('YYYYMM',incMonth(bDate+b-1,1))+formatfloat('00',reck_day));
    end;
    if (bDate+b)<=uDate then //ֻ���������ݲ���
    begin
    //׼���ڳ�
    SQL :=
      'insert into '+tempTableName+'('+
      'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST)'+
      'select '+
      ''+TENANT_ID+' as TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',bDate+b)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
      'BAL_AMT as ORG_AMT,BAL_MNY as ORG_MNY,BAL_RTL as ORG_RTL,BAL_CST as ORG_CST '+
      'from '+tempTableName+' A where (A.BAL_AMT<>0 or A.BAL_CST<>0) and A.TENANT_ID=0 and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+b-1)+' ';
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('�����ڳ�����'+PlugIntf.GetLastError);

    //����ɱ�
    SQL :=
      'update '+tempTableName+' set '+
      'COST_PRICE=(select case when sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0))<>0 then round(cast(sum(isnull(ORG_CST,0)+isnull(STOCK_MNY,0)) as decimal(18,3))/(cast(sum(isnull(ORG_AMT,0)+isnull(STOCK_AMT,0)) as decimal(18,3))*1.0),6) else 0 end '+
      'from '+tempTableName+' A where A.TENANT_ID='+tempTableName+'.TENANT_ID and A.GODS_ID='+tempTableName+'.GODS_ID and A.BATCH_NO='+tempTableName+'.BATCH_NO and A.CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',e)+') '+
      'where TENANT_ID='+TENANT_ID+' and CREA_DATE>='+formatDatetime('YYYYMMDD',bDate+b)+' and CREA_DATE<='+formatDatetime('YYYYMMDD',e)+'';
    SQL:=DBFactory.ParseSQL(DbType,SQL);
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('����ɱ�����'+PlugIntf.GetLastError);
  end;

  for i:= b to pt do
  begin
    if (bDate+i)>e then continue;
    //��������
    SQL :=
      'insert into '+tempTableName+'('+
      'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      'NEW_INPRICE,NEW_OUTPRICE,'+
      'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
      'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
      'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
      'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
      'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
      'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
      'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
      'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
      'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
      'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
      'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST '+
      ') '+
      'select '+
      'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      'max(NEW_INPRICE),max(NEW_OUTPRICE),'+
      'sum(ORG_AMT),sum(ORG_AMT)*max(NEW_INPRICE),sum(ORG_AMT)*max(NEW_OUTPRICE),sum(ORG_CST),'+
      'sum(STOCK_AMT),sum(STOCK_MNY),sum(STOCK_TAX),sum(STOCK_RTL),sum(STOCK_AGO),sum(STKRT_AMT),sum(STKRT_MNY),sum(STKRT_TAX),'+
      'sum(SALE_AMT),sum(SALE_RTL),sum(SALE_AGO),sum(SALE_MNY),sum(SALE_TAX),sum(SALE_CST),max(COST_PRICE),sum(SALE_PRF),sum(SALRT_AMT),sum(SALRT_MNY),sum(SALRT_TAX),sum(SALRT_CST),'+
      'sum(DBIN_AMT),sum(DBIN_MNY),sum(DBIN_RTL),sum(DBIN_CST),'+
      'sum(DBOUT_AMT),sum(DBOUT_MNY),sum(DBOUT_RTL),sum(DBOUT_CST),'+
      'sum(CHANGE1_AMT),sum(CHANGE1_MNY),sum(CHANGE1_RTL),sum(CHANGE1_CST),'+
      'sum(CHANGE2_AMT),sum(CHANGE2_MNY),sum(CHANGE2_RTL),sum(CHANGE2_CST),'+
      'sum(CHANGE3_AMT),sum(CHANGE3_MNY),sum(CHANGE3_RTL),sum(CHANGE3_CST),'+
      'sum(CHANGE4_AMT),sum(CHANGE4_MNY),sum(CHANGE4_RTL),sum(CHANGE4_CST),'+
      'sum(CHANGE5_AMT),sum(CHANGE5_MNY),sum(CHANGE5_RTL),sum(CHANGE5_CST),'+
      '0 as BAL_AMT,0 as BAL_MNY,0 as BAL_RTL,0 as BAL_CST '+
      'from('+
      'select '+
      '0 as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      'NEW_INPRICE,NEW_OUTPRICE,'+
      '0 as ORG_AMT,0 as ORG_MNY,0 as ORG_RTL,0 as ORG_CST,'+
      'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
      'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
      'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
      'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
      'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
      'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
      'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
      'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
      'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST '+
      'from '+tempTableName+' A where A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i)+' '+
      'union all '+
      'select '+
      '0 as TENANT_ID,A.SHOP_ID,'+formatDatetime('YYYYMMDD',bDate+i)+' as CREA_DATE,A.GODS_ID,A.BATCH_NO,'+
      'A.NEW_INPRICE,A.NEW_OUTPRICE,'+
      'A.BAL_AMT as ORG_AMT,A.BAL_MNY as ORG_MNY,A.BAL_RTL as ORG_RTL,A.BAL_CST as ORG_CST,'+
      '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_RTL,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
      '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as COST_PRICE,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
      '0 as DBIN_AMT,0 as DBIN_MNY,0 as DBIN_RTL,0 as DBIN_CST,'+
      '0 as DBOUT_AMT,0 as DBOUT_MNY,0 as DBOUT_RTL,0 as DBOUT_CST,'+
      '0 as CHANGE1_AMT,0 as CHANGE1_MNY,0 as CHANGE1_RTL,0 as CHANGE1_CST,'+
      '0 as CHANGE2_AMT,0 as CHANGE2_MNY,0 as CHANGE2_RTL,0 as CHANGE2_CST,'+
      '0 as CHANGE3_AMT,0 as CHANGE3_MNY,0 as CHANGE3_RTL,0 as CHANGE3_CST,'+
      '0 as CHANGE4_AMT,0 as CHANGE4_MNY,0 as CHANGE4_RTL,0 as CHANGE4_CST,'+
      '0 as CHANGE5_AMT,0 as CHANGE5_MNY,0 as CHANGE5_RTL,0 as CHANGE5_CST '+
      'from '+tempTableName+' A where A.TENANT_ID=0 and A.CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i-1)+' '+
      ') j group by TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO ';
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('����ɱ�����'+PlugIntf.GetLastError);

      //�������
    SQL :=
      'update '+tempTableName+' set '+
      'SALE_CST=round(SALE_AMT*COST_PRICE,2),'+
      'SALE_PRF=SALE_MNY - round(SALE_AMT*COST_PRICE,2),'+
      'DBIN_CST=round(DBIN_AMT*COST_PRICE,2),'+
      'DBOUT_CST=round(DBOUT_AMT*COST_PRICE,2),'+
      'CHANGE1_CST=round(CHANGE1_AMT*COST_PRICE,2),'+
      'CHANGE2_CST=round(CHANGE2_AMT*COST_PRICE,2),'+
      'CHANGE3_CST=round(CHANGE3_AMT*COST_PRICE,2),'+
      'CHANGE4_CST=round(CHANGE4_AMT*COST_PRICE,2),'+
      'CHANGE5_CST=round(CHANGE5_AMT*COST_PRICE,2),'+
      'BAL_AMT=ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT,'+
      'BAL_MNY=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_INPRICE,'+
      'BAL_RTL=(ORG_AMT+STOCK_AMT-SALE_AMT+DBIN_AMT-DBOUT_AMT+CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*NEW_OUTPRICE,'+
      'BAL_CST=ORG_CST+STOCK_MNY-round(SALE_AMT*COST_PRICE,2)+round(DBIN_AMT*COST_PRICE,2)-round(DBOUT_AMT*COST_PRICE,2)+'+
      'round(CHANGE1_AMT*COST_PRICE,2)+round(CHANGE2_AMT*COST_PRICE,2)+round(CHANGE3_AMT*COST_PRICE,2)+round(CHANGE4_AMT*COST_PRICE,2)+round(CHANGE5_AMT*COST_PRICE,2) '+
      'where TENANT_ID=0 and CREA_DATE='+formatDatetime('YYYYMMDD',bDate+i)+'';
      if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('����������'+PlugIntf.GetLastError);
    end;
    if e>=mDate then break;
    b := b +round(e-(bDate+b))+1;
  end;

  if DbType <> 5 then BeginTrans;
  try
    SQL:='delete from RCK_GOODS_DAYS where TENANT_ID='+TENANT_ID+' and CREA_DATE>'+formatDatetime('YYYYMMDD',bDate);
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���ݳ���'+PlugIntf.GetLastError);
    SQL :=
        'insert into RCK_GOODS_DAYS('+
        'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,COMM,TIME_STAMP '+
        ') '+
        'select '+
        ''+TENANT_ID+' as TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
        'NEW_INPRICE,NEW_OUTPRICE,'+
        'ORG_AMT,ORG_MNY,ORG_RTL,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_RTL,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'DBIN_AMT,DBIN_MNY,DBIN_RTL,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_MNY,DBOUT_RTL,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_MNY,CHANGE1_RTL,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_MNY,CHANGE2_RTL,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_MNY,CHANGE3_RTL,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_MNY,CHANGE4_RTL,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_MNY,CHANGE5_RTL,CHANGE5_CST,'+
        'BAL_AMT,BAL_MNY,BAL_RTL,BAL_CST,''00'','+DBFactory.GetTimeStamp(DbType)+' '+
        'from '+tempTableName+' where TENANT_ID=0 and CREA_DATE>'+formatDatetime('YYYYMMDD',bDate);
    if PlugIntf.ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create('������̨�˳���'+PlugIntf.GetLastError);
    if DbType <> 5 then CommitTrans;
  except
    if DbType <> 5 then RollbackTrans;
    Raise;
  end;
end;

procedure TGodsDayReck.SetTENANT_ID(const Value: string);
begin
  FTENANT_ID := Value;
end;

procedure TGodsDayReck.SetDBFactory(const Value: TRimSyncFactory);
begin
  FDBFactory := Value;
end;

function TGodsDayReck.BeginTrans(TimeOut: integer): Boolean;
begin
  result:=DBFactory.BeginTrans(TimeOut);
end;

function TGodsDayReck.CommitTrans: Boolean;
begin
  result:=DBFactory.CommitTrans;
end;

function TGodsDayReck.RollbackTrans: Boolean;
begin
  result:=DBFactory.RollbackTrans;
end;

function TGodsDayReck.Open(DataSet: TDataSet): Boolean;
begin
  result:=DBFactory.Open(DataSet);
end;

function TGodsDayReck.GetDBType: integer;
begin
  result:=DBFactory.DbType;
end;

function TGodsDayReck.GetPlugIntf: IPlugIn;
begin
  result:=DBFactory.PlugIntf;
end;

{TDayReckSyncFactory}

constructor TDayReckSyncFactory.Create;
begin
  inherited;
  DayReck:=TGodsDayReck.Create;
  DayReck.DBFactory:=self;
end;

destructor TDayReckSyncFactory.Destroy;
begin
  DayReck.Free;
  inherited;
end;

function TDayReckSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  ErrorFlag: Boolean; 
  RimParam: TRimParams;
begin
  result:=-1;
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  //3������ͬ�����ͱ��
  GetSyncType;

  {------��ʼ������־------}
  BeginLogRun;
  try
    DBLock(true);  //�������ݿ����� 
    //����R3���ϱ�ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      FRunInfo.ErrorStr:='��ҵID('+RimParam.TenID+')û�ж�Ӧ���ϱ��ŵ�(�ϱ��˳�ִ��)��';
      result:=0;
      Exit;
    end;

    //���ŵ�ID����ѭ���ϱ�
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      RimParam.CustID:='';
      try
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);   //R3��ҵID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString); //R3��ҵ���� (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);     //R3�ŵ�ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);  //R3�ŵ����� (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString);  //R3�ŵ����֤�� (Field: LICENSE_CODE)
        RimParam.SHORT_ShopID:=Copy(RimParam.ShopID,Length(RimParam.ShopID)-3,4);     //�ŵ�ID�ĺ�4λ

        //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID); //�����̲ݹ�˾ComID�����ۻ�CustID

        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          LogInfo.BeginLog(RimParam.TenName+'-'+RimParam.ShopName); //��ʼ��־

          //��ʼ�ϱ���̨�ʣ�
          try
            iRet:=GodsDayReckSync(RimParam);
            LogInfo.AddBillMsg('���ۻ���̨��',iRet);
          except
            on E:Exception do
            begin
              WriteRunErrorMsg(E.Message);
              ErrorFlag:=true;                
            end;
          end;

          if R3ShopList.RecordCount=1 then LogInfo.SetLogMsg(LogList) //��ӱ���ִ����־
          else LogInfo.SetLogMsg(LogList, R3ShopList.RecNo);  //��ӱ���ִ����־
          //��¼
          if ErrorFlag then Inc(FRunInfo.ErrorCount)
          else Inc(FRunInfo.RunCount);
        end else
        begin
          Inc(FRunInfo.NotCount);  //��Ӧ����
          LogList.Add('   �ŵ�('+RimParam.TenName+'-'+RimParam.ShopName+')���֤��'+RimParam.LICENSE_CODE+' ��Rimϵͳ��û��Ӧ�����ۻ���'); 
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //���ŵ���
    DBLock(False);
    if SyncType<>3 then  //�������в�д��־
      WriteLogRun('���ۻ���̨��');  //������ı���־ 
  end;
end;

{------------------------------------------------------------------------------
 �ϱ�����:         
   (1)�Զ�������̨�ˣ�ֻ�����㣬���������ս�������ϴν����յ�����;
   (2)�ϱ�����δ������̨�ˣ��Ѿ����˲��ݣ����ս���ʱ���Ϊ׼��δ���˲��ݣ�
      ÿ���ر���
   (3)��̨���ϱ�������ݴ�����ŵ�(SHOP_ID)��ȡ�����֤�ţ��÷��ϸ����֤�ŵ�
      ���ŵ�һ���ϱ���  
 ------------------------------------------------------------------------------}
function TDayReckSyncFactory.GodsDayReckSync(vRimParam: TRimParams): integer;
var
  LastReckDate: TDate;   //����������
  iRet,UpiRet: integer;  //����ExeSQLӰ������м�¼
  Session: string;    //sessionǰ׺����
  Str,DayTab,ReckDate,SHOP_IDS,SumFields: string;
begin
  result:=-1;
  //���ϱ����ۻ���̨��֮ǰ������TGodsDayReck����
  DayReck.CalcDayReck(vRimParam.TenID);

  //��������������:
  LastReckDate:=DayReck.bDate;

  //���ص�ǰ�ŵ���ͬ���֤��һ����:SHOP_IDS
  SHOP_IDS:=GetShop_IDS(vRimParam.TenID,vRimParam.LICENSE_CODE);

  //��һ��: ����̨����ʱ[INF_DAYMONTH]:
  case DbType of
   1:
    begin
      Session:='';
      ReckDate:='to_char(A.CREA_DATE) ';
    end;
   4:
    begin
      Session:='session.';
      ReckDate:='trim(char(A.CREA_DATE)) ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKDAY('+
             'TENANT_ID INTEGER NOT NULL,'+         //R3��ҵID
             'LICENSE_CODE VARCHAR(50) NOT NULL,'+       //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3�ŵ�ID�ĺ���λ
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //RIM���ۻ�ID
             'ITEM_ID VARCHAR(30) NOT NULL,'+       //RIM��ƷID
             'GODS_ID CHAR(36) NOT NULL,'+          //R3��ƷID
             'UNIT_CALC DECIMAL (18,6),'+           //��Ʒ������λ�������λ����ֵ
             'NEW_INPIRCE DECIMAL (18,6),'+         //��Ʒ���½���[������]
             'NEW_OUTPIRCE DECIMAL (18,6),'+        //��Ʒ�ŵ����ۼ�
             'RECK_DATE VARCHAR(8) NOT NULL'+       //̨������
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨����ʱ�����'+PlugIntf.GetLastError);
    end;
  end;  

  //����ʱ���:
  MaxStmp:=GetMaxNUM('09',vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
  //�ڶ���:ɾ����ʷ����:
  Str:='delete from '+Session+'INF_RECKDAY where TENANT_ID='+vRimParam.TenID+' and LICENSE_CODE='''+vRimParam.LICENSE_CODE+''' ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);

  //��̨�˱�
  DayTab:=                                                               
    '(select distinct TENANT_ID,CREA_DATE,GODS_ID from RCK_GOODS_DAYS where TENANT_ID='+vRimParam.TenID+' and SHOP_ID in ('+SHOP_IDS+') and CREA_DATE>'+FormatDatetime('YYYYMMDD',LastReckDate)+' '+
    ' union  '+
    ' select distinct A.TENANT_ID,A.CREA_DATE,A.GODS_ID from RCK_GOODS_DAYS A,RCK_DAYS_CLOSE C where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.TENANT_ID='+vRimParam.TenID+' and '+
    ' A.SHOP_ID in ('+SHOP_IDS+') and '+ReckDate+'=C.CREA_DATE and A.TIME_STAMP>'+MaxStmp+')';

  Str:='insert into '+Session+'INF_RECKDAY(TENANT_ID,LICENSE_CODE,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,NEW_INPIRCE,NEW_OUTPIRCE,RECK_DATE) '+
       'select A.TENANT_ID,'''+vRimParam.LICENSE_CODE+''' as LICENSE_CODE,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,'+
       'B.SECOND_ID,A.GODS_ID,('+GetDefaultUnitCalc+') as UNIT_CALC,B.NEW_OUTPRICE,B.NEW_INPRICE,'+ReckDate+' as RECK_DATE '+
       ' from '+DayTab+' A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨����ʱ�����:'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit;      //û���ϱ�����ʱ���˳�
  end;

  //��ɾ��RIM��̨�˱����Ҫ�����ϱ���¼:
  Str:='delete from RIM_CUST_DAY A where A.COM_ID='''+vRimParam.ComID+''' and A.CUST_ID='''+vRimParam.CustID+''' and '+
       ' exists(select 1 from '+Session+'INF_RECKDAY B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.ITEM_ID=B.ITEM_ID and A.DATE1=B.RECK_DATE)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����̨����ʷ���ݳ���'+PlugIntf.GetLastError);

  UpiRet:=0; //Ӱ���¼����

  SumFields:='cast(sum(ORG_AMT) as decimal(18,3)) as ORG_AMT,'+
             'cast(sum(ORG_MNY) as decimal(18,3)) as ORG_MNY,'+
             'cast(sum(STOCK_AMT) as decimal(18,3)) as STOCK_AMT,'+
             'cast(sum(STOCK_MNY) as decimal(18,3)) as STOCK_MNY,'+
             'cast(sum(SALE_AMT) as decimal(18,3)) as SALE_AMT,'+
             'cast(sum(SALE_MNY) as decimal(18,3)) as SALE_MNY,'+
             'cast(sum(SALE_RTL) as decimal(18,3)) as SALE_RTL,'+
             'cast(sum(SALE_TAX) as decimal(18,3)) as SALE_TAX,'+
             'cast(sum(SALE_CST) as decimal(18,3)) as SALE_CST,'+
             'cast(sum(CHANGE1_AMT) as decimal(18,3)) as CHANGE1_AMT,'+
             'cast(sum(CHANGE1_MNY) as decimal(18,3)) as CHANGE1_MNY,'+
             'cast((sum(CHANGE2_AMT)+sum(CHANGE3_AMT)+sum(CHANGE4_AMT)+sum(CHANGE5_AMT)) as decimal(18,3)) as CHANGE_AMT,'+
             'cast((sum(CHANGE2_MNY)+sum(CHANGE3_MNY)+sum(CHANGE4_MNY)+sum(CHANGE5_MNY)) as decimal(18,3)) as CHANGE_MNY,'+
             'cast(sum(DBIN_AMT) as decimal(18,3)) as DBIN_AMT,'+
             'cast(sum(DBIN_MNY) as decimal(18,3)) as DBIN_MNY,'+
             'cast(sum(DBOUT_AMT) as decimal(18,3)) as DBOUT_AMT,'+
             'cast(sum(DBOUT_MNY) as decimal(18,3)) as DBOUT_MNY,'+
             'cast(sum(BAL_AMT) as decimal(18,3)) as BAL_AMT,'+
             'cast(sum(BAL_MNY) as decimal(18,3)) as BAL_MNY,'+
             'cast(sum(SALE_PRF) as decimal(18,3)) as SALE_PRF ';
             // '(case when sum(SALE_AMT)>0 then sum(SALE_MNY)*1.00/cast(sum(SALE_AMT) as decimal(18,6)) else SALE_MNY end) as COST_PRICE ';
  DayTab:=
    'select TENANT_ID,CREA_DATE,GODS_ID,'+SumFields+' from '+
    '(select * from RCK_GOODS_DAYS where TENANT_ID='+vRimParam.TenID+' and SHOP_ID in ('+SHOP_IDS+') and CREA_DATE>'+FormatDatetime('YYYYMMDD',LastReckDate)+' '+
    ' union all '+
    ' select A.* from RCK_GOODS_DAYS A,RCK_DAYS_CLOSE C where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.TENANT_ID='+vRimParam.TenID+' and '+
    ' A.SHOP_ID in ('+SHOP_IDS+') and '+ReckDate+'=C.CREA_DATE and A.TIME_STAMP>'+MaxStmp+') tmp '+
    ' group by TENANT_ID,CREA_DATE,GODS_ID ';
    
  //�����ϱ���¼:
  Str:=
    'insert into RIM_CUST_DAY('+
        'COM_ID,CUST_ID,TERM_ID,ITEM_ID,DATE1'+
        ',PRI3'+          //�����۸�
        ',PRI4'+          //�������ۼ�
        ',PRI_SOLD'+      //ʵ�����۾���
        ',AMT_GROSS_PROFIT_THEO'+       //����ë����
        ',QTY_IOD,AMT_IOD'+             //1���ճ�����������ճ���������˰��
        ',QTY_PURCH,AMT_PURCH'+         //2�����չ������������չ������   [���]
        ',QTY_SOLD,AMT_SOLD_WITH_TAX'+  //3�����������������������ۺ�˰���
        ',QTY_PROFIT,AMT_PROFIT'+       //4��������������������������
        ',QTY_LOSS,AMT_LOSS'+           //5���������������������Ľ��
        ',QTY_TAKE,AMT_TAKE'+           //6�����յ������������յ������
        ',QTY_TRN_IN,AMT_TRN_IN'+       //7�����յ������������յ�����
        ',QTY_TRN_OUT,AMT_TRN_OUT'+     //8�����յ������������յ������
        ',QTY_EOD,AMT_EOD'+             //9����ĩ�����������ĩ�����
        ',UNIT_COST,SUMCOST_SOLD'+      //10����λ�ɱ������۳ɱ�
        ',AMT_GROSS_PROFIT'+   //ë����
        ',AMT_PROFIT_COM) '+   //����ë��
    'select B.COM_ID,B.CUST_ID,B.SHORT_SHOP_ID,B.ITEM_ID,B.RECK_DATE'+
        ',B.NEW_INPIRCE'+      //������
        ',B.NEW_OUTPIRCE'+     //���ۼ�                       
        ',((B.NEW_OUTPIRCE-(case when SALE_AMT>0 then SALE_MNY*1.00/cast(SALE_AMT as decimal(18,6)) else 0 end))* SALE_AMT) as SALE_PRF_LL'+  //����ë���� =���������ۼ�-�ɱ���* ����
        ',(case when SALE_AMT<>0 then SALE_RTL/(SALE_AMT*1.00) else 0 end)as SALE_PIRCE'+    //���۾���
        ',(case when B.UNIT_CALC>0 then ORG_AMT/B.UNIT_CALC else ORG_AMT end)as ORG_AMT,ORG_MNY'+       //1:�ڳ����������
        ',(case when B.UNIT_CALC>0 then STOCK_AMT/B.UNIT_CALC else STOCK_AMT end)as STOCK_AMT,STOCK_MNY'+  //2:������������
        ',(case when B.UNIT_CALC>0 then SALE_AMT/B.UNIT_CALC else SALE_AMT end)as SALE_AMT,SALE_MNY+SALE_TAX'+   //3:������������˰���
        ',(case when CHANGE1_AMT>0 then (case when B.UNIT_CALC>0 then CHANGE1_AMT/B.UNIT_CALC else CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT>0 then CHANGE1_MNY else 0 end) as CHANGE1_MNY'+    //4: �������������
        ',(case when CHANGE1_AMT<0 then (case when B.UNIT_CALC>0 then -CHANGE1_AMT/B.UNIT_CALC else -CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT<0 then -CHANGE1_MNY else 0 end) as CHANGE1_MNY'+ //5: �������������
        ',(case when B.UNIT_CALC>0 then CHANGE_AMT/B.UNIT_CALC else CHANGE_AMT end)as CHANGE_AMT,CHANGE_MNY'+ //6: �������������
        ',(case when B.UNIT_CALC>0 then DBIN_AMT/B.UNIT_CALC else DBIN_AMT end)as DBIN_AMT,DBIN_MNY'+       //7: �������������
        ',(case when B.UNIT_CALC>0 then DBOUT_AMT/B.UNIT_CALC else DBOUT_AMT end)as DBOUT_AMT,DBOUT_MNY'+   //8: �������������
        ',(case when B.UNIT_CALC>0 then BAL_AMT/B.UNIT_CALC else BAL_AMT end)as BAL_AMT,BAL_MNY'+           //9: ��ĩ���������
        ',(case when SALE_AMT>0 then SALE_MNY*1.00/cast(SALE_AMT as decimal(18,3)) else 0 end) as COST_PRICE,SALE_CST'+          //11: ��λ�ɱ������۳ɱ�
        ',SALE_PRF,0 '+                    //12: ë�������ë��
    'from ('+DayTab+') A,'+Session+'INF_RECKDAY B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+ReckDate+'=B.RECK_DATE ';
  if PlugIntf.ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('�ϱ���̨�����ݳ���:'+PlugIntf.GetLastError);
 
  //3��������̨�ʱ�Ǻ��ϱ�ʱ���:[]
  try
    BeginTrans;
    //����̨���ϱ��ı��λ:COMM�ĵ�1λ����Ϊ��1
    Str:='update RCK_GOODS_DAYS A set COMM='+GetUpCommStr(DbType)+'  '+
         ' where A.TENANT_ID='''+vRimParam.TenID+''' and A.SHOP_ID in ('+SHOP_IDS+') and '+ReckDate+'<='+FormatDatetime('YYYYMMDD',LastReckDate)+' and  '+
         ' exists(select 1 from '+Session+'INF_RECKDAY INF where A.TENANT_ID=INF.TENANT_ID and '+ReckDate+'=INF.RECK_DATE and A.GODS_ID=INF.GODS_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨��ͨ�ű��:'+PlugIntf.GetLastError);

    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' '+
         ' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''09'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨���ϱ�ʱ�������:'+PlugIntf.GetLastError);

    CommitTrans; //�ύ����
    result:=UpiRet;
  except
    on E:Exception do
    begin
      RollbackTrans;
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'09','�ϱ���̨�ʴ���','02'); //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
  //ִ�гɹ�д��־:
  WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'09','�ϱ���̨�ʳɹ�','01');
end;


end.
