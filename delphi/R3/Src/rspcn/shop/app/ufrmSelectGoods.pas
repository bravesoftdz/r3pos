unit ufrmSelectGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, RzButton, cxTextEdit, Grids, DBGridEh, cxControls, cxContainer,
  cxEdit, cxMaskEdit, cxDropDownEdit, ComCtrls, RzTreeVw, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, udataFactory, ObjCommon, ZLogFile;

type
  TfrmSelectGoods = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    RzPanel2: TRzPanel;
    Splitter1: TSplitter;
    RzPanel3: TRzPanel;
    rzTree: TRzTreeView;
    RzPanel5: TRzPanel;
    DBGridEh1: TDBGridEh;
    fndPanel: TPanel;
    RzPanel6: TRzPanel;
    cdsList: TZQuery;
    DataSource1: TDataSource;
    RzPanel4: TRzPanel;
    btnOk: TRzBmpButton;
    btnCancel: TRzBmpButton;
    search: TRzPanel;
    barcode_input_left: TImage;
    barcode_input_right: TImage;
    search_input_line: TImage;
    btnSearch: TRzBmpButton;
    edtSearch: TEdit;
    procedure FormShow(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchEnter(Sender: TObject);
    procedure edtSearchExit(Sender: TObject);
    procedure edtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    searchTxt:string;
    procedure Open;
    procedure InitGrid;
    procedure LoadTree;
    function  GetOpenWhere:string;
    function  FindDBColumn(Grid:TDBGridEh;FieldName:string):TColumnEh;
  public

  end;

implementation

uses udllGlobal,udllDsUtil,uTokenFactory;

{$R *.dfm}

function TfrmSelectGoods.FindDBColumn(Grid: TDBGridEh; FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:= Grid.Columns.Count -1 downto 0 do
    begin
      if LowerCase(Grid.Columns[i].FieldName)=LowerCase(FieldName) then
         begin
           result := Grid.Columns[I];
           Exit;
         end;
    end;
end;

procedure TfrmSelectGoods.InitGrid;
var
  rs: TZQuery;
  SetCol:TColumnEh;
begin
  inherited;
  SetCol:=FindDBColumn(DBGridEh1,'UNIT_ID');
  if SetCol<>nil then
  begin
    rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.add(rs.Fieldbyname('UNIT_ID').asstring);
      SetCol.PickList.add(rs.Fieldbyname('UNIT_NAME').asstring);
      rs.Next;
    end;
  end;
end;

procedure TfrmSelectGoods.LoadTree;
begin
  rzTree.OnChange := nil;
  dllGlobal.CreateGoodsSortTree(rzTree,true);
  rzTree.OnChange := rzTreeChange;
end;

procedure TfrmSelectGoods.FormShow(Sender: TObject);
begin
  inherited;
  InitGrid;
  LoadTree;
  Open;
  if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
end;

procedure TfrmSelectGoods.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if rzTree.CanFocus then Open;
end;

procedure TfrmSelectGoods.Open;
begin
  cdsList.Close;
  cdsList.SQL.Text :=
    ParseSQL(dataFactory.iDbType,
   'select 0 as A,jp.*,isnull(shp.NEW_OUTPRICE,jp.NEW_OUTPRICE_P) as NEW_OUTPRICE from ('+
   'select j.TENANT_ID,'''+token.shopId+''' as CUR_SHOP_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.SORT_ID1,j.RELATION_ID,j.CALC_UNITS UNIT_ID,j.PRICE_ID,j.COMM,c.AMOUNT,'+
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

function TfrmSelectGoods.GetOpenWhere: string;
  function getSortId(node:TTreeNode):string;
  var child:TTreeNode;
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
begin
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

  if result<>'' then result := ' where '+result else result := '';
end;

procedure TfrmSelectGoods.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key<>VK_RETURN) and (Key<>VK_ESCAPE) and (Key<>VK_TAB) and (Key<>VK_SPACE) and (KEY<>VK_DOWN) and (KEY<>VK_UP) and (KEY<>VK_LEFT) and (KEY<>VK_RIGHT) and (Key<>0) AND (KEY<>VK_CONTROL) then
     edtSearch.SetFocus;
  inherited;
  if Key = VK_F5 then Open;
end;

procedure TfrmSelectGoods.edtSearchChange(Sender: TObject);
begin
  inherited;
  if edtSearch.Focused then searchTxt := edtSearch.Text;
end;

procedure TfrmSelectGoods.edtSearchEnter(Sender: TObject);
begin
  inherited;
  edtSearch.Text := searchTxt;
  edtSearch.SelectAll;
end;

procedure TfrmSelectGoods.edtSearchExit(Sender: TObject);
begin
  inherited;
  if searchTxt='' then edtSearch.Text := edtSearch.Hint;
end;

procedure TfrmSelectGoods.edtSearchKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     Open;
end;

procedure TfrmSelectGoods.btnOkClick(Sender: TObject);
begin
  inherited;
  if cdsList.State in [dsEdit,dsInsert] then cdsList.Post;
  cdsList.DisableControls;
  try
    if cdsList.IsEmpty or (cdsList.FieldByName('GODS_ID').AsString = '')then
       begin
         Raise Exception.Create('请选择货品,在选择栏打勾');
       end;
    cdsList.Filtered := false;
    cdsList.Filter := 'GODS_ID='''+cdsList.FieldByName('GODS_ID').AsString+'''';
    cdsList.Filtered := true;
  except
    cdsList.Filtered := false;
    cdsList.EnableControls;
    Raise;
  end;
  ModalResult := MROK;
end;

procedure TfrmSelectGoods.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSelectGoods.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if not cdsList.IsEmpty then
     btnOkClick(nil)
  else
     edtSearch.SetFocus;
end;

procedure TfrmSelectGoods.btnSearchClick(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TfrmSelectGoods.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  br:TBrush;
  pn:TPen;
begin
  pn := TPen.Create;
  br := TBrush.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  br.Assign(DBGridEh1.Canvas.Brush);
  try
    if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and
       (not (gdFocused in State) or not DBGridEh1.Focused or (Column.FieldName = 'TOOL_NAV')) then
    begin
      DBGridEh1.Canvas.Brush.Color := clWhite;
    end;
    DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    pn.Free;
    br.Free;
  end;
end;

procedure TfrmSelectGoods.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=13 then
     begin
       if cdsList.IsEmpty then Exit;
       Key := 0;
       btnOkClick(nil);
     end;
  if Key=VK_SPACE then
     begin
       DBGridEh1DblClick(nil);
     end;
end;

end.
