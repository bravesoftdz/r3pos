unit ufrmGoodsStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzButton,
  cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, ComCtrls, RzTreeVw, Grids, DBGridEh, cxButtonEdit, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase,ObjCommon;

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
    RzBitBtn3: TRzBitBtn;
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
    RzToolButton3: TRzToolButton;
    RzSpacer1: TRzSpacer;
    serachText: TEdit;
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnNavClick(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
  private
    { Private declarations }
    ESortId:string;
    FSortId:string;
    function FindColumn(fieldname:string):TColumnEh;
    function GetOpenWhere:string;
  public
    { Public declarations }
    procedure Open;
    procedure showForm;override;
  end;

implementation
uses ufrmSortDropFrom,udllGlobal,udataFactory,udllShopUtil,utokenFactory;
{$R *.dfm}

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
      ESortId := Obj.FieldbyName('SORT_ID').AsString;
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
  dllGlobal.CreateGoodsSortTree(rzTree,true);
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
   'select jp.*,isnull(shp.NEW_OUTPRICE,jp.NEW_OUTPRICE_P) as NEW_OUTPRICE from ('+
   'select j.TENANT_ID,'''+token.shopId+''' as SHOP_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.SORT_ID1,j.CALC_UNITS,c.AMOUNT,'+
   'isnull(ext.NEW_INPRICE,j.NEW_INPRICE) as NEW_INPRICE,'+
   'isnull(prc.NEW_OUTPRICE,j.NEW_OUTPRICE) as NEW_OUTPRICE_P '+
   'from ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,SHOP_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS,NEW_INPRICE,NEW_OUTPRICE')+') j '+
   'left outer join (select TENANT_ID,GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+''') c on j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID '+
   'left outer join  PUB_GOODSINFOEXT ext on j.TENANT_ID=ext.TENANT_ID and j.GODS_ID=ext.GODS_ID '+
   'left outer join  PUB_GOODSPRICE prc on j.TENANT_ID=prc.TENANT_ID and j.GODS_ID=prc.GODS_ID and j.SHOP_ID=prc.SHOP_ID ) jp '+
   'left outer join  PUB_GOODSPRICE shp on jp.TENANT_ID=shp.TENANT_ID and jp.GODS_ID=shp.GODS_ID and jp.SHOP_ID=shp.SHOP_ID '+GetOpenWhere
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
begin
  if Assigned(rzTree.Selected) and (rzTree.Selected.Level>0) then
     begin
       if rzTree.Selected.Level=1 then
          begin
            result := 'jp.RELATION_ID='''+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString+'''';
          end
       else
          begin
            result := 'jp.RELATION_ID='''+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString+''' and jp.SORT_ID1 in ('+getSortId(rzTree.Selected)+')';
          end;
     end;
  if trim(serachText.Text) <> '' then
     begin
       if result <> '' then result := result +' and ';
       result := result + '(jp.GODS_NAME like ''%'+trim(serachText.Text)+'%'' or jp.GODS_CODE like ''%'+trim(serachText.Text)+'%'' or jp.BARCODE like ''%'+trim(serachText.Text)+'%'')';
     end;
  if result<>'' then result := ' where '+result;
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

initialization
  RegisterClass(TfrmGoodsStorage);
finalization
  UnRegisterClass(TfrmGoodsStorage);
end.
