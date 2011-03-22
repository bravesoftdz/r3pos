
unit ufrmLogo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, jpeg,ZdbFactory,Registry, ComCtrls;

type
  TfrmLogo = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Image3: TImage;
  private
  public
    procedure ShowPostion(Postion:Integer;Caption:String);
    { Public declarations }
    procedure Show;
  end;
var frmLogo:TfrmLogo;
implementation

{$R *.DFM}

procedure TfrmLogo.Show;
begin
  inherited Show;
  Update;
end;

procedure TfrmLogo.ShowPostion(Postion: Integer; Caption: String);
begin
  ProgressBar1.Visible := True;
  ProgressBar1.Position := Postion;
  Label1.Caption := Caption;
  Label1.Update;
end;

initialization
finalization
end.

