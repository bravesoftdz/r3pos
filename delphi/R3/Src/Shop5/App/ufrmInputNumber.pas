unit ufrmInputNumber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, ActnList, Menus, RzTabs, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls;

type
  TfrmInputNumber = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    lblInput: TLabel;
    edtInput: TcxTextEdit;
    procedure btnOkClick(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function ShowDialog(AOwner:TForm;var Num:Currency):boolean;
  end;

implementation
uses uFnUtil;
{$R *.dfm}

class function TfrmInputNumber.ShowDialog(AOwner: TForm;
  var Num: Currency): boolean;
begin
  with TfrmInputNumber.Create(AOwner) do
  begin
    edtInput.EditValue := Num;
    if ShowModal = mrOk then
    begin
       Num := edtInput.EditValue;
       Result := True;
    end;
  end;
end;

procedure TfrmInputNumber.btnOkClick(Sender: TObject);
begin
  inherited;
  if not FnString.IsNumberChar(Trim(edtInput.Text)) then
     Raise Exception.Create('"'+Trim(edtInput.Text)+'"中存在非数字字符!');
  ModalResult := mrOk;
end;

procedure TfrmInputNumber.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  ModalResult := mrIgnore;
end;

procedure TfrmInputNumber.FormShow(Sender: TObject);
begin
  inherited;
  edtInput.SelectAll;
  if edtInput.CanFocus then edtInput.SetFocus;
end;

end.
