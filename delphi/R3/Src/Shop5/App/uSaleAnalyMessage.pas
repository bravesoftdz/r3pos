unit uSaleAnalyMessage;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns,
  Des, WinInet, Controls, ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase,
  Variants, ZLogFile;

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
  end;

  //�·ݾ�Ӫ���:
  TSaleMonthMsg=Record
    Month: string;      //�·�
    //ͬ���»���:
    LMSale_AMT: real;   //��������(��λ:��);
    LMSale_MNY: real;   //�������۶�(Ԫ);
    LMSale_PRF: real;   //����ë(��λ:��);
    LMSale_SINGLE_MNY: real;  //����ƽ��ÿ�����۶�(Ԫ);
    //ͬȥ��ͬ��ͬ��:
    LYTMSale_AMT: real;  //ȥ��ͬ������(��λ:��);
    LYTMSale_MNY: real;  //ȥ��ͬ�����۶�(Ԫ);
    LYTMSale_PRF: real;  //ȥ��ͬ��ë(��λ:��);
    LYTMSale_SINGLE_MNY: real;  //ȥ��ͬƽ��ÿ�����۶�(Ԫ);
    //��ǰ�·�
    TMGods_AMT: integer;  //���¾�ӪƷ����;
    TMCust_AMT: integer;  //������������;
    TMCust_MNY: real;     //�������������ѽ��;
    TMCust_RATE: real;    //��������������ռ�ı���;
    TMSH_RATIO: real;     //���´�����;
    TMSale_AMT: real;     //��������(��λ:��);
    TMSale_MNY: real;     //�������۶�(Ԫ);
    TMSale_PRF: real;     //����ë(��λ:��);
    TMSale_PRF_RATE: real;    //����ë����(��λ:��);
    TMSale_SINGLE_MNY: real;  //����ƽ��ÿ�����۶�(Ԫ);

    TMSale_AMT_UP_RATE: real;  //������������;
    TMSale_PRF_UP_RATE: real;  //����ë������;
    TMSale_SINGLE_MNY_UP_RATE: real;  //���ȵ�����ֵ��������(Ԫ);

    LYTMSale_AMT_UP_RATE: real;  //ͬ������������;
    LYTMSale_PRF_UP_RATE: real;  //ͬ����ë������;
    LYTMSale_SINGLE_MNY_UP_RATE: real;  //ͬ�ȵ�����ֵ��������;

    TMGods_MaxGrow_AMT: string;  //�������ǰ3�������֮���á�;�������;
    TMGods_MaxGrow_PRF: string;  //ë�����ǰ3�������֮���á�;�������;

    TMGods_MaxGrowRate_AMT: string;  //���������������3�������֮���á�;�������;
    TMGods_MinGrowRate_AMT: string;  //���ȶ��������3�������֮���á�;�������;
  end;

type
  TSaleAnalyMsg=class
  private
    MinMonth: string; //��С�����·�
    MaxMonth: string; //�������·�
    LM_BegDate: string; //���µ�һ��
    LM_EndDate: string; //������һ��
    TM_BegDate: string; //���µ�һ��
    TM_EndDate: string; //������һ��

    TopCount: integer;
    Qry: TZQuery;
    procedure InitalParam; //��ʼ������
    procedure SetRckMonth(var vMinMonth,vMaxMonth: string);  //�����½����·�

    function GetFactor: TdbFactory; //����
    function GetTenantID: string; //������ҵID
    function FormatFloatValue(InValue :real; size: integer): real;
    function GetStorage(EndDate: string): real; //���µ׵Ŀ��

    function GetMaxGodsName(vType: integer; BegDate,EndDate: string): string; //������ë������������Ʒ
    function GetGrowRateGodsName(vType: integer): string; //�����������������ǰ������Ʒ
    //�¶Ⱦ�Ӫ����
    function LastMonth_SaleInfo: Boolean; //�ϸ��¾�Ӫ���;
    function LastYearThisMonth_SaleInfo: Boolean; //ȥ�굱ǰ�·ݾ�Ӫ���;
    function ThisMonth_SaleInfo: Boolean; //��ǰ�·ݾ�Ӫ���;
  public
    DayMsg: TSaleDayMsg;  //ÿ��������Ϣ
    MonthMsg: TSaleMonthMsg;  //�¾�Ӫ���
    constructor Create;
    destructor  Destroy; override;
    procedure GetSaleDayMsg;  //���ص�������msg
    procedure GetSaleMonthMsg(vCount: integer=3);  //���ص�������msg
    property Factor: TdbFactory read GetFactor; //���⴫��
    property Tenant_ID: string read GetTenantID;  //������ҵID
  end;

var
  SaleAnalyMsg: TSaleAnalyMsg;

implementation

uses
  uGlobal,uShopGlobal,DateUtils,uFnUtil;


{ TSaleAnalyMsg }

constructor TSaleAnalyMsg.Create;
begin
  inherited;
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
  SetRckMonth(MinMonth,MaxMonth); //ȡ�����·��ڼ�
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

  //��ʼ���¾�Ӫ����
  MonthMsg.Month:=FormatDatetime('YYYYMM',IncMonth(Date(),-1));
  MonthMsg.LMSale_AMT:=0;   //��������(��λ:��);
  MonthMsg.LMSale_MNY:=0;   //�������۶�(Ԫ);
  MonthMsg.LMSale_PRF:=0;   //����ë(��λ:��);
  MonthMsg.LMSale_SINGLE_MNY:=0; //����ƽ��ÿ�����۶�(Ԫ);

  //ͬȥ��ͬ��ͬ��:
  MonthMsg.LYTMSale_AMT:=0;   //ȥ��ͬ������(��λ:��);
  MonthMsg.LYTMSale_MNY:=0;   //ȥ��ͬ�����۶�(Ԫ);
  MonthMsg.LYTMSale_PRF:=0;   //ȥ��ͬ��ë(��λ:��);
  MonthMsg.LYTMSale_SINGLE_MNY:=0;  //ȥ��ͬƽ��ÿ�����۶�(Ԫ);

  MonthMsg.TMGods_AMT:=0;  //���¾�ӪƷ����;
  MonthMsg.TMCust_AMT:=0;  //������������;
  MonthMsg.TMCust_MNY:=0;  //�������������ѽ��;
  MonthMsg.TMCust_RATE:=0; //��������������ռ�ı���;
  MonthMsg.TMSH_RATIO:=0;  //���´�����;
  MonthMsg.TMSale_AMT:=0;  //��������(��λ:��);
  MonthMsg.TMSale_MNY:=0;  //�������۶�(Ԫ);
  MonthMsg.TMSale_PRF:=0;  //����ë(��λ:��);
  MonthMsg.TMSale_PRF_RATE:=0;    //����ë����(��λ:��);
  MonthMsg.TMSale_SINGLE_MNY:=0;  //�������۶�

  MonthMsg.TMSale_AMT_UP_RATE:=0; //����������
  MonthMsg.TMSale_PRF_UP_RATE:=0; //���۶�������
  MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=0;  //������ֵ��������(Ԫ);
  MonthMsg.LYTMSale_AMT_UP_RATE:=0;  //ͬ������������;
  MonthMsg.LYTMSale_PRF_UP_RATE:=0;  //ͬ����ë������;
  MonthMsg.LYTMSale_SINGLE_MNY_UP_RATE:=0;  //ͬ�ȵ�����ֵ��������(Ԫ);

  MonthMsg.TMGods_MaxGrow_PRF:='';  //����ë���������3�������֮���á�;�������;
  MonthMsg.TMGods_MaxGrow_AMT:='';  //���������������3�������֮���á�;�������;
  MonthMsg.TMGods_MaxGrowRate_AMT:='';  //����ë���������3�������֮���á�;�������;
  MonthMsg.TMGods_MinGrowRate_AMT:='';  //���������������3�������֮���á�;�������;
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
      'select sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 '+
      ' and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE='+YsDay+' ';
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      DayMsg.YDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      DayMsg.YDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      DayMsg.YDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //����˰��� 
      if NOTAX_MONEY<>0 then //ë�� �� ����˰���
        DayMsg.YDSale_PRF_RATE:=FormatFloatValue((DayMsg.YDSale_PRF*100)/NOTAX_MONEY,2);
    end;
    //if (DayMsg.YDSale_AMT=0) and (DayMsg.YDSale_MNY=0) then Exit;  //����û�о�Ӫ��������;
    
    //�����������
    str:=
      'select sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 '+
      ' and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE='+ToDay+' ';
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      DayMsg.TDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      DayMsg.TDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      DayMsg.TDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //����˰��� 
      if NOTAX_MONEY>0 then
        DayMsg.TDSale_PRF_RATE:=FormatFloatValue((DayMsg.TDSale_PRF*100)/NOTAX_MONEY,2);
    end;
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
  str,CalcUnit: string;
  StorageValue,NOTAX_MONEY: real; //�������
begin
  TopCount:=vCount;
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';

  //���·ݾ�Ӫ���(����):
  LastMonth_SaleInfo;
  //ȥ�걾�·ݾ�Ӫ���(ͬ��):
  LastYearThisMonth_SaleInfo;
  //��ǰ�·ݾ�Ӫ���:
  ThisMonth_SaleInfo;

  try 
    //�ԱȾ�Ӫ���(ͬ���»���)��
    if MonthMsg.LMSale_AMT<>0 then
      MonthMsg.TMSale_AMT_UP_RATE:=((MonthMsg.TMSale_AMT-MonthMsg.LMSale_AMT)*100)/MonthMsg.LMSale_AMT;  //���»�����������;
    if MonthMsg.LMSale_PRF<>0 then
      MonthMsg.TMSale_PRF_UP_RATE:=((MonthMsg.TMSale_PRF-MonthMsg.LMSale_PRF)*100)/MonthMsg.LMSale_PRF;  //���»���ë������;
    if MonthMsg.LMSale_SINGLE_MNY<>0 then
      MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=((MonthMsg.TMSale_SINGLE_MNY-MonthMsg.LMSale_SINGLE_MNY)*100)/MonthMsg.LMSale_SINGLE_MNY;   //���»��ȵ���������

    //�ԱȾ�Ӫ���(ͬȥ����ͬ��)��
    if MonthMsg.LYTMSale_AMT<>0 then
      MonthMsg.LYTMSale_AMT_UP_RATE:=((MonthMsg.TMSale_AMT-MonthMsg.LYTMSale_AMT)*100)/MonthMsg.LYTMSale_AMT;  //���»�����������;
    if MonthMsg.LYTMSale_PRF<>0 then
      MonthMsg.LYTMSale_PRF_UP_RATE:=((MonthMsg.LYTMSale_PRF-MonthMsg.LYTMSale_PRF)*100)/MonthMsg.LYTMSale_PRF;  //���»���ë������;
    if MonthMsg.LYTMSale_SINGLE_MNY<>0 then
      MonthMsg.LYTMSale_SINGLE_MNY_UP_RATE:=((MonthMsg.LYTMSale_SINGLE_MNY-MonthMsg.LYTMSale_SINGLE_MNY)*100)/MonthMsg.LYTMSale_SINGLE_MNY;   //���»��ȵ���������

    //���·ݾ�Ӫ������ë������ǰ��λ����Ʒ:
    MonthMsg.TMGods_MaxGrow_AMT:=GetMaxGodsName(1,TM_BegDate,TM_EndDate);  //��������ǰ��λ
    MonthMsg.TMGods_MaxGrow_PRF:=GetMaxGodsName(2,TM_BegDate,TM_EndDate);  //����ë��ǰ��λ
    //����������ǰ��λ�ͺ���λ����Ʒ:
    MonthMsg.TMGods_MaxGrowRate_AMT:=GetGrowRateGodsName(1);  //������������ǰ��λ
    MonthMsg.TMGods_MinGrowRate_AMT:=GetGrowRateGodsName(2);  //��������������ǰ��λ

    StorageValue:=GetStorage(TM_EndDate);                         //�µ��ܿ�
    if MonthMsg.TMSale_AMT<>0 then
      MonthMsg.TMSH_RATIO:=FormatFloatValue(StorageValue/MonthMsg.TMSale_AMT,5); //������
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
        'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,VIW_GOODSINFO b '+
        ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' and b.RELATION_ID=1000006 '+
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
        'select GODS_NAME,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,VIW_GOODSINFO b '+
        ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' and b.RELATION_ID=1000006 '+
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
function TSaleAnalyMsg.GetGrowRateGodsName(vType: integer): string;
var
  LMTab,TMTab,BaseTab,OrderBy,Str,ReStr: string;
  rs: TZQuery;
begin
  if TopCount<=0 then TopCount:=3;  //Ĭ��ȡǰ����
  //�ϸ�����������:
  LMTab:=
    'select a.GODS_ID as GODS_ID,b.GODS_NAME as GODS_NAME,sum(a.CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,VIW_GOODSINFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+LM_BegDate+' and a.SALES_DATE<='+LM_EndDate+' and b.RELATION_ID=1000006 '+
    ' group by a.GODS_ID,b.GODS_NAME';

  //������������:
  TMTab:=
    'select a.GODS_ID as GODS_ID,sum(a.CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,VIW_GOODSINFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+TM_BegDate+' and a.SALES_DATE<='+TM_EndDate+' and b.RELATION_ID=1000006 '+
    ' group by a.GODS_ID';
  //�������� 
  BaseTab:='select LM.GODS_NAME,(case when LM.SAL_AMT<>0 then TM.SAL_AMT/LM.SAL_AMT else 0 end) as GrowRate from ('+LMTab+')LM,('+TMTab+')TM where LM.GODS_ID=TM.GODS_ID ';

  case vType of
   1: OrderBy:=' order by GrowRate desc '; //���������������:3��
   2: OrderBy:=' order by GrowRate asc ';
  end;
  case Factor.iDbType of
   0,2,3:
      str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp '+OrderBy; //����
   1: str:='select GODS_NAME From ('+BaseTab+')tp where rownum<='+InttoStr(TopCount)+' '+OrderBy;
   4: str:='select GODS_NAME from (select * From ('+BaseTab+')tmp '+OrderBy+')tp fetch first '+InttoStr(TopCount)+' rows only ';
   5: str:='select GODS_NAME from ('+BaseTab+')tp '+OrderBy+' limit '+InttoStr(TopCount);
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

//���µ׵Ŀ��
function TSaleAnalyMsg.GetStorage(EndDate: string): real;
var
  rs:TZQuery;
  UnitCalc: string;
  Str,MaxReckDate,BegDate: string;
begin
  result:=0.0;
  MaxReckDate:='';
  BegDate:=EndDate; //��ѯ�������
  UnitCalc:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  rs := TZQuery.Create(nil);
  try
    Str:='select Max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID='+TENANT_ID;
    rs.Close;
    rs.SQL.Text := ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if rs.Active then MaxReckDate:=trim(rs.fieldbyName('CREA_DATE').AsString);

    if MaxReckDate='' then //δ����ȫ������ͼ:
    begin
      Str:=
        'select sum(cast(case when ORDER_TYPE in (11,13) then STOCK_AMT '+
                            ' when ORDER_TYPE in (21,23,24) then -SALE_AMT '+
                            ' when ORDER_TYPE=12 then DBIN_AMT '+
                            ' when ORDER_TYPE=22 then -DBOUT_AMT '+
                            ' else (CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*1.0 end as decimal(18,3))*1.0/'+UnitCalc+')as BAL_AMT '+
         'from VIW_GOODS_DAYS A,VIW_GOODSINFO D '+
         ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and D.RELATION_ID=1000006 '+
         ' and A.CREA_DATE<='+BegDate+' ';
    end else
    begin
      if MaxReckDate>=BegDate then  //�ѽ��ˣ�ȫ����̨�˱�
      begin
        Str:='select sum(A.BAL_AMT*1.0/'+UnitCalc+') as BAL_AMT from RCK_GOODS_DAYS A,VIW_GOODSINFO D '+
             ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+BegDate+' and D.RELATION_ID=1000006 ';
      end else //������������[union]
      begin
        Str:=
          'select sum(BAL_AMT) as BAL_AMT from '+
          '(select sum(A.BAL_AMT*1.0/'+UnitCalc+') as BAL_AMT from RCK_GOODS_DAYS A,VIW_GOODSINFO D '+
          ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+MaxReckDate+' and D.RELATION_ID=1000006 '+
          '  union all  '+
          ' select sum((case when ORDER_TYPE in (11,13) then STOCK_AMT '+
                           ' when ORDER_TYPE in (21,23,24) then -SALE_AMT '+
                           ' when ORDER_TYPE=12 then DBIN_AMT '+
                           ' when ORDER_TYPE=22 then -DBOUT_AMT '+
                           ' else CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT end)*1.0/'+UnitCalc+')as BAL_AMT '+
          ' from VIW_GOODS_DAYS A,VIW_GOODSINFO D '+
          ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE>'+MaxReckDate+
          ' and A.CREA_DATE<='+BegDate+' and D.RELATION_ID=1000006)tmp ';
      end;
    end;
    rs.Close;
    rs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if Rs.Active then
    begin
      if Rs.RecordCount=1 then
        result:=rs.fieldbyName('BAL_AMT').AsFloat
      else if Rs.RecordCount=0 then
        result:=0;
    end;
  finally
    rs.Free;
  end;
end;

procedure TSaleAnalyMsg.SetRckMonth(var vMinMonth, vMaxMonth: string);
var
  rs: TZQuery;
begin
  try
    vMinMonth:='';
    vMaxMonth:='';
    rs:=TZQuery.create(nil);
    rs.SQL.Text:='select min(MONTH) as minMonth,max(MONTH) as maxMonth from RCK_MONTH_CLOSE where TENANT_ID='+Tenant_ID+' ';
    Factor.Open(rs);
    if rs.Active then
    begin
      vMinMonth:=trim(rs.fieldbyName('minMonth').AsString);
      vMaxMonth:=trim(rs.fieldbyName('maxMonth').AsString);;
    end; 
  finally
    rs.Free;
  end;
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
        'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and '+
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

function TSaleAnalyMsg.LastYearThisMonth_SaleInfo: Boolean;
var
  CurMonth: string; //��ǰ�·�
  BegDate: string; //��ʼ����;
  EndDate: string; //��������;
  CurDate: TDate;
  str,CalcUnit: string;
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  try
    //ȥ�걾�¾�Ӫ�����
    CurDate:=IncYear(IncMonth(Date(),-1),-1) ;//ȥ�����µĽ���
    CurMonth:=FormatDatetime('YYYYMM',CurDate);
    if CurMonth>MaxMonth then //��ǰ�·� ���� �������£���ѯ��ͼ
    begin
      BegDate:=FormatDatetime('YYYYMM',CurDate)+'01'; //���¿�ʼ����;
      EndDate:=FnTime.GetLastDate(FormatDatetime('YYYYMM',CurDate)); //�������һ��;
      str:=
        'select '+
        ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+      //��������[��]
        '(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,'+  //���۽��
        '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //����ë��
        'from VIW_SALESDATA a,VIW_GOODSINFO b  where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and '+
        ' a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' ';
    end else
    begin  //��������[��], ���۽��, ����ë��
      str:=
        'select sum(SALE_AMT/'+CalcUnit+') as SAL_AMT,sum(SALE_RTL) as SALE_MNY,sum(SALE_PRF) as SALE_PRF '+
        ' from RCK_GOODS_MONTH a,VIW_GOODSINFO b '+
        ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and a.TENANT_ID='+Tenant_ID+' and a.MONTH='+CurMonth+' ';
    end;
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      MonthMsg.LYTMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      MonthMsg.LYTMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      MonthMsg.LYTMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if MonthMsg.LYTMSale_AMT<>0 then
        MonthMsg.LYTMSale_SINGLE_MNY:=FormatFloatValue(MonthMsg.LYTMSale_MNY/MonthMsg.LYTMSale_AMT,2);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('���㣨ȥ�걾�·ݣ��¾�Ӫ��������,����:'+E.message);
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
    Str:=
      'select TENANT_ID,CLIENT_ID,GODS_ID,CALC_AMOUNT,NOTAX_MONEY,'+
      'cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3)) as SALE_MNY,'+
      'cast(isnull(NOTAX_MONEY,0)-isnull(COST_MONEY,0) as decimal(18,3)) as SALE_PRF,'+
      '(case when isnull(CLIENT_ID,'''')<>'''' then cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3)) else 0 end) as CUST_MNY '+
      ' from VIW_SALESDATA where TENANT_ID='+Tenant_ID+' and SALES_DATE>='+TM_BegDate+' and SALES_DATE<='+TM_EndDate+' ';

    str:=
      'select '+
      ' count(distinct a.GODS_ID) as GODS_COUNT,'+   //��Ӫ��Ʒ��
      ' count(distinct a.CLIENT_ID) as CUST_COUNT,'+  //�̶���������
      ' sum(CUST_MNY) as CUST_MNY,'+  //�̶����ѽ��
      ' sum(NOTAX_MONEY) as NOTAX_MONEY,'+  //����˰���
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //��������[��]
      ' sum(SALE_MNY) as SALE_MNY,'+  //���۽��
      ' sum(SALE_PRF) as SALE_PRF '+ //����ë��
      'from ('+Str+') a,VIW_GOODSINFO b '+
      ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and b.TENANT_ID='+Tenant_ID;

    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      MonthMsg.TMGods_AMT:=Qry.fieldbyName('GODS_COUNT').AsInteger; //���¾�ӪƷ����
      MonthMsg.TMCust_AMT:=Qry.fieldbyName('CUST_COUNT').AsInteger;                   //���¹̶�������
      MonthMsg.TMCust_MNY:=FormatFloatValue(Qry.fieldbyName('CUST_MNY').AsFloat,2);   //���¹̶����ѽ��
      MonthMsg.TMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);    //����������
      MonthMsg.TMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);   //�������۶�
      MonthMsg.TMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);   //��������ë����
      NOTAX_MONEY:=FormatFloatValue(Qry.fieldbyName('NOTAX_MONEY').AsFloat,2);        //���²�����˰���
      if NOTAX_MONEY>0 then  //����ë����:
        MonthMsg.TMSale_PRF_RATE:=FormatFloatValue((MonthMsg.TMSale_PRF*100)/NOTAX_MONEY,2);
      if MonthMsg.TMSale_MNY<>0 then  //����̶�������ռ�ı���:
        MonthMsg.TMCust_RATE:=FormatFloatValue((MonthMsg.TMCust_MNY*100)/MonthMsg.TMSale_MNY,2);
      if MonthMsg.TMSale_AMT<>0 then  //���㱾�µ���ֵ:
        MonthMsg.TMSale_SINGLE_MNY:=FormatFloatValue(MonthMsg.TMSale_MNY/MonthMsg.TMSale_AMT,2);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('���㣨���·ݣ��¾�Ӫ��������,����:'+E.message);
    end;
  end;
end;

end.
