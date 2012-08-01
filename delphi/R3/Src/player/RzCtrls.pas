unit RzCtrls;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,RzCommon,
  Dialogs, StdCtrls,MultiMon, DirectShow9, ActiveX,ComObj, DSUtil, RzPanel, ExtCtrls, RzStatus, DSPack,
  jpeg,msxml,IniFiles;
const
  WM_PLAY_ENDING=WM_USER+3000;
  WM_PLAY_INIT=WM_PLAY_ENDING+1;
  WM_LOGFILE_MSG=WM_PLAY_INIT+1;
  WM_PLAY_START=WM_LOGFILE_MSG+1;
  WM_PLAY_END=WM_PLAY_START+1;
  WM_PLAY_CLOSE=WM_PLAY_END+1;
type
  TMonitorType=(mtNone,mtPhoto,mtText,mtVideo,mtMusic);
  TPlayStatus=(psNone,psPlaying,psEnded);
  PSrcDefine=^TSrcDefine;
  TSrcDefine=record
    //资源编号
    SourceId:string;
    //序号
    Sequence:integer;
    //文件名或文本
    src:string;
    //显示时长
    srcLength:integer;
    //显示速度
    ScrollSpeed:integer;
    //背景
    BackColor:TColor;
    //颜色
    FontColor:TColor;
    //大小
    FontSize:integer;
    //字体名
    FontName:string;
    //字符集  
    CharSet:integer;
    //效果
    Effect:integer;
    //音量
    volume:integer;
  end;
  TrzProgram=class;
  TrzPlayList=class;
  TrzFile=class;
  TrzMonitor=class
  private
    Parant:TWinControl;
    display:TControl;
    Fheight: integer;
    Ftop: integer;
    Fwidth: integer;
    Fleft: integer;
    FdpyLength: int64;
    FdpyStart: int64;
    FList:TList;
    Findex: integer;
    FMonitorType: TMonitorType;
    Timer:TTimer;
    FrcProgram: TrzProgram;
    FMonitorIdx: integer;
    F_Start: Int64;
    FEnded: boolean;
    FplayTimes: integer;
    procedure Setheight(const Value: integer);
    procedure Setleft(const Value: integer);
    procedure Settop(const Value: integer);
    procedure Setwidth(const Value: integer);
    procedure SetdpyLength(const Value: int64);
    procedure SetdpyStart(const Value: int64);
    function  GetSrcs(idx: integer): PSrcDefine;
    procedure SetSrcs(idx: integer; const Value: PSrcDefine);
    procedure Setindex(const Value: integer);
    function  GetSrcCount: integer;
    procedure SetMonitorType(const Value: TMonitorType);
    procedure SeTrzProgram(const Value: TrzProgram);
    procedure SetMonitorIdx(const Value: integer);
    procedure Set_Start(const Value: Int64);
    procedure SetEnded(const Value: boolean);
    procedure SetplayTimes(const Value: integer);
  protected
    procedure WndProc(var Message: TMessage);
    procedure PlayEnded;virtual;
    procedure TimerComplete(Sender:TObject);
    procedure Sort;
  public
    Handle:THandle;
    constructor Create(AOwner: TWinControl); virtual;
    destructor Destroy; override;

    procedure DoTimerNext;
    function Open(src:PSrcDefine):boolean;virtual;
    procedure Pause;virtual;
    procedure resume;virtual;
    procedure Close;virtual;
    procedure Clear;
    procedure AddSrc(src:PSrcDefine);
    procedure DelSrc(src:PSrcDefine);
    procedure DoTimer;
    //显示位置
    property top:integer read Ftop write Settop;
    property left:integer read Fleft write Setleft;
    property width:integer read Fwidth write Setwidth;
    property height:integer read Fheight write Setheight;
    //开始显示时间 精确到秒
    property dpyStart:int64 read FdpyStart write SetdpyStart;
    //显示时间（秒）
    property dpyLength:int64 read FdpyLength write SetdpyLength;
    property Srcs[idx:integer]:PSrcDefine read GetSrcs write SetSrcs;
    //当前播放资源
    property index:integer read Findex write Setindex;
    property SrcCount:integer read GetSrcCount;
    property MonitorType:TMonitorType read FMonitorType write SetMonitorType;
    property rcProgram:TrzProgram read FrcProgram write SeTrzProgram;
    property MonitorIdx:integer read FMonitorIdx write SetMonitorIdx;
    property _Start:Int64 read F_Start write Set_Start;
    property Ended:boolean read FEnded write SetEnded;
    property playTimes:integer read FplayTimes write SetplayTimes;
  end;
  TrzVideoMonitor=class(TrzMonitor)
  private
    Cursrc:PSrcDefine;
    FilterGraph:TFilterGraph;
    procedure FilterGraphGraphComplete(sender: TObject;Result: HRESULT; Renderer: IBaseFilter);
    procedure WMPlayEnd(var Message: TMessage); message WM_PLAY_END;
    procedure GraphPausedEvent(sender: TObject; Result: HRESULT);
    function WaitForSendMessage:boolean;
  public
    function Open(src:PSrcDefine):boolean;override;
    procedure Close;override;
    procedure Pause;override;
    procedure resume;override;

    constructor Create(AOwner: TWinControl); override;
    destructor Destroy; override;
  end;
  TrzMusicMonitor=class(TrzMonitor)
  private
    Cursrc:PSrcDefine;
    FilterGraph:TFilterGraph;
    procedure FilterGraphGraphComplete(sender: TObject;Result: HRESULT; Renderer: IBaseFilter);
    procedure WMPlayEnd(var Message: TMessage); message WM_PLAY_END;
  public
    function Open(src:PSrcDefine):boolean;override;
    procedure Close;override;
    procedure Pause;override;
    procedure resume;override;

    constructor Create(AOwner: TWinControl); override;
    destructor Destroy; override;
  end;
  TrzPhotoMonitor=class(TrzMonitor)
  private
  public
    function Open(src:PSrcDefine):boolean;override;
    procedure Pause;override;
    procedure resume;override;
    procedure Close;override;
    constructor Create(AOwner: TWinControl); override;
    destructor Destroy; override;
  end;
  TrzTextMonitor=class(TrzMonitor)
  private
    function GetFont: TFont;
    procedure SetFont(const Value: TFont);
    function GetBackColor: TColor;
    function GetScrollSpeed: integer;
    procedure SetBackColor(const Value: TColor);
    procedure SetScrollSpeed(const Value: integer);
  public
    procedure Pause;override;
    procedure resume;override;
    function Open(src:PSrcDefine):boolean;override;
    procedure Close;override;
    constructor Create(AOwner: TWinControl); override;
    destructor Destroy; override;
    property Font:TFont read GetFont write SetFont;
    property ScrollSpeed:integer read GetScrollSpeed write SetScrollSpeed;
    property BackColor:TColor read GetBackColor write SetBackColor;
  end;

  TrzProgram=class
  private
    Parant:TWinControl;
    FList:TList;
    FProgramLen: integer;
    FProgramSeq: integer;
    FProgramId: string;
    FScreenWidth: integer;
    FScreenHeight: integer;
    Froot: IXMLDOMNode;
    Factive: boolean;
    Timer:TTimer;
    rzPlayList:TrzPlayList;
    FProgramIndex: integer;
    F_Start: int64;
    Fended: boolean;
    FMonitorLen: integer;
    FVedioLen: integer;
    FProgramCount: integer;
    Handle:THandle;
    procedure SetProgramId(const Value: string);
    procedure SetProgramLen(const Value: integer);
    procedure SetProgramSeq(const Value: integer);
    procedure SetScreenHeight(const Value: integer);
    procedure SetScreenWidth(const Value: integer);
    procedure Setroot(const Value: IXMLDOMNode);
    procedure Setactive(const Value: boolean);
    procedure SetProgramIndex(const Value: integer);
    procedure Set_Start(const Value: int64);
    procedure Setended(const Value: boolean);
    procedure SetMonitorLen(const Value: integer);
    procedure SetVedioLen(const Value: integer);
    procedure SetProgramCount(const Value: integer);
  protected
    procedure TimerComplete(Sender:TObject);
    function PlayEnd:boolean;
    function PlayNext:boolean;
    procedure WMPlayEnd(var Message: TMessage); message WM_PLAY_END;
    procedure WndProc(var Message: TMessage);
  public
    constructor Create(AOwner: TWinControl;PlayList:TrzPlayList);
    destructor Destroy; override;
    //清屏
    procedure Clear;
    //引导屏幕
    procedure Open(root:IXMLDOMNode);
    procedure Play;
    procedure Close;
    procedure Pause;
    procedure resume;
    property ProgramId:string read FProgramId write SetProgramId;
    property ProgramSeq:integer read FProgramSeq write SetProgramSeq;
    property ProgramLen:integer read FProgramLen write SetProgramLen;
    property ProgramCount:integer read FProgramCount write SetProgramCount;
    property MonitorLen:integer read FMonitorLen write SetMonitorLen;
    property VedioLen:integer read FVedioLen write SetVedioLen;
    property ScreenWidth:integer read FScreenWidth write SetScreenWidth;
    property ScreenHeight:integer read FScreenHeight write SetScreenHeight;
    property ProgramIndex:integer read FProgramIndex write SetProgramIndex;
    property root:IXMLDOMNode read Froot write Setroot;
    property active:boolean read Factive write Setactive;
    property _Start:int64 read F_Start write Set_Start;
    property ended:boolean read Fended write Setended;
  end;

  TrzPlayList=class
  private
    Parant:TWinControl;
    FList:TList;
    FStartTime: string;
    FPlayType: integer;
    FPlayListLen: integer;
    FPlayListSeq: integer;
    FPlayListId: string;
    curProgram:TrzProgram;
    Timer:TTimer;
    Findex: integer;
    FEnded: boolean;
    FNearTime: string;
    Factive: boolean;
    rzFile:TrzFile;
    FPlayListIndex: integer;
    F_Start: Int64;
    FPlayTimes: integer;
    FProgramLen: integer;
    FPlayCount: integer;
    Handle:THandle;
    procedure SetPlayListId(const Value: string);
    procedure SetPlayListLen(const Value: integer);
    procedure SetPlayType(const Value: integer);
    procedure SetPlayListSeq(const Value: integer);
    procedure SetStartTime(const Value: string);
    procedure Setindex(const Value: integer);
    procedure SetEnded(const Value: boolean);
    procedure SetNearTime(const Value: string);
    procedure Setactive(const Value: boolean);
    procedure SetPlayListIndex(const Value: integer);
    procedure Set_Start(const Value: Int64);
    procedure SetPlayTimes(const Value: integer);
    procedure SetProgramLen(const Value: integer);
    procedure SetPlayCount(const Value: integer);
  protected
    procedure WMPlayEnd(var Message: TMessage); message WM_PLAY_END;
    procedure TimerComplete(Sender:TObject);
    procedure PlayNext;
    procedure Sort;
    function PlayEnd:boolean;
    procedure WriteToFile;
    procedure WndProc(var Message: TMessage);
  public
    constructor Create(AOwner: TWinControl;AFile:TrzFile);
    destructor Destroy; override;
    procedure Clear;
    //引导节目
    procedure Open(root:IXMLDOMNode);
    function  reLoad:boolean;
    procedure Close;
    procedure Play;
    procedure Pause;
    procedure resume;

    property PlayListId:string read FPlayListId write SetPlayListId;
    property PlayListLen:integer read FPlayListLen write SetPlayListLen;
    property ProgramLen:integer read FProgramLen write SetProgramLen;
    property PlayType:integer read FPlayType write SetPlayType;
    property PlayCount:integer read FPlayCount write SetPlayCount;
    property StartTime:string read FStartTime write SetStartTime;
    property PlayListSeq:integer read FPlayListSeq write SetPlayListSeq;
    property index:integer read Findex write Setindex;
    property Ended:boolean read FEnded write SetEnded;
    //最近播时时间
    property NearTime:string read FNearTime write SetNearTime;
    property _Start:Int64 read F_Start write Set_Start;
    property active:boolean read Factive write Setactive;
    property PlayListIndex:integer read FPlayListIndex write SetPlayListIndex;
    property PlayTimes:integer read FPlayTimes write SetPlayTimes;
  end;


  TrzFile=class
  private
    Parant:TWinControl;
    FList:TList;
    Timer:TTimer;
    Findex: integer;
    playLen:int64;
    dayPlayFile:string;
    curPlayList:TrzPlayList;
    xmlDoc:IXMLDomDocument;
    FProgramListType: integer;
    FPeriod: integer;
    FEndDate: string;
    FStartDate: string;
    FProgramListId: string;
    Ffilename: string;
    FActive: boolean;
    FPlayStatus: TPlayStatus;
    procedure Setindex(const Value: integer);
    procedure SetEndDate(const Value: string);
    procedure SetPeriod(const Value: integer);
    procedure SetProgramListId(const Value: string);
    procedure SetProgramListType(const Value: integer);
    procedure SetStartDate(const Value: string);
    procedure Setfilename(const Value: string);
    procedure SetActive(const Value: boolean);
    procedure SetPlayStatus(const Value: TPlayStatus);
  protected
    procedure TimerComplete(Sender:TObject);
    procedure Sort;
    procedure WriteToFile;
  public
    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
    procedure Clear;
    //引导节目
    procedure Open(filename:string);
    procedure Close;
    procedure Play(CallBacked:boolean=false);
    procedure Pause;
    procedure resume;
    procedure DoTimer;
    procedure rePlay;

    property index:integer read Findex write Setindex;
    property ProgramListId:string read FProgramListId write SetProgramListId;
    property Period:integer read FPeriod write SetPeriod;
    property StartDate:string read FStartDate write SetStartDate;
    property EndDate:string read FEndDate write SetEndDate;
    property ProgramListType:integer read FProgramListType write SetProgramListType;
    property PlayStatus:TPlayStatus read FPlayStatus write SetPlayStatus;
    property filename:string read Ffilename write Setfilename;
    property Active:boolean read FActive write SetActive;
  end;
TrzPlayIni=class
  private
    F:TIniFile;
    FThreadLock:TRTLCriticalSection;
    procedure Enter;
    procedure Leave;
  public
    constructor Create;
    destructor Destroy; override;

    procedure ReadSections(Strings: TStrings);
    function readString(Section, Ident:string;default:string=''):string;
    function readInteger(Section, Ident:string;default:integer=0):integer;
    procedure WriteString(Section, Ident:string;default:string);
    procedure WriteInteger(Section, Ident:string;default:integer);
    procedure EraseSection(Section:string);
    procedure DeleteKey(Section, Ident:string);
  end;
//FATAL、ERROR、WARN、INFO、 DEBUG、TRACE、ALL
procedure SendDebug(s:string;flag:integer=0);
procedure ClearDebug;
var
  Plays:TrzPlayIni;
  log:TextFile;
  logFlag:string='110000';
  AppPath,AppData:string;
  resDay:integer=30;
  DefVMRVideoMode:TVMRVideoMode=vmrWindowless;
implementation
uses ScrnCtrl,ufrmRzPlayer;
procedure SendDebug(s:string;flag:integer=0);
var
  buf:Pchar;
  w:integer;
  filename:string;
  p,szFilename:pchar;
begin
  try
    case flag of
    0:s := formatdatetime('MM/DD/YY HH:NN:SS zzz',now())+' ['+inttostr(GetCurrentProcessId)+'] FATAL - '+s;
    1:s := formatdatetime('MM/DD/YY HH:NN:SS zzz',now())+' ['+inttostr(GetCurrentProcessId)+'] ERROR - '+s;
    2:s := formatdatetime('MM/DD/YY HH:NN:SS zzz',now())+' ['+inttostr(GetCurrentProcessId)+'] WARN - '+s;
    3:s := formatdatetime('MM/DD/YY HH:NN:SS zzz',now())+' ['+inttostr(GetCurrentProcessId)+'] INFO - '+s;
    4:s := formatdatetime('MM/DD/YY HH:NN:SS zzz',now())+' ['+inttostr(GetCurrentProcessId)+'] DEBUG - '+s;
    5:s := formatdatetime('MM/DD/YY HH:NN:SS zzz',now())+' ['+inttostr(GetCurrentProcessId)+'] TRACE - '+s;
    6:s := formatdatetime('MM/DD/YY HH:NN:SS zzz',now())+' ['+inttostr(GetCurrentProcessId)+'] ALL - '+s;
    end;
    if (Application.MainForm<>nil) and Application.MainForm.Visible then
       begin
         w := length(s);
         getmem(buf,w);
         move(pchar(s)^,buf^,w);
         PostMessage(Application.MainForm.Handle,WM_LOGFILE_MSG,w,Integer(buf));
       end;
    if logFlag[flag+1]='0' then Exit;
    filename := AppData + '\logs\RzPlayer.log';
    AssignFile(log,filename);
    if fileExists(filename) then
       Append(log) else reWrite(log);
    try
       writeln(log,s);
    finally
       if fileSize(log)>1024*1024 then
          begin
            closefile(log);
            ClearDebug;
          end
       else
          begin
            closefile(log);
          end;
    end;
  except  end;
end;
procedure ClearDebug;
var
  Filename:string;
  p,szFilename:pchar;
  sText,nText:TMemoryStream;
begin
  Filename := AppData + '\logs\RzPlayer.log';
  sText := TMemoryStream.Create;
  nText := TMemoryStream.Create;
  try
    sText.LoadFromFile(Filename);
    if sText.Size<=1024*512 then Exit;
    sText.Position := sText.Size - 1024*512;
    nText.CopyFrom(sText,1024*512);
    nText.SaveToFile(Filename);
  finally
    sText.Free;
    nText.Free;
  end;
end;
{ TrzMonitor }

procedure TrzMonitor.AddSrc(src: PSrcDefine);
begin
  FList.Add(src); 
end;

procedure TrzMonitor.Clear;
var
  i:integer;
begin
  for i:=Flist.Count -1 downto 0 do
    begin
      dispose(Flist[i]);
    end;
  Flist.Clear;
end;

procedure TrzMonitor.Close;
begin
  index := -1;
  Timer.Enabled := false;
end;

constructor TrzMonitor.Create(AOwner: TWinControl);
begin
  Handle := AllocateHwnd(WndProc);
  Parant :=  AOwner;
  FList := TList.Create;
  fdpyLength := 0;
  Timer := TTimer.Create(AOwner);
  Timer.Enabled := false;
  Timer.OnTimer := TimerComplete;
  findex := -1;
  Ended := false;
end;

procedure TrzMonitor.DelSrc(src: PSrcDefine);
var
  idx:integer;
begin
  idx := FList.IndexOf(src);
  if idx>=0 then
     begin
       dispose(src);
       FList.Delete(idx);
     end;
end;

destructor TrzMonitor.Destroy;
begin
  if Handle <> 0 then DeallocateHWnd(Handle);
  Timer.Free;
  Clear;
  FList.Free;
  Parant :=  nil;
  inherited;
end;

procedure TrzMonitor.DoTimer;
begin
  Timer.Enabled := false;
  Timer.Enabled := (dpyLength > 0);
end;

procedure TrzMonitor.DoTimerNext;
begin
  Timer.Enabled := false;
  Timer.Interval := 1000;
  Timer.Enabled := true;
end;

function TrzMonitor.GetSrcCount: integer;
begin
  result := FList.Count;
end;

function TrzMonitor.GetSrcs(idx: integer): PSrcDefine;
begin
  result := PSrcDefine(FList[idx]);
end;

function TrzMonitor.Open(src: PSrcDefine): boolean;
begin
  result := false;
end;

procedure TrzMonitor.Pause;
begin
  display.Visible := false;
end;

procedure TrzMonitor.PlayEnded;
begin
  if IsWorkStationLocked then
     begin
       Timer.Enabled := false;
       Timer.Interval := 3000;
       Timer.Enabled := true;
       SendDebug('锁屏暂停播放',4);
       Exit;
     end;
  if index=(flist.count-1) then
     begin
       Ended := true;
       inc(FplayTimes);
     end;
  if rcProgram.PlayEnd then
     begin
       PostMessage(rcProgram.Handle,WM_PLAY_END,0,0);
       Exit;
     end;
  if SrcCount<=0 then exit;
  index := index+1;
  if index<0 then index := 0;
  if ended and (index=0) then  ended := false;

  try
    Open(srcs[index]);
  except
    on E:Exception do
       begin
         SendDebug('播放出错了，软件自动清除非法节目<'+inttostr(index)+'>，原因："'+E.Message+'"',1);
         DelSrc(srcs[index]);
         DoTimerNext;
       end;
  end;
end;

procedure TrzMonitor.resume;
begin
  display.Visible := true;
end;

procedure TrzMonitor.SetdpyLength(const Value: int64);
begin
  FdpyLength := Value;
  Timer.Enabled := false;
  Timer.Interval := Value*1000;
end;

procedure TrzMonitor.SetdpyStart(const Value: int64);
begin
  FdpyStart := Value;
end;

procedure TrzMonitor.SetEnded(const Value: boolean);
begin
  FEnded := Value;
end;

procedure TrzMonitor.Setheight(const Value: integer);
begin
  Fheight := Value;
  display.Height := Value;
end;

procedure TrzMonitor.Setindex(const Value: integer);
begin
  Findex := Value;
  if findex>=flist.Count then findex := 0;
end;

procedure TrzMonitor.Setleft(const Value: integer);
begin
  Fleft := Value;
  display.Left := Value;
end;

procedure TrzMonitor.SetMonitorIdx(const Value: integer);
begin
  FMonitorIdx := Value;
end;

procedure TrzMonitor.SetMonitorType(const Value: TMonitorType);
begin
  FMonitorType := Value;
end;

procedure TrzMonitor.SetplayTimes(const Value: integer);
begin
  FplayTimes := Value;
end;

procedure TrzMonitor.SeTrzProgram(const Value: TrzProgram);
begin
  FrcProgram := Value;
end;

procedure TrzMonitor.SetSrcs(idx: integer; const Value: PSrcDefine);
begin
  if FList[idx]<>nil then Dispose(FList[idx]);
  FList[idx] := Value;
end;

procedure TrzMonitor.Settop(const Value: integer);
begin
  Ftop := Value;
  display.Top := Value;
end;

procedure TrzMonitor.Setwidth(const Value: integer);
begin
  Fwidth := Value;
  display.Width := Value;
end;

procedure TrzMonitor.Set_Start(const Value: Int64);
begin
  F_Start := Value;
end;

procedure TrzMonitor.Sort;
function SrcSort(Item1, Item2: Pointer): Integer;
begin
  if PSrcDefine(Item1)^.Sequence>PSrcDefine(Item2)^.Sequence then
     result := 1
  else
  if PSrcDefine(Item1)^.Sequence<PSrcDefine(Item2)^.Sequence then
     result := -1
  else
     result := 0;

end;
begin
  FList.Sort(@SrcSort);
end;


procedure TrzMonitor.TimerComplete(Sender: TObject);
begin
  PlayEnded;
end;

procedure TrzMonitor.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

{ TrzVideoMonitor }

procedure TrzVideoMonitor.Close;
begin
  display.Visible := false;
  Timer.Enabled := false;
  FilterGraph.ClearGraph;
  FilterGraph.Active := false;
  index := -1;
end;

constructor TrzVideoMonitor.Create(AOwner: TWinControl);
begin
  inherited;
  rcProgram := nil;
  FilterGraph := TFilterGraph.Create(nil);
  FilterGraph.OnGraphComplete := FilterGraphGraphComplete;
  display := TVideoWindow.Create(AOwner);
  with TVideoWindow(display) do
     begin
       Mode := vmVMR;
       FilterGraph := self.FilterGraph;
       VMROptions.KeepAspectRatio := false;
       //VMROptions.Mode := vmrWindowless;
       //FilterGraph := self.FilterGraph;
       Align := alNone;
       Parent := AOwner;
     end;
  MonitorType := mtVideo;
//  FilterGraph.Active := true;
  SendDebug('--------------------创建视屏--------------------',4);
end;

destructor TrzVideoMonitor.Destroy;
begin
  Close;
  FilterGraph.Free;
  display.Free;
  SendDebug('====================释放视屏====================',4);
  inherited;
end;

procedure TrzVideoMonitor.FilterGraphGraphComplete(sender: TObject;
  Result: HRESULT; Renderer: IBaseFilter);
begin
  PostMessage(Handle,WM_PLAY_END,0,0);
end;

procedure TrzVideoMonitor.GraphPausedEvent(sender: TObject;
  Result: HRESULT);
begin
  SendDebug('被暂停了',4);
  result := E_NOTIMPL;
end;

function TrzVideoMonitor.Open(src: PSrcDefine): boolean;
var
  hCurWindow,CurActiveWindow: HWnd;  // 窗口句柄
begin
  SendDebug('第'+inttostr(playTimes+1)+'次播放视屏<'+inttostr(index)+'>"'+src^.SourceId+'"',4);
  Cursrc := src;
  if not WaitForSendMessage then Exit;
  hCurWindow:=GetForegroundWindow();
  Timer.Enabled := false;
  display.Visible := true;
  if not FilterGraph.Active then FilterGraph.Active := true;
  if not WaitForSendMessage then Exit;
  FilterGraph.ClearGraph;
  if fileExists(src^.src) then
     begin
        if not WaitForSendMessage then Exit;
//        TVideoWindow(display).FilterGraph:= nil;
//        TVideoWindow(display).FilterGraph:= self.FilterGraph;
        FilterGraph.RenderFile(src^.src);
        if not WaitForSendMessage then Exit;
        if src^.volume>=0 then FilterGraph.Volume := src^.volume*100;
        FilterGraph.Play;
        dpyStart := GetTickCount div 1000;
        dpyLength := src^.srcLength;
        _Start := GetTickCount;
        CurActiveWindow:=GetForegroundWindow();
        if (GetActiveWindow()>0) and (CurActiveWindow<>hCurWindow) then
           begin
              SendDebug('窗口切换',4);
              ForceForegroundWindow(hCurWindow);
           end;
        result := true;
     end
  else
     Raise Exception.Create('"'+src^.src+'"视屏文件没找到');
  if rcProgram<>nil then
  begin
    Plays.WriteInteger(rcProgram.rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(MonitorIdx),index);
    Plays.WriteString('res',src^.SourceId,formatDatetime('YYYYMMDDHHNNSS',now()));
  end;
end;

procedure TrzVideoMonitor.Pause;
begin
  inherited;
  if not WaitForSendMessage then exit;
  FilterGraph.Pause;
end;

procedure TrzVideoMonitor.resume;
begin
  inherited;
//  if FilterGraph.State=gsStopped then
//     PostMessage(Handle,WM_PLAY_END,0,0)
//  else
//     begin
  try
    Close;
    Open(curSrc);
  except
    PostMessage(Handle,WM_PLAY_END,0,0);
    SendDebug('锁屏重播失败了',0);
  end;
//     end;
end;

function TrzVideoMonitor.WaitForSendMessage: boolean;
var
  _Start:Int64;
begin
  _Start := GetTickCount;
  result := true;
  while not Application.Terminated and InSendMessage() do
    begin
      Application.HandleMessage;
      sleep(1);
      if (GetTickCount-_Start)>10000 then
          begin
            SendDebug('等待sendMessage消息超时',4);
            PostMessage(Handle,WM_PLAY_END,0,0);
            result := false;
            break;
          end;
    end;
end;

procedure TrzVideoMonitor.WMPlayEnd(var Message: TMessage);
begin
  PlayEnded;
end;

{ TrzPhotoMonitor }

procedure TrzPhotoMonitor.Close;
begin
  inherited;
  Timer.Enabled := false;
  with TImage(display) do Picture := nil;
  display.Visible := false;
  Index := -1;
end;

constructor TrzPhotoMonitor.Create(AOwner: TWinControl);
begin
  inherited;
  display := TImage.Create(AOwner);
  with display do
    begin
      Align := alNone;
      Parent := AOwner;
    end;
  TImage(display).Stretch := true;
  MonitorType := mtPhoto;
  SendDebug('--------------------创建图片--------------------',4);
end;

destructor TrzPhotoMonitor.Destroy;
begin
  Close;
  display.Free;
  SendDebug('====================释放图片====================',4);
  inherited;
end;

function TrzPhotoMonitor.Open(src: PSrcDefine): boolean;
begin
  SendDebug('第'+inttostr(playTimes+1)+'次播放图片<'+inttostr(index)+'>"'+src^.SourceId+'"',4);
  Timer.Enabled := false;
  TImage(display).Picture.LoadFromFile(src^.src);
//  display.BringToFront;
  display.Visible := true;
  dpyStart := GetTickCount div 1000;
  dpyLength := src^.srcLength;
  _Start := GetTickCount;
  DoTimer;
  result := true;
  Plays.WriteInteger(rcProgram.rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(MonitorIdx),index);
  Plays.WriteString('res',src^.SourceId,formatDatetime('YYYYMMDDHHNNSS',now()));
end;

procedure TrzPhotoMonitor.Pause;
begin
  inherited;
end;

procedure TrzPhotoMonitor.resume;
begin
  inherited;
  DoTimer;
end;

{ TrzTextMonitor }

procedure TrzTextMonitor.Close;
begin
  inherited;
  Timer.Enabled := false;
  TRzMarqueeStatus(display).Caption := '';
  TRzMarqueeStatus(display).ScrollType := stNone;
  TRzMarqueeStatus(display).Scrolling := false;
  display.Visible := false;
  index := -1;
end;

constructor TrzTextMonitor.Create(AOwner: TWinControl);
begin
  inherited;
  display := TRzMarqueeStatus.Create(AOwner);
  with TRzMarqueeStatus(display) do
    begin
      Align := alNone;
      Parent := AOwner;
      frameStyle := fsNone;
    end;
  MonitorType := mtText;
  SendDebug('--------------------创建字幕--------------------',4);
end;

destructor TrzTextMonitor.Destroy;
begin
  Close;
  display.Free;
  SendDebug('====================释放字幕====================',4);
  inherited;
end;

function TrzTextMonitor.GetBackColor: TColor;
begin
  with TRzMarqueeStatus(display) do
    begin
       result := Color;
    end;
end;

function TrzTextMonitor.GetFont: TFont;
begin
  with TRzMarqueeStatus(display) do
    begin
      result := font;
    end;
end;

function TrzTextMonitor.GetScrollSpeed: integer;
begin
  with TRzMarqueeStatus(display) do
    begin
       result := ScrollDelay;
    end;
end;

function TrzTextMonitor.Open(src: PSrcDefine): boolean;
begin
  SendDebug('第'+inttostr(playTimes+1)+'次播放字幕<'+inttostr(index)+'>"'+src^.src+'"',4);
  Timer.Enabled := false;
  TRzMarqueeStatus(display).Caption := src^.src;
//  display.BringToFront;
  dpyStart := GetTickCount div 1000;
  dpyLength := src^.srcLength;
  with TRzMarqueeStatus(display) do
     begin
       Color := src^.BackColor;
       Font.Name := src^.FontName;
       Font.Color := src^.FontColor;
       Font.Size := src^.FontSize;
       case src^.CharSet of
       0:Font.Charset := 1;
       1:Font.Charset := 2;
       2:Font.Charset := 134;
       end;
       ScrollSpeed := src^.ScrollSpeed;
       case src^.Effect of
       0:ScrollType := stLeftToRight;
       1:ScrollType := stRightToLeft;
       2:begin
           ScrollType := stNone;
           Alignment := taCenter;
         end;
       end;
       Scrolling := true;
     end;
  _Start := GetTickCount;
  DoTimer;
  display.Visible := true;
  Plays.WriteInteger(rcProgram.rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(MonitorIdx),index);
  result := true;
end;

procedure TrzTextMonitor.Pause;
begin
  inherited;
  TRzMarqueeStatus(display).Scrolling := false;
end;

procedure TrzTextMonitor.resume;
begin
  inherited;
  TRzMarqueeStatus(display).Scrolling := true;
  DoTimer;
end;

procedure TrzTextMonitor.SetBackColor(const Value: TColor);
begin
  with TRzMarqueeStatus(display) do
    begin
       Color := Value;
    end;
end;

procedure TrzTextMonitor.SetFont(const Value: TFont);
begin
  with TRzMarqueeStatus(display) do
    begin
       font.Assign(Value); 
    end;
end;

procedure TrzTextMonitor.SetScrollSpeed(const Value: integer);
begin
  with TRzMarqueeStatus(display) do
    begin
       ScrollDelay := Value;
    end;
end;

{ TrzProgram }

procedure TrzProgram.Clear;
var i:integer;
begin
  for i:=Flist.Count -1 downto 0 do
    TObject(Flist[i]).Free;
  Flist.Clear;
  Active := false;
end;

procedure TrzProgram.Close;
var i:integer;
begin
  Timer.Enabled := false;
  for i:=0 to flist.Count -1 do
    begin
      TrzMonitor(flist[i]).Close;
    end;
end;

constructor TrzProgram.Create(AOwner: TWinControl;PlayList:TrzPlayList);
begin
  SendDebug('=============创建场景==============',4);
  Handle := AllocateHwnd(WndProc);
  rzPlayList := PlayList;
  FList := TList.Create;
  Parant := AOwner;
  Timer := TTimer.Create(nil);
  Timer.Enabled := false;
  Timer.OnTimer := TimerComplete;
  root := nil;
end;

destructor TrzProgram.Destroy;
begin
  if Handle <> 0 then DeallocateHWnd(Handle);
  Timer.Free;
  Clear;
  FList.Free;
  root := nil;
  inherited;
  SendDebug('=============释放场景==============',4);
end;

procedure TrzProgram.Open(root: IXMLDOMNode);
procedure AddVideo(root: IXMLDOMNode);
var
  Node:IXMLDOMNode;
  LayoutStartX,LayoutEndX,LayoutStartY,LayoutEndY:integer;
  Video:TrzVideoMonitor;
  Src:PSrcDefine;
  Volume:integer;
  myLen:integer;
begin
  LayoutStartX := StrtoIntDef(Root.selectSingleNode('layoutStartX').text,0);
  LayoutEndX := StrtoIntDef(Root.selectSingleNode('layoutEndX').text,0);
  LayoutStartY := StrtoIntDef(Root.selectSingleNode('layoutStartY').text,0);
  LayoutEndY := StrtoIntDef(Root.selectSingleNode('layoutEndY').text,0);
  if Root.selectSingleNode('volume')<>nil then
     Volume:= StrtoIntDef(Root.selectSingleNode('volume').text,-1)
  else
     Volume := -1;

  Video := TrzVideoMonitor.Create(Parant);
  Flist.Add(Video);
  Video.top := LayoutStartY;
  Video.left := LayoutStartX;
  Video.height := LayoutEndY-LayoutStartY;
  Video.width := LayoutEndX-LayoutStartX;
  Video.rcProgram := self;
  Video.MonitorIdx := Flist.Count -1 ;
  Node := Root.selectSingleNode('videoList');
  Node := Node.firstChild;
  myLen := 0;
  VedioLen := 0;
  while Node<>nil do
    begin
      if Node.nodeName='video' then
         begin
           new(src);
           src^.SourceId := Node.selectSingleNode('videoId').text;
           src^.Sequence := StrtoIntDef(Node.selectSingleNode('sequence').text,0);
           src^.volume := Volume;
           src^.src := AppData+'\res\vedio\'+Node.selectSingleNode('videoId').text+ExtractFileExt(Node.selectSingleNode('videoName').text);
           if Node.selectSingleNode('showTime')<>nil then
              src^.srcLength:= StrtoIntDef(Node.selectSingleNode('showTime').text,1)
           else
              src^.srcLength := 1;
           Video.AddSrc(src);
           myLen := myLen + src^.srcLength;
           VedioLen := VedioLen + src^.srcLength;
         end;
      Node := Node.nextSibling;
    end;
  if myLen>MonitorLen then MonitorLen := myLen;
  Video.Sort;
  if rzPlayList.PlayType = 0 then
     begin
      if (plays.ReadInteger(rzPlayList.rzFile.ProgramListId,'cache_playlist_index',-1)=rzPlayList.PlayListIndex)
          and
         (plays.ReadInteger(rzPlayList.rzFile.ProgramListId,'cache_program_index',-1)=ProgramIndex)
      then
         begin
           Video.Findex := Plays.readInteger(rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(flist.Count-1),0)-1;
           if Video.Findex >= (Video.SrcCount-1) then Video.Findex :=  -1;
         end;
     end;
end;
procedure AddMusic(root: IXMLDOMNode);
var
  Node:IXMLDOMNode;
  Music:TrzMusicMonitor;
  Src:PSrcDefine;
  Volume:integer;
  MusicLen,myLen:integer;
begin
  if Root.selectSingleNode('volume')<>nil then
     Volume:= StrtoIntDef(Root.selectSingleNode('volume').text,-1)
  else
     Volume := -1;

  Music := TrzMusicMonitor.Create(Parant);
  Flist.Add(Music);
  Music.rcProgram := self;
  Music.MonitorIdx := Flist.Count -1 ;
  Node := Root.selectSingleNode('musicList');
  Node := Node.firstChild;
  myLen := 0;
  MusicLen := 0;
  while Node<>nil do
    begin
      if Node.nodeName='music' then
         begin
           new(src);
           src^.SourceId := Node.selectSingleNode('musicId').text;
           src^.Sequence := StrtoIntDef(Node.selectSingleNode('sequence').text,0);
           src^.volume := Volume;
           src^.src := AppData+'\res\music\'+Node.selectSingleNode('musicId').text+ExtractFileExt(Node.selectSingleNode('musicName').text);
           if Node.selectSingleNode('musicLen')<>nil then
              src^.srcLength:= StrtoIntDef(Node.selectSingleNode('musicLen').text,1)
           else
              src^.srcLength := 1;
           Music.AddSrc(src);
           myLen := myLen + src^.srcLength;
           MusicLen := MusicLen + src^.srcLength;
         end;
      Node := Node.nextSibling;
    end;
  if myLen>MonitorLen then MonitorLen := myLen;
  Music.Sort;
  if rzPlayList.PlayType = 0 then
     begin
      if (plays.ReadInteger(rzPlayList.rzFile.ProgramListId,'cache_playlist_index',-1)=rzPlayList.PlayListIndex)
          and
         (plays.ReadInteger(rzPlayList.rzFile.ProgramListId,'cache_program_index',-1)=ProgramIndex)
      then
         begin
           Music.Findex := Plays.readInteger(rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(flist.Count-1),0)-1;
           if Music.Findex >= (Music.SrcCount-1) then Music.Findex :=  -1;
         end;
     end;
end;
procedure AddPhoto(root: IXMLDOMNode);
var
  Node:IXMLDOMNode;
  LayoutStartX,LayoutEndX,LayoutStartY,LayoutEndY:integer;
  Photo:TrzPhotoMonitor;
  Src:PSrcDefine;
  myLen:integer;
begin
  LayoutStartX := StrtoIntDef(Root.selectSingleNode('layoutStartX').text,0);
  LayoutEndX := StrtoIntDef(Root.selectSingleNode('layoutEndX').text,0);
  LayoutStartY := StrtoIntDef(Root.selectSingleNode('layoutStartY').text,0);
  LayoutEndY := StrtoIntDef(Root.selectSingleNode('layoutEndY').text,0);

  Photo := TrzPhotoMonitor.Create(Parant);
  Flist.Add(Photo);
  Photo.top := LayoutStartY;
  Photo.left := LayoutStartX;
  Photo.height := LayoutEndY-LayoutStartY;
  Photo.width := LayoutEndX-LayoutStartX;
  Photo.rcProgram := self;
  Photo.MonitorIdx := Flist.Count -1 ;
  myLen := 0;
  Node := Root.selectSingleNode('photoList');
  Node := Node.firstChild;
  while Node<>nil do
    begin
      if Node.nodeName='photo' then
         begin
           new(src);
           src^.SourceId := Node.selectSingleNode('photoId').text;
           src^.Sequence := StrtoIntDef(Node.selectSingleNode('sequence').text,0);
           src^.src := AppData+'\res\photo\'+Node.selectSingleNode('photoId').text+ExtractFileExt(Node.selectSingleNode('photoName').text);
           src^.srcLength := StrtoIntDef(Node.selectSingleNode('showTime').text,0);
           src^.Effect := StrtoIntDef(Node.selectSingleNode('effect').text,0);
           Photo.AddSrc(src);
           myLen := myLen + src^.srcLength;
         end;
      Node := Node.nextSibling;
    end;
  if myLen>MonitorLen then MonitorLen := myLen;
  Photo.Sort;
  if rzPlayList.PlayType = 0 then
    begin
      if (plays.ReadInteger(rzPlayList.rzFile.ProgramListId,'cache_playlist_index',-1)=rzPlayList.PlayListIndex)
          and
         (plays.ReadInteger(rzPlayList.rzFile.ProgramListId,'cache_program_index',-1)=ProgramIndex)
      then
         begin
           Photo.Findex := Plays.readInteger(rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(flist.Count-1),0)-1;
           if Photo.Findex >= (Photo.SrcCount-1) then Photo.Findex :=  -1;
         end;
    end;
end;
procedure AddText(root: IXMLDOMNode);
function ConvColor(s:string;def:integer):TColor;
var
  s1,s2,s3:string;
begin
  s1 := copy(s,1,2);
  s2 := copy(s,3,2);
  s3 := copy(s,5,2);
  result := StrtoIntDef('$'+s3+s2+s1,$ffff);
end;
var
  Node:IXMLDOMNode;
  LayoutStartX,LayoutEndX,LayoutStartY,LayoutEndY:integer;
  Text:TrzTextMonitor;
  Src:PSrcDefine;
  myLen:integer;
begin
  LayoutStartX := StrtoIntDef(Root.selectSingleNode('layoutStartX').text,0);
  LayoutEndX := StrtoIntDef(Root.selectSingleNode('layoutEndX').text,0);
  LayoutStartY := StrtoIntDef(Root.selectSingleNode('layoutStartY').text,0);
  LayoutEndY := StrtoIntDef(Root.selectSingleNode('layoutEndY').text,0);

  Text := TrzTextMonitor.Create(Parant);
  Flist.Add(Text);
  Text.top := LayoutStartY;
  Text.left := LayoutStartX;
  Text.height := LayoutEndY-LayoutStartY;
  Text.width := LayoutEndX-LayoutStartX;
  Text.rcProgram := self;
  Text.MonitorIdx := Flist.Count -1 ;
  myLen := 0;
  Node := Root.selectSingleNode('textList');
  Node := Node.firstChild;
  while Node<>nil do
    begin
      if Node.nodeName='text' then
         begin
           new(src);
           src^.SourceId := Node.selectSingleNode('textId').text;
           src^.Sequence := StrtoIntDef(Node.selectSingleNode('sequence').text,0);
           src^.src := Node.selectSingleNode('content').text;
           src^.srcLength := StrtoIntDef(Node.selectSingleNode('showTime').text,0);
           src^.Effect := StrtoIntDef(Node.selectSingleNode('effect').text,0);
           src^.FontSize := StrtoIntDef(Node.selectSingleNode('fontSize').text,12);
           src^.FontColor := ConvColor(Node.selectSingleNode('fontColor').text,$0);
           src^.BackColor := ConvColor(Node.selectSingleNode('backColor').text,$ffff);
           src^.ScrollSpeed := StrtoIntDef(Node.selectSingleNode('scrollSpeed').text,100);
           src^.FontName := Node.selectSingleNode('fontName').text;
           src^.CharSet := StrtoIntDef(Node.selectSingleNode('charSet').text,0);
           Text.AddSrc(src);
           myLen := myLen + src^.srcLength;
         end;
      Node := Node.nextSibling;
    end;
  if myLen>MonitorLen then MonitorLen := myLen;
  Text.Sort;
  if rzPlayList.PlayType=0 then
     begin
        if (plays.ReadInteger(rzPlayList.rzFile.ProgramListId,'cache_playlist_index',-1)=rzPlayList.PlayListIndex)
            and
           (plays.ReadInteger(rzPlayList.rzFile.ProgramListId,'cache_program_index',-1)=ProgramIndex)
        then
           begin
             Text.Findex := Plays.readInteger(rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(flist.Count-1),0)-1;
             if Text.Findex >= (Text.SrcCount-1) then Text.Findex :=  -1;
           end;
     end;
end;
var
  Node:IXMLDOMNode;
  ScreenSize:string;
  w:integer;
begin
  Clear;
  ScreenSize := Root.selectSingleNode('screenSize').text;
  w := pos('*',ScreenSize);
  ScreenWidth := StrtoIntDef(trim(copy(ScreenSize,1,w-1)),1024);
  ScreenHeight := StrtoIntDef(trim(copy(ScreenSize,w+1,255)),768);
  Parant.SetBounds(Parant.left,Parant.top,ScreenWidth,ScreenHeight);
  programCount := StrtoIntDef(Root.selectSingleNode('programCount').text,1);
  programLen := StrtoIntDef(Root.selectSingleNode('programLen').text,0);
  programSeq := StrtoIntDef(Root.selectSingleNode('programSeq').text,0);
  programId := Root.selectSingleNode('programId').text;
  //初始化图片
  Node := Root.selectSingleNode('photoElList');
  if Node<>nil then
     begin
        Node := Node.firstChild;
        while Node<>nil do
          begin
            if Node.nodeName='photoEl' then
               AddPhoto(Node);
            Node := Node.nextSibling;
          end;
     end;
  //初始化视屏
  Node := Root.selectSingleNode('videoElList');
  if Node<>nil then
     begin
        Node := Node.firstChild;
        while Node<>nil do
          begin
            if Node.nodeName='videoEl' then
               AddVideo(Node);
            Node := Node.nextSibling;
          end;
     end;
  //初始化音频
  Node := Root.selectSingleNode('musicElList');
  if Node<>nil then
     begin
        Node := Node.firstChild;
        while Node<>nil do
          begin
            if Node.nodeName='musicEl' then
               AddMusic(Node);
            Node := Node.nextSibling;
          end;
     end;
  //初始化文本
  Node := Root.selectSingleNode('textElList');
  if Node<>nil then
     begin
        Node := Node.firstChild;
        while Node<>nil do
          begin
            if Node.nodeName='textEl' then
               AddText(Node);
            Node := Node.nextSibling;
          end;
     end;
  active := true;
end;

procedure TrzProgram.Pause;
var
  i:integer;
begin
  Timer.Enabled := false;
  for i:=0 to flist.Count -1 do
    begin
      with TrzMonitor(flist[i]) do
        begin
          Pause;
        end;
    end;
end;

procedure TrzProgram.Play;
var
  i:integer;
  _playTimes:integer;
begin
  Timer.Enabled := false;
  if rzPlayList.playType=0 then
     _playTimes := Plays.readInteger(rzPlayList.rzFile.ProgramListId,'cache_program_length',0);
  SendDebug('第'+inttostr(rzPlayList.PlayTimes)+'次节目"'+programId+'" ====== 时长<'+inttostr(Timer.Interval)+'>微秒',4);
  ended := false;
  for i:=0 to flist.Count -1 do
    begin
      with TrzMonitor(flist[i]) do
        begin
          playTimes := _playTimes;
          if SrcCount<=0 then
             begin
               DoTimerNext;
               continue;
             end;
          //if index=0 then playTimes := 0;
          index := index+1;
          try
            Ended := false;
            if index<0 then index := 0;
            Open(srcs[index]);
          except
            on E:Exception do
               begin
                 SendDebug('播放出错了，软件自动清除非法节目<'+inttostr(index)+'>，原因："'+E.Message+'"',1);
                 DelSrc(srcs[index]);
                 DoTimerNext;
               end;
          end;
        end;
    end;
  _Start := GetTickCount;
  Timer.Enabled := true;
end;

function TrzProgram.PlayEnd: boolean;
var
  i:integer;
  myTimes:integer;
begin
  result := false;
  {
  if VedioLen=0 then //没有视屏时按最长资源
     begin
        if monitorLen<>0 then
           begin
             myTimes := programLen div monitorLen;
             if (programLen mod monitorLen)<>0 then inc(myTimes);
           end
        else
           myTimes := 0;
        Plays.WriteInteger(rzPlayList.rzFile.ProgramListId,'cache_program_Length',myTimes);
        for i:=0 to flist.Count-1 do
          begin
             if (TrzMonitor(flist[i]).playTimes<myTimes) and (TrzMonitor(flist[i]).SrcCount>0) then Exit;
          end;
     end
  else
     begin
        if VedioLen<>0 then
           begin
             myTimes := programLen div VedioLen;
             if (programLen mod VedioLen)<>0 then inc(myTimes);
           end
        else
           myTimes := 0;
        Plays.WriteInteger(rzPlayList.rzFile.ProgramListId,'cache_program_Length',myTimes);
        for i:=0 to flist.Count-1 do
          begin
             if (TrzMonitor(flist[i]).MonitorType=mtVideo) and (TrzMonitor(flist[i]).SrcCount>0) and (TrzMonitor(flist[i]).playTimes<myTimes) then Exit;
          end;
     end;
  }
  myTimes := 999999999;
  for i:=0 to flist.Count-1 do
    begin
       if VedioLen=0 then
          begin
            if  not ( (TrzMonitor(flist[i]).MonitorType<>mtMusic) or ((TrzMonitor(flist[i]).MonitorType=mtMusic) and (flist.Count=1))) then continue;
            if (TrzMonitor(flist[i]).playTimes<myTimes) then
               begin
                 myTimes := TrzMonitor(flist[i]).playTimes;
                 if rzPlayList.PlayType=0 then
                    Plays.WriteInteger(rzPlayList.rzFile.ProgramListId,'cache_program_Length',myTimes);
               end;
            if (TrzMonitor(flist[i]).SrcCount>0) and (TrzMonitor(flist[i]).playTimes<programCount) then Exit;
          end
       else
          begin
            if (TrzMonitor(flist[i]).MonitorType=mtVideo) and (TrzMonitor(flist[i]).playTimes<myTimes) then
               begin
                 myTimes := TrzMonitor(flist[i]).playTimes;
                 if rzPlayList.PlayType=0 then
                    Plays.WriteInteger(rzPlayList.rzFile.ProgramListId,'cache_program_Length',myTimes);
               end;
            if (TrzMonitor(flist[i]).MonitorType=mtVideo) and (TrzMonitor(flist[i]).SrcCount>0) and (TrzMonitor(flist[i]).playTimes<programCount) then Exit;
          end;
    end;
  result := true;
end;

function TrzProgram.PlayNext:boolean;
var i:integer;
begin
  result := PlayEnd;
  if result then
     begin
        for i:=0 to flist.Count -1 do
          begin
            with TrzMonitor(flist[i]) do
              begin
                Plays.DeleteKey(rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(i));
              end;
          end;
        Close;
        ended := true;
        if rzPlayList.PlayType=0 then
           Plays.WriteInteger(rzPlaylist.rzFile.ProgramListId,'cache_program_Length',0);
        //SendDebug('节目"'+programId+'" 播放结束',4);
        PostMessage(rzPlayList.Handle,WM_PLAY_END,0,0);
        //rzPlayList.PlayNext;
     end;
end;

procedure TrzProgram.resume;
var
  i:integer;
begin
  for i:=0 to flist.Count -1 do
    begin
      with TrzMonitor(flist[i]) do
        begin
          resume;
        end;
    end;
  Timer.Enabled := true;
end;

procedure TrzProgram.Setactive(const Value: boolean);
begin
  Factive := Value;
end;

procedure TrzProgram.Setended(const Value: boolean);
begin
  Fended := Value;
end;

procedure TrzProgram.SetMonitorLen(const Value: integer);
begin
  FMonitorLen := Value;
end;

procedure TrzProgram.SetProgramCount(const Value: integer);
begin
  FProgramCount := Value;
end;

procedure TrzProgram.SetProgramId(const Value: string);
begin
  FProgramId := Value;
end;

procedure TrzProgram.SetProgramIndex(const Value: integer);
begin
  FProgramIndex := Value;
end;

procedure TrzProgram.SetProgramLen(const Value: integer);
begin
  FProgramLen := Value;
  Timer.Interval := Value*1000;
end;

procedure TrzProgram.SetProgramSeq(const Value: integer);
begin
  FProgramSeq := Value;
end;

procedure TrzProgram.Setroot(const Value: IXMLDOMNode);
begin
  Froot := Value;
end;

procedure TrzProgram.SetScreenHeight(const Value: integer);
begin
  FScreenHeight := Value;
end;

procedure TrzProgram.SetScreenWidth(const Value: integer);
begin
  FScreenWidth := Value;
end;

procedure TrzProgram.SetVedioLen(const Value: integer);
begin
  FVedioLen := Value;
end;

procedure TrzProgram.Set_Start(const Value: int64);
begin
  F_Start := Value;
end;

procedure TrzProgram.TimerComplete(Sender: TObject);
begin

end;

procedure TrzProgram.WMPlayEnd(var Message: TMessage);
begin
  PlayNext;
end;

procedure TrzProgram.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

{ TrzPlayList }

procedure TrzPlayList.Clear;
var i:integer;
begin
  active := false;
  for i:=Flist.Count -1 downto 0 do
    TObject(Flist[i]).Free;
  Flist.Clear;
end;


procedure TrzPlayList.WriteToFile;
var
  F:TIniFile;
  filename:string;
  n:integer;
begin
  filename := AppData+'\data\'+formatDatetime('YYYYMMDD',now())+'.dat';
  F := TIniFile.Create(filename);
  try
    n := F.ReadInteger(rzFile.ProgramListId,PlayListId,0);
    F.WriteInteger(rzFile.ProgramListId,PlayListId,n+1);
  finally
    F.Free;
  end;
  SendDebug('>>'+rzFile.ProgramListId+'->PlayListId->'+inttostr(n+1)+'次',4);
end;
constructor TrzPlayList.Create(AOwner: TWinControl;AFile:TrzFile);
begin
  SendDebug('---------========创建节目========--------',4);
  Handle := AllocateHwnd(WndProc);
  FList := TList.Create;
  Timer := TTimer.Create(nil);
  Timer.Enabled := false;
//  Timer.OnTimer := TimerComplete;
  rzFile := AFile;
  Parant := AOwner;
  curProgram := nil;
  findex := -1;
  fEnded := false;
end;

destructor TrzPlayList.Destroy;
begin
  if Handle <> 0 then DeallocateHWnd(Handle);
  Timer.Free;
  curProgram := nil;
  Clear;
  FList.Free;
  inherited;
  SendDebug('---------========释放节目========--------',4);
end;

procedure TrzPlayList.Open(root: IXMLDOMNode);
var
  Node:IXMLDOMNode;
  prog:TrzProgram;
  i:integer;
begin
  PlayListId := Root.selectSingleNode('playId').text;
  PlayListLen := StrtoIntDef(Root.selectSingleNode('playLen').text,0);
  PlayCount := StrtoIntDef(Root.selectSingleNode('playCount').text,0);
  PlayType := StrtoIntDef(Root.selectSingleNode('type').text,0);
  StartTime := Root.selectSingleNode('startTime').text;
  PlayListSeq := StrtoIntDef(Root.selectSingleNode('playSeq').text,0);
  if PlayType=1 then FNearTime := Plays.ReadString(rzFile.ProgramListId,'cache_timer_'+PlayListId,'');
  ProgramLen := 0;
  Node := Root.selectSingleNode('programList');
  Node := Node.firstChild;
  while Node<>nil do
    begin
      if Node.nodeName='program' then
         begin
           prog := TrzProgram.Create(Parant,self);
           Flist.Add(prog);
           prog.root := Node;
           prog.ProgramId := Node.selectSingleNode('programId').text;
           prog.ProgramLen := StrtoIntDef(Node.selectSingleNode('programLen').text,0);
           ProgramLen := ProgramLen + prog.ProgramLen;
           prog.ProgramSeq := StrtoIntDef(Node.selectSingleNode('programSeq').text,0);
           prog.ProgramIndex := flist.Count - 1;
         end;
      Node := Node.nextSibling;
    end;
  Sort;
  for i:=0 to flist.count-1 do TrzProgram(flist[i]).ProgramIndex := i;
  active := true;
end;

procedure TrzPlayList.SetPlayListId(const Value: string);
begin
  FPlayListId := Value;
end;

procedure TrzPlayList.SetPlayListLen(const Value: integer);
begin
  FPlayListLen := Value;
  Timer.Interval := Value*1000;
end;

procedure TrzPlayList.SetPlayType(const Value: integer);
begin
  FPlayType := Value;
end;

procedure TrzPlayList.SetPlayListSeq(const Value: integer);
begin
  FPlayListSeq := Value;
end;

procedure TrzPlayList.SetStartTime(const Value: string);
begin
  FStartTime := Value;
end;

procedure TrzPlayList.Play;
var
  pProgram:TrzProgram;
begin
  if flist.Count=0 then Exit;
  if ended then
     begin
       Timer.Enabled := false;
       ended := false; //如果已经结束，打开重播放
       PlayTimes := 0;
       SendDebug('>>>>>>>播表<'+inttostr(rzFile.index)+'> ===== 时长<'+inttostr(Timer.Interval)+'>微秒',4);
     end;
  pProgram := curProgram;
  if curProgram=nil then
     begin
       curProgram := TrzProgram(flist[0]);
       index := 0;
     end
  else
     begin
       index := index + 1;
       if findex>=flist.Count then
          begin
            findex := -1;
          end;
       if index<0 then index := 0;
       curProgram := TrzProgram(flist[index]);
     end;
//  if not Timer.Enabled then
     begin
       //if ProgramLen>0 then
       if PlayType = 0 then
          playTimes := Plays.readInteger(rzFile.ProgramListId,'cache_playlist_length',0);
       //Timer.Interval := FPlayListLen*1000 - Plays.readInteger(rzFile.ProgramListId,'cache_playlist_length',0);
     end;
  if pProgram<>curProgram then
     begin
       if pProgram<>nil then
          begin
            pProgram.Close;
            pProgram.Clear;
          end;
       //Close;
       if not curProgram.active then
          curProgram.Open(curProgram.root);
       curProgram.Play;
     end
  else
     begin
       //curProgram.Close;
       if not curProgram.active then
          curProgram.Open(curProgram.root);
       curProgram.Play;
     end;
  if not Timer.Enabled then
     begin
       NearTime := formatDatetime('YYYY-MM-DD HH:NN:SS',now());
       _Start := GetTickCount;
       Timer.Enabled := (Timer.Interval>0);
     end;
end;

procedure TrzPlayList.Close;
var i:integer;
begin
  Timer.Enabled := false;
  for i:=0 to FList.Count -1 do
     begin
        TrzProgram(Flist[i]).Close;
        TrzProgram(Flist[i]).Clear;
     end;
//  findex := -1;
//  if assigned(curProgram) then
//     begin
//       curProgram.Close;
//       curProgram.Clear;
//     end;
//  Ended := true;
end;

procedure TrzPlayList.TimerComplete(Sender: TObject);
begin
  if PlayEnd then
     begin
       //SendDebug('第'+inttostr(playTimes+1)+'次播放"'+PlayListId+'"播表完毕',4);
       WriteToFile;
       Close;
       index := -1;
       playTimes := 0;
       //Plays.WriteInteger(rzFile.ProgramListId,'cache_playlist_Length',0);
       if playType=0 then
          Plays.WriteInteger(rzFile.ProgramListId,'cache_program_Length',0);
       Ended := true;
     end
  else
     begin
       Timer.Interval := 1000;
       Timer.Enabled := false;
       Timer.Enabled := true;
     end;
end;

procedure TrzPlayList.Setindex(const Value: integer);
begin
  Findex := Value;
  if playType=0 then
     begin
        if Value<0 then
        Plays.DeleteKey(rzFile.ProgramListId,'cache_program_index') else
        Plays.WriteInteger(rzFile.ProgramListId,'cache_program_index',value);
     end;
end;

procedure TrzPlayList.SetEnded(const Value: boolean);
begin
  FEnded := Value;
end;

procedure TrzPlayList.SetNearTime(const Value: string);
begin
  FNearTime := Value;
  if (PlayType=1) then Plays.WriteString(rzFile.ProgramListId,'cache_timer_'+PlayListId,Value);
end;

procedure TrzPlayList.Pause;
begin
  if curProgram=nil then Exit;
  curProgram.Pause;
end;

procedure TrzPlayList.resume;
begin
  if curProgram=nil then Exit;
  curProgram.resume;
end;

procedure TrzPlayList.PlayNext;
begin
//  SendDebug('第'+inttostr(playTimes+1)+'次播放"'+curProgram.ProgramId+'"节目完毕',4);
  if index>=(flist.Count-1) then PlayTimes := PlayTimes + 1;
  if PlayEnd then
       TimerComplete(nil)
    else
       begin
         Close;
         Play;
       end;
end;

procedure TrzPlayList.Setactive(const Value: boolean);
begin
  Factive := Value;
end;

procedure TrzPlayList.Sort;
function SrcSort(Item1, Item2: Pointer): Integer;
begin
  if TrzProgram(Item1).ProgramSeq>TrzProgram(Item2).ProgramSeq then
     result := 1
  else
  if TrzProgram(Item1).ProgramSeq<TrzProgram(Item2).ProgramSeq then
     result := -1
  else
     result := 0;

end;
begin
  FList.Sort(@SrcSort);
end;

procedure TrzPlayList.SetPlayListIndex(const Value: integer);
begin
  FPlayListIndex := Value;
end;

procedure TrzPlayList.Set_Start(const Value: Int64);
begin
  F_Start := Value;
end;

function TrzPlayList.reLoad:boolean;
begin
 if (playType=0) and (Plays.readInteger(rzFile.ProgramListId,'cache_playlist_index',-1)=rzFile.index) then
    begin
      findex := Plays.ReadInteger(rzFile.ProgramListId,'cache_program_index',0)-1;
      if FIndex>=0 then curProgram := TrzProgram(FList[Index]);
      result := true;
    end
 else
    result := false;
end;

procedure TrzPlayList.SetPlayTimes(const Value: integer);
begin
  FPlayTimes := Value;
  if playType=0 then
     Plays.WriteInteger(rzFile.ProgramListId,'cache_playlist_Length',PlayTimes);
end;

procedure TrzPlayList.SetProgramLen(const Value: integer);
begin
  FProgramLen := Value;
end;

function TrzPlayList.PlayEnd: boolean;
var
  myTimes:integer;
begin
{  if programLen=0 then
     begin
       myTimes := playlistLen div programLen;
       if (playlistLen mod programLen)<>0 then inc(myTimes);
     end
  else
     myTimes := 1;
}
  result := playTimes>=playCount;
end;

procedure TrzPlayList.SetPlayCount(const Value: integer);
begin
  FPlayCount := Value;
end;

procedure TrzPlayList.WMPlayEnd(var Message: TMessage);
begin
  PlayNext;
end;

procedure TrzPlayList.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

{ TrzFile }

procedure TrzFile.Clear;
var i:integer;
begin
  Active := false;
  for i:=Flist.Count -1 downto 0 do
    TObject(Flist[i]).Free;
  Flist.Clear;
  xmlDoc := nil;
end;

procedure TrzFile.Close;
var i:integer;
begin
  Timer.Enabled := false;
  for i:=0 to FList.Count-1 do
     begin
       TrzPlayList(FList[i]).Close;
     end;
//  findex := -1;
//  if assigned(curPlayList) then curPlayList.Close;
end;

constructor TrzFile.Create(AOwner: TWinControl);
begin
  FList := TList.Create;
  Timer := TTimer.Create(nil);
  Timer.Enabled := false;
  Timer.Interval := 1000;
  Timer.OnTimer := TimerComplete;
  Parant := AOwner;
  curPlayList := nil;
  findex := -1;
  playLen := 0;
end;

destructor TrzFile.Destroy;
begin
  Timer.Free;
  Clear;
  FList.Free;
  inherited;
end;

procedure TrzFile.DoTimer;
begin
  
end;

procedure TrzFile.Open(filename: string);
var
  node:IXMLDOMNode;
  playList:TrzPlayList;
  i:integer;
begin
  ffilename := filename;
  SendDebug('打开文件"'+filename+'"',4);
  Clear;
  xmlDoc := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  xmlDoc.load(filename);
  node := xmlDoc.documentElement;
  ProgramListId := node.selectSingleNode('playbillId').text;
//  Period := StrtoIntDef(node.selectSingleNode('period').text,0);
  StartDate := node.selectSingleNode('starteDate').text;
  EndDate := node.selectSingleNode('endDate').text;
  ProgramListType := StrtoIntDef(node.selectSingleNode('playbillType').text,0);
  node := node.selectSingleNode('playList');
  node := node.firstChild;
  while node<>nil do
    begin
      if node.nodeName='play' then
         begin
           playList := TrzPlayList.Create(Parant,self);
           flist.Add(playList);
           playList.Open(Node);
         end;
      node := node.nextSibling;
    end;
  Sort;
  for i:=0 to flist.count-1 do TrzPlaylist(flist[i]).PlayListIndex := i;
//  if curPlayList.PlayType = 0 then
     begin
      findex := plays.ReadInteger(ProgramListId,'cache_playlist_index',-1);
      if index>=0 then
         begin
           curPlayList :=  TrzPlaylist(flist[index]);
           if curPlayList.PlayType<>0 then curPlayList.Ended := true else
              begin
                curPlayList.Ended := (curPlayList.FList.Count=0);
              end;
         end;
     end;
  Active := true;
end;

procedure TrzFile.Pause;
begin
  if curPlayList<>nil then curPlayList.Pause;
end;

procedure TrzFile.Play(CallBacked:boolean=false);
begin
  if flist.Count=0 then Exit;
  if (index<=0) then SendDebug('节目单>>>>>>>>>>>>>>>>>>>>>>>>>>"'+ProgramListId+'"',4);
  if curPlayList=nil then index := -1
  else
     begin
        if (curPlaylist.PlayType=0) and not curPlaylist.Ended then //如果正常播表没有播继续播
           begin
             SendDebug('复播播表--<'+inttostr(index)+'>--播表"'+curPlaylist.PlayListId+'"',4);
             if not curPlayList.reload then
                if curPlaylist.findex>=0 then curPlaylist.findex := curPlaylist.findex -1;
             curPlaylist.Play;
             if PlayStatus<>psPlaying then PlayStatus := psPlaying;
             Timer.Enabled := true;
             Exit;
           end
        else
           begin
             if not CallBacked then Timer.OnTimer(Timer);
             if Index<0 then Exit;
           end;
     end;
   Plays.WriteInteger(ProgramListId,'cache_playlist_Length',0);
   Plays.WriteInteger(ProgramListId,'cache_program_Length',0);
{  if curPlayList=nil then
     begin
       curPlayList := TrzPlayList(flist[0]);
       index := 0;
     end
  else
     begin
       index := index + 1;
       if index<0 then index := 0;
       curPlayList := TrzPlayList(flist[index]);
       if curPlayList.PlayType=1
     end;
  curPlayList.Play;}

  if PlayStatus<>psPlaying then PlayStatus := psPlaying;
  Timer.Enabled := true;

end;

procedure TrzFile.rePlay;
var
  i:integer;
begin
  if not assigned(curPlaylist) then Exit;
  if not assigned(curPlaylist.curProgram) then Exit;
  for i:=0 to curPlaylist.curProgram.FList.Count -1 do
    begin
      if TrzMonitor(curPlaylist.curProgram.FList[i]).MonitorType = mtVideo then
         TrzMonitor(curPlaylist.curProgram.FList[i]).resume;
    end;
end;

procedure TrzFile.resume;
begin
  if curPlayList<>nil then curPlayList.resume;
end;

procedure TrzFile.SetActive(const Value: boolean);
begin
  FActive := Value;
end;

procedure TrzFile.SetEndDate(const Value: string);
begin
  FEndDate := Value;
end;

procedure TrzFile.Setfilename(const Value: string);
begin
  Ffilename := Value;
end;

procedure TrzFile.Setindex(const Value: integer);
begin
  Findex := Value;
  if Value<0 then
  plays.DeleteKey(ProgramListId,'cache_playlist_index') else
     begin
       if TrzPlayList(flist[value]).playType=0 then
          plays.WriteInteger(ProgramListId,'cache_playlist_index',Value)
     end;
end;

procedure TrzFile.SetPeriod(const Value: integer);
begin
  FPeriod := Value;
end;

procedure TrzFile.SetPlayStatus(const Value: TPlayStatus);
var i:integer;
begin
  FPlayStatus := Value;
  if PlayStatus in [psPlaying] then
     begin
       for i:=0 to flist.Count -1 do
         begin
           TrzPlayList(flist[i]).Ended := false;
         end;
       //findex := -1;
     end;
  if PlayStatus = psEnded then
     begin
       if Assigned(curPlayList) and (curPlayList.PlayType=0) then
          Plays.WriteInteger(ProgramListId,'cache_playlist_Length',0);
       if Assigned(curPlayList) and (curPlayList.PlayType=0) and Assigned(curPlayList.curProgram) then
          begin
            Plays.WriteInteger(ProgramListId,'cache_program_Length', 0);
          end;
     end;
end;

procedure TrzFile.SetProgramListId(const Value: string);
begin
  FProgramListId := Value;
end;

procedure TrzFile.SetProgramListType(const Value: integer);
begin
  FProgramListType := Value;
end;

procedure TrzFile.SetStartDate(const Value: string);
begin
  FStartDate := Value;
end;

procedure TrzFile.Sort;
function SrcSort(Item1, Item2: Pointer): Integer;
begin
  if TrzPlayList(Item1).PlayListSeq>TrzPlayList(Item2).PlayListSeq then
     result := 1
  else
  if TrzPlayList(Item1).PlayListSeq<TrzPlayList(Item2).PlayListSeq then
     result := -1
  else
     result := 0;

end;
begin
  FList.Sort(@SrcSort);
end;

procedure TrzFile.TimerComplete(Sender: TObject);
var
  i:integer;
  hasPlay:boolean;
begin
  if flist.Count=0 then exit;
  if SLocked then Exit;
  inc(playLen);
  if (playlen mod 60)=0 then
     begin
       WriteToFile;
     end;
  hasPlay := false;
  if Assigned(curPlayList) and (curPlayList.PlayType=1) and not curPlayList.Ended then Exit;

  //检查是否有定时播表
  for i:=0 to flist.Count -1 do
    begin
      if TrzPlayList(flist[i]).PlayType = 1 then //定时播表
         begin
           if
           (    copy(TrzPlayList(flist[i]).NearTime,1,10)
                =
                formatDatetime('YYYY-MM-DD',now())
           )
           then continue else
              begin
                if (TrzPlayList(flist[i]).StartTime>=formatDatetime('HH:NN:SS',now())) then
                   TrzPlayList(flist[i]).Ended := false;
              end;

           if (TrzPlayList(flist[i]).StartTime<formatDatetime('HH:NN:SS',now())) then
              begin
                if TrzPlayList(flist[i])<>curPlayList then
                   begin
                     if Assigned(curPlayList) then curPlayList.Close;
                     curPlayList := TrzPlayList(flist[i]);
                     SendDebug('定时播表--<'+inttostr(i)+'>--"'+curPlaylist.PlayListId+'"',4);
                     curPlayList.Close;
                     curPlayList.Play;
                     exit;
                   end;
              end;
         end
      else
         hasPlay := true;
    end;
  if (index<0) or not( Assigned(curPlayList) and not curPlayList.Ended) then
     begin
       if Assigned(curPlayList) and (curPlayList.PlayType=1) and (index>=0) then //加上定时还原
          begin
            curPlayList.Close;
            curPlayList := TrzPlayList(flist[index]);
            curPlayList.Ended := false;
            Play(false);
            Exit;
          end;
       if (index=(flist.Count-1)) then
          begin
            SendDebug('节目单<<<<<<<<<<<<<<<<<<<<<<<<<<"'+ProgramListId+'"',4);
            PlayStatus := psEnded;
            index := -1;
            curPlayList.Close;
            postmessage(Parant.Handle,WM_PLAY_ENDING,integer(self),0);
            Exit;
          end;
       index := index+1;
       if findex>=flist.Count then index := -1;
       if index<0 then index := 0;
       if TrzPlayList(flist[index]).PlayType=0 then
          begin
            curPlayList := TrzPlayList(flist[index]);
            curPlayList.close;
            //SendDebug('播放播表<'+inttostr(index)+'>>>>>>>>>>>>>>>>>"'+curPlaylist.PlayListId+'"',4);
            curPlayList.Play;
          end
       else
          if hasPlay then Play(false);
     end;
end;

procedure TrzFile.WriteToFile;
var
  F:TIniFile;
  filename:string;
  mLen,pLen:integer;
begin
  filename := AppData+'\data\'+formatDatetime('YYYYMMDD',now())+'.dat';
  F := TIniFile.Create(filename);
  try
    dayPlayFile := filename;
    mLen := F.ReadInteger('playLength','maxLength',0);
    if (playLen div 60)>mLen then mLen := (playLen div 60)-1;
    pLen := F.ReadInteger('playLength','Length',0);
    F.WriteInteger('playLength','maxLength',mLen+1);
    F.WriteInteger('playLength','Length',pLen+1);
  finally
    F.Free;
  end;
  SendDebug('>>dayLength->maxLength->'+inttostr(mLen+1)+'分',4);
  SendDebug('>>dayLength->Length->'+inttostr(pLen+1)+'分',4);
end;

{ TrzPlayIni }

constructor TrzPlayIni.Create;
var
  Buf:array [0..255] of char;
begin
  inherited;
  InitializeCriticalSection(FThreadLock);
  AppPath := ExtractFilePath(ParamStr(0));
  fillchar(Buf,256,0);
  GetEnvironmentVariable('ALLUSERSPROFILE',Buf,256);
  AppData := Buf+'\rzico';
  if AppData='' then AppData := AppPath;
  F := TIniFile.Create(AppData+'\adv\plays.ini');
end;

procedure TrzPlayIni.EraseSection(Section: string);
begin
  Enter;
  try
    F.EraseSection(Section);
    F.UpdateFile;
  finally
    Leave;
  end;
end;

destructor TrzPlayIni.Destroy;
begin
  DeleteCriticalSection(FThreadLock);
  F.Free;
  inherited;
end;

function TrzPlayIni.readInteger(Section, Ident: string; default: integer): integer;
begin
  Enter;
  try
    result := F.ReadInteger(Section,Ident,Default);
  finally
    Leave;
  end;
end;

procedure TrzPlayIni.ReadSections(Strings: TStrings);
begin
  Enter;
  try
    F.ReadSections(Strings);
  finally
    Leave;
  end;
end;

function TrzPlayIni.readString(Section, Ident, default: string): string;
begin
  Enter;
  try
    result := F.ReadString(Section,Ident,Default);
  finally
    Leave;
  end;
end;

procedure TrzPlayIni.WriteInteger(Section, Ident: string;
  default: integer);
begin
  Enter;
  try
    F.WriteInteger(Section, Ident, default);
    F.UpdateFile;
  finally
    Leave;
  end;
end;

procedure TrzPlayIni.WriteString(Section, Ident, default: string);
begin
  Enter;
  try
    F.WriteString(Section, Ident, default);
    F.UpdateFile;
  finally
    Leave;
  end;
end;

procedure TrzPlayIni.DeleteKey(Section, Ident: string);
begin
  Enter;
  try
    F.DeleteKey(Section, Ident);
    F.UpdateFile;
  finally
    Leave;
  end;
end;

procedure TrzPlayIni.Enter;
begin
  EnterCriticalSection(FThreadLock);
end;

procedure TrzPlayIni.Leave;
begin
  LeaveCriticalSection(FThreadLock);
end;

{ TrzMusicMonitor }

procedure TrzMusicMonitor.Close;
begin
  Timer.Enabled := false;
  FilterGraph.ClearGraph;
  FilterGraph.Active := False;
  index := -1;
  inherited;

end;

constructor TrzMusicMonitor.Create(AOwner: TWinControl);
begin
  inherited;
  FilterGraph := TFilterGraph.Create(nil);
  FilterGraph.OnGraphComplete := FilterGraphGraphComplete;
  MonitorType := mtMusic;
//  FilterGraph.Active := true;
  SendDebug('--------------------创建音频--------------------',4);
end;

destructor TrzMusicMonitor.Destroy;
begin
  Close;
  FilterGraph.Free;
  SendDebug('====================释放音频====================',4);

  inherited;
end;

procedure TrzMusicMonitor.FilterGraphGraphComplete(sender: TObject;
  Result: HRESULT; Renderer: IBaseFilter);
begin
  PostMessage(Handle,WM_PLAY_END,0,0);

end;

function TrzMusicMonitor.Open(src: PSrcDefine): boolean;
begin
  SendDebug('第'+inttostr(playTimes+1)+'次播放音频<'+inttostr(index)+'>"'+src^.SourceId+'"',4);
  Cursrc := src;
  Timer.Enabled := false;
  if not FilterGraph.Active then FilterGraph.Active := true;
  FilterGraph.ClearGraph;
  if fileExists(src^.src) then
     begin
        FilterGraph.RenderFile(src^.src);
        if src^.volume>=0 then FilterGraph.Volume := src^.volume*100;
        FilterGraph.Play;
        dpyStart := GetTickCount div 1000;
        dpyLength := src^.srcLength;
        _Start := GetTickCount;
        result := true;
     end
  else
     Raise Exception.Create('"'+src^.src+'"音频文件没找到');
  Plays.WriteInteger(rcProgram.rzPlayList.rzFile.ProgramListId,'cache_ei_'+inttostr(MonitorIdx),index);
  Plays.WriteString('res',src^.SourceId,formatDatetime('YYYYMMDDHHNNSS',now()));
end;

procedure TrzMusicMonitor.Pause;
begin
  inherited;
  FilterGraph.Pause;
end;

procedure TrzMusicMonitor.resume;
begin
  inherited;
  try
    Close;
    Open(curSrc);
  except
    PostMessage(Handle,WM_PLAY_END,0,0);
    SendDebug('锁屏重播失败了',0);
  end;
end;

procedure TrzMusicMonitor.WMPlayEnd(var Message: TMessage);
begin
  PlayEnded;

end;

initialization
  if not hExists then
     Plays := TrzPlayIni.Create;
finalization
  if not hExists then
     Plays.Free;
end.
