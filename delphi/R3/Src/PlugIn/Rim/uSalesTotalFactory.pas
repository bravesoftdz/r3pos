{-------------------------------------------------------------------------------
 RIM����ͬ��:
 (1)����Ԫ�ϱ�ͬ��ʹ��ʱ��������¾�ϵͳ�л�ʱ��Ҫ��RIM_R3_NUM����Ӧ�ĳ�ʼTIME_STAMP��ֵ;
 (2)R3ϵͳ������λ: Calc_UNIT��RIM�ļ�����λ����R3�Ĺ���λ;

 ------------------------------------------------------------------------------}

unit uSalesTotalFactory;

interface

uses                 
  SysUtils,Classes,Windows,zDataSet,zBase,uPlugInUtil;   //ufnUtil,

procedure CallSaleReckSync(PlugIntf:IPlugIn; InParams: string);   //�ϱ���������


implementation

{============================ ����Ϊ�ϱ�RIMҵ�񵥾� [DB2\ORACLE] ==============================}

//////2011.04.14 PM�ϱ���̨��  (type='10')
function SendDayReck(PlugIntf:IPlugIn; TENANT_ID,SHOP_ID,ORGAN_ID,CustID,LICENSE_CODE,SALES_DATE:string; iDbType: integer):boolean;
var
  iRet: integer;   //����ExeSQLӰ������м�¼
  Session: string; //sessionǰ׺
  MaxStamp,        //���ϱ����ʱ���
  UpMaxStamp,      //�����ϱ����ʱ���
  Str,
  Short_ID,       //�ŵ����λ����
  CndTab,         //������
  SalesTab,       //������ͼ
  vSALES_DATE     //��������[ת���ַ�]
  : string; 
begin
  result := false;
  Short_ID:=Copy(SHOP_ID,Length(SHOP_ID)-3,4);
  MaxStamp:=GetMaxNUM(PlugIntf,'10',SHOP_ID,ORGAN_ID,CustID,UpMaxStamp); //������̨�����ʱ���
  
  //������̨����ʱ[INF_RECKDAY]:
  case iDbType of
   1:
    begin
      Session:='';
      vSALES_DATE:='trim(char(M.CREA_DATE))';    //̨������ ת�� varchar
    end;
   4:
    begin
      Session:='session.';
      vSALES_DATE:='cast(M.CREA_DATE as varchar(8))';    //̨������ ת�� varchar
      Str:=
        'DECLARE GLOBAL TEMPORARY TABLE session.INF_SALESUM( '+
             ' TENANT_ID INTEGER NOT NULL,'+     //R3��ҵID
             ' SHOP_ID VARCHAR(20) NOT NULL,'+   //R3�ŵ�ID
             ' SHORT_SHOP_ID VARCHAR(4) NOT NULL,'+  //R3�ŵ�ID����λ
             ' COM_ID VARCHAR(30) NOT NULL,'+    //RIM�̲ݹ�˾ID
             ' CUST_ID VARCHAR(30) NOT NULL,'+   //RIM���ۻ�ID
             ' ITEM_ID VARCHAR(30) NOT NULL,'+   //RIM��ƷID
             ' GODS_ID CHAR(36) NOT NULL,'+      //R3��ƷID
             ' SALES_DAY VARCHAR(8) NOT NULL,'+  //��������
             ' QTY_ORD DECIMAL (18,6),'+         //̨����������
             ' AMT DECIMAL (18,6),'+             //̨�����۽��
             ' CO_NUM VARCHAR(30) NOT NULL, '+   //���ݺ�[̨������ + ���ۻ�ID+ R3_�ŵ�ID��4λ] 
             ' TIME_STAMP bigint NOT NULL'+      //ʱ���
             ') ON COMMIT PRESERVE ROWS NOT LOGGED ON ROLLBACK PRESERVE ROWS WITH REPLACE ';
      if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������������ʱ��INF_SALESUM����:'+PlugIntf.GetLastError);
    end;
  end;

  iRet:=0;
  //��һ��: ����ʱ�����̨�ʲ�����ʱ��:
  //������: ���ݴ���������ָ�����ڷ��ض�Ӧ�ŵ꼰������Ҫ�ϱ�����:
  CndTab:='select TENANT_ID,SHOP_ID,SALES_DATE from SAL_SALESORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' ';
  if SALES_DATE='' then
    CndTab:=CndTab+' and TIME_STAMP>'+MaxStamp+' '
  else
    CndTab:=CndTab+' and ((TIME_STAMP>'+MaxStamp+')or(SALES_DATE='+SALES_DATE+'))'; //ǰ̨��������

  SalesTab:=
    'select M.TENANT_ID,M.SHOP_ID,S.GODS_ID,'+vSALES_DATE+' as SALES_DATE,sum(S.CALC_AMOUNT) as CALC_AMOUNT,sum(S.CALC_MONEY) as CALC_MONEY from SAL_SALESORDER M,SAL_SALESDATA S,('+CndTab+') C '+
    ' where M.TENANT_ID=S.TENANT_ID and M.SALES_ID=S.SALES_ID and M.TENANT_ID=C.TENANT_ID and M.SHOP_ID=C.SHOP_ID and '+
    ' M.SALES_DATE=C.SALES_DATE and M.SALES_TYPE in (1,3,4) and M.COMM not in (''02'',''12'') and M.TENANT_ID='+TENANT_ID+' and M.SHOP_ID='''+SHOP_ID+''' '+
    ' group by M.TENANT_ID,M.SHOP_ID,M.SALES_DATE,S.GODS_ID';

  Str:='insert into '+Session+'INF_SALESUM(TENANT_ID,SHOP_ID,COM_ID,CUST_ID,ITEM_ID,GODS_ID,SALES_DATE,QTY_ORD,AMT,TIME_STAMP) '+
    'select A.TENANT_ID,A.SHOP_ID,'''+Short_ID+''' as SHORT_SHOP_ID,'''+ORGAN_ID+''' as COM_ID,'''+CustID+''' as CUST_ID,B.SECOND_ID,A.GODS_ID,'+vSALES_DATE+' as SALES_DATE,'+
    ' (case when '+GetDefaultUnitCalc+'<>0 then A.CALC_AMOUNT/('+GetDefaultUnitCalc+') else A.AMOUNT end) as SALE_AMT,A.CALC_MONEY,('+vSALES_DATE+' || ''_'' || '''+CustID+''' ||''_'' || '''+Short_ID+''') as CO_NUM '+
    ' from ('+SalesTab+')A,VIW_GOODSINFO B '+
    ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.TENANT_ID='+TENANT_ID+' and B.RELATION_ID='+InttoStr(NT_RELATION_ID)+
    ' group by A.TENANT_ID,A.SHOP_ID,B.SECOND_ID,A.GODS_ID,'+vSALES_DATE+' ';

  if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('������̨����ʱ�����ݳ���:'+PlugIntf.GetLastError);
  if iRet=0 then Raise Exception.Create('û�п��ϱ���������'); //������û�м�¼���˳�ѭ��

  //������: ÿһ��ִ����Ϊһ�������ύ
  try
    PlugIntf.BeginTrans;
    //1��ɾ��������ʷ����(��ɾ��������ɾ����ͷ):
    Str:='delete from RIM_RETAIL_CO_LINE A '+
         ' where exists(select B.CO_NUM from RIM_RETAIL_CO B,'+Session+'INF_SALESUM C '+
                      ' where B.COM_ID=C.COM_ID and B.CUST_ID=C.CUST_ID and B.PUH_DATE=C.RECK_DAY and B.COM_ID='''+ORGAN_ID+'''and B.TERM_ID='''+Short_ID+''' and B.CUST_ID='''+CustID+''' and A.CO_NUM=B.CO_NUM)';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�����۱������'+PlugIntf.GetLastError);
    Str:='delete from RIM_RETAIL_CO A where exists(select 1 from '+Session+'INF_SALESUM B where A.COM_ID=B.COM_ID and A.CUST_ID=B.CUST_ID and A.PUH_DATE=B.RECK_DAY) and A.COM_ID='''+ORGAN_ID+''' and A.TERM_ID='''+Short_ID+''' and A.CUST_ID='''+CustID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('ɾ����ʷ�����۱�ͷ����'+PlugIntf.GetLastError);

    //2������������̨��(�Ȳ��ͷ�ڲ������):
    Str:='insert into RIM_RETAIL_CO(CO_NUM,CUST_ID,COM_ID,TERM_ID,PUH_DATE,STATUS,UPD_DATE,UPD_TIME,QTY_SUM,AMT_SUM) '+
         'select CO_NUM,CUST_ID,COM_ID,SHORT_SHOP_ID,RECK_DAY,''01'' as STATUS,'''+FormatDatetime('YYYYMMDD',Date())+''','''+TimetoStr(time())+''',sum(QTY_ORD) as QTY_SUM,sum(AMT) as AMT_SUM '+
         ' from '+Session+'INF_SALESUM group by COM_ID,CUST_ID,SHORT_SHOP_ID,CO_NUM,RECK_DAY';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������۱�ͷ[RIM_RETAIL_CO]����:'+PlugIntf.GetLastError);
    Str:='insert into RIM_RETAIL_CO_LINE(CO_NUM,ITEM_ID,QTY_ORD,AMT) '+
         'select CO_NUM,ITEM_ID,QTY_ORD,AMT from '+Session+'INF_SALESUM ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('���������۱���[RIM_RETAIL_CO_LINE]����:'+PlugIntf.GetLastError);

    //3�������ϱ�ʱ���:
    Str:='update RIM_R3_NUM set MAX_NUM='''+UpMaxStamp+''' where COM_ID='''+ORGAN_ID+''' and CUST_ID='''+CustID+''' and TYPE=''10'' and TERM_ID='''+SHOP_ID+''' ';
    if PlugIntf.ExecSQL(PChar(Str),iRet)<>0 then Raise Exception.Create('�����ϱ�ʱ�������:'+PlugIntf.GetLastError);

    PlugIntf.CommitTrans;  //�ύ����
    result:=true;
    //ִ�гɹ�д��־:
    WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'10','�ϱ������۳ɹ���','01');
  except
    on E:Exception do
    begin
      PlugIntf.RollbackTrans;
      sleep(1);
      WriteToRIM_BAL_LOG(PlugIntf, LICENSE_CODE,CustID,'10','�ϱ������۴���','02'); //д��־
      Raise Exception.Create(E.Message);
    end;
  end;  
end;

procedure CallSaleReckSync(PlugIntf:IPlugIn; InParams: string); //�ϱ����
var
  Str: string;       //��ҵ����ͼ
  OrganID,           //RIM�̲ݹ�˾ID
  LICENSE_CODE,      //RIM���ۻ����֤��
  CustID,            //RIM���ۻ�ID
  TenantID,          //R3�ϱ���ҵID
  TenName,           //R3�ϱ���ҵName
  ShopID,            //R3�ϱ��ŵ�ID
  ShopName: string;  //R3�ϱ��ŵ�����;
  SALES_DATE: string;  //ǰ̨�����ָ���ϱ�����
  R3ShopList,Rs: TZQuery;
  vParam: TftParamList;
  IsFlag: Boolean;    //�Ƿ�Ϊ���ۻ�ֱ���ϱ�
  RunInfo: TRunInfo;  //������־
  DbType: integer;
begin
  SALES_DATE:='';
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
      if vParam.FindParam('SALES_DATE')<>nil then
        SALES_DATE:=vParam.FindParam('SALES_DATE').AsString;
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
          if SendDayReck(PlugIntf,TenantID,ShopID,OrganID,CustID,LICENSE_CODE,SALES_DATE,DbType) then 
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















