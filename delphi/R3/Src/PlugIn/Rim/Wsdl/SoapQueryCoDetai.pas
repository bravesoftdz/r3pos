// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.33.16.250:9081/rim/services/QueryCoDetail?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-8-22 14:04:06 - 1.33.2.5)
// ************************************************************************ //

unit SoapQueryCoDetai;

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
  // !:IQueryCoDetailServiceDomain - "http://10.33.16.250:9081/rim/services/QueryCoDetail"



  // ************************************************************************ //
  // Namespace : http://10.33.16.250:9081/rim/services/QueryCoDetail
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : QueryCoDetailSoapBinding
  // service   : QueryCoDetailServiceService
  // port      : QueryCoDetail
  // URL       : http://10.33.16.250:9081/rim/services/QueryCoDetail
  // ************************************************************************ //
  QueryCoDetailService = interface(IInvokable)
  ['{19BE525F-6079-6AA5-0F03-26FE194EC282}']
    function  QueryCoDetail(const inXml: WideString): WideString; stdcall;
  //  function  getQuerycodetailservicedomain: Variant; stdcall;
  //  procedure setQuerycodetailservicedomain(const rimquerycodetailservicedomain: IQueryCoDetailServiceDomain); stdcall;
  end;

function GetQueryCoDetailService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): QueryCoDetailService;


implementation

function GetQueryCoDetailService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): QueryCoDetailService;
const
  defWSDL = 'http://10.33.16.250:9081/rim/services/QueryCoDetail?wsdl';
  defURL  = 'http://10.33.16.250:9081/rim/services/QueryCoDetail';
  defSvc  = 'QueryCoDetailServiceService';
  defPrt  = 'QueryCoDetail';
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
    Result := (RIO as QueryCoDetailService);
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
  InvRegistry.RegisterInterface(TypeInfo(QueryCoDetailService), 'http://10.33.16.250:9081/rim/services/QueryCoDetail', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(QueryCoDetailService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(QueryCoDetailService), ioDocument);

end.