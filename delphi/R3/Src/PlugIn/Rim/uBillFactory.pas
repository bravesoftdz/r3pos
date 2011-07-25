{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)关于单位换算及上报单位:
    A、R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;
    B、上报数据是汇总数据，转成管理单位上报给Rim，单位根据管理单位名称对应ID值上报;
    C、流水单据上报按原单据单位上报;

 ------------------------------------------------------------------------------}

unit uBillFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  Forms, uBaseSyncFactory, uRimSyncFactory;

type
  TBillSyncFactory=class(TRimSyncFactory)
  private
    FBillType: string;
    FTempTableName: string;
    FBillMainTable: string;
    FBillKeyField: string;
    FINFKeyField: string;
    procedure SetBillType(const Value: string);      //单据类型
    procedure SetTempTableName(const Value: string);
    procedure SetBillKeyField(const Value: string);
    procedure SetBillMainTable(const Value: string);
    procedure SetINFKeyField(const Value: string);

    //上报月台账
    function SendMonthReck: integer;
    //上报销售单[零售、批发、退货]
    function SendSalesDetail: integer;
    //上报调拨单（调入）
    function SenddbInDetail: integer;
    //上报调拨单（调出）
    function SenddbOutDetail: integer;
    //上报入库单 [入库、退货]
    function SendStockDetail: integer;
    //上报调整单
    function SendChangeDetail: integer;

    //开始前取时间戳和清空中间表数据
    function BeginPrepare: Boolean;
    //提交上报控制事务
    function CommitReportTrans: Boolean;

    function Test(SQL: string): integer;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
    property BillType: string read FBillType write SetBillType;                 //单据类型
    property TempTableName: string read FTempTableName write SetTempTableName;  //单据类型
    property BillMainTable: string read FBillMainTable write SetBillMainTable;  //单据主表表名
    property BillKeyField: string read FBillKeyField write SetBillKeyField;     //单据关联关键字
    property INFKeyField: string read FINFKeyField write SetINFKeyField;     //单据关联关键字
  end;


implementation

{ TSalesTotalSyncFactory }

function TBillSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;  //返回上报成功记录
  ErrorFlag: Boolean;  //运行状态   
begin
  result:=-1;
  {------初始化参数------}
  PlugIntf:=GPlugIn;
  HasError:=False;
  ErrorMsg:='';
  GetDBType;    //1、返回数据库类型
  Params.Decode(Params, InParamStr); //2、还原ParamsList的参数对象
  GetSyncType;  //3、返回同步类型标记

  {------开始运行日志------}
  BeginLogRun;
  try
    DBLock(true);  //锁定数据库链接   

    //返回R3的上报ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      FRunInfo.ErrorStr:='企业ID('+RimParam.TenID+')没有对应可上报门店(上报退出执行)！';
      result:=0;
      Exit;
    end;

    //按门店ID排序循环上报
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      RimParam.CustID:='';
      try
        ErrorFlag:=False; //当前门店跟踪运行状态 
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);   //R3企业ID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString); //R3企业名称 (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);     //R3门店ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);  //R3门店名称 (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString); //R3门店许可证号 (Field: LICENSE_CODE)
        RimParam.SHORT_ShopID:=Copy(RimParam.ShopID,Length(RimParam.ShopID)-3,4);     //门店ID的后4位

        //传入R3门店ID,返回RIM的烟草公司ComID,零售户CustID;
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID); //返回烟草公司ComID、零售户CustID

        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          LogInfo.BeginLog(RimParam.TenName+'-'+RimParam.ShopName); //开始日志
          
          //开始上报月台帐：
          try
            iRet:=SendMonthReck;
            LogInfo.AddBillMsg('月台帐',iRet);
          except
            on E:Exception do
            begin
              LogInfo.AddBillMsg('月台帐',-1);
              WriteRunErrorMsg(E.Message);
              if not ErrorFlag then ErrorFlag:=true;
            end;
          end;

          //上报销售单 [零售、批发、退货]
          try
            iRet:=SendSalesDetail;
            LogInfo.AddBillMsg('销售单',iRet);
          except
            on E:Exception do
            begin
              LogInfo.AddBillMsg('销售单',-1);
              WriteRunErrorMsg(E.Message);
              if not ErrorFlag then ErrorFlag:=true;
            end;
          end;

          //上报调拨单（调入）
          try
            iRet:=SenddbInDetail;
            LogInfo.AddBillMsg('调拨单(入)',iRet);
          except
            on E:Exception do
            begin
              LogInfo.AddBillMsg('调拨单(入)',-1);
              WriteRunErrorMsg(E.Message);
              if not ErrorFlag then ErrorFlag:=true;
            end;
          end;

          //上报调拨单（调出）
          try
            iRet:=SenddbOutDetail;
            LogInfo.AddBillMsg('调拨单(出)',iRet);
          except
            on E:Exception do
            begin
              LogInfo.AddBillMsg('调拨单(出)',-1);
              WriteRunErrorMsg(E.Message);
              if not ErrorFlag then ErrorFlag:=true;
            end;
          end;
      
          //上报入库单
          try
            iRet:=SendStockDetail;
            LogInfo.AddBillMsg('入库单',iRet);
          except
            on E:Exception do
            begin
              LogInfo.AddBillMsg('入库单',-1);
              WriteRunErrorMsg(E.Message);
              if not ErrorFlag then ErrorFlag:=true;
            end;
          end;

          //上报调整单
          try
            iRet:=SendChangeDetail;
            LogInfo.AddBillMsg('调整单',iRet);
          except
            on E:Exception do
            begin
              LogInfo.AddBillMsg('调整单',-1);
              WriteRunErrorMsg(E.Message);
              if not ErrorFlag then ErrorFlag:=true;
            end;
          end;
          WriteToLogList(true,ErrorFlag); //写当前上报情况日志
        end else
          WriteToLogList(False); //没有对应上写日志
      except
        on E: Exception do
        begin
          PlugIntf.WriteLogFile(Pchar('<1003>'+E.Message));
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //总门店数
    DBLock(False); //解锁
    WriteLogRun('业务流水单据'); //输出到文本日志
  end;
end;

procedure TBillSyncFactory.SetTempTableName(const Value: string);
begin
  FTempTableName := Value;
end;

procedure TBillSyncFactory.SetBillType(const Value: string);
begin
  FBillType := Value;
end;

procedure TBillSyncFactory.SetBillKeyField(const Value: string);
begin
  FBillKeyField := Value;
end;

procedure TBillSyncFactory.SetBillMainTable(const Value: string);
begin
  FBillMainTable := Value;
end;

     
////上报月台账(type='00') [根据月台账表， 若月台帐表没有按月结帐则不上报—2011.06.03]
function TBillSyncFactory.SendMonthReck: integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀表名
  Str,MonthTab,ReckMonth,SHOP_IDS: string;
begin
  result := -1;
  UpiRet:=0;
  //返回当前门店相同许可证号一样的:SHOP_IDS
  SHOP_IDS:=GetShop_IDS(RimParam.TenID,RimParam.LICENSE_CODE);  

  //第一步: 创建台帐临时[INF_RECKMONTH]:
  case DbType of
   1:
    begin
      Session:='';
      ReckMonth:='to_char(A.MONTH) ';
    end;
   4:
    begin
      Session:='session.';
      ReckMonth:='ltrim(rtrim(char(A.MONTH))) ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKMONTH ('+
             'TENANT_ID INTEGER NOT NULL,'+         //R3企业ID
             'LICENSE_CODE VARCHAR(50) NOT NULL,'+  //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3门店ID的后四位
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //RIM零售户ID
             'ITEM_ID VARCHAR(30) NOT NULL,'+       //RIM商品ID
             'GODS_ID CHAR(36) NOT NULL,'+          //R3商品ID
             'UNIT_CALC DECIMAL (18,6),'+           //商品计量单位换算管理单位换算值
             'RECK_MONTH VARCHAR(8) NOT NULL'+      //台账月份
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建月台帐临时表出错：'+PlugIntf.GetLastError);
    end;
  end;

  //返回时间戳:
  MaxStmp:=GetMaxNUM('00',RimParam.ComID, RimParam.CustID, RimParam.ShopID); //返回时间戳和更新时间戳
  //先删除历史数据:
  Str:='delete from '+Session+'INF_RECKMONTH where TENANT_ID='+RimParam.TenID+' and LICENSE_CODE='''+RimParam.LICENSE_CODE+''' ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);

  //第二步: 大于时间戳的台帐插入临时表:
  //月台账表：
  MonthTab:='select M.* from RCK_GOODS_MONTH M,RCK_MONTH_CLOSE C where M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and M.MONTH=C.MONTH and '+
            ' M.TENANT_ID='+RimParam.TenID+' and M.SHOP_ID in ('+SHOP_IDS+') and C.TIME_STAMP>'+MaxStmp;
  //插入临时表：
  Str:='insert into '+Session+'INF_RECKMONTH(TENANT_ID,LICENSE_CODE,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_MONTH) '+
       'select A.TENANT_ID,'''+RimParam.LICENSE_CODE+''' as LICENSE_CODE,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,('+GetDefaultUnitCalc+') as UNIT_CALC,'+ReckMonth+' as RECK_MONTH '+
       ' from ('+MonthTab+') A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入月台帐临时表出错:'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //第三步: 先删除历史在插入:
  //1、先删除RIM月台账表掉需要重新上报记录:
  Str:='delete from RIM_CUST_MONTH A where A.COM_ID='''+RimParam.ComID+''' and A.CUST_ID='''+RimParam.CustID+''' and '+
       ' MONTH in (select distinct MONTH from '+Session+'INF_RECKMONTH where TENANT_ID='+RimParam.TenID+' and LICENSE_CODE='''+RimParam.LICENSE_CODE+''')';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除月台账历史数据出错：'+PlugIntf.GetLastError);

  //2、插入上报记录:
  MonthTab:=
    'select TENANT_ID,MONTH,GODS_ID,'+
         'cast(sum(ORG_AMT) as decimal(18,3)) as ORG_AMT,'+
         'cast(sum(ORG_MNY) as decimal(18,3)) as ORG_MNY,'+
         'cast(sum(STOCK_AMT) as decimal(18,3)) as STOCK_AMT,'+
         'cast(sum(STOCK_MNY) as decimal(18,3)) as STOCK_MNY,'+
         'cast(sum(SALE_AMT) as decimal(18,3)) as SALE_AMT,'+
         'cast(sum(SALE_MNY) as decimal(18,3)) as SALE_MNY,'+
         'cast(sum(SALE_TAX) as decimal(18,3)) as SALE_TAX,'+
         'cast(sum(SALE_RTL) as decimal(18,3)) as SALE_RTL,'+
         'cast(sum(SALE_CST) as decimal(18,3)) as SALE_CST,'+
         'cast(sum(CHANGE1_AMT) as decimal(18,3)) as CHANGE1_AMT,'+
         'cast(sum(CHANGE1_MNY) as decimal(18,3)) as CHANGE1_MNY,'+
         'cast(sum(CHANGE2_AMT) as decimal(18,3)) as CHANGE2_AMT,'+
         'cast(sum(CHANGE2_MNY) as decimal(18,3)) as CHANGE2_MNY,'+
         'cast(sum(CHANGE3_AMT) as decimal(18,3)) as CHANGE3_AMT,'+
         'cast(sum(CHANGE3_MNY) as decimal(18,3)) as CHANGE3_MNY,'+
         'cast(sum(CHANGE4_AMT) as decimal(18,3)) as CHANGE4_AMT,'+
         'cast(sum(CHANGE4_MNY) as decimal(18,3)) as CHANGE4_MNY,'+
         'cast(sum(CHANGE5_AMT) as decimal(18,3)) as CHANGE5_AMT,'+
         'cast(sum(CHANGE5_MNY) as decimal(18,3)) as CHANGE5_MNY,'+    
         'cast(sum(DBIN_AMT) as decimal(18,3)) as DBIN_AMT,'+
         'cast(sum(DBIN_MNY) as decimal(18,3)) as DBIN_MNY,'+
         'cast(sum(DBOUT_AMT) as decimal(18,3)) as DBOUT_AMT,'+
         'cast(sum(DBOUT_MNY) as decimal(18,3)) as DBOUT_MNY,'+
         'cast(sum(BAL_AMT) as decimal(18,3)) as BAL_AMT,'+
         'cast(sum(BAL_MNY) as decimal(18,3)) as BAL_MNY,'+
         'cast(sum(SALE_PRF) as decimal(18,3)) as SALE_PRF '+
     ' from RCK_GOODS_MONTH '+
     ' where TENANT_ID='+RimParam.TenID+' and SHOP_ID in ('+SHOP_IDS+') and TIME_STAMP>'+MaxStmp+' '+ 
     ' group by TENANT_ID,MONTH,GODS_ID';

  Str:=
    'insert into RIM_CUST_MONTH('+
        'COM_ID,CUST_ID,TERM_ID,ITEM_ID,MONTH,PRI3,PRI4,PRI_SOLD,AMT_GROSS_PROFIT_THEO,'+ //1:
        'QTY_IOM,AMT_IOM,'+              //2: 期初数量、金额
        'QTY_PURCH,AMT_PURCH,'+          //3: 入库数量、金额
        'QTY_SOLD,AMT_SOLD_WITH_TAX,'+   //4: 销售数量、含税金额
        'QTY_PROFIT,AMT_PROFIT,'+        //5: 溢余数量、金额
        'QTY_LOSS,AMT_LOSS,'+            //6: 溢损数量、金额
        'QTY_TAKE,AMT_TAKE,'+            //7: 调整数量、金额
        'QTY_TRN_IN,AMT_TRN_IN,'+        //8: 调入数量、金额
        'QTY_TRN_OUT,AMT_TRN_OUT,'+      //9: 调出数量、金额
        'QTY_EOM,AMT_EOM,'+              //10: 期末数量、金额
        'UNIT_COST,SUMCOST_SOLD,'+       //11: 单位成本、销售成本
        'AMT_GROSS_PROFIT,AMT_PROFIT_COM)'+  //12:毛利额、贡献毛利
    'select B.COM_ID,B.CUST_ID,SHORT_SHOP_ID,B.ITEM_ID,B.RECK_MONTH,0,0,0,0,'+     //1:
        '(case when B.UNIT_CALC>0 then ORG_AMT/B.UNIT_CALC else ORG_AMT end)as ORG_AMT,ORG_MNY,'+          //2:期初数量、金额
        '(case when B.UNIT_CALC>0 then STOCK_AMT/B.UNIT_CALC else STOCK_AMT end)as STOCK_AMT,STOCK_MNY,'+  //3:入库数量、金额
        '(case when B.UNIT_CALC>0 then SALE_AMT/B.UNIT_CALC else SALE_AMT end)as SALE_AMT,SALE_MNY+SALE_TAX,'+  //4:销售数量、含税金额
        '(case when CHANGE1_AMT>0 then (case when B.UNIT_CALC>0 then CHANGE1_AMT/B.UNIT_CALC else CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT>0 then CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+    //5: 溢余数量、金额
        '(case when CHANGE1_AMT<0 then (case when B.UNIT_CALC>0 then -CHANGE1_AMT/B.UNIT_CALC else -CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT<0 then -CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+ //6: 溢损数量、金额
        '(case when B.UNIT_CALC>0 then (CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)/B.UNIT_CALC else CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT end)as CHANGE_AMT,(CHANGE2_MNY+CHANGE3_MNY+CHANGE3_MNY+CHANGE4_MNY+CHANGE5_MNY) as CHANGE_MNY,'+ //7: 调整数量、金额
        '(case when B.UNIT_CALC>0 then DBIN_AMT/B.UNIT_CALC else DBIN_AMT end)as DBIN_AMT,DBIN_MNY,'+      //8: 调入数量、金额
        '(case when B.UNIT_CALC>0 then DBOUT_AMT/B.UNIT_CALC else DBOUT_AMT end)as DBOUT_AMT,DBOUT_MNY,'+  //9: 调出数量、金额
        '(case when B.UNIT_CALC>0 then BAL_AMT/B.UNIT_CALC else BAL_AMT end)as BAL_AMT,BAL_MNY,'+          //10: 期末数量、金额
        '(case when (case when B.UNIT_CALC>0 then SALE_AMT/B.UNIT_CALC else SALE_AMT end)>0 then SALE_CST*1.0/cast((case when B.UNIT_CALC>0 then SALE_AMT/B.UNIT_CALC else SALE_AMT end) as decimal(18,3)) else SALE_CST end) as PJ_CST,'+ //单位成本[]
        'SALE_CST,'+            //11: 单位成本、销售成本
        'SALE_PRF,0 '+                  //12: 毛利额、贡献毛利
    'from ('+MonthTab+') A,'+Session+'INF_RECKMONTH B '+   //RCK_GOODS_MONTH
    ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+ReckMonth+'=B.RECK_MONTH ';
  if PlugIntf.ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('上报月台账数据出错:'+PlugIntf.GetLastError);

  //3、更新月台帐标记和上报时间戳:[]
  try
    BeginTrans;
    //将月台帐上报的标记位:COMM的第1位设置为：1
    Str:='update RCK_MONTH_CLOSE A set COMM='+GetUpCommStr(DbType)+'  '+
         ' where A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID in ('+SHOP_IDS+') and '+ReckMonth+' in '+
         ' (select distinct RECK_MONTH from '+Session+'INF_RECKMONTH INF where INF.TENANT_ID='+RimParam.TenID+' and LICENSE_CODE='''+RimParam.LICENSE_CODE+''')';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新月台帐通信标记:'+PlugIntf.GetLastError);
    
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' '+
         ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TYPE=''00'' and TERM_ID='''+RimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新月台帐上报时间戳出错:'+PlugIntf.GetLastError);
    CommitTrans; //提交事务
    result:=UpiRet;
  except
    on E:Exception do
    begin
      RollbackTrans;
      WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'00','上报月台帐错误！','02'); //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
  //执行成功写日志:
  WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'00','上报月台帐成功','01');
end;


//////上报POS零售单 (type='01')
function TBillSyncFactory.SendSalesDetail: integer;
var
  iRet,UpiRet: integer;     //返回ExeSQL影响多少行记录
  Session: string;          //session前缀
  Str, SALES_DATE: string;  
  SaleTab,DetailTab: string; //销售明细表、商品表
begin
  result := -1;
  UpiRet:=0;

  //第一步: 创建零售单（POS）临时[INF_POS_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      SALES_DATE:='to_char(A.SALES_DATE) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='ltrim(rtrim(char(A.SALES_DATE))) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+     //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+   //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+   //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+    //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+   //RIM零售户ID
             'SALES_ID CHAR(36) NOT NULL,'+     //RIM零售销售单ID
             'SALE_DATE CHAR (8) NOT NULL,'+    //RIM零售销售单日期
             'CUST_CODE varchar (20)'+         //会员号
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建零售单[INF_SALE]错误:'+PlugIntf.GetLastError);
    end;
  end;

  //初始化参数
  BillType:='01'; //销售流水
  TempTableName:=Session+'INF_SALE';  //临时表
  BillMainTable:='SAL_SALESORDER';    //单据主表
  BillKeyField:='SALES_ID';           //主表关键字段
  INFKeyField:='SALES_ID';            //中间表关键字段
  BeginPrepare; //取时间戳和删除临时表数据

  str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE)'+
       'select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,A.SALES_ID,'+SALES_DATE+',B.CUST_CODE '+
       ' from SAL_SALESORDER A left outer join PUB_CUSTOMER B on A.IC_CARDNO=B.CUST_ID '+
       ' where A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and A.SALES_TYPE in (1,3,4) and A.COMM not in (''02'',''12'') and '+
       ' A.TIME_STAMP>'+MaxStmp+' ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单临时表出错:'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //1、上报前删除历史单据：
  Str:='delete from RIM_RETAIL_DETAIL where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售单表头出错：'+PlugIntf.GetLastError);
  Str:='delete from RIM_RETAIL_INFO where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售单表体出错：'+PlugIntf.GetLastError);

  //2、插入销售单表头:                                                                       //R3_NUM, -->SALES_ID,
  Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
     ' select A.SALES_ID,'''','''',B.CUST_ID,SHORT_SHOP_ID,B.COM_ID,coalesce(INTEGRAL,0),B.SALE_DATE,B.CUST_CODE,B.SALE_DATE,'+
             '(case when A.SALES_TYPE=1 then case when (length(CREA_DATE)>12) then substr(CREA_DATE,12,length(CREA_DATE)-12) else ''00:00:00'' end else '' '' end) as PUH_TIME,'+
             '''admin'' as CREA_USER,(case when A.SALES_TYPE=3 then ''02'' else ''01'' end) as SALES_TYPE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',SHORT_SHOP_ID '+
     ' from SAL_SALESORDER A,'+Session+'INF_SALE B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if PlugIntf.ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('插入售单表头错误:'+PlugIntf.GetLastError);
  UpiRet:=iRet;

  //3、插入销售单表体:
  DetailTab:=
     'select S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID,INF.SHORT_SHOP_ID from SAL_SALESDATA S,'+Session+'INF_SALE INF '+
     ' where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.SALES_ID=INF.SALES_ID and '+
     ' S.TENANT_ID='+RimParam.TenID+' and S.SHOP_ID='''+RimParam.ShopID+''' ';

  Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE,TREND_ID)'+
       ' select A.SALES_ID,A.SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID, '+
       ' A.COST_PRICE,A.APRICE,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''',A.TREND_ID '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
       ' B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单表体出错：'+PlugIntf.GetLastError);

  //4、更新上报时间戳和单据COMM:
  if CommitReportTrans then
    result:=UpiRet;
end;


//上报调拨单 (type='04') {说明: 新R3设计时把调入当作为入库单，存储在入库表，调出单作为出库单，存储在销售单;同步时分两步处理 }
function TBillSyncFactory.SenddbInDetail: integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;      //session前缀  
  Str,BillDate: string;
  DetailTab: string;    //调拨明细表、商品表
begin
  result := -1;
  UpiRet:=0;

  //第一步: 创建销售单（批发）临时[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(STOCK_DATE) as STOCK_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='ltrim(rtrim(char(STOCK_DATE))) as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_DB( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+     //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'DB_ID CHAR(36) NOT NULL,'+       //RIM调拨ID
             'DB_NEWID VARCHAR(40) NOT NULL,'+       //RIM调拨ID(原单据+"_1")
             'DB_DATE CHAR(8) NOT NULL'+         //RIM调拨日期
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');
    end;
  end;

  //初始化参数
  BillType:='04'; //调入单
  TempTableName:=Session+'INF_DB';  //临时表
  BillMainTable:='STK_STOCKORDER';
  BillKeyField:='STOCK_ID';
  INFKeyField:='DB_ID';            //中间表关键字段  
  BeginPrepare;  //取时间戳和删除临时表数据

  str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE)'+
       'select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,STOCK_ID,STOCK_ID || ''_1'' as DB_NEWID,'+BillDate+' from '+
       ' STK_STOCKORDER where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调入单[INF_DB]错误！'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;     //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //1、上报前删除历史单据：
  Str:='delete from RIM_CUST_TRN where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调入单表头出错：'+PlugIntf.GetLastError);
  Str:='delete from RIM_CUST_TRN_LINE where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调入单表体出错：'+PlugIntf.GetLastError);

  //2、插入调拨（入）单表头:
  Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
     ' select B.DB_NEWID,B.CUST_ID,''2'' as vTYPE,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.DB_DATE,''admin'' as CREA_USER,B.DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
     ' from STK_STOCKORDER A,'+Session+'INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.DB_ID and '+
     ' A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调播单批发表头出错：'+PlugIntf.GetLastError);
  UpiRet:=iRet;

  //3、插入零售表体:
  DetailTab:='select INF.DB_NEWID,S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID from STK_STOCKDATA S,'+Session+'INF_DB INF where S.TENANT_ID=INF.TENANT_ID and S.STOCK_ID=INF.DB_ID and '+
             ' S.TENANT_ID='+RimParam.TenID+' and S.SHOP_ID='''+RimParam.ShopID+''' ';

  Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
       ' select A.DB_NEWID,SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID,'+
       ' A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
       ' order by B.GODS_CODE';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨（入）单批发表体[RIM_CUST_TRN_LINE]错误！'+PlugIntf.GetLastError);

  //4、更新上报时间戳和单据COMM:
  if CommitReportTrans then
    result:=UpiRet;
end;

//上报调拨单 (type='12')  单据号码=SALES_ID + _2 {说明: 新R3设计时把调入当作为入库单，存储在入库表，调出单作为出库单，存储在销售单;同步时分两步处理 }
function TBillSyncFactory.SenddbOutDetail: integer;
var
  iRet,UpiRet: integer;  //返回ExeSQL影响多少行记录
  Session: string;       //session前缀
  Str, BillDate: string;
  DetailTab: string;     //调拨明细表、商品表
begin
  result := -1;
  UpiRet:=0;

  //第一步: 创建销售单（批发）临时[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(SALES_DATE) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='ltrim(rtrim(char(SALES_DATE))) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_DB( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+     //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'DB_ID CHAR(36) NOT NULL,'+       //RIM调拨ID
             'DB_NEWID VARCHAR(40) NOT NULL,'+       //RIM调拨ID(原单据+"_1")
             'DB_DATE CHAR(8) NOT NULL'+         //RIM调拨日期
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');
    end;
  end;

  //初始化参数
  BillType:='12'; //调入单
  TempTableName:=Session+'INF_DB';  //临时表
  BillMainTable:='SAL_SALESORDER';
  BillKeyField:='SALES_ID';
  INFKeyField:='DB_ID';            //中间表关键字段  
  BeginPrepare;   //取时间戳和删除临时表数据

  str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE)'+
       'select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,SALES_ID,SALES_ID || ''_2'' as DB_NEWID,'+BillDate+' from '+
       ' SAL_SALESORDER where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and SALES_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插出调出单[INF_DB]错误！'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //1、上报前删除历史单据：
  Str:='delete from RIM_CUST_TRN where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调出单表头出错：'+PlugIntf.GetLastError);
  Str:='delete from RIM_CUST_TRN_LINE where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调出单表体出错：'+PlugIntf.GetLastError);

  //2、插入调拨（入）单表头:
  Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
     ' select B.DB_NEWID,B.CUST_ID,''2'' as vTYPE,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.DB_DATE,''admin'' as CREA_USER,B.DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
     ' from SAL_SALESORDER A,'+Session+'INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.DB_ID and '+
     ' A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨单表头出错：'+PlugIntf.GetLastError);
  UpiRet:=UpiRet+iRet;

  //3、插入零售表体:
  DetailTab:='select INF.DB_NEWID,S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID from SAL_SALESDATA S,'+Session+'INF_DB INF where S.TENANT_ID=INF.TENANT_ID and S.SALES_ID=INF.DB_ID and '+
             ' S.TENANT_ID='+RimParam.TenID;
  Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
       ' select A.DB_NEWID,SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID,'+
       ' A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
       ' order by B.GODS_CODE ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨（出）单批发表体[RIM_CUST_TRN_LINE]错误！'+PlugIntf.GetLastError);

  //4、更新上报时间戳和单据COMM:
  if CommitReportTrans then
    result:=UpiRet; 
end;

//上报入库单 [type='05']
function TBillSyncFactory.SendStockDetail: integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string; //session前缀
  Str,BillDate: string;
  DetailTab: string; //入库单细表、商品表
begin
  result := -1;
  UpiRet:=0;

  //第一步: 创建销售单（批发）临时[INF_STOCK]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(STOCK_DATE) as STOCK_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='ltrim(rtrim(char(STOCK_DATE))) as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+         //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+       //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //零售户ID
             'STOCK_ID CHAR(36) NOT NULL,'+         //入库单ID
             'STOCK_DATE CHAR(8) NOT NULL'+         //入库日期
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建进货入库单临时表[INF_STOCK]错误！');
    end;
  end;

  BillType:='05'; //调入单
  TempTableName:=Session+'INF_STOCK';  //临时表
  BillMainTable:='STK_STOCKORDER';     //主表表名
  BillKeyField:='STOCK_ID';   //主表关键字段
  INFKeyField:='STOCK_ID';    //中间表关键字段
  BeginPrepare;    //取时间戳和删除临时表数据

  str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,STOCK_ID,STOCK_DATE)'+
     'select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,STOCK_ID,'+BillDate+' from '+
     ' STK_STOCKORDER where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and STOCK_TYPE in (1,3) and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert入库单[INF_STOCK]错误：'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //1、上报前删除历史单据：
  Str:='delete from RIM_VOUCHER where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER.VOUCHER_NUM=A.STOCK_ID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史入库单表头出错：'+PlugIntf.GetLastError);
  Str:='delete from RIM_VOUCHER_LINE where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER_LINE.VOUCHER_NUM=A.STOCK_ID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史入库单表体出错：'+PlugIntf.GetLastError);

  //2、Insert入库单表头:
  Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
     ' select A.STOCK_ID,'' '' as RETAIL_NUM,B.CUST_ID,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.STOCK_DATE,''admin'' as CREA_USER,B.STOCK_DATE,'+
     ' (case when STOCK_TYPE=3 then ''02'' else ''01'' end) as STOCK_TYPE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
     ' from STK_STOCKORDER A,'+Session+'INF_STOCK B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.STOCK_ID and '+
     ' A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表头[RIM_VOUCHER]错误！');
  UpiRet:=iRet;

  //3、插入库单表体:
  DetailTab:='select S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID from STK_STOCKDATA S,'+Session+'INF_STOCK INF where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.STOCK_ID=INF.STOCK_ID and '+
             ' S.TENANT_ID='+RimParam.TenID+' and S.SHOP_ID='''+RimParam.ShopID+''' ';

  Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
       ' select A.STOCK_ID,SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID,'+
       ' A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
       ' order by B.GODS_CODE ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表体[RIM_VOUCHER_LINE]错误！');

  //4、更新上报时间戳和单据COMM:
  if CommitReportTrans then
    result:=UpiRet;  
end;

//上报调整单  (type='07')
function TBillSyncFactory.SendChangeDetail: integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀
  Str,BillDate: string;
  DetailTab: string; //入库单细表、商品表
begin
  result := -1;
  UpiRet:=0;

  //第一步: 创建销售单（批发）临时[INF_CHANGE]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(CHANGE_DATE) as CHANGE_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='ltrim(rtrim(char(CHANGE_DATE))) as CHANGE_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_CHANGE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'CHANGE_ID CHAR(36) NOT NULL,'+      //RIM调整单ID
             'CHANGE_DATE CHAR(8) NOT NULL'+         //入库日期
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建〖调整单〗临时[INF_CHANGE]错误！');
    end;
  end;

  BillType:='07'; //调整单
  TempTableName:=Session+'INF_CHANGE';  //临时表
  BillMainTable:='STO_CHANGEORDER';     //主表表名
  BillKeyField:='CHANGE_ID';      //主表关键字段
  INFKeyField:='CHANGE_ID';       //中间表关键字段
  BeginPrepare;        //取时间戳和删除临时表数据

  str:='insert into '+Session+'INF_CHANGE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,CHANGE_ID,CHANGE_DATE)'+
     ' select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,CHANGE_ID,'+BillDate+' from '+
     ' STO_CHANGEORDER where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert入库单[INF_CHANGE]错误：'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //1、上报前删除历史单据：
  Str:='delete from RIM_ADJUST_INFO where Exists(select 1 from '+Session+'INF_CHANGE A where RIM_ADJUST_INFO.ADJUST_NUM=A.CHANGE_ID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调整单表头出错：'+PlugIntf.GetLastError);
  Str:='delete from RIM_ADJUST_DETAIL where Exists(select 1 from '+Session+'INF_CHANGE A where RIM_ADJUST_DETAIL.ADJUST_NUM=A.CHANGE_ID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调整单表体出错：'+PlugIntf.GetLastError);

  //2、插入调整单表头:                                                //R3_NUM, --> CHANGE_ID,
  Str:='insert into RIM_ADJUST_INFO(ADJUST_NUM,CUST_ID,COM_ID,TERM_ID,TYPE,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
     ' select A.CHANGE_ID,'''+RimParam.CustID+''' as CUST_ID,'''+RimParam.ComID+''' as COM_ID,B.SHORT_SHOP_ID,'+
     ' (case when CHANGE_CODE=''01'' then ''02'' else ''03'' end) as CHANGE_CODE,''02'',B.CHANGE_DATE,''admin'' as CREA_USER,B.CHANGE_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,SHORT_SHOP_ID '+
     ' from STO_CHANGEORDER A,'+Session+'INF_CHANGE B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.CHANGE_ID=B.CHANGE_ID and '+
     ' A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入〖调整单〗表头[RIM_ADJUST_INFO]错误！（SQL='+str+'）');
  UpiRet:=UpiRet+iRet;

  //3、插入调整单表体:
  DetailTab:='select S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID from STO_CHANGEDATA S,'+Session+'INF_CHANGE INF where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.CHANGE_ID=INF.CHANGE_ID and '+
             ' S.TENANT_ID='+RimParam.TenID+' ';

  Str:='insert into RIM_ADJUST_DETAIL(ADJUST_NUM,ADJUST_LINE,COM_ID,ITEM_ID,UM_ID,QTY_ADJUST,QTY_MINI_UM,AMT_ADJUST)'+
       ' select A.CHANGE_ID,SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID,'+
       ' A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
       ' order by B.GODS_CODE';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入〖调整单〗表体[RIM_ADJUST_DETAIL]错误！'+PlugIntf.GetLastError);
 
  //4、更新上报时间戳和单据COMM:
  if CommitReportTrans then
    result:=UpiRet;  
end;


function TBillSyncFactory.Test(SQL: string): integer;
var
  Rs: TZQuery;
begin
  try
    Rs:=TZQuery.Create(nil);
    Rs.Close;
    Rs.SQL.Text:=SQL;
    self.Open(Rs);
    result:=Rs.RecordCount; 
  finally
  end;
end;

function TBillSyncFactory.BeginPrepare: Boolean;
var
  iRet: integer;
  Str: string;
begin
  result:=false;
  //返回时间戳和更新时间戳:
  MaxStmp:=GetMaxNUM(BillType,RimParam.ComID, RimParam.CustID, RimParam.ShopID);
  //删除临时表数据：
  Str:='delete from '+TempTableName+' where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' ';
  if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('删除临时表〖'+TempTableName+'〗数据出错:'+PlugIntf.GetLastError);
  result:=true;
end;

function TBillSyncFactory.CommitReportTrans: Boolean;
var
  iRet: integer;
  str: string;
begin
  result:=false;
  try
    BeginTrans; //开始一个批次事务:
    //1、将单据上报的标记位:COMM的第1位设置为：1
    Str:='update '+BillMainTable+' set COMM='+GetUpCommStr(DbType)+' '+
         ' where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and '+
         ' exists(select 1 from '+TempTableName+' INF where '+BillMainTable+'.TENANT_ID=INF.TENANT_ID and '+BillMainTable+'.SHOP_ID=INF.SHOP_ID and '+BillMainTable+'.'+BillKeyField+'=INF.'+INFKeyField+')';
    if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('更新通信标记:'+PlugIntf.GetLastError);

    //2、更新单据控制表：
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' '+
         ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TYPE='''+BillType+''' and TERM_ID='''+RimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新上报时间戳出错:'+PlugIntf.GetLastError);

    CommitTrans;  //提交事务
    result:=true;
  except
    on E:Exception do
    begin
      RollbackTrans;
      WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE, RimParam.CustID, BillType ,'上报销售单出错！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
  //执行成功写日志:
  WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE, RimParam.CustID, BillType ,'上报销售单成功！','01');
end;

procedure TBillSyncFactory.SetINFKeyField(const Value: string);
begin
  FINFKeyField := Value;
end;

end.

//以下是2011年6月13日修改月台帐之前备份
{
function TBillSyncFactory.SendMonthReck: integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀表名
  Str,MonthTab,ReckMonth: string;
begin
  result := -1;
  UpiRet:=0;

  //第一步: 创建台帐临时[INF_RECKMONTH]:
  case DbType of
   1:
    begin
      Session:='';
      ReckMonth:='to_char(A.MONTH) ';
    end;
   4:
    begin
      Session:='session.';
      ReckMonth:='trim(char(A.MONTH)) ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKMONTH ('+
             'TENANT_ID INTEGER NOT NULL,'+         //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+       //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3门店ID的后四位
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //RIM零售户ID
             'ITEM_ID VARCHAR(30) NOT NULL,'+       //RIM商品ID
             'GODS_ID CHAR(36) NOT NULL,'+          //R3商品ID
             'UNIT_CALC DECIMAL (18,6),'+           //商品计量单位换算管理单位换算值
             'RECK_MONTH VARCHAR(8) NOT NULL'+      //台账月份
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建月台帐临时表出错：'+PlugIntf.GetLastError);
    end;
  end;

  //初始化参数
  BillType:='00'; //销售流水
  TempTableName:=Session+'INF_RECKMONTH';  //临时表
  BeginPrepare; //取时间戳和删除临时表数据

  //第二步: 大于时间戳的台帐插入临时表:
  if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_RECKMONTH where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
  //月台账表
  MonthTab:='select M.* from RCK_GOODS_MONTH M,RCK_MONTH_CLOSE C where M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and M.MONTH=C.MONTH and '+
            ' M.TENANT_ID='+RimParam.TenID+' and M.SHOP_ID='''+RimParam.ShopID+''' and C.TIME_STAMP>'+MaxStmp;
  Str:='insert into '+Session+'INF_RECKMONTH(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_MONTH) '+
       'select A.TENANT_ID,A.SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,('+GetDefaultUnitCalc+') as UNIT_CALC,'+ReckMonth+' as RECK_MONTH '+
       ' from ('+MonthTab+') A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入月台帐临时表出错:'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //第三步: 先删除历史在插入:
  //1、先删除RIM月台账表掉需要重新上报记录:
  Str:='delete from RIM_CUST_MONTH A where A.COM_ID='''+RimParam.ComID+''' and A.CUST_ID='''+RimParam.CustID+''' and A.TERM_ID='''+RimParam.SHORT_ShopID+''' '+
       ' exists(select 1 from '+Session+'INF_RECKMONTH B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.ITEM_ID=B.ITEM_ID and A.MONTH=B.RECK_MONTH)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除月台账历史数据出错：'+PlugIntf.GetLastError);

  //2、插入上报记录:
  Str:=
    'insert into RIM_CUST_MONTH('+
        'COM_ID,CUST_ID,TERM_ID,ITEM_ID,MONTH,PRI3,PRI4,PRI_SOLD,AMT_GROSS_PROFIT_THEO,'+ //1:
        'QTY_IOM,AMT_IOM,'+              //2:期初数量、金额
        'QTY_PURCH,AMT_PURCH,'+          //3:入库数量、金额
        'QTY_SOLD,AMT_SOLD_WITH_TAX,'+   //4:销售数量、含税金额
        'QTY_PROFIT,AMT_PROFIT,'+        //5: 溢余数量、金额
        'QTY_LOSS,AMT_LOSS,'+            //6: 溢损数量、金额
        'QTY_TAKE,AMT_TAKE,'+            //7: 调整数量、金额
        'QTY_TRN_IN,AMT_TRN_IN,'+        //8: 调入数量、金额
        'QTY_TRN_OUT,AMT_TRN_OUT,'+      //9: 调出数量、金额
        'QTY_EOM,AMT_EOM,'+              //10: 期末数量、金额
        'UNIT_COST,SUMCOST_SOLD,'+       //11: 单位成本、销售成本
        'AMT_GROSS_PROFIT,AMT_PROFIT_COM)'+  //12:毛利额、贡献毛利
    'select B.COM_ID,B.CUST_ID,SHORT_SHOP_ID,B.ITEM_ID,B.RECK_MONTH,0,0,0,0,'+ //1:
        '(case when B.UNIT_CALC>0 then ORG_AMT/B.UNIT_CALC else ORG_AMT end)as ORG_AMT,ORG_MNY,'+          //2:期初数量、金额
        '(case when B.UNIT_CALC>0 then STOCK_AMT/B.UNIT_CALC else STOCK_AMT end)as STOCK_AMT,STOCK_MNY,'+  //3:入库数量、金额
        '(case when B.UNIT_CALC>0 then SALE_AMT/B.UNIT_CALC else SALE_AMT end)as SALE_AMT,SALE_MNY+SALE_TAX,'+  //4:销售数量、含税金额
        '(case when CHANGE1_AMT>0 then (case when B.UNIT_CALC>0 then CHANGE1_AMT/B.UNIT_CALC else CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT>0 then CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+    //5: 溢余数量、金额
        '(case when CHANGE1_AMT<0 then (case when B.UNIT_CALC>0 then -CHANGE1_AMT/B.UNIT_CALC else -CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT<0 then -CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+ //6: 溢损数量、金额
        '(case when B.UNIT_CALC>0 then (CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)/B.UNIT_CALC else CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT end)as CHANGE_AMT,(CHANGE2_MNY+CHANGE3_MNY+CHANGE3_MNY+CHANGE4_MNY+CHANGE5_MNY) as CHANGE_MNY,'+ //7: 调整数量、金额
        '(case when B.UNIT_CALC>0 then DBIN_AMT/B.UNIT_CALC else DBIN_AMT end)as DBIN_AMT,DBIN_MNY,'+      //8: 调入数量、金额
        '(case when B.UNIT_CALC>0 then DBOUT_AMT/B.UNIT_CALC else DBOUT_AMT end)as DBOUT_AMT,DBOUT_MNY,'+  //9: 调出数量、金额
        '(case when B.UNIT_CALC>0 then BAL_AMT/B.UNIT_CALC else BAL_AMT end)as BAL_AMT,BAL_MNY,'+          //10: 期末数量、金额
        'ADJ_CST,BAL_CST,'+             //11: 单位成本、销售成本
        'SALE_PRF,0 '+                  //12: 毛利额、贡献毛利
    'from RCK_GOODS_MONTH A,'+Session+'INF_RECKMONTH B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and '+ReckMonth+'=B.RECK_MONTH and A.TIME_STAMP>'+MaxStmp;
  if PlugIntf.ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('上报月台账数据出错:'+PlugIntf.GetLastError);

  //3、更新月台帐标记和上报时间戳:[]
  try
    BeginTrans;
    //将月台帐上报的标记位:COMM的第1位设置为：1
    Str:='update RCK_GOODS_MONTH A set COMM='+GetUpCommStr(DbType)+'  '+
         ' where A.TENANT_ID='''+RimParam.TenID+''' and A.SHOP_ID='''+RimParam.ShopID+''' and '+
         ' exists(select 1 from '+TempTableName+' INF where A.TENANT_ID=INF.TENANT_ID and A.SHOP_ID=INF.SHOP_ID and '+ReckMonth+'=INF.RECK_MONTH and A.GODS_ID=INF.GODS_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新月台帐通信标记:'+PlugIntf.GetLastError);
    
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TYPE=''00'' and TERM_ID='''+RimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新月台帐上报时间戳出错:'+PlugIntf.GetLastError);
    CommitTrans; //提交事务
    result:=UpiRet;
  except
    on E:Exception do
    begin
      RollbackTrans;
      WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'00','上报月台帐错误！','02'); //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
  //执行成功写日志:
  WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'00','上报月台帐成功','01');
end;
}















