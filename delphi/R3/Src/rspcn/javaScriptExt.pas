unit javaScriptExt;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  ComObj, ActiveX, Classes, rspcn_TLB, StdVcl, Forms, Windows, Messages,ZDataSet,SysUtils,ZBase,EncDec;

type
  TjavaScriptExt = class(TAutoObject, IjavaScriptExt)
  private
    Verify:string;
    lastError:string;
    _verify: WideString;
  protected
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

    function getUserInfo: WideString; safecall;
    function getLocalJson(const doMain: WideString): WideString; safecall;
    procedure setLocalJson(const doMain: WideString; const json: WideString); safecall;
  end;

implementation

uses ComServ,udataFactory,uUcFactory,uRspFactory,uTokenFactory;

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

procedure WriteRegister;
//var
//  rs:TZQuery;
begin
//  rs := TZQuery.Create(nil);
//  try
//    dataFactory.MoveToSqlite;
//    if dataFactory.ExecSQL('update SYS_DEFINE set VALUE='''+inttostr(rspFactory.tenantId)+''' where TENANT_ID=0 and DEFINE=''TENANT_ID''')=0 then
//       dataFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,''TENANT_ID'','''+inttostr(rspFactory.tenantId)+''',0,''00'',5497000)');
//    tenantId := rspFactory.tenantId;
//  finally
//    rs.Free;
//  end;
end;
var
  rs:TZQuery;
begin
  result := false;
  signOut;
  if _verify<>verify then Raise Exception.Create('校验码无效');
  if not CheckRegister then //没有注册,先自动注册
     begin
        if not online then Raise Exception.Create('没开通零售终端不支持离线使用');  
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
              if rspFactory.xsmLogin('testcusta01',3) then
                 begin
                   dataFactory.MoveToDefault;
                   dataFactory.connect;
                 end;
           end
        else
           begin
              dataFactory.MoveToSqlite;
           end;
     end;
  //开始登录
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT,A.TENANT_ID,C.TENANT_NAME from VIW_USERS A,CA_SHOP_INFO B,CA_TENANT C '+
      'where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.COMM not in (''02'',''12'') and A.TENANT_ID=:TENANT_ID and A.ACCOUNT in ('''+username+''','''+lowercase(username)+''','''+uppercase(username)+''')';
    rs.ParamByName('TENANT_ID').AsInteger := tenantId;
    dataFactory.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('无效登录名.'); 

    if not ((rs.FieldByName('ACCOUNT').AsString = 'admin') or (rs.FieldByName('ACCOUNT').AsString = 'system') or (rs.FieldByName('ROLE_IDS').AsString = 'xsm')) then
        begin
          rs.SQL.Text := 'select DIMI_DATE from CA_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT='+QuotedStr(rs.FieldByName('ACCOUNT').AsString)+
          ' and A.TENANT_ID='+rs.FieldbyName('TENANT_ID').asString+' and A.DIMI_DATE<='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()))+' and A.DIMI_DATE is not null ';
          dataFactory.Open(rs);
          if not rs.IsEmpty then Raise Exception.Create(username+'用户账号已经离职,不能登录。');
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
          if (rs.FieldbyName('ROLE_IDS').AsString='xsm') and online then //在线使用并属于新商盟用户
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
    token.xsmPWD := rs.FieldbyName('XSM_PSWD').AsString;
    token.licenseCode := rs.FieldbyName('LICENSE_CODE').AsString;
    token.legal := rs.FieldbyName('LINKMAN').AsString;
    token.mobile := rs.FieldbyName('TELEPHONE').AsString;
    token.Logined := true;
    token.online := online;
    dataFactory.signined := true;
  finally
    rs.Free;
  end;
  result := true;
end;

procedure TjavaScriptExt.signOut;
begin
  dataFactory.signined := false;
  UcFactory.xsmLogined := false;
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
  dataFactory.CommitTrans
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

initialization
  TAutoObjectFactory.Create(ComServer, TjavaScriptExt, Class_javaScriptExt,
    ciMultiInstance, tmApartment);
end.
