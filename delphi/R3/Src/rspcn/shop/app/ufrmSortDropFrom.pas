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
    SelectAll:boolean;
    SelfRoot:boolean;
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
    dllGlobal.CreateGoodsSortTree(rzTree,RelationId,SelfRoot);
end;

procedure TfrmSortDropFrom.rzTreeClick(Sender: TObject);
begin
  inherited;
  if SelectAll then
     begin
      if assigned(rzTree.Selected) and assigned(rzTree.Selected.Data) then
         begin
           SaveObj.Clear;
           TRecord_(rzTree.Selected.Data).CopyTo(SaveObj);
           ModalResult := MROK;
         end;
     end
  else
     begin
       if assigned(rzTree.Selected) and assigned(rzTree.Selected.Data) and (not rzTree.Selected.HasChildren) then
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
  SelectAll := false;
  SelfRoot := false;
end;

procedure TfrmSortDropFrom.FormCreate(Sender: TObject);
begin
  inherited;
  RelationId := '';
  ShowNoSort := true;
  ShowCgtSort := true;
  SelectAll := false;
  SelfRoot := false;
end;

initialization
  frmSortDropFrom := TfrmSortDropFrom.Create(nil);
finalization
  if Assigned(frmSortDropFrom) then FreeAndNil(frmSortDropFrom);
end.
