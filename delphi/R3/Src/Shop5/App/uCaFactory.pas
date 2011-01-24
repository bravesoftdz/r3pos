unit uCaFactory;

interface
type
  TCaTenant=record
    TENANT_ID:integer;
    LOGIN_NAME:string;
    TENANT_NAME:string;
    TENANT_TYPE:integer;
    SHORT_TENANT_NAME:string;
    TENANT_SPELL:string;
    LEGAL_REPR:string;
    LINKMAN:string;
    TELEPHONE:string;
    FAXES:string;
    HOMEPAGE:string;
    ADDRESS:string;
    POSTALCODE:string;
    REMARK:string;
    PASSWRD:string;
    REGION_ID:string;
    SRVR_ID:string;
    PROD_ID:string;
  end;
  TCaLogin=record
    TENANT_ID:integer;
    RET:string;
    SLL:string;
    HOST_NAME:string;
    SRVR_PORT:integer;
    SRVR_PATH:string;
  end;
  TCaFactory=class
  public
    function coLogin(Account:string;PassWrd:string):TCaLogin;
    function coRegister(Info:TCaTenant):TCaTenant;
  end;
var CaFactory:TCaFactory;
implementation
{ TCaFactory }

function TCaFactory.coLogin(Account, PassWrd: string): TCaLogin;
begin
  result.TENANT_ID := 1000001;
end;

function TCaFactory.coRegister(Info: TCaTenant): TCaTenant;
begin
  result := Info;
  result.TENANT_ID := 1000001;
end;

initialization
  CaFactory := TCaFactory.Create;
finalization
  CaFactory.Free;
end.
