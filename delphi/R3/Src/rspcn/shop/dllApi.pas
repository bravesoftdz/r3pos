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

function sendMsg(buf:Pchar;moduId:pchar):boolean;stdcall;

procedure freeApp(mid:string);
type
  TdllApplication=class
  private
    Fhandle: THandle;
    Fmode: string;
    procedure Sethandle(const Value: THandle);
    procedure Setmode(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;

    function getDllClass(name:string):TPersistentClass;
    function getModuId(name:string):string;
    procedure dllException(Sender: TObject; E: Exception);
    property handle:THandle read Fhandle write Sethandle;
    property mode:string read Fmode write Setmode;
  end;
var
  lastError:string;
  buf:string;
  dbHelp:IdbDllHelp;
  dllApplication:TdllApplication;
implementation
uses udllGlobal,uSyncFactory,IniFiles,uDevFactory,uRightsFactory,uRspSyncFactory,uCacheFactory,udllXDictFactory,ufrmSortDropFrom,uRtcSyncFactory;
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
    eraseApp;
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
  try
    DllProc := @DLLEntryPoint;
    DllProcEX := @DLLEntryPoint;
    webForm := TStringList.Create;
    oldHandle := Application.Handle;
    dllApplication.handle := appWnd;
    Application.OnException := dllApplication.dllException;
    //Application.Handle := appWnd;
    token.decode(strpas(_token));
    dbHelp:= _dbHelp;
    rspFactory := TrspFactory.Create(nil);
    result := true;
    if token.online then
       begin
         SyncFactory.LoginSync(appWnd);
       end;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

//2.��Ӧ��
//˵������Ӧ����ָ����ģ��
function openApp(hWnd:Thandle;moduId:pchar):boolean;stdcall;
var
  pClass:TPersistentClass;
  Form:TfrmWebForm;
  mid:string;
begin
  try
    mid := dllApplication.getModuId(moduId);
    pClass := dllApplication.getDllClass(mid);
    if pClass = nil then Raise Exception.Create(mid+'����û�ҵ�.');
    Form := TFormClass(pClass).Create(application) as TfrmWebForm;
    webForm.AddObject(mid,Form);

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
procedure freeApp(mid:string);
var
  idx:integer;
begin
  if not assigned(webForm) then Exit;
  idx := webForm.IndexOf(mid);
  if idx>=0 then
     begin
       webForm.Delete(idx);
     end;
end;
//3.�ر�Ӧ��
//˵�����ر�Ӧ���д򿪵�ģ��
//����ֵ:false��������رգ�true�رճɹ�
function closeApp(moduId:pchar):boolean;stdcall;
var
  idx:integer;
  mid:string;
  Form:TForm;
begin
  try
    mid := dllApplication.getModuId(moduId);
    idx := webForm.IndexOf(mid);
    if idx>=0 then
       begin
         if not TfrmWebForm(webForm.Objects[idx]).checkCanClose then Raise Exception.Create('ϵͳ���������У����ܹرա�');
         Form := TForm(webForm.Objects[idx]);
         webForm.Delete(idx);
         Form.Free;
       end;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;

//4.�ͷ���Դ
function eraseApp:boolean;stdcall;
var
  i:integer;
  Form:TForm;
begin
  try
    if not Assigned(webForm) then Exit;
    if assigned(frmSortDropFrom) and frmSortDropFrom.droped then Raise Exception.Create('��ǰģ�����ڲ���...'); 
    if assigned(SyncFactory) then SyncFactory.LogoutSync(dllApplication.handle);
    while webForm.Count>0 do
       begin
          Form := TfrmWebForm(webForm.Objects[0]);
          webForm.Delete(0);
          Form.Free; 
       end;
    if assigned(frmSortDropFrom) then FreeAndNil(frmSortDropFrom);
    if assigned(DevFactory) then FreeAndNil(DevFactory);
    if assigned(RightsFactory) then FreeAndNil(RightsFactory);
    if assigned(RtcSyncFactory) then FreeAndNil(RtcSyncFactory);
    if assigned(RspSyncFactory) then FreeAndNil(RspSyncFactory);
    if assigned(SyncFactory) then FreeAndNil(SyncFactory);
    if assigned(CacheFactory) then FreeAndNil(CacheFactory);
    if assigned(RspFactory) then FreeAndNil(RspFactory);
    if assigned(XDictFactory) then FreeAndNil(XDictFactory);
    if assigned(dllGlobal) then FreeAndNil(dllGlobal);
    if assigned(dataFactory) then FreeAndNil(dataFactory);
    if assigned(token) then FreeAndNil(token);
    FreeAndNil(webForm);
    dbHelp := nil;
    Application.OnException := nil;
    Application.Handle := oldHandle;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
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
  mid:string;
begin
  try
    mid := dllApplication.getModuId(moduId);
    idx := webForm.IndexOf(mid);
    if idx>=0 then
       begin
         buf:= TForm(webForm.Objects[idx]).caption;
         result := Pchar(buf);
       end
    else
       result := '��';
  except
    on E:Exception do
       begin
         result := nil;
         lastError := E.Message;
       end;
  end;
end;
function resize:boolean;stdcall;
var
  i:integer;
begin
  try
    for i:=webForm.Count -1 downto 0 do
       begin
         TfrmWebForm(webForm.Objects[i]).ajustPostion;
       end;
    result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;
function sendMsg(buf:Pchar;moduId:pchar):boolean;stdcall;
var
  idx:integer;
  mid:string;
begin
  try
    mid := dllApplication.getModuId(moduId);
    idx := webForm.IndexOf(mid);
    if idx>=0 then
       begin
         TfrmWebForm(webForm.Objects[idx]).Buf := StrPas(buf);
         PostMessage(TForm(webForm.Objects[idx]).Handle,WM_SEND_MSG,0,0);
       end;
     result := true;
  except
    on E:Exception do
       begin
         result := false;
         lastError := E.Message;
       end;
  end;
end;
{ TdllApplication }

constructor TdllApplication.Create;
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'r3.cfg');
  try
    mode := F.ReadString('soft','mode','release'); 
  finally
    F.Free;
  end;
end;

destructor TdllApplication.Destroy;
begin

  inherited;
end;

procedure TdllApplication.dllException(Sender: TObject; E: Exception);
var wnd:THandle;
begin
  if Screen.ActiveForm<>nil then
     wnd := Screen.ActiveForm.Handle
  else
     wnd := Application.Handle;
  MessageBox(wnd,pchar(E.Message),'��������',MB_OK+MB_ICONINFORMATION);
end;

function TdllApplication.getDllClass(name: string): TPersistentClass;
begin
  if (lowercase(name)='tfrmsaleorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'1') then
     begin
       name := 'TfrmPosOutOrder';
     end
  else
  if (lowercase(name)='tfrmstockorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'1') then
     begin
       name := 'TfrmPosInOrder';
     end;
  result := getClass(name);
end;

function TdllApplication.getModuId(name: string): string;
begin
  if token.tenantId='' then name:='TfrmSysDefine';
  if (lowercase(name)='tfrmsaleorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'1') then
     begin
       name := 'TfrmPosOutOrder';
     end
  else
  if (lowercase(name)='tfrmstockorder') and (dllGlobal.GetParameter('INPUT_MODE')<>'1') then
     begin
       name := 'TfrmPosInOrder';
     end;
  result := name;
end;

procedure TdllApplication.Sethandle(const Value: THandle);
begin
  Fhandle := Value;
end;

procedure TdllApplication.Setmode(const Value: string);
begin
  Fmode := Value;
end;

initialization
  dllApplication := TdllApplication.create;
finalization
  if assigned(dllApplication) then FreeAndNil(dllApplication);
end.
