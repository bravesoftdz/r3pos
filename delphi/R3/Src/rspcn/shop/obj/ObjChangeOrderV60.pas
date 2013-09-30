unit ObjChangeOrderV60;

interface

uses Dialogs,SysUtils,ZBase,Classes, ZDataSet,ZIntf,ObjCommon,DB,math,uFnUtil,
     ObjSyncFactoryV60;

type

  TChangeOrderV60=class(TZFactory)
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

  TChangeDataV60=class(TZFactory)
  public
    IsZeroOut:Boolean;
    lock:boolean;
    isSync:boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TSyncChangeOrderV60=class(TSyncSingleTableV60)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TSyncChangeDataV60=class(TSyncSingleTableV60)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation

{ TChangeDataV60 }

function TChangeDataV60.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
   w:integer;
   s:string;
begin
  Result := true;
  if isSync then Exit;
   //对整单库存进行检测
  if IsZeroOut then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
        'select jp2.*,p2.COLOR_NAME as COLOR_NAME from ('+
        'select jp1.*,p1.SIZE_NAME as SIZE_NAME from ('+
        'select b.GODS_CODE,b.GODS_NAME,j.TENANT_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.IS_PRESENT,j.LOCUS_NO,j.BOM_ID from ('+
        'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.BATCH_NO,B.IS_PRESENT,B.LOCUS_NO,B.BOM_ID from STO_STORAGE A,STO_CHANGEDATA B '+
        'where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 and A.BATCH_NO=B.BATCH_NO '+
        ' and A.AMOUNT<0 and B.CHANGE_ID=:CHANGE_ID and B.SHOP_ID=:SHOP_ID  and B.TENANT_ID=:TENANT_ID '+
        ') j left outer join VIW_GOODSINFO b on j.GODS_ID=b.GODS_ID and j.TENANT_ID=b.TENANT_ID '+
        ') jp1 left outer join VIW_SIZE_INFO p1 on jp1.TENANT_ID=p1.TENANT_ID and jp1.PROPERTY_01=p1.SIZE_ID '+
        ') jp2 left outer join VIW_COLOR_INFO p2 on jp2.TENANT_ID=p2.TENANT_ID and jp2.PROPERTY_02=p2.COLOR_ID ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.Params.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsString;
    rs.Params.ParamByName('CHANGE_ID').AsString := FieldbyName('CHANGE_ID').AsString;
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

function TChangeDataV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  try
  if FieldbyName('BATCH_NO').AsString='' then FieldbyName('BATCH_NO').AsString := '#';
  if FieldbyName('CHANGE_TYPE').AsOldString = '1' then
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asOldString,FieldbyName('SHOP_ID').asOldString,
             FieldbyName('GODS_ID').asOldString,
             FieldbyName('PROPERTY_01').asOldString,
             FieldbyName('PROPERTY_02').asOldString,
             FieldbyName('BATCH_NO').asOldString,
             FieldbyName('CALC_AMOUNT').asOldFloat,
             roundto(FieldbyName('CALC_AMOUNT').asOldFloat*FieldbyName('COST_PRICE').asOldFloat,-2),3)
  else
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asOldString,FieldbyName('SHOP_ID').asOldString,
             FieldbyName('GODS_ID').asOldString,
             FieldbyName('PROPERTY_01').asOldString,
             FieldbyName('PROPERTY_02').asOldString,
             FieldbyName('BATCH_NO').asOldString,
             FieldbyName('CALC_AMOUNT').asOldFloat,
             roundto(FieldbyName('CALC_AMOUNT').asOldFloat*FieldbyName('COST_PRICE').asOldFloat,-2),3);
//  if not lock then
//  begin
//  if Parant.FieldbyName('CHANGE_CODE').AsString='1' then
//     WriteLogInfo(AGlobal,Parant.FieldbyName('OPER_USER').AsString,2,'600027','删除【单号'+Parant.FieldbyName('GLIDE_NO').AsString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STO_CHANGEDATA',usDeleted))
//  else
//     WriteLogInfo(AGlobal,Parant.FieldbyName('OPER_USER').AsString,2,'600020','删除【单号'+Parant.FieldbyName('GLIDE_NO').AsString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STO_CHANGEDATA',usDeleted));
//  end;
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TChangeDataV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  try
  if FieldbyName('BATCH_NO').AsString='' then FieldbyName('BATCH_NO').AsString := '#';
  if FieldbyName('CHANGE_TYPE').AsString = '1' then
  IncStorage(AGlobal,FieldbyName('TENANT_ID').AsString,FieldbyName('SHOP_ID').AsString,
             FieldbyName('GODS_ID').AsString,
             FieldbyName('PROPERTY_01').AsString,
             FieldbyName('PROPERTY_02').AsString,
             FieldbyName('BATCH_NO').AsString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,-2),1)
  else
  DecStorage(AGlobal,FieldbyName('TENANT_ID').AsString,FieldbyName('SHOP_ID').AsString,
             FieldbyName('GODS_ID').AsString,
             FieldbyName('PROPERTY_01').AsString,
             FieldbyName('PROPERTY_02').AsString,
             FieldbyName('BATCH_NO').AsString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,-2),1);
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TChangeDataV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
//  if Parant.FieldbyName('CHANGE_CODE').AsString='1' then
//     WriteLogInfo(AGlobal,Parant.FieldbyName('OPER_USER').AsString,2,'600027','修改【单号'+Parant.FieldbyName('GLIDE_NO').AsString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STO_CHANGEDATA',usModified))
//  else
//     WriteLogInfo(AGlobal,Parant.FieldbyName('OPER_USER').AsString,2,'600020','修改【单号'+Parant.FieldbyName('GLIDE_NO').AsString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STO_CHANGEDATA',usModified));
end;

function TChangeDataV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
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
     IsZeroOut := (Temp.Fields[0].AsString = '') or (Temp.Fields[0].AsString = '1');
  finally
     Temp.free;
  end;

end;

procedure TChangeDataV60.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text := 'select g.*,h.CHANGE_TYPE as CHANGE_TYPE from ('+
               'select b.GODS_NAME,b.GODS_CODE,j.SHOP_ID,j.TENANT_ID,j.CHANGE_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.AMOUNT,j.APRICE,j.AMONEY,j.CALC_MONEY,j.COST_PRICE,j.IS_PRESENT,j.CALC_AMOUNT,'+
               'case when j.AMOUNT<>0 then round(j.COST_PRICE*j.CALC_AMOUNT,2)/j.AMOUNT else 0 end as COST_APRICE,'+
               'round(j.COST_PRICE*j.CALC_AMOUNT,2) as COST_MONEY,'+
               'j.REMARK from STO_CHANGEDATA j inner join ('+Params.ParambyName('VIW_GOODSINFO').AsString+') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.CHANGE_ID=:CHANGE_ID ) g '+
               'left outer join STO_CHANGEORDER h on g.TENANT_ID=h.TENANT_ID and g.CHANGE_ID=h.CHANGE_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into STO_CHANGEDATA(TENANT_ID,SHOP_ID,SEQNO,CHANGE_ID,GODS_ID,BATCH_NO,LOCUS_NO,BOM_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,AMOUNT,APRICE,AMONEY,CALC_MONEY,COST_PRICE,IS_PRESENT,CALC_AMOUNT,REMARK) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SEQNO,:CHANGE_ID,:GODS_ID,:BATCH_NO,:LOCUS_NO,:BOM_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:AMOUNT,:APRICE,:AMONEY,:CALC_MONEY,:COST_PRICE,:IS_PRESENT,:CALC_AMOUNT,:REMARK)';
  InsertSQL.Text := str;
  Str := 'update STO_CHANGEDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SEQNO=:SEQNO,CHANGE_ID=:CHANGE_ID,GODS_ID=:GODS_ID,BATCH_NO=:BATCH_NO,LOCUS_NO=:LOCUS_NO,BOM_ID=:BOM_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,'+
         'IS_PRESENT=:IS_PRESENT,CALC_AMOUNT=:CALC_AMOUNT,APRICE=:APRICE,AMONEY=:AMONEY,CALC_MONEY=:CALC_MONEY,COST_PRICE=:COST_PRICE,REMARK=:REMARK '
    + 'where TENANT_ID=:OLD_TENANT_ID and CHANGE_ID=:OLD_CHANGE_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from STO_CHANGEDATA where TENANT_ID=:OLD_TENANT_ID and CHANGE_ID=:OLD_CHANGE_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TChangeOrderV60 }

function TChangeOrderV60.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin
end;

function TChangeOrderV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
//  if not lock then
//  begin
//  if FieldbyName('CHANGE_CODE').AsString='1' then
//     WriteLogInfo(AGlobal,FieldbyName('OPER_USER').AsString,2,'600020','删除【单号'+FieldbyName('GLIDE_NO').AsString+'】',EncodeLogInfo(self,'STO_CHANGEORDER',usDeleted))
//  else
//     WriteLogInfo(AGlobal,FieldbyName('OPER_USER').AsString,2,'600027','删除【单号'+FieldbyName('GLIDE_NO').AsString+'】',EncodeLogInfo(self,'STO_CHANGEORDER',usDeleted));
//  end;
  result := true;
end;

function TChangeOrderV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (FieldbyName('GLIDE_NO').AsString='') then
    begin
      FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_3_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,FormatDatetime('YYMMDD',now()),5);
    end;
  result := true;
end;

function TChangeOrderV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。'); 
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
//  if FieldbyName('CHANGE_CODE').AsString='1' then
//     WriteLogInfo(AGlobal,FieldbyName('OPER_USER').AsString,2,'600020','修改【单号'+FieldbyName('GLIDE_NO').AsString+'】',EncodeLogInfo(self,'STO_CHANGEORDER',usModified))
//  else
//     WriteLogInfo(AGlobal,FieldbyName('OPER_USER').AsString,2,'600027','修改【单号'+FieldbyName('GLIDE_NO').AsString+'】',EncodeLogInfo(self,'STO_CHANGEORDER',usModified));

end;

function TChangeOrderV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
begin
   isSync := Params.FindParam('SyncFlag')<>nil;
   if isSync then
      begin
        AGlobal.ExecSQL('delete from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and (CREA_DATE>='+FieldbyName('CHANGE_DATE').AsOldString+' or CREA_DATE>='+FieldbyName('CHANGE_DATE').AsString+')',self);
        AGlobal.ExecSQL('delete from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and (END_DATE>='''+FormatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(FieldbyName('CHANGE_DATE').AsOldString))+''' or END_DATE>='''+FormatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(FieldbyName('CHANGE_DATE').AsString))+''')',self);
      end
   else
      begin
        Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsString,FieldbyName('SHOP_ID').AsString,FieldbyName('CHANGE_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
        if FieldbyName('CHANGE_DATE').AsOldString <> '' then
           Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('CHANGE_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
        result := true;
      end;

end;

function TChangeOrderV60.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  result := true;
  if isSync then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from STO_CHANGEORDER where CHANGE_ID='''+FieldbyName('CHANGE_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString;
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and
    (
       (copy(rs.Fields[1].AsString,1,1)='1')
       or
       (copy(rs.Fields[1].AsString,2,1)<>'0')
    )
    then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TChangeOrderV60.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select jf.*,f.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as DUTY_USER_TEXT from ('+
               ' select CHANGE_ID,TENANT_ID,SHOP_ID,GLIDE_NO,FIG_ID,CHANGE_DATE,DEPT_ID,CHANGE_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,CHANGE_CODE,DUTY_USER,REMARK,CHK_USER,CHK_DATE,FROM_ID,CREA_DATE,CHANGE_AMT,CHANGE_MNY,CREA_USER,COMM,'+
               ' TIME_STAMP,LOCUS_STATUS from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.DUTY_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID) je '+
               ' left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID) jf '+
               ' left outer join CA_DEPT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.DEPT_ID=f.DEPT_ID';
  IsSQLUpdate := True;
  Str := 'insert into STO_CHANGEORDER(CHANGE_ID,TENANT_ID,SHOP_ID,GLIDE_NO,CHANGE_DATE,CHANGE_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,CHANGE_CODE,DUTY_USER,REMARK,CHK_USER,CHK_DATE,FROM_ID,FIG_ID,CHANGE_AMT,CHANGE_MNY,CREA_DATE,CREA_USER,DEPT_ID,COMM,TIME_STAMP) '
    + 'VALUES(:CHANGE_ID,:TENANT_ID,:SHOP_ID,:GLIDE_NO,:CHANGE_DATE,:CHANGE_TYPE,:LINKMAN,:TELEPHONE,:SEND_ADDR,:CHANGE_CODE,:DUTY_USER,:REMARK,:CHK_USER,:CHK_DATE,:FROM_ID,:FIG_ID,:CHANGE_AMT,:CHANGE_MNY,:CREA_DATE,:CREA_USER,:DEPT_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update STO_CHANGEORDER set CHANGE_ID=:CHANGE_ID,TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,GLIDE_NO=:GLIDE_NO,CHANGE_DATE=:CHANGE_DATE,CHANGE_TYPE=:CHANGE_TYPE,LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,'+
      'SEND_ADDR=:SEND_ADDR,CHANGE_CODE=:CHANGE_CODE,DUTY_USER=:DUTY_USER,REMARK=:REMARK,FIG_ID=:FIG_ID,'+
      'CHK_USER=:CHK_USER,CHK_DATE=:CHK_DATE,FROM_ID=:FROM_ID,CHANGE_AMT=:CHANGE_AMT,CHANGE_MNY=:CHANGE_MNY,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,DEPT_ID=:DEPT_ID,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and CHANGE_ID=:OLD_CHANGE_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from STO_CHANGEORDER where TENANT_ID=:OLD_TENANT_ID and CHANGE_ID=:OLD_CHANGE_ID';
  DeleteSQL.Text := Str;
end;


{ TSyncChangeOrderV60 }

function TSyncChangeOrderV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select '+Params.ParamByName('TABLE_FIELDS').AsString+' from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID';
end;

function TSyncChangeOrderV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_CHANGEORDER';
     end;
  InitSQL(AGlobal,false);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger=0) then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
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

function TSyncChangeOrderV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update STO_CHANGEORDER set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID'),self);
end;

{ TSyncChangeDataV60 }

function TSyncChangeDataV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select '+Params.ParamByName('TABLE_FIELDS').AsString+',b.CHANGE_TYPE as CHANGE_TYPE from STO_CHANGEDATA a,STO_CHANGEORDER b where a.TENANT_ID=b.TENANT_ID and a.CHANGE_ID=b.CHANGE_ID and a.TENANT_ID=:TENANT_ID and a.CHANGE_ID=:CHANGE_ID';
end;

function TSyncChangeDataV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
  procedure InsertStorageInfo;
  begin
    if FieldbyName('BATCH_NO').AsString='' then FieldbyName('BATCH_NO').AsString := '#';
    if FieldbyName('CHANGE_TYPE').AsString = '1' then
    IncStorage(AGlobal,FieldbyName('TENANT_ID').AsString,FieldbyName('SHOP_ID').AsString,
               FieldbyName('GODS_ID').AsString,
               FieldbyName('PROPERTY_01').AsString,
               FieldbyName('PROPERTY_02').AsString,
               FieldbyName('BATCH_NO').AsString,
               FieldbyName('CALC_AMOUNT').asFloat,
               roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,-2),1)
    else
    DecStorage(AGlobal,FieldbyName('TENANT_ID').AsString,FieldbyName('SHOP_ID').AsString,
               FieldbyName('GODS_ID').AsString,
               FieldbyName('PROPERTY_01').AsString,
               FieldbyName('PROPERTY_02').AsString,
               FieldbyName('BATCH_NO').AsString,
               FieldbyName('CALC_AMOUNT').asFloat,
               roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,-2),1);
  end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_CHANGEDATA';
       MaxCol := RowAccessor.ColumnCount-1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  if (Params.FindParam('UPDATE_STORAGE')=nil) or Params.ParamByName('UPDATE_STORAGE').AsBoolean then
     InsertStorageInfo;
end;

function TSyncChangeDataV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    if (Params.FindParam('UPDATE_STORAGE')=nil) or Params.ParamByName('UPDATE_STORAGE').AsBoolean then
    begin
      rs.SQL.Text :=
         'select a.TENANT_ID,a.SHOP_ID,a.GODS_ID,a.PROPERTY_01,a.PROPERTY_02,a.BATCH_NO,a.CALC_AMOUNT,a.COST_PRICE,b.CHANGE_TYPE as CHANGE_TYPE from STO_CHANGEDATA a,STO_CHANGEORDER b where a.TENANT_ID=b.TENANT_ID and a.CHANGE_ID=b.CHANGE_ID '+
         'and a.TENANT_ID=:TENANT_ID and a.CHANGE_ID=:CHANGE_ID';
      rs.Params.AssignValues(Params); 
      AGlobal.Open(rs);
      rs.First;
      while not rs.Eof do
        begin
          if FieldbyName('CHANGE_TYPE').AsString = '1' then
          DecStorage(AGlobal,rs.FieldbyName('TENANT_ID').AsString,rs.FieldbyName('SHOP_ID').AsString,
                     rs.FieldbyName('GODS_ID').AsString,
                     rs.FieldbyName('PROPERTY_01').AsString,
                     rs.FieldbyName('PROPERTY_02').AsString,
                     rs.FieldbyName('BATCH_NO').AsString,
                     rs.FieldbyName('CALC_AMOUNT').asFloat,
                     roundto(rs.FieldbyName('CALC_AMOUNT').asFloat*rs.FieldbyName('COST_PRICE').asFloat,-2),3)
          else
          IncStorage(AGlobal,rs.FieldbyName('TENANT_ID').AsString,rs.FieldbyName('SHOP_ID').AsString,
                     rs.FieldbyName('GODS_ID').AsString,
                     rs.FieldbyName('PROPERTY_01').AsString,
                     rs.FieldbyName('PROPERTY_02').AsString,
                     rs.FieldbyName('BATCH_NO').AsString,
                     rs.FieldbyName('CALC_AMOUNT').AsFloat,
                     roundto(rs.FieldbyName('CALC_AMOUNT').asFloat*rs.FieldbyName('COST_PRICE').asFloat,-2),3);
          rs.Next;
        end;
    end;
    AGlobal.ExecSQL('delete from STO_CHANGEDATA where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID',Params);
  finally
    rs.Free;
  end;
end;

initialization
  RegisterClass(TChangeOrderV60);
  RegisterClass(TChangeDataV60);
  RegisterClass(TSyncChangeOrderV60);
  RegisterClass(TSyncChangeDataV60);
finalization
  UnRegisterClass(TChangeOrderV60);
  UnRegisterClass(TChangeDataV60);
  UnRegisterClass(TSyncChangeOrderV60);
  UnRegisterClass(TSyncChangeDataV60);
end.
