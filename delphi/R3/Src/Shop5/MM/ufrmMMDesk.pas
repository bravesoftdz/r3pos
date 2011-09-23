unit ufrmMMDesk;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmDesk, StdCtrls;

type
  TfrmMMDesk = class(TfrmDesk)
    Button1: TButton;
  private
    FHookLocked: boolean;
    procedure SetHookLocked(const Value: boolean);
    { Private declarations }
    procedure MouseHook(Code: integer; Msg: word;MouseHook: longint);override;
    procedure KeyBoardHook(Code: integer; Msg: word;KeyboardHook: longint);override;
  public
    { Public declarations }
    procedure LoadDesk;
    property HookLocked:boolean read FHookLocked write SetHookLocked;
  end;

var
  frmMMDesk: TfrmMMDesk;

implementation
uses uDevFactory;
{$R *.dfm}

{ TfrmMMDesk }

procedure TfrmMMDesk.KeyBoardHook(Code: integer; Msg: word;
  KeyboardHook: Integer);
begin
  inherited;
  if (Msg=VK_HOME) and not HookLocked then
     DevFactory.OpenCashBox;

end;

procedure TfrmMMDesk.LoadDesk;
begin

end;

procedure TfrmMMDesk.MouseHook(Code: integer; Msg: word;
  MouseHook: Integer);
begin
  inherited;

end;

procedure TfrmMMDesk.SetHookLocked(const Value: boolean);
begin
  FHookLocked := Value;
end;

end.
