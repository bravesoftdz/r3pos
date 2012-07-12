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
  Str := ' delete from MKT_KPI_MODIFY where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO ';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TMktKpiModify.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  Str := ' delete from MKT_KPI_MODIFY where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO ';
  AGlobal.ExecSQL(Str,Self);
  if (FieldbyName('MODI_AMOUNT').asFloat<>0) or (FieldbyName('MODI_MONEY').asFloat<>0) or (FieldbyName('SALES_DATE').AsInteger<>FieldbyName('KPI_DATE').AsInteger) then
    begin
       FieldbyName('MODI_AMOUNT').AsString := formatFloat('#0.000',FieldbyName('MODI_AMOUNT').AsFloat * FieldbyName('CONV_RATE').AsFloat);
       Str := ' insert into MKT_KPI_MODIFY(TENANT_ID,MODIFY_ID,KPI_YEAR,KPI_DATE,SALES_ID,SEQNO,GODS_ID,MODI_AMOUNT,MODI_MONEY) '+
              ' values(:TENANT_ID,:MODIFY_ID,:KPI_YEAR,:KPI_DATE,:SALES_ID,:SEQNO,:GODS_ID,:MODI_AMOUNT,:MODI_MONEY)';
       AGlobal.ExecSQL(Str,Self);
    end;
  Result := True;
end;

function TMktKpiModify.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeInsertRecord(AGlobal);
end;

function TMktKpiModify.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMktKpiModify.InitClass;
function GetUnitTO_CALC: string;
var str:string;
begin
  str:='( case when J.UNIT_ID=E.CALC_UNITS then 1.0 '+            //默认单位为 计量单位
       ' when J.UNIT_ID=E.SMALL_UNITS then cast(E.SMALLTO_CALC*1.00 as decimal(18,3)) '+  //默认单位为 小单位
       ' when J.UNIT_ID=E.BIG_UNITS then cast(E.BIGTO_CALC*1.00 as decimal(18,3)) '+      //默认单位为 大单位
       ' else 1.0 end )';
  result:=str;
end;
var Str:String;
begin
  inherited;
  Str := 'select 0 as A,J.GLIDE_NO,J.SALES_DATE,J.KPI_DATE,E.GODS_NAME,E.GODS_CODE,J.TENANT_ID,J.SHOP_ID,J.SALES_ID,'+
         'J.GODS_ID,J.BATCH_NO,J.LOCUS_NO,J.CALC_AMOUNT/'+GetUnitTO_CALC+' as ORG_AMOUNT,J.CALC_MONEY as ORG_MONEY,'+
         '(case when J.IS_PRESENT=0 then J.CALC_AMOUNT else 0.00 end + isnull(J.MODI_AMOUNT,0))/'+GetUnitTO_CALC+' as CALC_AMOUNT,'+
         'case when J.IS_PRESENT=0 then J.CALC_MONEY else 0.00 end + isnull(J.MODI_MONEY,0) as CALC_MONEY,'+
         'J.REMARK,J.APRICE*'+GetUnitTO_CALC+' as APRICE,J.SEQNO,J.MODIFY_ID,J.KPI_YEAR,J.IS_PRESENT,J.UNIT_ID,'+GetUnitTO_CALC+' as CONV_RATE,'+
         'isnull(J.MODI_AMOUNT,0)/'+GetUnitTO_CALC+' as MODI_AMOUNT,isnull(J.MODI_MONEY,0) as MODI_MONEY from ('+
         'select B.GLIDE_NO,B.CLIENT_ID,B.SALES_TYPE,B.SALES_DATE,isnull(D.KPI_DATE,B.SALES_DATE) as KPI_DATE,A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GODS_ID,A.BATCH_NO,A.SEQNO,'+
         'A.LOCUS_NO,C.UNIT_ID,A.CALC_AMOUNT,A.IS_PRESENT,case when A.CALC_AMOUNT<>0 then A.CALC_MONEY/A.CALC_AMOUNT else 0.00 end as APRICE,A.CALC_MONEY,A.REMARK,'+
         'D.MODI_MONEY,D.MODI_AMOUNT,D.MODIFY_ID,D.KPI_YEAR '+
         ' from SAL_SALESDATA A inner join SAL_SALESORDER B on A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID '+
         ' inner join MKT_KPI_GOODS C on A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
         ' left outer join MKT_KPI_MODIFY D on A.TENANT_ID=D.TENANT_ID and A.SALES_ID=D.SALES_ID and A.SEQNO=D.SEQNO '+
         ' where B.TENANT_ID=:TENANT_ID and C.KPI_ID=:KPI_ID and isnull(D.KPI_DATE,B.SALES_DATE)>=:D1 and isnull(D.KPI_DATE,B.SALES_DATE)<=:D2 '+
         ' and B.SALES_TYPE in (1,3,4) and B.COMM not in (''02'',''12'') '+
         ' and B.CLIENT_ID=:CLIENT_ID '+
         ' and ( ((case when A.IS_PRESENT=0 then A.CALC_AMOUNT else 0.00 end+isnull(D.MODI_AMOUNT,0))<>0) or ((case when A.IS_PRESENT=0 then A.CALC_MONEY else 0 end + isnull(D.MODI_MONEY,0))<>0) ) '+
         ') J '+
         ' left join VIW_GOODSINFO E on J.TENANT_ID=E.TENANT_ID and J.GODS_ID=E.GODS_ID ';
  SelectSQL.Text := ParseSQL(iDbType,Str);
end;

{ TMktKpiNotModify }

function TMktKpiNotModify.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiNotModify.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  Str := ' delete from MKT_KPI_MODIFY where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO ';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TMktKpiNotModify.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  Str := ' delete from MKT_KPI_MODIFY where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO ';
  AGlobal.ExecSQL(Str,Self);
  if (FieldbyName('MODI_AMOUNT').asFloat<>0) or (FieldbyName('MODI_MONEY').asFloat<>0) or (FieldbyName('SALES_DATE').AsInteger<>FieldbyName('KPI_DATE').AsInteger) then
    begin
       FieldbyName('MODI_AMOUNT').AsString := formatFloat('#0.000',FieldbyName('MODI_AMOUNT').AsFloat * FieldbyName('CONV_RATE').AsFloat);
       Str := ' insert into MKT_KPI_MODIFY(TENANT_ID,MODIFY_ID,KPI_YEAR,KPI_DATE,SALES_ID,SEQNO,GODS_ID,MODI_AMOUNT,MODI_MONEY) '+
              ' values(:TENANT_ID,:MODIFY_ID,:KPI_YEAR,:KPI_DATE,:SALES_ID,:SEQNO,:GODS_ID,:MODI_AMOUNT,:MODI_MONEY)';
       AGlobal.ExecSQL(Str,Self);
    end;
  Result := True;
end;

function TMktKpiNotModify.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeInsertRecord(AGlobal);
end;

function TMktKpiNotModify.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMktKpiNotModify.InitClass;
function GetUnitTO_CALC: string;
var str:string;
begin
  str:='( case when J.UNIT_ID=E.CALC_UNITS then 1.0 '+            //默认单位为 计量单位
       ' when J.UNIT_ID=E.SMALL_UNITS then cast(E.SMALLTO_CALC*1.00 as decimal(18,3)) '+  //默认单位为 小单位
       ' when J.UNIT_ID=E.BIG_UNITS then cast(E.BIGTO_CALC*1.00 as decimal(18,3)) '+      //默认单位为 大单位
       ' else 1.0 end )';
  result:=str;
end;
var Str:String;
begin
  inherited;
  Str := 'select 0 as A,J.GLIDE_NO,J.SALES_DATE,J.KPI_DATE,E.GODS_NAME,E.GODS_CODE,J.TENANT_ID,J.SHOP_ID,J.SALES_ID,'+
         'J.GODS_ID,J.BATCH_NO,J.LOCUS_NO,J.CALC_AMOUNT/'+GetUnitTO_CALC+' as ORG_AMOUNT,J.CALC_MONEY as ORG_MONEY,'+
         '(case when J.IS_PRESENT=0 then 0.00 else J.CALC_AMOUNT end-isnull(J.MODI_AMOUNT,0))/'+GetUnitTO_CALC+' as CALC_AMOUNT,'+
         'case when J.IS_PRESENT=0 then 0.00 else J.CALC_MONEY end-isnull(J.MODI_MONEY,0) as CALC_MONEY,'+
         'J.REMARK,J.SEQNO,J.MODIFY_ID,J.KPI_YEAR,J.IS_PRESENT,J.APRICE*'+GetUnitTO_CALC+' as APRICE,J.UNIT_ID,'+GetUnitTO_CALC+' as CONV_RATE,'+
         'isnull(J.MODI_AMOUNT,0)/'+GetUnitTO_CALC+' as MODI_AMOUNT,isnull(J.MODI_MONEY,0) as MODI_MONEY from ('+
         'select B.GLIDE_NO,B.CLIENT_ID,B.SALES_TYPE,B.SALES_DATE,isnull(D.KPI_DATE,B.SALES_DATE) as KPI_DATE,A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GODS_ID,A.BATCH_NO,A.SEQNO,'+
         'A.LOCUS_NO,C.UNIT_ID,A.CALC_AMOUNT,A.IS_PRESENT,case when A.CALC_AMOUNT<>0 then A.CALC_MONEY/A.CALC_AMOUNT else 0.00 end as APRICE,A.CALC_MONEY,A.REMARK,'+
         'D.MODI_MONEY,D.MODI_AMOUNT,D.MODIFY_ID,D.KPI_YEAR '+
         ' from SAL_SALESDATA A inner join SAL_SALESORDER B on A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID '+
         ' inner join MKT_KPI_GOODS C on A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
         ' left outer join MKT_KPI_MODIFY D on A.TENANT_ID=D.TENANT_ID and A.SALES_ID=D.SALES_ID and A.SEQNO=D.SEQNO '+
         ' where B.TENANT_ID=:TENANT_ID and C.KPI_ID=:KPI_ID and isnull(D.KPI_DATE,B.SALES_DATE)>=:D1 and isnull(D.KPI_DATE,B.SALES_DATE)<=:D2 '+
         ' and B.SALES_TYPE in (1,3,4) and B.COMM not in (''02'',''12'') '+
         ' and B.CLIENT_ID=:CLIENT_ID '+
         ' and ( ((case when A.IS_PRESENT=0 then 0.00 else A.CALC_AMOUNT end-isnull(D.MODI_AMOUNT,0))<>0) or ((case when A.IS_PRESENT=0 then 0.00 else A.CALC_MONEY end-isnull(D.MODI_MONEY,0))<>0)  ) ' +
         ') J  '+
         ' left join VIW_GOODSINFO E on J.TENANT_ID=E.TENANT_ID and J.GODS_ID=E.GODS_ID ';
  SelectSQL.Text := ParseSQL(iDbType,Str);
end;

initialization
  RegisterClass(TMktKpiModify);
  RegisterClass(TMktKpiNotModify);

finalization
  UnRegisterClass(TMktKpiModify);
  UnRegisterClass(TMktKpiNotModify);

end.
