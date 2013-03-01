unit udllGlobal;

interface

uses
  SysUtils, Classes, ZDataSet;

type
  TdllGlobal = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function GetZQueryFromName(Name:string):TZQuery;
    //按条码检索商品
    function GetGodsFromBarcode(ds:TZQuery;barcode:string):boolean;
    function GetGodsFromGodsCode(ds:TZQuery;godsCode:string):boolean;

    function GetVersionFlag:integer;
  end;

var
  dllGlobal: TdllGlobal;

implementation
uses utokenFactory,udataFactory,iniFiles;
{$R *.dfm}

{ TdllGlobal }

function TdllGlobal.GetGodsFromBarcode(ds: TZQuery;
  barcode: string): boolean;
begin

end;

function TdllGlobal.GetGodsFromGodsCode(ds: TZQuery;
  godsCode: string): boolean;
begin

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

initialization
  dllGlobal := TdllGlobal.Create(nil);
finalization
  dllGlobal.Free;
end.
