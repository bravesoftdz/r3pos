// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.160.11.3:9081/rim/services/GetMessage?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-9-12 14:41:05 - 1.33.2.5)
// ************************************************************************ //

unit SoapGetMessage;

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
  // !:IMessageDomain  - "http://10.160.11.3:9081/rim/services/GetMessage"



  // ************************************************************************ //
  // Namespace : http://10.160.11.3:9081/rim/services/GetMessage
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : GetMessageSoapBinding
  // service   : MessageServiceService
  // port      : GetMessage
  // URL       : http://10.160.11.3:9081/rim/services/GetMessage
  // ************************************************************************ //
  MessageService = interface(IInvokable)
  ['{B67124BD-80AC-F815-1FC8-3C547D82B847}']
    function  getMessage(const inXml: WideString): WideString; stdcall;
    function  getMessageDomain: Variant; stdcall;
//    procedure setMessageDomain(const messageDomain: IMessageDomain); stdcall;
  end;

function GetMessageService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): MessageService;


implementation

function GetMessageService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): MessageService;
const
  defWSDL = 'http://10.160.11.3:9081/rim/services/GetMessage?wsdl';
  defURL  = 'http://10.160.11.3:9081/rim/services/GetMessage';
  defSvc  = 'MessageServiceService';
  defPrt  = 'GetMessage';
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
    Result := (RIO as MessageService);
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
  InvRegistry.RegisterInterface(TypeInfo(MessageService), 'http://10.160.11.3:9081/rim/services/GetMessage', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(MessageService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(MessageService), ioDocument);

end. 