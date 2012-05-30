unit ufrmFvchOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxDropDownEdit, cxTextEdit, cxCalendar, cxControls, ZBase,
  cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, StdCtrls,
  Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxCheckBox, RzLabel, cxSpinEdit;

type
  TfrmFvchOrder = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    RzPanel4: TRzPanel;
    Image1: TImage;
    Label14: TLabel;
    TopPnl4: TRzPanel;
    TopPnl1: TRzPanel;
    RzLabel1: TRzLabel;
    Label6: TLabel;
    edtFVCH_DATE: TcxDateEdit;
    RzLabel2: TRzLabel;
    TopPnl5: TRzPanel;
    TopPnl3: TRzPanel;
    Label2: TLabel;
    edtFVCH_CODE: TcxTextEdit;
    Label40: TLabel;
    Label5: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    DBGridEh2: TDBGridEh;
    TopPnl2: TRzPanel;
    DBGridEh1: TDBGridEh;
    Label4: TLabel;
    edtGUIDE_USER: TzrComboBoxList;
    Label8: TLabel;
    edtFVCH_FLAG: TcxComboBox;
    Label3: TLabel;
    edtFVCH_ATTACH: TcxSpinEdit;
    Label9: TLabel;
    edtFVCH_IMPORT_ID: TcxTextEdit;
    CdsFvchOrder: TZQuery;
    CdsFvchData: TZQuery;
    CdsFvchDetail: TZQuery;
    DsFvchData: TDataSource;
    DsFvchDetail: TDataSource;
    procedure btnCloseClick(Sender: TObject);
    procedure RzPanel2Resize(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    FisAudit: boolean;
    Fcid: string;
    Tax_Rate:Currency;
    InputType:Integer;
    { Private declarations }
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Setcid(const Value: string);
    procedure FocusNextColumn;
  public
    { Public declarations }
    AObj:TRecord_;
    locked:Boolean;
    RowID:integer;
    procedure Open(id:string);
    procedure Append;
    procedure Edit(id:string);
    procedure SaveOrder;
    procedure CancelOrder;
    procedure DeleteOrder;
    property cid:string read Fcid write Setcid;
  end;

implementation
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal, IniFiles, ufrmBasic, uXDictFactory,
  Math;
{$R *.dfm}

{ TfrmSalInvoice }

procedure TfrmFvchOrder.Append;
begin
 
end;

procedure TfrmFvchOrder.CancelOrder;
begin

end;

procedure TfrmFvchOrder.DeleteOrder;
begin
  if CdsFvchOrder.IsEmpty then Raise Exception.Create('����ɾ��һ�ſյ�...');
  //ɾ������
  CdsFvchOrder.Delete;
  //ɾ����¼
  CdsFvchData.First;
  while not CdsFvchData.Eof do CdsFvchData.Delete;
  //ɾ����ϸ��
  CdsFvchDetail.First;
  while not CdsFvchDetail.Eof do CdsFvchDetail.Delete;

  Factor.BeginBatch;
  try
    Factor.AddBatch(CdsFvchOrder,'TFvchOrder');
    Factor.AddBatch(CdsFvchData,'TFvchData');
    Factor.AddBatch(CdsFvchDetail,'TFvchDetail');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
end;

procedure TfrmFvchOrder.Edit(id: string);
begin

end;

procedure TfrmFvchOrder.Open(id: string);
var
  Params:TftParamList;
begin
  locked:=True;
  try
    Params := TftParamList.Create(nil);
    try
      Factor.BeginBatch;
      try
        Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
        Params.ParamByName('FVCH_ID').asString := id;
        Factor.AddBatch(CdsFvchOrder,'TFvchOrder',Params);
        Factor.AddBatch(CdsFvchData,'TFvchData',Params);
        Factor.AddBatch(CdsFvchDetail,'TFvchDetail',Params);
        Factor.OpenBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;
      AObj.ReadFromDataSet(CdsFvchOrder);
      ReadFromObject(AObj,self);
      dbState := dsBrowse;
    finally
      Params.Free;
    end;
  finally
    locked:=False;
  end;
end;

procedure TfrmFvchOrder.SaveOrder;
begin
 
end;

procedure TfrmFvchOrder.Setcid(const Value: string);
begin

end;

procedure TfrmFvchOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnOk.Visible:=(dbState<>dsBrowse);
  //DBGridEh1.Readonly := (dbState=dsBrowse);
  case Value of
  dsInsert:begin
     Caption := '����ƾ֤--(����)';
     Label14.Caption := '״̬:����';
  end;
  dsEdit:begin
     Caption := '����ƾ֤--(�޸�)';
     Label14.Caption := '״̬:�޸�';
  end;
  else
      begin
        Caption := '����ƾ֤';
        Label14.Caption := '״̬:�鿴';
        btnOk.Visible := False;
      end;
  end;
end;

procedure TfrmFvchOrder.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;


procedure TfrmFvchOrder.FocusNextColumn;
begin

end;

procedure TfrmFvchOrder.RzPanel2Resize(Sender: TObject);
begin
  inherited;
  TopPnl2.Height:=Round((RzPanel2.Height-TopPnl1.Height-TopPnl3.Height-TopPnl5.Height)*3/7);
end;

procedure TfrmFvchOrder.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
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

procedure TfrmFvchOrder.DBGridEh1DrawColumnCell(Sender: TObject;
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
end;

procedure TfrmFvchOrder.FormCreate(Sender: TObject);
begin
  inherited;
  AObj:=TRecord_.Create;  

end;

end.
