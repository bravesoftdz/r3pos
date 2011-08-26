unit ufrmInstall;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, TlHelp32,Forms,
  Dialogs, ComCtrls, RzButton, ExtCtrls, StdCtrls,ZipUtils,IniFiles,ShellApi,RzBckgnd,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TfrmInstall = class(TForm)
    PrsBar: TProgressBar;
    cxbtnCancel: TRzBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel2: TBevel;
    Label5: TLabel;
    Image1: TImage;
    RzBackground1: TRzBackground;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    btnInstall: TRzBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxbtnCancelClick(Sender: TObject);
  private
    FUrl: string;
    Aborted:Boolean;
    FPath: string;
    BreakFile:TIniFile;
    FCurVersion: string;
    FNewVersion: string;
    procedure SetUrl(const Value: string);
    procedure SetPath(const Value: string);
    procedure SetCurVersion(const Value: string);
    procedure SetNewVersion(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    function CheckExeFile(filename:string):boolean;
    procedure UpdateLabel(s:string);
    function DownFile(FileName:string):boolean;
    property Url:string read FUrl write SetUrl;
    property Path:string read FPath write SetPath;
    property CurVersion:string read FCurVersion write SetCurVersion;
    property NewVersion:string read FNewVersion write SetNewVersion;
  end;

implementation
uses uDownByHttp,uGlobal,WinSvc;
var IsStop:boolean;
{$R *.dfm}

function StopService(AServName: string): Boolean;
var
  SCManager, hService: SC_HANDLE;
  SvcStatus: TServiceStatus;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_ALL_ACCESS);
    Result := hService <> 0;
    if Result then
    try  //停止并卸载服务;
      Result := ControlService(hService, SERVICE_CONTROL_STOP, SvcStatus);
      //删除服务，这一句可以不要;
      //DeleteService(hService);
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;
function StartService(AServName: string): Boolean;
var
  SCManager, hService: SC_HANDLE;
  lpServiceArgVectors: PChar;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_ALL_ACCESS);
    Result := hService <> 0;
    if (hService = 0) and (GetLastError = ERROR_SERVICE_DOES_NOT_EXIST) then
      Exception.Create('The specified service does not exist');
    if hService <> 0 then
    try
      lpServiceArgVectors := nil;
      Result := WinSvc.StartService(hService, 0, PChar(lpServiceArgVectors));
      if not Result and (GetLastError = ERROR_SERVICE_ALREADY_RUNNING) then
        Result := True;
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;
function QueryService(AServName: string): Boolean;
var
  SCManager, hService: SC_HANDLE;
  SvcStatus: TServiceStatus;
begin
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  Result := SCManager <> 0;
  if Result then
  try
    hService := OpenService(SCManager, PChar(AServName), SERVICE_QUERY_STATUS);
    Result := hService <> 0;
    if Result then
    try  //停止并卸载服务;
      Result := QueryServiceStatus(hService,SvcStatus);
      case SvcStatus.dwCurrentState of
      SERVICE_STOPPED:
        begin
          IsStop := true;
        end;
      SERVICE_RUNNING:
        begin
          IsStop := false;
        end;
      end;
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

{文件是否在使用中}
function IsFileInUse(fName:string):boolean;
var
  HFileRes : HFILE;
begin
  Result := false;
  if not FileExists(fName) then
    exit;
  HFileRes := CreateFile(pchar(fName), GENERIC_READ or GENERIC_WRITE,0, nil, OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL, 0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
end;
function GetSystemLoad():String;  //获取系统路径(system/system32)
var
   pcSystemDirectory : PChar;
   dwSDSize          : DWORD;
begin
   dwSDSize := MAX_PATH + 1;
   GetMem(pcSystemDirectory, dwSDSize ); // allocate memory for the string
   try
      if Windows.GetSystemDirectory( pcSystemDirectory, dwSDSize ) <> 0 then
         Result := pcSystemDirectory;
   finally
      FreeMem( pcSystemDirectory ); // now free the memory allocated for the string
   end;
end;
{ TfrmInstall }

function TfrmInstall.DownFile(FileName: string):boolean;
var HTTPGetFile: TDownByHttp;
  DstFile:string;
  SurFile:string;
  i:integer;
begin
  result := false;
  HTTPGetFile := TDownByHttp.Create(nil);
  try
    if Url[Length(Url)]='/' then
       SurFile := Url + FileName
    else
       SurFile := Url + '/'+FileName;
    DstFile := Path+'install\'+FileName;
    HTTPGetFile.FileName := DstFile;
    HTTPGetFile.FileURL := SurFile;
    HTTPGetFile.InitPosHandle(PrsBar.Handle);
    HTTPGetFile.DelayTime := 0;
    ForceDirectories(Path+'install\');//目录不存在时自动建目录
    Aborted := false;
    PrsBar.Max := 100;
    HTTPGetFile.LoadBreakFile;
    HTTPGetFile.DownFile;
    while not HTTPGetFile.Ended do
      begin
        if Aborted then HTTPGetFile.CancelDownLoad;
        Application.ProcessMessages;
      end;
    if Aborted then
      begin
        {文件可能还在使用中，做延时处理}
        i := 0;
        while (i < 500) and IsFileInUse(DstFile) do
        begin
          Application.ProcessMessages;
          inc(i);
        end;
        DeleteFile(DstFile);
      end;
    if FileExists(DstFile) and HTTPGetFile.Done then
      begin
        result := true;
      end
    else
      if not Aborted and HTTPGetFile.HasFile then
         result := DownFile(FileName);
  finally
    HTTPGetFile.free;
  end;
end;

procedure TfrmInstall.SetPath(const Value: string);
begin
  FPath := Value;
end;

procedure TfrmInstall.SetUrl(const Value: string);
begin
  FUrl := Value;
end;

procedure TfrmInstall.FormCreate(Sender: TObject);
var F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    Label1.Caption := '欢迎使用'+ F.ReadString('soft','name','云盟软件R3')+'系列产品';

    Label10.Caption :=  F.ReadString('home','url','www.rspcn.com');
    Label12.Caption :=  F.ReadString('home','qq','30355701');
  finally
    try
      F.Free;
    except
    end;
  end;
end;

procedure TfrmInstall.FormDestroy(Sender: TObject);
begin
  if BreakFile<>nil then FreeAndNil(BreakFile);
end;

procedure TfrmInstall.UpdateLabel(s: string);
begin
  Label4.Caption := s;
  Label4.Update;
end;

procedure TfrmInstall.cxbtnCancelClick(Sender: TObject);
begin
  Aborted := true;
end;

function TfrmInstall.CheckExeFile(filename: string): boolean;
var
  ProcessSnapShotHandle: THandle;
  ProcessEntry: TProcessEntry32;
  Ret: BOOL;
  s: string;
  Position: Integer;
begin
  result := false;
  ProcessSnapShotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if ProcessSnapShotHandle>0 then
  begin
    try
      ProcessEntry.dwSize:=SizeOf(TProcessEntry32);
      Ret:=Process32First(ProcessSnapShotHandle, ProcessEntry);
      while Ret do
      begin
        s:=LowerCase(ExtractFileName(ProcessEntry.szExeFile));
        if s=LowerCase(filename)
        then
          begin
            result := true;
            Break;
          end;
        //比较s的值就行了.
        Ret:=Process32Next(ProcessSnapShotHandle, ProcessEntry)
      end;
    finally
      CloseHandle(ProcessSnapShotHandle)
    end;
  end
end;
procedure TfrmInstall.SetCurVersion(const Value: string);
begin
  Label2.Caption := '软件版本：'+ Value;
end;

procedure TfrmInstall.SetNewVersion(const Value: string);
begin
  FNewVersion := Value;
  Label3.Caption := '最新版本：'+ Value;
end;

end.
