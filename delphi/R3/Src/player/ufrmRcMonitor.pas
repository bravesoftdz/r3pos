unit ufrmRcMonitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,MultiMon, DirectShow9, DSUtil, RzPanel, ExtCtrls, RzStatus, DSPack, Marquee,
  jpeg;

type
  TMonitorParams=record
    monitor:TControl;       //显示控件
    mediaType:integer;      //媒休类型
    index:integer;          //当前序号
    filename:string;
  end;
  TfrmRcMonitor = class(TForm)
    FilterGraph1: TFilterGraph;
    procedure FilterGraph1GraphComplete(sender: TObject; Result: HRESULT;
      Renderer: IBaseFilter);
  private
    { Private declarations }
    FVideoWindow:TVideoWindow;
    VideoIndex:integer;
    Monitor:array [0..3] of TMonitorParams;
    procedure LoadMonitor;
    function GetVideoWindow: TVideoWindow;
  public
    { Public declarations }
    procedure StartFullScreen(FilterGraph: TFilterGraph); overload;
    procedure StartFullScreen(FilterGraph: TFilterGraph;OnMonitor : TMonitor); overload;
    procedure NormalPlayback;
    constructor Create(AOwner: TComponent); override;

    procedure Play; overload;
    procedure Play(idx:integer;index:integer=-1); overload;

    property VideoWindow:TVideoWindow read GetVideoWindow;
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

procedure TfrmRcMonitor.StartFullScreen(FilterGraph: TFilterGraph);
begin
    StartFullScreen(FilterGraph,MonitorfromWindow(Application.MainForm.Handle));
end;

procedure TfrmRcMonitor.NormalPlayback;
begin
  if Screen.MonitorCount>1 then
     begin
     end;
end;

procedure TfrmRcMonitor.StartFullScreen(FilterGraph: TFilterGraph;OnMonitor: TMonitor);
begin
  BoundsRect := rect(OnMonitor.Left,
                     OnMonitor.Top,
                     OnMonitor.Left + OnMonitor.Width,
                     OnMonitor.Top + OnMonitor.Height);
  Show;
  LoadMonitor;
end;

constructor TfrmRcMonitor.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TfrmRcMonitor.LoadMonitor;
var
  F:TIniFile;
  
function CreateControl(bkg:TWinControl;idx:integer):TControl;
begin
  monitor[idx-1].mediaType := F.ReadInteger('m'+formatFloat('00',idx),'mediaType',1);
  case  monitor[idx-1].mediaType of
  1:begin
      FVideoWindow := TVideoWindow.Create(self);
      result := FVideoWindow;
      FVideoWindow.Mode := vmVMR;
      FVideoWindow.VMROptions.KeepAspectRatio := false;
      FVideoWindow.FilterGraph := FilterGraph1;
    end;
  2:begin
      result := TImage.Create(self);
      TImage(result).Stretch := true;
    end;
  3:Raise Exception.Create('暂不支持flash');
  end;
  result.Parent := bkg;
  result.Align := alClient;
  monitor[idx-1].monitor := result;
  monitor[idx-1].index := 0;
end;

var
  i:integer;
  p,bkg:TPanel;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'adv\monitor.ini');
  try
    for i:=ControlCount-1 downto 0 do
      begin
        if (i<ControlCount) and (Controls[i] is TPanel) then Controls[i].Free;
      end;
    for i:=0 to 3 do monitor[i].monitor := nil;
    case F.ReadInteger('monitor','monitor',0) of
    0:begin
        CreateControl(self,1);
      end;
    1:begin
        p := TPanel.Create(self);
        p.Align := alTop;
        p.BevelOuter := bvNone;
        p.Height := (Height*F.ReadInteger('m01','height',50)) div 100;
        p.Name := 'm01';
        p.Parent := self;
        p.Color := clBlack;
        CreateControl(p,1);
        p := TPanel.Create(self);
        p.Align := alClient;
        p.BevelOuter := bvNone;
        p.Name := 'm02';
        p.Parent := self;
        CreateControl(p,2);
      end;
    2:begin
        p := TPanel.Create(self);
        p.Align := alLeft;
        p.BevelOuter := bvNone;
        p.Width := (Width*F.ReadInteger('m01','width',50)) div 100;
        p.Name := 'm01';
        p.Color := clBlack;
        p.Parent := self;
        CreateControl(p,1);
        p := TPanel.Create(self);
        p.Align := alClient;
        p.BevelOuter := bvNone;
        p.Name := 'm02';
        p.Parent := self;
        CreateControl(p,2);
      end;
    3:begin
        p := TPanel.Create(self);
        p.Align := alTop;
        p.BevelOuter := bvNone;
        p.Height := (Height*F.ReadInteger('m01','height',50)) div 100;
        p.Name := 'm01';
        p.Color := clBlack;
        p.Parent := self;
        CreateControl(p,1);

        bkg := TPanel.Create(self);
        bkg.Parent := self;
        bkg.Align := alClient;
        bkg.BevelOuter := bvNone;
        bkg.Name := 'Bkg02';
        bkg.Parent := self;

        p := TPanel.Create(self);
        p.Align := alLeft;
        p.Parent := bkg;
        p.BevelOuter := bvNone;
        p.Width := (Width*F.ReadInteger('m02','width',50)) div 100;
        p.Name := 'm02';
        CreateControl(p,2);
        p := TPanel.Create(self);
        p.Align := alClient;
        p.Parent := bkg;
        p.BevelOuter := bvNone;
        p.Color := clWhite;
        p.Name := 'm03';
        CreateControl(p,3);
      end;
    4:begin
        bkg := TPanel.Create(self);
        bkg.Align := alTop;
        bkg.BevelOuter := bvNone;
        bkg.Height := (Height*F.ReadInteger('m01','height',50)) div 100;
        bkg.Name := 'Bkg01';
        bkg.Parent := self;
        p := TPanel.Create(self);
        p.Align := alLeft;
        p.Parent := bkg;
        p.BevelOuter := bvNone;
        p.Width := (Width*F.ReadInteger('m02','width',50)) div 100;
        p.Name := 'm01';
        CreateControl(p,1);
        p := TPanel.Create(self);
        p.Align := alClient;
        p.Parent := bkg;
        p.BevelOuter := bvNone;
        p.Name := 'm02';
        p.Color := clWhite;
        CreateControl(p,2);

        p := TPanel.Create(self);
        p.Parent := self;
        p.Align := alClient;
        p.BevelOuter := bvNone;
        p.Name := 'm03';
        p.Color := clBlack;
        CreateControl(p,3);
      end;
    5:begin
        bkg := TPanel.Create(self);
        bkg.Align := alTop;
        bkg.BevelOuter := bvNone;
        bkg.Height := (Height*F.ReadInteger('m01','height',50)) div 100;
        bkg.Name := 'Bkg01';
        bkg.Parent := self;
        p := TPanel.Create(self);
        p.Align := alLeft;
        p.Parent := bkg;
        p.BevelOuter := bvNone;
        p.Width := (Width*F.ReadInteger('m02','width',50)) div 100;
        p.Name := 'm01';
        p.Color := clWhite;
        CreateControl(p,1);
        p := TPanel.Create(self);
        p.Align := alClient;
        p.Parent := bkg;
        p.BevelOuter := bvNone;
        p.Name := 'm02';
        CreateControl(p,2);

        bkg := TPanel.Create(self);
        bkg.Align := alClient;
        bkg.BevelOuter := bvNone;
        bkg.Name := 'Bkg02';
        bkg.Parent := self;
        p := TPanel.Create(self);
        p.Align := alLeft;
        p.Parent := bkg;
        p.BevelOuter := bvNone;
        p.Width := (Width*F.ReadInteger('m02','width',50)) div 100;
        p.Name := 'm03';
        CreateControl(p,3);
        p := TPanel.Create(self);
        p.Align := alClient;
        p.Parent := bkg;
        p.BevelOuter := bvNone;
        p.Name := 'm04';
        p.Color := clWhite;
        CreateControl(p,4);
      end;
    end;
  finally
    F.Free;
  end;
end;

function TfrmRcMonitor.GetVideoWindow: TVideoWindow;
begin
  result := FVideoWindow;
end;

procedure TfrmRcMonitor.Play;
var
  i:integer;
begin
  for i:=0 to 3 do
    begin
      if Monitor[i].monitor<>nil then
         Play(i+1,-1);
    end;
end;

procedure TfrmRcMonitor.Play(idx: integer;index:integer=-1);
var
  F:TIniFile;
  List:TStringList;
  nIndex:integer;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'adv\'+'playlist-'+formatFloat('00',idx)+'.ini');
  List := TStringList.Create;
  try
    F.ReadSections(List);
    F.EraseSection('adv');
    if List.Count=0 then Exit;
    if index=-1 then
    begin
      nIndex := monitor[idx-1].index;
      while true do
        begin
          if nIndex>=(List.Count-1) then nIndex := 0;
          inc(nIndex);
          if F.ReadInteger(List[nIndex-1],'ready',0)=1 then
             begin
               break;
             end
          else
             begin
               if (nIndex<monitor[idx-1].index) or (List.Count=1) then break;
             end;
        end;
    end
    else
      nIndex := Index;
    monitor[idx-1].index := nIndex;
    monitor[idx-1].filename := F.ReadString(List[nIndex-1],'filename','');
    if pos(':',monitor[idx-1].filename)=0 then monitor[idx-1].filename :=  ExtractFilePath(ParamStr(0))+'adv\'+monitor[idx-1].filename;
  finally
    List.Free;
    F.Free;
  end;
  case monitor[idx-1].mediaType of
  1:begin
      FilterGraph1.ClearGraph;
      FilterGraph1.Active := False;
      FilterGraph1.Active := True;
      FilterGraph1.RenderFile(monitor[idx-1].filename);
      FilterGraph1.Play;
      VideoIndex := idx;
    end;
  2:begin
      TImage(monitor[idx-1].monitor).Picture.LoadfromFile(monitor[idx-1].filename);
    end;
  3:begin
    end;
  end;
end;

procedure TfrmRcMonitor.FilterGraph1GraphComplete(sender: TObject;
  Result: HRESULT; Renderer: IBaseFilter);
begin
  Play(VideoIndex,-1);
end;

end.
