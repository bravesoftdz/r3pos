unit ummGlobal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uGlobal, IdBaseComponent, IdComponent, IdTCPConnection, msxml,
  IdTCPClient, IdHTTP, ZLogFile, ComObj, IdCookieManager, ZDataSet, ZBase, uShopGlobal,
  DB, ZAbstractRODataset, ZAbstractDataset, ummFactory,IdCookie;

type
  TmmGlobal = class(TShopGlobal)
    IdCookieManager1: TIdCookieManager;
    IdHTTP1: TIdHTTP;
    procedure DataModuleCreate(Sender: TObject);
    procedure IdCookieManager1NewCookie(ASender: TObject;
      ACookie: TIdCookieRFC2109; var VAccept: Boolean);
  private
    Fxsm_password: string;
    Fxsm_username: string;
    Fxsm_challenge: string;
    FLogined: boolean;
    Fxsm_signature: string;
    Fchat_port: integer;
    Fchat_addr: string;
    Fhttp_addr: string;
    Fxsm_parentComId: string;
    Fxsm_comId: string;
    procedure Setxsm_challenge(const Value: string);
    procedure Setxsm_password(const Value: string);
    procedure Setxsm_username(const Value: string);
    procedure SetLogined(const Value: boolean);
    procedure Setxsm_signature(const Value: string);
    function getFriends: boolean;
    procedure Setchat_addr(const Value: string);
    procedure Setchat_port(const Value: integer);
    procedure Sethttp_addr(const Value: string);
    procedure Setxsm_parentComId(const Value: string);
    procedure Setxsm_comId(const Value: string);
    { Private declarations }
  protected
    function CreateXML(xml:string):IXMLDomDocument;
    procedure SaveParams;
    function GetNetVersion: boolean;
    function GetONLVersion: boolean;

    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string;CheckExists:boolean=true):IXMLDOMNode;

  public
    { Public declarations }
    mmFactory:TmmFactory;
    
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    function getChallenge:boolean;
    function doLogin:boolean;
    function getSignature:boolean;
    function getConfig:boolean;
    procedure InitLoad;

    //读我的好友
    function getAllfriends:boolean;
    //读我的黑名单
    function getBlackFriends:boolean;
    //读我所在黑名单
    function getBeBlackFriends:boolean;


    function getUrlPath:string;
    function coLogin(uid,pwd:string):boolean;
    function CheckRegister:boolean;
    function AutoRegister(isnew:boolean):boolean;
    function xsmLogin:boolean;

    property xsm_username:string read Fxsm_username write Setxsm_username;
    property xsm_password:string read Fxsm_password write Setxsm_password;
    property xsm_challenge:string read Fxsm_challenge write Setxsm_challenge;
    property xsm_signature:string read Fxsm_signature write Setxsm_signature;
    property xsm_comId:string read Fxsm_comId write Setxsm_comId;
    property xsm_parentComId:string read Fxsm_parentComId write Setxsm_parentComId;
    property chat_addr:string read Fchat_addr write Setchat_addr;
    property chat_port:integer read Fchat_port write Setchat_port;
    property http_addr:string read Fhttp_addr write Sethttp_addr;
    property Logined:boolean read FLogined write SetLogined;
    //判断是否连锁版
    property NetVersion:boolean read GetNetVersion;
    //判断是否网络版
    property ONLVersion:boolean read GetONLVersion;
  end;

var
  mmGlobal: TmmGlobal;

implementation
uses EncDec,uCaFactory,IniFiles;
{$R *.dfm}
var xsmc,xsmurl:string;
{ TmmGlobal }

function TmmGlobal.CheckRegister: boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select Value from SYS_DEFINE Where Define = ''TENANT_ID'' and TENANT_ID=0 ';
    LocalFactory.Open(rs);
    result := (rs.Fields[0].AsString <> '');
    if result then
       TENANT_ID := StrtoInt(rs.Fields[0].AsString); 
  finally
    rs.Free;
  end;
end;

function TmmGlobal.coLogin(uid, pwd: string): boolean;
begin
  Logined := false;
  result := GetChallenge;
  xsm_username := uid;
  xsm_password := pwd;
  result := doLogin;
  result := getConfig;
  Logined := result;
end;

function TmmGlobal.AutoRegister(isnew:boolean): boolean;
var
  Tenant: TCaTenant;
  Login: TCaLogin;
  rs:TZQuery;
  Params:TftParamList;
begin
  result := false;
  Login := CaFactory.coLogin(xsm_username,CaFactory.DesEncode(xsm_username,CaFactory.pubpwd),3);
  result := login.RET='1';
  if not result then Exit;
  if not isnew then
     begin
       if Login.TENANT_ID<>Global.TENANT_ID then
          begin
            Raise Exception.Create('当前登录账号跟原账号不属于同一企业,请联系客服人员');
          end;
       //保存门店信息
       CaFactory.downloadShopInfo(Login.TENANT_ID,Login.SHOP_ID,xsm_username,xsm_password,1);
       Exit;
     end;
  //保存企业信息
  Tenant := CaFactory.coGetList(IntToStr(Login.TENANT_ID));
  rs := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParambyName('TENANT_ID').asInteger := Tenant.TENANT_ID;
    LocalFactory.Open(rs,'TTenant',Params);
    rs.Edit;
    rs.FieldByName('TENANT_ID').AsInteger := Tenant.TENANT_ID;
    rs.FieldByName('LOGIN_NAME').AsString := Tenant.LOGIN_NAME;
    rs.FieldByName('TENANT_NAME').AsString := Tenant.TENANT_NAME;
    rs.FieldByName('TENANT_TYPE').AsInteger := Tenant.TENANT_TYPE;
    rs.FieldByName('SHORT_TENANT_NAME').AsString := Tenant.SHORT_TENANT_NAME;
    rs.FieldByName('TENANT_SPELL').AsString := Tenant.TENANT_SPELL;
    rs.FieldByName('LEGAL_REPR').AsString := Tenant.LEGAL_REPR;
    rs.FieldByName('LINKMAN').AsString := Tenant.LINKMAN;
    rs.FieldByName('TELEPHONE').AsString := Tenant.TELEPHONE;
    rs.FieldByName('FAXES').AsString := Tenant.FAXES;
    rs.FieldByName('MSN').AsString := Tenant.MSN;
    rs.FieldByName('QQ').AsString := Tenant.QQ;
    rs.FieldByName('LICENSE_CODE').AsString := Tenant.LICENSE_CODE;
    rs.FieldByName('ADDRESS').AsString := Tenant.ADDRESS;
    rs.FieldByName('POSTALCODE').AsString := Tenant.POSTALCODE;
    rs.FieldByName('REMARK').AsString := Tenant.REMARK;
    rs.FieldByName('PASSWRD').AsString := EncStr(Tenant.PASSWRD,ENC_KEY);
    rs.FieldByName('REGION_ID').AsString := Tenant.REGION_ID;
    rs.FieldByName('SRVR_ID').AsString := Tenant.SRVR_ID;
    rs.FieldByName('PROD_ID').AsString := Tenant.PROD_ID;
    rs.FieldByName('XSM_CODE').AsString := xsm_username;
    rs.FieldByName('XSM_PSWD').AsString := EncStr(xsm_password,ENC_KEY);
    rs.FieldByName('AUDIT_STATUS').AsString := Tenant.AUDIT_STATUS;
    rs.Post;
    LocalFactory.UpdateBatch(rs,'TTenant',nil);
    Global.TENANT_ID := Tenant.TENANT_ID;
    Global.TENANT_NAME := Tenant.TENANT_NAME;
    Global.SHORT_TENANT_NAME := Tenant.SHORT_TENANT_NAME;
    Global.SHOP_ID := inttostr(Tenant.TENANT_ID)+'0001';
    Global.SHOP_NAME := Tenant.TENANT_NAME;
    Global.UserID := inttostr(Tenant.TENANT_ID)+'0001';
    Global.UserName := Tenant.SHORT_TENANT_NAME;
    Global.Roles := 'xsm';
    SaveParams;
    result := true;
  finally
    Params.Free;
    rs.free;
  end;
  //保存门店信息
  CaFactory.downloadShopInfo(Login.TENANT_ID,Login.SHOP_ID,xsm_username,xsm_password,1);
end;

function TmmGlobal.CreateXML(xml: string): IXMLDomDocument;
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

function TmmGlobal.doLogin: boolean;
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
  F:TIniFile;
begin
  xsm_signature := IdHTTP1.Get(xsmc+'users/dologin/up?j_username='+xsm_username+'&j_password='+md5(md5(xsm_password)+xsm_challenge));
  xml := Utf8ToAnsi(xsm_signature);
  Doc := CreateXML(xml);
  xsm_signature := xml;
  if not Assigned(doc) then Raise Exception.Create('请求登录失败...');
  Root :=  doc.DocumentElement;
  if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求登录失败...');
  if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求登录失败...');
  if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create(Root.attributes.getNamedItem('msg').text);
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  try
    F.WriteString('xsm','xsmrt',getUrlPath);
    xsm_parentComId := Root.selectSingleNode('parentComId').text;
    F.WriteString('xsm','code1',xsm_parentComId);
    xsm_comId := Root.selectSingleNode('comId').text;
    F.WriteString('xsm','code2',xsm_comId);
  finally
    try
      F.Free;
    except
    end;
  end;
  result := true;
end;

function TmmGlobal.getChallenge: boolean;
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
    xsmc := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if xsmc='' then xsmc := ''
       else
       begin
         List.CommaText := xsmc;
         xsmc := List.Values['xsmc'];
         xsmurl := List.Values['xsm'];
       end;
    xml := IdHTTP1.Get(xsmc+'users/forlogin');
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('请求登录失败...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求校验码失败...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求校验码失败...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('请求校验码失败,错误:'+Root.attributes.getNamedItem('msg').text);
    xsm_challenge := Root.childNodes[0].text;
    result := true;
  finally
    List.free;
    try
      F.Free;
    except
    end;
  end;
end;

function TmmGlobal.getSignature: boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;    
  xml:string;
begin
  try
    xsm_signature := IdHTTP1.Get(xsmc+'users/gettoken');
    xml := Utf8ToAnsi(xsm_signature);
    Doc := CreateXML(xml);
    xsm_signature := xml;
    if not Assigned(doc) then Raise Exception.Create('请求令牌失败...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求令牌失败...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，请求令牌失败...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('请求令牌失败,错误:'+Root.attributes.getNamedItem('msg').text);
    result := true;
  except
    logined := false;
    Raise;
  end;
end;

procedure TmmGlobal.SetLogined(const Value: boolean);
begin
  FLogined := Value;
end;

procedure TmmGlobal.Setxsm_challenge(const Value: string);
begin
  Fxsm_challenge := Value;
  uShopGlobal.xsm_challenge := value;
end;

procedure TmmGlobal.Setxsm_password(const Value: string);
begin
  Fxsm_password := Value;
  uShopGlobal.xsm_password := value;
end;

procedure TmmGlobal.Setxsm_signature(const Value: string);
begin
  Fxsm_signature := Value;
  uShopGlobal.xsm_signature := value;
end;

procedure TmmGlobal.Setxsm_username(const Value: string);
begin
  Fxsm_username := Value;
  uShopGlobal.xsm_username := value;
end;

procedure TmmGlobal.SaveParams;
begin
  if LocalFactory.ExecSQL('update SYS_DEFINE set VALUE='''+inttostr(TENANT_ID)+''' where TENANT_ID=0 and DEFINE=''TENANT_ID''')=0 then
     LocalFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,''TENANT_ID'','''+inttostr(TENANT_ID)+''',0,''00'',5497000)');
  if LocalFactory.ExecSQL('update SYS_DEFINE set VALUE='''+inttostr(TENANT_ID)+''' where TENANT_ID='+inttostr(TENANT_ID)+' and DEFINE=''TENANT_ID''')=0 then
     LocalFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values('+inttostr(TENANT_ID)+',''TENANT_ID'','''+inttostr(TENANT_ID)+''',0,''00'',5497000)');
end;

procedure TmmGlobal.InitLoad;
var
  F:TIniFile;
begin
  inherited;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    SFVersion := F.ReadString('soft','SFVersion','.NET');
    CLVersion := F.ReadString('soft','CLVersion','.MKT');
    ProductID := F.ReadString('soft','ProductID','R3_RYC');
  finally
    try
      F.Free;
    except
    end;
  end;
end;

function TmmGlobal.GetNetVersion: boolean;
begin
  result := (SFVersion='.NET') and not Debug;
end;

function TmmGlobal.GetONLVersion: boolean;
begin
  result := (SFVersion='.ONL') or Debug;
end;

function TmmGlobal.xsmLogin: boolean;
var
  Temp:TZQuery;
begin
  result:= false;
  Temp := TZQuery.Create(nil);
  try
    Temp.Close;
    Temp.SQL.Text := 'select XSM_CODE,XSM_PSWD from CA_SHOP_INFO where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(TENANT_ID)+' and SHOP_ID='''+SHOP_ID+'''';
    Global.LocalFactory.Open(Temp);
    if Temp.Fields[0].asString<>'' then
       begin
         coLogin(Temp.Fields[0].AsString,DecStr(Temp.Fields[1].AsString,ENC_KEY));
         result := true;
       end
    else
       Raise Exception.Create('当前登录门店没有新商盟账号...');
  finally
    Temp.Free;
  end;
end;

procedure TmmGlobal.DataModuleCreate(Sender: TObject);
begin
  inherited;
  Logined := false;
end;

function TmmGlobal.getFriends: boolean;
begin

end;

function TmmGlobal.getUrlPath: string;
var
  vList:TStringList;
begin
  vList := TStringList.Create;
  try
    vList.Delimiter := '/';
    vList.DelimitedText := xsmurl;
    vList.Delete(vList.Count-1);
    result := vList.DelimitedText+'/';
  finally
    vList.Free;
  end;
end;

constructor TmmGlobal.Create(AOwner: TComponent); 
begin
  inherited;
  mmFactory := TmmFactory.Create;
end;

destructor TmmGlobal.Destroy;
begin
  mmFactory.free;
  inherited;
end;

function TmmGlobal.getAllfriends: boolean;
var
  url:string;
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  Node,Child,MyFriends:IXMLDOMNode;
  xml,gid:string;
  gs,us:TZQuery;
  gx,ux:integer;
  Params:TftParamList;
begin
  try
    url := http_addr+'/user/scusersocial/getAllfriends/'+uppercase(xsm_username);
    xml := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('请求好友失败...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，请求好友失败...');
    Node := FindNode(Doc,'PUB',true);
    if Node.attributes.getNamedItem('RTN_CODE').text<>'0000' then Raise Exception.Create('请求好友失败,错误:'+Node.attributes.getNamedItem('RTN_MSG').text);
    gs := TZQuery.Create(nil);
    us := TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    try
      Params.ParambyName('TENANT_ID').asInteger := Global.TENANT_ID;
      LocalFactory.Open(gs,'TmqqGrouping',Params);
      LocalFactory.Open(us,'TmqqFriends',Params);
      gx := 0;
      //开始保存数据
      Node := FindNode(Doc,'OUT_INFO',true);
      Child := Node.firstChild;
      while Child<>nil do
        begin
          if Child.attributes.getNamedItem('itemType').text = 'group' then
             begin
               gs.Append;
               gid := Child.attributes.getNamedItem('groupId').text;
               gs.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
               gs.FieldByName('S_GROUP_ID').AsString := Child.attributes.getNamedItem('groupId').text;
               gs.FieldByName('G_USER_ID').AsString := xsm_username;
               gs.FieldByName('I_SHOW_NAME').AsString := Child.attributes.getNamedItem('itemShowName').text;
               gs.FieldByName('I_GROUP_NAME').AsString := Child.attributes.getNamedItem('itemShowName').text;
               inc(gx);
               gs.FieldByName('SEQ_NO').asInteger := gx;
               gs.Post;
               ux := 0;
               MyFriends := Child.firstChild;
               while MyFriends<>nil do
                  begin
                     us.Append;
                     us.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
                     us.FieldByName('S_GROUP_ID').AsString := gid;
                     us.FieldByName('FRIEND_ID').AsString := MyFriends.attributes.getNamedItem('friendId').text;
                     us.FieldByName('F_USER_ID').AsString := xsm_username;
                     us.FieldByName('FRIEND_NAME').AsString := MyFriends.attributes.getNamedItem('friendName').text;
                     us.FieldByName('U_SHOW_NAME').AsString := MyFriends.attributes.getNamedItem('itemShowName').text;
                     us.FieldByName('IS_BE_BLACK').AsString := MyFriends.attributes.getNamedItem('isBeBlack').text;
                     us.FieldByName('IS_ONLINE').AsString := '0';
                     us.FieldByName('REF_ID').AsString := MyFriends.attributes.getNamedItem('refId').text;
                     us.FieldByName('NOTE').AsString := MyFriends.attributes.getNamedItem('note').text;
                     inc(ux);
                     us.FieldByName('SEQ_NO').asInteger := ux;
                     us.Post;
                     MyFriends := MyFriends.nextSibling;
                  end;
             end;
          Child := Child.nextSibling;
        end;
      LocalFactory.UpdateBatch(gs,'TmqqGrouping',Params);
      LocalFactory.UpdateBatch(us,'TmqqFriends',Params);
    finally
      Params.Free;
      us.Free;
      gs.Free;
    end;
    result := true;
  except
    logined := false;
    Raise;
  end;
end;

function TmmGlobal.getBeBlackFriends: boolean;
begin

end;

function TmmGlobal.getBlackFriends: boolean;
begin

end;

function TmmGlobal.getConfig: boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;    
  Node:IXMLDOMNode;
  xml:string;
begin
  try
    xml := IdHTTP1.Get(xsmc+'navi/donavi/a?userId='+xsm_username+'&isFirst=0&comId='+xsm_comId+'&zoneId=GWGC');
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('模拟导航失败...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url地址返回无效XML文档，模拟导航失败...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url地址返回无效XML文档，模拟导航失败...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('模拟导航失败,错误:'+Root.attributes.getNamedItem('msg').text);

    Node := FindNode(doc,'server_info\chat_server');
    chat_addr := Node.attributes.getNamedItem('ip').text;
    chat_port := StrtoInt(Node.attributes.getNamedItem('port').text);
    Node := FindNode(doc,'server_info\web_server');
    http_addr := Node.attributes.getNamedItem('web_url').text;
    
    result := true;
  except
    logined := false;
    Raise;
  end;
end;

procedure TmmGlobal.Setchat_addr(const Value: string);
begin
  Fchat_addr := Value;
end;

procedure TmmGlobal.Setchat_port(const Value: integer);
begin
  Fchat_port := Value;
end;

procedure TmmGlobal.Sethttp_addr(const Value: string);
begin
  Fhttp_addr := Value;
end;

procedure TmmGlobal.Setxsm_parentComId(const Value: string);
begin
  Fxsm_parentComId := Value;
end;

procedure TmmGlobal.Setxsm_comId(const Value: string);
begin
  Fxsm_comId := Value;
end;

function TmmGlobal.FindElement(root: IXMLDOMNode; s: string): IXMLDOMNode;
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

function TmmGlobal.FindNode(doc: IXMLDomDocument; tree: string;
  CheckExists: boolean): IXMLDOMNode;
var
  s:TStringList;
  i:integer;
begin
  s := TStringList.Create;
  try
    s.Delimiter := '\';
    s.DelimitedText := tree;
    result := doc.documentElement;
    for i:=0 to s.Count -1 do
      begin
        if result <>nil then
           result := FindElement(result,s[i]);
      end;
    if CheckExists and (result = nil) then Raise Exception.Create('在文档中没找到结点'+tree); 
  finally
    s.Free;
  end;
end;

procedure TmmGlobal.IdCookieManager1NewCookie(ASender: TObject;
  ACookie: TIdCookieRFC2109; var VAccept: Boolean);
begin
  inherited;
  LogFile.AddLogFile(0,'MaxAge:'+inttostr(ACookie.MaxAge));
  LogFile.AddLogFile(0,'MaCookieName:'+ACookie.CookieName);
  LogFile.AddLogFile(0,'Value:'+ACookie.Value);
end;

end.
