// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : C:\Documents and Settings\张森荣\桌面\Investigate.xml
// Encoding : UTF-8
// Version  : 1.0
// (2008-10-31 16:31:52 - 1.33.2.5)
// ************************************************************************ //

unit SoapInvestigate;

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
  // !:IInvestigateDomain - "http://10.33.27.9:9088/rim/services/Investigate"
  // !:Element         - "http://jdom.org"


  ArrayOf_xsd_anyType = array of Variant;       { "http://10.33.27.9:9088/rim/services/Investigate" }

  // ************************************************************************ //
  // Namespace : http://10.33.27.9:9088/rim/services/Investigate
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : InvestigateSoapBinding
  // service   : InvestigateServiceService
  // port      : Investigate
  // URL       : http://10.33.27.9:9088/rim/services/Investigate
  // ************************************************************************ //
  InvestigateService = interface(IInvokable)
  ['{397F1F58-37FC-A384-3170-2F44694B85DD}']
    function  getInvestigate(const inXml: WideString): WideString; stdcall;
    //function  getInvestigateDomain: Variant; stdcall;
    //procedure setInvestigateDomain(const investigateDomain: IInvestigateDomain); stdcall;
    function  getVolume(const inXml: WideString): WideString; stdcall;
    function  saveVolume(const inXml: WideString): WideString; stdcall;
    //function  getAttr(const ele: Variant; const subject_id: WideString): ArrayOf_xsd_anyType; stdcall;
    //function  getNodes(const father: Element): ArrayOf_xsd_anyType; stdcall;
  end;

function GetInvestigateService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): InvestigateService;


implementation

function GetInvestigateService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): InvestigateService;
const
  defWSDL = 'C:\Documents and Settings\张森荣\桌面\Investigate.xml';
  defURL  = 'http://10.33.27.9:9088/rim/services/Investigate';
  defSvc  = 'InvestigateServiceService';
  defPrt  = 'Investigate';
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
    Result := (RIO as InvestigateService);
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
  InvRegistry.RegisterInterface(TypeInfo(InvestigateService), 'http://10.33.27.9:9088/rim/services/Investigate', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(InvestigateService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(InvestigateService), ioDocument);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_xsd_anyType), 'http://10.33.27.9:9088/rim/services/Investigate', 'ArrayOf_xsd_anyType');

end.