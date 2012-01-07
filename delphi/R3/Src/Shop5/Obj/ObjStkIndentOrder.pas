unit ObjStkIndentOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;
type
  TStkIndentOrder=class(TZFactory)
  private
    Locked:boolean;
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
  TStkIndentData=class(TZFactory)
  public
    IsZeroOut:Boolean;
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
  TStkIndentDataForStock=class(TZFactory)
  public
    procedure InitClass; override;
  end;
  TStkIndentOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TStkIndentOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TStkIndentOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TStkIndentOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TStkIndentData }

function TStkIndentData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
   Result := true;
end;

function TStkIndentData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TStkIndentData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TStkIndentData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TStkIndentData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := true;
end;

procedure TStkIndentData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select j.TENANT_ID,j.SHOP_ID,j.INDE_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.IS_PRESENT,j.APRICE,j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,'+
               'case when j.CALC_AMOUNT=0 then 0 else j.FNSH_AMOUNT / (cast(j.CALC_AMOUNT/(j.AMOUNT*1.0) as decimal(18,3))*1.0) end as FNSH_AMOUNT,'+
               'j.REMARK,b.GODS_NAME,b.GODS_CODE,j.ORG_PRICE*j.AMOUNT as RTL_MONEY from STK_INDENTDATA j inner join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.INDE_ID=:INDE_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into STK_INDENTDATA(TENANT_ID,SHOP_ID,SEQNO,INDE_ID,GODS_ID,BATCH_NO,LOCUS_NO,BOM_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,AMOUNT,ORG_PRICE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,REMARK) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SEQNO,:INDE_ID,:GODS_ID,:BATCH_NO,:LOCUS_NO,:BOM_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:AMOUNT,:ORG_PRICE,:IS_PRESENT,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:REMARK)';
  InsertSQL.Text := Str;
  Str := 'update STK_INDENTDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SEQNO=:SEQNO,INDE_ID=:INDE_ID,GODS_ID=:GODS_ID,BATCH_NO=:BATCH_NO,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,ORG_PRICE=:ORG_PRICE,'+
         'IS_PRESENT=:IS_PRESENT,APRICE=:APRICE,AMONEY=:AMONEY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY,CALC_AMOUNT=:CALC_AMOUNT,CALC_MONEY=:CALC_MONEY,REMARK=:REMARK '
    + 'where TENANT_ID=:OLD_TENANT_ID and INDE_ID=:OLD_INDE_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := Str;
  Str := 'delete from STK_INDENTDATA where TENANT_ID=:OLD_TENANT_ID and INDE_ID=:OLD_INDE_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := Str;
end;

{ TStkIndentOrder }

function TStkIndentOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var SQL:string;
begin
{  SQL :=
    'UPDATE STK_INDENTDATA '+
    'SET '+
    '  FNSH_AMOUNT = ( '+
    '    SELECT '+
    '      sum( b.CALC_AMOUNT ) '+
    '    FROM  '+
    '      STK_STOCKORDER a ,'+
    '      STK_STOCKDATA b '+
    '    WHERE '+
    '      a.TENANT_ID = b.TENANT_ID AND a.STOCK_ID = b.STOCK_ID AND a.TENANT_ID = :TENANT_ID AND a.FROM_ID = :INDE_ID '+
    '      AND b.GODS_ID = STK_INDENTDATA.GODS_ID AND b.LOCUS_NO = STK_INDENTDATA.LOCUS_NO AND b.BATCH_NO = STK_INDENTDATA.BATCH_NO '+
    '      AND b.UNIT_ID = STK_INDENTDATA.UNIT_ID AND b.PROPERTY_01 = STK_INDENTDATA.PROPERTY_01 AND b.PROPERTY_02 = STK_INDENTDATA.PROPERTY_02 AND b.IS_PRESENT = STK_INDENTDATA.IS_PRESENT  '+
    '  ) '+
    'WHERE INDE_ID = :INDE_ID AND TENANT_ID = :TENANT_ID';
  AGlobal.ExecSQL(SQL,self);   }
  result := true;
end;

function TStkIndentOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  if not Locked and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  if FieldbyName('ADVA_MNY').AsOldFloat <> 0 then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select PAYM_MNY from ACC_PAYABLE_INFO where TENANT_ID='+FieldbyName('TENANT_ID').AsOldString+' and STOCK_ID='''+FieldbyName('INDE_ID').AsOldString+''' and ABLE_TYPE=''6''';
         AGlobal.Open(rs);
         if (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('已经付款的订货单不能修改...'); 
       finally
         rs.Free;
       end;
       AGlobal.ExecSQL('delete from ACC_PAYABLE_INFO where TENANT_ID='+FieldbyName('TENANT_ID').AsOldString+' and STOCK_ID='''+FieldbyName('INDE_ID').AsOldString+''' and ABLE_TYPE=''6''');
     end;
  result := true;
end;

function TStkIndentOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_8_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
  if (FieldbyName('ADVA_MNY').AsFloat <> 0) then
  begin
     AGlobal.ExecSQL(
         'insert into ACC_PAYABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,ABLE_TYPE,ACCT_MNY,PAYM_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,STOCK_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES('''+newid(FieldbyName('SHOP_ID').AsString)+''',:TENANT_ID,:SHOP_ID,:DEPT_ID,:CLIENT_ID,'''+'预付款【订单号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''6'',:ADVA_MNY,0,0,:ADVA_MNY,:INDE_DATE,:INDE_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
    ,self);
  end;
  result := true;
end;

function TStkIndentOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  Locked := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    Locked := false;
  end;
end;

function TStkIndentOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
//   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
//      begin
//        Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('INDE_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
//        if FieldbyName('INDE_DATE').AsOldString <> '' then
//           Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('INDE_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
//        result := true;
//      end
//   else
//      Result := true;
  Result := true;
end;

function TStkIndentOrder.CheckTimeStamp(aGlobal: IdbHelp;
  s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from STK_INDENTORDER where INDE_ID='''+FieldbyName('INDE_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString+'';
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

procedure TStkIndentOrder.InitClass;
var
  Str: string;
begin
  inherited;
  Locked := false;
  SelectSQL.Text :=
               'select je.*,e.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
               'select jb.*,b.CLIENT_NAME as CLIENT_ID_TEXT from '+
               '(select TENANT_ID,SHOP_ID,DEPT_ID,INDE_ID,GLIDE_NO,INDE_DATE,GUIDE_USER,CLIENT_ID,CHK_DATE,CHK_USER,PLAN_DATE,ADVA_MNY,FIG_ID,INVOICE_FLAG,TAX_RATE,REMARK,COMM,CREA_DATE,CREA_USER,'+
               'TIME_STAMP,INDE_AMT,INDE_MNY,STKBILL_STATUS from STK_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID) jb '+
               ' left outer join VIW_CLIENTINFO b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_DEPT_INFO e on je.TENANT_ID=e.TENANT_ID and je.DEPT_ID=e.DEPT_ID ';
  IsSQLUpdate := True;
  Str := 'insert into STK_INDENTORDER(TENANT_ID,SHOP_ID,DEPT_ID,INDE_ID,GLIDE_NO,INDE_DATE,GUIDE_USER,CLIENT_ID,CHK_DATE,CHK_USER,PLAN_DATE,ADVA_MNY,FIG_ID,INDE_AMT,INDE_MNY,INVOICE_FLAG,TAX_RATE,REMARK,STKBILL_STATUS,COMM,CREA_DATE,CREA_USER,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:DEPT_ID,:INDE_ID,:GLIDE_NO,:INDE_DATE,:GUIDE_USER,:CLIENT_ID,:CHK_DATE,:CHK_USER,:PLAN_DATE,:ADVA_MNY,:FIG_ID,:INDE_AMT,:INDE_MNY,:INVOICE_FLAG,:TAX_RATE,:REMARK,0,''00'',:CREA_DATE,:CREA_USER,'+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update STK_INDENTORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,INDE_ID=:INDE_ID,GLIDE_NO=:GLIDE_NO,INDE_DATE=:INDE_DATE,ADVA_MNY=:ADVA_MNY,GUIDE_USER=:GUIDE_USER,CLIENT_ID=:CLIENT_ID,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,'+
         'PLAN_DATE=:PLAN_DATE,FIG_ID=:FIG_ID,INDE_AMT=:INDE_AMT,INDE_MNY=:INDE_MNY,INVOICE_FLAG=:INVOICE_FLAG,TAX_RATE=:TAX_RATE,REMARK=:REMARK,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and INDE_ID=:OLD_INDE_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from STK_INDENTORDER where TENANT_ID=:OLD_TENANT_ID and INDE_ID=:OLD_INDE_ID';
  DeleteSQL.Text := Str;
end;

{ TStkIndentOrderGetPrior }

procedure TStkIndentOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 INDE_ID from STK_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select INDE_ID from STK_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select INDE_ID from STK_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select INDE_ID from STK_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC limit 1';
  end;
end;

{ TStkIndentOrderGetNext }

procedure TStkIndentOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 INDE_ID from STK_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select INDE_ID from STK_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select INDE_ID from STK_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select INDE_ID from STK_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO limit 1';
  end;
end;

{ TStkIndentOrderAudit }

function TStkIndentOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  try
//    Temp := TZQuery.Create(nil);
//    try
//      Temp.SQL.Text := 'select STKBILL_STATUS from STK_INDENTORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INDE_ID='''+Params.FindParam('INDE_ID').asString+'''';
//      AGlobal.Open(Temp);
//      if Temp.Fields[0].AsInteger>0 then Raise Exception.Create('已经入库的订单不能再修改了...');
//    finally
//      Temp.Free;
//    end;
    Str := 'update STK_INDENTORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INDE_ID='''+Params.FindParam('INDE_ID').asString+''' and CHK_DATE IS NULL';
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

{ TStkIndentOrderUnAudit }

function TStkIndentOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    rs:TZQuery;
begin
   try
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select STOCK_ID from STK_STOCKORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and FROM_ID='''+Params.FindParam('INDE_ID').asString+'''';
      AGlobal.Open(rs);
      if not rs.IsEmpty then Raise Exception.Create('已经入库的订货单不能弃审...');
      rs.Close;
      rs.SQL.Text := 'select FIG_ID from STK_INDENTORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INDE_ID='''+Params.FindParam('INDE_ID').asString+'''';
      AGlobal.Open(rs);
      if rs.FieldbyName('FIG_ID').AsString <> '' then Raise Exception.Create('已经配货的订货单不能弃审...');
    finally
      rs.Free;
    end;
    Str := 'update STK_INDENTORDER set CHK_DATE=null,CHK_USER=null,STKBILL_STATUS=0,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INDE_ID='''+Params.FindParam('INDE_ID').asString+''' and CHK_DATE IS NOT NULL';
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

{ TStkIndentDataForStock }

procedure TStkIndentDataForStock.InitClass;
begin
  SelectSQL.Text :=
     ParseSQL(iDbType,
     'select s.*,round(AMOUNT*APRICE,2) as AMONEY,round(AMOUNT*APRICE,2) as CALC_MONEY,round(AMOUNT*ORG_PRICE,2)-round(AMOUNT*APRICE,2) as AGIO_MONEY from( '+
     'select j.TENANT_ID,j.SHOP_ID,j.INDE_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.ORG_PRICE,j.IS_PRESENT,j.APRICE,j.AGIO_RATE,'+
      'case when j.CALC_AMOUNT=0 then 0 else (isnull(j.CALC_AMOUNT,0)-isnull(j.FNSH_AMOUNT,0)) / (cast(j.CALC_AMOUNT/(j.AMOUNT*1.0) as decimal(18,3))*1.0) end as AMOUNT,isnull(j.CALC_AMOUNT,0)-isnull(j.FNSH_AMOUNT,0) as CALC_AMOUNT,'+
     'j.REMARK,b.GODS_NAME,b.GODS_CODE,j.ORG_PRICE*j.AMOUNT as RTL_MONEY from STK_INDENTDATA j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
      'where j.TENANT_ID=:TENANT_ID and j.INDE_ID=:INDE_ID and (isnull(j.CALC_AMOUNT,0)-isnull(j.FNSH_AMOUNT,0))>0 ) s order by SEQNO');
end;

initialization
  RegisterClass(TStkIndentOrder);
  RegisterClass(TStkIndentData);
  RegisterClass(TStkIndentDataForStock);
  RegisterClass(TStkIndentOrderGetPrior);
  RegisterClass(TStkIndentOrderGetNext);
  RegisterClass(TStkIndentOrderAudit);
  RegisterClass(TStkIndentOrderUnAudit);
finalization
  UnRegisterClass(TStkIndentOrder);
  UnRegisterClass(TStkIndentData);
  UnRegisterClass(TStkIndentDataForStock);
  UnRegisterClass(TStkIndentOrderGetPrior);
  UnRegisterClass(TStkIndentOrderGetNext);
  UnRegisterClass(TStkIndentOrderAudit);
  UnRegisterClass(TStkIndentOrderUnAudit);
end.
