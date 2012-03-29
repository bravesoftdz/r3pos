unit ObjCostCalc;

interface

uses Dialogs,SysUtils,zBase,Classes,DB,ZIntf,ZDataset;

type
  TCheckCostCalc = class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

implementation

uses DateUtils;

function TCheckCostCalc.Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;
  var rs : TZQuery;
  var localDBKey : string;
  var remoteDBKey : string;
  var remoteTime : string;
  var curTime : string;
  var tenantId : integer;
begin
  result := true;  
  if Params.FindParam('localDBKey') <> nil then
    localDBKey := Params.FindParam('localDBKey').AsString;
  if Params.FindParam('tenantId') <> nil then
    tenantId := Params.FindParam('tenantId').AsInteger
  else
    begin
      Msg := '��ȡ��ǰ��ҵΪ�գ����Ժ�����...';
      Exit;
    end;

  rs := TZQuery.Create(nil);
  AGlobal.BeginTrans;
  try
    rs.Close;
    case AGlobal.iDbType of
      0:rs.SQL.Text := 'select VALUE from SYS_DEFINE with(UPDLOCK) where DEFINE=''RCK_ID'' and TENANT_ID=' + inttostr(tenantId);
      1:rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''RCK_ID'' and TENANT_ID=' + inttostr(tenantId) + ' for update';
      4:rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''RCK_ID'' and TENANT_ID=' + inttostr(tenantId) + ' for update with rs';
    else
      rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''RCK_ID'' and TENANT_ID=' + inttostr(tenantId);
    end;
    AGlobal.Open(rs);
    if not rs.IsEmpty then
      begin
        remoteDBKey := rs.Fields[0].AsString;// ����ִ�гɱ������DBKEY
        if (localDBKey <> remoteDBKey) then
          begin
            rs.Close;
            rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE=''RCK_TIME'' and TENANT_ID=' + inttostr(tenantId);// ����ִ�гɱ�����Ŀ�ʼʱ��
            AGlobal.Open(rs);
            if not rs.IsEmpty then
              begin
                remoteTime := rs.Fields[0].AsString;
                curTime := formatDatetime('YYYYMMDDHHNNSS', IncMinute(now(), -30));
                if curTime < remoteTime then
                  begin
                    Msg := '����ִ�гɱ����㣬���Ժ�����...';
                    AGlobal.RollbackTrans;
                    Exit;
                  end;
              end;
          end;
        AGlobal.ExecSQL('delete from SYS_DEFINE where TENANT_ID = ' + inttostr(tenantId) + ' and DEFINE in (''RCK_ID'',''RCK_TIME'') ');
      end;
 	  // �������ڳɱ������ʾ
    AGlobal.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values ('+inttostr(tenantId)+',''RCK_ID'','''+ localDBKey +''',0,''00'',0)');
	  AGlobal.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values ('+inttostr(tenantId)+',''RCK_TIME'','''+ formatDatetime('YYYYMMDDHHNNSS', now()) +''',0,''00'',0)');
    AGlobal.CommitTrans;
  except
    AGlobal.RollbackTrans;
    Msg := '�ɱ��������쳣�����Ժ�����...';
  end;
  rs.Free;
end;
      
initialization
  RegisterClass(TCheckCostCalc);
finalization
  UnRegisterClass(TCheckCostCalc);

end.
