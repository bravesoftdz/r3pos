unit ZPlugIn;

interface
uses Classes,SysUtils,Windows,Variants,ZServer,ZDataSet,ZdbHelp,ZLogFile,ZBase;

//���˵��
//����ֵΪ0����ִ�гɽ����񷴻ضԾ�ԭ����ԭ��.
type
  IPlugIn = Interface(IUnknown)
    ['{34E06C0E-34E5-4BB8-A10F-3F1ECB983AD8}']
    
    //���õ�ǰ�������,ָ������ID��
    function SetParams(DbID:integer):integer; stdcall;
    //��ȡִ�г�����Ϣ˵��
    function GetLastError:Pchar; stdcall;

    //��ʼ����  ��ʱ���� ��λ��
    function BeginTrans(TimeOut:integer=-1;dbResoler:integer=0):integer; stdcall;
    //�ύ����
    function CommitTrans(dbResoler:integer=0):integer; stdcall;
    //�ع�����
    function RollbackTrans(dbResoler:integer=0):integer; stdcall;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function iDbType(var dbType:integer;dbResoler:integer=0):integer; stdcall;

    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function Open(SQL:Pchar;var Data:OleVariant;dbResoler:integer=0;ParamStr:Pchar=nil):integer;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(Delta:OleVariant;ZClassName:Pchar;dbResoler:integer=0;ParamStr:Pchar=nil):integer;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(SQL:Pchar;var iRet:integer;dbResoler:integer=0;ParamStr:Pchar=nil):integer;stdcall;

    //��������
    function DbLock(Locked:boolean;dbResoler:integer=0):integer;stdcall;
    //��־����
    function WriteLogFile(s:Pchar):integer;stdcall;

   end;

  TPlugIn = class(TInterfacedPersistent, IPlugIn)
   private
    FPlugInId: integer;
    FHandle: THandle;
    Fdbid: integer;
    FPlugInDisplayName: string;
    FLastError: string;
    FData: Pointer;
    FWorking: integer;
    LockConn:TList;
    FThreadLock:TRTLCriticalSection;
    procedure SetHandle(const Value: THandle);
    procedure SetPlugInId(const Value: integer);
    procedure Setdbid(const Value: integer);
    procedure SetPlugInDisplayName(const Value: string);
    procedure SetLastError(const Value: string);
    procedure SetData(const Value: Pointer);
    procedure SetWorking(const Value: integer);
   protected
    IParams:IPlugIn;
    //���õ�ǰ�������,ָ������ID��
    function SetParams(DbID:integer):integer; stdcall;
    //��ȡִ�г�����Ϣ˵��
    function GetLastError:Pchar; stdcall;

    //��ʼ����  ��ʱ���� ��λ��
    function BeginTrans(TimeOut:integer=-1;dbResoler:integer=0):integer; stdcall;
    //�ύ����
    function CommitTrans(dbResoler:integer=0):integer; stdcall;
    //�ع�����
    function RollbackTrans(dbResoler:integer=0):integer; stdcall;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function iDbType(var dbType:integer;dbResoler:integer=0):integer; stdcall;

    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function Open(SQL:Pchar;var Data:OleVariant;dbResoler:integer=0;ParamStr:Pchar=nil):integer;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(Delta:OleVariant;ZClassName:Pchar;dbResoler:integer=0;ParamStr:Pchar=nil):integer;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(SQL:Pchar;var iRet:integer;dbResoler:integer=0;ParamStr:Pchar=nil):integer;stdcall;
    //��������
    function DbLock(Locked:boolean;dbResoler:integer=0):integer;stdcall;

    //��־����
    function WriteLogFile(s:Pchar):integer;stdcall;

    function CheckIdTransact:TdbResolver;
    procedure PushCache(dbResolver:TdbResolver);
   public
    constructor Create(FileName:string);
    destructor Destroy; override;

    procedure Enter;
    procedure Leave;

    function DLLGetLastError:string;
    procedure DLLDoExecute(Params:string;var Data:OleVariant);
    procedure DLLShowPlugIn;

    property Handle:THandle read FHandle write SetHandle;
    property PlugInId:integer read FPlugInId write SetPlugInId;
    property PlugInDisplayName:string read FPlugInDisplayName write SetPlugInDisplayName;
    property dbid:integer read Fdbid write Setdbid;
    property LastError:string read FLastError write SetLastError;
    property Data:Pointer read FData write SetData;
    property Working:integer read FWorking write SetWorking;
   end;
  TPlugInList=class
   private
    FList:TList;
    FThreadLock:TRTLCriticalSection;
    function GetItems(ItemIndex: Integer): TPlugIn;
    function GetCount: Integer;
    procedure Enter;
    procedure Leave;
   public
    constructor Create;
    destructor Destroy; override;
    //������
    procedure Clear;
    //�������
    procedure Load(FileName:string);
    procedure LoadAll;
    procedure Delete(id:integer);

    function Find(id:integer):TPlugIn;

    property Items[ItemIndex:Integer]:TPlugIn read GetItems;
    property Count:Integer read GetCount;
   end;
var
  PlugInList:TPlugInList;
implementation
uses IniFiles;
{ TPlugIn }

function TPlugIn.BeginTrans(TimeOut: integer=-1;dbResoler:integer=0): integer;
var
  dbResolver:TdbResolver;
begin
//  Enter;
//  try
    try
       dbResolver := TdbResolver(dbResoler);
       if dbResolver=nil then Raise Exception.Create('�����Ӻ���Ч:'+inttostr(dbResoler));
       dbResolver.BeginTrans(TimeOut);
       result := 0;
    except
      on E:Exception do
         begin
           LastError :='<BeginTrans>'+  E.Message;
           result := 10001;
         end;
    end;
//  finally
//    Leave;
//  end;
end;

function TPlugIn.CommitTrans(dbResoler:integer=0): integer;
var dbResolver:TdbResolver;
begin
//  Enter;
//  try
    try
       dbResolver := TdbResolver(dbResoler);
       if dbResolver=nil then Raise Exception.Create('�����Ӻ���Ч:'+inttostr(dbResoler));
       dbResolver.CommitTrans;
       result := 0;
    except
      on E:Exception do
         begin
           LastError := '<CommitTrans>'+  E.Message;
           result := 10002;
         end;
    end;
//  finally
//    Leave;
//  end;
end;

constructor TPlugIn.Create(FileName: string);
var
  DLLGetPlugInDisplayName:function :Pchar; stdcall;
  DLLGetPlugInId:function :Integer; stdcall;
  DLLSetParams:function(PlugIn:IPlugIn) :Integer; stdcall;
  f:TiniFile;
begin
  InitializeCriticalSection(FThreadLock);
  LockConn := TList.Create;
  FData := nil;
  Handle := LoadLibrary(Pchar(FileName));
  if Handle=0 then Raise Exception.Create('��Ч����ļ�'+FileName);
  try
    @DLLGetPlugInDisplayName := GetProcAddress(Handle, 'GetPlugInDisplayName');
    if @DLLGetPlugInDisplayName=nil then Raise Exception.Create('GetPlugInDisplayName����û��ʵ��');
    PlugInDisplayName := DLLGetPlugInDisplayName;

    @DLLGetPlugInId := GetProcAddress(Handle, 'GetPlugInId');
    if @DLLGetPlugInId=nil then Raise Exception.Create('GetPlugInId����û��ʵ��');
    PlugInId := DLLGetPlugInId;

    @DLLSetParams := GetProcAddress(Handle, 'SetParams');
    if @DLLSetParams=nil then Raise Exception.Create('SetParams����û��ʵ��');
    GetInterface(StringtoGuid('{34E06C0E-34E5-4BB8-A10F-3F1ECB983AD8}'),IParams);
    DLLSetParams(IParams);
    f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
    try
       dbid := f.ReadInteger('db','dbid',0);
    finally
       f.free;
    end;
  except
    FreeLibrary(Handle);
    Handle := 0;
    Raise;
  end;
end;

destructor TPlugIn.Destroy;
var
  DLLSetParams:function(PlugIn:IPlugIn) :Integer; stdcall;
begin
  Enter;
  try
    @DLLSetParams := GetProcAddress(Handle, 'SetParams');
    if @DLLSetParams=nil then Raise Exception.Create('SetParams����û��ʵ��');
    DLLSetParams(nil);
    IParams := nil;
    LockConn.Free;
    FreeLibrary(Handle);
  finally
    Leave;
    DeleteCriticalSection(FThreadLock);
  end;
  inherited;
end;

procedure TPlugIn.DLLDoExecute(Params:string;var Data:OleVariant);
var
  _DLLDoExecute:function(Params:Pchar;var Data:OleVariant;dbResoler:integer=0) :integer; stdcall;
  dbResolver:TdbResolver;
begin
  InterlockedIncrement(FWorking);
  dbResolver := CheckIdTransact;
//  LogFile.AddLogFile(0,'��ʼִ��<'+inttostr(PlugInId)+'>'+PlugInDisplayName);
  try
    try
      @_DLLDoExecute := GetProcAddress(Handle, 'DoExecute');
      if @_DLLDoExecute=nil then Raise Exception.Create('DoExecute����û��ʵ��');
      if _DLLDoExecute(Pchar(Params),Data,Integer(dbResolver))<>0 then
         Raise Exception.Create('ִ�в�������ˣ�ȥ������־�ɣ�');//DLLGetLastError);
    except
      on E:Exception do
         begin
           //LogFile.AddLogFile(0,'<'+inttostr(PlugInId)+'>'+E.Message,PlugInDisplayName);
           Raise;
         end;
    end;
  finally
    InterlockedDecrement(FWorking);
    PushCache(dbResolver);
//    LogFile.AddLogFile(0,'����ִ��<'+inttostr(PlugInId)+'>'+PlugInDisplayName);
  end;
end;

function TPlugIn.ExecSQL(SQL: Pchar; var iRet: integer;dbResoler:integer=0;ParamStr:Pchar=nil): integer;
var
  dbResolver:TdbResolver;
  params:TftParamList;
begin
  params := nil;
//  Enter;
  if ParamStr<>nil then params := TftParamList.Create(nil);
  try
    try
       if ParamStr<>nil then TftParamList.Decode(params,strpas(ParamStr));
       dbResolver := TdbResolver(dbResoler);
       if dbResolver=nil then Raise Exception.Create('�����Ӻ���Ч:'+inttostr(dbResoler));
       iRet := dbResolver.ExecSQL(SQL,params);
       result := 0;
    except
      on E:Exception do
         begin
           LastError := '<SQL='+StrPas(SQL)+'>'+E.Message;
           result := 10003;
         end;
    end;
  finally
    if ParamStr<>nil then params.free;
//    Leave;
  end;
end;

function TPlugIn.DLLGetLastError: string;
var
  _DLLGetLastError:function :Pchar; stdcall;
begin
  Enter;
  try
    @_DLLGetLastError := GetProcAddress(Handle, 'GetLastError');
    if @_DLLGetLastError=nil then Raise Exception.Create('GetLastError����û��ʵ��');
    result := 'Plug->'+StrPas(_DLLGetLastError);
  finally
    Leave;
  end;
end;

function TPlugIn.iDbType(var dbType: integer;dbResoler:integer=0): integer;
var dbResolver:TdbResolver;
begin
//  Enter;
//  try
    try
       dbResolver := TdbResolver(dbResoler);
       if dbResolver=nil then Raise Exception.Create('�����Ӻ���Ч:'+inttostr(dbResoler));
       dbType := dbResolver.iDbType;
       result := 0;
    except
      on E:Exception do
         begin
           LastError := '<iDbType>'+  E.Message;
           result := 10004;
         end;
    end;
//  finally
//    Leave;
//  end;
end;

function TPlugIn.Open(SQL: Pchar;var Data: OleVariant;dbResoler:integer=0;ParamStr:Pchar=nil): integer;
var
  rs:TZQuery;
  dbResolver:TdbResolver;
  params:TftParamList;
begin
//  Enter;
//  try
    try
       dbResolver := TdbResolver(dbResoler);
       if dbResolver=nil then Raise Exception.Create('�����Ӻ���Ч:'+inttostr(dbResoler));
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := SQL;
         if ParamStr<>nil then TftParamList.Decode(rs.Params,strpas(ParamStr));
         dbResolver.Open(rs);
         Data := rs.Data;
       finally
         rs.Free;
       end;
       result := 0;
    except
      on E:Exception do
         begin
           LastError := '<SQL='+StrPas(SQL)+'>'+E.Message;
           result := 10005;
         end;
    end;
//  finally
//    Leave;
//  end;
end;

function TPlugIn.RollbackTrans(dbResoler:integer=0): integer;
var
  dbResolver:TdbResolver;
begin
//  Enter;
//  try
    try
       dbResolver := TdbResolver(dbResoler);
       if dbResolver=nil then Raise Exception.Create('�����Ӻ���Ч:'+inttostr(dbResoler));
       dbResolver.RollbackTrans;
       result := 0;
    except
      on E:Exception do
         begin
           LastError := '<RollbackTrans>'+  E.Message;
           result := 10006;
         end;
    end;
//  finally
//    Leave;
//  end;
end;

procedure TPlugIn.SetHandle(const Value: THandle);
begin
  FHandle := Value;
end;

function TPlugIn.SetParams(DbID: integer): integer;
begin
  FDbId := DbId;
end;

procedure TPlugIn.SetPlugInId(const Value: integer);
begin
  FPlugInId := Value;
end;

function TPlugIn.WriteLogFile(s: Pchar): integer;
begin
//  Enter;
//  try
    try
      LogFile.AddLogFile(0,s,PlugInDisplayName);
      result := 0;
    except
      on E:Exception do
         begin
           result := 2000;
           LastError := 'WriteLogFile'+E.Message;
         end;
    end;
//  finally
//    Leave;
//  end;
end;

function TPlugIn.GetLastError: Pchar;
begin
  result := Pchar('RSP->'+LastError);
end;

function TPlugIn.CheckIdTransact: TdbResolver;
begin
  result := ConnCache.Get(dbid);
  if result=nil then Raise Exception.Create('��Ч�����ַ���...');
end;

procedure TPlugIn.PushCache(dbResolver:TdbResolver);
begin
  ConnCache.Push(dbResolver);
end;

procedure TPlugIn.Setdbid(const Value: integer);
begin
  Fdbid := Value;
end;

function TPlugIn.DbLock(Locked: boolean;dbResoler:integer=0): integer;
var
  dbResolver:TdbResolver;
begin
//  Enter;
//  try
    try
      dbResolver := TdbResolver(dbResoler);
      if dbResolver=nil then Raise Exception.Create('�����Ӻ���Ч:'+inttostr(dbResoler));
      dbResolver.DBLock(Locked);
      result := 0;
    except
      on E:Exception do
         begin
           LastError := '<DbLock>'+  E.Message;
           result := 10005;
         end;
    end;
//  finally
//    Leave;
// end;
end;

procedure TPlugIn.SetPlugInDisplayName(const Value: string);
begin
  FPlugInDisplayName := Value;
end;

procedure TPlugIn.SetLastError(const Value: string);
begin
  FLastError := Value;
end;

function TPlugIn.UpdateBatch(Delta: OleVariant;
  ZClassName: Pchar;dbResoler:integer=0;ParamStr:Pchar=nil): integer;
var
  rs:TZQuery;
  dbResolver:TdbResolver;
  params:TftParamList;
begin
  params := nil;
//  Enter;
  if ParamStr<>nil then params := TftParamList.Create(nil);
  try
    try
       dbResolver := TdbResolver(dbResoler);
       if dbResolver=nil then Raise Exception.Create('�����Ӻ���Ч:'+inttostr(dbResoler));
       rs := TZQuery.Create(nil);
       try
         if ParamStr<>nil then TftParamList.Decode(params,strpas(ParamStr));
         rs.Delta := Delta;
         dbResolver.UpdateBatch(rs,StrPas(ZClassName),params);
       finally
         rs.Free;
       end;
       result := 0;
    except
      on E:Exception do
         begin
           LastError := '<ZClassName='+StrPas(ZClassName)+'>'+ E.Message;
           result := 10007;
         end;
    end;
  finally
    if ParamStr<>nil then params.Free;
//    Leave;
  end;
end;

procedure TPlugIn.DLLShowPlugIn;
var
  _DLLShowPlugin:function :integer; stdcall;
begin
  try
    @_DLLShowPlugin := GetProcAddress(Handle, 'ShowPlugin');
    if @_DLLShowPlugin=nil then Raise Exception.Create('ShowPlugin����û��ʵ��');
    if _DLLShowPlugin<>0 then
       Raise Exception.Create(DLLGetLastError);
  except
    on E:Exception do
       begin
         LogFile.AddLogFile(0,E.Message,PlugInDisplayName);
         Raise;
       end;
  end;
end;

procedure TPlugIn.SetData(const Value: Pointer);
begin
  FData := Value;
end;

procedure TPlugIn.SetWorking(const Value: integer);
begin
  FWorking := Value;
end;

procedure TPlugIn.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

procedure TPlugIn.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

{ TPlugInList }

procedure TPlugInList.Clear;
var
  i:Integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      TObject(FList[i]).Free;
    end;
  FList.Clear;
end;

constructor TPlugInList.Create;
begin
  InitializeCriticalSection(FThreadLock);
  FList := TList.Create;
  LoadAll;
end;

procedure TPlugInList.Delete(id:integer);
var
  i:integer;
begin
  Enter;
  try
    for i:=0 to FList.Count -1 do
      begin
        if TPlugIn(FList[i]).PlugInId = id then
           begin
             TObject(FList[i]).Free;
             FList.Delete(i);
             break;
           end;
      end;
  finally
    Leave;
  end;
end;

destructor TPlugInList.Destroy;
begin
  Enter;
  try
    Clear;
    FList.Free;
  finally
    Leave;
    DeleteCriticalSection(FThreadLock);
  end;
  inherited;
end;

procedure TPlugInList.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

function TPlugInList.Find(id: integer): TPlugIn;
var
  i:integer;
begin
  Enter;
  try
    result := nil;
    for i:=0 to Count-1 do
      begin
        if Items[i].PlugInId = id then
           begin
             result := Items[i];
             break;
           end;
      end;
  finally
    Leave;
  end;
end;

function TPlugInList.GetCount: Integer;
begin
  result := FList.Count;
end;

function TPlugInList.GetItems(ItemIndex: Integer): TPlugIn;
begin
  result := TPlugIn(FList[ItemIndex]);
end;

procedure TPlugInList.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

procedure TPlugInList.Load(FileName: string);
var
  PlugIn:TPlugIn;
begin
  Enter;
  try
    PlugIn := TPlugIn.Create(FileName);
    FList.Add(PlugIn);
  finally
    Leave;
  end;
end;

procedure TPlugInList.LoadAll;
var
  sr: TSearchRec;
  FileAttrs: Integer;
begin
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(ExtractFilePath(ParamStr(0))+'PlugIn\*.dll', FileAttrs, sr) = 0 then
    begin
      repeat
        if (sr.Attr and FileAttrs) = sr.Attr then
          begin
            Load(ExtractFilePath(ParamStr(0))+'PlugIn\'+ExtractFileName(sr.Name));
          end;
      until FindNext(sr) <> 0;
      SysUtils.FindClose(sr);
    end;
end;

initialization
  PlugInList := TPlugInList.Create;
finalization
  PlugInList.Free;
end.
