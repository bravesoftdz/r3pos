unit ObjSalesOrderV60;

interface

uses Dialogs,SysUtils,zBase,Classes,zintf,ObjCommon,DB,ZDataSet,math,ObjSyncFactoryV60;

type

  TSalesOrderV60=class(TZFactory)
  private
    lock:boolean;
    isSync:boolean;
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TSalesDataV60=class(TZFactory)
  private
    IsZeroOut:Boolean;
    lock:boolean;
    isSync:boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

  TSalesICDataV60=class(TZFactory)
  private
    lock:boolean;
    isSync:boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

  TSyncSalesOrderV60=class(TSyncSingleTableV60)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TSyncSalesDataV60=class(TSyncSingleTableV60)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TSyncSalesICDataV60=class(TSyncSingleTableV60)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation

uses uFnUtil, DateUtils;

{ TStockData }

function TSalesDataV60.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
   w:integer;
   s:string;
begin
  Result := true;
  //对整单库存进行检测
  if isSync then Exit;
  if IsZeroOut then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
        'select jp2.*,p2.COLOR_NAME as COLOR_NAME from ('+
        'select jp1.*,p1.SIZE_NAME as SIZE_NAME from ('+
        'select b.GODS_CODE,b.GODS_NAME,j.TENANT_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.IS_PRESENT,j.LOCUS_NO,j.BOM_ID from ('+
        'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.BATCH_NO,B.IS_PRESENT,B.LOCUS_NO,B.BOM_ID from STO_STORAGE A,SAL_SALESDATA B '+
        'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 and A.BATCH_NO=B.BATCH_NO '+
        ' and round(A.AMOUNT,3)<0 and B.SALES_ID=:SALES_ID and B.SHOP_ID=:SHOP_ID and B.TENANT_ID=:TENANT_ID '+
        ') j inner join VIW_GOODSINFO b on j.GODS_ID=b.GODS_ID and j.TENANT_ID=b.TENANT_ID '+
        ') jp1 left outer join VIW_SIZE_INFO p1 on jp1.PROPERTY_01=p1.SIZE_ID and jp1.TENANT_ID=p1.TENANT_ID'+
        ') jp2 left outer join VIW_COLOR_INFO p2 on jp2.PROPERTY_02=p2.COLOR_ID and jp2.TENANT_ID=p2.TENANT_ID';
    rs.Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.Params.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsString;
    rs.Params.ParamByName('SALES_ID').AsString := FieldbyName('SALES_ID').AsString;
    AGlobal.Open(rs);
    w := 0;
    s := '';
    rs.first;
    while not rs.Eof do
      begin
        inc(w);
        if s<>'' then s := s + #10;
        s := s +'('+rs.FieldbyName('GODS_CODE').AsString+')'+rs.FieldbyName('GODS_NAME').AsString;
        if rs.FieldbyName('IS_PRESENT').AsString='1' then
           s := s + '(赠品)';
        if rs.FieldbyName('BOM_ID').AsString <> '' then
           s := s+ '(礼盒)';
        if rs.FieldbyName('SIZE_NAME').AsString <> '' then
           s := s+ '  尺码:'+rs.FieldbyName('SIZE_NAME').AsString+'';
        if rs.FieldbyName('COLOR_NAME').AsString <> '' then
           s := s+ '  颜色:'+rs.FieldbyName('COLOR_NAME').AsString+'';
        if rs.FieldbyName('BATCH_NO').AsString <> '#' then
           s := s+ '  批号:'+rs.FieldbyName('COLOR_NAME').AsString+'';
        if rs.FieldbyName('LOCUS_NO').AsString <> '' then
           s := s+ '  跟踪号:'+rs.FieldbyName('LOCUS_NO').AsString+'';
        if w>5 then break;
        rs.Next;
      end;
    if s<>'' then Raise Exception.Create(s+#10+'--商品库存不足,请核对是否输入正确？');
  finally
    rs.Free;
  end;
end;

function TSalesDataV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asOldString,FieldbyName('SHOP_ID').asOldString,
             FieldbyName('GODS_ID').asOldString,
             FieldbyName('PROPERTY_01').asOldString,
             FieldbyName('PROPERTY_02').asOldString,
             FieldbyName('BATCH_NO').asOldString,
             FieldbyName('CALC_AMOUNT').asOldFloat,
             roundto(FieldbyName('COST_PRICE').asOldFloat*FieldbyName('CALC_AMOUNT').asOldFloat,-2),3);
//  if not lock then
//     WriteLogInfo(AGlobal,Parant.FieldbyName('CREA_USER').AsString,2,'500026','删除【单号'+Parant.FieldbyName('GLIDE_NO').asString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'SAL_SALESDATA',usDeleted));
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TSalesDataV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
//改由开单前台最当最新进价
//  FieldbyName('COST_PRICE').AsFloat := GetCostPrice(AGlobal,FieldbyName('TENANT_ID').AsString,FieldbyName('SHOP_ID').AsString,FieldbyName('GODS_ID').AsString,FieldbyName('PROPERTY_01').AsString,FieldbyName('PROPERTY_02').AsString,FieldbyName('BATCH_NO').AsString);
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').AsFloat,
             roundto(FieldbyName('COST_PRICE').AsFloat*FieldbyName('CALC_AMOUNT').AsFloat,-2),2);

  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TSalesDataV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
//  WriteLogInfo(AGlobal,Parant.FieldbyName('CREA_USER').AsString,2,'500026','修改【单号'+Parant.FieldbyName('GLIDE_NO').asString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'SAL_SALESDATA',usModified));
end;

function TSalesDataV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var Temp:TZQuery;
begin
  Result := true;
  isSync := Params.FindParam('SyncFlag')<>nil;
  case AGlobal.iDbType of
  0:AGlobal.ExecSQL('select count(*) from STO_STORAGE with(UPDLOCK) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID',self);
  1:AGlobal.ExecSQL('select count(*) from STO_STORAGE  where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID for update',self);
  4:AGlobal.ExecSQL('select count(*) from STO_STORAGE  where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID WITH RS USE AND KEEP UPDATE LOCKS',self);
  end;
  if isSync then Exit;
  Temp := TZQuery.Create(nil);
  try
     Temp.close;
     Temp.SQL.Text  := 'select VALUE from SYS_DEFINE where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and DEFINE=''ZERO_OUT''';
     AGlobal.Open(Temp);
     IsZeroOut := (Temp.Fields[0].AsString = '') or (Temp.Fields[0].AsString = '1');
  finally
     Temp.free;
  end;
end;

procedure TSalesDataV60.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               ' select b.GODS_NAME,b.GODS_CODE,j.TENANT_ID,j.SHOP_ID,j.SALES_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.POLICY_TYPE,'+
               ' j.IS_PRESENT,j.BARTER_INTEGRAL,j.COST_PRICE,j.APRICE,j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,'+
               ' j.HAS_INTEGRAL,j.REMARK,j.TREND_ID,b.BARCODE,j.TAX_RATE from SAL_SALESDATA j inner join ('+Params.ParambyName('VIW_GOODSINFO').AsString+') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.SALES_ID=:SALES_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := ' insert into SAL_SALESDATA (TENANT_ID,SHOP_ID,SALES_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,BOM_ID,UNIT_ID,AMOUNT,ORG_PRICE,'+
         ' POLICY_TYPE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,BARTER_INTEGRAL,HAS_INTEGRAL,REMARK,TREND_ID,COST_PRICE,TAX_RATE) '+
         ' values (:TENANT_ID,:SHOP_ID,:SALES_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:BOM_ID,:UNIT_ID,:AMOUNT,:ORG_PRICE,'+
         ' :POLICY_TYPE,:IS_PRESENT,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:BARTER_INTEGRAL,:HAS_INTEGRAL,:REMARK,:TREND_ID,:COST_PRICE,:TAX_RATE)';
  InsertSQL.Text := str;
  Str := ' update SAL_SALESDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SALES_ID=:SALES_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,BOM_ID=:BOM_ID,UNIT_ID=:UNIT_ID,'+
         ' AMOUNT=:AMOUNT,ORG_PRICE=:ORG_PRICE,COST_PRICE=:COST_PRICE,POLICY_TYPE=:POLICY_TYPE,IS_PRESENT=:IS_PRESENT,APRICE=:APRICE,AMONEY=:AMONEY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY,CALC_AMOUNT=:CALC_AMOUNT,'+
         ' CALC_MONEY=:CALC_MONEY,BARTER_INTEGRAL=:BARTER_INTEGRAL,HAS_INTEGRAL=:HAS_INTEGRAL,REMARK=:REMARK,TREND_ID=:TREND_ID,TAX_RATE=:TAX_RATE '+
         ' where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from SAL_SALESDATA where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TSalesOrderV60 }

function TSalesOrderV60.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TSalesOrderV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  if not Lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,True) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  //还原积分
  if (length(FieldbyName('CLIENT_ID').AsOldString)>0) and (FieldbyName('UNION_ID').AsString='#') then
  begin
     if FieldbyName('INTEGRAL').AsOldInteger <> 0 then
     AGlobal.ExecSQL(
         ParseSQL(iDbType,
         'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :OLD_INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) - :OLD_INTEGRAL'+
         ' where TENANT_ID=:OLD_TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:OLD_CLIENT_ID')
     ,self);
     if FieldbyName('BARTER_INTEGRAL').AsOldInteger <> 0 then
     AGlobal.ExecSQL(
         ParseSQL(iDbType,
         'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)+ :OLD_BARTER_INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) - :OLD_BARTER_INTEGRAL '+
         ' where TENANT_ID=:OLD_TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:OLD_CLIENT_ID')
     ,self);
  end;

  if (FieldbyName('PAY_D').AsOldFloat <> 0) then
     begin
         rs := TZQuery.Create(nil);
         try
           rs.SQL.Text := 'select RECV_MNY from ACC_RECVABLE_INFO where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID and RECV_TYPE=''1''';
           rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
           rs.ParamByName('SALES_ID').AsString := FieldbyName('SALES_ID').AsOldString;
           AGlobal.Open(rs);
           if not isSync and (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('已经收款的销售单不能修改...');
           if rs.Fields[0].AsFloat=0 then
              AGlobal.ExecSQL('delete from ACC_RECVABLE_INFO where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and RECV_TYPE=''1''',self)
           else
              AGlobal.ExecSQL('update ACC_RECVABLE_INFO set ACCT_MNY=0,RECK_MNY=-(RECV_MNY+REVE_MNY) where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and RECV_TYPE=''1''',self);
         finally
           rs.Free;
         end;
     end;
//  if not lock then
//     WriteLogInfo(AGlobal,FieldbyName('CREA_USER').AsString,2,'500026','删除【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'SAL_SALESORDER',usDeleted));
  result := true;
end;

function TSalesOrderV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  r:integer;
  salesDate,nearBuyDate,frequency,diff: integer;
begin
   if (FieldbyName('GLIDE_NO').AsString='') then
       FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_1_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
   if (FieldbyName('PAY_D').AsFloat <> 0) then
   begin
     FieldbyName('ADVA_MNY').AsFloat := 0;
     begin
       if AGlobal.ExecSQL('update ACC_RECVABLE_INFO set ACCT_MNY=:PAY_D,RECK_MNY=:PAY_D -(RECV_MNY+REVE_MNY),ABLE_DATE=:SALES_DATE,CLIENT_ID=:CLIENT_ID,DEPT_ID=:DEPT_ID,SHOP_ID=:SHOP_ID where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID and RECV_TYPE=''1''',self)=0 then
          begin
             AGlobal.ExecSQL('insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
              + 'VALUES(:SALES_ID,:TENANT_ID,:SHOP_ID,:DEPT_ID,:CLIENT_ID,'''+'零售记账【小票号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''1'',:PAY_D,0,:ADVA_MNY,:PAY_D,:SALES_DATE,:SALES_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
             ,self);
          end;
     end;
   end;

  //更新积分以及最新购买日期
  if (length(FieldbyName('CLIENT_ID').AsString)>0) and (FieldbyName('UNION_ID').AsString='#') then
  begin
     if FieldbyName('BARTER_INTEGRAL').AsInteger<>0 then //扣减换购积分
     begin
     r := AGlobal.ExecSQL(
        ParseSQL(idbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :BARTER_INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) + :BARTER_INTEGRAL '+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID and INTEGRAL>=:BARTER_INTEGRAL')
     ,self
     );

     if r=0 then Raise Exception.Create('当前可用积分不足，不能完成积分兑换');
     end;
     if FieldbyName('INTEGRAL').AsInteger<>0 then
     AGlobal.ExecSQL(
        ParseSQL(idbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)+ :INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) + :INTEGRAL'+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID')
     ,self);

  end;
  result := true;
end;

function TSalesOrderV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
//  WriteLogInfo(AGlobal,FieldbyName('CREA_USER').AsString,2,'500026','修改【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'SAL_SALESORDER',usModified));
end;

function TSalesOrderV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
   cDate:string;
begin
   isSync := Params.FindParam('SyncFlag')<>nil;
   if isSync then
      begin
        AGlobal.ExecSQL('delete from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and (CREA_DATE>='+FieldbyName('SALES_DATE').AsOldString+' or CREA_DATE>='+FieldbyName('SALES_DATE').AsString+')',self);
        AGlobal.ExecSQL('delete from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and (END_DATE>='''+FormatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(FieldbyName('SALES_DATE').AsOldString))+''' or END_DATE>='''+FormatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(FieldbyName('SALES_DATE').AsString))+''')',self);
      end
   else
      begin
         Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('SALES_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
         if FieldbyName('SALES_DATE').AsOldString <> '' then
            Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('SALES_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
         rs := TZQuery.Create(nil);
         try
           rs.SQL.Text := 'select CLSE_DATE from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLSE_DATE in (:CLSE_DATE ,:OLD_CLSE_DATE ) and CREA_USER=:CREA_USER';
           rs.Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
           rs.Params.ParamByName('SHOP_ID').asString := FieldbyName('SHOP_ID').AsString;
           rs.Params.ParamByName('CLSE_DATE').AsInteger := FieldbyName('SALES_DATE').AsInteger;
           rs.Params.ParamByName('OLD_CLSE_DATE').AsInteger := FieldbyName('SALES_DATE').AsOldInteger;
           rs.Params.ParamByName('CREA_USER').asString := FieldbyName('CREA_USER').AsString;
           AGlobal.Open(rs);
           if not rs.IsEmpty then Raise Exception.Create('当前收银员['+FieldbyName('SALES_DATE').AsString+']号已经结账不能再开单了'+#13+'取消结账请到[财务管理]->[结账管理]中撤销.');
         finally
           rs.Free;
         end;
      end;
end;

function TSalesOrderV60.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  result := true;
  if isSync then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from SAL_SALESORDER where SALES_ID='''+FieldbyName('SALES_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString;
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and
    (
       (copy(rs.Fields[1].asString,1,1)='1')
       or
       (copy(rs.Fields[1].asString,2,1)<>'0')
    )
    then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TSalesOrderV60.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select jc.*,f.USER_NAME as GUIDE_USER_TEXT from ('+
               'select jb.*,b.CLIENT_NAME as CLIENT_ID_TEXT,b.PRICE_ID,b.INTEGRAL as ACCU_INTEGRAL,b.BALANCE,b.CLIENT_CODE from '+
               '(select TENANT_ID,SHOP_ID,DEPT_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,'+
               'ADVA_MNY,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,BANK_ID,BANK_CODE,INTEGRAL,BARTER_INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,SALES_STYLE,IC_CARDNO,UNION_ID,COMM,CREA_DATE,CREA_USER,COMM_ID,'+
               'TIME_STAMP,LOCUS_STATUS from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) jb '+
               ' left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
               ' left outer join VIW_USERS f on jc.TENANT_ID=f.TENANT_ID and jc.GUIDE_USER=f.USER_ID';
  IsSQLUpdate := True;
  Str := 'insert into SAL_SALESORDER(TENANT_ID,SHOP_ID,DEPT_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,ADVA_MNY,PAY_A,PAY_B,PAY_C,'+
      'PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,BANK_ID,BANK_CODE,INTEGRAL,BARTER_INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,COMM_ID,COMM,CREA_DATE,CREA_USER,TIME_STAMP,LINKMAN,TELEPHONE,SEND_ADDR,SALES_STYLE,IC_CARDNO,UNION_ID,LOCUS_STATUS) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:DEPT_ID,:SALES_ID,:GLIDE_NO,:SALES_DATE,:SALES_TYPE,:PLAN_DATE,:CLIENT_ID,:GUIDE_USER,:CHK_DATE,:CHK_USER,:FROM_ID,:FIG_ID,:SALE_AMT,:SALE_MNY,:CASH_MNY,:PAY_ZERO,:PAY_DIBS,:ADVA_MNY,:PAY_A,:PAY_B,:PAY_C,:PAY_D,'+
      ':PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,:BANK_ID,:BANK_CODE,:INTEGRAL,:BARTER_INTEGRAL,:REMARK,:INVOICE_FLAG,:TAX_RATE,:COMM_ID,''00'','+GetSysDateFormat(iDbType)+',:CREA_USER,'+GetTimeStamp(iDbType)+',:LINKMAN,:TELEPHONE,:SEND_ADDR,:SALES_STYLE,:IC_CARDNO,:UNION_ID,:LOCUS_STATUS)';
  InsertSQL.Text := Str;
  Str := 'update SAL_SALESORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,SALES_ID=:SALES_ID,GLIDE_NO=:GLIDE_NO,SALES_DATE=:SALES_DATE,PLAN_DATE=:PLAN_DATE,SALES_TYPE=:SALES_TYPE,CLIENT_ID=:CLIENT_ID,'+
         'GUIDE_USER=:GUIDE_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,FROM_ID=:FROM_ID,FIG_ID=:FIG_ID,SALE_AMT=:SALE_AMT,SALE_MNY=:SALE_MNY,CASH_MNY=:CASH_MNY,PAY_ZERO=:PAY_ZERO,PAY_DIBS=:PAY_DIBS,PAY_A=:PAY_A,PAY_B=:PAY_B,'+
         'PAY_C=:PAY_C,PAY_D=:PAY_D,PAY_E=:PAY_E,PAY_F=:PAY_F,PAY_G=:PAY_G,PAY_H=:PAY_H,PAY_I=:PAY_I,PAY_J=:PAY_J,BANK_ID=:BANK_ID,BANK_CODE=:BANK_CODE,INTEGRAL=:INTEGRAL,BARTER_INTEGRAL=:BARTER_INTEGRAL,REMARK=:REMARK,INVOICE_FLAG=:INVOICE_FLAG,TAX_RATE=:TAX_RATE,'
    + 'COMM=' + GetCommStr(iDbType) + ',LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,SEND_ADDR=:SEND_ADDR,SALES_STYLE=:SALES_STYLE,IC_CARDNO=:IC_CARDNO,UNION_ID=:UNION_ID,COMM_ID=:COMM_ID,LOCUS_STATUS=:LOCUS_STATUS,'
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_SALESORDER where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  DeleteSQL.Text := Str;
end;

{ TSalesICDataV60 }

function TSalesICDataV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
begin
  if (FieldbyName('PAY_C').AsOldFloat <>0) and (FieldbyName('UNION_ID').AsString='#') then
  begin
    r := AGlobal.ExecSQL(ParseSQL(iDbType,'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) + :OLD_PAY_C where TENANT_ID=:OLD_TENANT_ID and IC_CARDNO=:OLD_IC_CARDNO and UNION_ID=''#'' and IC_STATUS in (''0'',''1'')'),self);
    if (r=0) and not isSync then Raise Exception.Create(FieldbyName('IC_CARDNO').asOldString+'卡号无效,无法执行相关操作..');
  end;
end;

function TSalesICDataV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  rs:TZQuery;
begin
  if (FieldbyName('PAY_C').AsFloat <>0) and (FieldbyName('UNION_ID').AsString='#') then
  begin
    r := AGlobal.ExecSQL(ParseSQL(iDbType,'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) - :PAY_C where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#'' and IC_STATUS in (''0'',''1'')'),self);
    if isSync then Exit;
    if r=0 then Raise Exception.Create(FieldbyName('IC_CARDNO').asString+'卡号无效,无法执行相关操作..');
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select BALANCE from PUB_IC_INFO where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#'' ';
      rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
      rs.ParamByName('IC_CARDNO').AsString := FieldbyName('IC_CARDNO').AsString;
      AGlobal.Open(rs);
      if rs.Fields[0].AsFloat<0 then Raise Exception.Create(FieldbyName('IC_CARDNO').AsString+'的储值卡余额不足，不能完成支付');
    finally
      rs.Free;
    end;
  end;
end;

function TSalesICDataV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TSalesICDataV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
   isSync := Params.FindParam('SyncFlag')<>nil;
   result := true;
end;

procedure TSalesICDataV60.InitClass;
var Str:string;
begin
  inherited;
  SelectSQL.Text := 'select * from SAL_IC_GLIDE where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID and IC_GLIDE_TYPE=''2'' and COMM not in (''02'',''12'')';
  IsSQLUpdate := true;
  
  Str :=
    'insert into SAL_IC_GLIDE(GLIDE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,IC_CARDNO,SALES_ID,CREA_USER,CREA_DATE,GLIDE_INFO,IC_GLIDE_TYPE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,GLIDE_MNY,CHK_DATE,CHK_USER,COMM,TIME_STAMP) '+
    'values(:GLIDE_ID,:TENANT_ID,:SHOP_ID,:CLIENT_ID,:IC_CARDNO,:SALES_ID,:CREA_USER,:CREA_DATE,:GLIDE_INFO,:IC_GLIDE_TYPE,0,0,:PAY_C,0,0,0,0,0,0,0,:GLIDE_MNY,:CHK_DATE,:CHK_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str :=
    'update SAL_IC_GLIDE set GLIDE_ID=:GLIDE_ID,TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,IC_CARDNO=:IC_CARDNO,SALES_ID=:SALES_ID,CREA_USER=:CREA_USER,CREA_DATE=:CREA_DATE,GLIDE_INFO=:GLIDE_INFO,IC_GLIDE_TYPE=:IC_GLIDE_TYPE,'+
    'PAY_A=0,PAY_B=0,PAY_C=:PAY_C,PAY_D=0,PAY_E=0,PAY_F=0,PAY_G=0,PAY_H=0,PAY_I=0,PAY_J=0,GLIDE_MNY=:GLIDE_MNY,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,'+
    'COMM=' + GetCommStr(iDbType) + ','+
    'TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where TENANT_ID=:OLD_TENANT_ID and GLIDE_ID=:OLD_GLIDE_ID';
  UpdateSQL.Text := Str;
  
  Str :=
    'update SAL_IC_GLIDE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and GLIDE_ID=:OLD_GLIDE_ID';
  DeleteSQL.Text := Str;
end;

{ TSyncSalesOrderV60 }

function TSyncSalesOrderV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text :=
     'select j.*,a.ABLE_ID,b.NEAR_BUY_DATE,b.FREQUENCY from '+
     '(select '+Params.ParamByName('TABLE_FIELDS').AsString+' from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) j '+
     'left outer join ACC_RECVABLE_INFO a on j.TENANT_ID=a.TENANT_ID and j.SALES_ID=a.SALES_ID '+
     'left outer join PUB_IC_INFO b on j.TENANT_ID=b.TENANT_ID and j.CLIENT_ID=b.CLIENT_ID and b.UNION_ID=''#'' ';
end;

function TSyncSalesOrderV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
  procedure InsertAbleInfo;
  var rs:TZQuery;
  begin
    if (FieldbyName('PAY_D').AsFloat <> 0) and (FieldbyName('SALES_TYPE').AsInteger in [1,3,4]) and (FieldbyName('ABLE_ID').asString<>'') then
    begin
      if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
      begin
        rs := TZQuery.Create(nil);
        try
          rs.SQL.Text :=
           'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
           'values (:ABLE_ID,:TENANT_ID,:SHOP_ID,:DEPT_ID,:CLIENT_ID,:ACCT_INFO,:RECV_TYPE,:PAY_D,0,:ADVA_MNY,:RECK_MNY,:SALES_DATE,:SALES_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
          CopyToParams(rs.Params);
          case FieldbyName('SALES_TYPE').AsInteger of
            1,4: begin
              rs.ParambyName('RECV_TYPE').AsString := '1';
              rs.ParambyName('ACCT_INFO').AsString := '销售货款【出货单号'+FieldbyName('GLIDE_NO').AsString+'】';
            end;
            3:   begin
              rs.ParambyName('RECV_TYPE').AsString := '2';
              rs.ParambyName('ACCT_INFO').AsString := '销售退款【退货单号'+FieldbyName('GLIDE_NO').AsString+'】';
            end;
          end;
          rs.ParambyName('ABLE_ID').AsString := FieldbyName('ABLE_ID').asString;
          rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
          AGlobal.ExecQuery(rs);
        finally
          rs.Free;
        end;
      end;
    end;
  end;

  procedure InsertIntegralInfo;
  var rs:TZQuery;
  begin
    //更新积分
    if length(FieldbyName('CLIENT_ID').AsString)>0 then
    begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text :=
        ParseSQL(idbType,
        ' update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) + :RULE_INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) + :ACCU_INTEGRAL,'+
        ' NEAR_BUY_DATE=:NEAR_BUY_DATE,FREQUENCY=:FREQUENCY '+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID');
        rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
        rs.ParamByName('CLIENT_ID').AsString := FieldbyName('CLIENT_ID').AsString;
        rs.ParamByName('INTEGRAL').AsInteger := FieldbyName('BARTER_INTEGRAL').AsInteger-FieldbyName('INTEGRAL').AsInteger;
        rs.ParamByName('ACCU_INTEGRAL').AsInteger := FieldbyName('INTEGRAL').AsInteger;
        rs.ParamByName('RULE_INTEGRAL').AsInteger := FieldbyName('BARTER_INTEGRAL').AsInteger;
        rs.ParamByName('NEAR_BUY_DATE').AsInteger := FieldbyName('NEAR_BUY_DATE').AsInteger;
        rs.ParamByName('FREQUENCY').AsInteger := FieldbyName('FREQUENCY').AsInteger;
        AGlobal.ExecQuery(rs);
      finally
        rs.Free;
      end;
    end;
  end;

  procedure UpdateAbleInfo;
  var rs:TZQuery;
  begin
    if (FieldbyName('PAY_D').AsFloat <> 0) and (FieldbyName('SALES_TYPE').AsInteger in [1,3,4]) and (FieldbyName('ABLE_ID').asString<>'') then
    begin
      if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
      begin
        rs := TZQuery.Create(nil);
        try
          rs.SQL.Text :=
           'update ACC_RECVABLE_INFO set ACCT_MNY=:PAY_D,REVE_MNY=:ADVA_MNY,RECK_MNY=round(:RECK_MNY-RECV_MNY,2),SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:SALES_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '+
           'where TENANT_ID=:TENANT_ID and ABLE_ID=:ABLE_ID and RECV_TYPE=:RECV_TYPE';
          CopyToParams(rs.Params);
          rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
          case FieldbyName('SALES_TYPE').AsInteger of
          1,4: begin
                 rs.ParambyName('RECV_TYPE').AsString := '1';
               end;
          3:   begin
                 rs.ParambyName('RECV_TYPE').AsString := '2';
               end;
          end;
          AGlobal.ExecQuery(rs);
        finally
          rs.Free;
        end;
      end;
    end;
  end;

  function UpdateIntegralInfo:boolean;
  var
    rs:TZQuery;
    Params:TftParamList;
  begin
    rs := TZQuery.Create(nil);
    Params := TftParamList.Create(nil);
    try
      rs.SQL.Text := 'select INTEGRAL,BARTER_INTEGRAL,CLIENT_ID,SALES_TYPE from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
      rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
      rs.ParamByName('SALES_ID').AsString := FieldbyName('SALES_ID').AsString;
      AGlobal.Open(rs);
      result := not rs.IsEmpty;
      if result and (rs.FieldByName('SALES_TYPE').AsInteger in [1,3,4]) then
      begin
        if (rs.Fields[0].AsInteger <> 0) or (rs.Fields[1].AsInteger <> 0) then
           begin
             Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
             Params.ParamByName('CLIENT_ID').AsString := rs.FieldbyName('CLIENT_ID').AsString;
             Params.ParamByName('INTEGRAL').AsInteger := rs.FieldbyName('INTEGRAL').AsInteger-rs.FieldbyName('BARTER_INTEGRAL').AsInteger;
             Params.ParamByName('ACCU_INTEGRAL').AsInteger := rs.FieldbyName('INTEGRAL').AsInteger;
             Params.ParamByName('RULE_INTEGRAL').AsInteger := rs.FieldbyName('BARTER_INTEGRAL').AsInteger;
             AGlobal.ExecSQL(
               ParseSQL(AGlobal.iDbType,
               'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) - :RULE_INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) - :ACCU_INTEGRAL  '+
               'where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID'),Params);
           end;
        //更新积分
        InsertIntegralInfo;
      end;
    finally
      Params.Free;
      rs.Free;
    end;
  end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_SALESORDER';
       MaxCol := RowAccessor.ColumnCount - 3;
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
         InsertIntegralInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if UpdateIntegralInfo then
                      begin
                        UpdateAbleInfo;
                        FillParams(UpdateQuery);
                        AGlobal.ExecQuery(UpdateQuery);
                      end
                   else
                      Raise;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       if UpdateIntegralInfo then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
         if r<>0 then UpdateAbleInfo;
       end
       else
         r := 0;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
              InsertIntegralInfo;
            except
              on E:Exception do
                 begin
                   if not CheckUnique(E.Message) then
                      Raise;
                 end;
            end;
          end;
     end;
end;

function TSyncSalesOrderV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update SAL_SALESORDER set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID'),self);
end;

{ TSyncSalesDataV60 }

function TSyncSalesDataV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select '+Params.ParamByName('TABLE_FIELDS').AsString+' from SAL_SALESDATA where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
end;

function TSyncSalesDataV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
  procedure InsertStorageInfo;
  begin
    if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
    DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
               FieldbyName('GODS_ID').asString,
               FieldbyName('PROPERTY_01').asString,
               FieldbyName('PROPERTY_02').asString,
               FieldbyName('BATCH_NO').asString,
               FieldbyName('CALC_AMOUNT').AsFloat,
               roundto(FieldbyName('COST_PRICE').AsFloat*FieldbyName('CALC_AMOUNT').AsFloat,-2),2);
  end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_SALESDATA';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  if (Params.FindParam('UPDATE_STORAGE')=nil) or Params.ParamByName('UPDATE_STORAGE').AsBoolean then
     InsertStorageInfo;
end;

function TSyncSalesDataV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    if (Params.FindParam('UPDATE_STORAGE')=nil) or Params.ParamByName('UPDATE_STORAGE').AsBoolean then
    begin
      rs.SQL.Text :=
         'select a.TENANT_ID,a.SHOP_ID,a.GODS_ID,a.PROPERTY_01,a.PROPERTY_02,a.BATCH_NO,a.CALC_AMOUNT,a.COST_PRICE '+
         'from SAL_SALESDATA a where a.TENANT_ID=:TENANT_ID and a.SALES_ID=:SALES_ID';
      rs.Params.AssignValues(Params); 
      AGlobal.Open(rs);
      rs.First;
      while not rs.Eof do
        begin
          IncStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                     rs.FieldbyName('GODS_ID').asString,
                     rs.FieldbyName('PROPERTY_01').asString,
                     rs.FieldbyName('PROPERTY_02').asString,
                     rs.FieldbyName('BATCH_NO').asString,
                     rs.FieldbyName('CALC_AMOUNT').AsFloat,
                     roundto(rs.FieldbyName('COST_PRICE').AsFloat*rs.FieldbyName('CALC_AMOUNT').AsFloat,-2),3);
          rs.Next;
        end;
    end;
    AGlobal.ExecSQL('delete from SAL_SALESDATA where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID',Params);
  finally
    rs.Free;
  end;
end;

{ TSyncSalesICDataV60 }

function TSyncSalesICDataV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var str:string;
begin
  str := 'select '+Params.ParambyName('TABLE_FIELDS').AsString+' from SAL_IC_GLIDE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and SALES_ID=:SALES_ID';

  if Params.ParamByName('SYN_COMM').AsBoolean then
     str := str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

function TSyncSalesICDataV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
  procedure InsertAccountInfo;
  var str:string;
  begin
    if FieldbyName('IC_GLIDE_TYPE').AsInteger = 1 then
       str := 'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) + :GLIDE_MNY where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#'''
    else
       str := 'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) - :GLIDE_MNY where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#''';
    AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,str),Self);
  end;

  function UpdateAccountInfo:boolean;
  var
    Str:string;
    rs:TZQuery;
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select IC_GLIDE_TYPE,GLIDE_MNY,IC_CARDNO from SAL_IC_GLIDE where TENANT_ID=:TENANT_ID and GLIDE_ID=:GLIDE_ID';
      rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
      rs.ParamByName('GLIDE_ID').AsString := FieldbyName('GLIDE_ID').AsString;
      AGlobal.Open(rs);
      result := not rs.IsEmpty;
      if not rs.IsEmpty then
         begin
           if rs.FieldbyName('IC_GLIDE_TYPE').AsInteger = 1 then
              Str := 'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) - '+FormatFloat('#0.000',rs.FieldbyName('GLIDE_MNY').AsFloat)+' where TENANT_ID=:TENANT_ID and IC_CARDNO='''+rs.FieldbyName('IC_CARDNO').AsString+''' and UNION_ID=''#'''
           else
              Str := 'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) + '+FormatFloat('#0.000',rs.FieldbyName('GLIDE_MNY').AsFloat)+' where TENANT_ID=:TENANT_ID and IC_CARDNO='''+rs.FieldbyName('IC_CARDNO').AsString+''' and UNION_ID=''#''';
           AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);
           InsertAccountInfo;
         end;
    finally
      rs.Free;
    end;
  end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_IC_GLIDE';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAccountInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if UpdateAccountInfo then
                   begin
                     FillParams(UpdateQuery);
                     AGlobal.ExecQuery(UpdateQuery);
                   end
                   else
                     Raise;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       if UpdateAccountInfo then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
       end
       else
         r := 0;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAccountInfo;
            except
              on E:Exception do
                 begin
                   if not CheckUnique(E.Message) then
                      Raise;
                 end;
            end;
          end;
     end;
end;

function TSyncSalesICDataV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  result := inherited BeforeUpdateRecord(AGlobal);
end;

function TSyncSalesICDataV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update SAL_IC_GLIDE set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and SALES_ID=:SALES_ID'),self);
end;

initialization
  RegisterClass(TSalesOrderV60);
  RegisterClass(TSalesDataV60);
  RegisterClass(TSalesICDataV60);
  RegisterClass(TSyncSalesOrderV60);
  RegisterClass(TSyncSalesDataV60);
  RegisterClass(TSyncSalesICDataV60);
finalization
  UnRegisterClass(TSalesOrderV60);
  UnRegisterClass(TSalesDataV60);
  UnRegisterClass(TSalesICDataV60);
  UnRegisterClass(TSyncSalesOrderV60);
  UnRegisterClass(TSyncSalesDataV60);
  UnRegisterClass(TSyncSalesICDataV60);
end.
