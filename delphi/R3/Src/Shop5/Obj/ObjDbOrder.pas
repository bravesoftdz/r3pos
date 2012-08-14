unit ObjDbOrder;

interface
uses Dialogs,SysUtils,zBase,Classes,zintf,ObjCommon,DB,ZDataSet,math;
type
  TDbOrder=class(TZFactory)
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
  TDbData=class(TZFactory)
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
  TDbForLocusNoHeader=class(TZFactory)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    procedure InitClass;override;
  end;
  TDbForInLocusNoHeader=class(TDbOrder)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TDbForLocusNo=class(TZFactory)
  private
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  public
    procedure InitClass;override;
  end;
  TDbOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TDbOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TDbOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TDbOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TDbLocusNoAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TDbLocusNoUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TDbInLocusNoAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TDbInLocusNoUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation
uses uFnUtil;
{ TStockData }

function TDbData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
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
          if s<>'' then
            Raise Exception.Create(s+#10+'--商品库存不足,请核对是否输入正确？'); 
        finally
          rs.Free;
        end;
      end;
end;

function TDbData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  r:integer;
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
  if FieldbyName('PLAN_DATE').AsOldString <> '' then
     begin
       Str := 'delete from STK_STOCKDATA where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
       r := AGlobal.ExecSQL(Str,self);
       if r=1 then
       DecStorage(AGlobal,FieldbyName('TENANT_ID').asOldString,FieldbyName('CLIENT_ID').asOldString,
                  FieldbyName('GODS_ID').asOldString,
                  FieldbyName('PROPERTY_01').asOldString,
                  FieldbyName('PROPERTY_02').asOldString,
                  FieldbyName('BATCH_NO').asOldString,
                  FieldbyName('CALC_AMOUNT').asOldFloat,
                  roundto(FieldbyName('COST_PRICE').asOldFloat*FieldbyName('CALC_AMOUNT').asOldFloat,-2),3)
       else
         Raise Exception.Create('删除多笔到货确认单');
     end;
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

function TDbData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  rs:TZQuery;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  FieldByName('POLICY_TYPE').AsInteger := 0;
  FieldByName('HAS_INTEGRAL').AsInteger := 0;
  FieldByName('IS_PRESENT').AsInteger := 0;
  FieldByName('BARTER_INTEGRAL').AsInteger := 0;
  
//改由开单前台最当最新进价
//  FieldbyName('COST_PRICE').AsFloat := GetCostPrice(AGlobal,FieldbyName('TENANT_ID').AsString,FieldbyName('SHOP_ID').AsString,FieldbyName('GODS_ID').AsString,FieldbyName('PROPERTY_01').AsString,FieldbyName('PROPERTY_02').AsString,FieldbyName('BATCH_NO').AsString);
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('COST_PRICE').asFloat*FieldbyName('CALC_AMOUNT').asFloat,-2),2);


  if FieldbyName('PLAN_DATE').AsString <> '' then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text :=
              'insert into STK_STOCKDATA(TENANT_ID,SHOP_ID,SEQNO,STOCK_ID,GODS_ID,BATCH_NO,LOCUS_NO,BOM_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,AMOUNT,ORG_PRICE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,REMARK) '
            + 'VALUES(:TENANT_ID,:CLIENT_ID,:SEQNO,:SALES_ID,:GODS_ID,:BATCH_NO,:LOCUS_NO,:BOM_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:AMOUNT,:APRICE,:IS_PRESENT,'+
              ':STK_APRICE,:STK_AMONEY,0,0,:CALC_AMOUNT,:STK_AMONEY,:REMARK)';
         CopyToParams(rs.Params,false);
         rs.ParamByName('STK_APRICE').AsFloat := roundTo(FieldbyName('CALC_AMOUNT').AsFloat*FieldbyName('COST_PRICE').AsFloat,-2)/FieldbyName('AMOUNT').AsFloat;
         rs.ParamByName('STK_AMONEY').AsFloat := roundTo(FieldbyName('CALC_AMOUNT').AsFloat*FieldbyName('COST_PRICE').AsFloat,-2);
         AGlobal.ExecQuery(rs); 
       finally
         rs.Free;
       end;
//       AGlobal.ExecSQL(Str,self);
       IncStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('CLIENT_ID').asString,
                  FieldbyName('GODS_ID').asString,
                  FieldbyName('PROPERTY_01').asString,
                  FieldbyName('PROPERTY_02').asString,
                  FieldbyName('BATCH_NO').asString,
                  FieldbyName('CALC_AMOUNT').asFloat,
                  roundto(FieldbyName('COST_PRICE').asFloat*FieldbyName('CALC_AMOUNT').asFloat,-2),1);
     end;
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TDbData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
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

function TDbData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
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

procedure TDbData.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select b.GODS_NAME,b.GODS_CODE,j.TENANT_ID,j1.PLAN_DATE,j1.CLIENT_ID,j.SHOP_ID,j.SALES_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.POLICY_TYPE,'+
               'j.IS_PRESENT,j.BARTER_INTEGRAL,j.COST_PRICE,j.APRICE,j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,'+
               'j.COST_PRICE*case when J.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when J.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as COST_APRICE,'+
               'round(j.COST_PRICE*j.CALC_AMOUNT,2) as COST_MONEY,'+
               'j.HAS_INTEGRAL,j.REMARK,b.BARCODE from SAL_SALESDATA j inner join SAL_SALESORDER j1 on j.TENANT_ID=j1.TENANT_ID and j.SALES_ID=j1.SALES_ID '+
               ' inner join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.SALES_ID=:SALES_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into SAL_SALESDATA(TENANT_ID,SHOP_ID,SALES_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_NO,BOM_ID,UNIT_ID,AMOUNT,ORG_PRICE,'+
      'POLICY_TYPE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,BARTER_INTEGRAL,HAS_INTEGRAL,REMARK,COST_PRICE) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SALES_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:LOCUS_NO,:BOM_ID,:UNIT_ID,:AMOUNT,:APRICE,'+
      ':POLICY_TYPE,:IS_PRESENT,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:BARTER_INTEGRAL,:HAS_INTEGRAL,:REMARK,:COST_PRICE)';
  InsertSQL.Text := str;
  Str := 'update SAL_SALESDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SALES_ID=:SALES_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,LOCUS_NO=:LOCUS_NO,BOM_ID=:BOM_ID,UNIT_ID=:UNIT_ID,'+
      'AMOUNT=:AMOUNT,ORG_PRICE=:APRICE,COST_PRICE=:COST_PRICE,POLICY_TYPE=:POLICY_TYPE,IS_PRESENT=:IS_PRESENT,APRICE=:APRICE,AMONEY=:AMONEY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY,CALC_AMOUNT=:CALC_AMOUNT,'+
      'CALC_MONEY=:CALC_MONEY,BARTER_INTEGRAL=:BARTER_INTEGRAL,HAS_INTEGRAL=:HAS_INTEGRAL,REMARK=:REMARK '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from SAL_SALESDATA where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TDbOrder }

function TDbOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
  SQL:string;
begin
  if FieldbyName('FIG_ID').AsString <> '' then
     begin                                               
       SQL :=
        'UPDATE MKT_DEMANDDATA '+
        'SET '+
        '  SHIP_AMOUNT = ( '+
        '    SELECT '+
        '      sum( b.CALC_AMOUNT ) '+
        '    FROM  '+
        '      SAL_SALESORDER a ,'+
        '      SAL_SALESDATA b '+
        '    WHERE '+
        '      a.TENANT_ID = b.TENANT_ID AND a.SALES_ID = b.SALES_ID AND a.TENANT_ID = MKT_DEMANDDATA.TENANT_ID AND a.FIG_ID = MKT_DEMANDDATA.DEMA_ID '+
        '      AND b.GODS_ID = MKT_DEMANDDATA.GODS_ID AND b.BATCH_NO = MKT_DEMANDDATA.BATCH_NO '+
        '      AND b.UNIT_ID = MKT_DEMANDDATA.UNIT_ID AND b.PROPERTY_01 = MKT_DEMANDDATA.PROPERTY_01 AND b.PROPERTY_02 = MKT_DEMANDDATA.PROPERTY_02 AND b.IS_PRESENT = MKT_DEMANDDATA.IS_PRESENT  '+
        '  ) '+
        'WHERE DEMA_ID = :FIG_ID AND TENANT_ID = :TENANT_ID';
         AGlobal.ExecSQL(SQL,self);
     end;
end;

function TDbOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  Str:string;
begin
  if not Lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
{  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from STK_STOCKORDER where TENANT_ID='+FieldbyName('TENANT_ID').AsOldString+' and FROM_ID='''+FieldbyName('SALES_ID').AsOldString+''' and STOCK_TYPE=2';
    AGlobal.Open(rs);
    if (rs.Fields[0].AsInteger >0) then Raise Exception.Create('已经到货确认的调拨单不能修改...');
  finally
    rs.Free;
  end;
}  
  if FieldbyName('PLAN_DATE').AsOldString <> '' then
  begin
    Str := 'delete from STK_STOCKORDER where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_SALES_ID and STOCK_TYPE=2';
    AGlobal.ExecSQL(Str,self);
  end;
//  if not lock then
//     WriteLogInfo(AGlobal,FieldbyName('CREA_USER').AsString,2,'500026','删除【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'SAL_SALESORDER',usDeleted));
  result := true;
end;

function TDbOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  Str:string;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
  begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_B_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
  end;
  if FieldbyName('PLAN_DATE').AsString <> '' then
  begin
    Str := 'insert into STK_STOCKORDER(TENANT_ID,SHOP_ID,STOCK_ID,GLIDE_NO,STOCK_TYPE,STOCK_DATE,GUIDE_USER,CLIENT_ID,STOCK_MNY,STOCK_AMT,ADVA_MNY,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,INVOICE_FLAG,TAX_RATE,REMARK,COMM,CREA_DATE,CREA_USER,TIME_STAMP) '
      + 'VALUES(:TENANT_ID,:CLIENT_ID,:SALES_ID,:GLIDE_NO,:SALES_TYPE,'+formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(FieldbyName('PLAN_DATE').AsString))+',:STOCK_USER,:SHOP_ID,:STOCK_MNY,:SALE_AMT,0,:CHK_DATE,:CHK_USER,:SALES_ID,:FIG_ID,''1'',0,:REMARK,''00'',:CREA_DATE,:CREA_USER,'+GetTimeStamp(iDbType)+')';
    AGlobal.ExecSQL(Str,self);
  end;
  result := true;
end;

function TDbOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
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

function TDbOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
   cDate:string;
begin
  if Params.FindParam('OK_DIALOG')=nil then
  begin
     Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('SALES_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
     if FieldbyName('SALES_DATE').AsOldString <> '' then
        Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('SALES_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
  end;
  if FieldbyName('PLAN_DATE').AsString<>'' then
     Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(FieldbyName('PLAN_DATE').AsString)),FieldbyName('TIME_STAMP').AsString);
  if FieldbyName('PLAN_DATE').AsOldString <> '' then
     Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(FieldbyName('PLAN_DATE').AsOldString)),FieldbyName('TIME_STAMP').AsOldString);
  result := true;
end;

function TDbOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
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

procedure TDbOrder.DoUpgrade(AGlobal: IdbHelp);
begin
//  case AGlobal.iDbType of
//  0:AGlobal.ExecSQL('update BAS_CUSTOMER set PRICE_ID=isnull((select top 1 PRICE_ID from PUB_PRICEGRADE where INTEGRAL<=A.ACCU_INTEGRAL and INTEGRAL>0 and PRICE_ID not in (''000'',''---'') order by INTEGRAL desc),A.PRICE_ID),COMM=' + GetCommStr(iDbType) + ',' + 'TIME_STAMP='+GetTimeStamp(iDbType)+' from BAS_CUSTOMER A where A.CUST_ID in (:CUST_ID,:OLD_CUST_ID)',self);
//  end;
end;

procedure TDbOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select ji.*,i.GLIDE_NO as DEMA_GLIDE_NO from ('+
               'select jh.*,h.USER_NAME as STOCK_USER_TEXT from ('+
               'select jg.*,g.GUIDE_USER as STOCK_USER,g.STOCK_MNY from ('+
               'select jf.*,f.USER_NAME as GUIDE_USER_TEXT from ('+
               'select je.*,e.SHOP_NAME as SHOP_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+
               'select jb.*,b.SHOP_NAME as CLIENT_ID_TEXT from '+
               '(select TENANT_ID,SHOP_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,CLIENT_ID,PLAN_DATE,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,'+
               'ADVA_MNY,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,SALES_STYLE,IC_CARDNO,UNION_ID,COMM,CREA_DATE,CREA_USER,'+
               'TIME_STAMP,LOCUS_STATUS from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) jb '+
               ' left outer join CA_SHOP_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.SHOP_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_SHOP_INFO e on je.TENANT_ID=e.TENANT_ID and je.SHOP_ID=e.SHOP_ID ) jf '+
               ' left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.GUIDE_USER=f.USER_ID ) jg '+
               ' left outer join STK_STOCKORDER g on jg.TENANT_ID=g.TENANT_ID and jg.SALES_ID=g.STOCK_ID and jg.SALES_TYPE=g.STOCK_TYPE ) jh '+
               ' left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.STOCK_USER=h.USER_ID ) ji '+
               ' left outer join MKT_DEMANDORDER i on i.TENANT_ID=ji.TENANT_ID and ji.FIG_ID=i.DEMA_ID ';
  IsSQLUpdate := True;
  Str := 'insert into SAL_SALESORDER(TENANT_ID,SHOP_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,ADVA_MNY,PAY_A,PAY_B,PAY_C,'+
      'PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,COMM,CREA_DATE,CREA_USER,TIME_STAMP,LINKMAN,TELEPHONE,SEND_ADDR,SALES_STYLE,IC_CARDNO,UNION_ID) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SALES_ID,:GLIDE_NO,:SALES_DATE,:SALES_TYPE,:PLAN_DATE,:CLIENT_ID,:GUIDE_USER,:CHK_DATE,:CHK_USER,:FROM_ID,:FIG_ID,:SALE_AMT,:SALE_MNY,:CASH_MNY,:PAY_ZERO,:PAY_DIBS,:ADVA_MNY,:PAY_A,:PAY_B,:PAY_C,:PAY_D,'+
      ':PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,:INTEGRAL,:REMARK,:INVOICE_FLAG,:TAX_RATE,''00'','+GetSysDateFormat(iDbType)+',:CREA_USER,'+GetTimeStamp(iDbType)+',:LINKMAN,:TELEPHONE,:SEND_ADDR,:SALES_STYLE,:IC_CARDNO,:UNION_ID)';
  InsertSQL.Text := Str;
  Str := 'update SAL_SALESORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SALES_ID=:SALES_ID,GLIDE_NO=:GLIDE_NO,SALES_DATE=:SALES_DATE,PLAN_DATE=:PLAN_DATE,SALES_TYPE=:SALES_TYPE,CLIENT_ID=:CLIENT_ID,'+
         'GUIDE_USER=:GUIDE_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,FROM_ID=:FROM_ID,FIG_ID=:FIG_ID,SALE_AMT=:SALE_AMT,SALE_MNY=:SALE_MNY,CASH_MNY=:CASH_MNY,PAY_ZERO=:PAY_ZERO,PAY_DIBS=:PAY_DIBS,PAY_A=:PAY_A,PAY_B=:PAY_B,'+
         'PAY_C=:PAY_C,PAY_D=:PAY_D,PAY_E=:PAY_E,PAY_F=:PAY_F,PAY_G=:PAY_G,PAY_H=:PAY_H,PAY_I=:PAY_I,PAY_J=:PAY_J,INTEGRAL=:INTEGRAL,REMARK=:REMARK,INVOICE_FLAG=:INVOICE_FLAG,TAX_RATE=:TAX_RATE,'
    + 'COMM=' + GetCommStr(iDbType) + ',LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,SEND_ADDR=:SEND_ADDR,SALES_STYLE=:SALES_STYLE,IC_CARDNO=:IC_CARDNO,UNION_ID=:UNION_ID,'
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_SALESORDER where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  DeleteSQL.Text := Str;
end;

{ TDbOrderGetPrior }

procedure TDbOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC limit 1';
  end;
end;

{ TDbOrderGetNext }

procedure TDbOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO limit 1';
  end;

end;

{ TDbOrderAudit }

function TDbOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
  AGlobal.BeginTrans;
  try
    Str := 'update SAL_SALESORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Str := 'update STK_STOCKORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and STOCK_ID='''+Params.FindParam('SALES_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    Result := true;
    AGlobal.CommitTrans;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '审核错误'+E.Message;
        AGlobal.RollbackTrans;
      end;
  end;
end;

{ TDbOrderUnAudit }

function TDbOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select LOCUS_STATUS from SAL_SALESORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('SALES_ID').asString+'''';
    AGlobal.Open(rs);
    if rs.Fields[0].asString='3' then Raise Exception.Create('已经扫码出库完毕，不能弃核..');
  finally
    rs.Free;
  end;
   AGlobal.BeginTrans; 
   try
    Str := 'update SAL_SALESORDER set CHK_DATE=null,CHK_USER=null where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');

    Str := 'update STK_STOCKORDER set CHK_DATE=null,CHK_USER=null where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and STOCK_ID='''+Params.FindParam('SALES_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    AGlobal.CommitTrans;
    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '反审核错误:'+E.Message;
         AGlobal.RollbackTrans;
       end;
  end;
end;

{ TDbForLocusNo }

function TDbForLocusNo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from STK_LOCUS_FORSTCK where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO',self);
end;

function TDbForLocusNo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  Str := 'insert into STK_LOCUS_FORSTCK(TENANT_ID,SHOP_ID,STOCK_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_DATE,LOCUS_NO,UNIT_ID,AMOUNT,CALC_AMOUNT,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SALES_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:LOCUS_DATE,:LOCUS_NO,:UNIT_ID,:AMOUNT,:CALC_AMOUNT,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  AGlobal.ExecSQL(Str,self); 
end;

function TDbForLocusNo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  Str := 'update STK_LOCUS_FORSTCK set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,STOCK_ID=:SALES_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,'+
      'LOCUS_DATE=:LOCUS_DATE,LOCUS_NO=:LOCUS_NO,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,CALC_AMOUNT=:CALC_AMOUNT,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER, '
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  AGlobal.ExecSQL(Str,self); 
end;

procedure TDbForLocusNo.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
               'select TENANT_ID,SHOP_ID,SALES_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_DATE,LOCUS_NO,UNIT_ID,AMOUNT,CALC_AMOUNT,CREA_DATE,CREA_USER,COMM,TIME_STAMP '+
               'from SAL_LOCUS_FORSALE j where j.TENANT_ID=:TENANT_ID and j.SALES_ID=:SALES_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into SAL_LOCUS_FORSALE(TENANT_ID,SHOP_ID,SALES_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_DATE,LOCUS_NO,UNIT_ID,AMOUNT,CALC_AMOUNT,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SALES_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:LOCUS_DATE,:LOCUS_NO,:UNIT_ID,:AMOUNT,:CALC_AMOUNT,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := str;
  Str := 'update SAL_LOCUS_FORSALE set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SALES_ID=:SALES_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,'+
      'LOCUS_DATE=:LOCUS_DATE,LOCUS_NO=:LOCUS_NO,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,CALC_AMOUNT=:CALC_AMOUNT,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER, '
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from SAL_LOCUS_FORSALE where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TDbForLocusNoHeader }

function TDbForLocusNoHeader.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
end;

procedure TDbForLocusNoHeader.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
               'select jh.*,h.USER_NAME as STOCK_USER_TEXT from ('+
               'select jg.*,g.GUIDE_USER as STOCK_USER,g.STOCK_MNY from ('+
               'select jf.*,f.USER_NAME as GUIDE_USER_TEXT from ('+
               'select je.*,e.SHOP_NAME as SHOP_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+
               'select jb.*,b.SHOP_NAME as CLIENT_ID_TEXT from '+
               '(select TENANT_ID,SHOP_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,CLIENT_ID,PLAN_DATE,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,'+
               'ADVA_MNY,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,SALES_STYLE,IC_CARDNO,UNION_ID,COMM,CREA_DATE,CREA_USER,'+
               'LOCUS_STATUS,LOCUS_USER,LOCUS_DATE,LOCUS_AMT,LOCUS_CHK_DATE,LOCUS_CHK_USER,'+
               'TIME_STAMP from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) jb '+
               ' left outer join CA_SHOP_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.SHOP_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_SHOP_INFO e on je.TENANT_ID=e.TENANT_ID and je.SHOP_ID=e.SHOP_ID ) jf '+
               ' left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.GUIDE_USER=f.USER_ID ) jg '+
               ' left outer join STK_STOCKORDER g on jg.TENANT_ID=g.TENANT_ID and jg.SALES_ID=g.STOCK_ID and jg.SALES_TYPE=g.STOCK_TYPE ) jh '+
               ' left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.STOCK_USER=h.USER_ID ';
  IsSQLUpdate := True;
  Str :=
      'update SAL_SALESORDER set LOCUS_STATUS=:LOCUS_STATUS,LOCUS_USER=:LOCUS_USER,LOCUS_DATE=:LOCUS_DATE,LOCUS_AMT=:LOCUS_AMT,LOCUS_CHK_DATE=:LOCUS_CHK_DATE,LOCUS_CHK_USER=:LOCUS_CHK_USER,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  UpdateSQL.Text := Str;
end;

{ TDbLocusNoAudit }

function TDbLocusNoAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select LOCUS_STATUS from SAL_SALESORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('SALES_ID').asString+'''';
    AGlobal.Open(rs);
    if rs.Fields[0].AsString<>'3' then Raise Exception.Create('没有发货完毕，不能审核..');
  finally
    rs.Free;
  end;
  AGlobal.BeginTrans;
  try
    Str := 'update SAL_SALESORDER set LOCUS_CHK_DATE='''+Params.FindParam('LOCUS_CHK_DATE').asString+''',LOCUS_CHK_USER='''+Params.FindParam('LOCUS_CHK_USER').asString+''' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and LOCUS_CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Result := true;
    AGlobal.CommitTrans;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '审核错误'+E.Message;
        AGlobal.RollbackTrans;
      end;
  end;
end;

{ TDbLocusNoUnAudit }

function TDbLocusNoUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
  rs:TZQuery;
begin
   AGlobal.BeginTrans;
   try
    Str := 'update SAL_SALESORDER set LOCUS_CHK_DATE=null,LOCUS_CHK_USER=null,LOCUS_STATUS=''1'' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and LOCUS_CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    AGlobal.CommitTrans;
    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '反审核错误:'+E.Message;
         AGlobal.RollbackTrans;
       end;
  end;
end;

{ TDbForInLocusNoHeader }

function TDbForInLocusNoHeader.BeforeModifyRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  if FieldbyName('PLAN_DATE').AsOldString='' then result := inherited BeforeModifyRecord(AGlobal);
  Str :=
      'update STK_STOCKORDER set LOCUS_STATUS=:LOCUS_STATUS,LOCUS_USER=:LOCUS_USER,LOCUS_DATE=:LOCUS_DATE,LOCUS_AMT=:LOCUS_AMT,LOCUS_CHK_DATE=:LOCUS_CHK_DATE,LOCUS_CHK_USER=:LOCUS_CHK_USER,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and STOCK_ID=:OLD_SALES_ID';
  AGlobal.ExecSQL(Str,self);
  result := true; 
end;

function TDbForInLocusNoHeader.BeforeUpdateRecord(
  AGlobal: IdbHelp): Boolean;
begin
  if FieldbyName('PLAN_DATE').AsOldString='' then
  begin
     Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,formatDatetime('YYYYMMDD',fnTime.fnStrtoDate(FieldbyName('PLAN_DATE').AsString)),FieldbyName('TIME_STAMP').AsString);
  end;
  result := true;
end;

procedure TDbForInLocusNoHeader.InitClass;
begin
  inherited;
  SelectSQL.Text :=
               'select jh.*,h.USER_NAME as STOCK_USER_TEXT from ('+
               'select jg.*,g.GUIDE_USER as STOCK_USER,g.STOCK_MNY,g.LOCUS_STATUS,g.LOCUS_USER,g.LOCUS_DATE,g.LOCUS_AMT,g.LOCUS_CHK_DATE,g.LOCUS_CHK_USER from ('+
               'select jf.*,f.USER_NAME as GUIDE_USER_TEXT from ('+
               'select je.*,e.SHOP_NAME as SHOP_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+
               'select jb.*,b.SHOP_NAME as CLIENT_ID_TEXT from '+
               '(select TENANT_ID,SHOP_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,CLIENT_ID,PLAN_DATE,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,'+
               'ADVA_MNY,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,SALES_STYLE,IC_CARDNO,UNION_ID,COMM,CREA_DATE,CREA_USER,'+
               'TIME_STAMP from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) jb '+
               ' left outer join CA_SHOP_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.SHOP_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_SHOP_INFO e on je.TENANT_ID=e.TENANT_ID and je.SHOP_ID=e.SHOP_ID ) jf '+
               ' left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.GUIDE_USER=f.USER_ID ) jg '+
               ' left outer join STK_STOCKORDER g on jg.TENANT_ID=g.TENANT_ID and jg.SALES_ID=g.STOCK_ID and jg.SALES_TYPE=g.STOCK_TYPE ) jh '+
               ' left outer join VIW_USERS h on jh.TENANT_ID=h.TENANT_ID and jh.STOCK_USER=h.USER_ID ';
  IsSQLUpdate := True;
end;

{ TDbInLocusNoAudit }

function TDbInLocusNoAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select LOCUS_STATUS from STK_STOCKORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and STOCK_ID='''+Params.FindParam('SALES_ID').asString+'''';
    AGlobal.Open(rs);
    if rs.Fields[0].AsString<>'3' then Raise Exception.Create('没有发货完毕，不能审核..');
  finally
    rs.Free;
  end;
  AGlobal.BeginTrans;
  try
    Str := 'update STK_STOCKORDER set LOCUS_CHK_DATE='''+Params.FindParam('LOCUS_CHK_DATE').asString+''',LOCUS_CHK_USER='''+Params.FindParam('LOCUS_CHK_USER').asString+''' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and STOCK_ID='''+Params.FindParam('SALES_ID').asString+''' and LOCUS_CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待审核单据，是否被另一用户删除或已审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Result := true;
    AGlobal.CommitTrans;
    Msg := '审核单据成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '审核错误'+E.Message;
        AGlobal.RollbackTrans;
      end;
  end;
end;

{ TDbInLocusNoUnAudit }

function TDbInLocusNoUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
  rs:TZQuery;
begin
   AGlobal.BeginTrans;
   try
    Str := 'update STK_STOCKORDER set LOCUS_CHK_DATE=null,LOCUS_CHK_USER=null,LOCUS_STATUS=''1'' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and STOCK_ID='''+Params.FindParam('SALES_ID').asString+''' and LOCUS_CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已审核单据，是否被另一用户删除或反审核。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    AGlobal.CommitTrans;
    MSG := '反审核单据成功。';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '反审核错误:'+E.Message;
         AGlobal.RollbackTrans;
       end;
  end;
end;

initialization
  RegisterClass(TDbOrder);
  RegisterClass(TDbData);
  RegisterClass(TDbOrderAudit);
  RegisterClass(TDbOrderUnAudit);
  RegisterClass(TDbOrderGetPrior);
  RegisterClass(TDbOrderGetNext);
  RegisterClass(TDbForLocusNo);
  RegisterClass(TDbForLocusNoHeader);
  RegisterClass(TDbForInLocusNoHeader);
  RegisterClass(TDbLocusNoAudit);
  RegisterClass(TDbLocusNoUnAudit);
  RegisterClass(TDbInLocusNoAudit);
  RegisterClass(TDbInLocusNoUnAudit);
finalization
  UnRegisterClass(TDbOrder);
  UnRegisterClass(TDbData);
  UnRegisterClass(TDbOrderAudit);
  UnRegisterClass(TDbOrderUnAudit);
  UnRegisterClass(TDbOrderGetPrior);
  UnRegisterClass(TDbOrderGetNext);
  UnRegisterClass(TDbForLocusNo);
  UnRegisterClass(TDbForLocusNoHeader);
  UnRegisterClass(TDbForInLocusNoHeader);
  UnRegisterClass(TDbLocusNoAudit);
  UnRegisterClass(TDbLocusNoUnAudit);
  UnRegisterClass(TDbInLocusNoAudit);
  UnRegisterClass(TDbInLocusNoUnAudit);
end.
