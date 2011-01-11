unit uDownByHttp;

interface
  uses Windows, Messages, SysUtils, Classes, WinInet, WinSock,Forms
  , IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TOnProgressEvent = procedure(Sender: TObject; TotalSize, Readed: Integer) of object;

  TDownByHttp = class;

  TDownByHttpThread = class(TThread)
  private
    FTDownByHttp: TDownByHttp;
    FTURL: String;
    FTResult: Boolean;
    FTInfoString: String;
    FTFileSize: Int64;
    FDone: boolean;
    BytesReaded: Int64;
    BytesToRead:DWord;
    FTFile:TStream;
    FDelayTime: Integer;
    idHttp:TidHTTP;
    {更新进度事件}
    procedure UpdateProgress;
    procedure SetDelayTime(const Value: Integer);
  protected
    procedure DoTerminate; override;
    procedure IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode;
    const AWorkCount: Integer);
    procedure Execute; override;
  public
    constructor Create(aInfoURL: String;aFileStream: TStream;
      aDownByHttp: TDownByHttp);
    property DelayTime:Integer read FDelayTime write SetDelayTime;
  end;

  TDownByHttp = class(TComponent)
  private
    FFileURL: string;   {远程目标文件URL}
    FFileName: string;  {下载到本地的文件名}
    FUser   : string;   {登录远程WEB服务器的用户名}
    FPassWrd: string;   {登录远程WEB服务器的密码}
    FDone   : boolean;  {是否完整下载完成}
    FProgress: TOnProgressEvent;
    FDownFile: TDownByHttpThread;
    FFile:TFileStream;
    FDelayTime: Integer;
    FHasFile: Boolean;
    {下载文件完成}
    procedure DownFileDone(Sender: TObject);
    function IsDone: boolean;
    function GetEnded: Boolean;
    procedure SetDelayTime(const Value: Integer);
    procedure SetHasFile(const Value: Boolean);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure DownFile;          {开始下载文件}
    procedure LoadBreakFile;
    procedure CancelDownLoad;    {取消下载过程}
    {初始化进度条句柄}
    procedure InitPosHandle(PosHandle: HWND);
  published
    property FileURL: String read FFileURL write FFileURL;
    property FileName: String read FFileName write FFileName;
    property User: String read FUser write FUser;
    property PassWrd: String read FPassWrd write FPassWrd;
    property Ended:Boolean read GetEnded;
    property Done: boolean read IsDone;
    property OnProgress: TOnProgressEvent read FProgress write FProgress;
    property DelayTime:Integer read FDelayTime write SetDelayTime;
    property LocalFile:TFileStream read FFile;
    property HasFile:Boolean read FHasFile write SetHasFile;
  end;

procedure Register;

implementation

var
  //TempDir: String;
  PosHWND: HWND = 0;

// Function that checks the online status
function IsOnline: Boolean;
var
  Size: Integer;
  PC: Array[0..4] of Char;
  Key: hKey;

 function IsIPPresent: Boolean;
 type
   TaPInAddr = Array[0..10] of PInAddr;
   PaPInAddr = ^TaPInAddr;
 var
   phe: PHostEnt;
   pptr: PaPInAddr;
   Buffer: Array[0..63] of Char;
   I: Integer;
   GInitData: TWSAData;
   IP: String;
 begin
   WSAStartup($101, GInitData);
   Result := False;
   GetHostName(Buffer, SizeOf(Buffer));
   phe := GetHostByName(buffer);
   if phe = nil then Exit;
   pPtr := PaPInAddr(phe^.h_addr_list);
   I := 0;
   while pPtr^[I] <> nil do
    begin
     IP := inet_ntoa(pptr^[I]^);
     Inc(I);
    end;
   WSACleanup;
   Result := (IP <> '') and (IP <> '127.0.0.1');
 end;

begin
  if RegOpenKey(HKEY_LOCAL_MACHINE, 'System\CurrentControlSet\Services\RemoteAccess', Key) = ERROR_SUCCESS then
   begin
    Size := 4;
    if RegQueryValueEx(Key, 'Remote Connection', nil, nil, @PC, @Size) = ERROR_SUCCESS then
     Result := PC[0] = #1
    else
     Result := IsIPPresent;
    RegCloseKey(Key);
   end
  else Result := IsIPPresent;
end;

//TDownByHttpThread
constructor TDownByHttpThread.Create(aInfoURL: String;aFileStream: TStream;aDownByHttp: TDownByHttp);
begin
  FreeOnTerminate := true;
  inherited Create(false);

  FTURL := aInfoURL;
  FTDownByHttp := aDownByHttp;
  FDone      := false;
  FTFile := aFileStream;
end;

procedure TDownByHttpThread.UpdateProgress;
begin
  FTDownByHttp.FProgress(Self, FTFileSize, BytesReaded);
end;

procedure TDownByHttpThread.Execute;
begin
  idHttp := TidHTTP.Create(nil);
  try
    try
      idHTTP.OnWork := IdHTTPWork;
      //if FTFile.Size>0 then
      //   begin
      //      IdHTTP.Request.ContentRangeStart := FTFile.Size-1;
      //      FTFile.Position := FTFile.Size-1;
      //   end
      //else
         begin
            IdHTTP.Request.ContentRangeStart := 0;
            FTFile.Position := 0;
         end;
      IdHTTP.Head(FTURL);
      FTFileSize := IdHTTP.Response.ContentLength;
      IdHTTP.Request.ContentRangeEnd := FTFileSize;

      IdHTTP.ReadTimeout:=30000;
      //IdHTTP.HTTPOptions:=IdHTTP.HTTPOptions+[hoKeepOrigProtocol];//关键这行
      //IdHTTP.ProtocolVersion:=pv1_1;

      IdHTTP.Get(FTURL,FTFile);
      FDone := true;
    except
      FDone := false;
    end;
  finally
    FreeAndNil(idHttp);
    FTDownByHttp.DownFileDone(nil);
  end;
end;
{procedure TDownByHttpThread.Execute;

label Aborted1, Aborted2, Aborted3, Aborted4;

var
  hSession,hRequest: hInternet;
  Buf: Pointer;
  dwBufLen, dwIndex: DWord;
  dwstart:Int64;
  Data: Array[0..$400] of Char;
begin
  try
  FTResult := false;
  hSession := InternetOpen('',
    INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Terminated then goto Aborted1;
  if hSession=nil then goto Aborted1;

  hRequest := InternetOpenUrl(hSession, PChar(FTURL), nil, 0, INTERNET_FLAG_RELOAD, 0);

  if hRequest=nil then goto Aborted3;
  if Terminated then goto Aborted3;

  dwIndex  := 0;
  dwBufLen := 1024;
  GetMem(Buf, dwBufLen);

  FTResult := HttpQueryInfo(hRequest, HTTP_QUERY_CONTENT_LENGTH,
                            Buf, dwBufLen, dwIndex);

  if Terminated then goto Aborted4;

  if FTResult then
   begin
    FTFileSize := StrToInt(StrPas(Buf));
    dwstart := FTFile.Size;
    if InternetSetFilePointer(hRequest,dwstart,nil,FILE_BEGIN,0)<>-1 then
       begin
         FTFile.Position := FTFile.Size;
         BytesReaded := FTFile.Size;
       end
    else //不支持断点，重新下载
       begin
         FTFile.Position := 0;
         BytesReaded := 0;
       end;
    while not Terminated do
     begin
      if DelayTime>0 then Sleep(DelayTime);
      if BytesReaded = FTFileSize then
         begin
           FDone := true;
           Break;
         end;
      if not InternetReadFile(hRequest, @Data, SizeOf(Data), BytesToRead) then
         Break
      else
       if BytesToRead = 0 then
       begin
         if BytesReaded = FTFileSize then
            begin
              FDone := true;
            end;
         Break;
       end
       else
        begin
          FTFile.Write(Data[0],BytesToRead);
          inc(BytesReaded, BytesToRead);
          if Assigned(FTDownByHttp.FProgress) then
             Synchronize(UpdateProgress);
          if PosHWND <> 0 then
             SendMessage(PosHWND, $0400 + 2, (BytesReaded) div (FTFileSize div 100),0);
          if BytesReaded >= FTFileSize then
             begin
               FDone := true;
               Break;
             end;
        end;
     end;

     FTResult := FTFileSize = Integer(BytesReaded);
   end
   else
     FTResult := false;

  Aborted4:
  FreeMem(Buf);
  Aborted3:
  InternetCloseHandle(hRequest);
  Aborted1:
  InternetCloseHandle(hSession);
  finally
    FTDownByHttp.DownFileDone(nil);
  end;
end;    }

{ TDownByHttp }

procedure TDownByHttp.CancelDownLoad;
begin
  if Assigned(FDownFile) then
  begin
     FDownFile.DoTerminate;
     FDownFile.Terminate;
     FDone := false;
  end;
end;

constructor TDownByHttp.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FUser    := '';
  FFileURL := '';
  FPassWrd := '';
  FDone    := false;
  FDownFile := nil;
  FFile := nil;
end;

destructor TDownByHttp.Destroy;
begin
  if Assigned(FDownFile) then FDownFile.DoTerminate;
  if Assigned(FFile) then FreeAndNil(FFile);
  inherited Destroy;
end;

procedure TDownByHttp.DownFile;
begin
  FDownFile := TDownByHttpThread.Create(FFileURL,FFile,Self);
  FDownFile.DelayTime := DelayTime;
  FDone := false;
  FHasFile := false;
end;

procedure TDownByHttp.DownFileDone(Sender: TObject);
begin
  if Assigned(FFile) then FreeAndNil(FFile);
  FDone := FDownFile.FDone;
  if FDone then
     begin
       DeleteFile(FileName);
       FDone := MoveFile(Pchar(FileName+'.ft'),Pchar(FileName));
     end;
  FDownFile := nil;
  SendMessage(PosHWND, $0400 + 2, 100,0);
end;

procedure Register;
begin
  RegisterComponents('zhangsr', [TDownByHttp]);
end;

function TDownByHttp.GetEnded: Boolean;
begin
  result := (FDownFile=nil);
end;

procedure TDownByHttp.InitPosHandle(PosHandle: HWND);
begin
  PosHWND := PosHandle;
  if PosHWND <> 0 then
    SendMessage(PosHWND, $0400 + 2, 0, 0);
end;

function TDownByHttp.IsDone: boolean;
begin
  Result := FDone;
end;

procedure TDownByHttp.LoadBreakFile;
begin
  if Assigned(FFile) then FreeAndNil(FFile);
  if FileExists(FileName+'.ft') then
     FFile := TFileStream.Create(FileName+'.ft',fmOpenReadWrite)
  else
     FFile := TFileStream.Create(FileName+'.ft',fmCreate);
end;

procedure TDownByHttp.SetDelayTime(const Value: Integer);
begin
  FDelayTime := Value;
end;

procedure TDownByHttpThread.SetDelayTime(const Value: Integer);
begin
  FDelayTime := Value;
end;

procedure TDownByHttpThread.IdHTTPWork(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
  BytesReaded := FTFile.Position;
  if PosHWND <> 0 then
     SendMessage(PosHWND, $0400 + 2, (BytesReaded) div (FTFileSize div 100),0);
  if Assigned(FTDownByHttp.FProgress) then
     Synchronize(UpdateProgress);

  FTDownByHttp.HasFile := (BytesReaded>0);
end; 

procedure TDownByHttpThread.DoTerminate;
begin
  if idHTTP<>nil then idHTTP.Disconnect;
  inherited;

end;

procedure TDownByHttp.SetHasFile(const Value: Boolean);
begin
  FHasFile := Value;
end;

end.
