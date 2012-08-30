
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
    Tab_FvchDATA: TRzTabSheet;
    RzPanel3: TRzPanel;
    Tab_FvchDetail: TRzTabSheet;
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
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure RzPageDetailChanging(Sender: TObject; NewIndex: Integer;
      var AllowChange: Boolean);
  private
    FisAudit: boolean;
    Fcid: string;
    Tax_Rate:Currency;
    InputType:Integer;
    function  NumToStr(const mny: Currency): string;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Setcid(const Value: string);
    procedure FocusNextColumn;
    procedure SetGridAmtPriceCol(const AmtVisible,PriVisible: Boolean);
    procedure SetParams;
    procedure SetGridFooterSum; //����ҳ�Ż���
  public
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
  while not CdsFvchData.Eof do
  begin
    CdsFvchData.Delete;
  end;
  //ɾ����ϸ��
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
      //������ʾ
      edtFVCH_FLAG.ItemIndex:=StrToIntDef(CdsFvchOrder.FieldByName('FVCH_FLAG').AsString,0);
      edtFVCH_ATTACH.Value:=CdsFvchOrder.FieldByName('FVCH_ATTACH').AsInteger;
      //case  of
      //end;

      //���ÿ�������
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
  RzPageDetail.ActivePage:=Tab_FvchDATA;
end;

procedure TfrmFvchOrder.SetGridAmtPriceCol(const AmtVisible,PriVisible: Boolean);
var
  FindCol: TColumnEh;
begin
  //DBGridEh1���ý跽
  FindCol:=FindDBColumn(DBGridEh1,'DEBIT_AMT');
  if FindCol<>nil then FindCol.Visible:=AmtVisible;
  FindCol:=FindDBColumn(DBGridEh1,'DEBIT_PRICE');
  if FindCol<>nil then FindCol.Visible:=PriVisible;
  FindCol:=FindDBColumn(DBGridEh1,'DEBIT_MNY');
  if FindCol<>nil then
  begin
    if (not AmtVisible) and (not PriVisible) then //������ʾ
      FindCol.Title.Caption:='�跽���'
    else
      FindCol.Title.Caption:='�跽|���';
  end;
  //DBGridEh1���ô���
  FindCol:=FindDBColumn(DBGridEh1,'CREDIT_AMT');
  if FindCol<>nil then FindCol.Visible:=AmtVisible;
  FindCol:=FindDBColumn(DBGridEh1,'CREDIT_PRICE');
  if FindCol<>nil then FindCol.Visible:=PriVisible;
  FindCol:=FindDBColumn(DBGridEh1,'CREDIT_MNY');
  if FindCol<>nil then
  begin
    if (not AmtVisible) and (not PriVisible) then //������ʾ
      FindCol.Title.Caption:='�������'
    else
      FindCol.Title.Caption:='����|���';
  end;

  //DBGridEh1���ý跽
  FindCol:=FindDBColumn(DBGridEh2,'AMOUNT');
  if FindCol<>nil then FindCol.Visible:=AmtVisible;
  FindCol:=FindDBColumn(DBGridEh2,'APRICE');
  if FindCol<>nil then FindCol.Visible:=PriVisible;
end;

procedure TfrmFvchOrder.SetParams;
var
  Rs: TZQuery;
  CurMny:Currency;
  SumAmt,SumPri: real;
  FindCol: TColumnEh;
begin
  SumAmt:=0;
  SumPri:=0;
  CurMny:=0;
  try
    Rs:=TZQuery.Create(nil);
    Rs.Data:=CdsFvchData.Data;
    if not Rs.IsEmpty then
    begin
      Rs.First;
      while not Rs.Eof do
      begin
        CurMny:=CurMny+Rs.FieldByName('DEBIT_MNY').AsFloat;
        SumAmt:=SumAmt+abs(Rs.FieldByName('DEBIT_AMT').AsFloat)+abs(Rs.FieldByName('CREDIT_AMT').AsFloat);
        SumPri:=SumAmt+abs(Rs.FieldByName('DEBIT_PRI').AsFloat)+abs(Rs.FieldByName('CREDIT_PRI').AsFloat);
        Rs.Next;
      end;
    end;     
  finally
    Rs.Free;
  end;
  FindCol:=FindDBColumn(DBGridEh1,'SUMMARY');
  if FindCol<>nil then
    FindCol.Footer.Value:='�����(��д)'+NumToStr(CurMny);  
  SetGridAmtPriceCol((SumAmt<>0),(SumPri<>0));
end;

procedure TfrmFvchOrder.DBGridEh1DblClick(Sender: TObject);
var
  ChangeFlag: Boolean;
begin
  inherited;
  if CdsFvchData.IsEmpty then Exit;
  RzPageDetail.ActivePage:=Tab_FvchDetail;
end;

procedure TfrmFvchOrder.RzPageDetailChanging(Sender: TObject; NewIndex: Integer; var AllowChange: Boolean);
begin
  if (RzPageDetail.ActivePage<>Tab_FvchDetail) and (not CdsFvchData.IsEmpty) then
  begin
    CdsFvchDetail.Filtered:=False;
    CdsFvchDetail.Filter:='FVCH_DID='''+trim(CdsFvchData.FieldByName('FVCH_DID').AsString)+''' ';
    CdsFvchDetail.Filtered:=true;
    if CdsFvchDetail.RecordCount=0 then
    begin
      AllowChange:=False;
      Raise Exception.Create('  ��ǰƾ֤��¼û����ϸ...  ');
    end;
    //����Grid����ҳ��
    SetGridFooterSum;
  end;
end;

function TfrmFvchOrder.NumToStr(const mny: Currency): string;
const
  cnum: array[0..9] of string=('��','Ҽ','��','��','��','��','½','��','��','��');
  cunit: array[0..14] of string=('��','Ǫ','��','ʰ','��','Ǫ','��','ʰ','��','Ǫ','��','ʰ','Ԫ','��','��');
var
  i : Integer;
  snum,stemp : string;
begin
  result :='';
  snum := format('%15d',[round(mny * 100)]);
  for i := 0 to 14 do
  begin
    stemp := copy(snum,i+1,1);
    if stemp=' ' then continue
    else result := result + cnum[strtoint(stemp)] + cunit[i];
  end;
  //ȥ���������
  Result := StringReplace(Result, '��Ԫ','Ԫ', [rfReplaceAll]);
  Result := StringReplace(Result, '��ʰ', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '���', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '��Ǫ', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '����', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '����', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '����', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '������','��', [rfReplaceAll]);
  Result := StringReplace(Result, '����', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '����', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '����', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '����', '��', [rfReplaceAll]);
  Result := StringReplace(Result, '��Ԫ', 'Ԫ', [rfReplaceAll]);
  if pos('���',result)=0 then Result := StringReplace(Result,'���','��', [rfReplaceAll])
  else Result := StringReplace(Result,'���','��', [rfReplaceAll]);
  Result := StringReplace(Result,'���','', [rfReplaceAll]);
end;

procedure TfrmFvchOrder.SetGridFooterSum;
var
  SumAmt:real; //����
  SumPri:real; //����
  SumMny:Currency; //���
  FindCol: TColumnEh; //������
  RsData: TZQuery;
begin
  SumAmt:=0;
  SumPri:=0;
  SumMny:=0;
  try
    RsData:=TZQuery.Create(nil);
    RsData.Data:=CdsFvchDetail.Data;
    RsData.Filtered:=False;
    RsData.Filter:='FVCH_DID='''+trim(CdsFvchData.FieldByName('FVCH_DID').AsString)+''' ';
    RsData.Filtered:=true;
    RsData.First;
    if RsData.Active then
    begin
      SumAmt:=SumAmt+RsData.FieldByName('AMOUNT').AsFloat;
      SumMny:=SumMny+RsData.FieldByName('AMONEY').AsFloat;
      RsData.Next;
    end;
    if SumAmt<>0 then SumPri:=Roundto((SumMny*1.000)/(SumAmt*1.000),-2);
  finally
    RsData.Free;
  end;
  //�����ۼ�
  FindCol:=self.FindDBColumn(DBGridEh2,'AMOUNT');
  if (FindCol<>nil) and (FindCol.Visible) then
    FindCol.Footer.Value:=FormatFloat('#0.###',SumAmt);
  //����ƽ��
  FindCol:=self.FindDBColumn(DBGridEh2,'APRICE');
  if (FindCol<>nil) and (FindCol.Visible) then
    FindCol.Footer.Value:=FormatFloat('#0.00#',SumPri);
  //������
  FindCol:=self.FindDBColumn(DBGridEh2,'AMONEY');
  if (FindCol<>nil) and (FindCol.Visible) then
    FindCol.Footer.Value:=FormatFloat('#0.00',SumMny);
end;

end.
