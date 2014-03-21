unit uDLLFactory;

interface

uses Classes,SysUtils,windows,forms,urlParser,ZIntf,ZDataSet,ZBase,Variants;

type
  //1.��ʼ��Ӧ��
  //˵��������appId�����ƣ���ʼ���ɹ��󷵻�true
  TinitApp=function(app:TApplication;scr:TScreen;hWnd:THandle;_dbHelp:IdbDllHelp;token:pchar):boolean;stdcall;
  //2.��Ӧ��
  //˵������Ӧ����ָ����ģ��
  TopenApp=function(hWnd:Thandle;moduId:pchar):boolean;stdcall;
  //3.�ر�Ӧ��
  //˵�����ر�Ӧ���д򿪵�ģ��
  //����ֵ:false��������رգ�true�رճɹ�
  TcloseApp=function(moduId:pchar):boolean;stdcall;
  //4.�ͷ���Դ
  TeraseApp=function(synced:boolean):boolean;stdcall;
  //5.��ȡ����˵��
  TgetLastError=function():pchar;stdcall;
  //6.��ȡģ������
  TgetModuleName=function(moduId:pchar):Pchar;stdcall;
  //7.��ȡ����˵��
  Tresize=function():boolean;stdcall;
  //8.��ȡ����˵��
  TsendMsg=function(buf:Pchar;moduId:pchar):boolean;stdcall;
  //9.��ȡ����
  TgetToken=function():pchar;stdcall;

  TDLLPlugin=class
  private
    FDLLHandle: THandle;
    initApp:TinitApp;
    openApp:TopenApp;
    closeApp:TcloseApp;
    eraseApp:TeraseApp;
    getLastError:TgetLastError;
    getModuleName:TgetModuleName;
    resize:Tresize;
    sendMsg:TsendMsg;
    _getToken:TgetToken;
    FappId: string;
    procedure SetDLLHandle(const Value: THandle);
    procedure SetappId(const Value: string);
  public
    constructor Create(dllname:string);
    destructor Destroy; override;
    procedure Init;
    function getToken:string;
    property DLLHandle:THandle read FDLLHandle write SetDLLHandle;
    property appId:string read FappId write SetappId;
  end;

  TDLLFactory=class(TComponent,IdbDllHelp)
  private
    FList:TList;
    FDataSets:TList;
    FappWnd: THandle;
    lastError:string;
    FInited: boolean;
    FisBusy: boolean;
    procedure SetappWnd(const Value: THandle);
    procedure SetInited(const Value: boolean);
    procedure SetisBusy(const Value: boolean);
  protected
    //��ʼ����  ��ʱ���� ��λ��
    procedure BeginTrans(TimeOut:integer=-1);stdcall;
    //�ύ����
    procedure CommitTrans;stdcall;
    //�ع�����
    procedure RollbackTrans;stdcall;
    //�Ƿ��Ѿ��������� True ��������
    function  InTransaction:boolean;stdcall;
    //�õ����ݿ����� 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;stdcall;
    //HRESULT ����ֵ˵�� =0��ʾִ�гɹ� ����Ϊ�������
    function OpenSQL(SQL:WideString;Params:WideString):OleVariant;OverLoad;stdcall;
    function OpenNS(NS:WideString;Params:WideString):OleVariant;OverLoad;stdcall;
    //�ύ���ݼ�
    function UpdateBatch(ds:OleVariant;NS:WideString;Params:WideString):boolean;OverLoad;stdcall;
    //����ִ��Ӱ���¼��
    function ExecSQL(const SQL:WideString):Integer;stdcall;
    procedure BeginBatch; stdcall;
    procedure AddBatch(ds:OleVariant;const ns: WideString; const Params: WideString); stdcall;
    function OpenBatch:OleVariant; stdcall;
    procedure CommitBatch; stdcall;
    procedure CancelBatch; stdcall;
    procedure MoveToDefault; stdcall;
    function getLastError:pchar; stdcall;
    //ִ��Զ�̷�ʽ�����ؽ��
    function ExecProc(NS:String;Params:WideString):pchar;stdcall;
    function DBLock(locked:boolean):boolean;stdcall;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Init(hWnd:THandle);
    procedure Clear(synced:boolean);

    //��ȡ������Ϣ
    function getTokenInfo:boolean;
    //url �������� rspcn://appid/moduid
    function open(urltoken:TurlToken;hWnd:THandle):boolean;
    function close(urltoken:TurlToken):boolean;
    function getTitle(urltoken:TurlToken):string;

    procedure send(urltoken: TurlToken;msg:string);

    function erase(idx:integer):boolean;
    function find(appId:string):integer;

    function getToken:string;

    procedure resize;
    function getDBHelp:IdbDLLHelp;
    property appWnd:THandle read FappWnd write SetappWnd;
    property Inited:boolean read FInited write SetInited;
    property isBusy:boolean read FisBusy write SetisBusy;
  end;

var dllFactory:TDLLFactory;

implementation

uses udataFactory,utokenFactory,EncDec;


procedure TDLLFactory.AddBatch(ds: OleVariant; const ns, Params: WideString);
var
  rs:TZQuery;
begin
  try
    rs := TZQuery.Create(nil);
    rs.Delta := ds;
    if Params<>'' then
       TftParamList.Decode(rs.Params,Params);
    FDataSets.Add(rs);
    dataFactory.AddBatch(rs,ns,TftParamList(rs.Params));
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

procedure TDLLFactory.BeginBatch;
var
  i:integer;
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    dataFactory.BeginBatch;
    for i:=0 to FDataSets.Count-1 do
      begin
        TObject(FDataSets[i]).Free;
      end;
    FDataSets.Clear;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

procedure TDLLFactory.BeginTrans(TimeOut: integer);
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    dataFactory.BeginTrans(TimeOut);
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

procedure TDLLFactory.CancelBatch;
var
  i:integer;
begin
  try
    dataFactory.CancelBatch;
    for i:=0 to FDataSets.Count-1 do
      begin
        TObject(FDataSets[i]).Free;
      end;
    FDataSets.Clear;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

function TDLLFactory.close(urltoken:TurlToken): boolean;
var
  idx:integer;
  app:TDLLPlugin;
begin
  idx := find(urltoken.appId);
  if idx<0 then
     begin
      exit;
     end
  else
     app := TDLLPlugin(flist[idx]);
  try
    result := app.closeApp(Pchar(urlToken.moduname));
    if not result then Raise Exception.Create(StrPas(app.getLastError)); 
  except
    Raise Exception.Create(StrPas(app.getLastError));
  end;
end;

procedure TDLLFactory.CommitBatch;
var
  i:integer;
begin
  try
    dataFactory.CommitBatch;
    for i:=0 to FDataSets.Count-1 do
      begin
        TObject(FDataSets[i]).Free;
      end;
    FDataSets.Clear;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

procedure TDLLFactory.CommitTrans;
begin
  try
    dataFactory.CommitTrans;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

constructor TDLLFactory.Create;
begin
  FList:=TList.Create;
  FDataSets:=TList.Create;
  Inited := false;
end;

destructor TDLLFactory.Destroy;
var i:integer;
begin
  for i:=0 to FDataSets.Count-1 do
    begin
      TObject(FDataSets[i]).Free;
    end;
  FDataSets.Free;
  Clear(false);
  FList.Free;
  inherited;
end;

function TDLLFactory.erase(idx: integer): boolean;
begin
  TObject(Flist[idx]).Free;
  flist.Delete(idx); 
end;

function TDLLFactory.ExecSQL(const SQL: WideString): Integer;
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    result := dataFactory.ExecSQL(SQL);
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

function TDLLFactory.find(appId: string): integer;
var i:integer;
begin
  result := -1;
  for i:=0 to flist.Count-1 do
    begin
      if lowercase(TDLLPlugin(flist[i]).appId)=lowercase(appId) then
         begin
           result := i;
           exit;
         end;
    end;
end;

function TDLLFactory.getTitle(urltoken: TurlToken): string;
var
  idx:integer;
  app:TDLLPlugin;
  buf:Pchar;
begin
  idx := find(urltoken.appId);
  if idx<0 then
     begin
       Exit;
     end
  else
     app := TDLLPlugin(flist[idx]);
  buf := app.getModuleName(pchar(urlToken.moduname));
  if buf<>nil then
     result := strPas(buf) 
  else
     Raise Exception.Create(StrPas(app.getLastError)); 
end;

function TDLLFactory.iDbType: Integer;
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    result := dataFactory.iDbType;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

function TDLLFactory.InTransaction: boolean;
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    result := dataFactory.InTransaction;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

function TDLLFactory.open(urltoken:TurlToken;hWnd:THandle): boolean;
var
  idx:integer;
  app:TDLLPlugin;
begin
  if not Inited then Init(appWnd);
  try
    if not getTokenInfo then Exit;
    idx := find(urltoken.appId);
    if idx<0 then
       begin
         app := TDLLPlugin.Create(urltoken.path);
         app.appId := urltoken.appId;
         flist.Add(app);
         app.Init;
       end
    else
       app := TDLLPlugin(flist[idx]);
    result := app.openApp(hWnd,pchar(urlToken.moduname));
    if not result then MessageBox(application.MainForm.Handle,app.getLastError,'����..',MB_OK+MB_ICONERROR);
  except
    on E:Exception do
       begin
         result := false;
         MessageBox(application.MainForm.Handle,pchar(E.Message),'����..',MB_OK+MB_ICONERROR);
       end;
  end;
end;

function TDLLFactory.OpenSQL(SQL, Params: WideString): OleVariant;
var
  rs:TZQuery;
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := SQL;
      TftParamList.Decode(rs.Params,Params);
      dataFactory.Open(rs);
      result := rs.Data;
    finally
      rs.Free;
    end;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

function TDLLFactory.OpenBatch: OleVariant;
var
  i:integer;
begin
  try
    dataFactory.OpenBatch;
    result:=VarArrayCreate([0,FDataSets.Count-1],varVariant);
    for i:=0 to FDataSets.Count-1 do
      begin
        result[i] := TZQuery(FDataSets[i]).Data;
        TObject(FDataSets[i]).Free;
      end;
    FDataSets.Clear;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

function TDLLFactory.OpenNS(NS, Params: WideString): OleVariant;
var
  rs:TZQuery;
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    rs := TZQuery.Create(nil);
    try
      TftParamList.Decode(rs.Params,Params);
      dataFactory.Open(rs,ns,TftParamList(rs.Params));
      result := rs.Data;
    finally
      rs.Free;
    end;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

procedure TDLLFactory.RollbackTrans;
begin
  try
    dataFactory.RollbackTrans;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

function TDLLFactory.UpdateBatch(ds: OleVariant; NS, Params: WideString): boolean;
var
  rs:TZQuery;
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    rs := TZQuery.Create(nil);
    try
      rs.Delta := ds;
      TftParamList.Decode(rs.Params,Params);
      dataFactory.UpdateBatch(rs,ns,TftParamList(rs.Params));
    finally
      rs.Free;
    end;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

function TDLLFactory.getDBHelp: IdbDLLHelp;
begin
  if GetInterface(IdbDLLHelp,result) then
     result._AddRef
  else
     Raise Exception.Create('��ȡdll�ӿ�ʧ��');
end;

function TDLLFactory.ExecProc(NS: String; Params: WideString): pchar;
var
  prms:TftParamList;
begin
  try
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    prms := TftParamList.Create;
    try
      TftParamList.Decode(prms,Params);
      result := Pchar( dataFactory.ExecProc(NS,prms));
    finally
      prms.Free;
    end;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

procedure TDLLFactory.resize;
var
  i:integer;
begin
  for i:=0 to FList.Count -1 do
    begin
      TDLLPlugin(FList[i]).resize;
    end;
end;

function TDLLFactory.getTokenInfo: boolean;
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
  rs:TZQuery;
begin
  if (token.tenantId='') and CheckRegister then
     begin
       rs := TZQuery.Create(nil);
       try
        rs.Close;
        rs.SQL.Text := 'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT,A.TENANT_ID,C.TENANT_NAME from VIW_USERS A,CA_SHOP_INFO B,CA_TENANT C '+
          'where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.COMM not in (''02'',''12'') and A.TENANT_ID=:TENANT_ID and A.ACCOUNT in (:ACCOUNT,:LOWER_ACCOUNT,:UPPER_ACCOUNT)';
        rs.ParamByName('TENANT_ID').AsInteger := tenantId;
        rs.ParamByName('ACCOUNT').AsString := token.account;
        rs.ParamByName('LOWER_ACCOUNT').AsString := lowerCase(token.account);
        rs.ParamByName('UPPER_ACCOUNT').AsString := upperCase(token.account);
        dataFactory.Open(rs);
        if rs.IsEmpty then Raise Exception.Create('��ȡ�û���Ϣʧ�ܣ������µ�¼...');
        token.userId := rs.FieldbyName('USER_ID').AsString;
        token.account := rs.FieldbyName('ACCOUNT').AsString;
        token.tenantId := rs.FieldbyName('TENANT_ID').AsString;
        token.tenantName := rs.FieldbyName('TENANT_NAME').AsString;
        token.shopId := rs.FieldbyName('SHOP_ID').AsString;
        token.shopName := rs.FieldbyName('SHOP_NAME').AsString;
        token.username := rs.FieldbyName('USER_NAME').AsString;
        token.roleIds := rs.FieldbyName('ROLE_IDS').AsString;
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
        token.Logined := true;
        token.online := true;
      finally
        rs.Free;
      end;
     end;
  result := true;
end;

procedure TDLLFactory.MoveToDefault;
begin
  try
    dataFactory.MoveToDefault;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

procedure TDLLFactory.send(urltoken: TurlToken;msg:string);
var
  idx:integer;
  app:TDLLPlugin;
begin
  idx := find(urltoken.appId);
  if idx<0 then
     begin
      exit;
     end
  else
     app := TDLLPlugin(flist[idx]);
  app.sendMsg(pchar(msg),Pchar(urlToken.moduname));
end;

procedure TDLLFactory.Init(hWnd:THandle);
var
  idx:integer;
  app:TDLLPlugin;
begin
  isBusy := true;
  try
  appWnd := hWnd;
  if not getTokenInfo then Exit;
  idx := find('shop.dll');
  if idx<0 then
     begin
       app := TDLLPlugin.Create('shop.dll');
       app.appId := 'shop.dll';
       flist.Add(app);
       app.Init;
     end
  else
     begin
       app := TDLLPlugin(flist[idx]);
       app.Init;
     end;
  Inited := true;
  finally
    isBusy := false;
  end;
end;

procedure TDLLFactory.SetappWnd(const Value: THandle);
begin
  FappWnd := Value;
end;

function TDLLFactory.getLastError: pchar;
begin
  result := pchar(lastError);
end;

procedure TDLLFactory.Clear(synced:boolean);
var i:integer;
begin
  isBusy := true;
  try
  for i:=FList.Count-1 downto 0 do
    begin
      if not TDLLPlugin(FList[i]).eraseApp(synced) then
         Raise Exception.Create(TDLLPlugin(FList[i]).getLastError);
      TObject(FList[i]).Free;
      FList.Delete(i); 
    end;
  Inited := false;
  FList.Clear;
  finally
    isBusy := false;
  end;
end;

function TDLLFactory.getToken: string;
var
  idx:integer;
  app:TDLLPlugin;
begin
  idx := find('shop.dll');
  if idx<0 then
     begin
       app := TDLLPlugin.Create('shop.dll');
       app.appId := 'shop.dll';
       flist.Add(app);
     end
  else
     begin
       app := TDLLPlugin(flist[idx]);
     end;
  result := app.getToken;
end;

procedure TDLLFactory.SetInited(const Value: boolean);
begin
  FInited := Value;
end;

procedure TDLLFactory.SetisBusy(const Value: boolean);
begin
  FisBusy := Value;
end;

function TDLLFactory.DBLock(locked: boolean): boolean;
begin
  try
    if not token.online then Exit;
    if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
    dataFactory.DBLock(locked);
    result := true;
  except
    on E:Exception do
       begin
         lastError := E.Message;
         raise;
       end;
  end;
end;

{ TDLLPlugin }

constructor TDLLPlugin.Create(dllname:string);
begin
  dllHandle := LoadLibrary(Pchar(extractFilePath(application.exename)+dllname));
  if dllHandle=0 then Raise Exception.Create('��Ч����ļ�'+dllname);
  try
    @initApp := GetProcAddress(dllHandle, 'initApp');
    if @initApp=nil then Raise Exception.Create('initApp����û��ʵ��');
    @openApp := GetProcAddress(dllHandle, 'openApp');
    if @openApp=nil then Raise Exception.Create('openApp����û��ʵ��');
    @closeApp := GetProcAddress(dllHandle, 'closeApp');
    if @closeApp=nil then Raise Exception.Create('closeApp����û��ʵ��');
    @eraseApp := GetProcAddress(dllHandle, 'eraseApp');
    if @eraseApp=nil then Raise Exception.Create('eraseApp����û��ʵ��');
    @getLastError := GetProcAddress(dllHandle, 'getLastError');
    if @getLastError=nil then Raise Exception.Create('getLastError����û��ʵ��');
    @getModuleName := GetProcAddress(dllHandle, 'getModuleName');
    if @getModuleName=nil then Raise Exception.Create('getModuleName����û��ʵ��');
    @resize := GetProcAddress(dllHandle, 'resize');
    if @resize=nil then Raise Exception.Create('resize����û��ʵ��');
    @sendMsg := GetProcAddress(dllHandle, 'sendMsg');
    if @sendMsg=nil then Raise Exception.Create('sendMsg����û��ʵ��');
    @_getToken := GetProcAddress(dllHandle, 'getToken');
    if @_getToken=nil then Raise Exception.Create('getToken����û��ʵ��');
  except
    freeLibrary(dllHandle);
    dllHandle := 0;
    raise;
  end;
end;

destructor TDLLPlugin.Destroy;
begin
  if dllHandle>0 then
     begin
       FreeLibrary(dllHandle);
     end;
  inherited;
end;

function TDLLPlugin.getToken: string;
var
  buf:pchar;
begin
  buf := _getToken;
  if buf=nil then Raise Exception.Create(StrPas(getLastError));
  result := StrPas(buf);
end;

procedure TDLLPlugin.Init;
begin
  if not initApp(Application,Screen,dllFactory.appWnd,dllFactory.getDBHelp,pchar(token.encode)) then Raise Exception.Create('��ʼ��'+appId+'Ӧ��ʧ��,����'+strPas(getLastError));
end;

procedure TDLLPlugin.SetappId(const Value: string);
begin
  FappId := Value;
end;

procedure TDLLPlugin.SetDLLHandle(const Value: THandle);
begin
  FDLLHandle := Value;
end;

end.
