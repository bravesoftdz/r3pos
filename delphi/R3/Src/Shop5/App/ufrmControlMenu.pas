unit ufrmControlMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, StdCtrls, Buttons, ExtCtrls,
  RzPanel, RzButton;

type
  TfrmControlMenu = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    Image1: TImage;
    Label1: TLabel;
    cmbPrintStyle: TcxComboBox;
    btnOnceReceipt: TRzBitBtn;
    btnStarPrint: TRzBitBtn;
    btnPrintPreview: TRzBitBtn;
    btnExit: TRzBitBtn;
    procedure btnExitClick(Sender: TObject);
    procedure btnOnceReceiptClick(Sender: TObject);
    procedure btnStarPrintClick(Sender: TObject);
    procedure btnPrintPreviewClick(Sender: TObject);
  private
    { Private declarations }
    Result_Value:String;
  public
    { Public declarations }
    class function ShowDialog(Owner:TForm;PrintStyle:TStringList):String;
  end;

var
  frmControlMenu: TfrmControlMenu;

implementation

{$R *.dfm}

{ TfrmControlMenu }

class function TfrmControlMenu.ShowDialog(Owner: TForm;PrintStyle:TStringList): String;
begin
  with TfrmControlMenu.Create(Owner) do
    begin
      try
        if PrintStyle.Count > 0 then
          begin
            cmbPrintStyle.Clear;
            cmbPrintStyle.Properties.Items := PrintStyle;
          end;
        cmbPrintStyle.ItemIndex := 0;
        case ShowModal of
          mrOk:Result := Result_Value;
          mrIgnore :Result := '0';
        end;
      finally
        Free;
      end;
    end;
end;

procedure TfrmControlMenu.btnExitClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrIgnore;
end;

procedure TfrmControlMenu.btnOnceReceiptClick(Sender: TObject);
begin
  inherited;
  Result_Value := '1';
  ModalResult := mrOk;
end;

procedure TfrmControlMenu.btnStarPrintClick(Sender: TObject);
begin
  inherited;
  Result_Value := '2'+IntToStr(cmbPrintStyle.ItemIndex);
  ModalResult := mrOk;
end;

procedure TfrmControlMenu.btnPrintPreviewClick(Sender: TObject);
begin
  inherited;
  Result_Value := '3'+IntToStr(cmbPrintStyle.ItemIndex);
  ModalResult := mrOk;
end;

end.
