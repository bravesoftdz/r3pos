unit uCaFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,Des,WinInet, xmldom, XMLIntf,
  msxmldom, XMLDoc, MSHTML, ActiveX,msxml,ComObj,ZDataSet,DB,ZBase,Variants,ZLogFile;
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
    Version:string;
  end;

  PServiceLine=^TServiceLine;
  TServiceLine=record
    RELATION_ID:integer;
    TENANT_ID:integer;
    RELATION_NAME:string;
    RELATION_SPELL:string;
    REMARK:string;
  end;

  PRelationInfo=^TRelationInfo;
  TRelationInfo=record
      //企业关系ID号
    RELATIONS_ID:string;
      //供应链ID号
    RELATION_ID:integer;
      //当前企业代码
    TENANT_ID:integer;
      //下级企业代码
    RELATI_ID:integer;
      //关系类型
    RELATION_TYPE:string;
      //结构树 000000 6位一级，最多支持5级 <在此不是一棵树，没有指企业供应链无法生成此代号>
    LEVEL_ID:string;
      //关系状态  1 申请 2 审核
    RELATION_STATUS:string;
      //创建日期
    CREA_DATE:string;
      //审核日期
    CHK_DATE:string;
      //通讯标志 00 新增 01修改 02 删除 第一位为0待同步,1已同步
    COMM:string;
      //更新时间 从2011-01-01开始的秒数
    TIME_STAMP:int64;
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
    FAudited: boolean;
    FTimeStamp: int64;
    _Start:int64;
    procedure SetSSL(const Value: string);
    procedure SetURL(const Value: string);
    procedure Setpubpwd(const Value: string);
    procedure Setsslpwd(const Value: string);
    procedure SetSessionId(const Value: string);
    procedure doAfterExecute(const MethodName: string;
      SOAPResponse: TStream);
    procedure SetAudited(const Value: boolean);
    procedure SetTimeStamp(const Value: int64);
  protected
    function Encode(inxml:String;Key:string):String;
    function Decode(inxml:String;Key:string):String;
    procedure SetTicket;
    function GetTicket:Int64;
  public
    constructor Create;
    destructor Destroy;override;

    function CreateRio(_timeOut:integer=-1):THTTPRIO;

    function GetHeader(rio:THTTPRIO):rsp;
    function SendHeader(rio:THTTPRIO;flag:integer=1):rsp;
    function CreateXML(xml:string):IXMLDomDocument;
    function CreateRspXML:IXMLDomDocument;
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string):IXMLDOMNode;
    function GetNodeValue(root:IXMLDOMNode;s:string):string;
    procedure CheckRecAck(doc:IXMLDomDocument);
    function CheckNetwork(addr:string=''):boolean;

    function GetSynTimeStamp(tbName:string;SHOP_ID:string='#'):int64;
    procedure SetSynTimeStamp(tbName:string;_TimeStamp:int64;SHOP_ID:string='#');

    //产品服务
    function CheckUpgrade(TENANT_ID,PROD_ID,CurVeraion:string):TCaUpgrade;

    //供应链服务
    function CreateServiceLine(var ServiceLine:TServiceLine):boolean;
    function queryServiceLines(tid:integer;List:TList):boolean;
    function applyRelation(supTenantId,serviceLineId,subTenantId,relationType:integer):TRelationInfo;

    //数据同步
    function downloadTenants(TenantId,flag:integer):boolean;
    function downloadServiceLines(TenantId,flag:integer):boolean;
    function downloadRelations(TenantId,flag:integer):boolean;
    function downloadSort(TenantId,flag:integer):boolean;
    function downloadUnit(TenantId,flag:integer):boolean;
    function downloadGoods(TenantId,flag:integer):boolean;
    function downloadDeployGoods(TenantId,flag:integer):boolean;
    function downloadBarcode(TenantId,flag:integer):boolean;
    function SyncAll(flag:integer):boolean;

    //企业服务
    function AutoCoLogo:boolean;
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
    //认证审核通过
    property Audited:boolean read FAudited write SetAudited;
    //认证时的时间戳
    property TimeStamp:int64 read FTimeStamp write SetTimeStamp;
  end;
var CaFactory:TCaFactory;
implementation
uses ufrmLogo,EncDec,ZLibExGZ,uGlobal,encddecd,CaTenantService,CaProductService,CaServiceLineService,RspDownloadService,IniFiles;
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
  try
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
     end
  else
     begin
       node := FindElement(node.parentNode,'timeStamp');
       if node<>nil then
          timeStamp := StrtoInt64(node.text);
     end;
  except
    on E:Exception do
      begin
        LogFile.AddLogFile(0,E.Message+' XML='+doc.xml);
        Raise;
      end;
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
  h,r:rsp;
  OutXml:widestring;
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
        OutXml := GetCaTenantWebServiceImpl(true,URL+'CaTenantService?wsdl',rio).getTenantInfo(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    result.REGION_ID := GetNodeValue(caTenant,'regionId');
    result.SRVR_ID := GetNodeValue(caTenant,'srvrId');
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
  f:TIniFile;
begin
  Audited := false;
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

    CheckRecAck(doc);
    GetHeader(rio).free;
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
              Audited := true;
              f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
              try
                if not FindCmdLineSwitch('DEBUG',['-','+'],false) then
                   f.WriteString('db','Connstr','connmode=2;hostname='+result.HOST_NAME+';port='+inttostr(result.SRVR_PORT)+';dbid='+inttostr(result.DB_ID));
              finally
                f.Free;
              end;
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
    GetHeader(rio).free;
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
  h,r:rsp;
  OutXml:WideString;
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
        OutXml := GetCaProductWebServiceImpl(true,URL+'CaProductService?wsdl',rio).checkUpgrade(Encode(inxml,pubpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    caProductCheckUpgradeResp := FindNode(doc,'body\caProductCheckUpgradeResp');
    result.UpGrade := StrtoInt(GetNodeValue(caProductCheckUpgradeResp,'upgradeType'));
    result.URL := GetNodeValue(caProductCheckUpgradeResp,'pkgDownloadUrl');
    result.Version := GetNodeValue(caProductCheckUpgradeResp,'newVersion');
  finally
    rio.Free;
  end;
end;

procedure TCaFactory.SetAudited(const Value: boolean);
begin
  FAudited := Value;
end;

function TCaFactory.CreateServiceLine(var ServiceLine:TServiceLine):boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caServiceLineCreateResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  code:string;
  h,r:rsp;
  OutXml:WideString;
begin
  AutoCoLogo;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('caServiceLineCreateReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(ServiceLine.TENANT_ID);
  FindNode(doc,'body\caServiceLineCreateReq').appendChild(Node);

  Node := doc.createElement('serviceLineName');
  Node.text := ServiceLine.RELATION_NAME;
  FindNode(doc,'body\caServiceLineCreateReq').appendChild(Node);

  Node := doc.createElement('serviceLineSpell');
  Node.text := ServiceLine.RELATION_SPELL;
  FindNode(doc,'body\caServiceLineCreateReq').appendChild(Node);

  Node := doc.createElement('remark');
  Node.text := ServiceLine.REMARK;
  FindNode(doc,'body\caServiceLineCreateReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(10000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetCaServiceLineWebServiceImpl(true,URL+'CaServiceLineService?wsdl',rio).createServiceLine(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    caServiceLineCreateResp := FindNode(doc,'body\caServiceLineCreateResp');
    code := GetNodeValue(caServiceLineCreateResp,'code');
    result := (code='1');
    if result then
       begin
         ServiceLine.RELATION_ID := StrtoInt(GetNodeValue(caServiceLineCreateResp,'serviceLineId'));
       end
    else
       Raise Exception.Create(GetNodeValue(caServiceLineCreateResp,'desc'));
  finally
    rio.Free;
  end;
end;

function TCaFactory.queryServiceLines(tid:integer;List: TList): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caServiceLineQueryResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  OutXml:WideString;
begin
  AutoCoLogo;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('caServiceLineQueryReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(tid);
  FindNode(doc,'body\caServiceLineQueryReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(10000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetCaServiceLineWebServiceImpl(true,URL+'CaServiceLineService?wsdl',rio).queryServiceLines(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    caServiceLineQueryResp := Node.firstChild;
    while caServiceLineQueryResp<>nil do
       begin
         new(line);
         line^.RELATION_ID := StrtoInt(GetNodeValue(caServiceLineQueryResp,'serviceLineId'));
         line^.RELATION_NAME := GetNodeValue(caServiceLineQueryResp,'serviceLineName');
         line^.RELATION_SPELL := GetNodeValue(caServiceLineQueryResp,'serviceLineSpell');
         line^.REMARK := GetNodeValue(caServiceLineQueryResp,'remark');
         List.Add(line);
         caServiceLineQueryResp := caServiceLineQueryResp.nextSibling;
       end;
  finally
    rio.Free;
  end;
end;

function TCaFactory.applyRelation(supTenantId, serviceLineId, subTenantId,
  relationType: integer): TRelationInfo;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caRelationApplyResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  code:string;
  OutXml:WideString;
begin
  AutoCoLogo;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('caRelationApplyReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('supTenantId');
  Node.text := inttostr(supTenantId);
  FindNode(doc,'body\caRelationApplyReq').appendChild(Node);

  Node := doc.createElement('serviceLineId');
  Node.text := inttostr(serviceLineId);
  FindNode(doc,'body\caRelationApplyReq').appendChild(Node);

  Node := doc.createElement('subTenantId');
  Node.text := inttostr(subTenantId);
  FindNode(doc,'body\caRelationApplyReq').appendChild(Node);

  Node := doc.createElement('relationType');
  Node.text := inttostr(relationType);
  FindNode(doc,'body\caRelationApplyReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(10000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml :=  GetCaServiceLineWebServiceImpl(true,URL+'CaServiceLineService?wsdl',rio).applyRelation(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    caRelationApplyResp := FindNode(doc,'body\caRelationApplyResp');
    code := GetNodeValue(caRelationApplyResp,'code');
    if StrtoIntDef(code,0) in [1] then //注册成功
       begin
         result.RELATIONS_ID := GetNodeValue(caRelationApplyResp,'relationsId');
         result.RELATION_ID := StrtoInt(GetNodeValue(caRelationApplyResp,'serviceLineId'));
         result.TENANT_ID := StrtoInt(GetNodeValue(caRelationApplyResp,'supTenantId'));
         result.RELATI_ID := StrtoInt(GetNodeValue(caRelationApplyResp,'subTenantId'));
         result.RELATION_TYPE := GetNodeValue(caRelationApplyResp,'relationType');
         result.LEVEL_ID := GetNodeValue(caRelationApplyResp,'levelId');
         result.RELATION_STATUS := GetNodeValue(caRelationApplyResp,'relationStatus');
         result.CREA_DATE := GetNodeValue(caRelationApplyResp,'creaDate');
         result.CHK_DATE := GetNodeValue(caRelationApplyResp,'chkDate');
         result.COMM := GetNodeValue(caRelationApplyResp,'comm');
         result.TIME_STAMP := StrtoInt(GetNodeValue(caRelationApplyResp,'timeStamp'));
       end
    else
       Raise Exception.Create(GetNodeValue(caRelationApplyResp,'desc'));

  finally
    rio.Free;
  end;
end;

function TCaFactory.SyncAll(flag:integer): boolean;
begin
  AutoCoLogo;
  frmLogo.Show;
  try
    frmLogo.ProgressBar1.Max := 8;
    frmLogo.Label1.Caption := '下载企业关系...';
    frmLogo.Label1.Update;
    downloadRelations(Global.TENANT_ID,flag);
    frmLogo.ProgressBar1.Position := 1;
    frmLogo.Label1.Caption := '下载供应链...';
    frmLogo.Label1.Update;
    downloadServiceLines(Global.TENANT_ID,flag);
    frmLogo.ProgressBar1.Position := 2;
    frmLogo.Label1.Caption := '下载企业资料...';
    frmLogo.Label1.Update;
    downloadTenants(Global.TENANT_ID,flag);
    frmLogo.ProgressBar1.Position := 3;
    frmLogo.Label1.Caption := '下载商品分类...';
    frmLogo.Label1.Update;
    downloadSort(Global.TENANT_ID,flag);
    frmLogo.ProgressBar1.Position := 4;
    frmLogo.Label1.Caption := '下载计量单位...';
    frmLogo.Label1.Update;
    downloadUnit(Global.TENANT_ID,flag);
    frmLogo.ProgressBar1.Position := 5;
    frmLogo.Label1.Caption := '下载商品资料...';
    frmLogo.Label1.Update;
    downloadGoods(Global.TENANT_ID,flag);
    frmLogo.ProgressBar1.Position := 6;
    frmLogo.Label1.Caption := '下载供应链商品...';
    frmLogo.Label1.Update;
    downloadDeployGoods(Global.TENANT_ID,flag);
    frmLogo.ProgressBar1.Position := 7;
    frmLogo.Label1.Caption := '下载条码信息...';
    frmLogo.Label1.Update;
    downloadBarcode(Global.TENANT_ID,flag);
  finally
    frmLogo.Close;
  end;
end;

function TCaFactory.downloadRelations(TenantId, flag: integer): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caRelationDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  rs:TZQuery;
  Params:TftParamList;
  OutXml:WideString;
begin
try
  SetTicket;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(GetSynTimeStamp('CA_RELATIONS','#'));
  FindNode(doc,'header\pub').appendChild(Node);
  LogFile.AddLogFile(0,'开始下载<供应关系>上次同步时间:'+Node.text+' 本次同步时间:'+inttostr(TimeStamp));

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(60000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetRspDownloadWebServiceImpl(true,URL+'RspDownloadService?wsdl',rio).downloadRelations(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    LogFile.AddLogFile(0,'下载<供应关系>打开时长:'+inttostr(GetTicket));
    SetTicket;
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.FieldDefs.Add('RELATIONS_ID',ftstring,36,true);
      rs.FieldDefs.Add('RELATION_ID',ftInteger,0,true);
      rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
      rs.FieldDefs.Add('RELATI_ID',ftInteger,0,true);
      rs.FieldDefs.Add('RELATION_TYPE',ftstring,1,true);
      rs.FieldDefs.Add('LEVEL_ID',ftstring,50,true);
      rs.FieldDefs.Add('RELATION_STATUS',ftstring,1,true);
      rs.FieldDefs.Add('CREA_DATE',ftstring,10,true);
      rs.FieldDefs.Add('CHK_DATE',ftstring,10,true);
      rs.FieldDefs.Add('COMM',ftstring,2,true);
      rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
      rs.CreateDataSet;
      caRelationDownloadResp := Node.firstChild;
      while caRelationDownloadResp<>nil do
         begin
           rs.Append;
           rs.FieldByName('RELATIONS_ID').AsString := GetNodeValue(caRelationDownloadResp,'relationsId');
           rs.FieldByName('RELATION_ID').AsInteger := StrtoInt(GetNodeValue(caRelationDownloadResp,'serviceLineId'));
           rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(GetNodeValue(caRelationDownloadResp,'supTenantId'));
           rs.FieldByName('RELATI_ID').AsInteger := StrtoInt(GetNodeValue(caRelationDownloadResp,'subTenantId'));
           rs.FieldByName('RELATION_TYPE').AsString := GetNodeValue(caRelationDownloadResp,'relationType');
           rs.FieldByName('LEVEL_ID').AsString := GetNodeValue(caRelationDownloadResp,'levelId');
           rs.FieldByName('RELATION_STATUS').AsString := GetNodeValue(caRelationDownloadResp,'relationStatus');
           rs.FieldByName('CREA_DATE').AsString := GetNodeValue(caRelationDownloadResp,'creaDate');
           rs.FieldByName('CHK_DATE').AsString := GetNodeValue(caRelationDownloadResp,'chkDate');
           rs.FieldByName('COMM').AsString := GetNodeValue(caRelationDownloadResp,'comm');
           TLargeintField(rs.FieldByName('TIME_STAMP')).AsLargeInt := StrtoInt64(GetNodeValue(caRelationDownloadResp,'timeStamp'));
           rs.Post;
           caRelationDownloadResp := caRelationDownloadResp.nextSibling;
         end;
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('TABLE_NAME').AsString := 'CA_RELATIONS';
        Params.ParamByName('KEY_FIELDS').AsString := 'RELATIONS_ID';
        Factor.UpdateBatch(rs,'TSyncSingleTable',Params);
        SetSynTimeStamp('CA_RELATIONS',timeStamp,'#');
      finally
        Params.free;
      end;
      LogFile.AddLogFile(0,'保存<供应关系>执行时长:'+inttostr(GetTicket)+' 记录数:'+inttostr(rs.RecordCount));
    finally
      rs.Free;
    end;
  finally
    rio.Free;
  end;
except
  LogFile.AddLogFile(0,'下载<供应关系>xml='+doc.xml);
  Raise;
end;
end;

function TCaFactory.GetSynTimeStamp(tbName, SHOP_ID: string): int64;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
    rs.ParambyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
    rs.ParamByName('TABLE_NAME').AsString := 'RSP_'+tbName;
    Global.LocalFactory.Open(rs);
    if rs.IsEmpty then result := 0 else result := rs.Fields[0].Value;
  finally
    rs.Free;
  end;
end;

procedure TCaFactory.SetSynTimeStamp(tbName: string; _TimeStamp: int64;
  SHOP_ID: string);
var
  r:integer;
begin
  r := Global.LocalFactory.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(_TimeStamp)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+'RSP_'+tbName+'''');
  if r=0 then
     Global.LocalFactory.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+inttostr(Global.TENANT_ID)+','''+SHOP_ID+''','''+'RSP_'+tbName+''','+inttostr(_TimeStamp)+')');
end;

function TCaFactory.downloadServiceLines(TenantId, flag: integer): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caServiceLineDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  rs:TZQuery;
  Params:TftParamList;
  OutXml:WideString;
begin
try
  SetTicket;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(GetSynTimeStamp('CA_RELATION','#'));
  FindNode(doc,'header\pub').appendChild(Node);
  LogFile.AddLogFile(0,'开始下载<供应链>上次同步时间:'+Node.text+' 本次同步时间:'+inttostr(TimeStamp));

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(60000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetRspDownloadWebServiceImpl(true,URL+'RspDownloadService?wsdl',rio).downloadServiceLines(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    LogFile.AddLogFile(0,'下载<供应链>打开时长:'+inttostr(GetTicket));
    SetTicket;
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.FieldDefs.Add('RELATION_ID',ftInteger,0,true);
      rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
      rs.FieldDefs.Add('RELATION_NAME',ftstring,50,true);
      rs.FieldDefs.Add('RELATION_SPELL',ftstring,50,true);
      rs.FieldDefs.Add('REMARK',ftstring,255,true);
      rs.FieldDefs.Add('CREA_DATE',ftstring,10,true);
      rs.FieldDefs.Add('COMM',ftstring,2,true);
      rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
      rs.CreateDataSet;
      caServiceLineDownloadResp := Node.firstChild;
      while caServiceLineDownloadResp<>nil do
         begin
           rs.Append;
           rs.FieldByName('RELATION_ID').AsInteger := StrtoInt(GetNodeValue(caServiceLineDownloadResp,'serviceLineId'));
           rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(GetNodeValue(caServiceLineDownloadResp,'tenantId'));
           rs.FieldByName('RELATION_NAME').AsString := GetNodeValue(caServiceLineDownloadResp,'serviceLineName');
           rs.FieldByName('RELATION_SPELL').AsString := GetNodeValue(caServiceLineDownloadResp,'serviceLineSpell');
           rs.FieldByName('REMARK').AsString := GetNodeValue(caServiceLineDownloadResp,'remark');
           rs.FieldByName('CREA_DATE').AsString := GetNodeValue(caServiceLineDownloadResp,'creaDate');
           rs.FieldByName('COMM').AsString := GetNodeValue(caServiceLineDownloadResp,'comm');
           TLargeintField(rs.FieldByName('TIME_STAMP')).AsLargeInt := StrtoInt64(GetNodeValue(caServiceLineDownloadResp,'timeStamp'));
           rs.Post;
           caServiceLineDownloadResp := caServiceLineDownloadResp.nextSibling;
         end;
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('TABLE_NAME').AsString := 'CA_RELATION';
        Params.ParamByName('KEY_FIELDS').AsString := 'RELATION_ID';
        Factor.UpdateBatch(rs,'TSyncSingleTable',Params);
        SetSynTimeStamp('CA_RELATION',timeStamp,'#');
      finally
        Params.free;
      end;
      LogFile.AddLogFile(0,'保存<供应链>执行时长:'+inttostr(GetTicket)+' 记录数:'+inttostr(rs.RecordCount));
    finally
      rs.Free;
    end;
  finally
    rio.Free;
  end;
except
  LogFile.AddLogFile(0,'下载<供应链>xml='+doc.xml);
  Raise;
end;
end;

function TCaFactory.downloadTenants(TenantId, flag: integer): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  caTenantDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  rs:TZQuery;
  Params:TftParamList;
  OutXml:WideString;
begin
try
  SetTicket;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(GetSynTimeStamp('CA_TENANT','#'));
  FindNode(doc,'header\pub').appendChild(Node);
  LogFile.AddLogFile(0,'开始下载<企业资料>上次同步时间:'+Node.text+' 本次同步时间:'+inttostr(TimeStamp));

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(60000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetRspDownloadWebServiceImpl(true,URL+'RspDownloadService?wsdl',rio).downloadTenants(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    LogFile.AddLogFile(0,'下载<企业资料>打开时长:'+inttostr(GetTicket));
    SetTicket;
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
      rs.FieldDefs.Add('LOGIN_NAME',ftstring,50,true);
      rs.FieldDefs.Add('LICENSE_CODE',ftstring,50,true);
      rs.FieldDefs.Add('TENANT_NAME',ftstring,50,true);
      rs.FieldDefs.Add('TENANT_TYPE',ftstring,1,true);
      rs.FieldDefs.Add('SHORT_TENANT_NAME',ftstring,50,true);
      rs.FieldDefs.Add('TENANT_SPELL',ftstring,50,true);
      rs.FieldDefs.Add('LEGAL_REPR',ftstring,20,true);
      rs.FieldDefs.Add('LINKMAN',ftstring,20,true);
      rs.FieldDefs.Add('TELEPHONE',ftstring,30,true);
      rs.FieldDefs.Add('FAXES',ftstring,30,true);
      rs.FieldDefs.Add('HOMEPAGE',ftstring,50,true);
      rs.FieldDefs.Add('ADDRESS',ftstring,50,true);
      rs.FieldDefs.Add('QQ',ftstring,50,true);
      rs.FieldDefs.Add('MSN',ftstring,50,true);
      rs.FieldDefs.Add('POSTALCODE',ftstring,6,true);
      rs.FieldDefs.Add('REMARK',ftstring,100,true);
      rs.FieldDefs.Add('PASSWRD',ftstring,100,true);
      rs.FieldDefs.Add('REGION_ID',ftstring,10,true);
      rs.FieldDefs.Add('SRVR_ID',ftstring,10,true);
      rs.FieldDefs.Add('AUDIT_STATUS',ftstring,1,true);
      rs.FieldDefs.Add('PROD_ID',ftstring,10,true);
      rs.FieldDefs.Add('DB_ID',ftInteger,0,true);
      rs.FieldDefs.Add('CREA_DATE',ftstring,10,true);
      rs.FieldDefs.Add('COMM',ftstring,2,true);
      rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
      rs.CreateDataSet;
      caTenantDownloadResp := Node.firstChild;
      while caTenantDownloadResp<>nil do
         begin
           rs.Append;
           rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(GetNodeValue(caTenantDownloadResp,'tenantId'));
           rs.FieldByName('LOGIN_NAME').AsString := GetNodeValue(caTenantDownloadResp,'loginName');
           rs.FieldByName('LICENSE_CODE').AsString := GetNodeValue(caTenantDownloadResp,'licenseCode');
           rs.FieldByName('TENANT_NAME').AsString := GetNodeValue(caTenantDownloadResp,'tenantName');
           rs.FieldByName('TENANT_TYPE').AsString := GetNodeValue(caTenantDownloadResp,'tenantType');
           rs.FieldByName('SHORT_TENANT_NAME').AsString := GetNodeValue(caTenantDownloadResp,'shortTenantName');
           rs.FieldByName('TENANT_SPELL').AsString := GetNodeValue(caTenantDownloadResp,'tenantSpell');
           rs.FieldByName('LEGAL_REPR').AsString := GetNodeValue(caTenantDownloadResp,'legalRepr');
           rs.FieldByName('LINKMAN').AsString := GetNodeValue(caTenantDownloadResp,'linkman');
           rs.FieldByName('TELEPHONE').AsString := GetNodeValue(caTenantDownloadResp,'telephone');
           rs.FieldByName('FAXES').AsString := GetNodeValue(caTenantDownloadResp,'faxes');
           rs.FieldByName('HOMEPAGE').AsString := GetNodeValue(caTenantDownloadResp,'homepage');
           rs.FieldByName('ADDRESS').AsString := GetNodeValue(caTenantDownloadResp,'address');
           rs.FieldByName('QQ').AsString := GetNodeValue(caTenantDownloadResp,'qq');
           rs.FieldByName('MSN').AsString := GetNodeValue(caTenantDownloadResp,'msn');
           rs.FieldByName('POSTALCODE').AsString := GetNodeValue(caTenantDownloadResp,'postalcode');
           rs.FieldByName('REMARK').AsString := GetNodeValue(caTenantDownloadResp,'remark');
           rs.FieldByName('PASSWRD').AsString := EncStr(GetNodeValue(caTenantDownloadResp,'passwrd'),ENC_KEY);
           rs.FieldByName('REGION_ID').AsString := GetNodeValue(caTenantDownloadResp,'regionId');
           rs.FieldByName('SRVR_ID').AsString := GetNodeValue(caTenantDownloadResp,'passwrd');
           rs.FieldByName('AUDIT_STATUS').AsString := GetNodeValue(caTenantDownloadResp,'auditStatus');
           rs.FieldByName('PROD_ID').AsString := GetNodeValue(caTenantDownloadResp,'prodId');
           rs.FieldByName('DB_ID').AsString := GetNodeValue(caTenantDownloadResp,'dbId');
           rs.FieldByName('CREA_DATE').AsString := GetNodeValue(caTenantDownloadResp,'creaDate');
           rs.FieldByName('COMM').AsString := GetNodeValue(caTenantDownloadResp,'comm');
           TLargeintField(rs.FieldByName('TIME_STAMP')).AsLargeInt := StrtoInt64(GetNodeValue(caTenantDownloadResp,'timeStamp'));
           rs.Post;
           caTenantDownloadResp := caTenantDownloadResp.nextSibling;
         end;
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('TABLE_NAME').AsString := 'CA_TENANT';
        Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID';
        Factor.UpdateBatch(rs,'TSyncSingleTable',Params);
        SetSynTimeStamp('CA_TENANT',timeStamp,'#');
      finally
        Params.free;
      end;
      LogFile.AddLogFile(0,'保存<企业资料>打开时长:'+inttostr(GetTicket)+'  记录数:'+inttostr(rs.RecordCount));
    finally
      rs.Free;
    end;
  finally
    rio.Free;
  end;
except
  LogFile.AddLogFile(0,'下载<企业资料>xml='+doc.xml);
  Raise;
end;
end;

function TCaFactory.downloadSort(TenantId, flag: integer): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  pubGoodsSortDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  rs:TZQuery;
  Params:TftParamList;
  OutXml:WideString;
begin
try
  SetTicket;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(GetSynTimeStamp('PUB_GOODSSORT','#'));
  FindNode(doc,'header\pub').appendChild(Node);
  LogFile.AddLogFile(0,'开始下载<商品分类>上次同步时间:'+Node.text+' 本次同步时间:'+inttostr(TimeStamp));

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(60000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetRspDownloadWebServiceImpl(true,URL+'RspDownloadService?wsdl',rio).downloadSort(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    LogFile.AddLogFile(0,'下载<商品分类>打开时长:'+inttostr(GetTicket));
    SetTicket;
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.FieldDefs.Add('SORT_ID',ftstring,36,true);
      rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
      rs.FieldDefs.Add('LEVEL_ID',ftstring,20,true);
      rs.FieldDefs.Add('SORT_NAME',ftstring,30,true);
      rs.FieldDefs.Add('SORT_TYPE',ftInteger,0,true);
      rs.FieldDefs.Add('SORT_SPELL',ftstring,30,true);
      rs.FieldDefs.Add('SEQ_NO',ftInteger,0,true);
      rs.FieldDefs.Add('COMM',ftstring,2,true);
      rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
      rs.CreateDataSet;
      pubGoodsSortDownloadResp := Node.firstChild;
      while pubGoodsSortDownloadResp<>nil do
         begin
           rs.Append;
           rs.FieldByName('SORT_ID').AsString := GetNodeValue(pubGoodsSortDownloadResp,'sortId');
           rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(GetNodeValue(pubGoodsSortDownloadResp,'tenantId'));
           rs.FieldByName('LEVEL_ID').AsString := GetNodeValue(pubGoodsSortDownloadResp,'levelId');
           rs.FieldByName('SORT_NAME').AsString := GetNodeValue(pubGoodsSortDownloadResp,'sortName');
           rs.FieldByName('SORT_TYPE').AsInteger := StrtoInt(GetNodeValue(pubGoodsSortDownloadResp,'sortType'));
           rs.FieldByName('SORT_SPELL').AsString := GetNodeValue(pubGoodsSortDownloadResp,'sortSpell');
           if GetNodeValue(pubGoodsSortDownloadResp,'seqNo')='' then
           rs.FieldByName('SEQ_NO').AsInteger := 0 else
           rs.FieldByName('SEQ_NO').AsInteger := StrtoInt(GetNodeValue(pubGoodsSortDownloadResp,'seqNo'));
           rs.FieldByName('COMM').AsString := GetNodeValue(pubGoodsSortDownloadResp,'comm');
           TLargeintField(rs.FieldByName('TIME_STAMP')).AsLargeInt := StrtoInt64(GetNodeValue(pubGoodsSortDownloadResp,'timeStamp'));
           rs.Post;
           pubGoodsSortDownloadResp := pubGoodsSortDownloadResp.nextSibling;
         end;
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODSSORT';
        Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SORT_ID;SORT_TYPE';
        Factor.UpdateBatch(rs,'TSyncSingleTable',Params);
        SetSynTimeStamp('PUB_GOODSSORT',timeStamp,'#');
      finally
        Params.free;
      end;
      LogFile.AddLogFile(0,'保存<商品分类>执行时长:'+inttostr(GetTicket)+' 记录数:'+inttostr(rs.RecordCount));
    finally
      rs.Free;
    end;
  finally
    rio.Free;
  end;
except
  LogFile.AddLogFile(0,'下载<商品分类>xml='+doc.xml);
  Raise;
end;
end;

function TCaFactory.downloadGoods(TenantId, flag: integer): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  pubGoodsDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  rs:TZQuery;
  Params:TftParamList;
  OutXml:WideString;
begin
try
  SetTicket;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(GetSynTimeStamp('PUB_GOODSINFO','#'));
  FindNode(doc,'header\pub').appendChild(Node);
  LogFile.AddLogFile(0,'开始下载<商品资料>上次同步时间:'+Node.text+' 本次同步时间:'+inttostr(TimeStamp));

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(60000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetRspDownloadWebServiceImpl(true,URL+'RspDownloadService?wsdl',rio).downloadGoods(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    LogFile.AddLogFile(0,'下载<商品资料>打开时长:'+inttostr(GetTicket));
    SetTicket;
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.FieldDefs.Add('GODS_ID',ftstring,36,true);
      rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
      rs.FieldDefs.Add('GODS_CODE',ftstring,20,true);
      rs.FieldDefs.Add('GODS_NAME',ftstring,50,true);
      rs.FieldDefs.Add('GODS_SPELL',ftstring,50,true);
      rs.FieldDefs.Add('GODS_TYPE',ftInteger,0,true);
      rs.FieldDefs.Add('SORT_ID1',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID2',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID3',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID4',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID5',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID6',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID7',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID8',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID9',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID10',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID11',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID12',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID13',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID14',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID15',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID16',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID17',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID18',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID19',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID20',ftstring,36,true);
      rs.FieldDefs.Add('BARCODE',ftstring,30,true);
      rs.FieldDefs.Add('UNIT_ID',ftstring,36,true);
      rs.FieldDefs.Add('CALC_UNITS',ftstring,36,true);
      rs.FieldDefs.Add('SMALL_UNITS',ftstring,36,true);
      rs.FieldDefs.Add('BIG_UNITS',ftstring,36,true);
      rs.FieldDefs.Add('SMALLTO_CALC',ftFloat,0,true);
      rs.FieldDefs.Add('BIGTO_CALC',ftFloat,0,true);
      rs.FieldDefs.Add('NEW_INPRICE',ftFloat,0,true);
      rs.FieldDefs.Add('NEW_OUTPRICE',ftFloat,0,true);
      rs.FieldDefs.Add('NEW_LOWPRICE',ftFloat,0,true);
      rs.FieldDefs.Add('USING_PRICE',ftInteger,0,true);
      rs.FieldDefs.Add('HAS_INTEGRAL',ftInteger,0,true);
      rs.FieldDefs.Add('USING_BATCH_NO',ftInteger,0,true);
      rs.FieldDefs.Add('USING_BARTER',ftInteger,0,true);
      rs.FieldDefs.Add('USING_LOCUS_NO',ftInteger,0,true);
      rs.FieldDefs.Add('BARTER_INTEGRAL',ftInteger,0,true);
      rs.FieldDefs.Add('REMARK',ftstring,2000,true);
      rs.FieldDefs.Add('COMM',ftstring,2,true);
      rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
      rs.CreateDataSet;
      pubGoodsDownloadResp := Node.firstChild;
      while pubGoodsDownloadResp<>nil do
         begin
           rs.Append;
           rs.FieldByName('GODS_ID').AsString := GetNodeValue(pubGoodsDownloadResp,'godsId');
           rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(GetNodeValue(pubGoodsDownloadResp,'tenantId'));
           rs.FieldByName('GODS_CODE').AsString := GetNodeValue(pubGoodsDownloadResp,'godsCode');
           rs.FieldByName('GODS_NAME').AsString := GetNodeValue(pubGoodsDownloadResp,'godsName');
           rs.FieldByName('GODS_SPELL').AsString := GetNodeValue(pubGoodsDownloadResp,'godsSpell');
           rs.FieldByName('GODS_TYPE').AsInteger := StrtoInt(GetNodeValue(pubGoodsDownloadResp,'godsType'));
           rs.FieldByName('SORT_ID1').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId1');
           rs.FieldByName('SORT_ID2').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId2');
           rs.FieldByName('SORT_ID3').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId3');
           rs.FieldByName('SORT_ID4').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId4');
           rs.FieldByName('SORT_ID5').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId5');
           rs.FieldByName('SORT_ID6').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId6');
           rs.FieldByName('SORT_ID7').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId7');
           rs.FieldByName('SORT_ID8').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId8');
           rs.FieldByName('SORT_ID9').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId9');
           rs.FieldByName('SORT_ID10').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId10');
           rs.FieldByName('SORT_ID11').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId11');
           rs.FieldByName('SORT_ID12').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId12');
           rs.FieldByName('SORT_ID13').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId13');
           rs.FieldByName('SORT_ID14').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId14');
           rs.FieldByName('SORT_ID15').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId15');
           rs.FieldByName('SORT_ID16').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId16');
           rs.FieldByName('SORT_ID17').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId17');
           rs.FieldByName('SORT_ID18').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId18');
           rs.FieldByName('SORT_ID19').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId19');
           rs.FieldByName('SORT_ID20').AsString := GetNodeValue(pubGoodsDownloadResp,'sortId20');
           rs.FieldByName('BARCODE').AsString := GetNodeValue(pubGoodsDownloadResp,'barcode');
           rs.FieldByName('UNIT_ID').AsString := GetNodeValue(pubGoodsDownloadResp,'unitId');
           rs.FieldByName('CALC_UNITS').AsString := GetNodeValue(pubGoodsDownloadResp,'calcUnits');
           rs.FieldByName('SMALL_UNITS').AsString := GetNodeValue(pubGoodsDownloadResp,'smallUnits');
           rs.FieldByName('BIG_UNITS').AsString := GetNodeValue(pubGoodsDownloadResp,'bigUnits');
           rs.FieldByName('SMALLTO_CALC').AsFloat := StrtoFloatDef(GetNodeValue(pubGoodsDownloadResp,'smalltoCalc'),0);
           rs.FieldByName('BIGTO_CALC').AsFloat := StrtoFloatDef(GetNodeValue(pubGoodsDownloadResp,'bigtoCalc'),0);
           rs.FieldByName('NEW_INPRICE').AsFloat := StrtoFloatDef(GetNodeValue(pubGoodsDownloadResp,'newInprice'),0);
           rs.FieldByName('NEW_OUTPRICE').AsFloat := StrtoFloatDef(GetNodeValue(pubGoodsDownloadResp,'newOutprice'),0);
           rs.FieldByName('NEW_LOWPRICE').AsFloat := StrtoFloatDef(GetNodeValue(pubGoodsDownloadResp,'newLowprice'),0);
           rs.FieldByName('USING_PRICE').AsInteger := StrtoInt(GetNodeValue(pubGoodsDownloadResp,'usingPrice'));
           rs.FieldByName('HAS_INTEGRAL').AsInteger := StrtoInt(GetNodeValue(pubGoodsDownloadResp,'hasIntegral'));
           rs.FieldByName('USING_BATCH_NO').AsInteger := StrtoInt(GetNodeValue(pubGoodsDownloadResp,'usingBatchNo'));
           rs.FieldByName('USING_BARTER').AsInteger := StrtoInt(GetNodeValue(pubGoodsDownloadResp,'usingBarter'));
           rs.FieldByName('USING_LOCUS_NO').AsInteger := StrtoInt(GetNodeValue(pubGoodsDownloadResp,'usingLocusNo'));
           rs.FieldByName('BARTER_INTEGRAL').AsInteger := StrtoInt(GetNodeValue(pubGoodsDownloadResp,'barterIntegral'));
           rs.FieldByName('REMARK').AsString := GetNodeValue(pubGoodsDownloadResp,'remark');
           rs.FieldByName('COMM').AsString := GetNodeValue(pubGoodsDownloadResp,'comm');
           TLargeintField(rs.FieldByName('TIME_STAMP')).AsLargeInt := StrtoInt64(GetNodeValue(pubGoodsDownloadResp,'timeStamp'));
           rs.Post;
           pubGoodsDownloadResp := pubGoodsDownloadResp.nextSibling;
         end;
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODSINFO';
        Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;GODS_ID';
        Factor.UpdateBatch(rs,'TSyncSingleTable',Params);
        SetSynTimeStamp('PUB_GOODSINFO',timeStamp,'#');
      finally
        Params.free;
      end;
      LogFile.AddLogFile(0,'保存<商品资料>执行时长:'+inttostr(GetTicket)+' 记录数:'+inttostr(rs.RecordCount));
    finally
      rs.Free;
    end;
  finally
    rio.Free;
  end;
except
  LogFile.AddLogFile(0,'下载<商品资料>xml='+doc.xml);
  Raise;
end;
end;

function TCaFactory.downloadUnit(TenantId, flag: integer): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  pubGoodsUnitDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  rs:TZQuery;
  Params:TftParamList;
  OutXml:WideString;
begin
try
  SetTicket;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(GetSynTimeStamp('PUB_MEAUNITS','#'));
  FindNode(doc,'header\pub').appendChild(Node);
  LogFile.AddLogFile(0,'开始下载<商品单位>上次同步时间:'+Node.text+' 本次同步时间:'+inttostr(TimeStamp));

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(60000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetRspDownloadWebServiceImpl(true,URL+'RspDownloadService?wsdl',rio).downloadUnit(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    LogFile.AddLogFile(0,'下载<计量单位>打开时长:'+inttostr(GetTicket));
    SetTicket;
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.FieldDefs.Add('UNIT_ID',ftstring,36,true);
      rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
      rs.FieldDefs.Add('UNIT_NAME',ftstring,30,true);
      rs.FieldDefs.Add('UNIT_SPELL',ftstring,30,true);
      rs.FieldDefs.Add('SEQ_NO',ftInteger,0,true);
      rs.FieldDefs.Add('COMM',ftstring,2,true);
      rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
      rs.CreateDataSet;
      pubGoodsUnitDownloadResp := Node.firstChild;
      while pubGoodsUnitDownloadResp<>nil do
         begin
           rs.Append;
           rs.FieldByName('UNIT_ID').AsString := GetNodeValue(pubGoodsUnitDownloadResp,'unitId');
           rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(GetNodeValue(pubGoodsUnitDownloadResp,'tenantId'));
           rs.FieldByName('UNIT_NAME').AsString := GetNodeValue(pubGoodsUnitDownloadResp,'unitName');
           rs.FieldByName('UNIT_SPELL').AsString := GetNodeValue(pubGoodsUnitDownloadResp,'unitSpell');
           if GetNodeValue(pubGoodsUnitDownloadResp,'seqNo')='' then
           rs.FieldByName('SEQ_NO').AsInteger := 0 else
           rs.FieldByName('SEQ_NO').AsInteger := StrtoInt(GetNodeValue(pubGoodsUnitDownloadResp,'seqNo'));
           rs.FieldByName('COMM').AsString := GetNodeValue(pubGoodsUnitDownloadResp,'comm');
           TLargeintField(rs.FieldByName('TIME_STAMP')).AsLargeInt := StrtoInt64(GetNodeValue(pubGoodsUnitDownloadResp,'timeStamp'));
           rs.Post;
           pubGoodsUnitDownloadResp := pubGoodsUnitDownloadResp.nextSibling;
         end;
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('TABLE_NAME').AsString := 'PUB_MEAUNITS';
        Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;UNIT_ID';
        Factor.UpdateBatch(rs,'TSyncSingleTable',Params);
        SetSynTimeStamp('PUB_MEAUNITS',timeStamp,'#');
      finally
        Params.free;
      end;
      LogFile.AddLogFile(0,'保存<计量单位>执行时长:'+inttostr(GetTicket)+' 记录数:'+inttostr(rs.RecordCount));
    finally
      rs.Free;
    end;
  finally
    rio.Free;
  end;
except
  LogFile.AddLogFile(0,'下载<商品单位>xml='+doc.xml);
  Raise;
end;
end;

function TCaFactory.downloadDeployGoods(TenantId, flag: integer): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  pubDeployGoodsDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  rs:TZQuery;
  Params:TftParamList;
  OutXml:WideString;
begin
try
  SetTicket;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(GetSynTimeStamp('PUB_GOODS_RELATION','#'));
  FindNode(doc,'header\pub').appendChild(Node);
  LogFile.AddLogFile(0,'开始下载<供应链商品>上次同步时间:'+Node.text+' 本次同步时间:'+inttostr(TimeStamp));

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(60000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetRspDownloadWebServiceImpl(true,URL+'RspDownloadService?wsdl',rio).downloadDeployGoods(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    LogFile.AddLogFile(0,'下载<供应链商品>打开时长:'+inttostr(GetTicket));
    SetTicket;
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.FieldDefs.Add('ROWS_ID',ftstring,36,true);
      rs.FieldDefs.Add('RELATION_ID',ftInteger,0,true);
      rs.FieldDefs.Add('GODS_ID',ftstring,36,true);
      rs.FieldDefs.Add('SECOND_ID',ftstring,36,true);
      rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
      rs.FieldDefs.Add('GODS_CODE',ftstring,20,true);
      rs.FieldDefs.Add('GODS_NAME',ftstring,50,true);
      rs.FieldDefs.Add('GODS_SPELL',ftstring,50,true);
      rs.FieldDefs.Add('SORT_ID1',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID2',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID3',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID4',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID5',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID6',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID7',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID8',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID9',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID10',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID11',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID12',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID13',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID14',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID15',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID16',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID17',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID18',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID19',ftstring,36,true);
      rs.FieldDefs.Add('SORT_ID20',ftstring,36,true);
      rs.FieldDefs.Add('NEW_INPRICE',ftFloat,0,true);
      rs.FieldDefs.Add('NEW_OUTPRICE',ftFloat,0,true);
      rs.FieldDefs.Add('NEW_LOWPRICE',ftFloat,0,true);
      rs.FieldDefs.Add('USING_PRICE',ftInteger,0,true);
      rs.FieldDefs.Add('HAS_INTEGRAL',ftInteger,0,true);
      rs.FieldDefs.Add('USING_BATCH_NO',ftInteger,0,true);
      rs.FieldDefs.Add('USING_BARTER',ftInteger,0,true);
      rs.FieldDefs.Add('USING_LOCUS_NO',ftInteger,0,true);
      rs.FieldDefs.Add('BARTER_INTEGRAL',ftInteger,0,true);
      rs.FieldDefs.Add('COMM',ftstring,2,true);
      rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
      rs.CreateDataSet;
      pubDeployGoodsDownloadResp := Node.firstChild;
      while pubDeployGoodsDownloadResp<>nil do
         begin
           rs.Append;
           rs.FieldByName('ROWS_ID').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'rowsId');
           rs.FieldByName('RELATION_ID').AsInteger := StrtoInt(GetNodeValue(pubDeployGoodsDownloadResp,'relationId'));
           rs.FieldByName('SECOND_ID').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'secondId');
           rs.FieldByName('GODS_ID').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'godsId');
           rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(GetNodeValue(pubDeployGoodsDownloadResp,'tenantId'));
           rs.FieldByName('GODS_CODE').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'godsCode');
           if rs.FieldByName('GODS_CODE').AsString='' then rs.FieldByName('GODS_CODE').Value := null;
           rs.FieldByName('GODS_NAME').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'godsName');
           if rs.FieldByName('GODS_NAME').AsString='' then rs.FieldByName('GODS_NAME').Value := null;
           rs.FieldByName('GODS_SPELL').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'godsSpell');
           if rs.FieldByName('GODS_SPELL').AsString='' then rs.FieldByName('GODS_SPELL').Value := null;
           rs.FieldByName('SORT_ID1').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId1');
           if rs.FieldByName('SORT_ID1').AsString='' then rs.FieldByName('SORT_ID1').Value := null;
           rs.FieldByName('SORT_ID2').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId2');
           if rs.FieldByName('SORT_ID2').AsString='' then rs.FieldByName('SORT_ID2').Value := null;
           rs.FieldByName('SORT_ID3').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId3');
           if rs.FieldByName('SORT_ID3').AsString='' then rs.FieldByName('SORT_ID3').Value := null;
           rs.FieldByName('SORT_ID4').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId4');
           if rs.FieldByName('SORT_ID4').AsString='' then rs.FieldByName('SORT_ID4').Value := null;
           rs.FieldByName('SORT_ID5').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId5');
           if rs.FieldByName('SORT_ID5').AsString='' then rs.FieldByName('SORT_ID5').Value := null;
           rs.FieldByName('SORT_ID6').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId6');
           if rs.FieldByName('SORT_ID6').AsString='' then rs.FieldByName('SORT_ID6').Value := null;
           rs.FieldByName('SORT_ID7').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId7');
           if rs.FieldByName('SORT_ID7').AsString='' then rs.FieldByName('SORT_ID7').Value := null;
           rs.FieldByName('SORT_ID8').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId8');
           if rs.FieldByName('SORT_ID8').AsString='' then rs.FieldByName('SORT_ID8').Value := null;
           rs.FieldByName('SORT_ID9').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId9');
           if rs.FieldByName('SORT_ID9').AsString='' then rs.FieldByName('SORT_ID9').Value := null;
           rs.FieldByName('SORT_ID10').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId10');
           if rs.FieldByName('SORT_ID10').AsString='' then rs.FieldByName('SORT_ID10').Value := null;
           rs.FieldByName('SORT_ID11').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId11');
           if rs.FieldByName('SORT_ID11').AsString='' then rs.FieldByName('SORT_ID11').Value := null;
           rs.FieldByName('SORT_ID12').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId12');
           if rs.FieldByName('SORT_ID12').AsString='' then rs.FieldByName('SORT_ID12').Value := null;
           rs.FieldByName('SORT_ID13').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId13');
           if rs.FieldByName('SORT_ID13').AsString='' then rs.FieldByName('SORT_ID13').Value := null;
           rs.FieldByName('SORT_ID14').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId14');
           if rs.FieldByName('SORT_ID14').AsString='' then rs.FieldByName('SORT_ID14').Value := null;
           rs.FieldByName('SORT_ID15').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId15');
           if rs.FieldByName('SORT_ID15').AsString='' then rs.FieldByName('SORT_ID15').Value := null;
           rs.FieldByName('SORT_ID16').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId16');
           if rs.FieldByName('SORT_ID16').AsString='' then rs.FieldByName('SORT_ID16').Value := null;
           rs.FieldByName('SORT_ID17').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId17');
           if rs.FieldByName('SORT_ID17').AsString='' then rs.FieldByName('SORT_ID17').Value := null;
           rs.FieldByName('SORT_ID18').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId18');
           if rs.FieldByName('SORT_ID18').AsString='' then rs.FieldByName('SORT_ID18').Value := null;
           rs.FieldByName('SORT_ID19').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId19');
           if rs.FieldByName('SORT_ID19').AsString='' then rs.FieldByName('SORT_ID19').Value := null;
           rs.FieldByName('SORT_ID20').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'sortId20');
           if rs.FieldByName('SORT_ID20').AsString='' then rs.FieldByName('SORT_ID20').Value := null;
           if GetNodeValue(pubDeployGoodsDownloadResp,'newInprice')='' then
              rs.FieldByName('NEW_INPRICE').Value := null
           else
              rs.FieldByName('NEW_INPRICE').AsFloat := StrtoFloatDef(GetNodeValue(pubDeployGoodsDownloadResp,'newInprice'),0);
           if GetNodeValue(pubDeployGoodsDownloadResp,'newOutprice')='' then
              rs.FieldByName('NEW_OUTPRICE').Value := null
           else
              rs.FieldByName('NEW_OUTPRICE').AsFloat := StrtoFloatDef(GetNodeValue(pubDeployGoodsDownloadResp,'newOutprice'),0);
           if GetNodeValue(pubDeployGoodsDownloadResp,'newLowprice')='' then
              rs.FieldByName('NEW_LOWPRICE').Value := null
           else
              rs.FieldByName('NEW_LOWPRICE').AsFloat := StrtoFloatDef(GetNodeValue(pubDeployGoodsDownloadResp,'newLowprice'),0);
           if GetNodeValue(pubDeployGoodsDownloadResp,'usingPrice')='' then
              rs.FieldByName('USING_PRICE').Value := null
           else
              rs.FieldByName('USING_PRICE').AsInteger := StrtoInt(GetNodeValue(pubDeployGoodsDownloadResp,'usingPrice'));
           if GetNodeValue(pubDeployGoodsDownloadResp,'hasIntegral')='' then
              rs.FieldByName('HAS_INTEGRAL').Value := null
           else
              rs.FieldByName('HAS_INTEGRAL').AsInteger := StrtoInt(GetNodeValue(pubDeployGoodsDownloadResp,'hasIntegral'));
           if GetNodeValue(pubDeployGoodsDownloadResp,'usingBatchNo')='' then
              rs.FieldByName('USING_BATCH_NO').Value := null
           else
              rs.FieldByName('USING_BATCH_NO').AsInteger := StrtoInt(GetNodeValue(pubDeployGoodsDownloadResp,'usingBatchNo'));
           if GetNodeValue(pubDeployGoodsDownloadResp,'usingBarter')='' then
              rs.FieldByName('USING_BARTER').Value := null
           else
              rs.FieldByName('USING_BARTER').AsInteger := StrtoInt(GetNodeValue(pubDeployGoodsDownloadResp,'usingBarter'));
           if GetNodeValue(pubDeployGoodsDownloadResp,'usingLocusNo')='' then
              rs.FieldByName('USING_LOCUS_NO').Value := null
           else
              rs.FieldByName('USING_LOCUS_NO').AsInteger := StrtoInt(GetNodeValue(pubDeployGoodsDownloadResp,'usingLocusNo'));
           if GetNodeValue(pubDeployGoodsDownloadResp,'barterIntegral')='' then
              rs.FieldByName('BARTER_INTEGRAL').Value := null
           else
              rs.FieldByName('BARTER_INTEGRAL').AsInteger := StrtoInt(GetNodeValue(pubDeployGoodsDownloadResp,'barterIntegral'));
           rs.FieldByName('COMM').AsString := GetNodeValue(pubDeployGoodsDownloadResp,'comm');
           TLargeintField(rs.FieldByName('TIME_STAMP')).AsLargeInt := StrtoInt64(GetNodeValue(pubDeployGoodsDownloadResp,'timeStamp'));
           rs.Post;
           pubDeployGoodsDownloadResp := pubDeployGoodsDownloadResp.nextSibling;
         end;
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODS_RELATION';
        Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;GODS_ID;RELATION_ID';
        Factor.UpdateBatch(rs,'TSyncSingleTable',Params);
        SetSynTimeStamp('PUB_GOODS_RELATION',timeStamp,'#');
      finally
        Params.free;
      end;
      LogFile.AddLogFile(0,'保存<供应链商品>执行时长:'+inttostr(GetTicket)+' 记录数:'+inttostr(rs.RecordCount));
    finally
      rs.Free;
    end;
  finally
    rio.Free;
  end;
except
  LogFile.AddLogFile(0,'下载<商品分类>xml='+doc.xml);
  Raise;
end;
end;

function TCaFactory.downloadBarcode(TenantId, flag: integer): boolean;
var
  inxml:string;
  doc:IXMLDomDocument;
  rio:THTTPRIO;
  pubBarcodeDownloadResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  line:PServiceLine;
  h,r:rsp;
  i:integer;
  rs:TZQuery;
  Params:TftParamList;
  OutXml:WideString;
begin
try
  SetTicket;
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(GetSynTimeStamp('PUB_BARCODE','#'));
  FindNode(doc,'header\pub').appendChild(Node);
  LogFile.AddLogFile(0,'开始下载<商品条码>上次同步时间:'+Node.text+' 本次同步时间:'+inttostr(TimeStamp));

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  rio := CreateRio(60000);
  try
    h := SendHeader(rio,2);
    try
      try
        OutXml := GetRspDownloadWebServiceImpl(true,URL+'RspDownloadService?wsdl',rio).downloadBarcode(Encode(inxml,sslpwd));
        r := GetHeader(rio);
        try
          case r.encryptType of
          2:doc := CreateXML(Decode(OutXml,sslpwd) );
          1:doc := CreateXML(Decode(OutXml,Pubpwd) );
          else doc := CreateXML(Decode(OutXml,''));
          end;
        finally
          r.Free;
        end;
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
    Node := FindNode(doc,'body');
    LogFile.AddLogFile(0,'下载<商品条码>打开时长:'+inttostr(GetTicket));
    SetTicket;
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.FieldDefs.Add('ROWS_ID',ftstring,36,true);
      rs.FieldDefs.Add('GODS_ID',ftstring,36,true);
      rs.FieldDefs.Add('TENANT_ID',ftInteger,0,true);
      rs.FieldDefs.Add('PROPERTY_01',ftstring,36,true);
      rs.FieldDefs.Add('PROPERTY_02',ftstring,36,true);
      rs.FieldDefs.Add('UNIT_ID',ftstring,36,true);
      rs.FieldDefs.Add('BARCODE_TYPE',ftstring,1,true);
      rs.FieldDefs.Add('BATCH_NO',ftstring,36,true);
      rs.FieldDefs.Add('BARCODE',ftstring,30,true);
      rs.FieldDefs.Add('COMM',ftstring,2,true);
      rs.FieldDefs.Add('TIME_STAMP',ftLargeInt,0,true);
      rs.CreateDataSet;
      pubBarcodeDownloadResp := Node.firstChild;
      while pubBarcodeDownloadResp<>nil do
         begin
           rs.Append;
           rs.FieldByName('ROWS_ID').AsString := GetNodeValue(pubBarcodeDownloadResp,'rowsId');
           rs.FieldByName('GODS_ID').AsString := GetNodeValue(pubBarcodeDownloadResp,'godsId');
           rs.FieldByName('TENANT_ID').AsInteger := StrtoInt(GetNodeValue(pubBarcodeDownloadResp,'tenantId'));
           rs.FieldByName('PROPERTY_01').AsString := GetNodeValue(pubBarcodeDownloadResp,'property01');
           rs.FieldByName('PROPERTY_02').AsString := GetNodeValue(pubBarcodeDownloadResp,'property02');
           rs.FieldByName('UNIT_ID').AsString := GetNodeValue(pubBarcodeDownloadResp,'unitId');
           rs.FieldByName('BARCODE_TYPE').AsInteger := StrtoInt(GetNodeValue(pubBarcodeDownloadResp,'barcodeType'));
           rs.FieldByName('BATCH_NO').AsString := GetNodeValue(pubBarcodeDownloadResp,'batchNo');
           rs.FieldByName('BARCODE').AsString := GetNodeValue(pubBarcodeDownloadResp,'barcode');
           rs.FieldByName('COMM').AsString := GetNodeValue(pubBarcodeDownloadResp,'comm');
           TLargeintField(rs.FieldByName('TIME_STAMP')).AsLargeInt := StrtoInt64(GetNodeValue(pubBarcodeDownloadResp,'timeStamp'));
           rs.Post;
           pubBarcodeDownloadResp := pubBarcodeDownloadResp.nextSibling;
         end;
      Params := TftParamList.Create(nil);
      try
        Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        Params.ParamByName('TABLE_NAME').AsString := 'PUB_BARCODE';
        Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;GODS_ID;PROPERTY_01;PROPERTY_02;UNIT_ID';
        Factor.UpdateBatch(rs,'TSyncSingleTable',Params);
        SetSynTimeStamp('PUB_BARCODE',timeStamp,'#');
      finally
        Params.free;
      end;
      LogFile.AddLogFile(0,'保存<下载条码>执行时长:'+inttostr(GetTicket)+' 记录数:'+inttostr(rs.RecordCount));
    finally
      rs.Free;
    end;
  finally
    rio.Free;
  end;
except
  LogFile.AddLogFile(0,'下载<商品条码>xml='+doc.xml);
  Raise;
end;
end;

function TCaFactory.AutoCoLogo: boolean;
var Temp:TZQuery;
begin
  Temp := TZQuery.Create(nil);
  try
    Temp.Close;
    Temp.SQL.Text := 'select LOGIN_NAME,PASSWRD from CA_TENANT where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID);
    Factor.Open(Temp);
    coLogin(Temp.Fields[0].AsString,DecStr(Temp.Fields[1].AsString,ENC_KEY));
  finally
    Temp.Free;
  end;
end;

procedure TCaFactory.SetTimeStamp(const Value: int64);
begin
  FTimeStamp := Value;
end;

function TCaFactory.GetTicket: Int64;
begin
  result := GetTickCount-_Start;
end;

procedure TCaFactory.SetTicket;
begin
  _Start := GetTickCount;
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

