unit ufrmRCPlayer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, DSPack, DirectShow9, StdCtrls, ActiveX, DSUtil, Menus,
  ExtCtrls, ComCtrls, Buttons, ImgList, RzTray, RzStatus, RzPanel,ufrmRcMonitor;

const
  RC_PLAYER = '{878F551E-FE1B-4A89-B6BF-A49B300882A6}';
  
type
  TfrmRCPlayer = class(TForm)
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Panel1: TPanel;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    Fullscreen1: TMenuItem;
    ImageList2: TImageList;
    Exit2: TMenuItem;
    N5: TMenuItem;
    RzTrayIcon1: TRzTrayIcon;
    Bkg: TPanel;
    Memo1: TMemo;
    open1: TMenuItem;
    N3: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Exit2Click(Sender: TObject);
    procedure Fullscreen1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OsdChanged : Boolean;
    Shut:boolean;
    frmRcMonitor:TfrmRcMonitor;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmRCPlayer: TfrmRCPlayer;
  hExists:boolean;
implementation

uses IniFiles;

{$R *.dfm}
var
  MutHandle:THandle;

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
end;

constructor TfrmRCPlayer.Create(AOwner: TComponent);
begin
  inherited;
  frmRcMonitor := TfrmRcMonitor.Create(nil);
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

procedure TfrmRCPlayer.Exit2Click(Sender: TObject);
begin
  Shut := true;
  Application.MainForm.Close;
end;

procedure TfrmRCPlayer.Fullscreen1Click(Sender: TObject);
begin
  Show;
end;

initialization
  //打开互斥对象
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, RC_PLAYER);
  if MutHandle = 0 then
  begin
    //建立互斥对象
    MutHandle := CreateMutex(nil, False, RC_PLAYER);
    hExists := false;
  end
  else
    hExists := true;
finalization
  if MutHandle<>0 then  CloseHandle(MutHandle);
end.
