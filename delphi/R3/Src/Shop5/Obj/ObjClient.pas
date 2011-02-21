unit ObjClient;

interface
uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TClient=class(TZFactory)
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

function TClient.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str: String;
begin
  Result := False;
  Str := 'update PUB_IC_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where CLIENT_ID=:OLD_CLIENT_ID and TENANT_ID=:OLD_TENANT_ID  ';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TClient.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Temp: TZQuery;
    Str: String;
begin
  Temp := TZQuery.Create(nil);
  try
    Temp.Close;
    try
      Temp.SQL.Text := 'select * from PUB_IC_INFO where COMM not in (''02'',''12'') and IC_CARDNO=:IC_CARDNO and TENANT_ID=:TENANT_ID';
      AGlobal.Open(Temp);
      if Temp.RecordCount > 0 then
        Raise Exception.Create('此卡号已经存在，不能重复！');

      Str := 'insert into PUB_IC_INFO(CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,ACCU_INTEGRAL,'+
      'RULE_INTEGRAL,INTEGRAL,BALANCE,PASSWRD,USING_DATE,COMM,TIME_STAMP) values(:CLIENT_ID,:TENANT_ID,''#'',:IC_CARDNO,:CREA_DATE,:CREA_USER,'+
      ':IC_INFO,:IC_STATUS,''0'',:ACCU_INTEGRAL,:RULE_INTEGRAL,:INTEGRAL,:BALANCE,:PASSWRD,:USING_DATE,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
      AGlobal.ExecSQL(Str,Self);
      Result := True;
    finally
      Temp.Free;
    end;
  except
    on E:Exception do
      begin
        Result := False;
        Raise Exception.Create('');
      end;
  end;
end;

function TClient.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var Temp: TZQuery;
    Str: String;
begin
  try
    Temp := TZQuery.Create(nil);
    try
      Temp.Close;
      Temp.SQL.Text := 'select * from PUB_IC_INFO where COMM not in (''02'',''12'') and IC_CARDNO=:IC_CARDNO and TENANT_ID=:TENANT_ID';
      AGlobal.Open(Temp);
      if Temp.RecordCount > 0 then
        Raise Exception.Create('此卡号已经存在，不能重复！');
      Str := 'update PUB_IC_INFO set IC_CARDNO=:IC_CARDNO,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,IC_INFO=:IC_INFO,IC_STATUS=:IC_STATUS,'+
      'IC_TYPE=:IC_TYPE,BALANCE=:BALANCE,PASSWRD=:PASSWRD,USING_DATE=:USING_DATE,'+
      'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where CLIENT_ID=:OLD_CLIENT_ID and TENANT_ID=:OLD_TENANT_ID and UNION_ID=:OLD_UNION_ID';
      if not (AGlobal.ExecSQL(Str,Self)) then
        begin
          Str := 'insert into PUB_IC_INFO(CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,ACCU_INTEGRAL,'+
          'RULE_INTEGRAL,INTEGRAL,BALANCE,PASSWRD,USING_DATE,COMM,TIME_STAMP) values(:CLIENT_ID,:TENANT_ID,''#'',:IC_CARDNO,:CREA_DATE,:CREA_USER,'+
          ':IC_INFO,:IC_STATUS,''0'',:ACCU_INTEGRAL,:RULE_INTEGRAL,:INTEGRAL,:BALANCE,:PASSWRD,:USING_DATE,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
          AGlobal.ExecSQL(Str,Self);
        end;
      Result := True;
    finally
      Temp.Free;
    end;
  except
    on E:Exception do
      begin
        Result := False;
        Raise Exception.Create('');
      end;
  end;
end;

procedure TClient.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'CLIENT_ID;TENANT_ID';

  SelectSQL.Text := 'select A.TENANT_ID,A.CLIENT_ID,A.CLIENT_TYPE,A.CLIENT_CODE,A.LICENSE_CODE,A.CLIENT_NAME,A.CLIENT_SPELL,A.SORT_ID,'+
  'A.REGION_ID,A.SETTLE_CODE,A.ADDRESS,A.POSTALCODE,A.LINKMAN,A.TELEPHONE3,A.TELEPHONE1,A.TELEPHONE2,A.FAXES,A.HOMEPAGE,A.EMAIL,A.QQ,'+
  'A.MSN,A.BANK_ID,A.ACCOUNT,A.INVOICE_FLAG,A.REMARK,A.TAX_RATE,A.PRICE_ID,A.SHOP_ID,B.UNION_ID,B.IC_CARDNO,B.CREA_DATE,B.CREA_USER,'+
  'B.IC_INFO,B.IC_STATUS,B.IC_TYPE,B.ACCU_INTEGRAL,B.RULE_INTEGRAL,B.INTEGRAL,B.BALANCE,B.PASSWRD,B.USING_DATE'+
  ' from PUB_CLIENTINFO A left join PUB_IC_INFO B on A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID'+
  ' where A.COMM not in (''02'',''12'') and IC_TYPE=''0'' and A.CLIENT_ID=:CLIENT_ID and A.TENANT_ID=:TENANT_ID order by A.CLIENT_ID';
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
  'INVOICE_FLAG=:INVOICE_FLAG,REMARK=:REMARK,TAX_RATE=:TAX_RATE,PRICE_ID=:PRICE_ID,SHOP_ID=:SHOP_ID,COMM=' + GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+ ' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID and UNION_ID=:OLD_UNION_ID';
  UpdateSQL.Text := Str;

  Str := 'update PUB_CLIENTINFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID and UNION_ID=:OLD_UNION_ID';
  DeleteSQL.Text := Str;

end;

initialization
  RegisterClass(TClient);
finalization
  UnRegisterClass(TClient);
end.
