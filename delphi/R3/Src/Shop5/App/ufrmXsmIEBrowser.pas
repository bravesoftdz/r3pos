unit ufrmXsmIEBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ActnList, Menus, OleCtrls, SHDocVw, ExtCtrls,
  RzPanel, RzTabs, ImgList, LCContrllerLib, ZDataSet, StdCtrls;

type
  TfrmXsmIEBrowser = class(TfrmIEWebForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FLogined: boolean;
    Fready: boolean;
    FSessionFail: boolean;
    { Private declarations }
    procedure DoFuncCall(ASender: TObject; const szMethodName: WideString;
                                                   const szPara: WideString);
    procedure DoFuncCall2(ASender: TObject; const szMethodName: WideString;
                                                   const szPara1: WideString;
                                                   const szPara2: WideString);
    procedure DoFuncCall3(ASender: TObject; const szMethodName: WideString;
                                                   const szPara1: WideString; 
                                                   const szPara2: WideString; 
                                                   const szPara3: WideString);
    procedure SetLogined(const Value: boolean);
    procedure Setready(const Value: boolean);
    procedure SetSessionFail(const Value: boolean);
  public
    { Public declarations }
    LCObject:TLCObject;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure Connect;
    procedure Send(const szMethodName: WideString;const szPara: WideString);
    procedure Send2(const szMethodName: WideString;const szPara1: WideString;const szPara2: WideString);
    procedure Send3(const szMethodName: WideString;const szPara1: WideString;const szPara2: WideString;const szPara3: WideString);
    function WaitRun:boolean;
    procedure DoInit;
    function DoLogin:boolean;
    procedure ClearResource;
    procedure Open(sid,oid:string);
    property Logined:boolean read FLogined write SetLogined;
    property ready:boolean read Fready write Setready;
    property SessionFail:boolean read FSessionFail write SetSessionFail;
  end;
var
  frmXsmIEBrowser:TfrmXsmIEBrowser;
implementation
uses uCaFactory,uGlobal,ufrmLogo,ZLogFile,ufrmXsmLogin;
{$R *.dfm}

{ TfrmXsmIEBrowser }

constructor TfrmXsmIEBrowser.Create(AOwner: TComponent);
begin
  inherited;
  try
    LCObject := TLCObject.Create(AOwner);
    LCObject.OnFuncCall := DoFuncCall;
    LCObject.OnFuncCall2 := DoFuncCall2;
    LCObject.OnFuncCall3 := DoFuncCall3;
    LCObject.Visible := false;
    Connect;
  except
    MessageBox(Handle,'系统没有检测到"新商盟接口组件",请检查软件是否正确安装?','友情提示...',MB_OK+MB_ICONWARNING);
  end;
end;

destructor TfrmXsmIEBrowser.Destroy;
begin
  inherited;
end;

procedure TfrmXsmIEBrowser.DoFuncCall3(ASender: TObject;
  const szMethodName, szPara1, szPara2, szPara3: WideString);
begin
  runed := false;
  LogFile.AddLogFile(0,'FuncCall3:方法='+szMethodName+' 参数1='+szPara1+' 参数2='+szPara2+' 参数3='+szPara3);
end;

function TfrmXsmIEBrowser.DoLogin:boolean;
var
  _Start:Int64;
begin
  if not ready then Raise Exception.Create('系统装载新商盟运行环境无效.');
  frmLogo.Show;
  frmLogo.ShowTitle := '正在登录新商盟...';
  try
    Send2('login',xsm_username,xsm_password);
    if not WaitRun then Logined := false;
    result := Logined;
  finally
    frmLogo.Close;
  end;
end;

procedure TfrmXsmIEBrowser.SetLogined(const Value: boolean);
begin
  FLogined := Value;
  SessionFail := false;
end;

procedure TfrmXsmIEBrowser.DoFuncCall(ASender: TObject; const szMethodName,
  szPara: WideString);
begin
  if szMethodName='ready' then
     ready := true;
  if szMethodName='loginReady' then
     ready := true;
  if szMethodName='loginStatus' then
     Logined := (szPara='success');
  if szMethodName='sessionFail' then
     begin
       Logined := false;
       SessionFail := true;
     end;
  if szMethodName='loginReady' then
     Logined := true;
  runed := false;
  LogFile.AddLogFile(0,'FuncCall:方法='+szMethodName+' 参数1='+szPara);
end;

procedure TfrmXsmIEBrowser.DoFuncCall2(ASender: TObject;
  const szMethodName, szPara1, szPara2: WideString);
begin
  runed := false;
  LogFile.AddLogFile(0,'FuncCall2:方法='+szMethodName+' 参数1='+szPara1+' 参数2='+szPara2);
end;

procedure TfrmXsmIEBrowser.Connect;
var r:integer;
begin
  r := LCObject.Connect('_r3');
  if r<>0 then LogFile.AddLogFile(0,'初始化新商盟LCObject失败，失败代码:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Send(const szMethodName, szPara: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send('_R3_XSM',szMethodName,szPara);
  if r<>0 then LogFile.AddLogFile(0,'发送<'+szMethodName+'>p1='+szPara+'失败，失败代码:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Send2(const szMethodName, szPara1,
  szPara2: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send2('_R3_XSM',szMethodName,szPara1,szPara2);
  if r<>0 then LogFile.AddLogFile(0,'发送<'+szMethodName+'>p1='+szPara1+',p2='+szPara2+'失败，失败代码:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Send3(const szMethodName, szPara1, szPara2,
  szPara3: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send3('_R3_XSM',szMethodName,szPara1,szPara2,szPara3);
  if r<>0 then LogFile.AddLogFile(0,'发送<'+szMethodName+'>p1='+szPara1+',p2='+szPara2+',p3='+szPara3+'失败，失败代码:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;
  FormStyle := fsNormal;
end;

procedure TfrmXsmIEBrowser.Open(sid, oid: string);
begin
  FormStyle := fsMDIChild;
  WindowState := wsMaximized;
  BringToFront;
  if not CaFactory.Audited then Raise Exception.Create('脱机状态不能进行新商盟...');
  if not Logined then
     begin
       if SessionFail then DoLogin;
       if not Logined and TfrmXsmLogin.XsmRegister then
          begin
            if not DoLogin then Open(sid,oid);
          end
       else
          Exit;
     end;
  Send2('getModule',sid,oid);
end;

procedure TfrmXsmIEBrowser.Setready(const Value: boolean);
begin
  Fready := Value;
end;

procedure TfrmXsmIEBrowser.DoInit;
var
  _Start,W:Int64;
begin
  ready := false;
  Runed := true;
  IEBrowser.Navigate(ExtractFilePath(ParamStr(0))+'xsm\xsm.html');
  if not WaitRun then Exit;
  _Start := GetTickCount;
  frmLogo.Show;
  frmLogo.ProgressBar1.Position := 0;
  frmLogo.ProgressBar1.Update;
  while not ready do
     begin
       Application.ProcessMessages;
       W := (GetTickCount-_Start);
//       if (W mod 1000)=0 then
//          begin
            frmLogo.ProgressBar1.Position := (W div 1000);
            frmLogo.ProgressBar1.Update;
//          end;
       if W>60000 then
          begin
            ready := false;
            Exit;
          end;
     end;
  frmLogo.ProgressBar1.Position := 100;
end;

function TfrmXsmIEBrowser.WaitRun:boolean;
var
  _Start:Int64;
begin
  _Start := GetTickCount;
  result := true;
  while Runed do
     begin
       Application.ProcessMessages;
       if (GetTickCount-_Start)>20000 then
          begin
            Runed := false;
            result := false;
          end;
     end;
end;

procedure TfrmXsmIEBrowser.ClearResource;
begin
  Send('getModule','clear');
end;

procedure TfrmXsmIEBrowser.SetSessionFail(const Value: boolean);
begin
  FSessionFail := Value;
end;

end.
