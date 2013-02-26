unit dllApi;

interface
uses
  SysUtils,
  Classes,
  Forms,
  Windows,
  ZIntf,uTokenFactory,
  ufrmWebForm;
  
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

var
  lastError:string;
  buf:string;
  dbHelp:IdbDllHelp;
implementation
var
  webForm:TStringList;
  oldHandle:THandle;
//1.初始化应用
//说明：传入appId与令牌，初始化成功后返回true
function initApp(appWnd:Thandle;_dbHelp:IdbDllHelp;_token:pchar):boolean;stdcall;
begin
  webForm := TStringList.Create;
  oldHandle := Application.Handle;
  Application.Handle := appWnd;
  token.decode(strpas(_token));
  dbHelp:= _dbHelp;
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
    pClass := GetClass(strpas(moduId));
    if pClass = nil then Raise Exception.Create(strPas(moduId)+'类名没找到.');
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

//3.关闭应用
//说明：关闭应用中打开的模块
//返回值:false代表不允许关闭，true关闭成功
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
end.
