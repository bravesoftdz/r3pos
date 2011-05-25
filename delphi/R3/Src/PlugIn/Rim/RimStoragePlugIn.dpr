{
 插件参数：
  (1)调度执行:不需要传入:TYPE
  (2)前台调用:需要传入参数:TYPE，且Value=0;
 }


library RimStoragePlugIn;

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
  System,
  Windows,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  DB,
  zBase,
  uPlugInUtil in '..\obj\uPlugInUtil.pas';

{$R *.res}


//////2011.04.15 AM上报零售户库 (每天上报一次)不需要上报时间戳  
function SendCustStorage(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE:string): Boolean;
var
  iRet,iDBType: integer;    //返回ExeSQL影响多少行记录
  Str,StoreTab,ShortID: string;
begin
  result := False;
  try
    if PlugIntf.iDbType(iDBType)<>0 then Raise Exception.Create('返回数据类型错误！');   
    PlugIntf.BeginTrans;
    ShortID:=Copy(SHOP_ID,length(SHOP_ID)-3,4);
    //1、先插入不存在商品:
    Str:='insert into RIM_CUST_ITEM_SWHSE(CUST_ID,ITEM_ID,COM_ID,TERM_ID,QTY,DATE1,TIME1,IS_MRB) '+
         ' select '''+CustID+''' as CustID,B.SECOND_ID,'''+ORGAN_ID+''' as COM_ID,'''+ShortID+''' as TERM_ID,0 as QRY,'''+FormatDatetime('YYYYMMDD',Date())+''' as UPD_DATE,'''+TimetoStr(time())+''' as UPD_TIME,''0'' '+
         ' from STO_STORAGE A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.COMM not in (''02'',''12'') and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' and not exists(select ITEM_ID from RIM_CUST_ITEM_SWHSE C where C.COM_ID='''+ORGAN_ID+''' and C.CUST_ID='''+CustID+''' and C.TERM_ID='''+ShortID+''' and C.ITEM_ID=B.SECOND_ID) ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('插入不存在商品RIM_CUST_ITEM_SWHSE出错：'+PlugIntf.GetLastError);

    //2、插入: RIM_CUST_ITEM_SWHSE
    Str:='update RIM_CUST_ITEM_SWHSE '+
         ' set QTY=(select sum(A.AMOUNT/'+GetDefaultUnitCalc+')as QRY from STO_STORAGE A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and '+
         ' B.COMM not in (''02'',''12'') and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)'+
         ' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TERM_ID='''+ShortID+''' ';
         // ' and exists(select B.SECOND_ID from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('插入RIM_CUST_ITEM_SWHSE记录出错:'+PlugIntf.GetLastError);

    //3、先更新当前当天的中间库存中间表：[RIM_CUST_ITEM_SWHSE]:
    str:=' update RIM_CUST_ITEM_WHSE '+
         '  set QTY=coalesce((select sum(QTY) from RIM_CUST_ITEM_SWHSE A where RIM_CUST_ITEM_WHSE.COM_ID=A.COM_ID and RIM_CUST_ITEM_WHSE.CUST_ID=A.CUST_ID and RIM_CUST_ITEM_WHSE.ITEM_ID=A.ITEM_ID),0) '+
         ' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' ';
    str:=ParseSQL(iDBType,str);
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('更新RIM_CUST_ITEM_SWHSE出错:'+PlugIntf.GetLastError);

    //4、没有更新到记录插入中间表：[RIM_CUST_ITEM_WHSE]:
    str:='insert into RIM_CUST_ITEM_WHSE(COM_ID,CUST_ID,ITEM_ID,QTY) '+
         ' select COM_ID,CUST_ID,ITEM_ID,sum(QTY) from RIM_CUST_ITEM_SWHSE A where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and '+
         ' not Exists(select COM_ID from RIM_CUST_ITEM_WHSE where COM_ID=A.COM_ID and CUST_ID=A.CUST_ID and ITEM_ID=A.ITEM_ID) '+
         ' group by COM_ID,CUST_ID,ITEM_ID ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('插入RIM_CUST_ITEM_SWHSE新记录出错:'+PlugIntf.GetLastError);

    PlugIntf.CommitTrans;
    result:=true;
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf,LICENSE_CODE,CustID,'11','上报零售户库错误！','02');  //写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

procedure CallReportStorageSync(PlugIntf:IPlugIn; InParam: string);  //上报库存
var
  RunInfo: TRunInfo; //上报纪录信息
  Str: string;       //企业表视图
  OrganID,           //RIM烟草公司ID
  LICENSE_CODE,      //RIM零售户许可证号
  CustID,            //RIM零售户ID
  TenantID,          //R3上报企业ID
  TenName,           //R3上报企业Name
  ShopID,            //R3上报门店ID
  ShopName: string;  //R3上报门店名称;
  R3ShopList,Rs: TZQuery;
  vParam: TftParamList;
  IsFlag: Boolean;  //是否为零售户直接上报
  BegTime,ErrorStr: string; //开始运行时间点
  BegTick,RunCount,NotCount,ErrorCount: integer;
begin
  BegTime:=Timetostr(time());
  BegTick:=GetTickCount;
  RunCount:=0;
  NotCount:=0;
  ErrorCount:=0;
  ErrorStr:='';
  
  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,InParam);
    TenantID:=vParam.ParamByName('TENANT_ID').AsString;
    IsFlag:=False; 
    if (vParam.FindParam('FLAG')<>nil) and (vParam.FindParam('FLAG').AsInteger=3) then
      IsFlag:=true;
  finally
    vParam.Free;
  end;

  Rs := TZQuery.Create(nil);
  R3ShopList := TZQuery.Create(nil);
  try
    //返回R3的上报ShopList
    GetR3ReportShopList(PlugIntf, R3ShopList, InParam);
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
        if OrganID='' then Raise Exception.Create('R3传入企业ID（'+TenantID+'）在RIM中没找到对应的ORGAN_ID值...');
        CustID:=GetRimCust_ID(PlugIntf, OrganID, LICENSE_CODE);
        if CustID<>'' then
        begin
          //开始上零售户库存
          if SendCustStorage(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE) then
            Inc(RunCount)   //累计上报成功个数
          else
            Inc(ErrorCount); //累计失败个数
        end else
        begin
          ErrorStr:=ErrorStr+'   '+'R3门店:'+ShopID+' —'+ShopName+' 许可证号'+LICENSE_CODE+' 在Rim系统中没对应上！';
          Inc(NotCount);  //对应不上
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          ErrorStr:=ErrorStr+'   '+E.Message;
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'12','上报库存出错误！','02'); //写Rim表错误日志
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    Rs.Free; 
    R3ShopList.Free;
    BegTick:=GetTickCount-BegTick; //总执行多少秒
    //输出日志:
    if IsFlag then  //客户端单个门店日志
    begin
      if RunCount=1 then
        PlugIntf.WriteLogFile(Pchar('R3终端上报库存,传入门店：('+ShopID+'- '+ShopName+') 开始执行时间：'+BegTime+' 共执行'+FormatFloat('#0.00',BegTick/1000)+'秒  上报成功！')) 
      else
        PlugIntf.WriteLogFile(Pchar('R3终端上报库存,传入门店：('+ShopID+'- '+ShopName+') 开始执行时间：'+BegTime+' 共执行'+FormatFloat('#0.00',BegTick/1000)+'秒  上报出错:'+ErrorStr));
    end else  //后台调度运行:
    begin
      PlugIntf.WriteLogFile(Pchar('R3终端上报库存,传入企业：('+TenantID+'- '+TenName+') 开始执行时间：'+BegTime+' 共执行'+FormatFloat('#0.00',BegTick/1000)+'秒 '));
      Str:='上报成功门店数：'+inttostr(RunCount)+'  Rim中没有对应门店数:'+inttoStr(NotCount)+' 上报失败门店数:'+inttoStr(ErrorCount);
      if ErrorStr<>'' then Str:=Str+' 错误消息： '+#13+ErrorStr;
      PlugIntf.WriteLogFile(Pchar(ErrorStr));
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
  result := 'RSP平台上报RIM库存';
end;

//为每个插件定义一个唯一标识号，范围1000-9999
function GetPlugInId:Integer; stdcall;
begin
  result := 1004;  //RIM接口的插件
end;

//RSP调用插件时执行此方法
function DoExecute(Params:Pchar; var Data: oleVariant):Integer; stdcall;
begin
  try
    //上报库存
    CallReportStorageSync(GPlugIn, StrPas(Params));
    result := 0;
  except
    on E:Exception do
    begin
      GLastError := E.Message;
      result := 2001;
    end;
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


