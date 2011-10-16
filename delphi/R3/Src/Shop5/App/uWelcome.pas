unit uWelcome;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns,
  Des, WinInet, Controls, ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase,
  Variants, ZLogFile,Dialogs;
  
type

  TMsgDayInfo=Record
    YDSaleGods_Count: integer; //昨天销售品种(单位:个);
    YDSaleBill_Count: integer; //昨天销售单据比数(单位:笔);
    YDSale_AMT: real;   //昨天销量(单位:条);
    YDSale_MNY: real;   //昨天销售额(元);
    YDSale_PRF: real;   //昨天毛利(元);
    YDSale_PRF_RATE: real;  //昨天毛利率(%);

    TDSaleGods_Count: integer; //今天销售品种(单位:个);
    TDSaleBill_Count: integer; //今天销售单据比数(单位:笔);
    TDSale_Count: integer;  //销售品种(单位:个);
    TDSale_AMT: real;   //今天销量(单位:条);
    TDSale_MNY: real;   //今天销售额(元);
    TDSale_PRF: real;   //今天毛利(元);
    TDSale_PRF_RATE: real;  //今天毛利率(%);
    //与前天对比:
    QTSaleGods_Count: integer; //今天销售品种(单位:个);
    QTSaleBill_Count: integer; //今天销售单据比数(单位:笔);
    QTSale_Count: integer;  //销售品种(单位:个);
    QTSale_AMT: real;   //今天销量(单位:条);
    QTSale_MNY: real;   //今天销售额(元);
    QTSale_PRF: real;   //今天毛利(元);
    QTSale_PRF_RATE: real;  //今天毛利率(%);

    TDStockGods_Count: integer; //本次进货商品数
    TDStock_AMT: real;  //本次进货条数
    TDStock_MNY: real;  //本次进货金额

    SCStockGods_Count: integer; //本次进货商品数
    SCStock_AMT: real;  //本次进货条数
    SCStock_MNY: real;  //本次进货金额

    TMGods_All_Count:integer;  //本月经营总品种数;
    TMGods_Count:integer;      //本月有库存品种数;
    TMGods_SX_Count:integer;   //本月畅销品种数;
    TMGods_NEW_Count:integer;   //本月畅销品种数;
    TMAllStor_AMT:real;     //商品总库存数
    TMLowStor_Count:integer;   //低于合理库存商品数
  end;

  //月份经营情况:
  TMsgMonthInfo=Record
    //同上月环比:
    LMSale_AMT: real;   //上月销量(单位:条);
    LMSale_MNY: real;   //上月销售额(元);
    LMSale_PRF: real;   //上月毛(单位:条);
    LMSale_SINGLE_MNY: real;  //本月平均每条销售额(元);

    //当前月份
    TMStock_AMT: real;    //本月购进(单位:条);
    TMStock_MNY: real; //本月购进(单条值);
    
    TMSale_AMT: real;     //本月销量(单位:条);
    TMSale_MNY: real;     //本月销售额(元);
    TMSale_PRF: real;     //本月毛(单位:条);
    TMSale_PRF_RATE: real;    //本月毛理率;
    TMSale_SINGLE_MNY: real;  //本月平均每条销售额(元);
    TMSale_AMT_UP_RATE: real;    //本月数量增长;
    TMSale_PRF_UP_RATE: real;    //本月毛利率增长;
    TMSale_SINGLE_MNY_UP_RATE: real;   //本月单条金额增长率;
    TMNEWGODS_COUNT: integer;    //本月新品
    TMNEWSTOR_COUNT: integer;    //本月经营新品

    TMGods_MaxGrow_AMT: string;  //销量最大前3个，多个之间用“;”间隔开;
    TMGods_MaxGrow_PRF: string;  //本月毛利最大前3个，多个之间用“;”间隔开;
    TMGods_SY_MaxGrow_PRF: string;  //上月毛利最大前3个，多个之间用“;”间隔开;
    TMGods_MaxGrowRate_AMT: string;  //环比销量增长最快3个，多个之间用“;”间隔开;
    
    //2011.10.12 消费者(会员)情况:
    TMCust_Count: integer;     //总的消费者个数;
    TMCust_HG_Count: integer;  //高档烟草消费者个数;
    TMCust_NEW_Count: integer; //本月新建消费者个数;
    TMCust_AMT: real;          //消费者消费数量;
    TMCust_MNY: real;          //消费者消费金额;
    TMCust_AMT_RATE: real;     //本月消费者消费数量占的比例;
    TMCust_MNY_RATE: real;     //本月消费者消费金额占的比例;
    TMCust_MAX_TIME:string;    //最旺销时段
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
  //昨天销售情况:
  if dayRs.Locate('SALES_DATE',strtoint(YsDay),[]) then
  begin
    result.YDSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.YDSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.YDSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.YDSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.YDSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //毛利 除 不含税金额
       result.YDSale_PRF_RATE:=(result.YDSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;
  //今天销售情况:
  if dayRs.Locate('SALES_DATE',strtoint(ToDay),[]) then
  begin
    result.TDSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.TDSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.TDSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.TDSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.TDSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //毛利 除 不含税金额
       result.TDSale_PRF_RATE:=(result.TDSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;
  //前天销售情况:
  if dayRs.Locate('SALES_DATE',strtoint(QTDay),[]) then
  begin
    result.QTSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.QTSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.QTSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.QTSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.QTSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //毛利 除 不含税金额
       result.QTSale_PRF_RATE:=(result.QTSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;
  //进货情况
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
     
  //当前库存
  result.TMGods_All_Count:=dayKc.FieldbyName('ALLGODS_COUNT').AsInteger;   //本月经营总品种数;
  result.TMGods_Count:=dayKc.FieldbyName('GODS_COUNT').AsInteger;       //本月有库存品种数;
  result.TMGods_SX_Count:=dayKc.FieldbyName('GODS_SX_COUNT').AsInteger; //本月畅销品种数
  result.TMGods_NEW_Count:=dayKc.FieldbyName('GODS_NEW_COUNT').AsInteger; //本月新品种数
  result.TMLowStor_Count:=dayKc.FieldbyName('LOWER_COUNT').AsInteger; //低于合理库存商品数
  result.TMAllStor_AMT:=dayKc.FieldbyName('STOR_SUM').AsFloat;        //商品总库存数

end;

function TWelcome.EncodeMsgMthInfo: TMsgMonthInfo;
begin

end;

procedure TWelcome.LoadDays;
var
  CalcUnit,str:string;
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  //进货情况
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

  //当前库存
  str:= ParseSQL(Factor.iDbType,
      'select '+
      ' count(distinct c.GODS_ID) as ALLGODS_COUNT,'+  //有商品档案数
      ' sum(case when bb.STOR_GODS_ID is null then 1 else 0 end) as GODS_COUNT,'+  //有库存商品总数
      ' sum(case when c.SORT_ID10 =''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'' then 1 else 0 end) as GODS_SX_COUNT,'+  //是否是畅销品牌
      ' sum(case when c.SORT_ID11=''5D8D7AF6-2DE3-4866-85C7-925E07F66096'' then 1 else 0 end) as GODS_NEW_COUNT,'+  //是否是新品
      ' sum(case when (Round(bb.AMOUNT,3)<Round(bb.LOWER_AMOUNT,3)) and (isnull(Round(bb.LOWER_AMOUNT,3),0)>0) then 1 else 0 end) as LOWER_COUNT, '+ //低于合理库存数量
      ' sum(AMOUNT/'+CalcUnit+') as STOR_SUM '+  //库存总数量[单位:条]
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

  //销售情况
  QtDay:=FormatDatetime('YYYYMMDD',Date()-2); //前天;
  YsDay:=FormatDatetime('YYYYMMDD',Date()-1); //昨天;
  ToDay:=FormatDatetime('YYYYMMDD',Date());   //今天;
  //昨天销售情况
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
  //昨天销售情况
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
