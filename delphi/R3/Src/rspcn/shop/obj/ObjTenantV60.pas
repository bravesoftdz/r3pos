unit ObjTenantV60;

interface

uses SysUtils,ZBase,Classes, ZIntf,ObjCommon,ZDataset;

type
  TTenantV60=class(TZFactory)
  private
    function BeforeInsertRecord(AGlobal: IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal: IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

  TTenantInitV60=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

function TTenantV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str: String;
begin
  result := false;

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

  //��ʼ����ӡ����
  Str := 'insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) '+
         'select  '+FieldByName('TENANT_ID').AsString+',''ORDER_'''+GetStrJoin(AGlobal.iDbType)+'A.CODE_ID as DEFINE,''-1'',0,''00'',5497000 '+
         'from    (select * from PUB_PARAMS where TYPE_CODE=''BILL_NAME'') A ';
  AGlobal.ExecSQL(Str,self);

  result := true;
end;

function TTenantV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: String;
begin
  Str := 'update CA_SHOP_INFO set LICENSE_CODE=:LICENSE_CODE,SHOP_NAME=:SHORT_TENANT_NAME,SHOP_SPELL=:TENANT_SPELL,TENANT_ID=:TENANT_ID,'+
         'COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID='''+FieldbyName('TENANT_ID').AsString+'0001''';
  AGlobal.ExecSQL(Str,self);
  result := true;
end;

procedure TTenantV60.InitClass;
var Str: String;
begin
  inherited;
  KeyFields:='TENANT_ID';
  SelectSQL.Text := 'select TENANT_ID,LICENSE_CODE,LOGIN_NAME,TENANT_NAME,TENANT_TYPE,SHORT_TENANT_NAME,TENANT_SPELL,LEGAL_REPR,LINKMAN,TELEPHONE,FAXES,'+
                    'HOMEPAGE,QQ,MSN,ADDRESS,POSTALCODE,REMARK,PASSWRD,REGION_ID,SRVR_ID,PROD_ID,AUDIT_STATUS from CA_TENANT where TENANT_ID=:TENANT_ID';
  IsSQLUpdate := true;

  Str := 'insert into CA_TENANT (TENANT_ID,LICENSE_CODE,LOGIN_NAME,TENANT_NAME,TENANT_TYPE,SHORT_TENANT_NAME,TENANT_SPELL,LEGAL_REPR,LINKMAN,TELEPHONE,FAXES,'+
         'HOMEPAGE,QQ,MSN,ADDRESS,POSTALCODE,REMARK,PASSWRD,REGION_ID,SRVR_ID,PROD_ID,AUDIT_STATUS,COMM,TIME_STAMP) VALUES (:TENANT_ID,:LICENSE_CODE,:LOGIN_NAME,:TENANT_NAME,:TENANT_TYPE,:SHORT_TENANT_NAME,'+
         ':TENANT_SPELL,:LEGAL_REPR,:LINKMAN,:TELEPHONE,:FAXES,:HOMEPAGE,:QQ,:MSN,:ADDRESS,:POSTALCODE,:REMARK,:PASSWRD,:REGION_ID,:SRVR_ID,:PROD_ID,:AUDIT_STATUS,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);

  Str := 'update CA_TENANT set LOGIN_NAME=:LOGIN_NAME,TENANT_NAME=:TENANT_NAME,LICENSE_CODE=:LICENSE_CODE,TENANT_TYPE=:TENANT_TYPE,SHORT_TENANT_NAME=:SHORT_TENANT_NAME,'+
         'TENANT_SPELL=:TENANT_SPELL,LEGAL_REPR=:LEGAL_REPR,LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,FAXES=:FAXES,HOMEPAGE=:HOMEPAGE,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,'+
         'REMARK=:REMARK,QQ=:QQ,MSN=:MSN,PASSWRD=:PASSWRD,REGION_ID=:REGION_ID,SRVR_ID=:SRVR_ID,AUDIT_STATUS=:AUDIT_STATUS,TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Add(Str);
end;

function TTenantInitV60.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
function GetCodeInfo:boolean;
var
  Str: String;
  rs:TZQuery;
begin
  result := false;
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
end;
function GetDeptInfo:boolean;
var
  Str: String;
  rs:TZQuery;
begin
  result := false;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from CA_DEPT_INFO where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       begin
         result := true;
         Exit;
       end;
  finally
    rs.Free;
  end;
end;
function GetRoleInfo:boolean;
var
  Str: String;
  rs:TZQuery;
begin
  result := false;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from CA_ROLE_INFO where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       begin
         result := true;
         Exit;
       end;
  finally
    rs.Free;
  end;
end;
function GetDutyInfo:boolean;
var
  Str: String;
  rs:TZQuery;
begin
  result := false;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from CA_DUTY_INFO where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       begin
         result := true;
         Exit;
       end;
  finally
    rs.Free;
  end;
end;
function GetGradeInfo:boolean;
var
  Str: String;
  rs:TZQuery;
begin
  result := false;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from PUB_PRICEGRADE where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString+' and PRICE_TYPE=''1'' ';
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       begin
         result := true;
         Exit;
       end;
  finally
    rs.Free;
  end;
end;
var
  Str: String;
  rs:TZQuery;
begin
  result := false;
  AGlobal.BeginTrans;
  try
    if not GetCodeInfo then
    begin
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

      //��; CODE_TYPE=16
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''01'',''����'',''ZY'',''17'',1,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''02'',''������Ʒ'',''KZLP'',''17'',2,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''03'',''��������'',''TTXH'',''17'',3,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''04'',''��ɥ��Ȣ'',''FSJQ'',''17'',4,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''05'',''����'',''QT'',''17'',5,''00'',5497000)';
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
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''6E3CB7C8-C3B8-48D6-B508-F8D98ED6253C'',''�г�����'',''SCFY'',''3'',6,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''206FEBCB-6550-4EA0-A8E6-E8728AADA1BA'',''���۷���'',''XSFL'',''3'',6,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''B43EF134-66A1-41DF-A921-EFD76198307F'',''�̶���֤��'',''GDBZJ'',''3'',6,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''E9AED0B1-050C-4EFB-AA7A-0A64FE45EF97'',''������֤��'',''GDBZJ'',''3'',6,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
    end;
                           
    if not GetDutyInfo then
    begin
      //Ϊ��ҵ��ʼ��ְ��
      Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''�ϰ�'',''001'',''LB'',''��ҵ��Ӫ��'',''00'',5497000)';
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
    end;

    if not GetRoleInfo then
    begin
      //Ϊ��ҵ��ʼ����ɫ
      Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''�ϰ�'',''LB'',''��ҵ��Ӫ��ӵ������ģ��Ȩ��'',''00'',5497000)';
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
    end;

    if not GetDeptInfo then
    begin
      //Ϊ��ҵ��ʼ������
      Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''Ӫ����'',''1'',''001'',''YXB'',''ҵ�����۲���'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'002'+''',''�ۺϲ�'',''3'',''002'',''ZHB'',''�������º�̨������'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'003'+''',''����'',''2'',''003'',''CWB'',''�����Ƽ�ͳ�Ʋ���'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'004'+''',''��չ��'',''3'',''004'',''TZB'',''��ҵ��չ���Ծ�Ӫ����'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
    end;

    if not GetGradeInfo then
    begin
      //��ʼ����Ա�ȼ�
      Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP,PRICE_TYPE)'+
      'values(:TENANT_ID,''332E5CE8-D1FC-4D53-84C3-2A1EB07EF8AA'',''����'',''YK'',0,0,0,0,0,0,1,''00'',5497000,''1'')';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP,PRICE_TYPE)'+
      'values(:TENANT_ID,''26AB5597-5AA5-49BC-8CBF-7A332CB1B6FA'',''��'',''JK'',0,0,0,0,0,0,1,''00'',5497000,''1'')';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP,PRICE_TYPE)'+
      'values(:TENANT_ID,''4433497A-0A2E-4D72-BE0B-723850A6EFE8'',''��ʯ'',''ZS'',0,0,0,0,0,0,1,''00'',5497000,''1'')';
      AGlobal.ExecSQL(Str,Params);
    end;
    result := true;
    AGlobal.CommitTrans;
  except
    AGlobal.RollbackTrans;
    Raise;
  end;
end;

initialization
  RegisterClass(TTenantV60);
  RegisterClass(TTenantInitV60);
finalization
  UnRegisterClass(TTenantV60);
  UnRegisterClass(TTenantInitV60);
end.
