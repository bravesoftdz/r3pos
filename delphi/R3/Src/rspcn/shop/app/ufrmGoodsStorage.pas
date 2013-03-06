unit ufrmGoodsStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzButton,
  cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, ComCtrls, RzTreeVw, Grids, DBGridEh, cxButtonEdit, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase;

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
    DBGridEh2: TDBGridEh;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzToolButton3: TRzToolButton;
    RzSpacer1: TRzSpacer;
    serachText: TEdit;
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    ESortId:string;
    FSortId:string;
    function FindColumn(fieldname:string):TColumnEh;
  public
    { Public declarations }
    procedure Open;
    procedure showForm;override;
  end;

implementation
uses ufrmSortDropFrom,udllGlobal,udataFactory,udllShopUtil;
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

procedure TfrmGoodsStorage.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh2.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh2.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+11,ARect.Top+11,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
       end
    else
       DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.Brush.Color := DBGridEh2.FixedColor;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh2.Canvas.Brush.Assign(br);
    DBGridEh2.Canvas.Pen.Assign(pn);
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
  rs.First;
  while not rs.Eof do
    begin
      rs.Next;
    end;
end;

procedure TfrmGoodsStorage.Open;
begin
  cdsList.Close;
  cdsList.SQL.Text :=
   'select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.SORT_ID1,j.CALC_UNITS,c.AMOUNT,'+
   'isnull(ext.NEW_INPRICE,j.NEW_INPRICE) as NEW_INPRICE,'+
   'isnull(prc.NEW_OUTPRICE,j.NEW_OUTPRICE) as NEW_OUTPRICE '+
   'from ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,SHOP_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS,NEW_INPRICE,NEW_OUTPRICE')+') j '+
   'left outer join STO_STORAGE c on j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID '+
   'left outer join  PUB_GOODSINFOEXT ext on j.TENANT_ID=ext.TENANT_ID and j.GODS_ID=ext.GODS_ID '+
   'left outer join  PUB_GOODSPRICE prc on j.TENANT_ID=prc.TENANT_ID and j.GODS_ID=prc.GODS_ID and j.SHOP_ID=prc.SHOP_ID '
  ;
  dataFactory.Open(cdsList);
end;

function TfrmGoodsStorage.FindColumn(fieldname: string): TColumnEh;
begin

end;

initialization
  RegisterClass(TfrmGoodsStorage);
finalization
  UnRegisterClass(TfrmGoodsStorage);
end.
