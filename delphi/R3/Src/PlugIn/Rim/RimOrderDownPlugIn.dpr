{
  Create Date: 2011.04.11 Pm
  说明:
    1、插件ID: 是对于实现某个功能插件编号;
 }


library RimOrderDownPlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase;

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

   
{$R *.res}
var
  GPlugIn:IPlugIn;
  GLastError:string;


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

function OpenData(PlugIn: IPlugIn; Qry: TZQuery; SQL: string): Boolean;
var
  vData: OleVariant;
begin
  result:=False;
  PlugIn.Open(Pchar(SQL),vData);
  if VarIsArray(vData) then
  begin
    Qry.Close;
    Qry.Data:=vData;
    Result:=Qry.Active;
  end;
end;

procedure SetRimCom_CustID(PlugIn: IPlugIn; ParamStr: string; var ComID: string; var CustID: string);
var
  vParam: TftParamList;
begin
  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,ParamStr); 
    

  finally
    vParam.Free;
  end;
end;

function DownOrderToINF_StockOrder(PlugIn: IPlugIn; ParamStr: string): Boolean;
var
  iRet: integer;
  Str,NearDate,ComID,CustID: string;
begin
  result:=False;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //获取最近30天的订单日期
  SetRimCom_CustID(PlugIn,ParamStr,ComID,CustID); //读取Rim系统的供应商（烟草公司Com_ID）和零售户的Cust_Id
  {== 中间表是作为接口，相应系统共用，此处处理: 主表作为查询显示下载列表显示使用 ==}
  PlugIn.ExecSQL(Pchar('delete from INF_INDEORDER where '+Cnd),iRet);
  Str:='insert into INF_INDEORDER (INDE_ID,CLIENT_ID,CUST_ID,INDE_DATE,INDE_AMT,INDE_MNY) '+
       ' select CO_NUM,COM_ID,CUST_ID,CRT_DATE,QTY_SUM,AMT_SUM from RIM_SD_CO '+
       ' where CRT_DATE>='''+NearDate+''' and COM_ID='''+vParam.ParamByName('COM_ID').AsString+''' and '+
       ' CUST_ID='''+vParam.ParamByName('CUST_ID').AsString+''' ';;
  PlugIn.ExecSQL(Pchar(Str),iRet);
  {== 汇总需求量直接更新到主表 需求量 ==}
  str:='update INF_INDEORDER A set NEED_AMT=(select sum(QTY_NEED) from RIM_SD_CO_LINE B where A.CO_NUM=B.CO_NUM) '+
       ' where exists(select 1 from RIM_SD_CO_LINE C where A.CO_NUM=B.CO_NUM) ';
  PlugIn.ExecSQL(Pchar(Str),iRet);
end;
       
//RSP装载插件时调用，传插件可访问的服务接口
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;

//插件中执行的所有操作都必须带 try except end 如果出错时，由此方法返回错信息
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;

//返回当前插件说明
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := 'RSP平台下载RIM系统订单';
end;

//返回RIM下载订单（到货确认）的插件
function GetPlugInId:Integer; stdcall;
begin
  result := 1002;
end;

//RSP调用插件时执行此方法
function DoExecute(Params:Pchar):Integer; stdcall;
begin
  try
    //下载订单
     
    
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2001;
      end;
  end;
end;

//RSP调用插件自定义的管理界面,没有时直接返回0
function ShowPlugin:Integer; stdcall;
begin
  try
    //开始显示主界面窗体
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2002;
      end;
  end;
end;

exports
  SetParams,GetLastError,GetPlugInDisplayName,GetPlugInId,DoExecute,ShowPlugin;
begin

end.
