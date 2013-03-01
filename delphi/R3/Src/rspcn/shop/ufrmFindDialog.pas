unit ufrmFindDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, RzButton, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase;

type
  TfrmFindDialog = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    findText: TcxTextEdit;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    rs: TZQuery;
    DataSource1: TDataSource;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function FindDsDialog(ds:TZQuery;var AObj:TRecord_;listFields:string):boolean;
    class function FindSQLDialog(SQL:string;var AObj:TRecord_;listFields:string):boolean;
  end;

implementation

{$R *.dfm}

{ TfrmFindDialog }

class function TfrmFindDialog.FindDsDialog(ds: TZQuery; var AObj: TRecord_;
  listFields: string): boolean;
begin

end;

class function TfrmFindDialog.FindSQLDialog(SQL: string;
  var AObj: TRecord_; listFields: string): boolean;
begin

end;

procedure TfrmFindDialog.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmFindDialog.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  if DataSource1.DataSet.IsEmpty then Raise Exception.Create('没有数据在选择列表');
  ModalResult := MROK;
end;

end.
