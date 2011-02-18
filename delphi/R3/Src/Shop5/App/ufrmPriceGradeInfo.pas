unit ufrmPriceGradeInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  ComCtrls, RzTreeVw, cxMaskEdit, cxControls, cxContainer, cxEdit, cxTextEdit,
  StdCtrls, RzButton, DB, zBase, Grids, DBGridEh, ValEdit, cxDropDownEdit,
  cxSpinEdit, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmPriceGradeInfo = class(TframeDialogForm)
    rzTree: TRzTreeView;
    Label18: TLabel;
    edtPRICE_ID: TcxTextEdit;
    Label1: TLabel;
    edtPRICE_NAME: TcxTextEdit;
    Label2: TLabel;
    edtPRICE_SPELL: TcxTextEdit;
    Label3: TLabel;
    edtINTEGRAL: TcxTextEdit;
    Label4: TLabel;
    edtAGIO_TYPE: TcxComboBox;
    edtSave: TRzBitBtn;
    edtCancel: TRzBitBtn;
    edtDelete: TRzBitBtn;
    edtExit: TRzBitBtn;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    GroupBox1: TGroupBox;
    Notebook1: TNotebook;
    Label8: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label17: TLabel;
    edtPriceGrade: TRzBitBtn;
    Label7: TLabel;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    edtMINIMUM_PERCENT: TcxSpinEdit;
    edtAGIO_PERCENT: TcxSpinEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    edtINTE_TYPE: TcxComboBox;
    Label14: TLabel;
    Label19: TLabel;
    edtINTE_AMOUNT: TcxTextEdit;
    Label20: TLabel;
    Label24: TLabel;
    cdsPRICEGRADE: TZQuery;
    cds_GoodsPercent: TZQuery;
    RzPanel1: TRzPanel;
    btnAdd: TRzBitBtn;
    btnDetele: TRzBitBtn;
    procedure edtAGIO_TYPEPropertiesChange(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure rzTreeChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure edtSaveClick(Sender: TObject);
    procedure edtPriceGradeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtPRICE_NAMEPropertiesChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtExitClick(Sender: TObject);
    procedure edtDeleteClick(Sender: TObject);
    procedure edtCancelClick(Sender: TObject);
    procedure edtINTE_TYPEPropertiesChange(Sender: TObject);
    procedure edtPRICE_SPELLPropertiesChange(Sender: TObject);
    procedure edtINTEGRALPropertiesChange(Sender: TObject);
    procedure edtINTE_AMOUNTPropertiesChange(Sender: TObject);
    procedure edtAGIO_PERCENTPropertiesChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtMINIMUM_PERCENTPropertiesChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeteleClick(Sender: TObject);
  private
    //IsCompany:Boolean;
    FInFlag: integer;
    procedure SetInFlag(const Value: integer);
    { Private declarations }
  public
    //p:integer;
    locked:boolean;
    PRICE_ID:string;
    { Public declarations }
    procedure Append;
    procedure Open;
    procedure Save;
    procedure InitButton;
    procedure Cancel(i:integer);
    procedure WriteTo(AObj:TRecord_);
    procedure ReadFrom(AObj:TRecord_);
    function  FindNode(ID: string): TTreeNode;
    property InFlag:integer read FInFlag write SetInFlag; //1:其它窗体调用这个窗体
    class function AddDialog(Owner:TForm;var AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm):boolean;
  end;

var
  frmPriceGradeInfo: TfrmPriceGradeInfo;

implementation
uses uGlobal,uTreeutil,uShopUtil,uFnUtil,ufrmSelectGoodSort,uShopGlobal,uDsUtil,Math;
{$R *.dfm}

procedure TfrmPriceGradeInfo.edtAGIO_TYPEPropertiesChange(Sender: TObject);
var id:string;
begin
  inherited;
  id := '0';
  if edtAGIO_TYPE.ItemIndex>0 then
      id:=IntToStr(edtAGIO_TYPE.ItemIndex);
//     id := TRecord_(edtAGIO_TYPE.Properties.Items.Objects[edtAGIO_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString;
  Notebook1.ActivePage:='P'+id;
  if locked then exit;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;  
end;

procedure TfrmPriceGradeInfo.rzTreeChange(Sender: TObject;
  Node: TTreeNode);
var str,id:string;
begin
  inherited;
  if (rzTree.Selected=nil) or (rzTree.Selected.Data = nil) then exit;
  locked := true;
  try
    ReadFrom(TRecord_(rzTree.Selected.Data));  //*************************************
    str:=TRecord_(edtINTE_TYPE.Properties.Items.Objects[edtINTE_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString;
    if  str='0' then
    begin
       if edtINTE_AMOUNT.Text='' then
         edtINTE_AMOUNT.Text:='0';
       Label20.Visible:=False;
       edtINTE_AMOUNT.Enabled:=False;
    end
    else
    begin
      if  str='1' then
      begin
        Label19.Caption:='积一分所需购买';
        Label24.Caption:='元的商品';
      end
      else if str='2' then
      begin
        Label19.Caption:='积一分所需产生';
        Label24.Caption:='元的毛利';
      end
      else if str='3' then
      begin
        Label19.Caption:='积一分所需购买';
        Label24.Caption:='数量的商品';
      end;
      Label20.Visible:=True;
      edtINTE_AMOUNT.Enabled:=True;
    end;
    id := '0';
    if edtAGIO_TYPE.ItemIndex>0 then
       id:=IntToStr(edtAGIO_TYPE.ItemIndex);
//     id := TRecord_(edtAGIO_TYPE.Properties.Items.Objects[edtAGIO_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString;
    Notebook1.ActivePage:='P'+id;
  finally
    locked := false;
  end;
  if not ShopGlobal.GetChkRight('300004') then
  begin
    dbState:=dsBrowse;
    DBGridEh1.ReadOnly:=True;
  end;  
end;

procedure TfrmPriceGradeInfo.ReadFrom(AObj: TRecord_);
  procedure Decode(s:string);
    var vList:TStringList;
        i:integer;
        ID,Str_SORT:string;
    var tmp:TZQuery;
    begin
      //cds_GoodsPercent.Close;

      cds_GoodsPercent.CreateDataSet;

      //tmp:=TZQuery.Create(nil);
      {try
        //tmp.Close;
        //tmp.SQL.Text := 'select SORT_ID,SORT_NAME,100 AGIO_SORTS from PUB_GOODSSORT where COMM not in (''02'',''12'') and length(LEVEL_ID)=4';
        tmp := Global.GetZQueryFromName('PUB_GOODSSORT');
        //Factor.Open(tmp);
        tmp.First;
        while not tmp.Eof do
        begin
          cds_GoodsPercent.Append;
          cds_GoodsPercent.FieldByName('SORT_ID').AsString:=tmp.FieldByName('SORT_ID').AsString;
          cds_GoodsPercent.FieldByName('SORT_NAME').AsString:=tmp.FieldByName('SORT_NAME').AsString;
          cds_GoodsPercent.FieldByName('AGIO_SORTS').AsFloat:=tmp.FieldByName('AGIO_SORTS').AsFloat;
          cds_GoodsPercent.Post;
          tmp.Next;
        end;
      finally
        //tmp.Free;
      end;}
      //cds_GoodsPercent.First;
      vList := TStringList.Create;
      try
        vList.CommaText := s;
        tmp := Global.GetZQueryFromName('PUB_GOODSSORT');
        for i:=0 to vList.Count-1  do
        begin
          Str_SORT := COPY(vList.Strings[i],1,AnsiPos('=',vList.Strings[i])-1);
          //if cds_GoodsPercent.Locate('SORT_NAME',Copy(vList.Strings[i],1,5),[]) then
          if tmp.Locate('SORT_ID',Str_SORT,[]) then
          begin
            cds_GoodsPercent.Append;
            //cds_GoodsPercent.FieldByName('AGIO_SORTS').AsString:=Copy(vList.Strings[i],7,length(vList.Strings[i])-6);
            cds_GoodsPercent.FieldByName('SORT_ID').AsString:=tmp.FieldByName('SORT_ID').AsString;
            cds_GoodsPercent.FieldByName('SORT_NAME').AsString:=tmp.FieldByName('SORT_NAME').AsString;
            cds_GoodsPercent.FieldByName('AGIO_SORTS').AsString:=vList.Values[Str_SORT];
            cds_GoodsPercent.Post;
          end;
        end;
      finally
        vList.Free;
      end;
    end;
var i:integer;
begin
  ReadFromObject(AObj,self);
  //if AObj.FieldByName('AGIO_SORTS').AsString<>'' then
  Decode(AObj.FieldByName('AGIO_SORTS').AsString);
  cds_GoodsPercent.First;
end;

procedure TfrmPriceGradeInfo.WriteTo(AObj: TRecord_);
function EnCode:string;
begin
  cds_GoodsPercent.First;
  while not cds_GoodsPercent.Eof do
  begin
    if Result='' then
      Result:=cds_GoodsPercent.FieldByName('SORT_ID').AsString+'='+ cds_GoodsPercent.FieldByName('AGIO_SORTS').AsString
    else
      Result:=Result+','+cds_GoodsPercent.FieldByName('SORT_ID').AsString+'='+ cds_GoodsPercent.FieldByName('AGIO_SORTS').AsString;
    cds_GoodsPercent.Next;
  end;
end;
begin
  WriteToObject(AObj,self);
  AObj.FieldbyName('AGIO_SORTS').AsString := EnCode;
end;

procedure TfrmPriceGradeInfo.Open;
var
  Params: TftParamList;
begin
  inherited;
  {rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:='select max(PRICE_ID) from PUB_PRICEGRADE ';
    Factor.Open(rs);
    if rs.Fields[0].AsString='' then
       p:=0
    else
      p:=rs.Fields[0].AsInteger;
  finally
    rs.Free;
  end; }
  try
    Params := TftParamList.Create;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsPRICEGRADE.Close;
    Factor.Open(cdsPRICEGRADE,'TPRICEGRADEInfo',Params);
    ClearTree(rzTree);
    CreateLevelTree(cdsPRICEGRADE,rzTree,'44444444','PRICE_ID','PRICE_NAME','LEVEL_ID',1,3);
    dbState := dsEdit;
    rzTree.SetFocus;
    if rzTree.Items.Count > 0 then rzTree.TopItem.Selected := true;
  finally
    Params.Free;
  end;
end;

procedure TfrmPriceGradeInfo.Save;
procedure CheckPercent(AObj:TRecord_);
var vList:TStringList;
    i:integer;
    Str_Sort: String;
begin
  vList:=TStringList.Create;
  try
    vList.CommaText:=AObj.FieldByName('AGIO_SORTS').AsString;
    for i:=0 to vList.Count-1 do
    begin
      Str_Sort := Copy(vList.Strings[i],1,AnsiPos('=',vList.Strings[i])-1);
      if AObj.FieldByName('MINIMUM_PERCENT').AsFloat>StrToFloat(vList.Values[Str_Sort]) then
      begin
        FindNode(AObj.FieldByName('PRICE_ID').AsString).Selected:=True;
        DBGridEh1.SetFocus;
        DBGridEh1.Col:=1;
        raise Exception.Create('"'+AObj.FieldbyName('PRICE_NAME').AsString+'"的分类折扣率不能低于最低折扣率!');
      end;
    end;
  finally
    vList.Free;
  end;
end;
var i:integer;
   AObj:TRecord_;
   rzNode:TTreeNode;
begin
  inherited;
  for i:=0 to rzTree.Items.Count -1 do
  begin
    AObj := TRecord_(rzTree.Items[i].Data);
    if copy(TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_NAME').AsString,1,6) = '等级名' then
       Raise Exception.Create('请输入"'+rzTree.Items[i].Text+'"等级名');
    if TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_ID').AsString = '' then
       begin
          if rzTree.Items[i].Level = 0 then
             Raise Exception.Create('请输入"'+rzTree.Items[i].Text+'"等级名')
       end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_NAME').AsString = '' then
      raise Exception.Create('等级名称不能为空!');
    if TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_SPELL').AsString = '' then
      raise Exception.Create('等级名称'+TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_NAME').AsString+'的拼音码不能为空!');
    if AObj.FieldByName('AGIO_TYPE').AsString='1' then
    begin
      if AObj.FieldByName('AGIO_PERCENT').AsFloat<AObj.FieldByName('MINIMUM_PERCENT').AsFloat then
      begin
        FindNode(AObj.FieldByName('PRICE_ID').AsString).Selected:=True;
        edtAGIO_PERCENT.SetFocus;
        raise Exception.Create('"'+TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_NAME').AsString+'"的指定折扣率不能低于最低折扣率!');
      end;
    end;
    if AObj.FieldByName('AGIO_TYPE').AsString='2' then
      CheckPercent(AObj);
    if cdsPRICEGRADE.Locate('PRICE_ID',AObj.FieldbyName('PRICE_ID').AsString,[]) then cdsPRICEGRADE.Edit else cdsPRICEGRADE.Append;
    AObj.WriteToDataSet(cdsPRICEGRADE);
    cdsPRICEGRADE.Post;
  end;
  //以上判断必填项是否为空及折扣率，并写入 cdsPRICEGRADE 数据集

  try
    Factor.UpdateBatch(cdsPRICEGRADE,'TPRICEGRADEInfo');
  except
    Cancel(6);
    raise;
  end;

  //别的窗体调用此窗体
  Global.RefreshTable('PUB_PRICEGRADE');
  if InFlag=1 then
  begin
     edtSave.Enabled:=False;
     ModalResult:=MROK;
     exit;
  end;

  //begin
  if rzTree.Items.Count>0 then
     PRICE_ID:=TRecord_(rzTree.Selected.Data).FieldByName('PRICE_ID').AsString;
  FormShow(nil);
  if rzTree.Items.Count<>0 then
    begin
      rzTree.SetFocus;
      if PRICE_ID<>'' then
      begin
        rzNode:=FindNode(PRICE_ID);
        if rzNode<>nil  then
          rzNode.Selected:=True;
      end;
    end;
  //从begin开始，这段代码有无的必要性

  edtSave.Enabled:=False;
  edtCancel.Enabled:=False;
  edtPRICEGRADE.Enabled:=True;  //******
  edtDelete.Enabled:=True;
  if rzTree.Items.Count=0 then
    begin
      edtDelete.Enabled:=False;
      dbState:=dsBrowse;
      DBGridEh1.ReadOnly:=True;
    end;
end;

procedure TfrmPriceGradeInfo.Append;
var AObj:TRecord_;
begin
  inherited;
  //inc(p);
  AObj := TRecord_.Create;
  AObj.ReadField(cdsPRICEGRADE);
  AObj.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldByName('PRICE_ID').AsString := TSequence.NewId;
  AObj.FieldByName('PRICE_NAME').AsString := '等级名';
  AObj.FieldByName('INTEGRAL').AsString := '0';
  AObj.FieldByName('INTE_AMOUNT').AsString := '1';
  AObj.FieldByName('INTE_TYPE').AsString:='0';
  AObj.FieldByName('AGIO_TYPE').AsString := '1';
  AObj.FieldByName('AGIO_PERCENT').AsString:='100';
  with rzTree.Items.AddObject(nil,AObj.FieldbyName('PRICE_NAME').AsString,AObj) do
     begin
       Selected := true;
     end;
  locked := true;
  try
    //ReadFrom(AObj);
    edtINTE_TYPE.ItemIndex:=0;
    edtAGIO_TYPE.ItemIndex:=0;
    Label20.Visible:=False;
    edtINTE_AMOUNT.Enabled:=False;
    edtPRICE_NAME.SetFocus;
    edtPRICE_NAME.SelectAll;
  finally
    locked := false;
  end;
  dbState := dsInsert;
  edtDelete.Enabled:=True;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  DBGridEh1.ReadOnly:=False;
end;

procedure TfrmPriceGradeInfo.rzTreeChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  if rzTree.Selected<>nil then WriteTo(TRecord_(rzTree.Selected.Data));  //******************************
end;

procedure TfrmPriceGradeInfo.edtSaveClick(Sender: TObject);
begin
  inherited;
  if rzTree.Selected<>nil then WriteTo(TRecord_(rzTree.Selected.Data));
  Save;
end;

procedure TfrmPriceGradeInfo.edtPriceGradeClick(Sender: TObject);
var i:integer;
begin
  inherited;
  if rzTree.Selected<>nil then WriteTo(TRecord_(rzTree.Selected.Data));
  for i:=0 to rzTree.Items.Count -1 do
  begin
    if copy(TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_NAME').AsString,1,6) = '等级名' then
    begin
       FindNode(TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_ID').AsString).Selected:=True;
       edtPRICE_NAME.SetFocus;
       Raise Exception.Create('请输入"'+rzTree.Items[i].Text+'"等级名');
    end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_ID').AsString = '' then
       begin
          if rzTree.Items[i].Level = 0 then
          begin
             FindNode(TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_ID').AsString).Selected:=True;
             edtPRICE_NAME.SetFocus;
             Raise Exception.Create('请输入"'+rzTree.Items[i].Text+'"等级名');
          end;
       end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_NAME').AsString = '' then
    begin
      FindNode(TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_ID').AsString).Selected:=True;
      edtPRICE_NAME.SetFocus;
      raise Exception.Create('等级名称不能为空!');
    end;
    if TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_SPELL').AsString = '' then
    begin
      FindNode(TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_ID').AsString).Selected:=True;
      edtPRICE_SPELL.SetFocus;
      raise Exception.Create('等级名称'+TRecord_(rzTree.Items[i].Data).FieldbyName('PRICE_NAME').AsString+'的拼音码不能为空!');
    end;
  end;
  Append;
end;

procedure TfrmPriceGradeInfo.FormShow(Sender: TObject);
var tmp:TZQuery;
begin
  inherited;
  Open;
  InitButton;
  {IsCompany:=ShopGlobal.GetIsCompany(Global.UserID);
  if not IsCompany then
  begin
    dbState:=dsBrowse;
    DBGridEh1.ReadOnly:=True;
    edtPriceGrade.Enabled:=False;
    edtSave.Enabled:=False;
    edtCancel.Enabled:=False;
    edtDelete.Enabled:=False;
  end; }
  if not ShopGlobal.GetChkRight('300004') then
  begin
    dbState:=dsBrowse;
    DBGridEh1.ReadOnly:=True;
    edtPriceGrade.Enabled:=False;
    edtSave.Enabled:=False;
    edtCancel.Enabled:=False;
    edtDelete.Enabled:=False;
  end;
  if InFlag=1 then
     Append;
end;

procedure TfrmPriceGradeInfo.edtPRICE_NAMEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if locked then exit;
  if dbState=dsBrowse then Exit;
  if rzTree.Selected = nil then Exit;
  rzTree.Selected.Text := edtPRICE_NAME.Text;
  edtPRICE_SPELL.Text:=Fnstring.GetWordSpell(Trim(edtPRICE_NAME.Text),3);
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmPriceGradeInfo.InitButton;
begin
  if rzTree.Items.Count=0 then
  begin
    edtDelete.Enabled:=False;
    dbState:=dsBrowse;
    DBGridEh1.ReadOnly:=True;
  end;
  edtSave.Enabled:=False;
  edtCancel.Enabled:=False;
end;

procedure TfrmPriceGradeInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  inherited;
  if edtSave.Enabled=True then
  begin
    i:=MessageBox(Handle,Pchar('会员等级档案有修改，是否要保存?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
       abort
    else if i=6 then
    begin
      edtSaveClick(nil);
      ModalResult:=MROK;
    end;
  end;
end;

procedure TfrmPriceGradeInfo.edtExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

function TfrmPriceGradeInfo.FindNode(ID: string): TTreeNode;
var i:Integer;
begin
  Result := nil;
  for i:=0 to rzTree.Items.Count -1 do
  begin
      if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('PRICE_ID').AsString))  then
      begin
        Result := rzTree.Items[i];
        exit;
      end;
  end;

end;

procedure TfrmPriceGradeInfo.edtDeleteClick(Sender: TObject);
var Aobj:TRecord_;
    ID:string;
begin
  inherited;
  if rzTree.Selected = nil then Exit;
  if MessageBox(Handle,pchar('是否删除"'+rzTree.Selected.Text+'"会员等级?'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  if (TRecord_(rzTree.Selected.Data).FieldbyName('PRICE_ID').AsString='---')  or (TRecord_(rzTree.Selected.Data).FieldbyName('PRICE_ID').AsString='000') then
     raise Exception.Create('"'+TRecord_(rzTree.Selected.Data).FieldbyName('PRICE_NAME').AsString+'"会员等级不能被删除!');
  ID:=TRecord_(rzTree.Selected.Data).FieldbyName('PRICE_ID').AsString;
  TObject(rzTree.Selected.Data).Free;
  rzTree.Selected.Delete;
  if ID<>'' then
  begin
    if cdsPRICEGRADE.Locate('PRICE_ID',ID,[]) then
      cdsPRICEGRADE.Delete;
  end;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
  if rzTree.Items.Count=0 then
  begin
    edtDelete.Enabled:=False;
    dbState:=dsBrowse;
    DBGridEh1.ReadOnly:=True;
    try
      Aobj:=TRecord_.Create;
      Aobj.ReadFromDataSet(cdsPRICEGRADE);
      ReadFrom(Aobj);
    finally
      Aobj.Free;
    end;
  end;
end;

procedure TfrmPriceGradeInfo.edtCancelClick(Sender: TObject);
var i:integer;
begin
  inherited;
  i:=MessageBox(Handle,Pchar('是否把数据恢复至上次保存的结果？'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  Cancel(i);
end;


procedure TfrmPriceGradeInfo.edtINTE_TYPEPropertiesChange(Sender: TObject);
var str:string;
begin
  inherited;
  if locked then exit;
  str:=TRecord_(edtINTE_TYPE.Properties.Items.Objects[edtINTE_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString;
  if  str='0' then
  begin
     if edtINTE_AMOUNT.Text='' then
       edtINTE_AMOUNT.Text:='0';
     Label20.Visible:=False;
     edtINTE_AMOUNT.Enabled:=False;
  end
  else
  begin
    if  str='1' then
    begin
      Label19.Caption:='积一分所需购买';
      Label24.Caption:='元的商品';
    end
    else if str='2' then
    begin
      Label19.Caption:='积一分所需产生';
      Label24.Caption:='元的毛利';
    end
    else if str='3' then
    begin
      Label19.Caption:='积一分所需购买';
      Label24.Caption:='数量的商品';
    end;
    Label20.Visible:=True;
    edtINTE_AMOUNT.Enabled:=True;
  end;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmPriceGradeInfo.edtPRICE_SPELLPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if locked then exit;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmPriceGradeInfo.edtINTEGRALPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;  
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmPriceGradeInfo.edtINTE_AMOUNTPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if locked then exit;  
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmPriceGradeInfo.edtAGIO_PERCENTPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if locked then exit;
  if StrToFloatDef(edtAGIO_PERCENT.Value,0)<0 then
    edtAGIO_PERCENT.EditValue:='0';
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmPriceGradeInfo.SetInFlag(const Value: integer);
begin
  FInFlag := Value;
end;

class function TfrmPriceGradeInfo.AddDialog(Owner: TForm;
  var AObj: TRecord_): boolean;
var tmp:TZQuery;
begin
  //if not ShopGlobal.GetIsCompany(Global.UserID) then raise Exception.Create('不是总店，不能编辑会员等级!');
  //if not ShopGlobal.GetChkRight('300004') then Raise Exception.Create('你没有编辑会员等级的权限,请和管理员联系.');
  with TfrmPriceGradeInfo.Create(Owner) do
  begin
    try
      InFlag:=1;
      ShowModal;
      if ModalResult=MROK then
      begin
        if rzTree.Selected.Level=0 then
           TRecord_(rzTree.Selected.Data).CopyTo(AObj)
        else
          TRecord_(rzTree.Selected.Parent.Data).CopyTo(AObj);
        result :=True;
      end
      else
        result :=False;
    finally
      free;
    end;
  end;
end;
procedure TfrmPriceGradeInfo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
{  if edtPRICE_NAME.Focused then exit;
  if edtPRICE_SPELL.Focused then exit;
  if edtINTEGRAL.Focused then exit;
  if edtINTE_TYPE.Focused then exit;
  if edtINTE_AMOUNT.Focused then exit;
  if edtAGIO_PERCENT.Focused then exit;
  if DBGridEh1.Focused then exit;
  if (Key in [ord('A')..ord('Z')])
     or
     (Key in [ord('a')..ord('z')])
     or
     (Key in [ord('0')..ord('9')])
  then
  begin
    edtPRICE_ID.SetFocus;
  end;}
end;

procedure TfrmPriceGradeInfo.Cancel(i: integer);
var rzNode:TTreeNode;
    Aobj:TRecord_;
begin
  if i=6 then
  begin
    if rzTree.Items.Count>0 then
       PRICE_ID:=TRecord_(rzTree.Selected.Data).FieldByName('PRICE_ID').AsString;
    Global.RefreshTable('PUB_PRICEGRADE');
    Open;
    InitButton;
    if rzTree.Items.Count<>0 then
    begin
      rzTree.SetFocus;
      if PRICE_ID<>'' then
      begin
        rzNode:=FindNode(PRICE_ID);
        if rzNode<>nil  then
          rzNode.Selected:=True;
      end;
    end;
    edtSave.Enabled:=False;
    edtCancel.Enabled:=False;
    edtPRICEGRADE.Enabled:=True;
    edtDelete.Enabled:=True;
    if rzTree.Items.Count=0 then
    begin
      edtDelete.Enabled:=False;
      dbState:=dsBrowse;
      DBGridEh1.ReadOnly:=True;
      try
        Aobj:=TRecord_.Create;
        Aobj.ReadFromDataSet(cdsPRICEGRADE);
        ReadFrom(Aobj);
      finally
        Aobj.Free;
      end;
    end;
  end;
end;

procedure TfrmPriceGradeInfo.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if locked then exit;
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmPriceGradeInfo.edtMINIMUM_PERCENTPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if locked then exit;
  if StrToFloatDef(edtMINIMUM_PERCENT.Value,0)<0 then
    edtMINIMUM_PERCENT.EditValue:='0';
  edtSave.Enabled:=True;
  edtCancel.Enabled:=True;
end;

procedure TfrmPriceGradeInfo.btnAddClick(Sender: TObject);
var Aobj_:TRecord_;
begin
  inherited;
  try
    Aobj_ := TRecord_.Create;
    If TfrmSelectGoodSort.FindDialog(Self,Aobj_) then
      begin
        cds_GoodsPercent.Append;
        //Aobj_.WriteToDataSet(cds_GoodsPercent);
        cds_GoodsPercent.FieldByName('SORT_ID').AsString := Aobj_.FieldbyName('SORT_ID').AsString;
        cds_GoodsPercent.FieldByName('SORT_NAME').AsString := Aobj_.FieldByName('SORT_NAME').AsString;
        cds_GoodsPercent.FieldByName('AGIO_SORTS').AsFloat := 0;
        cds_GoodsPercent.Post;
      end;
  finally
    Aobj_.Free;
  end;
end;

procedure TfrmPriceGradeInfo.btnDeteleClick(Sender: TObject);
begin
  inherited;
  if (cds_GoodsPercent.IsEmpty) or (not cds_GoodsPercent.Active) then Exit;
  cds_GoodsPercent.Delete;
  edtPriceGrade.Enabled := False;
  edtDelete.Enabled := False;
  edtCancel.Enabled := True;
  edtSave.Enabled := True;
end;

class function TfrmPriceGradeInfo.ShowDialog(Owner: TForm): boolean;
begin
  with TfrmPriceGradeInfo.Create(Owner) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

end.
