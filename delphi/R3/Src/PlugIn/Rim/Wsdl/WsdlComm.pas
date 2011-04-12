unit WsdlComm;

interface
uses windows,SysUtils,Classes,EncdDecd,ZLib,ZDataSet;
type
  IPlugIn = Interface(IUnknown)
    ['{34E06C0E-34E5-4BB8-A10F-3F1ECB983AD8}']
    
    //设置当前插件参数,指定连锁ID号
    function SetParams(DbID:integer):integer; stdcall;
    //读取执行出错信息说明
    function GetLastError:Pchar; stdcall;

    //开始事务  超时设置 单位秒
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

function decodeZipBase64(inXml:string):string;
function EncodeZipBase64(inXml:string):string;

//通过许可证号取公司代码
function GetOrgId(lsCode:string):string;
function GetComId(lsCode:string):string;

var
  GPlugIn:IPlugIn;
  GLastError:string;
  url:string;
implementation
uses ZipUtils;
function EncodeZipBase64(inXml:string):string;
var
  ism:TStringStream;
  zsm:TMemoryStream;
  osm:TStringStream;
begin
  ism := TStringStream.Create(inXml);
  osm := TStringStream.Create('');
  zsm := TMemoryStream.Create;
  try
    ism.Position := 0;
    if not ZipStream(ism,zsm) then Raise Exception.Create('压缩数据流失败...');
    zsm.Position := 0;
    EncodeStream(zsm,osm);
    osm.Position := 0;
    result := '#zip#'+osm.DataString;
  finally
    osm.Free;
    zsm.Free;
    ism.Free;
  end;
end;
function decodeZipBase64(inXml:string):string;
var
  ism:TStringStream;
  zsm:TMemoryStream;
  osm:TStringStream;
begin
  if copy(inXml,1,5)='#zip#' then
  begin
    delete(inxml,1,5);
    ism := TStringStream.Create(inXml);
    osm := TStringStream.Create('');
    zsm := TMemoryStream.Create;
    try
      DecodeStream(ism,zsm);
      zsm.Position := 0;
      if not UnZipStream(zsm,osm) then Raise Exception.Create('解压数据流失败...');
      osm.Position := 0;
      result := osm.DataString;
    finally
      osm.Free;
      zsm.Free;
      ism.Free;
    end;
  end
  else
     result := inXml;
end;
function GetOrgId(lsCode:string):string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
  finally
    rs.free;
  end;
end;
function GetComId(lsCode:string):string;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
  finally
    rs.free;
  end;
end;
end.
