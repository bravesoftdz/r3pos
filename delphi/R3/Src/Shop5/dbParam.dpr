program dbParam;

uses
  Forms,
  ufrmDbParam in 'dbParam\ufrmDbParam.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDBSetup, frmDbParam);
  Application.Run;
end.
