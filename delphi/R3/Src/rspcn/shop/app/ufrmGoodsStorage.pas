unit ufrmGoodsStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzButton,
  cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, ComCtrls, RzTreeVw, Grids, DBGridEh, cxButtonEdit, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase,ObjCommon,
  zrComboBoxList, RzBorder, cxCheckBox;

type
  TfrmGoodsStorage = class(TfrmWebToolForm)
    lblCaption: TRzLabel;
    RzPanel15: TRzPanel;
    btnNav: TRzBitBtn;
    RzPanel11: TRzPanel;
    RzPanel13: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    rzTree: TRzTreeView;
    RzPanel6: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    btnPrint: TRzBitBtn;
    btnPreview: TRzBitBtn;
    btnAMOUNT: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RzBitBtn5: TRzBitBtn;
    RzPanel1: TRzPanel;
    sortDrop: TcxButtonEdit;
    dsList: TDataSource;
    cdsList: TZQuery;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzSpacer1: TRzSpacer;
    serachText: TEdit;
    EditPanel: TRzPanel;
    RzPanel9: TRzPanel;
    edtGODS_CODE: TcxTextEdit;
    RzPanel10: TRzPanel;
    edtGODS_NAME: TcxTextEdit;
    RzPanel12: TRzPanel;
    RzPanel14: TRzPanel;
    RzPanel16: TRzPanel;
    edtNEW_INPRICE: TcxTextEdit;
    RzPanel17: TRzPanel;
    edtNEW_OUTPRICE: TcxTextEdit;
    edtSHOP_NEW_OUTPRICE: TcxTextEdit;
    RzPanel18: TRzPanel;
    RzPanel19: TRzPanel;
    edtGODS_SPELL: TcxTextEdit;
    edtSORT_ID1: TcxButtonEdit;
    RzPanel20: TRzPanel;
    edtBARCODE: TcxTextEdit;
    edtCALC_UNITS: TzrComboBoxList;
    RzPanel21: TRzPanel;
    edtAMOUNT: TcxTextEdit;
    edtLOWER_AMOUNT: TcxTextEdit;
    RzPanel22: TRzPanel;
    RzPanel23: TRzPanel;
    edtUPPER_AMOUNT: TcxTextEdit;
    RzBorder1: TRzBorder;
    edtUNIT_ID_USING: TcxCheckBox;
    RzBitBtn6: TRzBitBtn;
    RzBitBtn7: TRzBitBtn;
    unitPanel: TRzPanel;
    RzPanel25: TRzPanel;
    edtSMALL_UNITS: TzrComboBoxList;
    RzPanel26: TRzPanel;
    edtSMALLTO_CALC: TcxTextEdit;
    RzPanel27: TRzPanel;
    edtBIG_UNITS: TzrComboBoxList;
    RzPanel28: TRzPanel;
    edtBIGTO_CALC: TcxTextEdit;
    cdsGoodsInfo: TZQuery;
    cdsHeader: TZQuery;
    cdsGodsRelation: TZQuery;
    cdsGoodsPrice: TZQuery;
    cdsGoodsExt: TZQuery;
    cdsBarcode: TZQuery;
    cdsDetail: TZQuery;
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnNavClick(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtSORT_ID1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtUNIT_ID_USINGClick(Sender: TObject);
    procedure RzToolButton2Click(Sender: TObject);
    procedure RzBitBtn7Click(Sender: TObject);
    procedure RzBitBtn6Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure btnAMOUNTClick(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
  private
    { Private declarations }
    ESortId:string;
    FSortId:string;
    relationId:integer;
    relationType:integer;
    AObj:TRecord_;
    storAmt:real;
    FdbState: TDataSetState;
    FstorFlag: integer;
    function FindColumn(fieldname:string):TColumnEh;
    function GetOpenWhere:string;
    procedure ReadInfo;
    procedure WriteInfo;
    procedure WriteOweOrder;
    procedure SetdbState(const Value: TDataSetState);virtual;
    procedure SetstorFlag(const Value: integer);
  public
    { Public declarations }
    procedure OpenInfo(godsId:string;Relation:integer=0);
    procedure SaveInfo;
    procedure DeleteInfo(godsId:string;Relation:integer=0);
    procedure Open;
    procedure showForm;override;

    property dbState:TDataSetState read FdbState write SetdbState;
    property storFlag:integer read FstorFlag write SetstorFlag;
  end;

implementation
uses ufrmSortDropFrom,udllDsUtil,udllFnUtil,udllGlobal,udataFactory,udllShopUtil,utokenFactory;
{$R *.dfm}

function getTodayId:string;
begin                                                    
  result := token.shopId+formatDatetime('YYYYMMDD',date())+'000000000000000';
end;
procedure TfrmGoodsStorage.sortDropPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  Obj:TRecord_;
begin
  inherited;
  Obj := TRecord_.Create;
  try
    if frmSortDropFrom.DropForm(sortDrop,obj) then
    begin
      FSortId := Obj.FieldbyName('SORT_ID').AsString;
      sortDrop.Text := Obj.FieldbyName('SORT_NAME').AsString;
    end;
  finally
    Obj.Free;
  end;
end;

procedure TfrmGoodsStorage.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+1,ARect.Top+1,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
       end
    else
       DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := DBGridEh1.FixedColor;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmGoodsStorage.showForm;
var
  rs:TZQuery;
  column:TColumnEh;
begin
  inherited;
  storFlag := 0;
  dllGlobal.CreateGoodsSortTree(rzTree,true);
  edtCALC_UNITS.DataSet := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  edtSMALL_UNITS.DataSet := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  edtBIG_UNITS.DataSet := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
  column := FindColumn('SORT_ID1');
  rs.First;
  while not rs.Eof do
    begin
      column.KeyList.Add(rs.FieldbyName('SORT_ID').AsString);
      column.PickList.Add(rs.FieldbyName('SORT_NAME').AsString);
      rs.Next;
    end;
  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  column := FindColumn('CALC_UNITS');
  rs.First;
  while not rs.Eof do
    begin
      column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  Open;
end;

procedure TfrmGoodsStorage.Open;
begin
  cdsList.Close;
  cdsList.SQL.Text :=
    ParseSQL(dataFactory.iDbType,
   'select 0 as A,jp.*,isnull(shp.NEW_OUTPRICE,jp.NEW_OUTPRICE_P) as NEW_OUTPRICE from ('+
   'select j.TENANT_ID,'''+token.shopId+''' as CUR_SHOP_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.SORT_ID1,j.RELATION_ID,j.CALC_UNITS,j.PRICE_ID,c.AMOUNT,'+
   'isnull(ext.NEW_INPRICE,j.NEW_INPRICE) as NEW_INPRICE,'+
   'isnull(prc.NEW_OUTPRICE,j.NEW_OUTPRICE) as NEW_OUTPRICE_P '+
   'from ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,SHOP_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS,NEW_INPRICE,NEW_OUTPRICE,RELATION_ID,PRICE_ID')+') j '+
   'left outer join (select TENANT_ID,GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+''' group by TENANT_ID,GODS_ID) c on j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID '+
   'left outer join  PUB_GOODSINFOEXT ext on j.TENANT_ID=ext.TENANT_ID and j.GODS_ID=ext.GODS_ID '+
   'left outer join  PUB_GOODSPRICE prc on j.TENANT_ID=prc.TENANT_ID and j.GODS_ID=prc.GODS_ID and j.SHOP_ID=prc.SHOP_ID and j.PRICE_ID=trim(prc.PRICE_ID) ) jp '+
   'left outer join  PUB_GOODSPRICE shp on jp.TENANT_ID=shp.TENANT_ID and jp.GODS_ID=shp.GODS_ID and jp.CUR_SHOP_ID=shp.SHOP_ID and jp.PRICE_ID=trim(shp.PRICE_ID) '+GetOpenWhere
  );
  dataFactory.Open(cdsList);
end;

function TfrmGoodsStorage.FindColumn(fieldname: string): TColumnEh;
var
  i:integer;
begin
  for i:=0 to DBGridEh1.Columns.Count-1 do
    begin
      if lowercase(DBGridEh1.Columns[i].FieldName)=lowercase(fieldname) then
         begin
           result := DBGridEh1.Columns[i];
           break;
         end;
    end;
end;

function TfrmGoodsStorage.GetOpenWhere: string;
function getSortId(node:TTreeNode):string;
var
  child:TTreeNode;
begin
  if result<>'' then result := result +',';
  result := result + ''''+TRecord_(node.Data).FieldbyName('SORT_ID').AsString+'''';
  child := node.getFirstChild;
  while child<>nil do
    begin
      result := getSortId(node);
      child := node.GetNextChild(child);
    end;
end;
var
  w:string;
begin
  if Assigned(rzTree.Selected) and (rzTree.Selected.Level>0) then
     begin
       if rzTree.Selected.Level=1 then
          begin
            result := ' jp.RELATION_ID='+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString+'';
          end
       else
          begin
            result := ' jp.RELATION_ID='+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString+' and jp.SORT_ID1 in ('+getSortId(rzTree.Selected)+')';
          end;
     end;
  if trim(serachText.Text) <> '' then
     begin
       if result <> '' then result := result +' and ';
       result := result + '(jp.GODS_NAME like ''%'+trim(serachText.Text)+'%'' or jp.GODS_CODE like ''%'+trim(serachText.Text)+'%'' or jp.BARCODE like ''%'+trim(serachText.Text)+'%'')';
     end;
  case storFlag of
  0:begin
      w :=' where ';
      if result<>'' then result := w+result else result := '';
    end;
  1:begin
      w :=' where AMOUNT<>0 ';
      if result<>'' then result := w+' and '+result else result := w;
    end;
  end;

end;

procedure TfrmGoodsStorage.btnNavClick(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TfrmGoodsStorage.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if rzTree.Focused then Open;
end;

procedure TfrmGoodsStorage.OpenInfo(godsId: string;Relation:integer=0);
function getRelatonTenant(flag:integer):integer;
var
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  if rs.Locate('RELATION_ID',relation,[]) then
     begin
       relationId := relation;
       relationType := rs.FieldbyName('RELATION_TYPE').AsInteger;
       case flag of
       0:result := rs.FieldbyName('TENANT_ID').AsInteger;
       else
         begin
           if rs.FieldbyName('RELATION_TYPE').AsInteger=1 then
              result := rs.FieldbyName('TENANT_ID').AsInteger
           else
              result := rs.FieldbyName('P_TENANT_ID').AsInteger;
         end;
       end;
     end
  else
     raise Exception.Create('缓存中没找到当前供应链，数据同步后重试'); 
end;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('CHANGE_ID').AsString := getTodayId;
    Params.ParamByName('RELATION_ID').AsInteger := Relation;
    dataFactory.BeginBatch;
    try
       if Relation=0 then
          Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId)
       else
          Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(0);
       dataFactory.AddBatch(cdsGoodsInfo,'TGoodsInfoV60',Params);
       dataFactory.AddBatch(cdsBarcode,'TBarCodeV60',Params);
       Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(1);
       dataFactory.AddBatch(cdsGodsRelation,'TGoodsRelationV60',Params);
       Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       dataFactory.AddBatch(cdsGoodsPrice,'TGoodsPriceV60',Params);
       dataFactory.AddBatch(cdsGoodsExt,'TGoodsInfoExtV60',Params);
       dataFactory.AddBatch(cdsHeader,'TChangeOrderV60',Params);
       dataFactory.AddBatch(cdsDetail,'TChangeDataV60',Params);
       dataFactory.OpenBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;
    ReadInfo;
    dbState := dsEdit;
    EditPanel.Visible := true;
    if edtBARCODE.CanFocus then edtBARCODE.SetFocus;
  finally
    Params.Free;
  end;
end;

procedure TfrmGoodsStorage.SaveInfo;
begin
  WriteInfo;
  dataFactory.BeginBatch;
  try
     dataFactory.AddBatch(cdsGoodsInfo,'TGoodsInfoV60',nil);
     dataFactory.AddBatch(cdsBarcode,'TBarCodeV60',nil);
     dataFactory.AddBatch(cdsGodsRelation,'TGoodsRelationV60',nil);
     dataFactory.AddBatch(cdsGoodsPrice,'TGoodsPriceV60',nil);
     dataFactory.AddBatch(cdsGoodsExt,'TGoodsInfoExtV60',nil);
     dataFactory.AddBatch(cdsHeader,'TChangeOrderV60',nil);
     dataFactory.AddBatch(cdsDetail,'TChangeDataV60',nil);
     dataFactory.CommitBatch;
  except
     dataFactory.CancelBatch;
     Raise;
  end;
  if cdsList.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then
     begin
       cdsList.Edit;
       cdsList.FieldByName('GODS_NAME').AsString := edtGODS_NAME.Text;
       cdsList.FieldByName('GODS_CODE').AsString := edtGODS_CODE.Text;
       cdsList.FieldByName('SORT_ID1').AsString := ESortId;
       cdsList.FieldByName('CALC_UNITS').AsString := edtCALC_UNITS.AsString;
       cdsList.FieldByName('NEW_INPRICE').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0);
       cdsList.FieldByName('NEW_OUTPRICE').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0);
       cdsList.FieldByName('BARCODE').AsString := edtBARCODE.Text;
       cdsList.FieldByName('AMOUNT').AsString := edtAMOUNT.Text;
       cdsList.Post;
     end;
end;

procedure TfrmGoodsStorage.ReadInfo;
begin
  AObj.ReadFromDataSet(cdsGoodsInfo);
  ReadFromObject(AObj,self);
  ESortId := AObj.FieldByName('SORT_ID1').AsString;
  edtSORT_ID1.Text := TdsFind.GetNameByID(dllGlobal.GetZQueryFromName('PUB_GOODSSORT'),'SORT_ID','SORT_NAME',AObj.FieldByName('SORT_ID1').AsString);
  if (AObj.FieldByName('TENANT_ID').AsString<>token.tenantId) and not cdsGodsRelation.IsEmpty then //如果是经销商加盟的商品，可能重命名。
     begin
       if cdsGodsRelation.FieldByName('GODS_CODE').AsString <> '' then
          edtGODS_CODE.Text := cdsGodsRelation.FieldByName('GODS_CODE').AsString;
       if cdsGodsRelation.FieldByName('GODS_NAME').AsString <> '' then
          edtGODS_NAME.Text := cdsGodsRelation.FieldByName('GODS_NAME').AsString;
       if cdsGodsRelation.FieldByName('GODS_SPELL').AsString <> '' then
          edtGODS_SPELL.Text := cdsGodsRelation.FieldByName('GODS_SPELL').AsString;
       if cdsGodsRelation.FieldByName('SORT_ID1').AsString <> '' then
          begin
            ESortId := cdsGodsRelation.FieldByName('SORT_ID1').AsString;
            edtSORT_ID1.Text := TdsFind.GetNameByID(dllGlobal.GetZQueryFromName('PUB_GOODSSORT'),'SORT_ID','SORT_NAME',cdsGodsRelation.FieldByName('SORT_ID1').AsString);
          end;
       if cdsGodsRelation.FieldByName('NEW_INPRICE').AsString <> '' then
          edtNEW_INPRICE.Text := cdsGodsRelation.FieldByName('NEW_INPRICE').AsString;
       if cdsGodsRelation.FieldByName('NEW_OUTPRICE').AsString <> '' then
          edtNEW_OUTPRICE.Text := cdsGodsRelation.FieldByName('NEW_OUTPRICE').AsString;
     end;
  if not cdsGoodsExt.IsEmpty then
      begin
        edtNEW_INPRICE.Text := cdsGoodsExt.FieldbyName('NEW_INPRICE').AsString;
      end;
  edtSHOP_NEW_OUTPRICE.Text := edtNEW_OUTPRICE.Text;
  if not cdsGoodsPrice.IsEmpty then
      begin
        cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]);
        edtSHOP_NEW_OUTPRICE.Text := cdsGoodsPrice.FieldbyName('NEW_OUTPRICE').AsString;
      end;
  edtLOWER_AMOUNT.Text := formatFloat('#0.###',cdsGoodsExt.FieldByName('LOWER_AMOUNT').AsFloat);
  edtUPPER_AMOUNT.Text := formatFloat('#0.###',cdsGoodsExt.FieldByName('UPPER_AMOUNT').AsFloat);
  edtUNIT_ID_USING.Checked := (AObj.FieldbyName('SMALL_UNITS').AsString<>'') or (AObj.FieldbyName('BIG_UNITS').AsString<>'');

  storAmt := cdsList.FieldbyName('AMOUNT').AsFloat;
  edtAMOUNT.Text := formatFloat('#0.###',storAmt);
end;

procedure TfrmGoodsStorage.WriteInfo;
var
  isDel:boolean;
begin
  WriteToObject(AObj,self);
  if relationId=0 then  //自经营
     begin
       cdsGoodsInfo.Edit;
       AObj.WriteToDataSet(cdsGoodsInfo);
       cdsGoodsInfo.FieldbyName('SORT_ID1').AsString := ESortId;
       cdsGoodsInfo.Post;
       cdsGodsRelation.CancelUpdates;
       if cdsBarcode.Locate('BARCODE_TYPE','0',[]) then
          begin
            cdsBarcode.Edit;
            cdsBarcode.FieldbyName('BARCODE').AsString := edtBARCODE.Text;
            cdsBarcode.Post; 
          end;
     end
  else
     begin
        cdsGoodsInfo.CancelUpdates;
        if (relationType=1) and not cdsGodsRelation.IsEmpty then //经销商加盟
           begin
             cdsGodsRelation.Edit;
             cdsGodsRelation.FieldbyName('GODS_CODE').AsString := edtGODS_CODE.Text;
             cdsGodsRelation.FieldbyName('GODS_NAME').AsString := edtGODS_NAME.Text;
             cdsGodsRelation.FieldbyName('GODS_SPELL').AsString := edtGODS_SPELL.Text;
             cdsGodsRelation.FieldbyName('NEW_OUTPRICE').AsFloat := StrtoFloatDef(edtNEW_OUTPRICE.Text,0);
             cdsGodsRelation.FieldbyName('SORT_ID1').AsString := ESortId;
             cdsGodsRelation.Post;
           end;
     end;

  if cdsGoodsExt.IsEmpty then cdsGoodsExt.Append else cdsGoodsExt.Edit;
  cdsGoodsExt.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
  cdsGoodsExt.FieldByName('GODS_ID').asString := AObj.FieldbyName('GODS_ID').asString;
  cdsGoodsExt.FieldByName('NEW_INPRICE').AsFloat  := StrtoFloatDef(edtNEW_INPRICE.Text,0);
  cdsGoodsExt.FieldByName('NEW_INPRICE1').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0)*StrtoFloatDef(edtSMALLTO_CALC.TEXT,0);
  cdsGoodsExt.FieldByName('NEW_INPRICE2').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0)*StrtoFloatDef(edtBIGTO_CALC.TEXT,0);
  cdsGoodsExt.FieldByName('LOWER_AMOUNT').AsFloat := StrtoFloatDef(edtLOWER_AMOUNT.Text,0);
  cdsGoodsExt.FieldByName('UPPER_AMOUNT').AsFloat := StrtoFloatDef(edtUPPER_AMOUNT.Text,0);
  cdsGoodsExt.Post;
  
  if FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0))=0 then
     begin
        isDel := false;
        if cdsGoodsPrice.Locate('SHOP_ID',token.tenantId+'0001',[]) and
           (FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0),cdsGoodsPrice.FieldByName('NEW_OUTPRICE').AsFloat)=0)
        then
           isDel := true;
        if cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]) and (cdsGoodsPrice.RecordCount=1) then
           isDel := true;
        if IsDel and cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]) then cdsGoodsPrice.Delete;
     end;
  if not isDel then
     begin
       cdsGoodsPrice.Edit;
       cdsGoodsPrice.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       cdsGoodsPrice.FieldByName('PRICE_ID').asString :=  '#';
       cdsGoodsPrice.FieldByName('SHOP_ID').asString := token.shopId;
       cdsGoodsPrice.FieldByName('GODS_ID').asString := AObj.FieldbyName('GODS_ID').asString;
       cdsGoodsPrice.FieldByName('PRICE_METHOD').asString := '1';
       cdsGoodsPrice.FieldByName('NEW_OUTPRICE').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0);
       cdsGoodsPrice.FieldByName('NEW_OUTPRICE1').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)*StrtoFloatDef(edtSMALLTO_CALC.TEXT,0);
       cdsGoodsPrice.FieldByName('NEW_OUTPRICE2').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)*StrtoFloatDef(edtBIGTO_CALC.TEXT,0);
       cdsGoodsPrice.Post;
     end;
  WriteOweOrder;
end;

procedure TfrmGoodsStorage.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  SetFormEditStatus(self,Value);
  if relationId=0 then Exit;
  SetEditStyle(dsBrowse,edtBARCODE.Style);
  edtBARCODE.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtCALC_UNITS.Style);
  edtCALC_UNITS.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtSMALL_UNITS.Style);
  edtSMALL_UNITS.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtBIG_UNITS.Style);
  edtBIG_UNITS.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtBIGTO_CALC.Style);
  edtBIGTO_CALC.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtSMALLTO_CALC.Style);
  edtSMALLTO_CALC.Properties.ReadOnly := true;
  if not dllGlobal.checkChangePrice(relationId) then
     begin
        SetEditStyle(dsBrowse,edtNEW_INPRICE.Style);
        edtNEW_INPRICE.Properties.ReadOnly := true;
        SetEditStyle(dsBrowse,edtNEW_OUTPRICE.Style);
        edtNEW_OUTPRICE.Properties.ReadOnly := true;
     end;
  if relationType=1 then Exit;
  SetEditStyle(dsBrowse,edtNEW_OUTPRICE.Style);
  edtNEW_OUTPRICE.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtGODS_CODE.Style);
  edtGODS_CODE.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtGODS_NAME.Style);
  edtGODS_NAME.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtSORT_ID1.Style);
  edtSORT_ID1.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtGODS_SPELL.Style);
  edtGODS_SPELL.Properties.ReadOnly := true;

end;

procedure TfrmGoodsStorage.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;

end;

procedure TfrmGoodsStorage.FormDestroy(Sender: TObject);
begin
  AObj.Free;
  inherited;

end;

procedure TfrmGoodsStorage.edtSORT_ID1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  Obj:TRecord_;
begin
  inherited;
  Obj := TRecord_.Create;
  try
    if frmSortDropFrom.DropForm(edtSORT_ID1,obj) then
    begin
      ESortId := Obj.FieldbyName('SORT_ID').AsString;
      edtSORT_ID1.Text := Obj.FieldbyName('SORT_NAME').AsString;
    end;
  finally
    Obj.Free;
  end;
end;

procedure TfrmGoodsStorage.edtUNIT_ID_USINGClick(Sender: TObject);
begin
  inherited;
  unitPanel.Visible := edtUNIT_ID_USING.Checked;
end;

procedure TfrmGoodsStorage.RzToolButton2Click(Sender: TObject);
begin
  inherited;
  openinfo(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
end;

procedure TfrmGoodsStorage.RzBitBtn7Click(Sender: TObject);
begin
  inherited;
  EditPanel.Visible := false;
end;

procedure TfrmGoodsStorage.RzBitBtn6Click(Sender: TObject);
begin
  inherited;
  SaveInfo;
  EditPanel.Visible := false;
end;

procedure TfrmGoodsStorage.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  openinfo(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
end;

procedure TfrmGoodsStorage.WriteOweOrder;
var
  rs:TZQuery;
  curAmt,CHANGE_MNY,CHANGE_AMT:Real;
  rowId:integer;
begin
  if storAmt=StrtoFloatDef(edtAMOUNT.Text,0) then Exit;
  //保存单据
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select AMOUNT,BATCH_NO,PROPERTY_01,PROPERTY_02 from STO_STORAGE where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    rs.ParamByName('GODS_ID').asString := AObj.FieldbyName('GODS_ID').asString;
    rs.ParamByName('SHOP_ID').asString := token.shopId;
    dataFactory.Open(rs);
    if not rs.IsEmpty then
       begin
         if rs.RecordCount>1 then Raise Exception.Create('存在多批号库存，不能完成盘点');
         if (rs.FieldByName('BATCH_NO').AsString<>'#') or (rs.FieldByName('PROPERTY_01').AsString<>'#') or (rs.FieldByName('PROPERTY_02').AsString<>'#') then Raise Exception.Create('存在多批号库存，不能完成盘点');
       end;
    curAmt := rs.Fields[0].AsFloat;
  finally
    rs.Free;
  end;
  
  cdsHeader.Edit;
  cdsHeader.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
  cdsHeader.FieldByName('CHANGE_ID').AsString := getTodayId;
  cdsHeader.FieldByName('SHOP_ID').AsString := token.shopId;
  cdsHeader.FieldByName('CHANGE_DATE').AsString := formatDatetime('YYYYMMDD',date());
  cdsHeader.FieldByName('CHANGE_TYPE').AsString := '2';
  cdsHeader.FieldByName('CHANGE_CODE').AsString := '1';
  cdsHeader.FieldByName('DUTY_USER').AsString := token.userId;
  cdsHeader.FieldByName('CHK_DATE').AsString := formatDatetime('YYYY-MM-DD',date());
  cdsHeader.FieldByName('CHK_USER').AsString := token.userId;
  cdsHeader.FieldByName('CREA_USER').AsString := token.userId;
  cdsHeader.FieldByName('CREA_DATE').AsString := formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  cdsHeader.FieldByName('DEPT_ID').AsString := dllGlobal.getMyDeptId;
  cdsHeader.Post;
  
  if cdsDetail.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').asString,[]) then
     begin
       cdsDetail.Edit;
       cdsDetail.FieldbyName('AMOUNT').AsFloat := cdsDetail.FieldbyName('AMOUNT').AsFloat - (StrtoFloatDef(edtAMOUNT.Text,0)-curAmt);
       cdsDetail.FieldbyName('CALC_AMOUNT').AsFloat := cdsDetail.FieldbyName('AMOUNT').AsFloat;
       cdsDetail.FieldbyName('AMONEY').AsString := formatFloat('#0.00',cdsDetail.FieldbyName('AMOUNT').AsFloat*cdsDetail.FieldbyName('APRICE').AsFloat);
       cdsDetail.FieldbyName('CALC_MONEY').AsString := cdsDetail.FieldbyName('AMONEY').AsString;
       cdsDetail.Post;
     end
  else
     begin
       rowId := cdsDetail.RecordCount+1;
       cdsDetail.Append;
       cdsDetail.FieldbyName('TENANT_ID').AsString := cdsHeader.FieldByName('TENANT_ID').AsString;
       cdsDetail.FieldbyName('CHANGE_ID').AsString := cdsHeader.FieldByName('CHANGE_ID').AsString;
       cdsDetail.FieldbyName('SHOP_ID').AsString := cdsHeader.FieldByName('SHOP_ID').AsString;
       cdsDetail.FieldbyName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').asString;
       cdsDetail.FieldbyName('SEQNO').AsInteger := rowId;
       cdsDetail.FieldbyName('UNIT_ID').AsString := edtCALC_UNITS.KeyValue;
       cdsDetail.FieldbyName('IS_PRESENT').AsInteger := 0;
       cdsDetail.FieldbyName('BATCH_NO').AsString := '#';
       cdsDetail.FieldbyName('PROPERTY_01').AsString := '#';
       cdsDetail.FieldbyName('PROPERTY_02').AsString := '#';
       cdsDetail.FieldbyName('AMOUNT').AsFloat := -(StrtoFloatDef(edtAMOUNT.Text,0)-curAmt);
       cdsDetail.FieldbyName('CALC_AMOUNT').AsFloat := cdsDetail.FieldbyName('AMOUNT').AsFloat;
       cdsDetail.FieldbyName('AMONEY').AsString := formatFloat('#0.00',cdsDetail.FieldbyName('AMOUNT').AsFloat*cdsDetail.FieldbyName('APRICE').AsFloat);
       cdsDetail.FieldbyName('CALC_MONEY').AsString := cdsDetail.FieldbyName('AMONEY').AsString;
       cdsDetail.Post;
     end;
  cdsDetail.First;
  while not cdsDetail.Eof do
    begin
      CHANGE_MNY := CHANGE_MNY + cdsDetail.FieldbyName('CALC_MONEY').AsFloat;
      CHANGE_AMT := CHANGE_AMT + cdsDetail.FieldbyName('CALC_AMOUNT').AsFloat;
      cdsDetail.Next;
    end;
  cdsHeader.Edit;
  cdsHeader.FieldByName('CHANGE_AMT').AsFloat := CHANGE_AMT;
  cdsHeader.FieldByName('CHANGE_MNY').AsFloat := CHANGE_MNY;
  cdsHeader.Post;
end;

procedure TfrmGoodsStorage.SetstorFlag(const Value: integer);
begin
  FstorFlag := Value;
  case value of
  0:btnAMOUNT.Caption := '隐藏零库存';
  1:btnAMOUNT.Caption := '显示全部';
  end;
end;

procedure TfrmGoodsStorage.btnAMOUNTClick(Sender: TObject);
begin
  inherited;
  case storFlag of
  0:storFlag := 1;
  1:storFlag := 0;
  end;
  Open;
end;

procedure TfrmGoodsStorage.DeleteInfo(godsId: string;Relation:integer=0);
function getRelatonTenant(flag:integer):integer;
var
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  if rs.Locate('RELATION_ID',relation,[]) then
     begin
       relationId := relation;
       relationType := rs.FieldbyName('RELATION_TYPE').AsInteger;
       case flag of
       0:result := rs.FieldbyName('TENANT_ID').AsInteger;
       else
         begin
           if rs.FieldbyName('RELATION_TYPE').AsInteger=1 then
              result := rs.FieldbyName('TENANT_ID').AsInteger
           else
              Raise Exception.Create('不能删除供应链中的商品');
         end;
       end;
     end
  else
     raise Exception.Create('缓存中没找到当前供应链，数据同步后重试'); 
end;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('CHANGE_ID').AsString := getTodayId;
    Params.ParamByName('RELATION_ID').AsInteger := Relation;
    dataFactory.BeginBatch;
    try
       if Relation=0 then
          Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId)
       else
          Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(0);
       dataFactory.AddBatch(cdsGoodsInfo,'TGoodsInfoV60',Params);
       dataFactory.AddBatch(cdsBarcode,'TBarCodeV60',Params);
       Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(1);
       dataFactory.AddBatch(cdsGodsRelation,'TGoodsRelationV60',Params);
       Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       dataFactory.AddBatch(cdsGoodsPrice,'TGoodsPriceV60',Params);
       dataFactory.AddBatch(cdsGoodsExt,'TGoodsInfoExtV60',Params);
       dataFactory.OpenBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;
    case RelationId of
    0:begin
        cdsGoodsInfo.Delete;
        cdsBarcode.First;
        cdsGodsRelation.Delete;
        while not cdsBarcode.IsEmpty do cdsBarcode.Delete;
        cdsGoodsPrice.First;
        while not cdsGoodsPrice.IsEmpty do cdsGoodsPrice.Delete;
        cdsGoodsExt.Delete;
      end
    else
      begin
        cdsGodsRelation.Delete;
        cdsGoodsPrice.First;
        while not cdsGoodsPrice.IsEmpty do cdsGoodsPrice.Delete;
        cdsGoodsExt.Delete;
      end;
    end;
    dataFactory.BeginBatch;
    try
       dataFactory.AddBatch(cdsGoodsInfo,'TGoodsInfoV60',nil);
       dataFactory.AddBatch(cdsBarcode,'TBarCodeV60',nil);
       dataFactory.AddBatch(cdsGodsRelation,'TGoodsRelationV60',nil);
       dataFactory.AddBatch(cdsGoodsPrice,'TGoodsPriceV60',nil);
       dataFactory.AddBatch(cdsGoodsExt,'TGoodsInfoExtV60',nil);
       dataFactory.CommitBatch;
    except
       dataFactory.CancelBatch;
       Raise;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmGoodsStorage.RzToolButton1Click(Sender: TObject);
begin
  inherited;
  DeleteInfo(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
end;

initialization
  RegisterClass(TfrmGoodsStorage);
finalization
  UnRegisterClass(TfrmGoodsStorage);
end.
