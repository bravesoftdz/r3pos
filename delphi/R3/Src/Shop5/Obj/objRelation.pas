unit objRelation;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TRelation=class(TZFactory)
  public
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;


implementation

{ TRelation }

function TRelation.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from  CA_RELATIONS where TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID and COMM not in (''02'',''12'') ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsOldInteger;
    rs.ParamByName('RELATION_ID').AsInteger := FieldByName('RELATION_ID').AsOldInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create('本企业供应链下面已经有加盟商,不能删除.');

    rs.Close;
    rs.SQL.Text := 'select count(*) from  PUB_GOODS_RELATION where TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID and COMM not in (''02'',''12'') ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsOldInteger;
    rs.ParamByName('RELATION_ID').AsInteger := FieldByName('RELATION_ID').AsOldInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
      Raise Exception.Create('本企业供应链下面已经有商品,不能删除.');
  finally
    rs.Free;
  end;
end;

function TRelation.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  Result := False;
  rs :=  TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select RELATION_ID,COMM from CA_RELATION where TENANT_ID=:TENANT_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString <> '' then
      begin
        if Copy(rs.FieldByName('COMM').AsString,2,1) = '2' then
          AGlobal.ExecSQL('delete from CA_RELATION where TENANT_ID=:TENANT_ID ',self)
        else
          Raise Exception.Create('企业只能创建一条供应链.');
      end;
  finally
    rs.Free;
  end;
  Result := True;
end;

function TRelation.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TRelation.InitClass;
var Str:String;
begin
  inherited;
  KeyFields:='RELATION_ID';
  Str := ' select RELATION_ID,TENANT_ID,RELATION_NAME,RELATION_SPELL,REMARK,COMM from CA_RELATION where TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID and COMM not in (''02'',''12'') ';
  SelectSQL.Text := Str;
  IsSQLUpdate := True;
  Str := ' insert into CA_RELATION(RELATION_ID,TENANT_ID,RELATION_NAME,RELATION_SPELL,REMARK,COMM,TIME_STAMP) '
       + 'VALUES(:RELATION_ID,:TENANT_ID,:RELATION_NAME,:RELATION_SPELL,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := ' update CA_RELATION set TENANT_ID=:TENANT_ID,RELATION_NAME=:RELATION_NAME,RELATION_SPELL=:RELATION_SPELL,REMARK=:REMARK,COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+' where COMM not in (''02'',''12'') and RELATION_ID=:OLD_RELATION_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := ' update CA_RELATION set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where RELATION_ID=:OLD_RELATION_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;


initialization
  RegisterClass(TRelation);
finalization
  RegisterClass(TRelation);

end.
