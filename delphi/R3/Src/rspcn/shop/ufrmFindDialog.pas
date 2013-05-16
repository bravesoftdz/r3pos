unit ufrmFindDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  cxControls, cxContainer, cxEdit, cxTextEdit, RzButton, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, StdCtrls,
  RzLabel;

type
  TfrmFindDialog = class(TfrmWebDialog)
    rs: TZQuery;
    DataSource1: TDataSource;
    RzPanel3: TRzPanel;
    DBGridEh1: TDBGridEh;
    btnFind: TRzBmpButton;
    RzPanel5: TRzPanel;
    Image4: TImage;
    Image6: TImage;
    Image7: TImage;
    serachText: TEdit;
    RzLabel26: TRzLabel;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnFindClick(Sender: TObject);
    procedure serachTextEnter(Sender: TObject);
    procedure serachTextExit(Sender: TObject);
    procedure rsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure serachTextKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure serachTextChange(Sender: TObject);
  private
    FMuiltSelect: boolean;
    serachTxt:string;
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
        DataSource1.DataSet.OnFilterRecord := nil;
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
        DataSource1.DataSet.OnFilterRecord := nil;
        free;
      end;
    end;
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

procedure TfrmFindDialog.btnFindClick(Sender: TObject);
begin
  inherited;
  if DataSource1.DataSet.IsEmpty then Raise Exception.Create('没有数据在选择列表');
  ModalResult := MROK;

end;

procedure TfrmFindDialog.serachTextEnter(Sender: TObject);
begin
  inherited;
  serachText.Text := serachTxt;
  serachText.SelectAll;

end;

procedure TfrmFindDialog.serachTextExit(Sender: TObject);
begin
  inherited;
  if serachTxt='' then serachText.Text := serachText.Hint;

end;

procedure TfrmFindDialog.rsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  i:integer;
begin
  inherited;
  Accept := false;
  for i:=0 to DataSet.Fields.Count-1 do
    begin
      Accept := (Pos(serachTxt,DataSet.Fields[i].AsString)>0);
      if Accept then Exit;
    end;
end;

procedure TfrmFindDialog.serachTextKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       DataSource1.DataSet.OnFilterRecord := rs.OnFilterRecord;
       DataSource1.DataSet.Filtered := (trim(serachTxt)<>'');
       Key := #0;
       btnFind.SetFocus;
     end;
end;

procedure TfrmFindDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_UP then DataSource1.DataSet.Prior;
  if Key=VK_DOWN then DataSource1.DataSet.Next;
end;

procedure TfrmFindDialog.serachTextChange(Sender: TObject);
begin
  inherited;
  if serachText.Focused then serachTxt := serachText.Text;

end;

end.
