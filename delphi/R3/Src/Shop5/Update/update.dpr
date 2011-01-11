program update;

uses
  SysUtils,
  Forms,
  ufrmInstall in 'ufrmInstall.pas' {frmInstall},
  uDownByHttp in 'uDownByHttp.pas';

{$R *.res}
var frmInstall:TfrmInstall;
  s:string;
begin
  if ParamStr(1)='' then exit;
  Application.Initialize;
  Application.Title := '安装升级向导';
  Application.CreateForm(TfrmInstall,frmInstall);
  frmInstall.InstallType := 2;
  frmInstall.cxbtnCancel.Caption := '退出';
  frmInstall.btnInstall.Visible := true;
  s := ParamStr(1);
  delete(s,pos('.',s),5);
  frmInstall.SysId := s;
  frmInstall.Path := ExtractFilePath(ParamStr(0));
  frmInstall.LoadVersionFile;
  frmInstall.LoadControlFile;
  Application.Run;
end.
