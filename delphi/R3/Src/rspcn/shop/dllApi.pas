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
  
//1.��ʼ��Ӧ��
//˵��������appId�����ƣ���ʼ���ɹ��󷵻�true
function initApp(appWnd:Thandle;_dbHelp:IdbDllHelp;_token:pchar):boolean;stdcall;
//2.��Ӧ��
//˵������Ӧ����ָ����ģ��
function openApp(hWnd:Thandle;moduId:pchar):boolean;stdcall;
//3.�ر�Ӧ��
//˵�����ر�Ӧ���д򿪵�ģ��
//����ֵ:false��������رգ�true�رճɹ�
function closeApp(moduId:pchar):boolean;stdcall;
//4.�ͷ���Դ
function eraseApp:boolean;stdcall;

//5.��ȡ����˵��
function getLastError:pchar;stdcall;
//6.��ȡ������
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
//1.��ʼ��Ӧ��
//˵��������appId�����ƣ���ʼ���ɹ��󷵻�true
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

//2.��Ӧ��
//˵������Ӧ����ָ����ģ��
function openApp(hWnd:Thandle;moduId:pchar):boolean;stdcall;
var
  pClass:TPersistentClass;
  Form:TfrmWebForm;
begin
  try
    if token.tenantId='' then moduId:='TfrmSysDefine';
    pClass := dllApplication.getDllClass(strpas(moduId));
    if pClass = nil then Raise Exception.Create(strPas(moduId)+'����û�ҵ�.');
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

//3.�ر�Ӧ��
//˵�����ر�Ӧ���д򿪵�ģ��
//����ֵ:false��������رգ�true�رճɹ�
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

//4.�ͷ���Դ
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
//5.��ȡ����˵��
function getLastError:pchar;stdcall;
begin
  result := Pchar(lastError);
end;
//6.��ȡ������
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
     result := '��';
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
  MessageBox(wnd,pchar(E.Message),'������',MB_OK+MB_ICONERROR);
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
