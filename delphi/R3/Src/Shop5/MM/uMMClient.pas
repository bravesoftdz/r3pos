unit uMMClient;

interface

uses
  Windows ,Messages, SysUtils, Classes, Forms, uMMUtil, ZBase;
type
  TMMClient=class
  private
    Ffinshed: boolean;
    procedure InitInstance;
    procedure Setfinshed(const Value: boolean);
  protected
    MMHandle:THandle;
    function RecvProc(wParam, lParam: Longint):LongInt;
    function SendProc(wParam, lParam: Longint):LongInt;
    procedure mcLogin(lParam: Longint);
    procedure mcSign(lParam: Longint);
    procedure mcQuit(lParam: Longint);
    procedure mcSessionFail(lParam: Longint);
  public
    MCExists:boolean;
    MMLogin:TMMLogin;
    constructor Create;
    destructor Destroy;override;
    //检测MM是否打开
    function MMExists:boolean;
    //通讯认证中心令牌失效了
    function sessionFail:boolean;
    //请求登录令牌
    function getSignature:string;
    property finshed:boolean read Ffinshed write Setfinshed;
  end;
var
  MMClient:TMMClient;
implementation
const
  MI_ACTIVEAPP  = 1;  //激活应用程序
  MI_GETHANDLE  = 2;  //取得句柄
  MI_DESKTOP  = 3;    //发子模块消息
  WM_DESKTOP_REQUEST=WM_USER+11;

var
  OldWProc      : TFNWndProc;
  MutHandle     : THandle;
  BSMRecipients : DWORD;
  
function NewWndProc(Handle: HWND; Msg: Integer; wParam, lParam: Longint):
  Longint; stdcall;
var prm:string;
begin
  Result := 0;
  if Msg = MC_MsgId then
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
               PostMessage(HWND(lParam), MC_MsgId, MI_DESKTOP,strtointdef(copy(prm,5,50),0));
             end;
          //终止本实例
          Application.Terminate;
        end;
      MI_GETHANDLE: //取得程序句柄
        begin
          PostMessage(HWND(lParam), MC_MsgId, MI_ACTIVEAPP,
            Application.Handle);
          Application.Restore;
        end;
      MI_DESKTOP:
        begin
          PostMessage(Application.MainForm.Handle, WM_DESKTOP_REQUEST, lParam,1);
        end;
    end;
  end
  else
  if Msg = MM_MsgId then
  begin
    case wParam of
      MI_ACTIVEAPP: //激活应用程序
        MMClient.MMHandle := HWND(lParam);
      MI_GETHANDLE: //取得程序句柄
        begin
          PostMessage(HWND(lParam), MC_MsgId, MI_ACTIVEAPP,
            Application.Handle);
        end;
    end;
  end
  else
  if (Msg = WM_COPYDATA) then
    begin
        result := MMClient.RecvProc(wParam, lParam);
    end
  else
    Result := CallWindowProc(OldWProc, Handle, Msg, wParam, lParam);
end;

procedure TMMClient.InitInstance;
begin
  //取代应用程序的消息处理
  OldWProc    := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC,
    Longint(@NewWndProc)));
  //打开互斥对象
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, MC_UNIQUE);
  if MutHandle = 0 then
  begin
    //建立互斥对象
    MutHandle := CreateMutex(nil, False, MC_UNIQUE);
    MCExists := false;
  end
  else begin
    //已经有程序实例,广播消息取得实例句柄
    Application.ShowMainForm  :=  False;
    BSMRecipients := BSM_APPLICATIONS;
    BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
        @BSMRecipients, MC_MsgId, MI_GETHANDLE,Application.Handle);
    //关闭互斥对象
    if MutHandle <> 0 then CloseHandle(MutHandle);
    MutHandle := 0;
    MCExists := true;
  end;
end;

{ TMMClient }

constructor TMMClient.Create;
begin
  //注册消息
  //注册消息
  MM_MsgId  := RegisterWindowMessage(MM_UNIQUE);
  MC_MsgId  := RegisterWindowMessage(MC_UNIQUE);
  InitInstance;
end;

destructor TMMClient.Destroy;
begin
  //还原消息处理过程
  if OldWProc <> Nil then
    SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(OldWProc));
  //关闭互斥对象
  if MutHandle <> 0 then CloseHandle(MutHandle);
  inherited;
end;

function TMMClient.RecvProc(wParam, lParam: Integer): LongInt;
begin
  case wParam of
  MM_LOGIN:mcLogin(lParam);
  MM_SIGN:mcSign(lParam);
  MM_QUIT:mcQuit(lParam);
  MM_SESSION_FAIL:mcSessionFail(lParam);
  end;
end;

function TMMClient.SendProc(wParam, lParam: Integer): LongInt;
var
  _Start:Int64;
begin
  MMHandle := 0;
  BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
      @BSMRecipients, MC_MsgId, MI_GETHANDLE,Application.Handle);
  _Start := GetTickCount;
  while MMHandle=0 do
    begin
      Application.ProcessMessages;
      if MMHandle>0 then break;
      if (GetTickCount-_Start)>2000 then Raise Exception.Create('等待超时，目标程序没有响...'); 
    end;
  SendMessage(MMHandle,WM_COPYDATA, wParam,lParam);
end;

function TMMClient.MMExists: boolean;
begin
  result := ProcExists(MM_UNIQUE);
end;

procedure TMMClient.mcSign(lParam: Longint);
var
  lp:PCopyDataStruct;
  s:string;
  Params:TftParamList;
begin
  lp := PCopyDataStruct(lParam);
  Params := TftParamList.Create;
  try
    s := StrPas(lp^.lpData);
    TftParamList.Decode(Params,s);
    MMLogin.xsmUserName := Params.ParambyName('XSM_USERNAME').AsString;
    MMLogin.xsmpassword := Params.ParambyName('XSM_PASSWORD').AsString;
    MMLogin.xsmsignature := Params.ParambyName('XSM_SIGNATURE').AsString;
    MMLogin.xsmchallenge := Params.ParambyName('XSM_CHALLENGE').AsString;
    finshed := true;
  finally
    Params.Free;
  end;
end;

procedure TMMClient.mcLogin(lParam: Longint);
var
  lp:PCopyDataStruct;
  s:string;
  Params:TftParamList;
begin
  lp := PCopyDataStruct(lParam);
  Params := TftParamList.Create;
  try
    s := StrPas(lp^.lpData);
    TftParamList.Decode(Params,s);
    MMLogin.tenantId := Params.ParambyName('TENANT_ID').AsInteger;
    MMLogin.tenantName := Params.ParambyName('TENANT_NAME').AsString;
    MMLogin.shortTenantName := Params.ParambyName('SHORT_TENANT_NAME').AsString;
    MMLogin.shopId := Params.ParambyName('SHOP_ID').AsString;
    MMLogin.shopName := Params.ParambyName('SHOP_NAME').AsString;
    MMLogin.userId := Params.ParambyName('USER_ID').AsString;
    MMLogin.userName := Params.ParambyName('USER_NAME').AsString;
    MMLogin.loginStatus := Params.ParambyName('LOGIN_STATUS').AsInteger;
    MMLogin.xsmUserName := Params.ParambyName('XSM_USERNAME').AsString;
    MMLogin.xsmpassword := Params.ParambyName('XSM_PASSWORD').AsString;
    MMLogin.xsmsignature := Params.ParambyName('XSM_SIGNATURE').AsString;
    MMLogin.xsmchallenge := Params.ParambyName('XSM_CHALLENGE').AsString;
    MMLogin.fn := Params.ParambyName('fn').asInteger;
    if Params.ParambyName('XSM_LOGINED').AsBoolean then
       MMLogin.xsmStatus := 1
    else
       MMLogin.xsmStatus := 2;
    PostMessage(Application.MainForm.Handle,MM_LOGIN,0,0);
  finally
    Params.Free;
  end;
end;

function TMMClient.getSignature: string;
var
  _Start:Int64;
begin
  finshed := false;
  _Start := getTickCount;
  SendProc(MM_SIGN,0);
  while not finshed do
    begin
      Application.ProcessMessages;
      if (GetTickCount-_Start)>20000 then Raise Exception.Create('读取新商盟令牌超时了!'); 
    end;
  result := MMLogin.xsmchallenge;
end;

function TMMClient.sessionFail: boolean;
var
  _Start:Int64;
begin
  result := false;
  finshed := false;
  _Start := getTickCount;
  SendProc(MM_SESSION_FAIL,0);
  while not finshed do
    begin
      Application.ProcessMessages;
      if (GetTickCount-_Start)>20000 then Raise Exception.Create('读取新商盟令牌超时了!'); 
    end;
  result := (MMLogin.xsmchallenge<>'');
end;

procedure TMMClient.Setfinshed(const Value: boolean);
begin
  Ffinshed := Value;
end;

procedure TMMClient.mcQuit(lParam: Integer);
begin
  PostMessage(Application.MainForm.Handle,MM_QUIT,0,0);
end;

procedure TMMClient.mcSessionFail(lParam: Integer);
var
  lp:PCopyDataStruct;
  s:string;
  Params:TftParamList;
begin
  lp := PCopyDataStruct(lParam);
  Params := TftParamList.Create;
  try
    s := StrPas(lp^.lpData);
    TftParamList.Decode(Params,s);
    MMLogin.xsmUserName := Params.ParambyName('XSM_USERNAME').AsString;
    MMLogin.xsmpassword := Params.ParambyName('XSM_PASSWORD').AsString;
    MMLogin.xsmsignature := Params.ParambyName('XSM_SIGNATURE').AsString;
    MMLogin.xsmchallenge := Params.ParambyName('XSM_CHALLENGE').AsString;
    finshed := true;
  finally
    Params.Free;
  end;
end;

initialization
  MMClient := TMMClient.Create;
finalization
  FreeAndNil(MMClient);
end. 

