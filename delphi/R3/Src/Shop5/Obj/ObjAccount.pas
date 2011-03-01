unit ObjAccount;

interface
uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;
type
  TAccount=class(TZFactory)
  public
    procedure InitClass; override;
    function CheckReck(AGlobal:IdbHelp):boolean;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation
{ TAccount }

function TAccount.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select BALANCE from ACC_ACCOUNT_INFO where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID and SHOP_ID=:SHOP_ID';
    AGlobal.Open(rs);
    if rs.FieldByName('BALANCE').AsFloat <> 0 then
      Raise Exception.Create('此账户金额有变动,不能删除!');
  finally
    rs.Free;
  end;
  result := true;
end;

function TAccount.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ACCOUNT_ID,COMM from ACC_ACCOUNT_INFO where ACCT_NAME=:ACCT_NAME and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if Copy(rs.FieldbyName('COMM').AsString,2,1) = '2' then
          Begin
            FieldByName('ACCOUNT_ID').AsString := rs.FieldbyName('ACCOUNT_ID').AsString;
            AGlobal.ExecSQL('delete from ACC_ACCOUNT_INFO where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID',Self);
          end
        else
          Raise Exception.Create('此账户名已经存在,请重新输入..');
      end;
  finally
    rs.Free;
  end;
  Result:=True;
end;

function TAccount.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var  tmp:TZQuery;
     str:string;
begin
  result := true;
  if CheckReck(AGlobal) and (FieldbyName('ORG_MNY').AsFloat<>FieldbyName('ORG_MNY').AsOldFloat) then
     Raise Exception.Create('已经存在结账记录不能修改期初金额...');
  {tmp:=TZQuery.Create(self);
  try
    tmp.Close;
    tmp.SQL.Text:='select COMP_ID from RCK_ACCOUNT_INFO where COMP_ID='''+FieldByName('COMP_ID').AsString+''' and ACCOUNT_ID='''+FieldByName('ACCOUNT_ID').AsString+'''';
    AGlobal.Open(tmp);
    if tmp.RecordCount<=0 then
    begin
      Str := 'insert into RCK_ACCOUNT_INFO(COMP_ID,ACCOUNT_ID,ACCT_NAME,ACCT_SPELL,ACCOUNT_TYPE,ORG_MNY,OUT_MNY,IN_MNY,BAL_MNY,COMM,TIME_STAMP) '
        + 'VALUES('''+FieldByName('COMP_ID').AsString+''','''+FieldByName('ACCOUNT_ID').AsString+''','''+FieldByName('ACCT_NAME').AsString+''','''+FieldByName('ACCT_SPELL').AsString+''','''+FieldByName('ACCOUNT_TYPE').AsString+''',0,0,0,0,''00'','+GetTimeStamp(iDbType)+')';
      AGlobal.ExecSQL(str,self);
    end;
    Str := 'update RCK_ACCOUNT_INFO set COMP_ID=:COMP_ID,ACCOUNT_ID=:ACCOUNT_ID,ORG_MNY=:ORG_MNY,'
      +'BAL_MNY=isnull(BAL_MNY,0)+(isnull(:ORG_MNY,0)-isnull(:OLD_ORG_MNY,0)),'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)
      + ' where ACCOUNT_ID=:ACCOUNT_ID and COMP_ID=:COMP_ID';
    AGlobal.ExecSQL(str,self);
    Str := 'update RCK_ACCOUNT_INFO set COMP_ID=''----'',ACCOUNT_ID=:ACCOUNT_ID,ACCT_NAME=:ACCT_NAME,ACCT_SPELL=:ACCT_SPELL,ACCOUNT_TYPE=:ACCOUNT_TYPE,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)
      + ' where ACCOUNT_ID=:OLD_ACCOUNT_ID and COMP_ID=''----''';
    AGlobal.ExecSQL(str,self);
  finally
    tmp.Free;
  end;}
end;


function TAccount.CheckReck(AGlobal: IdbHelp): boolean;
var rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select * from ACC_RECVORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and ACCOUNT_ID=:ACCOUNT_ID';
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create('此账户在收款单据中有使用,不能删除!');

    rs.SQL.Text := 'select * from ACC_PAYORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and ACCOUNT_ID=:ACCOUNT_ID';
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create('此账户在付款单据中有使用,不能删除!');

    rs.SQL.Text := 'select * from ACC_TRANSORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and IN_ACCOUNT_ID=:ACCOUNT_ID and OUT_ACCOUNT_ID=:ACCOUNT_ID';
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create('此账户在存取款单据中有使用,不能删除!');

  finally
    rs.Free;
  end;
  Result := True;
end;

procedure TAccount.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='ACCOUNT_ID;TENANT_ID';

  Str := 'select TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE '+
  'from ACC_ACCOUNT_INFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID ';
  SelectSQL.Text := Str;
  IsSQLUpdate := True;
  Str := 'insert into ACC_ACCOUNT_INFO(TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,COMM,TIME_STAMP) '+
  'values(:TENANT_ID,:ACCOUNT_ID,:SHOP_ID,:ACCT_NAME,:ACCT_SPELL,:PAYM_ID,:ORG_MNY,:OUT_MNY,:IN_MNY,:BALANCE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update ACC_ACCOUNT_INFO set ACCT_NAME=:ACCT_NAME,ACCT_SPELL=:ACCT_SPELL,PAYM_ID=:PAYM_ID,ORG_MNY=:ORG_MNY,'+
  'OUT_MNY=:OUT_MNY,IN_MNY=:IN_MNY,BALANCE=:BALANCE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where COMM not in (''02'',''12'') and TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID and SHOP_ID=:OLD_SHOP_ID ';
  UpdateSQL.Text := Str;

  Str := 'update ACC_ACCOUNT_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where COMM not in (''02'',''12'') and TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID and SHOP_ID=:OLD_SHOP_ID ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TAccount);
finalization
  UnRegisterClass(TAccount);

end.
