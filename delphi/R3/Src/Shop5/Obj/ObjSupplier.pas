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

{ TSupplier }

function TSupplier.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs: TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from STK_STOCKORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLIENT_ID=:CLIENT_ID ';
    rs.ParamByName('CLIENT_ID').AsString := FieldbyName('CLIENT_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsString := FieldbyName('TENANT_ID').AsOldString;
    rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create('供应商"'+FieldbyName('CLIENT_NAME').AsString+'"在入库单据中有使用,不能删除!');
  finally
    rs.Free;
  end;
  Result := True;
end;

function TSupplier.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CLIENT_ID,COMM from PUB_CLIENTINFO where COMM not in (''02'',''12'') and CLIENT_NAME=:CLIENT_NAME and CLIENT_TYPE=''1'' and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('CLIENT_NAME').AsString := FieldbyName('CLIENT_NAME').AsOldString;
    rs.ParamByName('TENANT_ID').AsString := FieldbyName('TENANT_ID').AsOldString;
    rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.RecordCount > 0 then
      Raise Exception.Create('"'+FieldbyName('CLIENT_NAME').AsString+'"供应商名称不能重复设置');

  finally
    rs.Free;
  end;
  Result := True;
end;

function TSupplier.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_CLIENTINFO where COMM not in (''12'',''02'') and CLIENT_NAME=:CLIENT_NAME '+
    'and CLIENT_ID<>:OLD_CLIENT_ID and CLIENT_TYPE=''1'' and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('CLIENT_NAME').AsString := FieldbyName('CLIENT_NAME').AsString;
    rs.ParamByName('OLD_CLIENT_ID').AsString := FieldbyName('CLIENT_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsString := FieldbyName('TENANT_ID').AsOldString;
    rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    AGlobal.Open(rs);
      if rs.Fields[0].AsInteger > 0 then
        raise Exception.Create('"'+FieldbyName('CLIENT_NAME').AsString+'"供应商名称不能重复设置');
  finally
    rs.Free;
  end;
  Result := True;
end;

procedure TSupplier.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'CLIENT_ID;TENANT_ID';

  SelectSQL.Text:='select TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,REGION_ID,SETTLE_CODE,PRICE_ID,'+
  'SHOP_ID,TAX_RATE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,BANK_ID,ACCOUNT,INVOICE_FLAG,REMARK'+
  ' from PUB_CLIENTINFO where COMM not in (''02'',''12'') and CLIENT_ID=:CLIENT_ID and TENANT_ID=:TENANT_ID order by CLIENT_CODE';
  IsSQLUpdate := True;

  Str := 'insert into PUB_CLIENTINFO(TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,'+
  'REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,BANK_ID,ACCOUNT,'+
  'INVOICE_FLAG,REMARK,TAX_RATE,SHOP_ID,COMM,TIME_STAMP) values(:TENANT_ID,:CLIENT_ID,:CLIENT_TYPE,:CLIENT_CODE,:LICENSE_CODE,'+
  ':CLIENT_NAME,:CLIENT_SPELL,:SORT_ID,:REGION_ID,:SETTLE_CODE,:ADDRESS,:POSTALCODE,:LINKMAN,:TELEPHONE3,:TELEPHONE1,:TELEPHONE2,'+
  ':FAXES,:HOMEPAGE,:EMAIL,:QQ,:MSN,:BANK_ID,:ACCOUNT,:INVOICE_FLAG,:REMARK,:TAX_RATE,:SHOP_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update PUB_CLIENTINFO set CLIENT_CODE=:CLIENT_CODE,LICENSE_CODE=:LICENSE_CODE,CLIENT_NAME=:CLIENT_NAME,CLIENT_SPELL=:CLIENT_SPELL,'+
  'SORT_ID=:SORT_ID,REGION_ID=:REGION_ID,SETTLE_CODE=:SETTLE_CODE,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,LINKMAN=:LINKMAN,TELEPHONE3=:TELEPHONE3,'+
  'TELEPHONE1=:TELEPHONE1,TELEPHONE2=:TELEPHONE2,FAXES=:FAXES,HOMEPAGE=:HOMEPAGE,EMAIL=:EMAIL,QQ=:QQ,MSN=:MSN,BANK_ID=:BANK_ID,ACCOUNT=:ACCOUNT,'+
  'INVOICE_FLAG=:INVOICE_FLAG,REMARK=:REMARK,TAX_RATE=:TAX_RATE,SHOP_ID=:SHOP_ID,COMM='+ GetCommStr(iDbType)+
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
