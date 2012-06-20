unit ufrmRzMonitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,MultiMon, DSUtil, RzPanel, ExtCtrls, jpeg, rzCtrls;

type
  TfrmRzMonitor = class(TForm)
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FList:TList;  // 节目列表
    FPList:TList;
    FMonitor: Integer;
    FplayIndex: integer;
    FplayFile: TrzFile;
    FThreadLock:TRTLCriticalSection;
    FdefFile: TrzFile;
    procedure SetMonitor(const Value: Integer);
    procedure SetplayFile(const Value: TrzFile);
    procedure SetplayIndex(const Value: integer);
    procedure SetdefFile(const Value: TrzFile); // 插播列表
  protected
    procedure PlayEndIng(var Message: TMessage); message WM_PLAY_ENDING;
    procedure AddFile(rzFile:TrzFile);
    procedure AddPFile(rzFile:TrzFile);

    function  GetPlayFile:TrzFile;
    procedure Enter;
    procedure Leave;
  public
    { Public declarations }
    procedure StartFullScreen; overload;
    procedure StartFullScreen(OnMonitor : TMonitor); overload;
    procedure Play;
    procedure Close;

    //引导节目
    procedure Load;
    procedure Add(rzFile:TrzFile);
    function  Find(pid:string):TrzFile;
    procedure Remove(rzFile:TrzFile);
    //清除节目
    procedure Clear;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Monitor:Integer read FMonitor write SetMonitor;
    property playIndex:integer read FplayIndex write SetplayIndex;
    property playFile:TrzFile read FplayFile write SetplayFile;
    property defFile:TrzFile read FdefFile write SetdefFile;
  end;

implementation
uses IniFiles,ScrnCtrl;
{$R *.dfm}
{ TfrmRcMonitor }

procedure TfrmRzMonitor.StartFullScreen;
begin
  if (Monitor<0) and (Screen.MonitorCount>1) then
     begin
       StartFullScreen(Screen.Monitors[GetMonitorExt])
     end
  else
  if (Monitor<Screen.MonitorCount) and (Monitor>=0) then
     StartFullScreen(Screen.Monitors[Monitor])
  else
     StartFullScreen(MMonitor);
end;

procedure TfrmRzMonitor.StartFullScreen(OnMonitor: TMonitor);
begin
  BoundsRect := rect(OnMonitor.Left,
                     OnMonitor.Top,
                     OnMonitor.Left + OnMonitor.Width,
                     OnMonitor.Top + OnMonitor.Height);
  Show;
end;

constructor TfrmRzMonitor.Create(AOwner: TComponent);
begin
  inherited;
  InitializeCriticalSection(FThreadLock);
  FList := TList.Create;
  FPList := TList.Create;
  playFile := nil;
  defFile := nil;
  playIndex := -1;
  windows.SetParent(Handle,FindWindow('Progman',nil)); 

end;

procedure TfrmRzMonitor.Play;
begin
  Enter;
  try
    playFile := GetPlayFile;
    if assigned(playFile) then playFile.Play;
  finally
    Leave;
  end;
end;

destructor TfrmRzMonitor.Destroy;
begin
  Clear;
  FList.Free;
  FPList.Free;
  DeleteCriticalSection(FThreadLock);
  inherited;
end;

procedure TfrmRzMonitor.AddPFile(rzFile: TrzFile);
begin
  FPList.Add(rzFile);
end;

procedure TfrmRzMonitor.AddFile(rzFile: TrzFile);
begin
  FList.Add(rzFile); 
end;

procedure TfrmRzMonitor.PlayEndIng(var Message: TMessage);
begin
  Close;
  Play;
end;

procedure TfrmRzMonitor.Clear;
var
  i:integer;
begin
  Enter;
  try
    for i:=0 to flist.Count -1 do
      begin
        TObject(flist[i]).Free;
      end;
    flist.Clear;
    for i:=0 to fplist.Count -1 do
      begin
        TObject(fplist[i]).Free;
      end;
    fplist.Clear;
    if FdefFile<>nil then freeAndNil(FdefFile);
  finally
    Leave;
  end;
  playFile := nil;
  playIndex := -1;
end;

procedure TfrmRzMonitor.Load;
var
  jm:TStringList;
  i:integer;
  rc:TrzFile;
  filename,pFile:string;
begin
  Clear;
  Enter;
  jm := TStringList.Create;
  try
    Plays.ReadSections(jm);
    for i:=0 to jm.Count -1 do
      begin
        filename := Plays.ReadString(jm[i],'filename','');
        if fileExists(filename)
           and
           (Plays.ReadString(jm[i],'ready','0')='1')
           and
           (formatDatetime('YYYY-MM-DD',now())>=Plays.ReadString(jm[i],'startdate',''))
           and
           (formatDatetime('YYYY-MM-DD',now())<=Plays.ReadString(jm[i],'enddate',''))
        then
           begin
             if Plays.ReadInteger(jm[i],'programType',0) in [1,3] then
                begin
                  rc := TrzFile.Create(self);
                  AddPFile(rc);
                  rc.Open(filename);
                end
             else
                begin
                  if Plays.ReadInteger(jm[i],'programType',0) in [2] then
                     begin
                        if FdefFile<>nil then freeAndNil(FdefFile);
                        rc := TrzFile.Create(self);
                        defFile := rc;
                        rc.Open(filename);
                     end
                  else
                     pFile := filename;
                end;
           end;
      end;
    if pFile<>'' then
      begin
        rc := TrzFile.Create(self);
        AddFile(rc);
        rc.Open(pFile);
      end;
    if defFile=nil then //没有有效默认时，找最后一个
      begin
        for i:=0 to jm.Count -1 do
          begin
            filename := Plays.ReadString(jm[i],'filename','');
            if fileExists(filename)
               and
               (Plays.ReadString(jm[i],'ready','0')='1')
            then
               begin
                 if Plays.ReadInteger(jm[i],'programType',0) in [2] then
                   begin
                      if FdefFile<>nil then freeAndNil(FdefFile);
                      rc := TrzFile.Create(self);
                      defFile := rc;
                      rc.Open(filename);
                   end;
               end;
          end;
      end;
  finally
    Leave;
    jm.Free;
  end;
end;

procedure TfrmRzMonitor.SetMonitor(const Value: Integer);
begin
  FMonitor := Value;
end;

procedure TfrmRzMonitor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := false;
end;

procedure TfrmRzMonitor.SetplayFile(const Value: TrzFile);
begin
  FplayFile := Value;
end;

procedure TfrmRzMonitor.SetplayIndex(const Value: integer);
begin
  FplayIndex := Value;
end;

function TfrmRzMonitor.GetPlayFile: TrzFile;
var
  i:integer;
begin
  if FPList.Count >0 then
     begin
       result := FPList[0];
       exit;
     end;
  if FList.Count <1 then
     result := defFile
  else
     begin
       playIndex := playIndex + 1;
       if playIndex>=FList.Count then playIndex := 0; 
       result := FList[playIndex];
     end;
end;

procedure TfrmRzMonitor.Add(rzFile: TrzFile);
begin
  Enter;
  try
    case rzFile.ProgramListType of
    0:AddFile(rzFile);
    1,3:AddPFile(rzFile);
    2:begin
        if Assigned(defFile) then freeAndNil(fdefFile);
        defFile := rzFile;
      end;
    end;
  finally
    Enter;
  end;
end;

procedure TfrmRzMonitor.Enter;
begin
  EnterCriticalSection(FThreadLock);

end;

procedure TfrmRzMonitor.Leave;
begin
  LeaveCriticalSection(FThreadLock);
  
end;

function TfrmRzMonitor.Find(pid: string): TrzFile;
var i:integer;
begin
  Enter;
  try
    result := nil;
    for i:=0 to FList.Count -1 do
      begin
        if TrzFile(FList[i]).ProgramListId = pid then
           begin
             result := TrzFile(FList[i]);
             break;
           end;
      end;
  finally
    Leave;
  end;
end;

procedure TfrmRzMonitor.Remove(rzFile: TrzFile);
begin
  Enter;
  try
    if rzFile.ProgramListType=1 then
       FPList.Remove(rzFile)
    else
       FList.Remove(rzFile);
    rzFile.Free;
  finally
    Leave;
  end;
end;

procedure TfrmRzMonitor.Close;
begin
  if PlayFile=nil then Exit;
  PlayFile.Close;
  if PlayFile.ProgramListType in [1,3] then //插播节目，完毕就清除
     begin
       Plays.EraseSection(PlayFile.ProgramListId);
       deletefile(AppData+'\adv\'+PlayFile.ProgramListId+'.xml');
       Remove(FPlayFile);
     end
  else
     begin
       if not (
           (formatDatetime('YYYY-MM-DD',now())>=PlayFile.startdate)
           and
           (formatDatetime('YYYY-MM-DD',now())<=PlayFile.enddate)
           )
       then                           //不在有效期内了，也清除
           begin
             Plays.EraseSection(PlayFile.ProgramListId);
             deletefile(AppData+'\adv\'+PlayFile.ProgramListId+'.xml');
             Remove(FPlayFile);
           end
     end;
end;

procedure TfrmRzMonitor.SetdefFile(const Value: TrzFile);
begin
  FdefFile := Value;
end;

end.
