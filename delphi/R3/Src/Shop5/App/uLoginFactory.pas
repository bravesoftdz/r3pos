unit uLoginFactory;

interface
uses SysUtils, Classes, Windows,Registry, Winsock, NB30, ZBase;
type
  TLoginFactory=class
  private
    FId: string;
    //登录计时
    LStart:Int64;
    function GetSystemInfo:string;
    function GetComputerName:string;
    function GetMacAddr:string;
    function GetIpAddr:string;
    procedure SetId(const Value: string);
  protected
    function UpdateDbVersion:boolean;
  public
    function ConnectTo():boolean;

    procedure Login(uid,sid:string);
    procedure Logout;
    procedure OpenModule(mId:string);

    property Id:string read FId write SetId;
  end;
var
  LoginFactory:TLoginFactory;
implementation
uses uGlobal,uFnUtil,uDsUtil,uCaFactory,ObjCommon,udbUtil,ufrmDbUpgrade;
{ TLoginFactory }

function TLoginFactory.ConnectTo(): boolean;
var
  Factory:TCreateDbFactory;
begin
  result := false;
  Global.MoveToLocal;
  Global.Connect;
  if not UpdateDbVersion then
     begin
       result := false;
       Exit;
     end;
end;

function TLoginFactory.GetComputerName: string;
var
  s: array [0..MAX_COMPUTERNAME_LENGTH] of Char;
  w:dword;
begin
  w := MAX_COMPUTERNAME_LENGTH+1;
  Windows.GetComputerName(s,w);
  result := string(s);
end;

function TLoginFactory.GetIpAddr: string;
var
  WSAData: TWSAData;
  HostEnt: PHostEnt;
  s: string;
  size: Cardinal;
begin
  result := '';
  s := GetComputerName;
  //获取IP地址
  WSAStartup(2, WSAData);
  HostEnt := GetHostByName(PChar(s));
  if HostEnt <> nil then
  begin
    with HostEnt^ do
      result := Format('%d.%d.%d.%d', [Byte(h_addr^[0]), Byte(h_addr^[1]),
        Byte(h_addr^[2]), Byte(h_addr^[3])]);
  end;
  WSACleanup;
end;

function TLoginFactory.GetMacAddr: string;
var
  NCB: TNCB;
  ADAPTER: TADAPTERSTATUS;
  LANAENUM: TLANAENUM;
  intIdx: Integer;
  cRC: Char;
  strTemp: string;
  Index:integer;
begin
  Index := 0;
  Result := '';
  try
    // Zero control blocl
    ZeroMemory(@NCB, SizeOf(NCB));

    // Issue enum command
    NCB.ncb_command := Chr(NCBENUM);
    cRC := NetBios(@NCB);

    // Reissue enum command
    NCB.ncb_buffer := @LANAENUM;
    NCB.ncb_length := SizeOf(LANAENUM);
    cRC := NetBios(@NCB);
    if Ord(cRC) <> 0 then exit;

    // Reset adapter
    ZeroMemory(@NCB, SizeOf(NCB));
    NCB.ncb_command := Chr(NCBRESET);
    NCB.ncb_lana_num := LANAENUM.lana[index];
    cRC := NetBios(@NCB);
    if Ord(cRC) <> 0 then exit;

    // Get adapter address
    ZeroMemory(@NCB, SizeOf(NCB));
    NCB.ncb_command := Chr(NCBASTAT);
    NCB.ncb_lana_num := LANAENUM.lana[index];
    StrPCopy(NCB.ncb_callname, '*');
    NCB.ncb_buffer := @ADAPTER;
    NCB.ncb_length := SizeOf(ADAPTER);
    cRC := NetBios(@NCB);

    // Convert it to string
    strTemp := '';
    for intIdx := 0 to 5 do
      strTemp := strTemp + InttoHex(Integer(ADAPTER.adapter_address[intIdx]), 2);
    Result := strTemp;
  finally
  end;
end;

function TLoginFactory.GetSystemInfo: string;
var Reg:TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey:=HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion',false) then
    begin
      result:=Reg.ReadString('ProductName');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TLoginFactory.Login(uid,sid:string);
var
  SQL,flag,ConnectTo:string;
  vList:TStringList;
begin
  LStart := GetTickCount;
  Id := TSequence.NewId;
  if CaFactory.Audited then flag := '1' else flag := '2';
  vList := TStringList.Create;
  try
    vList.Delimiter := ';';
    vList.QuoteChar := '"';
    vList.DelimitedText := Global.RemoteFactory.ConnString;
    ConnectTo := vList.Values['hostname']+':'+vList.Values['port']+'<'+vList.Values['dbid']+'>';
  finally
    vList.Free;
  end;
  Global.SHOP_ID := sid;
  SQL :=
    'insert into CA_LOGIN_INFO(LOGIN_ID,TENANT_ID,SHOP_ID,USER_ID,IP_ADDR,COMPUTER_NAME,MAC_ADDR,SYSTEM_INFO,PRODUCT_ID,NETWORK_STATUS,CONNECT_TO,LOGIN_DATE,CONNECT_TIMES,COMM,TIME_STAMP) '+
    'values('''+Id+''','+inttostr(Global.TENANT_ID)+','''+sid+''','''+uid+''','''+GetIPAddr+''','''+GetComputerName+''','''+GetMacAddr+''','''+GetSystemInfo+''','''+ProductId+''','''+flag+''','''+ConnectTo+''','''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',-1,''00'','+GetTimeStamp(uGlobal.Factor.iDbType)+')';
  uGlobal.Factor.ExecSQL(SQL);
end;

procedure TLoginFactory.Logout;
begin
  if id='' then Exit;
  uGlobal.Factor.ExecSQL('update CA_LOGIN_INFO set LOGOUT_DATE='''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',CONNECT_TIMES='+inttostr((GetTickCount-LStart) div 60000)+',COMM='+GetCommStr(uGlobal.Factor.iDbType)+',TIME_STAMP='+GetTimeStamp(uGlobal.Factor.iDbType)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and LOGIN_ID='''+id+'''');
  id := '';
end;

procedure TLoginFactory.OpenModule(mId: string);
var SQL:string;
begin
  if id='' then Exit;
  SQL :=
    'insert into CA_MODULE_CLICK(ROWS_ID,LOGIN_ID,TENANT_ID,USER_ID,MODU_ID,CLICK_DATE,COMM,TIME_STAMP) '+
    'values('''+TSequence.NewId+''','''+Id+''','+inttostr(Global.TENANT_ID)+','''+Global.UserID+''','''+mId+''','''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',''00'','+GetTimeStamp(uGlobal.Factor.iDbType)+')';
  uGlobal.Factor.ExecSQL(SQL);
end;

procedure TLoginFactory.SetId(const Value: string);
begin
  FId := Value;
end;

function TLoginFactory.UpdateDbVersion: boolean;
var
  Factory:TCreateDbFactory;
begin
  result := true;
  Factory := TCreateDbFactory.Create;
  try
    if Factory.CheckVersion(DBVersion,Global.LocalFactory) then
       result := TfrmDbUpgrade.DbUpgrade(Factory,Global.LocalFactory);
  finally
    Factory.Free;
  end;
end;

initialization
  LoginFactory := TLoginFactory.Create;
finalization
  LoginFactory.Free;
end.
