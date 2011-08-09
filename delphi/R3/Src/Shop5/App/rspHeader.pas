unit rspHeader;

interface
uses
  Windows, Messages, SysUtils, Classes,InvokeRegistry,WinInet,SOAPHTTPClient;
type
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

  TRspFactory=class
  private
    timeout:integer;
    HTTPRIO : THTTPRIO;
    Addr:string;
    flag:integer;
    function Encode(inxml:String;Key:string):String;
    function Decode(inxml:String;Key:string):String;
    procedure doAfterExecute(const MethodName: string;
      SOAPResponse: TStream);
    function SendHeader(rio: THTTPRIO; flag: integer=1):rsp;
    function GetHeader(rio: THTTPRIO):boolean;
  public
    constructor Create(_timeOut:integer;url:string;_flag:integer);
    destructor Destroy;override;
    //还回异常
    function ErrorEncode(Err:string):string;
    //企业服务
    function coLogin(inxml:string):string;
    function coRegister(inxml:string):string;
    function getTenantInfo(inxml:string):string;
    //产品服务
    function checkUpgrade(inxml:string):string;
    function listModules(inxml:string):string;
    //供应链服务
    function createServiceLine(inxml:string):string;
    function queryServiceLines(inxml:string):string;
    function applyRelation(inxml:string):string;
    //数据下载服务
    function downloadTenants(inxml:string):string;
    function downloadServiceLines(inxml:string):string;
    function downloadRelations(inxml:string):string;
    function downloadSort(inxml:string):string;
    function downloadUnit(inxml:string):string;
    function downloadGoods(inxml:string):string;
    function downloadDeployGoods(inxml:string):string;
    function downloadBarcode(inxml:string):string;
    //消费者服务
    function queryUnion(inxml:string):string;

  end;
var
  SessionId: string;
  pubpwd:string;
  sslpwd:string;
implementation
uses ZLibExGZ,Des,encddecd,PubMemberService,RspDownloadService,CaProductService,CaServiceLineService,CaTenantService;
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

{ TRspFactory }

function TRspFactory.applyRelation(inxml: string): string;
var
  r:rsp;
  intf:CaServiceLineWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaServiceLineWebServiceImpl(true,Addr+'CaServiceLineService?wsdl',HTTPRIO);
    result := intf.applyRelation(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.checkUpgrade(inxml: string): string;
var
  r:rsp;
  intf:CaProductWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaProductWebServiceImpl(true,Addr+'CaProductService?wsdl',HTTPRIO);
    result := intf.checkUpgrade(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.coLogin(inxml: string): string;
var
  r:rsp;
  intf:CaTenantWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaTenantWebServiceImpl(true,Addr+'CaTenantService?wsdl',HTTPRIO);
    result := intf.login(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.coRegister(inxml: string): string;
var
  r:rsp;
  intf:CaTenantWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaTenantWebServiceImpl(true,Addr+'CaTenantService?wsdl',HTTPRIO);
    result := intf.register(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

constructor TRspFactory.Create(_timeOut:integer;url:string;_flag:integer);
begin
  pubpwd := 'SaRi0+jf';
  timeOut := _timeOut;
  flag := _flag;
  Addr := url;
  HTTPRIO := THTTPRIO.Create(nil);
  if _timeOut>0 then
     HTTPRIO.OnAfterExecute := doAfterExecute
  else
     HTTPRIO.OnAfterExecute := nil;
end;

function TRspFactory.createServiceLine(inxml: string): string;
var
  r:rsp;
  intf:CaServiceLineWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaServiceLineWebServiceImpl(true,Addr+'CaServiceLineService?wsdl',HTTPRIO);
    result := intf.createServiceLine(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.Decode(inxml, Key: string): String;
var
  gzip:RawByteString;
  DecStr:string;
begin
  DecStr := encddecd.DecodeString(inxml);
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

function TRspFactory.downloadBarcode(inxml: string): string;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    result := intf.downloadBarcode(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadDeployGoods(inxml: string): string;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    result := intf.downloadDeployGoods(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadGoods(inxml: string): string;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    result := intf.downloadGoods(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadRelations(inxml: string): string;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    result := intf.downloadRelations(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadServiceLines(inxml: string): string;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    result := intf.downloadServiceLines(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadSort(inxml: string): string;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    result := intf.downloadSort(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadTenants(inxml: string): string;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    result := intf.downloadTenants(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.downloadUnit(inxml: string): string;
var
  r:rsp;
  intf:RspDownloadWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetRspDownloadWebServiceImpl(true,Addr+'RspDownloadService?wsdl',HTTPRIO);
    result := intf.downloadUnit(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.Encode(inxml, Key: string): String;
var
  gzip:RawByteString;
  EncStr:String;
begin
  GZCompressString(gzip,inxml);
  if Key='' then
  EncStr := gzip else
  EncStr := EncryStr(gzip,Key);
  result := encddecd.EncodeString(EncStr);
end;

function TRspFactory.ErrorEncode(Err: string): string;
begin
  result := '<Err>:'+Err;
end;

function TRspFactory.GetHeader(rio: THTTPRIO): boolean;
var r:rsp;
begin
  r := rsp(rio.SOAPHeaders.Get(rsp));
  try
    SessionId := r.rspSessionId;
    sslpwd := r.encryptType;
  finally
    r.Free;
  end;
  result := true;
end;

function TRspFactory.getTenantInfo(inxml: string): string;
var
  r:rsp;
  intf:CaTenantWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaTenantWebServiceImpl(true,Addr+'CaTenantService?wsdl',HTTPRIO);
    result := intf.getTenantInfo(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.listModules(inxml: string): string;
var
  r:rsp;
  intf:CaProductWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaProductWebServiceImpl(true,Addr+'CaProductService?wsdl',HTTPRIO);
    result := intf.listModules(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.queryServiceLines(inxml: string): string;
var
  r:rsp;
  intf:CaServiceLineWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetCaServiceLineWebServiceImpl(true,Addr+'CaServiceLineService?wsdl',HTTPRIO);
    result := intf.queryServiceLines(inxml);
    GetHeader(HTTPRIO);
  finally
    intf := nil;
    r.Free;
  end;
end;

function TRspFactory.queryUnion(inxml: string): string;
var
  r:rsp;
  intf:PubMemberWebServiceImpl;
begin
  r := SendHeader(HTTPRIO,flag);
  try
    intf := GetPubMemberWebServiceImpl(true,Addr+'PubMemberService?wsdl',HTTPRIO);
    result := intf.queryUnion(inxml);
    GetHeader(HTTPRIO);
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
