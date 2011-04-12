// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.33.16.250:9081/rim/services/QueryItemInfoService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-8-22 14:02:10 - 1.33.2.5)
// ************************************************************************ //

unit SoapQueryItemInfoService;

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
  // !:IQueryItemInfoServiceDomain - "http://10.33.16.250:9081/rim/services/QueryItemInfoService"


  // ************************************************************************ //
  // Namespace : http://trans.QueryItemInfoService.service.netco.sale.sd.v3.lc.com
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : QueryItemInfoServiceSoapBinding
  // service   : QueryItemInfoServiceService
  // port      : QueryItemInfoService
  // URL       : http://10.33.16.250:9081/rim/services/QueryItemInfoService
  // ************************************************************************ //
  QueryItemInfoService = interface(IInvokable)
  ['{ED4875DF-880F-3401-C72E-D5C06639EE65}']
    function  QueryItemInfoByCustId(const inXml: WideString): WideString; stdcall;
  //  function  getQueryiteminfodomain: Variant; stdcall;
  //  procedure setQueryiteminfodomain(const queryiteminfodomain: IQueryItemInfoServiceDomain); stdcall;
  end;

function GetQueryItemInfoService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): QueryItemInfoService;


implementation

function GetQueryItemInfoService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): QueryItemInfoService;
const
  defWSDL = 'http://10.33.16.250:9081/rim/services/QueryItemInfoService?wsdl';
  defURL  = 'http://10.33.16.250:9081/rim/services/QueryItemInfoService';
  defSvc  = 'QueryItemInfoServiceService';
  defPrt  = 'QueryItemInfoService';
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
    Result := (RIO as QueryItemInfoService);
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
  InvRegistry.RegisterInterface(TypeInfo(QueryItemInfoService), 'http://trans.QueryItemInfoService.service.netco.sale.sd.v3.lc.com', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(QueryItemInfoService), '');

end.