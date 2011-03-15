unit ObjCloseForDay;

interface
uses Dialogs,SysUtils,zBase,Classes,DB, ZDataSet,zIntf,ObjCommon;
type
  TCloseForDay=class(TZFactory)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function CheckTimeStamp(aGlobal:IdbHelp;s:string):boolean;
    procedure InitClass;override;
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
var Str:String;
begin
  Result := False;
  if not CheckTimeStamp(AGlobal,FieldbyName('TIME_STAMP').AsString) then Raise Exception.Create('当前结账记录已经被另一用户修改.');
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=-OLD_:PAY_A+isnull(IN_MNY,0),BALANCE=-:OLD_PAY_A+isnull(BALANCE,0),'+
  'COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PAYM_ID=''A'' ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),self);

  Str := 'delete ACC_CLOSE_FORDAY where TENANT_ID=:OLD_TENANT_ID and ROWS_ID=:OLD_ROWS_ID';
  AGlobal.ExecSQL(Str,self);
  Result := True;
end;

function TCloseForDay.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Result := False;;
  Str :=
  'insert into ACC_CLOSE_FORDAY(ROWS_ID,TENANT_ID,SHOP_ID,CLSE_DATE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,'+
  'PAY_I,PAY_J,CREA_DATE,CREA_USER,COMM,TIME_STAMP) values('''+newid(FieldbyName('SHOP_ID').asString)+''',:TENANT_ID,:SHOP_ID,:CLSE_DATE,:PAY_A,:PAY_B,:PAY_C,'+
  ':PAY_D,:PAY_E,:PAY_F,:PAY_G,:PAY_H,:PAY_I,:PAY_J,'''+formatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  AGlobal.ExecSQL(Str,Self);
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=:PAY_A+isnull(IN_MNY,0),BALANCE=:PAY_A+isnull(BALANCE,0),'+
  'COMM='+GetCommStr(iDbType)+
  ',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and PAYM_ID=''A'' ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);
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
    ' and ROWS_ID='''+Params.FindParam('ROWS_ID').AsString+''' and CHK_DATE is not null';
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
    ' and ROWS_ID='''+Params.FindParam('ROWS_ID').AsString+''' and CHK_DATE is null';
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
