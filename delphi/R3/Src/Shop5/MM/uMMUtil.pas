unit uMMUtil;

interface

uses
  Windows ,Messages, SysUtils, Classes, Forms;
const
  MM_UNIQUE    = '{FA49A7C5-1A5F-4461-8E0D-65DE9E9D2D0A}';
  MC_UNIQUE    = '{A16ABE7C-AEEA-4BAB-B2E0-DB9D097D5676}';
//通讯指令说明

  MM_USER    = WM_USER+10000;
  MM_LOGIN     = MM_USER+1; {向盟盟发送登录请求}  {向客户端发送已登录指令}
  MM_SIGN      = MM_USER+2; {向中心服务取令牌}
  MM_MESSAGE   = MM_USER+3; {向盟盟界面发送消息提示}
  MM_QUIT      = MM_USER+4; {向目标程序发送退出指令}
  MM_SESSION_FAIL   = MM_USER+5; {SESSION失效了，请求重新登录...}
  
type
  PMMCopyData=^TMMCopyData;
  TMMCopyData=record
   Buf:array [0..1024] of char;
   len:integer;
  end;
//通讯相关结构体说明
  PMMLogin=^TMMLogin;
  TMMLogin=record
    //业务系统登录
    userId:string;  
    userName:string;
    tenantId:integer;
    tenantName:string;
    shortTenantName:string;
    shopId:string;
    shopName:string;
    loginStatus:integer;{1 在线登录 2 离线登录}
    //新商盟登录
    xsmStatus:integer;{1 已登录 2 未登录}
    xsmUserName:string;
    xsmPassword:string;
    xsmChallenge:string;
    xsmSignature:string;
    //子模块选项
    fn:integer;  {默认0打开桌面}
  end;

  PMMMscPacket=^TMMMscPacket;
  TMMMscPacket=record
    mscId:string;
    mscTitle:string;
    mscContents:string;
    mscsndDate:string;
    mscClass:integer;
    
    sFlag:integer;  {业务类型标志}
    SenceId:string; {xsm调用指令}
    Action:string;  {智能提醒动作}
    mscFlag:integer;{1 r3消息 2 mm消息 3 xsm消息}
  end;
  
function ProcExists(UNIQUE:string):boolean;
var
  MM_MsgId    : Integer; //服务端消息
  MC_MsgId    : Integer; //客户端消息
implementation
function ProcExists(UNIQUE:string):boolean;
var MutHandle:THandle;
begin
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, pchar(UNIQUE));
  result := (MutHandle>0);
end;
end.

