unit ufrmLocusNoProperty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, Grids, DBGridEh,
  RzButton, DB, ZDataSet, uframeOrderForm, RzBorder;

type
  TfrmLocusNoProperty = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    pnlBarCode: TRzPanel;
    lblInput: TLabel;
    edtInput: TcxTextEdit;
    RzBitBtn1: TRzBitBtn;
    Panel1: TPanel;
    RzLEDDisplay: TRzLEDDisplay;
    Label1: TLabel;
    Label2: TLabel;
    RzLEDDisplay2: TRzLEDDisplay;
    PopupMenu1: TPopupMenu;
    actDelete: TAction;
    actImport: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actDeleteAll: TAction;
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteAllExecute(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
  private
    FDataSet: TDataSet;
    FdbState: TDataSetState;
    FForm: TframeOrderForm;
    FWait: integer;
    procedure SetDataSet(const Value: TDataSet);
    { Private declarations }
    procedure InitGrid;
    procedure SetdbState(const Value: TDataSetState);
    procedure SetForm(const Value: TframeOrderForm);
    procedure SetWait(const Value: integer);
  public
    { Public declarations }
    property DataSet:TDataSet read FDataSet write SetDataSet;
    property dbState:TDataSetState read FdbState write SetdbState;
    property Form:TframeOrderForm read FForm write SetForm;
    property Wait:integer read FWait write SetWait;
  end;

implementation

uses uGlobal,ufrmExcelFactory;
var frmLocusNoProperty:TfrmLocusNoProperty;
{$R *.dfm}

procedure TfrmLocusNoProperty.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='LOCUS_NO' then
     begin
       Text := '合计:'+Text;
     end;
end;

procedure TfrmLocusNoProperty.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
  DataSource1.DataSet := Value;
  RzLEDDisplay.Caption := inttostr(DataSet.RecordCount);
  RzLEDDisplay2.Caption := inttostr(Wait-DataSet.RecordCount);
end;

procedure TfrmLocusNoProperty.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(DataSet.RecNo)),length(Inttostr(DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmLocusNoProperty.InitGrid;
function  FindColumn(FieldName:string):TColumnEh;
var i:integer;
begin
  Result := nil;
  for i:=0 to DBGridEh1.Columns.Count -1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := DBGridEh1.Columns[i];
           Exit;
         end;
    end;
end;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  inherited;
  Column := FindColumn('UNIT_ID');
  if Column<>nil then
  begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
end;

procedure TfrmLocusNoProperty.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  frmLocusNoProperty := self;
end;

procedure TfrmLocusNoProperty.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmLocusNoProperty.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  if DataSet.RecordCount <> Wait then Raise Exception.Create('系统检测扫码没有结束,请扫码完毕后再操作');
  self.ModalResult := MROK;
end;

procedure TfrmLocusNoProperty.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  pnlBarCode.Visible := (Value<>dsBrowse);


end;

procedure TfrmLocusNoProperty.SetForm(const Value: TframeOrderForm);
begin
  FForm := Value;
end;

procedure TfrmLocusNoProperty.edtInputKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if trim(edtInput.Text)='' then Exit;
  if Key=#13 then
     begin
       try
         TframeOrderForm(Form).GodsToLocusNo(trim(edtInput.Text));
       finally
         //DataSet.Filtered := false;
         //DataSet.Filtered := true;
       end;
       RzLEDDisplay.Caption := inttostr(DataSet.RecordCount);
       RzLEDDisplay2.Caption := floattostr(Wait-DataSet.RecordCount);
       edtInput.Text := '';
     end;
end;

procedure TfrmLocusNoProperty.SetWait(const Value: integer);
begin
  FWait := Value;
  if DataSet<>nil then
     RzLEDDisplay2.Caption := floattostr(Value-DataSet.RecordCount);
end;

procedure TfrmLocusNoProperty.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not edtInput.CanFocus then inherited;

end;

procedure TfrmLocusNoProperty.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if DataSet.IsEmpty then Exit;
  if MessageBox(Handle,pchar('是否确认删除'+DataSet.FieldbyName('LOCUS_NO').AsString+'，重新扫码？'),'友情提示...',MB_YESNO+MB_ICONINFORMATION)<>6 then Exit;
  DataSet.Delete;
  RzLEDDisplay.Caption := inttostr(DataSet.RecordCount);
  RzLEDDisplay2.Caption := floattostr(Wait-DataSet.RecordCount);

end;

procedure TfrmLocusNoProperty.actDeleteAllExecute(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,'是否确认删除所有扫码数据，重新扫码？','友情提示...',MB_YESNO+MB_ICONINFORMATION)<>6 then Exit;
  if DataSet.IsEmpty then Exit;
  DataSet.First;
  while not DataSet.Eof do DataSet.Delete;
  RzLEDDisplay.Caption := inttostr(DataSet.RecordCount);
  RzLEDDisplay2.Caption := floattostr(Wait-DataSet.RecordCount);

end;

procedure TfrmLocusNoProperty.actImportExecute(Sender: TObject);
function ImportLocusNo(Source, Dest: TDataSet;
  SFieldName, DFieldName: string): Boolean;
begin
  if DFieldName='LOCUS_NO' then
     begin
       TframeOrderForm(frmLocusNoProperty.Form).GodsToLocusNo(Source.FieldbyName(SFieldName).AsString);
       Dest.Edit;
       frmLocusNoProperty.RzLEDDisplay.Caption := inttostr(frmLocusNoProperty.DataSet.RecordCount);
       frmLocusNoProperty.RzLEDDisplay2.Caption := floattostr(frmLocusNoProperty.Wait-frmLocusNoProperty.DataSet.RecordCount);
       result := true;
     end;
end;
begin
  inherited;
  if not DataSet.IsEmpty then Raise Exception.Create('已经存在扫码记录，不能导入');
  TfrmExcelFactory.ExcelFactory(DataSet,'LOCUS_NO=物流跟踪码',@ImportLocusNo,nil,'0=LOCUS_NO',1);
end;

end.
