unit ufrmLocusNoProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, Grids, DBGridEh,
  RzButton, DB, ZDataSet;

type
  TfrmLocusNoProperty = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnExit: TRzBitBtn;
    DataSource1: TDataSource;
    RzBitBtn1: TRzBitBtn;
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    FDataSet: TDataSet;
    FdbState: TDataSetState;
    procedure SetDataSet(const Value: TDataSet);
    { Private declarations }
    procedure InitGrid;
    procedure SetdbState(const Value: TDataSetState);
  public
    { Public declarations }
    property DataSet:TDataSet read FDataSet write SetDataSet;
    property dbState:TDataSetState read FdbState write SetdbState;
  end;

implementation

uses uGlobal;

{$R *.dfm}

procedure TfrmLocusNoProperty.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='LOCUS_NO' then
     begin
       Text := 'ºÏ¼Æ:'+Text;
     end;
end;

procedure TfrmLocusNoProperty.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
  DataSource1.DataSet := Value;
end;

procedure TfrmLocusNoProperty.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(DataSet.RecNo)),length(Inttostr(DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmLocusNoProperty.InitGrid;
function  FindColumn(FieldName:string):TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh1.Columns[i];
           Exit;
         end;
    end;
end;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  inherited;
  Column := FindColumn('UNIT_ID');
  if Column<>nil then
  begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
end;

procedure TfrmLocusNoProperty.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
end;

procedure TfrmLocusNoProperty.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmLocusNoProperty.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  if DataSet.IsEmpty then Exit;
  DataSet.Delete;
end;

procedure TfrmLocusNoProperty.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  RzBitBtn1.Visible := (Value<>dsBrowse);
end;

end.
