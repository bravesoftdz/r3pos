unit ufrmPayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  Grids, DBGridEh, ZBase, ZDataSet, DB, ZAbstractRODataset,
  ZAbstractDataset, DBSumLst, cxControls, cxContainer, cxEdit, cxTextEdit,
  StdCtrls, RzLabel;

type
  TfrmPayment = class(TfrmWebDialog)
    DBGridEh1: TDBGridEh;
    edtTable: TZQuery;
    dsTable: TDataSource;
    DBSumList1: TDBSumList;
    RzPanel2: TRzPanel;
    btnOk: TRzBmpButton;
    barcode: TRzPanel;
    barcode_input_left: TImage;
    barcode_input_right: TImage;
    barcode_input_line: TImage;
    edtInput: TcxTextEdit;
    RzLabel26: TRzLabel;
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBSumList1SumListChanged(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtInputEnter(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    _totalFee,_payMny:currency;
    _AObj:TRecord_;
    procedure ReadInfo;
    procedure WriteInfo;
  public
    { Public declarations }
    class function payment(AOwner:TForm;totalFee:currency;AObj:TRecord_):boolean;
  end;

implementation

uses udllGlobal;

{$R *.dfm}

{ TfrmPayment }

class function TfrmPayment.payment(AOwner:TForm;totalFee: currency;AObj: TRecord_): boolean;
begin
  with TfrmPayment.Create(AOwner) do
    begin
      try
        _totalFee := totalFee;
        _AObj := AObj;
        ReadInfo;
        edtInput.Text := formatFloat('#0.00',_totalFee-_payMny);
        edtInput.SelectAll;
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmPayment.ReadInfo;
var
  rs:TZQuery;
begin
  edtTable.Close;
  edtTable.CreateDataSet;
  rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
  rs.First;
  while not rs.Eof do
    begin
      edtTable.Append;
      edtTable.FieldbyName('CODE_ID').AsString := rs.FieldbyName('CODE_ID').AsString;
      edtTable.FieldbyName('CODE_NAME').AsString := rs.FieldbyName('CODE_NAME').AsString;
      edtTable.FieldByName('PAY_MNY').AsFloat := _AObj.FieldbyName('PAY_'+rs.FieldbyName('CODE_ID').AsString).asFloat;
      edtTable.Post;
      rs.Next;
    end;
  edtTable.First;
end;

procedure TfrmPayment.WriteInfo;
begin
  edtTable.DisableControls;
  try
    edtTable.First;
    while not edtTable.Eof do
      begin
        _AObj.FieldbyName('PAY_'+edtTable.FieldbyName('CODE_ID').AsString).AsFloat := edtTable.FieldbyName('PAY_MNY').AsFloat;
        edtTable.Next;
      end;
  finally
    edtTable.First;
    edtTable.EnableControls;
  end;
end;

procedure TfrmPayment.DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
  Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
var
  ARect:TRect;
  s:string;
begin
  inherited;
  ARect := Rect;
  ARect.Left:= 1;
  ARect.Right := DBGridEh1.Width-5;
  DbGridEh1.canvas.FillRect(ARect);
  s := '应付:'+formatFloat('#0.00',_totalFee)+' 已付:'+formatFloat('#0.00',_payMny)+ ' 结余:'+formatFloat('#0.00',_totalFee-_payMny);
  if (_totalFee-_payMny)<0 then
     DbGridEh1.Canvas.Font.Color := clred;
  DrawText(DbGridEh1.Canvas.Handle,pchar(s),length(s),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
end;

procedure TfrmPayment.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmPayment.btnOkClick(Sender: TObject);
begin
  inherited;
  try
    WriteInfo;
    if (_payMny=0) and (_AObj.FieldbyName('PAY_A').AsFloat=0) then
       _AObj.FieldbyName('PAY_A').AsFloat := _TotalFee
    else
       if _TotalFee<>_payMny then Raise Exception.Create('支付的金额与应付金额不平，请正确输入');
  except
    edtInput.SelectAll;
    edtInput.SetFocus;
  end;
  ModalResult := MROK;
end;

procedure TfrmPayment.DBSumList1SumListChanged(Sender: TObject);
begin
  inherited;
  _payMny := DBSumList1.SumCollection.Items[0].SumValue;
end;

procedure TfrmPayment.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       DBGridEh1.Col := 2;
       edtTable.Next;
     end;
end;

procedure TfrmPayment.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r:real;
begin
  inherited;
  try
    r := StrtoFloat(Text);
  except
    Value := edtTable.FieldByName('PAY_MNY').AsFloat;
    Text := edtTable.FieldByName('PAY_MNY').AsString;
    MessageBox(Handle,'你输入的金额无效','友情提示..',MB_OK+MB_ICONINFORMATION);
    Exit;
  end;
  edtTable.Edit;
  edtTable.FieldByName('PAY_MNY').AsFloat := r;
  edtTable.Post;
  edtTable.Edit;
end;

procedure TfrmPayment.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not DBGridEh1.Focused then
     begin
       if Key=VK_UP then edtTable.Prior;
       if Key=VK_DOWN then edtTable.Next;
     end;
end;

procedure TfrmPayment.FormKeyPress(Sender: TObject; var Key: Char);
var
  r:real;
begin
//  inherited;
  if Key='+' then
    begin
      Key := #0;
      btnOk.OnClick(nil);
    end;
  if not edtInput.Focused then Exit;
  if (Key=#13) or (Key in ['A'..'J','a'..'j']) then
     begin
       try
         if (trim(edtInput.Text)='') or (edtInput.SelLength=length(edtInput.Text)) then
            begin
              btnOk.OnClick(nil);
              Exit;
            end;
         try
           r := StrtoFloat(edtInput.Text);
         except
           MessageBox(Handle,'你输入的金额无效','友情提示..',MB_OK+MB_ICONINFORMATION);
           Exit;
         end;
         if Key<>#13 then
            begin
              if not edtTable.Locate('CODE_ID',uppercase(Key),[]) then Exit; 
            end;
         edtTable.Edit;
         edtTable.FieldByName('PAY_MNY').AsFloat := r;
         edtTable.Post;
       finally
         Key := #0;
         edtInput.Text := '';
         edtInput.SelectAll;
         edtInput.SetFocus;
       end;
     end;
end;

procedure TfrmPayment.edtInputEnter(Sender: TObject);
begin
  inherited;
  edtInput.SelectAll;
end;

procedure TfrmPayment.edtInputKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then Key := #0;
end;

procedure TfrmPayment.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clWhite;
    DbGridEh1.Canvas.Font.Size := DbGridEh1.Canvas.Font.Size+2;
    DbGridEh1.Canvas.Font.Style := [fsBold];
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

end.
