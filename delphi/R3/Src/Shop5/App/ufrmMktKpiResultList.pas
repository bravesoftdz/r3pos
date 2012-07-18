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
    lab_KPI_TYPE: TLabel;
    edtKPI_NAME: TcxTextEdit;
    edtKPI_TYPE: TcxComboBox;
    DsList: TDataSource;
    CdsResultList: TZQuery;
    CdsResult: TZQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    btnSave: TRzBitBtn;
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1Columns9UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure btnSaveClick(Sender: TObject);
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
    FAudited: boolean;
    procedure SetKpiType(const Value: String);
    procedure SetIdxType(const Value: String);
    procedure SetKpiName(const Value: String);
    procedure SetKpiYear(const Value: Integer);
    procedure SetKpiId(const Value: String);
    procedure SetClientId(const Value: String);
    procedure SetUpdateRecord(const Value: TOnEditEvent);
    procedure SetAudited(const Value: boolean);
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
    property Audited:boolean read FAudited write SetAudited;
  end;

implementation
uses uGlobal,uCtrlUtil, ufrmBasic, uDsUtil, uShopGlobal;
{$R *.dfm}

{ TfrmMktKpiResultList }

procedure TfrmMktKpiResultList.Open;
var param:TftParamList;
begin
  try
    param := TftParamList.Create;
    param.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    param.ParamByName('KPI_YEAR').AsInteger := KpiYear;
    param.ParamByName('KPI_ID').AsString := KpiId;
    param.ParamByName('CLIENT_ID').AsString := ClientId;
    Factor.BeginBatch;
    try
      Factor.AddBatch(CdsResult,'TMktKpiResult',param);
      Factor.AddBatch(CdsResultList,'TMktKpiResultListForEdit',param);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
  finally
    param.Free;
  end;
end;

procedure TfrmMktKpiResultList.SetIdxType(const Value: String);
begin
  FIdxType := Value;
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

procedure TfrmMktKpiResultList.FormShow(Sender: TObject);
begin
  inherited;
  dbState := dsBrowse;
end;

procedure TfrmMktKpiResultList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
  s:string;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'FISH_RATE' then
    begin
      if CdsResultList.FieldByName('KPI_DATA').AsInteger in [1,4] then
         begin
           if CdsResult.FieldByName('PLAN_AMT').AsFloat<>0 then
              s := formatFloat('#0.00%',CdsResultList.FieldbyName('FISH_AMT').AsFloat/CdsResult.FieldByName('PLAN_AMT').AsFloat*100)
           else
              s := '0.00%';
         end
      else
         begin
           if CdsResult.FieldByName('PLAN_MNY').AsFloat<>0 then
              s := formatFloat('#0.00%',CdsResultList.FieldbyName('FISH_AMT').AsFloat/CdsResult.FieldByName('PLAN_MNY').AsFloat*100)
           else
              s := '0.00%';
         end;
      ARect := Rect;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;

  if Column.FieldName = 'SHW_RATIO' then
     begin
      ARect := Rect;
      DBGridEh1.canvas.FillRect(ARect);
       case CdsResultList.FieldbyName('KPI_CALC').AsInteger of
       1,3:s := formatFloat('#0.00',Column.Field.AsFloat)+CdsResultList.FieldbyName('CALC_SHOW_NAME').asString;
       2:s := formatFloat('#0.00',Column.Field.AsFloat)+'/'+CdsResultList.FieldbyName('CALC_SHOW_NAME').asString;
       end;
      DrawText(DBGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
     end;
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
var Rate:Real;
    rs:TZQuery;
begin
  inherited;
  try
    Rate := Value;
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.AsFloat;
    Raise Exception.Create('无效数值类型!');
  end;
  TColumnEh(Sender).Field.AsFloat := Rate;
  CdsResultList.FieldByName('ADJS_RATE').AsFloat := Rate;
  CdsResultList.Edit;
  case CdsResultList.FieldbyName('KPI_CALC').AsInteger of
  1,3:CdsResultList.FieldByName('KPI_MNY').AsFloat := CdsResultList.FieldByName('FISH_AMT').AsFloat*Rate/100;
  2:  CdsResultList.FieldByName('KPI_MNY').AsFloat := CdsResultList.FieldByName('FISH_AMT').AsFloat*Rate*CdsResultList.FieldByName('FISH_CALC_RATE').AsFloat;
  end;
  CdsResultList.Post;
  CdsResultList.Edit;
  IsEdit := true;
  
end;

class function TfrmMktKpiResultList.ShowDialog(Owner: TForm; Id, K_Name,
  K_Type, ClientId, I_Type: String; K_Year: Integer): Boolean;
begin
  with TfrmMktKpiResultList.Create(Owner) do
  begin
    try
      DBGridEh1.ReadOnly := true;
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
var SumKpiMny:Real;
begin
  SumKpiMny := 0;
  CdsResultList.First;
  while not CdsResultList.Eof do
  begin
    SumKpiMny := SumKpiMny + CdsResultList.FieldByName('KPI_MNY').AsFloat;
    CdsResultList.Next;
  end;
  CdsResult.Edit;
  CdsResult.FieldByName('KPI_MNY').AsFloat := SumKpiMny;
  CdsResult.FieldByName('CREA_DATE').AsString := formatDatetime('YYYYMMDD HH:NN:SS',now());
  CdsResult.FieldByName('CREA_USER').AsString := Global.UserID;
  CdsResult.Post;
  Obj_1.ReadFromDataSet(CdsResult);
  try
    Factor.BeginBatch;
    Factor.AddBatch(CdsResult,'TMktKpiResult');
    Factor.AddBatch(CdsResultList,'TMktKpiResultListForEdit');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  DBGridEh1.ReadOnly := true;
  btnSave.Visible := not DBGridEh1.ReadOnly;
  IsEdit := false;
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

procedure TfrmMktKpiResultList.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMktKpiResultList.FormClose(Sender: TObject;
  var Action: TCloseAction);
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
end;

procedure TfrmMktKpiResultList.N1Click(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002158',2) then Raise Exception.Create('你没有修改的权限,请和管理员联系.');
  if Audited then Raise Exception.Create('已经审核不能修改');
  DBGridEh1.ReadOnly := false;
  btnSave.Visible := not DBGridEh1.ReadOnly;
end;

procedure TfrmMktKpiResultList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if not Column.ReadOnly and not DBGridEh1.ReadOnly then
     Background := clYellow;
end;

procedure TfrmMktKpiResultList.btnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmMktKpiResultList.SetAudited(const Value: boolean);
begin
  FAudited := Value;
end;

end.
