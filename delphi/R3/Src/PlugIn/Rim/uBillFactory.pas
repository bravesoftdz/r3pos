{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)���ڵ�λ���㼰�ϱ���λ:
    A��R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;
    B���ϱ������ǻ������ݣ�ת�ɹ���λ�ϱ���Rim����λ���ݹ���λ���ƶ�ӦIDֵ�ϱ�;
    C����ˮ�����ϱ���ԭ���ݵ�λ�ϱ�;

 ------------------------------------------------------------------------------}

unit uBillFactory;

interface

uses                 
  SysUtils,windows, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  Forms, uBaseSyncFactory, uRimSyncFactory;

type
  TBillSyncFactory=class(TRimSyncFactory)
  private
    FAutoCheckReport: Boolean; //�Ƿ������Զ�����ϱ����
    ComTrans: Boolean;   //�����Ƿ��ύ�ɹ�
    FBillType: string;
    FTempTableName: string;
    FBillMainTable: string;
    FBillKeyField: string;
    FINFKeyField: string;
    procedure SetBillType(const Value: string);      //��������
    procedure SetTempTableName(const Value: string);
    procedure SetBillKeyField(const Value: string);
    procedure SetBillMainTable(const Value: string);
    procedure SetINFKeyField(const Value: string);
    procedure SetAutoCheckReport(const Value: Boolean);  //�Զ����δ�ϱ�[]

    //��������Ľ�����:
    function GetMaxReckDay: string; 
    //����Ƿ����©�����:
    function CheckReportBill: Boolean;
    
    //�ϱ���̨��
    function SendMonthReck: integer;
    //�ϱ����۵�[���ۡ��������˻�]
    function SendSalesDetail: integer;
    //�ϱ������������룩
    function SenddbInDetail: integer;
    //�ϱ���������������
    function SenddbOutDetail: integer;
    //�ϱ���ⵥ [��⡢�˻�]
    function SendStockDetail: integer;
    //�ϱ�������
    function SendChangeDetail: integer;

    //��ʼǰȡʱ���������м������
    function BeginPrepare: Boolean;
    //�ύ�ϱ���������
    function CommitReportTrans: Boolean;

    function Test(SQL: string): integer;
  public
    constructor Create; override;
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
    property BillType: string read FBillType write SetBillType;                 //��������
    property TempTableName: string read FTempTableName write SetTempTableName;  //��������
    property BillMainTable: string read FBillMainTable write SetBillMainTable;  //�����������
    property BillKeyField: string read FBillKeyField write SetBillKeyField;     //���ݹ����ؼ���
    property INFKeyField: string read FINFKeyField write SetINFKeyField;        //���ݹ����ؼ���
    property AutoCheckReport: Boolean read FAutoCheckReport write SetAutoCheckReport;  //�Զ����δ�ϱ�[]
  end;


implementation

{ TSalesTotalSyncFactory }

constructor TBillSyncFactory.Create;
begin
  inherited;
  //��ȡ���ò���[Ĭ�ϲ�����]
  AutoCheckReport:=trim(ReadConfig('PARAMS','AUTO_CHECK_REPORT','1'))='0';
end;

function TBillSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
var
  iRet: integer;  //�����ϱ��ɹ���¼
  ErrorFlag: Boolean;  //����״̬   
begin
  result:=-1;
  PlugInID:='1003';
  {------��ʼ������------}
  PlugIntf:=GPlugIn;
  HasError:=False;
  ErrorMsg:='';
  GetDBType;    //1���������ݿ�����
  Params.Decode(Params, InParamStr); //2����ԭParamsList�Ĳ�������
  GetSyncType;  //3������ͬ�����ͱ��

  {------��ʼ��־�ϱ�------}
  BeginLogReport;
  try
    DBLock(true);  //�������ݿ�����   

    //����R3���ϱ�ShopList
    GetR3ReportShopList(R3ShopList);
    if R3ShopList.RecordCount=0 then
    begin
      Raise Exception.Create('<'+PlugInID+'>'+'[��ҵID('+RimParam.TenID+')û�п��ϱ��ŵ�(�˳�)��]');
    end;

    //���ŵ�ID����ѭ���ϱ�
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      RimParam.CustID:='';
      try
        ErrorFlag:=False; //��ǰ�ŵ��������״̬ 
        RimParam.TenID  :=trim(R3ShopList.fieldbyName('TENANT_ID').AsString);   //R3��ҵID (Field: TENANT_ID)
        RimParam.TenName:=trim(R3ShopList.fieldbyName('TENANT_NAME').AsString); //R3��ҵ���� (Field: TENANT_NAME)
        RimParam.ShopID :=trim(R3ShopList.fieldbyName('SHOP_ID').AsString);     //R3�ŵ�ID (Field: SHOP_ID)
        RimParam.ShopName:=trim(R3ShopList.fieldbyName('SHOP_NAME').AsString);  //R3�ŵ����� (Field: SHOP_NAME)
        RimParam.LICENSE_CODE:=trim(R3ShopList.fieldbyName('LICENSE_CODE').AsString); //R3�ŵ����֤�� (Field: LICENSE_CODE)
        RimParam.SHORT_ShopID:=Copy(RimParam.ShopID,Length(RimParam.ShopID)-3,4);     //�ŵ�ID�ĺ�4λ

        //����R3�ŵ�ID,����RIM���̲ݹ�˾ComID,���ۻ�CustID;
        SetRimORGAN_CUST_ID(RimParam.TenID, RimParam.ShopID, RimParam.ComID, RimParam.CustID); //�����̲ݹ�˾ComID�����ۻ�CustID

        if (RimParam.ComID<>'') and (RimParam.CustID<>'') then
        begin
          BeginLogShopReport; //��ʼ��־�ŵ�

          //��ʼ�ϱ���̨�ʣ�
          try
            iRet:=SendMonthReck;
            AddBillMsg('��̨��',iRet);
          except
            on E:Exception do
            begin
              if not ErrorFlag then ErrorFlag:=true;
              AddBillMsg('��̨��',-1,E.Message);    
            end;
          end;

          //�ϱ����۵� [���ۡ��������˻�]
          try
            iRet:=SendSalesDetail;
            AddBillMsg('���۵�',iRet);
          except
            on E:Exception do
            begin
              if not ErrorFlag then ErrorFlag:=true;
              AddBillMsg('���۵�',-1,E.Message);    
            end;
          end;

          //�ϱ������������룩
          try
            iRet:=SenddbInDetail;
            AddBillMsg('������(��)',iRet);
          except
            on E:Exception do
            begin
              if not ErrorFlag then ErrorFlag:=true;
              AddBillMsg('������(��)',-1,E.Message);
            end;
          end;

          //�ϱ���������������
          try
            iRet:=SenddbOutDetail;
            AddBillMsg('������(��)',iRet);
          except
            on E:Exception do
            begin
              if not ErrorFlag then ErrorFlag:=true;
              AddBillMsg('������(��)',-1,E.Message);
            end;
          end;
      
          //�ϱ���ⵥ
          try
            iRet:=SendStockDetail;
            AddBillMsg('��ⵥ',iRet);
          except
            on E:Exception do
            begin
              if not ErrorFlag then ErrorFlag:=true;
              AddBillMsg('��ⵥ',-1,E.Message);
            end;
          end;

          //�ϱ�������
          try
            iRet:=SendChangeDetail;
            AddBillMsg('������',iRet);
          except
            on E:Exception do
            begin
              if not ErrorFlag then ErrorFlag:=true;
              AddBillMsg('������',-1,E.Message);
            end;
          end;
          EndLogShopReport(true,ErrorFlag); //д��ǰ�ϱ������־
        end else
          EndLogShopReport(False); //û�ж�Ӧ��д��־
      except
        on E: Exception do
        begin
          WriteLogFile(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    DBLock(False); //����
    WriteToReportLogFile('ҵ����ˮ����');
  end;
end;

procedure TBillSyncFactory.SetTempTableName(const Value: string);
begin
  FTempTableName := Value;
end;

procedure TBillSyncFactory.SetBillType(const Value: string);
begin
  FBillType := Value;
end;

procedure TBillSyncFactory.SetBillKeyField(const Value: string);
begin
  FBillKeyField := Value;
end;

procedure TBillSyncFactory.SetBillMainTable(const Value: string);
begin
  FBillMainTable := Value;
end;

     
////�ϱ���̨��(type='00') [������̨�˱� ����̨�ʱ�û�а��½������ϱ���2011.06.03]
function TBillSyncFactory.SendMonthReck: integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string;      //sessionǰ׺����
  Str,MonthTab,ReckMonth,SHOP_IDS: string;
begin
  result := -1;
  UpiRet:=0;
  //���ص�ǰ�ŵ���ͬ���֤��һ����:SHOP_IDS
  SHOP_IDS:=GetShop_IDS(RimParam.TenID,RimParam.LICENSE_CODE);  

  //��һ��: ����̨����ʱ[INF_RECKMONTH]:
  case DbType of
   1:
    begin
      Session:='';
      ReckMonth:='to_char(A.MONTH) ';
      if ExecSQL(PChar('truncate table INF_RECKMONTH'),iRet)<>0 then Raise Exception.Create(GetLastError);
    end;
   4:
    begin
      Session:='session.';
      ReckMonth:='ltrim(rtrim(char(A.MONTH))) ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKMONTH ('+
             'TENANT_ID INTEGER NOT NULL,'+         //R3��ҵID
             'LICENSE_CODE VARCHAR(50) NOT NULL,'+  //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3�ŵ�ID�ĺ���λ
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //RIM���ۻ�ID
             'ITEM_ID VARCHAR(30) NOT NULL,'+       //RIM��ƷID
             'GODS_ID CHAR(36) NOT NULL,'+          //R3��ƷID
             'UNIT_CALC DECIMAL (18,6),'+           //��Ʒ������λ�������λ����ֵ
             'RECK_MONTH VARCHAR(8) NOT NULL'+      //̨���·�
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����INF_RECKMONTH����:'+GetLastError);
    end;
  end;

  //����ʱ���:
  MaxStmp:=GetMaxNUM('00',RimParam.ComID, RimParam.CustID, RimParam.ShopID); //����ʱ����͸���ʱ���
  //��ɾ����ʷ����:
  Str:='delete from '+Session+'INF_RECKMONTH where TENANT_ID='+RimParam.TenID+' and LICENSE_CODE='''+RimParam.LICENSE_CODE+''' ';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���INF_RECKMONTH����:'+GetLastError);

  //�ڶ���: ����ʱ�����̨�ʲ�����ʱ��:
  //��̨�˱�
  MonthTab:='select M.* from RCK_GOODS_MONTH M,RCK_MONTH_CLOSE C where M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and M.MONTH=C.MONTH and '+
            ' M.TENANT_ID='+RimParam.TenID+' and M.SHOP_ID in ('+SHOP_IDS+') and C.TIME_STAMP>'+MaxStmp;
  //������ʱ��
  Str:='insert into '+Session+'INF_RECKMONTH(TENANT_ID,LICENSE_CODE,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_MONTH) '+
       'select A.TENANT_ID,'''+RimParam.LICENSE_CODE+''' as LICENSE_CODE,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,('+GetDefaultUnitCalc+') as UNIT_CALC,'+ReckMonth+' as RECK_MONTH '+
       ' from ('+MonthTab+') A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����INF_RECKMONTH����:'+GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit;   //û���ϱ�����ʱ���˳�;  
  end;

  //������: ��ɾ����ʷ�ڲ���:
  //1����ɾ��RIM��̨�˱����Ҫ�����ϱ���¼:
  Str:='delete from RIM_CUST_MONTH A where A.COM_ID='''+RimParam.ComID+''' and A.CUST_ID='''+RimParam.CustID+''' and '+
       ' MONTH in (select distinct MONTH from '+Session+'INF_RECKMONTH where TENANT_ID='+RimParam.TenID+' and LICENSE_CODE='''+RimParam.LICENSE_CODE+''')';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷRIM_CUST_MONTH����'+GetLastError);

  //2�������ϱ���¼:
  MonthTab:=
    'select a.TENANT_ID,a.MONTH,b.SECOND_ID as ITEM_ID,'+
         'cast(sum(ORG_AMT) as decimal(18,3)) as ORG_AMT,'+
         'cast(sum(ORG_MNY) as decimal(18,3)) as ORG_MNY,'+
         'cast(sum(STOCK_AMT) as decimal(18,3)) as STOCK_AMT,'+
         'cast(sum(STOCK_MNY) as decimal(18,3)) as STOCK_MNY,'+
         'cast(sum(SALE_AMT) as decimal(18,3)) as SALE_AMT,'+
         'cast(sum(SALE_MNY) as decimal(18,3)) as SALE_MNY,'+
         'cast(sum(SALE_TAX) as decimal(18,3)) as SALE_TAX,'+
         'cast(sum(SALE_RTL) as decimal(18,3)) as SALE_RTL,'+
         'cast(sum(SALE_CST) as decimal(18,3)) as SALE_CST,'+
         'cast(sum(CHANGE1_AMT) as decimal(18,3)) as CHANGE1_AMT,'+
         'cast(sum(CHANGE1_MNY) as decimal(18,3)) as CHANGE1_MNY,'+
         'cast(sum(CHANGE2_AMT) as decimal(18,3)) as CHANGE2_AMT,'+
         'cast(sum(CHANGE2_MNY) as decimal(18,3)) as CHANGE2_MNY,'+
         'cast(sum(CHANGE3_AMT) as decimal(18,3)) as CHANGE3_AMT,'+
         'cast(sum(CHANGE3_MNY) as decimal(18,3)) as CHANGE3_MNY,'+
         'cast(sum(CHANGE4_AMT) as decimal(18,3)) as CHANGE4_AMT,'+
         'cast(sum(CHANGE4_MNY) as decimal(18,3)) as CHANGE4_MNY,'+
         'cast(sum(CHANGE5_AMT) as decimal(18,3)) as CHANGE5_AMT,'+
         'cast(sum(CHANGE5_MNY) as decimal(18,3)) as CHANGE5_MNY,'+    
         'cast(sum(DBIN_AMT) as decimal(18,3)) as DBIN_AMT,'+
         'cast(sum(DBIN_MNY) as decimal(18,3)) as DBIN_MNY,'+
         'cast(sum(DBOUT_AMT) as decimal(18,3)) as DBOUT_AMT,'+
         'cast(sum(DBOUT_MNY) as decimal(18,3)) as DBOUT_MNY,'+
         'cast(sum(BAL_AMT) as decimal(18,3)) as BAL_AMT,'+
         'cast(sum(BAL_MNY) as decimal(18,3)) as BAL_MNY,'+
         'cast(sum(SALE_PRF) as decimal(18,3)) as SALE_PRF '+
     ' from RCK_GOODS_MONTH a,VIW_GOODSINFO b '+
     ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+RimParam.TenID+' and a.SHOP_ID in ('+SHOP_IDS+') and a.TIME_STAMP>'+MaxStmp+' '+
     ' group by a.TENANT_ID,a.MONTH,b.SECOND_ID';

  Str:=
    'insert into RIM_CUST_MONTH('+
        'COM_ID,CUST_ID,TERM_ID,ITEM_ID,MONTH,PRI3,PRI4,PRI_SOLD,AMT_GROSS_PROFIT_THEO,'+ //1:
        'QTY_IOM,AMT_IOM,'+              //2: �ڳ����������
        'QTY_PURCH,AMT_PURCH,'+          //3: ������������
        'QTY_SOLD,AMT_SOLD_WITH_TAX,'+   //4: ������������˰���
        'QTY_PROFIT,AMT_PROFIT,'+        //5: �������������
        'QTY_LOSS,AMT_LOSS,'+            //6: �������������
        'QTY_TAKE,AMT_TAKE,'+            //7: �������������
        'QTY_TRN_IN,AMT_TRN_IN,'+        //8: �������������
        'QTY_TRN_OUT,AMT_TRN_OUT,'+      //9: �������������
        'QTY_EOM,AMT_EOM,'+              //10: ��ĩ���������
        'UNIT_COST,SUMCOST_SOLD,'+       //11: ��λ�ɱ������۳ɱ�
        'AMT_GROSS_PROFIT,AMT_PROFIT_COM)'+  //12:ë�������ë��
    'select B.COM_ID,B.CUST_ID,SHORT_SHOP_ID,B.ITEM_ID,B.RECK_MONTH,0 as PRI3,0 as PRI4,0 as PRI_SOLD,0 as AMT_GROSS_PROFIT_THEO,'+     //1:
        '(case when B.UNIT_CALC>0 then ORG_AMT/B.UNIT_CALC else ORG_AMT end)as ORG_AMT,ORG_MNY,'+           //2:�ڳ����������
        '(case when B.UNIT_CALC>0 then STOCK_AMT/B.UNIT_CALC else STOCK_AMT end)as STOCK_AMT,STOCK_MNY,'+  //3:������������
        '(case when B.UNIT_CALC>0 then SALE_AMT/B.UNIT_CALC else SALE_AMT end)as SALE_AMT,(SALE_MNY+SALE_TAX)as SALE_TTL,'+  //4:������������˰���
        '(case when CHANGE1_AMT>0 then (case when B.UNIT_CALC>0 then CHANGE1_AMT/B.UNIT_CALC else CHANGE1_AMT end) else 0 end) as CHANGE1_AMT,(case when CHANGE1_AMT>0 then CHANGE1_MNY else 0 end) as CHANGE1_MNY,'+    //5: �������������
        '(case when CHANGE1_AMT<0 then (case when B.UNIT_CALC>0 then -CHANGE1_AMT/B.UNIT_CALC else -CHANGE1_AMT end) else 0 end) as CHANGE11_AMT,(case when CHANGE1_AMT<0 then -CHANGE1_MNY else 0 end) as CHANGE11_MNY,'+ //6: �������������
        '(case when B.UNIT_CALC>0 then (CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)/B.UNIT_CALC else CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT end)as CHANGE_AMT,(CHANGE2_MNY+CHANGE3_MNY+CHANGE3_MNY+CHANGE4_MNY+CHANGE5_MNY) as CHANGE_MNY,'+ //7: �������������
        '(case when B.UNIT_CALC>0 then DBIN_AMT/B.UNIT_CALC else DBIN_AMT end)as DBIN_AMT,DBIN_MNY,'+      //8: �������������
        '(case when B.UNIT_CALC>0 then DBOUT_AMT/B.UNIT_CALC else DBOUT_AMT end)as DBOUT_AMT,DBOUT_MNY,'+  //9: �������������
        '(case when B.UNIT_CALC>0 then BAL_AMT/B.UNIT_CALC else BAL_AMT end)as BAL_AMT,BAL_MNY,'+          //10: ��ĩ���������
        '(case when (case when B.UNIT_CALC>0 then SALE_AMT/B.UNIT_CALC else SALE_AMT end)>0 then SALE_CST*1.0/cast((case when B.UNIT_CALC>0 then SALE_AMT/B.UNIT_CALC else SALE_AMT end) as decimal(18,3)) else SALE_CST end) as PJ_CST,'+ //��λ�ɱ�[]
        'SALE_CST,'+          //11: ��λ�ɱ������۳ɱ�
        'SALE_PRF,0 '+        //12: ë�������ë��
    'from ('+MonthTab+') A,'+Session+'INF_RECKMONTH B '+   //RCK_GOODS_MONTH
    ' where A.TENANT_ID=B.TENANT_ID and A.ITEM_ID=B.ITEM_ID and '+ReckMonth+'=B.RECK_MONTH ';
  if ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('�ϱ���̨�˳���:'+GetLastError);

  //3��������̨�ʱ�Ǻ��ϱ�ʱ���:[]
  if TWO_PHASE_COMMIT then //�ֲ�ʽ�����ύ
  begin
    BeginTrans;
    try
      //����̨���ϱ��ı��λ:COMM�ĵ�1λ����Ϊ��1
      Str:='update RCK_MONTH_CLOSE A set COMM='+GetUpCommStr(DbType)+'  '+
           ' where A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID in ('+SHOP_IDS+') and '+ReckMonth+' in '+
           ' (select distinct RECK_MONTH from '+Session+'INF_RECKMONTH INF where INF.TENANT_ID='+RimParam.TenID+' and LICENSE_CODE='''+RimParam.LICENSE_CODE+''')';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����RCK_MONTH_CLOSE.COMM����:'+GetLastError);
    
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' '+
           ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TYPE=''00'' and TERM_ID='''+RimParam.ShopID+''' ';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨��RIM_R3_NUM.MAX_NUM����:'+GetLastError);

      CommitTrans; //�ύ����
      result:=UpiRet;
    except
      on E:Exception do
      begin
        RollbackTrans;
        WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'00','�ϱ���̨�ʴ���','02'); //д��־
        Raise Exception.Create(E.Message);
      end;
    end;
  end else //���������ύ
  begin
    ComTrans:=False;
    try
      //����̨���ϱ��ı��λ:COMM�ĵ�1λ����Ϊ��1
      Str:='update RCK_MONTH_CLOSE A set COMM='+GetUpCommStr(DbType)+'  '+
           ' where A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID in ('+SHOP_IDS+') and '+ReckMonth+' in '+
           ' (select distinct RECK_MONTH from '+Session+'INF_RECKMONTH INF where INF.TENANT_ID='+RimParam.TenID+' and LICENSE_CODE='''+RimParam.LICENSE_CODE+''')';
      ComTrans:=ExecTransSQL(Str,iRet,'����RCK_MONTH_CLOSE.COMM����:');
      if ComTrans then
      begin
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' '+
             ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TYPE=''00'' and TERM_ID='''+RimParam.ShopID+''' ';
        ExecTransSQL(Str,iRet,'������̨��RIM_R3_NUM.MAX_NUM����:');
      end;
      result:=UpiRet;
    except
      on E:Exception do
      begin
        WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'00','�ϱ���̨�ʴ���','02'); //д��־
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
  //ִ�гɹ�д��־:
  WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE,RimParam.CustID,'00','�ϱ���̨�ʳɹ�','01');
end;
              

//////�ϱ�POS���۵� (type='01')
function TBillSyncFactory.SendSalesDetail: integer;
var
  iRet,UpiRet: integer;     //����ExeSQLӰ������м�¼
  Session: string;          //sessionǰ׺
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
      if ExecSQL(PChar('truncate table INF_SALE'),iRet)<>0 then Raise Exception.Create('�����ʱ��INF_SALE����:'+GetLastError);
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='ltrim(rtrim(char(A.SALES_DATE))) as SALES_DATE ';
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
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�[INF_SALE]����:'+GetLastError);
    end;
  end;

  //��ʼ������
  BillType:='01'; //������ˮ
  TempTableName:=Session+'INF_SALE';  //��ʱ��
  BillMainTable:='SAL_SALESORDER';    //��������
  BillKeyField:='SALES_ID';           //����ؼ��ֶ�
  INFKeyField:='SALES_ID';            //�м��ؼ��ֶ�
  BeginPrepare; //ȡʱ�����ɾ����ʱ������

  str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE)'+
       'select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,A.SALES_ID,'+SALES_DATE+',B.CUST_CODE '+
       ' from SAL_SALESORDER A left outer join PUB_CUSTOMER B on A.CLIENT_ID=B.CUST_ID '+
       ' where A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' and A.SALES_TYPE in (1,3,4) and A.COMM not in (''02'',''12'') and '+
       ' A.TIME_STAMP>'+MaxStmp+' ';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ�����:'+GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
  end;

  //1���ϱ�ǰɾ����ʷ���ݣ�
  Str:='delete from RIM_RETAIL_DETAIL where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���۵���ͷ����'+GetLastError);
  Str:='delete from RIM_RETAIL_INFO where Exists(select A.SALES_ID from '+Session+'INF_SALE A where RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���۵��������'+GetLastError);

  //2���������۵���ͷ:                                                                       //R3_NUM, -->SALES_ID,
  Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
     ' select A.SALES_ID,'''','''',B.CUST_ID,SHORT_SHOP_ID,B.COM_ID,coalesce(INTEGRAL,0),B.SALE_DATE,B.CUST_CODE,B.SALE_DATE,'+
             '(case when (length(CREA_DATE)>12) then substr(CREA_DATE,12,length(CREA_DATE)-12) else ''00:00:00'' end) as PUH_TIME,'+
             '''admin'' as CREA_USER,(case when A.SALES_TYPE=3 then ''02'' else ''01'' end) as SALES_TYPE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',SHORT_SHOP_ID '+
     ' from SAL_SALESORDER A,'+Session+'INF_SALE B '+
     ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('�����۵���ͷ����:'+GetLastError);

  //3���������۵�����:
  DetailTab:=
     'select S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID,INF.SALE_DATE,INF.SHORT_SHOP_ID from SAL_SALESDATA S,'+Session+'INF_SALE INF '+
     ' where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.SALES_ID=INF.SALES_ID and '+
     ' S.TENANT_ID='+RimParam.TenID+' and S.SHOP_ID='''+RimParam.ShopID+''' ';

  Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE,TREND_ID)'+
       ' select A.SALES_ID,A.SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID, '+
       ' A.COST_PRICE,A.APRICE,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,A.SALE_DATE,A.TREND_ID '+ //'''+FormatDatetime('YYYYMMDD',Date())+'''
       ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
       ' B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵��������'+GetLastError);

  //4�������ϱ�ʱ����͵���COMM:
  if CommitReportTrans then
    result:=UpiRet;
end;


//�ϱ������� (type='04') {˵��: ��R3���ʱ�ѵ��뵱��Ϊ��ⵥ���洢��������������Ϊ���ⵥ���洢�����۵�;ͬ��ʱ���������� }
function TBillSyncFactory.SenddbInDetail: integer;
var
  iRet,UpiRet: integer; //����ExeSQLӰ������м�¼
  Session: string;      //sessionǰ׺  
  Str,BillDate: string;
  DetailTab: string;    //������ϸ����Ʒ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵�����������ʱ[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(STOCK_DATE) as STOCK_DATE ';
      if ExecSQL(PChar('truncate table INF_DB'),iRet)<>0 then Raise Exception.Create('�����ʱ��INF_DB����:'+GetLastError);
    end;
   4:
    begin
      Session:='session.';
      BillDate:='ltrim(rtrim(char(STOCK_DATE))) as STOCK_DATE ';
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
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ[INF_SALE]����');
    end;
  end;

  //��ʼ������
  BillType:='04'; //���뵥
  TempTableName:=Session+'INF_DB';  //��ʱ��
  BillMainTable:='STK_STOCKORDER';
  BillKeyField:='STOCK_ID';
  INFKeyField:='DB_ID';            //�м��ؼ��ֶ�  
  BeginPrepare;  //ȡʱ�����ɾ����ʱ������

  str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE)'+
       'select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,STOCK_ID,STOCK_ID || ''_1'' as DB_NEWID,'+BillDate+' from '+
       ' STK_STOCKORDER where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������뵥[INF_DB]����'+GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit; //û���ϱ�����ʱ���˳�;     //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
  end;

  //1���ϱ�ǰɾ����ʷ���ݣ�
  Str:='delete from RIM_CUST_TRN where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���뵥��ͷ����'+GetLastError);
  Str:='delete from RIM_CUST_TRN_LINE where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���뵥�������'+GetLastError);

  //2������������룩����ͷ:
  Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
     ' select B.DB_NEWID,B.CUST_ID,''2'' as vTYPE,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.DB_DATE,''admin'' as CREA_USER,B.DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
     ' from STK_STOCKORDER A,'+Session+'INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.DB_ID and '+
     ' A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('���������������ͷ����'+GetLastError);

  //3���������۱���:
  DetailTab:='select INF.DB_NEWID,S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID from STK_STOCKDATA S,'+Session+'INF_DB INF where S.TENANT_ID=INF.TENANT_ID and S.STOCK_ID=INF.DB_ID and '+
             ' S.TENANT_ID='+RimParam.TenID+' and S.SHOP_ID='''+RimParam.ShopID+''' ';

  Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
       ' select A.DB_NEWID,SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID,'+
       ' A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
       ' order by B.GODS_CODE';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������룩����������[RIM_CUST_TRN_LINE]����'+GetLastError);

  //4�������ϱ�ʱ����͵���COMM:
  if CommitReportTrans then
    result:=UpiRet;
end;

//�ϱ������� (type='12')  ���ݺ���=SALES_ID + _2 {˵��: ��R3���ʱ�ѵ��뵱��Ϊ��ⵥ���洢��������������Ϊ���ⵥ���洢�����۵�;ͬ��ʱ���������� }
function TBillSyncFactory.SenddbOutDetail: integer;
var
  iRet,UpiRet: integer;  //����ExeSQLӰ������м�¼
  Session: string;       //sessionǰ׺
  Str, BillDate: string;
  DetailTab: string;     //������ϸ����Ʒ��
begin
  result := -1;
  UpiRet:=0;

  //��һ��: �������۵�����������ʱ[INF_SALE]:
  case DbType of
   1:
    begin
      Session:='';
      BillDate:='to_char(SALES_DATE) as SALES_DATE ';
      if ExecSQL(PChar('truncate table INF_DB'),iRet)<>0 then Raise Exception.Create('�����ʱ��INF_DB����:'+GetLastError);
    end;
   4:
    begin
      Session:='session.';
      BillDate:='ltrim(rtrim(char(SALES_DATE))) as SALES_DATE ';
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
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ[INF_SALE]����');
    end;
  end;

  //��ʼ������
  BillType:='12'; //���뵥
  TempTableName:=Session+'INF_DB';  //��ʱ��
  BillMainTable:='SAL_SALESORDER';
  BillKeyField:='SALES_ID';
  INFKeyField:='DB_ID';            //�м��ؼ��ֶ�  
  BeginPrepare;   //ȡʱ�����ɾ����ʱ������

  str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE)'+
       'select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,SALES_ID,SALES_ID || ''_2'' as DB_NEWID,'+BillDate+' from '+
       ' SAL_SALESORDER where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and SALES_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������[INF_DB]����'+GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
  end;

  //1���ϱ�ǰɾ����ʷ���ݣ�
  Str:='delete from RIM_CUST_TRN where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��������ͷ����'+GetLastError);
  Str:='delete from RIM_CUST_TRN_LINE where Exists(select 1 from '+Session+'INF_DB A where RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�������������'+GetLastError);

  //2������������룩����ͷ:
  Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
     ' select B.DB_NEWID,B.CUST_ID,''2'' as vTYPE,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.DB_DATE,''admin'' as CREA_USER,B.DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
     ' from SAL_SALESORDER A,'+Session+'INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.DB_ID and '+
     ' A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('�����������ͷ����'+GetLastError);

  //3���������۱���:
  DetailTab:='select INF.DB_NEWID,S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID from SAL_SALESDATA S,'+Session+'INF_DB INF where S.TENANT_ID=INF.TENANT_ID and S.SALES_ID=INF.DB_ID and '+
             ' S.TENANT_ID='+RimParam.TenID;
  Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
       ' select A.DB_NEWID,SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID,'+
       ' A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
       ' order by B.GODS_CODE ';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����������������������[RIM_CUST_TRN_LINE]����'+GetLastError);

  //4�������ϱ�ʱ����͵���COMM:
  if CommitReportTrans then
    result:=UpiRet; 
end;

//�ϱ���ⵥ [type='05']
function TBillSyncFactory.SendStockDetail: integer;
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
      if ExecSQL(PChar('truncate table INF_STOCK'),iRet)<>0 then Raise Exception.Create('�����ʱ��INF_STOCK����:'+GetLastError);
    end;
   4:
    begin
      Session:='session.';
      BillDate:='ltrim(rtrim(char(STOCK_DATE))) as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+         //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+       //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+        //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+       //���ۻ�ID
             'STOCK_ID CHAR(36) NOT NULL,'+         //��ⵥID
             'STOCK_DATE CHAR(8) NOT NULL'+         //�������
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������ⵥ��ʱ��[INF_STOCK]����');
    end;
  end;

  BillType:='05'; //���뵥
  TempTableName:=Session+'INF_STOCK';  //��ʱ��
  BillMainTable:='STK_STOCKORDER';     //�������
  BillKeyField:='STOCK_ID';   //����ؼ��ֶ�
  INFKeyField:='STOCK_ID';    //�м��ؼ��ֶ�
  BeginPrepare;    //ȡʱ�����ɾ����ʱ������

  str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,STOCK_ID,STOCK_DATE)'+
     'select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,STOCK_ID,'+BillDate+' from '+
     ' STK_STOCKORDER where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and STOCK_TYPE in (1,3) and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert��ⵥ[INF_STOCK]����'+GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
  end;

  //1���ϱ�ǰɾ����ʷ���ݣ�
  Str:='delete from RIM_VOUCHER where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER.VOUCHER_NUM=A.STOCK_ID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��ⵥ��ͷ����'+GetLastError);
  Str:='delete from RIM_VOUCHER_LINE where Exists(select 1 from '+Session+'INF_STOCK A where RIM_VOUCHER_LINE.VOUCHER_NUM=A.STOCK_ID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��ⵥ�������'+GetLastError);

  //2��Insert��ⵥ��ͷ:
  Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
     ' select A.STOCK_ID,'' '' as RETAIL_NUM,B.CUST_ID,B.COM_ID,B.SHORT_SHOP_ID,''02'',B.STOCK_DATE,''admin'' as CREA_USER,B.STOCK_DATE,'+
     ' (case when STOCK_TYPE=3 then ''02'' else ''01'' end) as STOCK_TYPE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,B.SHORT_SHOP_ID '+
     ' from STK_STOCKORDER A,'+Session+'INF_STOCK B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.STOCK_ID and '+
     ' A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('�����������ͷ[RIM_VOUCHER]����');

  //3������ⵥ����:
  DetailTab:='select S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID from STK_STOCKDATA S,'+Session+'INF_STOCK INF where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.STOCK_ID=INF.STOCK_ID and '+
             ' S.TENANT_ID='+RimParam.TenID+' and S.SHOP_ID='''+RimParam.ShopID+''' ';

  Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
       ' select A.STOCK_ID,SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID,'+
       ' A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
       ' order by B.GODS_CODE ';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������������[RIM_VOUCHER_LINE]����');

  //4�������ϱ�ʱ����͵���COMM:
  if CommitReportTrans then
    result:=UpiRet;  
end;

//�ϱ�������  (type='07')
function TBillSyncFactory.SendChangeDetail: integer;
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
      if ExecSQL(PChar('truncate table INF_CHANGE'),iRet)<>0 then Raise Exception.Create('�����ʱ��INF_CHANGE����:'+GetLastError);
    end;
   4:
    begin
      Session:='session.';
      BillDate:='ltrim(rtrim(char(CHANGE_DATE))) as CHANGE_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_CHANGE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'CHANGE_ID CHAR(36) NOT NULL,'+      //RIM������ID
             'CHANGE_DATE CHAR(8) NOT NULL'+         //�������
        ') ON COMMIT PRESERVE ROWS NOT LOGGED WITH REPLACE ';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������������ʱ[INF_CHANGE]����');
    end;
  end;

  BillType:='07'; //������
  TempTableName:=Session+'INF_CHANGE';  //��ʱ��
  BillMainTable:='STO_CHANGEORDER';     //�������
  BillKeyField:='CHANGE_ID';      //����ؼ��ֶ�
  INFKeyField:='CHANGE_ID';       //�м��ؼ��ֶ�
  BeginPrepare;        //ȡʱ�����ɾ����ʱ������

  str:='insert into '+Session+'INF_CHANGE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,CHANGE_ID,CHANGE_DATE)'+
     ' select '+RimParam.TenID+' as TENANT_ID,'''+RimParam.ShopID+''' as SHOP_ID,'''+RimParam.SHORT_ShopID+''' as SHORT_SHOP_ID,'''+RimParam.ComID+''' as COM_ID,'''+RimParam.CustID+''' as CUST_ID,CHANGE_ID,'+BillDate+' from '+
     ' STO_CHANGEORDER where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStmp;
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('Insert��ⵥ[INF_CHANGE]����'+GetLastError);
  if iRet=0 then
  begin
    result:=0; //����û�п��ϱ�����
    Exit; //û���ϱ�����ʱ���˳�;  //Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��
  end;

  //1���ϱ�ǰɾ����ʷ���ݣ�
  Str:='delete from RIM_ADJUST_INFO where Exists(select 1 from '+Session+'INF_CHANGE A where RIM_ADJUST_INFO.ADJUST_NUM=A.CHANGE_ID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ��������ͷ����'+GetLastError);
  Str:='delete from RIM_ADJUST_DETAIL where Exists(select 1 from '+Session+'INF_CHANGE A where RIM_ADJUST_DETAIL.ADJUST_NUM=A.CHANGE_ID)';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�������������'+GetLastError);

  //2�������������ͷ:                                                //R3_NUM, --> CHANGE_ID,
  Str:='insert into RIM_ADJUST_INFO(ADJUST_NUM,CUST_ID,COM_ID,TERM_ID,TYPE,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
     ' select A.CHANGE_ID,'''+RimParam.CustID+''' as CUST_ID,'''+RimParam.ComID+''' as COM_ID,B.SHORT_SHOP_ID,'+
     ' (case when CHANGE_CODE=''01'' then ''02'' else ''03'' end) as CHANGE_CODE,''02'',B.CHANGE_DATE,''admin'' as CREA_USER,B.CHANGE_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,SHORT_SHOP_ID '+
     ' from STO_CHANGEORDER A,'+Session+'INF_CHANGE B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.CHANGE_ID=B.CHANGE_ID and '+
     ' A.TENANT_ID='+RimParam.TenID+' and A.SHOP_ID='''+RimParam.ShopID+''' ';
  if ExecSQL(PChar(Str),UpiRet)<>0 then Raise Exception.Create('���롼����������ͷ[RIM_ADJUST_INFO]���󣡣�SQL='+str+'��');

  //3���������������:
  DetailTab:='select S.*,'+GetR3ToRimUnit_ID(DbType,'S.UNIT_ID')+' as UM_ID from STO_CHANGEDATA S,'+Session+'INF_CHANGE INF where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.CHANGE_ID=INF.CHANGE_ID and '+
             ' S.TENANT_ID='+RimParam.TenID+' ';

  Str:='insert into RIM_ADJUST_DETAIL(ADJUST_NUM,ADJUST_LINE,COM_ID,ITEM_ID,UM_ID,QTY_ADJUST,QTY_MINI_UM,AMT_ADJUST)'+
       ' select A.CHANGE_ID,SEQNO,'''+RimParam.ComID+''' as COM_ID,B.SECOND_ID,A.UM_ID,'+
       ' A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
       ' from ('+DetailTab+')A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+RimParam.TenID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
       ' order by B.GODS_CODE';
  if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���롼������������[RIM_ADJUST_DETAIL]����'+GetLastError);
 
  //4�������ϱ�ʱ����͵���COMM:
  if CommitReportTrans then
    result:=UpiRet;  
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

function TBillSyncFactory.BeginPrepare: Boolean;
var
  iRet: integer;
  Str: string;
begin
  result:=false;
  //����ʱ����͸���ʱ���:
  MaxStmp:=GetMaxNUM(BillType,RimParam.ComID, RimParam.CustID, RimParam.ShopID);
  //ɾ����ʱ�����ݣ�
  Str:='delete from '+TempTableName+' where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' ';
  if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʱ��'+TempTableName+'�����ݳ���:'+GetLastError);
  result:=true;
end;

function TBillSyncFactory.CommitReportTrans: Boolean;
var
  iRet: integer;
  str, BillName: string;
begin
  result:=false;
  if trim(BillType)='01' then BillName:='���۵�'
  else if trim(BillType)='04' then BillName:='����[��]��'
  else if trim(BillType)='12' then BillName:='����[��]��'
  else if trim(BillType)='05' then BillName:='��ⵥ'
  else if trim(BillType)='07' then BillName:='������';

  if TWO_PHASE_COMMIT then //�ֲ�ʽ�����ύ
  begin
    BeginTrans; //��ʼһ����������:
    try
      //1���������ϱ��ı��λ:COMM�ĵ�1λ����Ϊ��1
      Str:='update '+BillMainTable+' set COMM='+GetUpCommStr(DbType)+' '+
           ' where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and '+
           ' exists(select 1 from '+TempTableName+' INF where '+BillMainTable+'.TENANT_ID=INF.TENANT_ID and '+BillMainTable+'.SHOP_ID=INF.SHOP_ID and '+BillMainTable+'.'+BillKeyField+'=INF.'+INFKeyField+')';
      if ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('����ͨ�ű��:'+GetLastError);

      //2�����µ��ݿ��Ʊ�
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' '+
           ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TYPE='''+BillType+''' and TERM_ID='''+RimParam.ShopID+''' ';
      if ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����ϱ�ʱ�������:'+GetLastError);

      CommitTrans;  //�ύ����
      result:=true;
    except
      on E:Exception do
      begin
        RollbackTrans;
        WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE, RimParam.CustID, BillType ,'�ϱ�'+BillName+'����','02');  //д��־
        Raise Exception.Create(E.Message);
      end;
    end;
  end else  //������������
  begin
    try
      //1���������ϱ��ı��λ:COMM�ĵ�1λ����Ϊ��1
      Str:='update '+BillMainTable+' set COMM='+GetUpCommStr(DbType)+' '+
           ' where TENANT_ID='+RimParam.TenID+' and SHOP_ID='''+RimParam.ShopID+''' and '+
           ' exists(select 1 from '+TempTableName+' INF where '+BillMainTable+'.TENANT_ID=INF.TENANT_ID and '+BillMainTable+'.SHOP_ID=INF.SHOP_ID and '+BillMainTable+'.'+BillKeyField+'=INF.'+INFKeyField+')';
      ComTrans:=ExecTransSQL(Str,iRet,'����ͨ�ű��:'); 

      //2�����µ��ݿ��Ʊ�
      if ComTrans then
      begin
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStmp+''',UPDATE_TIME='''+UpdateTime+''' '+
             ' where COM_ID='''+RimParam.ComID+''' and CUST_ID='''+RimParam.CustID+''' and TYPE='''+BillType+''' and TERM_ID='''+RimParam.ShopID+''' ';
        ExecTransSQL(Str,iRet,'����RIM_R3_NUM����:'); 
      end;
      result:=true;
    except
      on E:Exception do
      begin
        WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE, RimParam.CustID, BillType ,'�ϱ�'+BillName+'����','02');  //д��־
        Raise Exception.Create(E.Message);
      end;
    end;
  end;

  //ִ�гɹ�д��־:
  WriteToRIM_BAL_LOG(RimParam.LICENSE_CODE, RimParam.CustID, BillType ,'�ϱ�'+BillName+'�ɹ���','01');
end;

procedure TBillSyncFactory.SetINFKeyField(const Value: string);
begin
  FINFKeyField := Value;
end;

procedure TBillSyncFactory.SetAutoCheckReport(const Value: Boolean);
begin
  FAutoCheckReport:=Value;
end;


function TBillSyncFactory.CheckReportBill: Boolean;
begin


end;

function TBillSyncFactory.GetMaxReckDay: string;
begin

end;

end.

 







