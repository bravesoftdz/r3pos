unit ufrmWebForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel,DbGridEh;

type
  TfrmWebForm = class(TForm)
    ScrollBox: TScrollBox;
    webForm: TRzPanel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FhWnd: THandle;
    procedure SethWnd(const Value: THandle);
    procedure OnEnterPress(CurrentForm: TForm; Key: Char);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ajustPostion;virtual;
    procedure showForm;virtual;
    property hWnd:THandle read FhWnd write SethWnd;
  end;
  
implementation
uses dllApi,udllShopUtil;
{$R *.dfm}

{ TForm1 }

procedure TfrmWebForm.OnEnterPress(CurrentForm: TForm; Key: Char);
begin
  with CurrentForm do
  begin
    if not Visible then Exit;
    if (Key = #13) then
    begin
      if (ActiveControl=nil) or
         not ((ActiveControl.ClassNameIs('TcxCustomInnerMemo')) or
              (ActiveControl is TDbGridEh)
              )
      then
      begin
        SendMessage(handle, WM_NEXTDLGCTL, 0, 0);
        while (ActiveControl.ClassNameIs('TcxCustomInnerMemo')) do
           SendMessage(handle, WM_NEXTDLGCTL, 0, 0);
      end;
    end;
  end;
end;
procedure TfrmWebForm.ajustPostion;
var
  Rect:TRect;
begin
  Windows.GetClientRect(hWnd, Rect);
//  Align := alClient;
//  ScrollBox.DisableAlign;
  try
//    ScrollBox.Align := alClient;
    SetBounds(0,0,Rect.Right-Rect.Left,Rect.Bottom-Rect.Top);
//    if webForm.Height>ScrollBox.ClientHeight then Rect.top := 0
//    else
//       Rect.top := (ScrollBox.ClientHeight - webForm.height+1) div 2;
//
//    if webForm.Width>ScrollBox.ClientWidth then Rect.left := 0
//    else
//       Rect.Left := (ScrollBox.ClientWidth - webForm.Width-1) div 2;
//    ScrollBox.AutoScroll := true;
  finally
//    ScrollBox.EnableAlign;
  end;
end;

procedure TfrmWebForm.SethWnd(const Value: THandle);
begin
  FhWnd := Value;
  windows.SetParent(Handle,Value);
end;

procedure TfrmWebForm.showForm;
begin
  show;
  ajustPostion;
end;

procedure TfrmWebForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  OnEnterPress(Self,Key);
end;

procedure TfrmWebForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

constructor TfrmWebForm.Create(AOwner: TComponent);
begin
  inherited;
  setWindowLong(handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
  Initform(self);
end;

destructor TfrmWebForm.Destroy;
begin
  Freeform(self);
  inherited;
end;

end.
 