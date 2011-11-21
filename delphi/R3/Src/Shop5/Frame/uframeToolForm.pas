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
    Image3: TImage;
    rzPanel5: TPanel;
    Image4: TImage;
    lblToolCaption: TRzLabel;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    Image14: TImage;
    Image1: TImage;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ToolBar1Resize(Sender: TObject);
    procedure CoolBar1Resize(Sender: TObject);
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
       Key := 0;
     end;
  if (ssCtrl in Shift) and (Key in [ord('I'),ord('i')]) then
     begin
       if actNew.Enabled and Assigned(actNew.OnExecute) then
          actNew.OnExecute(actNew);
       Key := 0;
     end;
  if (ssCtrl in Shift) and (Key in [ord('S'),ord('s')]) then
     begin
       if actSave.Enabled and Assigned(actSave.OnExecute) then
          actSave.OnExecute(actSave);
       Key := 0;
     end;
  if (ssCtrl in Shift) and (Key in [ord('Z'),ord('z')]) then
     begin
       if actCancel.Enabled and Assigned(actCancel.OnExecute) then
          actCancel.OnExecute(actCancel);
       Key := 0;
     end;
  if (ssCtrl in Shift) and (Key = VK_END) then
     begin
       if actAudit.Enabled and Assigned(actAudit.OnExecute) then
          actAudit.OnExecute(actAudit);
       Key := 0;
     end;
  if (ssCtrl in Shift) and (Key = VK_F5) then
     begin
       if actFind.Enabled and Assigned(actFind.OnExecute) then
          actFind.OnExecute(actFind);
       Key := 0;
     end;
  if (ssCtrl in Shift) and (Key in [ord('E'),ord('e')]) then
     begin
       if actEdit.Enabled and Assigned(actEdit.OnExecute) then
          actEdit.OnExecute(actEdit);
       Key := 0;
     end;
  if (ssCtrl in Shift) and (Key in [ord('P'),ord('p')]) then
     begin
       if actPrint.Enabled and Assigned(actPrint.OnExecute) then
          actPrint.OnExecute(actPreview);
       Key := 0;
     end;
  if (ssCtrl in Shift) and (ssShift in Shift) and (Key in [ord('P'),ord('p')]) then
     begin
       if actPreview.Enabled and Assigned(actPreview.OnExecute) then
          actPreview.OnExecute(actPreview);
       Key := 0;
     end;
end;

procedure TframeToolForm.FormActivate(Sender: TObject);
begin
  inherited;
  lblToolCaption.Caption := 'µ±Ç°Î»ÖÃ->'+Caption;
end;

procedure TframeToolForm.ToolBar1Resize(Sender: TObject);
begin
  inherited;
  ToolBar1.AutoSize := false;
  CoolBar1.AutoSize := false;
  ToolBar1.Width := width;
  CoolBar1.Width := width;
  ToolBar1.AutoSize := true;
  CoolBar1.AutoSize := true;
end;

procedure TframeToolForm.CoolBar1Resize(Sender: TObject);
begin
  inherited;
  ToolBar1.AutoSize := false;
  CoolBar1.AutoSize := false;
  ToolBar1.Width := width;
  CoolBar1.Width := width;
  ToolBar1.AutoSize := true;
  CoolBar1.AutoSize := true;

end;

end.
