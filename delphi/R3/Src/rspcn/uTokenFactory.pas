unit uTokenFactory;

interface
uses SysUtils, Classes,Des,EncDec,msxml,windows,EncdDecd,Comobj;
type
  TToken=class
  private
    Fonline: boolean;
    FtenantId: string;
    FtenantName: string;
    FshopId: string;
    Faccount: string;
    Fmobile: string;
    FuserId: string;
    FxsmPWD: string;
    FxsmCode: string;
    FshopName: string;
    FlicenseCode: string;
    Flegal: string;
    Faddress: string;
    FidCard: string;
    FxsmAlias: string;
    Fshoped: boolean;
    Flogined: boolean;
    Fusername: string;
    FlDate: integer;
    procedure Setaccount(const Value: string);
    procedure Setaddress(const Value: string);
    procedure SetidCard(const Value: string);
    procedure Setlegal(const Value: string);
    procedure SetlicenseCode(const Value: string);
    procedure Setmobile(const Value: string);
    procedure Setonline(const Value: boolean);
    procedure SetshopId(const Value: string);
    procedure SetshopName(const Value: string);
    procedure SettenantId(const Value: string);
    procedure SettenantName(const Value: string);
    procedure SetuserId(const Value: string);
    procedure SetxsmAlias(const Value: string);
    procedure SetxsmCode(const Value: string);
    procedure SetxsmPWD(const Value: string);
    procedure Setshoped(const Value: boolean);
    procedure Setlogined(const Value: boolean);
    procedure Setusername(const Value: string);
    procedure SetlDate(const Value: integer);
  public
    function encode:string;
    function encodeJson:string;
    procedure decode(_token:string);

    property userId:string read FuserId write SetuserId;
    property account:string read Faccount write Setaccount;
    property username:string read Fusername write Setusername;
    property tenantId:string read FtenantId write SettenantId;
    property tenantName:string read FtenantName write SettenantName;
    property shopId:string read FshopId write SetshopId;
    property shopName:string read FshopName write SetshopName;
    property address:string read Faddress write Setaddress;
    property xsmCode:string read FxsmCode write SetxsmCode;
    property xsmAlias:string read FxsmAlias write SetxsmAlias;
    property xsmPWD:string read FxsmPWD write SetxsmPWD;
    property licenseCode:string read FlicenseCode write SetlicenseCode;
    property legal:string read Flegal write Setlegal;
    property idCard:string read FidCard write SetidCard;
    property mobile:string read Fmobile write Setmobile;
    property online:boolean read Fonline write Setonline;
    property shoped:boolean read Fshoped write Setshoped;
    property logined:boolean read Flogined write Setlogined;
    property lDate:integer read FlDate write SetlDate;
  end;
var
  token:TToken;
implementation

{ TToken }

procedure TToken.decode(_token: string);
var
  rspcn:IXMLDOMElement;
  userinfo:IXMLDOMNode;
  doc:IXMLDomDocument;
begin
  doc := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    doc.loadXML(_token);
    rspcn := doc.documentElement;
    if rspcn.getAttribute('code')<>'0000' then raise exception.Create(rspcn.getAttribute('msg'));
    userId := rspcn.selectSingleNode('/rspcn/userInfo/userId').text;
    account := rspcn.selectSingleNode('/rspcn/userInfo/account').text;
    username := rspcn.selectSingleNode('/rspcn/userInfo/username').text;
    tenantId := rspcn.selectSingleNode('/rspcn/userInfo/tenantId').text;
    tenantName := rspcn.selectSingleNode('/rspcn/userInfo/tenantName').text;
    shopId := rspcn.selectSingleNode('/rspcn/userInfo/shopId').text;
    shopName := rspcn.selectSingleNode('/rspcn/userInfo/shopName').text;
    address := rspcn.selectSingleNode('/rspcn/userInfo/address').text;
    xsmCode := rspcn.selectSingleNode('/rspcn/userInfo/xsmCode').text;
    xsmPWD := rspcn.selectSingleNode('/rspcn/userInfo/xsmPWD').text;
    licenseCode := rspcn.selectSingleNode('/rspcn/userInfo/licenseCode').text;
    legal := rspcn.selectSingleNode('/rspcn/userInfo/legal').text;
    idCard := rspcn.selectSingleNode('/rspcn/userInfo/idCard').text;
    mobile := rspcn.selectSingleNode('/rspcn/userInfo/mobile').text;
    online := (rspcn.selectSingleNode('/rspcn/userInfo/online').text='1');
    LDate := strtoIntDef(rspcn.selectSingleNode('/rspcn/userInfo/lDate').text,0);
    shoped := true;
    logined := true;
  except
    Raise;
  end;
end;

function TToken.encode: string;
var
  rspcn,userinfo,node:IXMLDOMElement;
  doc:IXMLDomDocument;
begin
  doc := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    rspcn := doc.createElement('rspcn');
    rspcn.setAttribute('code','0000');
    rspcn.setAttribute('msg','∫œ∑®¡Ó∞Ê');
    rspcn.setAttribute('time_stamp',formatDatetime('YYYYMMDDHHNNSS',now()));
    doc.documentElement := rspcn;
    userinfo := doc.createElement('userInfo');
    node := doc.createElement('userId');
    node.text := userId;
    userinfo.appendChild(node);
    node := doc.createElement('account');
    node.text := account;
    userinfo.appendChild(node);
    node := doc.createElement('username');
    node.text := username;
    userinfo.appendChild(node);
    node := doc.createElement('tenantId');
    node.text := tenantId;
    userinfo.appendChild(node);
    node := doc.createElement('tenantName');
    node.text := tenantName;
    userinfo.appendChild(node);
    node := doc.createElement('shopId');
    node.text := shopId;
    userinfo.appendChild(node);
    node := doc.createElement('shopName');
    node.text := shopName;
    userinfo.appendChild(node);
    node := doc.createElement('address');
    node.text := address;
    userinfo.appendChild(node);
    node := doc.createElement('xsmCode');
    node.text := xsmCode;
    userinfo.appendChild(node);
    node := doc.createElement('xsmPWD');
    node.text := xsmPWD;
    userinfo.appendChild(node);
    node := doc.createElement('licenseCode');
    node.text := licenseCode;
    userinfo.appendChild(node);
    node := doc.createElement('legal');
    node.text := legal;
    userinfo.appendChild(node);
    node := doc.createElement('idCard');
    node.text := idCard;
    userinfo.appendChild(node);
    node := doc.createElement('mobile');
    node.text := mobile;
    userinfo.appendChild(node);
    node := doc.createElement('online');
    if online then
       node.text := '1'
    else
       node.text := '0';
    userinfo.appendChild(node);
    rspcn.appendChild(userinfo);
    node := doc.createElement('lDate');
    node.text := inttostr(lDate);
    userinfo.appendChild(node);
    result := doc.xml;
  except
    Raise;
  end;
end;

function TToken.encodeJson: string;
begin
  result :=
   '{'+
   '"userId":"'+userId+'",'+
   '"userName":"'+userName+'",'+
   '"account":"'+account+'",'+
   '"tenantId":"'+tenantId+'",'+
   '"tenantName":"'+tenantName+'",'+
   '"shopId":"'+shopId+'",'+
   '"shopName":"'+shopName+'",'+
   '"address":"'+address+'",'+
   '"xsmCode":"'+xsmCode+'",'+
   '"xsmAlias":"'+xsmAlias+'",'+
   '"licenseCode":"'+licenseCode+'",'+
   '"legal":"'+legal+'",'+
   '"idCard":"'+idCard+'",'+
   '"mobile":"'+mobile+'",'+
   '"online":"'+booltoStr(online,true)+'",'+
   '"lDate":"'+inttostr(lDate)+'"'+
   '}';
end;

procedure TToken.Setaccount(const Value: string);
begin
  Faccount := Value;
end;

procedure TToken.Setaddress(const Value: string);
begin
  Faddress := Value;
end;

procedure TToken.SetidCard(const Value: string);
begin
  FidCard := Value;
end;

procedure TToken.SetlDate(const Value: integer);
begin
  FlDate := Value;
end;

procedure TToken.Setlegal(const Value: string);
begin
  Flegal := Value;
end;

procedure TToken.SetlicenseCode(const Value: string);
begin
  FlicenseCode := Value;
end;

procedure TToken.Setlogined(const Value: boolean);
begin
  Flogined := Value;
end;

procedure TToken.Setmobile(const Value: string);
begin
  Fmobile := Value;
end;

procedure TToken.Setonline(const Value: boolean);
begin
  Fonline := Value;
end;

procedure TToken.Setshoped(const Value: boolean);
begin
  Fshoped := Value;
end;

procedure TToken.SetshopId(const Value: string);
begin
  FshopId := Value;
end;

procedure TToken.SetshopName(const Value: string);
begin
  FshopName := Value;
end;

procedure TToken.SettenantId(const Value: string);
begin
  FtenantId := Value;
end;

procedure TToken.SettenantName(const Value: string);
begin
  FtenantName := Value;
end;

procedure TToken.SetuserId(const Value: string);
begin
  FuserId := Value;
end;

procedure TToken.Setusername(const Value: string);
begin
  Fusername := Value;
end;

procedure TToken.SetxsmAlias(const Value: string);
begin
  FxsmAlias := Value;
end;

procedure TToken.SetxsmCode(const Value: string);
begin
  FxsmCode := Value;
end;

procedure TToken.SetxsmPWD(const Value: string);
begin
  FxsmPWD := Value;
end;

initialization
  token := TToken.create;
finalization
  if assigned(token) then FreeAndNil(token);
end.
