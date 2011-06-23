unit ObjDefineReport;

interface
uses Dialogs,SysUtils,zBase,Classes,zintf,ObjCommon,DB,ZDataSet,math;

type
  TR3Report=class(TZFactory)
  public
    //function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    //function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    //function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    //function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TReportTemplate=class(TZFactory)
  public
    //function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    //function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    //function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    //function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

{ TR3Report }

procedure TR3Report.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select TENANT_ID,REPORT_ID,REPORT_TYPE,REPORT_SOURCE,REPORT_NAME,REPORT_SPELL,ROLES from SYS_REPORT where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and REPORT_ID=:REPORT_ID ';
  IsSQLUpdate := True;

  Str := 'insert into SYS_REPORT(TENANT_ID,REPORT_ID,REPORT_TYPE,REPORT_SOURCE,REPORT_NAME,REPORT_SPELL,ROLES,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:REPORT_ID,:REPORT_TYPE,:REPORT_SOURCE,:REPORT_NAME,:REPORT_SPELL,:ROLES,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update SYS_REPORT set TENANT_ID=:TENANT_ID,REPORT_ID=:REPORT_ID,REPORT_TYPE=:REPORT_TYPE,REPORT_SOURCE=:REPORT_SOURCE,REPORT_NAME=:REPORT_NAME,REPORT_SPELL=:REPORT_SPELL,'
    + 'ROLES=:ROLES,COMM='+GetCommStr(iDbType)
    + ',TIME_STAMP='+GetTimeStamp(iDbType) 
    + ' where TENANT_ID=:OLD_TENANT_ID and REPORT_ID=:OLD_REPORT_ID';
  UpdateSQL.Text := Str;

  Str := 'update SYS_REPORT set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and REPORT_ID=:OLD_REPORT_ID';
  DeleteSQL.Text := Str;
end;

{ TReportTemplate }

procedure TReportTemplate.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  ' select ROWS_ID,TENANT_ID,REPORT_ID,CELL_TYPE,CELL_COL,CELL_ROW,DISPLAY_NAME,FIELD_NAME,CELL_WIDTH,'+
  ' FIELD_NAME as FIELD_NAME_TEXT,INDEX_ID,SUM_TYPE,INDEX_FLAG,SUB_FLAG '+
  ' from SYS_REPORT_TEMPLATE where TENANT_ID=:TENANT_ID and REPORT_ID=:REPORT_ID and CELL_TYPE=:CELL_TYPE ';
  IsSQLUpdate := True;

  Str := 'insert into SYS_REPORT_TEMPLATE(ROWS_ID,TENANT_ID,REPORT_ID,CELL_TYPE,CELL_COL,CELL_ROW,DISPLAY_NAME,FIELD_NAME,CELL_WIDTH,INDEX_ID,SUM_TYPE,INDEX_FLAG,SUB_FLAG) '+
  ' VALUES(:ROWS_ID,:TENANT_ID,:REPORT_ID,:CELL_TYPE,:CELL_COL,:CELL_ROW,:DISPLAY_NAME,:FIELD_NAME,:CELL_WIDTH,:INDEX_ID,:SUM_TYPE,:INDEX_FLAG,:SUB_FLAG)';
  InsertSQL.Text := Str;

  Str := 'update SYS_REPORT_TEMPLATE set ROWS_ID=:ROWS_ID,TENANT_ID=:TENANT_ID,REPORT_ID=:REPORT_ID,CELL_TYPE=:CELL_TYPE,CELL_COL=:CELL_COL,CELL_ROW=:CELL_ROW,DISPLAY_NAME=:DISPLAY_NAME,'+
  'FIELD_NAME=:FIELD_NAME,CELL_WIDTH=:CELL_WIDTH,INDEX_ID=:INDEX_ID,SUM_TYPE=:SUM_TYPE,INDEX_FLAG=:INDEX_FLAG,SUB_FLAG=:SUB_FLAG where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID';
  UpdateSQL.Text := Str;

  Str := 'delete from SYS_REPORT_TEMPLATE where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TR3Report);
  RegisterClass(TReportTemplate);

finalization
  UnRegisterClass(TR3Report);
  UnRegisterClass(TReportTemplate);

end.
