// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.10.11.232/rsp/services/CaTenantService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2011/2/15 17:24:47 - 1.33.2.5)
// ************************************************************************ //

unit CaTenantService;

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
  // Namespace : http://10.10.11.232/rsp/services/CaTenantService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : CaTenantServiceSoapBinding
  // service   : CaTenantServiceImplService
  // port      : CaTenantService
  // URL       : http://10.10.11.232/rsp/services/CaTenantService
  // ************************************************************************ //
  CaTenantServiceImpl = interface(IInvokable)
  ['{D6B4F84E-FD86-42BE-352A-4FEFCFB94DC6}']
    function  register(const inXml: WideString): WideString; stdcall;
    function  login(const inXml: WideString): WideString; stdcall;
    function  unRegister(const inXml: WideString): WideString; stdcall;
    function  getTenantInfo(const inXml: WideString): WideString; stdcall;
  end;

function GetCaTenantServiceImpl(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CaTenantServiceImpl;


implementation

function GetCaTenantServiceImpl(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CaTenantServiceImpl;
const
  defWSDL = 'http://10.10.11.232/rsp/services/CaTenantService?wsdl';
  defURL  = 'http://10.10.11.232/rsp/services/CaTenantService';
  defSvc  = 'CaTenantServiceImplService';
  defPrt  = 'CaTenantService';
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
    Result := (RIO as CaTenantServiceImpl);
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
  InvRegistry.RegisterInterface(TypeInfo(CaTenantServiceImpl), 'http://10.10.11.232/rsp/services/CaTenantService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CaTenantServiceImpl), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CaTenantServiceImpl), ioDocument);

end. 