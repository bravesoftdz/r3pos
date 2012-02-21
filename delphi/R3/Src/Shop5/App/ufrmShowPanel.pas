unit ufrmShowPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RzPanel,MultiMon;

type
  TfrmShowPanel = class(TForm)
    RzPanel1: TRzPanel;
    Label1: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    FsText: string;
    procedure SetsText(const Value: string);
    { Private declarations }
   procedure Start(OnMonitor : TMonitor);
  public
    { Public declarations }
    procedure StartScreen;
     property sText:string read FsText write SetsText;
  end;

implementation
{$R *.dfm}

{ TfrmShowPanel }

function FindMonitor(Handle: THandle): TMonitor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Screen.MonitorCount - 1 do
  if Screen.Monitors[I].Handle = Handle then
  begin
    Result := Screen.Monitors[I];
    break;
  end;
end;

function MonitorFromWindow(const Handle: THandle;
  MonitorDefault: TMonitorDefaultTo = mdNearest): TMonitor;
const
  MonitorDefaultFlags: array[TMonitorDefaultTo] of DWORD = (MONITOR_DEFAULTTONEAREST,
                                                          MONITOR_DEFAULTTONULL,
                                                          MONITOR_DEFAULTTOPRIMARY);
begin
  Result := FindMonitor(MultiMon.MonitorFromWindow(Handle,
    MonitorDefaultFlags[MonitorDefault]));
    end;
procedure TfrmShowPanel.StartScreen;
begin
  Start(Screen.Monitors[1]);
end;

procedure TfrmShowPanel.SetsText(const Value: string);
begin
  FsText := Value;
  Label1.Caption := Value;
  Label1.Width := Label1.Canvas.TextWidth(Value) + 20; 
end;

procedure TfrmShowPanel.Start(OnMonitor: TMonitor);
begin
  BoundsRect := rect(OnMonitor.Left+width,
                     OnMonitor.Top+0,
                     Width,
                     Height);
  Show;
  Timer1.Enabled := true;
end;

procedure TfrmShowPanel.Timer1Timer(Sender: TObject);
begin
  Close;
  Timer1.Enabled := false;
end;

end.
