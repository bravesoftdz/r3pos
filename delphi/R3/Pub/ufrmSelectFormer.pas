unit ufrmSelectFormer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, RzTabs, RzButton,
  Grids, RzGrids,ZDataSet;

type
  TfrmSelectFormer = class(TfrmBasic)
    RzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPanel2: TRzPanel;
    Panel1: TPanel;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    RzPanel1: TRzPanel;
    frfGrid: TRzStringGrid;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Load(filename:string);
    class function SelectFormer(Owner:TForm;fname:string):string;
  end;

implementation

uses uGlobal;

{$R *.dfm}

{ TfrmSelectFormer }

procedure TfrmSelectFormer.Load(filename:string);
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
          if copy(s,1,length(filename)+1)=filename+'_' then
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
  if not Global.RemoteFactory.Connected then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select frfFileTitle from SYS_FASTFILE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and frfFileName like '''+filename+'%''';
    Global.RemoteFactory.Open(rs);
    rs.first;
    while not rs.eof do
      begin
        if w >= frfGrid.RowCount then frfGrid.RowCount := frfGrid.RowCount + 1;
        frfGrid.Cells[0,w] := rs.Fields[0].AsString+'(×Ô¶¨Òå)';
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

class function TfrmSelectFormer.SelectFormer(Owner: TForm;
  fname: string): string;
begin
  with TfrmSelectFormer.Create(Owner) do
    begin
      try
        Load(fname);
        result := '';
        if ShowModal=MROK then
           begin
             result := fname+'_'+frfGrid.Cells[0,frfGrid.Selection.Top];
           end;
      finally
        free;
      end;
    end;
end;

procedure TfrmSelectFormer.btnOKClick(Sender: TObject);
begin
  inherited;
  if trim(frfGrid.Cells[0,frfGrid.Selection.Top])='' then Exit;
  ModalResult := MROK;
end;

end.
