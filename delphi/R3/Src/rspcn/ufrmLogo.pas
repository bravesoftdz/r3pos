unit ufrmLogo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, RzLabel, ExtCtrls, RzBckgnd, RzPanel;

type
  TfrmLogo = class(TForm)
    webForm: TRzPanel;
    RzBackground1: TRzBackground;
    RzPanel1: TRzPanel;
    Image2: TImage;
    label1: TRzLabel;
  private
    FhWnd: THandle;
    FshowCaption: string;
    procedure SethWnd(const Value: THandle);
    procedure SetshowCaption(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    procedure ajustPostion;virtual;
    procedure ShowForm;virtual;
    property hWnd:THandle read FhWnd write SethWnd;
    property showCaption:string read FshowCaption write SetshowCaption;
  end;

var
  frmLogo: TfrmLogo;

implementation

{$R *.dfm}

{ TfrmLogo }

procedure TfrmLogo.ajustPostion;
var
  Rect:TRect;
begin
  Windows.GetClientRect(hWnd, Rect);
  SetBounds(0,0,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
  RzPanel1.Left := (webForm.Width - RzPanel1.Width) div 2 -1;
end;

procedure TfrmLogo.SethWnd(const Value: THandle);
begin
  FhWnd := Value;
  windows.SetParent(Handle,Value);
end;

procedure TfrmLogo.SetshowCaption(const Value: string);
begin
  FshowCaption := Value;
  label1.Caption := Value;
  label1.Update;
end;

procedure TfrmLogo.ShowForm;
begin
  show;
  ajustPostion;
  Update;
end;

end.
