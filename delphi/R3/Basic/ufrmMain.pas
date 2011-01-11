unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,ScktCnst,
  Dialogs, Menus, ComCtrls, ActnList, ExtCtrls,ufrmBasic,ZBase,ShellAPI,Registry;

const
  WM_MIDASICON    = WM_USER + 1;
  WM_MODIIFYICON    = WM_USER + 2;
type
  TfrmMain = class(TfrmBasic)
    stbBottom: TStatusBar;
    PopupMenu: TPopupMenu;
    miClose: TMenuItem;
    UpdateTimer: TTimer;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FTaskMessage: DWord;
    FIconData: TNotifyIconData;
    NT351: Boolean;
    FProgmanOpen: Boolean;
    { Private declarations }
    FClientInstance, FPrevClientProc: TFarProc;
    FOnIconDbClick: TNotifyEvent;
    FParamStr: string;
    procedure ClientWndProc(var Message: TMessage);
    procedure SetOnIconDbClick(const Value: TNotifyEvent);
    procedure SetParamStr(const Value: string);
  public
    { Public declarations }
    DeskForm: TForm;
    procedure WriteRegistryInfo(ASysId:string);
    procedure ShowException(Sender: TObject; E: Exception);
    function  FindChildForm(AChild:TFormClass):TfrmBasic;overload;
    function  FindChildForm(Name:string):TfrmBasic;overload;
    procedure ShowForm(Form:TfrmBasic);
    procedure WMMIDASIcon(var Message: TMessage); message WM_MIDASICON;
    procedure WMMODIIFYICON(var Message: TMessage); message WM_MODIIFYICON;
    procedure WndProc(var Message: TMessage); override;
    procedure AddIcon;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OnIconDbClick:TNotifyEvent read FOnIconDbClick write SetOnIconDbClick;
  protected
    procedure WMClose(var Message: TWMClose); message WM_CLOSE;
  public
    procedure OpenAction(ActionName:string;Params:string); virtual;
    property ParamsStr:string read FParamStr write SetParamStr;
  end;

var
  frmMain: TfrmMain;

implementation
uses ufrmDesk,IniFiles;
{$R *.dfm}

procedure TfrmMain.WndProc(var Message: TMessage);
begin
  if Message.Msg = FTaskMessage then
  begin
    AddIcon;
    Refresh;
  end;
  inherited WndProc(Message);
end;
procedure TfrmMain.AddIcon;
begin
  Exit;
  if not NT351 then
  begin
    with FIconData do
    begin
      cbSize := SizeOf(FIconData);
      Wnd := Self.Handle;
      uID := $DEDB;
      uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
      hIcon := Forms.Application.Icon.Handle;
      uCallbackMessage := WM_MIDASICON;
      StrCopy(szTip, PChar(Caption));
    end;
    Shell_NotifyIcon(NIM_Add, @FIconData);
  end;
end;
procedure TfrmMain.FormResize(Sender: TObject);
var
  wRect: TRect;
begin
  GetWindowRect(ClientHandle, wRect);
  if Assigned(DeskForm) then
  begin
    DeskForm.SetBounds(0, 0, wRect.Right - wRect.Left, wRect.Bottom -
      wRect.Top);
  end;
end;

procedure TfrmMain.ClientWndProc(var Message: TMessage);
begin
  with Message do
    case Msg of
      WM_ERASEBKGND:
        begin
          FormResize(nil);
          Result := 1;
        end;
    $3F:
        begin
          SetWindowLong(ClientHandle, GWL_EXSTYLE, 0);
          SetWindowPos(ClientHandle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED
          or SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER); 
        end;
    else
      Result := CallWindowProc(FPrevClientProc, ClientHandle, Msg, wParam,
        lParam);
    end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  wRect: TRect;
begin
  GetWindowRect(ClientHandle, wRect);
  {登录完，显示主窗体，同时开始初始化数据}
  if Assigned(DeskForm) then
    DeskForm.SetBounds(0, 0, wRect.Right - wRect.Left, wRect.Bottom -
      wRect.Top);
end;

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;
  Application.OnException := ShowException;
  frmMain := Self;
  DeskForm := nil;
  FClientInstance := MakeObjectInstance(ClientWndProc);
  FPrevClientProc := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
  SetWindowLong(ClientHandle, GWL_WNDPROC, LongInt(FClientInstance));
end;

destructor TfrmMain.Destroy;
var i:Integer;
begin
  for i:= MDIChildCount-1 downto 0 do
    begin
      MDIChildren[i].Free;
    end;
  Application.OnException := nil;
  if Assigned(DeskForm) then
     begin
       FreeAndNil(DeskForm);
     end;
  inherited;
end;

procedure TfrmMain.WMClose(var Message: TWMClose);
begin
  inherited;
end;

function TfrmMain.FindChildForm(AChild: TFormClass): TfrmBasic;
var i:Integer;
begin
  Result := nil;
  for i:= Screen.FormCount -1 Downto 0 do
    begin
      if Screen.Forms[i].ClassType = AChild then
         begin
           Result := TfrmBasic(Screen.Forms[i]);
           Exit;
         end;
    end;
end;

procedure TfrmMain.ShowForm(Form: TfrmBasic);
begin
  if Form.WindowState = wsMinimized then
     Form.WindowState := wsMaximized;
  if Form.Visible then
     Form.BringToFront
  else
     Form.Show; 
end;

function TfrmMain.FindChildForm(Name: string): TfrmBasic;
var i:Integer;
begin
  Result := nil;
  for i:= Screen.FormCount -1 Downto 0 do
    begin
      if UpperCase(Screen.Forms[i].Name) = UpperCase(Name) then
         begin
           Result := TfrmBasic(Screen.Forms[i]);
           Exit;
         end;
    end;
end;

procedure TfrmMain.ShowException(Sender: TObject; E: Exception);
var Form:TForm;
    PWnd:THandle;
begin
  if E.Message = '' then Exit;
  Form := Screen.ActiveForm;
  if Form<>nil then
     PWnd := Form.Handle
  else
     PWnd := Application.Handle;

  MessageBox(PWnd,Pchar(E.Message),Pchar(Application.Title),MB_OK+MB_ICONWARNING)
end;

procedure TfrmMain.WMMIDASIcon(var Message: TMessage);
var
  pt: TPoint;
begin
  case Message.LParam of
    WM_RBUTTONUP:
    begin
      if not Visible then
      begin
        SetForegroundWindow(Handle);
        GetCursorPos(pt);
        PopupMenu.Popup(pt.x, pt.y);
      end else
        SetForegroundWindow(Handle);
    end;
    WM_LBUTTONDBLCLK:
    begin
      if Visible then SetForegroundWindow(Handle) ;
      if Assigned(FOnIconDbClick) then
         FOnIconDbClick(nil);
    end;
  end;
end;

procedure TfrmMain.miCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
  function IE4Installed: Boolean;
  var
    RegKey: HKEY;
  begin
    Result := False;
    if RegOpenKey(HKEY_LOCAL_MACHINE, KEY_IE, RegKey) = ERROR_SUCCESS then
    try
      Result := RegQueryValueEx(RegKey, 'Version', nil, nil, nil, nil) = ERROR_SUCCESS;
    finally
      RegCloseKey(RegKey);
    end;
  end;
begin
  inherited;
  NT351 := (Win32MajorVersion <= 3) and (Win32Platform = VER_PLATFORM_WIN32_NT);
  AddIcon;
  if IE4Installed then
    FTaskMessage := RegisterWindowMessage('TaskbarCreated') else
    UpdateTimer.Enabled := True;
end;

procedure TfrmMain.UpdateTimerTimer(Sender: TObject);
var
  Found: Boolean;
begin
  Found := FindWindow('Progman', nil) <> 0;
  if Found <> FProgmanOpen then
  begin
    FProgmanOpen := Found;
    if Found then AddIcon;
    Refresh;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  inherited;
  UpdateTimer.Enabled := False;
  if not NT351 then
    Shell_NotifyIcon(NIM_DELETE, @FIconData);
end;

procedure TfrmMain.SetOnIconDbClick(const Value: TNotifyEvent);
begin
  FOnIconDbClick := Value;
end;

procedure TfrmMain.WMMODIIFYICON(var Message: TMessage);
begin
  if not NT351 then
  begin
    if FIconData.hIcon =  Message.WParam then Exit;
    with FIconData do
    begin
      cbSize := SizeOf(FIconData);
      Wnd := Self.Handle;
      uID := $DEDB;
      uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
      hIcon := Message.WParam;
      uCallbackMessage := WM_MIDASICON;
      StrCopy(szTip, PChar(Caption));
    end;
    Shell_NotifyIcon(NIM_MODIFY, @FIconData);
  end;
end;

procedure TfrmMain.OpenAction(ActionName: string;Params:string);
var i:Integer;
begin
  for i:=0 to actList.ActionCount -1 do
    begin
      if uppercase(actList.Actions[i].Name) = uppercase(ActionName) then
         begin
           FParamStr := Params;
           actList.Actions[i].OnExecute(nil);
           Break;
         end;
    end;
end;

procedure TfrmMain.SetParamStr(const Value: string);
begin
  FParamStr := Value;
end;

procedure TfrmMain.WriteRegistryInfo(ASysId:string);
var
  Reg: TRegistry;
  SoftGUID: string;
  F:TIniFile;
begin
  if ASysId='' then
  begin
    F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'system.info');
    try
      ASysId := F.ReadString('SYSTEM','SysId','');
      Caption := F.ReadString('SYSTEM','SysName',Application.Title);
    finally
      F.Free;
    end;
  end;
  if ASysId='' then Exit;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if not Reg.KeyExists('SOFTWARE\Classes\Srvr\'+ASysId) then
       Reg.CreateKey('SOFTWARE\Classes\Srvr\'+ASysId);
    Reg.OpenKey('SOFTWARE\Classes\Srvr\'+ASysId, True);
    Reg.WriteInteger('FormHandle',Handle);
    Reg.WriteString('InstallPath',ExtractFilePath(ParamStr(0)));
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
end;

end.
