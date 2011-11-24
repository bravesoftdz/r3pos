unit ufrmMMPlayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack, DirectShow9, StdCtrls, ActiveX, DSUtil, Menus,
  ExtCtrls, ComCtrls, Buttons, ImgList, RzTray, RzStatus, RzPanel;

const
  WM_PLAYLIST_REFRESH=WM_USER+3948;
  WM_PLAY_DESKTOP=WM_USER+3949;
  WM_TPOS_DISPLAY=WM_USER+3950;

type
  pPlayListItem = ^TPlayListItem;
  TPlayListItem = Record
    Filename : String;
    Path : String;
  End;

  TfrmMMPlayer = class(TForm)
    FilterGraph1: TFilterGraph;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Exit1: TMenuItem;
    Panel1: TPanel;
    TrackBar1: TTrackBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ImageList1: TImageList;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    Play1: TMenuItem;
    Pause1: TMenuItem;
    Stop1: TMenuItem;
    N1: TMenuItem;
    Fullscreen1: TMenuItem;
    Panel3: TPanel;
    ColorControl1: TMenuItem;
    N2: TMenuItem;
    SoundLevel: TTrackBar;
    Label3: TLabel;
    ImageList2: TImageList;
    Splitter1: TSplitter;
    PopupMenu2: TPopupMenu;
    Add1: TMenuItem;
    Clear1: TMenuItem;
    View1: TMenuItem;
    AspectRatio1: TMenuItem;
    Stretched1: TMenuItem;
    LetterBox1: TMenuItem;
    Crop1: TMenuItem;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Panel4: TPanel;
    ListBox1: TListBox;
    SpeedButton13: TSpeedButton;
    N3: TMenuItem;
    Exit2: TMenuItem;
    ComboBox1: TComboBox;
    DSTrackBar1: TDSTrackBar;
    Label2: TLabel;
    Bevel1: TBevel;
    RzTrayIcon1: TRzTrayIcon;
    DSVideoWindowEx1: TDSVideoWindowEx2;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Panel2: TPanel;
    RzMarqueeStatus1: TRzMarqueeStatus;
    RzPanel1: TRzPanel;
    pos01: TLabel;
    pos02: TLabel;
    pos03: TLabel;
    pos04: TLabel;
    procedure Open1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DSVideoWindowEx1ColorKeyChanged(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure DSTrackBar1Timer(sender: TObject; CurrentPos,
      StopPos: Cardinal);
    procedure SoundLevelChange(Sender: TObject);
    procedure CheckColorControlSupport;
    procedure PopupMenu2Popup(Sender: TObject);
    procedure Add1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure PlayFile(Filename : String);
    procedure FilterGraph1GraphComplete(sender: TObject; Result: HRESULT;
      Renderer: IBaseFilter);
    procedure Stretched1Click(Sender: TObject);
    procedure LetterBox1Click(Sender: TObject);
    procedure Crop1Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure DSVideoWindowEx1OverlayVisible(Sender: TObject;
      Visible: Boolean);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure DSVideoWindowEx1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzTrayIcon1RestoreApp(Sender: TObject);
  private
    { Private declarations }
    procedure WMPlayList(var Message: TMessage); message WM_PLAYLIST_REFRESH;
    procedure WMPlayDesktop(var Message: TMessage); message WM_PLAY_DESKTOP;
    procedure WMTPosDisplay(var Message: TMessage); message WM_TPOS_DISPLAY;
  public
    { Public declarations }
    OsdChanged : Boolean;
    PlayListItem : pPlayListItem;
    PlayingIndex : Integer;
    procedure ReadMMPlayer;
    procedure WriteMMPlayer;
    procedure ClearPlayList;
    procedure LoadPlayList;
  end;

var
  frmMMPlayer: TfrmMMPlayer;

implementation

uses IniFiles,ufrmMMUrlDown,ufrmColorCtrl;

{$R *.dfm}

procedure TfrmMMPlayer.Open1Click(Sender: TObject);
var
  i : Integer;
begin
  // The Add file to playerlist was selected.
  If OpenDialog1.Execute then
  Begin
    ClearPlayList;
    with OpenDialog1.Files do
      // Now go thru every files selected in the opendialog and add
      // them one by one to the Players playlist.
      // The first file added to the players playlist will loaded
      // automaticly
      for I := Count - 1 downto 0 do
      begin
        New(PlayListItem);
        PlayListItem^.Filename := ExtractFilename(Strings[I]);
        PlayListItem^.Path := ExtractFilePath(Strings[I]);
        ListBox1.Items.AddObject(PlayListItem^.Filename, TObject(PlayListItem));
      end;
    Listbox1.ItemIndex := 0;
    PlayFile(OpenDialog1.Files.Strings[0]);
    PlayingIndex := 0;
  end;
  if PlayingIndex < Listbox1.Items.Count -1 then
    SpeedButton7.Enabled := True;
end;

procedure TfrmMMPlayer.Exit1Click(Sender: TObject);
begin
  FilterGraph1.ClearGraph;
{  FilterGraph1.Active := false;
  Application.Terminate;}
end;

procedure TfrmMMPlayer.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Exit1Click(nil)
end;

procedure TfrmMMPlayer.DSVideoWindowEx1ColorKeyChanged(Sender: TObject);
begin
  If DSVideoWindowEx1.OverlayVisible then
  Begin
    RzMarqueeStatus1.Color := DSVideoWindowEx1.ColorKey;
    ImageList2.BkColor := DSVideoWindowEx1.ColorKey;
  end
  else
  Begin
    RzMarqueeStatus1.Color := DSVideoWindowEx1.Color;
    ImageList2.BkColor := DSVideoWindowEx1.Color;
  end;
end;

procedure TfrmMMPlayer.TrackBar1Change(Sender: TObject);
begin
  DSVideoWindowEx1.DigitalZoom := TrackBar1.Position;
end;

procedure TfrmMMPlayer.SpeedButton1Click(Sender: TObject);
begin
  if not FilterGraph1.Active then
    Open1Click(nil)
  else
    FilterGraph1.play;
  CheckColorControlSupport;
end;

procedure TfrmMMPlayer.SpeedButton2Click(Sender: TObject);
begin
  FilterGraph1.Pause;
end;

procedure TfrmMMPlayer.SpeedButton3Click(Sender: TObject);
begin
  FilterGraph1.Stop;
end;

procedure TfrmMMPlayer.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  Imagelist1.GetBitmap(3, SpeedButton1.Glyph);
  Imagelist1.GetBitmap(2, SpeedButton2.Glyph);
  Imagelist1.GetBitmap(4, SpeedButton3.Glyph);
  Imagelist1.GetBitmap(9, SpeedButton4.Glyph);
  Imagelist1.GetBitmap(8, SpeedButton13.Glyph);
  Imagelist1.GetBitmap(0, SpeedButton6.Glyph);
  Imagelist1.GetBitmap(6, SpeedButton7.Glyph);

  Case DSVideoWindowEx1.AspectRatio of
    rmStretched : Stretched1.Checked := True;
    rmLetterBox : LetterBox1.Checked := True;
    rmCrop      : Crop1.Checked := True;
  End;

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

procedure TfrmMMPlayer.SpeedButton4Click(Sender: TObject);
begin
  If DSVideoWindowEx1.FullScreen then
    DSVideoWindowEx1.NormalPlayback
  else
    If Combobox1.ItemIndex > 0 then
      DSVideoWindowEx1.StartFullScreen(Screen.Monitors[Combobox1.Itemindex -1])
    else
      DSVideoWindowEx1.StartFullScreen;
  SpeedButton4.Down := DSVideoWindowEx1.FullScreen;
end;

procedure TfrmMMPlayer.SpeedButton5Click(Sender: TObject);
begin
  ColorControlForm.Show;
end;

procedure TfrmMMPlayer.DSTrackBar1Timer(sender: TObject; CurrentPos,
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
    Panel2.Caption := Format('%d:%2.2d:%2.2d', [H, M, S]);
  End;
  If OsdChanged then
  Begin
    DSVideoWindowEx1.ClearBack;
    OsdChanged := False;
  End;
end;

procedure TfrmMMPlayer.SoundLevelChange(Sender: TObject);
var
  Tmp : TBitmap;
begin
  Tmp := TBitmap.Create;
  Imagelist2.GetBitmap(0, Tmp);
  FilterGraph1.Volume := SoundLevel.Position;
  DSVideoWindowEx1.Canvas.CopyRect(Rect(10, DSVideoWindowEx1.Height - 65, 218, DSVideoWindowEx1.Height - 27), Tmp.Canvas, Rect(0, 0, 104, 23));
  Imagelist2.GetBitmap(1, Tmp);
  DSVideoWindowEx1.Canvas.CopyRect(Rect(10, DSVideoWindowEx1.Height - 65, 10 + Trunc((104 / 10000) * SoundLevel.Position) * 2, DSVideoWindowEx1.Height - 27), Tmp.Canvas, Rect(0,0,Trunc((104 / 10000) * SoundLevel.Position), 23));
  Tmp.Free;
  OsdChanged := True;
end;

procedure TfrmMMPlayer.CheckColorControlSupport;
Begin
  SpeedButton5.Enabled := True;
  ColorControl1.Enabled := True;
End;

procedure TfrmMMPlayer.PopupMenu2Popup(Sender: TObject);
begin
  If Listbox1.Items.Count > 0 then
    Clear1.Enabled := True
  else
    Clear1.Enabled := False;
end;

procedure TfrmMMPlayer.Add1Click(Sender: TObject);
var
  i : Integer;
begin
  If ListBox1.Items.Count < 1 then
  Begin
    Open1Click(nil);
    SpeedButton6.Enabled := False;
    SpeedButton7.Enabled := False;
    Exit;
  End;
  if OpenDialog1.Execute then
  begin
    with OpenDialog1.Files do
      // Now go thru every files selected in the opendialog and add
      // them one by one to the Players playlist.
      // The first file added to the players playlist will loaded
      // automaticly
      for I := Count - 1 downto 0 do
      begin
        New(PlayListItem);
        PlayListItem^.Filename := ExtractFilename(Strings[I]);
        PlayListItem^.Path := ExtractFilePath(Strings[I]);
        ListBox1.Items.AddObject(PlayListItem^.Filename, TObject(PlayListItem));
      end;
  End;
  If PlayingIndex > 0 then
    SpeedButton6.Enabled := True;
  if PlayingIndex < Listbox1.Items.Count -1 then
    SpeedButton7.Enabled := True;
end;

procedure TfrmMMPlayer.ListBox1DblClick(Sender: TObject);
var
  Filename : String;
begin
  If ListBox1.ItemIndex = PlayingIndex then Exit;
  PlayListItem := pPlayListitem(Listbox1.Items.Objects[ListBox1.Itemindex]);
  Filename := PlayListItem^.Path;
  If Filename[Length(Filename)] <> '\' then
    Filename := Filename + '\';
  Filename := Filename + PlayListItem^.Filename;
  PlayFile(Filename);
  PlayingIndex := Listbox1.Itemindex;
  If PlayingIndex > 0 then
    SpeedButton6.Enabled := True
  else
    SpeedButton6.Enabled := False;
  if PlayingIndex < Listbox1.Items.Count -1 then
    SpeedButton7.Enabled := True
  else
    SpeedButton7.Enabled := False;
end;

procedure TfrmMMPlayer.PlayFile(Filename : String);
begin
  FilterGraph1.ClearGraph;

  // --------------------------------------------------------------------------------------
  // This is a workaround the problem that we don't always get the EC_CLOCK_CHANGED.
  // and because we didn't get the EC_CLOCK_CHANGED the DSTrackbar and DSVideoWindowEx1
  // didn't got reassigned and that returned in misfuntions.
  FilterGraph1.Active := False;
  FilterGraph1.Active := True;
  // --------------------------------------------------------------------------------------

  FilterGraph1.RenderFile(FileName);
  SoundLevel.Position := FilterGraph1.Volume;
  FilterGraph1.Play;
  CheckColorControlSupport;
end;

procedure TfrmMMPlayer.FilterGraph1GraphComplete(sender: TObject;
  Result: HRESULT; Renderer: IBaseFilter);
Var
  Filename : String;
begin
  if Playingindex>=(Listbox1.Items.Count -1) then
     begin
       Playingindex := -1;
       ListBox1.ItemIndex := -1;
     end;
  If Playingindex < Listbox1.Items.Count -1 then
  Begin
    Listbox1.ItemIndex := ListBox1.ItemIndex +1;
    PlayListItem := pPlayListItem(Listbox1.Items.Objects[Listbox1.ItemIndex]);
    Filename := PlayListItem^.Path;
    If Filename[Length(Filename)] <> '\' then
      Filename := Filename + '\';
    Filename := Filename + PlayListItem^.Filename;
    PlayFile(Filename);
    PlayingIndex := Listbox1.Itemindex;
  End;
  If PlayingIndex > 0 then
    SpeedButton6.Enabled := True
  else
    SpeedButton6.Enabled := False;
  if PlayingIndex < Listbox1.Items.Count -1 then
    SpeedButton7.Enabled := True
  else
    SpeedButton7.Enabled := False;
end;

procedure TfrmMMPlayer.Stretched1Click(Sender: TObject);
begin
  DSVideoWindowEx1.AspectRatio := rmStretched;
end;

procedure TfrmMMPlayer.LetterBox1Click(Sender: TObject);
begin
  DSVideoWindowEx1.AspectRatio := rmLetterBox;
end;

procedure TfrmMMPlayer.Crop1Click(Sender: TObject);
begin
  DSVideoWindowEx1.AspectRatio := rmCrop;
end;

procedure TfrmMMPlayer.SpeedButton13Click(Sender: TObject);
begin
  If Not DSVideoWindowEx1.DesktopPlayback then
  Begin
    If Combobox1.ItemIndex > 0 then
      DSVideoWindowEx1.StartDesktopPlayback(Screen.Monitors[Combobox1.Itemindex -1])
    else
      DSVideoWindowEx1.StartDesktopPlayback;
    Application.Minimize;
  End
  else
    DSVideoWindowEx1.NormalPlayback;
end;

procedure TfrmMMPlayer.PopupMenu1Popup(Sender: TObject);
begin
  FullScreen1.Checked := DSVideoWindowEx1.FullScreen;
end;

procedure TfrmMMPlayer.SpeedButton7Click(Sender: TObject);
Var
  Filename : String;
begin
  If Playingindex < Listbox1.Items.Count -1 then
  Begin
    Listbox1.ItemIndex := ListBox1.ItemIndex +1;
    PlayListItem := pPlayListItem(Listbox1.Items.Objects[Listbox1.ItemIndex]);
    Filename := PlayListItem^.Path;
    If Filename[Length(Filename)] <> '\' then
      Filename := Filename + '\';
    Filename := Filename + PlayListItem^.Filename;
    PlayFile(Filename);
    PlayingIndex := Listbox1.Itemindex;
  End;
  If PlayingIndex > 0 then
    SpeedButton6.Enabled := True
  else
    SpeedButton6.Enabled := False;
  if PlayingIndex < Listbox1.Items.Count -1 then
    SpeedButton7.Enabled := True
  else
    SpeedButton7.Enabled := False;
end;

procedure TfrmMMPlayer.SpeedButton6Click(Sender: TObject);
Var
  Filename : String;
begin
  If Playingindex > 0 then
  Begin
    Listbox1.ItemIndex := ListBox1.ItemIndex -1;
    PlayListItem := pPlayListItem(Listbox1.Items.Objects[Listbox1.ItemIndex]);
    Filename := PlayListItem^.Path;
    If Filename[Length(Filename)] <> '\' then
      Filename := Filename + '\';
    Filename := Filename + PlayListItem^.Filename;
    PlayFile(Filename);
    PlayingIndex := Listbox1.Itemindex;
  End;
  If PlayingIndex > 0 then
    SpeedButton6.Enabled := True
  else
    SpeedButton6.Enabled := False;
  if PlayingIndex < Listbox1.Items.Count -1 then
    SpeedButton7.Enabled := True
  else
    SpeedButton7.Enabled := False;
end;

procedure TfrmMMPlayer.Clear1Click(Sender: TObject);
begin
  FilterGraph1.Stop;
  FilterGraph1.ClearGraph;
  FilterGraph1.Active := False;
  ClearPlayList;
end;

procedure TfrmMMPlayer.Exit2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmMMPlayer.DSVideoWindowEx1OverlayVisible(Sender: TObject;
  Visible: Boolean);
begin
  If Visible then
    Panel2.Color := DSVideoWindowEx1.ColorKey
  else
    Panel2.Color := DSVideoWindowEx1.Color;
end;

procedure TfrmMMPlayer.LoadPlayList;
var
  F:TIniFile;
  Session:TStringList;
  i:integer;
  PlayListItem:pPlayListItem;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'adv\playlist.ini');
  Session := TStringList.Create;
  try
    ClearPlayList;
    F.ReadSections(Session);
    for i := Session.Count - 1 downto 0 do
    begin
      if F.ReadBool(Session[i],'ready',false) then
         begin
            New(PlayListItem);
            PlayListItem^.Filename := ExtractFileName(F.ReadString(Session[i],'filename',''));
            PlayListItem^.Path := ExtractFilePath(F.ReadString(Session[i],'filename',''));
            ListBox1.Items.AddObject(F.ReadString(Session[i],'title',''), TObject(PlayListItem));
         end;
    end;
    if Session.Count > 0 then
       begin
         Listbox1.ItemIndex := 0;
         PlayingIndex := 0;
       end
    else
       begin
         Listbox1.ItemIndex := -1;
         PlayingIndex := -1;
       end;
  finally
    Session.Free;
    F.Free;
  end;
end;

procedure TfrmMMPlayer.ClearPlayList;
var i:integer;
begin
  for i:=0 to ListBox1.Items.Count -1 do dispose(Pointer(ListBox1.Items.Objects[i]));
  ListBox1.Clear;
end;

procedure TfrmMMPlayer.WMPlayList(var Message: TMessage);
begin
  LoadPlayList;
  if ListBox1.Items.Count > 0 then
     begin
       PlayFile(pPlayListItem(ListBox1.Items.Objects[0])^.Path+pPlayListItem(ListBox1.Items.Objects[0])^.filename);
       Listbox1.ItemIndex := 0;
       PlayingIndex := 0;
     end;
  PostMessage(frmMMPlayer.Handle,WM_PLAY_DESKTOP,0,0);
end;

procedure TfrmMMPlayer.N4Click(Sender: TObject);
begin
  frmMMUrlDown.Show;
end;

procedure TfrmMMPlayer.N6Click(Sender: TObject);
begin
  frmMMUrlDown.Show;
end;

procedure TfrmMMPlayer.DSVideoWindowEx1DblClick(Sender: TObject);
begin
  SpeedButton4Click(SpeedButton4);
end;

procedure TfrmMMPlayer.ReadMMPlayer;
var
  F:TIniFile;
  w:integer;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'\mmPlayer.ini');
  try
    w := F.ReadInteger('config','Monitor',0);
    if w<ComboBox1.Items.Count then ComboBox1.ItemIndex := w;
    F.WriteInteger('config','Handle',Handle);
  finally
    F.Free;
  end;
end;

procedure TfrmMMPlayer.WriteMMPlayer;
var
  F:TIniFile;
  w:integer;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'\mmPlayer.ini');
  try
    F.WriteInteger('config','Monitor',ComboBox1.ItemIndex);
  finally
    F.Free;
  end;
end;

procedure TfrmMMPlayer.FormDestroy(Sender: TObject);
begin
  WriteMMPlayer;
end;

procedure TfrmMMPlayer.WMPlayDesktop(var Message: TMessage);
begin
  If Combobox1.ItemIndex > 0 then
     DSVideoWindowEx1.StartFullScreen(Screen.Monitors[Combobox1.Itemindex -1])
  else
     DSVideoWindowEx1.StartFullScreen;
  SpeedButton4.Down := DSVideoWindowEx1.FullScreen;
  Application.Minimize;
end;

procedure TfrmMMPlayer.RzTrayIcon1RestoreApp(Sender: TObject);
begin
  left := (screen.width-width) div 2-1;
end;

procedure TfrmMMPlayer.WMTPosDisplay(var Message: TMessage);
var
  Str: string;
  vLow,vHigh,Iparm: integer;
  pos:TLabel;
begin
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
end;

end.
