unit uSyncFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns,Des,WinInet, xmldom, XMLIntf,
  msxmldom, XMLDoc, MSHTML, ActiveX,msxml,ComObj;
type
  TSyncFactory=class
  private
  public
    constructor Create;
    destructor Destroy;override;
    //ÏÂÔØ

    //ÉÏ´«
    

  end;
var SyncFactory:TSyncFactory;
implementation

{ TCaFactory }

constructor TSyncFactory.Create;
begin

end;

destructor TSyncFactory.Destroy;
begin

  inherited;
end;

initialization
  SyncFactory := TSyncFactory.Create;
finalization
  SyncFactory.Free;
end.
