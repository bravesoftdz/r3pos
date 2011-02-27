unit ufrmSvcMgr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, COMAdmin,CmAdmCtl,ExtCtrls;

type
  TfrmSvcMgr = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image1: TImage;
    Image2: TImage;
    Timer1: TTimer;
    Bevel1: TBevel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSvcMgr: TfrmSvcMgr;

implementation

uses WinSvc;

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
          frmSvcMgr.Image2.Visible := true;
          frmSvcMgr.Image1.Visible := false;
          frmSvcMgr.SpeedButton1.Enabled := true;
          frmSvcMgr.SpeedButton2.Enabled := false;
        end;
      SERVICE_RUNNING:
        begin
          frmSvcMgr.Image2.Visible := false;
          frmSvcMgr.Image1.Visible := true;
          frmSvcMgr.SpeedButton1.Enabled := false;
          frmSvcMgr.SpeedButton2.Enabled := True;
        end;
      end;
    finally
      CloseServiceHandle(hService);
    end;
  finally
    CloseServiceHandle(SCManager);
  end;
end;

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

procedure CloseApplication;
var
  i : ICOMAdminCatalog;
  l : ICatalogCollection;
  k : ICatalogObject;
  r:Integer;
  vProgId:TStrings;
begin
//  CoInitialize(nil);
  try
    i:=CoCOMAdminCatalog.Create;
    l:=i.GetCollection('Applications') as ICatalogCollection;
    l.Populate;
    for r:= 0 to l.Count -1 do
      begin
        k:= l.Item[r] as ICatalogObject;
        if k.Name = 'RSPScktSrvr' then
           Break
        else
           k := nil;
      end;
    if k=nil then
       begin
         k:=l.Add as ICatalogObject;
         k.Value['Name']:='RSPScktSrvr';
         l.SaveChanges;
       end;
    if k<>nil then
       i.ShutdownApplication(k.Name);
  finally
    //CoUninitialize;
  end;
end;

{$R *.dfm}

procedure TfrmSvcMgr.SpeedButton1Click(Sender: TObject);
begin
  StartService('RSPScktSrvr');
end;

procedure TfrmSvcMgr.SpeedButton2Click(Sender: TObject);
begin
  StopService('RSPScktSrvr');
  CloseApplication;
end;

procedure TfrmSvcMgr.SpeedButton4Click(Sender: TObject);
begin
  QueryService('RSPScktSrvr');
end;

procedure TfrmSvcMgr.Timer1Timer(Sender: TObject);
begin
  QueryService('RSPScktSrvr');
end;

end.
