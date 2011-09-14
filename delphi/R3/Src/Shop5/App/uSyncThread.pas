unit uSyncThread;

interface
uses Classes,SysUtils,Windows,ActiveX;
type
  TSyncThread=class(TThread)
  private
    Proc:TNotifyEvent;
    FTimeOut: int64;
    hEvent: THandle;
    procedure SetTimeOut(const Value: int64);
  public
    constructor Create(AProc:TNotifyEvent;uTimeOut:int64);
    destructor Destroy; override;

    function Terminated:boolean;
    procedure Execute; override;
    
    property TimeOut:int64 read FTimeOut write SetTimeOut;
  end;
//开启自动同步任务
procedure StartSyncTask;
//结束同步任务
procedure StopSyncTask;
var SyncThread:TSyncThread;
implementation
uses uGlobal,uShopGlobal,uSyncFactory,ufrmLogo;
//开启自动同步任务
procedure StartSyncTask;
begin
  if not Global.RemoteFactory.Connected then Exit;
  if ShopGlobal.NetVersion or ShopGlobal.ONLVersion then Exit;
  if not SyncFactory.CheckThreadSync then Exit;
  if not SyncFactory.SyncLockCheck then Exit;
  if ShopGlobal.GetParameter('AUTO_SYNC')='0' then Exit; 
  SyncThread := TSyncThread.Create(SyncFactory.SyncThread,random(999999));
end;
//结束同步任务
procedure StopSyncTask;
begin
  if SyncThread=nil then Exit;
  frmLogo.Show;
  try
    frmLogo.ShowTitle := '正在关闭后台任务...';
    frmLogo.Position := 0;
    SyncFactory.Stoped := true;
    SyncThread.free;
    SyncThread := nil;
  finally
    frmLogo.Close;
  end;
end;
{ TSyncThread }

constructor TSyncThread.Create(AProc:TNotifyEvent;uTimeOut:int64);
begin
  Proc := AProc;
  FreeOnTerminate := false;
  TimeOut := uTimeOut;
  hEvent := CreateEvent(nil, True, False, nil);
  ResetEvent(hEvent);
  inherited Create(false);
end;

destructor TSyncThread.Destroy;
begin
  DoTerminate;
  SyncFactory.Stoped := true;
  SetEvent(hEvent);
  TimeOut := 1;
  inherited;
  if hEvent<>0 then CloseHandle(hEvent);
  SyncThread := nil;
end;

procedure TSyncThread.Execute;
begin
  CoInitialize(nil);
  try
    WaitForSingleObject(hEvent, TimeOut+60*1000*30);
    if not SyncFactory.Stoped then
       begin
         try
           Proc(nil);
         except
         end;
       end;
  finally
    CoUninitialize;
  end;
end;

procedure TSyncThread.SetTimeOut(const Value: int64);
begin
  FTimeOut := Value;
end;

function TSyncThread.Terminated: boolean;
begin
  result := inherited Terminated;
end;

initialization
  SyncThread := nil;
finalization
  if SyncThread<>nil then SyncThread.Free;
end.
