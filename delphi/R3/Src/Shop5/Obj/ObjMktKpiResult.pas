unit ObjMktKpiResult;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;

type
  TMktKpiResult=class(TZFactory)
  private
    Locked:boolean;
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
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
  TMktKpiResultList=class(TZFactory)
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

function TMktKpiResultList.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResultList.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResultList.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResultList.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResultList.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMktKpiResultList.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select TENANT_ID,PLAN_ID,KPI_ID,KPI_LV,SEQNO,KPI_TYPE,KPI_DATA,KPI_CALC,KPI_RATE,KPI_AMT,KPI_DATE1,KPI_DATE2,KPI_AGIO,FSH_VLE,KPI_MNY '+
                    ' from MKT_KPI_RESULT_LIST where TENANT_ID=:TENANT_ID and PLAN_ID=:PLAN_ID and KPI_ID=:KPI_ID order by KPI_LV,SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_RESULT_LIST(TENANT_ID,PLAN_ID,KPI_ID,KPI_LV,SEQNO,KPI_TYPE,KPI_DATA,KPI_CALC,KPI_RATE,KPI_AMT,KPI_DATE1,KPI_DATE2,KPI_AGIO,FSH_VLE,KPI_MNY) '
    + 'VALUES(:TENANT_ID,:PLAN_ID,:KPI_ID,:KPI_LV,:SEQNO,:KPI_TYPE,:KPI_DATA,:KPI_CALC,:KPI_RATE,:KPI_AMT,:KPI_DATE1,:KPI_DATE2,:KPI_AGIO,:FSH_VLE,:KPI_MNY)';
  InsertSQL.Text := Str;
  Str := 'update MKT_KPI_RESULT_LIST set TENANT_ID=:TENANT_ID,PLAN_ID=:PLAN_ID,KPI_ID=:KPI_ID,KPI_LV=:KPI_LV,SEQNO=:SEQNO,KPI_TYPE=:KPI_TYPE,KPI_DATA=:KPI_DATA,'+
         'KPI_CALC=:KPI_CALC,KPI_RATE=:KPI_RATE,KPI_AMT=:KPI_AMT,KPI_DATE1=:KPI_DATE1,KPI_DATE2=:KPI_DATE2,KPI_AGIO=:KPI_AGIO,FSH_VLE=:FSH_VLE,KPI_MNY=:KPI_MNY '+
         ' where TENANT_ID=:OLD_TENANT_ID and PLAN_ID=:OLD_PLAN_ID and KPI_ID=:OLD_KPI_ID and KPI_LV=:OLD_KPI_LV and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := Str;
  Str := 'delete from MKT_KPI_RESULT_LIST where TENANT_ID=:OLD_TENANT_ID and PLAN_ID=:OLD_PLAN_ID and KPI_ID=:OLD_KPI_ID and KPI_LV=:OLD_KPI_LV and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := Str;
end;

{ TMktKpiResult }

function TMktKpiResult.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResult.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResult.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResult.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResult.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktKpiResult.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
begin

end;

procedure TMktKpiResult.InitClass;
var
  Str: string;
begin
  inherited;

  Str := 'update MKT_KPI_RESULT set FISH_AMT=:FISH_AMT,FISH_MNY=:FISH_MNY,KPI_MNY=:KPI_MNY,WDW_MNY=:WDW_MNY '+
         ' where TENANT_ID=:OLD_TENANT_ID and PLAN_ID=:OLD_PLAN_ID and KPI_ID=:OLD_KPI_ID ';
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
    ExceSql := ' insert into MKT_KPI_RESULT (TENANT_ID,PLAN_ID,SHOP_ID,IDX_TYPE,KPI_CALC,KPI_TYPE,KPI_DATA,KPI_ID,KPI_YEAR,BEGIN_DATE,END_DATE,CLIENT_ID,'+
         'CHK_DATE,CHK_USER,PLAN_AMT,PLAN_MNY,FISH_AMT,FISH_MNY,KPI_MNY,WDW_MNY,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+  //
         ' select B.TENANT_ID,B.PLAN_ID,B.SHOP_ID,C.IDX_TYPE,C.KPI_CALC,C.KPI_TYPE,C.KPI_DATA,A.KPI_ID,B.KPI_YEAR,B.BEGIN_DATE,B.END_DATE,B.CLIENT_ID,B.CHK_DATE,B.CHK_USER,B.PLAN_AMT,'+
         'B.PLAN_MNY,0 as FISH_AMT,0 as FISH_MNY,0 as KPI_MNY,0 as WDW_MNY,B.REMARK,'+QuotedStr(Params.FindParam('CREA_DATE').AsString)+
         ','+QuotedStr(Params.FindParam('CREA_USER').AsString)+',''00'','+GetTimeStamp(AGlobal.iDbType)+ //
         ' from MKT_PLANDATA A,MKT_PLANORDER B,MKT_KPI_INDEX C '+
         ' where A.TENANT_ID=B.TENANT_ID and A.PLAN_ID=B.PLAN_ID and A.TENANT_ID=C.TENANT_ID and A.KPI_ID=C.KPI_ID '+
         ' and not exists (select * from MKT_KPI_RESULT where TENANT_ID=A.TENANT_ID and PLAN_ID=A.PLAN_ID and KPI_ID=A.KPI_ID) '+
         ' and B.CHK_DATE IS NOT NULL and B.PLAN_TYPE=:PLAN_TYPE and C.IDX_TYPE=:IDX_TYPE and B.TENANT_ID=:TENANT_ID and B.KPI_YEAR=:KPI_YEAR ';
    if Params.FindParam('CLIENT_ID') <> nil then
       ExceSql := ExceSql + ' and B.CLIENT_ID=:CLIENT_ID ';
    if Params.FindParam('KPI_ID') <> nil then
       ExceSql := ExceSql + ' and A.KPI_ID=:KPI_ID ';
  end
  else if Params.FindParam('EXCETYPE').AsInteger = 2 then
  begin
    ExceSql := ' update MKT_KPI_RESULT '+
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
       ExceSql := ExceSql + ' and KPI_ID=:KPI_ID ';
  end
  else if Params.FindParam('EXCETYPE').AsInteger = 3 then
  begin
    ExceSql := 'delete from MKT_KPI_RESULT where not exists(select * from MKT_PLANDATA B where '+
               'B.TENANT_ID=MKT_KPI_RESULT.TENANT_ID and B.PLAN_ID=MKT_KPI_RESULT.PLAN_ID and B.KPI_ID=MKT_KPI_RESULT.KPI_ID) and TENANT_ID=:TENANT_ID and IDX_TYPE=:IDX_TYPE and KPI_YEAR=:KPI_YEAR '+
               'and Exists(select * from MKT_PLANORDER where TENANT_ID=MKT_KPI_RESULT.TENANT_ID and PLAN_ID=MKT_KPI_RESULT.PLAN_ID and PLAN_TYPE=:PLAN_TYPE and KPI_YEAR=:KPI_YEAR) ';
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
