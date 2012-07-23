unit ObjVhPayGlide;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;

type
  TVhPayGlide=class(TZFactory)
  private
    Locked:boolean;
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  
  TUpdateVhPayGlide=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TVhPayGlide }

function TVhPayGlide.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhPayGlide.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhPayGlide.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
    Str:String;
begin
  Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VOUCHER_STATUS from SAL_VOUCHERDATA where TENANT_ID=:TENANT_ID and BARCODE=:BARCODE ';
    rs.Params.ParamByName('BARCODE').AsString := FieldByName('BARCODE').AsString;
    rs.Params.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    AGlobal.Open(rs);
    if rs.Fields[0].AsString = '4' then Exception.Create('"'+FieldByName('BARCODE').AsString+'"礼券已经结算,请核对真实!');
    Str := 'update SAL_VOUCHERDATA set VOUCHER_STATUS=''4'' where TENANT_ID=:TENANT_ID and BARCODE=:BARCODE';
    AGlobal.ExecSQL(Str,Self);
  finally
    rs.Free;
  end;
  Result := True;
end;

function TVhPayGlide.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhPayGlide.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhPayGlide.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
begin

end;

procedure TVhPayGlide.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select TENANT_ID,VHPAY_ID,BARCODE,SHOP_ID,DEPT_ID,CLIENT_ID,VHPAY_DATE,VHPAY_USER,VOUCHER_PRC,VOUCHER_TYPE,VHPAY_MNY,'+
  'AGIO_RATE,AGIO_MONEY,FROM_ID,CREA_DATE,CREA_USER,REMARK from SAL_VHPAY_GLIDE where TENANT_ID=0 ';
  IsSQLUpdate := True;
  Str := 'insert into SAL_VHPAY_GLIDE(TENANT_ID,VHPAY_ID,BARCODE,SHOP_ID,DEPT_ID,CLIENT_ID,VHPAY_DATE,VHPAY_USER,'+
         'VOUCHER_PRC,VOUCHER_TYPE,VHPAY_MNY,AGIO_RATE,AGIO_MONEY,FROM_ID,CREA_DATE,CREA_USER,REMARK,COMM,TIME_STAMP) '+
         'values(:TENANT_ID,:VHPAY_ID,:BARCODE,:SHOP_ID,:DEPT_ID,:CLIENT_ID,:VHPAY_DATE,:VHPAY_USER,:VOUCHER_PRC,'+
         ':VOUCHER_TYPE,:VHPAY_MNY,:AGIO_RATE,:AGIO_MONEY,:FROM_ID,:CREA_DATE,:CREA_USER,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update SAL_VHPAY_GLIDE set TENANT_ID=:TENANT_ID,BARCODE=:BARCODE,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,CLIENT_ID=:CLIENT_ID,'+
         'VHPAY_DATE=:VHPAY_DATE,VHPAY_USER=:VHPAY_USER,VOUCHER_PRC=:VOUCHER_PRC,VOUCHER_TYPE=:VOUCHER_TYPE,VHPAY_MNY=:VHPAY_MNY,'+
         'AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY,FROM_ID=:FROM_ID,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,REMARK=:REMARK '+
         'COMM=' + GetCommStr(iDbType) + ','+
         'TIME_STAMP='+GetTimeStamp(iDbType)+' '+
         ' where TENANT_ID=:OLD_TENANT_ID and VHPAY_ID=:OLD_VHPAY_ID ';
  UpdateSQL.Text := Str;
  Str := ' delete from SAL_VHPAY_GLIDE where TENANT_ID=:OLD_TENANT_ID and VHPAY_ID=:OLD_VHPAY_ID ';
  DeleteSQL.Text := Str;
end;

{ TUpdateVhPayGlide }

function TUpdateVhPayGlide.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  Str,ChkUser:string;
  n:Integer;
  rs:TZQuery;
begin
  AGlobal.BeginTrans;
  try
    Str := 'update SAL_VOUCHERDATA set VOUCHER_STATUS=''1'',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and BARCODE='''+Params.FindParam('BARCODE').asString+'''';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待撤消的防伪码，是否被另一用户撤消。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');

    ChkUser:=Params.ParamByName('CHK_USER').AsString;
{    Str:='insert into SAL_VHPAY_GLIDE(TENANT_ID,VHPAY_ID,BARCODE,SHOP_ID,DEPT_ID,CLIENT_ID,VHPAY_DATE,VHPAY_USER,'+
         'VOUCHER_PRC,VOUCHER_TYPE,VHPAY_MNY,AGIO_RATE,AGIO_MONEY,FROM_ID,CREA_DATE,CREA_USER,REMARK,COMM,TIME_STAMP) '+
         'values('+Params.FindParam('TENANT_ID').asString+','''+Params.FindParam('VHPAY_ID').asString+''','''+Params.FindParam('BARCODE').asString+
         ''','''+Params.FindParam('SHOP_ID').asString+''','''+Params.FindParam('DEPT_ID').asString+''','''+Params.FindParam('CLIENT_ID').asString+
         ''','+Params.FindParam('VHPAY_DATE').asString+','''+Params.FindParam('VHPAY_USER').asString+''','+Params.FindParam('VOUCHER_PRC').asString+
         ','''+Params.FindParam('VOUCHER_TYPE').asString+''','+Params.FindParam('VHPAY_MNY').asString+','+Params.FindParam('AGIO_RATE').asString+
         ','+Params.FindParam('AGIO_MONEY').asString+','''+Params.FindParam('FROM_ID').asString+''','''+Params.FindParam('CREA_DATE').asString+
         ''','''+Params.FindParam('CREA_USER').asString+''','''+Params.FindParam('REMARK').asString+''',''00'','+GetTimeStamp(AGlobal.iDbType)+')';;
}
    Str:='insert into SAL_VHPAY_GLIDE(TENANT_ID,VHPAY_ID,BARCODE,SHOP_ID,DEPT_ID,CLIENT_ID,VHPAY_DATE,VHPAY_USER,'+
         'VOUCHER_PRC,VOUCHER_TYPE,VHPAY_MNY,AGIO_RATE,AGIO_MONEY,FROM_ID,CREA_DATE,CREA_USER,REMARK,COMM,TIME_STAMP) '+
         'values(:TENANT_ID,:VHPAY_ID,:BARCODE,:SHOP_ID,:DEPT_ID,:CLIENT_ID,:VHPAY_DATE,:VHPAY_USER,:VOUCHER_PRC,'+
         ':VOUCHER_TYPE,:VHPAY_MNY,:AGIO_RATE,:AGIO_MONEY,:FROM_ID,:CREA_DATE,:CREA_USER,:REMARK,''00'','+GetTimeStamp(AGlobal.iDbType)+')';
    AGlobal.ExecSQL(Str,params);
    AGlobal.CommitTrans;

    Result := true;
    Msg := '撤消成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '撤消错误'+E.Message;
        AGlobal.RollbackTrans;
      end;
  end;
end;

initialization
  RegisterClass(TVhPayGlide);
  RegisterClass(TUpdateVhPayGlide);
finalization
  UnRegisterClass(TVhPayGlide);
  UnRegisterClass(TUpdateVhPayGlide);

end.
