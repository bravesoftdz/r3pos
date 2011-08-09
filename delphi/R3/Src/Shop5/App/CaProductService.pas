// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://jerry/rsp/services/CaProductService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2011/3/26 21:36:45 - 1.33.2.5)
// ************************************************************************ //

unit CaProductService;

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

  Pub                  = class;                 { "http://xml.soa.modules.rsp.rspcn.com" }
  MessageException     = class;                 { "http://xml.soa.modules.rsp.rspcn.com" }



  // ************************************************************************ //
  // Namespace : http://xml.soa.modules.rsp.rspcn.com
  // ************************************************************************ //
  Pub = class(TRemotable)
  private
    FtimeStamp: WideString;
    Fvss: WideString;
    Fflag: WideString;
    Fmsg: WideString;
    FrecAck: WideString;
  published
    property timeStamp: WideString read FtimeStamp write FtimeStamp;
    property vss: WideString read Fvss write Fvss;
    property flag: WideString read Fflag write Fflag;
    property msg: WideString read Fmsg write Fmsg;
    property recAck: WideString read FrecAck write FrecAck;
  end;



  // ************************************************************************ //
  // Namespace : http://xml.soa.modules.rsp.rspcn.com
  // ************************************************************************ //
  MessageException = class(TRemotable)
  private
    Fmessage: WideString;
    Fpub: Pub;
  public
    destructor Destroy; override;
  published
    property message: WideString read Fmessage write Fmessage;
    property pub: Pub read Fpub write Fpub;
  end;

  fault           = MessageException;      { "http://jerry/rsp/services/CaProductService"[F] }

  // ************************************************************************ //
  // Namespace : http://jerry/rsp/services/CaProductService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : CaProductServiceSoapBinding
  // service   : CaProductWebServiceImplService
  // port      : CaProductService
  // URL       : http://jerry/rsp/services/CaProductService
  // ************************************************************************ //
  CaProductWebServiceImpl = interface(IInvokable)
  ['{53086D7B-8250-CCF2-1195-57EA9B5C9244}']
    function  listModules(const inXml: WideString): WideString; stdcall;
    function  checkUpgrade(const inXml: WideString): WideString; stdcall;
  end;

function GetCaProductWebServiceImpl(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CaProductWebServiceImpl;


implementation
function GetCaProductWebServiceImpl(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CaProductWebServiceImpl;
const
  defWSDL = 'http://jerry/rsp/services/CaProductService?wsdl';
  defURL  = 'http://jerry/rsp/services/CaProductService';
  defSvc  = 'CaProductWebServiceImplService';
  defPrt  = 'CaProductService';
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
    Result := (RIO as CaProductWebServiceImpl);
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
  if result=nil then Raise Exception.Create('无法访问CaProductWebService服务');
end;


destructor MessageException.Destroy;
begin
  if Assigned(Fpub) then
    Fpub.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(CaProductWebServiceImpl), 'http://jerry/rsp/services/CaProductService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CaProductWebServiceImpl), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CaProductWebServiceImpl), ioDocument);
  RemClassRegistry.RegisterXSClass(Pub, 'http://xml.soa.modules.rsp.rspcn.com', 'Pub');
  RemClassRegistry.RegisterXSClass(MessageException, 'http://xml.soa.modules.rsp.rspcn.com', 'MessageException');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fault), 'http://jerry/rsp/services/CaProductService', 'fault');

end. 