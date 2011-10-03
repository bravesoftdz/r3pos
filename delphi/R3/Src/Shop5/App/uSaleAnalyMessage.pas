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

    TMGods_AMT: integer;  //���¾�ӪƷ����;
    TMCust_AMT: integer;  //������������;
    TMCust_MNY: real;  //�������������ѽ��;
    TMCust_RATE: real; //��������������ռ�ı���;
    TMSH_RATIO: real;  //���´�����;

    TMSale_AMT: real;  //��������(��λ:��);
    TMSale_MNY: real;  //�������۶�(Ԫ);
    TMSale_PRF: real;  //����ë(��λ:��);
    TMSale_PRF_RATE: real;  //����ë����(��λ:��);

    TMSale_AMT_UP_RATE: real;  //������������;
    TMSale_PRF_UP_RATE: real;  //����ë������;
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
    function GetFactor: TdbFactory; //����
    function GetTenantID: string; //������ҵID
    function FormatFloatValue(InValue :real; size: integer): real;
    function GetStorage(EndDate: string): real; //���µ׵Ŀ��
    function GetMinGodsName(BegDate,EndDate: string): string; //������С��������Ʒ
    function GetMaxGodsName(vType: integer; BegDate,EndDate: string): string; //������ë������������Ʒ
  public
    DayMsg: TSaleDayMsg;  //ÿ��������Ϣ
    MonthMsg: TSaleMonthMsg;  //�¾�Ӫ���
    constructor Create;
    destructor  Destroy; override;
    procedure GetSaleDayMsg;  //���ص�������msg
    procedure GetSaleMonthMsg(vCount: integer=3);  //���ص�������msg
    property Factor: TdbFactory read GetFactor; //���⴫��
    property Tenant_ID: string read GetTenantID;  //������ҵID
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
  DayMsg.YDSale_AMT:=0;   //��������(��λ:��);
  DayMsg.YDSale_MNY:=0;   //�������۶�(Ԫ);
  DayMsg.YDSale_PRF:=0;   //����ë��(Ԫ);
  DayMsg.YDSale_PRF_RATE:=0;  //����ë����(%);
  DayMsg.TDSale_AMT:=0;   //��������(��λ:��);
  DayMsg.TDSale_MNY:=0;   //�������۶�(Ԫ);
  DayMsg.TDSale_PRF:=0;   //����ë��(Ԫ);
  DayMsg.TDSale_PRF_RATE:=0;  //����ë����(%);

  //��ʼ���¾�Ӫ����
  MonthMsg.Month:=FormatDatetime('YYYYMM',IncMonth(Date(),-1));
  MonthMsg.LMSale_AMT:=0;   //��������(��λ:��);
  MonthMsg.LMSale_MNY:=0;   //�������۶�(Ԫ);
  MonthMsg.LMSale_PRF:=0;   //����ë(��λ:��);
  MonthMsg.TMGods_AMT:=0;  //���¾�ӪƷ����;
  MonthMsg.TMCust_AMT:=0;  //������������;
  MonthMsg.TMCust_MNY:=0;  //�������������ѽ��;
  MonthMsg.TMCust_RATE:=0; //��������������ռ�ı���;
  MonthMsg.TMSH_RATIO:=0;  //���´�����;
  MonthMsg.TMSale_AMT:=0;  //��������(��λ:��);
  MonthMsg.TMSale_MNY:=0;  //�������۶�(Ԫ);
  MonthMsg.TMSale_PRF:=0;  //����ë(��λ:��);
  MonthMsg.TMSale_PRF_RATE:=0;  //��������(��λ:��);
  MonthMsg.TMSale_AMT_UP_RATE:=0; //����������
  MonthMsg.TMSale_PRF_UP_RATE:=0; //���۶�������
  MonthMsg.TMGods_MaxPRF:='';  //����ë���������3�������֮���á�;�������;
  MonthMsg.TMGods_MaxAMT:='';  //���������������3�������֮���á�;�������;
  MonthMsg.TMGods_MinPRF:='';  //����ë���������3�������֮���á�;�������;
  MonthMsg.TMGods_MinAMT:='';  //���������������3�������֮���á�;�������;
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
  NOTAX_MONEY: Real;
begin
  try
    CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
    YsDay:=FormatDatetime('YYYYMMDD',Date()-1); //������������;
    ToDay:=FormatDatetime('YYYYMMDD',Date()); //���½������ڣ����죩;
    //�����������
    str:=
      'select sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 '+
      ' and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE='+YsDay+' ';
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      DayMsg.YDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      DayMsg.YDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      DayMsg.YDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //����˰��� 
      if NOTAX_MONEY<>0 then //ë�� �� ����˰���
        DayMsg.YDSale_PRF_RATE:=FormatFloatValue((DayMsg.YDSale_PRF*100)/NOTAX_MONEY,2);
    end;
    //if (DayMsg.YDSale_AMT=0) and (DayMsg.YDSale_MNY=0) then Exit;  //����û�о�Ӫ��������;
    
    //�����������
    str:=
      'select sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 '+
      ' and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE='+ToDay+' ';
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      DayMsg.TDSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      DayMsg.TDSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      DayMsg.TDSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
      NOTAX_MONEY:=Qry.fieldbyName('NOTAX_MONEY').AsFloat; //����˰��� 
      if NOTAX_MONEY>0 then
        DayMsg.TDSale_PRF_RATE:=FormatFloatValue((DayMsg.TDSale_PRF*100)/NOTAX_MONEY,2);
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
  StorageValue,NOTAX_MONEY: real; //�������
begin
  TopCount:=vCount;
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  LMBegDay:=FormatDatetime('YYYYMM',IncMonth(Date(),-2))+'01'; //�ϸ��¿�ʼ����;
  LMEndDay:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(Date(),-2))); //�ϸ������һ��;
  TMBegDay:=FormatDatetime('YYYYMM',IncMonth(Date(),-1))+'01'; //���¿�ʼ����;
  TMEndDay:=FnTime.GetLastDate(FormatDatetime('YYYYMM',IncMonth(Date(),-1)));    //���½������ڣ����죩;
  try
    //�ϸ��¾�Ӫ�����
    str:=
      'select '+
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+      //��������[��]
      '(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,'+  //���۽��
      '(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+ //����ë��
      'from VIW_SALESDATA a,VIW_GOODSINFO b where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and '+
      ' a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+LMBegDay+' and a.SALES_DATE<='+LMEndDay+' ';
    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      MonthMsg.LMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);
      MonthMsg.LMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);
      MonthMsg.LMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);
    end;

    //if (MonthMsg.LMSale_AMT=0) and (MonthMsg.LMSale_MNY=0) then Exit; //����û�������˳�

    //���¾�Ӫ�����
    Str:=
      'select TENANT_ID,CLIENT_ID,GODS_ID,CALC_AMOUNT,NOTAX_MONEY,'+
      'cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3)) as SALE_MNY,'+
      'cast(isnull(NOTAX_MONEY,0)-isnull(COST_MONEY,0) as decimal(18,3)) as SALE_PRF,'+
      '(case when isnull(CLIENT_ID,'''')<>'''' then cast(isnull(NOTAX_MONEY,0)+isnull(TAX_MONEY,0) as decimal(18,3)) else 0 end) as CUST_MNY '+
      ' from VIW_SALESDATA where TENANT_ID='+Tenant_ID+' and SALES_DATE>='+TMBegDay+' and SALES_DATE<='+TMEndDay+' ';

    str:=
      'select '+
      ' count(distinct a.GODS_ID) as GODS_COUNT,'+   //��Ӫ��Ʒ��
      ' count(distinct a.CLIENT_ID) as CUST_COUNT,'+  //�̶���������
      ' sum(CUST_MNY) as CUST_MNY,'+  //�̶����ѽ��
      ' sum(NOTAX_MONEY) as NOTAX_MONEY,'+  //����˰���
      ' sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+  //��������[��]
      ' sum(SALE_MNY) as SALE_MNY,'+  //���۽��
      ' sum(SALE_PRF) as SALE_PRF '+ //����ë��
      'from ('+Str+') a,VIW_GOODSINFO b '+
      ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and b.RELATION_ID=1000006 and b.TENANT_ID='+Tenant_ID;

    Qry.Close;
    Qry.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(Qry);
    if Qry.Active then
    begin
      MonthMsg.TMGods_AMT:=Qry.fieldbyName('GODS_COUNT').AsInteger; //���¾�ӪƷ����
      MonthMsg.TMCust_AMT:=Qry.fieldbyName('CUST_COUNT').AsInteger;                   //���¹̶�������
      MonthMsg.TMCust_MNY:=FormatFloatValue(Qry.fieldbyName('CUST_MNY').AsFloat,2);   //���¹̶����ѽ��
      MonthMsg.TMSale_AMT:=FormatFloatValue(Qry.fieldbyName('SAL_AMT').AsFloat,3);    //����������
      MonthMsg.TMSale_MNY:=FormatFloatValue(Qry.fieldbyName('SALE_MNY').AsFloat,2);   //�������۶�
      MonthMsg.TMSale_PRF:=FormatFloatValue(Qry.fieldbyName('SALE_PRF').AsFloat,2);   //��������ë����
      NOTAX_MONEY:=FormatFloatValue(Qry.fieldbyName('NOTAX_MONEY').AsFloat,2);        //���²�����˰���
      if NOTAX_MONEY>0 then
        MonthMsg.TMSale_PRF_RATE:=FormatFloatValue((MonthMsg.TMSale_PRF*100)/NOTAX_MONEY,2);

      if MonthMsg.TMSale_MNY<>0 then
        MonthMsg.TMCust_RATE:=FormatFloatValue((MonthMsg.TMCust_MNY*100)/MonthMsg.TMSale_MNY,2);
    end;

    //�ԱȾ�Ӫ�����
    if MonthMsg.LMSale_AMT<>0 then
      MonthMsg.TMSale_AMT_UP_RATE:=((MonthMsg.TMSale_AMT-MonthMsg.LMSale_AMT)*100)/MonthMsg.LMSale_AMT;  //������������;
    if MonthMsg.LMSale_PRF<>0 then
      MonthMsg.TMSale_PRF_UP_RATE:=((MonthMsg.TMSale_PRF-MonthMsg.LMSale_PRF)*100)/MonthMsg.LMSale_PRF;  //����ë������;
    //��Ӫ������������Ʒ:
    MonthMsg.TMGods_MaxAMT:=GetMaxGodsName(1,TMBegDay,TMEndDay);  //����ǰ��λ
    MonthMsg.TMGods_MaxPRF:=GetMaxGodsName(2,TMBegDay,TMEndDay);  //ë��ǰ��λ

    MonthMsg.TMGods_MinAMT:=GetMinGodsName(TMBegDay,TMEndDay);  //��������λ
    StorageValue:=GetStorage(TMEndDay);                         //�µ��ܿ�
    if MonthMsg.TMSale_AMT<>0 then
      MonthMsg.TMSH_RATIO:=FormatFloatValue(StorageValue/MonthMsg.TMSale_AMT,5); //������
  except
    on E:Exception do
    begin
      Raise Exception.Create('�����¾�Ӫ��������,����:'+E.message);
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

  case vType of
   1: //����
    begin
      BaseTab:=
        'select GODS_NAME,sum(CALC_AMOUNT) as SAL_AMT from VIW_SALESDATA a,VIW_GOODSINFO b '+
        ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' and b.RELATION_ID=1000006 '+
        ' group by GODS_NAME';
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
      BaseTab:=
        'select GODS_NAME,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF from VIW_SALESDATA a,VIW_GOODSINFO b '+
        ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' and b.RELATION_ID=1000006 '+
        ' group by GODS_NAME';
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
    rs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if rs.Active then
    begin
      rs.First;
      while not rs.Eof do
      begin
        if ReStr='' then
          ReStr:=rs.fieldbyName('GODS_NAME').AsString
        else
          ReStr:=ReStr+'��'+rs.fieldbyName('GODS_NAME').AsString;
        rs.Next;
      end; 
    end;
  finally
    rs.Free;
  end;
  result:=ReStr;
  if result='' then result:='��';
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
    ' where a.TENANT_ID=b.TENANT_ID and a.GODS_ID=b.GODS_ID and a.TENANT_ID='+Tenant_ID+' and a.SALES_DATE>='+BegDate+' and a.SALES_DATE<='+EndDate+' and b.RELATION_ID=1000006 '+
    ' group by GODS_NAME';

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
    rs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if rs.Active then
    begin
      rs.First;
      while not rs.Eof do
      begin
        if ReStr='' then
          ReStr:=rs.fieldbyName('GODS_NAME').AsString
        else
          ReStr:=ReStr+'��'+rs.fieldbyName('GODS_NAME').AsString;
        rs.Next; 
      end;
    end;
  finally
    rs.Free;
  end;
  result:=ReStr;
  if result='' then result:='��';
end;

//���µ׵Ŀ��
function TSaleAnalyMsg.GetStorage(EndDate: string): real;
var
  rs:TZQuery;
  UnitCalc: string;
  Str,MaxReckDate,BegDate: string;
begin
  result:=0.0;
  MaxReckDate:='';
  BegDate:=EndDate; //��ѯ�������
  UnitCalc:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  rs := TZQuery.Create(nil);
  try
    Str:='select Max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID='+TENANT_ID;
    rs.Close;
    rs.SQL.Text := ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if rs.Active then MaxReckDate:=trim(rs.fieldbyName('CREA_DATE').AsString);

    if MaxReckDate='' then //δ����ȫ������ͼ:
    begin
      Str:=
        'select sum(cast(case when ORDER_TYPE in (11,13) then STOCK_AMT '+
                            ' when ORDER_TYPE in (21,23,24) then -SALE_AMT '+
                            ' when ORDER_TYPE=12 then DBIN_AMT '+
                            ' when ORDER_TYPE=22 then -DBOUT_AMT '+
                            ' else (CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT)*1.0 end as decimal(18,3))*1.0/'+UnitCalc+')as BAL_AMT '+
         'from VIW_GOODS_DAYS A,VIW_GOODSINFO D '+
         ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and D.RELATION_ID=1000006 '+
         ' and A.CREA_DATE<='+BegDate+' ';
    end else
    begin
      if MaxReckDate>=BegDate then  //�ѽ��ˣ�ȫ����̨�˱�
      begin
        Str:='select sum(A.BAL_AMT*1.0/'+UnitCalc+') as BAL_AMT from RCK_GOODS_DAYS A,VIW_GOODSINFO D '+
             ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+BegDate+' and D.RELATION_ID=1000006 ';
      end else //������������[union]
      begin
        Str:=
          'select sum(BAL_AMT) as BAL_AMT from '+
          '(select sum(A.BAL_AMT*1.0/'+UnitCalc+') as BAL_AMT from RCK_GOODS_DAYS A,VIW_GOODSINFO D '+
          ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE='+MaxReckDate+' and D.RELATION_ID=1000006 '+
          '  union all  '+
          ' select sum((case when ORDER_TYPE in (11,13) then STOCK_AMT '+
                           ' when ORDER_TYPE in (21,23,24) then -SALE_AMT '+
                           ' when ORDER_TYPE=12 then DBIN_AMT '+
                           ' when ORDER_TYPE=22 then -DBOUT_AMT '+
                           ' else CHANGE1_AMT+CHANGE2_AMT+CHANGE3_AMT+CHANGE4_AMT+CHANGE5_AMT end)*1.0/'+UnitCalc+')as BAL_AMT '+
          ' from VIW_GOODS_DAYS A,VIW_GOODSINFO D '+
          ' where A.TENANT_ID=D.TENANT_ID and A.GODS_ID=D.GODS_ID and A.TENANT_ID='+TENANT_ID+' and A.CREA_DATE>'+MaxReckDate+
          ' and A.CREA_DATE<='+BegDate+' and D.RELATION_ID=1000006)tmp ';
      end;
    end;
    rs.Close;
    rs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
    Factor.Open(rs);
    if Rs.Active then
    begin
      if Rs.RecordCount=1 then
        result:=rs.fieldbyName('BAL_AMT').AsFloat
      else if Rs.RecordCount=0 then
        result:=0;
    end;
  finally
    rs.Free;
  end;
end;

end.
