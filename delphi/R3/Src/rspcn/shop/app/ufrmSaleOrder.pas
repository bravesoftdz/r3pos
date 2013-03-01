unit ufrmSaleOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmOrderForm, RzButton, RzPanel, cxTextEdit, cxDropDownEdit,
  cxCalendar, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, StdCtrls, RzLabel, ExtCtrls, RzBmpBtn,
  RzBorder, RzTabs, RzStatus, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmSaleOrder = class(TfrmOrderForm)
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn3: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RzBitBtn6: TRzBitBtn;
    TabSheet2: TRzTabSheet;
    edtCLIENT_ID: TzrComboBoxList;
    edtREMARK: TcxTextEdit;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    edtSALES_DATE: TcxDateEdit;
    RzPanel8: TRzPanel;
    edtGUIDE_USER: TzrComboBoxList;
    RzPanel9: TRzPanel;
    cxTextEdit1: TcxTextEdit;
    RzPanel10: TRzPanel;
    cxTextEdit2: TcxTextEdit;
    RzPanel11: TRzPanel;
    cxTextEdit3: TcxTextEdit;
    RzLabel2: TRzLabel;
    RzBorder1: TRzBorder;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSaleOrder: TfrmSaleOrder;

implementation

{$R *.dfm}

initialization
  RegisterClass(TfrmSaleOrder);
finalization
  UnRegisterClass(TfrmSaleOrder);
end.
