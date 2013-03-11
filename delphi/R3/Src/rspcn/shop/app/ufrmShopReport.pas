unit ufrmShopReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzButton,
  Grids, DBGridEh, ComCtrls, RzTreeVw, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, RzTabs,
  TeEngine, Series, TeeProcs, Chart;

type
  TfrmShopReport = class(TfrmWebToolForm)
    lblCaption: TRzLabel;
    PageControl: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPanel11: TRzPanel;
    RzPanel13: TRzPanel;
    RzPanel16: TRzPanel;
    Label8: TLabel;
    Label9: TLabel;
    dateFlag: TcxComboBox;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    btnNav: TRzBitBtn;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel7: TRzPanel;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzToolButton3: TRzToolButton;
    RzToolButton4: TRzToolButton;
    DBGridEh1: TDBGridEh;
    RzPanel1: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzToolbar1: TRzToolbar;
    RzToolButton5: TRzToolButton;
    Chart1: TChart;
    Series1: TBarSeries;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmShopReport: TfrmShopReport;

implementation

{$R *.dfm}

{ TfrmShopReport }

constructor TfrmShopReport.Create(AOwner: TComponent);
var
  i:integer;
begin
  inherited;
  for i:=0 to PageControl.PageCount - 1 do PageControl.Pages[i].TabVisible := false;
  PageControl.ActivePageIndex := 0;
end;

destructor TfrmShopReport.Destroy;
begin

  inherited;
end;

initialization
  RegisterClass(TfrmShopReport);
finalization
  UnRegisterClass(TfrmShopReport);
end.
