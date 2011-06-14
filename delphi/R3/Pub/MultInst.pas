//==============================================================================
// Unit Name: MultInst
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
  MI_ACTIVEAPP  = 1;  //激活应用程序
  MI_GETHANDLE  = 2;  //取得句柄
  MI_DESKTOP  = 3;    //发子模块消息

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
          prm := ParamStr(4);
          if copy(prm,1,3)='-fn' then
             begin
               BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
               @BSMRecipients, iMessageID, MI_DESKTOP,strtointdef(copy(prm,5,50),0));
             end;
          //终止本实例
          Application.Terminate;
        end;
      MI_GETHANDLE: //取得程序句柄
        begin
          PostMessage(HWND(lParam), iMessageID, MI_ACTIVEAPP,
            Application.Handle);
          Application.Restore;
        end;
      MI_DESKTOP: //取得程序句柄
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
 
