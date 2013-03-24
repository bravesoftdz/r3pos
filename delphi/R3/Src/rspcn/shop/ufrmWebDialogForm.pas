unit ufrmWebDialogForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebForm, ExtCtrls, RzPanel, pngimage, RzBckgnd;

type
  TfrmWebDialogForm = class(TfrmWebForm)
    RzBackground1: TRzBackground;
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
//  if fileExists(ExtractFilePath(Application.ExeName)+'\images\bkg.png') then
//     bkgImage.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'\images\bkg.png');
end;

end.
