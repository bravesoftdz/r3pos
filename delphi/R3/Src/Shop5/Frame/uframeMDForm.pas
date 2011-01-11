unit uframeMDForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel;

type
  TframeMDForm = class(TfrmBasic)
    bgPanel: TRzPanel;
    actNew: TAction;
    actDelete: TAction;
    actEdit: TAction;
    actSave: TAction;
    actCancel: TAction;
    actExit: TAction;
    actPrint: TAction;
    actPreview: TAction;
    actFind: TAction;
    actInfo: TAction;
    actAudit: TAction;
    procedure actExitExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Createparams(Var Params:TCreateParams);override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
  end;

implementation
uses uShopUtil;
{$R *.dfm}

procedure TframeMDForm.actExitExecute(Sender: TObject);
begin
  inherited;
  Close;
end;

constructor TframeMDForm.Create(AOwner: TComponent);
begin
  inherited;
//  DoubleBuffered := true;
  if Assigned(Application.MainForm) and Application.MainForm.Visible then
     begin
       SetBounds(-4,-30,Application.MainForm.ClientWidth-129,Application.MainForm.ClientHeight-66);
       WindowState := wsMaximized;
       FormStyle := fsMDIChild;
     end
  else
     begin
       SetBounds(0,0,800,580);
     end;
  LoadFormRes(self);
  //初始form窗体
  Initform(self);
end;

procedure TframeMDForm.Createparams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      //EXStyle:=ExStyle or WS_EX_TOPMOST OR WS_EX_ACCEPTFILES or WS_DLGFRAME ;
      //WndParent:= GetDesktopWindow
    end;

end;

destructor TframeMDForm.Destroy;
begin
  //悉放form窗体
  Freeform(self);
  inherited;
end;

procedure TframeMDForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

end.
