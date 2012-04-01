unit ObjKpiIndex;

interface
uses SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  //考核指标
  TKpiIndex=class(TZFactory)
  private
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  //考核等级
  TKpiLevel=class(TZFactory)
  private
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  //考核商品
  TKpiGoods=class(TZFactory)
  private
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  //考核时段
  TKpiTimes=class(TZFactory)
  private
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  //2012.03.07xhh add考核指标的档次
  //考核档次
  TKpiSeqNo=class(TZFactory)
  private
    procedure InitClass; override;
  end;

  //2012.03.07xhh add考核内容填报
  //考核系数填报
  TKpiRatio=class(TZFactory)
  private
    procedure InitClass; override;
  end;

  //考核市场费计提系数
  TMktRatio=class(TZFactory)
  private
    procedure InitClass; override;
  end;

  //删除考核指标
  TKpiIndexDelete=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  


implementation


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

procedure TKpiIndex.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;KPI_ID';
  SelectSQL.Text :=
  'select TENANT_ID,KPI_ID,KPI_NAME,KPI_SPELL,UNIT_NAME,IDX_TYPE,KPI_TYPE,REMARK,0 as GOODS_SUM,COMM from MKT_KPI_INDEX '+
  'where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') ';

  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_INDEX(TENANT_ID,KPI_ID,KPI_NAME,KPI_SPELL,UNIT_NAME,IDX_TYPE,KPI_TYPE,REMARK,COMM,TIME_STAMP) '+
         ' VALUES(:TENANT_ID,:KPI_ID,:KPI_NAME,:KPI_SPELL,:UNIT_NAME,:IDX_TYPE,:KPI_TYPE,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_KPI_INDEX set TENANT_ID=:TENANT_ID,KPI_ID=:KPI_ID,KPI_NAME=:KPI_NAME,UNIT_NAME=:UNIT_NAME,IDX_TYPE=:IDX_TYPE,KPI_TYPE=:KPI_TYPE,'+
         'KPI_SPELL=:KPI_SPELL,REMARK=:REMARK,COMM='+GetCommStr(iDbType)+
         ',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and KPI_ID=:OLD_KPI_ID';
  UpdateSQL.Add( Str);
  //Str := 'update MKT_KPI_INDEX set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where KPI_ID=:OLD_KPI_ID and TENANT_ID=:OLD_TENANT_ID';
  Str :='delete from MKT_KPI_INDEX where TENANT_ID=:OLD_TENANT_ID and KPI_ID=:OLD_KPI_ID';
  DeleteSQL.Add( Str);
end;

{ TKpiLevel }

function TKpiLevel.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  //删除对应的档次中:
  Str:='delete from MKT_KPI_SEQNO where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID=:OLD_LEVEL_ID';
  AGlobal.ExecSQL(Str,self);
  //删除对应的系数中:
  Str:='delete from MKT_KPI_RATIO where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID=:OLD_LEVEL_ID';
  AGlobal.ExecSQL(Str,self);
end;

procedure TKpiLevel.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'TENANT_ID;LEVEL_ID';
  SelectSQL.Text :=
    'select TENANT_ID,LEVEL_ID,LEVEL_NAME,KPI_ID,LVL_AMT,LOW_RATE,0 as LEVEL_Rows from MKT_KPI_LEVEL '+
    'where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'') order by LEVEL_NAME ';

  IsSQLUpdate := True;
  Str := 'insert into MKT_KPI_LEVEL(TENANT_ID,LEVEL_ID,LEVEL_NAME,KPI_ID,LVL_AMT,LOW_RATE,COMM,TIME_STAMP) '+
         ' VALUES(:TENANT_ID,:LEVEL_ID,:LEVEL_NAME,:KPI_ID,:LVL_AMT,:LOW_RATE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_KPI_LEVEL '+
         ' set TENANT_ID=:TENANT_ID,LEVEL_ID=:LEVEL_ID,LEVEL_NAME=:LEVEL_NAME,KPI_ID=:KPI_ID,LVL_AMT=:LVL_AMT,LOW_RATE=:LOW_RATE,COMM='+GetCommStr(iDbType)+
         ',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' where TENANT_ID=:OLD_TENANT_ID and KPI_ID=:OLD_KPI_ID and LEVEL_ID=:OLD_LEVEL_ID';
  UpdateSQL.Add( Str);
  Str := 'delete from MKT_KPI_LEVEL where TENANT_ID=:OLD_TENANT_ID and LEVEL_ID=:OLD_LEVEL_ID';
  DeleteSQL.Add( Str);
end;

{ TKpiGoods }

function TKpiGoods.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  //删除对应的系数中:
  Str:='delete from MKT_KPI_RATIO where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID';
  AGlobal.ExecSQL(Str,self);
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
         ' where TENANT_ID=:OLD_TENANT_ID and KPI_ID=:OLD_KPI_ID and GODS_ID=:OLD_GODS_ID';
  UpdateSQL.Add( Str);
  Str := 'delete from MKT_KPI_GOODS where TENANT_ID=:OLD_TENANT_ID and KPI_ID=:OLD_KPI_ID and GODS_ID=:OLD_GODS_ID';
  DeleteSQL.Add( Str);
end; 

{ TKpiTimes }

function TKpiTimes.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  //删除对应的档次中:
  Str:='delete from MKT_KPI_SEQNO where TENANT_ID=:OLD_TENANT_ID and TIMES_ID=:OLD_TIMES_ID';
  AGlobal.ExecSQL(Str,self);
  //删除对应的系数中:
  Str:='delete from MKT_KPI_RATIO where TENANT_ID=:OLD_TENANT_ID and TIMES_ID=:OLD_TIMES_ID';
  AGlobal.ExecSQL(Str,self);
end;

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
  Str :=
    ' insert into MKT_KPI_TIMES(TENANT_ID,TIMES_ID,KPI_ID,TIMES_NAME,SEQNO,KPI_DATE1,KPI_DATE2,USING_BRRW,KPI_FLAG, '+
    ' KPI_DATA,KPI_CALC,RATIO_TYPE,COMM,TIME_STAMP) VALUES(:TENANT_ID,:TIMES_ID,:KPI_ID,:TIMES_NAME,:SEQNO,:KPI_DATE1,'+
    ' :KPI_DATE2,:USING_BRRW,:KPI_FLAG,:KPI_DATA,:KPI_CALC,:RATIO_TYPE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str :=
    ' update MKT_KPI_TIMES '+
    ' set TENANT_ID=:TENANT_ID,TIMES_ID=:TIMES_ID,KPI_ID=:KPI_ID,TIMES_NAME=:TIMES_NAME,SEQNO=:SEQNO,'+
    ' KPI_DATE1=:KPI_DATE1,KPI_DATE2=:KPI_DATE2,USING_BRRW=:USING_BRRW,KPI_FLAG=:KPI_FLAG,KPI_DATA=:KPI_DATA,KPI_CALC=:KPI_CALC,'+
    ' RATIO_TYPE=:RATIO_TYPE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and  and TIMES_ID=:OLD_TIMES_ID';
  UpdateSQL.Add( Str);
  Str := 'delete from MKT_KPI_TIMES where TENANT_ID=:OLD_TENANT_ID and TIMES_ID=:OLD_TIMES_ID';
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
    'select TENANT_ID,'+
          ' SEQNO_ID,'+
          ' SEQNO,'+
          ' KPI_ID,'+
          ' LEVEL_ID,'+
          ' TIMES_ID,'+
          ' KPI_AMT '+
    ' from MKT_KPI_SEQNO '+
    ' where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID '+
    ' order by SEQNO';
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
    //'update MKT_KPI_TIMES set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and SEQNO_ID=:OLD_SEQNO_ID';
  Str:='delete from MKT_KPI_SEQNO where TENANT_ID=:OLD_TENANT_ID and SEQNO_ID=:OLD_SEQNO_ID';
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
    'select TENANT_ID,'+
          ' RATIO_ID,'+
          ' KPI_ID,'+
          ' LEVEL_ID,'+
          ' TIMES_ID,'+
          ' SEQNO_ID,'+
          ' GODS_ID,'+
          ' UNIT_ID,'+
          ' KPI_RATIO '+
    ' from MKT_KPI_RATIO '+
    ' where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID '+
    ' order by LEVEL_ID';
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
    //'update MKT_KPI_RATIO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and RATIO_ID=:OLD_RATIO_ID ';
  Str:='delete from MKT_KPI_RATIO where TENANT_ID=:OLD_TENANT_ID and RATIO_ID=:OLD_RATIO_ID';
  DeleteSQL.Add( Str);
end;

{ TMktRatio }

procedure TMktRatio.InitClass;
var
  Str: string;
begin
  KeyFields:='TENANT_ID;ACTR_ID';
  SelectSQL.Text :=
    'select '+
    ' a.TENANT_ID as TENANT_ID,'+
    ' a.ACTR_ID as ACTR_ID,'+
    ' a.KPI_ID as KPI_ID,'+
    ' a.GODS_ID as GODS_ID,'+
    ' a.UNIT_ID as UNIT_ID,'+
    ' a.ACTR_RATIO as ACTR_RATIO,'+
    ' b.GODS_NAME as GODS_NAME,'+
    ' b.GODS_CODE as GODS_CODE,'+
    ' b.BARCODE as BARCODE '+
    ' from MKT_ACTIVE_RATIO a '+
    ' left join VIW_GOODSINFO b on a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID '+
    ' where a.TENANT_ID=:TENANT_ID and a.KPI_ID=:KPI_ID and a.COMM not in (''02'',''12'')';

  Str := 'insert into MKT_ACTIVE_RATIO(TENANT_ID,ACTR_ID,KPI_ID,GODS_ID,UNIT_ID,ACTR_RATIO,COMM,TIME_STAMP)'+
         ' VALUES(:TENANT_ID,:ACTR_ID,:KPI_ID,:GODS_ID,:UNIT_ID,:ACTR_RATIO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update MKT_ACTIVE_RATIO '+
         ' set TENANT_ID=:TENANT_ID,KPI_ID=:KPI_ID,ACTR_ID=:ACTR_ID,GODS_ID=:GODS_ID,UNIT_ID=:UNIT_ID,ACTR_RATIO=:ACTR_RATIO,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' where TENANT_ID=:OLD_TENANT_ID and ACTR_ID=:OLD_ACTR_ID';
  UpdateSQL.Add( Str);
  Str := 'delete from MKT_ACTIVE_RATIO where TENANT_ID=:OLD_TENANT_ID and ACTR_ID=:OLD_ACTR_ID';
  DeleteSQL.Add( Str);
end;

{ TKpiIndexDelete }

function TKpiIndexDelete.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Str,TenID,KPI_ID:string;
  n:Integer;
  rs:TZQuery;
begin
  try
    TenID:=IntToStr(Params.ParamByName('TENANT_ID').AsInteger);
    KPI_ID:=trim(Params.ParamByName('KPI_ID').AsString);
    rs:=TZQuery.Create(nil);                                  
    rs.SQL.Text:=
      'select sum(ReSum) as ReSum from '+
      '(select count(*) as ReSum from MKT_KPI_RESULT where TENANT_ID='+TenID+' and KPI_ID='''+KPI_ID+''' and COMM not in (''02'',''12'')'+
      '  union all '+
      ' select count(*) as ReSum from MKT_KPI_RESULT_LIST a,MKT_KPI_RESULT b where a.TENANT_ID=b.TENANT_ID and a.CLIENT_ID=b.CLIENT_ID and a.KPI_ID=b.KPI_ID and a.TENANT_ID='+TenID+' and a.KPI_ID='''+KPI_ID+''' and b.COMM not in (''02'',''12'') '+
      '  union all '+
      ' select count(*) as ReSum from MKT_REQUDATA a,MKT_REQUORDER b where a.TENANT_ID=b.TENANT_ID and a.REQU_ID=b.REQU_ID and a.TENANT_ID='+TenID+' and a.KPI_ID='''+KPI_ID+''' and b.COMM not in (''02'',''12''))tp';
    AGlobal.Open(rs);
    if rs.Active and (rs.FieldByName('ReSum').AsInteger>0) then
      Raise Exception.Create('   此指标已被引用，不能删除！   ');   
  finally
    rs.Free;
  end;
  AGlobal.BeginTrans;
  try
    //删除指标
    Str:='delete from MKT_KPI_INDEX where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'')';
    AGlobal.ExecSQL(Str,Params); 
    //删除等级:
    Str:='delete from MKT_KPI_LEVEL where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'')';
    AGlobal.ExecSQL(Str,Params);
    //删除时段:
    Str:='delete from MKT_KPI_TIMES where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'')';
    AGlobal.ExecSQL(Str,Params);
    //删除商品:
    Str:='delete from MKT_KPI_GOODS where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'')';
    AGlobal.ExecSQL(Str,Params);
    //删除档次:
    Str:='delete from MKT_KPI_SEQNO where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'')';
    AGlobal.ExecSQL(Str,Params);
    //删除系数:
    Str:='delete from MKT_KPI_RATIO where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'')';
    AGlobal.ExecSQL(Str,Params);
    //删除市场费计提:
    Str:='delete from MKT_ACTIVE_RATIO where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID and COMM not in (''02'',''12'')';
    AGlobal.ExecSQL(Str,Params);
    //提交事务
    AGlobal.CommitTrans;
    Result := true;
    Msg := '审核单据成功';
  except 
    on E:Exception do
    begin
      AGlobal.RollbackTrans; //回滚事务
      Result := false;
      Msg := '删除错误'+E.Message;
    end;
  end;
end;

initialization
  RegisterClass(TKpiIndex);
  RegisterClass(TKpiLevel);
  RegisterClass(TKpiGoods);
  RegisterClass(TKpiTimes);
  RegisterClass(TKpiSeqNo);
  RegisterClass(TKpiRatio);
  RegisterClass(TMktRatio);
  RegisterClass(TKpiIndexDelete);

finalization
  UnRegisterClass(TKpiIndex);
  UnRegisterClass(TKpiLevel);
  UnRegisterClass(TKpiGoods);
  UnRegisterClass(TKpiTimes);
  UnRegisterClass(TKpiSeqNo);
  UnRegisterClass(TKpiRatio);
  UnRegisterClass(TMktRatio);
  UnRegisterClass(TKpiIndexDelete);

end.
