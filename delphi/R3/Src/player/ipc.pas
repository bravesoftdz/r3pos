unit ipc;

interface
uses
  Windows, Messages, SysUtils, Classes, RzCtrls, ActiveX;
type

PipcInfo=^TipcInfo;
TipcInfo=record
	szUserName:array [1..100] of char;
	szToken:array [1..100] of char;
end;


TSetRecvMsgCallBackFun=function(proc:pointer):integer;stdcall;
Trpc_init=function(sPort,cPort:integer):integer;stdcall;
Tgeterror=function(errno:integer):pchar;stdcall;
Tclient_server_send=function(str:pchar;len:integer):integer;stdcall;
TAppSubscribe=function(pAddCode:pchar;ipcInfo:PipcInfo):integer;stdcall;
const
  appid='rzPlayer';
var
  SetRecvMsgCallBackFun:TSetRecvMsgCallBackFun;
  rpc_init:Trpc_init;
  geterror:Tgeterror;
  AppSubscribe:TAppSubscribe;
  client_server_send:Tclient_server_send;
  username,token:string;
procedure InitIpc;
function Subscribe:boolean;
implementation
uses rzXmlDown;
var
  dllHandle:THandle;
function Subscribe:boolean;
var
  ipc:TipcInfo;
  r:integer;
begin
  fillchar(ipc,sizeof(ipc),0);
  r := AppSubscribe(pchar(appid),@ipc);
  if r=0 then
     begin
       username := StrPas(pchar(@ipc.szUserName));
       token := StrPas(pchar(@ipc.szToken));
     end
  else
     SendDebug(StrPas(geterror(r)),1);
end;
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
       @AppSubscribe := GetProcAddress(dllHandle, 'app_subscribe');
       if @AppSubscribe=nil then Raise Exception.Create('ipc.dll不合法');
       r := rpc_init(9090,9091);
       if r<>0 then Raise Exception.Create(StrPas(geterror(r)));
       r := SetRecvMsgCallBackFun(@IPCRecv);
       if r<>0 then Raise Exception.Create(StrPas(geterror(r)));
       try
         Subscribe;
       except
       end;
     end;
end;
initialization
finalization
  if dllHandle>0 then FreeLibrary(dllHandle);
end.
