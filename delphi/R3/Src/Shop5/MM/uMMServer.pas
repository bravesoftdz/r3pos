unit uMMServer;

interface

uses
  Windows ,Messages, SysUtils, Classes, Forms, uMMUtil , ZBase;
type
  TMMServer=class
  private
    FMMHandle: THandle;
    procedure InitInstance;
    procedure SetMMHandle(const Value: THandle);
  protected
    MCHandle:THandle;
    FParams:string;
    procedure DecodeParams(lParam:Longint);
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
    function ParamStr(Index:integer):string;
    //检测是否打开
    function MCExists:boolean;
    property MMHandle:THandle read FMMHandle write SetMMHandle;
    property Params:string read FParams write FParams;
  end;
var
  MMServer:TMMServer;
implementation
Const
  MI_ACTIVEAPP  = 1;  //激活应用程序
  MI_GETHANDLE  = 2;  //取得句柄
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
          //终止本实例
          Application.Terminate;
        end;
      MI_GETHANDLE: //取得程序句柄
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
      MI_ACTIVEAPP: //激活应用程序
        MMServer.MCHandle := HWND(lParam);
      MI_GETHANDLE: //取得程序句柄
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
  //取代应用程序的消息处理
  OldWProc    := TFNWndProc(SetWindowLong(Application.Handle, GWL_WNDPROC,
    Longint(@NewWndProc)));

  //打开互斥对象
  MutHandle := OpenMutex(MUTEX_ALL_ACCESS, False, MM_UNIQUE);
  if MutHandle = 0 then
  begin
    //建立互斥对象
    MutHandle := CreateMutex(nil, False, MM_UNIQUE);
    MMExists := false;
  end
  else begin
    //已经有程序实例,广播消息取得实例句柄
    Application.ShowMainForm  :=  False;
    BSMRecipients := BSM_APPLICATIONS;
    BroadCastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE,
        @BSMRecipients, MM_MsgId, MI_GETHANDLE,Application.Handle);
    //关闭互斥对象
    if MutHandle <> 0 then CloseHandle(MutHandle);
    MutHandle := 0;
    MMExists := true;
  end;
end;

{ TMMServer }

constructor TMMServer.Create;
begin
  //注册消息
  MM_MsgId  := RegisterWindowMessage(MM_UNIQUE);
  MC_MsgId  := RegisterWindowMessage(MC_UNIQUE);
  InitInstance;
end;

destructor TMMServer.Destroy;
begin
  if MCHandle>0 then
     SendMessage(MCHandle,WM_COPYDATA, MM_QUIT,0);
     
  //还原消息处理过程
  if OldWProc <> Nil then
     SetWindowLong(Application.Handle, GWL_WNDPROC, LongInt(OldWProc));

  //关闭互斥对象
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
  MM_PARAMS:DecodeParams(lParam);
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
      if (GetTickCount-_Start)>2000 then Raise Exception.Create('等待超时，目标程序没有响...');
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
  if not MCExists then Raise Exception.Create('没有打开目标应用....');
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
  if not MCExists then Raise Exception.Create('没有打开目标应用....');
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
  if not MCExists then Raise Exception.Create('没有打开目标应用....');
  s := TftParamList.Encode(_MMLogin);
  lp.lpData := Pchar(s);
  lp.dwData := WM_COPYDATA;
  lp.cbData := length(s);
  SendProc(MM_SESSION_FAIL,integer(@lp));
end;

procedure TMMServer.DecodeParams(lParam: Integer);
var
  lp:PCopyDataStruct;
begin
  lp := PCopyDataStruct(lParam);
  FParams := StrPas(lp^.lpData);
  PostMessage(MMHandle,MM_PARAMS,0,0);
end;

procedure TMMServer.SetMMHandle(const Value: THandle);
begin
  FMMHandle := Value;
end;

function TMMServer.ParamStr(Index: integer): string;
function GetParamStr(P: PChar; var Param: string): PChar;
var
  i, Len: Integer;
  Start, S, Q: PChar;
begin
  while True do
  begin
    while (P[0] <> #0) and (P[0] <= ' ') do
      P := CharNext(P);
    if (P[0] = '"') and (P[1] = '"') then Inc(P, 2) else Break;
  end;
  Len := 0;
  Start := P;
  while P[0] > ' ' do
  begin
    if P[0] = '"' then
    begin
      P := CharNext(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Q := CharNext(P);
        Inc(Len, Q - P);
        P := Q;
      end;
      if P[0] <> #0 then
        P := CharNext(P);
    end
    else
    begin
      Q := CharNext(P);
      Inc(Len, Q - P);
      P := Q;
    end;
  end;

  SetLength(Param, Len);

  P := Start;
  S := Pointer(Param);
  i := 0;
  while P[0] > ' ' do
  begin
    if P[0] = '"' then
    begin
      P := CharNext(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Q := CharNext(P);
        while P < Q do
        begin
          S[i] := P^;
          Inc(P);
          Inc(i);
        end;
      end;
      if P[0] <> #0 then P := CharNext(P);
    end
    else
    begin
      Q := CharNext(P);
      while P < Q do
      begin
        S[i] := P^;
        Inc(P);
        Inc(i);
      end;
    end;
  end;

  Result := P;
end;
var
  P: PChar;
begin
  P := Pchar(FParams);
  while True do
  begin
    P := GetParamStr(P, Result);
    if (Index = 0) or (Result = '') then Break;
    Dec(Index);
  end;
end;

initialization
  MMServer := TMMServer.Create;

finalization
  FreeAndNil(MMServer);
end. 

