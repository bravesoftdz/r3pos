//==============================================================================
// Unit Name: MultInst
// Author   : ysai
// Date     : 2003-05-20
// Purpose  : ���Ӧ�ó����ʵ������
// History  :
//==============================================================================

//==============================================================================
// ��������
// ����������ȡ��ԭ����������Ϣ�������,Ȼ��㲥һ����Ϣ.
// ���������ʵ������,�յ��㲥��Ϣ��ط���Ϣ�����ͳ���,���������Լ��ľ��
// ���ͳ�����յ�����Ϣ,�����յ���Ϣ�ĳ���,Ȼ��ر��Լ�
//==============================================================================
unit MultInst;

interface

uses
  Windows ,Messages, SysUtils, Classes, Forms;
const
  WM_DESKTOP_REQUEST=WM_USER+11;

var
  Runed         : boolean;
implementation

const
  STR_UNIQUE    = '{A16ABE7C-AEEA-4BAB-B2E0-DB9D097D5676}';
  MI_ACTIVEAPP  = 1;  //����Ӧ�ó���
  MI_GETHANDLE  = 2;  //ȡ�þ��
  MI_DESKTOP  = 3;    //����ģ����Ϣ

var
  iMessageID    : Integer;
  OldWProc      : TFNWndProc;
  MutHandle     : THandle;
  BSMRecipients : DWORD;

function NewWndProc(Handle: HWND; Msg: Integer; wParam, lParam: Longint):
  Longint; stdcall;
var prm:string;
begin
  Result := 0;
  if Msg = iMessageID then
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
          prm := ParamStr(4);
          if copy(prm,1,3)='-fn' then
             begin
               BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
               @BSMRecipients, iMessageID, MI_DESKTOP,strtointdef(copy(prm,5,50),0));
             end;
          //��ֹ��ʵ��
          Application.Terminate;
        end;
      MI_GETHANDLE: //ȡ�ó�����
        begin
          PostMessage(HWND(lParam), iMessageID, MI_ACTIVEAPP,
            Application.Handle);
          Application.Restore;
        end;
      MI_DESKTOP: //ȡ�ó�����
        begin
          PostMessage(Application.MainForm.Handle, WM_DESKTOP_REQUEST, lParam,1);
        end;
    end;
  end
  else
    Result := CallWindowProc(OldWProc, Handle, Msg, wParam, lParam);
end;

procedure InitInstance;
begin
  //ȡ��Ӧ�ó������Ϣ����
  OldWProc    := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC,
    Longint(@NewWndProc)));

  //�򿪻������
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, STR_UNIQUE);
  if MutHandle = 0 then
  begin
    //�����������
    MutHandle := CreateMutex(nil, False, STR_UNIQUE);
    Runed := false;
  end
  else begin
    //�Ѿ��г���ʵ��,�㲥��Ϣȡ��ʵ�����
    Application.ShowMainForm  :=  False;
    BSMRecipients := BSM_APPLICATIONS;
    BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
        @BSMRecipients, iMessageID, MI_GETHANDLE,Application.Handle);
    //�رջ������
    if MutHandle <> 0 then CloseHandle(MutHandle);
    MutHandle := 0;
    Runed := true;
  end;
end;

initialization
  //ע����Ϣ
  iMessageID  := RegisterWindowMessage(STR_UNIQUE);
  InitInstance;

finalization
  //��ԭ��Ϣ�������
  if OldWProc <> Nil then
    SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(OldWProc));

  //�رջ������
  if MutHandle <> 0 then CloseHandle(MutHandle);

end. 
 
