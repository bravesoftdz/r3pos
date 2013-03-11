unit ObjMeaUnitsV60;

interface

uses
  SysUtils, zBase, Classes, ZIntf, ObjCommon, ZDataset, DB;

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
begin

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
    'select TENANT_ID,UNIT_ID,UNIT_NAME,UNIT_SPELL,SEQ_NO,COMM,TIME_STAMP from PUB_MEAUNITS where TENANT_ID=:TENANT_ID and UNIT_ID=:UNIT_ID';

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
    'update 	PUB_MEAUNITS '+
    'set			TENANT_ID=:TENANT_ID,UNIT_ID=:UNIT_ID,UNIT_NAME=:UNIT_NAME,UNIT_SPELL=:UNIT_SPELL,SEQ_NO=:SEQ_NO '+
    '         COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where    TENANT_ID=:OLD_TENANT_ID and UNIT_ID=:OLD_UNIT_ID';

  DeleteSQL.Text :=
    'update 	PUB_MEAUNITS '+
    'set			COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where    TENANT_ID=:OLD_TENANT_ID and UNIT_ID=:OLD_UNIT_ID';
end;

initialization
  RegisterClass(TMeaUnitsV60);
finalization
  UnRegisterClass(TMeaUnitsV60);
end.




