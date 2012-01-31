unit ObjChangeOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes, ZDataSet,ZIntf,ObjCommon,DB,math;
type
  TChangeOrder=class(TZFactory)
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
  TChangeData=class(TZFactory)
  public
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
    procedure InitClass; override;
  end;
  TChangeOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TChangeOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TChangeOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TChangeOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TChangeLocusNoAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TChangeLocusNoUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TChangeForLocusNoHeader=class(TZFactory)
  private
  public
    procedure InitClass;override;
  end;
  TChangeForLocusNo=class(TZFactory)
  private
  public
    procedure InitClass;override;
  end;
implementation

{ TChangeData }

function TChangeData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
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
end;

function TChangeData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
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
//     WriteLogInfo(AGlobal,Parant.FieldbyName('OPER_USER').AsString,2,'600027','删除【单号'+Parant.FieldbyName('GLIDE_NO').asString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STO_CHANGEDATA',usDeleted))
//  else
//     WriteLogInfo(AGlobal,Parant.FieldbyName('OPER_USER').AsString,2,'600020','删除【单号'+Parant.FieldbyName('GLIDE_NO').asString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STO_CHANGEDATA',usDeleted));
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

function TChangeData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
//  FieldbyName('COST_PRICE').AsFloat := GetCostPrice(AGlobal,FieldbyName('COMP_ID').AsString,'#',FieldbyName('GODS_ID').AsString,FieldbyName('PROPERTY_01').AsString,FieldbyName('PROPERTY_02').AsString,FieldbyName('BATCH_NO').AsString,FieldbyName('IS_PRESENT').asString);
  if FieldbyName('CHANGE_TYPE').AsString = '1' then
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,-2),1)
  else
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
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

function TChangeData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
//  if Parant.FieldbyName('CHANGE_CODE').AsString='1' then
//     WriteLogInfo(AGlobal,Parant.FieldbyName('OPER_USER').AsString,2,'600027','修改【单号'+Parant.FieldbyName('GLIDE_NO').asString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STO_CHANGEDATA',usModified))
//  else
//     WriteLogInfo(AGlobal,Parant.FieldbyName('OPER_USER').AsString,2,'600020','修改【单号'+Parant.FieldbyName('GLIDE_NO').asString+'】的“'+FieldbyName('GODS_NAME').asOldString+'”',EncodeLogInfo(self,'STO_CHANGEDATA',usModified));
end;

function TChangeData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var Temp:TZQuery;
begin
  Result := true;
  Temp := TZQuery.Create(nil);
  try
     Temp.close;
     Temp.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and DEFINE=''ZERO_OUT''';
     AGlobal.Open(Temp);
     IsZeroOut := (Temp.Fields[0].AsString = '1');
  finally
     Temp.free;
  end;
  case AGlobal.iDbType of
  0:AGlobal.ExecSQL('select count(*) from STO_STORAGE with(UPDLOCK) where TENANT_ID=:TENANT_ID',self);
  end;

end;

procedure TChangeData.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text := 'select g.*,h.CHANGE_TYPE as CHANGE_TYPE from ('+
               'select b.GODS_NAME,b.GODS_CODE,j.SHOP_ID,j.TENANT_ID,j.CHANGE_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.AMOUNT,j.APRICE,j.AMONEY,j.CALC_MONEY,j.COST_PRICE,j.IS_PRESENT,j.CALC_AMOUNT,'+
               'case when j.AMOUNT<>0 then round(j.COST_PRICE*j.CALC_AMOUNT,2)/j.AMOUNT else 0 end as COST_APRICE,'+
               'round(j.COST_PRICE*j.CALC_AMOUNT,2) as COST_MONEY,'+
               'j.REMARK from STO_CHANGEDATA j inner join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.CHANGE_ID=:CHANGE_ID ) g '+
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

{ TChangeOrder }

function TChangeOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
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
        '      STO_CHANGEORDER a,'+
        '      STO_CHANGEDATA b '+
        '    WHERE '+
        '      a.TENANT_ID = b.TENANT_ID AND a.CHANGE_ID = b.CHANGE_ID AND a.TENANT_ID = MKT_DEMANDDATA.TENANT_ID AND a.FROM_ID = MKT_DEMANDDATA.DEMA_ID '+
        '      AND b.GODS_ID = MKT_DEMANDDATA.GODS_ID AND b.BATCH_NO = MKT_DEMANDDATA.BATCH_NO '+
        '      AND b.UNIT_ID = MKT_DEMANDDATA.UNIT_ID AND b.PROPERTY_01 = MKT_DEMANDDATA.PROPERTY_01 AND b.PROPERTY_02 = MKT_DEMANDDATA.PROPERTY_02 AND b.IS_PRESENT = MKT_DEMANDDATA.IS_PRESENT  '+
        '  ) '+
        'WHERE DEMA_ID = :FIG_ID AND TENANT_ID = :TENANT_ID';
         AGlobal.ExecSQL(SQL,self);
     end;
end;

function TChangeOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
//  if not lock then
//  begin
//  if FieldbyName('CHANGE_CODE').AsString='1' then
//     WriteLogInfo(AGlobal,FieldbyName('OPER_USER').AsString,2,'600020','删除【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'STO_CHANGEORDER',usDeleted))
//  else
//     WriteLogInfo(AGlobal,FieldbyName('OPER_USER').AsString,2,'600027','删除【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'STO_CHANGEORDER',usDeleted));
//  end;
  result := true;
end;

function TChangeOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
     begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_3_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     end;
  result := true;
end;

function TChangeOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
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
//     WriteLogInfo(AGlobal,FieldbyName('OPER_USER').AsString,2,'600020','修改【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'STO_CHANGEORDER',usModified))
//  else
//     WriteLogInfo(AGlobal,FieldbyName('OPER_USER').AsString,2,'600027','修改【单号'+FieldbyName('GLIDE_NO').asString+'】',EncodeLogInfo(self,'STO_CHANGEORDER',usModified));

end;

function TChangeOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
        Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,FieldbyName('CHANGE_DATE').AsString,FieldbyName('TIME_STAMP').AsString);
        if FieldbyName('CHANGE_DATE').AsOldString <> '' then
           Result := GetReckOning(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('CHANGE_DATE').AsOldString,FieldbyName('TIME_STAMP').AsOldString);
        result := true;
      end
   else
      Result := true;
      
end;

function TChangeOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from STO_CHANGEORDER where CHANGE_ID='''+FieldbyName('CHANGE_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString;
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

procedure TChangeOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select jg.*,g.GLIDE_NO as DEMA_GLIDE_NO from ('+  
               'select jf.*,f.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as DUTY_USER_TEXT from ('+
               ' select CHANGE_ID,TENANT_ID,SHOP_ID,GLIDE_NO,FIG_ID,CHANGE_DATE,DEPT_ID,CHANGE_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,CHANGE_CODE,DUTY_USER,REMARK,CHK_USER,CHK_DATE,FROM_ID,CREA_DATE,CHANGE_AMT,CHANGE_MNY,CREA_USER,COMM,'+
               ' TIME_STAMP,LOCUS_STATUS from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.DUTY_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID) je '+
               ' left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID) jf '+
               ' left outer join CA_DEPT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.DEPT_ID=f.DEPT_ID) jg '+
               ' left outer join MKT_DEMANDORDER g on g.TENANT_ID=jg.TENANT_ID and jg.FIG_ID=g.DEMA_ID ';
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

{ TChangeOrderGetPrior }

procedure TChangeOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 CHANGE_ID from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and CHANGE_CODE=:CHANGE_CODE order by GLIDE_NO desc';
  1:SelectSQL.Text := 'select * from (select CHANGE_ID from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and CHANGE_CODE=:CHANGE_CODE order by GLIDE_NO desc) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select CHANGE_ID from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and CHANGE_CODE=:CHANGE_CODE order by GLIDE_NO desc) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select CHANGE_ID from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and CHANGE_CODE=:CHANGE_CODE order by GLIDE_NO desc limit 1';
  end;
  
end;

{ TChangeOrderGetNext }

procedure TChangeOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 CHANGE_ID from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and CHANGE_CODE=:CHANGE_CODE order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select CHANGE_ID from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and CHANGE_CODE=:CHANGE_CODE order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select CHANGE_ID from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and CHANGE_CODE=:CHANGE_CODE order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select CHANGE_ID from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and CHANGE_CODE=:CHANGE_CODE order by GLIDE_NO limit 1';
  end;
end;

{ TChangeOrderAudit }

function TChangeOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
  rs:TZQuery;
begin
{  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select count(*) from STO_CHANGEDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
      'A.TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and A.CHANGE_ID='''+Params.FindParam('CHANGE_ID').asString+''' and B.USING_LOCUS_NO=1 and '+
      'not Exists(select * from STO_LOCUS_FORCHAG where TENANT_ID=A.TENANT_ID and GODS_ID=A.GODS_ID and CHANGE_ID=A.CHANGE_ID)';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger>0 then Raise Exception.Create('没有扫码出库完毕，不能审核..');
  finally
    rs.Free;
  end;  }
  try
    Str := 'update STO_CHANGEORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and CHANGE_ID='''+Params.FindParam('CHANGE_ID').asString+''' and CHK_DATE IS NULL';
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

{ TChangeOrderUnAudit }

function TChangeOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select LOCUS_STATUS from STO_CHANGEORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and CHANGE_ID='''+Params.FindParam('CHANGE_ID').asString+'''';
    AGlobal.Open(rs);
    if rs.Fields[0].AsString='3' then Raise Exception.Create('已经扫码出库完毕，不能弃核..');
  finally
    rs.Free;
  end;
   try
    Str := 'update STO_CHANGEORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and CHANGE_ID='''+Params.FindParam('CHANGE_ID').asString+''' and CHK_DATE IS NOT NULL';
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

{ TChangeForLocusNo }

procedure TChangeForLocusNo.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
               'select TENANT_ID,SHOP_ID,CHANGE_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_DATE,LOCUS_NO,UNIT_ID,AMOUNT,CALC_AMOUNT,CREA_DATE,CREA_USER,COMM,TIME_STAMP '+
               'from STO_LOCUS_FORCHAG j where j.TENANT_ID=:TENANT_ID and j.CHANGE_ID=:CHANGE_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into STO_LOCUS_FORCHAG(TENANT_ID,SHOP_ID,CHANGE_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,LOCUS_DATE,LOCUS_NO,UNIT_ID,AMOUNT,CALC_AMOUNT,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:CHANGE_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:LOCUS_DATE,:LOCUS_NO,:UNIT_ID,:AMOUNT,:CALC_AMOUNT,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := str;
  Str := 'update STO_LOCUS_FORCHAG set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,CHANGE_ID=:CHANGE_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,'+
      'LOCUS_DATE=:LOCUS_DATE,LOCUS_NO=:LOCUS_NO,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,CALC_AMOUNT=:CALC_AMOUNT,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER, '
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and CHANGE_ID=:OLD_CHANGE_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from STO_LOCUS_FORCHAG where TENANT_ID=:OLD_TENANT_ID and CHANGE_ID=:OLD_CHANGE_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TChangeForLocusNoHeader }

procedure TChangeForLocusNoHeader.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
               'select jf.*,f.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select je.*,e.USER_NAME as CREA_USER_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as DUTY_USER_TEXT from ('+
               ' select CHANGE_ID,TENANT_ID,SHOP_ID,GLIDE_NO,CHANGE_DATE,DEPT_ID,CHANGE_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,CHANGE_CODE,DUTY_USER,REMARK,CHK_USER,CHK_DATE,FROM_ID,CREA_DATE,CHANGE_AMT,CHANGE_MNY,CREA_USER,COMM,'+
               ' TIME_STAMP,LOCUS_STATUS,LOCUS_USER,LOCUS_DATE,LOCUS_AMT,LOCUS_CHK_DATE,LOCUS_CHK_USER from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.DUTY_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID) je '+
               ' left outer join VIW_USERS e on je.TENANT_ID=e.TENANT_ID and je.CREA_USER=e.USER_ID) jf '+
               ' left outer join CA_DEPT_INFO f on jf.TENANT_ID=f.TENANT_ID and jf.DEPT_ID=f.DEPT_ID';
  Str :=
      'update STO_CHANGEORDER set LOCUS_STATUS=:LOCUS_STATUS,LOCUS_USER=:LOCUS_USER,LOCUS_DATE=:LOCUS_DATE,LOCUS_AMT=:LOCUS_AMT,LOCUS_CHK_DATE=:LOCUS_CHK_DATE,LOCUS_CHK_USER=:LOCUS_CHK_USER,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and CHANGE_ID=:OLD_CHANGE_ID';
  UpdateSQL.Text := Str;
end;

{ TChangeLocusNoAudit }

function TChangeLocusNoAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
    Temp:TZQuery;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select LOCUS_STATUS from STO_CHANGEORDER where TENANT_ID='+Params.FindParam('TENANT_ID').asString+' and CHANGE_ID='''+Params.FindParam('CHANGE_ID').asString+'''';
    AGlobal.Open(rs);
    if rs.Fields[0].AsString<>'3' then Raise Exception.Create('没有发货完毕，不能审核..');
  finally
    rs.Free;
  end;
  try
    Str := 'update STO_CHANGEORDER set LOCUS_CHK_DATE='''+Params.FindParam('LOCUS_CHK_DATE').asString+''',LOCUS_CHK_USER='''+Params.FindParam('LOCUS_CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and CHANGE_ID='''+Params.FindParam('CHANGE_ID').asString+''' and LOCUS_CHK_DATE IS NULL';
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

{ TChangeLocusNoUnAudit }

function TChangeLocusNoUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
  rs:TZQuery;
begin
   try
    Str := 'update STO_CHANGEORDER set LOCUS_CHK_DATE=null,LOCUS_CHK_USER=null,LOCUS_STATUS=''1'',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and CHANGE_ID='''+Params.FindParam('CHANGE_ID').asString+''' and LOCUS_CHK_DATE IS NOT NULL';
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
  RegisterClass(TChangeOrder);
  RegisterClass(TChangeData);
  RegisterClass(TChangeOrderGetPrior);
  RegisterClass(TChangeOrderGetNext);
  RegisterClass(TChangeOrderAudit);
  RegisterClass(TChangeOrderUnAudit);
  RegisterClass(TChangeForLocusNo);
  RegisterClass(TChangeForLocusNoHeader);
  RegisterClass(TChangeLocusNoAudit);
  RegisterClass(TChangeLocusNoUnAudit);
finalization
  UnRegisterClass(TChangeOrder);
  UnRegisterClass(TChangeData);
  UnRegisterClass(TChangeOrderGetPrior);
  UnRegisterClass(TChangeOrderGetNext);
  UnRegisterClass(TChangeOrderAudit);
  UnRegisterClass(TChangeOrderUnAudit);
  UnRegisterClass(TChangeForLocusNo);
  UnRegisterClass(TChangeForLocusNoHeader);
  UnRegisterClass(TChangeLocusNoAudit);
  UnRegisterClass(TChangeLocusNoUnAudit);
end.
