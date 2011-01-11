program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  EncDec in '..\EncDec.pas',
  ZBase in '..\ZBase.pas',
  ZIntf in '..\ZIntf.pas',
  ZConst in '..\ZConst.pas',
  zdbHelp in '..\ZdbHelp.pas',
  ZdbFactory in '..\ZdbFactory.pas',
  ufrmBasic in '..\..\..\..\Basic\ufrmBasic.pas' {frmBasic},
  uGlobal in '..\..\..\..\Basic\uGlobal.pas' {Global: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
