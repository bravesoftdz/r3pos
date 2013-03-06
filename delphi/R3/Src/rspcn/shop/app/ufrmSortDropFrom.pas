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
    FRelationId: string;
    procedure SetRelationId(const Value: string);
  public
    { Public declarations }
    function showForm:boolean;override;
    property RelationId:string read FRelationId write SetRelationId;
  end;

var
  frmSortDropFrom: TfrmSortDropFrom;

implementation
uses udllGlobal;
{$R *.dfm}

{ TfrmSortDropFrom }

procedure TfrmSortDropFrom.SetRelationId(const Value: string);
begin
  FRelationId := Value;
end;

function TfrmSortDropFrom.showForm: boolean;
begin
  result := inherited showForm;
  if RelationId = '' then
    dllGlobal.CreateGoodsSortTree(rzTree,false)
  else
    dllGlobal.CreateGoodsSortTree(rzTree,RelationId);
  RelationId := '';
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
