
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Borland Socket Server source code               }
{                                                       }
{       Copyright (c) 1997,99 Inprise Corporation       }
{                                                       }
{*******************************************************}

unit uSrvrMain;

interface

uses
  SvcMgr, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,Variants,
  Dialogs, Menus, ShellAPI, ExtCtrls, StdCtrls, ComCtrls, ScktComp,SyncObjs,ZConst,
  ActnList, DB,OleServer,ImgList,ZIocp,ZServer,ZPacket,ZWSock2,MidConst,ZLogFile;

const
  WM_MIDASICON    = WM_USER + 1;
  UI_INITIALIZE   = WM_USER + 2;
  WM_UPDATESTATUS = WM_USER + 6;
type

  TSocketForm = class(TForm)
    pmuSystem: TPopupMenu;
    miClose: TMenuItem;
    N1: TMenuItem;
    miProperties: TMenuItem;
    UpdateTimer: TTimer;
    MainMenu1: TMainMenu;
    miPorts: TMenuItem;
    miAdd: TMenuItem;
    miRemove: TMenuItem;
    Pages: TPageControl;
    PropPage: TTabSheet;
    PortGroup: TGroupBox;
    Label1: TLabel;
    PortDesc: TLabel;
    PortNo: TEdit;
    PortUpDown: TUpDown;
    ThreadGroup: TGroupBox;
    Label4: TLabel;
    ThreadDesc: TLabel;
    ThreadSize: TEdit;
    ThreadUpDown: TUpDown;
    StatPage: TTabSheet;
    ConnectionList: TListView;
    TimeoutGroup: TGroupBox;
    Label7: TLabel;
    Timeout: TEdit;
    TimeoutUpDown: TUpDown;
    TimeoutDesc: TLabel;
    ActionList1: TActionList;
    ApplyAction: TAction;
    DisconnectAction: TAction;
    ShowHostAction: TAction;
    RemovePortAction: TAction;
    N3: TMenuItem;
    miExit: TMenuItem;
    UserStatus: TStatusBar;
    AllowXML: TAction;
    PortList: TListBox;
    Panel1: TPanel;
    ApplyButton: TButton;
    TabSheet1: TTabSheet;
    ImageList1: TImageList;
    actRegistryService: TAction;
    actRemoveSerivce: TAction;
    pmuLogFile: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    actClearLogFile: TAction;
    actOpenLogFile: TAction;
    actSaveLogFile: TAction;
    N6: TMenuItem;
    N7: TMenuItem;
    actLogFileSaveAs: TAction;
    actSetConfig: TAction;
    edtKeepAlive: TCheckBox;
    actRefreshComponment: TAction;
    mnuMgr: TMenuItem;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    ListView2: TListView;
    OpenDialog1: TOpenDialog;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    dbList: TListView;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    pmuDbConfig: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    actfrmAddDb: TAction;
    actfrmDeleteDb: TAction;
    actfrmDbConfig: TAction;
    N2: TMenuItem;
    Label14: TLabel;
    Label18: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
    procedure miPropertiesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miDisconnectClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure ApplyActionExecute(Sender: TObject);
    procedure ApplyActionUpdate(Sender: TObject);
    procedure DisconnectActionUpdate(Sender: TObject);
    procedure ShowHostActionExecute(Sender: TObject);
    procedure miAddClick(Sender: TObject);
    procedure RemovePortActionUpdate(Sender: TObject);
    procedure RemovePortActionExecute(Sender: TObject);
    procedure UpDownClick(Sender: TObject; Button: TUDBtnType);
    procedure PortListClick(Sender: TObject);
    procedure ConnectionListCompare(Sender: TObject; Item1,
      Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ConnectionListColumnClick(Sender: TObject;
      Column: TListColumn);
    procedure IntegerExit(Sender: TObject);
    procedure UpdateTimerTimer(Sender: TObject);
    procedure RegisteredActionExecute(Sender: TObject);
    procedure AllowXMLExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edtKeepAliveClick(Sender: TObject);
    procedure mnuMgrClick(Sender: TObject);
    procedure actfrmAddDbExecute(Sender: TObject);
    procedure actfrmDeleteDbExecute(Sender: TObject);
    procedure actfrmDbConfigExecute(Sender: TObject);
    procedure dbListDblClick(Sender: TObject);
  private
    FTaskMessage: DWord;
    FIconData: TNotifyIconData;
    FClosing: Boolean;
    FProgmanOpen: Boolean;
    FFromService: Boolean;
    NT351: Boolean;
    FCurItem: Integer;
    FSortCol: Integer;
    FSystemShutDown: boolean;

    procedure UpdateStatus;
    function GetItemIndex: Integer;
    procedure SetItemIndex(Value: Integer);
    procedure CheckValues;
    function GetSelectedSocket: Pointer;
    procedure SetSystemShutDown(const Value: boolean);
   protected
    procedure AddClient(Session : TZSession);
    procedure UpdateClient(Session : TZSession);
    procedure RemoveClient(Session : TZSession);
    procedure ClearModifications;
    procedure UIInitialize(var Message: TMessage); message UI_INITIALIZE;
    procedure WMMIDASIcon(var Message: TMessage); message WM_MIDASICON;
    procedure WMQUERYENDSESSION(var msg:Tmessage);Message  WM_QUERYENDSESSION;
    procedure WMLogFileUpdate(var msg:Tmessage);Message  WM_LOGFILE_UPDATE;
    procedure WMSessionUpdate(var msg:Tmessage);Message  WM_SESSION_UPDATE;
    procedure AddIcon;
    procedure ReadSettings;
    procedure WndProc(var Message: TMessage); override;
    procedure WriteSettings;

    procedure AddLogFile;

    procedure ApplicationException(Sender: TObject; E: Exception);

    //数据库连接管理
    procedure ReadDbList;
  public
    procedure Initialize(FromService: Boolean);
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property SelectedSocket: Pointer read GetSelectedSocket;
    property SystemShutDown:boolean read FSystemShutDown write SetSystemShutDown;
    destructor Destroy; override;
  end;

  TSocketService = class(TService)
  protected
    procedure Start(Sender: TService; var Started: Boolean);
    procedure Stop(Sender: TService; var Stopped: Boolean);
  public
    function GetServiceController: TServiceController; override;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
  end;

var
  SocketForm: TSocketForm;
  SocketService: TSocketService;

implementation

uses IniFiles,Registry,ScktCnst,ufrmDbSetup;

{$R *.dfm}

type
  TDllRegisterServer=function:HResult;
  TDllUnregisterServer=function:HResult;
{ TSocketForm }

procedure TSocketForm.FormCreate(Sender: TObject);
begin
  Application.OnException := ApplicationException;
  if not LoadWinSock2 then raise Exception.CreateRes(@SNoWinSock2);
  FClosing := False;
  FCurItem := -1;
  FSortCol := -1;
  SystemShutDown := false;
  MainFormHandle := Handle;
end;

procedure TSocketForm.WndProc(var Message: TMessage);
begin
  if Message.Msg = FTaskMessage then
  begin
    AddIcon;
    Refresh;
  end;
  inherited WndProc(Message);
end;

procedure TSocketForm.UpdateTimerTimer(Sender: TObject);
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
  if Pages.ActivePageIndex = 5 then
     begin
       Label2.Caption :=  '当前线程数:'+inttostr(WorkThreadCount);
       Label3.Caption :=  '运行线程数:'+inttostr(ExecThreadCount);
       Label10.Caption := '最大线程数:'+inttostr(MaxThreadCount);
       if (GetTickCount-StartServiceTickCount)>0 then
          Label11.Caption := '执行效率值:'+inttostr(round((DataBlockCount-WaitDataBlockCount) / (GetTickCount-StartServiceTickCount)*(1000*60)))+'/分'
       else
          Label11.Caption := '执行效率值:无';

       Label5.Caption := '缓冲连接数:'+inttostr(ConnCache.Count);
       Label6.Caption := '锁定连接数:'+inttostr(ConnCache.DBCacheLockCount);

       Label8.Caption :=  '等待指令数:'+inttostr(WaitDataBlockCount);
       Label16.Caption := '最大并发数:'+inttostr(MaxSyncRequestCount);
       Label13.Caption := '在线连接数:'+inttostr(Sessions.Count);
       Label12.Caption := '最大连接数:'+inttostr(Sessions.MaxSessionCount);
       Label17.Caption := '请求指令总数:'+inttostr(DataBlockCount);
       Label9.Caption :=  '指令等待延时:'+inttostr(DataBlockMaxWaitTime)+'微秒';
     end;
end;

procedure TSocketForm.CheckValues;
begin
  StrToInt(PortNo.Text);
  StrToInt(ThreadSize.Text);
  StrToInt(Timeout.Text);
end;

function TSocketForm.GetItemIndex: Integer;
begin
  Result := FCurItem;
end;

procedure TSocketForm.SetItemIndex(Value: Integer);
var
  Selected: Boolean;
begin
  if (FCurItem <> Value) then
  try
    if ApplyAction.Enabled then ApplyAction.Execute;
  except
    PortList.ItemIndex := FCurItem;
    raise;
  end else
    Exit;
  if Value = -1 then Value := 0;
  PortList.ItemIndex := Value;
  FCurItem := PortList.ItemIndex;
  Selected := FCurItem <> -1;
  if Selected then
    with TSocketDispatcher(PortList.Items.Objects[FCurItem]) do
    begin
      PortUpDown.Position := Port;
      ThreadUpDown.Position := ThreadCacheSize;
      TimeoutUpDown.Position := Timeout;
      Self.edtKeepAlive.Checked := KeepAlive;
      ClearModifications;
    end;
  PortNo.Enabled := Selected;
  ThreadSize.Enabled := Selected;
  Timeout.Enabled := Selected;
  edtKeepAlive.Enabled := Selected;
end;
procedure TSocketForm.UIInitialize(var Message: TMessage);
begin
  Initialize(Message.WParam <> 0);
end;

procedure TSocketForm.Initialize(FromService: Boolean);

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
  FFromService := FromService;
  NT351 := (Win32MajorVersion <= 3) and (Win32Platform = VER_PLATFORM_WIN32_NT);
  if NT351 then
  begin
    if not FromService then
      raise Exception.CreateRes(@SServiceOnly);
    BorderIcons := BorderIcons + [biMinimize];
    BorderStyle := bsSingle;
  end;
  ReadSettings;
  if FromService then
  begin
    miClose.Visible := False;
    miExit.Visible := False;
    N1.Visible := False;
    N3.Visible := False;
  end;
  mnuMgr.Visible := FromService;
  UpdateStatus;
  ReadDbList;
  AddIcon;
  if IE4Installed then
    FTaskMessage := RegisterWindowMessage('TaskbarCreated');
  UpdateTimer.Enabled := True;
end;

procedure TSocketForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  TimerEnabled: Boolean;
begin
  TimerEnabled := UpdateTimer.Enabled;
//  Timer1.Enabled := False;
  UpdateTimer.Enabled := False;
  try
    if not SystemShutDown and not Application.Terminated then
       begin
          CanClose := False;
          if ApplyAction.Enabled then ApplyAction.Execute;
          if FClosing and (not FFromService) and (ConnectionList.Items.Count > 0) then
          begin
            FClosing := False;
            if MessageDlg(SErrClose, mtConfirmation, [mbYes, mbNo], 0) <> idYes then
              Exit;
          end;
       end;
    WriteSettings;
    CanClose := True;
  finally
    if TimerEnabled and (not CanClose) then
       begin
         UpdateTimer.Enabled := True;
//         Timer1.Enabled := True;
       end;
  end;
end;

procedure TSocketForm.AddIcon;
begin
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

procedure TSocketForm.ReadSettings;
var
  F: TIniFile;

  procedure CreateItem(ID: Integer);
  var
    SH: TSocketDispatcher;
  begin
    SH := TSocketDispatcher.Create(nil);
    SH.ReadSettings(ID);
    PortList.Items.AddObject(IntToStr(SH.Port), SH);
    try
      SH.Open;
    except
      on E: Exception do
         raise Exception.CreateResFmt(@SOpenError, [SH.Port, E.Message]);
    end;
  end;

var
  Sections: TStringList;
  i: Integer;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'sckt.cfg');
  try
    Sections := TStringList.Create;
    try
      F.ReadSections(Sections);
      if Sections.Count > 1 then
      begin
        for i := 0 to Sections.Count - 1 do
          if CompareText(Sections[i], csSettings) <> 0 then
            begin
              try
                CreateItem(StrToInt(Sections[i]));
              except
                on E:Exception do
                   Application.MessageBox(pchar(E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
              end;
            end;
      end else
        CreateItem(-1);
      ItemIndex := 0;
    finally
      Sections.Free;
    end;
  finally
    F.Free;
  end;
end;

procedure TSocketForm.WriteSettings;
var
  i: Integer;
begin
  for i := 0 to PortList.Items.Count - 1 do
    TSocketDispatcher(PortList.Items.Objects[i]).WriteSettings;
end;

procedure TSocketForm.miCloseClick(Sender: TObject);
var stop:boolean;
begin
  FClosing := True;
  Application.Terminate;
end;

procedure TSocketForm.WMMIDASIcon(var Message: TMessage);
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
      if Visible then
        SetForegroundWindow(Handle) else
        miPropertiesClick(nil);
  end;
end;

procedure TSocketForm.miPropertiesClick(Sender: TObject);
begin
  ShowModal;
end;

procedure TSocketForm.FormShow(Sender: TObject);
begin
  Pages.ActivePage := Pages.Pages[0];
end;

procedure TSocketForm.UpdateStatus;
begin
//  UserStatus.SimpleText := Format('%d 当前连接数',[ConnectionList.Items.Count])+'  工作线程数:'+inttostr(ThreadCount)+'  执行中指令:'+inttostr(dictateCount)+'  断网请求:'+inttostr(MngThreadCount);
end;

procedure TSocketForm.AddClient(Session : TZSession);
var
  Item: TListItem;
begin
  Item := ConnectionList.Items.Add;
  try
    Item.Caption := Session.Port;
    Item.SubItems.Add(Session.IPAddress);
    Item.SubItems.Add(Session.UserName);
    Item.SubItems.Add(DateTimeToStr(now()));
    Item.Data := Pointer(Session);
  except
    Item.Free;
  end;
end;

procedure TSocketForm.RemoveClient(Session : TZSession);
var
  Item: TListItem;
begin
  Item := ConnectionList.FindData(0,Pointer(Session), True, False);
  if Assigned(Item) then Item.Free;
end;

procedure TSocketForm.miDisconnectClick(Sender: TObject);
var
  i: Integer;
begin
  if MessageBox(Handle,'是否断开当前选中连接？', Pchar(Application.Title), MB_YESNO+MB_ICONINFORMATION) <> 6 then
    Exit;
  try
  for i := 0 to ConnectionList.Items.Count - 1 do
    with ConnectionList.Items[i] do
      if Selected then
         TServerClientSocket(Data).Close;
  except
  end;
end;

procedure TSocketForm.miExitClick(Sender: TObject);
var stop:boolean;
begin
  FClosing := True;
  Application.Terminate;
end;

procedure TSocketForm.ApplyActionExecute(Sender: TObject);
begin
  with TSocketDispatcher(SelectedSocket) do
  begin
    if ActiveConnections > 0 then
      if MessageBox(Handle,'已经存在缴活连接，是否删除所有连接？', Pchar(Application.Title), MB_YESNO+MB_ICONQUESTION) <> 6 then
        Exit;
    Close;
    Port := StrToInt(PortNo.Text);
    PortList.Items[ItemIndex] := PortNo.Text;
    ThreadCacheSize := StrToInt(ThreadSize.Text);
    Timeout := StrToInt(Self.Timeout.Text);
    KeepAlive := Self.edtKeepAlive.Checked;
    Open;
  end;
  WriteSettings;
  ClearModifications;
end;

procedure TSocketForm.ApplyActionUpdate(Sender: TObject);
begin
  ApplyAction.Enabled := PortNo.Modified or ThreadSize.Modified or
    Timeout.Modified or (edtKeepAlive.Tag = 1);
end;

procedure TSocketForm.ClearModifications;
begin
  PortNo.Modified  := False;
  ThreadSize.Modified := False;
  Timeout.Modified := False;
  edtKeepAlive.Tag := 0;
end;

procedure TSocketForm.DisconnectActionUpdate(Sender: TObject);
begin
  DisconnectAction.Enabled := ConnectionList.SelCount > 0;
end;

procedure TSocketForm.ShowHostActionExecute(Sender: TObject);
var
  i: Integer;
  Item: TListItem;
begin
  ShowHostAction.Checked := not ShowHostAction.Checked;
  ConnectionList.Items.BeginUpdate;
  try
    for i := 0 to ConnectionList.Items.Count - 1 do
    begin
      Item := ConnectionList.Items[i];
      if ShowHostAction.Checked then
      begin
        Item.SubItems[1] := TServerClientThread(Item.Data).ClientSocket.RemoteHost;
        if Item.SubItems[1] = '' then Item.SubItems[1] := SHostUnknown;
      end else
        Item.SubItems[1] := SNotShown;
    end;
  finally
    ConnectionList.Items.EndUpdate;
  end;
end;

procedure TSocketForm.miAddClick(Sender: TObject);
var
  SD: TSocketDispatcher;
  Idx: Integer;
begin
  CheckValues;
  SD := TSocketDispatcher.Create(nil);
  SD.Port := PortUpDown.Position + 1;
  PortUpDown.Position := SD.Port;
  Idx := PortList.Items.AddObject(PortNo.Text,SD);
  PortNo.Modified := True;
  ItemIndex := Idx;
  Pages.ActivePage := Pages.Pages[0];
  PortNo.SetFocus;
  ApplyButton.Enabled := true;
end;

procedure TSocketForm.RemovePortActionUpdate(Sender: TObject);
begin
  RemovePortAction.Enabled := (PortList.Items.Count > 1) and (ItemIndex <> -1);
end;

procedure TSocketForm.RemovePortActionExecute(Sender: TObject);
begin
  CheckValues;
  PortList.Items.Objects[ItemIndex].Free;
  PortList.Items.Delete(ItemIndex);
  FCurItem := -1;
  ItemIndex := 0;
end;

procedure TSocketForm.UpDownClick(Sender: TObject; Button: TUDBtnType);
begin
  ((Sender as TUpDown).Associate as TEdit).Modified := True;
end;

procedure TSocketForm.PortListClick(Sender: TObject);
begin
  ItemIndex := PortList.ItemIndex;
end;

procedure TSocketForm.ConnectionListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if Data = -1 then
    Compare := AnsiCompareText(Item1.Caption, Item2.Caption) else
    Compare := AnsiCompareText(Item1.SubItems[Data], Item2.SubItems[Data]);
end;

procedure TSocketForm.ConnectionListColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  FSortCol := Column.Index - 1;
  ConnectionList.CustomSort(nil, FSortCol);
end;

procedure TSocketForm.IntegerExit(Sender: TObject);
begin
  try
    StrToInt(PortNo.Text);
  except
    ActiveControl := PortNo;
    raise;
  end;
end;

procedure TSocketForm.RegisteredActionExecute(Sender: TObject);
begin
  ShowMessage(SNotUntilRestart);
end;

procedure TSocketForm.AllowXMLExecute(Sender: TObject);
begin
  AllowXML.Checked := not AllowXML.Checked;
end;


procedure TSocketForm.AddLogFile;
var
  s:string;
  Item:TListItem;
begin
  s := LogFile.ReadLogFile;
  if s<>'' then
     Memo1.Lines.Add(s); 
end;

procedure TSocketForm.Timer1Timer(Sender: TObject);
begin
  if SystemShutDown then Exit;
  if FormatDatetime('HH:NN',now())='23:00' then
     begin
     end;
end;

function TSocketForm.GetSelectedSocket: Pointer;
begin
  Result := PortList.Items.Objects[ItemIndex];
end;

procedure TSocketForm.ApplicationException(Sender: TObject; E: Exception);
begin
  LogFile.AddLogFile(0,E.Message,'Application','Exception');
end;

procedure TSocketForm.SetSystemShutDown(const Value: boolean);
begin
  FSystemShutDown := Value;
end;

destructor TSocketForm.Destroy;
var
  i: Integer;
begin
  Application.OnException := nil;
  UpdateTimer.Enabled := False;
  if not NT351 then
    Shell_NotifyIcon(NIM_DELETE, @FIconData);

  for i := 0 to PortList.Items.Count - 1 do
    PortList.Items.Objects[i].Free;

  inherited;
end;

procedure TSocketForm.WMQUERYENDSESSION(var msg: Tmessage);
begin
  SystemShutdown := true;
  inherited;
end;

procedure TSocketForm.edtKeepAliveClick(Sender: TObject);
begin
  edtKeepAlive.Tag := 1;
end;

procedure TSocketForm.mnuMgrClick(Sender: TObject);
begin
  ShellExecute(handle,'open',pchar(ExtractFilePath(ParamStr(0))+'SvcMgr.exe'),nil,nil,0);
end;
procedure TSocketForm.WMLogFileUpdate(var msg: Tmessage);
begin
  AddLogFile;
end;

procedure TSocketForm.UpdateClient(Session: TZSession);
var
  Item: TListItem;
begin
  Item := ConnectionList.FindData(0,Pointer(Session), True, False);
  if Item=nil then Exit;
  Item.Caption := Session.Port;
  Item.SubItems[0] := Session.IPAddress;
  Item.SubItems[1] := Session.UserName;
  Item.SubItems[2] := DateTimeToStr(now());
end;

procedure TSocketForm.WMSessionUpdate(var msg: Tmessage);
var
  Session:TZSession;
begin
  Session := TZSession(msg.WParam);
  case msg.LParam of
  0:AddClient(Session);
  1:RemoveClient(Session);
  2:ConnectionList.Clear;
  3:UpdateClient(Session);
  end;
end;

procedure TSocketForm.ReadDbList;
var
  F:TIniFile;
  db:TStringList;
  i:integer;
  item:TListItem;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  db := TStringList.Create;
  try
    F.ReadSections(db);
    dbList.Clear;
    for i:=0 to db.Count -1 do
      begin
        if (length(db[i])>2) and (copy(db[i],1,2)='db') then
           begin
             if StrtoInt(copy(db[i],3,20))>0 then
             begin
             Item := dbList.Items.Add;
             Item.Caption := copy(db[i],3,20);
             Item.SubItems.Add(F.ReadString(db[i],'hostname','')+'  <数据库名:'+F.ReadString(db[i],'databasename','')+'>'); 
             Item.SubItems.Add('数据库类型:'+F.ReadString(db[i],'provider',''));
             end;
           end;
      end;
  finally
    db.Free;
    F.Free;
  end;
end;

{ TSocketService }

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  SocketService.Controller(CtrlCode);
end;

function TSocketService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

constructor TSocketService.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  AllowPause := False;
  Interactive := True;
  DisplayName := 'RSP Socket Service';
  Name := 'RSPScktSrvr';
  OnStart := Start;
  OnStop := Stop;
end;

procedure TSocketService.Start(Sender: TService; var Started: Boolean);
begin
  PostMessage(SocketForm.Handle, UI_INITIALIZE, 1, 0);
  Started := True;
end;

procedure TSocketService.Stop(Sender: TService; var Stopped: Boolean);
begin
  PostMessage(SocketForm.Handle, WM_QUIT, 0, 0);
  Stopped := True;
end;


procedure TSocketForm.actfrmAddDbExecute(Sender: TObject);
begin
  TfrmDbSetup.EditDialog(self,0);
  ReadDbList;
end;

procedure TSocketForm.actfrmDeleteDbExecute(Sender: TObject);
begin
  if dbList.Selected = nil then Raise Exception.Create('请选择要删除的连接..'); 
  TfrmDbSetup.DeleteFun(StrtoInt(dbList.Selected.Caption));
  dbList.Selected.Delete;
end;

procedure TSocketForm.actfrmDbConfigExecute(Sender: TObject);
begin
  if dbList.Selected = nil then Exit;
  TfrmDbSetup.EditDialog(self,StrtoInt(dbList.Selected.Caption));

end;

procedure TSocketForm.dbListDblClick(Sender: TObject);
begin
  actfrmDbConfigExecute(nil);
end;

initialization
finalization
end.
