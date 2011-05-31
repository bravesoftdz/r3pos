unit ObjTenant;

interface
uses SysUtils,ZBase,Classes, ZIntf,ObjCommon,ZDataset;

type
  TTenant = class(TZFactory)
  private
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal: IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal: IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

  TTenantInit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TTenant }

function TTenant.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str,shopid,dutyid: String;
begin
  Result := False;
  case AGlobal.iDbType of
  0:shopid := 'convert(varchar,:TENANT_ID)+''0001''';
  1:shopid := 'to_char(:TENANT_ID)||''0001''';
  4:shopid := ':TENANT_ID||''0001''';
  5:shopid := 'cast(:TENANT_ID as varchar)||''0001''';
  end;

  Str := 'insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,''USING_DATE'','''+formatDatetime('YYYY-MM-DD',Date())+''',0,''00'',5497000)';
  AGlobal.ExecSQL(Str,self);

  //Ϊ��ҵ��ʼ������Ա
  Str := 'insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,''ADMIN'',''admin'',0,''00'',5497000)';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,''PASSWRD'',''79415A40'',0,''00'',5497000)';
  AGlobal.ExecSQL(Str,self);

  Str := 'insert into CA_SHOP_INFO(SHOP_ID,LICENSE_CODE,SHOP_NAME,SHOP_SPELL,SHOP_TYPE,TENANT_ID,REGION_ID,SEQ_NO,LINKMAN,'+
  'TELEPHONE,ADDRESS,POSTALCODE,FAXES,COMM,TIME_STAMP) values('+shopid+',:LICENSE_CODE,:SHORT_TENANT_NAME,:TENANT_SPELL,'+
  '''CA73FC48-985B-4EE7-9BDA-B7D638BD25F6'',:TENANT_ID,:REGION_ID,1001,:LINKMAN,:TELEPHONE,:ADDRESS,:POSTALCODE,:FAXES,''00'',5497000)';
  AGlobal.ExecSQL(Str,Self);

  //Ϊÿ���ŵ��ʼ���ֽ��˻�
  Str := 'insert into ACC_ACCOUNT_INFO(TENANT_ID,SHOP_ID,ACCOUNT_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,comm,time_stamp)'+
  ' values(:TENANT_ID,'+shopid+','''+FieldbyName('TENANT_ID').asString+'000100000000000000000000000'+''',''�ֽ�'',''XJ'',''A'',0,0,0,0,''00'',5497000)';
  AGlobal.ExecSQL(Str,self);
  Result := True;

end;

function TTenant.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: String;
begin
  // zhangsenrong 20110-01-26 COMM ��Ϊ��������
  Str := 'update CA_SHOP_INFO set LICENSE_CODE=:LICENSE_CODE,SHOP_NAME=:SHORT_TENANT_NAME,SHOP_SPELL=:TENANT_SPELL,TENANT_ID=:TENANT_ID,'+
         'COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID='''+FieldbyName('TENANT_ID').AsString+'0001''';
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


{ TTenantInit }

function TTenantInit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  Str: String;
  rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_CODE_INFO where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       begin
         result := true;
         Exit;
       end;
  finally
    rs.Free;
  end;
AGlobal.BeginTrans;
try
  //������ CODE_TYPE=12
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''CA73FC48-985B-4EE7-9BDA-B7D638BD25F6'',''�ܵ�'',''ZD'',''12'',1,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);

  //���㷽ʽ CODE_TYPE=6        
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''4C430A2C-0C43-41A9-A286-4EF5AD0E041F'',''�ֽ�'',''XJ'',''6'',1,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''62E7AC45-959E-4727-962F-A4098614A711'',''����'',''JZ'',''6'',2,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
                                  
  //���۷�ʽ CODE_TYPE=2
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''6BD82B9E-3678-4F33-89ED-B8C26B6589BD'',''�ŵ�����'',''MDXS'',''2'',1,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''86329D7D-97D8-4031-9F0B-64F343104831'',''ҵ������'',''JTXS'',''2'',2,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''FB72FAEF-9615-4F05-BA46-46D75728CD98'',''�绰����'',''DHXS'',''2'',3,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''F58DD749-7059-4F81-8933-0CEE71F0B88F'',''��������'',''WLXS'',''2'',4,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);

  //��֧��Ŀ CODE_TYPE=3        
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''1EB4EFEB-2CF5-4CF0-99AF-1F07410A7E90'',''��������'',''XSSR'',''3'',1,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''839B0E48-BFD2-40AE-9E0B-AD666AC4416B'',''���۳ɱ�'',''XSCB'',''3'',2,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''EDAE15F5-6CCE-4CFA-B071-ED601AE074D1'',''Ӧ��˰��'',''YJSJ'',''3'',3,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''C82A681A-E956-40CC-ABA2-2FCA46136255'',''Ӧ������'',''YFGZ'',''3'',4,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
  ' values(:TENANT_ID,''291A4198-8AAC-46F7-8AB0-193189BF82EC'',''�������'',''GLFY'',''3'',5,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);

  //Ϊ��ҵ��ʼ��ְ��
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''�ܾ���'',''001'',''LB'',''��ҵ��Ӫ��'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'002'+''',''�곤'',''001001'',''DZ'',''�ŵ������'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'003'+''',''����'',''001001001'',''SY'',''�ŵ�����������'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'004'+''',''����'',''001001002'',''DG'',''�ŵ�ҵ������'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'005'+''',''����'',''001002'',''CW'',''���������'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'006'+''',''�ֹ�'',''001003'',''CG'',''�ֿ������'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);

  //Ϊ��ҵ��ʼ����ɫ
  Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''����'',''LB'',''��ҵ��Ӫ��ӵ������ģ��Ȩ��'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'002'+''',''�곤'',''DZ'',''ӵ���ŵ�����������Ȩ��'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'003'+''',''����'',''SY'',''ӵ�����ۼ��տ���������Ȩ��'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'005'+''',''����'',''CW'',''ӵ�в�������������Ȩ��'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'006'+''',''�ֹ�'',''CG'',''ӵ�д�������������Ȩ��'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);

  //Ϊ��ҵ��ʼ������
  Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''Ӫ����'',''1'',''001'',''ZD'',''ҵ�����۲���'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'002'+''',''�ۺϲ�'',''3'',''002'',''ZD'',''�������º�̨������'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'003'+''',''����'',''2'',''003'',''ZD'',''�����Ƽ�ͳ�Ʋ���'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'004'+''',''��չ��'',''3'',''004'',''ZD'',''��ҵ��չ���Ծ�Ӫ����'',''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);

  //��ʼ����Ա�ȼ�
  Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP)'+
  'values(:TENANT_ID,''332E5CE8-D1FC-4D53-84C3-2A1EB07EF8AA'',''����'',''YK'',0,0,0,0,0,0,1,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP)'+
  'values(:TENANT_ID,''26AB5597-5AA5-49BC-8CBF-7A332CB1B6FA'',''��'',''JK'',0,0,0,0,0,0,1,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);
  Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP)'+
  'values(:TENANT_ID,''4433497A-0A2E-4D72-BE0B-723850A6EFE8'',''��ʯ'',''ZS'',0,0,0,0,0,0,1,''00'',5497000)';
  AGlobal.ExecSQL(Str,Params);

  Result := True;
  AGlobal.CommitTrans;
except
  AGlobal.RollbackTrans;
  Raise;
end;
end;

initialization
  RegisterClass(TTenant);
  RegisterClass(TTenantInit);
finalization
  UnRegisterClass(TTenant);
  UnRegisterClass(TTenantInit);

end.
