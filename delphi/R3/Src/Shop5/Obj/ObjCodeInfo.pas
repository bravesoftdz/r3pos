unit ObjCodeInfo;

interface
uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TCodeInfo=class(TZFactory)
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

{ TCodeInfo }

function TCodeInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
    rs:TZQuery;
begin
  if FieldByName('CODE_TYPE').AsInteger in [5,6,9] then
    begin
      rs := TZQuery.Create(nil);
      case FieldByName('CODE_TYPE').AsInteger of
        5:Str:='select CLIENT_ID from PUB_CLIENTINFO where COMM not in (''02'',''12'') and CLIENT_TYPE=''2'' and SORT_ID=:OLD_CODE_ID and TENANT_ID=:TENANT_ID ';
        6:Str:='select CLIENT_ID from PUB_CLIENTINFO where COMM not in (''02'',''12'') and SETTLE_CODE=:OLD_CODE_ID and TENANT_ID=:TENANT_ID ';
        9:Str:='select CLIENT_ID from PUB_CLIENTINFO where COMM not in (''02'',''12'') and CLIENT_TYPE=''1'' and SORT_ID=:OLD_CODE_ID and TENANT_ID=:TENANT_ID ';
      end;                 
      try
        rs.Close;
        rs.SQL.Text := Str;
        rs.ParamByName('OLD_CODE_ID').AsString := Fieldbyname('CODE_ID').AsOldString;
        rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
        AGlobal.Open(rs);
        if rs.Fields[0].AsString <> '' then
           Raise Exception.Create('"'+FieldbyName('CODE_NAME').AsOldString+'"已经在相关资料中使用不能删除.');
      finally
        rs.Free;
      end;
  end;
  result := true;
end;

function TCodeInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CODE_ID,COMM,SEQ_NO from PUB_CODE_INFO where CODE_NAME=:CODE_NAME and CODE_TYPE=:CODE_TYPE and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('CODE_TYPE').AsString := Fieldbyname('CODE_TYPE').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('CODE_NAME').AsString := Fieldbyname('CODE_NAME').AsString;
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if copy(rs.FieldbyName('COMM').AsString,2,1)='2' then //如果原来删除的分组，重新启动原有编码
           begin
             FieldbyName('CODE_ID').AsString := rs.FieldbyName('CODE_ID').AsString;
             AGlobal.ExecSQL('delete from PUB_CODE_INFO where CODE_ID=:CODE_ID and CODE_TYPE=:CODE_TYPE and TENANT_ID=:TENANT_ID ',self);
           end
        else
           Raise Exception.Create('"'+FieldbyName('CODE_NAME').AsString+'"类别名称不能重复设置');
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

function TCodeInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  result := true;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CODE_ID from PUB_CODE_INFO where COMM not in (''02'',''12'') and CODE_TYPE=:CODE_TYPE '+
    'and CODE_NAME=:CODE_NAME and CODE_ID<>:CODE_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('CODE_TYPE').AsString := Fieldbyname('CODE_TYPE').AsString;
    rs.ParamByName('CODE_ID').AsString := Fieldbyname('CODE_ID').AsOldString;
    rs.ParamByName('TENANT_ID').AsInteger := Fieldbyname('TENANT_ID').AsInteger;
    rs.ParamByName('CODE_NAME').AsString := Fieldbyname('CODE_NAME').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString <> '' then Raise Exception.Create('"'+FieldbyName('CODE_NAME').AsString+'"类别名称不能重复设置');
  finally
    rs.Free;
  end;
end;

procedure TCodeInfo.InitClass;
var
  Str: string;
begin
  inherited;    
  SelectSQL.Text := 'select TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,CODE_TYPE,SEQ_NO from PUB_CODE_INFO where CODE_TYPE=:CODE_TYPE and TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into PUB_CODE_INFO(TENANT_ID,CODE_ID,CODE_NAME,CODE_SPELL,SEQ_NO,CODE_TYPE,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:CODE_ID,:CODE_NAME,:CODE_SPELL,:SEQ_NO,:CODE_TYPE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update PUB_CODE_INFO set CODE_ID=:CODE_ID,CODE_NAME=:CODE_NAME,CODE_SPELL=:CODE_SPELL,SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+' where CODE_ID=:OLD_CODE_ID and TENANT_ID=:OLD_TENANT_ID and CODE_TYPE=:OLD_CODE_TYPE';
  UpdateSQL.Text := Str;
  Str := 'update PUB_CODE_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where CODE_ID=:OLD_CODE_ID and TENANT_ID=:OLD_TENANT_ID and CODE_TYPE=:OLD_CODE_TYPE';
  DeleteSQL.Text := Str;
end;


initialization
  RegisterClass(TCodeInfo);
finalization
  UnRegisterClass(TCodeInfo);

  
end.

