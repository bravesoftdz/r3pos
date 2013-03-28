unit ufrmWebDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzBmpBtn, RzForms, jpeg, ExtCtrls, RzPanel, DB, DBGridEh;

type
  TfrmWebDialog = class(TForm)
    pnlAddressBar: TPanel;
    Image1: TImage;
    Image3: TImage;
    RzFormShape1: TRzFormShape;
    Image2: TImage;
    RzPanel1: TRzPanel;
    RzBmpButton2: TRzBmpButton;
    procedure RzBmpButton2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FdbState: TDataSetState;
    procedure OnEnterPress(CurrentForm: TForm; Key: Char);
  protected
    procedure SetdbState(const Value: TDataSetState); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    property dbState:TDataSetState read FdbState write SetdbState;
  end;

implementation

uses udllShopUtil,dllApi;

{$R *.dfm}

constructor TfrmWebDialog.Create(AOwner: TComponent);
begin
  inherited;
  setWindowLong(handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
  Initform(self);
end;

destructor TfrmWebDialog.Destroy;
begin
  Freeform(self);
  inherited;
end;

procedure TfrmWebDialog.RzBmpButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmWebDialog.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  SetFormEditStatus(self,Value);
end;

procedure TfrmWebDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  OnEnterPress(Self,Key);
end;

procedure TfrmWebDialog.OnEnterPress(CurrentForm: TForm; Key: Char);
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

procedure TfrmWebDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=27 then Close;
end;

end.
