unit ZTuXeDo;

interface
uses Windows, Messages, SysUtils, Variants, Classes, ZDataSet, ZDbcIntfs,DB,ZdbHelp,ZBase;
  //=========================ATMI 函数 =================================//
  // 资料:http://wenku.baidu.com/view/dae80920af45b307e8719787.html     //
  // 代码:张森荣                  时间:2012-01-06                       //
  //====================================================================//
  
const
  MAXTIDENT=30;    //* max len of a /T identifier */

  //* Return values to tpchkauth() */
  TPNOAUTH=0;		   //* no authentication */
  TPSYSAUTH=1;	 	//* system authentication */
  TPAPPAUTH=2;	 	//* system and application authentication */

  //* Flags to tpinit() */
  TPU_MASK=$00000047;	//* unsolicited notification mask */
  TPU_SIG=$00000001;	//* signal based notification */
  TPU_DIP=$00000002;	//* dip-in based notification */
  TPU_IGN=$00000004;	//* ignore unsolicited messages */
  TPSA_FASTPATH=$00000008;	//* System access == fastpath */
  TPSA_PROTECTED=$00000010;	//* System access == protected */
  PMULTICONTEXTS=$00000020;	//* Enable MULTI context */
  TPU_THREAD=$00000040;     //* thread based notification */

  TPNOBLOCK=$00000001;//* non-blocking send/rcv */
  TPSIGRSTRT=$00000002;//* restart rcv on interrupt */
  TPNOREPLY=$00000004;//* no reply expected */
  TPNOTRAN=$00000008;	//* not sent in transaction mode */
  TPTRAN=$00000010;	//* sent in transaction mode */
  TPNOTIME=$00000020;	//* no timeout */
  TPABSOLUTE=$00000040;	//* absolute value on tmsetprio */
  TPGETANY=$00000080;	//* get any valid reply */
  TPNOCHANGE=$00000100;	//* force incoming buffer to match */
  RESERVED_BIT1=$00000200;	//* reserved for future use */
  TPCONV=$00000400;	//* conversational service */
  TPSENDONLY=$00000800;	//* send-only mode */
  TPRECVONLY=$00001000;	//* recv-only mode */
  TPACK=$00002000;	//* */
  RESERVED_BIT2=$00004000;      //* reserved for future use */
  RESERVED_BIT3=$00008000;	//* reserved for future use */
  RESERVED_BIT4=$00010000;	//* reserved for future use */
  RESERVED_BIT5=$00020000;	//* reserved for future use */
type

  ppinfo_t=^tpinfo_t;
  tpinfo_t=record
  	usrname:array [1..MAXTIDENT+2] of char;	//* client user name */
  	cltname:array [1..MAXTIDENT+2] of char;	//* application client name */
  	passwd:array [1..MAXTIDENT+2] of char;	//* application password */
  	grpname:array [1..MAXTIDENT+2] of char;	//* client group name */
  	flags:integer;			//* initialization flags */
  	datalen:integer;		//* length of app specific data */
  	data:integer;		   	//* placeholder for app data */
  end;

  TcoParamList=class(TParams)
    public
      class procedure Encode(Params:TParams;Stream:TStream);
      class procedure Decode(Params:TParams;Stream:TStream);
      class procedure coSetData(Params:TParams;V:OleVariant);
      class function coGetData(Params:TParams):OleVariant;
    end;


  //通讯数据包
  PftPacked=^ TftPacked;
  TftPacked=packed record
      Sign:shortint;
      PackedCount: integer;
      PackedSeqNo:integer;
      SQL:string;
      HasResult:Boolean;
      Params: OleVariant;
      Data: OleVariant;
  end;
  

  //设置环境变量
  //tuxputenv("WSNADDR=//10.110.1.4:3200");
  //tuxputenv("TUXDIR=C:\\debug\\tuxedo11");
  Ttuxputenv=function(prms:Pchar):integer;stdcall;

  // =============缓冲区操作API============================================================//
  //Ttpalloc 功能:分配缓冲区
  //         参数:_type 缓冲区类型
  //              _subtype 缓冲区子类型  只有VIEW才有子类型，其他缓冲区_subtype设为null
  //              _size 缓冲区大小
  //       返回值：返回指向该缓冲区的首地址指针,失败返回null
  Ttpalloc=function(_type:Pchar;_subtype:Pchar;_size:integer):Pchar;stdcall;

  //Ttprealloc 功能:重新分配缓冲区
  //           参数:_ptr 原缓冲区指针
  //                _size 新的缓冲区大小
  //         返回值：返回指向新缓冲区的首地址指针,失败返回null
  Ttprealloc=function(_Ptr:Pchar;_size:integer):Pchar;stdcall;
  
  //Ttpfree 功能:释放由 tpalloc、tprealloc 分配的缓存区
  //        参数:_bufPtr 缓冲区指针
  Ttpfree=procedure(_bufPtr:Pchar);stdcall;
  // =============缓冲区操作API============================================================//


  // =============建立连接相关API============================================================//
  //Ttpchkauth 功能:检查服务采用的安全方式
  //           参数:无
  //           返回值：失败返回 - 1 错误号保存在全局变量tperrno中 TPNOAUTH 不需要认证 TPSYSAUTH 需要口令认证   TPAPPSUTH 需要口令认证并还需要应用级的认证与授权
  Ttpchkauth=function:integer;stdcall;
  //Ttpinit 功能:建立与服务器的连接
  //        参数:tpinfo结构体
  //      返回值：失败返回 - 1 错误号保存在全局变量tperrno中
  Ttpinit=function(tpinfo:ppinfo_t):integer;stdcall;
  //Ttpterm 功能:断开与服务器的连接
  //        参数:无
  //      返回值：失败返回 - 1 错误号保存在全局变量tperrno中
  Ttpterm=function():integer;stdcall;
  // =============建立连接相关API============================================================//


  
  // =============请求相关API============================================================//
  //Ttpcall 功能:客户端同步调用 服务名为 svc 的SERVER
  //        参数:svc 调用的服务名
  //            :idata 输入缓冲区的地址，客户端传给服务端的参数放在此地址中
  //            :ilen  输入缓冲区的长度
  //            :odata 输出缓冲区的地址，服务端传给客户端的结果放在此地址中
  //            :olen  输出缓冲区的长度
  //            :flags 调用标志　
  //                   TPNOTRAN 如果调用svc的客户端当前在TRANSACTION方式下，那么svc不参与当前的TRANSACTION
  //                   TPNOCHANGE 如果服务端返回的缓冲区类型与客户端定义的缓冲区odata类型不一致时，默认情况下转换成服务端类型，设置后不转换，并报错
  //                   TPNOBLOCK 默认情况下，如果客户端有阻塞条件存在（缓冲区满，磁盘IO忙），那么客户端等待，如果设置了TPNOBLOCK则立即返回报错，注意只对发送请求时起作用
  //                   TPNOTIME 如果客户端有阻塞条件存在,客户端会一直等在那里,即时超时也不返回，如果客户端在TRANACTION模式下时，当前事务的超时还是会报错返回
  //                   TPSIGRSTRT 如果在进行系统调用时，被信号中断，该系统调用会重新进行。
  //     返回值:调用成功返回0，失败返回-1，错误号保存在全局变量tperrno中。 
  Ttpcall=function(svc:Pchar;idata:Pchar;ilen:integer;odata:PPchar;olen:Pinteger;flags:integer):integer;stdcall;
  // =============请求相关API============================================================//


  // =============错误信息相关API============================================================//
  //Ttpstrerror 功能:返回错误号为tperrno的错误描述
  //            参数:svc 调用的服务名
  //          返回值:失败返回null 成功返回错误描述
  Tgettperrno=function:integer;stdcall;
  Ttpstrerror=function(tperrno:integer):Pchar;stdcall;
  // =============错误信息相关API============================================================//


  procedure loadTuxedo;   //初始化运行环境
  procedure unloadTuxedo; //释放运行环境

  function  coVToStream(Value:oleVariant;Stream:TStream):boolean;
  function  coStreamToV(Stream:TStream): OleVariant;
  function  coDecode(src:TStream;des: PftPacked):boolean;
  function  coEncode(src: PftPacked;des:TStream):boolean;
type
  TZTuXeDo = class(TCustomdbResolver)
  private
    fiDbType:integer;
    FPort: Integer;
    FHost: string;
    fConnected:boolean;
  	sendbuf, recvbuf:pchar;
    sendlen, recvlen:integer;
    FList:TList;
  protected
    procedure RaiseError;
    procedure ClearBuf;
    procedure CheckPackedError(coPacket:PftPacked);
    procedure ClearList(coList:TList);
    procedure Send(coPacket:PftPacked;SvcName:string);
    procedure Recv(coPacket:PftPacked);
    procedure BSend(coList:TList;SvcName:string);
    procedure BRecv(coList:TList);
  public
    constructor Create;
    destructor Destroy; override;
    //设置连接参数< hostname=192.168.0.1;port=1024;dbid=1>
    function  Initialize(Const ConnStr:WideString):boolean;override;
    //读取连接串
    function  GetConnectionString:WideString;override;
    //连接数据库
    function  Connect:boolean;override;
    //检测通讯连接状态
    function  Connected:boolean;override;
    //关闭数据库
    function  DisConnect:boolean;override;

    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);override;
    //提交事务
    procedure CommitTrans;override;
    //回滚事务
    procedure RollbackTrans;override;
    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;override;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;override;

    //数据包组织
    function BeginBatch:Boolean;override;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;override;
    function OpenBatch:Boolean;override;
    function CommitBatch:Boolean;override;
    function CancelBatch:Boolean;override;

    //查询数据;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload; override;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload; override;
    function Open(DataSet:TDataSet):Boolean;overload;override;
    //提交数据
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload; override;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload; override;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;override;

    //返回执行影响记录数
    function ExecSQL(const SQL:WideString;ObjectFactory:TObject=nil):Integer;override;

    //执行远程方式，返回结果
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;override;

    //用户登录
    procedure GqqLogin(UserId:string;UserName:string);override;

    //锁定数据连接
    procedure DBLock(Locked:boolean);override;

    property Host: string read FHost write FHost;
    property Port:Integer read FPort write FPort;
  end;
var
  dllHandle:THandle;
  tuxputenv:Ttuxputenv;
  tpalloc:Ttpalloc;
  tprealloc:Ttprealloc;
  tpfree:Ttpfree;
  tpchkauth:Ttpchkauth;
  tpinit:Ttpinit;
  tpterm:Ttpterm;
  tpcall:Ttpcall;
  tpstrerror:Ttpstrerror;
  gettperrno:Tgettperrno;
implementation
  procedure loadTuxedo;   //初始化运行环境
  begin
    if dllHandle>0 then Exit;
    dllHandle := LoadLibrary('wtuxws32.dll');
    if dllHandle>0 then
       begin
         @tuxputenv := getprocaddress(dllHandle,'tuxputenv');
         if @tuxputenv=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @tpalloc := getprocaddress(dllHandle,'tpalloc');
         if @tpalloc=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @tprealloc := getprocaddress(dllHandle,'tprealloc');
         if @tprealloc=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @tpfree := getprocaddress(dllHandle,'tpfree');
         if @tpfree=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @tpchkauth := getprocaddress(dllHandle,'tpchkauth');
         if @tpchkauth=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @tpinit := getprocaddress(dllHandle,'tpinit');
         if @tpinit=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @tpterm := getprocaddress(dllHandle,'tpterm');
         if @tpterm=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @tpcall := getprocaddress(dllHandle,'tpcall');
         if @tpcall=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @tpstrerror := getprocaddress(dllHandle,'tpstrerror');
         if @tpstrerror=nil then Raise Exception.Create('wtuxws32.dll无效dll');
         @gettperrno := getprocaddress(dllHandle,'gettperrno');
         if @gettperrno=nil then Raise Exception.Create('wtuxws32.dll无效dll');
       end
    else
       Raise Exception.Create('没有找到运行时所需的wtuxws32.dll');
  end;
  procedure unloadTuxedo; //释放运行环境
  begin
    if dllHandle>0 then
       begin
         FreeLibrary(dllHandle);
         dllHandle := 0;
       end;
  end;
  function coStreamToV(Stream:TStream): OleVariant;
  var
  P: Pointer;
  begin
   Result := VarArrayCreate([0, Stream.Size - 1], varByte);
   P := VarArrayLock(Result);
   try
     Stream.Position := 0;
     Stream.Read(P^,Stream.Size);
   finally
     VarArrayUnlock(Result);
   end;
  end;
  function  coDecode(src:TStream;des: PftPacked):boolean;
  var
    w:integer;
    dInt:integer;
    s:string;
    vtype:TZSQLType;
    Stream:TMemoryStream;
  begin
    result := true;
    src.Read(des^.Sign,sizeof(des^.Sign));
    src.Read(des^.PackedCount,sizeof(des^.PackedCount));
    src.Read(des^.PackedSeqNo,sizeof(des^.PackedSeqNo));
    src.Read(w,sizeof(w));
    if w>0 then
       begin
          setlength(s,w);
          src.Read(pchar(s)^,w);
          des^.SQL := s;
       end;
    src.Read(des^.HasResult,sizeof(des^.HasResult));
    //读参数
    src.Read(vtype,sizeof(vtype));
    case vtype of
    stUnknown:
       begin
         des^.Params := null;
       end;
    else
       begin
         src.read(w,sizeof(w));
         if w>0 then
            begin
              Stream := TMemoryStream.Create;
              try
                Stream.CopyFrom(src,w);
                des^.Params := coStreamToV(Stream);
              finally
                Stream.Free;
              end;
            end;
       end;
    end;
    //读数据
    src.Read(vtype,sizeof(vtype));
    case vtype of
    stInteger:
       begin
         src.read(w,sizeof(w));
         src.read(dInt,sizeof(dInt));
         des^.Data := dInt;
       end;
    stUnknown:
       begin     
         des^.Data := null;
       end;
    stString, stUnicodeString:
       begin
         src.read(w,sizeof(w));
         if w>0 then
            begin
              SetLength(s,w);
              src.Read(pchar(s)^,w);
              des^.Data := s; 
            end;
       end;
    else
       begin
         src.read(w,sizeof(w));
         if w>0 then
            begin
              Stream := TMemoryStream.Create;
              try
                Stream.CopyFrom(src,w);
                des^.Data := coStreamToV(Stream);
              finally
                Stream.Free;
              end;
            end;
       end;
    end;
    result := true;
  end;
  function coVToStream(Value:oleVariant;Stream:TStream):boolean;
    var
      P: Pointer;
      Size: Integer;
    begin
      if VarIsArray(Value) and (VarType(Value) and varTypeMask = varByte) then
      begin
        Size := VarArrayHighBound(Value, 1) - VarArrayLowBound(Value, 1) + 1;
        if Size > 0 then
        begin
            P := VarArrayLock(Value);
            try
              Stream.Write(P^,Size);
            finally
              VarArrayUnlock(Value);
            end;
        end;
      end else Exception.Create('无级的OleVariant字节流');
    end;
  function  coEncode(src: PftPacked;des:TStream):boolean;
  var
    w:integer;
    dInt:integer;
    s:string;
    Stream:TStream;
    vtype:TZSQLType;
  begin
    result := true;
    des.Write(src^.Sign,sizeof(src^.Sign));
    des.Write(src^.PackedCount,sizeof(src^.PackedCount));
    des.Write(src^.PackedSeqNo,sizeof(src^.PackedSeqNo));
    w := length(src^.SQL);
    des.Write(w,sizeof(w));
    if w>0 then
       begin
          des.Write(pchar(src^.SQL)^,w);
       end;
    des.Write(src^.HasResult,sizeof(src^.HasResult));
    if VarIsNull(src^.Params) then
       begin
         vtype := stUnknown;
         des.Write(vtype,sizeof(vtype));
       end
    else
       begin
         Stream := TMemoryStream.Create;
         try
           coVToStream(src^.Params,Stream);
           Stream.Position := 0;
           w := Stream.Size;
           vtype := stBytes;
           des.Write(vtype,sizeof(vtype));
           des.Write(w,sizeof(w));
           des.CopyFrom(Stream,w);
         finally
           Stream.Free;
         end;
       end;
    if VarIsNull(src^.Data) then
       begin
         vtype := stUnknown;
         des.Write(vtype,sizeof(vtype));
       end
    else
    if VarIsNumeric(src^.Data) then
       begin
         vtype := stInteger;
         des.Write(vtype,sizeof(vtype));
         dInt := src^.Data;
         w := sizeof(dInt);
         des.Write(w,sizeof(w));
         des.Write(dInt,sizeof(dInt));
       end
    else
    if VarIsStr(src^.Data) then
       begin
         vtype := stString;
         des.Write(vtype,sizeof(vtype));
         s := VartoStr(src^.Data);
         w := length(s);
         des.Write(w,sizeof(w));
         des.Write(pchar(s)^,w);
       end
    else
       begin
         Stream := TMemoryStream.Create;
         try
           coVToStream(src^.Data,Stream);
           Stream.Position := 0;
           w := Stream.Size;
           vtype := stBytes;
           des.Write(vtype,sizeof(vtype));
           des.Write(w,sizeof(w));
           des.CopyFrom(Stream,w);
         finally
           Stream.Free;
         end;
       end;
    result := true;
  end;

{ TcoParamList }

class function TcoParamList.coGetData(Params:TParams): OleVariant;
var
  Stream:TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    TcoParamList.Encode(Params,Stream);
    Stream.Position := 0;
    result := coStreamToV(Stream); 
  finally
    Stream.Free;
  end;
end;

class procedure TcoParamList.coSetData(Params: TParams; V: OleVariant);
var
  Stream:TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    coVToStream(V,Stream);
    Stream.Position := 0;
    TcoParamList.Decode(Params,Stream);
  finally
    Stream.Free;
  end;
end;

class procedure TcoParamList.Encode(Params: TParams; Stream: TStream);
var
  i,w:integer;
  dInt:integer;
  dInt64:Int64;
  dBool:Boolean;
  dTime:TDatetime;
  dDouble:Extended;
  vType:TZSQLType;
  ms:TMemoryStream;
  s:string;
begin
  w := Params.Count;
  Stream.Write(w,sizeof(w));
  for i:=0 to Params.Count -1 do
    begin
      w := length(Params[i].Name);
      Stream.Write(w,sizeof(w));
      Stream.Write(Pchar(Params[i].Name)^,w);
    end;
  for i:=0 to Params.Count -1 do
    begin
      case Params[i].DataType of
      ftString,ftFixedChar,ftWideString:
      begin
        vType := stString;
        Stream.Write(vType,sizeof(vType));
        s := Params[i].AsString;
        w := length(s);
        dBool := (w=0);
        Stream.Write(dBool,sizeof(dBool));
        if not dBool then
           begin
              Stream.Write(w,sizeof(w));
              Stream.Write(Pchar(s)^,w);
           end;
      end;
      ftSmallint, ftInteger, ftWord:
      begin
        vType := stInteger;
        Stream.Write(vType,sizeof(vType));
        dBool := VarIsNull(Params[i].Value);
        Stream.Write(dBool,sizeof(dBool));
        if not dBool then
           begin
              dInt := Params[i].asInteger;
              w := sizeof(dInt);
              Stream.Write(w,sizeof(w));
              Stream.Write(dInt,w);
           end;
      end;
      ftLargeint:
      begin
        vType := stLong;
        Stream.Write(vType,sizeof(vType));
        dBool := VarIsNull(Params[i].Value);
        Stream.Write(dBool,sizeof(dBool));
        if not dBool then
           begin
              dInt64 := Params[i].Value;
              w := sizeof(dInt64);
              Stream.Write(w,sizeof(w));
              Stream.Write(dInt64,w);
           end;
      end;
      ftFloat, ftCurrency, ftBCD,ftFMTBcd:
      begin
        vType := stDouble;
        Stream.Write(vType,sizeof(vType));
        dBool := VarIsNull(Params[i].Value);
        Stream.Write(dBool,sizeof(dBool));
        if not dBool then
           begin
              dDouble := Params[i].AsFloat;
              w := sizeof(dDouble);
              Stream.Write(w,sizeof(w));
              Stream.Write(dDouble,w);
           end;
      end;
      ftDate, ftTime, ftDateTime:
      begin
        vType := stTimestamp;
        Stream.Write(vType,sizeof(vType));
        dBool := VarIsNull(Params[i].Value);
        Stream.Write(dBool,sizeof(dBool));
        if not dBool then
           begin
              dTime := Params[i].asDatetime;
              w := sizeof(dTime);
              Stream.Write(w,sizeof(w));
              Stream.Write(dTime,w);
           end;
      end;
      ftBoolean:
      begin
        vType := stBoolean;
        Stream.Write(vType,sizeof(vType));
        dBool := VarIsNull(Params[i].Value);
        Stream.Write(dBool,sizeof(dBool));
        if not dBool then
           begin
              dBool := Params[i].asBoolean;
              w := sizeof(dBool);
              Stream.Write(w,sizeof(w));
              Stream.Write(dBool,w);
           end;
      end;
      ftBytes,  ftBlob, ftMemo, ftGraphic, ftFmtMemo,ftOraBlob, ftOraClob:
      begin
        vType := stBytes;
        Stream.Write(vType,sizeof(vType));
        dBool := VarIsNull(Params[i].Value);
        Stream.Write(dBool,sizeof(dBool));
        if not dBool then
           begin
              ms := TMemoryStream.Create;
              try
                coVToStream(Params[i].Value,ms);
                w := ms.Size;
                Stream.Write(w,sizeof(w));
                Stream.CopyFrom(ms,w);
              finally
                ms.Free;
              end;
           end;
      end;
      else
        Raise Exception.Create('不支持的数据类型'); 
      end;
    end;
end;

class procedure TcoParamList.Decode(Params: TParams; Stream: TStream);
var
  i,w,pCount:integer;
  dInt:integer;
  dInt64:Int64;
  dDouble:Extended;
  dBool:Boolean;
  dTime:TDatetime;
  vType:TZSQLType;
  ms:TMemoryStream;
  s:string;
  Param:TParam;
begin
  Params.Clear;
  Stream.Read(pCount,sizeof(pCount));
  for i:=0 to pCount -1 do
    begin
      Stream.Read(w,sizeof(w));
      SetLength(s,w);
      Stream.Read(Pchar(s)^,w);
      Param := TParam(Params.Add);
      Param.Name := s;
      Param.ParamType := ptInput;
    end;
  for i:=0 to pCount -1 do
    begin
      Stream.Read(vType,sizeof(vType));
      Stream.Read(dBool,sizeof(dBool));
      if not dBool then
      case vType of
      stString, stUnicodeString:
      begin
        Stream.Read(w,sizeof(w));
        SetLength(s,w);
        Stream.Read(Pchar(s)^,w);
        Params[i].AsString := s;
      end;
      stByte, stShort, stInteger:
      begin
        Stream.Read(w,sizeof(w));
        Stream.Read(dInt,sizeof(dInt));
        Params[i].AsInteger := dInt;
      end;
      stLong:
      begin
        Stream.Read(w,sizeof(w));
        Stream.Read(dInt64,sizeof(dInt64));
        Params[i].Value := dInt64;
      end;
      stFloat, stDouble, stBigDecimal:
      begin
        Stream.Read(w,sizeof(w));
        Stream.Read(dDouble,sizeof(dDouble));
        Params[i].AsFloat := dDouble;
      end;
      stDate, stTime, stTimestamp:
      begin
        Stream.Read(w,sizeof(w));
        Stream.Read(dTime,sizeof(dTime));
        Params[i].AsDateTime := dTime;
      end;
      stBoolean:
      begin
        Stream.Read(w,sizeof(w));
        Stream.Read(dBool,sizeof(dBool));
        Params[i].AsBoolean := dBool;
      end;
      stBytes, stAsciiStream, stUnicodeStream, stBinaryStream:
      begin
        Stream.Read(w,sizeof(w));
        ms := TMemoryStream.Create;
        try
          ms.CopyFrom(Stream,w);
          Params[i].Value := coStreamToV(ms);
        finally
          ms.Free;
        end;
      end;
      else
        Raise Exception.Create('不支持的数据类型'); 
      end;
    end;
end;

{ TZTuXeDo }

function TZTuXeDo.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
var
  Factory:TZFactory;
begin
  Factory := TZFactory.Create(DataSet);
  FList.Add(Factory);
  Factory.ZClassName := AClassName;
  Factory.DataSet := DataSet;
  if Assigned(Params) then  Factory.Params.Assign(Params);
end;

function TZTuXeDo.BeginBatch: Boolean;
begin
  if FList.Count > 0 then Raise Exception.Create('正在组织数据包，无法开始新的数据包。');
end;

procedure TZTuXeDo.BeginTrans(TimeOut: integer);
begin
  inherited;
  Raise Exception.Create('不支持客户端事务'); 
end;

function TZTuXeDo.CancelBatch: Boolean;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Clear;
end;

function TZTuXeDo.CommitBatch: Boolean;
var
  coPacket:PftPacked;
  i:integer;
  coList:TList;
begin
  result := false;
  coList := TList.Create;
  try
    for i:=0 to fList.Count -1 do
      begin
        new(coPacket);
        coList.Add(coPacket);
        coPacket.Sign := 1;
        coPacket.PackedCount := fList.Count;
        coPacket.PackedSeqNo := i+1;
        coPacket.SQL := TZFactory(fList[i]).ClassName;
        coPacket.HasResult := true;
        if TZFactory(fList[i]).Params <>nil then
           coPacket.Params := TcoParamList.coGetData(TZFactory(fList[i]).Params)
        else
           coPacket.Params := null;
        coPacket.Data := TZQuery(TZFactory(fList[i]).DataSet).Delta;
      end;
    BSend(coList,'svcBCommit');
    ClearList(coList);
    BRecv(coList);
    for i:=0 to fList.Count -1 do
      begin
        CheckPackedError(PftPacked(coList[i]));
      end;
    CancelBatch;
    result := true;
  finally
    ClearList(coList);
    coList.Free;
  end;
end;

procedure TZTuXeDo.CommitTrans;
begin
  inherited;
  Raise Exception.Create('不支持客户端事务'); 
end;

function TZTuXeDo.Connect: boolean;
begin
  fConnected := false;
	if (tpinit(nil) = -1) then
      RaiseError;
  fConnected := true;
  fiDbType := -1;
end;

function TZTuXeDo.Connected: boolean;
begin
  result := fConnected;
end;

constructor TZTuXeDo.Create;
begin
  loadTuxedo;
  sendbuf := nil;
  recvbuf := nil;
  fiDbType := -1;
  FList := TList.Create;
end;

procedure TZTuXeDo.DBLock(Locked: boolean);
begin
  inherited;

end;

destructor TZTuXeDo.Destroy;
var i:integer;
begin
  ClearBuf;
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Free;
  unLoadTuxedo;
  inherited;
end;

function TZTuXeDo.DisConnect: boolean;
begin
  tpterm();
end;

function TZTuXeDo.ExecProc(AClassName: String;
  Params: TftParamList): String;
var
  coPacket:TftPacked;
begin
  coPacket.Sign := 1;
  coPacket.PackedCount := 1;
  coPacket.PackedSeqNo := 1;
  coPacket.SQL := AClassName;
  coPacket.HasResult := true;
  coPacket.Params := TcoParamList.coGetData(Params);
  coPacket.Data := null;
  Send(@coPacket,'ExecProc');
  Recv(@coPacket);
  CheckPackedError(@coPacket);
  result := coPacket.Data;
end;

function TZTuXeDo.ExecSQL(const SQL: WideString;
  ObjectFactory: TObject): Integer;
var
  coPacket:TftPacked;
begin
  coPacket.Sign := 1;
  coPacket.PackedCount := 1;
  coPacket.PackedSeqNo := 1;
  coPacket.SQL := SQL;
  coPacket.HasResult := true;
  if ObjectFactory is TParams then
     coPacket.Params := TcoParamList.coGetData(TParams(ObjectFactory))
  else
     coPacket.Params := null;
  coPacket.Data := null;
  Send(@coPacket,'ExecSQL');
  Recv(@coPacket);
  CheckPackedError(@coPacket);
  result := coPacket.Data;
end;

function TZTuXeDo.GetConnectionString: WideString;
begin
  result := 'connmode=3;hostname='+host+';port='+inttostr(Port)+';dbid=-1';
end;

procedure TZTuXeDo.GqqLogin(UserId, UserName: string);
begin
  inherited;

end;

function TZTuXeDo.iDbType: Integer;
var
  coPacket:TftPacked;
begin
  if fiDbType<0 then
  begin
    coPacket.Sign := 1;
    coPacket.PackedCount := 1;
    coPacket.PackedSeqNo := 1;
    coPacket.SQL := '';
    coPacket.HasResult := true;
    coPacket.Params := null;
    coPacket.Data := null;
    Send(@coPacket,'svciDbType');
    Recv(@coPacket);
    CheckPackedError(@coPacket);
    result := coPacket.Data;
    fiDbType := result;
  end
  else
    result := fiDbType;
end;

function TZTuXeDo.Initialize(const ConnStr: WideString): boolean;
var
  vList:TStringList;
begin
  Disconnect;
  vList := TStringList.Create;
  try
    vList.Delimiter := ';';
    vList.DelimitedText := lowercase(ConnStr);
    Host := vList.Values['hostname'];
    Port := StrtoIntDef(vList.Values['port'],1024);
  	tuxputenv(pchar('WSNADDR=//'+Host+':'+inttostr(Port)));
   	tuxputenv(pchar('TUXDIR='+ExtractFilePath(ParamStr(0))+'debug\tuxedo11'));
//    dbid := StrtoIntDef(vList.Values['dbid'],1);
  finally
    vList.Free;
  end;
end;

function TZTuXeDo.InTransaction: boolean;
begin
  Raise Exception.Create('不支持客户端事务'); 
end;

function TZTuXeDo.Open(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
var
  coPacket:TftPacked;
begin
  coPacket.Sign := 1;
  coPacket.PackedCount := 1;
  coPacket.PackedSeqNo := 1;
  coPacket.SQL := AClassName;
  coPacket.HasResult := true;
  if Params<>nil then
     coPacket.Params := TcoParamList.coGetData(Params)
  else
     coPacket.Params := null;
  coPacket.Data := null;
  Send(@coPacket,'GOpen');
  Recv(@coPacket);
  CheckPackedError(@coPacket);
  TZQuery(DataSet).Data := coPacket.Data;
end;

function TZTuXeDo.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  result := Open(DataSet,AClassName,nil);
end;

function TZTuXeDo.Open(DataSet: TDataSet): Boolean;
var
  coPacket:TftPacked;
begin
  coPacket.Sign := 1;
  coPacket.PackedCount := 1;
  coPacket.PackedSeqNo := 1;
  coPacket.SQL := TZQuery(DataSet).SQL.Text;
  coPacket.HasResult := true;
  coPacket.Params := TcoParamList.coGetData(TZQuery(DataSet).Params);
  coPacket.Data := null;
  Send(@coPacket,'Open');
  Recv(@coPacket);
  CheckPackedError(@coPacket);
  TZQuery(DataSet).Data := coPacket.Data;
end;

function TZTuXeDo.OpenBatch: Boolean;
var
  coPacket:PftPacked;
  i:integer;
  coList:TList;
begin
  result := false;
  coList := TList.Create;
  try
    for i:=0 to fList.Count -1 do
      begin
        new(coPacket);
        coList.Add(coPacket);
        coPacket.Sign := 1;
        coPacket.PackedCount := fList.Count;
        coPacket.PackedSeqNo := i+1;
        coPacket.SQL := TZFactory(fList[i]).ClassName;
        coPacket.HasResult := true;
        if TZFactory(fList[i]).Params <>nil then
           coPacket.Params := TcoParamList.coGetData(TZFactory(fList[i]).Params)
        else
           coPacket.Params := null;
        coPacket.Data := null;
      end;
    BSend(coList,'svcBOpen');
    ClearList(coList);
    BRecv(coList);
    for i:=0 to fList.Count -1 do
      begin
        CheckPackedError(PftPacked(coList[i]));
        TZQuery(TZFactory(fList[i]).DataSet).Data := PftPacked(coList[i]).Data;
      end;
    CancelBatch;
    result := true;
  finally
    ClearList(coList);
    coList.Free;
  end;
end;

procedure TZTuXeDo.RaiseError;
var
  errno:integer;
  s:string;
begin
  try
    errno := gettperrno;
    s := StrPas(tpstrerror(errno));
  except
    Raise Exception.Create('读取tperrno错误信息失败'); 
  end;
  Raise Exception.Create(s);
end;

procedure TZTuXeDo.RollbackTrans;
begin
  inherited;
  Raise Exception.Create('不支持客户端事务'); 
end;

function TZTuXeDo.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
var
  coPacket:TftPacked;
begin
  result := false;
  coPacket.Sign := 1;
  coPacket.PackedCount := 1;
  coPacket.PackedSeqNo := 1;
  coPacket.SQL := AClassName;
  coPacket.HasResult := true;
  if Params<>nil then
     coPacket.Params := TcoParamList.coGetData(Params)
  else
     coPacket.Params := null;
  coPacket.Data := TZQuery(DataSet).Delta;
  Send(@coPacket,'GCommit ');
  Recv(@coPacket);
  CheckPackedError(@coPacket);
  result := true;
end;

function TZTuXeDo.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  result := UpdateBatch(DataSet,AClassName,nil);
end;

procedure TZTuXeDo.Send(coPacket: PftPacked;SvcName:string);
var
  ms : TMemoryStream;
begin
  ClearBuf;
  ms := TMemoryStream.Create;
  try
    coEncode(coPacket,ms);
    sendlen := ms.Size;
    sendbuf := tpalloc('CARRAY', nil, sendlen+1);
    if sendbuf=nil then Raise Exception.Create('分配发送缓存区失败了');
    ms.Position := 0;
    ms.Read(sendbuf^,ms.Size);
    recvlen := sendlen;
    recvbuf := tpalloc('CARRAY', nil, recvlen+1);
  	if tpcall(pchar(SvcName) , sendbuf, sendlen, @recvbuf, @recvlen,0)=-1 then RaiseError;
  finally
    ms.Free;
  end;
end;

function TZTuXeDo.UpdateBatch(DataSet: TDataSet): Boolean;
begin
  Raise Exception.Create('不支持此项功能'); 
end;

procedure TZTuXeDo.BSend(coList: TList;SvcName:string);
var
  ms : TMemoryStream;
  i:integer;
begin
  ClearBuf;
  ms := TMemoryStream.Create;
  try
    for i:=0 to coList.Count -1 do
        coEncode(PftPacked(coList[i]),ms);
    sendlen := ms.Size;
    sendbuf := tpalloc('CARRAY', nil, sendlen+1);
    if sendbuf=nil then Raise Exception.Create('分配发送缓存区失败了');
    ms.Position := 0;
    ms.Read(sendbuf^,ms.Size);
    recvlen := sendlen;
    recvbuf := tpalloc('CARRAY', nil, recvlen+1);
  	if tpcall(pchar(SvcName) , sendbuf, sendlen, @recvbuf, @recvlen,0)=-1 then RaiseError;
  finally
    ms.Free;
  end;
end;

procedure TZTuXeDo.ClearBuf;
begin
  if assigned(sendbuf) then
     begin
       tpfree(sendbuf);
       sendbuf := nil;
     end;
	if assigned(recvbuf) then
     begin
       tpfree(recvbuf);
       recvbuf := nil;
     end;
end;

procedure TZTuXeDo.BRecv(coList:TList);
var
  ms:TMemoryStream;
  coPacket: PftPacked;
  i:integer;
begin
  ClearList(coList);
  ms := TMemoryStream.Create;
  try
    ms.Write(recvBuf^,recvLen);
    ms.Position := 0;
    new(coPacket);
    coList.Add(coPacket);
    coDecode(ms,coPacket);
    for i:=2 to coPacket.PackedCount do
      begin
        new(coPacket);
        coList.Add(coPacket);
        coDecode(ms,coPacket);
      end;
    ClearBuf;
  finally
    ms.Free;
  end;
end;

procedure TZTuXeDo.Recv(coPacket: PftPacked);
var
  ms:TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    ms.Write(recvBuf^,recvLen);
    ms.Position := 0;
    coDecode(ms,coPacket); 
    ClearBuf;
  finally
    ms.Free;
  end;
end;

procedure TZTuXeDo.ClearList(coList: TList);
var
  i:integer;
begin
  for i:=0 to coList.Count - 1 do
    dispose(coList[i]);
  coList.Clear;
end;

procedure TZTuXeDo.CheckPackedError(coPacket: PftPacked);
begin
  if coPacket^.Sign=3 then Raise Exception.Create(coPacket^.Data); 
end;

initialization
  dllHandle := 0;
finalization
end.                                                                                                                                  .
