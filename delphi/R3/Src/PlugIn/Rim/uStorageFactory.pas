unit uStorageFactory;

interface

uses
  SysUtils,windows, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TStorageSyncFactory=class(TRimSyncFactory)
  private
    function SendCustStorage: integer;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;

implementation


{ TStorageSyncFactory }

//上报一个门店库存 
function TStorageSyncFactory.SendCustStorage: integer;
var
  iRet,iRet1,iRet2,iRet3: integer;    //返回ExeSQL影响多少行记录
  Str,StoreTab,ShortID: string;
begin
  result := -1;
  try
    BeginTrans;
    ShortID:=Copy(RimParam.ShopID,length(RimParam.ShopID)-3,4); //门店代码后4位
    
    //1、先插入不存在商品:
    Str:='insert into RIM_CUST_ITEM_SWHSE(CUST_ID,ITEM_ID,COM_ID,TERM_ID,QTY,DATE1,TIME1,IS_MRB) '+
         ' select '''+RimParam.CustID+''' as CUST_ID,B.SECOND_ID,'''+RimParam.ComID+''' as COM_ID,'''+ShortID+''' as TERM_ID,0 as QRY,'''+FormatDatetime('YYYYMMDD',Date())+''' as UPD_DATE,'''+TimetoStr(time())+''' as UPD_TIME,''0'' '+
         ' from STO_STORAGE A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.COMM not in (''02'',''12'') and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' and not exists(select ITEM_ID from RIM_CUST_ITEM_SWHSE C where C.COM_ID='''+RimParam.ComID+''' and C.CUST_ID='''+RimParam.CustID+''' and C.TERM_ID='''+ShortID+''' and C.ITEM_ID=B.SECOND_ID) ';
    if PlugIntf.ExecSQL(pchar(Str), iRet)<>0 then
      Raise Exception.Create('插入不存在商品RIM_CUST_ITEM_SWHSE出错：'+PlugIntf.GetLastError);

    //2、插入: RIM_CUST_ITEM_SWHSE
    Str:=ParseSQL(DbType,
           'update RIM_CUST_ITEM_SWHSE '+
           ' set QTY=coalesce((select sum(A.AMOUNT/'+GetDefaultUnitCalc+')as QRY from STO_STORAGE A,VIW_GOODSINFO B '+
           ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and '+
           ' B.COMM not in (''02'',''12'') and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID),0)'+
           ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TERM_ID='''+ShortID+''' ');
         // ' and exists(select B.SECOND_ID from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)';
    if PlugIntf.ExecSQL(pchar(Str), iRet1)<>0 then
      Raise Exception.Create('插入RIM_CUST_ITEM_SWHSE记录出错:'+PlugIntf.GetLastError);

    //3、先更新当前当天的中间库存中间表：[RIM_CUST_ITEM_SWHSE]:
    str:=' update RIM_CUST_ITEM_WHSE '+
         '  set QTY=coalesce((select sum(QTY) from RIM_CUST_ITEM_SWHSE A where RIM_CUST_ITEM_WHSE.COM_ID=A.COM_ID and RIM_CUST_ITEM_WHSE.CUST_ID=A.CUST_ID and RIM_CUST_ITEM_WHSE.ITEM_ID=A.ITEM_ID),0) '+
         ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' ';
    str:=ParseSQL(DbType,str);
    if PlugIntf.ExecSQL(pchar(Str), iRet2)<>0 then
      Raise Exception.Create('更新RIM_CUST_ITEM_SWHSE出错:'+PlugIntf.GetLastError);

    //4、没有更新到记录插入中间表：[RIM_CUST_ITEM_WHSE]:
    str:='insert into RIM_CUST_ITEM_WHSE(COM_ID,CUST_ID,ITEM_ID,QTY) '+
         ' select COM_ID,CUST_ID,ITEM_ID,sum(QTY) from RIM_CUST_ITEM_SWHSE A where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and '+
         ' not Exists(select COM_ID from RIM_CUST_ITEM_WHSE where COM_ID=A.COM_ID and CUST_ID=A.CUST_ID and ITEM_ID=A.ITEM_ID) '+
         ' group by COM_ID,CUST_ID,ITEM_ID ';
    if PlugIntf.ExecSQL(pchar(Str), iRet3)<>0 then
      Raise Exception.Create('插入RIM_CUST_ITEM_SWHSE新记录出错:'+PlugIntf.GetLastError);

    PlugIntf.CommitTrans;
    result:=iRet1+iRet2+iRet3;

    //上报成功写日志：
    WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'11','上报零售户库存成功！','02');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'11','上报零售户库错误！','02');  //上报出错写日志
      Raise Exception.Create(E.Message);
    end;
  end;
end;

function TStorageSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  ErrorFlag: Boolean;
begin
  {------初始化参数------}
  PlugIntf:=GPlugIn;
  //1、返回数据库类型
  GetDBType;
  //2、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  GetSyncType;  //返回同步类型标记[SyncType=3从前台传入执行]

  {------开始运行日志------}
  BeginLogRun;
  try
    DBLock(true); //锁定连接
    //返回R3的上报ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      FRunInfo.ErrorStr:='企业ID('+RimParam.TenID+')没有对应可上报门店(上报退出执行)！';
      Exit;
    end;

    //按门店ID排序循环上报
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      ErrorFlag:=False;
      RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);      //R3企业ID (Field: TENANT_ID)
      RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString);    //R3企业名称 (Field: TENANT_NAME)
      RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);        //R3门店ID (Field: SHOP_ID)
      RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);     //R3门店名称 (Field: SHOP_NAME)
      RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString);   //R3门店许可证号 (Field: LICENSE_CODE)
      SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID);  //传入R3门店ID,返回RIM的烟草公司ComID,零售户CustID;

      //if ='' then Raise Exception.Create('R3传入企业ID（'+RimParam.TenID+' - '+RimParam.TenName+'）在RIM中没找到对应的COM_ID值...');
      if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
      begin
        LogInfo.BeginLog(RimParam.TenName+'-'+RimParam.ShopName); //开始日志

        //开始上零售户库存
        try
          iRet:=SendCustStorage;
          LogInfo.AddBillMsg('零售户库存',iRet);
        except
          on E:Exception do
          begin
            WriteRunErrorMsg(E.Message);
            if not ErrorFlag then ErrorFlag:=true;
          end;
        end;
        WriteToLogList(True,ErrorFlag);
      end else
        WriteToLogList(False); //对应不上门店日志
      R3ShopList.Next;
    end;
  finally
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //总门店数
    DBLock(False);
    if SyncType<>3 then
      WriteLogRun('零售户库存'); //输出到文本日志
  end;
end;

end.
