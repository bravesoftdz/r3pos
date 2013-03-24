unit ObjPriceGradeV60;

interface

uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;

type

  TPriceGradeV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

function TPriceGradeV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from VIW_CUSTOMER where TENANT_ID=:TENANT_ID and PRICE_ID=:OLD_PRICE_ID and COMM not in (''02'',''12'')';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('OLD_PRICE_ID').AsString := FieldByName('PRICE_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('"'+FieldbyName('PRICE_NAME').AsOldString+'"已经在会员档案中使用不能删除.');
  finally
    rs.Free;
  end;
  result := true;
end;

function TPriceGradeV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TPriceGradeV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TPriceGradeV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,'+
    'AGIO_SORTS,SEQ_NO,''0000'' as LEVEL_ID,COMM,TIME_STAMP from PUB_PRICEGRADE where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and PRICE_ID=:PRICE_ID';
  IsSQLUpdate := True;

  InsertSQL.Text :=
    'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,AGIO_SORTS,SEQ_NO,PRICE_TYPE,COMM,TIME_STAMP) '+
    'VALUES(:TENANT_ID,:PRICE_ID,:PRICE_NAME,:PRICE_SPELL,:INTEGRAL,:INTE_TYPE,:INTE_AMOUNT,:MINIMUM_PERCENT,:AGIO_TYPE,:AGIO_PERCENT,:AGIO_SORTS,:SEQ_NO,''1'',''00'','+GetTimeStamp(iDbType)+')';

  UpdateSQL.Text :=
    'update PUB_PRICEGRADE set PRICE_ID=:PRICE_ID,PRICE_NAME=:PRICE_NAME,PRICE_SPELL=:PRICE_SPELL,INTEGRAL=:INTEGRAL,INTE_TYPE=:INTE_TYPE,'+
    'INTE_AMOUNT=:INTE_AMOUNT,MINIMUM_PERCENT=:MINIMUM_PERCENT,AGIO_TYPE=:AGIO_TYPE,AGIO_PERCENT=:AGIO_PERCENT,AGIO_SORTS=:AGIO_SORTS,SEQ_NO=:SEQ_NO,'+
    'COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and PRICE_ID=:OLD_PRICE_ID ';
  
  DeleteSQL.Text :=
    'update PUB_PRICEGRADE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and PRICE_ID=:OLD_PRICE_ID';
end;

initialization
  RegisterClass(TPriceGradeV60);
finalization
  UnRegisterClass(TPriceGradeV60);
end. 
