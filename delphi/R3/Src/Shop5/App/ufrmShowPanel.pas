unit ufrmShowPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RzPanel,MultiMon, RzStatus;

type
  TfrmShowPanel = class(TForm)
    RzPanel1: TRzPanel;
    Timer1: TTimer;
    RzMarqueeStatus1: TRzStatusPane;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
const
  MonitorDefaultFlags: array[TMonitorDefaultTo] of DWORD = (MONITOR_DEFAULTTONEAREST,
                                                          MONITOR_DEFAULTTONULL,
                                                          MONITOR_DEFAULTTOPRIMARY);
var
  MMonitor:TMonitor;
  MIndex:integer;
function GetMonitorExt:integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Screen.MonitorCount - 1 do
    if MIndex <> I then
    begin
      Result := I;
      break;
    end;
end;
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
function FindMonitorIndex(Monitor: TMonitor): integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Screen.MonitorCount - 1 do
    if Screen.Monitors[I].Handle = Monitor.Handle then
    begin
      Result := i;
      break;
    end;
end;

function MonitorFromWindow(const Handle: THandle;
  MonitorDefault: TMonitorDefaultTo = mdNearest): TMonitor;
begin
  Result := FindMonitor(MultiMon.MonitorFromWindow(Handle,
    MonitorDefaultFlags[MonitorDefault]));
end;

{ TfrmShowPanel }

procedure TfrmShowPanel.StartScreen;
var
  Form:TCustomForm;
begin
  Form := Screen.ActiveCustomForm;
  try
    Start(Screen.Monitors[GetMonitorExt]);
  finally
    if Form.CanFocus and Form.Visible then Form.SetFocus;
  end;
end;

procedure TfrmShowPanel.SetsText(const Value: string);
begin
  FsText := Value;
  RzMarqueeStatus1.Caption := ' '+Value;
end;

procedure TfrmShowPanel.Start(OnMonitor: TMonitor);
var
  hWnd:THandle;
begin
  Timer1.Enabled := false;
  Show;
  hWnd := FindWindow('TfrmRzMonitor',nil);
  if hWnd>0 then
     begin
       Windows.SetParent(Handle,hWnd);
       BoundsRect := rect(3,
                     0,
                     3+Width,
                     Height);
     end
  else
     BoundsRect := rect(OnMonitor.Left+3,
                     OnMonitor.Top,
                     OnMonitor.Left+3+Width,
                     OnMonitor.Top+Height);
  BringToFront;
  Timer1.Enabled := true;
end;

procedure TfrmShowPanel.Timer1Timer(Sender: TObject);
begin
  Close;
  Timer1.Enabled := false;
end;

procedure TfrmShowPanel.FormCreate(Sender: TObject);
begin
  MMonitor := MonitorfromWindow(Application.Handle);
  MIndex := FindMonitorIndex(MMonitor);
end;

end.
