{------------------------------------------------------------------------------
  RIM������ú����������ࡢ���ݽṹ

  
 ------------------------------------------------------------------------------}
unit uRimSyncFactory;

interface

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  Windows,
  Forms,
  zBase,
  Dialogs,
  uBaseSyncFactory;

//������ϵͳ���ݶԽӵĻ���
type
  TRimSyncFactory=class(TBaseSyncFactory)
  private
    FMaxStmp: string;     //���ʱ���
    FUpMaxStmp: string;   //�������ʱ���
    FSyncType: integer;   //ͬ������
    FShopLog: TLogShopInfo;  //�ŵ���־
    FPlugInIdx: integer;
    procedure SetMaxStmp(const Value: string);
    procedure SetSyncType(const Value: Integer);
    procedure TreatLogFile(LogDir: string);
    procedure SetPlugInIdx(const Value: integer);
  public
    R3ShopList: TZQuery;  //�ϱ��ŵ�List
    RimParam: TRimParams; //�ϱ�������¼
    constructor Create; override;
    destructor Destroy;override;
    //�����Ƿ��ϱ�������������壺�Ƿ��ϱ�;
    function GetPlugInRunFlag: Boolean;
    //����R3��Rim�����ʵĻ��㣺
    function GetR3ToRimZoom_Rate(Bill_UNIT_ID: string; AliasTable: string=''): string;
    //����R3תRim��λ��Unit_ID;
    function GetR3ToRimUnit_ID(iDbType:integer; UNIT_ID: string): string;     //���ص�λ����
    //ͬ������
    function GetSyncType: integer; virtual; //ͬ������   
    //1������RIM_R3_NUM����ϴ�ʱ����͵�ǰ���ʱ���:
    function GetMaxNUM(BillType, COM_ID,CUST_ID, SHOP_ID: string): string;
    //2������Rim�̲ݹ�˾ID(COM_ID): [IsTobaccoFlag=true���̲ݹ�˾������Ҫ��ѯ��ϵ��]         
    function GetRimCOM_ID(TENANT_ID: string; IsTobaccoFlag: Boolean=False): string; virtual;
    //4������Rim���ۻ�CUST_ID:
    function GetRimCUST_ID(COM_ID,LICENSE_CODE: string): string;
    //5������Rim���ۻ�CUST_ID�����ۻ�������COM_ID:
    function SetRimORGAN_CUST_ID(const InTENANT_ID,InSHOP_ID: string; var InCOM_ID,InCUST_ID: string): Boolean;
    //6�������ϱ����ŵ�List
    function GetR3ReportShopList(var ShopList: TZQuery): Boolean;
    //7�����ص�ǰ�ŵ�һ�����֤�ŵ������ŵ�List
    function GetShop_IDS(TenID,LICENSE_CODE: string): string;
    //8��ִ�е�������ӿ���俪������:
    function ExecTransSQL(SQL: string; var iRet: Integer; Msg: string=''): Boolean;  //�����Ƿ������Ƿ�ִ�гɹ�
    //9����ҵ��ʼ�ϱ�:
    procedure BeginLogReport; virtual;  //��ҵ��ʼ�ϱ�
    //10����ҵ�ϱ���д��Log�ļ�:
    procedure WriteToReportLogFile(ReportName: string=''); virtual;  //д��LogFile
    //11���ŵ꿪ʼ�ϱ�:
    procedure BeginLogShopReport; virtual;  //�ŵ꿪ʼ�ϱ�
    //12���ŵ��ϱ����дMsg:
    procedure EndLogShopReport(RelationFlag: Boolean; RunFlag: Boolean=False); overload; //�ŵ�����ϱ�
    //13���ŵ��ϱ����дMsg:
    procedure EndLogShopReport(Msg: string; RelationFlag: Boolean; RunFlag: Boolean=False); overload; //�ŵ�����ϱ�
    //14�������ϱ�дMsg��vType: 1:��ʾ�ɹ�; 0:��ʾ����;
    procedure AddBillMsg(BillName: string; iRect: integer; Msg: string='');  //һ�������ϱ�
    //16��дRIM_BAL_LOG��־
    function WriteToRIM_BAL_LOG(LICENSE_CODE,CustID,LogType,LogNote,LogStatus: string; USER_ID: string='auto'): Boolean;

    property MaxStmp: string read FMaxStmp write SetMaxStmp;              //���ʱ���
    property UpMaxStmp: string read FUpMaxStmp;                           //�������ʱ���
    property SyncType: integer read FSyncType write SetSyncType;          //�ϱ���ʽ:��0: ����ִ�У� 3��ǰ̨����ִ��)
    property ShopLog: TLogShopInfo read FShopLog;  //�ŵ���־
    property PlugInIdx: integer read FPlugInIdx write SetPlugInIdx;  //����������:Idx
  end;

implementation

{ TRimSyncFactory }
 
constructor TRimSyncFactory.Create;
begin
  inherited;
  FUpMaxStmp:='';
  R3ShopList:=TZQuery.Create(nil);
  FShopLog:=TLogShopInfo.Create;
  FShopLog.LogKind:=LogKind; //��־��ʽ
end;

destructor TRimSyncFactory.Destroy;
begin
  R3ShopList.Free;
  FShopLog.Free;
  inherited;
end;

function TRimSyncFactory.GetSyncType: integer; //ͬ������
begin
  result:=0;
  FSyncType:=0;
  if (Params.FindParam('FLAG')<>nil) then
    FSyncType:=Params.FindParam('FLAG').AsInteger;
  result:=FSyncType;
  FShopLog.SyncType:=result;  
end;

function TRimSyncFactory.GetMaxNUM(BillType, COM_ID, CUST_ID, SHOP_ID: string): string;
var
  iRet: integer;
  Str,TimeStamp: string;
  Rs: TZQuery;
begin
  result:='';
  Rs:=TZQuery.Create(nil);   
  try
    //���ص���0ʱ0��0��0�̵�ʱ���
    case DbType of
     0: TimeStamp:='convert(bigint,(convert(float,Convert(datetime,Convert(varchar(10),GetDate(),23)))-40542.0)*86400)';
     1: TimeStamp:='86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))';
     4: TimeStamp:='86400*(DAYS(CURRENT DATE)-DAYS(DATE(''2011-01-01'')))';  
     else
        TimeStamp:='convert(bigint,(convert(float,getdate())-40542.0)*86400)';
    end;

    Rs.Close;
    Rs.SQL.Text:='select MAX_NUM,'+TimeStamp+' as UPMAX_NUM  from RIM_R3_NUM where COM_ID='''+COM_ID+''' and CUST_ID='''+Cust_ID+''' and TYPE='''+BillType+''' and TERM_ID='''+SHOP_ID+''' ';
    if Open(Rs) then
    begin
      result:=trim(Rs.Fields[0].AsString);
      FUpMaxStmp:=trim(Rs.Fields[1].AsString);
    end;
    if result='' then result:='0';
    if Rs.IsEmpty then
    begin
      str:='insert into RIM_R3_NUM(COM_ID,CUST_ID,TYPE,TERM_ID,MAX_NUM) values ('''+COM_ID+''','''+Cust_ID+''','''+BillType+''','''+SHOP_ID+''',''0'')';
      if ExecSQL(Pchar(str),iRet)<>0 then Raise Exception.Create('RIM_R3_NUM��ʼ��['+str+']����:'+GetLastError);

      //����ʱ�����
      Rs.Close;
      Rs.SQL.Text:='select MAX_NUM,'+TimeStamp+' as UPMAX_NUM  from RIM_R3_NUM where COM_ID='''+COM_ID+''' and CUST_ID='''+Cust_ID+''' and TYPE='''+BillType+''' and TERM_ID='''+SHOP_ID+''' ';
      if Open(Rs) then
      begin
        result:=trim(Rs.Fields[0].AsString);
        FUpMaxStmp:=trim(Rs.Fields[1].AsString);
      end;
    end;
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.GetR3ReportShopList(var ShopList: TZQuery): Boolean;
var
  Str: string;
begin
  result:=False;
  if SyncType=3 then  //ǰ̨�ŵ��ն��ύ�ϱ�
  begin
    //(��ҵ����,�ŵ�ID,�ŵ�����,�ŵ����֤��):
    Str:='select TE.TENANT_ID,TE.TENANT_NAME,SH.SHOP_ID,SH.SHOP_NAME,SH.LICENSE_CODE from CA_SHOP_INFO SH,CA_TENANT TE '+
         ' where SH.TENANT_ID=TE.TENANT_ID and  SH.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' and '+
         ' SH.SHOP_ID='''+Params.ParamByName('SHOP_ID').AsString+''' ';
  end else //Rsp�����ϱ����̲ݹ�˾��ҵ
  begin
    //��Ӧ����ϵ��[���ش�����ҵ�����¼���ҵ]:
    Str:='select T.TENANT_ID,T.TENANT_NAME from CA_TENANT T,CA_RELATIONS R '+
         ' where T.TENANT_ID=R.RELATI_ID and T.COMM not in (''02'',''12'') and R.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+
         ' and R.RELATION_ID=1000006';

    //(��ҵ����,�ŵ�ID,�ŵ�����,�ŵ����֤��):
    Str:='select TE.TENANT_ID,TE.TENANT_NAME,SH.SHOP_ID,SH.SHOP_NAME,SH.LICENSE_CODE '+
         ' from CA_SHOP_INFO SH,('+Str+') TE where SH.TENANT_ID=TE.TENANT_ID order by TE.TENANT_ID,SH.SHOP_ID ';
  end;

  ShopList.Close;
  ShopList.SQL.Text:=Str;
  result:=Open(ShopList);
end;

function TRimSyncFactory.SetRimORGAN_CUST_ID(const InTENANT_ID, InSHOP_ID: string; var InCOM_ID,InCUST_ID: string): Boolean;
var
  Msg: string;
  Rs: TZQuery;
begin
  result:=False;
  InCOM_ID:='';
  InCUST_ID:='';
  try
    Rs:=TZQuery.Create(nil);
    try
      Rs.SQL.Text:=
         'select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B '+
         ' where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+InTENANT_ID+' and B.SHOP_ID='''+InSHOP_ID+''' ';
      if Open(Rs) then
      begin
        InCOM_ID:=trim(Rs.fieldbyName('COM_ID').AsString);
        InCUST_ID:=trim(Rs.fieldbyName('CUST_ID').AsString);
      end;
      Msg:=InCOM_ID;
    except
      on E:Exception do
      begin
        Raise Exception.Create(Pchar('����<SHOP_ID='+InSHOP_ID+'> ����Rim.COM_ID,CUST_ID����'+E.Message));
      end;
    end;
  finally
    rs.Free;
  end;
end;

//2011.05.25 ��ȡRim���ۻ�IDCust_ID
function TRimSyncFactory.GetRimCUST_ID(COM_ID,LICENSE_CODE: string): string;
var
  Rs: TZQuery;
begin
  result:='';
  try
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select CUST_ID from RM_CUST where COM_ID='''+COM_ID+''' and LICENSE_CODE='''+LICENSE_CODE+'''';
    if Open(Rs) then
      result:=trim(Rs.Fields[0].AsString);
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.GetRimCOM_ID(TENANT_ID: string; IsTobaccoFlag: Boolean): string;
var
  TenID: string;
  Rs: TZQuery;
begin
  result:='';
  TenID:='';
  try
    try
      Rs:=TZQuery.Create(nil);
      if (SyncType=3) and (IsTobaccoFlag=False) then  //ǰ̨�ŵ��ն��ύ�ϱ�[�Ƚ��ŵ����ҵID ���ݹ�Ӧ��ID���� �̲ݹ�˾����ҵID]
      begin
        Rs.Close;
        Rs.SQL.Text:='select TENANT_ID from CA_RELATIONS where RELATION_ID=1000006 and RELATI_ID ='+TENANT_ID+' ';
        if Open(Rs) then
          TenID:=trim(Rs.Fields[0].AsString);
        if TenID='' then Raise Exception.Create('����<���ۻ�>��ҵID:('+TENANT_ID+') û�м����ϼ��̲���ҵ');
      end else
        TenID:=TENANT_ID;  
      Rs.Close;
      Rs.SQL.Text:='select A.ORGAN_ID as ORGAN_ID from RIM_PUB_ORGAN A,CA_TENANT B where B.LOGIN_NAME=A.ORGAN_CODE and B.TENANT_ID='+TenID+' ';
      if Open(Rs) then
        result:=trim(Rs.Fields[0].AsString);
    except
      on E:Exception do
      begin
        if pos('����<���ۻ�>��ҵID:',E.Message)>0 then
          Raise
        else
          Raise Exception.Create('����<TENANT_ID='+TENANT_ID+'> ����Rim�̲ݹ�˾ID����'+E.Message);
      end;
    end;
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.WriteToRIM_BAL_LOG(LICENSE_CODE, CustID, LogType, LogNote, LogStatus, USER_ID: string): Boolean;
var
  str,LOG_SEQ,UserID,LogText: string;
  iRet: integer;
begin
  sleep(1);
  LOG_SEQ:=LICENSE_CODE+Formatdatetime('YYYYMMDDHHNNSSZZZ',now());
  LogText:=Copy(trim(LogNote),1,40);
  UserID:='auto';
  if SyncType=3 then USER_ID:='R3'; //�ն�ִ����־
  Str:='insert into RIM_BAL_LOG(LOG_SEQ,REF_TYPE,REF_ID,BAL_DATE,BAL_TIME,NOTE,USER_ID,STATUS) values '+
       '('''+LOG_SEQ+''','''+LogType+''','''+CustID+''','''+Formatdatetime('YYYYMMDD',date())+''','''+formatdatetime('HH:NN:SS',now())+''','''+LogText+''','''+UserID+''','''+LogStatus+''')' ;
  if ExecSQL(Pchar(Str),iRet)<>0 then
   Raise Exception.Create('д��־ִ��ʧ��:'+GetLastError);  
end;

procedure TRimSyncFactory.SetSyncType(const Value: Integer);
begin
  FSyncType := Value;
end;

procedure TRimSyncFactory.SetMaxStmp(const Value: string);
begin
  FMaxStmp := Value;
end;

procedure TRimSyncFactory.TreatLogFile(LogDir: string);
  function GetFileSize(const FileName: String): LongInt;
  var SearchRec: TSearchRec;
  begin
    try
      if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec)=0 then
        Result:=(SearchRec.Size div 1024) 
      else
        Result:=-1;
    finally
      SysUtils.FindClose(SearchRec);
    end;
  end;
var
  i,KeepDay: integer;
  LogFile,NewFile: string;
begin
  //Ĭ�ϱ������1���µ���־�ļ�
  if DayOfWeek(Date())=5 then  //�����ж�ɾ���ļ�
  begin
    KeepDay:=KeepLogDay;
    if KeepDay<7 then KeepDay:=7; //���ٱ���7��
    try
      for i:=KeepDay to 100 do
      begin
        LogFile:=LogDir+FormatDatetime('YYYYMMDD',Date()-i)+'.log';
        if FileExists(LogFile) then
          DeleteFile(Pchar(LogFile));
      end;
    except
    end;
  end;

  //�ж��ļ���С
  LogFile:=LogDir+FormatDatetime('YYYYMMDD',Date())+'.log';
  if FileExists(LogFile) then
  begin
    if GetFileSize(LogFile)> 1024 then
    for i:=1 to 100 do
    begin
      NewFile:=LogDir+FormatDatetime('YYYYMMDD',Date())+'_'+InttoStr(i)+'.log';
      if not FileExists(NewFile) then
        RenameFile(LogFile, NewFile);
    end;
  end;
end;

procedure TRimSyncFactory.BeginLogReport;
begin
  if SyncType=3 then Exit; //ǰ̨����ִ�в���־

  LogList.Clear;
  FRunInfo.BegTime:=GetTickTime;
  FRunInfo.BegTick:=GetTickCount;
  FRunInfo.AllCount:=0;
  FRunInfo.RunCount:=0;
  FRunInfo.NotCount:=0;
  FRunInfo.ErrorCount:=0;
  FRunInfo.ErrorStr:=''
end;

procedure TRimSyncFactory.WriteToReportLogFile(ReportName: string);
var
  i,KeepDay: integer;
  LogDir,LogFile,Str,ReportTitle: string;
  LogFileList: TStringList;
begin
  if SyncType=3 then Exit; //ǰ̨����ִ�в���־
  if R3ShopList.Active then
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //���ŵ���

  LogDir:=ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT';
  TreatLogFile(LogDir); //������־�ļ�

  if trim(ReportName)='' then ReportTitle:=' ��ʼ' else ReportTitle:='��'+ReportName+'�� ��ʼ';
  FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick; //��ִ�ж�����
  LogFile := LogDir+FormatDatetime('YYYYMMDD',Date())+'.log';
  try
    try
      //�����־:
      ReportTitle:=ReportTitle+':'+FRunInfo.BegTime+'; ����:'+inttoStr(FRunInfo.AllCount);
      if FRunInfo.RunCount>0   then ReportTitle:=ReportTitle+' �ɹ���'+inttoStr(FRunInfo.RunCount);
      if FRunInfo.ErrorCount>0 then ReportTitle:=ReportTitle+'���쳣��'+inttoStr(FRunInfo.ErrorCount);
      if FRunInfo.NotCount>0   then ReportTitle:=ReportTitle+'���޶�Ӧ���֤����'+inttoStr(FRunInfo.NotCount);

      LogFileList:=TStringList.Create;
      if FileExists(LogFile) then
      begin
        LogFileList.LoadFromFile(LogFile);
        LogFileList.Add('    ');
      end;

      if SyncType=3 then  //�ͻ��˵����ŵ���־
        LogFileList.Add('��---- <R3�ն�> '+ReportTitle+' ----��')
      else
        LogFileList.Add('��---- <Rsp����> '+ReportTitle+' ----��');
      for i:=0 to LogList.Count-1 do
      begin
        LogFileList.Add(LogList.Strings[i]);
      end;
      ReportTitle:='��---- [����] <���У�'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'��> ';
      if UpMaxStmp<>'' then
        ReportTitle:=ReportTitle+' <TIMESTAMP='+UpMaxStmp+'> ';
      if TWO_PHASE_COMMIT then
        ReportTitle:=ReportTitle+' <DBTran=TWO_COMMIT>'
      else
        ReportTitle:=ReportTitle+' <DBTran=SINGLE_COMMIT>';
      ReportTitle:=ReportTitle+'  ----��';
      LogFileList.Add(ReportTitle);
      LogFileList.Add('  ');
      LogFileList.SaveToFile(LogFile);
    finally
      LogFileList.Free;
    end;
  except
  end;
end;

procedure TRimSyncFactory.BeginLogShopReport;
begin
  FShopLog.BeginLog(RimParam.ShopName);
end;

procedure TRimSyncFactory.EndLogShopReport(RelationFlag, RunFlag: Boolean);
var
  Msg: string;
begin
  if not RelationFlag then
  begin
    Msg:='�ŵ�<'+RimParam.ShopName+'>���֤��<'+RimParam.LICENSE_CODE+'>��Rimϵͳ��û��Ӧ��';
    if PlugIntf.WriteLogFile(Pchar(LogHead+'['+Msg+']'))<>0 then Raise Exception.Create(GetLastError);
    //WriteLogFile(Msg); //д��Rsp��־���
  end;

  if SyncType=3 then Exit; //ǰ̨����ִ�в���־

  if RelationFlag then //R3�ŵ���Rim���ۻ��ж�Ӧ��
  begin
    if R3ShopList.RecordCount=1 then
      FShopLog.SetLogMsg(LogList)  //��ӱ���ִ����־
    else
      FShopLog.SetLogMsg(LogList,R3ShopList.RecNo); //��ӱ���ִ����־

    if RunFlag then
      Inc(FRunInfo.ErrorCount)  //ִ���쳣��
    else
      Inc(FRunInfo.RunCount);   //ִ�гɹ���
  end else
  begin
    Inc(FRunInfo.NotCount);  //��Ӧ����
    if R3ShopList.RecordCount=1 then
      Msg:='     '+Msg
    else
      Msg:='  ('+InttoStr(R3ShopList.RecNo)+')�ŵ�<'+RimParam.TenName+'>���֤��<'+RimParam.LICENSE_CODE+'> ��Rimϵͳ��û��Ӧ�����ۻ���';
    LogList.Add(Msg);
  end;
end;

procedure TRimSyncFactory.EndLogShopReport(Msg: string; RelationFlag, RunFlag: Boolean);
begin
  if SyncType=3 then Exit; //ǰ̨����ִ�в���־
  
  if RelationFlag then //�ж�ӦRim���֤��:
  begin
    if RunFlag then
      Inc(FRunInfo.ErrorCount)  //ִ���쳣��
    else
      Inc(FRunInfo.RunCount);   //ִ�гɹ���
  end else
    Inc(FRunInfo.NotCount);    //δ��Ӧ���֤�ţ�

  LogList.Add('  '+Msg);
end;

procedure TRimSyncFactory.AddBillMsg(BillName: string; iRect: integer; Msg: string);
begin
  if iRect=-1 then  //д��־Rsp��־���
  begin
    WriteLogFile('<'+BillName+'>'+Msg);
  end;

  if SyncType<>3 then
    FShopLog.AddBillMsg(BillName,iRect);
end;

function TRimSyncFactory.GetShop_IDS(TenID,LICENSE_CODE: string): string;
var
  Rs: TZQuery;
  ReStr: string;
begin
  result:=''' ''';
  try
    ReStr:='';
    Rs:=TZQuery.Create(nil);
    Rs.SQL.Text:='select SHOP_ID from CA_SHOP_INFO where TENANT_ID='+TenID+' and LICENSE_CODE='''+LICENSE_CODE+''' ';
    if Open(Rs) then
    begin
      Rs.First;
      while not Rs.Eof do
      begin
        if ReStr='' then
          ReStr:=''''+Rs.fieldbyName('SHOP_ID').AsString+''''
        else
          ReStr:=ReStr+','''+Rs.fieldbyName('SHOP_ID').AsString+'''';
        Rs.Next;
      end;
      result:=ReStr;
    end;
  finally
    Rs.Free;
  end;
end;

function TRimSyncFactory.ExecTransSQL(SQL: string; var iRet: Integer; Msg: string): Boolean;
begin
  result:=False;
  iRet:=-1;
  BeginTrans;  //��ʼ����
  try
    if ExecSQL(Pchar(SQL),iRet)<>0 then Raise Exception.Create(Msg+GetLastError);
    CommitTrans; //�ύ����
    result:=true;
  except
    RollbackTrans;
    Raise
  end;
end;

function TRimSyncFactory.GetR3ToRimUnit_ID(iDbType: integer; UNIT_ID: string): string;
begin
  case iDbType of
   0,4:
    begin
      Result:='(case when '+UNIT_ID+'=''13F817A7-9472-48CF-91CD-27125E077FEB'' then ''02'' '+
                   ' when '+UNIT_ID+'=''95331F4A-7AD6-45C2-B853-C278012C5525'' then ''03'' '+
               ' when '+UNIT_ID+'=''93996CD7-B043-4440-9037-4B82BB5207DA'' then ''04'' '+
               ' else ''01'' end)';
    end;
   1:
    begin
      Result:=' DECODE('+UNIT_ID+',''13F817A7-9472-48CF-91CD-27125E077FEB'',''02'',''95331F4A-7AD6-45C2-B853-C278012C5525'',''03'',''93996CD7-B043-4440-9037-4B82BB5207DA'',''04'',''01'')';
    end;
  end;
end;

//'13F817A7-9472-48CF-91CD-27125E077FEB','��'
//'95331F4A-7AD6-45C2-B853-C278012C5525','��'
//'93996CD7-B043-4440-9037-4B82BB5207DA','��'

function TRimSyncFactory.GetR3ToRimZoom_Rate(Bill_UNIT_ID: string; AliasTable: string): string;
var
  AliasTab,Zoom_Rate: string;
begin
  if trim(AliasTable)<>'' then AliasTab:=trim(AliasTable)+'.';
  Zoom_Rate:=ParseSQL(DbType,'nvl('+AliasTab+'ZOOM_RATE,1.0)');
  case DbType of
   0,4:
    begin
      Result:='(case when '+Bill_UNIT_ID+'=''13F817A7-9472-48CF-91CD-27125E077FEB'' then 1.0 '+  //��
                   ' when '+Bill_UNIT_ID+'=''95331F4A-7AD6-45C2-B853-C278012C5525'' then '+Zoom_Rate+' '+  //��
               ' when '+Bill_UNIT_ID+'=''93996CD7-B043-4440-9037-4B82BB5207DA'' then '+Zoom_Rate+' '+      //��
               ' else 1.0 end)'; //֧
    end;
   1:
    begin
      Result:=' DECODE('+Bill_UNIT_ID+',''13F817A7-9472-48CF-91CD-27125E077FEB'',1.0,''95331F4A-7AD6-45C2-B853-C278012C5525'','+Zoom_Rate+',''93996CD7-B043-4440-9037-4B82BB5207DA'','+Zoom_Rate+',1.0)';
    end;
  end;
end;

function TRimSyncFactory.GetPlugInRunFlag: Boolean;
var
  PlugInIDS: string;
begin
  result:=False;
  //��ȡ���Ƶ�IDS
  PlugInIDS:=ReadConfig('PARAMS','PlugInID','0000000000000000000');   //������Щ����ϱ�
  if PlugInIDS='' then PlugInIDS:='0000000000000000000';
  if Copy(PlugInIDS,PlugInIdx,1)='1' then
    result:=true;
end;

procedure TRimSyncFactory.SetPlugInIdx(const Value: integer);
begin
  FPlugInIdx := Value;
end;

end.
