unit uAdvFactory;

interface
uses
  Windows, Messages, Forms, SysUtils, Classes,InvokeRegistry, SOAPHTTPClient, IdHttp, Types, XSBuiltIns,Des,WinInet, xmldom, XMLIntf,
  msxmldom, XMLDoc, MSHTML, ActiveX,msxml,ComObj,ZDataSet,DB,ZBase,Variants,ZLogFile,SHDocVw;
type
  PAdvInfo=^TAdvInfo;
  TAdvInfo=record
    Position:integer;
    //1 ���ļ�ͼƬ 2 ý���� 3 swf 4 ���ļ�swf
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
  public
    constructor Create;
    destructor Destroy;override;

    procedure ReadParam;
    
    function GetUrlStream(url:string;Stream:TStream):boolean;
    function GetUrlFile(url:string;FileName:string):boolean;

    function GetAllFile(IEBrowser:TWebBrowser;id:string):integer;
    function LoadAllFile(IEBrowser:TWebBrowser;id:string):integer;

    procedure LoadAdv;
    function AdvRequest(Position:integer;var AdvInfo:TAdvInfo):boolean;
    function GetAdvAllFile(AdvInfo:TAdvInfo):boolean;
    function GetAdvInfo(Position:integer):boolean;
  end;
var
  AdvFactory:TAdvFactory;
implementation
uses IniFiles,uCaFactory,ufrmDesk;
var
  Rim_Url:string;
  Rim_ComId:string;
  Rim_CustId:string;
function GetUrlFileName(url:string):string;
var
  list:TStringList;
begin
  list := TStringList.Create;
  try
    list.Delimiter := '/';
    list.DelimitedText := url;
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
    AdvInfo.AdvType := StrtoInt(GetNodeValue(Node,'advType'));
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
end;

function TAdvFactory.CreateXML(xml: string): IXMLDomDocument;
var
  ErrXml:string;
  w:integer;
begin
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    if xml<>'' then
       begin
         if not result.loadXML(xml) then
            begin
              ErrXml :=xml;
              w := pos('?>',ErrXml);
              delete(ErrXml,1,w+1);
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml������,xml='+xml);
            end;
       end
    else
       Raise Exception.Create('xml�ַ�������Ϊ��...');
  except
    result := nil;
    Raise;
  end;
end;

destructor TAdvFactory.Destroy;
begin
  inherited;
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
    if result = nil then Raise Exception.Create('���ĵ���û�ҵ����'+tree); 
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
           GetUrlFile(AdvInfo.urlList[i],ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(AdvInfo.urlList[i]));
      end;
    adv.Add('<html>');
    adv.Add('<title>���</title>');
    adv.Add('<style type="test/css">a:link{text-decoration:none}</style>');
    adv.Add('<style type="text/css">html,body{margin:0; border:0; padding:0}</style>');
    if AdvInfo.AdvType = 4 then adv.Add('<script src="adv1.js" type="text/javascript"></script>');
    adv.Add('<body scroll="no">');
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
               adv.Add('<td><img src="'+ExtractFilePath(ParamStr(0))+'adv\images\'+GetUrlFileName(AdvInfo.urlList[i])+'"/></td>');
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
    adv.SaveToFile(ExtractFilePath(ParamStr(0))+'adv\adv1.html')
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

function TAdvFactory.GetAllFile(IEBrowser: TWebBrowser;
  id: string): integer;
function GetUrl(url:string):string;
var
  s:TStringList;
begin
  s := TStringList.Create;
  try
    s.Delimiter := '/';
    s.DelimitedText := url;
    s.Delete(s.Count-1);
    result := s.DelimitedText; 
  finally
    s.Free;
  end;
end;  
var url:string;
    Doc:IHTMLDocument2;
    Ec:IHTMLElementCollection;
    Embed:IHTMLEmbedElement;
    img:IHTMLImgElement;
    i:integer;
    PersistFile: IPersistFile;
begin
  if not CaFactory.Audited then Exit;
  Doc := IEBrowser.Document as IHTMLDocument2;
  if Doc=nil then Raise Exception.Create('IEû���ҿ�');
  if pos('����',Doc.title)>0 then Exit;
  result := 0;
  try
  Ec := Doc.embeds;
  if Ec<>nil then
  for i:=0 to Ec.length-1 do
     begin
       Embed := Ec.item(i,EmptyParam) as IHTMLEmbedElement;
       url := Embed.src;
       if pos('http://',url)=0 then Exit;
       ForceDirectories(ExtractFilePath(ParamStr(0))+'adv\images\'+id);
       if not GetUrlFile(url,ExtractFilePath(ParamStr(0))+'adv\images\'+id+'\'+GetUrlFileName(url)) then
          continue;
       Embed.src := ExtractFilePath(ParamStr(0))+'adv\images\'+id+'\'+GetUrlFileName(url);
       inc(result);
     end;
  Ec := Doc.images;
  if Ec<>nil then
  for i:=0 to Ec.length-1 do
     begin
       img := Ec.item(i,EmptyParam) as IHTMLImgElement;
       url := img.src;
       if pos('http://',url)=0 then Exit;
       ForceDirectories(ExtractFilePath(ParamStr(0))+'adv\images\'+id);
       if not GetUrlFile(url,ExtractFilePath(ParamStr(0))+'adv\images\'+id+'\'+GetUrlFileName(url)) then
          continue;
       img.src := ExtractFilePath(ParamStr(0))+'adv\images\'+id+'\'+GetUrlFileName(url);
       inc(result);
     end;
  PersistFile := Doc as IPersistFile;
  PersistFile.Save(StringToOleStr(ExtractFilePath(ParamStr(0))+'adv\'+id+'.html'),True);
  except
    result := 0;
  end;
end;

function TAdvFactory.GetNodeValue(root: IXMLDOMNode; s: string): string;
var
  node:IXMLDOMNode;
begin
  node := FindElement(root,s);
  if node=nil then Raise Exception.Create('XML��ȡ������ԭ��'+s+'�������û�ҵ�.');
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
    Http := TIdHttp.Create(nil);
    try
      Stream.Position := 0;
      Http.Get(url,Stream);
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
  ReadParam;
  GetAdvInfo(1);  
end;

function TAdvFactory.LoadAllFile(IEBrowser: TWebBrowser;
  id: string): integer;
var
  sm: TMemoryStream;
begin
  if not FileExists(ExtractFilePath(ParamStr(0))+'adv\'+id+'.html') then Exit;
  IEBrowser.Navigate('about:blank');
  frmDesk.Waited := true;
  sm := TMemoryStream.Create;
  try
    while not Assigned(IEBrowser.Document) do Application.ProcessMessages;
    sm.LoadFromFile(ExtractFilePath(ParamStr(0))+'adv\'+id+'.html');
    sm.Position := 0;
    (IEBrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(sm));
  finally
    sm.Free;
    frmDesk.Waited := false;
  end;
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
    F.Free;
  end;
  Rim_ComId := 'LZ0000000000001';
  Rim_CustId := 'GX00000004392';
end;

initialization
  AdvFactory := TAdvFactory.Create;
finalization
  AdvFactory.Free;
end.