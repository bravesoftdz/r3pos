unit ufrmXsmIEBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmIEWebForm, ActnList, Menus, OleCtrls, SHDocVw, ExtCtrls,
  RzPanel, RzTabs, ImgList,LCContrllerLib, ZDataSet, StdCtrls, msxml, ActiveX, ComObj,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdCookieManager;

type
  TfrmXsmIEBrowser = class(TfrmIEWebForm)
    LCObject: TLCObject;
    IdHTTP1: TIdHTTP;
    IdCookieManager1: TIdCookieManager;
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

    //�����˵�¼
    function CreateXML(xml:string):IXMLDomDocument;
    function GetChallenge:boolean;
    function DoForLogin(checked:boolean=false):boolean;
    function GetSignature:boolean;
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
    procedure DoInit(Wait:boolean=false);
    procedure ReadInfo(checked:boolean=false);
    function DoLogin(Hinted:boolean=false):boolean;
    function XsmLogin(checked:boolean=false):boolean;
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
  SessionFail := true;
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
    MessageBox(Handle,'ϵͳû�м�⵽"�����˽ӿ����",��������Ƿ���ȷ��װ?','������ʾ...',MB_OK+MB_ICONWARNING);
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
  LogFile.AddLogFile(0,'FuncCall3:����='+szMethodName+' ����1='+szPara1+' ����2='+szPara2+' ����3='+szPara3);
end;

function TfrmXsmIEBrowser.DoLogin(Hinted:boolean=false):boolean;
var
  _Start:Int64;
  SaveLog:Boolean;
begin
  result := false;
  if not ready then
     begin
       MessageBox(Handle,'ϵͳװ�����������л�����Ч,���Ժ�����.','������ʾ...',MB_OK+MB_ICONWARNING);
       Exit;
     end;
  SaveLog := frmLogo.Visible;
  if not SaveLog then frmLogo.Show;
  frmLogo.ShowTitle := '���ڵ�¼������...';
  try
    GetSignature;
//    SessionFail := false;
//    Send2('login',xsm_username,xsm_password);
    Send('login',xsm_signature);
    if not WaitRun(commandTimeout) then Logined := false;
    result := Logined;
    if Hinted and not result then
       begin
         if LoginError='' then LoginError := 'δ��������...';
         LoginError := '��¼������ʧ���ˣ�����:'+LoginError;
         MessageBox(Handle,pchar(LoginError),'������ʾ...',MB_OK+MB_ICONINFORMATION);
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
          LoginError := '��ЧUrl,����:'+szPara
       else
       if szPara='serviceFail' then
          LoginError := '��Ч����,����:'+szPara
       else
       if szPara='approveFail' then
          LoginError := '��¼�����˵��û���������Ч������������....'
       else
       if szPara='getInforFail' then
          LoginError := '��Ч��Ϣ,����:'+szPara
       else
          LoginError := '����δ֪����...';
     end;
  if szMethodName='sessionFail' then
     begin
       Logined := false;
       SessionFail := true;
       LoginError := 'SessionʧЧ�ˣ������µ��...';
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
  LogFile.AddLogFile(0,'FuncCall:����='+szMethodName+' ����1='+szPara);
end;

procedure TfrmXsmIEBrowser.DoFuncCall2(ASender: TObject;
  const szMethodName, szPara1, szPara2: WideString);
var s:string;
begin
  if szMethodName='loginStatus' then
     begin
       Logined := (szPara1='success');
       if szPara1='getUrlconfigFail' then
          LoginError := '��ЧUrl,����:'+szPara1
       else
       if szPara1='serviceFail' then
          LoginError := '��Ч����,����:'+szPara1
       else
       if szPara1='approveFail' then
          LoginError := '��¼�����˵��û���������Ч������������....'
       else
       if szPara1='getInforFail' then
          LoginError := '��Ч��Ϣ,����:'+szPara1
       else
          LoginError := '����δ֪����...';
       xsm_signature := szPara2;
     end;
  if szMethodName='error' then
     begin
        s := utf8toAnsi(szPara2);
        frmDesk.Waited := false;
        MessageBox(Handle,Pchar('<������>'+ s +'<code='+szPara1+'>'),'������ʾ...',MB_OK+MB_ICONWARNING);
     end;
  runed := false;
  LogFile.AddLogFile(0,'FuncCall2:����='+szMethodName+' ����1='+szPara1+' ����2='+szPara2);
end;

procedure TfrmXsmIEBrowser.Connect;
var r:integer;
begin
  LCObject.UnRegisterLC('_R3_XSM');
  LCObject.UnRegisterLC('_XSM_R3');
  r := LCObject.Connect('_XSM_R3');
  if r<>0 then LogFile.AddLogFile(0,'��ʼ��������LCObjectʧ�ܣ�ʧ�ܴ���:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Send(const szMethodName, szPara: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send('_R3_XSM',szMethodName,szPara);
  LogFile.AddLogFile(0,'����<'+szMethodName+'>p1='+szPara+'������:'+inttostr(r))
end;

procedure TfrmXsmIEBrowser.Send2(const szMethodName, szPara1,
  szPara2: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send2('_R3_XSM',szMethodName,szPara1,szPara2);
  LogFile.AddLogFile(0,'����<'+szMethodName+'>p1='+szPara1+',p2='+szPara2+'������:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.Send3(const szMethodName, szPara1, szPara2,
  szPara3: WideString);
var r:integer;
begin
  runed := true;
  r := LCObject.Send3('_R3_XSM',szMethodName,szPara1,szPara2,szPara3);
  LogFile.AddLogFile(0,'����<'+szMethodName+'>p1='+szPara1+',p2='+szPara2+',p3='+szPara3+'������:'+inttostr(r));
end;

procedure TfrmXsmIEBrowser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;
//  FormStyle := fsNormal;
end;

function TfrmXsmIEBrowser.Open(sid, oid: string;hHandle:THandle):boolean;
begin
  SaveHandle := PageHandle;
  try
  PageHandle := hHandle;
  WindowState := wsMaximized;
  BringToFront;
  result := false;
  if Runed then 
     begin
       MessageBox(Handle,'���ڵȴ���������Ӧ...','������ʾ...',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  if not CaFactory.Audited then
     begin
       MessageBox(Handle,'�ѻ�״̬���ܽ����ģ��...','������ʾ...',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  if SessionFail then XsmLogin(false);
  if SessionFail then
     begin
       if TfrmXsmLogin.XsmRegister then
          begin
            if not XsmLogin(false) then
               Open(sid,oid,hHandle);
          end
       else
          Exit;
     end;
  if not Logined then
     begin
        if not DoLogin(True) then
           begin
             if SessionFail then Open(sid,oid,hHandle);
             Exit;
           end;
     end;
  finish := false;
  confirm := false;
  Send3('getModule',sid,EncodeXml(oid),'clear');
  if not WaitRun(commandTimeout) then Exit;
  if SessionFail then //ʧЧ�ˣ��Զ���������
     begin
       result := Open(sid,oid,hHandle);
       Exit;
     end;
  if confirm then
     begin
       if MessageBox(Handle,'��ǰ�������ڱ༭״̬���Ƿ�ȡ������?','������ʾ...',MB_YESNO+MB_ICONQUESTION)=6 then
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

procedure TfrmXsmIEBrowser.DoInit(Wait:boolean=false);
var
  _Start,W:Int64;
  F:TIniFile;
  List:TStringList;
begin
  ready := false;
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
  if Wait then
     begin
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
            LoginError := '����ʱ��....';
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

function TfrmXsmIEBrowser.GetChallenge: boolean;
var
  F:TIniFile;
  List:TStringList;
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  xml:string;
begin
  result := false;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    xsm_center := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if xsm_center='' then xsm_center := 'http://preview.xinshangmeng.com/st/' 
       else
       begin
         List.CommaText := xsm_center;
         xsm_center := List.Values['xsmc'];
       end;
    xml := IdHTTP1.Get(xsm_center+'users/forlogin');
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('�����¼ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ�������У����ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ�������У����ʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('����У����ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
    xsm_challenge := Root.childNodes[0].text;
    result := true;
  finally
    List.free;
    F.Free;
  end;
end;

function TfrmXsmIEBrowser.DoForLogin(checked:boolean=false): boolean;
const
  dec='{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}';
function md5(s:string):string;
begin
  result := md5Encode(s+dec);
end;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;    
  xml:string;
begin
  xsm_signature := IdHTTP1.Get(xsm_center+'users/dologin/up?j_username='+xsm_username+'&j_password='+md5(md5(xsm_password)+xsm_challenge));
  xml := Utf8ToAnsi(xsm_signature);
  Doc := CreateXML(xml);
  xsm_signature := xml;
  if not Assigned(doc) then Raise Exception.Create('�����¼ʧ��...');
  Root :=  doc.DocumentElement;
  if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
  if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
  if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('�����¼ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
  result := true;
end;

function TfrmXsmIEBrowser.CreateXML(xml: string): IXMLDomDocument;
var
  ErrXml:string;
  w:integer;
begin
  if Global.debug then LogFile.AddLogFile(0,xml);
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    if xml<>'' then
       begin
         if not result.loadXML(xml) then
            begin
              ErrXml :=xml;
              w := pos('?>',ErrXml);
              delete(ErrXml,1,w+1);
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml������,xml='+xml);
            end;
       end
    else
       Raise Exception.Create('xml�ַ�������Ϊ��...');
  except
    result := nil;
    Raise;
  end;
end;

function TfrmXsmIEBrowser.XsmLogin(checked:boolean=false): boolean;
begin
  try
    if not checked then ReadInfo(checked);
    SessionFail := true;
    result := GetChallenge;
    result := DoForLogin(checked);
    SessionFail := not result;
  except
    on E:Exception do
       begin
         SessionFail := true;
         Logined := false;
         result := false;
         MessageBox(Handle,Pchar('��¼������'+E.Message),'������ʾ..',MB_OK+MB_ICONINFORMATION);
       end;
  end;
end;

function TfrmXsmIEBrowser.GetSignature: boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;    
  xml:string;
begin
  try
    xsm_signature := IdHTTP1.Get(xsm_center+'users/gettoken');
    xml := Utf8ToAnsi(xsm_signature);
    Doc := CreateXML(xml);
    xsm_signature := xml;
    if not Assigned(doc) then Raise Exception.Create('��������ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('��������ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
    result := true;
  except
    SessionFail := true;
    Raise;
  end;
end;

end.
