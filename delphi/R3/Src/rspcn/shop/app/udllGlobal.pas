unit udllGlobal;

interface

uses
  SysUtils, Classes, ZDataSet, DB, ZAbstractRODataset, ZAbstractDataset;

type
  TdllGlobal = class(TDataModule)
    CA_TENANT: TZQuery;
    CA_SHOP_INFO: TZQuery;
    SYS_DEFINE: TZQuery;
    CA_USERS: TZQuery;
    PUB_CUSTOMER: TZQuery;
    PUB_CLIENTINFO: TZQuery;
    PUB_GOODSINFO: TZQuery;
    PUB_MEAUNITS: TZQuery;
    PUB_PARAMS: TZQuery;
    PUB_PRICEGRADE: TZQuery;
    CA_RELATIONS: TZQuery;
  private
    { Private declarations }
    procedure OpenPubGoodsInfo;
  public
    { Public declarations }
    function GetZQueryFromName(Name:string):TZQuery;
    function OpenSqlite(DataSet:TZQuery):boolean;
    //按条码检索商品
    function GetGodsFromBarcode(ds:TZQuery;barcode:string):boolean;
    function GetGodsFromGodsCode(ds:TZQuery;godsCode:string):boolean;
    function getMyDeptId:string;
    function GetChkRight(MID: string; SequNo: integer=1; userid:string=''):boolean;

    function GetVersionFlag:integer;
    function sysDate:TDatetime;
    function GetParameter(paramname:string):string;
    //得到供应链企业 in ();
    function GetTenantId:string;

  end;

var
  dllGlobal: TdllGlobal;

implementation
uses utokenFactory,udataFactory,iniFiles;
{$R *.dfm}

{ TdllGlobal }

function TdllGlobal.GetChkRight(MID: string; SequNo: integer;
  userid: string): boolean;
begin
  result := true;
end;

function TdllGlobal.GetGodsFromBarcode(ds: TZQuery;
  barcode: string): boolean;
begin

end;

function TdllGlobal.GetGodsFromGodsCode(ds: TZQuery;
  godsCode: string): boolean;
begin

end;

function TdllGlobal.getMyDeptId: string;
begin

end;

function TdllGlobal.GetParameter(paramname: string): string;
begin

end;

function TdllGlobal.GetTenantId: string;
var
  rs:TZQuery;
begin
  rs := GetZQueryFromName('CA_RELATIONS');
  result := '''+token.tenantId+''';
  rs.first;
  while not rs.eof do
    begin
      result := result + ','''+rs.FieldbyName('TENANT_ID').asString+'''';
      rs.next;
    end;
end;

function TdllGlobal.GetVersionFlag: integer;
var
  f:TIniFile;
  CLVersion:string;
begin
  f := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    CLVersion := f.ReadString('soft','CLVersion','.MKT');
  finally
    F.Free;
  end;
  if CLVersion='.FIG' then //服装版
     result := 1
  else
  if CLVersion='.MKT' then //中小超市版
     result := 2
  else
  if CLVersion='.DLI' then //食品业
     result := 4
  else
  if CLVersion='.TGS' then //食杂店-小型夫妻店精简版
     result := 5
  else
     result := 3          //默认
end;

function TdllGlobal.GetZQueryFromName(Name: string): TZQuery;
var
  i:Integer;
begin
  Result := nil;
  for i:=0 to ComponentCount -1 do
    begin
       if UpperCase(TComponent(Components[i]).Name) = UpperCase(Name) then
          begin
            Result := TZQuery(Components[i]);
            break;
          end;
    end;
  if Result = nil then Raise Exception.CreateFmt('%s数据表没找到。',[Name]);
  if not Result.Active then
     begin
       if TZQuery(Result).Params.FindParam('SHOP_ID')<>nil then
          TZQuery(Result).Params.FindParam('SHOP_ID').AsString := token.shopId;
       if TZQuery(Result).Params.FindParam('SHOP_ID_ROOT')<>nil then
          TZQuery(Result).Params.FindParam('SHOP_ID_ROOT').AsString := token.tenantId+'0001';
       if TZQuery(Result).Params.FindParam('TENANT_ID')<>nil then
          TZQuery(Result).Params.FindParam('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
       if TZQuery(Result).Params.FindParam('USER_ID')<>nil then
          TZQuery(Result).Params.FindParam('USER_ID').AsString := token.userId;
       if Trim(TZQuery(Result).SQL.Text) = '' then Exit;
       dataFactory.MoveToSqlite;
       try
         dataFactory.Open(Result);
       finally
         dataFactory.MoveToDefault;
       end;
     end;
  if Result.Filtered then Result.Filtered := false;
  Result.OnFilterRecord := nil;
  Result.CommitUpdates;
end;

procedure TdllGlobal.OpenPubGoodsInfo;
begin
  dataFactory.MoveToSqlite;
  try
    PUB_GOODSINFO.SQL.Text :=
      '';
    dataFactory.Open(PUB_GOODSINFO);
  finally
    dataFactory.MoveToDefault;
  end;
end;

function TdllGlobal.OpenSqlite(DataSet: TZQuery): boolean;
begin
  dataFactory.MoveToSqlite;
  try
    dataFactory.Open(DataSet); 
  finally
    dataFactory.MoveToDefault;
  end;
end;

function TdllGlobal.sysDate: TDatetime;
begin
  result := date();
end;

initialization
  dllGlobal := TdllGlobal.Create(nil);
finalization
  dllGlobal.Free;
end.
