unit ObjInvoice;

interface
uses SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TInvoice=class(TZFactory)
  private
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True �����������ǰ��¼
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
      Raise Exception.Create(FieldbyName('ACCOUNT').AsString+'��¼���Ѿ��������û�ʹ�ã��������޸��µĵ�¼��...');
  finally
    rs.Free;
  end;}
  Result:=True;
end;

function TInvoice.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

  result := true;
end;

procedure TInvoice.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'INVH_NO;TENANT_ID';
  SelectSQL.Text := 'select TENANT_ID,INVH_ID,SHOP_ID,DEPT_ID,INVOICE_FLAG,CREA_USER,CREA_DATE,INVH_NO,BEGIN_NO,ENDED_NO,TOTAL_AMT,USING_AMT,CANCEL_AMT,'+
  'CURRENT_NO,BALANCE,REMARK from SAL_INVOICE_BOOK where TENANT_ID = :TENANT_ID and INVH_ID = :INVH_ID order by CREA_DATE';
  IsSQLUpdate := True;

  Str := 'insert into SAL_INVOICE_BOOK(TENANT_ID,INVH_ID,SHOP_ID,DEPT_ID,INVOICE_FLAG,CREA_USER,CREA_DATE,INVH_NO,BEGIN_NO,ENDED_NO,USING_AMT,CANCEL_AMT,TOTAL_AMT,'+
  'BALANCE,REMARK,COMM,TIME_STAMP) values(:TENANT_ID,:INVH_ID,:SHOP_ID,:DEPT_ID,:INVOICE_FLAG,:CREA_USER,:CREA_DATE,:INVH_NO,:BEGIN_NO,'+
  ':ENDED_NO,0,0,:TOTAL_AMT,:TOTAL_AMT,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text :=Str;

  Str := 'update SAL_INVOICE_BOOK set TENANT_ID=:TENANT_ID,INVH_ID=:INVH_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,INVOICE_FLAG=:INVOICE_FLAG,CREA_USER=:CREA_USER,'+
  'CREA_DATE=:CREA_DATE,INVH_NO=:INVH_NO,BEGIN_NO=:BEGIN_NO,ENDED_NO=:ENDED_NO,TOTAL_AMT=:TOTAL_AMT,BALANCE=:TOTAL_AMT - isnull(USING_AMT,0) - isnull(CANCEL_AMT,0),'+
  'REMARK=:REMARK,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:TENANT_ID and INVH_ID=:INVH_ID ';
  UpdateSQL.Text := ParseSQL(iDbType,Str);
  Str := 'update SAL_INVOICE_BOOK set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and INVH_ID=:OLD_INVH_ID';
  DeleteSQL.Text := Str;
end;


initialization
  RegisterClass(TInvoice);
finalization
  UnRegisterClass(TInvoice);
end.
