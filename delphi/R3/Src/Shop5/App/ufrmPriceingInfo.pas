unit ufrmPriceingInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmPriceingInfo = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnClose: TRzBitBtn;
    cdsList: TZQuery;
    dsList: TDataSource;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    procedure InitGrid;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
  public
    { Public declarations }
    class function ShowDialog(Owner:TForm;GodsId,ShopId:String):Boolean;
    procedure Open(GODS_ID,SHOP_ID:String);
    function EncodeSql:String;
  end;


implementation
uses uGlobal,uCtrlUtil, ufrmBasic, uDsUtil, uShopGlobal;
{$R *.dfm}

{ TfrmPriceingInfo }

function TfrmPriceingInfo.EncodeSql: String;
begin
  Result :=
  ' select A.PRICING_DATE,C.USER_NAME as PRICING_USER_TEXT,B.GODS_CODE,B.GODS_NAME as GODS_ID_TEXT,B.UNIT_ID,A.PRICE_METHOD,A.ORG_OUTPRICE,A.NEW_OUTPRICE '+
  ' from LOG_PRICING_INFO A left join VIW_GOODSINFO B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
  ' left join VIW_USERS C on A.TENANT_ID=C.TENANT_ID and A.PRICING_USER=C.USER_ID where A.TENANT_ID=:TENANT_ID and A.SHOP_ID=:SHOP_ID and A.GODS_ID=:GODS_ID ';
end;

procedure TfrmPriceingInfo.Open(GODS_ID,SHOP_ID: String);
begin
  cdsList.close;
  cdsList.DisableControls;
  try
    cdsList.SQL.Text := EncodeSQL;
    cdsList.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsList.Params.ParamByName('SHOP_ID').AsString := SHOP_ID;
    cdsList.Params.ParamByName('GODS_ID').AsString := GODS_ID;

    Factor.Open(cdsList);
  finally
    cdsList.EnableControls;
  end;
end;

procedure TfrmPriceingInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmPriceingInfo.ShowDialog(Owner: TForm; GodsId,
  ShopId: String): Boolean;
begin
  with TfrmPriceingInfo.Create(Owner) do
  begin
    try
      Open(GodsId,ShopId);
      ShowModal;
    finally
      Free;
    end;
  end;
end;

function TfrmPriceingInfo.FindColumn(DBGrid: TDBGridEh;
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

procedure TfrmPriceingInfo.InitGrid;
var rs:TZQuery;
    Column:TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(DBGridEh1,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
end;

procedure TfrmPriceingInfo.FormShow(Sender: TObject);
begin
  inherited;
  InitGrid;
end;

procedure TfrmPriceingInfo.DBGridEh1DrawColumnCell(Sender: TObject;
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
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

end.
