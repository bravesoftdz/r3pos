unit uMsgBox;

interface
uses Forms,Windows;
//信息提示箱
function ShowMsgBox(lpText:Pchar;lpCaption:Pchar;bType:integer):integer;
implementation
uses ufrmLogo,ufrmDesk,ufrmPrgBar;
function ShowMsgBox(lpText:Pchar;lpCaption:Pchar;bType:integer):integer;
var
  Form:TForm;
  PWnd:THandle;
  LogoVisible:boolean;
  PrgBarVisible:boolean;
begin
  if frmDesk<>nil then frmDesk.Waited := false;
  if (frmLogo<>nil) and frmLogo.Visible then
     begin
       frmLogo.Close;
//       LogoVisible := true;
     end;
  if (frmPrgBar<>nil) and frmPrgBar.Visible then
     begin
       frmPrgBar.Close;
//       PrgBarVisible := true;
     end;
  try
    Form := Screen.ActiveForm;
    if Form<>nil then
       PWnd := Form.Handle
    else
       PWnd := Application.Handle;

    result := MessageBox(PWnd,lpText,lpCaption,bType);
  finally
//    if LogoVisible then frmLogo.Show;
//    if PrgBarVisible then frmPrgBar.Show;
  end;
end;
end.
