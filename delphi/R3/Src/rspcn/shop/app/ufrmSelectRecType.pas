unit ufrmSelectRecType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, cxRadioGroup;

type
  TfrmSelectRecType = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    btnSave: TRzBmpButton;
    btnCancel: TRzBmpButton;
    RzLabel26: TRzLabel;
    Recovery_1: TcxRadioButton;
    Recovery_2: TcxRadioButton;
    Recovery_3: TcxRadioButton;
    RzLabel53: TRzLabel;
    Bevel8: TBevel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  public
    class function ShowDialog(AOwner:TForm):string;
  end;

implementation

{$R *.dfm}

class function TfrmSelectRecType.ShowDialog(AOwner:TForm):string;
begin
  with TfrmSelectRecType.Create(AOwner) do
    begin
      try
        result := '';
        if ShowModal = MROK then
           begin
             if Recovery_1.Checked then
                result := '1'
             else if Recovery_2.Checked then
                result := '2'
             else if Recovery_3.Checked then
                result := '3';
           end
      finally
        Free;
      end;
    end;
end;

procedure TfrmSelectRecType.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSelectRecType.btnSaveClick(Sender: TObject);
begin
  inherited;
  ModalResult := MROK;
end;

end.
