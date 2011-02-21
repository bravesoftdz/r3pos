unit ObjSupplier;

interface
uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TSupplier=class(TZFactory)
  private
    procedure InitClass; override;
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation

{ TClient }

function TSupplier.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TSupplier.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TSupplier.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

procedure TSupplier.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'CLIENT_ID;TENANT_ID';

  SelectSQL.Text:='select TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,REGION_ID,SETTLE_CODE,'+
  'PRICE_ID,SHOP_ID,TAX_RATE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,BANK_ID,ACCOUNT,INVOICE_FLAG,REMARK'+
  ' from PUB_CLIENTINFO where COMM not in (''02'',''12'') and CLIENT_ID=:CLIENT_ID and TENANT_ID=:TENANT_ID order by CLIENT_CODE';
  IsSQLUpdate := True;

  Str := 'insert into PUB_CLIENTINFO(TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,'+
  'REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,BANK_ID,ACCOUNT,'+
  'INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,SHOP_ID,COMM,TIME_STAMP) values(:TENANT_ID,:CLIENT_ID,:CLIENT_TYPE,:CLIENT_CODE,:LICENSE_CODE,'+
  ':CLIENT_NAME,:CLIENT_SPELL,:SORT_ID,:REGION_ID,:SETTLE_CODE,:ADDRESS,:POSTALCODE,:LINKMAN,:TELEPHONE3,:TELEPHONE1,:TELEPHONE2,'+
  ':FAXES,:HOMEPAGE,:EMAIL,:QQ,:MSN,:BANK_ID,:ACCOUNT,:INVOICE_FLAG,:REMARK,:TAX_RATE,:PRICE_ID,:SHOP_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update PUB_CLIENTINFO set TENANT_ID=:TENANT_ID,CLIENT_ID=:CLIENT_ID,CLIENT_TYPE=:CLIENT_TYPE,CLIENT_CODE=:CLIENT_CODE,'+
  'LICENSE_CODE=:LICENSE_CODE,CLIENT_NAME=:CLIENT_NAME,CLIENT_SPELL=:CLIENT_SPELL,SORT_ID=:SORT_ID,REGION_ID=:REGION_ID,'+
  'SETTLE_CODE=:SETTLE_CODE,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,LINKMAN=:LINKMAN,TELEPHONE3=:TELEPHONE3,TELEPHONE1=:TELEPHONE1,'+
  'TELEPHONE2=:TELEPHONE2,FAXES=:FAXES,HOMEPAGE=:HOMEPAGE,EMAIL=:EMAIL,QQ=:QQ,MSN=:MSN,BANK_ID=:BANK_ID,ACCOUNT=:ACCOUNT,'+
  'INVOICE_FLAG=:INVOICE_FLAG,REMARK=:REMARK,TAX_RATE=:TAX_RATE,PRICE_ID=:PRICE_ID,SHOP_ID=:SHOP_ID,COMM='+ GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID ';
  UpdateSQL.Text := Str;

  Str := 'update PUB_CLIENTINFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID ';
  DeleteSQL.Text := Str;

end;

initialization
  RegisterClass(TSupplier);
finalization
  UnRegisterClass(TSupplier);
end.
