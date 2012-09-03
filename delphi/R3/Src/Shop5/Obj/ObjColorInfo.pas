unit ObjColorInfo;

interface
uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TColorInfo=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TColorGroupInfo=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TColorGroupRelation=class(TZFactory)
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

{ TColorInfo }

function TColorInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  Str := 'select count(CODE_ID) as SUM_CODE from PUB_CODE_RELATION where CODE_ID=:OLD_COLOR_ID and TENANT_ID=:TENANT_ID and SORT_TYPE=7';

  try
    rs.Close;
    rs.SQL.Text := Str;
    rs.ParamByName('OLD_COLOR_ID').AsString := Fieldbyname('COLOR_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('COLOR_NAME').AsOldString+'"已经在相关资料中使用不能删除.');
  finally
    rs.Free;
  end;

  result := true;
end;

function TColorInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := ' select COLOR_ID,COMM,SEQ_NO from PUB_COLOR_INFO where COLOR_NAME=:COLOR_NAME and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('COLOR_NAME').AsString := Fieldbyname('COLOR_NAME').AsString;
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的颜色，重新启动原有编码
           begin
             FieldbyName('COLOR_ID').AsString := rs.FieldbyName('COLOR_ID').AsString;
             AGlobal.ExecSQL('delete from PUB_COLOR_INFO where COLOR_ID=:COLOR_ID and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('COLOR_NAME').AsString+'"颜色名称不能重复设置');
        rs.Next;
      end;

    rs.SQL.Text := ' select COLOR_ID,COMM,SEQ_NO from PUB_COLOR_INFO where BARCODE_FLAG=:BARCODE_FLAG and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('BARCODE_FLAG').AsString := Fieldbyname('BARCODE_FLAG').AsString;
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的 条码标号，重新启动原有编码
           begin
             FieldbyName('COLOR_ID').AsString := rs.FieldbyName('COLOR_ID').AsString;
             AGlobal.ExecSQL('delete from PUB_COLOR_INFO where COLOR_ID=:COLOR_ID and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('BARCODE_FLAG').AsString+'"条码标号名称不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TColorInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select COLOR_ID from PUB_COLOR_INFO where COMM not in (''02'',''12'') and COLOR_NAME=:COLOR_NAME '+
    ' and COLOR_ID<>:COLOR_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('COLOR_ID').AsString := Fieldbyname('COLOR_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('COLOR_NAME').AsString := Fieldbyname('COLOR_NAME').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString <> '' then Raise Exception.Create('"'+FieldbyName('COLOR_NAME').AsString+'"颜色名称不能重复设置');

    rs.SQL.Text := 'select COLOR_ID from PUB_COLOR_INFO where COMM not in (''02'',''12'') and BARCODE_FLAG=:BARCODE_FLAG '+
    ' and COLOR_ID<>:COLOR_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('COLOR_ID').AsString := Fieldbyname('COLOR_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('BARCODE_FLAG').AsString := Fieldbyname('BARCODE_FLAG').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString <> '' then Raise Exception.Create('"'+FieldbyName('BARCODE_FLAG').AsString+'"条码标号不能重复设置');
  finally
    rs.Free;
  end;
end;

procedure TColorInfo.InitClass;
var
  Str: string;
begin
  inherited;    
  SelectSQL.Text := 'select TENANT_ID,COLOR_ID,SORT_ID7S,SORT_ID7_NAMES,COLOR_NAME,COLOR_SPELL,BARCODE_FLAG,SEQ_NO from PUB_COLOR_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into PUB_COLOR_INFO(TENANT_ID,COLOR_ID,SORT_ID7S,SORT_ID7_NAMES,COLOR_NAME,COLOR_SPELL,BARCODE_FLAG,SEQ_NO,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:COLOR_ID,:SORT_ID7S,:SORT_ID7_NAMES,:COLOR_NAME,:COLOR_SPELL,:BARCODE_FLAG,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_COLOR_INFO set SORT_ID7S=:SORT_ID7S,SORT_ID7_NAMES=:SORT_ID7_NAMES,COLOR_NAME=:COLOR_NAME,COLOR_SPELL=:COLOR_SPELL,BARCODE_FLAG=:BARCODE_FLAG,SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+' where COLOR_ID=:OLD_COLOR_ID and TENANT_ID=:OLD_TENANT_ID ';
  UpdateSQL.Text := Str;
  Str := 'update PUB_COLOR_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where COLOR_ID=:OLD_COLOR_ID and TENANT_ID=:OLD_TENANT_ID ';
  DeleteSQL.Text := Str;
end;


{ TColorGroupRelation }

function TColorGroupRelation.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TColorGroupRelation.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TColorGroupRelation.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TColorGroupRelation.InitClass;
var
  Str: string;
begin
  inherited;    
  SelectSQL.Text := 'select A.TENANT_ID,A.CODE_ID,A.SORT_ID,A.SORT_TYPE,A.SEQ_NO,B.COLOR_NAME as SORT_NAME,B.COLOR_SPELL as SORT_SPELL '+
  ' from PUB_CODE_RELATION A left join PUB_COLOR_INFO B on A.TENANT_ID=B.TENANT_ID and A.CODE_ID=B.COLOR_ID where A.TENANT_ID=:TENANT_ID and A.SORT_TYPE=7 order by A.SEQ_NO';
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

{ TColorGroupInfo }

function TColorGroupInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TColorGroupInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TColorGroupInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TColorGroupInfo.InitClass;
var Str: string;
begin
  inherited;    
  SelectSQL.Text := 'select TENANT_ID,SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO from PUB_GOODSSORT '+
  ' where TENANT_ID=:TENANT_ID and SORT_TYPE=7 and COMM not in (''02'',''12'') order by SEQ_NO';
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

initialization
  RegisterClass(TColorInfo);
  RegisterClass(TColorGroupInfo);
  RegisterClass(TColorGroupRelation);
finalization
  UnRegisterClass(TColorInfo);
  UnRegisterClass(TColorGroupInfo);
  UnRegisterClass(TColorGroupRelation);

end.

