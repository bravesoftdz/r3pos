unit ObjGoodsSort;

interface
uses Dialogs,SysUtils,ZBase,Classes, AdoDb,ZIntf,ObjCommon,ZDataset;
type
  TGoodsSort=class(TZFactory)
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
implementation

{ TGoodsSort }

function TGoodsSort.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  {rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from PUB_GOODSINFO where (CALC_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') or (SMALL_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') or (BIG_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') and COMM not in (''02'',''12'')';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('UNIT_NAME').AsOldString+'"已经在商品资料中使用不能删除.');
    rs.Close;
    rs.CommandText := 'select count(*) from BAS_GOODSINFO where (CALC_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') or (SMALL_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') or (BIG_UNITS='''+FieldbyName('UNIT_ID').AsOldString+''') and COMM not in (''02'',''12'')';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('UNIT_NAME').AsOldString+'"已经在商品资料中使用不能删除.'); 
  finally
    rs.Free;
  end; }
  result := true;
end;

function TGoodsSort.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select SORT_ID,COMM,SEQ_NO from PUB_GOODSSORT where  SORT_NAME='''+FieldbyName('SORT_NAME').AsString+'''';
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的分组，重新启动原有编码
           begin
             FieldbyName('SORT_ID').AsString := rs.FieldbyName('SORT_ID').AsString;
             AGlobal.ExecSQL('delete from PUB_GOODSSORT where SORT_ID=:SORT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('SORT_NAME').AsString+'"单位名称不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TGoodsSort.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_GOODSSORT where  SORT_NAME='''+FieldbyName('SORT_NAME').AsString+''' and SORT_ID<>'''+FieldbyName('SORT_ID').AsString+''' and COMM not in (''02'',''12'')';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger >0 then Raise Exception.Create('"'+FieldbyName('SORT_NAME').AsString+'"单位名称不能重复设置');
  finally
    rs.Free;
  end;
end;

procedure TGoodsSort.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select SORT_ID,SORT_NAME,SORT_SPELL,SORT_TYPE,TENANT_ID,SEQ_NO from PUB_GOODSSORT where SORT_TYPE = :SORT_TYPE and COMM not in (''02'',''12'')  order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into PUB_GOODSSORT(SORT_ID,SORT_NAME,SORT_SPELL,SORT_TYPE,TENANT_ID,SEQ_NO,TIME_STAMP) '
    + 'VALUES(:SORT_ID,:SORT_NAME,:SORT_SPELL,:SORT_TYPE,:TENANT_ID,:SEQ_NO,'+GetTimeStamp(5)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_GOODSSORT set SORT_ID=:SORT_ID,SORT_NAME=:SORT_NAME,SORT_SPELL=:SORT_SPELL,TENANT_ID=:TENANT_ID,SEQ_NO=:SEQ_NO,'
    + 'COMM='+GetCommStr(5)+',TIME_STAMP='+GetTimeStamp(5)+' where SORT_ID=:OLD_SORT_ID and TENANT_ID = :OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'update PUB_GOODSSORT set COMM=''02'',TIME_STAMP='+GetTimeStamp(5)+' where SORT_ID=:OLD_SORT_ID and TENANT_ID = :OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;
initialization
  RegisterClass(TGoodsSort);
finalization
  UnRegisterClass(TGoodsSort);
end.

