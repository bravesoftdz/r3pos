unit ufrmAdv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDesk, StdCtrls, SHDocVw, MSHTML, ActnList, OleCtrls, ufrmBasic;

type
  TfrmAdv = class(TfrmBasic)
    IEAdvBrowser: TWebBrowser;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  public
    class procedure LoadAdv;
  end;

var AdvShowed : integer;

implementation

{$R *.dfm}

class procedure TfrmAdv.LoadAdv;
var
    url : string;
    Doc : IHTMLDocument2;
    Ec : IHTMLElementCollection;
    iframe : DispHTMLIFrame;
    _Start : int64;
begin
  AdvShowed := 2;
  with TfrmAdv.Create(application.MainForm) do
  begin
    if not FileExists(ExtractFilePath(ParamStr(0))+'adv\adv2.html') then Exit;
    IEAdvBrowser.Navigate(ExtractFilePath(ParamStr(0))+'adv\adv2.html');
    Show;
  end;
end;

procedure TfrmAdv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

initialization
  AdvShowed := 0;

end.
