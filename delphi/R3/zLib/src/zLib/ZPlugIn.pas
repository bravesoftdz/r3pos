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
    function BeginTrans(TimeOut:integer=-1):integer; stdcall;
    //�ύ����
    function CommitTrans:integer; stdcall;
    //�ع�����
    function RollbackTrans:integer; stdcall;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function iDbType(var dbType:integer):integer; stdcall;

    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function Open(SQL:Pchar;Data:OleVariant):integer;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(Delta:OleVariant;ZClassName:Pchar):integer;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(SQL:Pchar;var iRet:integer):integer;stdcall;

    //��������
    function DbLock(Locked:boolean):integer;stdcall;
    //��־����
    function WriteLogFile(s:Pchar):integer;stdcall;

   end;

  TPlugIn = class(TInterfacedObject, IPlugIn)
   private
    FPlugInId: integer;
    FHandle: THandle;
    FdbResolver: TdbResolver;
    Fdbid: integer;
    dbLocked: boolean;
    FPlugInDisplayName: string;
    FLastError: string;
    FData: Pointer;
    procedure SetHandle(const Value: THandle);
    procedure SetPlugInId(const Value: integer);
    procedure SetdbResolver(const Value: TdbResolver);
    procedure Setdbid(const Value: integer);
    procedure SetPlugInDisplayName(const Value: string);
    procedure SetLastError(const Value: string);
    procedure SetData(const Value: Pointer);
   protected
    //���õ�ǰ�������,ָ������ID��
    function SetParams(DbID:integer):integer; stdcall;
    //��ȡִ�г�����Ϣ˵��
    function GetLastError:Pchar; stdcall;

    //��ʼ����  ��ʱ���� ��λ��
    function BeginTrans(TimeOut:integer=-1):integer; stdcall;
    //�ύ����
    function CommitTrans:integer; stdcall;
    //�ع�����
    function RollbackTrans:integer; stdcall;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function iDbType(var dbType:integer):integer; stdcall;

    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function Open(SQL:Pchar;Data:OleVariant):integer;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(Delta:OleVariant;ZClassName:Pchar):integer;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(SQL:Pchar;var iRet:integer):integer;stdcall;
    //��������
    function DbLock(Locked:boolean):integer;stdcall;

    //��־����
    function WriteLogFile(s:Pchar):integer;stdcall;

    function CheckIdTransact:boolean;
    procedure PushCache;

   public
    constructor Create(FileName:string);
    destructor Destroy; override;

    function DLLGetLastError:string;
    procedure DLLDoExecute;
    procedure DLLShowPlugIn;

    property Handle:THandle read FHandle write SetHandle;
    property PlugInId:integer read FPlugInId write SetPlugInId;
    property PlugInDisplayName:string read FPlugInDisplayName write SetPlugInDisplayName;
    property dbResolver:TdbResolver read FdbResolver write SetdbResolver;
    property dbid:integer read Fdbid write Setdbid;
    property LastError:string read FLastError write SetLastError;
    property Data:Pointer read FData write SetData;
   end;
  TPlugInList=class
   private
    FList:TList;
    function GetItems(ItemIndex: Integer): TPlugIn;
    function GetCount: Integer;
   public
    constructor Create;
    destructor Destroy; override;
    //������
    procedure Clear;
    //�������
    procedure Load(FileName:string);
    procedure LoadAll;
    procedure Delete(id:integer);

    property Items[ItemIndex:Integer]:TPlugIn read GetItems;
    property Count:Integer read GetCount;
   end;
var
  PlugInList:TPlugInList;
implementation

{ TPlugIn }

function TPlugIn.BeginTrans(TimeOut: integer): integer;
begin
  try
  if CheckIdTransact then
     begin
       try
         dbResolver.BeginTrans(TimeOut);
       finally
         PushCache;
       end;
     end;
     result := 0;
  except
    on E:Exception do
       begin
         LastError := E.Message;
         result := 10001;
       end;
  end;
end;

function TPlugIn.CommitTrans: integer;
begin
  try
  if CheckIdTransact then
     begin
       try
         dbResolver.CommitTrans;
       finally
         PushCache;
       end;
     end;
     result := 0;
  except
    on E:Exception do
       begin
         LastError := E.Message;
         result := 10002;
       end;
  end;
end;

constructor TPlugIn.Create(FileName: string);
var
  DLLGetPlugInDisplayName:function :Pchar; stdcall;
  DLLGetPlugInId:function :Integer; stdcall;
begin
  dbResolver := nil;
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
  except
    FreeLibrary(Handle);
    Handle := 0;
    Raise;
  end;
end;

destructor TPlugIn.Destroy;
begin
  if assigned(dbResolver) then
     begin
       ConnCache.Push(dbResolver);
       dbResolver := nil;
     end;
  FreeLibrary(Handle);
  inherited;
end;

procedure TPlugIn.DLLDoExecute;
var
  _DLLDoExecute:function :integer; stdcall;
begin
  try
    @_DLLDoExecute := GetProcAddress(Handle, 'DoExecute');
    if @_DLLDoExecute=nil then Raise Exception.Create('DoExecute����û��ʵ��');
    if _DLLDoExecute<>0 then
       Raise Exception.Create(DLLGetLastError);
  except
    on E:Exception do
       begin
         LogFile.AddLogFile(0,E.Message,PlugInDisplayName);
       end;
  end;
end;

function TPlugIn.ExecSQL(SQL: Pchar; var iRet: integer): integer;
begin
  try
  if CheckIdTransact then
     begin
       try
         iRet := dbResolver.ExecSQL(SQL);
       finally
         PushCache;
       end;
     end;
     result := 0;
  except
    on E:Exception do
       begin
         LastError := E.Message;
         result := 10003;
       end;
  end;
end;

function TPlugIn.DLLGetLastError: string;
var
  _DLLGetLastError:function :Pchar; stdcall;
begin
  @_DLLGetLastError := GetProcAddress(Handle, 'GetLastError');
  if @_DLLGetLastError=nil then Raise Exception.Create('GetLastError����û��ʵ��');
  result := StrPas(_DLLGetLastError);
end;

function TPlugIn.iDbType(var dbType: integer): integer;
begin
  try
  if CheckIdTransact then
     begin
       try
         dbType := dbResolver.iDbType;
       finally
         PushCache;
       end;
     end;
     result := 0;
  except
    on E:Exception do
       begin
         LastError := E.Message;
         result := 10004;
       end;
  end;
end;

function TPlugIn.Open(SQL: Pchar; Data: OleVariant): integer;
var
  rs:TZQuery;
begin
  try
  if CheckIdTransact then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := SQL;
         dbResolver.Open(rs);
         Data := rs.Data;
       finally
         PushCache;
         rs.Free;
       end;
     end;
     result := 0;
  except
    on E:Exception do
       begin
         LastError := E.Message;
         result := 10005;
       end;
  end;
end;

function TPlugIn.RollbackTrans: integer;
begin
  try
  if CheckIdTransact then
     begin
       try
         dbResolver.RollbackTrans;
       finally
         PushCache;
       end;
     end;
     result := 0;
  except
    on E:Exception do
       begin
         LastError := E.Message;
         result := 10006;
       end;
  end;
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
  LogFile.AddLogFile(0,s,PlugInDisplayName);
end;

function TPlugIn.GetLastError: Pchar;
begin
  result := Pchar(LastError);
end;

function TPlugIn.CheckIdTransact: boolean;
begin
  if not assigned(dbResolver) then
     begin
       dbResolver := ConnCache.Get(dbid);
     end;
  if dbResolver=nil then Raise Exception.Create('��Ч�����ַ���...');
  result := true;
end;

procedure TPlugIn.PushCache;
begin
  if not assigned(dbResolver) then Exit;
  if not dbResolver.InTransaction and not dbLocked then
     begin
       ConnCache.Push(dbResolver);
       dbResolver := nil;
     end;
end;

procedure TPlugIn.SetdbResolver(const Value: TdbResolver);
begin
  FdbResolver := Value;
end;

procedure TPlugIn.Setdbid(const Value: integer);
begin
  Fdbid := Value;
end;

function TPlugIn.DbLock(Locked: boolean): integer;
begin
  DbLocked := Locked;
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
  ZClassName: Pchar): integer;
var
  rs:TZQuery;
begin
  try
  if CheckIdTransact then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.Delta := Delta;
         dbResolver.UpdateBatch(rs,StrPas(ZClassName));
       finally
         PushCache;
         rs.Free;
       end;
     end;
     result := 0;
  except
    on E:Exception do
       begin
         LastError := E.Message;
         result := 10007;
       end;
  end;
end;

procedure TPlugIn.DLLShowPlugIn;
var
  _DLLShowPlugin:function :integer; stdcall;
begin
  try
    @_DLLShowPlugin := GetProcAddress(Handle, 'ShowPlugIn');
    if @_DLLShowPlugin=nil then Raise Exception.Create('ShowPlugIn����û��ʵ��');
    if _DLLShowPlugin<>0 then
       Raise Exception.Create(DLLGetLastError);
  except
    on E:Exception do
       begin
         LogFile.AddLogFile(0,E.Message,PlugInDisplayName);
       end;
  end;
end;

procedure TPlugIn.SetData(const Value: Pointer);
begin
  FData := Value;
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
  FList := TList.Create;
  LoadAll;
end;

procedure TPlugInList.Delete(id:integer);
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      if TPlugIn(FList[i]).PlugInId = id then
         begin
           TObject(FList[i]).Free;
           FList.Delete(i); 
           break;
         end;
    end;
end;

destructor TPlugInList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

function TPlugInList.GetCount: Integer;
begin
  result := FList.Count;
end;

function TPlugInList.GetItems(ItemIndex: Integer): TPlugIn;
begin
  result := TPlugIn(FList[ItemIndex]);
end;

procedure TPlugInList.Load(FileName: string);
var
  PlugIn:TPlugIn;
begin
  PlugIn := TPlugIn.Create(FileName);
  FList.Add(PlugIn);
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
            Load(sr.Name);
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
