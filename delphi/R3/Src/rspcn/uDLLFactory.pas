unit uDLLFactory;

interface
uses
  Classes,SysUtils,windows,forms,urlParser,ZIntf,ZDataSet,ZBase,Variants;
type
  //1.初始化应用
  //说明：传入appId与令牌，初始化成功后返回true
  TinitApp=function(appWnd:Thandle;_dbHelp:IdbDllHelp;token:pchar):boolean;stdcall;
  //2.打开应用
  //说明：打开应用中指定的模块
  TopenApp=function(hWnd:Thandle;moduId:pchar):boolean;stdcall;
  //3.关闭应用
  //说明：关闭应用中打开的模块
  //返回值:false代表不允许关闭，true关闭成功
  TcloseApp=function(moduId:pchar):boolean;stdcall;
  //4.释放资源
  TeraseApp=function():boolean;stdcall;
  //5.读取错误说明
  TgetLastError=function():pchar;stdcall;
  //6.读取模块名称
  TgetModuleName=function(moduId:pchar):Pchar;stdcall;
  //5.读取错误说明
  Tresize=function():boolean;stdcall;

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
    FappId: string;
    procedure SetDLLHandle(const Value: THandle);
    procedure SetappId(const Value: string);
  public
    constructor Create(dllname:string);
    destructor Destroy; override;

    property DLLHandle:THandle read FDLLHandle write SetDLLHandle;
    property appId:string read FappId write SetappId;
  end;
  TDLLFactory=class(TComponent,IdbDllHelp)
  private
    FList:TList;
    FDataSets:TList;
  protected
    //开始事务  超时设置 单位秒
    procedure BeginTrans(TimeOut:integer=-1);stdcall;
    //提交事务
    procedure CommitTrans;stdcall;
    //回滚事务
    procedure RollbackTrans;stdcall;
    //是否已经在事务中 True 在事务中
    function  InTransaction:boolean;stdcall;

    //得到数据库类型 0:SQL Server ;1 Oracle ; 2 Sybase; 3 ACCESS; 4 DB2;  5 Sqlite
    function  iDbType:Integer;stdcall;

    //HRESULT 返回值说明 =0表示执行成功 否则为错误代码
    function OpenSQL(SQL:WideString;Params:WideString):OleVariant;OverLoad;stdcall;
    function OpenNS(NS:WideString;Params:WideString):OleVariant;OverLoad;stdcall;
    //提交数据集
    function UpdateBatch(ds:OleVariant;NS:WideString;Params:WideString):boolean;OverLoad;stdcall;
    //返回执行影响记录数
    function ExecSQL(const SQL:WideString):Integer;stdcall;
    procedure BeginBatch; stdcall;
    procedure AddBatch(ds:OleVariant;const ns: WideString; const Params: WideString); stdcall;
    function OpenBatch:OleVariant; stdcall;
    procedure CommitBatch; stdcall;
    procedure CancelBatch; stdcall;

    //执行远程方式，返回结果
    function ExecProc(NS:String;Params:WideString):pchar;stdcall;

  public
    constructor Create;
    destructor Destroy; override;
    //url 命名规则 rspcn://appid/moduid
    function open(urltoken:TurlToken;hWnd:THandle):boolean;
    function close(urltoken:TurlToken):boolean;
    function getTitle(urltoken:TurlToken):string;

    function erase(idx:integer):boolean;
    function find(appId:string):integer;

    procedure resize;
    function getDBHelp:IdbDLLHelp;
  end;
var
  dllFactory:TDLLFactory;
implementation
uses udataFactory,utokenFactory;

{ TDLLFactory }

procedure TDLLFactory.AddBatch(ds: OleVariant; const ns,
  Params: WideString);
var
  rs:TZQuery;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  rs := TZQuery.Create(nil);
  rs.Delta := ds;
  if Params<>'' then
     TftParamList.Decode(rs.Params,Params);
  FDataSets.Add(rs);
  dataFactory.AddBatch(rs,ns,TftParamList(rs.Params));
end;

procedure TDLLFactory.BeginBatch;
var
  i:integer;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  dataFactory.BeginBatch;
  for i:=0 to FDataSets.Count-1 do
    begin
      TObject(FDataSets[i]).Free;
    end;
  FDataSets.Clear;
end;

procedure TDLLFactory.BeginTrans(TimeOut: integer);
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  dataFactory.BeginTrans(TimeOut);
end;

procedure TDLLFactory.CancelBatch;
var
  i:integer;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  for i:=0 to FDataSets.Count-1 do
    begin
      TObject(FDataSets[i]).Free;
    end;
  FDataSets.Clear;
  dataFactory.CancelBatch;
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
  app.closeApp(Pchar(urlToken.moduname));
end;

procedure TDLLFactory.CommitBatch;
var
  i:integer;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  dataFactory.CommitBatch;
  for i:=0 to FDataSets.Count-1 do
    begin
      TObject(FDataSets[i]).Free;
    end;
  FDataSets.Clear;
end;

procedure TDLLFactory.CommitTrans;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  dataFactory.CommitTrans;
end;

constructor TDLLFactory.Create;
begin
  FList:=TList.Create;
  FDataSets:=TList.Create;
end;

destructor TDLLFactory.Destroy;
var i:integer;
begin
  for i:=0 to FList.Count-1 do
    begin
      TObject(FList[i]).Free;
    end;
  FList.Free;
  for i:=0 to FDataSets.Count-1 do
    begin
      TObject(FDataSets[i]).Free;
    end;
  FDataSets.Free;
  inherited;
end;

function TDLLFactory.erase(idx: integer): boolean;
begin
  TObject(Flist[idx]).Free;
  flist.Delete(idx); 
end;

function TDLLFactory.ExecSQL(const SQL: WideString): Integer;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  result := dataFactory.ExecSQL(SQL); 
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
     result := strPas(buf) else result := '未知...';
end;

function TDLLFactory.iDbType: Integer;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  result := dataFactory.iDbType;
end;

function TDLLFactory.InTransaction: boolean;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  result := dataFactory.InTransaction;
end;

function TDLLFactory.open(urltoken:TurlToken;hWnd:THandle): boolean;
var
  idx:integer;
  app:TDLLPlugin;
begin
  idx := find(urltoken.appId);
  if idx<0 then
     begin
       app := TDLLPlugin.Create(urltoken.path);
       app.appId := urltoken.appId;
       flist.Add(app);
     end
  else
     app := TDLLPlugin(flist[idx]);
  result := app.openApp(hWnd,pchar(urlToken.moduname));
end;

function TDLLFactory.OpenSQL(SQL, Params: WideString): OleVariant;
var
  rs:TZQuery;
begin
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
end;

function TDLLFactory.OpenBatch: OleVariant;
var
  i:integer;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  dataFactory.OpenBatch;
  result:=VarArrayCreate([0,FList.Count-1],varVariant);
  for i:=0 to FDataSets.Count-1 do
    begin
      result[i] := TZQuery(FDataSets[i]).Data;
      TObject(FDataSets[i]).Free;
    end;
  FDataSets.Clear;
end;

function TDLLFactory.OpenNS(NS, Params: WideString): OleVariant;
var
  rs:TZQuery;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  rs := TZQuery.Create(nil);
  try
    TftParamList.Decode(rs.Params,Params);
    dataFactory.Open(rs,ns,TftParamList(rs.Params));
    result := rs.Data;
  finally
    rs.Free;
  end;
end;

procedure TDLLFactory.RollbackTrans;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  dataFactory.RollbackTrans;
end;

function TDLLFactory.UpdateBatch(ds: OleVariant; NS,
  Params: WideString): boolean;
var
  rs:TZQuery;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  rs := TZQuery.Create(nil);
  try
    rs.Delta := ds;
    TftParamList.Decode(rs.Params,Params);
    dataFactory.UpdateBatch(rs,ns,TftParamList(rs.Params));  
  finally
    rs.Free;
  end;
end;

function TDLLFactory.getDBHelp: IdbDLLHelp;
begin
  if GetInterface(IdbDLLHelp,result) then
     result._AddRef
  else
     Raise Exception.Create('读取dll接口失败');
end;

function TDLLFactory.ExecProc(NS: String; Params: WideString): pchar;
var
  prms:TftParamList;
begin
  if dataFactory.dbFlag=0 then dataFactory.MoveToRemote;
  prms := TftParamList.Create;
  try
    TftParamList.Decode(prms,Params);
    result := Pchar( dataFactory.ExecProc(NS,prms));
  finally
    prms.Free;
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

{ TDLLPlugin }

constructor TDLLPlugin.Create(dllname:string);
begin
  dllHandle := LoadLibrary(Pchar(extractFilePath(application.exename)+dllname));
  if dllHandle=0 then Raise Exception.Create('无效插件文件'+dllname);
  try
    @initApp := GetProcAddress(dllHandle, 'initApp');
    if @initApp=nil then Raise Exception.Create('initApp方法没有实现');
    @openApp := GetProcAddress(dllHandle, 'openApp');
    if @openApp=nil then Raise Exception.Create('openApp方法没有实现');
    @closeApp := GetProcAddress(dllHandle, 'closeApp');
    if @closeApp=nil then Raise Exception.Create('closeApp方法没有实现');
    @eraseApp := GetProcAddress(dllHandle, 'eraseApp');
    if @eraseApp=nil then Raise Exception.Create('eraseApp方法没有实现');
    @getLastError := GetProcAddress(dllHandle, 'getLastError');
    if @getLastError=nil then Raise Exception.Create('getLastError方法没有实现');
    @getModuleName := GetProcAddress(dllHandle, 'getModuleName');
    if @getModuleName=nil then Raise Exception.Create('getModuleName方法没有实现');
    @resize := GetProcAddress(dllHandle, 'resize');
    if @resize=nil then Raise Exception.Create('resize方法没有实现');
    if not initApp(Application.Handle,dllFactory.getDBHelp,pchar(token.encode)) then Raise Exception.Create('初始化'+dllname+'应用失败');
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
       eraseApp;
       FreeLibrary(dllHandle);
     end;
  inherited;
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
