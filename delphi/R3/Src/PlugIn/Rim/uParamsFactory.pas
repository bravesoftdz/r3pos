{-------------------------------------------------------------------------------
 RIM数据同步:
 (1)本单元上报同步使用时间戳，在新旧系统切换时需要对RIM_R3_NUM做相应的初始TIME_STAMP的值;
 (2)R3系统计量单位: Calc_UNIT，RIM的计量单位就是R3的管理单位;

 ------------------------------------------------------------------------------}

unit uParamsFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TParamsSyncFactory=class(TRimSyncFactory)
  private
    //自动到货确认，默认不自动到货
    AUTO_DOWN_ORDER: Boolean;
    //启用日期
    UsedDateQry: TZQuery;
    //下载订单表头
    OrderQry: TZQuery;
    
    procedure WriteDownLoadToReportLog(LogMsg: string); //下载参数写日志
    //从Rim的零售户表同步参数[single_sale_limit、sale_limit、IS_CHG_PRI]
    function  DownRimParamsToR3: Boolean;
    //2012.03.05移入的自动到货消息:
    //格式日期
    function FormatDay(InDay: string): string;
    //返回R3企业启用日期列表
    function GetR3UsedDateList: Boolean;
    //返回一个门店的订单
    function GetINDEOrderList: Boolean;
    //判断是否已存在，并返回消息标题
    function CheckMessageExists(const OrderDay,ArrDay: string; var Title, s, Content,COMM_ID: string): Boolean;
    //生成一个门店到货确认消息
    function DoShopDownOrderMessage: integer;
    //生成到货确认消息
    function DownOrderMessage: integer;
  public
    constructor Create;override;
    destructor Destroy;override;
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //调用上报
  end;
 
implementation

uses
  uFnUtil;

{ TParamsSyncFactory }

function TParamsSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  result:=-1;
  PlugInID:='1006';
  //2011.11.26日定义插件不执行参数
  PlugInIdx:=8;
  {------初始化参数------}
  PlugIntf:=GPlugIn;
  //1、返回数据库类型
  GetDBType;
  //2、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  GetSyncType;  //返回同步类型标记

  //2011.06.12 Add从Rim下载销售限价、限量定义参数值:
  if not GetPlugInRunFlag then
  begin
    DownRimParamsToR3;
    result:=1;
  end else
    result:=0;

  //2012.03.05 Add自动生成到货提醒(到货确认):
  if ReadBool('PARAMS','CREATE_ORDER_MSG',False) then
    DownOrderMessage;
end;

//从Rim的零售户表同步参数[single_sale_limit、sale_limit、IS_CHG_PRI]  Rim的单位：条，R3单位：盒，默认关系为:10;
function TParamsSyncFactory.CheckMessageExists(const OrderDay, ArrDay: string; var Title, s, Content, COMM_ID: string): Boolean;
var
  Qry: TZQuery;
  NotExist: Boolean;
  CurDay,ISSUE_DATE: string;
  Msg: string;  
begin             
  //1、先判断今天是否有生成消息；2、没有生成消息则生成消息相关:Title、Source、Content;
  result:=False;
  if trim(ArrDay)='' then Exit;
  NotExist:=False;
  CurDay:=FormatDatetime('YYYYMMDD',Date()); //今天日期格式化
  if OrderDay=CurDay then //当天提醒
  begin
    COMM_ID:='MESSAGE_'+ArrDay;
    ISSUE_DATE:=CurDay;
  end else
  begin
    COMM_ID:='AUTODOWN_'+ArrDay;
    ISSUE_DATE:=OrderDay;
  end;

  Qry:=TZQuery.Create(nil);
  try
    Qry.SQL.Text:=
      'select count(*) as ReSum from MSC_MESSAGE A,MSC_MESSAGE_LIST B '+
      ' where A.TENANT_ID=B.TENANT_ID and A.MSG_ID=B.MSG_ID and A.TENANT_ID='+RimParam.TenID+' and B.SHOP_ID='''+RimParam.ShopID+''' and '+
      ' A.ISSUE_DATE='+ISSUE_DATE+' and A.COMM_ID='''+COMM_ID+''' ';
    if Open(Qry) then
    begin
      NotExist:=(Qry.FieldbyName('ReSum').AsInteger=0);
    end;
  finally
    Qry.Free;
  end;

  if (NotExist) and (ArrDay<>'') then
  begin
    if ArrDay=CurDay then //当天提醒
    begin
      s := '通知';
      Title:=FormatDay(OrderDay)+'到货提醒';          
      Content:='您<'+FormatDay(OrderDay)+'>订的订单（'+Content+'），预计<'+FormatDay(ArrDay)+'>送达，请及时到货确认。';
      
      //Content:='您'+FormatDay(OrderDay)+'的订单，预计今天送达，请及时进行到货确认，谢谢合作！';
    end else
    begin
      if AUTO_DOWN_ORDER then
      begin
        s:='到货通知';
        Title:=FormatDay(OrderDay)+'自动到货提醒';
        Content:='您<'+FormatDay(OrderDay)+'>订的订单（'+Content+'），应已于<'+FormatDay(ArrDay)+'>送达，系统将对此订单进行自动到货确认。';

        //Content:='您'+FormatDay(OrderDay)+'的订单，可能未进行手工到货确认，系统将进行自动到货确认，如果已经到货确认，忽略此信息，谢谢合作！ ';
      end else
      begin
        s :='通知';
        Title:=FormatDay(OrderDay)+'到货提醒';
        Content:='您<'+FormatDay(OrderDay)+'>订的订单（'+Content+'），应已于<'+FormatDay(ArrDay)+'>送达，请及时到货确认。';

        //Content:='您'+FormatDay(OrderDay)+'的订单，请及时进行到货确认，如果已经到货确认，忽略此消息，谢谢合作！ ';
      end;
    end;
    result:=true;
  end;
end;

constructor TParamsSyncFactory.Create;
begin
  inherited;
  OrderQry:=TZQuery.Create(nil);
  UsedDateQry:=TZQuery.Create(nil);
  //读取自动到货的标记，默认不启用
  AUTO_DOWN_ORDER:=trim(ReadConfig('PARAMS','AUTO_DOWN_ORDER','0'))='1';  
end;

destructor TParamsSyncFactory.Destroy;
begin
  OrderQry.Free;
  UsedDateQry.Free;
  inherited;
end;

function TParamsSyncFactory.DoShopDownOrderMessage: integer;
var
  iRet,vCount: integer;
  mid,s,Title,Content,ISSUE_DATE: string; //消息单据号
  CurDay,ArrDay,EndDay,OrderDay,Str,COMM_ID: string; //启用日期
begin
  result:=-1;
  try
    vCount:=0;
    CurDay:=FormatDatetime('YYYYMMDD',Date());
    EndDay:=FormatDatetime('YYYY-MM-DD',Date()+7); //有效日期格式化
    GetINDEOrderList;
    OrderQry.First;
    while not OrderQry.Eof do
    begin
      mid:= TBaseSyncFactory.newid(RimParam.ShopID);
      ArrDay:=trim(OrderQry.FieldByName('ARR_DATE').AsString);
      OrderDay:=trim(OrderQry.FieldByName('CRT_DATE').AsString);
      if ArrDay=FormatDatetime('YYYYMMDD',Date()) then //当天日期
        ISSUE_DATE:=FormatDatetime('YYYYMMDD',Date())  
      else
        ISSUE_DATE:=OrderDay;
      Content:='品种：'+InttoStr(OrderQry.fieldbyName('PZSUM').asInteger)+'，'+
               '数量：'+FormatFloat('#0.00',OrderQry.fieldbyName('QTY_SUM').asFloat)+'条，'+
               '总金额：'+FormatFloat('#0.00',OrderQry.fieldbyName('AMT_SUM').asFloat)+' ';
      
      if CheckMessageExists(OrderDay,ArrDay, Title, s, Content,COMM_ID) then
      begin
        BeginTrans;
        try
          str:='insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP)'+
               ' values('+RimParam.TenID+','''+mid+''','''+RimParam.ShopID+''',1,1,''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GetLastError);

          str:='insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP)'+
               ' values('+RimParam.TenID+','''+mid+''',''0'','+ISSUE_DATE+','+RimParam.TenID+','''+s+''',''system'','''+Title+''','''+Content+''','''+EndDay+''','''+COMM_ID+''',''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GetLastError);
          CommitTrans;
          Inc(vCount);
        except
          on E:Exception do
          begin
            RollbackTrans;
            Raise;
          end;
        end;
      end; 
      OrderQry.Next;
    end; //while not OrderQry.Eof do
    result:=vCount;
  except
    on E:Exception do
    begin
      Raise;
    end;
  end;
end;

function TParamsSyncFactory.DownOrderMessage: integer;
var
  iRet: integer; //返回运行消息 
  ErrorFlag: Boolean;
  SaveLog: TStringList;
begin
  result:=-1;
  {------开始日志生成消息------}
  BeginLogReport;
  try
    DBLock(true); //锁定数据库链接

    //返回R3的企业启用日期：
    GetR3UsedDateList;
    //返回R3的生成消息的ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      FRunInfo.ErrorStr:='<'+PlugInID+'> <'+RimParam.TenID+'> 没有可生成到货确认消息门店(退出)！';
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

        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          BeginLogShopReport; //开始门店日志

          //开始生成到货消息
          try
            iRet:=DoShopDownOrderMessage; //返回生成消息数
            AddBillMsg('到货消息',iRet);
          except
            on E:Exception do
            begin
              ErrorFlag:=true;
              AddBillMsg('到货消息',-1,E.Message);
            end;
          end;
          EndLogShopReport(true,ErrorFlag); //写本门店总体生成情况
        end else
          EndLogShopReport(False);  //写本门店对应不上日志
      except
        on E:Exception do
        begin
          WriteLogFile(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
    result:=1;
  finally
    DBLock(False);
    WriteToReportLogFile('到货消息');  //输出到文本日志
  end;
end;

function TParamsSyncFactory.DownRimParamsToR3: Boolean;
var
  IsRun: Boolean;
  iRet: integer;
  CustCnd,UpCnd,Msg: string; //门店上报更新
  Str,COM_ID,CHANGE_PRICE,CHGCnd: string;
begin
  Str:='';
  UpCnd:='';
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
    ' and A.RELATI_ID in (select C.TENANT_ID from RM_CUST B,CA_SHOP_INFO C where B.LICENSE_CODE=C.LICENSE_CODE '+CustCnd+' and ('+CHGCnd+'))';

  try
    BeginLogReport; //开始上报日志
    try
      if COM_ID<>'' then
      begin
        IsRun:=ExecTransSQL(Str,iRet,'下载Rim零售户限价限量出错：');
        if IsRun and (SyncType<>3) then //批量才写日志
        begin
          FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick;  //总执行多少秒
          Msg:='---- RSP调度【Rim零售户限价量参数】 同步：'+InttoStr(iRet)+'笔，运行'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'秒-------';
        end;
      end else
      begin
        if SyncType<>3 then Msg:='---- RSP调度【Rim零售户限价量参数】 出错: 没找到对应Rim.COM_ID！-------'; //写入[REPORT]
        WriteLogFile('<Rim零售户限价量参数> 出错: 没找到对应Rim.COM_ID！'); 
      end;
    except
      on E:Exception do
      begin
        Msg:='---- RSP调度【Rim零售户限价量参数】 同步出错（'+E.Message+'）！-------';
        WriteLogFile(Msg);
      end;    
    end;
  finally
    WriteDownLoadToReportLog(Msg); //写入REPORT文件
  end;
end;

function TParamsSyncFactory.FormatDay(InDay: string): string;
var
  CurValue: string;
begin
  result:=Copy(InDay,1,4)+'年';
  CurValue:=Copy(InDay,5,2);
  CurValue:=InttoStr(StrtoIntDef(CurValue,0)); //月份
  result:=result+CurValue+'月';
  CurValue:=Copy(InDay,7,2);
  CurValue:=InttoStr(StrtoIntDef(CurValue,0)); //天数
  result:=result+CurValue+'日';
end;

function TParamsSyncFactory.GetINDEOrderList: Boolean;
var
  iRet: integer;
  Str,NearDate,UseDate,CurDay: string;
begin
  result:=False;
  CurDay:=FormatDatetime('YYYYMMDD',Date());
  NearDate:=FormatDatetime('YYYYMMDD',Date()-7); //获取最近7天的订单日期
  //根据系统启用日期判断
  if UsedDateQry.Active then
  begin
    if UsedDateQry.Locate('TENANT_ID',trim(RimParam.TenID),[]) then
    begin
      UseDate:=trim(UsedDateQry.FieldbyName('USING_DATE').AsString);
      UseDate:=FormatDatetime('YYYYMMDD',FnTime.fnStrtoDate(UseDate));
    end;
  end;
  if trim(UseDate)='' then UseDate:=FormatDatetime('YYYYMMDD',Date());  //启用默认今天
  if NearDate<UseDate then NearDate:=UseDate; //对比比启用日期还小则从启用日期开始取消息

  try                   
    Str:='select A.ARR_DATE,A.CRT_DATE,sum(B.QTY_ORD) as QTY_SUM,sum(B.AMT) as AMT_SUM,Count(distinct B.ITEM_ID) as PZSUM '+
         ' from RIM_SD_CO A,RIM_SD_CO_LINE B where A.CO_NUM=B.CO_NUM and A.COM_ID='''+RimParam.ComID+''' and A.CUST_ID='''+RimParam.CustID+''' and '+
         ' A.STATUS in (''05'',''06'') and A.ARR_DATE<='''+CurDay+''' and A.ARR_DATE>='''+NearDate+''' and '+
         ' not A.CO_NUM in(select COMM_ID from STK_STOCKORDER where TENANT_ID='+RimParam.TenID+' and COMM_ID is not null and COMM not in (''02'',''12'') )'+
         ' Group by A.ARR_DATE,A.CRT_DATE ';
    OrderQry.close;
    OrderQry.SQL.Text:=Str;
    Open(OrderQry);
    result:=OrderQry.Active;
  except
    on E:Exception do
    begin
      Raise;
    end;
  end;
end;

function TParamsSyncFactory.GetR3UsedDateList: Boolean;
var
  Str: string;
begin
  result:=False;
  //供应链关系表[返回传入企业所有下级企业]:
  Str:=
    'select A.TENANT_ID as TENANT_ID,A.VALUE as USING_DATE from SYS_DEFINE A,CA_RELATIONS R '+
    ' where A.TENANT_ID=R.RELATI_ID and R.RELATION_ID=1000006 and A.COMM not in (''02'',''12'') and A.DEFINE=''USING_DATE'' and '+
    ' R.COMM not in (''02'',''12'') and R.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' ';

  UsedDateQry.Close;
  UsedDateQry.SQL.Text:=Str;
  result:=Open(UsedDateQry);
end;

procedure TParamsSyncFactory.WriteDownLoadToReportLog(LogMsg: string);
var
  LogFile: string;
  LogFileList: TStringList;
begin
  if SyncType=3 then Exit; //前台执行不写日志
  try
    LogFile := ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT'+FormatDatetime('YYYYMMDD',Date())+'.log';
    LogFileList:=TStringList.Create;
    if FileExists(LogFile) then
    begin
      LogFileList.LoadFromFile(LogFile);
      LogFileList.Add('    ');
    end;
    LogFileList.Add(LogMsg);
    LogFileList.SaveToFile(LogFile);
  finally
    LogFileList.Free;
  end;
end;

end.















