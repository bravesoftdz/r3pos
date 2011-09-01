program mm;

uses
  Forms,
  ufrmMMBasic in 'MM\ufrmMMBasic.pas' {frmMMBasic},
  ufrmMMMain in 'MM\ufrmMMMain.pas' {frmMMMain},
  uLoginFactory in 'App\uLoginFactory.pas',
  ummFactory in 'App\ummFactory.pas',
  ummGlobal in 'ummGlobal.pas' {mmGlobal: TDataModule},
  ObjCommon in 'Obj\ObjCommon.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TmmGlobal, mmGlobal);
  Application.CreateForm(TfrmMMMain, frmMMMain);
  Application.Run;
end.
