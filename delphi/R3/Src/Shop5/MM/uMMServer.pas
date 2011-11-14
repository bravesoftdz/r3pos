unit uMMServer;

interface

uses
  Windows ,Messages, SysUtils, Classes, Forms, uMMUtil , ZBase;
type
  TMMServer=class
  private
    procedure InitInstance;
  protected
    MCHandle:THandle;
    function RecvProc(wParam, lParam: Longint):LongInt;
    function SendProc(wParam, lParam: Longint):LongInt;
    procedure mmLogin;
    procedure mmSign;
    procedure mmSessionFail;
  public
    MMExists:boolean;
    constructor Create;
    destructor Destroy;override;
    procedure coLogin(_MMLogin:TftParamList);
    procedure coSign(_MMLogin:TftParamList);
    procedure coSessionFail(_MMLogin:TftParamList);
    //����Ƿ��
    function MCExists:boolean;
  end;
var
  MMServer:TMMServer;
implementation
Const
  MI_ACTIVEAPP  = 1;  //����Ӧ�ó���
  MI_GETHANDLE  = 2;  //ȡ�þ��
var
  OldWProc      : TFNWndProc;
  MutHandle     : THandle;
  BSMRecipients : DWORD;
  
function NewWndProc(Handle: HWND; Msg: Integer; wParam, lParam: Longint):Longint; stdcall;
var prm:string;
begin
  Result := 0;
  if Msg = MM_MsgId then
  begin
    case wParam of
      MI_ACTIVEAPP: //����Ӧ�ó���
        if lParam<>0 then
        begin
          //�յ���Ϣ�ļ���ǰһ��ʵ��
          //ΪʲôҪ����һ�������м���?
          //��Ϊ��ͬһ��������SetForegroundWindow�����ܰѴ����ᵽ��ǰ
          if IsIconic(lParam) then
            OpenIcon(lParam)
          else
            SetForegroundWindow(lParam);
          //��ֹ��ʵ��
          Application.Terminate;
        end;
      MI_GETHANDLE: //ȡ�ó�����
        begin
          PostMessage(HWND(lParam), MM_MsgId, MI_ACTIVEAPP,
            Application.Handle);
          Application.Restore;
        end;
    end;
  end
  else
  if Msg = MC_MsgId then
  begin
    case wParam of
      MI_ACTIVEAPP: //����Ӧ�ó���
        MMServer.MCHandle := HWND(lParam);
      MI_GETHANDLE: //ȡ�ó�����
        begin
          PostMessage(HWND(lParam), MM_MsgId, MI_ACTIVEAPP,
            Application.Handle);
        end;
    end;
  end
  else
  if (Msg = WM_COPYDATA) and (wParam>MM_USER) then
    begin
      result := MMServer.RecvProc(wParam, lParam);
    end
  else
    Result := CallWindowProc(OldWProc, Handle, Msg, wParam, lParam);
end;

procedure TMMServer.InitInstance;
begin
  //ȡ��Ӧ�ó������Ϣ����
  OldWProc    := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC,
    Longint(@NewWndProc)));

  //�򿪻������
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, MM_UNIQUE);
  if MutHandle = 0 then
  begin
    //�����������
    MutHandle := CreateMutex(nil, False, MM_UNIQUE);
    MMExists := false;
  end
  else begin
    //�Ѿ��г���ʵ��,�㲥��Ϣȡ��ʵ�����
    Application.ShowMainForm  :=  False;
    BSMRecipients := BSM_APPLICATIONS;
    BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
        @BSMRecipients, MM_MsgId, MI_GETHANDLE,Application.Handle);
    //�رջ������
    if MutHandle <> 0 then CloseHandle(MutHandle);
    MutHandle := 0;
    MMExists := true;
  end;
end;

{ TMMServer }

constructor TMMServer.Create;
begin
  //ע����Ϣ
  MM_MsgId  := RegisterWindowMessage(MM_UNIQUE);
  MC_MsgId  := RegisterWindowMessage(MC_UNIQUE);
  InitInstance;
end;

destructor TMMServer.Destroy;
begin
  if MCHandle>0 then
     SendMessage(MCHandle,WM_COPYDATA, MM_QUIT,0);
     
  //��ԭ��Ϣ�������
  if OldWProc <> Nil then
     SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(OldWProc));

  //�رջ������
  if MutHandle <> 0 then CloseHandle(MutHandle);
  inherited;
end;

function TMMServer.RecvProc(wParam, lParam: Integer): LongInt;
begin
  result := 0;
  case wParam of
  MM_LOGIN:mmLogin;
  MM_SIGN:mmSign;
  MM_SESSION_FAIL:mmSessionFail;
  end;
end;

function TMMServer.SendProc(wParam, lParam: Integer): LongInt;
var _Start:Int64;
begin
  MCHandle := 0;
  BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
      @BSMRecipients, MM_MsgId, MI_GETHANDLE, Application.Handle);
  _Start := GetTickCount;
  while MCHandle=0 do
    begin
      Application.ProcessMessages;
      if MCHandle>0 then break;
      if (GetTickCount-_Start)>2000 then Raise Exception.Create('�ȴ���ʱ��Ŀ�����û����...');
    end;
  SendMessage(MCHandle,WM_COPYDATA, wParam,lParam);
end;

function TMMServer.MCExists: boolean;
begin
  result := ProcExists(MC_UNIQUE);
end;

procedure TMMServer.mmLogin;
begin
  PostMessage(Application.MainForm.Handle,MM_LOGIN,0,0);
end;

procedure TMMServer.mmSign;
begin
  PostMessage(Application.MainForm.Handle,MM_SIGN,0,0);
end;

procedure TMMServer.coLogin(_MMLogin: TftParamList);
var
  lp:TCopyDataStruct;
  s:string;
begin
  if not MCExists then Raise Exception.Create('û�д�Ŀ��Ӧ��....');
  s := TftParamList.Encode(_MMLogin);
  lp.lpData := Pchar(s);
  lp.dwData := WM_COPYDATA;
  lp.cbData := length(s);
  SendProc(MM_LOGIN,integer(@lp));
end;

procedure TMMServer.coSign(_MMLogin: TftParamList);
var
  lp:TCopyDataStruct;
  s:string;
begin
  if not MCExists then Raise Exception.Create('û�д�Ŀ��Ӧ��....');
  s := TftParamList.Encode(_MMLogin);
  lp.lpData := Pchar(s);
  lp.dwData := WM_COPYDATA;
  lp.cbData := length(s);
  SendProc(MM_SIGN,integer(@lp));
end;

procedure TMMServer.mmSessionFail;
begin
  PostMessage(Application.MainForm.Handle,MM_SESSION_FAIL,0,0);
end;

procedure TMMServer.coSessionFail(_MMLogin: TftParamList);
var
  lp:TCopyDataStruct;
  s:string;
begin
  if not MCExists then Raise Exception.Create('û�д�Ŀ��Ӧ��....');
  s := TftParamList.Encode(_MMLogin);
  lp.lpData := Pchar(s);
  lp.dwData := WM_COPYDATA;
  lp.cbData := length(s);
  SendProc(MM_SESSION_FAIL,integer(@lp));
end;

initialization
  MMServer := TMMServer.Create;

finalization
  FreeAndNil(MMServer);
end. 

