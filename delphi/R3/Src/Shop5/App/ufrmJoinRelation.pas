unit ufrmJoinRelation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, ActnList, Menus, RzTabs, ExtCtrls,
  RzPanel, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, Grids,
  DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmJoinRelation = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    RzPanel1: TRzPanel;
    RzPanel3: TRzPanel;
    DBGridEh1: TDBGridEh;
    edtKey: TcxTextEdit;
    btnFilter: TRzBitBtn;
    Label8: TLabel;
    Cds_Relation: TZQuery;
    Ds_Telation: TDataSource;
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open;
    class function AddDialog(Owner:TForm):Boolean;
  end;

implementation
uses uGlobal, uShopGlobal, ufrmBasic;
{$R *.dfm}

{ TfrmJoinRelation }

class function TfrmJoinRelation.AddDialog(Owner: TForm): Boolean;
begin
  with TfrmJoinRelation.Create(Owner) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmJoinRelation.Open;
var StrWhere:String;
begin
  if Trim(edtKey.Text) <> '' then
    StrWhere := ' and TENANT_ID='+IntToStr(Global.TENANT_ID);
  Cds_Relation.SQL.Text := 'select RELATION_ID,RELATION_NAME,TENANT_ID,RELATION_SPELL from CA_RELATION where COMM not in (''02'',''12'') '+StrWhere;
  Factor.Open(Cds_Relation);  
end;

procedure TfrmJoinRelation.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
