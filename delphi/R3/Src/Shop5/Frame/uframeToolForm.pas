unit uframeToolForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeMDForm, ExtCtrls, RzPanel, ActnList, Menus, ComCtrls,
  ToolWin, RzTabs, ActnMan, ActnCtrls, StdCtrls, RzLabel,DBGridEh, jpeg;

type
  TframeToolForm = class(TframeMDForm)
    RzPanel2: TRzPanel;
    RzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    Image2: TImage;
    Image1: TImage;
    Image14: TImage;
    Image3: TImage;
    rzPanel5: TPanel;
    Image4: TImage;
    lblToolCaption: TRzLabel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
  end;

implementation
uses udmIcon,uCtrlUtil, uGlobal, IniFiles;
{$R *.dfm}

{ TframeToolForm }

constructor TframeToolForm.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TframeToolForm.Destroy;
begin
  inherited;
end;

procedure TframeToolForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and (Key in [ord('D'),ord('d')]) then
     begin
       if actDelete.Enabled and Assigned(actDelete.OnExecute) then
          actDelete.OnExecute(actDelete);
     end;
  if (ssCtrl in Shift) and (Key in [ord('I'),ord('i')]) then
     begin
       if actNew.Enabled and Assigned(actNew.OnExecute) then
          actNew.OnExecute(actNew);
     end;
  if (ssCtrl in Shift) and (Key in [ord('S'),ord('s')]) then
     begin
       if actSave.Enabled and Assigned(actSave.OnExecute) then
          actSave.OnExecute(actSave);
     end;
  if (ssCtrl in Shift) and (Key in [ord('Z'),ord('z')]) then
     begin
       if actCancel.Enabled and Assigned(actCancel.OnExecute) then
          actCancel.OnExecute(actCancel);
     end;
  if (ssCtrl in Shift) and (Key = VK_END) then
     begin
       if actAudit.Enabled and Assigned(actAudit.OnExecute) then
          actAudit.OnExecute(actAudit);
     end;
  if (ssCtrl in Shift) and (Key = VK_F5) then
     begin
       if actFind.Enabled and Assigned(actFind.OnExecute) then
          actFind.OnExecute(actFind);
     end;
  if (ssCtrl in Shift) and (Key in [ord('E'),ord('e')]) then
     begin
       if actEdit.Enabled and Assigned(actEdit.OnExecute) then
          actEdit.OnExecute(actEdit);
     end;
  if (ssCtrl in Shift) and (Key in [ord('P'),ord('p')]) then
     begin
       if actPrint.Enabled and Assigned(actPrint.OnExecute) then
          actPrint.OnExecute(actPreview);
     end;
  if (ssCtrl in Shift) and (ssShift in Shift) and (Key in [ord('P'),ord('p')]) then
     begin
       if actPreview.Enabled and Assigned(actPreview.OnExecute) then
          actPreview.OnExecute(actPreview);
     end;
end;

procedure TframeToolForm.FormActivate(Sender: TObject);
begin
  inherited;
  lblToolCaption.Caption := 'µ±Ç°Î»ÖÃ->'+Caption;
end;

end.
