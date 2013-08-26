program shop;

uses
  Forms,
  Windows,
  ufrmBrowerForm in 'ufrmBrowerForm.pas' {frmBrowerForm},
  shop_TLB in 'shop_TLB.pas',
  NSHandler in 'NSHandler.pas',
  uUcFactory in 'uUcFactory.pas' {UcFactory: TDataModule},
  uDLLFactory in 'uDLLFactory.pas',
  urlParser in 'urlParser.pas',
  udataFactory in 'udataFactory.pas',
  javaScriptExt in 'javaScriptExt.pas',
  uRspFactory in 'uRspFactory.pas' {rspFactory: TDataModule},
  uTokenFactory in 'uTokenFactory.pas',
  webMultInst in 'webMultInst.pas',
  uAppMgr in 'uAppMgr.pas',
  ufrmUpdate in 'ufrmUpdate.pas',
  ufrmWebDialog in 'ufrmWebDialog.pas' {frmWebDialog},
  ufrmLogo in 'ufrmLogo.pas' {frmLogo},
  uResFactory in 'uResFactory.pas';

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '现代卷烟零售终端营销管理系统';
  Application.CreateForm(TfrmBrowerForm, frmBrowerForm);
  Application.CreateForm(TfrmLogo, frmLogo);
  if paramStr(1)='-install' then
     frmBrowerForm.Install
  else
     begin
       if not Runed then
          begin
            Application.CreateForm(TUcFactory, UcFactory);
            Application.CreateForm(TrspFactory, rspFactory);
            PostMessage(frmBrowerForm.Handle,WM_BROWSER_INIT,0,0);
          end
       else
          begin
            frmBrowerForm.Timer1.Interval := 1000*30;
            frmBrowerForm.Timer1.Enabled := true;
          end;
     end;
   Application.Run;
end.
