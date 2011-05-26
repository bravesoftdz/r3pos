{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uBillFactory;

interface

uses                 
  SysUtils,Classes,zDataSet,ufnUtil,uPlugInUtil;

             

procedure CallBillSync(PlugIntf:IPlugIn; InParams: string);   //�ϱ���������



implementation


//�����ϱ�ɾ����ʷ����
function DeleteExistsReportedBill(PlugIntf:IPlugIn; MainTable,DetailTable,KeyFieldName,BillNum: string): Boolean;
var
  iRet: integer;
  MsgStr: string;
  MainSQL,DetailSQL: Pchar;
begin
  result:=False;
  try
    MainSQL:=Pchar('delete from '+MainTable+' where '+KeyFieldName+'='''+BillNum+''' ');
    if PlugIntf.ExecSQL(MainSQL,iRet)<>0 then Raise Exception.Create(Pchar('ɾ����'+MainTable+'�����ţ�'+BillNum+'��ִ�г��� '));   
    DetailSQL:=Pchar('delete from '+DetailTable+' where '+KeyFieldName+'='''+BillNum+''' ');
    if PlugIntf.ExecSQL(MainSQL,iRet)<>0 then Raise Exception.Create(Pchar('ɾ����'+DetailTable+'�����ţ�'+BillNum+'��ִ�г��� '));   
    result:=true;
  except
    on E:Exception do
    begin
      MsgStr:=E.Message;
      if Pos('ɾ����',MsgStr)>0 then
        Raise Exception.Create(E.Message) 
      else
        Raise Exception.Create(Pchar('ɾ����ʷ���ݡ�������'+MainTable+'��'+DetailTable+'�����ݺţ�'+BillNum+'��ִ�г���'+E.Message));
    end;
  end;
end;


{============================ ����Ϊ�ϱ�RIMҵ�񵥾� [DB2\ORACLE] ==============================}
//////2011.04.14 AM�ϱ���̨��  (type='00')
function SendMonthReck(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE:string; iDbType: integer):boolean;
var
  iRet: integer;    //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺����
  MaxStamp,      //���ϱ����ʱ���
  UpMaxStamp,    //�����ϱ����ʱ���
  Str,
  Short_ID: string;
begin
  result := false;
  MaxStamp:=GetMaxNUM(PlugIntf,'00',SHOP_ID,ORGAN_ID,CustID); //������̨�����ʱ���
  Short_ID:=Copy(SHOP_ID,Length(SHOP_ID)-3,4);  //�ŵ�ID�ĺ���λ

  //��һ��: ����̨����ʱ[INF_RECKMONTH]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_RECKMONTH ('+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3�ŵ�ID�ĺ���λ
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'ITEM_ID VARCHAR(30) NOT NULL,'+     //RIM��ƷID
             'GODS_ID CHAR(36) NOT NULL,'+        //R3��ƷID
             'UNIT_CALC DECIMAL (18,6),'+         //��Ʒ������λ�������λ����ֵ
             'RECK_MONTH VARCHAR(8) NOT NULL, '+  //̨���·�
             'TIME_STAMP bigint NOT NULL'+       //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨����ʱ�����'+PlugIntf.GetLastError);
    end;
  end;
  
  //�ڶ���: ����ʱ�����̨�ʲ�����ʱ��:
  Str:='insert into '+Session+'INF_RECKMONTH(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,UNIT_CALC,RECK_MONTH,TIME_STAMP) '+
       'select A.TENANT_ID,A.SHOP_ID,'''+Short_ID+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,('+GetDefaultUnitCalc+') as UNIT_CALC,trim(char(A.MONTH)) as RECK_MONTH,A.TIME_STAMP  '+
       ' from RCK_GOODS_MONTH A,VIW_GOODSINFO B '+
       ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.TENANT_ID='+TENANT_ID+
       ' and A.SHOP_ID='''+SHOP_ID+''' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+'  and A.TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨����ʱ�����:'+PlugIntf.GetLastError);

  //������: ��ɾ����ʷ�ڲ���:
  if iRet>0 then  
  begin
    //��ȡ�����ϱ����ʱ�����
    UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_RECKMONTH ');
    try
      PlugIntf.BeginTrans;
      //1����ɾ��RIM��̨�˱����Ҫ�����ϱ���¼:
      Str:='delete from RIM_CUST_MONTH A where A.COM_ID='''+ORGAN_ID+''' and A.CUST_ID='''+CustID+''' and '+
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
        'select B.COM_ID,B.CUST_ID,SHORT_SHOP_ID,B.ITEM_ID,trim(char(A.MONTH)) as RECK_MONTH,0,0,0,0,'+ //1:
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
        ' where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and trim(char(A.MONTH))=B.RECK_MONTH and A.TIME_STAMP>'+MaxStamp;
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�ϱ���̨�����ݳ���:'+PlugIntf.GetLastError);

      //3�������ϱ�ʱ���:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''00'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨���ϱ�ʱ�������:'+PlugIntf.GetLastError);
      PlugIntf.CommitTrans; //�ύ����

      //ִ�гɹ�д��־:
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'00','�ϱ���̨�ʳɹ�','01');
      result:=true;
    except
      on E:Exception do
      begin
        PlugIntf.RollbackTrans;
        sleep(1);
        WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'00','�ϱ���̨�ʴ���','02'); //д��־
        Raise Exception.Create(E.Message);
      end;
    end;
  end;
end;

//////�ϱ�POS���۵� (type='01')  
function SendSalesDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  MaxStamp,      //���ϱ����ʱ���
  UpMaxStamp,    //�����ϱ����ʱ���
  SaleID,        //���۵�ID
  CUST_CODE,     //��Ա��
  Str,
  SALES_DATE: string;
  SaleTab,DetailTab, GoodTab: string; //������ϸ����Ʒ��
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'01',SHOP_ID,ORGAN_ID,CustID); //������̨�����ʱ���

  //��һ��: �������۵���POS����ʱ[INF_POS_SALE]:
  case iDbType of
   1:
    begin
      Session:='';
      SALES_DATE:='trim(char(A.SALES_DATE)) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='cast(A.SALES_DATE as varchar(8)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_POS_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+     //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+   //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+   //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+    //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+   //RIM���ۻ�ID
             'SALES_ID CHAR(36) NOT NULL,'+     //RIM�������۵�ID
             'SALE_DATE CHAR (8) NOT NULL,'+    //RIM�������۵�����
             'CUST_CODE varchar (20),'+         //��Ա��
             'TIME_STAMP bigint NOT NULL'+      //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�[INF_POS_SALE]����:'+PlugIntf.GetLastError);
    end;
  end;

  try
    //�ڶ�����ѭ�������м��
    while true do
    begin
      SaleTab:='select SALES_ID,SALES_DATE,TIME_STAMP,IC_CARDNO from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=4 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
      SaleTab:='select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,A.SALES_ID,'+SALES_DATE+',B.CUST_CODE,A.TIME_STAMP from '+
               ' ('+SaleTab+')A left outer join PUB_CUSTOMER B on A.IC_CARDNO=B.CUST_ID order by A.TIME_STAMP ';
      case iDbType of
       1: str:='insert into '+Session+'INF_POS_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE,TIME_STAMP)'+
               'select tp.* from ('+SaleTab+')tp fetch first 100 rows only ';
       4: str:='insert into '+Session+'INF_POS_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,CUST_CODE,TIME_STAMP)'+
               'select tp.* from ('+SaleTab+')where ROWNUM<=100 ';
      end;

      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ�����:'+PlugIntf.GetLastError);
      if iRet=0 then Break; //������û�м�¼���˳�
      UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_POS_SALE ');

      //��ʼ���봦��:
      PlugIntf.BeginTrans; //��ʼһ����������:
      //0�����۵������޸ģ������ر���
      //1���������۱�ͷ:                                                                       //R3_NUM, -->SALES_ID,
      Str:='insert into RIM_RETAIL_INFO(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
         ' select A.SALES_ID,'''','''',B.CUST_ID,SHORT_SHOP_ID,B.COM_ID,coalesce(INTEGRAL,0),B.SALE_DATE,B.CUST_CODE,B.SALE_DATE,(case when length(CREA_DATE)>12 then substr(CREA_DATE,12,length(CREA_DATE)-12) else ''00:00:00'' end) as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',SHORT_SHOP_ID '+
         ' from SAL_SALESORDER A,INF_POS_SALE B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALE_ID=B.SALE_ID and A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����۵���ͷ����:'+PlugIntf.GetLastError);

      //2���������۱���:
      DetailTab:=
         'select S.*,M.UNIT_NAME from SAL_SALESDATA S,INF_POS_SALE INF,VIW_MEAUNITS M '+
         ' where S.TENANT_ID=INF.TENANT_ID and S.TENANT_ID=M.TENANT_ID and S.SHOP_ID=INF.SHOP_ID and S.SALES_ID=INF.SALES_ID and '+
         ' S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID;

      Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE,TREND_ID)'+
           ' select A.SALES_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID, '+
           ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''',A.SHOP_ID '+
           ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
           ' B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����POS���۵��������'+PlugIntf.GetLastError);

      //3�������ϱ�ʱ���:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''01'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����ϱ�ʱ�������:'+PlugIntf.GetLastError);

      PlugIntf.CommitTrans;  //�ύ����
    end;//ѭ��End
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'01','�ϱ�POS���۵��ɹ���','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'01','�ϱ�POS���۵�����','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

////�ϱ����۵��������������� (type='02')
function SendSaleBatchDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  MaxStamp,      //���ϱ����ʱ���
  UpMaxStamp,    //�����ϱ����ʱ���
  SaleID,        //���۵�ID
  Str,
  SALES_DATE: string;
  DetailTab, GoodTab: string; //������ϸ����Ʒ��
  RsINF: TZQuery;     //�м��ѭ��ʹ��
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'02',SHOP_ID,ORGAN_ID,CustID);

  //��һ��: �������۵�����������ʱ[INF_SALE]:
  case iDbType of
   1:
    begin
      Session:='';
      SALES_DATE:='trim(char(A.SALES_DATE)) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='cast(A.SALES_DATE as varchar(8)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+   //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'SALES_ID CHAR(36) NOT NULL,'+       //RIM���۵�ID
             'SALE_DATE CHAR (8) NOT NULL,'+      //RIM���۵�����
             'TIME_STAMP bigint NOT NULL'+        //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ[INF_SALE]����');
    end;
  end;

  //�ڶ�����ѭ�������м��
  try
    while true do
    begin
      case iDbType of
       1:
        begin
          str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
               'select tp.* from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+',TIME_STAMP '+
               ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
               ' order by TIME_STAMP)tp fetch first 100 rows only ';
        end;
       4:
        begin
          str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
               'select * from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+',TIME_STAMP '+
               ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
               ' order by TIME_STAMP) where ROWNUM<=100 ';
        end;
      end;
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�[INF_SALE]����'+PlugIntf.GetLastError);
      if iRet=0 then Break; //������û�м�¼���˳�ѭ��

      //ȡ��ǰѭ�����ʱ���:
      UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_SALE ');

      PlugIntf.BeginTrans;
      //1���ϱ�ǰɾ����ʷ���ݣ�
      Str:='delete from RIM_RETAIL_DETAIL '+
           ' where Exists(select A.SALES_ID from INF_SALE A where RIM_RETAIL_DETAIL.COM_ID=A.COM_ID and RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���۵���ͷ����'+PlugIntf.GetLastError);
      Str:='delete from RIM_RETAIL_INFO '+
           ' where Exists(select A.SALES_ID from INF_SALE A where RIM_RETAIL_INFO.COM_ID=A.COM_ID and RIM_RETAIL_INFO.CUST_ID=A.CUST_ID and RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���۵��������'+PlugIntf.GetLastError);

      //2���������۱�ͷ:
      Str:='insert into RIM_RETAIL_INFO'+                                               //R3_NUM, ---> SALES_ID,
         '(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
         ' select SALES_ID,'' '','' '',B.CUST_ID,B.SHORT_SHOP_ID,B.COM_ID,0,B.SALE_DATE,'' '',B.SALE_DATE,'' '' as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',B.SHORT_SHOP_ID '+
         ' from SAL_SALESORDER A,INF_SALE B where  A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and '+
         ' A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+'''  ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�������ͷ[RIM_RETAIL_INFO]����:'+PlugIntf.GetLastError);

      //3���������۱���:
      DetailTab:=
         'select S.*,M.UNIT_NAME from SAL_SALESDATA S,INF_SALE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=M.SHOP_ID and '+
         ' S.SALES_ID=M.SALES_ID and S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID;
      Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
         ' select A.SALES_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID, '+
         ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
         ' B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵������������:'+PlugIntf.GetLastError);

      //4�������ϱ�ʱ���:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''02'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵��ϱ�ʱ�������');

      PlugIntf.CommitTrans; //�ύ����
    end; //ѭ��End
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'02','�ϱ��������۵��ɹ���','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'02','�ϱ����۵�����������','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//�����˻���  (type='03')            
function SendSaleRetDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  MaxStamp,      //���ϱ����ʱ���
  UpMaxStamp,    //�����ϱ����ʱ���
  SaleID,        //���۵�ID
  Str,
  SALES_DATE: string;
  DetailTab, GoodTab: string; //������ϸ����Ʒ��
  RsINF: TZQuery;     //�м��ѭ��ʹ��
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'03',SHOP_ID,ORGAN_ID,CustID);  

  //��һ��: ���������˻�����ʱ[INF_SALE]:
  case iDbType of
   1:
    begin
      Session:='';
      SALES_DATE:='trim(char(A.SALES_DATE)) as SALES_DATE ';
    end;
   4:
    begin
      Session:='session.';
      SALES_DATE:='cast(A.SALES_DATE as varchar(8)) as SALES_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALE( '+
             'TENANT_ID INTEGER NOT NULL,'+        //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+      //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+ //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+       //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+      //RIM���ۻ�ID
             'SALES_ID CHAR(36) NOT NULL,'+        //RIM���۵�ID
             'SALE_DATE CHAR (8) NOT NULL,'+       //RIM���۵�����
             'TIME_STAMP bigint NOT NULL'+         //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������˻�����ʱ��[INF_SALE]����');
    end;
  end;

  //�ڶ�����ѭ�������м��
  try
    while true do
    begin
      case iDbType of
       1:
        begin
          str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
               'select tp.* from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+',TIME_STAMP '+
               'from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
               ' order by TIME_STAMP)tp fetch first 100 rows only ';
        end;
       4:
        begin
          str:='insert into '+Session+'INF_SALE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,SALES_ID,SALE_DATE,TIME_STAMP)'+
               'select * from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+Copy(SHOP_ID,Length(SHOP_ID)-3,4)+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID,'+SALES_DATE+',TIME_STAMP '+
               'from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
               ' order by TIME_STAMP) where ROWNUM<=100 ';
        end;
      end;
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������˻���[INF_SALE]����'+PlugIntf.GetLastError);
      if iRet=0 then Break; //������û�м�¼���˳�ѭ��

      //ȡ��ǰѭ�����ʱ���:
      UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_SALE ');

      PlugIntf.BeginTrans; //��ʼ����
      //1���ϱ�ǰɾ����ʷ���ݣ�
      Str:='delete from RIM_RETAIL_DETAIL '+
           ' where Exists(select A.SALES_ID from INF_SALE A where RIM_RETAIL_DETAIL.COM_ID=A.COM_ID and RIM_RETAIL_DETAIL.RETAIL_NUM=A.SALES_ID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�����˻�����ͷ����'+PlugIntf.GetLastError);
      Str:='delete from RIM_RETAIL_INFO '+
           ' where Exists(select A.SALES_ID from INF_SALE A where RIM_RETAIL_INFO.COM_ID=A.COM_ID and RIM_RETAIL_INFO.CUST_ID=A.CUST_ID and RIM_RETAIL_INFO.RETAIL_NUM=A.SALES_ID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�����˻����������'+PlugIntf.GetLastError);

      //2���������۱�ͷ:
      Str:='insert into RIM_RETAIL_INFO '+                                               //R3_NUM, ---> SALES_ID,
         '(RETAIL_NUM,CONSUMER_CARD_ID,CONSUMER_ID,CUST_ID,TERM_ID,COM_ID,SCORE,SCORE_DATE,VIP_RTL_CARD_ID,PUH_DATE,PUH_TIME,CRT_USER_ID,TYPE,UPDATE_TIME,R3_NUM)'+
         ' select SALES_ID,'' '','' '',B.CUST_ID,B.SHORT_SHOP_ID,B.COM_ID,0,B.SALE_DATE,'' '',B.SALE_DATE,'' '' as PUH_TIME,CREA_USER,''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''',B.SHORT_SHOP_ID '+
         ' from SAL_SALESORDER A,INF_SALE B where  A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.SALES_ID=B.SALES_ID and '+
         ' A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+'''  ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�������ͷ[RIM_RETAIL_INFO]����:'+PlugIntf.GetLastError);
      //3���������۱���:
      DetailTab:=
         'select S.*,M.UNIT_NAME from SAL_SALESDATA S,INF_SALE INF,VIW_MEAUNITS M where S.TENANT_ID=INF.TENANT_ID and S.SHOP_ID=M.SHOP_ID and '+
         ' S.SALES_ID=M.SALES_ID and S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID;
      Str:='insert into RIM_RETAIL_DETAIL(RETAIL_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,UNIT_COST,RETAIL_PRICE,QTY_SALE,QTY_MINI_UM,AMT,NOTE,PUH_DATE)'+
         ' select A.SALES_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID, '+
         ' A.COST_PRICE,A.APRICE,(case when B.UNIT_CALC>0 then A.AMOUNT/B.UNIT_CALC else A.AMOUNT end)as AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark,'''+FormatDatetime('YYYYMMDD',Date())+''' '+
         ' from ('+DetailTab+')A,VIW_GOODSINFO B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and '+
         ' B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID);
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵������������:'+PlugIntf.GetLastError);

      //4�������ϱ�ʱ���:[]
      Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''03'' and TERM_ID='''+SHOP_ID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������˻����ϱ�ʱ�������');

      PlugIntf.CommitTrans; //�ύ����
    end; //ѭ��End
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'03','�ϱ������˻����ɹ���','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'03','�ϱ������˻�����','02');  //д��־
      Raise Exception.Create(E.Message);
    end;
  end;
end;

//�ϱ������� (type='04')
{˵��: ��R3���ʱ�ѵ��뵱��Ϊ��ⵥ���洢��������������Ϊ���ⵥ���洢�����۵�;ͬ��ʱ���������� }
function SenddbInDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  MaxStamp,         //���ϱ����ʱ���
  UpMaxStamp,       //�����ϱ����ʱ���
  DBID,             //RIM����(��)��ID(��R3������ + _1)
  R3_DBID,          //R3����(��)��ID
  Str,
  BillDate: string;
  DetailTab, GoodTab: string; //������ϸ����Ʒ��
  RsINF: TZQuery;             //�м��ѭ��ʹ��
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'04',SHOP_ID,ORGAN_ID,CustID); 

  //��һ��: �������۵�����������ʱ[INF_SALE]:
  case iDbType of
   1:
    begin
      Session:='';
      BillDate:='trim(char(A.STOCK_DATE)) as STOCK_DATE ';
    end;
   4:
    begin
      Session:='session.';
      BillDate:='trim(char(A.STOCK_DATE)) as STOCK_DATE ';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_DB( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'SHORT_SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID��4λ
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'DB_ID VARCHAR(40) NOT NULL,'+       //RIM����ID
             'DB_NEWID CHAR(36) NOT NULL,'+       //RIM����ID(ԭ����+"_1")
             'DB_DATE CHAR(8) NOT NULL,'+         //RIM��������
             'TIME_STAMP bigint NOT NULL'+        //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ[INF_SALE]����');
    end;
  end;

  //�ڶ����������м�(��ʱ)��
  try
    while true do
    begin
      case iDbType of
       1:
        begin
          str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE,TIME_STAMP)'+
             'select tp.* from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,STOCK_ID || ''_1'' as DB_NEWID,'+BillDate+',TIME_STAMP from '+
             ' STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
             ' order by TIME_STAMP)tp fetch first 100 rows only ';
        end;
       4:
        begin
          str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,SHORT_SHOP_ID,COM_ID,CUST_ID,DB_ID,DB_NEWID,DB_DATE,TIME_STAMP)'+
             'select * from (select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,STOCK_ID || ''_1'' as DB_NEWID,'+BillDate+',TIME_STAMP from '+
             ' STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp+
             ' order by TIME_STAMP) where ROWNUM<=100 ';
        end;
      end;
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������뵥[INF_DB]����'+PlugIntf.GetLastError);
      if iRet=0 then Break; //������û�м�¼���˳�ѭ��

      //ȡ��ǰѭ�����ʱ���:
      UpMaxStamp:=GetValue(PlugIntf, 'select max(TIME_STAMP) as TIME_STAMP from '+Session+'INF_DB ');

      PlugIntf.BeginTrans; //��ʼ����
      //1���ϱ�ǰɾ����ʷ���ݣ�
      Str:='delete from RIM_CUST_TRN '+
           ' where Exists(select 1 from INF_DB A where RIM_CUST_TRN.COM_ID=A.COM_ID and RIM_CUST_TRN.TRN_NUM=A.DB_NEWID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���뵥��ͷ����'+PlugIntf.GetLastError);
      Str:='delete from RIM_CUST_TRN_LINE '+
           ' where Exists(select 1 from INF_DB A where RIM_CUST_TRN_LINE.COM_ID=A.COM_ID and RIM_CUST_TRN_LINE.CUST_ID=A.CUST_ID and RIM_CUST_TRN_LINE.TRN_NUM=A.DB_NEWID)';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ���뵥�������'+PlugIntf.GetLastError);

      //2������������룩����ͷ:
      Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
         ' select B.DB_NEWID,A.CUST_ID,''2'' as vTYPE,B.COM_ID,SHORT_SHOP_ID,''02'',DB_DATE,CREA_USER,DB_DATE,'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,SHORT_SHOP_ID '+
         ' from STK_STOCKORDER A,INF_DB B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.STOCK_ID=B.DB_ID '+
         ' A.TENANT_ID='+TENANT_ID+' and A.SHOP_ID='''+SHOP_ID+''' and '''+R3_DBID+''' ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������������ͷ����'+PlugIntf.GetLastError);



        //3���������۱���:
        DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.STOCK_ID='''+R3_DBID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
             ' select A.STOCK_ID || ''_1'' as STOCK_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������룩����������[RIM_CUST_TRN_LINE]���󣡣�SQL='+str+'��');

        //4�������ϱ�ʱ���:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''04'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵��ϱ�ʱ�������');
        //�ύ����
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'04','�ϱ��������룩����','02');  //д��־
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'04','�ϱ��������������ɹ���','01');
  finally
    RsINF.Free;
  end;
end;

//�ϱ������� (type='12')  ���ݺ���=SALES_ID + _2
{˵��: ��R3���ʱ�ѵ��뵱��Ϊ��ⵥ���洢��������������Ϊ���ⵥ���洢�����۵�;ͬ��ʱ���������� }
function SenddbOutDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer; //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  MaxStamp,      //���ϱ����ʱ���
  UpMaxStamp,    //�����ϱ����ʱ���
  DBID,          //RIM����(��)��ID(��R3������ + _1)
  R3_DBID,       //R3����(��)��ID
  Str: string;
  DetailTab, GoodTab: string; //������ϸ����Ʒ��
  RsINF: TZQuery;             //�м��ѭ��ʹ��
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'12',SHOP_ID,ORGAN_ID,CustID); 

  //��һ��: �������۵�����������ʱ[INF_SALE]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_DB( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'DB_ID CHAR(36) NOT NULL,'+          //RIM����ID
             'TIME_STAMP bigint NOT NULL'+        //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵���ʱ[INF_SALE]����');
    end;
  end;
  
  //�ڶ����������м�(��ʱ)��
  str:='insert into '+Session+'INF_DB(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,DB_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,SALES_ID || ''_2'' as SALES_ID,TIME_STAMP '+
       ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_TYPE=2 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������(��)��[INF_DB]���󣡣�SQL='+str+'��');
  if iRet=0 then Exit; //������û�м�¼���˳�

  try
    RsINF:=TZQuery.Create(nil);
    RsINF.SQL.Text:='select DB_ID,TIME_STAMP from '+Session+'INF_DB order by TIME_STAMP';
    OpenData(PlugIntf, RsINF);
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //��Ϊ�������˳�

    //������: ѭ����������ÿ��ִ��1��POS���۵�]
    RsINF.First;
    while not RsINF.Eof do
    begin
      DBID:=trim(RsINF.fieldbyName('DB_ID').AsString);     //���۵��ݺ�
      R3_DBID:=Copy(DBID,1,36); //GUIID
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //��ǰ���ʱ���

      //��ʼ���봦��:
      PlugIntf.BeginTrans;
      try
        //1���ϱ�ǰɾ����ʷ���ݣ�
        DeleteExistsReportedBill(PlugIntf,'RIM_CUST_TRN','RIM_CUST_TRN_LINE','TRN_NUM',DBID);

        //2������������룩����ͷ:                                       //R3_NUM,--->SALES_ID || ''_2'' as SALES_ID,
        Str:='insert into RIM_CUST_TRN(TRN_NUM,CUST_ID,TYPE,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
           ' select SALES_ID || ''_2'' as SALES_ID,'''+CustID+''' as CUST_ID,''02'' as vTYPE,'''+ORGAN_ID+''' as COM_ID,right('''+SHOP_ID+''',4) as TERM_ID,''2'',trim(char(SALES_DATE)),CREA_USER,trim(char(SALES_DATE)),'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and SALES_ID='''+R3_DBID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������������ͷ[RIM_CUST_TRN]���󣡣�SQL='+str+'��');

        //3���������۱���:
        DetailTab:='select S.*,M.UNIT_NAME from SAL_SALESDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.SALES_ID='''+R3_DBID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_CUST_TRN_LINE(TRN_NUM,LINE_NUM,COM_ID,ITEM_ID,UM_ID,QTY_TRN,QTY_MINI_UM,AMT_TRN,NOTE)'+
             ' select A.SALES_ID || ''_2'' as SALES_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY,A.remark '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������룩����������[RIM_CUST_TRN_LINE]���󣡣�SQL='+str+'��');

        //4�������ϱ�ʱ���:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''12'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵��ϱ�ʱ�������');
        //�ύ����
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'12','�ϱ�������������','02');  //д��־
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'12','�ϱ��������������ɹ���','01');
  finally
    RsINF.Free;
  end;
end; 

//�ϱ���ⵥ [type='05']
function SendStockDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer;  //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  MaxStamp,       //���ϱ����ʱ���
  UpMaxStamp,     //�����ϱ����ʱ���
  StockID,        //���ⵥ��
  Str: string;
  DetailTab, GoodTab: string; //��ⵥϸ����Ʒ��
  RsINF: TZQuery;             //�м��ѭ��ʹ��
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'05',SHOP_ID,ORGAN_ID,CustID);

  //��һ��: �������۵�����������ʱ[INF_STOCK]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'STOCK_ID CHAR(36) NOT NULL,'+       //RIM��ⵥID
             'TIME_STAMP bigint NOT NULL'+        //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������ⵥ��ʱ��[INF_SALE]����');
    end;
  end;
  
  //�ڶ����������м�(��ʱ)��
  str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,STOCK_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,TIME_STAMP '+
       ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=1 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������ⵥ�м��[INF_STOCK]���󣡣�SQL='+str+'��');
  if iRet=0 then Exit; //������û�м�¼���˳�

  try
    RsINF:=TZQuery.Create(nil);
    RsINF.SQL.Text:='select STOCK_ID,TIME_STAMP from '+Session+'INF_STOCK order by TIME_STAMP';
    OpenData(PlugIntf, RsINF);
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //��Ϊ�������˳�

    //������: ѭ����������ÿ��ִ��1����ⵥ]
    RsINF.First;
    while not RsINF.Eof do
    begin
      StockID:=trim(RsINF.fieldbyName('STOCK_ID').AsString);      //���ݺ�
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //���ʱ���

      //��ʼ���봦��:
      PlugIntf.BeginTrans;
      try
        //1���ϱ�ǰɾ����ʷ���ݣ�
        DeleteExistsReportedBill(PlugIntf,'RIM_VOUCHER','RIM_VOUCHER_LINE','VOUCHER_NUM',StockID);

        //2������������룩����ͷ:                                               //R3_NUM, --> STOCK_ID,
        Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
           ' select STOCK_ID,'' '' as RETAIL_NUM,'''+CustID+''' as CUST_ID,'''+ORGAN_ID+''' as COM_ID,trim(char(TENANT_ID))as TERM_ID,''02'',trim(char(STOCK_DATE)),CREA_USER,trim(char(STOCK_DATE)),''01'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_ID='''+StockID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����������ͷ[RIM_VOUCHER]����');

        //3���������۱���:
        DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.STOCK_ID='''+StockID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
             ' select A.STOCK_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������������[RIM_VOUCHER_LINE]����');

        //4�������ϱ�ʱ���:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''05'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���½�����ⵥ�ϱ�ʱ�������');
        //�ύ����
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'05','�ϱ�������ⵥ��','02');  //д��־
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'05','�ϱ�������ⵥ�ɹ���','01');
  finally
    RsINF.Free;
  end;
end;

//�ϱ�����˻� (type='06')
function SendStkRetuDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer;  //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  MaxStamp,       //���ϱ����ʱ���
  UpMaxStamp,     //�����ϱ����ʱ���
  StockID,        //���ⵥ��
  Str: string;
  DetailTab, GoodTab: string; //��ⵥϸ����Ʒ��
  RsINF: TZQuery;             //�м��ѭ��ʹ��
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'05',SHOP_ID,ORGAN_ID,CustID); 

  //��һ��: �������۵�����������ʱ[INF_STOCK]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_STOCK( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'STOCK_ID CHAR(36) NOT NULL,'+       //RIM����ID
             'TIME_STAMP bigint NOT NULL'+        //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�����������ʱ[INF_STOCK]����');
    end;
  end;
  //�ڶ����������м�(��ʱ)��
  str:='insert into '+Session+'INF_STOCK(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,STOCK_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,STOCK_ID,TIME_STAMP '+
       ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_TYPE=3 and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵����������м��[INF_STOCK]���󣡣�SQL='+str+'��');
  if iRet=0 then Exit; //������û�м�¼���˳�

  try
    RsINF:=TZQuery.Create(nil);
    RsINF.SQL.Text:='select STOCK_ID,TIME_STAMP from '+Session+'INF_STOCK order by TIME_STAMP';
    OpenData(PlugIntf, RsINF);
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //��Ϊ�������˳�

    //������: ѭ����������ÿ��ִ��1����ⵥ]
    RsINF.First;
    while not RsINF.Eof do
    begin
      StockID:=trim(RsINF.fieldbyName('STOCK_ID').AsString);     //���۵��ݺ�
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //��ǰ���ʱ���

      //��ʼ���봦��:
      PlugIntf.BeginTrans;
      try
        //1���ϱ�ǰɾ����ʷ���ݣ�
        DeleteExistsReportedBill(PlugIntf,'RIM_VOUCHER','RIM_VOUCHER_LINE','VOUCHER_NUM',StockID);

        //2������������룩����ͷ:                                              //R3_NUM, --> STOCK_ID,
        Str:='insert into RIM_VOUCHER(VOUCHER_NUM,RETAIL_NUM,CUST_ID,COM_ID,TERM_ID,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,TYPE,UPDATE_TIME,R3_NUM)'+
           ' select STOCK_ID,'' '' as RETAIL_NUM,'''+CustID+''' as CUST_ID,'''+ORGAN_ID+''' as COM_ID,trim(char(TENANT_ID))as TERM_ID,''02'',trim(char(STOCK_DATE)),CREA_USER,trim(char(STOCK_DATE)),''02'','''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from STK_STOCKORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and STOCK_ID='''+StockID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�����������ͷ[RIM_VOUCHER]���󣡣�SQL='+str+'��');

        //3���������۱���:
        DetailTab:='select S.*,M.UNIT_NAME from STK_STOCKDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.STOCK_ID='''+StockID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_VOUCHER_LINE(VOUCHER_NUM,VOUCHER_LINE,COM_ID,ITEM_ID,UM_ID,QTY_INCEPT,QTY_MINI_UM,AMT_INCEPT)'+
             ' select A.STOCK_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵�������������[RIM_VOUCHER_LINE]���󣡣�SQL='+str+'��');

        //4�������ϱ�ʱ���:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''05'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�������۵����������ϱ�ʱ�������');
        //�ύ����
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'06','�ϱ��ɹ��˻���','02');  //д��־
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'06','�ϱ��ɹ��˻����ɹ���','01');
  finally
    RsINF.Free;
  end;
end;

//�ϱ�������  (type='07')
function SendChangeDetail(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE: string; iDbType: integer): boolean;
var
  iRet: integer;  //����ExeSQLӰ������м�¼
  Session: string;  //sessionǰ׺  
  MaxStamp,       //���ϱ����ʱ���
  UpMaxStamp,     //�����ϱ����ʱ���
  ChangeID,       //������ID
  Str: string;
  DetailTab, GoodTab: string; //��ⵥϸ����Ʒ��
  RsINF: TZQuery;             //�м��ѭ��ʹ��
begin
  result:=False;
  MaxStamp:=GetMaxNUM(PlugIntf,'07',SHOP_ID,ORGAN_ID,CustID); 

  //��һ��: �������۵�����������ʱ[INF_CHANGE]:
  case iDbType of
   1: Session:='';
   4:
    begin
      Session:='session.';
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_CHANGE( '+
             'TENANT_ID INTEGER NOT NULL,'+       //R3��ҵID
             'SHOP_ID VARCHAR(20) NOT NULL,'+     //R3�ŵ�ID
             'COM_ID VARCHAR(30) NOT NULL,'+      //RIM�̲ݹ�˾ID
             'CUST_ID VARCHAR(30) NOT NULL,'+     //RIM���ۻ�ID
             'CHANGE_ID CHAR(36) NOT NULL,'+      //RIM������ID
             'TIME_STAMP bigint NOT NULL'+        //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('����������������ʱ[INF_CHANGE]����');
    end;
  end;

  //�ڶ����������м�(��ʱ)��
  str:='insert into '+Session+'INF_CHANGE(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,CHANGE_ID,TIME_STAMP)'+
       'select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,CHANGE_ID,TIME_STAMP '+
       ' from STO_CHANGEORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and COMM not in (''02'',''12'') and TIME_STAMP>'+MaxStamp;
  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���롼���������м��[INF_CHANGE]���󣡣�SQL='+str+'��');
  if iRet=0 then Exit; //������û�м�¼���˳�

  try
    RsINF:=TZQuery.Create(nil);
    RsINF.SQL.Text:='select CHANGE_ID,TIME_STAMP from '+Session+'INF_CHANGE order by TIME_STAMP';
    OpenData(PlugIntf, RsINF);
    if (not RsINF.Active) or (RsINF.IsEmpty) then Exit; //��Ϊ�������˳�

    //������: ѭ����������ÿ��ִ��1����ⵥ]
    RsINF.First;
    while not RsINF.Eof do
    begin
      ChangeID:=trim(RsINF.fieldbyName('CHANGE_ID').AsString);     //���۵��ݺ�
      UpMaxStamp:=trim(RsINF.fieldbyName('TIME_STAMP').AsString); //��ǰ���ʱ���

      //��ʼ���봦��:
      PlugIntf.BeginTrans;
      try
        //1���ϱ�ǰɾ����ʷ���ݣ�
        DeleteExistsReportedBill(PlugIntf,'RIM_ADJUST_INFO','RIM_ADJUST_DETAIL','ADJUST_NUM',ChangeID);

        //2�������������ͷ:                                                //R3_NUM, --> CHANGE_ID,
        Str:='insert into RIM_ADJUST_INFO(ADJUST_NUM,CUST_ID,COM_ID,TERM_ID,TYPE,STATUS,CRT_DATE,CRT_USER_ID,POST_DATE,UPDATE_TIME,R3_NUM)'+
           ' select CHANGE_ID,'''+CustID+''' as CUST_ID,'''+ORGAN_ID+''' as COM_ID,trim(char(TENANT_ID))as TERM_ID,'+
           ' (case when CHANGE_CODE=''01'' then ''02'' else ''03'' end) as CHANGE_CODE,''02'',trim(char(CHANGE_DATE)),CREA_USER,trim(char(CHANGE_DATE)),'''+Formatdatetime('YYYY-MM-DD HH:NN:SS',now())+''' as PUH_TIME,right(SHOP_ID,4) '+
           ' from STO_CHANGEORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' and CHANGE_ID='''+ChangeID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���롼����������ͷ[RIM_VOUCHER]���󣡣�SQL='+str+'��');

        //3���������������:
        DetailTab:='select S.*,M.UNIT_NAME from STO_CHANGEDATA S,VIW_MEAUNITS M where S.TENANT_ID=M.TENANT_ID and S.UNIT_ID=M.UNIT_ID and S.TENANT_ID='+TENANT_ID+' and S.CHANGE_ID='''+ChangeID+''' ';
        GoodTab:='select G.GODS_ID,G.GODS_CODE,'+GetDefaultUnitCalc('G')+' as UNIT_CALC,R.SECOND_ID from PUB_GOODSINFO G,PUB_GOODS_RELATION R where G.TENANT_ID=R.TENANT_ID and G.GODS_ID=R.GODS_ID and G.TENANT_ID='+TENANT_ID+' and R.RELATION_ID='+InttoStr(NT_RELATION_ID)+' ';

        Str:='insert into RIM_ADJUST_DETAIL(ADJUST_NUM,ADJUST_LINE,COM_ID,ITEM_ID,UM_ID,QTY_ADJUST,QTY_MINI_UM,AMT_ADJUST)'+
             ' select A.CHANGE_ID,SEQNO,'''+ORGAN_ID+''' as COM_ID,B.SECOND_ID,(case when A.UNIT_NAME=''֧'' then ''01'' when A.UNIT_NAME=''��'' then ''03'' when A.UNIT_NAME=''��'' then ''04'' else ''02'' end) as UN_ID,A.AMOUNT,A.CALC_AMOUNT,A.AMONEY '+
             ' from ('+DetailTab+')A,('+GoodTab+')B '+
             ' where A.GODS_ID=B.GODS_ID order by B.GODS_CODE ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���롼������������[RIM_ADJUST_DETAIL]���󣡣�SQL='+str+'��');

        //4�������ϱ�ʱ���:[]
        Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''07'' and TERM_ID='''+SHOP_ID+''' ';
        if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���¡����������ϱ�ʱ�������');
        //�ύ����
        PlugIntf.CommitTrans;
      except
        on E:Exception do
        begin
          PlugIntf.RollbackTrans;
          sleep(1);
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'07','�ϱ���������������','02');  //д��־
          Raise Exception.Create(E.Message);
        end;
      end;
      RsINF.Next;
    end;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'07','�ϱ������������ɹ���','01');
  finally
    RsINF.Free;
  end;
end;     

{
 ԭ����������:
 (1)INTF_SELF:���ۻ���ţ�Ҳ�������֤�ţ���ͨ�����֤ȡ���ۻ�ID��
 (2)INTF_CODE:�̲ݹ�˾ID
 (3)COMP_ID:R3��ϵͳ�ŵ�ID

 R3�ϱ�:
 (1)��λ����:�����ݼ�����λ����ɹ���λ�ϱ�;
 (2)��ҵ����: R3: CA_TENANT     --->   RIM: RIM_ORGAN  (�̲�ר�ž�|��˾)
 (3)�ŵ굵��: R3: CA_SHOP_INFO  --->   RIM: RM_CUST    (���ۻ�)     
}

procedure CallBillSync(PlugIntf:IPlugIn; InParams: string);   //�ϱ���������
var
  Str: string;       //��ҵ����ͼ
  OrganID,           //RIM�̲ݹ�˾ID
  LICENSE_CODE,      //RIM���ۻ����֤��
  CustID,            //RIM���ۻ�ID
  TenantID,          //R3�ϱ���ҵID
  TenName,           //R3�ϱ���ҵName
  ShopID,            //R3�ϱ��ŵ�ID
  ShopName: string;  //R3�ϱ��ŵ�����;
  ReckDate: string;  //ǰ̨�����ָ���ϱ�����
  R3ShopList, Rs: TZQuery;
  vParam: TftParamList;
  IsFlag: Boolean;    //�Ƿ�Ϊ���ۻ�ֱ���ϱ�
  RunInfo: TRunInfo;  //������־
  DbType: integer;
begin
  ReckDate:='';
  //�������ݿ�����
  if PlugIntf.iDbType(DbType)<>0 then Raise Exception.Create('�������ݿ����ʹ���'+PlugIntf.GetLastError);
  
  RunInfo.BegTime:=Timetostr(time());
  RunInfo.BegTick:=GetTickCount;
  RunInfo.RunCount:=0;
  RunInfo.NotCount:=0;
  RunInfo.ErrorCount:=0;
  RunInfo.ErrorStr:='';

  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,InParams);
    TenantID:=vParam.ParamByName('TENANT_ID').AsString;
    IsFlag:=False; 
    if (vParam.FindParam('FLAG')<>nil) and (vParam.FindParam('FLAG').AsInteger=3) then
    begin
      IsFlag:=true;
      if vParam.FindParam('RECKDATE')<>nil then
        ReckDate:=vParam.FindParam('RECKDATE').AsString;
    end;
  finally
    vParam.Free;
  end;

  Rs := TZQuery.Create(nil);
  R3ShopList := TZQuery.Create(nil);
  try
    //����R3���ϱ�ShopList
    GetR3ReportShopList(PlugIntf, R3ShopList, InParams);
    if R3ShopList.RecordCount=0 then Raise Exception.Create(' ��ҵ��û�ж�Ӧ�����ݣ������ϱ��� ');

    //���ŵ�ID����ѭ���ϱ�
    R3ShopList.First;
    while not R3ShopList.Eof do
    begin
      CustID:='';
      try
        TenantID:=trim(R3ShopList.Fields[0].AsString);      //R3��ҵID (Field: TENANT_NAME)
        TenName:=trim(R3ShopList.Fields[1].AsString);       //R3��ҵ���� (Field: TENANT_NAME)
        ShopID:=trim(R3ShopList.Fields[2].AsString);        //R3�ŵ�ID (Field: SHOP_ID)
        ShopName:=trim(R3ShopList.Fields[3].AsString);      //R3�ŵ����� (Field: SHOP_NAME)
        LICENSE_CODE:=trim(R3ShopList.Fields[4].AsString);  //R3�ŵ����֤�� (Field: LICENSE_CODE)

        //����R3�����̲ݹ�˾��ҵID(TENANT_ID)
        Rs.SQL.Text:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenantID+' and B.SHOP_ID='''+ShopID+''' ';
        if OpenData(GPlugIn, Rs) then        begin          OrganID:=trim(rs.fieldbyName('COM_ID').AsString);          CustID:=trim(rs.fieldbyName('CUST_ID').AsString);        end;
        if OrganID='' then Raise Exception.Create('R3������ҵ��'+TenantID+' ��'+TenName+'����RIM��û�ҵ���Ӧ��ORGAN_IDֵ...');
        if CustID<>'' then
        begin
          //��ʼ������̨�ˣ�
          if SendDayReck(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE,ReckDate,DbType) then 
            Inc(RunInfo.RunCount)    //�ۼ��ϱ��ɹ��ŵ���
          else
            Inc(RunInfo.ErrorCount); //�ۼ��ϱ�ʧ���ŵ����
        end else
        begin
          RunInfo.ErrorStr:=RunInfo.ErrorStr+'   '+'R3�ŵ�:'+ShopID+' ��'+ShopName+' ���֤��'+LICENSE_CODE+' ��Rimϵͳ��û��Ӧ�ϣ�';
          Inc(RunInfo.NotCount);  //��Ӧ����
        end;
      except
        on E:Exception do
        begin
          sleep(1);
          RunInfo.ErrorStr:=RunInfo.ErrorStr+'   '+E.Message;
          WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'10','�ϱ����۳�����','02'); //дRim�������־
          Raise Exception.Create(E.Message);
        end;
      end;
      R3ShopList.Next;
    end;
  finally
    Rs.Free; 
    R3ShopList.Free;
    RunInfo.BegTick:=GetTickCount-RunInfo.BegTick; //��ִ�ж�����
    //�����־:
    if IsFlag then  //�ͻ��˵����ŵ���־
    begin
      if RunInfo.RunCount=1 then
        PlugIntf.WriteLogFile(Pchar('R3�ն��ϱ����,�����ŵ꣺('+ShopID+'- '+ShopName+') ��ʼִ��ʱ�䣺'+RunInfo.BegTime+' ��ִ��'+FormatFloat('#0.00',RunInfo.BegTick/1000)+'��  �ϱ��ɹ���')) 
      else
        PlugIntf.WriteLogFile(Pchar('R3�ն��ϱ����,�����ŵ꣺('+ShopID+'- '+ShopName+') ��ʼִ��ʱ�䣺'+RunInfo.BegTime+' ��ִ��'+FormatFloat('#0.00',RunInfo.BegTick/1000)+'��  �ϱ�����:'+RunInfo.ErrorStr));
    end else  //��̨��������:
    begin
      PlugIntf.WriteLogFile(Pchar('R3�ն��ϱ����,������ҵ��('+TenantID+'- '+TenName+') ��ʼִ��ʱ�䣺'+RunInfo.BegTime+' ��ִ��'+FormatFloat('#0.00',RunInfo.BegTick/1000)+'�� '));
      Str:='�ϱ��ɹ��ŵ�����'+inttostr(RunInfo.RunCount)+'  Rim��û�ж�Ӧ�ŵ���:'+inttoStr(RunInfo.NotCount)+' �ϱ�ʧ���ŵ���:'+inttoStr(RunInfo.ErrorCount);
      if RunInfo.ErrorStr<>'' then Str:=Str+' ������Ϣ�� '+#13+RunInfo.ErrorStr;
      PlugIntf.WriteLogFile(Pchar(RunInfo.ErrorStr));
    end; 
  end;
end;    


end.















