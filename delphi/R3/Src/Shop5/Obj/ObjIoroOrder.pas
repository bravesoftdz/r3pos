unit ObjIoroOrder;

interface
uses SysUtils,ZBase,Classes,ZDataSet,ZIntf,ObjCommon;
type
  TIoroOrder=class(TZFactory)
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TIoroData=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TIoroAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TIoroUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TIoroOrder }

function TIoroOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString) then Raise Exception.Create('当前账款已经被另一用户修改，你不能再删除。');
  result := true;
end;

function TIoroOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := GetSequence(AGlobal,'GNO_A_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
  result := true;
end;

function TIoroOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString) then Raise Exception.Create('当前账款已经被另一用户修改，你不能再保存。');
  result := true;
end;

function TIoroOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
        Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('IORO_DATE').AsString);
        if FieldbyName('IORO_DATE').AsOldString <> '' then
           Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('IORO_DATE').AsOldString);
        result := true;
      end
   else
      Result := true;
end;

function TIoroOrder.CheckTimeStamp(aGlobal: IdbHelp;
  s: string): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from ACC_IOROORDER where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and IORO_ID='''+FieldbyName('IORO_ID').AsString+'''';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s) and (copy(rs.Fields[1].asString,1,1)<>'1');
  finally
    rs.Free;
  end;
end;

procedure TIoroOrder.InitClass;
var
  Str: string;
begin
  inherited;
  case Params.ParamByName('IORO_TYPE').AsInteger of
  1:SelectSQL.Text :=
    'select jg.*,g.USER_NAME as CREA_USER_TEXT from ('+
    'select jf.*,f.SHOP_NAME as SHOP_ID_TEXT from ('+
    'select je.*,e.USER_NAME as IORO_USER_TEXT from ('+
    'select jd.*,d.CODE_NAME as ITEM_ID_TEXT from ('+
    'select jc.*,c.DEPT_NAME as DEPT_ID_TEXT from ('+
    'select A.*,B.CLIENT_NAME as CLIENT_ID_TEXT from ACC_IOROORDER A,VIW_CUSTOMER B where A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.TENANT_ID=:TENANT_ID and A.IORO_ID=:IORO_ID ) jc '+
    'left outer join CA_DEPT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.DEPT_ID=c.DEPT_ID ) jd '+
    'left outer join VIW_ITEM_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.ITEM_ID=d.CODE_ID ) je '+
    'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.IORO_USER=e.USER_ID) jf '+
    'left outer join CA_SHOP_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.SHOP_ID=f.SHOP_ID) jg '+
    'left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.CREA_USER=g.USER_ID ';
  2:SelectSQL.Text :=  //支出
    'select jg.*,g.USER_NAME as CREA_USER_TEXT from ('+
    'select jf.*,f.SHOP_NAME as SHOP_ID_TEXT from ('+
    'select je.*,e.USER_NAME as IORO_USER_TEXT from ('+
    'select jd.*,d.CODE_NAME as ITEM_ID_TEXT from ('+
    'select jc.*,c.DEPT_NAME as DEPT_ID_TEXT from ('+
    'select A.*,B.CLIENT_NAME as CLIENT_ID_TEXT from ACC_IOROORDER A,VIW_CLIENTINFO B where A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.TENANT_ID=:TENANT_ID and A.IORO_ID=:IORO_ID ) jc '+
    'left outer join CA_DEPT_INFO c on jc.TENANT_ID=c.TENANT_ID and jc.DEPT_ID=c.DEPT_ID ) jd '+
    'left outer join VIW_ITEM_INFO d on jd.TENANT_ID=d.TENANT_ID and jd.ITEM_ID=d.CODE_ID ) je '+
    'left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.IORO_USER=e.USER_ID) jf '+
    'left outer join CA_SHOP_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.SHOP_ID=f.SHOP_ID ) jg '+
    'left outer join VIW_USERS g on jg.TENANT_ID=g.TENANT_ID and jg.CREA_USER=g.USER_ID ';    
  end;

  Str := 'insert into ACC_IOROORDER(TENANT_ID,SHOP_ID,IORO_ID,GLIDE_NO,CLIENT_ID,ITEM_ID,DEPT_ID,IORO_TYPE,IORO_DATE,IORO_USER,IORO_MNY,CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:IORO_ID,:GLIDE_NO,:CLIENT_ID,:ITEM_ID,:DEPT_ID,:IORO_TYPE,:IORO_DATE,:IORO_USER,:IORO_MNY,:CHK_DATE,:CHK_USER,:REMARK,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update ACC_IOROORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,IORO_ID=:IORO_ID,GLIDE_NO=:GLIDE_NO,CLIENT_ID=:CLIENT_ID,ITEM_ID=:ITEM_ID,DEPT_ID=:DEPT_ID,IORO_TYPE=:IORO_TYPE,'+
      'IORO_DATE=:IORO_DATE,IORO_USER=:IORO_USER,IORO_MNY=:IORO_MNY,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:TENANT_ID and IORO_ID=:OLD_IORO_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from ACC_IOROORDER where TENANT_ID=:TENANT_ID and IORO_ID=:OLD_IORO_ID';
  DeleteSQL.Text := Str;
end;

{ TIoroData }

function TIoroData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  case FieldbyName('IORO_TYPE').AsOldInteger of
  1:
  AGlobal.ExecSQL(
        ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set IN_MNY=isnull(IN_MNY,0)-:OLD_IORO_MNY,BALANCE=isnull(BALANCE,0)-:OLD_IORO_MNY,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID'),self);
  2:
  AGlobal.ExecSQL(
        ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set OUT_MNY=isnull(OUT_MNY,0)-:OLD_IORO_MNY,BALANCE=isnull(BALANCE,0)+:OLD_IORO_MNY,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID'),self);
  end;
  result := true;
end;

function TIoroData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  case FieldbyName('IORO_TYPE').AsInteger of
  1:
  AGlobal.ExecSQL(
        ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set IN_MNY=isnull(IN_MNY,0)+:IORO_MNY,BALANCE=isnull(BALANCE,0)+:IORO_MNY,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),self);
  2:
  AGlobal.ExecSQL(
        ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set OUT_MNY=isnull(OUT_MNY,0)+:IORO_MNY,BALANCE=isnull(BALANCE,0)-:IORO_MNY,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),self);
  end;
  result := true;
end;

function TIoroData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  result := true;
end;

procedure TIoroData.InitClass;
var
  Str: string;
begin
  inherited;
   SelectSQL.Text :=  //收入
    'select jd.*,d.CODE_NAME as PAYM_ID_TEXT from ('+
    'select j.*,c.ACCT_NAME as ACCOUNT_ID_TEXT from ('+
    'select A.TENANT_ID,A.SHOP_ID,A.IORO_ID,A.PAYM_ID,A.BILL_NO,A.SEQNO,A.ACCOUNT_ID,A.IORO_INFO,A.IORO_MNY,B.IORO_TYPE '+
    'from ACC_IORODATA A,ACC_IOROORDER B where A.TENANT_ID=B.TENANT_ID and A.IORO_ID=B.IORO_ID and A.TENANT_ID=:TENANT_ID and A.IORO_ID=:IORO_ID ) j '+
    'left outer join VIW_ACCOUNT_INFO c on j.TENANT_ID=c.TENANT_ID and j.ACCOUNT_ID=c.ACCOUNT_ID) jd '+
    'left outer join PUB_CODE_INFO d on jd.PAYM_ID=d.CODE_ID and d.CODE_TYPE=''1'' order by jd.SEQNO';

  IsSQLUpdate := True;
  Str := 'insert into ACC_IORODATA(TENANT_ID,SHOP_ID,PAYM_ID,BILL_NO,IORO_ID,SEQNO,ACCOUNT_ID,IORO_INFO,IORO_MNY) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:PAYM_ID,:BILL_NO,:IORO_ID,:SEQNO,:ACCOUNT_ID,:IORO_INFO,:IORO_MNY)';
  InsertSQL.Text := Str;
  Str := 'update ACC_IORODATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,PAYM_ID=:PAYM_ID,BILL_NO=:BILL_NO,IORO_ID=:IORO_ID,SEQNO=:SEQNO,ACCOUNT_ID=:ACCOUNT_ID,IORO_INFO=:IORO_INFO,IORO_MNY=:IORO_MNY '
    + 'where TENANT_ID=:OLD_TENANT_ID and IORO_ID=:OLD_IORO_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := Str;
  Str := 'delete from ACC_IORODATA where TENANT_ID=:OLD_TENANT_ID and IORO_ID=:OLD_IORO_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := Str;
end;

{ TIoroAudit }

function TIoroAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  try
    Str :=
    'update ACC_IOROORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+
    ''',COMM=' + GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
    '  where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and IORO_ID='''+Params.FindParam('IORO_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('审核指令会影响多行，可能数据库中数据误。');
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

{ TIoroUnAudit }

function TIoroUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  try
    Str := 'update ACC_IOROORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) +
    ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  where TENANT_ID='+Params.FindParam('TENANT_ID').asString +
    ' and IORO_ID='''+Params.FindParam('IORO_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('弃审指令会影响多行，可能数据库中数据误。');
    Result := true;
    Msg := '弃审单据成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '弃审错误'+E.Message;
      end;
  end;
end;

initialization
  RegisterClass(TIoroOrder);
  RegisterClass(TIoroData);
  RegisterClass(TIoroAudit);
  RegisterClass(TIoroUnAudit);
finalization
  UnRegisterClass(TIoroOrder);
  UnRegisterClass(TIoroData);
  UnRegisterClass(TIoroAudit);
  UnRegisterClass(TIoroUnAudit);
end.
