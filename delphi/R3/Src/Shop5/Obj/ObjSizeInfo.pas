unit ObjSizeInfo;

interface
uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TSizeInfo=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TSizeGroupInfo=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TSizeGroupRelation=class(TZFactory)
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

{ TSizeInfo }

function TSizeInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  Str := 'select count(CODE_ID) as SUM_CODE from PUB_CODE_RELATION where CODE_ID=:OLD_SIZE_ID and TENANT_ID=:TENANT_ID and SORT_TYPE=8';
  try
    rs.Close;
    rs.SQL.Text := Str;
    rs.ParamByName('OLD_SIZE_ID').AsString := Fieldbyname('SIZE_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('SIZE_NAME').AsOldString+'"已经在相关资料中使用不能删除.');
  finally
    rs.Free;
  end;

  result := true;
end;

function TSizeInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select SIZE_ID,COMM,SEQ_NO from PUB_SIZE_INFO where SIZE_NAME=:SIZE_NAME and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('SIZE_NAME').AsString := Fieldbyname('SIZE_NAME').AsString;
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的分组，重新启动原有编码
           begin
             FieldbyName('SIZE_ID').AsString := rs.FieldbyName('SIZE_ID').AsString;
             AGlobal.ExecSQL('delete from PUB_SIZE_INFO where SIZE_ID=:SIZE_ID and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('SIZE_NAME').AsString+'"尺码名称不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TSizeInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select SIZE_ID from PUB_SIZE_INFO where COMM not in (''02'',''12'') and SIZE_NAME=:SIZE_NAME and SIZE_ID<>:SIZE_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('SIZE_ID').AsString := Fieldbyname('SIZE_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('SIZE_NAME').AsString := Fieldbyname('SIZE_NAME').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString <> '' then Raise Exception.Create('"'+FieldbyName('SIZE_NAME').AsString+'"尺码名称不能重复设置');
  finally
    rs.Free;
  end;
end;

procedure TSizeInfo.InitClass;
var
  Str: string;
begin
  inherited;    
  SelectSQL.Text := 'select TENANT_ID,SIZE_ID,SORT_ID8S,SORT_ID8_NAMES,SIZE_NAME,SIZE_SPELL,BARCODE_FLAG,SEQ_NO from PUB_SIZE_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into PUB_SIZE_INFO(TENANT_ID,SIZE_ID,SORT_ID8S,SORT_ID8_NAMES,SIZE_NAME,SIZE_SPELL,BARCODE_FLAG,SEQ_NO,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SIZE_ID,:SORT_ID8S,:SORT_ID8_NAMES,:SIZE_NAME,:SIZE_SPELL,:BARCODE_FLAG,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_SIZE_INFO set SORT_ID8S=:SORT_ID8S,SORT_ID8_NAMES=:SORT_ID8_NAMES,SIZE_NAME=:SIZE_NAME,SIZE_SPELL=:SIZE_SPELL,BARCODE_FLAG=:BARCODE_FLAG,SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+' where SIZE_ID=:OLD_SIZE_ID and TENANT_ID=:OLD_TENANT_ID ';
  UpdateSQL.Text := Str;
  Str := 'update PUB_SIZE_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where SIZE_ID=:OLD_SIZE_ID and TENANT_ID=:OLD_TENANT_ID ';
  DeleteSQL.Text := Str;
end;


{ TSizeGroupInfo }

function TSizeGroupInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TSizeGroupInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TSizeGroupInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TSizeGroupInfo.InitClass;
var Str: string;
begin
  inherited;    
  SelectSQL.Text := 'select TENANT_ID,SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO from PUB_GOODSSORT '+
  ' where TENANT_ID=:TENANT_ID and SORT_TYPE=8 and COMM not in (''02'',''12'') order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into PUB_GOODSSORT(TENANT_ID,SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:SORT_ID,:LEVEL_ID,:SORT_NAME,:SORT_TYPE,:SORT_SPELL,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_GOODSSORT set SORT_NAME=:SORT_NAME,SORT_SPELL=:SORT_SPELL,SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+' where SORT_ID=:OLD_SORT_ID and TENANT_ID=:OLD_TENANT_ID and SORT_TYPE=:OLD_SORT_TYPE';
  UpdateSQL.Text := Str;
  Str := 'delete from PUB_GOODSSORT where SORT_ID=:OLD_SORT_ID and TENANT_ID=:OLD_TENANT_ID and SORT_TYPE=:OLD_SORT_TYPE';
  DeleteSQL.Text := Str;
end;

{ TSizeGroupRelation }

function TSizeGroupRelation.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TSizeGroupRelation.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TSizeGroupRelation.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TSizeGroupRelation.InitClass;
var
  Str: string;
begin
  inherited;    
  SelectSQL.Text := 'select A.TENANT_ID,A.CODE_ID,A.SORT_ID,A.SORT_TYPE,A.SEQ_NO,B.SIZE_NAME as SORT_NAME,B.SIZE_SPELL as SORT_SPELL '+
  ' from PUB_CODE_RELATION A left join PUB_SIZE_INFO B on A.TENANT_ID=B.TENANT_ID and A.CODE_ID=B.SIZE_ID where A.TENANT_ID=:TENANT_ID and A.SORT_TYPE=8 ';
  IsSQLUpdate := True;
  Str := 'insert into PUB_CODE_RELATION(TENANT_ID,CODE_ID,SORT_ID,SORT_TYPE,SEQ_NO,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:CODE_ID,:SORT_ID,:SORT_TYPE,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_CODE_RELATION set SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and CODE_ID=:OLD_CODE_ID and SORT_ID=:OLD_SORT_ID and SORT_TYPE=:OLD_SORT_TYPE ';
  UpdateSQL.Text := Str;
  Str := 'delete from PUB_CODE_RELATION where TENANT_ID=:OLD_TENANT_ID and CODE_ID=:OLD_CODE_ID and SORT_ID=:OLD_SORT_ID and SORT_TYPE=:OLD_SORT_TYPE ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TSizeInfo);
  RegisterClass(TSizeGroupInfo);
  RegisterClass(TSizeGroupRelation);
finalization
  UnRegisterClass(TSizeInfo);
  UnRegisterClass(TSizeGroupInfo);
  UnRegisterClass(TSizeGroupRelation);

end.

