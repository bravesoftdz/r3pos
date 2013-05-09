unit uUcFactory;

interface

uses
  SysUtils, windows, Classes, IdBaseComponent, IdComponent, IdTCPConnection, HttpApp,
  IdTCPClient, IdHTTP, msxml, ComObj, EmbeddedWB, EncDec, IniFiles, IdCookieManager,IdCookie,WinInet;

type
  TUcFactory = class(TDataModule)
    IdHTTP1: TIdHTTP;
    IdCookieManager1: TIdCookieManager;
    procedure DataModuleCreate(Sender: TObject);
    procedure IdCookieManager1NewCookie(ASender: TObject;
      ACookie: TIdCookieRFC2109; var VAccept: Boolean);
  private
    FxsmUC: string;
    FxsmWB: string;
    FxsmChallenge: string;
    FxsmSignature: string;
    FxsmLogined: boolean;
    loginTime:int64;
    FxsmUser: string;
    { Private declarations }
    function CreateXML(xml:string):IXMLDomDocument;
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string;CheckExists:boolean=true):IXMLDOMNode;
    procedure SetxsmUC(const Value: string);
    procedure SetxsmWB(const Value: string);
    procedure SetxsmChallenge(const Value: string);
    procedure SetxsmSignature(const Value: string);
    procedure SetxsmLogined(const Value: boolean);
    function GetxsmLogined: boolean;
    procedure SetxsmUser(const Value: string);
  public
    { Public declarations }
    //��ȡ��У��
    function getChallenge:boolean;
    //�û����뷽ʽ��¼
    function xsmLogin(username,password:string):boolean;
    //�����Ƶ�¼
    function xsmLoginForToken(token:string):boolean;
    //����¼״̬
    function chkLogin(EWB:TEmbeddedWB):boolean;
    //��ȡ��ǰ����
    function getSignature:boolean;
    
    property xsmUC:string read FxsmUC write SetxsmUC;
    property xsmWB:string read FxsmWB write SetxsmWB;
    property xsmChallenge:string read FxsmChallenge write SetxsmChallenge;
    property xsmSignature:string read FxsmSignature write SetxsmSignature;
    property xsmLogined:boolean read GetxsmLogined write SetxsmLogined;

    property xsmUser:string read FxsmUser write SetxsmUser;
  end;

var
  UcFactory: TUcFactory;

implementation

{$R *.dfm}

{ TUcFactory }

function TUcFactory.CreateXML(xml: string): IXMLDomDocument;
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
    on E:Exception do
       begin
         result := nil;
       end;
  end;
end;

function TUcFactory.FindElement(root: IXMLDOMNode; s: string): IXMLDOMNode;
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

function TUcFactory.FindNode(doc: IXMLDomDocument; tree: string;
  CheckExists: boolean): IXMLDOMNode;
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
    if CheckExists and (result = nil) then Raise Exception.Create('���ĵ���û�ҵ����'+tree); 
  finally
    s.Free;
  end;
end;

function TUcFactory.getChallenge: boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  xml,url:string;
begin
  try
    result := false;
    url := xsmUC+'users/forlogin';
    xml := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('�����¼ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ�������У����ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ�������У����ʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('����У����ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
    xsmChallenge := Root.selectSingleNode('challenge').text;
    result := true;
  except
    on E:Exception do
    begin
      Raise;
    end;
  end;
end;

function TUcFactory.getSignature: boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;    
  xml,url:string;
begin
  try
    url := xsmUC+'users/gettoken';
    xml := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('��������ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('��������ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
    xsmSignature := xml;
    loginTime := getTickCount;
    result := true;
  except
    Raise;
  end;
end;

procedure TUcFactory.SetxsmUC(const Value: string);
begin
  FxsmUC := Value;
end;

procedure TUcFactory.SetxsmWB(const Value: string);
begin
  FxsmWB := Value;
end;

function TUcFactory.xsmLogin(username,password:string): boolean;
const
  dec='{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}';
function md5(s:string):string;
begin
  result := md5Encode(s+dec);
end;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  xml:string;
  url:string;
begin
if not getChallenge then Raise Exception.Create('��ȡ����ʧ�ܡ�');
try
  result := false;
  url := xsmUC+'users/dologin/up?j_username='+username+'&j_password='+md5(md5(password)+xsmChallenge);
  xml := IdHTTP1.Get(url);
  xml := Utf8ToAnsi(xml);
  Doc := CreateXML(xml);
  if not Assigned(doc) then Raise Exception.Create('�����¼ʧ��...');
  Root :=  doc.DocumentElement;
  if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
  if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
  if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create(Root.attributes.getNamedItem('msg').text);
  xsmSignature := xml;
  xsmLogined := true;
  xsmUser := username;
  loginTime := getTickCount;
  result := true;
except
  on E:Exception do
  begin
    xsmLogined := false;
    Raise;
  end;
end;
end;

procedure TUcFactory.DataModuleCreate(Sender: TObject);
var
  F:TIniFile;
  List:TStringList;
begin
  xsmLogined := false;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    xsmUC := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if xsmUC='' then
       begin
         xsmUC := 'http://test.xinshangmeng.com/st/';
         xsmWB := 'http://test.xinshangmeng.com/xsm6/';
       end
       else
       begin
         List.CommaText := xsmUC;
         xsmUC := List.Values['xsmc'];
         xsmWB := List.Values['xsm'];
       end;
  finally
    F.Free;
    List.Free;
  end;
end;

procedure TUcFactory.SetxsmChallenge(const Value: string);
begin
  FxsmChallenge := Value;
end;

procedure TUcFactory.SetxsmSignature(const Value: string);
begin
  FxsmSignature := Value;
end;

procedure TUcFactory.SetxsmLogined(const Value: boolean);
begin
  FxsmLogined := Value;
end;

procedure TUcFactory.IdCookieManager1NewCookie(ASender: TObject;
  ACookie: TIdCookieRFC2109; var VAccept: Boolean);
begin
//  messagebox(0,pchar(ACookie.CookieText),'',mb_ok);
//  InternetSetCookie(pchar('xinshangmeng.com'),pchar(ACookie.CookieName),pchar(ACookie.Value+ ';expires=Sun,22-Feb-2099 00:00:00 GMT'));
end;

function TUcFactory.chkLogin(EWB: TEmbeddedWB): boolean;
var
  s:string;
begin
  s := '';
  try
     s := EWB.OleObject.Document.XMLDocument.documentElement.XML;
  except
     s := EWB.OleObject.document.documentelement.innerText;
  end;
  result := pos('code="0000"',s)>0;
end;

function TUcFactory.xsmLoginForToken(token: string): boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  xml:string;
  url:string;
begin
  try
    result := false;
    Doc := CreateXML(token);
    if not Assigned(doc) then Raise Exception.Create('��֤����ʧ��...');
    Root :=  doc.DocumentElement;
    xsmUser := Root.selectSingleNode('/xsm/userId').text;

    url := xsmUC+'tokenconsumer?xmlStr='+HttpEncode(token);
    xml := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('�����¼ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create(Root.attributes.getNamedItem('msg').text);
    xsmSignature := token;
    xsmLogined := true;
    loginTime := getTickCount;
    result := true;
  except
    on E:Exception do
    begin
      xsmLogined := false;
      Raise;
    end;
  end;
end;

function TUcFactory.GetxsmLogined: boolean;
begin
  result := FxsmLogined and ((GetTickCount-LoginTime) < 1000*60*60);
end;

procedure TUcFactory.SetxsmUser(const Value: string);
begin
  FxsmUser := Value;
end;

end.
