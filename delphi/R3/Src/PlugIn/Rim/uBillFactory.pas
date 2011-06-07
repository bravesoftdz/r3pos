{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uBillFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  Forms, uBaseSyncFactory, uRimSyncFactory;

type
  TBillSyncFactory=class(TRimSyncFactory)
  private
    //�ϱ���̨��
    function SendMonthReck(vRimParam: TRimParams): integer;
    //�ϱ����۵�
    function SendSalesDetail(vRimParam: TRimParams): integer;
    //�ϱ����۵���������
    function SendSaleBatchDetail(vRimParam: TRimParams): integer;
    //�ϱ������˻�
    function SendSaleRetDetail(vRimParam: TRimParams): integer;
    //�ϱ������������룩
    function SenddbInDetail(vRimParam: TRimParams): integer;
    //�ϱ������������룩
    function SenddbOutDetail(vRimParam: TRimParams): integer;
    //�ϱ���ⵥ
    function SendStockDetail(vRimParam: TRimParams): integer;
    //�ϱ�����˻���
    function SendStkRetuDetail(vRimParam: TRimParams): integer;
    //�ϱ�������
    function SendChangeDetail(vRimParam: TRimParams): integer;

    function Test(SQL: string): integer; //����
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;
 
implementation

{ TSalesTotalSyncFactory }

function TBillSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  ErrorFlag: Boolean; //����״̬
  iRet: integer; //�����ϱ��ɹ���¼
  RimParam: TRimParams;
  R3ShopList: TZQuery;
begin
  result:=-1;
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  GetDBType;    //1���������ݿ�����
  Params.Decode(Params, InParamStr); //2����ԭParamsList�Ĳ�������
  GetSyncType;  //3������ͬ�����ͱ��

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
        ErrorFlag:=False; 
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);   //R3��ҵID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString); //R3��ҵ���� (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);     //R3�ŵ�ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);  //R3�ŵ����� (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString); //R3�ŵ����֤�� (Field: LICENSE_CODE)
        RimParam.SHORT_ShopID:=Copy(RimParam.ShopID,Length(RimParam.ShopID)-3,4);     //�ŵ�ID�ĺ�4λ

        //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID); //�����̲ݹ�˾ComID�����ۻ�CustID

        //if then Raise Exception.Create('R3������ҵID��'+RimParam.TenID+' - '+RimParam.TenName+'����RIM��û�ҵ���Ӧ��COM_IDֵ...');
        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          LogInfo.BeginLog(RimParam.TenName+'-'+RimParam.ShopName); //��ʼ��־

          //��ʼ�ϱ���̨�ʣ�
          iRet:=SendMonthReck(RimParam);
          LogInfo.AddBillMsg('��̨��',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //�ϱ����۵�
          iRet:=SendSalesDetail(RimParam);
          LogInfo.AddBillMsg('���۵�',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //�ϱ����۵���������
          iRet:=SendSaleBatchDetail(RimParam);
          LogInfo.AddBillMsg('���۵�',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //�ϱ������˻�
          iRet:=SendSaleRetDetail(RimParam);
          LogInfo.AddBillMsg('�����˻���',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //�ϱ������������룩
          iRet:=SenddbInDetail(RimParam);
          LogInfo.AddBillMsg('������(��)',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //�ϱ���������������
          iRet:=SenddbOutDetail(RimParam);
          LogInfo.AddBillMsg('������(��)',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);
      
          //�ϱ���ⵥ
          iRet:=SendStockDetail(RimParam);
          LogInfo.AddBillMsg('��ⵥ',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //�ϱ�����˻���
          iRet:=SendStkRetuDetail(RimParam);
          LogInfo.AddBillMsg('����˻���',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1);

          //�ϱ�������
          iRet:=SendChangeDetail(RimParam);
          LogInfo.AddBillMsg('������',iRet);
          if not ErrorFlag then ErrorFlag:=(iRet=-1); 

          if R3ShopList.RecordCount=1 then 
            LogInfo.SetLogMsg(LogList)  //��ӱ���ִ����־
          else 
            LogInfo.SetLogMsg(LogList,R3ShopList.RecNo); //��ӱ���ִ����־

          if ErrorFlag then
            Inc(FRunInfo.ErrorCount) //ִ���쳣��
          else
            Inc(FRunInfo.RunCount);  //ִ�гɹ���
        end else
        begin
          if R3ShopList.RecordCount=1 then
            LogList.Add('   �ŵ�('+RimParam.TenName+'-'+RimParam.ShopName+')���֤��'+RimParam.LICENSE_CODE+' ��Rimϵͳ��û��Ӧ�����ۻ���') 
          else
            LogList.Add('  ('+InttoStr(R3ShopList.RecordCount)+')�ŵ�('+RimParam.TenName+'-'+RimParam.ShopName+')���֤��'+RimParam.LICENSE_CODE+' ��Rimϵͳ��û��Ӧ�����ۻ���');
          Inc(FRunInfo.NotCount);  //��Ӧ����
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    FRunInfo.AllCount:=R3ShopList.RecordCount;  //���ŵ���
    DBLock(False); //����     
    R3ShopList.Free;
    WriteLogRun('ҵ����ˮ����'); //������ı���־
  end;
end;


////�ϱ���̨��(type='00') [������̨�˱� ����̨�ʱ�û�а��½������ϱ���2011.06.03]
function TBillSyncFactory.SendMonthReck(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺����
  Str,MonthTab,ReckMonth: string;
begin
  result := -1;
  UpiRet:=0;
  MaxStmp:=GetMaxNUM('00',vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���

  //��һ��: ����̨����ʱ[INF_RECKMONTH]:
  case DbType of
   1:
    begin
      Session:='';
      ReckMonth:='to_char(A.MONTH) ';
    end;
   4:
    begin
      Session:='session.';
      ReckMonth:='trim(char(A.MONTH)) ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKMONTH ('+
             'TENANT_ID INTEGER NOT NULL,'+         //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+       //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3�ŵ�ID�ĺ���λ
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //RIM���ۻ�ID
             'ITEM_ID VARCHAR(30) NOT NULL,'+       //RIM��ƷID
             'GODS_ID CHAR(36) NOT NULL,'+          //R3��ƷID
             'UNIT_CALC DECIMAL (18,6),'+           //��Ʒ������λ�������λ����ֵ
             'RECK_MONTH VARCHAR(8) NOT NULL'+      //̨���·�
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨����ʱ�����'+PlugIntf.GetLastError);
    end;
  end;

  //�ڶ���: ����ʱ�����̨�ʲ�����ʱ��:
  if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_RECKMONTH where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);
  MonthTab:='select M.* from RCK_GOODS_MONTH M,RCK_MONTH_CLOSE C where M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and M.MONTH=C.MONTH and '+
            ' M.TENANT_ID='+vRimParam.TenID+' and M.SHOP_ID='''+vRimParam.ShopID+''' and C.TIME_STAMP>'+MaxStmp;
  Str:='insert into '+Session+'INF_RECKMONTH(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_MONTH) '+
       'select A.TENANT_ID,A.SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,('+GetDefaultUnitCalc+') as UNIT_CALC,'+ReckMonth+' as RECK_MONTH '+
       ' from ('+MonthTab+') A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨����ʱ�����:'+PlugIntf.GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
  end;

  //������: ��ɾ����ʷ�ڲ���:
  try
    BeginTrans; 
    //1����ɾ��RIM��̨�˱����Ҫ�����ϱ���¼:
    Str:='delete from RIM_CUST_MONTH A where A.COM_ID='''+vRimParam.ComID+''' and A.CUST_ID='''+vRimParam.CustID+''' and '+
         ' exists(select 1 from '+Session+'INF_RECKMONTH B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.ITEM_ID=B.ITEM_ID and A.MONTH=B.RECK_MONTH)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����̨����ʷ���ݳ���'+PlugIntf.GetLastError);

    //2�������ϱ���¼:
    Str:=
      'insert into RIM_CUST_MONTH('+
          'COM_ID,CUST_ID,TERM_ID,ITEM_ID,MONTH,PRI3,PRI4,PRI_SOLD,AMT_GROSS_PROFIT_THEO,'+ //1:
          'QTY_IOM,AMT_IOM,'+              //2:�ڳ����������
          'QTY_PURCH,AMT_PURCH,'+          //3:������������
          'QTY_SOLD,AMT_SOLD_WITH_TAX,'+   //4:������������˰���
          'QTY_PROFIT,AMT_PROFIT,'+        //5: �������������
          'QTY_LOSS,AMT_LOSS,'+            //6: �������������
          'QTY_TAKE,AMT_TAKE,'+            //7: �������������
          'QTY_TRN_IN,AMT_TRN_IN,'+        //8: �������������
          'QTY_TRN_OUT,AMT_TRN_OUT,'+      //9: �������������
          'QTY_EOM,AMT_EOM,'+              //10: ��ĩ���������
          'UNIT_COST,SUMCOST_SOLD,'+       //11: ��λ�ɱ������۳ɱ�
          'AMT_GROSS_PROFIT,AMT_PROFIT_COM)'+  //12:ë�������ë��
      'select B.COM_ID,B.CUST_ID,SHORT_SHOP_ID,B.ITEM_ID,B.RECK_MONTH,0,0,0,0,'+ //1:
          '(case when B.UNIT_CALC>0 then ORG_AMT/B.UNIT_CALC else ORG_AMT end)as ORG_AMT,ORG_MNY,'+          //2:�ڳ����������
          '(case when B.UNIT_CALC>0 then STOCK_AMT/B.UNIT_CALC else STOCK_AMT end)as STOCK_AMT,STOCK_MNY,'+  //3:������������
          'SALE_AMT,SALE_MNY+SALE_TAX,'+   //4:������������˰���
          '(case when CHANGE1_AMT>0 then (case when B.UNIT_CALC>0 then CHANGE1_AMT/B.UNIT_CALC else CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT>0 then CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+    //5: �������������
          '(case when CHANGE1_AMT<0 then (case when B.UNIT_CALC>0 then -CHANGE1_AMT/B.UNIT_CALC else -CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT<0 then -CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+ //6: �������������
          '(case when B.UNIT_CALC>0 then (CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)/B.UNIT_CALC else CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT end)as CHANGE_AMT,(CHANGE2_MNY+CHANGE3_MNY+CHANGE3_MNY+CHANGE4_MNY+CHANGE5_MNY) as CHANGE_MNY,'+ //7: �������������
          '(case when B.UNIT_CALC>0 then DBIN_AMT/B.UNIT_CALC else DBIN_AMT end)as DBIN_AMT,DBIN_MNY,'+      //8: �������������
          '(case when B.UNIT_CALC>0 then DBOUT_AMT/B.UNIT_CALC else DBOUT_AMT end)as DBOUT_AMT,DBOUT_MNY,'+  //9: �������������
          '(case when B.UNIT_CALC>0 then BAL_AMT/B.UNIT_CALC else BAL_AMT end)as BAL_AMT,BAL_MNY,'+          //10: ��ĩ���������
          'ADJ_CST,BAL_CST,'+             //11: ��λ�ɱ������۳ɱ�
          'SALE_PRF,0 '+                  //12: ë�������ë��
      'from RCK_GOODS_MONTH A,'+Session+'INF_RECKMONTH B '+
      ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and '+ReckMonth+'=B.RECK_MONTH and A.TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('�ϱ���̨�����ݳ���:'+PlugIntf.GetLastError);

    //3�������ϱ�ʱ���:[]                                
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''00'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨���ϱ�ʱ�������:'+PlugIntf.GetLastError);
    CommitTrans; //�ύ����
    result:=UpiRet;

    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'00','�ϱ���̨�ʳɹ�','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'00','�ϱ���̨�ʴ���','02'); //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;


//////�ϱ�POS���۵� (type='01')
function TBillSyncFactory.SendSalesDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  Str, SALES_DATE: string;
  SaleTab,DetailTab: string; //������ϸ����Ʒ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵���POS����ʱ[INF_POS_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      SALES_DATE:='to_char(A.SALES_DATE) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='trim(char((A.SALES_DATE)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+     //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+   //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+   //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+    //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+   //RIM���ۻ�ID
             'SALES_ID CHAR(36) NOT NULL,'+     //RIM�������۵�ID
             'SALE_DATE CHAR (8) NOT NULL,'+    //RIM�������۵�����
             'CUST_CODE varchar (20)'+         //��Ա��
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�[INF_SALE]����:'+PlugIntf.GetLastError);
    end;
  end;

  try
    //�ڶ����������м��
    MaxStmp:=GetMaxNUM('01',vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_SALE where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);

    SaleTab:='select SALES_ID,SALES_DATE,IC_CARDNO,TIME_STAMP from SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and SALES_TYPE=4 and COMM not in (''02'',''12'') and '+
             ' TIME_STAMP>'+MaxStmp+' and not exists(select 1 from RIM_RETAIL_INFO AA where SAL_SALESORDER.SALES_ID=AA.RETAIL_NUM and AA.COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''') ';
    str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,A.SALES_ID,'+SALES_DATE+',B.CUST_CODE from '+
         ' ('+SaleTab+')A left outer join PUB_CUSTOMER B on A.IC_CARDNO=B.CUST_ID ';

    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ�����:'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //����û�п��ϱ�����
      Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
    end;

    //��ʼ���봦��:
    BeginTrans; //��ʼһ����������:
    //0�����۵������޸ģ������ر���
    //1���������۱�ͷ:                                                                       //R3_NUM, -->SALES_ID,
    Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.SALES_ID,'''','''',B.CUST_ID,SHORT_SHOP_ID,B.COM_ID,coalesce(INTEGRAL,0),B.SALE_DATE,B.CUST_CODE,B.SALE_DATE,(case when length(CREA_DATE)>12 then substr(CREA_DATE,12,length(CREA_DATE)-12) else ''00:00:00'' end) as PUH_TIME,''admin'' as CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',SHORT_SHOP_ID '+
       ' from SAL_SALESORDER A,'+Session+'INF_SALE B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('�����۵���ͷ����:'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;

    //2���������۱���:
    DetailTab:=
       'select S.*,M.UNIT_NAME,INF.SHORT_SHOP_ID from SAL_SALESDATA S,'+Session+'INF_SALE INF,VIW_MEAUNITS M '+
       ' where S.TENANT_ID=INF.TENANT_ID and S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.SALES_ID=INF.SALES_ID and '+
       ' S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID;

    Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE,TREND_ID)'+
         ' select A.SALES_ID,A.SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID, '+
         ' A.COST_PRICE,A.APRICE,(case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''',A.SHORT_SHOP_ID '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
         ' B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����POS���۵��������'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;

    //3�������ϱ�ʱ���:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''01'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����ϱ�ʱ�������:'+PlugIntf.GetLastError);

    CommitTrans;  //�ύ����

    result:=UpiRet;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE, vRimParam.CustID, '01','�ϱ�POS���۵��ɹ���','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE, vRimParam.CustID, '01','�ϱ�POS���۵�����','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

////�ϱ����۵��������������� (type='02')
function TBillSyncFactory.SendSaleBatchDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  Str, SALES_DATE: string;
  DetailTab: string; //������ϸ����Ʒ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵�����������ʱ[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      SALES_DATE:='to_char(SALES_DATE) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='trim(char(SALES_DATE)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+//R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'SALES_ID CHAR(36) NOT NULL,'+       //RIM���۵�ID
             'SALE_DATE CHAR (8) NOT NULL,'+      //RIM���۵�����
             'CUST_CODE varchar (20)'+            //��Ա��( ���ֶ���ʱ����)             
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ[INF_SALE]����');
    end;
  end;

  //�ڶ����������м��
  try
    MaxStmp:=GetMaxNUM('02', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_SALE where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+' '+
         ' from SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and SALES_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�[INF_SALE]����'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //����û�п��ϱ�����
      Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
    end;


    BeginTrans;
    //1���ϱ�ǰɾ����ʷ���ݣ�
    Str:='delete from RIM_RETAIL_DETAIL where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���۵���ͷ����'+PlugIntf.GetLastError);
    Str:='delete from RIM_RETAIL_INFO where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���۵��������'+PlugIntf.GetLastError);

    //2���������۱�ͷ:
    Str:='insert into RIM_RETAIL_INFO'+                                               //R3_NUM, ---> SALES_ID,
       '(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.SALES_ID,'' '','' '',B.CUST_ID,B.SHORT_SHOP_ID,B.COM_ID,0,B.SALE_DATE,'' '',B.SALE_DATE,'' '' as PUH_TIME,''admin'' as CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',B.SHORT_SHOP_ID '+
       ' from SAL_SALESORDER A,'+Session+'INF_SALE B where  A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+'''  ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�������ͷ[RIM_RETAIL_INFO]����:'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;
      
    //3���������۱���:
    DetailTab:=
       'select S.*,M.UNIT_NAME from SAL_SALESDATA S,'+Session+'INF_SALE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and '+
       ' S.SALES_ID=INF.SALES_ID and S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID;
    Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
       ' select A.SALES_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID, '+
       ' A.COST_PRICE,A.APRICE,(case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
       ' B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵������������:'+PlugIntf.GetLastError);

    //4�������ϱ�ʱ���:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''02'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵��ϱ�ʱ�������');
    CommitTrans; //�ύ����

    result:=UpiRet;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'02','�ϱ��������۵��ɹ���','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'02','�ϱ����۵�����������','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//�����˻���  (type='03')
function TBillSyncFactory.SendSaleRetDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string; //sessionǰ׺  
  Str, SALES_DATE: string;
  DetailTab: string; //������ϸ����Ʒ��
  RsINF: TZQuery;     //�м��ѭ��ʹ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: ���������˻�����ʱ[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      SALES_DATE:='to_char(SALES_DATE)as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='trim(char(SALES_DATE)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+        //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+      //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+       //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+      //RIM���ۻ�ID
             'SALES_ID CHAR(36) NOT NULL,'+        //RIM���۵�ID
             'SALE_DATE CHAR (8) NOT NULL,'+       //RIM���۵�����
             'CUST_CODE varchar (20)'+            //��Ա��( ���ֶ���ʱ����)
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������˻�����ʱ��[INF_SALE]����');
    end;
  end;

  //�ڶ�����ѭ�������м��
  try
    MaxStmp:=GetMaxNUM('03', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_SALE where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+' '+
         'from SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and SALES_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������˻���[INF_SALE]����'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //����û�п��ϱ�����
      Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
    end;

    BeginTrans; //��ʼ����
    //1���ϱ�ǰɾ����ʷ���ݣ�
    Str:='delete from RIM_RETAIL_DETAIL where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�����˻�����ͷ����'+PlugIntf.GetLastError);
    Str:='delete from RIM_RETAIL_INFO where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_INFO.COM_ID=A.COM_ID and RIM_RETAIL_INFO.CUST_ID=A.CUST_ID and RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�����˻����������'+PlugIntf.GetLastError);

    //2���������۱�ͷ:
    Str:='insert into RIM_RETAIL_INFO '+                                               //R3_NUM ---> SALES_ID,
       '(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.SALES_ID,'' '','' '',B.CUST_ID,B.SHORT_SHOP_ID,B.COM_ID,0,B.SALE_DATE,'' '',B.SALE_DATE,'' '' as PUH_TIME,''admin'' as CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',B.SHORT_SHOP_ID '+
       ' from SAL_SALESORDER A,'+Session+'INF_SALE B where  A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+'''  ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�������ͷ[RIM_RETAIL_INFO]����:'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;
    //3���������۱���:
    DetailTab:=
       'select S.*,M.UNIT_NAME from SAL_SALESDATA S,'+Session+'INF_SALE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and '+
       ' S.SALES_ID=INF.SALES_ID and S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID;
    Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
       ' select A.SALES_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID, '+
       ' A.COST_PRICE,A.APRICE,(case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
       ' B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵������������:'+PlugIntf.GetLastError);
      
    //4�������ϱ�ʱ���:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''03'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������˻����ϱ�ʱ�������');

    CommitTrans; //�ύ����
    result:=UpiRet;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'03','�ϱ������˻����ɹ���','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'03','�ϱ������˻�����','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;          

//�ϱ������� (type='04') {˵��: ��R3���ʱ�ѵ��뵱��Ϊ��ⵥ���洢��������������Ϊ���ⵥ���洢�����۵�;ͬ��ʱ���������� }
function TBillSyncFactory.SenddbInDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  Str,BillDate: string;
  DetailTab: string; //������ϸ����Ʒ��
  RsINF: TZQuery;             //�м��ѭ��ʹ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵�����������ʱ[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(STOCK_DATE) as STOCK_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='trim(char(STOCK_DATE)) as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_DB( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+     //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'DB_ID CHAR(36) NOT NULL,'+       //RIM����ID
             'DB_NEWID VARCHAR(40) NOT NULL,'+       //RIM����ID(ԭ����+"_1")
             'DB_DATE CHAR(8) NOT NULL'+         //RIM��������
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ[INF_SALE]����');
    end;
  end;

  //�ڶ����������м�(��ʱ)��
  try
    MaxStmp:=GetMaxNUM('04', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_DB where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,STOCK_ID,STOCK_ID || ''_1'' as DB_NEWID,'+BillDate+' from '+
         ' STK_STOCKORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������뵥[INF_DB]����'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //����û�п��ϱ�����
      Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
    end;

    BeginTrans; //��ʼ����
    //1���ϱ�ǰɾ����ʷ���ݣ�
    Str:='delete from RIM_CUST_TRN where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���뵥��ͷ����'+PlugIntf.GetLastError);
    Str:='delete from RIM_CUST_TRN_LINE where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���뵥�������'+PlugIntf.GetLastError);

    //2������������룩����ͷ:
    Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
       ' select B.DB_NEWID,B.CUST_ID,''2'' as vTYPE,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.DB_DATE,''admin'' as CREA_USER,B.DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
       ' from STK_STOCKORDER A,'+Session+'INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.DB_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������������ͷ����'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;

    //3���������۱���:
    DetailTab:='select INF.DB_NEWID,S.*,M.UNIT_NAME from STK_STOCKDATA S,'+Session+'INF_DB INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.STOCK_ID=INF.DB_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID+' and S.SHOP_ID='''+vRimParam.ShopID+''' ';

    Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
         ' select A.DB_NEWID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,'+
         ' (case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������룩����������[RIM_CUST_TRN_LINE]����'+PlugIntf.GetLastError);

    //4�������ϱ�ʱ���:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''04'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵��ϱ�ʱ�������:'+PlugIntf.GetLastError);

    //�ύ����
    CommitTrans;
    result:=UpiRet;

    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'04','�ϱ��������������ɹ���','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'04','�ϱ��������룩����','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//�ϱ������� (type='12')  ���ݺ���=SALES_ID + _2 {˵��: ��R3���ʱ�ѵ��뵱��Ϊ��ⵥ���洢��������������Ϊ���ⵥ���洢�����۵�;ͬ��ʱ���������� }
function TBillSyncFactory.SenddbOutDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺
  Str, BillDate: string;
  DetailTab: string; //������ϸ����Ʒ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵�����������ʱ[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(SALES_DATE) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='trim(char(SALES_DATE)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_DB( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+     //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'DB_ID CHAR(36) NOT NULL,'+       //RIM����ID
             'DB_NEWID VARCHAR(40) NOT NULL,'+       //RIM����ID(ԭ����+"_1")
             'DB_DATE CHAR(8) NOT NULL'+         //RIM��������
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ[INF_SALE]����');
    end;
  end;

  try
    MaxStmp:=GetMaxNUM('12', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_DB where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE)'+
         'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,SALES_ID,SALES_ID || ''_2'' as DB_NEWID,'+BillDate+' from '+
         ' SAL_SALESORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and SALES_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������[INF_DB]����'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //����û�п��ϱ�����
      Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
    end;

    BeginTrans; //��ʼ����
    //1���ϱ�ǰɾ����ʷ���ݣ�
    Str:='delete from RIM_CUST_TRN where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��������ͷ����'+PlugIntf.GetLastError);
    Str:='delete from RIM_CUST_TRN_LINE where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�������������'+PlugIntf.GetLastError);

    //2������������룩����ͷ:
    Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
       ' select B.DB_NEWID,B.CUST_ID,''2'' as vTYPE,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.DB_DATE,''admin'' as CREA_USER,B.DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
       ' from SAL_SALESORDER A,'+Session+'INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.DB_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����������ͷ����'+PlugIntf.GetLastError);
    UpiRet:=UpiRet+iRet;

    //3���������۱���:
    DetailTab:='select INF.DB_NEWID,S.*,M.UNIT_NAME from SAL_SALESDATA S,'+Session+'INF_DB INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SALES_ID=INF.DB_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID;
    Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
         ' select A.DB_NEWID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,'+
         ' (case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����������������������[RIM_CUST_TRN_LINE]����'+PlugIntf.GetLastError);

    //4�������ϱ�ʱ���:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''12'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���µ������������ϱ�ʱ�������:'+PlugIntf.GetLastError);

    //�ύ����
    CommitTrans;
    result:=UpiRet;

    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'12','�ϱ��������������ɹ���','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'12','�ϱ���������������','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//�ϱ���ⵥ [type='05']
function TBillSyncFactory.SendStockDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string; //sessionǰ׺
  Str,BillDate: string;
  DetailTab: string; //��ⵥϸ����Ʒ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵�����������ʱ[INF_STOCK]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(STOCK_DATE) as STOCK_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='trim(char(STOCK_DATE)) as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+         //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+       //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //���ۻ�ID
             'STOCK_ID CHAR(36) NOT NULL,'+         //��ⵥID
             'STOCK_DATE CHAR(8) NOT NULL'+         //�������
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������ⵥ��ʱ��[INF_STOCK]����');
    end;
  end;

  try
    MaxStmp:=GetMaxNUM('05', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_STOCK where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,STOCK_ID,STOCK_DATE)'+
       'select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,STOCK_ID,'+BillDate+' from '+
       ' STK_STOCKORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and STOCK_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert��ⵥ[INF_STOCK]����'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //����û�п��ϱ�����
      Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
    end;

    BeginTrans; //��ʼ����
    //1���ϱ�ǰɾ����ʷ���ݣ�
    Str:='delete from RIM_VOUCHER where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER.VOUCHER_NUM=A.STOCK_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��ⵥ��ͷ����'+PlugIntf.GetLastError);
    Str:='delete from RIM_VOUCHER_LINE where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER_LINE.VOUCHER_NUM=A.STOCK_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��ⵥ�������'+PlugIntf.GetLastError);

    //2��Insert��ⵥ��ͷ:
    Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.STOCK_ID,'' '' as RETAIL_NUM,B.CUST_ID,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.STOCK_DATE,''admin'' as CREA_USER,B.STOCK_DATE,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
       ' from STK_STOCKORDER A,'+Session+'INF_STOCK B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.STOCK_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����������ͷ[RIM_VOUCHER]����');
    UpiRet:=UpiRet+iRet;

    //3������ⵥ����:
    DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,'+Session+'INF_STOCK INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.STOCK_ID=INF.STOCK_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID+' and S.SHOP_ID='''+vRimParam.ShopID+''' ';

    Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
         ' select A.STOCK_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,'+
         ' (case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������������[RIM_VOUCHER_LINE]����');

    //4�������ϱ�ʱ���:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''05'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���½�����ⵥ�ϱ�ʱ�������');
    //�ύ����
    CommitTrans;
    result:=UpiRet;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'05','�ϱ���ⵥ�ɹ���','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'05','�ϱ���ⵥ����','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;


//�ϱ�����˻� (type='06')
function TBillSyncFactory.SendStkRetuDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string; //sessionǰ׺
  Str,BillDate: string;
  DetailTab: string; //��ⵥϸ����Ʒ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵�����������ʱ[INF_STOCK]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(STOCK_DATE)as STOCK_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='trim(char(STOCK_DATE))as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+         //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+       //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //���ۻ�ID
             'STOCK_ID CHAR(36) NOT NULL,'+         //��ⵥID
             'STOCK_DATE CHAR(8) NOT NULL'+         //�������
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������ⵥ��ʱ��[INF_STOCK]����');
    end;
  end;

  try
    MaxStmp:=GetMaxNUM('06', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_STOCK where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,STOCK_ID,STOCK_DATE)'+
       ' select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,STOCK_ID,'+BillDate+' from '+
       ' STK_STOCKORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and STOCK_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert��ⵥ[INF_STOCK]����'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //����û�п��ϱ�����
      Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
    end;

    BeginTrans; //��ʼ����
    //1���ϱ�ǰɾ����ʷ���ݣ�
    Str:='delete from RIM_VOUCHER where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER.VOUCHER_NUM=A.STOCK_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��ⵥ��ͷ����'+PlugIntf.GetLastError);
    Str:='delete from RIM_VOUCHER_LINE where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER_LINE.VOUCHER_NUM=A.STOCK_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��ⵥ�������'+PlugIntf.GetLastError);

    //2��Insert��ⵥ��ͷ:
    Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
       ' select A.STOCK_ID,'' '' as RETAIL_NUM,B.CUST_ID,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.STOCK_DATE,''admin'' as CREA_USER,B.STOCK_DATE,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
       ' from STK_STOCKORDER A,'+Session+'INF_STOCK B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.STOCK_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����������ͷ[RIM_VOUCHER]����');
    UpiRet:=UpiRet+iRet;

    //3������ⵥ����:
    DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,'+Session+'INF_STOCK INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.STOCK_ID=INF.STOCK_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID+' and S.SHOP_ID='''+vRimParam.ShopID+''' ';

    Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
         ' select A.STOCK_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,'+
         '(case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE';

    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������������[RIM_VOUCHER_LINE]����');

    //4�������ϱ�ʱ���:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''06'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���½�����ⵥ�ϱ�ʱ�������');
    //�ύ����
    CommitTrans;
    result:=UpiRet;

    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'06','�ϱ�����˳����ɹ���','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'06','�ϱ�����˳�������','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//�ϱ�������  (type='07')
function TBillSyncFactory.SendChangeDetail(vRimParam: TRimParams): integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺
  Str,BillDate: string;
  DetailTab: string; //��ⵥϸ����Ʒ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵�����������ʱ[INF_CHANGE]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(CHANGE_DATE) as CHANGE_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='trim(char(CHANGE_DATE)) as CHANGE_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_CHANGE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'CHANGE_ID CHAR(36) NOT NULL,'+      //RIM������ID
             'CHANGE_DATE CHAR(8) NOT NULL'+         //�������
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������������ʱ[INF_CHANGE]����');
    end;
  end;

  try
    MaxStmp:=GetMaxNUM('07', vRimParam.ComID, vRimParam.CustID, vRimParam.ShopID); //����ʱ����͸���ʱ���
    if PlugIntf.ExecSQL(PChar('delete from '+Session+'INF_CHANGE where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' '),iRet)<>0 then Raise Exception.Create('ɾ����ʱ�����:'+PlugIntf.GetLastError);
    str:='insert into '+Session+'INF_CHANGE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,CHANGE_ID,CHANGE_DATE)'+
       ' select '+vRimParam.TenID+' as TENANT_ID,'''+vRimParam.ShopID+''' as SHOP_ID,'''+vRimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+vRimParam.ComID+''' as COM_ID,'''+vRimParam.CustID+''' as CUST_ID,CHANGE_ID,'+BillDate+' from '+
       ' STO_CHANGEORDER where TENANT_ID='+vRimParam.TenID+' and SHOP_ID='''+vRimParam.ShopID+''' and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert��ⵥ[INF_CHANGE]����'+PlugIntf.GetLastError);
    if iRet=0 then
    begin
      result:=0; //����û�п��ϱ�����
      Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
    end;

    BeginTrans; //��ʼ����
    //1���ϱ�ǰɾ����ʷ���ݣ�
    Str:='delete from RIM_ADJUST_INFO where Exists(select 1 from '+Session+'INF_CHANGE A where RIM_ADJUST_INFO.ADJUST_NUM=A.CHANGE_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��������ͷ����'+PlugIntf.GetLastError);
    Str:='delete from RIM_ADJUST_DETAIL where Exists(select 1 from '+Session+'INF_CHANGE A where RIM_ADJUST_DETAIL.ADJUST_NUM=A.CHANGE_ID)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�������������'+PlugIntf.GetLastError);

    //2�������������ͷ:                                                //R3_NUM, --> CHANGE_ID,
    Str:='insert into RIM_ADJUST_INFO(ADJUST_NUM,CUST_ID,COM_ID,TERM_ID,TYPE,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
       ' select A.CHANGE_ID,'''+vRimParam.CustID+''' as CUST_ID,'''+vRimParam.ComID+''' as COM_ID,B.SHORT_SHOP_ID,'+
       ' (case when CHANGE_CODE=''01'' then ''02'' else ''03'' end) as CHANGE_CODE,''02'',B.CHANGE_DATE,''admin'' as CREA_USER,B.CHANGE_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,SHORT_SHOP_ID '+
       ' from STO_CHANGEORDER A,'+Session+'INF_CHANGE B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.CHANGE_ID=B.CHANGE_ID and '+
       ' A.TENANT_ID='+vRimParam.TenID+' and A.SHOP_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���롼����������ͷ[RIM_ADJUST_INFO]���󣡣�SQL='+str+'��');
    UpiRet:=UpiRet+iRet;

    //3���������������:
    DetailTab:='select S.*,M.UNIT_NAME from STO_CHANGEDATA S,'+Session+'INF_CHANGE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.CHANGE_ID=INF.CHANGE_ID and '+
               ' S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+vRimParam.TenID+' ';

    Str:='insert into RIM_ADJUST_DETAIL(ADJUST_NUM,ADJUST_LINE,COM_ID,ITEM_ID,UM_ID,QTY_ADJUST,QTY_MINI_UM,AMT_ADJUST)'+
         ' select A.CHANGE_ID,SEQNO,'''+vRimParam.ComID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,'+
         ' (case when '+GetDefaultUnitCalc('B')+'>0 then A.AMOUNT/'+GetDefaultUnitCalc('B')+' else A.AMOUNT end) as AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
         ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+vRimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
         ' order by B.GODS_CODE';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���롼������������[RIM_ADJUST_DETAIL]����'+PlugIntf.GetLastError);
 
    //4�������ϱ�ʱ���:[]
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' where COM_ID='''+vRimParam.ComID+''' and CUST_ID='''+vRimParam.CustID+''' and TYPE=''07'' and TERM_ID='''+vRimParam.ShopID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���¡����������ϱ�ʱ�������');

    //�ύ����
    CommitTrans;
    result:=UpiRet;

    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'07','�ϱ������������ɹ���','01');
  except
    on E:Exception do
    begin
      RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(vRimParam.LICENSE_CODE,vRimParam.CustID,'07','�ϱ���������������','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;


function TBillSyncFactory.Test(SQL: string): integer;
var
  Rs: TZQuery;
begin
  try
    Rs:=TZQuery.Create(nil);
    Rs.Close;
    Rs.SQL.Text:=SQL;
    self.Open(Rs);
    result:=Rs.RecordCount; 
  finally
  end;
end;

end.















