program rspcn;

uses
  Forms,
  Windows,
  ufrmBrowerForm in 'ufrmBrowerForm.pas' {frmBrowerForm},
  rspcn_TLB in 'rspcn_TLB.pas',
  NSHandler in 'NSHandler.pas',
  uUcFactory in 'uUcFactory.pas' {UcFactory: TDataModule},
  uDLLFactory in 'uDLLFactory.pas',
  urlParser in 'urlParser.pas',
  udataFactory in 'udataFactory.pas',
  javaScriptExt in 'javaScriptExt.pas',
  uRspFactory in 'uRspFactory.pas' {rspFactory: TDataModule},
  uTokenFactory in 'uTokenFactory.pas',
  webMultInst in 'webMultInst.pas';

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmBrowerForm, frmBrowerForm);
  if paramStr(2)='-install' then
     frmBrowerForm.Install
  else
     begin
       if not Runed then
       begin
         Application.CreateForm(TUcFactory, UcFactory);
         Application.CreateForm(TrspFactory, rspFactory);
         PostMessage(frmBrowerForm.Handle,WM_BROWSER_INIT,0,0);
       end;
     end;
  Application.Run;
end.
