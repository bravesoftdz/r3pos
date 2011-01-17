unit ObjRoleInfo;

interface

uses
  Dialogs,SysUtils,zBase,Classes, ZDataSet,ZIntf,ObjCommon;

type
  TRoleInfo=class(TZFactory)
  public
    procedure InitClass;override;
  end;

  TRoleInfoDelete=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp; Params:TftParamList):Boolean;override;
  end;

implementation

{ TRole }

procedure TRoleInfo.InitClass;
var Str:string;
begin
  KeyFields:='ROLE_ID';
  //初始化查询
  SelectSQL.Text:='select ROLE_ID,ROLE_NAME,ROLE_SPELL,TENANT_ID,REMARK From CA_ROLE_INFO '+
                  ' where TENANT_ID=:TENANT_ID and ROLE_ID=:ROLE_ID';
  //初始化更新逻辑
  IsSQLUpdate := true;
  Str :='insert into CA_ROLE_INFO (ROLE_ID,ROLE_NAME,ROLE_SPELL,TENANT_ID,REMARK,COMM,TIME_STAMP) '+
        ' values (:ROLE_ID,:ROLE_NAME,:ROLE_SPELL,:TENANT_ID,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);
  Str :='update CA_ROLE_INFO set ROLE_NAME=:ROLE_NAME,ROLE_SPELL=:ROLE_SPELL,TENANT_ID=:TENANT_ID,REMARK=:REMARK '+
        ',COMM='+ GetCommStr(iDbType)+','+ 'TIME_STAMP='+GetTimeStamp(iDbType)+
        ' where TENANT_ID=:OLD_TENANT_ID and ROLE_ID=:OLD_ROLE_ID';
  UpdateSQL.Add(Str);
  Str := ' update CA_ROLE_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' where TENANT_ID=:OLD_TENANT_ID and ROLE_ID=:OLD_ROLE_ID';
  DeleteSQL.Add(Str);
end;

{ TRoleDelete }

function TRoleInfoDelete.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var
  Str: String;
  tmp:TZQuery;
begin
  Result:=False;
  try
    try
      tmp:=TZQuery.Create(nil);
      tmp.Close;
      tmp.SQL.Text:='Select Count(*) as ReSum from CA_USERS where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+
           ' and '';''+ROLE_IDS+'';'' like '';''+:ROLE_ID+'';''  ';
      tmp.Params.AssignValues(Params);
      AGlobal.Open(tmp);
      if tmp.Fields[0].AsInteger>0 then
        raise Exception.Create('角色'+Params.ParamByName('ROLE_NAME').asString+'有用户使用不能删除！');
      Str:='update CA_ROLE_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
          ' where TENANT_ID=:TENANT_ID and ROLE_ID=:ROLE_ID';
      AGlobal.ExecSQL(Str,Params);
    finally
      tmp.Free;
    end;
    Result:=True;
  except
    on E:Exception do
    begin
      Msg := E.Message;
    end;
  end;
end;

initialization
  RegisterClass(TRoleInfo);
  RegisterClass(TRoleInfoDelete);
finalization
  UnRegisterClass(TRoleInfo);
  UnRegisterClass(TRoleInfoDelete); 
end.

