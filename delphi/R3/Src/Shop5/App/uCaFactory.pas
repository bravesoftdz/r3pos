unit uCaFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,Des,WinInet, xmldom, XMLIntf,
  msxmldom, XMLDoc, MSHTML, ActiveX,msxml,ComObj;
  //, IdBaseComponent, IdComponent, IdRawBase, IdRawClient, IdIcmpClient, Forms;
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
    DB_ID:string;
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
  
  TCaUpgrade=record
    UpGrade:integer;
    URL:string;
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
    FSessionId: string;
    timeout:Integer;
    procedure SetSSL(const Value: string);
    procedure SetURL(const Value: string);
    procedure Setpubpwd(const Value: string);
    procedure Setsslpwd(const Value: string);
    procedure SetSessionId(const Value: string);
    procedure doAfterExecute(const MethodName: string;
      SOAPResponse: TStream);
  protected
    function Encode(inxml:String;Key:string):String;
    function Decode(inxml:String;Key:string):String;
  public
    constructor Create;
    destructor Destroy;override;

    function CreateRio(_timeOut:integer=-1):THTTPRIO;

    function CheckUpgrade(TENANT_ID,PROD_ID,CurVeraion:string):TCaUpgrade;

    function GetHeader(rio:THTTPRIO):rsp;
    function SendHeader(rio:THTTPRIO;flag:integer=1):rsp;
    function CreateXML(xml:string):IXMLDomDocument;
    function CreateRspXML:IXMLDomDocument;
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string):IXMLDOMNode;
    function GetNodeValue(root:IXMLDOMNode;s:string):string;
    procedure CheckRecAck(doc:IXMLDomDocument);

    function CheckNetwork(addr:string=''):boolean;
    function coLogin(Account:string;PassWrd:string):TCaLogin;
    function coRegister(Info:TCaTenant):TCaTenant;
    function coGetList(TENANT_ID:string):TCaTenant;

    property SSL:string read FSSL write SetSSL;
    property URL:string read FURL write SetURL;
    //公共密码
    property pubpwd:string read Fpubpwd write Setpubpwd;
    //临时密码
    property sslpwd:string read Fsslpwd write Setsslpwd;
    //通讯会话
    property SessionId:string read FSessionId write SetSessionId;
  end;
var CaFactory:TCaFactory;
implementation
uses EncDec,ZLibExGZ,uGlobal,encddecd,CaTenantService,CaProductService,IniFiles;
{ TCaFactory }

procedure TCaFactory.doAfterExecute(const MethodName: string; SOAPResponse: TStream);
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

function TCaFactory.CheckNetwork(addr:string=''): boolean;
function GetHost:string;
var
  List:TStringList;
begin
  List:=TStringList.Create;
  try
    List.Delimiter := '/';
    if addr='' then List.DelimitedText := url else List.DelimitedText := addr;
    result := '';
    while List.Count>0 do
      begin
       if List[0]='' then List.Delete(0)
       else
       if uppercase(List[0])='HTTP:' then List.Delete(0)
       else
          begin
            result := List[0];
            Exit;
          end;
      end;
  finally
    List.Free;
  end;
end;
function InternetConnected: Boolean;
const
// local system uses a modem to connect to the Internet.
INTERNET_CONNECTION_MODEM = 1;
// local system uses a local area network to connect to the Internet.
INTERNET_CONNECTION_LAN = 2;
// local system uses a proxy server to connect to the Internet.
INTERNET_CONNECTION_PROXY = 4;
// local system's modem is busy with a non-Internet connection.
INTERNET_CONNECTION_MODEM_BUSY = 8;
var
dwConnectionTypes : DWORD;
begin
  dwConnectionTypes := INTERNET_CONNECTION_MODEM+ INTERNET_CONNECTION_LAN
  + INTERNET_CONNECTION_PROXY;
  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
end;
//var
//  Icmp:TIdIcmpClient;
begin
  result := InternetConnected;
//  Exit;
{  Icmp := TIdIcmpClient.Create(nil);
  try
    Icmp.OnReply := ICMPReply;
    Icmp.ReceiveTimeout := 500;
    Icmp.Host := 'www.163.com';
    Icmp.Ping('12345678901234567890'); 
    result:= (Icmp.ReplyStatus.BytesReceived > 0);
  finally
    Icmp.Free;
  end;  }
end;

function TCaFactory.coGetList(TENANT_ID: string): TCaTenant;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caTenant:IXMLDOMNode;
  Node:IXMLDOMNode;
  code:string;
  h:rsp;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '3';
  FindNode(doc,'header\pub').appendChild(Node);
  
  Node := doc.createElement('caTenant');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := TENANT_ID;
  FindNode(doc,'body\caTenant').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(10000);
  try
    h := SendHeader(rio,2);
    try
      try
        doc := CreateXML(
                     Decode(
                        GetCaTenantWebServiceImpl(true,URL+'CaTenantService?wsdl',rio).getTenantInfo(Encode(inxml,sslpwd))
                        ,sslpwd
                     )
               );
      except
        on E:Exception do
           begin
             if pos('Empty document',E.Message)>0 then
                begin
                  Raise Exception.Create('无法连接到RSP认证服务器，请检查网络是否正常.');
                end
             else
                Raise;
           end;
      end;
    finally
      h.Free;
    end;
    CheckRecAck(doc);
    caTenant := FindNode(doc,'body\caTenant');
    result.TENANT_ID := StrtoInt(GetNodeValue(caTenant,'tenantId'));
    result.LOGIN_NAME := GetNodeValue(caTenant,'loginName');
    result.TENANT_NAME := GetNodeValue(caTenant,'tenantName');
    result.SHORT_TENANT_NAME := GetNodeValue(caTenant,'shortTenantName');
    result.TENANT_SPELL := GetNodeValue(caTenant,'tenantSpell');
    result.TENANT_TYPE := StrtoInt(GetNodeValue(caTenant,'tenantType'));
    result.LICENSE_CODE := GetNodeValue(caTenant,'licenseCode');
    result.LEGAL_REPR := GetNodeValue(caTenant,'legalRepr');
    result.LINKMAN := GetNodeValue(caTenant,'linkman');
    result.TELEPHONE := GetNodeValue(caTenant,'telephone');
    result.FAXES := GetNodeValue(caTenant,'faxes');
    result.HOMEPAGE := GetNodeValue(caTenant,'homepage');
    result.ADDRESS := GetNodeValue(caTenant,'address');
    result.POSTALCODE := GetNodeValue(caTenant,'postalcode');
    result.PASSWRD := GetNodeValue(caTenant,'passwrd');
    result.QQ := GetNodeValue(caTenant,'qq');
    result.MSN := GetNodeValue(caTenant,'msn');
    result.REMARK := GetNodeValue(caTenant,'remark');
//    result.SRVR_ID := GetNodeValue(caTenant,'srvrId');
    result.PROD_ID := GetNodeValue(caTenant,'prodId');
    result.DB_ID := GetNodeValue(caTenant,'dbId');
    result.AUDIT_STATUS := GetNodeValue(caTenant,'auditStatus');
  finally
    rio.Free;
  end;    
end;

function TCaFactory.coLogin(Account, PassWrd: string): TCaLogin;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caTenantLoginResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  code:string;
  h:rsp;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);
  
  Node := doc.createElement('caTenant');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('loginName');
  Node.text := Account;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('passwrd');
  Node.text := PassWrd;
  FindNode(doc,'body\caTenant').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(10000);
  try
    h := SendHeader(rio,1);
    try
      try
      doc := CreateXML(
                   Decode(
                      GetCaTenantWebServiceImpl(true,URL+'CaTenantService?wsdl',rio).login(Encode(inxml,pubpwd))
                      ,pubpwd
                   )
             );
      except
        on E:Exception do
           begin
             if pos('Empty document',E.Message)>0 then
                begin
                  Raise Exception.Create('无法连接到RSP认证服务器，请检查网络是否正常.');
                end
             else
                Raise;
           end;
      end;
    finally
      h.Free;
    end;

    GetHeader(rio).free;
    CheckRecAck(doc);
    caTenantLoginResp := FindNode(doc,'body\caTenantLoginResp');
    code := GetNodeValue(caTenantLoginResp,'code');
    result.RET := code;
    if StrtoIntDef(code,0) in [1,5] then //认证成功
       begin
         result.TENANT_ID := StrtoInt(GetNodeValue(caTenantLoginResp,'tenantId'));
         sslpwd := encddecd.DecodeString(GetNodeValue(caTenantLoginResp,'keyStr'));
         result.SLL := sslpwd;
         if code = '1' then
            begin
              result.HOST_NAME := GetNodeValue(caTenantLoginResp,'hostNmae');
              result.SRVR_PORT := StrtoInt(GetNodeValue(caTenantLoginResp,'srvrPort'));
              result.SRVR_PATH := GetNodeValue(caTenantLoginResp,'srvrPath');
              result.DB_ID := StrtoInt(GetNodeValue(caTenantLoginResp,'dbId'));
            end;
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
  caTenantRegisterResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  code:string;
  h:rsp;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);
  
  Node := doc.createElement('caTenant');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('loginName');
  Node.text := Info.LOGIN_NAME;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('tenantName');
  Node.text := Info.TENANT_NAME;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('shortTenantName');
  Node.text := Info.SHORT_TENANT_NAME;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('licenseCode');
  Node.text := Info.LICENSE_CODE;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('tenantSpell');
  Node.text := Info.TENANT_SPELL;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('tenantType');
  Node.text := '3';
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('passwrd');
  Node.text := Info.PASSWRD;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('legalRepr');
  Node.text := Info.LEGAL_REPR;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('linkman');
  Node.text := Info.LINKMAN;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('telephone');
  Node.text := Info.TELEPHONE;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('faxes');
  Node.text := Info.FAXES;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('homepage');
  Node.text := Info.HOMEPAGE;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('address');
  Node.text := Info.ADDRESS;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('postalcode');
  Node.text := Info.POSTALCODE;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('qq');
  Node.text := Info.QQ;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('msn');
  Node.text := Info.MSN;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('remark');
  Node.text := Info.REMARK;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('regionId');
  Node.text := Info.REGION_ID;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('prodId');
  Node.text := ProductId;
  FindNode(doc,'body\caTenant').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(10000);
  try
    h := SendHeader(rio,1);
    try
      try
        doc := CreateXML(
                     Decode(
                        GetCaTenantWebServiceImpl(true,URL+'CaTenantService?wsdl',rio).register(Encode(inxml,pubpwd))
                        ,pubpwd
                     )
               );
      except
        on E:Exception do
           begin
             if pos('Empty document',E.Message)>0 then
                begin
                  Raise Exception.Create('无法连接到RSP认证服务器，请检查网络是否正常.');
                end
             else
                Raise;
           end;
      end;
    finally
      h.Free;
    end;
    CheckRecAck(doc);
    caTenantRegisterResp := FindNode(doc,'body\caTenantRegisterResp');
    code := GetNodeValue(caTenantRegisterResp,'code');
    if StrtoIntDef(code,0) in [1] then //注册成功
       begin
         result.TENANT_ID := StrtoInt(GetNodeValue(caTenantRegisterResp,'tenantId'));
       end
    else
       Raise Exception.Create(GetNodeValue(caTenantRegisterResp,'desc'));

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
    URL := f.ReadString('soft','rsp','http://10.10.11.249/services/');
    pubpwd := 'SaRi0+jf';
  finally
    f.Free;
  end;
  timeout:= 2000000;
end;

function TCaFactory.CreateRio(_timeOut:integer=-1): THTTPRIO;
begin
  result := THTTPRIO.Create(nil);
  timeOut := _timeOut;
  if _timeOut>0 then
     result.OnAfterExecute := doAfterExecute
  else
     result.OnAfterExecute := nil;
end;

function TCaFactory.CreateXML(xml: string): IXMLDomDocument;
begin
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    if xml<>'' then result.loadXML(xml);
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
  SessionId := result.rspSessionId;
end;

function TCaFactory.SendHeader(rio: THTTPRIO;flag:integer=1):rsp;
begin
  result := rsp.Create;
  result.rspSessionId := SessionId;
  result.encryptType := flag;
  rio.SOAPHeaders.Send(result);
end;

function TCaFactory.CreateRspXML: IXMLDomDocument;
var
  Node:IXMLDOMElement;
begin
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    Node := Result.createElement('message');
    result.documentElement := Node;
    Node.appendChild(Result.createElement('header'));
    FindElement(Node,'header').appendChild(Result.createElement('pub'));
    Node.appendChild(Result.createElement('body'));
  except
    result := nil;
    Raise;
  end;
end;

procedure TCaFactory.SetSessionId(const Value: string);
begin
  FSessionId := Value;
end;

function TCaFactory.CheckUpgrade(TENANT_ID, PROD_ID,CurVeraion: string): TCaUpgrade;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caProductCheckUpgradeResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  code:string;
  h:rsp;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);
  
  Node := doc.createElement('caProductCheckUpgradeReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := TENANT_ID;
  FindNode(doc,'body\caProductCheckUpgradeReq').appendChild(Node);

  Node := doc.createElement('prodId');
  Node.text := PROD_ID;
  FindNode(doc,'body\caProductCheckUpgradeReq').appendChild(Node);

  Node := doc.createElement('curVersion');
  Node.text := CurVeraion;
  FindNode(doc,'body\caProductCheckUpgradeReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(10000);
  try
    h := SendHeader(rio,1);
    try
      try
      doc := CreateXML(
                   Decode(
                      GetCaProductWebServiceImpl(true,URL+'CaProductService?wsdl',rio).checkUpgrade(Encode(inxml,pubpwd))
                      ,pubpwd
                   )
             );
      except
        on E:Exception do
           begin
             if pos('Empty document',E.Message)>0 then
                begin
                  Raise Exception.Create('无法连接到RSP认证服务器，请检查网络是否正常.');
                end
             else
                Raise;
           end;
      end;
    finally
      h.Free;
    end;

    GetHeader(rio).free;
    CheckRecAck(doc);
    caProductCheckUpgradeResp := FindNode(doc,'body\caProductCheckUpgradeResp');
    result.UpGrade := StrtoInt(GetNodeValue(caProductCheckUpgradeResp,'upgradeType'));
    result.URL := GetNodeValue(caProductCheckUpgradeResp,'pkgDownloadUrl');
  finally
    rio.Free;
  end;
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

