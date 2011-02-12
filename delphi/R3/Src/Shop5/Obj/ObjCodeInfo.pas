unit ObjCodeInfo;

interface
uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TClientSort=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
implementation

{ TClientSort }

function TClientSort.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from PUB_CLIENTINFO where SORT_ID=:OLD_CODE_ID and COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('CODE_NAME').AsOldString+'"已经在供应商资料中使用不能删除.');
  finally
    rs.Free;
  end;
  result := true;
end;

function TClientSort.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CODE_ID,COMM,SEQ_NO from PUB_CODE_INFO where CODE_TYPE=:CODE_TYPE and TENANT_ID=:TENANT_ID ';
    AGlobal.Open(rs);
    FieldbyName('CODE_ID').AsString := '';
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的分组，重新启动原有编码
           begin
             FieldbyName('CODE_ID').AsString := rs.FieldbyName('CODE_ID').AsString;
             AGlobal.ExecSQL('delete from PUB_CODE_INFO where CODE_ID=:CODE_ID and CODE_TYPE=:CODE_TYPE and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('CODE_NAME').AsString+'"供应商类别不能重复设置');
        rs.Next;
      end;
    //if FieldbyName('CODE_ID').AsString='' then FieldbyName('CODE_ID').AsString := GetSequence(AGlobal,'ClientSort_ID','----','',6);
  finally
    rs.Free;
  end;
end;

function TClientSort.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_CODE_INFO where CODE_TYPE=:CODE_TYPE and CODE_NAME=:CODE_NAME '+
    'and CODE_ID<>:CODE_ID and COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID ';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger >0 then Raise Exception.Create('"'+FieldbyName('CODE_NAME').AsString+'"客户类别不能重复设置');
  finally
    rs.Free;
  end;
end;

procedure TClientSort.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := 'select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,CODE_TYPE,SEQ_NO from PUB_CODE_INFO where CODE_TYPE=:CODE_TYPE and TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO,CODE_TYPE,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:CODE_ID,:CODE_NAME,:CODE_SPELL,:SEQ_NO,:CODE_TYPE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_CODE_INFO set CODE_ID=:CODE_ID,CODE_NAME=:CODE_NAME,CODE_SPELL=:CODE_SPELL,SEQ_NO=:SEQ_NO,COMM='
  +GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where CODE_ID=:OLD_CODE_ID and TENANT_ID=:OLD_TENANT_ID and CODE_TYPE=:OLD_CODE_TYPE';
  UpdateSQL.Text := Str;
  Str := 'update PUB_CODE_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where CODE_ID=:OLD_CODE_ID and TENANT_ID=:OLD_TENANT_ID and CODE_TYPE=:OLD_CODE_TYPE';
  DeleteSQL.Text := Str;
end;
initialization
  RegisterClass(TClientSort);
finalization
  UnRegisterClass(TClientSort);
end.

