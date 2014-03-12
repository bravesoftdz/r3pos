unit uUcFactory;

interface

uses
  SysUtils, windows, Classes, IdBaseComponent, IdComponent, IdTCPConnection,
  HttpApp, Forms,ZBase,ZLogFile, IdTCPClient, IdHTTP, msxml, ComObj, EmbeddedWB,
  EncDec, IniFiles, IdCookieManager, IdCookie, WinInet, ZDataSet, ZdbFactory,
  uRspFactory, urlParser, ZTuXeDo, EncdDecd;

type
  TUcFactory = class(TDataModule)
    IdHTTP1: TIdHTTP;
    IdCookieManager1: TIdCookieManager;
    procedure DataModuleCreate(Sender: TObject);
    procedure IdCookieManager1NewCookie(ASender: TObject;
      ACookie: TIdCookieRFC2109; var VAccept: Boolean);
  private
    FxsmUC: string;
    FxsmWB: string;
    FxsmChallenge: string;
    FxsmSignature: UTF8String;
    FxsmLogined: boolean;
    loginTime:int64;
    FxsmUser: string;
    FscWeb: string;
    FecWeb: string;
    FrimWB: string;
    FrimCustId: string;
    FrimComId: string;
    FAuthMode: integer;
    FxsmComId: string;
    function CreateXML(xml:string):IXMLDomDocument;
    function FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function FindNode(doc:IXMLDomDocument;tree:string;CheckExists:boolean=true):IXMLDOMNode;
    procedure SetxsmUC(const Value: string);
    procedure SetxsmWB(const Value: string);
    procedure SetxsmChallenge(const Value: string);
    procedure SetxsmSignature(const Value: UTF8String);
    procedure SetxsmLogined(const Value: boolean);
    function  GetxsmLogined: boolean;
    procedure SetxsmUser(const Value: string);
    procedure SetecWeb(const Value: string);
    procedure SetscWeb(const Value: string);
    procedure SetrimWB(const Value: string);
    procedure SetrimComId(const Value: string);
    procedure SetrimCustId(const Value: string);
    procedure SetAuthMode(const Value: integer);
    procedure SetxsmComId(const Value: string);
  public
    //��ȡ������ַ
    function getModule:boolean;
    //��ȡ��У��
    function getChallenge:boolean;
    //�û����뷽ʽ��¼
    function xsmLogin(username,password:string;login:boolean=true):boolean;
    function autoLogin(tenantId,username,password:string):boolean;
    //��¼RIM
    function rimLogin:boolean;
    //�����Ƶ�¼
    function xsmLoginForToken(token:string):boolean;
    //����¼״̬
    function chkLogin(EWB:TEmbeddedWB):boolean;
    //��ȡ��ǰ����
    function getSignature:boolean;
    //��ȡ����������
    function getxsmWBHost:string;
    //��ȡ�����ַ���
    function getConnStr:string;
    //��ȡdb.cfg����
    function getDBConfig(username,connstr:string):boolean;
    //���汾����
    function CheckUpgrade(tenantId,prodId,CurVeraion:string):TCaUpgrade;
    //���ģ��Ȩ��
    function GetChkRight(urlToken:TurlToken):boolean;
    //��֤��ʽ 1:rsp 2:xsm
    property AuthMode:integer read FAuthMode write SetAuthMode;
    property xsmUC:string read FxsmUC write SetxsmUC;
    property xsmWB:string read FxsmWB write SetxsmWB;
    property rimWB:string read FrimWB write SetrimWB;
    property ecWeb:string read FecWeb write SetecWeb;
    property scWeb:string read FscWeb write SetscWeb;
    property xsmChallenge:string read FxsmChallenge write SetxsmChallenge;
    property xsmSignature:UTF8String read FxsmSignature write SetxsmSignature;
    property xsmLogined:boolean read GetxsmLogined write SetxsmLogined;
    property xsmUser:string read FxsmUser write SetxsmUser;
    property xsmComId:string read FxsmComId write SetxsmComId;
    property rimComId:string read FrimComId write SetrimComId;
    property rimCustId:string read FrimCustId write SetrimCustId;
  end;

var UcFactory: TUcFactory;

implementation

uses udataFactory,uTokenFactory,uDLLFactory;

{$R *.dfm}

function TUcFactory.CreateXML(xml: string): IXMLDomDocument;
var
  ErrXml:string;
  w:integer;
begin
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
    on E:Exception do
       begin
         result := nil;
       end;
  end;
end;

function TUcFactory.FindElement(root: IXMLDOMNode; s: string): IXMLDOMNode;
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

function TUcFactory.FindNode(doc: IXMLDomDocument; tree: string;
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
    if CheckExists and (result = nil) then Raise Exception.Create('���ĵ���û�ҵ����'+tree); 
  finally
    s.Free;
  end;
end;

function TUcFactory.getChallenge: boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  xml,url:string;
begin
  try
    result := false;
    IdCookieManager1.CookieCollection.Clear;
    url := xsmUC+'users/forlogin';
    xml := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('�����¼ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ�������У����ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ�������У����ʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('����У����ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
    xsmChallenge := Root.selectSingleNode('challenge').text;
    result := true;
  except
    on E:Exception do
    begin
      LogFile.AddLogFile(0,'������,����:'+url);
      if pos('Socket Error # 11004', E.Message) > 0 then
         Raise Exception.Create('���������쳣���������������...')
      else
         Raise;
    end;
  end;
end;

function TUcFactory.getSignature: boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;    
  xml,url:string;
begin
  try
    url := xsmUC+'users/gettoken';
    xsmSignature := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xsmSignature);
    xsmSignature := StringReplace(xml,'"utf-8"','"GBK"',[rfReplaceAll]);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('��������ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ�����������ʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('��������ʧ��,����:'+Root.attributes.getNamedItem('msg').text);
    loginTime := getTickCount;
    result := true;
  except
    LogFile.AddLogFile(0,'������,����:'+url);
    Raise;
  end;
end;

procedure TUcFactory.SetxsmUC(const Value: string);
begin
  FxsmUC := Value;
end;

procedure TUcFactory.SetxsmWB(const Value: string);
begin
  FxsmWB := Value;
end;

function TUcFactory.xsmLogin(username,password:string;login:boolean): boolean;
const
  dec='{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}';
function md5(s:string):string;
begin
  result := md5Encode(s+dec);
end;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  xml,url,conn:string;
begin
  getModule;
  if not getChallenge then Raise Exception.Create('��ȡ����ʧ�ܡ�');
  try
    result := false;
    url := xsmUC+'users/dologin/up?j_username='+username+'&j_password='+md5(md5(password)+xsmChallenge);
    xsmSignature := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xsmSignature);
    xsmSignature := StringReplace(xml,'"utf-8"','"GBK"',[rfReplaceAll]);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('�����¼ʧ��...');
    Root := doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
    if (Root.attributes.getNamedItem('code').text<>'0000') then Raise Exception.Create(Root.attributes.getNamedItem('msg').text);
    xsmComId := Root.selectSingleNode('comId').text;

    if login and (AuthMode = 2) then
       begin
         conn := getConnstr;
         getDBConfig(username,conn);
       end;

    xsmLogined := true;
    xsmUser := username;
    loginTime := getTickCount;
    result := true;
  except
    on E:Exception do
    begin
      LogFile.AddLogFile(0,'������,����:'+url);
      xsmLogined := false;
      Raise;
    end;
  end;
end;

procedure TUcFactory.DataModuleCreate(Sender: TObject);
var
  uc:string;
  F:TIniFile;
  List:TStringList;
begin
  AuthMode := 1;
  xsmLogined := false;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    uc := F.ReadString('soft', 'xsm', '');
    if (uc <> '') and (uc[1] = '#') then
       begin
         delete(uc,1,1);
         uc := DecStr(uc,ENC_KEY);
       end;
    if uc <> '' then
       begin
         xsmUC := uc;
         AuthMode := 2;
       end;
  finally
    F.Free;
  end;
end;

procedure TUcFactory.SetxsmChallenge(const Value: string);
begin
  FxsmChallenge := Value;
end;

procedure TUcFactory.SetxsmSignature(const Value: UTF8String);
begin
  FxsmSignature := Value;
end;

procedure TUcFactory.SetxsmLogined(const Value: boolean);
begin
  FxsmLogined := Value;
end;

procedure TUcFactory.IdCookieManager1NewCookie(ASender: TObject;
  ACookie: TIdCookieRFC2109; var VAccept: Boolean);
begin
// messagebox(0,pchar(ACookie.CookieText),'',mb_ok);
// InternetSetCookie(pchar('xinshangmeng.com'),pchar(ACookie.CookieName),pchar(ACookie.Value+ ';expires=Sun,22-Feb-2099 00:00:00 GMT'));
end;

function TUcFactory.chkLogin(EWB: TEmbeddedWB): boolean;
var
  s:string;
begin
  s := '';
  try
     s := EWB.OleObject.Document.XMLDocument.documentElement.XML;
  except
     s := EWB.OleObject.document.documentelement.innerText;
  end;
  result := pos('code="0000"',s)>0;
end;

function TUcFactory.xsmLoginForToken(token: string): boolean;
var
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  xml:string;
  url:string;
begin
  getModule;
  try
    result := false;
    Doc := CreateXML(token);
    if not Assigned(doc) then Raise Exception.Create('��֤����ʧ��...');
    Root :=  doc.DocumentElement;
    xsmUser := Root.selectSingleNode('/xsm/userId').text;
    if pos(token,'"utf-8"')>0 then
       begin
         token := Utf8ToAnsi(token);
         token := StringReplace(token,'"utf-8"','"GBK"',[rfReplaceAll]);
       end;
    url := xsmUC+'tokenconsumer?xmlStr='+HttpEncode(token);
    xml := IdHTTP1.Get(url);
    Doc := CreateXML(xml);
    xml := Utf8ToAnsi(xml);
    if not Assigned(doc) then Raise Exception.Create('�����¼ʧ��...');
    Root :=  doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('Url��ַ������ЧXML�ĵ��������¼ʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create(Root.attributes.getNamedItem('msg').text);
    xsmSignature := token;
    xsmLogined := true;
    loginTime := getTickCount;
    result := true;
  except
    on E:Exception do
    begin
      xsmLogined := false;
      LogFile.AddLogFile(0,'������,����:'+url);
      Raise;
    end;
  end;
end;

function TUcFactory.GetxsmLogined: boolean;
begin
  result := FxsmLogined and ((GetTickCount-LoginTime) < 1000*60*60);
end;

procedure TUcFactory.SetxsmUser(const Value: string);
begin
  FxsmUser := Value;
end;

function TUcFactory.getxsmWBHost: string;
var sl:TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Delimiter := '/';
    sl.DelimitedText := xsmWB;
  finally
    sl.Free;
  end;
end;

function TUcFactory.getModule: boolean;
var
  F:TIniFile;
  xsmConfig:string;
  List:TStringList;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    xsmConfig := F.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    if xsmConfig = '' then
       begin
         if AuthMode <> 2 then xsmUC := 'http://test.xinshangmeng.com/st/';
         xsmWB := 'http://test.xinshangmeng.com/xsm6/';
         rimWB := 'http://test.xinshangmeng.com/rimweb';
         ecWeb := 'http://test.xinshangmeng.com/ecweb/';
         scWeb := 'http://test.xinshangmeng.com/scweb/';
       end
    else
       begin
         List.CommaText := xsmConfig;
         if AuthMode <> 2 then xsmUC := List.Values['xsmc'];
         xsmWB := List.Values['xsm'];
         rimWB := List.Values['rim'];
         ecWeb := List.Values['ecweb'];
         scWeb := List.Values['scweb'];
       end;
  finally
    F.Free;
    List.Free;
  end;
end;

procedure TUcFactory.SetecWeb(const Value: string);
begin
  FecWeb := Value;
end;

procedure TUcFactory.SetscWeb(const Value: string);
begin
  FscWeb := Value;
end;

procedure TUcFactory.SetrimWB(const Value: string);
begin
  FrimWB := Value;
end;

procedure TUcFactory.SetrimComId(const Value: string);
begin
  FrimComId := Value;
end;

procedure TUcFactory.SetrimCustId(const Value: string);
begin
  FrimCustId := Value;
end;

procedure TUcFactory.SetAuthMode(const Value: integer);
begin
  FAuthMode := Value;
end;

procedure TUcFactory.SetxsmComId(const Value: string);
begin
  FxsmComId := Value;
end;

function TUcFactory.rimLogin: boolean;
var
  Msg:string;
  Params:TftParamList;
  ss:TStringStream;
  CoParams:TcoParamList;
begin
  if not dllFactory.getTokenInfo then Raise Exception.Create('��ȡ�û���Ϣʧ�ܣ������µ�¼...');
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Msg := dataFactory.Remote.ExecProc('TRimWsdlService',Params);
    case dataFactory.Remote.ConnMode of
     2:begin
         Params.Decode(Params,Msg);
         rimComId := Params.ParambyName('rimcid').AsString;
         rimCustId := Params.ParambyName('xsmuid').AsString;
       end;
     3:begin
         CoParams := TcoParamList.Create(nil);
         ss := TStringStream.Create(DecodeString(Msg));
         try
           CoParams.Decode(CoParams,ss);
           rimComId := CoParams.ParambyName('rimcid').AsString;
           rimCustId := CoParams.ParambyName('xsmuid').AsString;
         finally
           CoParams.Free;
           ss.Free;
         end;
       end;
    end;
    if rimCustId='' then rimCustId := Params.ParambyName('rimuid').AsString;
    if rimCustId='' then Raise Exception.Create('��ǰ��¼�ŵ�����֤����Ч���������޸���ȷ�����֤��.');
    result := true;
  finally
    Params.Free;
  end;
end;

function TUcFactory.getConnStr: string;
var
  F:TIniFile;
  Doc:IXMLDomDocument;
  Root:IXMLDOMElement;
  Node:IXMLDOMNode;
  xml,url,str:string;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'r3.cfg');
  try
    if F.ReadString('soft','mode','release') = 'debug' then
       begin
         result := F.ReadString('soft','connstr',''); 
         Exit;
       end;
  finally
    F.Free;
  end;

  try
    url := xsmUC+'navi/donavi/c?comId='+xsmComId+'&srvType=43';
    xml := IdHTTP1.Get(url);
    xml := Utf8ToAnsi(xml);
    Doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('��ȡӦ�÷�����������Ϣʧ��...');
    Root := doc.DocumentElement;
    if not Assigned(Root) then Raise Exception.Create('url��ַ������Чxml�ĵ�����ȡӦ�÷�����������Ϣʧ��...');
    if Root.attributes.getNamedItem('code')=nil then Raise Exception.Create('url��ַ������Чxml�ĵ�����ȡӦ�÷�����������Ϣʧ��...');
    if Root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('��ȡӦ�÷�����������Ϣʧ��,����:'+Root.attributes.getNamedItem('msg').text);

    Node := FindNode(doc,'server_info',false);
    if Node <> nil then
       begin
         str := Node.attributes.getNamedItem('url').text;
         if trim(str) <> '' then
            begin
              str := trim(str);
              if Copy(str,1,4) = 'http' then delete(str,1,4);
              delete(str,1,3);
              delete(str,length(str)-1,2);
              result := str;
            end;
       end
    else Raise Exception.Create('��ȡӦ�÷�����������Ϣʧ�ܣ�����xml��Ч...');
  except
    LogFile.AddLogFile(0,'��ȡӦ�÷�����������Ϣʧ��,url='+url);
    Raise;
  end;
end;

function TUcFactory.getDBConfig(username, connstr: string): boolean;
var
  i:integer;
  rs,us:TZQuery;
  db,r3:TIniFile;
  remote:TdbFactory;
  isSrvr,finded:boolean;
  paramsList:TStringList;
  CheckShopId,str,defStr,dbId,srvrId,defSrvrId,shopId,tenantId:string;
begin
  if connstr = '' then Raise Exception.Create('��ȡ��������ʧ��...');

  remote := TdbFactory.Create;
  rs := TZQuery.Create(nil);
  db := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  r3 := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    remote.Initialize(connstr);
    remote.connect;
    rs.SQL.Text :=
      ' select a.TENANT_ID,a.SRVR_ID DEF_SRVR_ID, '+
      '        b.SHOP_ID,b.SHOP_NAME, '+
      '        c.PROD_ID,c.PROD_NAME,c.PROD_FLAG,c.INDUSTRY,c.RES_VERSION,c.RES_DESKTOP,c.PROD_PARAMS, '+
      '        d.DB_ID, '+
      '        d.SRVR_ID,d.SRVR_NAME,d.CONN_MODE,d.HOST_NAME,d.SRVR_PORT,d.SRVR_PATH,d.SRVR_STATUS, '+
      '        a.COMM COMM_1,b.COMM COMM_2 '+
      ' from   CA_SHOP_INFO b '+
      '        inner join CA_TENANT a on a.TENANT_ID = b.TENANT_ID '+
      '        left  join CA_PROD_INFO c on a.PROD_ID = c.PROD_ID and c.COMM not in (''02'',''12'') '+
      '        left  join '+
      '        ( '+
      '          select a.DB_ID,c.SRVR_ID,c.SRVR_NAME,c.CONN_MODE,c.HOST_NAME,c.SRVR_PORT,c.SRVR_PATH,c.SRVR_STATUS '+
      '          from   CA_DB_INFO a,CA_DB_TO_SRVR b,CA_SERVER_INFO c '+
      '          where  a.DB_ID = b.DB_ID and b.SRVR_ID = c.SRVR_ID and a.COMM not in (''02'',''12'') and b.COMM not in (''02'',''12'') and c.COMM not in (''02'',''12'') '+
      '         ) d  on a.DB_ID = d.DB_ID '+
      ' where  b.XSM_CODE in (:UPPER_XSM_CODE,:LOWER_XSM_CODE) '+
      ' order by b.SHOP_ID ';
    rs.ParamByName('UPPER_XSM_CODE').AsString := UpperCase(username);
    rs.ParamByName('LOWER_XSM_CODE').AsString := LowerCase(username);
    remote.Open(rs);

    if rs.IsEmpty then Raise Exception.Create('���˺���δ��ͨ�����ն˹���...');
    if (Copy(rs.FieldByName('COMM_1').AsString,2,1) = '2') or (Copy(rs.FieldByName('COMM_2').AsString,2,1) = '2') then Raise Exception.Create('���û���ע��...');
    if rs.FieldByName('PROD_ID').AsString = '' then Raise Exception.Create('���û���δ�����Ʒ��Ϣ...');
    if rs.FieldByName('DEF_SRVR_ID').AsString = '' then Raise Exception.Create('���û���δ����Ĭ��Ӧ�÷�������Ϣ...');
    if rs.FieldByName('DB_ID').AsString = '' then Raise Exception.Create('���û���δ�������ݿ��������Ϣ...');

    rs.First;
    CheckShopId := rs.FieldByName('SHOP_ID').AsString;
    while not rs.Eof do
      begin
        if CheckShopId <> rs.FieldByName('SHOP_ID').AsString then Raise Exception.Create('�ظ��ĵ�¼��...');
        rs.Next;
      end;
    rs.First;

    us := TZQuery.Create(nil);
    try
      us.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=0 and DEFINE=''TENANT_ID''';
      dataFactory.sqlite.Open(us);
      if not us.IsEmpty then
         begin
           if us.Fields[0].AsInteger <> rs.FieldByName('TENANT_ID').AsInteger then
              Raise Exception.Create('��ǰ��¼�˺Ÿ�ԭ�˺Ų�����ͬһ��ҵ,����ϵ�ͷ���Ա...');
         end;
    finally
      us.Free;
    end;    

    srvrId := db.readString('db','srvrId','');
    defSrvrId := rs.FieldbyName('DEF_SRVR_ID').AsString;
    tenantId := rs.FieldbyName('TENANT_ID').AsString;
    shopId := rs.FieldbyName('SHOP_ID').AsString;
    dbId := rs.FieldbyName('DB_ID').AsString;
    db.WriteString('db','dbid',dbId);
    r3.WriteString('soft','SFVersion','.'+rs.FieldbyName('PROD_FLAG').asString);
    r3.WriteString('soft','CLVersion','.'+rs.FieldbyName('INDUSTRY').asString);
    r3.WriteString('soft','ProductID',rs.FieldbyName('PROD_ID').asString);
    r3.WriteString('soft','name',rs.FieldbyName('PROD_NAME').asString);
    rspFactory.resVersion := rs.FieldbyName('RES_VERSION').asString;
    rspFactory.resDesktop := rs.FieldbyName('RES_DESKTOP').asString;
    rspFactory.prodParams := rs.FieldbyName('PROD_PARAMS').asString;
    paramsList := TStringList.Create;
    try
      paramsList.CommaText := rs.FieldbyName('PROD_PARAMS').asString;
      for i := 0 to paramsList.Count - 1 do
        begin
          if (paramsList.Names[i] <> '') and (paramsList.ValueFromIndex[i] <> '') then
             r3.WriteString('soft',paramsList.Names[i],paramsList.ValueFromIndex[i]);
        end;
    finally
      paramsList.Free;
    end;
    finded := false;
    isSrvr := false;
    rs.First;
    while not rs.Eof do
      begin
        db.WriteString('H_'+rs.FieldbyName('SRVR_ID').asString,'srvrName',rs.FieldbyName('SRVR_NAME').asString);
        db.WriteString('H_'+rs.FieldbyName('SRVR_ID').asString,'connMode',rs.FieldbyName('CONN_MODE').asString);
        db.WriteString('H_'+rs.FieldbyName('SRVR_ID').asString,'hostName',rs.FieldbyName('HOST_NAME').asString);
        db.WriteString('H_'+rs.FieldbyName('SRVR_ID').asString,'srvrPort',rs.FieldbyName('SRVR_PORT').asString);
        db.WriteString('H_'+rs.FieldbyName('SRVR_ID').asString,'srvrPath',rs.FieldbyName('SRVR_PATH').asString);
        case rs.FieldbyName('SRVR_STATUS').asInteger of
        1: db.WriteString('H_'+rs.FieldbyName('SRVR_ID').asString,'srvrStatus','����');
        2: db.WriteString('H_'+rs.FieldbyName('SRVR_ID').asString,'srvrStatus','����');
        9: begin
             db.EraseSection(rs.FieldbyName('SRVR_ID').asString);
             rs.Next;
             continue;
           end;
        else
           db.WriteString('H_'+rs.FieldbyName('SRVR_ID').asString,'srvrStatus','����');
        end;
{       // r6��ʱû��ѡ��Ӧ�÷������Ĺ��ܣ�ÿ�ε�½��ȡĬ�ϵ�ַ 20140312
        if srvrId = rs.FieldbyName('SRVR_ID').asString then isSrvr := true;
        if not finded then
           begin
             if srvrId = rs.FieldbyName('SRVR_ID').asString then
                begin
                  db.WriteString('db','Connstr','connmode='+rs.FieldbyName('CONN_MODE').asString+';hostname='+rs.FieldbyName('HOST_NAME').asString+';port='+rs.FieldbyName('SRVR_PORT').asString+';dbid='+dbId);
                  finded := true;
                end;
           end;
}
        if defSrvrId = rs.FieldbyName('SRVR_ID').AsString then
           begin
             defStr := 'connmode='+rs.FieldbyName('CONN_MODE').asString+';hostname='+rs.FieldbyName('HOST_NAME').asString+';port='+rs.FieldbyName('SRVR_PORT').asString+';dbid='+dbId;
           end;
        rs.Next;
      end;

    if not finded or not isSrvr then //һֱû�ҵ����ã�Ĭ�ϵ�һ��
       begin
         db.WriteString('db','srvrId',defSrvrId);
         db.WriteString('db','Connstr',defStr);
       end;

    case remote.iDbType of
      0:str := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
      1:str := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))+(sysdate - trunc(sysdate))*24*60*60';
      4:str := '86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))+MIDNIGHT_SECONDS(CURRENT TIMESTAMP)';
      5:str := 'strftime(''%s'',''now'',''localtime'')-1293840000';
      else str := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
    end;

    case remote.iDbType of
      0,5: str := 'select ' + str + ' as time_stamp ';
      4:   str := 'select ' + str + ' as time_stamp from SYSIBM.SYSDUMMY1';
      1:   str := 'select ' + str + ' as time_stamp from DUAL';
    end;

    rs.Close;
    rs.SQL.Text := str;
    remote.Open(rs);
    rspFactory.timestamp := StrtoInt64(rs.Fields[0].Asstring);

    remote.DisConnect;
  finally
    db.Free;
    r3.Free;
    rs.Free;
    remote.Free;
  end;
end;

function TUcFactory.autoLogin(tenantId, username, password: string): boolean;
var
  F:TIniFile;
  Temp:TZQuery;
  isXsm:boolean;
  name,connstr:string;
begin
  result:= false;

  isXsm := false;
  Temp := TZQuery.Create(nil);
  try
    Temp.Close;
    Temp.SQL.Text :=
     ' select A.ROLE_IDS,B.XSM_CODE '+
     ' from   VIW_USERS A,CA_SHOP_INFO B,CA_TENANT C '+
     ' where  A.TENANT_ID=C.TENANT_ID '+
     '        and A.SHOP_ID=B.SHOP_ID '+
     '        and A.TENANT_ID=B.TENANT_ID '+
     '        and A.ACCOUNT in ('''+username+''','''+LowerCase(username)+''','''+UpperCase(username)+''') '+
     '        and A.TENANT_ID='+tenantId+
     '        and A.COMM not in (''02'',''12'') ';
    dataFactory.sqlite.Open(Temp);
    if Temp.IsEmpty then Raise Exception.Create('��Ч��¼��.');
    if Temp.FieldbyName('ROLE_IDS').AsString = 'xsm' then
       begin
         isXsm := true;
       end
    else
       begin
         name := Temp.FieldByName('XSM_CODE').AsString;
       end;
  finally
    Temp.Free;
  end;

  if isXsm then
     begin
       xsmLogin(username,password);
     end
  else
     begin
       if name = '' then
          begin
            Temp := TZQuery.Create(nil);
            try
              Temp.Close;
              Temp.SQL.Text := 'select LOGIN_NAME from CA_TENANT where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID';
              Temp.ParamByName('TENANT_ID').AsInteger := strtoint(tenantId);
              dataFactory.sqlite.Open(Temp);
              name := Temp.FieldByName('LOGIN_NAME').AsString;
            finally
              Temp.Free;
            end;
          end;

       F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
       try
         connstr := F.ReadString('db','Connstr','');
       finally
         try
           F.Free;
         except
         end;
       end;

       getDBConfig(name,connstr);
     end;

  result := true;
end;

function TUcFactory.CheckUpgrade(tenantId, prodId, CurVeraion: string): TCaUpgrade;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  dataFactory.MoveToRemote;
  try
    rs.SQL.Text :=
      ' select  A.VERSION_ID,A.PROD_ID,A.UPGRADE_VERSION,A.SRVR_ID,A.VERSION_STATUS,A.UPGRADE_FLAG,A.UPGRADE_RANGE,A.UPGRADE_URL '+
      ' from    CA_UPGRADE_VERSION A,CA_TENANT B '+
      ' where   A.PROD_ID = :PROD_ID '+
      '         AND A.SRVR_ID = B.SRVR_ID '+
      '         AND B.TENANT_ID = :TENANT_ID '+
      '         AND UPGRADE_VERSION > :CUR_VERSION '+
      '         AND A.VERSION_STATUS = ''2'' '+
      '         AND A.COMM NOT IN (''02'',''12'') '+
      ' order by VERSION_ID DESC ';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(tenantId);
    rs.ParamByName('CUR_VERSION').AsString := CurVeraion;
    rs.ParamByName('PROD_ID').AsString := prodId;
    dataFactory.Open(rs);
    if rs.IsEmpty then
       result.UpGrade := 3
    else
       begin
         rs.First;
         result.UpGrade := rs.FieldByName('UPGRADE_FLAG').AsInteger;
         result.URL := rs.FieldByName('UPGRADE_URL').AsString;
         result.Version := rs.FieldByName('UPGRADE_VERSION').AsString;
       end;
  finally
    dataFactory.MoveToDefault;
    rs.Free;
  end;
end;

function TUcFactory.GetChkRight(urlToken:TurlToken): boolean;
var
  rs:TZQuery;
  mid,uid,roleIds:string;
begin
  result := true;
  if token.tenantId = '' then Exit;
  if token.userId = '' then Exit;
  uid := token.userId;
  if (uid = 'admin') or (uid='system') or (token.userId=token.xsmCode) or (token.account=token.xsmCode) then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ROLE_IDS from VIW_USERS where TENANT_ID=:TENANT_ID and USER_ID=:USER_ID';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('USER_ID').AsString := token.userId;
    dataFactory.sqlite.Open(rs);
    if rs.IsEmpty then
       begin
         result := false;
         Exit;
       end;
    roleIds := rs.FieldByName('ROLE_IDS').AsString;
    if roleIds = 'xsm' then Exit;
    roleIds := ','+roleIds+',';
  finally
    rs.Free;
  end;

  result := false;
  mid := LowerCase(urlToken.moduname);

  if pos(','+token.tenantId+'001,', roleIds) > 0 then //�ϰ�-����Ȩ��
     begin
       result := true;
       Exit;
     end;

  if pos(','+token.tenantId+'002,', roleIds) > 0 then //�곤
     begin
       result := not ((urlToken.appId='xsm-in') or (urlToken.appId='rim-in'));
       Exit;
     end;

  if (mid = 'tfrmsaleorder') or (mid = 'tfrmposoutorder') then
     begin
       result := pos(','+token.tenantId+'003,', roleIds) > 0;
       Exit;
     end;

  if (mid = 'tfrmstockorder') or (mid = 'tfrmposinorder') or (mid = 'tfrmdownstockorder') then
     begin
       result := pos(','+token.tenantId+'006,', roleIds) > 0;
       Exit;
     end;

  if (mid = 'report.html') then
     begin
       result := pos(','+token.tenantId+'005,', roleIds) > 0;
       Exit;
     end;
end;

end.
