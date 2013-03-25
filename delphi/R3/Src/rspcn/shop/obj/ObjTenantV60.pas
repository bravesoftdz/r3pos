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

  //为企业初始化管理员
  Str := 'insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,''ADMIN'',''admin'',0,''00'',5497000)';
  AGlobal.ExecSQL(Str,self);
  Str := 'insert into SYS_DEFINE(TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,''PASSWRD'',''79415A40'',0,''00'',5497000)';
  AGlobal.ExecSQL(Str,self);

  //初始化打印限制
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
      //管理组 CODE_TYPE=12
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''CA73FC48-985B-4EE7-9BDA-B7D638BD25F6'',''总店'',''ZD'',''12'',1,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);

      //结算方式 CODE_TYPE=6
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''4C430A2C-0C43-41A9-A286-4EF5AD0E041F'',''现金'',''XJ'',''6'',1,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''62E7AC45-959E-4727-962F-A4098614A711'',''记账'',''JZ'',''6'',2,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
                                  
      //销售方式 CODE_TYPE=2
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''6BD82B9E-3678-4F33-89ED-B8C26B6589BD'',''门店销售'',''MDXS'',''2'',1,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''86329D7D-97D8-4031-9F0B-64F343104831'',''业务销售'',''JTXS'',''2'',2,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''FB72FAEF-9615-4F05-BA46-46D75728CD98'',''电话销售'',''DHXS'',''2'',3,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''F58DD749-7059-4F81-8933-0CEE71F0B88F'',''网络销售'',''WLXS'',''2'',4,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);

      //用途 CODE_TYPE=16
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''01'',''自用'',''ZY'',''17'',1,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''02'',''馈赠礼品'',''KZLP'',''17'',2,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''03'',''团体消费'',''TTXH'',''17'',3,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''04'',''婚丧嫁娶'',''FSJQ'',''17'',4,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''05'',''其他'',''QT'',''17'',5,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);

      //收支项目 CODE_TYPE=3
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''1EB4EFEB-2CF5-4CF0-99AF-1F07410A7E90'',''销售收入'',''XSSR'',''3'',1,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''839B0E48-BFD2-40AE-9E0B-AD666AC4416B'',''销售成本'',''XSCB'',''3'',2,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''EDAE15F5-6CCE-4CFA-B071-ED601AE074D1'',''应交税金'',''YJSJ'',''3'',3,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''C82A681A-E956-40CC-ABA2-2FCA46136255'',''应付工资'',''YFGZ'',''3'',4,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''291A4198-8AAC-46F7-8AB0-193189BF82EC'',''管理费用'',''GLFY'',''3'',5,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''6E3CB7C8-C3B8-48D6-B508-F8D98ED6253C'',''市场费用'',''SCFY'',''3'',6,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''206FEBCB-6550-4EA0-A8E6-E8728AADA1BA'',''销售返利'',''XSFL'',''3'',6,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''B43EF134-66A1-41DF-A921-EFD76198307F'',''固定保证金'',''GDBZJ'',''3'',6,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_CODE_INFO(tenant_id,code_id,code_name,code_spell,code_type,seq_no,comm,time_stamp)'+
      ' values(:TENANT_ID,''E9AED0B1-050C-4EFB-AA7A-0A64FE45EF97'',''滚动保证金'',''GDBZJ'',''3'',6,''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
    end;
                           
    if not GetDutyInfo then
    begin
      //为企业初始化职务
      Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''老板'',''001'',''LB'',''企业经营者'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'002'+''',''店长'',''001001'',''DZ'',''门店管理者'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'003'+''',''收银'',''001001001'',''SY'',''门店收银负责人'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'004'+''',''导购'',''001001002'',''DG'',''门店业务负责人'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'005'+''',''财务'',''001002'',''CW'',''财务管理者'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_DUTY_INFO (TENANT_ID,DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'006'+''',''仓管'',''001003'',''CG'',''仓库管理者'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
    end;

    if not GetRoleInfo then
    begin
      //为企业初始化角色
      Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''老板'',''LB'',''企业经营者拥有所有模块权限'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'002'+''',''店长'',''DZ'',''拥有门店管理所需相关权限'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'003'+''',''收银'',''SY'',''拥有销售及收款开单所需相关权限'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'005'+''',''财务'',''CW'',''拥有财务管理所需相关权限'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str :='insert into CA_ROLE_INFO (TENANT_ID,ROLE_ID,ROLE_NAME,ROLE_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'006'+''',''仓管'',''CG'',''拥有存货管理所需相关权限'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
    end;

    if not GetDeptInfo then
    begin
      //为企业初始化部门
      Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'001'+''',''营销部'',''1'',''001'',''YXB'',''业务销售部门'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'002'+''',''综合部'',''3'',''002'',''ZHB'',''行政人事后台管理部门'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'003'+''',''财务部'',''2'',''003'',''CWB'',''财务会计及统计部门'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into CA_DEPT_INFO (TENANT_ID,DEPT_ID,DEPT_NAME,DEPT_TYPE,LEVEL_ID,DEPT_SPELL,REMARK,COMM,TIME_STAMP)'+
      ' values(:TENANT_ID,'''+Params.ParambyName('TENANT_ID').AsString+'004'+''',''拓展部'',''3'',''004'',''TZB'',''企业发展策略经营管理部'',''00'',5497000)';
      AGlobal.ExecSQL(Str,Params);
    end;

    if not GetGradeInfo then
    begin
      //初始化会员等级
      Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP,PRICE_TYPE)'+
      'values(:TENANT_ID,''332E5CE8-D1FC-4D53-84C3-2A1EB07EF8AA'',''银卡'',''YK'',0,0,0,0,0,0,1,''00'',5497000,''1'')';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP,PRICE_TYPE)'+
      'values(:TENANT_ID,''26AB5597-5AA5-49BC-8CBF-7A332CB1B6FA'',''金卡'',''JK'',0,0,0,0,0,0,1,''00'',5497000,''1'')';
      AGlobal.ExecSQL(Str,Params);
      Str := 'insert into PUB_PRICEGRADE(TENANT_ID,PRICE_ID,PRICE_NAME,PRICE_SPELL,INTEGRAL,INTE_TYPE,INTE_AMOUNT,MINIMUM_PERCENT,AGIO_TYPE,AGIO_PERCENT,SEQ_NO,COMM,TIME_STAMP,PRICE_TYPE)'+
      'values(:TENANT_ID,''4433497A-0A2E-4D72-BE0B-723850A6EFE8'',''钻石'',''ZS'',0,0,0,0,0,0,1,''00'',5497000,''1'')';
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
