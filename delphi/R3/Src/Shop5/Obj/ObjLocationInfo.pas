unit ObjLocationInfo;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TLocation=class(TZFactory)
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

{ TLocation }

function TLocation.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from STO_GOODS_LOCATION where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and'+
    ' LOCATION_ID=:LOCATION_ID and AMOUNT<>0 ';
    rs.ParamByName('LOCATION_ID').AsString := FieldbyName('LOCATION_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);

    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('LOCATION_NAME').AsOldString+'"已经在商品资料中使用不能删除.');
  finally
    rs.Free;
  end;

  result := true;
end;

function TLocation.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_LOCATION_INFO where LOCATION_NAME=:LOCATION_NAME and COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('LOCATION_NAME').AsString := FieldbyName('LOCATION_NAME').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);

    if rs.Fields[0].AsInteger >0 then Raise Exception.Create('"'+FieldbyName('LOCATION_NAME').AsString+'"储位名称不能重复设置');
  finally
    rs.Free;
  end;
end;

function TLocation.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_LOCATION_INFO where LOCATION_NAME=:LOCATION_NAME and LOCATION_ID<>:OLD_LOCATION_ID and COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('LOCATION_NAME').AsString := FieldbyName('LOCATION_NAME').AsString;
    rs.ParamByName('OLD_LOCATION_ID').AsString := FieldbyName('LOCATION_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);

    if rs.Fields[0].AsInteger >0 then Raise Exception.Create('"'+FieldbyName('LOCATION_NAME').AsString+'"储位名称不能重复设置');
  finally
    rs.Free;
  end;
end;

procedure TLocation.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select TENANT_ID,SHOP_ID,LOCATION_ID,LOCATION_NAME,LOCATION_SPELL,REMARK,COMM,TIME_STAMP from PUB_LOCATION_INFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and LOCATION_ID=:LOCATION_ID';
  IsSQLUpdate := True;
  Str := 'insert into PUB_LOCATION_INFO(TENANT_ID,SHOP_ID,LOCATION_ID,LOCATION_NAME,LOCATION_SPELL,REMARK,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:LOCATION_ID,:LOCATION_NAME,:LOCATION_SPELL,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_LOCATION_INFO set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,LOCATION_ID=:LOCATION_ID,LOCATION_NAME=:LOCATION_NAME,LOCATION_SPELL=:LOCATION_SPELL,REMARK=:REMARK,' +
  'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where LOCATION_ID=:OLD_LOCATION_ID and TENANT_ID = :OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'update PUB_LOCATION_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where LOCATION_ID=:OLD_LOCATION_ID and TENANT_ID = :OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TLocation);
finalization
  UnRegisterClass(TLocation);
end.
