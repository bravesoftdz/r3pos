unit uXsmFactory;

interface

uses Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase,
     ObjCommon, Dialogs, DB, IdHTTP ,EncDec, MSHTML, ActiveX, OleCtrls, msxml,
     Variants, ComObj, uFnUtil, StrUtils, IniFiles, ZLogFile;

type
  TXsmFactory=class
  private
    idHttp:TIdHTTP;
    ParentCode:integer;
    ParentName:string;
    xsm_center:string;
    http_addr:string;
    xsm_refId:string;
    xsm_comId:string;
    xsm_challenge:string;
    days_diff:integer;
    function  XsmAuth:boolean;
    function  getMail_Scnotice(var hs,ls:TZQuery;cs:TZQuery):boolean;
    function  getMail_ScnoticeDetail(comId,seq: string):string;
    function  getBBS_SlsmanWorkAct(var hs,ls:TZQuery;cs:TZQuery):boolean;
    function  getBBS_SlsmanWorkActDetail(blockId,bbsType,org_code,bbsId:string):string;
    function  getChallenge:boolean;
    function  doLogin:boolean;
    function  getXsmConfig:boolean;
    procedure getParentInfo;
  public
    constructor Create;
    destructor  Destroy;override;
    function  getXsmMessage:boolean;
  end;

var XsmFactory:TXsmFactory;

implementation

uses uTokenFactory,udataFactory,udllGlobal;

function HtmlToText(HtmlText: WideString): WideString;
var
  V: OleVariant;
  Document: IHTMLDocument2;
begin
  result := HtmlText;
  if HtmlText = '' then Exit;
  CoInitialize(nil);
  Document := CoHTMLDocument.Create as IHtmlDocument2;
  try
    V := VarArrayCreate([0, 0], varVariant);
    V[0] := HtmlText;
    Document.Write(PSafeArray(TVarData(v).VArray));
    Document.Close;
    result := trim(Document.body.outerText);
  finally
    Document := nil;
    CoUninitialize;
  end;
end;

function URLDecode(const S: string): string;
var
  Idx: Integer;
  Hex: string;
  Code: Integer;
begin
  result := '';
  Idx := 1;
  while Idx <= Length(S) do
    begin
      case S[Idx] of
        '%':
        begin
          if Idx <= Length(S) - 2 then
             begin
               Hex := S[Idx+1] + S[Idx+2];
               Code := SysUtils.StrToIntDef('$' + Hex, -1);
               Inc(Idx, 2);
             end
          else
             Code := -1;

          if Code = -1 then
             Raise SysUtils.EConvertError.Create('Invalid hex digit in URL');

          result := result + Chr(Code);
        end;
        '+':
          result := result + ' '
        else
          result := result + S[Idx];
      end;
    Inc(Idx);
  end;
end;

function CreateXML(xml: string): IXMLDomDocument;
var
  w:integer;
  ErrXml:string;
begin
  result := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  try
    if xml <> '' then
       begin
         if not result.loadXML(xml) then
            begin
              ErrXml := xml;
              w := pos('?>',ErrXml);
              delete(ErrXml,1,w+1);
              if not result.loadXML(ErrXml) then Raise Exception.Create('loadxml出错了,xml='+xml);
            end;
       end
    else
       Raise Exception.Create('xml字符串不能为空...');
  except
    on E:Exception do result := nil;
  end;
end;

function FindElement(root: IXMLDOMNode; s: string): IXMLDOMNode;
begin
  result := root.firstChild;
  while result <> nil do
    begin
    if result.nodeName = s then Exit;
    result := result.nextSibling;
    end;
  result := nil;
end;

function FindNode(doc: IXMLDomDocument; tree: string): IXMLDOMNode;
var
  s:TStringList;
  i:integer;
begin
  s := TStringList.Create;
  try
    s.Delimiter := '\';
    s.DelimitedText := tree;
    result := doc.documentElement;
    for i := 0 to s.Count -1 do
      begin
        if result  <> nil then result := FindElement(result,s[i]);
      end;
  finally
    s.Free;
  end;
end;

constructor TXsmFactory.Create;
begin
  idHttp := TIdHTTP.Create(nil);
  idHttp.HandleRedirects := true;
  days_diff := 300;
end;

destructor TXsmFactory.Destroy;
begin
  idHttp.Free;
  inherited;
end;

function TXsmFactory.getBBS_SlsmanWorkAct(var hs, ls: TZQuery; cs: TZQuery): boolean;
var
  url,blockId,bbsType:string;
  firstRow,maxRows,pageCount,pageCurr:Integer;
  doc:IXMLDomDocument;
  root:IXMLDOMElement;
  Child,Node:IXMLDOMNode;
  xml:string;
  strTemp:string;
  vMSG_ID:string;
  vMSG_CONTENT:string;
begin
  blockId := 'SlsmanWorkAct';
  bbsType := '10';
  firstRow := 0;
  maxRows  := 10;

  url := http_addr+'/bbs/ecbbsflex/getBbsListByPageInterface?blockId='+blockId+'&bbsType='+bbsType+'&orgCode='+xsm_comId+'&refId='+xsm_refId+'&firstRow='+inttostr(firstRow)+'&maxRows='+inttostr(maxRows)+'&status=1&userType=1000';
  xml := idHttp.Get(url);
  xml := Utf8ToAnsi(xml);
  doc := CreateXML(xml);

  if not Assigned(doc) then Exit;
  root := doc.DocumentElement;
  if not Assigned(root) then Exit;
  if root.attributes.getNamedItem('code').text <> '0000' then Exit;

  pageCount := strtoint(root.attributes.getNamedItem('pageCount').text) ;

  Node := FindNode(doc,'XSM_OUT_INFO');

  if Node = nil then Exit;

  Child := Node.firstChild;
  while Child <> nil do
    begin
      if trim(Child.attributes.getNamedItem('bbsDate').text) <= FormatDatetime('YYYYMMDD',now()-days_diff) then
         begin
           pageCount := 1;
           break;
         end;

      if (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('bbsId').text))) > 36)
         or
         (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('userName').text))) > 36)
         or
         (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('bbsTitle').text))) > 50)
         then
         begin
           Child := Child.nextSibling;
           continue;
         end;

      vMSG_ID := Child.attributes.getNamedItem('bbsId').text;
      vMSG_CONTENT := getBBS_SlsmanWorkActDetail(blockId, bbsType,xsm_comId,Child.attributes.getNamedItem('bbsId').text);
          
      if (not cs.Locate('MSG_ID', vMSG_ID, [])) and (vMSG_CONTENT<>'') then
         begin
           hs.Append;
           hs.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
           hs.FieldByName('MSG_ID').AsString := vMSG_ID;
           hs.FieldByName('MSG_CLASS').AsString := '2';
           hs.FieldByName('ISSUE_DATE').AsInteger := strtoint(trim(Child.attributes.getNamedItem('bbsDate').text));
           hs.FieldByName('ISSUE_TENANT_ID').AsInteger := ParentCode;
           hs.FieldByName('MSG_SOURCE').AsString := ParentName;
           hs.FieldByName('ISSUE_USER').AsString := Child.attributes.getNamedItem('userName').text;
           hs.FieldByName('MSG_TITLE').AsString := Child.attributes.getNamedItem('bbsTitle').text;
           hs.FieldByName('MSG_CONTENT').AsString :=vMSG_CONTENT;
           strTemp := Child.attributes.getNamedItem('updateDate').text;
           hs.FieldByName('END_DATE').AsString := FormatDatetime('YYYY-MM-DD',incMonth(fnTime.fnStrtoDate(strTemp),1));;
           hs.FieldByName('COMM_ID').AsString := Child.attributes.getNamedItem('bbsId').text;
           hs.Post;

           ls.Append;
           ls.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
           ls.FieldByName('MSG_ID').AsString := vMSG_ID;
           ls.FieldByName('SHOP_ID').AsString := token.shopId;
           ls.FieldByName('READ_DATE').AsString := '';
           ls.FieldByName('READ_USER').AsString := '';
           ls.FieldByName('MSG_FEEDBACK_STATUS').AsInteger := 1;
           ls.FieldByName('MSG_READ_STATUS').AsInteger := 1;
           ls.Post;
         end;
      Child := Child.nextSibling;
    end;

  if pageCount > 1 then
     begin
       pageCurr := 2;
       while pageCount >= pageCurr do
         begin
           pageCurr := pageCurr +1;
           firstRow := firstRow + maxRows;

           url := http_addr+'/bbs/ecbbsflex/getBbsListByPageInterface?blockId='+blockId+'&bbsType='+bbsType+'&orgCode='+xsm_comId+'&refId='+xsm_refId+'&firstRow='+inttostr(firstRow)+'&maxRows='+inttostr(maxRows)+'&status=1&userType=1000';
           xml := idHTTP.Get(url);
           xml := Utf8ToAnsi(xml);
           doc := CreateXML(xml);
           if not Assigned(doc) then continue;
           root := doc.DocumentElement;
           if not Assigned(root) then continue;
           if root.attributes.getNamedItem('code').text <> '0000' then continue;

           Node := FindNode(doc,'XSM_OUT_INFO');

           if Node = nil then Exit;

           Child := Node.firstChild;
           while Child <> nil do
             begin
               if trim(Child.attributes.getNamedItem('bbsDate').text) <= FormatDatetime('YYYYMMDD',now()-days_diff) then
                  begin
                    pageCount := 1;
                    break;
                  end;

               if (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('bbsId').text))) > 36)
                  or
                  (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('userName').text))) > 36)
                  or
                  (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('bbsTitle').text))) > 50)
                  then
                  begin
                    Child := Child.nextSibling;
                    continue;
                  end;

               vMSG_ID := Child.attributes.getNamedItem('bbsId').text;
               vMSG_CONTENT := getBBS_SlsmanWorkActDetail(blockId,bbsType,xsm_comId,Child.attributes.getNamedItem('bbsId').text);

               if (not cs.Locate('MSG_ID', vMSG_ID, [])) and (vMSG_CONTENT<>'') then
                  begin
                    hs.Append;
                    hs.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
                    hs.FieldByName('MSG_ID').AsString := vMSG_ID;
                    hs.FieldByName('MSG_CLASS').AsString := '4';
                    hs.FieldByName('ISSUE_DATE').AsInteger := strtoint(trim(Child.attributes.getNamedItem('bbsDate').text));
                    hs.FieldByName('ISSUE_TENANT_ID').AsInteger := ParentCode;
                    hs.FieldByName('MSG_SOURCE').AsString := ParentName;
                    hs.FieldByName('ISSUE_USER').AsString := Child.attributes.getNamedItem('userName').text;
                    hs.FieldByName('MSG_TITLE').AsString := Child.attributes.getNamedItem('bbsTitle').text;
                    hs.FieldByName('MSG_CONTENT').AsString := vMSG_CONTENT;
                    strTemp := Child.attributes.getNamedItem('updateDate').text;
                    hs.FieldByName('END_DATE').AsString := FormatDatetime('YYYY-MM-DD',incMonth(fnTime.fnStrtoDate(strTemp),1));;
                    hs.FieldByName('COMM_ID').AsString := Child.attributes.getNamedItem('bbsId').text;
                    hs.Post;

                    ls.Append;
                    ls.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
                    ls.FieldByName('MSG_ID').AsString := vMSG_ID;
                    ls.FieldByName('SHOP_ID').AsString := token.shopId;
                    ls.FieldByName('READ_DATE').AsString := '';
                    ls.FieldByName('READ_USER').AsString := '';
                    ls.FieldByName('MSG_FEEDBACK_STATUS').AsInteger := 1;
                    ls.FieldByName('MSG_READ_STATUS').AsInteger := 1;
                    ls.Post;
                  end;

               Child := Child.nextSibling;
            end;
         end;
     end;

  result := true;
end;

function TXsmFactory.getBBS_SlsmanWorkActDetail(blockId, bbsType, org_code, bbsId: string): string;
var
  url:string;
  doc:IXMLDomDocument;
  root:IXMLDOMElement;
  Child,Node:IXMLDOMNode;
  xml:string;
begin
  url := http_addr+'/bbs/ecbbsflex/getBbsInterface?blockId='+blockId+'&bbsType='+bbsType+'&orgCode='+org_code+'&bbsId='+bbsId+'&status=1';
  xml := idHttp.Get(url);
  xml := Utf8ToAnsi(xml);
  doc := CreateXML(xml);
  if not Assigned(doc) then Exit;
  root := doc.DocumentElement;
  if not Assigned(root) then Exit;
  if root.attributes.getNamedItem('code').text <> '0000' then Exit;
  Node := FindNode(doc,'XSM_OUT_INFO');
  if Node = nil then Exit;
  Child := Node.firstChild;
  if Child = nil then
     result := ''
  else
     begin
       result := HtmlToText(URLDecode(Child.attributes.getNamedItem('bbsContent').text));
       if Length(result) >500 then result := LeftStr(result,494)+'......';
     end;
end;

function TXsmFactory.getMail_Scnotice(var hs, ls: TZQuery; cs: TZQuery): boolean;
var
  url,strTemp:string;
  doc:IXMLDomDocument;
  root:IXMLDOMElement;
  Child:IXMLDOMNode;
  xml:string;
  vMSG_ID:string;
  vMSG_CONTENT:string;
begin
  url := http_addr+'/mail/scnotice/getNoticeToShowInterface';
  xml := idHttp.Get(url);
  xml := Utf8ToAnsi(xml);
  doc := CreateXML(xml);

  if not Assigned(doc) then Raise Exception.Create('获得公告列表失败...');
  root := doc.DocumentElement;
  if not Assigned(root) then Raise Exception.Create('Url地址返回无效XML文档，获得公告列表失败...');
  if root.attributes.getNamedItem('retCode').text <> '0000' then Raise Exception.Create('获得公告列表失败,错误:'+root.attributes.getNamedItem('retCode').text);

  Child := root.firstChild;
  while Child <> nil do
    begin
      if Child.attributes.getNamedItem('status').text = '20' then
         begin
           if trim(Child.attributes.getNamedItem('effectTime').text) <= FormatDatetime('YYYYMMDD',now()-days_diff) then
              begin
                break;
              end;

           if (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('noticeId').text))) > 36)
              or
              (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('sendUserName').text))) > 36)
              or
              (Length(WideCharToString(PWideChar(Child.attributes.getNamedItem('noticeTitle').text))) > 50)
              then
              begin
                Child := Child.nextSibling;
                continue;
              end;

           vMSG_ID:=Child.attributes.getNamedItem('noticeId').text;
           vMSG_CONTENT:=getMail_ScnoticeDetail(Child.attributes.getNamedItem('comId').text,Child.attributes.getNamedItem('seq').text);

           if (not cs.Locate('MSG_ID',vMSG_ID,[])) and (vMSG_CONTENT<>'') then
              begin
                hs.Append;
                hs.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
                hs.FieldByName('MSG_ID').AsString := vMSG_ID;
                hs.FieldByName('MSG_CLASS').AsString := '1';
                hs.FieldByName('ISSUE_DATE').AsInteger := strtoint(trim(Child.attributes.getNamedItem('effectTime').text));
                hs.FieldByName('ISSUE_TENANT_ID').AsInteger := ParentCode;
                hs.FieldByName('MSG_SOURCE').AsString := ParentName;
                hs.FieldByName('ISSUE_USER').AsString := Child.attributes.getNamedItem('sendUserName').text;
                hs.FieldByName('MSG_TITLE').AsString := Child.attributes.getNamedItem('noticeTitle').text;
                hs.FieldByName('MSG_CONTENT').AsString := vMSG_CONTENT;
                strTemp := trim(Child.attributes.getNamedItem('expireTime').text);
                if Length(strTemp)>=8 then
                   hs.FieldByName('END_DATE').AsString := Copy(strTemp,1,4)+'-'+Copy(strTemp,5,2)+'-'+Copy(strTemp,7,2)
                else
                   hs.FieldByName('END_DATE').AsString := strTemp;
                hs.FieldByName('COMM_ID').AsString := Child.attributes.getNamedItem('noticeId').text;
                hs.Post;

                ls.Append;
                ls.FieldByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
                ls.FieldByName('MSG_ID').AsString := vMSG_ID;
                ls.FieldByName('SHOP_ID').AsString := token.shopId;
                ls.FieldByName('READ_DATE').AsString := '';
                ls.FieldByName('READ_USER').AsString := '';
                ls.FieldByName('MSG_FEEDBACK_STATUS').AsInteger := 1;
                ls.FieldByName('MSG_READ_STATUS').AsInteger := 1;
                ls.Post;
              end;
         end;
      Child := Child.nextSibling;
    end;
  result := true;
end;

function TXsmFactory.getMail_ScnoticeDetail(comId, seq: string): string;
var
  url:string;
  doc:IXMLDomDocument;
  root:IXMLDOMElement;
  Child:IXMLDOMNode;
  xml:string;
begin
  result := '';
  url := http_addr+'/mail/scnotice/detail?comId='+comId+'&seq='+seq;
  xml := idHttp.Get(url);
  xml := Utf8ToAnsi(xml);
  doc := CreateXML(xml);
  if not Assigned(doc) then Raise Exception.Create('获得公告明细失败...');
  root := doc.DocumentElement;
  if not Assigned(root) then Raise Exception.Create('Url地址返回无效XML文档，获得公告明细失败....');
  if root.attributes.getNamedItem('retCode').text <> '0000' then Raise Exception.Create('获得公告明细失败,错误:'+root.attributes.getNamedItem('retCode').text);
  Child := root.firstChild;
  if Child <> nil then
     begin
       result := HtmlToText(URLDecode(Child.attributes.getNamedItem('noticeContent').text));
       if Length(result) >500 then result := LeftStr(result,494)+'......';
     end;
end;

procedure TXsmFactory.getParentInfo;
var
  rs:TZQuery;
begin
  ParentCode := 0;
  ParentName := '市公司';
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TENANT_ID,SHORT_TENANT_NAME from CA_TENANT where TENANT_ID in (select TENANT_ID from CA_RELATIONS where RELATI_ID = ' + token.tenantId +' and RELATION_ID = 1000006 )';
    dataFactory.Open(rs);
    if not rs.IsEmpty then
       begin
         ParentCode := rs.fieldbyName('TENANT_ID').AsInteger;
         ParentName := rs.fieldbyName('SHORT_TENANT_NAME').AsString;
       end;
  finally
    rs.Free;
  end;
end;

function TXsmFactory.getXsmMessage: boolean;
var
  hs,ls,cs:TZQuery;
  Params:TftParamList;
begin
  try
    getParentInfo;
    hs := TZQuery.Create(nil);
    ls := TZQuery.Create(nil);
    cs := TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
      Params.ParamByName('SHOP_ID').AsString := token.shopId;
      Params.ParamByName('MSG_ID').AsString := '';
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(hs,'TMessage',Params);
        dataFactory.AddBatch(ls,'TMessageList',Params);
        dataFactory.OpenBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;

      cs.SQL.Text :=
        ' select A.MSG_ID as MSG_ID,A.MSG_CLASS as MSG_CLASS '+
        ' from MSC_MESSAGE A '+
        ' left outer join (select MSG_ID from MSC_MESSAGE_LIST where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID) B on A.MSG_ID=B.MSG_ID '+
        ' where A.TENANT_ID=:TENANT_ID and A.ISSUE_TENANT_ID=:ISSUE_TENANT_ID and A.ISSUE_DATE>=:ISSUE_DATE and A.MSG_CLASS in (''0'',''1'',''2'',''4'')';
      cs.Params.ParamByName('ISSUE_TENANT_ID').AsInteger := ParentCode;
      cs.Params.ParamByName('ISSUE_DATE').AsString := FormatDatetime('YYYYMMDD',Date()-days_diff);
      dataFactory.Open(cs);

      if XsmAuth then
         begin
           try
             getMail_Scnotice(hs,ls,cs);
           except
             on E:Exception do
                begin
                  LogFile.AddLogFile(0, '获取公共信息失败,' + E.Message);
                end;
           end;

           try
             getBBS_SlsmanWorkAct(hs,ls,cs);
           except
             on E:Exception do
                begin
                  LogFile.AddLogFile(0, '获取营销建议失败,' + E.Message);
                end;
           end;
         end;

      if hs.State in [dsEdit,dsInsert] then hs.Post;
      if ls.State in [dsEdit,dsInsert] then ls.Post;
      if (not hs.IsEmpty) or (not ls.IsEmpty) then
         begin
           dataFactory.BeginBatch;
           try
             dataFactory.AddBatch(hs,'TMessage');
             dataFactory.AddBatch(ls,'TMessageList');
             dataFactory.CommitBatch;
           except
             dataFactory.CancelBatch;
             Raise;
           end;
         end;
    finally
      Params.Free;
      cs.Free;
      hs.Free;
      ls.Free;
    end;
  except
    on E:Exception do
       begin
         LogFile.AddLogFile(0, '获取新商盟消息失败,' + E.Message);
       end;
  end;
end;

function TXsmFactory.getChallenge: boolean;
var
  F:TIniFile;
  List:TStringList;
  doc:IXMLDomDocument;
  root:IXMLDOMElement;
  xml,url:string;
begin
  result := false;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    if dllGlobal.AuthMode <> 2 then
       begin
         xsm_center := F.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
         if xsm_center = '' then
            xsm_center := ''
         else
            begin
              List.CommaText := xsm_center;
              xsm_center := List.Values['xsmc'];
            end;
       end
    else xsm_center := dllGlobal.XsmCenterUrl;

    url := xsm_center+'users/forlogin';
    xml := idHttp.Get(url);
    xml := Utf8ToAnsi(xml);
    doc := CreateXML(xml);
    if not Assigned(doc) then Raise Exception.Create('获取验证码失败...');
    root := doc.DocumentElement;
    if not Assigned(root) then Raise Exception.Create('url地址返回无效xml文档，获取验证码失败...');
    if root.attributes.getNamedItem('code')=nil then Raise Exception.Create('url地址返回无效xml文档，获取验证码失败...');
    if root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('获取校验码失败,错误:'+root.attributes.getNamedItem('msg').text);
    xsm_challenge := root.selectSingleNode('challenge').text;
    result := true;
  finally
    List.free;
    F.Free;
  end;
end;

function TXsmFactory.doLogin: boolean;
const
  dec='{1#2$3%4(5)6@7!poeeww$3%4(5)djjkkldss}';
function md5(s:string):string;
begin
  result := md5Encode(s+dec);
end;
var
  doc:IXMLDomDocument;
  root:IXMLDOMElement;
  xml,url:string;
begin
  result := false;
  url := xsm_center+'users/dologin/up?j_username='+token.xsmCode+'&j_password='+md5(md5(token.xsmPWD)+xsm_challenge);
  xml := idHttp.Get(url);
  xml := Utf8ToAnsi(xml);
  doc := CreateXML(xml);
  if not Assigned(doc) then Raise Exception.Create('用户名密码验证失败...');
  root := doc.DocumentElement;
  if not Assigned(root) then Raise Exception.Create('url地址返回无效xml文档，用户名密码验证失败...');
  if root.attributes.getNamedItem('code')=nil then Raise Exception.Create('url地址返回无效xml文档，用户名密码验证失败...');
  if root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('用户名密码验证失败，错误:'+root.attributes.getNamedItem('msg').text);
  xsm_comId := root.selectSingleNode('comId').text;
  xsm_refId := root.selectSingleNode('refId').text;
  result := true;
end;

function TXsmFactory.getXsmConfig: boolean;
var
  doc:IXMLDomDocument;
  root:IXMLDOMElement;
  Node:IXMLDOMNode;
  xml,url:string;
begin
  result := false;
  url := xsm_center+'navi/donavi/a?userId='+token.xsmCode+'&isFirst=0&comId='+xsm_comId+'&zoneId=GWGC';
  xml := idHttp.Get(url);
  xml := Utf8ToAnsi(xml);
  doc := CreateXML(xml);
  if not Assigned(doc) then Raise Exception.Create('获取新商盟配置信息失败...');
  root := doc.DocumentElement;
  if not Assigned(root) then Raise Exception.Create('url地址返回无效xml文档，获取新商盟配置信息失败...');
  if root.attributes.getNamedItem('code')=nil then Raise Exception.Create('url地址返回无效xml文档，获取新商盟配置信息失败...');
  if root.attributes.getNamedItem('code').text<>'0000' then Raise Exception.Create('获取新商盟配置信息失败,错误:'+root.attributes.getNamedItem('msg').text);
  Node := FindNode(doc,'server_info\web_server');
  if Node = nil then Exit;
  http_addr := Node.attributes.getNamedItem('web_url').text;
  result := true;
end;

function TXsmFactory.XsmAuth: boolean;
begin
  result := false;
  try
    if getChallenge then if doLogin then result := getXsmConfig;
  except
    on E:Exception do
       begin
         LogFile.AddLogFile(0,'新商盟认证失败，'+E.Message);
       end;
  end;
end;

initialization
  XsmFactory := TXsmFactory.Create;
finalization
  if Assigned(XsmFactory) then FreeAndNil(XsmFactory);
end.
