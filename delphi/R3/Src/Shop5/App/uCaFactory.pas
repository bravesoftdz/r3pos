unit uCaFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,Des,WinInet;
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
    SRVR_PATH:string;
  end;
  TCaFactory=class
  private
    FSSL: string;
    FURL: string;
    procedure SetSSL(const Value: string);
    procedure SetURL(const Value: string);
  protected
    function Encode(inxml:String;Key:string):String;
    function Decode(inxml:String;Key:string):String;
  public
    constructor Create;
    destructor Destroy;override;

    function CreateRio:THTTPRIO;

    function CheckNetwork:boolean;
    function coLogin(Account:string;PassWrd:string):TCaLogin;
    function coRegister(Info:TCaTenant):TCaTenant;
    function coGetList(TENANT_ID:string):TCaTenant;

    property SSL:string read FSSL write SetSSL;
    property URL:string read FURL write SetURL;
    
  end;
var CaFactory:TCaFactory;
implementation
uses EncDec,ZLibExGZ,encddecd,CaTenantService,IniFiles;
{ TCaFactory }

function TCaFactory.CheckNetwork: boolean;
begin
  result := false;exit;
  result := InternetCheckConnection(PChar(URL), 1, 0);
end;

function TCaFactory.coGetList(TENANT_ID: string): TCaTenant;
begin
  Result.TENANT_ID := 1000001;
end;

function TCaFactory.coLogin(Account, PassWrd: string): TCaLogin;
var
  inxml:string;
  rio:THTTPRIO;
begin
  result.TENANT_ID := 1000001;
  inxml :=
  '<?xml version="1.0" encoding="utf-8"?> '+
  '<Message> '+
  '  <header> '+
  '    <Pub> '+
  '      <flag>3</flag> '+
  '    </Pub> '+
  '  </header> '+
  '  <body> '+
  '    <CaTenant> '+
  '     <loginName>'+Account+'</loginName> '+
  '     <passwrd>'+PassWrd+'</passwrd>'+
  '    </CaTenant> '+
  '  </body> '+
  '</Message> ';
  rio := CreateRio;
  try
    Decode(GetCaTenantServiceImpl(true,URL,rio).login(Encode(inxml,'SaRi0+jf')),'SaRi0+jf');
  finally
    rio.Free;
  end;
end;

function TCaFactory.coRegister(Info: TCaTenant): TCaTenant;
begin
  result := Info;
  result.TENANT_ID := 1000001;
end;

constructor TCaFactory.Create;
var
  f:TIniFile;
begin
  f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    URL := f.ReadString('CaFactory','url','http://www.rspcn.com/rsp/services/CaTenantService?wsdl'); 
  finally
    f.Free;
  end;
end;

function TCaFactory.CreateRio: THTTPRIO;
begin
  result := THTTPRIO.Create(nil); 
end;

function TCaFactory.Decode(inxml: string;Key:string): string;
var
  gzip:string;
  DecStr:string;
begin
  DecStr := encddecd.DecodeString(inxml);
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
  EncStr := EncryStr(gzip,Key);
  result := encddecd.EncodeString(EncStr);
end;

procedure TCaFactory.SetSSL(const Value: string);
begin
  FSSL := Value;
end;

procedure TCaFactory.SetURL(const Value: string);
begin
  FURL := Value;
end;

initialization
  CaFactory := TCaFactory.Create;
finalization
  CaFactory.Free;
end.
