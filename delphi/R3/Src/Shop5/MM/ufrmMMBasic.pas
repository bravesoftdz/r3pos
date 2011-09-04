unit ufrmMMBasic;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzForms, RzBckgnd, RzPanel,DbGridEh, RzBmpBtn, StdCtrls;

type
  TfrmMMBasic = class(TForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzBackground2: TRzBackground;
    RzPanel3: TRzPanel;
    Image1: TImage;
    labType: TLabel;
    sysClose: TRzBmpButton;
    RzBackground3: TRzBackground;
    RzFormShape1: TRzFormShape;
    procedure sysCloseClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure OnEnterPress(CurrentForm: TForm; Key: Char);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmMMBasic.sysCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMMBasic.OnEnterPress(CurrentForm: TForm; Key: Char);
begin
  with CurrentForm do
  begin
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

procedure TfrmMMBasic.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then
     Close
  else
     OnEnterPress(Self,Key);

end;

end.
