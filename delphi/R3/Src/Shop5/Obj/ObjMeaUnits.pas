unit ObjMeaUnits;

interface
uses Dialogs,SysUtils,ZBase,Classes, AdoDb,ZIntf,ObjCommon,ZDataset;
type
  TMeaUnits=class(TZFactory)
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
implementation

{ TMeaUnits }

function TMeaUnits.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from PUB_GOODSINFO where (CALC_UNITS=:OLD_UNIT_ID) or (SMALL_UNITS=:OLD_UNIT_ID)'+
    ' or (BIG_UNITS=:OLD_UNIT_ID) and COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('UNIT_NAME').AsOldString+'"已经在商品资料中使用不能删除.');
    {rs.Close;
    rs.CommandText := 'select count(*) from BAS_GOODSINFO where (CALC_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') or (SMALL_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') or (BIG_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') and COMM not in (''02'',''12'')';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('UNIT_NAME').AsOldString+'"已经在商品资料中使用不能删除.'); }
  finally
    rs.Free;
  end;
  result := true;
end;

function TMeaUnits.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select UNIT_ID,COMM,SEQ_NO from PUB_MEAUNITS where UNIT_NAME=:UNIT_NAME and TENANT_ID=:TENANT_ID ';
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的分组，重新启动原有编码
           begin
             FieldbyName('UNIT_ID').AsString := rs.FieldbyName('UNIT_ID').AsString;
             AGlobal.ExecSQL('delete from PUB_MEAUNITS where UNIT_ID=:UNIT_ID and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('UNIT_NAME').AsString+'"单位名称不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TMeaUnits.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_MEAUNITS where UNIT_NAME=:UNIT_NAME and UNIT_ID<>:UNIT_ID and COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger >0 then Raise Exception.Create('"'+FieldbyName('UNIT_NAME').AsString+'"单位名称不能重复设置');
  finally
    rs.Free;
  end;
end;

procedure TMeaUnits.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select UNIT_ID,UNIT_NAME,UNIT_SPELL,TENANT_ID,SEQ_NO from PUB_MEAUNITS where COMM not in (''02'',''12'')  order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into PUB_MEAUNITS(UNIT_ID,UNIT_NAME,UNIT_SPELL,TENANT_ID,SEQ_NO,COMM,TIME_STAMP) '
    + 'VALUES(:UNIT_ID,:UNIT_NAME,:UNIT_SPELL,:TENANT_ID,:SEQ_NO,''00'','+GetTimeStamp(5)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_MEAUNITS set UNIT_ID=:UNIT_ID,UNIT_NAME=:UNIT_NAME,UNIT_SPELL=:UNIT_SPELL,TENANT_ID=:TENANT_ID,SEQ_NO=:SEQ_NO,'
    + 'COMM='+GetCommStr(5)+',TIME_STAMP='+GetTimeStamp(5)+' where UNIT_ID=:OLD_UNIT_ID and TENANT_ID = :OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'update PUB_MEAUNITS set COMM=''02'',TIME_STAMP='+GetTimeStamp(5)+' where UNIT_ID=:OLD_UNIT_ID and TENANT_ID = :OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;
initialization
  RegisterClass(TMeaUnits);
finalization
  UnRegisterClass(TMeaUnits);
end.

