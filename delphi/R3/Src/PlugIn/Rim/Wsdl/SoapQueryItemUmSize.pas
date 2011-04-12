// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.33.16.250:9081/rim/services/QueryItemUmSize?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-8-24 18:57:36 - 1.33.2.5)
// ************************************************************************ //

unit SoapQueryItemUmSize;

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
  // !:IQueryItemUmSizeDomain - "http://10.33.16.250:9081/rim/services/QueryItemUmSize"



  // ************************************************************************ //
  // Namespace : http://10.33.16.250:9081/rim/services/QueryItemUmSize
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : QueryItemUmSizeSoapBinding
  // service   : QueryItemUmSizeServiceService
  // port      : QueryItemUmSize
  // URL       : http://10.33.16.250:9081/rim/services/QueryItemUmSize
  // ************************************************************************ //
  QueryItemUmSizeService = interface(IInvokable)
  ['{A368EB2E-4460-DDAB-12B4-207C511D7AAA}']
    function  getItemUmSize(const inXml: WideString): WideString; stdcall;
    //function  getQueryItemUmSizeDomain: Variant; stdcall;
   // procedure setQueryItemUmSizeDomain(const queryItemUmSizeDomain: IQueryItemUmSizeDomain); stdcall;
  end;

function GetQueryItemUmSizeService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): QueryItemUmSizeService;


implementation

function GetQueryItemUmSizeService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): QueryItemUmSizeService;
const
  defWSDL = 'http://10.33.16.250:9081/rim/services/QueryItemUmSize?wsdl';
  defURL  = 'http://10.33.16.250:9081/rim/services/QueryItemUmSize';
  defSvc  = 'QueryItemUmSizeServiceService';
  defPrt  = 'QueryItemUmSize';
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
    Result := (RIO as QueryItemUmSizeService);
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
  InvRegistry.RegisterInterface(TypeInfo(QueryItemUmSizeService), 'http://10.33.16.250:9081/rim/services/QueryItemUmSize', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(QueryItemUmSizeService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(QueryItemUmSizeService), ioDocument);

end.