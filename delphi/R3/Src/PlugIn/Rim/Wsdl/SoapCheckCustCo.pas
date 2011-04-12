// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.33.16.250:9081/rim/services/CheckCustCo?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-8-22 14:02:48 - 1.33.2.5)
// ************************************************************************ //

unit SoapCheckCustCo;

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
  // !:IRimCustCoQueryDomain - "http://10.33.16.250:9081/rim/services/CheckCustCo"



  // ************************************************************************ //
  // Namespace : http://10.33.16.250:9081/rim/services/CheckCustCo
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : CheckCustCoSoapBinding
  // service   : RimCustCoQueryServiceService
  // port      : CheckCustCo
  // URL       : http://10.33.16.250:9081/rim/services/CheckCustCo
  // ************************************************************************ //
  RimCustCoQueryService = interface(IInvokable)
  ['{AFA3FF4B-E9B2-CD26-C547-C825A247B606}']
    function  getRimCustCo(const inXml: WideString): WideString; stdcall;
   // function  getRimCustCoQueryDomain: Variant; stdcall;
   // procedure setRimCustCoQueryDomain(const rimCustCoQueryDomain: IRimCustCoQueryDomain); stdcall;
  end;

function GetRimCustCoQueryService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): RimCustCoQueryService;


implementation

function GetRimCustCoQueryService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): RimCustCoQueryService;
const
  defWSDL = 'http://10.33.16.250:9081/rim/services/CheckCustCo?wsdl';
  defURL  = 'http://10.33.16.250:9081/rim/services/CheckCustCo';
  defSvc  = 'RimCustCoQueryServiceService';
  defPrt  = 'CheckCustCo';
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
    Result := (RIO as RimCustCoQueryService);
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
  InvRegistry.RegisterInterface(TypeInfo(RimCustCoQueryService), 'http://10.33.16.250:9081/rim/services/CheckCustCo', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RimCustCoQueryService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RimCustCoQueryService), ioDocument);

end.