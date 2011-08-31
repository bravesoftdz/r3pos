unit ufrmProfitAnaly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, TeEngine, Series, TeeProcs, Chart, Grids, DBGridEh,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  StdCtrls,ZAbstractRODataset, ZAbstractDataset, ZDataset,DB, RzPanel;

type
  TfrmProfitAnaly = class(TFrame)
    adoAnaly: TZQuery;
    dsAnaly: TDataSource;
    adoReport: TZQuery;
    MainPnl: TPanel;
    Panel7: TPanel;
    Pnl_Left: TPanel;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    PnlTop: TPanel;
    RightPnl: TPanel;
    Label2: TLabel;
    edtOrderNo: TcxComboBox;
    vType: TcxComboBox;
    Splitter1: TSplitter;
    Pnl_Right: TPanel;
    Panel3: TPanel;
    ChartTitle: TPanel;
    Panel4: TPanel;
    CB_Color: TCheckBox;
    ButtomPnl: TPanel;
    Panel5: TPanel;
    RihtPnl: TPanel;
    RzPanel15: TRzPanel;
    Chart1: TChart;
    BarSeries1: TBarSeries;
    procedure edtOrderNoPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FrameResize(Sender: TObject);
    procedure CB_ColorClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    FSumValue: Real; //�ۼ�ֵ
    FTtileName: string;
    FAnalyType: integer;
    function FindColumn(DBGrid:TDBGridEh; FieldName:string):TColumnEh;
    procedure SetRealition_ID(const Realition_ID: integer);
  public
    procedure ShowOrderData(Sender: Tobject); //ˢ����ʾ������
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
     RelName:=defaultRelatin // '������Ӫ'
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
  ChartTitle.Caption:=FTtileName;
end;

procedure TfrmProfitAnaly.edtOrderNoPropertiesChange(Sender: TObject);
begin
  //��ʼ�������»�
  ShowOrderData(Sender);
end;

procedure TfrmProfitAnaly.InitData(const AnalyType,Relation_ID: integer; const vData: OleVariant);
var
  SetCol: TColumnEh;
begin
  vType.ItemIndex:=0;
  vType.Properties.OnChange:=ShowOrderData;
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
  adoAnaly.FieldDefs.Add('UNIT_NAME',ftstring,20,true);  //��������
  adoAnaly.FieldDefs.Add('ORDERNO',ftInteger,0,true);    //�����
  adoAnaly.CreateDataSet;
  ShowOrderData(nil);
end;

procedure TfrmProfitAnaly.ShowOrderData(Sender: Tobject);
var
  i,j,vmax,allReCount: integer;
begin
  if not adoAnaly.Active then Exit;
  if not adoReport.Active then Exit;

  if not adoAnaly.IsEmpty then
    adoAnaly.EmptyDataSet;
    
  if Chart1.Series[0].Count>0 then
    Chart1.Series[0].Clear;
  vmax:=StrtoIntDef(edtOrderNo.Text,5);
  allReCount:=adoReport.RecordCount;
  FSumValue:=0;
  for i:=1 to vmax do
  begin
    case vType.ItemIndex of
     0: //ǰ��������
      begin
        if i<= allReCount then
          adoReport.RecNo:=i
        else
          continue;
      end;
     1: //��������
      begin
        if allReCount-i+1>0 then
          adoReport.RecNo:=allReCount-i+1 //ǰ��������
        else
          continue;
      end;
    end;
    //�����ʾ
    adoAnaly.Append;
    adoAnaly.fieldbyName('GODS_CODE').AsString:=adoReport.fieldByName('GODS_CODE').AsString;
    adoAnaly.fieldbyName('GODS_NAME').AsString:=adoReport.fieldByName('GODS_NAME').AsString;
    adoAnaly.fieldbyName('ANALYSUM').AsFloat:=adoReport.fieldByName('ANALYSUM').AsFloat;
    adoAnaly.fieldbyName('UNIT_NAME').AsString:=adoReport.fieldByName('UNIT_NAME').AsString;
    adoAnaly.fieldbyName('ORDERNO').AsInteger:=i;
    adoAnaly.Post;
    //ͼ����ʾ
    Chart1.Series[0].Add(adoReport.fieldByName('ANALYSUM').AsFloat,trim(adoReport.fieldByName('GODS_NAME').AsString));
    FSumValue:=FSumValue+adoReport.fieldByName('ANALYSUM').AsFloat;
  end;
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

function TfrmProfitAnaly.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var
  i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns[i].FieldName = FieldName then
     begin
       result := DBGrid.Columns[i];
       Exit;
     end;
  end;
end;

procedure TfrmProfitAnaly.CB_ColorClick(Sender: TObject);
begin
  BarSeries1.ColorEachPoint:=CB_Color.Checked;
end;

procedure TfrmProfitAnaly.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  if Column.FieldName = 'GODS_CODE' then
    Text := '�� ��'
  else if UpperCase(Column.FieldName)='ANALYSUM' then
    Text:=FormatFloat(Column.DisplayFormat,FSumValue);
end;

end.
