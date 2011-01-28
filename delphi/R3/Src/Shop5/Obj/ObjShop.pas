unit ObjShop;

interface
uses Dialogs,SysUtils,ZBase,Classes,ZIntf,AdoDb,ObjCommon,ZDataset;
type
  TShop=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  TShopDelete=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
  TIntoShop=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;
implementation

{ TCompany }

function TShop.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  {result := true;
//  if FieldbyName('GROUP_NAME').asString = '#' then FieldbyName('GROUP_NAME').AsString := '';
  Str := 'insert into SYS_DEFINE(COMP_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values('''+FieldbyName('COMP_ID').AsString+''',''USING_DATE'','''+FormatDatetime('YYYY-MM-01',DATE())+''',0,''00'','+GetTimeStamp(iDbType)+')';
  AGlobal.ExecSQL(Str);
  if FieldbyName('UPCOMP_ID').AsString <> '' then
  begin
    Str := 'insert into SYS_DEFINE(COMP_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP)  select '''+FieldbyName('COMP_ID').AsString+''',DEFINE,VALUE,0,''00'','+GetTimeStamp(iDbType)+' from SYS_DEFINE where COMP_ID='+QuotedStr(FieldByName('UPCOMP_ID').AsString)+' and DEFINE<>''USING_DATE''';
    AGlobal.ExecSQL(Str);
  end;
  if FieldByName('COMP_TYPE').AsString<>'2'  then
  begin
    Str:=' insert into CA_USERS(USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,COMP_ID,CAN_LOGIN,COMM,TIME_STAMP ) '+
         ' values('''+FieldbyName('COMP_ID').AsString+''','''+FieldbyName('COMP_ID').AsString+''','''+FieldbyName('COMP_NAME').AsString+'(管理员)'+''','''+FieldbyName('COMP_SPELL').AsString+'(GLY)'+''',''000'','''+FieldbyName('COMP_ID').AsString+''',''1'',''00'','+GetTimeStamp(iDbType)+' )';
    AGlobal.ExecSQL(Str);
    Str:=' Insert into CA_COMPRIGHT(COMP_ID,USER_ID,COMM,TIME_STAMP) '
       +' VALUES('''+FieldbyName('COMP_ID').AsString+''','''+FieldbyName('COMP_ID').AsString+''',''00'','+GetTimeStamp(iDbType)+')';
    AGlobal.ExecSQL(Str);
  end;
  if (FieldbyName('UPCOMP_ID').AsString <> '') then
  begin
    Str := 'insert into CA_RIGHTS(COMP_ID,MID,UID,UTYPE,CHK,COMM,TIME_STAMP) '
    + 'select '''+FieldbyName('COMP_ID').AsString+''',MID,UID,UTYPE,CHK,''00'','+GetTimeStamp(iDbType)+' from CA_RIGHTS where COMP_ID='''+FieldbyName('UPCOMP_ID').AsString+'''';
    AGlobal.ExecSQL(Str);
  end;}
end;

function TShop.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var SQL,str:string;
    tmp:TADODataSet;
begin
//  if FieldbyName('GROUP_NAME').asString = '#' then FieldbyName('GROUP_NAME').AsString := '';
  {case iDbType of
  0:SQL := 'update CA_COMPANY set LEVEL_ID='''+FieldbyName('LEVEL_ID').AsString+'''+substring(LEVEL_ID,len('''+FieldbyName('LEVEL_ID').AsOldString+''')+1,50) where LEVEL_ID like '''+FieldbyName('LEVEL_ID').AsOldString+'%''';
  3:SQL := 'update CA_COMPANY set LEVEL_ID='''+FieldbyName('LEVEL_ID').AsString+'''+mid(LEVEL_ID,len('''+FieldbyName('LEVEL_ID').AsOldString+''')+1,50) where LEVEL_ID like '''+FieldbyName('LEVEL_ID').AsOldString+'%''';
  end;
  AGlobal.ExecSQL(SQL,self);
  if (FieldByName('COMP_TYPE').AsOldString='2') and (FieldByName('COMP_TYPE').AsString<>FieldByName('COMP_TYPE').AsOldString) then
  begin
    tmp:=TADODataSet.Create(nil);
    try
      tmp.Close;
      tmp.CommandText:='select top 1 USER_ID from VIW_USERS where COMP_ID='+QuotedStr(FieldbyName('COMP_ID').AsString);
      AGlobal.Open(tmp);
      if tmp.RecordCount=0 then
      begin
        Str:=' insert into CA_USERS(USER_ID,ACCOUNT,USER_NAME,USER_SPELL,DUTY_IDS,COMP_ID,CAN_LOGIN,COMM,TIME_STAMP ) '+
             ' values('''+FieldbyName('COMP_ID').AsString+''','''+FieldbyName('COMP_ID').AsString+''','''+FieldbyName('COMP_NAME').AsString+'(管理员)'+''','''+FieldbyName('COMP_SPELL').AsString+'(GLY)'+''',''000'','''+FieldbyName('COMP_ID').AsString+''',''1'',''00'','+GetTimeStamp(iDbType)+' )';
        AGlobal.ExecSQL(Str);
        Str:=' Insert into CA_COMPRIGHT(COMP_ID,USER_ID,COMM,TIME_STAMP) '
           +' VALUES('''+FieldbyName('COMP_ID').AsString+''','''+FieldbyName('COMP_ID').AsString+''',''00'','+GetTimeStamp(iDbType)+')';
        AGlobal.ExecSQL(Str);
      end;
    finally
      tmp.Free;
    end;
  end;}
end;

procedure TShop.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='SHOP_ID';
  SelectSQL.Text := 'Select SHOP_ID,SHOP_NAME,SHOP_SPELL,TENANT_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,REGION_ID,SHOP_TYPE,SEQ_NO From CA_SHOP_INFO where TENANT_ID=:TENANT_ID order by SEQ_NO';
  IsSQLUpdate := True;
  Str := 'insert into CA_SHOP_INFO(SHOP_ID,SHOP_NAME,SHOP_SPELL,TENANT_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,REGION_ID,SHOP_TYPE,SEQ_NO,COMM,TIME_STAMP) '
       + 'VALUES(:SHOP_ID,:SHOP_NAME,:SHOP_SPELL,:TENANT_ID,:LINKMAN,:TELEPHONE,:FAXES,:ADDRESS,:POSTALCODE,:REMARK,:REGION_ID,:SHOP_TYPE,:SEQ_NO,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(Str);
  Str := 'update CA_SHOP_INFO set COMP_ID=:COMP_ID,COMP_TYPE=:COMP_TYPE,COMP_NAME=:COMP_NAME,COMP_SPELL=:COMP_SPELL,LEVEL_ID=:LEVEL_ID,UPCOMP_ID=:UPCOMP_ID,TELEPHONE=:TELEPHONE,FAXES=:FAXES,ADDRESS=:ADDRESS,POSTALCODE=:POSTALCODE,'
    +'REMARK=:REMARK,GROUP_NAME=:GROUP_NAME,LINKMAN=:LINKMAN,SEQ_NO=:SEQ_NO,COMM='+ GetCommStr(iDbType) + ',TIME_STAMP='+GetTimeStamp(iDbType)+' where SHOP_ID=:OLD_SHOP_ID';
  UpdateSQL.Add(Str);
  Str := 'update CA_SHOP_INFO set COMM=''02'' where SHOP_ID=:OLD_SHOP_ID';
  DeleteSQL.Add(Str);
end;

{ TShopDelete }

function TShopDelete.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var tmp:TZQuery;
begin
  Result:=False;
  AGlobal.BeginTrans;
  try
    tmp:=TZQuery.Create(nil);
    try
      tmp.Close;
      tmp.SQL.Text:='select * from CA_SHOP_INFO where UPCOMP_ID='+Params.ParamByName('SHOP_ID').asString;
      AGlobal.Open(tmp);
      if tmp.RecordCount>0 then
      begin
        raise Exception.Create('门店'+Params.ParamByName('COMP_NAME').asString+'有下级门店不能删除！');
      end
      else
      begin
        AGlobal.ExecSQL('update CA_SHOP_INFO set  COMM=''02'',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where SHOP_ID='+Params.ParamByName('COMP_ID').asString);
      end;
      AGlobal.CommitTrans;
    finally
      tmp.Free;
    end;
    Result:=True;
  except
    on E:Exception do
       begin
         Msg := E.Message;
         AGlobal.RollBackTrans;
       end;
  end;
end;

{ TIntoShop }

function TIntoShop.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var SHOP_ID1,SHOP_ID2,LEVEL_ID,Str:string;//SHOP_ID1 原来总店ID,SHOP_ID2 要装换成总店的门店ID
begin
  Result:=False;
  AGlobal.BeginTrans;
  try
    SHOP_ID1:=Params.ParamByName('SHOP_ID1').asString;
    SHOP_ID2:=Params.ParamByName('SHOP_ID2').asString;
    LEVEL_ID:=Params.ParamByName('LEVEL_ID').asString;
    Str:='update CA_SHOP_INFO set UPCOMP_ID=NULL,LEVEL_ID='''+SHOP_ID2+''',SHOP_TYPE=1 '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where SHOP_ID='''+SHOP_ID2+'''';
    AGlobal.ExecSQL(Str,Self); //修改要转换成总店的门店的UPCOMP_ID和LEVEL_ID
    Str:='update CA_COMPANY set LEVEL_ID='''+SHOP_ID2+'''+substring(LEVEL_ID,len('''+LEVEL_ID+''')+1,50)  '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where LEVEL_ID like '''+LEVEL_ID+'%''';
    AGlobal.ExecSQL(Str,Self);//修改“要转换成总店的门店”的下级门店的LEVEL_ID
    Str:='update CA_COMPANY set UPCOMP_ID='''+SHOP_ID2+''',LEVEL_ID='''+SHOP_ID2+'''+LEVEL_ID,COMP_TYPE=2 '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+ ' where COMP_ID='''+SHOP_ID1+'''';
    AGlobal.ExecSQL(Str,Self);//修改原总店的UPCOMP_ID和LEVEL_ID
    Str:='update CA_COMPANY set UPCOMP_ID='''+SHOP_ID2+''',LEVEL_ID='''+SHOP_ID2+'''+substring(LEVEL_ID,4,50) '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where UPCOMP_ID='''+SHOP_ID1+'''';
    AGlobal.ExecSQL(Str,Self);//修改原总店的第一级下级门店的UPCOMP_ID和LEVEL_ID
    Str:='update CA_COMPANY set LEVEL_ID='''+SHOP_ID2+'''+substring(LEVEL_ID,4,50) '
    + ',COMM=''01'','
    + 'TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+' where LEVEL_ID like '''+SHOP_ID1+'%''';
    AGlobal.ExecSQL(Str,Self);//修改原总店的下级门店的LEVEL_ID
    AGlobal.CommitTrans;
    Result:=True;
  except
    on E:Exception do
       begin
         Msg := E.Message;
         AGlobal.RollbackTrans;
       end;
  end;
end;

initialization
  RegisterClass(TShop);
  RegisterClass(TShopDelete);
  RegisterClass(TIntoShop);
finalization
  UnRegisterClass(TShop);
  UnRegisterClass(TShopDelete);
  UnRegisterClass(TIntoShop);
end.
