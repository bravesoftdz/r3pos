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
  TLogRunInfo=class
  public
    class procedure LogWrite(LogText: string; LogType: string='');
  end;

type
  TConParam= Record
    DbType: integer;    //数据库类型
    RmServerIP: string; //远程服务器IP
    PortNum: string;    //端口号
    LogName: string;    //登陆名
    LogPwd:  string;    //登陆密码
  end;



//插件常用函数
function NewId(id:string=''): string; //获取GUID
function OpenData(GPlugIn: IPlugIn; Qry: TZQuery): Boolean;    //查询数据
function GetValue(GPlugIn: IPlugIn; SQL: string; FieldName: string=''): string; //返回某个字段值
procedure DBLock(GPlugIn: IPlugIn; Locked: Boolean);  //锁定数据连接
function ParseSQL(iDbType:integer;SQL:string):string;

{== 暂无用 ==}
function GetTickTime: string;  //取当前精确时间[暂时]

//共用变量定义
var
  GPlugIn: IPlugIn;
  GLastError:string;

implementation

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

function OpenData(GPlugIn: IPlugIn; Qry: TZQuery): Boolean;
var
  ReRun: integer;
  vData: OleVariant;
begin
  result:=False;
  try
    Qry.Close;
    ReRun:=GPlugIn.Open(Pchar(Qry.SQL.Text),vData);
    if ReRun<>0 then Raise Exception.Create(Qry.SQL.Text+'执行异常！');
    Qry.Data:=vData;
    Result:=Qry.Active;
  except
    on E:Exception do
    begin
      Raise Exception.Create(Pchar('PlugIntf.Open:('+Qry.Name+') 出错：'+E.Message));
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
  try
    GPlugIn.DbLock(Locked); //缩定连接
  except
    on E:Exception do
    begin
      if Locked then
        Raise Exception.Create('锁定数据连接错误：'+E.Message)
      else
        Raise Exception.Create('解锁数据连接错误：'+E.Message);
    end;
  end;
end;

//取当前精确时间
function GetTickTime: string;
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Now(), Hour, Min, Sec, MSec);
  result:=InttoStr(Hour)+':'+InttoStr(Min)+':'+InttoStr(Sec)+' '+inttoStr(MSec);
end;

{ TLogRunInfo }

{ 根据文件名[判断是写日志情况，日志文件存放在: C:\Rsp\Log或 E:盘的Rsp\Log  }
class procedure TLogRunInfo.LogWrite(LogText: string; LogType: string='');
const {==三处按顺序搜索，若找不到则不日志==}
  FilePathC='C:\Rsp\Log\debug.log';
  FilePathD='D:\Rsp\Log\debug.log';
  FilePathE='E:\Rsp\Log\debug.log';
var
  i: integer;
  FilePath, LogStr: string;
  StrList: TStringList;
begin
  FilePath:='';
  if FileExists(FilePathC) then FilePath:=FilePathC;
  if (FilePath='') and (FileExists(FilePathD)) then FilePath:=FilePathD;
  if (FilePath='') and (FileExists(FilePathE)) then FilePath:=FilePathE;
  if FilePath<>'' then
  begin
    try
      StrList:=TStringList.Create;
      StrList.LoadFromFile(FilePath);
      if StrList.Count>1000 then  //超过1000行则进行批量删除
      begin
        for i:=400 to 1 do
          StrList.Delete(i);  
      end;
      LogStr:='类别：'+LogType+'  运行时间：'+GetTickTime+'  '+LogText;
      StrList.Add(LogStr);
      StrList.SaveToFile(FilePath);
    finally
      StrList.Free;
    end;
  end;
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
