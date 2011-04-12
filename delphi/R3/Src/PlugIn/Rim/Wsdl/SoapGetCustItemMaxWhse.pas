// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Documents and Settings\张森荣\桌面\GetCustItemMaxWhse.xml
// Encoding : UTF-8
// Version  : 1.0
// (2008-9-23 13:33:56 - 1.33.2.5)
// ************************************************************************ //

unit SoapGetCustItemMaxWhse;

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
  // !:ICustItemMaxWhseDomain - "http://10.33.16.250:9081/rim/services/GetCustItemMaxWhse"



  // ************************************************************************ //
  // Namespace : http://10.33.16.250:9081/rim/services/GetCustItemMaxWhse
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : GetCustItemMaxWhseSoapBinding
  // service   : CustItemMaxWhseServiceService
  // port      : GetCustItemMaxWhse
  // URL       : http://10.33.16.250:9081/rim/services/GetCustItemMaxWhse
  // ************************************************************************ //
  CustItemMaxWhseService = interface(IInvokable)
  ['{C7EB882E-DE27-5DBC-7A6A-322B38850E12}']
    function  getCustItemMaxWhse(const inXml: WideString): WideString; stdcall;
    function  getCustItemMaxWhseDomain: Variant; stdcall;
  end;

function GetCustItemMaxWhseService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CustItemMaxWhseService;


implementation

function GetCustItemMaxWhseService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CustItemMaxWhseService;
const
  defWSDL = 'C:\Documents and Settings\张森荣\桌面\GetCustItemMaxWhse.xml';
  defURL  = 'http://10.33.16.250:9081/rim/services/GetCustItemMaxWhse';
  defSvc  = 'CustItemMaxWhseServiceService';
  defPrt  = 'GetCustItemMaxWhse';
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
    Result := (RIO as CustItemMaxWhseService);
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
  InvRegistry.RegisterInterface(TypeInfo(CustItemMaxWhseService), 'http://10.33.16.250:9081/rim/services/GetCustItemMaxWhse', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CustItemMaxWhseService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CustItemMaxWhseService), ioDocument);

end.