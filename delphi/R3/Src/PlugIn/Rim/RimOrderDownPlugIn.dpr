{
  Create Date: 2011.04.11 Pm
  ˵��:
    1�����ID: �Ƕ���ʵ��ĳ�����ܲ�����;
 }


library RimOrderDownPlugIn;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  DB,
  zDataSet,
  SysUtils,
  Variants,
  Classes,
  zBase,
  uPlugInUtil in '..\obj\uPlugInUtil.pas';


{$R *.res}


procedure SetRimCom_CustID(PlugIn: IPlugIn; vParam: TftParamList; var ComID: string; var CustID: string);
var
  str,TenantID,ShopID: string;
  rs: TZQuery;
begin
  try
    rs:=TZQuery.Create(nil);
    try
      TenantID:=vParam.ParamByName('TENANT_ID').AsString;
      ShopID:=vParam.ParamByName('SHOP_ID').AsString;
      str:='select A.COM_ID as COM_ID,A.CUST_ID as CUST_ID from RM_CUST A,CA_SHOP_INFO B where A.LICENSE_CODE=B.LICENSE_CODE and B.TENANT_ID='+TenantID+' and B.SHOP_ID='''+ShopID+''' ';
      if OpenData(PlugIn, rs, str) then
      begin
        ComID:=trim(rs.fieldbyName('COM_ID').AsString);
        CustID:=trim(rs.fieldbyName('CUST_ID').AsString);
      end;
    except
      on E:Exception do
      begin
        str:='��ҵID('+vParam.ParamByName('TENANT_ID').AsString+'),�ŵ�ID('+vParam.ParamByName('SHOP_ID').AsString+')������Rim�Ĺ�Ӧ��ID�����ۻ�ID����'+E.Message;
        Raise Exception.Create(Pchar(str));
      end;
    end;
  finally
    rs.Free;
  end;
end;

function DownOrderToINF_StockOrder(GPlugIn: IPlugIn; vParam: TftParamList): Boolean;
var
  iRet: integer;
  Str,NearDate,UseDate: string;
  TenantID,ShopID,ComID,CustID: string;
begin
  result:=False;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //��ȡ���30��Ķ�������
  TenantID:=vParam.ParamByName('TENANT_ID').AsString;
  ShopID:=vParam.ParamByName('SHOP_ID').AsString;
  UseDate:=vParam.ParamByName('USING_DATE').AsString;
  SetRimCom_CustID(GPlugIn,vParam,ComID,CustID); //��ȡRimϵͳ�Ĺ�Ӧ�̣��̲ݹ�˾Com_ID�������ۻ���Cust_Id
  TLogRunInfo.LogWrite('���ض�������ȡ����:��R3��ҵID��'+TenantID+';�ŵ�ID��'+ShopID+'������RIM�̲ݹ�˾ID:'+ComID+';���ۻ�ID:'+CustID+'��','RimOrderDownPlugIn.dll');

  //�ж��������������30���ϵ
  //if NearDate < UseDate then NearDate:=UseDate;

  try
    {== �м������Ϊ�ӿڣ���Ӧϵͳ���ã��˴�����: ������Ϊ��ѯ��ʾ�����б���ʾʹ�� ==}
    if (ComID<>'') and (CustID<>'')  then
    begin
      //1����ɾ���м����ʷ����:
      if GPlugIn.ExecSQL(Pchar('delete from INF_INDEORDER where TENANT_ID='+TenantID+' and SHOP_ID='''+ShopID+''' '),iRet)<>0 then Raise Exception.Create('1��ɾ�������м��(INF_INDEORDER)ʧ�ܣ�����������ҵID='+TenantID+',�ŵ�ID='+ShopID+'��');

      //2���������30������ȷ�ϵĶ�����ͷ:
      Str:='insert into INF_INDEORDER (TENANT_ID,SHOP_ID,INDE_ID,INDE_DATE,INDE_AMT,INDE_MNY,NEED_AMT,STATUS) '+
         ' select '+TenantID+' as TenantID,'''+ShopID+''' as SHOP_ID,A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,sum(QTY_NEED) as NEED_AMT,A.STATUS '+
         ' from RIM_SD_CO A,RIM_SD_CO_LINE B '+
         ' where A.CO_NUM=B.CO_NUM and A.STATUS>=''04'' and A.CRT_DATE>='''+NearDate+''' and A.COM_ID='''+ComID+''' and A.CUST_ID='''+CustID+''' '+
         ' group by A.CO_NUM,A.CRT_DATE,A.QTY_SUM,A.AMT_SUM,A.STATUS ';
      if GPlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2���������30�충����ͷ����'+Str);
      TLogRunInfo.LogWrite('���ض���ִ�����:������:'+inttoStr(iRet)+'�ʣ���InsertSQL:'+Str+'��','RimOrderDownPlugIn.dll');
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('���ض�����RIM_SD_CO�����м��INF_INDEORDER������'+E.Message); //д�쳣��־;
    end;
  end;
end;

function DownOrderToINF_StockData(PlugIn: IPlugIn; vParam: TftParamList): Boolean;
var
  iRet: integer;
  Str, INDE_ID, TenantID: string;
begin
  result:=False;
  INDE_ID:=trim(vParam.ParamByName('INDE_ID').AsString);
  TenantID:=inttostr(vParam.ParamByName('TENANT_ID').AsInteger);
  TLogRunInfo.LogWrite('���ض�������ǰ�������:��R3��ҵID��'+TenantID+';����ID��'+INDE_ID+'��','RimOrderDownPlugIn.dll');
  try
    //1��ɾ������������ʷ���ݣ�
    Str:='delete from INF_INDEDATA where TENANT_ID='+TenantID+' and INDE_ID='''+INDE_ID+''' ';
    if PlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('1��ɾ������������ʷ���ݳ�����SQL='+Str+'��');

    //2�����붩������:
    Str:='insert into INF_INDEDATA(TENANT_ID,INDE_ID,GODS_ID,SECOND_ID,UNIT_ID,NEED_AMT,CHK_AMT,AMOUNT,APRICE,AMONEY,AGIO_MONEY) '+
         'select '+TenantID+' as TENANT_ID,CO_NUM,B.GODS_ID,ITEM_ID,''95331F4A-7AD6-45C2-B853-C278012C5525'' as UNIT_ID,QTY_NEED,QTY_VFY,QTY_ORD,PRI,AMT,RET_AMT '+
         ' from RIM_SD_CO_LINE A '+
         ' left outer join (select GODS_ID,SECOND_ID from VIW_GOODSINFO where TENANT_ID='+TenantID+')B on A.ITEM_ID=B.SECOND_ID '+
         ' where A.CO_NUM='''+INDE_ID+''' ';
    if PlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2�����붩�����������SQL='+Str+'��');
    TLogRunInfo.LogWrite('���ض�������ִ�����:�����أ�'+inttoStr(iRet)+'�ʣ���InsertSQL:'+Str+'��','RimOrderDownPlugIn.dll');
  except
    on E:Exception do
    begin
      Raise Exception.Create('���ض�����ϸ��RIM_SD_CO_LINE�����м��INF_INDEORDER������'+E.Message);
    end;
  end;
end;
       
//RSPװ�ز��ʱ���ã�������ɷ��ʵķ���ӿ�
function SetParams(PlugIn: IPlugIn):integer; stdcall;
begin
  GPlugIn := PlugIn;
end;

//�����ִ�е����в���������� try except end �������ʱ���ɴ˷������ش���Ϣ
function GetLastError:Pchar; stdcall;
begin
  result := Pchar(GLastError);
end;

//���ص�ǰ���˵��
function GetPlugInDisplayName:Pchar; stdcall;
begin
  result := 'RSPƽ̨����RIMϵͳ����';
end;

//����RIM���ض���������ȷ�ϣ��Ĳ��
function GetPlugInId:Integer; stdcall;
begin
  result := 1002;
end;

//RSP���ò��ʱִ�д˷���
function DoExecute(Params:Pchar; var Data:oleVariant):Integer; stdcall;
var
  ExeType: Integer; //ִ�����ͣ�1:��������; 2:������ϸ��
  vParam: TftParamList;
begin
  try
    vParam:=TftParamList.Create(nil);
    vParam.Decode(vParam,StrPas(Params));
    ExeType:=vParam.ParamByName('ExeType').AsInteger;  
    try
      case ExeType of
       1: DownOrderToINF_StockOrder(GPlugIn, vParam);  //���ض�������
       2: DownOrderToINF_StockData(GPlugIn, vParam);   //���ض�����ϸ��
      end;
      result := 0;
    except
      on E:Exception do
      begin
        GLastError := E.Message;
        GPlugIn.WriteLogFile(Pchar(E.Message));
        result := 2001;
      end;
    end;
  finally
    vParam.Free;
  end;
end;

//RSP���ò���Զ���Ĺ������,û��ʱֱ�ӷ���0
function ShowPlugin:Integer; stdcall;
begin
  try
    //��ʼ��ʾ�����洰��
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2002;
      end;
  end;
end;

exports
  SetParams,GetLastError,GetPlugInDisplayName,GetPlugInId,DoExecute,ShowPlugin;
begin

end.



     {//2���������30������ȷ�ϵĶ�����ͷ:
      Str:='insert into INF_INDEORDER (TENANT_ID,SHOP_ID,INDE_ID,INDE_DATE,INDE_AMT,INDE_MNY,STATUS) '+
         ' select '+TenantID+' as TenantID,'''+ShopID+''' as SHOP_ID,CO_NUM,CRT_DATE,QTY_SUM,AMT_SUM,STATUS from RIM_SD_CO '+
         ' where STATUS>=''04'' and CRT_DATE>='''+NearDate+''' and COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' ';
      if GPlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('2���������30�충����ͷ����'+Str);


      //3�����ܶ�����ͷ������:
      str:='update INF_INDEORDER A set NEED_AMT=(select sum(QTY_NEED) from RIM_SD_CO_LINE B where A.INDE_ID=B.CO_NUM) '+
           ' where exists(select 1 from RIM_SD_CO_LINE B where A.INDE_ID=B.CO_NUM) ';
      if GPlugIn.ExecSQL(Pchar(Str),iRet)<>0 then Raise Exception.Create('3�����ܶ�����ͷ����������');
      }

