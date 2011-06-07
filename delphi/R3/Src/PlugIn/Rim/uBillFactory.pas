{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;

 ------------------------------------------------------------------------------}

unit uBillFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  Forms, uBaseSyncFactory, uRimSyncFactory;

type
  TBillSyncFactory=class(TRimSyncFactory)
  private
    //上报月台账
    function SendMonthReck(vRimParam: TRimParams): integer;
    //上报零售单
    function SendSalesDetail(vRimParam: TRimParams): integer;
    //上报销售单（批发）
    function SendSaleBatchDetail(vRimParam: TRimParams): integer;
    //上报销售退货
    function SendSaleRetDetail(vRimParam: TRimParams): integer;
    //上报调拨单（调入）
    function SenddbInDetail(vRimParam: TRimParams): integer;
    //上报调拨单（调入）
    function SenddbOutDetail(vRimParam: TRimParams): integer;
    //上报入库单
    function SendStockDetail(vRimParam: TRimParams): integer;
    //上报入库退货单
    function SendStkRetuDetail(vRimParam: TRimParams): integer;
    //上报调整单
    function SendChangeDetail(vRimParam: TRimParams): integer;

    function Test(SQL: string): integer; //调试
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;
 
implementation

{ TSalesTotalSyncFactory }

function TBillSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  ErrorFlag: Boolean; //运行状态
  iRet: integer; //返回上报成功记录
  RimParam: TRimParams;
  R3ShopList: TZQuery;
begin
  result:=-1;
  {------初始化参数------}
  PlugIntf:=GPlugIn;
  GetDBType;    //1、返回数据库类型
  Params.Decode(Params, InParamStr); //2、还原ParamsList的参数对象
  GetSyncType;  //3、返回同步类型标记

  {------开始运行日志------}
  BeginLogRun;
  R3ShopList := TZQuery.Create(nil);
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
        ErrorFlag:=False; 
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);   //R3企业ID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString); //R3企业名称 (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);     //R3门店ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);  //R3门店名称 (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString); //R3门店许可证号 (Field: LICENSE_CODE)
        RimParam.SHORT_ShopID:=Copy(RimParam.ShopID,Length(RimParam.ShopID)-3,4);     //门店ID的后4位

        //传入R3门店ID,返回RIM的烟草公司ComID,零售户CustID;
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID); //返回烟草公司ComID、零售户CustID

        //if then Raise Exception.Create('R3传入企业ID（'+RimParam.TenID+' - '+RimParam.TenName+'）在RIM中没找到对应的COM_ID值...');
        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          LogInfo.BeginLog(RimParam.TenName+'-'+RimParam.ShopName); //开始日志

          //开始上报月台帐：
          iRet:=SendMonthReck(RimParam);
          LogInfo.AddBillMsg('月台帐',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //上报零售单
          iRet:=SendSalesDetail(RimParam);
          LogInfo.AddBillMsg('零售单',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //上报销售单（批发）
          iRet:=SendSaleBatchDetail(RimParam);
          LogInfo.AddBillMsg('销售单',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //上报销售退货
          iRet:=SendSaleRetDetail(RimParam);
          LogInfo.AddBillMsg('销售退货单',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //上报调拨单（调入）
          iRet:=SenddbInDetail(RimParam);
          LogInfo.AddBillMsg('调拨单(入)',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //上报调拨单（调出）
          iRet:=SenddbOutDetail(RimParam);
          LogInfo.AddBillMsg('调拨单(出)',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);
      
          //上报入库单
          iRet:=SendStockDetail(RimParam);
          LogInfo.AddBillMsg('入库单',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //上报入库退货单
          iRet:=SendStkRetuDetail(RimParam);
          LogInfo.AddBillMsg('入库退货单',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //上报调整单
          iRet:=SendChangeDetail(RimParam);
          LogInfo.AddBillMsg('调整单',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1); 

          if R3ShopList.RecordCount=1 then 
            LogInfo.SetLogMsg(LogList)  //添加本次执行日志
          else 
            LogInfo.SetLogMsg(LogList,R3ShopList.RecNo); //添加本次执行日志

          if ErrorFlag then
            Inc(FRunInfo.ErrorCount) //执行异常！
          else
            Inc(FRunInfo.RunCount);  //执行成功！
        end else
        begin
          if R3ShopList.RecordCount=1 then
            LogList.Add('   门店('+RimParam.TenName+'-'+RimParam.ShopName+')许可证号'+RimParam.LICENSE_CODE+' 在Rim系统中没对应上零售户！') 
          else
            LogList.Add('  ('+InttoStr(R3ShopList.RecordCount)+')门店('+RimParam.TenName+'-'+RimParam.ShopName+')许可证号'+RimParam.LICENSE_CODE+' 在Rim系统中没对应上零售户！');
          Inc(FRunInfo.NotCount);  //对应不上
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //总门店数
    DBLock(False); //解锁     
    R3ShopList.Free;
    WriteLogRun('业务流水单据'); //输出到文本日志
  end;
end;


////上报月台账(type='00') [根据月台账表， 若月台帐表没有按月结帐则不上报—2011.06.03]
function TBillSyncFactory.SendMonthReck(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀表名
  Str,MonthTab,ReckMonth: string;
begin
  result := -1;
  UpiRet:=0;
  MaxStmp:=GetMaxNUM('00',vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳

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

  //第二步: 大于时间戳的台帐插入临时表:
  if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_RECKMONTH where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
  MonthTab:='select M.* from RCK_GOODS_MONTH M,RCK_MONTH_CLOSE C where M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and M.MONTH=C.MONTH and '+
            ' M.TENANT_ID='+vRimParam.TenID+' and M.SHOP_ID='''+vRimParam.ShopID+''' and C.TIME_STAMP>'+MaxStmp;
  Str:='insert into '+Session+'INF_RECKMONTH(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_MONTH) '+
       'select A.TENANT_ID,A.SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,('+GetDefaultUnitCalc+') as UNIT_CALC,'+ReckMonth+' as RECK_MONTH '+
       ' from ('+MonthTab+') A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入月台帐临时表出错:'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //第三步: 先删除历史在插入:
  try
    BeginTrans; 
    //1、先删除RIM月台账表掉需要重新上报记录:
    Str:='delete from RIM_CUST_MONTH A where A.COM_ID='''+vRimParam.ComID+''' and A.CUST_ID='''+vRimParam.CustID+''' and '+
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
          'SALE_AMT,SALE_MNY+SALE_TAX,'+   //4:销售数量、含税金额
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

    //3、更新上报时间戳:[]                                
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''00'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新月台帐上报时间戳出错:'+PlugIntf.GetLastError);
    CommitTrans; //提交事务
    result:=UpiRet;

    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'00','上报月台帐成功','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'00','上报月台帐错误！','02'); //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;


//////上报POS零售单 (type='01')
function TBillSyncFactory.SendSalesDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
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
      SALES_DATE:='trim(char((A.SALES_DATE)) as SALES_DATE ';
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
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建零售单[INF_SALE]错误:'+PlugIntf.GetLastError);
    end;
  end;

  try
    //第二步、插入中间表
    MaxStmp:=GetMaxNUM('01',vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_SALE where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);

    SaleTab:='select SALES_ID,SALES_DATE,IC_CARDNO,TIME_STAMP from SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and SALES_TYPE=4 and COMM not in (''02'',''12'') and '+
             ' TIME_STAMP>'+MaxStmp+' and not exists(select 1 from RIM_RETAIL_INFO AA where SAL_SALESORDER.SALES_ID=AA.RETAIL_NUM and AA.COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''') ';
    str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,A.SALES_ID,'+SALES_DATE+',B.CUST_CODE from '+
         ' ('+SaleTab+')A left outer join PUB_CUSTOMER B on A.IC_CARDNO=B.CUST_ID ';

    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入零售单临时表出错:'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //返回没有可上报数据
      Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
    end;

    //开始插入处理:
    BeginTrans; //开始一个批次事务:
    //0、零售单不能修改，不需重报：
    //1、插入零售表头:                                                                       //R3_NUM, -->SALES_ID,
    Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.SALES_ID,'''','''',B.CUST_ID,SHORT_SHOP_ID,B.COM_ID,coalesce(INTEGRAL,0),B.SALE_DATE,B.CUST_CODE,B.SALE_DATE,(case when length(CREA_DATE)>12 then substr(CREA_DATE,12,length(CREA_DATE)-12) else ''00:00:00'' end) as PUH_TIME,''admin'' as CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',SHORT_SHOP_ID '+
       ' from SAL_SALESORDER A,'+Session+'INF_SALE B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('插入售单表头错误:'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;

    //2、插入零售表体:
    DetailTab:=
       'select S.*,M.UNIT_NAME,INF.SHORT_SHOP_ID from SAL_SALESDATA S,'+Session+'INF_SALE INF,VIW_MEAUNITS M '+
       ' where S.TENANT_ID=INF.TENANT_ID and S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.SALES_ID=INF.SALES_ID and '+
       ' S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID;

    Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE,TREND_ID)'+
         ' select A.SALES_ID,A.SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
         ' A.COST_PRICE,A.APRICE,(case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''',A.SHORT_SHOP_ID '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
         ' B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入POS零售单表体出错：'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;

    //3、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''01'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新上报时间戳出错:'+PlugIntf.GetLastError);

    CommitTrans;  //提交事务

    result:=UpiRet;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE, vRimParam.CustID, '01','上报POS零售单成功！','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE, vRimParam.CustID, '01','上报POS零售单出错！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

////上报销售单（批发单）数据 (type='02')
function TBillSyncFactory.SendSaleBatchDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  Str, SALES_DATE: string;
  DetailTab: string; //销售明细表、商品表
begin
  result := -1;
  UpiRet:=0;

  //第一步: 创建销售单（批发）临时[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      SALES_DATE:='to_char(SALES_DATE) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='trim(char(SALES_DATE)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+//R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'SALES_ID CHAR(36) NOT NULL,'+       //RIM销售单ID
             'SALE_DATE CHAR (8) NOT NULL,'+      //RIM销售单日期
             'CUST_CODE varchar (20)'+            //会员号( 本字段暂时不用)             
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');
    end;
  end;

  //第二步、插入中间表
  try
    MaxStmp:=GetMaxNUM('02', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_SALE where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+' '+
         ' from SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and SALES_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单[INF_SALE]错误！'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //返回没有可上报数据
      Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
    end;


    BeginTrans;
    //1、上报前删除历史单据：
    Str:='delete from RIM_RETAIL_DETAIL where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售单表头出错：'+PlugIntf.GetLastError);
    Str:='delete from RIM_RETAIL_INFO where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售单表体出错：'+PlugIntf.GetLastError);

    //2、插入销售表头:
    Str:='insert into RIM_RETAIL_INFO'+                                               //R3_NUM, ---> SALES_ID,
       '(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.SALES_ID,'' '','' '',B.CUST_ID,B.SHORT_SHOP_ID,B.COM_ID,0,B.SALE_DATE,'' '',B.SALE_DATE,'' '' as PUH_TIME,''admin'' as CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',B.SHORT_SHOP_ID '+
       ' from SAL_SALESORDER A,'+Session+'INF_SALE B where  A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+'''  ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表头[RIM_RETAIL_INFO]错误:'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;
      
    //3、插入销售表体:
    DetailTab:=
       'select S.*,M.UNIT_NAME from SAL_SALESDATA S,'+Session+'INF_SALE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and '+
       ' S.SALES_ID=INF.SALES_ID and S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID;
    Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
       ' select A.SALES_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
       ' A.COST_PRICE,A.APRICE,(case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
       ' B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表体错误:'+PlugIntf.GetLastError);

    //4、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''02'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售单上报时间戳出错！');
    CommitTrans; //提交事务

    result:=UpiRet;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'02','上报批发销售单成功！','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'02','上报销售单（批发）！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//销售退货单  (type='03')
function TBillSyncFactory.SendSaleRetDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string; //session前缀  
  Str, SALES_DATE: string;
  DetailTab: string; //销售明细表、商品表
  RsINF: TZQuery;     //中间表循环使用
begin
  result := -1;
  UpiRet:=0;

  //第一步: 创建销售退货单临时[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      SALES_DATE:='to_char(SALES_DATE)as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='trim(char(SALES_DATE)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+        //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+      //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+       //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+      //RIM零售户ID
             'SALES_ID CHAR(36) NOT NULL,'+        //RIM销售单ID
             'SALE_DATE CHAR (8) NOT NULL,'+       //RIM销售单日期
             'CUST_CODE varchar (20)'+            //会员号( 本字段暂时不用)
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售退货单临时表[INF_SALE]错误！');
    end;
  end;

  //第二步、循环插入中间表
  try
    MaxStmp:=GetMaxNUM('03', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_SALE where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+' '+
         'from SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and SALES_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售退货单[INF_SALE]错误！'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //返回没有可上报数据
      Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
    end;

    BeginTrans; //开始事务
    //1、上报前删除历史单据：
    Str:='delete from RIM_RETAIL_DETAIL where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售退货单表头出错：'+PlugIntf.GetLastError);
    Str:='delete from RIM_RETAIL_INFO where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_INFO.COM_ID=A.COM_ID and RIM_RETAIL_INFO.CUST_ID=A.CUST_ID and RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售退货单表体出错：'+PlugIntf.GetLastError);

    //2、插入销售表头:
    Str:='insert into RIM_RETAIL_INFO '+                                               //R3_NUM ---> SALES_ID,
       '(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.SALES_ID,'' '','' '',B.CUST_ID,B.SHORT_SHOP_ID,B.COM_ID,0,B.SALE_DATE,'' '',B.SALE_DATE,'' '' as PUH_TIME,''admin'' as CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',B.SHORT_SHOP_ID '+
       ' from SAL_SALESORDER A,'+Session+'INF_SALE B where  A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+'''  ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表头[RIM_RETAIL_INFO]错误:'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;
    //3、插入销售表体:
    DetailTab:=
       'select S.*,M.UNIT_NAME from SAL_SALESDATA S,'+Session+'INF_SALE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and '+
       ' S.SALES_ID=INF.SALES_ID and S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID;
    Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
       ' select A.SALES_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
       ' A.COST_PRICE,A.APRICE,(case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
       ' B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表体错误:'+PlugIntf.GetLastError);
      
    //4、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''03'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售退货单上报时间戳出错！');

    CommitTrans; //提交事务
    result:=UpiRet;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'03','上报销售退货单成功！','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'03','上报销售退货单！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;          

//上报调拨单 (type='04') {说明: 新R3设计时把调入当作为入库单，存储在入库表，调出单作为出库单，存储在销售单;同步时分两步处理 }
function TBillSyncFactory.SenddbInDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  Str,BillDate: string;
  DetailTab: string; //调拨明细表、商品表
  RsINF: TZQuery;             //中间表循环使用
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
      BillDate:='trim(char(STOCK_DATE)) as STOCK_DATE ';
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
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');
    end;
  end;

  //第二步、插入中间(临时)表
  try
    MaxStmp:=GetMaxNUM('04', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_DB where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,STOCK_ID,STOCK_ID || ''_1'' as DB_NEWID,'+BillDate+' from '+
         ' STK_STOCKORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调入单[INF_DB]错误！'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //返回没有可上报数据
      Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
    end;

    BeginTrans; //开始事务
    //1、上报前删除历史单据：
    Str:='delete from RIM_CUST_TRN where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调入单表头出错：'+PlugIntf.GetLastError);
    Str:='delete from RIM_CUST_TRN_LINE where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调入单表体出错：'+PlugIntf.GetLastError);

    //2、插入调拨（入）单表头:
    Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
       ' select B.DB_NEWID,B.CUST_ID,''2'' as vTYPE,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.DB_DATE,''admin'' as CREA_USER,B.DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
       ' from STK_STOCKORDER A,'+Session+'INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.DB_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调播单批发表头出错：'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;

    //3、插入零售表体:
    DetailTab:='select INF.DB_NEWID,S.*,M.UNIT_NAME from STK_STOCKDATA S,'+Session+'INF_DB INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.STOCK_ID=INF.DB_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID+' and S.SHOP_ID='''+vRimParam.ShopID+''' ';

    Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
         ' select A.DB_NEWID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,'+
         ' (case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨（入）单批发表体[RIM_CUST_TRN_LINE]错误！'+PlugIntf.GetLastError);

    //4、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''04'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售单上报时间戳出错:'+PlugIntf.GetLastError);

    //提交事务
    CommitTrans;
    result:=UpiRet;

    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'04','上报调拨（出）单成功！','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'04','上报调拨（入）单：','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//上报调拨单 (type='12')  单据号码=SALES_ID + _2 {说明: 新R3设计时把调入当作为入库单，存储在入库表，调出单作为出库单，存储在销售单;同步时分两步处理 }
function TBillSyncFactory.SenddbOutDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀
  Str, BillDate: string;
  DetailTab: string; //调拨明细表、商品表
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
      BillDate:='trim(char(SALES_DATE)) as SALES_DATE ';
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
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');
    end;
  end;

  try
    MaxStmp:=GetMaxNUM('12', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_DB where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,SALES_ID,SALES_ID || ''_2'' as DB_NEWID,'+BillDate+' from '+
         ' SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and SALES_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插出调出单[INF_DB]错误！'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //返回没有可上报数据
      Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
    end;

    BeginTrans; //开始事务
    //1、上报前删除历史单据：
    Str:='delete from RIM_CUST_TRN where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调出单表头出错：'+PlugIntf.GetLastError);
    Str:='delete from RIM_CUST_TRN_LINE where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调出单表体出错：'+PlugIntf.GetLastError);

    //2、插入调拨（入）单表头:
    Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
       ' select B.DB_NEWID,B.CUST_ID,''2'' as vTYPE,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.DB_DATE,''admin'' as CREA_USER,B.DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
       ' from SAL_SALESORDER A,'+Session+'INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.DB_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨单表头出错：'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;

    //3、插入零售表体:
    DetailTab:='select INF.DB_NEWID,S.*,M.UNIT_NAME from SAL_SALESDATA S,'+Session+'INF_DB INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SALES_ID=INF.DB_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID;
    Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
         ' select A.DB_NEWID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,'+
         ' (case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨（出）单批发表体[RIM_CUST_TRN_LINE]错误！'+PlugIntf.GetLastError);

    //4、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''12'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新调拨（出）单上报时间戳出错:'+PlugIntf.GetLastError);

    //提交事务
    CommitTrans;
    result:=UpiRet;

    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'12','上报调拨（出）单成功！','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'12','上报调拨（出）单：','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//上报入库单 [type='05']
function TBillSyncFactory.SendStockDetail(vRimParam: TRimParams): integer;
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
      BillDate:='trim(char(STOCK_DATE)) as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+         //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+       //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //零售户ID
             'STOCK_ID CHAR(36) NOT NULL,'+         //入库单ID
             'STOCK_DATE CHAR(8) NOT NULL'+         //入库日期
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建进货入库单临时表[INF_STOCK]错误！');
    end;
  end;

  try
    MaxStmp:=GetMaxNUM('05', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_STOCK where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,STOCK_ID,STOCK_DATE)'+
       'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,STOCK_ID,'+BillDate+' from '+
       ' STK_STOCKORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and STOCK_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert入库单[INF_STOCK]错误：'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //返回没有可上报数据
      Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
    end;

    BeginTrans; //开始事务
    //1、上报前删除历史单据：
    Str:='delete from RIM_VOUCHER where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER.VOUCHER_NUM=A.STOCK_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史入库单表头出错：'+PlugIntf.GetLastError);
    Str:='delete from RIM_VOUCHER_LINE where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER_LINE.VOUCHER_NUM=A.STOCK_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史入库单表体出错：'+PlugIntf.GetLastError);

    //2、Insert入库单表头:
    Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.STOCK_ID,'' '' as RETAIL_NUM,B.CUST_ID,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.STOCK_DATE,''admin'' as CREA_USER,B.STOCK_DATE,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
       ' from STK_STOCKORDER A,'+Session+'INF_STOCK B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.STOCK_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表头[RIM_VOUCHER]错误！');
    UpiRet:=UpiRet+iRet;

    //3、插入库单表体:
    DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,'+Session+'INF_STOCK INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.STOCK_ID=INF.STOCK_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID+' and S.SHOP_ID='''+vRimParam.ShopID+''' ';

    Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
         ' select A.STOCK_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,'+
         ' (case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表体[RIM_VOUCHER_LINE]错误！');

    //4、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''05'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新进货入库单上报时间戳出错！');
    //提交事务
    CommitTrans;
    result:=UpiRet;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'05','上报入库单成功！','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'05','上报入库单出错！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;


//上报入库退货 (type='06')
function TBillSyncFactory.SendStkRetuDetail(vRimParam: TRimParams): integer;
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
      BillDate:='to_char(STOCK_DATE)as STOCK_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='trim(char(STOCK_DATE))as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+         //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+       //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //零售户ID
             'STOCK_ID CHAR(36) NOT NULL,'+         //入库单ID
             'STOCK_DATE CHAR(8) NOT NULL'+         //入库日期
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建进货入库单临时表[INF_STOCK]错误！');
    end;
  end;

  try
    MaxStmp:=GetMaxNUM('06', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_STOCK where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,STOCK_ID,STOCK_DATE)'+
       ' select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,STOCK_ID,'+BillDate+' from '+
       ' STK_STOCKORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and STOCK_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert入库单[INF_STOCK]错误：'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //返回没有可上报数据
      Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
    end;

    BeginTrans; //开始事务
    //1、上报前删除历史单据：
    Str:='delete from RIM_VOUCHER where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER.VOUCHER_NUM=A.STOCK_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史入库单表头出错：'+PlugIntf.GetLastError);
    Str:='delete from RIM_VOUCHER_LINE where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER_LINE.VOUCHER_NUM=A.STOCK_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史入库单表体出错：'+PlugIntf.GetLastError);

    //2、Insert入库单表头:
    Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.STOCK_ID,'' '' as RETAIL_NUM,B.CUST_ID,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.STOCK_DATE,''admin'' as CREA_USER,B.STOCK_DATE,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
       ' from STK_STOCKORDER A,'+Session+'INF_STOCK B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.STOCK_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表头[RIM_VOUCHER]错误！');
    UpiRet:=UpiRet+iRet;

    //3、插入库单表体:
    DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,'+Session+'INF_STOCK INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.STOCK_ID=INF.STOCK_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID+' and S.SHOP_ID='''+vRimParam.ShopID+''' ';

    Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
         ' select A.STOCK_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,'+
         '(case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE';

    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表体[RIM_VOUCHER_LINE]错误！');

    //4、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''06'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新进货入库单上报时间戳出错！');
    //提交事务
    CommitTrans;
    result:=UpiRet;

    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'06','上报入库退出单成功！','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'06','上报入库退出单出错！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//上报调整单  (type='07')
function TBillSyncFactory.SendChangeDetail(vRimParam: TRimParams): integer;
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
      BillDate:='trim(char(CHANGE_DATE)) as CHANGE_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_CHANGE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'CHANGE_ID CHAR(36) NOT NULL,'+      //RIM调整单ID
             'CHANGE_DATE CHAR(8) NOT NULL'+         //入库日期
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建〖调整单〗临时[INF_CHANGE]错误！');
    end;
  end;

  try
    MaxStmp:=GetMaxNUM('07', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //返回时间戳和更新时间戳
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_CHANGE where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('删除临时表出错:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_CHANGE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,CHANGE_ID,CHANGE_DATE)'+
       ' select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,CHANGE_ID,'+BillDate+' from '+
       ' STO_CHANGEORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert入库单[INF_CHANGE]错误：'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //返回没有可上报数据
      Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
    end;

    BeginTrans; //开始事务
    //1、上报前删除历史单据：
    Str:='delete from RIM_ADJUST_INFO where Exists(select 1 from '+Session+'INF_CHANGE A where RIM_ADJUST_INFO.ADJUST_NUM=A.CHANGE_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调整单表头出错：'+PlugIntf.GetLastError);
    Str:='delete from RIM_ADJUST_DETAIL where Exists(select 1 from '+Session+'INF_CHANGE A where RIM_ADJUST_DETAIL.ADJUST_NUM=A.CHANGE_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调整单表体出错：'+PlugIntf.GetLastError);

    //2、插入调整单表头:                                                //R3_NUM, --> CHANGE_ID,
    Str:='insert into RIM_ADJUST_INFO(ADJUST_NUM,CUST_ID,COM_ID,TERM_ID,TYPE,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
       ' select A.CHANGE_ID,'''+vRimParam.CustID+''' as CUST_ID,'''+vRimParam.ComID+''' as COM_ID,B.SHORT_SHOP_ID,'+
       ' (case when CHANGE_CODE=''01'' then ''02'' else ''03'' end) as CHANGE_CODE,''02'',B.CHANGE_DATE,''admin'' as CREA_USER,B.CHANGE_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,SHORT_SHOP_ID '+
       ' from STO_CHANGEORDER A,'+Session+'INF_CHANGE B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.CHANGE_ID=B.CHANGE_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入〖调整单〗表头[RIM_ADJUST_INFO]错误！（SQL='+str+'）');
    UpiRet:=UpiRet+iRet;

    //3、插入调整单表体:
    DetailTab:='select S.*,M.UNIT_NAME from STO_CHANGEDATA S,'+Session+'INF_CHANGE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.CHANGE_ID=INF.CHANGE_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID+' ';

    Str:='insert into RIM_ADJUST_DETAIL(ADJUST_NUM,ADJUST_LINE,COM_ID,ITEM_ID,UM_ID,QTY_ADJUST,QTY_MINI_UM,AMT_ADJUST)'+
         ' select A.CHANGE_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,'+
         ' (case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入〖调整单〗表体[RIM_ADJUST_DETAIL]错误！'+PlugIntf.GetLastError);
 
    //4、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''07'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新〖调整单〗上报时间戳出错！');

    //提交事务
    CommitTrans;
    result:=UpiRet;

    //执行成功写日志:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'07','上报〖调整单〗成功！','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'07','上报〖调整单〗错误','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
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

end.















