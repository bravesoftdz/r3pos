unit ufrmMainPlayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ufrmMMPlayer;
  
const
  MM_PLAYER = '{D51AB2C4-FFEE-414B-890B-30071D941E97}';
  
type
  TfrmMainPlayer = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WMTPosDisplay(var Message: TMessage); message WM_TPOS_DISPLAY;
  end;

var
  frmMainPlayer: TfrmMainPlayer;
  hExists:boolean;

implementation
uses IniFiles;
{$R *.dfm}
var
  MutHandle:THandle;
procedure TfrmMainPlayer.FormCreate(Sender: TObject);
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'\mmPlayer.ini');
  try
    F.WriteInteger('config','Handle',Handle);
  finally
    F.Free;
  end;
end;

procedure TfrmMainPlayer.WMTPosDisplay(var Message: TMessage);
begin
  PostMessage(frmMMPlayer.Handle,WM_TPOS_DISPLAY,Message.WParam,Message.LParam);
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
