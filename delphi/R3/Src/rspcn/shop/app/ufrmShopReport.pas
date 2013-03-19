unit ufrmShopReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzButton,
  Grids, DBGridEh, ComCtrls, RzTreeVw, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, RzTabs,
  TeEngine, Series, TeeProcs, Chart, RzBmpBtn, cxRadioGroup, Mask, RzEdit,
  RzSpnEdt, RzBorder, cxButtonEdit, zrComboBoxList;

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
    chart1Panel: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    myChart1: TChart;
    Series1: TBarSeries;
    tool1: TRzPanel;
    chart1: TRzBmpButton;
    cxRadioButton1: TcxRadioButton;
    cxRadioButton2: TcxRadioButton;
    RzBorder1: TRzBorder;
    cxRadioButton3: TcxRadioButton;
    RzPageControl1: TRzPageControl;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
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
    RzToolbar1: TRzToolbar;
    RzToolButton5: TRzToolButton;
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel8: TRzPanel;
    RzToolbar2: TRzToolbar;
    RzToolButton6: TRzToolButton;
    RzToolButton7: TRzToolButton;
    RzSpacer2: TRzSpacer;
    RzToolButton8: TRzToolButton;
    RzToolButton9: TRzToolButton;
    DBGridEh2: TDBGridEh;
    RzToolbar3: TRzToolbar;
    RzToolButton10: TRzToolButton;
    btnPrint: TRzBitBtn;
    btnPreview: TRzBitBtn;
    btnExport: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    edtCLIENT_ID: TzrComboBoxList;
    procedure chart1Click(Sender: TObject);
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

procedure TfrmShopReport.chart1Click(Sender: TObject);
begin
  inherited;
  chart1Panel.Visible := chart1.Down;
  tool1.Top := 0;
end;

initialization
  RegisterClass(TfrmShopReport);
finalization
  UnRegisterClass(TfrmShopReport);
end.
