unit ObjStockOrderV60;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet,math,udllFnUtil;
type
  TStockOrderV60=class(TZFactory)
  private
    lock:boolean;
    isSync:boolean;
  public
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
  TStockDataV60=class(TZFactory)
  private
    IsZeroOut:Boolean;
    lock:boolean;
    isSync:boolean;
  public
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
implementation

{ TStockDataV60 }

function TStockDataV60.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
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
        'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.BATCH_NO,B.IS_PRESENT,B.LOCUS_NO,B.BOM_ID from STO_STORAGE A,STK_STOCKDATA B '+
        'where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 and A.BATCH_NO=B.BATCH_NO '+
        ' and A.AMOUNT<0 and B.STOCK_ID=:STOCK_ID and B.SHOP_ID=:SHOP_ID and A.TENANT_ID=:TENANT_ID '+
        ') j inner join VIW_GOODSINFO b on j.GODS_ID=b.GODS_ID and j.TENANT_ID=b.TENANT_ID '+
        ') jp1 left join VIW_SIZE_INFO p1 on jp1.PROPERTY_01=p1.SIZE_ID  and jp1.TENANT_ID=p1.TENANT_ID '+
        ') jp2 left join VIW_COLOR_INFO p2 on jp2.PROPERTY_02=p2.COLOR_ID  and jp2.TENANT_ID=p2.TENANT_ID ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.Params.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsString;
    rs.Params.ParamByName('STOCK_ID').AsString := FieldbyName('STOCK_ID').AsString;
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

function TStockDataV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asOldString,FieldbyName('SHOP_ID').asOldString,
             FieldbyName('GODS_ID').asOldString,
             FieldbyName('PROPERTY_01').asOldString,
             FieldbyName('PROPERTY_02').asOldString,
             FieldbyName('BATCH_NO').asOldString,
             FieldbyName('CALC_AMOUNT').asOldFloat,
             FieldbyName('CALC_MONEY').asOldFloat-roundto(FieldbyName('CALC_MONEY').asOldFloat/(1+FieldbyName('TAX_RATE').asOldFloat)*FieldbyName('TAX_RATE').asOldFloat,-2),3);
//  if not lock then
//     WriteLogInfo(AGlobal,Parant.FieldbyName('CREA_USER').AsString,2,'400018','删除【单号'+Parant.FieldbyName('GLIDE_NO').asString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STK_STOCKDATA',usDeleted));
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TStockDataV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  n:integer;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             FieldbyName('CALC_MONEY').asFloat-roundto(FieldbyName('CALC_MONEY').asFloat/(1+FieldbyName('TAX_RATE').AsFloat)*FieldbyName('TAX_RATE').AsFloat,-2),1);
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TStockDataV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
//  WriteLogInfo(AGlobal,Parant.FieldbyName('CREA_USER').AsString,2,'400018','修改【单号'+Parant.FieldbyName('GLIDE_NO').asString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STK_STOCKDATA',usModified));
end;

function TStockDataV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
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
     Temp.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and DEFINE=''ZERO_OUT''';
     AGlobal.Open(Temp);
     IsZeroOut := (Temp.Fields[0].AsString = '1');
  finally
     Temp.free;
  end;

end;

procedure TStockDataV60.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
      ' select jb.*,b.GODS_NAME as GODS_NAME,b.GODS_CODE as GODS_CODE from ('+
      ' select j.TENANT_ID,j.SHOP_ID,j.STOCK_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,'+
      ' j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.IS_PRESENT,j.APRICE,j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,'+
      ' j.REMARK,j.ORG_PRICE*j.AMOUNT as RTL_MONEY,h.TAX_RATE from STK_STOCKDATA j,STK_STOCKORDER h where j.TENANT_ID=h.TENANT_ID and j.STOCK_ID=h.STOCK_ID and j.TENANT_ID=:TENANT_ID and j.STOCK_ID=:STOCK_ID) jb inner join ('+Params.ParambyName('VIW_GOODSINFO').AsString+') b '+
      ' on jb.TENANT_ID=b.TENANT_ID and jb.GODS_ID=b.GODS_ID order by jb.SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into STK_STOCKDATA(TENANT_ID,SHOP_ID,SEQNO,STOCK_ID,GODS_ID,BATCH_NO,LOCUS_NO,BOM_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,AMOUNT,ORG_PRICE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,REMARK) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SEQNO,:STOCK_ID,:GODS_ID,:BATCH_NO,:LOCUS_NO,:BOM_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:AMOUNT,:ORG_PRICE,:IS_PRESENT,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:REMARK)';
  InsertSQL.Text := Str;
  Str := 'update STK_STOCKDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SEQNO=:SEQNO,STOCK_ID=:STOCK_ID,GODS_ID=:GODS_ID,BATCH_NO=:BATCH_NO,LOCUS_NO=:LOCUS_NO,BOM_ID=:BOM_ID,'+
         'PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,ORG_PRICE=:ORG_PRICE,'+
         'IS_PRESENT=:IS_PRESENT,APRICE=:APRICE,AMONEY=:AMONEY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY,CALC_AMOUNT=:CALC_AMOUNT,CALC_MONEY=:CALC_MONEY,REMARK=:REMARK '
    + 'where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_STOCK_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from STK_STOCKDATA where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_STOCK_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TStockOrderV60 }

function TStockOrderV60.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

function TStockOrderV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  if not Lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  if FieldbyName('PAY_D').AsOldFloat <> 0 then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select PAYM_MNY from ACC_PAYABLE_INFO where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID and ABLE_TYPE=''4''';
         rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
         rs.ParamByName('STOCK_ID').AsString := FieldbyName('STOCK_ID').AsOldString;
         AGlobal.Open(rs);
         if not isSync and (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('已经收款的进货入库单不能修改...');
         if rs.Fields[0].AsFloat=0 then
            AGlobal.ExecSQL('delete from ACC_PAYABLE_INFO where STOCK_ID=:OLD_STOCK_ID and TENANT_ID=:OLD_TENANT_ID and ABLE_TYPE=''4''',self)
         else
            AGlobal.ExecSQL('update ACC_PAYABLE_INFO set ACCT_MNY=0,PAYM_MNY=-(PAYM_MNY+REVE_MNY) where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_STOCK_ID and ABLE_TYPE=''4''',self);
       finally
         rs.Free;
       end;
     end;
//  if not lock then
//     WriteLogInfo(AGlobal,FieldbyName('CREA_USER').AsString,2,'400018','删除【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'STK_STOCKORDER',usDeleted));
  result := true;
end;

function TStockOrderV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
   if (FieldbyName('GLIDE_NO').AsString='') then
      FieldbyName('GLIDE_NO').asString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_2_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
   if (FieldbyName('PAY_D').AsFloat <> 0) then
   begin
     FieldbyName('ADVA_MNY').AsFloat := 0;
     if AGlobal.ExecSQL('update ACC_PAYABLE_INFO set ACCT_MNY=:PAY_D,RECK_MNY=:PAY_D -(PAYM_MNY+REVE_MNY),ABLE_DATE=:STOCK_DATE,CLIENT_ID=:CLIENT_ID,DEPT_ID=:DEPT_ID,SHOP_ID=:SHOP_ID where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID and ABLE_TYPE=''4''',self)=0 then
        begin
          AGlobal.ExecSQL(
             'insert into ACC_PAYABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,ABLE_TYPE,ACCT_MNY,PAYM_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,STOCK_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
           + 'VALUES(:STOCK_ID,:TENANT_ID,:SHOP_ID,:DEPT_ID,:CLIENT_ID,'''+'进货货款【入库单号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''4'',:PAY_D,0,:ADVA_MNY,:PAY_D,:STOCK_DATE,:STOCK_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
           ,self);
        end;
   end;
  result := true;
end;

function TStockOrderV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。'); 
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := true;
  end;
  //WriteLogInfo(AGlobal,FieldbyName('CREA_USER').AsString,2,'400018','修改【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'STK_STOCKORDER',usModified));
end;

function TStockOrderV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
   isSync := Params.FindParam('SyncFlag')<>nil;
   if isSync then
      begin
        AGlobal.ExecSQL('delete from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and (CREA_DATE>='+FieldbyName('STOCK_DATE').AsOldString+' or CREA_DATE>='+FieldbyName('STOCK_DATE').AsString+')',self);
        AGlobal.ExecSQL('delete from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and (END_DATE>='+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(FieldbyName('STOCK_DATE').AsString))+' or END_DATE>='+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(FieldbyName('STOCK_DATE').AsString))+')',self);
      end
   else
      begin
        Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('STOCK_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
        if FieldbyName('STOCK_DATE').AsOldString <> '' then
           Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('STOCK_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
        result := true;
      end;
end;

function TStockOrderV60.CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  result := true;
  if isSync then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from STK_STOCKORDER where STOCK_ID='''+FieldbyName('STOCK_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString;
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

procedure TStockOrderV60.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
               'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
               'select jb.*,b.CLIENT_NAME as CLIENT_ID_TEXT from '+
               '(select TENANT_ID,SHOP_ID,DEPT_ID,STOCK_ID,GLIDE_NO,STOCK_TYPE,STOCK_DATE,GUIDE_USER,CLIENT_ID,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,INVOICE_FLAG,'+
               'STOCK_MNY,STOCK_AMT,PAY_ZERO ,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,ADVA_MNY,TAX_RATE,REMARK,COMM,CREA_DATE,CREA_USER,TIME_STAMP,COMM_ID,LOCUS_STATUS from STK_STOCKORDER where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID) jb '+
               ' left outer join VIW_CLIENTINFO b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ';
  IsSQLUpdate := True;
  Str := 'insert into STK_STOCKORDER(TENANT_ID,SHOP_ID,DEPT_ID,STOCK_ID,GLIDE_NO,STOCK_TYPE,STOCK_DATE,GUIDE_USER,CLIENT_ID,STOCK_MNY,STOCK_AMT,PAY_ZERO,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,'+
      'ADVA_MNY,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,INVOICE_FLAG,TAX_RATE,REMARK,COMM,CREA_DATE,CREA_USER,COMM_ID,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:DEPT_ID,:STOCK_ID,:GLIDE_NO,:STOCK_TYPE,:STOCK_DATE,:GUIDE_USER,:CLIENT_ID,:STOCK_MNY,:STOCK_AMT,:PAY_ZERO,:PAY_A,:PAY_B,:PAY_C,:PAY_D,:PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,'+
      ':ADVA_MNY,:CHK_DATE,:CHK_USER,:FROM_ID,:FIG_ID,:INVOICE_FLAG,:TAX_RATE,:REMARK,''00'',:CREA_DATE,:CREA_USER,:COMM_ID,'+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := str;
  Str := 'update STK_STOCKORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,STOCK_ID=:STOCK_ID,GLIDE_NO=:GLIDE_NO,STOCK_TYPE=:STOCK_TYPE,STOCK_DATE=:STOCK_DATE,GUIDE_USER=:GUIDE_USER,CLIENT_ID=:CLIENT_ID,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,'+
         'FROM_ID=:FROM_ID,FIG_ID=:FIG_ID,INVOICE_FLAG=:INVOICE_FLAG,TAX_RATE=:TAX_RATE,STOCK_MNY=:STOCK_MNY,STOCK_AMT=:STOCK_AMT,PAY_ZERO=:PAY_ZERO,PAY_A=:PAY_A,PAY_B=:PAY_B,PAY_C=:PAY_C,'+
         'PAY_D=:PAY_D,PAY_E=:PAY_E,PAY_F=:PAY_F,PAY_G=:PAY_G,PAY_H=:PAY_H,PAY_I=:PAY_I,PAY_J=:PAY_J,ADVA_MNY=:ADVA_MNY,REMARK=:REMARK,COMM_ID=:COMM_ID,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_STOCK_ID';
  UpdateSQL.Text := str;
  Str := 'delete from STK_STOCKORDER where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_STOCK_ID';
  DeleteSQL.Text := str;
end;


initialization
  RegisterClass(TStockOrderV60);
  RegisterClass(TStockDataV60);
finalization
  UnRegisterClass(TStockOrderV60);
  UnRegisterClass(TStockDataV60);
end.
