unit ObjBatchNo;

interface
uses SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TBatchNo=class(TZFactory)
  private
    //记录行集新增检测函数，返回值是True 则可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 则可以新增当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;    
    procedure InitClass; override;
  end;
  
implementation

{ TBatchNo }

function TBatchNo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    if FieldbyName('GODS_ID').AsOldString<>'#' then
       rs.SQL.Text := 'select SHOP_ID from STO_STORAGE where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID and BATCH_NO=:BATCH_NO and AMOUNT<>0'
    else
       rs.SQL.Text := 'select SHOP_ID from STO_STORAGE where TENANT_ID=:TENANT_ID and BATCH_NO=:BATCH_NO and AMOUNT<>0';
    if rs.Params.FindParam('GODS_ID')<>nil then
       rs.ParamByName('GODS_ID').AsString := FieldByName('GODS_ID').AsString;
    rs.ParamByName('BATCH_NO').AsString := FieldByName('BATCH_NO').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString <> '' then
      Raise Exception.Create('此批号还有库存,不能删除!');
  finally
    rs.Free;
  end;
end;

function TBatchNo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select COMM from PUB_BATCH_NO where BATCH_NO=:BATCH_NO and GODS_ID=:GODS_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('BATCH_NO').AsString := FieldByName('BATCH_NO').AsString;
    rs.ParamByName('GODS_ID').AsString := FieldByName('GODS_ID').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的分组，重新启动原有编码
           begin
             AGlobal.ExecSQL('delete from PUB_BATCH_NO where BATCH_NO=:BATCH_NO and GODS_ID=:GODS_ID and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('BATCH_NO').AsString+'"批号不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TBatchNo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin  
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_BATCH_NO where COMM not in (''02'',''12'') and BATCH_NO=:BATCH_NO and BATCH_NO<>:OLD_BATCH_NO and GODS_ID=:GODS_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('BATCH_NO').AsString := FieldByName('BATCH_NO').AsString;
    rs.ParamByName('OLD_BATCH_NO').AsString := FieldByName('BATCH_NO').AsOldString;
    rs.ParamByName('GODS_ID').AsString := FieldByName('GODS_ID').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create(FieldbyName('BATCH_NO').AsString+'批号已经存在，不能重复添加...');
  finally
    rs.Free;
  end;
  Result:=True;
end;

procedure TBatchNo.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := ParseSQL(iDbType,
  'select A.*,isnull(B.GODS_NAME,''无'') as GODS_ID_TEXT from PUB_BATCH_NO A left outer join VIW_GOODSINFO B on A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID '+
  'where A.TENANT_ID=:TENANT_ID and A.BATCH_NO=:BATCH_NO and A.GODS_ID=:GODS_ID ');

  IsSQLUpdate := True;
  Str := 'insert into PUB_BATCH_NO(TENANT_ID,BATCH_NO,GODS_ID,FACT_DATE,VILD_DATE,REMARK,COMM,TIME_STAMP) VALUES(:TENANT_ID,:BATCH_NO,:GODS_ID,:FACT_DATE,:VILD_DATE,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update PUB_BATCH_NO set TENANT_ID=:TENANT_ID,BATCH_NO=:BATCH_NO,GODS_ID=:GODS_ID,FACT_DATE=:FACT_DATE,VILD_DATE=:VILD_DATE,REMARK=:REMARK,COMM='
          +GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and BATCH_NO=:OLD_BATCH_NO and GODS_ID=:OLD_GODS_ID ';
  UpdateSQL.Add( Str);
  Str := 'update PUB_BATCH_NO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and BATCH_NO=:OLD_BATCH_NO and GODS_ID=:OLD_GODS_ID';
  DeleteSQL.Add( Str);
end;



initialization
  RegisterClass(TBatchNo);
finalization
  UnRegisterClass(TBatchNo);
  
end.
