unit uMMUtil;

interface

uses
  Windows ,Messages, SysUtils, Classes, Forms;
const
  MM_UNIQUE    = '{FA49A7C5-1A5F-4461-8E0D-65DE9E9D2D0A}';
  MC_UNIQUE    = '{A16ABE7C-AEEA-4BAB-B2E0-DB9D097D5676}';
//ͨѶָ��˵��

  MM_USER    = WM_USER+10000;
  MM_LOGIN     = MM_USER+1; {�����˷��͵�¼����}  {��ͻ��˷����ѵ�¼ָ��}
  MM_SIGN      = MM_USER+2; {�����ķ���ȡ����}
  MM_MESSAGE   = MM_USER+3; {�����˽��淢����Ϣ��ʾ}
  MM_QUIT      = MM_USER+4; {��Ŀ��������˳�ָ��}
  MM_SESSION_FAIL   = MM_USER+5; {SESSIONʧЧ�ˣ��������µ�¼...}
  
type
  PMMCopyData=^TMMCopyData;
  TMMCopyData=record
   Buf:array [0..1024] of char;
   len:integer;
  end;
//ͨѶ��ؽṹ��˵��
  PMMLogin=^TMMLogin;
  TMMLogin=record
    //ҵ��ϵͳ��¼
    userId:string;  
    userName:string;
    tenantId:integer;
    tenantName:string;
    shortTenantName:string;
    shopId:string;
    shopName:string;
    loginStatus:integer;{1 ���ߵ�¼ 2 ���ߵ�¼}
    //�����˵�¼
    xsmStatus:integer;{1 �ѵ�¼ 2 δ��¼}
    xsmUserName:string;
    xsmPassword:string;
    xsmChallenge:string;
    xsmSignature:string;
    //��ģ��ѡ��
    fn:integer;  {Ĭ��0������}
  end;

  PMMMscPacket=^TMMMscPacket;
  TMMMscPacket=record
    mscId:string;
    mscTitle:string;
    mscContents:string;
    mscsndDate:string;
    mscClass:integer;
    
    sFlag:integer;  {ҵ�����ͱ�־}
    SenceId:string; {xsm����ָ��}
    Action:string;  {�������Ѷ���}
    mscFlag:integer;{1 r3��Ϣ 2 mm��Ϣ 3 xsm��Ϣ}
  end;
  
function ProcExists(UNIQUE:string):boolean;
var
  MM_MsgId    : Integer; //�������Ϣ
  MC_MsgId    : Integer; //�ͻ�����Ϣ
implementation
function ProcExists(UNIQUE:string):boolean;
var MutHandle:THandle;
begin
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, pchar(UNIQUE));
  result := (MutHandle>0);
end;
end.

