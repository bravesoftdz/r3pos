unit uGodsFactory;

interface
uses
  Windows, Messages, SysUtils, Classes,ZdbFactory,ZDataSet,ZBase;
type
  TGodsFactory=class
  private
    FDb: TdbFactory;
    FMeaUnit: TZQuery;
    FSortInfo: TZQuery;
    procedure SetDb(const Value: TdbFactory);
    procedure SetMeaUnit(const Value: TZQuery);
    procedure SetSortInfo(const Value: TZQuery);
  public
    constructor Create;
    destructor Destroy;override;
    function Check(bcode:string):TRecord_;
    property Db:TdbFactory read FDb write SetDb;
    property MeaUnit:TZQuery read FMeaUnit write SetMeaUnit;
    property SortInfo:TZQuery read FSortInfo write SetSortInfo;
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
      'select BARCODE,GODS_NAME,GODS_SPELL,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,NEW_OUTPRICE,NEW_INPRICE,SORT_ID1,UNIT_ID '+
      'from PUB_GOODSINFO where TENANT_ID=0 and BARCODE=:BARCODE';
    rs.Parambyname('BARCODE').AsString := bcode;
    db.Open(rs);
    if not rs.IsEmpty then
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
  MeaUnit := TZQuery.Create(nil);
  SortInfo := TZQuery.Create(nil);
  Db := TdbFactory.Create;
  if FileExists(ExtractShortPathName(ExtractFilePath(ParamStr(0)))+'basic.db') then
     begin
       Db.Initialize('provider=sqlite-3;databasename='+ExtractShortPathName(ExtractFilePath(ParamStr(0)))+'basic.db');
       Db.Connect;
       MeaUnit.close;
       MeaUnit.SQL.Text := 'select * from PUB_MEAUNITS where TENANT_ID=0';
       Db.Open(MeaUnit);
       SortInfo.close;
       SortInfo.SQL.Text := 'select * from PUB_GOODSSORT where TENANT_ID=0 and SORT_TYPE=1';
       Db.Open(SortInfo);
     end;

end;

destructor TGodsFactory.Destroy;
begin
  MeaUnit.free;
  SortInfo.Free;
  Db.Free;
  inherited;
end;

procedure TGodsFactory.SetDb(const Value: TdbFactory);
begin
  FDb := Value;
end;

procedure TGodsFactory.SetMeaUnit(const Value: TZQuery);
begin
  FMeaUnit := Value;
end;

procedure TGodsFactory.SetSortInfo(const Value: TZQuery);
begin
  FSortInfo := Value;
end;

initialization
  GodsFactory := TGodsFactory.Create;
finalization
  GodsFactory.free;
end.
