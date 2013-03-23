unit dllApi;

interface
uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  ZIntf,
  uTokenFactory,
  ufrmWebForm,
  uRspFactory,
  udataFactory;
  
//1.初始化应用
//说明：传入appId与令牌，初始化成功后返回true
function initApp(appWnd:Thandle;_dbHelp:IdbDllHelp;_token:pchar):boolean;stdcall;
//2.打开应用
//说明：打开应用中指定的模块
function openApp(hWnd:Thandle;moduId:pchar):boolean;stdcall;
//3.关闭应用
//说明：关闭应用中打开的模块
//返回值:false代表不允许关闭，true关闭成功
function closeApp(moduId:pchar):boolean;stdcall;
//4.释放资源
function eraseApp:boolean;stdcall;

//5.读取错误说明
function getLastError:pchar;stdcall;
//6.获取标题名
function getModuleName(moduId:Pchar):Pchar;stdcall;

function resize:boolean;stdcall;

type
  TdllApplication=class
  private
    Fhandle: THandle;
    procedure Sethandle(const Value: THandle);
  public
    function getDllClass(name:string):TPersistentClass;
    procedure dllException(Sender: TObject; E: Exception);
    property handle:THandle read Fhandle write Sethandle;
  end;
var
  lastError:string;
  buf:string;
  dbHelp:IdbDllHelp;
  dllApplication:TdllApplication;
implementation
uses udllGlobal;
var
  webForm:TStringList;
  oldHandle:THandle;
procedure Halt0;
begin
  halt;
end;
procedure DLLEntryPoint(dwReason: DWord);
begin
  if (dwReason = DLL_PROCESS_DETACH) Then
  Begin
    asm
      xor edx, edx
      push ebp
      push OFFSET @@safecode
      push dword ptr fs:[edx]
      mov fs:[edx],esp
      call Halt0
      jmp @@exit;
      @@safecode:
      call Halt0;
      @@exit:
    end;
  end;
end;
//1.初始化应用
//说明：传入appId与令牌，初始化成功后返回true
function initApp(appWnd:Thandle;_dbHelp:IdbDllHelp;_token:pchar):boolean;stdcall;
begin
  DllProc := @DLLEntryPoint;
  DllProcEX := @DLLEntryPoint;
  webForm := TStringList.Create;
  oldHandle := Application.Handle;
  dllApplication.handle := appWnd;
  Application.OnException := dllApplication.dllException;
  Application.Handle := appWnd;
  token.decode(strpas(_token));
  dbHelp:= _dbHelp;
  rspFactory := TrspFactory.Create(nil);
  result := true;
end;

//2.打开应用
//说明：打开应用中指定的模块
function openApp(hWnd:Thandle;moduId:pchar):boolean;stdcall;
var
  pClass:TPersistentClass;
  Form:TfrmWebForm;
begin
  try
    if token.tenantId='' then moduId:='TfrmSysDefine';
    pClass := dllApplication.getDllClass(strpas(moduId));
    if pClass = nil then Raise Exception.Create(strPas(moduId)+'类名没找到.');
    Form := TFormClass(pClass).Create(application) as TfrmWebForm;
    webForm.AddObject(moduid,Form);

    Form.hWnd := hWnd;
    Form.showForm;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

//3.关闭应用
//说明：关闭应用中打开的模块
//返回值:false代表不允许关闭，true关闭成功
function closeApp(moduId:pchar):boolean;stdcall;
var
  idx:integer;
begin
  if token.tenantId='' then moduId:='TfrmSysDefine';
  idx := webForm.IndexOf(moduId);
  if idx>=0 then
     begin
       TObject(webForm.Objects[idx]).Free;
       webForm.Delete(idx); 
     end;
end;

//4.释放资源
function eraseApp:boolean;stdcall;
var
  i:integer;
begin
  for i:=webForm.Count -1 downto 0 do
     begin
       TfrmWebForm(webForm.Objects[i]).Free;
     end;
  webForm.Free;
  dbHelp := nil;
  Application.OnException := nil;
  Application.Handle := oldHandle;
end;
//5.读取错误说明
function getLastError:pchar;stdcall;
begin
  result := Pchar(lastError);
end;
//6.获取标题名
function getModuleName(moduId:Pchar):Pchar;
var
  idx:integer;
begin
  idx := webForm.IndexOf(moduId);
  if idx>=0 then
     begin
       buf:= TForm(webForm.Objects[idx]).caption;
       result := Pchar(buf);
     end
  else
     result := '无';
end;
function resize:boolean;stdcall;
var
  i:integer;
begin
  for i:=webForm.Count -1 downto 0 do
     begin
       TfrmWebForm(webForm.Objects[i]).ajustPostion;
     end;
end;
{ TdllApplication }

procedure TdllApplication.dllException(Sender: TObject; E: Exception);
var wnd:THandle;
begin
  if Screen.ActiveForm<>nil then
     wnd := Screen.ActiveForm.Handle
  else
     wnd := Application.Handle;
  MessageBox(wnd,pchar(E.Message),'出错了',MB_OK+MB_ICONERROR);
end;

function TdllApplication.getDllClass(name: string): TPersistentClass;
begin
  if (lowercase(name)='tfrmsaleorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'2') then
     begin
       name := 'TfrmPosOutOrder';
     end
  else
  if (lowercase(name)='tfrmstockorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'2') then
     begin
       name := 'TfrmPosInOrder';
     end;
  result := getClass(name);
end;

procedure TdllApplication.Sethandle(const Value: THandle);
begin
  Fhandle := Value;
end;

initialization
  dllApplication := TdllApplication.create;
finalization
  dllApplication.Free;
end.
