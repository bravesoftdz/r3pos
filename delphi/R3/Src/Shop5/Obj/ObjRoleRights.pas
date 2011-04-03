unit ObjRoleRights;

interface
  uses Dialogs,SysUtils,zBase,Classes,zIntf,ObjCommon;

type
  TRoleRigths=class(TZFactory)
  public
    procedure InitClass;override;
  end;

implementation

{ TRigths }

procedure TRoleRigths.InitClass;
var
  Str:string;
begin
  inherited;
  SelectSQL.Text:= 'select ROWS_ID,TENANT_ID,MODU_ID,ROLE_ID,ROLE_TYPE,case when COMM in (''02'',''12'') then 0 else CHK end as CHK from CA_RIGHTS where ROLE_TYPE=1 and TENANT_ID=:TENANT_ID and ROLE_ID=:ROLE_ID ';

  Str := 'insert into CA_RIGHTS(ROWS_ID,TENANT_ID,MODU_ID,ROLE_ID,ROLE_TYPE,CHK,COMM,TIME_STAMP) '+
         ' values(:ROWS_ID,:TENANT_ID,:MODU_ID,:ROLE_ID,:ROLE_TYPE,:CHK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);

  Str:='update CA_RIGHTS set TENANT_ID=:TENANT_ID,MODU_ID=:MODU_ID,ROLE_ID=:ROLE_ID,ROLE_TYPE=:ROLE_TYPE,CHK=:CHK,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ';
  UpdateSQL.Add(Str);

  DeleteSQL.Add('update CA_RIGHTS set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID ');
end;

initialization
  RegisterClass(TRoleRigths);
finalization
  UnRegisterClass(TRoleRigths);
end.
