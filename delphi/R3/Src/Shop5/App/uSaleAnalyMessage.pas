unit uSaleAnalyMessage;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns, Des, WinInet,
  ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase, Variants, ZLogFile;

  {============命名规则：
    Yesterday:  缩写：YD
    Today:      缩写：TD
    Last Month: 缩写：LM
    This Month: 缩写：TM
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
    LMSale_AMT: real;   //上月销量(单位:条);
    LMSale_MNY: real;   //上月销售额(元);
    LMSale_PRF: real;   //上月毛(单位:条);
    LMSale_PRF_RATE: real;  //本月销量(单位:条);
    TMGods_AMT: integer;  //本月经营品种数;
    TMCust_AMT: integer;  //本月消费者数;
    TMCust_MNY: real;  //本月消费者消费金额;
    TMCust_RATE: real; //本月消费者消费占的比例;
    TMSH_RATIO: real;  //本月存销比;
    TMSale_AMT: real;  //本月销量(单位:条);
    TMSale_MNY: real;  //本月销售额(元);
    TMSale_PRF: real;  //本月毛(单位:条);
    TMSale_PRF_RATE: real;  //本月毛利率(单位:条);
    TMGods_MaxPRF: string;  //环比毛利增长最快3个，多个之间用“;”间隔开;
    TMGods_MaxAMT: string;  //环比销量增长最快3个，多个之间用“;”间隔开;
    TMGods_MinPRF: string;  //环比毛利增长最快3个，多个之间用“;”间隔开;
    TMGods_MinAMT: string;  //环比销量增长最快3个，多个之间用“;”间隔开;
  end;
  
type
  TSaleAnalyMsg=class
  private
    TopCount: integer;
    Qry: TZQuery;
    FSaleDayMsg: TSaleDayMsg; //每天销售消息
    FSaleMonthMsg: TSaleMonthMsg; //月经营情况
    function GetFactor: TdbFactory; //返回
    function GetTenantID: string; //传入企业ID
    function FormatFloatValue(InValue :real; size: integer): real;
    function GetStorage(EndDate: string): real; //本月底的库存
    function GetMinGodsName(BegDate,EndDate: string): string; //动销最小的三个商品
    function GetMaxGodsName(vType: integer; BegDate,EndDate: string): string; //销量、毛利最大的三个商品
  public
    constructor Create;
    destructor  Destroy; override;
    procedure GetSaleDayMsg;  //返回当天销售msg
    procedure GetSaleMonthMsg(vCount: integer=3);  //返回当天销售msg
    property Factor: TdbFactory read GetFactor; //从外传入
    property Tenant_ID: string read GetTenantID;  //传入企业ID
    property DayMsg: TSaleDayMsg read FSaleDayMsg;  //每天经营情况
    property MonthMsg: TSaleMonthMsg read FSaleMonthMsg;  //每月经营情况
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
  //初始化日经营参数
  FSaleDayMsg.YDSale_AMT:=0;   //昨天销量(单位:条);
  FSaleDayMsg.YDSale_MNY:=0;   //昨天销售额(元);
  FSaleDayMsg.YDSale_PRF:=0;   //昨天毛利(元);
  FSaleDayMsg.YDSale_PRF_RATE:=0;  //昨天毛利率(%);
  FSaleDayMsg.TDSale_AMT:=0;   //今天销量(单位:条);
  FSaleDayMsg.TDSale_MNY:=0;   //今天销售额(元);
  FSaleDayMsg.TDSale_PRF:=0;   //今天毛利(元);
  FSaleDayMsg.TDSale_PRF_RATE:=0;  //今天毛利率(%);

  //初始化月经营参数
  FSaleMonthMsg.Month:=FormatDatetime('YYYYMM',Date());
  FSaleMonthMsg.LMSale_AMT:=0;   //上月销量(单位:条);
  FSaleMonthMsg.LMSale_MNY:=0;   //上月销售额(元);
  FSaleMonthMsg.LMSale_PRF:=0;   //上月毛(单位:条);
  FSaleMonthMsg.LMSale_PRF_RATE:=0;  //本月销量(单位:条);
  FSaleMonthMsg.TMGods_AMT:=0;  //本月经营品种数;
  FSaleMonthMsg.TMCust_AMT:=0;  //本月消费者数;
  FSaleMonthMsg.TMCust_MNY:=0;  //本月消费者消费金额;
  FSaleMonthMsg.TMCust_RATE:=0; //本月消费者消费占的比例;
  FSaleMonthMsg.TMSH_RATIO:=0;  //本月存销比;
  FSaleMonthMsg.TMSale_AMT:=0;  //本月销量(单位:条);
  FSaleMonthMsg.TMSale_MNY:=0;  //本月销售额(元);
  FSaleMonthMsg.TMSale_PRF:=0;  //本月毛(单位:条);
  FSaleMonthMsg.TMSale_PRF_RATE:=0;  //本月销量(单位:条);
  FSaleMonthMsg.TMGods_MaxPRF:='';  //环比毛利增长最快3个，多个之间用“;”间隔开;
  FSaleMonthMsg.TMGods_MaxAMT:='';  //环比销量增长最快3个，多个之间用“;”间隔开;
  FSaleMonthMsg.TMGods_MinPRF:='';  //环比毛利增长最快3个，多个之间用“;”间隔开;
  FSaleMonthMsg.TMGods_MinAMT:='';  //环比销量增长最快3个，多个之间用“;”间隔开;
end;

destructor TSaleAnalyMsg.Destroy;
begin
  Qry.Free;
  inherited; 
end;

procedure TSaleAnalyMsg.GetSaleDayMsg;
var
  YsDay: string; //昨天；
  ToDay: string; //今天;
  str,CalcUnit: string;
begin
  try
    CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
    YsDay:=FormatDatetime('YYYYMMDD',Date()-1); //昨天销售日期;
    ToDay:=FormatDatetime('YYYYMMDD',Date()); //本月结束日期（今天）;
    //昨天销售情况
    str:='select sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,(sum(SALE_MNY)+sum(SALE_TAX)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
         'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID '+
         ' and TENANT_ID='+Tenant_ID+' and SALES_DATE='+YsDay+' ';
    Qry.Close;
    Qry.SQL.Text:=str;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      FSaleDayMsg.YDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      FSaleDayMsg.YDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      FSaleDayMsg.YDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if FSaleDayMsg.YDSale_MNY>0 then
        FSaleDayMsg.YDSale_PRF_RATE:=FormatFloatValue(FSaleDayMsg.YDSale_PRF/FSaleDayMsg.YDSale_MNY,2);
    end;
    if (FSaleDayMsg.YDSale_AMT=0) and (FSaleDayMsg.YDSale_MNY=0) then Exit;  //昨天没有经营数据则退;
    
    //今天销售情况
    str:='select sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,(sum(SALE_MNY)+sum(SALE_TAX)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
         'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID '+
         ' and TENANT_ID='+Tenant_ID+' and SALES_DATE='+ToDay+' ';
    Qry.Close;
    Qry.SQL.Text:=str;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      FSaleDayMsg.TDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      FSaleDayMsg.TDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      FSaleDayMsg.TDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if FSaleDayMsg.YDSale_MNY>0 then
        FSaleDayMsg.YDSale_PRF_RATE:=FormatFloatValue(FSaleDayMsg.YDSale_PRF/FSaleDayMsg.YDSale_MNY,2);
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
  LMBegDay: string; //上个月开始日期;
  LMEndDay: string; //本月结束日期;
  TMBegDay: string; //本月开始日期;
  TMEndDay: string; //本月结束日期;
  str,CalcUnit: string;
begin
  TopCount:=vCount;
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  LMBegDay:=FormatDatetime('YYYYMM',IncMonth(Date(),-1))+'01'; //上个月开始日期;
  LMEndDay:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(Date(),-1))); //上个月最后一天;
  TMBegDay:=FormatDatetime('YYYYMM',Date())+'01'; //本月开始日期;
  TMEndDay:=FormatDatetime('YYYYMMDD',Date());    //本月结束日期（今天）;
  try
    //上个月经营情况：
    str:=
      'select '+
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //销售数量[条]
      '(sum(SALE_MNY)+sum(SALE_TAX)) as SALE_MNY,'+  //销售金额
      '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //销售毛利
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and '+
      ' TENANT_ID='+Tenant_ID+' and SALES_DATE>='+LMBegDay+' and SALES_DATE<='+LMEndDay+' ';
    Qry.Close;
    Qry.SQL.Text:=Str;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      FSaleMonthMsg.LMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      FSaleMonthMsg.LMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      FSaleMonthMsg.LMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if FSaleMonthMsg.LMSale_MNY<>0 then
        FSaleMonthMsg.LMSale_PRF_RATE:=FormatFloatValue(FSaleMonthMsg.LMSale_PRF/FSaleMonthMsg.LMSale_MNY,2);
    end;

    if (FSaleMonthMsg.LMSale_AMT=0) and (FSaleMonthMsg.LMSale_MNY=0) then Exit; //上月没数据则退出
    //本月经营情况：
    str:=
      'select '+
      ' count(distinct a.GODS_ID) as GODS_COUNT,'+   //经营商品数
      ' count(distinct a.CLIENT_ID) as CUST_COUNT,'+  //固定消费者数
      '(case when isnull(a.CLIENT_ID,'''')<>'''' then (sum(SALE_MNY)+sum(SALE_TAX)) else 0 end) as CUST_MNY,'+  //固定消费金额
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //销售数量[条]
      '(sum(SALE_MNY)+sum(SALE_TAX)) as SALE_MNY,'+  //销售金额
      '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //销售毛利
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and '+
      ' TENANT_ID='+Tenant_ID+' and SALES_DATE>='+TMBegDay+' and SALES_DATE<='+TMEndDay+' ';
    Qry.Close;
    Qry.SQL.Text:=Str;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      FSaleMonthMsg.TMGods_AMT:=Qry.fieldbyName('GODS_COUNT').AsInteger; //本月经营品项数
      FSaleMonthMsg.TMCust_AMT:=Qry.fieldbyName('CUST_COUNT').AsInteger;                   //本月固定消费者
      FSaleMonthMsg.TMCust_MNY:=FormatFloatValue(Qry.fieldbyName('CUST_MNY').AsFloat,2);   //本月固定消费金额
      FSaleMonthMsg.TMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);    //本月销售量
      FSaleMonthMsg.TMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      FSaleMonthMsg.TMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if FSaleMonthMsg.LMSale_MNY<>0 then
        FSaleMonthMsg.TMSale_PRF_RATE:=FormatFloatValue(FSaleMonthMsg.TMSale_PRF/FSaleMonthMsg.TMSale_MNY,2);
    end;
    //对比经营情况：
    if FSaleMonthMsg.TMSale_AMT>FSaleMonthMsg.LMSale_AMT then //本月比上月增长
    begin
      FSaleMonthMsg.TMGods_MaxAMT:=GetMaxGodsName(1,TMBegDay,TMEndDay);
      FSaleMonthMsg.TMGods_MinPRF:=GetMaxGodsName(2,TMBegDay,TMEndDay);
    end else
    begin
      FSaleMonthMsg.TMGods_MinAMT:=GetMinGodsName(TMBegDay,TMEndDay);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('计算月经营情况出错,错误:'+E.message);
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
  BaseTab:=
    'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,VIW_GOODSINFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and TENANT_ID='''+Tenant_ID+''' and SALES_DATE>='+BegDate+' and SALES_DATE<='+EndDate+' ';

  case vType of
   1: //销量
    begin
      case Factor.iDbType of
       0,2,3:
          str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SAL_AMT desc'; //降序
       1: str:='select GODS_NAME From ('+BaseTab+')as tp where rownum<='+InttoStr(TopCount)+' order by SAL_AMT desc';
       4: str:='select GODS_NAME from (select * From ('+BaseTab+') as tmp order by SAL_AMT desc)tp fetch first '+InttoStr(TopCount)+' rows only ';
       5: str:='select GODS_NAME from ('+BaseTab+') as tmp order by SAL_AMT desc limit '+InttoStr(TopCount)+'';
      end;
    end;
   2: //毛利
    begin
      case Factor.iDbType of
       0,2,3:
          str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SALE_PRF desc'; //降序
       1: str:='select GODS_NAME From ('+BaseTab+')as tp where rownum<='+InttoStr(TopCount)+' order by SALE_PRF desc';
       4: str:='select GODS_NAME from (select * From ('+BaseTab+') as tmp order by SALE_PRF desc)tp fetch first '+InttoStr(TopCount)+' rows only ';
       5: str:='select GODS_NAME from ('+BaseTab+') as tmp order by SALE_PRF desc limit '+InttoStr(TopCount)+' ';
      end;
    end;
  end;

  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:=str;
    Factor.Open(rs);
    if rs.Active then
    begin
      rs.First;
      while not rs.Eof do
      begin
        ReStr:=ReStr+rs.fieldbyName('GODS_NAME').AsString+';';
        rs.Next; 
      end; 
    end;
  finally
    rs.Free;
  end;
end;

//动销最小的三个商品
function TSaleAnalyMsg.GetMinGodsName(BegDate, EndDate: string): string;
var
  BaseTab,str,ReStr: string;
  rs: TZQuery;
begin
  if TopCount<=0 then TopCount:=3;  //默认取前三个
  BaseTab:=
    'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,VIW_GOODSINFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and TENANT_ID='''+Tenant_ID+''' and SALES_DATE>='+BegDate+' and SALES_DATE<='+EndDate+' ';

  case Factor.iDbType of
   0,2,3:
      str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SAL_AMT asc'; //降序
   1: str:='select GODS_NAME From ('+BaseTab+')as tp where rownum<='+InttoStr(TopCount)+' order by SAL_AMT asc';
   4: str:='select GODS_NAME from (select * From ('+BaseTab+') as tmp order by SAL_AMT asc)tp fetch first '+InttoStr(TopCount)+' rows only ';
   5: str:='select GODS_NAME from ('+BaseTab+') as tmp order by SAL_AMT asc limit '+InttoStr(TopCount)+' ';
  end;

  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:=str;
    Factor.Open(rs);
    if rs.Active then
    begin
      rs.First;
      while not rs.Eof do
      begin
        ReStr:=ReStr+rs.fieldbyName('GODS_NAME').AsString+';';
        rs.Next; 
      end;
    end;
  finally
    rs.Free;
  end;
end;

//本月底的库存
function TSaleAnalyMsg.GetStorage(EndDate: string): real;
begin

end;

end.
