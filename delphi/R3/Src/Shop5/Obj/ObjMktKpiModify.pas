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
  if (FieldbyName('MODI_AMOUNT').asFloat<>0) or (FieldbyName('MODI_MONEY').asFloat<>0) then
    begin
       FieldbyName('MODI_AMOUNT').AsString := formatFloat('#0.000',FieldbyName('MODI_AMOUNT').AsFloat * FieldbyName('CONV_RATE').AsFloat);
       Str := ' insert into MKT_KPI_MODIFY(TENANT_ID,MODIFY_ID,KPI_YEAR,SALES_ID,SEQNO,GODS_ID,MODI_AMOUNT,MODI_MONEY) '+
              ' values(:TENANT_ID,:MODIFY_ID,:KPI_YEAR,:SALES_ID,:SEQNO,:GODS_ID,:MODI_AMOUNT,:MODI_MONEY)';
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
  str:='( case when C.UNIT_ID=E.CALC_UNITS then 1.0 '+            //默认单位为 计量单位
       ' when C.UNIT_ID=E.SMALL_UNITS then cast(E.SMALLTO_CALC*1.00 as decimal(18,3)) '+  //默认单位为 小单位
       ' when C.UNIT_ID=E.BIG_UNITS then cast(E.BIGTO_CALC*1.00 as decimal(18,3)) '+      //默认单位为 大单位
       ' else 1.0 end )';
  result:=str;
end;
var Str:String;
begin
  inherited;
  Str := 'select 0 as A,C.GLIDE_NO,C.SALES_DATE,E.GODS_NAME,E.GODS_CODE,C.TENANT_ID,C.SHOP_ID,C.SALES_ID,'+
         'C.GODS_ID,C.BATCH_NO,C.LOCUS_NO,C.CALC_AMOUNT/'+GetUnitTO_CALC+' as ORG_AMOUNT,C.CALC_MONEY as ORG_MONEY,'+
         '(case when C.IS_PRESENT=0 then C.CALC_AMOUNT else 0.00 end + isnull(D.MODI_AMOUNT,0))/'+GetUnitTO_CALC+' as CALC_AMOUNT,'+
         'case when C.IS_PRESENT=0 then C.CALC_MONEY else 0.00 end + isnull(D.MODI_MONEY,0) as CALC_MONEY,'+
         'C.REMARK,D.KPI_YEAR,C.APRICE*'+GetUnitTO_CALC+' as APRICE,C.SEQNO,D.MODIFY_ID,D.KPI_YEAR,C.IS_PRESENT,C.UNIT_ID,'+GetUnitTO_CALC+' as CONV_RATE,'+
         'isnull(D.MODI_AMOUNT,0)/'+GetUnitTO_CALC+' as MODI_AMOUNT,isnull(D.MODI_MONEY,0) as MODI_MONEY from ('+
         'select B.GLIDE_NO,B.CLIENT_ID,B.SALES_TYPE,B.SALES_DATE,A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GODS_ID,A.BATCH_NO,A.SEQNO,'+
         'A.LOCUS_NO,B1.UNIT_ID,A.CALC_AMOUNT,A.IS_PRESENT,case when A.CALC_AMOUNT<>0 then A.CALC_MONEY/A.CALC_AMOUNT else 0.00 endA.APRICE,A.CALC_MONEY,A.REMARK '+
         ' from SAL_SALESDATA A,SAL_SALESORDER B,MKT_KPI_GOODS B1 where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and B.TENANT_ID=:TENANT_ID and B.SALES_DATE>=:D1 and B.SALES_DATE<=:D2 '+
         ' and B.SALES_TYPE in (1,3,4) and B.COMM not in (''02'',''12'') '+
         ' and B.CLIENT_ID=:CLIENT_ID and A.TENANT_ID=B1.TENANT_ID and A.GODS_ID=B1.GODS_ID and B1.KPI_ID=:KPI_ID '+
         ') C left join MKT_KPI_MODIFY D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID and C.SEQNO=D.SEQNO '+
         ' left join VIW_GOODSINFO E on C.TENANT_ID=E.TENANT_ID and C.GODS_ID=E.GODS_ID '+
         ' where ((case when C.IS_PRESENT=0 then C.CALC_AMOUNT else 0.00 end+isnull(D.MODI_AMOUNT,0))<>0) or ((case when C.IS_PRESENT=0 then C.CALC_MONEY else 0 end + isnull(D.MODI_MONEY,0))<>0)';
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
  if (FieldbyName('MODI_AMOUNT').asFloat<>0) or (FieldbyName('MODI_MONEY').asFloat<>0) then
    begin
       FieldbyName('MODI_AMOUNT').AsString := formatFloat('#0.000',FieldbyName('MODI_AMOUNT').AsFloat * FieldbyName('CONV_RATE').AsFloat);
       Str := ' insert into MKT_KPI_MODIFY(TENANT_ID,MODIFY_ID,KPI_YEAR,SALES_ID,SEQNO,GODS_ID,MODI_AMOUNT,MODI_MONEY) '+
              ' values(:TENANT_ID,:MODIFY_ID,:KPI_YEAR,:SALES_ID,:SEQNO,:GODS_ID,:MODI_AMOUNT,:MODI_MONEY)';
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
  str:='( case when C.UNIT_ID=E.CALC_UNITS then 1.0 '+            //默认单位为 计量单位
       ' when C.UNIT_ID=E.SMALL_UNITS then cast(E.SMALLTO_CALC*1.00 as decimal(18,3)) '+  //默认单位为 小单位
       ' when C.UNIT_ID=E.BIG_UNITS then cast(E.BIGTO_CALC*1.00 as decimal(18,3)) '+      //默认单位为 大单位
       ' else 1.0 end )';
  result:=str;
end;
var Str:String;
begin
  inherited;
  Str := 'select 0 as A,C.GLIDE_NO,C.SALES_DATE,E.GODS_NAME,E.GODS_CODE,C.TENANT_ID,C.SHOP_ID,C.SALES_ID,'+
         'C.GODS_ID,C.BATCH_NO,C.LOCUS_NO,C.CALC_AMOUNT/'+GetUnitTO_CALC+' as ORG_AMOUNT,C.CALC_MONEY as ORG_MONEY,'+
         '(case when C.IS_PRESENT=0 then 0.00 else C.CALC_AMOUNT end-isnull(D.MODI_AMOUNT,0))/'+GetUnitTO_CALC+' as CALC_AMOUNT,'+
         'case when C.IS_PRESENT=0 then 0.00 else C.CALC_MONEY end-isnull(D.MODI_MONEY,0) as CALC_MONEY,'+
         'C.REMARK,D.KPI_YEAR,C.SEQNO,D.MODIFY_ID,D.KPI_YEAR,C.IS_PRESENT,C.APRICE*'+GetUnitTO_CALC+' as APRICE,C.UNIT_ID,'+GetUnitTO_CALC+' as CONV_RATE,'+
         'isnull(D.MODI_AMOUNT,0)/'+GetUnitTO_CALC+' as MODI_AMOUNT,isnull(D.MODI_MONEY,0) as MODI_MONEY from ('+
         'select B.GLIDE_NO,B.CLIENT_ID,B.SALES_TYPE,B.SALES_DATE,A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GODS_ID,A.BATCH_NO,A.SEQNO,'+
         'A.LOCUS_NO,B1.UNIT_ID,A.CALC_AMOUNT,A.IS_PRESENT,case when A.CALC_AMOUNT<>0 then A.CALC_MONEY/A.CALC_AMOUNT else 0.00 endA.APRICE,A.CALC_MONEY,A.REMARK '+
         ' from SAL_SALESDATA A,SAL_SALESORDER B,MKT_KPI_GOODS B1 where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID and B.TENANT_ID=:TENANT_ID and B.SALES_DATE>=:D1 and B.SALES_DATE<=:D2 '+
         ' and B.SALES_TYPE in (1,3,4) and B.COMM not in (''02'',''12'') '+
         ' and B.CLIENT_ID=:CLIENT_ID and A.TENANT_ID=B1.TENANT_ID and A.GODS_ID=B1.GODS_ID and B1.KPI_ID=:KPI_ID '+
         ') C left join MKT_KPI_MODIFY D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID and C.SEQNO=D.SEQNO '+
         ' left join VIW_GOODSINFO E on C.TENANT_ID=E.TENANT_ID and C.GODS_ID=E.GODS_ID '+
         ' where ((case when C.IS_PRESENT=0 then 0.00 else C.CALC_AMOUNT end-isnull(D.MODI_AMOUNT,0))<>0) or ((case when C.IS_PRESENT=0 then 0.00 else C.CALC_MONEY end-isnull(D.MODI_MONEY,0))<>0)';
  SelectSQL.Text := ParseSQL(iDbType,Str);
end;

initialization
  RegisterClass(TMktKpiModify);
  RegisterClass(TMktKpiNotModify);

finalization
  UnRegisterClass(TMktKpiModify);
  UnRegisterClass(TMktKpiNotModify);

end.
