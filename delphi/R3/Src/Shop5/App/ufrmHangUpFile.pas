unit ufrmHangUpFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, DB, ADODB;

type
  TfrmHangUpFile = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    cdsTable: TADODataSet;
    cdsTableID: TStringField;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    cdsTableSEQNO: TIntegerField;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadFile(cName:string);
  end;

implementation

{$R *.dfm}

{ TfrmHangUpFile }

procedure TfrmHangUpFile.LoadFile(cName: string);
var
  sr: TSearchRec;
  FileAttrs: Integer;
begin
  cdsTable.Close;
  cdsTable.CreateDataSet;
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  if FindFirst(ExtractFilePath(ParamStr(0))+'HangUp\*.dat', FileAttrs, sr) = 0 then
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
var ARect:TRect;
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := clBtnFace;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;

end;

procedure TfrmHangUpFile.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
     Background := clBtnFace;
end;

procedure TfrmHangUpFile.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmHangUpFile.btnOkClick(Sender: TObject);
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

end.
