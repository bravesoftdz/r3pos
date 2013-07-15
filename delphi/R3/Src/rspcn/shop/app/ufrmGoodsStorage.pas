unit ufrmGoodsStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzButton,
  cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, ComCtrls, RzTreeVw, Grids, DBGridEh, cxButtonEdit, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase,ObjCommon,
  zrComboBoxList, RzBorder, cxCheckBox, RzBmpBtn, RzBckgnd, Menus, PrnDbgeh;

type
  TfrmGoodsStorage = class(TfrmWebToolForm)
    RzPanel11: TRzPanel;
    RzPanel13: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    rzTree: TRzTreeView;
    RzPanel6: TRzPanel;
    btnNewSort: TRzBitBtn;
    RzPanel1: TRzPanel;
    sortDrop: TcxButtonEdit;
    dsList: TDataSource;
    cdsList: TZQuery;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    rowToolNav: TRzToolbar;
    toolDelete: TRzToolButton;
    toolEdit: TRzToolButton;
    toolSpacer: TRzSpacer;
    EditPanel: TRzPanel;
    RzBorder1: TRzBorder;
    cdsGoodsInfo: TZQuery;
    cdsHeader: TZQuery;
    cdsGodsRelation: TZQuery;
    cdsGoodsPrice: TZQuery;
    cdsGoodsExt: TZQuery;
    cdsBarcode: TZQuery;
    cdsDetail: TZQuery;
    lblCaption: TRzLabel;
    RzPanel8: TRzPanel;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    RzPanel15: TRzPanel;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    serachText: TEdit;
    btnFind: TRzBmpButton;
    btnSave: TRzBmpButton;
    RzBmpButton5: TRzBmpButton;
    btnAMOUNT: TRzBmpButton;
    RzBmpButton6: TRzBmpButton;
    RzBmpButton7: TRzBmpButton;
    edtBK_BARCODE: TRzPanel;
    RzPanel24: TRzPanel;
    RzLabel6: TRzLabel;
    edtBARCODE: TcxTextEdit;
    edtBK_GODS_CODE: TRzPanel;
    RzPanel29: TRzPanel;
    RzLabel1: TRzLabel;
    edtGODS_CODE: TcxTextEdit;
    edtBK_GODS_NAME: TRzPanel;
    RzPanel30: TRzPanel;
    RzLabel2: TRzLabel;
    edtGODS_NAME: TcxTextEdit;
    RzPanel31: TRzPanel;
    RzLabel16: TRzLabel;
    edtGODS_SPELL: TcxTextEdit;
    edtBK_SORT_ID1: TRzPanel;
    RzPanel19: TRzPanel;
    RzLabel3: TRzLabel;
    edtSORT_ID1: TcxButtonEdit;
    edtBK_CALC_UNITS: TRzPanel;
    RzPanel32: TRzPanel;
    RzLabel4: TRzLabel;
    edtCALC_UNITS: TzrComboBoxList;
    edtUNIT_ID_USING: TcxCheckBox;
    edtBK_SMALL_UNITS: TRzPanel;
    RzPanel33: TRzPanel;
    RzLabel5: TRzLabel;
    RzPanel34: TRzPanel;
    RzLabel7: TRzLabel;
    edtSMALL_UNITS: TzrComboBoxList;
    edtSMALLTO_CALC: TcxTextEdit;
    edtBK_BIG_UNITS: TRzPanel;
    RzPanel35: TRzPanel;
    RzLabel8: TRzLabel;
    RzPanel36: TRzPanel;
    RzLabel9: TRzLabel;
    edtBIG_UNITS: TzrComboBoxList;
    edtBIGTO_CALC: TcxTextEdit;
    edtBK_NEW_INPRICE: TRzPanel;
    RzPanel25: TRzPanel;
    RzLabel10: TRzLabel;
    edtNEW_INPRICE: TcxTextEdit;
    edtBK_NEW_OUTPRICE: TRzPanel;
    RzPanel26: TRzPanel;
    RzLabel11: TRzLabel;
    edtNEW_OUTPRICE: TcxTextEdit;
    edtBK_SHOW_NEW_OUTPRICE: TRzPanel;
    RzPanel27: TRzPanel;
    RzLabel12: TRzLabel;
    edtSHOP_NEW_OUTPRICE: TcxTextEdit;
    edtBK_AMOUNT: TRzPanel;
    RzPanel37: TRzPanel;
    RzLabel13: TRzLabel;
    edtAMOUNT: TcxTextEdit;
    edtBK_LOWER_AMOUNT: TRzPanel;
    RzPanel21: TRzPanel;
    RzLabel14: TRzLabel;
    edtBK_UPPER_AMOUNT: TRzPanel;
    RzPanel39: TRzPanel;
    RzLabel15: TRzLabel;
    edtUPPER_AMOUNT: TcxTextEdit;
    edtLOWER_AMOUNT: TcxTextEdit;
    AddSortTree: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    lower: TRzPanel;
    upper: TRzPanel;
    PrintDBGridEh1: TPrintDBGridEh;
    PopupMenu1: TPopupMenu;
    ExcelImport: TMenuItem;
    RzPanel9: TRzPanel;
    RzBackground29: TRzBackground;
    RzLabel37: TRzLabel;
    ClearStorage: TMenuItem;
    RzBmpButton4: TRzBmpButton;
    ChangeImport: TMenuItem;
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtSORT_ID1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtUNIT_ID_USINGClick(Sender: TObject);
    procedure toolEditClick(Sender: TObject);
    procedure RzBitBtn7Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure btnAMOUNTClick(Sender: TObject);
    procedure toolDeleteClick(Sender: TObject);
    procedure sortDropKeyPress(Sender: TObject; var Key: Char);
    procedure btnNewSortClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure RzBmpButton6Click(Sender: TObject);
    procedure RzBmpButton7Click(Sender: TObject);
    procedure serachTextEnter(Sender: TObject);
    procedure serachTextExit(Sender: TObject);
    procedure serachTextChange(Sender: TObject);
    procedure RzBmpButton5Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure edtGODS_NAMEPropertiesChange(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure serachTextKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure ExcelImportClick(Sender: TObject);
    procedure RzLabel37Click(Sender: TObject);
    procedure VIPPriceImportClick(Sender: TObject);
    procedure ClearStorageClick(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure ChangeImportClick(Sender: TObject);
  private
    ESortId:string;
    FSortId:string;
    searchTxt:string;
    relationId:integer;
    relationType:integer;
    AObj:TRecord_;
    storAmt:real;
    FdbState: TDataSetState;
    FstorFlag: integer;
    function  FindColumn(fieldname:string):TColumnEh;
    function  GetOpenWhere:string;
    procedure ReadInfo;
    procedure WriteInfo;
    procedure WriteOweOrder;
    procedure SetdbState(const Value: TDataSetState);virtual;
    procedure SetstorFlag(const Value: integer);
    procedure DBGridPrint;
    procedure SaveChangeOrder(rs: TZQuery);
  public
    procedure OpenInfo(godsId:string;Relation:integer=0);
    procedure SaveInfo;
    procedure SaveLocalInfo;
    procedure DeleteInfo(godsId:string;Relation:integer=0);
    procedure unDeleteInfo(godsId:string;Relation:integer=0);
    procedure UpdateSort(godsId:string;Relation:integer=0);
    procedure Open;
    procedure showForm;override;
    property  dbState:TDataSetState read FdbState write SetdbState;
    property  storFlag:integer read FstorFlag write SetstorFlag;
  end;

implementation

uses ufrmSortDropFrom,udllDsUtil,udllCtrlUtil,uFnUtil,udllGlobal,udataFactory,
     udllShopUtil,utokenFactory,ufrmGoodsSort,ufrmInitGoods,ufrmMemberPrice,
     ufrmGoodsExcel,ufrmPriceExcel,ufrmDBGridPreview,ufrmClearStorage,ufrmStorageExcel;

{$R *.dfm}

function getTodayId:string;
begin
  result := token.shopId+formatDatetime('YYYYMMDD',dllGlobal.SysDate)+'000000000000000';
end;

procedure TfrmGoodsStorage.sortDropPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  Obj:TRecord_;
begin
  inherited;
  Obj := TRecord_.Create;
  try
    frmSortDropFrom.ShowCgtSort := false;
    if frmSortDropFrom.DropForm(sortDrop,obj) then
    begin
      if Obj.Count>0 then
         begin
            FSortId := Obj.FieldbyName('SORT_ID').AsString;
            sortDrop.Text := Obj.FieldbyName('SORT_NAME').AsString;
         end
      else
         begin
            FSortId := '';
            sortDrop.Text := '';
         end;
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
  rowToolNav.Visible := not cdsList.IsEmpty;
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused or (Column.FieldName = 'TOOL_NAV')) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+1,ARect.Top+1,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
       end
    else
       begin
         DBGridEh1.Canvas.Font.Color := clBlack;
         DBGridEh1.Canvas.Brush.Color := clWhite;
       end;
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
  rzTree.Items.Add(nil,'回收站');
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
  column.KeyList.Add('#');
  column.PickList.Add('无分类');
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
   'select j.TENANT_ID,'''+token.shopId+''' as CUR_SHOP_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.SORT_ID1,j.RELATION_ID,j.CALC_UNITS,j.PRICE_ID,j.COMM,c.AMOUNT,'+
   'isnull(ext.NEW_INPRICE,j.NEW_INPRICE) as NEW_INPRICE,'+
   'isnull(prc.NEW_OUTPRICE,j.NEW_OUTPRICE) as NEW_OUTPRICE_P,ext.LOWER_AMOUNT,ext.UPPER_AMOUNT '+
   'from ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,SHOP_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS,NEW_INPRICE,NEW_OUTPRICE,RELATION_ID,PRICE_ID,COMM',true)+') j '+
   'left outer join (select TENANT_ID,GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+''' group by TENANT_ID,GODS_ID) c on j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID '+
   'left outer join  PUB_GOODSINFOEXT ext on j.TENANT_ID=ext.TENANT_ID and j.GODS_ID=ext.GODS_ID '+
   'left outer join  PUB_GOODSPRICE prc on j.TENANT_ID=prc.TENANT_ID and j.GODS_ID=prc.GODS_ID and j.SHOP_ID=prc.SHOP_ID and j.PRICE_ID=trim(prc.PRICE_ID) ) jp '+
   'left outer join  PUB_GOODSPRICE shp on jp.TENANT_ID=shp.TENANT_ID and jp.GODS_ID=shp.GODS_ID and jp.CUR_SHOP_ID=shp.SHOP_ID and jp.PRICE_ID=trim(shp.PRICE_ID) '+GetOpenWhere + ' '
  );
  cdsList.SQL.Text := cdsList.SQL.Text + ' order by GODS_CODE';
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
      result := getSortId(child);
      child := node.GetNextChild(child);
    end;
end;
var
  w:string;
begin
  if Assigned(rzTree.Selected) and (rzTree.Selected.Level=0) then
     begin
       if rzTree.Selected.Text='回收站' then
          result := ' jp.COMM in (''12'',''02'') '
       else
          result := ' jp.COMM not in (''12'',''02'') ';
     end
  else
     result := ' jp.COMM not in (''12'',''02'') ';
  if Assigned(rzTree.Selected) and (rzTree.Selected.Level>0) then
     begin
       if result <> '' then result := result +' and ';
       if rzTree.Selected.Level=1 then
          begin
            begin
              if TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString='#' then
              result := result +' jp.SORT_ID1=''#'' ' else
              begin
                if TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsInteger=0 then
                   result := result +' jp.RELATION_ID in ('+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString+',1000008)'
                else
                   result := result +' jp.RELATION_ID='+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString+'';
              end;
            end;
          end
       else
          begin
            if TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsInteger=0 then
               result := result +' jp.RELATION_ID in ('+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString+',1000008) and jp.SORT_ID1 in ('+getSortId(rzTree.Selected)+')'
            else
               result := result +' jp.RELATION_ID = '+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString+' and jp.SORT_ID1 in ('+getSortId(rzTree.Selected)+')';
          end;
     end;
  if trim(searchTxt) <> '' then
     begin
       if result <> '' then result := result +' and ';
       result := result + '(jp.GODS_NAME like ''%'+trim(searchTxt)+'%'' or jp.GODS_CODE like ''%'+trim(searchTxt)+'%'' or jp.BARCODE like ''%'+trim(searchTxt)+'%'')';
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

procedure TfrmGoodsStorage.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if rzTree.CanFocus then Open;
  rowToolNav.Visible := not cdsList.IsEmpty;
  toolSpacer.Visible := Node.Text<>'回收站';
  toolEdit.Visible := Node.Text<>'回收站';
  if toolEdit.Visible then
     toolDelete.Caption := '删除'
  else
     toolDelete.Caption := '还原';
end;

procedure TfrmGoodsStorage.OpenInfo(godsId: string;Relation:integer=0);
function getRelatonTenant(flag:integer):integer;
var
  rs:TZQuery;
begin
  if relation=0 then
     begin
       result := strtoint(token.tenantId);
       Exit;
     end;
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
              result := strtoint(token.tenantId)
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
    Params.ParamByName('PRICE_ID').AsString := '#';
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('CHANGE_ID').AsString := getTodayId;
    Params.ParamByName('RELATION_ID').AsInteger := Relation;
    Params.ParamByName('VIW_GOODSINFO').AsString := dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE',true);
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
    if not cdsGoodsInfo.IsEmpty and (cdsGoodsInfo.FieldByName('COMM').AsString[2]='2') then
       dbState := dsBrowse
    else
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

  SaveLocalInfo;
  dllGlobal.Refresh('PUB_GOODSINFO');

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
       cdsList.FieldByName('LOWER_AMOUNT').AsString := edtLOWER_AMOUNT.Text;
       cdsList.FieldByName('UPPER_AMOUNT').AsString := edtUPPER_AMOUNT.Text;
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

  if cdsList.FieldbyName('AMOUNT').AsString<>'' then
    storAmt := cdsList.FieldbyName('AMOUNT').AsFloat
  else
    storAmt:=0;
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
  cdsGoodsExt.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
  cdsGoodsExt.FieldByName('NEW_INPRICE').AsFloat  := StrtoFloatDef(edtNEW_INPRICE.Text,0);
  cdsGoodsExt.FieldByName('NEW_INPRICE1').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0)*StrtoFloatDef(edtSMALLTO_CALC.TEXT,0);
  cdsGoodsExt.FieldByName('NEW_INPRICE2').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0)*StrtoFloatDef(edtBIGTO_CALC.TEXT,0);
  cdsGoodsExt.FieldByName('LOWER_AMOUNT').AsFloat := StrtoFloatDef(edtLOWER_AMOUNT.Text,0);
  cdsGoodsExt.FieldByName('UPPER_AMOUNT').AsFloat := StrtoFloatDef(edtUPPER_AMOUNT.Text,0);
  cdsGoodsExt.Post;
  
  isDel := false;
  if FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0))=0 then
     begin
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
       cdsGoodsPrice.FieldByName('PRICE_ID').AsString :=  '#';
       cdsGoodsPrice.FieldByName('SHOP_ID').AsString := token.shopId;
       cdsGoodsPrice.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
       cdsGoodsPrice.FieldByName('PRICE_METHOD').AsString := '1';
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
  btnSave.Visible := dbState <> dsBrowse;
  if relationId=0 then Exit;
  SetEditStyle(dsBrowse,edtBARCODE.Style);
  edtBK_BARCODE.Color := edtBARCODE.Style.Color;
  edtBARCODE.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtCALC_UNITS.Style);
  edtBK_CALC_UNITS.Color := edtCALC_UNITS.Style.Color;
  edtCALC_UNITS.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtSMALL_UNITS.Style);
  edtBK_SMALL_UNITS.Color := edtSMALL_UNITS.Style.Color;
  edtSMALL_UNITS.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtBIG_UNITS.Style);
  edtBK_BIG_UNITS.Color := edtBIG_UNITS.Style.Color;
  edtBIG_UNITS.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtBIGTO_CALC.Style);
  edtBIGTO_CALC.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtSMALLTO_CALC.Style);
  edtSMALLTO_CALC.Properties.ReadOnly := true;
  edtUNIT_ID_USING.Properties.ReadOnly := true;
  if not dllGlobal.checkChangePrice(relationId) then
     begin
        SetEditStyle(dsBrowse,edtNEW_INPRICE.Style);
        edtBK_NEW_INPRICE.Color := edtNEW_INPRICE.Style.Color;
        edtNEW_INPRICE.Properties.ReadOnly := true;
        SetEditStyle(dsBrowse,edtNEW_OUTPRICE.Style);
        edtBK_NEW_OUTPRICE.Color := edtNEW_OUTPRICE.Style.Color;
        edtNEW_OUTPRICE.Properties.ReadOnly := true;
     end;
  if relationType=1 then Exit;
  SetEditStyle(dsBrowse,edtNEW_OUTPRICE.Style);
  edtBK_NEW_OUTPRICE.Color := edtNEW_OUTPRICE.Style.Color;
  edtNEW_OUTPRICE.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtGODS_CODE.Style);
  edtBK_GODS_CODE.Color := edtGODS_CODE.Style.Color;
  edtGODS_CODE.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtGODS_NAME.Style);
  edtBK_GODS_NAME.Color := edtGODS_NAME.Style.Color;
  edtGODS_NAME.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtSORT_ID1.Style);
  edtBK_SORT_ID1.Color := edtSORT_ID1.Style.Color;
  edtSORT_ID1.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtGODS_SPELL.Style);
  edtGODS_SPELL.Properties.ReadOnly := true;
end;

procedure TfrmGoodsStorage.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  TDbGridEhSort.InitForm(self);
end;

procedure TfrmGoodsStorage.FormDestroy(Sender: TObject);
begin
  TDbGridEhSort.FreeForm(self);
  AObj.Free;
  inherited;
end;

procedure TfrmGoodsStorage.edtSORT_ID1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  Obj:TRecord_;
begin
  inherited;
  if edtSORT_ID1.Properties.ReadOnly then Exit;
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
  edtBK_SMALL_UNITS.Visible := edtUNIT_ID_USING.Checked;
  edtBK_BIG_UNITS.Visible := edtUNIT_ID_USING.Checked;
end;

procedure TfrmGoodsStorage.toolEditClick(Sender: TObject);
begin
  inherited;
  if cdsList.FieldByName('GODS_ID').AsString = '' then Exit;
  openinfo(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
end;

procedure TfrmGoodsStorage.RzBitBtn7Click(Sender: TObject);
begin
  inherited;
  EditPanel.Visible := false;
end;

procedure TfrmGoodsStorage.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
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
    rs.ParamByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
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
  cdsHeader.FieldByName('CHANGE_DATE').AsString := formatDatetime('YYYYMMDD',dllGlobal.SysDate);
  cdsHeader.FieldByName('CHANGE_TYPE').AsString := '2';
  cdsHeader.FieldByName('CHANGE_CODE').AsString := '1';
  cdsHeader.FieldByName('DUTY_USER').AsString := token.userId;
  cdsHeader.FieldByName('CHK_DATE').AsString := formatDatetime('YYYY-MM-DD',dllGlobal.SysDate);
  cdsHeader.FieldByName('CHK_USER').AsString := token.userId;
  cdsHeader.FieldByName('CREA_USER').AsString := token.userId;
  cdsHeader.FieldByName('CREA_DATE').AsString := formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  cdsHeader.FieldByName('DEPT_ID').AsString := dllGlobal.getMyDeptId;
  cdsHeader.FieldByName('REMARK').AsString := '修改库存';
  cdsHeader.Post;
  
  if cdsDetail.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then
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
       rowId := 0;
       cdsDetail.first;
       while not cdsDetail.Eof do
         begin
           if cdsDetail.FieldbyName('SEQNO').AsInteger > rowId then
              rowId := cdsDetail.FieldbyName('SEQNO').AsInteger;
           cdsDetail.next;
         end;
       inc(rowId);
       cdsDetail.Append;
       cdsDetail.FieldbyName('TENANT_ID').AsString := cdsHeader.FieldByName('TENANT_ID').AsString;
       cdsDetail.FieldbyName('CHANGE_ID').AsString := cdsHeader.FieldByName('CHANGE_ID').AsString;
       cdsDetail.FieldbyName('SHOP_ID').AsString := cdsHeader.FieldByName('SHOP_ID').AsString;
       cdsDetail.FieldbyName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
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
  if relation=0 then
     begin
       result := strtoint(token.tenantId);
       Exit;
     end;
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  if rs.Locate('RELATION_ID',relation,[]) then
     begin
       case flag of
       0:result := rs.FieldbyName('TENANT_ID').AsInteger;
       else
         begin
           if rs.FieldbyName('RELATION_TYPE').AsInteger=1 then
              result := strtoint(token.tenantId)
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
  tmpGoodsInfo,tmpBarCode,tmpGoodsRelation,tmpGoodsPrice,tmpGoodsExt:TZQuery;
begin
  EditPanel.Visible := false;
  Params := TftParamList.Create;
  try
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('PRICE_ID').AsString := '#';
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
    case Relation of
    0:begin
        if not cdsGoodsInfo.IsEmpty then cdsGoodsInfo.Delete;
        if not cdsGodsRelation.IsEmpty then cdsGodsRelation.Delete;
        cdsBarcode.First;
        while not cdsBarcode.IsEmpty do cdsBarcode.Delete;
        cdsGoodsPrice.First;
        while not cdsGoodsPrice.IsEmpty do cdsGoodsPrice.Delete;
        if not cdsGoodsExt.IsEmpty then cdsGoodsExt.Delete;
      end
    else
      begin
        if not cdsGodsRelation.IsEmpty then cdsGodsRelation.Delete;
        cdsGoodsPrice.First;
        while not cdsGoodsPrice.IsEmpty do cdsGoodsPrice.Delete;
        if not cdsGoodsExt.IsEmpty then cdsGoodsExt.Delete;
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

  if dataFactory.iDbType <> 5 then
  begin
    Params := TftParamList.Create;
    tmpGoodsInfo := TZQuery.Create(nil);
    tmpBarCode := TZQuery.Create(nil);
    tmpGoodsRelation := TZQuery.Create(nil);
    tmpGoodsPrice := TZQuery.Create(nil);
    tmpGoodsExt := TZQuery.Create(nil);
    dataFactory.MoveToSqlite;
    try
      Params.ParamByName('SHOP_ID').AsString := token.shopId;
      Params.ParamByName('PRICE_ID').AsString := '#';
      Params.ParamByName('GODS_ID').AsString := godsId;
      Params.ParamByName('CHANGE_ID').AsString := getTodayId;
      Params.ParamByName('RELATION_ID').AsInteger := Relation;
      dataFactory.BeginBatch;
      try
        if Relation=0 then
           Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId)
        else
           Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(0);
        dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',Params);
        dataFactory.AddBatch(tmpBarcode,'TBarCodeV60',Params);
        Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(1);
        dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',Params);
        Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
        dataFactory.AddBatch(tmpGoodsPrice,'TGoodsPriceV60',Params);
        dataFactory.AddBatch(tmpGoodsExt,'TGoodsInfoExtV60',Params);
        dataFactory.OpenBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
      case Relation of
      0:begin
          if not tmpGoodsInfo.IsEmpty then tmpGoodsInfo.Delete;
          if not tmpGoodsRelation.IsEmpty then tmpGoodsRelation.Delete;
          tmpBarcode.First;
          while not tmpBarcode.IsEmpty do tmpBarcode.Delete;
          tmpGoodsPrice.First;
          while not tmpGoodsPrice.IsEmpty do tmpGoodsPrice.Delete;
          if not tmpGoodsExt.IsEmpty then tmpGoodsExt.Delete;
        end
      else
        begin
          if not tmpGoodsRelation.IsEmpty then tmpGoodsRelation.Delete;
          tmpGoodsPrice.First;
          while not tmpGoodsPrice.IsEmpty do tmpGoodsPrice.Delete;
          if not tmpGoodsExt.IsEmpty then tmpGoodsExt.Delete;
        end;
      end;
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',nil);
        dataFactory.AddBatch(tmpBarcode,'TBarCodeV60',nil);
        dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',nil);
        dataFactory.AddBatch(tmpGoodsPrice,'TGoodsPriceV60',nil);
        dataFactory.AddBatch(tmpGoodsExt,'TGoodsInfoExtV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      dataFactory.MoveToDefault;
      Params.Free;
      tmpGoodsInfo.Free;
      tmpBarCode.Free;
      tmpGoodsRelation.Free;
      tmpGoodsPrice.Free;
      tmpGoodsExt.Free;
    end;
  end;
  dllGlobal.Refresh('PUB_GOODSINFO');
end;

procedure TfrmGoodsStorage.toolDeleteClick(Sender: TObject);
begin
  inherited;
  if cdsList.FieldByName('GODS_ID').AsString = '' then Exit;
  if cdsList.FieldbyName('COMM').AsString[2]<>'2' then
     begin
       if MessageBox(Handle,'是否删除当前行的商品？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       DeleteInfo(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
       cdsList.Delete;
     end
  else
     begin
       if MessageBox(Handle,'是否还原当前行的商品？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       unDeleteInfo(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
       cdsList.Delete;
     end;
end;

procedure TfrmGoodsStorage.sortDropKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key<>#13) and (Key<>#27) and (Key<>#8) then
     begin
       Key := #0;
       sortDropPropertiesButtonClick(nil,0);
     end;
end;

procedure TfrmGoodsStorage.UpdateSort(godsId: string; Relation: integer);
function getRelatonTenant(flag:integer):integer;
var
  rs:TZQuery;
begin
  if relation=0 then
     begin
       result := strtoint(token.tenantId);
       Exit;
     end;
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  if rs.Locate('RELATION_ID',relation,[]) then
     begin
       case flag of
       0:result := rs.FieldbyName('TENANT_ID').AsInteger;
       else
         begin
           if rs.FieldbyName('RELATION_TYPE').AsInteger=1 then
              result := strtoint(token.tenantId)
           else
              Raise Exception.Create('不能更改供应链中的商品');
         end;
       end;
     end
  else
     raise Exception.Create('缓存中没找到当前供应链，数据同步后重试');
end;
var
  Params:TftParamList;
  tmpDataSet:TZQuery;
begin
  EditPanel.Visible := false;
  Params := TftParamList.Create;
  try
    Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(1);
    Params.ParamByName('GODS_ID').AsString := godsId;
    Params.ParamByName('RELATION_ID').AsInteger := Relation;
    case relation of
    0:begin
        dataFactory.Open(cdsGoodsInfo,'TGoodsInfoV60',Params);
        cdsGoodsInfo.Edit;
        cdsGoodsInfo.FieldByName('SORT_ID1').AsString := FSortId;
        cdsGoodsInfo.Post;
        dataFactory.UpdateBatch(cdsGoodsInfo,'TGoodsInfoV60');
      end;
    else
      begin
        dataFactory.Open(cdsGodsRelation,'TGoodsRelationV60',Params);
        cdsGodsRelation.Edit;
        cdsGodsRelation.FieldByName('SORT_ID1').AsString := FSortId;
        cdsGodsRelation.Post;
        dataFactory.UpdateBatch(cdsGodsRelation,'TGoodsRelationV60');
      end;
    end;
  finally
    Params.Free;
  end;

  if dataFactory.iDbType <> 5 then
  begin
    Params := TftParamList.Create;
    tmpDataSet := TZQuery.Create(nil);
    dataFactory.MoveToSqlite;
    try
      case relation of
      0:begin
          Params.ParamByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
          Params.ParamByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
          dataFactory.Open(tmpDataSet,'TGoodsInfoV60',Params);
          tmpDataSet.Edit;
          tmpDataSet.FieldByName('SORT_ID1').AsString := FSortId;
          tmpDataSet.Post;
          dataFactory.UpdateBatch(tmpDataSet,'TGoodsInfoV60');
        end;
      else
        begin
          Params.ParamByName('TENANT_ID').AsInteger := cdsGodsRelation.FieldByName('TENANT_ID').AsInteger;
          Params.ParamByName('GODS_ID').AsString := cdsGodsRelation.FieldByName('GODS_ID').AsString;
          Params.ParamByName('RELATION_ID').AsInteger := cdsGodsRelation.FieldByName('RELATION_ID').AsInteger;
          dataFactory.Open(tmpDataSet,'TGoodsRelationV60',Params);
          tmpDataSet.Edit;
          tmpDataSet.FieldByName('SORT_ID1').AsString := FSortId;
          tmpDataSet.Post;
          dataFactory.UpdateBatch(tmpDataSet,'TGoodsRelationV60');
        end;
      end;
    finally
      dataFactory.MoveToDefault;
      tmpDataSet.Free;
      Params.Free;
    end;
  end;
  dllGlobal.Refresh('PUB_GOODSINFO');
end;

procedure TfrmGoodsStorage.btnNewSortClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  AObj := TRecord_.Create;
  try
    if TfrmGoodsSort.ShowDialog(self,'',AObj) then
       begin
         rzTree.OnChange := nil;
         dllGlobal.CreateGoodsSortTree(rzTree,true);
         rzTree.Items.Add(nil,'回收站');
         rzTree.OnChange := rzTreeChange;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmGoodsStorage.btnFindClick(Sender: TObject);
var
  gid:string;
begin
  inherited;
  if TfrmInitGoods.ShowDialog(self,'',gid) then
     begin
       editPanel.Visible := false;
       open;
       cdsList.Locate('GODS_ID',gid,[]); 
     end; 
end;

procedure TfrmGoodsStorage.RzBmpButton6Click(Sender: TObject);
var
  gid:string;
  isSelected,canDelete:boolean;
begin
  inherited;
  isSelected := false;
  canDelete := true;
  gid := cdsList.FieldbyName('GODS_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldByName('A').AsString = '1' then
           begin
             isSelected := true;
             if Copy(cdsList.FieldByName('COMM').AsString,2,2) = '2' then
                begin
                  canDelete := false;
                  break;
                end;
           end;
        cdsList.Next;
      end;
  finally
    cdsList.Locate('GODS_ID',gid,[]);
    cdsList.EnableControls;
  end;
  if not isSelected then Raise Exception.Create('请选择要删除的记录...');
  if not canDelete then Raise Exception.Create('回收站内商品不能删除...');
  if MessageBox(Handle,'是否删除选中的所有商品？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  gid := cdsList.FieldbyName('GODS_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldbyName('A').AsString='1' then
           begin
             if Copy(cdsList.FieldByName('COMM').AsString,2,2) <> '2' then
                begin
                  DeleteInfo(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
                  cdsList.Delete;
                end
             else cdsList.Next;
           end
        else
           cdsList.Next;
      end;
  finally
    cdsList.Locate('GODS_ID',gid,[]);
    cdsList.EnableControls;
  end;
end;

procedure TfrmGoodsStorage.RzBmpButton7Click(Sender: TObject);
var
  gid:string;
  isSelected:boolean;
begin
  inherited;
  isSelected := false;
  gid := cdsList.FieldbyName('GODS_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldByName('A').AsString = '1' then
           begin
             isSelected := true;
             break;
           end;
        cdsList.Next;
      end;
  finally
    cdsList.Locate('GODS_ID',gid,[]);
    cdsList.EnableControls;
  end;
  if not isSelected then Raise Exception.Create('请选择要变更的记录...');
  if FSortId='' then Raise Exception.Create('请选择更改的目标分类。');
  if MessageBox(Handle,'是否修改选中的所有商品分类？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  gid := cdsList.FieldbyName('GODS_ID').AsString;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        if cdsList.FieldbyName('A').AsString='1' then
           begin
             UpdateSort(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
             cdsList.Edit;
             cdsList.FieldbyName('SORT_ID1').AsString := FSortId;
             cdsList.Post;
           end;
        cdsList.Next;
      end;
  finally
    cdsList.Locate('GODS_ID',gid,[]);
    cdsList.EnableControls;
  end;
end;

procedure TfrmGoodsStorage.serachTextEnter(Sender: TObject);
begin
  inherited;
  serachText.Text := searchTxt;
  serachText.SelectAll;
end;

procedure TfrmGoodsStorage.serachTextExit(Sender: TObject);
begin
  inherited;
  if searchTxt='' then serachText.Text := serachText.Hint;
end;

procedure TfrmGoodsStorage.serachTextChange(Sender: TObject);
begin
  inherited;
  if serachText.Focused then searchTxt := serachText.Text;
end;

procedure TfrmGoodsStorage.RzBmpButton5Click(Sender: TObject);
begin
  inherited;
  EditPanel.Visible := false;
end;

procedure TfrmGoodsStorage.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveInfo;
  EditPanel.Visible := false;
end;

procedure TfrmGoodsStorage.RzBmpButton2Click(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TfrmGoodsStorage.edtGODS_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtGODS_NAME.Focused then edtGODS_SPELL.Text := FnString.GetWordSpell(edtGODS_NAME.Text,3) ;
end;

procedure TfrmGoodsStorage.unDeleteInfo(godsId: string; Relation: integer);
function getRelatonTenant(flag:integer):integer;
var
  rs:TZQuery;
begin
  if relation=0 then
     begin
       result := strtoint(token.tenantId);
       Exit;
     end;
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  if rs.Locate('RELATION_ID',relation,[]) then
     begin
       case flag of
       0:result := rs.FieldbyName('TENANT_ID').AsInteger;
       else
         begin
           if rs.FieldbyName('RELATION_TYPE').AsInteger=1 then
              result := strtoint(token.tenantId)
           else
              Raise Exception.Create('不能还原供应链中的商品');
         end;
       end;
     end
  else
     raise Exception.Create('缓存中没找到当前供应链，数据同步后重试');
end;
var
  Params:TftParamList;
  tmpGoodsInfo,tmpBarCode,tmpGoodsRelation,tmpGoodsPrice,tmpGoodsExt:TZQuery;
begin
  EditPanel.Visible := false;
  Params := TftParamList.Create;
  try
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('PRICE_ID').AsString := '#';
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
    case Relation of
    0:begin
        cdsGoodsInfo.Edit;
        cdsGoodsInfo.FieldByName('COMM').AsString := '10';
        cdsGoodsInfo.Post;
        cdsGodsRelation.First;
        while not cdsGodsRelation.Eof do
           begin
             cdsGodsRelation.Edit;
             cdsGodsRelation.FieldByName('COMM').AsString := '10';
             cdsGodsRelation.Post;
             cdsGodsRelation.Next;
           end;
        cdsBarcode.First;
        while not cdsBarcode.Eof do
           begin
             cdsBarcode.Edit;
             cdsBarcode.FieldByName('COMM').AsString := '10';
             cdsBarcode.Post;
             cdsBarcode.Next;
           end;
        cdsGoodsPrice.First;
        while not cdsGoodsPrice.Eof do
           begin
             cdsGoodsPrice.Edit;
             cdsGoodsPrice.FieldByName('COMM').AsString := '10';
             cdsGoodsPrice.Post;
             cdsGoodsPrice.Next;
           end;
        cdsGoodsExt.First;
        while not cdsGoodsExt.Eof do
           begin
             cdsGoodsExt.Edit;
             cdsGoodsExt.FieldByName('COMM').AsString := '10';
             cdsGoodsExt.Post;
             cdsGoodsExt.Next;
           end;
      end
    else
      begin
        cdsGodsRelation.First;
        while not cdsGodsRelation.Eof do
           begin
             cdsGodsRelation.Edit;
             cdsGodsRelation.FieldByName('COMM').AsString := '10';
             cdsGodsRelation.Post;
             cdsGodsRelation.Next;
           end;
        while not cdsGoodsPrice.Eof do
           begin
             cdsGoodsPrice.Edit;
             cdsGoodsPrice.FieldByName('COMM').AsString := '10';
             cdsGoodsPrice.Post;
             cdsGoodsPrice.Next;
           end;
        cdsGoodsExt.First;
        while not cdsGoodsExt.Eof do
           begin
             cdsGoodsExt.Edit;
             cdsGoodsExt.FieldByName('COMM').AsString := '10';
             cdsGoodsExt.Post;
             cdsGoodsExt.Next;
           end;
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

  if dataFactory.iDbType <> 5 then
  begin
    Params := TftParamList.Create;
    tmpGoodsInfo := TZQuery.Create(nil);
    tmpBarCode := TZQuery.Create(nil);
    tmpGoodsRelation := TZQuery.Create(nil);
    tmpGoodsPrice := TZQuery.Create(nil);
    tmpGoodsExt := TZQuery.Create(nil);
    dataFactory.MoveToSqlite;
    try
      Params.ParamByName('SHOP_ID').AsString := token.shopId;
      Params.ParamByName('PRICE_ID').AsString := '#';
      Params.ParamByName('GODS_ID').AsString := godsId;
      Params.ParamByName('CHANGE_ID').AsString := getTodayId;
      Params.ParamByName('RELATION_ID').AsInteger := Relation;
      dataFactory.BeginBatch;
      try
        if Relation=0 then
           Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId)
        else
           Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(0);
        dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',Params);
        dataFactory.AddBatch(tmpBarcode,'TBarCodeV60',Params);
        Params.ParamByName('TENANT_ID').AsInteger := getRelatonTenant(1);
        dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',Params);
        Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
        dataFactory.AddBatch(tmpGoodsPrice,'TGoodsPriceV60',Params);
        dataFactory.AddBatch(tmpGoodsExt,'TGoodsInfoExtV60',Params);
        dataFactory.OpenBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
      case Relation of
      0:begin
          tmpGoodsInfo.Edit;
          tmpGoodsInfo.FieldByName('COMM').AsString := '10';
          tmpGoodsInfo.Post;
          tmpGoodsRelation.First;
          while not tmpGoodsRelation.Eof do
            begin
              tmpGoodsRelation.Edit;
              tmpGoodsRelation.FieldByName('COMM').AsString := '10';
              tmpGoodsRelation.Post;
              tmpGoodsRelation.Next;
            end;
          tmpBarcode.First;
          while not tmpBarcode.Eof do
            begin
              tmpBarcode.Edit;
              tmpBarcode.FieldByName('COMM').AsString := '10';
              tmpBarcode.Post;
              tmpBarcode.Next;
            end;
          tmpGoodsPrice.First;
          while not tmpGoodsPrice.Eof do
            begin
              tmpGoodsPrice.Edit;
              tmpGoodsPrice.FieldByName('COMM').AsString := '10';
              tmpGoodsPrice.Post;
              tmpGoodsPrice.Next;
            end;
          tmpGoodsExt.First;
          while not tmpGoodsExt.Eof do
            begin
              tmpGoodsExt.Edit;
              tmpGoodsExt.FieldByName('COMM').AsString := '10';
              tmpGoodsExt.Post;
              tmpGoodsExt.Next;
            end;
        end
      else
        begin
          tmpGoodsRelation.First;
          while not tmpGoodsRelation.Eof do
            begin
              tmpGoodsRelation.Edit;
              tmpGoodsRelation.FieldByName('COMM').AsString := '10';
              tmpGoodsRelation.Post;
              tmpGoodsRelation.Next;
            end;
          while not tmpGoodsPrice.Eof do
            begin
              tmpGoodsPrice.Edit;
              tmpGoodsPrice.FieldByName('COMM').AsString := '10';
              tmpGoodsPrice.Post;
              tmpGoodsPrice.Next;
            end;
          tmpGoodsExt.First;
          while not tmpGoodsExt.Eof do
            begin
              tmpGoodsExt.Edit;
              tmpGoodsExt.FieldByName('COMM').AsString := '10';
              tmpGoodsExt.Post;
              tmpGoodsExt.Next;
            end;
        end;
      end;
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',nil);
        dataFactory.AddBatch(tmpBarcode,'TBarCodeV60',nil);
        dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',nil);
        dataFactory.AddBatch(tmpGoodsPrice,'TGoodsPriceV60',nil);
        dataFactory.AddBatch(tmpGoodsExt,'TGoodsInfoExtV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      dataFactory.MoveToDefault;
      Params.Free;
      tmpGoodsInfo.Free;
      tmpBarCode.Free;
      tmpGoodsRelation.Free;
      tmpGoodsPrice.Free;
      tmpGoodsExt.Free;
    end;
  end;
  dllGlobal.Refresh('PUB_GOODSINFO');
end;

procedure TfrmGoodsStorage.N3Click(Sender: TObject);
var AObj,SObj:TRecord_;
begin
  inherited;
  SObj := TRecord_(rzTree.Selected.Data);
  if (SObj = nil)
     or
     (SObj.FieldByName('RELATION_ID').AsInteger <> 0)
     or
     (SObj.FieldByName('SORT_ID').AsString = '#') then
     Raise Exception.Create('不允许添加非自经营分类...');

  AObj := TRecord_.Create;
  try
    if TfrmGoodsSort.ShowDialog(self,'',AObj,SObj) then
       begin
         rzTree.OnChange := nil;
         dllGlobal.CreateGoodsSortTree(rzTree,true);
         rzTree.Items.Add(nil,'回收站');
         rzTree.OnChange := rzTreeChange;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmGoodsStorage.N4Click(Sender: TObject);
var AObj,SObj:TRecord_;
begin
  inherited;
  SObj := TRecord_(rzTree.Selected.Data);
  if (SObj = nil)
     or
     (SObj.FieldByName('RELATION_ID').AsInteger <> 0)
     or
     (SObj.FieldByName('SORT_ID').AsString = '#')
     or
     (SObj.FieldByName('LEVEL_ID').AsString = '') then
     Raise Exception.Create('非自经营分类不允许修改...');

  AObj := TRecord_.Create;
  try
    if TfrmGoodsSort.ShowDialog(self,SObj.FieldbyName('SORT_ID').AsString,AObj) then
       begin
         rzTree.OnChange := nil;
         dllGlobal.CreateGoodsSortTree(rzTree,true);
         rzTree.Items.Add(nil,'回收站');
         rzTree.OnChange := rzTreeChange;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmGoodsStorage.N5Click(Sender: TObject);
var
  SObj:TRecord_;
  cdsSort:TZQuery;
  Params:TftParamList;
begin
  inherited;
  SObj := TRecord_(rzTree.Selected.Data);
  if (SObj = nil)
     or
     (SObj.FieldByName('RELATION_ID').AsInteger <> 0)
     or
     (SObj.FieldByName('SORT_ID').AsString = '#')
     or
     (SObj.FieldByName('LEVEL_ID').AsString = '') then
     Raise Exception.Create('非自经营分类不允许删除...');

  if rzTree.Selected.HasChildren then Raise Exception.Create('当前分类存在下级，不允许删除...');

  if MessageBox(Handle,Pchar('确定要删除"'+SObj.FieldByName('SORT_NAME').AsString+'"分类吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1) <> 6 then Exit;

  cdsSort := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SORT_TYPE').AsInteger := 1;
    Params.ParamByName('SORT_ID').AsString := SObj.FieldByName('SORT_ID').AsString; 
    dataFactory.Open(cdsSort,'TGoodsSortV60',Params);
    if not cdsSort.IsEmpty then cdsSort.Delete;
    try
      dataFactory.UpdateBatch(cdsSort,'TGoodsSortV60');
    except
      cdsSort.CancelUpdates;
      Raise;
    end
  finally
    cdsSort.Free;
    Params.Free;
  end;

  if dataFactory.iDbType <> 5 then
  begin
    cdsSort := TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    dataFactory.MoveToSqlite;
    try
      Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      Params.ParamByName('SORT_TYPE').AsInteger := 1;
      Params.ParamByName('SORT_ID').AsString := SObj.FieldByName('SORT_ID').AsString;
      dataFactory.Open(cdsSort,'TGoodsSortV60',Params);
      if not cdsSort.IsEmpty then cdsSort.Delete;
      try
        dataFactory.UpdateBatch(cdsSort,'TGoodsSortV60');
      except
        cdsSort.CancelUpdates;
        Raise;
      end
    finally
      dataFactory.MoveToDefault;
      cdsSort.Free;
      Params.Free;
    end;
  end;
  dllGlobal.Refresh('PUB_GOODSSORT');
  rzTree.OnChange := nil;
  dllGlobal.CreateGoodsSortTree(rzTree,true);
  rzTree.Items.Add(nil,'回收站');
  rzTree.OnChange := rzTreeChange;
end;

procedure TfrmGoodsStorage.SaveLocalInfo;
var
  tmpObj:TRecord_;
  Params:TftParamList;
  tmpGoodsInfo,tmpBarCode,tmpGoodsRelation,tmpGoodsPrice,tmpGoodsExt:TZQuery;
begin
  if dataFactory.iDbType = 5 then Exit;
  Params := TftParamList.Create(nil);
  tmpGoodsInfo := TZQuery.Create(nil);
  tmpBarCode := TZQuery.Create(nil);
  tmpGoodsRelation := TZQuery.Create(nil);
  tmpGoodsPrice := TZQuery.Create(nil);
  tmpGoodsExt := TZQuery.Create(nil);
  dataFactory.MoveToSqlite;
  try
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('PRICE_ID').AsString := '#';
    Params.ParamByName('GODS_ID').AsString := cdsGoodsInfo.FieldByName('GODS_ID').AsString;
    Params.ParamByName('RELATION_ID').AsInteger := cdsGodsRelation.FieldByName('RELATION_ID').AsInteger;
    Params.ParamByName('VIW_GOODSINFO').AsString := dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE',true);

    dataFactory.BeginBatch;
    try
      Params.ParamByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldByName('TENANT_ID').AsInteger;
      dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',Params);
      dataFactory.AddBatch(tmpBarcode,'TBarCodeV60',Params);
      Params.ParamByName('TENANT_ID').AsInteger := cdsGodsRelation.FieldByName('TENANT_ID').AsInteger;
      dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',Params);
      Params.ParamByName('TENANT_ID').AsInteger := cdsGoodsPrice.FieldByName('TENANT_ID').AsInteger;
      dataFactory.AddBatch(tmpGoodsPrice,'TGoodsPriceV60',Params);
      dataFactory.AddBatch(tmpGoodsExt,'TGoodsInfoExtV60',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;

    tmpObj := TRecord_.Create;
    try
      if tmpGoodsInfo.IsEmpty then tmpGoodsInfo.Append else tmpGoodsInfo.Edit;
      tmpObj.ReadFromDataSet(cdsGoodsInfo);
      tmpObj.WriteToDataSet(tmpGoodsInfo);
    finally
      tmpObj.Free;
    end;

    tmpObj := TRecord_.Create;
    try
      if tmpGoodsExt.IsEmpty then tmpGoodsExt.Append else tmpGoodsExt.Edit;
      tmpObj.ReadFromDataSet(cdsGoodsExt);
      tmpObj.WriteToDataSet(tmpGoodsExt);
    finally
      tmpObj.Free;
    end;

    if not cdsGodsRelation.IsEmpty then
    begin
      tmpObj := TRecord_.Create;
      try
        if tmpGoodsRelation.IsEmpty then tmpGoodsRelation.Append else tmpGoodsRelation.Edit;
        tmpObj.ReadFromDataSet(cdsGodsRelation);
        tmpObj.WriteToDataSet(tmpGoodsRelation);
      finally
        tmpObj.Free;
      end;
    end;

    tmpObj := TRecord_.Create;
    try
      if cdsBarCode.Locate('BARCODE_TYPE', '0', []) then
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '0', []) then
              tmpBarCode.Edit
           else
              tmpBarCode.Append;
           tmpObj.ReadFromDataSet(cdsBarCode);
           tmpObj.WriteToDataSet(tmpBarCode);
         end
      else
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '0', []) then
              tmpBarCode.Delete;
         end;

      if cdsBarCode.Locate('BARCODE_TYPE', '1', []) then
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '1', []) then
              tmpBarCode.Edit
           else
              tmpBarCode.Append;
           tmpObj.ReadFromDataSet(cdsBarCode);
           tmpObj.WriteToDataSet(tmpBarCode);
         end
      else
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '1', []) then
              tmpBarCode.Delete;
         end;

      if cdsBarCode.Locate('BARCODE_TYPE', '2', []) then
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '2', []) then
              tmpBarCode.Edit
           else
              tmpBarCode.Append;
           tmpObj.ReadFromDataSet(cdsBarCode);
           tmpObj.WriteToDataSet(tmpBarCode);
         end
      else
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '2', []) then
              tmpBarCode.Delete;
         end;
    finally
      tmpObj.Free;
    end;

    tmpObj := TRecord_.Create;
    try
      if cdsGoodsPrice.Locate('SHOP_ID', token.shopId, []) then
         begin
           if tmpGoodsPrice.Locate('SHOP_ID', token.shopId, []) then
              tmpGoodsPrice.Edit
           else
              tmpGoodsPrice.Append;
           tmpObj.ReadFromDataSet(cdsGoodsPrice);
           tmpObj.WriteToDataSet(tmpGoodsPrice);
         end
      else
         begin
           if tmpGoodsPrice.Locate('SHOP_ID', token.shopId, []) then
              tmpGoodsPrice.Delete;
         end;
    finally
      tmpObj.Free;
    end;
    
    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(tmpGoodsInfo,'TGoodsInfoV60',nil);
      dataFactory.AddBatch(tmpBarcode,'TBarCodeV60',nil);
      dataFactory.AddBatch(tmpGoodsRelation,'TGoodsRelationV60',nil);
      dataFactory.AddBatch(tmpGoodsPrice,'TGoodsPriceV60',nil);
      dataFactory.AddBatch(tmpGoodsExt,'TGoodsInfoExtV60',nil);
      dataFactory.CommitBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
  finally
    dataFactory.MoveToDefault;
    Params.Free;
    tmpGoodsInfo.Free;
    tmpBarCode.Free;
    tmpGoodsRelation.Free;
    tmpGoodsPrice.Free;
    tmpGoodsExt.Free;
  end;
end;

procedure TfrmGoodsStorage.serachTextKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     Open;
end;

procedure TfrmGoodsStorage.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
{
  if (cdsList.FieldByName('LOWER_AMOUNT').AsFloat<>0) and (cdsList.FieldbyName('AMOUNT').AsFloat<cdsList.FieldByName('LOWER_AMOUNT').AsFloat) then
     Background := lower.Color;
  if (cdsList.FieldByName('UPPER_AMOUNT').AsFloat<>0) and (cdsList.FieldbyName('AMOUNT').AsFloat>cdsList.FieldByName('UPPER_AMOUNT').AsFloat) then
     Background := upper.Color;
}
end;

procedure TfrmGoodsStorage.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  DBGridPrint;
  TfrmDBGridPreview.Preview(self,PrintDBGridEh1);
end;

procedure TfrmGoodsStorage.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  DBGridPrint;
  TfrmDBGridPreview.Print(self,PrintDBGridEh1);
end;

procedure TfrmGoodsStorage.DBGridPrint;
begin
  inherited;
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.PageHeader.CenterText.Text := '商品库存报表';
  DBGridEh1.DBGridTitle := '商品库存报表';
  DBGridEh1.DBGridHeader.Text := '';
  DBGridEh1.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+token.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', '']);
end;

procedure TfrmGoodsStorage.ExcelImportClick(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  rs:=TZQuery.Create(nil);
  if TfrmGoodsExcel.ExcelFactory(self,rs,'','',true) then
     dllGlobal.Refresh('PUB_GOODSINFO');
end;

procedure TfrmGoodsStorage.RzLabel37Click(Sender: TObject);
begin
  inherited;
  TfrmMemberPrice.ShowDialog(self,AObj.FieldByName('GODS_ID').AsString,AObj.FieldByName('GODS_CODE').AsString,AObj.FieldByName('GODS_NAME').AsString);
end;

procedure TfrmGoodsStorage.VIPPriceImportClick(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  try
    rs:=TZQuery.Create(nil);
    if TfrmPriceExcel.ExcelFactory(self,rs,'','',true) then
       dllGlobal.Refresh('PUB_GOODSINFO');
  finally
    rs.Free;
  end;
end;

procedure TfrmGoodsStorage.SaveChangeOrder(rs: TZQuery);
var
  rowId:integer;
  Params:TftParamList;
  CHANGE_MNY,CHANGE_AMT:real;
  gs,cdsOrder,cdsData:TZQuery;
begin
  gs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  Params := TftParamList.Create(nil);
  cdsOrder := TZQuery.Create(nil);
  cdsData := TZQuery.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('CHANGE_ID').AsString := getTodayId;
    Params.ParamByName('VIW_GOODSINFO').AsString := dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE',true);
    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsOrder,'TChangeOrderV60',Params);
      dataFactory.AddBatch(cdsData,'TChangeDataV60',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;

    cdsOrder.Edit;
    cdsOrder.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    cdsOrder.FieldByName('CHANGE_ID').AsString := getTodayId;
    cdsOrder.FieldByName('SHOP_ID').AsString := token.shopId;
    cdsOrder.FieldByName('CHANGE_DATE').AsString := formatDatetime('YYYYMMDD',dllGlobal.SysDate);
    cdsOrder.FieldByName('CHANGE_TYPE').AsString := '2';
    cdsOrder.FieldByName('CHANGE_CODE').AsString := '1';
    cdsOrder.FieldByName('DUTY_USER').AsString := token.userId;
    cdsOrder.FieldByName('CHK_DATE').AsString := formatDatetime('YYYY-MM-DD',dllGlobal.SysDate);
    cdsOrder.FieldByName('CHK_USER').AsString := token.userId;
    cdsOrder.FieldByName('CREA_USER').AsString := token.userId;
    cdsOrder.FieldByName('CREA_DATE').AsString := formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    cdsOrder.FieldByName('DEPT_ID').AsString := dllGlobal.getMyDeptId;
    cdsOrder.FieldByName('REMARK').AsString := '库存盘点';
    cdsOrder.Post;

    rowId := 0;
    cdsData.First;
    while not cdsData.Eof do
      begin
        if cdsData.FieldbyName('SEQNO').AsInteger > rowId then
           rowId := cdsData.FieldbyName('SEQNO').AsInteger;
        cdsData.next;
      end;

    rs.First;
    while not rs.Eof do
    begin
      if not gs.Locate('GODS_ID',rs.FieldByName('GODS_ID').AsString,[]) then
         Raise Exception.Create('经营商品中找不到“'+rs.FieldByName('GODS_ID').AsString+'”');

      if cdsData.Locate('GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02',
                        VarArrayOf([rs.FieldByName('GODS_ID').AsString,
                                    rs.FieldByName('BATCH_NO').AsString,
                                    rs.FieldByName('PROPERTY_01').AsString,
                                    rs.FieldByName('PROPERTY_02').AsString]),[]) then
         begin
           cdsData.Edit;
           cdsData.FieldbyName('AMOUNT').AsFloat := cdsData.FieldbyName('AMOUNT').AsFloat + rs.FieldbyName('AMOUNT').AsFloat;
           cdsData.FieldbyName('CALC_AMOUNT').AsFloat := cdsData.FieldbyName('AMOUNT').AsFloat;
           cdsData.FieldbyName('APRICE').AsFloat := gs.FieldByName('NEW_OUTPRICE').AsFloat;
           cdsData.FieldbyName('AMONEY').AsString := FormatFloat('#0.00',cdsData.FieldbyName('AMOUNT').AsFloat*cdsData.FieldbyName('APRICE').AsFloat);
           cdsData.FieldbyName('CALC_MONEY').AsString := cdsData.FieldbyName('AMONEY').AsString;
           cdsData.Post;
         end
      else
         begin
           inc(rowId);
           cdsData.Append;
           cdsData.FieldbyName('TENANT_ID').AsString := cdsOrder.FieldByName('TENANT_ID').AsString;
           cdsData.FieldbyName('CHANGE_ID').AsString := cdsOrder.FieldByName('CHANGE_ID').AsString;
           cdsData.FieldbyName('SHOP_ID').AsString := cdsOrder.FieldByName('SHOP_ID').AsString;
           cdsData.FieldbyName('GODS_ID').AsString := rs.FieldbyName('GODS_ID').AsString;
           cdsData.FieldbyName('SEQNO').AsInteger := rowId;
           cdsData.FieldbyName('UNIT_ID').AsString := gs.FieldByName('CALC_UNITS').AsString;
           cdsData.FieldbyName('IS_PRESENT').AsInteger := 0;
           cdsData.FieldbyName('BATCH_NO').AsString := rs.FieldbyName('BATCH_NO').AsString;
           cdsData.FieldbyName('PROPERTY_01').AsString := rs.FieldbyName('PROPERTY_01').AsString;
           cdsData.FieldbyName('PROPERTY_02').AsString := rs.FieldbyName('PROPERTY_02').AsString;
           cdsData.FieldbyName('AMOUNT').AsFloat := rs.FieldbyName('AMOUNT').AsFloat;
           cdsData.FieldbyName('CALC_AMOUNT').AsFloat := cdsData.FieldbyName('AMOUNT').AsFloat;
           cdsData.FieldbyName('APRICE').AsFloat := gs.FieldByName('NEW_OUTPRICE').AsFloat;
           cdsData.FieldbyName('AMONEY').AsString := FormatFloat('#0.00',cdsData.FieldbyName('AMOUNT').AsFloat*cdsData.FieldbyName('APRICE').AsFloat);
           cdsData.FieldbyName('CALC_MONEY').AsString := cdsData.FieldbyName('AMONEY').AsString;
           cdsData.Post;
         end;
      rs.Next;
    end;

    CHANGE_MNY := 0;
    CHANGE_AMT := 0;
    cdsData.First;
    while not cdsData.Eof do
      begin
        CHANGE_MNY := CHANGE_MNY + cdsData.FieldbyName('CALC_MONEY').AsFloat;
        CHANGE_AMT := CHANGE_AMT + cdsData.FieldbyName('CALC_AMOUNT').AsFloat;
        cdsData.Next;
      end;
    cdsOrder.Edit;
    cdsOrder.FieldByName('CHANGE_AMT').AsFloat := CHANGE_AMT;
    cdsOrder.FieldByName('CHANGE_MNY').AsFloat := CHANGE_MNY;
    cdsOrder.Post;

    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsOrder,'TChangeOrderV60',nil);
      dataFactory.AddBatch(cdsData,'TChangeDataV60',nil);
      dataFactory.CommitBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
  finally
    cdsOrder.Free;
    cdsData.Free;
    Params.Free;
  end;
end;

procedure TfrmGoodsStorage.ClearStorageClick(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if not TfrmClearStorage.ShowDialog(self) then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select GODS_ID,AMOUNT,BATCH_NO,PROPERTY_01,PROPERTY_02 from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and AMOUNT<>0';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    dataFactory.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('当前商品库存全部为零，不需要清零...');
    SaveChangeOrder(rs);
    Open;
    MessageBox(handle,'库存清零成功...','友情提示..',MB_OK+MB_ICONINFORMATION);
  finally
    rs.Free;
  end;
end;

procedure TfrmGoodsStorage.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  ClearStorageClick(nil);
end;

procedure TfrmGoodsStorage.ChangeImportClick(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  try
    rs:=TZQuery.Create(nil);
    if TfrmStorageExcel.ExcelFactory(self,rs,'','',true) then
      SaveChangeOrder(rs);
  finally
    rs.Free;
  end;
end;

initialization
  RegisterClass(TfrmGoodsStorage);
finalization
  UnRegisterClass(TfrmGoodsStorage);
end.
