unit ufrmDbGridEhDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ComCtrls, RzButton, Grids, DBGridEh,
  DB, ADODB, DBGrids;

type
  TfrmDbGridEhDialog = class(TfrmBasic)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    btnCancel: TRzBitBtn;
    btnOK: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    cdsTable: TADODataSet;
    DataSource1: TDataSource;
    cdsTableVisible: TBooleanField;
    cdsTableFieldName: TStringField;
    cdsTableWidth: TIntegerField;
    cdsTableCaption: TStringField;
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ReadDbGrid(Grid:TDbGridEh);
    procedure WriteDbGrid(Grid:TDbGridEh);

    Class function ShowExecute(Grid:TDbGridEh):Boolean;
  end;

implementation

{$R *.dfm}

procedure TfrmDbGridEhDialog.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDbGridEhDialog.ReadDbGrid(Grid: TDbGridEh);
var i:Integer;
begin
  cdsTable.close;
  cdsTable.CreateDataSet;
  for i:=0 to Grid.Columns.Count -1 do
    begin
       if  Grid.Columns[i].FieldName='' then Continue;
       if Grid.Columns[i].Index <= Grid.FrozenCols then Continue;
       cdsTable.Append;
       cdsTable.FieldByName('Visible').AsBoolean := Grid.Columns[i].Visible;
       cdsTable.FieldByName('FieldName').AsString := Grid.Columns[i].FieldName;
       cdsTable.FieldByName('Caption').AsString := Grid.Columns[i].Title.Caption;
       cdsTable.FieldByName('Width').AsInteger := Grid.Columns[i].Width;
       cdsTable.Post;
    end;
end;

class function TfrmDbGridEhDialog.ShowExecute(Grid: TDbGridEh): Boolean;
begin
  with TfrmDbGridEhDialog.Create(Application) do
    begin
      try
        ReadDbGrid(Grid);
        Result := (ShowModal=MROK);
        if Result then
           WriteDbGrid(Grid);
      finally
        Free;
      end;
    end;
end;

procedure TfrmDbGridEhDialog.WriteDbGrid(Grid: TDbGridEh);
var i:Integer;
begin
  for i:=0 to Grid.Columns.Count -1 do
    begin
       if cdsTable.Locate('FieldName',Grid.Columns[i].FieldName,[]) then
          begin
             Grid.Columns[i].Visible := cdsTable.FieldByName('Visible').AsBoolean ;
             Grid.Columns[i].Width := cdsTable.FieldByName('Width').AsInteger;
          end;
    end;
end;

end.
