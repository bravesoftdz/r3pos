unit ufrmBatchAdjustPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, jpeg, ExtCtrls, RzTabs, RzPanel, cxButtonEdit, zrComboBoxList,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  RzButton, Grids, DBGridEh, RzTreeVw, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZBase, PrnDbgeh;

type
  TfrmBatchAdjustPrice = class(TframeToolForm)
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    Panel1: TPanel;
    Grid: TDBGridEh;
    RzPanel9: TRzPanel;
    Panel2: TPanel;
    Label21: TLabel;
    Label25: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    btnOk: TRzBitBtn;
    edtGoods_Type: TcxComboBox;
    edtGoods_ID: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtSHOP_VALUE: TzrComboBoxList;
    edtSHOP_TYPE: TcxComboBox;
    edtGoodsName: TzrComboBoxList;
    cdsPrice: TZQuery;
    dsPrice: TDataSource;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    RzPanel7: TRzPanel;
    Label3: TLabel;
    edtValue: TcxTextEdit;
    Label1: TLabel;
    Btn_OK: TRzBitBtn;
    PrintDBGridEh1: TPrintDBGridEh;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure edtSHOP_TYPEPropertiesChange(Sender: TObject);
    procedure edtGoods_TypePropertiesChange(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure GridColumns10UpdateData(Sender: TObject; var Text: String;
      var Value: Variant; var UseText, Handled: Boolean);
    procedure actNewExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure GridColumns9UpdateData(Sender: TObject; var Text: String;
      var Value: Variant; var UseText, Handled: Boolean);
    procedure actCancelExecute(Sender: TObject);
    procedure Btn_OKClick(Sender: TObject);
    procedure GridCellClick(Column: TColumnEh);
    procedure GridDrawFooterCell(Sender: TObject; DataCol, Row: Integer;
      Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
  private
    FdbState: TDataSetState;
    { Private declarations }
    function CheckCanExport:Boolean;
    procedure PrintView;
    procedure InitGrid;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
    procedure AddGoodTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111100000000000000');
    function  GetGodsStateValue(DefineState: string='11111111111111111111'): string;
    procedure SetdbState(const Value: TDataSetState); //返回商品指标的启用情况
  public
    { Public declarations }
    function EncodeSql:String;
    property dbState:TDataSetState read FdbState write SetdbState;
  end;

implementation
uses uTreeUtil,uGlobal, uShopGlobal,uCtrlUtil,uShopUtil,uFnUtil,ufrmEhLibReport,uDsUtil,StrUtils,
  ObjCommon,ufrmBasic, Math, uframeMDForm, ufrmPriceingInfo, uXDictFactory;
{$R *.dfm}

{ TfrmBatchAdjustPrice }

function TfrmBatchAdjustPrice.FindColumn(DBGrid: TDBGridEh;
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

procedure TfrmBatchAdjustPrice.InitGrid;
var rs:TZQuery;
    Column:TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(Grid,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
end;

procedure TfrmBatchAdjustPrice.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  AddGoodTypeItems(edtGoods_Type,GetGodsStateValue);
  edtGoodsName.DataSet := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtGoods_Type.ItemIndex := 0;
  edtSHOP_TYPE.ItemIndex := 0;
  InitGrid;
  dbState := dsBrowse;
end;

procedure TfrmBatchAdjustPrice.edtSHOP_TYPEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  case edtSHOP_TYPE.ItemIndex of
    0:edtSHOP_VALUE.DataSet := Global.GetZQueryFromName('PUB_REGION_INFO');
    1:edtSHOP_VALUE.DataSet := Global.GetZQueryFromName('PUB_SHOP_TYPE');
  end;
  edtSHOP_VALUE.KeyValue := null;
  edtSHOP_VALUE.Text := '';
end;

procedure TfrmBatchAdjustPrice.edtGoods_TypePropertiesChange(
  Sender: TObject);
var
  CodeID: string;
  ItemsIdx: integer;
begin
  inherited;
  if (edtGoods_Type.ItemIndex<>-1) then
  begin
    CodeID:=trim(TRecord_(edtGoods_Type.Properties.Items.Objects[edtGoods_Type.ItemIndex]).fieldbyName('CODE_ID').AsString);
    ItemsIdx:=StrtoIntDef(CodeID,0);
  end;
  if ItemsIdx<=0 then Exit;
  //清除上次选项
  edtGoods_ID.Text:='';
  edtGoods_ID.KeyValue:='';
  case ItemsIdx of
   3:
    begin
      edtGoods_ID.KeyField:='CLIENT_ID';
      edtGoods_ID.ListField:='CLIENT_NAME';
      edtGoods_ID.FilterFields:='CLIENT_ID;CLIENT_NAME;CLIENT_SPELL';
    end;
   else
    begin
      edtGoods_ID.KeyField:='SORT_ID';
      edtGoods_ID.ListField:='SORT_NAME';
      edtGoods_ID.FilterFields:='SORT_ID;SORT_NAME;SORT_SPELL';
    end;
  end;
  edtGoods_ID.Columns[0].FieldName:=edtGoods_ID.ListField;
  if edtGoods_ID.Columns.Count>1 then
    edtGoods_ID.Columns[1].FieldName:=edtGoods_ID.KeyField;
  case ItemsIdx of
   3: //主供应商;
    begin
      edtGoods_ID.RangeField:='';
      edtGoods_ID.RangeValue:='';
      edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');
    end;
   else
    begin
      edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_GOODS_INDEXS');
      edtGoods_ID.RangeField:='SORT_TYPE';
      edtGoods_ID.RangeValue:=InttoStr(ItemsIdx);
    end;
  end;
end;

procedure TfrmBatchAdjustPrice.AddGoodTypeItems(GoodSortList: TcxComboBox;
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

function TfrmBatchAdjustPrice.GetGodsStateValue(
  DefineState: string): string;
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

procedure TfrmBatchAdjustPrice.actFindExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('12100001',1) then Raise Exception.Create('你没有查询的权限,请和管理员联系.');
  cdsPrice.Close;
  cdsPrice.SQL.Text := ParseSQL(Factor.iDbType,EncodeSql);
  Factor.Open(cdsPrice);
end;

function TfrmBatchAdjustPrice.EncodeSql: String;
var StrSql,StrWhere,StrJoin:String;
    Item_Index:Integer;
begin
  case Factor.iDbType of
    0: StrJoin := '+';
    1,4,5: StrJoin := '||';
  end;
  StrWhere := ' where A.TENANT_ID='+IntToStr(Global.TENANT_ID);

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

  if (edtGoods_Type.ItemIndex>=0) and (trim(edtGoods_ID.AsString) <> '') then
  begin
    Item_Index := StrToIntDef(Trim(TRecord_(edtGoods_Type.Properties.Items.Objects[edtGoods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
    StrWhere := StrWhere + ' and A.SORT_ID'+InttoStr(Item_Index)+'='+QuotedStr(edtGoods_ID.AsString);
  end;

  if edtGoodsName.AsString<>'' then
    StrWhere := StrWhere + ' and A.GODS_ID='+QuotedStr(edtGoodsName.AsString);
  if edtSHOP_ID.AsString<>'' then
    StrWhere := StrWhere + ' and B.SHOP_ID='+QuotedStr(edtSHOP_ID.AsString);

  StrSql := 'select A.TENANT_ID,A.GODS_ID,A.GODS_CODE,A.GODS_NAME,A.BARCODE,C.SHOP_NAME,A.CALC_UNITS as UNIT_ID,isnull(A.NEW_OUTPRICE,0) as NEW_OUTPRICE_1,'+
  'isnull(B.NEW_OUTPRICE,0) as ORG_OUTPRICE,isnull(B.NEW_OUTPRICE1,0) as ORG_OUTPRICE1,isnull(B.NEW_OUTPRICE2,0) as ORG_OUTPRICE2,A.SMALLTO_CALC,A.BIGTO_CALC,'+
  'isnull(B.NEW_OUTPRICE,0)*1.00/A.NEW_OUTPRICE*100 as OUTPRICE_A_RATE,isnull(B.NEW_OUTPRICE,0) as NEW_OUTPRICE,isnull(B.NEW_OUTPRICE,0)*1.00/A.NEW_OUTPRICE*100 as NEW_OUTPRICE_RATE,'+
  'isnull(B.PRICE_ID,''#'') as PRICE_ID,isnull(B.SHOP_ID,'''+ShopGlobal.SHOP_ID+''') as SHOP_ID,isnull(B.PRICE_METHOD,''1'') as PRICE_METHOD,B.NEW_OUTPRICE1,B.NEW_OUTPRICE2 '+
  'from VIW_GOODSINFO A left join PUB_GOODSPRICE B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
  ' left join CA_SHOP_INFO C on B.TENANT_ID=C.TENANT_ID and B.SHOP_ID=C.SHOP_ID '+ StrWhere;
  Result := StrSql;
end;

procedure TfrmBatchAdjustPrice.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
    AFont:TFont;
    Num:String;
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
      DrawText(Grid.Canvas.Handle,pchar(Inttostr(cdsPrice.RecNo)),length(Inttostr(cdsPrice.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;

  if Column.FieldName = 'LOOK' then
    begin
      ARect := Rect;
      AFont := TFont.Create;
      AFont.Assign(Grid.Canvas.Font);
      try
        Grid.canvas.FillRect(ARect);
        Grid.Canvas.Font.Color := clBlue;
        Grid.Canvas.Font.Style := [fsUnderline];
        Num := '详情';
        DrawText(Grid.Canvas.Handle,pchar(Num),length(Num),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
      finally
        Grid.Canvas.Font.Assign(AFont);
        AFont.Free;
      end;
    end;

end;

procedure TfrmBatchAdjustPrice.GridColumns10UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;
begin
  inherited;
    try
      if Text='' then
         r := 0
      else
         r := StrtoFloat(Text);
      //if abs(r)>100 then Raise Exception.Create('输入的数值过大，无效');
      cdsPrice.Edit;
      cdsPrice.FieldByName('NEW_OUTPRICE').AsFloat := StrToFloat(FormatFloat('#0.00',(cdsPrice.FieldByName('NEW_OUTPRICE_1').AsFloat * r / 100)));
      cdsPrice.FieldByName('NEW_OUTPRICE1').AsFloat := cdsPrice.FieldByName('NEW_OUTPRICE').AsFloat*cdsPrice.FieldByName('SMALLTO_CALC').AsFloat;
      cdsPrice.FieldByName('NEW_OUTPRICE2').AsFloat := cdsPrice.FieldByName('NEW_OUTPRICE').AsFloat*cdsPrice.FieldByName('BIGTO_CALC').AsFloat;
      cdsPrice.Post;
      cdsPrice.Edit;
    except
      on E:Exception do
         begin
            Text := TColumnEh(Sender).Field.AsString;
            Value := TColumnEh(Sender).Field.asFloat;
            MessageBox(Handle,pchar('输入无效折扣率,错误：'+E.Message),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
            Exit;
         end;
    end;
end;

procedure TfrmBatchAdjustPrice.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('12100001',2) then Raise Exception.Create('你没有调价的权限,请和管理员联系.');
  if cdsPrice.IsEmpty then Exit;
  dbState := dsEdit;
end;

procedure TfrmBatchAdjustPrice.actSaveExecute(Sender: TObject);
begin
  inherited;
  if cdsPrice.IsEmpty then Exit;

  if Factor.UpdateBatch(cdsPrice,'TGoodsPrice') then
  begin
     dbState := dsBrowse;
     MessageBox(Handle,pchar('调价商品已保存!'),pchar(Application.Title),MB_OK);
  end
  else
     MessageBox(Handle,pchar('调价商品未保存!'),pchar(Application.Title),MB_OK);
end;

procedure TfrmBatchAdjustPrice.GridColumns9UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;
begin
  inherited;
    try
      if Text='' then
         r := 0
      else
         r := StrtoFloat(Text);
      //if abs(r)>100 then Raise Exception.Create('输入的数值过大，无效');
      cdsPrice.Edit;
      cdsPrice.FieldByName('NEW_OUTPRICE_RATE').AsFloat := cdsPrice.FieldByName('NEW_OUTPRICE').AsFloat / cdsPrice.FieldByName('NEW_OUTPRICE_1').AsFloat * 100;
      cdsPrice.Post;
      cdsPrice.Edit;
    except
      on E:Exception do
         begin
            Text := TColumnEh(Sender).Field.AsString;
            Value := TColumnEh(Sender).Field.asFloat;
            MessageBox(Handle,pchar('输入无效数值型,错误：'+E.Message),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
            Exit;
         end;
    end;
end;

procedure TfrmBatchAdjustPrice.actCancelExecute(Sender: TObject);
begin
  inherited;
  dbState := dsBrowse;
  actFindExecute(Sender);
end;

procedure TfrmBatchAdjustPrice.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  RzPanel7.Visible := Value <> dsBrowse;
  RzPanel9.Visible := Value = dsBrowse;
  Grid.ReadOnly := Value = dsBrowse;
  Panel2.Enabled := Value = dsBrowse;
  actNew.Enabled := Value = dsBrowse;
  actSave.Enabled := Value <> dsBrowse;
  actCancel.Enabled := Value <> dsBrowse;
  if Value <> dsBrowse then edtValue.SetFocus;
end;

procedure TfrmBatchAdjustPrice.Btn_OKClick(Sender: TObject);
var RateValue:Currency;
    i:Integer;
begin
  inherited;
  if not FnString.IsNumberChar(Trim(edtValue.Text)) then
  begin
     edtValue.SelectAll;
     edtValue.SetFocus;
     Raise Exception.Create('"'+Trim(edtValue.Text)+'"中存在非数字字符!');
  end;
  RateValue := edtValue.EditValue;
  i:=cdsPrice.RecNo;
  cdsPrice.DisableControls;
  try
   cdsPrice.First;
   while not cdsPrice.Eof do
   begin
     cdsPrice.Edit;
     cdsPrice.FieldByName('NEW_OUTPRICE_RATE').AsFloat := RateValue;
     cdsPrice.FieldByName('NEW_OUTPRICE').AsFloat := StrToFloat(FormatFloat('#0.00',(cdsPrice.FieldByName('NEW_OUTPRICE_1').AsFloat * RateValue / 100)));
     cdsPrice.FieldByName('NEW_OUTPRICE1').AsFloat := cdsPrice.FieldByName('NEW_OUTPRICE').AsFloat*cdsPrice.FieldByName('SMALLTO_CALC').AsFloat;
     cdsPrice.FieldByName('NEW_OUTPRICE2').AsFloat := cdsPrice.FieldByName('NEW_OUTPRICE').AsFloat*cdsPrice.FieldByName('BIGTO_CALC').AsFloat;
     cdsPrice.Post;
     cdsPrice.Next;
   end;

  finally
    cdsPrice.RecNo := i;
    cdsPrice.EnableControls;
  end;
end;

procedure TfrmBatchAdjustPrice.GridCellClick(Column: TColumnEh);
begin
  inherited;
  if cdsPrice.IsEmpty then Exit;

  if Column.FieldName = 'LOOK' then
  begin
     TfrmPriceingInfo.ShowDialog(Self,cdsPrice.FieldByName('GODS_ID').AsString,cdsPrice.FieldByName('SHOP_ID').AsString);
  end;
end;

procedure TfrmBatchAdjustPrice.GridDrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;
       {if FindColumn(Grid,'BARCODE') = nil then
          R.Right := Rect.Right
       else
          R.Right := Rect.Right + FindColumn(Grid,'BARCODE').Width;
        }
       Grid.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s笔',[Inttostr(cdsPrice.RecordCount)]);
       Grid.Canvas.Font.Style := [fsBold];
       Grid.Canvas.TextRect(R,(Rect.Right-Rect.Left-Grid.Canvas.TextWidth(s)) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmBatchAdjustPrice.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('12100001',4) then Raise Exception.Create('你没有打印的权限,请和管理员联系.');

  PrintView;
  PrintDBGridEh1.Print;
end;

procedure TfrmBatchAdjustPrice.PrintView;
begin
  PrintDBGridEh1.PageHeader.CenterText.Text := '批量调价';

  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+Global.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]','']);
  Grid.DataSource.DataSet.Filtered := False;
  PrintDBGridEh1.DBGridEh := Grid;
end;

procedure TfrmBatchAdjustPrice.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('12100001',4) then Raise Exception.Create('你没有预览的权限,请和管理员联系.');
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

function TfrmBatchAdjustPrice.CheckCanExport: Boolean;
begin
  Result := ShopGlobal.GetChkRight('12100001',5);
end;

end.
