unit ufrmMainPlayer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;
  
const
  MM_PLAYER = '{D51AB2C4-FFEE-414B-890B-30071D941E97}';
  
type
  TfrmMainPlayer = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainPlayer: TfrmMainPlayer;
  hExists:boolean;

implementation

{$R *.dfm}
var
  MutHandle:THandle;
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
