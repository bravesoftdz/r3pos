unit ufrmCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, RzLabel, RzButton, Grids,
  DBGridEh, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, StdCtrls,
  ComCtrls, RzTreeVw;

type
  TfrmCustomer = class(TfrmWebToolForm)
    RzPanel11: TRzPanel;
    RzPanel13: TRzPanel;
    lblCaption: TRzLabel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    btnNewSort: TRzBitBtn;
    rzTree: TRzTreeView;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzPanel1: TRzPanel;
    Edit1: TEdit;
    btnNav: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    btnPrint: TRzBitBtn;
    btnPreview: TRzBitBtn;
    btnAMOUNT: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RzBitBtn5: TRzBitBtn;
    RzPanel8: TRzPanel;
    sortDrop: TcxButtonEdit;
    RzToolButton3: TRzToolButton;
    RzToolButton4: TRzToolButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustomer: TfrmCustomer;

implementation

{$R *.dfm}

initialization
  RegisterClass(TfrmCustomer);
finalization
  UnRegisterClass(TfrmCustomer);
end.
