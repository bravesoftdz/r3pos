unit ObjUsers;

interface
uses SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TUsers=class(TZFactory)
  private
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True �����������ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;    
    procedure InitClass; override;
  end;
  
implementation

{ TUsers }

function TUsers.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select * from STK_STOCKORDER where GUIDE_USER=:USER_ID or CREA_USER=:USER_ID ';
    rs.ParamByName('USER_ID').AsString := FieldByName('USER_ID').AsString;
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create('���û�����ⵥ������ʹ��,����ɾ��!');

    rs.Close;
    rs.SQL.Text := 'select * from SAL_SALESORDER where GUIDE_USER=:USER_ID or CREA_USER=:USER_ID';
    rs.ParamByName('USER_ID').AsString := FieldByName('USER_ID').AsString;
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create('���û������۵�������ʹ��,����ɾ��!');
  finally
    rs.Free;
  end;
end;

function TUsers.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin  
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select USER_ID,ACCOUNT,COMM from CA_USERS where COMM not in (''02'',''12'') and  ACCOUNT=:ACCOUNT and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('ACCOUNT').AsString := FieldByName('ACCOUNT').AsString;
    rs.ParamByName('TENANT_ID').AsString := FieldByName('TENANT_ID').AsString;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsString;
    AGlobal.Open(rs);
    if rs.RecordCount > 0 then
      Raise Exception.Create(FieldbyName('ACCOUNT').AsString+'��¼���Ѿ��������û�ʹ�ã�����ȡ�µĵ�¼��...');
  finally
    rs.Free;
  end;
  Result:=True;
end;

function TUsers.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ACCOUNT from CA_USERS where ACCOUNT=:ACCOUNT and ACCOUNT<>:OLD_ACCOUNT and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('ACCOUNT').AsString := FieldByName('ACCOUNT').AsString;
    rs.ParamByName('OLD_ACCOUNT').AsString := FieldByName('ACCOUNT').AsOldString;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsString;
    rs.ParamByName('TENANT_ID').AsString := FieldByName('TENANT_ID').AsString;
    AGlobal.Open(rs);
    if not rs.IsEmpty then Raise Exception.Create(FieldbyName('ACCOUNT').AsString+'��¼���Ѿ��������û�ʹ�ã��������޸��µĵ�¼��...');
  finally
    rs.Free;
  end;
  result := true;
end;

procedure TUsers.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'USER_ID';
  SelectSQL.Text := 'select USER_ID,ACCOUNT,ENCODE,USER_NAME,USER_SPELL,PASS_WRD,SHOP_ID,DEPT_ID,DUTY_IDS,DUTY_NAMES as DUTY_IDS_TEXT,ROLE_IDS,ROLE_NAMES as ROLE_IDS_TEXT,TENANT_ID,SEX,BIRTHDAY,DEGREES,'+
                    'MOBILE,OFFI_TELE,FAMI_TELE,EMAIL,QQ,MSN,ID_NUMBER,IDN_TYPE,FAMI_ADDR,POSTALCODE,WORK_DATE,DIMI_DATE,REMARK from CA_USERS where TENANT_ID=:TENANT_ID and USER_ID=:USER_ID ORDER BY USER_ID';
  IsSQLUpdate := True;
  Str := 'insert into CA_USERS(USER_ID,TENANT_ID,ACCOUNT,USER_NAME,USER_SPELL,SHOP_ID,DEPT_ID,DUTY_IDS,DUTY_NAMES,ROLE_IDS,ROLE_NAMES,SEX,BIRTHDAY,DEGREES,'+
         'MOBILE,OFFI_TELE,FAMI_TELE,EMAIL,QQ,MSN,ID_NUMBER,IDN_TYPE,FAMI_ADDR,POSTALCODE,WORK_DATE,DIMI_DATE,REMARK,COMM,TIME_STAMP) VALUES(:USER_ID,'+
         ':TENANT_ID,:ACCOUNT,:USER_NAME,:USER_SPELL,:SHOP_ID,:DEPT_ID,:DUTY_IDS,:DUTY_IDS_TEXT,:ROLE_IDS,:ROLE_IDS_TEXT,:SEX,:BIRTHDAY,:DEGREES,:MOBILE,'+
         ':OFFI_TELE,:FAMI_TELE,:EMAIL,:QQ,:MSN,:ID_NUMBER,:IDN_TYPE,:FAMI_ADDR,:POSTALCODE,:WORK_DATE,:DIMI_DATE,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update CA_USERS set ACCOUNT=:ACCOUNT,USER_NAME=:USER_NAME,USER_SPELL=:USER_SPELL,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,DUTY_IDS=:DUTY_IDS,ROLE_IDS=:ROLE_IDS,ROLE_NAMES=:ROLE_NAMES,'+
         'DUTY_NAMES=:DUTY_IDS_TEXT,TENANT_ID=:TENANT_ID,SEX=:SEX,BIRTHDAY=:BIRTHDAY,DEGREES=:DEGREES,MOBILE=:MOBILE,OFFI_TELE=:OFFI_TELE,FAMI_TELE=:FAMI_TELE,EMAIL=:EMAIL,'+
         'QQ=:QQ,MSN=:MSN,ID_NUMBER=:ID_NUMBER,IDN_TYPE=:IDN_TYPE,FAMI_ADDR=:FAMI_ADDR,POSTALCODE=:POSTALCODE,WORK_DATE=:WORK_DATE,DIMI_DATE=:DIMI_DATE,REMARK=:REMARK,COMM='
          +GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where USER_ID=:OLD_USER_ID and TENANT_ID=:OLD_TENANT_ID ';
  UpdateSQL.Add( Str);
  Str := 'update CA_USERS set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where USER_ID=:OLD_USER_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Add( Str);
end;



initialization
  RegisterClass(TUsers);
finalization
  UnRegisterClass(TUsers);
  
end.
