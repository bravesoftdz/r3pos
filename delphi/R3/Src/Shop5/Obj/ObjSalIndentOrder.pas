unit ObjSalIndentOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;
type
  TSalIndentOrder=class(TZFactory)
  private
    lock:boolean;
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
  TSalIndentData=class(TZFactory)
  private
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
    procedure InitClass;override;
  end;
  TSalIndentOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TSalIndentOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TSalIndentOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSalIndentOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TStockData }

function TSalIndentData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := true;
end;

function TSalIndentData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TSalIndentData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TSalIndentData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TSalIndentData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := true;
end;

procedure TSalIndentData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
      'select j.TENANT_ID,j.SHOP_ID,j.INDE_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.BOM_ID,j.LOCUS_NO,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.POLICY_TYPE,j.IS_PRESENT,j.APRICE,'+
      'j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,'+
      'case when j.CALC_AMOUNT=0 then 0 else j.FNSH_AMOUNT / (j.CALC_AMOUNT/j.AMOUNT) end as FNSH_AMOUNT,'+
      'j.HAS_INTEGRAL,j.REMARK,b.GODS_NAME,b.GODS_CODE from SAL_INDENTDATA j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.INDE_ID=:INDE_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into SAL_INDENTDATA(TENANT_ID,SHOP_ID,INDE_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,BOM_ID,LOCUS_NO,UNIT_ID,AMOUNT,ORG_PRICE,POLICY_TYPE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,HAS_INTEGRAL,REMARK) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:INDE_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:BOM_ID,:LOCUS_NO,:UNIT_ID,:AMOUNT,:ORG_PRICE,:POLICY_TYPE,:IS_PRESENT,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:HAS_INTEGRAL,:REMARK)';
  InsertSQL.Text := Str;
  Str := 'update SAL_INDENTDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,INDE_ID=:INDE_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,BOM_ID=:BOM_ID,LOCUS_NO=:LOCUS_NO,UNIT_ID=:UNIT_ID,'+
      'AMOUNT=:AMOUNT,ORG_PRICE=:ORG_PRICE,POLICY_TYPE=:POLICY_TYPE,IS_PRESENT=:IS_PRESENT,APRICE=:APRICE,AMONEY=:AMONEY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY,CALC_AMOUNT=:CALC_AMOUNT,'+
      'CALC_MONEY=:CALC_MONEY,HAS_INTEGRAL=:HAS_INTEGRAL,REMARK=:REMARK '
    + 'where TENANT_ID=:OLD_TENANT_ID and INDE_ID=:OLD_INDE_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_INDENTDATA where TENANT_ID=:OLD_TENANT_ID and INDE_ID=:OLD_INDE_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := Str;
end;

{ TSalIndentOrder }

function TSalIndentOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var SQL:string;
begin
  SQL :=
    'UPDATE SAL_INDENTDATA '+
    'SET '+
    '  FNSH_AMOUNT = ( '+
    '    SELECT '+
    '      sum( b.CALC_AMOUNT ) '+
    '    FROM  '+
    '      SAL_SALESORDER a ,'+
    '      SAL_SALESDATA b '+
    '    WHERE '+
    '      a.TENANT_ID = b.TENANT_ID AND a.SALES_ID = b.SALES_ID AND a.TENANT_ID = :TENANT_ID AND a.FROM_ID = :INDE_ID '+
    '      AND b.GODS_ID = SAL_INDENTDATA.GODS_ID AND b.LOCUS_NO = SAL_INDENTDATA.LOCUS_NO AND b.BATCH_NO = SAL_INDENTDATA.BATCH_NO '+
    '      AND b.UNIT_ID = SAL_INDENTDATA.UNIT_ID AND b.PROPERTY_01 = SAL_INDENTDATA.PROPERTY_01 AND b.PROPERTY_02 = SAL_INDENTDATA.PROPERTY_02 AND b.IS_PRESENT = SAL_INDENTDATA.IS_PRESENT  '+
    '  ) '+
    'WHERE INDE_ID = :INDE_ID AND TENANT_ID = :TENANT_ID';
  AGlobal.ExecSQL(SQL,self);
  result := true;
end;

function TSalIndentOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  if not lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  if FieldbyName('ADVA_MNY').AsOldFloat <> 0 then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select RECV_MNY from ACC_RECVABLE_INFO where TENANT_ID='+FieldbyName('TENANT_ID').AsOldString+' and SALES_ID='''+FieldbyName('INDE_ID').AsOldString+'''';
         AGlobal.Open(rs);
         if (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('已经收款的订货单不能修改...');
         AGlobal.ExecSQL('delete from ACC_RECVABLE_INFO where TENANT_ID='+FieldbyName('TENANT_ID').AsOldString+' and SALES_ID='''+FieldbyName('INDE_ID').AsOldString+'''');
       finally
         rs.Free;
       end;
     end;
  result := true;
end;

function TSalIndentOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := GetSequence(AGlobal,'GNO_7_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
  if (FieldbyName('ADVA_MNY').AsFloat <> 0) then
  begin
     AGlobal.ExecSQL(
         'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES('''+newid(FieldbyName('SHOP_ID').AsString)+''',:TENANT_ID,:SHOP_ID,:CLIENT_ID,'''+'预收款【订单号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''3'',:ADVA_MNY,0,0,:ADVA_MNY,:INDE_DATE,:INDE_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
    ,self);
  end;
  result := true;
end;

function TSalIndentOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  lock := true;
  try
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
end;

function TSalIndentOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
        Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('INDE_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
        if FieldbyName('INDE_DATE').AsOldString <> '' then
           Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('INDE_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
        result := true;
      end
   else
      Result := true;
  result := true;
end;

function TSalIndentOrder.CheckTimeStamp(aGlobal: IdbHelp;
  s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from SAL_INDENTORDER where INDE_ID='''+FieldbyName('INDE_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString+'';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TSalIndentOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select je.*,e.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as GUIDE_USER_TEXT from ('+
               'select jb.*,b.CLIENT_NAME as CLIENT_ID_TEXT,b.PRICE_ID,b.INTEGRAL as ACCU_INTEGRAL,b.BALANCE,b.CLIENT_CODE from '+
               '(select TENANT_ID,SHOP_ID,DEPT_ID,INDE_ID,GLIDE_NO,INDE_DATE,PLAN_DATE,ADVA_MNY,LINKMAN,TELEPHONE,SEND_ADDR,SALES_STYLE,CLIENT_ID,'+
               'IC_CARDNO,UNION_ID,GUIDE_USER,CHK_DATE,CHK_USER,FIG_ID,REMARK,INVOICE_FLAG,TAX_RATE,COMM,CREA_DATE,CREA_USER,'+
               'INDE_AMT,INDE_MNY,TIME_STAMP from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID) jb '+
               ' left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.GUIDE_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_DEPT_INFO e on je.TENANT_ID=e.TENANT_ID and je.DEPT_ID=e.DEPT_ID ';
  IsSQLUpdate := True;
  Str :=
      'insert into SAL_INDENTORDER(TENANT_ID,SHOP_ID,DEPT_ID,INDE_ID,GLIDE_NO,INDE_DATE,PLAN_DATE,ADVA_MNY,LINKMAN,TELEPHONE,SEND_ADDR,SALES_STYLE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,INDE_AMT,'+
      'INDE_MNY,FIG_ID,REMARK,INVOICE_FLAG,TAX_RATE,COMM,CREA_DATE,CREA_USER,IC_CARDNO,UNION_ID,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:DEPT_ID,:INDE_ID,:GLIDE_NO,:INDE_DATE,:PLAN_DATE,:ADVA_MNY,:LINKMAN,:TELEPHONE,:SEND_ADDR,:SALES_STYLE,:CLIENT_ID,:GUIDE_USER,:CHK_DATE,:CHK_USER,:INDE_AMT,'+
      ':INDE_MNY,:FIG_ID,:REMARK,:INVOICE_FLAG,:TAX_RATE,''00'',:CREA_DATE,:CREA_USER,:IC_CARDNO,:UNION_ID,'+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update SAL_INDENTORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,INDE_ID=:INDE_ID,GLIDE_NO=:GLIDE_NO,INDE_DATE=:INDE_DATE,PLAN_DATE=:PLAN_DATE,ADVA_MNY=:ADVA_MNY,CLIENT_ID=:CLIENT_ID,INDE_AMT=:INDE_AMT,INDE_MNY=:INDE_MNY,'+
         'GUIDE_USER=:GUIDE_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,SEND_ADDR=:SEND_ADDR,SALES_STYLE=:SALES_STYLE,FIG_ID=:FIG_ID,'+
         'REMARK=:REMARK,INVOICE_FLAG=:INVOICE_FLAG,TAX_RATE=:TAX_RATE,IC_CARDNO=:IC_CARDNO,UNION_ID=:UNION_ID,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and INDE_ID=:OLD_INDE_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_INDENTORDER where TENANT_ID=:OLD_TENANT_ID and INDE_ID=:OLD_INDE_ID';
  DeleteSQL.Text := Str;
end;

{ TSalIndentOrderGetPrior }

procedure TSalIndentOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC';
  4:SelectSQL.Text := 'select * from (select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO DESC limit 1';
  end;
end;

{ TSalIndentOrderGetNext }

procedure TSalIndentOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
  4:SelectSQL.Text := 'select * from (select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select INDE_ID from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO limit 1';
  end;
end;

{ TSalIndentOrderAudit }

function TSalIndentOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
begin
  try
    Str := 'update SAL_INDENTORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INDE_ID='''+Params.FindParam('INDE_ID').asString+''' and CHK_DATE IS NULL';
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

{ TSalIndentOrderUnAudit }

function TSalIndentOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
begin
   try
    Str := 'update SAL_INDENTORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INDE_ID='''+Params.FindParam('INDE_ID').asString+''' and CHK_DATE IS NOT NULL';
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

initialization
  RegisterClass(TSalIndentOrder);
  RegisterClass(TSalIndentData);
  RegisterClass(TSalIndentOrderAudit);
  RegisterClass(TSalIndentOrderUnAudit);
  RegisterClass(TSalIndentOrderGetPrior);
  RegisterClass(TSalIndentOrderGetNext);
finalization
  UnRegisterClass(TSalIndentOrder);
  UnRegisterClass(TSalIndentData);
  UnRegisterClass(TSalIndentOrderAudit);
  UnRegisterClass(TSalIndentOrderUnAudit);
  UnRegisterClass(TSalIndentOrderGetPrior);
  UnRegisterClass(TSalIndentOrderGetNext);
end.
