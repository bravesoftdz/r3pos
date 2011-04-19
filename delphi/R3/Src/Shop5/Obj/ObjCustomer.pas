unit ObjCustomer;

interface
uses Dialogs,SysUtils,zBase,Classes,ZDataset,ZIntf,ObjCommon;

type
  TCustomer=class(TZFactory)
  private
    procedure InitClass; override;
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TPubIcInfo=class(TZFactory)
  private
    procedure InitClass; override;
  end;
  TCustomerExt=class(TZFactory)
  private
    procedure InitClass; override;
  end;
  TIntegralGlide=class(TZFactory)
  private
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TSelectIntegralGlide=class(TZFactory)
  private
    procedure InitClass; override;
  end;
  TNewCard=class(TZFactory)
  private
    procedure InitClass; override;
  public
    //function AfterUpdateBatch(AGlobal:IdbHelp):Boolean;override;
  end;
  TSelectCard=class(TZFactory)
  private
    procedure InitClass; override;
  end;
  TNewCardUpdate=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TDeposit=class(TZFactory)
  private
    procedure InitClass; override;
  public
    //function AfterUpdateBatch(AGlobal:IdbHelp):Boolean;override;
  end;
  TSelectDeposit=class(TZFactory)
  private
    procedure InitClass;override;
  end;
  TRenew=class(TZFactory)
  private
    procedure InitClass; override;
  public
    //function AfterUpdateBatch(AGlobal:IdbHelp):Boolean;override;
  end;
  TUnionIndex=class(TZFactory)
  private
    procedure InitClass; override;
  end;
  TCustomerSalesData=class(TZFactory)
  private
    procedure InitClass;override;
  end;
implementation



{ TCustomer }

function TCustomer.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str: String;
    rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLIENT_ID=:CUST_ID';
    rs.ParamByName('CUST_ID').AsString := FieldbyName('CUST_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
    rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger>0 then
      Raise Exception.Create('会员"'+FieldbyName('CUST_NAME').AsString+'"存在消费记录,不能删除!');

    rs.SQL.Text :=
    'select BALANCE from PUB_IC_INFO where COMM not in (''02'',''12'') and UNION_ID=:UNION_ID and IC_CARDNO=:IC_CARDNO'+
    ' and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
    rs.ParamByName('UNION_ID').AsString := FieldbyName('UNION_ID').AsOldString;
    rs.ParamByName('IC_CARDNO').AsString := FieldbyName('CUST_CODE').AsOldString;
    AGlobal.Open(rs);
    if rs.RecordCount > 0 then
      if rs.FieldByName('BALANCE').AsFloat > 0 then
        Raise Exception.Create('会员卡"'+FieldbyName('CUST_CODE').AsString+'"中还有余额,不能删除!')
      else
        begin
          Str := 'update PUB_IC_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
          ' where IC_CARDNO=:OLD_CUST_CODE and TENANT_ID=:OLD_TENANT_ID  and UNION_ID=:OLD_UNION_ID';
          AGlobal.ExecSQL(Str,Self);
        end;
  finally
    rs.Free;
  end;
end;

function TCustomer.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Tmp:TZQuery;
    Str:String;
begin
   result := false;
   try
     try
       Tmp := TZQuery.Create(nil);
       Tmp.Close;
       Tmp.SQL.Text := 'Select COMM From PUB_IC_INFO Where IC_CARDNO=:CUST_CODE and TENANT_ID=:TENANT_ID and UNION_ID=:UNION_ID';
       Tmp.ParamByName('CUST_CODE').AsString := FieldbyName('CUST_CODE').AsString;
       Tmp.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
       Tmp.ParamByName('UNION_ID').AsString := FieldbyName('UNION_ID').AsString;
       AGlobal.Open(Tmp);
       Tmp.First;
       while not Tmp.Eof do
        begin
          if Copy(Tmp.FieldByName('COMM').AsString,2,1) = '2' then
            AGlobal.ExecSQL('delete from PUB_IC_INFO where IC_CARDNO=:IC_CARDNO and TENANT_ID=:TENANT_ID and UNION_ID=:UNION_ID ',Self)
          else
            Raise Exception.Create('此会员卡号已经存在,不能重复!');
          Tmp.Next;
        end;

       Str := 'insert into PUB_IC_INFO(CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,ACCU_INTEGRAL,'+
       'RULE_INTEGRAL,INTEGRAL,BALANCE,PASSWRD,USING_DATE,COMM,TIME_STAMP) values(:CUST_ID,:TENANT_ID,''#'',:CUST_CODE,:CREA_DATE,:CREA_USER,'+
       ':IC_INFO,''0'',''0'',0,0,0,0,null,null,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
       AGlobal.ExecSQL(Str,Self);
     finally
       Tmp.Free;
     end;
   except
     on E:Exception do
     begin
       result := false;
       Raise Exception.Create('会员卡:'+E.Message);
     end;
   end;
   result := true;
end;

function TCustomer.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var Tmp:TZQuery;
    Str:String;
    r:integer;
begin
   result := false;
   try
     try
      Tmp := TZQuery.Create(nil);
      if FieldByName('CUST_CODE').AsString <> '' then
      begin
        Tmp.Close;
        Tmp.SQL.Text := 'select COMM,CLIENT_ID from PUB_IC_INFO where IC_CARDNO=:CUST_CODE'+
        ' and TENANT_ID=:OLD_TENANT_ID and UNION_ID=:OLD_UNION_ID';
        Tmp.ParamByName('CUST_CODE').AsString := FieldbyName('CUST_CODE').AsString;
        Tmp.ParamByName('OLD_TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
        Tmp.ParamByName('OLD_UNION_ID').AsString := FieldbyName('UNION_ID').AsOldString;
        AGlobal.Open(Tmp);

        if not Tmp.IsEmpty then
          begin
            if (Tmp.FieldbyName('CLIENT_ID').AsString <> FieldbyName('CUST_ID').AsString)
               and
               (copy(Tmp.FieldbyName('COMM').AsString,2,1)<>'2')
            then Raise Exception.Create('此会员卡号已经存在,不能重复!');
          end;

        if not Tmp.IsEmpty and (Tmp.FieldbyName('CLIENT_ID').AsString <> FieldbyName('CUST_ID').AsString) then
           begin
             Str := 'delete from PUB_IC_INFO where IC_CARDNO=:CUST_CODE and TENANT_ID=:TENANT_ID and UNION_ID=:UNION_ID';
             AGlobal.ExecSQL(Str,self);
             r := 0;
           end;
        Str :=
          'update PUB_IC_INFO set CLIENT_ID=:CUST_ID,TENANT_ID=:TENANT_ID,UNION_ID=:UNION_ID,IC_CARDNO=:IC_CARDNO,CREA_DATE=:CREA_DATE,'+
          'CREA_USER=:CREA_USER,IC_INFO=:IC_INFO,IC_STATUS=:IC_STATUS,IC_TYPE=:IC_TYPE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+
          GetTimeStamp(AGlobal.iDbType)+' where IC_CARDNO=:OLD_CUST_CODE and TENANT_ID=:OLD_TENANT_ID and UNION_ID=:OLD_UNION_ID';
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
       Raise Exception.Create('会员号:'+E.Message);
     end;
   end;
   Result := True;
end;

procedure TCustomer.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'CUST_ID';
  SelectSQL.Text :=
  'select A.*,B.UNION_ID,B.IC_CARDNO,B.CREA_DATE,B.CREA_USER,B.IC_INFO,B.IC_STATUS,B.IC_TYPE,'+
  'B.ACCU_INTEGRAL,B.RULE_INTEGRAL,B.INTEGRAL,B.BALANCE,B.PASSWRD,B.USING_DATE from ('+
  'select CUST_ID,TENANT_ID,SHOP_ID,CUST_CODE,CUST_NAME,CUST_SPELL,SEX,EMAIL,OFFI_TELE,FAMI_TELE,'+
  'MOVE_TELE,BIRTHDAY,FAMI_ADDR,POSTALCODE,ID_NUMBER,IDN_TYPE,SND_DATE,CON_DATE,QQ,MSN,END_DATE,SORT_ID,PRICE_ID,REGION_ID,'+
  'MONTH_PAY,DEGREES,OCCUPATION,JOBUNIT,REMARK,''#'' as UNION_ID from PUB_CUSTOMER where TENANT_ID=:TENANT_ID and CUST_ID=:CUST_ID and COMM not in (''02'',''12'')) A '+
  'left join PUB_IC_INFO B on A.CUST_ID=B.CLIENT_ID and A.TENANT_ID=B.TENANT_ID and A.UNION_ID=B.UNION_ID order by A.CUST_CODE';
  {}
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
  ',TIME_STAMP='+GetTimeStamp(iDbType)+' where COMM not in (''02'',''12'') and TENANT_ID=:OLD_TENANT_ID and CUST_ID=:OLD_CUST_ID';
  UpdateSQL.Text := Str;

  Str := 'update PUB_CUSTOMER set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where CUST_ID=:OLD_CUST_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Add( Str);
end;

{ TIntegralGlide }

function TIntegralGlide.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  n:integer;
  Str:String;
begin
  rs := TZQuery.Create(nil);
  try
    Str := 'update PUB_IC_INFO set INTEGRAL=INTEGRAL-ifnull(:INTEGRAL,0),RULE_INTEGRAL=RULE_INTEGRAL+ifnull(:INTEGRAL,0) where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and IC_CARDNO=:IC_CARDNO';
    AGlobal.ExecSQL(ParseSQL(iDbType,Str),self);
    rs.Close;
    rs.SQL.Text := 'select INTEGRAL from PUB_IC_INFO where TENANT_ID=:TENANT_ID and CLIENT_ID='''+FieldbyName('CLIENT_ID').AsString+'''';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger<0 then Raise Exception.Create('可用积分不足，不能完成对换。');
  finally
    rs.Free;
  end;
  result := true;
end;

procedure TIntegralGlide.InitClass;
var SQL:string;
begin
  inherited;
  SelectSQL.Text := 'select GLIDE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,IC_CARDNO,CREA_DATE,CREA_USER,INTEGRAL_FLAG,GLIDE_INFO,INTEGRAL,GLIDE_AMT from SAL_INTEGRAL_GLIDE where TENANT_ID=:TENANT_ID and GLIDE_ID=:GLIDE_ID';
  IsSQLUpdate := true;
  SQL :=
  ' insert into SAL_INTEGRAL_GLIDE(GLIDE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,IC_CARDNO,CREA_DATE,CREA_USER,INTEGRAL_FLAG,GLIDE_INFO,INTEGRAL,GLIDE_AMT,COMM,TIME_STAMP)'+
  ' values (:GLIDE_ID,:TENANT_ID,:SHOP_ID,:CLIENT_ID,:IC_CARDNO,:CREA_DATE,:CREA_USER,:INTEGRAL_FLAG,:GLIDE_INFO,:INTEGRAL,:GLIDE_AMT,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := SQL;
  
end;

{ TSelectIntegralGlide }

procedure TSelectIntegralGlide.InitClass;
begin
  inherited;
  SelectSQL.Text:='select CREA_DATE,INTEGRAL_FLAG,FLAG_AMT,INTEGRAL,GLIDE_INFO from RCK_INTEGRAL_GLIDE where CUST_ID=:CUST_ID';
  IsSQLUpdate:=True;
end;

{ TNewCard }
{
function TNewCard.AfterUpdateBatch(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('update BAS_CUSTOMER set IC_CARDNO=:IC_CARDNO '
   + ',COMM=' + GetCommStr(iDbType) + ','
   + 'TIME_STAMP='+GetTimeStamp(iDbType)+' where CUST_ID=:CUST_ID ',SELF);
  Result:=True;
end;}

procedure TNewCard.InitClass;
var SQL:string;
begin
  inherited;
  SelectSQL.Text := 'select A.CLIENT_ID,A.TENANT_ID,A.UNION_ID,A.IC_CARDNO,A.CREA_DATE,A.CREA_USER,A.IC_INFO,A.IC_STATUS,B.CUST_NAME,'+
  'A.IC_TYPE,A.ACCU_INTEGRAL,A.RULE_INTEGRAL,A.INTEGRAL,A.BALANCE,A.PASSWRD,A.USING_DATE from PUB_IC_INFO A left join PUB_CUSTOMER B '+
  'on B.CUST_ID=A.CLIENT_ID and B.TENANT_ID=A.TENANT_ID  where A.CLIENT_ID=:CLIENT_ID and A.TENANT_ID=:TENANT_ID and A.UNION_ID=:UNION_ID ';
  IsSQLUpdate := true;

  SQL := 'update PUB_IC_INFO set IC_CARDNO=:IC_CARDNO,PASSWRD=:PASSWRD,BALANCE=:BALANCE,COMM='+
  GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID';
  UpdateSQL.Text := SQL;
end;

{ TDeposit }
{
function TDeposit.AfterUpdateBatch(AGlobal: IdbHelp): Boolean;
var tmp:TZQuery;
begin
   AGlobal.ExecSQL('update RCK_IC_INFO set BALANCE=isnull(BALANCE,0)+:IC_AMONEY,'
       + 'COMM=' + GetCommStr(iDbType) + ','
       + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
       + 'where IC_CARDNO=:IC_CARDNO',self);

    tmp:=TZQuery.Create(nil);
    try
      tmp.Close;
      tmp.SQL.Text:='select BALANCE from RCK_IC_INFO where IC_CARDNO='''+FieldByName('IC_CARDNO').AsString+'''';
      AGlobal.Open(tmp);
      if tmp.FieldByName('BALANCE').AsFloat<0 then
        Raise Exception.Create('退款金额不能大于卡上余额!');
    finally
      tmp.Free;
    end;

   Result := true;
end; }

procedure TDeposit.InitClass;
var SQL:string;
begin
  inherited;
  SelectSQL.Text := 'select COMP_ID,CUST_ID,PAY_CASH,PAY_A,ACCT_ID,OPER_USER,GLIDE_ID,IC_CARDNO,CREA_DATE,GLIDE_INFO,IC_GLIDE_TYPE,IC_AMONEY,SALES_ID from RCK_IC_GLIDE where GLIDE_ID=:GLIDE_ID';
  IsSQLUpdate := true;
  SQL := 'insert into RCK_IC_GLIDE(COMP_ID,CUST_ID,PAY_CASH,PAY_A,ACCT_ID,OPER_USER,GLIDE_ID,IC_CARDNO,CREA_DATE,GLIDE_INFO,IC_GLIDE_TYPE,IC_AMONEY,SALES_ID,COMM,TIME_STAMP) '+
     'values(:COMP_ID,:CUST_ID,:PAY_CASH,:PAY_A,:ACCT_ID,:OPER_USER,:GLIDE_ID,:IC_CARDNO,convert(varchar(10),getdate(),120),:GLIDE_INFO,''1'',:IC_AMONEY,:SALES_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := SQL;
end;

{ TSelectDeposit }

procedure TSelectDeposit.InitClass;
var SQL:string;
begin
  inherited;
  SelectSQL.Text:=
  ' select A.*,B.USER_NAME OPER_USER_TEXT from (select IC_CARDNO,PAY_CASH,PAY_A,OPER_USER,CREA_DATE, '+
  ' GLIDE_INFO,IC_AMONEY from RCK_IC_GLIDE '+
  ' where IC_GLIDE_TYPE=''1'' and CUST_ID=:CUST_ID ) A  '+
  ' left outer join VIW_USERS B on A.OPER_USER=B.USER_ID  order by CREA_DATE DESC ';
  IsSQLUpdate:=true;
end;

{ TCustomerSalesData }

procedure TCustomerSalesData.InitClass;
begin
  inherited;
  SelectSQL.Text:='select ji.*,J.GODS_NAME from '+
  '(select jh.*,I.COMP_NAME from  '+
  '(select jf.*,H.CUST_NAME from   '+
  '(select je.*,F.CODE_NAME COLORNAME from    '+
  '(select jd.*,E.CODE_NAME SIZENAME from   '+
  '(select jc.*,D.UNIT_NAME from     '+
  '(select A.SALES_TYPE,A.COMP_ID,A.GLIDE_NO,A.SALES_DATE,A.CUST_ID,B.AMOUNT,B.GODS_ID,   '+
  'B.APRICE,B.AMONEY,B.PROPERTY_01,B.PROPERTY_02,B.UNIT_ID from SAL_SALESORDER A,SAL_SALESDATA B      '+
  ' where A.SALES_ID=B.SALES_ID and A.SALES_TYPE<>2  and A.CUST_ID=:CUST_ID)jc  '+
  'left outer join (select UNIT_ID,UNIT_NAME from PUB_MEAUNITS)D on jc.UNIT_ID=D.UNIT_ID)jd    '+
  'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO    '+
  'where  CODE_TYPE=''2'' and len(CODE_ID)=3)E on jd.PROPERTY_01=E.CODE_ID)je    '+
  'left outer join (select CODE_ID,CODE_NAME from PUB_CODE_INFO   '+
  'where CODE_TYPE=''4'' and len(CODE_ID)=3)F on je.PROPERTY_02=F.CODE_ID)jf    '+
  'left outer join VIW_CUSTOMER H on jf.CUST_ID=H.CUST_ID)jh   '+
  'left outer join CA_COMPANY I on jh.COMP_ID=I.COMP_ID)ji '+
  'left outer join VIW_GOODSINFO J on ji.COMP_ID=J.COMP_ID and ji.GODS_ID=J.GODS_ID order by ji.SALES_DATE DESC';
  IsSQLUpdate:=true;
end;

{ TNewCardUpdate }

function TNewCardUpdate.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
begin
  Result:=False;
  AGlobal.BeginTrans;
  try
      if Params.ParamByName('TYPE').asString='1' then
      begin
        AGlobal.ExecSQL('update RCK_IC_INFO set IC_STATUS=''1'',BALANCE=''0'''
        + ',COMM=' + GetCommStr(AGlobal.iDbType) + ','
        + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where IC_CARDNO='''+Params.ParamByName('IC_CARDNO').asString+'''');
        AGlobal.ExecSQL('update BAS_CUSTOMER set IC_CARDNO='''+Params.ParamByName('IC_CARDNO').asString+''' '
        + ',COMM=' + GetCommStr(AGlobal.iDbType) + ','
        + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where CUST_ID='''+Params.ParamByName('CUST_ID').asString+'''');
      end;
      if Params.ParamByName('TYPE').asString='2' then
      begin
        AGlobal.ExecSQL('update RCK_IC_INFO set IC_STATUS=''2'' '
        + ',COMM=' + GetCommStr(AGlobal.iDbType) + ','
        + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where IC_CARDNO='''+Params.ParamByName('IC_CARDNO').asString+'''');
        AGlobal.ExecSQL('update BAS_CUSTOMER set IC_CARDNO='''' '
        + ',COMM=' + GetCommStr(AGlobal.iDbType) + ','
        + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where CUST_ID='''+Params.ParamByName('CUST_ID').asString+'''');
      end;
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
procedure TSelectCard.InitClass;
begin
  inherited;
  SelectSQL.Text := 'select CREA_DATE,IC_INFO,B.USER_NAME,BALANCE from RCK_IC_INFO A,VIW_USERS B where A.IC_CARDNO=:IC_CARDNO and A.CREA_USER=B.USER_ID';
  IsSQLUpdate := true;
end;

{ TRenew }

{function TRenew.AfterUpdateBatch(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('update BAS_CUSTOMER set INTEGRAL=:INTEGRAL2,END_DATE=:END_DATE2,CON_DATE=:CREA_DATE '
   + ',COMM=' + GetCommStr(iDbType) + ','
   + 'TIME_STAMP='+GetTimeStamp(iDbType)+' where CUST_ID=:CUST_ID ',SELF);
  Result:=True;
end;  }

procedure TRenew.InitClass;
var SQL:string;
begin
  inherited;
  SelectSQL.Text := 'select COMP_ID,PAY_A,GLIDE_ID,CUST_ID,CREA_DATE,GLIDE_INFO,OPER_USER   '+
  '   ,AMONEY,ACCU_INTEGRAL,INTEGRAL1,INTEGRAL2,END_DATE1  '+
  '   ,END_DATE2 from RCK_RENEW_GLIDE where GLIDE_ID=:GLIDE_ID';
  IsSQLUpdate := true;
  SQL := 'insert into RCK_RENEW_GLIDE(COMP_ID,PAY_A,GLIDE_ID,CUST_ID,CREA_DATE,GLIDE_INFO,OPER_USER   '+
  '   ,AMONEY,ACCU_INTEGRAL,INTEGRAL1,INTEGRAL2,END_DATE1  '+
  '   ,END_DATE2,COMM,TIME_STAMP) '+
  '  values(:COMP_ID,:PAY_A,newid(),:CUST_ID,:CREA_DATE,:GLIDE_INFO,:OPER_USER,'+
  '  :AMONEY,:ACCU_INTEGRAL,:INTEGRAL1,:INTEGRAL2,'+
  ' :END_DATE1,:END_DATE2,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := SQL;
end;

{ TUnionIndex }

procedure TUnionIndex.InitClass;
var Str:String;
begin
  inherited;
  SelectSQL.Text := 'select TENANT_ID,UNION_ID,INDEX_ID,INDEX_NAME,INDEX_SPELL,INDEX_TYPE,INDEX_OPTION,INDEX_ISNULL from PUB_UNION_INDEX '+
  ' where TENANT_ID=:TENANT_ID and UNION_ID=:UNION_ID and INDEX_ID=:INDEX_ID ';
  IsSQLUpdate := true;

  Str :=
  'insert into [PUB_CUSTOMER_EXT] (TENANT_ID,UNION_ID,INDEX_ID,INDEX_NAME,INDEX_SPELL,INDEX_TYPE,INDEX_OPTION,INDEX_ISNULL,COMM,STAMP_TIME) '+
  'values(:TENANT_ID,:UNION_ID,:INDEX_ID,:INDEX_NAME,:INDEX_SPELL,:INDEX_TYPE,:INDEX_OPTION,:INDEX_ISNULL,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str :=
  'update PUB_UNION_INDEX set TENANT_ID=:TENANT_ID,UNION_ID=:UNION_ID,INDEX_ID=:INDEX_ID,INDEX_NAME=:INDEX_NAME,INDEX_SPELL=:INDEX_SPELL,INDEX_TYPE=:,INDEX_OPTION=:,INDEX_ISNULL=:,COMM=:,STAMP_TIME=: where ';
  UpdateSQL.Text := Str;
end;

{ TPubIcInfo }

procedure TPubIcInfo.InitClass;
var Str:String;
begin
  inherited;
  SelectSQL.Text :=
  'select j.UNION_NAME,j.UNION_ID,ic.CLIENT_ID,ic.TENANT_ID,ic.UNION_ID,ic.IC_CARDNO,ic.IC_CARDNO,ic.CREA_DATE,ic.CREA_USER,ic.IC_INFO,ic.IC_STATUS,ic.IC_TYPE,'+
  'ic.ACCU_INTEGRAL,ic.RULE_INTEGRAL,ic.INTEGRAL,ic.BALANCE,''详情'' as UNION_INFO from ('+
  'select  '''+Params.ParambyName('CUST_ID').asString+''' as CLIENT_ID,'+Params.ParambyName('TENANT_ID').asString+' as TENANT_ID,''#'' as UNION_ID,''企业会员'' as UNION_NAME from CA_TENANT where TENANT_ID=:TENANT_ID '+
  'union all '+
  'select '''+Params.ParambyName('CUST_ID').asString+''' as CLIENT_ID,TENANT_ID,PRICE_ID as UNION_ID,PRICE_NAME as UNION_NAME from PUB_PRICEGRADE where TENANT_ID=:TENANT_ID and PRICE_TYPE=''2'' '+
  ') j left outer join PUB_IC_INFO ic on j.TENANT_ID=ic.TENANT_ID and j.UNION_ID=ic.UNION_ID and j.CLIENT_ID=ic.CLIENT_ID';
  IsSQLUpdate := true;

  Str :=
  'insert into PUB_IC_INFO(CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,ACCU_INTEGRAL,RULE_INTEGRAL,INTEGRAL,'+
  'BALANCE,PASSWRD,USING_DATE,COMM,TIME_STAMP) values(:CUST_ID,:TENANT_ID,:UNION_ID,:IC_CARDNO,:CREA_DATE,:CREA_USER,'+
  ':IC_INFO,:IC_STATUS,:IC_TYPE,0,0,0,0,null,null,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str :=
  'update PUB_IC_INFO set IC_CARDNO=:IC_CARDNO,CREA_DATE=:CREA_DATE,'+
  'CREA_USER=:CREA_USER,IC_INFO=:IC_INFO,IC_STATUS=:IC_STATUS,IC_TYPE=:IC_TYPE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+
  GetTimeStamp(iDbType)+' where CLIENT_ID=:OLD_CLIENT_ID and TENANT_ID=:OLD_TENANT_ID and UNION_ID=:OLD_UNION_ID' ;
  UpdateSQL.Text := Str;
end;

{ TCustomerExt }

procedure TCustomerExt.InitClass;
var Str:String;
begin
  inherited;
  SelectSQL.Text :=
  'select ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE from PUB_CUSTOMER_EXT where TENANT_ID=:TENANT_ID and'+
  ' UNION_ID=:UNION_ID and CUST_ID=:CUST_ID';
  IsSQLUpdate := true;

  Str :=
  ' insert into PUB_CUSTOMER_EXT(ROWS_ID,TENANT_ID,UNION_ID,CUST_ID,INDEX_ID,INDEX_NAME,INDEX_TYPE,INDEX_VALUE,COMM,TIME_STAMP) '+
  ' values(:ROWS_ID,:TENANT_ID,:UNION_ID,:CUST_ID,:INDEX_ID,:INDEX_NAME,:INDEX_TYPE,:INDEX_VALUE,''00'','+GetTimeStamp(iDbType)+') ';
  InsertSQL.Text := Str;

  Str :=
  'update PUB_CUSTOMER_EXT set UNION_ID=:UNION_ID,CUST_ID=:CUST_ID,INDEX_ID=:INDEX_ID,INDEX_NAME=:INDEX_NAME,INDEX_TYPE=:INDEX_TYPE,'+
  'INDEX_VALUE=:INDEX_VALUE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+
  GetTimeStamp(iDbType)+' where ROWS_ID=:OLD_ROWS_ID and TENANT_ID=:OLD_TENANT_ID ';
  UpdateSQL.Text := Str;

  Str :=
  'update PUB_CUSTOMER_EXT set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where ROWS_ID=:OLD_ROWS_ID and TENANT_ID=:OLD_TENANT_ID ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TCustomer);
  RegisterClass(TIntegralGlide);
  RegisterClass(TSelectIntegralGlide);
  RegisterClass(TNewCard);
  RegisterClass(TSelectCard);
  RegisterClass(TDeposit);
  RegisterClass(TSelectDeposit);
  RegisterClass(TRenew);
  RegisterClass(TCustomerSalesData);
  RegisterClass(TNewCardUpdate);
  RegisterClass(TPubIcInfo);
  RegisterClass(TCustomerExt);
finalization
  UnRegisterClass(TCustomer);
  UnRegisterClass(TIntegralGlide);
  UnRegisterClass(TSelectIntegralGlide);
  UnRegisterClass(TNewCard);
  UnRegisterClass(TSelectCard);  
  UnRegisterClass(TDeposit);
  UnRegisterClass(TSelectDeposit);
  UnRegisterClass(TRenew);
  UnRegisterClass(TCustomerSalesData);
  UnRegisterClass(TNewCardUpdate);
  UnRegisterClass(TPubIcInfo);
  UnRegisterClass(TCustomerExt);
end.
