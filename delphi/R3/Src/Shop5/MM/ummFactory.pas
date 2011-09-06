unit ummFactory;

interface
uses SysUtils, Classes, Windows,Registry, Winsock, NB30, ZBase;
type
  PmmUserInfo=^TmmUserInfo;
  TmmUserInfo=record
  end;
  TmmFactory=class
  private
  public
    constructor Create;
    destructor Destroy;override;
  end;
implementation

{ TmmFactory }

constructor TmmFactory.Create;
begin

end;

destructor TmmFactory.Destroy;
begin

  inherited;
end;
end.
