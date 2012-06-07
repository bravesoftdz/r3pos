unit ObjVhLeadOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,ObjCommon,DB,ZDataSet;

type
  TVhLeadOrder=class(TZFactory)
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
  TVhLeadData=class(TZFactory)
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
  TVhLeadOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  TVhLeadOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  
implementation

{ TVhLeadOrder }

function TVhLeadOrder.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhLeadOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhLeadOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhLeadOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhLeadOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhLeadOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
begin

end;

procedure TVhLeadOrder.InitClass;
var
  Str: string;
begin
  inherited;
  Locked := false;
  SelectSQL.Text :=
  ' select A.TENANT_ID,A.VHLEAD_ID,A.SHOP_ID,C.SHOP_NAME as SHOP_ID_TEXT,A.DEPT_ID,B.DEPT_NAME as DEPT_ID_TEXT,A.LEAD_DATE,A.LEAD_USER,A.CREA_DATE,A.CREA_USER,A.REMARK,A.COMM '+
  ' from SAL_VHLEADORDER A left join CA_DEPT_INFO B on A.TENANT_ID=B.TENANT_ID and A.DEPT_ID=B.DEPT_ID '+
  ' left join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
  ' left join VIW_USERS D on A.TENANT_ID=D.TENANT_ID and A.CREA_USER=D.USER_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.LEAD_USER=E.USER_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.VHLEAD_ID=:VHLEAD_ID ';
  IsSQLUpdate := True;
  Str := ' insert into SAL_VHLEADORDER(TENANT_ID,VHLEAD_ID,SHOP_ID,DEPT_ID,LEAD_DATE,LEAD_USER,CREA_DATE,CREA_USER,REMARK,COMM,TIME_STAMP) '+
  ' VALUES(:TENANT_ID,:VHLEAD_ID,:SHOP_ID,:DEPT_ID,:LEAD_DATE,:LEAD_USER,:CREA_DATE,:CREA_USER,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := ' update SAL_VHLEADORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,LEAD_DATE=:LEAD_DATE,'+
         'LEAD_USER=:LEAD_USER,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,REMARK=:REMARK,'+
         'COMM=' + GetCommStr(iDbType) + ','+
         'TIME_STAMP='+GetTimeStamp(iDbType)+' '+
         'where TENANT_ID=:OLD_TENANT_ID and VHLEAD_ID=:OLD_VHLEAD_ID ';
  UpdateSQL.Text := Str;
  Str := ' delete from SAL_VHLEADORDER where TENANT_ID=:OLD_TENANT_ID and VOUCHER_ID=:OLD_VOUCHER_ID ';
  DeleteSQL.Text := Str;
end;

{ TVhLeadData }

function TVhLeadData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhLeadData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TVhLeadData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
 { Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
    ' select count(B.VOUCHER_ID) as AMOUNT from SAL_VOUCHERORDER A, SAL_VOUCHERDATA B where A.TENANT_ID=B.TENANT_ID and A.VOUCHER_ID=B.VOUCHER_ID '+
    ' and A.TENANT_ID=:TENANT_ID and A.VOUCHER_ID=:VOUCHER_ID and B.VOUCHER_STATUS=''1'' group by B.VOUCHER_ID ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.Params.ParamByName('VOUCHER_ID').AsString := FieldByName('VOUCHER_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsFloat < FieldByName('AMOUNT').AsFloat then
       Raise Exception.Create('"'+FieldByName('VOUCHER_ID_TEXT').AsString+'"礼券总数小于输入数!');
  finally
    rs.Free;
  end;

  Result := True; }
end;

function TVhLeadData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  {Result := False;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
    ' select count(B.VOUCHER_ID) as AMOUNT from SAL_VOUCHERORDER A, SAL_VOUCHERDATA B where A.TENANT_ID=B.TENANT_ID and A.VOUCHER_ID=B.VOUCHER_ID '+
    ' and A.TENANT_ID=:TENANT_ID and A.VOUCHER_ID=:VOUCHER_ID and B.VOUCHER_STATUS=''1'' group by B.VOUCHER_ID ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.Params.ParamByName('VOUCHER_ID').AsString := FieldByName('VOUCHER_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsFloat < FieldByName('AMOUNT').AsFloat then
       Raise Exception.Create('"'+FieldByName('VOUCHER_ID_TEXT').AsString+'"礼券总数小于输入数!');
  finally
    rs.Free;
  end;
  Result := True;}
end;

function TVhLeadData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TVhLeadData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select A.TENANT_ID,A.VHLEAD_ID,A.VOUCHER_ID,B.VUCH_NAME as VOUCHER_ID_TEXT,A.SUMMARY,A.AMOUNT,A.VOUCHER_PRC,A.VOUCHER_TTL '+
  ' from SAL_VHLEADDATA A left join SAL_VOUCHERORDER B on A.TENANT_ID=B.TENANT_ID and A.VOUCHER_ID=B.VOUCHER_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.VHLEAD_ID=:VHLEAD_ID ';
  IsSQLUpdate := True;
  Str := 'insert into SAL_VHLEADDATA(TENANT_ID,VHLEAD_ID,VOUCHER_ID,SUMMARY,AMOUNT,VOUCHER_PRC,VOUCHER_TTL) '
    + 'values(:TENANT_ID,:VHLEAD_ID,:VOUCHER_ID,:SUMMARY,:AMOUNT,:VOUCHER_PRC,:VOUCHER_TTL)';
  InsertSQL.Text := Str;
  Str := 'update SAL_VHLEADDATA set TENANT_ID=:TENANT_ID,VOUCHER_ID=:VOUCHER_ID,'+
         'SUMMARY=:SUMMARY,AMOUNT=:AMOUNT,VOUCHER_PRC=:VOUCHER_PRC,VOUCHER_TTL=:VOUCHER_TTL'+
         ' where TENANT_ID=:OLD_TENANT_ID and VHLEAD_ID=:OLD_VHLEAD_ID and VOUCHER_ID=:OLD_VOUCHER_ID';
  UpdateSQL.Text := Str;
  Str := ' delete from SAL_VHLEADDATA where TENANT_ID=:OLD_TENANT_ID and VHLEAD_ID=:OLD_VHLEAD_ID and VOUCHER_ID=:OLD_VOUCHER_ID ';
  DeleteSQL.Text := Str;
end;

{ TVhLeadOrderGetPrior }

procedure TVhLeadOrderGetPrior.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 VHLEAD_ID from SAL_VHLEADORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHLEAD_ID<:VHLEAD_ID order by VHLEAD_ID DESC';
  1:SelectSQL.Text := 'select * from (select VHLEAD_ID from SAL_VHLEADORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHLEAD_ID<:VHLEAD_ID order by VHLEAD_ID DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select VHLEAD_ID from SAL_VHLEADORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHLEAD_ID<:VHLEAD_ID order by VHLEAD_ID DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select VHLEAD_ID from SAL_VHLEADORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHLEAD_ID<:VHLEAD_ID order by VHLEAD_ID DESC limit 1';
  end;
end;

{ TVhLeadOrderGetNext }

procedure TVhLeadOrderGetNext.InitClass;
begin
  inherited;
  case iDbType of
  0,3:SelectSQL.Text := 'select top 1 VHLEAD_ID from SAL_VHLEADORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHLEAD_ID>:VHLEAD_ID order by VHLEAD_ID DESC';
  1:SelectSQL.Text := 'select * from (select VHLEAD_ID from SAL_VHLEADORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHLEAD_ID>:VHLEAD_ID order by VHLEAD_ID DESC ) where ROWNUM=1';
  4:SelectSQL.Text := 'select * from (select VHLEAD_ID from SAL_VHLEADORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHLEAD_ID>:VHLEAD_ID order by VHLEAD_ID DESC ) tp fetch first 1 rows only';
  5:SelectSQL.Text := 'select VHLEAD_ID from SAL_VHLEADORDER where TENANT_ID=:TENANT_ID and CREA_USER=:CREA_USER and VHLEAD_ID>:VHLEAD_ID order by VHLEAD_ID DESC limit 1';
  end;
end;

initialization
  RegisterClass(TVhLeadOrder);
  RegisterClass(TVhLeadData);
  RegisterClass(TVhLeadOrderGetPrior);
  RegisterClass(TVhLeadOrderGetNext);
finalization
  UnRegisterClass(TVhLeadOrder);
  UnRegisterClass(TVhLeadData);
  UnRegisterClass(TVhLeadOrderGetPrior);
  UnRegisterClass(TVhLeadOrderGetNext);
end.
