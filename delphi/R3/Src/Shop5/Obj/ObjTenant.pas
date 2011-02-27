unit ObjTenant;

interface
uses SysUtils,ZBase,Classes, AdoDb,ZIntf,ObjCommon,ZDataset,uDsUtil;

type
  TTenant = class(TZFactory)
  private
    //记录行集新增检测函数，返回值是True 则可以新增当前记录
    function BeforeInsertRecord(AGlobal: IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 则可以修改当前记录
    function BeforeModifyRecord(AGlobal: IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

{ TTenant }

function TTenant.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str,shopid,dutyid: String;
begin
  Result := False;
  case AGlobal.iDbType of
  0:shopid := 'convert(varchar,:TENANT_ID)+''10001''';
  1:shopid := 'to_char(:TENANT_ID)||''10001''';
  4:shopid := 'str(:TENANT_ID)||''10001''';
  5:shopid := 'cast(:TENANT_ID as varchar)||'10001'';
  end;
  Str := 'insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(0,''TENANT_ID'',:TENANT_ID,0,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,''USING_DATE'','''+formatDatetime('YYYY-MM-DD',Date())+''',0,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into CA_SHOP_INFO(SHOP_ID,LICENSE_CODE,SHOP_NAME,SHOP_SPELL,SHOP_TYPE,TENANT_ID,REGION_ID,SEQ_NO,LINKMAN,'+
  'TELEPHONE,ADDRESS,POSTALCODE,FAXES,COMM,TIME_STAMP) values('+shopid+',:LICENSE_CODE,:SHORT_TENANT_NAME,:TENANT_SPELL,'+
  '''1'',:TENANT_ID,:REGION_ID,1,:LINKMAN,:TELEPHONE,:ADDRESS,:POSTALCODE,:FAXES,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);

  //管理组 CODE_TYPE=12
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1'',''总店'',''ZD'',''12'',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //结算方式 CODE_TYPE=6
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1'',''现金'',''XJ'',''6'',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''2'',''记账'',''JZ'',''6'',2,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //销售方式 CODE_TYPE=2
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1'',''门店销售'',''MDXS'',''2'',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''2'',''集团销售'',''JTXS'',''2'',2,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //收支项目 CODE_TYPE=3
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1'',''销售收入'',''XSSR'',''3'',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''2'',''销售成本'',''XSCB'',''3'',2,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''3'',''应交税金'',''YJSJ'',''3'',3,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''4'',''应付工资'',''YFGZ'',''3'',4,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''5'',''管理费用'',''GLFY'',''3'',5,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //为每个门店初始化现金账户
  Str := 'insert into ACC_ACCOUNT_INFO(TENANT_ID,SHOP_ID,ACCOUNT_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,comm,time_stamp)'+
  ' values(:TENANT_ID,'+shopid+','''+TSequence.NewId+''',''现金'',''XJ'',''A'',0,0,0,0,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //为企业初始化管理员
  Str := 'insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,''ADMIN'',''admin'',0,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,''PASSWRD'',''79415A40'',0,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  case AGlobal.iDbType of
  0:shopid := 'convert(varchar,:TENANT_ID)+''1001''';
  1:shopid := 'to_char(:TENANT_ID)||''1001''';
  4:shopid := 'str(:TENANT_ID)||''1001''';
  5:shopid := 'cast(:TENANT_ID as varchar)||'1001'';
  end;
  //为企业初始化职务
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''老板'',''001'',''LB'',''企业经营者'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''店长'',''001001'',''DZ'',''门店管理者'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''收银员'',''001001001'',''SYY'',''门店收银负责人'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''导购员'',''001001002'',''DGY'',''门店业务负责人'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);

  //为企业初始化部门
  Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''总店'',''001'',''ZD'',''后台仓库'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  //初始化会员等级
  Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP)'+
  'values(:TENANT_ID,'''+TSequence.NewId+''',''普通会员'',''PTFY'',0,0,0,0,0,0,1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);

  Result := True;

end;

function TTenant.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: String;
begin
  // zhangsenrong 20110-01-26 COMM 传为公共涵数
  Str := 'update CA_SHOP_INFO set LICENSE_CODE=:LICENSE_CODE,SHOP_NAME=:SHORT_TENANT_NAME,SHOP_SPELL=:TENANT_SPELL,TENANT_ID=:TENANT_ID,'+
         'COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where SHOP_ID=:OLD_TENANT_ID * 10000+1';
  AGlobal.ExecSQL(Str,self);
  //
  Result := True;
end;

procedure TTenant.InitClass;
var Str: String;
begin
  inherited;
  KeyFields := 'TENANT_ID';
  SelectSQL.Text := 'Select TENANT_ID,LICENSE_CODE,LOGIN_NAME,TENANT_NAME,TENANT_TYPE,SHORT_TENANT_NAME,TENANT_SPELL,LEGAL_REPR,LINKMAN,TELEPHONE,FAXES,'+
                    'HOMEPAGE,QQ,MSN,ADDRESS,POSTALCODE,REMARK,PASSWRD,REGION_ID,SRVR_ID,PROD_ID,AUDIT_STATUS From CA_TENANT where TENANT_ID=:TENANT_ID';
  IsSQLUpdate := True;
  Str := 'INSERT INTO CA_TENANT (TENANT_ID,LICENSE_CODE,LOGIN_NAME,TENANT_NAME,TENANT_TYPE,SHORT_TENANT_NAME,TENANT_SPELL,LEGAL_REPR,LINKMAN,TELEPHONE,FAXES,'+
         'HOMEPAGE,QQ,MSN,ADDRESS,POSTALCODE,REMARK,PASSWRD,REGION_ID,SRVR_ID,PROD_ID,AUDIT_STATUS,COMM,TIME_STAMP) VALUES (:TENANT_ID,:LICENSE_CODE,:LOGIN_NAME,:TENANT_NAME,:TENANT_TYPE,:SHORT_TENANT_NAME,'+
         ':TENANT_SPELL,:LEGAL_REPR,:LINKMAN,:TELEPHONE,:FAXES,:HOMEPAGE,:QQ,:MSN,:ADDRESS,:POSTALCODE,:REMARK,:PASSWRD,:REGION_ID,:SRVR_ID,:PROD_ID,:AUDIT_STATUS,''00'','+GetTimeStamp(iDbType)+')';

  InsertSQL.Add(Str);
  Str := 'UPDATE CA_TENANT SET LOGIN_NAME=:LOGIN_NAME,TENANT_NAME=:TENANT_NAME,LICENSE_CODE=:LICENSE_CODE,TENANT_TYPE=:TENANT_TYPE,SHORT_TENANT_NAME=:SHORT_TENANT_NAME,'+
         'TENANT_SPELL=:TENANT_SPELL,LEGAL_REPR=:LEGAL_REPR,LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,FAXES=:FAXES,HOMEPAGE=:HOMEPAGE,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,'+
         'REMARK=:REMARK,QQ=:QQ,MSN=:MSN,PASSWRD=:PASSWRD,REGION_ID=:REGION_ID,SRVR_ID=:SRVR_ID,AUDIT_STATUS=:AUDIT_STATUS,TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Add(Str);
end;


initialization
  RegisterClass(TTenant);
finalization
  UnRegisterClass(TTenant);

end.
