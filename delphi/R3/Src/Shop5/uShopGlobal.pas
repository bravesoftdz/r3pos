unit uShopGlobal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uGlobal, DB, ZdbFactory, Registry, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ZBase;

type
  TShopGlobal = class(TGlobal)
    SYS_DEFINE: TZQuery;
    CA_RIGHTS: TZQuery;
    CA_USERS: TZQuery;
    CA_SHOP_INFO: TZQuery;
    CA_DUTY_INFO: TZQuery;
    CA_ROLE_INFO: TZQuery;
    CA_TENANT: TZQuery;
    PUB_REGION_INFO: TZQuery;
    PUB_PAYMENT: TZQuery;
    PUB_GOODSINFO: TZQuery;
    PUB_CLIENTINFO: TZQuery;
    PUB_CUSTOMER: TZQuery;
    PUB_MEAUNITS: TZQuery;
    PUB_PARAMS: TZQuery;
    CA_DEPT_INFO: TZQuery;
    PUB_BRAND_INFO: TZQuery;
    PUB_GOODSSORT: TZQuery;
    PUB_CATE_INFO: TZQuery;
    PUB_IMPT_INFO: TZQuery;
    PUB_COLOR_GROUP: TZQuery;
    PUB_SIZE_GROUP: TZQuery;
    PUB_AREA_INFO: TZQuery;
    PUB_COLOR_INFO: TZQuery;
    PUB_SIZE_INFO: TZQuery;
    PUB_BARCODE: TZQuery;
    PUB_IDNTYPE_INFO: TZQuery;
    PUB_SALE_STYLE: TZQuery;
    PUB_BANK_INFO: TZQuery;
    PUB_CLIENTSORT: TZQuery;
    PUB_PRICEGRADE: TZQuery;
    ACC_ACCOUNT_INFO: TZQuery;
    ACC_ITEM_INFO: TZQuery;
    PUB_MONTH_PAY_INFO: TZQuery;
    PUB_DEGREES_INFO: TZQuery;
    PUB_OCCUPATION_INFO: TZQuery;
    PUB_SHOP_TYPE: TZQuery;
    PUB_SETTLE_CODE: TZQuery;
    STO_CHANGECODE: TZQuery;
    PUB_SUPPERSORT: TZQuery;
    PUB_STAT_INFO: TZQuery;
  private
    Fokline: boolean;
    FLimit: integer;
    procedure SetLimit(const Value: integer);
    procedure Setokline(const Value: boolean);
    function Getoffline: boolean;
    function GetNetVersion: boolean;
    { Private declarations }
  protected
    function GetSysDate: TDate;override;
  public
    { Public declarations }
    function GetOperRight(CdsRight: TDataSet; SEQUNo: integer; Filter:string=''): Boolean;
    function GetChkRight(MID: string; SequNo: integer=1; userid:string=''):boolean; overload;

    procedure LoadRight;
    //1.操作日志 2.数据日志
    procedure WriteLogInfo(LogType:integer;ModId:string;LogName:string;LogInfo:string);
    //检测网络
    function CheckNetwork:boolean;
    //检测数据库主机
    function CheckHostLocal: boolean;
    function GetVersionFlag:integer;

    //刷新最近同步时间
    procedure SyncTimeStamp;
    function GetParameter(ParamName:string):string;
    procedure SetParameter(ParamName:string;Value:string);
    property Limit:integer read FLimit write SetLimit;
    //是否网络在线应用
    property okline:boolean read Fokline write Setokline;
    // 1是离线, 0 是联机
    property offline:boolean read Getoffline;
    //判断是否连锁版
    property NetVersion:boolean read GetNetVersion;

  end;

const
  SysID:TGUID='{149C2F30-9066-48A6-8CFC-0EDD7F6DFE54}';
var
  ShopGlobal: TShopGlobal;
implementation
uses uFnUtil;
{$R *.dfm}

{ TShopGlobal }
function TShopGlobal.GetParameter(ParamName: string): string;
begin
  if not SYS_DEFINE.Active then Factor.Open(SYS_DEFINE); 
  if SYS_DEFINE.Locate('DEFINE',ParamName,[]) then
     Result := SYS_DEFINE.FieldbyName('VALUE').AsString
  else
     Result := '';
end;

function TShopGlobal.GetSysDate: TDate;
var
  Temp:TZQuery;
  B:string;
begin
  Temp := TZQuery.Create(nil);
  try
     Temp.SQL.Text :=
         'select max(PRINT_DATE) from ('+
         'select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID='+inttostr(TENANT_ID)+' and SHOP_ID='''+SHOP_ID+''' ) j';
     Factor.Open(Temp);
     if Temp.Fields[0].AsString = '' then
        begin
           Temp.close;
           Temp.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID='+inttostr(TENANT_ID)+' and DEFINE=''USING_DATE''';
           Factor.Open(Temp);
           if Temp.IsEmpty then
              B := FormatDatetime('YYYYMMDD',Date()-1)
           else
              B := FormatDatetime('YYYYMMDD',FnTime.fnStrtoDate(Temp.Fields[0].AsString)-1);
        end
     else
        B := Temp.Fields[0].AsString;
     if FnTime.fnStrtoDate(B)<(inherited GetSysDate) then
        result := inherited GetSysDate
     else
        result := FnTime.fnStrtoDate(B)+1;
  finally
     Temp.Free;
  end;
end;

procedure TShopGlobal.SetLimit(const Value: integer);
begin
  FLimit := Value;       
end;

procedure TShopGlobal.Setokline(const Value: boolean);
begin
  Fokline := Value;
end;

procedure TShopGlobal.LoadRight;
var
  Str:string;
begin
//  if not CA_USERS.Locate('USER_ID',UserId,[]) then Raise Exception.Create('无效用户名...');
//  Roles := Global.Roles;
  Str:=
    'select j.* from ('+
    'select MODU_ID,R.ROLE_ID,CHK from CA_RIGHTS R,CA_ROLE_INFO B where R.ROLE_TYPE=1 and R.TENANT_ID=B.TENANT_ID and '+
    ' R.ROLE_ID=B.ROLE_ID and R.TENANT_ID=:TENANT_ID and R.COMM not in (''02'',''12'') and B.ROLE_ID in ('''+stringReplace(Roles,',',''',''',[rfReplaceAll])+''') '+
    ' union all '+
    ' select MODU_ID,ROLE_ID,CHK from CA_RIGHTS where ROLE_TYPE=0 and TENANT_ID=:TENANT_ID and ROLE_ID=:USER_ID and COMM not in (''02'',''12'') ) j';
  CA_RIGHTS.Close;
  CA_RIGHTS.SQL.Text:=Str;
  if CA_RIGHTS.Params.FindParam('TENANT_ID')<>nil then
    CA_RIGHTS.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
  if CA_RIGHTS.Params.FindParam('USER_ID')<>nil then
    CA_RIGHTS.ParamByName('USER_ID').AsString:=Global.UserID;
  Factor.Open(CA_RIGHTS);
end;

function TShopGlobal.CheckHostLocal: boolean;
var
  rs:TZQuery;
  s:string;
  d:dword;
begin
  result := false;
  if Factor.iDbType = 0 then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select HOST_NAME() ';
         Factor.Open(rs);
         d := 255;
         SetLength(s,d);
         GetComputerName(pchar(s),d);
         SetLength(s,d);
         result := (uppercase(s)=uppercase(rs.Fields[0].AsString));
       finally
         rs.Free;
       end;
     end;
end;

function TShopGlobal.GetVersionFlag: integer;
begin
  if CLVersion='FIG' then
     result := 1
  else
  if CLVersion='MKT' then
     result := 2
  else
  if CLVersion='DLI' then
     result := 4
  else
     result := 3
end;

procedure TShopGlobal.WriteLogInfo(LogType: integer; ModId, LogName,
  LogInfo: string);
begin
//  Factor.ExecSQL(
//    'insert into SYS_LOG_INFO(LOG_ID,USER_ID,LOG_TYPE,MODU_ID,LOG_NAME,LOG_INFO,CREA_DATE,CREA_TIME,COMM,TIME_STAMP) '+
//    'values(newid(),'''+UserId+''','''+inttostr(LogType)+''','''+ModId+''','+QuotedStr(LogName)+','+QuotedStr(LogInfo)+','''+formatDatetime('YYYY-MM-DD',date())+''','''+formatDatetime('HH:NN:SS',now())+''',''00'','+GetTimeStamp(Factor.iDbType)+')');
end;

procedure TShopGlobal.SetParameter(ParamName, Value: string);
begin

end;

function TShopGlobal.CheckNetwork: boolean;
begin
  result := true;
end;

function TShopGlobal.GetChkRight(MID: string; SequNo: integer=1;
  userid: string=''): boolean;
var
  rs,us:TZQuery;
  CHK_Value: integer;
  uid,myRoles:string;
begin
  result := false;
  CHK_Value:=0;
  if userid='' then uid := Global.UserID else uid := userid;
  if (uid = 'admin') or (uid='administrator') then
  begin
    result := true;
    Exit;
  end;
  if uid=Global.UserID then
  begin
    if not CA_RIGHTS.Active then Exit;
    result:=GetOperRight(CA_RIGHTS,SEQUNo,'MODU_ID='''+MID+''''); //返回判断
  end else
  begin
    rs := TZQuery.Create(nil);
    try
       us := Global.GeTZQueryFromName('CA_USERS');
       if not us.Locate('USER_ID',uid,[]) then Raise Exception.Create('无效用户名...');
       myRoles := us.FieldbyName('DUTY_IDS').AsString;
       rs.Close;
       rs.SQL.Text:='(select distinct MODU_ID,R.ROLE_ID as ROLE_ID,CHK from CA_RIGHTS R,CA_ROLE_INFO B where MODU_ID='''+MID+''' and R.ROLE_TYPE=1 and R.TENANT_ID=B.TENANT_ID and R.ROLE_ID=B.ROLE_ID and '+
         ' R.TENANT_ID=:TENANT_ID and B.ROLE_ID in ('''+stringReplace(myRoles,',',''',''',[rfReplaceAll])+''')) '+
         ' union all '+
         ' (select distinct MODU_ID,ROLE_ID,CHK from CA_RIGHTS where ROLE_TYPE=0 and MODU_ID='''+MID+''' and TENANT_ID=:TENANT_ID and ROLE_ID=:USER_ID) ';
       if rs.Params.FindParam('TENANT_ID')<>nil then
         rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
       if rs.Params.FindParam('USER_ID')<>nil then
         rs.ParamByName('USER_ID').AsString:=uid;
       Factor.Open(rs);
       if (rs.Active) and (not rs.IsEmpty) then
       result:=GetOperRight(rs,SEQUNo,''); //返回判断
     finally
       rs.free;
     end;
   end;
end;

function TShopGlobal.GetOperRight(CdsRight: TDataSet; SEQUNo: integer;
  Filter: string): Boolean;
var CHK_Value: integer;
begin
  if not CdsRight.Active then Exit;
  try
    CHK_Value:=0;
    if Filter<>'' then //CA_RIGHTS.Filter 过滤的记录
    begin
      CdsRight.Filtered:=False;
      CdsRight.Filter:=Filter;
      CdsRight.Filtered:=true;
    end;
    CdsRight.First;
    while not CdsRight.Eof do
    begin
      CHK_Value:=(CdsRight.fieldbyName('CHK').AsInteger or CHK_Value); //不同角色进行 OR 运算
      CdsRight.Next;
    end;
    //对应位进行 and 预算，返回是否有权限
    result:=(CHK_Value and (1 shl (SEQUNo-1)))<>0;
  finally
    CdsRight.Filtered:=False;
    CdsRight.Filter:='';
  end;
end;

function TShopGlobal.Getoffline: boolean;
begin
  result := (Factor=LocalFactory);
end;

function TShopGlobal.GetNetVersion: boolean;
begin
  result := (SFVersion='.NET');
end;

procedure TShopGlobal.SyncTimeStamp;
var
  Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := TENANT_ID;
    if not ShopGlobal.offline then LocalFactory.ExecProc('TGetSyncTimeStamp',Params); 
    Factor.ExecProc('TGetSyncTimeStamp',Params);
  finally
    Params.free;
  end;
end;

initialization
finalization
end.
