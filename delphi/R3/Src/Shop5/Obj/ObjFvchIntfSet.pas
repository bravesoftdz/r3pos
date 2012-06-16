unit ObjFvchIntfSet;

interface

uses
  SysUtils, zBase, Classes, ZIntf, ObjCommon, ZDataset, DB;

type
 TFvchIntfSet =class(TZFactory)
 public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
 end;


implementation

function TFvchIntfSet.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  str,UpStr: string;
begin
   UpStr:='COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType);
   case self.FieldByName('vTYPE').AsInteger of
    1: Str:='Update CA_SHOP_INFO Set SUBJECT_NO=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID ';
    2: Str:='Update CA_DEPT_INFO Set SUBJECT_NO=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and DEPT_ID=:DEPT_ID';
    3: Str:='Update CA_USERS Set SUBJECT_NO=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and USER_ID=:USER_ID';
    4: Str:='Update PUB_CLIENTINFO Set SUBJECT_NO=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID';
    5: Str:='Update PUB_CODE_INFO Set CODE_NAME=:CNAME,CODE_SPELL=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and CODE_ID=:CODE_ID and CODE_TYPE=:CODE_TYPE';
   end;
   AGlobal.ExecSQL(Str,self);
end;

function TFvchIntfSet.BeforeOpenRecord(AGlobal:IdbHelp):Boolean;
var
  str: string;
begin
  case self.Params.ParamByName('vTYPE').AsInteger of  //1 as SEQ_NO,
   0: Str:='Select 1 as vTYPE,TENANT_ID,SHOP_ID,SHOP_NAME as CNAME,SUBJECT_NO From CA_SHOP_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')';
   1: Str:='Select 2 as vTYPE,TENANT_ID,DEPT_ID,DEPT_NAME as CNAME,SUBJECT_NO From CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')';
   2: Str:='Select 3 as vTYPE,TENANT_ID,USER_ID,USER_NAME as CNAME,SUBJECT_NO From CA_USERS where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')';
   3: Str:='Select 4 as vTYPE,TENANT_ID,CLIENT_ID,CLIENT_NAME as CNAME,SUBJECT_NO From PUB_CLIENTINFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')';
   4: Str:='Select 5 as vTYPE,TENANT_ID,CODE_ID,CODE_SPELL as SUBJECT_NO,CODE_TYPE,CODE_NAME as CNAME From PUB_CODE_INFO where TENANT_ID=:TENANT_ID and CODE_TYPE=''20'' and COMM not in (''02'',''12'')';
  end;
  SelectSQL.Text:=str;
end;

initialization
  RegisterClass(TFvchIntfSet);


finalization
  UnRegisterClass(TFvchIntfSet);


end.
