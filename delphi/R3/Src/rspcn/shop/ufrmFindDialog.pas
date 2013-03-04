unit ufrmFindDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, RzButton, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase;

type
  TfrmFindDialog = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    findText: TcxTextEdit;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    rs: TZQuery;
    DataSource1: TDataSource;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    FMuiltSelect: boolean;
    { Private declarations }
    procedure decodeFields(str:string);
    procedure SetMuiltSelect(const Value: boolean);
  public
    { Public declarations }
    class function FindDsDialog(ds:TZQuery;var AObj:TRecord_;listFields:string):boolean;
    class function FindSQLDialog(SQL:string;var AObj:TRecord_;listFields:string):boolean;
    property MuiltSelect:boolean read FMuiltSelect write SetMuiltSelect;
  end;

implementation
uses udllGlobal;
{$R *.dfm}

{ TfrmFindDialog }

procedure TfrmFindDialog.decodeFields(str: string);
var
  list:TStringList;
  i:integer;
  Column:TColumnEh;
begin
  list := TStringList.Create;
  try
    list.CommaText := str;
    DBGridEh1.Columns[1].FieldName := list.Names[0];
    DBGridEh1.Columns[1].Title.Caption := list.ValueFromIndex[0];
    DBGridEh1.Columns[2].FieldName := list.Names[1];
    DBGridEh1.Columns[2].Title.Caption := list.ValueFromIndex[1];
    for i:=2 to list.Count -1 do
      begin
         Column := DBGridEh1.Columns.Add;
         Column.FieldName := list.Names[i];
         Column.Title.Caption := list.ValueFromIndex[i];
      end;
  finally
    list.Free;
  end;
end;

class function TfrmFindDialog.FindDsDialog(ds: TZQuery; var AObj: TRecord_;
  listFields: string): boolean;
begin
  with TfrmFindDialog.Create(nil) do
    begin
      try
        DataSource1.DataSet := ds;
        decodeFields(listFields);
        if showModal=mrok then
           begin
             AObj.ReadFromDataSet(ds);
             result := true;
           end
        else
           result := false;
      finally
        free;
      end;
    end;
end;

class function TfrmFindDialog.FindSQLDialog(SQL: string;
  var AObj: TRecord_; listFields: string): boolean;
begin
  with TfrmFindDialog.Create(nil) do
    begin
      try
        rs.SQL.Text := SQL;
        dllGlobal.OpenSqlite(rs);
        decodeFields(listFields);
        if showModal=mrok then
           begin
             AObj.ReadFromDataSet(rs);
             result := true;
           end
        else
           result := false;
      finally
        free;
      end;
    end;
end;

procedure TfrmFindDialog.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmFindDialog.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  if DataSource1.DataSet.IsEmpty then Raise Exception.Create('没有数据在选择列表');
  ModalResult := MROK;
end;

procedure TfrmFindDialog.SetMuiltSelect(const Value: boolean);
begin
  FMuiltSelect := Value;
end;

procedure TfrmFindDialog.DBGridEh1DrawColumnCell(Sender: TObject;
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
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if (Column.FieldName = 'SEQNO') then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(DataSource1.DataSet.RecNo)),length(Inttostr(DataSource1.DataSet.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  if ((gdSelected in State) or (gdFocused in State)) then
    begin
      ARect := Rect;
      DBGridEh1.Canvas.Pen.Color := clRed;
      DBGridEh1.Canvas.Pen.Width := 1;
      DBGridEh1.Canvas.Brush.Style := bsClear;
      DbGridEh1.canvas.Rectangle(ARect);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

end.
