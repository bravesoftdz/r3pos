unit javaScriptExt;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses ComObj, ActiveX, Classes, shop_TLB, StdVcl, Forms, Windows, Messages,
     ZDataSet, SysUtils, ZBase, EncDec, IniFiles;

type
  TjavaScriptExt = class(TAutoObject, IjavaScriptExt)
  private
    Verify:string;
    lastError:string;
    _verify: WideString;
  protected
    procedure SaveTimeStamp;
    procedure CheckTimeStamp;
    function signIn(const username, password, verify: WideString; online: WordBool): WordBool;
      safecall;
    procedure signOut; safecall;
    function getVerify: WideString; safecall;
    function getToken(const appId: WideString): WideString; safecall;
    function createDataSet: Integer; safecall;
    function connect: WordBool; safecall;
    procedure disconnet; safecall;
    procedure append(ds: Integer); safecall;
    procedure edit(ds: Integer); safecall;
    function getAsString(ds: Integer; const fieldname: WideString): WideString; safecall;
    function getAsInteger(ds: Integer; const fieldname: WideString): Integer; safecall;
    function getAsValue(ds: Integer; const fieldname: WideString): OleVariant; safecall;
    function getAsDouble(ds: Integer; const fieldname: WideString): Double; safecall;
    procedure setAsString(ds: Integer; const fieldname: WideString; const value: WideString); safecall;
    procedure setAsInteger(ds: Integer; const fieldname: WideString; value: Integer); safecall;
    procedure setAsValue(ds: Integer; const fieldname: WideString; value:OleVariant); safecall;
    procedure setAsDouble(ds: Integer; const fieldname: WideString; value: Double); safecall;
    procedure post(ds: Integer); safecall;
    function  eof(ds: Integer): WordBool; safecall;
    procedure first(ds: Integer); safecall;
    procedure last(ds: Integer); safecall;
    procedure next(ds: Integer); safecall;
    procedure prior(ds: Integer); safecall;
    procedure eraseDataSet(ds: Integer); safecall;
    function locate(ds: Integer; const fieldname: WideString; value: OleVariant): WordBool; safecall;
    procedure setSQL(ds: Integer; const SQL: WideString); safecall;
    procedure open(ds: Integer; const ns: WideString; const Params: WideString); safecall;
    function getLastError: WideString; safecall;
    procedure beginbatch; safecall;
    procedure addbatch(ds: Integer; const ns: WideString; const params: WideString);safecall;
    procedure openBatch; safecall;
    procedure commitBatch;safecall;
    procedure cancelBatch;safecall;
    procedure updatebatch(ds: Integer; const ns: WideString;const Params: WideString); safecall;
    function execSQL(const SQL: WideString): Integer; safecall;
    function iDbType: Integer;safecall;
    procedure moveToRemote;safecall;
    procedure moveToSqlite;safecall;
    procedure moveToDefault; safecall;
    function parseSQL(const sql: WideString): WideString; safecall;
    function getUserInfo: WideString; safecall;
    function getLocalJson(const doMain: WideString): WideString; safecall;
    procedure setLocalJson(const doMain: WideString; const json: WideString); safecall;
    function signToken(const _token: WideString): WordBool; safecall;
    function getIniInfo(const FileName: WideString; const Section: WideString; 
                        const ParamName: WideString; const DefaultValue: WideString): WideString; safecall;
  end;

implementation

uses ComServ,udataFactory,uUcFactory,uRspFactory,uTokenFactory,ufrmBrowerForm,udllFactory;

function TjavaScriptExt.signIn(const username, password,
  verify: WideString; online: WordBool): WordBool;
var tenantId:integer;
function CheckRegister:boolean;
var
  rs:TZQuery;
begin
  dataFactory.MoveToSqlite;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=0 and DEFINE=''TENANT_ID''';
    dataFactory.Open(rs);
    result := (rs.Fields[0].AsString<>'');
    if result then tenantId := rs.Fields[0].asInteger;
  finally
    rs.Free;
  end;
end;

var
  rs,us:TZQuery;
  isXsm:boolean;
begin
  result := false;
  signOut;
  if _verify<>verify then Raise Exception.Create('校验码无效');
  if not CheckRegister then //没有注册,先自动注册
     begin
        if not online then Raise Exception.Create('没开通零售终端不支持离线使用');  
        if not rspFactory.xsmLogin(username,3) then Raise Exception.Create('当前账号没有开通零售终端，请联系客户经理申请。'); 
        if UcFactory.xsmLogin(username,password) then
           begin
             dataFactory.signined := true;
             token.shoped := false;
             token.tenantId := '';
             token.online := online;
             token.account := username;
             token.xsmCode := username;
             token.xsmPWD := password;
             token.userId := username;
             token.username := username;
             token.Logined := true;
             DllFactory.Inited := false;
             token.online := online;
             dataFactory.signined := true;
             result := true;
             Exit;
             //if rspFactory.xsmLogin(username,3) then
             //   begin
             //     WriteRegister;
             //     dataFactory.MoveToDefault;
             //     dataFactory.connect;
             //     result := true;
             //     Exit;
             //   end;
           end;
     end
  else
     begin
        token.shoped := true;
        token.online := online;
        if online then //在线操作情况重取系统参数
           begin
              //已经登录过了，用企业号订证一下，读取相关连接参数
              if rspFactory.xsmLogin(inttostr(tenantId),4) then
                 begin
                   dataFactory.MoveToDefault;
                   dataFactory.connect;
                 end else Raise Exception.Create('rsp认证失败了，当前企业没开通终端功能');
           end
        else
           begin
              dataFactory.MoveToSqlite;
           end;
     end;
  //开始登录
  rs := TZQuery.Create(nil);
  us := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT,A.TENANT_ID,C.TENANT_NAME from VIW_USERS A,CA_SHOP_INFO B,CA_TENANT C '+
      'where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.COMM not in (''02'',''12'') and A.TENANT_ID=:TENANT_ID and A.ACCOUNT in ('''+username+''','''+lowercase(username)+''','''+uppercase(username)+''')';
    rs.ParamByName('TENANT_ID').AsInteger := tenantId;
    dataFactory.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('无效登录名.'); 
    isXsm := (rs.FieldByName('ROLE_IDS').AsString = 'xsm');
    if not ((rs.FieldByName('ACCOUNT').AsString = 'admin') or (rs.FieldByName('ACCOUNT').AsString = 'system') or isXsm) then
        begin
          us.SQL.Text := 'select DIMI_DATE,PASS_WRD from CA_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT='+QuotedStr(rs.FieldByName('ACCOUNT').AsString)+
          ' and A.TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' ';
          dataFactory.Open(us);
          if us.IsEmpty then Raise Exception.Create(username+'用户账号不存在,不能登录。');
          if (us.FieldbyName('DIMI_DATE').AsString<>'') and (us.FieldbyName('DIMI_DATE').AsString<=FormatDateTime('YYYY-MM-DD',Date())) then Raise Exception.Create(username+'用户账号已经离职,不能登录。');
        end;

     if username='system' then
        begin
          if lowerCase(password)<>('rspcn.com@'+formatdatetime('YYMMDD',date())+inttostr(strtoint(formatDatetime('DD',Date())) mod 7 )) then
             begin
                Raise Exception.Create('输入的密码无效,请重新输入。');
             end;
        end
     else
        begin
          if isXsm and online then //在线使用并属于新商盟用户
             begin
               if UcFactory.xsmLogin(username,password) then
                  begin
                     dataFactory.MoveToSqlite;
                     dataFactory.ExecSQL('update CA_SHOP_INFO set XSM_PSWD='''+EncStr(password,ENC_KEY)+''' where TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' and SHOP_ID='''+rs.FieldbyName('SHOP_ID').asString+'''');
                     dataFactory.movetoDefault;
                     dataFactory.ExecSQL('update CA_SHOP_INFO set XSM_PSWD='''+EncStr(password,ENC_KEY)+''' where TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' and SHOP_ID='''+rs.FieldbyName('SHOP_ID').asString+'''');
                  end
               else
                  Raise Exception.Create('输入的密码无效,请重新输入。');
             end
          else
             begin
               if UpperCase(password) <> UpperCase(DecStr(rs.FieldbyName('PASS_WRD').AsString,ENC_KEY)) then
                  Raise Exception.Create('输入的密码无效,请重新输入。');
             end;
        end;
    token.userId := rs.FieldbyName('USER_ID').AsString;
    token.account := rs.FieldbyName('ACCOUNT').AsString;
    token.tenantId := rs.FieldbyName('TENANT_ID').AsString;
    token.tenantName := rs.FieldbyName('TENANT_NAME').AsString;
    token.shopId := rs.FieldbyName('SHOP_ID').AsString;
    token.shopName := rs.FieldbyName('SHOP_NAME').AsString;
    token.username := rs.FieldbyName('USER_NAME').AsString;
    rs.Close;
    rs.SQL.Text := 'select XSM_CODE,XSM_PSWD,ADDRESS,LICENSE_CODE,LINKMAN,TELEPHONE from CA_SHOP_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    dataFactory.Open(rs);
    token.address := rs.FieldbyName('ADDRESS').AsString;
    token.xsmCode := rs.FieldbyName('XSM_CODE').AsString;
    token.xsmPWD := DecStr(rs.FieldbyName('XSM_PSWD').AsString,ENC_KEY);
    token.licenseCode := rs.FieldbyName('LICENSE_CODE').AsString;
    token.legal := rs.FieldbyName('LINKMAN').AsString;
    token.mobile := rs.FieldbyName('TELEPHONE').AsString;
    if online then SaveTimeStamp else checkTimeStamp;
    token.Logined := true;
    DllFactory.Inited := false;
    token.online := online;
    dataFactory.signined := true;
    PostMessage(frmBrowerForm.Handle,WM_UPGRADE_CHECK,0,0);
  finally
    us.Free;
    rs.Free;
  end;
  result := true;
end;

procedure TjavaScriptExt.signOut;
begin
  dataFactory.signined := false;
  UcFactory.xsmLogined := false;
  token.Logined := false;
end;

function TjavaScriptExt.getVerify: WideString;
begin
  result := 'rspcn://test/ht_oa.gif';
  _verify := '123456';
end;

function TjavaScriptExt.getToken(const appId: WideString): WideString;
begin
  result := 'abcdkjed';
end;

procedure TjavaScriptExt.append(ds: Integer);
begin
  dataFactory.findDataSet(ds).append; 
end;

function TjavaScriptExt.connect: WordBool;
begin
  try
    dataFactory.connect;
    result := true;
  except
    result := false;
    raise;
  end;
end;

function TjavaScriptExt.createDataSet: Integer;
begin
  result := dataFactory.createDataSet;
end;

procedure TjavaScriptExt.disconnet;
begin
  dataFactory.disConnect;
end;

procedure TjavaScriptExt.edit(ds: Integer);
begin
  dataFactory.findDataSet(ds).Edit; 
end;

function TjavaScriptExt.eof(ds: Integer): WordBool;
begin
  result := dataFactory.findDataSet(ds).Eof; 
end;

procedure TjavaScriptExt.eraseDataSet(ds: Integer);
begin
  dataFactory.eraseDataSet(ds); 
end;

procedure TjavaScriptExt.first(ds: Integer);
begin
  dataFactory.findDataSet(ds).first;
end;

function TjavaScriptExt.getAsDouble(ds: Integer;
  const fieldname: WideString): Double;
begin
  result := dataFactory.findDataSet(ds).FieldByName(fieldname).AsFloat;
end;

function TjavaScriptExt.getAsValue(ds: Integer;
  const fieldname: WideString): OleVariant;
begin
  result := dataFactory.findDataSet(ds).FieldByName(fieldname).AsVariant;
end;

function TjavaScriptExt.getAsInteger(ds: Integer;
  const fieldname: WideString): Integer;
begin
  result := dataFactory.findDataSet(ds).FieldByName(fieldname).AsInteger;
end;

function TjavaScriptExt.getAsString(ds: Integer;
  const fieldname: WideString): WideString;
begin
  result := dataFactory.findDataSet(ds).FieldByName(fieldname).AsString;
end;

procedure TjavaScriptExt.last(ds: Integer);
begin
  dataFactory.findDataSet(ds).Last;
end;

function TjavaScriptExt.locate(ds: Integer; const fieldname: WideString;
  value: OleVariant): WordBool;
begin
  result := dataFactory.findDataSet(ds).Locate(fieldname,value,[]);
end;

procedure TjavaScriptExt.next(ds: Integer);
begin
  dataFactory.findDataSet(ds).Next;
end;

procedure TjavaScriptExt.open(ds: Integer; const ns: WideString; const Params: WideString);
var
  rs:TZQuery;
  prms:TftParamList;
begin
  if not dataFactory.signined then Raise Exception.Create('没有登录认证，您不能使用此功能');
  prms:=TftParamList.Create;
  try
    TftParamList.DecodeJson(prms,params);
    rs := dataFactory.findDataSet(ds);
    if ns<>'' then
      dataFactory.Open(rs,ns,prms)
    else
      begin
        rs.Params.Assign(prms);
        dataFactory.Open(rs);
      end;
  finally
    prms.Free;
  end;
end;

procedure TjavaScriptExt.post(ds: Integer);
begin
  dataFactory.findDataSet(ds).Post;
end;

procedure TjavaScriptExt.prior(ds: Integer);
begin
  dataFactory.findDataSet(ds).Prior;
end;

procedure TjavaScriptExt.setAsDouble(ds: Integer;
  const fieldname: WideString; value: Double);
begin
  dataFactory.findDataSet(ds).FieldByName(fieldname).AsFloat := value;
end;

procedure TjavaScriptExt.setAsValue(ds: Integer;
  const fieldname: WideString; value: OleVariant);
begin
  dataFactory.findDataSet(ds).FieldByName(fieldname).AsVariant := value;
end;

procedure TjavaScriptExt.setAsInteger(ds: Integer;
  const fieldname: WideString; value: Integer);
begin
  dataFactory.findDataSet(ds).FieldByName(fieldname).AsInteger := value;
end;

procedure TjavaScriptExt.setAsString(ds: Integer; const fieldname,
  value: WideString);
begin
  dataFactory.findDataSet(ds).FieldByName(fieldname).AsString := value;
end;

procedure TjavaScriptExt.setSQL(ds: Integer; const SQL: WideString);
begin
  dataFactory.findDataSet(ds).SQL.Text := SQL;
end;

function TjavaScriptExt.getLastError: WideString;
begin
  result := lastError;
end;

procedure TjavaScriptExt.addbatch(ds: Integer; const ns: WideString; const params: WideString);
var
  rs:TZQuery;
  prms:TftParamList;
begin
  prms:=TftParamList.Create;
  try
    TftParamList.DecodeJson(prms,params);
    rs := dataFactory.findDataSet(ds);
    dataFactory.AddBatch(rs,ns,prms);
  finally
    prms.free;
  end;
end;

procedure TjavaScriptExt.beginbatch;
begin
  dataFactory.BeginBatch;
end;

procedure TjavaScriptExt.cancelBatch;
begin
  dataFactory.CancelBatch;
end;

procedure TjavaScriptExt.commitBatch;
begin
  if not dataFactory.signined then Raise Exception.Create('没有登录认证，您不能使用此功能');
  dataFactory.CommitBatch;
end;

function TjavaScriptExt.execSQL(const SQL: WideString): Integer;
begin
  if not dataFactory.signined then Raise Exception.Create('没有登录认证，您不能使用此功能');
  result := dataFactory.ExecSQL(SQL); 
end;

function TjavaScriptExt.iDbType: Integer;
begin
  result := dataFactory.iDbType;
end;

procedure TjavaScriptExt.moveToSqlite;
begin
  dataFactory.MoveToSqlite;
end;

procedure TjavaScriptExt.moveToRemote;
begin
  dataFactory.MoveToRemote;
  dataFactory.connect;
end;

procedure TjavaScriptExt.openBatch;
begin
  if not dataFactory.signined then Raise Exception.Create('没有登录认证，您不能使用此功能');
  dataFactory.OpenBatch;
end;

procedure TjavaScriptExt.updatebatch(ds: Integer; const ns: WideString; const Params: WideString);
var
  rs:TZQuery;
  prms:TftParamList;
begin
  if not dataFactory.signined then Raise Exception.Create('没有登录认证，您不能使用此功能');
  prms:=TftParamList.Create;
  try
    TftParamList.DecodeJson(prms,params);
    rs := dataFactory.findDataSet(ds);
    dataFactory.UpdateBatch(rs,ns,prms);
  finally
    prms.Free;
  end;
end;

function TjavaScriptExt.getUserInfo: WideString;
begin
  result := token.encodeJson;
end;

function TjavaScriptExt.getLocalJson(const doMain: WideString): WideString;
var
  F:Textfile;
  s:string;
begin
  result := '';
  if not fileExists(ExtractFilePath(Application.ExeName)+'temp\'+doMain+'.dat') then exit;
  AssignFile(F,ExtractFilePath(Application.ExeName)+'temp\'+doMain+'.dat');
  reset(F);
  try
  while not system.eof(F) do
    begin
      readln(F,S);
      result := result + s;
    end;
  finally
    closefile(F);
  end;
end;

procedure TjavaScriptExt.setLocalJson(const doMain, json: WideString);
var
  F:TextFile;
  s:string;
begin
  AssignFile(F,ExtractFilePath(Application.ExeName)+'temp\'+doMain+'.dat');
  rewrite(F);
  try
    s := json;
    writeln(F,s);
  finally
    closefile(F);
  end;
end;

procedure TjavaScriptExt.moveToDefault;
begin
  dataFactory.MoveToDefault;
  if dataFactory.dbFlag=1 then dataFactory.connect;
end;

function TjavaScriptExt.parseSQL(const sql: WideString): WideString;
begin
  {==判断null函数替换处理==}
  case dataFactory.iDbType of
  0:begin
     result := stringreplace(SQL,'ifnull','isnull',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','isnull',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','isnull',[rfReplaceAll]);
     result := stringreplace(result,'nvl','isnull',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','isnull',[rfReplaceAll]);
     result := stringreplace(result,'NVL','isnull',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','isnull',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','isnull',[rfReplaceAll]);
    end;
  1:begin
     result := stringreplace(SQL,'ifnull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','nvl',[rfReplaceAll]);
     result := stringreplace(result,'isnull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','nvl',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','nvl',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','nvl',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','nvl',[rfReplaceAll]);
    end;
  4:begin
     result := stringreplace(SQL,'ifnull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IfNull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IFNULL','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'isnull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'nvl','coalesce',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','coalesce',[rfReplaceAll]);
    end;
  5:begin
     result := stringreplace(SQL,'nvl','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'NVL','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'Nvl','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'isnull','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'ISNULL','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'IsNull','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'coalesce','ifnull',[rfReplaceAll]);
     result := stringreplace(result,'Coalesce','ifnull',[rfReplaceAll]);
    end;
  end;
  {== 2011.02.25 Add字符函数substring与substr函数替换处理 [substring |substr| mid] ==}
  case iDbType of
   0,2: //Ms SQL Server | SYSBASE  [substring]
    begin
      result := stringreplace(result,'substr(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'SubStr(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTR(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'mid(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'Mid(','substring(',[rfReplaceAll]);
      result := stringreplace(result,'MID(','substring(',[rfReplaceAll]);
    end;
   3:  //ACCESS
    begin
      result := stringreplace(result,'substr(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SubStr(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTR(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'substring(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SubString(','mid(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTRING(','mid(',[rfReplaceAll]);
    end;
   1,4,5: //Oracle | DB2 | SQLITE
    begin
      result := stringreplace(result,'substring(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'SubString(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'SUBSTRING(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'mid(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'Mid(','substr(',[rfReplaceAll]);
      result := stringreplace(result,'MID(','substr(',[rfReplaceAll]);
    end;
  end;
  {==2011.02.25 Add字符长度函数len()与length函数替换处理 [len |length|char_length] ==}
  case iDbType of
   0,3: //Ms SQL Server | Access [substring]
    begin
      result := stringreplace(result,'length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'Length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'LENGTH(','len(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','len(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','len(',[rfReplaceAll]);
    end;
   2:  //SYSBASE [char_length] 字符长度（字节长度用：data_length）
    begin
      result := stringreplace(result,'length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'Length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'LENGTH(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','data_length(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','data_length(',[rfReplaceAll]);
    end;
   1,4,5: //Oracle | DB2 | SQLITE [length]  [Oracle字节长度:lengthb]
    begin
      result := stringreplace(result,'len(','length(',[rfReplaceAll]);
      result := stringreplace(result,'Len(','length(',[rfReplaceAll]);
      result := stringreplace(result,'LEN(','length(',[rfReplaceAll]);
      result := stringreplace(result,'char_length(','length(',[rfReplaceAll]);
      result := stringreplace(result,'Char_Length(','length(',[rfReplaceAll]);
      result := stringreplace(result,'CHAR_LENGTH(','length(',[rfReplaceAll]);
    end;
  end;    
end;

procedure TjavaScriptExt.SaveTimeStamp;
var
  LDate:TDatetime;
begin
  LDate := trunc(rspFactory.timestamp/86400.0+40542.0)+2;
  token.lDate := strtoint(formatDatetime('YYYYMMDD',LDate));
  dataFactory.MoveToSqlite;
  try
    if dataFactory.ExecSQL('update SYS_DEFINE set VALUE='''+formatDatetime('YYYYMMDD',LDate)+''' where TENANT_ID=0 and DEFINE=''NEAR_LOGIN_DATE''')=0 then
       dataFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,''NEAR_LOGIN_DATE'','''+formatDatetime('YYYYMMDD',LDate)+''',0,''00'',5497000)');
  finally
    dataFactory.MoveToDefault;
  end;
end;

procedure TjavaScriptExt.CheckTimeStamp;
function fnStrtoDate(Str: string): TDatetime;
var Y,M,D:Word;
begin
  try
  if Length(Str)=8 then
     begin
      Y := StrtoInt(Copy(Str,1,4));
      M := StrtoInt(Copy(Str,5,2));
      D := StrtoInt(Copy(Str,7,2));
     end
  else
     begin
      Y := StrtoInt(Copy(Str,1,4));
      M := StrtoInt(Copy(Str,6,2));
      D := StrtoInt(Copy(Str,9,2));
     end;
  Result := EnCodeDate(Y,M,D);
  except
     Raise Exception.CreateFmt('%s无效日期型字符串。',[Str]); 
  end;
end;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where  TENANT_ID=0 and DEFINE=''NEAR_LOGIN_DATE''';
    dataFactory.Open(rs);
    if rs.Fields[0].AsString='' then  Raise Exception.Create('首次登录不允许使用离线操作'); 
    if rs.Fields[0].AsString<>'' then
       begin
         if (date()-fnStrtoDate(rs.Fields[0].asString))>7 then
            Raise Exception.Create('您已经超过7天没上网了，不能再使用离线了')
         else
         if fnStrtoDate(rs.Fields[0].asString)>date() then
            Raise Exception.Create('你的计算机时间与服务器时间不符，请校准后再登录软件。');
       end;
  finally
    rs.Free;
  end;
end;

function TjavaScriptExt.signToken(const _token: WideString): WordBool;
var tenantId:integer;
function CheckRegister:boolean;
var
  rs:TZQuery;
begin
  dataFactory.MoveToSqlite;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=0 and DEFINE=''TENANT_ID''';
    dataFactory.Open(rs);
    result := (rs.Fields[0].AsString<>'');
    if result then tenantId := rs.Fields[0].asInteger;
  finally
    rs.Free;
  end;
end;
var
  rs,us:TZQuery;
  isXsm:boolean;
  username:string;
begin
  result := false;
  signOut;
  if not UcFactory.xsmLoginForToken(_token) then Raise Exception.Create('无效令牌，无法完成登录');
  if not CheckRegister then
     begin
       dataFactory.signined := true;
       token.shoped := false;
       token.tenantId := '';
       token.online := true;
       token.account := UcFactory.xsmUser;
       token.xsmCode := UcFactory.xsmUser;
       token.xsmPWD := '';
       token.userId := UcFactory.xsmUser;
       token.username := UcFactory.xsmUser;
       token.Logined := true;
       DllFactory.Inited := false;
       token.online := true;
       dataFactory.signined := true;
       result := true;
       Exit;
     end;
  //已经登录过了，用企业号订证一下，读取相关连接参数
  if rspFactory.xsmLogin(inttostr(tenantId),4) then
     begin
       dataFactory.MoveToDefault;
       dataFactory.connect;
     end else Raise Exception.Create('rsp认证失败了，当前企业没开通终端功能');
  username := UcFactory.xsmUser;
  //开始登录
  rs := TZQuery.Create(nil);
  us := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT,A.TENANT_ID,C.TENANT_NAME from VIW_USERS A,CA_SHOP_INFO B,CA_TENANT C '+
      'where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.COMM not in (''02'',''12'') and A.TENANT_ID=:TENANT_ID and A.ACCOUNT in ('''+username+''','''+lowercase(username)+''','''+uppercase(username)+''')';
    rs.ParamByName('TENANT_ID').AsInteger := tenantId;
    dataFactory.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('无效登录名.');
    isXsm := (rs.FieldByName('ROLE_IDS').AsString = 'xsm');
    if not ((rs.FieldByName('ACCOUNT').AsString = 'admin') or (rs.FieldByName('ACCOUNT').AsString = 'system') or isXsm) then
        begin
          us.SQL.Text := 'select DIMI_DATE,PASS_WRD from CA_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT='+QuotedStr(rs.FieldByName('ACCOUNT').AsString)+
          ' and A.TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' ';
          dataFactory.Open(us);
          if us.IsEmpty then Raise Exception.Create(username+'用户账号不存在,不能登录。');
          if (us.FieldbyName('DIMI_DATE').AsString<>'') and (us.FieldbyName('DIMI_DATE').AsString<=FormatDateTime('YYYY-MM-DD',Date())) then Raise Exception.Create(username+'用户账号已经离职,不能登录。');
        end;

    token.userId := rs.FieldbyName('USER_ID').AsString;
    token.account := rs.FieldbyName('ACCOUNT').AsString;
    token.tenantId := rs.FieldbyName('TENANT_ID').AsString;
    token.tenantName := rs.FieldbyName('TENANT_NAME').AsString;
    token.shopId := rs.FieldbyName('SHOP_ID').AsString;
    token.shopName := rs.FieldbyName('SHOP_NAME').AsString;
    token.username := rs.FieldbyName('USER_NAME').AsString;
    rs.Close;
    rs.SQL.Text := 'select XSM_CODE,XSM_PSWD,ADDRESS,LICENSE_CODE,LINKMAN,TELEPHONE from CA_SHOP_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    dataFactory.Open(rs);
    token.address := rs.FieldbyName('ADDRESS').AsString;
    token.xsmCode := rs.FieldbyName('XSM_CODE').AsString;
    token.xsmPWD := rs.FieldbyName('XSM_PSWD').AsString;
    token.licenseCode := rs.FieldbyName('LICENSE_CODE').AsString;
    token.legal := rs.FieldbyName('LINKMAN').AsString;
    token.mobile := rs.FieldbyName('TELEPHONE').AsString;
    if true then SaveTimeStamp else checkTimeStamp;
    token.Logined := true;
    DllFactory.Inited := false;
    token.online := true;
    dataFactory.signined := true;
    PostMessage(frmBrowerForm.Handle,WM_UPGRADE_CHECK,0,0);
  finally
    us.Free;
    rs.Free;
  end;
  result := true;
end;

function TjavaScriptExt.getIniInfo(const FileName, Section, ParamName,
  DefaultValue: WideString): WideString;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+FileName);
  try
    result := F.ReadString(Section,ParamName,DefaultValue);
  finally
    F.Free;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TjavaScriptExt, Class_javaScriptExt, ciMultiInstance, tmApartment);
end.
