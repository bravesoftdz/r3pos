unit ufrmWebDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzBmpBtn, RzForms, jpeg, ExtCtrls, RzPanel;

type
  TfrmWebDialog = class(TForm)
    pnlAddressBar: TPanel;
    Image1: TImage;
    Image3: TImage;
    RzFormShape1: TRzFormShape;
    Image2: TImage;
    RzBmpButton2: TRzBmpButton;
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    procedure RzBmpButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmWebDialog.RzBmpButton2Click(Sender: TObject);
begin
  close;
end;

end.
