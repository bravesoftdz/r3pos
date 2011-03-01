unit ObjCloseForDay;

interface
uses Dialogs,SysUtils,zBase,Classes,DB, ZDataSet,zIntf,ObjCommon;
type
  TCloseForDay=class(TZFactory)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;


implementation

{ TCloseForDay }

function TCloseForDay.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TCloseForDay.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;;
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=:PAY_A+isnull(IN_MNY,0),BALANCE=:PAY_A+isnull(BALANCE,0),'+
  'COMM=:'+GetCommStr(iDbType)+
  ',TIME_STAMP=:'+GetTimeStamp(iDbType)+
  ' where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PAYM_ID=''A'' ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);
  Result := True;
end;

function TCloseForDay.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TCloseForDay.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

procedure TCloseForDay.InitClass;
var Str:String;
begin
  inherited;
  //KeyFields := 'ROWS_ID';

  IsSQLUpdate := True;
  Str := 'insert into ACC_CLOSE_FORDAY(ROWS_ID,TENANT_ID,SHOP_ID,CLSE_DATE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,'+
  'PAY_I,PAY_J,CREA_DATE,CREA_USER,COMM,TIME_STAMP) values(:ROWS_ID,:TENANT_ID,:SHOP_ID,:CLSE_DATE,:PAY_A,:PAY_B,:PAY_C,'+
  ':PAY_D,:PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

end;


initialization
  RegisterClass(TCloseForDay);

finalization
  UnRegisterClass(TCloseForDay);

end.
