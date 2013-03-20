//==============================================================================
// Unit Name: webMultInst
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
unit webMultInst;

interface

uses
  Windows ,Messages, SysUtils, Classes, Forms;
var
  Runed         : boolean;
implementation
uses ufrmBrowerForm;
const
  STR_UNIQUE    = '{B147A91D-9854-426B-BA65-52B841BD4700}';
  MI_ACTIVEAPP  = 1;  //����Ӧ�ó���
  MI_GETHANDLE  = 2;  //ȡ�þ��
  MI_HOTKEY  = 3;  //�����Ƚ�

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
          PostMessage(HWND(lParam),iMessageID, MI_HOTKEY,0);
          //��ֹ��ʵ��
          Application.Terminate;
        end;
      MI_GETHANDLE: //ȡ�ó�����
        begin
          PostMessage(HWND(lParam), iMessageID, MI_ACTIVEAPP,
            Application.Handle);
          Application.Restore;
        end;
      MI_HOTKEY: //VK_F12
        begin
          PostMessage(Application.MainForm.Handle, WM_HOTKEY, frmBrowerForm.hotKeyid,frmBrowerForm.hotKeyid);
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
 
