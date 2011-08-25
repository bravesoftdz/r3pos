{-------------------------------------------------------------------------------
  //��Ϣͬ��
 ------------------------------------------------------------------------------}

unit uMsgFactory;

interface

uses
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TMsgSyncFactory=class(TRimSyncFactory)
  private
    AUTO_DOWN_ORDER: Boolean;  //�Զ�����ȷ�ϣ�Ĭ�ϲ��Զ�����
    //��������
    UsedDateQry: TZQuery;
    //���ض�����ͷ
    OrderQry: TZQuery;

    //����ͬ������
    function GetSyncType: integer; override; //ͬ������     

    //ͬ����Ա��tid ��ҵ��
    function SyncMessage: Boolean;

    //��ʽ����
    function FormatDay(InDay: string): string;
    //����R3��ҵ���������б�
    function GetR3UsedDateList: Boolean;
    //����һ���ŵ�Ķ���
    function GetINDEOrderList: Boolean;
    //�ж��Ƿ��Ѵ��ڣ���������Ϣ����
    function CheckMessageExists(const ArrDay: string; var Title, s, Content: string): Boolean;
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

{ TMsgSyncFactory }

constructor TMsgSyncFactory.Create;
begin
  inherited;
  OrderQry:=TZQuery.Create(nil);
  UsedDateQry:=TZQuery.Create(nil);
end;

destructor TMsgSyncFactory.Destroy;
begin
  OrderQry.Free;
  UsedDateQry.Free;
  inherited;
end;

//tid ��ҵ��; sid �ŵ��
function TMsgSyncFactory.SyncMessage: Boolean;
var
  iRet:integer;
  str,s,mid: string;
  rs: TZQuery;
begin
  result:=False;
  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    case DbType of
    4:
     rs.SQL.Text :=
       'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and '+
       '('+
       ' (POSSTR(RECEIVER,'''+RimParam.CustID+','')>0) or ('+
       ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+RimParam.CustID+''') or slsman_id is null or slsman_id='''') '+
       ' and (saleorg_id in (select saleorg_id from rm_cust where cust_id='''+RimParam.CustID+''') or saleorg_id is null or saleorg_id='''') '+       ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+RimParam.CustID+''') or sale_center_id is null or sale_center_id='''') '+       ' and (receiver is null or receiver =''''  or receiver ='','') '+       ' )'+       ')'+       'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
       'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+RimParam.ShopID+''' and B.TENANT_ID='+RimParam.TenID+' and B.COMM_ID=A.MSG_ID)';
    1:
     rs.SQL.Text :=
       'select MSG_ID,TYPE,INVALID_DATE from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and '+
       '('+
       ' (INSTR(RECEIVER,'''+RimParam.CustID+','')>0) or ('+
       ' (slsman_id in (select slsman_id from rm_cust where cust_id='''+RimParam.CustID+''') or slsman_id is null or slsman_id='''') '+
       ' and ( saleorg_id in (select saleorg_id from rm_cust where cust_id='''+RimParam.CustID+''') or saleorg_id is null or saleorg_id='''') '+       ' and (sale_center_id in (select sale_center_id from rm_cust where cust_id='''+RimParam.CustID+''') or sale_center_id is null or sale_center_id='''') '+       ' and (receiver is null or receiver =''''  or receiver ='','') '+       ' )'+
       ')'+
       'and STATUS=''02'' and RECEIVER_TYPE=''2'' and USE_DATE>='''+formatDatetime('YYYYMMDD',Date()-30)+''' and invalid_date>='''+formatDatetime('YYYYMMDD',Date())+''' '+
       'and not Exists(select * from MSC_MESSAGE B,MSC_MESSAGE_LIST C where B.TENANT_ID=C.TENANT_ID and B.MSG_ID=C.MSG_ID and C.SHOP_ID='''+RimParam.ShopID+''' and B.TENANT_ID='+RimParam.TenID+' and B.COMM_ID=A.MSG_ID)';
    end;
    if Open(Rs) then
    begin
      rs.First;
      while not rs.Eof do
      begin
        BeginTrans;
        try
          mid:= TBaseSyncFactory.newid(RimParam.ShopID);
          str:='insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP) '+
               'values('+RimParam.TenID+','''+mid+''','''+RimParam.ShopID+''',1,1,''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(str),iRet) <>0 then Raise Exception.Create(GPlugIn.GetLastError);

          if rs.Fields[1].asString='01' then
             s := '������Ϣ'
          else
          if rs.Fields[1].asString='02' then
             s := '�����Ϣ'
          else
          if rs.Fields[1].asString='03' then
             s := '��Դ��Ϣ'
          else
          if rs.Fields[1].asString='04' then
             s := '��Ʒ��Ϣ'
          else
          if rs.Fields[1].asString='05' then
             s := '֪ͨ'
          else
          if rs.Fields[1].asString='99' then
             s := '����֪ͨ'
          else
             s := '����';
          case DbType of
           4:str :=
              'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
              'select '+RimParam.TenID+','''+mid+''',''0'',int(USE_DATE),'+RimParam.TenID+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(DbType)+
              ' from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
           1:str :=
              'insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP) '+
              'select '+RimParam.TenID+','''+mid+''',''0'',to_number(USE_DATE),'+RimParam.TenID+','''+s+''',''system'',TITLE,CONTENT,'''+formatDatetime('YYYY-MM-DD',fnTime.fnStrtoDate(rs.Fields[2].asString) )+''','''+rs.Fields[0].asString+''',''00'','+GetTimeStamp(DbType)+
              ' from RIM_MESSAGE A where COM_ID='''+RimParam.ComID+''' and MSG_ID='''+rs.Fields[0].asString+''' ';
          end;
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GPlugIn.GetLastError);
          CommitTrans;
        except
          on E:Exception do
          begin
            RollbackTrans;
            WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'13','������Ϣ����','02'); //д��־
            Raise
          end;
        end;
        rs.Next;
      end;
    end;
    result:=true;
  finally
    rs.Free;
  end;
end;

function TMsgSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  result:=-1;
  PlugInID:='803';
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType; //����ͬ�����ͱ��
  if SyncType=3 then //ǰ̨�������
  begin
    try
      DBLock(true);
      if Params.FindParam('SHOP_ID')=nil then Params.ParambyName('SHOP_ID').asString := Params.ParambyName('TENANT_ID').asString+'0001';
      RimParam.TenID  :=trim(Params.ParambyName('TENANT_ID').asString);   //R3��ҵID (Field: TENANT_ID)
      RimParam.ShopID :=trim(Params.ParambyName('SHOP_ID').asString);     //R3�ŵ�ID (Field: SHOP_ID)
      SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID);  //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;
      if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
      begin
        SyncMessage;
        result:=0;
      end;
    finally
      DBLock(False); 
    end;
  end else  //Rsp����ִ��
  begin
    DownOrderMessage;
  end;
end;

function TMsgSyncFactory.GetSyncType: integer;
begin
  result:=0;
  SyncType:=0;
  if (Params.FindParam('SHOP_ID')<>nil) then
  begin
    if Length(Params.FindParam('SHOP_ID').AsString)>10 then
      SyncType:=3;
  end;
  result:=SyncType;
  ShopLog.SyncType:=result;
end;

function TMsgSyncFactory.FormatDay(InDay: string): string;
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

function TMsgSyncFactory.GetR3UsedDateList: Boolean;
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

function TMsgSyncFactory.GetINDEOrderList: Boolean;
var
  iRet: integer;
  Str,NearDate,UseDate,CurDay: string;
begin
  result:=False;
  CurDay:=FormatDatetime('YYYYMMDD',Date());
  NearDate:=FormatDatetime('YYYYMMDD',Date()-7); //��ȡ���7��Ķ�������
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
    Str:='select distinct ARR_DATE,CRT_DATE from RIM_SD_CO where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and '+
         ' STATUS in (''05'',''06'') and ARR_DATE<='''+CurDay+''' and ARR_DATE>='''+NearDate+''' and '+
         ' not CO_NUM in(select COMM_ID from STK_STOCKORDER where TENANT_ID='+RimParam.TenID+' and COMM_ID is not null and COMM not in (''02'',''12'') )'+
         ' order by ARR_DATE ';
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

function TMsgSyncFactory.CheckMessageExists(const ArrDay: string; var Title, s, Content: string): Boolean;
var
  Qry: TZQuery;
  NotExist: Boolean;
  CurDay,COMM_ID: string;  
begin
  //1�����жϽ����Ƿ���������Ϣ��2��û��������Ϣ��������Ϣ���:Title��Source��Content;
  result:=False;
  NotExist:=False;
  CurDay:=FormatDatetime('YYYYMMDD',Date()); //�������ڸ�ʽ��
  COMM_ID:='AUTODOWN'+ArrDay+'_'+CurDay;
  Qry:=TZQuery.Create(nil);
  try
    Qry.SQL.Text:=
      'select count(*) as ReSum from MSC_MESSAGE A,MSC_MESSAGE_LIST B '+
      ' where A.TENANT_ID=B.TENANT_ID and A.MSG_ID=B.MSG_ID and A.TENANT_ID='+RimParam.TenID+' and B.SHOP_ID='''+RimParam.ShopID+''' and '+
      ' A.ISSUE_DATE='+CurDay+' and A.END_DATE='''+CurDay+''' and A.COMM_ID='''+COMM_ID+''' ';
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
      Title:='��������';
      Content:='��'+FormatDay(ArrDay)+'�Ķ�����Ԥ�ƽ����ʹ�뼰ʱ���е���ȷ�ϣ�лл������';
    end else
    begin
      if AUTO_DOWN_ORDER then
      begin
        s:='����֪ͨ';
        Title:='�Զ���������';
        Content:='��'+FormatDay(ArrDay)+'�Ķ���������δ�����ֹ�����ȷ�ϣ�ϵͳ�������Զ�����ȷ�ϣ�����Ѿ�����ȷ�ϣ����Դ���Ϣ��лл������ ';
      end else
      begin
        s := '֪ͨ';
        Title:='��������';
        Content:='��'+FormatDay(ArrDay)+'�Ķ������뼰ʱ���е���ȷ�ϣ�����Ѿ�����ȷ�ϣ����Դ���Ϣ��лл������ ';
      end;
    end;
    result:=true;
  end;
end;

function TMsgSyncFactory.DoShopDownOrderMessage: integer;
var
  iRet,vCount: integer;
  mid,s,Title,Content: string; //��Ϣ���ݺ�
  CurDay,ArrDay,OrderDay,Str,COMM_ID: string; //��������
begin
  result:=-1;
  try
    vCount:=0;
    CurDay:=FormatDatetime('YYYYMMDD',Date());
    GetINDEOrderList;
    OrderQry.First;
    while not OrderQry.Eof do
    begin
      mid:= TBaseSyncFactory.newid(RimParam.ShopID);
      ArrDay:=trim(OrderQry.FieldByName('ARR_DATE').AsString);
      OrderDay:=trim(OrderQry.FieldByName('CRT_DATE').AsString);
      COMM_ID:='AUTODOWN'+ArrDay+'_'+CurDay;
      if CheckMessageExists(ArrDay, Title, s, Content) then
      begin
        BeginTrans;
        try
          str:='insert into MSC_MESSAGE_LIST(TENANT_ID,MSG_ID,SHOP_ID,MSG_FEEDBACK_STATUS,MSG_READ_STATUS,COMM,TIME_STAMP)'+
               ' values('+RimParam.TenID+','''+mid+''','''+RimParam.ShopID+''',1,1,''00'','+GetTimeStamp(DbType)+')';
          if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create(GetLastError);

          str:='insert into MSC_MESSAGE(TENANT_ID,MSG_ID,MSG_CLASS,ISSUE_DATE,ISSUE_TENANT_ID,MSG_SOURCE,ISSUE_USER,MSG_TITLE,MSG_CONTENT,END_DATE,COMM_ID,COMM,TIME_STAMP)'+
               ' values('+RimParam.TenID+','''+mid+''',''0'','+OrderDay+','+RimParam.TenID+','''+s+''',''system'','''+Title+''','''+Content+''','''+CurDay+''','''+COMM_ID+''',''00'','+GetTimeStamp(DbType)+')';
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

function TMsgSyncFactory.DownOrderMessage: Integer;
var
  iRet: integer; //����������Ϣ 
  ErrorFlag: Boolean; 
begin
  result:=-1;
  //��ȡ�Զ������ı�ǣ�Ĭ�ϲ�����
  AUTO_DOWN_ORDER:=trim(ReadConfig('PARAMS','AUTO_DOWN_ORDER','0'))='1';

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


end.















