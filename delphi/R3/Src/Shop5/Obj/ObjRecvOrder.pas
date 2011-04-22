unit ObjRecvOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes, DB, ZDataSet,ZIntf,ObjCommon;
type
  TRecvOrder=class(TZFactory)
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
  TRecvData=class(TZFactory)
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
  TRecvOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TRecvOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TRECVOrder }

function TRecvOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前帐款已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TRecvOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := GetSequence(AGlobal,'GNO_5_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
  result := true;
end;

function TRecvOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前帐款已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TRecvOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
        Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('RECV_DATE').AsString);
        if FieldbyName('RECV_DATE').AsOldString <> '' then
           Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('RECV_DATE').AsOldString);
        if (FieldbyName('PAYM_ID').AsString = 'A')
           or
           (FieldbyName('PAYM_ID').AsOldString = 'A')
        then  //已经结账不能操作现金收款
        begin
          rs := TZQuery.Create(nil);
          try
            rs.SQL.Text := 'select * from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLSE_DATE in (:CLSE_DATE ,:OLD_CLSE_DATE ) and CREA_USER=:CREA_USER';
            rs.Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
            rs.Params.ParamByName('SHOP_ID').asString := FieldbyName('SHOP_ID').AsString;
            rs.Params.ParamByName('CLSE_DATE').AsInteger := FieldbyName('RECV_DATE').AsInteger;
            rs.Params.ParamByName('OLD_CLSE_DATE').AsInteger := FieldbyName('RECV_DATE').AsOldInteger;
            rs.Params.ParamByName('CREA_USER').asString := FieldbyName('CREA_USER').AsString;
            AGlobal.Open(rs);
            if not rs.IsEmpty then Raise Exception.Create('当前收款人在'+FieldbyName('RECV_DATE').AsString+'已经交班结账不能开现金收款.');
          finally
            rs.Free;
          end;
        end;
        result := true;
      end
   else        
      Result := true;
end;

function TRecvOrder.CheckTimeStamp(aGlobal: IdbHelp;
  s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from ACC_RECVORDER where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and RECV_ID='''+FieldbyName('RECV_ID').AsString+'''';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TRecvOrder.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select je.*,e.CLIENT_NAME as CLIENT_ID_TEXT from ('+
  'select jd.*,d.USER_NAME as RECV_USER_TEXT from ('+
  'select jc.*,c.CODE_NAME as ITEM_ID_TEXT from ('+
  'select A.RECV_ID,A.TENANT_ID,A.SHOP_ID,A.GLIDE_NO,A.ACCOUNT_ID,A.PAYM_ID,A.BANK_ID,A.BANK_CODE,A.CLIENT_ID,B.ACCT_NAME as ACCOUNT_ID_TEXT,A.ITEM_ID,'+
  'A.RECV_DATE,A.RECV_USER,A.RECV_MNY,A.CHK_DATE,A.CHK_USER,A.REMARK,A.COMM,A.CREA_DATE,A.CREA_USER,A.BILL_NO,A.TIME_STAMP '+
  'from ACC_RECVORDER A,VIW_ACCOUNT_INFO B where A.TENANT_ID=B.TENANT_ID and A.ACCOUNT_ID=B.ACCOUNT_ID and A.TENANT_ID=:TENANT_ID and A.RECV_ID=:RECV_ID ) jc '+
  'left outer join VIW_ITEM_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.ITEM_ID=c.CODE_ID ) jd '+
  'left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.RECV_USER=d.USER_ID ) je '+
  'left outer join VIW_CUSTOMER e on je.TENANT_ID=e.TENANT_ID and je.CLIENT_ID=e.CLIENT_ID';
  IsSQLUpdate := True;
  Str := 'insert into ACC_RECVORDER(TENANT_ID,RECV_ID,SHOP_ID,GLIDE_NO,ACCOUNT_ID,PAYM_ID,BANK_ID,BANK_CODE,RECV_MNY,CLIENT_ID,ITEM_ID,RECV_DATE,RECV_USER,CHK_DATE,CHK_USER,COMM,CREA_DATE,CREA_USER,BILL_NO,REMARK,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:RECV_ID,:SHOP_ID,:GLIDE_NO,:ACCOUNT_ID,:PAYM_ID,:BANK_ID,:BANK_CODE,:RECV_MNY,:CLIENT_ID,:ITEM_ID,:RECV_DATE,:RECV_USER,:CHK_DATE,:CHK_USER,''00'','+GetSysDateFormat(iDbType)+',:CREA_USER,:BILL_NO,:REMARK,'+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update ACC_RECVORDER set TENANT_ID=:TENANT_ID,RECV_ID=:RECV_ID,SHOP_ID=:SHOP_ID,GLIDE_NO=:GLIDE_NO,ACCOUNT_ID=:ACCOUNT_ID,PAYM_ID=:PAYM_ID,BANK_ID=:BANK_ID,BANK_CODE=:BANK_CODE,CLIENT_ID=:CLIENT_ID,ITEM_ID=:ITEM_ID,'+
      'RECV_DATE=:RECV_DATE,RECV_USER=:RECV_USER,RECV_MNY=:RECV_MNY,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,BILL_NO=:BILL_NO, '
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where RECV_ID=:OLD_RECV_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from ACC_RECVORDER where RECV_ID=:OLD_RECV_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;

end;

{ TRECVData }

function TRecvData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
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
     'from ACC_RECVABLE_INFO A,VIW_CUSTOMER B,ACC_RECVDATA C '+
     'where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=C.TENANT_ID and A.ABLE_ID=C.ABLE_ID and C.TENANT_ID=:TENANT_ID and C.RECV_ID=:RECV_ID '+
     'and abs(A.ACCT_MNY)<abs(isnull(A.RECV_MNY,0)+isnull(A.REVE_MNY,0))');
    rs.Params.ParamByName('TENANT_ID').asInteger := FieldbyName('TENANT_ID').asInteger;
    rs.Params.ParamByName('RECV_ID').AsString := FieldbyName('RECV_ID').AsString;
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
    if s<>'' then Raise Exception.Create('以下帐款:'+s+' 本次收款金额大于余额,无法完成收款');
  finally
    rs.Free;
  end;
  result := true;
end;

function TRecvData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  r:integer;
begin
  result := true;
  Str := 'delete from ACC_RECVDATA where TENANT_ID=:TENANT_ID and RECV_ID=:OLD_RECV_ID and SEQNO=:OLD_SEQNO';
  AGlobal.ExecSQL(Str,self);
  if (FieldbyName('RECV_MNY').AsOldFloat=0)  then Exit;
  AGlobal.ExecSQL(
    ParseSQL(AGlobal.iDbType,'update ACC_RECVABLE_INFO set RECV_MNY=isnull(RECV_MNY,0)-isnull(:OLD_RECV_MNY,0),RECK_MNY=isnull(RECK_MNY,0)+isnull(:OLD_RECV_MNY,0) ,COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where TENANT_ID=:OLD_TENANT_ID and ABLE_ID=:OLD_ABLE_ID')
    ,self);

  AGlobal.ExecSQL(
      ParseSQL(AGlobal.iDbType,
      'update ACC_ACCOUNT_INFO set IN_MNY=isnull(IN_MNY,0)- :OLD_RECV_MNY,BALANCE=isnull(BALANCE,0)- :OLD_RECV_MNY,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where ACCOUNT_ID=:OLD_ACCOUNT_ID and TENANT_ID=:OLD_TENANT_ID')
      ,self);
  result := true;
end;

function TRecvData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  rs:TZQuery;
  r:integer;
begin
  result := true;
  if (FieldbyName('RECV_MNY').AsFloat=0) then Exit;
  Str := 'insert into ACC_RECVDATA(TENANT_ID,SHOP_ID,RECV_ID,SEQNO,ABLE_ID,RECV_TYPE,RECV_MNY) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:RECV_ID,:SEQNO,:ABLE_ID,:RECV_TYPE,:RECV_MNY)';
  AGlobal.ExecSQL(Str,self);
  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType ,
     'update ACC_RECVABLE_INFO set NEAR_DATE='''+formatDatetime('YYYY-MM-DD',now())+''',RECV_MNY=isnull(RECV_MNY,0)+isnull(:RECV_MNY,0),'+
     'RECK_MNY=isnull(RECK_MNY,0)-isnull(:RECV_MNY,0),COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+'  where ABLE_ID=:ABLE_ID and TENANT_ID=:TENANT_ID')
     ,self);

  AGlobal.ExecSQL(
     ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set IN_MNY=isnull(IN_MNY,0)+:RECV_MNY,BALANCE=isnull(BALANCE,0)+:RECV_MNY,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where ACCOUNT_ID=:ACCOUNT_ID and TENANT_ID=:TENANT_ID'),self);
end;

function TRecvData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  result := true;
end;

procedure TRecvData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select jd.*,d.SHOP_NAME as SHOP_ID_TEXT from ('+
  'select jc.*,c.CLIENT_NAME as CLIENT_ID_TEXT from ('+
  'select case when A.RECV_MNY=0 then 0 else 1 end as A,A.TENANT_ID,A.SHOP_ID,A.RECV_ID,A.SEQNO,A.ABLE_ID,A.RECV_TYPE,'+
  'B.ACCT_MNY,B.RECK_MNY+A.RECV_MNY as RECK_MNY,A.RECV_MNY,B.RECK_MNY as BALA_MNY,'+
  'b.ACCT_INFO,b.CLIENT_ID,b.ABLE_DATE,C.ACCOUNT_ID '+
  'from ACC_RECVDATA A,ACC_RECVABLE_INFO B,ACC_RECVORDER C '+
  'where A.TENANT_ID=C.TENANT_ID and A.RECV_ID=C.RECV_ID and A.TENANT_ID=B.TENANT_ID and A.ABLE_ID=B.ABLE_ID and A.TENANT_ID=:TENANT_ID and A.RECV_ID=:RECV_ID ) jc '+
  'left outer join VIW_CUSTOMER c on jc.TENANT_ID=c.TENANT_ID and jc.CLIENT_ID=c.CLIENT_ID ) jd '+
  'left outer join CA_SHOP_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.SHOP_ID=d.SHOP_ID ';
  IsSQLUpdate := True;
end;

{ TRecvOrderAudit }

function TRecvOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  try
    Str := 'update ACC_RECVORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and RECV_ID='''+Params.FindParam('RECV_ID').asString+''' and CHK_DATE IS NULL';
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

{ TRecvOrderUnAudit }

function TRecvOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
begin
   try
    Str := 'update ACC_RECVORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and RECV_ID='''+Params.FindParam('RECV_ID').asString+''' and CHK_DATE IS NOT NULL';
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
  RegisterClass(TRecvOrder);
  RegisterClass(TRecvData);
  RegisterClass(TRecvOrderAudit);
  RegisterClass(TRecvOrderUnAudit);
finalization
  UnRegisterClass(TRecvOrder);
  UnRegisterClass(TRecvData);
  UnRegisterClass(TRecvOrderAudit);
  UnRegisterClass(TRecvOrderUnAudit);
end.
