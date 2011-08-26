//***********************************************************//
//        ���:��ɭ��     ���룺��ɭ��
//        �汾:5.0        �޸�����:2011-01-10
//        R3��Ŀ��
//***********************************************************//
unit ZdbFactory;

interface
uses SysUtils,Classes,Windows,DB,ZIntf,ZdbHelp,ZBase,ZAbstractDataset,ZClient,Forms,ZLogFile;
type
  TdbFactory = class(TComponent)
  private
    FThreadLock:TRTLCriticalSection;
    dbResolver:TCustomdbResolver;
    FConnMode: integer;
    FConnStr: string;
    OkKey:boolean;
    procedure SetConnMode(const Value: integer);
    procedure SetConnStr(const Value: string);
  protected
    procedure Enter;
    procedure Leave;

    procedure LoadKey;
  public
    constructor Create;
    destructor  Destroy;override;

    //�������Ӳ��� connmode=1 �������� 2 Rsp��������
    function  Initialize(Const ConnStr:WideString):boolean;
    //��ȡ���Ӵ�
    function  GetConnectionString:WideString;
    //�������ݿ�
    function  Connect:boolean;
    //���ͨѶ����״̬
    function  Connected:boolean;
    //�ر����ݿ�
    function  DisConnect:boolean;

    //��ʼ����  ��ʱ���� ��λ��
    procedure BeginTrans(TimeOut:integer=-1);
    //�ύ����
    procedure CommitTrans;
    //�ع�����
    procedure RollbackTrans;
    //�Ƿ��Ѿ��������� True ��������
    function  InTransaction:boolean;

    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;

    //���ݰ���֯
    function BeginBatch:Boolean;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;
    function OpenBatch:Boolean;
    function CommitBatch:Boolean;
    function CancelBatch:Boolean;

    //��ѯ����;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload;
    function Open(DataSet:TDataSet):Boolean;overload;

    //�ύ����
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;

    //����ִ��Ӱ���¼��
    function ExecSQL(const SQL:WideString;ObjectFactory:TZFactory=nil):Integer;

    //ִ��Զ�̷�ʽ�����ؽ��
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;

    //�û���¼
    procedure GqqLogin(UserId:string;UserName:string);
    //������������ <���õ�Seesion������ʱ��ָ��һ��SESSION�����ݽ��в���������������>
    procedure DBLock(Locked:boolean);

    //����ģʽ 1 �Ǳ�������  2 RSPͨѶ����
    property ConnMode:integer read FConnMode write SetConnMode;
    //�����ַ���
    property ConnString:string read FConnStr write SetConnStr;
  end;
implementation
type
  TFileInfo = packed record
    CommpanyName: string;
    FileDescription: string;
    FileVersion: string;
    InternalName: string;
    LegalCopyright: string;
    LegalTrademarks: string;
    OriginalFileName: string;
    ProductName: string;
    ProductVersion: string;
    SpecialBuild: string;
    PrivateBuild: string;
    Comments: string;
    VsFixedFileInfo: VS_FIXEDFILEINFO;
    UserDefineValue: string;
  end;
function GetFileVersionInfomation(const FileName: string;
  var info: TFileInfo; UserDefine: string): boolean;
const
  SFInfo = '\StringFileInfo\';
var
  VersionInfo: Pointer;
  InfoSize: DWORD;
  InfoPointer: Pointer;
  Translation: Pointer;
  VersionValue: string;
  unused: DWORD;
begin
  unused := 0;
  Result := False;
  InfoSize := GetFileVersionInfoSize(pchar(FileName), unused);
  if InfoSize > 0 then
  begin
    GetMem(VersionInfo, InfoSize);
    Result := GetFileVersionInfo(pchar(FileName), 0, InfoSize, VersionInfo);
    if Result then
    begin
      VerQueryValue(VersionInfo, '\VarFileInfo\Translation', Translation,
        InfoSize);
      VersionValue := SFInfo + IntToHex(LoWord(Longint(Translation^)), 4) +
        IntToHex(HiWord(Longint(Translation^)), 4) + '\';
      VerQueryValue(VersionInfo, pchar(VersionValue + 'CompanyName'),
        InfoPointer, InfoSize);
      info.CommpanyName := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'FileDescription'),
        InfoPointer, InfoSize);
      info.FileDescription := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'FileVersion'),
        InfoPointer, InfoSize);
      info.FileVersion := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'InternalName'),
        InfoPointer, InfoSize);
      info.InternalName := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'LegalCopyright'),
        InfoPointer, InfoSize);
      info.LegalCopyright := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'LegalTrademarks'),
        InfoPointer, InfoSize);
      info.LegalTrademarks := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'OriginalFileName'),
        InfoPointer, InfoSize);
      info.OriginalFileName := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'ProductName'),
        InfoPointer, InfoSize);
      info.ProductName := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'ProductVersion'),
        InfoPointer, InfoSize);
      info.ProductVersion := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'SpecialBuild'),
        InfoPointer, InfoSize);
      info.SpecialBuild := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'PrivateBuild'),
        InfoPointer, InfoSize);
      info.PrivateBuild := string(pchar(InfoPointer));
      VerQueryValue(VersionInfo, pchar(VersionValue + 'Comments'), InfoPointer,
        InfoSize);
      info.Comments := string(pchar(InfoPointer));
      if VerQueryValue(VersionInfo, '\', InfoPointer, InfoSize) then
        info.VsFixedFileInfo := TVSFixedFileInfo(InfoPointer^);
      if UserDefine <> '' then
      begin
        if VerQueryValue(VersionInfo, pchar(VersionValue + UserDefine),
          InfoPointer, InfoSize) then
          info.UserDefineValue := string(pchar(InfoPointer));
      end;
    end;
    FreeMem(VersionInfo);
  end;
end;
{ TdbFactory }

procedure TdbFactory.BeginTrans(TimeOut: integer);
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    dbResolver.BeginTrans(TimeOut);
  finally
    Leave;
  end;
end;

procedure TdbFactory.CommitTrans;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    dbResolver.CommitTrans;
  finally
    Leave;
  end;
end;

function TdbFactory.Connect: boolean;
begin
  DisConnect;
  LogFile.AddLogFile(0,'<dbFactory.Connect> to '+ConnString);
  Enter;
  try
    if FConnStr='' then Raise Exception.Create('�����ַ�������Ϊ��..'); 
    case ConnMode of
    2:dbResolver := TZClient.Create;
    else
      dbResolver := TdbResolver.Create;
    end;
    dbResolver.Initialize(ConnString); 
    result := dbResolver.Connect;
  finally
    Leave;
    LogFile.AddLogFile(0,'<dbFactory.Connect> finish');
  end;
end;

function TdbFactory.Connected: boolean;
begin
  result := assigned(dbResolver) and dbResolver.Connected;
end;

constructor TdbFactory.Create;
begin
  InitializeCriticalSection(FThreadLock);
  dbResolver := nil;
  OkKey := true;
//  LoadKey;
end;

destructor TdbFactory.Destroy;
begin
  DisConnect;
  Enter;
  try
    inherited;
  finally
    Leave;
    DeleteCriticalSection(FThreadLock);
  end;
end;

function TdbFactory.Open(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.Open(DataSet,AClassName,Params)
  finally
    Leave;
  end;
end;

function TdbFactory.DisConnect: boolean;
begin
  Enter;
  try
    if assigned(dbResolver) then freeandnil(dbResolver);
  finally
    Leave;
  end;
end;

function TdbFactory.ExecSQL(const SQL: WideString;
  ObjectFactory: TZFactory): Integer;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.ExecSQL(SQL,ObjectFactory);
  finally
    Leave;
  end;
end;

function TdbFactory.GetConnectionString: WideString;
begin
  result := ConnString;
end;

function TdbFactory.iDbType: Integer;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.iDbType;
  finally
    Leave;
  end;
end;

function TdbFactory.Initialize(const ConnStr: WideString): boolean;
var
  vList:TStringList;
begin
  Disconnect;
  vList := TStringList.Create;
  try
    vList.Delimiter := ';';
    vList.QuoteChar := '"';
    vList.DelimitedText := ConnStr;
    ConnMode := StrtoIntDef(vList.Values['connmode'],1);
    FConnStr := ConnStr;
  finally
    vList.Free;
  end;
end;

function TdbFactory.InTransaction: boolean;
begin
  result := Assigned(dbResolver) and dbResolver.InTransaction;
end;

function TdbFactory.Open(DataSet: TDataSet): Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.Open(DataSet);
  finally
    Leave;
  end;
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet; AClassName: String;
  Params: TftParamList): Boolean;
begin
  if DataSet.State in [dsEdit,dsInsert] then DataSet.Post;
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.UpdateBatch(DataSet,AClassName,Params);
    if result then TZAbstractDataset(DataSet).CommitUpdates;
  finally
    Leave;
  end;
end;

procedure TdbFactory.RollbackTrans;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    dbResolver.RollbackTrans;
  finally
    Leave;
  end;
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet): Boolean;
begin
  if DataSet.State in [dsEdit,dsInsert] then DataSet.Post;
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.UpdateBatch(DataSet);
    if result then TZAbstractDataset(DataSet).CommitUpdates;
  finally
    Leave;
  end;
end;

function TdbFactory.AddBatch(DataSet: TDataSet; AClassName: string;
  Params: TftParamList): Boolean;
begin
  if DataSet.State in [dsEdit,dsInsert] then DataSet.Post;
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.AddBatch(DataSet,AClassName,Params);
  finally
    Leave;
  end;
end;

function TdbFactory.BeginBatch: Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.BeginBatch;
  finally
    Leave;
  end;
end;

function TdbFactory.CancelBatch: Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.CancelBatch;
  finally
    Leave;
  end;
end;

function TdbFactory.CommitBatch: Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.CommitBatch;
  finally
    Leave;
  end;
end;

function TdbFactory.OpenBatch: Boolean;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.OpenBatch;
  finally
    Leave;
  end;
end;

function TdbFactory.ExecProc(AClassName: String;
  Params: TftParamList): String;
begin
  if dbResolver=nil then Connect;
  Enter;
  try
    result := dbResolver.ExecProc(AClassName,Params);
  finally
    Leave;
  end;
end;

function TdbFactory.Open(DataSet: TDataSet; AClassName: String): Boolean;
begin
  if dbResolver=nil then Connect;
//  Enter;
  try
    result := Open(DataSet,AClassName,nil);
  finally
//    Leave;
  end;
end;

function TdbFactory.UpdateBatch(DataSet: TDataSet;
  AClassName: String): Boolean;
begin
  if DataSet.State in [dsEdit,dsInsert] then DataSet.Post;
  if dbResolver=nil then Connect;
//  Enter;
  try
    result := UpdateBatch(DataSet,AClassName,nil);
  finally
//    Leave;
  end;
end;

procedure TdbFactory.SetConnMode(const Value: integer);
begin
  FConnMode := Value;

end;

procedure TdbFactory.SetConnStr(const Value: string);
begin
  FConnStr := Value;
  Initialize(ConnString);
end;

procedure TdbFactory.Enter;
begin
  EnterCriticalSection(FThreadLock);
  if not OkKey and (Application.MainForm<>nil) then
     begin
       Application.MainForm.Caption := '��ӭʹ��"zLib����ƽ̨��ʾϵͳ"����֧���������棬�ɻ����ߣ�13860431130������';
       Application.Title := '��ӭʹ��"zLib����ƽ̨��ʾϵͳ"����֧���������棬�ɻ����ߣ�13860431130������';
     end;
end;

procedure TdbFactory.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

procedure TdbFactory.GqqLogin(UserId, UserName: string);
begin
  dbResolver.GqqLogin(UserId,UserName);
end;

procedure TdbFactory.DBLock(Locked: boolean);
begin
  dbResolver.DBLock(Locked);
end;

procedure TdbFactory.LoadKey;
var
  DllHandle:THandle;
function GetResString(ResName:integer):string;
var
  iRet:array[0..254] of char;
begin
  result := '';
  LoadString(DllHandle, ResName, iRet, 254);
  result := StrPas(iRet);
end;
function EncStr(AStr,ENC_KEY:string):string;
var
  i: integer;
  LongKey: string;
  TmpStr: string;
begin
  Result:='';
  LongKey:='';
  for i:=0 to (Length(AStr) div Length(ENC_KEY)) do
      LongKey:=LongKey+ENC_KEY;
  for i:=1 to Length(AStr) do
    begin
      TmpStr:=IntToHex((Ord(AStr[i]) xor Ord(LongKey[i])),2);
      Result:= Result+TmpStr;
    end;
end;
var
  KeyStr:string;
  FileInfo:TFileInfo;
begin
  DllHandle := LoadLibrary('key.dll');
  if DllHandle=0 then
     begin
       MessageBox(0,'��ӭʹ��"zLib����ƽ̨��ʾϵͳ"����֧�����ǵ�����.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  KeyStr := GetResString(1);
  GetFileVersionInfomation(ParamStr(0),FileInfo,'');
  OkKey := (KeyStr = EncStr(FileInfo.CommpanyName+'#2@~#$%^&*-1235'+FileInfo.ProductName,'zhangsr30355701'));
  if not OkKey then
     begin
       MessageBox(0,'��ӭʹ��"zLib����ƽ̨��ʾϵͳ"����֧�����ǵ�����.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
end;

end.
