unit ufrmRcMonitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,MultiMon, DSUtil, RzPanel, ExtCtrls, jpeg, rcCtrls;

type
  TfrmRcMonitor = class(TForm)
  private
    { Private declarations }
    FList:TList;  // 节目列表
    FPList:TList; // 插播列表
  protected
    procedure AddFile(rcFile:TrcFile);
    procedure AddPFile(rcFile:TrcFile);
    procedure PlayEndIng(var Message: TMessage); message WM_PLAY_ENDING;
  public
    { Public declarations }
    procedure StartFullScreen; overload;
    procedure StartFullScreen(OnMonitor : TMonitor); overload;
    procedure Play;

    //引导节目
    procedure Load;
    //清除节目
    procedure Clear;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses IniFiles;
{$R *.dfm}

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
{ TfrmRcMonitor }

procedure TfrmRcMonitor.StartFullScreen;
begin
  StartFullScreen(MonitorfromWindow(Application.MainForm.Handle));
end;

procedure TfrmRcMonitor.StartFullScreen(OnMonitor: TMonitor);
begin
  BoundsRect := rect(OnMonitor.Left,
                     OnMonitor.Top,
                     OnMonitor.Left + OnMonitor.Width,
                     OnMonitor.Top + OnMonitor.Height);
  Show;
end;

constructor TfrmRcMonitor.Create(AOwner: TComponent);
begin
  inherited;
  FList := TList.Create;
  FPList := TList.Create;
end;

procedure TfrmRcMonitor.Play;
begin
end;

destructor TfrmRcMonitor.Destroy;
begin
  Clear;
  FList.Free;
  FPList.Free;
  inherited;
end;

procedure TfrmRcMonitor.AddPFile(rcFile: TrcFile);
begin
  FPList.Add(rcFile);
end;

procedure TfrmRcMonitor.AddFile(rcFile: TrcFile);
begin
  FList.Add(rcFile); 
end;

procedure TfrmRcMonitor.PlayEndIng(var Message: TMessage);
begin
  Play;
end;

procedure TfrmRcMonitor.Clear;
var
  i:integer;
begin
  for i:=0 to flist.Count -1 do
    begin
      TObject(flist[i]).Free;
    end;
  for i:=0 to fplist.Count -1 do
    begin
      TObject(fplist[i]).Free;
    end;
end;

procedure TfrmRcMonitor.Load;
var
  F:TIniFile;
  jm:TStringList;
  i:integer;
  rc:TrcFile;
  filename:string;
begin
  Clear;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'adv\plays.ini'); 
  jm := TStringList.Create;
  try
    F.ReadSections(jm);
    for i:=0 to jm.Count -1 do
      begin
        filename := f.ReadString(jm[i],'filename','');
        if fileExists(filename)
           and
           (f.ReadString(jm[i],'ready','1')='1')
           and
           (formatDatetime('YYYY-MM-DD',now())>=f.ReadString(jm[i],'startdate',''))
           and
           (formatDatetime('YYYY-MM-DD',now())<=f.ReadString(jm[i],'enddate',''))
        then
           begin
             rc := TrcFile.Create(self);
             if f.ReadString(jm[i],'programType','0')='1' then
                AddPFile(rc)
             else
                AddFile(rc);
             rc.Open(filename); 
           end;
      end;
  finally
    jm.Free;
    F.Free;
  end;
end;

end.
