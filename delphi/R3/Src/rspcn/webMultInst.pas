//==============================================================================
// Unit Name: webMultInst
// Author   : ysai
// Date     : 2003-05-20
// Purpose  : 解决应用程序多实例问题
// History  :
//==============================================================================

//==============================================================================
// 工作流程
// 程序运行先取代原有向所有消息处理过程,然后广播一个消息.
// 如果有其它实例运行,收到广播消息会回发消息给发送程序,并传回它自己的句柄
// 发送程序接收到此消息,激活收到消息的程序,然后关闭自己
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
  MI_ACTIVEAPP  = 1;  //激活应用程序
  MI_GETHANDLE  = 2;  //取得句柄
  MI_HOTKEY  = 3;  //激活热健

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
      MI_ACTIVEAPP: //激活应用程序
        if lParam<>0 then
        begin
          //收到消息的激活前一个实例
          //为什么要在另一个程序中激活?
          //因为在同一个进程中SetForegroundWindow并不能把窗体提到最前
          if IsIconic(lParam) then
             OpenIcon(lParam)
          else
             SetForegroundWindow(lParam);
          PostMessage(HWND(lParam),iMessageID, MI_HOTKEY,0);
          //终止本实例
          Application.Terminate;
        end;
      MI_GETHANDLE: //取得程序句柄
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
  //取代应用程序的消息处理
  OldWProc    := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC,
    Longint(@NewWndProc)));

  //打开互斥对象
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, STR_UNIQUE);
  if MutHandle = 0 then
  begin
    //建立互斥对象
    MutHandle := CreateMutex(nil, False, STR_UNIQUE);
    Runed := false;
  end
  else begin
    //已经有程序实例,广播消息取得实例句柄
    Application.ShowMainForm  :=  False;
    BSMRecipients := BSM_APPLICATIONS;
    BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
        @BSMRecipients, iMessageID, MI_GETHANDLE,Application.Handle);
    //关闭互斥对象
    if MutHandle <> 0 then CloseHandle(MutHandle);
    MutHandle := 0;
    Runed := true;
  end;
end;

initialization
  //注册消息
  iMessageID  := RegisterWindowMessage(STR_UNIQUE);
  InitInstance;

finalization
  //还原消息处理过程
  if OldWProc <> Nil then
     SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(OldWProc));

  //关闭互斥对象
  if MutHandle <> 0 then CloseHandle(MutHandle);

end. 
 
