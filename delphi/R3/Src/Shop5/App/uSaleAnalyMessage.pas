unit uSaleAnalyMessage;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns, Des, WinInet,
  ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase, Variants, ZLogFile;

  {============��������
    Yesterday:  ��д��YD
    Today:      ��д��TD
    Last Month: ��д��LM
    This Month: ��д��TM
    AMT: ����
    MNY: ���
    PRF: ë��
    PRF_RATE��ë����
    Stock holding ratio:������ ��д:SH_Ratio
   =============}
  //�쾭Ӫ���:
type
  TSaleDayMsg=Record
    YDSale_AMT: real;   //��������(��λ:��);
    YDSale_MNY: real;   //�������۶�(Ԫ);
    YDSale_PRF: real;   //����ë��(Ԫ);
    YDSale_PRF_RATE: real;  //����ë����(%);
    TDSale_AMT: real;   //��������(��λ:��);
    TDSale_MNY: real;   //�������۶�(Ԫ);
    TDSale_PRF: real;   //����ë��(Ԫ);
    TDSale_PRF_RATE: real;  //����ë����(%);
  end;

  //�·ݾ�Ӫ���:
  TSaleMonthMsg=Record
    Month: string;      //�·�
    LMSale_AMT: real;   //��������(��λ:��);
    LMSale_MNY: real;   //�������۶�(Ԫ);
    LMSale_PRF: real;   //����ë(��λ:��);
    LMSale_PRF_RATE: real;  //��������(��λ:��);
    TMGods_AMT: integer;  //���¾�ӪƷ����;
    TMCust_AMT: integer;  //������������;
    TMCust_MNY: real;  //�������������ѽ��;
    TMCust_RATE: real; //��������������ռ�ı���;
    TMSH_RATIO: real;  //���´�����;
    TMSale_AMT: real;  //��������(��λ:��);
    TMSale_MNY: real;  //�������۶�(Ԫ);
    TMSale_PRF: real;  //����ë(��λ:��);
    TMSale_PRF_RATE: real;  //����ë����(��λ:��);
    TMGods_MaxPRF: string;  //����ë���������3�������֮���á�;�������;
    TMGods_MaxAMT: string;  //���������������3�������֮���á�;�������;
    TMGods_MinPRF: string;  //����ë���������3�������֮���á�;�������;
    TMGods_MinAMT: string;  //���������������3�������֮���á�;�������;
  end;
  
type
  TSaleAnalyMsg=class
  private
    TopCount: integer;
    Qry: TZQuery;
    FSaleDayMsg: TSaleDayMsg; //ÿ��������Ϣ
    FSaleMonthMsg: TSaleMonthMsg; //�¾�Ӫ���
    function GetFactor: TdbFactory; //����
    function GetTenantID: string; //������ҵID
    function FormatFloatValue(InValue :real; size: integer): real;
    function GetStorage(EndDate: string): real; //���µ׵Ŀ��
    function GetMinGodsName(BegDate,EndDate: string): string; //������С��������Ʒ
    function GetMaxGodsName(vType: integer; BegDate,EndDate: string): string; //������ë������������Ʒ
  public
    constructor Create;
    destructor  Destroy; override;
    procedure GetSaleDayMsg;  //���ص�������msg
    procedure GetSaleMonthMsg(vCount: integer=3);  //���ص�������msg
    property Factor: TdbFactory read GetFactor; //���⴫��
    property Tenant_ID: string read GetTenantID;  //������ҵID
    property DayMsg: TSaleDayMsg read FSaleDayMsg;  //ÿ�쾭Ӫ���
    property MonthMsg: TSaleMonthMsg read FSaleMonthMsg;  //ÿ�¾�Ӫ���
  end;

var
  SaleAnalyMsg: TSaleAnalyMsg;

implementation

uses
  uGlobal,uShopGlobal,DateUtils,uFnUtil;


{ TSaleAnalyMsg }

constructor TSaleAnalyMsg.Create;
begin
  inherited;
  Qry:=TZQuery.Create(nil);
  //��ʼ���վ�Ӫ����
  FSaleDayMsg.YDSale_AMT:=0;   //��������(��λ:��);
  FSaleDayMsg.YDSale_MNY:=0;   //�������۶�(Ԫ);
  FSaleDayMsg.YDSale_PRF:=0;   //����ë��(Ԫ);
  FSaleDayMsg.YDSale_PRF_RATE:=0;  //����ë����(%);
  FSaleDayMsg.TDSale_AMT:=0;   //��������(��λ:��);
  FSaleDayMsg.TDSale_MNY:=0;   //�������۶�(Ԫ);
  FSaleDayMsg.TDSale_PRF:=0;   //����ë��(Ԫ);
  FSaleDayMsg.TDSale_PRF_RATE:=0;  //����ë����(%);

  //��ʼ���¾�Ӫ����
  FSaleMonthMsg.Month:=FormatDatetime('YYYYMM',Date());
  FSaleMonthMsg.LMSale_AMT:=0;   //��������(��λ:��);
  FSaleMonthMsg.LMSale_MNY:=0;   //�������۶�(Ԫ);
  FSaleMonthMsg.LMSale_PRF:=0;   //����ë(��λ:��);
  FSaleMonthMsg.LMSale_PRF_RATE:=0;  //��������(��λ:��);
  FSaleMonthMsg.TMGods_AMT:=0;  //���¾�ӪƷ����;
  FSaleMonthMsg.TMCust_AMT:=0;  //������������;
  FSaleMonthMsg.TMCust_MNY:=0;  //�������������ѽ��;
  FSaleMonthMsg.TMCust_RATE:=0; //��������������ռ�ı���;
  FSaleMonthMsg.TMSH_RATIO:=0;  //���´�����;
  FSaleMonthMsg.TMSale_AMT:=0;  //��������(��λ:��);
  FSaleMonthMsg.TMSale_MNY:=0;  //�������۶�(Ԫ);
  FSaleMonthMsg.TMSale_PRF:=0;  //����ë(��λ:��);
  FSaleMonthMsg.TMSale_PRF_RATE:=0;  //��������(��λ:��);
  FSaleMonthMsg.TMGods_MaxPRF:='';  //����ë���������3�������֮���á�;�������;
  FSaleMonthMsg.TMGods_MaxAMT:='';  //���������������3�������֮���á�;�������;
  FSaleMonthMsg.TMGods_MinPRF:='';  //����ë���������3�������֮���á�;�������;
  FSaleMonthMsg.TMGods_MinAMT:='';  //���������������3�������֮���á�;�������;
end;

destructor TSaleAnalyMsg.Destroy;
begin
  Qry.Free;
  inherited; 
end;

procedure TSaleAnalyMsg.GetSaleDayMsg;
var
  YsDay: string; //���죻
  ToDay: string; //����;
  str,CalcUnit: string;
begin
  try
    CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
    YsDay:=FormatDatetime('YYYYMMDD',Date()-1); //������������;
    ToDay:=FormatDatetime('YYYYMMDD',Date()); //���½������ڣ����죩;
    //�����������
    str:='select sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,(sum(SALE_MNY)+sum(SALE_TAX)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
         'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID '+
         ' and TENANT_ID='+Tenant_ID+' and SALES_DATE='+YsDay+' ';
    Qry.Close;
    Qry.SQL.Text:=str;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      FSaleDayMsg.YDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      FSaleDayMsg.YDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      FSaleDayMsg.YDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if FSaleDayMsg.YDSale_MNY>0 then
        FSaleDayMsg.YDSale_PRF_RATE:=FormatFloatValue(FSaleDayMsg.YDSale_PRF/FSaleDayMsg.YDSale_MNY,2);
    end;
    if (FSaleDayMsg.YDSale_AMT=0) and (FSaleDayMsg.YDSale_MNY=0) then Exit;  //����û�о�Ӫ��������;
    
    //�����������
    str:='select sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,(sum(SALE_MNY)+sum(SALE_TAX)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
         'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID '+
         ' and TENANT_ID='+Tenant_ID+' and SALES_DATE='+ToDay+' ';
    Qry.Close;
    Qry.SQL.Text:=str;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      FSaleDayMsg.TDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      FSaleDayMsg.TDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      FSaleDayMsg.TDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if FSaleDayMsg.YDSale_MNY>0 then
        FSaleDayMsg.YDSale_PRF_RATE:=FormatFloatValue(FSaleDayMsg.YDSale_PRF/FSaleDayMsg.YDSale_MNY,2);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('�����վ�Ӫ�������,����:'+E.message);
    end;
  end;
end;

procedure TSaleAnalyMsg.GetSaleMonthMsg(vCount: integer);
var
  LMBegDay: string; //�ϸ��¿�ʼ����;
  LMEndDay: string; //���½�������;
  TMBegDay: string; //���¿�ʼ����;
  TMEndDay: string; //���½�������;
  str,CalcUnit: string;
begin
  TopCount:=vCount;
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  LMBegDay:=FormatDatetime('YYYYMM',IncMonth(Date(),-1))+'01'; //�ϸ��¿�ʼ����;
  LMEndDay:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(Date(),-1))); //�ϸ������һ��;
  TMBegDay:=FormatDatetime('YYYYMM',Date())+'01'; //���¿�ʼ����;
  TMEndDay:=FormatDatetime('YYYYMMDD',Date());    //���½������ڣ����죩;
  try
    //�ϸ��¾�Ӫ�����
    str:=
      'select '+
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //��������[��]
      '(sum(SALE_MNY)+sum(SALE_TAX)) as SALE_MNY,'+  //���۽��
      '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //����ë��
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and '+
      ' TENANT_ID='+Tenant_ID+' and SALES_DATE>='+LMBegDay+' and SALES_DATE<='+LMEndDay+' ';
    Qry.Close;
    Qry.SQL.Text:=Str;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      FSaleMonthMsg.LMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      FSaleMonthMsg.LMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      FSaleMonthMsg.LMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if FSaleMonthMsg.LMSale_MNY<>0 then
        FSaleMonthMsg.LMSale_PRF_RATE:=FormatFloatValue(FSaleMonthMsg.LMSale_PRF/FSaleMonthMsg.LMSale_MNY,2);
    end;

    if (FSaleMonthMsg.LMSale_AMT=0) and (FSaleMonthMsg.LMSale_MNY=0) then Exit; //����û�������˳�
    //���¾�Ӫ�����
    str:=
      'select '+
      ' count(distinct a.GODS_ID) as GODS_COUNT,'+   //��Ӫ��Ʒ��
      ' count(distinct a.CLIENT_ID) as CUST_COUNT,'+  //�̶���������
      '(case when isnull(a.CLIENT_ID,'''')<>'''' then (sum(SALE_MNY)+sum(SALE_TAX)) else 0 end) as CUST_MNY,'+  //�̶����ѽ��
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //��������[��]
      '(sum(SALE_MNY)+sum(SALE_TAX)) as SALE_MNY,'+  //���۽��
      '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //����ë��
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and '+
      ' TENANT_ID='+Tenant_ID+' and SALES_DATE>='+TMBegDay+' and SALES_DATE<='+TMEndDay+' ';
    Qry.Close;
    Qry.SQL.Text:=Str;
    Factor.Open(Qry);
    if Qry.Active then
    begin
      FSaleMonthMsg.TMGods_AMT:=Qry.fieldbyName('GODS_COUNT').AsInteger; //���¾�ӪƷ����
      FSaleMonthMsg.TMCust_AMT:=Qry.fieldbyName('CUST_COUNT').AsInteger;                   //���¹̶�������
      FSaleMonthMsg.TMCust_MNY:=FormatFloatValue(Qry.fieldbyName('CUST_MNY').AsFloat,2);   //���¹̶����ѽ��
      FSaleMonthMsg.TMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);    //����������
      FSaleMonthMsg.TMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      FSaleMonthMsg.TMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      if FSaleMonthMsg.LMSale_MNY<>0 then
        FSaleMonthMsg.TMSale_PRF_RATE:=FormatFloatValue(FSaleMonthMsg.TMSale_PRF/FSaleMonthMsg.TMSale_MNY,2);
    end;
    //�ԱȾ�Ӫ�����
    if FSaleMonthMsg.TMSale_AMT>FSaleMonthMsg.LMSale_AMT then //���±���������
    begin
      FSaleMonthMsg.TMGods_MaxAMT:=GetMaxGodsName(1,TMBegDay,TMEndDay);
      FSaleMonthMsg.TMGods_MinPRF:=GetMaxGodsName(2,TMBegDay,TMEndDay);
    end else
    begin
      FSaleMonthMsg.TMGods_MinAMT:=GetMinGodsName(TMBegDay,TMEndDay);
    end;
  except
    on E:Exception do
    begin
      Raise Exception.Create('�����¾�Ӫ�������,����:'+E.message);
    end;
  end;
end;

function TSaleAnalyMsg.GetFactor: TdbFactory; //����
begin
  result:=uGlobal.Factor;
end;

function TSaleAnalyMsg.GetTenantID: string;
begin
  result:=InttoStr(Global.TENANT_ID);
end;

function TSaleAnalyMsg.FormatFloatValue(InValue: real; size: integer): real;
var
  vSize: LongInt;
  CurValue: Real;
begin
  result:=InValue;
  vSize:=1;
  case size of
   0: vSize:=1;
   1: vSize:=10;
   2: vSize:=100;
   3: vSize:=1000;
   4: vSize:=10000;
   5: vSize:=100000;
   6: vSize:=1000000;
   7: vSize:=10000000;
  end;
  CurValue:=Round(InValue*vSize);
  result:=CurValue/vSize;  //���� 
end;

//������ë������������Ʒ
function TSaleAnalyMsg.GetMaxGodsName(vType: integer; BegDate,EndDate: string): string;
var
  str,BaseTab,ReStr: string;
  rs: TZQuery;
begin
  result:='';
  ReStr:='';
  if TopCount<=0 then TopCount:=3;  //Ĭ��ȡǰ����
  BaseTab:=
    'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,VIW_GOODSINFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and TENANT_ID='''+Tenant_ID+''' and SALES_DATE>='+BegDate+' and SALES_DATE<='+EndDate+' ';

  case vType of
   1: //����
    begin
      case Factor.iDbType of
       0,2,3:
          str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SAL_AMT desc'; //����
       1: str:='select GODS_NAME From ('+BaseTab+')as tp where rownum<='+InttoStr(TopCount)+' order by SAL_AMT desc';
       4: str:='select GODS_NAME from (select * From ('+BaseTab+') as tmp order by SAL_AMT desc)tp fetch first '+InttoStr(TopCount)+' rows only ';
       5: str:='select GODS_NAME from ('+BaseTab+') as tmp order by SAL_AMT desc limit '+InttoStr(TopCount)+'';
      end;
    end;
   2: //ë��
    begin
      case Factor.iDbType of
       0,2,3:
          str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SALE_PRF desc'; //����
       1: str:='select GODS_NAME From ('+BaseTab+')as tp where rownum<='+InttoStr(TopCount)+' order by SALE_PRF desc';
       4: str:='select GODS_NAME from (select * From ('+BaseTab+') as tmp order by SALE_PRF desc)tp fetch first '+InttoStr(TopCount)+' rows only ';
       5: str:='select GODS_NAME from ('+BaseTab+') as tmp order by SALE_PRF desc limit '+InttoStr(TopCount)+' ';
      end;
    end;
  end;

  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:=str;
    Factor.Open(rs);
    if rs.Active then
    begin
      rs.First;
      while not rs.Eof do
      begin
        ReStr:=ReStr+rs.fieldbyName('GODS_NAME').AsString+';';
        rs.Next; 
      end; 
    end;
  finally
    rs.Free;
  end;
end;

//������С��������Ʒ
function TSaleAnalyMsg.GetMinGodsName(BegDate, EndDate: string): string;
var
  BaseTab,str,ReStr: string;
  rs: TZQuery;
begin
  if TopCount<=0 then TopCount:=3;  //Ĭ��ȡǰ����
  BaseTab:=
    'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,VIW_GOODSINFO b '+
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and TENANT_ID='''+Tenant_ID+''' and SALES_DATE>='+BegDate+' and SALES_DATE<='+EndDate+' ';

  case Factor.iDbType of
   0,2,3:
      str:='select top '+InttoStr(TopCount)+' GODS_NAME from ('+BaseTab+')tp order by SAL_AMT asc'; //����
   1: str:='select GODS_NAME From ('+BaseTab+')as tp where rownum<='+InttoStr(TopCount)+' order by SAL_AMT asc';
   4: str:='select GODS_NAME from (select * From ('+BaseTab+') as tmp order by SAL_AMT asc)tp fetch first '+InttoStr(TopCount)+' rows only ';
   5: str:='select GODS_NAME from ('+BaseTab+') as tmp order by SAL_AMT asc limit '+InttoStr(TopCount)+' ';
  end;

  rs:=TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text:=str;
    Factor.Open(rs);
    if rs.Active then
    begin
      rs.First;
      while not rs.Eof do
      begin
        ReStr:=ReStr+rs.fieldbyName('GODS_NAME').AsString+';';
        rs.Next; 
      end;
    end;
  finally
    rs.Free;
  end;
end;

//���µ׵Ŀ��
function TSaleAnalyMsg.GetStorage(EndDate: string): real;
begin

end;

end.
