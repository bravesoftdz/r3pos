// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://rsp.xinshangmeng.com/services/PubMemberService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2011/4/28 14:10:21 - 1.33.2.5)
// ************************************************************************ //

unit PubMemberService;

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

  Pub                  = class;                 { "http://xml.soa.modules.rsp.rspcn.com" }
  MessageException     = class;                 { "http://xml.soa.modules.rsp.rspcn.com" }



  // ************************************************************************ //
  // Namespace : http://xml.soa.modules.rsp.rspcn.com
  // ************************************************************************ //
  Pub = class(TRemotable)
  private
    Fmsg: WideString;
    FtimeStamp: WideString;
    FrecAck: WideString;
    Fvss: WideString;
    Fflag: WideString;
  published
    property msg: WideString read Fmsg write Fmsg;
    property timeStamp: WideString read FtimeStamp write FtimeStamp;
    property recAck: WideString read FrecAck write FrecAck;
    property vss: WideString read Fvss write Fvss;
    property flag: WideString read Fflag write Fflag;
  end;



  // ************************************************************************ //
  // Namespace : http://xml.soa.modules.rsp.rspcn.com
  // ************************************************************************ //
  MessageException = class(TRemotable)
  private
    Fpub: Pub;
    Fmessage: WideString;
  public
    destructor Destroy; override;
  published
    property pub: Pub read Fpub write Fpub;
    property message: WideString read Fmessage write Fmessage;
  end;

  fault           = MessageException;      { "http://rsp.xinshangmeng.com/services/PubMemberService"[F] }

  // ************************************************************************ //
  // Namespace : http://rsp.xinshangmeng.com/services/PubMemberService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : PubMemberServiceSoapBinding
  // service   : PubMemberWebServiceImplService
  // port      : PubMemberService
  // URL       : http://rsp.xinshangmeng.com/services/PubMemberService
  // ************************************************************************ //
  PubMemberWebServiceImpl = interface(IInvokable)
  ['{E2155A88-0A02-1A07-57A9-0D5E0235088B}']
    function  queryUnion(const inXml: WideString): WideString; stdcall;
  end;

function GetPubMemberWebServiceImpl(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): PubMemberWebServiceImpl;


implementation

function GetPubMemberWebServiceImpl(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): PubMemberWebServiceImpl;
const
  defWSDL = 'http://rsp.xinshangmeng.com/services/PubMemberService?wsdl';
  defURL  = 'http://rsp.xinshangmeng.com/services/PubMemberService';
  defSvc  = 'PubMemberWebServiceImplService';
  defPrt  = 'PubMemberService';
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
    Result := (RIO as PubMemberWebServiceImpl);
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


destructor MessageException.Destroy;
begin
  if Assigned(Fpub) then
    Fpub.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(PubMemberWebServiceImpl), 'http://rsp.xinshangmeng.com/services/PubMemberService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(PubMemberWebServiceImpl), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(PubMemberWebServiceImpl), ioDocument);
  RemClassRegistry.RegisterXSClass(Pub, 'http://xml.soa.modules.rsp.rspcn.com', 'Pub');
  RemClassRegistry.RegisterXSClass(MessageException, 'http://xml.soa.modules.rsp.rspcn.com', 'MessageException');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fault), 'http://rsp.xinshangmeng.com/services/PubMemberService', 'fault');

end. 