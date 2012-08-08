unit ufrmSizeGroupInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, objCommon,
  ComCtrls, RzTreeVw, DB, DBClient,ADODB, cxMaskEdit, cxButtonEdit, ZBase,
  zrComboBoxList, Grids, DBGridEh, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmSizeGroupInfo = class(TframeDialogForm)
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
    edtSORT_SPELL: TcxTextEdit;
    edtSORT_NAME: TcxTextEdit;
    RzPanel4: TRzPanel;
    RzPanel6: TRzPanel;
    CdsSizeInfo: TZQuery;
    CdsSizeGroupInfo: TZQuery;
    CdsSizeGroupRelation: TZQuery;
    DsSizeInfo: TDataSource;
    DBGridEh1: TDBGridEh;
    Label4: TLabel;
    BtnAddSelected: TRzBitBtn;
    BtnSizeGroup: TRzBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    BtnSize: TRzBitBtn;
    procedure edtNAMEPropertiesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure BtnSizeGroupClick(Sender: TObject);
    procedure BtnSizeClick(Sender: TObject);
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
    function IsGroupSizeSame(str:string):boolean;//判断尺码名是否重复
    class function AddDialog(Owner:TForm;var AObj1:TRecord_):boolean;
    procedure Open;
    procedure OpenSizeInfo;
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
uses uTreeUtil,uShopUtil,uGlobal,uFnUtil,uDsUtil, uShopGlobal,ufrmSizeInfo,
  ufrmBasic;
{$R *.dfm}

procedure TfrmSizeGroupInfo.edtNAMEPropertiesChange(Sender: TObject);
var
  AObj:TRecord_;
begin
  inherited;
  if locked then Exit;
  if dbState=dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  if rzTree.Selected.Level = 1 then Exit;
  rzTree.Selected.Text := edtSORT_NAME.Text;
  AObj := TRecord_(rzTree.Selected.Data);
  case flag of
  1:begin
      if CdsSizeGroupInfo.Locate('SORT_ID',AObj.FieldbyName('SORT_ID').AsString,[]) then
         begin
           CdsSizeGroupInfo.Edit;
           CdsSizeGroupInfo.FieldbyName('SORT_NAME').AsString := Trim(edtSORT_NAME.Text);
           CdsSizeGroupInfo.FieldbyName('SORT_SPELL').AsString := fnString.GetWordSpell(Trim(edtSORT_NAME.Text),3);
           CdsSizeGroupInfo.Post;
           AObj.ReadFromDataSet(CdsSizeGroupInfo);
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

procedure TfrmSizeGroupInfo.FormShow(Sender: TObject);
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
      BtnSize.Enabled:=False;
    end;
  end;
  if not ShopGlobal.GetChkRight('200024') then
  begin
    dbState:=dsBrowse;
    BtnSave.Enabled:=False;
    BtnCancel.Enabled:=False;
    BtnDelete.Enabled:=False;
    BtnSizeGroup.Enabled:=False;
    BtnSize.Enabled:=False;
  end;}
  //别的窗体调用此窗体，直接新增组  
  if InFlag=1 then
     Append;
end;

procedure TfrmSizeGroupInfo.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if rzTree.Selected=nil then exit;
  if (rzTree.Selected.Data = nil) then Exit;
  if locked then Exit;
  locked := true;
  CdsSizeInfo.DisableControls;
  try
    ReadFromObject(TRecord_(rzTree.Selected.Data),self);

    CdsSizeInfo.CancelUpdates;;
    CdsSizeInfo.First;
    while not CdsSizeInfo.Eof do
    begin
      CdsSizeInfo.Edit;
      CdsSizeInfo.FieldByName('FLAG').AsInteger := 0;
      CdsSizeInfo.Post;
      CdsSizeInfo.Next;
    end;
    CdsSizeGroupRelation.Filtered := False;
    if rzTree.Selected.Level = 0 then
       CdsSizeGroupRelation.Filter := 'SORT_ID='''+TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString+''''
    else
       CdsSizeGroupRelation.Filter := 'SORT_ID='''+TRecord_(rzTree.Selected.Parent.Data).FieldbyName('SORT_ID').AsString+'''';
    CdsSizeGroupRelation.Filtered := True;
    CdsSizeGroupRelation.First;
    while not CdsSizeGroupRelation.Eof do
    begin
      if CdsSizeInfo.Locate('CODE_ID',CdsSizeGroupRelation.FieldByName('CODE_ID').AsString,[]) then CdsSizeInfo.Delete;
      CdsSizeGroupRelation.Next;
    end;

  finally
    CdsSizeInfo.EnableControls;
    locked := false;
  end;
  flag := rzTree.Selected.Level+1 ;
end;

procedure TfrmSizeGroupInfo.BtnSizeGroupClick(Sender: TObject);
var i:integer;
begin
  for i:=0 to rzTree.Items.Count -1 do
  begin
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
          raise Exception.Create('尺码组'+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString+'的拼音码不能为空!');
        end;
      end;
  end;
  Append;
end;

procedure TfrmSizeGroupInfo.BtnSizeClick(Sender: TObject);
var
  AObj_:TRecord_;
  Root:TTreeNode;
  i:integer;
begin
  //locked := true;
  AObj_ := TRecord_.Create;
  try
    if TfrmSizeInfo.AddDialog(Self,AObj_) then
    begin
       OpenSizeInfo;
       rzTreeChange(Sender,rzTree.Selected);
    end;
    {ReadFromObject(AObj,self);}
  finally
    AObj_.Free;
    //locked := false;
  end;
end;

procedure TfrmSizeGroupInfo.BtnSaveClick(Sender: TObject);
var i,SeqNo:integer;
    rzNode:TTreeNode;
begin
  inherited;
  CdsSizeGroupInfo.First;
  while not CdsSizeGroupInfo.Eof do CdsSizeGroupInfo.Delete;
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
        raise Exception.Create('尺码组'+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString+'的拼音码不能为空!');
      end;

       CdsSizeGroupInfo.Append;
       CdsSizeGroupInfo.FieldByName('SORT_ID').AsString := TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_ID').AsString;
       CdsSizeGroupInfo.FieldByName('SORT_NAME').AsString := TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_NAME').AsString;
       CdsSizeGroupInfo.FieldByName('SORT_SPELL').AsString := TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_SPELL').AsString;
       CdsSizeGroupInfo.FieldByName('TENANT_ID').AsInteger := TRecord_(rzTree.Items[i].Data).FieldbyName('TENANT_ID').AsInteger;
       CdsSizeGroupInfo.FieldByName('SORT_TYPE').AsInteger := TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_TYPE').AsInteger;
       CdsSizeGroupInfo.FieldByName('SEQ_NO').AsInteger := TRecord_(rzTree.Items[i].Data).FieldbyName('SEQ_NO').AsInteger;
       CdsSizeGroupInfo.Post;
       SeqNo := 0;
       CdsSizeGroupRelation.Filtered := False;
       CdsSizeGroupRelation.Filter := 'SORT_ID='''+TRecord_(rzTree.Items[i].Data).FieldbyName('SORT_ID').AsString+'''';
       CdsSizeGroupRelation.Filtered := True;
       CdsSizeGroupRelation.First;
       while not CdsSizeGroupRelation.Eof do
       begin
         Inc(SeqNo);
         CdsSizeGroupRelation.Edit;
         CdsSizeGroupRelation.FieldByName('SEQ_NO').AsInteger := SeqNo;
         CdsSizeGroupRelation.Post;
         CdsSizeGroupRelation.Next;
       end;
    end;
  Factor.BeginBatch;
  try
    Factor.AddBatch(CdsSizeGroupInfo,'TSizeGroupInfo');
    Factor.AddBatch(CdsSizeGroupRelation,'TSizeGroupRelation');
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
     Global.RefreshTable('PUB_SIZE_INFO');
     ModalResult:=MROK;
     exit;
  end;
  Global.RefreshTable('PUB_SIZE_INFO');
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

procedure TfrmSizeGroupInfo.Setflag(const Value: integer);
begin
  Fflag := Value;
  case flag of
  1:begin
      Label1.Caption := '分组名称';
    end;
  2:begin
      Label1.Caption := '尺码名称';
    end;
  end;
end;

procedure TfrmSizeGroupInfo.BtnDeleteClick(Sender: TObject);
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
       if MessageBox(Handle,pchar('是否删除"'+rzTree.Selected.Text+'"尺码组?'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       ID:=TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString;
       DeleteAll(rzTree.Selected);
       rzTree.Selected.Delete;
       if ID<>'' then
       begin
         if CdsSizeGroupInfo.Locate('SORT_ID',ID,[]) then
            CdsSizeGroupInfo.Delete;
       end;
       ButtonChange5;
     end
  else
     begin
       N1Click(Sender);
     end;
end;

procedure TfrmSizeGroupInfo.BtnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmSizeGroupInfo.edtSPELLPropertiesChange(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if locked then Exit;
  if dbState=dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  if rzTree.Selected.Level = 1 then Exit;
  AObj := TRecord_(rzTree.Selected.Data);
  if CdsSizeGroupInfo.Locate('SORT_ID',AObj.FieldbyName('SORT_ID').AsString,[]) then
     begin
       CdsSizeGroupInfo.Edit;
       CdsSizeGroupInfo.FieldbyName('SORT_SPELL').AsString := Trim(edtSORT_SPELL.Text);
       CdsSizeGroupInfo.Post;
       AObj.ReadFromDataSet(CdsSizeGroupInfo);
     end
  else
     Raise Exception.Create('没找到"'+edtSORT_NAME.Text+'"分组');

  BtnSave.Enabled:=True;
  BtnCancel.Enabled:=True;
end;

procedure TfrmSizeGroupInfo.BtnCancelClick(Sender: TObject);
var i:integer;
begin
  inherited;
  i:=MessageBox(Handle,Pchar('是否把数据恢复至上次保存的结果？'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  Cancel(i);
end;

procedure TfrmSizeGroupInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  inherited;
  if BtnSave.Enabled=True then
  begin
    i:=MessageBox(Handle,Pchar('尺码和尺码组档案有修改，是否要保存?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
       abort
    else if i=6 then
    begin
      BtnSaveClick(nil);
      ModalResult:=MROK;
    end;
  end;
end;


function TfrmSizeGroupInfo.IsGroupSizeSame(str: string): boolean;
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

function TfrmSizeGroupInfo.FindNode(Name, ID: string;
  Level: integer): TTreeNode;
var i:Integer;
    tmp:TZQuery;
    ColorGroupID:string;
    rzNode,rzChildNode:TTreeNode;
begin
  Result := nil;
  tmp:=Global.GetZQueryFromName('PUB_SIZE_GROUP');
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

procedure TfrmSizeGroupInfo.SetInFlag(const Value: integer);
begin
  FInFlag := Value;
end;

class function TfrmSizeGroupInfo.AddDialog(Owner: TForm;
  var AObj1: TRecord_): boolean;
var tmp:TZQuery;
begin
  {tmp:=Global.GetZQueryFromName('CA_COMPANY');
  if tmp.Locate('COMP_ID',Global.TENANT_ID,[]) then
  begin
    if tmp.FieldByName('UPCOMP_ID').AsString<>'' then
       raise Exception.Create('不是总店，不能编辑尺码和尺码组!');
  end; }
  //if not ShopGlobal.GetChkRight('200024') then Raise Exception.Create('你没有编辑尺码和尺码组的权限,请和管理员联系.');
  with TfrmSizeGroupInfo.Create(Owner) do
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

procedure TfrmSizeGroupInfo.ButtonChange1;
begin
  edtSORT_NAME.Enabled:=True;
  edtSORT_SPELL.Enabled:=True;
  BtnSave.Enabled:=True;
  BtnCancel.Enabled:=True;
  BtnDelete.Enabled:=True;
  BtnSize.Enabled:=True;
  dbState:=dsEdit;
end;

procedure TfrmSizeGroupInfo.ButtonChange2;
begin
  edtSORT_NAME.Enabled:=True;
  edtSORT_SPELL.Enabled:=True;
  BtnSave.Enabled:=True;
  BtnCancel.Enabled:=True;
  BtnDelete.Enabled:=True;
  dbState:=dsEdit;
end;

procedure TfrmSizeGroupInfo.ButtonChange3;
begin
  BtnSave.Enabled:=False;
  BtnCancel.Enabled:=False;
  BtnSizeGroup.Enabled:=True;
  BtnSize.Enabled:=True;
  BtnDelete.Enabled:=True;
  if rzTree.Items.Count=0 then
  begin
    BtnDelete.Enabled:=False;
    BtnSize.Enabled:=False;
    dbState:=dsBrowse;
    edtSORT_NAME.Text:='';
    edtSORT_SPELL.Text:='';
  end;
end;

procedure TfrmSizeGroupInfo.ButtonChange4;
begin
  BtnSave.Enabled:=False;
  BtnCancel.Enabled:=False;
  BtnSizeGroup.Enabled:=True;
  BtnSize.Enabled:=True;
  BtnDelete.Enabled:=True;
  edtSORT_NAME.Enabled:=True;
  edtSORT_SPELL.Enabled:=True;
  if rzTree.Items.Count=0 then
  begin
    BtnDelete.Enabled:=False;
    BtnSize.Enabled:=False;
    dbState:=dsBrowse;
    edtSORT_NAME.Text:='';
    edtSORT_SPELL.Text:='';
  end;
end;

procedure TfrmSizeGroupInfo.ButtonChange5;
begin
   BtnSave.Enabled:=True;
   BtnCancel.Enabled:=True;
   if rzTree.Items.Count=0 then
   begin
     BtnDelete.Enabled:=False;
     BtnSizeGroup.Enabled:=True;
     BtnSize.Enabled:=False;
     dbState:=dsBrowse;
     edtSORT_NAME.Text:='';
     edtSORT_SPELL.Text:='';
   end;
end;

procedure TfrmSizeGroupInfo.ButtonChange6;
begin
   BtnSave.Enabled:=True;
   BtnCancel.Enabled:=True;
end;

procedure TfrmSizeGroupInfo.InitButton;
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
    BtnSize.Enabled:=False;
    edtSORT_NAME.Enabled:=False;
    edtSORT_SPELL.Enabled:=False;
  end;
  BtnSave.Enabled:=False;
  BtnCancel.Enabled:=False;
end;

procedure TfrmSizeGroupInfo.Open;
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
      Factor.AddBatch(CdsSizeGroupInfo,'TSizeGroupInfo',Params);
      Factor.AddBatch(CdsSizeGroupRelation,'TSizeGroupRelation',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    OpenSizeInfo;
    g := CdsSizeGroupInfo.RecordCount;
    CreateLevelTree(CdsSizeGroupInfo,rzTree,'4444444','SORT_ID','SORT_NAME','LEVEL_ID',1,4);
    CdsSizeGroupInfo.First;
    while not CdsSizeGroupInfo.Eof do
    begin
       for i := 0 to rzTree.Items.Count - 1 do
       begin
         if rzTree.Items[i].Level = 1 then Continue;
         if CdsSizeGroupInfo.FieldByName('SORT_ID').AsString <> TRecord_(rzTree.Items[i].Data).FieldByName('SORT_ID').AsString then Continue;
         //Root := rzTree.Items[i];
         CdsSizeGroupRelation.Filtered := False;
         CdsSizeGroupRelation.Filter := 'SORT_ID='''+TRecord_(rzTree.Items[i].Data).FieldByName('SORT_ID').AsString+'''';
         CdsSizeGroupRelation.Filtered := True;
         CdsSizeGroupRelation.First;
         while not CdsSizeGroupRelation.Eof do
         begin
           AObj1_ := TRecord_.Create;
           AObj1_.ReadFromDataSet(CdsSizeGroupRelation);
           rzTree.Items.AddChildObject(rzTree.Items[i],AObj1_.FieldByName('SORT_NAME').AsString,AObj1_);
           CdsSizeGroupRelation.Next;
         end;
       end;
       CdsSizeGroupInfo.Next;
    end;
  finally
    Params.Free;
  end;

  dbState := dsEdit;
end;

procedure TfrmSizeGroupInfo.Append;
var AObj:TRecord_;
begin
  inherited;
  ButtonChange1;
  inc(g);
  CdsSizeGroupInfo.Append;
  CdsSizeGroupInfo.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  CdsSizeGroupInfo.FieldByName('SORT_ID').AsString := TSequence.NewId;
  CdsSizeGroupInfo.FieldByName('SORT_NAME').AsString := '尺码组名'+inttostr(g);
  CdsSizeGroupInfo.FieldByName('SORT_TYPE').AsInteger := 8;
  CdsSizeGroupInfo.FieldByName('SEQ_NO').AsInteger := g;
  CdsSizeGroupInfo.Post;
  AObj := TRecord_.Create;
  AObj.ReadFromDataSet(CdsSizeGroupInfo);
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

procedure TfrmSizeGroupInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if edtSORT_NAME.Focused then exit;
  if edtSORT_SPELL.Focused then exit;
end;

procedure TfrmSizeGroupInfo.Cancel(i: integer);
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

procedure TfrmSizeGroupInfo.OpenSizeInfo;
var str:String;
begin
  CdsSizeInfo.DisableControls;
  try
    str := 'select 0 as FLAG,SIZE_ID as CODE_ID,SIZE_NAME as SORT_NAME,SIZE_SPELL as SORT_SPELL,SEQ_NO from PUB_SIZE_INFO '+
    ' where TENANT_ID=:TENANT_ID  and COMM not in (''02'',''12'') order by SEQ_NO ';
    CdsSizeInfo.Close;
    CdsSizeInfo.SQL.Text := str;
    CdsSizeInfo.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(CdsSizeInfo);
  finally
    CdsSizeInfo.EnableControls;
  end;
end;

procedure TfrmSizeGroupInfo.BtnAddSelectedClick(Sender: TObject);
var Root:TTreeNode;
    AObj2_:TRecord_;
begin
  inherited;
  if locked then Exit;
  if dbState = dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  if CdsSizeInfo.IsEmpty then Exit;
  if copy(TRecord_(rzTree.Selected.Data).FieldbyName('SORT_NAME').AsString,1,6) = '分组名' then Raise Exception.Create('请输入"'+rzTree.Selected.Text+'"分组名');;
  if rzTree.Selected.Level = 0 then
     Root := rzTree.Selected
  else
     Root := rzTree.Selected.Parent;
  CdsSizeInfo.DisableControls;
  try
    CdsSizeInfo.CommitUpdates;
    CdsSizeInfo.Filtered := False;
    CdsSizeInfo.Filter := 'FLAG=''1''';
    CdsSizeInfo.Filtered := True;
    CdsSizeInfo.First;
    while not CdsSizeInfo.Eof do
    begin
      AObj2_ := TRecord_.Create;
      AObj2_.ReadFromDataSet(CdsSizeInfo);
      rzTree.Items.AddChildObject(Root,AObj2_.FieldByName('SORT_NAME').AsString,AObj2_);
      CdsSizeGroupRelation.Append;
      CdsSizeGroupRelation.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      CdsSizeGroupRelation.FieldByName('CODE_ID').AsString := AObj2_.FieldByName('CODE_ID').AsString;
      CdsSizeGroupRelation.FieldByName('SORT_ID').AsString := TRecord_(Root.Data).FieldByName('SORT_ID').AsString;
      CdsSizeGroupRelation.FieldByName('SORT_TYPE').AsInteger := 8;
      CdsSizeGroupRelation.Post;

      CdsSizeInfo.Next;
    end;
    CdsSizeInfo.First;
    while not CdsSizeInfo.Eof do CdsSizeInfo.Delete;
    CdsSizeInfo.Filtered := False;
  finally
    CdsSizeInfo.EnableControls;
  end;
end;

procedure TfrmSizeGroupInfo.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmSizeGroupInfo.N1Click(Sender: TObject);
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
  CdsSizeInfo.CancelUpdates;
  CdsSizeInfo.DisableControls;
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
         if CdsSizeInfo.Locate('CODE_ID',TRecord_(rzTree.Items[i].Data).FieldByName('CODE_ID').AsString,[]) then
            CdsSizeInfo.Delete;
      end;
    end;

    if CdsSizeGroupRelation.Locate('SORT_ID,CODE_ID',VarArrayOf([SORT_ID,SIZE_ID]),[]) then
       CdsSizeGroupRelation.Delete;

  finally
    CdsSizeInfo.EnableControls;
    locked := False;
  end;
end;

procedure TfrmSizeGroupInfo.N2Click(Sender: TObject);
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
  CdsSizeInfo.CancelUpdates;
  CdsSizeInfo.DisableControls;
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
      if CdsSizeGroupRelation.Locate('SORT_ID,CODE_ID',VarArrayOf([SORT_ID,SIZE_ID]),[]) then
         CdsSizeGroupRelation.Delete;
    end;

    DeleteAll(Root);
    if Root.HasChildren then Root.DeleteChildren; 
  finally
    CdsSizeInfo.EnableControls;
    locked := False;
  end;
end;

end.
