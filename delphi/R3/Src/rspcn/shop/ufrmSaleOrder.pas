unit ufrmSaleOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebForm, StdCtrls, ExtCtrls, RzPanel, Buttons,udataFactory,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGridEh;

type
  TfrmSaleOrder = class(TfrmWebForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Label1: TLabel;
    DBGridEh1: TDBGridEh;
    ZQuery1: TZQuery;
    DataSource1: TDataSource;
    Button2: TButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmSaleOrder.BitBtn1Click(Sender: TObject);
begin
  inherited;
  dataFactory.BeginBatch;
end;

procedure TfrmSaleOrder.Button2Click(Sender: TObject);
begin
  inherited;
  ZQuery1.SQL.Text := 'select * from CA_TENANT';
  dataFactory.Open(ZQuery1);
end;

initialization
  RegisterClass(TfrmSaleOrder);
finalization
  UnRegisterClass(TfrmSaleOrder);
end.
