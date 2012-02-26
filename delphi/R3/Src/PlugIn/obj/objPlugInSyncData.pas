unit objPlugInSyncData;

interface

uses
   SysUtils,Classes,Dialogs,ZBase,zIntf,Forms,zDataSet,DB,ZLogFile;

const
  //国家烟草供应链ID:1000006
  NT_RELATION_ID=1000006;

{== 插件上报序号ID==}
{ 1、上报库存
  2、上报销售汇总
  3、消息同步
  4、消费者
  5、Rim.WSDL的Url、用户名、密码;
  6、问卷调查
}

{== 日志类型: DEBUG_TYPE
    0:不是日志模式;
    1:全部门店上报直接打印在控制面板上;
    2:根据指定SHOP.Log内的门店上报直接打印在控制面板上;
    3:根据指定SHOP.Log内的门店上报写入Debug.log日志文件上;
 ==}


type
   TPlugParams=Record
     DEBUG_TYPE: Integer;     {==日志类型:0,1,2,3 ==}
     LOG_TYPE: Integer;       {==日志模式:0:上报执行情况不日志,1:有错误时打日志; 2：全部上报日志 ==}
     PlugInID: string;        {==插件ID;第1位:上报库存；第2位:上报销售汇总；第3位: 消息同步； 第4位：消费者 第5位：Rim.WSDL ==}
     VipUpload: Boolean;      {==消费者是否上报（默认上报）[1：上报，0表示不上报]==}
     Up_CUST_STATUS: string;  {==上报会员的状态[默认03：有效]==}
     USE_SM_CARD: Boolean;    {==消费者启用商盟卡才上报[默认会员卡商盟卡上报][1：上报，0表示不上报]==}
     AutoCreateCard: Boolean;   {==启用商盟卡时才能上报时是否自动创建卡号（根据电话号码作为卡号）[]==}
     USING_CUST_PSWD: Boolean;  {==是否启用密码==}
     RimUrl: string;            {==RimUrl==}
     TWO_PHASE_COMMIT: Boolean; {==是否启用分布式服务==}
   end;

{=== 服务端Obj调用 ===}
type
  TPlugInBase=class
  private
    FComID: string;    //烟草公司ID
    FCustID: string;   //零售户Cust_ID
    FLICENSE_CODE: string;  //烟草许可证
    FTenID: string;    //零售户企业ID
    FShopID: string;   //零售户门店ID
    FDBFactor: IdbHelp;
    FParams: TftParamList;
    FShortID: string;
    FDbType: integer;
    FMaxStmp: string;
    FUpMaxStmp: string;
    FLogMsg: string;
    FPrcdMsg: string;
    FRunState: Boolean;
    FPlugInID: Integer;
    procedure SetParams(const Value: TftParamList);
    procedure setComID(const Value: string);
    procedure SetCustID(const Value: string);
    procedure SetLICENSE_CODE(const Value: string);
    procedure SetShopID(const Value: string);
    procedure SetTenID(const Value: string);
    procedure SetShortID(const Value: string);
    procedure SetMaxStmp(const Value: string); //读取Rim相关参数值
    function  SetParamsValue(InParams: TftParamList): Boolean;
    function  GetUpdateTime: string;
    function  GetTWO_PHASE_COMMIT: Boolean;
    procedure SetLogMsg(const Value: string);
    procedure SetPrcdMsg(const Value: string);
    procedure SetRunState(const Value: Boolean);
    procedure SetPlugInID(const Value: Integer);
  public
    constructor Create(AGlobal: IdbHelp); virtual;
    function DLLDoExecute(InParams: TftParamList; var vData: OleVariant): integer; virtual;      //提供给外面调用过程
    function newId(id:string=''): string; //获取GUID
    function newRandomId: string;        //返回时间+随机编号ID
    function GetMaxNUM(BillType, COM_ID,CUST_ID, SHOP_ID: string): string;
    function ParseSQL(iDbType:integer;SQL:string):string;    //通用函数转换
    function GetDefaultUnitCalc(AliasTable: string=''): string;  //返回转换后单位ID
    function GetR3ToRimUnit_ID(iDbType:integer; UNIT_ID: string): string; //返回单位换算
    function GetTimeStamp(iDbType:Integer):string;   //返回时间戳
    function AddLogMsg(vMsg: string; RunState: integer=1): Boolean; {==RunState:1表示直接加日志文字==}
    function AddPrcdLogMsg(RunFlag: Boolean; vMsg: string;iRet: integer): Boolean;
    function WriteToFileLog: Boolean; overload;
    function ExecSQL(SQL: string; var iRet: integer; MsgStr: string=''): Boolean;overload;  //返回更新记录数据
    function ExecSQL(SQLList: TStringList;var iRet:integer; Params: TftParamList=nil):integer; overload;  //返回更新记录数据
    function ExecTransSQL(SQL: string; var iRet: integer): Boolean;  //返回是否事务是否执行成功
    function Open(DataSet: TDataSet; Params: TftParamList=nil):Boolean;  //取数据
    function WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,LogType,LogNote,LogStatus: string; USER_ID: string='auto'): Boolean; //写Rim日志

    property DBFactor: IdbHelp read FDBFactor;                    //数据访问接口
    property DbType: integer read FDbType;        //数据库类型
    property Params: TftParamList read FParams write SetParams;   //参数列表
    property UpdateTime: string read GetUpdateTime; //最新更新时间[YYYY-MM-DD_HH:MM:SS]
    property ComID: string read FComID write setComID;    //Rim烟草公司ID
    property CustID: string read FCustID write SetCustID; //Rim零售户ID
    property TenID: string read FTenID write SetTenID;    //零售户企业ID
    property ShopID: string read FShopID write SetShopID; //零售户门店ID
    property ShortID: string read FShortID write SetShortID; //零售户门店ID(后四位)
    property LICENSE_CODE: string read FLICENSE_CODE write SetLICENSE_CODE; //烟草经营许可证ID
    property MaxStmp: string read FMaxStmp write SetMaxStmp;  //最大时间戳
    property UpMaxStmp: string read FUpMaxStmp;               //更新最大时间戳
    property TWO_PHASE_COMMIT: Boolean read GetTWO_PHASE_COMMIT; //启动分布式（多个数据源提交事务）
    property RunState: Boolean read FRunState write SetRunState; //运行状态（过程运行状态）
    property LogMsg: string read FLogMsg Write SetLogMsg; //写一个类日志
    property PrcdMsg: string read FPrcdMsg Write SetPrcdMsg; //某个过程日志
    property PlugInID: Integer read FPlugInID Write SetPlugInID;  //插件ID(控制是否启用上报) 
  end;

  //上报最新库存
  TPlugInSyncStorage=class(TPlugInBase)
  private
    function SyncCustStorage:integer;
  public
    function DLLDoExecute(InParams: TftParamList; var vData: OleVariant):integer; override;  //提供给外面调用过程
  end;

  //上报销售汇总
  TPlugSyncSaleTotal=class(TPlugInBase)
  private
    function SyncSaleTotal: integer;
  public
    function DLLDoExecute(InParams: TftParamList; var vData: OleVariant):integer; override;  //提供给外面调用过程
  end;

  //取Rim消息
  TPlugInSyncMessage=class(TPlugInBase)
  private
    AllRet: integer; //总下载消息数
    NewRet: integer; //新插入消息数
    function SyncMessage: integer;
  public
    function DLLDoExecute(InParams: TftParamList; var vData: OleVariant):integer; override;  //提供给外面调用过程
  end;

  //上报消费者(Vip)
  TPlugSyncVip=class(TPlugInBase)
  private
    PRICE_NAME: string;  //卡信息
    basInfo: TZQuery;
    //对照性别
    function GetGender(n:string;flag:integer):string;
    //对照到RIM的内码。
    function GetRimId(id:string;flag:integer):string;
    //对照到R3的内码。
    function GetR3Id(id:string;flag:integer):string;
    //返回时间戳
    function GetStamp(UPD_Date:string;UPD_Time:string):int64;
    //返回当前日期：
    function GetCurDate(s:string;format:string='YYYY-MM-DD'):string;
    //返回价格等级：
    function GetPriceId(tid:string):string;
    //下载会员
    function DownLoadCustomer(tid,custid,sid,rid,pid:string;rs:TZQuery): integer;
    //上传会员：tid 企业号  cid 会员ID
    function UpLoadCustomer(tid,custid:string;rs:TZQuery):integer;
    //同步消费者：
    function SyncCustomer(tid,sid,pid:string;today:boolean=false): Boolean;
  public
    constructor Create(AGlobal: IdbHelp); override;
    destructor Destroy;override;
    function DLLDoExecute(InParams: TftParamList; var vData: OleVariant):integer; override;  //提供给外面调用过程
  end;

  //Rim的Wsdl服务
  TPlugSyncWsdlService=class(TPlugInBase)
  public
    function DLLDoExecute(InParams: TftParamList; var vData: OleVariant):integer; override;  //提供给外面调用过程
  end;

  //同步问卷调查
  TPlugSyncQuestion=class(TPlugInBase)
  private
    FSyncType: integer;
    //返回OPTION_IDS
    function GetOPTION_IDS(SUBJECT_ID: string): string;
    //下载写入一个问卷[]
    function Write_Question_Page(Volume_ID,tid,sid,Mid: string): string;
    //同步调查
    function SyncInvest(tid,sid,qid:string): integer;
    //同步问卷: tid 企业号  sid 门店号
    function SyncQuestion(tid,sid:string): integer; //问卷
  public
    function DLLDoExecute(InParams: TftParamList; var vData: OleVariant):integer; override;  //提供给外面调用过程
  end;

  function ReadConfig(Header,Ident,DefValue:string; IniFile: string=''):string;  //读配置文件
  function ReadBool(Header,Ident:string; DefValue: Boolean;IniFile: string=''):Boolean;  //读配置文件
  procedure ReadPlugInCfg(var vPlugParams: TPlugParams); //读取插件原定义参数
  //写日志：
  function WriteDebugLog(LogText: string; SHOP_ID: string=''): Boolean;
            

var
  PlugParams: TPlugParams;

implementation

uses
  IniFiles,uFnUtil;

 { TPlugInBase }

function ReadBool(Header, Ident: string; DefValue: Boolean; IniFile: string): Boolean;
var
  F: TIniFile;
  FileName: string;
begin
  result:=False;
  if trim(IniFile)='' then
    FileName:=ExtractFilePath(Application.ExeName)+'PlugIn.cfg';
  F:=TIniFile.Create(FileName);
  try
    result:=F.ReadBool(Header,Ident,DefValue);
  finally
    F.Free;
  end;
end;

function ReadConfig(Header, Ident, DefValue, IniFile: string): string;
var
  F: TIniFile;
  FileName: string;
begin
  result:='';
  if trim(IniFile)='' then
    FileName:=ExtractFilePath(Application.ExeName)+'PlugIn.cfg';
  F:=TIniFile.Create(FileName);
  try
    result:=trim(F.ReadString(Header,Ident,DefValue));
  finally
    F.Free;
  end;
end;

procedure ReadPlugInCfg(var vPlugParams: TPlugParams); //取取产件定义参数
begin
  vPlugParams.PlugInID:=ReadConfig('PARAMS','PlugInID','0000000000000000000');   //启用哪些插件上报
  vPlugParams.VipUpload:=ReadBool('PARAMS','VipUpload',true);      //是否上报终端采集消费者
  vPlugParams.Up_CUST_STATUS:=ReadConfig('PARAMS','UP_CUST_STATUS','03'); //上报消费者的状态，默认:03
  vPlugParams.USE_SM_CARD:=ReadBool('PARAMS','USE_SM_CARD',true);  //默认启用上报商盟卡
  vPlugParams.AutoCreateCard:=trim(ReadConfig('PARAMS','AutoCreateCard','0'))='1'; //启用上报商盟卡自动将电话号作为商盟卡
  vPlugParams.USING_CUST_PSWD:=ReadBool('rim','USING_CUST_PSWD',false); //启用客户密码
  vPlugParams.RimUrl:=ReadConfig('rim','url','');   //RimUrl
  vPlugParams.TWO_PHASE_COMMIT:=trim(ReadConfig('PARAMS','TWO_PHASE_COMMIT','1'))<>'0';
  vPlugParams.DEBUG_TYPE:=StrtoIntDef(ReadConfig('PARAMS','DEBUG_TYPE','0'),0); //启用调试类型;
  vPlugParams.LOG_TYPE:=StrtoIntDef(ReadConfig('PARAMS','LOG_TYPE','2'),0); //启用调试类型;
end;

//写日志
function WriteDebugLog(LogText: string; SHOP_ID: string=''): Boolean;
var
  S,vShopID: string;
  F: TextFile;
begin
  if PlugParams.DEBUG_TYPE=0 then Exit;  //非日志模式退出；
  vShopID:='';
  //if SHOP_ID<>'' then vShopID:=' SHOP_ID='+SHOP_ID;
  case PlugParams.DEBUG_TYPE of
   1:
    begin
      LogFile.AddLogFile(0,vShopID+' '+LogText);
    end;
   2:
    begin
      if FileExists(SHOP_ID+'.FLAG') then
        LogFile.AddLogFile(0,vShopID+' '+LogText);
    end;
   3:
    begin
      if FileExists(SHOP_ID+'.FLAG') then
      begin
        S:=TimeToStr(Time())+vShopID+' '+LogText;
        AssignFile(F,'debug.log');
        if FileExists('debug.log') then
           append(f)
        else
           rewrite(f);
        try
          Writeln(f,s);
        finally
          closefile(f);
        end;
      end;
    end;
  end;
end;

function TPlugInBase.AddLogMsg(vMsg: string; RunState: integer): Boolean;
begin
  result:=False;
  if PlugParams.DEBUG_TYPE=0 then Exit;
  if PlugParams.LOG_TYPE=0 then Exit;

  case RunState of
   -1: {==执行错误==}
    begin
      if vMsg<>'' then
      begin
        if trim(LogMsg)<>'' then
          LogMsg:=LogMsg+';['+vMsg+'=Error]'
        else
          LogMsg:='['+vMsg+'=Error]';
        result:=true;
      end;
    end;
   0: {执行成功}
    begin
      if vMsg<>'' then
      begin
        if trim(LogMsg)<>'' then
          LogMsg:=LogMsg+';['+vMsg+'Succ]'
        else
          LogMsg:='['+vMsg+'Succ]';
        result:=true;
      end;
    end;
   1: {==默认情况直接添加日志文字==}
    begin
      if vMsg<>'' then
      begin
        if trim(LogMsg)<>'' then
          LogMsg:=LogMsg+';['+vMsg+']'
        else
          LogMsg:='['+vMsg+']';
        result:=true;
      end;
    end;
  end;
end;

function TPlugInBase.AddPrcdLogMsg(RunFlag: Boolean;vMsg: string;iRet: integer): Boolean;
begin
  result:=False;
  if PlugParams.DEBUG_TYPE=0 then Exit;
  if PlugParams.LOG_TYPE=0 then Exit;

  if RunFlag then //正常运行
  begin
    if trim(PrcdMsg)='' then
      PrcdMsg:=PrcdMsg+';'+vMsg+'='+InttoStr(iRet)
    else
      PrcdMsg:=vMsg+'='+InttoStr(iRet);
  end else //错误情况
    PrcdMsg:=PrcdMsg+';'+vMsg+'=False';
end;

function TPlugInBase.WriteToFileLog: Boolean;
begin
  // 0:上报执行情况不日志,1:有错误时打日志; 2：全部上报日志
  if PlugParams.LOG_TYPE=0 then Exit;

  case PlugParams.LOG_TYPE of
   1:
    begin
      if not RunState then
        WriteDebugLog(LogMsg,ShopID);
    end;
   2: WriteDebugLog(LogMsg,ShopID);
  end;   
end;

constructor TPlugInBase.Create(AGlobal: IdbHelp);
begin
  //传入参数:
  FDBFactor:=AGlobal;
  FLogMsg:='';
end;

function TPlugInBase.DLLDoExecute(InParams: TftParamList; var vData: OleVariant): integer;
begin

end;

function TPlugInBase.ExecSQL(SQL: string; var iRet: integer; MsgStr: string): Boolean;
begin
  result:=False;
  try
    WriteDebugLog('ExecSQL:'+SQL);
    iRet:=FDBFactor.ExecSQL(SQL);
    result:=True;
  except
    on E:Exception do
    begin
      WriteDebugLog('错误:'+E.Message);
      Raise Exception.Create(Pchar(MsgStr+'错误:'+E.Message));
    end;
  end;  
end;

function TPlugInBase.ExecSQL(SQLList: TStringList; var iRet: integer; Params: TftParamList): integer;
var
  SQLStr: string;
  i,RunCount,vCount: integer;
  InParamsStr: Pchar;
  ReRun: Boolean;
begin
  result:=-1;
  vCount:=0;
  RunCount:=0;
  for i:=0 to SQLList.Count-1 do
  begin
    SQLStr:=trim(SQlList.Strings[i]);
    if SQlStr<>'' then
    begin
      iRet:=0;
      ReRun:=ExecSQL(SQLStr,vCount);
      if ReRun then //正常
      begin
        iRet:=iRet+vCount;  //影响行数
        Inc(RunCount);      //累计正常数
      end;
    end;
  end;
  if RunCount=SQLList.Count then
    Result:=0;
end;

function TPlugInBase.ExecTransSQL(SQL: string; var iRet: integer): Boolean;
begin
  result:=False;
  FDBFactor.BeginTrans;
  try
    WriteDebugLog('ExecTransSQL:'+SQL);
    iRet:=FDBFactor.ExecSQL(SQL);
    FDBFactor.CommitTrans;
    result:=True;
  except
    on E:Exception do
    begin
      FDBFactor.RollbackTrans;
      WriteDebugLog('错误:'+E.Message);
      Raise Exception.Create('错误:'+E.Message);
    end;
  end;  
end;

{== R3.数量 ÷ZOOR_RATE=Rim.数量[R3.数量 =ZOOR_RATE * Rim.数量] ==}
function TPlugInBase.GetDefaultUnitCalc(AliasTable: string): string;
var
  AliasTab,Zoom_Rate: string;
begin
  AliasTab:='';
  if trim(AliasTable)<>'' then
    AliasTab:=trim(AliasTable)+'.';
  Zoom_Rate:=ParseSQL(FDBFactor.iDbType,'nvl('+AliasTab+'ZOOM_RATE,1.0)');
  result:=
    'case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.00 '+             //默认单位为 计量单位
        ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC*'+Zoom_Rate+'*1.00 '+  //默认单位为 小单位
        ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC*'+Zoom_Rate+'*1.00 '+      //默认单位为 大单位
        ' else 1.00 end ';                                                        //都不是则默认为换算为1;
end;

function TPlugInBase.GetMaxNUM(BillType, COM_ID, CUST_ID, SHOP_ID: string): string;
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
      ExecSQL(Str,iRet,'RIM_R3_NUM初始化');

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

function TPlugInBase.GetR3ToRimUnit_ID(iDbType: integer; UNIT_ID: string): string;
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

function TPlugInBase.GetTimeStamp(iDbType: Integer): string;
begin
  case iDbType of
   0:Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
   1:Result := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))+(sysdate - trunc(sysdate))*24*60*60';
   4:result := '86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))+MIDNIGHT_SECONDS(CURRENT TIMESTAMP)';
   //5:result := 'strftime(''%s'',''now'',''localtime'')-1293840000'; //没有修改[暂时未找到对应函数处理]
   else Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
  end;
end;

function TPlugInBase.GetTWO_PHASE_COMMIT: Boolean;
begin
  result:=PlugParams.TWO_PHASE_COMMIT;
end;

function TPlugInBase.GetUpdateTime: string;
var
  vYear,vMonth,vDay,vHour,vMin, vSec,vMSec: Word;
begin
  DecodeDate(Date(), vYear, vMonth,vDay);
  result:=FormatFloat('0000',vYear)+'-'+FormatFloat('00',vMonth)+'-'+FormatFloat('00',vDay);  //10位
  DecodeTime(Time(), vHour, vMin, vSec, vMSec);
  result:=result+' '+FormatFloat('00',vHour)+':'+FormatFloat('00',vMin)+':'+FormatFloat('00',vSec);
end;

function TPlugInBase.newId(id: string): string;
var
  g:TGuid;
begin
  if CreateGUID(g)=S_OK then
  begin
     result :=trim(GuidToString(g));
     result :=Copy(result,2,length(result)-2);  //去掉"{}"
  end else
     result :=id+'_'+formatDatetime('YYYYMMDDHHNNSS',now());
end;

function TPlugInBase.newRandomId: string;
var
  vRandvalue: integer;
  vHour, vMin, vSec, vMSec: Word;
begin
  DecodeTime(time(), vHour, vMin, vSec, vMSec);
  result:=FormatDatetime('YYYYMMDD',Date())+FormatFloat('00',vHour)+FormatFloat('00',vMin)+FormatFloat('00',vSec)+FormatFloat('000',vMSec);
  //获取8位随机数
  vRandvalue:=0;
  while vRandvalue<9999999 do
  begin
    vRandvalue:=Random(99999999); //8位
  end;
  result:=result+InttoStr(vRandvalue);

  //获取7位随机数
  vRandvalue:=0;
  while vRandvalue<999999 do
  begin
    vRandvalue:=Random(8888888); //8位
  end;
  result:=result+InttoStr(vRandvalue);
end;

function TPlugInBase.Open(DataSet: TDataSet; Params: TftParamList): Boolean;
var
  ReRun: integer;
  InParamsStr: Pchar;
begin
  result:=False;
  InParamsStr:=nil;
  if Params<>nil then
  begin
    InParamsStr:=Pchar(Params.Encode(Params));
  end;
  if DataSet.ClassNameIs('TZQuery') then //TZQuery
  begin
    try
      WriteDebugLog('ExecSQL:'+TZQuery(DataSet).SQL.Text);
      TZQuery(DataSet).Close;
      DBFactor.Open(TZQuery(DataSet));  
      Result:=TZQuery(DataSet).Active;
    except
      on E:Exception do
      begin
        WriteDebugLog('错误:'+E.Message);
        Raise;
      end;
    end;
  end
end;

function TPlugInBase.ParseSQL(iDbType: integer; SQL: string): string;
begin
  {==判断null函数替换处理==}
  case iDbType of
  0:begin
     result := stringreplace(SQL,'ifnull','isnull',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','isnull',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','isnull',[rfReplaceAll]);
     result := stringreplace(result,'nvl','isnull',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','isnull',[rfReplaceAll]);
     result := stringreplace(result,'NVL','isnull',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','isnull',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','isnull',[rfReplaceAll]);
    end;
  1:begin
     result := stringreplace(SQL,'ifnull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','nvl',[rfReplaceAll]);
     result := stringreplace(result,'isnull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','nvl',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','nvl',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','nvl',[rfReplaceAll]);
    end;
  4:begin
     result := stringreplace(SQL,'ifnull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'isnull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'nvl','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','coalesce',[rfReplaceAll]);
    end;
  5:begin
     result := stringreplace(SQL,'nvl','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'NVL','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'isnull','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','ifnull',[rfReplaceAll]);
    end;
  end;
  {== 2011.02.25 Add字符函数substring与substr函数替换处理 [substring |substr| mid] ==}
  case iDbType of
   0,2: //Ms SQL Server | SYSBASE  [substring]
    begin
      result := stringreplace(result,'substr(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'SubStr(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTR(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'mid(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'Mid(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'MID(','substring(',[rfReplaceAll]);
    end;
   3:  //ACCESS
    begin
      result := stringreplace(result,'substr(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SubStr(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTR(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'substring(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SubString(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTRING(','mid(',[rfReplaceAll]);
    end;
   1,4,5: //Oracle | DB2 | SQLITE
    begin
      result := stringreplace(result,'substring(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'SubString(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTRING(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'mid(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'Mid(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'MID(','substr(',[rfReplaceAll]);
    end;
  end;
  {==2011.02.25 Add字符长度函数len()与length函数替换处理 [len |length|char_length] ==}
  case iDbType of
   0,3: //Ms SQL Server | Access [substring]
    begin
      result := stringreplace(result,'length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'Length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'LENGTH(','len(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','len(',[rfReplaceAll]);
    end;
   2:  //SYSBASE [char_length] 字符长度（字节长度用：data_length）
    begin
      result := stringreplace(result,'length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'Length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'LENGTH(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','data_length(',[rfReplaceAll]);
    end;
   1,4,5: //Oracle | DB2 | SQLITE [length]  [Oracle字节长度:lengthb]
    begin
      result := stringreplace(result,'len(','length(',[rfReplaceAll]);
      result := stringreplace(result,'Len(','length(',[rfReplaceAll]);
      result := stringreplace(result,'LEN(','length(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','length(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','length(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','length(',[rfReplaceAll]);
    end;
  end;
end;

procedure TPlugInBase.setComID(const Value: string);
begin
  FComID := Value;
end;

procedure TPlugInBase.SetPrcdMsg(const Value: string);
begin
  FPrcdMsg := Value;
end;

procedure TPlugInBase.SetCustID(const Value: string);
begin
  FCustID := Value;
end;

procedure TPlugInBase.SetLICENSE_CODE(const Value: string);
begin
  FLICENSE_CODE := Value;
end;

procedure TPlugInBase.SetLogMsg(const Value: string);
begin
  FLogMsg := Value;
end;

procedure TPlugInBase.SetMaxStmp(const Value: string);
begin
  FMaxStmp := Value;
end;

procedure TPlugInBase.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

function TPlugInBase.SetParamsValue(InParams: TftParamList): Boolean;
var
  Rs: TZQuery;
  PlugInIDS: string;
begin
  result:=False;
  PlugInIDS:=PlugParams.PlugInID;
  if trim(PlugInIDS)='' then PlugInIDS:='000000000000000000000000';
  if Copy(PlugInIDS,PlugInID,1)='0' then Exit;
 

  //传入参数列表
  Params:=InParams;
  TenID:=Params.ParamByName('TENANT_ID').AsString; //企业ID
  ShopID:=Params.ParamByName('SHOP_ID').AsString;  //门店ID
  ShortID:=Copy(ShopID,Length(ShopID)-3,4);
  FDbType:=DBFactor.iDbType; //数据库类型
  //先判断是否是烟草企业(是否是烟草加盟的企业):
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select TENANT_ID from CA_RELATIONS where RELATION_ID=1000006 and RELATI_ID='+TenID+' ';
    DBFactor.Open(Rs);
    if Rs.Active then
    begin
      if trim(Rs.FieldByName('TENANT_ID').AsString)='' then
        Raise Exception.Create('传入<零售户>企业ID:('+TenID+') 没有加盟上级烟草企业');
    end;
    //读取Rim.COM_ID,Rim.Cust_ID,Rim.LICENSE_CODE 许可证号;
    Rs.Close;
    Rs.SQL.Text:=
      'select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID,A.LICENSE_CODE as LICENSE_CODE from RM_CUST A,CA_SHOP_INFO B '+
      ' where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenID+' and B.SHOP_ID='''+ShopID+''' ';
    DBFactor.Open(Rs);
    if (Rs.Active) and (Rs.RecordCount=1) then
    begin
      ComID:=trim(Rs.FieldByName('COM_ID').AsString);
      CustID:=trim(Rs.FieldByName('CUST_ID').AsString);
      LICENSE_CODE:=trim(Rs.FieldByName('LICENSE_CODE').AsString);     
    end else
      Raise Exception.Create('没有找到Rim对应的零售户！');
  finally
    Rs.Free;
  end;
  FLogMsg:='[TenID='+TenID+';ShopID='+ShopID+';ComID='+ComID+';CustID='+CustID+';LICENSE_CODE='+LICENSE_CODE+']';
  result:=True;
end;

procedure TPlugInBase.SetRunState(const Value: Boolean);
begin
  FRunState := Value;
end;

procedure TPlugInBase.SetShopID(const Value: string);
begin
  FShopID := Value;
end;

procedure TPlugInBase.SetShortID(const Value: string);
begin
  FShortID := Value;
end;

procedure TPlugInBase.SetTenID(const Value: string);
begin
  FTenID := Value;
end;

function TPlugInBase.WriteToRIM_BAL_LOG(LICENSE_CODE, CustID, LogType, LogNote, LogStatus, USER_ID: string): Boolean;
var
  str,LOG_SEQ,LogText: string;
begin
  sleep(1);
  LOG_SEQ:=LICENSE_CODE+Formatdatetime('YYYYMMDDHHNNSSZZZ',now());
  LogText:=Copy(trim(LogNote),1,40);
  Str:='insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values '+
       '('''+LOG_SEQ+''','''+LogType+''','''+CustID+''','''+Formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''','''+LogText+''','''+USER_ID+''','''+LogStatus+''')' ;
  try
    FDBFactor.ExecSQL(Str);
  except
    on E:Exception do
    begin
      Raise Exception.Create('写日志(RIM_BAL_LOG)执行失败:'+E.Message);
    end;
  end;
end;

{ TPlugInSyncStorage }
{
 RIM_CUST_ITEM_SWHSE与RIM_CUST_ITEM_WHSE区别：
  (1)RIM_CUST_ITEM_SWHSE有终端ID:TERM_ID，RIM_CUST_ITEM_WHSE无终端ID;
  (2)RIM_CUST_ITEM_SWHSE是中间表（对应Rim系统一个零售户可能有多个店）;
  (3)RIM_CUST_ITEM_WHSE是Rim零售户的总库存的汇总;
}


function TPlugInSyncStorage.SyncCustStorage: integer;
var
  iRect: integer;      //影响记录行
  Str,Up_Date: string;
begin
  result := -1;
  iRect:=0;
  PrcdMsg:='';
  RunState:=False;  
  try
    Up_Date:=FormatDatetime('YYYYMMDD',Date());

    //1、先插入不存在商品[中间库存表]:
    Str:='insert into RIM_CUST_ITEM_SWHSE(CUST_ID,ITEM_ID,COM_ID,TERM_ID,QTY,DATE1,TIME1,IS_MRB,TIME_STAMP) '+
         ' select '''+CustID+''' as CUST_ID,B.SECOND_ID,'''+ComID+''' as COM_ID,'''+ShortID+''' as TERM_ID,0 as QRY,'''+Up_Date+''' as UPD_DATE,'''+TimetoStr(time())+''' as UPD_TIME,''0'',0 '+
         ' from STO_STORAGE A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.COMM not in (''02'',''12'') and A.TENANT_ID='+TenID+' and A.SHOP_ID='''+ShopID+''' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' and not exists(select ITEM_ID from RIM_CUST_ITEM_SWHSE C where C.COM_ID='''+ComID+''' and C.CUST_ID='''+CustID+''' and C.TERM_ID='''+ShortID+''' and C.ITEM_ID=B.SECOND_ID) ';
    RunState:=ExecTransSQL(Str,iRect);
    AddPrcdLogMsg(RunState,'SWHSE.insert=',iRect);
    
    //2、插入: RIM_CUST_ITEM_SWHSE
    Str:=ParseSQL(DbType,
           'update RIM_CUST_ITEM_SWHSE '+
           ' set (QTY,TIME_STAMP)=(select sum(A.AMOUNT/'+GetDefaultUnitCalc+')as QRY,max(A.TIME_STAMP) as TIME_STAMP from STO_STORAGE A,VIW_GOODSINFO B '+
                             ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TenID+' and A.SHOP_ID='''+ShopID+''' and '+
                             ' B.COMM not in (''02'',''12'') and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)'+
                ',DATE1='''+Up_Date+''',TIME1='''+TimeToStr(Time())+''' '+
           ' where COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' and TERM_ID='''+ShortID+''' '+
           ' and exists(select B.SECOND_ID from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TenID+' and A.SHOP_ID='''+ShopID+''' and RIM_CUST_ITEM_SWHSE.ITEM_ID=B.SECOND_ID)');
    if RunState then
    begin
      RunState:=ExecTransSQL(Str,iRect);
      AddPrcdLogMsg(RunState,'SWHSE.update=',iRect);
    end;

    //3、先更新当前当天的中间库存到零售户库存表：[RIM_CUST_ITEM_WHSE]:
    str:=ParseSQL(DbType,
         ' update RIM_CUST_ITEM_WHSE '+
         '  set (QTY,TIME_STAMP)=(select sum(QTY),max(TIME_STAMP) from RIM_CUST_ITEM_SWHSE A where RIM_CUST_ITEM_WHSE.COM_ID=A.COM_ID and RIM_CUST_ITEM_WHSE.CUST_ID=A.CUST_ID and RIM_CUST_ITEM_WHSE.ITEM_ID=A.ITEM_ID),'+
              ' DATE1='''+Up_Date+''',UPD_TIME='''+TimeToStr(Time())+''' '+
         ' where COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' ');
    if RunState then
    begin
      RunState:=ExecTransSQL(Str,iRect);
      AddPrcdLogMsg(RunState,'WHSE.update=',iRect);
    end;

    //4、没有更新到记录插入中间表：[RIM_CUST_ITEM_WHSE]:
    str:='insert into RIM_CUST_ITEM_WHSE(COM_ID,CUST_ID,ITEM_ID,QTY,DATE1,UPD_TIME,TIME_STAMP) '+
         ' select COM_ID,CUST_ID,ITEM_ID,sum(QTY),'''+Up_Date+''' as Up_Date,'''+TimeToStr(Time())+''' as UPD_TIME,max(TIME_STAMP) from RIM_CUST_ITEM_SWHSE A '+
         ' where COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' and '+
         ' not Exists(select COM_ID from RIM_CUST_ITEM_WHSE where COM_ID=A.COM_ID and CUST_ID=A.CUST_ID and ITEM_ID=A.ITEM_ID) '+
         ' group by COM_ID,CUST_ID,ITEM_ID ';
    if RunState then
    begin
      RunState:=ExecTransSQL(Str,iRect);
      AddPrcdLogMsg(RunState,'WHSE.insert=',iRect);
      result:=0;
    end;
  except
    on E:Exception do
    begin
      WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,'11','上报零售户库存错误！','02');  //上报出错写日志
      Raise;
    end;
  end;
  //上报成功写日志：
  WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,'11','上报零售户库存成功！','01');
end;

function TPlugInSyncStorage.DLLDoExecute(InParams: TftParamList; var vData: OleVariant):integer;
begin
  result := -1;
  PlugInID:=1;  //第1位
  if Not SetParamsValue(InParams) then Exit;  //退出不执行

  try
    result:=SyncCustStorage;
    {result=0返回执行成功}
    AddLogMsg('SyncCustStorage=',result);
  finally
    WriteToFileLog; //写入
  end;
end;

procedure TPlugInBase.SetPlugInID(const Value: Integer);
begin
  FPlugInID := Value;
end;

{ TPlugSyncSaleTotal }

function TPlugSyncSaleTotal.SyncSaleTotal: integer;
var
  iRet,NewiRet: integer;  //返回ExeSQL影响多少行记录
  Session: string;       //session前缀
  Str: string; //门店后四位代码
  CndTab,         //条件表
  SalesTab,       //销售视图
  SaleDetail,     //销售明细表
  SALES_DATE,     //指定上报日期
  vSALES_DATE: string;     //销售日期[转成字符]
begin
  result := -1;
  iRet:=0;
  NewiRet:=0;
  RunState:=False;
  //返回销售汇总上次最大时间戳和当前时间戳:
  MaxStmp:=GetMaxNUM('10',ComID,CustID,ShopID);

  //创建日台帐临时[INF_RECKDAY]:
  case DbType of
   1:
    begin
      Session:='';
      vSALES_DATE:='to_char(A.SALES_DATE)';    //台账日期 转成 varchar
      ExecSQL('truncate table INF_SALESUM',iRet,'清除临时表INF_SALESUM'); 
    end;
   4:
    begin              
      Session:='session.';
      vSALES_DATE:='ltrim(rtrim(char(A.SALES_DATE)))';   //台账日期 转成 varchar
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALESUM( '+
             ' TENANT_ID INTEGER NOT NULL,'+     //R3企业ID
             ' SHOP_ID VARCHAR(20) NOT NULL,'+   //R3门店ID
             ' SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3门店ID后四位
             ' COM_ID VARCHAR(30) NOT NULL,'+    //RIM烟草公司ID
             ' CUST_ID VARCHAR(30) NOT NULL,'+   //RIM零售户ID
             ' ITEM_ID VARCHAR(30) NOT NULL,'+   //RIM商品ID
             ' GODS_ID CHAR(36) NOT NULL,'+      //R3商品ID
             ' SALES_DATE  VARCHAR(8) NOT NULL,'+  //销售日期
             ' UNIT_ID CHAR(36) NOT NULL,'+       //单位ID
             ' QTY_ORD DECIMAL (18,6),'+         //台账销售数量
             ' AMT DECIMAL (18,6),'+             //台账销售金额
             ' CO_NUM VARCHAR(30) NOT NULL '+    //单据号[台账日期 + 零售户ID+ R3_门店ID后4位]
             ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      ExecSQL(Str,iRet,'创建临时表INF_SALESUM');
    end;
  end;

  //第一步: 大于时间戳的台帐插入临时表:
  //条件表: 根据传入条件及指定日期返回对应门店及日期需要上报条件:
  CndTab:='select distinct TENANT_ID,SHOP_ID,SALES_DATE from SAL_SALESORDER where TENANT_ID='+TenID+' and SHOP_ID='''+ShopID+''' ';
  SALES_DATE:='';
  if Params.findParam('SALES_DATE')<>nil then SALES_DATE:=Params.findParam('SALES_DATE').AsString;
  if SALES_DATE='' then
    CndTab:=CndTab+' and TIME_STAMP>'+MaxStmp+' '
  else
    CndTab:=CndTab+' and ((TIME_STAMP>'+MaxStmp+')or(SALES_DATE='+SALES_DATE+'))'; //前台传入日期
                   
  ExecSQL('delete from '+Session+'INF_SALESUM',iRet,'删除中间表');
  SalesTab:=
    'select M.TENANT_ID,M.SHOP_ID,S.GODS_ID,M.SALES_DATE,sum(S.CALC_AMOUNT) as CALC_AMOUNT,sum(S.CALC_MONEY) as CALC_MONEY '+
    ' from SAL_SALESORDER M,SAL_SALESDATA S,('+CndTab+') C '+
    ' where M.TENANT_ID=S.TENANT_ID and M.SALES_ID=S.SALES_ID and M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and '+
    ' M.SALES_DATE=C.SALES_DATE and M.SALES_TYPE in (1,3,4) and M.COMM not in (''02'',''12'') and M.TENANT_ID='+TenID+' and M.SHOP_ID='''+ShopID+''' '+
    ' group by M.TENANT_ID,M.SHOP_ID,M.SALES_DATE,S.GODS_ID';
  Str:='insert into '+Session+'INF_SALESUM(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_ID,SALES_DATE,QTY_ORD,AMT,CO_NUM) '+
    'select A.TENANT_ID,A.SHOP_ID,'''+ShortID+''' as SHORT_SHOP_ID,'''+ComID+''' as COM_ID,'''+CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,B.UNIT_ID,'+vSALES_DATE+' as SALES_DATE,'+
    ' (case when '+GetDefaultUnitCalc+'<>0 then cast(A.CALC_AMOUNT as decimal(18,3))/('+GetDefaultUnitCalc+') else A.CALC_AMOUNT end) as SALE_AMT,A.CALC_MONEY,('+vSALES_DATE+' || ''_'' || '''+CustID+''' ||''_'' || '''+ShortID+''') as CO_NUM '+
    ' from ('+SalesTab+')A,VIW_GOODSINFO B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
  RunState:=ExecSQL(Str,iRet,'插入日销售汇总中间表');
  AddPrcdLogMsg(RunState,'INF_SALESUM.insert=',iRet);

  if iRet=0 then
  begin
    result:=0; //返回没有可上报数据
    Exit; //没有上报数据时则退出;  //Raise Exception.Create('没有可上报销售数据'); //若插入没有记录，退出循环
  end;

  //第三步: 每一次执行作为一个事务提交
  //1、删除销售历史数据(先删除表体在删除表头):
  Str:='delete from RIM_RETAIL_CO_LINE A '+
       ' where exists(select B.CO_NUM from RIM_RETAIL_CO B,'+Session+'INF_SALESUM C '+
                    ' where B.COM_ID=C.COM_ID and B.CUST_ID=C.CUST_ID and B.PUH_DATE=C.SALES_DATE and B.COM_ID='''+ComID+'''and B.TERM_ID='''+ShortID+''' and B.CUST_ID='''+CustID+''' and A.CO_NUM=B.CO_NUM)';
  ExecSQL(Str,iRet,'删除历史日销售表体');

  Str:='delete from RIM_RETAIL_CO A where exists(select 1 from '+Session+'INF_SALESUM B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.PUH_DATE=B.SALES_DATE) and A.COM_ID='''+ComID+''' and A.TERM_ID='''+ShortID+''' and A.CUST_ID='''+CustID+''' ';
  ExecSQL(Str,iRet,'删除历史日销售表头');

  DBFactor.BeginTrans;
  try
    //2、插入日销售台账(先插表头在插入表体):
    Str:='insert into RIM_RETAIL_CO(CO_NUM,CUST_ID,COM_ID,TERM_ID,PUH_DATE,STATUS,PUH_TIME,UPD_DATE,UPD_TIME,QTY_SUM,AMT_SUM) '+
         'select CO_NUM,CUST_ID,COM_ID,SHORT_SHOP_ID,SALES_DATE,''01'' as STATUS,'''+TimetoStr(time())+''','''+FormatDatetime('YYYYMMDD',Date())+''','''+TimetoStr(time())+''',sum(QTY_ORD) as QTY_SUM,sum(AMT) as AMT_SUM '+
         ' from '+Session+'INF_SALESUM group by COM_ID,CUST_ID,SHORT_SHOP_ID,CO_NUM,SALES_DATE';
    ExecSQL(Str,NewiRet,'插入日销售表头[RIM_RETAIL_CO]');

    Str:='insert into RIM_RETAIL_CO_LINE(CO_NUM,ITEM_ID,QTY_ORD,AMT,UM_ID,PRICE) '+
         'select CO_NUM,ITEM_ID,QTY_ORD,AMT,'+GetR3ToRimUnit_ID(DbType,'UNIT_ID')+' as UNIT_ID,'+
         '(case when QTY_ORD<>0 then cast(AMT as decimal(18,3))/cast(QTY_ORD as decimal(18,3)) else cast(AMT as decimal(18,3)) end) as PRICE from '+Session+'INF_SALESUM ';
    ExecSQL(Str,iRet,'插入日销售表体[RIM_RETAIL_CO_LINE]');
    
    //3、更新上报时间戳:
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' and TYPE=''10'' and TERM_ID='''+ShopID+''' ';
    ExecSQL(Str,iRet,'更新上报时间戳');

    DBFactor.CommitTrans;
    result:=NewiRet;
    AddPrcdLogMsg(true,'RIM_RETAIL_CO.insert=',NewiRet);
  except
    on E:Exception do
    begin
      DBFactor.RollbackTrans;
      WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,'10','上报日销售错误！','02'); //写日志
      Raise;
    end;
  end;
  //执行成功写日志:
  WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,'10','上报日销售成功！','01');
end;

function TPlugSyncSaleTotal.DLLDoExecute(InParams: TftParamList; var vData: OleVariant): integer;
begin
  result := -1;
  PlugInID:=2;  //第2位
  if Not SetParamsValue(InParams) then Exit;  //退出不执行
  
  try
    result:=SyncSaleTotal;
    { result返回上报多笔销售汇总 }
    if result>=0 then
      AddLogMsg('SyncSaleTotal=',0)
    else if result=-1 then
      AddLogMsg('SyncSaleTotal=',-1);
  finally
    WriteToFileLog;
  end;
end;

{ TPlugInSyncMessage }

function TPlugInSyncMessage.SyncMessage: integer;
var
  iRet: integer;
  str,s,mid,Msg_Class: string;
  rs: TZQuery;
  FReData: OleVariant;
begin
  result:=-1;
  AllRet:=0;
  NewRet:=0;
  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    case DbType of
    4:
     rs.SQL.Text :=
       'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+ComID+''' and '+
       '('+
       ' (POSSTR(RECEIVER,'''+CustID+','')>0) or ('+
       ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+CustID+''') or slsman_id is null or slsman_id='''') '+
       ' and (saleorg_id in (select saleorg_id from rm_cust where cust_id='''+CustID+''') or saleorg_id is null or saleorg_id='''') '+       ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+CustID+''') or sale_center_id is null or sale_center_id='''') '+       ' and (receiver is null or receiver =''''  or receiver ='','') '+       ' )'+       ')'+       'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
       'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+ShopID+''' and B.TENANT_ID='+TenID+' and B.COMM_ID=A.MSG_ID)';
    1:
     rs.SQL.Text :=
       'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+ComID+''' and '+
       '('+
       ' (INSTR(RECEIVER,'''+CustID+','')>0) or ('+
       ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+CustID+''') or slsman_id is null or slsman_id='''') '+
       ' and ( saleorg_id in (select saleorg_id from rm_cust where cust_id='''+CustID+''') or saleorg_id is null or saleorg_id='''') '+       ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+CustID+''') or sale_center_id is null or sale_center_id='''') '+       ' and (receiver is null or receiver =''''  or receiver ='','') '+       ' )'+
       ')'+
       'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
       'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+ShopID+''' and B.TENANT_ID='+TenID+' and B.COMM_ID=A.MSG_ID)';
    end;

    if Open(Rs) then
    begin
      AllRet:=Rs.RecordCount;
      rs.First;
      while not rs.Eof do
      begin
        DBFactor.BeginTrans;
        try
          Msg_Class:='0';
          mid:=newid(ShopID);
          str:='insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP) '+
               'values('+TenID+','''+mid+''','''+ShopID+''',1,1,''00'','+GetTimeStamp(DbType)+')';
          ExecSQL(str,iRet);
          {== 消息:0;公告:1;政策:2;广告:3;==}
          if rs.Fields[1].asString='01' then
          begin
             s := '促销信息';
             Msg_Class:='1';
          end else
          if rs.Fields[1].asString='02' then
          begin
             s := '广告信息';
             Msg_Class:='3';
          end else
          if rs.Fields[1].asString='03' then
          begin
             s := '货源信息';
             Msg_Class:='1';
          end else
          if rs.Fields[1].asString='04' then
          begin
             s := '新品信息';
             Msg_Class:='0';
          end else
          if rs.Fields[1].asString='05' then
          begin
             s := '通知'
             Msg_Class:='0';
          end else
          if rs.Fields[1].asString='99' then
          begin
             s := '到货通知';
             Msg_Class:='0';
          end else
          begin
            s := '公告';
            Msg_Class:='1';
          end;

          case DbType of
           4:str :=
              'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
              'select '+TenID+','''+mid+''','''+Msg_Class+''',int(USE_DATE),'+TenID+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(DbType)+
              ' from RIM_MESSAGE A where COM_ID='''+ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
           1:str :=
              'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
              'select '+TenID+','''+mid+''','''+Msg_Class+''',to_number(USE_DATE),'+TenID+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(DbType)+
              ' from RIM_MESSAGE A where COM_ID='''+ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
          end;
          ExecSQL(Str,iRet);
          DBFactor.CommitTrans;
          Inc(NewRet);
        except
          on E:Exception do
          begin
            DBFactor.RollbackTrans;
            WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,'13','下载消息错误！','02'); //写日志
            Raise
          end;
        end;
        rs.Next;
      end;
    end;
    result:=NewRet;
  finally
    rs.Free;
  end;
end;

function TPlugInSyncMessage.DLLDoExecute(InParams: TftParamList; var vData: OleVariant): integer;
begin
  result:=-1;
  PlugInID:=3;  //第3位
  if Not SetParamsValue(InParams) then Exit;  //退出不执行

  try
    result:=SyncMessage;
    { result返回下载多少条消息 }
    AddLogMsg('总下载消息数:'+InttoStr(AllRet)+';SyncMessage='+InttoStr(NewRet),1);
  finally
    WriteToFileLog;
  end;
end;


{ TPlugSyncVip }

constructor TPlugSyncVip.Create(AGlobal: IdbHelp);
begin
  inherited;
  BasInfo:=TZQuery.Create(nil);
end;

destructor TPlugSyncVip.Destroy;
begin
  BasInfo.Free;
  inherited;
end;

function TPlugSyncVip.DLLDoExecute(InParams: TftParamList; var vData: OleVariant): integer;
var
  iRet: integer;
  ErrorFlag: Boolean;
  custid,pid:string;
  RsShop: TZQuery;
begin
  try
    result:=-1;
    PlugInID:=4;  //第4位
    if Not SetParamsValue(InParams) then Exit;  //退出不执行

    BasInfo.Close;
    BasInfo.SQL.Text:='select GODS_ID,SORT_ID4,SORT_ID9 from VIW_GOODSINFO where TENANT_ID='+TenID;
    Open(BasInfo);

    pid := GetPriceId(TenID);
    try
      if pid<>'' then
        SyncCustomer(TenID,ShopID,pid,true);
    except
      on E:Exception do
      begin
        Raise Exception.Create(Pchar('<'+ShopID+'>消费者同步[上传]错误:'+E.Message));
      end;
    end;
  finally
    WriteToFileLog;
  end;
end;         

function TPlugSyncVip.DownLoadCustomer(tid, custid, sid, rid, pid: string; rs: TZQuery): integer;
var
  tmp,idx:TZQuery;
  Str,IcStr,IcStr1,idno,ctid,crname:string;
  r,iRect:integer;
begin
  result:=0;
  ctid := rs.FieldbyName('CONSUMER_ID').asString;
  for r :=length(rs.FieldbyName('CONSUMER_ID').asString)+1 to 36 do ctid := ctid +'$';
  tmp := TZQuery.Create(nil);
  idx := TZQuery.Create(nil);
  try
    crname := rs.FieldbyName('CR_NAME').asString;
    if crname='' then crname:='不记名';
    tmp.Close;
    tmp.SQL.Text := 'select TIME_STAMP from PUB_CUSTOMER where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
    Open(tmp);
    Str :='';
    if not tmp.IsEmpty then
     begin
      if tmp.FieldByName('TIME_STAMP').AsInteger<GetStamp(rs.FieldbyName('UPD_DATE').AsString,rs.FieldbyName('UPD_TIME').AsString) then //有更新，则上传
         begin
           Str :=
             'update PUB_CUSTOMER set '+
             'SHOP_ID='''+sid+''','+
             'REGION_ID='''+rid+''','+
             'CUST_CODE='''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','+
             'IDN_TYPE='''+inttostr(StrtoIntDef(rs.FieldbyName('CERT_TYPE_ID').AsString,1))+''','+
             'ID_NUMBER='''+rs.FieldbyName('CERT_ID').AsString+''','+
             'FAMI_ADDR='''+rs.FieldbyName('ADDRESS').AsString+''','+
             'CUST_NAME='''+crname+''','+
             'CUST_SPELL='''+crname+''','+
             'SEX='''+GetGender(rs.FieldbyName('GENDER').AsString,1)+''','+
             'BIRTHDAY ='+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString)+','+
             'FAMI_TELE='''+rs.FieldbyName('HOME_TEL').AsString+''','+
             'MOVE_TELE ='''+rs.FieldbyName('MOBILE_TEL').AsString+''','+
             'EMAIL='''+rs.FieldbyName('EMAIL').AsString+''','+
             'DEGREES='''+inttostr(StrtoIntDef(rs.FieldbyName('DEGREES').AsString,0))+''','+
             'MONTH_PAY='''+inttostr(StrtoIntDef(rs.FieldbyName('MONTH_PAY').AsString,0))+''','+
             'OCCUPATION='''+inttostr(StrtoIntDef(rs.FieldbyName('OCCUPATION').AsString,99))+''','+
             'JOBUNIT='''+rs.FieldbyName('JOBUNIT').AsString+''','+
             'TIME_STAMP='+GetTimeStamp(DbType)+' '+
             'where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
             IcStr := 'update PUB_IC_INFO set IC_CARDNO='''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''',TIME_STAMP='+GetTimeStamp(DbType)+' where TENANT_ID='+tid+' and CLIENT_ID='''+ctid+''' and UNION_ID='''+pid+'''';
             IcStr1 := 'update PUB_IC_INFO set IC_CARDNO='''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''',TIME_STAMP='+GetTimeStamp(DbType)+' where TENANT_ID='+tid+' and CLIENT_ID='''+ctid+''' and UNION_ID=''#''';
         end;
     end
    else
       begin
         Str :=
           'insert into PUB_CUSTOMER(TENANT_ID,SHOP_ID,CUST_ID,PRICE_ID,CUST_CODE,IDN_TYPE,ID_NUMBER,FAMI_ADDR,CUST_NAME,CUST_SPELL,SEX,BIRTHDAY,FAMI_TELE,MOVE_TELE,EMAIL,DEGREES,MONTH_PAY,OCCUPATION,JOBUNIT,REGION_ID,COMM,TIME_STAMP) '+
           'values('+tid+','''+sid+''','''+ctid+''','+
           ''''+pid+''','+
           ''''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('CERT_TYPE_ID').AsString,1))+''','+
           ''''+rs.FieldbyName('CERT_ID').AsString+''','+
           ''''+rs.FieldbyName('ADDRESS').AsString+''','+
           ''''+crname+''','+
           ''''+crname+''','+
           ''''+GetGender(rs.FieldbyName('GENDER').AsString,1)+''','+
           ''+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString)+','+
           ''''+rs.FieldbyName('HOME_TEL').AsString+''','+
           ''''+rs.FieldbyName('MOBILE_TEL').AsString+''','+
           ''''+rs.FieldbyName('EMAIL').AsString+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('DEGREES').AsString,0))+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('MONTH_PAY').AsString,0))+''','+
           ''''+inttostr(StrtoIntDef(rs.FieldbyName('OCCUPATION').AsString,99))+''','+
           ''''+rs.FieldbyName('JOBUNIT').AsString+''','+
           ''''+rid+''','+
           '''00'','+GetTimeStamp(DbType)+')';

           IcStr :=
             'insert into PUB_IC_INFO(TENANT_ID,CLIENT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,IC_INFO,CREA_USER,IC_STATUS,IC_TYPE,COMM,TIME_STAMP) '+
             'values('+tid+','''+ctid+''','''+pid+''','''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','''+formatDatetime('YYYY-MM-DD',date())+''',null,''烟草消费者'',''system'',''1'',''1'',''00'','+GetTimeStamp(DbType)+')';
             
           IcStr1 :=
             'insert into PUB_IC_INFO(TENANT_ID,CLIENT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,IC_INFO,CREA_USER,IC_STATUS,IC_TYPE,COMM,TIME_STAMP) '+
             'values('+tid+','''+ctid+''',''#'','''+rs.FieldbyName('CONSUMER_CARD_ID').AsString+''','''+formatDatetime('YYYY-MM-DD',date())+''',null,''烟草消费者店内积分'',''system'',''1'',''0'',''00'','+GetTimeStamp(DbType)+')';
             
       end;
    if Str<>'' then
       begin
         ExecSQL(Str,iRect);  
         if IcStr<>'' then
         begin
           ExecSQL(IcStr,iRect);
           ExecSQL(IcStr1,iRect);
         end;
         Str := 'delete from PUB_CUSTOMER_EXT where TENANT_ID='+tid+' and CUST_ID='''+ctid+'''';
         ExecSQL(Str,iRect);

         //开始更新指标
         idx.Close;
         idx.SQL.Text := 'select INDEX_ID,INDEX_NAME,INDEX_TYPE from PUB_UNION_INDEX where UNION_ID='''+pid+'''';
         Open(idx);
         Str := '';
         idx.First;
         while not idx.Eof do
           begin
             if idx.FieldbyName('INDEX_NAME').AsString = '吸烟日期' then
                begin
                  if rs.FieldbyName('SMOKE_DATE').AsString<>'' then
                     begin
                       if length(rs.FieldbyName('SMOKE_DATE').AsString)=6 then
                          icStr := rs.FieldbyName('SMOKE_DATE').AsString+'01'
                       else
                          icStr := rs.FieldbyName('SMOKE_DATE').AsString;
                       Str :=
                        'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                        'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                        formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(icStr))
                        +''',''00'','+GetTimeStamp(DbType)+')';
                       ExecSQL(Str,iRect);
                     end;
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '职业' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DEGREES').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '月收入' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('MONTH_PAY').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '人口类型' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('POP_TYPE').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '焦油含量' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('TAR_CONT').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '吸食口味' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('FAVOR').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '乐意购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '是否购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '购买新品') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('is_buynewitem').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '每日吸烟量' then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DAILY_USE').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜好厂家') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜好厂家') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('DAILY_USE').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱卷烟') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱卷烟') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  GetR3Id(rs.FieldbyName('ITEM_ID').AsString,0)
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱品牌') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱品牌') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  GetR3Id(rs.FieldbyName('BRAND_ID').AsString,4)
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '价位结构') or (idx.FieldbyName('INDEX_NAME').AsString = '常抽价位') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('STRUCT').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '城农网') or (idx.FieldbyName('INDEX_NAME').AsString = '地址类型') then
                begin
                  Str :=
                  'insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
                  'values('''+newid(sid)+''','+tid+','''+pid+''','''+ctid+''','''+idx.FieldbyName('INDEX_ID').AsString+''','''+idx.FieldbyName('INDEX_NAME').AsString+''','''+idx.FieldbyName('INDEX_TYPE').AsString+''','''+
                  rs.FieldbyName('ADDRESS_TYPE').AsString
                  +''',''00'','+GetTimeStamp(DbType)+')';
                  ExecSQL(Str,iRect);
                end;
             idx.Next;
           end; //while not idx.Eof do
         result:=1;
       end;
  finally
    idx.free;
    tmp.free;
  end;
end;

function TPlugSyncVip.GetCurDate(s, format: string): string;
begin
  if s='' then
    result := 'null'
  else
    result := ''''+formatDatetime(format,fnTime.fnStrtoDate(s))+'''';
end;

function TPlugSyncVip.GetGender(n: string; flag: integer): string;
begin
  //RIM:  0:男、1:女  
  //R3:   0:女、1:男 2:保密  
  case flag of
   0: //R3-->Rim
    begin
      if n='0' then
        result := '1'
      else if n='1' then
        result := '0'
      else
        result := '0'; //将R3保密的上传到：男
    end;
   1: //RIM-->R3
    begin
      if n='0' then
        result := '1'
      else if n='1' then
        result := '0'
      else
        result := '2';
    end;
  end;
end;

function TPlugSyncVip.GetPriceId(tid: string): string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select PRICE_ID,PRICE_NAME from PUB_PRICEGRADE where TENANT_ID in (select TENANT_ID from CA_RELATIONS where RELATI_ID='+tid+' AND RELATION_ID=1000006) and PRICE_TYPE=''2''';
    Open(rs);
    result := rs.Fields[0].AsString;
    PRICE_NAME:=trim(rs.Fields[1].AsString);
    if PRICE_NAME='' then PRICE_NAME:='烟草消费者'; 
  finally
    rs.Free;
  end;
end;

function TPlugSyncVip.GetR3Id(id: string; flag: integer): string;
var
  rs:TZQuery;
begin
  result := id;
  if (flag=0) and BasInfo.Locate('SECOND_ID',id,[]) then
     result := BasInfo.FieldbyName('GODS_ID').AsString;
  if (flag=4) then
   begin
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text := 'select ITEM_ID from sd_item A,RIM_GOODS_RELATION B where A.BRAND_ID1='''+id+''' and A.ITEM_ID=B.GODS_ID';
       if Open(rs) then
       begin
         if not rs.IsEmpty and BasInfo.Locate('GODS_ID',rs.Fields[0].AsString,[]) then
           result := rs.FieldbyName('SORT_ID4').AsString;
       end;
     finally
       rs.Free;
     end;
   end;
end;

function TPlugSyncVip.GetRimId(id: string; flag: integer): string;
var
  rs:TZQuery;
begin
  result := id;
  if (flag=0) and BasInfo.Locate('GODS_ID',id,[]) then
     result := BasInfo.FieldbyName('SECOND_ID').AsString;
  if (flag=4) and BasInfo.Locate('SORT_ID4',id,[]) then
   begin
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text := 'select BRAND_ID1 from sd_item where ITEM_ID='''+BasInfo.FieldbyName('SECOND_ID').AsString+'''';
       Open(rs);
       result := rs.Fields[0].AsString;
     finally
       rs.Free;
     end;
   end;
end;

function TPlugSyncVip.GetStamp(UPD_Date, UPD_Time: string): int64;
begin
  upd_time := stringreplace(upd_time,':','',[rfReplaceAll]);
  result := round((fnTime.fnStrToDatetime(UPD_DATE+UPD_TIME)-fnTime.fnStrtoDatetime('20110101000000'))*86400);
end;

function TPlugSyncVip.SyncCustomer(tid, sid, pid: string; today: boolean): Boolean;
var
  str,CustID,rid,UpMsg,DownMsg,SQLStr: string;
  DCount,DErrCount,UCount,UErrCount,ReRun: integer;
  rs: TZQuery;
begin
  result:=False;
  UCount:=0;
  UErrCount:=0;
  DCount:=0;
  DErrCount:=0;
  UpMsg:='';
  DownMsg:='';
                    
  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID,B.REGION_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''' ';
    Open(rs);
    if rs.IsEmpty then
    begin
      Raise Exception.Create(sid+'门店的许可证号在RIM中没找到，请核对许可证号...');
    end;
    custid := rs.fieldbyname('CUST_ID').AsString;
    rid := rs.fieldbyname('REGION_ID').AsString;

    //上传消费者 [全部写Rim表直接开启事务]
    if PlugParams.VipUpload then
    begin
      if PlugParams.USE_SM_CARD then //默认是：直接上报商盟卡
      begin
        SQLStr:=
          'select A.CUST_ID,A.CUST_NAME,A.IDN_TYPE,A.ID_NUMBER,A.FAMI_ADDR,A.SEX,A.BIRTHDAY,A.FAMI_TELE,A.MOVE_TELE,A.POSTALCODE,A.EMAIL,'+
          ' B.IC_CARDNO,B.CREA_DATE,B.END_DATE,B.IC_STATUS,A.MONTH_PAY,A.DEGREES,A.OCCUPATION,A.JOBUNIT,A.TIME_STAMP '+
          ' from PUB_CUSTOMER A,PUB_IC_INFO B '+
          '  where A.TENANT_ID='+tid+' and A.SHOP_ID='''+sid+''' and A.SHOP_ID<>''#'' and B.UNION_ID='''+pid+''' and '+
          '  A.TENANT_ID=B.TENANT_ID and A.CUST_ID=B.CLIENT_ID and A.COMM not in (''02'',''12'') and B.COMM not in (''02'',''12'') ';
      end else
      begin
        SQLStr:=
          'select A.CUST_ID,A.CUST_NAME,A.IDN_TYPE,A.ID_NUMBER,A.FAMI_ADDR,A.SEX,A.BIRTHDAY,A.FAMI_TELE,A.MOVE_TELE,A.POSTALCODE,A.EMAIL,'+
          ' B.IC_CARDNO,B.CREA_DATE,B.END_DATE,B.IC_STATUS,A.MONTH_PAY,A.DEGREES,A.OCCUPATION,A.JOBUNIT,A.TIME_STAMP '+
          ' from PUB_CUSTOMER A,PUB_IC_INFO B '+
          '  where A.TENANT_ID='+tid+' and A.SHOP_ID='''+sid+''' and A.SHOP_ID<>''#'' and B.UNION_ID=''#'' and '+
          '  A.TENANT_ID=B.TENANT_ID and A.CUST_ID=B.CLIENT_ID and A.COMM not in (''02'',''12'') and B.COMM not in (''02'',''12'') ';
      end;
      if today then SQLStr := SQLStr+ ' and A.SND_DATE='''+formatDatetime('YYYY-MM-DD',date())+'''';

      rs.Close;
      rs.SQL.Text:=SQLStr;
      Open(rs);
      rs.First;
      while not rs.Eof do
      begin
        DBFactor.BeginTrans;
        try
          //把此会员信息，同步上去
          ReRun:=UpLoadCustomer(tid,custid,rs);
          DBFactor.CommitTrans;
          if ReRun=1 then Inc(UCount); //累计
        except
          Inc(UErrCount);   //错误累加1;
          DBFactor.RollbackTrans;
          Raise
        end;
        rs.Next;
      end;
    end;
    if toDay then
    begin
      result:=(DErrCount=0);
      Exit;  //前台门店执行，不下载
    end;

    //下载消费者 [全部写R3表，直接启动事务]
    rs.Close;
    rs.SQL.Text:='select * from RIM_VIP_CONSUMER where CUST_ID='''+custid+''' and CONSUMER_STATUS=''03'' ';
    Open(rs);
    rs.First;
    while not rs.Eof do
    begin
      DBFactor.BeginTrans;
      try
        //把此会员信息，下载下来
        ReRun:=DownLoadCustomer(tid,custid,sid,rid,pid,rs);
        DBFactor.CommitTrans;
        if ReRun=1 then Inc(DCount); //累计
      except
        Inc(DErrCount);   //错误累加1;
        DBFactor.RollbackTrans;
        Raise;
      end;
      rs.Next;
    end;

    result:=(DErrCount+UErrCount=0);
  finally
    //上传日志
    AddLogMsg('UpLoadCustomer.Up:'+InttoStr(UCount)+',Error='+InttoStr(UErrCount),1);
    //下载日志
    AddLogMsg('DownLoadCustomer.Down:'+InttoStr(DCount)+',Error='+InttoStr(DErrCount),1);
    
    rs.Free;
  end;
end;

function TPlugSyncVip.UpLoadCustomer(tid, custid: string;rs: TZQuery): integer;
var
  RunFlag: Boolean;
  tmp,idx:TZQuery;
  Str,idno,ctid,Up_CUST_STATUS:string;
  iRect:integer;
begin
  result:=0;
  ctid := StringReplace(rs.FieldbyName('CUST_ID').AsString,'$','',[rfReplaceAll]);
  tmp := TZQuery.Create(nil);
  idx := TZQuery.Create(nil);
  Up_CUST_STATUS:=PlugParams.Up_CUST_STATUS;
  if Up_CUST_STATUS='' then Up_CUST_STATUS:='03';
  try
    tmp.Close;
    tmp.SQL.Text := 'select UPD_DATE,UPD_TIME from RIM_VIP_CONSUMER where CONSUMER_ID='''+ctid+'''';
    Open(tmp);
    
    Str :='';
    if rs.FieldbyName('ID_NUMBER').AsString='' then idno := '无' else idno := rs.FieldbyName('ID_NUMBER').AsString;
    if not tmp.IsEmpty then
       begin
        if rs.FieldByName('TIME_STAMP').AsInteger>=GetStamp(tmp.Fields[0].asString,tmp.Fields[1].asString) then //有更新，则上传
           begin
             Str :=
               'update RIM_VIP_CONSUMER set '+
               'CUST_ID='''+custid+''','+
               'CONSUMER_CARD_ID='''+rs.FieldbyName('IC_CARDNO').AsString+''','+
               'CERT_TYPE_ID='''+fnString.FormatStringEx(rs.FieldbyName('IDN_TYPE').AsString,2)+''','+
               'CERT_ID='''+idno+''','+
               'ADDRESS='''+rs.FieldbyName('FAMI_ADDR').AsString+''','+
               'CR_NAME='''+rs.FieldbyName('CUST_NAME').AsString+''','+
               'GENDER='''+GetGender(rs.FieldbyName('SEX').AsString,0)+''','+
               'BIRTHDAY ='+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString,'YYYYMMDD')+','+
               'HOME_TEL='''+rs.FieldbyName('FAMI_TELE').AsString+''','+
               'MOBILE_TEL ='''+rs.FieldbyName('MOVE_TELE').AsString+''','+
               'EMAIL='''+rs.FieldbyName('EMAIL').AsString+''','+
               'DEGREES='''+fnString.FormatStringEx(rs.FieldbyName('DEGREES').AsString,2)+''','+
               'MONTH_PAY='''+fnString.FormatStringEx(rs.FieldbyName('MONTH_PAY').AsString,2)+''','+
               'OCCUPATION='''+fnString.FormatStringEx(rs.FieldbyName('OCCUPATION').AsString,2)+''','+
               'JOBUNIT='''+rs.FieldbyName('JOBUNIT').AsString+''','+
               'UPD_DATE='''+formatdatetime('YYYYMMDD',Date())+''','+
               'UPD_TIME='''+formatdatetime('HH:NN:SS',now())+''' '+
               'where CONSUMER_ID='''+ctid+'''';
           end;
       end
    else
       begin
         Str :=
           'insert into RIM_VIP_CONSUMER(CONSUMER_ID,CUST_ID,CONSUMER_CARD_ID,CERT_TYPE_ID,CERT_ID,ADDRESS,CR_NAME,GENDER,BIRTHDAY,HOME_TEL,MOBILE_TEL,EMAIL,DEGREES,MONTH_PAY,OCCUPATION,JOBUNIT,UPD_DATE,UPD_TIME,CONSUMER_STATUS,'+
           'POP_TYPE,TAR_CONT,FAVOR,is_buynewitem,DAILY_USE,FACT_ID,ITEM_ID,BRAND_ID,STRUCT,ADDRESS_TYPE) '+
           'values('''+ctid+''','+
           ''''+custid+''','+
           ''''+rs.FieldbyName('IC_CARDNO').AsString+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('IDN_TYPE').AsString,2)+''','+
           ''''+idno+''','+
           ''''+rs.FieldbyName('FAMI_ADDR').AsString+''','+
           ''''+rs.FieldbyName('CUST_NAME').AsString+''','+
           ''''+GetGender(rs.FieldbyName('SEX').AsString,0)+''','+
           ''+GetCurDate(rs.FieldbyName('BIRTHDAY').AsString,'YYYYMMDD')+','+
           ''''+rs.FieldbyName('FAMI_TELE').AsString+''','+
           ''''+rs.FieldbyName('MOVE_TELE').AsString+''','+
           ''''+rs.FieldbyName('EMAIL').AsString+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('DEGREES').AsString,2)+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('MONTH_PAY').AsString,2)+''','+
           ''''+fnString.FormatStringEx(rs.FieldbyName('OCCUPATION').AsString,2)+''','+
           ''''+rs.FieldbyName('JOBUNIT').AsString+''','+
           ''''+formatdatetime('YYYYMMDD',Date())+''','+
           ''''+formatdatetime('HH:NN:SS',now())+''','''+Up_CUST_STATUS+''','+  // ''01''
           '''#'',''#'',''#'',''#'',''#'',''#'',''#'',''#'',''#'',''#'')';
       end;
    if Str<>'' then
       begin
         RunFlag:=ExecSQL(Str,iRect);

         //开始更新指标
         idx.Close;
         idx.SQL.Text := 'select INDEX_ID,INDEX_NAME,INDEX_VALUE from PUB_CUSTOMER_EXT where TENANT_ID='+tid+' and CUST_ID='''+rs.FieldbyName('CUST_ID').AsString+'''';
         Open(idx);
         Str := '';
         idx.First;
         while not idx.Eof do
           begin
             if idx.FieldbyName('INDEX_NAME').AsString = '吸烟日期' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'SMOKE_DATE='''+formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(idx.FieldByName('INDEX_VALUE').AsString) )+''''
                  else
                     Str := Str +'SMOKE_DATE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '职业' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'DEGREES='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'DEGREES=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '月收入' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'MONTH_PAY='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'MONTH_PAY=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '人口类型' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'POP_TYPE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'POP_TYPE=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '焦油含量' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'TAR_CONT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'TAR_CONT=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '吸食口味' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'FAVOR='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'FAVOR=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '乐意购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '是否购买新品') or (idx.FieldbyName('INDEX_NAME').AsString = '购买新品') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'is_buynewitem='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'is_buynewitem=''#''';
                end;
             if idx.FieldbyName('INDEX_NAME').AsString = '每日吸烟量' then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'DAILY_USE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'DAILY_USE=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜好厂家') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜好厂家') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'FACT_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,9)+''''
                  else
                     Str := Str +'FACT_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱卷烟') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱卷烟') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'ITEM_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,0)+''''
                  else
                     Str := Str +'ITEM_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '喜爱品牌') or (idx.FieldbyName('INDEX_NAME').AsString = '最喜爱品牌') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'BRAND_ID='''+GetRimId(idx.FieldByName('INDEX_VALUE').AsString,4)+''''
                  else
                     Str := Str +'BRAND_ID=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '价位结构') or (idx.FieldbyName('INDEX_NAME').AsString = '常抽价位') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'STRUCT='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'STRUCT=''#''';
                end;
             if (idx.FieldbyName('INDEX_NAME').AsString = '城农网') or (idx.FieldbyName('INDEX_NAME').AsString = '地址类型') then
                begin
                  if Str<>'' then Str := Str +',';
                  if idx.FieldByName('INDEX_VALUE').AsString<>'' then
                     Str := Str +'ADDRESS_TYPE='''+idx.FieldByName('INDEX_VALUE').AsString+''''
                  else
                     Str := Str +'ADDRESS_TYPE=''#''';
                end;
             idx.Next;
           end;

        if Str<>'' then
        begin
          Str := 'update RIM_VIP_CONSUMER set '+Str+' where CONSUMER_ID='''+ctid+'''';
          if RunFlag then RunFlag:=ExecSQL(Str,iRect);
        end;
      end;
      if RunFlag then result:=1;
  finally
    idx.free;
    tmp.free;
  end;
end;

{ TPlugSyncWsdlService }

function TPlugSyncWsdlService.DLLDoExecute(InParams: TftParamList; var vData: OleVariant): integer;
var
  N26Version: Boolean;
  RimURL:string;
  Rs: TZQuery;
begin
  result:=-1;
  PlugInID:=5;  //第5位
  if Not SetParamsValue(InParams) then Exit;  //退出不执行

  //返回RimURL
  RimURL:=trim(PlugParams.RimUrl);
  N26Version:=PlugParams.USING_CUST_PSWD;

  rs := TZQuery.Create(nil);
  try
    try
      if N26Version then
         begin
            rs.close;
            rs.SQL.Text:=
               'select A.CUST_ID,A.COM_ID,A.CUST_CODE,A.CUST_PSWD from RM_CUST A,CA_SHOP_INFO B '+
               ' where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenID+' and B.SHOP_ID='''+ShopID+''' ';
         end
      else
         begin
            rs.close;
            rs.SQL.Text:=
               'select A.CUST_ID,A.COM_ID,A.CUST_CODE,A.CUST_CODE from RM_CUST A,CA_SHOP_INFO B '+
               ' where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenID+' and B.SHOP_ID='''+ShopID+''' ';
         end;
      if Open(rs) then
      begin
        Params.ParamByName('xsmuid').AsString := rs.Fields[0].AsString;
        Params.ParamByName('rimuid').AsString := rs.Fields[2].AsString;
        Params.ParamByName('rimpwd').AsString := rs.Fields[3].AsString;
        Params.ParamByName('rimcid').AsString := rs.Fields[1].AsString;
        Params.ParamByName('rimurl').AsString := RimURL;
        vData := Params.Encode(Params);
        result:=0;
      end;
    except
      on E:Exception do
      begin
        Raise Exception.Create('取Rim服务Url错误:'+E.Message);
      end;
    end;
  finally
    rs.Free;
    WriteToFileLog;
  end;
end;

{ TPlugSyncQuestion }

function TPlugSyncQuestion.DLLDoExecute(InParams: TftParamList; var vData: OleVariant): integer;
var
  iRet,ReRun: integer;
  ErrorFlag: Boolean;
  rs: TZQuery;
begin
  result:=-1;
  PlugInID:=6;  //第6位
  if Not SetParamsValue(InParams) then Exit;  //退出不执行
  
  if (FParams.FindParam('FLAG')<>nil) then
    FSyncType:=Params.FindParam('FLAG').AsInteger;

  try
    try
      //提交问卷
      if FSyncType=2 then
      begin
        ReRun:=SyncInvest(TenID,ShopID,Params.ParambyName('QUESTION_ID').asString);
        //提交日志
        AddLogMsg('SyncInvest=',ReRun);
      end else  //下载问卷
      begin
        ReRun:=SyncQuestion(TenID,ShopID);
        //下载日志
        AddLogMsg('SyncQuestion=',ReRun);
      end;
    except
      on E:Exception do
      begin
        Raise Exception.Create('问卷调查失败:'+E.Message);
      end;
    end;
  finally
    WriteToFileLog;
  end;
end;

function TPlugSyncQuestion.GetOPTION_IDS(SUBJECT_ID: string): string;
var
  Rs: TZQuery;
  ReStr: string;
begin
  ReStr:='';
  result:='';
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text := 'select OPTION_ID,OPTION_TITLE from CC_INVEST_OPTION where SUBJECT_ID='''+SUBJECT_ID+''' ';
    if Open(Rs) then
    begin
      ReStr:= '';
      Rs.First;
      while not Rs.Eof do
      begin
        if ReStr<>'' then ReStr := ReStr + ',';
        ReStr := ReStr + '"'+Rs.Fields[0].AsString+'='+Rs.Fields[1].AsString+'"';
        Rs.Next;
      end;
    end;
  finally
    Rs.Free;
  end;
  result:=ReStr;
end;

function TPlugSyncQuestion.SyncInvest(tid, sid, qid: string): integer;
var
  r,vCount,Idx: integer;
  IsComTrans: Boolean; //是否正常提交事务
  mid,An_Value: string;
  RimSQL1,R3SQL,Str: string;
  DetailQry: TZQuery;   //明细查询Qry
  DetailSQlList: TStringList; //明细语句List
begin
  result:=-1;
  Str:='';
  vCount:=0;
  IsComTrans:=False;
  DetailQry:= TZQuery.Create(nil); //明细Qry
  DetailSQlList:=TStringList.Create; //明细SQL.List
  try
    mid := formatDatetime('YYYYMMDDHHNNSS',now())+inttostr(Random(9999999999999999));
    //插入Rim我的调查表
    RimSQL1 :=
      'insert into CC_MYINVESTIGATE(MYINVEST_ID,INVEST_ID,VOLUME_ID,INVEST_DATE,INVEST_TIME,CUST_ID) '+
      'select '''+mid+''',A.INVEST_ID,A.VOLUME_ID,'''+formatDatetime('YYYYMMDD',date())+''','''+formatDatetime('HH:NN:SS',now())+''','''+CustID+''' '+
      ' from CC_INVESTIGATE A,MSC_QUESTION B,MSC_INVEST_LIST C where B.TENANT_ID='+tid+' and B.COMM_ID=A.INVEST_ID '+
      ' and B.QUESTION_ID='''+qid+''' and B.TENANT_ID=C.TENANT_ID and B.QUESTION_ID=C.QUESTION_ID and C.QUESTION_FEEDBACK_STATUS=1 and C.QUESTION_ANSWER_STATUS=1 and C.SHOP_ID='''+sid+''' '+
      ' and not Exists(select * from CC_MYINVESTIGATE D where A.INVEST_ID=D.INVEST_ID and D.CUST_ID='''+CustID+''')';

    //插入Rim我的调查行表
    DetailQry.Close;
    DetailQry.SQL.Text:=
      'select B.COMM_ID,A.ANSWER_VALUE from MSC_INVEST_ANSWER A,MSC_QUESTION_ITEM B '+
      ' where A.TENANT_ID=B.TENANT_ID and A.QUESTION_ID=B.QUESTION_ID and  A.QUESTION_ITEM_ID=B.QUESTION_ITEM_ID and A.TENANT_ID='+tid+' and A.SHOP_ID='''+sid+''' and A.QUESTION_ID='''+qid+'''';
    if Open(DetailQry) then //明细List
    begin
      DetailQry.First;
      while not DetailQry.Eof do
      begin
        An_Value:=trim(DetailQry.fieldbyName('ANSWER_VALUE').AsString);
        while length(trim(An_Value))>5 do
        begin
          Idx:=Pos(',',An_Value);
          if Idx>0 then //多个有豆号间隔
          begin
            Str:='insert into CC_MYINVEST_SUBJECT(MYSUBJECT_ID,MYINVEST_ID,SUBJECT_ID,MYOPTION_ID) values '+
                 '('''+newRandomId()+''','''+mid+''','''+DetailQry.fieldbyName('COMM_ID').AsString+''','''+Copy(An_Value,1,Idx-1)+''')';
            DetailSQlList.Add(Str);
            An_Value:=Copy(An_Value,Idx+1,Length(An_Value)-Idx-1); //删除前面字符
          end else
          begin //单个情况
            Str:='insert into CC_MYINVEST_SUBJECT(MYSUBJECT_ID,MYINVEST_ID,SUBJECT_ID,MYOPTION_ID) values '+
                 '('''+newRandomId()+''','''+mid+''','''+DetailQry.fieldbyName('COMM_ID').AsString+''','''+An_Value+''')';
            DetailSQlList.Add(Str);
            An_Value:='';
          end;
        end;
        DetailQry.Next;
      end;             
    end;
 
    //更新R3提交状态
    R3SQL:='update MSC_INVEST_LIST set QUESTION_FEEDBACK_STATUS=2 where TENANT_ID='+tid+' and SHOP_ID='''+sid+''' and QUESTION_ID='''+qid+''' ';

    if TWO_PHASE_COMMIT then //启用分布式事务同时更新
    begin
      try
        DBFactor.BeginTrans;
        ExecSQL(RimSQL1,r);
        if r>0 then
        begin
          ExecSQL(DetailSQlList,r);
          ExecSQL(R3SQL,r);
        end;
        DBFactor.CommitTrans;
        result:=0;
      except
        DBFactor.RollbackTrans;
        Raise
      end;
    end else
    begin
      //开始写Rim事务
      try
        DBFactor.BeginTrans;
        ExecSQL(RimSQL1,r);
        vCount:=r;
        if r>0 then
        begin
          ExecSQL(DetailSQlList,r);
          vCount:=vCount+r;
        end;
        DBFactor.CommitTrans;
        IsComTrans:=true;
      except
        DBFactor.RollbackTrans;
        Raise
      end;
      //开始写R3事务
      if IsComTrans and (vCount>0) then ExecTransSQL(R3SQL,r);
      result:=0;
    end;
  finally
    DetailQry.Free;
    DetailSQlList.Free;
  end;
end;

function TPlugSyncQuestion.SyncQuestion(tid, sid: string): integer;
var
  r,vCount:integer;
  str,mid,Msg:string;
  rs: TZQuery;
  Beg_Date,END_Date,IS_REPEAT: string;
begin
  Result:=-1;
  vCount:=0;
  Msg:='';
  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:=
       'select INVEST_ID,VOLUME_ID,BEGIN_DATE,END_DATE,IS_REPEAT from CC_INVESTIGATE A where A.INVEST_GROUP=''01'' and A.END_DATE>='''+FormatDatetime('YYYYMMDD',Now())+''' '+
       'and not exists(select * from MSC_INVEST_LIST B where A.INVEST_ID=B.COMM_ID and B.TENANT_ID='+tid+' and B.SHOP_ID='''+sid+''')';
    Open(rs);
    rs.First;
    while not rs.Eof do
    begin
      try
        DBFactor.BeginTrans; //开始事务
        mid := newid(sid);
        Beg_Date:=rs.fieldbyName('BEGIN_DATE').AsString;
        END_Date:=trim(rs.fieldbyName('END_DATE').AsString);
        END_Date:=Copy(END_Date,1,4)+'-'+Copy(END_Date,5,2)+'-'+Copy(END_Date,7,2);  //转成[2011-07-29]格式
        if trim(rs.fieldbyName('IS_REPEAT').AsString)='1' then //(1:是,0:否)
          IS_REPEAT:='1'
        else
          IS_REPEAT:='2';

        str :=
          'insert into MSC_QUESTION(TENANT_ID,QUESTION_ID,QUESTION_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,QUESTION_SOURCE,ISSUE_USER,QUESTION_TITLE,ANSWER_FLAG,QUESTION_ITEM_AMT,REMARK,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
          'select '+tid+','''+mid+''',''1'','+Beg_Date+',0,A.INVEST_NAME,''system'',B.VOLUME_NAME,'''+IS_REPEAT+''',0,B.VOLUME_NOTE,'''+END_Date+''',A.INVEST_ID,''00'','+GetTimeStamp(DbType)+' '+
          'from CC_INVESTIGATE A,CC_VOLUME B where A.VOLUME_ID=B.VOLUME_ID and A.ORGAN_ID=B.ORGAN_ID and '+
          ' A.INVEST_ID='''+rs.Fields[0].asString+''' and A.ORGAN_ID='''+ComID+''' and not exists(select * from MSC_QUESTION B where A.INVEST_ID=B.COMM_ID and B.TENANT_ID='+tid+')';
        ExecSQL(str,r);

        //初始化[一张问卷]题目
        if r>0 then
          Write_Question_Page(rs.Fields[1].AsString,tid,sid,Mid);  //VOLUME_ID

        str:='insert into MSC_INVEST_LIST(TENANT_ID,QUESTION_ID,SHOP_ID,QUESTION_FEEDBACK_STATUS,QUESTION_ANSWER_STATUS,COMM_ID,COMM,TIME_STAMP) '+
             'values('+tid+','''+mid+''','''+sid+''',1,2,'''+rs.Fields[0].AsString+''',''00'','+GetTimeStamp(DbType)+')';
        ExecSQL(str,r);
        DBFactor.CommitTrans;
        result:=0;
        Inc(vCount);
      except
        on E:Exception do
        begin
          DBFactor.RollbackTrans;
          if Msg='' then Msg:=E.Message else Msg:=Msg+'; '+E.Message;
        end;
      end;
      rs.Next;
    end;
  finally
    rs.Free;
  end;
end;

function TPlugSyncQuestion.Write_Question_Page(Volume_ID, tid, sid,Mid: string): string;
var
  r: integer;
  str,S,imust: string;
  tmp: TZQuery;
begin
  tmp:=TZQuery.Create(nil);
  try
    tmp.Close;
    tmp.SQL.Text := 'select SUBJECT_ID,SUBJECT_TITLE,SUBJECT_TYPE,IS_MUST,NOTE from CC_INVEST_ITEM where VOLUME_ID='''+Volume_ID+'''';
    Open(tmp);
    tmp.First;
    while not tmp.Eof do
    begin
      S:=GetOPTION_IDS(tmp.fieldbyName('SUBJECT_ID').AsString); //返回答案的选项
      if trim(S)='' then
        Raise Exception.Create('<题目：'+tmp.FieldByName('SUBJECT_TITLE').AsString+'['+tmp.FieldByName('SUBJECT_ID').AsString+']>没有答案选项');
      if tmp.Fields[3].AsString ='Y' then imust := '1' else imust := '2';
      str :=
        'insert into MSC_QUESTION_ITEM(TENANT_ID,QUESTION_ID,QUESTION_ITEM_ID,SEQ_NO,QUESTION_ITEM_TYPE,QUESTION_IS_MUST,QUESTION_INFO,QUESTION_OPTIONS,COMM_ID)'+
        'values('+tid+','''+mid+''','''+newid(sid)+''','+inttostr(tmp.RecNo)+','''+inttostr(tmp.Fields[2].asInteger+1)+''','''+imust+''','''+tmp.Fields[1].AsString+''','''+s+''','''+tmp.Fields[0].AsString+''')';
      ExecSQL(Str,r,'MSC_QUESTION_ITEM.TENANT_ID='+TenID);
      tmp.Next;
    end;
    str := 'update MSC_QUESTION set QUESTION_ITEM_AMT='+inttostr(tmp.recordCount)+' where TENANT_ID='+tid+' and QUESTION_ID='''+mid+'''';
    ExecSQL(Str,r,'MSC_QUESTION.TENANT_ID='+TenID);
  finally
    tmp.Free;
  end;
end;


initialization
  ReadPlugInCfg(PlugParams);

finalization



end.
