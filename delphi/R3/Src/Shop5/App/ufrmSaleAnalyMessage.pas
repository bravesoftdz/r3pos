unit ufrmSaleAnalyMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, ufrmBasic, ExtCtrls, ActnList, Menus, RzPanel, RzForms, RzBckgnd,
  StdCtrls, jpeg, RzBmpBtn, RzTabs, cxTextEdit, cxDropDownEdit, cxControls, EncDec,
  cxContainer, cxEdit, cxMaskEdit, cxSpinEdit, cxMemo, cxCheckBox,IniFiles, zBase,
  ComCtrls, RzTreeVw, uGodsFactory, uTreeUtil, zDataSet, cxCalendar, DB,
  ZAbstractRODataset, ZAbstractDataset, RzLabel, RzButton;

type
  TfrmSaleAnalyMessage = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzBackground3: TRzBackground;
    RzPanel5: TRzPanel;
    RzPage: TRzPageControl;
    Tab1: TRzTabSheet;
    Tab2: TRzTabSheet;
    RzPnl2: TRzPanel;
    CdsUsing: TZQuery;
    RzPanel2: TRzPanel;
    RzPanel6: TRzPanel;
    RzFormShape1: TRzFormShape;
    Image1: TImage;
    RzPanel8: TRzPanel;
    BtnSort: TRzBitBtn;
    RzPnl1: TRzPanel;
    Image2: TImage;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_EndClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure BtnSortClick(Sender: TObject);
  private
  public
    class function ShowSaleAnalyMsg(AOwner:TForm):boolean;
  end;


implementation
uses uShopGlobal,uGlobal,uSaleAnalyMessage;
{$R *.dfm}

procedure TfrmSaleAnalyMessage.FormCreate(Sender: TObject);
var i:Integer;
begin
  inherited;
  for i := 0 to RzPage.PageCount - 1 do
    begin
      RzPage.Pages[i].TabVisible := False;
    end;
  RzPage.ActivePageIndex := 0;
end;

procedure TfrmSaleAnalyMessage.btn_EndClick(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmSaleAnalyMessage.ShowSaleAnalyMsg(AOwner: TForm): boolean;
var
  SaleAnaly: TSaleAnalyMsg;
begin
  try
    SaleAnaly:=TSaleAnalyMsg.Create;
    SaleAnaly.GetSaleDayMsg;
    SaleAnaly.GetSaleMonthMsg;
    if (SaleAnaly.DayMsg.YDSale_AMT>0) or (SaleAnaly.MonthMsg.LMSale_AMT>0) then
    begin
      with TfrmSaleAnalyMessage.Create(AOwner) do
      begin
        try
          result := (ShowModal=MROK);
        finally
          free;
        end;
      end;
    end;
  finally
    SaleAnaly.Free;
  end;
end;

procedure TfrmSaleAnalyMessage.Image2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmSaleAnalyMessage.BtnSortClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
