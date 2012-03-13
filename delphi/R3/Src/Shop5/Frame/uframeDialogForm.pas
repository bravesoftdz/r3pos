unit uframeDialogForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, RzTabs, DB, ZBase,
  cxControls, cxContainer, cxEdit, cxTextEdit;
type
  TOnSaveEvent=procedure(AObj:TRecord_) of object;
  TframeDialogForm = class(TfrmBasic)
    bgPanel: TRzPanel;
    RzPage: TRzPageControl;
    btPanel: TRzPanel;
    TabSheet1: TRzTabSheet;
    RzPanel2: TRzPanel;
  private
    FdbState: TDataSetState;
    FOnSave: TOnSaveEvent;
    procedure SetOnSave(const Value: TOnSaveEvent);
    { Private declarations }
  protected
    procedure SetdbState(const Value: TDataSetState); virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    property dbState:TDataSetState read FdbState write SetdbState;
    property OnSave:TOnSaveEvent read FOnSave write SetOnSave;
  end;

implementation
uses uShopUtil;
{$R *.dfm}

{ TframeDialogForm }

constructor TframeDialogForm.Create(AOwner: TComponent);
begin
  inherited;
  //初始form窗体
  Initform(self);
  LoadFormRes(self);
end;

destructor TframeDialogForm.Destroy;
begin
  //悉放form窗体
  Freeform(self);
  inherited;
  
end;

procedure TframeDialogForm.SetdbState(const Value: TDataSetState);
begin
  FdbState := Value;
  SetFormEditStatus(self,Value);

end;

procedure TframeDialogForm.SetOnSave(const Value: TOnSaveEvent);
begin
  FOnSave := Value;
end;

end.
