unit ObjMessageV60;

interface

uses Dialogs,SysUtils,zBase,Classes,ZIntf,ObjCommon,DB,ZDataSet,math;

type
  TMessageListV60=class(TZFactory)
  public
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TMessageV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

function TMessageListV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
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

function TMessageListV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  Str:String;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := ' select count(*) as ReSum from MSC_MESSAGE_LIST where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MSG_ID=:MSG_ID ';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('SHOP_ID').AsString := FieldbyName('SHOP_ID').AsString;
    rs.ParamByName('MSG_ID').AsString := FieldbyName('MSG_ID').AsString;
    AGlobal.Open(rs);
    if rs.FieldByName('ReSum').AsInteger=0 then
       begin
         Str := ' insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,READ_DATE,READ_USER,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP) '+
                ' values(:TENANT_ID,:MSG_ID,:SHOP_ID,:READ_DATE,:READ_USER,:MSG_FEEDBACK_STATUS,:MSG_READ_STATUS,''00'','+GetTimeStamp(iDbType)+')';
         AGlobal.ExecSQL(Str,self);
       end;
    result := True;
  finally
    rs.Free;
  end;
end;

procedure TMessageListV60.InitClass;
var
  Str: string;
begin
  inherited;
  IsSQLUpdate := True;

  Str := ' select TENANT_ID,MSG_ID,SHOP_ID,READ_DATE,READ_USER,MSG_FEEDBACK_STATUS,MSG_READ_STATUS '+
         ' from MSC_MESSAGE_LIST  where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and MSG_ID=:MSG_ID';
  SelectSQL.Text := Str;

  Str := 'update MSC_MESSAGE_LIST set READ_DATE=:READ_DATE,READ_USER=:READ_USER,MSG_FEEDBACK_STATUS=:MSG_FEEDBACK_STATUS,MSG_READ_STATUS=:MSG_READ_STATUS,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and MSG_ID=:OLD_MSG_ID ';
  UpdateSQL.Text := Str;

  Str := 'update MSC_MESSAGE_LIST set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and MSG_ID=:OLD_MSG_ID ';
  DeleteSQL.Text := Str;
end;

function TMessageV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:String;
begin
  Str := ' update MSC_MESSAGE set MSG_CLASS=:MSG_CLASS,ISSUE_DATE=:ISSUE_DATE,ISSUE_TENANT_ID=:ISSUE_TENANT_ID,MSG_SOURCE=:MSG_SOURCE,ISSUE_USER=:ISSUE_USER,'+
         ' MSG_TITLE=:MSG_TITLE,MSG_CONTENT=:MSG_CONTENT,END_DATE=:END_DATE,COMM_ID=:COMM_ID,COMM=''10'',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' where TENANT_ID=:TENANT_ID and MSG_ID=:MSG_ID ';
  if AGlobal.ExecSQL(Str,self) = 0 then
     begin
       Str :=
         ' insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
         ' values(:TENANT_ID,:MSG_ID,:MSG_CLASS,:ISSUE_DATE,:ISSUE_TENANT_ID,:MSG_SOURCE,:ISSUE_USER,:MSG_TITLE,:MSG_CONTENT,:END_DATE,:COMM_ID,''10'','+GetTimeStamp(iDbType)+')';
       AGlobal.ExecSQL(Str,self);
     end;
  result := True;
end;

procedure TMessageV60.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text := ' select TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM,COMM_ID from MSC_MESSAGE '+
                    ' where TENANT_ID=:TENANT_ID and MSG_ID=:MSG_ID ';
  IsSQLUpdate := True;

  Str := ' update MSC_MESSAGE set MSG_CLASS=:MSG_CLASS,ISSUE_DATE=:ISSUE_DATE,ISSUE_TENANT_ID=:ISSUE_TENANT_ID,MSG_SOURCE=:MSG_SOURCE,ISSUE_USER=:ISSUE_USER,'+
         ' MSG_TITLE=:MSG_TITLE,MSG_CONTENT=:MSG_CONTENT,END_DATE=:END_DATE,COMM_ID=:COMM_ID,COMM=''11'',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' where TENANT_ID=:OLD_TENANT_ID and MSG_ID=:OLD_MSG_ID ';
  UpdateSQL.Text := Str;

  Str := ' update MSC_MESSAGE set COMM=''12'',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' where TENANT_ID=:OLD_TENANT_ID and MSG_ID=:OLD_MSG_ID ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TMessageListV60);
  RegisterClass(TMessageV60);
finalization
  UnRegisterClass(TMessageListV60);
  UnRegisterClass(TMessageV60);
end.
