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
  if FieldByName('IS_PRESENT').AsInteger <> 0 then
  begin
     Str := ' insert into MKT_KPI_MODIFY(TENANT_ID,MODIFY_ID,KPI_YEAR,SALES_ID,SEQNO,GODS_ID,MODI_AMOUNT,MODI_MONEY) '+
            ' values(:TENANT_ID,:MODIFY_ID,:KPI_YEAR,:SALES_ID,:SEQNO,:GODS_ID,:MODI_AMOUNT,:MODI_MONEY)';
     AGlobal.ExecSQL(Str,Self);
  end;
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
var Str:String;
begin
  inherited;
  Str := 'select 0 as A,C.GLIDE_NO,C.SALES_DATE,H.CODE_NAME,E.GODS_NAME,E.GODS_CODE,F.CLIENT_NAME,C.TENANT_ID,C.SHOP_ID,C.SALES_ID,'+
         'C.GODS_ID,C.BATCH_NO,C.LOCUS_NO,G.UNIT_NAME,C.AMOUNT,C.IS_PRESENT,C.APRICE,C.AMONEY,C.REMARK,D.KPI_YEAR,C.SEQNO,D.MODIFY_ID,D.KPI_YEAR,'+
         'C.AMOUNT+isnull(D.MODI_AMOUNT,0) as COPY_MODI_AMOUNT,isnull(D.MODI_AMOUNT,0) as MODI_AMOUNT,isnull(D.MODI_MONEY,0) as MODI_MONEY from ('+
         'select B.GLIDE_NO,B.CLIENT_ID,B.SALES_TYPE,B.SALES_DATE,A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GODS_ID,A.BATCH_NO,A.SEQNO,'+
         'A.LOCUS_NO,A.UNIT_ID,A.AMOUNT,A.IS_PRESENT,A.APRICE,A.AMONEY,A.REMARK '+
         ' from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID '+
         ') C left join MKT_KPI_MODIFY D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID and C.GODS_ID=D.GODS_ID '+
         ' left join VIW_GOODSINFO E on C.TENANT_ID=E.TENANT_ID and C.GODS_ID=E.GODS_ID '+
         ' left join VIW_CUSTOMER F on C.TENANT_ID=F.TENANT_ID and C.CLIENT_ID=F.CLIENT_ID '+
         ' left join VIW_MEAUNITS G on C.TENANT_ID=G.TENANT_ID and C.UNIT_ID=G.UNIT_ID '+
         ' left join PUB_PARAMS H on C.SALES_TYPE=H.CODE_ID '+
         ' where H.TYPE_CODE=''SALES_TYPE'' and C.TENANT_ID=:TENANT_ID and C.SALES_DATE>=:D1 and C.SALES_DATE<=:D2 '+
         ' and C.CLIENT_ID=:CLIENT_ID and C.GODS_ID in (select GODS_ID from MKT_KPI_RATIO where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID) '+
         ' and ((C.IS_PRESENT = 0 and isnull(D.TENANT_ID,0)>0) or (C.IS_PRESENT <> 0 and isnull(D.TENANT_ID,0)=0))';
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

  Str := ' delete from MKT_KPI_MODIFY where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and SALES_ID=:OLD_SALES_ID and GODS_ID=:OLD_GODS_ID ';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TMktKpiNotModify.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  if FieldByName('IS_PRESENT').AsInteger = 0 then
  begin
     Str := ' insert into MKT_KPI_MODIFY(TENANT_ID,MODIFY_ID,KPI_YEAR,SALES_ID,SEQNO,GODS_ID,MODI_AMOUNT,MODI_MONEY) '+
            ' values(:TENANT_ID,:MODIFY_ID,:KPI_YEAR,:SALES_ID,:SEQNO,:GODS_ID,:MODI_AMOUNT,:MODI_MONEY)';
     AGlobal.ExecSQL(Str,Self);
  end;
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
var Str:String;
begin
  inherited;
  Str := 'select 0 as A,C.GLIDE_NO,C.SALES_DATE,H.CODE_NAME,E.GODS_NAME,E.GODS_CODE,F.CLIENT_NAME,C.TENANT_ID,C.SHOP_ID,C.SALES_ID,'+
         'C.GODS_ID,C.BATCH_NO,C.LOCUS_NO,G.UNIT_NAME,C.AMOUNT,C.IS_PRESENT,C.APRICE,C.AMONEY,C.REMARK,D.KPI_YEAR,C.SEQNO,D.MODIFY_ID,D.KPI_YEAR,'+
         'C.AMOUNT+isnull(D.MODI_AMOUNT,0) as COPY_MODI_AMOUNT,isnull(D.MODI_AMOUNT,0) as MODI_AMOUNT,isnull(D.MODI_MONEY,0) as MODI_MONEY from ('+
         'select B.GLIDE_NO,B.CLIENT_ID,B.SALES_TYPE,B.SALES_DATE,A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GODS_ID,A.BATCH_NO,A.SEQNO,'+
         'A.LOCUS_NO,A.UNIT_ID,A.AMOUNT,A.IS_PRESENT,A.APRICE,A.AMONEY,A.REMARK '+
         ' from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID '+
         ') C left join MKT_KPI_MODIFY D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID and C.GODS_ID=D.GODS_ID '+
         ' left join VIW_GOODSINFO E on C.TENANT_ID=E.TENANT_ID and C.GODS_ID=E.GODS_ID '+
         ' left join VIW_CUSTOMER F on C.TENANT_ID=F.TENANT_ID and C.CLIENT_ID=F.CLIENT_ID '+
         ' left join VIW_MEAUNITS G on C.TENANT_ID=G.TENANT_ID and C.UNIT_ID=G.UNIT_ID '+
         ' left join PUB_PARAMS H on C.SALES_TYPE=H.CODE_ID '+
         ' where H.TYPE_CODE=''SALES_TYPE'' and C.TENANT_ID=:TENANT_ID and C.SALES_DATE>=:D1 and C.SALES_DATE<=:D2 '+
         ' and C.CLIENT_ID=:CLIENT_ID and C.GODS_ID in (select GODS_ID from MKT_KPI_RATIO where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID) '+
         ' and ((C.IS_PRESENT <> 0 and isnull(D.TENANT_ID,0)>0) or (C.IS_PRESENT = 0 and isnull(D.TENANT_ID,0)=0))';
  SelectSQL.Text := ParseSQL(iDbType,Str);
end;

initialization
  RegisterClass(TMktKpiModify);
  RegisterClass(TMktKpiNotModify);

finalization
  UnRegisterClass(TMktKpiModify);
  UnRegisterClass(TMktKpiNotModify);

end.
