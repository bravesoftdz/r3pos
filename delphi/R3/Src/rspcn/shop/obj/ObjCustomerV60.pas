unit ObjCustomerV60;

interface

uses Dialogs,SysUtils,zBase,Classes,ZDataset,ZIntf,ObjCommon;

type
  TCustomerV60=class(TZFactory)
  private
    procedure InitClass; override;
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TIntegralGlideV60=class(TZFactory)
  private
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

function TCustomerV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
  rs: TZQuery;
begin
  result := false;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLIENT_ID=:CUST_ID';
    rs.ParamByName('CUST_ID').AsString := FieldbyName('CUST_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
    rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger>0 then
       Raise Exception.Create('��Ա"'+FieldbyName('CUST_NAME').AsString+'"�������Ѽ�¼,����ɾ��!');

    rs.SQL.Text := 'select BALANCE from PUB_IC_INFO where COMM not in (''02'',''12'') and UNION_ID=:UNION_ID and CLIENT_ID=:CLIENT_ID and TENANT_ID=:TENANT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
    rs.ParamByName('UNION_ID').AsString := FieldbyName('UNION_ID').AsOldString;
    rs.ParamByName('CLIENT_ID').AsString := FieldbyName('CUST_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.RecordCount > 0 then
       if rs.FieldByName('BALANCE').AsFloat > 0 then
          Raise Exception.Create('��Ա��"'+FieldbyName('CUST_CODE').AsString+'"�л������,����ɾ��!')
       else
          begin
            Str := ' update PUB_IC_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where CLIENT_ID=:OLD_CUST_ID and TENANT_ID=:OLD_TENANT_ID ';
            AGlobal.ExecSQL(Str,Self);
          end;
  finally
    rs.Free;
  end;
end;

function TCustomerV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Tmp:TZQuery;
  Str:string;
begin
  result := false;
  try
    Tmp := TZQuery.Create(nil);
    try
      Tmp.Close;
      Tmp.SQL.Text := 'select COMM from PUB_IC_INFO Where IC_CARDNO=:CUST_CODE and TENANT_ID=:TENANT_ID';
      Tmp.ParamByName('CUST_CODE').AsString := FieldbyName('CUST_CODE').AsString;
      Tmp.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
      AGlobal.Open(Tmp);
      Tmp.First;
      while not Tmp.Eof do
        begin
          if Copy(Tmp.FieldByName('COMM').AsString,2,1) = '2' then
             AGlobal.ExecSQL('delete from PUB_IC_INFO where IC_CARDNO=:IC_CARDNO and TENANT_ID=:TENANT_ID',Self)
          else
             Raise Exception.Create('�˻�Ա�����Ѿ�����,�����ظ�!');
          Tmp.Next;
        end;

      if FieldByName('ACCU_INTEGRAL').AsString = '' then FieldByName('ACCU_INTEGRAL').AsFloat := 0;
      if FieldByName('INTEGRAL').AsString = '' then FieldByName('INTEGRAL').AsFloat := 0;

      Str := 'insert into PUB_IC_INFO(CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,ACCU_INTEGRAL,'+
             'RULE_INTEGRAL,INTEGRAL,BALANCE,PASSWRD,USING_DATE,COMM,TIME_STAMP) values(:CUST_ID,:TENANT_ID,''#'',:CUST_CODE,:CREA_DATE,:CREA_USER,'+
             '''��ҵ��'',''1'',''0'',:ACCU_INTEGRAL,0,:INTEGRAL,0,:PASSWRD,null,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
      AGlobal.ExecSQL(Str,Self);
    finally
      Tmp.Free;
    end;
  except
    on E:Exception do
       begin
         result := false;
         Raise Exception.Create('��Ա��:'+E.Message);
       end;
    end;
  result := true;
end;

function TCustomerV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Tmp:TZQuery;
  Str:string;
  r:integer;
begin
  result := false;
  try
    Tmp := TZQuery.Create(nil);
    try
      if FieldByName('CUST_CODE').AsString <> '' then
         begin
           Tmp.Close;
           Tmp.SQL.Text := 'select COMM,CLIENT_ID from PUB_IC_INFO where IC_CARDNO=:CUST_CODE and TENANT_ID=:OLD_TENANT_ID';
           Tmp.ParamByName('CUST_CODE').AsString := FieldbyName('CUST_CODE').AsString;
           Tmp.ParamByName('OLD_TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
           AGlobal.Open(Tmp);

           if not Tmp.IsEmpty then
              begin
                if (Tmp.FieldbyName('CLIENT_ID').AsString <> FieldbyName('CUST_ID').AsString)
                   and
                   (copy(Tmp.FieldbyName('COMM').AsString,2,1)<>'2')
                   then Raise Exception.Create('�˻�Ա�����Ѿ�����,�����ظ�!');
              end;

           if not Tmp.IsEmpty and (Tmp.FieldbyName('CLIENT_ID').AsString <> FieldbyName('CUST_ID').AsString) then
              begin
                Str := 'delete from PUB_IC_INFO where IC_CARDNO=:CUST_CODE and TENANT_ID=:TENANT_ID and UNION_ID=:UNION_ID';
                AGlobal.ExecSQL(Str,self);
                r := 0;
              end;

           Str := 'update PUB_IC_INFO set CLIENT_ID=:CUST_ID,TENANT_ID=:TENANT_ID,UNION_ID=:UNION_ID,IC_CARDNO=:CUST_CODE,CREA_DATE=:CREA_DATE,'+
                  'CREA_USER=:CREA_USER,IC_INFO=:IC_INFO,IC_STATUS=:IC_STATUS,IC_TYPE=:IC_TYPE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+
                  GetTimeStamp(AGlobal.iDbType)+' where CLIENT_ID=:OLD_CUST_ID and TENANT_ID=:OLD_TENANT_ID and UNION_ID=:OLD_UNION_ID';

           r := AGlobal.ExecSQL(Str,Self);
           if r = 0 then
              begin
                Str := 'insert into PUB_IC_INFO(CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,ACCU_INTEGRAL,'+
                       'RULE_INTEGRAL,INTEGRAL,BALANCE,PASSWRD,USING_DATE,COMM,TIME_STAMP) values(:CUST_ID,:TENANT_ID,''#'',:CUST_CODE,:CREA_DATE,:CREA_USER,'+
                       ':IC_INFO,:IC_STATUS,:IC_TYPE,:ACCU_INTEGRAL,:RULE_INTEGRAL,:INTEGRAL,:BALANCE,:PASSWRD,:USING_DATE,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
                AGlobal.ExecSQL(Str,Self);
              end;
         end;
    finally
      Tmp.Free;
    end;
  except
    on E:Exception do
       begin
         result := false;
         Raise Exception.Create('��Ա��:'+E.Message);
       end;
    end;
  result := True;
end;

procedure TCustomerV60.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'CUST_ID';
  SelectSQL.Text :=
    'select A.*,B.IC_CARDNO,B.CREA_DATE,B.CREA_USER,B.IC_INFO,B.IC_STATUS,B.IC_TYPE,'+
    'B.ACCU_INTEGRAL,B.RULE_INTEGRAL,B.INTEGRAL,B.BALANCE,B.PASSWRD,B.USING_DATE from ('+
    'select CUST_ID,TENANT_ID,SHOP_ID,CUST_CODE,CUST_NAME,CUST_SPELL,SEX,EMAIL,OFFI_TELE,FAMI_TELE,'+
    'MOVE_TELE,BIRTHDAY,FAMI_ADDR,POSTALCODE,ID_NUMBER,IDN_TYPE,SND_DATE,CON_DATE,QQ,MSN,END_DATE,SORT_ID,PRICE_ID,REGION_ID,'+
    'MONTH_PAY,DEGREES,OCCUPATION,JOBUNIT,REMARK,''#'' as UNION_ID,COMM from PUB_CUSTOMER where TENANT_ID=:TENANT_ID and CUST_ID=:CUST_ID ) A '+
    'left join PUB_IC_INFO B on A.CUST_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.UNION_ID=B.UNION_ID order by A.CUST_CODE';

  IsSQLUpdate := True;
  Str := 'insert into PUB_CUSTOMER(CUST_ID,TENANT_ID,SHOP_ID,CUST_CODE,CUST_NAME,CUST_SPELL,SEX,EMAIL,OFFI_TELE,FAMI_TELE,MOVE_TELE,'+
    'BIRTHDAY,FAMI_ADDR,POSTALCODE,ID_NUMBER,IDN_TYPE,SND_DATE,CON_DATE,QQ,MSN,END_DATE,SORT_ID,PRICE_ID,REGION_ID,MONTH_PAY,DEGREES,'+
    'OCCUPATION,JOBUNIT,REMARK,COMM,TIME_STAMP) values(:CUST_ID,:TENANT_ID,:SHOP_ID,:CUST_CODE,:CUST_NAME,:CUST_SPELL,:SEX,:EMAIL,:OFFI_TELE,'+
    ':FAMI_TELE,:MOVE_TELE,:BIRTHDAY,:FAMI_ADDR,:POSTALCODE,:ID_NUMBER,:IDN_TYPE,:SND_DATE,:CON_DATE,:QQ,:MSN,:END_DATE,:SORT_ID,:PRICE_ID,'+
    ':REGION_ID,:MONTH_PAY,:DEGREES,:OCCUPATION,:JOBUNIT,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update PUB_CUSTOMER set SHOP_ID=:SHOP_ID,CUST_CODE=:CUST_CODE,CUST_NAME=:CUST_NAME,CUST_SPELL=:CUST_SPELL,SEX=:SEX,PRICE_ID=:PRICE_ID,'+
    'OFFI_TELE=:OFFI_TELE,FAMI_TELE=:FAMI_TELE,MOVE_TELE=:MOVE_TELE,BIRTHDAY=:BIRTHDAY,FAMI_ADDR=:FAMI_ADDR,POSTALCODE=:POSTALCODE,MSN=:MSN,'+
    'ID_NUMBER=:ID_NUMBER,IDN_TYPE=:IDN_TYPE,SND_DATE=:SND_DATE,CON_DATE=:CON_DATE,QQ=:QQ,EMAIL=:EMAIL,END_DATE=:END_DATE,SORT_ID=:SORT_ID,'+
    'REGION_ID=:REGION_ID,MONTH_PAY=:MONTH_PAY,DEGREES=:DEGREES,OCCUPATION=:OCCUPATION,JOBUNIT=:JOBUNIT,REMARK=:REMARK,COMM='+GetCommStr(iDbType)+
    ',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and CUST_ID=:OLD_CUST_ID';
  UpdateSQL.Text := Str;

  Str := 'update PUB_CUSTOMER set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where CUST_ID=:OLD_CUST_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Add(Str);
end;

function TIntegralGlideV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  Str:string;
begin
  rs := TZQuery.Create(nil);
  try
    if FieldByName('INTEGRAL_FLAG').AsString = '1' then
       Str := 'update PUB_IC_INFO set INTEGRAL=ifnull(INTEGRAL,0)+:INTEGRAL,ACCU_INTEGRAL=ifnull(ACCU_INTEGRAL,0)+:INTEGRAL where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and IC_CARDNO=:IC_CARDNO '
    else
       Str := 'update PUB_IC_INFO set INTEGRAL=ifnull(INTEGRAL,0)-:INTEGRAL,RULE_INTEGRAL=ifnull(RULE_INTEGRAL,0)+:INTEGRAL where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and IC_CARDNO=:IC_CARDNO ';
    AGlobal.ExecSQL(ParseSQL(iDbType,Str),self);
    if FieldByName('INTEGRAL_FLAG').AsString <> '1' then
       begin
         rs.SQL.Text := 'select INTEGRAL from PUB_IC_INFO where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and CLIENT_ID='''+FieldbyName('CLIENT_ID').AsString+'''';
         AGlobal.Open(rs);
         if rs.Fields[0].AsInteger<0 then Raise Exception.Create('���û��ֲ��㣬������ɶԻ���');
       end;
  finally
    rs.Free;
  end;
  result := true;
end;

procedure TIntegralGlideV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    ' select GLIDE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,IC_CARDNO,CREA_DATE,CREA_USER,INTEGRAL_FLAG,GLIDE_INFO,INTEGRAL,GLIDE_AMT,GODS_ID,INTEGRAL_GOODS '+
    ' from SAL_INTEGRAL_GLIDE where TENANT_ID=:TENANT_ID and GLIDE_ID=:GLIDE_ID and COMM not in (''02'',''12'') ';

  IsSQLUpdate := true;

  InsertSQL.Text :=
    ' insert into SAL_INTEGRAL_GLIDE(GLIDE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,IC_CARDNO,CREA_DATE,CREA_USER,INTEGRAL_FLAG,GLIDE_INFO,INTEGRAL,GLIDE_AMT,GODS_ID,INTEGRAL_GOODS,COMM,TIME_STAMP)'+
    ' values (:GLIDE_ID,:TENANT_ID,:SHOP_ID,:CLIENT_ID,:IC_CARDNO,:CREA_DATE,:CREA_USER,:INTEGRAL_FLAG,:GLIDE_INFO,:INTEGRAL,:GLIDE_AMT,:GODS_ID,:INTEGRAL_GOODS,''00'','+GetTimeStamp(iDbType)+')';
end;

initialization
  RegisterClass(TCustomerV60);
  RegisterClass(TIntegralGlideV60);
finalization
  UnRegisterClass(TCustomerV60);
  UnRegisterClass(TIntegralGlideV60);
end.
