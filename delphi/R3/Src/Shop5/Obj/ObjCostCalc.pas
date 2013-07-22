unit ObjCostCalc;

interface

uses
  Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,Controls,ObjCommon,Variants;

type  
  //台账计算基类
  TBaseCalc = class
  private
    dbHelp:IdbHelp; //数据库访问接口
    FParams:TftParamList; //参数集对象
    FTENANT_ID:integer;   //企业ID
    FLastMth_Date:TDate;  //上一个结账日期
    FUSER_ID:string;      //用户ID
    FReckBegDate:TDate;   //核算区间开始日期（核算开始日期）
    FReckEndDate:TDate;   //核算区间结束日期（核算结束日期）
    function GetDbType:Integer; //数据库存类型
    procedure SetReckBegDate(const Value: TDate);
    procedure SetReckEndDate(const Value: TDate);
  public
    procedure CreateNew; virtual;
    procedure SetInParams(AGlobal:IdbHelp;InParams:TftParamList;TEN_ID:integer;U_ID:string;LMth_Date:TDate); //设置参数
    function DoCalcReck(Reck_Beg_Date,Reck_End_Date:TDate):Boolean;virtual; //外部调用函数
    function CreateTable(tb,CreaSQL,CreaIdxFields:string;ClearFlag:Boolean=true):Boolean;
    property ReckBegDate:TDate read FReckBegDate write SetReckBegDate; //核算区间开始日期（核算开始日期）
    property ReckEndDate:TDate read FReckEndDate write SetReckEndDate; //核算区间结束日期（核算结束日期）
    property iDbType:Integer read GetDbType;
    property FdbHelp:IdbHelp read dbHelp; //数据库访问接口
    property Params:TftParamList read FParams; //参数集对象
    property LastMth_Date: TDate read FLastMth_Date; //上一个结账日
    property TENANT_ID: integer read FTENANT_ID; //企业ID
    property USER_ID: string read FUSER_ID; //操作员ID
  end;

  //核算商品成本价、生成台账
  TCalcForGodsCost = class(TBaseCalc)
  private
    FCalc_Flag:integer;    //成本核算方法
    tempTabCost:string; //核算成本价
    tempTableOrder:string; //业务单据表(中间表)     
    FRckDays:integer;      //核算天数
    //初始化环境
    procedure CreateNew; override;
    //日结账检查是否存在盘点没有审核
    function CheckForRck:Boolean;
    //生成成本核算中间表SQL
    function GetRckTempTabSQL(tb:string):string;
    //清空本核算临时表
    procedure ClearRckTempTable(TabName:string);
    //生成核算成本价临时表SQL
    function GetCostPriceTmpSQL(tb:string):string;
    //创建成本核算临时表
    function CreateCostPriceTable(ClearFlag:Boolean=False):Boolean;
    //清空成本临时表
    procedure ClearCostTempTable(TabName:string);
  protected
    //删除本期间的商品日台账表流水
    function DeleteRckGodsData(DelFlag:Boolean=False):Boolean;
    //生成本区间核算临时表数据
    function CreateDataForRck:Boolean;
    //移动平均成本核算<按开单时的平均加计算>
    function Calc0:Boolean;
    //日加权移动平均成本核算
    function Calc1:Boolean;
    //月加权移动平均成本核算
    function Calc2:Boolean;
    //生成台账数据(RCK_GOODS_DAYS)
    function CreateRckForCalc(RckDate:TDate):Boolean;
    //生成本期间的客户商品台账(RCK_C_GOODS_DAYS)
    function CreateRckGodsForCust(RckDate:string=''):Boolean;
  public
    function DoCalcReck(Reck_Beg_Date,Reck_End_Date:TDate):Boolean;override; //日台账业务日期、核算天数
  end;

  //将核算成本价更新当前库存表
  TCalcForUpStroage = class(TBaseCalc)
  private
    //更新库存临时表
    tempTableUpStor:string;
    //创建临时表
    procedure CreateNew;override;
  public
    //计算更新库存
    function DoCalcUpdateStroage(UP_RECK_DATE:TDate):Boolean;
  end;

  //自动交班结账
  TCalcForPosReck = class(TBaseCalc)
  private
    rs:TZQuery;
    ss:TZQuery;
    ps:TZQuery;
  protected
    //取支付方式名称
    function GetPayment(s:string):string;
    //取人员所在部门ID
    function GetDeptID(TenID:integer;UserID:string):string;
    //取交班结账数据
    function OpenCloseForDay:Boolean;
    //插入交班交班结账记录
    function InsertRecordCloseForDay(ClsObj:TZQuery):Boolean;
    //插入应收账款记录
    function InsertRecordAccRecvAble:Boolean;
  public
    //创建临时表
    procedure CreateNew; override;
    destructor Destroy;override;
    function DoCalcReck(RckBeg_Date,RckEnd_Date:TDate):Boolean;override;
  end;

  //计算账款日台账
  TCalcForDayAcct = class(TBaseCalc)
  public
    function DoCalcReck(Rck_Beg_Date,Rck_End_Date:TDate):Boolean;override;
  end;

  //计算商品月台账
  TCalcForGodsMonth = class(TBaseCalc)
  private
    tempTableUpMonth:string;
    //创建临时表
    procedure CreateNew; override;
    //返回创建临时表的SQL
    function GetTempMonthSQL(tb: string): string;
    //清空临时表
    function CleanTempMonth:boolean;
  public
    //计算月台账
    function DoCalcReck(BegReckDate,EndReckDate:TDate):Boolean;override;
  end;

  //计算账款月台账
  TCalcForMonthAcct = class(TBaseCalc)
  public
    function DoCalcReck(RckBeg_Date,RckEnd_Date:TDate):Boolean;override;
  end;

  //计算分析数据
  TCalcForGodsAnaly = class(TBaseCalc)
  private
    //商品档案临时表
    tempTableGods:string;
    //门店临时表
    tempTableUpShop:string;
    //创建临时表
    procedure CreateNew; override;
    //返回创建临时表的SQL
    function GetTempAnalySQL(tb: string): string;
    //清除月台账记录
    procedure ClearAnalyTempTable(TabName:string);
    //返回商品档案临时表
    function GetTempGoodSQL(tb: string): string;
    //创建商品档案临时表
    function CreateGoodTable: Boolean;
    //清空临时表
    function CleanTempGodsAnaly:boolean;
  public
    //分析监控
    function DoCalcGodsAnaly: Boolean;
  end;

  //关账(日台账、月台账)
  TCalcForCloseReck = class(TBaseCalc)
  public
    function DoEndRckDaysClose(RCK_BEG_DATE,RCK_END_DATE:TDate):Boolean; //关账(日台账)
    function DoEndRckMonthClose(RCK_BEG_DATE,RCK_END_DATE:TDate):Boolean; //关账(月台账)
  end;

type
  //判断是否有同时在算台账
  TCheckCostCalc = class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  //计算商品日台账
  TCostCalc = class(TZProcFactory)
  private
    FdbHelp:IdbHelp;     //数据库访问接口
    FInParams:TftParamList; //参数集
    FUSER_ID:string;     //用户ID
    FTENANT_ID:integer;  //企业ID

    pt:integer;  
    Fcalc_flag: integer;
    FcDate: TDate;
    FeDate: TDate;
    FbDate: TDate;
    FmDate: TDate;
    reck_flag:integer;
    reck_day:integer;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
    property dbHelp:IdbHelp read FdbHelp;  //数据访问接口
    property InParams:TftParamList read FInParams; //传入参数
    property TENANT_ID:integer read FTENANT_ID; //企业ID
    property USER_ID:string read FUSER_ID;      //用户ID
    //核算方式 1日加权移动平均 2月加权移平均 3先进先出
    property calc_flag:integer read Fcalc_flag;
    //上次日结日期
    property cDate:TDate read FcDate;
    //本次结账日期
    property eDate:TDate read FeDate;
    //上次月结日期
    property bDate:TDate read FbDate;
    //最大日期
    property mDate:TDate read FmDate;
  end;

  //计算安全参数测算(对应原:flag=3)
  TCostCalcForAnalyLister = class(TCostCalc)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  //按日期进行计算日台账
  TCostCalcForDayReck = class(TCostCalc)
  private
    FBaseCalc: TBaseCalc;
    FDayReckClose: TCalcForCloseReck;
    FUpStroageCalc: TCalcForUpStroage;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  //按月份进行计算月台账
  TCostCalcForMonthReck = class(TCostCalc)
  private
    FBaseCalc: TBaseCalc;
    FMthReckClose: TCalcForCloseReck;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  
implementation

uses
  DateUtils,uFnUtil;

{ TBaseCalc }

procedure TBaseCalc.CreateNew;
begin

end;

function TBaseCalc.CreateTable(tb, CreaSQL, CreaIdxFields: string; ClearFlag: Boolean): Boolean;
var
  CreaIdxSQL:string;
  rs:TZQuery;
begin
  result:=False;
  CreaIdxSQL:='';
  if trim(CreaIdxFields)<>'' then
  begin
    case iDbType of
     4:CreaIdxSQL:='CREATE INDEX '+tb+'_IDX ON '+tb+'('+CreaIdxFields+')';
     else
       CreaIdxSQL:='CREATE INDEX IX_'+tb+'_IDX ON '+tb+'('+CreaIdxFields+')';
    end;
  end;
  case iDbType of
   0:
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text := 'select OBJECT_ID(N''tempdb..'+tb+''')';
        FdbHelp.Open(rs);
        if rs.Fields[0].AsString = '' then
        begin
          FdbHelp.ExecSQL(CreaSQL);
          if CreaIdxSQL<>'' then
            FdbHelp.ExecSQL(CreaIdxSQL);
        end;
      finally
        rs.Free;
      end;
    end;
  1:
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text := 'select count(*) from user_tables where table_name='''+tb+'''';
        FdbHelp.Open(rs);
        if rs.Fields[0].asInteger = 0 then
        begin
          FdbHelp.ExecSQL(CreaSQL);
          if CreaIdxSQL<>'' then
            FdbHelp.ExecSQL(CreaIdxSQL);
        end;
      finally
        rs.Free;
      end;
    end;
  4:
    begin
      FdbHelp.ExecSQL(CreaSQL);
      //if CreaIdxSQL<>'' then FdbHelp.ExecSQL(CreaIdxSQL);
    end;
  5:
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text := 'select count(*) from sqlite_master where type=''table'' and name='''+tb+'''';
        FdbHelp.Open(rs);
        if rs.Fields[0].asInteger = 0 then
        begin
          FdbHelp.ExecSQL(CreaSQL);
          if CreaIdxSQL<>'' then
            FdbHelp.ExecSQL(CreaIdxSQL);
        end;
      finally
        rs.Free;
      end;
    end;
  end;
  //清空临时表
  if ClearFlag then
  begin
    case iDbType of
     0,1:FdbHelp.ExecSQL('truncate table '+tb);
     5:FdbHelp.ExecSQL('delete from '+tb);
    end;
  end;
  result:=true;  
end;

function TBaseCalc.GetDbType: Integer;
begin
  result:=FdbHelp.iDbType;
end;

procedure TBaseCalc.SetInParams(AGlobal: IdbHelp; InParams: TftParamList;TEN_ID: integer; U_ID: string; LMth_Date: TDate);
begin
  dbHelp:=AGlobal;     //数据访问接口
  FParams:=InParams;   //参数集
  FTENANT_ID:=TEN_ID;  //企业ID
  FUSER_ID:=U_ID;      //操作员
  FLastMth_Date:=LMth_Date; //最后一次月结账日期
  CreateNew;
end;

procedure TBaseCalc.SetReckBegDate(const Value: TDate);
begin
  FReckBegDate := Value;
end;

procedure TBaseCalc.SetReckEndDate(const Value: TDate);
begin
  FReckEndDate := Value;
end;

function TBaseCalc.DoCalcReck(Reck_Beg_Date,Reck_End_Date: TDate): Boolean;
begin

end;

{ TCalcForGodsCost }

function TCalcForGodsCost.Calc0:Boolean;
var
  i,iError:integer;
  SQL:string;
  CurRckDate:TDate;
begin
  result:=False;
  iError:=0;
  //删除本区间日台账流水记录
  DeleteRckGodsData;

  //生成到台账表(RCK_GOODS_DAYS)每天1次生成
  for i:=0 to FRckDays do
  begin
    CurRckDate:=FReckBegDate+i;
    //if iDbType <> 5 then FdbHelp.BeginTrans;
    try
      //生成到台账表(RCK_GOODS_DAYS)每天1次生成
      SQL :=
        ParseSQL(iDbType,
          'insert into RCK_GOODS_DAYS('+
            'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
            'ORG_AMT,ORG_CST,'+
            'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
            'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
            'DBIN_AMT,DBIN_CST,'+
            'DBOUT_AMT,DBOUT_CST,'+
            'CHANGE1_AMT,CHANGE1_CST,'+
            'CHANGE2_AMT,CHANGE2_CST,'+
            'CHANGE3_AMT,CHANGE3_CST,'+
            'CHANGE4_AMT,CHANGE4_CST,'+
            'CHANGE5_AMT,CHANGE5_CST,'+
            'BAL_AMT,BAL_CST,COMM,TIME_STAMP '+
          ') '+
          'select '+
            ' '+inttostr(TENANT_ID)+' as TENANT_ID,SHOP_ID,'+FormatDatetime('YYYYMMDD',CurRckDate)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
            'round(sum(case when ORDER_TYPE=0 then RCK_AMT else 0 end),3)as ORG_AMT,'+
            'round(sum(case when ORDER_TYPE=0 then RCK_CST else 0 end),2)as ORG_CST,'+
            'round(sum(case when ORDER_TYPE in (11,13) then RCK_AMT else 0 end),3)as STOCK_AMT,'+
            'round(sum(case when ORDER_TYPE in (11,13) then RCK_MNY else 0 end),2)as STOCK_MNY,'+
            'round(sum(case when ORDER_TYPE in (11,13) then RCK_TAX else 0 end),2)as STOCK_TAX,'+
            'round(sum(case when ORDER_TYPE in (11,13) then RCK_AGO else 0 end),2)as STOCK_AGO,'+
            'round(sum(case when ORDER_TYPE=13 then RCK_AMT else 0 end),3)as STKRT_AMT,'+
            'round(sum(case when ORDER_TYPE=13 then RCK_MNY else 0 end),2)as STKRT_MNY,'+
            'round(sum(case when ORDER_TYPE=13 then RCK_TAX else 0 end),2)as STKRT_TAX,'+
            'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_AMT else 0 end),3)as SALE_AMT,'+
            'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_RTL else 0 end),3)as RCK_RTL,'+
            'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_AGO else 0 end),2)as SALE_AGO,'+
            'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_MNY else 0 end),2)as SALE_MNY,'+
            'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_TAX else 0 end),2)as SALE_TAX,'+
            'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_CST else 0 end),2)as SALE_CST,'+
            'round(case when cast(sum(case when ORDER_TYPE in (21,23,24) then RCK_AMT else 0 end)as decimal(18,3))<>0 then '+
                 ' sum(case when ORDER_TYPE in (21,23,24) then RCK_CST else 0 end)*1.000000/cast(sum(case when ORDER_TYPE in (21,23,24) then RCK_AMT else 0 end)as decimal(18,3)) '+
                 ' else 0 end,6)as COST_PRICE,'+
            'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_PRF else 0 end),2)as SALE_PRF,'+
            'round(sum(case when ORDER_TYPE=23 then RCK_AMT else 0 end),3)as SALRT_AMT,'+
            'round(sum(case when ORDER_TYPE=23 then RCK_MNY else 0 end),2)as SALRT_MNY,'+
            'round(sum(case when ORDER_TYPE=23 then RCK_TAX else 0 end),2)as SALRT_TAX,'+
            'round(sum(case when ORDER_TYPE=23 then RCK_CST else 0 end),2)as SALRT_CST,'+
            'round(sum(case when ORDER_TYPE=12 then RCK_AMT else 0 end),3)as DBIN_AMT,'+
            'round(sum(case when ORDER_TYPE=12 then RCK_CST else 0 end),2)as DBIN_CST,'+
            'round(sum(case when ORDER_TYPE=22 then RCK_AMT else 0 end),3)as DBOUT_AMT,'+
            'round(sum(case when ORDER_TYPE=22 then RCK_CST else 0 end),2)as DBOUT_CST,'+
            'round(sum(case when ORDER_TYPE=31 then RCK_AMT else 0 end),3)as CHANGE1_AMT,'+
            'round(sum(case when ORDER_TYPE=31 then RCK_CST else 0 end),2)as CHANGE1_CST,'+
            'round(sum(case when ORDER_TYPE=32 then RCK_AMT else 0 end),3)as CHANGE2_AMT,'+
            'round(sum(case when ORDER_TYPE=32 then RCK_CST else 0 end),2)as CHANGE2_CST,'+
            'round(sum(case when ORDER_TYPE=33 then RCK_AMT else 0 end),3)as CHANGE3_AMT,'+
            'round(sum(case when ORDER_TYPE=33 then RCK_CST else 0 end),2)as CHANGE3_CST,'+
            'round(sum(case when ORDER_TYPE=34 then RCK_AMT else 0 end),3)as CHANGE4_AMT,'+
            'round(sum(case when ORDER_TYPE=34 then RCK_CST else 0 end),2)as CHANGE4_CST,'+
            'round(sum(case when ORDER_TYPE=35 then RCK_AMT else 0 end),3)as CHANGE5_AMT,'+
            'round(sum(case when ORDER_TYPE=35 then RCK_CST else 0 end),2)as CHANGE5_CST,'+
            'round(sum(case when ORDER_TYPE in (0,11,12,13,31,32,33,34,35) then RCK_AMT else round(-1.000000*RCK_AMT,3) end),3)as BAL_AMT,'+
            'round(sum(case when ORDER_TYPE in (11,13) then RCK_MNY '+  //购进成本
                          ' when ORDER_TYPE in (0,12,31,32,33,34,35) then RCK_CST '+ //期初、调入成本、调整成本
                          ' when ORDER_TYPE in (21,22,23,24) then round(-1.000000*RCK_CST,2) '+      //销售成本负数
                          ' else 0 end),2)as BAL_CST,'+
            '''00'' as COMM,'+GetTimeStamp(iDbType)+' '+
          ' from '+
          '(select TENANT_ID,SHOP_ID,CREA_DATE,ORDER_TYPE,GODS_ID,BATCH_NO,RCK_AMT,RCK_MNY,RCK_CST,RCK_TAX,RCK_RTL,RCK_PRF,RCK_AGO,COST_PRICE '+
          ' from '+tempTableOrder+' where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE='+FormatDatetime('YYYYMMDD',CurRckDate)+' '+
          ' union all '+
          ' select TENANT_ID,SHOP_ID,CREA_DATE,0 as ORDER_TYPE,GODS_ID,BATCH_NO,BAL_AMT as RCK_AMT,0 as RCK_MNY,BAL_CST as RCK_CST,0 as RCK_TAX,0 as RCK_RTL,0 as RCK_PRF,0 as RCK_AGO,0 as COST_PRICE '+
          ' from RCK_GOODS_DAYS where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE='+FormatDatetime('YYYYMMDD',(CurRckDate-1))+' and (BAL_AMT<>0 or BAL_CST<>0)'+
          ')A '+
          ' group by SHOP_ID,GODS_ID,BATCH_NO'
        );
      FdbHelp.ExecSQL(SQL);
      //if iDbType <> 5 then FdbHelp.CommitTrans;
    except
      //if iDbType <> 5 then FdbHelp.RollbackTrans;
      Inc(iError);
      Raise;
    end;
  end;
  
  //生成到商品台账表(RCK_C_GOODS_DAYS)[根据VIW_SALESDATA]
  if iError=0 then
    result:=CreateRckGodsForCust;
end;

function TCalcForGodsCost.Calc1:Boolean;
var
  i,iError:integer;
  SQL:string;
  CurRckDate:TDate;
begin
  result:=False;
  iError:=0;
  //1、创建成本临时表
  if iDbType<>4 then CreateCostPriceTable(False); //DB2不需清楚，直接声明即可

  //2、删除本区间日台账流水记录
  DeleteRckGodsData;
                    
  //3、循环迭代计算每天成本
  for i:=0 to FRckDays do
  begin
    CurRckDate:=FReckBegDate+i;
    //A、清空成本价临时表
    ClearCostTempTable(tempTabCost);

    //B、核算成本生成(生成成本价)
    SQL:=
      'insert into '+tempTabCost+'(GODS_ID,BATCH_NO,COST_PRICE)'+
      'select GODS_ID,BATCH_NO,'+
      '(case when (cast(sum(ORG_AMT)as decimal(18,3))*1.000000)<>0 then round(cast(sum(ORG_CST)as decimal(18,3))/(cast(sum(ORG_AMT)as decimal(18,3))*1.000000),6) else 0.0 end)as COST_PRICE '+
      ' from '+
      '(select GODS_ID,BATCH_NO,sum(BAL_AMT)as ORG_AMT,sum(BAL_CST)as ORG_CST from RCK_GOODS_DAYS '+
      ' where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',(CurRckDate-1))+' and (BAL_AMT<>0 or BAL_CST<>0) '+
      ' group by GODS_ID,BATCH_NO '+
      ' union all '+
      ' select GODS_ID,BATCH_NO,sum(RCK_AMT)as ORG_AMT,sum(RCK_MNY) as ORG_CST from '+tempTableOrder+' '+
      ' where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',CurRckDate)+' and ORDER_TYPE in (11,13)'+
      ' group by GODS_ID,BATCH_NO)A '+
      ' group by GODS_ID,BATCH_NO';
    FdbHelp.ExecSQL(SQL);

    //C、逐天生成台账记录
    if not CreateRckForCalc(CurRckDate) then Inc(iError);

    //D、生成到商品台账表(RCK_C_GOODS_DAYS)[根据VIW_SALESDATA]
    if not CreateRckGodsForCust(FormatDatetime('YYYYMMDD',CurRckDate)) then Inc(iError);
  end;
  result:=(iError=0);
end;

function TCalcForGodsCost.Calc2:Boolean;
var
  i,iError:integer;
  SQL:string;
  CurRckDate:TDate;
begin
  result:=False;
  iError:=0;
  //1、创建成本临时表
  CreateCostPriceTable(True);
  //2、删除本区间日台账流水记录
  DeleteRckGodsData(True);

  //3、核算成本价(核算一个月成本价)
  SQL:=
    'insert into '+tempTabCost+'(GODS_ID,BATCH_NO,COST_PRICE)'+
    'select GODS_ID,BATCH_NO,'+
    '(case when cast(sum(ORG_AMT) as decimal(18,3))<>0 then round(cast(sum(ORG_CST)as decimal(18,3))/(cast(sum(ORG_AMT)as decimal(18,3))*1.000000),6) else 0.0 end)as COST_PRICE '+
    ' from '+
    '(select GODS_ID,BATCH_NO,sum(BAL_AMT)as ORG_AMT,sum(BAL_CST)as ORG_CST from RCK_GOODS_DAYS '+
    ' where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE='+FormatDatetime('YYYYMMDD',(FReckBegDate-1))+' and (BAL_AMT<>0 or BAL_CST<>0) '+
    ' group by GODS_ID,BATCH_NO '+
    ' union all '+
    ' select GODS_ID,BATCH_NO,sum(RCK_AMT)as ORG_AMT,sum(RCK_MNY) as ORG_CST from '+tempTableOrder+' '+
    ' where TENANT_ID='+inttostr(TENANT_ID)+' and ORDER_TYPE in (11,13) group by GODS_ID,BATCH_NO)A '+
    ' group by GODS_ID,BATCH_NO ';
  FdbHelp.ExecSQL(SQL);

  //4、循环迭代生成日台账
  for i:=0 to FRckDays do
  begin
    CurRckDate:=FReckBegDate+i;
    //逐天生成台账记录
    if not CreateRckForCalc(CurRckDate) then Inc(iError);
  end;
  
  //5、生成到商品台账表(RCK_C_GOODS_DAYS)[根据VIW_SALESDATA]
  if iError=0 then
    result:=CreateRckGodsForCust;
end;

function TCalcForGodsCost.CreateRckForCalc(RckDate:TDate):Boolean;
var
  SQL:string;
  VIW_GODS_DAYS:string;
begin
  result:=False;
  VIW_GODS_DAYS:=
    'select TENANT_ID,SHOP_ID,CREA_DATE,ORDER_TYPE,A.GODS_ID,A.BATCH_NO,RCK_AMT,RCK_MNY,'+
    '(case when ORDER_TYPE in (12,21,22,23,24,31,32,33,34,35) then round(RCK_AMT*isnull(B.COST_PRICE,0),2) else RCK_CST end) as RCK_CST,'+
    ' RCK_TAX,RCK_RTL,'+
    '(case when ORDER_TYPE in (21,23,24) then RCK_MNY - round(RCK_AMT*isnull(B.COST_PRICE,0),2) else RCK_PRF end) as RCK_PRF,'+  //毛利计算
    ' RCK_AGO,A.COST_PRICE '+
    ' from '+tempTableOrder+' A '+
    ' left outer join '+tempTabCost+' B ON A.GODS_ID=B.GODS_ID and A.BATCH_NO=B.BATCH_NO '+
    ' where A.TENANT_ID='+inttostr(TENANT_ID)+' and A.CREA_DATE='+FormatDatetime('YYYYMMDD',RckDate)+' '+
    ' union all '+
    ' select TENANT_ID,SHOP_ID,CREA_DATE,0 as ORDER_TYPE,GODS_ID,BATCH_NO,BAL_AMT as RCK_AMT,0 as RCK_MNY,BAL_CST as RCK_CST,0 as RCK_TAX,0 as RCK_RTL,0 as RCK_PRF,0 as RCK_AGO,0 as COST_PRICE '+
    ' from RCK_GOODS_DAYS where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE='+FormatDatetime('YYYYMMDD',(RckDate-1))+' and (BAL_AMT<>0 or BAL_CST<>0)';

  //生成到台账表(RCK_GOODS_DAYS)每天1次生成
  SQL:=ParseSQL(iDbType,
    'insert into RCK_GOODS_DAYS('+
      'TENANT_ID,SHOP_ID,CREA_DATE,GODS_ID,BATCH_NO,'+
      'ORG_AMT,ORG_CST,'+
      'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
      'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
      'DBIN_AMT,DBIN_CST,'+
      'DBOUT_AMT,DBOUT_CST,'+
      'CHANGE1_AMT,CHANGE1_CST,'+
      'CHANGE2_AMT,CHANGE2_CST,'+
      'CHANGE3_AMT,CHANGE3_CST,'+
      'CHANGE4_AMT,CHANGE4_CST,'+
      'CHANGE5_AMT,CHANGE5_CST,'+
      'BAL_AMT,BAL_CST,COMM,TIME_STAMP '+
    ') '+
    'select '+
      ' '+inttostr(TENANT_ID)+' as TENANT_ID,SHOP_ID,'+FormatDatetime('YYYYMMDD',RckDate)+' as CREA_DATE,GODS_ID,BATCH_NO,'+
      'round(sum(case when ORDER_TYPE=0 then RCK_AMT else 0 end),3)as ORG_AMT,'+
      'round(sum(case when ORDER_TYPE=0 then RCK_CST else 0 end),2)as ORG_CST,'+
      'round(sum(case when ORDER_TYPE in (11,13) then RCK_AMT else 0 end),3)as STOCK_AMT,'+
      'round(sum(case when ORDER_TYPE in (11,13) then RCK_MNY else 0 end),2)as STOCK_MNY,'+
      'round(sum(case when ORDER_TYPE in (11,13) then RCK_TAX else 0 end),2)as STOCK_TAX,'+
      'round(sum(case when ORDER_TYPE in (11,13) then RCK_AGO else 0 end),2)as STOCK_AGO,'+
      'round(sum(case when ORDER_TYPE=13 then RCK_AMT else 0 end),3)as STKRT_AMT,'+
      'round(sum(case when ORDER_TYPE=13 then RCK_MNY else 0 end),2)as STKRT_MNY,'+
      'round(sum(case when ORDER_TYPE=13 then RCK_TAX else 0 end),2)as STKRT_TAX,'+
      'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_AMT else 0 end),3)as SALE_AMT,'+
      'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_RTL else 0 end),3)as RCK_RTL,'+
      'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_AGO else 0 end),2)as SALE_AGO,'+
      'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_MNY else 0 end),2)as SALE_MNY,'+
      'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_TAX else 0 end),2)as SALE_TAX,'+
      'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_CST else 0 end),2)as SALE_CST,'+
      'round(case when cast(sum(case when ORDER_TYPE in (21,23,24) then RCK_AMT else 0 end)as decimal(18,3))<>0 then '+
           ' sum(case when ORDER_TYPE in (21,23,24) then RCK_CST else 0 end)*1.000000/cast(sum(case when ORDER_TYPE in (21,23,24) then RCK_AMT else 0 end)as decimal(18,3)) '+
           ' else 0 end,6)as COST_PRICE,'+
      'round(sum(case when ORDER_TYPE in (21,23,24) then RCK_PRF else 0 end),2)as SALE_PRF,'+
      'round(sum(case when ORDER_TYPE=23 then RCK_AMT else 0 end),3)as SALRT_AMT,'+
      'round(sum(case when ORDER_TYPE=23 then RCK_MNY else 0 end),2)as SALRT_MNY,'+
      'round(sum(case when ORDER_TYPE=23 then RCK_TAX else 0 end),2)as SALRT_TAX,'+
      'round(sum(case when ORDER_TYPE=23 then RCK_CST else 0 end),2)as SALRT_CST,'+
      'round(sum(case when ORDER_TYPE=12 then RCK_AMT else 0 end),3)as DBIN_AMT,'+
      'round(sum(case when ORDER_TYPE=12 then RCK_CST else 0 end),2)as DBIN_CST,'+
      'round(sum(case when ORDER_TYPE=22 then RCK_AMT else 0 end),3)as DBOUT_AMT,'+
      'round(sum(case when ORDER_TYPE=22 then RCK_CST else 0 end),2)as DBOUT_CST,'+
      'round(sum(case when ORDER_TYPE=31 then RCK_AMT else 0 end),3)as CHANGE1_AMT,'+
      'round(sum(case when ORDER_TYPE=31 then RCK_CST else 0 end),2)as CHANGE1_CST,'+
      'round(sum(case when ORDER_TYPE=32 then RCK_AMT else 0 end),3)as CHANGE2_AMT,'+
      'round(sum(case when ORDER_TYPE=32 then RCK_CST else 0 end),2)as CHANGE2_CST,'+
      'round(sum(case when ORDER_TYPE=33 then RCK_AMT else 0 end),3)as CHANGE3_AMT,'+
      'round(sum(case when ORDER_TYPE=33 then RCK_CST else 0 end),2)as CHANGE3_CST,'+
      'round(sum(case when ORDER_TYPE=34 then RCK_AMT else 0 end),3)as CHANGE4_AMT,'+
      'round(sum(case when ORDER_TYPE=34 then RCK_CST else 0 end),2)as CHANGE4_CST,'+
      'round(sum(case when ORDER_TYPE=35 then RCK_AMT else 0 end),3)as CHANGE5_AMT,'+
      'round(sum(case when ORDER_TYPE=35 then RCK_CST else 0 end),2)as CHANGE5_CST,'+
      'round(sum(case when ORDER_TYPE in (0,11,12,13,31,32,33,34,35) then RCK_AMT else round(-1.000000*RCK_AMT,3) end),3)as BAL_AMT,'+
      'round(sum(case when ORDER_TYPE in (11,13) then RCK_MNY '+  //购进成本
                    ' when ORDER_TYPE in (0,12,31,32,33,34,35) then RCK_CST '+ //期初、调入成本、调整成本
                    ' when ORDER_TYPE in (21,22,23,24) then round(-1.000000*RCK_CST,2) '+      //销售成本负数
                    ' else 0 end),2)as BAL_CST,'+
      '''00'' as COMM,'+GetTimeStamp(iDbType)+' '+
    ' from ('+VIW_GODS_DAYS+')TP '+
    ' group by SHOP_ID,GODS_ID,BATCH_NO'
    );

  //if iDbType <> 5 then FdbHelp.BeginTrans;
  try
    FdbHelp.ExecSQL(SQL);
    //if iDbType <> 5 then FdbHelp.CommitTrans;
    result:=true;
  except
    //if iDbType <> 5 then FdbHelp.RollbackTrans;
    Raise;
  end;
end;


function TCalcForGodsCost.DoCalcReck(Reck_Beg_Date,Reck_End_Date:TDate): Boolean;
begin
  result:=False;
  //读取成本类型
  if FParams.FindParam('CALC_FLAG')=nil then Raise Exception.Create('无效成本核算类型...');
  FCalc_Flag:=FParams.ParamByName('CALC_FLAG').AsInteger;

  ReckBegDate:=Reck_Beg_Date; //台账开始日期
  ReckEndDate:=Reck_End_Date; //台账结束日期
  FRckDays:=Round(Reck_End_Date-Reck_Beg_Date); //计算循环天数

  try
    //1、生成本区间核算临时表数据
    CreateDataForRck;

    //2、核算商品成本
    case FCalc_Flag of
     0:result:=Calc0;
     1:result:=Calc1;
     2:result:=Calc2;
    end;
  finally
    try
      ClearRckTempTable(tempTableOrder);
      ClearCostTempTable(tempTabCost);
    except
    end;
  end;
end;

procedure TCalcForGodsCost.CreateNew;
var
  FLAG_IDX:integer;
  TabSQL:string;
  rs:TZQuery;
begin
  inherited;
  //判断是否有存在盘点未审核
  FLAG_IDX:=FParams.ParamByName('FLAG').AsInteger;
  if FLAG_IDX in [1,2] then CheckForRck; //结账时才做判断

  //生成单据台账中间表(按区间生成[1月份])
  case iDbType of
   0:tempTableOrder := '#T_ORDER_DAYS';
   1,5:tempTableOrder := 'T_ORDER_DAYS';
   4:tempTableOrder := 'session.T_ORDER_DAYS';
  end;
  TabSQL:=GetRckTempTabSQL(tempTableOrder);
  CreateTable(tempTableOrder,TabSQL,'TENANT_ID,CREA_DATE',True);

  //成本表
  case iDbType of
   0:tempTabCost := '#TMP_COST';
   1,5:tempTabCost := 'TMP_COST';
   4:tempTabCost := 'session.TMP_COST';
  end;  
end;

function TCalcForGodsCost.GetCostPriceTmpSQL(tb: string): string;
begin
  result:='';
  case iDbType of
   0,5:result :=
      'CREATE TABLE '+tb+' ('+
      '	GODS_ID varchar (36)  NOT NULL ,'+
      '	BATCH_NO varchar (36) NOT NULL ,'+
      '	COST_PRICE decimal(18, 6) NULL '+
      ')';
   1:result :=
      'create global temporary table '+tb+' ('+
      ' GODS_ID varchar2(36)  NOT NULL ,'+
      ' BATCH_NO varchar2(36) NOT NULL ,'+
      '	COST_PRICE decimal(18, 6) '+
      ') ON COMMIT PRESERVE ROWS';
  4:result :=
      'declare global temporary table '+tb+' ('+
      '	GODS_ID varchar (36)  NOT NULL ,'+
      '	BATCH_NO varchar (36) NOT NULL ,'+
      '	COST_PRICE decimal(18, 6) '+
      ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
  end;
end;

function TCalcForGodsCost.CreateCostPriceTable(ClearFlag:Boolean): Boolean;
var
  TabSQL:string;
begin
  result:=False;
  TabSQL:=GetCostPriceTmpSQL(tempTabCost);
  CreateTable(tempTabCost,TabSQL,'GODS_ID,BATCH_NO',False);

  //先清空临时表
  if ClearFlag then
  begin
    case iDbType of
     0,1:FdbHelp.ExecSQL('truncate table '+tempTabCost);
     5:FdbHelp.ExecSQL('delete from '+tempTabCost);
    end;
  end;
end;

function TCalcForGodsCost.CreateDataForRck: Boolean;
var
  SQL,DateCnd:string;
begin
  result:=False;
  //临时表在判断创建自动清除数据

  //1、插入STK_STOCKORDER(1:入库;2:调拨入库;3:入库退货)
  if FReckBegDate = FReckEndDate then
    DateCnd:=' and B.STOCK_DATE='+FormatDatetime('YYYYMMDD',FReckBegDate)
  else
    DateCnd:=' and B.STOCK_DATE>='+FormatDatetime('YYYYMMDD',FReckBegDate)+' and B.STOCK_DATE<='+FormatDatetime('YYYYMMDD',FReckEndDate);
  SQL:=
    'insert into '+tempTableOrder+'(TENANT_ID,SHOP_ID,CREA_DATE,ORDER_TYPE,GODS_ID,BATCH_NO,RCK_AMT,RCK_MNY,RCK_CST,RCK_TAX,RCK_RTL,RCK_PRF,RCK_AGO,COST_PRICE)'+
    'select B.TENANT_ID,B.SHOP_ID,B.STOCK_DATE,(B.STOCK_TYPE+10) as ORDER_TYPE,A.GODS_ID,A.BATCH_NO,'+
    ' CALC_AMOUNT as RCK_AMT,'+
    ' round(case when STOCK_TYPE=2 then 0 '+
               ' else A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end),2)'+
               ' end,2)as RCK_MNY,'+
    ' round(case when STOCK_TYPE=2 then A.CALC_MONEY else 0 end,2)as RCK_CST,'+
    ' round(case when STOCK_TYPE=2 then 0 '+
               ' else A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG=''3'' then A.TAX_RATE else 0 end)'+
               ' end,2)as RCK_TAX,'+
    ' 0 as RCK_RTL,'+
    ' 0 as RCK_PRF,'+
    ' 0 as RCK_AGO,'+
    ' 0 as COST_PRICE '+
    ' from STK_STOCKDATA A,STK_STOCKORDER B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.STOCK_ID=B.STOCK_ID and B.TENANT_ID='+IntToStr(TENANT_ID)+' '+DateCnd;
  FdbHelp.ExecSQL(SQL);

  //2、插入SAL_SALESORDER(1:销售出货;2:调拨出库;3:销售退货;4:零售)
  if FReckBegDate = FReckEndDate then
    DateCnd:=' and B.SALES_DATE='+FormatDatetime('YYYYMMDD',FReckBegDate)
  else
    DateCnd:=' and B.SALES_DATE>='+FormatDatetime('YYYYMMDD',FReckBegDate)+' and B.SALES_DATE<='+FormatDatetime('YYYYMMDD',FReckEndDate);
  SQL:=
    'insert into '+tempTableOrder+'(TENANT_ID,SHOP_ID,CREA_DATE,ORDER_TYPE,GODS_ID,BATCH_NO,RCK_AMT,RCK_MNY,RCK_CST,RCK_TAX,RCK_RTL,RCK_PRF,RCK_AGO,COST_PRICE)'+
    'select B.TENANT_ID,B.SHOP_ID,B.SALES_DATE,(B.SALES_TYPE+20) as ORDER_TYPE,A.GODS_ID,A.BATCH_NO,'+
    ' CALC_AMOUNT as RCK_AMT,'+
    ' round(case when SALES_TYPE=2 then 0 '+
               ' else A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2) '+
               ' end,2)as RCK_MNY,'+
    ' round(A.CALC_AMOUNT*A.COST_PRICE,2)as RCK_CST,'+
    ' round(case when SALES_TYPE=2 then 0 '+
               ' else round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2) '+
               ' end,2)as RCK_TAX,'+
    ' round(case when SALES_TYPE=2 then 0 else A.CALC_MONEY+A.AGIO_MONEY end,2)as RCK_RTL,'+
    ' round(case when SALES_TYPE=2 then 0 '+
               ' else A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2)-round(A.CALC_AMOUNT*A.COST_PRICE,2) end,2)as RCK_PRF,'+
    ' A.AGIO_MONEY as RCK_AGO,'+
    ' 0 as COST_PRICE '+
    ' from SAL_SALESDATA A,SAL_SALESORDER B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and B.TENANT_ID='+IntToStr(TENANT_ID)+' '+DateCnd;
  FdbHelp.ExecSQL(SQL);

  //3、插入STO_CHANGEORDER(1:损益单;2:领用单)
  if FReckBegDate = FReckEndDate then
    DateCnd:=' and B.CHANGE_DATE='+FormatDatetime('YYYYMMDD',FReckBegDate)
  else
    DateCnd:=' and B.CHANGE_DATE>='+FormatDatetime('YYYYMMDD',FReckBegDate)+' and B.CHANGE_DATE<='+FormatDatetime('YYYYMMDD',FReckEndDate);
  SQL:=
    'insert into '+tempTableOrder+'(TENANT_ID,SHOP_ID,CREA_DATE,ORDER_TYPE,GODS_ID,BATCH_NO,RCK_AMT,RCK_MNY,RCK_CST,RCK_TAX,RCK_RTL,RCK_PRF,RCK_AGO,COST_PRICE)'+
    'select B.TENANT_ID,B.SHOP_ID,B.CHANGE_DATE,'+
    '(case when B.CHANGE_CODE=''1'' then 31 when B.CHANGE_CODE=''2'' then 32 when B.CHANGE_CODE=''3'' then 33 '+
         ' when B.CHANGE_CODE=''4'' then 34 when B.CHANGE_CODE=''5'' then 35 else 30 end)as ORDER_TYPE,GODS_ID,BATCH_NO,'+
    ' (case when B.CHANGE_TYPE=''1'' then 1 else -1 end)*A.CALC_AMOUNT as RCK_AMT,'+
    ' 0 as RCK_MNY, '+
    ' (case when B.CHANGE_TYPE=''1'' then 1 else -1 end)*round(A.CALC_AMOUNT*A.COST_PRICE,2) as RCK_CST,'+
    ' 0 as RCK_TAX,'+
    ' 0 as RCK_RTL,'+
    ' 0 as RCK_PRF,'+
    ' 0 as RCK_AGO,'+
    ' 0 as COST_PRICE '+
    ' from STO_CHANGEDATA A,STO_CHANGEORDER B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.CHANGE_ID=B.CHANGE_ID and B.TENANT_ID='+IntToStr(TENANT_ID)+' '+DateCnd;
  FdbHelp.ExecSQL(SQL);
  result:=true;
end;

function TCalcForGodsCost.DeleteRckGodsData(DelFlag:Boolean): Boolean;
var
  SQL:string;
begin
  result:=False;
  if FReckBegDate = FReckEndDate then
    SQL := ' where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE='+FormatDatetime('YYYYMMDD',FReckBegDate)+' '
  else
    SQL := ' where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE>='+FormatDatetime('YYYYMMDD',FReckBegDate)+' and CREA_DATE<='+FormatDatetime('YYYYMMDD',FReckEndDate)+' ';
  if DelFlag then
    FdbHelp.ExecSQL('delete from RCK_DAYS_CLOSE where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE>='+FormatDatetime('YYYYMMDD',FReckBegDate));
  FdbHelp.ExecSQL('delete from RCK_GOODS_DAYS '+SQL);
  FdbHelp.ExecSQL('delete from RCK_C_GOODS_DAYS '+SQL);
  result:=true;
end;

function TCalcForGodsCost.CreateRckGodsForCust(RckDate:string=''): Boolean;
var
  SQL:string;
  SQLCnd:string;
begin
  result:=False;
  case FCalc_Flag of
   0:
    begin
      if FReckBegDate = FReckEndDate then
        SQLCnd:=' and B.SALES_DATE='+FormatDatetime('YYYYMMDD',FReckBegDate)
      else
        SQLCnd:=' and B.SALES_DATE>='+FormatDatetime('YYYYMMDD',FReckBegDate)+' and B.SALES_DATE<='+FormatDatetime('YYYYMMDD',FReckEndDate);
      SQL:=
        ParseSQL(iDbType,
          'insert into RCK_C_GOODS_DAYS('+
              'TENANT_ID,SHOP_ID,DEPT_ID,GUIDE_USER,SALES_STYLE,CLIENT_ID,CREA_DATE,GODS_ID,BATCH_NO,IS_PRESENT,'+
              'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,COMM,TIME_STAMP) '+
          'select B.TENANT_ID,B.SHOP_ID,'+
              'case when B.DEPT_ID is null then ''#'' else B.DEPT_ID end,'+
              'case when B.GUIDE_USER is null then ''#'' else B.GUIDE_USER end,'+
              'case when B.SALES_STYLE is null then ''#'' else B.SALES_STYLE end,'+
              'case when B.CLIENT_ID is null then ''#'' else B.CLIENT_ID end,'+
              'B.SALES_DATE,A.GODS_ID,A.BATCH_NO,A.IS_PRESENT, '+
              'sum(A.CALC_AMOUNT) as SALE_AMT,sum(A.CALC_MONEY+A.AGIO_MONEY) as SALE_RTL,sum(A.AGIO_MONEY) as SALE_AGO,'+
              'sum(A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2))as SALE_MNY,'+
              'sum(round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2)) as SALE_TAX, '+
              'sum(round(A.CALC_AMOUNT*isnull(A.COST_PRICE,0),2)) as SALE_CST,'+
              'round(case when sum(A.CALC_AMOUNT)<>0 then sum(A.CALC_AMOUNT*isnull(A.COST_PRICE,0))*1.0000/sum(A.CALC_AMOUNT) else 0 end,6) as COST_PRICE, '+
              'sum(A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2)'+
                  '-round(A.CALC_AMOUNT*isnull(A.COST_PRICE,0),2)) as SALE_PRF, '+
              'sum(case when B.SALES_TYPE=3 then A.CALC_AMOUNT else 0 end) as SALRT_AMT, '+
              'sum(case when B.SALES_TYPE=3 then A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2) else 0 end) as SALRT_MNY, '+
              'sum(case when B.SALES_TYPE=3 then round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2) else 0 end) as SALRT_TAX, '+
              'sum(case when B.SALES_TYPE=3 then round(A.CALC_AMOUNT*isnull(A.COST_PRICE,0),2) else 0 end) as SALRT_CST, '+
              '''00'','+GetTimeStamp(iDbType)+' '+
          ' from SAL_SALESDATA A,SAL_SALESORDER B '+
          ' where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and B.TENANT_ID='+inttostr(TENANT_ID)+' '+SQLCnd+' and B.SALES_TYPE in (1,3,4) '+
          ' group by B.TENANT_ID,B.SHOP_ID,B.DEPT_ID,'+
              'case when B.GUIDE_USER is null then ''#'' else B.GUIDE_USER end,'+
              'case when B.SALES_STYLE is null then ''#'' else B.SALES_STYLE end,'+
              'case when B.CLIENT_ID is null then ''#'' else B.CLIENT_ID end,'+
              'B.SALES_DATE,A.GODS_ID,A.BATCH_NO,A.IS_PRESENT'
        );
      FdbHelp.ExecSQL(SQL);
      result:=true;
    end;
   1,2:
    begin
      case FCalc_Flag of
       1: SQLCnd:=' and B.SALES_DATE='+RckDate+' ';
       2:
        begin
          if FReckBegDate = FReckEndDate then
            SQLCnd:=' and B.SALES_DATE='+FormatDatetime('YYYYMMDD',FReckBegDate)
          else
            SQLCnd:=' and B.SALES_DATE>='+FormatDatetime('YYYYMMDD',FReckBegDate)+' and B.SALES_DATE<='+FormatDatetime('YYYYMMDD',FReckEndDate)+' ';
        end;
      end;
      SQL:=
        ParseSQL(iDbType,
          'insert into RCK_C_GOODS_DAYS('+
              'TENANT_ID,SHOP_ID,DEPT_ID,GUIDE_USER,SALES_STYLE,CLIENT_ID,CREA_DATE,GODS_ID,BATCH_NO,IS_PRESENT,'+
              'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,COST_PRICE,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,COMM,TIME_STAMP) '+
          'select B.TENANT_ID,B.SHOP_ID,'+
              'case when B.DEPT_ID is null then ''#'' else B.DEPT_ID end,'+
              'case when B.GUIDE_USER is null then ''#'' else B.GUIDE_USER end,'+
              'case when B.SALES_STYLE is null then ''#'' else B.SALES_STYLE end,'+
              'case when B.CLIENT_ID is null then ''#'' else B.CLIENT_ID end,'+
              'B.SALES_DATE,A.GODS_ID,A.BATCH_NO,A.IS_PRESENT, '+
              'sum(A.CALC_AMOUNT) as SALE_AMT,sum(A.CALC_MONEY+A.AGIO_MONEY) as SALE_RTL,sum(A.AGIO_MONEY) as SALE_AGO,'+
              'sum(A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2))as SALE_MNY,'+
              'sum(round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2)) as SALE_TAX, '+
              'sum(round(A.CALC_AMOUNT*isnull(C.COST_PRICE,0),2)) as SALE_CST,'+
              'max(C.COST_PRICE) as COST_PRICE, '+
              'sum(A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2)'+
                  '-round(A.CALC_AMOUNT*isnull(C.COST_PRICE,0),2)) as SALE_PRF, '+
              'sum(case when B.SALES_TYPE=3 then A.CALC_AMOUNT else 0 end) as SALRT_AMT, '+
              'sum(case when B.SALES_TYPE=3 then A.CALC_MONEY-round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2) else 0 end) as SALRT_MNY, '+
              'sum(case when B.SALES_TYPE=3 then round(A.CALC_MONEY*1.000/(1+case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end)*(case when B.INVOICE_FLAG in (''2'',''3'') then A.TAX_RATE else 0 end),2) else 0 end) as SALRT_TAX, '+
              'sum(case when B.SALES_TYPE=3 then round(A.CALC_AMOUNT*isnull(C.COST_PRICE,0),2) else 0 end) as SALRT_CST, '+
              '''00'','+GetTimeStamp(iDbType)+' '+
          ' from SAL_SALESDATA A '+
          ' inner join SAL_SALESORDER B on A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID '+
          ' left join '+tempTabCost+' C on A.GODS_ID=C.GODS_ID and A.BATCH_NO=C.BATCH_NO '+
          ' where B.TENANT_ID='+inttostr(TENANT_ID)+' '+SQLCnd+' and B.SALES_TYPE in (1,3,4) '+
          ' group by B.TENANT_ID,B.SHOP_ID,B.DEPT_ID,'+
              'case when B.GUIDE_USER is null then ''#'' else B.GUIDE_USER end,'+
              'case when B.SALES_STYLE is null then ''#'' else B.SALES_STYLE end,'+
              'case when B.CLIENT_ID is null then ''#'' else B.CLIENT_ID end,'+
              'B.SALES_DATE,A.GODS_ID,A.BATCH_NO,A.IS_PRESENT'
        );
      FdbHelp.ExecSQL(SQL);
      result:=true;
    end;
  end;
end;

procedure TCalcForGodsCost.ClearCostTempTable(TabName: string);
begin
  case iDbType of
   0,1:FdbHelp.ExecSQL('truncate table '+TabName);
   4:begin
       FdbHelp.ExecSQL(GetCostPriceTmpSQL(TabName));
       //FdbHelp.ExecSQL('CREATE INDEX '+TabName+'_IDX ON '+TabName+'(GODS_ID,BATCH_NO)');
     end;
   5:FdbHelp.ExecSQL('delete from '+TabName);
  end;
end;

function TCalcForGodsCost.CheckForRck: Boolean;
var
  rs:TZQuery;
begin
  result:=False;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
      'select B.SHOP_NAME,A.PRINT_DATE from STO_PRINTORDER A,CA_SHOP_INFO B '+
      'where A.TENANT_ID=:TENANT_ID and A.PRINT_DATE>:PRINT_DATE and A.TENANT_ID=B.TENANT_ID and A.CHK_DATE is null';
    rs.ParamByName('TENANT_ID').AsInteger := TENANT_ID;
    rs.ParamByName('PRINT_DATE').AsInteger := StrtoInt(FormatDatetime('YYYYMMDD',FLastMth_Date));
    FdbHelp.Open(rs);
    if not rs.IsEmpty then Raise Exception.Create(rs.Fields[0].asString+'门店'+rs.Fields[1].asString+'号的盘点没有审核,不能结账.');
    result:=true;
  finally
    rs.Free;
  end;
end;

function TCalcForGodsCost.GetRckTempTabSQL(tb: string): string;
begin
  //创建临时表SQL
  case iDbType of
   0,5:result:=
    'CREATE TABLE '+tb+' ('+
    '	TENANT_ID int NOT NULL ,'+
    '	SHOP_ID varchar (13) NOT NULL ,'+
    '	CREA_DATE int NOT NULL ,'+
    '	ORDER_TYPE int NOT NULL ,'+
    '	GODS_ID varchar (36)  NOT NULL ,'+
    '	BATCH_NO varchar (36) NOT NULL ,'+
    '	RCK_AMT decimal(18, 3) NULL ,'+
    '	RCK_MNY decimal(18, 3) NULL ,'+
    '	RCK_CST decimal(18, 3) NULL ,'+
    '	RCK_TAX decimal(18, 3) NULL ,'+
    '	RCK_RTL decimal(18, 3) NULL ,'+
    '	RCK_PRF decimal(18, 3) NULL ,'+
    '	RCK_AGO decimal(18, 3) NULL ,'+
    '	COST_PRICE decimal(18, 6) NULL '+
    ')';
  1:result :=
    'create global temporary table '+tb+' ('+
    ' TENANT_ID NUMBER(9,0) NOT NULL ,'+
    ' SHOP_ID varchar2(13) NOT NULL ,'+
    ' CREA_DATE NUMBER(9,0) NOT NULL ,'+
    '	ORDER_TYPE int NOT NULL ,'+
    ' GODS_ID varchar2(36)  NOT NULL ,'+
    ' BATCH_NO varchar2(36) NOT NULL ,'+
    '	RCK_AMT decimal(18, 3) ,'+
    '	RCK_MNY decimal(18, 3) ,'+
    '	RCK_CST decimal(18, 3) ,'+
    '	RCK_TAX decimal(18, 3) ,'+
    '	RCK_RTL decimal(18, 3) ,'+
    '	RCK_PRF decimal(18, 3) ,'+
    '	RCK_AGO decimal(18, 3) ,'+
    '	COST_PRICE decimal(18, 6) '+
    ') ON COMMIT PRESERVE ROWS';
  4:result :=
    'declare global temporary table '+tb+' ('+
    '	TENANT_ID int NOT NULL ,'+
    '	SHOP_ID varchar (13) NOT NULL ,'+
    '	CREA_DATE int NOT NULL ,'+
    '	ORDER_TYPE int NOT NULL ,'+
    '	GODS_ID varchar (36)  NOT NULL ,'+
    '	BATCH_NO varchar (36) NOT NULL ,'+
    '	RCK_AMT decimal(18, 3) ,'+
    '	RCK_MNY decimal(18, 3) ,'+
    '	RCK_CST decimal(18, 3) ,'+
    '	RCK_TAX decimal(18, 3) ,'+
    '	RCK_RTL decimal(18, 3) ,'+
    '	RCK_PRF decimal(18, 3) ,'+
    '	RCK_AGO decimal(18, 3) ,'+
    '	COST_PRICE decimal(18, 6) '+
    ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
  end;
end;

procedure TCalcForGodsCost.ClearRckTempTable(TabName: string);
begin
  case iDbType of
   0,1:FdbHelp.ExecSQL('truncate table '+TabName);
   4:FdbHelp.ExecSQL(GetRckTempTabSQL(TabName));
   5:FdbHelp.ExecSQL('delete from '+TabName);
  end;
end;

{ TCalcForPosReck }

procedure TCalcForPosReck.CreateNew;
begin
  inherited;
  ps := TZQuery.Create(nil);
  rs := TZQuery.Create(nil);
  ss := TZQuery.Create(nil);
  ss.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
  ss.FieldDefs.Add('SHOP_ID',ftString,13,true);
  ss.FieldDefs.Add('CLSE_DATE',ftInteger,0,true);
  ss.FieldDefs.Add('CREA_USER',ftString,36,true);
  ss.FieldDefs.Add('PAY_A',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_B',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_C',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_D',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_E',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_F',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_G',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_H',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_I',ftFloat,0,true);
  ss.FieldDefs.Add('PAY_J',ftFloat,0,true);
  ss.CreateDataSet;
end;

destructor TCalcForPosReck.Destroy;
begin
  ps.Free;
  rs.Free;
  ss.Free;
  inherited;
end;

function TCalcForPosReck.GetPayment(s: string):string;
begin
  if not ps.Active then
  begin
    ps.Close;
    ps.SQL.Text := 'select CODE_ID,CODE_NAME,CODE_SPELL from VIW_PAYMENT where TENANT_ID='+IntToStr(TENANT_ID);
    FdbHelp.Open(ps);
  end;
  if ps.Locate('CODE_ID',s,[]) then
    result := ps.FieldbyName('CODE_NAME').AsString
  else
    result := 'H';
end;

function TCalcForPosReck.GetDeptID(TenID: integer; UserID: string): string;
var
  Rs: TZQuery;
begin
  result:='';
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select DEPT_ID from VIW_USERS where TENANT_ID=:TENANT_ID and USER_ID=:CREA_USER';
    Rs.Params.ParamByName('TENANT_ID').AsInteger:=TenID;
    Rs.Params.ParamByName('CREA_USER').AsString:=UserID;
    FdbHelp.Open(Rs);
    result:=Rs.FieldByName('DEPT_ID').AsString;
  finally
    Rs.Free;
  end;
end;

function TCalcForPosReck.OpenCloseForDay: Boolean;
var
  Str:string;
  SalCnd:string; //销售单日期条件
  ICCnd:string;  //卡交易日期条件
begin
  result:=False;
  if ReckBegDate = ReckEndDate then //日期相等直接用等号
  begin
    SalCnd:=' and SALES_DATE=:RCK_BEG_DATE ';
    ICCnd:=' and CREA_DATE=:RCK_BEG_DATE ';
  end else
  begin
    SalCnd:=' and SALES_DATE>=:RCK_BEG_DATE and SALES_DATE<=:RCK_END_DATE ';
    ICCnd :=' and CREA_DATE>=:RCK_BEG_DATE and CREA_DATE<=:RCK_END_DATE ';
  end;

  Str :=
    'select TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE as CLSE_DATE,''1'' as CLSE_TYPE,'+
    'sum(PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J) as CLSE_MNY,'+
    'sum(PAY_A) as PAY_A,'+
    'sum(PAY_B) as PAY_B,'+
    'sum(PAY_C) as PAY_C,'+
    'sum(PAY_D) as PAY_D,'+
    'sum(PAY_E) as PAY_E,'+
    'sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,'+
    'sum(PAY_H) as PAY_H,'+
    'sum(PAY_I) as PAY_I,'+
    'sum(PAY_J) as PAY_J '+
    ' from SAL_SALESORDER A'+
    ' where TENANT_ID=:TENANT_ID '+SalCnd+' and SALES_TYPE=4 '+
    ' group by TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE'+
    ' union all '+
    'select TENANT_ID,SHOP_ID,CREA_USER,CREA_DATE as CLSE_DATE,''2'' as CLSE_TYPE,'+
    'sum(PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J) as CLSE_MNY,'+
    'sum(PAY_A) as PAY_A,'+
    'sum(PAY_B) as PAY_B,'+
    'sum(PAY_C) as PAY_C,'+
    'sum(PAY_D) as PAY_D,'+
    'sum(PAY_E) as PAY_E,'+
    'sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,'+
    'sum(PAY_H) as PAY_H,'+
    'sum(PAY_I) as PAY_I,'+
    'sum(PAY_J) as PAY_J '+
    ' from SAL_IC_GLIDE A '+
    ' where TENANT_ID=:TENANT_ID '+ICCnd+' and IC_GLIDE_TYPE=''1'' '+
    ' group by TENANT_ID,SHOP_ID,CREA_USER,CREA_DATE';

  Str :=
    'select A.* from ('+Str+') A '+
    ' where not exists(select TENANT_ID from ACC_CLOSE_FORDAY where TENANT_ID=A.TENANT_ID and SHOP_ID=A.SHOP_ID and CREA_USER=A.CREA_USER and CLSE_DATE=A.CLSE_DATE)';
  rs.Close;
  rs.SQL.Text := Str;
  rs.ParamByName('TENANT_ID').AsInteger := TENANT_ID;
  rs.ParamByName('RCK_BEG_DATE').AsInteger:=StrToIntDef(FormatDatetime('YYYYMMDD',ReckBegDate),0);
  if rs.Params.FindParam('RCK_END_DATE')<>nil then
    rs.ParamByName('RCK_END_DATE').AsInteger:=StrToIntDef(FormatDatetime('YYYYMMDD',ReckEndDate),0);
  FdbHelp.Open(rs);
  result:=rs.Active;
end;

function TCalcForPosReck.InsertRecordAccRecvAble: Boolean;
var
  Str,id:String;
  rs:TZQuery;
begin
  result:=False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'insert into ACC_RECVABLE_INFO '+
      '(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,PAYM_ID,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
      ' values(:ABLE_ID,:TENANT_ID,:SHOP_ID,:DEPT_ID,:CLIENT_ID,:ACCT_INFO,''4'',:PAYM_ID,:RECV_MNY,0,0,:RECV_MNY,:CLSE_DATE,'+GetSysDateFormat(iDbType)+',:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
    ss.First;
    while not ss.Eof do
    begin
      rs.ParambyName('TENANT_ID').AsInteger := ss.FieldbyName('TENANT_ID').AsInteger;
      rs.ParambyName('SHOP_ID').AsString := ss.FieldbyName('SHOP_ID').AsString;
      rs.ParambyName('CLIENT_ID').AsString := IntToStr(ss.FieldbyName('TENANT_ID').AsInteger);
      rs.ParambyName('CLSE_DATE').AsInteger := ss.FieldbyName('CLSE_DATE').AsInteger;
      rs.ParambyName('CREA_USER').AsString := ss.FieldbyName('CREA_USER').AsString;
      rs.ParambyName('DEPT_ID').AsString := GetDeptID(ss.FieldbyName('TENANT_ID').AsInteger,ss.FieldbyName('CREA_USER').AsString);
      //支付方式A
      if ss.FieldbyName('PAY_A').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('A')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'A';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_A').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      //支付方式B
      if ss.FieldbyName('PAY_B').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('B')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'B';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_B').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      //支付方式C
      if ss.FieldbyName('PAY_C').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('C')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'C';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_C').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      //支付方式E
      if ss.FieldbyName('PAY_E').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('E')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'E';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_E').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      //支付方式F
      if ss.FieldbyName('PAY_F').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('F')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'F';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_F').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      //支付方式G
      if ss.FieldbyName('PAY_G').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('G')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'G';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_G').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      //支付方式H
      if ss.FieldbyName('PAY_H').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('H')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'H';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_H').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      //支付方式I
      if ss.FieldbyName('PAY_I').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('I')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'I';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_I').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      //支付方式J
      if ss.FieldbyName('PAY_J').AsFloat<>0 then
      begin
        rs.ParambyName('ABLE_ID').AsString := newid(ss.FieldbyName('SHOP_ID').asString);
        rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('J')+'】';
        rs.ParambyName('PAYM_ID').AsString := 'J';
        rs.ParambyName('RECV_MNY').AsFloat := ss.FieldbyName('PAY_J').AsFloat;
        FdbHelp.ExecQuery(rs);
      end;
      ss.Next;
    end;
    result:=true;
  finally
    rs.Free;
  end;
end;

function TCalcForPosReck.InsertRecordCloseForDay(ClsObj:TZQuery): Boolean;
var
  TenID:integer;  //企业ID
  ShopID:string;  //门店ID
  CLSE_DATE:integer;  //结账日期
  CREA_USER:string;  //创建人
  Str,id:String;
  CurRecord:TRecord_;
begin
  result:=False;
  CurRecord:=TRecord_.Create;
  try
    ClsObj.First;
    while not ClsObj.Eof do
    begin
      CurRecord.ReadFromDataSet(ClsObj); 
      id := Newid(ClsObj.FieldbyName('SHOP_ID').asString);
      Str :=
        'insert into ACC_CLOSE_FORDAY'+
        '(ROWS_ID,TENANT_ID,SHOP_ID,CLSE_DATE,CLSE_MNY,CLSE_TYPE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
        ' values '+
        '('''+id+''',:TENANT_ID,:SHOP_ID,:CLSE_DATE,:CLSE_MNY,:CLSE_TYPE,:PAY_A,:PAY_B,:PAY_C,:PAY_D,:PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,'''+FormatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
      FdbHelp.ExecSQL(Str,CurRecord);

      //参数
      TenID:=ClsObj.FieldbyName('TENANT_ID').AsInteger;  //企业ID
      ShopID:=ClsObj.FieldbyName('SHOP_ID').AsString;    //门店ID
      CLSE_DATE:=ClsObj.FieldbyName('CLSE_DATE').AsInteger;  //结账日期
      CREA_USER:=ClsObj.FieldbyName('CREA_USER').AsString;   //创建人

      if ss.Locate('TENANT_ID;SHOP_ID;CLSE_DATE;CREA_USER',VarArrayOf([TenID,ShopID,CLSE_DATE,CREA_USER]),[]) then
        ss.Edit
      else
        ss.Append;
      ss.FieldbyName('TENANT_ID').AsInteger := ClsObj.FieldbyName('TENANT_ID').AsInteger;
      ss.FieldbyName('SHOP_ID').AsString := ClsObj.FieldbyName('SHOP_ID').AsString;
      ss.FieldbyName('CLSE_DATE').AsInteger := ClsObj.FieldbyName('CLSE_DATE').AsInteger;
      ss.FieldbyName('CREA_USER').AsString := ClsObj.FieldbyName('CREA_USER').AsString;
      ss.FieldbyName('PAY_A').AsFloat := ss.FieldbyName('PAY_A').AsFloat + ClsObj.FieldbyName('PAY_A').AsFloat;
      ss.FieldbyName('PAY_B').AsFloat := ss.FieldbyName('PAY_B').AsFloat + ClsObj.FieldbyName('PAY_B').AsFloat;
      ss.FieldbyName('PAY_C').AsFloat := ss.FieldbyName('PAY_C').AsFloat + ClsObj.FieldbyName('PAY_C').AsFloat;
      ss.FieldbyName('PAY_D').AsFloat := ss.FieldbyName('PAY_D').AsFloat + ClsObj.FieldbyName('PAY_D').AsFloat;
      ss.FieldbyName('PAY_E').AsFloat := ss.FieldbyName('PAY_E').AsFloat + ClsObj.FieldbyName('PAY_E').AsFloat;
      ss.FieldbyName('PAY_F').AsFloat := ss.FieldbyName('PAY_F').AsFloat + ClsObj.FieldbyName('PAY_F').AsFloat;
      ss.FieldbyName('PAY_G').AsFloat := ss.FieldbyName('PAY_G').AsFloat + ClsObj.FieldbyName('PAY_G').AsFloat;
      ss.FieldbyName('PAY_H').AsFloat := ss.FieldbyName('PAY_H').AsFloat + ClsObj.FieldbyName('PAY_H').AsFloat;
      ss.FieldbyName('PAY_I').AsFloat := ss.FieldbyName('PAY_I').AsFloat + ClsObj.FieldbyName('PAY_I').AsFloat;
      ss.FieldbyName('PAY_J').AsFloat := ss.FieldbyName('PAY_J').AsFloat + ClsObj.FieldbyName('PAY_J').AsFloat;
      ss.Post;
      ClsObj.Next;
    end;
  finally
    CurRecord.Free;
  end;
  Result := True;
end;

function TCalcForPosReck.DoCalcReck(RckBeg_Date,RckEnd_Date:TDate): Boolean;
begin
  result:=False;
  ReckBegDate:=RckBeg_Date; //台账开始日期
  ReckEndDate:=RckEnd_Date; //台账结束日期

  if OpenCloseForDay then
  begin
    //if iDbType<>5 then FdbHelp.BeginTrans;
    try
      InsertRecordCloseForDay(Rs); //插入交班结账
      result:=InsertRecordAccRecvAble;  //插入对应应收款
      //if iDbType<>5 then FdbHelp.CommitTrans;
    except
      //if iDbType<>5 then FdbHelp.RollbackTrans;
      Raise;
    end;
  end;
end;

{ TCalcForUpStroage }

procedure TCalcForUpStroage.CreateNew;
var
  TabSQL:string;
begin
  inherited;
  tempTableUpStor:='';
  //临时表名
  case iDbType of
   0: tempTableUpStor := '#TMP_STORAGE';
   1: tempTableUpStor := 'TMP_STORAGE';
   4: tempTableUpStor := 'session.TMP_STORAGE';
   5: tempTableUpStor := 'TMP_STORAGE';
  end;
  //临时表SQL
  case iDbType of
   0,5:
    TabSQL :=
      'CREATE TABLE '+tempTableUpStor+' ('+
      '	TENANT_ID int NOT NULL ,'+
      '	GODS_ID varchar (36) NOT NULL ,'+
      '	BATCH_NO varchar (36) NOT NULL ,'+
      '	COST_PRICE decimal(18, 6) NULL'+
      ')';
   1:
    TabSQL :=
      'create global temporary table '+tempTableUpStor+' ('+
      '	TENANT_ID int NOT NULL ,'+
      '	GODS_ID varchar2 (36) NOT NULL ,'+
      '	BATCH_NO varchar2 (36) NOT NULL ,'+
      '	COST_PRICE decimal(18, 6)'+
      ') ON COMMIT PRESERVE ROWS';
   4:
    TabSQL :=
      'declare global temporary table '+tempTableUpStor+' ('+
      ' TENANT_ID int NOT NULL ,'+
      ' GODS_ID varchar (36) NOT NULL ,'+
      ' BATCH_NO varchar (36) NOT NULL ,'+
      ' COST_PRICE decimal(18, 6) '+
      ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
  end;
  //创建临时表并清除数据
  CreateTable(tempTableUpStor,TabSQL,'TENANT_ID,GODS_ID,BATCH_NO',True);
end;

function TCalcForUpStroage.DoCalcUpdateStroage(UP_RECK_DATE:TDate):Boolean;
var
  SQL:string;
  Rck_Date:string;
begin
  result:=False;
  Rck_Date:=FormatDatetime('YYYYMMDD',UP_RECK_DATE); //更新日期
  //1、临时表生成数据
  SQL:=ParseSQL(iDbType,
         'insert into '+tempTableUpStor+'(TENANT_ID,GODS_ID,BATCH_NO,COST_PRICE)'+
         'select TENANT_ID,GODS_ID,BATCH_NO,(case when sum(BAL_AMT)<>0 then round(sum(BAL_CST)*1.000000/sum(BAL_AMT),6) else 0.0 end)as COST_PRICE from RCK_GOODS_DAYS '+
         ' where TENANT_ID= '+IntToStr(TENANT_ID)+' and CREA_DATE='+Rck_Date+
         ' group by TENANT_ID,GODS_ID,BATCH_NO'
       );
  FdbHelp.ExecSQL(SQL);

  if iDbType <> 5 then FdbHelp.BeginTrans;
  try
    //2、更新库存成本
    SQL:='update STO_STORAGE '+
         ' set COST_PRICE='+
         '(select COST_PRICE from '+tempTableUpStor+
         ' where TENANT_ID=STO_STORAGE.TENANT_ID and GODS_ID=STO_STORAGE.GODS_ID and BATCH_NO=STO_STORAGE.BATCH_NO)'+
         ' where TENANT_ID='+inttostr(TENANT_ID);
    FdbHelp.ExecSQL(SQL);

    //3、更新成本金额
    SQL:=ParseSQL(iDbType,
           'update STO_STORAGE set AMONEY=round(AMOUNT*isnull(COST_PRICE,0),2),COST_PRICE=isnull(COST_PRICE,0) '+
           'where TENANT_ID='+inttostr(TENANT_ID)
         );
    FdbHelp.ExecSQL(SQL); 
    if iDbType <> 5 then FdbHelp.CommitTrans;
    result:=true;
  except
    if iDbType <> 5 then FdbHelp.RollbackTrans;
    raise;
  end;
end;

{ TCheckCostCalc }

function TCheckCostCalc.Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;
  var rs : TZQuery;
  var localDBKey : string;
  var remoteDBKey : string;
  var remoteTime : string;
  var curTime : string;
  var tenantId : integer;
begin
  result := true;  
  if Params.FindParam('localDBKey') <> nil then
    localDBKey := Params.FindParam('localDBKey').AsString;
  if Params.FindParam('tenantId') <> nil then
    tenantId := Params.FindParam('tenantId').AsInteger
  else
    begin
      Msg := '获取当前企业为空，请稍后再试...';
      Exit;
    end;

  rs := TZQuery.Create(nil);
  AGlobal.BeginTrans;
  try
    rs.Close;
    case AGlobal.iDbType of
      0:rs.SQL.Text := 'select VALUE from SYS_DEFINE with(UPDLOCK) where DEFINE=''RCK_ID'' and TENANT_ID=' + inttostr(tenantId);
      1:rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''RCK_ID'' and TENANT_ID=' + inttostr(tenantId) + ' for update';
      4:rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''RCK_ID'' and TENANT_ID=' + inttostr(tenantId) + ' for update with rs';
    else
      rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''RCK_ID'' and TENANT_ID=' + inttostr(tenantId);
    end;
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      begin
        remoteDBKey := rs.Fields[0].AsString;// 正在执行成本核算的DBKEY
        if (localDBKey <> remoteDBKey) then
          begin
            rs.Close;
            rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''RCK_TIME'' and TENANT_ID=' + inttostr(tenantId);// 正在执行成本核算的开始时间
            AGlobal.Open(rs);
            if not rs.IsEmpty then
              begin
                remoteTime := rs.Fields[0].AsString;
                curTime := formatDatetime('YYYYMMDDHHNNSS', IncMinute(now(), -30));
                if curTime < remoteTime then
                  begin
                    Msg := '正在执行成本核算，请稍后再试...';
                    AGlobal.RollbackTrans;
                    Exit;
                  end;
              end;
          end;
        AGlobal.ExecSQL('delete from SYS_DEFINE where TENANT_ID = ' + inttostr(tenantId) + ' and DEFINE in (''RCK_ID'',''RCK_TIME'') ');
      end;
 	  // 插入正在成本核算标示
    AGlobal.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values ('+inttostr(tenantId)+',''RCK_ID'','''+ localDBKey +''',0,''00'',0)');
	  AGlobal.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values ('+inttostr(tenantId)+',''RCK_TIME'','''+ formatDatetime('YYYYMMDDHHNNSS', now()) +''',0,''00'',0)');
    AGlobal.CommitTrans;
  except
    AGlobal.RollbackTrans;
    Msg := '成本核算检测异常，请稍后再试...';
  end;
  rs.Free;
end;


{ TCalcForCloseReck }
                                             
function TCalcForCloseReck.DoEndRckDaysClose(RCK_BEG_DATE,RCK_END_DATE:TDate): Boolean;
var
  i:integer;
  SQL:string;
  Days:integer;
  succCount:integer;
  CLS_DATE:string;
begin
  result:=False;
  succCount:=0;
  Days:=Round(RCK_END_DATE-RCK_BEG_DATE);
  if iDbType<>5 then FdbHelp.BeginTrans;
  try
    for i:=0 to Days do
    begin
      CLS_DATE:=FormatDatetime('YYYYMMDD',RCK_BEG_DATE+i);
      SQL:=
        'insert into RCK_DAYS_CLOSE(TENANT_ID,SHOP_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP)'+
        'select TENANT_ID,SHOP_ID,'+CLS_DATE+','''+USER_ID+''',''00'','+GetTimeStamp(iDbType)+' from CA_SHOP_INFO where TENANT_ID='+inttostr(TENANT_ID);
      if FdbHelp.ExecSQL(SQL)>0 then Inc(succCount);
    end;
    result:=(succCount=Days+1);
    if iDbType<>5 then FdbHelp.CommitTrans;
  except
    if iDbType<>5 then FdbHelp.RollbackTrans;
    raise;
  end;
end;

function TCalcForCloseReck.DoEndRckMonthClose(RCK_BEG_DATE,RCK_END_DATE:TDate): Boolean;
var
  SQL:string;
  iRet:integer;
begin
  SQL:=
    'insert into RCK_MONTH_CLOSE(TENANT_ID,SHOP_ID,MONTH,BEGIN_DATE,END_DATE,CREA_USER,COMM,TIME_STAMP) '+
    'select TENANT_ID,SHOP_ID,'+FormatDatetime('YYYYMM',RCK_END_DATE)+','''+FormatDatetime('YYYY-MM-DD',RCK_BEG_DATE)+''','''+formatDatetime('YYYY-MM-DD',RCK_END_DATE)+''','+
    ''''+USER_ID+''',''00'','+GetTimeStamp(iDbType)+' from CA_SHOP_INFO where TENANT_ID='+inttostr(TENANT_ID);

  if iDbType<>5 then FdbHelp.BeginTrans;
  try
    iRet:=FdbHelp.ExecSQL(SQL);
    result:=(iRet>0);
    if iDbType<>5 then FdbHelp.CommitTrans;
  except
    if iDbType<>5 then FdbHelp.RollbackTrans;
    raise;
  end;    
end;

{ TCostCalc }

function TCostCalc.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  DoCmdIdx:integer;
begin
  FdbHelp:=AGlobal;  //数据库访问接口
  FInParams:=Params;  //参数集
  //系统参数
  Fcalc_flag:=Params.ParamByName('CALC_FLAG').AsInteger; //核算方法(0:移动加权平均;1:日移动加权平均;2:月移动加权平均)
  reck_flag:=Params.ParamByName('RECK_FLAG').AsInteger; //月结账类型(月底结账、指定日结账)
  reck_day:=Params.ParamByName('RECK_DAY').AsInteger;   //指定日结账
  //台账参数
  FcDate:=fnTime.fnStrtoDate(Params.ParamByName('CDATE').AsString); //最后日结日期
  FmDate:=fnTime.fnStrtoDate(Params.ParamByName('MDATE').AsString); //本次日台账日期(最大日期)
  FeDate:=fnTime.fnStrtoDate(Params.ParamByName('EDATE').AsString); //本次日结账日期(之前当天不关账,现在无限制)
  FbDate:=fnTime.fnStrtoDate(Params.ParamByName('BDATE').AsString); //上次月结日期RCK_MONTH_CLOSE.END_DATE
  pt:=round(mDate-cDate); //计算日台账天数;
  //客户端参数
  FTENANT_ID:=Params.ParamByName('TENANT_ID').AsInteger; //企业ID
  FUSER_ID:=Params.ParamByName('USER_ID').AsString;   //用户ID
end;

{ TCalcForGodsMonth }

function TCalcForGodsMonth.GetTempMonthSQL(tb:string):string;
begin
  case iDbType of
  0,5:result :=
    'CREATE TABLE '+tb+' ('+
    '	TENANT_ID int NOT NULL ,'+
    '	SHOP_ID varchar (13) NOT NULL ,'+
    '	GODS_ID varchar (36)  NOT NULL ,'+
    '	BATCH_NO varchar (36) NOT NULL ,'+
    '	ORG_AMT decimal(18, 3) NULL ,'+
    '	ORG_MNY decimal(18, 3) NULL ,'+
    '	ORG_CST decimal(18, 3) NULL ,'+
    '	STOCK_AMT decimal(18, 3) NULL ,'+
    '	STOCK_MNY decimal(18, 3) NULL ,'+
    '	STOCK_TAX decimal(18, 3) NULL ,'+
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
    '	DBIN_CST decimal(18, 3) NULL ,'+
    '	DBOUT_AMT decimal(18, 3) NULL ,'+
    '	DBOUT_CST decimal(18, 3) NULL ,'+
    '	CHANGE1_AMT decimal(18, 3) NULL ,'+
    '	CHANGE1_CST decimal(18, 3) NULL ,'+
    '	CHANGE2_AMT decimal(18, 3) NULL ,'+
    '	CHANGE2_CST decimal(18, 3) NULL ,'+
    '	CHANGE3_AMT decimal(18, 3) NULL ,'+
    '	CHANGE3_CST decimal(18, 3) NULL ,'+
    '	CHANGE4_AMT decimal(18, 3) NULL ,'+
    '	CHANGE4_CST decimal(18, 3) NULL ,'+
    '	CHANGE5_AMT decimal(18, 3) NULL ,'+
    '	CHANGE5_CST decimal(18, 3) NULL ,'+
    '	BAL_AMT decimal(18, 3) NULL ,'+
    '	BAL_CST decimal(18, 3) NULL ,'+
    '	PRIOR_YEAR_AMT decimal(18, 3) NULL ,'+
    '	PRIOR_YEAR_MNY decimal(18, 3) NULL ,'+
    '	PRIOR_YEAR_TAX decimal(18, 3) NULL ,'+
    '	PRIOR_YEAR_CST decimal(18, 3) NULL ,'+
    '	PRIOR_MONTH_AMT decimal(18, 3) NULL ,'+
    '	PRIOR_MONTH_MNY decimal(18, 3) NULL ,'+
    '	PRIOR_MONTH_TAX decimal(18, 3) NULL ,'+
    '	PRIOR_MONTH_CST decimal(18, 3) NULL  '+
    ')';
  1:result := 
    'create global temporary table '+tb+' ('+
    ' TENANT_ID NUMBER(9,0) NOT NULL ,'+
    ' SHOP_ID varchar2(13) NOT NULL ,'+
    ' GODS_ID varchar2(36)  NOT NULL ,'+
    ' BATCH_NO varchar2(36) NOT NULL ,'+
    ' ORG_AMT decimal(18, 3) ,'+
    ' ORG_CST decimal(18, 3) ,'+
    ' STOCK_AMT decimal(18, 3) ,'+
    ' STOCK_MNY decimal(18, 3) ,'+
    ' STOCK_TAX decimal(18, 3) ,'+
    ' STOCK_AGO decimal(18, 3) ,'+
    ' STKRT_AMT decimal(18, 3) ,'+
    ' STKRT_MNY decimal(18, 3) ,'+
    ' STKRT_TAX decimal(18, 3) ,'+
    ' SALE_AMT decimal(18, 3) ,'+
    ' SALE_RTL decimal(18, 3) ,'+
    ' SALE_AGO decimal(18, 3) ,'+
    ' SALE_MNY decimal(18, 3) ,'+
    ' SALE_TAX decimal(18, 3) ,'+
    ' SALE_CST decimal(18, 3) ,'+
    ' COST_PRICE decimal(18, 6) ,'+
    ' SALE_PRF decimal(18, 3) ,'+
    ' SALRT_AMT decimal(18, 3) ,'+
    ' SALRT_MNY decimal(18, 3) ,'+
    ' SALRT_TAX decimal(18, 3) ,'+
    ' SALRT_CST decimal(18, 3) ,'+
    ' DBIN_AMT decimal(18, 3) ,'+
    ' DBIN_CST decimal(18, 3) ,'+
    ' DBOUT_AMT decimal(18, 3) ,'+
    ' DBOUT_CST decimal(18, 3) ,'+
    ' CHANGE1_AMT decimal(18, 3) ,'+
    ' CHANGE1_CST decimal(18, 3) ,'+
    ' CHANGE2_AMT decimal(18, 3) ,'+
    ' CHANGE2_CST decimal(18, 3) ,'+
    ' CHANGE3_AMT decimal(18, 3) ,'+
    ' CHANGE3_CST decimal(18, 3) ,'+
    ' CHANGE4_AMT decimal(18, 3) ,'+
    ' CHANGE4_CST decimal(18, 3) ,'+
    ' CHANGE5_AMT decimal(18, 3) ,'+
    ' CHANGE5_CST decimal(18, 3) ,'+
    '	BAL_AMT decimal(18, 3) ,'+
    '	BAL_CST decimal(18, 3) ,'+
    '	PRIOR_YEAR_AMT decimal(18, 3) ,'+
    '	PRIOR_YEAR_MNY decimal(18, 3) ,'+
    '	PRIOR_YEAR_TAX decimal(18, 3) ,'+
    '	PRIOR_YEAR_CST decimal(18, 3) ,'+
    '	PRIOR_MONTH_AMT decimal(18, 3) ,'+
    '	PRIOR_MONTH_MNY decimal(18, 3) ,'+
    '	PRIOR_MONTH_TAX decimal(18, 3) ,'+
    '	PRIOR_MONTH_CST decimal(18, 3)  '+      
    ') ON COMMIT PRESERVE ROWS';
  4:result :=
    'declare global temporary table '+tb+' ('+
    '	TENANT_ID int NOT NULL ,'+
    '	SHOP_ID varchar (13) NOT NULL ,'+
    '	GODS_ID varchar (36)  NOT NULL ,'+
    '	BATCH_NO varchar (36) NOT NULL ,'+
    '	ORG_AMT decimal(18, 3) ,'+
    '	ORG_CST decimal(18, 3) ,'+
    '	STOCK_AMT decimal(18, 3) ,'+
    '	STOCK_MNY decimal(18, 3) ,'+
    '	STOCK_TAX decimal(18, 3) ,'+
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
    '	DBIN_CST decimal(18, 3) ,'+
    '	DBOUT_AMT decimal(18, 3) ,'+
    '	DBOUT_CST decimal(18, 3) ,'+
    '	CHANGE1_AMT decimal(18, 3) ,'+
    '	CHANGE1_CST decimal(18, 3) ,'+
    '	CHANGE2_AMT decimal(18, 3) ,'+
    '	CHANGE2_CST decimal(18, 3) ,'+
    '	CHANGE3_AMT decimal(18, 3) ,'+
    '	CHANGE3_CST decimal(18, 3) ,'+
    '	CHANGE4_AMT decimal(18, 3) ,'+
    '	CHANGE4_CST decimal(18, 3) ,'+
    '	CHANGE5_AMT decimal(18, 3) ,'+
    '	CHANGE5_CST decimal(18, 3) ,'+
    '	BAL_AMT decimal(18, 3) ,'+
    '	BAL_CST decimal(18, 3) ,'+
    '	PRIOR_YEAR_AMT decimal(18, 3) ,'+
    '	PRIOR_YEAR_MNY decimal(18, 3) ,'+
    '	PRIOR_YEAR_TAX decimal(18, 3) ,'+
    '	PRIOR_YEAR_CST decimal(18, 3) ,'+
    '	PRIOR_MONTH_AMT decimal(18, 3) ,'+
    '	PRIOR_MONTH_MNY decimal(18, 3) ,'+
    '	PRIOR_MONTH_TAX decimal(18, 3) ,'+
    '	PRIOR_MONTH_CST decimal(18, 3)  '+
    ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE';
  end;
end;

function TCalcForGodsMonth.DoCalcReck(BegReckDate,EndReckDate:TDate):Boolean;
var
  i:integer;
  SQL:string;
begin
  result:=False;
  //1、删除月结流水表
  SQL := 'delete from RCK_GOODS_MONTH where TENANT_ID='+inttostr(TENANT_ID)+' and MONTH='+formatDatetime('YYYYMM',EndReckDate);
  FdbHelp.ExecSQL(SQL);

  //2、生成月台账临时表
  //A、生成本月台账
  SQL :=
    'insert into '+tempTableUpMonth+'('+
        'TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,'+
        'ORG_AMT,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'PRIOR_YEAR_AMT,PRIOR_YEAR_MNY,PRIOR_YEAR_TAX,PRIOR_YEAR_CST,PRIOR_MONTH_AMT,PRIOR_MONTH_MNY,PRIOR_MONTH_TAX,PRIOR_MONTH_CST,'+
        'DBIN_AMT,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_CST,'+
        'BAL_AMT,BAL_CST) '+
    'select TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,'+
        'sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',BegReckDate)+' then ORG_AMT else 0 end)as ORG_AMT,'+
        'sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',BegReckDate)+' then ORG_CST else 0 end)as ORG_CST,'+
        'sum(STOCK_AMT)as STOCK_AMT,sum(STOCK_MNY)as STOCK_MNY,sum(STOCK_TAX)as STOCK_TAX,sum(STOCK_AGO)as STOCK_AGO,'+
        'sum(STKRT_AMT)as STKRT_AMT,sum(STKRT_MNY)as STKRT_MNY,sum(STKRT_TAX)as STKRT_TAX,'+
        'sum(SALE_AMT)as SALE_AMT,sum(SALE_RTL)as SALE_RTL,sum(SALE_AGO)as SALE_AGO,sum(SALE_MNY)as SALE_MNY,sum(SALE_TAX)as SALE_TAX,sum(SALE_CST)as SALE_CST,'+
        'sum(SALE_PRF)as SALE_PRF,sum(SALRT_AMT)as SALRT_AMT,sum(SALRT_MNY)as SALRT_MNY,sum(SALRT_TAX)as SALRT_TAX,sum(SALRT_CST)as SALRT_CST,'+
        '0 as PRIOR_YEAR_AMT,0 as PRIOR_YEAR_MNY,0 as PRIOR_YEAR_TAX,0 as PRIOR_YEAR_CST,0 as PRIOR_MONTH_AMT,0 as PRIOR_MONTH_MNY,0 as PRIOR_MONTH_TAX,0 as PRIOR_MONTH_CST,'+
        'sum(DBIN_AMT)as DBIN_AMT,sum(DBIN_CST)as DBIN_CST,'+
        'sum(DBOUT_AMT)as DBOUT_AMT,sum(DBOUT_CST)as DBOUT_CST,'+
        'sum(CHANGE1_AMT)as CHANGE1_AMT,sum(CHANGE1_CST)as CHANGE1_CST,'+
        'sum(CHANGE2_AMT)as CHANGE2_AMT,sum(CHANGE2_CST)as CHANGE2_CST,'+
        'sum(CHANGE3_AMT)as CHANGE3_AMT,sum(CHANGE3_CST)as CHANGE3_CST,'+
        'sum(CHANGE4_AMT)as CHANGE4_AMT,sum(CHANGE4_CST)as CHANGE4_CST,'+
        'sum(CHANGE5_AMT)as CHANGE5_AMT,sum(CHANGE5_CST)as CHANGE5_CST,'+
        'sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',EndReckDate)+' then BAL_AMT else 0 end)as BAL_AMT,'+
        'sum(case when CREA_DATE='+formatDatetime('YYYYMMDD',EndReckDate)+' then BAL_CST else 0 end)as BAL_CST '+
    'from RCK_GOODS_DAYS '+
    ' where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE>='+formatDatetime('YYYYMMDD',BegReckDate)+' and CREA_DATE<='+formatDatetime('YYYYMMDD',EndReckDate)+
    ' group by TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO';
  FdbHelp.ExecSQL(SQL);
  //B、生成月账的销售同比(前一年的同月份)
  SQL :=
    'insert into '+tempTableUpMonth+'('+
        'TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,'+
        'ORG_AMT,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'PRIOR_YEAR_AMT,PRIOR_YEAR_MNY,PRIOR_YEAR_TAX,PRIOR_YEAR_CST,PRIOR_MONTH_AMT,PRIOR_MONTH_MNY,PRIOR_MONTH_TAX,PRIOR_MONTH_CST,'+
        'DBIN_AMT,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_CST,'+
        'BAL_AMT,BAL_CST) '+
    'select '+
       'TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,'+
       '0 as ORG_AMT,0 as ORG_CST,'+
       '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
       '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
       'sum(SALE_AMT)as PRIOR_YEAR_AMT,sum(SALE_MNY)as PRIOR_YEAR_MNY,sum(SALE_TAX)as PRIOR_YEAR_TAX,sum(SALE_CST)as PRIOR_YEAR_CST,0 as PRIOR_MONTH_AMT,0 as PRIOR_MONTH_MNY,0 as PRIOR_MONTH_TAX,0 as PRIOR_MONTH_CST,'+
       '0 as DBIN_AMT,0 as DBIN_CST,'+
       '0 as DBOUT_AMT,0 as DBOUT_CST,'+
       '0 as CHANGE1_AMT,0 as CHANGE1_CST,'+
       '0 as CHANGE2_AMT,0 as CHANGE2_CST,'+
       '0 as CHANGE3_AMT,0 as CHANGE3_CST,'+
       '0 as CHANGE4_AMT,0 as CHANGE4_CST,'+
       '0 as CHANGE5_AMT,0 as CHANGE5_CST,'+
       '0 as BAL_AMT,0 as BAL_CST '+
     'from RCK_GOODS_DAYS where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE>='+FormatDatetime('YYYYMMDD',IncMonth(BegReckDate,-12))+' and CREA_DATE<='+formatDatetime('YYYYMMDD',IncMonth(EndReckDate,-12))+
     ' group by TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO';
  FdbHelp.ExecSQL(SQL);
         
  //C、生成月账的销售环比(同年度前一月份)
  SQL :=
    'insert into '+tempTableUpMonth+'('+
        'TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,'+
        'ORG_AMT,ORG_CST,'+
        'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
        'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,SALE_PRF,SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
        'PRIOR_YEAR_AMT,PRIOR_YEAR_MNY,PRIOR_YEAR_TAX,PRIOR_YEAR_CST,PRIOR_MONTH_AMT,PRIOR_MONTH_MNY,PRIOR_MONTH_TAX,PRIOR_MONTH_CST,'+
        'DBIN_AMT,DBIN_CST,'+
        'DBOUT_AMT,DBOUT_CST,'+
        'CHANGE1_AMT,CHANGE1_CST,'+
        'CHANGE2_AMT,CHANGE2_CST,'+
        'CHANGE3_AMT,CHANGE3_CST,'+
        'CHANGE4_AMT,CHANGE4_CST,'+
        'CHANGE5_AMT,CHANGE5_CST,'+
        'BAL_AMT,BAL_CST) '+
    'select '+
        'TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,'+
        '0 as ORG_AMT,0 as ORG_CST,'+
        '0 as STOCK_AMT,0 as STOCK_MNY,0 as STOCK_TAX,0 as STOCK_AGO,0 as STKRT_AMT,0 as STKRT_MNY,0 as STKRT_TAX,'+
        '0 as SALE_AMT,0 as SALE_RTL,0 as SALE_AGO,0 as SALE_MNY,0 as SALE_TAX,0 as SALE_CST,0 as SALE_PRF,0 as SALRT_AMT,0 as SALRT_MNY,0 as SALRT_TAX,0 as SALRT_CST,'+
        '0 as PRIOR_YEAR_AMT,0 as PRIOR_YEAR_MNY,0 as PRIOR_YEAR_TAX,0 as PRIOR_YEAR_CST,sum(SALE_AMT)as PRIOR_MONTH_AMT,sum(SALE_MNY)as PRIOR_MONTH_MNY,sum(SALE_TAX)as PRIOR_MONTH_TAX,sum(SALE_CST)as PRIOR_MONTH_CST,'+
        '0 as DBIN_AMT,0 as DBIN_CST,'+
        '0 as DBOUT_AMT,0 as DBOUT_CST,'+
        '0 as CHANGE1_AMT,0 as CHANGE1_CST,'+
        '0 as CHANGE2_AMT,0 as CHANGE2_CST,'+
        '0 as CHANGE3_AMT,0 as CHANGE3_CST,'+
        '0 as CHANGE4_AMT,0 as CHANGE4_CST,'+
        '0 as CHANGE5_AMT,0 as CHANGE5_CST,'+
        '0 as BAL_AMT,0 as BAL_CST '+
    'from RCK_GOODS_DAYS where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE>='+FormatDatetime('YYYYMMDD',IncMonth(BegReckDate,-1))+' and CREA_DATE<='+FormatDatetime('YYYYMMDD',IncMonth(EndReckDate,-1))+
    ' group by TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO ';
  FdbHelp.ExecSQL(SQL);    

  //4、生成月台账临时表
  try
    //if iDbType <> 5 then FdbHelp.BeginTrans;
    try
      //A、生成月台账汇总插入(RCK_GOODS_MONTH)
      SQL :=
        'insert into RCK_GOODS_MONTH('+
           'TENANT_ID,SHOP_ID,MONTH,GODS_ID,BATCH_NO,'+
           'ORG_AMT,ORG_CST,'+
           'STOCK_AMT,STOCK_MNY,STOCK_TAX,STOCK_AGO,STKRT_AMT,STKRT_MNY,STKRT_TAX,'+
           'SALE_AMT,SALE_RTL,SALE_AGO,SALE_MNY,SALE_TAX,SALE_CST,SALE_PRF,'+
           'SALRT_AMT,SALRT_MNY,SALRT_TAX,SALRT_CST,'+
           'PRIOR_YEAR_AMT,PRIOR_YEAR_MNY,PRIOR_YEAR_TAX,PRIOR_YEAR_CST,PRIOR_MONTH_AMT,PRIOR_MONTH_MNY,PRIOR_MONTH_TAX,PRIOR_MONTH_CST,'+
           'DBIN_AMT,DBIN_CST,'+
           'DBOUT_AMT,DBOUT_CST,'+
           'CHANGE1_AMT,CHANGE1_CST,'+
           'CHANGE2_AMT,CHANGE2_CST,'+
           'CHANGE3_AMT,CHANGE3_CST,'+
           'CHANGE4_AMT,CHANGE4_CST,'+
           'CHANGE5_AMT,CHANGE5_CST,'+
           'BAL_AMT,BAL_CST,ADJ_CST,COMM,TIME_STAMP '+
        ') '+
        'select '+
           'TENANT_ID,SHOP_ID,'+FormatDatetime('YYYYMM',EndReckDate)+' as MONTH,GODS_ID,BATCH_NO,'+
           'round(sum(ORG_AMT),3)as ORG_AMT,'+
           'round(sum(ORG_CST),2)as ORG_CST,'+
           'round(sum(STOCK_AMT),3),round(sum(STOCK_MNY),2),round(sum(STOCK_TAX),2),round(sum(STOCK_AGO),2),round(sum(STKRT_AMT),3),round(sum(STKRT_MNY),2),round(sum(STKRT_TAX),2),'+
           'round(sum(SALE_AMT),3),round(sum(SALE_RTL),2),round(sum(SALE_AGO),2),round(sum(SALE_MNY),2),round(sum(SALE_TAX),2),round(sum(SALE_CST),2),round(sum(SALE_PRF),2),'+
           'round(sum(SALRT_AMT),3),round(sum(SALRT_MNY),2),round(sum(SALRT_TAX),2),round(sum(SALRT_CST),2),'+
           'round(sum(PRIOR_YEAR_AMT),2),round(sum(PRIOR_YEAR_MNY),2),round(sum(PRIOR_YEAR_TAX),2),round(sum(PRIOR_YEAR_CST),2),round(sum(PRIOR_MONTH_AMT),2),round(sum(PRIOR_MONTH_MNY),2),round(sum(PRIOR_MONTH_TAX),2),round(sum(PRIOR_MONTH_CST),2),'+
           'round(sum(DBIN_AMT),3),round(sum(DBIN_CST),2),'+
           'round(sum(DBOUT_AMT),3),round(sum(DBOUT_CST),2),'+
           'round(sum(CHANGE1_AMT),3),round(sum(CHANGE1_CST),2),'+
           'round(sum(CHANGE2_AMT),3),round(sum(CHANGE2_CST),2),'+
           'round(sum(CHANGE3_AMT),3),round(sum(CHANGE3_CST),2),'+
           'round(sum(CHANGE4_AMT),3),round(sum(CHANGE4_CST),2),'+
           'round(sum(CHANGE5_AMT),3),round(sum(CHANGE5_CST),2),'+
           'round(sum(BAL_AMT),3)as BAL_AMT,'+
           'round(sum(BAL_CST),2)as BAL_CST,'+
           '0,''00'' as COMM,'+GetTimeStamp(iDbType)+' '+
        'from '+tempTableUpMonth+' '+
      ' group by TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO';
      FdbHelp.ExecSQL(SQL);

      //if iDbType <> 5 then FdbHelp.CommitTrans;
    except
      //if iDbType <> 5 then FdbHelp.RollbackTrans;
      Raise;
    end;
  finally
    CleanTempMonth; //清空临时表
  end;
  result:=true;
end;

procedure TCalcForGodsMonth.CreateNew;
var
  TabName,SQL:string;
begin
  tempTableUpMonth:='';
  case iDbType of
   0: tempTableUpMonth := '#TMP_RCK_MONTH';
   1: tempTableUpMonth := 'TMP_RCK_MONTH';
   4: tempTableUpMonth := 'session.TMP_RCK_MONTH';
   5: tempTableUpMonth := 'TMP_RCK_MONTH';
  end;
  //生数据临时表
  SQL:=GetTempMonthSQL(tempTableUpMonth);
  CreateTable(tempTableUpMonth,SQL,'TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO',True);
end;

function TCalcForGodsMonth.CleanTempMonth: boolean;
begin
  try
    case iDbType of
     0,1:FdbHelp.ExecSQL('truncate table '+tempTableUpMonth);
     4: FdbHelp.ExecSQL(GetTempMonthSQL(tempTableUpMonth));
     5:FdbHelp.ExecSQL('delete from '+tempTableUpMonth);
    end;
  except
  end;
end;

{ TCalcForDayAcct }

function TCalcForDayAcct.DoCalcReck(Rck_Beg_Date,Rck_End_Date:TDate): Boolean;
var
  i:integer;
  pt:integer;
  SQL,Tab:string;
begin
  result:=False;
  pt:=Round(Rck_End_Date-Rck_Beg_Date); //本区间天数
  ReckBegDate:=Rck_Beg_Date;
  ReckEndDate:=Rck_End_Date;

  //1、删除历史数据
  if ReckBegDate = ReckEndDate then
    SQL:=' and CREA_DATE='+formatDatetime('YYYYMMDD',ReckBegDate)
  else
    SQL:=' and CREA_DATE>='+formatDatetime('YYYYMMDD',ReckBegDate)+' and CREA_DATE<='+formatDatetime('YYYYMMDD',ReckEndDate);
  FdbHelp.ExecSQL('delete from RCK_ACCT_DAYS where TENANT_ID='+inttostr(TENANT_ID)+SQL);

  //2、启动事务循环每天插入
  //if iDbType<>5 then FdbHelp.BeginTrans;
  try
    //开始循环执行
    for i:= 0 to pt do
    begin
      SQL :=
        'insert into RCK_ACCT_DAYS('+
        'TENANT_ID,SHOP_ID,CREA_DATE,ACCOUNT_ID,'+
        'ORG_MNY,IN_MNY,OUT_MNY,BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY,COMM,TIME_STAMP '+
        ') '+
        'select '+
        'TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMMDD',ReckBegDate+i)+',ACCOUNT_ID,'+
        'sum(ORG_MNY),sum(IN_MNY),sum(OUT_MNY),sum(ORG_MNY)+sum(IN_MNY)-sum(OUT_MNY),'+
        'sum(PAY_MNY),sum(RECV_MNY),sum(POS_MNY),sum(TRN_IN_MNY),sum(TRN_OUT_MNY),sum(PUSH_MNY),sum(IORO_IN_MNY),sum(IORO_OUT_MNY),'+
        '''00'' as COMM,'+GetTimeStamp(iDbType)+' '+
        'from('+
        'select '+
        'B.TENANT_ID,B.SHOP_ID,B.ACCOUNT_ID,'+
        'isnull(A.BAL_MNY,0)+isnull(B.ORG_MNY,0) as ORG_MNY,0 as IN_MNY,0 as OUT_MNY,0 as BAL_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY '+
        'from ACC_ACCOUNT_INFO B left outer join (select * from RCK_ACCT_DAYS where TENANT_ID='+inttostr(TENANT_ID)+' and CREA_DATE='+formatDatetime('YYYYMMDD',ReckBegDate+i-1)+') A '+
        'on B.TENANT_ID=A.TENANT_ID and B.ACCOUNT_ID=A.ACCOUNT_ID where B.TENANT_ID='+inttostr(TENANT_ID)+' '+
        'union all '+
        'select '+
        'A.TENANT_ID,B.SHOP_ID,A.ACCOUNT_ID,'+
        '0 as ORG_MNY,A.IN_MNY,A.OUT_MNY,0 as BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY '+
        'from VIW_ACCT_DAYS A,ACC_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.ACCOUNT_ID=B.ACCOUNT_ID and A.TENANT_ID='+inttostr(TENANT_ID)+' and A.CREA_DATE='+formatDatetime('YYYYMMDD',ReckBegDate+i)+' '+
        ') j group by TENANT_ID,SHOP_ID,ACCOUNT_ID';
      FdbHelp.ExecSQL(ParseSQL(iDbType,SQL));
    end;
    //if iDbType<>5 then FdbHelp.CommitTrans;
    result:=True;
  except
    //if iDbType<>5 then FdbHelp.RollbackTrans;
    raise;
  end;
end;

{ TCalcForMonthAcct }

function TCalcForMonthAcct.DoCalcReck(RckBeg_Date,RckEnd_Date: TDate): Boolean;
var
  SQL:string;
begin
  result:=False;
  //if iDbType <> 5 then FdbHelp.BeginTrans;
  try
    //1、删除历史数据
    SQL := 'delete from RCK_ACCT_MONTH where TENANT_ID='+inttostr(TENANT_ID)+' and MONTH='+formatDatetime('YYYYMM',RckEnd_Date);
    FdbHelp.ExecSQL(SQL);

    //2、生成月账户账款
    SQL :=
      ParseSQL(iDbType,
        'insert into RCK_ACCT_MONTH('+
        'TENANT_ID,SHOP_ID,MONTH,ACCOUNT_ID,'+
        'ORG_MNY,IN_MNY,OUT_MNY,BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY,COMM,TIME_STAMP '+
        ') '+
        'select '+
          'TENANT_ID,SHOP_ID,'+formatDatetime('YYYYMM',RckEnd_Date)+' as MONTH,ACCOUNT_ID,'+
          'sum(ORG_MNY),sum(IN_MNY),sum(OUT_MNY),sum(ORG_MNY)+sum(IN_MNY)-sum(OUT_MNY),'+
          'sum(PAY_MNY),sum(RECV_MNY),sum(POS_MNY),sum(TRN_IN_MNY),sum(TRN_OUT_MNY),sum(PUSH_MNY),sum(IORO_IN_MNY),sum(IORO_OUT_MNY),'+
          '''00'' as COMM,'+GetTimeStamp(iDbType)+' '+
        'from '+
        '('+
          'select '+
          ' B.TENANT_ID,B.SHOP_ID,B.ACCOUNT_ID,'+
          'isnull(A.BAL_MNY,0)+isnull(B.ORG_MNY,0) as ORG_MNY,0 as IN_MNY,0 as OUT_MNY,0 as BAL_MNY,0 as PAY_MNY,0 as RECV_MNY,0 as POS_MNY,0 as TRN_IN_MNY,0 as TRN_OUT_MNY,0 as PUSH_MNY,0 as IORO_IN_MNY,0 as IORO_OUT_MNY '+
          'from ACC_ACCOUNT_INFO B '+
          ' left outer join '+
          ' (select TENANT_ID,ACCOUNT_ID,BAL_MNY from RCK_ACCT_MONTH where TENANT_ID='+inttostr(TENANT_ID)+' and MONTH='+formatDatetime('YYYYMM',incmonth(RckEnd_Date,-1))+') A '+
          'on B.TENANT_ID=A.TENANT_ID and B.ACCOUNT_ID=A.ACCOUNT_ID where B.TENANT_ID='+inttostr(TENANT_ID)+' '+
        'union all '+
          'select '+
          ' TENANT_ID,SHOP_ID,ACCOUNT_ID,0 as ORG_MNY,IN_MNY,OUT_MNY,0 as BAL_MNY,PAY_MNY,RECV_MNY,POS_MNY,TRN_IN_MNY,TRN_OUT_MNY,PUSH_MNY,IORO_IN_MNY,IORO_OUT_MNY '+
          'from RCK_ACCT_DAYS A '+
          ' where A.TENANT_ID='+inttostr(TENANT_ID)+' and A.CREA_DATE>='+formatDatetime('YYYYMMDD',RckBeg_Date)+' and A.CREA_DATE<='+formatDatetime('YYYYMMDD',RckEnd_Date)+' '+
        ') j '+
        ' group by TENANT_ID,SHOP_ID,ACCOUNT_ID'
      );
    FdbHelp.ExecSQL(SQL);
    //if iDbType <> 5 then FdbHelp.CommitTrans;
    result:=true;
  except
    //if iDbType <> 5 then FdbHelp.RollbackTrans;
    Raise;
  end;
end;

{ TCalcForGodsAnaly }

function TCalcForGodsAnaly.CleanTempGodsAnaly: boolean;
begin
  //先清空临时表
  case iDbType of
   0,1:FdbHelp.ExecSQL('truncate table '+tempTableGods);
   4:FdbHelp.ExecSQL(GetTempAnalySQL(tempTableGods));
   5:FdbHelp.ExecSQL('delete from '+tempTableGods);
  end;
end;

procedure TCalcForGodsAnaly.ClearAnalyTempTable(TabName: string);
begin
  //先清空临时表
  case iDbType of
   0,1:FdbHelp.ExecSQL('truncate table '+TabName);
   4:
     begin
       FdbHelp.ExecSQL(GetTempAnalySQL(TabName));
       //FdbHelp.ExecSQL('CREATE INDEX '+TabName+'_IDX ON '+TabName+'(TENANT_ID,GODS_ID)');
     end;
   5:FdbHelp.ExecSQL('delete from '+TabName);
  end;
end;

function TCalcForGodsAnaly.CreateGoodTable: Boolean;
var
  TabSQL:string;
begin
  result:=False;
  //商品档案临时表
  tempTableGods:='';
  case iDbType of
   0: tempTableGods := '#T_GOODS';
   1: tempTableGods := 'T_GOODS';
   4: tempTableGods := 'session.T_GOODS';
   5: tempTableGods := 'T_GOODS';
  end;
  TabSQL:=GetTempGoodSQL(tempTableGods);
  //立即生成临时表数据
  CreateTable(tempTableGods,TabSQL,'TENANT_ID,GODS_ID');
  TabSQL:=
    'insert into '+tempTableGods+'(TENANT_ID,GODS_ID,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,'+
                            'SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20)'+
    'select TENANT_ID,GODS_ID,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,'+
    ' SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20 from VIW_GOODSINFO '+
    ' where TENANT_ID='+IntToStr(TENANT_ID);
  FdbHelp.ExecSQL(TabSQL);
  result:=true;
end;

procedure TCalcForGodsAnaly.CreateNew;
var
  TabSQL:string;
begin
  tempTableUpShop:='';
  case iDbType of
   0: tempTableUpShop := '#TMP_INSHOP';
   1: tempTableUpShop := 'TMP_INSHOP';
   4: tempTableUpShop := 'session.TMP_INSHOP';
   5: tempTableUpShop := 'TMP_INSHOP';   
  end;
  //生数据临时表
  TabSQL:=GetTempAnalySQL(tempTableUpShop);
  CreateTable(tempTableUpShop,TabSQL,'TENANT_ID,SHOP_ID,GODS_ID',False);
end;

function TCalcForGodsAnaly.DoCalcGodsAnaly: Boolean;
var
  SQL,id,v,v1,v2,sid:string;
  safe,reas,daySale,w:integer;
  LRate,HRate:real;
  rs:TZQuery;
begin
  result:=False;
  try
    safe := Params.ParamByName('SAFE_DAY').AsInteger;
    reas := Params.ParamByName('REAS_DAY').AsInteger;
    daySale := Params.ParamByName('DAY_SALE_STAND').AsInteger;
    sid := Params.ParamByName('SMT_RATE').AsString;

    //判断并插入不存在记录商品
    SQL :=
      'insert into PUB_GOODS_INSHOP(TENANT_ID,GODS_ID,SHOP_ID,COMM,TIME_STAMP)'+
      'select TENANT_ID,GODS_ID,SHOP_ID,''00'','+GetTimeStamp(iDbType)+' from VIW_GOODSPRICE A where TENANT_ID='+inttostr(TENANT_ID)+' and '+
      'not Exists(select * from PUB_GOODS_INSHOP where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and SHOP_ID=A.SHOP_ID)';
    FdbHelp.ExecSQL(SQL);

    //1、算近期销量(NEAR_SALE_AMT)
    ClearAnalyTempTable(tempTableUpShop);
    SQL:=                                                                              
       'insert into '+tempTableUpShop+'(TENANT_ID,SHOP_ID,GODS_ID,SALE_AMT)'+
       'select TENANT_ID,SHOP_ID,GODS_ID,sum(CALC_AMOUNT)as SALE_AMT from VIW_SALESDATA where TENANT_ID='+inttostr(TENANT_ID)+
       ' and SALES_DATE>='+FormatDatetime('YYYYMMDD',Date-safe-1)+' and SALES_DATE<='+formatDatetime('YYYYMMDD',Date-1)+' '+
       ' group by TENANT_ID,SHOP_ID,GODS_ID';
    FdbHelp.ExecSQL(SQL);
    //更新PUB_GOODS_INSHOP.NEAR_SALE_AMT
    SQL :=
      'update PUB_GOODS_INSHOP set NEAR_SALE_AMT=(select SALE_AMT from '+tempTableUpShop+' where TENANT_ID='+inttostr(TENANT_ID)+
      ' and TENANT_ID=PUB_GOODS_INSHOP.TENANT_ID and SHOP_ID=PUB_GOODS_INSHOP.SHOP_ID and GODS_ID=PUB_GOODS_INSHOP.GODS_ID) '+
      'where TENANT_ID='+inttostr(TENANT_ID);
    FdbHelp.ExecSQL(SQL);

    //2、日均销量测算(DAY_SALE_AMT)
    ClearAnalyTempTable(tempTableUpShop);
    SQL:=
      'insert into '+tempTableUpShop+'(TENANT_ID,SHOP_ID,GODS_ID,SALE_AMT)'+
      'select TENANT_ID,SHOP_ID,GODS_ID,round((DAY_SALE_AMT*1.000000/'+GetDayDiff(iDbType,'MIN_SALES_DATE','MAX_SALES_DATE')+'),3)as SALE_AMT '+
      ' from (select TENANT_ID,SHOP_ID,GODS_ID,sum(CALC_AMOUNT)as DAY_SALE_AMT,min(SALES_DATE)as MIN_SALES_DATE,max(SALES_DATE)as MAX_SALES_DATE from VIW_SALESDATA where TENANT_ID='+inttostr(TENANT_ID)+
      ' and SALES_DATE>='+FormatDatetime('YYYYMMDD',Date-daySale-1)+' and SALES_DATE<='+formatDatetime('YYYYMMDD',Date-1)+' '+
      ' group by TENANT_ID,SHOP_ID,GODS_ID)tp';
    FdbHelp.ExecSQL(SQL);
    //更新PUB_GOODS_INSHOP.DAY_SALE_AMT
    SQL :=
      'update PUB_GOODS_INSHOP set DAY_SALE_AMT=(select SALE_AMT from '+tempTableUpShop+' where TENANT_ID='+inttostr(TENANT_ID)+
      ' and TENANT_ID=PUB_GOODS_INSHOP.TENANT_ID and SHOP_ID=PUB_GOODS_INSHOP.SHOP_ID and GODS_ID=PUB_GOODS_INSHOP.GODS_ID) '+
      'where TENANT_ID='+inttostr(TENANT_ID);
    FdbHelp.ExecSQL(SQL);

    //3、本月销量(MTH_SALE_AMT)
    ClearAnalyTempTable(tempTableUpShop);
    SQL:=
      'insert into '+tempTableUpShop+'(TENANT_ID,SHOP_ID,GODS_ID,SALE_AMT)'+
      'select TENANT_ID,SHOP_ID,GODS_ID,sum(CALC_AMOUNT) as SALE_AMT from VIW_SALESDATA where TENANT_ID='+inttostr(TENANT_ID)+
      ' and SALES_DATE>='+formatDatetime('YYYYMM01',Date)+' and SALES_DATE<='+formatDatetime('YYYYMMDD',Date-1)+
      ' group by TENANT_ID,SHOP_ID,GODS_ID ';
    FdbHelp.ExecSQL(SQL);
    //更新PUB_GOODS_INSHOP.MTH_SALE_AMT
    SQL :=
      'update PUB_GOODS_INSHOP set MTH_SALE_AMT=(select SALE_AMT from '+tempTableUpShop+' where TENANT_ID='+inttostr(TENANT_ID)+
      ' and TENANT_ID=PUB_GOODS_INSHOP.TENANT_ID and SHOP_ID=PUB_GOODS_INSHOP.SHOP_ID and GODS_ID=PUB_GOODS_INSHOP.GODS_ID) '+
      'where TENANT_ID='+inttostr(TENANT_ID);
    FdbHelp.ExecSQL(SQL);

    //4、安全库存及合理库存测算
    SQL :=
      'update PUB_GOODS_INSHOP set LOWER_AMOUNT=DAY_SALE_AMT*'+inttostr(safe)+',UPPER_AMOUNT=DAY_SALE_AMT*'+inttostr(reas)+' '+
      'where TENANT_ID='+inttostr(TENANT_ID)+'';
    FdbHelp.ExecSQL(SQL);
 
    if sid='' then sid := '2';
    //计算存销比
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID='+inttostr(TENANT_ID)+' and DEFINE like ''SMT_RATE_%'' and COMM not in (''02'',''12'')';
      FdbHelp.Open(rs);
      if not rs.IsEmpty then CreateGoodTable; //创建商品临时表
      rs.First;
      while not rs.Eof do
      begin
        id := copy(rs.Fields[0].AsString,1,36);
        v := trim(copy(rs.Fields[0].AsString,38,555));
        w := pos('-',v);
        v1:= copy(v,1,w-1);
        v2:= copy(v,w+1,20);
        SQL:='update PUB_GOODS_INSHOP set LOWER_RATE='+v1+',UPPER_RATE='+v2+' where TENANT_ID='+inttostr(TENANT_ID)+
             ' and exists(select * from '+tempTableGods+' where TENANT_ID=PUB_GOODS_INSHOP.TENANT_ID and GODS_ID=PUB_GOODS_INSHOP.GODS_ID and SORT_ID'+sid+'='''+id+''')';
        FdbHelp.ExecSQL(SQL);
        rs.Next;
      end;
    finally
      rs.Free;
    end;
  finally
    try
      ClearAnalyTempTable(tempTableUpShop);
      CleanTempGodsAnaly;
    except
    end;
  end;
  result:=True;
end;

function TCalcForGodsAnaly.GetTempAnalySQL(tb: string): string;
begin
  case iDbType of
   0,5:
    result :=
      'CREATE TABLE '+tb+' ('+
      '	TENANT_ID int NOT NULL ,'+
      ' SHOP_ID varchar(13) NOT NULL , '+
      '	GODS_ID varchar (36) NOT NULL ,'+
      '	SALE_AMT decimal(18, 3) NULL '+
      ')';
   1:
    result :=
      'create global temporary table '+tb+' ('+
      '	TENANT_ID int NOT NULL ,'+
      ' SHOP_ID varchar2 (13) NOT NULL , '+
      '	GODS_ID varchar2 (36) NOT NULL ,'+
      '	SALE_AMT decimal(18, 3) '+
      ') ON COMMIT PRESERVE ROWS';
   4:
    result :=
     'declare global temporary table '+tb+' ('+
      ' TENANT_ID int NOT NULL ,'+
      ' SHOP_ID varchar(13) NOT NULL , '+
      ' GODS_ID varchar (36) NOT NULL ,'+
      '	SALE_AMT decimal(18, 3) '+
      ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
  end;
end;

{ TCostCalcForAnalyLister }

//商品分析统计
function TCostCalcForAnalyLister.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  GodsAnalyCalc: TCalcForGodsAnaly;
begin
  result:=False;
  try
    //针对SQLITE启动全程事务
    if AGlobal.iDbType=5 then AGlobal.BeginTrans;
    try
      GodsAnalyCalc:=TCalcForGodsAnaly.Create;
      GodsAnalyCalc.SetInParams(AGlobal,Params,TENANT_ID,USER_ID,bDate);
      result:=GodsAnalyCalc.DoCalcGodsAnaly;
      if AGlobal.iDbType=5 then AGlobal.CommitTrans;
      if result then Msg:='RCK_OK';
    except
      on E:Exception do
      begin
        if AGlobal.iDbType=5 then AGlobal.RollbackTrans;
        result:=False;
        Msg:=E.Message;
        Raise;
      end;
    end;
  finally
    GodsAnalyCalc.Free;
  end;
end;

{ TCostCalcForReck }

function TCostCalcForDayReck.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  //命令类型(1:计算成本价生成台账;2:零售交班结账;3:计算账户台账;4:日结账关账;5:更新当前库存成本价);
  i:integer; 
  CalcCmdIdx:integer;
  RCK_BEG_DATE:TDate;  //业务开始日期
  RCK_END_DATE:TDate;  //业务结束日期
  ReValue:Boolean;
begin
  result:=False;
  inherited Execute(AGlobal,Params);
  CalcCmdIdx:=Params.ParamByName('CALC_CMD_IDX').AsInteger;
  RCK_BEG_DATE:=fnTime.fnStrtoDate(Params.ParamByName('RCK_BEG_DATE').AsString);  //业务开始日期
  RCK_END_DATE:=fnTime.fnStrtoDate(Params.ParamByName('RCK_END_DATE').AsString);  //业务结束日期
                                                         
  //针对SQLITE启动全程事务
  if AGlobal.iDbType=5 then AGlobal.BeginTrans;
  try
    //命令类型
    case CalcCmdIdx of
     1,2,3:
      begin
        try
          case CalcCmdIdx of
           1:FBaseCalc:=TCalcForGodsCost.Create;  //计算成本价生成台账
           2:FBaseCalc:=TCalcForPosReck.Create;   //零售交班结账
           3:FBaseCalc:=TCalcForDayAcct.Create;   //计算账户台账
          end;
          FBaseCalc.SetInParams(AGlobal,Params,TENANT_ID,USER_ID,bDate);
          result:=FBaseCalc.DoCalcReck(RCK_BEG_DATE,RCK_END_DATE);
        finally
          FBaseCalc.Free;
        end;
      end;
     4: //日结账关账
      begin
        try
          FDayReckClose:=TCalcForCloseReck.Create;
          FDayReckClose.SetInParams(AGlobal,Params,TENANT_ID,USER_ID,bDate);
          result:=FDayReckClose.DoEndRckDaysClose(RCK_BEG_DATE,RCK_END_DATE);
        finally
          FDayReckClose.Free;
        end;
      end;
     5: //更新当前库存成本价
      begin
        try
          FUpStroageCalc:=TCalcForUpStroage.Create;
          FUpStroageCalc.SetInParams(AGlobal,Params,TENANT_ID,USER_ID,bDate);
          result:=FUpStroageCalc.DoCalcUpdateStroage(RCK_BEG_DATE);
        finally
          FUpStroageCalc.Free;
        end;
      end;
    end;
    if AGlobal.iDbType=5 then AGlobal.CommitTrans;
    if result then Msg:='RCK_OK';
  except
    on E:Exception do
    begin
      if AGlobal.iDbType=5 then AGlobal.RollbackTrans;
      result:=False;
      Msg:=E.Message;
      Raise;
    end;
  end;
end;

function TCalcForGodsAnaly.GetTempGoodSQL(tb: string): string;
begin
  case iDbType of
   0,5:result :=
        'CREATE TABLE '+tb+' ('+
        '	TENANT_ID int NOT NULL ,'+
        '	GODS_ID varchar (36)  NOT NULL ,'+
        ' SORT_ID1 varchar (36)  NOT NULL ,'+
        ' SORT_ID2 varchar (36)  NOT NULL ,'+
        ' SORT_ID3 varchar (36)  NOT NULL ,'+
        ' SORT_ID4 varchar (36)  NOT NULL ,'+
        ' SORT_ID5 varchar (36)  NOT NULL ,'+
        ' SORT_ID6 varchar (36)  NOT NULL ,'+
        ' SORT_ID7 varchar (36)  NOT NULL ,'+
        ' SORT_ID8 varchar (36)  NOT NULL ,'+
        ' SORT_ID9 varchar (36)  NOT NULL ,'+
        ' SORT_ID10 varchar (36)  NOT NULL ,'+
        ' SORT_ID11 varchar (36)  NOT NULL ,'+
        ' SORT_ID12 varchar (36)  NOT NULL ,'+
        ' SORT_ID13 varchar (36)  NOT NULL ,'+
        ' SORT_ID14 varchar (36)  NOT NULL ,'+
        ' SORT_ID15 varchar (36)  NOT NULL ,'+
        ' SORT_ID16 varchar (36)  NOT NULL ,'+
        ' SORT_ID17 varchar (36)  NOT NULL ,'+
        ' SORT_ID18 varchar (36)  NOT NULL ,'+
        ' SORT_ID19 varchar (36)  NOT NULL ,'+
        ' SORT_ID20 varchar (36)  NOT NULL '+
        ')';
   1: result :=
        'create global temporary table '+tb+' ('+
        ' TENANT_ID NUMBER(9,0) NOT NULL ,'+
        ' GODS_ID varchar2(36)  NOT NULL ,'+
        ' SORT_ID1 varchar2(36)  NOT NULL ,'+
        ' SORT_ID2 varchar2(36)  NOT NULL ,'+
        ' SORT_ID3 varchar2(36)  NOT NULL ,'+
        ' SORT_ID4 varchar2(36)  NOT NULL ,'+
        ' SORT_ID5 varchar2(36)  NOT NULL ,'+
        ' SORT_ID6 varchar2(36)  NOT NULL ,'+
        ' SORT_ID7 varchar2(36)  NOT NULL ,'+
        ' SORT_ID8 varchar2(36)  NOT NULL ,'+
        ' SORT_ID9 varchar2(36)  NOT NULL ,'+
        ' SORT_ID10 varchar2(36)  NOT NULL ,'+
        ' SORT_ID11 varchar2(36)  NOT NULL ,'+
        ' SORT_ID12 varchar2(36)  NOT NULL ,'+
        ' SORT_ID13 varchar2(36)  NOT NULL ,'+
        ' SORT_ID14 varchar2(36)  NOT NULL ,'+
        ' SORT_ID15 varchar2(36)  NOT NULL ,'+
        ' SORT_ID16 varchar2(36)  NOT NULL ,'+
        ' SORT_ID17 varchar2(36)  NOT NULL ,'+
        ' SORT_ID18 varchar2(36)  NOT NULL ,'+
        ' SORT_ID19 varchar2(36)  NOT NULL ,'+
        ' SORT_ID20 varchar2(36)  NOT NULL '+
        ') ON COMMIT PRESERVE ROWS';
   4: result :=
        'declare global temporary table '+tb+' ('+
        '	TENANT_ID int NOT NULL ,'+
        '	GODS_ID varchar (36)  NOT NULL ,'+
        '	SORT_ID1 varchar (36)  NOT NULL ,'+
        '	SORT_ID2 varchar (36)  NOT NULL ,'+
        '	SORT_ID3 varchar (36)  NOT NULL ,'+
        '	SORT_ID4 varchar (36)  NOT NULL ,'+
        '	SORT_ID5 varchar (36)  NOT NULL ,'+
        '	SORT_ID6 varchar (36)  NOT NULL ,'+
        '	SORT_ID7 varchar (36)  NOT NULL ,'+
        '	SORT_ID8 varchar (36)  NOT NULL ,'+
        '	SORT_ID9 varchar (36)  NOT NULL ,'+
        '	SORT_ID10 varchar (36)  NOT NULL ,'+
        '	SORT_ID11 varchar (36)  NOT NULL ,'+
        '	SORT_ID12 varchar (36)  NOT NULL ,'+
        '	SORT_ID13 varchar (36)  NOT NULL ,'+
        '	SORT_ID14 varchar (36)  NOT NULL ,'+
        '	SORT_ID15 varchar (36)  NOT NULL ,'+
        '	SORT_ID16 varchar (36)  NOT NULL ,'+
        '	SORT_ID17 varchar (36)  NOT NULL ,'+
        '	SORT_ID18 varchar (36)  NOT NULL ,'+
        '	SORT_ID19 varchar (36)  NOT NULL ,'+
        '	SORT_ID20 varchar (36)  NOT NULL '+
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE';
  end;
end;

{ TCostCalcForMonthReck }

function TCostCalcForMonthReck.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  //命令类型(1:生成商品月台账(流水表);2:生成账户(流水表);3:月帐户的关账CLOSE;);
  i:integer; 
  CalcCmdIdx:integer;
  RCK_BEG_DATE:TDate;  //业务开始日期
  RCK_END_DATE:TDate;  //业务结束日期
begin
  result:=False;
  inherited Execute(AGlobal,Params);
  CalcCmdIdx:=Params.ParamByName('CALC_CMD_IDX').AsInteger;
  RCK_BEG_DATE:=fnTime.fnStrtoDate(Params.ParamByName('RCK_BEG_DATE').AsString);  //业务开始日期
  RCK_END_DATE:=fnTime.fnStrtoDate(Params.ParamByName('RCK_END_DATE').AsString);;  //业务结束日期

  //针对SQLITE启动全程事务
  if AGlobal.iDbType=5 then AGlobal.BeginTrans;
  try
    //命令类型
    case CalcCmdIdx of
     1,2:
      begin
        try
          case CalcCmdIdx of
           1: FBaseCalc:=TCalcForGodsMonth.Create; //商品月台账
           2: FBaseCalc:=TCalcForMonthAcct.Create; //账户月台账
          end;
          FBaseCalc.SetInParams(AGlobal,Params,TENANT_ID,USER_ID,bDate);
          result:=FBaseCalc.DoCalcReck(RCK_BEG_DATE,RCK_END_DATE);
        finally
          FBaseCalc.Free;
        end;
      end;
     3: //日结账关账
      begin
        try
          FMthReckClose:=TCalcForCloseReck.Create;
          FMthReckClose.SetInParams(AGlobal,Params,TENANT_ID,USER_ID,bDate);
          result:=FMthReckClose.DoEndRckMonthClose(RCK_BEG_DATE,RCK_END_DATE);
        finally
          FMthReckClose.Free;
        end;
      end;
    end;
    if AGlobal.iDbType=5 then AGlobal.CommitTrans;
    if result then Msg:='RCK_OK';
  except
    on E:Exception do
    begin
      if AGlobal.iDbType=5 then AGlobal.RollbackTrans;
      result:=False;
      Msg:=E.Message;
      Raise;
    end;
  end;
end;


initialization
  RegisterClass(TCheckCostCalc);
  RegisterClass(TCostCalcForAnalyLister);
  RegisterClass(TCostCalcForDayReck);
  RegisterClass(TCostCalcForMonthReck);

finalization
  UnRegisterClass(TCheckCostCalc);
  UnRegisterClass(TCostCalcForAnalyLister);
  UnRegisterClass(TCostCalcForDayReck);    
  UnRegisterClass(TCostCalcForMonthReck);

end.
