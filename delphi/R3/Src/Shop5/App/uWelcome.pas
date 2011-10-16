unit uWelcome;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns,
  Des, WinInet, Controls, ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase,
  Variants, ZLogFile,Dialogs;
  
type

  TMsgDayInfo=Record
    YDSaleGods_Count: integer; //��������Ʒ��(��λ:��);
    YDSaleBill_Count: integer; //�������۵��ݱ���(��λ:��);
    YDSale_AMT: real;   //��������(��λ:��);
    YDSale_MNY: real;   //�������۶�(Ԫ);
    YDSale_PRF: real;   //����ë��(Ԫ);
    YDSale_PRF_RATE: real;  //����ë����(%);

    TDSaleGods_Count: integer; //��������Ʒ��(��λ:��);
    TDSaleBill_Count: integer; //�������۵��ݱ���(��λ:��);
    TDSale_Count: integer;  //����Ʒ��(��λ:��);
    TDSale_AMT: real;   //��������(��λ:��);
    TDSale_MNY: real;   //�������۶�(Ԫ);
    TDSale_PRF: real;   //����ë��(Ԫ);
    TDSale_PRF_RATE: real;  //����ë����(%);
    //��ǰ��Ա�:
    QTSaleGods_Count: integer; //��������Ʒ��(��λ:��);
    QTSaleBill_Count: integer; //�������۵��ݱ���(��λ:��);
    QTSale_Count: integer;  //����Ʒ��(��λ:��);
    QTSale_AMT: real;   //��������(��λ:��);
    QTSale_MNY: real;   //�������۶�(Ԫ);
    QTSale_PRF: real;   //����ë��(Ԫ);
    QTSale_PRF_RATE: real;  //����ë����(%);

    TDStockGods_Count: integer; //���ν�����Ʒ��
    TDStock_AMT: real;  //���ν�������
    TDStock_MNY: real;  //���ν������

    SCStockGods_Count: integer; //���ν�����Ʒ��
    SCStock_AMT: real;  //���ν�������
    SCStock_MNY: real;  //���ν������

    TMGods_All_Count:integer;  //���¾�Ӫ��Ʒ����;
    TMGods_Count:integer;      //�����п��Ʒ����;
    TMGods_SX_Count:integer;   //���³���Ʒ����;
    TMGods_NEW_Count:integer;   //���³���Ʒ����;
    TMAllStor_AMT:real;     //��Ʒ�ܿ����
    TMLowStor_Count:integer;   //���ں�������Ʒ��
  end;

  //�·ݾ�Ӫ���:
  TMsgMonthInfo=Record
    //ͬ���»���:
    LMSale_AMT: real;   //��������(��λ:��);
    LMSale_MNY: real;   //�������۶�(Ԫ);
    LMSale_PRF: real;   //����ë(��λ:��);
    LMSale_SINGLE_MNY: real;  //����ƽ��ÿ�����۶�(Ԫ);

    //��ǰ�·�
    TMStock_AMT: real;    //���¹���(��λ:��);
    TMStock_MNY: real; //���¹���(����ֵ);
    
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
    TMGods_MaxGrow_PRF: string;  //����ë�����ǰ3�������֮���á�;�������;
    TMGods_SY_MaxGrow_PRF: string;  //����ë�����ǰ3�������֮���á�;�������;
    TMGods_MaxGrowRate_AMT: string;  //���������������3�������֮���á�;�������;
    
    //2011.10.12 ������(��Ա)���:
    TMCust_Count: integer;     //�ܵ������߸���;
    TMCust_HG_Count: integer;  //�ߵ��̲������߸���;
    TMCust_NEW_Count: integer; //�����½������߸���;
    TMCust_AMT: real;          //��������������;
    TMCust_MNY: real;          //���������ѽ��;
    TMCust_AMT_RATE: real;     //������������������ռ�ı���;
    TMCust_MNY_RATE: real;     //�������������ѽ��ռ�ı���;
    TMCust_MAX_TIME:string;    //������ʱ��
  end;
  
  TWelcome=class
  private
    dayRs:TZQuery;
    dayJh:TZQuery;
    dayKc:TZQuery;
    MthRs:TZQuery;
    FMonth: string;
    QtDay:string;
    YsDay:string;
    ToDay:string;
    procedure LoadDays;
    procedure LoadMths;
    procedure SetMonth(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    function EncodeMsgDayInfo:TMsgDayInfo;

    function EncodeMsgMthInfo:TMsgMonthInfo;

    property Month:string read FMonth write SetMonth;
  end;

implementation
uses uGlobal,uFnUtil;

{ TWelcome }

constructor TWelcome.Create;
begin
  dayRs := TZQuery.Create(nil);
  dayJh := TZQuery.Create(nil);
  dayKc := TZQuery.Create(nil);
  MthRs := TZQuery.Create(nil);
  Month := formatDatetime('YYYYMM',Date());
end;

destructor TWelcome.Destroy;
begin
  dayRs.Free;
  dayJh.Free;
  dayKc.Free;
  MthRs.Free;
  inherited;
end;

function TWelcome.EncodeMsgDayInfo: TMsgDayInfo;
begin
  if not dayRs.Active then LoadDays;
  //�����������:
  if dayRs.Locate('SALES_DATE',strtoint(YsDay),[]) then
  begin
    result.YDSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.YDSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.YDSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.YDSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.YDSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //ë�� �� ����˰���
       result.YDSale_PRF_RATE:=(result.YDSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;
  //�����������:
  if dayRs.Locate('SALES_DATE',strtoint(ToDay),[]) then
  begin
    result.TDSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.TDSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.TDSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.TDSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.TDSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //ë�� �� ����˰���
       result.TDSale_PRF_RATE:=(result.TDSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;
  //ǰ���������:
  if dayRs.Locate('SALES_DATE',strtoint(QTDay),[]) then
  begin
    result.QTSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.QTSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.QTSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.QTSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.QTSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //ë�� �� ����˰���
       result.QTSale_PRF_RATE:=(result.QTSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;
  //�������
  result.TDStockGods_Count:=dayJh.fieldbyName('GODS_COUNT').AsInteger;
  result.TDStock_AMT:=dayJh.fieldbyName('STK_AMT').AsFloat;
  result.TDStock_MNY:=dayJh.fieldbyName('STK_MNY').AsFloat;
  if dayJh.recordCount>1 then
     begin
       dayJh.Next;
       result.SCStockGods_Count:=dayJh.fieldbyName('GODS_COUNT').AsInteger;
       result.SCStock_AMT:=dayJh.fieldbyName('STK_AMT').AsFloat;
       result.SCStock_MNY:=dayJh.fieldbyName('STK_MNY').AsFloat;
     end;
     
  //��ǰ���
  result.TMGods_All_Count:=dayKc.FieldbyName('ALLGODS_COUNT').AsInteger;   //���¾�Ӫ��Ʒ����;
  result.TMGods_Count:=dayKc.FieldbyName('GODS_COUNT').AsInteger;       //�����п��Ʒ����;
  result.TMGods_SX_Count:=dayKc.FieldbyName('GODS_SX_COUNT').AsInteger; //���³���Ʒ����
  result.TMGods_NEW_Count:=dayKc.FieldbyName('GODS_NEW_COUNT').AsInteger; //������Ʒ����
  result.TMLowStor_Count:=dayKc.FieldbyName('LOWER_COUNT').AsInteger; //���ں�������Ʒ��
  result.TMAllStor_AMT:=dayKc.FieldbyName('STOR_SUM').AsFloat;        //��Ʒ�ܿ����

end;

function TWelcome.EncodeMsgMthInfo: TMsgMonthInfo;
begin

end;

procedure TWelcome.LoadDays;
var
  CalcUnit,str:string;
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  //�������
  str:=
    'select a.STOCK_DATE as STOCK_DATE,count(distinct a.GODS_ID) as GODS_COUNT,sum(CALC_AMOUNT/'+CalcUnit+') as STK_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as STK_MNY '+
    'from VIW_STOCKDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 '+
    ' and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.STOCK_DATE>:LAST_DATE '+
    'group by a.STOCK_DATE order by a.STOCK_DATE desc';
    
  dayJh.Close;
  dayJh.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  dayJh.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  dayJh.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  dayJh.ParamByName('LAST_DATE').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',Date-30));
  Factor.Open(dayJh);

  //��ǰ���
  str:= ParseSQL(Factor.iDbType,
      'select '+
      ' count(distinct c.GODS_ID) as ALLGODS_COUNT,'+  //����Ʒ������
      ' sum(case when bb.STOR_GODS_ID is null then 1 else 0 end) as GODS_COUNT,'+  //�п����Ʒ����
      ' sum(case when c.SORT_ID10 =''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'' then 1 else 0 end) as GODS_SX_COUNT,'+  //�Ƿ��ǳ���Ʒ��
      ' sum(case when c.SORT_ID11=''5D8D7AF6-2DE3-4866-85C7-925E07F66096'' then 1 else 0 end) as GODS_NEW_COUNT,'+  //�Ƿ�����Ʒ
      ' sum(case when (Round(bb.AMOUNT,3)<Round(bb.LOWER_AMOUNT,3)) and (isnull(Round(bb.LOWER_AMOUNT,3),0)>0) then 1 else 0 end) as LOWER_COUNT, '+ //���ں���������
      ' sum(AMOUNT/'+CalcUnit+') as STOR_SUM '+  //���������[��λ:��]
      ' from PUB_GOODSINFO c '+
      ' left outer join '+
      ' (select a.GODS_ID as STOR_GODS_ID,b.LOWER_AMOUNT,round(a.AMOUNT,3) as AMOUNT from STO_STORAGE a '+
      '   left join PUB_GOODS_INSHOP b on  a.TENANT_ID=b.TENANT_ID and a.SHOP_ID=b.SHOP_ID and a.GODS_ID=b.GODS_ID '+
      '  where a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and round(a.AMOUNT,3)>0) bb '+
      ' on c.GODS_ID=bb.STOR_GODS_ID '+
      ' where c.TENANT_ID=110000001 and c.COMM not in (''01'',''02'')');

  dayKc.Close;
  dayKc.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  dayKc.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  dayKc.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Factor.Open(dayKc);

  //�������
  QtDay:=FormatDatetime('YYYYMMDD',Date()-2); //ǰ��;
  YsDay:=FormatDatetime('YYYYMMDD',Date()-1); //����;
  ToDay:=FormatDatetime('YYYYMMDD',Date());   //����;
  //�����������
  str:=
    'select a.SALES_DATE as SALES_DATE,count(distinct a.GODS_ID) as SALES_GODS_COUNT,count(distinct a.SALES_ID) as SALES_BILL_COUNT,sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
    'from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 '+
    ' and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.SALES_DATE in ('+YsDay+','+ToDay+','+QtDay+') '+
    'group by a.SALES_DATE ';
  dayRs.Close;
  dayRs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  dayRs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  dayRs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Factor.Open(dayRs);
end;

procedure TWelcome.LoadMths;
var
  CalcUnit,str:string;
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  //�����������
  str:=
    'select round(a.SALES_DATE / 100) as SALES_DATE,count(*) as SAL_OAMT,count(distinct a.GODS_ID) as SAL_GAMT,'+
    'sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,'+
    '(nvl(sum(NOTAX_MONEY),0)+nvl(sum(TAX_MONEY),0)) as SALE_MNY,'+
    '(nvl(sum(NOTAX_MONEY),0)-nvl(sum(COST_MONEY),0)) as SALE_PRF,'+
    'sum(case when substring(CREA_DATE,12,2)=''00'' then CALC_AMOUNT) as T00_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''01'' then CALC_AMOUNT) as T01_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''02'' then CALC_AMOUNT) as T02_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''03'' then CALC_AMOUNT) as T03_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''04'' then CALC_AMOUNT) as T04_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''05'' then CALC_AMOUNT) as T05_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''06'' then CALC_AMOUNT) as T06_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''07'' then CALC_AMOUNT) as T07_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''08'' then CALC_AMOUNT) as T08_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''09'' then CALC_AMOUNT) as T09_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''10'' then CALC_AMOUNT) as T10_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''11'' then CALC_AMOUNT) as T11_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''12'' then CALC_AMOUNT) as T12_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''13'' then CALC_AMOUNT) as T13_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''14'' then CALC_AMOUNT) as T14_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''15'' then CALC_AMOUNT) as T15_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''16'' then CALC_AMOUNT) as T16_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''17'' then CALC_AMOUNT) as T17_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''18'' then CALC_AMOUNT) as T18_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''19'' then CALC_AMOUNT) as T19_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''20'' then CALC_AMOUNT) as T20_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''21'' then CALC_AMOUNT) as T21_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''22'' then CALC_AMOUNT) as T22_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''23'' then CALC_AMOUNT) as T23_AMT '+
    'from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 '+
    ' and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.SALES_DATE>=:BEGIN_DATE and a.SALES_DATE<=:END_DATE '+
    'group by round(a.SALES_DATE / 100) ';
  MthRs.Close;
  MthRs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  MthRs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  MthRs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  MthRs.ParamByName('BEGIN_DATE').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',incMonth(fnTime.fnStrtoDate(MONTH+'01'),-1)));
  MthRs.ParamByName('END_DATE').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',incMonth(fnTime.fnStrtoDate(MONTH+'01'),1)-1));
  Factor.Open(MthRs);
end;

procedure TWelcome.SetMonth(const Value: string);
begin
  FMonth := Value;
  MthRs.Close;
end;

end.
