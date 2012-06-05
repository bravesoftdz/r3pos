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
    TopPnl1: TRzPanel;
    RzLabel1: TRzLabel;
    Label6: TLabel;
    edtFVCH_DATE: TcxDateEdit;
    RzLabel2: TRzLabel;
    Label2: TLabel;
    edtFVCH_CODE: TcxTextEdit;
    Label40: TLabel;
    Label5: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    CdsFvchOrder: TZQuery;
    CdsFvchData: TZQuery;
    CdsFvchDetail: TZQuery;
    DsFvchData: TDataSource;
    DsFvchDetail: TDataSource;
    RzPageDetail: TRzPageControl;
    RzTabSheet1: TRzTabSheet;
    RzPanel3: TRzPanel;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    Label4: TLabel;
    edtCREA_USER: TzrComboBoxList;
    Label3: TLabel;
    edtFVCH_ATTACH: TcxSpinEdit;
    Label8: TLabel;
    edtFVCH_FLAG: TcxComboBox;
    Label9: TLabel;
    edtFVCH_IMPORT_ID: TcxTextEdit;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    procedure btnCloseClick(Sender: TObject);
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
    procedure SetGridAmtPriceCol(const AmtVisible,PriVisible: Boolean);
    procedure SetParams;
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
  if CdsFvchOrder.IsEmpty then Raise Exception.Create('不能删除一张空单...');
  //删除主表
  CdsFvchOrder.Delete;
  //删除分录
  CdsFvchData.First;
  while not CdsFvchData.Eof do
  begin
    CdsFvchData.Delete;
  end;
  //删除明细项
  CdsFvchDetail.First;
  while not CdsFvchDetail.Eof do
  begin
    CdsFvchDetail.Delete;
  end;

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
      //设置显示
      edtFVCH_FLAG.ItemIndex:=StrToIntDef(CdsFvchOrder.FieldByName('FVCH_FLAG').AsString,0);
      edtFVCH_ATTACH.Value:=CdsFvchOrder.FieldByName('FVCH_ATTACH').AsInteger;

      //设置控制属性
      SetParams;
      
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
     Caption := '财务凭证--(新增)';
     Label14.Caption := '状态:新增';
  end;
  dsEdit:begin
     Caption := '财务凭证--(修改)';
     Label14.Caption := '状态:修改';
  end;
  else
      begin
        Caption := '财务凭证';
        Label14.Caption := '状态:查看';
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

procedure TfrmFvchOrder.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
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
    Column.Grid.Canvas.Brush.Color := clAqua;   //选中颜色状态
  end;
  Column.Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFvchOrder.FormCreate(Sender: TObject);
begin
  inherited;
  AObj:=TRecord_.Create;

end;

procedure TfrmFvchOrder.SetGridAmtPriceCol(const AmtVisible,PriVisible: Boolean);
var
  FindCol: TColumnEh;
begin
  //DBGridEh1设置借方
  FindCol:=FindDBColumn(DBGridEh1,'DEBIT_AMT');
  if FindCol<>nil then FindCol.Visible:=AmtVisible;
  FindCol:=FindDBColumn(DBGridEh1,'DEBIT_PRICE');
  if FindCol<>nil then FindCol.Visible:=PriVisible;
  FindCol:=FindDBColumn(DBGridEh1,'DEBIT_MNY');
  if FindCol<>nil then
  begin
    if (not AmtVisible) and (not PriVisible) then //设置显示
      FindCol.Title.Caption:='借方金额'
    else
      FindCol.Title.Caption:='借方|金额';
  end;
  //DBGridEh1设置贷方
  FindCol:=FindDBColumn(DBGridEh1,'CREDIT_AMT');
  if FindCol<>nil then FindCol.Visible:=AmtVisible;
  FindCol:=FindDBColumn(DBGridEh1,'CREDIT_PRICE');
  if FindCol<>nil then FindCol.Visible:=PriVisible;
  FindCol:=FindDBColumn(DBGridEh1,'CREDIT_MNY');
  if FindCol<>nil then
  begin
    if (not AmtVisible) and (not PriVisible) then //设置显示
      FindCol.Title.Caption:='贷方金额'
    else
      FindCol.Title.Caption:='贷方|金额';
  end;

  //DBGridEh1设置借方
  FindCol:=FindDBColumn(DBGridEh2,'AMOUNT');
  if FindCol<>nil then FindCol.Visible:=AmtVisible;
  FindCol:=FindDBColumn(DBGridEh2,'APRICE');
  if FindCol<>nil then FindCol.Visible:=PriVisible;
end;

procedure TfrmFvchOrder.SetParams;
var
  Rs: TZQuery;
  SumAmt,SumPri: real;    
begin
  SumAmt:=0;
  SumPri:=0;
  try
    Rs:=TZQuery.Create(nil);
    Rs.Data:=CdsFvchData.Data;
    if not Rs.IsEmpty then
    begin
      Rs.First;
      while not Rs.Eof do
      begin
        SumAmt:=SumAmt+abs(Rs.FieldByName('DEBIT_AMT').AsFloat)+abs(Rs.FieldByName('CREDIT_AMT').AsFloat);
        SumPri:=SumAmt+abs(Rs.FieldByName('DEBIT_PRI').AsFloat)+abs(Rs.FieldByName('CREDIT_PRI').AsFloat);
        Rs.Next;
      end;
    end;     
  finally
    Rs.Free;
  end;   
  SetGridAmtPriceCol((SumAmt<>0),(SumPri<>0));
end;

end.
