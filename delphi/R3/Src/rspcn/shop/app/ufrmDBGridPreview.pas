unit ufrmDBGridPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzBmpBtn,
  PrViewEh, PrnDbgeh,DBGridEhImpExp;

type
  TfrmDBGridPreview = class(TfrmWebToolForm)
    RzPanel12: TRzPanel;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    RzBmpButton2: TRzBmpButton;
    btnPrior: TRzBmpButton;
    lblCaption: TRzLabel;
    PreviewBox1: TPreviewBox;
    SaveDialog1: TSaveDialog;
    procedure btnPriorClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
  private
    FPrintDBGridEh: TPrintDBGridEh;
    procedure SetPrintDBGridEh(const Value: TPrintDBGridEh);
    { Private declarations }
  public
    { Public declarations }
    class procedure Preview(AOwner:TForm;PrintGrid:TPrintDBGridEh);
    class procedure Print(AOwner:TForm;PrintGrid:TPrintDBGridEh);
    property PrintDBGridEh:TPrintDBGridEh read FPrintDBGridEh write SetPrintDBGridEh;
  end;

var
  frmDBGridPreview: TfrmDBGridPreview;

implementation

{$R *.dfm}

procedure TfrmDBGridPreview.btnPriorClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDBGridPreview.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  PreviewBox1.Printer.Abort;
  PreviewBox1.Printer.PrinterSetupOwner := nil;
  PreviewBox1.OnOpenPreviewer := nil;
  Action := cafree;
end;

procedure TfrmDBGridPreview.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  if PrintDBGridEh.PrinterSetupDialog then
     PrintDBGridEh.PrintTo(PreviewBox1.Printer);

end;

procedure TfrmDBGridPreview.SetPrintDBGridEh(const Value: TPrintDBGridEh);
begin
  FPrintDBGridEh := Value;
end;

procedure TfrmDBGridPreview.RzBmpButton3Click(Sender: TObject);
begin
  inherited;
  PreviewBox1.PrintDialog;

end;

procedure TfrmDBGridPreview.RzBmpButton2Click(Sender: TObject);
var Stream: TMemoryStream;
begin
  inherited;
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '已经存在，是否覆盖它？'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        exit;
      DeleteFile(SaveDialog1.FileName);
    end;
    Stream := TMemoryStream.Create;
    try
      Stream.Position := 0;
      if ExtractFileExt(SaveDialog1.FileName)='.xls' then
      begin
        with TDBGridEhExportAsXLS.Create do
        begin
          try
            DBGridEh := PrintDBGridEh.DBGridEh;
            ExportToStream(Stream, True);
          finally
            Free;
          end;
        end;
      end
      else
      begin
        with TDBGridEhExportAsHTML.Create do
        begin
          try
            DBGridEh := PrintDBGridEh.DBGridEh;
            ExportToStream(Stream, True);
          finally
            Free;
          end;
        end;
      end;
      Stream.SaveToFile(SaveDialog1.FileName);
    finally
      Stream.Free;
    end;
  end;
end;

class procedure TfrmDBGridPreview.Preview(AOwner:TForm;PrintGrid: TPrintDBGridEh);
begin
  with TfrmDBGridPreview.Create(AOwner) do
    begin
      lblCaption.Caption := PrintGrid.PageHeader.CenterText.Text;
      hWnd := AOwner.Handle;
      ShowForm;
      BringtoFront;
      PrintDBGridEh :=  PrintGrid;
      PreviewBox1.Printer.PrinterSetupOwner := PrintGrid.DBGridEh;
//      PreviewBox1.Printer.OnPrinterSetupDialog := actPrintSetupExecute;
      PrintDBGridEh.PrintTo(PreviewBox1.Printer);
    end;
end;

class procedure TfrmDBGridPreview.Print(AOwner: TForm;
  PrintGrid: TPrintDBGridEh);
begin
  with TfrmDBGridPreview.Create(AOwner) do
    begin
      PrintDBGridEh :=  PrintGrid;
      PreviewBox1.Printer.PrinterSetupOwner := PrintGrid.DBGridEh;
      PrintDBGridEh.PrintTo(PreviewBox1.Printer);
      PreviewBox1.PrintDialog;
    end;
end;

end.
