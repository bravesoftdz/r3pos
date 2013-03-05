unit rspHeader;

interface
uses
  Windows, Messages, SysUtils, Classes,InvokeRegistry,WinInet,SOAPHTTPClient,des;
type
  rsp = class(TSOAPHeader)
  private
    FencryptType: integer;
    FrspSessionId: ansistring;
    procedure SetencryptType(const Value: integer);
    procedure SetrspSessionId(const Value: ansistring);
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property rspSessionId: ansistring read FrspSessionId write SetrspSessionId;
    property encryptType:integer read FencryptType write SetencryptType;
  end;

  TRspFactory=class
  private
    timeout,connectTimeOut:integer;
    HTTPRIO : THTTPRIO;
    Addr: ansistring;
    flag:integer;
    function Encode(inxml:Ansistring;Key:Ansistring):Ansistring;
    function Decode(inxml:Ansistring;Key:Ansistring):Ansistring;
    procedure doAfterExecute(const MethodName: string;
      SOAPResponse: TStream);
    function SendHeader(rio: THTTPRIO; flag: integer=1):rsp;
    function GetHeader(rio: THTTPRIO):boolean;
  public
    constructor Create(_timeOut:integer;url: ansistring;_flag:integer);
    destructor Destroy;override;
    //还回异常
    function ErrorEncode(Err: ansistring): ansistring;
    //企业服务
    function coLogin(inxml:AnsiString): ansistring;
    function coRegister(inxml: ansistring): ansistring;
    function getTenantInfo(inxml: ansistring): ansistring;
    function getShopInfo(inxml: ansistring): ansistring;
    function checkLicese(inxml: ansistring): ansistring;
    //产品服务
    function checkUpgrade(inxml: ansistring): ansistring;
    function listModules(inxml: ansistring): ansistring;
    //供应链服务
    function createServiceLine(inxml: ansistring): ansistring;
    function queryServiceLines(inxml: ansistring): ansistring;
    function applyRelation(inxml: ansistring): ansistring;
    //数据下载服务
    function downloadTenants(inxml: ansistring): ansistring;
    function downloadServiceLines(inxml: ansistring): ansistring;
    function downloadRelations(inxml: ansistring): ansistring;
    function downloadSort(inxml: ansistring): ansistring;
    function downloadUnit(inxml: ansistring): ansistring;
    function downloadGoods(inxml: ansistring): ansistring;
    function downloadDeployGoods(inxml: ansistring): ansistring;
    function downloadBarcode(inxml: ansistring): ansistring;
    //消费者服务
    function queryUnion(inxml: ansistring): ansistring;
    //商品服务
    function uploadGoods(inxml: ansistring): ansistring;
    function getGoodsInfo(inxml: ansistring): ansistring;
  end;
var
  SessionId: ansistring;
  pubpwd: ansistring;
  sslpwd: ansistring;
  encryptType:integer;
implementation
uses ZLibExGZ,DCPbase64,PubMemberService,RspDownloadService,CaProductService,CaServiceLineService,CaTenantService,PubGoodsService;
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

procedure rsp.SetrspSessionId(const Value: ansistring);
begin
  FrspSessionId := Value;
end;

{ TRspFactory }

function TRspFactory.applyRelation(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaServiceLineWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaServiceLineWebServiceImpl(true,Addr+'CaServiceLineService?wsdl',HTTPRIO);
    outXml := intf.applyRelation(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.checkLicese(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaTenantWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaTenantWebServiceImpl(true,Addr+'CaTenantService?wsdl',HTTPRIO);
    outXml := intf.checkLicese(Encode(inxml,Pubpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.checkUpgrade(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaProductWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaProductWebServiceImpl(true,Addr+'CaProductService?wsdl',HTTPRIO);
    outXml := intf.checkUpgrade(Encode(inxml,pubpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.coLogin(inxml: AnsiString): ansistring;
var
  r:rsp;
  intf:CaTenantWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaTenantWebServiceImpl(true,Addr+'CaTenantService?wsdl',HTTPRIO);
    outXml := intf.login(Encode(inxml,pubpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.coRegister(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaTenantWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaTenantWebServiceImpl(true,Addr+'CaTenantService?wsdl',HTTPRIO);
    outXml := intf.register(Encode(inxml,pubpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

constructor TRspFactory.Create(_timeOut:integer;url: ansistring;_flag:integer);
begin
  pubpwd := 'SaRi0+jf';
  timeOut := _timeOut;
  connectTimeOut := 20000;
  flag := _flag;
  Addr := url;
  HTTPRIO := THTTPRIO.Create(nil);
  HTTPRIO.HTTPWebNode.ConnectTimeout := ConnectTimeOut;
  HTTPRIO.HTTPWebNode.ReceiveTimeout := _timeOut;
  HTTPRIO.HTTPWebNode.SendTimeout := _timeOut;
  if _timeOut>0 then
     HTTPRIO.OnAfterExecute := doAfterExecute
  else
     HTTPRIO.OnAfterExecute := nil;
end;

function TRspFactory.createServiceLine(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaServiceLineWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaServiceLineWebServiceImpl(true,Addr+'CaServiceLineService?wsdl',HTTPRIO);
    outXml := intf.createServiceLine(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.Decode(inxml, Key: Ansistring): Ansistring;
var
  gzip:Ansistring;
  DecStr:Ansistring;
begin
  DecStr := Base64DecodeStr(inxml);
  if Key='' then
  gzip := DecStr else
  gzip := DecryStr(DecStr,Key);
  GZDecompressString(result,gzip);
end;

destructor TRspFactory.Destroy;
begin
  inherited;
end;

function TRspFactory.SendHeader(rio: THTTPRIO;flag:integer=1):rsp;
begin
  result := rsp.Create;
  result.rspSessionId := SessionId;
  result.encryptType := flag;
  rio.SOAPHeaders.Send(result);
end;

procedure TRspFactory.doAfterExecute(const MethodName: string;
  SOAPResponse: TStream);
begin
  try
    InternetSetOption(nil, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@connectTimeOut), SizeOf(connectTimeOut));
    InternetSetOption(nil, INTERNET_OPTION_SEND_TIMEOUT, Pointer(@timeout), SizeOf(timeout));
    InternetSetOption(nil, INTERNET_OPTION_RECEIVE_TIMEOUT, Pointer(@timeout), SizeOf(timeout));
  except
    on E:Exception do
       begin
         Raise;
       end;
  end;
end;

function TRspFactory.downloadBarcode(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    outXml := intf.downloadBarcode(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadDeployGoods(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    outXml := intf.downloadDeployGoods(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadGoods(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    outXml := intf.downloadGoods(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadRelations(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    outXml := intf.downloadRelations(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadServiceLines(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    outXml := intf.downloadServiceLines(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadSort(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    outXml := intf.downloadSort(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadTenants(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    outXml := intf.downloadTenants(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadUnit(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    outXml := intf.downloadUnit(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.Encode(inxml, Key: Ansistring): Ansistring;
var
  gzip:RawByteString;
  EncStr:Ansistring;
begin
  GZCompressString(gzip,inxml);
  if Key='' then
  EncStr := gzip else
  EncStr := EncryStr(gzip,Key);
  result := Base64EncodeStr(EncStr);
end;

function TRspFactory.ErrorEncode(Err: ansistring): ansistring;
begin
  result := '<Err>:'+Err;
end;

function TRspFactory.GetHeader(rio: THTTPRIO): boolean;
var r:rsp;
begin
  r := rsp(rio.SOAPHeaders.Get(rsp));
  try
    SessionId := r.rspSessionId;
    encryptType := r.encryptType;
  finally
    r.Free;
  end;
  result := true;
end;

function TRspFactory.getShopInfo(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaTenantWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaTenantWebServiceImpl(true,Addr+'CaTenantService?wsdl',HTTPRIO);
    outXml := intf.getShopInfo(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.getTenantInfo(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaTenantWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaTenantWebServiceImpl(true,Addr+'CaTenantService?wsdl',HTTPRIO);
    outXml := intf.getTenantInfo(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.listModules(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaProductWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaProductWebServiceImpl(true,Addr+'CaProductService?wsdl',HTTPRIO);
    outXml := intf.listModules(Encode(inxml,pubpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.queryServiceLines(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:CaServiceLineWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaServiceLineWebServiceImpl(true,Addr+'CaServiceLineService?wsdl',HTTPRIO);
    outXml := intf.queryServiceLines(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.queryUnion(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:PubMemberWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetPubMemberWebServiceImpl(true,Addr+'PubMemberService?wsdl',HTTPRIO);
    outXml := intf.queryUnion(Encode(inxml,sslpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.uploadGoods(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:PubGoodsWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetPubGoodsWebServiceImpl(true,Addr+'PubGoodsService?wsdl',HTTPRIO);
    outXml := intf.uploadGoods(Encode(inxml,Pubpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.getGoodsInfo(inxml: ansistring): ansistring;
var
  r:rsp;
  intf:PubGoodsWebServiceImpl;
  outXml: ansistring;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetPubGoodsWebServiceImpl(true,Addr+'PubGoodsService?wsdl',HTTPRIO);
    outXml := intf.getGoodsInfo(Encode(inxml,Pubpwd));
    GetHeader(HTTPRIO);
    case encryptType of
    2:result := Decode(outXml,sslpwd);
    1:result := Decode(outXml,Pubpwd);
    else result := Decode(outXml,'');
    end;
  finally
    intf := nil;
    r.Free;
  end;
end;

initialization
  InvRegistry.RegisterHeaderClass(TypeInfo(CaTenantWebServiceImpl), rsp, 'rsp', 'http://www.rspcn.com.cn/rsp');
  InvRegistry.RegisterHeaderClass(TypeInfo(CaServiceLineWebServiceImpl), rsp, 'rsp', 'http://www.rspcn.com.cn/rsp');
  InvRegistry.RegisterHeaderClass(TypeInfo(PubMemberWebServiceImpl), rsp, 'rsp', 'http://www.rspcn.com.cn/rsp');
  InvRegistry.RegisterHeaderClass(TypeInfo(RspDownloadWebServiceImpl), rsp, 'rsp', 'http://www.rspcn.com.cn/rsp');
  InvRegistry.RegisterHeaderClass(TypeInfo(CaProductWebServiceImpl), rsp, 'rsp', 'http://www.rspcn.com.cn/rsp');
  RemClassRegistry.RegisterXSClass(rsp, 'http://www.rspcn.com.cn/rsp', 'rsp');
end.
