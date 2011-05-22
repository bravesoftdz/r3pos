{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;

 ------------------------------------------------------------------------------}

unit uReportedFactory;

interface

uses                 
  SysUtils,Classes,zDataSet,ufnUtil,uPlugInUtil;


procedure CallSync(PlugIntf:IPlugIn; TENANT_ID: string);

implementation

//2011.04.14 获取上报最大编号(MaxTime)[采用时间戳，暂没使用]
function GetMaxTIME(PlugIntf:IPlugIn; BillType,SHOP_ID,ORGAN_ID,CustID: string): string;
var
  iRet: integer;
  Str: string;
  Rs: TZQuery;
begin
  result:='';
  try
    Rs:=TZQuery.Create(nil);
    Str:='select BAL_TIME from RIM_R3_NUM where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE='''+BillType+''' and TERM_ID='''+SHOP_ID+'''';
    OpenData(PlugIntf, Rs, Str);
    if Rs.Active then
      result:=trim(Rs.Fields[0].AsString);
    if Rs.IsEmpty then
    begin
      str:='insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM,BAL_TIME) values ('''+ORGAN_ID+''','''+CustID+''','''+BillType+''','''+SHOP_ID+''',''000000000000000'',null)';
      if PlugIntf.ExecSQL(Pchar(str),iRet)<>0 then
        Raise Exception.Create('RIM_R3_NUM表执行插入错误！');
    end;
  finally
    Rs.Free;
  end;
end;

//2011.04.14 获取上报最大编号(MaxNum)
function GetMaxNUM(PlugIntf:IPlugIn; BillType,SHOP_ID,ORGAN_ID,CustID: string): string; 
var
  iRet: integer;
  Str: string;
  Rs: TZQuery;
begin
  result:='';
  try
    Rs:=TZQuery.Create(nil);  
    Str:='select MAX_NUM from RIM_R3_NUM where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE='''+BillType+''' and TERM_ID='''+SHOP_ID+'''';
    OpenData(PlugIntf, Rs, Str);
    if Rs.Active then
      result:=trim(Rs.Fields[0].AsString);
    if result='' then result:='0'; 
    if Rs.IsEmpty then
    begin
      str:='insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values ('''+ORGAN_ID+''','''+CustID+''','''+BillType+''','''+SHOP_ID+''',''0'')';
      if PlugIntf.ExecSQL(Pchar(str),iRet)<>0 then
        Raise Exception.Create('RIM_R3_NUM执行插入初值错误！（'+str+'）');
    end;
  finally
    Rs.Free;
  end;
end;

//2011.04.15 写入上报执行日志
function WriteToRIM_BAL_LOG(PlugIntf:IPlugIn; LICENSE_CODE,CustID,LogType,LogNote,LogStatus: string; USER_ID: string='auto'): Boolean; //返回插入语句执行返回值;
var
  str: string;
  iRet: integer;
begin
  Str:='insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values '+
       '('''+LICENSE_CODE+Formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''','''+LogType+''','''+CustID+''','''+Formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''','''+LogNote+''',''auto'','''+LogStatus+''')' ;
  if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then
   Raise Exception.Create('写日志执行失败！(SQL='+Str+')');
end;

//返回商品表管理单位与计量单位换算SQl:
function GetDefaultUnitCalc(AliasTable: string=''): string;
var
  AliasTab: string;
begin
  if trim(AliasTable)<>'' then
    AliasTab:=trim(AliasTable)+'.';
  result:=
    'case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.0 '+             //默认单位为 计量单位
         ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC '+  //默认单位为 小单位
         ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC '+      //默认单位为 大单位
         ' else 1.0 end ';                                                        //都不是则默认为换算为1;
end;

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


{============================ 下面为上报RIM业务单据 ==============================}

//////2011.04.14 AM上报月台账  (type='00')
function SendMonthReck(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE:string):boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  Str: string;
begin
  result := false;
  MaxStamp:=GetMaxNUM(PlugIntf,'00',SHOP_ID,ORGAN_ID,CustID); //返回月台帐最大时间戳
  TLogRunInfo.LogWrite('月台帐（SendMonthReck）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');

  //第一步: 创建台帐临时[INF_RECKMONTH]:
  Str:=
    'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKMONTH ('+
         'TENANT_ID INTEGER NOT NULL,'+     //R3企业ID
         'SHOP_ID VARCHAR(20) NOT NULL,'+   //R3门店ID
         'COM_ID VARCHAR(30) NOT NULL,'+    //RIM烟草公司ID
         'CUST_ID VARCHAR(30) NOT NULL,'+   //RIM零售户ID
         'ITEM_ID VARCHAR(30) NOT NULL,'+   //RIM商品ID
         'GODS_ID CHAR(36) NOT NULL,'+      //R3商品ID
         'UNIT_CALC DECIMAL (18,6),'+       //商品计量单位换算管理单位换算值
         'RECK_MONTH VARCHAR(8) NOT NULL '+ //台账月份
         ') ON COMMIT PRESERVE ROWS WITH REPLACE NOT LOGGED';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建月台帐临时表（session.INF_RECKMONTH）错误！');

  //第二步: 大于时间戳的台帐插入临时表:
  Str:='insert into session.INF_RECKMONTH(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_MONTH) '+
       'select A.TENANT_ID,A.SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,1.0,trim(char(A.MONTH)) as RECK_MONTH  '+
       ' from RCK_GOODS_MONTH A,PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+
       ' and A.SHOP_ID='''+SHOP_ID+''' and B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+'  and A.TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入月台帐临时表数据出错！');
  TLogRunInfo.LogWrite(' '+#13+'月台帐（SendMonthReck）插入中间表记录数:'+inttoStr(iRet)+'笔   InsertSQL='+Str,'RimOrderDownPlugIn.dll');

  //第三步、更新商品计量单位换算管理单位换算值
  Str:='update session.INF_RECKMONTH A set A.UNIT_CALC=(select ('+GetDefaultUnitCalc+') as UNIT_CALC from PUB_GOODSINFO B where A.GODS_ID=B.GODS_ID) where exists(select 1 from PUB_GOODSINFO B where A.GODS_ID=B.GODS_ID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新商品计量单位换算管理单位换算值出错！');

  //第四步、获取更新上报最大时间戳：
  Str:='select max(A.TIME_STAMP) as TIME_STAMP from RCK_GOODS_MONTH A,session.INF_RECKMONTH B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and B.TENANT_ID='+TENANT_ID+' and A.TIME_STAMP>'+MaxStamp;
  UpMaxStamp:=GetValue(PlugIntf, Str);
  TLogRunInfo.LogWrite('月台帐（SendMonthReck）本次上报最大时间戳:'+UpMaxStamp,'RimOrderDownPlugIn.dll');  

  //第五步: 先删除插入:
  if iRet>0 then  //有记录才执行
  begin
    try
      PlugIntf.BeginTrans;
      //1、先删除RIM月台账表掉需要重新上报记录:
      Str:='delete from RIM_CUST_MONTH A where A.COM_ID='''+ORGAN_ID+''' and A.CUST_ID='''+CustID+''' and '+
           ' exists(select 1 from session.INF_RECKMONTH B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.ITEM_ID=B.ITEM_ID and A.MONTH=B.RECK_MONTH)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除月台账〖RIM_CUST_MONTH〗需要重新上报历史数据出错！');

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
        'select B.COM_ID,B.CUST_ID,trim(char(A.TENANT_ID)) as TERM_ID,B.ITEM_ID,trim(char(A.MONTH)) as RECK_MONTH,0,0,0,0,'+ //1:
            '(case when B.UNIT_CALC>0 then ORG_AMT/B.UNIT_CALC else ORG_AMT end)as ORG_AMT,ORG_MNY,'+          //2:期初数量、金额
            '(case when B.UNIT_CALC>0 then STOCK_AMT/B.UNIT_CALC else STOCK_AMT end)as STOCK_AMT,STOCK_MNY,'+  //3:入库数量、金额
            'SALE_AMT,SALE_MNY+SALE_TAX,'+  //4:销售数量、含税金额
            '(case when CHANGE1_AMT>0 then (case when B.UNIT_CALC>0 then CHANGE1_AMT/B.UNIT_CALC else CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT>0 then CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+    //5: 溢余数量、金额
            '(case when CHANGE1_AMT<0 then (case when B.UNIT_CALC>0 then -CHANGE1_AMT/B.UNIT_CALC else -CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT<0 then -CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+  //6: 溢损数量、金额
            '(case when B.UNIT_CALC>0 then (CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)/B.UNIT_CALC else CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT end)as CHANGE_AMT,(CHANGE2_MNY+CHANGE3_MNY+CHANGE3_MNY+CHANGE4_MNY+CHANGE5_MNY) as CHANGE_MNY,'+      //7: 调整数量、金额
            '(case when B.UNIT_CALC>0 then DBIN_AMT/B.UNIT_CALC else DBIN_AMT end)as DBIN_AMT,DBIN_MNY,'+      //8: 调入数量、金额
            '(case when B.UNIT_CALC>0 then DBOUT_AMT/B.UNIT_CALC else DBOUT_AMT end)as DBOUT_AMT,DBOUT_MNY,'+  //9: 调出数量、金额
            '(case when B.UNIT_CALC>0 then BAL_AMT/B.UNIT_CALC else BAL_AMT end)as BAL_AMT,BAL_MNY,'+          //10: 期末数量、金额
            'ADJ_CST,BAL_CST,'+             //11: 单位成本、销售成本
            'SALE_PRF,0 '+                  //12: 毛利额、贡献毛利
        'from RCK_GOODS_MONTH A,session.INF_RECKMONTH B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and trim(char(A.MONTH))=B.RECK_MONTH and A.TIME_STAMP>'+MaxStamp;
      TLogRunInfo.LogWrite('月台帐（SendMonthReck）插入SQL:'+Str,'RimOrderDownPlugIn.dll');
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('上报RIM_CUST_MONTH数据出错！');

      //3、更新上报时间戳:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''00'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新上报时间戳出错！');
      PlugIntf.CommitTrans; //提交事务

      //执行成功写日志:
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'00','上报月台帐成功','01');
      TLogRunInfo.LogWrite('月台帐（SendMonthReck）本次上报执行成功！','RimOrderDownPlugIn.dll');
      result:=true;
    except
      on E:Exception do
      begin
        PlugIntf.RollbackTrans;
        sleep(1);
        WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'00','上报月台帐错误！','02'); //写日志
        TLogRunInfo.LogWrite('上报月台帐错误出错：错误信息='+E.Message,'RimOrderDownPlugIn.dll'); //写错误日志代码
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
end;  

//////2011.04.14 PM上报日台账  (type='10')
function SendDayReck(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE:string):boolean;
var
  RunTimes,       //循环次数  
  iRet: integer; //返回ExeSQL影响多少行记录
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  Str: string;
begin
  result := false;
  RunTimes:=0;  //循环次数
  MaxStamp:=GetMaxNUM(PlugIntf,'10',SHOP_ID,ORGAN_ID,CustID); //返回日台账最大时间戳
  TLogRunInfo.LogWrite('日台帐（SendDayReck）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');
  
  //创建日台帐临时[INF_RECKDAY]:
  Str:=
    'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKDAY( '+
         ' TENANT_ID INTEGER NOT NULL,'+     //R3企业ID
         ' SHOP_ID VARCHAR(20) NOT NULL,'+   //R3门店ID
         ' COM_ID VARCHAR(30) NOT NULL,'+    //RIM烟草公司ID
         ' CUST_ID VARCHAR(30) NOT NULL,'+   //RIM零售户ID
         ' ITEM_ID VARCHAR(30) NOT NULL,'+   //RIM商品ID
         ' GODS_ID CHAR(36) NOT NULL,'+      //R3商品ID
         ' UNIT_CALC DECIMAL (18,6),'+       //商品计量单位换算管理单位换算值
         ' RECK_DAY VARCHAR(8) NOT NULL,'+   //台账日期
         ' QTY_ORD DECIMAL (18,6),'+         //台账销售数量
         ' AMT DECIMAL (18,6),'+             //台账销售金额
         ' TIME_STAMP bigint NOT NULL'+      //时间戳
         ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建日销售临时表（session.INF_RECKDAY）错误！');

  {==循环处理: 每次循环只处理[20天日销售数据] ==}
  while True do
  begin
    inc(RunTimes); //循环一次加1;
    iRet:=0;
    //第一步: 大于时间戳的台帐插入临时表:
    Str:='insert into session.INF_RECKDAY(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_DAY,QTY_ORD,AMT,TIME_STAMP) '+
       'select tp.* from ('+
       'select A.TENANT_ID,A.SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,1.0,trim(char(A.CREA_DATE)) as RECK_DAY,A.SALE_AMT,A.SALE_RTL,A.TIME_STAMP '+
       ' from RCK_GOODS_DAYS A,PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+
       ' and A.SHOP_ID='''+SHOP_ID+''' and B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and A.TIME_STAMP>'+MaxStamp+' order by A.TIME_STAMP) tp '+
       ' fetch first 20 rows only ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入日台帐临时表数据出错！');
    TLogRunInfo.LogWrite(' '+#13+'日台帐（SendDayReck）第'+InttoStr(RunTimes)+'次插入临时表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
    if iRet=0 then Break; //若插入没有记录，退出循环

    //第二步、更新商品计量单位换算管理单位换算值
    Str:='update session.INF_RECKDAY A set A.UNIT_CALC=(select ('+GetDefaultUnitCalc+') as UNIT_CALC from PUB_GOODSINFO B where A.GODS_ID=B.GODS_ID) where exists(select 1 from PUB_GOODSINFO B where A.GODS_ID=B.GODS_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新商品计量单位换算管理单位换算值出错！');
    //更新换算后数量值:
    if PlugIntf.ExecSQL(PChar('update session.INF_RECKDAY set QTY_ORD=(QTY_ORD*1.0)/UNIT_CALC '),iRet)<>0 then Raise Exception.Create('更新商品计量关系出错了！');
 
    //第三步: 每一次执行作为一个事务提交
    UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from session.INF_RECKDAY ');
    TLogRunInfo.LogWrite('日台帐（SendDayReck）第'+InttoStr(RunTimes)+'次上报最大时间戳:'+UpMaxStamp,'RimOrderDownPlugIn.dll');
    try
      PlugIntf.BeginTrans;
      //1、删除已上报历史记录表头:
      Str:='delete from RIM_RETAIL_CO_LINE A where exists(select B.CO_NUM from RIM_RETAIL_CO B,session.INF_RECKDAY C '+
             ' where B.COM_ID=C.COM_ID and B.CUST_ID=C.CUST_ID and B.PUH_DATE=C.RECK_DAY and B.COM_ID='''+ORGAN_ID+'''and B.TERM_ID='''+SHOP_ID+''' and B.CUST_ID='''+CustID+''' and A.CO_NUM=B.CO_NUM)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除已上报日销售历史记录表头出错！');

      //2、删除已上报历史记录表体:
      Str:='delete from RIM_RETAIL_CO A where exists(select 1 from session.INF_RECKDAY B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.PUH_DATE=B.RECK_DAY) and A.COM_ID='''+ORGAN_ID+''' and A.TERM_ID='''+SHOP_ID+''' and A.CUST_ID='''+CustID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除已上报日销售历史记录表体出错！');

      //3、插入日销售主表数据[RIM_RETAIL_CO]:
      Str:='select COM_ID,CUST_ID,SHOP_ID,RECK_DAY,(RECK_DAY || ''_'' || CUST_ID ||''_'' || SHOP_ID) as CO_NUM,sum(QTY_ORD) as QTY_SUM,sum(AMT) as AMT_SUM from session.INF_RECKDAY group by COM_ID,CUST_ID,SHOP_ID,RECK_DAY';
      Str:='insert into RIM_RETAIL_CO(CO_NUM,CUST_ID,COM_ID,QTY_SUM,AMT_SUM,TERM_ID,PUH_DATE,STATUS,UPD_DATE,UPD_TIME) '+
           'select CO_NUM,CUST_ID,COM_ID,QTY_SUM,AMT_SUM,trim(char(TENANT_ID)) as TERM_ID,RECK_DAY,''01'' as STATUS,'''+FormatDatetime('YYYYMMDD',Date())+''','''+TimetoStr(time())+''' from ('+Str+') as tp order by RECK_DAY ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入日销售表头[RIM_RETAIL_CO]出错(SQL:'+Str+')！');

      //4、插入日销售明细表数据[RIM_RETAIL_CO_LINE]:
      Str:='insert into RIM_RETAIL_CO_LINE(CO_NUM,ITEM_ID,QTY_ORD,AMT) select (RECK_DAY || ''_'' || CUST_ID ||''_'' || SHOP_ID) as CO_NUM,ITEM_ID,QTY_ORD,AMT from session.INF_RECKDAY order by RECK_DAY ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入日销售表体[RIM_RETAIL_CO_LINE]出错(SQL:'+Str+')！');

      //5、更新上报时间戳:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''10'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新上报时间戳出错！');
      //提交事务
      PlugIntf.CommitTrans;
      TLogRunInfo.LogWrite('日台帐（SendDayReck）第'+InttoStr(RunTimes)+'次上报执行成功！','RimOrderDownPlugIn.dll'); 
      //执行成功写日志:
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'10','上报日销售成功！','01');
    except
      on E:Exception do
      begin
        PlugIntf.RollbackTrans;
        sleep(1);
        WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'10','上报日销售错误！','02'); //写日志
        TLogRunInfo.LogWrite('上报日销售错误：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码
        Raise Exception.Create(E.Message);
      end;
    end; //try .. except end;
  end;  //循环: while True do
end;
       
//////2011.04.15 AM上报零售户库 (每天上报一次)不需要上报时间戳
function SendCustStorage(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE:string):boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  Str: string;
begin
  result := false;
  // MaxStamp:=GetMaxNUM(PlugIntf,'11',SHOP_ID,ORGAN_ID,CustID); //返回月台帐最大时间戳

  //创建零售户库存帐临时[INF_CUST_STORAGE]:
  Str:=
    'DECLARE GLOBAL TEMPORARY TABLE session.INF_CUST_STORAGE('+
         ' TENANT_ID INTEGER NOT NULL,'+     //R3企业ID
         ' SHOP_ID VARCHAR(20) NOT NULL,'+   //R3门店ID
         ' COM_ID VARCHAR(30) NOT NULL,'+    //RIM烟草公司ID
         ' CUST_ID VARCHAR(30) NOT NULL,'+   //RIM零售户ID
         ' ITEM_ID VARCHAR(30) NOT NULL,'+   //RIM商品ID
         ' GODS_ID CHAR(36) NOT NULL,'+      //R3商品ID
         ' QTY DECIMAL (18,6),'+              //库存数量
         ' UPD_DATE VARCHAR(8) NOT NULL,'+   //上报日期
         ' UPD_TIME VARCHAR(8) NOT NULL,'+   //更新日期
         ' TIME_STAMP bigint NOT NULL'+      //时间戳
         ')ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建日零售户库存帐临时[INF_CUST_STORAGE]错误！');
  iRet:=0;

  //第一步: 插入临时表:
  Str:='Select TENANT_ID,SHOP_ID,GODS_ID,sum(AMOUNT)as AMOUNT from STO_STORAGE where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and COMM not in (''02'',''12'') group by TENANT_ID,SHOP_ID,GODS_ID'; //库存表
  Str:='insert into session.INF_CUST_STORAGE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,QTY,UPD_DATE,UPD_TIME) '+
       ' select A.TENANT_ID,A.SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CustID,C.SECOND_ID,A.GODS_ID,(A.AMOUNT/('+GetDefaultUnitCalc+'))as QRY,'''+FormatDatetime('YYYYMMDD',Date())+''' as UPD_DATE,'''+TimetoStr(time())+''' as UPD_TIME  '+
       ' from ('+Str+')A,PUB_GOODSINFO B,PUB_GOODS_RELATION C '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID=C.TENANT_ID and B.GODS_ID=C.GODS_ID and A.TENANT_ID='+TENANT_ID+' and C.RELATION_ID='+InttoStr(NT_RELATION_ID)+'  ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('库存插入临时表出错！（SQL='+Str+'）');
  TLogRunInfo.LogWrite(' '+#13+'零售户库存（SendCustStorage）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');

  //第二步、处理中间表[事务处理]
  try
    PlugIntf.BeginTrans;  
    //1、先删除已上报数据:
    Str:='delete from RIM_CUST_ITEM_SWHSE where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TERM_ID='''+SHOP_ID+''' ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then Raise Exception.Create('删除表（RIM_CUST_ITEM_SWHSE）历史数表出错！(SQl='+Str+')');

    //2、从中间表插入插入 [RIM_CUST_ITEM_SWHSE]
    Str:='insert into RIM_CUST_ITEM_SWHSE(CUST_ID,ITEM_ID,COM_ID,TERM_ID,QTY,DATE1,TIME1,IS_MRB) '+
         'select CUST_ID,ITEM_ID,COM_ID,trim(char(TENANT_ID)) as TERM_ID,QTY,UPD_DATE,UPD_TIME,''0'' from session.INF_CUST_STORAGE ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then Raise Exception.Create('插入（RIM_CUST_ITEM_SWHSE）记录出错！（SQL='+Str+'）');

    //3、先更新当前当天的中间库存中间表：[RIM_CUST_ITEM_SWHSE]:
    str:=' update RIM_CUST_ITEM_WHSE '+
         '  set QTY=coalesce((select sum(QTY) from RIM_CUST_ITEM_SWHSE A where RIM_CUST_ITEM_WHSE.COM_ID=A.COM_ID and RIM_CUST_ITEM_WHSE.CUST_ID=A.CUST_ID and RIM_CUST_ITEM_WHSE.ITEM_ID=A.ITEM_ID),0) '+
         ' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then Raise Exception.Create('更新（RIM_CUST_ITEM_SWHSE）出错！（SQL='+Str+'）');

    //4、没有更新到记录插入中间表：[RIM_CUST_ITEM_WHSE]:
    str:='insert into RIM_CUST_ITEM_WHSE(COM_ID,CUST_ID,ITEM_ID,QTY) '+
         ' select COM_ID,CUST_ID,ITEM_ID,sum(QTY) from RIM_CUST_ITEM_SWHSE A where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and '+
         ' not Exists(select COM_ID from RIM_CUST_ITEM_WHSE where COM_ID=A.COM_ID and CUST_ID=A.CUST_ID and ITEM_ID=A.ITEM_ID) '+
         ' group by COM_ID,CUST_ID,ITEM_ID ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then Raise Exception.Create('插入（RIM_CUST_ITEM_SWHSE）新记录出错！（SQL='+Str+'）');

    PlugIntf.CommitTrans;
    TLogRunInfo.LogWrite('零售户库存（SendCustStorage）上报执行成功！','RimOrderDownPlugIn.dll');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'11','上报零售户库错误！','02');  //写日志
      TLogRunInfo.LogWrite('上报零售户库错误：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//////上报POS零售单 (type='01')
function SendSalesDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  SaleID,        //销售单ID
  CUST_CODE,     //会员号
  Str: string;
  DetailTab, GoodTab: string; //销售明细表、商品表
  RsINF: TZQuery;     //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'01',SHOP_ID,ORGAN_ID,CustID); //返回月台帐最大时间戳
  TLogRunInfo.LogWrite(' '+#13+'POS零售单（SendSalesDetail）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');  

  //第一步: 创建零售单（POS）临时[INF_POS_SALE]:
  Str:=
    'DECLARE GLOBAL TEMPORARY TABLE session.INF_POS_SALE( '+
         'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
         'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
         'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
         'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
         'SALES_ID CHAR(36) NOT NULL,'+        //RIM零售销售单ID
         'SALE_DATE CHAR (8) NOT NULL,'+      //RIM零售销售单日期
         'CUST_CODE varchar (20),'+  //会员号
         'TIME_STAMP bigint NOT NULL'+        //时间戳
         ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建零售单（POS）临时表[INF_POS_SALE]错误！');

  //第二步、插入中间表
  Str:='select SALES_ID,SALES_DATE,TIME_STAMP,IC_CARDNO from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=4 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  str:='insert into session.INF_POS_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,A.SALES_ID,trim(char(A.SALES_DATE)),B.CUST_CODE,A.TIME_STAMP from '+
       ' ('+str+') as A left outer join PUB_CUSTOMER B on A.IC_CARDNO=B.CUST_ID ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入零售单临时[INF_POS_SALE]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('POS零售单（SendSalesDetail）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    OpenData(PlugIntf, RsINF, 'select SALES_ID,CUST_CODE,TIME_STAMP from session.INF_POS_SALE order by TIME_STAMP');
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //若为空数据退出 

    //第三步: 循环分批处理：每次执行1单POS销售单]
    RsINF.First;
    while not RsINF.Eof do
    begin
      SaleID:=trim(RsINF.fieldbyName('SALES_ID').AsString);      //销售单据号
      CUST_CODE:=trim(RsINF.fieldbyname('CUST_CODE').AsString);  //会员号
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //当前最大时间戳

      //开始插入处理:
      PlugIntf.BeginTrans;
      try
        //0、零售单不能修改，不需重报：
        //1、插入零售表头:                                                                       //R3_NUM, -->SALES_ID,
        Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
           ' select SALES_ID,'''','''','''+CustID+''' as CUST_ID,trim(char(TENANT_ID)) as TERM_ID,'''+ORGAN_ID+''' as COM_ID,coalesce(INTEGRAL,0),trim(char(SALES_DATE)),'''+CUST_CODE+''' as CUST_CODE,trim(char(SALES_DATE)) as SALES_DATE,'+
           '(case when length(CREA_DATE)>12 then substr(CREA_DATE,12,length(CREA_DATE)-12) else ''00:00:00'' end) as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',right(SHOP_ID,4) '+
           ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_ID='''+SaleID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入POS零售单表头[RIM_RETAIL_INFO]错误！（SQL='+str+'）');
        //2、插入零售表体:
        DetailTab:='select S.*,M.UNIT_NAME from SAL_SALESDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.SALES_ID='''+SaleID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
        Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE,TREND_ID)'+
             ' select A.SALES_ID,row_number()over() as LINE_NUM,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
             ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''','''+SHOP_ID+''' as TREND_ID '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入POS零售单表体[RIM_RETAIL_DETAIL]错误！（SQL='+str+'）');

        //3、更新上报时间戳:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''01'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新上报时间戳出错！');
        //提交事务
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'01','上报POS零售单出错！','02');  //写日志
          TLogRunInfo.LogWrite('上报POS零售单错误：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'01','上报POS零售单成功！','01');
    TLogRunInfo.LogWrite('POS零售单（SendSalesDetail）本次上报执行成功！','RimOrderDownPlugIn.dll');
  finally
    RsINF.Free; 
  end;
end;

////上报销售单（批发单）数据 (type='02')
function SendSaleBatchDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  SaleID,        //销售单ID
  Str: string;
  DetailTab, GoodTab: string; //销售明细表、商品表
  RsINF: TZQuery;     //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'02',SHOP_ID,ORGAN_ID,CustID); 
  TLogRunInfo.LogWrite(' '+#13+'销售单（SendSaleBatchDetail）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');  

  //第一步: 创建销售单（批发）临时[INF_SALE]:
  Str:=
    'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
         'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
         'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
         'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
         'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
         'SALES_ID CHAR(36) NOT NULL,'+       //RIM销售单ID
         'SALE_DATE CHAR (8) NOT NULL,'+      //RIM销售单日期
         'TIME_STAMP bigint NOT NULL'+        //时间戳
         ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售单临时[INF_SALE]错误！');

  //第二步、插入中间(临时)表
  str:='insert into session.INF_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,trim(char(SALES_DATE)),TIME_STAMP from '+
       ' SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单（批发单）[INF_SALE]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('销售单（SendSaleBatchDetail）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    OpenData(PlugIntf, RsINF, 'select SALES_ID,TIME_STAMP from session.INF_SALE order by TIME_STAMP');
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //若为空数据退出

    //第三步: 循环分批处理：每次执行1单销售单]
    RsINF.First;
    while not RsINF.Eof do
    begin
      SaleID:=trim(RsINF.fieldbyName('SALES_ID').AsString);     //销售单据号
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //当前最大时间戳

      //开始插入处理:
      PlugIntf.BeginTrans;
      try
        //1、上报前删除历史单据：
        DeleteExistsReportedBill(PlugIntf,'RIM_RETAIL_INFO','RIM_RETAIL_DETAIL','RETAIL_NUM',SaleID);
        
        //2、插入销售表头:                                                                   //R3_NUM, ---> SALES_ID,
        Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
           ' select SALES_ID,'' '','' '','''+CustID+''' as CUST_ID,trim(char(TENANT_ID)) as TERM_ID,'''+ORGAN_ID+''' as COM_ID,0,trim(char(SALES_DATE)),'' '',trim(char(SALES_DATE)),'' '' as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',right(SHOP_ID,4) '+
           ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_ID='''+SaleID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表头[RIM_RETAIL_INFO]错误！（SQL='+str+'）');

        //3、插入销售表体:
        DetailTab:='select S.*,M.UNIT_NAME from SAL_SALESDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.SALES_ID='''+SaleID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
        Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
             ' select A.SALES_ID,row_number()over() as LINE_NUM,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
             ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单批发表体[RIM_RETAIL_DETAIL]错误！（SQL='+str+'）');

        //4、更新上报时间戳:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''02'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售单上报时间戳出错！');
        //提交事务
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'02','上报销售单（批发）！','02');  //写日志
          TLogRunInfo.LogWrite('上报销售单（批发）错误：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'02','上报批发销售单成功！','01');
    TLogRunInfo.LogWrite('销售单（SendSaleBatchDetail）本次上报执行成功！','RimOrderDownPlugIn.dll');
  finally
    RsINF.Free; 
  end;
end;

//销售退货单  (type='03')
function SendSaleRetDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  SaleID,        //销售单ID
  Str: string;
  DetailTab, GoodTab: string; //销售明细表、商品表
  RsINF: TZQuery;     //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'02',SHOP_ID,ORGAN_ID,CustID);  
  TLogRunInfo.LogWrite(' '+#13+'销售退货单（SendSaleRetDetail）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');
  
  //第一步: 创建销售退货单（）临时[INF_SALE]:
  Str:=
    'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
         'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
         'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
         'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
         'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
         'SALES_ID CHAR(36) NOT NULL,'+        //RIM销售单ID
         'SALE_DATE CHAR (8) NOT NULL,'+      //RIM销售单日期
         'TIME_STAMP bigint NOT NULL'+        //时间戳
         ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售退货单临时表[INF_SALE]错误！');

  //第二步、插入中间(临时)表     
  str:='insert into session.INF_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,trim(char(SALES_DATE)),TIME_STAMP from '+
       ' SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售退货单临时表[INF_SALE]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('销售退货单（SendSaleRetDetail）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    OpenData(PlugIntf, RsINF, 'select SALES_ID,TIME_STAMP from session.INF_SALE order by TIME_STAMP');
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //若为空数据退出

    //第三步: 循环分批处理：每次执行1单POS销售单]
    RsINF.First;
    while not RsINF.Eof do
    begin
      SaleID:=trim(RsINF.fieldbyName('SALES_ID').AsString);       //销售单据号
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //当前最大时间戳

      //开始插入处理:
      PlugIntf.BeginTrans;
      try
        //1、上报前删除历史单据：
        DeleteExistsReportedBill(PlugIntf,'RIM_RETAIL_INFO','RIM_RETAIL_DETAIL','RETAIL_NUM',SaleID);
      
        //2、插入零售表头:                                                                      //R3_NUM,---> SALES_ID,
        Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
           ' select SALES_ID,'' '','' '','''+CustID+''' as CUST_ID,trim(char(TENANT_ID))as TERM_ID,'''+ORGAN_ID+''' as COM_ID,0,trim(char(SALES_DATE)),'' '',trim(char(SALES_DATE)),'' '' as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',right(SHOP_ID,4) '+
           ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_ID='''+SaleID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售退货单表头[RIM_RETAIL_INFO]错误！（SQL='+str+'）');

        //3、插入零售表体:
        DetailTab:='select S.*,M.UNIT_NAME from SAL_SALESDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.SALES_ID='''+SaleID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
        Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
             ' select A.SALES_ID,row_number()over() as LINE_NUM,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID, '+
             ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售退货单表体[RIM_RETAIL_DETAIL]错误！（SQL='+str+'）');

        //3、更新上报时间戳:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''03'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新销售退货单上报时间戳出错！');
        //提交事务
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'03','上报销售退货单！','02');  //写日志
          TLogRunInfo.LogWrite('上报销售退货单错误：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码
          Raise Exception.Create(E.Message); 
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'03','上报销售退货单成功！','01');
    TLogRunInfo.LogWrite('销售退货单（SendSaleRetDetail）本次上报执行成功！','RimOrderDownPlugIn.dll');
  finally
    RsINF.Free; 
  end;
end;

//上报调拨单 (type='04')
{说明: 新R3设计时把调入当作为入库单，存储在入库表，调出单作为出库单，存储在销售单;同步时分两步处理 }
function SenddbInDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
  MaxStamp,      //已上报最大时间戳
  UpMaxStamp,    //本次上报最大时间戳
  DBID,          //RIM调拨(入)单ID(在R3调拨单 + _1)
  R3_DBID,       //R3调拨(入)单ID
  Str: string;
  DetailTab, GoodTab: string; //调拨明细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'04',SHOP_ID,ORGAN_ID,CustID); 
  TLogRunInfo.LogWrite(' '+#13+'调入单（SenddbInDetail）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');

  //第一步: 创建销售单（批发）临时[INF_SALE]:
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

  //第二步、插入中间(临时)表
  str:='insert into session.INF_DB(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,DB_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID || ''_1'' as STOCK_ID,TIME_STAMP from '+
       ' STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨(入)单[INF_DB]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('调入单（SenddbInDetail）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    OpenData(PlugIntf, RsINF, 'select DB_ID,TIME_STAMP from session.INF_DB order by TIME_STAMP');
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

        //2、插入调拨（入）单表头:                                        //R3_NUM,--->STOCK_ID || ''_1'' as STOCK_ID,
        Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
           ' select STOCK_ID || ''_1'' as STOCK_ID,'''+CustID+''' as CUST_ID,''2'' as vTYPE,'''+ORGAN_ID+''' as COM_ID,trim(char(TENANT_ID))as TERM_ID,''02'',trim(char(STOCK_DATE)),CREA_USER,trim(char(STOCK_DATE)),'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_ID='''+R3_DBID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调播单批发表头[RIM_CUST_TRN]错误！（SQL='+str+'）');

        //3、插入零售表体:
        DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.STOCK_ID='''+R3_DBID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
             ' select A.STOCK_ID || ''_1'' as STOCK_ID,row_number()over() as LINE_NUM,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
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
          TLogRunInfo.LogWrite('上报调拨（入）单错误：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码
          Raise Exception.Create(E.Message); 
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'04','上报调拨（出）单成功！','01');
    TLogRunInfo.LogWrite('调入单（SenddbInDetail）本次上报执行成功！','RimOrderDownPlugIn.dll');
  finally
    RsINF.Free;
  end;
end;

//上报调拨单 (type='12')  单据号码=SALES_ID + _2
{说明: 新R3设计时把调入当作为入库单，存储在入库表，调出单作为出库单，存储在销售单;同步时分两步处理 }
function SenddbOutDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer; //返回ExeSQL影响多少行记录
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
  TLogRunInfo.LogWrite(' '+#13+'调出单（SenddbOutDetail）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');

  //第一步: 创建销售单（批发）临时[INF_SALE]:
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

  //第二步、插入中间(临时)表
  str:='insert into session.INF_DB(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,DB_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID || ''_2'' as SALES_ID,TIME_STAMP '+
       ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入调拨(出)单[INF_DB]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('调出单（SenddbOutDetail）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    OpenData(PlugIntf, RsINF, 'select DB_ID,TIME_STAMP from session.INF_DB order by TIME_STAMP');
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
             ' select A.SALES_ID || ''_2'' as SALES_ID,row_number()over() as LINE_NUM,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
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
          TLogRunInfo.LogWrite('上报调拨（出）单出错：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码
          Raise Exception.Create(E.Message); 
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'12','上报调拨（出）单成功！','01');
    TLogRunInfo.LogWrite('调出单（SenddbOutDetail）本次上报执行成功！','RimOrderDownPlugIn.dll');
  finally
    RsINF.Free;
  end;
end; 

//上报入库单 [type='05']
function SendStockDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer;  //返回ExeSQL影响多少行记录
  MaxStamp,       //已上报最大时间戳
  UpMaxStamp,     //本次上报最大时间戳
  StockID,        //出库单号
  Str: string;
  DetailTab, GoodTab: string; //入库单细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'05',SHOP_ID,ORGAN_ID,CustID);
  TLogRunInfo.LogWrite(' '+#13+'入库单开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');

  //第一步: 创建销售单（批发）临时[INF_STOCK]:
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

  //第二步、插入中间(临时)表
  str:='insert into session.INF_STOCK(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,STOCK_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,TIME_STAMP '+
       ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库单中间表[INF_STOCK]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('入库单（SendStockDetail）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    OpenData(PlugIntf, RsINF, 'select STOCK_ID,TIME_STAMP from session.INF_STOCK order by TIME_STAMP');
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
        TLogRunInfo.LogWrite('插入进货入库表头：'+Str,'RimOrderDownPlugIn.dll');
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库表头[RIM_VOUCHER]错误！');

        //3、插入零售表体:
        DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.STOCK_ID='''+StockID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
             ' select A.STOCK_ID,row_number()over() as LINE_NUM,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        TLogRunInfo.LogWrite('插入进货入库表体：'+Str,'RimOrderDownPlugIn.dll');
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
          TLogRunInfo.LogWrite('上报进货入库单！','RimOrderDownPlugIn.dll');     //写错误日志代码
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'05','上报进货入库单成功！','01');
    TLogRunInfo.LogWrite('入库单上报执行成功！','RimOrderDownPlugIn.dll');
  finally
    RsINF.Free;
  end;
end;

//上报入库退货 (type='06')
function SendStkRetuDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer;  //返回ExeSQL影响多少行记录
  MaxStamp,       //已上报最大时间戳
  UpMaxStamp,     //本次上报最大时间戳
  StockID,        //出库单号
  Str: string;
  DetailTab, GoodTab: string; //入库单细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'05',SHOP_ID,ORGAN_ID,CustID); 
  TLogRunInfo.LogWrite(' '+#13+'入库单（SendStkRetuDetail）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');

  //第一步: 创建销售单（批发）临时[INF_STOCK]:
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

  //第二步、插入中间(临时)表
  str:='insert into session.INF_STOCK(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,STOCK_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,TIME_STAMP '+
       ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售单（批发）中间表[INF_STOCK]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('入库退出单（SendStkRetuDetail）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    OpenData(PlugIntf, RsINF, 'select STOCK_ID,TIME_STAMP from session.INF_STOCK order by TIME_STAMP');
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
             ' select A.STOCK_ID,row_number()over() as LINE_NUM,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
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
          TLogRunInfo.LogWrite('上报采购退货单：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码           
          Raise Exception.Create(E.Message);   
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'06','上报采购退货单成功！','01');
    TLogRunInfo.LogWrite('入库退货单（SendStkRetuDetail）本次上报执行成功！','RimOrderDownPlugIn.dll');
  finally
    RsINF.Free;
  end;
end;

//上报调整单  (type='07')
function SendChangeDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer;  //返回ExeSQL影响多少行记录
  MaxStamp,       //已上报最大时间戳
  UpMaxStamp,     //本次上报最大时间戳
  ChangeID,       //调整单ID
  Str: string;
  DetailTab, GoodTab: string; //入库单细表、商品表
  RsINF: TZQuery;             //中间表循环使用
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'07',SHOP_ID,ORGAN_ID,CustID); 
  TLogRunInfo.LogWrite(' '+#13+'调整单（SendChangeDetail）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');

  //第一步: 创建销售单（批发）临时[INF_CHANGE]:
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

  //第二步、插入中间(临时)表
  str:='insert into session.INF_CHANGE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,CHANGE_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,CHANGE_ID,TIME_STAMP '+
       ' from STO_CHANGEORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入〖调整单〗中间表[INF_CHANGE]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('调整单（SendChangeDetail）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  try
    RsINF:=TZQuery.Create(nil);
    OpenData(PlugIntf, RsINF, 'select CHANGE_ID,TIME_STAMP from session.INF_CHANGE order by TIME_STAMP');
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
             ' select A.CHANGE_ID,row_number()over() as LINE_NUM,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''支'' then ''01'' when A.UNIT_NAME=''条'' then ''03'' when A.UNIT_NAME=''箱'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
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
          TLogRunInfo.LogWrite('上报调整单：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码           
          Raise Exception.Create(E.Message);   
        end;
      end;
      RsINF.Next;
    end;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'07','上报〖调整单〗成功！','01');
    TLogRunInfo.LogWrite('调整单（SendChangeDetail）本次上报执行成功！','RimOrderDownPlugIn.dll');    
  finally
    RsINF.Free;
  end;
end;


//组合（捆绑）单 (type='08')
function SendCombDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
const BillName='组合（捆绑）单';
begin

end;

//销售成本(type='09')
function SendCostPrice(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string): boolean;
var
  iRet: integer;  //返回ExeSQL影响多少行记录
  MaxStamp,       //已上报最大时间戳
  UpMaxStamp,     //本次上报最大时间戳
  Str: string;
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'09',SHOP_ID,ORGAN_ID,CustID);
  TLogRunInfo.LogWrite(' '+#13+'销售成本价（SendCostPrice）开始上报，上次上报时间戳:'+MaxStamp,'RimOrderDownPlugIn.dll');

  //第一步: 创建销售单（批发）临时[INF_STOCK]:
  Str:=
    'DECLARE GLOBAL TEMPORARY TABLE session.INF_COST( '+
         'TENANT_ID INTEGER NOT NULL,'+       //R3企业ID
         'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3门店ID
         'COM_ID VARCHAR(30) NOT NULL,'+      //RIM烟草公司ID
         'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM零售户ID
         'ITEM_ID VARCHAR(30) NOT NULL,'+     //RIM商品ID
         'GODS_ID CHAR(36) NOT NULL,'+        //R3商品ID
         'COST_PRICE DECIMAL (18,6),'+         //销售成本价
         'UNIT_CALC DECIMAL (18,6),'+          //商品计量单位换算管理单位换算值         
         'RECK_DATE CHAR(8) NOT NULL,'+       //台账表日期
         'TIME_STAMP bigint NOT NULL'+        //台账表时间戳
         ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建销售成本价临时表[INF_STOCK]错误！');

  //第二步、插入中间(临时)表
  str:='insert into session.INF_COST(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,RECK_DATE,ITEM_ID,GODS_ID,COST_PRICE,UNIT_CALC,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,trim(char(A.CREA_DATE)) as RECK_DAY,B.SECOND_ID,A.GODS_ID,A.COST_PRICE,1.0,A.TIME_STAMP '+
       ' from RCK_GOODS_DAYS A,PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+
       ' and A.SHOP_ID='''+SHOP_ID+''' and B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and A.TIME_STAMP>'+MaxStamp+
       ' order by A.TIME_STAMP ';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入进货入库单中间表[INF_STOCK]错误！（SQL='+str+'）');
  TLogRunInfo.LogWrite('销售成本价（SendCostPrice）插入中间表记录数:'+inttoStr(iRet)+'笔  InsertSQL='+Str,'RimOrderDownPlugIn.dll');
  if iRet=0 then Exit; //若插入没有记录，退出

  //第二步、处理RIM的计量单位成本价
  Str:='update session.INF_COST A set A.UNIT_CALC=(select ('+GetDefaultUnitCalc+') as UNIT_CALC from PUB_GOODSINFO B where B.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID) where exists(select 1 from PUB_GOODSINFO B where A.GODS_ID=B.GODS_ID)';
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新计量单位换算管理单位出错！');
  //更新换算后数量值:
  if PlugIntf.ExecSQL(PChar('update session.INF_COST set COST_PRICE=(COST_PRICE*1.0)/UNIT_CALC '),iRet)<>0 then Raise Exception.Create('更新商品成本价计算出错了！');

  //第三步、更新商品计量单位换算管理单位换算值
  UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from session.INF_COST '); //更新最大时间戳

  //第四步: 批量处理（事务内处理）
  PlugIntf.BeginTrans; //开始事务:
  try
    //1、更新历史单据：
    Str:='update RIM_CUST_ITEM_COST A '+
         ' set UNIT_COST=(select B.COST_PRICE from session.INF_COST B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.TERM_ID=trim(char(B.TENANT_ID)) and A.ITEM_ID=B.ITEM_ID and A.DATE1=B.RECK_DATE) '+
         ' where exists(select 1 from session.INF_COST B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.TERM_ID=trim(char(B.TENANT_ID)) and A.ITEM_ID=B.ITEM_ID and A.DATE1=B.RECK_DATE) ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新商品成本价出错了！');

    //2、插入新记录:
    Str:='insert into RIM_CUST_ITEM_COST(COM_ID,CUST_ID,TERM_ID,ITEM_ID,DATE1,UNIT_COST)'+
       ' select COM_ID,CUST_ID,trim(char(TENANT_ID)) as TERM_ID,ITEM_ID,RECK_DATE,COST_PRICE from session.INF_COST A '+
       ' where not exists(select 1 from RIM_CUST_ITEM_COST B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.SHOP_ID=B.TERM_ID and A.RECK_DATE=B.DATE1 and A.ITEM_ID=B.ITEM_ID ) ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入销售成本价错误！（SQL='+str+'）');

    //3、更新上报时间戳:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''05'' and TERM_ID='''+SHOP_ID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新进货入库单上报时间戳出错！');
    //提交事务
    PlugIntf.CommitTrans;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'09','上报进货入库单成功！','01');
    TLogRunInfo.LogWrite('销售成本价（SendCostPrice）本次上报执行成功！','RimOrderDownPlugIn.dll');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'09','上报销售成本价出错！','02');  //写日志
      TLogRunInfo.LogWrite('上报销售成本价出错：错误信息='+E.Message,'RimOrderDownPlugIn.dll');     //写错误日志代码 
      Raise Exception.Create(E.Message);
    end;
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

{
  '(select RELATI_ID from CA_RELATIONS where TENANT_ID='+TenantID+' and RELATION_ID=1000006)'
  '(select '+TenantID+' as TENANT_ID from sysibm.sysdummy1 union all select A.RELATI_ID as TENANT_ID from CA_RELATIONS A,(select LEVEL_ID from CA_RELATIONS where TENANT_ID='+TenantID+')B where left(A.LEVEL_ID,length(B.LEVEL_ID))=B.LEVEL_ID)R '+
}

procedure CallSync(PlugIntf: IPlugIn; TENANT_ID: string);
var
  Rs: TZQuery;
  Str: string; //企业表视图
  OrganID,       //RIM烟草公司ID
  LICENSE_CODE,  //RIM零售户许可证号
  CustID,        //RIM零售户ID
  TenantID,      //R3上报企业ID
  TenName,       //R3上报企业Name
  ShopID,        //R3上报门店ID
  ShopName: string; //R3上报门店名称;
begin
  Rs := TZQuery.Create(nil);
  try
    //根据R3传入烟草公司企业ID(TENANT_ID):
    OrganID:=GetValue(PlugIntf,'select A.ORGAN_ID from PUB_ORGAN A,CA_TENANT B where B.LOGIN_NAME=A.ORGAN_CODE and B.TENANT_ID='+TENANT_ID+' ');
    TLogRunInfo.LogWrite('R3上报数据Rim库:（传入R3企业ID：'+TENANT_ID+'，读取RIM烟草公司ID:'+OrganID+'）','RimReportedPlugIn.dll');
    if OrganID='' then Raise Exception.Create('R3传入企业ID（'+TENANT_ID+'）在RIM中没找到对应的ORGAN_ID值...');

    //供应链关系表[返回传入企业所有下级企业]:
    Str:='select T.TENANT_ID,T.TENANT_NAME from CA_TENANT T,CA_RELATIONS R where T.TENANT_ID=R.RELATI_ID and T.COMM not in (''02'',''12'') and R.TENANT_ID='+TENANT_ID+' and R.RELATION_ID=1000006';
    //返回门店与企业关联: (企业名称,门店ID,门店名称,门店许可证号)
    Str:='select TE.TENANT_ID,TE.TENANT_NAME,SH.SHOP_ID,SH.SHOP_NAME,SH.LICENSE_CODE from CA_SHOP_INFO SH,('+Str+') TE where SH.TENANT_ID=TE.TENANT_ID order by TE.TENANT_ID,SH.SHOP_ID ';
    OpenData(PlugIntf, Rs, Str);
    TLogRunInfo.LogWrite(' '+#13+'R3上报读取所有上报门店:'+InttoStr(Rs.RecordCount)+'个）（SQL='+Str+'）','RimReportedPlugIn.dll');
    if (not Rs.Active) or (Rs.IsEmpty) then Raise Exception.Create(' 企业表没有对应到数据，不需上报！ ');

    //锁定数据库连接:
    DBLock(PlugIntf, true);

    //按门店ID排序循环上报
    Rs.First;
    while not Rs.Eof do
    begin
      CustID:='';
      try
        TenantID:=trim(Rs.Fields[0].AsString);      //R3企业ID (Field: TENANT_NAME)
        TenName:=trim(Rs.Fields[1].AsString);       //R3企业名称 (Field: TENANT_NAME)
        ShopID:=trim(Rs.Fields[2].AsString);        //R3门店ID (Field: SHOP_ID)
        ShopName:=trim(Rs.Fields[3].AsString);      //R3门店名称 (Field: SHOP_NAME)
        LICENSE_CODE:=trim(Rs.Fields[4].AsString);  //R3门店许可证号 (Field: LICENSE_CODE)
        //根据R3许可证号读取RIM的零售户ID:
        CustID:=GetValue(PlugIntf,'select CUST_ID from RM_CUST where COM_ID='''+OrganID+''' and LICENSE_CODE='''+LICENSE_CODE+'''');
        if CustID<>'' then
        begin
          TLogRunInfo.LogWrite('第'+inttoStr(Rs.RecNo)+'次执行上报，R3:（门店ID:'+ShopID+'名称：'+ShopName+'许可证号：'+LICENSE_CODE+'）;（RIM零售户ID:'+CustID+'）开始执行上报','RimReportedPlugIn.dll');
          //1、开始上报日台账 (type='00')
          SendDayReck(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);
          //2、开始上报月台账 (type='10')
          SendMonthReck(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);
          //3、开始上报销售   (type='01')
          SendSalesDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //4、开始上报销售批发 (type='02')
          SendSaleBatchDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //5、开始上报销售退货 (type='03')
          SendSaleRetDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //6、开始上报调拨（调入）: (type='04')
          SenddbInDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //7、开始上报调拨（调出）: (type='12')
          SenddbOutDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //8、开始上报入库:  (type='05')
          SendStockDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //9、开始上报采购退货: (type='06')
          SendStkRetuDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //10、开始上报调整:    (type='07')
          SendChangeDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //11、开始上报组合:   (type='08')  暂无使用
          //SendCombDetail(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);
          //12、开始上报成本:   (type='09')
          SendCostPrice(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          //13、开始上零售户库存: (type='11')
          SendCustStorage(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE);

          PlugIntf.WriteLogFile(Pchar('企业ID：'+TenantID+'在 '+GetTickTime+'完成第'+inttoStr(Rs.RecNo)+'次上报！'));
          TLogRunInfo.LogWrite('R3门店ID:'+ShopID+'名称：'+ShopName+'许可证号：'+LICENSE_CODE+'完成第'+inttoStr(Rs.RecNo)+'次执行上报！'+#13+#13+'  ','RimReportedPlugIn.dll');
        end else  // Raise Exception.Create(ShopName+'->'+OrganID+'在RIM中没找到对应的CUST_ID值...');
        begin
          TLogRunInfo.LogWrite('第'+inttoStr(Rs.RecNo)+'次执行上报，R3:（门店ID:'+ShopID+'名称：'+ShopName+'许可证号：'+LICENSE_CODE+'）没有找到（RIM的零售户ID），本门店无法上报，继续执行下一门店上报！','RimReportedPlugIn.dll');
          PlugIntf.WriteLogFile(Pchar('第'+inttoStr(Rs.RecNo)+'次执行，'+'门店ID:'+ShopID+'(名称：'+ShopName+') 的许可证号('+LICENSE_CODE+')没找到对应！'));
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'12','CallSync循环执行上报出错误了！','02'); //写日志
          Raise Exception.Create(E.Message); 
        end;
      end;
      Rs.Next;
    end;
  finally
    DBLock(PlugIntf, false); //解锁数据库连接:
    Rs.Free;
  end;
end;

end.
