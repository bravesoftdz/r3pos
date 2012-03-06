{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uParamsFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TParamsSyncFactory=class(TRimSyncFactory)
  private
    //�Զ�����ȷ�ϣ�Ĭ�ϲ��Զ�����
    AUTO_DOWN_ORDER: Boolean;
    //��������
    UsedDateQry: TZQuery;
    //���ض�����ͷ
    OrderQry: TZQuery;
    
    procedure WriteDownLoadToReportLog(LogMsg: string); //���ز���д��־
    //��Rim�����ۻ���ͬ������[single_sale_limit��sale_limit��IS_CHG_PRI]
    function  DownRimParamsToR3: Boolean;
    //2012.03.05������Զ�������Ϣ:
    //��ʽ����
    function FormatDay(InDay: string): string;
    //����R3��ҵ���������б�
    function GetR3UsedDateList: Boolean;
    //����һ���ŵ�Ķ���
    function GetINDEOrderList: Boolean;
    //�ж��Ƿ��Ѵ��ڣ���������Ϣ����
    function CheckMessageExists(const OrderDay,ArrDay: string; var Title, s, Content,COMM_ID: string): Boolean;
    //����һ���ŵ굽��ȷ����Ϣ
    function DoShopDownOrderMessage: integer;
    //���ɵ���ȷ����Ϣ
    function DownOrderMessage: integer;
  public
    constructor Create;override;
    destructor Destroy;override;
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;
 
implementation

uses
  uFnUtil;

{ TParamsSyncFactory }

function TParamsSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  result:=-1;
  PlugInID:='1006';
  //2011.11.26�ն�������ִ�в���
  PlugInIdx:=8;
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType;  //����ͬ�����ͱ��

  //2011.06.12 Add��Rim���������޼ۡ������������ֵ:
  if not GetPlugInRunFlag then
  begin
    DownRimParamsToR3;
    result:=1;
  end else
    result:=0;

  //2012.03.05 Add�Զ����ɵ�������(����ȷ��):
  if ReadBool('PARAMS','CREATE_ORDER_MSG',False) then
    DownOrderMessage;
end;

//��Rim�����ۻ���ͬ������[single_sale_limit��sale_limit��IS_CHG_PRI]  Rim�ĵ�λ������R3��λ���У�Ĭ�Ϲ�ϵΪ:10;
function TParamsSyncFactory.CheckMessageExists(const OrderDay, ArrDay: string; var Title, s, Content, COMM_ID: string): Boolean;
var
  Qry: TZQuery;
  NotExist: Boolean;
  CurDay,ISSUE_DATE: string;
  Msg: string;  
begin             
  //1�����жϽ����Ƿ���������Ϣ��2��û��������Ϣ��������Ϣ���:Title��Source��Content;
  result:=False;
  if trim(ArrDay)='' then Exit;
  NotExist:=False;
  CurDay:=FormatDatetime('YYYYMMDD',Date()); //�������ڸ�ʽ��
  if OrderDay=CurDay then //��������
  begin
    COMM_ID:='MESSAGE_'+ArrDay;
    ISSUE_DATE:=CurDay;
  end else
  begin
    COMM_ID:='AUTODOWN_'+ArrDay;
    ISSUE_DATE:=OrderDay;
  end;

  Qry:=TZQuery.Create(nil);
  try
    Qry.SQL.Text:=
      'select count(*) as ReSum from MSC_MESSAGE A,MSC_MESSAGE_LIST B '+
      ' where A.TENANT_ID=B.TENANT_ID and A.MSG_ID=B.MSG_ID and A.TENANT_ID='+RimParam.TenID+' and B.SHOP_ID='''+RimParam.ShopID+''' and '+
      ' A.ISSUE_DATE='+ISSUE_DATE+' and A.COMM_ID='''+COMM_ID+''' ';
    if Open(Qry) then
    begin
      NotExist:=(Qry.FieldbyName('ReSum').AsInteger=0);
    end;
  finally
    Qry.Free;
  end;

  if (NotExist) and (ArrDay<>'') then
  begin
    if ArrDay=CurDay then //��������
    begin
      s := '֪ͨ';
      Title:=FormatDay(OrderDay)+'��������';          
      Content:='��<'+FormatDay(OrderDay)+'>���Ķ�����'+Content+'����Ԥ��<'+FormatDay(ArrDay)+'>�ʹ�뼰ʱ����ȷ�ϡ�';
      
      //Content:='��'+FormatDay(OrderDay)+'�Ķ�����Ԥ�ƽ����ʹ�뼰ʱ���е���ȷ�ϣ�лл������';
    end else
    begin
      if AUTO_DOWN_ORDER then
      begin
        s:='����֪ͨ';
        Title:=FormatDay(OrderDay)+'�Զ���������';
        Content:='��<'+FormatDay(OrderDay)+'>���Ķ�����'+Content+'����Ӧ����<'+FormatDay(ArrDay)+'>�ʹϵͳ���Դ˶��������Զ�����ȷ�ϡ�';

        //Content:='��'+FormatDay(OrderDay)+'�Ķ���������δ�����ֹ�����ȷ�ϣ�ϵͳ�������Զ�����ȷ�ϣ�����Ѿ�����ȷ�ϣ����Դ���Ϣ��лл������ ';
      end else
      begin
        s :='֪ͨ';
        Title:=FormatDay(OrderDay)+'��������';
        Content:='��<'+FormatDay(OrderDay)+'>���Ķ�����'+Content+'����Ӧ����<'+FormatDay(ArrDay)+'>�ʹ�뼰ʱ����ȷ�ϡ�';

        //Content:='��'+FormatDay(OrderDay)+'�Ķ������뼰ʱ���е���ȷ�ϣ�����Ѿ�����ȷ�ϣ����Դ���Ϣ��лл������ ';
      end;
    end;
    result:=true;
  end;
end;

constructor TParamsSyncFactory.Create;
begin
  inherited;
  OrderQry:=TZQuery.Create(nil);
  UsedDateQry:=TZQuery.Create(nil);
  //��ȡ�Զ������ı�ǣ�Ĭ�ϲ�����
  AUTO_DOWN_ORDER:=trim(ReadConfig('PARAMS','AUTO_DOWN_ORDER','0'))='1';  
end;

destructor TParamsSyncFactory.Destroy;
begin
  OrderQry.Free;
  UsedDateQry.Free;
  inherited;
end;

function TParamsSyncFactory.DoShopDownOrderMessage: integer;
var
  iRet,vCount: integer;
  mid,s,Title,Content,ISSUE_DATE: string; //��Ϣ���ݺ�
  CurDay,ArrDay,EndDay,OrderDay,Str,COMM_ID: string; //��������
begin
  result:=-1;
  try
    vCount:=0;
    CurDay:=FormatDatetime('YYYYMMDD',Date());
    EndDay:=FormatDatetime('YYYY-MM-DD',Date()+7); //��Ч���ڸ�ʽ��
    GetINDEOrderList;
    OrderQry.First;
    while not OrderQry.Eof do
    begin
      mid:= TBaseSyncFactory.newid(RimParam.ShopID);
      ArrDay:=trim(OrderQry.FieldByName('ARR_DATE').AsString);
      OrderDay:=trim(OrderQry.FieldByName('CRT_DATE').AsString);
      if ArrDay=FormatDatetime('YYYYMMDD',Date()) then //��������
        ISSUE_DATE:=FormatDatetime('YYYYMMDD',Date())  
      else
        ISSUE_DATE:=OrderDay;
      Content:='Ʒ�֣�'+InttoStr(OrderQry.fieldbyName('PZSUM').asInteger)+'��'+
               '������'+FormatFloat('#0.00',OrderQry.fieldbyName('QTY_SUM').asFloat)+'����'+
               '�ܽ�'+FormatFloat('#0.00',OrderQry.fieldbyName('AMT_SUM').asFloat)+' ';
      
      if CheckMessageExists(OrderDay,ArrDay, Title, s, Content,COMM_ID) then
      begin
        BeginTrans;
        try
          str:='insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP)'+
               ' values('+RimParam.TenID+','''+mid+''','''+RimParam.ShopID+''',1,1,''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GetLastError);

          str:='insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP)'+
               ' values('+RimParam.TenID+','''+mid+''',''0'','+ISSUE_DATE+','+RimParam.TenID+','''+s+''',''system'','''+Title+''','''+Content+''','''+EndDay+''','''+COMM_ID+''',''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GetLastError);
          CommitTrans;
          Inc(vCount);
        except
          on E:Exception do
          begin
            RollbackTrans;
            Raise;
          end;
        end;
      end; 
      OrderQry.Next;
    end; //while not OrderQry.Eof do
    result:=vCount;
  except
    on E:Exception do
    begin
      Raise;
    end;
  end;
end;

function TParamsSyncFactory.DownOrderMessage: integer;
var
  iRet: integer; //����������Ϣ 
  ErrorFlag: Boolean;
  SaveLog: TStringList;
begin
  result:=-1;
  {------��ʼ��־������Ϣ------}
  BeginLogReport;
  try
    DBLock(true); //�������ݿ�����

    //����R3����ҵ�������ڣ�
    GetR3UsedDateList;
    //����R3��������Ϣ��ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      FRunInfo.ErrorStr:='<'+PlugInID+'> <'+RimParam.TenID+'> û�п����ɵ���ȷ����Ϣ�ŵ�(�˳�)��';
      result:=0;
      Exit;
    end;

    //���ŵ�ID����ѭ���ϱ�
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      RimParam.CustID:='';
      try
        ErrorFlag:=False;
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);   //R3��ҵID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString); //R3��ҵ���� (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);     //R3�ŵ�ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);  //R3�ŵ����� (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString);  //R3�ŵ����֤�� (Field: LICENSE_CODE)
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID);  //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;

        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          BeginLogShopReport; //��ʼ�ŵ���־

          //��ʼ���ɵ�����Ϣ
          try
            iRet:=DoShopDownOrderMessage; //����������Ϣ��
            AddBillMsg('������Ϣ',iRet);
          except
            on E:Exception do
            begin
              ErrorFlag:=true;
              AddBillMsg('������Ϣ',-1,E.Message);
            end;
          end;
          EndLogShopReport(true,ErrorFlag); //д���ŵ������������
        end else
          EndLogShopReport(False);  //д���ŵ��Ӧ������־
      except
        on E:Exception do
        begin
          WriteLogFile(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
    result:=1;
  finally
    DBLock(False);
    WriteToReportLogFile('������Ϣ');  //������ı���־
  end;
end;

function TParamsSyncFactory.DownRimParamsToR3: Boolean;
var
  IsRun: Boolean;
  iRet: integer;
  CustCnd,UpCnd,Msg: string; //�ŵ��ϱ�����
  Str,COM_ID,CHANGE_PRICE,CHGCnd: string;
begin
  Str:='';
  UpCnd:='';
  CustCnd:='';
  COM_ID:=GetRimCOM_ID(trim(Params.ParamByName('TENANT_ID').AsString));

  if SyncType=3 then //�ŵ�ͬ��[ֻͬ�����ŵ�]
  begin
    CustCnd:=' and C.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' and C.SHOP_ID='''+Params.ParamByName('SHOP_ID').AsString+''' ';
    UpCnd:=' and A.RELATI_ID='+Params.ParamByName('TENANT_ID').AsString+' ';
  end else
    UpCnd:=' and A.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' ';

  {Rim:1:����     0:������  R3: 1:��ҵ��� 2: ͳһ���� }
  case DbType of
   1: CHANGE_PRICE:='DECODE(IS_CHG_PRI,''0'',''2'',''1'')';
   4: CHANGE_PRICE:='(case when IS_CHG_PRI=''0'' then ''2'' else ''1'' end)';
  end;
  CHGCnd:=ParseSQL(DbType,'(nvl(A.SINGLE_LIMIT,0)<>nvl(B.single_sale_limit,0)*10.0)or(nvl(A.SALE_LIMIT,0)<>nvl(B.sale_limit,0)*10.0)or(A.CHANGE_PRICE<>'+CHANGE_PRICE+')');
  Str:=
    'update CA_RELATIONS A '+
    ' set (SINGLE_LIMIT,SALE_LIMIT,CHANGE_PRICE,TIME_STAMP)='+
        '(select distinct single_sale_limit*10.0,sale_limit*10.0,'+CHANGE_PRICE+' as IS_CHG_PRI,'+GetTimeStamp(DbType)+' as TIME_STAMP '+
        ' from RM_CUST B,CA_SHOP_INFO C '+
        ' where B.LICENSE_CODE=C.LICENSE_CODE and A.RELATI_ID=C.TENANT_ID '+CustCnd+' and ('+CHGCnd+')) '+
    ' where A.RELATION_STATUS=''2'' and A.RELATION_ID='+InttoStr(NT_RELATION_ID)+' '+UpCnd+
    ' and A.RELATI_ID in (select C.TENANT_ID from RM_CUST B,CA_SHOP_INFO C where B.LICENSE_CODE=C.LICENSE_CODE '+CustCnd+' and ('+CHGCnd+'))';

  try
    BeginLogReport; //��ʼ�ϱ���־
    try
      if COM_ID<>'' then
      begin
        IsRun:=ExecTransSQL(Str,iRet,'����Rim���ۻ��޼���������');
        if IsRun and (SyncType<>3) then //������д��־
        begin
          FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick;  //��ִ�ж�����
          Msg:='---- RSP���ȡ�Rim���ۻ��޼��������� ͬ����'+InttoStr(iRet)+'�ʣ�����'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'��-------';
        end;
      end else
      begin
        if SyncType<>3 then Msg:='---- RSP���ȡ�Rim���ۻ��޼��������� ����: û�ҵ���ӦRim.COM_ID��-------'; //д��[REPORT]
        WriteLogFile('<Rim���ۻ��޼�������> ����: û�ҵ���ӦRim.COM_ID��'); 
      end;
    except
      on E:Exception do
      begin
        Msg:='---- RSP���ȡ�Rim���ۻ��޼��������� ͬ������'+E.Message+'����-------';
        WriteLogFile(Msg);
      end;    
    end;
  finally
    WriteDownLoadToReportLog(Msg); //д��REPORT�ļ�
  end;
end;

function TParamsSyncFactory.FormatDay(InDay: string): string;
var
  CurValue: string;
begin
  result:=Copy(InDay,1,4)+'��';
  CurValue:=Copy(InDay,5,2);
  CurValue:=InttoStr(StrtoIntDef(CurValue,0)); //�·�
  result:=result+CurValue+'��';
  CurValue:=Copy(InDay,7,2);
  CurValue:=InttoStr(StrtoIntDef(CurValue,0)); //����
  result:=result+CurValue+'��';
end;

function TParamsSyncFactory.GetINDEOrderList: Boolean;
var
  iRet: integer;
  Str,NearDate,UseDate,CurDay: string;
begin
  result:=False;
  CurDay:=FormatDatetime('YYYYMMDD',Date());
  NearDate:=FormatDatetime('YYYYMMDD',Date()-7); //��ȡ���7��Ķ�������
  //����ϵͳ���������ж�
  if UsedDateQry.Active then
  begin
    if UsedDateQry.Locate('TENANT_ID',trim(RimParam.TenID),[]) then
    begin
      UseDate:=trim(UsedDateQry.FieldbyName('USING_DATE').AsString);
      UseDate:=FormatDatetime('YYYYMMDD',FnTime.fnStrtoDate(UseDate));
    end;
  end;
  if trim(UseDate)='' then UseDate:=FormatDatetime('YYYYMMDD',Date());  //����Ĭ�Ͻ���
  if NearDate<UseDate then NearDate:=UseDate; //�Աȱ��������ڻ�С����������ڿ�ʼȡ��Ϣ

  try                   
    Str:='select A.ARR_DATE,A.CRT_DATE,sum(B.QTY_ORD) as QTY_SUM,sum(B.AMT) as AMT_SUM,Count(distinct B.ITEM_ID) as PZSUM '+
         ' from RIM_SD_CO A,RIM_SD_CO_LINE B where A.CO_NUM=B.CO_NUM and A.COM_ID='''+RimParam.ComID+''' and A.CUST_ID='''+RimParam.CustID+''' and '+
         ' A.STATUS in (''05'',''06'') and A.ARR_DATE<='''+CurDay+''' and A.ARR_DATE>='''+NearDate+''' and '+
         ' not A.CO_NUM in(select COMM_ID from STK_STOCKORDER where TENANT_ID='+RimParam.TenID+' and COMM_ID is not null and COMM not in (''02'',''12'') )'+
         ' Group by A.ARR_DATE,A.CRT_DATE ';
    OrderQry.close;
    OrderQry.SQL.Text:=Str;
    Open(OrderQry);
    result:=OrderQry.Active;
  except
    on E:Exception do
    begin
      Raise;
    end;
  end;
end;

function TParamsSyncFactory.GetR3UsedDateList: Boolean;
var
  Str: string;
begin
  result:=False;
  //��Ӧ����ϵ��[���ش�����ҵ�����¼���ҵ]:
  Str:=
    'select A.TENANT_ID as TENANT_ID,A.VALUE as USING_DATE from SYS_DEFINE A,CA_RELATIONS R '+
    ' where A.TENANT_ID=R.RELATI_ID and R.RELATION_ID=1000006 and A.COMM not in (''02'',''12'') and A.DEFINE=''USING_DATE'' and '+
    ' R.COMM not in (''02'',''12'') and R.TENANT_ID='+Params.ParamByName('TENANT_ID').AsString+' ';

  UsedDateQry.Close;
  UsedDateQry.SQL.Text:=Str;
  result:=Open(UsedDateQry);
end;

procedure TParamsSyncFactory.WriteDownLoadToReportLog(LogMsg: string);
var
  LogFile: string;
  LogFileList: TStringList;
begin
  if SyncType=3 then Exit; //ǰִ̨�в�д��־
  try
    LogFile := ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT'+FormatDatetime('YYYYMMDD',Date())+'.log';
    LogFileList:=TStringList.Create;
    if FileExists(LogFile) then
    begin
      LogFileList.LoadFromFile(LogFile);
      LogFileList.Add('    ');
    end;
    LogFileList.Add(LogMsg);
    LogFileList.SaveToFile(LogFile);
  finally
    LogFileList.Free;
  end;
end;

end.















