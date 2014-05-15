unit ZTuXeDo;

interface

uses Windows,Messages,SysUtils,Variants,Classes,Dialogs,ZDataSet,ZDbcIntfs,DB,
     ZdbHelp,ZBase,Registry;

  //=========================ATMI ���� =================================//
  // ����:http://wenku.baidu.com/view/dae80920af45b307e8719787.html     //
  // ����:��ɭ��                  ʱ��:2012-01-06                       //
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


//tuxedo���������  
  TcoParamList=class(TParams)
  public
    class procedure Encode(Params:TParams;Stream:TStream);
    class procedure Decode(Params:TParams;Stream:TStream);
    class procedure coSetData(Params:TParams;V:OleVariant);
    class function coGetData(Params:TParams):OleVariant;
  end;

  
  //ͨѶ���ݰ�
  PftPacked=^ TftPacked;
  TftPacked=packed record
      Sign:shortint;
      PackedCount: integer;
      PackedSeqNo:integer;
      SQL:string;
      HasResult:boolean;
      Params: OleVariant;
      Data: OleVariant;
  end;


  //���û�������
  //tuxputenv("WSNADDR=//10.110.1.4:3200");
  //tuxputenv("TUXDIR=C:\\debug\\tuxedo11");
  Ttuxputenv=function(prms:Pchar):integer;stdcall;

  // =============����������API============================================================//
  //Ttpalloc ����:���仺����
  //         ����:_type ����������
  //              _subtype ������������  ֻ��VIEW���������ͣ�����������_subtype��Ϊnull
  //              _size ��������С
  //       ����ֵ������ָ��û��������׵�ַָ��,ʧ�ܷ���null
  Ttpalloc=function(_type:Pchar;_subtype:Pchar;_size:integer):Pchar;stdcall;

  //Ttprealloc ����:���·��仺����
  //           ����:_ptr ԭ������ָ��
  //                _size �µĻ�������С
  //         ����ֵ������ָ���»��������׵�ַָ��,ʧ�ܷ���null
  Ttprealloc=function(_Ptr:Pchar;_size:integer):Pchar;stdcall;
  
  //Ttpfree ����:�ͷ��� tpalloc��tprealloc ����Ļ�����
  //        ����:_bufPtr ������ָ��
  Ttpfree=procedure(_bufPtr:Pchar);stdcall;
  // =============����������API============================================================//


  // =============�����������API============================================================//
  //Ttpchkauth ����:��������õİ�ȫ��ʽ
  //           ����:��
  //           ����ֵ��ʧ�ܷ��� - 1 ����ű�����ȫ�ֱ���tperrno�� TPNOAUTH ����Ҫ��֤ TPSYSAUTH ��Ҫ������֤   TPAPPSUTH ��Ҫ������֤������ҪӦ�ü�����֤����Ȩ
  Ttpchkauth=function:integer;stdcall;
  //Ttpinit ����:�����������������
  //        ����:tpinfo�ṹ��
  //      ����ֵ��ʧ�ܷ��� - 1 ����ű�����ȫ�ֱ���tperrno��
  Ttpinit=function(tpinfo:ppinfo_t):integer;stdcall;
  //Ttpterm ����:�Ͽ��������������
  //        ����:��
  //      ����ֵ��ʧ�ܷ��� - 1 ����ű�����ȫ�ֱ���tperrno��
  Ttpterm=function():integer;stdcall;
  // =============�����������API============================================================//


  
  // =============�������API============================================================//
  //Ttpcall ����:�ͻ���ͬ������ ������Ϊ svc ��SERVER
  //        ����:svc ���õķ�����
  //            :idata ���뻺�����ĵ�ַ���ͻ��˴�������˵Ĳ������ڴ˵�ַ��
  //            :ilen  ���뻺�����ĳ���
  //            :odata ����������ĵ�ַ������˴����ͻ��˵Ľ�����ڴ˵�ַ��
  //            :olen  ����������ĳ���
  //            :flags ���ñ�־��
  //                   TPNOTRAN �������svc�Ŀͻ��˵�ǰ��TRANSACTION��ʽ�£���ôsvc�����뵱ǰ��TRANSACTION
  //                   TPNOCHANGE �������˷��صĻ�����������ͻ��˶���Ļ�����odata���Ͳ�һ��ʱ��Ĭ�������ת���ɷ�������ͣ����ú�ת����������
  //                   TPNOBLOCK Ĭ������£�����ͻ����������������ڣ���������������IOæ������ô�ͻ��˵ȴ������������TPNOBLOCK���������ر���ע��ֻ�Է�������ʱ������
  //                   TPNOTIME ����ͻ�����������������,�ͻ��˻�һֱ��������,��ʱ��ʱҲ�����أ�����ͻ�����TRANACTIONģʽ��ʱ����ǰ����ĳ�ʱ���ǻᱨ����
  //                   TPSIGRSTRT ����ڽ���ϵͳ����ʱ�����ź��жϣ���ϵͳ���û����½��С�
  //     ����ֵ:���óɹ�����0��ʧ�ܷ���-1������ű�����ȫ�ֱ���tperrno�С� 
  Ttpcall=function(svc:Pchar;idata:Pchar;ilen:integer;odata:PPchar;olen:Pinteger;flags:integer):integer;stdcall;
  // =============�������API============================================================//


  // =============������Ϣ���API============================================================//
  //Ttpstrerror ����:���ش����Ϊtperrno�Ĵ�������
  //            ����:svc ���õķ�����
  //          ����ֵ:ʧ�ܷ���null �ɹ����ش�������
  Tgettperrno=function:integer;stdcall;
  Ttpstrerror=function(tperrno:integer):Pchar;stdcall;
  // =============������Ϣ���API============================================================//


  procedure loadTuxedo;   //��ʼ�����л���
  procedure unloadTuxedo; //�ͷ����л���

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
    Fpath:string;
    FTickCount:integer;  //��ʼʱ���
    FLogMsg:string; //��־����
    procedure WriteToFile(LogStr:string);
    procedure SetDefaultLogDir; //������־Ĭ��Ŀ¼
    function GetParamList(InParams:TftParamList):string;
  protected
    _dbLock:boolean;
    procedure RaiseError;
    function  CheckRaiseError: boolean; //����Ƿ�����Ͽ������Ƿ���True,�������쳣
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
    //�������Ӳ���< hostname=192.168.0.1;port=1024;dbid=1>
    function  Initialize(Const ConnStr:WideString):boolean;override;
    //��ȡ���Ӵ�
    function  GetConnectionString:WideString;override;
    //�������ݿ�
    function  Connect:boolean;override;
    //���ͨѶ����״̬
    function  Connected:boolean;override;
    //�ر����ݿ�
    function  DisConnect:boolean;override;

    //��ʼ����  ��ʱ���� ��λ��
    procedure BeginTrans(TimeOut:integer=-1);override;
    //�ύ����
    procedure CommitTrans;override;
    //�ع�����
    procedure RollbackTrans;override;
    //�Ƿ��Ѿ��������� True ��������
    function  InTransaction:boolean;override;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;override;

    //���ݰ���֯
    function BeginBatch:boolean;override;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):boolean;override;
    function OpenBatch:boolean;override;
    function CommitBatch:boolean;override;
    function CancelBatch:boolean;override;

    //��ѯ����;
    function Open(DataSet:TDataSet;AClassName:string;Params:TftParamList):boolean;overload; override;
    function Open(DataSet:TDataSet;AClassName:string):boolean;overload; override;
    function Open(DataSet:TDataSet):boolean;overload;override;
    //�ύ����
    function UpdateBatch(DataSet:TDataSet;AClassName:string;Params:TftParamList):boolean;overload; override;
    function UpdateBatch(DataSet:TDataSet;AClassName:string):boolean;overload; override;
    function UpdateBatch(DataSet:TDataSet):boolean;overload;override;

    //����ִ��Ӱ���¼��
    function ExecSQL(const SQL:WideString;ObjectFactory:TObject=nil):Integer;override;

    //ִ��Զ�̷�ʽ�����ؽ��
    function ExecProc(AClassName:string;Params:TftParamList=nil):string;override;

    //�û���¼
    procedure GqqLogin(UserId:string;UserName:string);override;

    //������������
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

  procedure loadTuxedo;   //��ʼ�����л���
  begin
    if dllHandle>0 then Exit;
    dllHandle := LoadLibrary('wtuxws32.dll');
    if dllHandle>0 then
       begin
         @tuxputenv := getprocaddress(dllHandle,'tuxputenv');
         if @tuxputenv=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @tpalloc := getprocaddress(dllHandle,'tpalloc');
         if @tpalloc=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @tprealloc := getprocaddress(dllHandle,'tprealloc');
         if @tprealloc=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @tpfree := getprocaddress(dllHandle,'tpfree');
         if @tpfree=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @tpchkauth := getprocaddress(dllHandle,'tpchkauth');
         if @tpchkauth=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @tpinit := getprocaddress(dllHandle,'tpinit');
         if @tpinit=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @tpterm := getprocaddress(dllHandle,'tpterm');
         if @tpterm=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @tpcall := getprocaddress(dllHandle,'tpcall');
         if @tpcall=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @tpstrerror := getprocaddress(dllHandle,'tpstrerror');
         if @tpstrerror=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
         @gettperrno := getprocaddress(dllHandle,'gettperrno');
         if @gettperrno=nil then Raise Exception.Create('wtuxws32.dll��Чdll');
       end
    else
       Raise Exception.Create('û���ҵ�����ʱ�����wtuxws32.dll');
  end;
  procedure unloadTuxedo; //�ͷ����л���
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
    //������
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
    //������
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
          VarArrayUnlock(Value);
        finally
        end;
      end;
    end else
      Raise Exception.Create('�޼���OleVariant�ֽ���');
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
  dBool:boolean;
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
        Raise Exception.Create('��֧�ֵ���������'); 
      end;
    end;
end;

class procedure TcoParamList.Decode(Params: TParams; Stream: TStream);
var
  i,w,pCount:integer;
  dInt:integer;
  dInt64:Int64;
  dDouble:Extended;
  dBool:boolean;
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
        Raise Exception.Create('��֧�ֵ���������');
      end;
    end;
end;

{ TZTuXeDo }

function TZTuXeDo.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): boolean;
var
  Factory:TZFactory;
begin
  Factory := TZFactory.Create(DataSet);
  FList.Add(Factory);
  Factory.ZClassName := AClassName;
  Factory.DataSet := DataSet;
  if Assigned(Params) then  Factory.Params.Assign(Params);
end;

function TZTuXeDo.BeginBatch: boolean;
begin
  if FList.Count > 0 then Raise Exception.Create('������֯���ݰ����޷���ʼ�µ����ݰ���');
end;

procedure TZTuXeDo.BeginTrans(TimeOut: integer);
begin
  inherited;
  Raise Exception.Create('��֧�ֿͻ�������'); 
end;

function TZTuXeDo.CancelBatch: boolean;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Clear;
end;

function TZTuXeDo.CommitBatch: boolean;
var
  coPacket:PftPacked;
  i:integer;
  coList:TList;
begin
  FLogMsg:='';
  FTickCount:=GetTickCount;
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
        coPacket.SQL := TZFactory(fList[i]).ZClassName; //2012.06.12  TZFactory(fList[i]).ClassName;
        coPacket.HasResult := true;
        if TZFactory(fList[i]).Params <>nil then
           coPacket.Params := TcoParamList.coGetData(TZFactory(fList[i]).Params)
        else
           coPacket.Params := null;
        coPacket.Data := TZQuery(TZFactory(fList[i]).DataSet).Delta;
        FLogMsg:=FLogMsg+','+TZFactory(fList[i]).ZClassName;
      end;
    BSend(coList,'BCommit');
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
    FTickCount:=GetTickCount-FTickCount;
    WriteToFile('[RunTime='+IntToStr(FTickCount)+'ms] TZTuXeDo.BCommit('+FLogMsg+')');
  end;
end;

procedure TZTuXeDo.CommitTrans;
begin
  inherited;
  Raise Exception.Create('��֧�ֿͻ�������'); 
end;

function TZTuXeDo.Connect: boolean;
begin
  FTickCount:=GetTickCount;
  try
    fConnected := false;
    if (tpinit(nil) = -1) then RaiseError;
    DisConnect;
    fConnected := true;
    fiDbType := -1;
  finally
    FTickCount:=GetTickCount-FTickCount;
    WriteToFile('[RunTime='+IntToStr(FTickCount)+'ms] TZTuXeDo.Connect');
  end;
end;

function TZTuXeDo.Connected: boolean;
begin
  result := fConnected;
end;

constructor TZTuXeDo.Create;
begin
  Fpath := ExtractShortPathName(ExtractFilePath(ParamStr(0)));
  FList := TList.Create;
  loadTuxedo;
  sendbuf := nil;
  recvbuf := nil;
  fiDbType := -1;
  _dbLock := false;
  SetDefaultLogDir;
end;

procedure TZTuXeDo.DBLock(Locked: boolean);
begin
  inherited;
  _dbLock := Locked;
  if not connected then Exit;
  if not Locked then
     tpterm()
  else
     begin
       if not _dbLock and (tpinit(nil) = -1) then RaiseError;
     end;
end;

destructor TZTuXeDo.Destroy;
var i:integer;
begin
  ClearBuf;
  for i:=0 to FList.Count -1 do TObject(FList[i]).Free;
  FList.Free;
  inherited;
end;

function TZTuXeDo.DisConnect: boolean;
begin
  tpterm();
  fConnected := false;
end;

function TZTuXeDo.ExecProc(AClassName: string; Params: TftParamList): string;
var
  ObjName:string;
  coPacket:TftPacked;
begin
  FTickCount:=GetTickCount;
  try
    coPacket.Sign := 1;
    coPacket.PackedCount := 1;
    coPacket.PackedSeqNo := 1;
    coPacket.SQL := AClassName;
    coPacket.HasResult := true;
    if Params=nil then
       coPacket.Params := null
    else
       coPacket.Params := TcoParamList.coGetData(Params);
    coPacket.Data := null;
    Send(@coPacket,'ExecProc');
    Recv(@coPacket);
    CheckPackedError(@coPacket);
    result := coPacket.Data;
  finally
    ObjName:=AClassName;
    ObjName:=ObjName+GetParamList(Params);
    FTickCount:=GetTickCount-FTickCount;
    WriteToFile('[RunTime='+IntToStr(FTickCount)+'ms] TZTuXeDo.ExecProc(RuleName='+ObjName+')');
  end;
end;

function TZTuXeDo.ExecSQL(const SQL: WideString; ObjectFactory: TObject): Integer;
var
  coPacket:TftPacked;
begin
  FTickCount:=GetTickCount;
  try
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
  finally
    FTickCount:=GetTickCount-FTickCount;
    WriteToFile('[RunTime='+IntToStr(FTickCount)+'ms] TZTuXeDo.ExecSQL(SQL='+SQL+')');
  end;
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
       Send(@coPacket,'iDbType');
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
  finally
    vList.Free;
  end;
end;

function TZTuXeDo.InTransaction: boolean;
begin
  Raise Exception.Create('��֧�ֿͻ�������'); 
end;

function TZTuXeDo.Open(DataSet: TDataSet; AClassName: string; Params: TftParamList): boolean;
var
  ObjName:string;
  coPacket:TftPacked;
begin
  FTickCount:=GetTickCount;
  try
    result:=false;
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
    //2012.08.29Add�ж�
    if (TZQuery(DataSet).Active)and(TZQuery(DataSet).FieldCount=0) then
       begin
         TZQuery(DataSet).Close;
         Raise Exception.Create('ִ��[GOpen('+AClassName+')]������Ч�����ݰ�...');
       end;
    result:=TZQuery(DataSet).Active;
  finally
    ObjName:=AClassName;
    ObjName:=ObjName+GetParamList(Params);
    FTickCount:=GetTickCount-FTickCount;
    WriteToFile('[RunTime='+IntToStr(FTickCount)+'ms] TZTuXeDo.GOpen(RuleName='+ObjName+')');
  end;
end;

function TZTuXeDo.Open(DataSet: TDataSet; AClassName: string): boolean;
begin
  result := Open(DataSet,AClassName,nil);
end;

function TZTuXeDo.Open(DataSet: TDataSet): boolean;
var
  coPacket:TftPacked;
begin
  FTickCount:=GetTickCount;
  try
    result:=false;
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
    //2012.08.29Add�ж�
    if (TZQuery(DataSet).Active)and(TZQuery(DataSet).FieldCount=0) then
       begin
         TZQuery(DataSet).Close;
         Raise Exception.Create('ִ��[Open()]������Ч�����ݰ�...');
       end;
    result:=TZQuery(DataSet).Active;
  finally
    FTickCount:=GetTickCount-FTickCount;
    WriteToFile('[RunTime='+IntToStr(FTickCount)+'ms] TZTuXeDo.Open(SQL='+TZQuery(DataSet).SQL.Text+')');
  end;
end;

function TZTuXeDo.OpenBatch: boolean;
var
  coPacket:PftPacked;
  i:integer;
  coList:TList;
  Qry: TZQuery;
begin
  FLogMsg:='';
  FTickCount:=GetTickCount;
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
      coPacket.SQL := TZFactory(fList[i]).ZClassName; //2012.06.12  TZFactory(fList[i]).ClassName;
      coPacket.HasResult := true;
      if TZFactory(fList[i]).Params <>nil then
         coPacket.Params := TcoParamList.coGetData(TZFactory(fList[i]).Params)
      else
         coPacket.Params := null;
      coPacket.Data := null;
      
      FLogMsg:=FLogMsg+','+TZFactory(fList[i]).ZClassName;
    end;
    BSend(coList,'BOpen');
    ClearList(coList);
    BRecv(coList);
    for i:=0 to fList.Count -1 do
    begin
      CheckPackedError(PftPacked(coList[i]));
      Qry:=TZQuery(TZFactory(fList[i]).DataSet);
      Qry.Data := PftPacked(coList[i]).Data;
      //2012.08.29���ӶԿ����ݰ��ж�
      if (Qry.Active) and (Qry.FieldCount=0) then
      begin
        Qry.Close;
        Raise Exception.Create('ִ��[BOpen('+TZFactory(FList[0]).ZClassName+')]������Ч�����ݰ�...'); 
      end;
    end;
    result := true;
  finally
    CancelBatch;
    ClearList(coList);
    coList.Free;
    
    FTickCount:=GetTickCount-FTickCount;
    WriteToFile('[RunTime='+IntToStr(FTickCount)+'ms] TZTuXeDo.OpenBatch('+FLogMsg+')');
  end;
end;

procedure TZTuXeDo.RaiseError;
var
  s:string;
  errno:integer;
begin
  try
    errno := gettperrno;
    s := StrPas(tpstrerror(errno));
    if (Pos(lowercase('Cannot open message catalog LIBWSC_CAT'),lowercase(s))>0) then _dbLock := false;
  except
    Raise Exception.Create('��ȡtperrno������Ϣʧ��');
  end;
  Raise Exception.Create('ErrNo:'+inttostr(errno)+'; '+s);
end;

function TZTuXeDo.CheckRaiseError: boolean;
var
  s:string;
  errno:integer;
begin
  result:=false;
  try
    errno := gettperrno;
    s := StrPas(tpstrerror(errno));
  except
    Raise Exception.Create('��ȡtperrno������Ϣʧ��');
  end;
  if (_dbLock = true) and (errno = 12) then
     begin
       tpterm();
       loadTuxedo;
       tuxputenv(pchar('WSNADDR=//'+Host+':'+inttostr(Port) ));
       tuxputenv(pchar('TUXDIR='+ExtractFilePath(ParamStr(0))+'debug\tuxedo11'));
       Connect;
       result:=true;
     end
  else
     begin
       if (Pos(lowercase('Cannot open message catalog LIBWSC_CAT'),lowercase(s))>0) then _dbLock := false;
       Raise Exception.Create('ErrNo:'+inttostr(errno)+'; '+s);
     end;
end;

procedure TZTuXeDo.RollbackTrans;
begin
  inherited;
  Raise Exception.Create('��֧�ֿͻ�������'); 
end;

function TZTuXeDo.UpdateBatch(DataSet: TDataSet; AClassName: string; Params: TftParamList): boolean;
var
  ObjName:string;
  coPacket:TftPacked;
begin
  FTickCount:=GetTickCount;
  try
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
    Send(@coPacket,'GCommit');
    Recv(@coPacket);
    CheckPackedError(@coPacket);
    result := true;
  finally
    ObjName:=AClassName;
    ObjName:=ObjName+GetParamList(Params);
    FTickCount:=GetTickCount-FTickCount;
    WriteToFile('[RunTime='+IntToStr(FTickCount)+'ms] TZTuXeDo.UpdateBatch(RuleName='+AClassName+')');
  end;
end;

function TZTuXeDo.UpdateBatch(DataSet: TDataSet; AClassName: string): boolean;
begin
  result := UpdateBatch(DataSet,AClassName,nil);
end;

procedure TZTuXeDo.Send(coPacket: PftPacked;SvcName:string);
var
  ms: TMemoryStream;
begin
  ClearBuf;
  ms := TMemoryStream.Create;
  try
    if not _dbLock then
       begin
         tpterm();
         if (tpinit(nil) = -1) then RaiseError;
       end;
    coEncode(coPacket,ms);
    sendlen := ms.Size;
    sendbuf := tpalloc('CARRAY', nil, sendlen+1);
    if sendbuf=nil then Raise Exception.Create('���䷢�ͻ�����ʧ����');
    ms.Position := 0;
    ms.Read(sendbuf^,ms.Size);
    recvlen := sendlen;
    recvbuf := tpalloc('CARRAY', nil, recvlen+1);
    if tpcall(pchar(SvcName), sendbuf, sendlen, @recvbuf, @recvlen,0)=-1 then
       begin
         if CheckRaiseError then
            begin
              if tpcall(pchar(SvcName), sendbuf, sendlen, @recvbuf, @recvlen,0)=-1 then
                 RaiseError;
            end;
       end;
  finally
    if not _dbLock then tpterm();
    ms.Free;
  end;
end;

function TZTuXeDo.UpdateBatch(DataSet: TDataSet): boolean;
begin
  Raise Exception.Create('��֧�ִ����');
end;

procedure TZTuXeDo.BSend(coList: TList;SvcName:string);
var
  i: integer;
  ms: TMemoryStream;
begin
  ClearBuf;
  ms := TMemoryStream.Create;
  try
    if not _dbLock then
       begin
         tpterm();
         if (tpinit(nil) = -1) then RaiseError;
       end;
    for i:=0 to coList.Count -1 do
        coEncode(PftPacked(coList[i]),ms);
    sendlen := ms.Size;
    sendbuf := tpalloc('CARRAY', nil, sendlen+1);
    if sendbuf=nil then Raise Exception.Create('���䷢�ͻ�����ʧ����');
    ms.Position := 0;
    ms.Read(sendbuf^,ms.Size);
    recvlen := sendlen;
    recvbuf := tpalloc('CARRAY', nil, recvlen+1);
    if tpcall(pchar(SvcName), sendbuf, sendlen, @recvbuf, @recvlen, 0)=-1 then
       begin
         if CheckRaiseError then
            begin
              if tpcall(pchar(SvcName), sendbuf, sendlen, @recvbuf, @recvlen, 0)=-1 then
                 RaiseError;
            end;
       end;
  finally
    if not _dbLock then tpterm();
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

procedure TZTuXeDo.WriteToFile(LogStr:string);
var
  myFile:string;
  F:TextFile;
begin
  if not FileExists(Fpath+'log\TLOG_'+formatDatetime('YYYYMMDD',date)+'.log') then Exit;
  try
     myFile := Fpath+'log\TLOG_'+formatDatetime('YYYYMMDD',date)+'.log';
     AssignFile(F,myFile);
     if FileExists(myFile) then Append(F) else rewrite(F);
     try
       Writeln(F,'<'+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+'>'+LogStr);
     finally
       CloseFile(F);
     end;
  except
  end;
end;

function TZTuXeDo.GetParamList(InParams: TftParamList): string;
var
  i:integer;
begin
  result:='';
  if (InParams<>nil)and(InParams.Count>0) then
  begin
    result:='; ParamList=';
    for i:=0 to InParams.Count-1 do
      result:=result+'['+InParams[i].Name+'='+InParams[i].AsString+'],';
  end;
end;

procedure TZTuXeDo.SetDefaultLogDir;
var
  vReg,RegValue:string;
  RegObj:TRegistry;
begin
  vReg:='SOFTWARE\Oracle\TUXEDO\11.1.1.2.0\Environment';
  RegObj := TRegistry.Create;
  try
    try
      RegObj.RootKey := HKEY_LOCAL_MACHINE;
      if not RegObj.KeyExists(vReg) then RegObj.CreateKey(vReg);
      RegObj.OpenKey(vReg, True);
      RegValue:=RegObj.ReadString('ULOGDIR');
      if trim(RegValue)<>Fpath then RegObj.WriteString('ULOGDIR', Fpath+'log');
    except
    end;
    RegObj.CloseKey;
  finally
    RegObj.Free;
  end;
end;

initialization
  dllHandle := 0;
finalization
  unLoadTuxedo;
end.
