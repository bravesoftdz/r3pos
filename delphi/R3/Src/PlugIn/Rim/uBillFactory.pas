{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;

 ------------------------------------------------------------------------------}

unit uBillFactory;

interface

uses                 
  SysUtils,Classes,zDataSet,ufnUtil,uPlugInUtil;

             

procedure CallBillSync(PlugIntf:IPlugIn; InParams: string);   //上报单据数据



implementation


//重新上报删除历史单据
function DeleteExistsReportedBill(PlugIntf:IPlugIn; MainTable,DetailTable,KeyFieldName,BillNum: string): Boolean;
var
  iRet: integer;
  MsgStr: string;
  MainSQL,DetailSQL: Pchar;
begin
  result:=False;
  try
    MainSQL:=Pchar('delete from '+MainTable+' where '+KeyFieldName+'='''+BillNum+''' ');
    if PlugIntf.ExecSQL(MainSQL,iRet)<>0 then Raise Exception.Create(Pchar('删除〖'+MainTable+'，单号：'+BillNum+'〗执行出错！ '));   
    DetailSQL:=Pchar('delete from '+DetailTable+' where '+KeyFieldName+'='''+BillNum+''' ');
    if PlugIntf.ExecSQL(MainSQL,iRet)<>0 then Raise Exception.Create(Pchar('删除〖'+DetailTable+'，单号：'+BillNum+'〗执行出错！ '));   
    result:=true;
  except
    on E:Exception do
    begin
      MsgStr:=E.Message;
      if Pos('删除〖',MsgStr)>0 then
        Raise Exception.Create(E.Message) 
      else
        Raise Exception.Create(Pchar('删除历史单据〖表名：'+MainTable+'、'+DetailTable+'，单据号：'+BillNum+'〗执行出错：'+E.Message));
    end;
  end;
end;


{============================ 下面为上报RIM业务单据 [DB2\ORACLE] ==============================}
//////2011.04.14 AM上报月台账  (type='00')
function SendMonthReck(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE:string; iDbType: integer):boolean;
var
  iRet: integer;    //返回ExeSQL影响多少行记录
  Session: string;  //session前缀表名
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  Str,
  Short_ID: string;
begin
  result := false;
  MaxStamp:=GetMaxNUM(PlugIntf,'00',SHOP_ID,ORGAN_ID,CustID); //返回月台帐最大时间戳
  Short_ID:=Copy(SHOP_ID,Length(SHOP_ID)-3,4);  //门店ID的后四位

  //第一步: 创建台帐临时[INF_RECKMONTH]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKMONTH ('+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3门店ID的后四位
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'ITEM_ID VARCHAR(30) NOT NULL,'+     //RIM商品ID
             'GODS_ID CHAR(36) NOT NULL,'+        //R3商品ID
             'UNIT_CALC DECIMAL (18,6),'+         //商品计量单位换算管理单位换算值
             'RECK_MONTH VARCHAR(8) NOT NULL, '+  //台账月份
             'TIME_STAMP bigint NOT NULL'+       //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建月台帐临时表出错：'+PlugIntf.GetLastError);
    end;
  end;
  
  //第二步: 大于时间戳的台帐插入临时表:
  Str:='insert into '+Session+'INF_RECKMONTH(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_MONTH,TIME_STAMP) '+
       'select A.TENANT_ID,A.SHOP_ID,'''+Short_ID+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,('+GetDefaultUnitCalc+') as UNIT_CALC,trim(char(A.MONTH)) as RECK_MONTH,A.TIME_STAMP  '+
       ' from RCK_GOODS_MONTH A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+
       ' and A.SHOP_ID='''+SHOP_ID+''' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+'  and A.TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入月台帐临时表出错:'+PlugIntf.GetLastError);

  //第三步: 先删除历史在插入:
  if iRet>0 then  
  begin
    //获取更新上报最大时间戳：
    UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_RECKMONTH ');
    try
      PlugIntf.BeginTrans;
      //1、先删除RIM月台账表掉需要重新上报记录:
      Str:='delete from RIM_CUST_MONTH A where A.COM_ID='''+ORGAN_ID+''' and A.CUST_ID='''+CustID+''' and '+
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
        'select B.COM_ID,B.CUST_ID,SHORT_SHOP_ID,B.ITEM_ID,trim(char(A.MONTH)) as RECK_MONTH,0,0,0,0,'+ //1:
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
        ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and trim(char(A.MONTH))=B.RECK_MONTH and A.TIME_STAMP>'+MaxStamp;
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('上报月台账数据出错:'+PlugIntf.GetLastError);

      //3、更新上报时间戳:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''00'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新月台帐上报时间戳出错:'+PlugIntf.GetLastError);
      PlugIntf.CommitTrans; //提交事务

      //执行成功写日志:
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'00','上报月台帐成功','01');
      result:=true;
    except
      on E:Exception do
      begin
        PlugIntf.RollbackTrans;
        sleep(1);
        WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'00','上报月台帐错误！','02'); //写日志
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

//////上报POS零售单 (type='01')  
function SendSalesDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  SaleID,        //销售单ID
  CUST_CODE,     //会员号
  Str,
  SALES_DATE: string;
  SaleTab,DetailTab, GoodTab: string; //销售明细表、商品表
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'01',SHOP_ID,ORGAN_ID,CustID); //返回月台帐最大时间戳

  //第一步: 创建零售单（POS）临时[INF_POS_SALE]:
  case iDbType of
   1:
    begin
      Session:='';
      SALES_DATE:='trim(char(A.SALES_DATE)) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='cast(A.SALES_DATE as varchar(8)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_POS_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+     //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+   //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+   //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+    //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+   //RIM零售户ID
             'SALES_ID CHAR(36) NOT NULL,'+     //RIM零售销售单ID
             'SALE_DATE CHAR (8) NOT NULL,'+    //RIM零售销售单日期
             'CUST_CODE varchar (20),'+         //会员号
             'TIME_STAMP bigint NOT NULL'+      //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建零售单[INF_POS_SALE]错误:'+PlugIntf.GetLastError);
    end;
  end;

  try
    //第二步、循环插入中间表
    while true do
    begin
      SaleTab:='select SALES_ID,SALES_DATE,TIME_STAMP,IC_CARDNO from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=4 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
      SaleTab:='select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,A.SALES_ID,'+SALES_DATE+',B.CUST_CODE,A.TIME_STAMP from '+
               ' ('+SaleTab+')A left outer join PUB_CUSTOMER B on A.IC_CARDNO=B.CUST_ID order by A.TIME_STAMP ';
      case iDbType of
       1: str:='insert into '+Session+'INF_POS_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE,TIME_STAMP)'+
               'select tp.* from ('+SaleTab+')tp fetch first 100 rows only ';
       4: str:='insert into '+Session+'INF_POS_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE,TIME_STAMP)'+
               'select tp.* from ('+SaleTab+')where ROWNUM<=100 ';
      end;

      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入零售单临时表出错:'+PlugIntf.GetLastError);
      if iRet=0 then Break; //若插入没有记录，退出
      UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_POS_SALE ');

      //开始插入处理:
      PlugIntf.BeginTrans; //开始一个批次事务:
      //0、零售单不能修改，不需重报：
      //1、插入零售表头:                                                                       //R3_NUM, -->SALES_ID,
      Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
         ' select A.SALES_ID,'''','''',B.CUST_ID,SHORT_SHOP_ID,B.COM_ID,coalesce(INTEGRAL,0),B.SALE_DATE,B.CUST_CODE,B.SALE_DATE,(case when length(CREA_DATE)>12 then substr(CREA_DATE,12,length(CREA_DATE)-12) else ''00:00:00'' end) as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',SHORT_SHOP_ID '+
         ' from SAL_SALESORDER A,INF_POS_SALE B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALE_ID=B.SALE_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入售单表头错误:'+PlugIntf.GetLastError);

      //2、插入零售表体:
      DetailTab:=
         'select S.*,M.UNIT_NAME from SAL_SALESDATA S,INF_POS_SALE INF,VIW_MEAUNITS M '+
         ' where S.TENANT_ID=INF.TENANT_ID and S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.SALES_ID=INF.SALES_ID and '+
         ' S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID;

      Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE,TREND_ID)'+
           ' select A.SALES_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
           ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''',A.SHOP_ID '+
           ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
           ' B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入POS零售单表体出错：'+PlugIntf.GetLastError);

      //3、更新上报时间戳:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''01'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新上报时间戳出错:'+PlugIntf.GetLastError);

      PlugIntf.CommitTrans;  //提交事务
    end;//循环End
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'01','上报POS零售单成功！','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'01','上报POS零售单出错！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

////上报销售单（批发单）数据 (type='02')
function SendSaleBatchDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  SaleID,        //销售单ID
  Str,
  SALES_DATE: string;
  DetailTab, GoodTab: string; //销售明细表、商品表
  RsINF: TZQuery;     //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'02',SHOP_ID,ORGAN_ID,CustID);

  //第一步: 创建销售单（批发）临时[INF_SALE]:
  case iDbType of
   1:
    begin
      Session:='';
      SALES_DATE:='trim(char(A.SALES_DATE)) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='cast(A.SALES_DATE as varchar(8)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+   //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'SALES_ID CHAR(36) NOT NULL,'+       //RIM销售单ID
             'SALE_DATE CHAR (8) NOT NULL,'+      //RIM销售单日期
             'TIME_STAMP bigint NOT NULL'+        //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');
    end;
  end;

  //第二步、循环插入中间表
  try
    while true do
    begin
      case iDbType of
       1:
        begin
          str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
               'select tp.* from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+',TIME_STAMP '+
               ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
               ' order by TIME_STAMP)tp fetch first 100 rows only ';
        end;
       4:
        begin
          str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
               'select * from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+',TIME_STAMP '+
               ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
               ' order by TIME_STAMP) where ROWNUM<=100 ';
        end;
      end;
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单[INF_SALE]错误！'+PlugIntf.GetLastError);
      if iRet=0 then Break; //若插入没有记录，退出循环

      //取当前循环最大时间戳:
      UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_SALE ');

      PlugIntf.BeginTrans;
      //1、上报前删除历史单据：
      Str:='delete from RIM_RETAIL_DETAIL '+
           ' where Exists(select A.SALES_ID from INF_SALE A where RIM_RETAIL_DETAIL.COM_ID=A.COM_ID and RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售单表头出错：'+PlugIntf.GetLastError);
      Str:='delete from RIM_RETAIL_INFO '+
           ' where Exists(select A.SALES_ID from INF_SALE A where RIM_RETAIL_INFO.COM_ID=A.COM_ID and RIM_RETAIL_INFO.CUST_ID=A.CUST_ID and RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售单表体出错：'+PlugIntf.GetLastError);

      //2、插入销售表头:
      Str:='insert into RIM_RETAIL_INFO'+                                               //R3_NUM, ---> SALES_ID,
         '(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
         ' select SALES_ID,'' '','' '',B.CUST_ID,B.SHORT_SHOP_ID,B.COM_ID,0,B.SALE_DATE,'' '',B.SALE_DATE,'' '' as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',B.SHORT_SHOP_ID '+
         ' from SAL_SALESORDER A,INF_SALE B where  A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and '+
         ' A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+'''  ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表头[RIM_RETAIL_INFO]错误:'+PlugIntf.GetLastError);

      //3、插入销售表体:
      DetailTab:=
         'select S.*,M.UNIT_NAME from SAL_SALESDATA S,INF_SALE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=M.SHOP_ID and '+
         ' S.SALES_ID=M.SALES_ID and S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID;
      Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
         ' select A.SALES_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
         ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
         ' B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表体错误:'+PlugIntf.GetLastError);

      //4、更新上报时间戳:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''02'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售单上报时间戳出错！');

      PlugIntf.CommitTrans; //提交事务
    end; //循环End
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'02','上报批发销售单成功！','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'02','上报销售单（批发）！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//销售退货单  (type='03')            
function SendSaleRetDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  SaleID,        //销售单ID
  Str,
  SALES_DATE: string;
  DetailTab, GoodTab: string; //销售明细表、商品表
  RsINF: TZQuery;     //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'03',SHOP_ID,ORGAN_ID,CustID);  

  //第一步: 创建销售退货单临时[INF_SALE]:
  case iDbType of
   1:
    begin
      Session:='';
      SALES_DATE:='trim(char(A.SALES_DATE)) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='cast(A.SALES_DATE as varchar(8)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+        //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+      //R3门店ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+       //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+      //RIM零售户ID
             'SALES_ID CHAR(36) NOT NULL,'+        //RIM销售单ID
             'SALE_DATE CHAR (8) NOT NULL,'+       //RIM销售单日期
             'TIME_STAMP bigint NOT NULL'+         //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售退货单临时表[INF_SALE]错误！');
    end;
  end;

  //第二步、循环插入中间表
  try
    while true do
    begin
      case iDbType of
       1:
        begin
          str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
               'select tp.* from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+',TIME_STAMP '+
               'from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
               ' order by TIME_STAMP)tp fetch first 100 rows only ';
        end;
       4:
        begin
          str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
               'select * from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+',TIME_STAMP '+
               'from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
               ' order by TIME_STAMP) where ROWNUM<=100 ';
        end;
      end;
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售退货单[INF_SALE]错误！'+PlugIntf.GetLastError);
      if iRet=0 then Break; //若插入没有记录，退出循环

      //取当前循环最大时间戳:
      UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_SALE ');

      PlugIntf.BeginTrans; //开始事务
      //1、上报前删除历史单据：
      Str:='delete from RIM_RETAIL_DETAIL '+
           ' where Exists(select A.SALES_ID from INF_SALE A where RIM_RETAIL_DETAIL.COM_ID=A.COM_ID and RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售退货单表头出错：'+PlugIntf.GetLastError);
      Str:='delete from RIM_RETAIL_INFO '+
           ' where Exists(select A.SALES_ID from INF_SALE A where RIM_RETAIL_INFO.COM_ID=A.COM_ID and RIM_RETAIL_INFO.CUST_ID=A.CUST_ID and RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史销售退货单表体出错：'+PlugIntf.GetLastError);

      //2、插入销售表头:
      Str:='insert into RIM_RETAIL_INFO '+                                               //R3_NUM, ---> SALES_ID,
         '(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
         ' select SALES_ID,'' '','' '',B.CUST_ID,B.SHORT_SHOP_ID,B.COM_ID,0,B.SALE_DATE,'' '',B.SALE_DATE,'' '' as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',B.SHORT_SHOP_ID '+
         ' from SAL_SALESORDER A,INF_SALE B where  A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and '+
         ' A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+'''  ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表头[RIM_RETAIL_INFO]错误:'+PlugIntf.GetLastError);
      //3、插入销售表体:
      DetailTab:=
         'select S.*,M.UNIT_NAME from SAL_SALESDATA S,INF_SALE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=M.SHOP_ID and '+
         ' S.SALES_ID=M.SALES_ID and S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID;
      Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
         ' select A.SALES_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
         ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
         ' B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表体错误:'+PlugIntf.GetLastError);

      //4、更新上报时间戳:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''03'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售退货单上报时间戳出错！');

      PlugIntf.CommitTrans; //提交事务
    end; //循环End
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'03','上报销售退货单成功！','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'03','上报销售退货单！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//上报调拨单 (type='04')
{说明: 新R3设计时把调入当作为入库单，存储在入库表，调出单作为出库单，存储在销售单;同步时分两步处理 }
function SenddbInDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  MaxStamp,         //已上报最大时间戳
  UpMaxStamp,       //本次上报最大时间戳
  DBID,             //RIM调拨(入)单ID(在R3调拨单 + _1)
  R3_DBID,          //R3调拨(入)单ID
  Str,
  BillDate: string;
  DetailTab, GoodTab: string; //调拨明细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'04',SHOP_ID,ORGAN_ID,CustID); 

  //第一步: 创建销售单（批发）临时[INF_SALE]:
  case iDbType of
   1:
    begin
      Session:='';
      BillDate:='trim(char(A.STOCK_DATE)) as STOCK_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='trim(char(A.STOCK_DATE)) as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_DB( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'SHORT_SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID后4位
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'DB_ID VARCHAR(40) NOT NULL,'+       //RIM调拨ID
             'DB_NEWID CHAR(36) NOT NULL,'+       //RIM调拨ID(原单据+"_1")
             'DB_DATE CHAR(8) NOT NULL,'+         //RIM调拨日期
             'TIME_STAMP bigint NOT NULL'+        //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');
    end;
  end;

  //第二步、插入中间(临时)表
  try
    while true do
    begin
      case iDbType of
       1:
        begin
          str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE,TIME_STAMP)'+
             'select tp.* from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,STOCK_ID || ''_1'' as DB_NEWID,'+BillDate+',TIME_STAMP from '+
             ' STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
             ' order by TIME_STAMP)tp fetch first 100 rows only ';
        end;
       4:
        begin
          str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE,TIME_STAMP)'+
             'select * from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,STOCK_ID || ''_1'' as DB_NEWID,'+BillDate+',TIME_STAMP from '+
             ' STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
             ' order by TIME_STAMP) where ROWNUM<=100 ';
        end;
      end;
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调入单[INF_DB]错误！'+PlugIntf.GetLastError);
      if iRet=0 then Break; //若插入没有记录，退出循环

      //取当前循环最大时间戳:
      UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_DB ');

      PlugIntf.BeginTrans; //开始事务
      //1、上报前删除历史单据：
      Str:='delete from RIM_CUST_TRN '+
           ' where Exists(select 1 from INF_DB A where RIM_CUST_TRN.COM_ID=A.COM_ID and RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调入单表头出错：'+PlugIntf.GetLastError);
      Str:='delete from RIM_CUST_TRN_LINE '+
           ' where Exists(select 1 from INF_DB A where RIM_CUST_TRN_LINE.COM_ID=A.COM_ID and RIM_CUST_TRN_LINE.CUST_ID=A.CUST_ID and RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史调入单表体出错：'+PlugIntf.GetLastError);

      //2、插入调拨（入）单表头:
      Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
         ' select B.DB_NEWID,A.CUST_ID,''2'' as vTYPE,B.COM_ID,SHORT_SHOP_ID,''02'',DB_DATE,CREA_USER,DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,SHORT_SHOP_ID '+
         ' from STK_STOCKORDER A,INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.DB_ID '+
         ' A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and '''+R3_DBID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调播单批发表头出错：'+PlugIntf.GetLastError);



        //3、插入零售表体:
        DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.STOCK_ID='''+R3_DBID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
             ' select A.STOCK_ID || ''_1'' as STOCK_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨（入）单批发表体[RIM_CUST_TRN_LINE]错误！（SQL='+str+'）');

        //4、更新上报时间戳:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''04'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售单上报时间戳出错！');
        //提交事务
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'04','上报调拨（入）单：','02');  //写日志
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'04','上报调拨（出）单成功！','01');
  finally
    RsINF.Free;
  end;
end;

//上报调拨单 (type='12')  单据号码=SALES_ID + _2
{说明: 新R3设计时把调入当作为入库单，存储在入库表，调出单作为出库单，存储在销售单;同步时分两步处理 }
function SenddbOutDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  DBID,          //RIM调拨(入)单ID(在R3调拨单 + _1)
  R3_DBID,       //R3调拨(入)单ID
  Str: string;
  DetailTab, GoodTab: string; //调拨明细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'12',SHOP_ID,ORGAN_ID,CustID); 

  //第一步: 创建销售单（批发）临时[INF_SALE]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_DB( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'DB_ID CHAR(36) NOT NULL,'+          //RIM调拨ID
             'TIME_STAMP bigint NOT NULL'+        //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');
    end;
  end;
  
  //第二步、插入中间(临时)表
  str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,DB_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID || ''_2'' as SALES_ID,TIME_STAMP '+
       ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨(出)单[INF_DB]错误！（SQL='+str+'）');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    RsINF.SQL.Text:='select DB_ID,TIME_STAMP from '+Session+'INF_DB order by TIME_STAMP';
    OpenData(PlugIntf, RsINF);
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //若为空数据退出

    //第三步: 循环分批处理：每次执行1单POS销售单]
    RsINF.First;
    while not RsINF.Eof do
    begin
      DBID:=trim(RsINF.fieldbyName('DB_ID').AsString);     //销售单据号
      R3_DBID:=Copy(DBID,1,36); //GUIID
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //当前最大时间戳

      //开始插入处理:
      PlugIntf.BeginTrans;
      try
        //1、上报前删除历史单据：
        DeleteExistsReportedBill(PlugIntf,'RIM_CUST_TRN','RIM_CUST_TRN_LINE','TRN_NUM',DBID);

        //2、插入调拨（入）单表头:                                       //R3_NUM,--->SALES_ID || ''_2'' as SALES_ID,
        Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
           ' select SALES_ID || ''_2'' as SALES_ID,'''+CustID+''' as CUST_ID,''02'' as vTYPE,'''+ORGAN_ID+''' as COM_ID,right('''+SHOP_ID+''',4) as TERM_ID,''2'',trim(char(SALES_DATE)),CREA_USER,trim(char(SALES_DATE)),'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_ID='''+R3_DBID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调播单批发表头[RIM_CUST_TRN]错误！（SQL='+str+'）');

        //3、插入零售表体:
        DetailTab:='select S.*,M.UNIT_NAME from SAL_SALESDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.SALES_ID='''+R3_DBID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
             ' select A.SALES_ID || ''_2'' as SALES_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨（入）单批发表体[RIM_CUST_TRN_LINE]错误！（SQL='+str+'）');

        //4、更新上报时间戳:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''12'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售单上报时间戳出错！');
        //提交事务
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'12','上报调拨（出）单','02');  //写日志
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'12','上报调拨（出）单成功！','01');
  finally
    RsINF.Free;
  end;
end; 

//上报入库单 [type='05']
function SendStockDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer;  //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  MaxStamp,       //已上报最大时间戳
  UpMaxStamp,     //本次上报最大时间戳
  StockID,        //出库单号
  Str: string;
  DetailTab, GoodTab: string; //入库单细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'05',SHOP_ID,ORGAN_ID,CustID);

  //第一步: 创建销售单（批发）临时[INF_STOCK]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'STOCK_ID CHAR(36) NOT NULL,'+       //RIM入库单ID
             'TIME_STAMP bigint NOT NULL'+        //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建进货入库单临时表[INF_SALE]错误！');
    end;
  end;
  
  //第二步、插入中间(临时)表
  str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,STOCK_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,TIME_STAMP '+
       ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库单中间表[INF_STOCK]错误！（SQL='+str+'）');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    RsINF.SQL.Text:='select STOCK_ID,TIME_STAMP from '+Session+'INF_STOCK order by TIME_STAMP';
    OpenData(PlugIntf, RsINF);
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //若为空数据退出

    //第三步: 循环分批处理：每次执行1单入库单]
    RsINF.First;
    while not RsINF.Eof do
    begin
      StockID:=trim(RsINF.fieldbyName('STOCK_ID').AsString);      //单据号
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //最大时间戳

      //开始插入处理:
      PlugIntf.BeginTrans;
      try
        //1、上报前删除历史单据：
        DeleteExistsReportedBill(PlugIntf,'RIM_VOUCHER','RIM_VOUCHER_LINE','VOUCHER_NUM',StockID);

        //2、插入调拨（入）单表头:                                               //R3_NUM, --> STOCK_ID,
        Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
           ' select STOCK_ID,'' '' as RETAIL_NUM,'''+CustID+''' as CUST_ID,'''+ORGAN_ID+''' as COM_ID,trim(char(TENANT_ID))as TERM_ID,''02'',trim(char(STOCK_DATE)),CREA_USER,trim(char(STOCK_DATE)),''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_ID='''+StockID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表头[RIM_VOUCHER]错误！');

        //3、插入零售表体:
        DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.STOCK_ID='''+StockID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
             ' select A.STOCK_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表体[RIM_VOUCHER_LINE]错误！');

        //4、更新上报时间戳:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''05'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新进货入库单上报时间戳出错！');
        //提交事务
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'05','上报进货入库单！','02');  //写日志
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'05','上报进货入库单成功！','01');
  finally
    RsINF.Free;
  end;
end;

//上报入库退货 (type='06')
function SendStkRetuDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer;  //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  MaxStamp,       //已上报最大时间戳
  UpMaxStamp,     //本次上报最大时间戳
  StockID,        //出库单号
  Str: string;
  DetailTab, GoodTab: string; //入库单细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'05',SHOP_ID,ORGAN_ID,CustID); 

  //第一步: 创建销售单（批发）临时[INF_STOCK]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'STOCK_ID CHAR(36) NOT NULL,'+       //RIM调拨ID
             'TIME_STAMP bigint NOT NULL'+        //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单（批发）临时[INF_STOCK]错误！');
    end;
  end;
  //第二步、插入中间(临时)表
  str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,STOCK_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,TIME_STAMP '+
       ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单（批发）中间表[INF_STOCK]错误！（SQL='+str+'）');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    RsINF.SQL.Text:='select STOCK_ID,TIME_STAMP from '+Session+'INF_STOCK order by TIME_STAMP';
    OpenData(PlugIntf, RsINF);
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //若为空数据退出

    //第三步: 循环分批处理：每次执行1单入库单]
    RsINF.First;
    while not RsINF.Eof do
    begin
      StockID:=trim(RsINF.fieldbyName('STOCK_ID').AsString);     //销售单据号
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //当前最大时间戳

      //开始插入处理:
      PlugIntf.BeginTrans;
      try
        //1、上报前删除历史单据：
        DeleteExistsReportedBill(PlugIntf,'RIM_VOUCHER','RIM_VOUCHER_LINE','VOUCHER_NUM',StockID);

        //2、插入调拨（入）单表头:                                              //R3_NUM, --> STOCK_ID,
        Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
           ' select STOCK_ID,'' '' as RETAIL_NUM,'''+CustID+''' as CUST_ID,'''+ORGAN_ID+''' as COM_ID,trim(char(TENANT_ID))as TERM_ID,''02'',trim(char(STOCK_DATE)),CREA_USER,trim(char(STOCK_DATE)),''02'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_ID='''+StockID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单（批发）表头[RIM_VOUCHER]错误！（SQL='+str+'）');

        //3、插入零售表体:
        DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.STOCK_ID='''+StockID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
             ' select A.STOCK_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单（批发）表体[RIM_VOUCHER_LINE]错误！（SQL='+str+'）');

        //4、更新上报时间戳:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''05'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售单（批发）上报时间戳出错！');
        //提交事务
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'06','上报采购退货单','02');  //写日志
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'06','上报采购退货单成功！','01');
  finally
    RsINF.Free;
  end;
end;

//上报调整单  (type='07')
function SendChangeDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer;  //返回ExeSQL影响多少行记录
  Session: string;  //session前缀  
  MaxStamp,       //已上报最大时间戳
  UpMaxStamp,     //本次上报最大时间戳
  ChangeID,       //调整单ID
  Str: string;
  DetailTab, GoodTab: string; //入库单细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'07',SHOP_ID,ORGAN_ID,CustID); 

  //第一步: 创建销售单（批发）临时[INF_CHANGE]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_CHANGE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
             'CHANGE_ID CHAR(36) NOT NULL,'+      //RIM调整单ID
             'TIME_STAMP bigint NOT NULL'+        //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建〖调整单〗临时[INF_CHANGE]错误！');
    end;
  end;

  //第二步、插入中间(临时)表
  str:='insert into '+Session+'INF_CHANGE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,CHANGE_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,CHANGE_ID,TIME_STAMP '+
       ' from STO_CHANGEORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入〖调整单〗中间表[INF_CHANGE]错误！（SQL='+str+'）');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    RsINF.SQL.Text:='select CHANGE_ID,TIME_STAMP from '+Session+'INF_CHANGE order by TIME_STAMP';
    OpenData(PlugIntf, RsINF);
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //若为空数据退出

    //第三步: 循环分批处理：每次执行1单入库单]
    RsINF.First;
    while not RsINF.Eof do
    begin
      ChangeID:=trim(RsINF.fieldbyName('CHANGE_ID').AsString);     //销售单据号
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //当前最大时间戳

      //开始插入处理:
      PlugIntf.BeginTrans;
      try
        //1、上报前删除历史单据：
        DeleteExistsReportedBill(PlugIntf,'RIM_ADJUST_INFO','RIM_ADJUST_DETAIL','ADJUST_NUM',ChangeID);

        //2、插入调整单表头:                                                //R3_NUM, --> CHANGE_ID,
        Str:='insert into RIM_ADJUST_INFO(ADJUST_NUM,CUST_ID,COM_ID,TERM_ID,TYPE,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
           ' select CHANGE_ID,'''+CustID+''' as CUST_ID,'''+ORGAN_ID+''' as COM_ID,trim(char(TENANT_ID))as TERM_ID,'+
           ' (case when CHANGE_CODE=''01'' then ''02'' else ''03'' end) as CHANGE_CODE,''02'',trim(char(CHANGE_DATE)),CREA_USER,trim(char(CHANGE_DATE)),'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from STO_CHANGEORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and CHANGE_ID='''+ChangeID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入〖调整单〗表头[RIM_VOUCHER]错误！（SQL='+str+'）');

        //3、插入调整单表体:
        DetailTab:='select S.*,M.UNIT_NAME from STO_CHANGEDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.CHANGE_ID='''+ChangeID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_ADJUST_DETAIL(ADJUST_NUM,ADJUST_LINE,COM_ID,ITEM_ID,UM_ID,QTY_ADJUST,QTY_MINI_UM,AMT_ADJUST)'+
             ' select A.CHANGE_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入〖调整单〗表体[RIM_ADJUST_DETAIL]错误！（SQL='+str+'）');

        //4、更新上报时间戳:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''07'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新〖调整单〗上报时间戳出错！');
        //提交事务
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'07','上报〖调整单〗错误','02');  //写日志
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'07','上报〖调整单〗成功！','01');
  finally
    RsINF.Free;
  end;
end;     

{
 原来参数分析:
 (1)INTF_SELF:零售户编号（也就是许可证号）（通过许可证取零售户ID）
 (2)INTF_CODE:烟草公司ID
 (3)COMP_ID:R3老系统门店ID

 R3上报:
 (1)单位换算:将单据计量单位换算成管理单位上报;
 (2)企业档案: R3: CA_TENANT     --->   RIM: RIM_ORGAN  (烟草专门局|公司)
 (3)门店档案: R3: CA_SHOP_INFO  --->   RIM: RM_CUST    (零售户)     
}

procedure CallBillSync(PlugIntf:IPlugIn; InParams: string);   //上报单据数据
var
  Str: string;       //企业表视图
  OrganID,           //RIM烟草公司ID
  LICENSE_CODE,      //RIM零售户许可证号
  CustID,            //RIM零售户ID
  TenantID,          //R3上报企业ID
  TenName,           //R3上报企业Name
  ShopID,            //R3上报门店ID
  ShopName: string;  //R3上报门店名称;
  ReckDate: string;  //前台传入的指定上报日期
  R3ShopList, Rs: TZQuery;
  vParam: TftParamList;
  IsFlag: Boolean;    //是否为零售户直接上报
  RunInfo: TRunInfo;  //运行日志
  DbType: integer;
begin
  ReckDate:='';
  //返回数据库类型
  if PlugIntf.iDbType(DbType)<>0 then Raise Exception.Create('返回数据库类型错误：'+PlugIntf.GetLastError);
  
  RunInfo.BegTime:=Timetostr(time());
  RunInfo.BegTick:=GetTickCount;
  RunInfo.RunCount:=0;
  RunInfo.NotCount:=0;
  RunInfo.ErrorCount:=0;
  RunInfo.ErrorStr:='';

  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,InParams);
    TenantID:=vParam.ParamByName('TENANT_ID').AsString;
    IsFlag:=False; 
    if (vParam.FindParam('FLAG')<>nil) and (vParam.FindParam('FLAG').AsInteger=3) then
    begin
      IsFlag:=true;
      if vParam.FindParam('RECKDATE')<>nil then
        ReckDate:=vParam.FindParam('RECKDATE').AsString;
    end;
  finally
    vParam.Free;
  end;

  Rs := TZQuery.Create(nil);
  R3ShopList := TZQuery.Create(nil);
  try
    //返回R3的上报ShopList
    GetR3ReportShopList(PlugIntf, R3ShopList, InParams);
    if R3ShopList.RecordCount=0 then Raise Exception.Create(' 企业表没有对应到数据，不需上报！ ');

    //按门店ID排序循环上报
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      CustID:='';
      try
        TenantID:=trim(R3ShopList.Fields[0].AsString);      //R3企业ID (Field: TENANT_NAME)
        TenName:=trim(R3ShopList.Fields[1].AsString);       //R3企业名称 (Field: TENANT_NAME)
        ShopID:=trim(R3ShopList.Fields[2].AsString);        //R3门店ID (Field: SHOP_ID)
        ShopName:=trim(R3ShopList.Fields[3].AsString);      //R3门店名称 (Field: SHOP_NAME)
        LICENSE_CODE:=trim(R3ShopList.Fields[4].AsString);  //R3门店许可证号 (Field: LICENSE_CODE)

        //根据R3传入烟草公司企业ID(TENANT_ID)
        Rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenantID+' and B.SHOP_ID='''+ShopID+''' ';
        if OpenData(GPlugIn, Rs) then        begin          OrganID:=trim(rs.fieldbyName('COM_ID').AsString);          CustID:=trim(rs.fieldbyName('CUST_ID').AsString);        end;
        if OrganID='' then Raise Exception.Create('R3传入企业（'+TenantID+' —'+TenName+'）在RIM中没找到对应的ORGAN_ID值...');
        if CustID<>'' then
        begin
          //开始销售日台账：
          if SendDayReck(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE,ReckDate,DbType) then 
            Inc(RunInfo.RunCount)    //累计上报成功门店数
          else
            Inc(RunInfo.ErrorCount); //累计上报失败门店个数
        end else
        begin
          RunInfo.ErrorStr:=RunInfo.ErrorStr+'   '+'R3门店:'+ShopID+' —'+ShopName+' 许可证号'+LICENSE_CODE+' 在Rim系统中没对应上！';
          Inc(RunInfo.NotCount);  //对应不上
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          RunInfo.ErrorStr:=RunInfo.ErrorStr+'   '+E.Message;
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'10','上报销售出错误！','02'); //写Rim表错误日志
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    Rs.Free; 
    R3ShopList.Free;
    RunInfo.BegTick:=GetTickCount-RunInfo.BegTick; //总执行多少秒
    //输出日志:
    if IsFlag then  //客户端单个门店日志
    begin
      if RunInfo.RunCount=1 then
        PlugIntf.WriteLogFile(Pchar('R3终端上报库存,传入门店：('+ShopID+'- '+ShopName+') 开始执行时间：'+RunInfo.BegTime+' 共执行'+FormatFloat('#0.00',RunInfo.BegTick/1000)+'秒  上报成功！')) 
      else
        PlugIntf.WriteLogFile(Pchar('R3终端上报库存,传入门店：('+ShopID+'- '+ShopName+') 开始执行时间：'+RunInfo.BegTime+' 共执行'+FormatFloat('#0.00',RunInfo.BegTick/1000)+'秒  上报出错:'+RunInfo.ErrorStr));
    end else  //后台调度运行:
    begin
      PlugIntf.WriteLogFile(Pchar('R3终端上报库存,传入企业：('+TenantID+'- '+TenName+') 开始执行时间：'+RunInfo.BegTime+' 共执行'+FormatFloat('#0.00',RunInfo.BegTick/1000)+'秒 '));
      Str:='上报成功门店数：'+inttostr(RunInfo.RunCount)+'  Rim中没有对应门店数:'+inttoStr(RunInfo.NotCount)+' 上报失败门店数:'+inttoStr(RunInfo.ErrorCount);
      if RunInfo.ErrorStr<>'' then Str:=Str+' 错误消息： '+#13+RunInfo.ErrorStr;
      PlugIntf.WriteLogFile(Pchar(RunInfo.ErrorStr));
    end; 
  end;
end;    


end.















