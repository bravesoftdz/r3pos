unit ObjUtilsV60;

interface
uses Windows,SysUtils,ZBase,Classes,DB,uFnUtil,ZIntf,Variants,ZDataSet,ObjCommon;
type
TCheckAppVersion=class(TZProcFactory)
public
  function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
end;
TCalcNewStorage=class(TZProcFactory)
public
  function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
end;
TRtcSyncClose=class(TZProcFactory)
public
  function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
end;

implementation

{ TCheckAppVersion }

function TCheckAppVersion.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  delDaysClose,delMonthClose:string;
  insertVersion,updateVersion:string;
begin
   delDaysClose  := 'delete from RCK_DAYS_CLOSE  where TENANT_ID='+params.ParambyName('TENANT_ID').AsString;
   delMonthClose := 'delete from RCK_MONTH_CLOSE where TENANT_ID='+params.ParambyName('TENANT_ID').AsString;
   updateVersion := 'update SYS_DEFINE set VALUE=''V6'' where TENANT_ID='+params.ParambyName('TENANT_ID').AsString+' and DEFINE=''APPVERSION'' ';
   insertVersion := 'insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values ('+params.ParambyName('TENANT_ID').AsString+',''APPVERSION'',''V6'',0,''00'','+GetTimeStamp(AGlobal.iDbType)+') ';
   AGlobal.BeginTrans;
   try
     AGlobal.ExecSQL(delDaysClose);
     AGlobal.ExecSQL(delMonthClose);
     if AGlobal.ExecSQL(updateVersion) <= 0 then
        AGlobal.ExecSQL(insertVersion);
     AGlobal.CommitTrans;
     result := true;
   except
     on E:Exception do
        begin
          AGlobal.RollbackTrans;
          Msg := E.Message;
          Raise;
        end;
   end;
end;

{ TCalcNewStorage }

function TCalcNewStorage.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
begin
  result := true;
end;

{ TRtcSyncClose }

function TRtcSyncClose.Execute(AGlobal: IdbHelp;
  Params: TftParamList): Boolean;
var
  rs:TZQuery;
  timeStamp:string;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select max(TIME_STAMP) TIME_STAMP from SYS_SYNC_CTRL';
    AGlobal.Open(rs);
    timeStamp := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
  AGlobal.BeginTrans;
  try
    AGlobal.ExecSQL('delete from SYS_SYNC_CTRL where TENANT_ID='+Params.ParambyName('TENANT_ID').AsString+' and SHOP_ID = '''+Params.ParambyName('SHOP_ID').AsString+''' and TABLE_NAME in (''RTC_STK_STOCKORDER'',''RTC_SAL_SALESORDER'',''RTC_PUB_CUSTOMER'') ');
    AGlobal.ExecSQL('insert into SYS_SYNC_CTRL (TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values ('+Params.ParambyName('TENANT_ID').AsString+','''+Params.ParambyName('SHOP_ID').AsString+''',''RTC_STK_STOCKORDER'','+timeStamp+') ');
    AGlobal.ExecSQL('insert into SYS_SYNC_CTRL (TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values ('+Params.ParambyName('TENANT_ID').AsString+','''+Params.ParambyName('SHOP_ID').AsString+''',''RTC_SAL_SALESORDER'','+timeStamp+') ');
    AGlobal.ExecSQL('insert into SYS_SYNC_CTRL (TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values ('+Params.ParambyName('TENANT_ID').AsString+','''+Params.ParambyName('SHOP_ID').AsString+''',''RTC_PUB_CUSTOMER'','+timeStamp+') ');
    AGlobal.CommitTrans;
    result := true;
  except
    on E:Exception do
       begin
         AGlobal.RollbackTrans;
         Msg := E.Message;
         Raise;
       end;
  end;
end;

initialization
  RegisterClass(TCheckAppVersion);
  RegisterClass(TCalcNewStorage);
  RegisterClass(TRtcSyncClose);
finalization
  UnRegisterClass(TCheckAppVersion);
  UnRegisterClass(TCalcNewStorage);
  UnRegisterClass(TRtcSyncClose);
end.
