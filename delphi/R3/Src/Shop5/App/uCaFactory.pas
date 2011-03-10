unit uCaFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,Des,WinInet, xmldom, XMLIntf,
  msxmldom, XMLDoc, MSHTML, ActiveX,msxml,ComObj;
type
  TCaTenant=record
    TENANT_ID:integer;
    LOGIN_NAME:string;
    TENANT_NAME:string;
    TENANT_TYPE:integer;
    SHORT_TENANT_NAME:string;
    TENANT_SPELL:string;
    LICENSE_CODE:String;
    LEGAL_REPR:string;
    LINKMAN:string;
    TELEPHONE:string;
    FAXES:string;
    MSN:string;
    QQ:string;
    HOMEPAGE:string;
    ADDRESS:string;
    POSTALCODE:string;
    REMARK:string;
    PASSWRD:string;
    REGION_ID:string;
    SRVR_ID:string;
    PROD_ID:string;
    AUDIT_STATUS:string;
  end;
  TCaLogin=record
    TENANT_ID:integer;
    RET:string;
    SLL:string;
    HOST_NAME:string;
    SRVR_PORT:integer;
    DB_ID:integer;
    SRVR_PATH:string;
  end;

  rsp = class(TSOAPHeader)
  private
    FencryptType: integer;
    FrspSessionId: string;
    procedure SetencryptType(const Value: integer);
    procedure SetrspSessionId(const Value: string);
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property rspSessionId:string read FrspSessionId write SetrspSessionId;
    property encryptType:integer read FencryptType write SetencryptType;
  end;

  TCaFactory=class
  private
    FSSL: string;
    FURL: string;
    Fsslpwd: string;
    Fpubpwd: string;
    procedure SetSSL(const Value: string);
    procedure SetURL(const Value: string);
    procedure Setpubpwd(const Value: string);
    procedure Setsslpwd(const Value: string);
  protected
    function Encode(inxml:String;Key:string):String;
    function Decode(inxml:String;Key:string):String;
  public
    constructor Create;
    destructor Destroy;override;

    function CreateRio:THTTPRIO;

    function GetHeader(rio:THTTPRIO):rsp;
    function SendHeader(rio:THTTPRIO):rsp;
    function  CreateXML(xml:string):IXMLDomDocument;
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string):IXMLDOMNode;
    function GetNodeValue(root:IXMLDOMNode;s:string):string;
    procedure CheckRecAck(doc:IXMLDomDocument);

    function CheckNetwork:boolean;
    function coLogin(Account:string;PassWrd:string):TCaLogin;
    function coRegister(Info:TCaTenant):TCaTenant;
    function coGetList(TENANT_ID:string):TCaTenant;

    property SSL:string read FSSL write SetSSL;
    property URL:string read FURL write SetURL;
    //公共密码
    property pubpwd:string read Fpubpwd write Setpubpwd;
    //临时密码
    property sslpwd:string read Fsslpwd write Setsslpwd;
  end;
var CaFactory:TCaFactory;
implementation
uses EncDec,ZLibExGZ,encddecd,CaTenantService,IniFiles;
{ TCaFactory }

procedure TCaFactory.CheckRecAck(doc: IXMLDomDocument);
var
  node:IXMLDOMNode;
begin
  if not Assigned(doc) then Raise Exception.Create('无效的XML文档...');
  node :=  doc.documentElement;
  if not Assigned(node) then Raise Exception.Create('无效的XML文档...');
  if node.nodeName<>'message' then Raise Exception.Create('无效的XML跟双方协议不相符...');
  node := FindElement(node,'header');
  if not Assigned(node) then Exception.Create('无效的XML跟双方协议不相符...');
  node := FindElement(node,'pub');
  if not Assigned(node) then Exception.Create('无效的XML跟双方协议不相符...');
  node := FindElement(node,'recAck');
  if not Assigned(node) then Exception.Create('无效的XML跟双方协议不相符...');
  if node.text<>'0000' then
     begin
       node := FindElement(node.parentNode,'msg');
       Raise Exception.Create(node.text);
     end;
end;

function TCaFactory.CheckNetwork: boolean;
begin
  result := InternetCheckConnection(PChar(URL), 1, 0);
end;

function TCaFactory.coGetList(TENANT_ID: string): TCaTenant;
begin
  Result.TENANT_ID := 1000001;
end;

function TCaFactory.coLogin(Account, PassWrd: string): TCaLogin;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caTenantLoginResp:IXMLDOMNode;
  code:string;
  h:rsp;
begin
  inxml :=
  '<?xml version="1.0" encoding="gb2312"?> '+
  '<message> '+
  '  <header> '+
  '    <pub> '+
  '      <flag>1</flag> '+
  '    </pub> '+
  '  </header> '+
  '  <body> '+
  '    <caTenant> '+
  '     <loginName>'+Account+'</loginName> '+
  '     <passwrd>'+PassWrd+'</passwrd>'+
  '    </caTenant> '+
  '  </body> '+
  '</message> ';
  rio := CreateRio;
  try
    h := SendHeader(rio);
    try
    doc := CreateXML(
                 Decode(
                    GetCaTenantWebServiceImpl(true,URL,rio).login(Encode(inxml,'SaRi0+jf'))
                    ,'SaRi0+jf'
                 )
           );
    finally
      h.Free;
    end;
    if h.encryptType <> 1 then Raise Exception.Create('无效加密类型...');
    CheckRecAck(doc);
    caTenantLoginResp := FindNode(doc,'body\caTenantLoginResp');
    code := GetNodeValue(caTenantLoginResp,'code');
    if StrtoIntDef(code,0) in [1,4] then //认证成功
       begin
         result.TENANT_ID := StrtoInt(GetNodeValue(caTenantLoginResp,'tenantid'));
         result.RET := GetNodeValue(caTenantLoginResp,'code');
         result.SLL := GetNodeValue(caTenantLoginResp,'keyStr');
         result.HOST_NAME := GetNodeValue(caTenantLoginResp,'hostNmae');
         result.SRVR_PORT := StrtoInt(GetNodeValue(caTenantLoginResp,'srvrPort'));
         result.SRVR_PATH := GetNodeValue(caTenantLoginResp,'srvrPath');
         result.DB_ID := StrtoInt(GetNodeValue(caTenantLoginResp,'dbid'));
       end
    else
       Raise Exception.Create(GetNodeValue(caTenantLoginResp,'desc'));

  finally
    rio.Free;
  end;
end;

function TCaFactory.coRegister(Info: TCaTenant): TCaTenant;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caTenantLoginResp:IXMLDOMNode;
  code:string;
  h:rsp;
begin
  inxml :=
  '<?xml version="1.0" encoding="gb2312"?> '+
  '<message> '+
  '  <header> '+
  '    <pub> '+
  '      <flag>1</flag> '+
  '    </pub> '+
  '  </header> '+
  '  <body> '+
  '    <caTenant> '+
  '    <loginName>登录名</loginName> '+
  '    <tenantName>企业名称</tenantName> '+
  '    <shortTenantName>简称</ shortTenantName > '+
  '    <tenantSpell>拼音码</ tenantSpell > '+
  '    <tenantType>企业类型</tenantType> '+
  '    <passwrd>密码</passwrd> '+
  '    <legalRepr>法人</legalRepr> '+
  '    <linkman>联系人</linkman> '+
  '    <telephone>电话</telephone> '+
  '    <faxes>传真</faxes> '+
  '    <linkman>联系人</linkman> '+
  '    <homepage>主页</homepage> '+
  '    <address>地址</address> '+
  '    <postalcode>邮编</postalcode> '+
  '    <qq>QQ</qq> '+
  '    <msn>MSN</msn> '+
  '    <remark>备注</remark> '+
  '    <regionId>地区</regionId> '+
  '    </caTenant> '+
  '  </body> '+
  '</message> ';
  rio := CreateRio;
  try
    h := SendHeader(rio);
    try
    doc := CreateXML(
                 Decode(
                    GetCaTenantWebServiceImpl(true,URL,rio).login(Encode(inxml,'SaRi0+jf'))
                    ,'SaRi0+jf'
                 )
           );
    finally
      h.Free;
    end;
    if h.encryptType <> 1 then Raise Exception.Create('无效加密类型...');
    CheckRecAck(doc);
    caTenantLoginResp := FindNode(doc,'body\caTenantLoginResp');
    code := GetNodeValue(caTenantLoginResp,'code');
    if StrtoIntDef(code,0) in [1,4] then //认证成功
       begin
         result.TENANT_ID := StrtoInt(GetNodeValue(caTenantLoginResp,'tenantid'));
         result.RET := GetNodeValue(caTenantLoginResp,'code');
         result.SLL := GetNodeValue(caTenantLoginResp,'keyStr');
         result.HOST_NAME := GetNodeValue(caTenantLoginResp,'hostNmae');
         result.SRVR_PORT := StrtoInt(GetNodeValue(caTenantLoginResp,'srvrPort'));
         result.SRVR_PATH := GetNodeValue(caTenantLoginResp,'srvrPath');
         result.DB_ID := StrtoInt(GetNodeValue(caTenantLoginResp,'dbid'));
       end
    else
       Raise Exception.Create(GetNodeValue(caTenantLoginResp,'desc'));

  finally
    rio.Free;
  end;
end;

constructor TCaFactory.Create;
var
  f:TIniFile;
begin
  f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    URL := f.ReadString('CaFactory','url','http://10.10.11.249/services/CaTenantService?wsdl');
    pubpwd := '';
  finally
    f.Free;
  end;
end;

function TCaFactory.CreateRio: THTTPRIO;
begin
  result := THTTPRIO.Create(nil); 
end;

function TCaFactory.CreateXML(xml: string): IXMLDomDocument;
begin
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    result.loadXML(xml);
  except
    result := nil;
    Raise;
  end;
end;

function TCaFactory.Decode(inxml: string;Key:string): string;
var
  gzip:string;
  DecStr:string;
begin
  DecStr := encddecd.DecodeString(inxml);
  if Key='' then
  gzip := DecStr else
  gzip := DecryStr(DecStr,Key);
  GZDecompressString(result,gzip);
end;

destructor TCaFactory.Destroy;
begin
  inherited;
end;

function TCaFactory.Encode(inxml: String;Key:string): String;
var
  gzip:String;
  EncStr:String;
begin
  GZCompressString(gzip,inxml);
  if Key='' then
  EncStr := gzip else
  EncStr := EncryStr(gzip,Key);
  result := encddecd.EncodeString(EncStr);
end;

procedure TCaFactory.Setpubpwd(const Value: string);
begin
  Fpubpwd := Value;
end;

procedure TCaFactory.SetSSL(const Value: string);
begin
  FSSL := Value;
end;

procedure TCaFactory.Setsslpwd(const Value: string);
begin
  Fsslpwd := Value;
end;

procedure TCaFactory.SetURL(const Value: string);
begin
  FURL := Value;
end;

function TCaFactory.FindElement(root:IXMLDOMNode;s: string): IXMLDOMNode;
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

function TCaFactory.FindNode(doc: IXMLDomDocument;
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

function TCaFactory.GetNodeValue(root: IXMLDOMNode; s: string): string;
var
  node:IXMLDOMNode;
begin
  node := FindElement(root,s);
  if node=nil then Raise Exception.Create('XML读取出错，原因：'+s+'结点属性没找到.');
  result := Node.text;
end;

function TCaFactory.GetHeader(rio: THTTPRIO): rsp;
begin
  result := rsp(rio.SOAPHeaders.Get(rsp));
end;

function TCaFactory.SendHeader(rio: THTTPRIO):rsp;
begin
  result := rsp.Create;
  result.rspSessionId := 'sdkfjdskfd';
  result.encryptType := 1;
  rio.SOAPHeaders.Send(result);
end;

{ rsp }

constructor rsp.Create;
begin
  inherited;

end;

destructor rsp.Destroy;
begin

  inherited;
end;

procedure rsp.SetencryptType(const Value: integer);
begin
  FencryptType := Value;
end;

procedure rsp.SetrspSessionId(const Value: string);
begin
  FrspSessionId := Value;
end;

initialization
  CaFactory := TCaFactory.Create;
  InvRegistry.RegisterInterface(TypeInfo(CaTenantWebServiceImpl), 'http://www.rspcn.com.cn/rsp', 'gb2312');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CaTenantWebServiceImpl), 'http://www.rspcn.com.cn/rsp#%operationName%');
  InvRegistry.RegisterHeaderClass(TypeInfo(CaTenantWebServiceImpl), rsp, 'rsp', 'http://www.rspcn.com.cn/rsp');
  RemClassRegistry.RegisterXSClass(rsp, 'http://www.rspcn.com.cn/rsp', 'rsp');
finalization
  CaFactory.Free;
end.

