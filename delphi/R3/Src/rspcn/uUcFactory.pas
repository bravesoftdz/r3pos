unit uUcFactory;

interface

uses
  SysUtils, windows, Classes, IdBaseComponent, IdComponent, IdTCPConnection, HttpApp, Forms,ZBase,
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
    FxsmSignature: UTF8String;
    FxsmLogined: boolean;
    loginTime:int64;
    FxsmUser: string;
    FscWeb: string;
    FecWeb: string;
    FrimWB: string;
    FrimCustId: string;
    FrimComId: string;
    { Private declarations }
    function CreateXML(xml:string):IXMLDomDocument;
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string;CheckExists:boolean=true):IXMLDOMNode;
    procedure SetxsmUC(const Value: string);
    procedure SetxsmWB(const Value: string);
    procedure SetxsmChallenge(const Value: string);
    procedure SetxsmSignature(const Value: UTF8String);
    procedure SetxsmLogined(const Value: boolean);
    function GetxsmLogined: boolean;
    procedure SetxsmUser(const Value: string);
    procedure SetecWeb(const Value: string);
    procedure SetscWeb(const Value: string);
    procedure SetrimWB(const Value: string);
    procedure SetrimComId(const Value: string);
    procedure SetrimCustId(const Value: string);
  public
    { Public declarations }
    //读取导航地址
    function getModule:boolean;
    //读取验校码
    function getChallenge:boolean;
    //用户密码方式登录
    function xsmLogin(username,password:string):boolean;
    //登录RIM
    function rimLogin:boolean;
    //用令牌登录
    function xsmLoginForToken(token:string):boolean;
    //检测登录状态
    function chkLogin(EWB:TEmbeddedWB):boolean;
    //读取当前令牌
    function getSignature:boolean;

    //读取新商盟主机
    function getxsmWBHost:string;
    property xsmUC:string read FxsmUC write SetxsmUC;
    property xsmWB:string read FxsmWB write SetxsmWB;
    property rimWB:string read FrimWB write SetrimWB;
    property ecWeb:string read FecWeb write SetecWeb;
    property scWeb:string read FscWeb write SetscWeb;
    property xsmChallenge:string read FxsmChallenge write SetxsmChallenge;
    property xsmSignature:UTF8String read FxsmSignature write SetxsmSignature;
    property xsmLogined:boolean read GetxsmLogined write SetxsmLogined;

    property xsmUser:string read FxsmUser write SetxsmUser;
    property rimComId:string read FrimComId write SetrimComId;
    property rimCustId:string read FrimCustId write SetrimCustId;
  end;

var
  UcFactory: TUcFactory;

implementation
uses udataFactory,uTokenFactory;
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
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml出错了,xml='+xml);
            end;
       end
    else
       Raise Exception.Create('xml字符串不能为空...');
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
    if CheckExists and (result = nil) then Raise Exception.Create('在文档中没找到结点'+tree); 
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
    if not Assigned(doc) then Raise Exception.Create('请求登录失败...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求校验码失败...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求校验码失败...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('请求校验码失败,错误:'+Root.attributes.getNamedItem('msg').text);
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
    xsmSignature := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xsmSignature);
    xsmSignature := StringReplace(xml,'"utf-8"','"GBK"',[rfReplaceAll]);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('请求令牌失败...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求令牌失败...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求令牌失败...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('请求令牌失败,错误:'+Root.attributes.getNamedItem('msg').text);
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
getModule;
if not getChallenge then Raise Exception.Create('读取令牌失败。');
try
  result := false;
  url := xsmUC+'users/dologin/up?j_username='+username+'&j_password='+md5(md5(password)+xsmChallenge);
  xsmSignature := IdHTTP1.Get(url);
  xml := Utf8ToAnsi(xsmSignature);
  xsmSignature := StringReplace(xml,'"utf-8"','"GBK"',[rfReplaceAll]);
  Doc := CreateXML(xml);
  if not Assigned(doc) then Raise Exception.Create('请求登录失败...');
  Root :=  doc.DocumentElement;
  if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求登录失败...');
  if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求登录失败...');
  if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create(Root.attributes.getNamedItem('msg').text);
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

procedure TUcFactory.SetxsmSignature(const Value: UTF8String);
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
  getModule;
  try
    result := false;
    Doc := CreateXML(token);
    if not Assigned(doc) then Raise Exception.Create('验证令牌失败...');
    Root :=  doc.DocumentElement;
    xsmUser := Root.selectSingleNode('/xsm/userId').text;
    if pos(token,'"utf-8"')>0 then
       begin
         token := Utf8ToAnsi(token);
         token := StringReplace(token,'"utf-8"','"GBK"',[rfReplaceAll]);
       end;
    url := xsmUC+'tokenconsumer?xmlStr='+HttpEncode(token);
    xml := IdHTTP1.Get(url);
    Doc := CreateXML(xml);
    xml := Utf8ToAnsi(xml);
    if not Assigned(doc) then Raise Exception.Create('请求登录失败...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求登录失败...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求登录失败...');
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

function TUcFactory.getxsmWBHost: string;
var sl:TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Delimiter := '/';
    sl.DelimitedText := xsmWB;
  finally
    sl.Free;
  end;
end;

function TUcFactory.getModule: boolean;
var
  F:TIniFile;
  List:TStringList;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    xsmUC := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if xsmUC='' then
       begin
         xsmUC := 'http://test.xinshangmeng.com/st/';
         xsmWB := 'http://test.xinshangmeng.com/xsm6/';
         rimWB := 'http://test.xinshangmeng.com/rimweb';
         ecWeb := 'http://test.xinshangmeng.com/ecweb/';
         scWeb := 'http://test.xinshangmeng.com/scweb/';
       end
       else
       begin
         List.CommaText := xsmUC;
         xsmUC := List.Values['xsmc'];
         xsmWB := List.Values['xsm'];
         rimWB := List.Values['rim'];
         ecWeb := List.Values['ecweb'];
         scWeb := List.Values['scweb'];
       end;
  finally
    F.Free;
    List.Free;
  end;
end;

procedure TUcFactory.SetecWeb(const Value: string);
begin
  FecWeb := Value;
end;

procedure TUcFactory.SetscWeb(const Value: string);
begin
  FscWeb := Value;
end;

procedure TUcFactory.SetrimWB(const Value: string);
begin
  FrimWB := Value;
end;

procedure TUcFactory.SetrimComId(const Value: string);
begin
  FrimComId := Value;
end;

procedure TUcFactory.SetrimCustId(const Value: string);
begin
  FrimCustId := Value;
end;

function TUcFactory.rimLogin: boolean;
var
  Params:TftParamList;
  msg:string;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Msg := dataFactory.Remote.ExecProc('TRimWsdlService',Params);
    Params.Decode(Params,Msg);
    rimComId := Params.ParambyName('rimcid').AsString;
    rimCustId := Params.ParambyName('xsmuid').AsString;
    if rimCustId='' then rimCustId := Params.ParambyName('rimuid').AsString;
    if rimCustId='' then Raise Exception.Create('当前登录门店的许可证号无效，请输入修改正确的许可证号.');
    result := true;
  finally
    Params.Free;
  end;
end;

end.
