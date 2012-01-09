unit ObjBondOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes, DB, ZDataSet,ZIntf,ObjCommon;
type
  TBondOrder=class(TZFactory)
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TBondData=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //所有记录处理完毕后,事务提交以前执行。
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TBondOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TBondOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TBondOrder }

function TBondOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TBondOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_F_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
  result := true;
end;

function TBondOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TBondOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('BOND_DATE').AsString);
  if FieldbyName('BOND_DATE').AsOldString <> '' then
     Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('BOND_DATE').AsOldString);
end;

function TBondOrder.CheckTimeStamp(aGlobal: IdbHelp;
  s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from MKT_BONDORDER where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and BOND_ID='''+FieldbyName('BOND_ID').AsString+'''';
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

procedure TBondOrder.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select je.*,e.CLIENT_NAME as CLIENT_ID_TEXT from ('+
  'select jd.*,d.USER_NAME as BOND_USER_TEXT from ('+
  'select jc.*,c.SHOP_NAME as SHOP_ID_TEXT from ('+
  'select A.BOND_ID,A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.BOND_TYPE,A.GLIDE_NO,A.CLIENT_ID,'+
  'A.BOND_DATE,A.BOND_USER,A.BOND_MNY,A.CHK_DATE,A.CHK_USER,A.REMARK,A.COMM,A.CREA_DATE,A.CREA_USER,A.TIME_STAMP '+
  'from MKT_BONDORDER A where A.TENANT_ID=:TENANT_ID and A.BOND_ID=:BOND_ID ) jc '+
  'left outer join CA_SHOP_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.SHOP_ID=c.SHOP_ID ) jd '+
  'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.BOND_USER=d.USER_ID ) je '+
  'left outer join VIW_CUSTOMER e on je.TENANT_ID=e.TENANT_ID and je.CLIENT_ID=e.CLIENT_ID';
  IsSQLUpdate := True;
  Str := 'insert into MKT_BONDORDER(TENANT_ID,BOND_ID,SHOP_ID,IORO_ID,DEPT_ID,BOND_TYPE,GLIDE_NO,BOND_DATE,CLIENT_ID,BOND_USER,CHK_DATE,CHK_USER,BOND_MNY,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:BOND_ID,:SHOP_ID,:IORO_ID,:DEPT_ID,:BOND_TYPE,:GLIDE_NO,:BOND_DATE,:CLIENT_ID,:BOND_USER,:CHK_DATE,:CHK_USER,:BOND_MNY,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update MKT_BONDORDER set TENANT_ID=:TENANT_ID,BOND_ID=:BOND_ID,SHOP_ID=:SHOP_ID,IORO_ID=:IORO_ID,DEPT_ID=:DEPT_ID,BOND_TYPE=:BOND_TYPE,GLIDE_NO=:GLIDE_NO,BOND_DATE=:BOND_DATE,'
    + 'CLIENT_ID=:CLIENT_ID,BOND_USER=:BOND_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,BOND_MNY=:BOND_MNY,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER, '
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where BOND_ID=:OLD_BOND_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from MKT_BONDORDER where BOND_ID=:OLD_BOND_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;

end;

{ TBondData }

function TBondData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TBondData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  r:integer;
begin
  result := true;
  Str := 'delete from MKT_BONDDATA where TENANT_ID=:OLD_TENANT_ID and BOND_ID=:OLD_BOND_ID and SEQNO=:OLD_SEQNO';
  AGlobal.ExecSQL(Str,self);
  if (FieldbyName('BOND_MNY').AsOldFloat=0)  then Exit;
  case FieldbyName('BOND_TYPE').AsOldInteger of
  1:
  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType ,
     'update MKT_PLANORDER set BOND_RET=round(isnull(BOND_RET,0)- :OLD_BOND_MNY,2),'+
     'COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where PLAN_ID=:OLD_FROM_ID and TENANT_ID=:OLD_TENANT_ID')
     ,self);
  2:
  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
        'update SAL_INDENTORDER set  BOND_RET=round(isnull(BOND_RET,0)- :OLD_BOND_MNY,2),'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where INDE_ID=:OLD_FROM_ID and TENANT_ID=:OLD_TENANT_ID'),self);
  end;
  result := true;
end;

function TBondData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  rs:TZQuery;
  r:integer;
begin
  result := true;
  Str := 'insert into MKT_BONDDATA(TENANT_ID,SHOP_ID,BOND_ID,SEQNO,FROM_ID,REMARK,BOND_MNY) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:BOND_ID,:SEQNO,:FROM_ID,:REMARK,:BOND_MNY)';
  AGlobal.ExecSQL(Str,self);
  if (FieldbyName('BOND_MNY').AsFloat=0)  then Exit;
  case FieldbyName('BOND_TYPE').AsInteger of
  1:
  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType ,
     'update MKT_PLANORDER set BOND_RET=round(isnull(BOND_RET,0)+ :BOND_MNY,2),'+
     'COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where PLAN_ID=:FROM_ID and TENANT_ID=:TENANT_ID')
     ,self);
  2:
  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
        'update SAL_INDENTORDER set  BOND_RET=round(isnull(BOND_RET,0)+ :BOND_MNY,2),'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where INDE_ID=:FROM_ID and TENANT_ID=:TENANT_ID'),self);
  end;
  rs := TZQuery.Create(nil);
  try
    rs.close;
    case FieldbyName('BOND_TYPE').AsInteger of
    1:rs.SQL.Text := 'select count(*) from MKT_PLANORDER where PLAN_ID=:FROM_ID and TENANT_ID=:TENANT_ID and BOND_RET>BOND_MNY';
    2:rs.SQL.Text := 'select count(*) from SAL_INDENTORDER where INDE_ID=:FROM_ID and TENANT_ID=:TENANT_ID and BOND_RET>BOND_MNY';
    end;
    rs.ParamByName('TENANT_ID').AsInteger :=  FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('FROM_ID').asString :=  FieldbyName('FROM_ID').asString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then Raise Exception.Create('"'+FieldbyName('REMARK').asString+'"余额不足不能申领.');  
  finally
    rs.Free;
  end;
end;

function TBondData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  result := true;
end;

function TBondData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select BOND_TYPE from MKT_BONDORDER where TENANT_ID=:TENANT_ID and BOND_ID=:BOND_ID';
    rs.Params.AssignValues(Params);
    AGlobal.Open(rs);
    case rs.Fields[0].AsInteger of
    1:begin
        SelectSQL.Text :=
        ParseSQL(AGlobal.iDbType ,
        'select jd.*,d.SHOP_NAME as SHOP_ID_TEXT from ('+
        'select jc.*,c.DEPT_NAME as DEPT_ID_TEXT from ('+
        'select 1 as A,A.FROM_ID,A.TENANT_ID,A.SHOP_ID,C.BOND_TYPE,B.SHOP_ID as D_SHOP_ID,B.DEPT_ID,A.BOND_ID,A.SEQNO,A.FROM_ID,'+
        'B.BOND_MNY as ACCT_MNY,(isnull(B.BOND_MNY,0)-isnull(B.BOND_RET,0))+A.BOND_MNY as RECK_MNY,A.BOND_MNY,(isnull(B.BOND_MNY,0)-isnull(B.BOND_RET,0)) as BALA_MNY,'+
        'A.REMARK,b.PLAN_DATE as ABLE_DATE '+
        'from MKT_BONDDATA A,MKT_PLANORDER B,MKT_BONDORDER C '+
        'where A.TENANT_ID=C.TENANT_ID and A.BOND_ID=C.BOND_ID and C.TENANT_ID=B.TENANT_ID and A.FROM_ID=B.PLAN_ID and A.TENANT_ID=:TENANT_ID and A.BOND_ID=:BOND_ID ) jc '+
        'left outer join CA_DEPT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.DEPT_ID=c.DEPT_ID ) jd '+
        'left outer join CA_SHOP_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.D_SHOP_ID=d.SHOP_ID ');
      end
    else
      begin
        SelectSQL.Text :=
        ParseSQL(AGlobal.iDbType ,
        'select jd.*,d.SHOP_NAME as SHOP_ID_TEXT from ('+
        'select jc.*,c.DEPT_NAME as DEPT_ID_TEXT from ('+
        'select 1 as A,A.FROM_ID,A.TENANT_ID,A.SHOP_ID,C.BOND_TYPE,B.SHOP_ID as D_SHOP_ID,B.DEPT_ID,A.BOND_ID,A.SEQNO,A.FROM_ID,'+
        'B.BOND_MNY as ACCT_MNY,(isnull(B.BOND_MNY,0)-isnull(B.BOND_RET,0))+A.BOND_MNY as RECK_MNY,A.BOND_MNY,(isnull(B.BOND_MNY,0)-isnull(B.BOND_RET,0)) as BALA_MNY,'+
        'A.REMARK,b.INDE_DATE as ABLE_DATE '+
        'from MKT_BONDDATA A,SAL_INDENTORDER B,MKT_BONDORDER C '+
        'where A.TENANT_ID=C.TENANT_ID and A.BOND_ID=C.BOND_ID and C.TENANT_ID=B.TENANT_ID and A.FROM_ID=B.INDE_ID and A.TENANT_ID=:TENANT_ID and A.BOND_ID=:BOND_ID ) jc '+
        'left outer join CA_DEPT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.DEPT_ID=c.DEPT_ID ) jd '+
        'left outer join CA_SHOP_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.D_SHOP_ID=d.SHOP_ID ');
      end;
    end;
  finally
    rs.Free;
  end;
end;

procedure TBondData.InitClass;
begin
  inherited;
  IsSQLUpdate := True;
end;

{ TBondOrderAudit }

function TBondOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  AGlobal.BeginTrans;
  try
    Str := 'update MKT_BONDORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and BOND_ID='''+Params.FindParam('BOND_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    AGlobal.ExecSQL(
           'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
         + 'select BOND_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,''返还保证金(申领单号:'''+GetStrJoin(AGlobal.iDbType)+'GLIDE_NO'+GetStrJoin(AGlobal.iDbType)+''')'',''5'',-BOND_MNY,0,0,-BOND_MNY,BOND_DATE,BOND_ID,'''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',:CHK_USER,''00'','+GetTimeStamp(AGlobal.iDbType)+' from MKT_BONDORDER where TENANT_ID=:TENANT_ID and BOND_ID=:BOND_ID'
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

{ TBondOrderUnAudit }

function TBondOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
   AGlobal.BeginTrans;
   try
    Str := 'update MKT_BONDORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and BOND_ID='''+Params.FindParam('BOND_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select RECV_MNY from ACC_RECVABLE_INFO where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('BOND_ID').asString+''' and RECV_TYPE=''5''';
      AGlobal.Open(rs);
      if (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('已经收款的单不能弃审...');
      AGlobal.ExecSQL('delete from ACC_RECVABLE_INFO where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('BOND_ID').asString+''' and RECV_TYPE=''5''');
    finally
      rs.Free;
    end;
    MSG := '反审核单据成功。';
    AGlobal.CommitTrans;
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
  RegisterClass(TBondOrder);
  RegisterClass(TBondData);
  RegisterClass(TBondOrderAudit);
  RegisterClass(TBondOrderUnAudit);
finalization
  UnRegisterClass(TBondOrder);
  UnRegisterClass(TBondData);
  UnRegisterClass(TBondOrderAudit);
  UnRegisterClass(TBondOrderUnAudit);
end.
