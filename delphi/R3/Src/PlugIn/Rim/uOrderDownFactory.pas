unit uOrderDownFactory;

interface

uses
  SysUtils, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory,uRimSyncFactory;

  
//下载Rim系统订单（到货入库确认）
type
  TOrderDownSyncFactory=class(TRimSyncFactory)
  private
    //从 [RIM_SD_CO] 插入中间表 [INF_INDEORDER]
    function DownOrderToINF_INDEOrder: Boolean;
    //从 [RIM_SD_CO_LINE] 插入中间表 [INF_INDERDATA]
    function DownOrderToINF_INDEData: Boolean;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;

implementation


{ TRimSyncFactory }

function TOrderDownSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  result := -1;
  {------初始化参数------}
  PlugIntf:=GPlugIn;

  //1、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  if Params.FindParam('ExeType')=nil then //Rsp调度的不执行订单下载
  begin
    result:=1; //退出执行
    Exit;
  end;

  //2、返回数据库类型
  GetDBType;
  try
    case Params.ParamByName('ExeType').AsInteger of   //执行类型： 
     1: DownOrderToINF_INDEOrder;   //下载订单主表
     2: DownOrderToINF_INDEData;    //下载订单明细表
    end;
    result := 0;
  except
    on E:Exception do
    begin
      GLastError := E.Message;
      PlugIntf.WriteLogFile(Pchar(E.Message));
      result := 2001;
    end;
  end;
end;

function TOrderDownSyncFactory.DownOrderToINF_INDEOrder: Boolean;
var
  iRet: integer;
  Str,NearDate,UseDate: string;
  TENANT_ID,SHOP_ID,COM_ID,CUST_ID: string;
begin
  result:=False;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //获取最近30天的订单日期
  // UseDate:=vParam.ParamByName('USING_DATE').AsString;
  //判断启用日期与最近30天关系
  //if NearDate < UseDate then NearDate:=UseDate;

  TENANT_ID:=trim(Params.ParamByName('TENANT_ID').AsString);
  SHOP_ID:=trim(Params.ParamByName('SHOP_ID').AsString);    //R3门店ID
  //返回Rim烟草公司ID,零售户ID
  SetRimORGAN_CUST_ID(TENANT_ID,SHOP_ID, COM_ID, CUST_ID);

  if COM_ID='' then Raise Exception.Create('没有找到RIM系统烟草公司！');
  if CUST_ID='' then Raise Exception.Create('没有找到RIM系统零售户！'); //写异常日志;

  try
    {== 中间表是作为接口，相应系统共用，此处处理: 主表作为查询显示下载列表显示使用 ==}
    //1、先删除中间表历史数据:
    if PlugIntf.ExecSQL(Pchar('delete from INF_INDEORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' '),iRet)<>0 then
       Raise Exception.Create('1、删除INF_INDEORDER失败！〖条件：企业ID='+TENANT_ID+',门店ID='+SHOP_ID+'〗'+PlugIntf.GetLastError);

    //2、插入最近30天且已确认的订单表头:
    Str:='insert into INF_INDEORDER (TENANT_ID,SHOP_ID,INDE_ID,INDE_DATE,INDE_AMT,INDE_MNY,NEED_AMT,STATUS) '+
      ' select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,sum(QTY_NEED) as NEED_AMT,A.STATUS '+
      ' from RIM_SD_CO A,RIM_SD_CO_LINE B '+
      ' where A.CO_NUM=B.CO_NUM and A.STATUS>=''04'' and A.CRT_DATE>='''+NearDate+''' and A.COM_ID='''+COM_ID+''' and A.CUST_ID='''+CUST_ID+''' '+
      ' group by A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,A.STATUS ';
     if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2、插入最近30天订单表头出错！'+PlugIntf.GetLastError);
     result:=true;
  except
    on E:Exception do
    begin
      Raise Exception.Create('下载订单（RIM_SD_CO）到中间表（INF_INDEORDER）出错：'+E.Message); //写异常日志;
    end;
  end;
end;

// 2011.06.02 Modif: 
function TOrderDownSyncFactory.DownOrderToINF_INDEData: Boolean;
var
  iRet: integer;
  Str, TENANT_ID, INDE_ID: string;
begin
  result:=False;
  INDE_ID:=trim(Params.ParamByName('INDE_ID').AsString);
  TENANT_ID:=inttostr(Params.ParamByName('TENANT_ID').AsInteger);
  try
    //1、删除订单表体历史数据：
    Str:='delete from INF_INDEDATA where TENANT_ID='+TENANT_ID+' and INDE_ID='''+INDE_ID+''' ';
    if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('1、删除订单表体历史数据出错！（SQL='+Str+'）');

    case DbType of
     1: //Oracle
      begin                                                     //SECOND_ID,
        Str:='insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
             ' select '+TENANT_ID+' as TENANT_ID,CO_NUM,B.GODS_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,'+
             ' sum(QTY_NEED) as QTY_NEED,'+                       //ITEM_ID,
             ' sum(QTY_VFY) as QTY_VFY,'+
             ' sum(QTY_ORD) as QTY_ORD,'+
             ' (case when sum(QTY_ORD)<>0 then cast(sum(AMT)as decimal(18,3))/cast(sum(QTY_ORD) as decimal(18,3)) else 0 end) as PRI,'+
             ' sum(AMT) as AMT,'+
             ' sum(RET_AMT) as RET_AMT '+
             ' from RIM_SD_CO_LINE A left outer join (select GODS_ID,SECOND_ID,COMM_ID from VIW_GOODSINFO where TENANT_ID='+TENANT_ID+')B '+
             ' on (A.ITEM_ID=B.SECOND_ID) or (INSTR( B.COMM_ID,'','' || A.ITEM_ID || '','', 1, 1)>0) '+  //加条件：
             ' where A.CO_NUM='''+INDE_ID+''' '+
             ' group by CO_NUM,B.GODS_ID ';  //,ITEM_ID
      end;
     4: //DB2
      begin                                                     //SECOND_ID,
        Str:='insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
             ' select '+TENANT_ID+' as TENANT_ID,CO_NUM,B.GODS_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,'+
             ' sum(QTY_NEED) as QTY_NEED,'+                       //ITEM_ID,
             ' sum(QTY_VFY) as QTY_VFY,'+
             ' sum(QTY_ORD) as QTY_ORD,'+
             ' (case when sum(QTY_ORD)<>0 then cast(sum(AMT)as decimal(18,3))/cast(sum(QTY_ORD) as decimal(18,3)) else 0 end) as PRI,'+
             ' sum(AMT) as AMT,'+
             ' sum(RET_AMT) as RET_AMT '+
             ' from RIM_SD_CO_LINE A left outer join (select GODS_ID,SECOND_ID,COMM_ID from VIW_GOODSINFO where TENANT_ID='+TENANT_ID+')B '+
             ' on (A.ITEM_ID=B.SECOND_ID) or (locate( B.COMM_ID,'','' || A.ITEM_ID || '','')>0) '+  //加条件：
             ' where A.CO_NUM='''+INDE_ID+''' '+
             ' group by CO_NUM,B.GODS_ID ';  //,ITEM_ID
      end;
    end;

    //2、插入订单表体:
   { Str:='insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,SECOND_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
         'select '+TENANT_ID+' as TENANT_ID,CO_NUM,B.GODS_ID,ITEM_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,QTY_NEED,QTY_VFY,QTY_ORD,PRI,AMT,RET_AMT '+
         ' from RIM_SD_CO_LINE A '+
         ' left outer join (select GODS_ID,SECOND_ID from VIW_GOODSINFO where TENANT_ID='+TENANT_ID+')B '+
         ' on A.ITEM_ID=B.SECOND_ID '+  //加条件：
         ' where A.CO_NUM='''+INDE_ID+''' ';
   }
    if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2、插入订单表体出错:'+PlugIntf.GetLastError);
    result:=true;
  except
    on E:Exception do
    begin
      Raise Exception.Create('下载订单明细（RIM_SD_CO_LINE）到中间表（INF_INDEORDER）出错：'+E.Message);
    end;
  end;
end;

 
end.
