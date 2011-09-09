program loader;

uses
  Forms,
  Windows,
  SysUtils,
  MultInst,
  uXsmCacheFactory in 'Loader\uXsmCacheFactory.pas' {XsmCacheFactory};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TXsmCacheFactory, XsmCacheFactory);
  Application.ShowMainForm := True;
  if not Runed then //如果已经运行
  begin
    PostMessage(XsmCacheFactory.Handle,WM_LOADER_REQUEST,1,1);
  end;
  Application.Run;
end.
