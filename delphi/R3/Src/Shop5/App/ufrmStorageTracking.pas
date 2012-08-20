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
    MainMenu1: TMainMenu;
    Lab_Count: TLabel;
    Lab_Mny: TLabel;
    Btn_Clear: TRzBitBtn;
    Btn_DeleteLast: TRzBitBtn;
    Btn_Commit: TRzBitBtn;
    edtProperty: TZQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    CdsCommitData: TZQuery;
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
    procedure GridGetFooterParams(Sender: TObject; DataCol, Row: Integer;
      Column: TColumnEh; AFont: TFont; var Background: TColor;
      var Alignment: TAlignment; State: TGridDrawState; var Text: String);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure rzP2_TreeChange(Sender: TObject; Node: TTreeNode);
    procedure rzP3_TreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure Btn_ClearClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure Btn_DeleteLastClick(Sender: TObject);
    procedure Btn_CommitClick(Sender: TObject);
  private
    FSumAmoney: Currency;
    FSumAmount: Currency;
    procedure SetSumAmoney(const Value: Currency);
    procedure SetSumAmount(const Value: Currency);
  private
    Locked:boolean;
    IsEnd: boolean;
    MaxId:string;
    ColumnStr:String;
    Flag:Integer;
    procedure OpenDialogProperty;
    procedure OpenDialogNumber;
    procedure LoadTree(Tree:TRzTreeView);
    procedure InitGrid;
    procedure PrintView;
    function FormatString(TextStr:String;SpaceNum:Integer):String;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
    function TransCalcRate(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function TransUnit(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function TransPrice(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function TransInPrice(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function EncodeSql(ID:String):String;
    function EncodeSql2(ID:String):String;
    function EncodeSql3(ID:String):String;
    function  GetGodsStateValue(DefineState: string='11111111111111111111'): string; //返回商品指标的启用情况
    procedure AddGoodTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111100000000000000');
    procedure AddGoodsIDItems(Sender: TObject; SortTypeList:TzrComboboxList);
    procedure Open(ID:String);
    procedure Open2(ID:String);
    procedure Open3(ID:String);
    procedure AutoAddColumn;
    procedure Shop_Type_Change(edtSHOP_VALUE:TzrComboBoxList);
    //2011.06.30 Am Add 导出Excel前表头
    function  DoBeforeExport: boolean; override;

    //2011.09.21 Add 金额的格式方式:
    procedure SetGridColumnDisplayFormat(AryMnyFormat: Array of string);
    procedure InitPrice(AObj: TRecord_);
    property SumAmount:Currency read FSumAmount write SetSumAmount;
    property SumAmoney:Currency read FSumAmoney write SetSumAmoney;
  public
    { Public declarations }
  end;


implementation
uses uTreeUtil,uGlobal, uShopGlobal,uCtrlUtil,uShopUtil,uFnUtil,ufrmEhLibReport,uDsUtil,StrUtils,
  ObjCommon,ufrmBasic, Math, ufrmCostCalc, ufrmOptionDefine, uframeDialogProperty, ufrmInputNumber,
  ufrmDemandOrderList, ufrmDemandOrder, ufrmMain;
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


  {rs := Global.GetZQueryFromName('PUB_SIZE_INFO');
  Column := FindColumn(Grid,'PROPERTY_01');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('SIZE_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('SIZE_NAME').AsString);
      rs.Next;
    end;}

  rs := Global.GetZQueryFromName('PUB_COLOR_INFO');
  Column := FindColumn(Grid,'PROPERTY_02');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('COLOR_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('COLOR_NAME').AsString);
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
var IsRoot: Boolean;
    rs:TZQuery;
    i:Integer;
    Rel_ID,Rel_IDS: string;
    Aobj,CurObj:TRecord_;
begin
  Locked := true;
  try
  Rel_ID:='';
  Rel_IDS:='';
  IsRoot:=False;
  ClearTree(Tree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  //rs.SortedFields := 'RELATION_ID';  //2011.08.27 排序错乱关闭
  rs.First;
  while not rs.Eof do
  begin
    Rel_ID:=','+InttoStr(rs.FieldByName('RELATION_ID').AsInteger)+','; //2011.09.25 add 当前供应链ID
    if Pos(Rel_ID,Rel_IDS)<=0 then
    begin
      Rel_IDS:=Rel_IDS+Rel_ID;  //2011.09.25 add 
      if trim(rs.FieldByName('RELATION_ID').AsString)='0' then //自主经营
      begin
        CurObj := TRecord_.Create;
        CurObj.ReadFromDataSet(rs);
        CurObj.FieldByName('LEVEL_ID').AsString := '';
        CurObj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
        IsRoot:=true;
      end else
      begin
        Aobj := TRecord_.Create;
        Aobj.ReadFromDataSet(rs);
        Aobj.FieldByName('LEVEL_ID').AsString := '';
        Aobj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
        Tree.Items.AddObject(nil,Aobj.FieldbyName('SORT_NAME').AsString,Aobj);
      end;
    end;
    rs.Next;
  end;
  if IsRoot and (CurObj<>nil) and (CurObj.FindField('SORT_NAME')<>nil) then
    Tree.Items.AddObject(nil,CurObj.FieldbyName('SORT_NAME').AsString,CurObj);

  for i:=Tree.Items.Count-1 downto 0 do
    begin
      rs.Filtered := False;
      rs.Filter := 'RELATION_ID='+TRecord_(Tree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
      rs.Filtered := True;
      //rs.SortedFields := 'LEVEL_ID';  //2011.08.27 排序错乱关闭
      CreateLevelTree(rs,Tree,'44444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',Tree.Items[i]);
    end;
  AddRoot(Tree,'所有分类');
  finally
  //  Locked := false;
  end;
end;

procedure TfrmStorageTracking.FormCreate(Sender: TObject);
var
  DefStateIDS: string;
begin
  inherited;
  RzPage.ActivePageIndex := 0;
  edtSTOR_AMT.ItemIndex := 0;
  TDbGridEhSort.InitForm(Self);
  DefStateIDS:=GetGodsStateValue; 
  AddGoodTypeItems(edtGoods_Type,DefStateIDS);
  AddGoodTypeItems(edtP2_Goods_Type,DefStateIDS);
  AddGoodTypeItems(edtP3_Goods_Type,DefStateIDS);
  //2011.10.15 add设置只能下来：
  edtGoods_Type.Properties.DropDownListStyle:=lsFixedList;
  edtP2_Goods_Type.Properties.DropDownListStyle:=lsFixedList;
  edtP3_Goods_Type.Properties.DropDownListStyle:=lsFixedList;
  InitGrid;                                                       
  if not ShopGlobal.GetChkRight('14500001',2) then
     begin
       FindColumn(Grid,'STOCK_MNY').Free;
       FindColumn(Grid,'NEW_INPRICE').Free;
       FindColumn(DBGridEh1,'STOCK_MNY').Free;
       FindColumn(DBGridEh1,'NEW_INPRICE').Free;
     end;

  if ShopGlobal.GetVersionFlag <> 1 then
     begin
       FindColumn(Grid,'PROPERTY_02').Free;
     end;
  edtProperty.Close;
  edtProperty.CreateDataSet;
  Btn_DeleteLast.Enabled := False;
  {if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
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
  end;}
  //2011.11.10 引入门店权限及部门权限，把原有的控制注释

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label12.Caption := '仓库群组';
      Label21.Caption := '仓库名称';
    end;

  //2011.09.22 Add 千分位；
  SetGridColumnDisplayFormat(['DBGridEh1.SALE_MNY','DBGridEh1.STOCK_MNY','DBGridEh2.STOCK_MNY']);
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

  //2011.10.10 add 判断索引
  if (edtGoods_Type.ItemIndex>=0) and (trim(edtGoods_ID.AsString) <> '') then
  begin
    Item_Index := StrToIntDef(Trim(TRecord_(edtGoods_Type.Properties.Items.Objects[edtGoods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
    StrWhere := StrWhere + ' and C.SORT_ID'+InttoStr(Item_Index)+'='+QuotedStr(edtGoods_ID.AsString);
  end;

  if edtGoodsName.AsString<>'' then
    StrWhere := StrWhere + ' and A.GODS_ID='+QuotedStr(edtGoodsName.AsString);
  if edtSHOP_ID.AsString<>'' then
    StrWhere := StrWhere + ' and A.SHOP_ID='+QuotedStr(edtSHOP_ID.AsString);

  case edtSTOR_AMT.ItemIndex of
  1: StrWhere := StrWhere + ' and round(A.AMOUNT,3)<>0';
  2: StrWhere := StrWhere + ' and round(A.AMOUNT,3)>0';
  3: StrWhere := StrWhere + ' and round(A.AMOUNT,3)=0';
  4: StrWhere := StrWhere + ' and round(A.AMOUNT,3)<0';
  end;

  if StrWhere <> '' then StrWhere :=' where '+ StrWhere;

  if ShopGlobal.GetVersionFlag = 1 then
     AutoAddColumn
  else
     ColumnStr := '';
  StrSql :=
  'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.BATCH_NO,A.PROPERTY_02,B.SHOP_NAME,C.GODS_CODE,C.GODS_NAME,C.BARCODE as CALC_BARCODE,'+
  'max(A.NEAR_INDATE) as NEAR_INDATE,max(A.NEAR_OUTDATE) as NEAR_OUTDATE'+ColumnStr+','+
  'sum(A.AMOUNT/(cast('+TransCalcRate(edtUNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0)) as AMOUNT,'+
  'sum(cast(D.AMOUNT as decimal(18,3))/(cast('+TransCalcRate(edtUNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0)) as ROAD_AMT,'+
  'max('+TransInPrice(edtUNIT_ID.ItemIndex,'C','')+') as NEW_INPRICE,'+
  'max('+TransPrice(edtUNIT_ID.ItemIndex,'C','')+') as NEW_OUTPRICE,'+
  'max('+TransUnit(edtUNIT_ID.ItemIndex,'C','')+') as UNIT_ID '+
  ' from STO_STORAGE A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSPRICE_SORTEXT C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+
  ' left join VIW_SR_INFO D on A.TENANT_ID=D.TENANT_ID and A.SHOP_ID=D.SHOP_ID and A.GODS_ID=D.GODS_ID and A.PROPERTY_01=D.PROPERTY_01 and A.PROPERTY_02=D.PROPERTY_02 and A.BATCH_NO=D.BATCH_NO '+
  ' '+StrWhere+ShopGlobal.GetDataRight('A.SHOP_ID',1)+
  ' group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.BATCH_NO,A.PROPERTY_02,B.SHOP_NAME,C.GODS_CODE,C.GODS_NAME,C.BARCODE';

  Result :=
  'select jc.*,jc.CALC_BARCODE as BARCODE,round(jc.NEW_OUTPRICE*jc.AMOUNT,2) as SALE_MNY,round(jc.NEW_INPRICE*jc.AMOUNT,2) as STOCK_MNY from ('+StrSql+') jc '+
  'order by jc.SHOP_ID,jc.GODS_CODE ';
  
end;

procedure TfrmStorageTracking.Open(ID: String);
begin
  if Locked then Exit;
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
  GoodSortList.Properties.BeginUpdate;
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
    GoodSortList.Properties.EndUpdate; 
  end;
end;

procedure TfrmStorageTracking.AddGoodsIDItems(Sender: TObject; SortTypeList:TzrComboboxList);
var
  CodeID: string;
  ItemsIdx: integer;
  Cbx: TcxComboBox;
begin
  if (Sender is TcxComboBox) and (TcxComboBox(Sender).ItemIndex<>-1) then
  begin
    Cbx:=TcxComboBox(Sender);
    CodeID:=trim(TRecord_(Cbx.Properties.Items.Objects[Cbx.ItemIndex]).fieldbyName('CODE_ID').AsString);
    ItemsIdx:=StrtoIntDef(CodeID,0);
  end;
  if ItemsIdx<=0 then Exit;
  //清除上次选项
  SortTypeList.Text:='';
  SortTypeList.KeyValue:='';
  case ItemsIdx of
   3:
    begin
      SortTypeList.KeyField:='CLIENT_ID';
      SortTypeList.ListField:='CLIENT_NAME';
      SortTypeList.FilterFields:='CLIENT_ID;CLIENT_NAME;CLIENT_SPELL';
    end;
   else
    begin
      SortTypeList.KeyField:='SORT_ID';
      SortTypeList.ListField:='SORT_NAME';
      SortTypeList.FilterFields:='SORT_ID;SORT_NAME;SORT_SPELL';
    end;
  end;
  SortTypeList.Columns[0].FieldName:=SortTypeList.ListField;
  if SortTypeList.Columns.Count>1 then
    SortTypeList.Columns[1].FieldName:=SortTypeList.KeyField;
  case ItemsIdx of
   3: //主供应商;
    begin
      SortTypeList.RangeField:='';
      SortTypeList.RangeValue:='';
      SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');
    end;
   else
    begin
      SortTypeList.DataSet:=Global.GetZQueryFromName('PUB_GOODS_INDEXS');
      SortTypeList.RangeField:='SORT_TYPE';
      SortTypeList.RangeValue:=InttoStr(ItemsIdx);
    end;
  end;
end;

procedure TfrmStorageTracking.rzTreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  if Locked then Exit;
  Open('');
end;

procedure TfrmStorageTracking.edtGoods_TypePropertiesChange(
  Sender: TObject);
begin
  inherited;
  AddGoodsIDItems(Sender,edtGoods_Id);
end;

function TfrmStorageTracking.TransUnit(CalcIdx: Integer;
  AliasTabName, AliasFileName: string): string;
var
  AliasTab: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  case CalcIdx of
   0: result:='(case when '+AliasTab+'UNIT_ID is null then '+AliasTab+'CALC_UNITS else '+AliasTab+'UNIT_ID end) ';  //若[默认单位]为空则 取 [计量单位]
   1: result:=' '+AliasTab+'CALC_UNITS ';   //[计量单位]  不能为空
   2: result:='(case when '+AliasTab+'SMALL_UNITS is null then '+AliasTab+'CALC_UNITS else '+AliasTab+'SMALL_UNITS end) ';  //小包装单位
   3: result:='(case when '+AliasTab+'BIG_UNITS is null then '+AliasTab+'CALC_UNITS else '+AliasTab+'BIG_UNITS end) ';      //大包装单位
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

  //2011.10.10 add 判断索引    
  if (edtP2_Goods_Type.ItemIndex>=0) and (trim(edtP2_Goods_ID.AsString) <> '') then
  begin
    Item_Index := StrToIntDef(Trim(TRecord_(edtP2_Goods_Type.Properties.Items.Objects[edtP2_Goods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
    StrWhere := StrWhere + ' and C.SORT_ID'+InttoStr(Item_Index)+'='+QuotedStr(edtP2_Goods_ID.AsString);
  end;

  if edtP2_GoodsName.AsString<>'' then
    StrWhere := StrWhere + ' and A.GODS_ID='+QuotedStr(edtP2_GoodsName.AsString);
  if edtP2_SHOP_ID.AsString<>'' then
    StrWhere := StrWhere + ' and A.SHOP_ID='+QuotedStr(edtP2_SHOP_ID.AsString);

  if StrWhere <> '' then StrWhere :=' where '+ StrWhere;

  StrSql :=
  'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,sum(A.AMOUNT) as AMOUNT '+
  ' from STO_STORAGE A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSINFO_SORTEXT C on A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
  ' '+StrWhere+ShopGlobal.GetDataRight('A.SHOP_ID',1)+' group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID';

  StrSql :=
  'select j1.TENANT_ID,j1.GODS_ID,''#'' as PROPERTY_01,''#'' as PROPERTY_02,''#'' as BATCH_NO,'+
  'sum(j1.AMOUNT) as AMOUNT,'+
  'sum(E1.AMOUNT) as ROAD_AMT,'+
  'sum(E.LOWER_AMOUNT) as LOWER_AMOUNT,'+
  'sum(E.UPPER_AMOUNT) as UPPER_AMOUNT,'+
  'sum(E.NEAR_SALE_AMT) as NEAR_SALE_AMT,'+
  'sum(E.DAY_SALE_AMT) as DAY_SALE_AMT '+
  'from ('+StrSql+') j1 '+
  'left outer join PUB_GOODS_INSHOP E on j1.TENANT_ID=E.TENANT_ID and j1.SHOP_ID=E.SHOP_ID and j1.GODS_ID=E.GODS_ID '+
  'left outer join (select TENANT_ID,SHOP_ID,GODS_ID,sum(AMOUNT) AS AMOUNT from VIW_SR_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' group by TENANT_ID,SHOP_ID,GODS_ID'+
  ') E1 on j1.TENANT_ID=E1.TENANT_ID and j1.SHOP_ID=E1.SHOP_ID and j1.GODS_ID=E1.GODS_ID '+
  'group by j1.TENANT_ID,j1.GODS_ID';

  result :=
  'select 0 as SEQNO,jc.TENANT_ID,jc.GODS_ID,F.GODS_CODE,isnull(c.BARCODE,f.BARCODE) as BARCODE,F.GODS_NAME,jc.PROPERTY_01,jc.PROPERTY_02,''#'' as BATCH_NO,'+TransUnit(edtP2_UNIT_ID.ItemIndex,'F','')+' as UNIT_ID,'+
  'cast(jc.AMOUNT as decimal(18,3))/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0) as STOCK_AMT,'+
  'cast(jc.ROAD_AMT as  decimal(18,3))/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0) AS ROAD_AMT,'+
  'F.NEW_INPRICE*'+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as NEW_INPRICE,'+
  'cast(jc.LOWER_AMOUNT as decimal(18,3))/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0) as LOWER_AMOUNT,'+
  'cast(jc.UPPER_AMOUNT as decimal(18,3))/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0) as UPPER_AMOUNT,'+
  'cast(jc.NEAR_SALE_AMT as decimal(18,3))/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0) as NEAR_SALE_AMT,'+
  'cast(jc.DAY_SALE_AMT as decimal(18,3))/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0) as DAY_SALE_AMT,'+
  'case when isnull(jc.DAY_SALE_AMT,0)<>0 then round(cast(isnull(jc.AMOUNT,0) as decimal(18,3))/cast(isnull(jc.DAY_SALE_AMT,0) as decimal(18,3))*1.0,1) else 0 end as CAN_SALE_DAY,'+
  'cast(case when isnull(jc.AMOUNT,0)+isnull(jc.ROAD_AMT,0)<isnull(jc.UPPER_AMOUNT,0) then isnull(jc.UPPER_AMOUNT,0)-(isnull(jc.AMOUNT,0)+isnull(jc.ROAD_AMT,0)) else 0 end as decimal(18,3))/(cast('+TransCalcRate(edtP2_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0) as AMOUNT,'+
  'case when isnull(jc.AMOUNT,0)+isnull(jc.ROAD_AMT,0)<isnull(jc.UPPER_AMOUNT,0) then isnull(jc.UPPER_AMOUNT,0)-(isnull(jc.AMOUNT,0)+isnull(jc.ROAD_AMT,0)) else 0 end*F.NEW_INPRICE as STOCK_MNY '+
  'from ('+StrSql+') jc inner join VIW_GOODSINFO F on jc.TENANT_ID=F.TENANT_ID and jc.GODS_ID=F.GODS_ID '+
  'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) c on jc.TENANT_ID=c.TENANT_ID and jc.GODS_ID=c.GODS_ID and jc.PROPERTY_01=c.PROPERTY_01 and jc.PROPERTY_02=c.PROPERTY_02 and '+TransUnit(edtP2_UNIT_ID.ItemIndex,'F','')+'=c.UNIT_ID '+
  'order by f.GODS_CODE ';

end;

procedure TfrmStorageTracking.Open2(ID: String);
begin
  if Locked then Exit;
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

  //2011.10.10 add 判断索引
  if (edtP3_Goods_Type.ItemIndex>=0) and (trim(edtP3_Goods_ID.AsString)<>'') then
  begin
    Item_Index := StrToIntDef(Trim(TRecord_(edtP3_Goods_Type.Properties.Items.Objects[edtP3_Goods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
    StrWhere := StrWhere + ' and C.SORT_ID'+InttoStr(Item_Index)+'='+QuotedStr(edtP3_Goods_ID.AsString);
  end;

  if edtP3_GoodsName.AsString<>'' then
    StrWhere := StrWhere + ' and A.GODS_ID='+QuotedStr(edtP3_GoodsName.AsString);
  if edtP3_SHOP_ID.AsString<>'' then
    StrWhere := StrWhere + ' and A.SHOP_ID='+QuotedStr(edtP3_SHOP_ID.AsString);

  if StrWhere <> '' then StrWhere :=' where '+ StrWhere;

  StrSql :=
  'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,sum(A.AMOUNT/(cast('+TransCalcRate(edtP3_UNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0)) as AMOUNT '+
  ' from STO_STORAGE A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSINFO_SORTEXT C on A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
  ' '+StrWhere+ShopGlobal.GetDataRight('A.SHOP_ID',1)+'  group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID';

  StrSql :=
  'select j1.TENANT_ID,j1.GODS_ID,F.GODS_CODE,F.GODS_NAME,F.BARCODE as CALC_BARCODE,''#'' as PROPERTY_01,''#'' as PROPERTY_02,max('+TransUnit(edtP3_UNIT_ID.ItemIndex,'F','')+') as UNIT_ID,sum(AMOUNT) as AMOUNT,'+
  'max(E.LOWER_RATE) as LOWER_RATE,'+
  'max(E.UPPER_RATE) as UPPER_RATE,'+
  'sum(E.NEAR_SALE_AMT/(cast('+TransCalcRate(edtP3_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as NEAR_SALE_AMT,'+
  'sum(E.DAY_SALE_AMT/(cast('+TransCalcRate(edtP3_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as DAY_SALE_AMT,'+
  'sum(E.MTH_SALE_AMT/(cast('+TransCalcRate(edtP3_UNIT_ID.ItemIndex,'F','')+' as decimal(18,3))*1.0)) as MTH_SALE_AMT '+
  'from ('+StrSql+') j1 inner join VIW_GOODSINFO F on j1.TENANT_ID=F.TENANT_ID and j1.GODS_ID=F.GODS_ID left outer join PUB_GOODS_INSHOP E on j1.TENANT_ID=E.TENANT_ID and j1.SHOP_ID=E.SHOP_ID and j1.GODS_ID=E.GODS_ID '+
  'group by j1.TENANT_ID,j1.GODS_ID,F.GODS_CODE,F.GODS_NAME,F.BARCODE';

  Result :=
  'select jc.*,isnull(c.BARCODE,jc.CALC_BARCODE) as BARCODE,'+
  'case when isnull(jc.DAY_SALE_AMT,0)<>0 then round(cast(isnull(jc.AMOUNT,0) as decimal(18,3))/cast(isnull(jc.DAY_SALE_AMT,0) as decimal(18,3))*1.0,1) else 0 end as CAN_SALE_DAY,'+
  'case when isnull(jc.MTH_SALE_AMT,0)<>0 then cast(isnull(jc.AMOUNT,0) as decimal(18,3))/cast(isnull(jc.MTH_SALE_AMT,0) as decimal(18,3))*1.0 else 0 end as RATE '+
  'from ('+StrSql+') jc '+
  'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+' and BARCODE_TYPE in (''0'',''1'',''2'')) c '+
  'on jc.TENANT_ID=c.TENANT_ID and jc.GODS_ID=c.GODS_ID and jc.PROPERTY_01=c.PROPERTY_01 and jc.PROPERTY_02=c.PROPERTY_02 and jc.UNIT_ID=c.UNIT_ID '+
  'order by jc.GODS_CODE ';

end;

procedure TfrmStorageTracking.Open3(ID: String);
begin
  if Locked then Exit;
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
  AddGoodsIDItems(Sender,edtP2_Goods_Id);

end;

procedure TfrmStorageTracking.edtP3_Goods_TypePropertiesChange(
  Sender: TObject);
begin
  inherited;
  AddGoodsIDItems(Sender,edtP3_Goods_Id); 
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

procedure TfrmStorageTracking.GridGetFooterParams(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  inherited;
  if Column.FieldName='GODS_NAME' then Text := '合计:'+Text+'笔';
end;

procedure TfrmStorageTracking.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='GODS_NAME' then Text := '合计:'+Text+'笔';

end;

procedure TfrmStorageTracking.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='GODS_NAME' then Text := '合计:'+Text+'笔';

end;

function TfrmStorageTracking.DoBeforeExport: boolean;
var
  i: integer;
  PageNo,CurStr: string;  //控件页码
  Str: WideString;
  DBGridEh: TDBGridEh;
  TitleList: TStringList;
begin
  Str:='';
  try
    case RzPage.ActivePageIndex of
     0: DBGridEh:= Grid;
     1: DBGridEh:= DBGridEh1;
     2: DBGridEh:= DBGridEh2;
    end;
    PageNo:=InttoStr(RzPage.ActivePageIndex+1);
    DBGridEh.DBGridTitle:=RzPage.ActivePage.Caption;
    //调用DBGridEh的Print来获取导出条件
    TitleList:=TStringList.Create;
    PrintView;
    TitleList.CommaText:=PrintDBGridEh1.BeforeGridText.CommaText;
    for i:=0 to TitleList.Count-1 do
    begin
      CurStr:=trim(TitleList.Strings[i]);
      if (i>0) and (i mod 4=0) then  //4个条件换一行
        Str:=Str+#13+CurStr
      else
      begin
        if i=0 then
          Str:=CurStr
        else
          Str:=Str+'      '+CurStr;
      end;
    end;
  finally
    TitleList.Free;
  end;
  DBGridEh.DBGridHeader.Text:=Str;
  DBGridEh.DBGridFooter.Add(' '+#13+' 操作员：'+Global.UserName+'  导出时间：'+formatDatetime('YYYY-MM-DD HH:NN:SS',now()));
end;

function TfrmStorageTracking.TransInPrice(CalcIdx: Integer; AliasTabName,
  AliasFileName: string): string;
var
  AliasTab: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  case CalcIdx of
   0: result:=
      '(case when isnull('+AliasTab+'UNIT_ID,'''')='+AliasTab+'SMALL_UNITS then '+AliasTab+'NEW_INPRICE1 when isnull('+AliasTab+'UNIT_ID,'''')='+AliasTab+'BIG_UNITS then '+AliasTab+'NEW_INPRICE2 else '+AliasTab+'NEW_INPRICE end) ';  //若[默认单位]为空则 取 [计量单位]
   1: result:=' '+AliasTab+'NEW_INPRICE ';   //[计量单位]  不能为空
   2: result:='(case when isnull('+AliasTab+'SMALL_UNITS,'''')='''' then '+AliasTab+'NEW_INPRICE else '+AliasTab+'NEW_INPRICE1 end) ';  //小包装单位
   3: result:='(case when isnull('+AliasTab+'BIG_UNITS,'''')='''' then '+AliasTab+'NEW_INPRICE else '+AliasTab+'NEW_INPRICE2 end) ';      //大包装单位
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

function TfrmStorageTracking.GetGodsStateValue(DefineState: string): string;
var
  ReStr: string;
  PosIdx: integer;
  RsState: TZQuery;
begin
  ReStr:='00000000000000000000';
  RsState:=Global.GetZQueryFromName('PUB_STAT_INFO');
  RsState.First;
  while not RsState.Eof do
  begin
    PosIdx:=StrToIntDef(RsState.fieldbyName('CODE_ID').AsString,0);
    if PosIdx>0 then
    begin
      if ShopGlobal.GetVersionFlag = 1 then  //服装版全部
        ReStr:=Copy(ReStr,1,PosIdx-1)+Copy(DefineState,PosIdx,1)+Copy(ReStr,PosIdx+1,20)
      else
      begin
        if (PosIdx<7) or (PosIdx>8) then
          ReStr:=Copy(ReStr,1,PosIdx-1)+Copy(DefineState,PosIdx,1)+Copy(ReStr,PosIdx+1,20)
      end;
    end;
    RsState.Next;
  end;
  result:=ReStr;
end;

procedure TfrmStorageTracking.rzP2_TreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if Locked then Exit;
  Open2('');
end;

procedure TfrmStorageTracking.rzP3_TreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  if Locked then Exit;
  Open3('');
end;

procedure TfrmStorageTracking.SetGridColumnDisplayFormat(AryMnyFormat: array of string);
  function FindGrid(GridName: string): TDBGridEh;
  var Grid: TComponent;
  begin
    result:=nil;
    Grid:=FindComponent(GridName);
    if (Grid<>nil) and (Grid is TDBGridEh) then
      result:=TDBGridEh(Grid);
  end;
var
  i,Idx: integer;
  CurGrid: TDBGridEh;  //DBGridEh
  SetColumn: TColumnEh;
  CurName, CurGridName, NearGridName,ColName: string; //DBGridEh的名
begin
  CurGridName:='';
  NearGridName:='';
  for i:=Low(AryMnyFormat) to High(AryMnyFormat) do
  begin
    CurName:=trim(AryMnyFormat[i]);
    Idx:=Pos('.',CurName);
    ColName:=Copy(CurName,Idx+1,length(CurName)-Idx);
    CurGridName:=Copy(CurName,1,Idx-1);
    
    if NearGridName<>'' then
    begin
      if NearGridName<>CurGridName then
        CurGrid:=FindGrid(CurGridName);
    end else
    begin
      NearGridName:=CurGridName;
      CurGrid:=FindGrid(CurGridName);
    end;
    
    if CurGrid<>nil then
    begin
      SetColumn:=FindColumn(CurGrid, ColName);
      if SetColumn<>nil then
      begin
        SetColumn.DisplayFormat:='#,##0.00';
        SetColumn.Footer.DisplayFormat:='#,##0.00';
      end;
    end;
  end;
end;

procedure TfrmStorageTracking.FormShow(Sender: TObject);
begin
  inherited;
  Locked := false;
  actFindExecute(nil);
  RzPanel3.Update;
end;

procedure TfrmStorageTracking.AutoAddColumn;
var rs,rs2:TZQuery;
    Column:TColumnEh;
    i,lv,mx,idx:Integer;
    fldArr: array [0..100] of String;
    TleArr: array [0..100] of String;
begin
  Grid.Columns.BeginUpdate;
  rs2 := TZQuery.Create(nil);
  try
    for i := Grid.Columns.Count-1 downto 0 do
      begin
        if copy(Grid.Columns[i].FieldName,1,5)='SIZE_' then
           Grid.Columns.Delete(i);
      end;
    for i:= 0 to 100 do fldArr[i] := '';
    for i:= 0 to 100 do TleArr[i] := '';
    rs2.SQL.Text := 'select distinct SORT_ID8 from VIW_GOODSINFO where TENANT_ID='+inttostr(Global.TENANT_ID);
    Factor.Open(rs2);
    rs := ShopGlobal.GetZQueryFromName('PUB_SIZE_RELATION');
    //求得最大列
    mx := -1;
    rs2.First;
    while not rs2.Eof do
    begin
      rs.Filtered := False;
      rs.Filter := 'SORT_ID='''+rs2.FieldByName('SORT_ID8').AsString+'''';
      rs.Filtered := True;
      lv := 0;
      rs.First;
      while not rs.Eof do
      begin
        if lv > mx then mx := lv;
        inc(lv);
        rs.Next;
      end;
      rs2.Next;
    end;
    //准备列头数据
    rs2.First;
    while not rs2.Eof do
    begin
      rs.Filtered := False;
      rs.Filter := 'SORT_ID='''+rs2.FieldByName('SORT_ID8').AsString+'''';
      rs.Filtered := True;
      if rs.isEmpty then
         begin
            rs2.next;
            continue;
         end;
      lv := 0;
      rs.First;
      while not rs.Eof do                      
      begin
        if fldArr[lv]<>'' then fldArr[lv] := fldArr[lv]+',';
        fldArr[lv] := fldArr[lv]+''''+rs.FieldbyName('SIZE_ID').AsString+'''';
        if TleArr[lv]<>'' then TleArr[lv] := TleArr[lv]+'|';
        TleArr[lv] := TleArr[lv]+rs.FieldbyName('SIZE_NAME').AsString;
        inc(lv);
        rs.Next;
      end;
      //不足最大列，要补足
      for i:= lv to mx do
      begin
        TleArr[i] := TleArr[i]+'| ';
      end;
      rs2.Next;
    end;
    if mx>=0 then
    begin
      idx := FindColumn(Grid,'PROPERTY_02').Index;
      Column := Grid.Columns.Add;
      Column.FieldName := 'SIZE_W';
      Column.Width := 30;
      Column.Title.Caption := '尺码|无';
      Column.Footer.ValueType := fvtNon;
      Column.Alignment := taRightJustify;
      Column.ReadOnly := true;
      Column.Index := Idx+1;
      ColumnStr := ',sum(case when isnull(A.PROPERTY_01,''#'')=''#'' then A.AMOUNT/(cast('+TransCalcRate(edtUNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0) else 0 end) as SIZE_W';
    end;
    for i:= 0 to mx do
      begin
        Column := Grid.Columns.Add;
        Column.FieldName := 'SIZE_'+formatFloat('000',i);
        Column.Width := 30;
        Column.Title.Caption := '尺码|'+TleArr[i];
        Column.Footer.ValueType := fvtNon;
        Column.Alignment := taRightJustify;
        Column.ReadOnly := true;
        Column.Index := Idx+1+i+1;
        ColumnStr := ColumnStr+',sum(case when A.PROPERTY_01 in ('+fldArr[i]+') then A.AMOUNT/(cast('+TransCalcRate(edtUNIT_ID.ItemIndex,'C','')+' as decimal(18,3))*1.0) else 0 end) as SIZE_'+formatFloat('000',i);
      end;
  finally
    Grid.Columns.EndUpdate;
  end;
end;
procedure TfrmStorageTracking.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  N1Click(Sender);
end;

procedure TfrmStorageTracking.OpenDialogNumber;
var Amount,TAmount,TAmoney:Currency;
    AObj:TRecord_;
    IsExist:Boolean;
begin
  AObj := TRecord_.Create;
  try
    AObj.ReadFromDataSet(cdsDemand);
    AObj.FieldByName('SEQNO').AsInteger := cdsDemand.RecNo;
    TAmount := 0;
    TAmoney := 0;
    edtProperty.Filtered := false;
    edtProperty.Filter := 'SEQNO='''+AObj.FieldbyName('SEQNO').AsString+'''';
    edtProperty.Filtered := true;
    IsExist := False;
    edtProperty.First;
    while not edtProperty.Eof do
    begin
      IsExist := True;
      TAmount := TAmount + edtProperty.FieldByName('AMOUNT').AsFloat;
      TAmoney := TAmoney + edtProperty.FieldByName('AMONEY').AsFloat;
      edtProperty.Next;
    end;
    if IsExist then
       Amount := TAmount
    else
       Amount := AObj.FieldByName('AMOUNT').AsFloat;

    if TfrmInputNumber.ShowDialog(Self,Amount) then
       begin
         SumAmount := SumAmount - TAmount;
         SumAmoney := SumAmoney - TAmoney;
         AObj.FieldByName('AMOUNT').AsFloat := Amount;
         if IsExist then
         begin
           edtProperty.Edit;
           edtProperty.FieldByName('AMOUNT').AsFloat := AObj.FieldByName('AMOUNT').AsFloat;
           edtProperty.Post;
         end
         else
         begin
           edtProperty.Append;
           edtProperty.FieldByName('SEQNO').AsInteger := AObj.FieldByName('SEQNO').AsInteger;
           edtProperty.FieldByName('GODS_ID').AsString := AObj.FieldByName('GODS_ID').AsString;
           edtProperty.FieldByName('BARCODE').AsString := AObj.FieldByName('BARCODE').AsString;
           edtProperty.FieldByName('GODS_CODE').AsString := AObj.FieldByName('GODS_CODE').AsString;
           edtProperty.FieldByName('UNIT_ID').AsString := AObj.FieldByName('UNIT_ID').AsString;
           edtProperty.FieldByName('BATCH_NO').AsString := AObj.FieldByName('BATCH_NO').AsString;
           edtProperty.FieldByName('IS_PRESENT').AsInteger := 0;
           edtProperty.FieldByName('PROPERTY_01').AsString := AObj.FieldByName('PROPERTY_01').AsString;
           edtProperty.FieldByName('PROPERTY_02').AsString := AObj.FieldByName('PROPERTY_02').AsString;
           edtProperty.FieldByName('AMOUNT').AsFloat := AObj.FieldByName('AMOUNT').AsFloat;
           edtProperty.Post;
           Flag := AObj.FieldbyName('SEQNO').AsInteger;
           Btn_DeleteLast.Enabled := True;
         end;
         SumAmount := SumAmount + AObj.FieldbyName('AMOUNT').AsFloat;
         InitPrice(AObj);
       end;
  finally
    AObj.Free;
    DBGridEh1.SetFocus;
  end;
end;

procedure TfrmStorageTracking.OpenDialogProperty;
var AObj:TRecord_;
    TAmount,TAmoney:Currency;
    IsExist:Boolean;
begin
  AObj := TRecord_.Create;
  try
    AObj.ReadFromDataSet(cdsDemand);
    AObj.FieldByName('SEQNO').AsInteger := cdsDemand.RecNo;
    TAmount := 0;
    TAmoney := 0;
    edtProperty.Filtered := false;
    edtProperty.Filter := 'SEQNO='''+AObj.FieldbyName('SEQNO').AsString+'''';
    edtProperty.Filtered := true;
    IsExist := False;
    edtProperty.First;
    while not edtProperty.Eof do
    begin
      IsExist := True;
      TAmount := TAmount + edtProperty.FieldByName('AMOUNT').AsFloat;
      TAmoney := TAmoney + edtProperty.FieldByName('AMONEY').AsFloat;
      edtProperty.Next;
    end;
    edtProperty.Filtered := False;
    if TframeDialogProperty.ShowDialog(self,AObj,edtProperty,dsEdit) then
    begin
       SumAmount := SumAmount - TAmount;
       SumAmoney := SumAmoney - TAmoney;
       if not IsExist then
       begin
         Flag := AObj.FieldbyName('SEQNO').AsInteger;
         Btn_DeleteLast.Enabled := True;
       end;
       SumAmount := SumAmount + AObj.FieldbyName('AMOUNT').AsFloat;
       InitPrice(AObj);
    end;
  finally
    AObj.Free;
    DBGridEh1.SetFocus;
  end;
end;

procedure TfrmStorageTracking.Btn_ClearClick(Sender: TObject);
begin
  inherited;
  if edtProperty.IsEmpty then Exit;
  edtProperty.First;
  while not edtProperty.Eof do  edtProperty.Delete;
  SumAmount := 0;
  SumAmoney := 0;
  Flag := 0;
  Btn_DeleteLast.Enabled := False;
end;

procedure TfrmStorageTracking.N1Click(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if cdsDemand.IsEmpty then Exit;
  rs := ShopGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',cdsDemand.FieldByName('GODS_ID').AsString,[]) then
  begin
   if Length(rs.FieldByName('SORT_ID7').AsString) > 1 then
      OpenDialogProperty
   else
      OpenDialogNumber;
  end;
  Btn_DeleteLast.Enabled := True;
end;

procedure TfrmStorageTracking.Btn_DeleteLastClick(Sender: TObject);
begin
  inherited;
  if edtProperty.IsEmpty then Exit;
  if Flag = 0 then Exit;
  edtProperty.Filtered := false;
  edtProperty.Filter := 'SEQNO='''+IntToStr(Flag)+'''';
  edtProperty.Filtered := true;
  edtProperty.First;
  while not edtProperty.Eof do
  begin
    SumAmount := SumAmount - edtProperty.FieldByName('AMOUNT').AsFloat;
    SumAmoney := SumAmoney - edtProperty.FieldByName('AMONEY').AsFloat;
    edtProperty.Next;
  end;
  edtProperty.First;
  while not edtProperty.Eof do edtProperty.Delete;
  edtProperty.Filtered := False;
  Flag := 0;
  Btn_DeleteLast.Enabled := False;
end;

procedure TfrmStorageTracking.InitPrice(AObj: TRecord_);
var
  bs:TZQuery;
  APrice:Currency;
  str,OutLevel:string;
begin
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',AObj.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('缓冲数据集中没找到当前商品...');

  if cdsDemand.FieldByName('UNIT_ID').AsString = bs.FieldByName('CALC_UNITS').AsString then
    begin
      APrice := bs.FieldbyName('NEW_OUTPRICE').AsFloat;
    end
  else if cdsDemand.FieldByName('UNIT_ID').AsString = bs.FieldByName('SMALL_UNITS').AsString then
    begin
      APrice := bs.FieldbyName('NEW_OUTPRICE1').AsFloat;
    end
  else if cdsDemand.FieldByName('UNIT_ID').AsString = bs.FieldByName('BIG_UNITS').AsString then
    begin
      APrice := bs.FieldbyName('NEW_OUTPRICE2').AsFloat;
    end;
  Flag := AObj.FieldbyName('SEQNO').AsInteger;
  edtProperty.Filtered := false;
  edtProperty.Filter := 'SEQNO='''+AObj.FieldbyName('SEQNO').AsString+'''';
  edtProperty.Filtered := true;
  edtProperty.First;
  while not edtProperty.Eof do
  begin
    edtProperty.Edit;
    edtProperty.FieldByName('AMONEY').AsFloat := APrice * edtProperty.FieldByName('AMOUNT').AsFloat;
    SumAmoney := SumAmoney + edtProperty.FieldByName('AMONEY').AsFloat;
    edtProperty.Post;
    edtProperty.Next;
  end;
end;

procedure TfrmStorageTracking.SetSumAmoney(const Value: Currency);
begin
  FSumAmoney := Value;
  Lab_Mny.Caption := '总额:'+ formatFloat('#0.00',Value);
end;

procedure TfrmStorageTracking.SetSumAmount(const Value: Currency);
begin
  FSumAmount := Value;
  Lab_Count.Caption := '总量:'+ formatFloat('#0.00',Value);
end;

procedure TfrmStorageTracking.Btn_CommitClick(Sender: TObject);
var frmDemandOrderList:TfrmDemandOrderList;
begin
  inherited;
  if not frmMain.FindAction('Action9').Enabled then Exit;
  frmMain.FindAction('Action9').OnExecute(nil);
  frmDemandOrderList := TfrmDemandOrderList(frmMain.FindChildForm(TfrmDemandOrderList));
  SendMessage(frmDemandOrderList.Handle,WM_USER+3,0,2);
  PostMessage(frmDemandOrderList.CurOrder.Handle,WM_USER+7,integer(Self),0);
end;

end.
