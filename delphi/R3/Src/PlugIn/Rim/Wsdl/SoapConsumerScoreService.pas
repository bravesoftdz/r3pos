// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://60.213.187.21:9081/rim/services/ConsumerScoreService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2010-8-14 12:02:15 - 1.33.2.5)
// ************************************************************************ //

unit SoapConsumerScoreService;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

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
  // !:IConsumerScoreDomain - "http://60.213.187.21:9081/rim/services/ConsumerScoreService"
  // !:IConsumerScoreTransactionService - "http://60.213.187.21:9081/rim/services/ConsumerScoreService"



  // ************************************************************************ //
  // Namespace : http://60.213.187.21:9081/rim/services/ConsumerScoreService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : ConsumerScoreServiceSoapBinding
  // service   : ConsumerScoreServiceService
  // port      : ConsumerScoreService
  // URL       : http://60.213.187.21:9081/rim/services/ConsumerScoreService
  // ************************************************************************ //
  ConsumerScoreService = interface(IInvokable)
  ['{0FCDD952-3AD7-2D5D-DE7A-34D1DFAC7437}']
    function  consumerScoreDetail(const inXml: WideString): WideString; stdcall;
    function  consumerInfoUpdater(const inXml: WideString): WideString; stdcall;
  end;

function GetConsumerScoreService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ConsumerScoreService;


implementation

function GetConsumerScoreService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ConsumerScoreService;
const
  defWSDL = 'http://60.213.187.21:9081/rim/services/ConsumerScoreService?wsdl';
  defURL  = 'http://60.213.187.21:9081/rim/services/ConsumerScoreService';
  defSvc  = 'ConsumerScoreServiceService';
  defPrt  = 'ConsumerScoreService';
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
    Result := (RIO as ConsumerScoreService);
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
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(ConsumerScoreService), 'http://60.213.187.21:9081/rim/services/ConsumerScoreService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ConsumerScoreService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ConsumerScoreService), ioDocument);

end.