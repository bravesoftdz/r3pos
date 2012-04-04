unit ObjBomOrder;

interface
uses Dialogs,SysUtils,zBase,Classes,zintf,ObjCommon,DB,ZDataSet,math;
type
  TBomOrder=class(TZFactory)
  private
    lock:boolean;
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TBomData=class(TZFactory)
  private
    IsZeroOut:Boolean;
    lock:boolean;
  public
    procedure InitClass;override;
  end;

  TBomOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TBomOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;

  TBomOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TBomOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TBomOrder }



function TBomOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  if not Lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,True) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');

end;

function TBomOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
  begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_10_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
  end;
end;

function TBomOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := true;
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
end;



function TBomOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from SAL_BOMORDER where BOM_ID='''+FieldbyName('BOM_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString;
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



procedure TBomOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select jf.*,jf.GODS_ID as GODS_IDS,f.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select je.*,e.SHOP_NAME as SHOP_ID_TEXT from ( '+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ( '+
               'select jc.*,c.USER_NAME as CREA_USER_TEXT from ( '+
               'select jb.*,b.USER_NAME as BOM_USER_TEXT  from  '+
               '(select A.TENANT_ID,A.SHOP_ID,A.DEPT_ID,A.BOM_ID,A.GLIDE_NO,A.GIFT_CODE,A.GIFT_NAME,A.BARCODE,A.BOM_AMOUNT,A.RCK_AMOUNT,A.RTL_PRICE,A.BOM_DATE,A.BOM_USER,A.CHK_DATE,A.CHK_USER,A.REMARK,'+
               'A.CREA_DATE,A.CREA_USER,A.BOM_TYPE,A.BOM_STATUS,A.GODS_ID,A.COMM,A.TIME_STAMP,A.HAS_INTEGRAL '+
               '  from SAL_BOMORDER A  where A.TENANT_ID=:TENANT_ID and A.BOM_ID=:BOM_ID) jb  '+
               ' left outer join VIW_USERS b on jb.TENANT_ID=b.TENANT_ID and jb.BOM_USER=b.USER_ID ) jc  '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ) jd  '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je  '+
               ' left outer join CA_SHOP_INFO e on je.TENANT_ID=e.TENANT_ID and je.SHOP_ID=e.SHOP_ID ) jf '+
               ' left outer join CA_DEPT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.DEPT_ID=f.DEPT_ID ';
  IsSQLUpdate := True;
  Str := 'insert into SAL_BOMORDER(TENANT_ID,SHOP_ID,DEPT_ID,BOM_ID,GLIDE_NO,GIFT_CODE,GIFT_NAME,BARCODE,BOM_AMOUNT,RCK_AMOUNT,RTL_PRICE,BOM_DATE,BOM_USER,CHK_DATE,CHK_USER,REMARK,CREA_DATE,CREA_USER,COMM,TIME_STAMP,BOM_TYPE,BOM_STATUS,GODS_ID,HAS_INTEGRAL)'
      +'VALUES(:TENANT_ID,:SHOP_ID,:DEPT_ID,:BOM_ID,:GLIDE_NO,:GIFT_CODE,:GIFT_NAME,:BARCODE,:BOM_AMOUNT,:RCK_AMOUNT,:RTL_PRICE,:BOM_DATE,:BOM_USER,:CHK_DATE,:CHK_USER,:REMARK,'
      + GetSysDateFormat(iDbType)+',:CREA_USER,''00'','+GetTimeStamp(iDbType)+',:BOM_TYPE,:BOM_STATUS,:GODS_ID,:HAS_INTEGRAL)';
  InsertSQL.Text := Str;
  Str := ' update SAL_BOMORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,BOM_ID=:BOM_ID,GLIDE_NO=:GLIDE_NO,GIFT_CODE=:GIFT_CODE,GIFT_NAME=:GIFT_NAME,BARCODE=:BARCODE,BOM_AMOUNT=:BOM_AMOUNT,RCK_AMOUNT=:RCK_AMOUNT,'
         +'RTL_PRICE=:RTL_PRICE,BOM_DATE=:BOM_DATE,BOM_USER=:BOM_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,REMARK=:REMARK,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,'
         +'COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+',BOM_TYPE=:BOM_TYPE,BOM_STATUS=:BOM_STATUS,GODS_ID=:GODS_IDS,HAS_INTEGRAL=:HAS_INTEGRAL '
    + 'where TENANT_ID=:OLD_TENANT_ID and BOM_ID=:OLD_BOM_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_BOMORDER where TENANT_ID=:OLD_TENANT_ID and BOM_ID=:OLD_BOM_ID';
  DeleteSQL.Text := Str;
end;


{ TBomData }


procedure TBomData.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  {SelectSQL.Text :=
               'select b.GODS_NAME,b.GODS_CODE,j.TENANT_ID,j.SHOP_ID,j.SALES_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.POLICY_TYPE,'+
               'j.IS_PRESENT,j.BARTER_INTEGRAL,j.COST_PRICE,j.APRICE,j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,'+
               'j.HAS_INTEGRAL,j.REMARK,j.TREND_ID,b.BARCODE from SAL_SALESDATA j inner join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.SALES_ID=:SALES_ID order by SEQNO';
 }
  SelectSQL.Text :=
               'select b.GODS_NAME,b.GODS_CODE,j.TENANT_ID,j.SHOP_ID,j.BOM_ID,j.SEQNO,j.GODS_ID,j.BATCH_NO,j.LOCUS_NO,j.UNIT_ID,j.PROPERTY_01,j.PROPERTY_02,j.AMOUNT,j.CALC_AMOUNT,j.RTL_PRICE,j.COMM'+
               ',b.BARCODE,0 as IS_PRESENT,j.AMOUNT * j.RTL_PRICE as RTL_MONEY from SAL_BOMDATA j inner join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.BOM_ID=:BOM_ID order by SEQNO';
  IsSQLUpdate := True;
  Str :=  'insert into SAL_BOMDATA(TENANT_ID,SHOP_ID,BOM_ID,SEQNO,BATCH_NO,LOCUS_NO,GODS_ID,UNIT_ID,PROPERTY_01,PROPERTY_02,AMOUNT,CALC_AMOUNT,'+
            'RTL_PRICE,COMM,TIME_STAMP) '
        + 'VALUES(:TENANT_ID,:SHOP_ID,:BOM_ID,:SEQNO,:BATCH_NO,:LOCUS_NO,:GODS_ID,:UNIT_ID,:PROPERTY_01,:PROPERTY_02,:AMOUNT,:CALC_AMOUNT,:RTL_PRICE,''00'','+GetTimeStamp(iDbType)+') ';
  InsertSQL.Text := str;
  Str := 'update SAL_BOMDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,BOM_ID=:BOM_ID,SEQNO=:SEQNO,BATCH_NO=:BATCH_NO,LOCUS_NO=:LOCUS_NO,GODS_ID=:GODS_ID,UNIT_ID=:UNIT_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,'+
      'AMOUNT=:AMOUNT,CALC_AMOUNT=:CALC_AMOUNT,RTL_PRICE=:RTL_PRICE,COMM=' + GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + ' where TENANT_ID=:OLD_TENANT_ID and BOM_ID=:OLD_BOM_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from SAL_BOMDATA where TENANT_ID=:OLD_TENANT_ID and BOM_ID=:OLD_BOM_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TBomOrderGetPrior }

procedure TBomOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 BOM_ID from SAL_BOMORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO  order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select BOM_ID from SAL_BOMORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO  order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select BOM_ID from SAL_BOMORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO  order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select BOM_ID from SAL_BOMORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO  order by GLIDE_NO DESC limit 1';
  end;
end;

{ TBomOrderGetNext }

procedure TBomOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 BOM_ID from SAL_BOMORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO  order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select BOM_ID from SAL_BOMORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO  order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select BOM_ID from SAL_BOMORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO  order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select BOM_ID from SAL_BOMORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO  order by GLIDE_NO limit 1';
  end;

end;


{ TBomOrderAudit }

function TBomOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  Str:string;
  n:Integer;
  rs:TZQuery;
begin
  try
    Str := 'update SAL_BOMORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and BOM_ID='''+Params.FindParam('BOM_ID').asString+''' and CHK_DATE IS NULL';
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

{ TBomOrderUnAudit }

function TBomOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
  rs:TZQuery;
begin
  {rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select LOCUS_STATUS from SAL_SALESORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and SALES_ID='''+Params.FindParam('SALES_ID').asString+'''';
    AGlobal.Open(rs);
    if rs.Fields[0].AsString='3' then Raise Exception.Create('已经扫码出库完毕，不能弃审..');
  finally
    rs.Free;
  end;
  }
   try
    Str := 'update SAL_BOMORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and BOM_ID='''+Params.FindParam('BOM_ID').asString+''' and CHK_DATE IS NOT NULL';
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
  RegisterClass(TBomOrder);
  RegisterClass(TBomData);
  RegisterClass(TBomOrderGetPrior);
  RegisterClass(TBomOrderGetNext);
  RegisterClass(TBomOrderAudit);
  RegisterClass(TBomOrderUnAudit);

finalization
  UnRegisterClass(TBomOrder);
  UnRegisterClass(TBomData);
  UnRegisterClass(TBomOrderGetPrior);
  UnRegisterClass(TBomOrderGetNext);
  UnRegisterClass(TBomOrderAudit);
  UnRegisterClass(TBomOrderUnAudit);

end.
