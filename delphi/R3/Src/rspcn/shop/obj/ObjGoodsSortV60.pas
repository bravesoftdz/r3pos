unit ObjGoodsSortV60;

interface

uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;

type

  TGoodsSortV60=class(TZFactory)
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

function TGoodsSortV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  SORT_ID:String;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  SORT_ID := 'SORT_ID'+FieldByName('SORT_TYPE').AsString;
  try
    rs.Close;
    rs.SQL.Text := 'select count(*) from PUB_GOODSINFO where TENANT_ID=:TENANT_ID and '+SORT_ID+'=:SORT_ID and COMM not in (''02'',''12'')';;
    rs.ParamByName('SORT_ID').AsString := FieldbyName('SORT_ID').AsString;
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('SORT_NAME').AsOldString+'"已经在商品资料中使用不能删除.');
  finally
    rs.Free;
  end;
  result := true;
end;

function TGoodsSortV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsSortV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TGoodsSortV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,TENANT_ID from PUB_GOODSSORT '+
    'where TENANT_ID=:TENANT_ID and SORT_TYPE=:SORT_TYPE and SORT_ID=:SORT_ID';

  IsSQLUpdate := true;
  InsertSQL.Text :=
    'insert into PUB_GOODSSORT (TENANT_ID,SORT_ID,LEVEL_ID,SORT_NAME,SORT_TYPE,SORT_SPELL,SEQ_NO,COMM,TIME_STAMP) '+
    'values (:TENANT_ID,:SORT_ID,:LEVEL_ID,:SORT_NAME,:SORT_TYPE,:SORT_SPELL,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';

  UpdateSQL.Text :=
    'update PUB_GOODSSORT set TENANT_ID=:TENANT_ID,SORT_ID=:SORT_ID,LEVEL_ID=:LEVEL_ID,SORT_NAME=:SORT_NAME,SORT_SPELL=:SORT_SPELL,'+
    'SEQ_NO=:SEQ_NO,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where SORT_ID=:OLD_SORT_ID and TENANT_ID=:OLD_TENANT_ID and SORT_TYPE=:OLD_SORT_TYPE';

  DeleteSQL.Text :=
    'update PUB_GOODSSORT set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where SORT_ID=:OLD_SORT_ID and TENANT_ID=:OLD_TENANT_ID and SORT_TYPE=:OLD_SORT_TYPE';
end;

initialization
  RegisterClass(TGoodsSortV60);
finalization
  UnRegisterClass(TGoodsSortV60);
end.

