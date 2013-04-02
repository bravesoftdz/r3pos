unit ufrmSelectFormer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls,
  Grids, RzGrids, RzTabs, StdCtrls, RzLabel, ZDataSet;

type
  TfrmSelectFormer = class(TfrmWebDialog)
    RzPanel3: TRzPanel;
    frfGrid: TRzStringGrid;
    RzLabel26: TRzLabel;
    RzPanel4: TRzPanel;
    btnOK: TRzBmpButton;
    btnCancel: TRzBmpButton;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure frfGridDblClick(Sender: TObject);
  public
    procedure Load(filename:string);
    class function SelectFormer(Owner:TForm;fname:string):string;
  end;

implementation

uses udataFactory,uTokenFactory;

{$R *.dfm}

{ TfrmSelectFormer }

procedure TfrmSelectFormer.Load(filename: string);
var
  sr: TSearchRec;
  FileAttrs: Integer;
  w:integer;
  s:string;
  rs:TZQuery;
begin
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  w := 0;
  if FindFirst(ExtractFilePath(ParamStr(0))+'frf\*.frf', FileAttrs, sr) = 0 then
    begin
      repeat
        if (sr.Attr and FileAttrs) = sr.Attr then
        begin
          s := ExtractFileName(sr.Name);
          if lowercase(copy(s,1,length(filename)+1))=lowercase(filename+'_') then
          begin
            if w >= frfGrid.RowCount then frfGrid.RowCount := frfGrid.RowCount + 1;
            frfGrid.Cells[0,w] := copy(s,length(filename)+2,255);
            frfGrid.Cells[0,w] := copy(frfGrid.Cells[0,w],1,length(frfGrid.Cells[0,w])-4);
            w := w + 1;
          end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;

  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select frfFileTitle from SYS_FASTFILE where TENANT_ID='+token.tenantId+' and frfFileName like '''+filename+'%''';
    dataFactory.MoveToRemote;
    try
      dataFactory.Open(rs);
    finally
      dataFactory.MoveToDefault;
    end;
    rs.first;
    while not rs.eof do
      begin
        if w >= frfGrid.RowCount then frfGrid.RowCount := frfGrid.RowCount + 1;
        frfGrid.Cells[0,w] := rs.Fields[0].AsString+'(×Ô¶¨Òå)';
        w := w + 1;
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

class function TfrmSelectFormer.SelectFormer(Owner: TForm; fname: string): string;
begin
  with TfrmSelectFormer.Create(Owner) do
    begin
      try
        Load(fname);
        result := '';
        if ShowModal = MROK then
           result := fname+'_'+frfGrid.Cells[0,frfGrid.Selection.Top];
      finally
        Free;
      end;
    end;
end;

procedure TfrmSelectFormer.btnOKClick(Sender: TObject);
begin
  inherited;
  if trim(frfGrid.Cells[0,frfGrid.Selection.Top])='' then Exit;
  ModalResult := MROK;
end;

procedure TfrmSelectFormer.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSelectFormer.frfGridDblClick(Sender: TObject);
begin
  inherited;
  btnOK.Click;
end;

end.
