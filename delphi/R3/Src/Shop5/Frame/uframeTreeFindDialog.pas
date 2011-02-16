unit uframeTreeFindDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, RzButton,
  ComCtrls, RzTreeVw, DB, ZBase;

type
  TframeTreeFindDialog = class(TframeDialogForm)
    fndPanel: TPanel;
    RzPanel5: TRzPanel;
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzTree: TRzTreeView;
    Label8: TLabel;
    edtSearch: TcxTextEdit;
    RzBitBtn4: TRzBitBtn;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure RzTreeKeyPress(Sender: TObject; var Key: Char);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure edtSearchEnter(Sender: TObject);
    procedure RzTreeDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function FindDialog1(AOwner:TForm;DataSet:TDataSet;IDField,LvlField,ShwField,Fmt:string;var rs:TRecord_):boolean;
    class function FindDialog2(AOwner:TForm;DataSet:TDataSet;IDField,PIDField,ShwField:string;var rs:TRecord_):boolean;
  end;

implementation
uses uTreeUtil;
{$R *.dfm}

{ TframeTreeFindDialog }

class function TframeTreeFindDialog.FindDialog1(AOwner:TForm;DataSet: TDataSet; IDField,
  LvlField, ShwField,Fmt: string; var rs: TRecord_): boolean;
begin
  with TframeTreeFindDialog.Create(AOwner) do
    begin
      try
        CreateLevelTree(DataSet,rzTree,Fmt,IDField,ShwField,LvlField);
        result := (ShowModal=MROK);
        if result then
           begin
             TRecord_(rzTree.Selected.Data).CopyTo(rs);
           end;
      finally
        free;
      end;
    end;
end;

procedure TframeTreeFindDialog.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  rzTree.FullExpand;
end;

procedure TframeTreeFindDialog.RzBitBtn3Click(Sender: TObject);
begin
  inherited;
  rzTree.FullCollapse;
end;

procedure TframeTreeFindDialog.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TframeTreeFindDialog.btnOkClick(Sender: TObject);
begin
  inherited;
  if rzTree.Selected = nil then Raise Exception.Create('请在列表中选择后再确定...');
  ModalResult := MROK;
end;

procedure TframeTreeFindDialog.RzTreeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then btnOk.OnClick(nil) else inherited;
end;

procedure TframeTreeFindDialog.edtSearchKeyPress(Sender: TObject;
  var Key: Char);
var
  i:integer;                                                           
  item:TTreeNode;
begin
  inherited;
  if Key<>#13 then Exit;
  item := nil;
  for i:=0 to rzTree.Items.Count -1 do
    begin
      if rzTree.Items[i].Text = edtSearch.Text then
         begin
           rzTree.Items[i].Selected := true;
           Exit;
         end;
      if pos(edtSearch.Text,rzTree.Items[i].Text)>0 then
         begin
           if item=nil then item := rzTree.Items[i];
         end;
    end;
  if item<>nil then item.Selected := true;
end;

procedure TframeTreeFindDialog.edtSearchEnter(Sender: TObject);
begin
  inherited;
  edtSearch.SelectAll;

end;

procedure TframeTreeFindDialog.RzTreeDblClick(Sender: TObject);
begin
  inherited;
  btnOk.OnClick(nil);
end;

class function TframeTreeFindDialog.FindDialog2(AOwner: TForm;
  DataSet: TDataSet; IDField, PIDField, ShwField: string;
  var rs: TRecord_): boolean;
begin
  with TframeTreeFindDialog.Create(AOwner) do
    begin
      try
        CreateParantTree(DataSet,rzTree,IDField,ShwField,PIDField);
        result := (ShowModal=MROK);
        if result then
           begin
             TRecord_(rzTree.Selected.Data).CopyTo(rs);
           end;
      finally
        free;
      end;
    end;
end;

end.
