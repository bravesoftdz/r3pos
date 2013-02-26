unit uTokenFactory;

interface
uses SysUtils, Classes,Des,EncDec,msxml,windows,EncdDecd;
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
  public
    function encode:string;
    procedure decode(_token:string);

    property userId:string read FuserId write SetuserId;
    property account:string read Faccount write Setaccount;
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
  end;
var
  token:TToken;
implementation

{ TToken }

procedure TToken.decode(_token: string);
begin

end;

function TToken.encode: string;
begin

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

procedure TToken.Setlegal(const Value: string);
begin
  Flegal := Value;
end;

procedure TToken.SetlicenseCode(const Value: string);
begin
  FlicenseCode := Value;
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
  token.Free;
end.
