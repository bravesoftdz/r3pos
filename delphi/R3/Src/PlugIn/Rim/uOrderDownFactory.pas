unit uOrderDownFactory;

interface

uses
  SysUtils, Variants, Classes, Dialogs, DB, zDataSet, zIntf, zBase,
  uBaseSyncFactory,uRimSyncFactory;

  
//����Rimϵͳ�������������ȷ�ϣ�
type
  TOrderDownSyncFactory=class(TRimSyncFactory)
  private
    //�� [RIM_SD_CO] �����м�� [INF_INDEORDER]
    function DownOrderToINF_INDEOrder: Boolean;
    //�� [RIM_SD_CO_LINE] �����м�� [INF_INDERDATA]
    function DownOrderToINF_INDEData: Boolean;
  public
    function CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer; override; //�����ϱ�
  end;

implementation


{ TRimSyncFactory }

function TOrderDownSyncFactory.CallSyncData(GPlugIn: IPlugIn; InParamStr: string): integer;
begin
  result := -1;
  {------��ʼ������------}
  PlugIntf:=GPlugIn;

  //1����ԭParamsList�Ĳ�������
  Params.Decode(Params, InParamStr);
  if Params.FindParam('ExeType')=nil then //Rsp���ȵĲ�ִ�ж�������
  begin
    result:=1; //�˳�ִ��
    Exit;
  end;

  //2���������ݿ�����
  GetDBType;
  try
    case Params.ParamByName('ExeType').AsInteger of   //ִ�����ͣ� 
     1: DownOrderToINF_INDEOrder;   //���ض�������
     2: DownOrderToINF_INDEData;    //���ض�����ϸ��
    end;
    result := 0;
  except
    on E:Exception do
    begin
      GLastError := E.Message;
      PlugIntf.WriteLogFile(Pchar(E.Message));
      result := 2001;
    end;
  end;
end;

function TOrderDownSyncFactory.DownOrderToINF_INDEOrder: Boolean;
var
  iRet: integer;
  Str,NearDate,UseDate: string;
  TENANT_ID,SHOP_ID,COM_ID,CUST_ID: string;
begin
  result:=False;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //��ȡ���30��Ķ�������
  // UseDate:=vParam.ParamByName('USING_DATE').AsString;
  //�ж��������������30���ϵ
  //if NearDate < UseDate then NearDate:=UseDate;

  TENANT_ID:=trim(Params.ParamByName('TENANT_ID').AsString);
  SHOP_ID:=trim(Params.ParamByName('SHOP_ID').AsString);    //R3�ŵ�ID
  //����Rim�̲ݹ�˾ID,���ۻ�ID
  SetRimORGAN_CUST_ID(TENANT_ID,SHOP_ID, COM_ID, CUST_ID);

  if COM_ID='' then Raise Exception.Create('û���ҵ�RIMϵͳ�̲ݹ�˾��');
  if CUST_ID='' then Raise Exception.Create('û���ҵ�RIMϵͳ���ۻ���'); //д�쳣��־;

  try
    {== �м������Ϊ�ӿڣ���Ӧϵͳ���ã��˴�����: ������Ϊ��ѯ��ʾ�����б���ʾʹ�� ==}
    //1����ɾ���м����ʷ����:
    if PlugIntf.ExecSQL(Pchar('delete from INF_INDEORDER where TENANT_ID='+TENANT_ID+' and SHOP_ID='''+SHOP_ID+''' '),iRet)<>0 then
       Raise Exception.Create('1��ɾ��INF_INDEORDERʧ�ܣ�����������ҵID='+TENANT_ID+',�ŵ�ID='+SHOP_ID+'��'+PlugIntf.GetLastError);

    //2���������30������ȷ�ϵĶ�����ͷ:
    Str:='insert into INF_INDEORDER (TENANT_ID,SHOP_ID,INDE_ID,INDE_DATE,INDE_AMT,INDE_MNY,NEED_AMT,STATUS) '+
      ' select '+TENANT_ID+' as TENANT_ID,'''+SHOP_ID+''' as SHOP_ID,A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,sum(QTY_NEED) as NEED_AMT,A.STATUS '+
      ' from RIM_SD_CO A,RIM_SD_CO_LINE B '+
      ' where A.CO_NUM=B.CO_NUM and A.STATUS>=''04'' and A.CRT_DATE>='''+NearDate+''' and A.COM_ID='''+COM_ID+''' and A.CUST_ID='''+CUST_ID+''' '+
      ' group by A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,A.STATUS ';
     if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2���������30�충����ͷ����'+PlugIntf.GetLastError);
     result:=true;
  except
    on E:Exception do
    begin
      Raise Exception.Create('���ض�����RIM_SD_CO�����м��INF_INDEORDER������'+E.Message); //д�쳣��־;
    end;
  end;
end;

// 2011.06.02 Modif: 
function TOrderDownSyncFactory.DownOrderToINF_INDEData: Boolean;
var
  iRet: integer;
  Str, TENANT_ID, INDE_ID: string;
begin
  result:=False;
  INDE_ID:=trim(Params.ParamByName('INDE_ID').AsString);
  TENANT_ID:=inttostr(Params.ParamByName('TENANT_ID').AsInteger);
  try
    //1��ɾ������������ʷ���ݣ�
    Str:='delete from INF_INDEDATA where TENANT_ID='+TENANT_ID+' and INDE_ID='''+INDE_ID+''' ';
    if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('1��ɾ������������ʷ���ݳ�����SQL='+Str+'��');

    case DbType of
     1: //Oracle
      begin                                                     //SECOND_ID,
        Str:='insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
             ' select '+TENANT_ID+' as TENANT_ID,CO_NUM,B.GODS_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,'+
             ' sum(QTY_NEED) as QTY_NEED,'+                       //ITEM_ID,
             ' sum(QTY_VFY) as QTY_VFY,'+
             ' sum(QTY_ORD) as QTY_ORD,'+
             ' (case when sum(QTY_ORD)<>0 then cast(sum(AMT)as decimal(18,3))/cast(sum(QTY_ORD) as decimal(18,3)) else 0 end) as PRI,'+
             ' sum(AMT) as AMT,'+
             ' sum(RET_AMT) as RET_AMT '+
             ' from RIM_SD_CO_LINE A left outer join (select GODS_ID,SECOND_ID,COMM_ID from VIW_GOODSINFO where TENANT_ID='+TENANT_ID+')B '+
             ' on (A.ITEM_ID=B.SECOND_ID) or (INSTR( B.COMM_ID,'','' || A.ITEM_ID || '','', 1, 1)>0) '+  //��������
             ' where A.CO_NUM='''+INDE_ID+''' '+
             ' group by CO_NUM,B.GODS_ID ';  //,ITEM_ID
      end;
     4: //DB2
      begin                                                     //SECOND_ID,
        Str:='insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
             ' select '+TENANT_ID+' as TENANT_ID,CO_NUM,B.GODS_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,'+
             ' sum(QTY_NEED) as QTY_NEED,'+                       //ITEM_ID,
             ' sum(QTY_VFY) as QTY_VFY,'+
             ' sum(QTY_ORD) as QTY_ORD,'+
             ' (case when sum(QTY_ORD)<>0 then cast(sum(AMT)as decimal(18,3))/cast(sum(QTY_ORD) as decimal(18,3)) else 0 end) as PRI,'+
             ' sum(AMT) as AMT,'+
             ' sum(RET_AMT) as RET_AMT '+
             ' from RIM_SD_CO_LINE A left outer join (select GODS_ID,SECOND_ID,COMM_ID from VIW_GOODSINFO where TENANT_ID='+TENANT_ID+')B '+
             ' on (A.ITEM_ID=B.SECOND_ID) or (locate( B.COMM_ID,'','' || A.ITEM_ID || '','')>0) '+  //��������
             ' where A.CO_NUM='''+INDE_ID+''' '+
             ' group by CO_NUM,B.GODS_ID ';  //,ITEM_ID
      end;
    end;

    //2�����붩������:
   { Str:='insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,SECOND_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
         'select '+TENANT_ID+' as TENANT_ID,CO_NUM,B.GODS_ID,ITEM_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,QTY_NEED,QTY_VFY,QTY_ORD,PRI,AMT,RET_AMT '+
         ' from RIM_SD_CO_LINE A '+
         ' left outer join (select GODS_ID,SECOND_ID from VIW_GOODSINFO where TENANT_ID='+TENANT_ID+')B '+
         ' on A.ITEM_ID=B.SECOND_ID '+  //��������
         ' where A.CO_NUM='''+INDE_ID+''' ';
   }
    if PlugIntf.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2�����붩���������:'+PlugIntf.GetLastError);
    result:=true;
  except
    on E:Exception do
    begin
      Raise Exception.Create('���ض�����ϸ��RIM_SD_CO_LINE�����м��INF_INDEORDER������'+E.Message);
    end;
  end;
end;

 
end.
