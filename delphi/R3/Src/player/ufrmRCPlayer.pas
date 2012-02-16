unit ufrmRCPlayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack, DirectShow9, StdCtrls, ActiveX, DSUtil, Menus,
  ExtCtrls, ComCtrls, Buttons, ImgList, RzTray, RzStatus, RzPanel,ufrmRcMonitor;

const
  WM_PLAYLIST_REFRESH=WM_USER+3948;
  WM_PLAY_DESKTOP=WM_USER+3949;
  WM_TPOS_DISPLAY=WM_USER+3950;
  UI_INITIALIZE   = WM_USER + 3951;
  WM_GET_PLAYLIST=WM_USER+3952;

const
  MM_PLAYER = '{D51AB2C4-FFEE-414B-890B-30071D941E97}';
  
type
  TfrmRCPlayer = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ImageList1: TImageList;
    SpeedButton5: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Fullscreen1: TMenuItem;
    Panel3: TPanel;
    SoundLevel: TTrackBar;
    Label3: TLabel;
    ImageList2: TImageList;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Exit2: TMenuItem;
    ComboBox1: TComboBox;
    DSTrackBar1: TDSTrackBar;
    Label2: TLabel;
    Bevel1: TBevel;
    N5: TMenuItem;
    RzTrayIcon1: TRzTrayIcon;
    Bkg: TPanel;
    Memo1: TMemo;
    open1: TMenuItem;
    N3: TMenuItem;
    SpeedButton4: TSpeedButton;
    procedure Exit1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DSTrackBar1Timer(sender: TObject; CurrentPos,
      StopPos: Cardinal);
    procedure SoundLevelChange(Sender: TObject);
    procedure PlayFile(Filename : String);
    procedure Clear1Click(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Fullscreen1Click(Sender: TObject);
    procedure open1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
    procedure WMPlayList(var Message: TMessage); message WM_PLAYLIST_REFRESH;
    procedure WMGetPlayList(var Message: TMessage); message WM_GET_PLAYLIST;
    procedure WMPlayDesktop(var Message: TMessage); message WM_PLAY_DESKTOP;
    procedure WMTPosDisplay(var Message: TMessage); message WM_TPOS_DISPLAY;
    function  GetFilterGraph1: TFilterGraph;
  public
    { Public declarations }
    OsdChanged : Boolean;
    Shut:boolean;
    frmRcMonitor:TfrmRcMonitor;
    procedure ReadMMPlayer;
    procedure WriteMMPlayer;
    procedure StartPlay;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property FilterGraph1:TFilterGraph read getFilterGraph1;
  end;

var
  frmRCPlayer: TfrmRCPlayer;
  hExists:boolean;
implementation

uses IniFiles;

{$R *.dfm}
var
  MutHandle:THandle;

procedure TfrmRCPlayer.Exit1Click(Sender: TObject);
begin
  FilterGraph1.ClearGraph;
end;

procedure TfrmRCPlayer.SpeedButton1Click(Sender: TObject);
begin
  if not FilterGraph1.Active then
    Open1Click(nil)
  else
    FilterGraph1.play;
end;

procedure TfrmRCPlayer.SpeedButton2Click(Sender: TObject);
begin
  FilterGraph1.Pause;
end;

procedure TfrmRCPlayer.SpeedButton3Click(Sender: TObject);
begin
  FilterGraph1.Stop;
end;

procedure TfrmRCPlayer.FormCreate(Sender: TObject);
var
  i : Integer;
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'\mmPlayer.ini');
  try
    F.WriteInteger('config','Handle',Handle);
  finally
    F.Free;
  end;

  Shut := false;
  Imagelist1.GetBitmap(3, SpeedButton1.Glyph);
  Imagelist1.GetBitmap(2, SpeedButton2.Glyph);
  Imagelist1.GetBitmap(4, SpeedButton3.Glyph);
  Imagelist1.GetBitmap(8, SpeedButton4.Glyph);
//  Imagelist1.GetBitmap(8, SpeedButton13.Glyph);
  Imagelist1.GetBitmap(0, SpeedButton6.Glyph);
  Imagelist1.GetBitmap(6, SpeedButton7.Glyph);

  Combobox1.Items.Add('默认');
  If Screen.MonitorCount > 1 then
  Begin
    for I := 0 to Screen.MonitorCount - 1 do
      Combobox1.Items.Add('显示屏-'+inttostr(I));
    Combobox1.Enabled := True;
  End;
  Combobox1.ItemIndex := 0;
  ReadMMPlayer;
  left := -9000;
end;

procedure TfrmRCPlayer.DSTrackBar1Timer(sender: TObject; CurrentPos,
  StopPos: Cardinal);
var
  CurrPos : Int64;
  Value, H, M, S : Integer;
  MediaSeeking: IMediaSeeking;
begin
  FilterGraph1.QueryInterface(IMediaSeeking, MediaSeeking);
  with MediaSeeking do
  Begin
    GetCurrentPosition(CurrPos);
    Value := Trunc(CurrPos / 10000000);
    H := value div 3600;
    M := (value mod 3600) div 60;
    S := (value mod 3600) mod 60;
//    Panel2.Caption := Format('%d:%2.2d:%2.2d', [H, M, S]);
  End;
  If OsdChanged then
  Begin
    //DSVideoWindowEx.ClearBack;
    OsdChanged := False;
  End;
end;

procedure TfrmRCPlayer.SoundLevelChange(Sender: TObject);
begin
  FilterGraph1.Volume := SoundLevel.Position;
  OsdChanged := True;
end;

procedure TfrmRCPlayer.PlayFile(Filename : String);
begin
  FilterGraph1.ClearGraph;

  // --------------------------------------------------------------------------------------
  // This is a workaround the problem that we don't always get the EC_CLOCK_CHANGED.
  // and because we didn't get the EC_CLOCK_CHANGED the DSTrackbar and DSVideoWindowEx
  // didn't got reassigned and that returned in misfuntions.
  FilterGraph1.Active := False;
  FilterGraph1.Active := True;
  // --------------------------------------------------------------------------------------

  FilterGraph1.RenderFile(FileName);
  SoundLevel.Position := FilterGraph1.Volume;
  FilterGraph1.Play;
end;

procedure TfrmRCPlayer.Clear1Click(Sender: TObject);
begin
  FilterGraph1.Stop;
  FilterGraph1.ClearGraph;
  FilterGraph1.Active := False;
end;

procedure TfrmRCPlayer.Exit2Click(Sender: TObject);
begin
  Shut := true;
  Application.MainForm.Close;
end;

procedure TfrmRCPlayer.ReadMMPlayer;
var
  F:TIniFile;
  w:integer;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'\mmPlayer.ini');
  try
    w := F.ReadInteger('config','Monitor',9);
    if w<ComboBox1.Items.Count then
       begin
         ComboBox1.ItemIndex := w;
       end
    else
       begin
         ComboBox1.ItemIndex := ComboBox1.Items.Count-1;
       end;
  finally
    F.Free;
  end;
end;

procedure TfrmRCPlayer.WriteMMPlayer;
var
  F:TIniFile;
  w:integer;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'\mmPlayer.ini');
  try
    if ComboBox1.Enabled then F.WriteInteger('config','Monitor',ComboBox1.ItemIndex);
  finally
    F.Free;
  end;
end;

procedure TfrmRCPlayer.FormDestroy(Sender: TObject);
begin
  WriteMMPlayer;
end;

procedure TfrmRCPlayer.WMPlayDesktop(var Message: TMessage);
begin
  if Combobox1.ItemIndex > 0 then
     frmRcMonitor.StartFullScreen(FilterGraph1,Screen.Monitors[Combobox1.Itemindex -1])
  else
     frmRcMonitor.StartFullScreen(FilterGraph1);
  Close;
end;

procedure TfrmRCPlayer.WMTPosDisplay(var Message: TMessage);
var
  Str: string;
  vLow,vHigh,Iparm,vCount,i: integer;
  pos:TLabel;
begin
{
  //消息的参数: 高字节位
  case Message.WParamHi of
  1:begin
      pos := pos01;
      pos02.Visible := false;
      pos03.Visible := false;
      pos04.Visible := false;
    end;
  2:begin
      pos := pos02;
      pos03.Visible := false;
      pos04.Visible := false;
    end;
  3:begin
      pos := pos03;
      pos04.Visible := false;
    end;
  4:pos := pos04;
  end;
  if pos<>nil then
  begin
    pos.Visible := true;

    //消息的参数: 低字节位
    case Message.WParamLo of
     0:begin
        pos.Caption := '结算:'+formatFloat('#.00',Message.LParam/100);
       end;
     1:begin
        pos.Caption := '找零:'+formatFloat('#.00',Message.LParam/100);
       end;
     else
       begin
         case Message.WParamLo of
          ord('A'):pos.Caption := '现金:'+formatFloat('#.00',Message.LParam/100);
          ord('B'):pos.Caption := '刷卡:'+formatFloat('#.00',Message.LParam/100);
          ord('C'):pos.Caption := '储值卡:'+formatFloat('#.00',Message.LParam/100);
          ord('D'):pos.Caption := '记账:'+formatFloat('#.00',Message.LParam/100);
          ord('E'):pos.Caption := '转账:'+formatFloat('#.00',Message.LParam/100);
          ord('F'):pos.Caption := '支票:'+formatFloat('#.00',Message.LParam/100);
          ord('G'):pos.Caption := '礼券:'+formatFloat('#.00',Message.LParam/100);
          ord('H'):pos.Caption := '结账:'+formatFloat('#.00',Message.LParam/100);
          ord('I'):pos.Caption := '结账:'+formatFloat('#.00',Message.LParam/100);
          ord('J'):pos.Caption := '结账:'+formatFloat('#.00',Message.LParam/100);
         end;
       end;
    end;
    pos.Update;
  end;
  //控制显示位置：
  vCount:=0;
  if pos01.Visible then Inc(vCount);
  if pos02.Visible then Inc(vCount);
  if pos03.Visible then Inc(vCount);
  if pos04.Visible then Inc(vCount);
  case vCount of
   1: RzPanel1.Height:=49;
   2: RzPanel1.Height:=97;
   3: RzPanel1.Height:=145;
   4: RzPanel1.Height:=193;
  end;
  vCount:=8;
  if pos01.Visible then
  begin
    pos01.Top:=vCount;
    vCount:=vCount+45;
  end;
  if pos02.Visible then
  begin
    pos02.Top:=vCount;
    vCount:=vCount+45;
  end;
  if pos03.Visible then
  begin
    pos04.Top:=vCount;
    vCount:=vCount+45;
  end;
  if pos04.Visible then pos04.Top:=vCount;
  RzPanel1.Visible := true;
  RzPanel1.Update;

  }
//  Timer1.Enabled := true;


end;

procedure TfrmRCPlayer.WMGetPlayList(var Message: TMessage);
begin
end;

constructor TfrmRCPlayer.Create(AOwner: TComponent);
begin
  inherited;
  frmRcMonitor := TfrmRcMonitor.Create(nil);
  DSTrackBar1.FilterGraph := FilterGraph1;
end;

destructor TfrmRCPlayer.Destroy;
begin
  frmRcMonitor.Free;
  inherited;
end;

procedure TfrmRCPlayer.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not Shut then
    begin
      CanClose := false;
      Hide;
      ShowWindow( Application.Handle, sw_Hide );
    end;
end;

procedure TfrmRCPlayer.Fullscreen1Click(Sender: TObject);
begin
  if WindowState= wsMinimized then
     WindowState := wsNormal;
  Show;
  Position := poScreenCenter;
  ShowWindow(Application.Handle, sw_Hide );
end;

procedure TfrmRCPlayer.open1Click(Sender: TObject);
begin
  If OpenDialog1.Execute then
  Begin
    PlayFile(OpenDialog1.FileName);
  end;
end;

function TfrmRCPlayer.GetFilterGraph1: TFilterGraph;
begin
  result := frmRcMonitor.FilterGraph1; 
end;

procedure TfrmRCPlayer.StartPlay;
begin
  if Combobox1.ItemIndex > 0 then
     frmRcMonitor.StartFullScreen(FilterGraph1,Screen.Monitors[Combobox1.Itemindex -1])
  else
     frmRcMonitor.StartFullScreen(FilterGraph1);
  frmRcMonitor.Play;
end;

procedure TfrmRCPlayer.WMPlayList(var Message: TMessage);
begin
  StartPlay;
end;

procedure TfrmRCPlayer.SpeedButton4Click(Sender: TObject);
begin
  frmRcMonitor.Show;
end;

initialization
  //打开互斥对象
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, MM_PLAYER);
  if MutHandle = 0 then
  begin
    //建立互斥对象
    MutHandle := CreateMutex(nil, False, MM_PLAYER);
    hExists := false;
  end
  else
    hExists := true;
finalization
  if MutHandle<>0 then  CloseHandle(MutHandle);
end.
