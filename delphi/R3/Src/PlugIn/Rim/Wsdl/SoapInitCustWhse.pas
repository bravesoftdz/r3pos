// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.33.16.250:9081/rim/services/InitCustWhse?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-8-30 15:48:22 - 1.33.2.5)
// ************************************************************************ //

unit SoapInitCustWhse;

interface

uses SysUtils,InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Borland types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"
  // !:anyType         - "http://www.w3.org/2001/XMLSchema"
  // !:IInitCustWhseDomain - "http://10.33.16.250:9081/rim/services/InitCustWhse"

  getInitCustWhseDomain = class;                { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  setInitCustWhseDomainResponse = class;        { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  updateCustWhseResponse = class;               { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  updateCustWhse       = class;                 { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  XmlToList            = class;                 { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  initCustWhseResponse = class;                 { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  initCustWhse         = class;                 { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  getInitCustWhseDomainResponse = class;        { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  setInitCustWhseDomain = class;                { "http://trans.InitCustWhse.service.rim.v3.lc.com" }
  XmlToListResponse    = class;                 { "http://trans.InitCustWhse.service.rim.v3.lc.com"[A] }



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getInitCustWhseDomain = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  setInitCustWhseDomainResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  updateCustWhseResponse = class(TRemotable)
  private
    FupdateCustWhseReturn: WideString;
  public
    constructor Create; override;
  published
    property updateCustWhseReturn: WideString read FupdateCustWhseReturn write FupdateCustWhseReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  updateCustWhse = class(TRemotable)
  private
    FinXml: WideString;
  public
    constructor Create; override;
  published
    property inXml: WideString read FinXml write FinXml;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  XmlToList = class(TRemotable)
  private
    Finxml: WideString;
  public
    constructor Create; override;
  published
    property inxml: WideString read Finxml write Finxml;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  initCustWhseResponse = class(TRemotable)
  private
    FinitCustWhseReturn: WideString;
  public
    constructor Create; override;
  published
    property initCustWhseReturn: WideString read FinitCustWhseReturn write FinitCustWhseReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  initCustWhse = class(TRemotable)
  private
    FinXml: WideString;
  public
    constructor Create; override;
  published
    property inXml: WideString read FinXml write FinXml;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getInitCustWhseDomainResponse = class(TRemotable)
  private
    FgetInitCustWhseDomainReturn: Variant;
  public
    constructor Create; override;
  published
    property getInitCustWhseDomainReturn: Variant read FgetInitCustWhseDomainReturn write FgetInitCustWhseDomainReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  setInitCustWhseDomain = class(TRemotable)
  private
  //  FinitCustWhseDomain: IInitCustWhseDomain;
  public
    constructor Create; override;
  published
  //  property initCustWhseDomain: IInitCustWhseDomain read FinitCustWhseDomain write FinitCustWhseDomain;
  end;

  ArrayOf_xsd_anyType = array of Variant;       { "http://10.33.16.250:9081/rim/services/InitCustWhse" }
  XmlToListReturn = array of ArrayOf_xsd_anyType;   { "http://trans.InitCustWhse.service.rim.v3.lc.com" }


  // ************************************************************************ //
  // Namespace : http://trans.InitCustWhse.service.rim.v3.lc.com
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  XmlToListResponse = class(TRemotable)
  private
    FXmlToListReturn: XmlToListReturn;
  public
    constructor Create; override;
    function   GetArrayOf_xsd_anyTypeArray(Index: Integer): ArrayOf_xsd_anyType;
    function   GetArrayOf_xsd_anyTypeArrayLength: Integer;
    property   ArrayOf_xsd_anyTypeArray[Index: Integer]: ArrayOf_xsd_anyType read GetArrayOf_xsd_anyTypeArray; default;
    property   Len: Integer read GetArrayOf_xsd_anyTypeArrayLength;
  published
    property XmlToListReturn: XmlToListReturn read FXmlToListReturn write FXmlToListReturn;
  end;


  // ************************************************************************ //
  // Namespace : http://10.33.16.250:9081/rim/services/InitCustWhse
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : InitCustWhseSoapBinding
  // service   : InitCustWhseServiceService
  // port      : InitCustWhse
  // URL       : http://10.33.16.250:9081/rim/services/InitCustWhse
  // ************************************************************************ //
  InitCustWhseService = interface(IInvokable)
  ['{E52B6874-C789-2B37-7B4F-5E2A9361C6A2}']
    function  initCustWhse(const parameters: initCustWhse): initCustWhseResponse; stdcall;
    function  getInitCustWhseDomain(const parameters: getInitCustWhseDomain): getInitCustWhseDomainResponse; stdcall;
    function  setInitCustWhseDomain(const parameters: setInitCustWhseDomain): setInitCustWhseDomainResponse; stdcall;
    function  XmlToList(const parameters: XmlToList): XmlToListResponse; stdcall;
    function  updateCustWhse(const parameters: updateCustWhse): updateCustWhseResponse; stdcall;
  end;

function GetInitCustWhseService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): InitCustWhseService;


implementation

function GetInitCustWhseService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): InitCustWhseService;
const
  defWSDL = 'http://10.33.16.250:9081/rim/services/InitCustWhse?wsdl';
  defURL  = 'http://10.33.16.250:9081/rim/services/InitCustWhse';
  defSvc  = 'InitCustWhseServiceService';
  defPrt  = 'InitCustWhse';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as InitCustWhseService);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
  if Result=nil then Raise Exception.Create('读取远程服务端失败'+Addr);
end;


constructor getInitCustWhseDomain.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor setInitCustWhseDomainResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor updateCustWhseResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor updateCustWhse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor XmlToList.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor initCustWhseResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor initCustWhse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getInitCustWhseDomainResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor setInitCustWhseDomain.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor XmlToListResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

function XmlToListResponse.GetArrayOf_xsd_anyTypeArray(Index: Integer): ArrayOf_xsd_anyType;
begin
  Result := FXmlToListReturn[Index];
end;

function XmlToListResponse.GetArrayOf_xsd_anyTypeArrayLength: Integer;
begin
  if Assigned(FXmlToListReturn) then
    Result := Length(FXmlToListReturn)
  else
  Result := 0;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(InitCustWhseService), 'http://10.33.16.250:9081/rim/services/InitCustWhse', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(InitCustWhseService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(InitCustWhseService), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(InitCustWhseService), ioLiteral);
  RemClassRegistry.RegisterXSClass(getInitCustWhseDomain, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'getInitCustWhseDomain');
  RemClassRegistry.RegisterSerializeOptions(getInitCustWhseDomain, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(setInitCustWhseDomainResponse, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'setInitCustWhseDomainResponse');
  RemClassRegistry.RegisterSerializeOptions(setInitCustWhseDomainResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(updateCustWhseResponse, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'updateCustWhseResponse');
  RemClassRegistry.RegisterSerializeOptions(updateCustWhseResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(updateCustWhse, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'updateCustWhse');
  RemClassRegistry.RegisterSerializeOptions(updateCustWhse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(XmlToList, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'XmlToList');
  RemClassRegistry.RegisterSerializeOptions(XmlToList, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(initCustWhseResponse, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'initCustWhseResponse');
  RemClassRegistry.RegisterSerializeOptions(initCustWhseResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(initCustWhse, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'initCustWhse');
  RemClassRegistry.RegisterSerializeOptions(initCustWhse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getInitCustWhseDomainResponse, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'getInitCustWhseDomainResponse');
  RemClassRegistry.RegisterSerializeOptions(getInitCustWhseDomainResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(setInitCustWhseDomain, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'setInitCustWhseDomain');
  RemClassRegistry.RegisterSerializeOptions(setInitCustWhseDomain, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_xsd_anyType), 'http://10.33.16.250:9081/rim/services/InitCustWhse', 'ArrayOf_xsd_anyType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(XmlToListReturn), 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'XmlToListReturn');
  RemClassRegistry.RegisterXSClass(XmlToListResponse, 'http://trans.InitCustWhse.service.rim.v3.lc.com', 'XmlToListResponse');
  RemClassRegistry.RegisterSerializeOptions(XmlToListResponse, [xoInlineArrays,xoLiteralParam]);

end. 