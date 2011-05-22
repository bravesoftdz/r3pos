unit ObjSalRetuOrder;

interface
uses Dialogs,SysUtils,zBase,Classes,zintf,ObjCommon,DB,ZDataSet,math;
type
  TSalRetuOrder=class(TZFactory)
  private
    lock:boolean;
  public
    procedure DoUpgrade(AGlobal:IdbHelp);
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TSalRetuData=class(TZFactory)
  private
    IsZeroOut:Boolean;
    lock:boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TSalRetuOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TSalRetuOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TSalRetuOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSalRetuOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSalRetuForLocusNoHeader=class(TZFactory)
  private
  public
    procedure InitClass;override;
  end;
  TSalRetuForLocusNo=class(TZFactory)
  private
  public
    procedure InitClass;override;
  end;
  TSalRetuLocusNoAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSalRetuLocusNoUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TStockData }

function TSalRetuData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
   w:integer;
   s:string;
begin
   Result := true;
   //对整单库存进行检测
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
        if IsZeroOut then Exit;
        rs := TZQuery.Create(nil);
        try
          rs.SQL.Text :=
              'select jp2.*,p2.COLOR_NAME as COLOR_NAME from ('+
              'select jp1.*,p1.SIZE_NAME as SIZE_NAME from ('+
              'select b.GODS_CODE,b.GODS_NAME,j.TENANT_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.IS_PRESENT,j.LOCUS_NO,j.BOM_ID from ('+
              'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.BATCH_NO,B.IS_PRESENT,B.LOCUS_NO,B.BOM_ID from STO_STORAGE A,SAL_SALESDATA B '+
              'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 and A.BATCH_NO=B.BATCH_NO '+
              ' and A.AMOUNT<0 and B.SALES_ID=:SALES_ID and B.SHOP_ID=:SHOP_ID and B.TENANT_ID=:TENANT_ID '+
              ') j left outer join VIW_GOODSINFO b on j.GODS_ID=b.GODS_ID and j.TENANT_ID=b.TENANT_ID '+
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
          if s<>'' then
            Raise Exception.Create(s+#10+'--商品库存不足,请核对是否输入正确？'); 
        finally
          rs.Free;
        end;
      end;
end;

function TSalRetuData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asOldString,FieldbyName('SHOP_ID').asOldString,
             FieldbyName('GODS_ID').asOldString,
             FieldbyName('PROPERTY_01').asOldString,
             FieldbyName('PROPERTY_02').asOldString,
             FieldbyName('BATCH_NO').asOldString,
             -FieldbyName('CALC_AMOUNT').asOldFloat,
             -roundto((FieldbyName('COST_PRICE').asOldFloat*FieldbyName('CALC_AMOUNT').asOldFloat),-2),3);
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

function TSalRetuData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
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
             -FieldbyName('CALC_AMOUNT').asFloat,
             -roundto((FieldbyName('COST_PRICE').asFloat*FieldbyName('CALC_AMOUNT').asFloat),-2),2);
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TSalRetuData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
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

function TSalRetuData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var Temp:TZQuery;
begin
  Result := true;
  Temp := TZQuery.Create(nil);
  try
     Temp.close;
     Temp.SQL.Text  := 'select VALUE from SYS_DEFINE where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and DEFINE=''ZERO_OUT''';
     AGlobal.Open(Temp);
     IsZeroOut := (Temp.Fields[0].AsString = '1');
  finally
     Temp.free;
  end;
  case AGlobal.iDbType of
  0:AGlobal.ExecSQL('select count(*) from STO_STORAGE with(UPDLOCK) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID',self);
  end; 
end;

procedure TSalRetuData.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select b.GODS_NAME,b.GODS_CODE,j.TENANT_ID,j.SHOP_ID,j.SALES_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,-j.AMOUNT as AMOUNT,j.ORG_PRICE,j.POLICY_TYPE,'+
               'j.IS_PRESENT,-j.BARTER_INTEGRAL as BARTER_INTEGRAL,j.COST_PRICE,j.APRICE,-j.AMONEY as AMONEY,j.AGIO_RATE,-j.AGIO_MONEY as AGIO_MONEY,-j.CALC_AMOUNT as CALC_AMOUNT,-j.CALC_MONEY as CALC_MONEY,'+
               'j.HAS_INTEGRAL,j.REMARK from SAL_SALESDATA j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.SALES_ID=:SALES_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into SAL_SALESDATA(TENANT_ID,SHOP_ID,SALES_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_NO,BOM_ID,UNIT_ID,AMOUNT,ORG_PRICE,'+
      'POLICY_TYPE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,BARTER_INTEGRAL,HAS_INTEGRAL,REMARK,COST_PRICE) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SALES_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:LOCUS_NO,:BOM_ID,:UNIT_ID,- :AMOUNT,:ORG_PRICE,'+
      ':POLICY_TYPE,:IS_PRESENT,:APRICE,- :AMONEY,:AGIO_RATE,- :AGIO_MONEY,- :CALC_AMOUNT,- :CALC_MONEY,- :BARTER_INTEGRAL,:HAS_INTEGRAL,:REMARK,:COST_PRICE)';
  InsertSQL.Text := str;
  Str := 'update SAL_SALESDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SALES_ID=:SALES_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,LOCUS_NO=:LOCUS_NO,BOM_ID=:BOM_ID,UNIT_ID=:UNIT_ID,'+
      'AMOUNT=- :AMOUNT,ORG_PRICE=:ORG_PRICE,COST_PRICE=:COST_PRICE,POLICY_TYPE=:POLICY_TYPE,IS_PRESENT=:IS_PRESENT,APRICE=:APRICE,AMONEY=- :AMONEY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=- :AGIO_MONEY,CALC_AMOUNT=- :CALC_AMOUNT,'+
      'CALC_MONEY=- :CALC_MONEY,BARTER_INTEGRAL=- :BARTER_INTEGRAL,HAS_INTEGRAL=:HAS_INTEGRAL,REMARK=:REMARK '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from SAL_SALESDATA where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TSalRetuOrder }

function TSalRetuOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  if (FieldbyName('CLIENT_ID').AsString<>'') or (FieldbyName('CLIENT_ID').AsOldString<>'') then DoUpgrade(AGlobal);
end;

function TSalRetuOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  if not Lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  //还原积分
  if length(FieldbyName('CLIENT_ID').AsOldString)>0 then
  begin
     if FieldbyName('BARTER_INTEGRAL').AsOldInteger <> 0 then
     AGlobal.ExecSQL(
        ParseSQL(iDbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)+ - :OLD_BARTER_INTEGRAL '+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:OLD_CLIENT_ID')
     ,self);
     if FieldbyName('INTEGRAL').AsOldInteger <> 0 then
     AGlobal.ExecSQL(
        ParseSQL(iDbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- - :OLD_INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) - - :OLD_INTEGRAL'+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:OLD_CLIENT_ID')
     ,self);
  end;
  
  if FieldbyName('SALE_MNY').AsOldFloat <> 0 then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select RECV_MNY from ACC_RECVABLE_INFO where TENANT_ID='+FieldbyName('TENANT_ID').AsOldString+' and SALES_ID='''+FieldbyName('SALES_ID').AsOldString+''' and RECV_TYPE=''2''';
         AGlobal.Open(rs);
         if (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('已经收款的退货单不能修改...');
       finally
         rs.Free;
       end;
       AGlobal.ExecSQL('delete from ACC_RECVABLE_INFO where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and RECV_TYPE=''2''',self);
     end;
{
  if (FieldbyName('PAY_C').AsOldFloat <> 0) and (FieldbyName('IC_CARDNO').AsOldString<>'') then
     begin
       case AGlobal.iDbType of
       0:AGlobal.ExecSQL('update RCK_IC_INFO set BALANCE=isnull(BALANCE,0)+:OLD_PAY_C where IC_CARDNO=:OLD_IC_CARDNO',self);
       3:AGlobal.ExecSQL('update RCK_IC_INFO set BALANCE=iif(isnull(BALANCE),0,BALANCEs)+:OLD_PAY_C where IC_CARDNO=:OLD_IC_CARDNO',self);
       end;
       AGlobal.ExecSQL('insert into RCK_IC_GLIDE(GLIDE_ID,CREA_DATE,GLIDE_INFO,IC_GLIDE_TYPE,IC_AMONEY,SALES_ID,COMM,TIME_STAMP,CREA_USER,CUST_ID,COMP_ID,PAY_CASH,PAY_A,ACCT_ID,IC_CARDNO) '+
                       'values(newid(),convert(varchar(10),getdate(),120),''结账(改)'',2,:OLD_PAY_C,:SALES_ID,''00'','+GetTimeStamp(iDbType)+',:OLD_SHROFF,:OLD_CUST_ID,:OLD_COMP_ID,0,0,null,:OLD_IC_CARDNO)',self);
     end;
}
//  if not lock then
//     WriteLogInfo(AGlobal,FieldbyName('CREA_USER').AsString,2,'500026','删除【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'SAL_SALESORDER',usDeleted));
  result := true;
end;

function TSalRetuOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  r:integer;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
  begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_1_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     if (FieldbyName('PAY_D').AsFloat <> 0) then
     begin
       if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
       AGlobal.ExecSQL(
           'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
         + 'VALUES('''+newid(FieldbyName('SHOP_ID').asString)+''',:TENANT_ID,:SHOP_ID,:CLIENT_ID,'''+'销售退款【单号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''2'',:PAY_D,0,- :ADVA_MNY,- :PAY_D,:SALES_DATE,:SALES_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
      ,self);
     end;
     {
     if (FieldbyName('PAY_C').AsFloat <> 0) and (FieldbyName('IC_CARDNO').AsString<>'') then
       begin
         case AGlobal.iDbType of
         0:AGlobal.ExecSQL('update RCK_IC_INFO set BALANCE=isnull(BALANCE,0)- :PAY_C where IC_CARDNO=:IC_CARDNO',self);
         3:AGlobal.ExecSQL('update RCK_IC_INFO set BALANCE=iif(isnull(BALANCE),0,BALANCE)- :PAY_C where IC_CARDNO=:IC_CARDNO',self);
         end;
         rs := TADODataSet.Create(nil);
         try
           rs.CommandText := 'select BALANCE from RCK_IC_INFO where IC_CARDNO='''+FieldbyName('IC_CARDNO').AsString+'''';
           AGlobal.Open(rs);
           if rs.Fields[0].AsFloat <0 then Raise Exception.Create('储值卡余额不足，不能支付..');  
         finally
           rs.Free;
         end;
         AGlobal.ExecSQL('insert into RCK_IC_GLIDE(GLIDE_ID,CREA_DATE,GLIDE_INFO,IC_GLIDE_TYPE,IC_AMONEY,SALES_ID,COMM,TIME_STAMP,CREA_USER,CUST_ID,COMP_ID,PAY_CASH,PAY_A,ACCT_ID,IC_CARDNO) '+
                       'values(newid(),convert(varchar(10),getdate(),120),''结账'',2,- :PAY_C,:SALES_ID,''00'','+GetTimeStamp(iDbType)+',:SHROFF,:CUST_ID,:COMP_ID,0,0,null,:IC_CARDNO)',self);
       end;
     }
  end;
  //更新积分
  if length(FieldbyName('CLIENT_ID').AsString)>0 then
  begin
     if FieldbyName('BARTER_INTEGRAL').AsInteger<>0 then //扣减换购积分
     r := AGlobal.ExecSQL(
        ParseSQL(idbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)+ :BARTER_INTEGRAL '+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID and INTEGRAL>=:BARTER_INTEGRAL')
     ,self);
     if FieldbyName('INTEGRAL').AsInteger<>0 then 
     AGlobal.ExecSQL(
       ParseSQL(iDbType,
       'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)+ - :INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) + - :INTEGRAL'+
       ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID')
     ,self);
  end;
  result := true;
end;

function TSalRetuOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
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

function TSalRetuOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
   cDate:string;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then  //不是同步状态
      begin
        Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('SALES_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
        if FieldbyName('SALES_DATE').AsOldString <> '' then
           Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('SALES_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
        rs := TZQuery.Create(nil);
        try
          rs.SQL.Text := 'select * from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CLSE_DATE in (:CLSE_DATE ,:OLD_CLSE_DATE ) and CREA_USER=:CREA_USER';
          rs.Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
          rs.Params.ParamByName('SHOP_ID').asString := FieldbyName('SHOP_ID').AsString;
          rs.Params.ParamByName('CLSE_DATE').AsInteger := FieldbyName('SALES_DATE').AsInteger;
          rs.Params.ParamByName('OLD_CLSE_DATE').AsInteger := FieldbyName('SALES_DATE').AsOldInteger;
          rs.Params.ParamByName('CREA_USER').asString := FieldbyName('CREA_USER').AsString;
          AGlobal.Open(rs);
          if not rs.IsEmpty then Raise Exception.Create('当前收银员在'+FieldbyName('SALES_DATE').AsString+'已经结账不能再开单.');
        finally
          rs.Free;
        end;
        result := true;
      end
   else
      begin
        cDate := GetReckDate(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString);
        if FieldbyName('SALES_DATE').asString < cDate then
           begin
             FieldbyName('NOTE').asString := '开单日期:'+FieldbyName('SALES_DATE').asString+'上传至最近结帐日:'+cDate;
             FieldbyName('SALES_DATE').asString := cDate;
           end;
        Result := true;
      end;
end;

function TSalRetuOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from SAL_SALESORDER where SALES_ID='''+FieldbyName('SALES_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString;
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TSalRetuOrder.DoUpgrade(AGlobal: IdbHelp);
begin
//  case AGlobal.iDbType of
//  0:AGlobal.ExecSQL('update PUB_CUSTOMER set PRICE_ID=isnull((select top 1 PRICE_ID from PUB_PRICEGRADE where INTEGRAL<=A.ACCU_INTEGRAL and INTEGRAL>0 and PRICE_ID not in (''000'',''---'') order by INTEGRAL desc),A.PRICE_ID),COMM=' + GetCommStr(iDbType) + ',' + 'TIME_STAMP='+GetTimeStamp(iDbType)+' from BAS_CUSTOMER A where A.CUST_ID in (:CUST_ID,:OLD_CUST_ID)',self);
//  end;
end;

procedure TSalRetuOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select jh.*,h.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select jg.*,g.GLIDE_NO as SAL_GLIDE_NO from ('+
               'select jf.*,f.USER_NAME as GUIDE_USER_TEXT from ('+
               'select je.*,e.SHOP_NAME as SHOP_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+
               'select jb.*,b.CLIENT_NAME as CLIENT_ID_TEXT,b.PRICE_ID,b.INTEGRAL as ACCU_INTEGRAL,b.BALANCE,b.CLIENT_CODE from '+
               '(select TENANT_ID,SHOP_ID,DEPT_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,-SALE_AMT as SALE_AMT,-SALE_MNY as SALE_MNY,CASH_MNY,PAY_ZERO,-PAY_DIBS as PAY_DIBS,'+
               '-ADVA_MNY as ADVA_MNY,-PAY_A as PAY_A,-PAY_B as PAY_B,-PAY_C as PAY_C,-PAY_D as PAY_D,-PAY_E as PAY_E,-PAY_F as PAY_F,-PAY_G as PAY_G,-PAY_H as PAY_H,-PAY_I as PAY_I,-PAY_J as PAY_J,-INTEGRAL as INTEGRAL,-BARTER_INTEGRAL as BARTER_INTEGRAL,'+
               'REMARK,INVOICE_FLAG,TAX_RATE,SALES_STYLE,IC_CARDNO,UNION_ID,COMM,CREA_DATE,CREA_USER,'+
               'TIME_STAMP,LOCUS_STATUS from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) jb '+
               ' left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_SHOP_INFO e on je.TENANT_ID=e.TENANT_ID and je.SHOP_ID=e.SHOP_ID ) jf '+
               ' left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.GUIDE_USER=f.USER_ID ) jg '+
               ' left outer join SAL_SALESORDER g on jg.TENANT_ID=g.TENANT_ID and jg.FROM_ID=g.SALES_ID ) jh '+
               ' left outer join CA_DEPT_INFO h on jh.TENANT_ID=h.TENANT_ID and jh.DEPT_ID=h.DEPT_ID';
  IsSQLUpdate := True;
  Str := 'insert into SAL_SALESORDER(TENANT_ID,SHOP_ID,DEPT_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,IC_CARDNO,UNION_ID,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,ADVA_MNY,PAY_A,PAY_B,PAY_C,'+
      'PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,INTEGRAL,BARTER_INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,COMM,CREA_DATE,CREA_USER,TIME_STAMP,LINKMAN,TELEPHONE,SEND_ADDR,SALES_STYLE,LOCUS_STATUS) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:DEPT_ID,:SALES_ID,:GLIDE_NO,:SALES_DATE,:SALES_TYPE,:IC_CARDNO,:UNION_ID,:PLAN_DATE,:CLIENT_ID,:GUIDE_USER,:CHK_DATE,:CHK_USER,:FROM_ID,'+
      ':FIG_ID,- :SALE_AMT,- :SALE_MNY,:CASH_MNY,:PAY_ZERO,- :PAY_DIBS,- :ADVA_MNY,- :PAY_A,- :PAY_B,- :PAY_C,- :PAY_D,'+
      '- :PAY_E,- :PAY_F,- :PAY_G,- :PAY_H,- :PAY_I,- :PAY_J,- :INTEGRAL,- :BARTER_INTEGRAL,:REMARK,:INVOICE_FLAG,:TAX_RATE,''00'','+GetSysDateFormat(iDbType)+',:CREA_USER,'+GetTimeStamp(iDbType)+',:LINKMAN,:TELEPHONE,:SEND_ADDR,:SALES_STYLE,''2'')';
  InsertSQL.Text := Str;
  Str := 'update SAL_SALESORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,SALES_ID=:SALES_ID,GLIDE_NO=:GLIDE_NO,SALES_DATE=:SALES_DATE,PLAN_DATE=:PLAN_DATE,SALES_TYPE=:SALES_TYPE,CLIENT_ID=:CLIENT_ID,'+
         'GUIDE_USER=:GUIDE_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,FROM_ID=:FROM_ID,FIG_ID=:FIG_ID,SALE_AMT=- :SALE_AMT,SALE_MNY=- :SALE_MNY,CASH_MNY=:CASH_MNY,PAY_ZERO=:PAY_ZERO,PAY_DIBS=- :PAY_DIBS,PAY_A=- :PAY_A,PAY_B=- :PAY_B,'+
         'PAY_C=- :PAY_C,PAY_D=- :PAY_D,PAY_E=- :PAY_E,PAY_F=- :PAY_F,PAY_G=- :PAY_G,PAY_H=- :PAY_H,PAY_I=- :PAY_I,PAY_J=- :PAY_J,INTEGRAL=- :INTEGRAL,BARTER_INTEGRAL=- :BARTER_INTEGRAL,REMARK=:REMARK,INVOICE_FLAG=:INVOICE_FLAG,TAX_RATE=:TAX_RATE,'
    + 'COMM=' + GetCommStr(iDbType) + ',LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,SEND_ADDR=:SEND_ADDR,SALES_STYLE=:SALES_STYLE,IC_CARDNO=:IC_CARDNO,UNION_ID=:UNION_ID,'
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_SALESORDER where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  DeleteSQL.Text := Str;
end;

{ TSalRetuOrderGetPrior }

procedure TSalRetuOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC';
  4:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC limit 1';
  end;
end;

{ TSalRetuOrderGetNext }

procedure TSalRetuOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO';
  4:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO limit 1';
  end;

end;

{ TSalRetuOrderAudit }

function TSalRetuOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  Str:string;
  n:Integer;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select LOCUS_STATUS from SAL_SALESORDER A where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' '+
      ' and Exists(select * from SAL_SALESDATA B,VIW_GOODSINFO C where B.TENANT_ID=C.TENANT_ID and B.GODS_ID=C.GODS_ID and C.USING_LOCUS_NO=1 and B.TENANT_ID=A.TENANT_ID and B.SALES_ID=A.SALES_ID)';
    AGlobal.Open(rs);
    if not rs.IsEmpty and (rs.Fields[0].AsString<>'3') then Raise Exception.Create('没有扫码入库完毕，不能审核..');
  finally
    rs.Free;
  end;
  try
    Str := 'update SAL_SALESORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Result := true;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '审核错误'+E.Message;
      end;
  end;
end;

{ TSalRetuOrderUnAudit }

function TSalRetuOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
begin
   try
    Str := 'update SAL_SALESORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '反审核错误:'+E.Message;
       end;
  end;
end;

{ TSalRetuForLocusNo }

procedure TSalRetuForLocusNo.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
               'select TENANT_ID,SHOP_ID,SALES_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_DATE,LOCUS_NO,UNIT_ID,- AMOUNT as AMOUNT,- CALC_AMOUNT as CALC_AMOUNT,CREA_DATE,CREA_USER,COMM,TIME_STAMP '+
               'from SAL_LOCUS_FORSALE j where j.TENANT_ID=:TENANT_ID and j.SALES_ID=:SALES_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into SAL_LOCUS_FORSALE(TENANT_ID,SHOP_ID,SALES_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_DATE,LOCUS_NO,UNIT_ID,AMOUNT,CALC_AMOUNT,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SALES_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:LOCUS_DATE,:LOCUS_NO,:UNIT_ID,- :AMOUNT,- :CALC_AMOUNT,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := str;
  Str := 'update SAL_LOCUS_FORSALE set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SALES_ID=:SALES_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,'+
      'LOCUS_DATE=:LOCUS_DATE,LOCUS_NO=:LOCUS_NO,UNIT_ID=:UNIT_ID,AMOUNT=- :AMOUNT,CALC_AMOUNT=- :CALC_AMOUNT,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER, '
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from SAL_LOCUS_FORSALE where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TSalRetuForLocusNoHeader }

procedure TSalRetuForLocusNoHeader.InitClass;
var Str:string;
begin
  inherited;
  SelectSQL.Text :=
               'select jh.*,h.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select jg.*,g.GLIDE_NO as SAL_GLIDE_NO from ('+
               'select jf.*,f.USER_NAME as GUIDE_USER_TEXT from ('+
               'select je.*,e.SHOP_NAME as SHOP_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+
               'select jb.*,b.CLIENT_NAME as CLIENT_ID_TEXT,b.PRICE_ID,b.INTEGRAL as ACCU_INTEGRAL,b.BALANCE,b.CLIENT_CODE from '+
               '(select TENANT_ID,SHOP_ID,DEPT_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,-SALE_AMT as SALE_AMT,-SALE_MNY as SALE_MNY,CASH_MNY,PAY_ZERO,-PAY_DIBS as PAY_DIBS,'+
               '-ADVA_MNY as ADVA_MNY,-PAY_A as PAY_A,-PAY_B as PAY_B,-PAY_C as PAY_C,-PAY_D as PAY_D,-PAY_E as PAY_E,-PAY_F as PAY_F,-PAY_G as PAY_G,-PAY_H as PAY_H,-PAY_I as PAY_I,-PAY_J as PAY_J,-INTEGRAL as INTEGRAL,-BARTER_INTEGRAL as BARTER_INTEGRAL,'+
               'LOCUS_STATUS,LOCUS_USER,LOCUS_DATE,-LOCUS_AMT as LOCUS_AMT,LOCUS_CHK_DATE,LOCUS_CHK_USER,'+
               'REMARK,INVOICE_FLAG,TAX_RATE,SALES_STYLE,IC_CARDNO,UNION_ID,COMM,CREA_DATE,CREA_USER,'+
               'TIME_STAMP from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) jb '+
               ' left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_SHOP_INFO e on je.TENANT_ID=e.TENANT_ID and je.SHOP_ID=e.SHOP_ID ) jf '+
               ' left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.GUIDE_USER=f.USER_ID ) jg '+
               ' left outer join SAL_SALESORDER g on jg.TENANT_ID=g.TENANT_ID and jg.FROM_ID=g.SALES_ID ) jh '+
               ' left outer join CA_DEPT_INFO h on jh.TENANT_ID=h.TENANT_ID and jh.DEPT_ID=h.DEPT_ID';
  Str :=
      'update SAL_SALESORDER set LOCUS_STATUS=:LOCUS_STATUS,LOCUS_USER=:LOCUS_USER,LOCUS_DATE=:LOCUS_DATE,LOCUS_AMT=- :LOCUS_AMT,LOCUS_CHK_DATE=:LOCUS_CHK_DATE,LOCUS_CHK_USER=:LOCUS_CHK_USER,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  UpdateSQL.Text := Str;
end;

{ TSalRetuLocusNoUnAudit }

function TSalRetuLocusNoUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
begin
   try
    Str := 'update SAL_SALESORDER set LOCUS_CHK_DATE=null,LOCUS_CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and LOCUS_CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '反审核错误:'+E.Message;
       end;
  end;
end;

{ TSalRetuLocusNoAudit }

function TSalRetuLocusNoAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  Str:string;
  n:Integer;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select LOCUS_STATUS from SAL_SALESORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('SALES_ID').asString+'''';
    AGlobal.Open(rs);
    if rs.Fields[0].AsString<>'3' then Raise Exception.Create('没有收货完毕，不能审核..');
  finally
    rs.Free;
  end;
  try
    Str := 'update SAL_SALESORDER set LOCUS_CHK_DATE='''+Params.FindParam('LOCUS_CHK_DATE').asString+''',LOCUS_CHK_USER='''+Params.FindParam('LOCUS_CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and LOCUS_CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Result := true;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '审核错误'+E.Message;
      end;
  end;
end;

initialization
  RegisterClass(TSalRetuOrder);
  RegisterClass(TSalRetuData);
  RegisterClass(TSalRetuOrderAudit);
  RegisterClass(TSalRetuOrderUnAudit);
  RegisterClass(TSalRetuOrderGetPrior);
  RegisterClass(TSalRetuOrderGetNext);
  RegisterClass(TSalRetuForLocusNoHeader);
  RegisterClass(TSalRetuForLocusNo);
  RegisterClass(TSalRetuLocusNoAudit);
  RegisterClass(TSalRetuLocusNoUnAudit);
finalization
  UnRegisterClass(TSalRetuOrder);
  UnRegisterClass(TSalRetuData);
  UnRegisterClass(TSalRetuOrderAudit);
  UnRegisterClass(TSalRetuOrderUnAudit);
  UnRegisterClass(TSalRetuOrderGetPrior);
  UnRegisterClass(TSalRetuOrderGetNext);
  UnRegisterClass(TSalRetuForLocusNoHeader);
  UnRegisterClass(TSalRetuForLocusNo);
  UnRegisterClass(TSalRetuLocusNoAudit);
  UnRegisterClass(TSalRetuLocusNoUnAudit);
end.
