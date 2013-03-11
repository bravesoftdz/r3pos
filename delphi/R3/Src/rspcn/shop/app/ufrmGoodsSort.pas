unit ufrmGoodsSort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  StdCtrls, RzButton, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset ,ZBase;

type
  TfrmGoodsSort = class(TfrmWebDialog)
    sortDrop: TcxButtonEdit;
    RzPanel20: TRzPanel;
    RzPanel2: TRzPanel;
    edtSHOP_NEW_OUTPRICE: TcxTextEdit;
    Label1: TLabel;
    RzBitBtn6: TRzBitBtn;
    RzBitBtn7: TRzBitBtn;
    cdsSort: TZQuery;
    procedure RzBitBtn7Click(Sender: TObject);
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure sortDropKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    SortId:string;
    procedure Open(id:string);
    procedure Delete;
    procedure Save;
    class function ShowDialog(AOwner:TForm;sid:string;AObj:TRecord_):boolean;
  end;

implementation

uses ufrmSortDropFrom;

{$R *.dfm}

procedure TfrmGoodsSort.RzBitBtn7Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmGoodsSort.sortDropPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  Obj:TRecord_;
begin
  inherited;
  Obj := TRecord_.Create;
  try
    if frmSortDropFrom.DropForm(sortDrop,obj) then
    begin
      SortId := Obj.FieldbyName('SORT_ID').AsString;
      sortDrop.Text := Obj.FieldbyName('SORT_NAME').AsString;
    end;
  finally
    Obj.Free;
  end;
end;

procedure TfrmGoodsSort.sortDropKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key<>#13) and (Key<>#27) and (Key<>#8) then
     begin
       Key := #0;
       sortDropPropertiesButtonClick(nil,0);
     end;

end;

procedure TfrmGoodsSort.Open(id: string);
begin

end;

procedure TfrmGoodsSort.Save;
begin

end;

procedure TfrmGoodsSort.Delete;
begin

end;

class function TfrmGoodsSort.ShowDialog(AOwner: TForm;sid:string;AObj:TRecord_): boolean;
begin
  with TfrmGoodsSort.Create(AOwner) do
    begin
      try
        result := (ShowModal=mrok);
      finally
        free;
      end;
    end;
end;

end.
 