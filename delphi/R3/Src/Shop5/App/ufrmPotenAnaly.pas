unit ufrmPotenAnaly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeEngine, Series, TeeProcs, Chart, Grids, DBGridEh,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  StdCtrls,ZAbstractRODataset, ZAbstractDataset, ZDataset, DB, cxCheckBox;

type
  TfrmPotenAnaly = class(TFrame)
    dsMaxAnaly: TDataSource;
    adoReport: TZQuery;
    MaxAnaly: TZQuery;
    MinAnaly: TZQuery;
    dsMinAnaly: TDataSource;
    ButtomPnl: TPanel;
    MainPnl: TPanel;
    Right_Pnl: TPanel;
    Pnl_Left: TPanel;
    LLeft_Pnl: TPanel;
    Pnl_Left_main: TPanel;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    PnlTop1: TPanel;
    RightPnl: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtMaxNo: TcxComboBox;
    LRight_Pnl: TPanel;
    Splitter1: TSplitter;
    RLeft_Pnl: TPanel;
    Pnl_Right_main: TPanel;
    Panel4: TPanel;
    DBGridEh2: TDBGridEh;
    RRight_Top: TPanel;
    Panel5: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    edtMinNo: TcxComboBox;
    PnlTop2: TPanel;
    Panel6: TPanel;
    CB_NotSale: TcxCheckBox;
    RRight_Pnl: TPanel;
    procedure edtOrderNoPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FrameResize(Sender: TObject);
    procedure edtMinNoPropertiesChange(Sender: TObject);
    procedure CB_NotSalePropertiesChange(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
  private
    Max_MNY,Max_PRF,Max_AMT: real;
    Min_MNY,Min_PRF,Min_AMT: real;
    FRelation_ID: integer;
  public
    procedure ShowOrderData(vType: Integer); //ˢ����ʾ������
    procedure InitData(const Relation_ID: integer; const vData: OleVariant);
  end;

implementation

{$R *.dfm}

uses
  uShopGlobal;

{ TfrmProfitAnaly }

procedure TfrmPotenAnaly.edtOrderNoPropertiesChange(Sender: TObject);
begin
  //��ʼ�������»�
  ShowOrderData(1);
end;

procedure TfrmPotenAnaly.InitData(const Relation_ID: integer; const vData: OleVariant);
var
  RelName: string;
  Rs: TZQuery;
begin
  FRelation_ID:=Relation_ID;
  Rs:=ShopGlobal.GetZQueryFromName('CA_RELATIONS');
  RelName:='';
  if Relation_ID=0 then
    RelName:=defaultRelatin  // '������Ӫ'
  else
  begin
    if Rs.Locate('RELATION_ID',Relation_ID,[]) then
      RelName:=trim(Rs.fieldbyName('RELATION_NAME').AsString);
  end;
  PnlTop1.Caption:='����Ǳ����'+RelName+'��Ʒ�����۶����';
  PnlTop2.Caption:='��������'+RelName+'��Ʒ�����۶����';
  
  adoReport.Close;
  adoReport.Data:=vData;
  //���Ǳ��
  MaxAnaly.Close;
  MaxAnaly.FieldDefs.Add('GODS_CODE',ftstring,20,true);  //��Ʒ����
  MaxAnaly.FieldDefs.Add('GODS_NAME',ftstring,50,true);  //��Ʒ����
  MaxAnaly.FieldDefs.Add('MNY_SUM',ftFloat,0,true);      //���۶�
  MaxAnaly.FieldDefs.Add('PRF_SUM',ftFloat,0,true);      //ë��
  MaxAnaly.FieldDefs.Add('AMT_SUM',ftFloat,0,true);      //����
  MaxAnaly.FieldDefs.Add('ORDERNO',ftInteger,0,true);    //�����
  MaxAnaly.CreateDataSet;
  //��СǱ��
  MinAnaly.Close;
  MinAnaly.FieldDefs.Add('GODS_CODE',ftstring,20,true);  //��Ʒ����
  MinAnaly.FieldDefs.Add('GODS_NAME',ftstring,50,true);  //��Ʒ����
  MinAnaly.FieldDefs.Add('MNY_SUM',ftFloat,0,true);      //���۶�
  MinAnaly.FieldDefs.Add('PRF_SUM',ftFloat,0,true);      //ë��
  MinAnaly.FieldDefs.Add('AMT_SUM',ftFloat,0,true);      //����
  MinAnaly.FieldDefs.Add('ORDERNO',ftInteger,0,true);    //�����
  MinAnaly.CreateDataSet;
  //ˢ����ʾ
  ShowOrderData(11);
end;

procedure TfrmPotenAnaly.ShowOrderData(vType: Integer);
var
  i,j,vmax,vmin,ReIdx: integer;
begin
  Max_MNY:=0;
  Max_PRF:=0;
  Max_AMT:=0;
  if (vType=1) or (vType=11) then
  begin
    if not MaxAnaly.IsEmpty then MaxAnaly.EmptyDataSet;
    vmax:=StrtoIntDef(edtMaxNo.Text,5);
    try
      adoReport.Filtered:=False;
      adoReport.Filter:='vType=4 and Relation_ID='+InttoStr(FRelation_ID);
      adoReport.Filtered:=true;
      for i:=1 to vmax do
      begin  //�����ʾ
        if i<=adoReport.RecordCount then
        begin
          adoReport.RecNo:=i;
          MaxAnaly.Append;
          MaxAnaly.fieldbyName('GODS_CODE').AsString:=adoReport.fieldByName('GODS_CODE').AsString;
          MaxAnaly.fieldbyName('GODS_NAME').AsString:=adoReport.fieldByName('GODS_NAME').AsString;
          MaxAnaly.fieldbyName('MNY_SUM').AsFloat:=adoReport.fieldByName('MNY_SUM').AsFloat;
          MaxAnaly.fieldbyName('PRF_SUM').AsFloat:=adoReport.fieldByName('PRF_SUM').AsFloat;
          MaxAnaly.fieldbyName('AMT_SUM').AsFloat:=adoReport.fieldByName('AMT_SUM').AsFloat;
          MaxAnaly.fieldbyName('ORDERNO').AsInteger:=i;
          MaxAnaly.Post;
          Max_MNY:=Max_MNY+adoReport.fieldByName('MNY_SUM').AsFloat;
          Max_PRF:=Max_PRF+adoReport.fieldByName('PRF_SUM').AsFloat;
          Max_AMT:=Max_AMT+adoReport.fieldByName('AMT_SUM').AsFloat;
        end;
      end;
    finally
      adoReport.Filtered:=False;
      adoReport.Filter:='';
    end;
  end;

  Min_MNY:=0;
  Min_PRF:=0;
  Min_AMT:=0;
  if (vType=10) or (vType=11) then
  begin
    if not MinAnaly.IsEmpty then MinAnaly.EmptyDataSet;
    vmin:=StrtoIntDef(edtMinNo.Text,5);
    try
      ReIdx:=0;
      adoReport.Filtered:=False;
      adoReport.Filter:='vType=1 and Relation_ID='+InttoStr(FRelation_ID);
      adoReport.Filtered:=true;
      ReIdx:=adoReport.RecordCount;
      for i:=ReIdx downto 1 do
      begin  //�����ʾ
        if MinAnaly.RecordCount=vmin then break; //�˳�ѭ��
        adoReport.RecNo:=i;
        if (CB_NotSale.Checked) and (adoReport.FieldByName('AMT_SUM').AsFloat=0) then Continue
        else
        begin
          MinAnaly.Append;
          MinAnaly.fieldbyName('GODS_CODE').AsString:=adoReport.fieldByName('GODS_CODE').AsString;
          MinAnaly.fieldbyName('GODS_NAME').AsString:=adoReport.fieldByName('GODS_NAME').AsString;
          MinAnaly.fieldbyName('MNY_SUM').AsFloat:=adoReport.fieldByName('MNY_SUM').AsFloat;
          MinAnaly.fieldbyName('PRF_SUM').AsFloat:=adoReport.fieldByName('PRF_SUM').AsFloat;
          MinAnaly.fieldbyName('AMT_SUM').AsFloat:=adoReport.fieldByName('AMT_SUM').AsFloat;
          MinAnaly.fieldbyName('ORDERNO').AsInteger:=MinAnaly.RecordCount+1;
          MinAnaly.Post;
          Min_MNY:=Min_MNY+adoReport.fieldByName('MNY_SUM').AsFloat;
          Min_PRF:=Min_PRF+adoReport.fieldByName('PRF_SUM').AsFloat;
          Min_AMT:=Min_AMT+adoReport.fieldByName('AMT_SUM').AsFloat;
        end;
      end;
    finally
      adoReport.Filtered:=False;
      adoReport.Filter:='';
    end;
  end;
end;

procedure TfrmPotenAnaly.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmPotenAnaly.FrameResize(Sender: TObject);
begin
  inherited;
  Pnl_Left.Width:=(self.Width-6) div 2;
end;

procedure TfrmPotenAnaly.edtMinNoPropertiesChange(Sender: TObject);
begin
  inherited;
  ShowOrderData(10);
end;

procedure TfrmPotenAnaly.CB_NotSalePropertiesChange(Sender: TObject);
begin
  ShowOrderData(10);
end;

procedure TfrmPotenAnaly.DBGridEh1GetFooterParams(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  if Column.FieldName = 'GODS_CODE' then
    Text := '�� ��'
  else if UpperCase(Column.FieldName)='MNY_SUM' then
    Text:=FormatFloat(Column.DisplayFormat,Max_MNY)
  else if UpperCase(Column.FieldName)='PRF_SUM' then
    Text:=FormatFloat(Column.DisplayFormat,Max_PRF)
  else if UpperCase(Column.FieldName)='AMT_SUM' then
    Text:=FormatFloat(Column.DisplayFormat,Max_AMT);
end;

procedure TfrmPotenAnaly.DBGridEh2GetFooterParams(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; AFont: TFont; var Background: TColor;
  var Alignment: TAlignment; State: TGridDrawState; var Text: String);
begin
  if Column.FieldName = 'GODS_CODE' then
    Text := '�� ��'
  else if UpperCase(Column.FieldName)='MNY_SUM' then
    Text:=FormatFloat(Column.DisplayFormat,Min_MNY)
  else if UpperCase(Column.FieldName)='PRF_SUM' then
    Text:=FormatFloat(Column.DisplayFormat,Min_PRF)
  else if UpperCase(Column.FieldName)='AMT_SUM' then
    Text:=FormatFloat(Column.DisplayFormat,Min_AMT);
end;

end.
