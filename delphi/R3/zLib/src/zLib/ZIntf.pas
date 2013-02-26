//***********************************************************//
//        设计:张森荣     编码：张森荣
//        版本:5.0        修改日期:2011-01-10
//        R3项目组
//***********************************************************//
unit ZIntf;           

interface
uses Classes,SysUtils,Windows,DB,Variants,ZSqlStrings;
type
IZFactory = Interface;
IdbHelp = Interface(IUnknown)
    ['{E66321DF-7462-4FAF-B612-2D4A3B0E103F}']
    //设置连接参数
    function  Initialize(Const ConnStr:WideString):boolean;stdcall;
    //读取连接串
    function  GetConnectionString:WideString;stdcall;
    //连接数据库
    function  Connect:boolean;stdcall;
    //检测通讯连接状态
    function  Connected:boolean;stdcall;
    //关闭数据库
    function  DisConnect:boolean;stdcall;
    
    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);stdcall;
    //提交事务
    procedure CommitTrans;stdcall;
    //回滚事务
    procedure RollbackTrans;stdcall;
    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;stdcall;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;stdcall;

    //HRESULT 返回值说明 =0表示执行成功 否则为错误代码
    function Open(DataSet:TDataSet):boolean;OverLoad;stdcall;
    //提交数据集
    function UpdateBatch(DataSet:TDataSet):boolean;OverLoad;stdcall;
    //返回执行影响记录数
    function ExecSQL(const SQL:WideString;ObjectFactory:TObject=nil):Integer;stdcall;

    //数据集执行Query 返回执行影响记录数
    function ExecQuery(DataSet:TDataSet):Integer;stdcall;
    //客户端中断连接
    function KillDBConnect:Integer;stdcall;
   end;

IdbDllHelp = Interface(IUnknown)
    ['{E66321DF-7462-4FAF-B612-2D4A3B0E103F}']
    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);stdcall;
    //提交事务
    procedure CommitTrans;stdcall;
    //回滚事务
    procedure RollbackTrans;stdcall;
    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;stdcall;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;stdcall;

    //HRESULT 返回值说明 =0表示执行成功 否则为错误代码
    function OpenSQL(SQL:WideString;Params:WideString):OleVariant;OverLoad;stdcall;
    function OpenNS(NS:WideString;Params:WideString):OleVariant;OverLoad;stdcall;
    //提交数据集
    function UpdateBatch(ds:OleVariant;NS:WideString;Params:WideString):boolean;OverLoad;stdcall;
    //返回执行影响记录数
    function ExecSQL(const SQL:WideString):Integer;stdcall;
    //执行远程方式，返回结果
    function ExecProc(NS:String;Params:WideString):pchar;stdcall;

    procedure BeginBatch; stdcall;
    procedure AddBatch(ds:OleVariant;const ns: WideString; const Params: WideString); stdcall;
    function OpenBatch: OleVariant; stdcall;
    procedure CommitBatch; stdcall;
    procedure CancelBatch; stdcall;
   end;

IZFactory= interface(IUnknown)
  ['{CC9E0F51-22D6-46DD-A3D9-D8B1D0A0A13A}']
    //初始化对象
    procedure PSInitialize;stdcall;
    //读取SelectSQL之前，通常用于处理 SelectSQL  返回值说明 =0表示执行成功 否则为错误代码
    function PSBeforeOpenRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //记录行集新增检测函数，返回值说明 =0表示执行成功 否则为错误代码 测可以新增当前记录
    function PSBeforeInsertRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //记录行集修改检测函数，返回值说明 =0表示执行成功 否则为错误代码 测可以修改当前记录
    function PSBeforeModifyRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //记录行集删除检测函数，返回值说明 =0表示执行成功 否则为错误代码 测可以删除当前记录
    function PSBeforeDeleteRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。返回值说明 =0表示执行成功 否则为错误代码
    function PSBeforeUpdateRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;
    //所有记录处理完毕后,事务提交以前执行。返回值说明 =0表示执行成功 否则为错误代码
    function PSBeforeCommitRecord(ObjectFactory:IdbHelp):HRESULT;stdcall;

  end;

IzProcFactory= interface(IUnknown)
  ['{368F6663-5E4F-41B5-A620-16A07C5DDD22}']
    function PSExecute(AGlobal:IdbHelp;HasResult:Boolean):Boolean;stdcall;
    function PSGetOutMessage:WideString;stdcall;
    function PSGetOutData:OleVariant;stdcall;
  end;
  
implementation
end.
