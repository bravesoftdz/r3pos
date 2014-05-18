program shop;

uses
  Forms,
  Windows,
  EncDec in '..\..\Pub\EncDec.pas',
  Des in '..\..\Pub\des.pas',
  uFnUtil in '..\..\Pub\uFnUtil.pas',
  udbUtil in '..\..\Pub\udbUtil.pas',
  ZipUtils in '..\..\Pub\ZipUtils.pas',
  ufrmBrowerForm in 'ufrmBrowerForm.pas' {frmBrowerForm},
  uUcFactory in 'uUcFactory.pas' {UcFactory: TDataModule},
  uRspFactory in 'uRspFactory.pas' {rspFactory: TDataModule},
  ufrmWebDialog in 'ufrmWebDialog.pas' {frmWebDialog},
  ufrmPswdModify in 'ufrmPswdModify.pas' {frmPswdModify},
  ufrmLogo in 'ufrmLogo.pas' {frmLogo},
  shop_TLB in 'shop_TLB.pas',
  NSHandler in 'NSHandler.pas',
  uDLLFactory in 'uDLLFactory.pas',
  urlParser in 'urlParser.pas',
  udataFactory in 'udataFactory.pas',
  javaScriptExt in 'javaScriptExt.pas',
  uTokenFactory in 'uTokenFactory.pas',
  webMultInst in 'webMultInst.pas',
  uAppMgr in 'uAppMgr.pas',
  ufrmUpdate in 'ufrmUpdate.pas',
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
