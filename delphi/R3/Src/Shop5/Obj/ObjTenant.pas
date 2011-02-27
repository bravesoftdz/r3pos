unit ObjTenant;

interface
uses SysUtils,ZBase,Classes, AdoDb,ZIntf,ObjCommon,ZDataset,uDsUtil;

type
  TTenant = class(TZFactory)
  private
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal: IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
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

  //������ CODE_TYPE=12
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1'',''�ܵ�'',''ZD'',''12'',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //���㷽ʽ CODE_TYPE=6
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1'',''�ֽ�'',''XJ'',''6'',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''2'',''����'',''JZ'',''6'',2,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //���۷�ʽ CODE_TYPE=2
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1'',''�ŵ�����'',''MDXS'',''2'',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''2'',''��������'',''JTXS'',''2'',2,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //��֧��Ŀ CODE_TYPE=3
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1'',''��������'',''XSSR'',''3'',1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''2'',''���۳ɱ�'',''XSCB'',''3'',2,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''3'',''Ӧ��˰��'',''YJSJ'',''3'',3,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''4'',''Ӧ������'',''YFGZ'',''3'',4,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''5'',''�������'',''GLFY'',''3'',5,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //Ϊÿ���ŵ��ʼ���ֽ��˻�
  Str := 'insert into ACC_ACCOUNT_INFO(TENANT_ID,SHOP_ID,ACCOUNT_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,comm,time_stamp)'+
  ' values(:TENANT_ID,'+shopid+','''+TSequence.NewId+''',''�ֽ�'',''XJ'',''A'',0,0,0,0,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,self);

  //Ϊ��ҵ��ʼ������Ա
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
  //Ϊ��ҵ��ʼ��ְ��
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''�ϰ�'',''001'',''LB'',''��ҵ��Ӫ��'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''�곤'',''001001'',''DZ'',''�ŵ������'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''����Ա'',''001001001'',''SYY'',''�ŵ�����������'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''����Ա'',''001001002'',''DGY'',''�ŵ�ҵ������'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);

  //Ϊ��ҵ��ʼ������
  Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'+dutyid+',''�ܵ�'',''001'',''ZD'',''��̨�ֿ�'',''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  //��ʼ����Ա�ȼ�
  Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP)'+
  'values(:TENANT_ID,'''+TSequence.NewId+''',''��ͨ��Ա'',''PTFY'',0,0,0,0,0,0,1,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);

  Result := True;

end;

function TTenant.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: String;
begin
  // zhangsenrong 20110-01-26 COMM ��Ϊ��������
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
