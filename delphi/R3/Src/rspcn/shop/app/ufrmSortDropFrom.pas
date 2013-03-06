unit ufrmSortDropFrom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDropForm, ExtCtrls, RzPanel, ComCtrls, RzTreeVw, ImgList, ZBase;

type
  TfrmSortDropFrom = class(TfrmDropForm)
    rzTree: TRzTreeView;
    ImageList1: TImageList;
    procedure rzTreeClick(Sender: TObject);
    procedure rzTreeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    function showForm:boolean;override;
  end;

var
  frmSortDropFrom: TfrmSortDropFrom;

implementation
uses udllGlobal;
{$R *.dfm}

{ TfrmSortDropFrom }

function TfrmSortDropFrom.showForm: boolean;
begin
  result := inherited showForm;
  dllGlobal.CreateGoodsSortTree(rzTree,false);
end;

procedure TfrmSortDropFrom.rzTreeClick(Sender: TObject);
begin
  inherited;
  if assigned(rzTree.Selected) and assigned(rzTree.Selected.Data) and not rzTree.Selected.HasChildren then
     begin
       SaveObj.Clear;
       TRecord_(rzTree.Selected.Data).CopyTo(SaveObj);
       ModalResult := MROK; 
     end;
end;

procedure TfrmSortDropFrom.rzTreeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
     rzTreeClick(nil);
end;

initialization
  frmSortDropFrom := TfrmSortDropFrom.Create(nil);
finalization
  frmSortDropFrom.Free;
end.
