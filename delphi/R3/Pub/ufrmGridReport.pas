unit ufrmGridReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ComCtrls, ToolWin, ExtCtrls, DB,
  ADODB, Grids, DBGridEh, FR_DSet, FR_DBSet, FR_Class;

type
  TfrmGridReport = class(TfrmBasic)
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
    ToolButton12: TToolButton;
    F1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    E1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    F2: TMenuItem;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    rTable: TADODataSet;
    dsrTable: TDataSource;
    actPrint: TAction;
    actPreview: TAction;
    actPrintSetup: TAction;
    actNext: TAction;
    actPrior: TAction;
    actExit: TAction;
    actFind: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton8: TToolButton;
    procedure actPrintSetupExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation
uses udmIcon,ufrmDesinger,uCtrlUtil;
{$R *.dfm}

procedure TfrmGridReport.actPrintSetupExecute(Sender: TObject);
var frmDesinger:TfrmDesigner;
  frReport:TfrReport;
  i:Integer;
begin
  frReport := nil;
  for i:=0 to Self.ComponentCount -1 do
    begin
      if Self.Components[i] is TfrReport then
         begin
           frReport := TfrReport(Components[i]);
         end;
    end;
  frmDesinger:=TfrmDesigner.Create(Self);
  try
    frmDesinger.Form := Self;
    frmDesinger.ShowExecute(frReport,'');
  finally
    frmDesinger.Free;
  end;
end;

procedure TfrmGridReport.actNextExecute(Sender: TObject);
begin
  inherited;
  if rTable.Active then
     rTable.Next;
end;

procedure TfrmGridReport.actPriorExecute(Sender: TObject);
begin
  inherited;
  if rTable.Active then
     rTable.Prior;

end;

procedure TfrmGridReport.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmGridReport.FormCreate(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.InitForm(Self);
  TDbGridEhMark.InitForm(Self);
end;

procedure TfrmGridReport.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(Self);
  TDbGridEhMark.FreeForm(Self);
end;

end.
