unit uframeAnalyBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, Grids, DBGridEh;

type
  TframeAnalyBase = class(TFrame)
  private      
  public
    function FindColumn(DBGrid:TDBGridEh; FieldName:string):TColumnEh;  
  end;

implementation

{$R *.dfm}

{ TframeAnalyBase }
 

function TframeAnalyBase.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var
  i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns[i].FieldName = FieldName then
     begin
       result := DBGrid.Columns[i];
       Exit;
     end;
  end;
end;

end.
