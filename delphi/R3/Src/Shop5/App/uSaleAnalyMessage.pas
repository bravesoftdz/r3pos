unit uSaleAnalyMessage;

interface

uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns,
  Des, WinInet, Controls, ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase,
  Variants, ZLogFile,Dialogs;

  {============��������
    Yesterday:  ��д��YD
    Today:      ��д��TD
    Last Month: ��д��LM
    This Month: ��д��TM
    Last Year : ��д��LY  (LYTM:ȥ��ͬ�·ݣ�ͬ��)
    AMT: ����
    MNY: ���
    PRF: ë��
    PRF_RATE��ë����
    Stock holding ratio:������ ��д:SH_Ratio
   =============}
  //�쾭Ӫ���:
type
  TSaleDayMsg=Record
    YDSale_AMT: real;   //��������(��λ:��);
    YDSale_MNY: real;   //�������۶�(Ԫ);
    YDSale_PRF: real;   //����ë��(Ԫ);
    YDSale_PRF_RATE: real;  //����ë����(%);
    TDSale_AMT: real;   //��������(��λ:��);
    TDSale_MNY: real;   //�������۶�(Ԫ);
    TDSale_PRF: real;   //����ë��(Ԫ);
    TDSale_PRF_RATE: real;  //����ë����(%);

    TDStock_GODS_Count: integer;
    TDStock_AMT: real;
    TDStock_MNY: real;
    TDStock_Single_MNY: real;  //����ë����(%);

    TDStock_AMT_RATE: real;
    TDStock_MNY_Grow: real;
    TDStock_Single_MNY_Grow: real;  //����ë����(%);
  end;

  //�·ݾ�Ӫ���:
  TSaleMonthMsg=Record
    //Month: string;      //�·�
    //ͬ���»���:
    LMSale_AMT: real;   //��������(��λ:��);
    LMSale_MNY: real;   //�������۶�(Ԫ);
    LMSale_PRF: real;   //����ë(��λ:��);
    LMSale_SINGLE_MNY: real;  //����ƽ��ÿ�����۶�(Ԫ);

    //��ǰ�·�
    TMStock_AMT: real;    //���¹���(��λ:��);
    TMStock_SINGLE_MNY: real; //���¹���(����ֵ);
    TMSale_AMT: real;     //��������(��λ:��);
    TMSale_MNY: real;     //�������۶�(Ԫ);
    TMSale_PRF: real;     //����ë(��λ:��);
    TMSale_PRF_RATE: real;    //����ë����;
    TMSale_SINGLE_MNY: real;  //����ƽ��ÿ�����۶�(Ԫ);
    TMSale_AMT_UP_RATE: real;    //������������;
    TMSale_PRF_UP_RATE: real;    //����ë��������;
    TMSale_SINGLE_MNY_UP_RATE: real;   //���µ������������;
    TMNEWGODS_COUNT: integer;    //������Ʒ
    TMNEWSTOR_COUNT: integer;    //���¾�Ӫ��Ʒ

    TMGods_MaxGrow_AMT: string;  //�������ǰ3�������֮���á�;�������;
    TMGods_MaxGrow_PRF: string;  //ë�����ǰ3�������֮���á�;�������;
    TMGods_MaxGrowRate_AMT: string;  //���������������3�������֮���á�;�������;
    
    //2011.10.12 ������:
    TMGods_Count: integer;     //���¾�ӪƷ����;
    TMGods_SX_Count: integer;     //���¾�ӪƷ����;
    TMAllStor_AMT: real;       //��Ʒ�ܿ����
    TMLowStor_Count: integer;  //���ں�������Ʒ��

    //2011.10.12 ������(��Ա)���:
    TMCust_Count: integer;     //�ܵ������߸���;
    TMCust_HG_Count: integer;  //�ߵ��̲������߸���;
    TMCust_NEW_Count: integer; //�����½������߸���;
    TMCust_AMT: real;          //��������������;
    TMCust_MNY: real;          //���������ѽ��;
    TMCust_AMT_RATE: real;     //������������������ռ�ı���;
    TMCust_MNY_RATE: real;     //�������������ѽ��ռ�ı���;
  end;


type
  TSaleAnalyMsg=class
  private
    FCalcStor: Boolean;
    FCurMonth: string; //��ǰ�·�
    MaxRckDay: string; //��������
    MinMonth: string;  //��С�����·�
    MaxMonth: string;  //�������·�
    LM_BegDate: string; //���µ�һ��
    LM_EndDate: string; //������һ��
    TM_BegDate: string; //���µ�һ��
    TM_EndDate: string; //������һ��

    TopCount: integer;
    Qry: TZQuery;
    procedure InitalParam; //��ʼ������
    procedure InitalMonthMsg;  //��ʼ������
    procedure SetRckMonth(var vMinMonth,vMaxMonth,vMaxRckDay: string);  //�����½����·�

    function GetFactor: TdbFactory; //����
    function GetTenantID: string; //������ҵID
    function FormatFloatValue(InValue :real; size: integer): real;

    function GetMaxGodsName(vType: integer; BegDate,EndDate: string): string; //������ë������������Ʒ
    function GetGrowRateGodsName: string; //�����������������ǰ������Ʒ

    //�¶Ⱦ�Ӫ����
    function LastMonth_SaleInfo: Boolean; //�ϸ��¾�Ӫ���;
    function ThisMonth_SaleInfo: Boolean; //��ǰ�·ݾ�Ӫ���;
    function GetCustomerInfo: Boolean; //���ػ�Ա��Ϣ
    function GetStorageInfo: Boolean;  //���ؿ�����
    function ThisMonth_StockInfo: Boolean;  //���¹�������
    function ThisMonth_NewGodsInfo: Boolean;  //������Ʒ
    procedure SetCurMonth(InValue: string);
    procedure GetStockDayMsg;  //���ص�������msg
  public
    DayMsg: TSaleDayMsg;   //ÿ��������Ϣ
    MonthMsg: TSaleMonthMsg;  //�¾�Ӫ���
    constructor Create;
    destructor Destroy; override;
    procedure GetSaleDayMsg;  //���ص�������msg
    procedure GetSaleMonthMsg(vCount: integer=3);  //���ص�������msg
    property Factor: TdbFactory read GetFactor;    //���⴫��
    property Tenant_ID: string read GetTenantID;   //������ҵID
    property CurMonth: string read FCurMonth write SetCurMonth;    //��ʾ�·�
  end;

var
  SaleAnalyMsg: TSaleAnalyMsg;

implementation

uses
  uGlobal,uShopGlobal,DateUtils,uFnUtil,ufrmLogo;


{ TSaleAnalyMsg }

constructor TSaleAnalyMsg.Create;
begin
  inherited;
  FCalcStor:=False;
  Qry:=TZQuery.Create(nil);
  self.InitalParam;
end;

destructor TSaleAnalyMsg.Destroy;
begin
  Qry.Free;
  inherited;
end;

procedure TSaleAnalyMsg.InitalParam;
begin
  SetRckMonth(MinMonth,MaxMonth,MaxRckDay); //ȡ�����·��ڼ�
  //������ʼ��������
  LM_BegDate:=FormatDatetime('YYYYMM',IncMonth(Date(),-2))+'01'; //���¿�ʼ����;
  LM_EndDate:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(Date(),-2))); //�������һ��;
  //������ʼ��������
  TM_BegDate:=FormatDatetime('YYYYMM',IncMonth(Date(),-1))+'01';  //���¿�ʼ����;
  TM_EndDate:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(Date(),-1)));  //���½������ڣ����죩;

  //��ʼ���վ�Ӫ����
  DayMsg.YDSale_AMT:=0;   //��������(��λ:��);
  DayMsg.YDSale_MNY:=0;   //�������۶�(Ԫ);
  DayMsg.YDSale_PRF:=0;   //����ë��(Ԫ);
  DayMsg.YDSale_PRF_RATE:=0;  //����ë����(%);
  DayMsg.TDSale_AMT:=0;   //��������(��λ:��);
  DayMsg.TDSale_MNY:=0;   //�������۶�(Ԫ);
  DayMsg.TDSale_PRF:=0;   //����ë��(Ԫ);
  DayMsg.TDSale_PRF_RATE:=0;  //����ë����(%);

  DayMsg.TDStock_GODS_Count:=0;
  DayMsg.TDStock_AMT:=0;
  DayMsg.TDStock_MNY:=0;
  DayMsg.TDStock_Single_MNY:=0;  //����ë����(%);

  DayMsg.TDStock_AMT_RATE:=0;
  DayMsg.TDStock_MNY_Grow:=0;
  DayMsg.TDStock_Single_MNY_Grow:=0;  //����ë����(%);
  //��ʼ���¾�Ӫ����
  FCurMonth:=FormatDatetime('YYYYMM',IncMonth(Date(),-1));;

  //��ʼ���²���
  InitalMonthMsg;
end;

procedure TSaleAnalyMsg.SetRckMonth(var vMinMonth, vMaxMonth,vMaxRckDay: string);
var
  rs: TZQuery;
begin
  try
    vMinMonth:='';
    vMaxMonth:='';
    vMaxRckDay:='';
    rs:=TZQuery.create(nil);
    rs.SQL.Text:='select min(MONTH) as minMonth,max(MONTH) as maxMonth,max(END_DATE) as maxRckDate from RCK_MONTH_CLOSE where TENANT_ID='+Tenant_ID+' ';
    Factor.Open(rs);
    if rs.Active then
    begin
      vMinMonth:=trim(rs.fieldbyName('minMonth').AsString);
      vMaxMonth:=trim(rs.fieldbyName('maxMonth').AsString);
      vMaxRckDay:=trim(rs.fieldbyName('maxRckDate').AsString);
      vMaxRckDay:=Copy(vMaxRckDay,1,4)+Copy(vMaxRckDay,6,2)+Copy(vMaxRckDay,9,2); //�������ڸ�ʽ(8λ)
    end;
  finally
    rs.Free;
  end;
end;

procedure TSaleAnalyMsg.GetSaleDayMsg;
var
  YsDay: string; //���죻
  ToDay: string; //����;
  str,CalcUnit: string;
  NOTAX_MONEY: Real;
begin
  try
    CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
    YsDay:=FormatDatetime('YYYYMMDD',Date()-1); //������������;
    ToDay:=FormatDatetime('YYYYMMDD',Date()); //���½������ڣ����죩;
    //�����������
    str:=
      'select a.SALES_DATE as SALES_DATE,sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
      'from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 '+
      ' and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE in ('+YsDay+','+ToDay+') group by a.SALES_DATE ';
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Locate('SALES_DATE',YsDay,[]) then
    begin
      DayMsg.YDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      DayMsg.YDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      DayMsg.YDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //����˰���
      if NOTAX_MONEY<>0 then //ë�� �� ����˰���
        DayMsg.YDSale_PRF_RATE:=FormatFloatValue((DayMsg.YDSale_PRF*100)/NOTAX_MONEY,2);
    end;

    if Qry.Locate('SALES_DATE',ToDay,[]) then
    begin
      DayMsg.TDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      DayMsg.TDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      DayMsg.TDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //����˰��� 
      if NOTAX_MONEY>0 then
        DayMsg.TDSale_PRF_RATE:=FormatFloatValue((DayMsg.TDSale_PRF*100)/NOTAX_MONEY,2);
    end;
    //���㵱��
    GetStockDayMsg;
    //���ؿ�����
    GetStorageInfo;
  except
    on E:Exception do
    begin
      Raise Exception.Create('�����վ�Ӫ�������,����:'+E.message);
    end;
  end;
end;

procedure TSaleAnalyMsg.GetSaleMonthMsg(vCount: integer);
var
  CurMonth: string; //��ǰ�·�
  BegDate: string; //��ʼ����;
  EndDate: string; //��������;
  CurDate: TDate;
  str: string;
  StorageValue,NOTAX_MONEY: real; //�������
begin
  TopCount:=vCount;
  //��ʼ���²���
  InitalMonthMsg;

  frmLogo.ShowTitle := '���ڼ������·ݾ�Ӫ... ';
  frmLogo.Update;  //���·ݾ�Ӫ���(����):
  LastMonth_SaleInfo;

  frmLogo.ShowTitle := '���ڼ��㱾�·ݾ�Ӫ... ';
  frmLogo.Update;  //��ǰ�·ݾ�Ӫ���:
  ThisMonth_SaleInfo;

  frmLogo.ShowTitle := '���ڼ��㱾�¹���... ';
  frmLogo.Update;  //���µĹ���:
  ThisMonth_StockInfo;

  frmLogo.ShowTitle := '���ڼ��㱾�¿��... ';
  frmLogo.Update;  //���ؿ�����
  GetStorageInfo;

  frmLogo.ShowTitle := '���ڼ��㱾����Ʒ... ';
  frmLogo.Update;  //������Ʒ
  ThisMonth_NewGodsInfo;

  frmLogo.ShowTitle := '���ڼ��㱾���������������... ';
  frmLogo.Update;  //�������������
  GetCustomerInfo;

  try 
    //�ԱȾ�Ӫ���(ͬ���»���)��
    if MonthMsg.LMSale_AMT<>0 then
      MonthMsg.TMSale_AMT_UP_RATE:=FormatFloatValue((MonthMsg.TMSale_AMT-MonthMsg.LMSale_AMT)*100.0/MonthMsg.LMSale_AMT,2);  //���»�����������;
    if MonthMsg.LMSale_PRF<>0 then
      MonthMsg.TMSale_PRF_UP_RATE:=FormatFloatValue((MonthMsg.TMSale_PRF-MonthMsg.LMSale_PRF)*100.0/MonthMsg.LMSale_PRF,2);   //���»���ë������;
    if MonthMsg.LMSale_SINGLE_MNY<>0 then
      MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=FormatFloatValue((MonthMsg.TMSale_SINGLE_MNY-MonthMsg.LMSale_SINGLE_MNY)*100.0/MonthMsg.LMSale_SINGLE_MNY,2);  //���»��ȵ���������

    //���·���û�����ݣ�������Ĭ�ϣ�100��
    if (MonthMsg.LMSale_AMT=0) and (MonthMsg.LMSale_SINGLE_MNY=0) and (MonthMsg.LMSale_PRF=0) and
       (MonthMsg.TMSale_AMT<>0) and (MonthMsg.TMSale_SINGLE_MNY<>0) and (MonthMsg.TMSale_PRF<>0) then
    begin
      MonthMsg.TMSale_AMT_UP_RATE:=100.00;
      MonthMsg.TMSale_PRF_UP_RATE:=100.00;
      MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=100.00;
    end;

    if (MonthMsg.LMSale_AMT<>0) and (MonthMsg.LMSale_SINGLE_MNY<>0) and (MonthMsg.LMSale_PRF<>0) and
       (MonthMsg.TMSale_AMT=0) and (MonthMsg.TMSale_SINGLE_MNY=0) and (MonthMsg.TMSale_PRF=0) then
    begin
      MonthMsg.TMSale_AMT_UP_RATE:=0;
      MonthMsg.TMSale_PRF_UP_RATE:=0;
      MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=0;
    end;


    //�����Ա����ռ������
    if MonthMsg.TMSale_AMT<>0 then
      MonthMsg.TMCust_AMT_RATE:=FormatFloatValue(MonthMsg.TMCust_AMT*100.0/MonthMsg.TMSale_AMT,2);
    if MonthMsg.TMSale_MNY<>0 then
      MonthMsg.TMCust_MNY_RATE:=FormatFloatValue(MonthMsg.TMCust_MNY*100.0/MonthMsg.TMSale_MNY,2);
 
    frmLogo.ShowTitle := '���ڼ�����Ʒ��������... ';
    //���·ݾ�Ӫ������ë������ǰ��λ����Ʒ������������ǰ��λ:
    MonthMsg.TMGods_MaxGrow_AMT:=GetMaxGodsName(1,TM_BegDate,TM_EndDate);  //��������ǰ��λ
    MonthMsg.TMGods_MaxGrow_PRF:=GetMaxGodsName(2,TM_BegDate,TM_EndDate);  //����ë��ǰ��λ
    MonthMsg.TMGods_MaxGrowRate_AMT:=GetGrowRateGodsName;  //����������������ǰ��λ
  except
    on E:Exception do
    begin
      Raise Exception.Create('�����¾�Ӫ����(���ȡ�ͬ��)����,����:'+E.message);
    end;
  end;
end;

function TSaleAnalyMsg.GetFactor: TdbFactory; //����
begin
  result:=uGlobal.Factor;
end;

function TSaleAnalyMsg.GetTenantID: string;
begin
  result:=InttoStr(Global.TENANT_ID);
end;

function TSaleAnalyMsg.FormatFloatValue(InValue: real; size: integer): real;
var
  vSize: LongInt;
  CurValue: Real;
begin
  result:=InValue;
  vSize:=1;
  case size of
   0: vSize:=1;
   1: vSize:=10;
   2: vSize:=100;
   3: vSize:=1000;
   4: vSize:=10000;
   5: vSize:=100000;
   6: vSize:=1000000;
   7: vSize:=10000000;
  end;
  CurValue:=Round(InValue*vSize);
  result:=CurValue/vSize;  //���� 
end;

//������ë������������Ʒ
function TSaleAnalyMsg.GetMaxGodsName(vType: integer; BegDate,EndDate: string): string;
var
  str,BaseTab,ReStr: string;
  rs: TZQuery;
begin
  result:='';
  ReStr:='';
  if TopCount<=0 then TopCount:=3;  //Ĭ��ȡǰ����

  case vType of
   1: //����
    begin
      BaseTab:=
        'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,PUB_GOODSINFO b '+
        ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+
        ' group by GODS_NAME';
      case Factor.iDbType of
       0,2,3:
          str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SAL_AMT desc'; //����
       1: str:='select GODS_NAME From ('+BaseTab+')tp where rownum<='+InttoStr(TopCount)+' order by SAL_AMT desc';
       4: str:='select GODS_NAME from (select * From ('+BaseTab+')tmp order by SAL_AMT desc)tp fetch first '+InttoStr(TopCount)+' rows only ';
       5: str:='select GODS_NAME from ('+BaseTab+')tmp order by SAL_AMT desc limit '+InttoStr(TopCount)+'';
      end;
    end;
   2: //ë��
    begin
      BaseTab:=
        'select GODS_NAME,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,PUB_GOODSINFO b '+
        ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+
        ' group by GODS_NAME';
      case Factor.iDbType of
       0,2,3:
          str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SALE_PRF desc'; //����
       1: str:='select GODS_NAME From ('+BaseTab+')tp where rownum<='+InttoStr(TopCount)+' order by SALE_PRF desc';
       4: str:='select GODS_NAME from (select * From ('+BaseTab+')tmp order by SALE_PRF desc)tp fetch first '+InttoStr(TopCount)+' rows only ';
       5: str:='select GODS_NAME from ('+BaseTab+')tmp order by SALE_PRF desc limit '+InttoStr(TopCount)+' ';
      end;
    end;
  end;

  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if rs.Active then
    begin
      rs.First;
      while not rs.Eof do
      begin
        if ReStr='' then
          ReStr:=rs.fieldbyName('GODS_NAME').AsString
        else
          ReStr:=ReStr+'��'+rs.fieldbyName('GODS_NAME').AsString;
        rs.Next;
      end; 
    end;
  finally
    rs.Free;
  end;
  result:=ReStr;
  if result='' then result:='��';
end;

//������С��������Ʒ
function TSaleAnalyMsg.GetGrowRateGodsName: string;
var
  LMTab,TMTab,BaseTab,OrderBy,Str,ReStr: string;
  rs: TZQuery;
begin
  if TopCount<=0 then TopCount:=3;  //Ĭ��ȡǰ����
  //�ϸ�����������:
  BaseTab:=
    'select b.GODS_NAME as GODS_NAME,'+
    ' cast(sum(case when a.SALES_DATE>='+TM_BegDate+' and a.SALES_DATE<='+TM_EndDate+' then a.CALC_AMOUNT else 0 end) as decimal(18,3))as TM_SAL_AMT,'+
    ' cast(sum(case when a.SALES_DATE>='+LM_BegDate+' and a.SALES_DATE<='+LM_EndDate+' then a.CALC_AMOUNT else 0 end) as decimal(18,3))as LM_SAL_AMT '+
    ' from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+
    ' and a.SALES_DATE>='+LM_BegDate+' and a.SALES_DATE<='+TM_EndDate+' group by b.GODS_NAME';

  case Factor.iDbType of
   0,2,3:
      str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp where LM_SAL_AMT<>0 order by (TM_SAL_AMT/LM_SAL_AMT) desc '; //����
   1: str:='select GODS_NAME From ('+BaseTab+')tp where LM_SAL_AMT<>0 and rownum<='+InttoStr(TopCount)+' order by (TM_SAL_AMT/LM_SAL_AMT) desc';
   4: str:='select GODS_NAME from (select * From ('+BaseTab+')tmp where LM_SAL_AMT<>0 order by (TM_SAL_AMT/LM_SAL_AMT) desc)tp fetch first '+InttoStr(TopCount)+' rows only ';
   5: str:='select GODS_NAME from ('+BaseTab+')tp where LM_SAL_AMT<>0 order by (TM_SAL_AMT/LM_SAL_AMT) desc limit '+InttoStr(TopCount);
  end;

  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if rs.Active then
    begin
      rs.First;
      while not rs.Eof do
      begin
        if ReStr='' then
          ReStr:=rs.fieldbyName('GODS_NAME').AsString
        else
          ReStr:=ReStr+'��'+rs.fieldbyName('GODS_NAME').AsString;
        rs.Next; 
      end;
    end;
  finally
    rs.Free;
  end;
  result:=ReStr;
  if result='' then result:='��';
end;

function TSaleAnalyMsg.LastMonth_SaleInfo: Boolean;
var
  CurMonth: string; //��ǰ�·�
  BegDate: string; //��ʼ����;
  EndDate: string; //��������;
  CurDate: TDate;
  str,CalcUnit: string;
begin
  result:=False;
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  try
    //�ϸ��¾�Ӫ�����
    CurMonth:=FormatDatetime('YYYYMM',IncMonth(Date(),-2));
    if CurMonth>MaxMonth then //��ǰ�·� ���� �������£���ѯ��ͼ
    begin
      str:=
        'select '+
        ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+      //��������[��]
        '(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,'+  //���۽��
        '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //����ë��
        'from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and '+
        ' a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+LM_BegDate+' and a.SALES_DATE<='+LM_EndDate+' ';
    end else
    begin  //��������[��], ���۽��, ����ë��
      str:=
        'select '+
        ' sum(SALE_AMT/'+CalcUnit+') as SAL_AMT,'+
        ' sum(SALE_RTL) as SALE_MNY,'+
        ' sum(SALE_PRF) as SALE_PRF '+
        ' from RCK_GOODS_MONTH a,VIW_GOODSINFO b '+
        ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and a.TENANT_ID='+Tenant_ID+' and a.MONTH='+CurMonth+' ';
    end;
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      MonthMsg.LMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      MonthMsg.LMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      MonthMsg.LMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if MonthMsg.LMSale_AMT<>0 then
        MonthMsg.LMSale_SINGLE_MNY:=FormatFloatValue(MonthMsg.LMSale_MNY/MonthMsg.LMSale_AMT,2);
      result:=true;
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('���㣨�ϸ��·ݣ��¾�Ӫ��������,����:'+E.message);
    end;
  end;
end;

function TSaleAnalyMsg.ThisMonth_SaleInfo: Boolean;
var
  CurMonth: string; //��ǰ�·�
  CurDate: TDate;
  str,CalcUnit: string;
  StorageValue,NOTAX_MONEY: real; //�������
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  try
    //���¾�Ӫ�����
    str:=
      'select '+
      ' sum(case when isnull(CLIENT_ID,'''')<>'''' then cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3)) else 0 end) as CUST_MNY,'+  //�̶����ѽ��
      ' sum(NOTAX_MONEY) as NOTAX_MONEY,'+  //����˰���
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //��������[��]
      ' sum(cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3))) as SALE_MNY,'+  //���۽��
      ' sum(cast(isnull(NOTAX_MONEY,0)-isnull(COST_MONEY,0) as decimal(18,3))) as SALE_PRF '+ //����ë��
      'from VIW_SALESDATA a,PUB_GOODSINFO b '+
      ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+
      ' and a.SALES_DATE>='+TM_BegDate+' and a.SALES_DATE<='+TM_EndDate+' ';

    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      MonthMsg.TMCust_MNY:=FormatFloatValue(Qry.fieldbyName('CUST_MNY').AsFloat,2);   //���¹̶����ѽ��
      MonthMsg.TMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);    //����������
      MonthMsg.TMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);   //�������۶�
      MonthMsg.TMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);   //��������ë����
      NOTAX_MONEY:=FormatFloatValue(Qry.fieldbyName('NOTAX_MONEY').AsFloat,2);        //���²�����˰���
      if MonthMsg.TMSale_AMT<>0 then  //���㱾�µ���ֵ:
        MonthMsg.TMSale_SINGLE_MNY:=FormatFloatValue(MonthMsg.TMSale_MNY/MonthMsg.TMSale_AMT,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat;
      if MonthMsg.TMSale_PRF<>0 then
        MonthMsg.TMSale_PRF_RATE:=FormatFloatValue((MonthMsg.TMSale_PRF*100.0)/NOTAX_MONEY,2);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('���㣨���·ݣ��¾�Ӫ��������,����:'+E.message);
    end;
  end;
end;

function TSaleAnalyMsg.GetCustomerInfo: Boolean;
var
  CalcUnit: string;
  Rs: TZQuery;
begin
  result:=False;
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  try
    //�������������:
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select count(CUST_ID) as allCount,sum(case when SND_DATE>='''+TM_BegDate+''' and SND_DATE<='''+TM_EndDate+''' then 1 else 0 end) as newCount from PUB_CUSTOMER where TENANT_ID='+Tenant_ID+' ';
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMCust_Count:=Rs.FieldByName('allCount').AsInteger;       //�ܵ������߸���;
      MonthMsg.TMCust_NEW_Count:=Rs.FieldByName('newCount').AsInteger;   //�����½������߸���;
    end;    

    //�����Ա�������:
    Rs.Close;
    Rs.SQL.Text:=ParseSQL(Factor.iDbType,
      'select sum(SAL_AMT) as SAL_AMT,sum(SALE_MNY) as SALE_MNY,count(distinct tmp.SORT_ID2) as CUST_HG_COUNT  from '+
      '(select (case when isnull(CLIENT_ID,'''')<>'''' then CALC_AMOUNT/'+CalcUnit+' else 0 end) as SAL_AMT,'+       //��������������[��]
      ' (case when isnull(CLIENT_ID,'''')<>'''' then NOTAX_MONEY+TAX_MONEY else 0 end) as SALE_MNY,'+   //���������۽��
      ' (case when b.SORT_ID2 in (''85994503-9CBC-4346-BC86-24C7F5A92BC6'',''59FD3FCD-2E8F-440A-B9B6-727B45524535'') then b.SORT_ID2 else '''' end) as SORT_ID2 '+ //�ߵ���������ռ������
      ' from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and '+
      ' a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+TM_BegDate+' and a.SALES_DATE<='+TM_EndDate+')tmp ');
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMCust_AMT:=FormatFloatValue(Rs.FieldByName('SAL_AMT').AsFloat,2);  //��������������;
      MonthMsg.TMCust_MNY:=FormatFloatValue(Rs.FieldByName('SALE_MNY').AsFloat,2); //���������ѽ��;
      MonthMsg.TMCust_HG_Count:=Rs.FieldByName('CUST_HG_COUNT').AsInteger; //������(�ߵ��̵ĸ���);
    end;
  finally
    Rs.Free;
  end;
end;

function TSaleAnalyMsg.GetStorageInfo: Boolean;
var
  Rs: TZQuery;
begin
  if FCalcStor then Exit;
  //2011.10.12 ������:
  MonthMsg.TMGods_Count:=0;      //���¾�ӪƷ����;
  MonthMsg.TMGods_SX_Count:=0;   //���¾�ӪƷ����;
  MonthMsg.TMAllStor_AMT:=0;     //��Ʒ�ܿ����
  MonthMsg.TMLowStor_Count:=0;   //���ں�������Ʒ��

  result:=False;
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:=ParseSQL(Factor.iDbType,
      'select count(a.GODS_ID) as GODS_COUNT,'+  //�п����Ʒ����
      ' sum(case when c.SORT_ID10 =''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'' then 1 else 0 end) as GODS_SX_COUNT,'+  //�Ƿ��ǳ���Ʒ��
      ' sum(case when c.SORT_ID11=''5D8D7AF6-2DE3-4866-85C7-925E07F66096'' then 1 else 0 end) as GODS_NEW_COUNT,'+  //�Ƿ�����Ʒ
      ' sum(case when (a.AMOUNT<b.LOWER_AMOUNT) and (isnull(b.LOWER_AMOUNT,0)>0) then 1 else 0 end) as LOWER_COUNT, '+ //���ں���������
      ' sum(AMOUNT/(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)) as STOR_SUM '+  //���������[��λ:��]
      ' from STO_STORAGE a '+
      ' inner join VIW_GOODSINFO c on a.GODS_ID=c.GODS_ID '+
      ' left outer join PUB_GOODS_INSHOP b on a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID '+
      ' where round(a.AMOUNT,3)>0 and c.RELATION_ID=1000006 and a.TENANT_ID='+Tenant_ID+' ');
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMGods_Count:=Rs.FieldbyName('GODS_COUNT').AsInteger;       //���¾�ӪƷ����;
      MonthMsg.TMGods_SX_Count:=Rs.FieldbyName('GODS_SX_COUNT').AsInteger; //���³���Ʒ����
      MonthMsg.TMNEWGODS_COUNT:=Rs.FieldbyName('GODS_NEW_COUNT').AsInteger; //���³���Ʒ����
      MonthMsg.TMLowStor_Count:=Rs.FieldbyName('LOWER_COUNT').AsInteger; //���ں�������Ʒ��
      MonthMsg.TMAllStor_AMT:=FormatFloatValue(Rs.FieldbyName('STOR_SUM').AsFloat,2);        //��Ʒ�ܿ����
      FCalcStor:=True;
    end;
  finally
    Rs.Free;
  end;
end;

function TSaleAnalyMsg.ThisMonth_StockInfo: Boolean;
var
  Rs: TZQuery;
begin
  result:=False;
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:=ParseSQL(Factor.iDbType,
      'select sum(CALC_AMOUNT/(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)) as STOCK_AMT '+  //�п����Ʒ����
      ' ,sum(CALC_MONEY) as STOCK_MNY '+
      ' from VIW_STOCKDATA a,PUB_GOODSINFO b '+
      ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+' and a.STOCK_DATE>='+TM_BegDate+' and a.STOCK_DATE<='+TM_EndDate+' ');
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMStock_AMT:=FormatFloatValue(Rs.FieldbyName('STOCK_AMT').AsFloat*1.00,2);  //�����������:��
      if MonthMsg.TMStock_AMT<>0 then
        MonthMsg.TMStock_SINGLE_MNY:=FormatFloatValue(Rs.FieldbyName('STOCK_MNY').AsFloat/MonthMsg.TMStock_AMT,2);  //����ƽ������
      result:=true;
    end;
  finally
    Rs.Free;
  end;
end;

function TSaleAnalyMsg.ThisMonth_NewGodsInfo: Boolean;
var
  Rs: TZQuery;
begin
  result:=False;
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:=ParseSQL(Factor.iDbType,
      'select Count(distinct TM.GODS_ID) as NEWGODS_COUNT from '+
      ' (select distinct a.GODS_ID from VIW_STOCKDATA a,PUB_GOODSINFO b '+
      '  where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+' and a.STOCK_DATE>='+TM_BegDate+' and a.STOCK_DATE<='+TM_EndDate+')TM '+
      ' left outer join (select distinct GODS_ID from VIW_STOCKDATA where TENANT_ID='+Tenant_ID+' and STOCK_DATE<='+TM_BegDate+')LS '+
      ' on TM.GODS_ID=LS.GODS_ID '+
      ' where LS.GODS_ID is null ');
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMNEWSTOR_COUNT:=Rs.FieldbyName('NEWGODS_COUNT').AsInteger;
      result:=true;
    end;
  finally
    Rs.Free;
  end;
end;

procedure TSaleAnalyMsg.SetCurMonth(InValue: string);
var
  CurDate: TDate;
begin
  if InValue <>'' then
  begin
    FCurMonth:=InValue;
    CurDate:=FnTime.fnStrtoDate(FCurMonth+'01');

    LM_BegDate:=FormatDatetime('YYYYMM',IncMonth(CurDate,-1))+'01';
    LM_EndDate:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(CurDate,-1)));

    TM_BegDate:=FormatDatetime('YYYYMM',CurDate)+'01';
    TM_EndDate:=FnTime.GetLastDate(FCurMonth);
  end;
end;

procedure TSaleAnalyMsg.GetStockDayMsg;
var
  maxID,minID: string;
  str: string;
  CurAMT,CurMNY,SingleMNY: Real;
begin
  maxID:='';
  minID:='';

  case Factor.iDbType of
    0,2,3:
       str:='select top 2  STOCK_ID from STK_STOCKORDER where isnull(COMM_ID,'''')<>'''' and TENANT_ID='+TENANT_ID+' and COMM not in (''02'',''12'') order by STOCK_DATE desc';
    1: str:='select STOCK_ID From STK_STOCKORDER where isnull(COMM_ID,'''')<>'''' and TENANT_ID='+TENANT_ID+' and COMM not in (''02'',''12'') and rownum<=2 order by STOCK_DATE desc';
    4: str:='select STOCK_ID from (select * From STK_STOCKORDER where isnull(COMM_ID,'''')<>'''' and TENANT_ID='+TENANT_ID+' and COMM not in (''02'',''12'') order by STOCK_DATE desc)tp fetch first 2 rows only ';
    5: str:='select STOCK_ID from STK_STOCKORDER where isnull(COMM_ID,'''')<>'''' and TENANT_ID='+TENANT_ID+' and COMM not in (''02'',''12'') order by STOCK_DATE desc limit 2 ';
  end;

  try
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);; 
    Factor.Open(Qry);
    if (Qry.active) and (Qry.RecordCount>0) then
    begin
      maxID:=trim(Qry.FieldbyName('STOCK_ID').asstring);
      if Qry.RecordCount>1 then
      begin
        Qry.Next;
        minID:=trim(Qry.FieldbyName('STOCK_ID').asstring);
      end;  
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('�����վ�Ӫ�������,����:'+E.message);
    end;
  end;
  
  str:=
    'select STOCK_ID'+
    ' ,count(distinct a.GODS_ID) as GODS_COUNT '+
    ' ,sum(CALC_AMOUNT/(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)) as STOCK_AMT '+
    ' ,sum(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0)) as STOCK_MONEY '+
    'from VIW_STOCKDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+' and STOCK_ID in ('''+maxID+''','''+minID+''') '+
    ' group by STOCK_ID ';
  try
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if (maxID<>'') and (Qry.Locate('STOCK_ID',maxID,[])) then
    begin 
      DayMsg.TDStock_GODS_Count:=Qry.fieldbyName('GODS_COUNT').AsInteger;
      DayMsg.TDStock_AMT:=FormatFloatValue(Qry.fieldbyName('STOCK_AMT').AsFloat,3);
      DayMsg.TDStock_MNY:=FormatFloatValue(Qry.fieldbyName('STOCK_MONEY').AsFloat,3);
      if DayMsg.TDStock_AMT<>0 then
        DayMsg.TDStock_Single_MNY:=FormatFloatValue(DayMsg.TDStock_MNY/DayMsg.TDStock_AMT,3);
    end;

    if (minID<>'') and (Qry.Locate('STOCK_ID',minID,[])) then
    begin
      CurAMT:=FormatFloatValue(Qry.fieldbyName('STOCK_AMT').AsFloat,3);
      if CurAMT<>0 then
        DayMsg.TDStock_AMT_Rate:=FormatFloatValue((DayMsg.TDStock_AMT-CurAMT)*100.0/CurAMT,2);

      CurMNY:=FormatFloatValue(Qry.fieldbyName('STOCK_MONEY').AsFloat,3);
      if CurMNY<>0 then
        DayMsg.TDStock_MNY_Grow:=FormatFloatValue((DayMsg.TDStock_MNY-CurMNY),2);

      SingleMNY:=FormatFloatValue(CurMNY/CurAMT,2);
      DayMsg.TDStock_Single_MNY_Grow:=FormatFloatValue(DayMsg.TDStock_Single_MNY-SingleMNY,2);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('�����վ�Ӫ�������,����:'+E.message);
    end;
  end;

end;

procedure TSaleAnalyMsg.InitalMonthMsg;
begin
  //ͬ���»���:
  MonthMsg.LMSale_AMT:=0;  //��������(��λ:��);
  MonthMsg.LMSale_MNY:=0;  //�������۶�(Ԫ);
  MonthMsg.LMSale_PRF:=0;  //����ë(��λ:��);
  MonthMsg.LMSale_SINGLE_MNY:=0;  //����ƽ��ÿ�����۶�(Ԫ);

  //��ǰ�·�
  MonthMsg.TMStock_AMT:=0;   //���¹���(��λ:��);
  MonthMsg.TMStock_SINGLE_MNY:=0;
  MonthMsg.TMSale_AMT:=0;    //��������(��λ:��);
  MonthMsg.TMSale_MNY:=0;    //�������۶�(Ԫ);
  MonthMsg.TMSale_PRF:=0;    //����ë(��λ:��);
  MonthMsg.TMSale_PRF_RATE:=0;     //����ë����
  MonthMsg.TMSale_SINGLE_MNY:=0;   //����ƽ��ÿ�����۶�(Ԫ);
  MonthMsg.TMSale_AMT_UP_RATE:=0;  //������������;
  MonthMsg.TMSale_PRF_UP_RATE:=0;  //����ë��������;
  MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=0;  //���µ������������;

  MonthMsg.TMGods_MaxGrow_AMT:='';      //�������ǰ3�������֮���á�;�������;
  MonthMsg.TMGods_MaxGrow_PRF:='';      //ë�����ǰ3�������֮���á�;�������;
  MonthMsg.TMGods_MaxGrowRate_AMT:='';  //���������������3�������֮���á�;�������;

  //2011.10.12 ������(��Ա)���:
  MonthMsg.TMCust_Count:=0;      //�ܵ������߸���;
  MonthMsg.TMCust_HG_Count:=0;   //�ߵ��̲������߸���;
  MonthMsg.TMCust_NEW_Count:=0;  //�����½������߸���;
  MonthMsg.TMCust_AMT:=0;        //��������������;
  MonthMsg.TMCust_MNY:=0;        //���������ѽ��;
  MonthMsg.TMCust_AMT_RATE:=0;   //������������������ռ�ı���;
  MonthMsg.TMCust_MNY_RATE:=0;   //�������������ѽ��ռ�ı���;
end;

end.
