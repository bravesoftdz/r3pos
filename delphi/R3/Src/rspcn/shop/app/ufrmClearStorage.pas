unit ufrmClearStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxCheckBox;

type
  TfrmClearStorage = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel4: TRzLabel;
    Cancel: TRzBmpButton;
    Save: TRzBmpButton;
    chkContinue: TcxCheckBox;
    procedure SaveClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkContinuePropertiesChange(Sender: TObject);
    procedure RzLabel4Click(Sender: TObject);
  public
    class function ShowDialog(AOwner:TForm):boolean;
  end;

implementation

{$R *.dfm}

class function TfrmClearStorage.ShowDialog(AOwner: TForm): boolean;
begin
  with TfrmClearStorage.Create(AOwner) do
    begin
      try
        result := (ShowModal = MROK);
      finally
        Free;
      end;
    end;
end;

procedure TfrmClearStorage.SaveClick(Sender: TObject);
begin
  inherited;
  ModalResult := MROK;
end;

procedure TfrmClearStorage.CancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmClearStorage.FormShow(Sender: TObject);
begin
  inherited;
  chkContinue.Checked := false;
  Save.Enabled := false;
end;

procedure TfrmClearStorage.chkContinuePropertiesChange(Sender: TObject);
begin
  inherited;
  if chkContinue.Checked then
     Save.Enabled := true
  else
     Save.Enabled := false;
end;

procedure TfrmClearStorage.RzLabel4Click(Sender: TObject);
begin
  inherited;
  if chkContinue.Checked then
     chkContinue.Checked := false
  else
     chkContinue.Checked := true;
end;

end.
