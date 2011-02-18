unit ufrmCardNoInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, StdCtrls, cxControls, cxContainer,
  cxEdit, cxTextEdit, ExtCtrls, RzPanel;

type
  TfrmCardNoInput = class(TfrmBasic)
    RzPanel1: TRzPanel;
    edtCardNo: TcxTextEdit;
    Label3: TLabel;
    procedure edtCardNoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetCardNo(Owner:TForm):string;
    class function GetPassWrd(Owner:TForm):string;
  end;

implementation

{$R *.dfm}

{ TfrmCardNoInput }

class function TfrmCardNoInput.GetCardNo(Owner:TForm): string;
begin
  with TfrmCardNoInput.Create(Owner) do
    begin
      try
        Label3.Caption := '«Î ‰»Îƒ„µƒø®∫≈';
        if ShowModal=MROK then
           result := edtCardNo.Text
        else
           result := '';
      finally
        free;
      end;
    end;
end;

procedure TfrmCardNoInput.edtCardNoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       ModalResult := MROK;
     end;
end;

class function TfrmCardNoInput.GetPassWrd(Owner: TForm): string;
begin
  with TfrmCardNoInput.Create(Owner) do
    begin
      try
        Label3.Caption := '«Î ‰»Îƒ„µƒ√‹¬Î';
        if ShowModal=MROK then
           result := edtCardNo.Text
        else
           result := '';
      finally
        free;
      end;
    end;
end;

end.
