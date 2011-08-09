// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://jerry/rsp/services/RspDownloadService?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2011/3/31 15:02:26 - 1.33.2.5)
// ************************************************************************ //

unit RspDownloadService;

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

  fault           = MessageException;      { "http://jerry/rsp/services/RspDownloadService"[F] }

  // ************************************************************************ //
  // Namespace : http://jerry/rsp/services/RspDownloadService
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : RspDownloadServiceSoapBinding
  // service   : RspDownloadWebServiceImplService
  // port      : RspDownloadService
  // URL       : http://jerry/rsp/services/RspDownloadService
  // ************************************************************************ //
  RspDownloadWebServiceImpl = interface(IInvokable)
  ['{65A04210-EC81-0D72-2D57-316B3AA71178}']
    function  downloadTenants(const inXml: WideString): WideString; stdcall;
    function  downloadServiceLines(const inXml: WideString): WideString; stdcall;
    function  downloadRelations(const inXml: WideString): WideString; stdcall;
    function  downloadSort(const inXml: WideString): WideString; stdcall;
    function  downloadUnit(const inXml: WideString): WideString; stdcall;
    function  downloadGoods(const inXml: WideString): WideString; stdcall;
    function  downloadDeployGoods(const inXml: WideString): WideString; stdcall;
    function  downloadBarcode(const inXml: WideString): WideString; stdcall;
  end;

function GetRspDownloadWebServiceImpl(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): RspDownloadWebServiceImpl;


implementation
function GetRspDownloadWebServiceImpl(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): RspDownloadWebServiceImpl;
const
  defWSDL = 'http://jerry/rsp/services/RspDownloadService?wsdl';
  defURL  = 'http://jerry/rsp/services/RspDownloadService';
  defSvc  = 'RspDownloadWebServiceImplService';
  defPrt  = 'RspDownloadService';
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
    Result := (RIO as RspDownloadWebServiceImpl);
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
  InvRegistry.RegisterInterface(TypeInfo(RspDownloadWebServiceImpl), 'http://jerry/rsp/services/RspDownloadService', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RspDownloadWebServiceImpl), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RspDownloadWebServiceImpl), ioDocument);
  RemClassRegistry.RegisterXSClass(Pub, 'http://xml.soa.modules.rsp.rspcn.com', 'Pub');
  RemClassRegistry.RegisterXSClass(MessageException, 'http://xml.soa.modules.rsp.rspcn.com', 'MessageException');
  RemClassRegistry.RegisterXSInfo(TypeInfo(fault), 'http://jerry/rsp/services/RspDownloadService', 'fault');

end.