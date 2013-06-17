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
    procedure SethWnd(const Value: THandle);
    { Private declarations }
  public
    { Public declarations }
    procedure ajustPostion;virtual;
    procedure ShowForm;virtual;
    property hWnd:THandle read FhWnd write SethWnd;
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

procedure TfrmLogo.ShowForm;
begin
  show;
  ajustPostion;
end;

end.
