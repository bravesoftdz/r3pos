unit uSaleAnalyMessage;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns,
  Des, WinInet, Controls, ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase,
  Variants, ZLogFile;

  {============命名规则：
    Yesterday:  缩写：YD
    Today:      缩写：TD
    Last Month: 缩写：LM
    This Month: 缩写：TM
    Last Year : 缩写：LY  (LYTM:去年同月份，同比)
    AMT: 数量
    MNY: 金额
    PRF: 毛利
    PRF_RATE：毛利率
    Stock holding ratio:存销比 缩写:SH_Ratio
   =============}
  //天经营情况:
type
  TSaleDayMsg=Record
    YDSale_AMT: real;   //昨天销量(单位:条);
    YDSale_MNY: real;   //昨天销售额(元);
    YDSale_PRF: real;   //昨天毛利(元);
    YDSale_PRF_RATE: real;  //昨天毛利率(%);
    TDSale_AMT: real;   //今天销量(单位:条);
    TDSale_MNY: real;   //今天销售额(元);
    TDSale_PRF: real;   //今天毛利(元);
    TDSale_PRF_RATE: real;  //今天毛利率(%);
  end;

  //月份经营情况:
  TSaleMonthMsg=Record
    Month: string;      //月份
    //同上月环比:
    LMSale_AMT: real;   //上月销量(单位:条);
    LMSale_MNY: real;   //上月销售额(元);
    LMSale_PRF: real;   //上月毛(单位:条);
    LMSale_SINGLE_MNY: real;  //本月平均每条销售额(元);
    //同去年同月同比:
    LYTMSale_AMT: real;  //去年同月销量(单位:条);
    LYTMSale_MNY: real;  //去年同月销售额(元);
    LYTMSale_PRF: real;  //去年同月毛(单位:条);
    LYTMSale_SINGLE_MNY: real;  //去年同平均每条销售额(元);
    //当前月份
    TMGods_AMT: integer;  //本月经营品种数;
    TMCust_AMT: integer;  //本月消费者数;
    TMCust_MNY: real;     //本月消费者消费金额;
    TMCust_RATE: real;    //本月消费者消费占的比例;
    TMSH_RATIO: real;     //本月存销比;
    TMSale_AMT: real;     //本月销量(单位:条);
    TMSale_MNY: real;     //本月销售额(元);
    TMSale_PRF: real;     //本月毛(单位:条);
    TMSale_PRF_RATE: real;    //本月毛利率(单位:条);
    TMSale_SINGLE_MNY: real;  //本月平均每条销售额(元);

    TMSale_AMT_UP_RATE: real;  //环比销量增长;
    TMSale_PRF_UP_RATE: real;  //环比毛利增长;
    TMSale_SINGLE_MNY_UP_RATE: real;  //环比单条的值增长多少(元);

    LYTMSale_AMT_UP_RATE: real;  //同比月销量增长;
    LYTMSale_PRF_UP_RATE: real;  //同比月毛利增长;
    LYTMSale_SINGLE_MNY_UP_RATE: real;  //同比单条的值增长多少;

    TMGods_MaxGrow_AMT: string;  //销量最大前3个，多个之间用“;”间隔开;
    TMGods_MaxGrow_PRF: string;  //毛利最大前3个，多个之间用“;”间隔开;

    TMGods_MaxGrowRate_AMT: string;  //环比销量增长最快3个，多个之间用“;”间隔开;
    TMGods_MinGrowRate_AMT: string;  //环比动销最不理想3个，多个之间用“;”间隔开;
  end;

type
  TSaleAnalyMsg=class
  private
    MinMonth: string; //最小结账月份
    MaxMonth: string; //最大结账月份
    LM_BegDate: string; //上月第一天
    LM_EndDate: string; //上月最一天
    TM_BegDate: string; //本月第一天
    TM_EndDate: string; //本月最一天

    TopCount: integer;
    Qry: TZQuery;
    procedure InitalParam; //初始化参数
    procedure SetRckMonth(var vMinMonth,vMaxMonth: string);  //返回月结账月份

    function GetFactor: TdbFactory; //返回
    function GetTenantID: string; //传入企业ID
    function FormatFloatValue(InValue :real; size: integer): real;
    function GetStorage(EndDate: string): real; //本月底的库存

    function GetMaxGodsName(vType: integer; BegDate,EndDate: string): string; //销量、毛利最大的三个商品
    function GetGrowRateGodsName(vType: integer): string; //销量增长最快或最不理想前三个商品
    //月度经营分析
    function LastMonth_SaleInfo: Boolean; //上个月经营情况;
    function LastYearThisMonth_SaleInfo: Boolean; //去年当前月份经营情况;
    function ThisMonth_SaleInfo: Boolean; //当前月份经营情况;
  public
    DayMsg: TSaleDayMsg;  //每天销售消息
    MonthMsg: TSaleMonthMsg;  //月经营情况
    constructor Create;
    destructor  Destroy; override;
    procedure GetSaleDayMsg;  //返回当天销售msg
    procedure GetSaleMonthMsg(vCount: integer=3);  //返回当天销售msg
    property Factor: TdbFactory read GetFactor; //从外传入
    property Tenant_ID: string read GetTenantID;  //传入企业ID
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
  SetRckMonth(MinMonth,MaxMonth); //取结账月份期间
  //上月启始—结束日
  LM_BegDate:=FormatDatetime('YYYYMM',IncMonth(Date(),-2))+'01'; //上月开始日期;
  LM_EndDate:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(Date(),-2))); //上月最后一天;
  //本月启始—结束日
  TM_BegDate:=FormatDatetime('YYYYMM',IncMonth(Date(),-1))+'01';  //本月开始日期;
  TM_EndDate:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(Date(),-1)));  //本月结束日期（今天）;

  //初始化日经营参数
  DayMsg.YDSale_AMT:=0;   //昨天销量(单位:条);
  DayMsg.YDSale_MNY:=0;   //昨天销售额(元);
  DayMsg.YDSale_PRF:=0;   //昨天毛利(元);
  DayMsg.YDSale_PRF_RATE:=0;  //昨天毛利率(%);
  DayMsg.TDSale_AMT:=0;   //今天销量(单位:条);
  DayMsg.TDSale_MNY:=0;   //今天销售额(元);
  DayMsg.TDSale_PRF:=0;   //今天毛利(元);
  DayMsg.TDSale_PRF_RATE:=0;  //今天毛利率(%);

  //初始化月经营参数
  MonthMsg.Month:=FormatDatetime('YYYYMM',IncMonth(Date(),-1));
  MonthMsg.LMSale_AMT:=0;   //上月销量(单位:条);
  MonthMsg.LMSale_MNY:=0;   //上月销售额(元);
  MonthMsg.LMSale_PRF:=0;   //上月毛(单位:条);
  MonthMsg.LMSale_SINGLE_MNY:=0; //上月平均每条销售额(元);

  //同去年同月同比:
  MonthMsg.LYTMSale_AMT:=0;   //去年同月销量(单位:条);
  MonthMsg.LYTMSale_MNY:=0;   //去年同月销售额(元);
  MonthMsg.LYTMSale_PRF:=0;   //去年同月毛(单位:条);
  MonthMsg.LYTMSale_SINGLE_MNY:=0;  //去年同平均每条销售额(元);

  MonthMsg.TMGods_AMT:=0;  //本月经营品种数;
  MonthMsg.TMCust_AMT:=0;  //本月消费者数;
  MonthMsg.TMCust_MNY:=0;  //本月消费者消费金额;
  MonthMsg.TMCust_RATE:=0; //本月消费者消费占的比例;
  MonthMsg.TMSH_RATIO:=0;  //本月存销比;
  MonthMsg.TMSale_AMT:=0;  //本月销量(单位:条);
  MonthMsg.TMSale_MNY:=0;  //本月销售额(元);
  MonthMsg.TMSale_PRF:=0;  //本月毛(单位:条);
  MonthMsg.TMSale_PRF_RATE:=0;    //本月毛利率(单位:条);
  MonthMsg.TMSale_SINGLE_MNY:=0;  //单条销售额

  MonthMsg.TMSale_AMT_UP_RATE:=0; //销量增长率
  MonthMsg.TMSale_PRF_UP_RATE:=0; //销售额增长率
  MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=0;  //单条的值增长多少(元);
  MonthMsg.LYTMSale_AMT_UP_RATE:=0;  //同比月销量增长;
  MonthMsg.LYTMSale_PRF_UP_RATE:=0;  //同比月毛利增长;
  MonthMsg.LYTMSale_SINGLE_MNY_UP_RATE:=0;  //同比单条的值增长多少(元);

  MonthMsg.TMGods_MaxGrow_PRF:='';  //环比毛利增长最快3个，多个之间用“;”间隔开;
  MonthMsg.TMGods_MaxGrow_AMT:='';  //环比销量增长最快3个，多个之间用“;”间隔开;
  MonthMsg.TMGods_MaxGrowRate_AMT:='';  //环比毛利增长最快3个，多个之间用“;”间隔开;
  MonthMsg.TMGods_MinGrowRate_AMT:='';  //环比销量增长最快3个，多个之间用“;”间隔开;
end;

procedure TSaleAnalyMsg.GetSaleDayMsg;
var
  YsDay: string; //昨天；
  ToDay: string; //今天;
  str,CalcUnit: string;
  NOTAX_MONEY: Real;
begin
  try
    CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
    YsDay:=FormatDatetime('YYYYMMDD',Date()-1); //昨天销售日期;
    ToDay:=FormatDatetime('YYYYMMDD',Date()); //本月结束日期（今天）;
    //昨天销售情况
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
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //不含税金额 
      if NOTAX_MONEY<>0 then //毛利 除 不含税金额
        DayMsg.YDSale_PRF_RATE:=FormatFloatValue((DayMsg.YDSale_PRF*100)/NOTAX_MONEY,2);
    end;
    //if (DayMsg.YDSale_AMT=0) and (DayMsg.YDSale_MNY=0) then Exit;  //昨天没有经营数据则退;
    
    //今天销售情况
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
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //不含税金额 
      if NOTAX_MONEY>0 then
        DayMsg.TDSale_PRF_RATE:=FormatFloatValue((DayMsg.TDSale_PRF*100)/NOTAX_MONEY,2);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('计算日经营情况出错,错误:'+E.message);
    end;
  end;
end;

procedure TSaleAnalyMsg.GetSaleMonthMsg(vCount: integer);
var
  CurMonth: string; //当前月份
  BegDate: string; //开始日期;
  EndDate: string; //结束日期;
  CurDate: TDate;
  str,CalcUnit: string;
  StorageValue,NOTAX_MONEY: real; //库存数量
begin
  TopCount:=vCount;
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';

  //上月份经营情况(环比):
  LastMonth_SaleInfo;
  //去年本月份经营情况(同比):
  LastYearThisMonth_SaleInfo;
  //当前月份经营情况:
  ThisMonth_SaleInfo;

  try 
    //对比经营情况(同上月环比)：
    if MonthMsg.LMSale_AMT<>0 then
      MonthMsg.TMSale_AMT_UP_RATE:=((MonthMsg.TMSale_AMT-MonthMsg.LMSale_AMT)*100)/MonthMsg.LMSale_AMT;  //本月环比销量增长;
    if MonthMsg.LMSale_PRF<>0 then
      MonthMsg.TMSale_PRF_UP_RATE:=((MonthMsg.TMSale_PRF-MonthMsg.LMSale_PRF)*100)/MonthMsg.LMSale_PRF;  //本月环比毛利增长;
    if MonthMsg.LMSale_SINGLE_MNY<>0 then
      MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=((MonthMsg.TMSale_SINGLE_MNY-MonthMsg.LMSale_SINGLE_MNY)*100)/MonthMsg.LMSale_SINGLE_MNY;   //本月环比单条增长；

    //对比经营情况(同去年月同比)：
    if MonthMsg.LYTMSale_AMT<>0 then
      MonthMsg.LYTMSale_AMT_UP_RATE:=((MonthMsg.TMSale_AMT-MonthMsg.LYTMSale_AMT)*100)/MonthMsg.LYTMSale_AMT;  //本月环比销量增长;
    if MonthMsg.LYTMSale_PRF<>0 then
      MonthMsg.LYTMSale_PRF_UP_RATE:=((MonthMsg.LYTMSale_PRF-MonthMsg.LYTMSale_PRF)*100)/MonthMsg.LYTMSale_PRF;  //本月环比毛利增长;
    if MonthMsg.LYTMSale_SINGLE_MNY<>0 then
      MonthMsg.LYTMSale_SINGLE_MNY_UP_RATE:=((MonthMsg.LYTMSale_SINGLE_MNY-MonthMsg.LYTMSale_SINGLE_MNY)*100)/MonthMsg.LYTMSale_SINGLE_MNY;   //本月环比单条增长；

    //本月份经营销量和毛利排在前三位的商品:
    MonthMsg.TMGods_MaxGrow_AMT:=GetMaxGodsName(1,TM_BegDate,TM_EndDate);  //本月销量前三位
    MonthMsg.TMGods_MaxGrow_PRF:=GetMaxGodsName(2,TM_BegDate,TM_EndDate);  //本月毛利前三位
    //环比销量排前三位和后三位的商品:
    MonthMsg.TMGods_MaxGrowRate_AMT:=GetGrowRateGodsName(1);  //环比销量最大的前三位
    MonthMsg.TMGods_MinGrowRate_AMT:=GetGrowRateGodsName(2);  //环比销量最不理想的前三位

    StorageValue:=GetStorage(TM_EndDate);                         //月底总库
    if MonthMsg.TMSale_AMT<>0 then
      MonthMsg.TMSH_RATIO:=FormatFloatValue(StorageValue/MonthMsg.TMSale_AMT,5); //存销比
  except
    on E:Exception do
    begin
      Raise Exception.Create('计算月经营分析(环比、同比)出错,错误:'+E.message);
    end;
  end;
end;

function TSaleAnalyMsg.GetFactor: TdbFactory; //返回
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
  result:=CurValue/vSize;  //数量 
end;

//销量、毛利最大的三个商品
function TSaleAnalyMsg.GetMaxGodsName(vType: integer; BegDate,EndDate: string): string;
var
  str,BaseTab,ReStr: string;
  rs: TZQuery;
begin
  result:='';
  ReStr:='';
  if TopCount<=0 then TopCount:=3;  //默认取前三个

  case vType of
   1: //销量
    begin
      BaseTab:=
        'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,VIW_GOODSINFO b '+
        ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' and b.RELATION_ID=1000006 '+
        ' group by GODS_NAME';
      case Factor.iDbType of
       0,2,3:
          str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SAL_AMT desc'; //降序
       1: str:='select GODS_NAME From ('+BaseTab+')tp where rownum<='+InttoStr(TopCount)+' order by SAL_AMT desc';
       4: str:='select GODS_NAME from (select * From ('+BaseTab+')tmp order by SAL_AMT desc)tp fetch first '+InttoStr(TopCount)+' rows only ';
       5: str:='select GODS_NAME from ('+BaseTab+')tmp order by SAL_AMT desc limit '+InttoStr(TopCount)+'';
      end;
    end;
   2: //毛利
    begin
      BaseTab:=
        'select GODS_NAME,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,VIW_GOODSINFO b '+
        ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' and b.RELATION_ID=1000006 '+
        ' group by GODS_NAME';
      case Factor.iDbType of
       0,2,3:
          str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SALE_PRF desc'; //降序
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
          ReStr:=ReStr+'、'+rs.fieldbyName('GODS_NAME').AsString;
        rs.Next;
      end; 
    end;
  finally
    rs.Free;
  end;
  result:=ReStr;
  if result='' then result:='无';
end;

//动销最小的三个商品
function TSaleAnalyMsg.GetGrowRateGodsName(vType: integer): string;
var
  LMTab,TMTab,BaseTab,OrderBy,Str,ReStr: string;
  rs: TZQuery;
begin
  if TopCount<=0 then TopCount:=3;  //默认取前三个
  //上个月销售数量:
  LMTab:=
    'select a.GODS_ID as GODS_ID,b.GODS_NAME as GODS_NAME,sum(a.CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,VIW_GOODSINFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+LM_BegDate+' and a.SALES_DATE<='+LM_EndDate+' and b.RELATION_ID=1000006 '+
    ' group by a.GODS_ID,b.GODS_NAME';

  //本月销售数量:
  TMTab:=
    'select a.GODS_ID as GODS_ID,sum(a.CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,VIW_GOODSINFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+TM_BegDate+' and a.SALES_DATE<='+TM_EndDate+' and b.RELATION_ID=1000006 '+
    ' group by a.GODS_ID';
  //关联数据 
  BaseTab:='select LM.GODS_NAME,(case when LM.SAL_AMT<>0 then TM.SAL_AMT/LM.SAL_AMT else 0 end) as GrowRate from ('+LMTab+')LM,('+TMTab+')TM where LM.GODS_ID=TM.GODS_ID ';

  case vType of
   1: OrderBy:=' order by GrowRate desc '; //环比销量增长最快:3个
   2: OrderBy:=' order by GrowRate asc ';
  end;
  case Factor.iDbType of
   0,2,3:
      str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp '+OrderBy; //降序
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
          ReStr:=ReStr+'、'+rs.fieldbyName('GODS_NAME').AsString;
        rs.Next; 
      end;
    end;
  finally
    rs.Free;
  end;
  result:=ReStr;
  if result='' then result:='无';
end;

//本月底的库存
function TSaleAnalyMsg.GetStorage(EndDate: string): real;
var
  rs:TZQuery;
  UnitCalc: string;
  Str,MaxReckDate,BegDate: string;
begin
  result:=0.0;
  MaxReckDate:='';
  BegDate:=EndDate; //查询最大日期
  UnitCalc:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  rs := TZQuery.Create(nil);
  try
    Str:='select Max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID='+TENANT_ID;
    rs.Close;
    rs.SQL.Text := ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if rs.Active then MaxReckDate:=trim(rs.fieldbyName('CREA_DATE').AsString);

    if MaxReckDate='' then //未结账全部走视图:
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
      if MaxReckDate>=BegDate then  //已结账，全部走台账表
      begin
        Str:='select sum(A.BAL_AMT*1.0/'+UnitCalc+') as BAL_AMT from RCK_GOODS_DAYS A,VIW_GOODSINFO D '+
             ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+BegDate+' and D.RELATION_ID=1000006 ';
      end else //走两部分联合[union]
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
  CurMonth: string; //当前月份
  BegDate: string; //开始日期;
  EndDate: string; //结束日期;
  CurDate: TDate;
  str,CalcUnit: string;
begin
  result:=False;
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  try
    //上个月经营情况：
    CurMonth:=FormatDatetime('YYYYMM',IncMonth(Date(),-2));
    if CurMonth>MaxMonth then //当前月份 大于 最大结账月：查询视图
    begin
      str:=
        'select '+
        ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+      //销售数量[条]
        '(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,'+  //销售金额
        '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //销售毛利
        'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and '+
        ' a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+LM_BegDate+' and a.SALES_DATE<='+LM_EndDate+' ';
    end else
    begin  //销售数量[条], 销售金额, 销售毛利
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
      Raise Exception.Create('计算（上个月份）月经营分析出错,错误:'+E.message);
    end;
  end;
end;

function TSaleAnalyMsg.LastYearThisMonth_SaleInfo: Boolean;
var
  CurMonth: string; //当前月份
  BegDate: string; //开始日期;
  EndDate: string; //结束日期;
  CurDate: TDate;
  str,CalcUnit: string;
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  try
    //去年本月经营情况：
    CurDate:=IncYear(IncMonth(Date(),-1),-1) ;//去年上月的今天
    CurMonth:=FormatDatetime('YYYYMM',CurDate);
    if CurMonth>MaxMonth then //当前月份 大于 最大结账月：查询视图
    begin
      BegDate:=FormatDatetime('YYYYMM',CurDate)+'01'; //上月开始日期;
      EndDate:=FnTime.GetLastDate(FormatDatetime('YYYYMM',CurDate)); //上月最后一天;
      str:=
        'select '+
        ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+      //销售数量[条]
        '(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,'+  //销售金额
        '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //销售毛利
        'from VIW_SALESDATA a,VIW_GOODSINFO b  where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and '+
        ' a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' ';
    end else
    begin  //销售数量[条], 销售金额, 销售毛利
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
      Raise Exception.Create('计算（去年本月份）月经营分析出错,错误:'+E.message);
    end;
  end;
end;

function TSaleAnalyMsg.ThisMonth_SaleInfo: Boolean;
var
  CurMonth: string; //当前月份
  CurDate: TDate;
  str,CalcUnit: string;
  StorageValue,NOTAX_MONEY: real; //库存数量
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  try
    //本月经营情况：
    Str:=
      'select TENANT_ID,CLIENT_ID,GODS_ID,CALC_AMOUNT,NOTAX_MONEY,'+
      'cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3)) as SALE_MNY,'+
      'cast(isnull(NOTAX_MONEY,0)-isnull(COST_MONEY,0) as decimal(18,3)) as SALE_PRF,'+
      '(case when isnull(CLIENT_ID,'''')<>'''' then cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3)) else 0 end) as CUST_MNY '+
      ' from VIW_SALESDATA where TENANT_ID='+Tenant_ID+' and SALES_DATE>='+TM_BegDate+' and SALES_DATE<='+TM_EndDate+' ';

    str:=
      'select '+
      ' count(distinct a.GODS_ID) as GODS_COUNT,'+   //经营商品数
      ' count(distinct a.CLIENT_ID) as CUST_COUNT,'+  //固定消费者数
      ' sum(CUST_MNY) as CUST_MNY,'+  //固定消费金额
      ' sum(NOTAX_MONEY) as NOTAX_MONEY,'+  //不含税金额
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //销售数量[条]
      ' sum(SALE_MNY) as SALE_MNY,'+  //销售金额
      ' sum(SALE_PRF) as SALE_PRF '+ //销售毛利
      'from ('+Str+') a,VIW_GOODSINFO b '+
      ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and b.TENANT_ID='+Tenant_ID;

    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      MonthMsg.TMGods_AMT:=Qry.fieldbyName('GODS_COUNT').AsInteger; //本月经营品项数
      MonthMsg.TMCust_AMT:=Qry.fieldbyName('CUST_COUNT').AsInteger;                   //本月固定消费者
      MonthMsg.TMCust_MNY:=FormatFloatValue(Qry.fieldbyName('CUST_MNY').AsFloat,2);   //本月固定消费金额
      MonthMsg.TMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);    //本月销售量
      MonthMsg.TMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);   //本月销售额
      MonthMsg.TMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);   //本月销售毛利额
      NOTAX_MONEY:=FormatFloatValue(Qry.fieldbyName('NOTAX_MONEY').AsFloat,2);        //本月不包含税金额
      if NOTAX_MONEY>0 then  //计算毛利率:
        MonthMsg.TMSale_PRF_RATE:=FormatFloatValue((MonthMsg.TMSale_PRF*100)/NOTAX_MONEY,2);
      if MonthMsg.TMSale_MNY<>0 then  //计算固定消费者占的比例:
        MonthMsg.TMCust_RATE:=FormatFloatValue((MonthMsg.TMCust_MNY*100)/MonthMsg.TMSale_MNY,2);
      if MonthMsg.TMSale_AMT<>0 then  //计算本月单条值:
        MonthMsg.TMSale_SINGLE_MNY:=FormatFloatValue(MonthMsg.TMSale_MNY/MonthMsg.TMSale_AMT,2);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('计算（本月份）月经营分析出错,错误:'+E.message);
    end;
  end;
end;

end.
