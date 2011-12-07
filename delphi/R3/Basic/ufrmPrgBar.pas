unit ufrmPrgBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzForms, RzPrgres, StdCtrls, RzLabel, RzPanel, jpeg;

type
  TfrmPrgBar = class(TForm)
    RzFormShape1: TRzFormShape;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzProgressBar1: TRzProgressBar;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    function GetPrecent: integer;
    function GetWaitHint: string;
    procedure setPrecent(const Value: integer);
    procedure SetWaitHint(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    procedure LoadPic32;
    property Precent:integer read GetPrecent write setPrecent;
    property WaitHint:string read GetWaitHint write SetWaitHint;
  end;

var
  frmPrgBar: TfrmPrgBar;

implementation
uses uRcFactory;
{$R *.dfm}

{ TfrmPrgBar }

function TfrmPrgBar.GetPrecent: integer;
begin
  result := RzProgressBar1.Percent;
end;

function TfrmPrgBar.GetWaitHint: string;
begin
  result := RzLabel1.Caption;
end;

procedure TfrmPrgBar.setPrecent(const Value: integer);
begin
  RzProgressBar1.Percent := Value;
  RzProgressBar1.Update;
end;

procedure TfrmPrgBar.SetWaitHint(const Value: string);
begin
  RzLabel1.Caption := Value;
  RzLabel1.Update;
end;

procedure TfrmPrgBar.FormCreate(Sender: TObject);
begin
  frmPrgBar := self;
end;

procedure TfrmPrgBar.LoadPic32;
begin
  Image1.Picture.Graphic := rcFactory.GetJpeg('s1_prg');
end;

initialization
  frmPrgBar := nil;
end.
