unit ufrmGoodsInfoDropForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDropForm, ExtCtrls, RzPanel, Grids, DBGridEh, DB, ZDataSet;

type
  TfrmGoodsInfoDropForm = class(TfrmDropForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    function showForm:boolean;override;
  end;

var
  frmGoodsInfoDropForm: TfrmGoodsInfoDropForm;

implementation
uses udllGlobal;
{$R *.dfm}

{ TfrmGoodsInfoDropForm }

function TfrmGoodsInfoDropForm.showForm: boolean;
begin
  result := inherited showForm;
  DataSource1.DataSet := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
end;

procedure TfrmGoodsInfoDropForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  DataSource1.DataSet := nil;
end;

procedure TfrmGoodsInfoDropForm.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if DataSource1.DataSet.IsEmpty then Exit;
  SaveObj.Clear;
  SaveObj.ReadFromDataSet(DataSource1.DataSet);
  ModalResult := MROK;

end;

procedure TfrmGoodsInfoDropForm.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       DBGridEh1CellClick(nil);
     end;
end;

procedure TfrmGoodsInfoDropForm.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := DBGridEh1.FixedColor;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(TZQuery(DataSource1.DataSet).RecNo)),length(Inttostr(TZQuery(DataSource1.DataSet).RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

initialization
  frmGoodsInfoDropForm := TfrmGoodsInfoDropForm.Create(nil);
finalization
  frmGoodsInfoDropForm.Free;
end.
