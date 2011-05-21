unit ObjClient;

interface
uses Windows,Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;

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
    rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLIENT_ID=:CLIENT_ID';
    rs.ParamByName('CLIENT_ID').AsString := FieldbyName('CLIENT_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create('客户"'+FieldbyName('CLIENT_NAME').AsString+'"在销售单据中有使用,不能删除!');

    rs.SQL.Text := 'select BALANCE from PUB_IC_INFO where COMM not in (''02'',''12'') and UNION_ID=:UNION_ID and IC_CARDNO=:IC_CARDNO'+
    ' and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('UNION_ID').AsString := FieldbyName('UNION_ID').AsOldString;
    rs.ParamByName('IC_CARDNO').AsString := FieldbyName('CLIENT_CODE').AsOldString;
    AGlobal.Open(rs);
    if rs.RecordCount > 0 then
      if rs.FieldByName('BALANCE').AsFloat > 0 then
        Raise Exception.Create('客户卡"'+FieldbyName('CLIENT_ID').AsString+'"中还有余额,不能删除!')
      else
        begin
          Str := 'update PUB_IC_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
          ' where IC_CARDNO=:CLIENT_CODE and UNION_ID=:OLD_UNION_ID and TENANT_ID=:OLD_TENANT_ID';
          AGlobal.ExecSQL(Str,Self);
        end;
  finally
    rs.Free;
  end;

end;

function TClient.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Temp: TZQuery;
    Str: String;
begin
  Temp := TZQuery.Create(nil);
  try
    Temp.Close;
    try                 
      Temp.SQL.Text := 'select COMM from PUB_IC_INFO where IC_CARDNO=:CLIENT_CODE and TENANT_ID=:TENANT_ID and UNION_ID=:UNION_ID';
      Temp.ParamByName('CLIENT_CODE').AsString := FieldbyName('CLIENT_CODE').AsString;
      Temp.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
      Temp.ParamByName('UNION_ID').AsString := FieldbyName('UNION_ID').AsString;
      AGlobal.Open(Temp);
      if not Temp.IsEmpty then
        if Copy(Temp.FieldByName('COMM').AsString,2,1) = '2' then
          AGlobal.ExecSQL('delete from PUB_IC_INFO where IC_CARDNO=:CLIENT_CODE and TENANT_ID=:TENANT_ID and UNION_ID=:UNION_ID ',Self)
        else
          Raise Exception.Create('客户卡号已经存在,不能重复!');

      Str := 'insert into PUB_IC_INFO(CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,ACCU_INTEGRAL,'+
       'RULE_INTEGRAL,INTEGRAL,BALANCE,PASSWRD,USING_DATE,COMM,TIME_STAMP) values(:CLIENT_ID,:TENANT_ID,''#'',:CLIENT_CODE,:CREA_DATE,:CREA_USER,'+
       ':IC_INFO,''0'',''0'',0,0,0,0,null,null,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
      AGlobal.ExecSQL(Str,Self);
      Result := True;
    finally
      Temp.Free;
    end;                                                                        
  except
    on E:Exception do
      begin
        Result := False;
        Raise Exception.Create('客户卡:'+E.Message);
      end;
  end;
end;

function TClient.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var Temp: TZQuery;
    Str: String;
    n:Integer;
begin
  try
    Temp := TZQuery.Create(nil);
    try
      Temp.Close;
      Temp.SQL.Text := 'select CLIENT_ID,COMM from PUB_IC_INFO where IC_CARDNO=:CLIENT_CODE and TENANT_ID=:OLD_TENANT_ID and UNION_ID=:OLD_UNION_ID ';
      Temp.ParamByName('CLIENT_CODE').AsString := FieldbyName('CLIENT_CODE').AsString;
      Temp.ParamByName('OLD_TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
      Temp.ParamByName('OLD_UNION_ID').AsString := FieldbyName('UNION_ID').AsOldString;
      AGlobal.Open(Temp);
      if not Temp.IsEmpty then
        if (Temp.FieldByName('CLIENT_ID').AsString <> FieldByName('CLIENT_ID').AsString)
         and
         (Copy(Temp.FieldbyName('COMM').AsString,2,1)<>'2')
         then
         Raise Exception.Create('此客户卡号已经存在,不能重复!');

      if not Temp.IsEmpty and (Temp.FieldByName('CLIENT_ID').AsString <> FieldByName('CLIENT_ID').AsString) then
        begin
          Str := 'delete from PUB_IC_INFO where IC_CARDNO=:CLIENT_CODE and TENANT_ID=:TENANT_ID and UNION_ID=:UNION_ID';
          AGlobal.ExecSQL(Str,self);
          n := 0;
        end;

      Str := 'update PUB_IC_INFO set CLIENT_ID=:CLIENT_ID,TENANT_ID=:TENANT_ID,UNION_ID=:UNION_ID,IC_CARDNO=:IC_CARDNO,'+
          'CREA_USER=:CREA_USER,IC_INFO=:IC_INFO,IC_STATUS=:IC_STATUS,IC_TYPE=:IC_TYPE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+
          GetTimeStamp(AGlobal.iDbType)+' where IC_CARDNO=:OLD_CLIENT_CODE and TENANT_ID=:OLD_TENANT_ID and UNION_ID=:OLD_UNION_ID';
      n := AGlobal.ExecSQL(Str,Self);

      if n = 0 then
        begin
          Str := 'insert into PUB_IC_INFO(CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,ACCU_INTEGRAL,'+
            'RULE_INTEGRAL,INTEGRAL,BALANCE,PASSWRD,USING_DATE,COMM,TIME_STAMP) values(:CLIENT_ID,:TENANT_ID,''#'',:CLIENT_CODE,:CREA_DATE,:CREA_USER,'+
            ':IC_INFO,:IC_STATUS,:IC_TYPE,:ACCU_INTEGRAL,:RULE_INTEGRAL,:INTEGRAL,:BALANCE,:PASSWRD,:USING_DATE,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
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
        Raise Exception.Create('客户卡:'+E.Message);
      end;
  end;
end;

procedure TClient.InitClass;
var Str: string;
begin
  inherited;
  KeyFields := 'CLIENT_ID;TENANT_ID';

  SelectSQL.Text :='select A.*,B.UNION_ID,B.IC_CARDNO,B.CREA_DATE,B.CREA_USER,B.IC_INFO,B.IC_STATUS,B.IC_TYPE,B.ACCU_INTEGRAL,'+
  'B.RULE_INTEGRAL,B.INTEGRAL,B.BALANCE,B.PASSWRD,B.USING_DATE from (select TENANT_ID,CLIENT_ID,''#'' as UNION_ID,CLIENT_TYPE,'+
  'CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,'+
  'TELEPHONE2,SEND_ADDR,SEND_TELE,SEND_LINKMAN,RECV_ADDR,RECV_LINKMAN,RECV_TELE,LEGAL_REPR,INVO_NAME,TAX_NO,FAXES,HOMEPAGE,EMAIL,'+
  'QQ,MSN,BANK_ID,ACCOUNT,INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,SHOP_ID from PUB_CLIENTINFO '+
  'where COMM not in (''02'',''12'') and CLIENT_ID=:CLIENT_ID and TENANT_ID=:TENANT_ID) A left join PUB_IC_INFO B '+
  'on A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and B.UNION_ID=A.UNION_ID order by A.CLIENT_CODE';
  IsSQLUpdate := True;

  Str := 'insert into PUB_CLIENTINFO(TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,'+
  'REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,SEND_ADDR,SEND_TELE,SEND_LINKMAN,RECV_ADDR,'+
  'RECV_LINKMAN,RECV_TELE,LEGAL_REPR,INVO_NAME,TAX_NO,FAXES,HOMEPAGE,EMAIL,QQ,MSN,BANK_ID,ACCOUNT,INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,'+
  'SHOP_ID,COMM,TIME_STAMP) values(:TENANT_ID,:CLIENT_ID,:CLIENT_TYPE,:CLIENT_CODE,:LICENSE_CODE,:CLIENT_NAME,:CLIENT_SPELL,:SORT_ID,:REGION_ID,'+
  ':SETTLE_CODE,:ADDRESS,:POSTALCODE,:LINKMAN,:TELEPHONE3,:TELEPHONE1,:TELEPHONE2,:SEND_ADDR,:SEND_TELE,:SEND_LINKMAN,:RECV_ADDR,:RECV_LINKMAN,'+
  ':RECV_TELE,:LEGAL_REPR,:INVO_NAME,:TAX_NO,:FAXES,:HOMEPAGE,:EMAIL,:QQ,:MSN,:BANK_ID,:ACCOUNT,:INVOICE_FLAG,:REMARK,:TAX_RATE,:PRICE_ID,:SHOP_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update PUB_CLIENTINFO set CLIENT_CODE=:CLIENT_CODE,LICENSE_CODE=:LICENSE_CODE,CLIENT_NAME=:CLIENT_NAME,CLIENT_SPELL=:CLIENT_SPELL,'+
  'SORT_ID=:SORT_ID,REGION_ID=:REGION_ID,SETTLE_CODE=:SETTLE_CODE,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,LINKMAN=:LINKMAN,TELEPHONE3=:TELEPHONE3,'+
  'TELEPHONE1=:TELEPHONE1,TELEPHONE2=:TELEPHONE2,SEND_ADDR=:SEND_ADDR,SEND_TELE=:SEND_TELE,SEND_LINKMAN=:SEND_LINKMAN,RECV_ADDR=:RECV_ADDR,RECV_LINKMAN=:RECV_LINKMAN,'+
  'RECV_TELE=:RECV_TELE,LEGAL_REPR=:LEGAL_REPR,INVO_NAME=:INVO_NAME,TAX_NO=:TAX_NO,FAXES=:FAXES,HOMEPAGE=:HOMEPAGE,EMAIL=:EMAIL,QQ=:QQ,MSN=:MSN,BANK_ID=:BANK_ID,ACCOUNT=:ACCOUNT,'+
  'INVOICE_FLAG=:INVOICE_FLAG,REMARK=:REMARK,TAX_RATE=:TAX_RATE,PRICE_ID=:PRICE_ID,SHOP_ID=:SHOP_ID,COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID ';
  UpdateSQL.Text := Str;

  Str := 'update PUB_CLIENTINFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID ';
  DeleteSQL.Text := Str;

end;

initialization
  RegisterClass(TClient);
finalization
  UnRegisterClass(TClient);
end.
