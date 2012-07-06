unit ObjSvcServiceInfo;

interface
uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset,ObjCommon;
type
  TSvcServiceInfo=class(TZFactory)
  public
    procedure InitClass; override;
    function CheckReck(AGlobal:IdbHelp):boolean;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation

{ TSvcServiceInfo }

function TSvcServiceInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TSvcServiceInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TSvcServiceInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TSvcServiceInfo.CheckReck(AGlobal: IdbHelp): boolean;
begin

end;

procedure TSvcServiceInfo.InitClass;
var
  Str: string;
begin
  inherited;
  KeyFields:='SRVR_ID;TENANT_ID';

  Str := 'select TENANT_ID,SRVR_ID,SALES_ID,GODS_ID,GODS_NAME,SERIAL_NO,CLIENT_ID,CLIENT_CODE,LINKMAN,TELEPHONE,ADDRESS,RECV_CLASS,'+
  'PROB_DESC,RECV_DATE,RECV_USER,SRVR_CLASS,SRVR_USER,SRVR_DATE,SRVR_DESC,FEE_FLAG,FEE_MNY,SATI_DEGR,CREA_DATE,CREA_USER,COMM '+
  'from SVC_SERVICE_INFO where COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and SRVR_ID=:SRVR_ID ';
  SelectSQL.Text := Str;
  IsSQLUpdate := True;
  Str := 'insert into SVC_SERVICE_INFO(TENANT_ID,SRVR_ID,SALES_ID,GODS_ID,GODS_NAME,SERIAL_NO,CLIENT_ID,CLIENT_CODE,LINKMAN,TELEPHONE,ADDRESS,'+
  'RECV_CLASS,PROB_DESC,RECV_DATE,RECV_USER,SRVR_CLASS,SRVR_USER,SRVR_DATE,SRVR_DESC,FEE_FLAG,FEE_MNY,SATI_DEGR,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '+
  'values(:TENANT_ID,:SRVR_ID,:SALES_ID,:GODS_ID,:GODS_NAME,:SERIAL_NO,:CLIENT_ID,:CLIENT_CODE,:LINKMAN,:TELEPHONE,:ADDRESS,:RECV_CLASS,:PROB_DESC,'+
  ':RECV_DATE,:RECV_USER,:SRVR_CLASS,:SRVR_USER,:SRVR_DATE,:SRVR_DESC,:FEE_FLAG,:FEE_MNY,:SATI_DEGR,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Text := Str;

  Str := 'update SVC_SERVICE_INFO set SALES_ID=:SALES_ID,GODS_ID=:GODS_ID,GODS_NAME=:GODS_NAME,SERIAL_NO=:SERIAL_NO,CLIENT_ID=:CLIENT_ID,'+
  'CLIENT_CODE=:CLIENT_CODE,LINKMAN=:LINKMAN,TELEPHONE=:TELEPHONE,ADDRESS=:ADDRESS,RECV_CLASS=:RECV_CLASS,RECV_DATE=:RECV_DATE,SRVR_DESC=:SRVR_DESC,'+
  'RECV_USER=:RECV_USER,SRVR_CLASS=:SRVR_CLASS,SRVR_USER=:SRVR_USER,SRVR_DATE=:SRVR_DATE,PROB_DESC=:PROB_DESC,FEE_FLAG=:FEE_FLAG,FEE_MNY=:FEE_MNY,'+
  'SATI_DEGR=:SATI_DEGR,CREA_DATE=:CREA_DATE,CREA_USER=:CREA_USER,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where COMM not in (''02'',''12'') and TENANT_ID=:OLD_TENANT_ID and SRVR_ID=:OLD_SRVR_ID ';
  UpdateSQL.Text := Str;

  Str := 'delete from SVC_SERVICE_INFO where COMM not in (''02'',''12'') and TENANT_ID=:OLD_TENANT_ID and SRVR_ID=:OLD_SRVR_ID ';
  DeleteSQL.Text := Str;
end;

initialization
  RegisterClass(TSvcServiceInfo);
finalization
  UnRegisterClass(TSvcServiceInfo);

end.
 