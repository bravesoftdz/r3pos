// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.33.16.250:9081/rim/services/insertRetailCo?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-8-30 15:46:23 - 1.33.2.5)
// ************************************************************************ //

unit SoapinsertRetailCo;

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
  // !:IInsertRetailCoDomain - "http://10.33.16.250:9081/rim/services/insertRetailCo"

  getInsertRetailCoDomain = class;              { "http://trans.InsertRetailCo.service.rim.v3.lc.com" }
  setInitCustWhseDomainResponse = class;        { "http://trans.InsertRetailCo.service.rim.v3.lc.com" }
  XmlToList            = class;                 { "http://trans.InsertRetailCo.service.rim.v3.lc.com" }
  insertRetailCoResponse = class;               { "http://trans.InsertRetailCo.service.rim.v3.lc.com" }
  insertRetailCo       = class;                 { "http://trans.InsertRetailCo.service.rim.v3.lc.com" }
  getInsertRetailCoDomainResponse = class;      { "http://trans.InsertRetailCo.service.rim.v3.lc.com" }
  setInitCustWhseDomain = class;                { "http://trans.InsertRetailCo.service.rim.v3.lc.com" }
  XmlToListResponse    = class;                 { "http://trans.InsertRetailCo.service.rim.v3.lc.com"[A] }



  // ************************************************************************ //
  // Namespace : http://trans.InsertRetailCo.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getInsertRetailCoDomain = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InsertRetailCo.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  setInitCustWhseDomainResponse = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InsertRetailCo.service.rim.v3.lc.com
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
  // Namespace : http://trans.InsertRetailCo.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  insertRetailCoResponse = class(TRemotable)
  private
    FinsertRetailCoReturn: WideString;
  public
    constructor Create; override;
  published
    property insertRetailCoReturn: WideString read FinsertRetailCoReturn write FinsertRetailCoReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InsertRetailCo.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  insertRetailCo = class(TRemotable)
  private
    FinXml: WideString;
  public
    constructor Create; override;
  published
    property inXml: WideString read FinXml write FinXml;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InsertRetailCo.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getInsertRetailCoDomainResponse = class(TRemotable)
  private
    FgetInsertRetailCoDomainReturn: Variant;
  public
    constructor Create; override;
  published
    property getInsertRetailCoDomainReturn: Variant read FgetInsertRetailCoDomainReturn write FgetInsertRetailCoDomainReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.InsertRetailCo.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  setInitCustWhseDomain = class(TRemotable)
  private
  //  FinsertRetailCoDomain: IInsertRetailCoDomain;
  public
    constructor Create; override;
  published
  //  property insertRetailCoDomain: IInsertRetailCoDomain read FinsertRetailCoDomain write FinsertRetailCoDomain;
  end;

  ArrayOf_xsd_anyType = array of Variant;       { "http://10.33.16.250:9081/rim/services/insertRetailCo" }
  XmlToListReturn = array of ArrayOf_xsd_anyType;   { "http://trans.InsertRetailCo.service.rim.v3.lc.com" }


  // ************************************************************************ //
  // Namespace : http://trans.InsertRetailCo.service.rim.v3.lc.com
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
  // Namespace : http://10.33.16.250:9081/rim/services/insertRetailCo
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : insertRetailCoSoapBinding
  // service   : InsertRetailCoServiceService
  // port      : insertRetailCo
  // URL       : http://10.33.16.250:9081/rim/services/insertRetailCo
  // ************************************************************************ //
  InsertRetailCoService = interface(IInvokable)
  ['{45DCDCB9-ACD0-3B2F-030A-F5BC06E43B6C}']
    function  insertRetailCo(const parameters: insertRetailCo): insertRetailCoResponse; stdcall;
    function  getInsertRetailCoDomain(const parameters: getInsertRetailCoDomain): getInsertRetailCoDomainResponse; stdcall;
    function  setInitCustWhseDomain(const parameters: setInitCustWhseDomain): setInitCustWhseDomainResponse; stdcall;
    function  XmlToList(const parameters: XmlToList): XmlToListResponse; stdcall;
  end;

function GetInsertRetailCoService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): InsertRetailCoService;


implementation

function GetInsertRetailCoService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): InsertRetailCoService;
const
  defWSDL = 'http://10.33.16.250:9081/rim/services/insertRetailCo?wsdl';
  defURL  = 'http://10.33.16.250:9081/rim/services/insertRetailCo';
  defSvc  = 'InsertRetailCoServiceService';
  defPrt  = 'insertRetailCo';
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
    Result := (RIO as InsertRetailCoService);
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


constructor getInsertRetailCoDomain.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor setInitCustWhseDomainResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor XmlToList.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor insertRetailCoResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor insertRetailCo.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getInsertRetailCoDomainResponse.Create;
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
  InvRegistry.RegisterInterface(TypeInfo(InsertRetailCoService), 'http://10.33.16.250:9081/rim/services/insertRetailCo', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(InsertRetailCoService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(InsertRetailCoService), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(InsertRetailCoService), ioLiteral);
  RemClassRegistry.RegisterXSClass(getInsertRetailCoDomain, 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'getInsertRetailCoDomain');
  RemClassRegistry.RegisterSerializeOptions(getInsertRetailCoDomain, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(setInitCustWhseDomainResponse, 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'setInitCustWhseDomainResponse');
  RemClassRegistry.RegisterSerializeOptions(setInitCustWhseDomainResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(XmlToList, 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'XmlToList');
  RemClassRegistry.RegisterSerializeOptions(XmlToList, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(insertRetailCoResponse, 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'insertRetailCoResponse');
  RemClassRegistry.RegisterSerializeOptions(insertRetailCoResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(insertRetailCo, 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'insertRetailCo');
  RemClassRegistry.RegisterSerializeOptions(insertRetailCo, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getInsertRetailCoDomainResponse, 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'getInsertRetailCoDomainResponse');
  RemClassRegistry.RegisterSerializeOptions(getInsertRetailCoDomainResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(setInitCustWhseDomain, 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'setInitCustWhseDomain');
  RemClassRegistry.RegisterSerializeOptions(setInitCustWhseDomain, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_xsd_anyType), 'http://10.33.16.250:9081/rim/services/insertRetailCo', 'ArrayOf_xsd_anyType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(XmlToListReturn), 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'XmlToListReturn');
  RemClassRegistry.RegisterXSClass(XmlToListResponse, 'http://trans.InsertRetailCo.service.rim.v3.lc.com', 'XmlToListResponse');
  RemClassRegistry.RegisterSerializeOptions(XmlToListResponse, [xoInlineArrays,xoLiteralParam]);

end. 