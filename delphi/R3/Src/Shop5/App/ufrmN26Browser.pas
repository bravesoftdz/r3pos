unit ufrmN26Browser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ImgList, ActnList, Menus, OleCtrls, SHDocVw,
  ExtCtrls, RzPanel;

type
  TfrmN26Browser = class(TfrmIEWebForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IEBrowserTitleChange(Sender: TObject;
      const Text: WideString);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function DoLogin:boolean;
    function OpenUrl(url:string):boolean;
  end;

implementation

{$R *.dfm}

{ TfrmN26Browser }

function TfrmN26Browser.DoLogin: boolean;
begin
  result := true;
end;

function TfrmN26Browser.OpenUrl(url: string): boolean;
begin
  Open(url);
end;

procedure TfrmN26Browser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;

end;

constructor TfrmN26Browser.Create(AOwner: TComponent);
begin
  inherited;
  FormStyle := fsMDIChild;

end;

procedure TfrmN26Browser.IEBrowserTitleChange(Sender: TObject;
  const Text: WideString);
begin
//  inherited;

end;

end.
