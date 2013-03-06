unit ufrmGoodsStroage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, RzButton,
  cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, ComCtrls, RzTreeVw, Grids, DBGridEh, cxButtonEdit;

type
  TfrmGoodsStroage = class(TfrmWebToolForm)
    lblCaption: TRzLabel;
    RzPanel15: TRzPanel;
    serachText: TEdit;
    btnNav: TRzBitBtn;
    RzPanel11: TRzPanel;
    RzPanel13: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzTreeView1: TRzTreeView;
    DBGridEh2: TDBGridEh;
    RzPanel6: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    btnPrint: TRzBitBtn;
    btnPreview: TRzBitBtn;
    RzBitBtn3: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RzBitBtn5: TRzBitBtn;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzToolButton3: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzToolButton4: TRzToolButton;
    RzPanel1: TRzPanel;
    sortDrop: TcxButtonEdit;
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses ufrmSortDropFrom;
{$R *.dfm}

procedure TfrmGoodsStroage.sortDropPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  frmSortDropFrom.DropForm(sortDrop);
end;

initialization
  RegisterClass(TfrmGoodsStroage);
finalization
  UnRegisterClass(TfrmGoodsStroage);
end.
