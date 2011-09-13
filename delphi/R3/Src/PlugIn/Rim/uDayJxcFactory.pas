{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uDayJxcFactory;

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
    function SendDaySaleTotal: integer;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;
 
implementation

{ TSalesTotalSyncFactory }

function TSalesTotalSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;
  ErrorFlag: Boolean;
begin
  result:=-1;
  PlugInID:='810';
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  //1���������ݿ�����
  GetDBType;
  //2����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  GetSyncType;  //����ͬ�����ͱ��

  try
    DBLock(true);  //�������ݿ�����

    //2011.06.12 Add��Rim���������޼ۡ������������ֵ
    DownRimParamsToR3;

    BeginLogRun; {------��ʼ������־------}
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
        ErrorFlag:=False;
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);   //R3��ҵID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString); //R3��ҵ���� (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);     //R3�ŵ�ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);  //R3�ŵ����� (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString);  //R3�ŵ����֤�� (Field: LICENSE_CODE)
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID);  //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;

        //if RimParam.ComID='' then Raise Exception.Create('R3������ҵID��'+RimParam.TenID+' - '+RimParam.TenName+'����RIM��û�ҵ���Ӧ��COM_IDֵ...');
        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          LogInfo.BeginLog(RimParam.ShopName); //��ʼ��־
          //��ʼ�ϱ��ս�������ܣ�
          try
            iRet:=SendDaySaleTotal;
            LogInfo.AddBillMsg('�ս��������',iRet);
          except
            on E:Exception do
            begin
              LogInfo.AddBillMsg('�ս��������',-1);
              WriteRunErrorMsg(E.Message);
              if not ErrorFlag then ErrorFlag:=true;
            end;
          end;

          //д��־LogList
          WriteToLogList(true, ErrorFlag);
        end else
          WriteToLogList(False); //��Ӧ�����ŵ�
      except
        on E:Exception do
        begin
          PlugIntf.WriteLogFile(Pchar('<810> <'+RimParam.ShopID+'>'+E.Message));
        end;
      end;
      R3ShopList.Next;
    end;
    result:=1;
  finally
    DBLock(False);
    if SyncType<>3 then  //�������в�д��־
    begin
      FRunInfo.AllCount:=R3ShopList.RecordCount;  //���ŵ���
      WriteLogRun('�ս��������');  //������ı���־
    end;
  end;
end;

//��Rim�����ۻ���ͬ������[single_sale_limit��sale_limit��IS_CHG_PRI]
//Rim�ĵ�λ������R3��λ���У�Ĭ�Ϲ�ϵΪ:10;
function TSalesTotalSyncFactory.DownRimParamsToR3: Boolean;
var
  IsRun: Boolean;
  iRet: integer;
  CustCnd,UpCnd,Msg: string; //�ŵ��ϱ�����
  Str,COM_ID,LogFile,CHANGE_PRICE,CHGCnd: string;
  LogFileList: TStringList;
begin
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
    ' and exists(select 1 from RM_CUST B,CA_SHOP_INFO C where B.LICENSE_CODE=C.LICENSE_CODE and A.RELATI_ID=C.TENANT_ID '+CustCnd+' and ('+CHGCnd+'))';

  try
    BeginLogRun; //��־
    try
      BeginTrans;  //��ʼ����
      if ExecSQL(Pchar(str),iRet)<>0 then Raise Exception.Create('����Rim���ۻ��޼�����������'+PlugIntf.GetLastError);
      IsRun:=CommitTrans; //�ύ����

      if IsRun and (SyncType<>3) then //������д��־
      begin
        FRunInfo.BegTick:=GetTickCount-FRunInfo.BegTick;  //��ִ�ж�����
        Msg:='---- RSP���ȡ�Rim���ۻ��޼��������� ͬ����'+InttoStr(iRet)+'�ʣ�����'+FormatFloat('#0.00',FRunInfo.BegTick/1000)+'��-------';
      end;
    except
      on E:Exception do
      begin
        RollbackTrans; //�ع�����
        Msg:='---- RSP���ȡ�Rim���ۻ��޼��������� ͬ������-------';
        PlugIntf.WriteLogFile(Pchar(Msg));
      end;    
    end;
  finally
    if SyncType<>3 then
    begin
      LogFile := ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT'+FormatDatetime('YYYYMMDD',Date())+'.log';
      LogFileList:=TStringList.Create;
      if FileExists(LogFile) then
      begin
        LogFileList.LoadFromFile(LogFile);
        LogFileList.Add('    ');
      end;
      LogFileList.Add(Msg); 
      LogFileList.SaveToFile(LogFile);
    end;
  end;
end;

function TSalesTotalSyncFactory.SendDaySaleTotal: integer;
var
  iRet,UpiRet: integer;  //����ExeSQLӰ������м�¼
  sql:string;
begin
  result := -1;
  iRet:=0;
  UpiRet:=0;
  BeginTrans;
  try
    sql := 'delete from INTERFACE.T_EBP_JOURNAL where CUSTOMERCODE='''+RimParam.CustID+''' and BDATE=current date';
    ExecSQL(Pchar(sql),iRet);

    sql :=
    'insert into INTERFACE.T_EBP_JOURNAL(BDATE,UPDATE_TIME,TAG,CUSTOMERCODE,CUSTOMERDESC,BARCODELOAF,INITQUANT,PURCHASEQUANT,SALESQUANT,SALESAMOUNT,INVENTORYQUANT,SALESPRICE) '+
    'select current date,current timestamp,''0'','''+RimParam.CustID+''','''+RimParam.ShopName+''',c.PACK_BARCODE,0.0,sum(STOCK_AMT) as STOCK_AMT,sum(SALES_AMT) as SALES_AMT,sum(SALES_MNY) as SALES_MNY,sum(STOR_AMT) as STOR_AMT,'+
    'case when sum(SALES_AMT)<>0 then cast(sum(SALES_MNY) as decimal(18,3))/cast(sum(SALES_AMT) as decimal(18,3)) else 0 end as SALES_PRC '+
    'from ( '+
    'select A.TENANT_ID,A.GODS_ID,B.SECOND_ID,0 as STOCK_AMT,sum(CALC_AMOUNT/('+GetDefaultUnitCalc('B')+')) as SALES_AMT,sum(CALC_MONEY) as SALES_MNY,0 as STOR_AMT '+
    'from VIW_SALESDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and A.SALES_DATE='+formatDatetime('YYYYMMDD',date())+' group by A.TENANT_ID,A.GODS_ID,B.SECOND_ID '+
    'union all '+
    'select A.TENANT_ID,A.GODS_ID,B.SECOND_ID,sum(A.CALC_AMOUNT/('+GetDefaultUnitCalc('B')+')) as STOCK_AMT,0 as SALES_AMT,0 as SALES_MNY,0 as STOR_AMT '+
    'from VIW_STOCKDATA A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+'''  and A.STOCK_DATE='+formatDatetime('YYYYMMDD',date())+' group by A.TENANT_ID,A.GODS_ID,B.SECOND_ID '+
    'union all '+
    'select A.TENANT_ID,A.GODS_ID,B.SECOND_ID,0 as STOCK_AMT,0 as SALES_AMT,0 as SALES_MNY,sum(A.AMOUNT/('+GetDefaultUnitCalc('B')+')) as STOR_AMT '+
    'from STO_STORAGE A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID=1000006 and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' group by A.TENANT_ID,A.GODS_ID,B.SECOND_ID '+
    ') j,RIM_GOODS_RELATION c where j.SECOND_ID=c.GODS_ID group by c.PACK_BARCODE ';

    ExecSQL(Pchar(sql),iRet);
    UpiRet := iRet;
    CommitTrans;
    result:=UpiRet;
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'10','�ϱ��ս�����ʧ�ܣ�','02'); //д��־
      Raise Exception.Create(E.Message);
    end;
  end;

  //ִ�гɹ�д��־:
  WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'10','�ϱ�������ɹ���','01');
end;

end.















