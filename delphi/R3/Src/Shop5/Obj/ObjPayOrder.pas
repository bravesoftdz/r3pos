unit ObjPayOrder;

interface
uses Dialogs,SysUtils,zBase,Classes,DB, ZDataSet,zIntf,ObjCommon;
type
  TPayOrder=class(TZFactory)
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
  TPayData=class(TZFactory)
  public
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
  TPayOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TPayOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TPayOrder }

function TPayOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前帐款已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TPayOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_4_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
  result := true;
end;

function TPayOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前帐款已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TPayOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
        Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('PAY_DATE').AsString);
        if FieldbyName('PAY_DATE').AsOldString <> '' then
           Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('PAY_DATE').AsOldString);
        result := true;
      end
   else  
  Result := true;
end;

function TPayOrder.CheckTimeStamp(aGlobal: IdbHelp;
  s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from ACC_PAYORDER where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and PAY_ID='''+FieldbyName('PAY_ID').AsString+'''';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TPayOrder.InitClass;
var
  Str: string;
begin
  inherited;
   SelectSQL.Text :=
  'select je.*,e.CLIENT_NAME as CLIENT_ID_TEXT from ('+
  'select jd.*,d.USER_NAME as PAY_USER_TEXT from ('+
  'select jc.*,c.CODE_NAME as ITEM_ID_TEXT from ('+
  'select A.PAY_ID,A.SHOP_ID,A.TENANT_ID,A.GLIDE_NO,A.CLIENT_ID,A.ACCOUNT_ID,B.ACCT_NAME as ACCOUNT_ID_TEXT,A.PAYM_ID,A.PAY_MNY,A.ITEM_ID,A.PAY_DATE,A.PAY_USER,A.CHK_DATE,A.CHK_USER,A.REMARK,A.COMM,A.CREA_DATE,A.BILL_NO,A.CREA_USER,A.TIME_STAMP '+
  'from ACC_PAYORDER A,VIW_ACCOUNT_INFO B where A.ACCOUNT_ID=B.ACCOUNT_ID and A.TENANT_ID=B.TENANT_ID and A.TENANT_ID=:TENANT_ID and A.PAY_ID=:PAY_ID ) jc '+
  'left outer join VIW_ITEM_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.ITEM_ID=c.CODE_ID ) jd '+
  'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.PAY_USER=d.USER_ID ) je '+
  'left outer join VIW_CLIENTINFO e on je.TENANT_ID=e.TENANT_ID and je.CLIENT_ID=e.CLIENT_ID';
  IsSQLUpdate := True;
  Str := 'insert into ACC_PAYORDER(PAY_ID,TENANT_ID,SHOP_ID,GLIDE_NO,ACCOUNT_ID,PAYM_ID,PAY_MNY,CLIENT_ID,ITEM_ID,PAY_DATE,PAY_USER,CHK_DATE,CHK_USER,COMM,CREA_DATE,CREA_USER,BILL_NO,REMARK,TIME_STAMP) '
    + 'VALUES(:PAY_ID,:TENANT_ID,:SHOP_ID,:GLIDE_NO,:ACCOUNT_ID,:PAYM_ID,:PAY_MNY,:CLIENT_ID,:ITEM_ID,:PAY_DATE,:PAY_USER,:CHK_DATE,:CHK_USER,''00'',:CREA_DATE,:CREA_USER,:BILL_NO,:REMARK,'+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update ACC_PAYORDER set PAY_ID=:PAY_ID,TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,GLIDE_NO=:GLIDE_NO,ACCOUNT_ID=:ACCOUNT_ID,PAYM_ID=:PAYM_ID,CLIENT_ID=:CLIENT_ID,ITEM_ID=:ITEM_ID,PAY_DATE=:PAY_DATE,'+
         'PAY_USER=:PAY_USER,PAY_MNY=:PAY_MNY,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,BILL_NO=:BILL_NO,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where PAY_ID=:OLD_PAY_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from ACC_PAYORDER where PAY_ID=:OLD_PAY_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;

{ TPayData }

function TPayData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  s:string;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
     ParseSQL(AGlobal.iDbType,
     'select A.ACCT_INFO,B.CLIENT_NAME as CLIENT_ID_TEXT,A.RECK_MNY '+
     'from ACC_PAYABLE_INFO A,VIW_CLIENTINFO B,ACC_PAYDATA C '+
     'where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=C.TENANT_ID and A.ABLE_ID=C.ABLE_ID and C.TENANT_ID=:TENANT_ID and C.PAY_ID=:PAY_ID '+
     'and abs(A.ACCT_MNY)<abs(isnull(A.PAYM_MNY,0)+isnull(A.REVE_MNY,0))');
    rs.Params.ParamByName('TENANT_ID').asInteger := FieldbyName('TENANT_ID').asInteger;
    rs.Params.ParamByName('PAY_ID').AsString := FieldbyName('PAY_ID').AsString;
    AGlobal.Open(rs);
    s := '';
    if not rs.IsEmpty then
       begin
         rs.First;
         while not rs.Eof do
           begin
             s := s + '['+rs.FieldbyName('CLIENT_ID_TEXT').AsString+']'+rs.FieldbyName('ACCT_INFO').AsString+#13;
             rs.Next;
           end;
       end;
    if s<>'' then Raise Exception.Create('以下帐款:'+s+' 本次付款金额大于余额,无法完成付款');
  finally
    rs.Free;
  end;
  result := true;
end;

function TPayData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  result := true;
  Str := 'delete from ACC_PAYDATA where PAY_ID=:OLD_PAY_ID and TENANT_ID=:OLD_TENANT_ID and SEQNO=:OLD_SEQNO';
  AGlobal.ExecSQL(Str,self);
  if (FieldbyName('PAY_MNY').AsOldFloat=0) then Exit;
  AGlobal.ExecSQL(
    ParseSQL(AGlobal.iDbType,
    'update ACC_PAYABLE_INFO set PAYM_MNY=round(isnull(PAYM_MNY,0)-:OLD_PAY_MNY,2),RECK_MNY=round(isnull(RECK_MNY,0)+:OLD_PAY_MNY,2),COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where TENANT_ID=:OLD_TENANT_ID and ABLE_ID=:OLD_ABLE_ID'),self);

  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
     'update ACC_ACCOUNT_INFO set OUT_MNY=round(isnull(OUT_MNY,0)- :OLD_PAY_MNY,2),BALANCE=round(isnull(BALANCE,0)+ :OLD_PAY_MNY,2),'
      + 'COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
        'where ACCOUNT_ID=:OLD_ACCOUNT_ID and TENANT_ID=:OLD_TENANT_ID '),self);
  result := true;
end;

function TPayData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  result := true;
  if (FieldbyName('PAY_MNY').AsFloat=0) then Exit;
  Str := 'insert into ACC_PAYDATA(TENANT_ID,SHOP_ID,PAY_ID,SEQNO,ABLE_ID,ABLE_TYPE,PAY_MNY) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:PAY_ID,:SEQNO,:ABLE_ID,:ABLE_TYPE,:PAY_MNY)';
  AGlobal.ExecSQL(Str,self);

  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
     'update ACC_PAYABLE_INFO set NEAR_DATE='''+formatDatetime('YYYY-MM-DD',now())+''',PAYM_MNY=round(isnull(PAYM_MNY,0)+:PAY_MNY,2),'+
        'RECK_MNY=round(isnull(RECK_MNY,0)-:PAY_MNY,2) ,COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where ABLE_ID=:ABLE_ID and TENANT_ID=:TENANT_ID'),self);

  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
     'update ACC_ACCOUNT_INFO set OUT_MNY=round(isnull(OUT_MNY,0)+:PAY_MNY,2),BALANCE=round(isnull(BALANCE,0)- :PAY_MNY,2),'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where ACCOUNT_ID=:ACCOUNT_ID and TENANT_ID=:TENANT_ID'),self);
  result := true;
  
end;

function TPayData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  result := true;
end;

procedure TPayData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select jd.*,d.SHOP_NAME as SHOP_ID_TEXT from ('+
  'select jc.*,c.CLIENT_NAME as CLIENT_ID_TEXT from ('+
  'select case when A.PAY_MNY=0 then 0 else 1 end as A,A.TENANT_ID,A.SHOP_ID,A.PAY_ID,A.SEQNO,A.ABLE_ID,A.ABLE_TYPE,'+
  'B.ACCT_MNY,B.RECK_MNY+A.PAY_MNY as RECK_MNY,A.PAY_MNY,B.RECK_MNY as BALA_MNY,'+
  'b.ACCT_INFO,b.CLIENT_ID,C.ACCOUNT_ID,b.ABLE_DATE '+
  'from ACC_PAYDATA A,ACC_PAYORDER C,ACC_PAYABLE_INFO B '+
  'where A.TENANT_ID=C.TENANT_ID and A.PAY_ID=C.PAY_ID and A.ABLE_ID=B.ABLE_ID and A.TENANT_ID=B.TENANT_ID and A.TENANT_ID=:TENANT_ID and A.PAY_ID=:PAY_ID ) jc '+
  'left outer join VIW_CLIENTINFO c on jc.CLIENT_ID=c.CLIENT_ID and jc.TENANT_ID=c.TENANT_ID ) jd '+
  'left outer join CA_SHOP_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.SHOP_ID=d.SHOP_ID ';
  IsSQLUpdate := True;
end;

{ TPayOrderAudit }

function TPayOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  try
    Str := 'update ACC_PAYORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and PAY_ID='''+Params.FindParam('PAY_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
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

{ TPayOrderUnAudit }

function TPayOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
begin
   try
    Str := 'update ACC_PAYORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and PAY_ID='''+Params.FindParam('PAY_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
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

initialization
  RegisterClass(TPayOrder);
  RegisterClass(TPayData);
  RegisterClass(TPayOrderAudit);
  RegisterClass(TPayOrderUnAudit);
finalization
  UnRegisterClass(TPayOrder);
  UnRegisterClass(TPayData);
  UnRegisterClass(TPayOrderAudit);
  UnRegisterClass(TPayOrderUnAudit);
end.
