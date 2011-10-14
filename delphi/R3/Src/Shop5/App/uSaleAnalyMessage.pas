unit uSaleAnalyMessage;

interface

uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns,
  Des, WinInet, Controls, ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase,
  Variants, ZLogFile,Dialogs;

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

    TDStock_GODS_Count: integer;
    TDStock_AMT: real;
    TDStock_MNY: real;
    TDStock_Single_MNY: real;  //今天毛利率(%);

    TDStock_AMT_RATE: real;
    TDStock_MNY_Grow: real;
    TDStock_Single_MNY_Grow: real;  //今天毛利率(%);
  end;

  //月份经营情况:
  TSaleMonthMsg=Record
    //Month: string;      //月份
    //同上月环比:
    LMSale_AMT: real;   //上月销量(单位:条);
    LMSale_MNY: real;   //上月销售额(元);
    LMSale_PRF: real;   //上月毛(单位:条);
    LMSale_SINGLE_MNY: real;  //本月平均每条销售额(元);

    //当前月份
    TMStock_AMT: real;    //本月购进(单位:条);
    TMStock_SINGLE_MNY: real; //本月购进(单条值);
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
    TMGods_MaxGrow_PRF: string;  //毛利最大前3个，多个之间用“;”间隔开;
    TMGods_MaxGrowRate_AMT: string;  //环比销量增长最快3个，多个之间用“;”间隔开;
    
    //2011.10.12 库存情况:
    TMGods_Count: integer;     //本月经营品种数;
    TMGods_SX_Count: integer;     //本月经营品种数;
    TMAllStor_AMT: real;       //商品总库存数
    TMLowStor_Count: integer;  //低于合理库存商品数

    //2011.10.12 消费者(会员)情况:
    TMCust_Count: integer;     //总的消费者个数;
    TMCust_HG_Count: integer;  //高档烟草消费者个数;
    TMCust_NEW_Count: integer; //本月新建消费者个数;
    TMCust_AMT: real;          //消费者消费数量;
    TMCust_MNY: real;          //消费者消费金额;
    TMCust_AMT_RATE: real;     //本月消费者消费数量占的比例;
    TMCust_MNY_RATE: real;     //本月消费者消费金额占的比例;
  end;


type
  TSaleAnalyMsg=class
  private
    FCalcStor: Boolean;
    FCurMonth: string; //当前月份
    MaxRckDay: string; //最大结账日
    MinMonth: string;  //最小结账月份
    MaxMonth: string;  //最大结账月份
    LM_BegDate: string; //上月第一天
    LM_EndDate: string; //上月最一天
    TM_BegDate: string; //本月第一天
    TM_EndDate: string; //本月最一天

    TopCount: integer;
    Qry: TZQuery;
    procedure InitalParam; //初始化参数
    procedure InitalMonthMsg;  //初始化参数
    procedure SetRckMonth(var vMinMonth,vMaxMonth,vMaxRckDay: string);  //返回月结账月份

    function GetFactor: TdbFactory; //返回
    function GetTenantID: string; //传入企业ID
    function FormatFloatValue(InValue :real; size: integer): real;

    function GetMaxGodsName(vType: integer; BegDate,EndDate: string): string; //销量、毛利最大的三个商品
    function GetGrowRateGodsName: string; //销量增长最快或最不理想前三个商品

    //月度经营分析
    function LastMonth_SaleInfo: Boolean; //上个月经营情况;
    function ThisMonth_SaleInfo: Boolean; //当前月份经营情况;
    function GetCustomerInfo: Boolean; //返回会员消息
    function GetStorageInfo: Boolean;  //返回库存情况
    function ThisMonth_StockInfo: Boolean;  //本月购进数量
    function ThisMonth_NewGodsInfo: Boolean;  //本月新品
    procedure SetCurMonth(InValue: string);
    procedure GetStockDayMsg;  //返回当天销售msg
  public
    DayMsg: TSaleDayMsg;   //每天销售消息
    MonthMsg: TSaleMonthMsg;  //月经营情况
    constructor Create;
    destructor Destroy; override;
    procedure GetSaleDayMsg;  //返回当天销售msg
    procedure GetSaleMonthMsg(vCount: integer=3);  //返回当天销售msg
    property Factor: TdbFactory read GetFactor;    //从外传入
    property Tenant_ID: string read GetTenantID;   //传入企业ID
    property CurMonth: string read FCurMonth write SetCurMonth;    //显示月份
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
  SetRckMonth(MinMonth,MaxMonth,MaxRckDay); //取结账月份期间
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

  DayMsg.TDStock_GODS_Count:=0;
  DayMsg.TDStock_AMT:=0;
  DayMsg.TDStock_MNY:=0;
  DayMsg.TDStock_Single_MNY:=0;  //今天毛利率(%);

  DayMsg.TDStock_AMT_RATE:=0;
  DayMsg.TDStock_MNY_Grow:=0;
  DayMsg.TDStock_Single_MNY_Grow:=0;  //今天毛利率(%);
  //初始化月经营参数
  FCurMonth:=FormatDatetime('YYYYMM',IncMonth(Date(),-1));;

  //初始化月参数
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
      vMaxRckDay:=Copy(vMaxRckDay,1,4)+Copy(vMaxRckDay,6,2)+Copy(vMaxRckDay,9,2); //返回日期格式(8位)
    end;
  finally
    rs.Free;
  end;
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
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //不含税金额
      if NOTAX_MONEY<>0 then //毛利 除 不含税金额
        DayMsg.YDSale_PRF_RATE:=FormatFloatValue((DayMsg.YDSale_PRF*100)/NOTAX_MONEY,2);
    end;

    if Qry.Locate('SALES_DATE',ToDay,[]) then
    begin
      DayMsg.TDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      DayMsg.TDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      DayMsg.TDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //不含税金额 
      if NOTAX_MONEY>0 then
        DayMsg.TDSale_PRF_RATE:=FormatFloatValue((DayMsg.TDSale_PRF*100)/NOTAX_MONEY,2);
    end;
    //计算当天
    GetStockDayMsg;
    //返回库存情况
    GetStorageInfo;
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
  str: string;
  StorageValue,NOTAX_MONEY: real; //库存数量
begin
  TopCount:=vCount;
  //初始化月参数
  InitalMonthMsg;

  frmLogo.ShowTitle := '正在计算上月份经营... ';
  frmLogo.Update;  //上月份经营情况(环比):
  LastMonth_SaleInfo;

  frmLogo.ShowTitle := '正在计算本月份经营... ';
  frmLogo.Update;  //当前月份经营情况:
  ThisMonth_SaleInfo;

  frmLogo.ShowTitle := '正在计算本月购进... ';
  frmLogo.Update;  //当月的购进:
  ThisMonth_StockInfo;

  frmLogo.ShowTitle := '正在计算本月库存... ';
  frmLogo.Update;  //返回库存情况
  GetStorageInfo;

  frmLogo.ShowTitle := '正在计算本月新品... ';
  frmLogo.Update;  //本月新品
  ThisMonth_NewGodsInfo;

  frmLogo.ShowTitle := '正在计算本月消费者消费情况... ';
  frmLogo.Update;  //消费者消费情况
  GetCustomerInfo;

  try 
    //对比经营情况(同上月环比)：
    if MonthMsg.LMSale_AMT<>0 then
      MonthMsg.TMSale_AMT_UP_RATE:=FormatFloatValue((MonthMsg.TMSale_AMT-MonthMsg.LMSale_AMT)*100.0/MonthMsg.LMSale_AMT,2);  //本月环比销量增长;
    if MonthMsg.LMSale_PRF<>0 then
      MonthMsg.TMSale_PRF_UP_RATE:=FormatFloatValue((MonthMsg.TMSale_PRF-MonthMsg.LMSale_PRF)*100.0/MonthMsg.LMSale_PRF,2);   //本月环比毛利增长;
    if MonthMsg.LMSale_SINGLE_MNY<>0 then
      MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=FormatFloatValue((MonthMsg.TMSale_SINGLE_MNY-MonthMsg.LMSale_SINGLE_MNY)*100.0/MonthMsg.LMSale_SINGLE_MNY,2);  //本月环比单条增长；

    //上月份若没有数据（增长率默认：100）
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


    //计算会员销售占比例：
    if MonthMsg.TMSale_AMT<>0 then
      MonthMsg.TMCust_AMT_RATE:=FormatFloatValue(MonthMsg.TMCust_AMT*100.0/MonthMsg.TMSale_AMT,2);
    if MonthMsg.TMSale_MNY<>0 then
      MonthMsg.TMCust_MNY_RATE:=FormatFloatValue(MonthMsg.TMCust_MNY*100.0/MonthMsg.TMSale_MNY,2);
 
    frmLogo.ShowTitle := '正在计算商品增长排名... ';
    //本月份经营销量和毛利排在前三位的商品，环比销量排前三位:
    MonthMsg.TMGods_MaxGrow_AMT:=GetMaxGodsName(1,TM_BegDate,TM_EndDate);  //本月销量前三位
    MonthMsg.TMGods_MaxGrow_PRF:=GetMaxGodsName(2,TM_BegDate,TM_EndDate);  //本月毛利前三位
    MonthMsg.TMGods_MaxGrowRate_AMT:=GetGrowRateGodsName;  //环比销量增长最快的前三位
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
        'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,PUB_GOODSINFO b '+
        ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+
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
        'select GODS_NAME,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,PUB_GOODSINFO b '+
        ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+
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
function TSaleAnalyMsg.GetGrowRateGodsName: string;
var
  LMTab,TMTab,BaseTab,OrderBy,Str,ReStr: string;
  rs: TZQuery;
begin
  if TopCount<=0 then TopCount:=3;  //默认取前三个
  //上个月销售数量:
  BaseTab:=
    'select b.GODS_NAME as GODS_NAME,'+
    ' cast(sum(case when a.SALES_DATE>='+TM_BegDate+' and a.SALES_DATE<='+TM_EndDate+' then a.CALC_AMOUNT else 0 end) as decimal(18,3))as TM_SAL_AMT,'+
    ' cast(sum(case when a.SALES_DATE>='+LM_BegDate+' and a.SALES_DATE<='+LM_EndDate+' then a.CALC_AMOUNT else 0 end) as decimal(18,3))as LM_SAL_AMT '+
    ' from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+
    ' and a.SALES_DATE>='+LM_BegDate+' and a.SALES_DATE<='+TM_EndDate+' group by b.GODS_NAME';

  case Factor.iDbType of
   0,2,3:
      str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp where LM_SAL_AMT<>0 order by (TM_SAL_AMT/LM_SAL_AMT) desc '; //降序
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
        'from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and '+
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
    str:=
      'select '+
      ' sum(case when isnull(CLIENT_ID,'''')<>'''' then cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3)) else 0 end) as CUST_MNY,'+  //固定消费金额
      ' sum(NOTAX_MONEY) as NOTAX_MONEY,'+  //不含税金额
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //销售数量[条]
      ' sum(cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3))) as SALE_MNY,'+  //销售金额
      ' sum(cast(isnull(NOTAX_MONEY,0)-isnull(COST_MONEY,0) as decimal(18,3))) as SALE_PRF '+ //销售毛利
      'from VIW_SALESDATA a,PUB_GOODSINFO b '+
      ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+
      ' and a.SALES_DATE>='+TM_BegDate+' and a.SALES_DATE<='+TM_EndDate+' ';

    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      MonthMsg.TMCust_MNY:=FormatFloatValue(Qry.fieldbyName('CUST_MNY').AsFloat,2);   //本月固定消费金额
      MonthMsg.TMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);    //本月销售量
      MonthMsg.TMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);   //本月销售额
      MonthMsg.TMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);   //本月销售毛利额
      NOTAX_MONEY:=FormatFloatValue(Qry.fieldbyName('NOTAX_MONEY').AsFloat,2);        //本月不包含税金额
      if MonthMsg.TMSale_AMT<>0 then  //计算本月单条值:
        MonthMsg.TMSale_SINGLE_MNY:=FormatFloatValue(MonthMsg.TMSale_MNY/MonthMsg.TMSale_AMT,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat;
      if MonthMsg.TMSale_PRF<>0 then
        MonthMsg.TMSale_PRF_RATE:=FormatFloatValue((MonthMsg.TMSale_PRF*100.0)/NOTAX_MONEY,2);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('计算（本月份）月经营分析出错,错误:'+E.message);
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
    //计算消费者情况:
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select count(CUST_ID) as allCount,sum(case when SND_DATE>='''+TM_BegDate+''' and SND_DATE<='''+TM_EndDate+''' then 1 else 0 end) as newCount from PUB_CUSTOMER where TENANT_ID='+Tenant_ID+' ';
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMCust_Count:=Rs.FieldByName('allCount').AsInteger;       //总的消费者个数;
      MonthMsg.TMCust_NEW_Count:=Rs.FieldByName('newCount').AsInteger;   //本月新建消费者个数;
    end;    

    //计算会员销售情况:
    Rs.Close;
    Rs.SQL.Text:=ParseSQL(Factor.iDbType,
      'select sum(SAL_AMT) as SAL_AMT,sum(SALE_MNY) as SALE_MNY,count(distinct tmp.SORT_ID2) as CUST_HG_COUNT  from '+
      '(select (case when isnull(CLIENT_ID,'''')<>'''' then CALC_AMOUNT/'+CalcUnit+' else 0 end) as SAL_AMT,'+       //消费者销售数量[条]
      ' (case when isnull(CLIENT_ID,'''')<>'''' then NOTAX_MONEY+TAX_MONEY else 0 end) as SALE_MNY,'+   //消费者销售金额
      ' (case when b.SORT_ID2 in (''85994503-9CBC-4346-BC86-24C7F5A92BC6'',''59FD3FCD-2E8F-440A-B9B6-727B45524535'') then b.SORT_ID2 else '''' end) as SORT_ID2 '+ //高档烟消费者占的总数
      ' from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and '+
      ' a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+TM_BegDate+' and a.SALES_DATE<='+TM_EndDate+')tmp ');
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMCust_AMT:=FormatFloatValue(Rs.FieldByName('SAL_AMT').AsFloat,2);  //消费者消费数量;
      MonthMsg.TMCust_MNY:=FormatFloatValue(Rs.FieldByName('SALE_MNY').AsFloat,2); //消费者消费金额;
      MonthMsg.TMCust_HG_Count:=Rs.FieldByName('CUST_HG_COUNT').AsInteger; //消费者(高档烟的个数);
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
  //2011.10.12 库存情况:
  MonthMsg.TMGods_Count:=0;      //本月经营品种数;
  MonthMsg.TMGods_SX_Count:=0;   //本月经营品种数;
  MonthMsg.TMAllStor_AMT:=0;     //商品总库存数
  MonthMsg.TMLowStor_Count:=0;   //低于合理库存商品数

  result:=False;
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:=ParseSQL(Factor.iDbType,
      'select count(a.GODS_ID) as GODS_COUNT,'+  //有库存商品总数
      ' sum(case when c.SORT_ID10 =''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'' then 1 else 0 end) as GODS_SX_COUNT,'+  //是否是畅销品牌
      ' sum(case when c.SORT_ID11=''5D8D7AF6-2DE3-4866-85C7-925E07F66096'' then 1 else 0 end) as GODS_NEW_COUNT,'+  //是否是新品
      ' sum(case when (a.AMOUNT<b.LOWER_AMOUNT) and (isnull(b.LOWER_AMOUNT,0)>0) then 1 else 0 end) as LOWER_COUNT, '+ //低于合理库存数量
      ' sum(AMOUNT/(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)) as STOR_SUM '+  //库存总数量[单位:条]
      ' from STO_STORAGE a '+
      ' inner join VIW_GOODSINFO c on a.GODS_ID=c.GODS_ID '+
      ' left outer join PUB_GOODS_INSHOP b on a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID '+
      ' where round(a.AMOUNT,3)>0 and c.RELATION_ID=1000006 and a.TENANT_ID='+Tenant_ID+' ');
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMGods_Count:=Rs.FieldbyName('GODS_COUNT').AsInteger;       //本月经营品种数;
      MonthMsg.TMGods_SX_Count:=Rs.FieldbyName('GODS_SX_COUNT').AsInteger; //本月畅销品种数
      MonthMsg.TMNEWGODS_COUNT:=Rs.FieldbyName('GODS_NEW_COUNT').AsInteger; //本月畅销品种数
      MonthMsg.TMLowStor_Count:=Rs.FieldbyName('LOWER_COUNT').AsInteger; //低于合理库存商品数
      MonthMsg.TMAllStor_AMT:=FormatFloatValue(Rs.FieldbyName('STOR_SUM').AsFloat,2);        //商品总库存数
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
      'select sum(CALC_AMOUNT/(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)) as STOCK_AMT '+  //有库存商品总数
      ' ,sum(CALC_MONEY) as STOCK_MNY '+
      ' from VIW_STOCKDATA a,PUB_GOODSINFO b '+
      ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 and a.TENANT_ID='+Tenant_ID+' and a.STOCK_DATE>='+TM_BegDate+' and a.STOCK_DATE<='+TM_EndDate+' ');
    Factor.Open(Rs);
    if Rs.Active then
    begin
      MonthMsg.TMStock_AMT:=FormatFloatValue(Rs.FieldbyName('STOCK_AMT').AsFloat*1.00,2);  //本月入库数量:条
      if MonthMsg.TMStock_AMT<>0 then
        MonthMsg.TMStock_SINGLE_MNY:=FormatFloatValue(Rs.FieldbyName('STOCK_MNY').AsFloat/MonthMsg.TMStock_AMT,2);  //本月平均单条
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
      Raise Exception.Create('计算日经营情况出错,错误:'+E.message);
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
      Raise Exception.Create('计算日经营情况出错,错误:'+E.message);
    end;
  end;

end;

procedure TSaleAnalyMsg.InitalMonthMsg;
begin
  //同上月环比:
  MonthMsg.LMSale_AMT:=0;  //上月销量(单位:条);
  MonthMsg.LMSale_MNY:=0;  //上月销售额(元);
  MonthMsg.LMSale_PRF:=0;  //上月毛(单位:条);
  MonthMsg.LMSale_SINGLE_MNY:=0;  //本月平均每条销售额(元);

  //当前月份
  MonthMsg.TMStock_AMT:=0;   //本月购进(单位:条);
  MonthMsg.TMStock_SINGLE_MNY:=0;
  MonthMsg.TMSale_AMT:=0;    //本月销量(单位:条);
  MonthMsg.TMSale_MNY:=0;    //本月销售额(元);
  MonthMsg.TMSale_PRF:=0;    //本月毛(单位:条);
  MonthMsg.TMSale_PRF_RATE:=0;     //本月毛利率
  MonthMsg.TMSale_SINGLE_MNY:=0;   //本月平均每条销售额(元);
  MonthMsg.TMSale_AMT_UP_RATE:=0;  //本月数量增长;
  MonthMsg.TMSale_PRF_UP_RATE:=0;  //本月毛利率增长;
  MonthMsg.TMSale_SINGLE_MNY_UP_RATE:=0;  //本月单条金额增长率;

  MonthMsg.TMGods_MaxGrow_AMT:='';      //销量最大前3个，多个之间用“;”间隔开;
  MonthMsg.TMGods_MaxGrow_PRF:='';      //毛利最大前3个，多个之间用“;”间隔开;
  MonthMsg.TMGods_MaxGrowRate_AMT:='';  //环比销量增长最快3个，多个之间用“;”间隔开;

  //2011.10.12 消费者(会员)情况:
  MonthMsg.TMCust_Count:=0;      //总的消费者个数;
  MonthMsg.TMCust_HG_Count:=0;   //高档烟草消费者个数;
  MonthMsg.TMCust_NEW_Count:=0;  //本月新建消费者个数;
  MonthMsg.TMCust_AMT:=0;        //消费者消费数量;
  MonthMsg.TMCust_MNY:=0;        //消费者消费金额;
  MonthMsg.TMCust_AMT_RATE:=0;   //本月消费者消费数量占的比例;
  MonthMsg.TMCust_MNY_RATE:=0;   //本月消费者消费金额占的比例;
end;

end.
