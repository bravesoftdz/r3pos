{------------------------------------------------------------------------------
  RIM插件共用函数、基础类、数据结构

  
 ------------------------------------------------------------------------------}
unit uRimSyncFactory;

interface

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  Windows,
  Forms,
  zBase,
  uBaseSyncFactory;

//第三方系统数据对接的基类
type
  TRimSyncFactory=class(TBaseSyncFactory)
  private
    FMaxStmp: string;    //最大时间戳
    FUpMaxStmp: string;  //更新最大时间戳
    FSyncType: integer;  //同步类型
    FLogInfo: TLogShopInfo; //门店日志
    procedure SetMaxStmp(const Value: string);
    procedure SetSyncType(const Value: Integer);
  public
    R3ShopList: TZQuery;  //上报门店List
    RimParam: TRimParams; //上报参数记录
    constructor Create; override;
    destructor Destroy;override;

    function GetR3ToRimUnit_ID(iDbType:integer; UNIT_ID: string): string;     //返回单位换算
    // 同步类型
    function GetSyncType: integer; //同步类型   
    //1、返回RIM_R3_NUM表的上次时间戳和当前最大时间戳:
    function GetMaxNUM(BillType, COM_ID,CUST_ID, SHOP_ID: string): string;
    //2、返回Rim烟草公司ID(COM_ID):
    function GetRimCOM_ID(TENANT_ID: string): string;
    //4、返回Rim零售户CUST_ID:
    function GetRimCUST_ID(COM_ID,LICENSE_CODE: string): string;
    //5、返回Rim零售户CUST_ID及零售户所属的COM_ID:
    function SetRimORGAN_CUST_ID(const InTENANT_ID,InSHOP_ID: string; var InCOM_ID,InCUST_ID: string): Boolean;
    //6、返回上报的门店List
    function GetR3ReportShopList(var ShopList: TZQuery): Boolean;
    //7、返回当前门店一样许可证号的所有门店List
    function GetShop_IDS(TenID,LICENSE_CODE: string): string;
    //8、执行单向的连接库语句开启事务:
    function ExecTransSQL(SQL: string; var iRet: Integer; Msg: string=''): Boolean;  //返回是否事务是否执行成功

    //9、写上报日志
    procedure TreatLogFile(LogDir: string); //处理日志文件
    procedure BeginLogRun; virtual;  //开始上报
    procedure WriteLogRun(ReportName: string=''); virtual;  //结束上报
    procedure WriteToLogList(RelationFlag: Boolean; RunFlag: Boolean=False); overload;  //写入LogList
    procedure WriteToLogList(Msg: string; RelationFlag: Boolean; RunFlag: Boolean=False); overload;  //写入LogList
    //10、写RIM_BAL_LOG日志
    function WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,LogType,LogNote,LogStatus: string; USER_ID: string='auto'): Boolean;

    property MaxStmp: string read FMaxStmp write SetMaxStmp;              //最大时间戳
    property UpMaxStmp: string read FUpMaxStmp;                           //更新最大时间戳
    property SyncType: integer read FSyncType write SetSyncType;          //上报方式:（0: 调度执行； 3：前台传入执行)
    property LogInfo: TLogShopInfo read FLogInfo;
  end;

implementation




{ TRimSyncFactory }

 
constructor TRimSyncFactory.Create;
begin
  inherited;
  R3ShopList:=TZQuery.Create(nil);
  FLogInfo:=TLogShopInfo.Create;
  FLogInfo.LogKind:=LogKind; //日志方式
end;

destructor TRimSyncFactory.Destroy;
begin
  R3ShopList.Free;
  FLogInfo.Free;
  inherited;
end;

function TRimSyncFactory.GetSyncType: integer; //同步类型
begin
  result:=0;
  if (Params.FindParam('FLAG')<>nil) then
    FSyncType:=Params.FindParam('FLAG').AsInteger;
  result:=FSyncType;
  LogInfo.SyncType:=FSyncType;  
end;

function TRimSyncFactory.GetMaxNUM(BillType, COM_ID, CUST_ID, SHOP_ID: string): string;
var
  iRet: integer;
  Str,TimeStamp: string;
  Rs: TZQuery;
begin
  result:='';
  try
    case DbType of
     0: TimeStamp := 'convert(bigint,(convert(float,Convert(datetime,Convert(varchar(10),GetDate(),23)))-40542.0)*86400)';
     1: TimeStamp := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))';
     4: TimeStamp := '86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))';
     
     else TimeStamp := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
    end;

    Rs:=TZQuery.Create(nil);       // GetTimeStamp(DbType)
    Rs.SQL.Text:='select MAX_NUM,'+TimeStamp+' as UPMAX_NUM  from RIM_R3_NUM where COM_ID='''+COM_ID+''' and CUST_ID='''+Cust_ID+''' and TYPE='''+BillType+''' and TERM_ID='''+SHOP_ID+''' ';
    if Open(Rs) then
    begin
      result:=trim(Rs.Fields[0].AsString);
      FUpMaxStmp:=trim(Rs.Fields[1].AsString);
    end;
    if result='' then result:='0';
    if Rs.IsEmpty then
    begin
      str:='insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values ('''+COM_ID+''','''+Cust_ID+''','''+BillType+''','''+SHOP_ID+''',''0'')';
      if ExecSQL(Pchar(str),iRet)<>0 then Raise Exception.Create('RIM_R3_NUM执行插入初值错误！（'+str+'）');

      //重新在取一次：最大时间戳：
      Rs.Close;                      // GetTimeStamp(DbType)
      Rs.SQL.Text:='select MAX_NUM,'+TimeStamp+' as UPMAX_NUM  from RIM_R3_NUM where COM_ID='''+COM_ID+''' and CUST_ID='''+Cust_ID+''' and TYPE='''+BillType+''' and TERM_ID='''+SHOP_ID+''' ';
      if Open(Rs) then
      begin
        result:=trim(Rs.Fields[0].AsString);
        FUpMaxStmp:=trim(Rs.Fields[1].AsString);
      end;
    end;
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.GetR3ReportShopList(var ShopList: TZQuery): Boolean;
var
  Str: string;
  IsFlag: Boolean;
begin
  result:=False;
  if SyncType=3 then  //前台门店终端提交上报
  begin
    //(企业名称,门店ID,门店名称,门店许可证号):
    Str:='select TE.TENANT_ID,TE.TENANT_NAME,SH.SHOP_ID,SH.SHOP_NAME,SH.LICENSE_CODE from CA_SHOP_INFO SH,CA_TENANT TE '+
         ' where SH.TENANT_ID=TE.TENANT_ID and  SH.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' and '+
         ' SH.SHOP_ID='''+Params.ParamByName('SHOP_ID').AsString+''' ';
  end else //Rsp调度上报：烟草公司企业
  begin
    //供应链关系表[返回传入企业所有下级企业]:
    Str:='select T.TENANT_ID,T.TENANT_NAME from CA_TENANT T,CA_RELATIONS R '+
         ' where T.TENANT_ID=R.RELATI_ID and T.COMM not in (''02'',''12'') and R.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+
         ' and R.RELATION_ID=1000006';

    //(企业名称,门店ID,门店名称,门店许可证号):
    Str:='select TE.TENANT_ID,TE.TENANT_NAME,SH.SHOP_ID,SH.SHOP_NAME,SH.LICENSE_CODE '+
         ' from CA_SHOP_INFO SH,('+Str+') TE where SH.TENANT_ID=TE.TENANT_ID order by TE.TENANT_ID,SH.SHOP_ID ';
  end;

  ShopList.Close;
  ShopList.SQL.Text:=Str;
  result:=Open(ShopList);
end;

function TRimSyncFactory.SetRimORGAN_CUST_ID(const InTENANT_ID, InSHOP_ID: string; var InCOM_ID,InCUST_ID: string): Boolean;
var
  str: string;
  Rs: TZQuery;
begin
  result:=False;
  InCOM_ID:='';
  InCUST_ID:='';
  try
    Rs:=TZQuery.Create(nil);
    try
      Rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B '+
                   ' where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+InTENANT_ID+' and B.SHOP_ID='''+InSHOP_ID+''' ';
      if Open(Rs) then
      begin
        InCOM_ID:=trim(Rs.fieldbyName('COM_ID').AsString);
        InCUST_ID:=trim(Rs.fieldbyName('CUST_ID').AsString);
      end;
    except
      on E:Exception do
      begin
        str:='企业ID('+InTENANT_ID+'),门店ID('+InSHOP_ID+')，返回Rim的供应商ID、零售户ID出错：'+E.Message;
        Raise Exception.Create(Pchar(str));
      end;
    end;
  finally
    rs.Free;
  end;
end;

//2011.05.25 获取Rim零售户IDCust_ID
function TRimSyncFactory.GetRimCUST_ID(COM_ID,LICENSE_CODE: string): string;
var
  Rs: TZQuery;
begin
  result:='';
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select CUST_ID from RM_CUST where COM_ID='''+COM_ID+''' and LICENSE_CODE='''+LICENSE_CODE+'''';
    if Open(Rs) then
      result:=trim(Rs.Fields[0].AsString);
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.GetRimCOM_ID(TENANT_ID: string): string;
var
  TenID: string;
  Rs: TZQuery;
begin
  result:='';
  TenID:='';
  try
    try
      Rs:=TZQuery.Create(nil);
      if SyncType=3 then  //前台门店终端提交上报[先将门店的企业ID 根据供应链ID换成 烟草公司的企业ID]
      begin
        Rs.Close;
        Rs.SQL.Text:='select TENANT_ID from CA_RELATIONS where RELATION_ID=1000006 and RELATI_ID ='+TENANT_ID+' ';
        if Open(Rs) then
          TenID:=trim(Rs.Fields[0].AsString);
        if TenID='' then Raise Exception.Create('传入[零售户]企业ID:('+TENANT_ID+') 没有加盟烟草企业');
      end else
        TenID:=TENANT_ID;  
      Rs.Close;
      Rs.SQL.Text:='select A.ORGAN_ID as ORGAN_ID from RIM_PUB_ORGAN A,CA_TENANT B where B.LOGIN_NAME=A.ORGAN_CODE and B.TENANT_ID='+TenID+' ';
      if Open(Rs) then
        result:=trim(Rs.Fields[0].AsString)
    except
      on E:Exception do
      begin
        Raise Exception.Create('传入R3企业ID:('+TENANT_ID+') 返回Rim烟草公司ID出错：'+E.Message);
      end;
    end;
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.WriteToRIM_BAL_LOG(LICENSE_CODE, CustID, LogType, LogNote, LogStatus, USER_ID: string): Boolean;
var
  str: string;
  iRet: integer;
begin
  sleep(1);
  Str:='insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values '+
       '('''+LICENSE_CODE+Formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''','''+LogType+''','''+CustID+''','''+Formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''','''+LogNote+''',''auto'','''+LogStatus+''')' ;
  if ExecSQL(Pchar(Str),iRet)<>0 then
   Raise Exception.Create('写日志执行失败:'+PlugIntf.GetLastError);  
end;

procedure TRimSyncFactory.SetSyncType(const Value: Integer);
begin
  FSyncType := Value;
end;

procedure TRimSyncFactory.SetMaxStmp(const Value: string);
begin
  FMaxStmp := Value;
end;

procedure TRimSyncFactory.TreatLogFile(LogDir: string);
  function GetFileSize(const FileName: String): LongInt;
  var SearchRec: TSearchRec;
  begin
    try
      if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec)=0 then
        Result:=(SearchRec.Size div 1024) 
      else
        Result:=-1;
    finally
      SysUtils.FindClose(SearchRec);
    end;
  end;
var
  i,KeepDay: integer;
  LogFile,NewFile: string;
begin
  //默认保留最近1个月的日志文件
  if DayOfWeek(Date())=5 then  //周四判断删除文件
  begin
    KeepDay:=KeepLogDay;
    if KeepDay<7 then KeepDay:=7; //至少保留7天
    try
      for i:=KeepDay to 100 do
      begin
        LogFile:=LogDir+FormatDatetime('YYYYMMDD',Date()-i)+'.log';
        if FileExists(LogFile) then
          DeleteFile(Pchar(LogFile));
      end;
    except
    end;
  end;

  //判断文件大小
  LogFile:=LogDir+FormatDatetime('YYYYMMDD',Date())+'.log';
  if FileExists(LogFile) then
  begin
    if GetFileSize(LogFile)> 1024 then
    for i:=1 to 100 do
    begin
      NewFile:=LogDir+FormatDatetime('YYYYMMDD',Date())+'_'+InttoStr(i)+'.log';
      if not FileExists(NewFile) then
        RenameFile(LogFile, NewFile);
    end;
  end;
end;

procedure TRimSyncFactory.WriteLogRun(ReportName: string);
var
  i,KeepDay: integer;
  LogDir,LogFile,Str,ReportTitle: string;
  LogFileList: TStringList;
begin
  if SyncType=3 then Exit; //前台传入执行不日志

  LogDir:=ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT';
  TreatLogFile(LogDir); //处理日志文件

  if trim(ReportName)='' then ReportTitle:=' 开始' else ReportTitle:='【'+ReportName+'】 开始';
  FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick; //总执行多少秒
  LogFile := LogDir+FormatDatetime('YYYYMMDD',Date())+'.log';
  try
    try
      //输出日志:
      ReportTitle:=ReportTitle+':'+FRunInfo.BegTime+'; 总数:'+inttoStr(FRunInfo.AllCount);
      if FRunInfo.RunCount>0   then ReportTitle:=ReportTitle+' 成功：'+inttoStr(FRunInfo.RunCount);
      if FRunInfo.ErrorCount>0 then ReportTitle:=ReportTitle+'，异常：'+inttoStr(FRunInfo.ErrorCount);
      if FRunInfo.NotCount>0   then ReportTitle:=ReportTitle+'，无对应许可证数：'+inttoStr(FRunInfo.NotCount);

      LogFileList:=TStringList.Create;
      if FileExists(LogFile) then
      begin
        LogFileList.LoadFromFile(LogFile);
        LogFileList.Add('    ');
      end;

      if SyncType=3 then  //客户端单个门店日志
        LogFileList.Add('---- <R3终端> '+ReportTitle+' ------')
      else
        LogFileList.Add('---- <Rsp调度> '+ReportTitle+' -------');
      for i:=0 to LogList.Count-1 do
      begin
        LogFileList.Add(LogList.Strings[i]);
      end;
      LogFileList.Add('--- [结束] <运行：'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'>秒 时间戳<'+UpMaxStmp+'><Trans='+BooltoStr(TWO_PHASE_COMMIT)+'> ----');
      LogFileList.Add('  ');
      LogFileList.SaveToFile(LogFile);
    finally
      LogFileList.Free;
    end;
  except
  end;
end;

procedure TRimSyncFactory.BeginLogRun;
begin
  if SyncType=3 then Exit; //前台传入执行不日志

  LogList.Clear;
  FRunInfo.BegTime:=GetTickTime;
  FRunInfo.BegTick:=GetTickCount;
  FRunInfo.AllCount:=0;
  FRunInfo.RunCount:=0;
  FRunInfo.NotCount:=0;
  FRunInfo.ErrorCount:=0;
  FRunInfo.ErrorStr:=''
end;


function TRimSyncFactory.GetShop_IDS(TenID,LICENSE_CODE: string): string;
var
  Rs: TZQuery;
  ReStr: string;
begin
  result:=''' ''';
  try
    ReStr:='';
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select SHOP_ID from CA_SHOP_INFO where TENANT_ID='+TenID+' and LICENSE_CODE='''+LICENSE_CODE+''' ';
    if Open(Rs) then
    begin
      Rs.First;
      while not Rs.Eof do
      begin
        if ReStr='' then
          ReStr:=''''+Rs.fieldbyName('SHOP_ID').AsString+''''
        else
          ReStr:=ReStr+','''+Rs.fieldbyName('SHOP_ID').AsString+'''';
        Rs.Next;
      end;
      result:=ReStr;
    end;
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.ExecTransSQL(SQL: string; var iRet: Integer; Msg: string): Boolean;
begin
  result:=False;
  iRet:=-1;
  try
    BeginTrans;  //开始事务
    if ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create(Msg+PlugIntf.GetLastError); 
    CommitTrans; //提交事务
    result:=true;
  except
    RollbackTrans;
    Raise
  end;
end;

procedure TRimSyncFactory.WriteToLogList(RelationFlag, RunFlag: Boolean);
begin
  if SyncType=3 then Exit; //前台传入执行不日志
  
  if RelationFlag then //R3门店与Rim零售户有对应上
  begin
    if R3ShopList.RecordCount=1 then
      LogInfo.SetLogMsg(LogList)  //添加本次执行日志
    else
      LogInfo.SetLogMsg(LogList,R3ShopList.RecNo); //添加本次执行日志

    if RunFlag then
      Inc(FRunInfo.ErrorCount)  //执行异常！
    else
      Inc(FRunInfo.RunCount);   //执行成功！
  end else
  begin
    Inc(FRunInfo.NotCount);  //对应不上
    if R3ShopList.RecordCount=1 then
      LogList.Add('   门店<'+RimParam.ShopName+'>许可证号<'+RimParam.LICENSE_CODE+'>在Rim系统中没对应上')
    else
      LogList.Add('  ('+InttoStr(R3ShopList.RecNo)+')门店<'+RimParam.TenName+'>许可证号<'+RimParam.LICENSE_CODE+'> 在Rim系统中没对应上零售户！');
  end;
end;

procedure TRimSyncFactory.WriteToLogList(Msg: string; RelationFlag: Boolean; RunFlag: Boolean);
begin
  if SyncType=3 then Exit; //前台传入执行不日志
  
  if RelationFlag then //有对应Rim许可证号:
  begin
    if RunFlag then
      Inc(FRunInfo.ErrorCount)  //执行异常！
    else
      Inc(FRunInfo.RunCount);   //执行成功！
  end else
    Inc(FRunInfo.NotCount);    //未对应许可证号！

  LogList.Add('  '+Msg);
end;

function TRimSyncFactory.GetR3ToRimUnit_ID(iDbType: integer; UNIT_ID: string): string;
begin
  case iDbType of
   0,4:
    begin
      Result:='(case when '+UNIT_ID+'=''13F817A7-9472-48CF-91CD-27125E077FEB'' then ''02'' '+
                   ' when '+UNIT_ID+'=''95331F4A-7AD6-45C2-B853-C278012C5525'' then ''03'' '+
               ' when '+UNIT_ID+'=''93996CD7-B043-4440-9037-4B82BB5207DA'' then ''04'' '+
               ' else ''01'' end)';
    end;
   1:
    begin
      Result:=' DECODE('+UNIT_ID+',''13F817A7-9472-48CF-91CD-27125E077FEB'',''02'',''95331F4A-7AD6-45C2-B853-C278012C5525'',''03'',''93996CD7-B043-4440-9037-4B82BB5207DA'',''04'',''01'')';
    end;
  end;
   {  Result:='(case when '+UNIT_ID+'=''13F817A7-9472-48CF-91CD-27125E077FEB'' then ''02'' '+
               ' when '+UNIT_ID+'=''95331F4A-7AD6-45C2-B853-C278012C5525'' then ''03'' '+
               ' when '+UNIT_ID+'=''93996CD7-B043-4440-9037-4B82BB5207DA'' then ''04'' '+
               ' else ''01'' end)';
  }
end;
 

end.
