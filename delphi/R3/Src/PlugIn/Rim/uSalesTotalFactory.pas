{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;

 ------------------------------------------------------------------------------}

unit uSalesTotalFactory;

interface

uses                 
  SysUtils,Classes,Windows,zDataSet,zBase,uPlugInUtil;   //ufnUtil,

procedure CallSaleReckSync(PlugIntf:IPlugIn; InParams: string);   //上报销售数据


implementation

{============================ 下面为上报RIM业务单据 [DB2\ORACLE] ==============================}

//////2011.04.14 PM上报日台账  (type='10')
function SendDayReck(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE,SALES_DATE:string; iDbType: integer):boolean;
var
  iRet: integer;   //返回ExeSQL影响多少行记录
  Session: string; //session前缀
  MaxStamp,        //已上报最大时间戳
  UpMaxStamp,      //本次上报最大时间戳
  Str,
  Short_ID,       //门店后四位代码
  CndTab,         //条件表
  SalesTab,       //销售视图
  vSALES_DATE     //销售日期[转成字符]
  : string; 
begin
  result := false;
  Short_ID:=Copy(SHOP_ID,Length(SHOP_ID)-3,4);
  MaxStamp:=GetMaxNUM(PlugIntf,'10',SHOP_ID,ORGAN_ID,CustID,UpMaxStamp); //返回日台账最大时间戳
  
  //创建日台帐临时[INF_RECKDAY]:
  case iDbType of
   1:
    begin
      Session:='';
      vSALES_DATE:='trim(char(M.CREA_DATE))';    //台账日期 转成 varchar
    end;
   4:
    begin
      Session:='session.';
      vSALES_DATE:='cast(M.CREA_DATE as varchar(8))';    //台账日期 转成 varchar
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALESUM( '+
             ' TENANT_ID INTEGER NOT NULL,'+     //R3企业ID
             ' SHOP_ID VARCHAR(20) NOT NULL,'+   //R3门店ID
             ' SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3门店ID后四位
             ' COM_ID VARCHAR(30) NOT NULL,'+    //RIM烟草公司ID
             ' CUST_ID VARCHAR(30) NOT NULL,'+   //RIM零售户ID
             ' ITEM_ID VARCHAR(30) NOT NULL,'+   //RIM商品ID
             ' GODS_ID CHAR(36) NOT NULL,'+      //R3商品ID
             ' SALES_DAY VARCHAR(8) NOT NULL,'+  //销售日期
             ' QTY_ORD DECIMAL (18,6),'+         //台账销售数量
             ' AMT DECIMAL (18,6),'+             //台账销售金额
             ' CO_NUM VARCHAR(30) NOT NULL, '+   //单据号[台账日期 + 零售户ID+ R3_门店ID后4位] 
             ' TIME_STAMP bigint NOT NULL'+      //时间戳
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('创建日销售临时表INF_SALESUM错误:'+PlugIntf.GetLastError);
    end;
  end;

  iRet:=0;
  //第一步: 大于时间戳的台帐插入临时表:
  //条件表: 根据传入条件及指定日期返回对应门店及日期需要上报条件:
  CndTab:='select TENANT_ID,SHOP_ID,SALES_DATE from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' ';
  if SALES_DATE='' then
    CndTab:=CndTab+' and TIME_STAMP>'+MaxStamp+' '
  else
    CndTab:=CndTab+' and ((TIME_STAMP>'+MaxStamp+')or(SALES_DATE='+SALES_DATE+'))'; //前台传入日期

  SalesTab:=
    'select M.TENANT_ID,M.SHOP_ID,S.GODS_ID,'+vSALES_DATE+' as SALES_DATE,sum(S.CALC_AMOUNT) as CALC_AMOUNT,sum(S.CALC_MONEY) as CALC_MONEY from SAL_SALESORDER M,SAL_SALESDATA S,('+CndTab+') C '+
    ' where M.TENANT_ID=S.TENANT_ID and M.SALES_ID=S.SALES_ID and M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and '+
    ' M.SALES_DATE=C.SALES_DATE and M.SALES_TYPE in (1,3,4) and M.COMM not in (''02'',''12'') and M.TENANT_ID='+TENANT_ID+' and M.SHOP_ID='''+SHOP_ID+''' '+
    ' group by M.TENANT_ID,M.SHOP_ID,M.SALES_DATE,S.GODS_ID';

  Str:='insert into '+Session+'INF_SALESUM(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,SALES_DATE,QTY_ORD,AMT,TIME_STAMP) '+
    'select A.TENANT_ID,A.SHOP_ID,'''+Short_ID+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,'+vSALES_DATE+' as SALES_DATE,'+
    ' (case when '+GetDefaultUnitCalc+'<>0 then A.CALC_AMOUNT/('+GetDefaultUnitCalc+') else A.AMOUNT end) as SALE_AMT,A.CALC_MONEY,('+vSALES_DATE+' || ''_'' || '''+CustID+''' ||''_'' || '''+Short_ID+''') as CO_NUM '+
    ' from ('+SalesTab+')A,VIW_GOODSINFO B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
    ' group by A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,'+vSALES_DATE+' ';

  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入日台帐临时表数据出错:'+PlugIntf.GetLastError);
  if iRet=0 then Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环

  //第三步: 每一次执行作为一个事务提交
  try
    PlugIntf.BeginTrans;
    //1、删除销售历史数据(先删除表体在删除表头):
    Str:='delete from RIM_RETAIL_CO_LINE A '+
         ' where exists(select B.CO_NUM from RIM_RETAIL_CO B,'+Session+'INF_SALESUM C '+
                      ' where B.COM_ID=C.COM_ID and B.CUST_ID=C.CUST_ID and B.PUH_DATE=C.RECK_DAY and B.COM_ID='''+ORGAN_ID+'''and B.TERM_ID='''+Short_ID+''' and B.CUST_ID='''+CustID+''' and A.CO_NUM=B.CO_NUM)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史日销售表体出错：'+PlugIntf.GetLastError);
    Str:='delete from RIM_RETAIL_CO A where exists(select 1 from '+Session+'INF_SALESUM B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.PUH_DATE=B.RECK_DAY) and A.COM_ID='''+ORGAN_ID+''' and A.TERM_ID='''+Short_ID+''' and A.CUST_ID='''+CustID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('删除历史日销售表头出错：'+PlugIntf.GetLastError);

    //2、插入日销售台账(先插表头在插入表体):
    Str:='insert into RIM_RETAIL_CO(CO_NUM,CUST_ID,COM_ID,TERM_ID,PUH_DATE,STATUS,UPD_DATE,UPD_TIME,QTY_SUM,AMT_SUM) '+
         'select CO_NUM,CUST_ID,COM_ID,SHORT_SHOP_ID,RECK_DAY,''01'' as STATUS,'''+FormatDatetime('YYYYMMDD',Date())+''','''+TimetoStr(time())+''',sum(QTY_ORD) as QTY_SUM,sum(AMT) as AMT_SUM '+
         ' from '+Session+'INF_SALESUM group by COM_ID,CUST_ID,SHORT_SHOP_ID,CO_NUM,RECK_DAY';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入日销售表头[RIM_RETAIL_CO]出错:'+PlugIntf.GetLastError);
    Str:='insert into RIM_RETAIL_CO_LINE(CO_NUM,ITEM_ID,QTY_ORD,AMT) '+
         'select CO_NUM,ITEM_ID,QTY_ORD,AMT from '+Session+'INF_SALESUM ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('插入日销售表体[RIM_RETAIL_CO_LINE]出错:'+PlugIntf.GetLastError);

    //3、更新上报时间戳:
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''10'' and TERM_ID='''+SHOP_ID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('更新上报时间戳出错:'+PlugIntf.GetLastError);

    PlugIntf.CommitTrans;  //提交事务
    result:=true;
    //执行成功写日志:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'10','上报日销售成功！','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'10','上报日销售错误！','02'); //写日志
      Raise Exception.Create(E.Message);
    end;
  end;  
end;

procedure CallSaleReckSync(PlugIntf:IPlugIn; InParams: string); //上报库存
var
  Str: string;       //企业表视图
  OrganID,           //RIM烟草公司ID
  LICENSE_CODE,      //RIM零售户许可证号
  CustID,            //RIM零售户ID
  TenantID,          //R3上报企业ID
  TenName,           //R3上报企业Name
  ShopID,            //R3上报门店ID
  ShopName: string;  //R3上报门店名称;
  SALES_DATE: string;  //前台传入的指定上报日期
  R3ShopList,Rs: TZQuery;
  vParam: TftParamList;
  IsFlag: Boolean;    //是否为零售户直接上报
  RunInfo: TRunInfo;  //运行日志
  DbType: integer;
begin
  SALES_DATE:='';
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
      if vParam.FindParam('SALES_DATE')<>nil then
        SALES_DATE:=vParam.FindParam('SALES_DATE').AsString;
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
          if SendDayReck(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE,SALES_DATE,DbType) then 
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















