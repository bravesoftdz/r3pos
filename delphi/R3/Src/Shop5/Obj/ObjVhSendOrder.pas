unit ObjVhSendOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;

type
  TVhSendOrder=class(TZFactory)
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
  TVhSendData=class(TZFactory)
  public
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
  TVhSendOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TVhSendOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;

implementation

{ TVhSendOrder }

function TVhSendOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhSendOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhSendOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhSendOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhSendOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhSendOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
begin

end;

procedure TVhSendOrder.InitClass;
var
  Str: string;
begin
  inherited;
  Locked := false;
  SelectSQL.Text :=
  ' select A.TENANT_ID,A.VHSEND_ID,A.SHOP_ID,C.SHOP_NAME as SHOP_ID_TEXT,A.DEPT_ID,B.DEPT_NAME as DEPT_ID_TEXT,A.CLIENT_ID,'+
  'F.CLIENT_NAME as CLIENT_ID_TEXT,A.SEND_DATE,A.SEND_USER,E.USER_NAME as SEND_USER_TEXT,A.VOUCHER_TTL,A.VOUCHER_MNY,A.CREA_DATE,'+
  'A.CREA_USER,D.USER_NAME as CREA_USER_TEXT,A.REMARK,A.COMM '+
  ' from SAL_VHSENDORDER A left join CA_DEPT_INFO B on A.TENANT_ID=B.TENANT_ID and A.DEPT_ID=B.DEPT_ID '+
  ' left join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
  ' left join VIW_USERS D on A.TENANT_ID=D.TENANT_ID and A.CREA_USER=D.USER_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.SEND_USER=E.USER_ID '+
  ' left join VIW_CUSTOMER F on A.TENANT_ID=F.TENANT_ID and A.CLIENT_ID=F.CLIENT_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.VHSEND_ID=:VHSEND_ID ';
  IsSQLUpdate := True;
  Str := ' insert into SAL_VHSENDORDER(TENANT_ID,VHSEND_ID,SHOP_ID,DEPT_ID,CLIENT_ID,SEND_DATE,SEND_USER,VOUCHER_TTL,VOUCHER_MNY,CREA_DATE,CREA_USER,REMARK,COMM,TIME_STAMP) '+
  ' VALUES(:TENANT_ID,:VHSEND_ID,:SHOP_ID,:DEPT_ID,:CLIENT_ID,:SEND_DATE,:SEND_USER,:VOUCHER_TTL,:VOUCHER_MNY,:CREA_DATE,:CREA_USER,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := ' update SAL_VHSENDORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,CLIENT_ID=:CLIENT_ID,SEND_DATE=:SEND_DATE,'+
         'SEND_USER=:SEND_USER,VOUCHER_TTL=:VOUCHER_TTL,VOUCHER_MNY=:VOUCHER_MNY,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,REMARK=:REMARK,'+
         'COMM=' + GetCommStr(iDbType) + ','+
         'TIME_STAMP='+GetTimeStamp(iDbType)+' '+
         'where TENANT_ID=:OLD_TENANT_ID and VHSEND_ID=:OLD_VHSEND_ID ';
  UpdateSQL.Text := Str;
  Str := ' delete from SAL_VHSENDORDER where TENANT_ID=:OLD_TENANT_ID and VHSEND_ID=:OLD_VHSEND_ID ';
  DeleteSQL.Text := Str;
end;

{ TVhSendData }

function TVhSendData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhSendData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;
  if FieldByName('VOUCHER_TYPE').AsString = '3' then
  begin
     Str := ' update SAL_VOUCHERDATA set VOUCHER_STATUS=''1'',CLIENT_ID=''#'' where TENANT_ID=:OLD_TENANT_ID and BARCODE=:OLD_BARCODE ';
     AGlobal.ExecSQL(Str,Self);
  end;
  Result := True;
end;

function TVhSendData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
    rs:TZQuery;
begin
  Result := False;
  if FieldByName('VOUCHER_TYPE').AsString = '3' then
  begin
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text := 'select BARCODE,VOUCHER_STATUS from SAL_VOUCHERDATA where TENANT_ID=:TENANT_ID and BARCODE=:BARCODE ';
       rs.Params.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
       rs.Params.ParamByName('BARCODE').AsString := FieldByName('BARCODE').AsString;
       AGlobal.Open(rs);
       if rs.FieldByName('BARCODE').AsString = '' then Raise Exception.Create('"'+FieldByName('BARCODE').AsString+'"礼券不存在库中,请核对防伪码!');
       if rs.FieldByName('VOUCHER_STATUS').AsString = '3' then Raise Exception.Create('"'+FieldByName('BARCODE').AsString+'"礼券已在发放状态!');
       Str := ' update SAL_VOUCHERDATA set VOUCHER_STATUS=''3'',CLIENT_ID='+QuotedStr(Params.FindParam('CLIENT_ID').AsString)+' where TENANT_ID=:TENANT_ID and BARCODE=:BARCODE ';
       AGlobal.ExecSQL(Str,Self);
     finally
       rs.Free;
     end;
  end;
  Result := True;
end;

function TVhSendData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TVhSendData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TVhSendData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select A.TENANT_ID,A.VHSEND_ID,A.VOUCHER_ID,A.BARCODE,B.VOUCHER_TYPE,B.VUCH_NAME as VOUCHER_ID_TEXT,A.AMOUNT,A.VOUCHER_PRC,'+
  'A.VOUCHER_TTL,A.VOUCHER_MNY,A.AGIO_RATE,A.AGIO_MONEY '+
  ' from SAL_VHSENDDATA A left join SAL_VOUCHERORDER B on A.TENANT_ID=B.TENANT_ID and A.VOUCHER_ID=B.VOUCHER_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.VHSEND_ID=:VHSEND_ID ';
  IsSQLUpdate := True;
  Str := 'insert into SAL_VHSENDDATA(TENANT_ID,VHSEND_ID,VOUCHER_ID,BARCODE,AMOUNT,VOUCHER_PRC,VOUCHER_TTL,VOUCHER_MNY,AGIO_RATE,AGIO_MONEY) '
    + 'values(:TENANT_ID,:VHSEND_ID,:VOUCHER_ID,:BARCODE,:AMOUNT,:VOUCHER_PRC,:VOUCHER_TTL,:VOUCHER_MNY,:AGIO_RATE,:AGIO_MONEY)';
  InsertSQL.Text := Str;
  Str := 'update SAL_VHSENDDATA set TENANT_ID=:TENANT_ID,VOUCHER_ID=:VOUCHER_ID,BARCODE=:BARCODE,AMOUNT=:AMOUNT,VOUCHER_PRC=:VOUCHER_PRC,'+
         'VOUCHER_TTL=:VOUCHER_TTL,VOUCHER_MNY=:VOUCHER_MNY,AGIO_RATE=:AGIO_RATE,AGIO_MONEY=:AGIO_MONEY '+
         ' where TENANT_ID=:OLD_TENANT_ID and VHSEND_ID=:OLD_VHSEND_ID and VOUCHER_ID=:OLD_VOUCHER_ID and BARCODE=:OLD_BARCODE ';
  UpdateSQL.Text := Str;
  Str := ' delete from SAL_VHSENDDATA where TENANT_ID=:OLD_TENANT_ID and VHLEAD_ID=:OLD_VHLEAD_ID and VOUCHER_ID=:OLD_VOUCHER_ID and BARCODE=:OLD_BARCODE ';
  DeleteSQL.Text := Str;
end;

{ TVhSendOrderGetPrior }

procedure TVhSendOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 VHSEND_ID from SAL_VHSENDORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHSEND_ID<:VHSEND_ID order by VHSEND_ID DESC';
  1:SelectSQL.Text := 'select * from (select VHSEND_ID from SAL_VHSENDORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHSEND_ID<:VHSEND_ID order by VHSEND_ID DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select VHSEND_ID from SAL_VHSENDORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHSEND_ID<:VHSEND_ID order by VHSEND_ID DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select VHSEND_ID from SAL_VHSENDORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHSEND_ID<:VHSEND_ID order by VHSEND_ID DESC limit 1';
  end;
end;

{ TVhSendOrderGetNext }

procedure TVhSendOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 VHSEND_ID from SAL_VHSENDORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHSEND_ID>:VHSEND_ID order by VHSEND_ID DESC';
  1:SelectSQL.Text := 'select * from (select VHSEND_ID from SAL_VHSENDORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHSEND_ID>:VHSEND_ID order by VHSEND_ID DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select VHSEND_ID from SAL_VHSENDORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHSEND_ID>:VHSEND_ID order by VHSEND_ID DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select VHSEND_ID from SAL_VHSENDORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHSEND_ID>:VHSEND_ID order by VHSEND_ID DESC limit 1';
  end;
end;

initialization
  RegisterClass(TVhSendOrder);
  RegisterClass(TVhSendData);
  RegisterClass(TVhSendOrderGetPrior);
  RegisterClass(TVhSendOrderGetNext);
finalization
  UnRegisterClass(TVhSendOrder);
  UnRegisterClass(TVhSendData);
  UnRegisterClass(TVhSendOrderGetPrior);
  UnRegisterClass(TVhSendOrderGetNext);

end.
