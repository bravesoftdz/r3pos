{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;

 ------------------------------------------------------------------------------}

unit uDayJxcFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TSalesTotalSyncFactory=class(TRimSyncFactory)
  private
    //从Rim的零售户表同步参数[single_sale_limit、sale_limit、IS_CHG_PRI]
    function DownRimParamsToR3: Boolean;
    //上报日台帐
    function SendDaySaleTotal: integer;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;
 
implementation

{ TSalesTotalSyncFactory }

function TSalesTotalSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  ErrorFlag: Boolean;
begin
  result:=-1;
  PlugInID:='810';
  {------初始化参数------}
  PlugIntf:=GPlugIn;
  //1、返回数据库类型
  GetDBType;
  //2、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  GetSyncType;  //返回同步类型标记

  try
    DBLock(true);  //锁定数据库链接

    //2011.06.12 Add从Rim下载销售限价、限量定义参数值
    DownRimParamsToR3;

    BeginLogRun; {------开始运行日志------}
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
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString);  //R3门店许可证号 (Field: LICENSE_CODE)
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID);  //传入R3门店ID,返回RIM的烟草公司ComID,零售户CustID;

        //if RimParam.ComID='' then Raise Exception.Create('R3传入企业ID（'+RimParam.TenID+' - '+RimParam.TenName+'）在RIM中没找到对应的COM_ID值...');
        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          LogInfo.BeginLog(RimParam.ShopName); //开始日志
          //开始上报日进销存汇总：
          try
            iRet:=SendDaySaleTotal;
            LogInfo.AddBillMsg('日进销存汇总',iRet);
          except
            on E:Exception do
            begin
              LogInfo.AddBillMsg('日进销存汇总',-1);
              WriteRunErrorMsg(E.Message);
              if not ErrorFlag then ErrorFlag:=true;
            end;
          end;

          //写日志LogList
          WriteToLogList(true, ErrorFlag);
        end else
          WriteToLogList(False); //对应不上门店
      except
        on E:Exception do
        begin
          PlugIntf.WriteLogFile(Pchar('<810> <'+RimParam.ShopID+'>'+E.Message));
        end;
      end;
      R3ShopList.Next;
    end;
    result:=1;
  finally
    DBLock(False);
    if SyncType<>3 then  //调度运行才写日志
    begin
      FRunInfo.AllCount:=R3ShopList.RecordCount;  //总门店数
      WriteLogRun('日进销存汇总');  //输出到文本日志
    end;
  end;
end;

//从Rim的零售户表同步参数[single_sale_limit、sale_limit、IS_CHG_PRI]
//Rim的单位：条，R3单位：盒，默认关系为:10;
function TSalesTotalSyncFactory.DownRimParamsToR3: Boolean;
var
  IsRun: Boolean;
  iRet: integer;
  CustCnd,UpCnd,Msg: string; //门店上报更新
  Str,COM_ID,LogFile,CHANGE_PRICE,CHGCnd: string;
  LogFileList: TStringList;
begin
  CustCnd:='';
  COM_ID:=GetRimCOM_ID(trim(Params.ParamByName('TENANT_ID').AsString));
  if SyncType=3 then //门店同步[只同步本门店]
  begin
    CustCnd:=' and C.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' and C.SHOP_ID='''+Params.ParamByName('SHOP_ID').AsString+''' ';
    UpCnd:=' and A.RELATI_ID='+Params.ParamByName('TENANT_ID').AsString+' ';
  end else
    UpCnd:=' and A.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' ';

  {Rim:1:接受     0:不接受  R3: 1:企业变价 2: 统一定价 }
  case DbType of
   1: CHANGE_PRICE:='DECODE(IS_CHG_PRI,''0'',''2'',''1'')';
   4: CHANGE_PRICE:='(case when IS_CHG_PRI=''0'' then ''2'' else ''1'' end)';
  end;
  CHGCnd:=ParseSQL(DbType,'(nvl(A.SINGLE_LIMIT,0)<>nvl(B.single_sale_limit,0)*10.0)or(nvl(A.SALE_LIMIT,0)<>nvl(B.sale_limit,0)*10.0)or(A.CHANGE_PRICE<>'+CHANGE_PRICE+')');
  Str:=
    'update CA_RELATIONS A '+
    ' set (SINGLE_LIMIT,SALE_LIMIT,CHANGE_PRICE,TIME_STAMP)='+
        '(select distinct single_sale_limit*10.0,sale_limit*10.0,'+CHANGE_PRICE+' as IS_CHG_PRI,'+GetTimeStamp(DbType)+' as TIME_STAMP '+
        ' from RM_CUST B,CA_SHOP_INFO C '+
        ' where B.LICENSE_CODE=C.LICENSE_CODE and A.RELATI_ID=C.TENANT_ID '+CustCnd+' and ('+CHGCnd+')) '+
    ' where A.RELATION_STATUS=''2'' and A.RELATION_ID='+InttoStr(NT_RELATION_ID)+' '+UpCnd+
    ' and exists(select 1 from RM_CUST B,CA_SHOP_INFO C where B.LICENSE_CODE=C.LICENSE_CODE and A.RELATI_ID=C.TENANT_ID '+CustCnd+' and ('+CHGCnd+'))';

  try
    BeginLogRun; //日志
    try
      BeginTrans;  //开始事务
      if ExecSQL(Pchar(str),iRet)<>0 then Raise Exception.Create('下载Rim零售户限价数参数出错：'+PlugIntf.GetLastError);
      IsRun:=CommitTrans; //提交事务

      if IsRun and (SyncType<>3) then //批量才写日志
      begin
        FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick;  //总执行多少秒
        Msg:='---- RSP调度【Rim零售户限价量参数】 同步：'+InttoStr(iRet)+'笔，运行'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'秒-------';
      end;
    except
      on E:Exception do
      begin
        RollbackTrans; //回滚事务
        Msg:='---- RSP调度【Rim零售户限价量参数】 同步出错！-------';
        PlugIntf.WriteLogFile(Pchar(Msg));
      end;    
    end;
  finally
    if SyncType<>3 then
    begin
      LogFile := ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT'+FormatDatetime('YYYYMMDD',Date())+'.log';
      LogFileList:=TStringList.Create;
      if FileExists(LogFile) then
      begin
        LogFileList.LoadFromFile(LogFile);
        LogFileList.Add('    ');
      end;
      LogFileList.Add(Msg); 
      LogFileList.SaveToFile(LogFile);
    end;
  end;
end;

function TSalesTotalSyncFactory.SendDaySaleTotal: integer;
var
  iRet,UpiRet: integer;  //返回ExeSQL影响多少行记录
  sql:string;
begin
  result := -1;
  iRet:=0;
  UpiRet:=0;
  BeginTrans;
  try
    sql := 'delete from INTERFACE.T_EBP_JOURNAL where CUSTOMERCODE='''+RimParam.CustID+''' and BDATE=current date';
    ExecSQL(Pchar(sql),iRet);

    sql :=
    'insert into INTERFACE.T_EBP_JOURNAL(BDATE,UPDATE_TIME,TAG,CUSTOMERCODE,CUSTOMERDESC,BARCODELOAF,INITQUANT,PURCHASEQUANT,SALESQUANT,SALESAMOUNT,INVENTORYQUANT,SALESPRICE) '+
    'select current date,current timestamp,''0'','''+RimParam.CustID+''','''+RimParam.ShopName+''',c.PACK_BARCODE,0.0,sum(STOCK_AMT) as STOCK_AMT,sum(SALES_AMT) as SALES_AMT,sum(SALES_MNY) as SALES_MNY,sum(STOR_AMT) as STOR_AMT,'+
    'case when sum(SALES_AMT)<>0 then cast(sum(SALES_MNY) as decimal(18,3))/cast(sum(SALES_AMT) as decimal(18,3)) else 0 end as SALES_PRC '+
    'from ( '+
    'select A.TENANT_ID,A.GODS_ID,B.SECOND_ID,0 as STOCK_AMT,sum(CALC_AMOUNT/('+GetDefaultUnitCalc('B')+')) as SALES_AMT,sum(CALC_MONEY) as SALES_MNY,0 as STOR_AMT '+
    'from VIW_SALESDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and A.SALES_DATE='+formatDatetime('YYYYMMDD',date())+' group by A.TENANT_ID,A.GODS_ID,B.SECOND_ID '+
    'union all '+
    'select A.TENANT_ID,A.GODS_ID,B.SECOND_ID,sum(A.CALC_AMOUNT/('+GetDefaultUnitCalc('B')+')) as STOCK_AMT,0 as SALES_AMT,0 as SALES_MNY,0 as STOR_AMT '+
    'from VIW_STOCKDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+'''  and A.STOCK_DATE='+formatDatetime('YYYYMMDD',date())+' group by A.TENANT_ID,A.GODS_ID,B.SECOND_ID '+
    'union all '+
    'select A.TENANT_ID,A.GODS_ID,B.SECOND_ID,0 as STOCK_AMT,0 as SALES_AMT,0 as SALES_MNY,sum(A.AMOUNT/('+GetDefaultUnitCalc('B')+')) as STOR_AMT '+
    'from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' group by A.TENANT_ID,A.GODS_ID,B.SECOND_ID '+
    ') j,RIM_GOODS_RELATION c where j.SECOND_ID=c.GODS_ID group by c.PACK_BARCODE ';

    ExecSQL(Pchar(sql),iRet);
    UpiRet := iRet;
    CommitTrans;
    result:=UpiRet;
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'10','上报日进销存失败！','02'); //写日志
      Raise Exception.Create(E.Message);
    end;
  end;

  //执行成功写日志:
  WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'10','上报日销存成功！','01');
end;

end.















