unit ufrmColorGroupInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, objCommon,
  ComCtrls, RzTreeVw, DB, DBClient,ADODB, cxMaskEdit, cxButtonEdit, ZBase,
  zrComboBoxList, Grids, DBGridEh, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmColorGroupInfo = class(TframeDialogForm)
    BtnSave: TRzBitBtn;
    BtnExit: TRzBitBtn;
    BtnDelete: TRzBitBtn;
    BtnCancel: TRzBitBtn;
    RzPanel1: TRzPanel;
    rzTree: TRzTreeView;
    RzPanel3: TRzPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    BtnColor: TRzBitBtn;
    edtSORT_SPELL: TcxTextEdit;
    edtSORT_NAME: TcxTextEdit;
    RzPanel4: TRzPanel;
    RzPanel6: TRzPanel;
    CdsColorInfo: TZQuery;
    CdsColorGroupInfo: TZQuery;
    CdsColorGroupRelation: TZQuery;
    DsSizeInfo: TDataSource;
    DBGridEh1: TDBGridEh;
    BtnColorGroup: TRzBitBtn;
    BtnAddSelected: TRzBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Label4: TLabel;
    procedure edtNAMEPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure BtnColorGroupClick(Sender: TObject);
    procedure BtnColorClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnExitClick(Sender: TObject);
    procedure edtSPELLPropertiesChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnAddSelectedClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    Fflag: integer;
    FInFlag: integer;
    procedure Setflag(const Value: integer);
    procedure SetInFlag(const Value: integer);
    { Private declarations }
  public
    CODE_NAME,CODE_ID:string;
    CODE_Level:integer;
    locked:boolean;
    c,g:integer;
    AObj:TRecord_;
    { Public declarations }
    property InFlag:integer read FInFlag write SetInFlag; //1:其它窗体调用这个窗体
    property flag:integer read Fflag write Setflag;
    function FindNode(Name:string;ID: string;Level:integer): TTreeNode;  //找节点
    function IsGroupColorSame(str:string):boolean;//判断颜色名是否重复
    class function AddDialog(Owner:TForm;var AObj1:TRecord_):boolean;
    procedure Open;
    procedure OpenColorInfo;
    procedure InitButton;
    procedure Append;
    procedure Cancel(i:integer);
    procedure ButtonChange1;//新增组按钮按下后，按钮的变化
    procedure ButtonChange2;//新增尺码按钮按下后，按钮的变化
    procedure ButtonChange3;//保存按钮按下后，按钮的变化
    procedure ButtonChange4;//取消按钮按下后，按钮的变化
    procedure ButtonChange5;//删除按钮按下后，删除尺码组,按钮的变化
    procedure ButtonChange6;//删除按钮按下后，删除尺码,按钮的变化
    { Public declarations }
  end;

implementation
uses uTreeUtil,uShopUtil,uGlobal,uFnUtil,uDsUtil, uShopGlobal,ufrmColorInfo,
  ufrmBasic;
{$R *.dfm}

procedure TfrmColorGroupInfo.edtNAMEPropertiesChange(Sender: TObject);
var
  AObj:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002497',3) then Raise Exception.Create('你没有修改颜色组的权限,请和管理员联系.');
  if locked then Exit;
  if dbState=dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  if rzTree.Selected.Level = 1 then Exit;
  rzTree.Selected.Text := edtSORT_NAME.Text;
  AObj := TRecord_(rzTree.Selected.Data);
  case flag of
  1:begin
      if CdsColorGroupInfo.Locate('SORT_ID',AObj.FieldbyName('SORT_ID').AsString,[]) then
         begin
           CdsColorGroupInfo.Edit;
           CdsColorGroupInfo.FieldbyName('SORT_NAME').AsString := Trim(edtSORT_NAME.Text);
           CdsColorGroupInfo.FieldbyName('SORT_SPELL').AsString := fnString.GetWordSpell(Trim(edtSORT_NAME.Text),3);
           CdsColorGroupInfo.Post;
           AObj.ReadFromDataSet(CdsColorGroupInfo);
         end
      else
         Raise Exception.Create('没找到"'+edtSORT_NAME.Text+'"分组');
    end;
  2:begin
      Raise Exception.Create('没找到"'+edtSORT_NAME.Text+'"尺码');
    end;
  end;
  edtSORT_SPELL.Text := AObj.FieldbyName('SORT_SPELL').AsString;
  BtnSave.Enabled:=True;
  BtnCancel.Enabled:=True;
end;

procedure TfrmColorGroupInfo.FormShow(Sender: TObject);
var tmp:TZQuery;
begin
  Open;
  InitButton;
  {tmp:=Global.GetADODataSetFromName('CA_COMPANY');
  if tmp.Locate('COMP_ID',Global.CompanyID,[]) then
  begin
    if tmp.FieldByName('UPCOMP_ID').AsString<>'' then
    begin
      dbState:=dsBrowse;
      BtnSave.Enabled:=False;
      BtnCancel.Enabled:=False;
      BtnDelete.Enabled:=False;
      BtnSizeGroup.Enabled:=False;
      BtnColor.Enabled:=False;
    end;
  end;
  if not ShopGlobal.GetChkRight('200024') then
  begin
    dbState:=dsBrowse;
    BtnSave.Enabled:=False;
    BtnCancel.Enabled:=False;
    BtnDelete.Enabled:=False;
    BtnSizeGroup.Enabled:=False;
    BtnColor.Enabled:=False;
  end;}
  //别的窗体调用此窗体，直接新增组  
  if InFlag=1 then
     Append;
end;

procedure TfrmColorGroupInfo.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if rzTree.Selected=nil then exit;
  if (rzTree.Selected.Data = nil) then Exit;
  if locked then Exit;
  locked := true;
  CdsColorInfo.DisableControls;
  try
    ReadFromObject(TRecord_(rzTree.Selected.Data),self);

    CdsColorInfo.CancelUpdates;;
    CdsColorInfo.First;
    while not CdsColorInfo.Eof do
    begin
      CdsColorInfo.Edit;
      CdsColorInfo.FieldByName('FLAG').AsInteger := 0;
      CdsColorInfo.Post;
      CdsColorInfo.Next;
    end;
    CdsColorGroupRelation.Filtered := False;
    if rzTree.Selected.Level = 0 then
       CdsColorGroupRelation.Filter := 'SORT_ID='''+TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString+''''
    else
       CdsColorGroupRelation.Filter := 'SORT_ID='''+TRecord_(rzTree.Selected.Parent.Data).FieldbyName('SORT_ID').AsString+'''';
    CdsColorGroupRelation.Filtered := True;
    CdsColorGroupRelation.First;
    while not CdsColorGroupRelation.Eof do
    begin
      if CdsColorInfo.Locate('CODE_ID',CdsColorGroupRelation.FieldByName('CODE_ID').AsString,[]) then CdsColorInfo.Delete;
      CdsColorGroupRelation.Next;
    end;
    if rzTree.Selected.Level = 0 then
    begin
       edtSORT_NAME.Enabled := True;
       edtSORT_SPELL.Enabled := True;
    end
    else
    begin
       edtSORT_NAME.Enabled := False;
       edtSORT_SPELL.Enabled := False;
    end;

  finally
    CdsColorInfo.EnableControls;
    locked := false;
  end;
  flag := rzTree.Selected.Level+1 ;
end;

procedure TfrmColorGroupInfo.BtnColorGroupClick(Sender: TObject);
var i:integer;
begin
  if not ShopGlobal.GetChkRight('100002497',2) then Raise Exception.Create('你没有新增颜色组的权限,请和管理员联系.');
  for i:=0 to rzTree.Items.Count -1 do
  begin
    if rzTree.Items[i].Level <> 0 then Continue;
    if copy(TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString,1,6) = '分组名' then
    begin
       rzTree.Items[i].Selected:=True;
       edtSORT_NAME.SetFocus;
       Raise Exception.Create('请输入"'+rzTree.Items[i].Text+'"分组名');
    end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_ID').AsString = '' then
       begin
          if rzTree.Items[i].Level = 0 then
          begin
             rzTree.Items[i].Selected:=True;
             edtSORT_NAME.SetFocus;
             Raise Exception.Create('请输入"'+rzTree.Items[i].Text+'"分组名');
          end;
       end;
      if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString='' then
      begin
        if rzTree.Items[i].Level = 0 then
        begin
           rzTree.Items[i].Selected:=True;
           edtSORT_NAME.SetFocus;
           raise Exception.Create('分组名不能为空！');
        end;
      end;
      if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_SPELL').AsString='' then
      begin
        if rzTree.Items[i].Level = 0 then
        begin
          rzTree.Items[i].Selected:=True;
          edtSORT_SPELL.SetFocus;
          raise Exception.Create('颜色组'+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString+'的拼音码不能为空!');
        end;
      end;
  end;
  Append;
end;

procedure TfrmColorGroupInfo.BtnColorClick(Sender: TObject);
var
  AObj_:TRecord_;
  Root:TTreeNode;
  i:integer;
begin
  //locked := true;
  if not ShopGlobal.GetChkRight('100002483',2) then Raise Exception.Create('你没有新增颜色的权限,请和管理员联系.');
  AObj_ := TRecord_.Create;
  try
    if TfrmColorInfo.AddDialog(Self,AObj_) then
    begin
       OpenColorInfo;
       rzTreeChange(Sender,rzTree.Selected);
    end;
    {ReadFromObject(AObj,self);}
  finally
    AObj_.Free;
    //locked := false;
  end;
end;

procedure TfrmColorGroupInfo.BtnSaveClick(Sender: TObject);
var i,SeqNo:integer;
    rzNode:TTreeNode;
begin
  inherited;
  CdsColorGroupInfo.First;
  while not CdsColorGroupInfo.Eof do CdsColorGroupInfo.Delete;
  for i:=0 to rzTree.Items.Count -1 do
    begin
      if rzTree.Items[i].Level = 1 then Continue;
      if copy(TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString,1,6) = '分组名' then
      begin
         rzTree.Items[i].Selected:=True;
         edtSORT_NAME.SetFocus;
         Raise Exception.Create('请输入"'+rzTree.Items[i].Text+'"分组名');
      end;
      if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_ID').AsString = '' then
      begin
         rzTree.Items[i].Selected:=True;
         edtSORT_NAME.SetFocus;
         Raise Exception.Create('请输入"'+rzTree.Items[i].Text+'"分组名');
      end;
      if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString='' then
      begin
       rzTree.Items[i].Selected:=True;
       edtSORT_NAME.SetFocus;
       raise Exception.Create('分组名不能为空！');
      end;
      if TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_SPELL').AsString='' then
      begin
        rzTree.Items[i].Selected:=True;
        edtSORT_SPELL.SetFocus;
        raise Exception.Create('颜色组'+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString+'的拼音码不能为空!');
      end;

       CdsColorGroupInfo.Append;
       CdsColorGroupInfo.FieldByName('SORT_ID').AsString := TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_ID').AsString;
       CdsColorGroupInfo.FieldByName('SORT_NAME').AsString := TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString;
       CdsColorGroupInfo.FieldByName('SORT_SPELL').AsString := TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_SPELL').AsString;
       CdsColorGroupInfo.FieldByName('TENANT_ID').AsInteger := TRecord_(rzTree.Items[i].Data).FieldbyName('TENANT_ID').AsInteger;
       CdsColorGroupInfo.FieldByName('SORT_TYPE').AsInteger := TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_TYPE').AsInteger;
       CdsColorGroupInfo.FieldByName('SEQ_NO').AsInteger := TRecord_(rzTree.Items[i].Data).FieldbyName('SEQ_NO').AsInteger;
       CdsColorGroupInfo.Post;
       SeqNo := 0;
       CdsColorGroupRelation.Filtered := False;
       CdsColorGroupRelation.Filter := 'SORT_ID='''+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_ID').AsString+'''';
       CdsColorGroupRelation.Filtered := True;
       CdsColorGroupRelation.First;
       while not CdsColorGroupRelation.Eof do
       begin
         Inc(SeqNo);
         CdsColorGroupRelation.Edit;
         CdsColorGroupRelation.FieldByName('SEQ_NO').AsInteger := SeqNo;
         CdsColorGroupRelation.Post;
         CdsColorGroupRelation.Next;
       end;
    end;
  Factor.BeginBatch;
  try
    Factor.AddBatch(CdsColorGroupInfo,'TColorGroupInfo');
    Factor.AddBatch(CdsColorGroupRelation,'TColorGroupRelation');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Cancel(6);
    Raise;
  end;
  //刷新前记录节点
  if rzTree.Items.Count<>0 then
  begin
    if rzTree.Selected.Level=0 then
    begin
       CODE_Level:=0;
       CODE_NAME:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_NAME').AsString;
       CODE_ID:='';
    end
    else
    begin
       CODE_Level:=1;
       CODE_NAME:=TRecord_(rzTree.Selected.Parent.Data).FieldByName('SORT_NAME').AsString;
       CODE_ID:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString;
    end;
  end;
  //别的窗体调用此窗体
  if InFlag=1 then
  begin
     BtnSave.Enabled:=False;
     Global.RefreshTable('PUB_COLOR_GROUP');
     ModalResult:=MROK;
     exit;
  end;
  Global.RefreshTable('PUB_COLOR_GROUP');
  FormShow(nil);
  //找节点
  if rzTree.Items.Count<>0 then
  begin
    rzTree.SetFocus;
    if CODE_NAME<>'' then
    begin
      rzNode:=FindNode(CODE_NAME,CODE_ID,CODE_Level);
      if rzNode<>nil  then
        rzNode.Selected:=True;
    end;
  end;
  ButtonChange3;
end;

procedure TfrmColorGroupInfo.Setflag(const Value: integer);
begin
  Fflag := Value;
  case flag of
  1:begin
      Label1.Caption := '分组名称';
    end;
  2:begin
      Label1.Caption := '颜色名称';
    end;
  end;
end;

procedure TfrmColorGroupInfo.BtnDeleteClick(Sender: TObject);
procedure DeleteAll(Node:TTreeNode);
var C:TTreeNode;
begin
  TRecord_(Node.Data).Free;
  Node.Data := nil;
  C := Node.getFirstChild;
  while C<>nil do
    begin
      DeleteAll(C);
      C := Node.GetNextChild(C);
    end;
end;
var rzNode:TTreeNode;
    ID:string;
begin
  inherited;
  if rzTree.Selected = nil then Exit;
  if (rzTree.Selected.Level=0) then
     begin
       if not ShopGlobal.GetChkRight('100002497',4) then Raise Exception.Create('你没有新增颜色组的权限,请和管理员联系.');
       if MessageBox(Handle,pchar('是否删除"'+rzTree.Selected.Text+'"颜色组?'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       ID:=TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString;
       DeleteAll(rzTree.Selected);
       rzTree.Selected.Delete;
       if ID<>'' then
       begin
         if CdsColorGroupInfo.Locate('SORT_ID',ID,[]) then
            CdsColorGroupInfo.Delete;
       end;
       ButtonChange5;
     end
  else
     begin
       N1Click(Sender);
     end;
  rzTreeChange(Sender,rzTree.Selected);
end;

procedure TfrmColorGroupInfo.BtnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmColorGroupInfo.edtSPELLPropertiesChange(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if locked then Exit;
  if dbState=dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  if rzTree.Selected.Level = 1 then Exit;
  AObj := TRecord_(rzTree.Selected.Data);
  if CdsColorGroupInfo.Locate('SORT_ID',AObj.FieldbyName('SORT_ID').AsString,[]) then
     begin
       CdsColorGroupInfo.Edit;
       CdsColorGroupInfo.FieldbyName('SORT_SPELL').AsString := Trim(edtSORT_SPELL.Text);
       CdsColorGroupInfo.Post;
       AObj.ReadFromDataSet(CdsColorGroupInfo);
     end
  else
     Raise Exception.Create('没找到"'+edtSORT_NAME.Text+'"分组');

  BtnSave.Enabled:=True;
  BtnCancel.Enabled:=True;
end;

procedure TfrmColorGroupInfo.BtnCancelClick(Sender: TObject);
var i:integer;
begin
  inherited;
  i:=MessageBox(Handle,Pchar('是否把数据恢复至上次保存的结果？'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  Cancel(i);
  rzTreeChange(Sender,rzTree.Selected);
end;

procedure TfrmColorGroupInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  inherited;
  if BtnSave.Enabled=True then
  begin
    i:=MessageBox(Handle,Pchar('颜色和颜色组档案有修改，是否要保存?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
       abort
    else if i=6 then
    begin
      BtnSaveClick(nil);
      ModalResult:=MROK;
    end;
  end;
end;


function TfrmColorGroupInfo.IsGroupColorSame(str: string): boolean;
var rzNode,rzNodeChild:TTreeNode;
    i,j:integer;
begin
  result:=False;
  j:=0;
  rzNode:=rzTree.Selected.Parent;
  rzNodeChild:=rzNode.getFirstChild;
  while (rzNodeChild<>nil) do
  begin
    if TRecord_(rzNodeChild.Data).FieldByName('CODE_NAME').AsString=str then
      j:=j+1;
    rzNodeChild:=rzNode.GetNextChild(rzNodeChild);
  end;
  if j>=2 then result:=True;
end;

function TfrmColorGroupInfo.FindNode(Name, ID: string;
  Level: integer): TTreeNode;
var i:Integer;
    tmp:TZQuery;
    ColorGroupID:string;
    rzNode,rzChildNode:TTreeNode;
begin
  Result := nil;
  tmp:=Global.GetZQueryFromName('PUB_COLOR_GROUP');
  if tmp.Locate('SORT_NAME',Name,[]) then
     ColorGroupID:=tmp.FieldByName('SORT_ID').AsString;
  if ID='' then
  begin
    for i:=0 to rzTree.Items.Count -1 do
    begin
        if (UpperCase(NAME)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('SORT_NAME').AsString)) and (rzTree.items[i].Level=Level) then
        begin
          Result := rzTree.Items[i];
          exit;
        end;
    end;
  end
  else
  begin
    for i:=0 to rzTree.Items.Count -1 do
    begin
        if  UpperCase(NAME)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('SORT_NAME').AsString) then
        begin
          rzNode:=rzTree.Items[i];
          rzChildNode:=rzNode.getFirstChild;
          while (rzChildNode<>nil) do
          begin
            if (UpperCase(ID)=UpperCase(TRecord_(rzChildNode.Data).FieldByName('SORT_ID').AsString)) and (rzChildNode.Level=Level) then
            begin
              Result :=rzChildNode;
              exit;
            end;
            rzChildNode:=rzNode.GetNextChild(rzChildNode);
          end;
        end;
    end;
  end;
end;

procedure TfrmColorGroupInfo.SetInFlag(const Value: integer);
begin
  FInFlag := Value;
end;

class function TfrmColorGroupInfo.AddDialog(Owner: TForm;
  var AObj1: TRecord_): boolean;
begin
  if not ShopGlobal.GetChkRight('200024') then Raise Exception.Create('你没有编辑尺码和尺码组的权限,请和管理员联系.');
  with TfrmColorGroupInfo.Create(Owner) do
  begin
    try
      InFlag:=1;
      ShowModal;
      if ModalResult=MROK then
      begin
        if rzTree.Selected.Level=0 then
           TRecord_(rzTree.Selected.Data).CopyTo(AObj1)
        else
           TRecord_(rzTree.Selected.Parent.Data).CopyTo(AObj1);
        result :=True;
      end
      else
        result :=False;
    finally
      free;
    end;
  end;
end;

procedure TfrmColorGroupInfo.ButtonChange1;
begin
  edtSORT_NAME.Enabled:=True;
  edtSORT_SPELL.Enabled:=True;
  BtnSave.Enabled:=True;
  BtnCancel.Enabled:=True;
  BtnDelete.Enabled:=True;
  BtnColor.Enabled:=True;
  dbState:=dsEdit;
end;

procedure TfrmColorGroupInfo.ButtonChange2;
begin
  edtSORT_NAME.Enabled:=True;
  edtSORT_SPELL.Enabled:=True;
  BtnSave.Enabled:=True;
  BtnCancel.Enabled:=True;
  BtnDelete.Enabled:=True;
  dbState:=dsEdit;
end;

procedure TfrmColorGroupInfo.ButtonChange3;
begin
  BtnSave.Enabled:=False;
  BtnCancel.Enabled:=False;
  BtnColorGroup.Enabled:=True;
  BtnColor.Enabled:=True;
  BtnDelete.Enabled:=True;
  if rzTree.Items.Count=0 then
  begin
    BtnDelete.Enabled:=False;
    BtnColor.Enabled:=False;
    dbState:=dsBrowse;
    edtSORT_NAME.Text:='';
    edtSORT_SPELL.Text:='';
  end;
end;

procedure TfrmColorGroupInfo.ButtonChange4;
begin
  BtnSave.Enabled:=False;
  BtnCancel.Enabled:=False;
  BtnColorGroup.Enabled:=True;
  BtnColor.Enabled:=True;
  BtnDelete.Enabled:=True;
  edtSORT_NAME.Enabled:=True;
  edtSORT_SPELL.Enabled:=True;
  if rzTree.Items.Count=0 then
  begin
    BtnDelete.Enabled:=False;
    BtnColor.Enabled:=False;
    dbState:=dsBrowse;
    edtSORT_NAME.Text:='';
    edtSORT_SPELL.Text:='';
  end;
end;

procedure TfrmColorGroupInfo.ButtonChange5;
begin
   BtnSave.Enabled:=True;
   BtnCancel.Enabled:=True;
   if rzTree.Items.Count=0 then
   begin
     BtnDelete.Enabled:=False;
     BtnColorGroup.Enabled:=True;
     BtnColor.Enabled:=False;
     dbState:=dsBrowse;
     edtSORT_NAME.Text:='';
     edtSORT_SPELL.Text:='';
   end;
end;

procedure TfrmColorGroupInfo.ButtonChange6;
begin
   BtnSave.Enabled:=True;
   BtnCancel.Enabled:=True;
end;

procedure TfrmColorGroupInfo.InitButton;
begin
  rzTree.SetFocus;
  if rzTree.Items.Count > 0 then
  begin
    rzTree.SetFocus;
    rzTree.TopItem.Selected := true;
  end;
  if rzTree.Items.Count=0   then
  begin
    BtnDelete.Enabled:=False;
    BtnColor.Enabled:=False;
    edtSORT_NAME.Enabled:=False;
    edtSORT_SPELL.Enabled:=False;
  end;
  BtnSave.Enabled:=False;
  BtnCancel.Enabled:=False;
end;

procedure TfrmColorGroupInfo.Open;
var Params:TftParamList;
    AObj1_:TRecord_;
    Root:TTreeNode;
    i:Integer;
begin
  Params := TftParamList.Create;
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.BeginBatch;
    try
      Factor.AddBatch(CdsColorGroupInfo,'TColorGroupInfo',Params);
      Factor.AddBatch(CdsColorGroupRelation,'TColorGroupRelation',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    OpenColorInfo;
    g := CdsColorGroupInfo.RecordCount;
    CreateLevelTree(CdsColorGroupInfo,rzTree,'4444444','SORT_ID','SORT_NAME','LEVEL_ID',1,4);
    CdsColorGroupInfo.First;
    while not CdsColorGroupInfo.Eof do
    begin
       for i := 0 to rzTree.Items.Count - 1 do
       begin
         if rzTree.Items[i].Level = 1 then Continue;
         if CdsColorGroupInfo.FieldByName('SORT_ID').AsString <> TRecord_(rzTree.Items[i].Data).FieldByName('SORT_ID').AsString then Continue;
         //Root := rzTree.Items[i];
         CdsColorGroupRelation.Filtered := False;
         CdsColorGroupRelation.Filter := 'SORT_ID='''+TRecord_(rzTree.Items[i].Data).FieldByName('SORT_ID').AsString+'''';
         CdsColorGroupRelation.Filtered := True;
         CdsColorGroupRelation.First;
         while not CdsColorGroupRelation.Eof do
         begin
           AObj1_ := TRecord_.Create;
           AObj1_.ReadFromDataSet(CdsColorGroupRelation);
           rzTree.Items.AddChildObject(rzTree.Items[i],AObj1_.FieldByName('SORT_NAME').AsString,AObj1_);
           CdsColorGroupRelation.Next;
         end;
       end;
       CdsColorGroupInfo.Next;
    end;
  finally
    Params.Free;
  end;

  dbState := dsEdit;
end;

procedure TfrmColorGroupInfo.Append;
var AObj:TRecord_;
begin
  inherited;
  ButtonChange1;
  inc(g);
  CdsColorGroupInfo.Append;
  CdsColorGroupInfo.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  CdsColorGroupInfo.FieldByName('SORT_ID').AsString := TSequence.NewId;
  CdsColorGroupInfo.FieldByName('SORT_NAME').AsString := '颜色组名'+inttostr(g);
  CdsColorGroupInfo.FieldByName('SORT_TYPE').AsInteger := 7;
  CdsColorGroupInfo.FieldByName('SEQ_NO').AsInteger := g;
  CdsColorGroupInfo.Post;
  AObj := TRecord_.Create;
  AObj.ReadFromDataSet(CdsColorGroupInfo);
  with rzTree.Items.AddObject(nil,AObj.FieldbyName('SORT_NAME').AsString,AObj) do
     begin
       Selected := true;
       flag := 1;
     end;
  locked := true;
  try
    ReadFromObject(AObj,self);
    edtSORT_NAME.SetFocus;
    edtSORT_NAME.SelectAll;
  finally
    locked := false;
  end;

end;

procedure TfrmColorGroupInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if edtSORT_NAME.Focused then exit;
  if edtSORT_SPELL.Focused then exit;
end;

procedure TfrmColorGroupInfo.Cancel(i: integer);
var rzNode:TTreeNode;
begin
  if i=6 then
  begin
    if rzTree.Items.Count<>0 then
    begin
      if rzTree.Selected.Level=0 then
      begin
         CODE_Level:=0;
         CODE_NAME:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_NAME').AsString;
         CODE_ID:='';
      end
      else
      begin
         CODE_Level:=1;
         CODE_NAME:=TRecord_(rzTree.Selected.Parent.Data).FieldByName('SORT_NAME').AsString;
         CODE_ID:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString;
      end;
    end;
    //Global.RefreshTable('PUB_SIZE_INFO');
    Open;
    InitButton;
    if rzTree.Items.Count<>0 then
    begin
      rzTree.SetFocus;
      if CODE_NAME<>'' then
      begin
        rzNode:=FindNode(CODE_NAME,CODE_ID,CODE_Level);
        if rzNode<>nil  then
          rzNode.Selected:=True;
      end;
    end;
  end;
  ButtonChange4;
end;

procedure TfrmColorGroupInfo.OpenColorInfo;
var str:String;
begin
  CdsColorInfo.DisableControls;
  try
    str := 'select 0 as FLAG,COLOR_ID as CODE_ID,COLOR_NAME as SORT_NAME,COLOR_SPELL as SORT_SPELL,SEQ_NO from PUB_COLOR_INFO '+
    ' where TENANT_ID=:TENANT_ID  and COMM not in (''02'',''12'') order by SEQ_NO ';
    CdsColorInfo.Close;
    CdsColorInfo.SQL.Text := str;
    CdsColorInfo.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(CdsColorInfo);
  finally
    CdsColorInfo.EnableControls;
  end;
end;

procedure TfrmColorGroupInfo.BtnAddSelectedClick(Sender: TObject);
var Root:TTreeNode;
    AObj2_:TRecord_;
begin
  inherited;
  if locked then Exit;
  if dbState = dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  if CdsColorInfo.IsEmpty then Exit;
  if copy(TRecord_(rzTree.Selected.Data).FieldbyName('SORT_NAME').AsString,1,6) = '分组名' then Raise Exception.Create('请输入"'+rzTree.Selected.Text+'"分组名');;
  if rzTree.Selected.Level = 0 then
     Root := rzTree.Selected
  else
     Root := rzTree.Selected.Parent;
  CdsColorInfo.DisableControls;
  try
    CdsColorInfo.CommitUpdates;
    CdsColorInfo.Filtered := False;
    CdsColorInfo.Filter := 'FLAG=''1''';
    CdsColorInfo.Filtered := True;
    CdsColorInfo.First;
    while not CdsColorInfo.Eof do
    begin
      AObj2_ := TRecord_.Create;
      AObj2_.ReadFromDataSet(CdsColorInfo);
      rzTree.Items.AddChildObject(Root,AObj2_.FieldByName('SORT_NAME').AsString,AObj2_);
      CdsColorGroupRelation.Append;
      CdsColorGroupRelation.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      CdsColorGroupRelation.FieldByName('CODE_ID').AsString := AObj2_.FieldByName('CODE_ID').AsString;
      CdsColorGroupRelation.FieldByName('SORT_ID').AsString := TRecord_(Root.Data).FieldByName('SORT_ID').AsString;
      CdsColorGroupRelation.FieldByName('SORT_TYPE').AsInteger := 7;
      CdsColorGroupRelation.Post;

      CdsColorInfo.Next;
    end;
    CdsColorInfo.First;
    while not CdsColorInfo.Eof do CdsColorInfo.Delete;
    CdsColorInfo.Filtered := False;
  finally
    CdsColorInfo.EnableControls;
  end;
end;

procedure TfrmColorGroupInfo.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmColorGroupInfo.N1Click(Sender: TObject);
procedure DeleteAll(Node:TTreeNode);
var C:TTreeNode;
begin
  TRecord_(Node.Data).Free;
  Node.Data := nil;
  C := Node.getFirstChild;
  while C<>nil do
    begin
      DeleteAll(C);
      C := Node.GetNextChild(C);
    end;
end;
var Root:TTreeNode;
    AObj2_:TRecord_;
    SORT_ID,SIZE_ID:String;
    i:Integer;
begin
  inherited;
  if locked then Exit;
  if dbState = dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  if rzTree.Selected.Level = 0 then Exit;
  //if copy(TRecord_(rzTree.Selected.Data).FieldbyName('SORT_NAME').AsString,1,6) = '分组名' then Raise Exception.Create('请输入"'+rzTree.Selected.Text+'"分组名');;
  CdsColorInfo.CancelUpdates;
  CdsColorInfo.DisableControls;
  locked := True;
  try

    SORT_ID := TRecord_(rzTree.Selected.Parent.Data).FieldByName('SORT_ID').AsString;
    SIZE_ID := TRecord_(rzTree.Selected.Data).FieldByName('CODE_ID').AsString;
    DeleteAll(rzTree.Selected);
    rzTree.Selected.Delete;    

    for i := 0 to rzTree.Items.Count - 1 do
    begin
      if rzTree.Items[i].Level = 0 then Continue;
      if TRecord_(rzTree.Items[i].Parent.Data).FieldByName('SORT_ID').AsString = SORT_ID then
      begin
         if CdsColorInfo.Locate('CODE_ID',TRecord_(rzTree.Items[i].Data).FieldByName('CODE_ID').AsString,[]) then
            CdsColorInfo.Delete;
      end;
    end;

    if CdsColorGroupRelation.Locate('SORT_ID,CODE_ID',VarArrayOf([SORT_ID,SIZE_ID]),[]) then
       CdsColorGroupRelation.Delete;

  finally
    CdsColorInfo.EnableControls;
    locked := False;
  end;
  ButtonChange5;
end;

procedure TfrmColorGroupInfo.N2Click(Sender: TObject);
procedure DeleteAll(Node:TTreeNode);
var C:TTreeNode;
begin
  if Node.Level <> 0 then
  begin
     TRecord_(Node.Data).Free;
     Node.Data := nil;
  end;
  C := Node.getFirstChild;
  while C<>nil do
    begin
      DeleteAll(C);
      C := Node.GetNextChild(C);
    end;
end;
var Root,CurNode:TTreeNode;
    AObj2_:TRecord_;
    SORT_ID,SIZE_ID:String;
    i:Integer;
begin
  inherited;
  if locked then Exit;
  if dbState = dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  //if rzTree.Selected.Level = 0 then Exit;
  //if copy(TRecord_(rzTree.Selected.Data).FieldbyName('SORT_NAME').AsString,1,6) = '分组名' then
  CdsColorInfo.CancelUpdates;
  CdsColorInfo.DisableControls;
  locked := True;
  try
    if rzTree.Selected.Level = 0 then
    begin
       SORT_ID := TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString;
       Root := rzTree.Selected;
    end
    else
    begin
       SORT_ID := TRecord_(rzTree.Selected.Parent.Data).FieldByName('SORT_ID').AsString;
       Root := rzTree.Selected.Parent;
    end;

    for i := 0 to rzTree.Items.Count - 1 do
    begin
      if rzTree.Items[i].Level = 0 then Continue;
      if TRecord_(rzTree.Items[i].Parent.Data).FieldByName('SORT_ID').AsString <> SORT_ID then Continue;
      SIZE_ID := TRecord_(rzTree.Items[i].Data).FieldByName('CODE_ID').AsString;
      if CdsColorGroupRelation.Locate('SORT_ID,CODE_ID',VarArrayOf([SORT_ID,SIZE_ID]),[]) then
         CdsColorGroupRelation.Delete;
    end;

    DeleteAll(Root);
    if Root.HasChildren then Root.DeleteChildren; 
  finally
    CdsColorInfo.EnableControls;
    locked := False;
  end;
  ButtonChange5;
end;

end.
