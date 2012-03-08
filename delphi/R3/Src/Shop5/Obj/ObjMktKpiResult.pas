unit ObjMktKpiResult;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;

type
  TMktKpiResult=class(TZFactory)
  private
    Locked:boolean;
  public
    procedure InitClass; override;
  end;
  TMktKpiResultList=class(TZFactory)
  public
    procedure InitClass; override;
  end;
  TMktKpiResultSale=class(TZFactory)
  public
    procedure InitClass; override;
  end;
  TMktKpiResultAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TMktKpiResultUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TMktKpiResultHeader=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TMktKpiResultUnAudit }

function TMktKpiResultUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
   try
    rs := TZQuery.Create(nil);

    Str := 'update MKT_KPI_RESULT set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +
    ' and PLAN_ID='''+Params.FindParam('PLAN_ID').asString+''' and KPI_ID='''+Params.FindParam('KPI_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核当前经销商考核结果，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    MSG := '反审核当前经销商考核结果成功。';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '反审核错误:'+E.Message;
       end;
  end;
end;

{ TMktKpiResultAudit }

function TMktKpiResultAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  try
    Str := 'update MKT_KPI_RESULT set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
           ' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and PLAN_ID='''+Params.FindParam('PLAN_ID').asString+''' and KPI_ID='''+Params.FindParam('KPI_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核当前经销商考核结果，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Result := true;
    Msg := '审核当前经销商考核结果成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '审核错误'+E.Message;
      end;
  end;
end;

{ TMktKpiResultList }

procedure TMktKpiResultList.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select ROWS_ID,TENANT_ID,CLIENT_ID,KPI_ID,KPI_YEAR,(KPI_YEAR*10000+KPI_DATE1) as KPI_DATE1,'+
                    'case when KPI_DATE1>KPI_DATE2 then ((KPI_YEAR+1)*10000+KPI_DATE2) else (KPI_YEAR*10000+KPI_DATE2) end as KPI_DATE2,'+
                    'KPI_DATA,KPI_CALC,RATIO_TYPE,GODS_ID,LVL_AMT,KPI_RATE,FISH_AMT-ADJS_AMT as ORG_AMT,FISH_AMT,'+
                    'FISH_CALC_RATE,ADJS_AMT,FISH_MNY,ADJS_MNY,KPI_RATIO,ACTR_RATIO,KPI_MNY,BUDG_KPI '+
                    ' from MKT_KPI_RESULT_LIST where TENANT_ID=:TENANT_ID and KPI_YEAR=:KPI_YEAR and KPI_ID=:KPI_ID and CLIENT_ID=:CLIENT_ID ';
  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_RESULT_LIST(ROWS_ID,TENANT_ID,CLIENT_ID,KPI_ID,KPI_YEAR,KPI_DATE1,KPI_DATE2,KPI_DATA,KPI_CALC,RATIO_TYPE,'+
         'GODS_ID,LVL_AMT,KPI_RATE,FISH_AMT,FISH_CALC_RATE,ADJS_AMT,FISH_MNY,ADJS_MNY,KPI_RATIO,ACTR_RATIO,KPI_MNY,BUDG_KPI) ' +
         ' VALUES(:ROWS_ID,:TENANT_ID,:CLIENT_ID,:KPI_ID,:KPI_YEAR,:KPI_DATE1,:KPI_DATE2,:KPI_DATA,:KPI_CALC,:RATIO_TYPE,:GODS_ID,'+
         ':LVL_AMT,:KPI_RATE,:FISH_AMT,:FISH_CALC_RATE,:ADJS_AMT,:FISH_MNY,:ADJS_MNY,:KPI_RATIO,:ACTR_RATIO,:KPI_MNY,:BUDG_KPI)';
  InsertSQL.Text := Str;
  Str := 'update MKT_KPI_RESULT_LIST set TENANT_ID=:TENANT_ID,CLIENT_ID=:CLIENT_ID,KPI_ID=:KPI_ID,KPI_YEAR=:KPI_YEAR,KPI_DATE1=:KPI_DATE1,'+
         'KPI_DATE2=:KPI_DATE2,KPI_DATA=:KPI_DATA,KPI_CALC=:KPI_CALC,RATIO_TYPE=:RATIO_TYPE,GODS_ID=:GODS_ID,LVL_AMT=:LVL_AMT,KPI_RATE=:KPI_RATE,'+
         'FISH_AMT=:FISH_AMT,FISH_CALC_RATE=:FISH_CALC_RATE,ADJS_AMT=:ADJS_AMT,FISH_MNY=:FISH_MNY,ADJS_MNY=:ADJS_MNY,KPI_RATIO=:KPI_RATIO,'+
         'ACTR_RATIO=:ACTR_RATIO,KPI_MNY=:KPI_MNY,BUDG_KPI=:BUDG_KPI where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and KPI_ID=:OLD_KPI_ID and CLIENT_ID=:OLD_CLIENT_ID ';
  UpdateSQL.Text := Str;
  Str := 'delete from MKT_KPI_RESULT_LIST where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and KPI_ID=:OLD_KPI_ID and CLIENT_ID=:OLD_CLIENT_ID ';
  DeleteSQL.Text := Str;
end;

{ TMktKpiResult }

procedure TMktKpiResult.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select TENANT_ID,CLIENT_ID,KPI_ID,KPI_YEAR,SHOP_ID,DEPT_ID,PLAN_ID,IDX_TYPE,KPI_TYPE,CHK_DATE,CHK_USER,PLAN_AMT,PLAN_MNY,'+
                    'FISH_AMT,ADJS_AMT,FISH_MNY,ADJS_MNY,KPI_MNY,WDW_MNY,BUDG_MNY,BUDG_KPI,BUDG_WDW,BUDG_VRF,REMARK,CREA_DATE,CREA_USER '+
                    ' from MKT_KPI_RESULT where TENANT_ID=:TENANT_ID and KPI_YEAR=:KPI_YEAR and KPI_ID=:KPI_ID and CLIENT_ID=:CLIENT_ID ';
  IsSQLUpdate := True;

  Str := 'update MKT_KPI_RESULT set TENANT_ID=:TENANT_ID,CLIENT_ID=:CLIENT_ID,KPI_ID=:KPI_ID,KPI_YEAR=:KPI_YEAR,SHOP_ID=:SHOP_ID,'+
         'DEPT_ID=:DEPT_ID,PLAN_ID=:PLAN_ID,IDX_TYPE=:IDX_TYPE,KPI_TYPE=:KPI_TYPE,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,PLAN_AMT=:PLAN_AMT,'+
         'PLAN_MNY=:PLAN_MNY,FISH_AMT=:FISH_AMT,ADJS_AMT=:ADJS_AMT,FISH_MNY=:FISH_MNY,ADJS_MNY=:ADJS_MNY,KPI_MNY=:KPI_MNY,WDW_MNY=:WDW_MNY,'+
         'BUDG_MNY=:BUDG_MNY,BUDG_KPI=:BUDG_KPI,BUDG_WDW=:BUDG_WDW,BUDG_VRF=:BUDG_VRF,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER '+
         ' where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and KPI_ID=:OLD_KPI_ID and CLIENT_ID=:OLD_CLIENT_ID ';
  UpdateSQL.Text := Str;

end;

{ TMktKpiResultHeader }

function TMktKpiResultHeader.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var ExceSql:String;
    n:Integer;
begin
  if Params.FindParam('EXCETYPE').AsInteger = 1 then
  begin
  {TENANT_ID,CLIENT_ID,KPI_ID,KPI_YEAR,SHOP_ID,DEPT_ID,PLAN_ID,IDX_TYPE,KPI_TYPE,KPI_DATA,KPI_CALC,RATIO_TYPE,CHK_DATE,
CHK_USER,PLAN_AMT,PLAN_MNY,FISH_AMT,ADJS_AMT,FISH_MNY,ADJS_MNY,KPI_MNY,WDW_MNY,BUDG_MNY,BUDG_KPI,BUDG_WDW,BUDG_VRF,
REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP}
    {ExceSql := ' insert into MKT_KPI_RESULT (TENANT_ID,PLAN_ID,SHOP_ID,IDX_TYPE,KPI_CALC,KPI_TYPE,KPI_DATA,KPI_ID,KPI_YEAR,BEGIN_DATE,END_DATE,CLIENT_ID,'+
         'CHK_DATE,CHK_USER,PLAN_AMT,PLAN_MNY,FISH_AMT,FISH_MNY,KPI_MNY,WDW_MNY,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+  //
         ' select B.TENANT_ID,B.PLAN_ID,B.SHOP_ID,C.IDX_TYPE,C.KPI_CALC,C.KPI_TYPE,C.KPI_DATA,A.KPI_ID,B.KPI_YEAR,B.BEGIN_DATE,B.END_DATE,B.CLIENT_ID,B.CHK_DATE,B.CHK_USER,B.PLAN_AMT,'+
         'B.PLAN_MNY,0 as FISH_AMT,0 as FISH_MNY,0 as KPI_MNY,0 as WDW_MNY,B.REMARK,'+QuotedStr(Params.FindParam('CREA_DATE').AsString)+
         ','+QuotedStr(Params.FindParam('CREA_USER').AsString)+',''00'','+GetTimeStamp(AGlobal.iDbType)+ //
         ' from MKT_PLANDATA A,MKT_PLANORDER B,MKT_KPI_INDEX C '+
         ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and A.TENANT_ID=C.TENANT_ID and A.KPI_ID=C.KPI_ID '+
         ' and not exists (select * from MKT_KPI_RESULT where TENANT_ID=A.TENANT_ID and PLAN_ID=A.PLAN_ID and KPI_ID=A.KPI_ID) '+
         ' and B.CHK_DATE IS NOT NULL and B.PLAN_TYPE=:PLAN_TYPE and C.IDX_TYPE=:IDX_TYPE and B.TENANT_ID=:TENANT_ID and B.KPI_YEAR=:KPI_YEAR ';}

    ExceSql := 'insert into MKT_KPI_RESULT (TENANT_ID,CLIENT_ID,KPI_ID,KPI_YEAR,SHOP_ID,DEPT_ID,PLAN_ID,IDX_TYPE,KPI_TYPE,'+
               'CREA_DATE,CREA_USER,PLAN_AMT,PLAN_MNY,FISH_AMT,ADJS_AMT,FISH_MNY,ADJS_MNY,KPI_MNY,WDW_MNY,REMARK,COMM,TIME_STAMP) '+
               'select B.TENANT_ID,B.CLIENT_ID,A.KPI_ID,B.KPI_YEAR,B.SHOP_ID,B.DEPT_ID,C.PLAN_ID,A.IDX_TYPE,A.KPI_TYPE,B.CREA_DATE,'+
               'B.CREA_USER, C.AMOUNT,C.AMONEY,0 as FISH_AMT,0 as ADJS_AMT,0 as FISH_MNY,0 as ADJS_MNY,0 as KPI_MNY,0 as WDW_MNY,C.REMARK,''00'','+GetTimeStamp(AGlobal.iDbType)+
               ' from MKT_KPI_INDEX A inner join MKT_PLANORDER B on B.TENANT_ID=A.TENANT_ID '+
               ' left join MKT_PLANDATA C on A.TENANT_ID=C.TENANT_ID and A.KPI_ID=C.KPI_ID '+
               ' where not exists (select * from MKT_KPI_RESULT where TENANT_ID=A.TENANT_ID and KPI_ID=A.KPI_ID) '+
               ' and B.CHK_DATE IS NOT NULL and B.PLAN_TYPE=:PLAN_TYPE and B.TENANT_ID=:TENANT_ID and B.KPI_YEAR=:KPI_YEAR ';
    if Params.FindParam('CLIENT_ID') <> nil then
       ExceSql := ExceSql + ' and B.CLIENT_ID=:CLIENT_ID ';
    if Params.FindParam('KPI_ID') <> nil then
       ExceSql := ExceSql + ' and C.KPI_ID=:KPI_ID ';
  end
  else if Params.FindParam('EXCETYPE').AsInteger = 2 then
  begin
    {ExceSql := ' update MKT_KPI_RESULT '+
               ' set PLAN_AMT = (select AMOUNT from MKT_PLANDATA C where '+
               ' C.TENANT_ID=MKT_KPI_RESULT.TENANT_ID and C.PLAN_ID=MKT_KPI_RESULT.PLAN_ID and C.KPI_ID=MKT_KPI_RESULT.KPI_ID) , '+
               ' PLAN_MNY = (select AMONEY from MKT_PLANDATA C where '+
               ' C.TENANT_ID=MKT_KPI_RESULT.TENANT_ID and C.PLAN_ID=MKT_KPI_RESULT.PLAN_ID and C.KPI_ID=MKT_KPI_RESULT.KPI_ID) , '+
               ' COMM= ' + GetCommStr(AGlobal.iDbType) + ' '+
               ' where TENANT_ID=:TENANT_ID and KPI_YEAR=:KPI_YEAR and IDX_TYPE=:IDX_TYPE and '+
               ' Exists(select * from MKT_PLANORDER where TENANT_ID=MKT_KPI_RESULT.TENANT_ID and PLAN_ID=MKT_KPI_RESULT.PLAN_ID and PLAN_TYPE=:PLAN_TYPE and KPI_YEAR=:KPI_YEAR) ';
    if Params.FindParam('CLIENT_ID') <> nil then
       ExceSql := ExceSql + ' and CLIENT_ID=:CLIENT_ID ';
    if Params.FindParam('KPI_ID') <> nil then
       ExceSql := ExceSql + ' and KPI_ID=:KPI_ID '; }
  end
  else if Params.FindParam('EXCETYPE').AsInteger = 3 then
  begin
    ExceSql := 'delete from MKT_KPI_RESULT where not exists(select * from MKT_PLANDATA B where '+
               'B.TENANT_ID=MKT_KPI_RESULT.TENANT_ID and B.PLAN_ID=MKT_KPI_RESULT.PLAN_ID and B.KPI_ID=MKT_KPI_RESULT.KPI_ID) and TENANT_ID=:TENANT_ID and IDX_TYPE=:IDX_TYPE and KPI_YEAR=:KPI_YEAR ';//+
               //'and Exists(select * from MKT_PLANORDER where TENANT_ID=MKT_KPI_RESULT.TENANT_ID and PLAN_ID=MKT_KPI_RESULT.PLAN_ID and PLAN_TYPE=:PLAN_TYPE and KPI_YEAR=:KPI_YEAR) ';
    if Params.FindParam('CLIENT_ID') <> nil then
       ExceSql := ExceSql + ' and CLIENT_ID=:CLIENT_ID ';
    if Params.FindParam('KPI_ID') <> nil then
       ExceSql := ExceSql + ' and KPI_ID=:KPI_ID ';
  end;
  AGlobal.ExecSQL(ExceSql,Params);
end;

{ TMktKpiResultSale }

procedure TMktKpiResultSale.InitClass;
begin
  inherited;
  SelectSQL.Text := 'select sum(CALC_AMOUNT) as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY from VIW_SALESDATA where TENANT_ID=:TENANT_ID '+
    ' and CLIENT_ID=:CLIENT_ID and GODS_ID in (select GODS_ID from MKT_KPI_GOODS where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID) and SALES_DATE >= :SALES_DATE1 and SALES_DATE <= :SALES_DATE2 ';
end;

initialization
  RegisterClass(TMktKpiResult);
  RegisterClass(TMktKpiResultList);
  RegisterClass(TMktKpiResultAudit);
  RegisterClass(TMktKpiResultUnAudit);
  RegisterClass(TMktKpiResultHeader);
  RegisterClass(TMktKpiResultSale);
finalization
  UnRegisterClass(TMktKpiResult);
  UnRegisterClass(TMktKpiResultList);
  UnRegisterClass(TMktKpiResultAudit);
  UnRegisterClass(TMktKpiResultUnAudit);
  UnRegisterClass(TMktKpiResultHeader);
  UnRegisterClass(TMktKpiResultSale);

end.
