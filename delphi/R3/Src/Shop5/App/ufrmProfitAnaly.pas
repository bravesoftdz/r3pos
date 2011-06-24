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
    procedure ShowOrderData; //ˢ����ʾ������
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
     RelName:='������Ӫ'
  else
  begin
    if Rs.Locate('RELATION_ID',Realition_ID,[]) then
      RelName:=trim(Rs.fieldbyName('RELATION_NAME').AsString);
  end;
  case FAnalyType of
   1: FTtileName:=RelName+'��Ʒ�����۶����';
   2: FTtileName:=RelName+'��Ʒ��ë��������';
   3: FTtileName:=RelName+'��Ʒ������������';
  end;
  PnlTop.Caption:=FTtileName;
end;

procedure TfrmProfitAnaly.edtOrderNoPropertiesChange(Sender: TObject);
begin
  //��ʼ�������»�
  ShowOrderData;
end;

procedure TfrmProfitAnaly.InitData(const AnalyType,Relation_ID: integer; const vData: OleVariant);
var
  SetCol: TColumnEh;
begin
  //��������
  FAnalyType:=AnalyType;
  SetCol:=FindColumn(DBGridEh1, 'ANALYSUM');
  case AnalyType of
   1: SetCol.Title.Caption:='���۶�';
   2: SetCol.Title.Caption:='ë��';
   3: SetCol.Title.Caption:='����';
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
  adoAnaly.FieldDefs.Add('GODS_CODE',ftstring,20,true);  //��Ʒ����
  adoAnaly.FieldDefs.Add('GODS_NAME',ftstring,50,true);  //��Ʒ����
  adoAnaly.FieldDefs.Add('ANALYSUM',ftFloat,0,true);     //��������
  adoAnaly.FieldDefs.Add('ORDERNO',ftInteger,0,true);    //�����
  adoAnaly.CreateDataSet;
  //ˢ����ʾ
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
    //�����ʾ
    if i< adoReport.RecordCount then
    begin
      adoReport.RecNo:=i;
      adoAnaly.Append;
      adoAnaly.fieldbyName('GODS_CODE').AsString:=adoReport.fieldByName('GODS_CODE').AsString;
      adoAnaly.fieldbyName('GODS_NAME').AsString:=adoReport.fieldByName('GODS_NAME').AsString;
      adoAnaly.fieldbyName('ANALYSUM').AsFloat:=adoReport.fieldByName('ANALYSUM').AsFloat;
      adoAnaly.fieldbyName('ORDERNO').AsInteger:=i;
      adoAnaly.Post;
      //ͼ����ʾ
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
    Column.Grid.Canvas.Brush.Color := clAqua;   //ѡ����ɫ״̬
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
