unit RcCtrls;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,RzCommon,
  Dialogs, StdCtrls,MultiMon, DirectShow9, ActiveX,ComObj, DSUtil, RzPanel, ExtCtrls, RzStatus, DSPack, Marquee,
  jpeg,msxml;
const
  WM_PLAY_ENDING=WM_USER+3000;
type
  TMonitorType=(mtNone,mtPhoto,mtText,mtVideo);
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
  end;
  TrcProgram=class;
  TrcMonitor=class
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
    FrcProgram: TrcProgram;
    procedure Setheight(const Value: integer);
    procedure Setleft(const Value: integer);
    procedure Settop(const Value: integer);
    procedure Setwidth(const Value: integer);
    procedure SetdpyLength(const Value: int64);
    procedure SetdpyStart(const Value: int64);
    function GetSrcs(idx: integer): PSrcDefine;
    procedure SetSrcs(idx: integer; const Value: PSrcDefine);
    procedure Setindex(const Value: integer);
    function GetSrcCount: integer;
    procedure SetMonitorType(const Value: TMonitorType);
    procedure SetrcProgram(const Value: TrcProgram);
  protected
    procedure PlayEnded;virtual;
    procedure TimerComplete(Sender:TObject);
  public
    constructor Create(AOwner: TWinControl); virtual;
    destructor Destroy; override;

    function Open(src:PSrcDefine):boolean;virtual;
    procedure Pause;virtual;
    procedure resume;virtual;
    procedure Close;virtual;
    procedure Clear;
    procedure AddSrc(src:PSrcDefine);
    procedure DelSrc(src:PSrcDefine);
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
    property rcProgram:TrcProgram read FrcProgram write SetrcProgram;
  end;
  TrcVideoMonitor=class(TrcMonitor)
  private
    FilterGraph:TFilterGraph;
    procedure FilterGraphGraphComplete(sender: TObject;Result: HRESULT; Renderer: IBaseFilter);
  public
    function Open(src:PSrcDefine):boolean;override;
    procedure Close;override;
    procedure Pause;override;
    procedure resume;override;
    
    constructor Create(AOwner: TWinControl); override;
    destructor Destroy; override;
  end;
  TrcPhotoMonitor=class(TrcMonitor)
  private
  public
    function Open(src:PSrcDefine):boolean;override;
    procedure Pause;override;
    procedure resume;override;
    procedure Close;override;
    constructor Create(AOwner: TWinControl); override;
    destructor Destroy; override;
  end;
  TrcTextMonitor=class(TrcMonitor)
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

  TrcProgram=class
  private
    Parant:TWinControl;
    FList:TList;
    FProgramLen: integer;
    FProgramSeq: integer;
    FProgramId: string;
    FScreenWidth: integer;
    FScreenHeight: integer;
    Froot: IXMLDOMNode;
    procedure SetProgramId(const Value: string);
    procedure SetProgramLen(const Value: integer);
    procedure SetProgramSeq(const Value: integer);
    procedure SetScreenHeight(const Value: integer);
    procedure SetScreenWidth(const Value: integer);
    procedure Setroot(const Value: IXMLDOMNode);
  public
    constructor Create(AOwner: TWinControl);
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
    property ScreenWidth:integer read FScreenWidth write SetScreenWidth;
    property ScreenHeight:integer read FScreenHeight write SetScreenHeight;
    property root:IXMLDOMNode read Froot write Setroot;
  end;

  TrcPlayList=class
  private
    Parant:TWinControl;
    FList:TList;
    FStartTime: string;
    FPlayType: integer;
    FPlayListLen: integer;
    FPlayListSeq: integer;
    FPlayListId: string;
    curProgram:TrcProgram;
    Timer:TTimer;
    Findex: integer;
    FEnded: boolean;
    FNearTime: string;
    procedure SetPlayListId(const Value: string);
    procedure SetPlayListLen(const Value: integer);
    procedure SetPlayType(const Value: integer);
    procedure SetPlayListSeq(const Value: integer);
    procedure SetStartTime(const Value: string);
    procedure Setindex(const Value: integer);
    procedure SetEnded(const Value: boolean);
    procedure SetNearTime(const Value: string);
  protected
    procedure TimerComplete(Sender:TObject);
  public
    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
    procedure Clear;
    //引导节目
    procedure Open(root:IXMLDOMNode);
    procedure Close;
    procedure Play;
    procedure Pause;
    procedure resume;
    
    property PlayListId:string read FPlayListId write SetPlayListId;
    property PlayListLen:integer read FPlayListLen write SetPlayListLen;
    property PlayType:integer read FPlayType write SetPlayType;
    property StartTime:string read FStartTime write SetStartTime;
    property PlayListSeq:integer read FPlayListSeq write SetPlayListSeq;
    property index:integer read Findex write Setindex;
    property Ended:boolean read FEnded write SetEnded;
    //最近播时时间
    property NearTime:string read FNearTime write SetNearTime;
  end;


  TrcFile=class
  private
    Parant:TWinControl;
    FList:TList;
    Timer:TTimer;
    Findex: integer;
    curPlayList:TrcPlayList;
    xmlDoc:IXMLDomDocument;
    FProgramListType: integer;
    FPeriod: integer;
    FEndDate: string;
    FStartDate: string;
    FProgramListId: string;
    Fended: boolean;
    procedure Setindex(const Value: integer);
    procedure SetEndDate(const Value: string);
    procedure SetPeriod(const Value: integer);
    procedure SetProgramListId(const Value: string);
    procedure SetProgramListType(const Value: integer);
    procedure SetStartDate(const Value: string);
    procedure Setended(const Value: boolean);
  protected
    procedure TimerComplete(Sender:TObject);
  public
    constructor Create(AOwner: TWinControl);
    destructor Destroy; override;
    procedure Clear;
    //引导节目
    procedure Open(filename:string);
    procedure Close;
    procedure Play;
    procedure Pause;
    procedure resume;

    property index:integer read Findex write Setindex;
    property ProgramListId:string read FProgramListId write SetProgramListId;
    property Period:integer read FPeriod write SetPeriod;
    property StartDate:string read FStartDate write SetStartDate;
    property EndDate:string read FEndDate write SetEndDate;
    property ProgramListType:integer read FProgramListType write SetProgramListType;
    property ended:boolean read Fended write Setended;
  end;
implementation

{ TrcMonitor }

procedure TrcMonitor.AddSrc(src: PSrcDefine);
begin
  FList.Add(src); 
end;

procedure TrcMonitor.Clear;
var
  i:integer;
begin
  for i:=Flist.Count -1 downto 0 do
    begin
      dispose(Flist[i]);
    end;
  Flist.Clear;
end;

procedure TrcMonitor.Close;
begin
  index := -1;
end;

constructor TrcMonitor.Create(AOwner: TWinControl);
begin
  Parant :=  AOwner;
  FList := TList.Create;
  dpyLength := 0;
  Timer := TTimer.Create(nil);
  Timer.Enabled := false;
  Timer.OnTimer := TimerComplete;
  findex := -1;
end;

procedure TrcMonitor.DelSrc(src: PSrcDefine);
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

destructor TrcMonitor.Destroy;
begin
  Timer.Free;
  Clear;
  FList.Free;
  Parant :=  nil;
  inherited;
end;

function TrcMonitor.GetSrcCount: integer;
begin
  result := FList.Count;
end;

function TrcMonitor.GetSrcs(idx: integer): PSrcDefine;
begin
  result := PSrcDefine(FList[idx]);
end;

function TrcMonitor.Open(src: PSrcDefine): boolean;
begin

end;

procedure TrcMonitor.Pause;
begin
  display.Visible := false;
end;

procedure TrcMonitor.PlayEnded;
begin
  if SrcCount<=0 then exit;
  index := index+1;
  Open(srcs[index]);
end;

procedure TrcMonitor.resume;
begin
  display.Visible := true;
end;

procedure TrcMonitor.SetdpyLength(const Value: int64);
begin
  FdpyLength := Value;
  Timer.Enabled := false;
  if Value>0 then Timer.Interval := Value*1000;
end;

procedure TrcMonitor.SetdpyStart(const Value: int64);
begin
  FdpyStart := Value;
end;

procedure TrcMonitor.Setheight(const Value: integer);
begin
  Fheight := Value;
  display.Height := Value;
end;

procedure TrcMonitor.Setindex(const Value: integer);
begin
  Findex := Value;
  if findex>=flist.Count then findex := 0;
end;

procedure TrcMonitor.Setleft(const Value: integer);
begin
  Fleft := Value;
  display.Left := Value;
end;

procedure TrcMonitor.SetMonitorType(const Value: TMonitorType);
begin
  FMonitorType := Value;
end;

procedure TrcMonitor.SetrcProgram(const Value: TrcProgram);
begin
  FrcProgram := Value;
end;

procedure TrcMonitor.SetSrcs(idx: integer; const Value: PSrcDefine);
begin
  if FList[idx]<>nil then Dispose(FList[idx]);
  FList[idx] := Value;
end;

procedure TrcMonitor.Settop(const Value: integer);
begin
  Ftop := Value;
  display.Top := Value;
end;

procedure TrcMonitor.Setwidth(const Value: integer);
begin
  Fwidth := Value;
  display.Width := Value;
end;

procedure TrcMonitor.TimerComplete(Sender: TObject);
begin
  PlayEnded;
end;

{ TrcVideoMonitor }

procedure TrcVideoMonitor.Close;
begin
  Timer.Enabled := false;
  FilterGraph.Stop;
  FilterGraph.ClearGraph;
  FilterGraph.Active := False;
  index := -1;
end;

constructor TrcVideoMonitor.Create(AOwner: TWinControl);
begin
  inherited;
  FilterGraph := TFilterGraph.Create(nil);
  FilterGraph.OnGraphComplete := FilterGraphGraphComplete;
  display := TVideoWindow.Create(AOwner);
  with TVideoWindow(display) do
     begin
       Mode := vmVMR;
       VMROptions.KeepAspectRatio := false;
       FilterGraph := FilterGraph;
       Align := alNone;
       Parent := AOwner;
     end;
  MonitorType := mtVideo;
end;

destructor TrcVideoMonitor.Destroy;
begin
  Close;
  display.Free;
  FilterGraph.Free;
  inherited;
end;

procedure TrcVideoMonitor.FilterGraphGraphComplete(sender: TObject;
  Result: HRESULT; Renderer: IBaseFilter);
begin
  PlayEnded;
end;

function TrcVideoMonitor.Open(src: PSrcDefine): boolean;
begin
  FilterGraph.Stop;
  FilterGraph.ClearGraph;
  FilterGraph.Active := False;
  FilterGraph.Active := True;
  FilterGraph.RenderFile(src^.src);
  FilterGraph.Play;
  dpyStart := GetTickCount div 1000;
  dpyLength := src^.srcLength;
  Timer.Enabled := (dpyLength > 0);
  result := true;
end;

procedure TrcVideoMonitor.Pause;
begin
  inherited;
  FilterGraph.Pause;
end;

procedure TrcVideoMonitor.resume;
begin
  inherited;
  FilterGraph.Play;

end;

{ TrcPhotoMonitor }

procedure TrcPhotoMonitor.Close;
begin
  inherited;
  Timer.Enabled := false;
  with TImage(display) do Picture := nil;
  Index := -1;
end;

constructor TrcPhotoMonitor.Create(AOwner: TWinControl);
begin
  inherited;
  display := TImage.Create(AOwner);
  with display do
    begin
      Align := alNone;
      Parent := AOwner;
    end;
  MonitorType := mtPhoto;
end;

destructor TrcPhotoMonitor.Destroy;
begin
  Close;
  display.Free;
  inherited;
end;

function TrcPhotoMonitor.Open(src: PSrcDefine): boolean;
begin
  TImage(display).Picture.LoadFromFile(src^.src);
  dpyStart := GetTickCount div 1000;
  dpyLength := src^.srcLength;
  Timer.Enabled := (dpyLength > 0);
  result := true;
end;

procedure TrcPhotoMonitor.Pause;
begin
  inherited;
end;

procedure TrcPhotoMonitor.resume;
begin
  inherited;
end;

{ TrcTextMonitor }

procedure TrcTextMonitor.Close;
begin
  inherited;
  Timer.Enabled := false;
  TRzMarqueeStatus(display).Caption := '';
  index := -1;
end;

constructor TrcTextMonitor.Create(AOwner: TWinControl);
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
end;

destructor TrcTextMonitor.Destroy;
begin
  Close;
  display.Free;
  inherited;
end;

function TrcTextMonitor.GetBackColor: TColor;
begin
  with TRzMarqueeStatus(display) do
    begin
       result := Color;
    end;
end;

function TrcTextMonitor.GetFont: TFont;
begin
  with TRzMarqueeStatus(display) do
    begin
      result := font;
    end;
end;

function TrcTextMonitor.GetScrollSpeed: integer;
begin
  with TRzMarqueeStatus(display) do
    begin
       result := ScrollDelay;
    end;
end;

function TrcTextMonitor.Open(src: PSrcDefine): boolean;
begin
  TRzMarqueeStatus(display).Caption := src^.src;
  dpyStart := GetTickCount div 1000;
  dpyLength := src^.srcLength;
  Timer.Enabled := (dpyLength > 0);
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
     end;
  result := true;
end;

procedure TrcTextMonitor.Pause;
begin
  inherited;
  TRzMarqueeStatus(display).Scrolling := false;
end;

procedure TrcTextMonitor.resume;
begin
  inherited;
  TRzMarqueeStatus(display).Scrolling := true;
end;

procedure TrcTextMonitor.SetBackColor(const Value: TColor);
begin
  with TRzMarqueeStatus(display) do
    begin
       Color := Value;
    end;
end;

procedure TrcTextMonitor.SetFont(const Value: TFont);
begin
  with TRzMarqueeStatus(display) do
    begin
       font.Assign(Value); 
    end;
end;

procedure TrcTextMonitor.SetScrollSpeed(const Value: integer);
begin
  with TRzMarqueeStatus(display) do
    begin
       ScrollDelay := Value;
    end;
end;

{ TrcProgram }

procedure TrcProgram.Clear;
var i:integer;
begin
  for i:=Flist.Count -1 downto 0 do
    TObject(Flist[i]).Free;
  Flist.Free;
end;

procedure TrcProgram.Close;
var i:integer;
begin
  for i:=0 to flist.Count -1 do
    begin
      TrcMonitor(flist[i]).Close;
    end;
end;

constructor TrcProgram.Create(AOwner: TWinControl);
begin
  FList := TList.Create;
  Parant := AOwner;
end;

destructor TrcProgram.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

procedure TrcProgram.Open(root: IXMLDOMNode);
procedure AddVideo(root: IXMLDOMNode);
var
  Node:IXMLDOMNode;
  LayoutStartX,LayoutEndX,LayoutStartY,LayoutEndY:integer;
  Video:TrcVideoMonitor;
  Src:PSrcDefine;
begin
  LayoutStartX := StrtoIntDef(Root.selectSingleNode('LayoutStartX').text,0);
  LayoutEndX := StrtoIntDef(Root.selectSingleNode('LayoutEndX').text,0);
  LayoutStartY := StrtoIntDef(Root.selectSingleNode('LayoutStartY').text,0);
  LayoutEndY := StrtoIntDef(Root.selectSingleNode('LayoutEndY').text,0);

  Video := TrcVideoMonitor.Create(Parant);
  Flist.Add(Video);
  Video.top := LayoutStartX;
  Video.left := LayoutStartY;
  Video.height := LayoutStartY+LayoutEndY;
  Video.width := LayoutStartX+LayoutEndX;
  Node := Root.firstChild;
  while Node<>nil do
    begin
      if Node.nodeName='Src' then
         begin
           new(src);
           src^.SourceId := Node.selectSingleNode('SourceId').text;
           src^.Sequence := StrtoIntDef(Node.selectSingleNode('Sequence').text,0);
           src^.src := Node.selectSingleNode('Path').text;
           Video.AddSrc(src);
         end;
      Node := Node.nextSibling;
    end;
end;
procedure AddPhoto(root: IXMLDOMNode);
var
  Node:IXMLDOMNode;
  LayoutStartX,LayoutEndX,LayoutStartY,LayoutEndY:integer;
  Photo:TrcPhotoMonitor;
  Src:PSrcDefine;
begin
  LayoutStartX := StrtoIntDef(Root.selectSingleNode('LayoutStartX').text,0);
  LayoutEndX := StrtoIntDef(Root.selectSingleNode('LayoutEndX').text,0);
  LayoutStartY := StrtoIntDef(Root.selectSingleNode('LayoutStartY').text,0);
  LayoutEndY := StrtoIntDef(Root.selectSingleNode('LayoutEndY').text,0);

  Photo := TrcPhotoMonitor.Create(Parant);
  Flist.Add(Photo);
  Photo.top := LayoutStartX;
  Photo.left := LayoutStartY;
  Photo.height := LayoutStartY+LayoutEndY;
  Photo.width := LayoutStartX+LayoutEndX;
  Node := Root.firstChild;
  while Node<>nil do
    begin
      if Node.nodeName='Src' then
         begin
           new(src);
           src^.SourceId := Node.selectSingleNode('SourceId').text;
           src^.Sequence := StrtoIntDef(Node.selectSingleNode('Sequence').text,0);
           src^.src := Node.selectSingleNode('Path').text;
           src^.srcLength := StrtoIntDef(Node.selectSingleNode('ShowTime').text,0);
           src^.Effect := StrtoIntDef(Node.selectSingleNode('Effect').text,0);
           Photo.AddSrc(src);
         end;
      Node := Node.nextSibling;
    end;
end;
procedure AddText(root: IXMLDOMNode);
var
  Node:IXMLDOMNode;
  LayoutStartX,LayoutEndX,LayoutStartY,LayoutEndY:integer;
  Text:TrcTextMonitor;
  Src:PSrcDefine;
begin
  LayoutStartX := StrtoIntDef(Root.selectSingleNode('LayoutStartX').text,0);
  LayoutEndX := StrtoIntDef(Root.selectSingleNode('LayoutEndX').text,0);
  LayoutStartY := StrtoIntDef(Root.selectSingleNode('LayoutStartY').text,0);
  LayoutEndY := StrtoIntDef(Root.selectSingleNode('LayoutEndY').text,0);

  Text := TrcTextMonitor.Create(Parant);
  Flist.Add(Text);
  Text.top := LayoutStartX;
  Text.left := LayoutStartY;
  Text.height := LayoutStartY+LayoutEndY;
  Text.width := LayoutStartX+LayoutEndX;
  
  Node := Root.firstChild;
  while Node<>nil do
    begin
      if Node.nodeName='Src' then
         begin
           new(src);
           src^.SourceId := Node.selectSingleNode('SourceId').text;
           src^.Sequence := StrtoIntDef(Node.selectSingleNode('Sequence').text,0);
           src^.src := Node.selectSingleNode('Content').text;
           src^.srcLength := StrtoIntDef(Node.selectSingleNode('ShowTime').text,0);
           src^.Effect := StrtoIntDef(Node.selectSingleNode('Effect').text,0);
           src^.FontSize := StrtoIntDef(Node.selectSingleNode('FontSize').text,12);
           src^.FontColor := StrtoIntDef(Node.selectSingleNode('FontColor').text,$0);
           src^.BackColor := StrtoIntDef(Node.selectSingleNode('BackColor').text,$ffff);
           src^.ScrollSpeed := StrtoIntDef(Node.selectSingleNode('ScrollSpeed').text,100);
           src^.FontName := Node.selectSingleNode('FontName').text;
           src^.CharSet := StrtoIntDef(Node.selectSingleNode('CharSet').text,0);
           Text.AddSrc(src);
         end;
      Node := Node.nextSibling;
    end;
end;
var
  Node:IXMLDOMNode;
  ScreenSize:string;
  w:integer;
begin
  ScreenSize := Root.selectSingleNode('ProgramId').text;
  w := pos('*',ScreenSize);
  ScreenWidth := StrtoIntDef(trim(copy(ScreenSize,1,w-1)),1024);
  ScreenHeight := StrtoIntDef(trim(copy(ScreenSize,w+1,255)),768);
  Parant.SetBounds(0,0,ScreenWidth,ScreenHeight);
  Node := Root.firstChild;
  while Node<>nil do
    begin
      if Node.nodeName='Photo' then
         AddPhoto(Node);
      if Node.nodeName='Video' then
         AddVideo(Node);
      if Node.nodeName='Text' then
         AddText(Node);
      Node := Node.nextSibling;
    end;
end;

procedure TrcProgram.Pause;
var
  i:integer;
begin
  for i:=0 to flist.Count -1 do
    begin
      with TrcMonitor(flist[i]) do
        begin
          Pause;
        end;
    end;
end;

procedure TrcProgram.Play;
var
  i:integer;
begin
  for i:=0 to flist.Count -1 do
    begin
      with TrcMonitor(flist[i]) do
        begin
          if SrcCount<=0 then continue;
          index := index+1;
          Open(srcs[index]);
        end;
    end;
end;

procedure TrcProgram.resume;
var
  i:integer;
begin
  for i:=0 to flist.Count -1 do
    begin
      with TrcMonitor(flist[i]) do
        begin
          resume;
        end;
    end;
end;

procedure TrcProgram.SetProgramId(const Value: string);
begin
  FProgramId := Value;
end;

procedure TrcProgram.SetProgramLen(const Value: integer);
begin
  FProgramLen := Value;
end;

procedure TrcProgram.SetProgramSeq(const Value: integer);
begin
  FProgramSeq := Value;
end;

procedure TrcProgram.Setroot(const Value: IXMLDOMNode);
begin
  Froot := Value;
end;

procedure TrcProgram.SetScreenHeight(const Value: integer);
begin
  FScreenHeight := Value;
end;

procedure TrcProgram.SetScreenWidth(const Value: integer);
begin
  FScreenWidth := Value;
end;

{ TrcPlayList }

procedure TrcPlayList.Clear;
var i:integer;
begin
  for i:=Flist.Count -1 downto 0 do
    TObject(Flist[i]).Free;
  Flist.Free;
end;

constructor TrcPlayList.Create(AOwner: TWinControl);
begin
  FList := TList.Create;
  Timer := TTimer.Create(nil);
  Timer.Enabled := false;
  Timer.OnTimer := TimerComplete;
  Parant := AOwner;
  curProgram := nil;
  findex := -1;
  Ended := false;
end;

destructor TrcPlayList.Destroy;
begin
  Timer.Free;
  curProgram := nil;
  Clear;
  FList.Free;
  inherited;
end;

procedure TrcPlayList.Open(root: IXMLDOMNode);
var
  Node:IXMLDOMNode;
  prog:TrcProgram;
begin
  PlayListId := Root.selectSingleNode('PlayListId').text;
  PlayListLen := StrtoIntDef(Root.selectSingleNode('PlayListLen').text,0);
  PlayType := StrtoIntDef(Root.selectSingleNode('Type').text,0);
  StartTime := Root.selectSingleNode('StartTime').text;
  PlayListSeq := StrtoIntDef(Root.selectSingleNode('PlayListSeq').text,0);
  Node := root.firstChild;
  while Node<>nil do
    begin
      if Node.nodeName='Program' then
         begin
           prog := TrcProgram.Create(Parant);
           Flist.Add(prog);
           prog.root := Node;
           prog.ProgramId := Node.selectSingleNode('ProgramId').text;
           prog.ProgramLen := StrtoIntDef(Node.selectSingleNode('ProgramLen').text,0);
           prog.ProgramSeq := StrtoIntDef(Node.selectSingleNode('ProgramSeq').text,0);
         end;
      Node := Node.nextSibling;
    end;
end;

procedure TrcPlayList.SetPlayListId(const Value: string);
begin
  FPlayListId := Value;
end;

procedure TrcPlayList.SetPlayListLen(const Value: integer);
begin
  FPlayListLen := Value;
end;

procedure TrcPlayList.SetPlayType(const Value: integer);
begin
  FPlayType := Value;
end;

procedure TrcPlayList.SetPlayListSeq(const Value: integer);
begin
  FPlayListSeq := Value;
end;

procedure TrcPlayList.SetStartTime(const Value: string);
begin
  FStartTime := Value;
end;

procedure TrcPlayList.Play;
begin
  if flist.Count=0 then Exit;
  if ended then ended := false; //如果已经结束，打开重播放
  if curProgram=nil then
     curProgram := TrcProgram(flist[0])
  else
     begin
       index := index + 1;
       curProgram := TrcProgram(flist[index]);
     end;
  curProgram.Open(curProgram.root);
  curProgram.Play;
  if index=0 then NearTime := formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  Timer.Enabled := false;
  Timer.Interval := curProgram.FProgramLen;
  Timer.Enabled := (Timer.Interval>0);
end;

procedure TrcPlayList.Close;
begin
  Timer.Enabled := false;
  curProgram.Close;
  curProgram.Clear;
end;

procedure TrcPlayList.TimerComplete(Sender: TObject);
begin
  if index>=(flist.Count-1) then
     ended := true
  else
     Play;
end;

procedure TrcPlayList.Setindex(const Value: integer);
begin
  Findex := Value;
  if findex>=flist.Count then findex := 0;
end;

procedure TrcPlayList.SetEnded(const Value: boolean);
begin
  FEnded := Value;
end;

procedure TrcPlayList.SetNearTime(const Value: string);
begin
  FNearTime := Value;
end;

procedure TrcPlayList.Pause;
begin
  if curProgram=nil then Exit;
  curProgram.Pause;
end;

procedure TrcPlayList.resume;
begin
  if curProgram=nil then Exit;
  curProgram.resume;
end;

{ TrcFile }

procedure TrcFile.Clear;
var i:integer;
begin
  for i:=Flist.Count -1 downto 0 do
    TObject(Flist[i]).Free;
  Flist.Free;
  xmlDoc := nil;
end;

procedure TrcFile.Close;
begin
  Timer.Enabled := false;
  curPlayList.Close;
end;

constructor TrcFile.Create(AOwner: TWinControl);
begin
  FList := TList.Create;
  Timer := TTimer.Create(nil);
  Timer.Enabled := false;
  Timer.Interval := 1000;
  Timer.OnTimer := TimerComplete;
  Parant := AOwner;
  curPlayList := nil;
  findex := -1;
end;

destructor TrcFile.Destroy;
begin
  Timer.Free;
  Clear;
  FList.Free;
  inherited;
end;

procedure TrcFile.Open(filename: string);
var
  node:IXMLDOMNode;
  playList:TrcPlayList;
begin
  Clear;
  xmlDoc := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  xmlDoc.load(filename);
  node := xmlDoc.documentElement;
  ProgramListId := node.selectSingleNode('ProgramListId').text;
  Period := StrtoIntDef(node.selectSingleNode('Period').text,0);
  StartDate := node.selectSingleNode('StartDate').text;
  EndDate := node.selectSingleNode('EndDate').text;
  ProgramListType := StrtoIntDef(node.selectSingleNode('ProgramListType').text,0);
  node := node.firstChild;
  while node<>nil do
    begin
      if node.nodeName='PlayList' then
         begin
           playList := TrcPlayList.Create(Parant);
           flist.Add(playList);
           playList.Open(Node); 
         end;
      node := node.nextSibling;
    end;
end;

procedure TrcFile.Pause;
begin
  if curPlayList<>nil then curPlayList.Pause;
end;

procedure TrcFile.Play;
begin
  if flist.Count=0 then Exit;
  if ended then ended := false;
  if curPlayList=nil then
     curPlayList := TrcPlayList(flist[0])
  else
     begin
       index := index + 1;
       curPlayList := TrcPlayList(flist[index]);
     end;
  curPlayList.Play;
  Timer.Enabled := true;
end;

procedure TrcFile.resume;
begin
  if curPlayList<>nil then curPlayList.resume;
end;

procedure TrcFile.SetEndDate(const Value: string);
begin
  FEndDate := Value;
end;

procedure TrcFile.Setended(const Value: boolean);
var i:integer;
begin
  Fended := Value;
  if not ended then
     begin
       for i:=0 to flist.Count -1 do
         begin
           TrcPlayList(flist[i]).Ended := ended;
         end;
     end;
end;

procedure TrcFile.Setindex(const Value: integer);
begin
  Findex := Value;
  if findex>=flist.Count then findex := 0;
end;

procedure TrcFile.SetPeriod(const Value: integer);
begin
  FPeriod := Value;
end;

procedure TrcFile.SetProgramListId(const Value: string);
begin
  FProgramListId := Value;
end;

procedure TrcFile.SetProgramListType(const Value: integer);
begin
  FProgramListType := Value;
end;

procedure TrcFile.SetStartDate(const Value: string);
begin
  FStartDate := Value;
end;

procedure TrcFile.TimerComplete(Sender: TObject);
var
  i:integer;
begin
  if flist.Count=0 then exit;
  //检查是否有定时播表
  for i:=0 to flist.Count -1 do
    begin
      if TrcPlayList(flist[i]).PlayType = 1 then //定时播表
         begin
           if TrcPlayList(flist[i]).Ended and
           (    copy(TrcPlayList(flist[i]).NearTime,1,10)
                =
                formatDatetime('YYYY-MM-DD',now())
           ) then continue;
           if TrcPlayList(flist[i]).StartTime<formatDatetime('HH:NN:SS',now()) then
              begin
                if TrcPlayList(flist[i])<>curPlayList then
                   begin
                     curPlayList := TrcPlayList(flist[i]);
                     curPlayList.Play;
                     exit;
                   end;
              end;
         end;
    end;
  if curPlayList.Ended then
     begin
       if (index=(flist.Count-1)) and (ProgramListType=1) then
          begin
            ended := true;
            postmessage(Parant.Handle,WM_PLAY_ENDING,integer(self),0);
            Exit;
          end;
       index := index+1;
       curPlayList := TrcPlayList(flist[index]);
       curPlayList.Play;
     end;
end;

end.
