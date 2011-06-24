unit ufrmProfitAnaly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeAnalyBase, ExtCtrls, TeEngine, Series, TeeProcs, Chart,
  Grids, DBGridEh, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, StdCtrls,ZAbstractRODataset, ZAbstractDataset, ZDataset,
  DB;

type
  TfrmProfitAnaly = class(TframeAnalyBase)
    Pnl_Left: TPanel;
    Pnl_Right: TPanel;
    PnlTop: TPanel;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    Chart1: TChart;
    BarSeries1: TBarSeries;
    BarSeries2: TBarSeries;
    edtOrderNo: TcxComboBox;
    Label1: TLabel;
    Label2: TLabel;
    adoAnaly: TZQuery;
    dsAnaly: TDataSource;
    adoReport: TZQuery;
    Splitter1: TSplitter;
    procedure edtOrderNoPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FrameResize(Sender: TObject);
  private
    FTtileName: string;
    FAnalyType: integer;
    procedure SetRealition_ID(const Realition_ID: integer);
  public
    procedure ShowOrderData; //刷新显示多少条
    procedure InitData(const AnalyType,Relation_ID: integer; const vData: OleVariant);
  end;

implementation

{$R *.dfm}

uses
  uShopGlobal;

{ TfrmProfitAnaly }

procedure TfrmProfitAnaly.SetRealition_ID(const Realition_ID: integer);
var
  RelName: string;
  Rs: TZQuery;
begin
  Rs:=ShopGlobal.GetZQueryFromName('CA_RELATIONS');
  RelName:='';
  if Realition_ID=0 then
     RelName:='自主经营'
  else
  begin
    if Rs.Locate('RELATION_ID',Realition_ID,[]) then
      RelName:=trim(Rs.fieldbyName('RELATION_NAME').AsString);
  end;
  case FAnalyType of
   1: FTtileName:=RelName+'商品（销售额）排名';
   2: FTtileName:=RelName+'商品（毛利）排名';
   3: FTtileName:=RelName+'商品（销量）排名';
  end;
  PnlTop.Caption:=FTtileName;
end;

procedure TfrmProfitAnaly.edtOrderNoPropertiesChange(Sender: TObject);
begin
  //开始处理重新画
  ShowOrderData;
end;

procedure TfrmProfitAnaly.InitData(const AnalyType,Relation_ID: integer; const vData: OleVariant);
var
  SetCol: TColumnEh;
begin
  //分析类型
  FAnalyType:=AnalyType;
  SetCol:=FindColumn(DBGridEh1, 'ANALYSUM');
  case AnalyType of
   1: SetCol.Title.Caption:='销售额';
   2: SetCol.Title.Caption:='毛利';
   3: SetCol.Title.Caption:='销量';
  end;      
  SetRealition_ID(Relation_ID); 
  adoReport.Close;
  adoReport.Data:=vData;
  if adoReport.Active then
  begin
    adoReport.Filtered:=false;
    adoReport.Filter:='Relation_ID='+InttoStr(Relation_ID);
    adoReport.Filtered:=true;
   //adoReport.SortedFields:='ANALYSUM';
   //adoReport.SortType:=stDescending;
  end;
  adoAnaly.Close;
  adoAnaly.FieldDefs.Add('GODS_CODE',ftstring,20,true);  //商品编码
  adoAnaly.FieldDefs.Add('GODS_NAME',ftstring,50,true);  //商品名称
  adoAnaly.FieldDefs.Add('ANALYSUM',ftFloat,0,true);     //汇总数量
  adoAnaly.FieldDefs.Add('ORDERNO',ftInteger,0,true);    //排序号
  adoAnaly.CreateDataSet;
  //刷新显示
  ShowOrderData;
end;

procedure TfrmProfitAnaly.ShowOrderData;
var
  i,j,vmax: integer;
begin
  if not adoAnaly.IsEmpty then
    adoAnaly.EmptyDataSet;
  if Chart1.Series[0].Count>0 then
    Chart1.Series[0].Clear;
  vmax:=StrtoIntDef(edtOrderNo.Text,5);
  for i:=1 to vmax do
  begin
    //表格显示
    if i< adoReport.RecordCount then
    begin
      adoReport.RecNo:=i;
      adoAnaly.Append;
      adoAnaly.fieldbyName('GODS_CODE').AsString:=adoReport.fieldByName('GODS_CODE').AsString;
      adoAnaly.fieldbyName('GODS_NAME').AsString:=adoReport.fieldByName('GODS_NAME').AsString;
      adoAnaly.fieldbyName('ANALYSUM').AsFloat:=adoReport.fieldByName('ANALYSUM').AsFloat;
      adoAnaly.fieldbyName('ORDERNO').AsInteger:=i;
      adoAnaly.Post;
      //图表显示
      Chart1.Series[0].Add(adoReport.fieldByName('ANALYSUM').AsFloat,trim(adoReport.fieldByName('GODS_NAME').AsString));
    end;
  end;
  Chart1.Title.Text.Clear;
  Chart1.Title.Text.Add(FTtileName);
end;

procedure TfrmProfitAnaly.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect:TRect;
begin
  if TDBGridEh(Sender).DataSource.DataSet=nil then Exit;
  if not TDBGridEh(Sender).DataSource.DataSet.Active then Exit;

  if (Rect.Top = Column.Grid.CellRect(Column.Grid.Col, Column.Grid.Row).Top) and
     (not (gdFocused in State) or not Column.Grid.Focused) then
  begin
    Column.Grid.Canvas.Brush.Color := clAqua;   //选中颜色状态
  end;
  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    DrawText(Column.Grid.Canvas.Handle,pchar(Inttostr(Column.Grid.DataSource.DataSet.RecNo)),length(Inttostr(Column.Grid.DataSource.DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmProfitAnaly.FrameResize(Sender: TObject);
begin
  inherited;
  Pnl_Left.Width:=(self.Width-6) div 2;
end;

end.
