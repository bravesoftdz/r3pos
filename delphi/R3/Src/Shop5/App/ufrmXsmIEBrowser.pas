unit ufrmXsmIEBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ActnList, Menus, OleCtrls, SHDocVw, ExtCtrls,
  RzPanel, RzTabs, ImgList,LCContrllerLib, ZDataSet, StdCtrls;

type
  TfrmXsmIEBrowser = class(TfrmIEWebForm)
    LCObject: TLCObject;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FLogined: boolean;
    Fready: boolean;
    LoginError:string;
    FSessionFail: boolean;
    FCurid: string;
    Ffinish: boolean;
    Fconfirm: boolean;
    SaveHandle:THandle;
    FConnectTimeOut: integer;
    FCommandTimeOut: integer;
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
    procedure Setfinish(const Value: boolean);
    procedure Setconfirm(const Value: boolean);
    procedure DoMsgFilter(var Msg: TMsg; var Handled: Boolean);
    procedure SetCommandTimeOut(const Value: integer);
    procedure SetConnectTimeOut(const Value: integer);
    procedure LoadFormat;override;
    procedure SaveFormat;override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    procedure Connect;
    function EncodeXml(objectId:string):string;
    procedure Send(const szMethodName: WideString;const szPara: WideString);
    procedure Send2(const szMethodName: WideString;const szPara1: WideString;const szPara2: WideString);
    procedure Send3(const szMethodName: WideString;const szPara1: WideString;const szPara2: WideString;const szPara3: WideString);
    function WaitRun(WaitOutTime:integer=20000):boolean;
    procedure DoInit;
    procedure ReadInfo(checked:boolean=false);
    function DoLogin(Hinted:boolean=false):boolean;
    procedure ClearResource;
    function Open(sid,oid:string;hHandle:THandle):boolean;
    property Logined:boolean read FLogined write SetLogined;
    property ready:boolean read Fready write Setready;
    property SessionFail:boolean read FSessionFail write SetSessionFail;
    property finish:boolean read Ffinish write Setfinish;
    property confirm:boolean read Fconfirm write Setconfirm;
    property ConnectTimeOut:integer read FConnectTimeOut write SetConnectTimeOut;
    property CommandTimeOut:integer read FCommandTimeOut write SetCommandTimeOut;
  end;
var
  frmXsmIEBrowser:TfrmXsmIEBrowser;
implementation
uses uCaFactory,ufrmMain,uCtrlUtil,IniFiles,uShopGlobal,EncDec,ufrmLogo,ZLogFile,ufrmXsmLogin,
  ufrmDesk, uGlobal, MultInst;
{$R *.dfm}

{ TfrmXsmIEBrowser }

constructor TfrmXsmIEBrowser.Create(AOwner: TComponent);
var
  F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    ConnectTimeOut := F.ReadInteger('xsm','connectTimeout',60000);
    CommandTimeOut := F.ReadInteger('xsm','commandTimeout',30000);
  finally
    F.Free;
  end;
  FormStyle := fsMDIChild;
  left := -9000;
  try
    LCObject.OnFuncCall := DoFuncCall;
    LCObject.OnFuncCall2 := DoFuncCall2;
    LCObject.OnFuncCall3 := DoFuncCall3;
    Connect;
  except
    MessageBox(Handle,'系统没有检测到"新商盟接口组件",请检查软件是否正确安装?','友情提示...',MB_OK+MB_ICONWARNING);
  end;
end;

destructor TfrmXsmIEBrowser.Destroy;
begin
  runed := false;
  IEBrowser.Free;
//  LCObject.Close;
  inherited;
  frmXsmIEBrowser := nil;
end;

procedure TfrmXsmIEBrowser.DoFuncCall3(ASender: TObject;
  const szMethodName, szPara1, szPara2, szPara3: WideString);
begin
  runed := false;
  LogFile.AddLogFile(0,'FuncCall3:方法='+szMethodName+' 参数1='+szPara1+' 参数2='+szPara2+' 参数3='+szPara3);
end;

function TfrmXsmIEBrowser.DoLogin(Hinted:boolean=false):boolean;
var
  _Start:Int64;
  SaveLog:Boolean;
begin
  if not ready then Raise Exception.Create('系统装载新商盟运行环境无效.');
  SaveLog := frmLogo.Visible;
  if not SaveLog then frmLogo.Show;
  frmLogo.ShowTitle := '正在登录新商盟...';
  try
    SessionFail := false;
    Send2('login',xsm_username,xsm_password);
    if not WaitRun(commandTimeout) then Logined := false;
    result := Logined;
    if Hinted and not result then
       begin
         if LoginError='' then LoginError := '未错误类型...';
         LoginError := '登录新商盟失败了，错误:'+LoginError;
         MessageBox(Handle,pchar(LoginError),'友情提示...',MB_OK+MB_ICONINFORMATION);
       end;
  finally
    if not SaveLog then frmLogo.Close;
  end;
end;

procedure TfrmXsmIEBrowser.SetLogined(const Value: boolean);
begin
  FLogined := Value;
  SessionFail := false;
end;

procedure TfrmXsmIEBrowser.DoFuncCall(ASender: TObject; const szMethodName,
  szPara: WideString);
var Action:TAction;
begin
  if szMethodName='ready' then
     ready := true;
  if szMethodName='loginReady' then
     ready := true;
  if szMethodName='loginStatus' then
     begin
       Logined := (szPara='success');
       if szPara='getUrlconfigFail' then
          LoginError := '无效Url,代码:'+szPara
       else
       if szPara='serviceFail' then
          LoginError := '无效服务,代码:'+szPara
       else
       if szPara='approveFail' then
          LoginError := '登录新商盟的用户或密码无效，请重新设置....'
       else
       if szPara='getInforFail' then
          LoginError := '无效信息,代码:'+szPara
       else
          LoginError := '返回未知错误...';
     end;
  if szMethodName='sessionFail' then
     begin
       Logined := false;
       SessionFail := true;
       LoginError := 'Session失效了，请重新点击...';
     end;
  if szMethodName='windowClose' then
     begin
       PageHandle := 0;
       PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);

     end;
  if szMethodName='finish' then
     begin
       finish := (szPara = 'finish');
       confirm := (szPara = 'confirm');
     end;
  if szMethodName='kickOut' then
     begin
       Logined := false;
     end;
  if szMethodName='loginReady' then
     Logined := true;
  runed := false;
  LogFile.AddLogFile(0,'FuncCall:方法='+szMethodName+' 参数1='+szPara);
end;

procedure TfrmXsmIEBrowser.DoFuncCall2(ASender: TObject;
  const szMethodName, szPara1, szPara2: WideString);
var s:string;
begin
  if szMethodName='loginStatus' then
     begin
       Logined := (szPara1='success');
       if szPara1='getUrlconfigFail' then
          LoginError := '无效Url,代码:'+szPara1
       else
       if szPara1='serviceFail' then
          LoginError := '无效服务,代码:'+szPara1
       else
       if szPara1='approveFail' then
          LoginError := '登录新商盟的用户或密码无效，请重新设置....'
       else
       if szPara1='getInforFail' then
          LoginError := '无效信息,代码:'+szPara1
       else
          LoginError := '返回未知错误...';
       xsm_signature := szPara2;
     end;
  if szMethodName='error' then
     begin
        s := szPara2;
        MessageBox(Handle,Pchar('<新商盟>'+ s +'<code='+szPara1+'>'),'友情提示...',MB_OK+MB_ICONWARNING);
     end;
  runed := false;
  LogFile.AddLogFile(0,'FuncCall2:方法='+szMethodName+' 参数1='+szPara1+' 参数2='+szPara2);
end;

procedure TfrmXsmIEBrowser.Connect;
var r:integer;
begin
  LCObject.UnRegisterLC('_R3_XSM');
  LCObject.UnRegisterLC('_XSM_R3');
  r := LCObject.Connect('_XSM_R3');
  if r<>0 then LogFile.AddLogFile(0,'初始化新商盟LCObject失败，失败代码:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Send(const szMethodName, szPara: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send('_R3_XSM',szMethodName,szPara);
  LogFile.AddLogFile(0,'发送<'+szMethodName+'>p1='+szPara+'，代码:'+inttostr(r))
end;

procedure TfrmXsmIEBrowser.Send2(const szMethodName, szPara1,
  szPara2: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send2('_R3_XSM',szMethodName,szPara1,szPara2);
  LogFile.AddLogFile(0,'发送<'+szMethodName+'>p1='+szPara1+',p2='+szPara2+'，代码:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Send3(const szMethodName, szPara1, szPara2,
  szPara3: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send3('_R3_XSM',szMethodName,szPara1,szPara2,szPara3);
  LogFile.AddLogFile(0,'发送<'+szMethodName+'>p1='+szPara1+',p2='+szPara2+',p3='+szPara3+'，代码:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;
//  FormStyle := fsNormal;
end;

function TfrmXsmIEBrowser.Open(sid, oid: string;hHandle:THandle):boolean;
begin
  if Runed then Raise Exception.Create('正在等待新商盟响应...');
  SaveHandle := PageHandle;
  try
  PageHandle := hHandle;
  WindowState := wsMaximized;
  BringToFront;
  result := false;
  if not CaFactory.Audited then
     begin
       MessageBox(Handle,'脱机状态不能进入此模块...','友情提示...',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  if not Logined then
     begin
       if SessionFail then DoLogin;
       if not Logined and TfrmXsmLogin.XsmRegister then
          begin
            if not DoLogin(True) then
               Open(sid,oid,hHandle);
          end
       else
          Exit;
     end;
  finish := false;
  confirm := false;
  Send3('getModule',sid,EncodeXml(oid),'clear');
  if not WaitRun(commandTimeout) then Exit;
  if SessionFail then //失效了，自动重新请求
     begin
       result := Open(sid,oid,hHandle);
       Exit;
     end;
  if confirm then
     begin
       if MessageBox(Handle,'当前窗体正在编辑状态，是否取消操作?','友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
          begin
            Send3('getModule',sid,EncodeXml(oid),'force');
            if not WaitRun(commandTimeout) then Exit;
          end;
     end;
  result := true;
  finally
    if not result then PageHandle := SaveHandle;
  end;
end;

procedure TfrmXsmIEBrowser.Setready(const Value: boolean);
begin
  Fready := Value;
end;

procedure TfrmXsmIEBrowser.DoInit;
var
  _Start,W:Int64;
  F:TIniFile;
  List:TStringList;
begin
  ready := false;
  SessionFail := false;
  Runed := true;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    xsm_url := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if xsm_url='' then xsm_url := ExtractFilePath(ParamStr(0))+'xsm\xsm.html'
       else
       begin
         List.CommaText := xsm_url;
         xsm_url := List.Values['xsm'];
       end;
    Left := -9000;
    IEBrowser.Navigate(xsm_url);
  finally
    List.free;
    F.Free;
  end;
  if not WaitRun(commandTimeout) then Exit;
  frmDesk.Waited := true;
  try
  _Start := GetTickCount;
  frmLogo.Show;
  frmLogo.ProgressBar1.Position := 0;
  frmLogo.ProgressBar1.Update;
  while not ready do
     begin
//       windows.WaitForSingleObject(FhEvent,500);
       Application.ProcessMessages;
       W := (GetTickCount-_Start);
//       if (W mod 1000)=0 then
//          begin
       frmLogo.ProgressBar1.Position := (W div 500);
       frmLogo.ProgressBar1.Update;
//          end;
       if W>ConnectTimeOut then
          begin
            ready := false;
            Exit;
          end;
     end;
  frmLogo.ProgressBar1.Position := 100;
  finally
    frmDesk.Waited := false;
  end;
end;

function TfrmXsmIEBrowser.WaitRun(WaitOutTime:integer=20000):boolean;
var
  _Start,W:Int64;
  s:boolean;
begin
  _Start := GetTickCount;
  result := true;
  _Start := GetTickCount;
  s := frmLogo.Visible;
  if not s then frmLogo.Show;
  frmLogo.ProgressBar1.Position := 1;
  frmLogo.ProgressBar1.Update;
//  Application.OnMessage := DoMsgFilter;
  frmDesk.Waited := true;
  try
  while Runed do
     begin
//       windows.MsgWaitForMultipleObjects(1,FhEvent,False,500,QS_ALLINPUT);
       Application.ProcessMessages;
       W := (GetTickCount-_Start);
       frmLogo.BringToFront;
       frmLogo.ProgressBar1.Position := (W div 500);
       frmLogo.ProgressBar1.Update;
       if (GetTickCount-_Start)>WaitOutTime then
          begin
            Runed := false;
            result := false;
            LoginError := '请求超时了....';
          end;
     end;
  finally
//    Application.OnMessage := nil;
    frmDesk.Waited := false;
    if not s then frmLogo.Close;
    Runed := false;
  end;
end;

procedure TfrmXsmIEBrowser.ClearResource;
begin
  Send('getModule','clear');
  WaitRun(commandTimeout);
end;

procedure TfrmXsmIEBrowser.SetSessionFail(const Value: boolean);
begin
  FSessionFail := Value;
end;

procedure TfrmXsmIEBrowser.ReadInfo(checked:boolean=false);
var
  cdsUnion:TZQuery;
begin
  if checked and not Factor.Connected then Exit;
  cdsUnion := TZQuery.Create(nil);
  try
    cdsUnion.Close;
    cdsUnion.SQL.Text := 'select XSM_CODE,XSM_PSWD from CA_SHOP_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='''+Global.SHOP_ID+'''';
    Factor.Open(cdsUnion);
    xsm_username := cdsUnion.Fields[0].AsString;
    xsm_password := DecStr(cdsUnion.Fields[1].AsString,ENC_KEY);
  finally
    cdsUnion.Free;
  end;
end;

procedure TfrmXsmIEBrowser.Setfinish(const Value: boolean);
begin
  Ffinish := Value;
end;

procedure TfrmXsmIEBrowser.Setconfirm(const Value: boolean);
begin
  Fconfirm := Value;
end;

procedure TfrmXsmIEBrowser.DoMsgFilter(var Msg: TMsg;
  var Handled: Boolean);
begin
//  if Msg.message =
end;

procedure TfrmXsmIEBrowser.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  inherited;

end;

procedure TfrmXsmIEBrowser.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;

end;

function TfrmXsmIEBrowser.EncodeXml(objectId: string): string;
begin
  result := objectId;
  result := stringreplace(result,'&nbsp;',' ',[rfReplaceAll]);//'<onClick><action object_id="'+objectId+'" method="POST" isPopUp="true" name="'+Caption+'"/></onClick>';
  result := stringreplace(result,'&quot;','"',[rfReplaceAll]);//'<onClick><action object_id="'+objectId+'" method="POST" isPopUp="true" name="'+Caption+'"/></onClick>';
end;

procedure TfrmXsmIEBrowser.SetCommandTimeOut(const Value: integer);
begin
  FCommandTimeOut := Value;
end;

procedure TfrmXsmIEBrowser.SetConnectTimeOut(const Value: integer);
begin
  FConnectTimeOut := Value;
end;

procedure TfrmXsmIEBrowser.LoadFormat;
begin
//  inherited;

end;

procedure TfrmXsmIEBrowser.SaveFormat;
begin
//  inherited;

end;

end.
