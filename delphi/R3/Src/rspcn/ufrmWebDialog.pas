unit ufrmWebDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzPanel, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  AppWebUpdater;

type
  TfrmWebDialog = class(TForm)
    pnlAddressBar: TPanel;
    Image2: TImage;
    Image3: TImage;
    RzLabel1: TRzLabel;
    Image1: TImage;
    RzFormShape1: TRzFormShape;
    btnClose: TRzBmpButton;
    RzPanel3: TRzPanel;
    RzBmpButton4: TRzBmpButton;
    btnWindow: TRzBmpButton;
    WebUpdater1: TWebUpdater;
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmWebDialog.btnCloseClick(Sender: TObject);
begin
  close;
end;

end.
