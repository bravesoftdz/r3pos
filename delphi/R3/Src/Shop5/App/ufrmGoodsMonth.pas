unit ufrmGoodsMonth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, ExtCtrls, jpeg, RzTabs, RzPanel, cxButtonEdit, zrComboBoxList,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  RzButton, Grids, DBGridEh, RzTreeVw, DB, ZAbstractRODataset, zBase,
  ZAbstractDataset, ZDataset, zrMonthEdit;

type
  TfrmGoodsMonth = class(TframeToolForm)
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    Splitter1: TSplitter;
    RzPanel7: TRzPanel;
    rzTree: TRzTreeView;
    RzPanel8: TRzPanel;
    Panel1: TPanel;
    dbGoodsMonth: TDBGridEh;
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
    procedure FormCreate(Sender: TObject);
    procedure edtGoods_TypePropertiesChange(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure dbGoodsMonthColumns9UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure N1Click(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure dbGoodsMonthDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
  private
    { Private declarations }
    procedure LoadTree(Tree:TRzTreeView);
    procedure AddGoodTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111100000000000000');
    function TransCalcRate(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function TransUnit(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function TransPrice(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    procedure InitGrid;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
    procedure AddGoodsIDItems(edtGoods_ID:TzrComboboxList);
    procedure AdjpriceToAdjCst(Aprice:Real);
    procedure BatchWrite;
  public
    { Public declarations }
    function EncodeSql(ID:String):String;
    procedure Open(ID:String);
    procedure Save;
  end;

implementation
uses uTreeUtil,uGlobal,uShopGlobal,uCtrlUtil,uShopUtil,uFnUtil,ufrmEhLibReport,
     uDsUtil,ObjCommon,ufrmPrgBar, ufrmBasic;
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
  'select A.MONTH,A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.BATCH_NO,C.GODS_CODE,C.GODS_NAME,C.BARCODE as CALC_BARCODE,A.BAL_AMT,(case when A.BAL_CST = 0 then A.BAL_MNY else A.BAL_CST end) as BAL_CST,'+
  '(case when A.BAL_CST = 0 then A.BAL_MNY else A.BAL_CST end)/A.BAL_AMT as BAL_PRICE,A.ADJ_CST,(A.ADJ_CST+(case when A.BAL_CST = 0 then A.BAL_MNY else A.BAL_CST end))/A.BAL_AMT as ADJ_PRICE,'+
  'A.ADJ_CST+(case when A.BAL_CST = 0 then A.BAL_MNY else A.BAL_CST end) as ADJ_MNY,'+TransUnit(0,'C','UNIT_ID')+
  ' from RCK_GOODS_MONTH A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSPRICE_SORTEXT C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.GODS_ID=C.GODS_ID '+StrWhere;

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

function TfrmGoodsMonth.TransCalcRate(CalcIdx: Integer; AliasTabName,
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

function TfrmGoodsMonth.TransPrice(CalcIdx: Integer; AliasTabName,
  AliasFileName: string): string;
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
begin
  inherited;
  if (Text = '') or (Text = '0') then Exit;
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
          AdjpriceToAdjCst(rs.FieldByName('NEW_INPRICE').AsFloat);
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
end;

procedure TfrmGoodsMonth.Save;
var Str_TenantID,Str_ShopID,Str_BatchNO,Str_Month,Str_SQL:String;
    SumRecord,CurRecord:Integer;
begin
  frmPrgBar.Show;
  frmPrgBar.Update;
  frmPrgBar.WaitHint := '开始提交数据...';
  frmPrgBar.Precent := 0;

  CdsGoodsMonth.DisableControls;
  if Factor.iDbType <> 5 then Factor.BeginTrans;
  try
    Str_TenantID := CdsGoodsMonth.FieldByName('TENANT_ID').AsString;
    Str_ShopID := CdsGoodsMonth.FieldByName('SHOP_ID').AsString;
    Str_BatchNO := CdsGoodsMonth.FieldByName('BATCH_NO').AsString;
    Str_Month := CdsGoodsMonth.FieldByName('MONTH').AsString;
    SumRecord := CdsGoodsMonth.RecordCount;
    CdsGoodsMonth.First;
    while not CdsGoodsMonth.Eof do
      begin
        Str_SQL := 'update RCK_GOODS_MONTH set ADJ_CST='+CdsGoodsMonth.FieldByName('ADJ_CST').AsString+',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+
        ' where TENANT_ID='+Str_TenantID+' and SHOP_ID='+QuotedStr(Str_ShopID)+' and MONTH='+Str_Month+' and GODS_ID='+QuotedStr(CdsGoodsMonth.FieldByName('GODS_ID').AsString)+
        ' and BATCH_NO='+QuotedStr(Str_BatchNO);
        frmPrgBar.Precent := (CdsGoodsMonth.RecNo*100) div SumRecord;
        Factor.ExecSQL(Str_SQL);
        CdsGoodsMonth.Next;
      end;
    if Factor.iDbType <> 5 then Factor.CommitTrans;

  except
    if Factor.iDbType <> 5 then Factor.RollbackTrans;
    CdsGoodsMonth.EnableControls;
    frmPrgBar.Close;
    Raise Exception.Create('数据提交失败!');
  end;
  CdsGoodsMonth.EnableControls;
  frmPrgBar.Close; 
end;

procedure TfrmGoodsMonth.dbGoodsMonthDrawColumnCell(Sender: TObject;
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

end.
