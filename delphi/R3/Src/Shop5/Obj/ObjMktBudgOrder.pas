unit ObjMktBudgOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;

type
  TMktBudgOrder=class(TZFactory)
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
  TMktBudgData=class(TZFactory)
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
  TMktBudgShare=class(TZFactory)
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
  TMktBudgOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TMktBudgOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TMktBudgOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TMktBudgOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TMktBudgOrder }

function TMktBudgOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktBudgOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktBudgOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := False;
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('TENANT_ID').AsString+'0001',4)+GetSequence(AGlobal,'GNO_H_'+FieldbyName('TENANT_ID').AsString+'0001',FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
  Result := True;
end;

function TMktBudgOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktBudgOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktBudgOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from MKT_BUDGORDER where BUDG_ID='''+FieldbyName('BUDG_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString+'';
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

procedure TMktBudgOrder.InitClass;
var
  Str: string;
begin
  inherited;
  Locked := false;
  SelectSQL.Text :=
  'select A.TENANT_ID,A.BUDG_ID,A.GLIDE_NO,A.CLIENT_ID,B.CLIENT_NAME as CLIENT_ID_TEXT,A.SHOP_ID,D.SHOP_NAME as SHOP_ID_TEXT,A.REQU_TYPE,'+
  'A.DEPT_ID,C.DEPT_NAME as DEPT_ID_TEXT,A.BUDG_DATE,A.CHK_DATE,A.CHK_USER,F.USER_NAME as CHK_USER_TEXT,A.REQU_ID,A.REMARK,A.BUDG_VRF,'+
  'A.CREA_DATE,A.CREA_USER,E.USER_NAME as CREA_USER_TEXT,A.BUDG_USER,G.USER_NAME as BUDG_USER_TEXT,H.GLIDE_NO as REQU_ID_TEXT,A.COMM,A.TIME_STAMP '+
  ' from MKT_BUDGORDER A left join VIW_CUSTOMER B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
  ' left join CA_DEPT_INFO C on A.TENANT_ID=C.TENANT_ID and A.DEPT_ID=C.DEPT_ID '+
  ' left join CA_SHOP_INFO D on A.TENANT_ID=D.TENANT_ID and A.SHOP_ID=D.SHOP_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.CREA_USER=E.USER_ID '+
  ' left join VIW_USERS F on A.TENANT_ID=F.TENANT_ID and A.CHK_USER=F.USER_ID '+
  ' left join VIW_USERS G on A.TENANT_ID=G.TENANT_ID and A.BUDG_USER=G.USER_ID '+
  ' left join MKT_REQUORDER H on A.TENANT_ID=H.TENANT_ID and A.REQU_ID=H.REQU_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.BUDG_ID=:BUDG_ID ';
  IsSQLUpdate := True;
  Str := 'insert into MKT_BUDGORDER(TENANT_ID,BUDG_ID,GLIDE_NO,CLIENT_ID,SHOP_ID,REQU_TYPE,DEPT_ID,BUDG_DATE,BUDG_USER,BUDG_VRF,CHK_DATE,CHK_USER,REQU_ID,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:BUDG_ID,:GLIDE_NO,:CLIENT_ID,:SHOP_ID,:REQU_TYPE,:DEPT_ID,:BUDG_DATE,:BUDG_USER,:BUDG_VRF,:CHK_DATE,:CHK_USER,:REQU_ID,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update MKT_BUDGORDER set TENANT_ID=:TENANT_ID,BUDG_ID=:BUDG_ID,GLIDE_NO=:GLIDE_NO,CLIENT_ID=:CLIENT_ID,SHOP_ID=:SHOP_ID,REQU_TYPE=:REQU_TYPE,DEPT_ID=:DEPT_ID,BUDG_USER=:BUDG_USER,'+
         'BUDG_DATE=:BUDG_DATE,BUDG_VRF=:BUDG_VRF,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REQU_ID=:REQU_ID,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,'+
         'COMM=' + GetCommStr(iDbType) + ','+
         'TIME_STAMP='+GetTimeStamp(iDbType)+' '+
         'where TENANT_ID=:OLD_TENANT_ID and BUDG_ID=:OLD_BUDG_ID ';
  UpdateSQL.Text := Str;
  Str := ' delete from MKT_BUDGORDER where TENANT_ID=:OLD_TENANT_ID and BUDG_ID=:OLD_BUDG_ID ';
  DeleteSQL.Text := Str;
end;

{ TMktBudgData }

function TMktBudgData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktBudgData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktBudgData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktBudgData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMktBudgData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMktBudgData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select A.TENANT_ID,A.SHOP_ID,A.SEQNO,A.BUDG_ID,A.ACTIVE_ID,B.ACTIVE_NAME as ACTIVE_ID_TEXT,'+
  'A.KPI_ID,C.KPI_NAME as KPI_ID_TEXT,A.BUDG_VRF,A.REMARK '+
  ' from MKT_BUDGDATA A left join MKT_ACTIVE_INFO B on A.TENANT_ID=B.TENANT_ID and A.ACTIVE_ID=B.ACTIVE_ID '+
  ' left join MKT_KPI_INDEX C on A.TENANT_ID=B.TENANT_ID and A.KPI_ID=C.KPI_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.BUDG_ID=:BUDG_ID ';
  IsSQLUpdate := True;
  Str := 'insert into MKT_BUDGDATA(TENANT_ID,SHOP_ID,SEQNO,BUDG_ID,ACTIVE_ID,KPI_ID,BUDG_VRF,REMARK) '
    + 'values(:TENANT_ID,:SHOP_ID,:SEQNO,:BUDG_ID,:ACTIVE_ID,:KPI_ID,:BUDG_VRF,:REMARK)';
  InsertSQL.Text := Str;
  Str := 'update MKT_BUDGDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SEQNO=:SEQNO,BUDG_ID=:BUDG_ID,'+
         'ACTIVE_ID=:ACTIVE_ID,KPI_ID=:KPI_ID,BUDG_VRF=:BUDG_VRF,REMARK=:REMARK '+
         ' where TENANT_ID=:OLD_TENANT_ID and BUDG_ID=:OLD_BUDG_ID and SEQNO=:OLD_SEQNO ';
  UpdateSQL.Text := Str;
  Str := ' delete from MKT_BUDGDATA where TENANT_ID=:OLD_TENANT_ID and BUDG_ID=:OLD_BUDG_ID and SEQNO=:OLD_SEQNO ';
  DeleteSQL.Text := Str;
end;

{ TMktBudgOrderGetPrior }

procedure TMktBudgOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 BUDG_ID from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select BUDG_ID from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select BUDG_ID from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select BUDG_ID from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC limit 1';
  end;
end;

{ TMktBudgOrderGetNext }

procedure TMktBudgOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 BUDG_ID from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select BUDG_ID from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select BUDG_ID from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select BUDG_ID from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO limit 1';
  end;
end;

{ TMktBudgOrderAudit }

function TMktBudgOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  Str,ChkUser:string;
  n:Integer;
  rs:TZQuery;
begin
  AGlobal.BeginTrans;
  try
    Str := 'update MKT_BUDGORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and BUDG_ID='''+Params.FindParam('BUDG_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');

    ChkUser:=Params.ParamByName('CHK_USER').AsString;
    Str:=
      'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
      'select BUDG_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,''市场费用'''+GetStrJoin(AGlobal.iDbType)+'''(核销单号:'''+GetStrJoin(AGlobal.iDbType)+'GLIDE_NO'+GetStrJoin(AGlobal.iDbType)+''')'',''5'','+
      ' BUDG_VRF,0,0,BUDG_VRF,BUDG_DATE,BUDG_ID,'''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''','''+ChkUser+''' as CHK_USER,''00'','+GetTimeStamp(AGlobal.iDbType)+
      ' from MKT_BUDGORDER where TENANT_ID=:TENANT_ID and BUDG_ID=:BUDG_ID and REQU_TYPE=''2''';
    AGlobal.ExecSQL(Str,params);
    AGlobal.CommitTrans;

    Result := true;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '审核错误'+E.Message;
      end;
  end;
end;

{ TMktBudgOrderUnAudit }

function TMktBudgOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
  AGlobal.BeginTrans;
  try
    Str := 'update MKT_BUDGORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and BUDG_ID='''+Params.FindParam('BUDG_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');

    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select RECV_MNY from ACC_RECVABLE_INFO where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('BUDG_ID').asString+''' and RECV_TYPE=''5''';
      AGlobal.Open(rs);
      if (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('已经收款的单不能弃审...');
      AGlobal.ExecSQL('delete from ACC_RECVABLE_INFO where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('BUDG_ID').asString+''' and RECV_TYPE=''5''');
    finally
      rs.Free;
    end;
    AGlobal.CommitTrans;

    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '反审核错误:'+E.Message;
       end;
  end;
end;

{ TMktBudgShare }

function TMktBudgShare.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
  rs :TZQuery;
  s:string;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := ParseSQL(iDbType,' select A.KPI_ID,A.KPI_YEAR,B.KPI_NAME from MKT_REQUDATA A,MKT_KPI_INDEX B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.KPI_ID=B.KPI_ID and A.TENANT_ID=:TENANT_ID and A.REQU_ID=:REQU_ID and round(isnull(A.BUDG_MNY,0)-isnull(A.BUDG_VRF,0),2)<0 ');
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('REQU_ID').AsString := FieldByName('REQU_ID').AsString;
    AGlobal.Open(rs);
    if rs.IsEmpty then Exit;
    s := '';
    rs.First;
    while not rs.Eof do
       begin
         if s<>'' then s := s + #13;
         s := s+rs.Fields[2].AsString+' '+rs.Fields[1].AsString+'年';
         rs.Next;
       end;
    if s<>'' then
       Raise Exception.Create('以下指标的申领金额不足:'+#13+'"'+s+'" '+#13+'无法完成超额核销.');
  finally
    rs.Free;
  end;

end;

function TMktBudgShare.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var str:String;
begin
  Result := False;
  Str := 'delete from MKT_BUDGSHARE where TENANT_ID=:OLD_TENANT_ID and BUDG_ID=:OLD_BUDG_ID and SEQNO=:OLD_SEQNO';
  AGlobal.ExecSQL(str,Self);

  str := ' update MKT_REQUORDER set BUDG_VRF=round(isnull(BUDG_VRF,0)-:BUDG_VRF,2) '+
         ' where TENANT_ID=:TENANT_ID and REQU_ID=:REQU_ID ';
  AGlobal.ExecSQL(ParseSQL(iDbType,str),Self);

  str := ' update MKT_REQUDATA set BUDG_VRF=round(isnull(BUDG_VRF,0)-:OLD_BUDG_VRF,2) '+
         ' where TENANT_ID=:OLD_TENANT_ID and REQU_ID=:OLD_REQU_ID and KPI_ID=:OLD_KPI_ID and KPI_YEAR=:OLD_KPI_YEAR ';
  AGlobal.ExecSQL(ParseSQL(iDbType,str),Self);

  str := ' update MKT_KPI_RESULT set BUDG_VRF=round(isnull(BUDG_VRF,0)-:OLD_BUDG_VRF,2) '+
         ' where TENANT_ID=:OLD_TENANT_ID and KPI_ID=:OLD_KPI_ID and KPI_YEAR=:OLD_KPI_YEAR and CLIENT_ID=:OLD_CLIENT_ID';
  AGlobal.ExecSQL(ParseSQL(iDbType,str),Self);
  Result := True;
end;

function TMktBudgShare.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  str:String;
begin
  Result := False;
  Str := 'insert into MKT_BUDGSHARE(TENANT_ID,SEQNO,REQU_ID,BUDG_ID,KPI_ID,KPI_YEAR,BUDG_VRF) '
  + 'values(:TENANT_ID,:SEQNO,:REQU_ID,:BUDG_ID,:KPI_ID,:KPI_YEAR,:BUDG_VRF)';
  AGlobal.ExecSQL(str,Self);

  str := ' update MKT_REQUORDER set BUDG_VRF=round(isnull(BUDG_VRF,0)+:BUDG_VRF,2) '+
         ' where TENANT_ID=:TENANT_ID and REQU_ID=:REQU_ID ';
  AGlobal.ExecSQL(ParseSQL(iDbType,str),Self);

  str := ' update MKT_REQUDATA set BUDG_VRF=round(isnull(BUDG_VRF,0)+:BUDG_VRF,2) '+
         ' where TENANT_ID=:TENANT_ID and REQU_ID=:REQU_ID and KPI_ID=:KPI_ID and KPI_YEAR=:KPI_YEAR ';
  AGlobal.ExecSQL(ParseSQL(iDbType,str),Self);

  str := ' update MKT_KPI_RESULT set BUDG_VRF=round(isnull(BUDG_VRF,0)+:BUDG_VRF,2) '+
         ' where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and KPI_YEAR=:KPI_YEAR and CLIENT_ID=:CLIENT_ID';
  AGlobal.ExecSQL(ParseSQL(iDbType,str),Self);
  Result := True;
end;

function TMktBudgShare.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := BeforeDeleteRecord(AGlobal);
  Result := BeforeInsertRecord(AGlobal);
end;

function TMktBudgShare.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMktBudgShare.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  ' select A.TENANT_ID,A.SEQNO,A.REQU_ID,A.BUDG_ID,A.KPI_ID,A.KPI_YEAR,A.BUDG_VRF,B.CLIENT_ID from MKT_BUDGSHARE A,MKT_BUDGORDER B '+
  ' where A.TENANT_ID=B.TENANT_ID and A.BUDG_ID=B.BUDG_ID and A.TENANT_ID=:TENANT_ID and A.BUDG_ID=:BUDG_ID ';
  IsSQLUpdate := True;
end;

initialization
  RegisterClass(TMktBudgOrder);
  RegisterClass(TMktBudgData);
  RegisterClass(TMktBudgShare);
  RegisterClass(TMktBudgOrderGetPrior);
  RegisterClass(TMktBudgOrderGetNext);
  RegisterClass(TMktBudgOrderAudit);
  RegisterClass(TMktBudgOrderUnAudit);
finalization
  UnRegisterClass(TMktBudgOrder);
  UnRegisterClass(TMktBudgData);
  UnRegisterClass(TMktBudgShare);
  UnRegisterClass(TMktBudgOrderGetPrior);
  UnRegisterClass(TMktBudgOrderGetNext);
  UnRegisterClass(TMktBudgOrderAudit);
  UnRegisterClass(TMktBudgOrderUnAudit);
end.
