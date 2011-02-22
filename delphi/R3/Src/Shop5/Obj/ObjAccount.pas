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
  TAccountDelete=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation
{ TAccount }

function TAccount.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TAccount.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  Result:=True;
end;

function TAccount.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var  tmp:TZQuery;
     str:string;
begin
  result := true;
  if CheckReck(AGlobal) and (FieldbyName('ORG_MNY').AsFloat<>FieldbyName('ORG_MNY').AsOldFloat) then
     Raise Exception.Create('已经存在结帐记录不能修改期初金额...');
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
var
  rs:TZQuery;
begin
  Result := False;
  {rs :=TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select top 1 PRINT_ID from STO_PRINTORDER where COMP_ID='''+FieldbyName('COMP_ID').AsString+'''';
    AGlobal.Open(rs);
    result := not rs.IsEmpty; 
  finally
    rs.Free;
  end;}
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

  Str := 'update ACC_ACCOUNT_INFO set SHOP_ID=:SHOP_ID,ACCT_NAME=:ACCT_NAME,ACCT_SPELL=:ACCT_SPELL,PAYM_ID=:PAYM_ID,ORG_MNY=:ORG_MNY,'+
  'OUT_MNY=:OUT_MNY,IN_MNY=:IN_MNY,BALANCE=:BALANCE,TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID';
  UpdateSQL.Text := Str;

  Str := 'update ACC_ACCOUNT_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID';
  DeleteSQL.Text := Str;
end;

{ TAccountDelete }

function TAccountDelete.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var tmp:TZQuery;
begin
  Result:=False;
  tmp:=TZQuery.Create(nil);
  tmp.Close;
  tmp.SQL.Text:='select top 1 ACCOUNT_ID from RCK_PAYORDER where ACCOUNT_ID='+QuotedStr(Params.ParamByName('ACCOUNT_ID').asString);
  AGlobal.Open(tmp);
  if tmp.RecordCount>0 then Raise Exception.Create('此帐户已被使用，不能删除！');
  AGlobal.BeginTrans;
  try
    AGlobal.ExecSQL('update RCK_ACCOUNT_INFO set  COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where ACCOUNT_ID='+QuotedStr(Params.ParamByName('ACCOUNT_ID').asString));
    AGlobal.CommitTrans;
    Result:=True;
  except
    on E:Exception do
       begin
         Msg := E.Message;
         AGlobal.RollBackTrans;
       end;
  end;

end;

initialization
  RegisterClass(TAccount);
  RegisterClass(TAccountDelete);
finalization
  UnRegisterClass(TAccount);
  UnRegisterClass(TAccountDelete);
end.
