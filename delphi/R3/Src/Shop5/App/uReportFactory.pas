unit uReportFactory;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes;
type

pRCondi=^TRCondi;
TRCondi=record
  Count:integer;
  idx:array [1..30] of string;
  V:array [1..30] of string;
  alled:boolean;
  end;

pRVariant=^RVariant;
RVariant=record
  Value:Variant;
  end;
  
PColumnR=^TColumnR;
TColumnR=record
  //0 字符型 1 数据值
  DataType:integer;
  FieldName:string;
  Title:string;
  Condi:pRCondi;
  end;
  
PRowR=^TRowR;
TRowR=record
  //0 字符型 1 数据值
  DataType:integer;
  FieldName:string;
  Title:string;
  Condi:pRCondi;
  Buffer:array [0..255] of pRVariant;
  end;

TReportFactory=class
  private
    Cols:TList;
    Rows:TList;
  public
    constructor Create;
    destructor Destroy;override;
  end;

implementation

{ TReportFactory }

constructor TReportFactory.Create;
begin
  Cols := TList.Create;
  Rows := TList.Create;
end;

destructor TReportFactory.Destroy;
begin
  Cols.Free;
  Rows.Free;
  inherited;
end;

end.
