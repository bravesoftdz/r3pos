{
  Create Date: 2011.04.11 Pm
  说明:
    1、插件ID: 是对于实现某个功能插件编号;
 }


library RimOrderDownPlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase,
  uPlugInUtil in '..\obj\uPlugInUtil.pas';


{$R *.res}


procedure SetRimCom_CustID(PlugIn: IPlugIn; vParam: TftParamList; var ComID: string; var CustID: string);
var
  str,TenantID,ShopID: string;
  rs: TZQuery;
begin
  try
    rs:=TZQuery.Create(nil);
    try
      TenantID:=vParam.ParamByName('TENANT_ID').AsString;
      ShopID:=vParam.ParamByName('SHOP_ID').AsString;
      str:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenantID+' and B.SHOP_ID='''+ShopID+''' ';
      if OpenData(PlugIn, rs, str) then
      begin
        ComID:=trim(rs.fieldbyName('COM_ID').AsString);
        CustID:=trim(rs.fieldbyName('CUST_ID').AsString);
      end;
    except
      on E:Exception do
      begin
        str:='企业ID('+vParam.ParamByName('TENANT_ID').AsString+'),门店ID('+vParam.ParamByName('SHOP_ID').AsString+')，返回Rim的供应商ID、零售户ID出错：'+E.Message;
        Raise Exception.Create(Pchar(str));
      end;
    end;
  finally
    rs.Free;
  end;
end;

function DownOrderToINF_StockOrder(GPlugIn: IPlugIn; vParam: TftParamList): Boolean;
var
  iRet: integer;
  Str,NearDate,UseDate: string;
  TenantID,ShopID,ComID,CustID: string;
begin
  result:=False;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //获取最近30天的订单日期
  TenantID:=vParam.ParamByName('TENANT_ID').AsString;
  ShopID:=vParam.ParamByName('SHOP_ID').AsString;
  UseDate:=vParam.ParamByName('USING_DATE').AsString;
  SetRimCom_CustID(GPlugIn,vParam,ComID,CustID); //读取Rim系统的供应商（烟草公司Com_ID）和零售户的Cust_Id
  TLogRunInfo.LogWrite('下载订单表体取参数:（R3企业ID：'+TenantID+';门店ID：'+ShopID+'），（RIM烟草公司ID:'+ComID+';零售户ID:'+CustID+'）','RimOrderDownPlugIn.dll');

  //判断启用日期与最近30天关系
  //if NearDate < UseDate then NearDate:=UseDate;

  try
    {== 中间表是作为接口，相应系统共用，此处处理: 主表作为查询显示下载列表显示使用 ==}
    if (ComID<>'') and (CustID<>'')  then
    begin
      //1、先删除中间表历史数据:
      if GPlugIn.ExecSQL(Pchar('delete from INF_INDEORDER where TENANT_ID='+TenantID+' and SHOP_ID='''+ShopID+''' '),iRet)<>0 then Raise Exception.Create('1、删除订单中间表(INF_INDEORDER)失败！〖条件：企业ID='+TenantID+',门店ID='+ShopID+'〗');

      //2、插入最近30天且已确认的订单表头:
      Str:='insert into INF_INDEORDER (TENANT_ID,SHOP_ID,INDE_ID,INDE_DATE,INDE_AMT,INDE_MNY,NEED_AMT,STATUS) '+
         ' select '+TenantID+' as TenantID,'''+ShopID+''' as SHOP_ID,A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,sum(QTY_NEED) as NEED_AMT,A.STATUS '+
         ' from RIM_SD_CO A,RIM_SD_CO_LINE B '+
         ' where A.CO_NUM=B.CO_NUM and A.STATUS>=''04'' and A.CRT_DATE>='''+NearDate+''' and A.COM_ID='''+ComID+''' and A.CUST_ID='''+CustID+''' '+
         ' group by A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,A.STATUS ';
      if GPlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2、插入最近30天订单表头出错！'+Str);
      TLogRunInfo.LogWrite('下载订单执行完毕:（下载:'+inttoStr(iRet)+'笔）（InsertSQL:'+Str+'）','RimOrderDownPlugIn.dll');
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('下载订单（RIM_SD_CO）到中间表（INF_INDEORDER）出错：'+E.Message); //写异常日志;
    end;
  end;
end;

function DownOrderToINF_StockData(PlugIn: IPlugIn; vParam: TftParamList): Boolean;
var
  iRet: integer;
  Str, INDE_ID, TenantID: string;
begin
  result:=False;
  INDE_ID:=trim(vParam.ParamByName('INDE_ID').AsString);
  TenantID:=inttostr(vParam.ParamByName('TENANT_ID').AsInteger);
  TLogRunInfo.LogWrite('下载订单表体前传入参数:（R3企业ID：'+TenantID+';订单ID：'+INDE_ID+'）','RimOrderDownPlugIn.dll');
  try
    //1、删除订单表体历史数据：
    Str:='delete from INF_INDEDATA where TENANT_ID='+TenantID+' and INDE_ID='''+INDE_ID+''' ';
    if PlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('1、删除订单表体历史数据出错！（SQL='+Str+'）');

    //2、插入订单表体:
    Str:='insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,SECOND_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
         'select '+TenantID+' as TENANT_ID,CO_NUM,B.GODS_ID,ITEM_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,QTY_NEED,QTY_VFY,QTY_ORD,PRI,AMT,RET_AMT '+
         ' from RIM_SD_CO_LINE A '+
         ' left outer join (select GODS_ID,SECOND_ID from VIW_GOODSINFO where TENANT_ID='+TenantID+')B on A.ITEM_ID=B.SECOND_ID '+
         ' where A.CO_NUM='''+INDE_ID+''' ';
    if PlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2、插入订单表体出错！（SQL='+Str+'）');
    TLogRunInfo.LogWrite('下载订单表体执行完毕:（下载：'+inttoStr(iRet)+'笔）（InsertSQL:'+Str+'）','RimOrderDownPlugIn.dll');
  except
    on E:Exception do
    begin
      Raise Exception.Create('下载订单明细（RIM_SD_CO_LINE）到中间表（INF_INDEORDER）出错：'+E.Message);
    end;
  end;
end;
       
//RSP装载插件时调用，传插件可访问的服务接口
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;

//插件中执行的所有操作都必须带 try except end 如果出错时，由此方法返回错信息
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;

//返回当前插件说明
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := 'RSP平台下载RIM系统订单';
end;

//返回RIM下载订单（到货确认）的插件
function GetPlugInId:Integer; stdcall;
begin
  result := 1002;
end;

//RSP调用插件时执行此方法
function DoExecute(Params:Pchar; var Data:oleVariant):Integer; stdcall;
var
  ExeType: Integer; //执行类型（1:订单主表; 2:订单明细表）
  vParam: TftParamList;
begin
  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,StrPas(Params));
    ExeType:=vParam.ParamByName('ExeType').AsInteger;  
    try
      case ExeType of
       1: DownOrderToINF_StockOrder(GPlugIn, vParam);  //下载订单主表
       2: DownOrderToINF_StockData(GPlugIn, vParam);   //下载订单明细表
      end;
      result := 0;
    except
      on E:Exception do
      begin
        GLastError := E.Message;
        GPlugIn.WriteLogFile(Pchar(E.Message));
        result := 2001;
      end;
    end;
  finally
    vParam.Free;
  end;
end;

//RSP调用插件自定义的管理界面,没有时直接返回0
function ShowPlugin:Integer; stdcall;
begin
  try
    //开始显示主界面窗体
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2002;
      end;
  end;
end;

exports
  SetParams,GetLastError,GetPlugInDisplayName,GetPlugInId,DoExecute,ShowPlugin;
begin

end.



     {//2、插入最近30天且已确认的订单表头:
      Str:='insert into INF_INDEORDER (TENANT_ID,SHOP_ID,INDE_ID,INDE_DATE,INDE_AMT,INDE_MNY,STATUS) '+
         ' select '+TenantID+' as TenantID,'''+ShopID+''' as SHOP_ID,CO_NUM,CRT_DATE,QTY_SUM,AMT_SUM,STATUS from RIM_SD_CO '+
         ' where STATUS>=''04'' and CRT_DATE>='''+NearDate+''' and COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' ';
      if GPlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2、插入最近30天订单表头出错！'+Str);


      //3、汇总订单表头需求量:
      str:='update INF_INDEORDER A set NEED_AMT=(select sum(QTY_NEED) from RIM_SD_CO_LINE B where A.INDE_ID=B.CO_NUM) '+
           ' where exists(select 1 from RIM_SD_CO_LINE B where A.INDE_ID=B.CO_NUM) ';
      if GPlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('3、汇总订单表头需求量出错！');
      }

