unit ObjKpiIndex;

interface
uses SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TKpiIndex=class(TZFactory)
  private
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TKpiLevel=class(TZFactory)
  private
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TKpiGoods=class(TZFactory)
  private
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TKpiTimes=class(TZFactory)
  private
    procedure InitClass; override;
  end;

  //2012.03.07xhh add考核指标的档次
  TKpiSeqNo=class(TZFactory)
  private
    procedure InitClass; override;
  end;

  //2012.03.07xhh add考核内容填报
  TKpiRatio=class(TZFactory)
  private
    procedure InitClass; override;
  end;
  


implementation

{ TKpiGoods }

function TKpiGoods.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiGoods.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiGoods.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiGoods.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TKpiGoods.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;KPI_ID;GODS_ID';
  SelectSQL.Text :=
  'select a.TENANT_ID,a.KPI_ID,a.GODS_ID,a.UNIT_ID,b.GODS_NAME,b.GODS_CODE,b.BARCODE from MKT_KPI_GOODS a left join VIW_GOODSINFO b '+
  ' on a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID where a.TENANT_ID=:TENANT_ID and a.KPI_ID=:KPI_ID and a.COMM not in (''02'',''12'')';

  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_GOODS(TENANT_ID,KPI_ID,GODS_ID,UNIT_ID,COMM,TIME_STAMP)  VALUES(:TENANT_ID,:KPI_ID,:GODS_ID,:UNIT_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_KPI_GOODS set TENANT_ID=:TENANT_ID,KPI_ID=:KPI_ID,GODS_ID=:GODS_ID,UNIT_ID=:UNIT_ID,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID';
  UpdateSQL.Add( Str);
  Str := 'delete from MKT_KPI_GOODS where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID';
  DeleteSQL.Add( Str);
end;


{ TKpiIndex }

function TKpiIndex.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str: String;
    rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from MKT_PLANDATA where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
    rs.ParamByName('KPI_ID').AsString := FieldbyName('KPI_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger>0 then
      Raise Exception.Create('指标"'+FieldbyName('KPI_NAME').AsString+'"存在销售计划明细中,不能删除!');

  finally
    rs.Free;
  end;
  Result := True;
end;

function TKpiIndex.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from MKT_KPI_INDEX where COMM not in (''02'',''12'') and KPI_NAME=:KPI_NAME and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('KPI_NAME').AsString := FieldByName('KPI_NAME').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create(FieldbyName('KPI_NAME').AsString+'指标名称已经被使用，请重取新的指标名称...');
  finally
    rs.Free;
  end;
  Result:=True;
end;

function TKpiIndex.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from MKT_KPI_INDEX where COMM not in (''02'',''12'') and KPI_ID<>:OLD_KPI_ID and KPI_NAME=:KPI_NAME and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('KPI_NAME').AsString := FieldByName('KPI_NAME').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('OLD_KPI_ID').AsString := FieldByName('KPI_ID').AsOldString;

    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create(FieldbyName('KPI_NAME').AsString+'指标名称已经被使用，请重取新的指标名称...');
  finally
    rs.Free;
  end;
  Result:=True;
end;

function TKpiIndex.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TKpiIndex.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;KPI_ID';
  SelectSQL.Text :=
  'select TENANT_ID,KPI_ID,KPI_NAME,KPI_SPELL,UNIT_NAME,IDX_TYPE,KPI_TYPE,0 as GOODS_SUM,REMARK from MKT_KPI_INDEX '+
  'where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') ';

  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_INDEX(TENANT_ID,KPI_ID,KPI_NAME,KPI_SPELL,UNIT_NAME,IDX_TYPE,KPI_TYPE,REMARK,COMM,TIME_STAMP) '+
         ' VALUES(:TENANT_ID,:KPI_ID,:KPI_NAME,:KPI_SPELL,:UNIT_NAME,:IDX_TYPE,:KPI_TYPE,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_KPI_INDEX set TENANT_ID=:TENANT_ID,KPI_ID=:KPI_ID,KPI_NAME=:KPI_NAME,UNIT_NAME=:UNIT_NAME,IDX_TYPE=:IDX_TYPE,KPI_TYPE=:KPI_TYPE,'+
         'KPI_SPELL=:KPI_SPELL,REMARK=:REMARK,COMM='+GetCommStr(iDbType)+
         ',TIME_STAMP='+GetTimeStamp(iDbType)+' where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID ';
  UpdateSQL.Add( Str);
  Str := 'update MKT_KPI_INDEX set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Add( Str);
end;

{ TKpiLevel }

function TKpiLevel.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiLevel.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiLevel.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiLevel.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TKpiLevel.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;LEVEL_ID';
  SelectSQL.Text :=
  'select TENANT_ID,LEVEL_ID,LEVEL_NAME,KPI_ID,LVL_AMT,LOW_RATE,0 as LEVEL_Rows from MKT_KPI_LEVEL '+
  'where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') order by LEVEL_ID ';

  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_LEVEL(TENANT_ID,LEVEL_ID,LEVEL_NAME,KPI_ID,LVL_AMT,LOW_RATE,COMM,TIME_STAMP) '+
         ' VALUES(:TENANT_ID,:LEVEL_ID,:LEVEL_NAME,:KPI_ID,:LVL_AMT,:LOW_RATE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_KPI_LEVEL set TENANT_ID=:TENANT_ID,LEVEL_ID=:LEVEL_ID,LEVEL_NAME=:LEVEL_NAME,KPI_ID=:KPI_ID,LVL_AMT=:LVL_AMT,LOW_RATE=:LOW_RATE,COMM='+GetCommStr(iDbType)+
         ',TIME_STAMP='+GetTimeStamp(iDbType)+' where LEVEL_ID=:OLD_LEVEL_ID and TENANT_ID=:OLD_TENANT_ID ';
  UpdateSQL.Add( Str);
  Str := 'delete from MKT_KPI_LEVEL where LEVEL_ID=:OLD_LEVEL_ID and TENANT_ID=:OLD_TENANT_ID ';
  DeleteSQL.Add( Str);
end;

{ TKpiTimes }

procedure TKpiTimes.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;TIMES_ID';
  SelectSQL.Text :=
  ' select TENANT_ID,TIMES_ID,KPI_ID,TIMES_NAME,SEQNO,KPI_DATE1,KPI_DATE2,USING_BRRW,KPI_FLAG, '+
  ' KPI_DATA,KPI_CALC,RATIO_TYPE,COMM,TIME_STAMP from MKT_KPI_TIMES '+
  ' where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') order by SEQNO ';
  IsSQLUpdate := True;
  Str := ' insert into MKT_KPI_TIMES(TENANT_ID,TIMES_ID,KPI_ID,TIMES_NAME,SEQNO,KPI_DATE1,KPI_DATE2,USING_BRRW,KPI_FLAG, '+
  ' KPI_DATA,KPI_CALC,RATIO_TYPE,COMM,TIME_STAMP) VALUES(:TENANT_ID,:TIMES_ID,:KPI_ID,:TIMES_NAME,:SEQNO,:KPI_DATE1,'+
  ' :KPI_DATE2,:USING_BRRW,:KPI_FLAG,:KPI_DATA,:KPI_CALC,:RATIO_TYPE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := ' update MKT_KPI_TIMES set TENANT_ID=:TENANT_ID,TIMES_ID=:TIMES_ID,KPI_ID=:KPI_ID,TIMES_NAME=:TIMES_NAME,SEQNO=:SEQNO,'+
  'KPI_DATE1=:KPI_DATE1,KPI_DATE2=:KPI_DATE2,USING_BRRW=:USING_BRRW,KPI_FLAG=:KPI_FLAG,KPI_DATA=:KPI_DATA,KPI_CALC=:KPI_CALC,'+
  'RATIO_TYPE=:RATIO_TYPE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TIMES_ID=:OLD_TIMES_ID and TENANT_ID=:OLD_TENANT_ID ';
  UpdateSQL.Add( Str);
  Str := ' delete from MKT_KPI_TIMES where TIMES_ID=:OLD_TIMES_ID and TENANT_ID=:OLD_TENANT_ID ';
  DeleteSQL.Add( Str);
end;

{ TKpiSeqNo }

procedure TKpiSeqNo.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;SEQNO_ID';
  SelectSQL.Text :=
    'select a.TENANT_ID as TENANT_ID,'+
          ' a.SEQNO_ID as SEQNO_ID,'+
          ' a.SEQNO as SEQNO,'+
          ' a.KPI_ID as KPI_ID,'+
          ' a.LEVEL_ID as LEVEL_ID,'+
          ' a.TIMES_ID as TIMES_ID,'+
          ' a.KPI_AMT as KPI_AMT,'+
          ' b.LEVEL_NAME as LEVEL_NAME,'+
          ' b.LVL_AMT as LVL_AMT,'+
          ' b.LOW_RATE as LOW_RATE,'+
          ' c.TIMES_NAME as TIMES_NAME,'+
          ' c.KPI_DATE1 as KPI_DATE1,'+
          ' c.KPI_DATE2 as KPI_DATE2,'+
          ' c.USING_BRRW as USING_BRRW,'+
          ' c.KPI_FLAG as KPI_FLAG,'+
          ' c.KPI_DATA as KPI_DATA,'+
          ' c.KPI_CALC as KPI_CALC,'+
          ' c.RATIO_TYPE as RATIO_TYPE '+
    ' from MKT_KPI_SEQNO a '+
    ' left outer join MKT_KPI_LEVEL b on a.tenant_id=b.tenant_id and a.LEVEL_ID=b.LEVEL_ID '+
    ' left outer join MKT_KPI_TIMES c on a.tenant_id=c.tenant_id and a.TIMES_ID=c.TIMES_ID '+
    ' where a.TENANT_ID=:TENANT_ID and a.KPI_ID=:KPI_ID '+
    ' order by a.SEQNO';
  Str :=
    'insert into MKT_KPI_SEQNO (TENANT_ID,SEQNO_ID,KPI_ID,LEVEL_ID,TIMES_ID,SEQNO,KPI_AMT,COMM,TIME_STAMP) '+
    ' values(:TENANT_ID,:SEQNO_ID,:KPI_ID,:LEVEL_ID,:TIMES_ID,:SEQNO,:KPI_AMT,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);
  Str :=
    'update MKT_KPI_SEQNO '+
    ' set TENANT_ID=:TENANT_ID,SEQNO_ID=:SEQNO_ID,KPI_ID=:KPI_ID,LEVEL_ID=:LEVEL_ID,TIMES_ID=:TIMES_ID,'+
    ' KPI_AMT=:KPI_AMT,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and SEQNO_ID=:OLD_SEQNO_ID and KPI_ID=:OLD_KPI_ID ';
  UpdateSQL.Add( Str);
  Str:=
    'update MKT_KPI_TIMES set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and SEQNO_ID=:OLD_SEQNO_ID';
  DeleteSQL.Add( Str);
end;

{ TKpiRatio }

procedure TKpiRatio.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;RATIO_ID';
  SelectSQL.Text :=
    'select a.TENANT_ID as TENANT_ID,'+
          ' a.RATIO_ID as RATIO_ID,'+
          ' a.KPI_ID as KPI_ID,'+
          ' a.LEVEL_ID as LEVEL_ID,'+
          ' a.TIMES_ID as TIMES_ID,'+
          ' a.SEQNO_ID as SEQNO_ID,'+
          ' a.GODS_ID as GODS_ID,'+
          ' a.UNIT_ID as UNIT_ID,'+
          ' a.KPI_RATIO as KPI_RATIO,'+
          ' b.SEQNO as SEQNO,'+
          ' b.KPI_AMT as KPI_AMT,'+
          ' c.LEVEL_NAME as LEVEL_NAME,'+
          ' c.LVL_AMT as LVL_AMT,'+
          ' c.LOW_RATE as LOW_RATE,'+
          ' d.TIMES_NAME as TIMES_NAME,'+
          ' d.KPI_DATE1 as KPI_DATE1,'+
          ' d.KPI_DATE2 as KPI_DATE2,'+
          ' d.USING_BRRW as USING_BRRW,'+
          ' d.KPI_FLAG as KPI_FLAG,'+
          ' d.KPI_DATA as KPI_DATA,'+
          ' d.KPI_CALC as KPI_CALC,'+
          ' d.RATIO_TYPE as RATIO_TYPE,'+
          ' e.GODS_NAME as GODS_NAME,'+
          ' f.UNIT_NAME as UNIT_NAME '+
    ' from MKT_KPI_RATIO a '+
    ' left outer join MKT_KPI_SEQNO b on a.tenant_id=b.tenant_id and a.SEQNO_ID=b.SEQNO_ID '+
    ' left outer join MKT_KPI_LEVEL c on a.tenant_id=c.tenant_id and a.LEVEL_ID=c.LEVEL_ID '+
    ' left outer join MKT_KPI_TIMES d on a.tenant_id=d.tenant_id and a.TIMES_ID=d.TIMES_ID '+
    ' left outer join VIW_GOODSINFO e on a.tenant_id=e.tenant_id and a.GODS_ID=e.GODS_ID '+
    ' left outer join VIW_MEAUNITS  f on a.tenant_id=f.tenant_id and a.UNIT_ID=f.UNIT_ID '+
    ' where a.TENANT_ID=:TENANT_ID and a.KPI_ID=:KPI_ID '+
    ' order by b.SEQNO';
  Str :=
    ' insert into MKT_KPI_RATIO(TENANT_ID,RATIO_ID,KPI_ID,LEVEL_ID,TIMES_ID,SEQNO_ID,GODS_ID,UNIT_ID,KPI_RATIO,COMM,TIME_STAMP)'+
    ' values(:TENANT_ID,:RATIO_ID,:KPI_ID,:LEVEL_ID,:TIMES_ID,:SEQNO_ID,:GODS_ID,:UNIT_ID,:KPI_RATIO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);
  Str :=
    'update MKT_KPI_RATIO '+
    ' set TENANT_ID=:TENANT_ID,RATIO_ID=:RATIO_ID,KPI_ID=:KPI_ID,LEVEL_ID=:LEVEL_ID,TIMES_ID=:TIMES_ID,'+
    ' SEQNO_ID=:SEQNO_ID,GODS_ID=:GODS_ID,UNIT_ID=:UNIT_ID,KPI_RATIO=:KPI_RATIO,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and RATIO_ID=:OLD_RATIO_ID and KPI_ID=:OLD_KPI_ID ';
  UpdateSQL.Add( Str);
  Str:=
    'update MKT_KPI_RATIO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and RATIO_ID=:OLD_RATIO_ID ';
  DeleteSQL.Add( Str);
end;

initialization
  RegisterClass(TKpiIndex);
  RegisterClass(TKpiLevel);
  RegisterClass(TKpiGoods);
  RegisterClass(TKpiTimes);
  RegisterClass(TKpiSeqNo);
  RegisterClass(TKpiRatio);

finalization
  UnRegisterClass(TKpiIndex);
  UnRegisterClass(TKpiLevel);
  UnRegisterClass(TKpiGoods);
  UnRegisterClass(TKpiTimes);
  UnRegisterClass(TKpiSeqNo);
  UnRegisterClass(TKpiRatio);  

end.
