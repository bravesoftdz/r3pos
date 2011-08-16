unit uGodsFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,ZdbFactory,ZDataSet,ZBase;
type
  TGodsFactory=class
  private
    FDb: TdbFactory;
    procedure SetDb(const Value: TdbFactory);
  public
    constructor Create;
    destructor Destroy;override;
    function Check(bcode:string):TRecord_;
    property Db:TdbFactory read FDb write SetDb;
  end;
var
  GodsFactory:TGodsFactory;
implementation
uses uGlobal;
{ TGodsFactory }

function TGodsFactory.Check(bcode: string): TRecord_;
var
  rs:TZQuery;
begin
  result := nil;
  if not db.Connected then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select * from PUB_GOODSINFO where TENANT_ID=0 and GODS_ID in (select GODS_ID from PUB_BARCODE where TENANT_ID=0 and BARCODE='''+bcode+''')';
    db.Open(rs);
    if rs.IsEmpty then
       begin
         result := TRecord_.Create;
         result.ReadFromDataSet(rs); 
       end;
  finally
    rs.Free;
  end;
end;

constructor TGodsFactory.Create;
begin
  Db := TdbFactory.Create;
  if FileExists(ExtractShortPathName(ExtractFilePath(ParamStr(0)))+'basic.db') then
     begin
       Db.Initialize('provider=sqlite-3;databasename='+ExtractShortPathName(ExtractFilePath(ParamStr(0)))+'basic.db');
       Db.Connect;
     end;
end;

destructor TGodsFactory.Destroy;
begin
  Db.Free;
  inherited;
end;

procedure TGodsFactory.SetDb(const Value: TdbFactory);
begin
  FDb := Value;
end;

initialization
  GodsFactory := TGodsFactory.Create;
finalization
  GodsFactory.free;
end.
