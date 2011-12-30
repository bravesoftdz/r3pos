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
  TKpiOption=class(TZFactory)
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
  'select TENANT_ID,KPI_ID,KPI_NAME,IDX_TYPE,KPI_TYPE,KPI_DATA,KPI_CALC,KPI_AGIO,KPI_OPTN,REMARK from MKT_KPI_INDEX '+
  'where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') ';

  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_INDEX(TENANT_ID,KPI_ID,KPI_NAME,IDX_TYPE,KPI_TYPE,KPI_DATA,KPI_CALC,KPI_AGIO,KPI_OPTN,REMARK,COMM,TIME_STAMP) '+
         ' VALUES(:TENANT_ID,:KPI_ID,:KPI_NAME,:IDX_TYPE,:KPI_TYPE,:KPI_DATA,:KPI_CALC,:KPI_AGIO,:KPI_OPTN,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_KPI_INDEX set TENANT_ID=:TENANT_ID,KPI_ID=:KPI_ID,KPI_NAME=:KPI_NAME,IDX_TYPE=:IDX_TYPE,KPI_TYPE=:KPI_TYPE,'+
         'KPI_DATA=:KPI_DATA,KPI_CALC=:KPI_CALC,KPI_AGIO=:KPI_AGIO,KPI_OPTN=:KPI_OPTN,REMARK=:REMARK,COMM='+GetCommStr(iDbType)+
         ',TIME_STAMP='+GetTimeStamp(iDbType)+' where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID ';
  UpdateSQL.Add( Str);
  Str := 'update MKT_KPI_INDEX set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Add( Str);

end;

{ TKpiOption }

function TKpiOption.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiOption.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiOption.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TKpiOption.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TKpiOption.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;KPI_ID;KPI_LV;SEQNO';
  SelectSQL.Text :=
  'select TENANT_ID,KPI_ID,KPI_LV,SEQNO,KPI_RATE,KPI_AMT,KPI_DATE1,KPI_DATE2,KPI_AGIO,USING_BRRW from MKT_KPI_OPTION '+
  'where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') order by KPI_LV,SEQNO ';

  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_OPTION(TENANT_ID,KPI_ID,KPI_LV,SEQNO,KPI_RATE,KPI_AMT,KPI_DATE1,KPI_DATE2,KPI_AGIO,USING_BRRW,COMM,TIME_STAMP) '+
         ' VALUES(:TENANT_ID,:KPI_ID,:KPI_LV,:SEQNO,:KPI_RATE,:KPI_AMT,:KPI_DATE1,:KPI_DATE2,:KPI_AGIO,:USING_BRRW,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_KPI_OPTION set TENANT_ID=:TENANT_ID,KPI_ID=:KPI_ID,KPI_LV=:KPI_LV,SEQNO=:SEQNO,KPI_RATE=:KPI_RATE,KPI_AMT=:KPI_AMT,'+
         'KPI_DATE1=:KPI_DATE1,KPI_DATE2=:KPI_DATE2,KPI_AGIO=:KPI_AGIO,USING_BRRW=:USING_BRRW,COMM='+GetCommStr(iDbType)+
         ',TIME_STAMP='+GetTimeStamp(iDbType)+' where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID and KPI_LV=:OLD_KPI_LV and SEQNO=:OLD_SEQNO ';
  UpdateSQL.Add( Str);
  Str := 'delete from MKT_KPI_OPTION where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID and KPI_LV=:OLD_KPI_LV and SEQNO=:OLD_SEQNO ';
  DeleteSQL.Add( Str);
end;

initialization
  RegisterClass(TKpiIndex);
  RegisterClass(TKpiOption);
  RegisterClass(TKpiGoods);
finalization
  UnRegisterClass(TKpiIndex);
  UnRegisterClass(TKpiOption);
  UnRegisterClass(TKpiGoods);

end.
