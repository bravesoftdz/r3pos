unit uXsmCacheFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, msxml, ZLogFile, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, OleCtrls, SHDocVw, uGlobal, ComObj;

type
  TXsmCacheFactory = class(TForm)
    IdHTTP1: TIdHTTP;
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    UrlAddr,xsm:String;
    FLoadError: BOOL;
    FLoadNum: Integer;
    function createXml(Xml:String):IXMLDOMDocument;
    procedure Loader(Url:String);
    procedure LoadVersionXml;
    procedure LoadVersionChildXml(Nodes:IXMLDOMNodeList;Str,ParentNodeName:String);
    procedure Load_GWGCorCs_Xml(Url:String);
    procedure Load_GWGCorCs_ChildXml(Nodes:IXMLDOMNodeList;Str,ParentNodeName:String);
  public
    { Public declarations }
    property LoadNum:Integer read FLoadNum;
    property LoadError:BOOL read FLoadError;
  end;

var
  XsmCacheFactory: TXsmCacheFactory;

implementation

{$R *.dfm}

{ TXsmCacheFactory }

function TXsmCacheFactory.createXml(Xml: String): IXMLDOMDocument;
var
  ErrXml:string;
  w:integer;
begin
  if Global.debug then LogFile.AddLogFile(0,xml);
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    if xml<>'' then
       begin
         if not result.loadXML(xml) then
            begin
              ErrXml :=xml;
              w := pos('?v',ErrXml);
              delete(ErrXml,1,w+1);
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml≥ˆ¥Ì¡À,xml='+xml);
            end;
       end
    else begin
      FLoadError := False;
      Raise Exception.Create('xml◊÷∑˚¥Æ≤ªƒ‹Œ™ø’...');
    end;
  except
    on E:Exception do
       begin
         result := nil;
         FLoadError := False;
         LogFile.AddLogFile(0,e.Message);
       end;
  end;
end;

procedure TXsmCacheFactory.Loader(Url: String);
begin
  try
    if Trim(Url) = '' then Exit;
    WebBrowser1.Navigate(Url);
    while WebBrowser1.ReadyState < READYSTATE_COMPLETE do
      Application.ProcessMessages;
  except
    FLoadError := False;
    
    Raise;
    Exit;
  end;
  Inc(FLoadNum);
end;

procedure TXsmCacheFactory.Load_GWGCorCs_ChildXml(Nodes: IXMLDOMNodeList; Str,
  ParentNodeName: String);
var Root:IXMLDOMElement;
    ChildUrl:String;
    i:Integer;
begin
  for i := 0 to Nodes.length - 1 do
    begin
      if not (Nodes.item[i].nodeType = NODE_ELEMENT) then Continue;
      Root := Nodes.item[i] as IXMLDOMElement;
      ChildUrl := xsm+Str+VarToStr(Root.getAttribute('id'));
      Loader(ChildUrl);
    end;
end;

procedure TXsmCacheFactory.Load_GWGCorCs_Xml(Url:String);
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  Nodes:IXMLDOMNodeList;
  i:Integer;
  xml,GWGCUrl,MapDir:string;
begin
  try
    xml := IdHTTP1.Get(Url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('«Î«Û¡Ó≈∆ ß∞‹...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Urlµÿ÷∑∑µªÿŒﬁ–ßXMLŒƒµµ£¨«Î«Û¡Ó≈∆ ß∞‹...');
    MapDir := Root.getAttribute('dir');
    Nodes := Root.childNodes;
    for i := 0 to Nodes.length - 1 do
      begin
        if not (Nodes.item[i].nodeType = NODE_ELEMENT) then Continue;
        if (Nodes.item[i].nodeName = 'background') or (Nodes.item[i].nodeName = 'ItemDefinitions') then
        begin
          if Nodes.item[i].hasChildNodes then
          begin
            Root := Nodes.item[i] as IXMLDOMElement;
            Load_GWGCorCs_ChildXml(Nodes.item[i].childNodes,MapDir,Nodes.item[i].nodeName);
          end else
          begin
            Root := Nodes.item[i] as IXMLDOMElement;
            GWGCUrl := xsm+MapDir+VarToStr(Root.getAttribute('file'));
            Loader(GWGCUrl);
          end;
        end;
      end;
    //if Root.attributes.getNamedItem('Versionfiles')=nil then Raise Exception.Create('Urlµÿ÷∑∑µªÿŒﬁ–ßXMLŒƒµµ£¨«Î«Û¡Ó≈∆ ß∞‹...');
    //if Root.attributes.getNamedItem('id').text<>'0000' then Raise Exception.Create('«Î«Û¡Ó≈∆ ß∞‹,¥ÌŒÛ:'+Root.attributes.getNamedItem('msg').text);
    //result := true;
  except
    Raise;
  end;
end;

procedure TXsmCacheFactory.LoadVersionChildXml(Nodes: IXMLDOMNodeList; Str,
  ParentNodeName: String);
var Root:IXMLDOMElement;
    ChildUrl,AttributeValue:String;
    i:Integer;
begin
  for i := 0 to Nodes.length - 1 do
    begin
      if not (Nodes.item[i].nodeType = NODE_ELEMENT) then Continue;
      Root := Nodes.item[i] as IXMLDOMElement;
      AttributeValue := UpperCase(VarToStr(Root.getAttribute('id')));
      if (AttributeValue = UpperCase('CS.XML')) or (AttributeValue = UpperCase('GWGC.XML')) then
      begin
        ChildUrl := xsm+Str+'/'+VarToStr(Root.getAttribute('id'))+'?v='+VarToStr(Root.getAttribute('v'));
        Load_GWGCorCs_Xml(ChildUrl);
      end else
      begin
        ChildUrl := xsm+Str+'/'+VarToStr(Root.getAttribute('id'))+'?v='+VarToStr(Root.getAttribute('v'));
        Loader(ChildUrl);
      end;
    end;
end;

procedure TXsmCacheFactory.LoadVersionXml;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  Nodes:IXMLDOMNodeList;
  Node:IXMLDOMNode;
  Attr:IXMLDOMAttribute;
  i:Integer;
  xml,Str_url:string;
begin
  try
    xml := IdHTTP1.Get(xsm+'VersionFiles.xml?v='+IntToStr(gettickcount));
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('«Î«Û¡Ó≈∆ ß∞‹...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Urlµÿ÷∑∑µªÿŒﬁ–ßXMLŒƒµµ£¨«Î«Û¡Ó≈∆ ß∞‹...');
    Nodes := Root.childNodes;
    for i := 0 to Nodes.length - 1 do
      begin
        if not (Nodes.item[i].nodeType = NODE_ELEMENT) then Continue;
        if Nodes.item[i].nodeName = 'f' then
        begin
          Root := Nodes.item[i] as IXMLDOMElement;
          Str_url := xsm+VarToStr(Root.getAttribute('id')+'?v='+VarToStr(Root.getAttribute('v')));
          Loader(Str_url);
        end;
        if Nodes.item[i].hasChildNodes then
        begin
          Root := Nodes.item[i] as IXMLDOMElement;
          LoadVersionChildXml(Nodes.item[i].childNodes,VarToStr(Root.getAttribute('id')),Nodes.item[i].nodeName);
        end;
      end;
    //if Root.attributes.getNamedItem('Versionfiles')=nil then Raise Exception.Create('Urlµÿ÷∑∑µªÿŒﬁ–ßXMLŒƒµµ£¨«Î«Û¡Ó≈∆ ß∞‹...');
    //if Root.attributes.getNamedItem('id').text<>'0000' then Raise Exception.Create('«Î«Û¡Ó≈∆ ß∞‹,¥ÌŒÛ:'+Root.attributes.getNamedItem('msg').text);
    //result := true;
  except
    FLoadError := false;
    Raise;
  end;
end;

procedure TXsmCacheFactory.FormCreate(Sender: TObject);
begin
  FLoadError := True;
  FLoadNum := 0;
  xsm := 'http://gx.xinshangmeng.com/xsm2/';
end;

procedure TXsmCacheFactory.FormShow(Sender: TObject);
begin
  LoadVersionXml;

end;

end.
