library shop;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ufrmWebForm in 'ufrmWebForm.pas' {frmWebForm},
  uTokenFactory in '..\uTokenFactory.pas',
  dllApi in 'dllApi.pas',
  ufrmSaleOrder in 'ufrmSaleOrder.pas' {frmSaleOrder},
  udataFactory in 'udataFactory.pas' {dataFactory: TDataModule},
  rspcn_TLB in '..\rspcn_TLB.pas',
  dllIntf in '..\dllIntf.pas',
  uRspFactory in '..\uRspFactory.pas' {rspFactory: TDataModule};

{$R *.res}

exports
  initApp,openApp,closeApp,eraseApp,getLastError,getModuleName;
begin

end.
