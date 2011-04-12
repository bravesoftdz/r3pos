// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Documents and Settings\张森荣\My Documents\My QQ Files\QueryCustBankAccService.wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2009-8-14 9:58:16 - 1.33.2.5)
// ************************************************************************ //

unit SoapQueryCustBankAccService;

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



  // ************************************************************************ //
  // Namespace : http://10.160.11.2:9080/rimjl/services/QueryCustBankAccService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : QueryCustBankAccServiceSoapBinding
  // service   : QueryCustBankAccServiceService
  // port      : QueryCustBankAccService
  // URL       : http://10.160.11.2:9080/rimjl/services/QueryCustBankAccService
  // ************************************************************************ //
  QueryCustBankAccService = interface(IInvokable)
  ['{509042BA-56E3-F524-C6FA-6CF56F4B37B5}']
    function  QueryCustBankAccByCustId(const inXml: WideString): WideString; stdcall;
  end;

function GetQueryCustBankAccService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): QueryCustBankAccService;


implementation

function GetQueryCustBankAccService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): QueryCustBankAccService;
const
  defWSDL = 'C:\Documents and Settings\张森荣\My Documents\My QQ Files\QueryCustBankAccService.wsdl';
  defURL  = 'http://10.160.11.2:9080/rimjl/services/QueryCustBankAccService';
  defSvc  = 'QueryCustBankAccServiceService';
  defPrt  = 'QueryCustBankAccService';
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
    Result := (RIO as QueryCustBankAccService);
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
  InvRegistry.RegisterInterface(TypeInfo(QueryCustBankAccService), 'http://10.160.11.2:9080/rimjl/services/QueryCustBankAccService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(QueryCustBankAccService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(QueryCustBankAccService), ioDocument);

end.