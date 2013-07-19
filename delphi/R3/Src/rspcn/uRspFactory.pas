unit uRspFactory;

interface

uses
  SysUtils,Classes,Des,EncDec,msxml,windows,activex,inifiles,ComObj,EncdDecd;

type
  TRspFunction=function(xml:widestring;url:widestring;flag:integer):widestring;stdcall;
  TRspSetParams=function(_sslpwd:pansichar):boolean;stdcall;

  TCaUpgrade=record
    UpGrade:integer;
    URL:string;
    Version:string;
  end;
  
  TrspFactory = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    RspHandle:THandle;
    rspUrl:string;
    Ftimestamp: Int64;
    FtenantId: integer;
    FshopId: string;
    FresVersion: string;
    FresDesktop: string;
    FprodParams: string;
    FdbId: integer;
    procedure FreeRspFactory;
    procedure LoadRspFactory;
    procedure Settimestamp(const Value: Int64);
    procedure SettenantId(const Value: integer);
    procedure SetshopId(const Value: string);
    procedure SetprodParams(const Value: string);
    procedure SetresDesktop(const Value: string);
    procedure SetresVersion(const Value: string);
    procedure SetdbId(const Value: integer);
  protected
    RspLogin:TRspFunction;
    RspSetParams:TRspSetParams;
    RspGetTenantInfo:TRspFunction;
    RspGetShopInfo:TRspFunction;
    RspGetGoodsInfo:TRspFunction;
    RspUploadGoods:TRspFunction;
    RspDownloadTenants:TRspFunction;
    RspDownloadServiceLines:TRspFunction;
    RspDownloadRelations:TRspFunction;
    RspQueryUnion:TRspFunction;
    RspListModules:TRspFunction;
    RspDownloadSort:TRspFunction;

    RspcheckUpgrade:TRspFunction;
  public
    { Public declarations }
    function  CreateRspXML: IXMLDomDocument;
    function  CreateXML(xml:string):IXMLDomDocument;
    procedure CheckRecAck(doc: IXMLDomDocument);
    function  FindElement(root:IXMLDOMNode;s:string):IXMLDOMNode;
    function  FindNode(doc:IXMLDomDocument;tree:string;CheckExists:boolean=true):IXMLDOMNode;
    function  GetNodeValue(root:IXMLDOMNode;s:string):string;
    function  DesEncode(inStr, Key: string): string;

    function CheckUpgrade(TENANT_ID,PROD_ID,CurVeraion:string):TCaUpgrade;

    function xsmLogin(username:string;flag:integer):boolean;
    function getTenantInfo(tenantId:integer):widestring;
    function getShopInfo(tenantId:integer;shopId:string):widestring;
    function getGoodsInfo(barcode:string):widestring;
    function uploadGoods(inXml:widestring):boolean;
    function downloadTenants(tenantId,flag:integer;timestamp:int64):widestring;
    function downloadServiceLines(tenantId,flag:integer;timestamp:int64):widestring;
    function downloadRelations(tenantId,flag:integer;timestamp:int64):widestring;
    function downloadUnion(tenantId,supTenantId,flag:integer;timestamp:int64):widestring;
    function downloadModules(tenantId,flag:integer;timestamp:int64):widestring;
    function downloadSort(tenantId,flag:integer;timestamp:int64):widestring;

    property timestamp:Int64 read Ftimestamp write Settimestamp;
    property tenantId:integer read FtenantId write SettenantId;
    property shopId:string read FshopId write SetshopId;
    property dbId:integer read FdbId write SetdbId;
    //最新桌面版本号
    property resVersion:string read FresVersion write SetresVersion;
    property resDesktop:string read FresDesktop write SetresDesktop;
    property prodParams:string read FprodParams write SetprodParams;
  end;

var
  rspFactory: TrspFactory;

implementation

uses udataFactory,uFnUtil;

const
  pubpwd = 'SaRi0+jf';
var
  sslpwd:string;

{$R *.dfm}

procedure TrspFactory.LoadRspFactory;
begin
  RspHandle := LoadLibrary(Pchar(ExtractFilePath(ParamStr(0))+'rspFactory.dll'));
  if RspHandle=0 then Exit;
  @RspLogin := GetProcAddress(RspHandle, 'coLogin');
  if @RspLogin=nil then Raise Exception.Create('无效Rsp插件包，没有实现coLogin方法');
  @RspSetParams := GetProcAddress(RspHandle, 'SetParams');
  if @RspSetParams=nil then Raise Exception.Create('无效Rsp插件包，没有实现SetParams方法');
  @RspGetTenantInfo := GetProcAddress(RspHandle, 'getTenantInfo');
  if @RspGetTenantInfo=nil then Raise Exception.Create('无效Rsp插件包，没有实现getTenantInfo方法');
  @RspGetShopInfo := GetProcAddress(RspHandle, 'getShopInfo');
  if @RspGetShopInfo=nil then Raise Exception.Create('无效Rsp插件包，没有实现getShopInfo方法');
  @RspGetGoodsInfo := GetProcAddress(RspHandle, 'getGoodsInfo');
  if @RspGetGoodsInfo=nil then Raise Exception.Create('无效Rsp插件包，没有实现getGoodsInfo方法');
  @RspUploadGoods := GetProcAddress(RspHandle, 'uploadGoods');
  if @RspUploadGoods=nil then Raise Exception.Create('无效Rsp插件包，没有实现uploadGoods方法');
  @RspDownloadTenants := GetProcAddress(RspHandle, 'downloadTenants');
  if @RspDownloadTenants=nil then Raise Exception.Create('无效Rsp插件包，没有实现downloadTenants方法');
  @RspDownloadServiceLines := GetProcAddress(RspHandle, 'downloadServiceLines');
  if @RspDownloadServiceLines=nil then Raise Exception.Create('无效Rsp插件包，没有实现downloadServiceLines方法');
  @RspDownloadRelations := GetProcAddress(RspHandle, 'downloadRelations');
  if @RspDownloadRelations=nil then Raise Exception.Create('无效Rsp插件包，没有实现downloadRelations方法');
  @RspQueryUnion := GetProcAddress(RspHandle, 'queryUnion');
  if @RspQueryUnion=nil then Raise Exception.Create('无效Rsp插件包，没有实现queryUnion方法');
  @RspListModules := GetProcAddress(RspHandle, 'listModules');
  if @RspListModules=nil then Raise Exception.Create('无效Rsp插件包，没有实现listModules方法');
  @RspDownloadSort := GetProcAddress(RspHandle, 'downloadSort');
  if @RspDownloadSort=nil then Raise Exception.Create('无效Rsp插件包，没有实现downloadSort方法');
  @RspcheckUpgrade := GetProcAddress(RspHandle, 'checkUpgrade');
  if @RspcheckUpgrade=nil then Raise Exception.Create('无效Rsp插件包，没有实现checkUpgrade方法');
end;

procedure TrspFactory.FreeRspFactory;
begin
  FreeLibrary(RspHandle);
end;

procedure TrspFactory.DataModuleCreate(Sender: TObject);
var
  f:TIniFile;
  s:string;
begin
  LoadRspFactory;
  f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    s := f.ReadString('soft','rsp','');
    if (s<>'') and (s[1]='#') then
       begin
         delete(s,1,1);
         rspUrl := DecStr(s,ENC_KEY);
       end
    else
       rspUrl := s;
  finally
    F.Free;
  end;
  LoadRspFactory;
end;

procedure TrspFactory.DataModuleDestroy(Sender: TObject);
begin
  FreeRspFactory;
end;

function TrspFactory.CreateRspXML: IXMLDomDocument;
var
  Node:IXMLDOMElement;
begin
  result := CreateOleObject('Microsoft.XMLDOM')  as IXMLDomDocument;
  try
    Node := Result.createElement('message');
    result.documentElement := Node;
    Node.appendChild(Result.createElement('header'));
    FindElement(Node,'header').appendChild(Result.createElement('pub'));
    Node.appendChild(Result.createElement('body'));
  except
    result := nil;
    Raise;
  end;
end;

function TrspFactory.DesEncode(inStr, Key: string): string;
var
  EncStr:string;
begin
  EncStr := EncryStr(inStr+'{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}',Key);
  result := encddecd.EncodeString(EncStr);
end;

procedure TrspFactory.CheckRecAck(doc:IXMLDomDocument);
var
  node:IXMLDOMNode;
begin
  try
  if not Assigned(doc) then Raise Exception.Create('无效的XML文档...');
  node :=  doc.documentElement;
  if not Assigned(node) then Raise Exception.Create('无效的XML文档...');
  if node.nodeName<>'message' then Raise Exception.Create('无效的XML跟双方协议不相符...');
  node := FindElement(node,'header');
  if not Assigned(node) then Exception.Create('无效的XML跟双方协议不相符...');
  node := FindElement(node,'pub');
  if not Assigned(node) then Exception.Create('无效的XML跟双方协议不相符...');
  node := FindElement(node,'recAck');
  if not Assigned(node) then Exception.Create('无效的XML跟双方协议不相符...');
  if node.text<>'0000' then
     begin
       node := FindElement(node.parentNode,'msg');
       Raise Exception.Create(node.text);
     end
  else
     begin
       node := FindElement(node.parentNode,'timeStamp');
       if node<>nil then
          timeStamp := StrtoInt64(node.text);
     end;
  except
    on E:Exception do
      begin
        Raise;
      end;
  end;
end;

function TrspFactory.xsmLogin(username: string;flag:integer): boolean;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml:widestring;
  caTenantLoginResp,ServerInfo:IXMLDOMNode;
  code,hsname,srvrId,cstr,defSrvrId,defStr:string;
  f,r:TiniFile;
  finded,isSrvr:boolean;
  paramsList: TStringList;
  i:integer;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('caTenant');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('loginName');
  Node.text := username;
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('passwrd');
  Node.text := DesEncode(username,pubpwd);
  FindNode(doc,'body\caTenant').appendChild(Node);

  Node := doc.createElement('appVersion');
  Node.text := 'V6';
  FindNode(doc,'body\caTenant').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  doc := CreateXML(RspLogin(inxml,rspUrl,1));

  CheckRecAck(doc);
  result := false;
  caTenantLoginResp := FindNode(doc,'body\caTenantLoginResp');
  code := GetNodeValue(caTenantLoginResp,'code');
  if StrtoIntDef(code,0) in [1,5] then //认证成功
     begin
       result := true;
       tenantId := StrtoInt(GetNodeValue(caTenantLoginResp,'tenantId'));
       sslpwd := encddecd.DecodeString(GetNodeValue(caTenantLoginResp,'keyStr'));
       if RspHandle>0 then
          begin
            RspSetParams(pansichar(sslpwd));
          end;
       if code = '1' then
          begin
            f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
            r := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
            try
               srvrId := f.readString('db','srvrId','');
               defSrvrId := GetNodeValue(caTenantLoginResp,'srvrId');
               shopId := GetNodeValue(caTenantLoginResp,'shopId');
               if shopId='' then shopId := inttostr(tenantId)+'0001';
               resVersion := GetNodeValue(caTenantLoginResp,'resVersion');
               resDesktop := GetNodeValue(caTenantLoginResp,'resDesktop');
               prodParams := GetNodeValue(caTenantLoginResp,'prodParams');
               dbId := StrtoInt(GetNodeValue(caTenantLoginResp,'dbId'));
               f.WriteString('db','dbid',inttostr(dbId));
               
               if StrtointDef(GetNodeValue(caTenantLoginResp,'databasePort'),0)=0 then
                  hsname := GetNodeValue(caTenantLoginResp,'dbHostName')
               else
                  hsname := GetNodeValue(caTenantLoginResp,'dbHostName')+':'+GetNodeValue(caTenantLoginResp,'databasePort');

               finded := false;

               r.WriteString('soft','SFVersion','.'+GetNodeValue(caTenantLoginResp,'prodFlag'));
               r.WriteString('soft','CLVersion','.'+GetNodeValue(caTenantLoginResp,'industry'));
               r.WriteString('soft','ProductID',GetNodeValue(caTenantLoginResp,'prodId'));
               r.WriteString('soft','name',GetNodeValue(caTenantLoginResp,'prodName'));
               paramsList := TStringList.Create;
               try
                 paramsList.CommaText := prodParams;
                 for i := 0 to paramsList.Count - 1 do
                   begin
                     if (paramsList.Names[i] <> '') and (paramsList.ValueFromIndex[i] <> '') then
                       r.WriteString('soft',paramsList.Names[i],paramsList.ValueFromIndex[i]);
                   end;
               finally
                 paramsList.Free;
               end;
               ServerInfo := FindNode(doc,'body\caTenantLoginResp\servers');
               ServerInfo := ServerInfo.firstChild;
               isSrvr := false;
               while ServerInfo<>nil do
                 begin
                   f.WriteString('H_'+GetNodeValue(ServerInfo,'srvrId'),'srvrName',GetNodeValue(ServerInfo,'srvrName')); //服务名
                   f.WriteString('H_'+GetNodeValue(ServerInfo,'srvrId'),'connMode',GetNodeValue(ServerInfo,'connMode')); //连接模式
                   f.WriteString('H_'+GetNodeValue(ServerInfo,'srvrId'),'hostName',GetNodeValue(ServerInfo,'hostName')); //主机名
                   f.WriteString('H_'+GetNodeValue(ServerInfo,'srvrId'),'srvrPort',GetNodeValue(ServerInfo,'srvrPort')); //服务端口
                   f.WriteString('H_'+GetNodeValue(ServerInfo,'srvrId'),'srvrPath',GetNodeValue(ServerInfo,'srvrPath')); //服务路径
                   case strtoint(GetNodeValue(ServerInfo,'srvrStatus')) of
                   1: f.WriteString('H_'+GetNodeValue(ServerInfo,'srvrId'),'srvrStatus','正常');
                   2: f.WriteString('H_'+GetNodeValue(ServerInfo,'srvrId'),'srvrStatus','爆满');
                   9: begin
                        f.EraseSection(GetNodeValue(ServerInfo,'srvrId'));
                        ServerInfo := ServerInfo.nextSibling;
                        continue;
                      end;
                   else
                     f.WriteString('H_'+GetNodeValue(ServerInfo,'srvrId'),'srvrStatus','正常');
                   end;
                   if srvrId=GetNodeValue(ServerInfo,'srvrId') then isSrvr := true;
                   if not finded then
                     begin
                       if srvrId=GetNodeValue(ServerInfo,'srvrId') then
                         begin
                           f.WriteString('db','Connstr','connmode='+GetNodeValue(ServerInfo,'connMode')+';hostname='+GetNodeValue(ServerInfo,'hostName')+';port='+GetNodeValue(ServerInfo,'srvrPort')+';dbid='+inttostr(dbId));
                           finded := true;
                         end;
                     end;
                   if defSrvrId=GetNodeValue(ServerInfo,'srvrId') then
                     begin
                       defStr := 'connmode='+GetNodeValue(ServerInfo,'connMode')+';hostname='+GetNodeValue(ServerInfo,'hostName')+';port='+GetNodeValue(ServerInfo,'srvrPort')+';dbid='+inttostr(dbId);
                     end;
                   ServerInfo := ServerInfo.nextSibling;
                 end;
               if not finded or not isSrvr then //一直没找到设置，默认第一个
                 begin
                   ServerInfo := FindNode(doc,'body\caTenantLoginResp\servers');
                   ServerInfo := ServerInfo.firstChild;
                   if ServerInfo<>nil then
                     begin
                       f.WriteString('db','srvrId',defSrvrId);
                       f.WriteString('db','Connstr',defStr);
                     end;
                 end;
            finally
              f.Free;
              r.Free;
            end;
          end;
     end
  else
     Raise Exception.Create(GetNodeValue(caTenantLoginResp,'desc'));
end;

function TrspFactory.getTenantInfo(tenantId:integer): widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '3';
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('caTenant');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(tenantId);
  FindNode(doc,'body\caTenant').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;

  outxml := RspGetTenantInfo(inxml,rspUrl,2);
  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.getShopInfo(tenantId:integer;shopId:string): widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('caShopInfo');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\caShopInfo').appendChild(Node);

  Node := doc.createElement('shopId');
  Node.text := shopId;
  FindNode(doc,'body\caShopInfo').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;

  outxml := RspGetShopInfo(inxml,rspUrl,2);
  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.getGoodsInfo(barcode:string): widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.CreateElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.CreateElement('pubGoodsinfo');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.CreateElement('barcode');
  Node.text := barcode;
  FindNode(doc,'body\pubGoodsinfo').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;
  outxml := RspGetGoodsInfo(inxml,rspUrl,1);
  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.uploadGoods(inXml:widestring): boolean;
var
  doc:IXMLDomDocument;
  simpleReturn:IXMLDOMNode;
  code:string;
begin
  doc := CreateXML(RspUploadGoods(inxml,rspUrl,1));
  CheckRecAck(doc);
  simpleReturn := FindNode(doc,'body\simpleReturn');
  code := GetNodeValue(simpleReturn,'code');
  result := (code = '1');
end;

function TrspFactory.downloadTenants(tenantId, flag: integer; timestamp: int64): widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(timestamp);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;
  outxml := RspDownloadTenants(inxml,rspUrl,2);

  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.downloadServiceLines(tenantId, flag: integer; timestamp: int64): widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(timestamp);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;
  outxml := RspDownloadServiceLines(inxml,rspUrl,2);

  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.downloadRelations(tenantId, flag: integer; timestamp: int64): widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(timestamp);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;
  outxml := RspDownloadRelations(inxml,rspUrl,2);

  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.downloadUnion(tenantId, supTenantId, flag: integer; timestamp: int64): widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(1);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(timestamp);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('pubUnionQueryReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(tenantId);
  FindNode(doc,'body\pubUnionQueryReq').appendChild(Node);

  Node := doc.createElement('supTenantId');
  Node.text := inttostr(supTenantId);
  FindNode(doc,'body\pubUnionQueryReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;
  outxml := RspQueryUnion(inxml,rspUrl,2);

  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.downloadModules(tenantId, flag: integer; timestamp: int64): widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(timestamp);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('listModulesReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(TenantId);
  FindNode(doc,'body\listModulesReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;
  outxml := RspListModules(inxml,rspUrl,1);

  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.downloadSort(tenantId,flag:integer;timestamp:int64):widestring;
var
  doc:IXMLDomDocument;
  node:IXMLDOMNode;
  inxml,outxml:widestring;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := inttostr(flag);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('timeStamp');
  Node.text := inttostr(timestamp);
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('downloadReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := inttostr(tenantId);
  FindNode(doc,'body\downloadReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?>'+doc.xml;
  outxml := RspDownloadSort(inxml,rspUrl,2);
  doc := CreateXML(outxml);
  CheckRecAck(doc);
  result := outxml;
end;

function TrspFactory.FindElement(root: IXMLDOMNode;
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

function TrspFactory.FindNode(doc: IXMLDomDocument; tree: string;
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

function TrspFactory.CreateXML(xml: string): IXMLDomDocument;
var
  ErrXml:string;
  w:integer;
begin
  if copy(xml,1,6)='<Err>:' then
     begin
       if pos('Empty document',xml)>0 then
          begin
            Raise Exception.Create('无法连接到RSP认证服务器，请检查网络是否正常.');
          end
       else
           Raise Exception.Create('连接RSP服务失败了，请关闭防火墙再试试...');
     end;
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
    result := nil;
    Raise;
  end;
end;

procedure TrspFactory.Settimestamp(const Value: Int64);
begin
  Ftimestamp := Value;
end;

function TrspFactory.GetNodeValue(root: IXMLDOMNode; s: string): string;
var
  node:IXMLDOMNode;
begin
  node := FindElement(root,s);
  if node=nil then Raise Exception.Create('XML读取出错，原因：'+s+'结点属性没找到.');
  result := Node.text;
end;

procedure TrspFactory.SettenantId(const Value: integer);
begin
  FtenantId := Value;
end;

procedure TrspFactory.SetshopId(const Value: string);
begin
  FshopId := Value;
end;

procedure TrspFactory.SetprodParams(const Value: string);
begin
  FprodParams := Value;
end;

procedure TrspFactory.SetresDesktop(const Value: string);
begin
  FresDesktop := Value;
end;

procedure TrspFactory.SetresVersion(const Value: string);
begin
  FresVersion := Value;
end;

procedure TrspFactory.SetdbId(const Value: integer);
begin
  FdbId := Value;
end;

function TrspFactory.CheckUpgrade(TENANT_ID, PROD_ID,
  CurVeraion: string): TCaUpgrade;
var
  inxml:string;
  doc:IXMLDomDocument;
  caProductCheckUpgradeResp:IXMLDOMNode;
  Node:IXMLDOMNode;
  F:TIniFile;
begin
  doc := CreateRspXML;
  Node := doc.createElement('flag');
  Node.text := '1';
  FindNode(doc,'header\pub').appendChild(Node);

  Node := doc.createElement('caProductCheckUpgradeReq');
  FindNode(doc,'body').appendChild(Node);

  Node := doc.createElement('tenantId');
  Node.text := TENANT_ID;
  FindNode(doc,'body\caProductCheckUpgradeReq').appendChild(Node);

  Node := doc.createElement('prodId');
  Node.text := PROD_ID;
  FindNode(doc,'body\caProductCheckUpgradeReq').appendChild(Node);

  Node := doc.createElement('curVersion');
  Node.text := CurVeraion;
  FindNode(doc,'body\caProductCheckUpgradeReq').appendChild(Node);

  inxml := '<?xml version="1.0" encoding="gb2312"?> '+doc.xml;
  doc := CreateXML(rspcheckUpgrade(inxml,rspUrl,1));
  CheckRecAck(doc);

  caProductCheckUpgradeResp := FindNode(doc,'body\caProductCheckUpgradeResp');
  result.UpGrade := StrtoInt(GetNodeValue(caProductCheckUpgradeResp,'upgradeType'));
  result.URL := GetNodeValue(caProductCheckUpgradeResp,'pkgDownloadUrl');
  result.Version := GetNodeValue(caProductCheckUpgradeResp,'newVersion');
  //写安装目录到临时文件夹
  F := TIniFile.Create(FnSystem.GetWinTmp+'r3.inst');
  try
    F.WriteString('r3','path',ExtractFileDir(ParamStr(0)));
  finally
    F.Free;
  end;
end;

end.
