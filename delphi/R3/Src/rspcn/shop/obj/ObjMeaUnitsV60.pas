unit ObjMeaUnitsV60;

interface

uses
  SysUtils, ZBase, Classes, ZIntf, ObjCommon, ZDataset, DB;

type

  TMeaUnitsV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

implementation

function TMeaUnitsV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
      ' select count(1) from PUB_GOODSINFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and '+
      ' ((CALC_UNITS=:OLD_UNIT_ID) or (SMALL_UNITS=:OLD_UNIT_ID) or (BIG_UNITS=:OLD_UNIT_ID)) ';
    rs.ParamByName('OLD_UNIT_ID').AsString := FieldbyName('UNIT_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('UNIT_NAME').AsOldString+'"已经在商品资料中使用不能删除.');
  finally
    rs.Free;
  end;
  result := true;
end;

function TMeaUnitsV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMeaUnitsV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMeaUnitsV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select TENANT_ID,UNIT_ID,UNIT_NAME,UNIT_SPELL,SEQ_NO,COMM,TIME_STAMP from PUB_MEAUNITS where UNIT_ID=:UNIT_ID';

  InsertSQL.Text :=
    'insert into PUB_MEAUNITS '+
    '( '+
    'TENANT_ID,UNIT_ID,UNIT_NAME,UNIT_SPELL,SEQ_NO,COMM,TIME_STAMP'+
    ') '+
    'values '+
    '( '+
    ':TENANT_ID,:UNIT_ID,:UNIT_NAME,:UNIT_SPELL,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+' '+
    ') ';

  UpdateSQL.Text :=
    'update   PUB_MEAUNITS '+
    'set      TENANT_ID=:TENANT_ID,UNIT_ID=:UNIT_ID,UNIT_NAME=:UNIT_NAME,UNIT_SPELL=:UNIT_SPELL,SEQ_NO=:SEQ_NO,'+
    '         COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where    UNIT_ID=:OLD_UNIT_ID';

  DeleteSQL.Text :=
    'update   PUB_MEAUNITS '+
    'set      COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where    UNIT_ID=:OLD_UNIT_ID';
end;

initialization
  RegisterClass(TMeaUnitsV60);
finalization
  UnRegisterClass(TMeaUnitsV60);
end.
