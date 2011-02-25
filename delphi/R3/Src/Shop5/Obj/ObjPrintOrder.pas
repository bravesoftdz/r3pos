unit ObjPrintOrder;

interface

uses
  SysUtils,zBase,Classes, AdoDb,zIntf,ObjCommon,DB,zDataSet;

type
  TPrintOrder=class(TZFactory)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    // function AfterUpdateBatch(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TPrintData=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  
  TPrintOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  
  TPrintOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;

  TPrintOrderAudit=class(TZProcFactory)
  private
    function IsZero(AGlobal:IdbHelp;Params:TftParamList):boolean;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  TPrintOrderUnAudit=class(TZProcFactory)
  private
    function IsZero(AGlobal:IdbHelp;Params:TftParamList):boolean;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;


implementation

{ TCheckData }

function TPrintData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var str: string; ReRun: Integer;
begin
  str:='update STO_PRINTDATA set CHK_AMOUNT=0,CHECK_STATUS=''1'' '+
    ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PRINT_DATE=:OLD_PRINT_DATE and GODS_ID=:OLD_GODS_ID and '+
    ' PROPERTY_01=:OLD_PROPERTY_01 and PROPERTY_02=:OLD_PROPERTY_02 and BATCH_NO=:OLD_BATCH_NO ';
  ReRun:=AGlobal.ExecSQL(str,self);
  result := true;
end;

function TPrintData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var str: string; ReRun: Integer;
begin
  str:='update STO_PRINTDATA set CHK_AMOUNT=:CHK_AMOUNT,CHECK_STATUS=''2'' '+
    ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE and GODS_ID=:GODS_ID and '+
    ' PROPERTY_01=:PROPERTY_01 and PROPERTY_02=:PROPERTY_02 and BATCH_NO=:BATCH_NO ';
  ReRun:=AGlobal.ExecSQL(str,self);

  if ReRun=0 then  //û�и��µ���¼;
  begin
    Str:='insert into STO_PRINTDATA(ROWS_ID,TENANT_ID,SHOP_ID,PRINT_DATE,BATCH_NO,LOCUS_NO,BOM_ID,GODS_ID,PROPERTY_01,PROPERTY_02,RCK_AMOUNT,CHK_AMOUNT,CHECK_STATUS) '+
      ' values (:ROWS_ID,:TENANT_ID,:SHOP_ID,:PRINT_DATE,''#'',''#'','''',:GODS_ID,:PROPERTY_01,:PROPERTY_02,:RCK_AMOUNT,:CHK_AMOUNT,2)';
    AGlobal.ExecSQL(str, self);
  end;
  result := true;
end;

function TPrintData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

procedure TPrintData.InitClass;
begin
  inherited;
  SelectSQL.Text:=
    ParseSQL(iDbType,
    'select j.ROWS_ID as ROWS_ID,j.TENANT_ID as TENANT_ID,j.SHOP_ID as SHOP_ID,j.PRINT_DATE as PRINT_DATE,j.GODS_ID as GODS_ID,j.PROPERTY_01 as PROPERTY_01,'+
    'j.PROPERTY_02 as PROPERTY_02,j.BATCH_NO as BATCH_NO,j.LOCUS_NO as LOCUS_NO,j.BOM_ID as BOM_ID,B.CALC_UNITS as UNIT_ID,0 as IS_PRESENT,0 as SEQNO,'+
    'j.RCK_AMOUNT as RCK_AMOUNT,'+  //��������
    'j.CHK_AMOUNT as CHK_AMOUNT,'+  //�̵�����
    '(ifnull(j.RCK_AMOUNT,0)-ifnull(j.CHK_AMOUNT,0)) as PAL_AMOUNT,'+  //ӯ������
    ' b.GODS_NAME as GODS_NAME,b.GODS_CODE as GODS_CODE,'+
    ' b.NEW_INPRICE as NEW_INPRICE,'+
    ' b.NEW_OUTPRICE as NEW_OUTPRICE,'+
    ' (ifnull(j.RCK_AMOUNT,0)-ifnull(j.CHK_AMOUNT,0))*ifnull(b.NEW_INPRICE,0) as PAL_INAMONEY,'+
    ' (ifnull(j.RCK_AMOUNT,0)-ifnull(j.CHK_AMOUNT,0))*ifnull(b.NEW_OUTPRICE,0) as PAL_OUTAMONEY  '+
    ' from STO_PRINTDATA j '+
    ' left join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
    ' where j.TENANT_ID=:TENANT_ID and j.SHOP_ID=:SHOP_ID and j.PRINT_DATE=:PRINT_DATE and CHECK_STATUS=2 '+
    ' order by b.GODS_CODE');
end;

{ TCheckOrder }

function TPrintOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin    
  result := true;
end;

function TPrintOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  {
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
  begin
    if (FieldbyName('GLIDE_NO').AsString='') or (Pos('����',FieldbyName('GLIDE_NO').AsString)>0) then
     FieldbyName('GLIDE_NO').AsString:=GetSequence(AGlobal,'GNO_3_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
  end;
  result := true;
  }
end;

function TPrintOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  
end;

function TPrintOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
//        Result := GetReckOning(AGlobal,FieldbyName('COMP_ID').asString,FieldbyName('CHECK_DATE').AsString);
//        if FieldbyName('CHECK_DATE').AsOldString <> '' then
//           Result := GetReckOning(AGlobal,FieldbyName('COMP_ID').asString,FieldbyName('CHECK_DATE').AsOldString);
        result := true;
      end
   else
      Result := true;
      
end;

procedure TPrintOrder.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text:=
    'select jc.*,c.USER_NAME as CREA_USER_TEXT,d.USER_NAME as CHK_USER_TEXT from ('+
    ' select TENANT_ID,SHOP_ID,PRINT_DATE,CHECK_STATUS,CHECK_TYPE,CREA_DATE,CREA_USER,CHK_USER,CHK_DATE,COMM from STO_PRINTORDER '+
    ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE) jc '+
    ' left outer join VIW_USERS c on jc.CREA_USER=c.USER_ID '+
    ' left outer join VIW_USERS d on jc.CHK_USER=d.USER_ID ';
    
  str:='insert into STO_PRINTORDER(TENANT_ID,SHOP_ID,PRINT_DATE,CHECK_STATUS,CHECK_TYPE,CREA_DATE,CREA_USER,COMM,TIME_STAMP)'+
       ' values (:TENANT_ID,:SHOP_ID,:PRINT_DATE,:CHECK_STATUS,:CHECK_TYPE,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(str);

  str:='update STO_PRINTORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,PRINT_DATE=:PRINT_DATE,CHECK_STATUS=:CHECK_STATUS,CHECK_TYPE=:CHECK_TYPE,CREA_DATE=:CREA_DATE,'+
       ' CREA_USER=:CREA_USER,CHK_USER=:CHK_USER,CHK_DATE=:CHK_DATE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PRINT_DATE=:OLD_PRINT_DATE ';
  UpdateSQL.Add(Str);
  Str := 'delete from STO_PRINTORDER where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PRINT_DATE=:OLD_PRINT_DATE ';
  DeleteSQL.Add(Str);
end;

{ TCheckOrderGetPrior }

procedure TPrintOrderGetPrior.InitClass;
begin
  inherited;
  SelectSQL.Text:= 'select top 1 CHECK_ID from STO_CHECKORDER where COMP_ID=:COMP_ID and OPER_USER=:OPER_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO desc';
end;


{ TCheckOrderGetNext }

procedure TPrintOrderGetNext.InitClass;
begin
  inherited;
  SelectSQL.Text := 'select top 1 CHECK_ID from STO_CHECKORDER where COMP_ID=:COMP_ID and OPER_USER=:OPER_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
end;


{ TPrintOrderAudit }

function TPrintOrderAudit.IsZero(AGlobal:IdbHelp;Params:TftParamList):boolean;
var Temp: TZQuery;
begin
  Result := true;
  Temp := TZQuery.Create(nil);
  try
     Temp.close;
     Temp.SQL.Text:= 'select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE ';
     if Temp.Params.FindParam('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Params.ParambyName('TENANT_ID').AsInteger;
     if Temp.Params.FindParam('DEFINE')<>nil then Temp.ParamByName('DEFINE').AsString:='ZERO_OUT';
     AGlobal.Open(Temp);
     result:=(Temp.Fields[0].AsString = '1');
  finally
     Temp.free;
  end;
end;

{== ������Params
  AUDIT_FLAG��0��ʾ����û¼���̵���Ʒ�������Ϊ0; Ϊ1��������
  TENANT_ID: ��ҵID
  SHOP_ID:   �ŵ�ID
  CHK_USER: �����
  PRINT_DATE: �̵㵥�ݺţ����ڣ�[�൱��ԭ��: PRINT_ID]
 }

function TPrintOrderAudit.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  rs,ts: TZQuery;
  SQL,id,gid,s,CurDate,CurTime,User:string;
  r,w:integer;
  cb,CHANGE_AMT,CHANGE_MNY: real;  //�ɱ��� |�������� |�������
begin
  //����: Params.ParambyName('AUDIT_FLAG').asString ����UI�������ĵ���Ϊ��Ϊ0��ʾ����û¼���̵���Ʒ�������Ϊ0��Ϊ1������ʾ������;
  rs := TZQuery.Create(nil);
  ts := TZQuery.Create(nil);
  try
    CHANGE_AMT:=0;
    CHANGE_MNY:=0;
    SQL:='select * from ('+
      'select A.TENANT_ID as TENANT_ID,A.SHOP_ID as SHOP_ID,A.GODS_ID as GODS_ID,B.CALC_UNITS as UNIT_ID,A.PROPERTY_01 as PROPERTY_01,'+
      'A.PROPERTY_02 as PROPERTY_02,A.BATCH_NO as BATCH_NO, '+
      '(case when CHECK_STATUS=''1'' then case when '+Params.ParambyName('AUDIT_FLAG').asString+
                    '=0 then -ifnull(A.RCK_AMOUNT,0) else 0 end else ifnull(A.CHK_AMOUNT,0)-ifnull(A.RCK_AMOUNT,0) end) as MDI_AMOUNT,'+
      ' ifnull(A.CHK_AMOUNT,0) as CHK_AMOUNT,ifnull(A.RCK_AMOUNT,0) as RCK_AMOUNT '+
      ' from STO_PRINTDATA A,VIW_GOODSINFO B '+
      ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
      ' A.TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and '+
      ' A.PRINT_DATE=:PRINT_DATE and ifnull(A.CHK_AMOUNT,0)<>ifnull(A.RCK_AMOUNT,0)) j where MDI_AMOUNT<>0';
    rs.Close;
    rs.SQL.Text:= ParseSQL(AGlobal.iDbType,SQL);
    rs.Params.AssignValues(Params);
    AGlobal.Open(rs);

    AGlobal.BeginTrans;
    try
      id := NewId('');
      User:=trim(Params.ParambyName('CHK_USER').asString);
      CurDate:=trim(FormatDatetime('YYYY-MM-DD',Date()));
      CurTime:=trim(FormatDatetime('YYYY-MM-DD HH:MM:SS',Now()));
      gid := GetSequence(AGlobal,'GNO_9_'+Params.ParambyName('SHOP_ID').asString,Params.ParambyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
      if not rs.IsEmpty then
      begin
        AGlobal.ExecSQL('insert into STO_CHANGEORDER(CHANGE_ID,GLIDE_NO,TENANT_ID,SHOP_ID,CHANGE_DATE,CHANGE_TYPE,CHANGE_CODE,DUTY_USER,REMARK,CHK_USER,CHK_DATE,FROM_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
                        'select '''+id+''','''+gid+''',TENANT_ID,SHOP_ID,PRINT_DATE,''1'',''1'','''+User+''',''�̵�'','''+User+''','''+CurTime+''','+'cast(PRINT_DATE as varchar(10)) as PRINT_DATE,'''+CurTime+''','''+User+''',''00'','+GetTimeStamp(AGlobal.iDbType)+' '+
                        'from STO_PRINTORDER where TENANT_ID='''+Params.ParambyName('TENANT_ID').asString+''' and '+
                        ' SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and PRINT_DATE='''+Params.ParambyName('PRINT_DATE').asString+''' ');

        //�̵���ϸ���ݲ����������ϸ:
        rs.First;
        while not rs.Eof do
          begin
            cb := GetCostPrice(AGlobal,rs.FieldbyName('TENANT_ID').AsString,rs.FieldbyName('SHOP_ID').AsString,
                                       rs.FieldbyName('GODS_ID').AsString,
                                       rs.FieldbyName('PROPERTY_01').AsString,rs.FieldbyName('PROPERTY_02').AsString,
                                       rs.FieldbyName('BATCH_NO').AsString);
            AGlobal.ExecSQL('insert into STO_CHANGEDATA(TENANT_ID,SHOP_ID,SEQNO,CHANGE_ID,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,UNIT_ID,AMOUNT,COST_PRICE,IS_PRESENT,CALC_AMOUNT,REMARK) '+
                            'values('+
                            ''''+Params.ParambyName('TENANT_ID').asString+''','+
                            ''''+Params.ParambyName('SHOP_ID').asString+''','+inttostr(rs.RecNo+1)+','''+id+''','+
                            ''''+rs.FieldbyName('GODS_ID').AsString+''','+
                            ''''+rs.FieldbyName('BATCH_NO').AsString+''','+
                            ''''+rs.FieldbyName('PROPERTY_01').AsString+''','+
                            ''''+rs.FieldbyName('PROPERTY_02').AsString+''','+
                            ''''+rs.FieldbyName('UNIT_ID').AsString+''','+
                            ''''+rs.FieldbyName('MDI_AMOUNT').AsString+''','+
                            ''''+formatfloat('#0.000000',cb)+''','+
                            '0,'+   //�Ƿ�����Ʒ[�̵㵥û�ֶΣ�Ĭ��Ϊ:0]
                            ''''+rs.FieldbyName('MDI_AMOUNT').AsString+''','+
                            '''�̵�:'+rs.FieldbyName('RCK_AMOUNT').AsString+'->'+rs.FieldbyName('CHK_AMOUNT').AsString+''''+
                            ')'
                           );

            IncStorage(AGlobal,
                       rs.FieldbyName('TENANT_ID').asString,
                       rs.FieldbyName('SHOP_ID').asString,
                       rs.FieldbyName('GODS_ID').asString,
                       rs.FieldbyName('PROPERTY_01').asString,
                       rs.FieldbyName('PROPERTY_02').asString,
                       rs.FieldbyName('BATCH_NO').asString,
                       rs.FieldbyName('MDI_AMOUNT').asFloat,
                       rs.FieldbyName('MDI_AMOUNT').asFloat*cb,3);
            //�����ۼ��������ۼƽ��:
            CHANGE_AMT:=CHANGE_AMT+StrtoFloatDef(rs.FieldbyName('MDI_AMOUNT').AsString,0);
            CHANGE_MNY:=CHANGE_MNY+StrtoFloatDef(rs.FieldbyName('MDI_AMOUNT').AsString,0)*cb;
            rs.Next;
          end;
      end;             

      //���µ�������ϸ��������
      AGlobal.ExecSQL('update STO_CHANGEORDER set CHANGE_AMT='+FloattoStr(CHANGE_AMT)+',CHANGE_MNY='+FloattoStr(CHANGE_MNY)+' '+
                      ' where TENANT_ID='''+Params.ParambyName('TENANT_ID').asString+''' and SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and CHANGE_ID='''+id+''' ');

      r := AGlobal.ExecSQL('update STO_PRINTORDER set CHECK_STATUS=''3'',CHK_USER='''+User+''',CHK_DATE='''+CurDate+''' where TENANT_ID='''+Params.ParambyName('TENANT_ID').asString+''' and '+
                           ' SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and PRINT_DATE='''+Params.ParambyName('PRINT_DATE').asString+''' and CHECK_STATUS<>''3''');
      if r=0 then Raise Exception.Create('û�ҵ�����˵��̵㵥���Ƿ�����һ�û������ϣ�');
      if not IsZero(AGlobal,Params) then
      begin
        ts.Close;
        ts.SQL.Text :=
            'select jp2.*,SIZE_NAME from ('+
            'select jp1.*,COLOR_NAME from ('+
            'select b.GODS_CODE,b.GODS_NAME,B.SORT_ID7,B.SORT_ID8,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO  from ('+
            'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.BATCH_NO from STO_STORAGE A,STO_CHANGEDATA B '+
            'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 and A.BATCH_NO=B.BATCH_NO '+
            ' and A.AMOUNT<0 and B.CHANGE_ID='''+id+''' and B.TENANT_ID='''+Params.ParambyName('TENANT_ID').asString+''' and B.SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''''+
            ') j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
            ') jp1 left outer join (select SORT_ID,SORT_NAME as COLOR_NAME from PUB_GOODSSORT where SORT_TYPE=7) p1 on jp1.SORT_ID7=p1.SORT_ID '+
            ') jp2 left outer join (select SORT_ID,SORT_NAME as SIZE_NAME from PUB_GOODSSORT where SORT_TYPE=8) p2 on jp2.SORT_ID8=p2.SORT_ID ';
        AGlobal.Open(ts);
        w := 0;
        s := '';
        rs.first;
        while not ts.Eof do
          begin
            inc(w);
            if s<>'' then s := s + #10;
            s := s +'('+ts.FieldbyName('GODS_CODE').AsString+')'+ts.FieldbyName('GODS_NAME').AsString;
            //if ts.FieldbyName('IS_PRESENT').AsString='1' then s := s + '(��Ʒ)';
            if ts.FieldbyName('SIZE_NAME').AsString <> '' then
               s := s+ '  ����:'+ts.FieldbyName('SIZE_NAME').AsString+'';
            if ts.FieldbyName('COLOR_NAME').AsString <> '' then
               s := s+ '  ��ɫ:'+ts.FieldbyName('COLOR_NAME').AsString+'';
            if ts.FieldbyName('BATCH_NO').AsString <> '#' then
               s := s+ '  ����:'+ts.FieldbyName('BATCH_NO').AsString+'';
            if w>5 then break;
            ts.Next;
          end;
        if s<>'' then
          Raise Exception.Create(s+#10+'--��Ʒ��治��,��˶��Ƿ�������ȷ��');
      end;
      //2010.02.24 SQLITE���ݿ�û����־��
      //WriteLogInfo(AGlobal,Params.ParambyName('CHK_USER').AsString,2,'600020','��ˡ��̵�����'+Params.ParambyName('PRINT_ID').asString+'��','�������浥������'+gid+'��');
      AGlobal.CommitTrans;
      MSG := '��˵��̵㵥���...';
      result := true;
    except
      AGlobal.RollbackTrans;
      Raise;
    end;
  finally
    ts.Free;
    rs.Free;
  end;
end;

{ TPrintOrderUnAudit }

function TPrintOrderUnAudit.IsZero(AGlobal:IdbHelp;Params:TftParamList): boolean;
var Temp: TZQuery;
begin
  Result := true;
  Temp := TZQuery.Create(nil);
  try
     Temp.close;
     Temp.SQL.Text:= 'select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE ';
     if Temp.Params.FindParam('TENANT_ID')<>nil then Temp.ParamByName('TENANT_ID').AsInteger:=Params.ParambyName('TENANT_ID').AsInteger;
     if Temp.Params.FindParam('DEFINE')<>nil then Temp.ParamByName('DEFINE').AsString:='ZERO_OUT';
     AGlobal.Open(Temp);
     result:=(Temp.Fields[0].AsString = '1');
  finally
     Temp.free;
  end;
end;

function TPrintOrderUnAudit.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  rs,ts: TZQuery;
  r,w:integer;
  s,Change_ID:string;
begin
  rs := TZQuery.Create(nil);
  ts := TZQuery.Create(nil);
  try
    ts.Close;
    ts.SQL.Text :='select max(PRINT_DATE) as PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID ';
    ts.Params.AssignValues(Params); 
    AGlobal.Open(ts);
    if ts.Fields[0].AsString>Params.ParambyName('PRINT_DATE').asString then Raise Exception.Create('�Ѿ����ʲ�������...');

    rs.Close;
    rs.SQL.Text := 'select COMM,CHANGE_ID,TENANT_ID,SHOP_ID,CHANGE_DATE from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and FROM_ID=:PRINT_DATE and CHANGE_CODE=''1'' ';
    rs.Params.AssignValues(Params);
    AGlobal.Open(rs);     
    if copy(rs.FieldByName('COMM').AsString,1,2)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ�������');
    AGlobal.BeginTrans;
    try
      Change_ID:=trim(rs.fieldbyName('CHANGE_ID').AsString);
      ts.Close;
      ts.SQL.Text := 'select TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,IS_PRESENT,CALC_AMOUNT,COST_PRICE from STO_CHANGEDATA where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CHANGE_ID='''+rs.FieldbyName('CHANGE_ID').AsString+''' ';
      ts.Params.AssignValues(Params); 
      AGlobal.Open(ts);
      ts.First;
      while not ts.Eof do
        begin
          DecStorage(AGlobal,
                     ts.FieldbyName('TENANT_ID').asString,
                     ts.FieldbyName('SHOP_ID').asString,
                     ts.FieldbyName('GODS_ID').asString,
                     ts.FieldbyName('PROPERTY_01').asString,
                     ts.FieldbyName('PROPERTY_02').asString,
                     ts.FieldbyName('BATCH_NO').asString,
                     ts.FieldbyName('CALC_AMOUNT').asFloat,
                     ts.FieldbyName('CALC_AMOUNT').asFloat*ts.FieldbyName('COST_PRICE').asFloat,3);
          ts.Next;
        end;
      AGlobal.ExecSQL('delete from STO_CHANGEDATA where TENANT_ID='''+Params.ParambyName('TENANT_ID').asString+''' and '+
                      ' SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and CHANGE_ID='''+rs.FieldbyName('CHANGE_ID').AsString+'''');
      AGlobal.ExecSQL('delete from STO_CHANGEORDER where TENANT_ID='''+Params.ParambyName('TENANT_ID').asString+''' and '+
                      ' SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and CHANGE_ID='''+rs.FieldbyName('CHANGE_ID').AsString+'''');
      r:=AGlobal.ExecSQL('update STO_PRINTORDER set CHECK_STATUS=''2'',CHK_USER=null,CHK_DATE=null where TENANT_ID='''+Params.ParambyName('TENANT_ID').asString+''' and '+
                         ' SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and PRINT_DATE='''+Params.ParambyName('PRINT_DATE').asString+''' and CHECK_STATUS=''3''');
      if r=0 then Raise Exception.Create('û�ҵ�����˵��̵㵥���Ƿ�����һ�û������ϣ�');
      
      if not IsZero(AGlobal,Params) then
      begin
        ts.Close;
        ts.SQL.Text :=
            'select jp2.*,SIZE_NAME from ('+
            'select jp1.*,COLOR_NAME from ('+
            'select b.GODS_CODE,b.GODS_NAME,B.SORT_ID7,B.SORT_ID8,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO  from ('+
            'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.BATCH_NO from STO_STORAGE A,STO_CHANGEDATA B '+
            'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 and A.BATCH_NO=B.BATCH_NO and '+
            ' A.AMOUNT<0 and B.CHANGE_ID='''+Change_ID+''' and B.TENANT_ID='''+Params.ParambyName('TENANT_ID').asString+''' and B.SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''''+
            ') j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
            ') jp1 left outer join (select SORT_ID,SORT_NAME as COLOR_NAME from PUB_GOODSSORT where SORT_TYPE=7) p1 on jp1.SORT_ID7=p1.SORT_ID '+
            ') jp2 left outer join (select SORT_ID,SORT_NAME as SIZE_NAME from PUB_GOODSSORT where SORT_TYPE=8) p2 on jp2.SORT_ID8=p2.SORT_ID ';
        AGlobal.Open(ts);
        w := 0;
        s := '';
        rs.first;
        while not ts.Eof do
          begin
            inc(w);
            if s<>'' then s := s + #10;
            s := s +'('+ts.FieldbyName('GODS_CODE').AsString+')'+ts.FieldbyName('GODS_NAME').AsString;
            // if ts.FieldbyName('IS_PRESENT').AsString='1' then s := s + '(��Ʒ)';
            if ts.FieldbyName('SIZE_NAME').AsString <> '' then
               s := s+ '  ����:'+ts.FieldbyName('SIZE_NAME').AsString+'';
            if ts.FieldbyName('COLOR_NAME').AsString <> '' then
               s := s+ '  ��ɫ:'+ts.FieldbyName('COLOR_NAME').AsString+'';
            if ts.FieldbyName('BATCH_NO').AsString <> '#' then
               s := s+ '  ����:'+ts.FieldbyName('BATCH_NO').AsString+'';
            if w>5 then break;
            ts.Next;
          end;
        if s<>'' then
          Raise Exception.Create(s+#10+'--��Ʒ��治��,��˶��Ƿ�������ȷ��');
      end;
      //2010.02.24 SQLITE���ݿ�û����־��
      // WriteLogInfo(AGlobal,Params.ParambyName('CHK_USER').AsString,2,'600020','�����̵�����'+Params.ParambyName('PRINT_DATE').asString+'��','ɾ�����浥������'+rs.FieldbyName('CHANGE_ID').AsString+'��');
      AGlobal.CommitTrans;
      MSG := '�����̵㵥���...';
      result := true;
    except
      AGlobal.RollbackTrans;
      Raise;
    end;
  finally
    ts.Free;
    rs.Free;
  end;
end;

initialization
  RegisterClass(TPrintOrder);
  RegisterClass(TPrintData);
  RegisterClass(TPrintOrderGetPrior);
  RegisterClass(TPrintOrderGetNext);
  RegisterClass(TPrintOrderAudit);
  RegisterClass(TPrintOrderUnAudit);

finalization
  UnRegisterClass(TPrintOrder);
  UnRegisterClass(TPrintData);
  UnRegisterClass(TPrintOrderGetPrior);
  UnRegisterClass(TPrintOrderGetNext);
  UnRegisterClass(TPrintOrderAudit);
  UnRegisterClass(TPrintOrderUnAudit);

end.
