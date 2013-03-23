unit ufrmSortDropFrom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDropForm, ExtCtrls, RzPanel, ComCtrls, RzTreeVw, ImgList, ZBase,
  StdCtrls, RzLabel;

type
  TfrmSortDropFrom = class(TfrmDropForm)
    rzTree: TRzTreeView;
    ImageList1: TImageList;
    RzPanel2: TRzPanel;
    RzLabel1: TRzLabel;
    procedure rzTreeClick(Sender: TObject);
    procedure rzTreeKeyPress(Sender: TObject; var Key: Char);
    procedure RzLabel1Click(Sender: TObject);
  private
    FRelationId: string;
    FSelectAll: boolean;
    SAll:boolean;
    procedure SetRelationId(const Value: string);
    procedure SetSelectAll(const Value: boolean);
  public
    function showForm:boolean;override;
    property RelationId:string read FRelationId write SetRelationId;
    property SelectAll:boolean read FSelectAll write SetSelectAll;
  end;

var frmSortDropFrom: TfrmSortDropFrom;

implementation

uses udllGlobal;

{$R *.dfm}

procedure TfrmSortDropFrom.SetRelationId(const Value: string);
begin
  FRelationId := Value;
end;

procedure TfrmSortDropFrom.SetSelectAll(const Value: boolean);
begin
  FSelectAll := Value;
end;

function TfrmSortDropFrom.showForm: boolean;
begin
  result := inherited showForm;
  if RelationId = '' then
    dllGlobal.CreateGoodsSortTree(rzTree,false)
  else
    dllGlobal.CreateGoodsSortTree(rzTree,RelationId);
  RelationId := '';

  SAll := SelectAll;
  SelectAll := false;
end;

procedure TfrmSortDropFrom.rzTreeClick(Sender: TObject);
begin
  inherited;
  if assigned(rzTree.Selected) and assigned(rzTree.Selected.Data)
     and
     ((not SAll and not rzTree.Selected.HasChildren) or SAll) then
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

procedure TfrmSortDropFrom.RzLabel1Click(Sender: TObject);
begin
  inherited;
  SaveObj.Clear;
  ModalResult := MROK;
end;

initialization
  frmSortDropFrom := TfrmSortDropFrom.Create(nil);
finalization
  frmSortDropFrom.Free;
end.
