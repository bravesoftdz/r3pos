unit ObjMktActiveList;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TMktActiveList=class(TZFactory)
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
implementation

{ TMktActiveList }

function TMktActiveList.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  {rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from PUB_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and'+
    ' ((CALC_UNITS=:OLD_UNIT_ID) or (SMALL_UNITS=:OLD_UNIT_ID) or (BIG_UNITS=:OLD_UNIT_ID)) ';
    rs.ParamByName('OLD_UNIT_ID').AsString := FieldbyName('UNIT_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);

    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('UNIT_NAME').AsOldString+'"已经在商品资料中使用不能删除.');
  finally
    rs.Free;
  end;}

  result := true;
end;

function TMktActiveList.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ACTIVE_ID,COMM from MKT_ACTIVE_INFO where ACTIVE_NAME=:ACTIVE_NAME and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('ACTIVE_NAME').AsString := FieldbyName('ACTIVE_NAME').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的活动，重新启动原有编码
           begin
             FieldbyName('ACTIVE_ID').AsString := rs.FieldbyName('ACTIVE_ID').AsString;
             AGlobal.ExecSQL('delete from MKT_ACTIVE_INFO where ACTIVE_ID=:ACTIVE_ID and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('ACTIVE_NAME').AsString+'"活动名称不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TMktActiveList.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from MKT_ACTIVE_INFO where ACTIVE_NAME=:ACTIVE_NAME and ACTIVE_ID<>:OLD_ACTIVE_ID and COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('ACTIVE_NAME').AsString := FieldbyName('ACTIVE_NAME').AsString;
    rs.ParamByName('OLD_ACTIVE_ID').AsString := FieldbyName('ACTIVE_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);

    if rs.Fields[0].AsInteger >0 then Raise Exception.Create('"'+FieldbyName('ACTIVE_NAME').AsString+'"活动名称不能重复设置');
  finally
    rs.Free;
  end;
end;

procedure TMktActiveList.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := ' select A.TENANT_ID,A.ACTIVE_ID,A.ACTIVE_NAME,A.ACTIVE_SPELL,A.ACTIVE_GROUP,B.CODE_NAME as ACTIVE_GROUP_TEXT,A.REMARK,A.COMM,A.TIME_STAMP from MKT_ACTIVE_INFO A '+
                    ' left join PUB_CODE_INFO B on A.TENANT_ID=B.TENANT_ID and A.ACTIVE_GROUP=B.CODE_ID '+
                    ' where A.COMM not in (''02'',''12'') and A.TENANT_ID=:TENANT_ID and B.CODE_TYPE=''18'' order by A.ACTIVE_ID ';
  IsSQLUpdate := True;
  Str := 'insert into MKT_ACTIVE_INFO(TENANT_ID,ACTIVE_ID,ACTIVE_NAME,ACTIVE_SPELL,ACTIVE_GROUP,REMARK,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:ACTIVE_ID,:ACTIVE_NAME,:ACTIVE_SPELL,:ACTIVE_GROUP,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update MKT_ACTIVE_INFO set TENANT_ID=:TENANT_ID,ACTIVE_ID=:ACTIVE_ID,ACTIVE_NAME=:ACTIVE_NAME,ACTIVE_SPELL=:ACTIVE_SPELL,ACTIVE_GROUP=:ACTIVE_GROUP,REMARK=:REMARK,' +
  'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where ACTIVE_ID=:OLD_ACTIVE_ID and TENANT_ID = :OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'update MKT_ACTIVE_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where ACTIVE_ID=:OLD_ACTIVE_ID and TENANT_ID = :OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TMktActiveList);
finalization
  UnRegisterClass(TMktActiveList);
end.

