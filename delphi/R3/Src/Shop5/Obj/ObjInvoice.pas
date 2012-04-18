unit ObjInvoice;

interface
uses SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TInvoice=class(TZFactory)
  private
    //记录行集新增检测函数，返回值是True 则可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 则可以新增当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

implementation

{ TInvoice }

function TInvoice.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin  
  {rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ACCOUNT from CA_USERS where ACCOUNT=:ACCOUNT and TENANT_ID=:TENANT_ID';
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create(FieldbyName('ACCOUNT').AsString+'登录名已经被其他用户使用，请重新修改新的登录名...');
  finally
    rs.Free;
  end;}
  Result:=True;
end;

function TInvoice.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  {rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ACCOUNT from CA_USERS where ACCOUNT=:ACCOUNT and ACCOUNT<>:OLD_ACCOUNT ';
    AGlobal.Open(rs);
    if not rs.IsEmpty then Raise Exception.Create(FieldbyName('ACCOUNT').AsString+'登录名已经被其他用户使用，请重新修改新的登录名...');
  finally
    rs.Free;
  end;
  if FieldByName('SHOP_ID').AsString<>FieldByName('SHOP_ID').AsOldString then
  begin
    Str:='update CA_COMPRIGHT set COMP_ID='+QuotedStr(FieldByName('COMP_ID').AsString)+' where COMP_ID='''+FieldByName('COMP_ID').AsOldString+''' '
    +' and USER_ID='''+FieldByName('USER_ID').AsString+'''';
    AGlobal.ExecSQL(Str);
  end;}
  result := true;
end;

procedure TInvoice.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'INVH_NO;TENANT_ID';
  SelectSQL.Text := 'select TENANT_ID,INVH_ID,SHOP_ID,DEPT_ID,INVOICE_FLAG,CREA_USER,CREA_DATE,INVH_NO,BEGIN_NO,ENDED_NO,TOTAL_AMT,USING_AMT,CANCEL_AMT,'+
  'BALANCE,REMARK from SAL_INVOICE_BOOK where TENANT_ID = :TENANT_ID and INVH_ID = :INVH_ID order by CREA_DATE';
  IsSQLUpdate := True;

  Str := 'insert into SAL_INVOICE_BOOK(TENANT_ID,INVH_ID,SHOP_ID,DEPT_ID,INVOICE_FLAG,CREA_USER,CREA_DATE,INVH_NO,BEGIN_NO,ENDED_NO,TOTAL_AMT,USING_AMT,'+
  'CANCEL_AMT,BALANCE,REMARK,COMM,TIME_STAMP) values(:TENANT_ID,:INVH_ID,:SHOP_ID,:DEPT_ID,:INVOICE_FLAG,:CREA_USER,:CREA_DATE,:INVH_NO,:BEGIN_NO,'+
  ':ENDED_NO,:TOTAL_AMT,:USING_AMT,:CANCEL_AMT,:BALANCE,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text :=Str;

  Str := 'update SAL_INVOICE_BOOK set TENANT_ID=:TENANT_ID,INVH_ID=:INVH_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,INVOICE_FLAG=:INVOICE_FLAG,CREA_USER=:CREA_USER,'+
  'CREA_DATE=:CREA_DATE,INVH_NO=:INVH_NO,BEGIN_NO=:BEGIN_NO,ENDED_NO=:ENDED_NO,TOTAL_AMT=:TOTAL_AMT,USING_AMT=:USING_AMT,CANCEL_AMT=:CANCEL_AMT,BALANCE=:BALANCE,'+
  'REMARK=:REMARK,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:TENANT_ID and INVH_ID=:INVH_ID ';
  UpdateSQL.Text := Str;
  Str := 'update SAL_INVOICE_BOOK set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and INVH_ID=:OLD_INVH_ID';
  DeleteSQL.Text := Str;
end;


initialization
  RegisterClass(TInvoice);
finalization
  UnRegisterClass(TInvoice);
end.
