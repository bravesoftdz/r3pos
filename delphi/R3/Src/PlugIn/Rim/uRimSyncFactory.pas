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
  Dialogs,
  uBaseSyncFactory;

//第三方系统数据对接的基类
type
  TRimSyncFactory=class(TBaseSyncFactory)
  private
    FMaxStmp: string;     //最大时间戳
    FUpMaxStmp: string;   //更新最大时间戳
    FSyncType: integer;   //同步类型
    FShopLog: TLogShopInfo;  //门店日志
    FPlugInIdx: integer;
    procedure SetMaxStmp(const Value: string);
    procedure SetSyncType(const Value: Integer);
    procedure TreatLogFile(LogDir: string);
    procedure SetPlugInIdx(const Value: integer);
  public
    R3ShopList: TZQuery;  //上报门店List
    RimParam: TRimParams; //上报参数记录
    constructor Create; override;
    destructor Destroy;override;
    //返回是否上报：插件参数定义：是否上报;
    function GetPlugInRunFlag: Boolean;
    //返回R3与Rim缩放率的换算：
    function GetR3ToRimZoom_Rate(Bill_UNIT_ID: string; AliasTable: string=''): string;
    //返回R3转Rim单位的Unit_ID;
    function GetR3ToRimUnit_ID(iDbType:integer; UNIT_ID: string): string;     //返回单位换算
    //同步类型
    function GetSyncType: integer; virtual; //同步类型   
    //1、返回RIM_R3_NUM表的上次时间戳和当前最大时间戳:
    function GetMaxNUM(BillType, COM_ID,CUST_ID, SHOP_ID: string): string;
    //2、返回Rim烟草公司ID(COM_ID): [IsTobaccoFlag=true是烟草公司，不需要查询关系表]         
    function GetRimCOM_ID(TENANT_ID: string; IsTobaccoFlag: Boolean=False): string; virtual;
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
    //9、企业开始上报:
    procedure BeginLogReport; virtual;  //企业开始上报
    //10、企业上报后写入Log文件:
    procedure WriteToReportLogFile(ReportName: string=''); virtual;  //写入LogFile
    //11、门店开始上报:
    procedure BeginLogShopReport; virtual;  //门店开始上报
    //12、门店上报完成写Msg:
    procedure EndLogShopReport(RelationFlag: Boolean; RunFlag: Boolean=False); overload; //门店完成上报
    //13、门店上报完成写Msg:
    procedure EndLogShopReport(Msg: string; RelationFlag: Boolean; RunFlag: Boolean=False); overload; //门店完成上报
    //14、单据上报写Msg：vType: 1:表示成功; 0:表示错误;
    procedure AddBillMsg(BillName: string; iRect: integer; Msg: string='');  //一个单据上报
    //16、写RIM_BAL_LOG日志
    function WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,LogType,LogNote,LogStatus: string; USER_ID: string='auto'): Boolean;

    property MaxStmp: string read FMaxStmp write SetMaxStmp;              //最大时间戳
    property UpMaxStmp: string read FUpMaxStmp;                           //更新最大时间戳
    property SyncType: integer read FSyncType write SetSyncType;          //上报方式:（0: 调度执行； 3：前台传入执行)
    property ShopLog: TLogShopInfo read FShopLog;  //门店日志
    property PlugInIdx: integer read FPlugInIdx write SetPlugInIdx;  //产件的索引:Idx
  end;

implementation

{ TRimSyncFactory }
 
constructor TRimSyncFactory.Create;
begin
  inherited;
  FUpMaxStmp:='';
  R3ShopList:=TZQuery.Create(nil);
  FShopLog:=TLogShopInfo.Create;
  FShopLog.LogKind:=LogKind; //日志方式
end;

destructor TRimSyncFactory.Destroy;
begin
  R3ShopList.Free;
  FShopLog.Free;
  inherited;
end;

function TRimSyncFactory.GetSyncType: integer; //同步类型
begin
  result:=0;
  FSyncType:=0;
  if (Params.FindParam('FLAG')<>nil) then
    FSyncType:=Params.FindParam('FLAG').AsInteger;
  result:=FSyncType;
  FShopLog.SyncType:=result;  
end;

function TRimSyncFactory.GetMaxNUM(BillType, COM_ID, CUST_ID, SHOP_ID: string): string;
var
  iRet: integer;
  Str,TimeStamp: string;
  Rs: TZQuery;
begin
  result:='';
  Rs:=TZQuery.Create(nil);   
  try
    //返回当天0时0分0秒0刻的时间戳
    case DbType of
     0: TimeStamp:='convert(bigint,(convert(float,Convert(datetime,Convert(varchar(10),GetDate(),23)))-40542.0)*86400)';
     1: TimeStamp:='86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))';
     4: TimeStamp:='86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))';  
     else
        TimeStamp:='convert(bigint,(convert(float,getdate())-40542.0)*86400)';
    end;

    Rs.Close;
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
      if ExecSQL(Pchar(str),iRet)<>0 then Raise Exception.Create('RIM_R3_NUM初始化['+str+']错误:'+GetLastError);

      //重新时间戳：
      Rs.Close;
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
  Msg: string;
  Rs: TZQuery;
begin
  result:=False;
  InCOM_ID:='';
  InCUST_ID:='';
  try
    Rs:=TZQuery.Create(nil);
    try
      Rs.SQL.Text:=
         'select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B '+
         ' where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+InTENANT_ID+' and B.SHOP_ID='''+InSHOP_ID+''' ';
      if Open(Rs) then
      begin
        InCOM_ID:=trim(Rs.fieldbyName('COM_ID').AsString);
        InCUST_ID:=trim(Rs.fieldbyName('CUST_ID').AsString);
      end;
      Msg:=InCOM_ID;
    except
      on E:Exception do
      begin
        Raise Exception.Create(Pchar('传入<SHOP_ID='+InSHOP_ID+'> 返回Rim.COM_ID,CUST_ID出错：'+E.Message));
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

function TRimSyncFactory.GetRimCOM_ID(TENANT_ID: string; IsTobaccoFlag: Boolean): string;
var
  TenID: string;
  Rs: TZQuery;
begin
  result:='';
  TenID:='';
  try
    try
      Rs:=TZQuery.Create(nil);
      if (SyncType=3) and (IsTobaccoFlag=False) then  //前台门店终端提交上报[先将门店的企业ID 根据供应链ID换成 烟草公司的企业ID]
      begin
        Rs.Close;
        Rs.SQL.Text:='select TENANT_ID from CA_RELATIONS where RELATION_ID=1000006 and RELATI_ID ='+TENANT_ID+' ';
        if Open(Rs) then
          TenID:=trim(Rs.Fields[0].AsString);
        if TenID='' then Raise Exception.Create('传入<零售户>企业ID:('+TENANT_ID+') 没有加盟上级烟草企业');
      end else
        TenID:=TENANT_ID;  
      Rs.Close;
      Rs.SQL.Text:='select A.ORGAN_ID as ORGAN_ID from RIM_PUB_ORGAN A,CA_TENANT B where B.LOGIN_NAME=A.ORGAN_CODE and B.TENANT_ID='+TenID+' ';
      if Open(Rs) then
        result:=trim(Rs.Fields[0].AsString);
    except
      on E:Exception do
      begin
        if pos('传入<零售户>企业ID:',E.Message)>0 then
          Raise
        else
          Raise Exception.Create('传入<TENANT_ID='+TENANT_ID+'> 返回Rim烟草公司ID出错：'+E.Message);
      end;
    end;
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.WriteToRIM_BAL_LOG(LICENSE_CODE, CustID, LogType, LogNote, LogStatus, USER_ID: string): Boolean;
var
  str,LOG_SEQ,UserID,LogText: string;
  iRet: integer;
begin
  sleep(1);
  LOG_SEQ:=LICENSE_CODE+Formatdatetime('YYYYMMDDHHNNSSZZZ',now());
  LogText:=Copy(trim(LogNote),1,40);
  UserID:='auto';
  if SyncType=3 then USER_ID:='R3'; //终端执行日志
  Str:='insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values '+
       '('''+LOG_SEQ+''','''+LogType+''','''+CustID+''','''+Formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''','''+LogText+''','''+UserID+''','''+LogStatus+''')' ;
  if ExecSQL(Pchar(Str),iRet)<>0 then
   Raise Exception.Create('写日志执行失败:'+GetLastError);  
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

procedure TRimSyncFactory.BeginLogReport;
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

procedure TRimSyncFactory.WriteToReportLogFile(ReportName: string);
var
  i,KeepDay: integer;
  LogDir,LogFile,Str,ReportTitle: string;
  LogFileList: TStringList;
begin
  if SyncType=3 then Exit; //前台传入执行不日志
  if R3ShopList.Active then
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //总门店数

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
        LogFileList.Add('〖---- <R3终端> '+ReportTitle+' ----〗')
      else
        LogFileList.Add('〖---- <Rsp调度> '+ReportTitle+' ----〗');
      for i:=0 to LogList.Count-1 do
      begin
        LogFileList.Add(LogList.Strings[i]);
      end;
      ReportTitle:='〖---- [结束] <运行：'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'秒> ';
      if UpMaxStmp<>'' then
        ReportTitle:=ReportTitle+' <TIMESTAMP='+UpMaxStmp+'> ';
      if TWO_PHASE_COMMIT then
        ReportTitle:=ReportTitle+' <DBTran=TWO_COMMIT>'
      else
        ReportTitle:=ReportTitle+' <DBTran=SINGLE_COMMIT>';
      ReportTitle:=ReportTitle+'  ----〗';
      LogFileList.Add(ReportTitle);
      LogFileList.Add('  ');
      LogFileList.SaveToFile(LogFile);
    finally
      LogFileList.Free;
    end;
  except
  end;
end;

procedure TRimSyncFactory.BeginLogShopReport;
begin
  FShopLog.BeginLog(RimParam.ShopName);
end;

procedure TRimSyncFactory.EndLogShopReport(RelationFlag, RunFlag: Boolean);
var
  Msg: string;
begin
  if not RelationFlag then
  begin
    Msg:='门店<'+RimParam.ShopName+'>许可证号<'+RimParam.LICENSE_CODE+'>在Rim系统中没对应上';
    if PlugIntf.WriteLogFile(Pchar(LogHead+'['+Msg+']'))<>0 then Raise Exception.Create(GetLastError);
    //WriteLogFile(Msg); //写入Rsp日志面板
  end;

  if SyncType=3 then Exit; //前台传入执行不日志

  if RelationFlag then //R3门店与Rim零售户有对应上
  begin
    if R3ShopList.RecordCount=1 then
      FShopLog.SetLogMsg(LogList)  //添加本次执行日志
    else
      FShopLog.SetLogMsg(LogList,R3ShopList.RecNo); //添加本次执行日志

    if RunFlag then
      Inc(FRunInfo.ErrorCount)  //执行异常！
    else
      Inc(FRunInfo.RunCount);   //执行成功！
  end else
  begin
    Inc(FRunInfo.NotCount);  //对应不上
    if R3ShopList.RecordCount=1 then
      Msg:='     '+Msg
    else
      Msg:='  ('+InttoStr(R3ShopList.RecNo)+')门店<'+RimParam.TenName+'>许可证号<'+RimParam.LICENSE_CODE+'> 在Rim系统中没对应上零售户！';
    LogList.Add(Msg);
  end;
end;

procedure TRimSyncFactory.EndLogShopReport(Msg: string; RelationFlag, RunFlag: Boolean);
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

procedure TRimSyncFactory.AddBillMsg(BillName: string; iRect: integer; Msg: string);
begin
  if iRect=-1 then  //写日志Rsp日志面板
  begin
    WriteLogFile('<'+BillName+'>'+Msg);
  end;

  if SyncType<>3 then
    FShopLog.AddBillMsg(BillName,iRect);
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
  BeginTrans;  //开始事务
  try
    if ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create(Msg+GetLastError);
    CommitTrans; //提交事务
    result:=true;
  except
    RollbackTrans;
    Raise
  end;
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
end;

//'13F817A7-9472-48CF-91CD-27125E077FEB','盒'
//'95331F4A-7AD6-45C2-B853-C278012C5525','条'
//'93996CD7-B043-4440-9037-4B82BB5207DA','箱'

function TRimSyncFactory.GetR3ToRimZoom_Rate(Bill_UNIT_ID: string; AliasTable: string): string;
var
  AliasTab,Zoom_Rate: string;
begin
  if trim(AliasTable)<>'' then AliasTab:=trim(AliasTable)+'.';
  Zoom_Rate:=ParseSQL(DbType,'nvl('+AliasTab+'ZOOM_RATE,1.0)');
  case DbType of
   0,4:
    begin
      Result:='(case when '+Bill_UNIT_ID+'=''13F817A7-9472-48CF-91CD-27125E077FEB'' then 1.0 '+  //盒
                   ' when '+Bill_UNIT_ID+'=''95331F4A-7AD6-45C2-B853-C278012C5525'' then '+Zoom_Rate+' '+  //条
               ' when '+Bill_UNIT_ID+'=''93996CD7-B043-4440-9037-4B82BB5207DA'' then '+Zoom_Rate+' '+      //箱
               ' else 1.0 end)'; //支
    end;
   1:
    begin
      Result:=' DECODE('+Bill_UNIT_ID+',''13F817A7-9472-48CF-91CD-27125E077FEB'',1.0,''95331F4A-7AD6-45C2-B853-C278012C5525'','+Zoom_Rate+',''93996CD7-B043-4440-9037-4B82BB5207DA'','+Zoom_Rate+',1.0)';
    end;
  end;
end;

function TRimSyncFactory.GetPlugInRunFlag: Boolean;
var
  PlugInIDS: string;
begin
  result:=False;
  //读取控制的IDS
  PlugInIDS:=ReadConfig('PARAMS','PlugInID','0000000000000000000');   //启用哪些插件上报
  if PlugInIDS='' then PlugInIDS:='0000000000000000000';
  if Copy(PlugInIDS,PlugInIdx,1)='1' then
    result:=true;
end;

procedure TRimSyncFactory.SetPlugInIdx(const Value: integer);
begin
  FPlugInIdx := Value;
end;

end.
