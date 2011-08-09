library rspFactory;

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
  SysUtils,
  Classes,
  CaProductService in 'App\CaProductService.pas',
  CaServiceLineService in 'App\CaServiceLineService.pas',
  CaTenantService in 'App\CaTenantService.pas',
  PubMemberService in 'App\PubMemberService.pas',
  RspDownloadService in 'App\RspDownloadService.pas',
  rspHeader in 'App\rspHeader.pas',
  ZLibEx in 'E:\soft\¿Ø¼þ\Gzip125\ZLibEx.pas',
  ZLibExApi in 'E:\soft\¿Ø¼þ\Gzip125\ZLibExApi.pas',
  ZLibExGZ in 'E:\soft\¿Ø¼þ\Gzip125\ZLibExGZ.pas',
  des in '..\..\Pub\des.pas';

{$R *.res}
function coLogin(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.coLogin(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message);
   end;
 finally
   rsp.Free;
 end;
end;
function coRegister(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.coRegister(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message);
   end;
 finally
   rsp.Free;
 end;
end;
function getTenantInfo(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.getTenantInfo(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message);
   end;
 finally
   rsp.Free;
 end;
end;
function listModules(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.listModules(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message);
   end;
 finally
   rsp.Free;
 end;
end;
function checkUpgrade(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.checkUpgrade(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function createServiceLine(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.createServiceLine(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function queryServiceLines(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.queryServiceLines(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function applyRelation(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.applyRelation(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function downloadTenants(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.downloadTenants(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function downloadServiceLines(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.downloadServiceLines(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function downloadRelations(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.downloadRelations(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function downloadSort(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.downloadSort(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function downloadUnit(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.downloadUnit(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function downloadGoods(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.downloadGoods(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function downloadDeployGoods(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.downloadDeployGoods(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function downloadBarcode(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.downloadBarcode(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;
function queryUnion(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
var
  rsp:TRspFactory;
begin
 rsp := TRspFactory.Create(20000,url,flag);
 try
   try
     result := rsp.queryUnion(xml);
   except
     on E:Exception do
       result := rsp.ErrorEncode(E.Message  );
   end;
 finally
   rsp.Free;
 end;
end;

exports
  coLogin,coRegister,getTenantInfo,listModules,checkUpgrade,
  createServiceLine,queryServiceLines,applyRelation,
  downloadTenants,downloadServiceLines,downloadRelations,downloadSort,downloadUnit,downloadGoods,downloadDeployGoods,downloadBarcode,
  queryUnion;
begin
end.
