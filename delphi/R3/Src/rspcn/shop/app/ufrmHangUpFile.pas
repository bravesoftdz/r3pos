unit ufrmHangUpFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, Grids, RzGrids, RzButton, DBGridEh, DB, ADODB;

type
  TfrmHangUpFile = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    btnOK: TRzBmpButton;
    btnCancel: TRzBmpButton;
    RzPanel34: TRzPanel;
    DBGridEh1: TDBGridEh;
    rowToolNav: TRzToolbar;
    Tool_Del: TRzToolButton;
    Tool_Edit: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzSpacer2: TRzSpacer;
    Tool_Right: TRzToolButton;
    RzSpacer3: TRzSpacer;
    Tool_Reset: TRzToolButton;
    DataSource1: TDataSource;
    cdsTable: TADODataSet;
    cdsTableID: TStringField;
    cdsTableSEQNO: TIntegerField;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1DblClick(Sender: TObject);
  public
    procedure LoadFile(cName,path:string);
  end;

implementation

{$R *.dfm}

procedure TfrmHangUpFile.LoadFile(cName,path: string);
var
  sr: TSearchRec;
  FileAttrs: Integer;
begin
  cdsTable.Close;
  cdsTable.CreateDataSet;
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(ExtractFilePath(ParamStr(0))+path+'*.dat', FileAttrs, sr) = 0 then
     begin
       repeat
         if (sr.Attr and FileAttrs) = sr.Attr then
            begin
              if (copy(sr.Name,1,length(cName))=cName) then
                 begin
                   cdsTable.Append;
                   cdsTable.FieldByName('FILENAME').AsString := sr.Name;
                   cdsTable.Post;
                 end;
            end;
       until FindNext(sr) <> 0;
       FindClose(sr);
    end;
  cdsTable.Sort := 'FILENAME DESC';
end;

procedure TfrmHangUpFile.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not (gdFocused in State) or not DBGridEh1.Focused) then
     begin
       DBGridEh1.Canvas.Font.Color := clBlack;
       DBGridEh1.Canvas.Brush.Color := clWhite;
     end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
     begin
       ARect := Rect;
       DBGridEh1.canvas.Brush.Color := DBGridEh1.FixedColor;
       DBGridEh1.canvas.FillRect(ARect);
       DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
     end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmHangUpFile.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmHangUpFile.btnOKClick(Sender: TObject);
begin
  inherited;
  if cdsTable.IsEmpty then Exit;
  ModalResult := MROK;
end;

procedure TfrmHangUpFile.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then btnOkClick(nil);
end;

procedure TfrmHangUpFile.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsTable.IsEmpty then Exit;
  ModalResult := MROK;
end;

end.
