{------------------------------------------------------------------------------
  第三方系统数据（插件）公共单元
    1、共用函数；
    2、数据结构定义
    3、基类
    
 ------------------------------------------------------------------------------}

unit uBaseSyncFactory;

interface

uses
  SysUtils, Windows, Variants, Classes, Forms, Dialogs, DB, zDataSet, zBase;

const
  //国家烟草供应链ID:1000006
  NT_RELATION_ID=1000006;

type
  TConParam= Record
    DbType: integer;    //数据库类型
    RmServerIP: string; //远程服务器IP
    PortNum: string;    //端口号
    LogName: string;    //登陆名
    LogPwd:  string;    //登陆密码
  end;

type
  TRunInfo=Record  
    BegTime: string;      //开始上报时间点
    BegTick: integer;     //开始上报GetTickCount
    AllCount: integer;    //上报总门店数
    RunCount: integer;    //上报成功门店数
    NotCount: integer;    //对应不上[R3门店  对不上  Rim零售户]
    ErrorCount: integer;  //上报存在错误门店数
    ErrorStr: string;     //运行错误Str
  end;


type
  TRimParams=Record
    ComID: string;      //RIM烟草公司ID
    CustID: string;     //RIM零售户ID
    TenID: string;      //R3上报企业ID
    TenName: string;    //R3上报企业Name
    ShopID: string;     //R3上报门店ID
    ShopName: string;   //R3上报门店名称;
    LICENSE_CODE: string;  //零售户许可证号
    SHORT_ShopID: string;  //R3上报门店ID后4位
  end;

//第三方系统数据对接的接口
type
  IPlugIn = Interface(IUnknown)
    ['{34E06C0E-34E5-4BB8-A10F-3F1ECB983AD8}']
    //设置当前插件参数,指定连锁ID号
    function SetParams(DbID:integer):integer; stdcall;
    //读取执行出错信息说明
    function GetLastError:Pchar; stdcall;
    //开始事务, 超时设置 单位秒
    function BeginTrans(TimeOut:integer=-1):integer; stdcall;
    //提交事务
    function CommitTrans:integer; stdcall;
    //回滚事务
    function RollbackTrans:integer; stdcall;
    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function iDbType(var dbType:integer):integer; stdcall; 
    //HRESULT 返回值说明 =0表示执行成功 否则为错误代码
    function Open(SQL:Pchar;var Data:OleVariant):integer;stdcall;
    //提交数据集
    function UpdateBatch(Delta:OleVariant;ZClassName:Pchar):integer;stdcall;
    //返回执行影响记录数
    function ExecSQL(SQL:Pchar;var iRet:integer):integer;stdcall;
    //锁定连接
    function DbLock(Locked:boolean):integer;stdcall;
    //日志服务
    function WriteLogFile(s:Pchar):integer;stdcall;
  end;

//门店上报日志
type
  TLogShopInfo=class
  private
    FRuniRet: integer;  //总上报记录数
    FBegTickCount: integer; //开始上报时间点
    FBegTime: string;   //开始上报时间点
    FShopName: string;  //当前上报门店
    FErrorState: Boolean;  //全部执行成功状态
    FBillList: TStringList;
    FLogKind: integer;
    FSyncType: integer; //上报单据列表
    function GetTickTime: string;
    procedure SetLogKind(const Value: integer);
    procedure SetSyncType(const Value: integer);
  public
    constructor Create;
    destructor Destroy;override;
    procedure BeginLog(const ShopName: string); //初始化参数
    //vType: 1:表示成功; 0:表示错误;
    function AddBillMsg(BillName: string;iRect: integer=-1): Boolean;
    function SetLogMsg(SetList: TStringList; vNum: integer=0): Boolean; //返回日志内容
    property RuniRet: integer read FRuniRet; //运行更改记录数
    property ErrorState: Boolean read FErrorState; //运行状态[默认为False]
    property BillList: TStringList read FBillList;
    property LogKind: integer read FLogKind write SetLogKind;  //日志类型[0:简单；1:详细]
    property SyncType: integer read FSyncType write SetSyncType;          //上报方式:（0: 调度执行； 3：前台传入执行)    
  end;

//第三方系统数据对接的基类
type
  TBaseSyncFactory=class
  private
    FPlugIntf: IPlugIn;
    FParams: TftParamList;
    FDbType: Integer;
    FLogList: TStringList;
    FHasError: boolean;
    FErrorMsg: string;
    FTWO_PHASE_COMMIT: Boolean;
    FKeepLogDay: integer;
    FLogKind: integer;
    FPlugInID: string;
    procedure SetPlugIntf(const Value: IPlugIn);
    procedure SetParams(const Value: TftParamList);
    procedure SetDbType(const Value: Integer);
    procedure SetHasError(const Value: boolean);
    procedure SetErrorMsg(const Value: string);
    procedure SetTWO_PHASE_COMMIT(const Value: Boolean);
    function  GetUpdateTime: string;
    procedure SetKeepLogDay(const Value: integer);
    procedure SetLogKind(const Value: integer);
    procedure SetPlugInID(const Value: string);
  public
    FRunInfo: TRunInfo; //日志信息
    constructor Create; virtual;
    destructor Destroy;override;
    function  CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; virtual; {==返回：0执行成功==}
    //锁定数据库
    function  DBLock(Locked: Boolean):Boolean; //锁定数据库连接
    //返回数据库类型
    function  GetDBType: integer;

    //事务控制
    function  BeginTrans(TimeOut:integer=-1): Boolean; //开始事务
    function  CommitTrans: Boolean;   //提交事务
    function  RollbackTrans: Boolean; //回滚事务
    function  Open(DataSet: TDataSet):Boolean;  //取数据
    procedure WriteRunErrorMsg(Msg: string);  //写日志

    //返回类函数
    class function newId(id:string=''): string; //获取GUID
    class function newRandomId: string;        //返回时间+随机编号ID
    class function GetTickTime: string;   //返回当前时间
    class function OpenData(GPlugIn: IPlugIn; Qry: TZQuery):Boolean;  //取数据（暂时兼容以前使用）
    class function GetCommStr(iDbType:integer;alias:string=''):string;
    class function GetUpCommStr(iDbType:integer;alias:string=''):string;
    class function GetTimeStamp(iDbType:Integer):string;   //返回时间戳
    class function GetDefaultUnitCalc(AliasTable: string=''): string;  //返回转换后单位ID
    class function ParseSQL(iDbType:integer;SQL:string):string;    //通用函数转换
    class function ReadConfig(Header,Ident,DefValue:string; IniFile: string=''):string;  //读配置文件
    class function WriteConfig(Header,Ident,Value:string; IniFile: string=''):Boolean; //写配置文件

    //调试及跟踪运行使用
    property PlugInID: string read FPlugInID write SetPlugInID; //插件ID号
    property KeepLogDay: integer read FKeepLogDay write SetKeepLogDay;  //保留最近上报日志数，默认：30
    property LogKind: integer read FLogKind write SetLogKind;    //日志类型[0:简单；1:详细]
    
    //数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase 3: access  4: db2
    property DbType:Integer read FDbType write SetDbType;
    property Params:TftParamList read FParams write SetParams;
    property PlugIntf: IPlugIn read FPlugIntf write SetPlugIntf;
    property LogList: TStringList read FLogList;
    property UpdateTime: string read GetUpdateTime; //最新更新时间[YYYY-MM-DD_HH:MM:SS]
    property HasError: boolean read FHasError write SetHasError;   //插件运行是否错误
    property ErrorMsg: string read FErrorMsg write SetErrorMsg;    //插件运行第一错误消息
    property TWO_PHASE_COMMIT: Boolean read FTWO_PHASE_COMMIT write SetTWO_PHASE_COMMIT; //是否启用分布式事务[默认启用事务] [0:不启用]
  end;


//共用变量定义
var
  GPlugIn: IPlugIn;
  GLastError:string;

implementation

uses
  IniFiles;


{ TLogShopInfo }
constructor TLogShopInfo.Create;
begin
  FBillList:=TStringList.Create;
end;

destructor TLogShopInfo.Destroy;
begin
  FBillList.Free;
  inherited;
end;

//vType: 1:表示成功; 0:表示错误;
function TLogShopInfo.AddBillMsg(BillName: string; iRect: integer): Boolean;
begin
  if SyncType=3 then Exit; //前台传入执行不日志

  if not FErrorState then
  begin
    FErrorState:=(iRect=-1);
  end;
  if iRect=-1 then
    FBillList.Add(BillName+'上报错误')
  else
  begin
    if LogKind=1 then //详细日志才写
      FBillList.Add(BillName+'上报：'+inttoStr(iRect)+'笔');
    FRuniRet:=FRuniRet+iRect;
  end;
end;

procedure TLogShopInfo.BeginLog(const ShopName: string);
begin
  if SyncType=3 then Exit; //前台传入执行不日志
  
  FShopName:=ShopName;
  FBegTime:=GetTickTime;
  FBegTickCount:=GetTickCount;
  FRuniRet:=0;
  FErrorState:=False;
  FBillList.Clear;
end;

function TLogShopInfo.SetLogMsg(SetList: TStringList; vNum: integer): Boolean;
var
  i: integer;
  isFirst: Boolean;
  Str,NumStr,TitleStr,ResutMsg: string;
begin
  result:=False;
  if SyncType=3 then Exit; //前台传入执行不日志
  
  isFirst:=False;
  if vNum=0 then NumStr:='    ' else  NumStr:='  ('+InttoStr(vNum)+')';
  if LogKind=1 then NumStr:=Copy(GetTickTime,4,8)+NumStr;  
  FBegTickCount:=GetTickCount-FBegTickCount;
  Str:='';
  TitleStr:=NumStr+'门店<'+FShopName+'>';
  if FErrorState then //没有全部上报成功
    TitleStr:=TitleStr+'〖有异常〗，同步<'+inttoStr(FRuniRet)+'>笔;'
  else
    TitleStr:=TitleStr+'〖正常〗，同步<'+inttoStr(FRuniRet)+'>笔;';

  if LogKind=1 then
    TitleStr:=TitleStr+' 运行：'+FormatFloat('#0.00',FBegTickCount/1000)+'秒';

  case LogKind of
   1:
    begin
      if FBillList.Count=1 then
      begin
        TitleStr:=TitleStr+'    详细:'+trim(FBillList.Strings[0]);
        SetList.Add(TitleStr); 
      end else
      begin
        SetList.Add(TitleStr);  //添加标题
        for i:=0 to FBillList.Count-1 do
        begin
          if Str='' then
            Str:='('+InttoStr(i+1)+')'+trim(FBillList.Strings[i]) 
          else
            Str:=Str+'; ('+InttoStr(i+1)+')'+trim(FBillList.Strings[i]);
          if (i+1) mod 5 =0 then
          begin
            if not isFirst then
            begin
              Str:='    详细:'+Str;
              isFirst:=true;
            end else
              Str:='         '+Str;
            SetList.Add(Str);
            Str:='';
          end;
        end;
        if Str<>'' then
        begin
          if not isFirst then
            Str:='    详细:'+Str
          else
            Str:='         '+Str;
          SetList.Add(Str);
        end;
      end;
    end;
   else
    begin
      for i:=0 to FBillList.Count-1 do
      begin
        if Str='' then
          Str:='('+InttoStr(i+1)+')'+trim(FBillList.Strings[i])
        else
          Str:=Str+'; ('+InttoStr(i+1)+')'+trim(FBillList.Strings[i]);
      end;
      TitleStr:=TitleStr+Str;
      SetList.Add(TitleStr); 
    end;
  end;
  result:=true;
end;

function TLogShopInfo.GetTickTime: string;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(time(), Hour, Min, Sec, MSec);
  result:=FormatFloat('00',Hour)+':'+FormatFloat('00',Min)+':'+FormatFloat('00',Sec)+':'+FormatFloat('00',MSec);
end;

procedure TLogShopInfo.SetLogKind(const Value: integer);
begin
  FLogKind := Value;
end;

procedure TLogShopInfo.SetSyncType(const Value: integer);
begin
  FSyncType := Value;
end;

{ TBaseSyncFactory }

constructor TBaseSyncFactory.Create;
begin
  inherited;
  FParams := TftParamList.Create(nil);
  FLogList:= TStringList.Create;
  //读取配置参数
  TWO_PHASE_COMMIT:=trim(ReadConfig('PARAMS','TWO_PHASE_COMMIT','1'))<>'0';
  KeepLogDay:=StrToInt(ReadConfig('PARAMS','KEEP_LOG_DAY','30'));
  LogKind:=StrToInt(ReadConfig('PARAMS','LOG_KIND','0'));
end;

function TBaseSyncFactory.DBLock(Locked: Boolean): Boolean;
var
  ErrMsg: string;
begin
  if Locked then
    ErrMsg:='锁定数据库连接错误:'
  else
    ErrMsg:='解锁数据库连接错误:'; 
  if PlugIntf.DbLock(Locked)<>0 then
    Raise Exception.Create(ErrMsg+PlugIntf.GetLastError);
end;

function TBaseSyncFactory.GetDBType: Integer;
begin
  Result:=PlugIntf.iDbType(FDbType);
  if Result<>0 then
    Raise Exception.Create('返回数据库类型错误：'+PlugIntf.GetLastError);
end;

destructor TBaseSyncFactory.Destroy;
begin
  FParams.Free;
  FLogList.Free;
  inherited;
end;

class function TBaseSyncFactory.newId(id: string): string;
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

class function TBaseSyncFactory.newRandomId: string;
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

class function TBaseSyncFactory.GetTimeStamp(iDbType: Integer): string;
begin
  case iDbType of
   0:Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
   1:Result := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))+(sysdate - trunc(sysdate))*24*60*60';
   4:result := '86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))+MIDNIGHT_SECONDS(CURRENT TIMESTAMP)';
   //5:result := 'strftime(''%s'',''now'',''localtime'')-1293840000'; //没有修改[暂时未找到对应函数处理]
   else Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
  end;
end;


class function TBaseSyncFactory.GetDefaultUnitCalc(AliasTable: string): string;
var
  AliasTab: string;
begin
  if trim(AliasTable)<>'' then
    AliasTab:=trim(AliasTable)+'.';
  result:=
    'case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.00 '+             //默认单位为 计量单位
        ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC*1.00 '+  //默认单位为 小单位
        ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC*1.00 '+      //默认单位为 大单位
        ' else 1.00 end ';                                                        //都不是则默认为换算为1;
end;

class function TBaseSyncFactory.ParseSQL(iDbType: integer; SQL: string): string;
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

function TBaseSyncFactory.Open(DataSet: TDataSet): Boolean;
var
  ReRun: integer;
  vData: OleVariant;
begin
  result:=False;
  if DataSet.ClassNameIs('TZQuery') then //TZQuery
  begin
    try
      TZQuery(DataSet).Close;
      ReRun:=PlugIntf.Open(Pchar(TZQuery(DataSet).SQL.Text),vData);
      if ReRun<>0 then Raise Exception.Create(PlugIntf.GetLastError);
      TZQuery(DataSet).Data:=vData;
      Result:=TZQuery(DataSet).Active;
    except
      on E:Exception do
      begin
        HasError:=true;
        ErrorMsg:=PlugIntf.GetLastError;
        Raise Exception.Create(Pchar('<'+PlugInID+'>Open'+TZQuery(DataSet).SQL.Text+' Error：'+E.Message));
      end;
    end;
  end
end;

procedure TBaseSyncFactory.SetDbType(const Value: Integer);
begin
  FDbType := Value;
end;

procedure TBaseSyncFactory.SetParams(const Value: TftParamList);
begin
  FParams := Value;
end;

procedure TBaseSyncFactory.SetPlugIntf(const Value: IPlugIn);
begin
   FPlugIntf := Value;
end;

function TBaseSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  
end;

function TBaseSyncFactory.BeginTrans(TimeOut: integer): Boolean;
begin
  result:=false;
  if PlugIntf.BeginTrans(TimeOut)<>0 then Raise Exception.Create('启动事务：'+PlugIntf.GetLastError);
  result:=true;
end;

function TBaseSyncFactory.CommitTrans: Boolean;
begin
  result:=false;
  if PlugIntf.CommitTrans<>0 then Raise Exception.Create('提交事务：'+PlugIntf.GetLastError);
  result:=true;
end;

function TBaseSyncFactory.RollbackTrans: Boolean;
begin
  result:=false;
  if PlugIntf.RollbackTrans<>0 then Raise Exception.Create('回滚事务：'+PlugIntf.GetLastError);
  result:=true;
end;

class function TBaseSyncFactory.GetCommStr(iDbType: integer; alias: string): string;
begin
  case iDbType of
   0: result := 'case when substring('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
   3: result := 'case when mid('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
   1,5:result := 'case when substr('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
   4: result := 'case when substr('+alias+'COMM,1,1)=''1'' then ''01'' else ''00'' end';
  else
    result := '''00''';
  end;
end;


class function TBaseSyncFactory.GetUpCommStr(iDbType: integer; alias: string): string;
begin
  case iDbType of
   0: result := ' ''1''+substring('+alias+'COMM,2,1) ';
   3: result := ' ''1''+mid('+alias+'COMM,2,1) ';
   1,4,5:
      result := ' ''1'' || substr('+alias+'COMM,2,1) ';
  end;
end;

class function TBaseSyncFactory.GetTickTime: string;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(time(), Hour, Min, Sec, MSec);
  result:=FormatFloat('00',Hour)+':'+FormatFloat('00',Min)+':'+FormatFloat('00',Sec)+':'+FormatFloat('00',MSec);
end;

class function TBaseSyncFactory.OpenData(GPlugIn: IPlugIn; Qry: TZQuery): Boolean;
var
  ReRun: integer;
  vData: OleVariant;
begin
  result:=False;
  try
    Qry.Close;
    ReRun:=GPlugIn.Open(Pchar(Qry.SQL.Text),vData);
    if ReRun<>0 then Raise Exception.Create(GPlugIn.GetLastError);
    Qry.Data:=vData;
    Result:=Qry.Active;
  except
    on E:Exception do
    begin
      Raise Exception.Create(Pchar('PlugIntf.Open:('+Qry.SQL.Text+') 错误：'+E.Message));
    end;
  end;
end;


function TBaseSyncFactory.GetUpdateTime: string;
var
  vYear,vMonth,vDay,vHour,vMin, vSec,vMSec: Word;
begin
  DecodeDate(Date(), vYear, vMonth,vDay);
  result:=FormatFloat('0000',vYear)+'-'+FormatFloat('00',vMonth)+'-'+FormatFloat('00',vDay);  //10位
  DecodeTime(Time(), vHour, vMin, vSec, vMSec);
  result:=result+' '+FormatFloat('00',vHour)+':'+FormatFloat('00',vMin)+':'+FormatFloat('00',vSec);
end;

procedure TBaseSyncFactory.SetHasError(const Value: boolean);
begin
  FHasError := Value;
end;

procedure TBaseSyncFactory.SetErrorMsg(const Value: string);
begin
  FErrorMsg := Value;
end;

procedure TBaseSyncFactory.WriteRunErrorMsg(Msg: string);
begin
  if HasError then Exit;
  //永远只记录第一个错误消息
  HasError:=true;
  ErrorMsg:=Msg; 
end;

procedure TBaseSyncFactory.SetTWO_PHASE_COMMIT(const Value: Boolean);
begin
  FTWO_PHASE_COMMIT := Value;
end;

class function TBaseSyncFactory.ReadConfig(Header,Ident,DefValue:string; IniFile: string=''): string;
var F: TIniFile; FileName: string; 
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

class function TBaseSyncFactory.WriteConfig(Header,Ident,Value:string; IniFile: string=''): Boolean;
var F: TIniFile; FileName: string; 
begin
  result:=False;
  if trim(IniFile)='' then
    FileName:=ExtractFilePath(Application.ExeName)+'PlugIn.cfg';
  F:=TIniFile.Create(FileName);
  try
    F.WriteString(Header,Ident,Value);
    result:=true;
  finally
    F.Free;
  end;
end;

procedure TBaseSyncFactory.SetKeepLogDay(const Value: integer);
begin
  FKeepLogDay := Value;
end;

procedure TBaseSyncFactory.SetLogKind(const Value: integer);
begin
  FLogKind := Value;
end;

procedure TBaseSyncFactory.SetPlugInID(const Value: string);
begin
  FPlugInID := Value;
end;

end.
