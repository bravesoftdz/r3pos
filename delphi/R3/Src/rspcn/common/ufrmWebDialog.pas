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
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses udllShopUtil;
{$R *.dfm}

constructor TfrmWebDialog.Create(AOwner: TComponent);
begin
  inherited;
  Initform(self);
end;

destructor TfrmWebDialog.Destroy;
begin
  Freeform(self);
  inherited;
end;

procedure TfrmWebDialog.RzBmpButton2Click(Sender: TObject);
begin
  close;
end;

end.
