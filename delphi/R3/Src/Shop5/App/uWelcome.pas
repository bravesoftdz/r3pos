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
    YDSale_AMT: real;          //昨天销量(单位:条);
    YDSale_MNY: real;          //昨天销售额(元);
    YDSale_PRF: real;          //昨天毛利(元);
    YDSale_PRF_RATE: real;     //昨天毛利率(%);

    TDSaleGods_Count: integer; //今天销售品种(单位:个);
    TDSaleBill_Count: integer; //今天销售单据比数(单位:笔);
    TDSale_Count: integer;     //销售品种(单位:个);
    TDSale_AMT: real;          //今天销量(单位:条);
    TDSale_MNY: real;          //今天销售额(元);
    TDSale_PRF: real;          //今天毛利(元);
    TDSale_PRF_RATE: real;     //今天毛利率(%);

    //与前天对比:
    QTSaleGods_Count: integer; //前天销售品种(单位:个);
    QTSaleBill_Count: integer; //前天销售单据比数(单位:笔);
    QTSale_Count: integer;     //销售品种(单位:个);
    QTSale_AMT: real;          //今天销量(单位:条);
    QTSale_MNY: real;          //今天销售额(元);
    QTSale_PRF: real;          //今天毛利(元);
    QTSale_PRF_RATE: real;     //今天毛利率(%);

    TDStockGods_Count: integer; //本次进货商品数
    TDStock_AMT: real;  //本次进货条数
    TDStock_MNY: real;  //本次进货金额

    SCStockGods_Count: integer; //本次进货商品数
    SCStock_AMT: real;  //本次进货条数
    SCStock_MNY: real;  //本次进货金额

    TMGods_All_Count:integer;  //本月经营总品种数;
    TMGods_Count:integer;      //本月有库存品种数;
    TMGods_SX_Count:integer;   //烟草畅销品种数;
    TMGods_NEW_Count:integer;  //经营新品种数;
    TMAllStor_AMT:real;        //商品总库存数
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
    TMStock_MNY: real;    //本月购进(单条值);
    
    TMSale_AMT: real;     //本月销量(单位:条);
    TMSale_MNY: real;     //本月销售额(元);
    TMSale_PRF: real;     //本月毛(单位:条);
    TMSale_PRF_RATE: real;    //本月毛理率;
    TMSale_SINGLE_MNY: real;  //本月平均每条销售额(元);
    TMSale_AMT_UP_RATE: real;    //本月数量增长;
    TMSale_PRF_UP_RATE: real;    //本月毛利率增长;
    TMSale_SINGLE_MNY_UP_RATE: real;   //本月单条金额增长率;

    LMGods_SY_MaxGrow_AMT: string;  //上月销量最大前3个，多个之间用“;”间隔开;
    LMGods_SY_MaxGrow_PRF: string;  //上月毛利最大前3个，多个之间用“;”间隔开;
    TMGods_MaxGrow_AMT: string;  //本月销量最大前3个，多个之间用“;”间隔开;
    TMGods_MaxGrow_PRF: string;  //本月毛利最大前3个，多个之间用“;”间隔开;
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
    FHotSale: array [0..23] of real;
    dayRs:TZQuery;
    dayJh:TZQuery;
    dayKc:TZQuery;
    MthRs:TZQuery;
    CustRs:TZQuery;
    FDay1: string;    //当月份第几天
    FDay2: string;    //当月份第几天
    FLMonth: string; //上个月
    FMonth: string;  //本月份
    QtDay:string;
    YsDay:string;
    ToDay:string;
    function  FormatFloatValue(InValue :real; size: integer): real; //小数位控制
    procedure LoadDays;
    procedure LoadMths;
    procedure SetMonth(const Value: string);
    function  GetGodsNames(GodsIds: TStringList): string; //根据GodsIDS返回GodsNAME
    function  GetAmtGrowRateMax: String; //增长率最快     //返回增长率最高
    function  GetMaxGrowGodsName(vType,Month: integer): String; //返回最大增长商品
    //读最旺销时段
    function  GetTMCust_MAX_TIME:string;
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
  CustRs := TZQuery.Create(nil);
  Month := formatDatetime('YYYYMM',Date());
end;

destructor TWelcome.Destroy;
begin
  dayRs.Free;
  dayJh.Free;
  dayKc.Free;
  MthRs.Free;
  CustRs.Free;
  inherited;
end;

function TWelcome.EncodeMsgDayInfo: TMsgDayInfo;
begin
  if not dayRs.Active then LoadDays;
  Fillchar(result,sizeof(result),0);
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

  //最后一次进货情况
  result.TDStockGods_Count:=dayJh.fieldbyName('GODS_COUNT').AsInteger;
  result.TDStock_AMT:=dayJh.fieldbyName('STK_AMT').AsFloat;
  result.TDStock_MNY:=dayJh.fieldbyName('STK_MNY').AsFloat;
  //最后第2次进货情况
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
var
  GodsID: string;
  TM_NOTAX_MNY: real; //未税金额
  RsGods: TZQuery;
  i:integer;
begin
  self.LoadMths; //重新查询
  TM_NOTAX_MNY:=0;
  Fillchar(result,sizeof(result),0); //初始化参数
  Fillchar(FHotSale,sizeof(FHotSale),0);
  RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO'); 
  for i:=0 to 23 do FHotSale[i] := 0;
  //循环取数据:
  MthRs.First;
  while not MthRs.Eof do
  begin
    if MthRs.FieldByName('SALES_DATE').AsCurrency=StrtoIntDef(FLMonth,0) then //上个月份
    begin
      result.LMSale_AMT:=result.LMSale_AMT+MthRs.FieldByName('SAL_AMT').AsFloat;  //上月销量(单位:条);
      result.LMSale_MNY:=result.LMSale_MNY+MthRs.FieldByName('SALE_MNY').AsFloat; //上月销售额(元);
      result.LMSale_PRF:=result.LMSale_PRF+MthRs.FieldByName('SALE_PRF').AsFloat; //上月毛(单位:条);
    end else
    if MthRs.FieldByName('SALES_DATE').AsCurrency=StrtoIntDef(FMonth,0) then //当前月份
    begin
      TM_NOTAX_MNY:=TM_NOTAX_MNY+MthRs.FieldByName('NOTAX_MONEY').AsFloat;  //未税金额
      result.TMSale_AMT:=result.TMSale_AMT+MthRs.FieldByName('SAL_AMT').AsFloat;  //本月销量(单位:条);
      result.TMSale_MNY:=result.TMSale_MNY+MthRs.FieldByName('SALE_MNY').AsFloat; //本月销售额(元);
      result.TMSale_PRF:=result.TMSale_PRF+MthRs.FieldByName('SALE_PRF').AsFloat; //本月毛(单位:条);
      for i:=0 to 23 do FHotSale[i] := FHotSale[i] + MthRs.FieldByName('T'+formatFloat('00',i)+'_AMT').AsFloat;

      if MthRs.FieldByName('CUST_FLAG').AsCurrency>0 then
      begin
        result.TMCust_AMT:=result.TMCust_AMT+MthRs.FieldByName('SAL_AMT').AsFloat;
        result.TMCust_MNY:=result.TMCust_MNY+MthRs.FieldByName('SALE_MNY').AsFloat;
        if RsGods.Locate('GODS_ID',MthRs.FieldbyName('GODS_ID').asString,[]) and (RsGods.FieldbyName('SORT_ID2').asString='85994503-9CBC-4346-BC86-24C7F5A92BC6') then
          result.TMCust_HG_Count := result.TMCust_HG_Count+1;
      end;
    end;
    MthRs.Next;
  end;

  if result.LMSale_AMT<>0 then
    result.LMSale_SINGLE_MNY:=FormatFloatValue(result.LMSale_MNY/result.LMSale_AMT,2); //上月平均每条销售额(元);
  if TM_NOTAX_MNY<>0 then
    result.TMSale_PRF_RATE:=FormatFloatValue(result.TMSale_PRF/TM_NOTAX_MNY,2);  //本月毛率;
  if result.TMSale_AMT<>0 then
    result.TMSale_SINGLE_MNY:=FormatFloatValue(result.TMSale_MNY/result.TMSale_AMT,2); //本月平均每条销售额(元);
  result.TMSale_AMT_UP_RATE:=result.TMSale_AMT-result.LMSale_AMT;   //本月数量增长;
  result.TMSale_PRF_UP_RATE:=result.TMSale_PRF-result.LMSale_PRF;   //本月毛利增长;
  if result.LMSale_SINGLE_MNY<>0 then
    result.TMSale_SINGLE_MNY_UP_RATE:=FormatFloatValue((result.TMSale_SINGLE_MNY-result.LMSale_SINGLE_MNY)*100/result.LMSale_SINGLE_MNY,2);   //本月单条金额增长率;

  if result.TMCust_AMT<>0 then
    result.TMCust_AMT_RATE:=result.TMCust_AMT/result.TMSale_AMT; //本月消费者消费数量占的比例;
  if result.TMCust_MNY<>0 then
    result.TMCust_MNY_RATE:=result.TMCust_MNY/result.TMSale_MNY; //本月消费者消费金额占的比例;

  result.TMCust_MAX_TIME := GetTMCust_MAX_TIME;

  result.LMGods_SY_MaxGrow_AMT:=GetMaxGrowGodsName(1,StrtoInt(FLMonth));
  result.LMGods_SY_MaxGrow_PRF:=GetMaxGrowGodsName(2,StrtoInt(FLMonth));
  result.TMGods_MaxGrow_AMT:=GetMaxGrowGodsName(1,StrtoInt(FMonth));
  result.TMGods_MaxGrow_PRF:=GetMaxGrowGodsName(2,StrtoInt(FMonth));
  result.TMGods_MaxGrowRate_AMT:=GetAmtGrowRateMax;

  //2011.10.12 消费者(会员)情况:
  result.TMCust_Count:=CustRs.FieldByName('allCount').AsInteger;       //总的消费者个数;
  result.TMCust_NEW_Count:=CustRs.FieldByName('newCount').AsInteger;   //本月新建消费者个数;
end;

function TWelcome.FormatFloatValue(InValue: real; size: integer): real;
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

function TWelcome.GetGodsNames(GodsIds: TStringList): string;
var
  GodsID: string;
  RsGods: TZQuery;
  i:integer;
begin
  RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO');
  if GodsIds.Count>0 then
  begin
    for i:=0 to GodsIds.Count-1 do
    begin
      GodsID:=trim(GodsIds.Strings[i]);
      if RsGods.Locate('GODS_ID',GodsID,[]) then
      begin
        if result<>'' then result:=result+'、';
        result:=result+RsGods.fieldbyName('GODS_NAME').AsString;
      end;
    end;
  end else
    result:='无';
end;

function TWelcome.GetMaxGrowGodsName(vType, Month: integer): string;
  function SetGodsInfo(GodsIDS: TStringList; FieldName: string ; var GODS_ID: string; var Gods_VALUE: Real):Boolean;
  begin
    MthRs.First;
    while not MthRs.Eof do
    begin
      if MthRs.FieldByName('SALES_DATE').AsCurrency=Month then
      begin
        if GodsIDS.IndexOf(MthRs.FieldByName('GODS_ID').AsString)=-1 then
        begin
          GODS_ID:=MthRs.FieldByName('GODS_ID').AsString;
          Gods_VALUE:=MthRs.FieldByName(FieldName).AsFloat;
          break;
        end;
      end;
      MthRs.Next;
    end;
  end;
var
  i: integer;
  CurValue: Real;
  GodsID,FieldName: string;
  tmpTable: TZQuery;
  Gods_IDList: TStringList;
begin
  result:='';
  case vType of
   1: FieldName:='SAL_AMT';
   2: FieldName:='SALE_PRF';
  end;

  try
    tmpTable:=TZQuery.Create(nil);
    tmpTable.Data:=MthRs.Data;
    Gods_IDList:=TStringList.Create;
    for i:=1 to 5 do
    begin
      //获取GODS_ID
      SetGodsInfo(Gods_IDList,FieldName,GodsID, CurValue);

      tmpTable.First;
      while not tmpTable.Eof do
      begin
        if tmpTable.FieldByName('SALES_DATE').AsCurrency=Month then
        begin
          if Gods_IDList.IndexOf(tmpTable.FieldByName('GODS_ID').AsString)=-1 then //不在List上
          begin   
            if CurValue<tmpTable.FieldByName(FieldName).AsFloat then
              GodsID:=tmpTable.FieldByName('GODS_ID').AsString;  
          end;
        end;
        tmpTable.Next;
      end;
      if GodsID<>'' then Gods_IDList.Add(GodsID);            
    end;
    result:=GetGodsNames(Gods_IDList);
  finally
    Gods_IDList.Free;
    tmpTable.Free;
  end;
end;

function TWelcome.GetAmtGrowRateMax: string; //增长率最快
  function SetGodsInfo(GodsIDS: TStringList; Rs: TZQuery; var GODS_ID: string; var GODS_VALUE: Real):Boolean;
  begin
    Rs.First;
    while not Rs.Eof do
    begin
      if GodsIDS.IndexOf(Rs.FieldByName('GODS_ID').AsString)=-1 then
      begin
        GODS_ID:=Rs.FieldByName('GODS_ID').AsString;
        GODS_VALUE:=Rs.FieldByName('AMT_RATE').AsFloat;
        break;
      end;
      Rs.Next;
    end;
  end;
var
  i: integer;
  CurValue: Real;
  GodsID,FieldName: string;
  GrowRs: TZQuery;
  Gods_IDList: TStringList;
begin
  try
    CurValue := -9999;
    GrowRs:=TZQuery.Create(nil);
    GrowRs.FieldDefs.Add('GODS_ID',ftstring,36,true);
    GrowRs.FieldDefs.Add('TM_AMT',ftfloat,0,true);
    GrowRs.FieldDefs.Add('LM_AMT',ftfloat,0,true);
    GrowRs.FieldDefs.Add('AMT_RATE',ftfloat,0,true);
    GrowRs.CreateDataSet;
    MthRs.First;
    while not MthRs.Eof do
    begin
      GodsID:=trim(MthRs.FieldByName('GODS_ID').AsString);
      if MthRs.FieldByName('SALES_DATE').AsCurrency=StrtoIntDef(FLMonth,0) then //上个月
      begin
        if GrowRs.Locate('GODS_ID',GodsID,[]) then GrowRs.Edit
        else
        begin
          GrowRs.Append;
          GrowRs.FieldByName('GODS_ID').AsString:=GodsID;
        end;
        GrowRs.FieldByName('LM_AMT').AsFloat:=GrowRs.FieldByName('LM_AMT').AsFloat+MthRs.FieldByName('SAL_AMT').AsFloat;
      end else
      if MthRs.FieldByName('SALES_DATE').AsCurrency=StrtoIntDef(FMonth,0) then //本月
      begin
        if GrowRs.Locate('GODS_ID',GodsID,[]) then GrowRs.Edit
        else
        begin
          GrowRs.Append;
          GrowRs.FieldByName('GODS_ID').AsString:=GodsID;
        end;
        GrowRs.FieldByName('TM_AMT').AsFloat:=GrowRs.FieldByName('TM_AMT').AsFloat+MthRs.FieldByName('SAL_AMT').AsFloat;
      end;
      if MthRs.FieldByName('SAL_AMT').AsFloat<>0 then
        GrowRs.FieldByName('AMT_RATE').AsFloat:=GrowRs.FieldByName('TM_AMT').AsFloat/MthRs.FieldByName('SAL_AMT').AsFloat
      else
        GrowRs.FieldByName('AMT_RATE').AsFloat:=0;
      MthRs.Next;
    end;

    //取最大5个
    Gods_IDList:=TStringList.Create;
    for i:=1 to 5 do
    begin
      //获取GODS_ID
      SetGodsInfo(Gods_IDList,GrowRs,GodsID, CurValue);

      GrowRs.First;
      while not GrowRs.Eof do
      begin
        if Gods_IDList.IndexOf(GrowRs.FieldByName('GODS_ID').AsString)=-1 then //不在List上
        begin
          if CurValue<GrowRs.FieldByName('AMT_RATE').AsFloat then
            GodsID:=GrowRs.FieldByName('GODS_ID').AsString;
        end;
        GrowRs.Next;
      end;
      if GodsID<>'' then Gods_IDList.Add(GodsID);            
    end;
    result:=GetGodsNames(Gods_IDList);
  finally
    Gods_IDList.Free;
    GrowRs.Free;
  end;
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
      ' sum(case when c.SORT_ID10 =''5D8D7AF6-2DE3-4866-85C7-925E07F66096'' then 1 else 0 end) as GODS_SX_COUNT,'+  //是否是畅销品牌
      ' sum(case when c.SORT_ID10=''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'' then 1 else 0 end) as GODS_NEW_COUNT,'+  //烟草提供新品个数
      ' sum(case when (c.SORT_ID10=''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'') and (bb.STOR_GODS_ID is not  null) then 1 else 0 end) as GODS_NEW_SALE_COUNT,'+  //零售户经营新品个数
      ' sum(case when (Round(bb.AMOUNT,3)<Round(bb.LOWER_AMOUNT,3)) and (isnull(Round(bb.LOWER_AMOUNT,3),0)>0) then 1 else 0 end) as LOWER_COUNT, '+ //低于合理库存数量
      ' sum(AMOUNT/'+CalcUnit+') as STOR_SUM '+  //库存总数量[单位:条]
      ' from VIW_GOODSINFO c '+
      ' left outer join '+
      ' (select a.GODS_ID as STOR_GODS_ID,b.LOWER_AMOUNT,round(a.AMOUNT,3) as AMOUNT from STO_STORAGE a '+
      '   left join PUB_GOODS_INSHOP b on  a.TENANT_ID=b.TENANT_ID and a.SHOP_ID=b.SHOP_ID and a.GODS_ID=b.GODS_ID '+
      '  where a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and round(a.AMOUNT,3)>0) bb '+
      ' on c.GODS_ID=bb.STOR_GODS_ID '+
      ' where c.TENANT_ID='+inttostr(Global.TENANT_ID)+' and c.RELATION_ID=1000006 and c.COMM not in (''01'',''02'')');
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
    'select round(a.SALES_DATE / 100) as SALES_DATE,'+
    'a.GODS_ID as GODS_ID,count(*) as SAL_OAMT,'+
    'count(distinct a.GODS_ID) as SAL_GAMT,'+
    'sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+
    'sum(NOTAX_MONEY) as NOTAX_MONEY,'+
    '(nvl(sum(NOTAX_MONEY),0)+nvl(sum(TAX_MONEY),0)) as SALE_MNY,'+  
    '(nvl(sum(NOTAX_MONEY),0)-nvl(sum(COST_MONEY),0)) as SALE_PRF,'+
    'sum(case when substring(CREA_DATE,12,2)=''00'' then CALC_AMOUNT else 0 end) as T00_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''01'' then CALC_AMOUNT else 0 end) as T01_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''02'' then CALC_AMOUNT else 0 end) as T02_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''03'' then CALC_AMOUNT else 0 end) as T03_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''04'' then CALC_AMOUNT else 0 end) as T04_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''05'' then CALC_AMOUNT else 0 end) as T05_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''06'' then CALC_AMOUNT else 0 end) as T06_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''07'' then CALC_AMOUNT else 0 end) as T07_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''08'' then CALC_AMOUNT else 0 end) as T08_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''09'' then CALC_AMOUNT else 0 end) as T09_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''10'' then CALC_AMOUNT else 0 end) as T10_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''11'' then CALC_AMOUNT else 0 end) as T11_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''12'' then CALC_AMOUNT else 0 end) as T12_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''13'' then CALC_AMOUNT else 0 end) as T13_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''14'' then CALC_AMOUNT else 0 end) as T14_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''15'' then CALC_AMOUNT else 0 end) as T15_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''16'' then CALC_AMOUNT else 0 end) as T16_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''17'' then CALC_AMOUNT else 0 end) as T17_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''18'' then CALC_AMOUNT else 0 end) as T18_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''19'' then CALC_AMOUNT else 0 end) as T19_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''20'' then CALC_AMOUNT else 0 end) as T20_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''21'' then CALC_AMOUNT else 0 end) as T21_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''22'' then CALC_AMOUNT else 0 end) as T22_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''23'' then CALC_AMOUNT else 0 end) as T23_AMT,'+
    'sum(case when a.CLIENT_ID is not null then 1 else 0 end) as CUST_FLAG '+ //是否是会员Flag
    'from VIW_SALESDATA a,PUB_GOODSINFO b '+
    ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 '+
    ' and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and ((a.SALES_DATE>=:LM_BEGIN_DATE and a.SALES_DATE<=:LM_END_DATE)'+
    ' or (a.SALES_DATE>=:TM_BEGIN_DATE and a.SALES_DATE<=:TM_END_DATE)) '+
    'group by round(a.SALES_DATE / 100),a.GODS_ID';
  MthRs.Close;
  MthRs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  MthRs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  MthRs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  MthRs.ParamByName('LM_BEGIN_DATE').AsInteger := StrtoInt(FLMonth+'01'); //上月第一天
  MthRs.ParamByName('LM_END_DATE').AsInteger :=   StrtoInt(FLMonth+FDay1); //上月今天
  MthRs.ParamByName('TM_BEGIN_DATE').AsInteger := StrtoInt(FMonth+'01');  //本月第一天
  MthRs.ParamByName('TM_END_DATE').AsInteger :=   StrtoInt(FMonth+FDay2);  //本月今天
  Factor.Open(MthRs);

  //取会员情况:
  CustRs.Close;
  CustRs.SQL.Text:=
    'select count(CUST_ID) as allCount,sum(case when SND_DATE>='''+Copy(FMonth,1,4)+'-'+Copy(FMonth,5,2)+'-01'' and SND_DATE<='''+Copy(FMonth,1,4)+'-'+Copy(FMonth,5,2)+'-'+FDay+''' then 1 else 0 end) as newCount from PUB_CUSTOMER '+
    ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID ';
  CustRs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  CustRs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Factor.Open(CustRs);

end;

procedure TWelcome.SetMonth(const Value: string);
var
  CurDate: TDate;
begin
  FMonth := Value;
  //根据本月份计算上个月份
  CurDate := FnTime.fnStrtoDate(FMonth+'01');
  FLMonth := FormatDatetime('YYYYMM',incMonth(CurDate,-1));
  if formatdatetime('YYYYMM',date())=Value then //本月
     begin
       FDay2:=Copy(FormatDatetime('YYYYMMDD',Date()),7,2);
       if formatDatetime('DD',Date())= formatdatetime('DD',incMonth(CurDate,1)-1) then
          FDay1:= FormatDatetime('DD',incMonth(CurDate)-1);
       else
          FDay1:= Copy(FormatDatetime('YYYYMMDD',Date()),7,2);
     end;
end;



function TWelcome.GetTMCust_MAX_TIME: string;
var
  s1,s2,s3,s4:real;
  t1,t2,t3,t4:integer;
  i:integer;
  list:TStringList;
  b:integer;
  IsFlag: Boolean; //标记位
begin
  s1 := 0;
  s2 := 0;
  s3 := 0;
  s4 := 0;
  for i:=0 to 23 do
     begin
       if (FHotSale[i]>s1) and (FHotSale[i]>0) then
          begin
            s1 := FHotSale[i];
            t1 := i;
          end;
     end;
  for i:=0 to 23 do
     begin
       if (FHotSale[i]>s2) and (FHotSale[i]>0) and (FHotSale[i]<s1) then
          begin
            s2 := FHotSale[i];
            t2 := i;
          end;
     end;
  for i:=0 to 23 do
     begin
       if (FHotSale[i]>s3) and (FHotSale[i]>0) and (FHotSale[i]<s2) then
          begin
            s3 := FHotSale[i];
            t3 := i;
          end;
     end;
  for i:=0 to 23 do
     begin
       if (FHotSale[i]>s4) and (FHotSale[i]>0) and (FHotSale[i]<s3) then
          begin
            s4 := FHotSale[i];
            t4 := i;
          end;
     end;
     
  //开始组旺销时段了
  list:=TStringList.Create;
  try
    if s1>0 then list.Add(formatFloat('00',t1));
    if s2>0 then list.Add(formatFloat('00',t2));
    if s3>0 then list.Add(formatFloat('00',t3));
    if s4>0 then list.Add(formatFloat('00',t4));
    list.Sort;
    result := '';
    b := -1;
    IsFlag:=False;
    for i:=0 to list.Count -1 do
    begin
      if b=-1 then
      begin
        if result <> '' then result := result + '，';
        result := result + list[i]+'时';
        b:= strtoint(list[i]);  //xhh add
      end else
      begin
        if (strtoint(list[i])=b+1) and (i<list.Count) then
        begin
          b := strtoint(list[i]);
          IsFlag:=True;
          continue;
        end;
        if b<>strtoint(list[i]) then
        begin
          if IsFlag then
          begin
            result := result + '至'+ list[i-1]+'时，'+list[i]+'时';
            IsFlag:=False;
          end else
          begin
            if result <> '' then result := result + '，';
            result := result + list[i]+'时';
          end;
          b:= strtoint(list[i]);
        end;
      end;
    end;
    if IsFlag then result := result + '至'+ list.Strings[List.Count-1]+'时';
  finally
    list.Free;
  end;
end;

end.
