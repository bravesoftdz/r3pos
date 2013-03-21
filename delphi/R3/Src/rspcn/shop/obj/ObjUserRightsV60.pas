unit ObjUserRightsV60;

interface

uses SysUtils,zBase,Classes, AdoDb,ZIntf,ObjCommon,ZDataset;

type

  TInitRightV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TUserRolesListV60=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp; Params:TftParamList):Boolean;override;
  end;

implementation

function TInitRightV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  i: integer;
  FieldName: string;
  SqlStr: wideString;
begin
  result:=False;
  SqlStr:='';
  for i:=0 to self.Count-1 do
  begin
    FieldName:=trim(self.Fields[i].FieldName);
    if Copy(FieldName,1,3)='SQL' then
    begin
      SqlStr:=SqlStr+self.Fields[i].AsString;
    end;
  end;
  if trim(SqlStr)<>'' then
  begin
    AGlobal.ExecSQL(SqlStr);
    result:=true;
  end;
end;

function TUserRolesListV60.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var str: string;
begin
  result:=false;
  try
    str:='update CA_USERS set ROLE_IDS=:ROLE_IDS,ROLE_NAMES=:ROLE_NAMES,COMM=''01'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' '+
         'where TENANT_ID=:TENANT_ID and USER_ID=:USER_ID ';
    AGlobal.ExecSQL(Str,Params);
    result := true;
  except
    on E:Exception do
       Msg := E.Message;
  end;  
end;

initialization
  RegisterClass(TInitRightV60);
  RegisterClass(TUserRolesListV60);
finalization
  UnRegisterClass(TInitRightV60);
  UnRegisterClass(TUserRolesListV60);
end.
