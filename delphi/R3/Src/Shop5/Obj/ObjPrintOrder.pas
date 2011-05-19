unit ObjPrintOrder;

interface

uses
  SysUtils,zBase,Classes, AdoDb,zIntf,ObjCommon,DB,zDataSet,math;

type
  TPrintOrder=class(TZFactory)
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
    procedure InitClass; override;
  end;

  TPrintData=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
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

  {=============================================================================
   审核: 以为出库减库存
   ============================================================================}

  TPrintOrderAudit=class(TZProcFactory)
  private
    function IntToVarchar(AGlobal:IdbHelp; FieldName: string): string;  
    function IsZero(AGlobal:IdbHelp;Params:TftParamList):boolean;
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  {}
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
  str:='update STO_PRINTDATA set CHK_AMOUNT=:CALC_AMOUNT,CHECK_STATUS=''2'' '+
    ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE and GODS_ID=:GODS_ID and '+
    ' PROPERTY_01=:PROPERTY_01 and PROPERTY_02=:PROPERTY_02 and BATCH_NO=:BATCH_NO ';
  ReRun:=AGlobal.ExecSQL(str,self);

  if ReRun=0 then  //没有更新到记录;
  begin
    Str:='insert into STO_PRINTDATA(ROWS_ID,TENANT_ID,SHOP_ID,PRINT_DATE,BATCH_NO,LOCUS_NO,BOM_ID,GODS_ID,PROPERTY_01,PROPERTY_02,RCK_AMOUNT,CHK_AMOUNT,CHECK_STATUS) '+
         ' values (:ROWS_ID,:TENANT_ID,:SHOP_ID,:PRINT_DATE,:BATCH_NO,''#'',null,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:RCK_CALC_AMOUNT,:CALC_AMOUNT,''2'')';
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
    'j.PROPERTY_02 as PROPERTY_02,j.BATCH_NO as BATCH_NO,j.LOCUS_NO as LOCUS_NO,j.BOM_ID as BOM_ID,B.UNIT_ID,0 as IS_PRESENT,0 as SEQNO,'+
    'j.RCK_AMOUNT*1.00/case when B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as RCK_AMOUNT,'+  //账面库存量
    'j.RCK_AMOUNT as RCK_CALC_AMOUNT,'+  //账面库存量
    'j.CHK_AMOUNT*1.00/case when B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as AMOUNT,'+  //盘点库存量
    'j.CHK_AMOUNT as CALC_AMOUNT,'+  //盘点库存量
    '(ifnull(j.RCK_AMOUNT,0)-ifnull(j.CHK_AMOUNT,0))*1.00/case when B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as PAL_AMOUNT,'+  //盈亏数量
    ' b.GODS_NAME as GODS_NAME,b.GODS_CODE as GODS_CODE,'+
    ' b.NEW_INPRICE*1.00/case when B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as NEW_INPRICE,'+
    ' b.NEW_OUTPRICE*1.00/case when B.UNIT_ID=B.SMALL_UNITS then B.SMALLTO_CALC when B.UNIT_ID=B.BIG_UNITS then B.BIGTO_CALC else 1 end as NEW_OUTPRICE,'+
    ' (ifnull(j.RCK_AMOUNT,0)-ifnull(j.CHK_AMOUNT,0))*ifnull(b.NEW_INPRICE,0) as PAL_INAMONEY,'+
    ' (ifnull(j.RCK_AMOUNT,0)-ifnull(j.CHK_AMOUNT,0))*ifnull(b.NEW_OUTPRICE,0) as PAL_OUTAMONEY  '+
    ' from STO_PRINTDATA j '+
    ' left outer join VIW_GOODSPRICEEXT b on j.TENANT_ID=b.TENANT_ID and j.SHOP_ID=b.SHOP_ID and j.GODS_ID=b.GODS_ID '+
    ' where j.TENANT_ID=:TENANT_ID and j.SHOP_ID=:SHOP_ID and j.PRINT_DATE=:PRINT_DATE and CHECK_STATUS=''2'' '+
    ' order by b.GODS_CODE');
end;

{ TCheckOrder }

function TPrintOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  if not lock and not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,true) then Raise Exception.Create('当前单据已经被另一用户修改，你不能再保存。');
  result := true;
  if not lock then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select CHK_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE';
         rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
         rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
         rs.ParamByName('PRINT_DATE').AsInteger := FieldbyName('PRINT_DATE').AsOldInteger;
         AGlobal.Open(rs);
         if rs.Fields[0].AsString <> '' then Raise Exception.Create('已经审核了不能删除...');  
       finally
         rs.Free;
       end;
       AGlobal.ExecSQL('delete from STO_PRINTDATA where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PRINT_DATE=:OLD_PRINT_DATE',self); 
       AGlobal.ExecSQL('delete from STO_CHECKDATA where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PRINT_DATE=:OLD_PRINT_DATE',self); 
     end;
end;

function TPrintOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
end;

function TPrintOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
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

function TPrintOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;comm:boolean=true): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from STO_PRINTORDER where SHOP_ID='''+FieldbyName('SHOP_ID').AsString+''' and PRINT_DATE='+FieldbyName('PRINT_DATE').AsString+' and TENANT_ID='+FieldbyName('TENANT_ID').AsString;
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and (copy(rs.Fields[1].asString,1,1)='1') then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TPrintOrder.InitClass;
var
  Str: string;
begin
  inherited;
  lock := false;
  SelectSQL.Text:=
    'select jc.*,c.USER_NAME as CREA_USER_TEXT,d.USER_NAME as CHK_USER_TEXT from ('+
    ' select TENANT_ID,SHOP_ID,PRINT_DATE,CHECK_STATUS,CHECK_TYPE,CREA_DATE,CREA_USER,CHK_USER,CHK_DATE,COMM,TIME_STAMP from STO_PRINTORDER '+
    ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PRINT_DATE=:PRINT_DATE) jc '+
    ' left outer join VIW_USERS c on jc.TENANT_ID=c.TENANT_ID and jc.CREA_USER=c.USER_ID '+
    ' left outer join VIW_USERS d on jc.TENANT_ID=d.TENANT_ID and jc.CHK_USER=d.USER_ID ';
    
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
  case iDbType of
   0,3:SelectSQL.Text :='select top 1 PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and PRINT_DATE<:PRINT_DATE order by PRINT_DATE desc ';
   1: SelectSQL.Text := 'select * from (select ROWNUM,PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and PRINT_DATE<:PRINT_DATE order by PRINT_DATE desc) where ROWNUM<2 ';
   4: SelectSQL.Text := 'select * from (select PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and PRINT_DATE<:PRINT_DATE order by PRINT_DATE desc) tp fetch first 1 rows only';
   5: SelectSQL.Text := 'select PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and PRINT_DATE<:PRINT_DATE order by PRINT_DATE desc DESC limit 1';
  end;
end;

{ TCheckOrderGetNext }

procedure TPrintOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
   0,3:SelectSQL.Text :='select top 1 PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and PRINT_DATE>:PRINT_DATE order by PRINT_DATE';
   1:SelectSQL.Text := 'select * from (select ROWNUM,PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and PRINT_DATE<:PRINT_DATE order by PRINT_DATE desc) where ROWNUM<2 ';
   4:SelectSQL.Text := 'select * from (select PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and PRINT_DATE>:PRINT_DATE order by PRINT_DATE) tp fetch first 1 rows only';
   5:SelectSQL.Text := 'select PRINT_DATE from STO_PRINTORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and PRINT_DATE>:PRINT_DATE order by PRINT_DATE limit 1';
  end;
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

{== 参数：Params
  AUDIT_FLAG：0表示对于没录入盘点商品库存设置为0; 为1不作处理　
  TENANT_ID: 企业ID
  SHOP_ID:   门店ID
  CHK_USER: 审核人
  PRINT_DATE: 盘点单据号（日期）[相当于原来: PRINT_ID]
 }

function TPrintOrderAudit.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  rs,ts: TZQuery;
  SQL,id,gid,s,CurDate,CurTime,User: string;
  r,w:integer;
  cb,CHANGE_AMT,CHANGE_MNY: real;  //成本价 |调整数量 |调整金额
begin
  GetAccountRange(AGlobal,Params.ParambyName('TENANT_ID').asString,Params.ParambyName('SHOP_ID').asString,Params.ParambyName('PRINT_DATE').asString);
  //参数: Params.ParambyName('AUDIT_FLAG').asString 界面UI传过来的的作为，为0表示对于没录入盘点商品库存设置为0，为1其它表示不处理;
  rs := TZQuery.Create(nil);
  ts := TZQuery.Create(nil);
  try
    CHANGE_AMT:=0;
    CHANGE_MNY:=0;
    SQL:='select * from ('+
      'select A.TENANT_ID as TENANT_ID,A.SHOP_ID as SHOP_ID,A.GODS_ID as GODS_ID,B.CALC_UNITS as UNIT_ID,A.PROPERTY_01 as PROPERTY_01,'+
      'A.PROPERTY_02 as PROPERTY_02,A.BATCH_NO as BATCH_NO, '+
      '(case when CHECK_STATUS=''1'' then case when '+Params.ParambyName('AUDIT_FLAG').asString+
                    '=0 then ifnull(A.RCK_AMOUNT,0) else 0 end else ifnull(A.RCK_AMOUNT,0)-ifnull(A.CHK_AMOUNT,0) end) as MDI_AMOUNT,'+
      ' ifnull(A.CHK_AMOUNT,0) as CHK_AMOUNT,ifnull(A.RCK_AMOUNT,0) as RCK_AMOUNT,B.NEW_OUTPRICE '+
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
      id := NewId(Params.ParambyName('SHOP_ID').asString);
      User:=trim(Params.ParambyName('CHK_USER').asString);
      CurDate:=trim(FormatDatetime('YYYY-MM-DD',Date()));
      CurTime:=trim(FormatDatetime('YYYY-MM-DD HH:MM:SS',Now()));
      gid := trimright(Params.ParambyName('SHOP_ID').AsString,4)+GetSequence(AGlobal,'GNO_3_'+Params.ParambyName('SHOP_ID').asString,Params.ParambyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);
      if not rs.IsEmpty then
      begin
        AGlobal.ExecSQL('insert into STO_CHANGEORDER(CHANGE_ID,GLIDE_NO,TENANT_ID,SHOP_ID,CHANGE_DATE,CHANGE_TYPE,CHANGE_CODE,DUTY_USER,REMARK,CHK_USER,CHK_DATE,FROM_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
                        'select '''+id+''','''+gid+''',TENANT_ID,SHOP_ID,PRINT_DATE,''2'',''1'','''+User+''',''盘点损益'','''+User+''','''+CurDate+''','+IntToVarchar(AGlobal,'PRINT_DATE')+','''+CurTime+''','''+User+''',''00'','+GetTimeStamp(AGlobal.iDbType)+' '+
                        'from STO_PRINTORDER where TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' and '+
                        ' SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and PRINT_DATE='+Params.ParambyName('PRINT_DATE').asString+' ');

        //盘点明细数据插入调整单明细:
        rs.First;
        while not rs.Eof do
          begin
            cb := GetCostPrice(AGlobal,rs.FieldbyName('TENANT_ID').AsString,rs.FieldbyName('SHOP_ID').AsString,
                                       rs.FieldbyName('GODS_ID').AsString,
                                       rs.FieldbyName('BATCH_NO').AsString);
            AGlobal.ExecSQL('insert into STO_CHANGEDATA(TENANT_ID,SHOP_ID,SEQNO,CHANGE_ID,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,UNIT_ID,AMOUNT,COST_PRICE,APRICE,AMONEY,CALC_MONEY,IS_PRESENT,CALC_AMOUNT,REMARK) '+
                            'values('+
                            ''+Params.ParambyName('TENANT_ID').asString+','+
                            ''''+Params.ParambyName('SHOP_ID').asString+''','+inttostr(rs.RecNo+1)+','''+id+''','+
                            ''''+rs.FieldbyName('GODS_ID').AsString+''','+
                            ''''+rs.FieldbyName('BATCH_NO').AsString+''','+
                            ''''+rs.FieldbyName('PROPERTY_01').AsString+''','+
                            ''''+rs.FieldbyName('PROPERTY_02').AsString+''','+
                            ''''+rs.FieldbyName('UNIT_ID').AsString+''','+
                            ''+floattostr(rs.FieldbyName('MDI_AMOUNT').AsFloat)+','+
                            ''+formatfloat('#0.000000',cb)+','+
                            ''+formatfloat('#0.000',rs.FieldbyName('NEW_OUTPRICE').AsFloat)+','+
                            ''+formatfloat('#0.00',rs.FieldbyName('NEW_OUTPRICE').AsFloat*rs.FieldbyName('MDI_AMOUNT').AsFloat)+','+
                            ''+formatfloat('#0.00',rs.FieldbyName('NEW_OUTPRICE').AsFloat*rs.FieldbyName('MDI_AMOUNT').AsFloat)+','+
                            '0,'+   //是否是赠品[盘点单没字段，默认为:0]
                            ''+floattostr(rs.FieldbyName('MDI_AMOUNT').AsFloat)+','+
                            '''盘点损益:'+rs.FieldbyName('RCK_AMOUNT').AsString+'->'+rs.FieldbyName('CHK_AMOUNT').AsString+''''+
                            ')'
                           );

            DecStorage(AGlobal,
                       rs.FieldbyName('TENANT_ID').asString,
                       rs.FieldbyName('SHOP_ID').asString,
                       rs.FieldbyName('GODS_ID').asString,
                       rs.FieldbyName('PROPERTY_01').asString,
                       rs.FieldbyName('PROPERTY_02').asString,
                       rs.FieldbyName('BATCH_NO').asString,
                       rs.FieldbyName('MDI_AMOUNT').asFloat,
                       roundto(rs.FieldbyName('MDI_AMOUNT').asFloat*cb,-2),3);
            //计算累计数量和累计金额:
            CHANGE_AMT:=CHANGE_AMT+rs.FieldbyName('MDI_AMOUNT').AsFloat;
            CHANGE_MNY:=CHANGE_MNY+roundto(rs.FieldbyName('MDI_AMOUNT').AsFloat*cb,-2);
            rs.Next;
          end;
      end;

      //更新调整单明细汇总数据
      AGlobal.ExecSQL('update STO_CHANGEORDER set CHANGE_AMT='+FloattoStr(CHANGE_AMT)+',CHANGE_MNY='+FloattoStr(CHANGE_MNY)+' '+
                      ' where TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' and CHANGE_ID='''+id+''' ');

      r := AGlobal.ExecSQL('update STO_PRINTORDER set CHECK_STATUS=3,CHK_USER='''+User+''',CHK_DATE='''+CurDate+''' where TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' and '+
                           ' SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and PRINT_DATE='+Params.ParambyName('PRINT_DATE').asString+' and CHECK_STATUS<>3');
      if r=0 then Raise Exception.Create('没找到待审核的盘点单，是否由另一用户审核完毕？');
      if not IsZero(AGlobal,Params) then
      begin
        ts.Close;
        ts.SQL.Text :=
            'select jp2.*,p2.COLOR_NAME as COLOR_NAME from ('+
            'select jp1.*,p1.SIZE_NAME as SIZE_NAME from ('+
            'select j.TENANT_ID as TENANT_ID,b.GODS_CODE,b.GODS_NAME,B.SORT_ID7,B.SORT_ID8,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO  from ('+
            'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.BATCH_NO from STO_STORAGE A,STO_CHANGEDATA B '+
            'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 and A.BATCH_NO=B.BATCH_NO '+
            ' and A.AMOUNT<0 and B.CHANGE_ID='''+id+''' and B.TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' '+
            ') j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
            ') jp1 left outer join VIW_SIZE_INFO p1 on jp1.TENANT_ID=p1.TENANT_ID and jp1.SORT_ID7=p1.SIZE_ID '+
            ') jp2 left outer join VIW_COLOR_INFO p2 on jp2.TENANT_ID=p2.TENANT_ID and jp2.SORT_ID8=p2.COLOR_ID ';
        AGlobal.Open(ts);
        w := 0;
        s := '';
        rs.first;
        while not ts.Eof do
          begin
            inc(w);
            if s<>'' then s := s + #10;
            s := s +'('+ts.FieldbyName('GODS_CODE').AsString+')'+ts.FieldbyName('GODS_NAME').AsString;
            if ts.FieldbyName('SIZE_NAME').AsString <> '' then
               s := s+ '  尺码:'+ts.FieldbyName('SIZE_NAME').AsString+'';
            if ts.FieldbyName('COLOR_NAME').AsString <> '' then
               s := s+ '  颜色:'+ts.FieldbyName('COLOR_NAME').AsString+'';
            if ts.FieldbyName('BATCH_NO').AsString <> '#' then
               s := s+ '  批号:'+ts.FieldbyName('BATCH_NO').AsString+'';
            if w>5 then break;
            ts.Next;
          end;
        if s<>'' then
          Raise Exception.Create(s+#10+'--商品库存不足,请核对是否输入正确？');
      end;
      //2010.02.24 SQLITE数据库没有日志表
      // WriteLogInfo(AGlobal,Params.ParambyName('CHK_USER').AsString,2,'600020','审核【盘点日期'+Params.ParambyName('PRINT_ID').asString+'】','生成损益单【单号'+gid+'】');
      AGlobal.CommitTrans;
      MSG := '审核的盘点单完毕...';
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

function TPrintOrderAudit.IntToVarchar(AGlobal:IdbHelp; FieldName: string): string;
begin
  result:=trim(FieldName);
  case AGlobal.iDbType of
   0,5: result:='cast('+FieldName+' as varchar)';
   1: result:='cast('+FieldName+' as varchar(10))';
   4: result:='trim(char('+FieldName+'))';
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
    GetAccountRange(AGlobal,Params.ParambyName('TENANT_ID').asString,Params.ParambyName('SHOP_ID').asString,Params.ParambyName('PRINT_DATE').asString);

    rs.Close;
    rs.SQL.Text := 'select COMM,CHANGE_ID,TENANT_ID,SHOP_ID,CHANGE_DATE from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and FROM_ID=:PRINT_DATE and CHANGE_CODE=''1'' ';
    rs.Params.AssignValues(Params);
    AGlobal.Open(rs);
    if copy(rs.FieldByName('COMM').AsString,1,2)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
    AGlobal.BeginTrans;
    try
      Change_ID:=trim(rs.fieldbyName('CHANGE_ID').AsString);
      ts.Close;
      ts.SQL.Text := 'select TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,IS_PRESENT,CALC_AMOUNT,COST_PRICE from STO_CHANGEDATA where TENANT_ID=:TENANT_ID and CHANGE_ID='''+rs.FieldbyName('CHANGE_ID').AsString+''' ';
      ts.Params.AssignValues(Params);
      AGlobal.Open(ts);
      ts.First;
      while not ts.Eof do
        begin
          IncStorage(AGlobal,
                     ts.FieldbyName('TENANT_ID').asString,
                     ts.FieldbyName('SHOP_ID').asString,
                     ts.FieldbyName('GODS_ID').asString,
                     ts.FieldbyName('PROPERTY_01').asString,
                     ts.FieldbyName('PROPERTY_02').asString,
                     ts.FieldbyName('BATCH_NO').asString,
                     ts.FieldbyName('CALC_AMOUNT').asFloat,
                     roundto(ts.FieldbyName('CALC_AMOUNT').asFloat*ts.FieldbyName('COST_PRICE').asFloat,-2),3);
          ts.Next;
        end;
      AGlobal.ExecSQL('delete from STO_CHANGEDATA where TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' and '+
                      ' CHANGE_ID='''+rs.FieldbyName('CHANGE_ID').AsString+'''');
      AGlobal.ExecSQL('delete from STO_CHANGEORDER where TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' and '+
                      ' CHANGE_ID='''+rs.FieldbyName('CHANGE_ID').AsString+'''');
      r:=AGlobal.ExecSQL('update STO_PRINTORDER set CHECK_STATUS=2,CHK_USER=null,CHK_DATE=null where TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' and '+
                         ' SHOP_ID='''+Params.ParambyName('SHOP_ID').asString+''' and PRINT_DATE='+Params.ParambyName('PRINT_DATE').asString+' and CHECK_STATUS=3');
      if r=0 then Raise Exception.Create('没找到已审核的盘点单，是否由另一用户审核完毕？');
      
      if not IsZero(AGlobal,Params) then
      begin
        ts.Close;
        ts.SQL.Text :=
            'select jp2.*,p2.COLOR_NAME as COLOR_NAME from ('+
            'select jp1.*,p1.SIZE_NAME as SIZE_NAME from ('+
            'select J.TENANT_ID,b.GODS_CODE,b.GODS_NAME,B.SORT_ID7,B.SORT_ID8,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO  from ('+
            'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.PROPERTY_01,A.PROPERTY_02,A.BATCH_NO from STO_STORAGE A,STO_CHANGEDATA B '+
            'where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and A.PROPERTY_01=B.PROPERTY_01 and A.PROPERTY_02=B.PROPERTY_02 and A.BATCH_NO=B.BATCH_NO '+
            ' and A.AMOUNT<0 and B.CHANGE_ID='''+Change_ID+''' and B.TENANT_ID='+Params.ParambyName('TENANT_ID').asString+' '+
            ') j left outer join VIW_GOODSINFO b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
            ') jp1 left outer join VIW_SIZE_INFO p1 on jp1.TENANT_ID=p1.TENANT_ID and jp1.SORT_ID7=p1.SIZE_ID '+
            ') jp2 left outer join VIW_COLOR_INFO p2 on jp2.TENANT_ID=p2.TENANT_ID and jp2.SORT_ID8=p2.COLOR_ID ';
        AGlobal.Open(ts);
        w := 0;
        s := '';
        rs.first;
        while not ts.Eof do
          begin
            inc(w);
            if s<>'' then s := s + #10;
            s := s +'('+ts.FieldbyName('GODS_CODE').AsString+')'+ts.FieldbyName('GODS_NAME').AsString;
            // if ts.FieldbyName('IS_PRESENT').AsString='1' then s := s + '(赠品)';
            if ts.FieldbyName('SIZE_NAME').AsString <> '' then
               s := s+ '  尺码:'+ts.FieldbyName('SIZE_NAME').AsString+'';
            if ts.FieldbyName('COLOR_NAME').AsString <> '' then
               s := s+ '  颜色:'+ts.FieldbyName('COLOR_NAME').AsString+'';
            if ts.FieldbyName('BATCH_NO').AsString <> '#' then
               s := s+ '  批号:'+ts.FieldbyName('BATCH_NO').AsString+'';
            if w>5 then break;
            ts.Next;
          end;
        if s<>'' then
          Raise Exception.Create(s+#10+'--商品库存不足,请核对是否输入正确？');
      end;
      //2010.02.24 SQLITE数据库没有日志表
      // WriteLogInfo(AGlobal,Params.ParambyName('CHK_USER').AsString,2,'600020','弃审【盘点日期'+Params.ParambyName('PRINT_DATE').asString+'】','删除损益单【单号'+rs.FieldbyName('CHANGE_ID').AsString+'】');
      AGlobal.CommitTrans;
      MSG := '弃审盘点单完毕...';
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
