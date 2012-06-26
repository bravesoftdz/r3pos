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
  str,UpStr,UserID: string;
begin
   Str:='';
   UpStr:='COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType);
   case self.FieldByName('vTYPE').AsInteger of
    1: Str:='Update CA_SHOP_INFO Set SUBJECT_NO=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID ';
    2: Str:='Update CA_DEPT_INFO Set SUBJECT_NO=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and DEPT_ID=:DEPT_ID';
    3:
     begin
       UserID:=trim(UpperCase(FieldByName('USER_ID').AsString));
       if (UserID='ADMIN') or (UserID='SYSTEM') then
       begin
         UserID:=UserID+'_SUBJECT_NO';
         //先更新
         Str:='Update SYS_DEFINE Set VALUE=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and DEFINE='''+UserID+''' ';
         if AGlobal.ExecSQL(Str,self)<>1 then //若不存在则插入
         begin
           Str:='insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) '+
                ' values (:TENANT_ID,'''+UserID+''',:SUBJECT_NO,0,''00'','+GetTimeStamp(iDbType)+')';
           AGlobal.ExecSQL(Str,self);
         end;
         Str:='';
       end else
         Str:='Update CA_USERS Set SUBJECT_NO=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and USER_ID=:USER_ID';
     end;
    4: Str:='Update PUB_CLIENTINFO Set SUBJECT_NO=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID';
    5: Str:='Update PUB_CODE_INFO Set CODE_NAME=:CNAME,CODE_SPELL=:SUBJECT_NO,'+UpStr+' Where TENANT_ID=:TENANT_ID and CODE_ID=:CODE_ID and CODE_TYPE=:CODE_TYPE';
   end;
   if Str<>'' then 
     AGlobal.ExecSQL(Str,self);
end;

function TFvchIntfSet.BeforeOpenRecord(AGlobal:IdbHelp):Boolean;
var
  str,DefTab: string;
begin
  case self.Params.ParamByName('vTYPE').AsInteger of  //1 as SEQ_NO,
   0: Str:='Select 1 as vTYPE,TENANT_ID,SHOP_ID,SHOP_NAME as CNAME,SUBJECT_NO From CA_SHOP_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')';
   1: Str:='Select 2 as vTYPE,TENANT_ID,DEPT_ID,DEPT_NAME as CNAME,SUBJECT_NO From CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')';
   2:
    begin
      DefTab:=
        'select (case when DEFINE=''ADMIN_SUBJECT_NO'' then ''admin'' '+
                    ' when DEFINE=''SYSTEM_SUBJECT_NO'' then ''system'' '+
                    ' else '''' end) as DEFINE,VALUE '+
        ' from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE in (''ADMIN_SUBJECT_NO'',''SYSTEM_SUBJECT_NO'')';

      Str:='Select 3 as vTYPE,a.TENANT_ID,a.USER_ID,a.USER_NAME as CNAME,'+
           ' (case when a.USER_ID in (''admin'',''system'') then c.VALUE else b.SUBJECT_NO end)as SUBJECT_NO from '+
           ' VIW_USERS a '+
           ' left outer join CA_USERS b on a.TENANT_ID=b.TENANT_ID and a.USER_ID=b.USER_ID '+
           ' left outer join ('+DefTab+')c on a.USER_ID=c.DEFINE '+
           ' where a.TENANT_ID=:TENANT_ID and a.COMM not in (''02'',''12'')';
    end;
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
