unit ObjCloseForDayV60;

interface

uses Dialogs,SysUtils,Variants,ZBase,Classes,DB,ZDataSet,zIntf,ObjCommon;

type
  TCloseForDayV60=class(TZFactory)
  private
    function CheckNotExistPosCloseRecord(AGlobal: IdbHelp):Boolean;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

function TCloseForDayV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  Str:string;
begin
  result := false;
  Str := 'delete from ACC_CLOSE_FORDAY where TENANT_ID=:OLD_TENANT_ID and CLSE_DATE=:OLD_CLSE_DATE and SHOP_ID=:OLD_SHOP_ID and CREA_USER=:OLD_CREA_USER';
  r := AGlobal.ExecSQL(Str,self);
  if r = 0 then Raise Exception.Create('没找到前当结账记录，是否被另一用户撤消？'); 
  result := true;
end;

function TCloseForDayV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  if CheckNotExistPosCloseRecord(AGlobal) then //不存在才插入
     begin
       Str := 'insert into ACC_CLOSE_FORDAY(ROWS_ID,TENANT_ID,SHOP_ID,CLSE_DATE,CLSE_MNY,CLSE_TYPE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,'+
              'PAY_I,PAY_J,CREA_DATE,CREA_USER,COMM,TIME_STAMP) values('''+NewId(FieldbyName('SHOP_ID').AsString)+''',:TENANT_ID,:SHOP_ID,:CLSE_DATE,:CLSE_MNY,:CLSE_TYPE,:PAY_A,:PAY_B,:PAY_C,'+
              ':PAY_D,:PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,'''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
       AGlobal.ExecSQL(Str,Self);
     end;
  result := true;
end;

function TCloseForDayV60.CheckNotExistPosCloseRecord(AGlobal: IdbHelp):Boolean;
var
  rs:TZQuery;
begin
  result:=false;
  rs:=TZQuery.Create(nil);
  try
    rs.SQL.Text:= 'select count(*) as resum from ACC_CLOSE_FORDAY '+
                  ' where TENANT_ID='+FieldByName('TENANT_ID').AsString+' and CLSE_TYPE='''+FieldByName('CLSE_TYPE').AsString+''' and SHOP_ID='''+FieldByName('SHOP_ID').AsString+''''+
                  ' and CLSE_DATE='+FieldByName('CLSE_DATE').AsString+' and CREA_USER='''+FieldByName('CREA_USER').AsString+''' ';
    AGlobal.Open(rs);
    result := (rs.FieldByName('resum').AsInteger = 0);
  finally
    rs.Free;
  end;
end;

procedure TCloseForDayV60.InitClass;
begin
  inherited;
  IsSQLUpdate := true;
end;

initialization
  RegisterClass(TCloseForDayV60);
finalization
  UnRegisterClass(TCloseForDayV60);
end.
