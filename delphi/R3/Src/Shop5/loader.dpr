program loader;

uses
  Forms,
  Windows,
  SysUtils,
  uXsmCacheFactory in 'Loader\uXsmCacheFactory.pas' {XsmCacheFactory};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TXsmCacheFactory, XsmCacheFactory);
  Application.ShowMainForm := True;
  PostMessage(XsmCacheFactory.Handle,WM_LOADER_REQUEST,1,1);
  Application.Run;
end.
