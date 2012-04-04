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
  TMktKpiResultListForEdit=class(TZFactory)
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
    ' and KPI_YEAR='+Params.FindParam('KPI_YEAR').asString+'';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核当前经销商考核结果，是否被另一用户删除或反审核。');
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
           ' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and KPI_YEAR='+Params.FindParam('KPI_YEAR').asString+'';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核当前经销商考核结果，是否被另一用户删除或已审核。');
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
  SelectSQL.Text :=
             ParseSQL(iDbType,
                    'select A.ROWS_ID,A.TIMES_ID,A.TENANT_ID,A.CLIENT_ID,A.KPI_ID,A.KPI_YEAR,A.KPI_DATE1,'+
                    'A.KPI_DATE2,'+
                    'A.KPI_DATA,A.KPI_CALC,A.RATIO_TYPE,A.GODS_ID,isnull(B.SHORT_GODS_NAME,B.GODS_NAME) as GODS_ID_TEXT,A.LVL_AMT,A.KPI_RATE,A.FISH_AMT-A.ADJS_AMT as ORG_AMT,A.FISH_AMT,'+
                    'A.FISH_CALC_RATE,A.ADJS_AMT,A.FISH_MNY,A.ADJS_MNY,A.KPI_RATIO,A.ACTR_RATIO,A.KPI_MNY,A.BUDG_KPI '+
                    ' from MKT_KPI_RESULT_LIST A left join VIW_GOODSINFO B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
                    ' where A.TENANT_ID=:TENANT_ID and A.KPI_YEAR=:KPI_YEAR and A.KPI_ID=:KPI_ID and A.CLIENT_ID=:CLIENT_ID ');
  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_RESULT_LIST(ROWS_ID,TENANT_ID,TIMES_ID,CLIENT_ID,KPI_ID,KPI_YEAR,KPI_DATE1,KPI_DATE2,KPI_DATA,KPI_CALC,RATIO_TYPE,'+
         'GODS_ID,LVL_AMT,KPI_RATE,FISH_AMT,FISH_CALC_RATE,ADJS_AMT,FISH_MNY,ADJS_MNY,KPI_RATIO,ACTR_RATIO,KPI_MNY,BUDG_KPI) ' +
         ' VALUES(:ROWS_ID,:TENANT_ID,:TIMES_ID,:CLIENT_ID,:KPI_ID,:KPI_YEAR,:KPI_DATE1,:KPI_DATE2,:KPI_DATA,:KPI_CALC,:RATIO_TYPE,:GODS_ID,'+
         ':LVL_AMT,:KPI_RATE,:FISH_AMT,:FISH_CALC_RATE,:ADJS_AMT,:FISH_MNY,:ADJS_MNY,:KPI_RATIO,:ACTR_RATIO,:KPI_MNY,:BUDG_KPI)';
  InsertSQL.Text := Str;
  Str := 'update MKT_KPI_RESULT_LIST set TENANT_ID=:TENANT_ID,TIMES_ID=:TIMES_ID,CLIENT_ID=:CLIENT_ID,KPI_ID=:KPI_ID,KPI_YEAR=:KPI_YEAR,KPI_DATE1=:KPI_DATE1,'+
         'KPI_DATE2=:KPI_DATE2,KPI_DATA=:KPI_DATA,KPI_CALC=:KPI_CALC,RATIO_TYPE=:RATIO_TYPE,GODS_ID=:GODS_ID,LVL_AMT=:LVL_AMT,KPI_RATE=:KPI_RATE,'+
         'FISH_AMT=:FISH_AMT,FISH_CALC_RATE=:FISH_CALC_RATE,ADJS_AMT=:ADJS_AMT,FISH_MNY=:FISH_MNY,ADJS_MNY=:ADJS_MNY,KPI_RATIO=:KPI_RATIO,'+
         'ACTR_RATIO=:ACTR_RATIO,KPI_MNY=:KPI_MNY,BUDG_KPI=:BUDG_KPI where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
  UpdateSQL.Text := Str;
  Str := 'delete from MKT_KPI_RESULT_LIST where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';//' KPI_YEAR=:OLD_KPI_YEAR and KPI_ID=:OLD_KPI_ID and CLIENT_ID=:OLD_CLIENT_ID ';
  DeleteSQL.Text := Str;
end;

{ TMktKpiResult }

procedure TMktKpiResult.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select TENANT_ID,CLIENT_ID,KPI_ID,KPI_YEAR,SHOP_ID,DEPT_ID,PLAN_ID,IDX_TYPE,KPI_TYPE,CHK_DATE,CHK_USER,PLAN_AMT,PLAN_MNY,'+
                    ' FISH_AMT,ADJS_AMT,FISH_MNY,ADJS_MNY,KPI_MNY,WDW_MNY,BUDG_MNY,BUDG_KPI,BUDG_WDW,BUDG_VRF,REMARK,CREA_DATE,CREA_USER '+
                    ' from MKT_KPI_RESULT where TENANT_ID=:TENANT_ID and KPI_YEAR=:KPI_YEAR and KPI_ID=:KPI_ID and CLIENT_ID=:CLIENT_ID ';
  IsSQLUpdate := True;
  {Str := 'update MKT_KPI_RESULT set TENANT_ID=:TENANT_ID,CLIENT_ID=:CLIENT_ID,KPI_ID=:KPI_ID,KPI_YEAR=:KPI_YEAR,SHOP_ID=:SHOP_ID,'+
         'DEPT_ID=:DEPT_ID,PLAN_ID=:PLAN_ID,IDX_TYPE=:IDX_TYPE,KPI_TYPE=:KPI_TYPE,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,PLAN_AMT=:PLAN_AMT,'+
         'PLAN_MNY=:PLAN_MNY,FISH_AMT=:FISH_AMT,ADJS_AMT=:ADJS_AMT,FISH_MNY=:FISH_MNY,ADJS_MNY=:ADJS_MNY,KPI_MNY=:KPI_MNY,WDW_MNY=:WDW_MNY,'+
         'BUDG_MNY=:BUDG_MNY,BUDG_KPI=:BUDG_KPI,BUDG_WDW=:BUDG_WDW,BUDG_VRF=:BUDG_VRF,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER '+
         ' where TENANT_ID=:OLD_TENANT_ID and KPI_YEAR=:OLD_KPI_YEAR and KPI_ID=:OLD_KPI_ID and CLIENT_ID=:OLD_CLIENT_ID '; }

  Str := ' update MKT_KPI_RESULT set FISH_AMT=:FISH_AMT,ADJS_AMT=:ADJS_AMT,FISH_MNY=:FISH_MNY,ADJS_MNY=:ADJS_MNY,KPI_MNY=:KPI_MNY,'+
         ' WDW_MNY=:WDW_MNY,BUDG_MNY=:BUDG_MNY,BUDG_KPI=:BUDG_KPI,BUDG_WDW=:BUDG_WDW,BUDG_VRF=:BUDG_VRF '+
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
               'select B.TENANT_ID,B.CLIENT_ID,A.KPI_ID,B.KPI_YEAR,B.SHOP_ID,B.DEPT_ID,B.PLAN_ID,A.IDX_TYPE,A.KPI_TYPE,B.CREA_DATE,'+
               'B.CREA_USER, C.AMOUNT,C.AMONEY,0 as FISH_AMT,0 as ADJS_AMT,0 as FISH_MNY,0 as ADJS_MNY,0 as KPI_MNY,0 as WDW_MNY,C.REMARK,''00'','+GetTimeStamp(AGlobal.iDbType)+
               ' from MKT_KPI_INDEX A inner join MKT_PLANORDER B on B.TENANT_ID=A.TENANT_ID '+
               ' left outer join MKT_PLANDATA C on A.TENANT_ID=C.TENANT_ID and B.TENANT_ID=C.TENANT_ID and B.PLAN_ID=C.PLAN_ID and A.KPI_ID=C.KPI_ID '+
               ' where not exists (select * from MKT_KPI_RESULT where TENANT_ID=A.TENANT_ID and KPI_ID=A.KPI_ID and KPI_YEAR=B.KPI_YEAR and CLIENT_ID=B.CLIENT_ID) '+
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

{ TMktKpiResultListForEdit }

procedure TMktKpiResultListForEdit.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
             ParseSQL(iDbType,
                    'select A.ROWS_ID,A.TENANT_ID,A.CLIENT_ID,A.KPI_ID,A.KPI_YEAR,A.KPI_DATE1,'+
                    'A.KPI_DATE2,'+
                    'A.KPI_DATA,A.KPI_CALC,A.RATIO_TYPE,A.GODS_ID,isnull(B.SHORT_GODS_NAME,B.GODS_NAME) as GODS_ID_TEXT,A.LVL_AMT,A.KPI_RATE,'+
                    'case when A.KPI_DATA in (''1'',''3'') then isnull(A.FISH_AMT,0)-isnull(A.ADJS_AMT,0) else isnull(A.FISH_MNY,0)-isnull(A.ADJS_MNY,0) end as ORG_AMT,'+
                    'case when A.KPI_DATA in (''1'',''3'') then A.FISH_AMT else A.FISH_MNY end as FISH_AMT,'+
                    'case when A.KPI_DATA in (''1'',''3'') then A.ADJS_AMT else A.ADJS_MNY end as ADJS_AMT,'+
                    'case when A.KPI_DATA in (''1'',''3'') then C.UNIT_NAME else ''元'' end as UNIT_NAME,'+
                    'case when A.KPI_CALC in (''1'') then ''%'' when A.KPI_CALC in (''2'') then D.UNIT_NAME else ''元'' end as CALC_SHOW_NAME,'+
                    'A.FISH_CALC_RATE,'+
                    'A.KPI_RATIO,A.ACTR_RATIO,A.KPI_MNY,A.BUDG_KPI '+
                    ' from MKT_KPI_RESULT_LIST A left join VIW_GOODSINFO B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
                    ' left join MKT_KPI_INDEX C on A.TENANT_ID=C.TENANT_ID and A.KPI_ID=C.KPI_ID '+
                    ' left join VIW_MEAUNITS D on B.TENANT_ID=D.TENANT_ID and B.CALC_UNITS=D.UNIT_ID '+
                    ' where A.TENANT_ID=:TENANT_ID and A.KPI_YEAR=:KPI_YEAR and A.KPI_ID=:KPI_ID and A.CLIENT_ID=:CLIENT_ID '
             );
end;

initialization
  RegisterClass(TMktKpiResult);
  RegisterClass(TMktKpiResultList);
  RegisterClass(TMktKpiResultListForEdit);
  RegisterClass(TMktKpiResultAudit);
  RegisterClass(TMktKpiResultUnAudit);
  RegisterClass(TMktKpiResultHeader);
  RegisterClass(TMktKpiResultSale);
finalization
  UnRegisterClass(TMktKpiResult);
  UnRegisterClass(TMktKpiResultList);
  UnRegisterClass(TMktKpiResultListForEdit);
  UnRegisterClass(TMktKpiResultAudit);
  UnRegisterClass(TMktKpiResultUnAudit);
  UnRegisterClass(TMktKpiResultHeader);
  UnRegisterClass(TMktKpiResultSale);

end.
