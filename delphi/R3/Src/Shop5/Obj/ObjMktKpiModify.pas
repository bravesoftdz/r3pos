unit ObjMktKpiModify;

interface
uses Dialogs,SysUtils,zBase,Classes,zintf,ObjCommon,DB,ZDataSet,math;

type
  TMktKpiModify=class(TZFactory)
  private
    lock:boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TMktKpiNotModify=class(TZFactory)
  private
    lock:boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

implementation

{ TMktKpiModify }

function TMktKpiModify.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiModify.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  Str := ' delete from MKT_KPI_MODIFY where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and SALES_ID=:OLD_SALES_ID and GODS_ID=:OLD_GODS_ID ';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TMktKpiModify.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  Str := ' insert into MKT_KPI_MODIFY(TENANT_ID,MODIFY_ID,KPI_YEAR,SALES_ID,SEQNO,GODS_ID,MODI_AMOUNT,MODI_MONEY) '+
         ' values(:TENANT_ID,:MODIFY_ID,:KPI_YEAR,:SALES_ID,:SEQNO,:GODS_ID,:MODI_AMOUNT,:MODI_MONEY)';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TMktKpiModify.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TMktKpiModify.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMktKpiModify.InitClass;
begin
  inherited;

end;

{ TMktKpiNotModify }

function TMktKpiNotModify.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiNotModify.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  Str := ' delete from MKT_KPI_MODIFY where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and SALES_ID=:OLD_SALES_ID and GODS_ID=:OLD_GODS_ID ';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TMktKpiNotModify.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  Str := ' insert into MKT_KPI_MODIFY(TENANT_ID,MODIFY_ID,KPI_YEAR,SALES_ID,SEQNO,GODS_ID,MODI_AMOUNT,MODI_MONEY) '+
         ' values(:TENANT_ID,:MODIFY_ID,:KPI_YEAR,:SALES_ID,:SEQNO,:GODS_ID,:MODI_AMOUNT,:MODI_MONEY)';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TMktKpiNotModify.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TMktKpiNotModify.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMktKpiNotModify.InitClass;
begin
  inherited;

end;

initialization
  RegisterClass(TMktKpiModify);
  RegisterClass(TMktKpiNotModify);

finalization
  UnRegisterClass(TMktKpiModify);
  UnRegisterClass(TMktKpiNotModify);

end.
