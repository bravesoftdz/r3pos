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


procedure SetRimCom_CustID(PlugIn: IPlugIn; vParam: TftParamList; var TenantID: string; var ShopID: string; var ComID: string; var CustID: string);
var
  str: string;
  rs: TZQuery;
begin
  try
    rs:=TZQuery.Create(nil);
    try
      TenantID:=InttoStr(vParam.ParamByName('TENANT_ID').AsInteger);
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
        GLastError := E.Message;
        PlugIn.WriteLogFile(Pchar('传入R3企业ID('+vParam.ParamByName('TENANT_ID').AsString+'),门店ID('+vParam.ParamByName('SHOP_ID').AsString+')，返回Rim的供应商ID、零售户ID出错：'+E.Message));
      end;
    end;
  finally
    rs.Free;
  end;
end;

function DownOrderToINF_StockOrder(PlugIn: IPlugIn; vParam: TftParamList): Boolean;
var
  iRet: integer;
  Str,NearDate,TenantID,ShopID,ComID,CustID: string;
begin
  result:=False;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //获取最近30天的订单日期
  SetRimCom_CustID(PlugIn,vParam,TenantID,ShopID,ComID,CustID); //读取Rim系统的供应商（烟草公司Com_ID）和零售户的Cust_Id
  try
    {== 中间表是作为接口，相应系统共用，此处处理: 主表作为查询显示下载列表显示使用 ==}
    if (ComID<>'') and (CustID<>'')  then
    begin
      PlugIn.ExecSQL(Pchar('delete from INF_INDEORDER where TENANT_ID='+TenantID+' and SHOP_ID='''+ShopID+''' '),iRet);
      Str:='insert into INF_INDEORDER (TENANT_ID,SHOP_ID,INDE_ID,INDE_DATE,INDE_AMT,INDE_MNY,STATUS) '+
         ' select '+TenantID+' as TenantID,'''+ShopID+''' as SHOP_ID,CO_NUM,CRT_DATE,QTY_SUM,AMT_SUM,STATUS from RIM_SD_CO '+
         ' where STATUS>=''04'' and CRT_DATE>='''+NearDate+''' and COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' ';
      PlugIn.ExecSQL(Pchar(Str),iRet);
      {== 汇总需求量直接更新到主表 需求量 ==}
      str:='update INF_INDEORDER A set NEED_AMT=(select sum(QTY_NEED) from RIM_SD_CO_LINE B where A.INDE_ID=B.CO_NUM) '+
           ' where exists(select 1 from RIM_SD_CO_LINE B where A.INDE_ID=B.CO_NUM) ';
      PlugIn.ExecSQL(Pchar(Str),iRet);
    end;
  except
    on E:Exception do
    begin
      GLastError := E.Message;
      PlugIn.WriteLogFile(Pchar('下载订单（RIM_SD_CO）到中间表（INF_INDEORDER）出错：'+E.Message));
    end;
  end;
end;

function DownOrderToINF_StockData(PlugIn: IPlugIn; vParam: TftParamList): Boolean;
var
  iRet: integer;
  Str,INDE_ID,TenantID: string;
begin
  result:=False;
  INDE_ID:=trim(vParam.ParamByName('INDE_ID').AsString);
  TenantID:=trim(vParam.ParamByName('TENANT_ID').AsString);
  try
    //删除单据历史数据：
    PlugIn.ExecSQL(Pchar('delete from INF_INDEDATA where INDE_ID='''+INDE_ID+''' '),iRet);
    //插入数据SQL语句:
    str:='insert into INF_INDEDATA(INDE_ID,SECOND_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
         'select CO_NUM,ITEM_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,QTY_NEED,QTY_VFY,QTY_ORD,PRI,AMT,RET_AMT '+
         ' from RIM_SD_CO_LINE where CO_NUM='''+INDE_ID+''' ';
    PlugIn.ExecSQL(Pchar(Str),iRet);
    
    //根据供应链[GODS_ID] 与 [SECOND_ID] 更新R3的GODS_ID
    str:='update INF_INDEDATA A set A.GODS_ID='+
         '(select GODS_ID from PUB_GOODS_RELATION B where B.TENANT_ID='+TenantID+' and A.SECOND_ID=B.SECOND_ID) '+
         ' where A.INDE_ID='''+INDE_ID+''' and exists(select 1 from PUB_GOODS_RELATION B where B.TENANT_ID='+TenantID+' and A.SECOND_ID=B.SECOND_ID) ';

    PlugIn.ExecSQL(Pchar(Str),iRet);
  except
    on E:Exception do
    begin
      GLastError := E.Message;
      PlugIn.WriteLogFile(Pchar('下载订单明细（RIM_SD_CO_LINE）到中间表（INF_INDEORDER）出错：'+E.Message));
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
