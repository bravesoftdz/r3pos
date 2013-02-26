unit dllApi;

interface
uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  ZIntf,uTokenFactory,
  ufrmWebForm;
  
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

var
  lastError:string;
  buf:string;
  dbHelp:IdbDllHelp;
implementation
var
  webForm:TStringList;
  oldHandle:THandle;
//1.��ʼ��Ӧ��
//˵��������appId�����ƣ���ʼ���ɹ��󷵻�true
function initApp(appWnd:Thandle;_dbHelp:IdbDllHelp;_token:pchar):boolean;stdcall;
begin
  webForm := TStringList.Create;
  oldHandle := Application.Handle;
  Application.Handle := appWnd;
  token.decode(strpas(_token));
  dbHelp:= _dbHelp;
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
    pClass := GetClass(strpas(moduId));
    if pClass = nil then Raise Exception.Create(strPas(moduId)+'����û�ҵ�.');
    Form := TFormClass(pClass).Create(application) as TfrmWebForm;
    webForm.AddObject(moduid,Form);
    windows.SetParent(Form.Handle,hWnd);
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
end.
