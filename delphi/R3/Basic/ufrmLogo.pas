
unit ufrmLogo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, jpeg,ZdbFactory,Registry, ComCtrls, RzForms, uRcFactory;

type
  TfrmLogo = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Image3: TImage;
    RzFormShape1: TRzFormShape;
    procedure FormCreate(Sender: TObject);
  private
    FShowTitle: string;
    FPosition: integer;
    procedure SetShowTitle(const Value: string);
    procedure SetPosition(const Value: integer);
  public
    procedure ShowPostion(Postion:Integer;Caption:String);
    { Public declarations }
    procedure LoadPic32;
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
  BringToFront;
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
  frmLogo := self;
  LoadPic32;
  if FileExists(ExtractFilePath(ParamStr(0))+'flash.jpg') then
     Image3.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'flash.jpg');
end;

procedure TfrmLogo.SetShowTitle(const Value: string);
begin
  if not Visible then Exit;
  BringToFront;
  FShowTitle := Value;
  Label1.Caption := Value;
  Update;
end;

procedure TfrmLogo.SetPosition(const Value: integer);
begin
  if not Visible then Exit;
  FPosition := Value;
  BringToFront;
  ProgressBar1.Visible := True;
  ProgressBar1.Position := Value;
  Update;
end;

procedure TfrmLogo.LoadPic32;
begin
  Image3.Picture.Graphic := rcFactory.GetJpeg('public_logo');
end;

initialization
  frmLogo := nil;
finalization
end.

