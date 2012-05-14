unit ufrmPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls;

type
  TfrmPassword = class(TForm)
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;
function InputRzBox(_Caption,_Title:string;var value:string):boolean;
function InputPsBox(_Caption,_Title:string;var value:string):boolean;
implementation

{$R *.dfm}
function InputPsBox(_Caption,_Title:string;var value:string):boolean;
begin
  with TfrmPassword.Create(Application.MainForm) do
    begin
      Caption := _Caption;
      Label1.Caption := _Title;
      MaskEdit1.Text := Value;
      MaskEdit1.PasswordChar := '*';
      result := (ShowModal=MROK);
      if result then
         value := MaskEdit1.Text;
    end;
end;
function InputRzBox(_Caption,_Title:string;var value:string):boolean;
begin
  with TfrmPassword.Create(Application.MainForm) do
    begin
      Caption := _Caption;
      Label1.Caption := _Title;
      MaskEdit1.Text := Value;
      MaskEdit1.PasswordChar := #0;
      result := (ShowModal=MROK);
      if result then
         value := MaskEdit1.Text;
    end;
end;
procedure TfrmPassword.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmPassword.Button1Click(Sender: TObject);
begin
  ModalResult := MROK;
end;

end.
