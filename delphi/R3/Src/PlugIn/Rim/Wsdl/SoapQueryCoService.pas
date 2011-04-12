// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.33.16.250:9081/rim/services/QueryCoService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-8-22 14:03:28 - 1.33.2.5)
// ************************************************************************ //

unit SoapQueryCoService;

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
  // !:string          - "http://schemas.xmlsoap.org/soap/encoding/"
  // !:anyType         - "http://www.w3.org/2001/XMLSchema"
  // !:IQueryCoServiceDomain - "http://10.33.16.250:9081/rim/services/QueryCoService"


  // ************************************************************************ //
  // Namespace : http://trans.QueryCoService.service.netco.sale.sd.v3.lc.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : QueryCoServiceSoapBinding
  // service   : QueryCoServiceService
  // port      : QueryCoService
  // URL       : http://10.33.16.250:9081/rim/services/QueryCoService
  // ************************************************************************ //
  QueryCoService = interface(IInvokable)
  ['{B77DE6BC-4AED-6BA6-C671-87E3C78FF9B2}']
    function  QueryNetCo(const inXml: WideString): WideString; stdcall;
  //  function  getQuerycoservicedomain: Variant; stdcall;
 //   procedure setQuerycoservicedomain(const querycoservicedomain: IQueryCoServiceDomain); stdcall;
  end;

function GetQueryCoService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): QueryCoService;


implementation

function GetQueryCoService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): QueryCoService;
const
  defWSDL = 'http://10.33.16.250:9081/rim/services/QueryCoService?wsdl';
  defURL  = 'http://10.33.16.250:9081/rim/services/QueryCoService';
  defSvc  = 'QueryCoServiceService';
  defPrt  = 'QueryCoService';
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
    Result := (RIO as QueryCoService);
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
  InvRegistry.RegisterInterface(TypeInfo(QueryCoService), 'http://trans.QueryCoService.service.netco.sale.sd.v3.lc.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(QueryCoService), '');

end.