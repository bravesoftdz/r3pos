unit ufrmGoodsMonth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, ExtCtrls, jpeg, RzTabs, RzPanel, cxButtonEdit, zrComboBoxList,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  RzButton, Grids, DBGridEh, RzTreeVw, DB, ZAbstractRODataset, zBase,
  ZAbstractDataset, ZDataset, zrMonthEdit, PrnDbgeh;

type
  TfrmGoodsMonth = class(TframeToolForm)
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    Splitter1: TSplitter;
    RzPanel7: TRzPanel;
    rzTree: TRzTreeView;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    uca: TDBGridEh;
    RzPanel9: TRzPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Label25: TLabel;
    btnOk: TRzBitBtn;
    edtGoods_Type: TcxComboBox;
    edtGoods_ID: TzrComboBoxList;
    DsGoodsMonth: TDataSource;
    CdsGoodsMonth: TZQuery;
    edtMonth: TzrMonthEdit;
    Label1: TLabel;
    ToolButton1: TToolButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    PrintDBGridEh1: TPrintDBGridEh;
    ToolButton8: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure edtGoods_TypePropertiesChange(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure dbGoodsMonthColumns9UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure N1Click(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure ucaDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure actCancelExecute(Sender: TObject);
    procedure dbGoodsMonthColumns10UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
  private
    FIsModify: Boolean;
    Locked: Boolean;
    { Private declarations }
    procedure LoadTree(Tree:TRzTreeView);
    procedure AddGoodTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111100000000000000');
    function TransUnit(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    procedure InitGrid;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
    procedure AddGoodsIDItems(edtGoods_ID:TzrComboboxList);
    procedure AdjpriceToAdjCst(Aprice:Real);
    procedure AdjCstToAdjprice(Acst:Real);
    procedure BatchWrite;
    procedure SetIsModify(const Value: Boolean);
    procedure PrintView;
  public
    { Public declarations }
    function EncodeSql(ID:String):String;
    procedure Open(ID:String);
    procedure Save;
    property IsModify:Boolean read FIsModify write SetIsModify;
  end;

implementation
uses uTreeUtil,uGlobal,uShopGlobal,uCtrlUtil,uShopUtil,uFnUtil,ufrmEhLibReport,
     uDsUtil,ObjCommon,ufrmPrgBar, ufrmBasic, Math;
{$R *.dfm}

{ TfrmGoodsMonth }

procedure TfrmGoodsMonth.AddGoodTypeItems(GoodSortList: TcxComboBox;
  SetFlag: string);
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

function TfrmGoodsMonth.EncodeSql(ID: String): String;
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

  if edtMonth.asString <> '' then
    StrWhere := StrWhere + ' and A.MONTH='+edtMonth.asString
  else
    StrWhere := StrWhere + ' and A.MONTH='+FormatDateTime('YYYYMM',Date);

  if StrWhere <> '' then StrWhere :=' where '+ StrWhere;

  StrSql :=
  'select A.MONTH,A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.BATCH_NO,C.GODS_CODE,C.GODS_NAME,C.BARCODE as CALC_BARCODE,sum(A.BAL_AMT) as BAL_AMT,'+
  'sum(A.BAL_CST) as BAL_CST,sum(A.BAL_CST)/sum(A.BAL_AMT) as BAL_PRICE,sum(A.ADJ_CST) as ADJ_CST,sum(A.ADJ_CST+A.BAL_CST)/sum(A.BAL_AMT) as ADJ_PRICE,'+
  'sum(A.ADJ_CST+A.BAL_CST) as ADJ_MNY,'+TransUnit(0,'C','UNIT_ID')+
  ' from RCK_GOODS_MONTH A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSPRICE_SORTEXT C '+
  ' on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+StrWhere+' group by A.GODS_ID,A.BATCH_NO ';

  Result :=
  'select ja.*,isnull(a.BARCODE,ja.CALC_BARCODE) as BARCODE  from ('+StrSql+') ja '+
  'left outer join (select * from VIW_BARCODE where TENANT_ID='+InttoStr(Global.TENANT_ID)+
  ' and BARCODE_TYPE in (''0'',''1'',''2'')) a on ja.TENANT_ID=a.TENANT_ID and ja.GODS_ID=a.GODS_ID and ja.UNIT_ID=a.UNIT_ID '+
  'order by ja.SHOP_ID,ja.GODS_CODE ';
  
end;

procedure TfrmGoodsMonth.LoadTree(Tree: TRzTreeView);
var IsRoot: Boolean;
    rs:TZQuery;
    i,j:Integer;
    Aobj,CurObj:TRecord_;
begin
  IsRoot:=False;
  ClearTree(Tree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs.SortedFields := 'RELATION_ID';
  j:=-1;
  rs.First;
  while not rs.Eof do
  begin
    if (j <> rs.FieldByName('RELATION_ID').AsInteger) then
    begin
      if trim(rs.FieldByName('RELATION_ID').AsString)='0' then //自主经营
      begin
        CurObj := TRecord_.Create;
        CurObj.ReadFromDataSet(rs);
        CurObj.FieldByName('LEVEL_ID').AsString := '';
        CurObj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
        j := CurObj.FieldbyName('RELATION_ID').AsInteger;
        IsRoot:=true;
      end else
      begin
        Aobj := TRecord_.Create;
        Aobj.ReadFromDataSet(rs);
        Aobj.FieldByName('LEVEL_ID').AsString := '';
        Aobj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
        Tree.Items.AddObject(nil,Aobj.FieldbyName('SORT_NAME').AsString,Aobj);
        j := Aobj.FieldbyName('RELATION_ID').AsInteger;
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
      rs.SortedFields := 'LEVEL_ID';
      CreateLevelTree(rs,Tree,'44444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',Tree.Items[i]);
    end;
  AddRoot(Tree,'所有分类');
end;

procedure TfrmGoodsMonth.Open(ID: String);
begin
  if edtMonth.asString = '' then edtMonth.asString := FormatDateTime('YYYYMM',Date);
  CdsGoodsMonth.Close;
  CdsGoodsMonth.SQL.Text := ParseSQL(Factor.iDbType,EncodeSql(ID));
  Factor.Open(CdsGoodsMonth);
end;

procedure TfrmGoodsMonth.FormCreate(Sender: TObject);
begin
  inherited;
  edtMonth.asString := FormatDateTime('YYYYMM',Date);
  RzPage.ActivePageIndex := 0;
  AddGoodTypeItems(edtGoods_Type);
  edtGoods_Type.ItemIndex := 0;
  LoadTree(rzTree);
  InitGrid;
  ToolButton5.Enabled := False;
end;

procedure TfrmGoodsMonth.InitGrid;
var rs:TZQuery;
    Column:TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(dbGoodsMonth,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
end;

function TfrmGoodsMonth.FindColumn(DBGrid: TDBGridEh;
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

function TfrmGoodsMonth.TransUnit(CalcIdx: Integer; AliasTabName,
  AliasFileName: string): string;
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

procedure TfrmGoodsMonth.AddGoodsIDItems(edtGoods_ID: TzrComboboxList);
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

procedure TfrmGoodsMonth.edtGoods_TypePropertiesChange(Sender: TObject);
begin
  inherited;
  AddGoodsIDItems(edtGoods_Id);
end;

procedure TfrmGoodsMonth.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmGoodsMonth.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TfrmGoodsMonth.dbGoodsMonthColumns9UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var Org_Adj_Price:String;
begin
  inherited;
  if (Text = '') then Text := '0';
  Org_Adj_Price := CdsGoodsMonth.FieldByName('ADJ_PRICE').AsString;
  if Org_Adj_Price <> Text then IsModify := True;
  AdjpriceToAdjCst(StrToFloat(Text));
end;

procedure TfrmGoodsMonth.AdjpriceToAdjCst(Aprice: Real);
begin
  if not (CdsGoodsMonth.State in [dsEdit,dsInsert]) then CdsGoodsMonth.Edit;
  CdsGoodsMonth.FieldByName('ADJ_PRICE').AsFloat := Aprice;
  CdsGoodsMonth.FieldByName('ADJ_MNY').AsFloat := CdsGoodsMonth.FieldByName('BAL_AMT').AsFloat * Aprice;
  CdsGoodsMonth.FieldByName('ADJ_CST').AsFloat := (CdsGoodsMonth.FieldByName('BAL_AMT').AsFloat * Aprice) - CdsGoodsMonth.FieldByName('BAL_CST').AsFloat;
  CdsGoodsMonth.Post;
  CdsGoodsMonth.Edit;
end;

procedure TfrmGoodsMonth.BatchWrite;
var rs:TZQuery;
    GoodsId:String;
begin
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  GoodsId := CdsGoodsMonth.FieldByName('GODS_ID').AsString;

  CdsGoodsMonth.DisableControls;
  try
    CdsGoodsMonth.First;
    while not CdsGoodsMonth.Eof do
      begin
        if rs.Locate('GODS_ID',CdsGoodsMonth.FieldByName('GODS_ID').AsString,[]) then
          begin
            if not IsModify then IsModify := True;
            AdjpriceToAdjCst(rs.FieldByName('NEW_INPRICE').AsFloat);
          end;
        CdsGoodsMonth.Next;
      end;
    CdsGoodsMonth.Locate('GODS_ID',GoodsId,[]);
  finally
    CdsGoodsMonth.EnableControls;
  end;
end;

procedure TfrmGoodsMonth.N1Click(Sender: TObject);
begin
  inherited;
  BatchWrite;
end;

procedure TfrmGoodsMonth.actExitExecute(Sender: TObject);
begin
  inherited;
  Exit;
end;

procedure TfrmGoodsMonth.actSaveExecute(Sender: TObject);
begin
  inherited;
  Save;
  actCancelExecute(Sender);
end;

procedure TfrmGoodsMonth.Save;
begin
  if not IsModify then Exit;
  frmPrgBar.Show;
  frmPrgBar.Update;
  frmPrgBar.WaitHint := '开始提交数据...';
  frmPrgBar.Precent := 0;

  CdsGoodsMonth.DisableControls;
  try

    Factor.UpdateBatch(CdsGoodsMonth,'TGoodsMonth',nil);
  except
    CdsGoodsMonth.EnableControls;
    frmPrgBar.Close;
    Raise Exception.Create('数据提交失败!');
  end;
  CdsGoodsMonth.EnableControls;
  frmPrgBar.Close;
end;

procedure TfrmGoodsMonth.ucaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = dbGoodsMonth.CellRect(dbGoodsMonth.Col, dbGoodsMonth.Row).Top) and (not
    (gdFocused in State) or not dbGoodsMonth.Focused) then
  begin
    dbGoodsMonth.Canvas.Brush.Color := clAqua;
  end;
  
  dbGoodsMonth.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      dbGoodsMonth.canvas.FillRect(ARect);
      DrawText(dbGoodsMonth.Canvas.Handle,pchar(Inttostr(CdsGoodsMonth.RecNo)),length(Inttostr(CdsGoodsMonth.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmGoodsMonth.SetIsModify(const Value: Boolean);
begin
  FIsModify := Value;
  if Value then
    begin
      rzTree.Enabled := False;
      btnOk.Enabled := False;
      ToolButton5.Enabled := True;
    end;
end;

procedure TfrmGoodsMonth.actCancelExecute(Sender: TObject);
begin
  inherited;
  if IsModify then
    begin
      rzTree.Enabled := True;
      btnOk.Enabled := True;
      ToolButton5.Enabled := False;
    end;
  IsModify := False;
end;

procedure TfrmGoodsMonth.AdjCstToAdjprice(Acst: Real);
begin
  if Locked then Exit;
  try
    Locked := True;
    if not (CdsGoodsMonth.State in [dsEdit,dsInsert]) then CdsGoodsMonth.Edit;
    CdsGoodsMonth.FieldByName('ADJ_MNY').AsFloat := Acst;
    CdsGoodsMonth.FieldByName('ADJ_PRICE').AsFloat := Acst/CdsGoodsMonth.FieldByName('BAL_AMT').AsFloat;
    CdsGoodsMonth.FieldByName('ADJ_CST').AsFloat := Acst - CdsGoodsMonth.FieldByName('BAL_CST').AsFloat;
    CdsGoodsMonth.Post;
    CdsGoodsMonth.Edit;
  finally
    Locked := False;
  end;
end;

procedure TfrmGoodsMonth.dbGoodsMonthColumns10UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var Org_Adj_Cst:String;
begin
  inherited;
  if (Text = '') then Text := '0';
  Org_Adj_Cst := CdsGoodsMonth.FieldByName('ADJ_CST').AsString;
  if Org_Adj_Cst <> Text then IsModify := True;
  AdjCstToAdjprice(StrToFloat(Text));
end;

procedure TfrmGoodsMonth.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '月成本调整';

  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  dbGoodsMonth.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := dbGoodsMonth;
end;

procedure TfrmGoodsMonth.actPrintExecute(Sender: TObject);
begin
  inherited;
  PrintView;
  PrintDBGridEh1.Print;
end;

procedure TfrmGoodsMonth.actPreviewExecute(Sender: TObject);
begin
  inherited;
  PrintView;
  with TfrmEhLibReport.Create(self) do
  begin
    try
      Preview(PrintDBGridEh1);
    finally
      free;
    end;
  end;
end;

end.
