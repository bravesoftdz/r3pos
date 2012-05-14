unit rzXmlDown;

interface

uses XMLIntf, XMLDoc, msXml, classes, ComObj, IdBaseComponent, IdComponent,Forms,
     IdTCPConnection, IdTCPClient, IdHTTP, SysUtils, Windows, RzCtrls, HttpApp, ActiveX;

type
  TUrlInfo=record
    UrlId:String;
    Url:String;
    resType:integer;
  end;
  PUrlInfo=^TUrlInfo;

type

  TrzXmlDown=class
  private
    FList:TList;
    XmlDocm:IXMLDOMDocument;
    FTFileSize:int64;
    Fsrc: string;
    idHttp:TidHttp;
    Fpid: string;
    FmsgId: string;
    function GetUrlInfo(itemindex: integer): PUrlInfo;
    function GetCount: integer;
    procedure IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure Setsrc(const Value: string);
    procedure Setpid(const Value: string);
    procedure SetmsgId(const Value: string);
  protected
    procedure ReadPlayList(Root:IXMLDOMNode);
    procedure ReadProgramList(Root:IXMLDOMNode);
    procedure AddPhoto(Root:IXMLDOMNode);
    procedure AddVideo(Root:IXMLDOMNode);
    procedure Open(FileName:String);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function DownFile(src:string;filename:string):boolean;
    function DownAllRes:boolean;
    function DownHeader:boolean;
    function SendStatus(flag:integer;msg:string=''):boolean;
    procedure AddToPlays;

    property UrlInfo[itemindex:integer]:PUrlInfo read GetUrlInfo;
    property Count:integer read GetCount;
    property src:string read Fsrc write Setsrc;
    property pid:string read Fpid write Setpid;
    property msgId:string read FmsgId write SetmsgId;
  end;
  PPlaysInfo=^TPlaysInfo;
  TPlaysInfo=record
    srcFlag:integer; //0 url 1 xmlfile
    src:string;
    msgId:string;
    pid:string;
    TryTime:integer;
  end;
  TXmlDownThread=class(TThread)
  private
    Event:THandle;
    Down:TrzXmlDown;
    FList:TList;
    procedure Execute; override;
    procedure Clear;
    procedure Load;
  public
    constructor Create;
    destructor Destroy; override;

    procedure DownSrc(src,msgId,pId:string);
    procedure DownXml(xml:string);
    procedure DownPrm(xml:string);
    procedure ClearRes;
    procedure Play;
  end;

var XmlDown:TXmlDownThread;
    PosHWND: HWND = 0;
    
implementation
uses ufrmRzPlayer;
{ TrzXmlDown }

procedure TrzXmlDown.AddPhoto(Root: IXMLDOMNode);
var Node:IXMLDOMNode;
    Url_Info:PUrlInfo;
begin
  Node := Root.selectSingleNode('photoList');
  Node := Node.firstChild;
  while Node <> nil do
  begin
    if Node.nodeName = 'photo' then
    begin
      new(Url_Info);
      Url_Info^.UrlId := Node.selectSingleNode('photoId').text+ExtractFileExt(Node.selectSingleNode('photoName').text);
      Url_Info^.Url := Node.selectSingleNode('path').text;
      Url_Info^.resType := 1;
      FList.Add(Url_Info);
    end;
    Node := Node.nextSibling;
  end;

end;

procedure TrzXmlDown.AddVideo(Root: IXMLDOMNode);
var Node:IXMLDOMNode;
    Url_Info:PUrlInfo;
begin
  Node := Root.selectSingleNode('videoList');
  Node := Node.firstChild;
  while Node <> nil do
  begin
    if Node.nodeName = 'video' then
    begin
      new(Url_Info);
      Url_Info^.UrlId := Node.selectSingleNode('videoId').text+ExtractFileExt(Node.selectSingleNode('videoName').text);
      Url_Info^.Url := Node.selectSingleNode('path').text;
      Url_Info^.resType := 2;
      FList.Add(Url_Info);
    end;
    Node := Node.nextSibling;
  end;
end;

procedure TrzXmlDown.Clear;
var i:Integer;
begin
  for i:=FList.Count-1 downto 0 do
    dispose(FList[i]);
  FList.Clear;
  XmlDocm := nil;
end;

constructor TrzXmlDown.Create;
begin
  inherited;
  FList := TList.Create;
  idHttp := TidHTTP.Create(nil);
end;

destructor TrzXmlDown.Destroy;
begin
  Clear;
  FreeAndNil(idHttp);
  FList.Free;
  inherited;
end;

function TrzXmlDown.DownAllRes: boolean;
var
  i,times:integer;
  filename:string;
begin
  try
    result := false;
    times := Plays.readInteger(pid,'times',0);
    if times>5 then
       begin
         result := true;
         Exit;
       end;
    Plays.WriteInteger(pid,'times',times+1);
    for i:=0 to FList.Count -1 do
      begin
        case UrlInfo[i]^.resType of
        1:filename := AppData+'\res\photo\'+UrlInfo[i]^.UrlId;
        2:filename := AppData+'\res\vedio\'+UrlInfo[i]^.UrlId;
        end;
        if FileExists(filename) then continue;
        downfile(UrlInfo[i]^.Url,filename);
      end;
    Plays.WriteString(pid,'ready','1'); 
    result := true;
    SendStatus(0);
  except
    on E:Exception do
       begin
          SendStatus(1,E.Message);
          Raise;
       end;
  end;
end;

function TrzXmlDown.DownFile(src, filename: string): boolean;
var fFile:TFileStream;
  idHTTP:TidHTTP;
begin
  result := false;
  ForceDirectories(ExtractFileDir(filename));
  fFile := TFileStream.Create(filename+'.ft',fmCreate);
  idHTTP := TidHTTP.Create(nil);
  try
      idHTTP.OnWork := IdHTTPWork;
      idHttp.HandleRedirects := true;
      IdHTTP.Head(src);
      FTFileSize := IdHTTP.Response.ContentLength;
      IdHTTP.Get(src,FFile);
  finally
    idHTTP.Free;
    fFile.Free;
  end;
  deletefile(pchar(filename));
  if not renamefile(filename+'.ft',filename) then
     begin
       deletefile(pchar(filename+'.ft'));
       Raise Exception.Create('下载"'+src+'"失败了.');
     end;
  SendDebug('下载“'+src+'”完毕',3);
  result := true;
end;

function TrzXmlDown.GetCount: integer;
begin
  Result := FList.Count;
end;

function TrzXmlDown.GetUrlInfo(itemindex: integer): PUrlInfo;
begin
  Result := PUrlInfo(FList[itemindex]);
end;

procedure TrzXmlDown.IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin

end;

procedure TrzXmlDown.ReadPlayList(Root: IXMLDOMNode);
var Node:IXMLDOMNode;
begin
  Node := Root.selectSingleNode('programList');
  Node := Node.firstChild;
  while Node <> nil do
  begin
    if Node.nodeName = 'program' then
       ReadProgramList(Node);
    Node := Node.nextSibling;
  end;
end;

procedure TrzXmlDown.ReadProgramList(Root: IXMLDOMNode);
var Node:IXMLDOMNode;
begin
  Node := Root.selectSingleNode('photoElList');
  if Node <> nil then
  begin
    Node := Node.firstChild;
    while Node <> nil do
    begin
      if Node.nodeName = 'photoEl' then
         AddPhoto(Node);
      Node := Node.nextSibling;
    end;
  end;

  Node := Root.selectSingleNode('videoElList');
  if Node <> nil then
  begin
    Node := Node.firstChild;
    while Node <> nil do
    begin
      if Node.nodeName = 'videoEl' then
         AddVideo(Node);
      Node := Node.nextSibling;
    end;
  end;
end;

procedure TrzXmlDown.Open(FileName: String);
var Node,Root:IXMLDOMNode;
    StartDate,EndDate,ProgramListType:string;
begin
  Clear;
  XmlDocm := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  XmlDocm.load(FileName);
  Root := XmlDocm.documentElement;
  pid  := Root.selectSingleNode('playbillId').text;
  StartDate := Root.selectSingleNode('starteDate').text;
  EndDate := Root.selectSingleNode('endDate').text;
  ProgramListType := Root.selectSingleNode('playbillType').text;
  msgId := Plays.readString(pid,'msgId','');
  Node := Root.selectSingleNode('playList');
  Node := Node.firstChild;
  while Node <> nil do
  begin
    if Node.nodeName = 'play' then
       ReadPlayList(Node);
    Node := Node.nextSibling;
  end;
//  if FList.Count=0 then Raise Exception.Create('无效节目单');
//  if not FileExists(ExtractFilePath(ParamStr(0))+'adv\'+pid+'.xml') then
     begin
       Plays.WriteString(pid,'ready','0');
       if ExtractFilePath(filename)=AppData+'\temp\' then
          begin
            deletefile(pchar(AppData+'\adv\'+pid+'.xml'));
            if not copyfile(pchar(filename),pchar(AppData+'\adv\'+pid+'.xml'),true) then Raise Exception.Create('保存节目"'+FileName+'"失败。');
          end;
       Plays.EraseSection(pid); 
       Plays.WriteString(pid,'filename',AppData+'\adv\'+pid+'.xml');
       Plays.WriteString(pid,'startdate',StartDate);
       Plays.WriteString(pid,'enddate',EndDate);
       Plays.WriteString(pid,'programType',ProgramListType);
       Plays.WriteString(pid,'src',src);
     end;
end;

function TrzXmlDown.DownHeader: boolean;
var
  filename:string;
begin
  result := false;
  filename := AppData+'\temp\play'+formatDatetime('yyyymmddhhnnss',now())+'.xml';
  downfile(src,filename);
  try
    open(filename);
    result := true;
  finally
    deletefile(pchar(filename));
  end;
end;

procedure TrzXmlDown.Setsrc(const Value: string);
begin
  Fsrc := Value;
end;

procedure TrzXmlDown.Setpid(const Value: string);
begin
  Fpid := Value;
end;

procedure TrzXmlDown.AddToPlays;
var
  rzFile:TrzFile;
begin
  if not (
           (Plays.ReadString(pid,'ready','1')='1')
           and
           (formatDatetime('YYYY-MM-DD',now())>=Plays.ReadString(pid,'startdate',''))
           and
           (formatDatetime('YYYY-MM-DD',now())<=Plays.ReadString(pid,'enddate',''))
         )
  then Exit;
  with frmRzPlayer.frmRzMonitor do
     begin
        try
          rzFile := TrzFile.Create(frmRzPlayer.frmRzMonitor);
          rzFile.Open(AppData+'\adv\'+pid+'.xml');
          if rzFile.ProgramListType in [1,2,3] then
             Add(rzFile)
          else
          if rzFile.ProgramListType in [0] then
             begin
               Clear;
               Add(rzFile)
             end
          else
             begin
               rzFile.Free;
               Exit;
             end;
          Close;
          Play //如果是插播立即播放
        except
          rzFile.Free;
          Raise;
        end;
     end;
end;

function TrzXmlDown.SendStatus(flag: integer;msg:string=''): boolean;
function GetUrl:string;
begin
  result := 'http://ad.rzico.net/publish/application/modifyStatus';
end;
var
  Request,Response:TStringStream;
  s:string;
  idHTTP:TidHTTP;
begin
  try
    s :='messId='+msgId+'&userCode=chenzh&playbillId='+pid+'&statusFlag='+inttostr(flag)+'&statusLog='+HTTPEncode(msg)+'&token=123456789';

    Response := TStringStream.Create('');
    Request := TStringStream.Create(s);
    idHTTP := TidHTTP.Create(nil);
    try
      idHTTP.OnWork := IdHTTPWork;
      idHttp.HandleRedirects := true;
      IdHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
      idHttp.Post(GetUrl,Request,Response);
      //SendDebug(Response.DataString,3);
    finally
      idHTTP.Free;
      Request.Free;
      Response.Free;
    end;
  except
    on E:Exception do
       begin
         SendDebug(E.Message,1);
       end;
  end;
end;

procedure TrzXmlDown.SetmsgId(const Value: string);
begin
  FmsgId := Value;
end;

{ TXmlDownThread }

procedure TXmlDownThread.Clear;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      dispose(FList[i]);
    end;
  FList.Clear;
end;

constructor TXmlDownThread.Create;
begin
  inherited Create(true);
  Event := CreateEvent(nil, True, False, nil);
  Down := TrzXmlDown.Create;
  FList := TList.Create;
end;

destructor TXmlDownThread.Destroy;
begin
  Terminate;
  SetEvent(Event);
  if Event<>0 then CloseHandle(Event);
  inherited;
  Clear;
  FList.Free;
  Down.Free;
end;

procedure TXmlDownThread.DownSrc(src,msgId,pId: string);
var
  Plays:PPlaysInfo;
begin
  new(Plays);
  Plays^.srcFlag := 0;
  Plays^.src := src;
  Plays^.msgId := msgId;
  Plays^.pid := pId;
  Plays^.TryTime := 0;
  FList.Insert(0,Plays);
  SetEvent(Event);
end;

procedure TXmlDownThread.DownXml(xml: string);
var
  Doc:IXMLDOMDocument;
  node:IXMLDOMNode;
  msgId,pId,url,ptype:string;
begin
  Doc := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  Doc.loadXML(xml);
  node := Doc.documentElement;
  if node=nil then Raise Exception.Create('无效的命令格式:'+xml);
  node := node.firstChild;
  while node<>nil do
    begin
      if node.attributes.getNamedItem('key').nodeValue='url' then
         begin
           url := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='messId' then
         begin
           msgId := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='playbillId' then
         begin
           pId := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='type' then
         begin
           ptype := node.attributes.getNamedItem('value').nodeValue;
         end;
      node := node.nextSibling;
    end;
  case StrtoIntDef(ptype,0) of
  1:if url<>'' then DownSrc(url,msgId,pId);
  end;
end;

procedure TXmlDownThread.Execute;
var
  Plays:PPlaysInfo;
begin
  inherited;
  CoInitialize(nil);
  try
  Load;
  resetEvent(Event);
  while not Terminated do
    begin
      if (FList.Count = 0) then
         begin
           WaitForSingleObject(Event,INFINITE);
           resetEvent(Event);
         end
      else
         begin
           WaitForSingleObject(Event,60000);
           resetEvent(Event);
         end;
      if not Terminated and (FList.Count > 0) then
         begin
           Plays := PPlaysInfo(FList[0]);
           Plays.TryTime := Plays.TryTime + 1;
           if Plays.TryTime>3 then
              begin
                FList.Remove(Plays);
                dispose(Plays);
                continue;
              end;
           try
             case Plays^.srcFlag of
             0:begin
                 Down.src := Plays^.src;
                 if Down.DownHeader then
                 begin
                   Plays^.srcFlag := 1;
                   Plays^.src :=AppData+'\adv\'+down.pid+'.xml';
                   if Plays^.pid<>'' then
                      RzCtrls.Plays.WriteString(Plays^.pid,'msgId',Plays^.msgId); 
                   if Down.DownAllRes then
                      begin
                        FList.Remove(Plays);
                        dispose(Plays);
                        SendMessage(Application.MainForm.Handle,WM_PLAY_START,0,0);
                      end;
                 end;
               end;
             1:begin
                 Down.Open(Plays^.src);
                 if Down.DownAllRes then
                    begin
                      FList.Remove(Plays);
                      dispose(Plays);
                      SendMessage(Application.MainForm.Handle,WM_PLAY_START,0,0);
                    end;
               end;
             2:begin
                 try
                   DownXml(Plays^.src);
                 finally
                   FList.Remove(Plays);
                   dispose(Plays);
                 end;
               end;
             end;
           except
             on E:Exception do
                begin
                  if (FList.IndexOf(Plays)>=0) and (FList.Count > 1) then
                     FList.Move(FList.IndexOf(Plays),FList.Count-1);
                  SendDebug('第'+inttostr(Plays^.TryTime)+'次下载节目"'+Plays^.src+'"失败了，错误原因：'+e.Message,1);
                end;
           end;
         end;
    end;
  finally
    CoUninitialize();
  end;
end;

procedure TXmlDownThread.Load;
var
  jm:TStringList;
  i:integer;
  filename:string;
  node:PPlaysInfo;
begin
  jm := TStringList.Create;
  try
    Plays.ReadSections(jm);
    for i:=0 to jm.Count -1 do
      begin
        filename := Plays.ReadString(jm[i],'filename','');
        if fileExists(filename)
           and
           (Plays.ReadString(jm[i],'ready','0')='0')
           and
           (formatDatetime('YYYY-MM-DD',now())>Plays.ReadString(jm[i],'enddate',''))
        then
           begin
             new(node);
             node^.srcFlag := 1;
             node^.src := filename;
             node^.TryTime := 0;
             FList.Insert(0,node);
           end;
      end;
  finally
    jm.Free;
  end;

end;

procedure TXmlDownThread.Play;
begin
  Down.AddToPlays;
end;

procedure TXmlDownThread.DownPrm(xml: string);
var
  node:PPlaysInfo;
begin
  new(node);
  node^.srcFlag := 2;
  node^.src := xml;
  node^.TryTime := 0;
  FList.Insert(0,node); 
  SetEvent(Event);
end;

procedure TXmlDownThread.ClearRes;
begin

end;

initialization
  XmlDown := TXmlDownThread.Create;
finalization
  XmlDown.free;

end.                                                                               
