// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://10.33.16.250:9081/rim/services/RimCoSave?wsdl
// Encoding : UTF-8
// Version  : 1.0
// (2008-8-22 18:52:53 - 1.33.2.5)
// ************************************************************************ //

unit SoapRimCoSave;

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
  // !:int             - "http://www.w3.org/2001/XMLSchema"
  // !:anyType         - "http://www.w3.org/2001/XMLSchema"
  // !:boolean         - "http://www.w3.org/2001/XMLSchema"
  // !:decimal         - "http://www.w3.org/2001/XMLSchema"

  getCurTime           = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getFourRandomNum     = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getCoDomain          = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getRimCustCoQueryDao = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getFourRandomNumResponse = class;             { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getCurTimeResponse   = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getLineXmlResponse   = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getLineXml           = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getHeadXmlResponse   = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getHeadXml           = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getReturnXmlResponse = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  XmlToCoList          = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  CoSaveResponse       = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  CoSave               = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getForCo             = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com"[A] }
  XmlToCoListResponse  = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com"[A] }
  getRimCustCoQueryDaoResponse = class;         { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getCoDomainResponse  = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  mapItem              = class;                 { "http://xml.apache.org/xml-soap" }
  Co                   = class;                 { "http://data.co.sale.sd.v3.lc.com" }
  getReturnXml         = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }
  getForCoResponse     = class;                 { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getCurTime = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getFourRandomNum = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getCoDomain = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getRimCustCoQueryDao = class(TRemotable)
  private
  public
    constructor Create; override;
  published
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getFourRandomNumResponse = class(TRemotable)
  private
    FgetFourRandomNumReturn: WideString;
  public
    constructor Create; override;
  published
    property getFourRandomNumReturn: WideString read FgetFourRandomNumReturn write FgetFourRandomNumReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getCurTimeResponse = class(TRemotable)
  private
    FgetCurTimeReturn: WideString;
  public
    constructor Create; override;
  published
    property getCurTimeReturn: WideString read FgetCurTimeReturn write FgetCurTimeReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getLineXmlResponse = class(TRemotable)
  private
    FgetLineXmlReturn: WideString;
  public
    constructor Create; override;
  published
    property getLineXmlReturn: WideString read FgetLineXmlReturn write FgetLineXmlReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getLineXml = class(TRemotable)
  private
    Famt: WideString;
    FitemCode: WideString;
    FitemId: WideString;
    FitemName: WideString;
    FlineNote: WideString;
    Fpri: WideString;
    Fpri3: WideString;
    FqtyNeed: WideString;
    FqtyOrd: WideString;
    FretAmt: WideString;
    FumId: WideString;
  public
    constructor Create; override;
  published
    property amt: WideString read Famt write Famt;
    property itemCode: WideString read FitemCode write FitemCode;
    property itemId: WideString read FitemId write FitemId;
    property itemName: WideString read FitemName write FitemName;
    property lineNote: WideString read FlineNote write FlineNote;
    property pri: WideString read Fpri write Fpri;
    property pri3: WideString read Fpri3 write Fpri3;
    property qtyNeed: WideString read FqtyNeed write FqtyNeed;
    property qtyOrd: WideString read FqtyOrd write FqtyOrd;
    property retAmt: WideString read FretAmt write FretAmt;
    property umId: WideString read FumId write FumId;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getHeadXmlResponse = class(TRemotable)
  private
    FgetHeadXmlReturn: WideString;
  public
    constructor Create; override;
  published
    property getHeadXmlReturn: WideString read FgetHeadXmlReturn write FgetHeadXmlReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getHeadXml = class(TRemotable)
  private
    FcoNum: WideString;
    FcustId: WideString;
    FcrtDate: WideString;
    FcrtUserId: WideString;
    Ftype_: WideString;
    Fstatus: WideString;
    Fnote: WideString;
  public
    constructor Create; override;
  published
    property coNum: WideString read FcoNum write FcoNum;
    property custId: WideString read FcustId write FcustId;
    property crtDate: WideString read FcrtDate write FcrtDate;
    property crtUserId: WideString read FcrtUserId write FcrtUserId;
    property type_: WideString read Ftype_ write Ftype_;
    property status: WideString read Fstatus write Fstatus;
    property note: WideString read Fnote write Fnote;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getReturnXmlResponse = class(TRemotable)
  private
    FgetReturnXmlReturn: WideString;
  public
    constructor Create; override;
  published
    property getReturnXmlReturn: WideString read FgetReturnXmlReturn write FgetReturnXmlReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  XmlToCoList = class(TRemotable)
  private
    Finxml: WideString;
  public
    constructor Create; override;
  published
    property inxml: WideString read Finxml write Finxml;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  CoSaveResponse = class(TRemotable)
  private
    FCoSaveReturn: WideString;
  public
    constructor Create; override;
  published
    property CoSaveReturn: WideString read FCoSaveReturn write FCoSaveReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  CoSave = class(TRemotable)
  private
    FinXml: WideString;
  public
    constructor Create; override;
  published
    property inXml: WideString read FinXml write FinXml;
  end;

  ArrayOf_xsd_anyType = array of Variant;       { "http://10.33.16.250:9081/rim/services/RimCoSave" }
  forCoList  = array of ArrayOf_xsd_anyType;    { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }


  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  getForCo = class(TRemotable)
  private
    FforCoList: forCoList;
  public
    constructor Create; override;
    function   GetArrayOf_xsd_anyTypeArray(Index: Integer): ArrayOf_xsd_anyType;
    function   GetArrayOf_xsd_anyTypeArrayLength: Integer;
    property   ArrayOf_xsd_anyTypeArray[Index: Integer]: ArrayOf_xsd_anyType read GetArrayOf_xsd_anyTypeArray; default;
    property   Len: Integer read GetArrayOf_xsd_anyTypeArrayLength;
  published
    property forCoList: forCoList read FforCoList write FforCoList;
  end;

  XmlToCoListReturn = array of ArrayOf_xsd_anyType;   { "http://trans.rimcustcosaveservice.service.rim.v3.lc.com" }


  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoInlineArrays,xoLiteralParam]
  // ************************************************************************ //
  XmlToCoListResponse = class(TRemotable)
  private
    FXmlToCoListReturn: XmlToCoListReturn;
  public
    constructor Create; override;
    function   GetArrayOf_xsd_anyTypeArray(Index: Integer): ArrayOf_xsd_anyType;
    function   GetArrayOf_xsd_anyTypeArrayLength: Integer;
    property   ArrayOf_xsd_anyTypeArray[Index: Integer]: ArrayOf_xsd_anyType read GetArrayOf_xsd_anyTypeArray; default;
    property   Len: Integer read GetArrayOf_xsd_anyTypeArrayLength;
  published
    property XmlToCoListReturn: XmlToCoListReturn read FXmlToCoListReturn write FXmlToCoListReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getRimCustCoQueryDaoResponse = class(TRemotable)
  private
    FgetRimCustCoQueryDaoReturn: Variant;
  public
    constructor Create; override;
  published
    property getRimCustCoQueryDaoReturn: Variant read FgetRimCustCoQueryDaoReturn write FgetRimCustCoQueryDaoReturn;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getCoDomainResponse = class(TRemotable)
  private
    FgetCoDomainReturn: Variant;
  public
    constructor Create; override;
  published
    property getCoDomainReturn: Variant read FgetCoDomainReturn write FgetCoDomainReturn;
  end;

  ArrayOf_xsd_string = array of WideString;     { "http://10.33.16.250:9081/rim/services/RimCoSave" }


  // ************************************************************************ //
  // Namespace : http://xml.apache.org/xml-soap
  // ************************************************************************ //
  mapItem = class(TRemotable)
  private
    Fkey: Variant;
    Fvalue: Variant;
  published
    property key: Variant read Fkey write Fkey;
    property value: Variant read Fvalue write Fvalue;
  end;

  Map        = array of mapItem;                { "http://xml.apache.org/xml-soap" }


  // ************************************************************************ //
  // Namespace : http://data.co.sale.sd.v3.lc.com
  // ************************************************************************ //
  Co = class(TRemotable)
  private
    FisIss: WideString;
    FcustName: WideString;
    FcomId: WideString;
    FcoNum: WideString;
    FbankId: WideString;
    Fcopy: Boolean;
    FmfrId: WideString;
    FreqInv: WideString;
    Fnote: WideString;
    Fstatus: WideString;
    FlistPromoCoLine: ArrayOf_xsd_anyType;
    FcustLimitDown: WideString;
    FpmtStatus: WideString;
    FsaleorgName: WideString;
    FbankName: WideString;
    FretAmtSum: TXSDecimal;
    FcustShortId: WideString;
    FamtSum: TXSDecimal;
    FcustCode: WideString;
    FposeDate: WideString;
    FwhseId: WideString;
    Fbalance: TXSDecimal;
    FumId: WideString;
    FcfmUserId: WideString;
    FcustId: WideString;
    FreserFinDate: WideString;
    FlineChange: Boolean;
    FumName: WideString;
    FvouUserId: WideString;
    FreturnStatus: WideString;
    FlistCoLine: ArrayOf_xsd_anyType;
    FitemName: WideString;
    FnodeId: WideString;
    Fspec: WideString;
    Ftype_: WideString;
    FsaleorgId: WideString;
    FaddGridDetail: ArrayOf_xsd_string;
    FpreareAmt: TXSDecimal;
    FmaxLimit: WideString;
    FqtySum: TXSDecimal;
    FcrtDate: WideString;
    FarrDate: WideString;
    FregionId: WideString;
    Fmanager: WideString;
    FcomName: WideString;
    FflowchartId: WideString;
    Fpri: TXSDecimal;
    FmfrName: WideString;
    Freservable: Integer;
    FisPrm: WideString;
    FisInvoiced: WideString;
    FretMsg: WideString;
    FitemCode: WideString;
    Fper: WideString;
    FcallMan: WideString;
    FpromoFlag: WideString;
    FslsmanId: WideString;
    FmsgMap: Map;
    FbornDate: WideString;
    Fkind: WideString;
    FrecAmtSum: TXSDecimal;
    FswhseId: WideString;
    FisDisted: WideString;
    FwhseName: WideString;
    FitemId: WideString;
    FupdateAmtSum: TXSDecimal;
    FslsmanName: WideString;
    FcrtUserId: WideString;
    FamtTaxSum: TXSDecimal;
    Fsuccess: Boolean;
    FdistNum: WideString;
  public
    destructor Destroy; override;
  published
    property isIss: WideString read FisIss write FisIss;
    property custName: WideString read FcustName write FcustName;
    property comId: WideString read FcomId write FcomId;
    property coNum: WideString read FcoNum write FcoNum;
    property bankId: WideString read FbankId write FbankId;
    property copy: Boolean read Fcopy write Fcopy;
    property mfrId: WideString read FmfrId write FmfrId;
    property reqInv: WideString read FreqInv write FreqInv;
    property note: WideString read Fnote write Fnote;
    property status: WideString read Fstatus write Fstatus;
    property listPromoCoLine: ArrayOf_xsd_anyType read FlistPromoCoLine write FlistPromoCoLine;
    property custLimitDown: WideString read FcustLimitDown write FcustLimitDown;
    property pmtStatus: WideString read FpmtStatus write FpmtStatus;
    property saleorgName: WideString read FsaleorgName write FsaleorgName;
    property bankName: WideString read FbankName write FbankName;
    property retAmtSum: TXSDecimal read FretAmtSum write FretAmtSum;
    property custShortId: WideString read FcustShortId write FcustShortId;
    property amtSum: TXSDecimal read FamtSum write FamtSum;
    property custCode: WideString read FcustCode write FcustCode;
    property poseDate: WideString read FposeDate write FposeDate;
    property whseId: WideString read FwhseId write FwhseId;
    property balance: TXSDecimal read Fbalance write Fbalance;
    property umId: WideString read FumId write FumId;
    property cfmUserId: WideString read FcfmUserId write FcfmUserId;
    property custId: WideString read FcustId write FcustId;
    property reserFinDate: WideString read FreserFinDate write FreserFinDate;
    property lineChange: Boolean read FlineChange write FlineChange;
    property umName: WideString read FumName write FumName;
    property vouUserId: WideString read FvouUserId write FvouUserId;
    property returnStatus: WideString read FreturnStatus write FreturnStatus;
    property listCoLine: ArrayOf_xsd_anyType read FlistCoLine write FlistCoLine;
    property itemName: WideString read FitemName write FitemName;
    property nodeId: WideString read FnodeId write FnodeId;
    property spec: WideString read Fspec write Fspec;
    property type_: WideString read Ftype_ write Ftype_;
    property saleorgId: WideString read FsaleorgId write FsaleorgId;
    property addGridDetail: ArrayOf_xsd_string read FaddGridDetail write FaddGridDetail;
    property preareAmt: TXSDecimal read FpreareAmt write FpreareAmt;
    property maxLimit: WideString read FmaxLimit write FmaxLimit;
    property qtySum: TXSDecimal read FqtySum write FqtySum;
    property crtDate: WideString read FcrtDate write FcrtDate;
    property arrDate: WideString read FarrDate write FarrDate;
    property regionId: WideString read FregionId write FregionId;
    property manager: WideString read Fmanager write Fmanager;
    property comName: WideString read FcomName write FcomName;
    property flowchartId: WideString read FflowchartId write FflowchartId;
    property pri: TXSDecimal read Fpri write Fpri;
    property mfrName: WideString read FmfrName write FmfrName;
    property reservable: Integer read Freservable write Freservable;
    property isPrm: WideString read FisPrm write FisPrm;
    property isInvoiced: WideString read FisInvoiced write FisInvoiced;
    property retMsg: WideString read FretMsg write FretMsg;
    property itemCode: WideString read FitemCode write FitemCode;
    property per: WideString read Fper write Fper;
    property callMan: WideString read FcallMan write FcallMan;
    property promoFlag: WideString read FpromoFlag write FpromoFlag;
    property slsmanId: WideString read FslsmanId write FslsmanId;
    property msgMap: Map read FmsgMap write FmsgMap;
    property bornDate: WideString read FbornDate write FbornDate;
    property kind: WideString read Fkind write Fkind;
    property recAmtSum: TXSDecimal read FrecAmtSum write FrecAmtSum;
    property swhseId: WideString read FswhseId write FswhseId;
    property isDisted: WideString read FisDisted write FisDisted;
    property whseName: WideString read FwhseName write FwhseName;
    property itemId: WideString read FitemId write FitemId;
    property updateAmtSum: TXSDecimal read FupdateAmtSum write FupdateAmtSum;
    property slsmanName: WideString read FslsmanName write FslsmanName;
    property crtUserId: WideString read FcrtUserId write FcrtUserId;
    property amtTaxSum: TXSDecimal read FamtTaxSum write FamtTaxSum;
    property success: Boolean read Fsuccess write Fsuccess;
    property distNum: WideString read FdistNum write FdistNum;
  end;



  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getReturnXml = class(TRemotable)
  private
    Fviewin: Co;
    Fnum: Integer;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property viewin: Co read Fviewin write Fviewin;
    property num: Integer read Fnum write Fnum;
  end;


  // ************************************************************************ //
  // Namespace : http://trans.rimcustcosaveservice.service.rim.v3.lc.com
  // Serializtn: [xoLiteralParam]
  // ************************************************************************ //
  getForCoResponse = class(TRemotable)
  private
    FgetForCoReturn: Co;
  public
    constructor Create; override;
    destructor Destroy; override;
  published
    property getForCoReturn: Co read FgetForCoReturn write FgetForCoReturn;
  end;


  // ************************************************************************ //
  // Namespace : http://10.33.16.250:9081/rim/services/RimCoSave
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : RimCoSaveSoapBinding
  // service   : RimCustCoSaveServiceService
  // port      : RimCoSave
  // URL       : http://10.33.16.250:9081/rim/services/RimCoSave
  // ************************************************************************ //
  RimCustCoSaveService = interface(IInvokable)
  ['{D7EBDCBD-E61E-047F-5A54-0B34C77D3F2E}']
    function  CoSave(const parameters: CoSave): CoSaveResponse; stdcall;
    function  XmlToCoList(const parameters: XmlToCoList): XmlToCoListResponse; stdcall;
    function  getForCo(const parameters: getForCo): getForCoResponse; stdcall;
    function  getReturnXml(const parameters: getReturnXml): getReturnXmlResponse; stdcall;
    function  getHeadXml(const parameters: getHeadXml): getHeadXmlResponse; stdcall;
    function  getLineXml(const parameters: getLineXml): getLineXmlResponse; stdcall;
    function  getCurTime(const parameters: getCurTime): getCurTimeResponse; stdcall;
    function  getFourRandomNum(const parameters: getFourRandomNum): getFourRandomNumResponse; stdcall;
    function  getCoDomain(const parameters: getCoDomain): getCoDomainResponse; stdcall;
    function  getRimCustCoQueryDao(const parameters: getRimCustCoQueryDao): getRimCustCoQueryDaoResponse; stdcall;
  end;

function GetRimCustCoSaveService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): RimCustCoSaveService;


implementation

function GetRimCustCoSaveService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): RimCustCoSaveService;
const
  defWSDL = 'http://10.33.16.250:9081/rim/services/RimCoSave?wsdl';
  defURL  = 'http://10.33.16.250:9081/rim/services/RimCoSave';
  defSvc  = 'RimCustCoSaveServiceService';
  defPrt  = 'RimCoSave';
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
    Result := (RIO as RimCustCoSaveService);
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


constructor getCurTime.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getFourRandomNum.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getCoDomain.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getRimCustCoQueryDao.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getFourRandomNumResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getCurTimeResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getLineXmlResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getLineXml.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getHeadXmlResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getHeadXml.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getReturnXmlResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor XmlToCoList.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor CoSaveResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor CoSave.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getForCo.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

function getForCo.GetArrayOf_xsd_anyTypeArray(Index: Integer): ArrayOf_xsd_anyType;
begin
  Result := FforCoList[Index];
end;

function getForCo.GetArrayOf_xsd_anyTypeArrayLength: Integer;
begin
  if Assigned(FforCoList) then
    Result := Length(FforCoList)
  else
  Result := 0;
end;

constructor XmlToCoListResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoInlineArrays,xoLiteralParam];
end;

function XmlToCoListResponse.GetArrayOf_xsd_anyTypeArray(Index: Integer): ArrayOf_xsd_anyType;
begin
  Result := FXmlToCoListReturn[Index];
end;

function XmlToCoListResponse.GetArrayOf_xsd_anyTypeArrayLength: Integer;
begin
  if Assigned(FXmlToCoListReturn) then
    Result := Length(FXmlToCoListReturn)
  else
  Result := 0;
end;

constructor getRimCustCoQueryDaoResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

constructor getCoDomainResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor Co.Destroy;
var
  I: Integer;
begin
  for I := 0 to Length(FmsgMap)-1 do
    if Assigned(FmsgMap[I]) then
      FmsgMap[I].Free;
  SetLength(FmsgMap, 0);
  if Assigned(FretAmtSum) then
    FretAmtSum.Free;
  if Assigned(FamtSum) then
    FamtSum.Free;
  if Assigned(Fbalance) then
    Fbalance.Free;
  if Assigned(FpreareAmt) then
    FpreareAmt.Free;
  if Assigned(FqtySum) then
    FqtySum.Free;
  if Assigned(Fpri) then
    Fpri.Free;
  if Assigned(FrecAmtSum) then
    FrecAmtSum.Free;
  if Assigned(FupdateAmtSum) then
    FupdateAmtSum.Free;
  if Assigned(FamtTaxSum) then
    FamtTaxSum.Free;
  inherited Destroy;
end;

constructor getReturnXml.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor getReturnXml.Destroy;
begin
  if Assigned(Fviewin) then
    Fviewin.Free;
  inherited Destroy;
end;

constructor getForCoResponse.Create;
begin
  inherited Create;
  FSerializationOptions := [xoLiteralParam];
end;

destructor getForCoResponse.Destroy;
begin
  if Assigned(FgetForCoReturn) then
    FgetForCoReturn.Free;
  inherited Destroy;
end;

initialization
  InvRegistry.RegisterInterface(TypeInfo(RimCustCoSaveService), 'http://10.33.16.250:9081/rim/services/RimCoSave', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(RimCustCoSaveService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(RimCustCoSaveService), ioDocument);
  InvRegistry.RegisterInvokeOptions(TypeInfo(RimCustCoSaveService), ioLiteral);
  RemClassRegistry.RegisterXSClass(getCurTime, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getCurTime');
  RemClassRegistry.RegisterSerializeOptions(getCurTime, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getFourRandomNum, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getFourRandomNum');
  RemClassRegistry.RegisterSerializeOptions(getFourRandomNum, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getCoDomain, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getCoDomain');
  RemClassRegistry.RegisterSerializeOptions(getCoDomain, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getRimCustCoQueryDao, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getRimCustCoQueryDao');
  RemClassRegistry.RegisterSerializeOptions(getRimCustCoQueryDao, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getFourRandomNumResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getFourRandomNumResponse');
  RemClassRegistry.RegisterSerializeOptions(getFourRandomNumResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getCurTimeResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getCurTimeResponse');
  RemClassRegistry.RegisterSerializeOptions(getCurTimeResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getLineXmlResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getLineXmlResponse');
  RemClassRegistry.RegisterSerializeOptions(getLineXmlResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getLineXml, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getLineXml');
  RemClassRegistry.RegisterSerializeOptions(getLineXml, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getHeadXmlResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getHeadXmlResponse');
  RemClassRegistry.RegisterSerializeOptions(getHeadXmlResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getHeadXml, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getHeadXml');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(getHeadXml), 'type_', 'type');
  RemClassRegistry.RegisterSerializeOptions(getHeadXml, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getReturnXmlResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getReturnXmlResponse');
  RemClassRegistry.RegisterSerializeOptions(getReturnXmlResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(XmlToCoList, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'XmlToCoList');
  RemClassRegistry.RegisterSerializeOptions(XmlToCoList, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(CoSaveResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'CoSaveResponse');
  RemClassRegistry.RegisterSerializeOptions(CoSaveResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(CoSave, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'CoSave');
  RemClassRegistry.RegisterSerializeOptions(CoSave, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_xsd_anyType), 'http://10.33.16.250:9081/rim/services/RimCoSave', 'ArrayOf_xsd_anyType');
  RemClassRegistry.RegisterXSInfo(TypeInfo(forCoList), 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'forCoList');
  RemClassRegistry.RegisterXSClass(getForCo, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getForCo');
  RemClassRegistry.RegisterSerializeOptions(getForCo, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(XmlToCoListReturn), 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'XmlToCoListReturn');
  RemClassRegistry.RegisterXSClass(XmlToCoListResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'XmlToCoListResponse');
  RemClassRegistry.RegisterSerializeOptions(XmlToCoListResponse, [xoInlineArrays,xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getRimCustCoQueryDaoResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getRimCustCoQueryDaoResponse');
  RemClassRegistry.RegisterSerializeOptions(getRimCustCoQueryDaoResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getCoDomainResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getCoDomainResponse');
  RemClassRegistry.RegisterSerializeOptions(getCoDomainResponse, [xoLiteralParam]);
  RemClassRegistry.RegisterXSInfo(TypeInfo(ArrayOf_xsd_string), 'http://10.33.16.250:9081/rim/services/RimCoSave', 'ArrayOf_xsd_string');
  RemClassRegistry.RegisterXSClass(mapItem, 'http://xml.apache.org/xml-soap', 'mapItem');
  RemClassRegistry.RegisterXSInfo(TypeInfo(Map), 'http://xml.apache.org/xml-soap', 'Map');
  RemClassRegistry.RegisterXSClass(Co, 'http://data.co.sale.sd.v3.lc.com', 'Co');
  RemClassRegistry.RegisterExternalPropName(TypeInfo(Co), 'type_', 'type');
  RemClassRegistry.RegisterXSClass(getReturnXml, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getReturnXml');
  RemClassRegistry.RegisterSerializeOptions(getReturnXml, [xoLiteralParam]);
  RemClassRegistry.RegisterXSClass(getForCoResponse, 'http://trans.rimcustcosaveservice.service.rim.v3.lc.com', 'getForCoResponse');
  RemClassRegistry.RegisterSerializeOptions(getForCoResponse, [xoLiteralParam]);

end.