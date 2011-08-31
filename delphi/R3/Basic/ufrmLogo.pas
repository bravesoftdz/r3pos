
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
    procedure FormCreate(Sender: TObject);
  private
    FShowTitle: string;
    FPosition: integer;
    procedure SetShowTitle(const Value: string);
    procedure SetPosition(const Value: integer);
  public
    procedure ShowPostion(Postion:Integer;Caption:String);
    { Public declarations }
    procedure Show;
    property ShowTitle:string read FShowTitle write SetShowTitle;
    property Position:integer read FPosition write SetPosition;
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
  BringToFront;
  ProgressBar1.Visible := True;
  ProgressBar1.Position := Postion;
  Label1.Caption := Caption;
  Label1.Update;
end;

procedure TfrmLogo.FormCreate(Sender: TObject);
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'flash.jpg') then
     Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'flash.jpg');
end;

procedure TfrmLogo.SetShowTitle(const Value: string);
begin
  if not Visible then Show;
  BringToFront;
  FShowTitle := Value;
  Label1.Caption := Value;
  Update;
end;

procedure TfrmLogo.SetPosition(const Value: integer);
begin
  FPosition := Value;
  BringToFront;
  ProgressBar1.Visible := True;
  ProgressBar1.Position := Value;
  Update;
end;

initialization
finalization
end.

