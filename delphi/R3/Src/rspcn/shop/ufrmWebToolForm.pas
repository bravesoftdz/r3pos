unit ufrmWebToolForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebForm, ExtCtrls, RzPanel, DB;

type
  TfrmWebToolForm = class(TfrmWebForm)
    toolNav: TRzPanel;
  private
    FdbState: TDataSetState;
  protected
    procedure SetdbState(const Value: TDataSetState);virtual;
  public
    property  dbState:TDataSetState read FdbState write SetdbState;
  end;

implementation

uses udllShopUtil;

{$R *.dfm}

procedure TfrmWebToolForm.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  SetFormEditStatus(self,Value);
end;

end.
