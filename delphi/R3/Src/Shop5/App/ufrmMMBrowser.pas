unit ufrmMMBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, OleCtrls, SHDocVw, ExtCtrls, RzPanel,
  ummFactory, ZBase, HTTPApp, XMLDoc, msxml, ActiveX, ComObj;

const
  READYSTATE_UNINITIALIZED = $00000000;
  READYSTATE_LOADING = $00000001;
  READYSTATE_LOADED = $00000002;
  READYSTATE_INTERACTIVE = $00000003;
  READYSTATE_COMPLETE = $00000004;

type
  TLCStatus=(lcNone,lcRuning,lcFinish,lcError,lcStoped,lcTimeOut);

  TfrmMMBrowser = class(TfrmBasic)
    RzPanel2: TRzPanel;
    IEBrowser: TWebBrowser;
    procedure IEBrowserTitleChange(Sender: TObject;
      const Text: WideString);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FxsmSenceReady: boolean;
    FxsmReady: boolean;
    FxsmSessionFail: boolean;
    FxsmSenceId: string;
    FxsmFinish: boolean;
    FxsmLogined: boolean;
    LoginError:string;
    IETitle:string;
    FxsmLCStatus: TLCStatus;
    FrimLogined: boolean;
    FrimcustId: string;
    FrimcomId: string;
    function getReadyState: integer;
    procedure SetxsmSenceReady(const Value: boolean);
    procedure SetxsmReady(const Value: boolean);
    procedure SetxsmSessionFail(const Value: boolean);
    procedure SetxsmSenceId(const Value: string);
    procedure SetxsmFinish(const Value: boolean);
    procedure SetxsmLogined(const Value: boolean);
    procedure SetxsmLCStatus(const Value: TLCStatus);
    function getxsmUrl: string;
    procedure SetrimLogined(const Value: boolean);
    function getrimUrl: string;
    procedure SetrimcomId(const Value: string);
    procedure SetrimcustId(const Value: string);
    function getrimLogined: boolean;
    function getmmcReady: boolean;
    { Private declarations }
  protected
    function CreateXML(xml:string):IXMLDomDocument;
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    
    function EncodeXml(objectId:string):string;
    function IEOpen(url:string;WaitFor:boolean=false):boolean;
    procedure IERefresh;

    //新商盟登录
    function XsmLogin(Waitfor:boolean=true):boolean;
    //RIM后台登录
    function RimLogin(Waitfor:boolean=true):boolean;

    //Lc接口指令集
    function CreateLoginFava:TmmLCControlFava;
    function CreateOpenFava(sid,oid:string):TmmLCControlFava;
    function LCRecv(msg:TmmLCControlFava):boolean;
    function LCSend(msg:TmmLCControlFava;TimeOut:integer=20000):boolean;
    function MsgRecv(szPara1,szPara2,szPara3:string):boolean;
    //end;

    property ReadyState:integer read getReadyState;
    property mmcReady:boolean read getmmcReady;
    //新商盟
    property xsmUrl:string read getxsmUrl;
    property xsmReady:boolean read FxsmReady write SetxsmReady;
    property xsmSessionFail:boolean read FxsmSessionFail write SetxsmSessionFail;
    property xsmSenceReady:boolean read FxsmSenceReady write SetxsmSenceReady;
    property xsmSenceId:string read FxsmSenceId write SetxsmSenceId;
    property xsmFinish:boolean read FxsmFinish write SetxsmFinish;
    property xsmLogined:boolean read FxsmLogined write SetxsmLogined;
    property xsmLCStatus:TLCStatus read FxsmLCStatus write SetxsmLCStatus;
    //RIM后台
    property rimLogined:boolean read getrimLogined write SetrimLogined;
    property rimcomId:string read FrimcomId write SetrimcomId;
    property rimcustId:string read FrimcustId write SetrimcustId;
    property rimUrl:string read getrimUrl;

  end;
  
implementation
uses ummGlobal, ufrmHintMsg, IniFiles, ufrmMain,ufrmLogo, ZLogFile, uMsgBox, ufrmDesk, uGlobal;
{$R *.dfm}

{ TfrmMMBrowser }

function TfrmMMBrowser.CreateLoginFava: TmmLCControlFava;
begin
  result := TmmLCControlFava.Create;
  result.szMethodName := 'login';
  result.mmFlag := 2;
  result.szPara1 := mmGlobal.xsm_signature;
  result.szPara2 := xsmSenceId;
end;

function TfrmMMBrowser.EncodeXml(objectId: string): string;
begin
  result := objectId;
  result := stringreplace(result,'&nbsp;',' ',[rfReplaceAll]);
  result := stringreplace(result,'&quot;','"',[rfReplaceAll]);
end;

function TfrmMMBrowser.getReadyState: integer;
begin
  result := IEBrowser.ReadyState;
end;

function TfrmMMBrowser.IEOpen(url: string;WaitFor:boolean=false): boolean;
var
  _Start:int64;
begin
  result := false;
  _Start := GetTickCount;
  IEBrowser.Navigate(url);
  Application.ProcessMessages;
  if WaitFor then
     begin
        while ReadyState <> READYSTATE_COMPLETE do
          begin
             frmLogo.BringToFront;
             Application.ProcessMessages;
             if (GetTickCount-_Start)>100000 then Exit;
          end;
     end;
  result := true;
end;

procedure TfrmMMBrowser.IERefresh;
begin
  xsmReady := false;
  xsmSessionFail := true;
  xsmSenceReady := false;
  xsmLogined := false;
  IEBrowser.Refresh;
end;

function TfrmMMBrowser.LCRecv(msg: TmmLCControlFava): boolean;
begin
  try
//一个参数
  if msg.szMethodName='ready' then
     begin
       xsmReady := true;
       xsmLCStatus := lcFinish;
       if xsmSessionFail then Exit;
       XsmLogin(false);
     end;
  if msg.szMethodName='loginReady' then
     begin
       xsmReady := true;
       xsmLCStatus := lcFinish;
     end;
  if msg.szMethodName='loginStatus' then
     begin
       xsmLogined := (msg.szPara1='success');
       if msg.szPara1='getUrlconfigFail' then
          LoginError := '无效Url,代码:'+msg.szPara1
       else
       if msg.szPara1='serviceFail' then
          LoginError := '无效服务,代码:'+msg.szPara1
       else
       if msg.szPara1='approveFail' then
          LoginError := '登录新商盟的用户或密码无效，请重新设置....'
       else
       if msg.szPara1='getInforFail' then
          LoginError := '无效信息,代码:'+msg.szPara1
       else
          LoginError := '返回未知错误...';
       xsmSenceReady := xsmLogined;
       xsmSessionFail := not xsmLogined;
       if not xsmLogined then
         begin
           xsmLCStatus := lcError;
           PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);
         end
       else
         xsmLCStatus := lcFinish;
     end;
  if msg.szMethodName='sessionFail' then
     begin
       xsmLCStatus := lcFinish;
       mmGlobal.Logined := false;
       IERefresh;
       PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);
     end;
  if msg.szMethodName='windowClose' then
     begin
       xsmLCStatus := lcFinish;
       PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);
     end;
  if msg.szMethodName='finish' then
     begin
       xsmLCStatus := lcFinish;
       xsmfinish := (msg.szPara1 = 'finish') or (msg.szPara1 = 'ready');
       if (msg.szPara1 = 'refuse') then xsmLCStatus := lcStoped;
     end;
  if msg.szMethodName='kickOut' then
     begin
       xsmLCStatus := lcFinish;
       mmGlobal.Logined := false;
       IERefresh;
       PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);
     end;
//两个参数
  if msg.szMethodName='error' then
     begin
        xsmLCStatus := lcError;
        frmDesk.Waited := false;
        frmLogo.Close;
        if (msg.szPara1='9901') or (msg.szPara1='9001') then
           ShowMsgBox('<新商盟>网络连接异常请重新尝试','友情提示...',MB_OK+MB_ICONWARNING)
        else
        if (msg.szPara1='9902') then
           begin
             IETitle := 'error';
             ShowMsgBox('<新商盟>请关闭IE版的新商盟再重试','友情提示...',MB_OK+MB_ICONWARNING);
           end
        else
           begin
             if msg.szPara1='9904' then
                begin
                   IERefresh;
                   PostMessage(frmMain.Handle,WM_DESKTOP_REQUEST,0,0);
                end;
             ShowMsgBox('<新商盟>其他错误异常请重新尝试','友情提示...',MB_OK+MB_ICONWARNING);
           end;
     end;

//三个参数
  if msg.szMethodName='MsgNotify' then //接收消息
     begin
       xsmLCStatus := lcFinish;
       MsgRecv(msg.szPara1,msg.szPara2,msg.szPara3);
     end;

   case msg.mmFlag of
   1:LogFile.AddLogFile(0,'FuncCall1:方法='+msg.szMethodName+' 参数1='+msg.szPara1);
   2:LogFile.AddLogFile(0,'FuncCall2:方法='+msg.szMethodName+' 参数1='+msg.szPara1+' 参数2='+msg.szPara2);
   3:LogFile.AddLogFile(0,'FuncCall3:方法='+msg.szMethodName+' 参数1='+msg.szPara1+' 参数2='+msg.szPara2+' 参数3='+msg.szPara3);
   end;

     msg.free;
  except
     on E:Exception do
        begin
           msg.free;
           LogFile.AddLogFile(0,E.Message);
        end;
  end;
end;

function TfrmMMBrowser.LCSend(msg: TmmLCControlFava;TimeOut:integer=20000): boolean;
var
  _Start:Int64;
begin
  frmDesk.Waited := true;
  try
    result := false;
    xsmLCStatus := lcRuning;
    _Start := GetTickCount;
    if msg.mmFlag > 0 then mmFactory.mmcLcControlFava(msg);
    while xsmLCStatus = lcRuning do
      begin
        if (GetTickCount-_Start)>TimeOut then
           begin
             xsmLCStatus := lcTimeOut;
             break;
           end;
        frmLogo.BringToFront;
        Application.ProcessMessages;
      end;
    result := (xsmLCStatus=lcFinish) and not xsmSessionFail;
  finally
    frmDesk.Waited := false;
    msg.Free;
  end;
end;

procedure TfrmMMBrowser.SetxsmSenceReady(const Value: boolean);
begin
  FxsmSenceReady := Value;
end;

procedure TfrmMMBrowser.SetxsmReady(const Value: boolean);
begin
  FxsmReady := Value;
end;

procedure TfrmMMBrowser.SetxsmSessionFail(const Value: boolean);
begin
  FxsmSessionFail := Value;
end;

procedure TfrmMMBrowser.SetxsmSenceId(const Value: string);
begin
  FxsmSenceId := Value;
end;

constructor TfrmMMBrowser.Create(AOwner: TComponent);
begin
  inherited;
  Set8087CW(Longword($133f));
  xsmSessionFail := true;
  xsmSenceId := 'GWGC';
  xsmSenceReady := false;
  xsmReady := false;
  FormStyle := fsMDIChild;
  left := -9000;
end;

destructor TfrmMMBrowser.Destroy;
begin

  inherited;
end;

procedure TfrmMMBrowser.SetxsmFinish(const Value: boolean);
begin
  FxsmFinish := Value;
end;

procedure TfrmMMBrowser.SetxsmLogined(const Value: boolean);
begin
  FxsmLogined := Value;
end;

procedure TfrmMMBrowser.IEBrowserTitleChange(Sender: TObject;
  const Text: WideString);
begin
  inherited;
  IETitle := Text;
  LogFile.AddLogFile(0,IETitle);
end;

procedure TfrmMMBrowser.SetxsmLCStatus(const Value: TLCStatus);
begin
  FxsmLCStatus := Value;
end;

function TfrmMMBrowser.XsmLogin(Waitfor:boolean=true): boolean;
begin
  if not mmcReady then Raise Exception.Create('新商盟插件初始化失败了，请重进系统试试吧');  
  frmLogo.Show;
  try
    frmLogo.ShowTitle := '正在初始化新商盟...';
    xsmLogined := false;
    xsmSessionFail := true;
    xsmSenceReady := false;
    result := false;
    if (pos('新商盟',IETitle)<=0) or not xsmReady then
       begin
         if IEOpen(getxsmUrl,true) then LCSend(TmmLCControlFava.Create,30000);
         if not xsmReady then Raise Exception.Create('新商盟初始化失败了，请重新试试吧。');
       end;
    if not mmGlobal.getSignature then Exit;
    frmLogo.ShowTitle := '正在登录新商盟...';
    LCSend(CreateLoginFava);
    if xsmSessionFail or not xsmLogined then Raise Exception.Create('新商盟会话失效了，请重新试试吧。');
    result := xsmLogined;
  finally
    frmLogo.Close;
  end;
  if not result then
     begin
       Raise Exception.Create(LoginError); 
     end;
end;

function TfrmMMBrowser.getxsmUrl: string;
var
  F:TIniFile;
  List:TStringList;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    result := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if result='' then Raise Exception.Create('系统没找到新商盟的参数，无法进行新商盟.'); 

    List.CommaText := result;
    result := List.Values['xsm'];
  finally
    List.free;
    try
      F.Free;
    except
    end;
  end;
end;

function TfrmMMBrowser.CreateOpenFava(sid,oid:string): TmmLCControlFava;
begin
  result := TmmLCControlFava.Create;
  if oid='' then
     begin
       result.szMethodName := 'getScene';
       result.mmFlag := 1;
     end
  else
     begin
       result.szMethodName := 'getModule';
       result.mmFlag := 2;
     end;
  result.szPara1 := sid;
  result.szPara2 := EncodeXml(oid);
end;

procedure TfrmMMBrowser.SetrimLogined(const Value: boolean);
begin
  FrimLogined := Value;
end;

function TfrmMMBrowser.RimLogin(Waitfor: boolean): boolean;
var
  Params:TftParamList;
  Msg:string;
begin
  frmLogo.Show;
  try
   RimLogined := false;
   Params := TftParamList.Create(nil);
   try
     Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
     Msg := Global.RemoteFactory.ExecProc('TRimWsdlService',Params);
     Params.Decode(Params,Msg);
     rimcomId := Params.ParambyName('rimcid').AsString;
     rimcustId := Params.ParambyName('xsmuid').AsString;
     if rimcustId='' then rimcustId := Params.ParambyName('rimuid').AsString;
     if rimcustId='' then Raise Exception.Create('当前登录门店的许可证号无效，请输入修改正确的许可证号.');
   finally
     Params.Free;
   end;
   if not mmGlobal.Logined then Exit;
   if not mmGlobal.getSignature then Exit;

   IEOpen(rimUrl+'xsmReg/reg.action?CTOKEN='+HTTPEncode(mmGlobal.xsm_signature)+'&CUST_ID='+rimcustId,true);
   Application.ProcessMessages;
   rimLogined := (copy(IETitle,1,6)='<0000>');
   result := rimLogined;
  finally
    frmLogo.Close;
  end;
   if not result then
      begin
        mmGlobal.Logined := false;
        Raise Exception.Create(IETitle);
      end;
end;

function TfrmMMBrowser.getrimUrl: string;
var
  F:TIniFile;
  List:TStringList;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    result := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');

    List.CommaText := result;
    result := List.Values['rim'];
    if result<>'' then
       begin
         if result[Length(result)]<>'/' then result := result+'/';
       end;
  finally
    List.free;
    try
      F.Free;
    except
    end;
  end;
end;

procedure TfrmMMBrowser.SetrimcomId(const Value: string);
begin
  FrimcomId := Value;
end;

procedure TfrmMMBrowser.SetrimcustId(const Value: string);
begin
  FrimcustId := Value;
end;

function TfrmMMBrowser.getrimLogined: boolean;
begin
  result := FrimLogined and (rimcustId<>'');
end;

procedure TfrmMMBrowser.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  left := - 90000;
  if Assigned(OnFreeForm) then OnFreeForm(self);

end;

function TfrmMMBrowser.getmmcReady: boolean;
begin
  result := mmFactory.mmcReady;
end;

function TfrmMMBrowser.MsgRecv(szPara1,szPara2,szPara3: string): boolean;
var
  Msg:PMsgInfo;
  Doc:IXMLDomDocument;
  Node:IXMLDOMNode;
begin
  Doc := CreateXml(szPara3);
  if Doc=nil then Exit;
  Node := Doc.documentElement;
  if Node=nil then Exit;
  try
    Msg := MsgFactory.FindMsg(FindElement(Node,'id').text);
    if Msg=nil then
    begin
      new(Msg);
      Msg^.SenceId := szPara1;
      Msg^.Action := szPara2;
      Msg^.ID := FindElement(Node,'id').text;
      Msg^.Title := FindElement(Node,'title').text;
      Msg^.Contents := FindElement(Node,'content').text;
      Msg^.SndDate := FindElement(Node,'sendDate').text;
      Msg^.Msg_Class := 0;
      Msg^.sFlag := 100;
      MsgFactory.Add(Msg);
      MsgFactory.MsgRead[Msg] := False;
      MsgFactory.Opened := true;
    end
  except
    on E:Exception do
       LogFile.AddLogFile(0,'处理消息出错了'+e.Message);
  end;
end;

function TfrmMMBrowser.CreateXML(xml: string): IXMLDomDocument;
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
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml出错了,xml='+xml);
            end;
       end
    else
       Raise Exception.Create('xml字符串不能为空...');
  except
    on E:Exception do
       begin
         result := nil;
         LogFile.AddLogFile(0,e.Message);
       end;
  end;
end;

function TfrmMMBrowser.FindElement(root: IXMLDOMNode;
  s: string): IXMLDOMNode;
var
  i:integer;
begin
  result := root.firstChild;
  while result<>nil do
    begin
      if result.nodeName=s then exit;
      result := result.nextSibling;
    end;
  result := nil;
end;

end.
