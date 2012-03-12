unit ufrmMktKpiResultList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, cxMaskEdit, cxDropDownEdit, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TOnEditEvent = procedure(Aobj:TRecord_) of object;
  TfrmMktKpiResultList = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnClose: TRzBitBtn;
    RzPanel1: TRzPanel;
    lab_KPI_NAME: TRzLabel;
    lab_IDX_TYPE: TRzLabel;
    lab_KPI_TYPE: TLabel;
    edtKPI_NAME: TcxTextEdit;
    edtIDX_TYPE: TcxComboBox;
    edtKPI_TYPE: TcxComboBox;
    DsList: TDataSource;
    CdsResultList: TZQuery;
    CdsResult: TZQuery;
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1Columns9UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    IsEdit,Saved:Boolean;
    FKpiData: String;
    FKpiCalc: String;
    FKpiType: String;
    FIdxType: String;
    FKpiName: String;
    FKpiYear: Integer;
    FKpiId: String;
    FClientId: String;
    FUpdateRecord: TOnEditEvent;
    procedure SetKpiType(const Value: String);
    procedure SetIdxType(const Value: String);
    procedure SetKpiName(const Value: String);
    procedure SetKpiYear(const Value: Integer);
    procedure SetKpiId(const Value: String);
    procedure SetClientId(const Value: String);
    procedure SetUpdateRecord(const Value: TOnEditEvent);
    { Private declarations }
  public
    { Public declarations }
    Obj_1:TRecord_;
    procedure Open;
    procedure Save;
    class function ShowDialog(Owner:TForm;Id,K_Name,K_Type,ClientId,I_Type:String;K_Year:Integer):Boolean;
    property KpiType:String read FKpiType write SetKpiType;
    property IdxType:String read FIdxType write SetIdxType;
    property ClientId:String read FClientId write SetClientId;
    property KpiYear:Integer read FKpiYear write SetKpiYear;
    property KpiId:String read FKpiId write SetKpiId;
    property KpiName:String write SetKpiName;
    property UpdateRecord:TOnEditEvent read FUpdateRecord write SetUpdateRecord;
  end;

implementation
uses uGlobal,uCtrlUtil, ufrmBasic, uDsUtil;
{$R *.dfm}

{ TfrmMktKpiResultList }

procedure TfrmMktKpiResultList.Open;
var param:TftParamList;
begin
  try
    param := TftParamList.Create;
    param.ParamByName('KPI_YEAR').AsInteger := KpiYear;
    param.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    param.ParamByName('KPI_ID').AsString := KpiId;
    param.ParamByName('CLIENT_ID').AsString := ClientId;
    Factor.BeginBatch;
    Factor.AddBatch(CdsResult,'TMktKpiResult',param);
    Factor.AddBatch(CdsResultList,'TMktKpiResultList',param);
    Factor.OpenBatch;
  finally
    param.Free;
  end;
end;

procedure TfrmMktKpiResultList.SetIdxType(const Value: String);
begin
  FIdxType := Value;
  edtIDX_TYPE.ItemIndex := TdsItems.FindItems(edtIDX_TYPE.Properties.Items,'CODE_ID',Value);
end;

procedure TfrmMktKpiResultList.SetKpiName(const Value: String);
begin
  FKpiName := Value;
  edtKPI_NAME.Text := Value;
end;

procedure TfrmMktKpiResultList.SetKpiType(const Value: String);
begin
  FKpiType := Value;
  edtKPI_TYPE.ItemIndex := TdsItems.FindItems(edtKPI_TYPE.Properties.Items,'CODE_ID',Value);
end;

procedure TfrmMktKpiResultList.btnCloseClick(Sender: TObject);
begin
  inherited;
  if IsEdit then
  begin
     if MessageBox(Handle,'数据有修改,是否保存?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
     begin
        Save;
        if Saved and Assigned(UpdateRecord) then UpdateRecord(Obj_1);
     end;
  end;
  Close;
end;

procedure TfrmMktKpiResultList.FormShow(Sender: TObject);
begin
  inherited;
  dbState := dsBrowse;
  DBGridEh1.PopupMenu :=nil; 
end;

procedure TfrmMktKpiResultList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(CdsResultList.RecNo)),length(Inttostr(CdsResultList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmMktKpiResultList.SetKpiYear(const Value: Integer);
begin
  FKpiYear := Value;
end;

procedure TfrmMktKpiResultList.SetKpiId(const Value: String);
begin
  FKpiId := Value;
end;

procedure TfrmMktKpiResultList.SetClientId(const Value: String);
begin
  FClientId := Value;
end;

procedure TfrmMktKpiResultList.DBGridEh1Columns9UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var Amt,CurPrice:Real;
    rs:TZQuery;
begin
  inherited;
  try
    rs := Global.GetZQueryFromName('PUB_GOODSINFO');
    if rs.Locate('GODS_ID',CdsResultList.FieldByName('GODS_ID').AsString,[]) then
       CurPrice := rs.FieldByName('NEW_OUTPRICE').AsFloat;
    if Text = '' then Amt := 0 else Amt := StrToFloat(Text);
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.AsFloat;
    Raise Exception.Create('无效数值类型!');
  end;
  TColumnEh(Sender).Field.AsFloat := Amt;
  
  CdsResultList.Edit;
  CdsResultList.FieldByName('FISH_MNY').AsFloat := Amt*CurPrice;
  CdsResultList.FieldByName('ADJS_AMT').AsFloat := Amt-CdsResultList.FieldByName('ORG_AMT').AsFloat;
  CdsResultList.FieldByName('ADJS_MNY').AsFloat := CdsResultList.FieldByName('ADJS_AMT').AsFloat*CdsResultList.FieldByName('FISH_CALC_RATE').AsFloat*CurPrice;
  CdsResultList.Post;
  CdsResultList.Edit;
  IsEdit := True;
end;

class function TfrmMktKpiResultList.ShowDialog(Owner: TForm; Id, K_Name,
  K_Type, ClientId, I_Type: String; K_Year: Integer): Boolean;
begin
  with TfrmMktKpiResultList.Create(Owner) do
  begin
    try
      KpiId := Id;
      KpiName := K_Name;
      KpiType := K_Type;
      IdxType := I_Type;
      ClientId := ClientId;
      KpiYear := K_Year;
      Open;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmMktKpiResultList.Save;
var SumFishAmt,SumFishMny,SumAdjsAmt,SumAdjsMny:Real;
begin
  CdsResultList.First;
  while not CdsResultList.Eof do
  begin
    SumFishAmt := SumFishAmt + CdsResultList.FieldByName('FISH_AMT').AsFloat;
    SumFishMny := SumFishAmt + CdsResultList.FieldByName('ADJS_AMT').AsFloat;
    SumAdjsAmt := SumFishAmt + CdsResultList.FieldByName('FISH_MNY').AsFloat;
    SumAdjsMny := SumFishAmt + CdsResultList.FieldByName('ADJS_MNY').AsFloat;
    CdsResultList.Next;
  end;
  CdsResult.Edit;
  CdsResult.FieldByName('FISH_AMT').AsFloat := SumFishAmt;
  CdsResult.FieldByName('ADJS_AMT').AsFloat := SumFishMny;
  CdsResult.FieldByName('FISH_MNY').AsFloat := SumAdjsAmt;
  CdsResult.FieldByName('ADJS_MNY').AsFloat := SumAdjsMny;
  CdsResult.Post;
  Obj_1.ReadFromDataSet(CdsResult);
  try
    Factor.BeginBatch;
    Factor.AddBatch(CdsResult,'TMktKpiResult');
    Factor.AddBatch(CdsResultList,'TMktKpiResultList');
    Factor.CommitBatch;
  Except
    Factor.CancelBatch;
    Raise;
  end;
  Saved := True;
end;

procedure TfrmMktKpiResultList.SetUpdateRecord(const Value: TOnEditEvent);
begin
  FUpdateRecord := Value;
end;

procedure TfrmMktKpiResultList.FormCreate(Sender: TObject);
begin
  inherited;
  Obj_1 := TRecord_.Create;
end;

procedure TfrmMktKpiResultList.FormDestroy(Sender: TObject);
begin
  inherited;
  Obj_1.Free;
end;

end.
