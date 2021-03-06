unit rzXmlDown;

interface

uses Windows, XMLIntf, Graphics, XMLDoc, msXml, classes, ComObj, IdBaseComponent, IdComponent,Forms,
     IdTCPConnection, IdTCPClient, IdHTTP, SysUtils, RzCtrls, HttpApp, ActiveX, Jpeg,md5,MultiMon;

type
  TUrlInfo=record
    id:string;
    UrlId:String;
    Url:String;
    resType:integer;
  end;
  PUrlInfo=^TUrlInfo;

type
  PPlaysInfo=^TPlaysInfo;
  TPlaysInfo=record
    srctype:integer;
    srcFlag:integer; //0 url 1 xmlfile
    src:string;
    ApplyUrl:string;
    msgId:string;
    pid:string;
    TryTime:integer;
    token:string;
    stHeader:TStrings;
  end;

  TrzXmlDown=class
  private
    FList:TList;
    XmlDocm:IXMLDOMDocument;
    FTFileSize:int64;
    Fsrc: string;
    idHttp:TidHttp;
    Fpid: string;
    FmsgId: string;
    Fapply: string;
    function GetUrlInfo(itemindex: integer): PUrlInfo;
    function GetCount: integer;
    procedure IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure Setsrc(const Value: string);
    procedure Setpid(const Value: string);
    procedure SetmsgId(const Value: string);
    function PutFile(url, filename: string;stHeader:TStrings=nil): boolean;
    procedure Setapply(const Value: string);
  protected
    procedure ReadPlayList(Root:IXMLDOMNode);
    procedure ReadProgramList(Root:IXMLDOMNode);
    procedure AddPhoto(Root:IXMLDOMNode);
    procedure AddVideo(Root:IXMLDOMNode);
    procedure AddMusic(Root:IXMLDOMNode);
    procedure Open(FileName:String;readPlays:boolean=true);
    procedure DoRedirect(Sender: TObject; var dest: String;
      var NumRedirect: Integer; var Handled: Boolean;
      var VMethod: TIdHTTPMethod);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function DownFile(src:string;filename:string):boolean;
    function GetFile(src:string;filename:string):boolean;
    function DownAllRes:boolean;
    function DownHeader:boolean;
    function SendStatus(flag:integer;msg:string='';token:string='1234567890'):boolean;
    function ApplyStatus(src,s:string):boolean;
    procedure AddToPlays;

    function GetScreenBmp:string;
    function SendLog(Plays:PPlaysInfo):string;
    procedure SendScn(Plays:PPlaysInfo);
    procedure UpdateLog(Plays:PPlaysInfo);
    procedure ClearRes(Play:PPlaysInfo);

    property UrlInfo[itemindex:integer]:PUrlInfo read GetUrlInfo;
    property Count:integer read GetCount;
    property src:string read Fsrc write Setsrc;
    property pid:string read Fpid write Setpid;
    property msgId:string read FmsgId write SetmsgId;
    property apply:string read Fapply write Setapply;
  end;
  TXmlDownThread=class(TThread)
  private
    Down:TrzXmlDown;
    Event:THandle;
    FList:TList;
    procedure Execute; override;
    procedure Clear;
    procedure Load;
  public
    constructor Create;
    destructor Destroy; override;

    procedure CloseThread;
    procedure DownSrc(srctype:integer;src,msgId,pId,apply,token:string;stHeader:TStrings=nil);
    procedure DownXml(xml:string);
    procedure DownPrm(xml:string);
    procedure DownFile_Test(url:string;filename:string);
    procedure Play;
  end;

var XmlDown:TXmlDownThread;
    PosHWND: HWND = 0;

implementation
uses ufrmRzPlayer,ipc,ScrnCtrl;
var mdc,cdc:HDC;
function EnumMonitorsProc(hm: HMONITOR; dc: HDC; r: PRect; Data: Pointer): Boolean; stdcall;
begin
  if hm=MMonitor.Handle then mdc := dc else cdc := dc;
  Result := True;
end;
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
      Url_Info^.id := Node.selectSingleNode('photoId').text;
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
      Url_Info^.id := Node.selectSingleNode('videoId').text;
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
        3:filename := AppData+'\res\music\'+UrlInfo[i]^.UrlId;
        end;
        if FileExists(filename) then continue;
        if downfile(UrlInfo[i]^.Url,filename) then
           Plays.WriteString('res',UrlInfo[i]^.id,formatDatetime('YYYYMMDDHHNNSS',now()));
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
var
  fFile:TFileStream;
  idHTTP:TidHTTP;
  lastModify:string;
  Etag:string;
  ext:string;
  mm:TMemoryStream;
begin
  result := false;
  ForceDirectories(ExtractFileDir(filename));
  idHTTP := TidHTTP.Create(nil);
  try
      idHTTP.OnWork := IdHTTPWork;
      idHTTP.OnRedirect := DoRedirect;
      idHTTP.ProtocolVersion := pv1_1 ;
      idHTTP.HandleRedirects := true;
      IdHTTP.Head(src);
      lastModify := IdHTTP.Response.RawHeaders.Values['Last-Modified'];
      Etag := IdHTTP.Response.RawHeaders.Values['Etag'];
      ext := MD5Print(MD5String(lastModify+Etag));
      if ext='' then ext := 'tmp';
      FTFileSize := StrtoInt64Def(IdHTTP.Response.RawHeaders.Values['Content-Length'],0);
      SendDebug('信息“'+filename+'”->Last-Modified:'+lastModify+' Etag:'+Etag+' Content-Length:'+inttostr(FTFileSize),4);
      if (FTFileSize<=0) then
      begin
         deletefile(filename+'.'+ext);
         fFile := TFileStream.Create(filename+'.'+ext,fmCreate);
         try
           IdHTTP.Get(src,FFile);
         finally
           fFile.Free;
         end;
      end
      else
      begin
         if not fileExists(filename+'.'+ext) then
           fFile := TFileStream.Create(filename+'.'+ext,fmCreate)
         else
           fFile := TFileStream.Create(filename+'.'+ext,fmOpenReadWrite);
         mm := TMemoryStream.Create;
         try
            fFile.Seek(0,soEnd);
            while fFile.Position<FTFileSize do
               begin
                 if XmlDown.Terminated then Exit;
                 IdHttp.Request.ContentRangeStart := fFile.Position;
                 IdHttp.Request.ContentRangeEnd   := fFile.Position+1024*20;
                 //SendDebug('分块下载->Content-Range:'+inttostr(IdHttp.Request.ContentRangeStart)+'-'+inttostr(IdHttp.Request.ContentRangeEnd),4);
                 mm.Clear;
                 IdHTTP.Get(src,mm);
                 mm.Position := 0;
                 fFile.CopyFrom(mm,mm.Size); 
               end;
         finally
            mm.Free;
            fFile.Free;
         end;
      end;
  finally
    idHTTP.Free;
  end;
  deletefile(pchar(filename));
  if not renamefile(filename+'.'+ext,filename) then
     begin
       deletefile(pchar(filename+'.'+ext));
       Raise Exception.Create('下载"'+src+'"失败了.');
     end;
  SendDebug('下载“'+src+'”完毕',4);
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

  Node := Root.selectSingleNode('musicElList');
  if Node <> nil then
  begin
    Node := Node.firstChild;
    while Node <> nil do
    begin
      if Node.nodeName = 'musicEl' then
         AddMusic(Node);
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

procedure TrzXmlDown.Open(FileName: String;readPlays:boolean=true);
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
  if readPlays then
     begin
       msgId := Plays.readString(pid,'msgId','');
       apply := Plays.readString(pid,'apply','');
     end;
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
  try
    filename := AppData+'\temp\play'+formatDatetime('yyyymmddhhnnss',now())+'.xml';
    Getfile(src,filename);
    try
      open(filename,false);
      result := true;
    finally
      deletefile(pchar(filename));
    end;
    SendStatus(2);
  except
    on E:Exception do
       begin
          SendStatus(3,E.Message);
          Raise;
       end;
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

function TrzXmlDown.SendStatus(flag: integer;msg:string='';token:string='1234567890'): boolean;
var
  Request,Response:TStringStream;
  s:string;
  idHTTP:TidHTTP;
begin
  try
    if apply='' then Exit;
    s :='messageId='+msgId+'&userCode='+username+'&status='+inttostr(flag)+'&log='+HTTPEncode(msg)+'&token='+token;

    Response := TStringStream.Create('');
    Request := TStringStream.Create(s);
    idHTTP := TidHTTP.Create(nil);
    try
      idHTTP.OnWork := IdHTTPWork;
      idHTTP.OnRedirect := DoRedirect;
      idHttp.HandleRedirects := true;
      IdHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
      idHttp.Post(apply,Request,Response);
      SendDebug(apply+'->'+s+'发送成功',4);
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

function TrzXmlDown.PutFile(url:string;filename: string;stHeader:TStrings=nil): boolean;
var fFile:TFileStream;
  idHTTP:TidHTTP;
  w:integer;
  upUrl:string;
begin
  result := false;
  w := pos('?',url);
  upUrl := stringreplace(URL,'[replaceName]',ExtractFileName(filename),[rfReplaceAll]);

  fFile := TFileStream.Create(filename,fmShareDenyNone);
  idHTTP := TidHTTP.Create(nil);
  try
      idHTTP.OnWork := IdHTTPWork;
      idHTTP.OnRedirect := DoRedirect;
      idHttp.HandleRedirects := true;
      idHttp.Request.CustomHeaders.Clear;
      idHttp.Request.CustomHeaders.AddStrings(stHeader);
      try
        IdHTTP.Put(upUrl,FFile);
      except
        on E:Exception do
           begin
             if pos('Cannot assign requested address',E.Message)=0 then Raise; 
           end;
      end;
  finally
    idHTTP.Free;
    fFile.Free;
  end;
  SendDebug('上传“'+filename+'”完毕',4);
  result := true;
end;

function TrzXmlDown.GetScreenBmp: string;
var
  B: TBitmap;
  S: string;
  i,l,t,bm,h,w:integer;
  JPEG: TJPEGImage;
  dc:HDC;
begin
//  EnumDisplayMonitors(0, nil, @EnumMonitorsProc, 0);
  w := 0;
  h := 0;
  t := 0;
  bm := 0;
  for i:=0 to Screen.MonitorCount-1 do
  begin
    w := w + Screen.Monitors[i].Width;
    if Screen.Monitors[i].BoundsRect.Top<t then t := Screen.Monitors[i].BoundsRect.Top;
    if Screen.Monitors[i].BoundsRect.Left<l then l := Screen.Monitors[i].BoundsRect.Left;
    if Screen.Monitors[i].BoundsRect.Bottom>bm then bm := Screen.Monitors[i].BoundsRect.Bottom;
    h := bm - t + 1;
  end;
    B := TBitmap.Create;
    JPEG := TJPEGImage.Create;
//    if Screen.Monitors[i]=MMonitor then
//    dc := GetDc(mdc) else
    dc := GetDc(0);
    try
      B.PixelFormat := pf32bit;
      B.Width := w;// GetSystemMetrics(SM_CXSCREEN);
      B.Height := h;// GetSystemMetrics(SM_CYSCREEN);
      BitBlt(B.Canvas.handle,0,0, B.Width, B.Height,dc, l, t, SRCCOPY);
      JPEG.Assign(B);
      //if Screen.Monitors[i].Primary then
      result := Appdata+'\logs\main_screen.jpg';
      //else
      //   result := Appdata+'\logs\client_screen.jpg';
      deletefile(result);
      JPEG.SaveToFile(result);

    finally
      ReleaseDC(0,dc);
      JPEG.Free;
      b.Free;
    end;
//  end;
  {
    B := TBitmap.Create;
    JPEG := TJPEGImage.Create;
    dc := GetDc(0);
//    dc := GetWindowDC(frmRzPlayer.frmRzMonitor.Handle);
    try
      B.PixelFormat := pf32bit;
      B.Width :=  frmRzPlayer.frmRzMonitor.Width;
      B.Height := frmRzPlayer.frmRzMonitor.Height;

      BitBlt(B.Canvas.handle, 0, 0, B.Width, B.Height,dc, 0, 0, SRCCOPY);
      JPEG.Assign(B);
      result := Appdata+'\logs\client_screen.jpg';
      deletefile(result);
      JPEG.SaveToFile (result);
    finally
      ReleaseDC(frmRzPlayer.frmRzMonitor.Handle,dc);
      JPEG.Free;
      b.Free;
    end;
  end;       }
end;

function TrzXmlDown.SendLog(Plays:PPlaysInfo):string;
var
  sr: TSearchRec;
  FileAttrs: Integer;
  msg:string;
begin
  try
  result := '';
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(appdata+'\logs\*.log', FileAttrs, sr) = 0 then
    begin
      repeat
        begin
          PutFile(Plays^.src,appdata+'\logs\'+sr.Name,Plays^.stHeader);
          if result<>'' then result := result+',';
          result := result+sr.Name;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
    msg :='messageId='+Plays^.msgId+'&filename='+result+'&status=0&terminalType='+inttostr(Plays^.srcType)+'&userCode='+username+'&token='+Plays^.token;
  except
    on E:Exception do
       begin
         msg :='messageId='+Plays^.msgId+'&filename='+result+'&status=1&terminalType='+inttostr(Plays^.srcType)+'&userCode='+username+'&token='+Plays^.token;
         SendDebug(E.Message,1);
       end;
  end;
  ApplyStatus(Plays^.ApplyUrl,msg);
end;

procedure TrzXmlDown.SendScn(Plays:PPlaysInfo);
var
  msg,filename:string;
begin
  try
    filename := GetScreenBmp;
    PutFile(Plays^.src,Appdata+'\logs\main_screen.jpg',Plays^.stHeader);
    //PutFile(Plays^.src,Appdata+'\logs\client_screen.jpg');
    msg :='messageId='+Plays^.msgId+'&filename=main_screen.jpg&status=0&terminalType='+inttostr(Plays^.srcType)+'&userCode='+username+'&token='+Plays^.token;
  except
    on E:Exception do
       begin
         msg :='messageId='+Plays^.msgId+'&filename=&status=1&terminalType='+inttostr(Plays^.srcType)+'&userCode='+username+'&token='+Plays^.token;
         SendDebug(E.Message,1);
       end;
  end;
  ApplyStatus(Plays^.ApplyUrl,msg);
end;

function TrzXmlDown.ApplyStatus(src,s: string): boolean;
var
  Request,Response:TStringStream;
  idHTTP:TidHTTP;
begin
  if src='' then Exit;
  try
    Response := TStringStream.Create('');
    Request := TStringStream.Create(s);
    idHTTP := TidHTTP.Create(nil);
    try
      idHTTP.OnWork := IdHTTPWork;
      idHTTP.OnRedirect := DoRedirect;
      idHttp.HandleRedirects := true;
      IdHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
      idHttp.Post(src,Request,Response);
      SendDebug(src+'->'+s+'发送成功',4);
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

procedure TrzXmlDown.Setapply(const Value: string);
begin
  Fapply := Value;
end;

procedure TrzXmlDown.UpdateLog(Plays: PPlaysInfo);
var
  msg:string;
begin
  try
    if pos('FATAL',Plays.src)>0 then logFlag[1] := '1' else logFlag[1] := '0';
    if pos('ERROR',Plays.src)>0 then logFlag[2] := '1' else logFlag[2] := '0';
    if pos('WARN',Plays.src)>0 then logFlag[3] := '1' else logFlag[3] := '0';
    if pos('INFO',Plays.src)>0 then logFlag[4] := '1' else logFlag[4] := '0';
    if pos('DEBUG',Plays.src)>0 then logFlag[5] := '1' else logFlag[5] := '0';
    if pos('ALL',Plays.src)>0 then logFlag[6] := '1' else logFlag[6] := '0';
    msg :='messageId='+Plays^.msgId+'&status=0&token='+Plays^.token;
  except
    on E:Exception do
       begin
         msg :='messageId='+Plays^.msgId+'&status=1&token='+Plays^.token;
         SendDebug(E.Message,1);
       end;
  end;
  ApplyStatus(Plays^.ApplyUrl,msg);
end;

procedure TrzXmlDown.ClearRes(Play: PPlaysInfo);
procedure ClearAll(day:integer=-1);
var
  sr: TSearchRec;
  FileAttrs,w: Integer;
  s,p:string;
begin
  if day<0 then
  begin
    SendMessage(Application.MainForm.Handle,WM_PLAY_CLOSE,0,0);
  end;
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(appdata+'\res\photo\*.*', FileAttrs, sr) = 0 then
    begin
      repeat
        begin
          s := sr.Name;
          w := length(ExtractFileExt(sr.Name));
          delete(s,length(s)-w+1,w);
          if (s<>'') and (s<>'.') and (s<>'..') then
             begin
                p := copy(Plays.readString('res',s,''),1,8);
                if (p<>'') or (day<0) then
                   begin
                     if (day<0) or (p<formatDatetime('YYYYMMDD',now()-day)) then
                        begin
                          if deletefile(appdata+'\res\photo\'+sr.Name) then
                          plays.DeleteKey('res',s);
                        end;
                   end;
             end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(appdata+'\res\vedio\*.*', FileAttrs, sr) = 0 then
    begin
      repeat
        begin
          s := sr.Name;
          w := length(ExtractFileExt(sr.Name));
          delete(s,length(s)-w+1,w);
          if (s<>'') and (s<>'.') and (s<>'..') then
             begin
                p := copy(Plays.readString('res',s,''),1,8);
                if (p<>'') or (day<0) then
                   begin
                     if (day<0) or (p<formatDatetime('YYYYMMDD',now()-day)) then
                        begin
                          if deletefile(appdata+'\res\vedio\'+sr.Name) then
                          plays.DeleteKey('res',s);
                        end;
                   end;
             end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  if day>=0 then Exit;
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(appdata+'\adv\*.*', FileAttrs, sr) = 0 then
    begin
      repeat
        begin
          //s := sr.Name;
          //w := length(ExtractFileExt(sr.Name));
          //delete(s,length(s)-w,w);
          if (s<>'') and (s<>'.') and (s<>'..') then
             begin
                deletefile(appdata+'\adv\'+sr.Name);
             end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  SendDebug('----------清理资源结束-------------',4);
end;
var
  msg:string;
begin
  try
  if Play.src='RESET' then
     begin
       ClearAll;
     end
  else
     begin
       resDay := StrtoIntDef(Play^.src,30);
       ClearAll(resDay);
     end;
     msg :='messageId='+Play^.msgId+'&status=0&token='+Play^.token;
  except
    on E:Exception do
       begin
         msg :='messageId='+Play^.msgId+'&status=1&token='+Play^.token;
         SendDebug(E.Message,1);
       end;
  end;
  ApplyStatus(Play^.ApplyUrl,msg);
end;

procedure TrzXmlDown.DoRedirect(Sender: TObject; var dest: String;
  var NumRedirect: Integer; var Handled: Boolean;
  var VMethod: TIdHTTPMethod);
begin
//  SendDebug('<'+inttostr(NumRedirect)+'>重定向url='+dest,4);
end;

procedure TrzXmlDown.AddMusic(Root: IXMLDOMNode);
var Node:IXMLDOMNode;
    Url_Info:PUrlInfo;
begin
  Node := Root.selectSingleNode('musicList');
  Node := Node.firstChild;
  while Node <> nil do
  begin
    if Node.nodeName = 'music' then
    begin
      new(Url_Info);
      Url_Info^.id := Node.selectSingleNode('musicId').text;
      Url_Info^.UrlId := Node.selectSingleNode('musicId').text+ExtractFileExt(Node.selectSingleNode('musicName').text);
      Url_Info^.Url := Node.selectSingleNode('path').text;
      Url_Info^.resType := 3;
      FList.Add(Url_Info);
    end;
    Node := Node.nextSibling;
  end;
end;

function TrzXmlDown.GetFile(src, filename: string): boolean;
var fFile:TFileStream;
  idHTTP:TidHTTP;
begin
  result := false;
  ForceDirectories(ExtractFileDir(filename));
  fFile := TFileStream.Create(filename+'.ft',fmCreate);
  idHTTP := TidHTTP.Create(nil);
  try
      idHTTP.OnWork := IdHTTPWork;
      idHTTP.OnRedirect := DoRedirect;
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
  SendDebug('下载“'+src+'”完毕',4);
  result := true;
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
  WaitFor;
  inherited;
  Clear;
  FList.Free;
  Down.Free;
end;

procedure TXmlDownThread.DownSrc(srctype:integer;src,msgId,pId,apply,token: string;stHeader:TStrings=nil);
var
  Plays:PPlaysInfo;
begin
  new(Plays);
  Plays^.srctype := srctype;
  Plays^.srcFlag := 0;
  Plays^.src := src;
  Plays^.msgId := msgId;
  Plays^.pid := pId;
  Plays^.ApplyUrl := apply;
  Plays^.TryTime := 0;
  Plays^.token := token;
  Plays^.stHeader := stHeader;
  FList.Insert(0,Plays);
  SetEvent(Event);
end;

procedure TXmlDownThread.DownXml(xml: string);
var
  Doc:IXMLDOMDocument;
  node:IXMLDOMNode;
  msgId,pId,url,ptype,applyurl,token:string;
  stHeader:TStrings;
begin
  Doc := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  Doc.loadXML(xml);
  node := Doc.documentElement;
  if node=nil then Raise Exception.Create('无效的命令格式:'+xml);
  stHeader := TStringList.Create;
  try
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
      if node.attributes.getNamedItem('key').nodeValue='type' then
         begin
           ptype := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='token' then
         begin
           token := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='interface' then
         begin
           applyurl := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='playbillId' then
         begin
           pId := node.attributes.getNamedItem('value').nodeValue;
         end;

      //新指令
      if node.attributes.getNamedItem('key').nodeValue='messageId' then
         begin
           msgId := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='content' then
         begin
           url := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='code' then
         begin
           if node.attributes.getNamedItem('value').nodeValue='PLAYBILL_UPDATE' then
              ptype := '1'
           else
           if node.attributes.getNamedItem('value').nodeValue='LOG_LEVEL_MODIFY' then
              ptype := '3'
           else
           if node.attributes.getNamedItem('value').nodeValue='COMMAND_EXECUTE' then
              ptype := '4'
           else
           if node.attributes.getNamedItem('value').nodeValue='RESOURCE_CLEAN_STRATEGY' then
              ptype := '5'
           else
           if node.attributes.getNamedItem('value').nodeValue='LOG_UPLOAD' then
              ptype := '6'
           else
           if node.attributes.getNamedItem('value').nodeValue='SCREENSHOT_UPLOAD' then
              ptype := '7';
         end;
      if node.attributes.getNamedItem('key').nodeValue='api' then
         begin
           applyurl := node.attributes.getNamedItem('value').nodeValue;
         end;
      if node.attributes.getNamedItem('key').nodeValue='content-header' then
         begin
           stHeader.Add(node.attributes.getNamedItem('value').nodeValue)
         end;
      node := node.nextSibling;
    end;
    if stHeader.Count>0 then
       DownSrc(StrtoIntDef(ptype,0),url,msgId,pId,applyurl,token,stHeader)
    else
       DownSrc(StrtoIntDef(ptype,0),url,msgId,pId,applyurl,token,nil);
  except
    stHeader.Free;
    Raise;
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
  while not Terminated and not Application.Terminated do
    begin
//      if (FList.Count = 0) then
//         begin
//           WaitForSingleObject(Event,INFINITE);
//           resetEvent(Event);
//         end
//      else
//         begin
           WaitForSingleObject(Event,60000);
           resetEvent(Event);
//         end;
      if not Terminated and not Application.Terminated and (FList.Count > 0) then
         begin
           Plays := PPlaysInfo(FList[0]);
           Plays.TryTime := Plays.TryTime + 1;
           if Plays.TryTime>3 then
              begin
                FList.Remove(Plays);
                if assigned(Plays^.stHeader) then freeandnil(Plays^.stHeader);
                dispose(Plays);
                continue;
              end;
           try
             case Plays^.srctype of
             1:begin
                 case Plays^.srcFlag of
                 0:begin
                     Down.src := Plays^.src;
                     Down.msgId := Plays^.msgId;
                     Down.apply := Plays^.applyUrl;
                     if Down.DownHeader then
                     begin
                       Plays^.srcFlag := 1;
                       Plays^.src :=AppData+'\adv\'+down.pid+'.xml';
                       if Plays^.pid<>'' then
                          begin
                            RzCtrls.Plays.WriteString(Plays^.pid,'msgId',Plays^.msgId);
                            RzCtrls.Plays.WriteString(Plays^.pid,'apply',Plays^.applyUrl);
                          end;
                       if Down.DownAllRes then
                          begin
                            FList.Remove(Plays);
                            if assigned(Plays^.stHeader) then freeandnil(Plays^.stHeader);
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
                          if assigned(Plays^.stHeader) then freeandnil(Plays^.stHeader);
                          dispose(Plays);
                          SendMessage(Application.MainForm.Handle,WM_PLAY_START,0,0);
                        end;
                   end;
                 2:begin
                     try
                       DownXml(Plays^.src);
                     finally
                       FList.Remove(Plays);
                       if assigned(Plays^.stHeader) then freeandnil(Plays^.stHeader);
                       dispose(Plays);
                     end;
                   end;
                 end;
               end;
             3:begin //设置LOG参数
                 try
                   Down.UpdateLog(Plays);
                 finally
                   FList.Remove(Plays);
                   if assigned(Plays^.stHeader) then freeandnil(Plays^.stHeader);
                   dispose(Plays);
                 end;
               end;
             5:begin //资源清除
                 try
                   Down.ClearRes(Plays);
                 finally
                   FList.Remove(Plays);
                   if assigned(Plays^.stHeader) then freeandnil(Plays^.stHeader);
                   dispose(Plays);
                 end;
               end;
             6:begin //日志上传
                 try
                   Down.SendLog(Plays);
                 finally
                   FList.Remove(Plays);
                   if assigned(Plays^.stHeader) then freeandnil(Plays^.stHeader);
                   dispose(Plays);
                 end;
               end;
             7:begin //截屏上传
                 try
                   Down.SendScn(Plays);
                 finally
                   FList.Remove(Plays);
                   if assigned(Plays^.stHeader) then freeandnil(Plays^.stHeader);
                   dispose(Plays);
                 end;
               end;
             end;
           except
             on E:Exception do
                begin
                  try
                    if (FList.IndexOf(Plays)>=0) and (FList.Count > 1) then
                       FList.Move(FList.IndexOf(Plays),FList.Count-1);
                    SendDebug('第'+inttostr(Plays^.TryTime)+'次执行"'+Plays^.src+'"失败了，错误原因：'+e.Message,1);
                  except
                    ;
                  end;
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
             node^.srctype := 1;
             node^.srcFlag := 1;
             node^.src := filename;
             node^.TryTime := 0;
             node^.stHeader := nil;
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
  node^.srctype := 1;
  node^.srcFlag := 2;
  node^.src := xml;
  node^.TryTime := 0;
  node^.stHeader := nil;
  FList.Insert(0,node);
  SetEvent(Event);
end;

procedure TXmlDownThread.DownFile_Test(url, filename: string);
begin
  Down.DownFile(url,filename); 
end;

procedure TXmlDownThread.CloseThread;
begin
  Terminate;
  SetEvent(Event);
end;

initialization
  if not hExists then
     XmlDown := TXmlDownThread.Create;
finalization
  if not hExists then
     XmlDown.free;

end.
