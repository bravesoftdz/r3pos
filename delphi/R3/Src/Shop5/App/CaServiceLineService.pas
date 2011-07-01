// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://jerry/rsp/services/CaServiceLineService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2011/3/28 21:18:08 - 1.33.2.5)
// ************************************************************************ //

unit CaServiceLineService;

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

  fault           = MessageException;      { "http://jerry/rsp/services/CaServiceLineService"[F] }

  // ************************************************************************ //
  // Namespace : http://jerry/rsp/services/CaServiceLineService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : CaServiceLineServiceSoapBinding
  // service   : CaServiceLineWebServiceImplService
  // port      : CaServiceLineService
  // URL       : http://jerry/rsp/services/CaServiceLineService
  // ************************************************************************ //
  CaServiceLineWebServiceImpl = interface(IInvokable)
  ['{EEB8CA73-1F78-B749-88EC-B3422A286DE8}']
    function  createServiceLine(const inXml: WideString): WideString; stdcall;
    function  queryServiceLines(const inXml: WideString): WideString; stdcall;
    function  applyRelation(const inXml: WideString): WideString; stdcall;
    function  changeRelationType(const inXml: WideString): WideString; stdcall;
    function  auditRelation(const inXml: WideString): WideString; stdcall;
  end;

function GetCaServiceLineWebServiceImpl(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): CaServiceLineWebServiceImpl;


implementation

function GetCaServiceLineWebServiceImpl(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CaServiceLineWebServiceImpl;
const
  defWSDL = 'http://jerry/rsp/services/CaServiceLineService?wsdl';
  defURL  = 'http://jerry/rsp/services/CaServiceLineService';
  defSvc  = 'CaServiceLineWebServiceImplService';
  defPrt  = 'CaServiceLineService';
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
    Result := (RIO as CaServiceLineWebServiceImpl);
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
    if result=nil then Raise Exception.Create('无法访问CaServiceLineWebService服务,url='+addr);
  end;
end;


destructor MessageException.Destroy;
begin
  if Assigned(Fpub) then
    Fpub.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(CaServiceLineWebServiceImpl), 'http://jerry/rsp/services/CaServiceLineService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CaServiceLineWebServiceImpl), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(CaServiceLineWebServiceImpl), ioDocument);
  RemClassRegistry.RegisterXSClass(Pub, 'http://xml.soa.modules.rsp.rspcn.com', 'Pub');
  RemClassRegistry.RegisterXSClass(MessageException, 'http://xml.soa.modules.rsp.rspcn.com', 'MessageException');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fault), 'http://jerry/rsp/services/CaServiceLineService', 'fault');

end. 