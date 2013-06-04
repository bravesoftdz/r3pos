unit ufrmDropForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, ZBase, dllApi;

type
  TfrmDropForm = class(TForm)
    RzPanel1: TRzPanel;
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    Fdroped: boolean;
    procedure Setdroped(const Value: boolean);
  protected
    SaveObj:TRecord_;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function showForm:boolean;virtual;
    function DropForm(control:TWinControl;var AObj:TRecord_):boolean;virtual;
    function Filter(s:string):boolean;virtual;
    function Find(keyValue:string):boolean;virtual;
    property droped:boolean read Fdroped write Setdroped;
  end;

implementation

{$R *.dfm}

{ TfrmDropForm }

function TfrmDropForm.DropForm(control: TWinControl;var AObj:TRecord_): boolean;
procedure AdjustDropDownForm(AControl : TControl; HostControl: TControl);
var
   WorkArea: TRect;
   HostP, PDelpta: TPoint;
begin                          //设置下拉窗口位置。
{$IFDEF CIL}
   SystemParametersInfo(SPI_GETWORKAREA,0,WorkArea,0);
{$ELSE}
   SystemParametersInfo(SPI_GETWORKAREA,0,@WorkArea,0);
{$ENDIF}
   HostP := HostControl.ClientToScreen(Point(0,0));
   PDelpta := AControl.ClientToScreen(Point(0,0));
   if AControl.Left<> HostP.x+1 then
      AControl.Left := HostP.x+1;
   if AControl.Top<> HostP.y + HostControl.Height then
      AControl.Top := HostP.y + HostControl.Height;
   if (AControl.Width > WorkArea.Right - WorkArea.Left) then
     if (AControl.Width <> (WorkArea.Right - WorkArea.Left)) then
        AControl.Width := WorkArea.Right - WorkArea.Left;
   if (AControl.Left + AControl.Width > WorkArea.Right) then
     if (AControl.Left <> (WorkArea.Right - AControl.Width)) then
        AControl.Left := WorkArea.Right - AControl.Width;
   if (AControl.Left < WorkArea.Left) then
     if (AControl.Left <> WorkArea.Left) then
        AControl.Left := WorkArea.Left;
   if (AControl.Top + AControl.Height > WorkArea.Bottom) then
   begin
     if (HostP.y - WorkArea.Top > WorkArea.Bottom - HostP.y - HostControl.Height)  then
       if AControl.Top <> (HostP.y - AControl.Height) then
          AControl.Top := HostP.y - AControl.Height;
   end;
   if (AControl.Top < WorkArea.Top) then
   begin
     if AControl.Height <> (AControl.Height - (WorkArea.Top - AControl.Top)) then
        AControl.Height := AControl.Height - (WorkArea.Top - AControl.Top);
     if AControl.Top <> WorkArea.Top then
        AControl.Top := WorkArea.Top;
   end;
   if (AControl.Top + AControl.Height > WorkArea.Bottom) then
   begin
     if AControl.Height <> (WorkArea.Bottom - AControl.Top) then
        AControl.Height := WorkArea.Bottom - AControl.Top;
   end;
end;
var Msg:TMsg;
begin
  AdjustDropDownForm(self,control);
  SaveObj := AObj;
  ModalResult := mrNone;
  showForm;
  Fdroped := true;
  try
    while (ModalResult = mrNone) and Visible and droped do
      begin
        if Application.Terminated then Exit;
        if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
          begin
            if Msg.Message <> WM_QUIT then
              begin
                TranslateMessage(Msg);
                DispatchMessage(Msg);
                sleep(1);
              end;
          end;
      end;
    result := (ModalResult = mrOk);
    Close;
    if Control.CanFocus then Control.SetFocus;
  finally
    droped := false;
  end;
end;

function TfrmDropForm.Filter(s: string): boolean;
begin

end;

function TfrmDropForm.Find(keyValue: string): boolean;
begin

end;

function TfrmDropForm.showForm: boolean;
begin
  show;
end;

procedure TfrmDropForm.FormDeactivate(Sender: TObject);
begin
  close;
  droped := false;
end;

procedure TfrmDropForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then
     begin
       Close;
       droped := false;
     end;
end;

constructor TfrmDropForm.Create(AOwner: TComponent);
begin
  inherited;
  setWindowLong(handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);

end;

destructor TfrmDropForm.Destroy;
begin

  inherited;
end;

procedure TfrmDropForm.Setdroped(const Value: boolean);
begin
  Fdroped := Value;
end;

end.
