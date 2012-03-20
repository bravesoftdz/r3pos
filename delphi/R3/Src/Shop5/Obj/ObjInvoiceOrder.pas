unit ObjInvoiceOrder;

interface
uses Dialogs,SysUtils,ZBase,Classes, DB, ZDataSet,ZIntf,ObjCommon;

type
  TInvoiceOrder=class(TZFactory)
  public
    function CheckTimeStamp(aGlobal:IdbHelp;s:string;comm:boolean=true):boolean;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TInvoiceData=class(TZFactory)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //所有记录处理完毕后,事务提交以前执行。
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;
  TInvoiceOrderAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TInvoiceOrderUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

{ TInvoiceOrder }

function TInvoiceOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvoiceOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvoiceOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;

begin
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString,false) then Raise Exception.Create('当前发票已经被另一用户修改，你不能再保存。');
end;

function TInvoiceOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvoiceOrder.CheckTimeStamp(aGlobal: IdbHelp; s: string;
  comm: boolean): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from SAL_INVOICE_INFO where INVD_ID='''+FieldbyName('INVD_ID').AsString+''' and TENANT_ID='+FieldbyName('TENANT_ID').AsString;
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s);
    if comm and result and
    (
       (copy(rs.Fields[1].asString,1,1)='1')
       or
       (copy(rs.Fields[1].asString,2,1)<>'0')
    )
    then Raise Exception.Create('已经同步的数据不能删除..');
  finally
    rs.Free;
  end;
end;

procedure TInvoiceOrder.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select A.TENANT_ID,A.INVD_ID,A.INVH_ID,A.SHOP_ID,C.SHOP_NAME as SHOP_ID_TEXT,A.DEPT_ID,D.DEPT_NAME as DEPT_ID_TEXT,'+
  'A.CREA_USER,E.USER_NAME as CREA_USER_TEXT,A.CREA_DATE,A.CLIENT_ID,B.CLIENT_NAME as CLIENT_ID_TEXT,A.INVO_NAME,'+
  'A.ADDR_NAME,A.REMARK,A.INVOICE_FLAG,A.INVOICE_NO,A.INVOICE_MNY,A.EXPORT_STATUS,A.INVOICE_STATUS '+
  ' from SAL_INVOICE_INFO A left join VIW_CUSTOMER B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
  ' left join CA_SHOP_INFO C on A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID '+
  ' left join CA_DEPT_INFO D on A.TENANT_ID=D.TENANT_ID and A.DEPT_ID=D.DEPT_ID '+
  ' left join VIW_USERS E on A.TENANT_ID=E.TENANT_ID and A.CREA_USER=E.USER_ID '+
  ' left join PUB_PARAMS F on A.INVOICE_FLAG=F.CODE_ID '+
  ' where A.TENANT_ID=:TENANT_ID and A.INVD_ID=:INVD_ID and F.TYPE_CODE=''INVOICE_FLAG'' ';
  IsSQLUpdate := True;
  Str := 'insert into SAL_INVOICE_INFO(TENANT_ID,INVD_ID,INVH_ID,SHOP_ID,DEPT_ID,CREA_USER,CREA_DATE,CLIENT_ID,INVO_NAME,ADDR_NAME,REMARK,INVOICE_FLAG,INVOICE_NO,INVOICE_MNY,INVOICE_STATUS,EXPORT_STATUS,COMM,TIME_STAMP) '
    + 'VALUES(:TENANT_ID,:INVD_ID,:INVH_ID,:SHOP_ID,:DEPT_ID,:CREA_USER,:CREA_DATE,:CLIENT_ID,:INVO_NAME,:ADDR_NAME,:REMARK,:INVOICE_FLAG,:INVOICE_NO,:INVOICE_MNY,:INVOICE_STATUS,:EXPORT_STATUS,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;
  Str := 'update SAL_INVOICE_INFO set TENANT_ID=:TENANT_ID,INVD_ID=:INVD_ID,INVH_ID=:INVH_ID,SHOP_ID=:SHOP_ID,DEPT_ID=:DEPT_ID,CREA_USER=:CREA_USER,'
    + 'CREA_DATE=:CREA_DATE,CLIENT_ID=:CLIENT_ID,INVO_NAME=:INVO_NAME,ADDR_NAME=:ADDR_NAME,REMARK=:REMARK,INVOICE_FLAG=:INVOICE_FLAG,'
    + 'INVOICE_NO=:INVOICE_NO,INVOICE_MNY=:INVOICE_MNY,INVOICE_STATUS=:INVOICE_STATUS,EXPORT_STATUS=:EXPORT_STATUS '
    + ',COMM=' + GetCommStr(iDbType)
    + ',TIME_STAMP='+GetTimeStamp(iDbType)
    + ' where INVD_ID=:OLD_INVD_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_INVOICE_INFO where INVD_ID=:OLD_INVD_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;

{ TInvoiceData }

function TInvoiceData.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvoiceData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TInvoiceData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := ' select B.GLIDE_NO from SAL_INVOICE_LIST A,SAL_SALESORDER B,SAL_INVOICE_INFO C where A.TENANT_ID=B.TENANT_ID '+
    ' and A.SALES_ID=B.SALES_ID and A.TENANT_ID=C.TENANT_ID and A.INVD_ID=C.INVD_ID and C.INVOICE_STATUS=''1'' and A.TENANT_ID=:TENANT_ID and A.SALES_ID=:SALES_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldByName('TENANT_ID').AsInteger;
    rs.ParamByName('SALES_ID').AsString := FieldByName('SALES_ID').AsString;
    AGlobal.Open(rs);
    if rs.RecordCount>0 then
       Raise Exception.Create('销售单号"'+rs.FieldByName('GLIDE_NO').AsString+'"已经开单...');
  finally
    rs.Free;
  end;
end;

function TInvoiceData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
    rs:TZQuery;
    n:Integer;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := ' select count(*) from SAL_INVOICE_LIST A,SAL_INVOICE_INFO B where A.TENANT_ID=B.TENANT_ID and A.INVD_ID=B.INVD_ID '+
    ' and A.TENANT_ID=:TENANT_ID and A.SALES_ID=:SALES_ID and A.INVD_ID<>:INVD_ID and B.INVOICE_STATUS=''1'' ';
    rs.ParamByName('TENANT_ID').AsInteger := Params.FindParam('TENANT_ID').AsInteger;
    rs.ParamByName('SALES_ID').AsString := Params.FindParam('SALES_ID').AsString;
    rs.ParamByName('INVD_ID').AsString := Params.FindParam('INVD_ID').AsString;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then
       Raise Exception.Create('发票中的销售单已开票!');
  finally
    rs.Free;
  end;
end;

procedure TInvoiceData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text :=
  'select TENANT_ID,INVD_ID,SALES_ID from SAL_INVOICE_LIST where TENANT_ID=:TENANT_ID and INVD_ID=:INVD_ID ';
  IsSQLUpdate := True;
  Str := ' insert into SAL_INVOICE_LIST(TENANT_ID,INVD_ID,SALES_ID) VALUES(:TENANT_ID,:INVD_ID,:SALES_ID) ';
  InsertSQL.Text := Str;
  Str := 'update SAL_INVOICE_LIST set TENANT_ID=:TENANT_ID,INVD_ID=:INVD_ID,SALES_ID=:SALES_ID '+
         ' where SALES_ID=:OLD_SALES_ID and INVD_ID=:OLD_INVD_ID and TENANT_ID=:OLD_TENANT_ID';
  UpdateSQL.Text := Str;
  Str := 'delete from SAL_INVOICE_LIST where SALES_ID=:OLD_SALES_ID and INVD_ID=:OLD_INVD_ID and TENANT_ID=:OLD_TENANT_ID';
  DeleteSQL.Text := Str;
end;

{ TInvoiceOrderAudit }

function TInvoiceOrderAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    n:Integer;
begin
  try
    Str := 'update SAL_INVOICE_INFO set INVOICE_STATUS=''2'',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
    ' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INVD_ID='''+Params.FindParam('INVD_ID').asString+''' ';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到待作废发票，是否被另一用户删除或已作废。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Result := true;
    Msg := '作废发票成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '作废错误'+E.Message;
      end;
  end;
end;

{ TInvoiceOrderUnAudit }

function TInvoiceOrderUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var Str:string;
    rs:TZQuery;
    n:Integer;
begin
  try
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := ' select A.SALES_ID from SAL_INVOICE_LIST A,SAL_INVOICE_INFO B where A.TENANT_ID=B.TENANT_ID and A.INVD_ID=B.INVD_ID and A.TENANT_ID=:TENANT_ID'+
      ' and A.SALES_ID in ( select SALES_ID from SAL_INVOICE_LIST  where TENANT_ID=:TENANT_ID and INVD_ID=:INVD_ID) and B.INVOICE_STATUS=''1'' ';
      rs.ParamByName('TENANT_ID').AsInteger := Params.FindParam('TENANT_ID').AsInteger;
      rs.ParamByName('INVD_ID').AsString := Params.FindParam('INVD_ID').AsString;
      AGlobal.Open(rs);
      if rs.FieldByName('SALES_ID').AsString <> '' then
         Raise Exception.Create('作废发票中的销售单已有重新开票!');
    finally
      rs.Free;
    end;
    Str := 'update SAL_INVOICE_INFO set INVOICE_STATUS=''1'',COMM=' + GetCommStr(AGlobal.iDbType) + ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+
    ' where TENANT_ID='+Params.FindParam('TENANT_ID').asString +' and INVD_ID='''+Params.FindParam('INVD_ID').asString+''' ';
    n := AGlobal.ExecSQL(Str);
    if n=0 then
       Raise Exception.Create('没找到已作废发票，是否被另一用户删除或已升效。')
    else
    if n>1 then
       Raise Exception.Create('删除指令会影响多行，可能数据库中数据误。');
    Result := true;
    Msg := '升效发票成功';
  except
    on E:Exception do
      begin
        Result := false;
        Msg := '升效错误'+E.Message;
      end;
  end;
end;

initialization
  RegisterClass(TInvoiceOrder);
  RegisterClass(TInvoiceData);
  RegisterClass(TInvoiceOrderAudit);
  RegisterClass(TInvoiceOrderUnAudit);
finalization
  UnRegisterClass(TInvoiceOrder);
  UnRegisterClass(TInvoiceData);
  UnRegisterClass(TInvoiceOrderAudit);
  UnRegisterClass(TInvoiceOrderUnAudit);
end.
