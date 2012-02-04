unit ObjMktRequOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;
type
  TMktRequOrder=class(TZFactory)
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
  TMktRequData=class(TZFactory)
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
  TMktRequOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TMktRequOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TMktRequOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TMktRequOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TMktRequOrder }

function TMktRequOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktRequOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktRequOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_E_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
end;

function TMktRequOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktRequOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktRequOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from MKT_REQUORDER where REQU_ID='''+FieldbyName('REQU_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString+'';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and
    (
       (copy(rs.Fields[1].asString,1,1)='1')
       or
       (copy(rs.Fields[1].asString,2,1)<>'0')
    )
    then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TMktRequOrder.InitClass;
var
  Str: string;
begin
  inherited;
  Locked := false;
  SelectSQL.Text :=
  'select A.TENANT_ID,A.REQU_ID,A.IORO_ID,A.SHOP_ID,B.SHOP_NAME as SHOP_ID_TEXT,A.DEPT_ID,C.DEPT_NAME as DEPT_ID_TEXT,'+
  'A.REQU_TYPE,A.GLIDE_NO,A.REQU_DATE,A.CLIENT_ID,D.CLIENT_NAME as CLIENT_ID_TEXT,A.REQU_USER,E.USER_NAME as REQU_USER_TEXT,'+
  'A.CHK_DATE,A.CHK_USER,G.USER_NAME as CHK_USER_TEXT,A.REQU_MNY,A.REMARK,A.CREA_DATE,A.CREA_USER,F.USER_NAME as CREA_USER_TEXT '+
  ' from MKT_REQUORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
  ' left join CA_DEPT_INFO C on A.TENANT_ID=C.TENANT_ID and A.DEPT_ID=C.DEPT_ID '+
  ' left join VIW_CUSTOMER D on A.TENANT_ID=D.TENANT_ID and A.CLIENT_ID=D.CLIENT_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.REQU_USER=E.USER_ID '+
  ' left join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.CREA_USER=F.USER_ID '+
  ' left join VIW_USERS G on A.TENANT_ID=G.TENANT_ID and A.CHK_USER=G.USER_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.REQU_ID=:REQU_ID';
  IsSQLUpdate := True;
  Str := 'insert into MKT_REQUORDER(TENANT_ID,SHOP_ID,REQU_ID,IORO_ID,DEPT_ID,REQU_TYPE,GLIDE_NO,REQU_DATE,CLIENT_ID,REQU_USER,CHK_DATE,CHK_USER,REQU_MNY,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:REQU_ID,''#'',:DEPT_ID,:REQU_TYPE,:GLIDE_NO,:REQU_DATE,:CLIENT_ID,:REQU_USER,:CHK_DATE,:CHK_USER,:REQU_MNY,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update MKT_REQUORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,REQU_ID=:REQU_ID,DEPT_ID=:DEPT_ID,REQU_TYPE=:REQU_TYPE,GLIDE_NO=:GLIDE_NO,REQU_DATE=:REQU_DATE,'+
      'CLIENT_ID=:CLIENT_ID,REQU_USER=:REQU_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REQU_MNY=:REQU_MNY,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and REQU_ID=:OLD_REQU_ID ';
  UpdateSQL.Text := Str;
  Str := ' delete from MKT_REQUORDER where TENANT_ID=:OLD_TENANT_ID and REQU_ID=:OLD_REQU_ID ';
  DeleteSQL.Text := Str;
end;

{ TMktRequData }

function TMktRequData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktRequData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktRequData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TMktRequData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TMktRequData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

procedure TMktRequData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=      
     'select A.TENANT_ID,A.SEQNO,A.REQU_ID,A.PLAN_ID,A.SHOP_ID,A.KPI_ID,B.KPI_NAME as KPI_ID_TEXT,A.KPI_YEAR,C.KPI_MNY,C.WDW_MNY,A.REQU_MNY,A.REMARK '+
     ' from MKT_REQUDATA A left join MKT_KPI_INDEX B on A.TENANT_ID=B.TENANT_ID and A.KPI_ID=B.KPI_ID '+
     ' left join MKT_KPI_RESULT C on A.TENANT_ID=C.TENANT_ID and A.KPI_ID=C.KPI_ID and A.KPI_YEAR=C.KPI_YEAR '+
     'where A.TENANT_ID=:TENANT_ID and A.REQU_ID=:REQU_ID order by A.SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into MKT_REQUDATA(TENANT_ID,SHOP_ID,SEQNO,REQU_ID,PLAN_ID,KPI_ID,KPI_YEAR,REQU_MNY,REMARK) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SEQNO,:REQU_ID,:PLAN_ID,:KPI_ID,:KPI_YEAR,:REQU_MNY,:REMARK)';
  InsertSQL.Text := Str;
  Str := 'update MKT_REQUDATA set TENANT_ID=:TENANT_ID,SEQNO=:SEQNO,SHOP_ID=:SHOP_ID,REQU_ID=:REQU_ID,PLAN_ID=:PLAN_ID,KPI_ID=:KPI_ID,KPI_YEAR=:KPI_YEAR,REQU_MNY=:REQU_MNY,REMARK=:REMARK '
    + 'where TENANT_ID=:OLD_TENANT_ID and REQU_ID=:OLD_REQU_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := Str;
  Str := 'delete from MKT_REQUDATA where TENANT_ID=:OLD_TENANT_ID and REQU_ID=:OLD_REQU_ID and SEQNO=:OLD_SEQNO ';
  DeleteSQL.Text := Str;
end;

{ TMktRequOrderGetPrior }

procedure TMktRequOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 REQU_ID from MKT_REQUORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select REQU_ID from MKT_REQUORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select REQU_ID from MKT_REQUORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select REQU_ID from MKT_REQUORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC limit 1';
  end;
end;

{ TMktRequOrderGetNext }

procedure TMktRequOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 REQU_ID from MKT_REQUORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select REQU_ID from MKT_REQUORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select REQU_ID from MKT_REQUORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select REQU_ID from MKT_REQUORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO limit 1';
  end;
end;

{ TMktRequOrderAudit }

function TMktRequOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  AGlobal.BeginTrans;
  try

    Str := 'update MKT_REQUORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) +
           ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and REQU_ID='''+Params.FindParam('REQU_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    AGlobal.ExecSQL(
           'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
         + 'select REQU_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,case when REQU_TYPE=''1'' then ''销售返利'' else ''市场费计提'' end'+GetStrJoin(AGlobal.iDbType)+'''(申请单号:'''+GetStrJoin(AGlobal.iDbType)+'GLIDE_NO'+GetStrJoin(AGlobal.iDbType)+''')'',''5'',REQU_MNY,0,0,REQU_MNY,REQU_DATE,REQU_ID,'''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',:CHK_USER,''00'','+GetTimeStamp(AGlobal.iDbType)+' from MKT_REQUORDER where TENANT_ID=:TENANT_ID and REQU_ID=:REQU_ID'
      ,params);
    AGlobal.CommitTrans;
    Result := true;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        AGlobal.RollbackTrans;
        Result := false;
        Msg := '审核错误'+E.Message;
      end;
  end;
end;

{ TMktRequOrderUnAudit }

function TMktRequOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
   AGlobal.BeginTrans;
   try
    Str := 'update MKT_REQUORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) +',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
           ' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and REQU_ID='''+Params.FindParam('REQU_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select RECV_MNY from ACC_RECVABLE_INFO where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('REQU_ID').asString+''' and RECV_TYPE=''5''';
      AGlobal.Open(rs);
      if (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('已经收款的单不能弃审...');
      AGlobal.ExecSQL('delete from ACC_RECVABLE_INFO where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('REQU_ID').asString+''' and RECV_TYPE=''5''');
    finally
      rs.Free;
    end;
    AGlobal.CommitTrans;
    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         AGlobal.RollbackTrans;
         Result := False;
         Msg := '反审核错误:'+E.Message;
       end;
  end;
end;

initialization
  RegisterClass(TMktRequOrder);
  RegisterClass(TMktRequData);
  RegisterClass(TMktRequOrderGetPrior);
  RegisterClass(TMktRequOrderGetNext);
  RegisterClass(TMktRequOrderAudit);
  RegisterClass(TMktRequOrderUnAudit);
finalization
  UnRegisterClass(TMktRequOrder);
  UnRegisterClass(TMktRequData);
  UnRegisterClass(TMktRequOrderGetPrior);
  UnRegisterClass(TMktRequOrderGetNext);
  UnRegisterClass(TMktRequOrderAudit);
  UnRegisterClass(TMktRequOrderUnAudit);
end.
 