{------------------------------------------------------------------------------
  插件共用函数单元

  
 ------------------------------------------------------------------------------}
unit uPlugInUtil;

interface

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase;

const
  //国家烟草供应链ID:1000006
  NT_RELATION_ID=1000006;
  
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
    BegTime: string;   //开始上报时间点
    BegTick: integer;  //开始上报GetTickCount
    ReCount: integer;  //上报记录数据[单据数量]
    ErCount: integer;  //错误数量
  end;  


function GetMaxNUM(PlugIntf:IPlugIn; BillType,SHOP_ID,ORGAN_ID,CustID: string): string; //2011.04.14 获取上报最大编号(MaxNum)
function GetRimCust_ID(PlugIntf:IPlugIn; Rim_ORGAN_ID,LICENSE_CODE: string): string;  //2011.05.25 获取Rim零售户IDCust_ID
function GetRimOrgan_ID(PlugIntf:IPlugIn; R3_TENANT_ID: string): string;  //2011.05.25 获取Rim烟草公司ORGANID(COM_ID)
function GetR3ReportShopList(PlugIntf:IPlugIn; ShopList: TZQuery; InParams: string): Boolean;

//插件常用函数
function NewId(id:string=''): string; //获取GUID
function OpenData(GPlugIn: IPlugIn; Qry: TZQuery): Boolean;    //查询数据
function GetValue(GPlugIn: IPlugIn; SQL: string; FieldName: string=''): string; //返回某个字段值
function WriteToRIM_BAL_LOG(PlugIntf:IPlugIn; LICENSE_CODE,CustID,LogType,LogNote,LogStatus: string; USER_ID: string='auto'): Boolean; //返回插入语句执行返回值;
function GetDefaultUnitCalc(AliasTable: string=''): string;  //返回转换后单位ID
procedure DBLock(GPlugIn: IPlugIn; Locked: Boolean);  //锁定数据连接
function ParseSQL(iDbType:integer;SQL:string):string;
function GetTimeStamp(iDbType:Integer):string;

//共用变量定义
var
  GPlugIn: IPlugIn;
  GLastError:string;

implementation


//2011.05.25 获取Rim零售户IDCust_ID
function GetRimCust_ID(PlugIntf:IPlugIn; Rim_ORGAN_ID,LICENSE_CODE: string): string;
var
  Rs: TZQuery;
begin
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select CUST_ID from RM_CUST where COM_ID='''+Rim_ORGAN_ID+''' and LICENSE_CODE='''+LICENSE_CODE+'''';
    if OpenData(PlugIntf,Rs) then
      result:=trim(Rs.Fields[0].AsString);
  finally
    Rs.Free;
  end;
end;


//2011.05.25 获取Rim烟草公司ORGANID(COM_ID)
function GetRimOrgan_ID(PlugIntf:IPlugIn; R3_TENANT_ID: string): string;
var
  Rs: TZQuery;
begin
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select A.ORGAN_ID from PUB_ORGAN A,CA_TENANT B where B.LOGIN_NAME=A.ORGAN_CODE and B.TENANT_ID='+R3_TENANT_ID+' ';
    if OpenData(PlugIntf,Rs) then
      result:=trim(Rs.Fields[0].AsString);
  finally
    Rs.Free;
  end;
end;

function GetR3ReportShopList(PlugIntf:IPlugIn; ShopList: TZQuery; InParams: string): Boolean;
var
  Str: string;
  IsFlag: Boolean;
  vParam: TftParamList;
begin
  result:=False;
  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,InParams);
    if (vParam.FindParam('FLAG')<>nil) and (vParam.FindParam('TYPE').AsInteger=3)  then  //门店直接上报
    begin
      //(企业名称,门店ID,门店名称,门店许可证号):
      Str:='select TE.TENANT_ID,TE.TENANT_NAME,SH.SHOP_ID,SH.SHOP_NAME,SH.LICENSE_CODE from CA_SHOP_INFO SH,CA_TENANT TE '+
           ' where SH.TENANT_ID=TE.TENANT_ID and  SH.TENANT_ID='+vParam.ParamByName('TENANT_ID').AsString+' and SH.SHOP_ID='''+vParam.ParamByName('SHOP_ID').AsString+''' ';
    end else  //调度上报：烟草公司企业
    begin
      //供应链关系表[返回传入企业所有下级企业]:
      Str:='select T.TENANT_ID,T.TENANT_NAME from CA_TENANT T,CA_RELATIONS R '+
           ' where T.TENANT_ID=R.RELATI_ID and T.COMM not in (''02'',''12'') and R.TENANT_ID='+vParam.ParamByName('TENANT_ID').AsString+' and R.RELATION_ID=1000006';

      //(企业名称,门店ID,门店名称,门店许可证号):
      Str:='select TE.TENANT_ID,TE.TENANT_NAME,SH.SHOP_ID,SH.SHOP_NAME,SH.LICENSE_CODE '+
           ' from CA_SHOP_INFO SH,('+Str+') TE where SH.TENANT_ID=TE.TENANT_ID order by TE.TENANT_ID,SH.SHOP_ID ';
    end;
    
    ShopList.Close;
    ShopList.SQL.Text:=Str;
    result:=OpenData(PlugIntf, ShopList); 
  finally
    vParam.Free;
  end;  
end;

//2011.04.14 获取上报最大编号(MaxNum)
function GetMaxNUM(PlugIntf:IPlugIn; BillType,SHOP_ID,ORGAN_ID,CustID: string): string;
var
  iRet: integer;
  Str: string;
  Rs: TZQuery;
begin
  result:='';
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select MAX_NUM from RIM_R3_NUM where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE='''+BillType+''' and TERM_ID='''+SHOP_ID+'''';
    if OpenData(PlugIntf, Rs) then
      result:=trim(Rs.Fields[0].AsString);
    if result='' then result:='0';
    if Rs.IsEmpty then
    begin
      str:='insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values ('''+ORGAN_ID+''','''+CustID+''','''+BillType+''','''+SHOP_ID+''',''0'')';
      if PlugIntf.ExecSQL(Pchar(str),iRet)<>0 then
        Raise Exception.Create('RIM_R3_NUM执行插入初值错误！（'+str+'）');
    end;
  finally
    Rs.Free;
  end;
end;

function NewId(id:string=''): string;
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

function  GetTimeStamp(iDbType:Integer):string;
begin
  case iDbType of
   0:Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
   1:Result := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))+(sysdate - trunc(sysdate))*24*60*60';
   4:result := '86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))+MIDNIGHT_SECONDS(CURRENT TIMESTAMP)';
   5:result := 'strftime(''%s'',''now'',''localtime'')-1293840000';
   else Result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
  end;
end;

//2011.04.15 写入上报执行日志
function WriteToRIM_BAL_LOG(PlugIntf:IPlugIn; LICENSE_CODE,CustID,LogType,LogNote,LogStatus: string; USER_ID: string='auto'): Boolean; //返回插入语句执行返回值;
var
  str: string;
  iRet: integer;
begin
  Str:='insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values '+
       '('''+LICENSE_CODE+Formatdatetime('YYYYMMDDHHNNSSZZZ',now())+''','''+LogType+''','''+CustID+''','''+Formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''','''+LogNote+''',''auto'','''+LogStatus+''')' ;
  if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then
   Raise Exception.Create('写日志执行失败！(SQL='+Str+')');
end;

//返回商品表管理单位与计量单位换算SQl:
function GetDefaultUnitCalc(AliasTable: string=''): string;
var
  AliasTab: string;
begin
  if trim(AliasTable)<>'' then
    AliasTab:=trim(AliasTable)+'.';
  result:=
    'case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.0 '+             //默认单位为 计量单位
         ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC '+  //默认单位为 小单位
         ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC '+      //默认单位为 大单位
         ' else 1.0 end ';                                                        //都不是则默认为换算为1;
end;

function OpenData(GPlugIn: IPlugIn; Qry: TZQuery): Boolean;
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

//返回某个字段值
function GetValue(GPlugIn: IPlugIn; SQL: string; FieldName: string=''): string;
var
  FName: string;
  Rs: TZQuery;
begin
  result:='';
  try
    FName:=trim(FieldName);
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:=SQL;
    OpenData(GPlugIn, Rs);
    if Rs.Active then
    begin
      if FName<>'' then
        result:=trim(Rs.FieldByName(FName).AsString)
      else
        result:=trim(Rs.Fields[0].AsString);
    end;
  finally
    Rs.Free;
  end;
end;

//锁定（解锁）数据库连接
procedure DBLock(GPlugIn: IPlugIn; Locked: Boolean);
begin
  if GPlugIn.DbLock(Locked)<>0 then Raise Exception.Create(GPlugIn.GetLastError); //缩定连接
end;

function ParseSQL(iDbType:integer;SQL:string):string;
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

end.
