{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uSalesTotalFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs,Forms, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory, uRimSyncFactory;

type
  TSalesTotalSyncFactory=class(TRimSyncFactory)
  private
    //��Rim�����ۻ���ͬ������[single_sale_limit��sale_limit��IS_CHG_PRI]
    function DownRimParamsToR3: Boolean;
    //�ϱ���̨��
    function SendDaySaleTotal(vRimParam: TRimParams): integer;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;
 
implementation

{ TSalesTotalSyncFactory }

function TSalesTotalSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  RimParam: TRimParams;
  R3ShopList: TZQuery;
begin
  result:=-1;
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType;  //����ͬ�����ͱ��

  {------��ʼ������־------}
  BeginLogRun;
  R3ShopList := TZQuery.Create(nil);
  try
    DBLock(true);  //�������ݿ����� 
    //����R3���ϱ�ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      FRunInfo.ErrorStr:='��ҵID('+RimParam.TenID+')û�ж�Ӧ���ϱ��ŵ�(�ϱ��˳�ִ��)��';
      result:=0;
      Exit;
    end;

    //���ŵ�ID����ѭ���ϱ�
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      RimParam.CustID:='';
      try
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);   //R3��ҵID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString); //R3��ҵ���� (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);     //R3�ŵ�ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);  //R3�ŵ����� (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString);  //R3�ŵ����֤�� (Field: LICENSE_CODE)
        //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID); //�����̲ݹ�˾ComID�����ۻ�CustID

        //if RimParam.ComID='' then Raise Exception.Create('R3������ҵID��'+RimParam.TenID+' - '+RimParam.TenName+'����RIM��û�ҵ���Ӧ��COM_IDֵ...');
        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          LogInfo.BeginLog(RimParam.TenName+'-'+RimParam.ShopName); //��ʼ��־
          //��ʼ�ϱ������ۻ��ܣ�
          iRet:=SendDaySaleTotal(RimParam); 
          LogInfo.AddBillMsg('�����ۻ���',iRet);

          if R3ShopList.RecordCount=1 then
            LogInfo.SetLogMsg(LogList)  //��ӱ���ִ����־
          else
            LogInfo.SetLogMsg(LogList, R3ShopList.RecNo);  //��ӱ���ִ����־
          if iRet=-1 then
            Inc(FRunInfo.ErrorCount)
          else
            Inc(FRunInfo.RunCount);
        end else
        begin
          Inc(FRunInfo.NotCount);  //��Ӧ����
          LogList.Add('   �ŵ�('+RimParam.TenName+'-'+RimParam.ShopName+')���֤��'+RimParam.LICENSE_CODE+' ��Rimϵͳ��û��Ӧ�����ۻ���'); 
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          //AddLogMsg(0,'R3�ŵ�:'+RimParam.ShopID+' ��'+RimParam.ShopName+' ���֤��'+RimParam.LICENSE_CODE+' �ϱ�����'+'  '+E.Message);
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //���ŵ���
    DBLock(False);
    R3ShopList.Free;
    if SyncType<>3 then  //�������в�д��־
      WriteLogRun('�����ۻ���');  //������ı���־ 
  end;
end;

//��Rim�����ۻ���ͬ������[single_sale_limit��sale_limit��IS_CHG_PRI]
function TSalesTotalSyncFactory.DownRimParamsToR3: Boolean;
var
  iRet: integer;
  Str,COM_ID,RimCust,LogFile: string;
  LogFileList: TStringList;
begin
  COM_ID:=GetRimCOM_ID(trim(Params.ParamByName('TENANT_ID').AsString));
  RimCust:='(select distinct TENANT_ID,single_sale_limit,sale_limit,IS_CHG_PRI from RM_CUST AA,CA_SHOP_INFO BB '+
           ' where AA.LICENSE_CODE=BB.LICENSE_CODE and AA.COM_ID='''+COM_ID+''') ';
  str:='update CA_RELATIONS A '+
       ' set (SINGLE_LIMIT*10.0,SALE_LIMIT*10.0,CHANGE_PRICE,TIME_STAMP)='+
            '(select single_sale_limit,sale_limit,IS_CHG_PRI,'+GetTimeStamp(DbType)+' as TIME_STAMP from '+RimCust+' B where A.RELATI_ID=B.TENANT_ID) '+
       ' where A.RELATION_ID='+InttoStr(NT_RELATION_ID)+' and exists(select 1 from '+RimCust+' B where A.RELATI_ID=B.TENANT_ID)  ';

  {------��ʼ������־------}
  BeginLogRun;
  if PlugIntf.ExecSQL(Pchar(str),iRet)<>0 then
    Raise Exception.Create('����Rim���ۻ��ļ���������������'+PlugIntf.GetLastError);

  if SyncType<>3 then
  begin
    try
      LogFile := ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT'+FormatDatetime('YYYYMMDD',Date())+'.log';
      LogFileList:=TStringList.Create;
      if FileExists(LogFile) then
      begin
        LogFileList.LoadFromFile(LogFile);
        LogFileList.Add('    ');
      end;
      FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick;  //��ִ�ж�����
      Str:='     ����Rim���ۻ�����   ��ִ��'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'�룬������'+InttoStr(iRet)+'�� ';
      {if SyncType=3 then
      begin
        LogFileList.Add('------------- R3�ն�ͬ�� ��Rim���ۻ����������� ---------------------');
        LogFileList.Add(Str);
        LogFileList.Add('  ');
      end else }
      begin
        LogFileList.Add('------------- RSP����ͬ����Rim�޼���������-----------------------');
        LogFileList.Add(Str);
        LogFileList.Add('  ');
        LogFileList.Add('------------- RSP����ͬ�������н�����-----------------------');
      end;
    finally
      LogFileList.SaveToFile(LogFile);
    end;
  end;
end;

function TSalesTotalSyncFactory.SendDaySaleTotal(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer;  //����ExeSQLӰ������м�¼
  Session: string;       //sessionǰ׺
  Str, Short_ID: string; //�ŵ����λ����
  CndTab,         //������
  SalesTab,       //������ͼ
  SaleDetail,     //������ϸ��
  SALES_DATE,     //ָ���ϱ�����
  vSALES_DATE: string;     //��������[ת���ַ�]
begin
  result := -1;
  iRet:=0;
  UpiRet:=0;
  Short_ID:=Copy(vRimParam.ShopID,Length(vRimParam.ShopID)-3,4);

  //�������ۻ����ϴ����ʱ����͵�ǰʱ���:
  MaxStmp:=GetMaxNUM('10',vRimParam.ComID,vRimParam.CustID,vRimParam.ShopID);
  //������̨����ʱ[INF_RECKDAY]:
  case DbType of
   1:
    begin
      Session:='';
      vSALES_DATE:='to_char(A.SALES_DATE)';    //̨������ ת�� varchar
    end;
   4:
    begin
      Session:='session.';
      vSALES_DATE:='trim(char(A.SALES_DATE))';   //̨������ ת�� varchar
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALESUM( '+
             ' TENANT_ID INTEGER NOT NULL,'+     //R3��ҵID
             ' SHOP_ID VARCHAR(20) NOT NULL,'+   //R3�ŵ�ID
             ' SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3�ŵ�ID����λ
             ' COM_ID VARCHAR(30) NOT NULL,'+    //RIM�̲ݹ�˾ID
             ' CUST_ID VARCHAR(30) NOT NULL,'+   //RIM���ۻ�ID
             ' ITEM_ID VARCHAR(30) NOT NULL,'+   //RIM��ƷID
             ' GODS_ID CHAR(36) NOT NULL,'+      //R3��ƷID
             ' SALES_DATE  VARCHAR(8) NOT NULL,'+  //��������
             ' UNIT_ID CHAR(36) NOT NULL,'+       //��λID
             ' QTY_ORD DECIMAL (18,6),'+         //̨����������
             ' AMT DECIMAL (18,6),'+             //̨�����۽��
             ' CO_NUM VARCHAR(30) NOT NULL '+    //���ݺ�[̨������ + ���ۻ�ID+ R3_�ŵ�ID��4λ]
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������ʱ��INF_SALESUM����:'+PlugIntf.GetLastError);
    end;
  end;

  //��һ��: ����ʱ�����̨�ʲ�����ʱ��:
  //������: ���ݴ���������ָ�����ڷ��ض�Ӧ�ŵ꼰������Ҫ�ϱ�����:
  CndTab:='select distinct TENANT_ID,SHOP_ID,SALES_DATE from SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' ';
  SALES_DATE:='';
  if Params.findParam('SALES_DATE')<>nil then SALES_DATE:=Params.findParam('SALES_DATE').AsString;
  if SALES_DATE='' then
    CndTab:=CndTab+' and TIME_STAMP>'+MaxStmp+' '
  else
    CndTab:=CndTab+' and ((TIME_STAMP>'+MaxStmp+')or(SALES_DATE='+SALES_DATE+'))'; //ǰ̨��������
                   
  SalesTab:=
    'select M.TENANT_ID,M.SHOP_ID,S.GODS_ID,M.SALES_DATE,sum(S.CALC_AMOUNT) as CALC_AMOUNT,sum(S.CALC_MONEY) as CALC_MONEY '+
    ' from SAL_SALESORDER M,SAL_SALESDATA S,('+CndTab+') C '+
    ' where M.TENANT_ID=S.TENANT_ID and M.SALES_ID=S.SALES_ID and M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and '+
    ' M.SALES_DATE=C.SALES_DATE and M.SALES_TYPE in (1,3,4) and M.COMM not in (''02'',''12'') and M.TENANT_ID='+vRimParam.TenID+' and M.SHOP_ID='''+vRimParam.ShopID+''' '+
    ' group by M.TENANT_ID,M.SHOP_ID,M.SALES_DATE,S.GODS_ID';

  if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_SALESUM'),iRet)<>0 then Raise Exception.Create('ɾ���м�����:'+PlugIntf.GetLastError);
  Str:='insert into '+Session+'INF_SALESUM(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_ID,SALES_DATE,QTY_ORD,AMT,CO_NUM) '+
    'select A.TENANT_ID,A.SHOP_ID,'''+Short_ID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,B.UNIT_ID,'+vSALES_DATE+' as SALES_DATE,'+
    ' (case when '+GetDefaultUnitCalc+'<>0 then A.CALC_AMOUNT/('+GetDefaultUnitCalc+') else A.CALC_AMOUNT end) as SALE_AMT,A.CALC_MONEY,('+vSALES_DATE+' || ''_'' || '''+vRimParam.CustID+''' ||''_'' || '''+Short_ID+''') as CO_NUM '+
    ' from ('+SalesTab+')A,VIW_GOODSINFO B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������ۻ����м�����:'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
  end;
  //������: ÿһ��ִ����Ϊһ�������ύ
  try
    BeginTrans;
    //1��ɾ��������ʷ����(��ɾ��������ɾ����ͷ):
    Str:='delete from RIM_RETAIL_CO_LINE A '+
         ' where exists(select B.CO_NUM from RIM_RETAIL_CO B,'+Session+'INF_SALESUM C '+
                      ' where B.COM_ID=C.COM_ID and B.CUST_ID=C.CUST_ID and B.PUH_DATE=C.SALES_DATE and B.COM_ID='''+vRimParam.ComID+'''and B.TERM_ID='''+Short_ID+''' and B.CUST_ID='''+vRimParam.CustID+''' and A.CO_NUM=B.CO_NUM)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�����۱������'+PlugIntf.GetLastError);
    Str:='delete from RIM_RETAIL_CO A where exists(select 1 from '+Session+'INF_SALESUM B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.PUH_DATE=B.SALES_DATE) and A.COM_ID='''+vRimParam.ComID+''' and A.TERM_ID='''+Short_ID+''' and A.CUST_ID='''+vRimParam.CustID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�����۱�ͷ����'+PlugIntf.GetLastError);

    //2������������̨��(�Ȳ��ͷ�ڲ������):
    Str:='insert into RIM_RETAIL_CO(CO_NUM,CUST_ID,COM_ID,TERM_ID,PUH_DATE,STATUS,PUH_TIME,UPD_DATE,UPD_TIME,QTY_SUM,AMT_SUM) '+
         'select CO_NUM,CUST_ID,COM_ID,SHORT_SHOP_ID,SALES_DATE,''01'' as STATUS,'''+TimetoStr(time())+''','''+FormatDatetime('YYYYMMDD',Date())+''','''+TimetoStr(time())+''',sum(QTY_ORD) as QTY_SUM,sum(AMT) as AMT_SUM '+
         ' from '+Session+'INF_SALESUM group by COM_ID,CUST_ID,SHORT_SHOP_ID,CO_NUM,SALES_DATE';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������۱�ͷ[RIM_RETAIL_CO]����:'+PlugIntf.GetLastError);
    UpiRet:=iRet;

    Str:='insert into RIM_RETAIL_CO_LINE(CO_NUM,ITEM_ID,QTY_ORD,AMT,UM_ID) '+
         'select CO_NUM,ITEM_ID,QTY_ORD,AMT,'+GetR3ToRimUnit_ID(DbType,'UNIT_ID')+' as UNIT_ID from '+Session+'INF_SALESUM ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������۱���[RIM_RETAIL_CO_LINE]����:'+PlugIntf.GetLastError);

    //3�������ϱ�ʱ���:
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''10'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����ϱ�ʱ�������:'+PlugIntf.GetLastError);

    CommitTrans;  //�ύ����
    result:=UpiRet;
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'10','�ϱ������۴���','02'); //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
  //ִ�гɹ�д��־:
  WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'10','�ϱ������۳ɹ���','01');
end;

end.















