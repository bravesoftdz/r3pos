unit ufrmStorageTracking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, ExtCtrls, jpeg, RzTabs, RzPanel, Grids, DBGridEh, RzTreeVw, ZBase,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxMaskEdit,
  cxDropDownEdit, cxButtonEdit, zrComboBoxList, FR_Class, PrnDbgeh,
  RzStatus;

type
  TfrmStorageTracking = class(TframeToolForm)
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    CdsStorage: TZQuery;
    RzPanel7: TRzPanel;
    rzTree: TRzTreeView;
    RzPanel6: TRzPanel;
    Panel1: TPanel;
    Grid: TDBGridEh;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    DsStorage: TDataSource;
    RzPanel9: TRzPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label25: TLabel;
    Label12: TLabel;
    btnOk: TRzBitBtn;
    edtUNIT_ID: TcxComboBox;
    edtGoods_Type: TcxComboBox;
    edtGoods_ID: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtSHOP_VALUE: TzrComboBoxList;
    edtSHOP_TYPE: TcxComboBox;
    Label2: TLabel;
    edtGoodsName: TzrComboBoxList;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    PrintDBGridEh1: TPrintDBGridEh;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    Label3: TLabel;
    edtSTOR_AMT: TcxComboBox;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    RzPanel8: TRzPanel;
    Splitter2: TSplitter;
    RzPanel10: TRzPanel;
    rzP2_Tree: TRzTreeView;
    RzPanel11: TRzPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Label4: TLabel;
    RzStatusPane3: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    DBGridEh1: TDBGridEh;
    RzPanel12: TRzPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    RzBitBtn1: TRzBitBtn;
    edtP2_UNIT_ID: TcxComboBox;
    edtP2_Goods_Type: TcxComboBox;
    edtP2_Goods_ID: TzrComboBoxList;
    edtP2_SHOP_ID: TzrComboBoxList;
    edtP2_SHOP_VALUE: TzrComboBoxList;
    edtP2_SHOP_TYPE: TcxComboBox;
    edtP2_GoodsName: TzrComboBoxList;
    RzPanel13: TRzPanel;
    Splitter3: TSplitter;
    RzPanel14: TRzPanel;
    rzP3_Tree: TRzTreeView;
    RzPanel15: TRzPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Label11: TLabel;
    RzPanel16: TRzPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    RzBitBtn2: TRzBitBtn;
    edtP3_UNIT_ID: TcxComboBox;
    edtP3_Goods_Type: TcxComboBox;
    edtP3_Goods_ID: TzrComboBoxList;
    edtP3_SHOP_ID: TzrComboBoxList;
    edtP3_SHOP_VALUE: TzrComboBoxList;
    edtP3_SHOP_TYPE: TcxComboBox;
    edtP3_GoodsName: TzrComboBoxList;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    cdsDemand: TZQuery;
    dsdemand: TDataSource;
    DBGridEh2: TDBGridEh;
    cdsRate: TZQuery;
    dsRate: TDataSource;
    actfrmCalc: TAction;
    ToolButton7: TToolButton;
    RzStatusPane5: TRzStatusPane;
    RzStatusPane6: TRzStatusPane;
    actSetup: TAction;
    ToolButton8: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSHOP_TYPEPropertiesChange(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure edtGoods_TypePropertiesChange(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure GridGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure edtP2_Goods_TypePropertiesChange(Sender: TObject);
    procedure edtP3_Goods_TypePropertiesChange(Sender: TObject);
    procedure edtP2_SHOP_TYPEPropertiesChange(Sender: TObject);
    procedure edtP3_SHOP_TYPEPropertiesChange(Sender: TObject);
    procedure actfrmCalcExecute(Sender: TObject);
    procedure actSetupExecute(Sender: TObject);
  private
    { Private declarations }
    IsEnd: boolean;
    MaxId:string;
    procedure LoadTree(Tree:TRzTreeView);
    procedure InitGrid;
    procedure PrintView;
    function FormatString(TextStr:String;SpaceNum:Integer):String;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
    function TransCalcRate(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function TransUnit(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function TransPrice(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function EncodeSql(ID:String):String;
    function EncodeSql2(ID:String):String;
    function EncodeSql3(ID:String):String;
    procedure AddGoodTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111100000000000000');
    procedure AddGoodsIDItems(edtGoods_ID:TzrComboboxList);
    procedure Open(ID:String);
    procedure Open2(ID:String);
    procedure Open3(ID:String);
    procedure Shop_Type_Change(edtSHOP_VALUE:TzrComboBoxList);
  public
    { Public declarations }
  end;


implementation
uses uTreeUtil,uGlobal, uShopGlobal,uCtrlUtil,uShopUtil,uFnUtil,ufrmEhLibReport,uDsUtil,
  ObjCommon,ufrmBasic, Math, ufrmCostCalc, ufrmOptionDefine;
{$R *.dfm}

{ TfrmStorageTrackingWarning }

function TfrmStorageTracking.FindColumn(DBGrid: TDBGridEh;
  FieldName: String): TColumnEh;
var i:Integer;
begin
  Result := nil;
  for i:=0 to DBGrid.Columns.Count-1 do
    begin
      if DBGrid.Columns.Items[i].FieldName = FieldName then
        begin
          Result := DBGrid.Columns[i];
          Exit;
        end;
    end;
end;

procedure TfrmStorageTracking.InitGrid;
var rs:TZQuery;
    Column:TColumnEh;
begin
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtGoodsName.DataSet := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtUNIT_ID.ItemIndex := 0;
  edtGoods_Type.ItemIndex := 0;
  edtSHOP_TYPE.ItemIndex := 0;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;

  edtP2_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtP2_GoodsName.DataSet := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtP2_UNIT_ID.ItemIndex := 0;
  edtP2_Goods_Type.ItemIndex := 0;
  edtP2_SHOP_TYPE.ItemIndex := 0;
  edtP2_SHOP_ID.KeyValue := Global.SHOP_ID;
  edtP2_SHOP_ID.Text := Global.SHOP_NAME;

  edtP3_SHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtP3_GoodsName.DataSet := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtP3_UNIT_ID.ItemIndex := 0;
  edtP3_Goods_Type.ItemIndex := 0;
  edtP3_SHOP_TYPE.ItemIndex := 0;
  edtP3_SHOP_ID.KeyValue := Global.SHOP_ID;
  edtP3_SHOP_ID.Text := Global.SHOP_NAME;

  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(Grid,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;

  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(DBGridEh1,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;

  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(DBGridEh2,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;

{  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select REGION_ID from CA_SHOP_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='+QuotedStr(Global.SHOP_ID);
    Factor.Open(rs);
    if rs.FieldByName('REGION_ID').AsString <> '' then
      begin
        edtSHOP_VALUE.Text:=TdsFind.GetNameByID(Global.GetZQueryFromName('PUB_REGION_INFO'),'CODE_ID','CODE_NAME',rs.FieldByName('REGION_ID').AsString);
        edtSHOP_VALUE.KeyValue := rs.FieldByName('REGION_ID').AsString;
      end;
  finally
    rs.Free;
  end;   }
  LoadTree(rzTree);
  LoadTree(rzP2_Tree);
  LoadTree(rzP3_Tree);
end;

procedure TfrmStorageTracking.LoadTree(Tree:TRzTreeView);
var rs:TZQuery;
    i,j:Integer;
    Aobj:TRecord_;
begin
  ClearTree(Tree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs.SortedFields := 'RELATION_ID';
  j:=-1;
  rs.First;
  while not rs.Eof do
    begin
      if (j <> rs.FieldByName('RELATION_ID').AsInteger) then
        begin
          Aobj := TRecord_.Create;
          Aobj.ReadFromDataSet(rs);
          Aobj.FieldByName('LEVEL_ID').AsString := '';
          Aobj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
          Tree.Items.AddObject(nil,Aobj.FieldbyName('SORT_NAME').AsString,Aobj);
          j := Aobj.FieldbyName('RELATION_ID').AsInteger;
        end;
      rs.Next;
    end;
  for i:=Tree.Items.Count-1 downto 0 do
    begin
      rs.Filtered := False;
      rs.Filter := 'RELATION_ID='+TRecord_(Tree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
      rs.Filtered := True;
      rs.SortedFields := 'LEVEL_ID';
      CreateLevelTree(rs,Tree,'44444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',Tree.Items[i]);
    end;
  AddRoot(Tree,'所有分类');
end;

procedure TfrmStorageTracking.FormCreate(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 0;
  edtSTOR_AMT.ItemIndex := 0;
  TDbGridEhSort.InitForm(Self);
  AddGoodTypeItems(edtGoods_Type);
  AddGoodTypeItems(edtP2_Goods_Type);
  AddGoodTypeItems(edtP3_Goods_Type);
  InitGrid;
  if ShopGlobal.GetVersionFlag <> 1 then
    begin
      Grid.Columns.Items[7].free;
      Grid.Columns.Items[6].free;
    end;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    edtSHOP_ID.Properties.ReadOnly := False;
    edtSHOP_ID.KeyValue := Global.SHOP_ID;
    edtSHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;

  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    edtP2_SHOP_ID.Properties.ReadOnly := False;
    edtP2_SHOP_ID.KeyValue := Global.SHOP_ID;
    edtP2_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,edtP2_SHOP_ID.Style);
    edtP2_SHOP_ID.Properties.ReadOnly := True;
  end;

  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    edtP3_SHOP_ID.Properties.ReadOnly := False;
    edtP3_SHOP_ID.KeyValue := Global.SHOP_ID;
    edtP3_SHOP_ID.Text := Global.SHOP_NAME;
    SetEditStyle(dsBrowse,edtP3_SHOP_ID.Style);
    edtP3_SHOP_ID.Properties.ReadOnly := True;
  end;


  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label12.Caption := '仓库群组';
      Label21.Caption := '仓库名称';
    end;
end;

procedure TfrmStorageTracking.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(Self);
end;

function TfrmStorageTracking.EncodeSql(ID: String): String;
var StrSql,StrWhere,StrJoin:String;
    Item_Index:Integer;
begin
  case Factor.iDbType of
    0: StrJoin := '+';
    1,4,5: StrJoin := '||';
  end;
  StrWhere := ' A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and C.COMM not in (''02'',''12'') ';
  if ID <> '' then
    StrWhere := StrWhere + ' and A.GODS_ID>'+QuotedStr(ID);
  if edtSHOP_TYPE.ItemIndex = 0 then
    begin
      if edtSHOP_VALUE.asString <> '' then
         begin
           if FnString.TrimRight(edtSHOP_VALUE.asString,2)<>'00' then
              StrWhere := StrWhere + ' and B.REGION_ID = '+QuotedStr(edtSHOP_VALUE.AsString+'')
           else
              StrWhere := StrWhere + ' and B.REGION_ID like '+QuotedStr(GetRegionId(edtSHOP_VALUE.AsString)+'%');
         end;
    end
  else
    begin
      if edtSHOP_VALUE.asString <> '' then
        StrWhere := StrWhere + ' and B.SHOP_TYPE='+QuotedStr(edtSHOP_VALUE.AsString);    
    end;

  if rzTree.Selected <> nil then
    begin
      if rzTree.Selected.Level > 1 then
        StrWhere := StrWhere + ' and C.LEVEL_ID like '+QuotedStr(TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString)+StrJoin+'''%'' and C.RELATION_ID='+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString
      else
      if rzTree.Selected.Level > 0 then
        StrWhere := StrWhere + ' and C.RELATION_ID='+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    end;
  Item_Index := StrToIntDef(Trim(TRecord_(edtGoods_Type.Properties.Items.Objects[edtGoods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
  case Item_Index of
    2:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID2='+QuotedStr(edtGoods_ID.AsString);
    end;
    3:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID3='+QuotedStr(edtGoods_ID.AsString);
    end;
    4:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID4='+QuotedStr(edtGoods_ID.AsString);
    end;
    5:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID5='+QuotedStr(edtGoods_ID.AsString);
    end;
    6:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID6='+QuotedStr(edtGoods_ID.AsString);
    end;
  end;
  if edtGoodsName.AsString<>'' then
    StrWhere := StrWhere + ' and A.GODS_ID='+QuotedStr(edtGoodsName.AsString);
  if edtSHOP_ID.AsString<>'' then
    StrWhere := StrWhere + ' and A.SHOP_ID='+QuotedStr(edtSHOP_ID.AsString);

  case edtSTOR_AMT.ItemIndex of
  1: StrWhere := StrWhere + ' and A.AMOUNT<>0';
  2: StrWhere := StrWhere + ' and A.AMOUNT>0';
  3: StrWhere := StrWhere + ' and A.AMOUNT=0';
  4: StrWhere := StrWhere + ' and A.AMOUNT<0';
  end;

  if StrWhere <> '' then StrWhere :=' where '+ StrWhere;

  StrSql :=
  'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02,A.NEAR_INDATE,A.NEAR_OUTDATE,A.AMOUNT/(cast('+TransCalcRate(edtUNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0) as AMOUNT,D.AMOUNT/(cast('+TransCalcRate(edtUNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0) as ROAD_AMT,'+TransPrice(edtUNIT_ID.ItemIndex,'C','NEW_OUTPRICE')+
  ',B.SHOP_NAME,C.GODS_CODE,C.GODS_NAME,C.BARCODE as CALC_BARCODE,'+TransUnit(edtUNIT_ID.ItemIndex,'C','UNIT_ID')+' '+
  ' from STO_STORAGE A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSPRICE_SORTEXT C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+
  ' left join VIW_SR_INFO D on A.TENANT_ID=D.TENANT_ID and A.SHOP_ID=D.SHOP_ID and A.GODS_ID=D.GODS_ID and A.PROPERTY_01=D.PROPERTY_01 and A.PROPERTY_02=D.PROPERTY_02 and A.BATCH_NO=D.BATCH_NO '+
  ' '+StrWhere;

  Result :=
  'select jc.*,isnull(c.BARCODE,jc.CALC_BARCODE) as BARCODE from ('+
  'select jb.*,b.COLOR_NAME as PROPERTY_02_TEXT from ('+
  'select ja.*,round(ja.NEW_OUTPRICE*ja.AMOUNT,2) as SALE_MNY,a.SIZE_NAME as PROPERTY_01_TEXT from ('+StrSql+') ja '+
  'left outer join VIW_SIZE_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.PROPERTY_01=a.SIZE_ID) jb '+
  'left outer join VIW_COLOR_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.PROPERTY_02=b.COLOR_ID) jc '+
  'left outer join VIW_BARCODE c on jc.TENANT_ID=c.TENANT_ID and jc.GODS_ID=c.GODS_ID and jc.PROPERTY_01=c.PROPERTY_01 and jc.PROPERTY_02=c.PROPERTY_02 and jc.UNIT_ID=c.UNIT_ID '+
  'order by jc.SHOP_ID,jc.GODS_CODE ';
  
end;

procedure TfrmStorageTracking.Open(ID: String);
begin
  CdsStorage.Close;
  CdsStorage.SQL.Text := ParseSQL(Factor.iDbType,EncodeSql(ID));
  Factor.Open(CdsStorage);
end;

procedure TfrmStorageTracking.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F5 then
     Open('');
end;

procedure TfrmStorageTracking.edtSHOP_TYPEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Shop_Type_Change(edtSHOP_VALUE);
end;

procedure TfrmStorageTracking.Shop_Type_Change(edtSHOP_VALUE:TzrComboBoxList);
begin
  case edtSHOP_TYPE.ItemIndex of
    0:edtSHOP_VALUE.DataSet := Global.GetZQueryFromName('PUB_REGION_INFO');
    1:edtSHOP_VALUE.DataSet := Global.GetZQueryFromName('PUB_SHOP_TYPE');
  end;
  edtSHOP_VALUE.KeyValue := null;
  edtSHOP_VALUE.Text := '';
end;

procedure TfrmStorageTracking.AddGoodTypeItems(
  GoodSortList: TcxComboBox; SetFlag: string);
 procedure AddItems(Cbx: TcxComboBox; Rs: TZQuery; CodeID: string);
 var CurObj: TRecord_;
 begin
   if (not Rs.Active) or (Rs.IsEmpty) then Exit;
   Rs.First;
   while not Rs.Eof do
   begin
     if trim(Rs.FieldByName('CODE_ID').AsString)=trim(CodeID) then
     begin
       CurObj:=TRecord_.Create;
       CurObj.ReadFromDataSet(Rs);
       Cbx.Properties.Items.AddObject(CurObj.fieldbyName('CODE_NAME').AsString,CurObj);
       break;
     end;
     Rs.Next;
   end;
 end;
var
  rs: TZQuery;
  i,InValue: integer;
begin
  try
    rs:=Global.GetZQueryFromName('PUB_STAT_INFO');
    ClearCbxPickList(GoodSortList);  //清除节点及Object对象
    for i:=1 to length(SetFlag) do
    begin
      InValue:=StrtoIntDef(SetFlag[i],0);
      if InValue=1 then
        AddItems(GoodSortList, rs, inttostr(i));
    end;
  finally
    rs.Filtered:=False;
    rs.Filter:='';
  end;
end;

procedure TfrmStorageTracking.AddGoodsIDItems(edtGoods_ID:TzrComboboxList);
var Item_Index:Integer;
begin
  if Trim(edtGoods_ID.Text)<>'' then
    begin
      edtGoods_ID.Text := '';
      edtGoods_ID.KeyValue := '';
    end;
  Item_Index := StrToIntDef(Trim(TRecord_(edtGoods_Type.Properties.Items.Objects[edtGoods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
  if Item_Index = 3 then
    begin
      edtGoods_ID.Columns[0].FieldName := 'CLIENT_NAME';
      edtGoods_ID.KeyField := 'CLIENT_ID';
      edtGoods_ID.ListField := 'CLIENT_NAME';
      edtGoods_ID.FilterFields := 'CLIENT_ID;CLIENT_NAME;CLIENT_SPELL';
    end
  else
    begin
      edtGoods_ID.Columns[0].FieldName := 'SORT_NAME';
      edtGoods_ID.KeyField := 'SORT_ID';
      edtGoods_ID.ListField := 'SORT_NAME';
      edtGoods_ID.FilterFields := 'SORT_ID;SORT_NAME;SORT_SPELL';
    end;
  case Item_Index of
    2: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_CATE_INFO');    //类别[烟草:一类烟、二类烟、三类烟]    
    3: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');   //主供应商
    4: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_BRAND_INFO');   //品牌
    5: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_IMPT_INFO');    //重点品牌
    6: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_AREA_INFO');    //省内外
    7: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_COLOR_GROUP');  //颜色
    8: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_SIZE_GROUP');   //尺码
  end;
end;

procedure TfrmStorageTracking.rzTreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TfrmStorageTracking.edtGoods_TypePropertiesChange(
  Sender: TObject);
begin
  inherited;
  AddGoodsIDItems(edtGoods_Id);
end;

function TfrmStorageTracking.TransUnit(CalcIdx: Integer;
  AliasTabName, AliasFileName: string): string;
var
  AliasTab: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  case CalcIdx of
   0: result:='(case when isnull('+AliasTab+'UNIT_ID,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'UNIT_ID end) ';  //若[默认单位]为空则 取 [计量单位]
   1: result:=' '+AliasTab+'CALC_UNITS ';   //[计量单位]  不能为空
   2: result:='(case when isnull('+AliasTab+'SMALL_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'SMALL_UNITS end) ';  //小包装单位
   3: result:='(case when isnull('+AliasTab+'BIG_UNITS,'''')='''' then '+AliasTab+'CALC_UNITS else '+AliasTab+'BIG_UNITS end) ';      //大包装单位
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

procedure TfrmStorageTracking.actFindExecute(Sender: TObject);
begin
  inherited;
  case rzPage.ActivePageIndex of
  0:Open('');
  1:Open2('');
  2:Open3('');
  end;
end;

procedure TfrmStorageTracking.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = Grid.CellRect(Grid.Col, Grid.Row).Top) and (not
    (gdFocused in State) or not Grid.Focused) then
  begin
    Grid.Canvas.Brush.Color := clAqua;
  end;
  
  Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      Grid.canvas.FillRect(ARect);
      DrawText(Grid.Canvas.Handle,pchar(Inttostr(CdsStorage.RecNo)),length(Inttostr(CdsStorage.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmStorageTracking.GridGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := clBtnFace;
end;

function TfrmStorageTracking.TransPrice(CalcIdx: Integer;
  AliasTabName: string; AliasFileName: string=''): string;
var
  AliasTab: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  case CalcIdx of
   0: result:=
      '(case when isnull('+AliasTab+'UNIT_ID,'''')='+AliasTab+'SMALL_UNITS then '+AliasTab+'NEW_OUTPRICE1 when isnull('+AliasTab+'UNIT_ID,'''')='+AliasTab+'BIG_UNITS then '+AliasTab+'NEW_OUTPRICE2 else '+AliasTab+'NEW_OUTPRICE end) ';  //若[默认单位]为空则 取 [计量单位]
   1: result:=' '+AliasTab+'NEW_OUTPRICE ';   //[计量单位]  不能为空
   2: result:='(case when isnull('+AliasTab+'SMALL_UNITS,'''')='''' then '+AliasTab+'NEW_OUTPRICE else '+AliasTab+'NEW_OUTPRICE1 end) ';  //小包装单位
   3: result:='(case when isnull('+AliasTab+'BIG_UNITS,'''')='''' then '+AliasTab+'NEW_OUTPRICE else '+AliasTab+'NEW_OUTPRICE2 end) ';      //大包装单位
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

function TfrmStorageTracking.TransCalcRate(CalcIdx: Integer; AliasTabName,
  AliasFileName: string): string;
var
  str,AliasTab,SmallCalc,BigCalc: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  SmallCalc:='case when isnull('+AliasTab+'SMALLTO_CALC,0)=0 then 1.0 else '+AliasTab+'SMALLTO_CALC end';
  BigCalc  :='case when isnull('+AliasTab+'BIGTO_CALC,0)=0 then 1.0 else '+AliasTab+'BIGTO_CALC end';

  str:=' case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.0 '+   //默认单位为 计量单位
       ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC '+  //默认单位为 小单位
       ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC '+   //默认单位为 大单位
       ' else 1.0 end ';

  case CalcIdx of
   0: result:=str;       //默认单位
   1: result:=' 1.0 ';   //计量单位
   2: result:=SmallCalc; //小包装单位
   3: result:=BigCalc;   //大包装单位
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

procedure TfrmStorageTracking.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if Grid = nil then Exit;
  PrintView;
  with TfrmEhLibReport.Create(Self) do
    begin
      try
        Preview(PrintDBGridEh1);
      finally
        Free;
      end;
    end;
end;

procedure TfrmStorageTracking.actPrintExecute(Sender: TObject);
begin
  inherited;
  if Grid = nil then Exit;
  PrintView;
  PrintDBGridEh1.Print;
end;

procedure TfrmStorageTracking.PrintView;
var HeaderText: String;
begin
  case rzPage.ActivePageIndex of
  0:begin
    PrintDBGridEh1.PageHeader.CenterText.Text := '当前库存';

    HeaderText := FormatString(edtSHOP_TYPE.Text+':'+edtSHOP_VALUE.Text,25);
    HeaderText := HeaderText + FormatString(edtGoods_Type.Text+':'+edtGoods_ID.Text,25);
    HeaderText := HeaderText + FormatString('统计单位:'+edtUNIT_ID.Text,25);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[SecondTitle]',HeaderText]);
    Grid.DataSource.DataSet.Filtered := False;
    PrintDBGridEh1.DBGridEh := Grid;
  end;
  1:begin
    PrintDBGridEh1.PageHeader.CenterText.Text := '补货需求';

    HeaderText := FormatString(edtP2_SHOP_TYPE.Text+':'+edtP2_SHOP_VALUE.Text,25);
    HeaderText := HeaderText + FormatString(edtP2_Goods_Type.Text+':'+edtP2_Goods_ID.Text,25);
    HeaderText := HeaderText + FormatString('统计单位:'+edtP2_UNIT_ID.Text,25);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[SecondTitle]',HeaderText]);
    DBGridEh1.DataSource.DataSet.Filtered := False;
    PrintDBGridEh1.DBGridEh := DBGridEh1;
  end;
  2:begin
    PrintDBGridEh1.PageHeader.CenterText.Text := '存销比监控';

    HeaderText := FormatString(edtP3_SHOP_TYPE.Text+':'+edtP3_SHOP_VALUE.Text,25);
    HeaderText := HeaderText + FormatString(edtP3_Goods_Type.Text+':'+edtP3_Goods_ID.Text,25);
    HeaderText := HeaderText + FormatString('统计单位:'+edtP3_UNIT_ID.Text,25);
    PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    PrintDBGridEh1.SetSubstitutes(['%[SecondTitle]',HeaderText]);
    DBGridEh2.DataSource.DataSet.Filtered := False;
    PrintDBGridEh1.DBGridEh := DBGridEh2;
  end;
  end;
end;

function TfrmStorageTracking.FormatString(TextStr: String;
  SpaceNum: Integer): String;
var Len,i:Integer;
    SpaceStr:String;
begin
  Len := length(TextStr);
  if Len >= SpaceNum then
    begin
      Result := copy(TextStr,1,SpaceNum);
    end
  else
    begin
      for i:=0 to SpaceNum-Len-1 do
        begin
          SpaceStr := SpaceStr + ' ';
        end;
      Result := TextStr + SpaceStr;
    end;
end;

function TfrmStorageTracking.EncodeSql2(ID: String): String;
var StrSql,StrWhere,StrJoin:String;
    Item_Index:Integer;
begin
  case Factor.iDbType of
    0: StrJoin := '+';
    1,4,5: StrJoin := '||';
  end;
  StrWhere := ' A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and C.COMM not in (''02'',''12'') ';
  if ID <> '' then
    StrWhere := StrWhere + ' and A.GODS_ID>'+QuotedStr(ID);
  if edtP2_SHOP_TYPE.ItemIndex = 0 then
    begin
      if edtP2_SHOP_VALUE.asString <> '' then
         begin
           if FnString.TrimRight(edtP2_SHOP_VALUE.asString,2)<>'00' then
              StrWhere := StrWhere + ' and B.REGION_ID = '+QuotedStr(edtP2_SHOP_VALUE.AsString+'')
           else
              StrWhere := StrWhere + ' and B.REGION_ID like '+QuotedStr(GetRegionId(edtP2_SHOP_VALUE.AsString)+'%');
         end;
    end
  else
    begin
      if edtP2_SHOP_VALUE.asString <> '' then
        StrWhere := StrWhere + ' and B.SHOP_TYPE='+QuotedStr(edtP2_SHOP_VALUE.AsString);
    end;

  if rzP2_Tree.Selected <> nil then
    begin
      if rzP2_Tree.Selected.Level > 1 then
        StrWhere := StrWhere + ' and C.LEVEL_ID like '+QuotedStr(TRecord_(rzP2_Tree.Selected.Data).FieldbyName('LEVEL_ID').AsString)+StrJoin+'''%'' and C.RELATION_ID='+TRecord_(rzP2_Tree.Selected.Data).FieldbyName('RELATION_ID').AsString
      else
      if rzP2_Tree.Selected.Level > 0 then
        StrWhere := StrWhere + ' and C.RELATION_ID='+TRecord_(rzP2_Tree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    end;
  Item_Index := StrToIntDef(Trim(TRecord_(edtP2_Goods_Type.Properties.Items.Objects[edtP2_Goods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
  case Item_Index of
    2:begin
      if edtP2_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID2='+QuotedStr(edtP2_Goods_ID.AsString);
    end;
    3:begin
      if edtP2_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID3='+QuotedStr(edtP2_Goods_ID.AsString);
    end;
    4:begin
      if edtP2_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID4='+QuotedStr(edtP2_Goods_ID.AsString);
    end;
    5:begin
      if edtP2_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID5='+QuotedStr(edtP2_Goods_ID.AsString);
    end;
    6:begin
      if edtP2_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID6='+QuotedStr(edtP2_Goods_ID.AsString);
    end;
  end;
  if edtP2_GoodsName.AsString<>'' then
    StrWhere := StrWhere + ' and A.GODS_ID='+QuotedStr(edtP2_GoodsName.AsString);
  if edtP2_SHOP_ID.AsString<>'' then
    StrWhere := StrWhere + ' and A.SHOP_ID='+QuotedStr(edtP2_SHOP_ID.AsString);

  if StrWhere <> '' then StrWhere :=' where '+ StrWhere;

  StrSql :=
  'select TENANT_ID,SHOP_ID,GODS_ID,sum(AMOUNT) as AMOUNT,sum(ROAD_AMT) as ROAD_AMT from ('+
  'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.AMOUNT/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0) as AMOUNT,D.AMOUNT/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0) as ROAD_AMT '+
  ' from STO_STORAGE A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSPRICE_SORTEXT C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+
  ' left join VIW_SR_INFO D on A.TENANT_ID=D.TENANT_ID and A.SHOP_ID=D.SHOP_ID and A.GODS_ID=D.GODS_ID and A.PROPERTY_01=D.PROPERTY_01 and A.PROPERTY_02=D.PROPERTY_02 and A.BATCH_NO=D.BATCH_NO '+
  ' '+StrWhere+' ) j group by TENANT_ID,SHOP_ID,GODS_ID';

  StrSql :=
  'select j1.TENANT_ID,j1.GODS_ID,F.GODS_CODE,F.GODS_NAME,F.BARCODE as CALC_BARCODE,''#'' as PROPERTY_01,''#'' as PROPERTY_02,max('+TransUnit(edtP2_UNIT_ID.ItemIndex,'F','')+') as UNIT_ID,sum(AMOUNT) as AMOUNT,sum(ROAD_AMT) as ROAD_AMT,max(F.NEW_INPRICE*('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+'*1.0)) as NEW_INPRICE,'+
  'sum(E.LOWER_AMOUNT/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as LOWER_AMOUNT,'+
  'sum(E.UPPER_AMOUNT/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as UPPER_AMOUNT,'+
  'sum(E.NEAR_SALE_AMT/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as NEAR_SALE_AMT,'+
  'sum(E.DAY_SALE_AMT/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as DAY_SALE_AMT '+
  'from ('+StrSql+') j1 left outer join VIW_GOODSINFO F on j1.TENANT_ID=F.TENANT_ID and j1.GODS_ID=F.GODS_ID left outer join PUB_GOODS_INSHOP E on j1.TENANT_ID=E.TENANT_ID and j1.SHOP_ID=E.SHOP_ID and j1.GODS_ID=E.GODS_ID '+
  'group by j1.TENANT_ID,j1.GODS_ID,F.GODS_CODE,F.GODS_NAME,F.BARCODE';

  Result :=
  'select jc.*,isnull(c.BARCODE,jc.CALC_BARCODE) as BARCODE,'+
  'case when isnull(DAY_SALE_AMT,0)<>0 then round(isnull(AMOUNT,0)/isnull(DAY_SALE_AMT,0),1) else 0 end as CAN_SALE_DAY,'+
  'case when isnull(AMOUNT,0)+isnull(ROAD_AMT,0)<isnull(UPPER_AMOUNT,0) then isnull(UPPER_AMOUNT,0)-(isnull(AMOUNT,0)+isnull(ROAD_AMT,0)) else 0 end as STOCK_AMT,'+
  'case when isnull(AMOUNT,0)+isnull(ROAD_AMT,0)<isnull(UPPER_AMOUNT,0) then isnull(UPPER_AMOUNT,0)-(isnull(AMOUNT,0)+isnull(ROAD_AMT,0)) else 0 end*NEW_INPRICE as STOCK_MNY '+
  'from ('+StrSql+') jc '+
  'left outer join VIW_BARCODE c on jc.TENANT_ID=c.TENANT_ID and jc.GODS_ID=c.GODS_ID and jc.PROPERTY_01=c.PROPERTY_01 and jc.PROPERTY_02=c.PROPERTY_02 and jc.UNIT_ID=c.UNIT_ID '+
  'order by jc.GODS_CODE ';

end;

procedure TfrmStorageTracking.Open2(ID: String);
begin
  if not Visible then Exit;
  cdsDemand.Close;
  cdsDemand.SQL.Text := ParseSQL(Factor.iDbType,EncodeSql2(ID));
  Factor.Open(cdsDemand);
end;

procedure TfrmStorageTracking.DBGridEh1DrawColumnCell(Sender: TObject;
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
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsDemand.RecNo)),length(Inttostr(cdsDemand.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmStorageTracking.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := clBtnFace;
  if (cdsDemand.FieldByName('LOWER_AMOUNT').AsFloat>0)
     and
     (cdsDemand.FieldByName('LOWER_AMOUNT').AsFloat>(cdsDemand.FieldByName('AMOUNT').AsFloat+cdsDemand.FieldByName('ROAD_AMT').AsFloat))
  then
     AFont.Color := RzStatusPane3.FillColor;
  if (cdsDemand.FieldByName('UPPER_AMOUNT').AsFloat>0)
     and
     (cdsDemand.FieldByName('UPPER_AMOUNT').AsFloat<(cdsDemand.FieldByName('AMOUNT').AsFloat+cdsDemand.FieldByName('ROAD_AMT').AsFloat))
  then
     AFont.Color := RzStatusPane4.FillColor;
  if (cdsDemand.FieldByName('DAY_SALE_AMT').AsFloat=0)
  then
     AFont.Color := RzStatusPane5.FillColor;

end;

function TfrmStorageTracking.EncodeSql3(ID: String): String;
var StrSql,StrWhere,StrJoin:String;
    Item_Index:Integer;
begin
  case Factor.iDbType of
    0: StrJoin := '+';
    1,4,5: StrJoin := '||';
  end;
  StrWhere := ' A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and C.COMM not in (''02'',''12'') ';
  if ID <> '' then
    StrWhere := StrWhere + ' and A.GODS_ID>'+QuotedStr(ID);
  if edtP3_SHOP_TYPE.ItemIndex = 0 then
    begin
      if edtP3_SHOP_VALUE.asString <> '' then
         begin
           if FnString.TrimRight(edtP3_SHOP_VALUE.asString,2)<>'00' then
              StrWhere := StrWhere + ' and B.REGION_ID = '+QuotedStr(edtP3_SHOP_VALUE.AsString+'')
           else
              StrWhere := StrWhere + ' and B.REGION_ID like '+QuotedStr(GetRegionId(edtP3_SHOP_VALUE.AsString)+'%');
         end;
    end
  else
    begin
      if edtP3_SHOP_VALUE.asString <> '' then
        StrWhere := StrWhere + ' and B.SHOP_TYPE='+QuotedStr(edtP3_SHOP_VALUE.AsString);
    end;

  if rzP3_Tree.Selected <> nil then
    begin
      if rzP3_Tree.Selected.Level > 1 then
        StrWhere := StrWhere + ' and C.LEVEL_ID like '+QuotedStr(TRecord_(rzP3_Tree.Selected.Data).FieldbyName('LEVEL_ID').AsString)+StrJoin+'''%'' and C.RELATION_ID='+TRecord_(rzP3_Tree.Selected.Data).FieldbyName('RELATION_ID').AsString
      else
      if rzP3_Tree.Selected.Level > 0 then
        StrWhere := StrWhere + ' and C.RELATION_ID='+TRecord_(rzP3_Tree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    end;
  Item_Index := StrToIntDef(Trim(TRecord_(edtP3_Goods_Type.Properties.Items.Objects[edtP3_Goods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
  case Item_Index of
    2:begin
      if edtP3_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID2='+QuotedStr(edtP3_Goods_ID.AsString);
    end;
    3:begin
      if edtP3_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID3='+QuotedStr(edtP3_Goods_ID.AsString);
    end;
    4:begin
      if edtP3_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID4='+QuotedStr(edtP3_Goods_ID.AsString);
    end;
    5:begin
      if edtP3_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID5='+QuotedStr(edtP3_Goods_ID.AsString);
    end;
    6:begin
      if edtP3_Goods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID6='+QuotedStr(edtP3_Goods_ID.AsString);
    end;
  end;
  if edtP3_GoodsName.AsString<>'' then
    StrWhere := StrWhere + ' and A.GODS_ID='+QuotedStr(edtP3_GoodsName.AsString);
  if edtP3_SHOP_ID.AsString<>'' then
    StrWhere := StrWhere + ' and A.SHOP_ID='+QuotedStr(edtP3_SHOP_ID.AsString);

  if StrWhere <> '' then StrWhere :=' where '+ StrWhere;

  StrSql :=
  'select TENANT_ID,SHOP_ID,GODS_ID,sum(AMOUNT) as AMOUNT from ('+
  'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.AMOUNT/(cast('+TransCalcRate(edtP3_UNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0) as AMOUNT '+
  ' from STO_STORAGE A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSPRICE_SORTEXT C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+
  ' '+StrWhere+' ) j group by TENANT_ID,SHOP_ID,GODS_ID';

  StrSql :=
  'select j1.TENANT_ID,j1.GODS_ID,F.GODS_CODE,F.GODS_NAME,F.BARCODE as CALC_BARCODE,''#'' as PROPERTY_01,''#'' as PROPERTY_02,max('+TransUnit(edtP3_UNIT_ID.ItemIndex,'F','')+') as UNIT_ID,sum(AMOUNT) as AMOUNT,'+
  'max(E.LOWER_RATE) as LOWER_RATE,'+
  'max(E.UPPER_RATE) as UPPER_RATE,'+
  'sum(E.NEAR_SALE_AMT/(cast('+TransCalcRate(edtP3_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as NEAR_SALE_AMT,'+
  'sum(E.DAY_SALE_AMT/(cast('+TransCalcRate(edtP3_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as DAY_SALE_AMT,'+
  'sum(E.MTH_SALE_AMT/(cast('+TransCalcRate(edtP3_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as MTH_SALE_AMT '+
  'from ('+StrSql+') j1 left outer join VIW_GOODSINFO F on j1.TENANT_ID=F.TENANT_ID and j1.GODS_ID=F.GODS_ID left outer join PUB_GOODS_INSHOP E on j1.TENANT_ID=E.TENANT_ID and j1.SHOP_ID=E.SHOP_ID and j1.GODS_ID=E.GODS_ID '+
  'group by j1.TENANT_ID,j1.GODS_ID,F.GODS_CODE,F.GODS_NAME,F.BARCODE';

  Result :=
  'select jc.*,isnull(c.BARCODE,jc.CALC_BARCODE) as BARCODE,'+
  'case when isnull(DAY_SALE_AMT,0)<>0 then round(isnull(AMOUNT,0)/isnull(DAY_SALE_AMT,0),1) else 0 end as CAN_SALE_DAY,'+
  'case when isnull(MTH_SALE_AMT,0)<>0 then cast(isnull(AMOUNT,0) as decimal(18,3))/cast(isnull(MTH_SALE_AMT,0) as decimal(18,3))*1.0 else 0 end as RATE '+
  'from ('+StrSql+') jc '+
  'left outer join VIW_BARCODE c on jc.TENANT_ID=c.TENANT_ID and jc.GODS_ID=c.GODS_ID and jc.PROPERTY_01=c.PROPERTY_01 and jc.PROPERTY_02=c.PROPERTY_02 and jc.UNIT_ID=c.UNIT_ID '+
  'order by jc.GODS_CODE ';

end;

procedure TfrmStorageTracking.Open3(ID: String);
begin
  if not Visible then Exit;
  cdsRate.Close;
  cdsRate.SQL.Text := ParseSQL(Factor.iDbType,EncodeSql3(ID));
  Factor.Open(cdsRate);
end;

procedure TfrmStorageTracking.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsRate.RecNo)),length(Inttostr(cdsRate.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmStorageTracking.DBGridEh2GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := clBtnFace;
  if (cdsRate.FieldByName('LOWER_RATE').AsFloat>0)
     and
     (cdsRate.FieldByName('LOWER_RATE').AsFloat>(cdsRate.FieldByName('RATE').AsFloat))
  then
     AFont.Color := RzStatusPane3.FillColor;
  if (cdsRate.FieldByName('UPPER_RATE').AsFloat>0)
     and
     (cdsRate.FieldByName('UPPER_RATE').AsFloat<(cdsRate.FieldByName('RATE').AsFloat))
  then
     AFont.Color := RzStatusPane4.FillColor;
  if (cdsRate.FieldByName('DAY_SALE_AMT').AsFloat=0)
  then
     AFont.Color := RzStatusPane6.FillColor;

end;

procedure TfrmStorageTracking.edtP2_Goods_TypePropertiesChange(
  Sender: TObject);
begin
  inherited;
  AddGoodsIDItems(edtP2_Goods_Id);

end;

procedure TfrmStorageTracking.edtP3_Goods_TypePropertiesChange(
  Sender: TObject);
begin
  inherited;
  AddGoodsIDItems(edtP3_Goods_Id);

end;

procedure TfrmStorageTracking.edtP2_SHOP_TYPEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Shop_Type_Change(edtP2_SHOP_VALUE);
end;

procedure TfrmStorageTracking.edtP3_SHOP_TYPEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Shop_Type_Change(edtP3_SHOP_VALUE);

end;

procedure TfrmStorageTracking.actfrmCalcExecute(Sender: TObject);
begin
  inherited;
  TfrmCostCalc.CalcAnalyLister(self);
end;

procedure TfrmStorageTracking.actSetupExecute(Sender: TObject);
begin
  inherited;
  with TfrmOptionDefine.Create(self) do
    begin
      try
        ShowModal;
      finally
        free;
      end;
    end;
end;

end.
