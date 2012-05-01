unit ObjVoucherOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;

type
  TVoucherOrder=class(TZFactory)
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
  TVoucherData=class(TZFactory)
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
  TVoucherOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TVoucherOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;

implementation

{ TVoucherOrder }

function TVoucherOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
begin

end;

procedure TVoucherOrder.InitClass;
var
  Str: string;
begin
  inherited;
  Locked := false;
  SelectSQL.Text :=
  ' select A.TENANT_ID,A.VOUCHER_ID,A.SHOP_ID,A.VOUCHER_TYPE,A.INTO_DATE,C.SHOP_NAME as SHOP_ID_TEXT,A.DEPT_ID,B.DEPT_NAME as DEPT_ID_TEXT,'+
  'A.CREA_DATE,A.CREA_USER,D.USER_NAME as CREA_USER_TEXT,A.INTO_USER,E.USER_NAME as INTO_USER_TEXT,A.REMARK,A.COMM '+
  ' from SAL_VOUCHERORDER A left join CA_DEPT_INFO B on A.TENANT_ID=B.TENANT_ID and A.DEPT_ID=B.DEPT_ID '+
  ' left join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
  ' left join VIW_USERS D on A.TENANT_ID=D.TENANT_ID and A.CREA_USER=D.USER_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.INTO_USER=E.USER_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.VOUCHER_ID=:VOUCHER_ID order by A.VOUCHER_ID';
  IsSQLUpdate := True;
  Str := ' insert into SAL_VOUCHERORDER(TENANT_ID,VOUCHER_ID,SHOP_ID,DEPT_ID,VOUCHER_TYPE,INTO_DATE,INTO_USER,CREA_DATE,CREA_USER,REMARK,COMM,TIME_STAMP) '
    + ' VALUES(:TENANT_ID,:VOUCHER_ID,:SHOP_ID,:DEPT_ID,:VOUCHER_TYPE,:INTO_DATE,:INTO_USER,:CREA_DATE,:CREA_USER,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := ' update SAL_VOUCHERORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,VOUCHER_TYPE=:VOUCHER_TYPE,INTO_DATE=:INTO_DATE,'+
         'INTO_USER=:INTO_USER,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,REMARK=:REMARK,'+
         'COMM=' + GetCommStr(iDbType) + ','+
         'TIME_STAMP='+GetTimeStamp(iDbType)+' '+
         'where TENANT_ID=:OLD_TENANT_ID and VOUCHER_ID=:OLD_VOUCHER_ID ';
  UpdateSQL.Text := Str;
  Str := ' delete from SAL_VOUCHERORDER where TENANT_ID=:OLD_TENANT_ID and VOUCHER_ID=:OLD_VOUCHER_ID ';
  DeleteSQL.Text := Str;
end;

{ TVoucherData }

function TVoucherData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVoucherData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TVoucherData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select TENANT_ID,VOUCHER_ID,BARCODE,VOUCHER_TYPE,VOUCHER_PRC,VOUCHER_STATUS,VAILD_DATE,CLIENT_ID,COMM '+
  ' from SAL_VOUCHERDATA where TENANT_ID=:TENANT_ID and VOUCHER_ID=:VOUCHER_ID order by BARCODE ';
  IsSQLUpdate := True;
  Str := 'insert into SAL_VOUCHERDATA(TENANT_ID,VOUCHER_ID,BARCODE,VOUCHER_TYPE,VOUCHER_PRC,VOUCHER_STATUS,VAILD_DATE,CLIENT_ID,COMM,TIME_STAMP) '
    + 'values(:TENANT_ID,:VOUCHER_ID,:BARCODE,:VOUCHER_TYPE,:VOUCHER_PRC,:VOUCHER_STATUS,:VAILD_DATE,:CLIENT_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update SAL_VOUCHERDATA set TENANT_ID=:TENANT_ID,VOUCHER_ID=:VOUCHER_ID,BARCODE=:BARCODE,VOUCHER_TYPE=:VOUCHER_TYPE,'+
         'VOUCHER_PRC=:VOUCHER_PRC,VOUCHER_STATUS=:VOUCHER_STATUS,VAILD_DATE=:VAILD_DATE,'+
         'COMM=' + GetCommStr(iDbType) + ','+
         'TIME_STAMP='+GetTimeStamp(iDbType)+' '+
         ' where TENANT_ID=:OLD_TENANT_ID and BARCODE=:OLD_BARCODE ';
  UpdateSQL.Text := Str;
  Str := ' delete from SAL_VOUCHERDATA where TENANT_ID=:OLD_TENANT_ID and BARCODE=:OLD_BARCODE ';
  DeleteSQL.Text := Str;
end;

{ TVoucherOrderGetPrior }

procedure TVoucherOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 VOUCHER_ID from SAL_VOUCHERORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VOUCHER_ID<:VOUCHER_ID order by VOUCHER_ID DESC';
  1:SelectSQL.Text := 'select * from (select VOUCHER_ID from SAL_VOUCHERORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VOUCHER_ID<:VOUCHER_ID order by VOUCHER_ID DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select VOUCHER_ID from SAL_VOUCHERORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VOUCHER_ID<:VOUCHER_ID order by VOUCHER_ID DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select VOUCHER_ID from SAL_VOUCHERORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VOUCHER_ID<:VOUCHER_ID order by VOUCHER_ID DESC limit 1';
  end;
end;

{ TVoucherOrderGetNext }

procedure TVoucherOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 VOUCHER_ID from SAL_VOUCHERORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VOUCHER_ID>:VOUCHER_ID order by VOUCHER_ID';
  1:SelectSQL.Text := 'select * from (select VOUCHER_ID from SAL_VOUCHERORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VOUCHER_ID>:VOUCHER_ID order by VOUCHER_ID) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select VOUCHER_ID from SAL_VOUCHERORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VOUCHER_ID>:VOUCHER_ID order by VOUCHER_ID) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select VOUCHER_ID from SAL_VOUCHERORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VOUCHER_ID>:VOUCHER_ID order by VOUCHER_ID limit 1';
  end;
end;

initialization
  RegisterClass(TVoucherOrder);
  RegisterClass(TVoucherData);
  RegisterClass(TVoucherOrderGetPrior);
  RegisterClass(TVoucherOrderGetNext);
finalization
  UnRegisterClass(TVoucherOrder);
  UnRegisterClass(TVoucherData);
  UnRegisterClass(TVoucherOrderGetPrior);
  UnRegisterClass(TVoucherOrderGetNext);
end.
 