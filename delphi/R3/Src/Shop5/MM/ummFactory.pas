unit ummFactory;

interface
uses SysUtils, Classes, Windows,Registry, Winsock, NB30, ZBase;
type
  TmmFactory=class
  private
    Furl: string;
    procedure Seturl(const Value: string);
  public
    constructor Create;
    destructor Destroy;override;
    //��֤��������·��
    property url:string read Furl write Seturl;
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

procedure TmmFactory.Seturl(const Value: string);
begin
  Furl := Value;
end;

end.
