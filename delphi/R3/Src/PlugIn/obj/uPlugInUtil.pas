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


//共用变量定义
var
  GPlugIn:IPlugIn;
  GLastError:string;
 

//插件常用函数
function NewId(id:string=''): string; //获取GUID
function OpenData(GPlugIn: IPlugIn; Qry: TZQuery; SQL: string): Boolean;    //查询数据
function GetValue(GPlugIn: IPlugIn; SQL: string; FieldName: string=''): string; //返回某个字段值
procedure DBLock(GPlugIn: IPlugIn; Locked: Boolean);  //锁定数据连接
function GetTickTime: string;  //取当前精确时间

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

function OpenData(GPlugIn: IPlugIn; Qry: TZQuery; SQL: string): Boolean;
var
  ReRun: integer;
  vData: OleVariant;
begin
  result:=False;
  try
    ReRun:=GPlugIn.Open(Pchar(SQL),vData);
    if (ReRun=0) and (VarIsArray(vData)) then
    begin
      Qry.Close;
      Qry.Data:=vData;
      Result:=Qry.Active;
    end else
    if ReRun<>0 then
      Exception.Create(SQL+'执行异常！');
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
    OpenData(GPlugIn, Rs, SQL);
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

end.
