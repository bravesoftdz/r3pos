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
    procedure DoAction(Act:PIEAction);override;
  end;

implementation

{$R *.dfm}

{ TfrmRimIEBrowser }

procedure TfrmRimIEBrowser.DoAction(Act: PIEAction);
begin
  inherited;

end;

end.
