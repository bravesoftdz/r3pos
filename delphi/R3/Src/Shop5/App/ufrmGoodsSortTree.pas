unit ufrmGoodsSortTree;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, uframeDialogForm, ActnList, Menus, ExtCtrls, RzPanel, cxControls, DB,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, ComCtrls, RzTreeVw, zBase,
  RzTabs, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids;

type
  TfrmGoodsSortTree = class(TframeDialogForm)
    rzTree: TRzTreeView;
    edtSORT1: TRzBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    edtSORT_NAME: TcxTextEdit;
    edtSORT_SPELL: TcxTextEdit;
    edtSORT2: TRzBitBtn;
    edtExit: TRzBitBtn;
    edtSave: TRzBitBtn;
    edtCancel: TRzBitBtn;
    PopupMenu1: TPopupMenu;
    CtrlUp: TAction;
    CtrlDown: TAction;
    CtrlHome: TAction;
    CtrlEnd: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Label11: TLabel;
    cdsGoodSort: TZQuery;
    edtDelete: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edtSORT2Click(Sender: TObject);
    procedure edtSaveClick(Sender: TObject);
    procedure edtExitClick(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure edtSORT_NAMEPropertiesChange(Sender: TObject);
    procedure edtSORT1Click(Sender: TObject);
    procedure edtSORT_SPELLPropertiesChange(Sender: TObject);
    procedure edtDeleteClick(Sender: TObject);
    procedure rzTreeDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure rzTreeStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure rzTreeEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CtrlUpExecute(Sender: TObject);
    procedure CtrlHomeExecute(Sender: TObject);
    procedure CtrlDownExecute(Sender: TObject);
    procedure CtrlEndExecute(Sender: TObject);
    procedure rzTreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSORT_NAMEExit(Sender: TObject);
  private
    FInFlag: integer;
    FSort_Type: Integer;
    procedure SetInFlag(const Value: integer);
    procedure SetSort_Type(const Value: Integer);
    { Private declarations }
  public
    locked,IsShop:boolean;
    DragNode:TTreeNode;
    SORT_ID:string;
    function FindNode(ID: string): TTreeNode;  //找节点
    function IsGoodsSortSame(Level:integer;str: string): boolean; //判断一个等级分类中有没有分类名有没有重复
    procedure InitButton;
    procedure Append;
    procedure Cancel(i:integer);
    procedure Open;
    procedure ButtonChange1;//新增组按钮按下后，按钮的变化
    procedure ButtonChange2;//新增尺码按钮按下后，按钮的变化
    procedure ButtonChange3;//保存按钮按下后，按钮的变化
    procedure ButtonChange4;//取消按钮按下后，按钮的变化
    procedure ButtonChange5;//删除按钮按下后, 按钮的变化
    property  InFlag:integer read FInFlag write SetInFlag;  //1:其它窗体调用这个窗体
    procedure ShowInfo;
    class function AddDialog(Owner:TForm;var AObj:TRecord_; SORTTYPE:Integer=1):boolean;
    class function ShowDialog(Owner:TForm;SORTTYPE:Integer=1):boolean;
    property Sort_Type: Integer read FSort_Type write SetSort_Type;
    { Public declarations }
  end;

implementation
uses uTreeUtil,uShopUtil,uGlobal,uFnUtil,uDsUtil, uShopGlobal, ufrmBasic;
{$R *.dfm}

procedure TfrmGoodsSortTree.FormShow(Sender: TObject);
begin
  ShowInfo;
end;

procedure TfrmGoodsSortTree.edtSORT2Click(Sender: TObject);
var
  AObj:TRecord_;
  i:integer;
begin
  if not ShopGlobal.GetChkRight('32100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  for i:=0 to rzTree.Items.Count -1 do
  begin
    if rzTree.Items[i].Text = '请输入分类名..' then
       begin
         rzTree.Items[i].Selected := true;
         edtSORT_NAME.SetFocus;
         Raise Exception.Create('请输入分类名..');
       end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString='' then
    begin
      rzTree.Items[i].Selected := true;
      edtSORT_NAME.SetFocus;
      raise Exception.Create('分类名称不能为空！');
    end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_SPELL').AsString='' then
    begin
      rzTree.Items[i].Selected := true;
      edtSORT_SPELL.SetFocus;
      raise Exception.Create('分类名称'+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString+'的拼音码不能为空！');
    end;
  end;
  if rzTree.Selected.Level=4 then raise Exception.Create('分类级别不能超过5级...');
  ButtonChange2;
  AObj := TRecord_.Create;
  AObj.ReadField(cdsGoodSort);
  with rzTree.Items.AddChildObject(rzTree.Selected,'请输入分类名..',AObj) do
     begin
       Selected := true;
     end;
  locked := true;
  try
    ReadFromObject(AObj,self);
    edtSORT_NAME.SetFocus;
  finally
    locked := false;
  end;
end;

procedure TfrmGoodsSortTree.edtSaveClick(Sender: TObject);
function GetLevelId(Node:TTreeNode):string;
var P:TTreeNode;
begin
  result := '';
  P := Node;
  while P<>nil do
    begin
      result := formatfloat('0000',P.Index+1)+result;
      P := P.Parent;
    end;
end;
var
  Node:TTreeNode;
  i:integer;
  AObj:TRecord_;
  rzNode:TTreeNode;
begin
  inherited;
  if not ShopGlobal.GetChkRight('32100001',2) then Raise Exception.Create('你没有保存操作的权限,请和管理员联系.');  
  for i:=0 to rzTree.Items.Count -1 do
    begin
      AObj := TRecord_(rzTree.Items[i].Data);
      if AObj.FieldByName('SORT_ID').AsString = '' then
         AObj.FieldByName('SORT_ID').AsString := TSequence.NewId;
      if rzTree.Items[i].Text = '请输入分类名..' then
         begin
           rzTree.Items[i].Selected := true;
           edtSORT_NAME.SetFocus;
           Raise Exception.Create('请输入分类名..或删除空的分类名');
         end;
      if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString='' then
      begin
        rzTree.Items[i].Selected := true;
        edtSORT_NAME.SetFocus;
        raise Exception.Create('分类名称不能为空！');
      end;
      if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_SPELL').AsString='' then
      begin
        rzTree.Items[i].Selected := true;
        edtSORT_SPELL.SetFocus;
        raise Exception.Create('分类名称'+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString+'的拼音码不能为空！');
      end;
      AObj.FieldbyName('LEVEL_ID').AsString := GetLevelId(rzTree.Items[i]);
      AObj.FieldbyName('SORT_TYPE').AsInteger := Sort_Type;
      AObj.FieldbyName('SEQ_NO').AsInteger := rzTree.Items[i].Index +1;
      if rzTree.Items[i].Level>4 then Raise Exception.Create('货品分类级别不能超过5级...');
      // 在此添加同级是否有重名分类
      //
      if cdsGoodSort.Locate('SORT_ID',AObj.FieldbyName('SORT_ID').AsString,[]) then cdsGoodSort.Edit else cdsGoodSort.Append;
      cdsGoodSort.FieldByName('SORT_ID').AsString := AObj.FieldByName('SORT_ID').AsString;
      cdsGoodSort.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      cdsGoodSort.FieldByName('SORT_NAME').AsString := AObj.FieldByName('SORT_NAME').AsString;
      cdsGoodSort.FieldByName('LEVEL_ID').AsString := AObj.FieldByName('LEVEL_ID').AsString;
      cdsGoodSort.FieldByName('SORT_TYPE').AsString := AObj.FieldByName('SORT_TYPE').AsString;
      cdsGoodSort.FieldByName('SORT_SPELL').AsString := AObj.FieldByName('SORT_SPELL').AsString;
      cdsGoodSort.FieldByName('SEQ_NO').AsString := AObj.FieldByName('SEQ_NO').AsString;
      cdsGoodSort.Post;
  end;
  try
    Factor.UpdateBatch(cdsGoodSort,'TGoodsSort');
  except
    Cancel(6);
    raise;
  end;
  if rzTree.Items.Count>0 then
     SORT_ID:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString;
  //别的窗体调用此窗体
  if InFlag=1 then
  begin
     edtSave.Enabled:=False;
     Global.RefreshTable('PUB_GOODSSORT');
     ModalResult:=MROK;
     exit;
  end;
  Global.RefreshTable('PUB_GOODSSORT');
  ShowInfo;
  //找刷新前的节点
  if rzTree.Items.Count<>0 then
  begin
    rzTree.SetFocus;
    if SORT_ID<>'' then
    begin
      rzNode:=FindNode(SORT_ID);
      if rzNode<>nil  then
        rzNode.Selected:=True;
    end;
  end;
  ButtonChange3;
end;

procedure TfrmGoodsSortTree.edtExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmGoodsSortTree.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if rzTree.Selected=nil then exit;
  if (rzTree.Selected.Data = nil) then Exit;
  locked := true;
  try
    ReadFromObject(TRecord_(rzTree.Selected.Data),self);
  finally
    locked := false;
  end;
end;

procedure TfrmGoodsSortTree.edtSORT_NAMEPropertiesChange(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if locked then Exit;
  if dbState=dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  rzTree.Selected.Text := edtSORT_NAME.Text;
  AObj := TRecord_(rzTree.Selected.Data);
  AObj.FieldbyName('SORT_NAME').asString := Trim(edtSORT_NAME.Text);
  AObj.FieldbyName('SORT_SPELL').AsString := FnString.GetWordSpell(Trim(edtSORT_NAME.Text),3);
  edtSORT_SPELL.Text := AObj.FieldbyName('SORT_SPELL').AsString;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmGoodsSortTree.edtSORT1Click(Sender: TObject);
var i:integer;
begin
  if not ShopGlobal.GetChkRight('32100001',2) then Raise Exception.Create('你没有新增的权限,请和管理员联系.');
  for i:=0 to rzTree.Items.Count -1 do
  begin
    if rzTree.Items[i].Text = '请输入分类名..' then
       begin
         rzTree.Items[i].Selected := true;
         edtSORT_NAME.SetFocus;
         Raise Exception.Create('请输入分类名..');
       end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString='' then
    begin
      rzTree.Items[i].Selected := true;
      edtSORT_NAME.SetFocus;
      raise Exception.Create('分类名称不能为空！');
    end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_SPELL').AsString='' then
    begin
      rzTree.Items[i].Selected := true;
      edtSORT_SPELL.SetFocus;
      raise Exception.Create('分类名称'+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString+'的拼音码不能为空！');
    end;
  end;
  Append;
end;

procedure TfrmGoodsSortTree.edtSORT_SPELLPropertiesChange(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if locked then Exit;
  if dbState=dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  AObj := TRecord_(rzTree.Selected.Data);
  AObj.FieldbyName('SORT_SPELL').AsString := Trim(edtSORT_SPELL.Text);
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmGoodsSortTree.edtDeleteClick(Sender: TObject);
procedure DeleteAll(Node:TTreeNode);
var C:TTreeNode;
begin
  if TRecord_(Node.Data).FieldbyName('SORT_ID').AsString<>'' then
  begin
    if cdsGoodSort.Locate('SORT_ID',TRecord_(Node.Data).FieldbyName('SORT_ID').AsString,[]) then
       cdsGoodSort.Delete;
  end;
  TRecord_(Node.Data).Free;
  Node.Data := nil;
  C := Node.getFirstChild;
  while C<>nil do
    begin
      DeleteAll(C);
      C := Node.GetNextChild(C);
    end;
end;
begin
  inherited;
  if not ShopGlobal.GetChkRight('32100001',4) then Raise Exception.Create('你没有删除的权限,请和管理员联系.');  
  if dbState=dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  if not rzTree.Selected.HasChildren then
  begin
     if MessageBox(Handle,Pchar('确定删除"'+rzTree.Selected.Text+'"结点？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit
  end
  else
  begin
     if MessageBox(Handle,Pchar('确定删除"'+rzTree.Selected.Text+'"结点及其下属所有子级分类？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  end;
  DeleteAll(rzTree.Selected);
  rzTree.Selected.Delete;
  ButtonChange5;
end;

procedure TfrmGoodsSortTree.rzTreeDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var Node:TTreeNode;
begin
  inherited;
  Node := rzTree.GetNodeAt(X,Y);
  Accept := Node<>nil;
end;

procedure TfrmGoodsSortTree.rzTreeStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  inherited;
  //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
  DragNode := rzTree.Selected;
end;

procedure TfrmGoodsSortTree.rzTreeEndDrag(Sender, Target: TObject; X,
  Y: Integer);
var Node,rzNodeChild:TTreeNode;
    j:integer;
begin
  inherited;
  if (DragNode=nil) then Exit;
  Node := rzTree.GetNodeAt(X,Y);
  if (Node=nil) then Exit;
  //判断拖曳的时候同级分类有没有重复
  j:=0;
  rzNodeChild:=Node.getFirstChild;
  while (rzNodeChild<>nil) do
  begin
    if TRecord_(rzNodeChild.Data).FieldByName('SORT_NAME').AsString=TRecord_(DragNode.Data).FieldByName('SORT_NAME').AsString then
      j:=j+1;
    rzNodeChild:=Node.GetNextChild(rzNodeChild);
  end;
  if j>=1 then 
     raise Exception.Create(TRecord_(DragNode.Data).FieldByName('SORT_NAME').AsString+'在'+TRecord_(Node.Data).FieldByName('SORT_NAME').AsString+'下级分类中已经存在！');
  DragNode.MoveTo(Node,naAddChild);
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  edtDelete.Enabled:=True;
  edtExit.Enabled:=True;  
end;

procedure TfrmGoodsSortTree.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  inherited;
  if edtSave.Enabled=True then
  begin
    i:=MessageBox(Handle,Pchar('商品分类档案有修改，是否要保存?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
       abort
    else if i=6 then
    begin
      edtSaveClick(nil);
      ModalResult:=MROK;
    end;
  end;
end;

procedure TfrmGoodsSortTree.edtCancelClick(Sender: TObject);
var i:integer;
begin
  inherited;
  i:=MessageBox(Handle,Pchar('是否把数据恢复至上次保存的结果？'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  Cancel(i);
end;

function TfrmGoodsSortTree.FindNode(ID: string): TTreeNode;
var i:Integer;
begin
  Result := nil;
  for i:=0 to rzTree.Items.Count -1 do
  begin
      if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('SORT_ID').AsString))  then
      begin
        Result := rzTree.Items[i];
        exit;
      end;
  end;
end;
function TfrmGoodsSortTree.IsGoodsSortSame(Level: integer;
  str: string): boolean;
var rzNode,rzNodeChild:TTreeNode;
    i,j:integer;
begin
  result:=False;
  if Level>0 then
  begin
    j:=0;
    rzNode:=rzTree.Selected.Parent;
    rzNodeChild:=rzNode.getFirstChild;
    while (rzNodeChild<>nil) do
    begin
      if TRecord_(rzNodeChild.Data).FieldByName('SORT_NAME').AsString=str then
        j:=j+1;
      rzNodeChild:=rzNode.GetNextChild(rzNodeChild);
    end;
    if j>=2 then result:=True;
  end
  else
  begin
    j:=0;
    rzNode:=rzTree.TopItem;
    while (rzNode<>nil) do
    begin
      if TRecord_(rzNode.Data).FieldByName('SORT_NAME').AsString=str then
        j:=j+1;
      rzNode:=rzNode.GetNext;
    end;
    if j>=2 then result:=True;
  end;
end;

procedure TfrmGoodsSortTree.ButtonChange1;
begin
  edtSORT_NAME.Enabled:=True;
  edtSORT2.Enabled:=True;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  edtDelete.Enabled:=True;
end;

procedure TfrmGoodsSortTree.ButtonChange2;
begin
  edtSORT_NAME.Enabled:=True;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  edtDelete.Enabled:=True;
end;

procedure TfrmGoodsSortTree.ButtonChange3;
begin
  edtSave.Enabled:=False;
  edtCancel.Enabled:=False;
  edtSORT1.Enabled:=True;
  edtSORT2.Enabled:=True;
  edtDelete.Enabled:=True;
  if rzTree.Items.Count=0 then
  begin
    edtSORT2.Enabled:=False;
    edtDelete.Enabled:=False;
  end;
end;

procedure TfrmGoodsSortTree.ButtonChange4;
begin
  edtSave.Enabled:=False;
  edtCancel.Enabled:=False;
  edtSORT1.Enabled:=True;
  edtSORT2.Enabled:=True;
  edtDelete.Enabled:=True;
  edtSORT_NAME.Enabled:=True;
  if rzTree.Items.Count=0 then
  begin
    edtSORT_NAME.Text:='';
    edtSORT_SPELL.Text:='';
    edtDelete.Enabled:=False;
    edtSORT2.Enabled:=False;
    dbState:=dsBrowse;
  end;
end;

procedure TfrmGoodsSortTree.ButtonChange5;
begin
  if rzTree.Items.Count=0 then
  begin
    edtSORT_NAME.Text:='';
    edtSORT_SPELL.Text:='';
    edtDelete.Enabled:=False;
    edtSORT1.Enabled:=True;
    edtSORT2.Enabled:=False;
    edtSORT_NAME.Enabled:=False;
  end;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmGoodsSortTree.InitButton;
begin
  if rzTree.Items.Count > 0 then
  begin
//    rzTree.SetFocus;
    rzTree.TopItem.Selected := true;
    rzTree.SetFocus;
  end;
  if rzTree.Items.Count=0   then
  begin
    edtDelete.Enabled:=False;
    edtSORT_NAME.Enabled:=False;
    edtSORT2.Enabled:=False;
  end;
  edtSave.Enabled:=False;
  edtCancel.Enabled:=False;
end;

class function TfrmGoodsSortTree.AddDialog(Owner: TForm;
  var AObj: TRecord_;SORTTYPE:Integer): boolean;
begin
   {if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('不是总店，不能编辑商品分类!');}
   with TfrmGoodsSortTree.Create(Owner) do
    begin
      try
        InFlag:=1;
        Sort_Type := SORTTYPE;
        if not ShopGlobal.GetChkRight('32100001',2) then Raise Exception.Create('你没有编辑'+Caption+'的权限,请和管理员联系.');
        ShowModal;
        if ModalResult=MROK then
        begin
          TRecord_(rzTree.Selected.Data).CopyTo(AObj);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;
procedure TfrmGoodsSortTree.SetInFlag(const Value: integer);
begin
  FInFlag := Value;
end;

procedure TfrmGoodsSortTree.Append;
var
  AObj:TRecord_;
begin
  ButtonChange1;
  AObj := TRecord_.Create;
  AObj.ReadField(cdsGoodSort);
  with rzTree.Items.AddObject(rzTree.Selected,'请输入分类名..',AObj) do
     begin
       Selected := true;
     end;
  locked := true;
  try
    ReadFromObject(AObj,self);
    edtSORT_NAME.SetFocus;
  finally
    locked := false;
  end;
end;

procedure TfrmGoodsSortTree.Open;
var Param: TftParamList;
begin
  Param := TftParamList.Create(nil);
  try
    Param.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Param.ParamByName('SORT_TYPE').AsInteger := Sort_Type;
    cdsGoodSort.Close;
    Factor.Open(cdsGoodSort,'TGoodsSort',Param);
    ClearTree(rzTree);
    CreateLevelTree(cdsGoodSort,rzTree,'4444444444','SORT_ID','SORT_NAME','LEVEL_ID',1,3);
    dbState := dsEdit;
    InitButton;
  finally
    Param.Free;
  end;

end;

procedure TfrmGoodsSortTree.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if edtSORT_NAME.Focused then exit;
  if edtSORT_SPELL.Focused then exit;

end;

procedure TfrmGoodsSortTree.CtrlUpExecute(Sender: TObject);
begin
  inherited;
  if rzTree.Items.Count<=1 then exit;
  if rzTree.Selected.Index=0 then exit;
  //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
  if rzTree.Selected.Index=1 then
    rzTree.Selected.MoveTo(rzTree.Selected.getPrevSibling,naAddFirst)
  else
    rzTree.Selected.MoveTo(rzTree.Selected.getPrevSibling,naInsert);
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  edtDelete.Enabled:=True;
  edtExit.Enabled:=True;
end;

procedure TfrmGoodsSortTree.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  if rzTree.Items.Count<=1 then exit;
  if rzTree.Selected.Index=0 then exit;
  //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
  rzTree.Selected.MoveTo(rzTree.Selected.getPrevSibling,naAddFirst);
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  edtDelete.Enabled:=True;
  edtExit.Enabled:=True;  
end;

procedure TfrmGoodsSortTree.CtrlDownExecute(Sender: TObject);
begin
  inherited;
  if rzTree.Items.Count<=1 then exit;
  if rzTree.Selected.getNextSibling=Nil then exit;
  //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
  rzTree.Selected.getNextSibling.MoveTo(rzTree.Selected,naInsert);
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  edtDelete.Enabled:=True;
  edtExit.Enabled:=True;  
end;

procedure TfrmGoodsSortTree.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  if rzTree.Items.Count<=1 then exit;
  if rzTree.Selected.getNextSibling=Nil then exit;
  //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
  rzTree.Selected.MoveTo(rzTree.Selected.getNextSibling,naAdd);
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  edtDelete.Enabled:=True;
  edtExit.Enabled:=True;
end;

procedure TfrmGoodsSortTree.rzTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and  (Key=VK_UP) then
  begin
    Key:=0;
    //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
    CtrlUpExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_DOWN) then
  begin
    Key:=0;
    //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
    CtrlDownExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_HOME) then
  begin
    Key:=0;
    //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
    CtrlHomeExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_END) then
  begin
    Key:=0;
    //if (not IsShop) or (not ShopGlobal.GetChkRight('200033')) then exit;
    CtrlEndExecute(nil);
  end;
end;

procedure TfrmGoodsSortTree.edtSORT_NAMEExit(Sender: TObject);
var Level:integer;
    SortName:string;
begin
  inherited;
  Level:=rzTree.Selected.Level;
  SortName:=edtSORT_NAME.Text;
  if IsGoodsSortSame(Level,SortName) then
  begin
     if TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString<>'' then
     begin
        ShowInfo;
        FindNode(TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString).Selected:=True;
     end
     else
     begin
       edtSORT_NAME.Text:='';
       rzTree.Selected.Text := edtSORT_NAME.Text;
       TRecord_(rzTree.Selected.Data).FieldByName('SORT_NAME').AsString:='';
       edtSORT_NAME.SetFocus;
     end;
     raise Exception.Create(SortName+'在同级分类中已经存在！');
  end;
end;

procedure TfrmGoodsSortTree.Cancel(i: integer);
var rzNode:TTreeNode;
begin
  if i=6 then
  begin
    if rzTree.Items.Count>0 then
       SORT_ID:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString;
    Global.RefreshTable('PUB_GOODSSORT');
    Open;
    if rzTree.Items.Count>0 then
    begin
      rzTree.SetFocus;
      if SORT_ID<>'' then
      begin
        rzNode:=FindNode(SORT_ID);
        if rzNode<>nil  then
          rzNode.Selected:=True;
      end;
    end;
    ButtonChange4;
  end;
end;

procedure TfrmGoodsSortTree.ShowInfo;
begin
  Open;
  {IsShop:=ShopGlobal.get(Global.UserID);
  if not IsShop then
  begin
    dbState:=dsBrowse;
    edtSave.Enabled:=False;
    edtCancel.Enabled:=False;
    edtDelete.Enabled:=False;
    edtSORT1.Enabled:=False;
    edtSORT2.Enabled:=False;
  end;
  if not ShopGlobal.GetChkRight('200033') then
  begin
    dbState:=dsBrowse;
    edtSave.Enabled:=False;
    edtCancel.Enabled:=False;
    edtDelete.Enabled:=False;
    edtSORT1.Enabled:=False;
    edtSORT2.Enabled:=False;
  end;}
  if InFlag=1 then
    Append;
end;

class function TfrmGoodsSortTree.ShowDialog(Owner: TForm;
  SORTTYPE: Integer): boolean;
begin

  with TfrmGoodsSortTree.Create(Owner) do
    begin
      try
        Sort_Type := SORTTYPE;
        if not ShopGlobal.GetChkRight('32100001',1) then Raise Exception.Create('你没有查看'+Caption+'的权限,请和管理员联系.');
        ShowModal;
        result:=(ModalResult=MROK);
      finally
        Free;
      end;
    end;
end;

procedure TfrmGoodsSortTree.SetSort_Type(const Value: Integer);
var Tmp: TZQuery;
begin
  FSort_Type := Value;

  Tmp := Global.GetZQueryFromName('PUB_PARAMS');
  if Tmp.Locate('TYPE_CODE;CODE_ID',VarArrayOf(['SORT_TYPE',IntToStr(Sort_Type)]),[]) then
    begin
      Self.Caption := Tmp.Fields[1].AsString+'管理';
      RzPage.Pages[0].Caption := Tmp.Fields[1].AsString+'信息';
    end
  else
    raise Exception.Create('无效 SORT_TYPE 值！');

end;

end.
