{-------------------------------------------------------------------------------
  商品分类选择（带供应链）查找对话框:
 ------------------------------------------------------------------------------}
 
unit ufrmSelectGoodSort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeTreeFindDialog, ActnList, Menus, ComCtrls, RzTreeVw,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls,
  ExtCtrls, RzTabs, RzPanel, DB, ZBase,ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmSelectGoodSort = class(TframeTreeFindDialog)
    procedure FormShow(Sender: TObject);
    procedure RzBitBtn4Click(Sender: TObject);
  private
  public
    procedure LoadGoodSortTree;  //创建加载树
    class function FindDialog(AOwner:TForm; var rs:TRecord_):boolean;
  end;
 

implementation

uses
  uGlobal,uTreeUtil;

{$R *.dfm}

class function TfrmSelectGoodSort.FindDialog(AOwner: TForm; var rs: TRecord_): boolean;
begin
  with TfrmSelectGoodSort.Create(AOwner) do
  begin
    try
      LoadGoodSortTree;  //加载树
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

procedure TfrmSelectGoodSort.LoadGoodSortTree;
var
  rs:TZQuery;
  w,i:integer;
  AObj,CurObj:TRecord_;
begin
  ClearTree(rzTree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs.SortedFields := 'RELATION_ID';
  w := -1;
  try
    CurObj:=TRecord_.Create;
    rs.First;
    while not rs.Eof do
    begin
      CurObj.ReadFromDataSet(rs); 
      if w<>CurObj.FieldByName('RELATION_ID').AsInteger then
      begin
        AObj := TRecord_.Create;
        AObj.ReadFromDataSet(rs);
        rzTree.Items.AddObject(nil,rs.FieldbyName('RELATION_NAME').AsString,AObj);
        w := CurObj.FieldByName('RELATION_ID').AsInteger;
      end;
      rs.Next;
    end;
  finally
    CurObj.Free;
  end;
  
  for i:=rzTree.Items.Count-1 downto 0 do
  begin
    rs.Filtered := false;
    rs.filter := 'RELATION_ID='+TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
    rs.Filtered := true;
    rs.SortedFields := 'LEVEL_ID';
    CreateLevelTree(rs,rzTree,'4444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzTree.Items[i]);
  end;
  rzTree.FullExpand;
end;

procedure TfrmSelectGoodSort.FormShow(Sender: TObject);
begin
  inherited;
  edtSearch.SetFocus;
end;

procedure TfrmSelectGoodSort.RzBitBtn4Click(Sender: TObject);
var
  i:integer;
  item:TTreeNode;
begin
  inherited;
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

end.
