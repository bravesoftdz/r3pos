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


procedure SetRimCom_CustID(PlugIn: IPlugIn; ParamStr: string; var TenantID: string; var ShopID: string; var ComID: string; var CustID: string);
var
  str: string;
  rs: TZQuery;
  vParam: TftParamList;
begin
  try
    rs:=TZQuery.Create(nil); 
    try
      vParam:=TftParamList.Create(nil);
      vParam.Decode(vParam,ParamStr);
      TenantID:=InttoStr(vParam.ParamByName('TENANT_ID').AsInteger);
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
        GLastError := E.Message;
        PlugIn.WriteLogFile(Pchar('����R3��ҵID('+vParam.ParamByName('TENANT_ID').AsString+'),�ŵ�ID('+vParam.ParamByName('SHOP_ID').AsString+')������Rim�Ĺ�Ӧ��ID�����ۻ�ID����'+E.Message));
      end;
    end;
  finally
    rs.Free;
    vParam.Free;
  end;
end;

function DownOrderToINF_StockOrder(PlugIn: IPlugIn; ParamStr: string): Boolean;
var
  iRet: integer;
  Str,NearDate,TenantID,ShopID,ComID,CustID: string;
begin
  result:=False;
  NearDate:=FormatDatetime('YYYYMMDD',Date()-30); //��ȡ���30��Ķ�������
  SetRimCom_CustID(PlugIn,ParamStr,TenantID,ShopID,ComID,CustID); //��ȡRimϵͳ�Ĺ�Ӧ�̣��̲ݹ�˾Com_ID�������ۻ���Cust_Id
  try
    {== �м������Ϊ�ӿڣ���Ӧϵͳ���ã��˴�����: ������Ϊ��ѯ��ʾ�����б���ʾʹ�� ==}
    if (ComID<>'') and (CustID<>'')  then
    begin
      PlugIn.ExecSQL(Pchar('delete from INF_INDEORDER where COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' '),iRet);
      Str:='insert into INF_INDEORDER (TENANT_ID,SHOP_ID,INDE_ID,INDE_DATE,INDE_AMT,INDE_MNY) '+
         ' select '+TenantID+' as TenantID,'''+ShopID+''' as SHOP_ID,CO_NUM,CRT_DATE,QTY_SUM,AMT_SUM from RIM_SD_CO '+
         ' where CRT_DATE>='''+NearDate+''' and COM_ID='''+ComID+''' and CUST_ID='''+CustID+''' ';
      PlugIn.ExecSQL(Pchar(Str),iRet);
      {== ����������ֱ�Ӹ��µ����� ������ ==}
      str:='update INF_INDEORDER A set NEED_AMT=(select sum(QTY_NEED) from RIM_SD_CO_LINE B where A.CO_NUM=B.CO_NUM) '+
           ' where exists(select 1 from RIM_SD_CO_LINE C where A.CO_NUM=B.CO_NUM) ';
      PlugIn.ExecSQL(Pchar(Str),iRet);
    end;
  except
    on E:Exception do
    begin
      GLastError := E.Message;
      PlugIn.WriteLogFile(Pchar('���ض������м��INF_INDEORDER������'+E.Message));
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
begin
  try
    //���ض���
    DownOrderToINF_StockOrder(GPlugIn, Params); 
    result := 0;
  except
    on E:Exception do
      begin
        GLastError := E.Message;
        result := 2001;
      end;
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
