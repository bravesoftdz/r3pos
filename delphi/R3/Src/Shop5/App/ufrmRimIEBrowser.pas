unit ufrmRimIEBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ImgList, ActnList, Menus, RzTabs, OleCtrls,
  SHDocVw, ExtCtrls, RzPanel;

type
  TfrmRimIEBrowser = class(TfrmIEWebForm)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure OpenUrl(url:string);
  end;

implementation

{$R *.dfm}

{ TfrmRimIEBrowser }

procedure TfrmRimIEBrowser.OpenUrl(url: string);
begin
  FormStyle := fsMDIChild;
  WindowState := wsMaximized;
  BringToFront;
  inherited Open(url);
end;

end.
