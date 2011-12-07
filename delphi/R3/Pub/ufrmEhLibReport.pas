unit ufrmEhLibReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ComCtrls, ToolWin, ExtCtrls,
  PrViewEh, PrnDbgeh,DBGridEh, Grids;
type
  TfrmEhLibReport = class(TfrmBasic)
    CoolBar1: TCoolBar;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton16: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton9: TToolButton;
    actPrint: TAction;
    actExit: TAction;
    actPrintSetup: TAction;
    actFilter: TAction;
    actPrior: TAction;
    actNext: TAction;
    actZoom: TAction;
    actOnePage: TAction;
    actPageWidth: TAction;
    actExport: TAction;
    ToolButton12: TToolButton;
    F1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    E1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    F2: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    PopupMenu1: TPopupMenu;
    HTML1: TMenuItem;
    CSV1: TMenuItem;
    N3: TMenuItem;
    RTF1: TMenuItem;
    SaveDialog1: TSaveDialog;
    PageControl1: TPageControl;
    PreviewBox1: TPreviewBox;
    procedure actNextExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPrintSetupExecute(Sender: TObject);
    procedure PreviewBox1PrinterPreviewChanged(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actExitExecute(Sender: TObject);
    procedure PreviewBox1OpenPreviewer(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
  private
    FPrintDBGridEh: TPrintDBGridEh;
    procedure SetPrintDBGridEh(const Value: TPrintDBGridEh);
    { Private declarations }
  protected
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    procedure Preview(PrintGrid:TPrintDBGridEh);
    property PrintDBGridEh:TPrintDBGridEh read FPrintDBGridEh write SetPrintDBGridEh;
  end;
implementation
{$R *.dfm}
uses RzSplit,DBGridEhImpExp;
{ TfrmEhLibReport }

constructor TfrmEhLibReport.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TfrmEhLibReport.Destroy;
begin

  inherited;
end;

procedure TfrmEhLibReport.Preview (PrintGrid:TPrintDBGridEh);
begin
  PrintDBGridEh :=  PrintGrid;
  PreviewBox1.Printer.PrinterSetupOwner := PrintGrid.DBGridEh;
  PreviewBox1.Printer.OnPrinterSetupDialog := actPrintSetupExecute;
  PrintDBGridEh.PrintTo(PreviewBox1.Printer);
  WindowState := wsMaximized;
  ShowModal;
end;

procedure TfrmEhLibReport.actNextExecute(Sender: TObject);
begin
  PreviewBox1.PageIndex:=Succ(PreviewBox1.PageIndex);
end;

procedure TfrmEhLibReport.actPriorExecute(Sender: TObject);
begin
  PreviewBox1.PageIndex := Pred(PreviewBox1.PageIndex);
end;

procedure TfrmEhLibReport.actPrintExecute(Sender: TObject);
begin
  PreviewBox1.PrintDialog;
end;

procedure TfrmEhLibReport.actPrintSetupExecute(Sender: TObject);
begin
  if PrintDBGridEh.PrinterSetupDialog then
     PrintDBGridEh.PrintTo(PreviewBox1.Printer);
end;

procedure TfrmEhLibReport.PreviewBox1PrinterPreviewChanged(
  Sender: TObject);
begin
  inherited;
  actPrior.Enabled:=PreviewBox1.PageIndex>1;
  actNext.Enabled:=PreviewBox1.PageIndex<PreviewBox1.PageCount;

end;

procedure TfrmEhLibReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  PreviewBox1.Printer.Abort;
  PreviewBox1.Printer.PrinterSetupOwner := nil;
  PreviewBox1.OnOpenPreviewer := nil;
end;

procedure TfrmEhLibReport.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmEhLibReport.PreviewBox1OpenPreviewer(Sender: TObject);
begin
  inherited;
//  if IsIconic(Handle) then ShowWindow(Handle,sw_Restore);
//  BringWindowToTop(Handle);
//  if not Visible then Show;   
end;

procedure TfrmEhLibReport.actExportExecute(Sender: TObject);
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

procedure TfrmEhLibReport.SetPrintDBGridEh(const Value: TPrintDBGridEh);
begin
  FPrintDBGridEh := Value;
end;

end.
