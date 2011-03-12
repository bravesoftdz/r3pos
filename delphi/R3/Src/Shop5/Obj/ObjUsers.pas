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
    rs.SQL.Text := 'select SHOP_ID from STK_STOCKORDER where GUIDE_USER=:USER_ID or CREA_USER=:USER_ID ';
    rs.ParamByName('USER_ID').AsString := FieldByName('USER_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString <> '' then
      Raise Exception.Create('���û�����ⵥ������ʹ��,����ɾ��!');

    rs.Close;
    rs.SQL.Text := 'select SHOP_ID from SAL_SALESORDER where GUIDE_USER=:USER_ID or CREA_USER=:USER_ID';
    rs.ParamByName('USER_ID').AsString := FieldByName('USER_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString <> '' then
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
    rs.SQL.Text := 'select count(*) from CA_USERS where COMM not in (''02'',''12'') and  ACCOUNT=:ACCOUNT and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('ACCOUNT').AsString := FieldByName('ACCOUNT').AsString;
    rs.ParamByName('TENANT_ID').AsString := FieldByName('TENANT_ID').AsString;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
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
    rs.SQL.Text := 'select count(*) from CA_USERS where COMM not in (''12'',''02'') and ACCOUNT=:ACCOUNT and USER_ID<>:OLD_USER_ID and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID ';
    rs.ParamByName('ACCOUNT').AsString := FieldByName('ACCOUNT').AsString;
    rs.ParamByName('OLD_USER_ID').AsString := FieldByName('USER_ID').AsOldString;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsString;
    rs.ParamByName('TENANT_ID').AsString := FieldByName('TENANT_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then Raise Exception.Create(FieldbyName('ACCOUNT').AsString+'��¼���Ѿ��������û�ʹ�ã��������޸��µĵ�¼��...');
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
  SelectSQL.Text :=
  'select jb.*,b.SHOP_NAME as SHOP_ID_TEXT from( '+
  'select ja.*,a.DEPT_NAME as DEPT_ID_TEXT from('+
  'select TENANT_ID,SHOP_ID,USER_ID,ACCOUNT,ENCODE,USER_NAME,USER_SPELL,PASS_WRD,DEPT_ID,DUTY_IDS,DUTY_NAMES as DUTY_IDS_TEXT,'+
  'ROLE_IDS,ROLE_NAMES as ROLE_IDS_TEXT,SEX,BIRTHDAY,DEGREES,MOBILE,OFFI_TELE,FAMI_TELE,EMAIL,QQ,'+
  'MSN,MM,ID_NUMBER,IDN_TYPE,FAMI_ADDR,POSTALCODE,WORK_DATE,DIMI_DATE,REMARK from CA_USERS '+
  'where TENANT_ID=:TENANT_ID and USER_ID=:USER_ID ) ja '+
  'left outer join CA_DEPT_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.DEPT_ID=a.DEPT_ID) jb '+
  'left outer join CA_SHOP_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.SHOP_ID=b.SHOP_ID ORDER BY jb.USER_ID';

  IsSQLUpdate := True;
  Str := 'insert into CA_USERS(USER_ID,TENANT_ID,ACCOUNT,USER_NAME,USER_SPELL,SHOP_ID,DEPT_ID,DUTY_IDS,DUTY_NAMES,ROLE_IDS,ROLE_NAMES,SEX,BIRTHDAY,DEGREES,'+
         'MOBILE,OFFI_TELE,FAMI_TELE,EMAIL,QQ,MSN,MM,ID_NUMBER,IDN_TYPE,FAMI_ADDR,POSTALCODE,WORK_DATE,DIMI_DATE,REMARK,COMM,TIME_STAMP) VALUES(:USER_ID,'+
         ':TENANT_ID,:ACCOUNT,:USER_NAME,:USER_SPELL,:SHOP_ID,:DEPT_ID,:DUTY_IDS,:DUTY_IDS_TEXT,:ROLE_IDS,:ROLE_IDS_TEXT,:SEX,:BIRTHDAY,:DEGREES,:MOBILE,'+
         ':OFFI_TELE,:FAMI_TELE,:EMAIL,:QQ,:MSN,:MM,:ID_NUMBER,:IDN_TYPE,:FAMI_ADDR,:POSTALCODE,:WORK_DATE,:DIMI_DATE,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add( Str);
  Str := 'update CA_USERS set ACCOUNT=:ACCOUNT,USER_NAME=:USER_NAME,USER_SPELL=:USER_SPELL,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,DUTY_IDS=:DUTY_IDS,ROLE_IDS=:ROLE_IDS,ROLE_NAMES=:ROLE_IDS_TEXT,'+
         'DUTY_NAMES=:DUTY_IDS_TEXT,TENANT_ID=:TENANT_ID,SEX=:SEX,BIRTHDAY=:BIRTHDAY,DEGREES=:DEGREES,MOBILE=:MOBILE,OFFI_TELE=:OFFI_TELE,FAMI_TELE=:FAMI_TELE,EMAIL=:EMAIL,'+
         'QQ=:QQ,MSN=:MSN,MM=:MM,ID_NUMBER=:ID_NUMBER,IDN_TYPE=:IDN_TYPE,FAMI_ADDR=:FAMI_ADDR,POSTALCODE=:POSTALCODE,WORK_DATE=:WORK_DATE,DIMI_DATE=:DIMI_DATE,REMARK=:REMARK,COMM='
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
