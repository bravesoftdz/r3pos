{-------------------------------------------------------------------------------
  //消息同步
 ------------------------------------------------------------------------------}

unit uMsgFactory;

interface

uses
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TMsgSyncFactory=class(TRimSyncFactory)
  private
    AUTO_DOWN_ORDER: Boolean;  //自动到货确认，默认不自动到货
    //启用日期
    UsedDateQry: TZQuery;
    //下载订单表头
    OrderQry: TZQuery;

    //返回同步类型
    function GetSyncType: integer; override; //同步类型     

    //同步会员：tid 企业号
    function SyncMessage: Boolean;

    //格式日期
    function FormatDay(InDay: string): string;
    //返回R3企业启用日期列表
    function GetR3UsedDateList: Boolean;
    //返回一个门店的订单
    function GetINDEOrderList: Boolean;
    //判断是否已存在，并返回消息标题
    function CheckMessageExists(const ArrDay: string; var Title, s, Content: string): Boolean;
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

{ TMsgSyncFactory }

constructor TMsgSyncFactory.Create;
begin
  inherited;
  OrderQry:=TZQuery.Create(nil);
  UsedDateQry:=TZQuery.Create(nil);
end;

destructor TMsgSyncFactory.Destroy;
begin
  OrderQry.Free;
  UsedDateQry.Free;
  inherited;
end;

//tid 企业号; sid 门店号
function TMsgSyncFactory.SyncMessage: Boolean;
var
  iRet:integer;
  str,s,mid: string;
  rs: TZQuery;
begin
  result:=False;
  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    case DbType of
    4:
     rs.SQL.Text :=
       'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and '+
       '('+
       ' (POSSTR(RECEIVER,'''+RimParam.CustID+','')>0) or ('+
       ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+RimParam.CustID+''') or slsman_id is null or slsman_id='''') '+
       ' and (saleorg_id in (select saleorg_id from rm_cust where cust_id='''+RimParam.CustID+''') or saleorg_id is null or saleorg_id='''') '+       ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+RimParam.CustID+''') or sale_center_id is null or sale_center_id='''') '+       ' and (receiver is null or receiver =''''  or receiver ='','') '+       ' )'+       ')'+       'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
       'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+RimParam.ShopID+''' and B.TENANT_ID='+RimParam.TenID+' and B.COMM_ID=A.MSG_ID)';
    1:
     rs.SQL.Text :=
       'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and '+
       '('+
       ' (INSTR(RECEIVER,'''+RimParam.CustID+','')>0) or ('+
       ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+RimParam.CustID+''') or slsman_id is null or slsman_id='''') '+
       ' and ( saleorg_id in (select saleorg_id from rm_cust where cust_id='''+RimParam.CustID+''') or saleorg_id is null or saleorg_id='''') '+       ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+RimParam.CustID+''') or sale_center_id is null or sale_center_id='''') '+       ' and (receiver is null or receiver =''''  or receiver ='','') '+       ' )'+
       ')'+
       'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
       'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+RimParam.ShopID+''' and B.TENANT_ID='+RimParam.TenID+' and B.COMM_ID=A.MSG_ID)';
    end;
    if Open(Rs) then
    begin
      rs.First;
      while not rs.Eof do
      begin
        BeginTrans;
        try
          mid:= TBaseSyncFactory.newid(RimParam.ShopID);
          str:='insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP) '+
               'values('+RimParam.TenID+','''+mid+''','''+RimParam.ShopID+''',1,1,''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(str),iRet) <>0 then Raise Exception.Create(GPlugIn.GetLastError);

          if rs.Fields[1].asString='01' then
             s := '促销信息'
          else
          if rs.Fields[1].asString='02' then
             s := '广告信息'
          else
          if rs.Fields[1].asString='03' then
             s := '货源信息'
          else
          if rs.Fields[1].asString='04' then
             s := '新品信息'
          else
          if rs.Fields[1].asString='05' then
             s := '通知'
          else
          if rs.Fields[1].asString='99' then
             s := '到货通知'
          else
             s := '公告';
          case DbType of
           4:str :=
              'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
              'select '+RimParam.TenID+','''+mid+''',''0'',int(USE_DATE),'+RimParam.TenID+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(DbType)+
              ' from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
           1:str :=
              'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
              'select '+RimParam.TenID+','''+mid+''',''0'',to_number(USE_DATE),'+RimParam.TenID+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(DbType)+
              ' from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
          end;
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          CommitTrans;
        except
          on E:Exception do
          begin
            RollbackTrans;
            WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'13','下载消息错误！','02'); //写日志
            Raise
          end;
        end;
        rs.Next;
      end;
    end;
    result:=true;
  finally
    rs.Free;
  end;
end;

function TMsgSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  result:=-1;
  PlugInID:='803';
  {------初始化参数------}
  PlugIntf:=GPlugIn;
  //1、返回数据库类型
  GetDBType;
  //2、还原ParamsList的参数对象
  Params.Decode(Params, InParamStr);
  GetSyncType; //返回同步类型标记
  if SyncType=3 then //前台传入调用
  begin
    try
      DBLock(true);
      if Params.FindParam('SHOP_ID')=nil then Params.ParambyName('SHOP_ID').asString := Params.ParambyName('TENANT_ID').asString+'0001';
      RimParam.TenID  :=trim(Params.ParambyName('TENANT_ID').asString);   //R3企业ID (Field: TENANT_ID)
      RimParam.ShopID :=trim(Params.ParambyName('SHOP_ID').asString);     //R3门店ID (Field: SHOP_ID)
      SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID);  //传入R3门店ID,返回RIM的烟草公司ComID,零售户CustID;
      if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
      begin
        SyncMessage;
        result:=0;
      end;
    finally
      DBLock(False); 
    end;
  end else  //Rsp调度执行
  begin
    DownOrderMessage;
  end;
end;

function TMsgSyncFactory.GetSyncType: integer;
begin
  result:=0;
  SyncType:=0;
  if (Params.FindParam('SHOP_ID')<>nil) then
  begin
    if Length(Params.FindParam('SHOP_ID').AsString)>10 then
      SyncType:=3;
  end;
  result:=SyncType;
  ShopLog.SyncType:=result;
end;

function TMsgSyncFactory.FormatDay(InDay: string): string;
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

function TMsgSyncFactory.GetR3UsedDateList: Boolean;
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

function TMsgSyncFactory.GetINDEOrderList: Boolean;
var
  iRet: integer;
  Str,NearDate,UseDate,CurDay: string;
begin
  result:=False;
  CurDay:=FormatDatetime('YYYYMMDD',Date());
  NearDate:=FormatDatetime('YYYYMMDD',Date()-7); //获取最近7天的订单日期
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
    Str:='select distinct ARR_DATE,CRT_DATE from RIM_SD_CO where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and '+
         ' STATUS in (''05'',''06'') and ARR_DATE<='''+CurDay+''' and ARR_DATE>='''+NearDate+''' and '+
         ' not CO_NUM in(select COMM_ID from STK_STOCKORDER where TENANT_ID='+RimParam.TenID+' and COMM_ID is not null and COMM not in (''02'',''12'') )'+
         ' order by ARR_DATE ';
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

function TMsgSyncFactory.CheckMessageExists(const ArrDay: string; var Title, s, Content: string): Boolean;
var
  Qry: TZQuery;
  NotExist: Boolean;
  CurDay,COMM_ID: string;  
begin
  //1、先判断今天是否有生成消息；2、没有生成消息则生成消息相关:Title、Source、Content;
  result:=False;
  NotExist:=False;
  CurDay:=FormatDatetime('YYYYMMDD',Date()); //今天日期格式化
  COMM_ID:='AUTODOWN'+ArrDay+'_'+CurDay;
  Qry:=TZQuery.Create(nil);
  try
    Qry.SQL.Text:=
      'select count(*) as ReSum from MSC_MESSAGE A,MSC_MESSAGE_LIST B '+
      ' where A.TENANT_ID=B.TENANT_ID and A.MSG_ID=B.MSG_ID and A.TENANT_ID='+RimParam.TenID+' and B.SHOP_ID='''+RimParam.ShopID+''' and '+
      ' A.ISSUE_DATE='+CurDay+' and A.END_DATE='''+CurDay+''' and A.COMM_ID='''+COMM_ID+''' ';
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
      Title:='到货提醒';
      Content:='您'+FormatDay(ArrDay)+'的订单，预计今天送达，请及时进行到货确认，谢谢合作！';
    end else
    begin
      if AUTO_DOWN_ORDER then
      begin
        s:='到货通知';
        Title:='自动到货提醒';
        Content:='您'+FormatDay(ArrDay)+'的订单，可能未进行手工到货确认，系统将进行自动到货确认，如果已经到货确认，忽略此信息，谢谢合作！ ';
      end else
      begin
        s := '通知';
        Title:='到货提醒';
        Content:='您'+FormatDay(ArrDay)+'的订单，请及时进行到货确认，如果已经到货确认，忽略此消息，谢谢合作！ ';
      end;
    end;
    result:=true;
  end;
end;

function TMsgSyncFactory.DoShopDownOrderMessage: integer;
var
  iRet,vCount: integer;
  mid,s,Title,Content: string; //消息单据号
  CurDay,ArrDay,OrderDay,Str,COMM_ID: string; //启用日期
begin
  result:=-1;
  try
    vCount:=0;
    CurDay:=FormatDatetime('YYYYMMDD',Date());
    GetINDEOrderList;
    OrderQry.First;
    while not OrderQry.Eof do
    begin
      mid:= TBaseSyncFactory.newid(RimParam.ShopID);
      ArrDay:=trim(OrderQry.FieldByName('ARR_DATE').AsString);
      OrderDay:=trim(OrderQry.FieldByName('CRT_DATE').AsString);
      COMM_ID:='AUTODOWN'+ArrDay+'_'+CurDay;
      if CheckMessageExists(ArrDay, Title, s, Content) then
      begin
        BeginTrans;
        try
          str:='insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP)'+
               ' values('+RimParam.TenID+','''+mid+''','''+RimParam.ShopID+''',1,1,''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GetLastError);

          str:='insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP)'+
               ' values('+RimParam.TenID+','''+mid+''',''0'','+OrderDay+','+RimParam.TenID+','''+s+''',''system'','''+Title+''','''+Content+''','''+CurDay+''','''+COMM_ID+''',''00'','+GetTimeStamp(DbType)+')';
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

function TMsgSyncFactory.DownOrderMessage: Integer;
var
  iRet: integer; //返回运行消息 
  ErrorFlag: Boolean; 
begin
  result:=-1;
  //读取自动到货的标记，默认不启用
  AUTO_DOWN_ORDER:=trim(ReadConfig('PARAMS','AUTO_DOWN_ORDER','0'))='1';

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


end.















