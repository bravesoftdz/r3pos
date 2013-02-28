unit ufrmWebDialogForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebForm, ExtCtrls, RzPanel, pngimage;

type
  TfrmWebDialogForm = class(TfrmWebForm)
    bkgImage: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmWebDialogForm.FormCreate(Sender: TObject);
begin
  inherited;
  bkgImage.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'images\bkg.png'); 
end;

end.
