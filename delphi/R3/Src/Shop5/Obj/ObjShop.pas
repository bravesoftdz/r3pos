unit ObjShop;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,ZDataset;
type
  TShop=class(TZFactory)
  public
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

implementation

{ TShop }

function TShop.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
    Str:String;
begin
  try
    rs := TZQuery.Create(nil);
    rs.SQL.Text := 'select IN_MNY,OUT_MNY,BALANCE from ACC_ACCOUNT_INFO where COMM not in (''12'',''02'') and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PAYM_ID=''A''';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsOldInteger;
    rs.ParamByName('SHOP_ID').AsString := FieldByName('SHOP_ID').AsString;
    AGlobal.Open(rs);
    if rs.FieldByName('BALANCE').AsFloat > 0 then
      Raise Exception.Create('此门店的现金账户上有余额,不能删除!')
    else
      begin
        Str := 'delete from ACC_ACCOUNT_INFO where SHOP_ID=:OLD_SHOP_ID and TENANT_ID=:TENANT_ID and PAYM_ID=''A'' ';
        AGlobal.ExecSQL(Str,Self);
      end;
  finally
    rs.Free;
  end;
  
end;

function TShop.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str: String;
begin
  Result := False;
  //为新建门店初始化现金账户
  Str := 'insert into ACC_ACCOUNT_INFO(TENANT_ID,SHOP_ID,ACCOUNT_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,ORG_MNY,OUT_MNY,IN_MNY,BALANCE,COMM,TIME_STAMP)'+
  ' values(:TENANT_ID,:SHOP_ID,'''+FieldbyName('SHOP_ID').AsString+'00000000000000000000000'+''',''现金'',''XJ'',''A'',0,0,0,0,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  Result := True;
end;

function TShop.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
//
end;

procedure TShop.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='SHOP_ID';
  SelectSQL.Text := 'Select SHOP_ID,SHOP_NAME,SHOP_SPELL,LICENSE_CODE,TENANT_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,'+
  'REGION_ID,SHOP_TYPE,SEQ_NO,XSM_CODE,XSM_PSWD From CA_SHOP_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and COMM not in (''12'',''02'') order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into CA_SHOP_INFO(SHOP_ID,SHOP_NAME,SHOP_SPELL,LICENSE_CODE,TENANT_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,REGION_ID,SHOP_TYPE,SEQ_NO,XSM_CODE,XSM_PSWD,COMM,TIME_STAMP) '
       + 'VALUES(:SHOP_ID,:SHOP_NAME,:SHOP_SPELL,:LICENSE_CODE,:TENANT_ID,:LINKMAN,:TELEPHONE,:FAXES,:ADDRESS,:POSTALCODE,:REMARK,:REGION_ID,:SHOP_TYPE,:SEQ_NO,XSM_CODE,XSM_PSWD,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update CA_SHOP_INFO set SHOP_TYPE=:SHOP_TYPE,SHOP_NAME=:SHOP_NAME,SHOP_SPELL=:SHOP_SPELL,LICENSE_CODE=:LICENSE_CODE,TELEPHONE=:TELEPHONE,FAXES=:FAXES,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,'
  +'REMARK=:REMARK,LINKMAN=:LINKMAN,REGION_ID=:REGION_ID,SEQ_NO=:SEQ_NO,XSM_CODE=:XSM_CODE,XSM_PSWD=:XSM_PSWD,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where SHOP_ID=:OLD_SHOP_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'update CA_SHOP_INFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where SHOP_ID=:OLD_SHOP_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;



initialization
  RegisterClass(TShop);
finalization
  UnRegisterClass(TShop);

end.
