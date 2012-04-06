unit uVerificationFactory;

interface
uses
  Windows,SysUtils,Dialogs, classes;
type
  PString =^String;
  TVerFunction_KeyExists=function(keytype:integer):integer;stdcall;
  TVerFunction_VerifyPin=function(keytype:integer;userpin:Pchar):integer;stdcall;
  TVerFunction_IngaIDGetOid=function(idfile:Pchar;pwd:Pchar;oidn:integer;oiddata:Pchar):integer;stdcall;
  TVerFunction_Data=function(keytype:integer;userpin:Pchar;digesttype:integer;
                             data:Pchar;datalen:integer;
                             signeddata:Pchar;ignedlen:integer;
                             pemprvkey:Pchar):integer;stdcall;
  TVerificationFactory =class
  private
    FMMID: string;
    FPermitID: string;
    FClientID: string;
    FVerData: string;
    bUseKey: boolean;
    procedure LoadVerFactory;
    procedure FreeVerFactory;
    procedure SetClientID(const Value: string);
    procedure SetMMID(const Value: string);
    procedure SetPermitID(const Value: string);
    procedure SetVerData(const Value: string);

public
    function GetClientID: string;
    function GetMMID: string;
    function GetPermitID: string;
  protected
    VerHandle:THandle;
    VerKeyExists:TVerFunction_KeyExists;
    VerVerifyPin:TVerFunction_VerifyPin;
    VerIngaIDGetOid:TVerFunction_IngaIDGetOid;
    VerRSAPrvSign:TVerFunction_Data;
    VerRSAPubVfy:TVerFunction_Data;
    function GetVerDetailInfo: boolean;
    function GetConifgValue:boolean;
  public
    constructor Create;
    destructor Destroy;override;
    function GetKeyExists:boolean;
    function GetUserExists:boolean;
    property VerData:string read FVerData write SetVerData;
    property MMID:string read GetMMID write SetMMID;
    property PermitID:string read GetPermitID write SetPermitID;
    property ClientID:string read GetClientID write SetClientID;
  end;
var VerificationFactory:TVerificationFactory;

implementation
uses ZDataSet, ZBase,uGlobal,ZLogFile,IniFiles;
{ TVerificationFactory }

constructor TVerificationFactory.Create;
begin
   //LoadVerFactory;
   VerHandle:=0;
   bUseKey := true;
   FMMID := '';
   FPermitID := '';
   FClientID:= '';
end;

destructor TVerificationFactory.Destroy;
begin
  FreeVerFactory;
  inherited;
end;

function TVerificationFactory.GetKeyExists: boolean;
var iRet:Integer;
begin
  if (not bUseKey) or (not GetConifgValue) then
  begin
    result :=true;
    exit;
  end;
  result :=false;
  try
    if VerHandle=0 then LoadVerFactory;
    iRet :=VerKeyExists(6);
    if iRet = 0 then    result :=true;//GetVerDetailInfo;
    LogFile.AddLogFile(0,'<Verification> VerKeyExists='+inttostr(iRet));
  finally
  end;
end;
function TVerificationFactory.GetUserExists: boolean;
var
  Temp:TZQuery;
begin
  if (not bUseKey) or (not GetConifgValue) then
  begin
    result :=true;
    exit;
  end;
  if not GetVerDetailInfo then
  begin
    result :=false;
    exit;
  end;
  result:= false;
  Temp := TZQuery.Create(nil);
  try
    Temp.Close;
    Temp.SQL.Text := 'select XSM_CODE,LICENSE_CODE from CA_SHOP_INFO where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='''+Global.SHOP_ID+'''';
    Global.LocalFactory.Open(Temp);
    if Temp.Fields[0].asString<>'' then
       begin
         //ShowMessage('XSM_CODE='+Temp.Fields[0].AsString
         //   +',LICENSE_CODE='+Temp.Fields[1].AsString);
         if (Temp.Fields[0].AsString = FMMID)
             and (Temp.Fields[1].AsString=FPermitID) then   result := true;
         //coLogin(Temp.Fields[0].AsString,DecStr(Temp.Fields[1].AsString,ENC_KEY));
         //result := false;
       end
    else
       Raise Exception.Create('当前登录门店没有新商盟账号...');
  finally
    Temp.Free;
  end;
end;

procedure TVerificationFactory.FreeVerFactory;
begin
   FreeLibrary(VerHandle);
end;



function TVerificationFactory.GetClientID: string;
begin
  result := FClientID;
end;

function TVerificationFactory.GetVerDetailInfo: boolean;
var iRet:Integer;
    vRet:Pchar;
    sRet:String;
    strs :TStrings;
    i:Integer;
begin
  result :=false;
  vRet :=' ';
  try
    iRet :=VerVerifyPin(6,'12345678');
    SetLength(sRet,1024);
    vRet :=pchar(sRet);
    if iRet = 0 then
    begin
       iRet :=VerIngaIDGetOid('CKEY','',50,vRet);
       //if vRet = nil then ShowMessage('11111');
       if iRet = 0 then
       begin
          //result :=true;
          //ShowMessage('VerIngaIDGetOid返回'+StrPas(vRet));
          //sRet := 'TESTCUSTB27,450200103645,qwerewrt';
          LogFile.AddLogFile(0,'<Verification> ='+sRet);
          iRet := Pos(',',sRet) ;
          if (iRet >0) then
          begin
              //ShowMessage('iRet='+inttostr(iRet));
              result :=true;
              strs := TStringList.Create;
              strs.CommaText := sRet;
              try
                 for i := 0 to Strs.Count-1 do
                  begin
                    //ShowMessage(Strs[i]);
                    case i of
                      0:FMMID := Strs[i];
                      1:FPermitID := Strs[i];
                      2:FClientID:= Strs[i];
                    end;
                  end;
                  LogFile.AddLogFile(0,'<Verification> ID='+FClientID);
              finally
                strs.Free;
              end;

          end;
       end
       else
       begin
          //ShowMessage('VerIngaIDGetOid返回'+inttostr(iRet));
          Raise Exception.Create('身份验证信息未初始化');
       end;
    end
    else
    begin
       //ShowMessage('VerVerifyPin返回'+inttostr(iRet));
       Raise Exception.Create('身份验证失败');
    end;
  except
  end;
end;

procedure TVerificationFactory.LoadVerFactory;
begin
  VerHandle := LoadLibrary(Pchar({ExtractFilePath(ParamStr(0))+C:\WINDOWS\system32\}'sysec.dll'));
  if VerHandle=0 then
  begin
   Raise Exception.Create('未检测到身份验证插件包');
   Exit;
  end;
  @VerKeyExists := GetProcAddress(VerHandle, Pchar('iKeyLib_KeyExists'));
  if @VerKeyExists=nil then Raise Exception.Create('无效身份验证插件包，没有实现iKeyLib_KeyExists方法');
  @VerVerifyPin := GetProcAddress(VerHandle, Pchar('iKeyLib_VerifyPin'));
  if @VerVerifyPin=nil then Raise Exception.Create('无效身份验证插件包，没有实现iKeyLib_VerifyPin方法');
  @VerIngaIDGetOid := GetProcAddress(VerHandle, Pchar('IngaIDGetOid'));
  if @VerIngaIDGetOid=nil then Raise Exception.Create('无效身份验证插件包，没有实现IngaIDGetOid方法');
end;
procedure TVerificationFactory.SetClientID(const Value: string);
begin
  FClientID := Value;
end;

function TVerificationFactory.GetConifgValue: boolean;
var
  F:TIniFile;
begin
  result := true;
  if not FileExists(ExtractFilePath(ParamStr(0))+'r3.cfg') then   exit;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
     result := F.ReadBool('soft','KeyUsed',false);
  finally
    try
      F.Free;
    except
    end;
  end;
end;


function TVerificationFactory.GetMMID: string;
begin
  result := FMMID;
end;

function TVerificationFactory.GetPermitID: string;
begin
  result := FPermitID;
end;

procedure TVerificationFactory.SetMMID(const Value: string);
begin
  FMMID := Value;
end;

procedure TVerificationFactory.SetPermitID(const Value: string);
begin
  FPermitID := Value;
end;

procedure TVerificationFactory.SetVerData(const Value: string);
begin
  FVerData := Value;
end;

initialization
  VerificationFactory := TVerificationFactory.Create;
finalization
  VerificationFactory.Free;

end.

