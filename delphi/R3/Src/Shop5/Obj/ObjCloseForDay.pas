unit ObjCloseForDay;

interface
uses Dialogs,SysUtils,zBase,Classes,DB, ZDataSet,zIntf,ObjCommon;
type
  TCloseForDay=class(TZFactory)
  public
    ps:TZQuery;
    function GetPayment(s:string):string;
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function CheckTimeStamp(aGlobal:IdbHelp;s:string):boolean;
    procedure InitClass;override;
    procedure CreateNew(AOwner: TComponent);override;
    destructor  Destroy;override;
  end;
  TCloseAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TCloseUnAudit=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;


implementation

{ TCloseForDay }

function TCloseForDay.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str:String;
  r:integer;
  rs:TZQuery;
begin
  Result := False;
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString) then Raise Exception.Create('当前结账记录已经被另一用户修改.');

  Result := GetAccountRange(AGlobal,FieldbyName('TENANT_ID').AsOldString,FieldbyName('SHOP_ID').AsOldString,FieldbyName('CLSE_DATE').AsOldString);
//  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=-:OLD_PAY_A+isnull(IN_MNY,0),BALANCE=-:OLD_PAY_A+isnull(BALANCE,0),'+
//  'COMM='+GetCommStr(iDbType)+
//  ',TIME_STAMP='+GetTimeStamp(iDbType)+
//  ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PAYM_ID=''A'' ';

//  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select count(*) from ACC_RECVABLE_INFO where TENANT_ID=:OLD_TENANT_ID and CLSE_DATE=:OLD_CLSE_DATE and RECV_TYPE=''4'' and RECV_MNY<>0';
    CopyToParams(rs.Params,true);
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger > 0 then Raise Exception.Create('当天的结账记录，已经做缴款登记了不能撤消？');  
  finally
    rs.Free;
  end;
  Str := 'delete from ACC_RECVABLE_INFO where TENANT_ID=:OLD_TENANT_ID and CLSE_DATE=:OLD_CLSE_DATE and RECV_TYPE=''4''';
  r := AGlobal.ExecSQL(Str,self);
  if r = 0 then Raise Exception.Create('没找到前当结账记录，是否被另一用户撤消？');

  Str := 'delete from ACC_CLOSE_FORDAY where TENANT_ID=:OLD_TENANT_ID and CLSE_DATE=:OLD_CLSE_DATE';
  r := AGlobal.ExecSQL(Str,self);
  if r = 0 then Raise Exception.Create('没找到前当结账记录，是否被另一用户撤消？'); 
  Result := True;
end;

function TCloseForDay.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str,id:String;
  rs:TZQuery;
begin
  Result := False;;
  id := newid(FieldbyName('SHOP_ID').asString);
  Str :=
  'insert into ACC_CLOSE_FORDAY(ROWS_ID,TENANT_ID,SHOP_ID,CLSE_DATE,CLSE_MNY,CLSE_TYPE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,'+
  'PAY_I,PAY_J,CREA_DATE,CREA_USER,COMM,TIME_STAMP) values('''+id+''',:TENANT_ID,:SHOP_ID,:CLSE_DATE,:CLSE_MNY,:CLSE_TYPE,:PAY_A,:PAY_B,:PAY_C,'+
  ':PAY_D,:PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,'''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  rs := TZQuery.Create(nil);
  try
    if not ps.Active then
       begin
         ps.Close;
         ps.SQL.Text := 'select CODE_ID,CODE_NAME,CODE_SPELL from VIW_PAYMENT where TENANT_ID='+FieldbyName('TENANT_ID').AsString;
         AGlobal.Open(ps); 
       end;
    rs.SQL.Text :=
      'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,PAYM_ID,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
    + 'VALUES(:ABLE_ID,:TENANT_ID,:SHOP_ID,:SHOP_ID,:ACCT_INFO,''4'',:PAYM_ID,:RECV_MNY,0,0,:RECV_MNY,:CLSE_DATE,:ROWS_ID,'+GetSysDateFormat(iDbType)+',:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
    CopyToParams(rs.Params);
    rs.ParambyName('ABLE_ID').AsString := newid(FieldbyName('SHOP_ID').asString);
    rs.ParambyName('ROWS_ID').AsString := id;
    if FieldbyName('PAY_A').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('A')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'A';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_A').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
    if FieldbyName('PAY_B').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('B')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'B';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_B').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
    if FieldbyName('PAY_C').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('C')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'C';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_C').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
    if FieldbyName('PAY_E').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('E')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'E';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_E').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
    if FieldbyName('PAY_F').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('F')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'F';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_F').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
    if FieldbyName('PAY_G').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('G')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'G';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_G').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
    if FieldbyName('PAY_H').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('H')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'H';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_H').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
    if FieldbyName('PAY_I').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('I')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'I';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_I').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
    if FieldbyName('PAY_J').AsFloat<>0 then
       begin
         rs.ParambyName('ACCT_INFO').AsString := '门店销售【'+GetPayment('J')+'】';
         rs.ParambyName('PAYM_ID').AsString := 'J';
         rs.ParambyName('RECV_MNY').AsFloat := FieldbyName('PAY_J').AsFloat;
         AGlobal.ExecQuery(rs);
       end;
  finally
    rs.Free;
  end;
//  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=:PAY_A+isnull(IN_MNY,0),BALANCE=:PAY_A+isnull(BALANCE,0),'+
//  'COMM='+GetCommStr(iDbType)+
//  ',TIME_STAMP='+GetTimeStamp(iDbType)+
//  ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PAYM_ID=''A'' ';
//  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);
  Result := True;
end;

function TCloseForDay.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TCloseForDay.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  Result := True;
end;

function TCloseForDay.CheckTimeStamp(aGlobal: IdbHelp; s: string): boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP,COMM from ACC_CLOSE_FORDAY where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' and ROWS_ID='''+FieldbyName('ROWS_ID').AsString+'''';
    aGlobal.Open(rs);
    result := (rs.Fields[0].AsString = s) and (copy(rs.Fields[1].asString,1,1)<>'1');
  finally
    rs.Free;
  end;
end;

procedure TCloseForDay.CreateNew(AOwner: TComponent);
begin
  inherited;
  ps := TZQuery.Create(nil);
end;

destructor TCloseForDay.Destroy;
begin
  ps.Free;
  inherited;
end;

function TCloseForDay.GetPayment(s: string): string;
begin
  if ps.Locate('CODE_ID',s,[]) then
     result := ps.FieldbyName('CODE_NAME').AsString
  else
     Raise Exception.Create(s+'支付方式没有找到'); 
end;

procedure TCloseForDay.InitClass;
begin
  inherited;
  //KeyFields := 'ROWS_ID';
  IsSQLUpdate := True;
end;


{ TCloseUnAudit }

function TCloseUnAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var StrSql:String;
    n:Integer;
begin
  try
    StrSql := 'update ACC_CLOSE_FORDAY set CHK_DATE=null,CHK_USER=null,COMM='+GetCommStr(AGlobal.iDbType)+
    ',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').AsString+
    ' and SHOP_ID='''+Params.FindParam('SHOP_ID').AsString+''' and CLSE_DATE='+Params.FindParam('CLSE_DATE').AsString+' and CHK_DATE is not null';
    n := AGlobal.ExecSQL(StrSql);
    if n = 0 then
      Raise Exception.Create('没找到审核单据,是否被另一用户删除或反审核.')
    else if n>1 then
      Raise Exception.Create('弃审指令会影响多行,可能数据库中数据有误.');

    Result := True;
    Msg := '弃审单据成功';
  Except
    on E:Exception do
      begin
        Result := False;
        Msg := '弃审错误:'+E.Message;
      end;
  end;

end;

{ TCloseAudit }

function TCloseAudit.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var StrSql:String;
    n:Integer;
begin
  try
    StrSql := 'update ACC_CLOSE_FORDAY set CHK_DATE='''+Params.FindParam('CHK_DATE').AsString+''',CHK_USER='''+Params.FindParam('CHK_USER').AsString+
    ''',COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where TENANT_ID='+Params.FindParam('TENANT_ID').AsString+
    ' and SHOP_ID='''+Params.FindParam('SHOP_ID').AsString+''' and CLSE_DATE='+Params.FindParam('CLSE_DATE').AsString+' and CHK_DATE is null';
    n := AGlobal.ExecSQL(StrSql);
    if n = 0 then
      Raise Exception.Create('没找到待审核单据,是否被另一用户删除或已审核.')
    else if n > 1 then
      Raise Exception.Create('审核指令会影响多行,可能数据库中数据误.');

    Result := True;
    Msg := '审核单据成功';
  Except
    on E:Exception do
      begin
        Result := False;
        Msg := '审核错误:'+E.Message;
      end;
  end;
end;

initialization
  RegisterClass(TCloseForDay);
  RegisterClass(TCloseAudit);
  RegisterClass(TCloseUnAudit);

finalization
  UnRegisterClass(TCloseForDay);
  UnRegisterClass(TCloseAudit);
  UnRegisterClass(TCloseUnAudit);

end.
