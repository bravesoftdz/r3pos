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
  'select TENANT_ID,LEVEL_ID,LEVELD_NAME,KPI_ID,LVL_AMT,LOW_RATE from MKT_KPI_LEVEL '+
  'where TENANT_ID=:TENANT_ID and LEVEL_ID=:LEVEL_ID and COMM not in (''02'',''12'') order by LEVEL_ID ';

  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_LEVEL(TENANT_ID,LEVEL_ID,LEVELD_NAME,KPI_ID,LVL_AMT,LOW_RATE,COMM,TIME_STAMP) '+
         ' VALUES(:TENANT_ID,:LEVEL_ID,:LEVELD_NAME,:KPI_ID,:LVL_AMT,:LOW_RATE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_KPI_LEVEL set TENANT_ID=:TENANT_ID,LEVEL_ID=:LEVEL_ID,LEVELD_NAME=:LEVELD_NAME,KPI_ID=:KPI_ID,LVL_AMT=:LVL_AMT,LOW_RATE=:LOW_RATE,COMM='+GetCommStr(iDbType)+
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

initialization
  RegisterClass(TKpiIndex);
  RegisterClass(TKpiLevel);
  RegisterClass(TKpiGoods);
  RegisterClass(TKpiTimes);
finalization
  UnRegisterClass(TKpiIndex);
  UnRegisterClass(TKpiLevel);
  UnRegisterClass(TKpiGoods);
  UnRegisterClass(TKpiTimes);

end.
