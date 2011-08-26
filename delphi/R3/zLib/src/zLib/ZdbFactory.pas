//***********************************************************//
//        设计:张森荣     编码：张森荣
//        版本:5.0        修改日期:2011-01-10
//        R3项目组
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

    //设置连接参数 connmode=1 本地连接 2 Rsp服务连接
    function  Initialize(Const ConnStr:WideString):boolean;
    //读取连接串
    function  GetConnectionString:WideString;
    //连接数据库
    function  Connect:boolean;
    //检测通讯连接状态
    function  Connected:boolean;
    //关闭数据库
    function  DisConnect:boolean;

    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);
    //提交事务
    procedure CommitTrans;
    //回滚事务
    procedure RollbackTrans;
    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;

    //数据包组织
    function BeginBatch:Boolean;
    function AddBatch(DataSet:TDataSet;AClassName:string='';Params:TftParamList=nil):Boolean;
    function OpenBatch:Boolean;
    function CommitBatch:Boolean;
    function CancelBatch:Boolean;

    //查询数据;
    function Open(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;
    function Open(DataSet:TDataSet;AClassName:String):Boolean;overload;
    function Open(DataSet:TDataSet):Boolean;overload;

    //提交数据
    function UpdateBatch(DataSet:TDataSet;AClassName:String;Params:TftParamList):Boolean;overload;
    function UpdateBatch(DataSet:TDataSet;AClassName:String):Boolean;overload;
    function UpdateBatch(DataSet:TDataSet):Boolean;overload;

    //返回执行影响记录数
    function ExecSQL(const SQL:WideString;ObjectFactory:TZFactory=nil):Integer;

    //执行远程方式，返回结果
    function ExecProc(AClassName:String;Params:TftParamList=nil):String;

    //用户登录
    procedure GqqLogin(UserId:string;UserName:string);
    //锁定数据连接 <当用到Seesion级操作时，指定一个SESSION对数据进行操作，用完必须解锁>
    procedure DBLock(Locked:boolean);

    //连接模式 1 是本地连接  2 RSP通讯连接
    property ConnMode:integer read FConnMode write SetConnMode;
    //连接字符串
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
    if FConnStr='' then Raise Exception.Create('连接字符串不能为空..'); 
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
       Application.MainForm.Caption := '欢迎使用"zLib开发平台演示系统"，请支持我们正版，缴活热线：13860431130张先生';
       Application.Title := '欢迎使用"zLib开发平台演示系统"，请支持我们正版，缴活热线：13860431130张先生';
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
       MessageBox(0,'欢迎使用"zLib开发平台演示系统"，请支持我们的正版.','友情提示..',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  KeyStr := GetResString(1);
  GetFileVersionInfomation(ParamStr(0),FileInfo,'');
  OkKey := (KeyStr = EncStr(FileInfo.CommpanyName+'#2@~#$%^&*-1235'+FileInfo.ProductName,'zhangsr30355701'));
  if not OkKey then
     begin
       MessageBox(0,'欢迎使用"zLib开发平台演示系统"，请支持我们的正版.','友情提示..',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
end;

end.
