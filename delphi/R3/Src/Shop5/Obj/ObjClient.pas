unit ObjClient;

interface
uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,ZDataset;

type
  TClient=class(TZFactory)
  private
    procedure InitClass; override;
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TClientDelete=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TClient }

function TClient.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
//
end;

function TClient.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
//
end;

procedure TClient.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields := 'CLIENT_ID;TENANT_ID';
  
  SelectSQL.Text := 'select TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,'
  +'SORT_ID,REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,'
  +'EMAIL,QQ,MSN,BANK_ID,ACCOUNT,IC_CARDNO,INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,ACCU_INTEGRAL,RULE_INTEGRAL,'
  +'INTEGRAL,BALANCE,SHOP_ID from PUB_CLIENTINFO where COMM not in (''02'',''12'') and CLIENT_ID=:CLIENT_ID and TENANT_ID=:TENANT_ID order by CLIENT_ID';
  IsSQLUpdate := True;

  Str := 'insert into PUB_CLIENTINFO(TENANT_ID,CLIENT_ID,CLIENT_TYPE,CLIENT_CODE,LICENSE_CODE,CLIENT_NAME,CLIENT_SPELL,SORT_ID,'
  +'REGION_ID,SETTLE_CODE,ADDRESS,POSTALCODE,LINKMAN,TELEPHONE3,TELEPHONE1,TELEPHONE2,FAXES,HOMEPAGE,EMAIL,QQ,MSN,BANK_ID,'
  +'ACCOUNT,IC_CARDNO,INVOICE_FLAG,REMARK,TAX_RATE,PRICE_ID,ACCU_INTEGRAL,RULE_INTEGRAL,INTEGRAL,BALANCE,SHOP_ID,COMM,TIME_STAMP)'
  +'VALUES(:TENANT_ID,:CLIENT_ID,:CLIENT_TYPE,:CLIENT_CODE,:LICENSE_CODE,:CLIENT_NAME,:CLIENT_SPELL,:SORT_ID,:REGION_ID,:SETTLE_CODE,'
  +':ADDRESS,:POSTALCODE,:LINKMAN,:TELEPHONE3,:TELEPHONE1,:TELEPHONE2,:FAXES,:HOMEPAGE,:EMAIL,:QQ,:MSN,:BANK_ID,:ACCOUNT,:IC_CARDNO,'
  +':INVOICE_FLAG,:REMARK,:TAX_RATE,:PRICE_ID,:ACCU_INTEGRAL,:RULE_INTEGRAL,:INTEGRAL,:BALANCE,:SHOP_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update PUB_CLIENTINFO set CLIENT_TYPE=:CLIENT_TYPE,CLIENT_CODE=:CLIENT_CODE,LICENSE_CODE=:LICENSE_CODE,CLIENT_NAME=:CLIENT_NAME,'
  +'CLIENT_SPELL=:CLIENT_SPELL,SORT_ID=:SORT_ID,REGION_ID=:REGION_ID,SETTLE_CODE=:SETTLE_CODE,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,'
  +'LINKMAN=:LINKMAN,TELEPHONE3=:TELEPHONE3,TELEPHONE1=:TELEPHONE1,TELEPHONE2=:TELEPHONE2,FAXES=:FAXES,HOMEPAGE=:HOMEPAGE,EMAIL=:EMAIL,'
  +'QQ=:QQ,MSN=:MSN,BANK_ID=:BANK_ID,ACCOUNT=:ACCOUNT,IC_CARDNO=:IC_CARDNO,INVOICE_FLAG=:INVOICE_FLAG,REMARK=:REMARK,TAX_RATE=:TAX_RATE,'
  +'PRICE_ID=:PRICE_ID,ACCU_INTEGRAL=:ACCU_INTEGRAL,RULE_INTEGRAL=:RULE_INTEGRAL,INTEGRAL=:INTEGRAL,BALANCE=:BALANCE,SHOP_ID=:SHOP_ID,'
  +'COMM=' + GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+ ' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID';
  UpdateSQL.Text := Str;

  Str := 'update PUB_CLIENTINFO set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and CLIENT_ID=:OLD_CLIENT_ID';
  DeleteSQL.Text := Str;

end;

{ TClientDelete }

function TClientDelete.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var tmp:TZQuery;
begin
  Result:=False;
  AGlobal.BeginTrans;
  try
    AGlobal.ExecSQL('update PUB_CLIENTINFO set  COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
    ' where CLIENT_ID= and TENANT_ID=:TENANT_ID ');

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
  RegisterClass(TClient);
  RegisterClass(TClientDelete);
finalization
  UnRegisterClass(TClient);
  UnRegisterClass(TClientDelete);
end.
