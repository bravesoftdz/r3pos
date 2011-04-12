// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Documents and Settings\张森荣\桌面\投诉建议wsdl\RimSuggestionService.xml
// Encoding : UTF-8
// Version  : 1.0
// (2009-1-5 18:55:00 - 1.33.2.5)
// ************************************************************************ //

unit SoapRimSuggestionService;

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



  // ************************************************************************ //
  // Namespace : http://10.33.27.30:9088/rim/services/RimSuggestionService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : RimSuggestionServiceSoapBinding
  // service   : RimSuggestionServiceService
  // port      : RimSuggestionService
  // URL       : http://10.33.27.30:9088/rim/services/RimSuggestionService
  // ************************************************************************ //
  RimSuggestionService = interface(IInvokable)
  ['{D49E7A84-9BF1-23AA-907C-C9BAA190AE8A}']
    function  AddSuggestion(const inXml: WideString): WideString; stdcall;
    function  QuerySuggestion(const inXml: WideString): WideString; stdcall;
    function  DetailSuggestion(const inXml: WideString): WideString; stdcall;
    function  DeleteSuggestion(const inXml: WideString): WideString; stdcall;
  end;

function GetRimSuggestionService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): RimSuggestionService;


implementation

function GetRimSuggestionService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): RimSuggestionService;
const
  defWSDL = 'C:\Documents and Settings\张森荣\桌面\投诉建议wsdl\RimSuggestionService.xml';
  defURL  = 'http://10.33.27.30:9088/rim/services/RimSuggestionService';
  defSvc  = 'RimSuggestionServiceService';
  defPrt  = 'RimSuggestionService';
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
    Result := (RIO as RimSuggestionService);
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
  InvRegistry.RegisterInterface(TypeInfo(RimSuggestionService), 'http://10.33.27.30:9088/rim/services/RimSuggestionService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RimSuggestionService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RimSuggestionService), ioDocument);

end.