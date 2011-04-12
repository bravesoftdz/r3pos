// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Documents and Settings\张森荣\My Documents\My QQ Files\CoSimulatorService.xml
// Encoding : UTF-8
// Version  : 1.0
// (2009-8-14 9:59:12 - 1.33.2.5)
// ************************************************************************ //

unit SoapCoSimulatorService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns, SysUtils;

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


  ArrayOf_xsd_anyType = array of Variant;       { "http://10.160.11.2:9080/rimjl/services/CoSimulatorService" }

  // ************************************************************************ //
  // Namespace : http://10.160.11.2:9080/rimjl/services/CoSimulatorService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : CoSimulatorServiceSoapBinding
  // service   : CoSimulatorServiceService
  // port      : CoSimulatorService
  // URL       : http://10.160.11.2:9080/rimjl/services/CoSimulatorService
  // ************************************************************************ //
  CoSimulatorService = interface(IInvokable)
  ['{B5C741AD-7266-23F6-9D95-3F02E47BAAA7}']
    function  QueryCoByCustId(const inXml: WideString): WideString; stdcall;
    function  getItemsByCustId(const custId: WideString; const comId: WideString): ArrayOf_xsd_anyType; stdcall;
    function  getRimRepleteCoService: Variant; stdcall;
    function  getRimItemSatisfyService: Variant; stdcall;
  end;

function GetCoSimulatorService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CoSimulatorService;


implementation

function GetCoSimulatorService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CoSimulatorService;
const
  defWSDL = 'C:\Documents and Settings\张森荣\My Documents\My QQ Files\CoSimulatorService.xml';
  defURL  = 'http://10.160.11.2:9080/rimjl/services/CoSimulatorService';
  defSvc  = 'CoSimulatorServiceService';
  defPrt  = 'CoSimulatorService';
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
    Result := (RIO as CoSimulatorService);
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


initialization
  InvRegistry.RegisterInterface(TypeInfo(CoSimulatorService), 'http://10.160.11.2:9080/rimjl/services/CoSimulatorService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CoSimulatorService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CoSimulatorService), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_xsd_anyType), 'http://10.160.11.2:9080/rimjl/services/CoSimulatorService', 'ArrayOf_xsd_anyType');

end.