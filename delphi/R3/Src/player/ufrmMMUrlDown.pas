unit ufrmMMUrlDown;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPrgres, ActiveX, RzButton, StdCtrls, RzLabel, UrlMon, ExtCtrls,
  RzTray;
type
  TDownLoadMonitor = class( TInterfacedObject, IBindStatusCallback )
   private
   protected
      function OnStartBinding( dwReserved: DWORD; pib: IBinding ): HResult; stdcall;
      function GetPriority( out nPriority ): HResult; stdcall;
      function OnLowResource( reserved: DWORD ): HResult; stdcall;
      function OnProgress( ulProgress, ulProgressMax, ulStatusCode: ULONG;
           szStatusText: LPCWSTR): HResult; stdcall;
      function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc: PFormatEtc;
           stgmed: PStgMedium): HResult; stdcall;
      function OnStopBinding( hresult: HResult; szError: LPCWSTR ): HResult; stdcall;
      function GetBindInfo( out grfBINDF: DWORD; var bindinfo: TBindInfo ): HResult; stdcall;
      function OnObjectAvailable( const iid: TGUID; punk: IUnknown ): HResult; stdcall;
  end;

  TMMUrlDown=class(TThread)
  public
    procedure Execute; override;
    constructor Create;
    destructor Destroy; override;
  end;

  TfrmMMUrlDown = class(TForm)
    btnCancel: TRzBitBtn;
    RzProgressBar1: TRzProgressBar;
    RzLabel1: TRzLabel;
    Timer1: TTimer;
    Bevel1: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FStoped: boolean;
    Fdowning: boolean;
    procedure SetStoped(const Value: boolean);
    procedure Setdowning(const Value: boolean);
    { Private declarations }
  public
    { Public declarations }
    BindStatus:IBindStatusCallback;
    MMUrlDown:TMMUrlDown;
    
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function DownFile(url:string;filename:string):boolean;
    procedure UrlDown(Sender: TObject);
    property Stoped:boolean read FStoped write SetStoped;
    property downing:boolean read Fdowning write Setdowning;
  end;

var
  frmMMUrlDown: TfrmMMUrlDown;

implementation
uses ufrmMMPlayer,IniFiles;
{$R *.dfm}
function TDownLoadMonitor.GetBindInfo( out grfBINDF: DWORD; var bindinfo: TBindInfo ): HResult;
begin
     result := S_OK;
end;

function TDownLoadMonitor.GetPriority( out nPriority ): HResult;
begin
     Result := S_OK;
end;

function TDownLoadMonitor.OnDataAvailable(grfBSCF, dwSize: DWORD;
  formatetc: PFormatEtc; stgmed: PStgMedium): HResult;
begin
     Result := S_OK;
end;

function TDownLoadMonitor.OnLowResource( reserved: DWORD ): HResult;
begin
     Result := S_OK;
end;

function TDownLoadMonitor.OnObjectAvailable( const iid: TGUID; punk: IInterface ): HResult;
begin
     Result := S_OK;
end;

function TDownLoadMonitor.OnProgress( ulProgress, ulProgressMax, ulStatusCode: ULONG; szStatusText: LPCWSTR ): HResult;
begin
    Application.ProcessMessages;
    if frmMMUrlDown.Stoped then
         Result := E_ABORT
    else
         Result := S_OK;
end;

function TDownLoadMonitor.OnStartBinding( dwReserved: DWORD; pib: IBinding ): HResult;
begin
     Result := S_OK;
end;

function TDownLoadMonitor.OnStopBinding( hresult: HResult; szError: LPCWSTR ): HResult;
begin
     Result := S_OK;
end;


{ TfrmMMUrlDown }

procedure TfrmMMUrlDown.SetStoped(const Value: boolean);
begin
  FStoped := Value;
  if Value then btnCancel.Caption := '下载' else btnCancel.Caption := '停止';
end;

procedure TfrmMMUrlDown.FormCreate(Sender: TObject);
begin
  BindStatus := TDownLoadMonitor.Create;
end;

function TfrmMMUrlDown.DownFile(url: string;filename:string): boolean;
begin
  result := (UrlDownloadToFile(nil, PChar(url), PChar(filename), 0, BindStatus)=0);
end;

procedure TfrmMMUrlDown.UrlDown(Sender: TObject);
var
  F:TIniFile;
  Session:TStringList;
  i:integer;
  url,filename:string;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'adv\playlist.ini');
  Session := TStringList.Create;
  downing := true;
  try
    F.ReadSections(Session);
    for i := 0 to Session.Count - 1 do
    begin
      if not F.ReadBool(Session[i],'ready',false) and not Stoped then
         begin
           filename := F.ReadString(Session[i],'filename','');
           url := F.ReadString(Session[i],'url','');
           RzLabel1.Caption := '下载'+url;
           RzLabel1.Update;
           if DownFile(url,filename) then F.WriteBool(Session[i],'ready',true);
         end;
    end;
    PostMessage(frmMMPlayer.Handle,WM_PLAYLIST_REFRESH,1,1);
    RzLabel1.Caption := '下载完成';
  finally
    Session.Free;
    F.Free;
    downing := false;
  end;
end;

constructor TfrmMMUrlDown.Create(AOwner: TComponent);
begin
  inherited;
  MMUrlDown := nil;
  Stoped := true;
end;

destructor TfrmMMUrlDown.Destroy;
begin
  if MMUrlDown<>nil then freeAndnil(MMUrlDown);
  inherited;
end;

procedure TfrmMMUrlDown.Setdowning(const Value: boolean);
begin
  Fdowning := Value;
end;

{ TMMUrlDown }

constructor TMMUrlDown.Create;
begin
  FreeOnTerminate := true;
  frmMMUrlDown.Stoped := true;
  inherited Create(false);
end;

destructor TMMUrlDown.Destroy;
begin
  frmMMUrlDown.MMUrlDown := nil;
  frmMMUrlDown.Stoped := true;
  inherited;
end;

procedure TMMUrlDown.Execute;
begin
  frmMMUrlDown.Stoped := false;
  frmMMUrlDown.RzProgressBar1.Percent := 0;
  frmMMUrlDown.UrlDown(self);
  frmMMUrlDown.RzProgressBar1.Percent := 100;
  frmMMUrlDown.Stoped := true;
end;

procedure TfrmMMUrlDown.Timer1Timer(Sender: TObject);
begin
  if frmMMUrlDown.downing then Exit;
  if not frmMMUrlDown.Stoped then Exit;
  frmMMUrlDown.MMUrlDown := TMMUrlDown.Create;
end;

procedure TfrmMMUrlDown.btnCancelClick(Sender: TObject);
begin
  if Stoped then Timer1Timer(self) else Stoped := true;
end;

end.
