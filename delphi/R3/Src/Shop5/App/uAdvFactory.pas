unit uAdvFactory;

interface
uses
  Windows, Messages, Forms, SysUtils, Classes,InvokeRegistry, SOAPHTTPClient, IdHttp, Types, XSBuiltIns,Des,WinInet, xmldom, XMLIntf,
  msxmldom, XMLDoc, MSHTML, ActiveX,msxml,CDO_TLB,ADODB_TLB,ComObj,ZDataSet,DB,ZBase,Variants,ZLogFile,SHDocVw;
type
  PAdvInfo=^TAdvInfo;
  TAdvInfo=record
    Position:integer;
    //1 单文件图片 2 媒体流 3 swf 4 多文件swf
    AdvType:integer;
    urlList:array [0..20] of string;
    linkList:array [0..20] of string;
  end;
  TAdvFactory=class
  private
    Http:TIdHTTP;
    function CreateXML(xml:string):IXMLDomDocument;
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string):IXMLDOMNode;
    function GetNodeValue(root:IXMLDOMNode;s:string):string;
    procedure doAfterExecute(const MethodName: string;
      SOAPResponse: TStream);
  public
    timeout:Integer;
    constructor Create;
    destructor Destroy;override;

    procedure ReadParam;

    function GetUrlStream(url:string;Stream:TStream):boolean;
    function GetUrlFile(url:string;FileName:string):boolean;

    function WBSaveAsMht(mUrl:string;id:string):boolean;

    function GetAllFile(IEBrowser:TWebBrowser):boolean;
    function LoadAllFile(IEBrowser:TWebBrowser):boolean;

    procedure LoadAdv;
    function AdvRequest(Position:integer;var AdvInfo:TAdvInfo):boolean;
    function GetAdvAllFile(AdvInfo:TAdvInfo):boolean;
    function GetAdvInfo(Position:integer):boolean;
  end;
var
  AdvFactory:TAdvFactory;
implementation
uses IniFiles,uCaFactory,ufrmDesk,uShopGlobal;
//var
//  Rim_Url:string;
//  Rim_ComId:string;
//  Rim_CustId:string;
function GetUrlFileName(url:string):string;
var
  list:TStringList;
begin
  list := TStringList.Create;
  try
    list.Delimiter := '/';
    list.DelimitedText := url;
    if list.Count = 0 then
    result := url else
    result := list[list.Count-1];
  finally
    list.free;
  end;
end;
{ TAdvFactory }

function TAdvFactory.AdvRequest(Position: integer;
  var AdvInfo: TAdvInfo): boolean;
var
  sm:TStringStream;
  doc:IXMLDomDocument;
  Node,UrlList:IXMLDOMNode;
  i:integer;
begin
  result := false;
  sm := TStringStream.Create('');
  try
    if not GetUrlStream(Rim_Url+'advRequest/adv.action?comId='+Rim_ComId+'&custId='+Rim_CustId+'&&position='+inttostr(Position),sm) then Exit;
    doc := CreateXML(sm.DataString);
    if doc=nil then Exit;
    Node := FindNode(doc,'header\pub');
    AdvInfo.Position := Position;
    AdvInfo.AdvType := StrtoIntDef(GetNodeValue(Node,'advType'),0);
    Node := FindNode(doc,'body\advinfo');
    UrlList := Node.firstChild;
    for i:=0 to 20 do AdvInfo.urlList[i] := '';
    i:=0;
    while UrlList<>nil do
       begin
         AdvInfo.urlList[i] := UrlList.text;// GetNodeValue(UrlList,'url');
         inc(i);
         UrlList := UrlList.nextSibling;
       end;
    Node := FindNode(doc,'body\linkinfo');
    UrlList := Node.firstChild;
    for i:=0 to 20 do AdvInfo.linkList[i] := '';
    i:=0;
    while UrlList<>nil do
       begin
         AdvInfo.linkList[i] := UrlList.text;//  GetNodeValue(UrlList,'url');
         inc(i);
         UrlList := UrlList.nextSibling;
       end;
    result := true;
  finally
    sm.Free;
  end;
end;

constructor TAdvFactory.Create;
begin
  timeout := 15000;
end;

function TAdvFactory.CreateXML(xml: string): IXMLDomDocument;
var
  ErrXml:string;
  w:integer;
begin
  if ShopGlobal.debug then LogFile.AddLogFile(0,xml);
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    if xml<>'' then
       begin
         if not result.loadXML(xml) then
            begin
              ErrXml :=xml;
              w := pos('?>',ErrXml);
              delete(ErrXml,1,w+1);
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml出错了,xml='+xml);
            end;
       end
    else
       Raise Exception.Create('xml字符串不能为空...');
  except
    result := nil;
    Raise;
  end;
end;

destructor TAdvFactory.Destroy;
begin
  inherited;
end;

procedure TAdvFactory.doAfterExecute(const MethodName: string;
  SOAPResponse: TStream);
begin
  try
    InternetSetOption(nil, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@timeout), SizeOf(timeout));
    InternetSetOption(nil, INTERNET_OPTION_SEND_TIMEOUT, Pointer(@timeout), SizeOf(timeout));
    InternetSetOption(nil, INTERNET_OPTION_RECEIVE_TIMEOUT, Pointer(@timeout), SizeOf(timeout));
  except
    on E:Exception do
       begin
         Raise;
       end;
  end;
end;

function TAdvFactory.FindElement(root: IXMLDOMNode;
  s: string): IXMLDOMNode;
var
  i:integer;
begin
  result := root.firstChild;
  while result<>nil do
    begin
      if result.nodeName=s then exit;
      result := result.nextSibling;
    end;
  result := nil;
end;

function TAdvFactory.FindNode(doc: IXMLDomDocument;
  tree: string): IXMLDOMNode;
var
  s:TStringList;
  i:integer;
begin
  s := TStringList.Create;
  try
    s.Delimiter := '\';
    s.DelimitedText := tree;
    result := doc.documentElement;
    for i:=0 to s.Count -1 do
      begin
        if result <>nil then
           result := FindElement(result,s[i]);
      end;
    if result = nil then Raise Exception.Create('在文档中没找到结点'+tree); 
  finally
    s.Free;
  end;
end;

function TAdvFactory.GetAdvAllFile(AdvInfo: TAdvInfo): boolean;
var
  i:integer;
  adv:TStringList;
begin
  ForceDirectories(ExtractFilePath(ParamStr(0))+'adv\images');
  adv:=TStringList.Create;
  try
    for i:=0 to 20 do
      begin
        if AdvInfo.urlList[i]<>'' then
           begin
             if not FileExists(ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(AdvInfo.urlList[i])) then
                GetUrlFile(AdvInfo.urlList[i],ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(AdvInfo.urlList[i]));
           end;
      end;
    adv.Add('<html>');
    adv.Add('<title>广告</title>');
    adv.Add('<style type="text/css">*{margin:0; border:0; padding:0;}</style>');
    adv.Add('<style type="test/css">a:link{text-decoration:none}</style>');
    if AdvInfo.AdvType = 4 then adv.Add('<script src="adv1.js" type="text/javascript"></script>');
    adv.Add('<body scroll="no" oncontextmenu ="return false">');
    case AdvInfo.AdvType of
    1:adv.Add('<a target="_blank" href="'+AdvInfo.linkList[0]+'"><img alt="" src="'+ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(AdvInfo.urlList[0])+'" /></a>');
    2:adv.Add('<a target="_blank" href="'+AdvInfo.linkList[0]+'"><embed src="'+ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(AdvInfo.urlList[0])+'" type="application/x-shockwave-flash"/></a>');
    3:adv.Add('<a target="_blank" href="'+AdvInfo.linkList[0]+'"><embed src="'+ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(AdvInfo.urlList[0])+'" type="application/x-shockwave-flash"/></a>');
    4:begin
       adv.Add('<link href="adv.css"  rel="stylesheet" type="text/css"/>');
       adv.Add('<div class="container" id="idContainer2">');
       adv.Add('<table id="idSlider2" border="0" cellpadding="0" cellspacing="0">');
       adv.Add('<tr>');
       for i:=0 to 20 do
         begin
            if AdvInfo.urlList[i]<>'' then
               adv.Add('<td><a target="_blank" href="'+AdvInfo.linkList[i]+'"><img src="'+ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(AdvInfo.urlList[i])+'"/></a></td>');
         end;
       adv.Add('</tr>');
       adv.Add('</table>');
       adv.Add('<ul class="num" id="idNum">');
       adv.Add('</ul>');
       adv.Add('</div>');
       adv.Add('<br/>');
       adv.Add('<script src="adv2.js"></script>');
      end;
    end;
    adv.Add('</body>');
    adv.Add('</html>');
    adv.SaveToFile(ExtractFilePath(ParamStr(0))+'adv\adv'+inttostr(AdvInfo.Position)+'.html')
  finally
    adv.Free;
  end;
end;

function TAdvFactory.GetAdvInfo(Position: integer): boolean;
var
  AdvInfo:TAdvInfo;
begin
  try
  result := AdvRequest(Position,AdvInfo);
  if result then
     result := GetAdvAllFile(AdvInfo);
  except
     on E:Exception do
        begin
          result := false;
          LogFile.AddLogFile(0,E.Message);
        end;
  end;
end;

function TAdvFactory.GetAllFile(IEBrowser: TWebBrowser): boolean;
function GetDocFile(Doc: IHTMLDocument2): boolean;
function GetFrame(nFrame: Integer): IWebBrowser2;
var
  pContainer: IOLEContainer;
  enumerator: ActiveX.IEnumUnknown;
  nFetched: PLongInt;
  unkFrame: IUnknown;
  hr: HRESULT;
begin
  Result := nil;
  nFetched := nil;
  // Cast the page as an OLE container
  pContainer := Doc as IOleContainer;
  // Get an enumerator for the frames on the page
  hr := pContainer.EnumObjects(OLECONTF_EMBEDDINGS or OLECONTF_OTHERS, enumerator);
  if hr <> S_OK then
  begin
    pContainer._Release;
    Exit;
  end;
  // Now skip to the frame we're interested in
  enumerator.Skip(nFrame);
  // and get the frame as IUnknown
  enumerator.Next(1,unkFrame, nFetched);
// Now QI the frame for a WebBrowser Interface - I'm not entirely
// sure this is necessary, but COM never ceases to surprise me
  unkframe.QueryInterface(IID_IWebBrowser2, Result);
end;

var url:string;
    Ec:IHTMLElementCollection;
    Fc:IHTMLFramesCollection2;
    Embed:IHTMLEmbedElement;
    iw2:IWebBrowser2;
    i:integer;
    PersistFile: IPersistFile;
begin
  if pos('错误',Doc.title)>0 then Exit;
  if pos('无法显示',Doc.title)>0 then Exit;
  Ec := Doc.embeds;
  if Ec<>nil then
  for i:=0 to Ec.length-1 do
     begin
       Embed := Ec.item(i,EmptyParam) as IHTMLEmbedElement;
       url := Embed.src;
       if pos('http://',url)=0 then continue;
       ForceDirectories(ExtractFilePath(ParamStr(0))+'adv\images');
       if FileExists(ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(url)) then
          begin
            if not GetUrlFile(url,ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(url)) then
               continue;
          end;
     end;
  Fc := Doc.frames;
  for i:=0 to Fc.length -1 do
     begin
       iw2 := GetFrame(i);
       if iw2=nil then continue;
       if iw2.Document=nil then continue;
       GetDocFile(iw2.document as IHTMLDocument2);
     end;
end;
var Doc:IHTMLDocument2;
begin
  result := false;
  if not CaFactory.Audited then Exit;
  Doc := IEBrowser.Document as IHTMLDocument2;
  if Doc=nil then Raise Exception.Create('IE没有找开');
  try
    result := GetDocFile(Doc);
  except
    result := false;
  end;
end;

function TAdvFactory.GetNodeValue(root: IXMLDOMNode; s: string): string;
var
  node:IXMLDOMNode;
begin
  node := FindElement(root,s);
  if node=nil then Raise Exception.Create('XML读取出错，原因：'+s+'结点属性没找到.');
  result := Node.text;
end;

function TAdvFactory.GetUrlFile(url, FileName: string): boolean;
var
  sm:TMemoryStream;
begin
  sm := TMemoryStream.Create;
  try
    result := GetUrlStream(url,sm);
    sm.SaveToFile(FileName); 
  finally
    sm.Free;
  end;
end;

function TAdvFactory.GetUrlStream(url:string;Stream: TStream): boolean;
begin
  try
    LogFile.AddLogFile(0,'下载广告:'+url); 
    Http := TIdHttp.Create(nil);
    try
      Http.HandleRedirects := True;
      Http.ReadTimeout := 15000;
      Stream.Position := 0;
      Http.Get(url,Stream);
      LogFile.AddLogFile(0,'下载完毕:'+url); 
      result := true;
    finally
      Http.Free;
    end;
  except
    result := false;
  end;
end;

procedure TAdvFactory.LoadAdv;
begin
  if not CaFactory.Audited then Exit;
  try
    ReadParam;
    GetAdvInfo(1);
  except
    
  end;
end;

function TAdvFactory.LoadAllFile(IEBrowser: TWebBrowser): boolean;
function UpdateFile(Doc:IHTMLDocument2):boolean;
function GetFrame(nFrame: Integer): IWebBrowser2;
var
  pContainer: IOLEContainer;
  enumerator: ActiveX.IEnumUnknown;
  nFetched: PLongInt;
  unkFrame: IUnknown;
  hr: HRESULT;
begin
  Result := nil;
  nFetched := nil;
  // Cast the page as an OLE container
  pContainer := Doc as IOleContainer;
  // Get an enumerator for the frames on the page
  hr := pContainer.EnumObjects(OLECONTF_EMBEDDINGS or OLECONTF_OTHERS, enumerator);
  if hr <> S_OK then
  begin
    pContainer._Release;
    Exit;
  end;
  // Now skip to the frame we're interested in
  enumerator.Skip(nFrame);
  // and get the frame as IUnknown
  enumerator.Next(1,unkFrame, nFetched);
// Now QI the frame for a WebBrowser Interface - I'm not entirely
// sure this is necessary, but COM never ceases to surprise me
  unkframe.QueryInterface(IID_IWebBrowser2, Result);
end;
var url:string;
    Ec:IHTMLElementCollection;
    Fc:IHTMLFramesCollection2;
    Embed:IHTMLEmbedElement;
    iframe:DispHTMLIFrame;
    iw2:IWebBrowser2;
    i:integer;
    Flags,nurl:OleVariant;
    TargetFrameName: OleVariant;
    PostData: OleVariant;
    Headers: OleVariant;
    _Start:Int64;  
begin
  Ec := Doc.embeds;
  if Ec<>nil then
  for i:=0 to Ec.length-1 do
     begin
       Embed := Ec.item(i,EmptyParam) as IHTMLEmbedElement;
       url := Embed.src;
       if pos('http://',url)=0 then continue;
       Embed.src := ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(url);
     end;
  Fc := Doc.frames;
  for i:=0 to Fc.length -1 do
     begin
       iw2 := GetFrame(i);
       if iw2=nil then continue;
       _Start := GetTickCount;
       while not (IEBrowser.ReadyState in [READYSTATE_INTERACTIVE,READYSTATE_COMPLETE]) do
          begin
            if (GetTickCount-_Start)>20000 then break;
            Application.ProcessMessages;
          end;
       UpdateFile(iw2.document as IHTMLDocument2);
     end;
end;
var
  sm: TMemoryStream;
  _Start:int64;
begin
   _Start := GetTickCount;
   while not (IEBrowser.ReadyState in [READYSTATE_INTERACTIVE,READYSTATE_COMPLETE]) do
      begin
        if (GetTickCount-_Start)>20000 then break;
        Application.ProcessMessages;
      end;
   UpdateFile(IEBrowser.Document as IHTMLDocument2);
end;

procedure TAdvFactory.ReadParam;
var
  F:TIniFile;
  List:TStringList;
begin
  if Rim_ComId<>'' then Exit;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    Rim_Url := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if Rim_Url='' then Rim_Url := 'http://220.173.61.110:9080/rimweb/'
       else
       begin
         List.CommaText := Rim_Url;
         Rim_Url := List.Values['rim'];
         if Rim_Url<>'' then
           begin
             if Rim_Url[Length(Rim_Url)]<>'/' then Rim_Url := Rim_Url+'/';
           end;
       end;
  finally
    List.free;
    try
      F.Free;
    except
    end;
  end;
end;

function TAdvFactory.WBSaveAsMht(mUrl:string;
  id: string): boolean;
var
  vMessage: IMessage;
  vConfiguration: IConfiguration;
  vStream:_Stream;
  mFileName:string;
begin
  LogFile.AddLogFile(0,'开始下载:'+mUrl);
  try
    vMessage := CreateComObject(CLASS_Message) as IMessage;
  except
    on E:Exception do  Raise Exception.Create('vMessage:'+E.Message);
  end;
  try
    vConfiguration := CreateComObject(CLASS_Configuration) as IConfiguration;
  except
    on E:Exception do  Raise Exception.Create('vConfiguration:'+E.Message);
  end;
  try
    vMessage.Configuration := vConfiguration;
    vMessage.CreateMHTMLBody(mURL, cdoSuppressNone,'','');
    vStream := vMessage.GetStream;
    mFileName := ExtractFilePath(ParamStr(0))+'adv\'+id+'.mht';
    vStream.SaveToFile(mFileName, adSaveCreateOverWrite);
    LogFile.AddLogFile(0,'下载完毕:'+mUrl);
  finally
    vMessage := nil;
    vConfiguration := nil;
    vStream := nil;
  end;
end;

initialization
  AdvFactory := TAdvFactory.Create;
  OleInitialize(nil);
finalization
  AdvFactory.Free;
  OleUninitialize;
end.
