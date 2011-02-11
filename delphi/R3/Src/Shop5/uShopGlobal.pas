unit uShopGlobal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uGlobal, DB, ZdbFactory, Registry, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

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
  private
    Fokline: boolean;
    FLimit: integer;
    Foffline: boolean;
    procedure SetLimit(const Value: integer);
    procedure Setokline(const Value: boolean);
    procedure Setoffline(const Value: boolean);
    { Private declarations }
  protected
    function GetSysDate: TDate;override;
  public
    { Public declarations }
    function GetChkRight(id:string;userid:string=''):boolean;

    procedure LoadRight;
    //1.操作日志 2.数据日志
    procedure WriteLogInfo(LogType:integer;ModId:string;LogName:string;LogInfo:string);
    //检测网络
    function CheckNetwork:boolean;
    //检测数据库主机
    function CheckHostLocal: boolean;
    function GetVersionFlag:integer;

    function GetParameter(ParamName:string):string;
    procedure SetParameter(ParamName:string;Value:string);
    property Limit:integer read FLimit write SetLimit;
    //是否网络在线应用
    property okline:boolean read Fokline write Setokline;
    // 1是离线, 0 是联机
    property offline:boolean read Foffline write Setoffline;
  end;

const
  SysID:TGUID='{149C2F30-9066-48A6-8CFC-0EDD7F6DFE54}';
var
  ShopGlobal: TShopGlobal;
  //数据库版本 DB5.0.0.3
  DBVersion:string;
  //软件版本  .ALL 分销版 .NET 连锁版 .LCL 单机版  .OLE 在线版 
  SFVersion:string;
  //行业版本 1.FIG 服装版 2.MKT 超市版  3.OHR 标准版  4.DLI 食品业
  CLVersion:string;
  //产品编码
  ProductID:string;
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
              B := FormatDatetime('YYYY-MM-DD',Date()-1)
           else
              B := FormatDatetime('YYYY-MM-DD',FnTime.fnStrtoDate(Temp.Fields[0].AsString)-1);
        end
     else
        B := Temp.Fields[0].AsString;
     if B<formatDatetime('YYYY-MM-DD',inherited GetSysDate) then
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

function TShopGlobal.GetChkRight(id: string;userid:string=''): boolean;
var
  uid:string;
  rs,us:TZQuery;
  myRoles:string;
begin
  result := false;
  if userid='' then uid := Global.UserID else uid := userid;
  if uid = 'admin' then
     begin
       result := true;
       Exit;
     end;
  if uid=Global.UserID then
     begin
       if not CA_RIGHTS.Active then Exit;
       if CA_RIGHTS.Locate('MID',id,[]) then
          result := (CA_RIGHTS.FieldByName('CHK').AsInteger > 0);
     end
  else
     begin
       Exit;
       rs := TZQuery.Create(nil);
       try
         us := Global.GeTZQueryFromName('CA_USERS');
         if not us.Locate('USER_ID',uid,[]) then Raise Exception.Create('无效用户名...');
         myRoles := us.FieldbyName('DUTY_IDS').AsString;
         case Factor.iDbType of
         0:rs.SQL.Text :=
           'select j.MID,IsNull(b.CHK,j.CHK) as CHK from '+
           '(select MID,sum(CHK) as CHK from CA_RIGHTS where UID in ('''+stringReplace(myRoles,',',''',''',[rfReplaceAll])+''') and UTYPE=0 and MID='''+id+''' and TENANT_ID='+inttostr(TENANT_ID)+' group by MID ) j '+
           'left outer join '+
           '(select MID,sum(CHK) as CHK from CA_RIGHTS where UID = '''+uid+''' and COMP_ID=''----'' and UTYPE=1 and MID='''+id+''' group by MID ) b on j.MID=b.MID';
         3:rs.SQL.Text :=
           'select j.MID,iif(IsNull(b.CHK),0,j.CHK) as CHK from '+
           '(select MID,sum(CHK) as CHK from CA_RIGHTS where UID in ('''+stringReplace(myRoles,',',''',''',[rfReplaceAll])+''') and UTYPE=0 and MID='''+id+''' and TENANT_ID='+inttostr(TENANT_ID)+' group by MID ) j '+
           'left outer join '+
           '(select MID,sum(CHK) as CHK from CA_RIGHTS where UID = '''+uid+''' and COMP_ID=''----'' and UTYPE=1 and MID='''+id+''' group by MID ) b on j.MID=b.MID';
         end;
         Factor.Open(rs);
         result := (rs.Fields[1].AsInteger > 0)
       finally
         rs.free;
       end;
     end;
end;

procedure TShopGlobal.LoadRight;
var Roles:string;
begin
  Exit;
{  if not CA_USERS.Locate('USER_ID',UserId,[]) then Raise Exception.Create('无效用户名...');
  Roles := CA_USERS.FieldbyName('DUTY_IDS').AsString; 
  CA_RIGHTS.Close;
  case Factor.iDbType of
  0:CA_RIGHTS.SQL.Text :=
    'select j.MID,IsNull(b.CHK,j.CHK) as CHK from '+
    '(select MID,sum(CHK) as CHK from CA_RIGHTS where UID in ('''+stringReplace(Roles,',',''',''',[rfReplaceAll])+''') and UTYPE=0 and COMP_ID='''+Global.CompanyID+''' group by MID ) j '+
    'left outer join '+
    '(select MID,sum(CHK) as CHK from CA_RIGHTS where UID = '''+Global.UserID+''' and COMP_ID=''----'' and UTYPE=1 group by MID ) b on j.MID=b.MID';
  3:CA_RIGHTS.SQL.Text :=
    'select j.MID,iif(IsNull(b.CHK),j.CHK,b.CHK) as CHK from '+
    '(select MID,sum(CHK) as CHK from CA_RIGHTS where UID in ('''+stringReplace(Roles,',',''',''',[rfReplaceAll])+''') and UTYPE=0 and COMP_ID='''+Global.CompanyID+''' group by MID ) j '+
    'left outer join '+
    '(select MID,sum(CHK) as CHK from CA_RIGHTS where UID = '''+Global.UserID+''' and COMP_ID=''----'' and UTYPE=1 group by MID ) b on j.MID=b.MID';
  end;
  Factor.Open(CA_RIGHTS);  }
end;

procedure TShopGlobal.Setoffline(const Value: boolean);
begin
  Foffline := Value;
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

initialization
finalization
end.
