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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  public
    RelationId:string;
    ShowCgtSort:boolean;
    ShowNoSort:boolean;
    ShowSelfRoot:boolean;
    SelectAll:boolean;
    SelectChildren:boolean;
    SelectRootOrLeaf:boolean;
    function showForm:boolean;override;
  end;

var frmSortDropFrom: TfrmSortDropFrom;

implementation

uses udllGlobal;

{$R *.dfm}

function TfrmSortDropFrom.showForm: boolean;
begin
  result := inherited showForm;
  if RelationId = '' then
    dllGlobal.CreateGoodsSortTree(rzTree,false,ShowCgtSort,ShowNoSort)
  else
    dllGlobal.CreateGoodsSortTree(rzTree,RelationId,ShowSelfRoot);
end;

procedure TfrmSortDropFrom.rzTreeClick(Sender: TObject);
begin
  inherited;
  if not Assigned(rzTree.Selected) then Exit;
  if not Assigned(rzTree.Selected.Data) then Exit;

  if SelectAll then
     begin
       SaveObj.Clear;
       TRecord_(rzTree.Selected.Data).CopyTo(SaveObj);
       ModalResult := MROK;
     end
  else if SelectRootOrLeaf then
     begin
       if (not rzTree.Selected.HasChildren) or (rzTree.Selected.Parent = nil) then
          begin
            SaveObj.Clear;
            TRecord_(rzTree.Selected.Data).CopyTo(SaveObj);
            ModalResult := MROK;
          end;
     end
  else if SelectChildren then
     begin
       if rzTree.Selected.Parent <> nil then
          begin
            SaveObj.Clear;
            TRecord_(rzTree.Selected.Data).CopyTo(SaveObj);
            ModalResult := MROK;
          end;
     end
  else
     begin
       if not rzTree.Selected.HasChildren then
          begin
            SaveObj.Clear;
            TRecord_(rzTree.Selected.Data).CopyTo(SaveObj);
            ModalResult := MROK;
          end;
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

procedure TfrmSortDropFrom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  RelationId := '';
  ShowNoSort := true;
  ShowCgtSort := true;
  ShowSelfRoot := false;
  SelectAll := false;
  SelectChildren := false;
  SelectRootOrLeaf := false;
end;

procedure TfrmSortDropFrom.FormCreate(Sender: TObject);
begin
  inherited;
  RelationId := '';
  ShowNoSort := true;
  ShowCgtSort := true;
  ShowSelfRoot := false;
  SelectAll := false;
  SelectChildren := false;
  SelectRootOrLeaf := false;
end;

initialization
  frmSortDropFrom := TfrmSortDropFrom.Create(nil);
finalization
  if Assigned(frmSortDropFrom) then FreeAndNil(frmSortDropFrom);
end.
