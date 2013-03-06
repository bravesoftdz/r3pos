unit ufrmGoodsInfoDropForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDropForm, ExtCtrls, RzPanel, Grids, DBGridEh, DB;

type
  TfrmGoodsInfoDropForm = class(TfrmDropForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
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

initialization
  frmGoodsInfoDropForm := TfrmGoodsInfoDropForm.Create(nil);
finalization
  frmGoodsInfoDropForm.Free;
end.
