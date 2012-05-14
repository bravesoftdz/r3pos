unit ipc;

interface
uses
  Windows, Messages, SysUtils, Classes, RzCtrls, ActiveX;
type
TSetRecvMsgCallBackFun=function(proc:pointer):integer;stdcall;
Trpc_init=function(sPort,cPort:integer):integer;stdcall;
Tgeterror=function(errno:integer):pchar;stdcall;
Tclient_server_send=function(str:pchar;len:integer):integer;stdcall;
var
  SetRecvMsgCallBackFun:TSetRecvMsgCallBackFun;
  rpc_init:Trpc_init;
  geterror:Tgeterror;
  client_server_send:Tclient_server_send;
procedure InitIpc;
implementation
uses rzXmlDown;
var
  dllHandle:THandle;
procedure IPCRecv(msg:pchar;len:integer);stdcall;
var
  s:string;
begin
try
  setlength(s,len);
  move(msg^,pchar(s)^,len);
  //CoInitialize(nil);
  //try
    SendDebug('接收:'+s,4);
    XmlDown.DownPrm(s);
  //finally
  //  CoUninitialize();
  //end;
except
  on E:Exception do
     SendDebug(E.Message,1);
end;
end;
procedure InitIpc;
var r:integer;
begin
  dllHandle := LoadLibrary('ipc.dll');
  if dllHandle>0 then
     begin
       @SetRecvMsgCallBackFun := GetProcAddress(dllHandle, 'SetRecvMsgCallBackFun');
       if @SetRecvMsgCallBackFun=nil then Raise Exception.Create('ipc.dll不合法');
       @rpc_init := GetProcAddress(dllHandle, 'rpc_init');
       if @rpc_init=nil then Raise Exception.Create('ipc.dll不合法');
       @geterror := GetProcAddress(dllHandle, 'geterror');
       if @geterror=nil then Raise Exception.Create('ipc.dll不合法');
       @client_server_send := GetProcAddress(dllHandle, 'client_server_send');
       if @client_server_send=nil then Raise Exception.Create('ipc.dll不合法');
       r := rpc_init(9090,9091);
       if r<>0 then Raise Exception.Create(StrPas(geterror(r)));
       r := SetRecvMsgCallBackFun(@IPCRecv);
       if r<>0 then Raise Exception.Create(StrPas(geterror(r)));
     end;
end;
initialization
finalization
  if dllHandle>0 then FreeLibrary(dllHandle);
end.
