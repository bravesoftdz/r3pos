// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Documents and Settings\张森荣\桌面\投诉建议wsdl\RimImpeachService.xml
// Encoding : UTF-8
// Version  : 1.0
// (2009-1-5 18:57:36 - 1.33.2.5)
// ************************************************************************ //

unit SoapRimImpeachService;

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
  // Namespace : http://10.33.27.30:9088/rim/services/RimImpeachService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : RimImpeachServiceSoapBinding
  // service   : RimImpeachServiceService
  // port      : RimImpeachService
  // URL       : http://10.33.27.30:9088/rim/services/RimImpeachService
  // ************************************************************************ //
  RimImpeachService = interface(IInvokable)
  ['{ADC9C1FC-3304-272C-6B22-3DA0A6FE98D0}']
    function  AddImpeach(const inXml: WideString): WideString; stdcall;
    function  QueryImpeach(const inXml: WideString): WideString; stdcall;
    function  DetailImpeach(const inXml: WideString): WideString; stdcall;
    function  DeleteImpeach(const inXml: WideString): WideString; stdcall;
  end;

function GetRimImpeachService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): RimImpeachService;


implementation

function GetRimImpeachService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): RimImpeachService;
const
  defWSDL = 'C:\Documents and Settings\张森荣\桌面\投诉建议wsdl\RimImpeachService.xml';
  defURL  = 'http://10.33.27.30:9088/rim/services/RimImpeachService';
  defSvc  = 'RimImpeachServiceService';
  defPrt  = 'RimImpeachService';
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
    Result := (RIO as RimImpeachService);
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
  InvRegistry.RegisterInterface(TypeInfo(RimImpeachService), 'http://10.33.27.30:9088/rim/services/RimImpeachService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RimImpeachService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RimImpeachService), ioDocument);

end.