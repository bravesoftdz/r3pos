unit ObjUsers;

interface
uses SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TUsers=class(TZFactory)
  private
    //记录行集新增检测函数，返回值是True 则可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 则可以新增当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TUsersDelete=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TUsers }

function TUsers.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
    rs:TZQuery;
begin  
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ACCOUNT from CA_USERS where ACCOUNT=:ACCOUNT and TENANT_ID=:TENANT_ID';
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      Raise Exception.Create(FieldbyName('ACCOUNT').AsString+'登录名已经被其他用户使用，请重新修改新的登录名...');
  finally
    rs.Free;
  end;
  Result:=True;
end;

function TUsers.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ACCOUNT from CA_USERS where ACCOUNT=:ACCOUNT and ACCOUNT<>:OLD_ACCOUNT ';
    AGlobal.Open(rs);
    if not rs.IsEmpty then Raise Exception.Create(FieldbyName('ACCOUNT').AsString+'登录名已经被其他用户使用，请重新修改新的登录名...');
  finally
    rs.Free;
  end;
  {if FieldByName('SHOP_ID').AsString<>FieldByName('SHOP_ID').AsOldString then
  begin
    Str:='update CA_COMPRIGHT set COMP_ID='+QuotedStr(FieldByName('COMP_ID').AsString)+' where COMP_ID='''+FieldByName('COMP_ID').AsOldString+''' '
    +' and USER_ID='''+FieldByName('USER_ID').AsString+'''';
    AGlobal.ExecSQL(Str);
  end;}
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

{ TUsersDelete }

function TUsersDelete.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var tmp:TZQuery;
    Str:String;
begin
  Result:=False;
  AGlobal.BeginTrans;
  try
    {tmp:=TZQuery.Create(nil);
    try
      tmp.Close;
      //tmp.SQL.Add('select * from STK_STOCKORDER where GUIDE_USER='''+Params.ParamByName('USER_ID').asString+''' or OPER_USER='''+Params.ParamByName('USER_ID').asString+'''');
      tmp.SQL.Text := 'select * from STK_STOCKORDER where GUIDE_USER = :USER_ID or OPER_USER = :USER_ID ';
      if Params <> nil then
        tmp.Params.AssignValues(Params);
      AGlobal.Open(tmp);
      if tmp.RecordCount>0 then Raise Exception.Create('此用户在进货单据中有使用,不能删除!');
      tmp.Close;
      tmp.SQL.Text := 'select * from SAL_SALESORDER where GUIDE_USER= :USER_ID or OPER_USER = :USER_ID';
      if Params <> nil then
        tmp.Params.AssignValues(Params);
      AGlobal.Open(tmp);
      if tmp.RecordCount>0 then Raise Exception.Create('此用户在销售单据中有使用,不能删除!');
    finally
      tmp.Free;
    end;}
    Str := 'update CA_USERS set COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where USER_ID = :USER_ID and TENANT_ID=:TENANT_ID';
    AGlobal.ExecSQL(Str,Params);
    AGlobal.CommitTrans;
    Result:=True;
  except
    on E:Exception do
       begin
         Msg := E.Message;
         AGlobal.RollBackTrans;
       end;
  end;
end;

initialization
  RegisterClass(TUsers);
  RegisterClass(TUsersDelete);
finalization
  UnRegisterClass(TUsers);
  UnRegisterClass(TUsersDelete);
end.
