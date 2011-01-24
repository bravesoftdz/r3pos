unit ObjTenant;

interface
uses SysUtils,ZBase,Classes, AdoDb,ZIntf,ObjCommon,ZDataset;

type
  TTenant = class(TZFactory)
  private
    //记录行集新增检测函数，返回值是True 则可以新增当前记录
    function BeforeInsertRecord(AGlobal: IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

{ TTenant }

function TTenant.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str: String;
begin
  Str := 'Insert into SYS_DEFINE (COMP_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' VALUES(''---'',''TENANT_ID'','+FieldbyName('TENANT_ID').AsString+',0,''00'','+GetTimeStamp(5)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'Insert Into CA_SHOP_INFO (SHOP_ID,SHOP_NAME,SHOP_SPELL,TENANT_ID,COMM,TIME_STAMP) VALUES('+FieldbyName('TENANT_ID').AsString+'0001,'+
  ''''+FieldbyName('TENANT_NAME').AsString+''','''+FieldbyName('TENANT_SPELL').AsString+''','''+FieldbyName('TENANT_ID').AsString+''',''00'','+GetTimeStamp(5)+')';
  AGlobal.ExecSQL(Str,Self);
  Result := True;

end;

procedure TTenant.InitClass;
var Str: String;
begin
  inherited;
  KeyFields := 'TENANT_ID';
  SelectSQL.Text := 'Select TENANT_ID,LOGIN_NAME,TENANT_NAME,TENANT_TYPE,SHORT_TENANT_NAME,TENANT_SPELL,LEGAL_REPR,LINKMAN,TELEPHONE,FAXES,'+
                    'HOMEPAGE,ADDRESS,POSTALCODE,REMARK,PASSWRD,REGION_ID,SRVR_ID From CA_TENANT where COMM not in (''02'',''12'')';
  IsSQLUpdate := True;
  Str := 'INSERT INTO CA_TENANT (TENANT_ID,LOGIN_NAME,TENANT_NAME,TENANT_TYPE,SHORT_TENANT_NAME,TENANT_SPELL,LEGAL_REPR,LINKMAN,TELEPHONE,FAXES,'+
         'HOMEPAGE,ADDRESS,POSTALCODE,REMARK,PASSWRD,REGION_ID,SRVR_ID,COMM,TIME_STAMP) VALUES (:TENANT_ID,:LOGIN_NAME,:TENANT_NAME,:TENANT_TYPE,:SHORT_TENANT_NAME,'+
         ':TENANT_SPELL,:LEGAL_REPR,:LINKMAN,:TELEPHONE,:FAXES,:HOMEPAGE,:ADDRESS,:POSTALCODE,:REMARK,:PASSWRD,:REGION_ID,:SRVR_ID,''00'','+GetTimeStamp(5)+')';

  InsertSQL.Add(Str);
  Str := 'UPDATE CA_TENANT SET LOGIN_NAME=:LOGIN_NAME,TENANT_NAME=:TENANT_NAME,TENANT_TYPE=:TENANT_TYPE,SHORT_TENANT_NAME=:SHORT_TENANT_NAME,'+
         'TENANT_SPELL=:TENANT_SPELL,LEGAL_REPR=:LEGAL_REPR,LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,FAXES=:FAXES,HOMEPAGE=:HOMEPAGE,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,'+
         'REMARK=:REMARK,PASSWRD=:PASSWRD,REGION_ID=:REGION_ID,SRVR_ID=:SRVR_ID,TIME_STAMP='+GetTimeStamp(5)+' where TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Add(Str);
end;

initialization
  RegisterClass(TTenant);
finalization
  UnRegisterClass(TTenant);

end.
