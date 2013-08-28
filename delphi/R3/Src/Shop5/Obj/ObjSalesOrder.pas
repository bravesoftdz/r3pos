unit ObjSalesOrder;

interface
uses Dialogs,SysUtils,zBase,Classes,zintf,ObjCommon,DB,ZDataSet,math;
type
  TSalesOrder=class(TZFactory)
  private
    lock:boolean;
  public
    procedure DoUpgrade(AGlobal:IdbHelp);
    procedure DoEnd(AGlobal:IdbHelp);
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TSalesData=class(TZFactory)
  private
    IsZeroOut:Boolean;
    lock:boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TSalesICData=class(TZFactory)
  private
    lock:boolean;
  public
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TSalesForLocusNoHeader=class(TZFactory)
  private
  public
    procedure InitClass;override;
  end;
  TSalesForLocusNo=class(TZFactory)
  private
  public
    procedure InitClass;override;
  end;
  TSalesOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TSalesOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TSalesOrderAudit=class(TZProcFactory)
  public
    function CheckZero(AGlobal:IdbHelp;Params:TftParamList):Boolean;
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSalesOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSalesLocusNoAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TSalesLocusNoUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation
uses uFnUtil, DateUtils;
{ TStockData }

function TSalesData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
   w:integer;
   s:string;
begin
   Result := true;
   //�����������м��
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
                 s := s + '(��Ʒ)';
              if rs.FieldbyName('BOM_ID').AsString <> '' then
                 s := s+ '(���)';
              if rs.FieldbyName('SIZE_NAME').AsString <> '' then
                 s := s+ '  ����:'+rs.FieldbyName('SIZE_NAME').AsString+'';
              if rs.FieldbyName('COLOR_NAME').AsString <> '' then
                 s := s+ '  ��ɫ:'+rs.FieldbyName('COLOR_NAME').AsString+'';
              if rs.FieldbyName('BATCH_NO').AsString <> '#' then
                 s := s+ '  ����:'+rs.FieldbyName('COLOR_NAME').AsString+'';
              if rs.FieldbyName('LOCUS_NO').AsString <> '' then
                 s := s+ '  ���ٺ�:'+rs.FieldbyName('LOCUS_NO').AsString+'';
              if w>5 then break;
              rs.Next;
            end;
          if s<>'' then
            Raise Exception.Create(s+#10+'--��Ʒ��治��,��˶��Ƿ�������ȷ��'); 
        finally
          rs.Free;
        end;
      end;
end;

function TSalesData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
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
//     WriteLogInfo(AGlobal,Parant.FieldbyName('CREA_USER').AsString,2,'500026','ɾ��������'+Parant.FieldbyName('GLIDE_NO').asString+'���ġ�'+FieldbyName('GODS_NAME').asOldString+'��',EncodeLogInfo(self,'SAL_SALESDATA',usDeleted));
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TSalesData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
//���ɿ���ǰ̨����½���
//  FieldbyName('COST_PRICE').AsFloat := GetCostPrice(AGlobal,FieldbyName('TENANT_ID').AsString,FieldbyName('SHOP_ID').AsString,FieldbyName('GODS_ID').AsString,FieldbyName('PROPERTY_01').AsString,FieldbyName('PROPERTY_02').AsString,FieldbyName('BATCH_NO').AsString);
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('COST_PRICE').asFloat*FieldbyName('CALC_AMOUNT').asFloat,-2),2);

  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TSalesData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
//  WriteLogInfo(AGlobal,Parant.FieldbyName('CREA_USER').AsString,2,'500026','�޸ġ�����'+Parant.FieldbyName('GLIDE_NO').asString+'���ġ�'+FieldbyName('GODS_NAME').asOldString+'��',EncodeLogInfo(self,'SAL_SALESDATA',usModified));
end;

function TSalesData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
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
  1:AGlobal.ExecSQL('select count(*) from STO_STORAGE  where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID for update',self);
  4:AGlobal.ExecSQL('select count(*) from STO_STORAGE  where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID WITH RS USE AND KEEP UPDATE LOCKS',self);
  end;
end;

procedure TSalesData.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select b.GODS_NAME,b.GODS_CODE,j.TENANT_ID,j.SHOP_ID,j.SALES_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.LOCUS_NO,j.BOM_ID,j.UNIT_ID,j.AMOUNT,j.ORG_PRICE,j.POLICY_TYPE,'+
               'j.IS_PRESENT,j.BARTER_INTEGRAL,j.COST_PRICE,j.APRICE,j.AMONEY,j.AGIO_RATE,j.AGIO_MONEY,j.CALC_AMOUNT,j.CALC_MONEY,'+
               'j.HAS_INTEGRAL,j.REMARK,j.TREND_ID,j.LOCATION_ID,b.BARCODE from SAL_SALESDATA j inner join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where j.TENANT_ID=:TENANT_ID and j.SALES_ID=:SALES_ID order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into SAL_SALESDATA(TENANT_ID,SHOP_ID,SALES_ID,SEQNO,GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,BOM_ID,UNIT_ID,AMOUNT,ORG_PRICE,'+
      'POLICY_TYPE,IS_PRESENT,APRICE,AMONEY,AGIO_RATE,AGIO_MONEY,CALC_AMOUNT,CALC_MONEY,BARTER_INTEGRAL,HAS_INTEGRAL,REMARK,TREND_ID,COST_PRICE,LOCATION_ID) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:SALES_ID,:SEQNO,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:BATCH_NO,:BOM_ID,:UNIT_ID,:AMOUNT,:ORG_PRICE,'+
      ':POLICY_TYPE,:IS_PRESENT,:APRICE,:AMONEY,:AGIO_RATE,:AGIO_MONEY,:CALC_AMOUNT,:CALC_MONEY,:BARTER_INTEGRAL,:HAS_INTEGRAL,:REMARK,:TREND_ID,:COST_PRICE,:LOCATION_ID)';
  InsertSQL.Text := str;
  Str := 'update SAL_SALESDATA set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,SALES_ID=:SALES_ID,SEQNO=:SEQNO,GODS_ID=:GODS_ID,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BATCH_NO=:BATCH_NO,BOM_ID=:BOM_ID,UNIT_ID=:UNIT_ID,'+
      'AMOUNT=:AMOUNT,ORG_PRICE=:ORG_PRICE,COST_PRICE=:COST_PRICE,POLICY_TYPE=:POLICY_TYPE,IS_PRESENT=:IS_PRESENT,APRICE=:APRICE,AMONEY=:AMONEY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY,CALC_AMOUNT=:CALC_AMOUNT,'+
      'CALC_MONEY=:CALC_MONEY,BARTER_INTEGRAL=:BARTER_INTEGRAL,HAS_INTEGRAL=:HAS_INTEGRAL,REMARK=:REMARK,TREND_ID=:TREND_ID,LOCATION_ID=:LOCATION_ID '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Text := str;
  Str := 'delete from SAL_SALESDATA where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Text := str;
end;

{ TSalesOrder }

function TSalesOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  t:integer;
  amt:integer;
  SQL:string;
begin
  if (FieldbyName('CLIENT_ID').AsString<>'') or (FieldbyName('CLIENT_ID').AsOldString<>'') then DoUpgrade(AGlobal);
  if FieldbyName('FROM_ID').AsString <> '' then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text :=
           'select count(*) from '+
           '(select GODS_ID,IS_PRESENT,PROPERTY_01,PROPERTY_02,sum(CALC_AMOUNT) as AMOUNT from SAL_INDENTDATA where TENANT_ID=:TENANT_ID and INDE_ID=:FROM_ID group by GODS_ID,IS_PRESENT,PROPERTY_01,PROPERTY_02) A '+
           'left outer join (select GODS_ID,IS_PRESENT,PROPERTY_01,PROPERTY_02,sum(CALC_AMOUNT) as AMOUNT from SAL_SALESDATA s1,SAL_SALESORDER s2 where s1.TENANT_ID=s2.TENANT_ID and s1.SALES_ID=s2.SALES_ID and '+
           's2.TENANT_ID=:TENANT_ID and s2.FROM_ID=:FROM_ID group by GODS_ID,IS_PRESENT,PROPERTY_01,PROPERTY_02) B '+
           'on A.GODS_ID=B.GODS_ID and A.IS_PRESENT=B.IS_PRESENT and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 where A.AMOUNT>B.AMOUNT or B.AMOUNT is null';
         rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
         rs.ParamByName('FROM_ID').AsString := FieldbyName('FROM_ID').AsString;
         AGlobal.Open(rs);
         if rs.Fields[0].AsInteger =0 then
            begin
              AGlobal.ExecSQL('update SAL_INDENTORDER set SALBILL_STATUS=2,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID=:TENANT_ID and INDE_ID=:FROM_ID',self);
              DoEnd(AGlobal);
            end
         else
            AGlobal.ExecSQL('update SAL_INDENTORDER set SALBILL_STATUS=1,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID=:TENANT_ID and INDE_ID=:FROM_ID',self);
       finally
         rs.Free;
       end;
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
        '      a.TENANT_ID = b.TENANT_ID AND a.SALES_ID = b.SALES_ID AND a.TENANT_ID = SAL_INDENTDATA.TENANT_ID AND a.FROM_ID = SAL_INDENTDATA.INDE_ID '+
        '      AND b.GODS_ID = SAL_INDENTDATA.GODS_ID AND b.PROPERTY_01 = SAL_INDENTDATA.PROPERTY_01 AND b.PROPERTY_02 = SAL_INDENTDATA.PROPERTY_02 AND b.IS_PRESENT = SAL_INDENTDATA.IS_PRESENT  '+
        '  ) '+
        'WHERE INDE_ID = :FROM_ID AND TENANT_ID = :TENANT_ID';
       AGlobal.ExecSQL(SQL,self);

     end;

end;

function TSalesOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  if not Lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,True) then Raise Exception.Create('��ǰ�����Ѿ�����һ�û��޸ģ��㲻���ٱ��档');
  //��ԭ����
  if length(FieldbyName('CLIENT_ID').AsOldString)>0 then
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

  if FieldbyName('SALE_MNY').AsOldFloat <> 0 then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select RECV_MNY from ACC_RECVABLE_INFO where TENANT_ID='+FieldbyName('TENANT_ID').AsOldString+' and SALES_ID='''+FieldbyName('SALES_ID').AsOldString+''' and RECV_TYPE=''1''';
         AGlobal.Open(rs);
         if (rs.Fields[0].AsFloat <>0) then Raise Exception.Create('�Ѿ��տ�����۵������޸�...');
       finally
         rs.Free;
       end;
       AGlobal.ExecSQL('delete from ACC_RECVABLE_INFO where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID and RECV_TYPE=''1''',self);
     end;
//  if not lock then
//     WriteLogInfo(AGlobal,FieldbyName('CREA_USER').AsString,2,'500026','ɾ��������'+FieldbyName('GLIDE_NO').asString+'��',EncodeLogInfo(self,'SAL_SALESORDER',usDeleted));
  result := true;
end;

function TSalesOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
function GetAdvaMny:currency;
var
  rs:TZQuery;
begin
  result := 0;
  if FieldbyName('FROM_ID').AsString='' then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select sum(ADVA_MNY) from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_ID=:FROM_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('FROM_ID').AsString := FieldbyName('FROM_ID').AsString;
    AGlobal.Open(rs);
    result := rs.Fields[0].AsFloat;
    rs.Close;
    rs.SQL.Text := 'select sum(ADVA_MNY) from SAL_SALESORDER where TENANT_ID=:TENANT_ID and FROM_ID=:FROM_ID and SALES_ID<>:SALES_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('FROM_ID').AsString := FieldbyName('FROM_ID').AsString;
    rs.ParamByName('SALES_ID').AsString := FieldbyName('SALES_ID').AsString;
    AGlobal.Open(rs);
    result := result - rs.Fields[0].AsFloat;
    if result >= FieldbyName('PAY_D').AsFloat then
       result := FieldbyName('PAY_D').AsFloat;
  finally
    rs.Free;
  end;
end;
var
  rs:TZQuery;
  r:integer;
  salesDate,nearBuyDate,frequency,diff: integer;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
  begin
     if (FieldbyName('GLIDE_NO').AsString='') or (Pos('����',FieldbyName('GLIDE_NO').AsString)>0) then
        FieldbyName('GLIDE_NO').AsString := trimright(FieldbyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_1_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
     if (FieldbyName('PAY_D').AsFloat <> 0) then
     begin
       FieldbyName('ADVA_MNY').AsFloat := GetAdvaMny;
//       if roundto(FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat,-3)<>0 then
       begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text :=
           'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,DEPT_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
         + 'VALUES(:ABLE_ID,:TENANT_ID,:SHOP_ID,:DEPT_ID,:CLIENT_ID,'''+'���ۻ����������'+FieldbyName('GLIDE_NO').AsString+'��'+''',''1'',:PAY_D,0,:ADVA_MNY,:RECK_MNY,:SALES_DATE,:SALES_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
         CopyToParams(rs.Params);
         rs.ParambyName('ABLE_ID').AsString := newid(FieldbyName('SHOP_ID').asString);
         rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
         AGlobal.ExecQuery(rs);
       finally
         rs.Free;
       end;
       end;
     end;
  end;
  //���»����Լ����¹�������
  if length(FieldbyName('CLIENT_ID').AsString)>0 then
  begin
     if FieldbyName('BARTER_INTEGRAL').AsInteger<>0 then //�ۼ���������
     begin
     r := AGlobal.ExecSQL(
        ParseSQL(idbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :BARTER_INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) + :BARTER_INTEGRAL '+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID and INTEGRAL>=:BARTER_INTEGRAL')
     ,self);

     if r=0 then Raise Exception.Create('��ǰ���û��ֲ��㣬������ɻ��ֶһ�');
     end;
     if FieldbyName('INTEGRAL').AsInteger<>0 then
     AGlobal.ExecSQL(
        ParseSQL(idbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)+ :INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) + :INTEGRAL'+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID')
     ,self);

     //����������������Լ�����Ƶ��
     rs := TZQuery.Create(nil);
     salesDate := FieldbyName('SALES_DATE').AsInteger;
     try
        rs.SQL.Text := 'select NEAR_BUY_DATE,FREQUENCY from PUB_IC_INFO where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID ';
        rs.ParambyName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
        rs.ParambyName('CLIENT_ID').AsString := FieldbyName('CLIENT_ID').AsString;
        AGlobal.Open(rs);
        if not rs.IsEmpty then
          begin
            nearBuyDate := rs.FieldByName('NEAR_BUY_DATE').AsInteger;
            frequency := rs.FieldByName('FREQUENCY').AsInteger;
            if salesDate >= nearBuyDate then
              begin
                if (nearBuyDate <= 0) and (frequency <= 0) then
                  frequency := 0
                else
                  begin
                    diff := DaysBetween(FnTime.fnStrtoDate(inttostr(nearBuyDate)), FnTime.fnStrtoDate(inttostr(salesDate)));
                    if frequency <= 0 then
                      frequency := 1;
                    frequency := ceil((frequency + diff) / 2.0);
                  end;
                //����������������Լ�Ƶ��
                AGlobal.ExecSQL('update PUB_IC_INFO set NEAR_BUY_DATE = ' + inttostr(salesDate) +
                                                       ',FREQUENCY = ' + inttostr(frequency) +
                                 ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID', self);
              end;
          end;
     finally
        rs.Free
     end;
  end;
  result := true;
end;

function TSalesOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('��ǰ�����Ѿ�����һ�û��޸ģ��㲻���ٱ��档');
  lock := true;
  try
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  finally
    lock := false;
  end;
//  WriteLogInfo(AGlobal,FieldbyName('CREA_USER').AsString,2,'500026','�޸ġ�����'+FieldbyName('GLIDE_NO').asString+'��',EncodeLogInfo(self,'SAL_SALESORDER',usModified));
end;

function TSalesOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
   rs:TZQuery;
   cDate:string;
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
     if not rs.IsEmpty then Raise Exception.Create('��ǰ����Ա['+FieldbyName('SALES_DATE').AsString+']���Ѿ����˲����ٿ�����'+#13+'ȡ�������뵽[�������]->[���˹���]�г���.');
   finally
     rs.Free;
   end;
   result := true;
end;

function TSalesOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
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
    then Raise Exception.Create('�Ѿ�ͬ�������ݲ���ɾ��..');
  finally
    rs.Free;
  end;
end;

procedure TSalesOrder.DoEnd(AGlobal: IdbHelp);
var
  rs:TZQuery;
  r:Currency;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select sum(ADVA_MNY) from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_ID=:FROM_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('FROM_ID').AsString := FieldbyName('FROM_ID').AsString;
    AGlobal.Open(rs);
    r := rs.Fields[0].AsFloat;
    rs.Close;
    rs.SQL.Text := 'select sum(ADVA_MNY) from SAL_SALESORDER where TENANT_ID=:TENANT_ID and FROM_ID=:FROM_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('FROM_ID').AsString := FieldbyName('FROM_ID').AsString;
    AGlobal.Open(rs);
    r := r - rs.Fields[0].AsFloat;
    if r > 0 then // ����᰸������ж���ʱҪ�����˿�
       begin
         AGlobal.ExecSQL('update SAL_SALESORDER set ADVA_MNY=ADVA_MNY+ '+formatFloat('#0.00',r)+' where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID',self);
         AGlobal.ExecSQL('update ACC_RECVABLE_INFO set REVE_MNY=REVE_MNY + '+formatFloat('#0.00',r)+',RECK_MNY=RECK_MNY - '+formatFloat('#0.00',r)+' where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID',self);
       end;
  finally
    rs.Free;
  end;
end;

procedure TSalesOrder.DoUpgrade(AGlobal: IdbHelp);
begin
//  case AGlobal.iDbType of
//  0:AGlobal.ExecSQL('update BAS_CUSTOMER set PRICE_ID=isnull((select top 1 PRICE_ID from PUB_PRICEGRADE where INTEGRAL<=A.ACCU_INTEGRAL and INTEGRAL>0 and PRICE_ID not in (''000'',''---'') order by INTEGRAL desc),A.PRICE_ID),COMM=' + GetCommStr(iDbType) + ',' + 'TIME_STAMP='+GetTimeStamp(iDbType)+' from BAS_CUSTOMER A where A.CUST_ID in (:CUST_ID,:OLD_CUST_ID)',self);
//  end;
end;

procedure TSalesOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text :=
               'select jh.*,h.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select jg.*,g.GLIDE_NO as INDE_GLIDE_NO from ('+
               'select jf.*,f.USER_NAME as GUIDE_USER_TEXT from ('+
               'select je.*,e.SHOP_NAME as SHOP_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+
               'select jb.*,b.CLIENT_NAME as CLIENT_ID_TEXT,b.PRICE_ID,b.INTEGRAL as ACCU_INTEGRAL,b.BALANCE,b.CLIENT_CODE from '+
               '(select TENANT_ID,SHOP_ID,DEPT_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,'+
               'ADVA_MNY,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,BANK_ID,BANK_CODE,INTEGRAL,BARTER_INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,SALES_STYLE,IC_CARDNO,UNION_ID,COMM,CREA_DATE,CREA_USER,COMM_ID,'+
               'TIME_STAMP,LOCUS_STATUS from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) jb '+
               ' left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_SHOP_INFO e on je.TENANT_ID=e.TENANT_ID and je.SHOP_ID=e.SHOP_ID ) jf '+
               ' left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.GUIDE_USER=f.USER_ID ) jg '+
               ' left outer join SAL_INDENTORDER g on jg.TENANT_ID=g.TENANT_ID and jg.FROM_ID=g.INDE_ID ) jh '+
               ' left outer join CA_DEPT_INFO h on jh.TENANT_ID=h.TENANT_ID and jh.DEPT_ID=h.DEPT_ID';
  IsSQLUpdate := True;
  Str := 'insert into SAL_SALESORDER(TENANT_ID,SHOP_ID,DEPT_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,ADVA_MNY,PAY_A,PAY_B,PAY_C,'+
      'PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,BANK_ID,BANK_CODE,INTEGRAL,BARTER_INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,COMM_ID,COMM,CREA_DATE,CREA_USER,TIME_STAMP,LINKMAN,TELEPHONE,SEND_ADDR,SALES_STYLE,IC_CARDNO,UNION_ID,LOCUS_STATUS) '
    + 'VALUES(:TENANT_ID,:SHOP_ID,:DEPT_ID,:SALES_ID,:GLIDE_NO,:SALES_DATE,:SALES_TYPE,:PLAN_DATE,:CLIENT_ID,:GUIDE_USER,:CHK_DATE,:CHK_USER,:FROM_ID,:FIG_ID,:SALE_AMT,:SALE_MNY,:CASH_MNY,:PAY_ZERO,:PAY_DIBS,:ADVA_MNY,:PAY_A,:PAY_B,:PAY_C,:PAY_D,'+
      ':PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,:BANK_ID,:BANK_CODE,:INTEGRAL,:BARTER_INTEGRAL,:REMARK,:INVOICE_FLAG,:TAX_RATE,:COMM_ID,''00'','+GetSysDateFormat(iDbType)+',:CREA_USER,'+GetTimeStamp(iDbType)+',:LINKMAN,:TELEPHONE,:SEND_ADDR,:SALES_STYLE,:IC_CARDNO,:UNION_ID,''1'')';
  InsertSQL.Text := Str;
  Str := 'update SAL_SALESORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,SALES_ID=:SALES_ID,GLIDE_NO=:GLIDE_NO,SALES_DATE=:SALES_DATE,PLAN_DATE=:PLAN_DATE,SALES_TYPE=:SALES_TYPE,CLIENT_ID=:CLIENT_ID,'+
         'GUIDE_USER=:GUIDE_USER,CHK_DATE=:CHK_DATE,CHK_USER=:CHK_USER,FROM_ID=:FROM_ID,FIG_ID=:FIG_ID,SALE_AMT=:SALE_AMT,SALE_MNY=:SALE_MNY,CASH_MNY=:CASH_MNY,PAY_ZERO=:PAY_ZERO,PAY_DIBS=:PAY_DIBS,PAY_A=:PAY_A,PAY_B=:PAY_B,'+
         'PAY_C=:PAY_C,PAY_D=:PAY_D,PAY_E=:PAY_E,PAY_F=:PAY_F,PAY_G=:PAY_G,PAY_H=:PAY_H,PAY_I=:PAY_I,PAY_J=:PAY_J,BANK_ID=:BANK_ID,BANK_CODE=:BANK_CODE,INTEGRAL=:INTEGRAL,BARTER_INTEGRAL=:BARTER_INTEGRAL,REMARK=:REMARK,INVOICE_FLAG=:INVOICE_FLAG,TAX_RATE=:TAX_RATE,'
    + 'COMM=' + GetCommStr(iDbType) + ',LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,SEND_ADDR=:SEND_ADDR,SALES_STYLE=:SALES_STYLE,IC_CARDNO=:IC_CARDNO,UNION_ID=:UNION_ID,COMM_ID=:COMM_ID,'
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_SALESORDER where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  DeleteSQL.Text := Str;
end;

{ TSalesOrderGetPrior }

procedure TSalesOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC';
  1:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO<:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO DESC limit 1';
  end;
end;

{ TSalesOrderGetNext }

procedure TSalesOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO';
  1:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select SALES_ID from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and GLIDE_NO>:GLIDE_NO and SALES_TYPE=:SALES_TYPE order by GLIDE_NO limit 1';
  end;

end;

{ TSalesOrderAudit }

function TSalesOrderAudit.CheckZero(AGlobal:IdbHelp;Params:TftParamList): Boolean;
var
  Temp:TZQuery;
  w:integer;
  s:string;
begin
  Temp := TZQuery.Create(nil);
  try
     Temp.close;
     Temp.SQL.Text  := 'select VALUE from SYS_DEFINE where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString+' and DEFINE=''ZERO_LCT_OUT''';
     AGlobal.Open(Temp);
     if Temp.Fields[0].AsString = '0' then //Ϊ0����������
        begin
          Temp.Close;
          Temp.SQL.Text :=
              'select b.GODS_CODE,b.GODS_NAME,j.TENANT_ID,j.BATCH_NO,j.IS_PRESENT,j.LOCUS_NO,j.BOM_ID from ('+
              'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.BATCH_NO,B.IS_PRESENT,B.LOCUS_NO,B.BOM_ID from STO_GOODS_LOCATION A,SAL_SALESDATA B '+
              'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and A.LOCATION_ID=B.LOCATION_ID and A.BATCH_NO=B.BATCH_NO '+
              ' and round(A.AMOUNT,3)<0 and B.SALES_ID=:SALES_ID and B.TENANT_ID=:TENANT_ID '+
              ') j inner join VIW_GOODSINFO b on j.GODS_ID=b.GODS_ID and j.TENANT_ID=b.TENANT_ID ';
          Temp.Params.ParamByName('TENANT_ID').AsInteger := Params.ParambyName('TENANT_ID').AsInteger;
          Temp.Params.ParamByName('SALES_ID').AsString := Params.ParambyName('SALES_ID').AsString;
          AGlobal.Open(Temp);
          w := 0;
          s := '';
          Temp.first;
          while not Temp.Eof do
            begin
              inc(w);
              if s<>'' then s := s + #10;
              s := s +'('+Temp.FieldbyName('GODS_CODE').AsString+')'+Temp.FieldbyName('GODS_NAME').AsString;
              if Temp.FieldbyName('IS_PRESENT').AsString='1' then
                 s := s + '(��Ʒ)';
              if Temp.FieldbyName('BOM_ID').AsString <> '' then
                 s := s+ '(���)';
              if Temp.FieldbyName('BATCH_NO').AsString <> '#' then
                 s := s+ '  ����:'+Temp.FieldbyName('COLOR_NAME').AsString+'';
              if Temp.FieldbyName('LOCUS_NO').AsString <> '' then
                 s := s+ '  ���ٺ�:'+Temp.FieldbyName('LOCUS_NO').AsString+'';
              if w>5 then break;
              Temp.Next;
            end;
          if s<>'' then
            Raise Exception.Create(s+#10+'--��λ��治��,��˶��Ƿ�������ȷ��'); 
        end;
  finally
     Temp.free;
  end;
end;

function TSalesOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  Str:string;
  n:Integer;
  rs:TZQuery;
begin
  AGlobal.BeginTrans;
  try
    Str := 'update SAL_SALESORDER set CHK_DATE='''+Params.FindParam('CHK_DATE').asString+''',CHK_USER='''+Params.FindParam('CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('û�ҵ�����˵��ݣ��Ƿ���һ�û�ɾ��������ˡ�')
    else
    if n>1 then
       Raise Exception.Create('ɾ��ָ���Ӱ����У��������ݿ���������');
    {
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select TENANT_ID,SHOP_ID,GODS_ID,LOCATION_ID,BATCH_NO,CALC_AMOUNT from SAL_SALESDATA where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
      rs.ParamByName('TENANT_ID').AsInteger := Params.ParambyName('TENANT_ID').AsInteger;
      rs.ParamByName('SALES_ID').AsString := Params.ParambyName('SALES_ID').AsString;
      AGlobal.Open(rs);
      case AGlobal.iDbType of
      0:AGlobal.ExecSQL('select count(*) from STO_GOODS_LOCATION with(UPDLOCK) where TENANT_ID=:TENANT_ID',Params);
      1:AGlobal.ExecSQL('select count(*) from STO_GOODS_LOCATION where TENANT_ID=:TENANT_ID for update',Params);
      4:AGlobal.ExecSQL('select count(*) from STO_GOODS_LOCATION where TENANT_ID=:TENANT_ID  WITH RS USE AND KEEP UPDATE LOCKS',Params);
      end;
      rs.First;
      while not rs.Eof do
        begin
          DecLocation(AGlobal,rs.Fields[0].AsString,rs.Fields[1].AsString,rs.Fields[2].AsString,rs.Fields[3].AsString,rs.Fields[4].AsString,rs.Fields[5].AsFloat);
          rs.Next;
        end;
    finally
      rs.Free;
    end;
    CheckZero(AGlobal,Params);
    }
    Result := true;
    AGlobal.CommitTrans;
    Msg := '��˵��ݳɹ�';
  except
    on E:Exception do
      begin
        AGlobal.RollbackTrans;
        Result := false;
        Msg := '��˴���'+E.Message;
      end;
  end;
end;

{ TSalesOrderUnAudit }

function TSalesOrderUnAudit.Execute(AGlobal: IdbHelp;
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
     if rs.Fields[0].AsString='3' then Raise Exception.Create('�Ѿ�ɨ�������ϣ���������..');
   finally
     rs.Free;
   end;
   AGlobal.BeginTrans; 
   try
    Str := 'update SAL_SALESORDER set CHK_DATE=null,CHK_USER=null,COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('û�ҵ�����˵��ݣ��Ƿ���һ�û�ɾ������ˡ�')
    else
    if n>1 then
       Raise Exception.Create('ɾ��ָ���Ӱ����У��������ݿ���������');
    {
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select TENANT_ID,SHOP_ID,GODS_ID,LOCATION_ID,BATCH_NO,CALC_AMOUNT from SAL_SALESDATA where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
      rs.ParamByName('TENANT_ID').AsInteger := Params.ParambyName('TENANT_ID').AsInteger;
      rs.ParamByName('SALES_ID').AsString := Params.ParambyName('SALES_ID').AsString;
      AGlobal.Open(rs);
      case AGlobal.iDbType of
      0:AGlobal.ExecSQL('select count(*) from STO_GOODS_LOCATION with(UPDLOCK) where TENANT_ID=:TENANT_ID',Params);
      1:AGlobal.ExecSQL('select count(*) from STO_GOODS_LOCATION where TENANT_ID=:TENANT_ID for update',Params);
      4:AGlobal.ExecSQL('select count(*) from STO_GOODS_LOCATION where TENANT_ID=:TENANT_ID  WITH RS USE AND KEEP UPDATE LOCKS',Params);
      end;
      rs.First;
      while not rs.Eof do
        begin
          IncLocation(AGlobal,rs.Fields[0].AsString,rs.Fields[1].AsString,rs.Fields[2].AsString,rs.Fields[3].AsString,rs.Fields[4].AsString,rs.Fields[5].AsFloat);
          rs.Next;
        end;
    finally
      rs.Free;
    end;
    }
    AGlobal.CommitTrans;
    MSG := '����˵��ݳɹ���';
    Result := True;
  except
    on E:Exception do
       begin
         AGlobal.RollbackTrans;
         Result := False;
         Msg := '����˴���:'+E.Message;
       end;
  end;
end;

{ TSalesForLocusNo }

procedure TSalesForLocusNo.InitClass;
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

{ TSalesForLocusNoHeader }

procedure TSalesForLocusNoHeader.InitClass;
var
  Str:string;
begin
  inherited;
  SelectSQL.Text :=
               'select jh.*,h.DEPT_NAME as DEPT_ID_TEXT from ('+
               'select jg.*,g.GLIDE_NO as INDE_GLIDE_NO from ('+
               'select jf.*,f.USER_NAME as GUIDE_USER_TEXT from ('+
               'select je.*,e.SHOP_NAME as SHOP_ID_TEXT from ('+
               'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
               'select jc.*,c.USER_NAME as CREA_USER_TEXT from ('+
               'select jb.*,b.CLIENT_NAME as CLIENT_ID_TEXT,b.PRICE_ID,b.INTEGRAL as ACCU_INTEGRAL,b.BALANCE,b.CLIENT_CODE from '+
               '(select TENANT_ID,SHOP_ID,DEPT_ID,SALES_ID,GLIDE_NO,SALES_DATE,SALES_TYPE,LINKMAN,TELEPHONE,SEND_ADDR,PLAN_DATE,CLIENT_ID,GUIDE_USER,CHK_DATE,CHK_USER,FROM_ID,FIG_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,PAY_DIBS,'+
               'ADVA_MNY,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J,BANK_ID,BANK_CODE,INTEGRAL,BARTER_INTEGRAL,REMARK,INVOICE_FLAG,TAX_RATE,SALES_STYLE,IC_CARDNO,UNION_ID,COMM,CREA_DATE,CREA_USER,'+
               'LOCUS_STATUS,LOCUS_USER,LOCUS_DATE,LOCUS_AMT,LOCUS_CHK_DATE,LOCUS_CHK_USER,'+
               'TIME_STAMP from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID) jb '+
               ' left outer join VIW_CUSTOMER b on jb.TENANT_ID=b.TENANT_ID and jb.CLIENT_ID=b.CLIENT_ID ) jc '+
               ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID ) jd '+
               ' left outer join VIW_USERS d on jd.TENANT_ID=d.TENANT_ID and jd.CHK_USER=d.USER_ID ) je '+
               ' left outer join CA_SHOP_INFO e on je.TENANT_ID=e.TENANT_ID and je.SHOP_ID=e.SHOP_ID ) jf '+
               ' left outer join VIW_USERS f on jf.TENANT_ID=f.TENANT_ID and jf.GUIDE_USER=f.USER_ID ) jg '+
               ' left outer join SAL_INDENTORDER g on jg.TENANT_ID=g.TENANT_ID and jg.FROM_ID=g.INDE_ID ) jh '+
               ' left outer join CA_DEPT_INFO h on jh.TENANT_ID=h.TENANT_ID and jh.DEPT_ID=h.DEPT_ID';
  Str :=
      'update SAL_SALESORDER set LOCUS_STATUS=:LOCUS_STATUS,LOCUS_USER=:LOCUS_USER,LOCUS_DATE=:LOCUS_DATE,LOCUS_AMT=:LOCUS_AMT,LOCUS_CHK_DATE=:LOCUS_CHK_DATE,LOCUS_CHK_USER=:LOCUS_CHK_USER,'
    + 'COMM=' + GetCommStr(iDbType) + ','
    + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
    + 'where TENANT_ID=:OLD_TENANT_ID and SALES_ID=:OLD_SALES_ID';
  UpdateSQL.Text := Str;
end;

{ TSalesLocusNoAudit }

function TSalesLocusNoAudit.Execute(AGlobal: IdbHelp;
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
    if rs.Fields[0].AsString<>'3' then Raise Exception.Create('û�з�����ϣ��������..');
  finally
    rs.Free;
  end;
  try
    Str := 'update SAL_SALESORDER set LOCUS_CHK_DATE='''+Params.FindParam('LOCUS_CHK_DATE').asString+''',LOCUS_CHK_USER='''+Params.FindParam('LOCUS_CHK_USER').asString+''',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'   where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and LOCUS_CHK_DATE IS NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('û�ҵ�����˵��ݣ��Ƿ���һ�û�ɾ��������ˡ�')
    else
    if n>1 then
       Raise Exception.Create('ɾ��ָ���Ӱ����У��������ݿ���������');
    Result := true;
    Msg := '��˵��ݳɹ�';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '��˴���'+E.Message;
      end;
  end;
end;

{ TSalesLocusNoUnAudit }

function TSalesLocusNoUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  Str:string;
  n:Integer;
begin
   try
    Str := 'update SAL_SALESORDER set LOCUS_CHK_DATE=null,LOCUS_CHK_USER=null,LOCUS_STATUS=''1'',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and SALES_ID='''+Params.FindParam('SALES_ID').asString+''' and LOCUS_CHK_DATE IS NOT NULL';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('û�ҵ�����˵��ݣ��Ƿ���һ�û�ɾ������ˡ�')
    else
    if n>1 then
       Raise Exception.Create('ɾ��ָ���Ӱ����У��������ݿ���������');
    MSG := '����˵��ݳɹ���';
    Result := True;
  except
    on E:Exception do
       begin
         Result := False;
         Msg := '����˴���:'+E.Message;
       end;
  end;
end;

{ TSalesICData }

function TSalesICData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
begin
  if FieldbyName('PAY_C').AsOldFloat <>0 then
  begin
    r := AGlobal.ExecSQL(ParseSQL(iDbType,'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) + :OLD_PAY_C where TENANT_ID=:OLD_TENANT_ID and IC_CARDNO=:OLD_IC_CARDNO and UNION_ID=''#'' and IC_STATUS in (''0'',''1'')'),self);
    if r=0 then Raise Exception.Create(FieldbyName('IC_CARDNO').asOldString+'������Ч,�޷�ִ����ز���..'); 
  end;
end;

function TSalesICData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  rs:TZQuery;
begin
  if FieldbyName('PAY_C').AsFloat <>0 then
  begin
    r := AGlobal.ExecSQL(ParseSQL(iDbType,'update PUB_IC_INFO set BALANCE=isnull(BALANCE,0) - :PAY_C where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#'' and IC_STATUS in (''0'',''1'')'),self);
    if r=0 then Raise Exception.Create(FieldbyName('IC_CARDNO').asString+'������Ч,�޷�ִ����ز���..');
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select BALANCE from PUB_IC_INFO where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#'' ';
      rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
      rs.ParamByName('IC_CARDNO').AsString := FieldbyName('IC_CARDNO').AsString;
      AGlobal.Open(rs);
      if rs.Fields[0].AsFloat<0 then Raise Exception.Create(FieldbyName('IC_CARDNO').AsString+'�Ĵ�ֵ�����㣬�������֧��');
    finally
      rs.Free;
    end;
  end;
end;

function TSalesICData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

procedure TSalesICData.InitClass;
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
    'COMM=' + GetCommStr(iDbType) + ','
  + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
  + 'where TENANT_ID=:OLD_TENANT_ID and GLIDE_ID=:OLD_GLIDE_ID';
  UpdateSQL.Text := Str;
  
  Str :=
    'update SAL_IC_GLIDE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and GLIDE_ID=:OLD_GLIDE_ID';
  DeleteSQL.Text := Str;

end;

initialization
  RegisterClass(TSalesOrder);
  RegisterClass(TSalesData);
  RegisterClass(TSalesICData);
  RegisterClass(TSalesOrderAudit);
  RegisterClass(TSalesOrderUnAudit);
  RegisterClass(TSalesOrderGetPrior);
  RegisterClass(TSalesOrderGetNext);
  RegisterClass(TSalesForLocusNo);
  RegisterClass(TSalesForLocusNoHeader);
  RegisterClass(TSalesLocusNoAudit);
  RegisterClass(TSalesLocusNoUnAudit);

finalization
  UnRegisterClass(TSalesOrder);
  UnRegisterClass(TSalesData);
  UnRegisterClass(TSalesICData);
  UnRegisterClass(TSalesOrderAudit);
  UnRegisterClass(TSalesOrderUnAudit);
  UnRegisterClass(TSalesOrderGetPrior);
  UnRegisterClass(TSalesOrderGetNext);
  UnRegisterClass(TSalesForLocusNo);
  UnRegisterClass(TSalesForLocusNoHeader);
  UnRegisterClass(TSalesLocusNoAudit);
  UnRegisterClass(TSalesLocusNoUnAudit);
  
end.
