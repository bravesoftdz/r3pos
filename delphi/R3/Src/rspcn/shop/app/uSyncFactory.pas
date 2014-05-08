unit uSyncFactory;

interface

uses
  Windows, Messages, Forms, SysUtils, Classes, ZDataSet, ZdbFactory, ZBase,
  ObjCommon, ZLogFile, Dialogs, DB, uFnUtil, math, Registry, Nb30, WinSock,
  ActiveX, RzStatus;

const
  MSC_SET_MAX=WM_USER+1;
  MSC_SET_POSITION=WM_USER+2;
  MSC_SET_CAPTION=WM_USER+3;
  MSC_SET_CLOSE=WM_USER+4;

  MAX_SYNC_RECORD_COUNT = 500;

type
  PSynTableInfo=^TSynTableInfo;
  TSynTableInfo=record
    tbName:string;//����
    tbTitle:string;//˵��
    keyFields:string;//�ؼ��ֶ�
    tableFields:string;//ͬ���ֶ�
    selectLocalSQL:string;//����openSQL�������ϴ�����SQL��һ�µ����
    selectRemoteSQL:string;//�����openSQL�������ϴ�����SQL��һ�µ����
    selectSQL:string;//Ĭ��openSQL
    whereStr:string;//where����
    synFlag:integer;
    keyFlag:integer; //0�ǰ���ṹ�ؼ��� 1�ǰ�ҵ��ؼ���
    syncTenantId:string;//ʱ�������TENANT_ID
    syncShopId:string;//ʱ�������SHOP_ID
    isSyncUp:string;//�Ƿ��ϴ�
    isSyncDown:string;//�Ƿ�����
    isUpdComm:string;//�ϴ����Ƿ���±���comm
  end;

  TSyncFactory=class
  protected
    _Start:Int64;
    LoginStart:Int64;
    FList:TList;
    FStoped: boolean;
    FProHandle:Hwnd;
    FProTitle:string;
    FinishIndex:integer;
    procedure SetTicket;
    function  GetTicket:Int64;
    procedure ClearSyncList;
    procedure ReadTimeStamp;
    function  GetFactoryName(node:PSynTableInfo):string;
    function  GetTableFields(tbName:string;alias:string=''):string;
    procedure SetStoped(const Value: boolean);
    procedure SetProHandle(const Value: Hwnd);
    procedure SetProTitle(const Value: string);
    procedure SetProCaption;
    procedure SetProMax(max:integer);
    procedure SetProPosition(position:integer);
  private
    ThreadLock:TRTLCriticalSection;
    CloseAccDate:integer;
    LoginSyncDate:integer;
    LastLoginSyncDate,LastLogoutSyncDate:integer;
    FLoginId: string;
    Ftimered: boolean;
    FtimerTerminted: boolean;
    function  CheckRemoteData(AppHandle:HWnd):integer;//0:δ��ԭ 1:�ļ���ԭ 2:����˻�ԭ
    procedure BackUpDBFile;
    procedure InitTenant;
    // 0:Ĭ��ͬ�� 1:ע��ͬ�� 2:����ͬ�� 3:�ָ�ͬ��
    procedure InitSyncRelationList(SyncType:integer=0);
    procedure InitSyncBasicList(SyncType:integer=0);
    procedure SyncList;

    procedure SyncBizData(SyncFlag:integer=0;BeginDate:string='');
    procedure BeforeSyncBiz(DataSet:TZQuery;FieldName:string;SyncFlag:integer);
    procedure SyncStockOrder(SyncFlag:integer=0;BeginDate:string='');// 0:�ϴ� 1:����
    procedure SyncSalesOrder(SyncFlag:integer=0;BeginDate:string='');
    procedure SyncChangeOrder(SyncFlag:integer=0;BeginDate:string='');
    procedure SyncRckDays(SyncFlag:integer=0;BeginDate:string='');
    procedure SyncStorage;
    procedure GetCloseAccDate;
    function  CheckNeedLoginSync:boolean;
    function  CheckNeedLoginSyncBizData:boolean;
    // ���غ�����
    procedure SyncUpperAmount;
    // ������ݱ���
    function  CheckBackUpDBFile(PHWnd:THandle):boolean;
    // ��½��־
    procedure AddLoginLog;
    procedure AddLogoutLog;
    procedure SetLoginId(const Value: string);
    procedure Settimered(const Value: boolean);
    procedure SettimerTerminted(const Value: boolean);
    function  Gettimered: boolean;
  public
    constructor Create;
    destructor  Destroy;override;
    // ����ͬ��
    procedure SyncSingleTable(n:PSynTableInfo;timeStampNoChg:integer=1;SaveCtrl:boolean=true);
    // 0:Ĭ��ͬ�� 1:ע��ͬ�� 2:����ͬ�� 3:�ָ�ͬ��
    procedure SyncBasic(SyncType:integer=0);
    // ����ļ��Ƿ�����Ч�������ļ�
    function  CheckValidDBFile(src:string):boolean;
    // ��¼ʱͬ��
    procedure LoginSync(PHWnd:THandle);
    // �˳�ʱͬ��
    procedure LogoutSync(PHWnd:THandle);
    // ���ݻָ�ʱͬ��
    procedure RecoverySync(PHWnd:THandle;BeginDate:string='');
    // ע��ʱͬ��
    procedure RegisterSync(PHWnd:THandle);
    // �����潻�����ʱ��ͬ��
    procedure CloseForDaySync(PHWnd:THandle);
    // ���ѻָ�ʱ����
    procedure RecoveryClose(CloseDate:string);
    // ���ݿ�����
    function  DBLocked:boolean;
    function  SyncLockCheck(PHWnd:THandle;tip:string=''):boolean;
    function  SyncLockDb:boolean;
    //ͬ������
    procedure TimerSync;
    procedure TimerSyncSales;
    procedure TimerSyncStock;
    procedure TimerSyncChange;
    procedure TimerSyncStorage;
    procedure TimerSyncMessage;

    function  GetSynTimeStamp(tenantId,tbName:string;SHOP_ID:string='#'):int64;
    procedure SetSynTimeStamp(tenantId,tbName:string;TimeStamp:int64;SHOP_ID:string='#');
    property  Stoped:boolean read FStoped write SetStoped;
    property  ProHandle:Hwnd read FProHandle write SetProHandle;
    property  ProTitle:string read FProTitle write SetProTitle;
    property  LoginId:string read FLoginId write SetLoginId;

    property  timered:boolean read Gettimered write Settimered;
    property  timerTerminted:boolean read FtimerTerminted write SettimerTerminted;
  end;

  TTimeSyncThread=class(TThread)
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;
  end;

var SyncFactory:TSyncFactory;

implementation

uses udllDsUtil,udllGlobal,uTokenFactory,udataFactory,IniFiles,ufrmSyncData,
     uRspSyncFactory,uRightsFactory,dllApi,ufrmSysDefine,uRtcSyncFactory,
     ufrmStocksCalc,ufrmSelectRecType,ufrmUnLockGuide,uCommand,ufrmHintMsg,
     uPlayerFactory,udllShopUtil,uXsmFactory;

constructor TSyncFactory.Create;
begin
  InitializeCriticalSection(ThreadLock);
  ftimered := false;
  timerTerminted := false;
  CloseAccDate := -1;
  LoginSyncDate := 0;
  LastLoginSyncDate := 0;
  LastLogoutSyncDate := 0;
  FList := TList.Create;
end;

destructor TSyncFactory.Destroy;
var i:integer;
begin
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Free;
  ftimered := false;
  DeleteCriticalSection(ThreadLock);
  inherited;
end;

function TSyncFactory.GetFactoryName(node: PSynTableInfo): string;
begin
  result := 'TSyncSingleTableV60';
end;

function TSyncFactory.GetTicket:int64;
begin
  result := GetTickCount - _Start;
end;

procedure TSyncFactory.SetTicket;
begin
  _Start := GetTickCount;
end;

procedure TSyncFactory.ReadTimeStamp;
var Params:TftParamList;
begin
  if token.tenantId='' then Exit;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    if dataFactory.iDbType <> 5 then
      begin
        dataFactory.sqlite.ExecProc('TGetSyncTimeStamp',Params);
      end;
    dataFactory.ExecProc('TGetSyncTimeStamp',Params);
  finally
    Params.Free;
  end;
end;

function TSyncFactory.GetSynTimeStamp(tenantId,tbName:string;SHOP_ID:string='#'):int64;
var rs:TZQuery;
begin
  if SHOP_ID='' then SHOP_ID:='#';
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TIME_STAMP from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
    rs.ParambyName('TENANT_ID').AsInteger := strtoint(tenantId);
    rs.ParamByName('SHOP_ID').AsString := SHOP_ID;
    rs.ParamByName('TABLE_NAME').AsString := tbName;
    dataFactory.sqlite.Open(rs);
    if rs.IsEmpty then result := 0 else result := rs.Fields[0].Value;
  finally
    rs.Free;
  end;
end;

procedure TSyncFactory.SetSynTimeStamp(tenantId,tbName:string;TimeStamp:int64;SHOP_ID:string='#');
var
  r:integer;
  rs:TZQuery;
begin
  if SHOP_ID='' then SHOP_ID:='#';

  r := dataFactory.sqlite.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+tenantId+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+'''');
  if r=0 then
     dataFactory.sqlite.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values('+tenantId+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');

  //���·����ʱ���
  rs := TZQuery.Create(nil);
  try
    r := dataFactory.remote.ExecSQL('update SYS_SYNC_CTRL set TIME_STAMP='+inttostr(TimeStamp)+' where TENANT_ID='+token.tenantId+' and SHOP_ID='''+SHOP_ID+''' and TABLE_NAME='''+tbName+''' and TIME_STAMP<'+inttostr(TimeStamp));
    if r=0 then
       begin
         rs.SQL.Text := 'select 1 from SYS_SYNC_CTRL where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TABLE_NAME=:TABLE_NAME';
         rs.Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
         rs.Params.ParamByName('SHOP_ID').AsString := SHOP_ID;
         rs.Params.ParamByName('TABLE_NAME').AsString := tbName;
         try
           TZQuery(rs).Data := dbHelp.OpenSQL(TZQuery(rs).SQL.Text,TftParamList.Encode(TZQuery(rs).Params));
         except
           Raise Exception.Create(StrPas(dbHelp.getLastError));
         end;
         if rs.IsEmpty then
            dataFactory.remote.ExecSQL('insert into SYS_SYNC_CTRL(TENANT_ID,SHOP_ID,TABLE_NAME,TIME_STAMP) values ('+token.tenantId+','''+SHOP_ID+''','''+tbName+''','+inttostr(TimeStamp)+')');
       end;
  finally
    rs.Free;
  end;
end;

function TSyncFactory.GetTableFields(tbName:string;alias:string=''):string;
var
  ls:TZQuery;
  i:integer;
  selectFields:string;
begin
  ls := TZQuery.Create(nil);
  try
    ls.SQL.Text := 'select * from '+tbName+' limit 1';
    dataFactory.sqlite.Open(ls);
    for i:=0 to ls.FieldList.Count - 1 do
      begin
        if selectFields<>'' then selectFields := selectFields + ',';
        if alias = '' then
           selectFields := selectFields + ls.FieldList.Fields[i].FieldName
        else
           selectFields := selectFields + alias + '.' + ls.FieldList.Fields[i].FieldName
      end;
    result := selectFields;
  finally
    ls.Free;
  end;
end;

procedure TSyncFactory.SyncSingleTable(n:PSynTableInfo;timeStampNoChg:integer=1;SaveCtrl:boolean=true);
  procedure UploadSingleTable(rs_l:TZQuery;ZClassName:string;n:PSynTableInfo;Params:TftParamList);
  var
    i:integer;
    ss:TZQuery;
    tmpObj:TRecord_;
  begin
    ss := TZQuery.Create(nil);
    try
      if rs_l.IsEmpty then Exit;

      SetTicket;

      if rs_l.RecordCount <= MAX_SYNC_RECORD_COUNT then
         begin
           ss.SyncDelta := rs_l.SyncDelta;
           if not ss.IsEmpty then
              begin
                try
                  dataFactory.remote.UpdateBatch(TZQuery(ss).Delta,ZClassName,TftParamList.Encode(Params));
                except
                  Raise Exception.Create(StrPas(dbHelp.getLastError));
                end;
              end;
         end
      else //�ְ�����
         begin
           i := 0;
           rs_l.First;
           tmpObj := TRecord_.Create;
           try
             ss.FieldDefs.Assign(rs_l.FieldDefs);
             ss.CreateDataSet;
             while not rs_l.Eof do
               begin
                 ss.Append;
                 tmpObj.ReadFromDataSet(rs_l);
                 tmpObj.WriteToDataSet(ss);
                 inc(i);
                 rs_l.Next;
                 if (i >= MAX_SYNC_RECORD_COUNT) or (rs_l.Eof) then
                    begin
                      try
                        dataFactory.remote.UpdateBatch(TZQuery(ss).Delta,ZClassName,TftParamList.Encode(Params));
                      except
                        Raise Exception.Create(StrPas(dbHelp.getLastError));
                      end;
                      LogFile.AddLogFile(0,'�ϴ�<'+n^.tbName+'><'+n^.syncTenantId+' '+n^.syncShopId+'>�����ύ��¼��:'+inttostr(ss.RecordCount));
                      i := 0;
                      ss.EmptyDataSet;
                    end;
               end;
           finally
             tmpObj.Free;
           end;
        end;

      if n^.isUpdComm <> '0' then
         begin
           rs_l.Delete;
           dataFactory.sqlite.UpdateBatch(rs_l,ZClassName,Params);
         end;

      LogFile.AddLogFile(0,'�ϴ�<'+n^.tbName+'><'+n^.syncTenantId+' '+n^.syncShopId+'>����ʱ��:'+inttostr(GetTicket));
    finally
      ss.Free;
    end;
  end;

  procedure DownloadSingleTable(rs_r:TZQuery;ZClassName:string;n:PSynTableInfo;Params:TftParamList);
  var
    i:integer;
    ss:TZQuery;
    tmpObj:TRecord_;
  begin
    ss := TZQuery.Create(nil);
    try
      if rs_r.IsEmpty then Exit;

      SetTicket;

      if rs_r.RecordCount <= MAX_SYNC_RECORD_COUNT then
         begin
           ss.SyncDelta := rs_r.SyncDelta;
           if not ss.IsEmpty then
              dataFactory.sqlite.UpdateBatch(ss,ZClassName,Params);
         end
     else //�ְ�����
         begin
           i := 0;
           rs_r.First;
           tmpObj := TRecord_.Create;
           try
             ss.FieldDefs.Assign(rs_r.FieldDefs);
             ss.CreateDataSet;
             while not rs_r.Eof do
               begin
                 ss.Append;
                 tmpObj.ReadFromDataSet(rs_r);
                 tmpObj.WriteToDataSet(ss);
                 inc(i);
                 rs_r.Next;
                 if (i >= MAX_SYNC_RECORD_COUNT) or (rs_r.Eof) then
                    begin
                      dataFactory.sqlite.UpdateBatch(ss,ZClassName,Params);
                      LogFile.AddLogFile(0,'����<'+n^.tbName+'><'+n^.syncTenantId+' '+n^.syncShopId+'>�����ύ��¼��:'+inttostr(ss.RecordCount));
                      i := 0;
                      ss.EmptyDataSet;
                    end;
               end;
           finally
             tmpObj.Free;
           end;
        end;

      LogFile.AddLogFile(0,'����<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>����ʱ��:'+inttostr(GetTicket));
    finally
      ss.Free;
    end;
  end;
var
  SFVersion:string;
  rs_l,rs_r:TZQuery;
  LCLVersion:boolean;
  ZClassName:string;
  openSQL:string;
  Params:TftParamList;
  MaxTimeStamp,LastTimeStamp:int64;
begin
  if (n^.isSyncUp <> '1') and (n^.isSyncDown <> '1') then Exit;

  SFVersion := dllGlobal.GetSFVersion;
  LCLVersion := (SFVersion = '.LCL');

  if trim(n^.syncTenantId) = '' then n^.syncTenantId := token.tenantId;
  if trim(n^.syncShopId) = '' then n^.syncShopId := '#';

  ZClassName := GetFactoryName(n);
  LastTimeStamp := GetSynTimeStamp(n^.syncTenantId,n^.tbName,n^.syncShopId);
  MaxTimeStamp := LastTimeStamp;

  rs_l := TZQuery.Create(nil);
  rs_r := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    rs_l.Close;
    rs_r.Close;

    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('KEY_FLAG').AsInteger := n^.keyFlag;
    Params.ParamByName('TABLE_NAME').AsString := n^.tbName;
    Params.ParamByName('KEY_FIELDS').AsString := n^.keyFields;
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('LAST_TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := timeStampNoChg;
    Params.ParamByName('WHERE_STR').AsString := n^.whereStr;
    if trim(n^.tableFields) <> '' then
       Params.ParamByName('TABLE_FIELDS').AsString := n^.tableFields
    else
       Params.ParamByName('TABLE_FIELDS').AsString := GetTableFields(n^.tbName);

    if n^.isSyncUp = '1' then
       begin
         LogFile.AddLogFile(0,'��ʼ�ϴ�<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>�ϴ�ʱ��:'+inttostr(LastTimeStamp));
         Params.ParamByName('SYN_COMM').AsBoolean := true;
         Params.ParamByName('Transed').AsBoolean := false;
         SetTicket;

         if (trim(n^.selectSQL) = '') and (trim(n^.selectLocalSQL) = '') then
            dataFactory.sqlite.Open(rs_l,ZClassName,Params)
         else
           begin
             if trim(n^.selectLocalSQL) <> '' then
                openSQL := n^.selectLocalSQL
             else
                openSQL := n^.selectSQL;
             rs_l.SQL.Text := openSQL;
             rs_l.Params := Params;
             dataFactory.sqlite.Open(rs_l);
           end;

         LogFile.AddLogFile(0,'�ϴ�<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(rs_l.RecordCount));

         if not rs_l.IsEmpty then
            begin
              rs_l.Last;
              if StrtoInt64(rs_l.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
                 MaxTimeStamp := StrtoInt64(rs_l.FieldByName('TIME_STAMP').AsString);
            end;
       end;

    if n^.isSyncDown = '1' then
       begin
         LogFile.AddLogFile(0,'��ʼ����<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>�ϴ�ʱ��:'+inttostr(LastTimeStamp));
         Params.ParamByName('SYN_COMM').AsBoolean := false;
         Params.ParamByName('Transed').AsBoolean := true;
         SetTicket;

         if (trim(n^.selectSQL) = '') and (trim(n^.selectRemoteSQL) = '') then
           begin
             try
               TZQuery(rs_r).Data := dbHelp.OpenNS(ZClassName,TftParamList.Encode(Params));
             except
               Raise Exception.Create(StrPas(dbHelp.getLastError));
             end;
           end
         else
           begin
             if trim(n^.selectRemoteSQL) <> '' then
                openSQL := n^.selectRemoteSQL
             else
                openSQL := n^.selectSQL;
             rs_r.SQL.Text := openSQL;
             rs_r.Params := Params;
             try
               TZQuery(rs_r).Data := dbHelp.OpenSQL(TZQuery(rs_r).SQL.Text,TftParamList.Encode(TZQuery(rs_r).Params));
             except
               Raise Exception.Create(StrPas(dbHelp.getLastError));
             end;
           end;

         LogFile.AddLogFile(0,'����<'+n^.tbName+'><'+n^.syncTenantId+':'+n^.syncShopId+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(rs_r.RecordCount));

         if not rs_r.IsEmpty then
            begin
              rs_r.Last;
              if StrtoInt64(rs_r.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
                 MaxTimeStamp := StrtoInt64(rs_r.FieldByName('TIME_STAMP').AsString);
            end;
       end;

     if LCLVersion then
        begin
          if n^.isSyncUp = '1' then
             begin
               UploadSingleTable(rs_l,ZClassName,n,Params);
               SetProPosition(FinishIndex * 100 + 50);
             end;
          if n^.isSyncDown = '1' then
             begin
               DownloadSingleTable(rs_r,ZClassName,n,Params);
               SetProPosition(FinishIndex * 100 + 100);
             end;
        end
     else
        begin
          if n^.isSyncDown = '1' then
             begin
               DownloadSingleTable(rs_r,ZClassName,n,Params);
               SetProPosition(FinishIndex * 100 + 50);
             end;
          if n^.isSyncUp = '1' then
             begin
               UploadSingleTable(rs_l,ZClassName,n,Params);
               SetProPosition(FinishIndex * 100 + 100);
             end;
        end;

    if SaveCtrl and (MaxTimeStamp > LastTimeStamp) then
       SetSynTimeStamp(n^.syncTenantId,n^.tbName,MaxTimeStamp,n^.syncShopId);
  finally
    Params.Free;
    rs_l.Free;
    rs_r.Free;
  end;
end;

procedure TSyncFactory.SetStoped(const Value: boolean);
begin
  FStoped := Value;
end;

procedure TSyncFactory.SyncList;
var i:integer;
begin
  SetProMax(FList.Count * 100);
  FinishIndex := 0;
  SetProPosition(0);
  for i:=0 to FList.Count -1 do
  begin
    case PSynTableInfo(FList[i])^.synFlag of
    0,1,2,3,4,10,20,21,22,23,29,33:
      begin
        ProTitle := '<'+PSynTableInfo(FList[i])^.tbtitle+'>...';
        SyncSingleTable(FList[i]);
        inc(FinishIndex);
        SetProPosition(FinishIndex * 100);
      end;
    end;
  end;
end;

procedure TSyncFactory.SyncBasic(SyncType:integer=0);
begin
  try
    InitSyncRelationList(SyncType);
    SyncList;
    dllGlobal.Refresh('CA_RELATIONS');

    InitSyncBasicList(SyncType);
    SyncList;

    SyncUpperAmount;
  finally
    ReadTimeStamp;
  end
end;

procedure TSyncFactory.ClearSyncList;
var i:integer;
begin
  for i:=0 to FList.Count -1 do Dispose(FList[i]);
  FList.Clear;
end;

procedure TSyncFactory.InitSyncRelationList(SyncType:integer=0);
var n:PSynTableInfo;
begin
  ClearSyncList;

  new(n);
  n^.tbname := 'CA_RELATIONS';
  n^.keyFields := 'RELATION_ID;TENANT_ID;RELATI_ID';
  n^.whereStr := '(TENANT_ID = :TENANT_ID or RELATI_ID = :TENANT_ID) and TIME_STAMP > :TIME_STAMP';
  n^.synFlag := 1;
  n^.keyFlag := 1;
  n^.tbtitle := '��Ӧ��ϵ';
  if dllGlobal.AuthMode = 1 then n^.isSyncUp := '1';
  n^.isSyncDown := '1';
  FList.Add(n);

  new(n);
  n^.tbname := 'CA_RELATION';
  n^.keyFields := 'TENANT_ID;RELATION_ID';
  n^.selectRemoteSQL :=
    ' select * from ( '+
    ' select i.RELATION_ID,i.TENANT_ID,i.RELATION_NAME,i.RELATION_SPELL,i.REMARK,i.CREA_DATE,i.COMM, '+
    ' case when i.TIME_STAMP > r.TIME_STAMP then i.TIME_STAMP else r.TIME_STAMP end TIME_STAMP '+
    ' from CA_RELATION i,'+
    ' ( '+
    '  select j.TENANT_ID,s.TIME_STAMP from CA_RELATION j,CA_RELATIONS s '+
    '  where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID '+
    ' ) r where i.TENANT_ID=r.TENANT_ID and (i.TIME_STAMP>:TIME_STAMP or r.TIME_STAMP>:TIME_STAMP) '+
    ' union all '+
    ' select i.RELATION_ID,i.TENANT_ID,i.RELATION_NAME,i.RELATION_SPELL,i.REMARK,i.CREA_DATE,i.COMM,i.TIME_STAMP '+
    ' from CA_RELATION i where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+
    ' ) t order by TIME_STAMP asc ';
  n^.synFlag := 2;
  n^.keyFlag := 0;
  n^.tbtitle := '��Ӧ��';
  if dllGlobal.AuthMode = 1 then n^.isSyncUp := '1';
  n^.isSyncDown := '1';
  n^.isUpdComm := '0';
  FList.Add(n);
end;

// 0:Ĭ��ͬ�� 1:ע��ͬ�� 2:����ͬ�� 3:�ָ�ͬ��
procedure TSyncFactory.InitSyncBasicList(SyncType:integer=0);
  procedure InitSyncBasicUpAndDown(var n:PSynTableInfo);
  begin
    if SyncType = 1 then
       begin
         n^.isSyncDown := '1';
       end
    else if SyncType = 2 then
       begin
         if dllGlobal.GetSFVersion = '.LCL' then
            n^.isSyncUp := '1'
         else
            n^.isSyncDown := '1'
       end
    else if SyncType = 3 then
       begin
         n^.isSyncDown := '1';
       end
    else
       begin
         n^.isSyncUp := '1';
         n^.isSyncDown := '1';
       end
  end;

  procedure InitSyncRelationUpAndDown(var n:PSynTableInfo;tenantId:string);
  begin
    if SyncType = 1 then
       begin
         n^.isSyncDown := '1';
       end
    else if SyncType = 2 then
       begin
         if dllGlobal.GetSFVersion = '.LCL' then
            begin
              if tenantId = token.tenantId then
                 n^.isSyncUp := '1'
              else
                 n^.isSyncDown := '1'
            end
         else
            begin
              n^.isSyncDown := '1'
            end;
       end
    else if SyncType = 3 then
       begin
         n^.isSyncDown := '1';
       end
    else
       begin
         n^.isSyncUp := '1';
         n^.isSyncDown := '1';
       end
  end;

  procedure InitList0;
  var
    rs:TZQuery;
    n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'CA_SHOP_INFO';
    n^.keyFields := 'TENANT_ID;SHOP_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '�ŵ�����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_DEPT_INFO';
    n^.keyFields := 'TENANT_ID;DEPT_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '��������';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_DUTY_INFO';
    n^.keyFields := 'TENANT_ID;DUTY_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := 'ְ������';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_ROLE_INFO';
    n^.keyFields := 'TENANT_ID;ROLE_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '��ɫ����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_USERS';
    n^.keyFields := 'TENANT_ID;USER_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '�û�����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_RIGHTS';
    n^.keyFields := 'TENANT_ID;MODU_ID;ROLE_ID;ROLE_TYPE';
    n^.synFlag := 0;
    n^.keyFlag := 1;
    n^.tbtitle := '����Ȩ��';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_PRICEGRADE';
    n^.keyFields := 'TENANT_ID;PRICE_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '�ͻ��ȼ�';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
    if rs.Locate('RELATION_ID',1000006,[]) then
       begin
         new(n);
         n^.tbname := 'PUB_PRICEGRADE';
         n^.keyFields := 'TENANT_ID;PRICE_ID';
         n^.synFlag := 0;
         n^.keyFlag := 0;
         n^.tbtitle := '�ͻ��ȼ�';
         n^.whereStr := 'TENANT_ID='+rs.FieldByName('P_TENANT_ID').AsString+' and TIME_STAMP>:TIME_STAMP';
         n^.syncTenantId := rs.FieldByName('P_TENANT_ID').AsString;
         n^.isSyncDown := '1';
         FList.Add(n);

         new(n);
         n^.tbname := 'PUB_UNION_INFO';
         n^.keyFields := 'TENANT_ID;UNION_ID';
         n^.synFlag := 0;
         n^.keyFlag := 0;
         n^.tbtitle := '���˵���';
         n^.whereStr := 'UNION_ID in (select PRICE_ID from PUB_PRICEGRADE where TENANT_ID='+rs.FieldByName('P_TENANT_ID').AsString+') and TIME_STAMP>:TIME_STAMP';
         n^.syncTenantId := rs.FieldByName('P_TENANT_ID').AsString;
         n^.isSyncDown := '1';
         FList.Add(n);

         if dllGlobal.GetSFVersion = '.LCL' then
            begin
              new(n);
              n^.tbname := 'PUB_UNION_INDEX';
              n^.keyFields := 'TENANT_ID;UNION_ID;INDEX_ID';
              n^.keyFlag := 0;
              n^.synFlag := 0;
              n^.tbtitle := '����ָ��';
              n^.whereStr := 'UNION_ID in (select PRICE_ID from PUB_PRICEGRADE where TENANT_ID='+rs.FieldByName('P_TENANT_ID').AsString+') and TIME_STAMP>:TIME_STAMP';
              n^.syncTenantId := rs.FieldByName('P_TENANT_ID').AsString;
              n^.isSyncDown := '1';
              FList.Add(n);
            end;
      end;

    new(n);
    n^.tbname := 'PUB_CLIENTINFO';
    n^.keyFields := 'TENANT_ID;CLIENT_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '�ͻ�����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CUSTOMER';
    n^.keyFields := 'TENANT_ID;CUST_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '��Ա����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_CUSTOMER_EXT';
    n^.keyFields := 'TENANT_ID;UNION_ID;CUST_ID;INDEX_ID';
    n^.synFlag := 0;
    n^.keyFlag := 1;
    n^.tbtitle := '��Ա����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_GOODSINFOEXT';
    n^.keyFields := 'TENANT_ID;GODS_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '���½���';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    new(n);
    n^.tbname := 'CA_LOGIN_INFO';
    n^.keyFields := 'TENANT_ID;LOGIN_ID';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.tbtitle := '��¼��־';
    if SyncType in [0,2] then n^.isSyncUp := '1';
    FList.Add(n);
  end;

  procedure InitList00;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_GOODSPRICE';
    n^.keyFields := 'TENANT_ID;GODS_ID;SHOP_ID;PRICE_ID';
    if token.shopId = (token.tenantId + '0001') then
       n^.whereStr := 'TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP'
    else
       n^.whereStr := 'TENANT_ID=:TENANT_ID and (SHOP_ID=:SHOP_ID or SHOP_ID='''+token.tenantId+'0001'') and TIME_STAMP>:TIME_STAMP';
    n^.synFlag := 0;
    n^.keyFlag := 0;
    n^.syncShopId := token.shopId;
    n^.tbtitle := '�����ۼ�';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);
  end;

  procedure InitList2(whereStr,syncTenantId:string);
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_CODE_INFO';
    n^.keyFields := 'TENANT_ID;CODE_ID;CODE_TYPE';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '��������';
    InitSyncRelationUpAndDown(n,syncTenantId);
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_GOODSSORT';
    n^.keyFields := 'TENANT_ID;SORT_ID;SORT_TYPE';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '��Ʒ����';
    InitSyncRelationUpAndDown(n,syncTenantId);
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_COLOR_INFO';
    n^.keyFields := 'TENANT_ID;COLOR_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '��ɫ����';
    InitSyncRelationUpAndDown(n,syncTenantId);
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_SIZE_INFO';
    n^.keyFields := 'TENANT_ID;SIZE_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '���뵵��';
    InitSyncRelationUpAndDown(n,syncTenantId);
    FList.Add(n);

    new(n);
    n^.tbname := 'PUB_MEAUNITS';
    n^.keyFields := 'TENANT_ID;UNIT_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 2;
    n^.keyFlag := 0;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '������λ';
    InitSyncRelationUpAndDown(n,syncTenantId);
    // �ϴ����̹�Ӧ����λ
    if (syncTenantId = FY_TENANT_ID) and (dllGlobal.GetSFVersion = '.LCL') then
       begin
         n^.isSyncUp := '1';
       end;
    FList.Add(n);
  end;

  procedure InitList3;
  var rs:TZQuery;
      n:PSynTableInfo;
      str,relationType,pid,cid:string;
  begin
    str :=
      'select b.ROWS_ID,b.TENANT_ID,b.GODS_ID,b.PROPERTY_01,b.PROPERTY_02,b.UNIT_ID,b.BARCODE_TYPE,b.BATCH_NO,b.BARCODE,b.COMM,b.TIME_STAMP '+
      'from   PUB_BARCODE b '+
      'where  TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP and BARCODE_TYPE in (''0'',''1'',''2'') '+
      'order by TIME_STAMP asc';
    new(n);
    n^.tbname := 'PUB_BARCODE';
    n^.keyFields := 'TENANT_ID;GODS_ID;UNIT_ID;PROPERTY_01;PROPERTY_02;BARCODE_TYPE';
    n^.selectSQL := str;
    n^.synFlag := 3;
    n^.keyFlag := 1;
    n^.tbtitle := '�����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
    rs.First;
    while not rs.Eof do
      begin
        relationType := rs.FieldByName('RELATION_TYPE').AsString;

        cid := rs.FieldByName('TENANT_ID').AsString;

        if relationType = '1' then
           pid := token.tenantId
        else
           pid := rs.FieldByName('P_TENANT_ID').AsString;

        str :=
          'select * from ( '+
          'select b.ROWS_ID,b.TENANT_ID,b.GODS_ID,b.PROPERTY_01,b.PROPERTY_02,b.UNIT_ID,b.BARCODE_TYPE,b.BATCH_NO,b.BARCODE,b.COMM, '+
          '       case '+
          '         when b.TIME_STAMP >= c.TIME_STAMP and b.TIME_STAMP >= s.TIME_STAMP then b.TIME_STAMP '+
          '         when c.TIME_STAMP >= b.TIME_STAMP and c.TIME_STAMP >= s.TIME_STAMP then c.TIME_STAMP '+
          '         when s.TIME_STAMP >= b.TIME_STAMP and s.TIME_STAMP >= c.TIME_STAMP then s.TIME_STAMP '+
          '         else b.TIME_STAMP '+
          '       end TIME_STAMP '+
          'from   PUB_BARCODE b,PUB_GOODS_RELATION c,CA_RELATIONS s '+
          'where  b.TENANT_ID = '+ cid +
          '       and c.TENANT_ID = ' + pid +
          '       and c.RELATION_ID = ' + rs.FieldByName('RELATION_ID').AsString +
          '       and b.GODS_ID = c.GODS_ID '+
          '       and s.RELATION_ID = c.RELATION_ID '+
          '       and s.RELATI_ID = ' + token.tenantId +
          '       and b.BARCODE_TYPE in (''0'',''1'',''2'') '+
          '       and (b.TIME_STAMP>:TIME_STAMP or c.TIME_STAMP>:TIME_STAMP or s.TIME_STAMP>:TIME_STAMP) '+
          ') t order by TIME_STAMP asc';
        new(n);
        n^.tbname := 'PUB_BARCODE';
        n^.keyFields := 'TENANT_ID;GODS_ID;UNIT_ID;PROPERTY_01;PROPERTY_02;BARCODE_TYPE';
        n^.selectSQL := str;
        n^.synFlag := 3;
        n^.keyFlag := 1;
        n^.tbtitle := '�����';
        n^.syncTenantId := cid;
        n^.isUpdComm := '0';
        if SyncType = 1 then
           begin
             n^.isSyncDown := '1';
           end
        else if SyncType = 2 then
           begin
             if rs.FieldByName('RELATION_ID').AsInteger = 1000006 then //���̹�Ӧ��ֻ����
                n^.isSyncDown := '1'
             else if rs.FieldByName('RELATION_ID').AsInteger = 1000008 then //���̹�Ӧ��
                begin
                  if dllGlobal.GetSFVersion = '.LCL' then
                     n^.isSyncUp := '1'
                  else
                     n^.isSyncDown := '1';
                end
             else
                begin
                  n^.isSyncUp := '1';
                  n^.isSyncDown := '1';
                end;
           end
        else if SyncType = 3 then
           begin
             n^.isSyncDown := '1';
           end
        else
           begin
             n^.isSyncUp := '1';
             n^.isSyncDown := '1';
           end;
        FList.Add(n);

        rs.Next;
      end;
  end;

  procedure InitList4;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_IC_INFO';
    n^.keyFields := 'TENANT_ID;UNION_ID;CLIENT_ID';
    // ���ݻָ�ʱ�ָ������ֶΣ���ͨͬ��ʱֻͬ�������ֶ�
    if (SyncType = 0) or (SyncType = 2) then
       n^.tableFields := 'CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,PASSWRD,USING_DATE,COMM,TIME_STAMP';
    n^.synFlag := 4;
    n^.keyFlag := 1;
    n^.tbtitle := 'IC����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);
  end;

  procedure InitList10;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'ACC_ACCOUNT_INFO';
    n^.keyFields := 'TENANT_ID;ACCOUNT_ID';
    // ���ݻָ�ʱ�ָ������ֶΣ���ͨͬ��ʱֻͬ�������ֶ�
    if (SyncType = 0) or (SyncType = 2) then
       n^.tableFields := 'TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,COMM,TIME_STAMP';
    n^.synFlag := 10;
    n^.keyFlag := 0;
    n^.tbtitle := '�˻�����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);
  end;

  procedure InitList20;
  var str:string;
      n:PSynTableInfo;
  begin
    str :=
      'select  i.TENANT_ID,i.LOGIN_NAME,i.LICENSE_CODE,i.TENANT_NAME,i.TENANT_TYPE,i.SHORT_TENANT_NAME,i.TENANT_SPELL,i.LEGAL_REPR, '+
      '        i.LINKMAN,i.TELEPHONE,i.FAXES,i.HOMEPAGE,i.ADDRESS,i.QQ,i.MSN,i.POSTALCODE,i.REMARK,i.PASSWRD,i.REGION_ID,i.AUDIT_STATUS,i.CREA_DATE, '+
      '        i.COMM,i.TIME_STAMP '+
      'from    CA_TENANT i '+
      'where   TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+
      'order by TIME_STAMP asc';
    new(n);
    n^.tbname := 'CA_TENANT';
    n^.keyFields := 'TENANT_ID';
    n^.selectSQL := str;
    n^.synFlag := 20;
    n^.keyFlag := 0;
    n^.tbtitle := '��ҵ����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    str :=
      'select * from ( '+
      'select  i.TENANT_ID,i.LOGIN_NAME,i.LICENSE_CODE,i.TENANT_NAME,i.TENANT_TYPE,i.SHORT_TENANT_NAME,i.TENANT_SPELL,i.LEGAL_REPR, '+
      '        i.LINKMAN,i.TELEPHONE,i.FAXES,i.HOMEPAGE,i.ADDRESS,i.QQ,i.MSN,i.POSTALCODE,i.REMARK,i.PASSWRD,i.REGION_ID,i.AUDIT_STATUS,i.CREA_DATE, '+
      '        i.COMM,case when i.TIME_STAMP > r.TIME_STAMP then i.TIME_STAMP else r.TIME_STAMP end TIME_STAMP '+
      'from    CA_TENANT i, '+
      '        ( '+
      '        select j.TENANT_ID as TENANT_ID,s.TIME_STAMP as TIME_STAMP from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID '+
      '        union all '+
      '        select TENANT_ID,TIME_STAMP from CA_RELATIONS s where s.RELATI_ID=:TENANT_ID '+
      '        union all '+
      '        select RELATI_ID as TENANT_ID,TIME_STAMP from CA_RELATIONS s where s.TENANT_ID=:TENANT_ID '+
      '        ) r '+
      'where   i.TENANT_ID=r.TENANT_ID and (i.TIME_STAMP>:TIME_STAMP or r.TIME_STAMP>:TIME_STAMP) '+
      ') t order by TIME_STAMP asc';
    new(n);
    n^.tbname := 'CA_TENANT';
    n^.keyFields := 'TENANT_ID';
    n^.selectSQL := str;
    n^.synFlag := 20;
    n^.keyFlag := 0;
    n^.tbtitle := '��ҵ����';
    n^.syncTenantId := '999999999';
    n^.isSyncDown := '1';
    FList.Add(n);
  end;

  procedure InitList21(whereStr,syncTenantId:string);
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'PUB_GOODS_RELATION';
    n^.keyFields := 'TENANT_ID;GODS_ID;RELATION_ID';
    n^.whereStr := whereStr;
    n^.synFlag := 21;
    n^.keyFlag := 1;
    n^.syncTenantId := syncTenantId;
    n^.tbtitle := '��Ӧ����Ʒ';
    InitSyncRelationUpAndDown(n,syncTenantId);
    FList.Add(n);
  end;

  procedure InitList22;
  var rs:TZQuery;
      n:PSynTableInfo;
      str,relationType,pid,cid:string;
  begin
    str :=
      'select b.GODS_ID,b.TENANT_ID,b.GODS_CODE,b.GODS_NAME,b.GODS_SPELL,b.GODS_TYPE,b.SORT_ID1, '+
      '       b.SORT_ID2,b.SORT_ID3,b.SORT_ID4,b.SORT_ID5,b.SORT_ID6,b.SORT_ID7,b.SORT_ID8,b.SORT_ID9, '+
      '       b.SORT_ID10,b.SORT_ID11,b.SORT_ID12,b.SORT_ID13,b.SORT_ID14,b.SORT_ID15,b.SORT_ID16,b.SORT_ID17, '+
      '       b.SORT_ID18,b.SORT_ID19,b.SORT_ID20,b.BARCODE,b.UNIT_ID,b.CALC_UNITS,b.SMALL_UNITS,b.BIG_UNITS, '+
      '       b.SMALLTO_CALC,b.BIGTO_CALC,b.NEW_INPRICE,b.NEW_OUTPRICE,b.NEW_LOWPRICE,b.USING_PRICE,b.HAS_INTEGRAL, '+
      '       b.USING_BATCH_NO,b.USING_BARTER,b.USING_LOCUS_NO,b.BARTER_INTEGRAL,b.REMARK,b.COMM,b.TIME_STAMP, '+
      '       b.SHORT_GODS_NAME,b.CREA_DATE '+
      'from   PUB_GOODSINFO b where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP '+
      'order by TIME_STAMP asc ';
    new(n);
    n^.tbname := 'PUB_GOODSINFO';
    n^.keyFields := 'TENANT_ID;GODS_ID';
    n^.selectSQL := str;
    n^.synFlag := 22;
    n^.keyFlag := 0;
    n^.tbtitle := '��Ʒ����';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);

    rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
    rs.First;
    while not rs.Eof do
      begin
        relationType := rs.FieldByName('RELATION_TYPE').AsString;

        cid := rs.FieldByName('TENANT_ID').AsString;

        if relationType = '1' then
           pid := token.tenantId
        else
           pid := rs.FieldByName('P_TENANT_ID').AsString;

        str :=
          'select * from ('+
          'select b.GODS_ID,b.TENANT_ID,b.GODS_CODE,b.GODS_NAME,b.GODS_SPELL,b.GODS_TYPE,b.SORT_ID1, '+
          '       b.SORT_ID2,b.SORT_ID3,b.SORT_ID4,b.SORT_ID5,b.SORT_ID6,b.SORT_ID7,b.SORT_ID8,b.SORT_ID9, '+
          '       b.SORT_ID10,b.SORT_ID11,b.SORT_ID12,b.SORT_ID13,b.SORT_ID14,b.SORT_ID15,b.SORT_ID16,b.SORT_ID17, '+
          '       b.SORT_ID18,b.SORT_ID19,b.SORT_ID20,b.BARCODE,b.UNIT_ID,b.CALC_UNITS,b.SMALL_UNITS,b.BIG_UNITS, '+
          '       b.SMALLTO_CALC,b.BIGTO_CALC,b.NEW_INPRICE,b.NEW_OUTPRICE,b.NEW_LOWPRICE,b.USING_PRICE,b.HAS_INTEGRAL, '+
          '       b.USING_BATCH_NO,b.USING_BARTER,b.USING_LOCUS_NO,b.BARTER_INTEGRAL,b.REMARK,b.COMM, '+
          '       case '+
          '         when b.TIME_STAMP >= c.TIME_STAMP and b.TIME_STAMP >= s.TIME_STAMP then b.TIME_STAMP '+
          '         when c.TIME_STAMP >= b.TIME_STAMP and c.TIME_STAMP >= s.TIME_STAMP then c.TIME_STAMP '+
          '         when s.TIME_STAMP >= b.TIME_STAMP and s.TIME_STAMP >= c.TIME_STAMP then s.TIME_STAMP '+
          '         else b.TIME_STAMP '+
          '       end TIME_STAMP, '+
          '       b.SHORT_GODS_NAME,b.CREA_DATE '+
          'from   PUB_GOODSINFO b,PUB_GOODS_RELATION c,CA_RELATIONS s '+
          'where  b.TENANT_ID = '+ cid +
          '       and c.TENANT_ID = ' + pid +
          '       and c.RELATION_ID = ' + rs.FieldByName('RELATION_ID').AsString +
          '       and b.GODS_ID = c.GODS_ID '+
          '       and s.RELATION_ID = c.RELATION_ID '+
          '       and s.RELATI_ID = ' + token.tenantId +
          '       and (b.TIME_STAMP>:TIME_STAMP or c.TIME_STAMP>:TIME_STAMP or s.TIME_STAMP>:TIME_STAMP) '+
          ') t order by TIME_STAMP asc';
        new(n);
        n^.tbname := 'PUB_GOODSINFO';
        n^.keyFields := 'TENANT_ID;GODS_ID';
        n^.selectSQL := str;
        n^.synFlag := 22;
        n^.keyFlag := 0;
        n^.tbtitle := '��Ʒ����';
        n^.syncTenantId := cid;
        n^.isUpdComm := '0';
        if SyncType = 1 then
           begin
             n^.isSyncDown := '1';
           end
        else if SyncType = 2 then
           begin
             if rs.FieldByName('RELATION_ID').AsInteger = 1000006 then //���̹�Ӧ��ֻ����
                n^.isSyncDown := '1'
             else if rs.FieldByName('RELATION_ID').AsInteger = 1000008 then //���̹�Ӧ��
                begin
                  if dllGlobal.GetSFVersion = '.LCL' then
                     n^.isSyncUp := '1'
                  else
                     n^.isSyncDown := '1';
                end
             else
                begin
                  n^.isSyncUp := '1';
                  n^.isSyncDown := '1';
                end;
           end
        else if SyncType = 3 then
           begin
             n^.isSyncDown := '1';
           end
        else
           begin
             n^.isSyncUp := '1';
             n^.isSyncDown := '1';
           end;
        FList.Add(n);

        rs.Next;
      end;
  end;

  procedure InitList23;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'SYS_SEQUENCE';
    n^.keyFields := 'TENANT_ID;SEQU_ID';
    n^.synFlag := 23;
    n^.keyFlag := 0;
    n^.tbtitle := '���кſ��Ʊ�';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);
  end;

  procedure InitList29;
  var n:PSynTableInfo;
  begin
    new(n);
    n^.tbname := 'SYS_DEFINE';
    n^.keyFields := 'TENANT_ID;DEFINE';
    n^.synFlag := 29;
    n^.keyFlag := 0;
    n^.tbtitle := '���������';
    InitSyncBasicUpAndDown(n);
    FList.Add(n);
  end;

  procedure InitList33;
  var n:PSynTableInfo;
  begin
    if dllGlobal.GetSFVersion <> '.LCL' then Exit;

    new(n);
    n^.tbname := 'MSC_MESSAGE';
    n^.keyFields := 'TENANT_ID;MSG_ID';
    n^.synFlag := 33;
    n^.keyFlag := 0;
    n^.tbtitle := '��Ϣ����';
    if SyncType in [0,2] then
       begin
         n^.isSyncUp := '1';
         n^.isSyncDown := '1';
       end;
    FList.Add(n);

    new(n);
    n^.tbname := 'MSC_MESSAGE_LIST';
    n^.keyFields := 'TENANT_ID;MSG_ID;SHOP_ID';
    n^.whereStr :=  'TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
    n^.syncShopId := token.shopId;
    n^.synFlag := 33;
    n^.keyFlag := 0;
    n^.tbtitle := '��Ϣ�б�';
    if SyncType in [0,2] then
       begin
         n^.isSyncUp := '1';
         n^.isSyncDown := '1';
       end;
    FList.Add(n);
  end;
var
  str:string;
  rs:TZQuery;
begin
  ClearSyncList;

  InitList0;

  InitList00;

  InitList2('TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP',token.tenantId);
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  rs.First;
  while not rs.Eof do
  begin
    InitList2('TENANT_ID='+rs.FieldByName('TENANT_ID').AsString+' and TIME_STAMP>:TIME_STAMP ',rs.FieldByName('TENANT_ID').AsString);
    rs.Next;
  end;

  InitList3;

  InitList4;

  InitList10;

  InitList20;

  InitList21('TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP',token.tenantId);
  rs := dllGlobal.GetZQueryFromName('CA_RELATIONS');
  rs.First;
  while not rs.Eof do
  begin
    str := 'TENANT_ID='+rs.FieldByName('P_TENANT_ID').AsString+' and TIME_STAMP>:TIME_STAMP';
    InitList21(str,rs.FieldByName('P_TENANT_ID').AsString);
    rs.Next;
  end;

  InitList22;

  InitList23;

  InitList29;

  InitList33;
end;

function TSyncFactory.CheckNeedLoginSync: boolean;
var timestamp:int64;
begin
  result := true;
  if LoginSyncDate = 0 then
     timestamp := GetSynTimeStamp(token.tenantId,'LOGIN_SYNC','#')
  else
     timestamp := LoginSyncDate;

  if token.lDate <> timestamp then
     result := true
  else
     result := false; 
end;

function TSyncFactory.CheckNeedLoginSyncBizData: boolean;
begin
  result := false;
  LastLoginSyncDate  := GetSynTimeStamp(token.tenantId,'LOGIN_SYNC','#');
  LastLogoutSyncDate := GetSynTimeStamp(token.tenantId,'LOGOUT_SYNC','#');
  if LastLoginSyncDate  = 0 then Exit;
  if LastLogoutSyncDate = 0 then Exit;
  if LastLoginSyncDate  = token.lDate then Exit;
  if LastLogoutSyncDate = token.lDate then Exit;
  if LastLogoutSyncDate < LastLoginSyncDate then result := true;
end;

procedure TSyncFactory.InitTenant;
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    dataFactory.ExecProc('TTenantInitV60',Params);
  finally
    Params.Free;
  end;
  // RightsFactory.InitialRights;
end;

procedure TSyncFactory.LoginSync(PHWnd: THandle);
var
  flag:integer;
  firstLogin:boolean;
begin
  timered := true;
  try
    firstLogin := false;
    if dllApplication.mode = 'demo' then Exit;
    with TfrmSyncData.Create(nil) do
    begin
      try
        if token.online then dataFactory.remote.DBLock(true);
        ReadTimeStamp;
        AddLoginLog;
        if token.tenantId <> '' then PlayerFactory.OpenPlayer;
        if not token.online then Exit;
        CommandPush.ExecuteCommand;
        hWnd := PHWnd;
        ShowForm;
        BringToFront;
        Update;
        Application.ProcessMessages;
        CheckBackUpDBFile(PHWnd);
        if token.tenantId = '' then
           begin
             firstLogin := true;
             TfrmSysDefine.AutoRegister;
             if token.tenantId = '' then Exit;
             AddLoginLog;
             PlayerFactory.OpenPlayer;
             flag := SyncFactory.CheckRemoteData(PHWnd);
             if flag = 0 then // û�л�ԭ
                begin
                  RspSyncFactory.SyncAll;
                  RspSyncFactory.copyGoodsSort;
                  SyncFactory.InitTenant;
                  SyncFactory.SyncBasic(1);
                  TfrmSysDefine.SaveRegister;
                end
             else if flag = 1 then // �ļ���ԭ
                begin

                end
             else if flag = 2 then // Զ�����ݻ�ԭ
                begin
                  TfrmSysDefine.SaveRegister;
                end;
           end
        else
           begin
             if not CheckNeedLoginSync then Exit;
             if not SyncLockCheck(PHWnd) then Exit;
             SyncFactory.BackUpDBFile;
             RspSyncFactory.SyncAll;
             RspSyncFactory.copyGoodsSort;
             SyncFactory.SyncBasic(2);
             if CheckNeedLoginSyncBizData then
                begin
                  if MessageBox(PHWnd,'ϵͳ��⵽�ϴ��˳�δ��������ͬ�����Ƿ�����ִ��?','��������',MB_YESNO+MB_ICONQUESTION) = 6 then
                     begin
                       if dllGlobal.GetSFVersion = '.LCL' then
                          TfrmStocksCalc.Calc(Application.MainForm,now());
                       SyncFactory.SyncBizData;
                       SyncFactory.SetSynTimeStamp(token.tenantId,'LOGOUT_SYNC',LastLoginSyncDate,'#');
                     end;
                end;
             if XsmFactory.getXsmMessage and Assigned(MsgFactory) then
                begin
                  MsgFactory.Load;
                  MsgFactory.GetUnRead;
                  MsgFactory.ShowHintMsg;
                end;
           end;
        SyncFactory.LoginSyncDate := token.lDate;
        SyncFactory.SetSynTimeStamp(token.tenantId,'LOGIN_SYNC',token.lDate,'#');
      finally
        if token.online then dataFactory.remote.DBLock(false);
        Free;
      end;
    end;
  finally
    timered := false;
  end;
end;

procedure TSyncFactory.LogoutSync(PHWnd: THandle);
begin
  timered := true;
  try
    PlayerFactory.ClosePlayer;
    if dllApplication.mode = 'demo' then Exit;
    if token.tenantId = '' then Exit;
    with TfrmSyncData.Create(nil) do
    begin
      try
        if token.online then dataFactory.remote.DBLock(true);
        AddLogoutLog;
        if not token.online then Exit;
        CommandPush.ExecuteCommand;
        hWnd := PHWnd;
        ShowForm;
        BringToFront;
        Update;
        if not SyncFactory.SyncLockCheck(PHWnd) then Exit;
        SyncFactory.SyncBasic(2);
        if dllGlobal.GetSFVersion = '.LCL' then
           TfrmStocksCalc.Calc(Application.MainForm,now());
        SyncFactory.SyncBizData;
        SyncFactory.SetSynTimeStamp(token.tenantId,'LOGOUT_SYNC',token.lDate,'#');
        if RtcSyncFactory.GetToken then
           begin
             RtcSyncFactory.RtcLogout;
             RtcSyncFactory.SyncRtcData;
           end;
      finally
        if token.online then dataFactory.remote.DBLock(false);
        Free;
      end;
    end;
  finally
    timered := false;
  end;
end;

procedure TSyncFactory.RecoverySync(PHWnd:THandle;BeginDate:string='');
begin
  timered := true;
  try
    if dllApplication.mode = 'demo' then Exit;
    if token.tenantId = '' then Exit;
    if not token.online then Exit;
    with TfrmSyncData.Create(nil) do
    begin
      try
        if token.online then dataFactory.remote.DBLock(true);
        hWnd := PHWnd;
        ShowForm;
        BringToFront;
        Update;
        SyncFactory.SyncBasic(3);
        SyncFactory.SyncBizData(1,BeginDate);
      finally
        if token.online then dataFactory.remote.DBLock(false);
        Free;
      end;
    end;
  finally
    timered := false;
  end;
end;

procedure TSyncFactory.RegisterSync(PHWnd: THandle);
begin
  timered := true;
  try
    if dllApplication.mode = 'demo' then Exit;
    if token.tenantId = '' then Exit;
    with TfrmSyncData.Create(nil) do
    begin
      try
        if token.online then dataFactory.remote.DBLock(true);
        hWnd := PHWnd;
        ShowForm;
        BringToFront;
        Update;
        RspSyncFactory.SyncAll;
        RspSyncFactory.copyGoodsSort;
        SyncFactory.InitTenant;
        SyncFactory.SyncBasic(1);
        SyncFactory.LoginSyncDate := token.lDate;
        SyncFactory.SetSynTimeStamp(token.tenantId,'LOGIN_SYNC',token.lDate,'#');
      finally
        if token.online then dataFactory.remote.DBLock(false);
        Free;
      end;
    end;
  finally
    timered := false;
  end;
end;

procedure TSyncFactory.SyncStockOrder(SyncFlag:integer=0;BeginDate:string='');
var
  Params:TftParamList;
  ls,rs_h,rs_d,cs_h,cs_d:TZQuery;
  MaxTimeStamp,LastTimeStamp:int64;
  tbName,orderFields,dataFields:string;
begin
  if (SyncFlag <> 0) and (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'STK_STOCKORDER';
  LastTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  MaxTimeStamp := LastTimeStamp;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+inttostr(LastTimeStamp));

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('TABLE_NAME').AsString := tbName;
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('KEY_FLAG').AsInteger := 0;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

    if SyncFlag = 0 then
       Params.ParamByName('SYN_COMM').AsBoolean := true
    else
       Params.ParamByName('SYN_COMM').AsBoolean := false;

    if (SyncFlag <> 0) and (BeginDate <> '') then
       begin
         Params.ParamByName('BEGIN_DATE').AsInteger := strtoint(BeginDate);
         Params.ParamByName('SYS_BEGIN_DATE').AsInteger := CloseAccDate;
       end;

    //���¿�����
    if SyncFlag = 0 then
       begin
         if dllGlobal.GetSFVersion = '.LCL' then
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := false
         else
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := true;
       end
    else
       begin
         if BeginDate = '' then
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := true
         else
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := false;
       end;

    SetTicket;
    if SyncFlag = 0 then
       dataFactory.MoveToSqlite
    else
       dataFactory.MoveToRemote;
    try
      dataFactory.Open(ls,'TSyncStockOrderListV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    BeforeSyncBiz(ls,'STOCK_DATE',SyncFlag);
    SetTicket;
    ls.First;
    while not ls.Eof do
    begin
      ProTitle := '<������>...��'+inttostr(ls.RecordCount)+'�ʣ���ǰ��'+inttostr(ls.RecNo)+'��';
      SetProPosition(100 div ls.RecordCount * ls.RecNo);
{
      // С�ڹ������ڵĵ��ݲ�����
      if (SyncFlag <> 0) and (CloseAccDate > 0) and (ls.FieldByName('STOCK_DATE').AsInteger <= CloseAccDate) then
         begin
           ls.Next;
           Continue;
         end;
}
      rs_h.Close;
      rs_d.Close;
      cs_h.Close;
      cs_d.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;STOCK_ID';
      Params.ParamByName('STOCK_ID').AsString := ls.FieldbyName('STOCK_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('STK_STOCKORDER');
      if dataFields = ''  then dataFields  := GetTableFields('STK_STOCKDATA','a');

      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
          dataFactory.AddBatch(rs_h,'TSyncStockOrderV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
          dataFactory.AddBatch(rs_d,'TSyncStockDataV60',Params);
          dataFactory.OpenBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;

      if SyncFlag = 0 then
         dataFactory.MoveToRemote
      else
         dataFactory.MoveToSqlite;
      try
        dataFactory.BeginBatch;
        try
          dataFactory.AddBatch(cs_h,'TSyncStockOrderV60',Params);
          dataFactory.AddBatch(cs_d,'TSyncStockDataV60',Params);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      if StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);

      if SyncFlag = 0 then
      begin
        rs_h.Delete;
        dataFactory.MoveToSqlite;
        try
          dataFactory.UpdateBatch(rs_h,'TSyncStockOrderV60',Params);
        finally
          dataFactory.MoveToDefault;
        end;
      end;

      ls.Next;
    end;
    if not ls.IsEmpty then SetSynTimeStamp(token.tenantId,tbName,MaxTimeStamp,token.shopId);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    Params.Free;
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    cs_h.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncSalesOrder(SyncFlag:integer=0;BeginDate:string='');
var
  Params:TftParamList;
  MaxTimeStamp,LastTimeStamp:int64;
  ls,rs_h,rs_d,rs_s,cs_h,cs_d,cs_s:TZQuery;
  tbName,orderFields,dataFields,glideFields:string;
begin
  if (SyncFlag <> 0) and (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'SAL_SALESORDER';
  LastTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  MaxTimeStamp := LastTimeStamp;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+inttostr(LastTimeStamp));

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('TABLE_NAME').AsString := tbName;
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('KEY_FLAG').AsInteger := 0;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

    if SyncFlag = 0 then
       Params.ParamByName('SYN_COMM').AsBoolean := true
    else
       Params.ParamByName('SYN_COMM').AsBoolean := false;

    if (SyncFlag <> 0) and (BeginDate <> '') then
       begin
         Params.ParamByName('BEGIN_DATE').AsInteger := strtoint(BeginDate);
         Params.ParamByName('SYS_BEGIN_DATE').AsInteger := CloseAccDate;
       end;

    //���¿�����
    if SyncFlag = 0 then
       begin
         if dllGlobal.GetSFVersion = '.LCL' then
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := false
         else
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := true;
       end
    else
       begin
         if BeginDate = '' then
            begin
              Params.ParamByName('UPDATE_STORAGE').AsBoolean := true;
              Params.ParamByName('UPDATE_INTEGRAL').AsBoolean := false;
            end
         else
            begin
              Params.ParamByName('UPDATE_STORAGE').AsBoolean := false;
              Params.ParamByName('UPDATE_INTEGRAL').AsBoolean := false;
            end;
       end;

    SetTicket;
    if SyncFlag = 0 then
       dataFactory.MoveToSqlite
    else
       dataFactory.MoveToRemote;
    try
      dataFactory.Open(ls,'TSyncSalesOrderListV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    BeforeSyncBiz(ls,'SALES_DATE',SyncFlag);
    SetTicket;
    ls.First;
    while not ls.Eof do
    begin
      ProTitle := '<���۵�>...��'+inttostr(ls.RecordCount)+'�ʣ���ǰ��'+inttostr(ls.RecNo)+'��';
      SetProPosition(100+(100 div ls.RecordCount * ls.RecNo));
{
      // С�ڹ������ڵĵ��ݲ�����
      if (SyncFlag <> 0) and (CloseAccDate > 0) and (ls.FieldByName('SALES_DATE').AsInteger <= CloseAccDate) then
         begin
           ls.Next;
           Continue;
         end;
}
      rs_h.Close;
      rs_d.Close;
      rs_s.Close;
      cs_h.Close;
      cs_d.Close;
      cs_s.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SALES_ID';
      Params.ParamByName('SALES_ID').AsString := ls.FieldbyName('SALES_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('SAL_SALESORDER');
      if dataFields = ''  then dataFields  := GetTableFields('SAL_SALESDATA');
      if glideFields = '' then glideFields := GetTableFields('SAL_IC_GLIDE');

      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
          dataFactory.AddBatch(rs_h,'TSyncSalesOrderV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
          dataFactory.AddBatch(rs_d,'TSyncSalesDataV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := glideFields;
          dataFactory.AddBatch(rs_s,'TSyncSalesICDataV60',Params);
          dataFactory.OpenBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;
      cs_s.SyncDelta := rs_s.SyncDelta;

      if SyncFlag = 0 then
         dataFactory.MoveToRemote
      else
         dataFactory.MoveToSqlite;
      try
        dataFactory.BeginBatch;
        try
          dataFactory.AddBatch(cs_h,'TSyncSalesOrderV60',Params);
          dataFactory.AddBatch(cs_d,'TSyncSalesDataV60',Params);
          dataFactory.AddBatch(cs_s,'TSyncSalesICDataV60',Params);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      if StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);

      if SyncFlag = 0 then
      begin
        rs_h.Delete;
        dataFactory.MoveToSqlite;
        try
          dataFactory.BeginBatch;
          try
            dataFactory.AddBatch(rs_h,'TSyncSalesOrderV60',Params);
            if not rs_s.IsEmpty then
               begin
                 rs_s.Delete;
                 dataFactory.AddBatch(rs_s,'TSyncSalesICDataV60',Params);
               end;
            dataFactory.CommitBatch;
          except
            dataFactory.CancelBatch;
            Raise;
          end;
        finally
          dataFactory.MoveToDefault;
        end;
      end;

      ls.Next;
    end;
    if not ls.IsEmpty then SetSynTimeStamp(token.tenantId,tbName,MaxTimeStamp,token.shopId);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    Params.Free;
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    rs_s.Free;
    cs_h.Free;
    cs_d.Free;
    cs_s.Free;
  end;
end;

procedure TSyncFactory.SyncChangeOrder(SyncFlag:integer=0;BeginDate:string='');
var
  Params:TftParamList;
  ls,rs_h,rs_d,cs_h,cs_d:TZQuery;
  MaxTimeStamp,LastTimeStamp:int64;
  tbName,orderFields,dataFields:string;
begin
  if (SyncFlag <> 0) and (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'STO_CHANGEORDER';
  LastTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  MaxTimeStamp := LastTimeStamp;

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+inttostr(LastTimeStamp));

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('TABLE_NAME').AsString := tbName;
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('KEY_FLAG').AsInteger := 0;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

    if SyncFlag = 0 then
       Params.ParamByName('SYN_COMM').AsBoolean := true
    else
       Params.ParamByName('SYN_COMM').AsBoolean := false;

    if (SyncFlag <> 0) and (BeginDate <> '') then
       begin
         Params.ParamByName('BEGIN_DATE').AsInteger := strtoint(BeginDate);
         Params.ParamByName('SYS_BEGIN_DATE').AsInteger := CloseAccDate;
       end;

    //���¿�����
    if SyncFlag = 0 then
       begin
         if dllGlobal.GetSFVersion = '.LCL' then
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := false
         else
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := true;
       end
    else
       begin
         if BeginDate = '' then
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := true
         else
            Params.ParamByName('UPDATE_STORAGE').AsBoolean := false;
       end;

    SetTicket;
    if SyncFlag = 0 then
       dataFactory.MoveToSqlite
    else
       dataFactory.MoveToRemote;
    try
      dataFactory.Open(ls,'TSyncChangeOrderListV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));
    BeforeSyncBiz(ls,'CHANGE_DATE',SyncFlag);
    SetTicket;
    ls.First;
    while not ls.Eof do
    begin
      ProTitle := '<���浥>...��'+inttostr(ls.RecordCount)+'�ʣ���ǰ��'+inttostr(ls.RecNo)+'��';
      SetProPosition(200+(100 div ls.RecordCount * ls.RecNo));
{
      // С�ڹ������ڵĵ��ݲ�����
      if (SyncFlag <> 0) and (CloseAccDate > 0) and (ls.FieldByName('CHANGE_DATE').AsInteger <= CloseAccDate) then
         begin
           ls.Next;
           Continue;
         end;
}
      rs_h.Close;
      rs_d.Close;
      cs_h.Close;
      cs_d.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;CHANGE_ID';
      Params.ParamByName('CHANGE_ID').AsString := ls.FieldbyName('CHANGE_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('STO_CHANGEORDER');
      if dataFields = ''  then dataFields  := GetTableFields('STO_CHANGEDATA','a');

      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
          dataFactory.AddBatch(rs_h,'TSyncChangeOrderV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
          dataFactory.AddBatch(rs_d,'TSyncChangeDataV60',Params);
          dataFactory.OpenBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;

      if SyncFlag = 0 then
         dataFactory.MoveToRemote
      else
         dataFactory.MoveToSqlite;
      try
        dataFactory.BeginBatch;
        try
          dataFactory.AddBatch(cs_h,'TSyncChangeOrderV60',Params);
          dataFactory.AddBatch(cs_d,'TSyncChangeDataV60',Params);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      if StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);

      if SyncFlag = 0 then
      begin
        rs_h.Delete;
        dataFactory.MoveToSqlite;
        try
          dataFactory.UpdateBatch(rs_h,'TSyncChangeOrderV60',Params);
        finally
          dataFactory.MoveToDefault;
        end;
      end;

      ls.Next;
    end;
    if not ls.IsEmpty then SetSynTimeStamp(token.tenantId,tbName,MaxTimeStamp,token.shopId);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    Params.Free;
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    cs_h.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncRckDays(SyncFlag:integer=0;BeginDate:string='');
var
  Params:TftParamList;
  ls,rs_h,rs_d,cs_h,cs_d:TZQuery;
  MaxTimeStamp,LastTimeStamp:int64;
  updateVersion,insertVersion:string;
  tbName,orderFields,dataFields:string;
begin
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;

  tbName := 'RCK_DAYS_CLOSE';
  LastTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  MaxTimeStamp := LastTimeStamp; 

  LogFile.AddLogFile(0,'��ʼ<'+tbName+'>�ϴ�ʱ��:'+inttostr(LastTimeStamp));

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('TABLE_NAME').AsString := tbName;
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('KEY_FLAG').AsInteger := 0;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;

    if SyncFlag = 0 then
       Params.ParamByName('SYN_COMM').AsBoolean := true
    else
       Params.ParamByName('SYN_COMM').AsBoolean := false;

    if (SyncFlag <> 0) and (BeginDate <> '') then
       begin
         Params.ParamByName('BEGIN_DATE').AsInteger := strtoint(BeginDate);
         Params.ParamByName('SYS_BEGIN_DATE').AsInteger := CloseAccDate;
       end;

    SetTicket;
    if SyncFlag = 0 then
       dataFactory.MoveToSqlite
    else
       dataFactory.MoveToRemote;
    try
      dataFactory.Open(ls,'TSyncRckDaysCloseListV60',Params);
    finally
      dataFactory.MoveToDefault;
    end;
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(ls.RecordCount));

    if (not ls.IsEmpty) and (SyncFlag = 0) then
       begin
         updateVersion := 'update SYS_DEFINE set VALUE=''V6'' where TENANT_ID='+token.tenantId+' and DEFINE=''APPVERSION'' ';
         insertVersion := 'insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values ('+token.tenantId+',''APPVERSION'',''V6'',0,''10'','+GetTimeStamp(dataFactory.remote.iDbType)+') ';
         if dataFactory.remote.ExecSQL(updateVersion) <= 0 then
            dataFactory.remote.ExecSQL(insertVersion);
       end;

    SetTicket;
    ls.First;
    while not ls.Eof do
    begin
      ProTitle := '<��̨��>...��'+inttostr(ls.RecordCount)+'�ʣ���ǰ��'+inttostr(ls.RecNo)+'��';
      SetProPosition(300+(100 div ls.RecordCount * ls.RecNo));
{
      // С�ڹ������ڵ����ݲ�����
      if (SyncFlag <> 0) and (CloseAccDate > 0) and (ls.FieldByName('CREA_DATE').AsInteger <= CloseAccDate) then
         begin
           ls.Next;
           Continue;
         end;
}
      rs_h.Close;
      rs_d.Close;

      Params.ParamByName('CREA_DATE').AsInteger := ls.FieldbyName('CREA_DATE').AsInteger;

      if orderFields = '' then orderFields := GetTableFields('RCK_DAYS_CLOSE');
      if dataFields = ''  then dataFields  := GetTableFields('RCK_STOCKS_DATA');

      if SyncFlag = 0 then
         dataFactory.MoveToSqlite
      else
         dataFactory.MoveToRemote;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
          dataFactory.AddBatch(rs_h,'TSyncRckDaysCloseV60',Params);
          Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
          dataFactory.AddBatch(rs_d,'TSyncRckStocksDataV60',Params);
          dataFactory.OpenBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;

      if SyncFlag = 0 then
         dataFactory.MoveToRemote
      else
         dataFactory.MoveToSqlite;
      try
        dataFactory.BeginBatch;
        try
          Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SHOP_ID;CREA_DATE';
          dataFactory.AddBatch(cs_h,'TSyncRckDaysCloseV60',Params);
          Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SHOP_ID;BILL_DATE';
          dataFactory.AddBatch(cs_d,'TSyncRckStocksDataV60',Params);
          dataFactory.CommitBatch;
        except
          dataFactory.CancelBatch;
          Raise;
        end;
      finally
        dataFactory.MoveToDefault;
      end;

      if StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
         MaxTimeStamp := StrtoInt64(rs_h.FieldByName('TIME_STAMP').AsString);

      if SyncFlag = 0 then
      begin
        rs_h.Delete;
        dataFactory.MoveToSqlite;
        try
          dataFactory.UpdateBatch(rs_h,'TSyncRckDaysCloseV60',Params);
        finally
          dataFactory.MoveToDefault;
        end;
      end;

      ls.Next;
    end;
    if not ls.IsEmpty then SetSynTimeStamp(token.tenantId,tbName,MaxTimeStamp,token.shopId);
    LogFile.AddLogFile(0,'�ϴ�<'+tbName+'>����ʱ��:'+inttostr(GetTicket));
  finally
    Params.Free;
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    cs_h.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.SyncBizData(SyncFlag:integer=0;BeginDate:string='');
begin
  try
    SetProMax(400);
    ProTitle := '����׼������...';
    GetCloseAccDate;
    ProTitle := '<������>...';
    SyncStockOrder(SyncFlag,BeginDate);
    SetProPosition(100);
    ProTitle := '<���۵�>...';
    SyncSalesOrder(SyncFlag,BeginDate);
    SetProPosition(200);
    ProTitle := '<���浥>...';
    SyncChangeOrder(SyncFlag,BeginDate);
    SetProPosition(300);
    ProTitle := '<��̨��>...';
    SyncRckDays(SyncFlag,BeginDate);
    SetProPosition(400);
    ProTitle := '<����>...';
    if SyncFlag=0 then SyncStorage;
  finally
    ReadTimeStamp;
  end
end;

procedure TSyncFactory.BeforeSyncBiz(DataSet:TZQuery;FieldName:string;SyncFlag:integer);
var
  rDate:integer;
  isUpdate:boolean;
  Params:TftParamList;
begin
  rDate := 99999999;
  isUpdate := false;
  DataSet.First;
  while not DataSet.Eof do
  begin
    if DataSet.FieldByName(FieldName).AsInteger < rDate then
       begin
         rDate := DataSet.FieldByName(FieldName).AsInteger;
         isUpdate := true;
       end;
    DataSet.Next;
  end;
  if isUpdate then
     begin
       Params := TftParamList.Create(nil);
       try
         Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
         Params.ParamByName('CLSE_DATE').AsInteger := rDate;
         Params.ParamByName('MOTH_DATE').AsString := FormatDatetime('YYYY-MM-DD',FnTime.fnStrtoDate(inttostr(rDate)));
         if SyncFlag = 0 then
            dataFactory.remote.ExecProc('TSyncDeleteRckCloseV60',TftParamList.Encode(Params))
         else
            dataFactory.sqlite.ExecProc('TSyncDeleteRckCloseV60',Params);
       finally
         Params.Free;
       end;
    end;
end;

procedure TSyncFactory.RecoveryClose(CloseDate: string);
var str:string;
begin
  if dataFactory.sqlite.ExecSQL('update SYS_DEFINE set VALUE='''+CloseDate+''' where TENANT_ID='+token.tenantId+' and DEFINE = ''SYS_BEGIN_DATE'' ')=0 then
    begin
      str := ' insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values ('+token.tenantId+',''SYS_BEGIN_DATE'','''+CloseDate+''',0,''00'',0)';
      dataFactory.sqlite.ExecSQL(str);
    end;
  CloseAccDate := strtoint(CloseDate);
end;

procedure TSyncFactory.GetCloseAccDate;
var rs:TZQuery;
begin
  if CloseAccDate >= 0 then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('DEFINE').AsString := 'SYS_BEGIN_DATE';
    dataFactory.sqlite.Open(rs);
    if rs.IsEmpty then
       CloseAccDate := 0
    else
       CloseAccDate := rs.Fields[0].AsInteger;
  finally
    rs.Free;
  end;
end;

procedure TSyncFactory.SetProTitle(const Value: string);
begin
  FProTitle := Value;
  SetProCaption;
end;

procedure TSyncFactory.SetProHandle(const Value: Hwnd);
begin
  FProHandle := Value;
end;

procedure TSyncFactory.SetProCaption;
begin
  GlobalProTitle := ProTitle;
  PostMessage(ProHandle, MSC_SET_CAPTION, 0, 0);
  Application.ProcessMessages;
end;

procedure TSyncFactory.SetProMax(max: integer);
begin
  PostMessage(ProHandle, MSC_SET_MAX, max, 0);
  Application.ProcessMessages;
end;

procedure TSyncFactory.SetProPosition(position: integer);
begin
  PostMessage(ProHandle, MSC_SET_POSITION, position, 0);
  Application.ProcessMessages;
end;

procedure TSyncFactory.AddLoginLog;
  function GetProductInfo:string;
  var dllVersionInfo: TRzVersionInfo;
  begin
    dllVersionInfo := TRzVersionInfo.Create(nil);
    try
      try
        dllVersionInfo.FilePath := ExtractFilePath(ParamStr(0))+'shop.dll';
        result := 'R6<'+dllVersionInfo.FileVersion+'>';
      except
        result := 'R6';
      end;
    finally
      dllVersionInfo.Free;
    end;
  end;

  function GetConnStr:string;
  var
    F:TIniFile;
    vList:TStringList;
  begin
    F := TIniFile.Create(ExtractShortPathName(ExtractFilePath(Application.ExeName))+'db.cfg');
    try
      result := F.ReadString('db','Connstr','');
    finally
      F.Free;
    end;
    vList := TStringList.Create;
    try
      vList.Delimiter := ';';
      vList.QuoteChar := '"';
      vList.DelimitedText := result;
      result := vList.Values['hostname']+':'+vList.Values['port']+'<'+vList.Values['dbid']+'>';
    finally
      vList.Free;
    end;
  end;
var
  SQL,Flag,ConnectTo:string;
begin
  if token.tenantId = '' then Exit;
  LoginStart := GetTickCount;
  LoginId := TSequence.NewId;
  try
    if token.online then
       begin
         Flag := '1';
         ConnectTo := GetConnStr;
         dataFactory.MoveToRemote;
       end
    else
       begin
         Flag := '2';
         ConnectTo := 'Local';
         dataFactory.MoveToSqlite;
       end;
    SQL :=
      'insert into CA_LOGIN_INFO (LOGIN_ID,TENANT_ID,SHOP_ID,USER_ID,IP_ADDR,COMPUTER_NAME,MAC_ADDR,SYSTEM_INFO,PRODUCT_ID,NETWORK_STATUS,CONNECT_TO,LOGIN_DATE,CONNECT_TIMES,COMM,TIME_STAMP) '+
      'values('''+LoginId+''','+token.tenantId+','''+token.shopId+''','''+token.userId+''','''+GetIPAddr+''','''+GetComputerName+''','''+GetMacAddr+''',''-'','''+GetProductInfo+''','''+Flag+''','''+ConnectTo+''','''+FormatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',-1,''00'','+GetTimeStamp(dataFactory.iDbType)+')';
    dataFactory.ExecSQL(SQL);
  finally
    dataFactory.MoveToDefault;
  end;
end;

procedure TSyncFactory.AddLogoutLog;
begin
  if LoginId='' then Exit;
  if token.online then dataFactory.MoveToRemote else dataFactory.MoveToSqlite;
  try
    dataFactory.ExecSQL('update CA_LOGIN_INFO set LOGOUT_DATE='''+FormatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',CONNECT_TIMES='+inttostr((GetTickCount-LoginStart) div 60000)+',COMM='+GetCommStr(dataFactory.iDbType)+',TIME_STAMP='+GetTimeStamp(dataFactory.iDbType)+' where TENANT_ID='+token.tenantId+' and LOGIN_ID='''+LoginId+'''');
  finally
    dataFactory.MoveToDefault;
  end;
  LoginId := '';
end;

procedure TSyncFactory.SetLoginId(const Value: string);
begin
  FLoginId := Value;
end;

function TSyncFactory.DBLocked: boolean;
var
  i:integer;
  rs:TZQuery;
  rid:string;
  LocalList:TStringList;
begin
  result := true;
  if (dllGlobal.GetSFVersion = '.ONL') or (dllGlobal.GetSFVersion = '.NET') then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE='''+'DBKEY_'+token.shopId+''' and TENANT_ID='+token.tenantId;
    try
      rs.Data := dataFactory.remote.OpenSQL(rs.SQL.Text,TftParamList.Encode(rs.Params));
    except
      Raise Exception.Create(StrPas(dataFactory.remote.getLastError));
    end;
    rid := rs.Fields[0].AsString;
    if rid <> '' then
       begin
         result := false;
         LocalList := TStringList.Create;
         try
           LocalList.DelimitedText := GetMacAddrInfo;
           LocalList.Delimiter := ',';
           for i := 0 to LocalList.Count - 1 do
             begin
               if pos(','+LocalList[i]+',', ','+rid+',') > 0 then
                  begin
                    result := true;
                    break;
                  end;
             end;
         finally
           LocalList.Free;
         end;
         if (not result) and (GetComputerName = rid) then
            begin
              result := true;
            end;
       end
    else
       begin
         result := false;
       end;
  finally
    rs.Free;
  end;
end;

function TSyncFactory.SyncLockCheck(PHWnd:THandle;tip:string): boolean;
var
  i:integer;
  rs:TZQuery;
  rid:string;
  LocalList:TStringList;
begin
  result := true;
  if (dllGlobal.GetSFVersion = '.ONL') or (dllGlobal.GetSFVersion = '.NET') then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE='''+'DBKEY_'+token.shopId+''' and TENANT_ID='+token.tenantId;
    try
      rs.Data := dataFactory.remote.OpenSQL(rs.SQL.Text,TftParamList.Encode(rs.Params));
    except
      Raise Exception.Create(StrPas(dataFactory.remote.getLastError));
    end;
    rid := rs.Fields[0].AsString;
    if rid <> '' then
       begin
         result := false;
         LocalList := TStringList.Create;
         try
           LocalList.DelimitedText := GetMacAddrInfo;
           LocalList.Delimiter := ',';
           for i := 0 to LocalList.Count - 1 do
             begin
               if pos(','+LocalList[i]+',', ','+rid+',') > 0 then
                  begin
                    result := true;
                    break;
                  end;
             end;
         finally
           LocalList.Free;
         end;
         if (not result) and (GetComputerName = rid) then
            begin
              result := true;
            end;
       end
    else
       begin
         result := true;
         SyncLockDb;
       end;
  finally
    rs.Free;
  end;

  if not result then
     begin
       if tip = '' then tip := '�޷��ϴ�����...';
       if MessageBox(PHWnd,pchar('ϵͳ��⵽��ǰʹ�õĵ��Բ��������õĵ��ԣ�'+tip+#10#13+'�Ƿ���������?'),'��������',MB_YESNO+MB_ICONQUESTION) = 6 then
          begin
            result := TfrmUnLockGuide.ShowDialog(Application.MainForm);
            if result then SyncLockDb;
          end
       else result := false;
     end;
end;

function TSyncFactory.SyncLockDb: boolean;
var
  rs:TZQuery;
  MacAddr:string;
  Params:TftParamList;
begin
  result := true;
  if not token.online then Exit;
  if (dllGlobal.GetSFVersion = '.ONL') or (dllGlobal.GetSFVersion = '.NET') then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE='''+'DBKEY_'+token.shopId+''' and TENANT_ID='+token.tenantId;
    try
      rs.Data := dataFactory.remote.OpenSQL(rs.SQL.Text,TftParamList.Encode(rs.Params));
    except
      Raise Exception.Create(StrPas(dataFactory.remote.getLastError));
    end;
    if rs.Fields[0].AsString<>'' then Exit;
  finally
    rs.Free;
  end;
  MacAddr := GetMacAddrInfo;
  if MacAddr = '' then MacAddr := GetComputerName;
  if Length(MacAddr) > 100 then SetLength(MacAddr, 100);
  Params:=TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger:=strtoint(token.tenantId);
    Params.ParamByName('DBKEY').AsString:='DBKEY_'+token.shopId;
    Params.ParamByName('NEWID').AsString:=MacAddr;
    dataFactory.remote.ExecProc('TDoLockDBKey',TftParamList.Encode(Params));
  finally
    Params.Free;
  end;
end;

procedure TSyncFactory.BackUpDBFile;
var
  sr: TSearchRec;
  FileAttrs: Integer;
  delTime,Folder,FileName: string;
begin
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;

  ProTitle := '���ڱ��������ļ������Ժ�...';
  try
    delTime := FormatDateTime('YYYYMMDD',now()-7);
    Folder := ExtractFilePath(Application.ExeName)+'backup\'+token.tenantId;
    FileName := Folder+'\r3_'+FormatDateTime('YYYYMMDD',now())+'.db';
    ForceDirectories(ExtractFileDir(FileName));
    CopyFile(pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),pchar(FileName),false);

    // ɾ����ʷ�����ļ�
    FileAttrs := 0;
    FileAttrs := FileAttrs + faAnyFile;
    if FindFirst(Folder+'\*.db', FileAttrs, sr) = 0 then
    begin
      repeat
        try
          if (sr.Attr and FileAttrs) = sr.Attr then
          begin
            if (Copy(sr.Name,1,3) = 'r3_') and (Length(sr.Name) = 14) then
               begin
                 if (Copy(sr.Name,4,8) <= delTime) then
                    begin
                      DeleteFile(Folder+'\'+sr.Name);
                    end;
               end;
          end;
        except

        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  except

  end;
end;

function TSyncFactory.CheckRemoteData(AppHandle:HWnd):integer;
var
  rs:TZQuery;
  NeedRecovery:boolean;
  recType:string;
  // Folder,FileName
  // sr: TSearchRec;
  // FileAttrs: integer;
begin
  result := 0;
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;
  rs := TZQuery.Create(nil);
  dataFactory.MoveToRemote;
  try
    rs.SQL.Text := 'select 1 from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    dataFactory.Open(rs);
    NeedRecovery := not rs.IsEmpty;
  finally
    dataFactory.MoveToDefault;
    rs.Free;
  end;

  if not NeedRecovery then Exit;

  //Զ�����ݻ�ԭ
  if MessageBox(AppHandle,pchar('ϵͳ��⵽����˴��ڱ��ݵ����ݣ��Ƿ�������ԭ��'),'������ʾ',MB_YESNO+MB_ICONQUESTION) = 6 then
     begin
       recType := TfrmSelectRecType.ShowDialog(Application.MainForm);
       if recType <> '' then
          begin
            try
              TfrmSysDefine.DBRemoteRecovery(recType,AppHandle);
              result := 2;
            except
              on E:Exception do
                 begin
                   MessageBox(AppHandle,pchar('���ݻָ�����ԭ��'+E.Message),'������ʾ...',MB_OK+MB_ICONQUESTION);
                 end;
            end;
          end;
     end;
{
  // ����ļ��ָ�
  try
    Folder := ExtractFilePath(Application.ExeName)+'backup\'+token.tenantId;
    FileAttrs := 0;
    FileAttrs := FileAttrs + faAnyFile;
    if FindFirst(Folder+'\*.db', FileAttrs, sr) = 0 then
       begin
         repeat
           try
             if (sr.Attr and FileAttrs) = sr.Attr then
             begin
               if (Copy(sr.Name,1,3) = 'r3_') and (Length(sr.Name) = 14) then
                  begin
                    if (FileName = '') or (Copy(sr.Name,4,8) > Copy(FileName,4,8)) then
                       begin
                         FileName := sr.Name;
                       end;
                  end;
             end;
           except

           end;
         until FindNext(sr) <> 0;
         FindClose(sr);
       end;
  except

  end;

  if (FileName <> '') and (CheckValidDBFile(Folder+'\'+FileName)) then
     begin
       //�����ļ���ԭ
       if MessageBox(AppHandle,pchar('ϵͳ��⵽���ش������ݱ����ļ����Ƿ�������ԭ��'),'������ʾ',MB_YESNO+MB_ICONQUESTION) = 6 then
          begin
            try
              TfrmSysDefine.DBFileRecovery(Folder+'\'+FileName,AppHandle);
              result := 1;
            except
              on E:Exception do
                 begin
                   MessageBox(AppHandle,pchar(E.Message),'������ʾ...',MB_OK+MB_ICONQUESTION);
                 end;
            end;
          end;
     end
  else
     begin
     end;
}
end;

function TSyncFactory.CheckBackUpDBFile(PHWnd:THandle): boolean;
begin
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;
  if FileExists(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6') then
     begin
       if not CheckValidDBFile(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6') then
          begin
            DeleteFile(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6');
            Exit;
          end;
       MessageBox(PHWnd,'ϵͳ��⵽�ϴ����ݻָ��������쳣�жϣ���������ļ����л�ԭ...','������ʾ...',MB_OK+MB_ICONQUESTION);
       dataFactory.sqlite.DisConnect;
       if CopyFile(pchar(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6'),pchar(ExtractFilePath(Application.ExeName)+'data\r3.db'),false) then
          begin
            dataFactory.sqlite.Connect;
            DeleteFile(ExtractFilePath(Application.ExeName)+'data\r3_bak.r6');
            MessageBox(PHWnd,'�����ļ���ԭ�ɹ�...','������ʾ..',MB_OK);
          end
       else
          begin
            Raise Exception.Create('�����ļ��ָ�ʧ��...');
          end;
      end;
end;

function TSyncFactory.CheckValidDBFile(src: string): boolean;
var
  rs:TZQuery;
  sqlite:TdbFactory;
begin
  result := false;
  try
    sqlite := TdbFactory.Create;
    rs := TZQuery.Create(nil);
    try
      sqlite.Initialize('provider=sqlite-3;databasename='+ExtractShortPathName(src));
      sqlite.connect;
      rs.SQL.Text := 'select VALUE from SYS_DEFINE where DEFINE = ''TENANT_ID'' and TENANT_ID=0';
      sqlite.Open(rs);
      if rs.Fields[0].AsString = token.tenantId then
         result := true
      else
         result := false;
    finally
      rs.Free;
      sqlite.Free;
    end;
  except
    result := false;
  end;
end;

procedure TSyncFactory.SyncStorage;
var
  n:PSynTableInfo;
begin
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;
  new(n);
  n^.tbname := 'STO_STORAGE';
  n^.keyFields := 'TENANT_ID;SHOP_ID;GODS_ID;BATCH_NO;PROPERTY_01;PROPERTY_02';
  n^.synFlag := 1;
  n^.keyFlag := 1;
  n^.tbtitle := '��ǰ���';
  n^.isSyncUp := '1';
  try
    if GetSynTimeStamp(token.tenantId,'STO_STORAGE','#') <= 5497000 then
       begin
         dataFactory.remote.ExecSQL('update STO_STORAGE set AMOUNT=0,AMONEY=0 where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+'''');
       end;
    SyncSingleTable(n);
  finally
    dispose(n);
  end;
end;

procedure TSyncFactory.TimerSync;
begin
  if dllApplication.mode = 'demo' then Exit;
  if not timered then TTimeSyncThread.Create(false);
end;

procedure TSyncFactory.Settimered(const Value: boolean);
begin
  if Value then
     EnterCriticalSection(ThreadLock)
  else
     LeaveCriticalSection(ThreadLock);
  Ftimered := Value;
end;

{ TTimeSyncThread }

constructor TTimeSyncThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate := true;
end;

destructor TTimeSyncThread.Destroy;
begin
  inherited;
end;

procedure TTimeSyncThread.Execute;
var
  sql:string;
begin
  inherited;
  SyncFactory.timered := true;
  CoInitialize(nil);
  try
    try
    if not SyncFactory.DBLocked then Exit;
    //����״̬����
    if SyncFactory.LoginId<>'' then
    begin
      if token.online then
         begin
           sql := 'update CA_LOGIN_INFO set LOGOUT_DATE='''+FormatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',CONNECT_TIMES='+inttostr((GetTickCount-SyncFactory.LoginStart) div 60000)+',COMM='+GetCommStr(dataFactory.remote.iDbType)+',TIME_STAMP='+GetTimeStamp(dataFactory.remote.iDbType)+' where TENANT_ID='+token.tenantId+' and LOGIN_ID='''+SyncFactory.LoginId+'''';
           dataFactory.remote.ExecSQL(sql);
         end
      else
         begin
           sql := 'update CA_LOGIN_INFO set LOGOUT_DATE='''+FormatDatetime('YYYY-MM-DD HH:NN:SS',now())+''',CONNECT_TIMES='+inttostr((GetTickCount-SyncFactory.LoginStart) div 60000)+',COMM='+GetCommStr(dataFactory.sqlite.iDbType)+',TIME_STAMP='+GetTimeStamp(dataFactory.sqlite.iDbType)+' where TENANT_ID='+token.tenantId+' and LOGIN_ID='''+SyncFactory.LoginId+'''';
           dataFactory.sqlite.ExecSQL(sql);
         end;
    end;
    if not SyncFactory.timerTerminted then SyncFactory.TimerSyncSales;
    if not SyncFactory.timerTerminted then SyncFactory.TimerSyncStock;
    if not SyncFactory.timerTerminted then SyncFactory.TimerSyncChange;
    if not SyncFactory.timerTerminted then SyncFactory.TimerSyncStorage;
    if not SyncFactory.timerTerminted then SyncFactory.TimerSyncMessage;
    except
    end;
  finally
    CoUninitialize;
    SyncFactory.timered := false;
  end;
end;

procedure TSyncFactory.SettimerTerminted(const Value: boolean);
begin
  FtimerTerminted := Value;
end;

procedure TSyncFactory.TimerSyncSales;
var
  Params:TftParamList;
  LastTimeStamp:int64;
  ls,rs_h,rs_d,rs_s,cs_h,cs_d,cs_s:TZQuery;
  tbName,orderFields,dataFields,glideFields:string;
begin
  if (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'SAL_SALESORDER';
  LastTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  if timerTerminted then Exit;

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  rs_s := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  cs_s := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('TABLE_NAME').AsString := tbName;
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('KEY_FLAG').AsInteger := 0;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
    Params.ParamByName('SYN_COMM').AsBoolean := true;

    //���¿�����
    if dllGlobal.GetSFVersion = '.LCL' then
       Params.ParamByName('UPDATE_STORAGE').AsBoolean := false
    else
       Params.ParamByName('UPDATE_STORAGE').AsBoolean := true;

    dataFactory.sqlite.Open(ls,'TSyncSalesOrderListV60',Params);
    if ls.RecordCount>0 then LogFile.AddLogFile(0,'�ϴ���ʱͬ��<'+tbName+'>  ��¼��:'+inttostr(ls.RecordCount));

    if timerTerminted then Exit;

    BeforeSyncBiz(ls,'SALES_DATE',0);
    ls.First;
    while not ls.Eof do
    begin
      if timerTerminted then Exit;
      rs_h.Close;
      rs_d.Close;
      rs_s.Close;
      cs_h.Close;
      cs_d.Close;
      cs_s.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SALES_ID';
      Params.ParamByName('SALES_ID').AsString := ls.FieldbyName('SALES_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('SAL_SALESORDER');
      if dataFields = ''  then dataFields  := GetTableFields('SAL_SALESDATA');
      if glideFields = '' then glideFields := GetTableFields('SAL_IC_GLIDE');

      dataFactory.sqlite.BeginBatch;
      try
        Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
        dataFactory.sqlite.AddBatch(rs_h,'TSyncSalesOrderV60',Params);
        Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
        dataFactory.sqlite.AddBatch(rs_d,'TSyncSalesDataV60',Params);
        Params.ParamByName('TABLE_FIELDS').AsString := glideFields;
        dataFactory.sqlite.AddBatch(rs_s,'TSyncSalesICDataV60',Params);
        dataFactory.sqlite.OpenBatch;
      except
        dataFactory.sqlite.CancelBatch;
        Raise;
      end;

      if timerTerminted then Exit;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;
      cs_s.SyncDelta := rs_s.SyncDelta;

      dataFactory.remote.BeginBatch;
      try
        dataFactory.remote.AddBatch(TZQuery(cs_h).Delta,'TSyncSalesOrderV60',TftParamList.Encode(Params));
        dataFactory.remote.AddBatch(TZQuery(cs_d).Delta,'TSyncSalesDataV60',TftParamList.Encode(Params));
        dataFactory.remote.AddBatch(TZQuery(cs_s).Delta,'TSyncSalesICDataV60',TftParamList.Encode(Params));
        dataFactory.remote.CommitBatch;
      except
        dataFactory.remote.CancelBatch;
        Raise;
      end;

      rs_h.Delete;
      dataFactory.sqlite.BeginBatch;
      try
        dataFactory.sqlite.AddBatch(rs_h,'TSyncSalesOrderV60',Params);
        if not rs_s.IsEmpty then
           begin
             rs_s.Delete;
             dataFactory.sqlite.AddBatch(rs_s,'TSyncSalesICDataV60',Params);
           end;
        dataFactory.sqlite.CommitBatch;
      except
        dataFactory.sqlite.CancelBatch;
        Raise;
      end;

      ls.Next;
    end;
  finally
    Params.Free;
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    rs_s.Free;
    cs_h.Free;
    cs_d.Free;
    cs_s.Free;
  end;
end;

procedure TSyncFactory.TimerSyncChange;
var
  Params:TftParamList;
  LastTimeStamp:int64;
  ls,rs_h,rs_d,cs_h,cs_d:TZQuery;
  tbName,orderFields,dataFields:string;
begin
  if (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'STO_CHANGEORDER';
  LastTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  if timerTerminted then Exit;

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('TABLE_NAME').AsString := tbName;
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('KEY_FLAG').AsInteger := 0;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    //���¿�����
    if dllGlobal.GetSFVersion = '.LCL' then
       Params.ParamByName('UPDATE_STORAGE').AsBoolean := false
    else
       Params.ParamByName('UPDATE_STORAGE').AsBoolean := true;

    dataFactory.sqlite.Open(ls,'TSyncChangeOrderListV60',Params);
    if timerTerminted then Exit;

    if ls.RecordCount>0 then LogFile.AddLogFile(0,'�ϴ���ʱͬ��<'+tbName+'> ��¼��:'+inttostr(ls.RecordCount));
    BeforeSyncBiz(ls,'CHANGE_DATE',0);
    ls.First;
    while not ls.Eof do
    begin
      if timerTerminted then Exit;
      rs_h.Close;
      rs_d.Close;
      cs_h.Close;
      cs_d.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;CHANGE_ID';
      Params.ParamByName('CHANGE_ID').AsString := ls.FieldbyName('CHANGE_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('STO_CHANGEORDER');
      if dataFields = ''  then dataFields  := GetTableFields('STO_CHANGEDATA','a');

      dataFactory.sqlite.BeginBatch;
      try
        Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
        dataFactory.sqlite.AddBatch(rs_h,'TSyncChangeOrderV60',Params);
        Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
        dataFactory.sqlite.AddBatch(rs_d,'TSyncChangeDataV60',Params);
        dataFactory.sqlite.OpenBatch;
      except
        dataFactory.sqlite.CancelBatch;
        Raise;
      end;
      if timerTerminted then Exit;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;

      dataFactory.remote.BeginBatch;
      try
        dataFactory.remote.AddBatch(TZQuery(cs_h).Delta,'TSyncChangeOrderV60',TftParamList.Encode(Params));
        dataFactory.remote.AddBatch(TZQuery(cs_d).Delta,'TSyncChangeDataV60',TftParamList.Encode(Params));
        dataFactory.remote.CommitBatch;
      except
        dataFactory.remote.CancelBatch;
        Raise;
      end;

      rs_h.Delete;
      dataFactory.UpdateBatch(rs_h,'TSyncChangeOrderV60',Params);

      ls.Next;
    end;
  finally
    Params.Free;
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    cs_h.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.TimerSyncStock;
var
  Params:TftParamList;
  LastTimeStamp:int64;
  ls,rs_h,rs_d,cs_h,cs_d:TZQuery;
  tbName,orderFields,dataFields:string;
begin
  if (dllGlobal.GetSFVersion <> '.LCL') then Exit;

  tbName := 'STK_STOCKORDER';
  LastTimeStamp := GetSynTimeStamp(token.tenantId,tbName,token.shopId);
  if timerTerminted then Exit;

  ls := TZQuery.Create(nil);
  rs_h := TZQuery.Create(nil);
  rs_d := TZQuery.Create(nil);
  cs_h := TZQuery.Create(nil);
  cs_d := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('TABLE_NAME').AsString := tbName;
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('KEY_FLAG').AsInteger := 0;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 0;
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    //���¿�����
    if dllGlobal.GetSFVersion = '.LCL' then
       Params.ParamByName('UPDATE_STORAGE').AsBoolean := false
    else
       Params.ParamByName('UPDATE_STORAGE').AsBoolean := true;

    dataFactory.sqlite.Open(ls,'TSyncStockOrderListV60',Params);
    if ls.RecordCount>0 then LogFile.AddLogFile(0,'�ϴ���ʱͬ��<'+tbName+'>  ��¼��:'+inttostr(ls.RecordCount));
    if timerTerminted then Exit;

    BeforeSyncBiz(ls,'STOCK_DATE',0);
    ls.First;
    while not ls.Eof do
    begin
      if timerTerminted then Exit;
      rs_h.Close;
      rs_d.Close;
      cs_h.Close;
      cs_d.Close;

      Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;STOCK_ID';
      Params.ParamByName('STOCK_ID').AsString := ls.FieldbyName('STOCK_ID').AsString;

      if orderFields = '' then orderFields := GetTableFields('STK_STOCKORDER');
      if dataFields = ''  then dataFields  := GetTableFields('STK_STOCKDATA','a');

      dataFactory.sqlite.BeginBatch;
      try
        Params.ParamByName('TABLE_FIELDS').AsString := orderFields;
        dataFactory.sqlite.AddBatch(rs_h,'TSyncStockOrderV60',Params);
        Params.ParamByName('TABLE_FIELDS').AsString := dataFields;
        dataFactory.sqlite.AddBatch(rs_d,'TSyncStockDataV60',Params);
        dataFactory.sqlite.OpenBatch;
      except
        dataFactory.sqlite.CancelBatch;
        Raise;
      end;

      if timerTerminted then Exit;

      cs_h.SyncDelta := rs_h.SyncDelta;
      cs_d.SyncDelta := rs_d.SyncDelta;

      dataFactory.remote.BeginBatch;
      try
        dataFactory.remote.AddBatch(TZQuery(cs_h).Delta,'TSyncStockOrderV60',TftParamList.Encode(Params));
        dataFactory.remote.AddBatch(TZQuery(cs_d).Delta,'TSyncStockDataV60',TftParamList.Encode(Params));
        dataFactory.remote.CommitBatch;
      except
        dataFactory.remote.CancelBatch;
        Raise;
      end;

      rs_h.Delete;
      dataFactory.sqlite.UpdateBatch(rs_h,'TSyncStockOrderV60',Params);

      ls.Next;
    end;
  finally
    Params.Free;
    ls.Free;
    rs_h.Free;
    rs_d.Free;
    cs_h.Free;
    cs_d.Free;
  end;
end;

procedure TSyncFactory.TimerSyncStorage;
var
  i:integer;
  tmpObj:TRecord_;
  ZClassName:string;
  rs_l,rs_r:TZQuery;
  LastTimeStamp:int64;
  Params:TftParamList;
begin
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;

  if timerTerminted then Exit;

  tmpObj := TRecord_.Create;
  rs_l := TZQuery.Create(nil);
  rs_r := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    ZClassName := 'TSyncSingleTableV60';
    LastTimeStamp := GetSynTimeStamp(token.tenantId,'STO_STORAGE','#');

    if timerTerminted then Exit;

    rs_l.Close;
    rs_r.Close;

    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    Params.ParamByName('SHOP_ID').AsString := token.shopId;
    Params.ParamByName('KEY_FLAG').AsInteger := 1;
    Params.ParamByName('TABLE_NAME').AsString := 'STO_STORAGE';
    Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;SHOP_ID;GODS_ID;BATCH_NO;PROPERTY_01;PROPERTY_02';
    Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('LAST_TIME_STAMP').Value := LastTimeStamp;
    Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 1;
    Params.ParamByName('SYN_COMM').AsBoolean := true;
    Params.ParamByName('Transed').AsBoolean := false;
    Params.ParamByName('TABLE_FIELDS').AsString := GetTableFields('STO_STORAGE');

    dataFactory.sqlite.Open(rs_l,ZClassName,Params);

    if timerTerminted then Exit;

    if LastTimeStamp <= 5497000 then
       begin
         dataFactory.remote.ExecSQL('update STO_STORAGE set AMOUNT=0,AMONEY=0 where TENANT_ID='+token.tenantId+' and SHOP_ID='''+token.shopId+'''');
       end;

    if timerTerminted then Exit;

    if rs_l.IsEmpty then Exit;

    if rs_l.RecordCount <= MAX_SYNC_RECORD_COUNT then
       begin
         rs_r.SyncDelta := rs_l.SyncDelta;
         dataFactory.remote.UpdateBatch(TZQuery(rs_r).Delta,ZClassName,TftParamList.Encode(Params));
       end
    else
       begin
         i := 0;
         rs_l.First;
         rs_r.FieldDefs.Assign(rs_l.FieldDefs);
         rs_r.CreateDataSet;
         while not rs_l.Eof do
           begin
             if timerTerminted then Exit;

             rs_r.Append;
             tmpObj.ReadFromDataSet(rs_l);
             tmpObj.WriteToDataSet(rs_r);
             inc(i);
             rs_l.Next;
             if (i >= MAX_SYNC_RECORD_COUNT) or (rs_l.Eof) then
                begin
                  dataFactory.remote.UpdateBatch(TZQuery(rs_r).Delta,ZClassName,TftParamList.Encode(Params));
                  i := 0;
                  rs_r.EmptyDataSet;
                end;
           end;
      end;
  finally
    tmpObj.Free;
    Params.Free;
    rs_l.Free;
    rs_r.Free;
  end;
end;

function TSyncFactory.Gettimered: boolean;
begin
  result := Ftimered;
end;

procedure TSyncFactory.TimerSyncMessage;
var n1,n2:PSynTableInfo;
begin
  if not token.online then Exit;
  if dllGlobal.GetSFVersion <> '.LCL' then Exit;

  new(n1);
  n1^.tbname := 'MSC_MESSAGE';
  n1^.keyFields := 'TENANT_ID;MSG_ID';
  n1^.whereStr :=  'TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP and END_DATE>='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()));
  n1^.synFlag := 33;
  n1^.keyFlag := 0;
  n1^.tbtitle := '��Ϣ����';
  n1^.isSyncDown := '1';

  new(n2);
  n2^.tbname := 'MSC_MESSAGE_LIST';
  n2^.keyFields := 'TENANT_ID;MSG_ID;SHOP_ID';
  n2^.whereStr :=  'TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP and MSG_READ_STATUS=1';
  n2^.syncShopId := token.shopId;
  n2^.synFlag := 33;
  n2^.keyFlag := 0;
  n2^.tbtitle := '��Ϣ�б�';
  n2^.isSyncDown := '1';

  try
    SyncSingleTable(n1);
    if timerTerminted then Exit;
    SyncSingleTable(n2);
  finally
    dispose(n1);
    dispose(n2);
  end;

  MsgFactory.Load;
  MsgFactory.GetUnRead;
end;

procedure TSyncFactory.SyncUpperAmount;
var
  F:TIniFile;
  rs,ss:TZQuery;
  Params:TftParamList;
  MaxTimeStamp,LastTimeStamp:int64;
  rimComId,rimCustId,ZClassName,LicenseCode:string;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'r3.cfg');
  try
    if F.ReadString('soft','SYNC_UPPER_AMOUNT','0') = '0' then Exit;
  finally
    F.Free;
  end;

  ss := dllGlobal.GetZQueryFromName('CA_SHOP_INFO');
  LicenseCode := ss.FieldByName('LICENSE_CODE').AsString;
  rs := TZQuery.Create(nil);
  ss := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    rs.SQL.Text := 'select COM_ID,CUST_ID from RM_CUST a where a.LICENSE_CODE=:LICENSE_CODE';
    rs.ParamByName('LICENSE_CODE').AsString := LicenseCode;
    try
      TZQuery(rs).Data := dbHelp.OpenSQL(TZQuery(rs).SQL.Text,TftParamList.Encode(TZQuery(rs).Params));
    except
      Raise Exception.Create(StrPas(dataFactory.remote.getLastError));
    end;
    if rs.IsEmpty then Exit;
    rimComId := rs.FieldByName('COM_ID').AsString;
    rimCustId := rs.FieldByName('CUST_ID').AsString;
  finally
    rs.Free;
  end;

  ZClassName := 'TSyncSingleTableV60';
  LastTimeStamp := GetSynTimeStamp('999999999','PUB_GOODSINFOEXT');
  MaxTimeStamp := LastTimeStamp;

  LogFile.AddLogFile(0,'��ʼ����<PUB_GOODSINFO_������>�ϴ�ʱ��:'+inttostr(LastTimeStamp));

  SetTicket;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      ' select a.TENANT_ID,a.GODS_ID,b.WHSE_UP*(case when a.SMALLTO_CALC is null then 1 else a.SMALLTO_CALC end) as UPPER_AMOUNT,''10'' as COMM,b.TIME_STAMP '+
      ' from   VIW_GOODSINFO a,RIM_CUST_ITEM_WHSE_QTY b '+
      ' where  a.TENANT_ID=:TENANT_ID '+
      '        and b.COM_ID=:COM_ID and b.CUST_ID=:CUST_ID '+
      '        and a.SECOND_ID=b.ITEM_ID '+
      '        and b.TIME_STAMP>:TIME_STAMP '+
      ' order by b.TIME_STAMP asc ';
    rs.ParamByName('TENANT_ID').AsInteger:=StrtoInt(token.tenantId);
    rs.ParamByName('COM_ID').AsString:=rimComId;
    rs.ParamByName('CUST_ID').AsString:=rimCustId;
    rs.ParamByName('TIME_STAMP').Value:=LastTimeStamp;
    try
      TZQuery(rs).Data := dbHelp.OpenSQL(TZQuery(rs).SQL.Text,TftParamList.Encode(TZQuery(rs).Params));
    except
      Raise Exception.Create(StrPas(dataFactory.remote.getLastError));
    end;

    LogFile.AddLogFile(0,'����<PUB_GOODSINFO_������>��ʱ��:'+inttostr(GetTicket)+'  ��¼��:'+inttostr(rs.RecordCount));

    if not rs.IsEmpty then
       begin
         rs.Last;
         if StrtoInt64(rs.FieldByName('TIME_STAMP').AsString) > MaxTimeStamp then
            MaxTimeStamp := StrtoInt64(rs.FieldByName('TIME_STAMP').AsString);

         SetTicket;
         ss.SyncDelta := rs.SyncDelta;
         Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
         Params.ParamByName('SHOP_ID').AsString := token.shopId;
         Params.ParamByName('KEY_FLAG').AsInteger := 1;
         Params.ParamByName('TABLE_NAME').AsString := 'PUB_GOODSINFOEXT';
         Params.ParamByName('KEY_FIELDS').AsString := 'TENANT_ID;GODS_ID';
         Params.ParamByName('TIME_STAMP').Value := LastTimeStamp;
         Params.ParamByName('TIME_STAMP_NOCHG').AsInteger := 1;
         Params.ParamByName('SYN_COMM').AsBoolean := false;
         Params.ParamByName('Transed').AsBoolean := true;
         dataFactory.UpdateBatch(ss,ZClassName,Params);

         LogFile.AddLogFile(0,'����<PUB_GOODSINFO_������>����ʱ��:'+inttostr(GetTicket));

         if MaxTimeStamp > LastTimeStamp then
            SetSynTimeStamp('999999999','PUB_GOODSINFOEXT',MaxTimeStamp);
       end;
  finally
    Params.Free;
    ss.Free;
    rs.Free;
  end;
end;

procedure TSyncFactory.CloseForDaySync(PHWnd: THandle);
begin
  timered := true;
  try
    if dllApplication.mode = 'demo' then Exit;
    if token.tenantId = '' then Exit;
    with TfrmSyncData.Create(nil) do
    begin
      try
        if token.online then dataFactory.remote.DBLock(true);
        if not token.online then Exit;
        hWnd := PHWnd;
        ShowForm;
        BringToFront;
        Update;
        SyncFactory.SyncBasic(2);
        SyncFactory.SyncBizData;
      finally
        if token.online then dataFactory.remote.DBLock(false);
        Free;
      end;
    end;
  finally
    timered := false;
  end;
end;

initialization
  SyncFactory := TSyncFactory.Create;
finalization
  if Assigned(SyncFactory) then FreeAndNil(SyncFactory);
end.
