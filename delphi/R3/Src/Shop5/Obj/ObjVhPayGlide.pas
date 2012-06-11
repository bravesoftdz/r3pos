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

initialization
  RegisterClass(TVhPayGlide);

finalization
  UnRegisterClass(TVhPayGlide);

end.
