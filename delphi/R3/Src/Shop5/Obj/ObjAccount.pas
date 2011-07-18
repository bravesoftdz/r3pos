unit ObjAccount;

interface
uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;
type
  TAccount=class(TZFactory)
  public
    procedure InitClass; override;
    function CheckReck(AGlobal:IdbHelp):boolean;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation
{ TAccount }

function TAccount.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select OUT_MNY,IN_MNY,BALANCE from ACC_ACCOUNT_INFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsOldInteger;
    rs.ParamByName('ACCOUNT_ID').AsString := FieldByName('ACCOUNT_ID').AsOldString;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsOldString;
    AGlobal.Open(rs);
    if (rs.FieldByName('OUT_MNY').AsFloat <> 0) or (rs.FieldByName('IN_MNY').AsFloat <> 0) then
        Raise Exception.Create('���˻�����б䶯,����ɾ��!');
  finally
    rs.Free;
  end;
  result := true;
end;

function TAccount.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    //����Ƿ�����
    rs.Close;
    rs.SQL.Text := 'select ACCT_NAME from ACC_ACCOUNT_INFO where COMM not in (''02'',''12'') and ACCT_NAME=:ACCT_NAME and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('ACCT_NAME').AsString := FieldByName('ACCT_NAME').AsString;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsString;
    AGlobal.Open(rs);
    if rs.FieldByName('ACCT_NAME').AsString <> '' then
       Raise Exception.Create('���˻����Ѿ�����,����������..');
    //����н��ˣ��ڳ����ֻ��Ϊ0
    if FieldbyName('ORG_MNY').AsFloat<>0 then
       begin
         rs.Close;
         rs.SQL.Text := 'select max(CLSE_DATE) as CLSE_DATE from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID ';
         rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
         AGlobal.Open(rs);
         if rs.Fields[0].AsString <> '' then Raise Exception.Create('�Ѿ����ڽ��˼�¼ʱ�ڳ����ֻ����0...');
       end;

      
  finally
    rs.Free;
  end;
  Result:=True;
end;

function TAccount.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    //����Ƿ�����
    rs.Close;
    rs.SQL.Text := 'select ACCT_NAME from ACC_ACCOUNT_INFO where COMM not in (''02'',''12'') and ACCT_NAME=:ACCT_NAME and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and ACCOUNT_ID<>:OLD_ACCOUNT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('ACCT_NAME').AsString := FieldByName('ACCT_NAME').AsString;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsString;
    rs.ParamByName('OLD_ACCOUNT_ID').AsString := FieldByName('ACCOUNT_ID').AsOldString;
    AGlobal.Open(rs);
    if rs.FieldByName('ACCT_NAME').AsString <> '' then  Raise Exception.Create('���˻����Ѿ�����,����������..');

    //����Ƿ�����

    //��������
    if FieldbyName('ORG_MNY').AsFloat<>FieldbyName('ORG_MNY').AsOldFloat then
       begin
        Raise Exception.Create('�����޸��ڳ����...');
         //rs.Close;
         //rs.SQL.Text := 'select OUT_MNY,IN_MNY,COMM from ACC_ACCOUNT_INFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID and SHOP_ID=:OLD_SHOP_ID';
         //rs.ParamByName('TENANT_ID').AsString := FieldByName('TENANT_ID').AsString;
         //rs.ParamByName('OLD_ACCOUNT_ID').AsString := FieldByName('ACCOUNT_ID').AsOldString;
         //rs.ParamByName('OLD_SHOP_ID').AsString := FieldByName('SHOP_ID').AsOldString;
         //AGlobal.Open(rs);
         //if (rs.FieldByName('OUT_MNY').AsFloat <> 0) or (rs.FieldByName('IN_MNY').AsFloat <> 0) then
         //   Raise Exception.Create('�Ѿ����ڽ��˼�¼�����޸��ڳ����...');
         //if copy(rs.FieldbyName('COMM').AsString,1,1) = '1' then
         //   Raise Exception.Create('�����Ѿ�ͬ�������޸��ڳ����...');
         //rs.Close;
         //rs.SQL.Text := 'select max(MONTH) from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID ';
         //rs.ParamByName('TENANT_ID').AsString := FieldbyName('TENANT_ID').AsString;
         //AGlobal.Open(rs);
         //if rs.Fields[0].AsString <> '' then Raise Exception.Create('�Ѿ����ڽ��˼�¼�����޸��ڳ����...');
       end;
  finally
    rs.Free;   
  end;

end;


function TAccount.CheckReck(AGlobal: IdbHelp): boolean;
var rs:TZQuery;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select * from ACC_RECVORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and ACCOUNT_ID=:ACCOUNT_ID';
    rs.FieldByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
    rs.FieldByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    rs.FieldByName('ACCOUNT_ID').AsString := FieldbyName('ACCOUNT_ID').AsOldString;
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create('���˻����տ������ʹ��,����ɾ��!');

    rs.SQL.Text := 'select * from ACC_PAYORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and ACCOUNT_ID=:ACCOUNT_ID';
    rs.FieldByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
    rs.FieldByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    rs.FieldByName('ACCOUNT_ID').AsString := FieldbyName('ACCOUNT_ID').AsOldString;
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create('���˻��ڸ��������ʹ��,����ɾ��!');

    rs.SQL.Text := 'select * from ACC_TRANSORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and IN_ACCOUNT_ID=:ACCOUNT_ID or OUT_ACCOUNT_ID=:ACCOUNT_ID';
    rs.FieldByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsOldInteger;
    rs.FieldByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsOldString;
    rs.FieldByName('ACCOUNT_ID').AsString := FieldbyName('ACCOUNT_ID').AsOldString;
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create('���˻��ڴ�ȡ�������ʹ��,����ɾ��!');

  finally
    rs.Free;
  end;
  Result := True;
end;

procedure TAccount.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='ACCOUNT_ID;TENANT_ID';

  Str := 'select TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,COMM '+
  'from ACC_ACCOUNT_INFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID ';
  SelectSQL.Text := Str;
  IsSQLUpdate := True;
  Str := 'insert into ACC_ACCOUNT_INFO(TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,COMM,TIME_STAMP) '+
  'values(:TENANT_ID,:ACCOUNT_ID,:SHOP_ID,:ACCT_NAME,:ACCT_SPELL,:PAYM_ID,:ORG_MNY,:OUT_MNY,:IN_MNY,:BALANCE,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update ACC_ACCOUNT_INFO set ACCT_NAME=:ACCT_NAME,ACCT_SPELL=:ACCT_SPELL,PAYM_ID=:PAYM_ID,ORG_MNY=:ORG_MNY,'+
  'OUT_MNY=:OUT_MNY,IN_MNY=:IN_MNY,BALANCE=:BALANCE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where COMM not in (''02'',''12'') and TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID and SHOP_ID=:OLD_SHOP_ID ';
  UpdateSQL.Text := Str;

  Str := 'update ACC_ACCOUNT_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where COMM not in (''02'',''12'') and TENANT_ID=:OLD_TENANT_ID and ACCOUNT_ID=:OLD_ACCOUNT_ID and SHOP_ID=:OLD_SHOP_ID ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TAccount);
finalization
  UnRegisterClass(TAccount);

end.
