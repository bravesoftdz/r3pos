unit dllApi;

interface
uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  ZIntf,ExtCtrls,
  uTokenFactory,
  ufrmWebForm,
  uRspFactory,
  udataFactory;

//1.初始化应用
//说明：传入appId与令牌，初始化成功后返回true
function initApp(appWnd:Thandle;_dbHelp:IdbDllHelp;_token:pchar):boolean;stdcall;
//2.打开应用
//说明：打开应用中指定的模块
function openApp(hWnd:Thandle;moduId:pchar):boolean;stdcall;
//3.关闭应用
//说明：关闭应用中打开的模块
//返回值:false代表不允许关闭，true关闭成功
function closeApp(moduId:pchar):boolean;stdcall;
//4.释放资源
function eraseApp(synced:boolean):boolean;stdcall;

//5.读取错误说明
function getLastError:pchar;stdcall;
//6.获取标题名
function getModuleName(moduId:Pchar):Pchar;stdcall;

function resize:boolean;stdcall;

function sendMsg(buf:Pchar;moduId:pchar):boolean;stdcall;

function getToken:pchar;stdcall;

procedure freeApp(mid:string);
type
  TdllApplication=class
  private
    Fhandle: THandle;
    Fmode: string;
    Finited: boolean;
    timer:TTimer;
    EvtHandle:THandle;
    ThreadLock:TRTLCriticalSection;
    procedure Sethandle(const Value: THandle);
    procedure Setmode(const Value: string);
    procedure Setinited(const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;

    procedure WaitForTimer;
    procedure onTimer(Sender: TObject);
    function getDllClass(name:string):TPersistentClass;
    function getModuId(name:string):string;
    procedure dllException(Sender: TObject; E: Exception);
    property handle:THandle read Fhandle write Sethandle;
    property mode:string read Fmode write Setmode;
    property inited:boolean read Finited write Setinited;
  end;

var
  lastError:string;
  buf:string;
  dbHelp:IdbDllHelp;
  dllApplication:TdllApplication;

implementation

uses udllGlobal,uSyncFactory,IniFiles,uDevFactory,uRightsFactory,uRspSyncFactory,
     uCacheFactory,udllXDictFactory,ufrmSortDropFrom,uRtcSyncFactory,uRtcLibFactory,
     uCodePrinterFactory;

var
  webForm:TStringList;
  oldHandle:THandle;

procedure Halt0;
begin
  halt;
end;

procedure DLLEntryPoint(dwReason: DWord);
begin
  if (dwReason = DLL_PROCESS_DETACH) Then
  Begin
    Application.Handle := oldHandle;
    eraseApp(false);
    asm
      xor edx, edx
      push ebp
      push OFFSET @@safecode
      push dword ptr fs:[edx]
      mov fs:[edx],esp
      call Halt0
      jmp @@exit;
      @@safecode:
      call Halt0;
      @@exit:
    end; 
  end;
end;

//1.初始化应用
//说明：传入appId与令牌，初始化成功后返回true
function initApp(appWnd:Thandle;_dbHelp:IdbDllHelp;_token:pchar):boolean;stdcall;
begin
  try
    DllProc := @DLLEntryPoint;
    DllProcEX := @DLLEntryPoint;
    webForm := TStringList.Create;
    oldHandle := Application.Handle;
    dllApplication.handle := appWnd;
    Application.OnException := dllApplication.dllException;
    Application.Handle := appWnd;
    token.decode(strpas(_token));
    dbHelp:= _dbHelp;
    rspFactory := TrspFactory.Create(nil);
    result := true;
    dataFactory.MoveToDefault;
    SyncFactory.LoginSync(appWnd);
    dllApplication.inited := true;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

//2.打开应用
//说明：打开应用中指定的模块
function openApp(hWnd:Thandle;moduId:pchar):boolean;stdcall;
var
  pClass:TPersistentClass;
  Form:TfrmWebForm;
  mid:string;
begin
  try
    mid := dllApplication.getModuId(moduId);
    pClass := dllApplication.getDllClass(mid);
    if pClass = nil then Raise Exception.Create(mid+'类名没找到.');
    Form := TFormClass(pClass).Create(application) as TfrmWebForm;
    webForm.AddObject(mid,Form);
    Form.hWnd := hWnd;
    Form.showForm;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

procedure freeApp(mid:string);
var
  idx:integer;
begin
  if not assigned(webForm) then Exit;
  idx := webForm.IndexOf(mid);
  if idx>=0 then
     begin
       webForm.Delete(idx);
     end;
end;

//3.关闭应用
//说明：关闭应用中打开的模块
//返回值:false代表不允许关闭，true关闭成功
function closeApp(moduId:pchar):boolean;stdcall;
var
  idx:integer;
  mid:string;
  Form:TForm;
begin
  try
    if assigned(frmSortDropFrom) and frmSortDropFrom.droped then Raise Exception.Create('当前模块正在操作...');
    mid := dllApplication.getModuId(moduId);
    idx := webForm.IndexOf(mid);
    if idx>=0 then
       begin
         if not TfrmWebForm(webForm.Objects[idx]).checkCanClose then Raise Exception.Create('正在业务中，不能关闭。');
         Form := TForm(webForm.Objects[idx]);
         webForm.Delete(idx);
         Form.Free;
       end;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

//4.释放资源
function eraseApp(synced:boolean):boolean;stdcall;
var
  i:integer;
  Form:TForm;
begin
  try
    result := true;
    if not Assigned(webForm) then Exit;
    if assigned(frmSortDropFrom) and frmSortDropFrom.droped then Raise Exception.Create('当前模块正在操作...');
    dllApplication.inited := false;
    if assigned(SyncFactory) then SyncFactory.timerTerminted := true;
    dllApplication.WaitForTimer;
    if assigned(SyncFactory) and synced then SyncFactory.LogoutSync(dllApplication.handle);
    while webForm.Count>0 do
       begin
          Form := TfrmWebForm(webForm.Objects[0]);
          webForm.Delete(0);
          Form.Free;
       end;
    //if assigned(frmSortDropFrom) then FreeAndNil(frmSortDropFrom);
    if assigned(DevFactory) then FreeAndNil(DevFactory);
    if assigned(CodePrinterFactory) then FreeAndNil(CodePrinterFactory);
    if assigned(RightsFactory) then FreeAndNil(RightsFactory);
    if assigned(RtcLibFactory) then FreeAndNil(RtcLibFactory);
    if assigned(RtcSyncFactory) then FreeAndNil(RtcSyncFactory);
    if assigned(RspSyncFactory) then FreeAndNil(RspSyncFactory);
    if assigned(SyncFactory) then FreeAndNil(SyncFactory);
    if assigned(CacheFactory) then FreeAndNil(CacheFactory);
    if assigned(RspFactory) then FreeAndNil(RspFactory);
    if assigned(XDictFactory) then FreeAndNil(XDictFactory);
    if assigned(dllGlobal) then FreeAndNil(dllGlobal);
    if assigned(dataFactory) then FreeAndNil(dataFactory);
    if assigned(token) then FreeAndNil(token);
    FreeAndNil(webForm);
    dbHelp := nil;
    Application.OnException := nil;
    Application.Handle := oldHandle;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

//5.读取错误说明
function getLastError:pchar;stdcall;
begin
  result := Pchar(lastError);
end;

//6.获取标题名
function getModuleName(moduId:Pchar):Pchar;
var
  idx:integer;
  mid:string;
begin
  try
    mid := dllApplication.getModuId(moduId);
    idx := webForm.IndexOf(mid);
    if idx>=0 then
       begin
         buf:= TForm(webForm.Objects[idx]).caption;
         result := Pchar(buf);
       end
    else
       result := '无';
  except
    on E:Exception do
       begin
         result := nil;
         lastError := E.Message;
       end;
  end;
end;

function resize:boolean;stdcall;
var
  i:integer;
begin
  try
    for i:=webForm.Count -1 downto 0 do
       begin
         TfrmWebForm(webForm.Objects[i]).ajustPostion;
       end;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

function sendMsg(buf:Pchar;moduId:pchar):boolean;stdcall;
var
  idx:integer;
  mid:string;
begin
  try
    mid := dllApplication.getModuId(moduId);
    idx := webForm.IndexOf(mid);
    if idx>=0 then
       begin
         TfrmWebForm(webForm.Objects[idx]).Buf := StrPas(buf);
         PostMessage(TForm(webForm.Objects[idx]).Handle,WM_SEND_MSG,0,0);
       end;
     result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

function getToken:pchar;stdcall;
begin
  try
    if RtcLibFactory.GetToken<>0 then Raise Exception.Create('读取令牌失败了');
    if RtcLibFactory.NetStatus = 0 then
       buf := RtcLibFactory.ticket
    else
       buf := '';
    result := pchar(buf);
  except
    on E:Exception do
       begin
         result := nil;
         lastError := E.Message;
       end;
  end;
end;

constructor TdllApplication.Create;
var
  F:TIniFile;
begin
  InitializeCriticalSection(ThreadLock);
  EvtHandle := CreateEvent(nil, True, False, nil);
  ResetEvent(EvtHandle);
  timer := TTimer.Create(nil);
  timer.OnTimer := onTimer;
  timer.Enabled := false;
  timer.Interval := 30*60*1000;
//  timer.Interval := 1000;
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'r3.cfg');
  try
    mode := F.ReadString('soft','mode','release');
  finally
    F.Free;
  end;
end;

destructor TdllApplication.Destroy;
begin
  CloseHandle(EvtHandle);
  DeleteCriticalSection(ThreadLock);
  timer.Free;
  inherited;
end;

procedure TdllApplication.dllException(Sender: TObject; E: Exception);
var wnd:THandle;
begin
  if Screen.ActiveForm<>nil then
     wnd := Screen.ActiveForm.Handle
  else
     wnd := Application.Handle;
  MessageBox(wnd,pchar(E.Message),'友情提醒',MB_OK+MB_ICONINFORMATION);
end;

function TdllApplication.getDllClass(name: string): TPersistentClass;
begin
  if (lowercase(name)='tfrmsaleorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'1') then
     begin
       name := 'TfrmPosOutOrder';
     end
  else
  if (lowercase(name)='tfrmstockorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'1') then
     begin
       name := 'TfrmPosInOrder';
     end;
  result := getClass(name);
end;

function TdllApplication.getModuId(name: string): string;
begin
  if token.tenantId='' then name:='TfrmSysDefine';
  if (lowercase(name)='tfrmsaleorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'1') then
     begin
       name := 'TfrmPosOutOrder';
     end
  else
  if (lowercase(name)='tfrmstockorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'1') then
     begin
       name := 'TfrmPosInOrder';
     end;
  result := name;
end;

procedure TdllApplication.onTimer(Sender: TObject);
begin
  if assigned(SyncFactory) then SyncFactory.TimerSync;
end;

procedure TdllApplication.Sethandle(const Value: THandle);
begin
  Fhandle := Value;
end;

procedure TdllApplication.Setinited(const Value: boolean);
begin
  Finited := Value;
  timer.Enabled := Value;
end;

procedure TdllApplication.Setmode(const Value: string);
begin
  Fmode := Value;
end;

procedure TdllApplication.WaitForTimer;
begin
  EnterCriticalSection(ThreadLock);
  try
    if SyncFactory=nil then Exit;
    while true do
      begin
        if not SyncFactory.timered then Exit;
        WaitForSingleObject(EvtHandle,500);
      end;
  finally
    LeaveCriticalSection(ThreadLock);
  end;
end;

initialization
  dllApplication := TdllApplication.create;
finalization
  if assigned(dllApplication) then FreeAndNil(dllApplication);
end.
