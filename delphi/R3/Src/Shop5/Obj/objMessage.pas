unit objMessage;

interface
uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;

type
  TMessage=class(TZFactory)
  public
    procedure InitClass; override;
    //function CheckReck(AGlobal:IdbHelp):boolean;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TPublishMessage=class(TZFactory)
  public
    procedure InitClass; override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;    
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;    
  end;

implementation


{ TMessage }

function TMessage.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMessage.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TMessage.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TMessage.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='MSG_ID';

  Str :=
  'select ja.*,a.USER_NAME as ISSUE_USER_TEXT from( '+
  'select TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM,COMM_ID from MSC_MESSAGE '+
  ' where COMM not in (''02'',''12'') and MSG_ID=:MSG_ID and TENANT_ID=:TENANT_ID ) ja '+
  ' left join VIW_USERS a on ja.TENANT_ID=a.TENANT_ID and a.USER_ID=ja.ISSUE_USER';

  SelectSQL.Text := Str;
  IsSQLUpdate := True;
  Str := 'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
  'values(:TENANT_ID,:MSG_ID,:MSG_CLASS,:ISSUE_DATE,:ISSUE_TENANT_ID,:MSG_SOURCE,:ISSUE_USER,:MSG_TITLE,:MSG_CONTENT,:END_DATE,:COMM_ID,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update MSC_MESSAGE set MSG_CLASS=:MSG_CLASS,ISSUE_DATE=:ISSUE_DATE,ISSUE_TENANT_ID=:ISSUE_TENANT_ID,MSG_SOURCE=:MSG_SOURCE,ISSUE_USER=:ISSUE_USER,'+
  'MSG_TITLE=:MSG_TITLE,MSG_CONTENT=:MSG_CONTENT,END_DATE=:END_DATE,COMM_ID=:COMM_ID,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and MSG_ID=:OLD_MSG_ID ';
  UpdateSQL.Text := Str;

  Str := 'update MSC_MESSAGE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and MSG_ID=:OLD_MSG_ID ';
  DeleteSQL.Text := Str;
end;

{ TPublishMessage }

function TPublishMessage.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var rs:TZQuery;
    Str:String;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM from MSC_MESSAGE_LIST where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MSG_ID=:MSG_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsString;
    rs.ParamByName('MSG_ID').AsString := FieldbyName('MSG_ID').AsString;
    AGlobal.Open(rs);

    if (rs.FieldByName('MSG_FEEDBACK_STATUS').AsString = '2') or (rs.FieldByName('MSG_READ_STATUS').AsString = '2') then
      Raise Exception.Create('已经阅读,不能删除!');
      
  finally
    rs.Free;
  end;
end;

function TPublishMessage.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var Str:String;
begin
  Str := ' update MSC_MESSAGE_LIST set COMM='+GetCommStr(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and MSG_ID=:OLD_MSG_ID ';
  if AGlobal.ExecSQL(Str,Self) = 0 then
    begin
      Str :=
        'insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP) '+
        'values(:TENANT_ID,:MSG_ID,:SHOP_ID,1,1,''00'','+GetTimeStamp(iDbType)+')';
      AGlobal.ExecSQL(Str,Self);
    end;
  Result := True;
end;

procedure TPublishMessage.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='TENANT_ID,MSG_ID,SHOP_ID';
  IsSQLUpdate := True;
  Str :=
  'select a.TENANT_ID,a.MSG_ID,b.SHOP_ID,b.SHOP_NAME,b.SHOP_SPELL,b.SHOP_TYPE,b.REGION_ID,b.LINKMAN,b.TELEPHONE,b.FAXES,b.POSTALCODE,b.REMARK,b.SEQ_NO '+
  'from MSC_MESSAGE_LIST a left join CA_SHOP_INFO b on a.TENANT_ID=b.TENANT_ID and a.SHOP_ID=b.SHOP_ID '+
  ' where a.COMM not in (''12'',''02'') and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.MSG_ID=:MSG_ID';
  SelectSQL.Text := Str;

  Str := 'update MSC_MESSAGE_LIST set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and MSG_ID=:OLD_MSG_ID ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TMessage);
  RegisterClass(TPublishMessage);
finalization
  UnRegisterClass(TMessage);
  UnRegisterClass(TPublishMessage);

end.
