unit ufrmGoodsStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzButton,
  cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, ComCtrls, RzTreeVw, Grids, DBGridEh, cxButtonEdit, DB, Menus,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, ObjCommon, PrnDbgeh,
  zrComboBoxList, RzBorder, cxCheckBox, RzBmpBtn, RzBckgnd, IniFiles;

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
    edtBK_SHOP_OUTPRICE: TRzPanel;
    RzPanel27: TRzPanel;
    h_label: TRzLabel;
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
    RzBmpButton8: TRzBmpButton;
    N1: TMenuItem;
    edtBK_SHOP_NEW_OUTPRICE1: TRzPanel;
    RzPanel10: TRzPanel;
    t_label: TRzLabel;
    edtSHOP_NEW_OUTPRICE1: TcxTextEdit;
    edtBK_SHOP_NEW_OUTPRICE2: TRzPanel;
    RzPanel12: TRzPanel;
    x_label: TRzLabel;
    edtSHOP_NEW_OUTPRICE2: TcxTextEdit;
    edtBK_SHOP_NEW_OUTPRICE: TRzPanel;
    edtSHOP_NEW_OUTPRICE: TcxTextEdit;
    N2: TMenuItem;
    N6: TMenuItem;
    edtBK_BARCODE1: TRzPanel;
    RzPanel17: TRzPanel;
    RzLabel12: TRzLabel;
    edtBARCODE1: TcxTextEdit;
    edtBK_BARCODE2: TRzPanel;
    RzPanel22: TRzPanel;
    RzLabel18: TRzLabel;
    edtBARCODE2: TcxTextEdit;
    edtDefault1: TcxCheckBox;
    edtDefault2: TcxCheckBox;
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
    procedure RzBmpButton8Click(Sender: TObject);
    procedure edtCALC_UNITSPropertiesChange(Sender: TObject);
    procedure edtSMALL_UNITSPropertiesChange(Sender: TObject);
    procedure edtBIG_UNITSPropertiesChange(Sender: TObject);
    procedure edtSMALLTO_CALCPropertiesChange(Sender: TObject);
    procedure edtBIGTO_CALCPropertiesChange(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure edtCALC_UNITSAddClick(Sender: TObject);
    procedure edtDefault1PropertiesChange(Sender: TObject);
    procedure edtDefault2PropertiesChange(Sender: TObject);
  private
    ESortId:string;
    FSortId:string;
    searchTxt:string;
    relationId:integer;
    relationType:integer;
    AObj:TRecord_;
    storAmt:real;
    FstorFlag: integer;
    FdbState: TDataSetState;
    isSyncUpperAmount:string;
    function  FindColumn(fieldname:string):TColumnEh;
    function  GetOpenWhere:string;
    procedure ReadInfo;
    procedure WriteInfo;
    procedure WriteOweOrder;
    procedure SetdbState(const Value: TDataSetState);virtual;
    procedure SetstorFlag(const Value: integer);
    procedure DBGridPrint;
    procedure SaveChangeOrder(rs: TZQuery);
    procedure RefreshMeaUnits;
    procedure SetShopOutPricePlace;
    procedure AddUnits(Sender: TObject);
    function  GetAidAmt(DataSet: TZQuery): real;
    function  GetAidName(DataSet: TZQuery): string;
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
     udllShopUtil,utokenFactory,uSyncFactory,ufrmGoodsSort,ufrmInitGoods,ufrmMemberPrice,
     ufrmGoodsExcel,ufrmPriceExcel,ufrmDBGridPreview,ufrmClearStorage,ufrmStorageExcel,ufrmMeaUnits;

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
  F:TIniFile;
  rs:TZQuery;
  column:TColumnEh;
begin
  inherited;
  storFlag := 0;
  dllGlobal.CreateGoodsSortTree(rzTree,true);
  rzTree.Items.Add(nil,'����վ');
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
  column.PickList.Add('�޷���');
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

  if not (
     (token.account = 'admin')
     or
     (token.account = 'system')
     or
     (token.account = token.xsmCode)
     or
     (pos(','+token.tenantId+'001,', ','+token.roleIds+',') > 0)) then
     begin
       RzBmpButton4.Visible := false;
       ClearStorage.Visible := false;
       RzBmpButton8.Left := RzBmpButton8.Left - 120;
       RzBmpButton7.Left := RzBmpButton7.Left - 120;
       RzPanel1.Left := RzPanel1.Left - 120;
     end;

  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'r3.cfg');
  try
    isSyncUpperAmount := F.ReadString('soft','SYNC_UPPER_AMOUNT','0');
  finally
    F.Free;
  end;
end;

procedure TfrmGoodsStorage.Open;
var str:string;
begin
  cdsList.Close;

  str := 'select 0 as A,jp.*,isnull(shp.NEW_OUTPRICE,jp.NEW_OUTPRICE_P) as NEW_OUTPRICE,isnull(SHP.NEW_OUTPRICE,JP.NEW_OUTPRICE_P) * JP.AMOUNT as SALE_MNY,JP.NEW_INPRICE * JP.AMOUNT as STOCK_MNY,';

  str := str + '(isnull(SHP.NEW_OUTPRICE,JP.NEW_OUTPRICE_P) - JP.NEW_INPRICE) * JP.AMOUNT as PROFIT_MNY,';

  if dataFactory.iDbType <> 4 then
     str := str + 'jp.AID_AMT'+GetStrJoin(dataFactory.iDbType)+'jp.AID_NAME as AID_AMOUNT from ('
  else
     str := str + ''''' as AID_AMOUNT from (';

  str := str +
   'select j.TENANT_ID,'''+token.shopId+''' as CUR_SHOP_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.SORT_ID1,j.RELATION_ID,j.CALC_UNITS,j.SMALL_UNITS,j.BIG_UNITS,j.UNIT_ID,j.SMALLTO_CALC,j.BIGTO_CALC,j.PRICE_ID,j.COMM,'+
   'c.AMOUNT,'+
   'round((c.AMOUNT * 1.000 / (cast((case when j.UNIT_ID=j.CALC_UNITS then 1.0 when j.UNIT_ID=j.SMALL_UNITS then j.SMALLTO_CALC when j.UNIT_ID=j.BIG_UNITS then j.BIGTO_CALC else 1.0 end) as decimal(18,3)))),3) as AID_AMT,'+
   'u.UNIT_NAME as AID_NAME,'+
   'isnull(ext.NEW_INPRICE,j.NEW_INPRICE) as NEW_INPRICE,'+
   'isnull(prc.NEW_OUTPRICE,j.NEW_OUTPRICE) as NEW_OUTPRICE_P,ext.LOWER_AMOUNT,ext.UPPER_AMOUNT '+
   'from ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,SHOP_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS,SMALL_UNITS,BIG_UNITS,UNIT_ID,SMALLTO_CALC,BIGTO_CALC,NEW_INPRICE,NEW_OUTPRICE,RELATION_ID,PRICE_ID,COMM',true)+') j '+
   'left outer join  VIW_MEAUNITS u on j.TENANT_ID=u.TENANT_ID and j.UNIT_ID=u.UNIT_ID '+
   'left outer join (select TENANT_ID,GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+''' group by TENANT_ID,GODS_ID) c on j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID '+
   'left outer join  PUB_GOODSINFOEXT ext on j.TENANT_ID=ext.TENANT_ID and j.GODS_ID=ext.GODS_ID '+
   'left outer join  PUB_GOODSPRICE prc on j.TENANT_ID=prc.TENANT_ID and j.GODS_ID=prc.GODS_ID and j.SHOP_ID=prc.SHOP_ID and j.PRICE_ID=trim(prc.PRICE_ID) and prc.COMM not in (''02'',''12'') ) jp '+
   'left outer join  PUB_GOODSPRICE shp on jp.TENANT_ID=shp.TENANT_ID and jp.GODS_ID=shp.GODS_ID and jp.CUR_SHOP_ID=shp.SHOP_ID and jp.PRICE_ID=trim(shp.PRICE_ID) and shp.COMM not in (''02'',''12'') '+GetOpenWhere + ' ';

  cdsList.SQL.Text := ParseSQL(dataFactory.iDbType, str);
  cdsList.SQL.Text := cdsList.SQL.Text + ' order by GODS_CODE';
  dataFactory.Open(cdsList);

  if dataFactory.iDbType = 4 then
     begin
       cdsList.DisableControls;
       try
         cdsList.First;
         while not cdsList.Eof do
           begin
             if cdsList.FieldByName('AID_AMT').AsString <> '' then
                begin
                  cdsList.Edit;
                  cdsList.FieldByName('AID_AMOUNT').AsString := cdsList.FieldByName('AID_AMT').AsString + cdsList.FieldByName('AID_NAME').AsString;
                  cdsList.Post;
                end;
             cdsList.Next;
           end;
         cdsList.First;
       finally;
         cdsList.EnableControls;
       end;
     end;
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
       if rzTree.Selected.Text='����վ' then
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
       result := result + '(jp.GODS_NAME like ''%'+trim(searchTxt)+'%'' or jp.GODS_CODE like ''%'+trim(searchTxt)+'%'' or jp.GODS_ID in (select GODS_ID from PUB_BARCODE where TENANT_ID in ('+dllGlobal.GetRelatTenantInWhere+') and BARCODE like ''%'+trim(searchTxt)+'%''))';
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
  toolSpacer.Visible := Node.Text<>'����վ';
  toolEdit.Visible := Node.Text<>'����վ';
  if toolEdit.Visible then
     toolDelete.Caption := 'ɾ��'
  else
     toolDelete.Caption := '��ԭ';
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
     raise Exception.Create('������û�ҵ���ǰ��Ӧ��������ͬ��������'); 
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
    relationId := relation;
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
  if not (
     (token.account = 'admin')
     or
     (token.account = 'system')
     or
     (token.account = token.xsmCode)
     or
     (pos(','+token.tenantId+'001,', ','+token.roleIds+',') > 0)) then
     begin
       edtAMOUNT.Properties.ReadOnly := true;
       SetEditStyle(dsBrowse,edtAMOUNT.Style);
       edtBK_AMOUNT.Color := edtAMOUNT.Style.Color;
     end
  else
     begin
       edtAMOUNT.Properties.ReadOnly := false;
       SetEditStyle(dsInsert,edtAMOUNT.Style);
       edtBK_AMOUNT.Color := edtAMOUNT.Style.Color;
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
       cdsList.FieldByName('SMALL_UNITS').AsString := edtSMALL_UNITS.AsString;
       cdsList.FieldByName('BIG_UNITS').AsString := edtBIG_UNITS.AsString;
       cdsList.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('UNIT_ID').AsString;
       cdsList.FieldByName('SMALLTO_CALC').AsFloat := cdsGoodsInfo.FieldByName('SMALLTO_CALC').AsFloat;
       cdsList.FieldByName('BIGTO_CALC').AsFloat := cdsGoodsInfo.FieldByName('BIGTO_CALC').AsFloat;
       cdsList.FieldByName('NEW_INPRICE').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0);
       cdsList.FieldByName('NEW_OUTPRICE').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0);
       cdsList.FieldByName('BARCODE').AsString := edtBARCODE.Text;
       cdsList.FieldByName('AMOUNT').AsString := edtAMOUNT.Text;
       cdsList.FieldByName('AID_AMT').AsFloat := GetAidAmt(cdsList);
       cdsList.FieldByName('AID_NAME').AsString := GetAidName(cdsList);
       cdsList.FieldByName('AID_AMOUNT').AsString := cdsList.FieldByName('AID_AMT').AsString + cdsList.FieldByName('AID_NAME').AsString;
       if (relationId=1000006) and (isSyncUpperAmount='1') and (AObj.FieldByName('SMALLTO_CALC').AsString<>'') then //������ʾ����λ
          begin
            cdsList.FieldByName('LOWER_AMOUNT').AsFloat := StrtoFloatDef(edtLOWER_AMOUNT.Text,0) * AObj.FieldByName('SMALLTO_CALC').AsFloat;
            cdsList.FieldByName('UPPER_AMOUNT').AsFloat := StrtoFloatDef(edtUPPER_AMOUNT.Text,0) * AObj.FieldByName('SMALLTO_CALC').AsFloat;
          end
       else
          begin
            cdsList.FieldByName('LOWER_AMOUNT').AsFloat := StrtoFloatDef(edtLOWER_AMOUNT.Text,0);
            cdsList.FieldByName('UPPER_AMOUNT').AsFloat := StrtoFloatDef(edtUPPER_AMOUNT.Text,0);
          end;
       cdsList.FieldByName('SALE_MNY').AsFloat := cdsList.FieldByName('AMOUNT').AsFloat * cdsList.FieldByName('NEW_OUTPRICE').AsFloat;
       cdsList.FieldByName('STOCK_MNY').AsFloat := cdsList.FieldByName('AMOUNT').AsFloat * cdsList.FieldByName('NEW_INPRICE').AsFloat;
       cdsList.FieldByName('PROFIT_MNY').AsFloat := (cdsList.FieldByName('NEW_OUTPRICE').AsFloat - cdsList.FieldByName('NEW_INPRICE').AsFloat) * cdsList.FieldByName('AMOUNT').AsFloat;
       cdsList.Post;
     end;
end;

procedure TfrmGoodsStorage.ReadInfo;
begin
  if cdsGoodsInfo.FieldByName('UNIT_ID').AsString = cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString then
     begin
       edtDefault1.Checked := true;
       edtDefault2.Checked := false;
     end
  else if cdsGoodsInfo.FieldByName('UNIT_ID').AsString = cdsGoodsInfo.FieldByName('BIG_UNITS').AsString then
     begin
       edtDefault1.Checked := false;
       edtDefault2.Checked := true;
     end
  else
     begin
       edtDefault1.Checked := false;
       edtDefault2.Checked := false;
     end;

  if cdsBarcode.Locate('BARCODE_TYPE','1',[]) then
     begin
       if cdsBarCode.FieldByName('COMM').AsString[2] <> '2' then
          edtBARCODE1.Text := cdsBarcode.FieldByName('BARCODE').AsString
       else
          edtBARCODE1.Text := '';
     end
  else
     begin
       edtBARCODE1.Text := '';
     end;

  if cdsBarcode.Locate('BARCODE_TYPE','2',[]) then
     begin
       if cdsBarCode.FieldByName('COMM').AsString[2] <> '2' then
          edtBARCODE2.Text := cdsBarcode.FieldByName('BARCODE').AsString
       else
          edtBARCODE2.Text := '';
     end
  else
     begin
       edtBARCODE2.Text := '';
     end;

  AObj.ReadFromDataSet(cdsGoodsInfo);
  ReadFromObject(AObj,self);
  ESortId := AObj.FieldByName('SORT_ID1').AsString;
  if ESortId = '#' then
     edtSORT_ID1.Text := '�� �� ��'
  else
     edtSORT_ID1.Text := TdsFind.GetNameByID(dllGlobal.GetZQueryFromName('PUB_GOODSSORT'),'SORT_ID','SORT_NAME',AObj.FieldByName('SORT_ID1').AsString);
  if (AObj.FieldByName('TENANT_ID').AsString<>token.tenantId) and not cdsGodsRelation.IsEmpty then //����Ǿ����̼��˵���Ʒ��������������
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
            if ESortId = '#' then
               edtSORT_ID1.Text := '�� �� ��'
            else
               edtSORT_ID1.Text := TdsFind.GetNameByID(dllGlobal.GetZQueryFromName('PUB_GOODSSORT'),'SORT_ID','SORT_NAME',cdsGodsRelation.FieldByName('SORT_ID1').AsString);
          end;
       if cdsGodsRelation.FieldByName('NEW_INPRICE').AsString <> '' then
          edtNEW_INPRICE.Text := cdsGodsRelation.FieldByName('NEW_INPRICE').AsString;
       if cdsGodsRelation.FieldByName('NEW_OUTPRICE').AsString <> '' then
          edtNEW_OUTPRICE.Text := cdsGodsRelation.FieldByName('NEW_OUTPRICE').AsString;
     end;
  if not cdsGoodsExt.IsEmpty then
     begin
       if cdsGoodsExt.FieldbyName('NEW_INPRICE').AsString <> '' then
          edtNEW_INPRICE.Text := cdsGoodsExt.FieldbyName('NEW_INPRICE').AsString;
     end;

  //�����ۼ�
  edtSHOP_NEW_OUTPRICE.Text := edtNEW_OUTPRICE.Text;

  if edtSMALL_UNITS.AsString <> '' then
     begin
       if (edtSMALLTO_CALC.Text<>'') and (edtSHOP_NEW_OUTPRICE.Text<>'') then
          edtSHOP_NEW_OUTPRICE1.Text:=FloattoStr(StrtoFloatDef(edtSMALLTO_CALC.Text,0)*StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0));
     end;

  if edtBIG_UNITS.AsString <> '' then
     begin
       if (edtBIGTO_CALC.Text<>'') and (edtSHOP_NEW_OUTPRICE.Text<>'') then
          edtSHOP_NEW_OUTPRICE2.Text:=FloattoStr(StrtoFloatDef(edtBIGTO_CALC.Text,0)*StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0));
     end;

  if not cdsGoodsPrice.IsEmpty then
      begin
        cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]);
        if (cdsGoodsPrice.FieldByName('COMM').AsString<>'02') and (cdsGoodsPrice.FieldByName('COMM').AsString<>'12') then
           begin
             edtSHOP_NEW_OUTPRICE.Text := cdsGoodsPrice.FieldbyName('NEW_OUTPRICE').AsString;
             edtSHOP_NEW_OUTPRICE1.Text:= cdsGoodsPrice.FieldbyName('NEW_OUTPRICE1').AsString;
             edtSHOP_NEW_OUTPRICE2.Text:= cdsGoodsPrice.FieldbyName('NEW_OUTPRICE2').AsString;
           end;
      end;

  if (relationId=1000006) and (isSyncUpperAmount='1') and (AObj.FieldByName('SMALLTO_CALC').AsString<>'') then //������ʾ����λ
     begin
       edtLOWER_AMOUNT.Text := FormatFloat('#0.###',cdsGoodsExt.FieldByName('LOWER_AMOUNT').AsFloat / AObj.FieldByName('SMALLTO_CALC').AsFloat);
       edtUPPER_AMOUNT.Text := FormatFloat('#0.###',cdsGoodsExt.FieldByName('UPPER_AMOUNT').AsFloat / AObj.FieldByName('SMALLTO_CALC').AsFloat);
     end
  else
     begin
       edtLOWER_AMOUNT.Text := FormatFloat('#0.###',cdsGoodsExt.FieldByName('LOWER_AMOUNT').AsFloat);
       edtUPPER_AMOUNT.Text := FormatFloat('#0.###',cdsGoodsExt.FieldByName('UPPER_AMOUNT').AsFloat);
     end;

  edtUNIT_ID_USING.Checked := (AObj.FieldbyName('SMALL_UNITS').AsString<>'') or (AObj.FieldbyName('BIG_UNITS').AsString<>'');

  if edtUNIT_ID_USING.Checked then
    begin
      SetShopOutPricePlace;
    end
  else
    begin
      edtBK_SHOP_NEW_OUTPRICE1.Visible:=false;
      edtBK_SHOP_NEW_OUTPRICE2.Visible:=false;
      edtBK_SHOP_OUTPRICE.Width:=218;
      RzPanel9.Left:=520;
    end;

  if cdsList.FieldbyName('AMOUNT').AsString<>'' then
     storAmt := cdsList.FieldbyName('AMOUNT').AsFloat
  else
     storAmt:=0;

  edtAMOUNT.Text := FormatFloat('#0.###',storAmt);
end;

procedure TfrmGoodsStorage.WriteInfo;
  function GetRowsId(Barcode,BarCodeType:string):string;
  var
    i:integer;
    gid:string;
  begin
    gid := BarCodeType+Barcode;
    for i:=1 to (36-length(gid)) do gid := '0'+gid;
    result := gid;
  end;
var
  isDel:boolean;
  i,o,p,p1,p2:real;
begin
  WriteToObject(AObj,self);
  edtBARCODE1.Text := trim(edtBARCODE1.Text);
  edtBARCODE2.Text := trim(edtBARCODE2.Text);

  if not edtUNIT_ID_USING.Checked then
    begin
      AObj.FieldbyName('SMALL_UNITS').AsString:='';
      AObj.FieldbyName('BIG_UNITS').AsString:='';
      AObj.FieldbyName('SMALLTO_CALC').AsString :='';
      AObj.FieldbyName('BIGTO_CALC').AsString :='';
      AObj.FieldbyName('UNIT_ID').AsString := AObj.FieldbyName('CALC_UNITS').AsString;
      edtDefault1.Checked := false;
      edtDefault2.Checked := false;
      edtSMALL_UNITS.KeyValue := null;
      edtSMALL_UNITS.Text := '';
      edtBIG_UNITS.KeyValue := null;
      edtBIG_UNITS.Text := '';
      edtBARCODE1.Text := '';
      edtBARCODE2.Text := '';
    end
  else
    begin
      if (edtSMALL_UNITS.Text<>'') and (StrtoFloatDef(edtSMALLTO_CALC.Text,0)=0) then
         Raise Exception.Create('�������0��С����λ����ϵ����');
      if (edtSMALL_UNITS.Text<>'') and (trim(edtBARCODE1.Text)='') then
         Raise Exception.Create('������С����λ���룡');
      if (StrtoFloatDef(edtSMALLTO_CALC.Text,0)<>0) and (trim(edtBARCODE1.Text)='') then
         Raise Exception.Create('������С����λ���룡');
      if (StrtoFloatDef(edtSMALLTO_CALC.Text,0)<>0) and (edtSMALL_UNITS.Text='') then
         Raise Exception.Create('��ѡ��С����λ��');
      if (trim(edtBARCODE1.Text)<>'') and (edtSMALL_UNITS.Text='') then
         Raise Exception.Create('��ѡ��С����λ��');

      if (edtBIG_UNITS.Text<>'') and (StrtoFloatDef(edtBIGTO_CALC.Text,0)=0) then
         Raise Exception.Create('�������0�Ĵ����λ����ϵ����');
      if (edtBIG_UNITS.Text<>'') and (trim(edtBARCODE2.Text)='') then
         Raise Exception.Create('����������λ���룡');
      if (StrtoFloatDef(edtBIGTO_CALC.Text,0)<>0) and (trim(edtBARCODE2.Text)='') then
         Raise Exception.Create('����������λ���룡');
      if (StrtoFloatDef(edtBIGTO_CALC.Text,0)<>0) and (edtBIG_UNITS.Text='') then
         Raise Exception.Create('��ѡ������λ��');
      if (trim(edtBARCODE2.Text)<>'') and (edtBIG_UNITS.Text='') then
         Raise Exception.Create('��ѡ������λ��');
    end;

  if relationId = 1000006 then
     begin
       if dllGlobal.GetChangePrice(relationId) = '3' then
          begin
            i := StrtoFloatDef(edtNEW_INPRICE.Text,0);
            o := StrtoFloatDef(edtNEW_OUTPRICE.Text,0);
            p := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0);
            p1 := StrtoFloatDef(edtSHOP_NEW_OUTPRICE1.Text,0);
            p2 := StrtoFloatDef(edtSHOP_NEW_OUTPRICE2.Text,0);

            if FnNumber.CompareFloat(p, o) > 0 then
               begin
                 Raise Exception.Create('������λ�ۼ۲��ܸ���ָ�����ۼۣ�');
               end;
            if FnNumber.CompareFloat(p, i) < 0 then
               begin
                 Raise Exception.Create('������λ�ۼ۲��ܵ��ڽ��ۣ�');
               end;

            if AObj.FieldByName('SMALL_UNITS').AsString <> '' then
               begin
                 if FnNumber.CompareFloat(p1, o * AObj.FieldByName('SMALLTO_CALC').AsFloat) > 0 then
                    begin
                      Raise Exception.Create('С����λ�ۼ۲��ܸ���ָ�����ۼۣ�');
                    end;
                 if FnNumber.CompareFloat(p1, i * AObj.FieldByName('SMALLTO_CALC').AsFloat) < 0 then
                    begin
                      Raise Exception.Create('С����λ�ۼ۲��ܵ��ڽ��ۣ�');
                    end;
               end;

            if AObj.FieldByName('BIG_UNITS').AsString <> '' then
               begin
                 if FnNumber.CompareFloat(p2, o * AObj.FieldByName('BIGTO_CALC').AsFloat) > 0 then
                    begin
                      Raise Exception.Create('�����λ�ۼ۲��ܸ���ָ�����ۼۣ�');
                    end;
                 if FnNumber.CompareFloat(p2, i * AObj.FieldByName('BIGTO_CALC').AsFloat) < 0 then
                    begin
                      Raise Exception.Create('�����λ�ۼ۲��ܵ��ڽ��ۣ�');
                    end;
               end;
          end;
     end;

  if relationId=0 then  //�Ծ�Ӫ
     begin
       cdsGoodsInfo.Edit;
       AObj.WriteToDataSet(cdsGoodsInfo);
       cdsGoodsInfo.FieldbyName('SORT_ID1').AsString := ESortId;
       cdsGoodsInfo.Post;
       cdsGodsRelation.CancelUpdates;
     end
  else
     begin
        cdsGoodsInfo.CancelUpdates;
        cdsGoodsInfo.Edit;
        cdsGoodsInfo.FieldbyName('CALC_UNITS').AsString := AObj.FieldbyName('CALC_UNITS').asString;
        cdsGoodsInfo.FieldbyName('SMALL_UNITS').AsString := AObj.FieldbyName('SMALL_UNITS').asString;
        cdsGoodsInfo.FieldbyName('BIG_UNITS').AsString := AObj.FieldbyName('BIG_UNITS').asString;
        cdsGoodsInfo.FieldbyName('SMALLTO_CALC').AsString := AObj.FieldbyName('SMALLTO_CALC').asString;
        cdsGoodsInfo.FieldbyName('BIGTO_CALC').AsString := AObj.FieldbyName('BIGTO_CALC').asString;
        cdsGoodsInfo.Post;
        if (relationType=1) and not cdsGodsRelation.IsEmpty then //�����̼���
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

  cdsGoodsInfo.Edit;
  if edtDEFAULT1.Checked then
     begin
       if cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString <> '' then
          cdsGoodsInfo.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('SMALL_UNITS').AsString
       else
          cdsGoodsInfo.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('CALC_UNITS').AsString;
     end
  else if edtDEFAULT2.Checked then
     begin
       if cdsGoodsInfo.FieldByName('BIG_UNITS').AsString <> '' then
          cdsGoodsInfo.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('BIG_UNITS').AsString
       else
          cdsGoodsInfo.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('CALC_UNITS').AsString;
     end
  else
     begin
       cdsGoodsInfo.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldByName('CALC_UNITS').AsString;
     end;
  cdsGoodsInfo.Post;

  if cdsBarcode.Locate('BARCODE_TYPE','0',[]) then
     begin
       cdsBarcode.Edit;
       cdsBarcode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldbyName('CALC_UNITS').AsString;
       cdsBarcode.FieldbyName('BARCODE').AsString := edtBARCODE.Text;
       cdsBarcode.Post;
     end;

  if cdsBarcode.Locate('BARCODE_TYPE','1',[]) then
     begin
       if trim(edtBARCODE1.Text) <> '' then
          begin
            cdsBarcode.Edit;
            cdsBarcode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldbyName('SMALL_UNITS').AsString;
            cdsBarcode.FieldbyName('BARCODE').AsString := edtBARCODE1.Text;
            cdsBarcode.Post;
          end
       else cdsBarcode.Delete;
     end
  else
     begin
       if trim(edtBARCODE1.Text) <> '' then
          begin
            cdsBarcode.Append;
            cdsBarcode.FieldByName('ROWS_ID').AsString := GetRowsId(trim(edtBARCODE1.Text),'1');
            cdsBarcode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldbyName('TENANT_ID').AsInteger;
            cdsBarcode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldbyName('GODS_ID').AsString;
            cdsBarcode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldbyName('SMALL_UNITS').AsString;
            cdsBarcode.FieldByName('BARCODE_TYPE').AsString := '1';
            cdsBarcode.FieldByName('PROPERTY_01').AsString := '#';
            cdsBarcode.FieldByName('PROPERTY_02').AsString := '#';
            cdsBarcode.FieldByName('BATCH_NO').AsString := '#';
            cdsBarcode.FieldByName('BARCODE').AsString := trim(edtBARCODE1.Text);
          end;
     end;

  if cdsBarcode.Locate('BARCODE_TYPE','2',[]) then
     begin
       if trim(edtBARCODE2.Text) <> '' then
          begin
            cdsBarcode.Edit;
            cdsBarcode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldbyName('BIG_UNITS').AsString;
            cdsBarcode.FieldbyName('BARCODE').AsString := edtBARCODE2.Text;
            cdsBarcode.Post;
          end
       else cdsBarcode.Delete;
     end
  else
     begin
       if trim(edtBARCODE2.Text) <> '' then
          begin
            cdsBarcode.Append;
            cdsBarcode.FieldByName('ROWS_ID').AsString := GetRowsId(trim(edtBARCODE2.Text),'2');
            cdsBarcode.FieldByName('TENANT_ID').AsInteger := cdsGoodsInfo.FieldbyName('TENANT_ID').AsInteger;
            cdsBarcode.FieldByName('GODS_ID').AsString := cdsGoodsInfo.FieldbyName('GODS_ID').AsString;
            cdsBarcode.FieldByName('UNIT_ID').AsString := cdsGoodsInfo.FieldbyName('BIG_UNITS').AsString;
            cdsBarcode.FieldByName('BARCODE_TYPE').AsString := '2';
            cdsBarcode.FieldByName('PROPERTY_01').AsString := '#';
            cdsBarcode.FieldByName('PROPERTY_02').AsString := '#';
            cdsBarcode.FieldByName('BATCH_NO').AsString := '#';
            cdsBarcode.FieldByName('BARCODE').AsString := trim(edtBARCODE2.Text);
          end;
     end;

  if cdsGoodsExt.IsEmpty then cdsGoodsExt.Append else cdsGoodsExt.Edit;
  cdsGoodsExt.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
  cdsGoodsExt.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
  if relationId=1000006 then
     begin
       if FnNumber.CompareFloat(cdsGodsRelation.FieldbyName('NEW_INPRICE').AsFloat,StrtoFloatDef(edtNEW_INPRICE.Text,0)) <> 0 then
          begin
            cdsGoodsExt.FieldByName('NEW_INPRICE').AsFloat  := StrtoFloatDef(edtNEW_INPRICE.Text,0);
            cdsGoodsExt.FieldByName('NEW_INPRICE1').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0)*StrtoFloatDef(edtSMALLTO_CALC.TEXT,0);
            cdsGoodsExt.FieldByName('NEW_INPRICE2').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0)*StrtoFloatDef(edtBIGTO_CALC.TEXT,0);
          end
       else
          begin
            cdsGoodsExt.FieldByName('NEW_INPRICE').Value  := null;
            cdsGoodsExt.FieldByName('NEW_INPRICE1').Value := null;
            cdsGoodsExt.FieldByName('NEW_INPRICE2').Value := null;
          end;
     end
  else
     begin
       cdsGoodsExt.FieldByName('NEW_INPRICE').AsFloat  := StrtoFloatDef(edtNEW_INPRICE.Text,0);
       cdsGoodsExt.FieldByName('NEW_INPRICE1').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0)*StrtoFloatDef(edtSMALLTO_CALC.TEXT,0);
       cdsGoodsExt.FieldByName('NEW_INPRICE2').AsFloat := StrtoFloatDef(edtNEW_INPRICE.Text,0)*StrtoFloatDef(edtBIGTO_CALC.TEXT,0);
     end;
  if (relationId=1000006) and (isSyncUpperAmount='1') and (AObj.FieldByName('SMALLTO_CALC').AsString<>'') then //������ʾ����λ
     begin
       cdsGoodsExt.FieldByName('LOWER_AMOUNT').AsFloat := StrtoFloatDef(edtLOWER_AMOUNT.Text,0) * AObj.FieldByName('SMALLTO_CALC').AsFloat;
       cdsGoodsExt.FieldByName('UPPER_AMOUNT').AsFloat := StrtoFloatDef(edtUPPER_AMOUNT.Text,0) * AObj.FieldByName('SMALLTO_CALC').AsFloat;
     end
  else
     begin
       cdsGoodsExt.FieldByName('LOWER_AMOUNT').AsFloat := StrtoFloatDef(edtLOWER_AMOUNT.Text,0);
       cdsGoodsExt.FieldByName('UPPER_AMOUNT').AsFloat := StrtoFloatDef(edtUPPER_AMOUNT.Text,0);
     end;
  cdsGoodsExt.Post;

  isDel := false;
  if (FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0))=0) and
     (FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE1.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0)*StrtoFloatDef(edtSMALLTO_CALC.Text,0))=0) and
     (FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE2.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0)*StrtoFloatDef(edtBIGTO_CALC.Text,0))=0)
   then
     begin
        if cdsGoodsPrice.Locate('SHOP_ID',token.tenantId+'0001',[]) and
           (FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0),cdsGoodsPrice.FieldByName('NEW_OUTPRICE').AsFloat)=0)
        then
           isDel := true;
        if cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]) and (cdsGoodsPrice.RecordCount=1) then
           isDel := true;
        if IsDel and cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]) then cdsGoodsPrice.Delete;
     end;
  if not isDel and
    ((FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0))<>0) or
     (FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE1.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0)*StrtoFloatDef(edtSMALLTO_CALC.Text,0))<>0)  or
     (FnNumber.CompareFloat(StrtoFloatDef(edtSHOP_NEW_OUTPRICE2.Text,0),StrtoFloatDef(edtNEW_OUTPRICE.Text,0)*StrtoFloatDef(edtBIGTO_CALC.Text,0))<>0))
  then
     begin
       cdsGoodsPrice.Edit;
       cdsGoodsPrice.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       cdsGoodsPrice.FieldByName('PRICE_ID').AsString :=  '#';
       cdsGoodsPrice.FieldByName('SHOP_ID').AsString := token.shopId;
       cdsGoodsPrice.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
       cdsGoodsPrice.FieldByName('PRICE_METHOD').AsString := '1';
       cdsGoodsPrice.FieldByName('NEW_OUTPRICE').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0);
       if (edtSHOP_NEW_OUTPRICE1.Text<>'') and (edtBK_SMALL_UNITS.Visible) and (edtSMALL_UNITS.Text<>'') then
          cdsGoodsPrice.FieldByName('NEW_OUTPRICE1').AsFloat :=StrtoFloatDef(edtSHOP_NEW_OUTPRICE1.Text,0)
       else
          cdsGoodsPrice.FieldByName('NEW_OUTPRICE1').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)*StrtoFloatDef(edtSMALLTO_CALC.TEXT,0);
       if (edtSHOP_NEW_OUTPRICE2.Text<>'') and (edtBK_BIG_UNITS.Visible) and (edtBIG_UNITS.Text<>'') then
          cdsGoodsPrice.FieldByName('NEW_OUTPRICE2').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE2.Text,0)
       else
          cdsGoodsPrice.FieldByName('NEW_OUTPRICE2').AsFloat := StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)*StrtoFloatDef(edtBIGTO_CALC.TEXT,0);
       cdsGoodsPrice.Post;
     end;
  WriteOweOrder;
end;

procedure TfrmGoodsStorage.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  SetFormEditStatus(self,Value);
  edtUNIT_ID_USING.Properties.ReadOnly := dbState = dsBrowse;
  btnSave.Visible := dbState <> dsBrowse;

  if (relationId=0) then Exit;
  SetEditStyle(dsBrowse,edtBARCODE.Style);
  edtBK_BARCODE.Color := edtBARCODE.Style.Color;
  edtBARCODE.Properties.ReadOnly := true;

  if (relationId=1000006) then
  begin
    if isSyncUpperAmount = '1' then
       begin
         SetEditStyle(dsBrowse,edtUPPER_AMOUNT.Style);
         edtBK_UPPER_AMOUNT.Color := edtUPPER_AMOUNT.Style.Color;
         edtUPPER_AMOUNT.Properties.ReadOnly := true;
       end;

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

    edtDEFAULT1.Properties.ReadOnly := true;
    edtDEFAULT2.Properties.ReadOnly := true;

    SetEditStyle(dsBrowse,edtBARCODE1.Style);
    edtBK_BARCODE1.Color := edtBARCODE1.Style.Color;
    edtBARCODE1.Properties.ReadOnly := true;

    SetEditStyle(dsBrowse,edtBARCODE2.Style);
    edtBK_BARCODE2.Color := edtBARCODE2.Style.Color;
    edtBARCODE2.Properties.ReadOnly := true;
  end;

  if dllGlobal.GetChangePrice(relationId) = '2' then
     begin
       SetEditStyle(dsBrowse,edtSHOP_NEW_OUTPRICE.Style);
       edtSHOP_NEW_OUTPRICE.Properties.ReadOnly := true;

       SetEditStyle(dsBrowse,edtSHOP_NEW_OUTPRICE1.Style);
       edtSHOP_NEW_OUTPRICE1.Properties.ReadOnly := true;

       SetEditStyle(dsBrowse,edtSHOP_NEW_OUTPRICE2.Style);
       edtSHOP_NEW_OUTPRICE2.Properties.ReadOnly := true;

       edtBK_SHOP_NEW_OUTPRICE.Color := edtSHOP_NEW_OUTPRICE.Style.Color;
       edtBK_SHOP_NEW_OUTPRICE1.Color := edtSHOP_NEW_OUTPRICE1.Style.Color;
       edtBK_SHOP_NEW_OUTPRICE2.Color := edtSHOP_NEW_OUTPRICE2.Style.Color;
     end;

  if relationType=1 then Exit;

  SetEditStyle(dsBrowse,edtNEW_INPRICE.Style);
  edtBK_NEW_INPRICE.Color := edtNEW_INPRICE.Style.Color;
  edtNEW_INPRICE.Properties.ReadOnly := true;
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
  TDbGridEhExport.InitForm(self);
end;

procedure TfrmGoodsStorage.FormDestroy(Sender: TObject);
begin
  TDbGridEhExport.FreeForm(self);
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
    frmSortDropFrom.ShowCgtSort := false;
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
  edtBK_BARCODE1.Visible := edtUNIT_ID_USING.Checked;
  edtBK_BARCODE2.Visible := edtUNIT_ID_USING.Checked;
  if edtUNIT_ID_USING.Checked then
    begin
      edtSHOP_NEW_OUTPRICE1.Properties.ReadOnly:=true;
      edtSHOP_NEW_OUTPRICE2.Properties.ReadOnly:=true;
      if (edtSMALLTO_CALC.Text<>'') and (edtSHOP_NEW_OUTPRICE.Text<>'') then
        begin
          edtSHOP_NEW_OUTPRICE1.Properties.ReadOnly:=false;
          t_label.Caption:=edtSMALL_UNITS.Text+'��';
          edtSHOP_NEW_OUTPRICE1.Text:=FloattoStr(StrtoFloatDef(edtSMALLTO_CALC.Text,0)*StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0));
        end
      else
        begin
          if (edtSMALLTO_CALC.Text='') or (edtSHOP_NEW_OUTPRICE.Text='') then
             edtSHOP_NEW_OUTPRICE1.Text:='';
          if edtSMALL_UNITS.Text ='' then
             t_label.Caption:='�ۼ�';
        end;
      if (edtBIGTO_CALC.Text<>'') and (edtSHOP_NEW_OUTPRICE.Text<>'') then
        begin
          edtSHOP_NEW_OUTPRICE2.Properties.ReadOnly:=false;
          x_label.Caption:=edtBIG_UNITS.Text+'��';
          edtSHOP_NEW_OUTPRICE2.Text:=FloattoStr(StrtoFloatDef(edtBIGTO_CALC.Text,0)*StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0));
        end
      else
        begin
          if (edtBIGTO_CALC.Text='') or (edtSHOP_NEW_OUTPRICE.Text='') then
             edtSHOP_NEW_OUTPRICE2.Text:='';
          if edtBIG_UNITS.Text ='' then
             x_label.Caption:='�ۼ�';
        end;
      //�õ����ۼ۶���
      if not cdsGoodsPrice.IsEmpty then
      begin
        cdsGoodsPrice.Locate('SHOP_ID',token.shopId,[]);
        if (cdsGoodsPrice.FieldByName('COMM').AsString<>'02') and (cdsGoodsPrice.FieldByName('COMM').AsString<>'12') then
           begin
             edtSHOP_NEW_OUTPRICE.Text := cdsGoodsPrice.FieldbyName('NEW_OUTPRICE').AsString;
             edtSHOP_NEW_OUTPRICE1.Text:= cdsGoodsPrice.FieldbyName('NEW_OUTPRICE1').AsString;
             edtSHOP_NEW_OUTPRICE2.Text:= cdsGoodsPrice.FieldbyName('NEW_OUTPRICE2').AsString;
           end;
      end;

      SetShopOutPricePlace;
    end
  else
    begin
      edtBK_SHOP_NEW_OUTPRICE1.Visible:=false;
      edtBK_SHOP_NEW_OUTPRICE2.Visible:=false;
      edtBK_SHOP_OUTPRICE.Width:=218;
      RzPanel9.Left:=520;
    end;
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
  if (DBGridEh1.Col>=0) and (DBGridEh1.Columns[DBGridEh1.Col].FieldName='AMOUNT') then edtAMOUNT.SetFocus;
  if (DBGridEh1.Col>=0) and (DBGridEh1.Columns[DBGridEh1.Col].FieldName='NEW_INPRICE') then edtNEW_INPRICE.SetFocus;
  if (DBGridEh1.Col>=0) and (DBGridEh1.Columns[DBGridEh1.Col].FieldName='NEW_OUTPRICE') then edtSHOP_NEW_OUTPRICE.SetFocus;
end;

procedure TfrmGoodsStorage.WriteOweOrder;
var
  rs:TZQuery;
  curAmt,CHANGE_MNY,CHANGE_AMT:Real;
  rowId:integer;
begin
  if storAmt=StrtoFloatDef(edtAMOUNT.Text,0) then Exit;
  //���浥��
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select AMOUNT,BATCH_NO,PROPERTY_01,PROPERTY_02 from STO_STORAGE where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    rs.ParamByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    dataFactory.Open(rs);
    if not rs.IsEmpty then
       begin
         if rs.RecordCount>1 then Raise Exception.Create('���ڶ����ſ�棬��������̵�');
         if (rs.FieldByName('BATCH_NO').AsString<>'#') or (rs.FieldByName('PROPERTY_01').AsString<>'#') or (rs.FieldByName('PROPERTY_02').AsString<>'#') then Raise Exception.Create('���ڶ����ſ�棬��������̵�');
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
  cdsHeader.FieldByName('REMARK').AsString := '�޸Ŀ��';
  cdsHeader.Post;
  
  if cdsDetail.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then
     begin
       cdsDetail.Edit;
       cdsDetail.FieldbyName('AMOUNT').AsFloat := cdsDetail.FieldbyName('AMOUNT').AsFloat - (StrtoFloatDef(edtAMOUNT.Text,0)-curAmt);
       cdsDetail.FieldbyName('CALC_AMOUNT').AsFloat := cdsDetail.FieldbyName('AMOUNT').AsFloat;
       cdsDetail.FieldbyName('AMONEY').AsString := FormatFloat('#0.00',cdsDetail.FieldbyName('AMOUNT').AsFloat*cdsDetail.FieldbyName('APRICE').AsFloat);
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
       cdsDetail.FieldbyName('AMONEY').AsString := FormatFloat('#0.00',cdsDetail.FieldbyName('AMOUNT').AsFloat*cdsDetail.FieldbyName('APRICE').AsFloat);
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
  0:btnAMOUNT.Caption := '��������';
  1:btnAMOUNT.Caption := '��ʾȫ��';
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
              Raise Exception.Create('����ɾ����Ӧ���е���Ʒ');
         end;
       end;
     end
  else
     raise Exception.Create('������û�ҵ���ǰ��Ӧ��������ͬ��������');
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
       if MessageBox(Handle,'�Ƿ�ɾ����ǰ�е���Ʒ��','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       DeleteInfo(cdsList.FieldbyName('GODS_ID').AsString,cdsList.FieldbyName('RELATION_ID').AsInteger);
       cdsList.Delete;
     end
  else
     begin
       if MessageBox(Handle,'�Ƿ�ԭ��ǰ�е���Ʒ��','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
              Raise Exception.Create('���ܸ��Ĺ�Ӧ���е���Ʒ');
         end;
       end;
     end
  else
     raise Exception.Create('������û�ҵ���ǰ��Ӧ��������ͬ��������');
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
         rzTree.Items.Add(nil,'����վ');
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
       EditPanel.Visible := false;
       RefreshMeaUnits;
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
  if not isSelected then Raise Exception.Create('��ѡ��Ҫɾ���ļ�¼...');
  if not canDelete then Raise Exception.Create('����վ����Ʒ����ɾ��...');
  if MessageBox(Handle,'�Ƿ�ɾ��ѡ�е�������Ʒ��','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
  if not isSelected then Raise Exception.Create('��ѡ��Ҫ����ļ�¼...');
  if FSortId='' then Raise Exception.Create('��ѡ����ĵ�Ŀ����ࡣ');
  if MessageBox(Handle,'�Ƿ��޸�ѡ�е�������Ʒ���ࣿ','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
              Raise Exception.Create('���ܻ�ԭ��Ӧ���е���Ʒ');
         end;
       end;
     end
  else
     raise Exception.Create('������û�ҵ���ǰ��Ӧ��������ͬ��������');
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
     Raise Exception.Create('��������ӷ��Ծ�Ӫ����...');

  AObj := TRecord_.Create;
  try
    if TfrmGoodsSort.ShowDialog(self,'',AObj,SObj) then
       begin
         rzTree.OnChange := nil;
         dllGlobal.CreateGoodsSortTree(rzTree,true);
         rzTree.Items.Add(nil,'����վ');
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
     Raise Exception.Create('���Ծ�Ӫ���಻�����޸�...');

  AObj := TRecord_.Create;
  try
    if TfrmGoodsSort.ShowDialog(self,SObj.FieldbyName('SORT_ID').AsString,AObj) then
       begin
         rzTree.OnChange := nil;
         dllGlobal.CreateGoodsSortTree(rzTree,true);
         rzTree.Items.Add(nil,'����վ');
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
     Raise Exception.Create('���Ծ�Ӫ���಻����ɾ��...');

  if rzTree.Selected.HasChildren then Raise Exception.Create('��ǰ��������¼���������ɾ��...');

  if MessageBox(Handle,Pchar('ȷ��Ҫɾ��"'+SObj.FieldByName('SORT_NAME').AsString+'"������?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1) <> 6 then Exit;

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
  rzTree.Items.Add(nil,'����վ');
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
      Params.ParamByName('TENANT_ID').AsInteger := cdsGoodsExt.FieldByName('TENANT_ID').AsInteger;
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
      tmpObj.WriteToDataSet(tmpGoodsInfo,false);
    finally
      tmpObj.Free;
    end;

    tmpObj := TRecord_.Create;
    try
      if tmpGoodsExt.IsEmpty then tmpGoodsExt.Append else tmpGoodsExt.Edit;
      tmpObj.ReadFromDataSet(cdsGoodsExt);
      tmpObj.WriteToDataSet(tmpGoodsExt,false);
    finally
      tmpObj.Free;
    end;

    if not cdsGodsRelation.IsEmpty then
    begin
      tmpObj := TRecord_.Create;
      try
        if tmpGoodsRelation.IsEmpty then tmpGoodsRelation.Append else tmpGoodsRelation.Edit;
        tmpObj.ReadFromDataSet(cdsGodsRelation);
        tmpObj.WriteToDataSet(tmpGoodsRelation,false);
      finally
        tmpObj.Free;
      end;
    end;

    tmpObj := TRecord_.Create;
    try
      if cdsBarcode.Locate('BARCODE_TYPE', '0', []) then
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '0', []) then
              tmpBarCode.Edit
           else
              tmpBarCode.Append;
           tmpObj.ReadFromDataSet(cdsBarcode);
           tmpObj.WriteToDataSet(tmpBarCode,false);
         end
      else
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '0', []) then
              tmpBarCode.Delete;
         end;

      if cdsBarcode.Locate('BARCODE_TYPE', '1', []) then
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '1', []) then
              tmpBarCode.Edit
           else
              tmpBarCode.Append;
           tmpObj.ReadFromDataSet(cdsBarcode);
           tmpObj.WriteToDataSet(tmpBarCode,false);
         end
      else
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '1', []) then
              tmpBarCode.Delete;
         end;

      if cdsBarcode.Locate('BARCODE_TYPE', '2', []) then
         begin
           if tmpBarCode.Locate('BARCODE_TYPE', '2', []) then
              tmpBarCode.Edit
           else
              tmpBarCode.Append;
           tmpObj.ReadFromDataSet(cdsBarcode);
           tmpObj.WriteToDataSet(tmpBarCode,false);
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
           tmpObj.WriteToDataSet(tmpGoodsPrice,false);
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
  if (cdsList.FieldByName('LOWER_AMOUNT').AsFloat<>0) and (cdsList.FieldbyName('AMOUNT').AsFloat<cdsList.FieldByName('LOWER_AMOUNT').AsFloat) then
     Background := lower.Color;
  if (cdsList.FieldByName('UPPER_AMOUNT').AsFloat<>0) and (cdsList.FieldbyName('AMOUNT').AsFloat>cdsList.FieldByName('UPPER_AMOUNT').AsFloat) then
     Background := upper.Color;
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
  PrintDBGridEh1.PageHeader.CenterText.Text := '��Ʒ��汨��';
  DBGridEh1.DBGridTitle := '��Ʒ��汨��';
  DBGridEh1.DBGridHeader.Text := '';
  DBGridEh1.DBGridFooter.Text := ' '+#13+' ����Ա:'+token.UserName+'  ����ʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+token.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', '']);
end;

procedure TfrmGoodsStorage.ExcelImportClick(Sender: TObject);
var
  rs:TZQuery;
  n1,n2,n3:PSynTableInfo;
begin
  inherited;
  rs := TZQuery.Create(nil);
  if TfrmGoodsExcel.ExcelFactory(self,rs,'','',true) then
     begin
       if dataFactory.iDbType <> 5 then
          begin
            new(n1);
            n1^.tbname := 'PUB_GOODSINFO';
            n1^.keyFields := 'TENANT_ID;GODS_ID';
            n1^.synFlag := 22;
            n1^.keyFlag := 0;
            n1^.tbtitle := '��Ʒ����';
            n1^.isSyncDown := '1';

            new(n2);
            n2^.tbname := 'PUB_BARCODE';
            n2^.keyFields := 'ROWS_ID';
            n2^.synFlag := 3;
            n2^.keyFlag := 0;
            n2^.tbtitle := '�����';
            n2^.isSyncDown := '1';

            new(n3);
            n3^.tbname := 'PUB_GOODSPRICE';
            n3^.keyFields := 'TENANT_ID;GODS_ID;SHOP_ID;PRICE_ID';
            n3^.whereStr := 'TENANT_ID=:TENANT_ID and (SHOP_ID=:SHOP_ID or SHOP_ID='''+token.tenantId+'0001'') and TIME_STAMP>:TIME_STAMP';
            n3^.synFlag := 0;
            n3^.keyFlag := 0;
            n3^.syncShopId := token.shopId;
            n3^.tbtitle := '�����ۼ�';
            n3^.isSyncDown := '1';

            try
              SyncFactory.SyncSingleTable(n1,1,false);
              SyncFactory.SyncSingleTable(n2,1,false);
              SyncFactory.SyncSingleTable(n3,1,false);
            finally
              dispose(n1);
              dispose(n2);
              dispose(n3);
            end;
          end;
       dllGlobal.Refresh('PUB_GOODSINFO');
       RefreshMeaUnits;
     end;
end;

procedure TfrmGoodsStorage.RzLabel37Click(Sender: TObject);
var
  rs:TZQuery;
  SObj:TRecord_;
begin
  inherited;
  SObj := TRecord_.Create;
  try
    SObj.AddField('GODS_ID',AObj.FieldByName('GODS_ID').AsString);
    SObj.AddField('GODS_CODE',AObj.FieldByName('GODS_CODE').AsString);
    SObj.AddField('GODS_NAME',AObj.FieldByName('GODS_NAME').AsString);
    if cdsGoodsInfo.FieldByName('TENANT_ID').AsString = token.tenantId then
       begin
         SObj.AddField('RELATION_ID',0,ftInteger);
         SObj.AddField('RELATION_TYPE',1,ftInteger);
         SObj.AddField('USING_BARTER',cdsGoodsInfo.FieldByName('USING_BARTER').AsInteger,ftInteger);
         SObj.AddField('BARTER_INTEGRAL',cdsGoodsInfo.FieldByName('BARTER_INTEGRAL').AsInteger,ftInteger);
       end
    else
       begin
         SObj.AddField('RELATION_ID',cdsGodsRelation.FieldByName('RELATION_ID').AsInteger,ftInteger);
         SObj.AddField('USING_BARTER',cdsGodsRelation.FieldByName('USING_BARTER').AsInteger,ftInteger);
         SObj.AddField('BARTER_INTEGRAL',cdsGodsRelation.FieldByName('BARTER_INTEGRAL').AsInteger,ftInteger);
         if cdsGodsRelation.FieldByName('TENANT_ID').AsString = token.tenantId then
            begin
              SObj.AddField('RELATION_TYPE',1,ftInteger);
            end
         else
            begin
              SObj.AddField('RELATION_TYPE',2,ftInteger);
            end;
       end;
    if TfrmMemberPrice.ShowDialog(self,SObj) then
       begin
        rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
        if (SObj.FieldByName('RELATION_ID').AsInteger=0) or (SObj.FieldByName('RELATION_TYPE').AsInteger=1) then
           begin
             if rs.Locate('GODS_ID',AObj.FieldByName('GODS_ID').AsString,[]) then
                begin
                  rs.Edit;
                  rs.FieldByName('USING_BARTER').AsInteger := SObj.FieldByName('USING_BARTER').AsInteger;
                  rs.FieldByName('BARTER_INTEGRAL').AsInteger := SObj.FieldByName('BARTER_INTEGRAL').AsInteger;
                  rs.Post;
                end;
             if SObj.FieldByName('RELATION_ID').AsInteger=0 then
                begin
                  AObj.FieldByName('USING_BARTER').AsInteger := SObj.FieldByName('USING_BARTER').AsInteger;
                  AObj.FieldByName('BARTER_INTEGRAL').AsInteger := SObj.FieldByName('BARTER_INTEGRAL').AsInteger;
                  cdsGoodsInfo.Edit;
                  cdsGoodsInfo.FieldByName('USING_BARTER').AsInteger := SObj.FieldByName('USING_BARTER').AsInteger;
                  cdsGoodsInfo.FieldByName('BARTER_INTEGRAL').AsInteger := SObj.FieldByName('BARTER_INTEGRAL').AsInteger;
                  cdsGoodsInfo.Post;
                end
             else if SObj.FieldByName('RELATION_TYPE').AsInteger=1 then
                begin
                  cdsGodsRelation.Edit;
                  cdsGodsRelation.FieldByName('USING_BARTER').AsInteger := SObj.FieldByName('USING_BARTER').AsInteger;
                  cdsGodsRelation.FieldByName('BARTER_INTEGRAL').AsInteger := SObj.FieldByName('BARTER_INTEGRAL').AsInteger;
                  cdsGodsRelation.Post;
                end;
           end;
       end;
  finally
    SObj.Free;
  end;
end;

procedure TfrmGoodsStorage.VIPPriceImportClick(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  rs:=TZQuery.Create(nil);
  try
    if TfrmPriceExcel.ExcelFactory(self,rs,'','',true) then
       begin
         dllGlobal.Refresh('PUB_GOODSINFO');
         Open;
       end;
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
    cdsOrder.FieldByName('REMARK').AsString := '����̵�';
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
         Raise Exception.Create('��Ӫ��Ʒ���Ҳ�����'+rs.FieldByName('GODS_ID').AsString+'��');

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
var
  rs:TZQuery;
  SObj:TRecord_;
  SortId:string;
begin
  inherited;
  SObj := TRecord_.Create;
  try
    if not TfrmClearStorage.ShowDialog(self, SObj) then Exit;
    SortId := trim(SObj.FieldByName('SORT_ID').AsString);
  finally
    SObj.Free;
  end;
  rs := TZQuery.Create(nil);
  try
    if SortId = '' then
       begin
         rs.SQL.Text := 'select GODS_ID,AMOUNT,BATCH_NO,PROPERTY_01,PROPERTY_02 from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and AMOUNT<>0';
       end
    else if SortId = '1000006' then
       begin
         rs.SQL.Text := 'select a.GODS_ID,a.AMOUNT,a.BATCH_NO,a.PROPERTY_01,a.PROPERTY_02 '+
                        'from   STO_STORAGE a,('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,RELATION_ID')+') b '+
                        'where  a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.AMOUNT<>0'+
                        '       and a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006';
       end
    else if SortId = '0000000' then
       begin
         rs.SQL.Text := 'select a.GODS_ID,a.AMOUNT,a.BATCH_NO,a.PROPERTY_01,a.PROPERTY_02 '+
                        'from   STO_STORAGE a,('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,RELATION_ID')+') b '+
                        'where  a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.AMOUNT<>0'+
                        '       and a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID<>1000006';
       end
    else
       begin
         rs.SQL.Text := 'select a.GODS_ID,a.AMOUNT,a.BATCH_NO,a.PROPERTY_01,a.PROPERTY_02 '+
                        'from   STO_STORAGE a,('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,SORT_ID1')+') b '+
                        'where  a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.AMOUNT<>0'+
                        '       and a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.SORT_ID1='''+SortId+'''';
       end;
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    dataFactory.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('��ǰ��Ʒ���ȫ��Ϊ�㣬����Ҫ����...');
    SaveChangeOrder(rs);
    Open;
    MessageBox(handle,'�������ɹ�...','������ʾ..',MB_OK+MB_ICONINFORMATION);
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
var
  rs:TZQuery;
begin
  inherited;
  rs:=TZQuery.Create(nil);
  try
    if TfrmStorageExcel.ExcelFactory(self,rs,'','',true) then
       SaveChangeOrder(rs);
  finally
    rs.Free;
  end;
end;

procedure TfrmGoodsStorage.RzBmpButton8Click(Sender: TObject);
var
  x,x1:TPoint;
begin
  inherited;
  x1.X := RzBmpButton8.Left+2;
  x1.Y := RzBmpButton8.Top+RzBmpButton8.Height+1;
  x := RzPanel13.ClientToScreen(x1);
  PopupMenu1.Popup(x.X,x.Y);
end;

procedure TfrmGoodsStorage.RefreshMeaUnits;
var rs:TZQuery;
    column:TColumnEh;
begin
  dllGlobal.Refresh('PUB_MEAUNITS');
  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  column := FindColumn('CALC_UNITS');
  column.KeyList.Clear;
  column.PickList.Clear;
  rs.First;
  while not rs.Eof do
    begin
      column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
end;

procedure TfrmGoodsStorage.edtCALC_UNITSPropertiesChange(Sender: TObject);
begin
  inherited;
  h_label.Caption:='�����ۼ�('+edtCALC_UNITS.Text+')';
end;

procedure TfrmGoodsStorage.edtSMALL_UNITSPropertiesChange(Sender: TObject);
begin
  inherited;
  if (edtSMALL_UNITS.Text<>'') and (edtSMALL_UNITS.Focused) and
     (StrtoFloatDef(edtSMALLTO_CALC.Text,0)<>0) and
     (StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)<>0) then
    begin
      edtSHOP_NEW_OUTPRICE1.Properties.ReadOnly:=false;
      edtSHOP_NEW_OUTPRICE1.Text:=FloattoStr(StrtoFloatDef(edtSMALLTO_CALC.Text,0)*StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0));
    end;
  t_label.Caption:=edtSMALL_UNITS.Text+'��';
  SetShopOutPricePlace;
end;

procedure TfrmGoodsStorage.edtBIG_UNITSPropertiesChange(Sender: TObject);
begin
  inherited;
  if (edtBIG_UNITS.Text<>'') and (edtBIG_UNITS.Focused) and
     (StrtoFloatDef(edtBIGTO_CALC.Text,0)<>0) and
     (StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)<>0)then
    begin
       edtSHOP_NEW_OUTPRICE2.Properties.ReadOnly:=false;
       edtSHOP_NEW_OUTPRICE2.Text:=FloattoStr(StrtoFloat(edtBIGTO_CALC.Text)*StrtoFloat(edtSHOP_NEW_OUTPRICE.Text));
    end;
  x_label.Caption:=edtBIG_UNITS.Text+'��';
  SetShopOutPricePlace;
end;

procedure TfrmGoodsStorage.edtSMALLTO_CALCPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if  (edtSMALLTO_CALC.Focused) and (StrtoFloatDef(edtSMALLTO_CALC.Text,0)<>0) and
      (edtSMALL_UNITS.Text<>'') and
      (StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)<>0) then
    begin
      edtSHOP_NEW_OUTPRICE1.Properties.ReadOnly:=false;
      edtSHOP_NEW_OUTPRICE1.Text:=FloattoStr(StrtoFloat(edtSMALLTO_CALC.Text)*StrtoFloat(edtSHOP_NEW_OUTPRICE.Text));
    end
  else
    begin
      edtSHOP_NEW_OUTPRICE1.Properties.ReadOnly:=true;
      edtSHOP_NEW_OUTPRICE1.Text:='';
    end;
  SetShopOutPricePlace;
end;

procedure TfrmGoodsStorage.edtBIGTO_CALCPropertiesChange(Sender: TObject);
begin
  inherited;
  if  (edtBIGTO_CALC.Focused) and (StrtoFloatDef(edtBIGTO_CALC.Text,0)<>0) and
      (edtBIG_UNITS.Text<>'') and
      (StrtoFloatDef(edtSHOP_NEW_OUTPRICE.Text,0)<>0) then
    begin
      edtSHOP_NEW_OUTPRICE2.Properties.ReadOnly:=false;
      edtSHOP_NEW_OUTPRICE2.Text:=FloattoStr(StrtoFloat(edtBIGTO_CALC.Text)*StrtoFloat(edtSHOP_NEW_OUTPRICE.Text));
    end
  else
    begin
      edtSHOP_NEW_OUTPRICE2.Properties.ReadOnly:=true;
      edtSHOP_NEW_OUTPRICE2.Text:='';
    end;
  SetShopOutPricePlace;
end;

procedure TfrmGoodsStorage.SetShopOutPricePlace;
begin
  if (edtSHOP_NEW_OUTPRICE1.Text<>'') and (edtSHOP_NEW_OUTPRICE2.Text='') then
    begin
      edtBK_SHOP_NEW_OUTPRICE1.Visible:=true;
      edtBK_SHOP_NEW_OUTPRICE2.Visible:=false;
      edtBK_SHOP_OUTPRICE.Width:=332;
      RzPanel9.Left:=625;
    end
  else if (edtSHOP_NEW_OUTPRICE1.Text='') and (edtSHOP_NEW_OUTPRICE2.Text<>'') then
    begin
      edtBK_SHOP_NEW_OUTPRICE1.Visible:=false;
      edtBK_SHOP_NEW_OUTPRICE2.Visible:=true;
      edtBK_SHOP_OUTPRICE.Width:=332;
      RzPanel9.Left:=625;
    end
  else if (edtSHOP_NEW_OUTPRICE1.Text<>'') and (edtSHOP_NEW_OUTPRICE2.Text<>'') then
    begin
      edtBK_SHOP_NEW_OUTPRICE1.Visible:=true;
      edtBK_SHOP_NEW_OUTPRICE2.Visible:=true;
      edtBK_SHOP_OUTPRICE.Width:=466;
      RzPanel9.Left:=746;
    end
  else
    begin
      edtBK_SHOP_NEW_OUTPRICE1.Visible:=false;
      edtBK_SHOP_NEW_OUTPRICE2.Visible:=false;
      edtBK_SHOP_OUTPRICE.Width:=218;
      RzPanel9.Left:=520;
    end;
end;

procedure TfrmGoodsStorage.N6Click(Sender: TObject);
begin
  inherited;
  AddUnits(Sender);
end;

procedure TfrmGoodsStorage.AddUnits(Sender: TObject);
var AObj:TRecord_;
begin 
  AObj := TRecord_.Create;
  try
    if TfrmMeaUnits.ShowDialog(self,'',AObj) then
       begin
         dllGlobal.Refresh('PUB_MEAUNITS');
         if Sender is TzrComboBoxList then
         begin
           TzrComboBoxList(Sender).KeyValue := AObj.FieldByName('UNIT_ID').AsString;
           TzrComboBoxList(Sender).Text := AObj.FieldByName('UNIT_NAME').AsString;
         end;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmGoodsStorage.edtCALC_UNITSAddClick(Sender: TObject);
begin
  inherited;
  AddUnits(Sender);
end;

function TfrmGoodsStorage.GetAidAmt(DataSet: TZQuery): real;
var
  CalcAmt,SmalltoCalc,BigtoCalc: real;
  UnitId,CalcUnit,SmallUnit,BigUnit: string;
begin
  if DataSet.IsEmpty then Exit;
  if DataSet.FieldByName('AMOUNT').AsString = '' then Exit;
  UnitId := DataSet.FieldByName('UNIT_ID').AsString;
  CalcUnit := DataSet.FieldByName('CALC_UNITS').AsString;
  SmallUnit := DataSet.FieldByName('SMALL_UNITS').AsString;
  BigUnit := DataSet.FieldByName('BIG_UNITS').AsString;
  CalcAmt := DataSet.FieldByName('AMOUNT').AsFloat;
  SmalltoCalc := DataSet.FieldByName('SMALLTO_CALC').AsFloat;
  BigtoCalc := DataSet.FieldByName('BIGTO_CALC').AsFloat;
  if UnitId = CalcUnit then
     result := StrToFloat(FormatFloat('#0.###',CalcAmt))
  else if UnitId = SmallUnit then
     result := StrToFloat(FormatFloat('#0.###',CalcAmt/SmalltoCalc))
  else if UnitId = BigUnit then
     result := StrToFloat(FormatFloat('#0.###',CalcAmt/BigtoCalc))
  else
     result := StrToFloat(FormatFloat('#0.###',CalcAmt));
end;

function TfrmGoodsStorage.GetAidName(DataSet: TZQuery): string;
var
  rs:TZQuery;
  UnitId:string;
begin
  if DataSet.IsEmpty then Exit;
  if DataSet.FieldByName('GODS_ID').AsString = '' then Exit;
  UnitId := DataSet.FieldByName('UNIT_ID').AsString;
  if UnitId = '' then
     UnitId := DataSet.FieldByName('CALC_UNITS').AsString;
  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  if rs.Locate('UNIT_ID',UnitId,[]) then
     result := rs.FieldByName('UNIT_NAME').AsString;
end;

procedure TfrmGoodsStorage.edtDefault1PropertiesChange(Sender: TObject);
begin
  inherited;
  if edtDefault1.Checked then edtDefault2.Checked := false;
end;

procedure TfrmGoodsStorage.edtDefault2PropertiesChange(Sender: TObject);
begin
  inherited;
  if edtDefault2.Checked then edtDefault1.Checked := false;
end;

initialization
  RegisterClass(TfrmGoodsStorage);
finalization
  UnRegisterClass(TfrmGoodsStorage);
end.
