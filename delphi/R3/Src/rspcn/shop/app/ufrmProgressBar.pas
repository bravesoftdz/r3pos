unit ufrmProgressBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzPanel, RzBmpBtn, RzForms, jpeg, ExtCtrls, ZDataSet,ZBase,
  RzButton, RzPrgres, StdCtrls, RzLabel, RzBorder;


type
  TfrmProgressBar = class(TfrmWebDialog)
    ProgressBar1: TRzProgressBar;
    RzLabel26: TRzLabel;
  private
    FShowTitle: string;
    FPosition: integer;
    procedure SetShowTitle(const Value: string);
    procedure SetPosition(const Value: integer);
    procedure SetMax(const Value: integer);

  protected

  public
    procedure ShowPostion(Postion:Integer;Caption:String);
    property ShowTitle:string read FShowTitle write SetShowTitle;
    property Position:integer read FPosition write SetPosition;
  end;

implementation

uses udataFactory,utokenFactory,uFnUtil,objCommon,udllGlobal;

{$R *.dfm}

{ TfrmProgressBar }
procedure TfrmProgressBar.SetMax(const Value: integer);
begin
  
  Update;
end;

procedure TfrmProgressBar.SetPosition(const Value: integer);
begin
  FPosition := Value;
  ProgressBar1.Visible := True;
  ProgressBar1.Percent:=value;
  Update;
end;

procedure TfrmProgressBar.SetShowTitle(const Value: string);
begin
  FShowTitle := Value;
  Update;
end;

procedure TfrmProgressBar.ShowPostion(Postion: Integer; Caption: String);
begin
  BringToFront;
  ProgressBar1.Visible := True;
  ProgressBar1.Percent := Postion;
  Update;
end;

end.
