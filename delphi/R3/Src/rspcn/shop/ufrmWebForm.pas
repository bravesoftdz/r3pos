unit ufrmWebForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel;

type
  TfrmWebForm = class(TForm)
    ScrollBox: TScrollBox;
    webForm: TRzPanel;
    RzPanel1: TRzPanel;
  private
    FhWnd: THandle;
    procedure SethWnd(const Value: THandle);
    { Private declarations }
  public
    { Public declarations }
    procedure ajustPostion;virtual;
    procedure showForm;virtual;
    property hWnd:THandle read FhWnd write SethWnd;
    
  end;
  
implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmWebForm.ajustPostion;
var
  Rect:TRect;
begin
  Windows.GetClientRect(hWnd, Rect);
  Align := alClient;
  ScrollBox.DisableAlign;
  try
    ScrollBox.Align := alClient;
    SetBounds(left,top,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
    if webForm.Height>ScrollBox.ClientHeight then webForm.top := 0
    else
       webForm.top := (ScrollBox.ClientHeight - webForm.height+1) div 2;

    if webForm.Width>ScrollBox.ClientWidth then webForm.left := 0
    else
       webForm.Left := (ScrollBox.ClientWidth - webForm.Width-1) div 2;
    ScrollBox.AutoScroll := true;
  finally
    ScrollBox.EnableAlign;
  end;
end;

procedure TfrmWebForm.SethWnd(const Value: THandle);
begin
  FhWnd := Value;
end;

procedure TfrmWebForm.showForm;
begin
  show;
  ajustPostion;
end;

end.
 