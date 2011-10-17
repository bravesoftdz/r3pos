unit uWelcome;

interface
uses
  Windows, Messages, SysUtils, Classes, InvokeRegistry, Types, XSBuiltIns,
  Des, WinInet, Controls, ComObj, ObjCommon, ZDataSet, DB, ZdbFactory, ZBase,
  Variants, ZLogFile,Dialogs;
  
type
  TMsgDayInfo=Record
    YDSaleGods_Count: integer; //��������Ʒ��(��λ:��);
    YDSaleBill_Count: integer; //�������۵��ݱ���(��λ:��);
    YDSale_AMT: real;          //��������(��λ:��);
    YDSale_MNY: real;          //�������۶�(Ԫ);
    YDSale_PRF: real;          //����ë��(Ԫ);
    YDSale_PRF_RATE: real;     //����ë����(%);

    TDSaleGods_Count: integer; //��������Ʒ��(��λ:��);
    TDSaleBill_Count: integer; //�������۵��ݱ���(��λ:��);
    TDSale_Count: integer;     //����Ʒ��(��λ:��);
    TDSale_AMT: real;          //��������(��λ:��);
    TDSale_MNY: real;          //�������۶�(Ԫ);
    TDSale_PRF: real;          //����ë��(Ԫ);
    TDSale_PRF_RATE: real;     //����ë����(%);

    //��ǰ��Ա�:
    QTSaleGods_Count: integer; //ǰ������Ʒ��(��λ:��);
    QTSaleBill_Count: integer; //ǰ�����۵��ݱ���(��λ:��);
    QTSale_Count: integer;     //����Ʒ��(��λ:��);
    QTSale_AMT: real;          //��������(��λ:��);
    QTSale_MNY: real;          //�������۶�(Ԫ);
    QTSale_PRF: real;          //����ë��(Ԫ);
    QTSale_PRF_RATE: real;     //����ë����(%);

    TDStockGods_Count: integer; //���ν�����Ʒ��
    TDStock_AMT: real;  //���ν�������
    TDStock_MNY: real;  //���ν������

    SCStockGods_Count: integer; //���ν�����Ʒ��
    SCStock_AMT: real;  //���ν�������
    SCStock_MNY: real;  //���ν������

    TMGods_All_Count:integer;  //���¾�Ӫ��Ʒ����;
    TMGods_Count:integer;      //�����п��Ʒ����;
    TMGods_SX_Count:integer;   //�̲ݳ���Ʒ����;
    TMGods_NEW_Count:integer;  //��Ӫ��Ʒ����;
    TMAllStor_AMT:real;        //��Ʒ�ܿ����
    TMLowStor_Count:integer;   //���ں�������Ʒ��
  end;

  //�·ݾ�Ӫ���:
  TMsgMonthInfo=Record
    //ͬ���»���:
    LMSale_AMT: real;   //��������(��λ:��);
    LMSale_MNY: real;   //�������۶�(Ԫ);
    LMSale_PRF: real;   //����ë(��λ:��);
    LMSale_SINGLE_MNY: real;  //����ƽ��ÿ�����۶�(Ԫ);

    //��ǰ�·�
    TMStock_AMT: real;    //���¹���(��λ:��);
    TMStock_MNY: real;    //���¹���(����ֵ);
    
    TMSale_AMT: real;     //��������(��λ:��);
    TMSale_MNY: real;     //�������۶�(Ԫ);
    TMSale_PRF: real;     //����ë(��λ:��);
    TMSale_PRF_RATE: real;    //����ë����;
    TMSale_SINGLE_MNY: real;  //����ƽ��ÿ�����۶�(Ԫ);
    TMSale_AMT_UP_RATE: real;    //������������;
    TMSale_PRF_UP_RATE: real;    //����ë��������;
    TMSale_SINGLE_MNY_UP_RATE: real;   //���µ������������;

    LMGods_SY_MaxGrow_AMT: string;  //�����������ǰ3�������֮���á�;�������;
    LMGods_SY_MaxGrow_PRF: string;  //����ë�����ǰ3�������֮���á�;�������;
    TMGods_MaxGrow_AMT: string;  //�����������ǰ3�������֮���á�;�������;
    TMGods_MaxGrow_PRF: string;  //����ë�����ǰ3�������֮���á�;�������;
    TMGods_MaxGrowRate_AMT: string;  //���������������3�������֮���á�;�������;

    //2011.10.12 ������(��Ա)���:
    TMCust_Count: integer;     //�ܵ������߸���;
    TMCust_HG_Count: integer;  //�ߵ��̲������߸���;
    TMCust_NEW_Count: integer; //�����½������߸���;
    TMCust_AMT: real;          //��������������;
    TMCust_MNY: real;          //���������ѽ��;
    TMCust_AMT_RATE: real;     //������������������ռ�ı���;
    TMCust_MNY_RATE: real;     //�������������ѽ��ռ�ı���;
    TMCust_MAX_TIME:string;    //������ʱ��
  end;
  
  TWelcome=class
  private
    FHotSale: array [0..23] of real;
    dayRs:TZQuery;
    dayJh:TZQuery;
    dayKc:TZQuery;
    MthRs:TZQuery;
    CustRs:TZQuery;
    FDay1: string;    //���·ݵڼ���
    FDay2: string;    //���·ݵڼ���
    FLMonth: string; //�ϸ���
    FMonth: string;  //���·�
    QtDay:string;
    YsDay:string;
    ToDay:string;
    function  FormatFloatValue(InValue :real; size: integer): real; //С��λ����
    procedure LoadDays;
    procedure LoadMths;
    procedure SetMonth(const Value: string);
    function  GetGodsNames(GodsIds: TStringList): string; //����GodsIDS����GodsNAME
    function  GetAmtGrowRateMax: String; //���������     //�������������
    function  GetMaxGrowGodsName(vType,Month: integer): String; //�������������Ʒ
    //��������ʱ��
    function  GetTMCust_MAX_TIME:string;
  public
    constructor Create;
    destructor Destroy; override;
    function EncodeMsgDayInfo:TMsgDayInfo;
    function EncodeMsgMthInfo:TMsgMonthInfo;

    property Month:string read FMonth write SetMonth;
  end;

implementation
uses uGlobal,uFnUtil;

{ TWelcome }

constructor TWelcome.Create;
begin
  dayRs := TZQuery.Create(nil);
  dayJh := TZQuery.Create(nil);
  dayKc := TZQuery.Create(nil);
  MthRs := TZQuery.Create(nil);
  CustRs := TZQuery.Create(nil);
  Month := formatDatetime('YYYYMM',Date());
end;

destructor TWelcome.Destroy;
begin
  dayRs.Free;
  dayJh.Free;
  dayKc.Free;
  MthRs.Free;
  CustRs.Free;
  inherited;
end;

function TWelcome.EncodeMsgDayInfo: TMsgDayInfo;
begin
  if not dayRs.Active then LoadDays;
  Fillchar(result,sizeof(result),0);
  //�����������:
  if dayRs.Locate('SALES_DATE',strtoint(YsDay),[]) then
  begin
    result.YDSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.YDSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.YDSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.YDSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.YDSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //ë�� �� ����˰���
       result.YDSale_PRF_RATE:=(result.YDSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;
  //�����������:
  if dayRs.Locate('SALES_DATE',strtoint(ToDay),[]) then
  begin
    result.TDSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.TDSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.TDSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.TDSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.TDSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //ë�� �� ����˰���
       result.TDSale_PRF_RATE:=(result.TDSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;
  //ǰ���������:
  if dayRs.Locate('SALES_DATE',strtoint(QTDay),[]) then
  begin
    result.QTSaleGods_Count:=dayRs.fieldbyName('SALES_GODS_COUNT').AsInteger;
    result.QTSaleBill_Count:=dayRs.fieldbyName('SALES_BILL_COUNT').AsInteger;
    result.QTSale_AMT:=dayRs.fieldbyName('SAL_AMT').AsFloat;
    result.QTSale_MNY:=dayRs.fieldbyName('SALE_MNY').AsFloat;
    result.QTSale_PRF:=dayRs.fieldbyName('SALE_PRF').AsFloat;
    if dayRs.fieldbyName('NOTAX_MONEY').AsFloat<>0 then //ë�� �� ����˰���
       result.QTSale_PRF_RATE:=(result.QTSale_PRF*100)/dayRs.fieldbyName('NOTAX_MONEY').AsFloat;
  end;

  //���һ�ν������
  result.TDStockGods_Count:=dayJh.fieldbyName('GODS_COUNT').AsInteger;
  result.TDStock_AMT:=dayJh.fieldbyName('STK_AMT').AsFloat;
  result.TDStock_MNY:=dayJh.fieldbyName('STK_MNY').AsFloat;
  //����2�ν������
  if dayJh.recordCount>1 then
  begin
    dayJh.Next;
    result.SCStockGods_Count:=dayJh.fieldbyName('GODS_COUNT').AsInteger;
    result.SCStock_AMT:=dayJh.fieldbyName('STK_AMT').AsFloat;
    result.SCStock_MNY:=dayJh.fieldbyName('STK_MNY').AsFloat;
  end;
  //��ǰ���
  result.TMGods_All_Count:=dayKc.FieldbyName('ALLGODS_COUNT').AsInteger;   //���¾�Ӫ��Ʒ����;
  result.TMGods_Count:=dayKc.FieldbyName('GODS_COUNT').AsInteger;       //�����п��Ʒ����;
  result.TMGods_SX_Count:=dayKc.FieldbyName('GODS_SX_COUNT').AsInteger; //���³���Ʒ����
  result.TMGods_NEW_Count:=dayKc.FieldbyName('GODS_NEW_COUNT').AsInteger; //������Ʒ����
  result.TMLowStor_Count:=dayKc.FieldbyName('LOWER_COUNT').AsInteger; //���ں�������Ʒ��
  result.TMAllStor_AMT:=dayKc.FieldbyName('STOR_SUM').AsFloat;        //��Ʒ�ܿ����
end;

function TWelcome.EncodeMsgMthInfo: TMsgMonthInfo;
var
  GodsID: string;
  TM_NOTAX_MNY: real; //δ˰���
  RsGods: TZQuery;
  i:integer;
begin
  self.LoadMths; //���²�ѯ
  TM_NOTAX_MNY:=0;
  Fillchar(result,sizeof(result),0); //��ʼ������
  Fillchar(FHotSale,sizeof(FHotSale),0);
  RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO'); 
  for i:=0 to 23 do FHotSale[i] := 0;
  //ѭ��ȡ����:
  MthRs.First;
  while not MthRs.Eof do
  begin
    if MthRs.FieldByName('SALES_DATE').AsCurrency=StrtoIntDef(FLMonth,0) then //�ϸ��·�
    begin
      result.LMSale_AMT:=result.LMSale_AMT+MthRs.FieldByName('SAL_AMT').AsFloat;  //��������(��λ:��);
      result.LMSale_MNY:=result.LMSale_MNY+MthRs.FieldByName('SALE_MNY').AsFloat; //�������۶�(Ԫ);
      result.LMSale_PRF:=result.LMSale_PRF+MthRs.FieldByName('SALE_PRF').AsFloat; //����ë(��λ:��);
    end else
    if MthRs.FieldByName('SALES_DATE').AsCurrency=StrtoIntDef(FMonth,0) then //��ǰ�·�
    begin
      TM_NOTAX_MNY:=TM_NOTAX_MNY+MthRs.FieldByName('NOTAX_MONEY').AsFloat;  //δ˰���
      result.TMSale_AMT:=result.TMSale_AMT+MthRs.FieldByName('SAL_AMT').AsFloat;  //��������(��λ:��);
      result.TMSale_MNY:=result.TMSale_MNY+MthRs.FieldByName('SALE_MNY').AsFloat; //�������۶�(Ԫ);
      result.TMSale_PRF:=result.TMSale_PRF+MthRs.FieldByName('SALE_PRF').AsFloat; //����ë(��λ:��);
      for i:=0 to 23 do FHotSale[i] := FHotSale[i] + MthRs.FieldByName('T'+formatFloat('00',i)+'_AMT').AsFloat;

      if MthRs.FieldByName('CUST_FLAG').AsCurrency>0 then
      begin
        result.TMCust_AMT:=result.TMCust_AMT+MthRs.FieldByName('SAL_AMT').AsFloat;
        result.TMCust_MNY:=result.TMCust_MNY+MthRs.FieldByName('SALE_MNY').AsFloat;
        if RsGods.Locate('GODS_ID',MthRs.FieldbyName('GODS_ID').asString,[]) and (RsGods.FieldbyName('SORT_ID2').asString='85994503-9CBC-4346-BC86-24C7F5A92BC6') then
          result.TMCust_HG_Count := result.TMCust_HG_Count+1;
      end;
    end;
    MthRs.Next;
  end;

  if result.LMSale_AMT<>0 then
    result.LMSale_SINGLE_MNY:=FormatFloatValue(result.LMSale_MNY/result.LMSale_AMT,2); //����ƽ��ÿ�����۶�(Ԫ);
  if TM_NOTAX_MNY<>0 then
    result.TMSale_PRF_RATE:=FormatFloatValue(result.TMSale_PRF/TM_NOTAX_MNY,2);  //����ë��;
  if result.TMSale_AMT<>0 then
    result.TMSale_SINGLE_MNY:=FormatFloatValue(result.TMSale_MNY/result.TMSale_AMT,2); //����ƽ��ÿ�����۶�(Ԫ);
  result.TMSale_AMT_UP_RATE:=result.TMSale_AMT-result.LMSale_AMT;   //������������;
  result.TMSale_PRF_UP_RATE:=result.TMSale_PRF-result.LMSale_PRF;   //����ë������;
  if result.LMSale_SINGLE_MNY<>0 then
    result.TMSale_SINGLE_MNY_UP_RATE:=FormatFloatValue((result.TMSale_SINGLE_MNY-result.LMSale_SINGLE_MNY)*100/result.LMSale_SINGLE_MNY,2);   //���µ������������;

  if result.TMCust_AMT<>0 then
    result.TMCust_AMT_RATE:=result.TMCust_AMT/result.TMSale_AMT; //������������������ռ�ı���;
  if result.TMCust_MNY<>0 then
    result.TMCust_MNY_RATE:=result.TMCust_MNY/result.TMSale_MNY; //�������������ѽ��ռ�ı���;

  result.TMCust_MAX_TIME := GetTMCust_MAX_TIME;

  result.LMGods_SY_MaxGrow_AMT:=GetMaxGrowGodsName(1,StrtoInt(FLMonth));
  result.LMGods_SY_MaxGrow_PRF:=GetMaxGrowGodsName(2,StrtoInt(FLMonth));
  result.TMGods_MaxGrow_AMT:=GetMaxGrowGodsName(1,StrtoInt(FMonth));
  result.TMGods_MaxGrow_PRF:=GetMaxGrowGodsName(2,StrtoInt(FMonth));
  result.TMGods_MaxGrowRate_AMT:=GetAmtGrowRateMax;

  //2011.10.12 ������(��Ա)���:
  result.TMCust_Count:=CustRs.FieldByName('allCount').AsInteger;       //�ܵ������߸���;
  result.TMCust_NEW_Count:=CustRs.FieldByName('newCount').AsInteger;   //�����½������߸���;
end;

function TWelcome.FormatFloatValue(InValue: real; size: integer): real;
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

function TWelcome.GetGodsNames(GodsIds: TStringList): string;
var
  GodsID: string;
  RsGods: TZQuery;
  i:integer;
begin
  RsGods:=Global.GetZQueryFromName('PUB_GOODSINFO');
  if GodsIds.Count>0 then
  begin
    for i:=0 to GodsIds.Count-1 do
    begin
      GodsID:=trim(GodsIds.Strings[i]);
      if RsGods.Locate('GODS_ID',GodsID,[]) then
      begin
        if result<>'' then result:=result+'��';
        result:=result+RsGods.fieldbyName('GODS_NAME').AsString;
      end;
    end;
  end else
    result:='��';
end;

function TWelcome.GetMaxGrowGodsName(vType, Month: integer): string;
  function SetGodsInfo(GodsIDS: TStringList; FieldName: string ; var GODS_ID: string; var Gods_VALUE: Real):Boolean;
  begin
    MthRs.First;
    while not MthRs.Eof do
    begin
      if MthRs.FieldByName('SALES_DATE').AsCurrency=Month then
      begin
        if GodsIDS.IndexOf(MthRs.FieldByName('GODS_ID').AsString)=-1 then
        begin
          GODS_ID:=MthRs.FieldByName('GODS_ID').AsString;
          Gods_VALUE:=MthRs.FieldByName(FieldName).AsFloat;
          break;
        end;
      end;
      MthRs.Next;
    end;
  end;
var
  i: integer;
  CurValue: Real;
  GodsID,FieldName: string;
  tmpTable: TZQuery;
  Gods_IDList: TStringList;
begin
  result:='';
  case vType of
   1: FieldName:='SAL_AMT';
   2: FieldName:='SALE_PRF';
  end;

  try
    tmpTable:=TZQuery.Create(nil);
    tmpTable.Data:=MthRs.Data;
    Gods_IDList:=TStringList.Create;
    for i:=1 to 5 do
    begin
      //��ȡGODS_ID
      SetGodsInfo(Gods_IDList,FieldName,GodsID, CurValue);

      tmpTable.First;
      while not tmpTable.Eof do
      begin
        if tmpTable.FieldByName('SALES_DATE').AsCurrency=Month then
        begin
          if Gods_IDList.IndexOf(tmpTable.FieldByName('GODS_ID').AsString)=-1 then //����List��
          begin   
            if CurValue<tmpTable.FieldByName(FieldName).AsFloat then
              GodsID:=tmpTable.FieldByName('GODS_ID').AsString;  
          end;
        end;
        tmpTable.Next;
      end;
      if GodsID<>'' then Gods_IDList.Add(GodsID);            
    end;
    result:=GetGodsNames(Gods_IDList);
  finally
    Gods_IDList.Free;
    tmpTable.Free;
  end;
end;

function TWelcome.GetAmtGrowRateMax: string; //���������
  function SetGodsInfo(GodsIDS: TStringList; Rs: TZQuery; var GODS_ID: string; var GODS_VALUE: Real):Boolean;
  begin
    Rs.First;
    while not Rs.Eof do
    begin
      if GodsIDS.IndexOf(Rs.FieldByName('GODS_ID').AsString)=-1 then
      begin
        GODS_ID:=Rs.FieldByName('GODS_ID').AsString;
        GODS_VALUE:=Rs.FieldByName('AMT_RATE').AsFloat;
        break;
      end;
      Rs.Next;
    end;
  end;
var
  i: integer;
  CurValue: Real;
  GodsID,FieldName: string;
  GrowRs: TZQuery;
  Gods_IDList: TStringList;
begin
  try
    CurValue := -9999;
    GrowRs:=TZQuery.Create(nil);
    GrowRs.FieldDefs.Add('GODS_ID',ftstring,36,true);
    GrowRs.FieldDefs.Add('TM_AMT',ftfloat,0,true);
    GrowRs.FieldDefs.Add('LM_AMT',ftfloat,0,true);
    GrowRs.FieldDefs.Add('AMT_RATE',ftfloat,0,true);
    GrowRs.CreateDataSet;
    MthRs.First;
    while not MthRs.Eof do
    begin
      GodsID:=trim(MthRs.FieldByName('GODS_ID').AsString);
      if MthRs.FieldByName('SALES_DATE').AsCurrency=StrtoIntDef(FLMonth,0) then //�ϸ���
      begin
        if GrowRs.Locate('GODS_ID',GodsID,[]) then GrowRs.Edit
        else
        begin
          GrowRs.Append;
          GrowRs.FieldByName('GODS_ID').AsString:=GodsID;
        end;
        GrowRs.FieldByName('LM_AMT').AsFloat:=GrowRs.FieldByName('LM_AMT').AsFloat+MthRs.FieldByName('SAL_AMT').AsFloat;
      end else
      if MthRs.FieldByName('SALES_DATE').AsCurrency=StrtoIntDef(FMonth,0) then //����
      begin
        if GrowRs.Locate('GODS_ID',GodsID,[]) then GrowRs.Edit
        else
        begin
          GrowRs.Append;
          GrowRs.FieldByName('GODS_ID').AsString:=GodsID;
        end;
        GrowRs.FieldByName('TM_AMT').AsFloat:=GrowRs.FieldByName('TM_AMT').AsFloat+MthRs.FieldByName('SAL_AMT').AsFloat;
      end;
      if MthRs.FieldByName('SAL_AMT').AsFloat<>0 then
        GrowRs.FieldByName('AMT_RATE').AsFloat:=GrowRs.FieldByName('TM_AMT').AsFloat/MthRs.FieldByName('SAL_AMT').AsFloat
      else
        GrowRs.FieldByName('AMT_RATE').AsFloat:=0;
      MthRs.Next;
    end;

    //ȡ���5��
    Gods_IDList:=TStringList.Create;
    for i:=1 to 5 do
    begin
      //��ȡGODS_ID
      SetGodsInfo(Gods_IDList,GrowRs,GodsID, CurValue);

      GrowRs.First;
      while not GrowRs.Eof do
      begin
        if Gods_IDList.IndexOf(GrowRs.FieldByName('GODS_ID').AsString)=-1 then //����List��
        begin
          if CurValue<GrowRs.FieldByName('AMT_RATE').AsFloat then
            GodsID:=GrowRs.FieldByName('GODS_ID').AsString;
        end;
        GrowRs.Next;
      end;
      if GodsID<>'' then Gods_IDList.Add(GodsID);            
    end;
    result:=GetGodsNames(Gods_IDList);
  finally
    Gods_IDList.Free;
    GrowRs.Free;
  end;
end;


procedure TWelcome.LoadDays;
var
  CalcUnit,str:string;
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  //�������
  str:=
    'select a.STOCK_DATE as STOCK_DATE,count(distinct a.GODS_ID) as GODS_COUNT,sum(CALC_AMOUNT/'+CalcUnit+') as STK_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as STK_MNY '+
    'from VIW_STOCKDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 '+
    ' and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.STOCK_DATE>:LAST_DATE '+
    'group by a.STOCK_DATE order by a.STOCK_DATE desc';
    
  dayJh.Close;
  dayJh.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  dayJh.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  dayJh.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  dayJh.ParamByName('LAST_DATE').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',Date-30));
  Factor.Open(dayJh);

  //��ǰ���
  str:= ParseSQL(Factor.iDbType,
      'select '+
      ' count(distinct c.GODS_ID) as ALLGODS_COUNT,'+  //����Ʒ������
      ' sum(case when bb.STOR_GODS_ID is null then 1 else 0 end) as GODS_COUNT,'+  //�п����Ʒ����
      ' sum(case when c.SORT_ID10 =''5D8D7AF6-2DE3-4866-85C7-925E07F66096'' then 1 else 0 end) as GODS_SX_COUNT,'+  //�Ƿ��ǳ���Ʒ��
      ' sum(case when c.SORT_ID10=''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'' then 1 else 0 end) as GODS_NEW_COUNT,'+  //�̲��ṩ��Ʒ����
      ' sum(case when (c.SORT_ID10=''32FD7EE2-5F01-4131-B46F-2A8A81B9C60F'') and (bb.STOR_GODS_ID is not  null) then 1 else 0 end) as GODS_NEW_SALE_COUNT,'+  //���ۻ���Ӫ��Ʒ����
      ' sum(case when (Round(bb.AMOUNT,3)<Round(bb.LOWER_AMOUNT,3)) and (isnull(Round(bb.LOWER_AMOUNT,3),0)>0) then 1 else 0 end) as LOWER_COUNT, '+ //���ں���������
      ' sum(AMOUNT/'+CalcUnit+') as STOR_SUM '+  //���������[��λ:��]
      ' from VIW_GOODSINFO c '+
      ' left outer join '+
      ' (select a.GODS_ID as STOR_GODS_ID,b.LOWER_AMOUNT,round(a.AMOUNT,3) as AMOUNT from STO_STORAGE a '+
      '   left join PUB_GOODS_INSHOP b on  a.TENANT_ID=b.TENANT_ID and a.SHOP_ID=b.SHOP_ID and a.GODS_ID=b.GODS_ID '+
      '  where a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and round(a.AMOUNT,3)>0) bb '+
      ' on c.GODS_ID=bb.STOR_GODS_ID '+
      ' where c.TENANT_ID='+inttostr(Global.TENANT_ID)+' and c.RELATION_ID=1000006 and c.COMM not in (''01'',''02'')');
  dayKc.Close;
  dayKc.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  dayKc.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  dayKc.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Factor.Open(dayKc);

  //�������
  QtDay:=FormatDatetime('YYYYMMDD',Date()-2); //ǰ��;
  YsDay:=FormatDatetime('YYYYMMDD',Date()-1); //����;
  ToDay:=FormatDatetime('YYYYMMDD',Date());   //����;
  //�����������
  str:=
    'select a.SALES_DATE as SALES_DATE,count(distinct a.GODS_ID) as SALES_GODS_COUNT,count(distinct a.SALES_ID) as SALES_BILL_COUNT,sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,sum(NOTAX_MONEY) as NOTAX_MONEY,(sum(NOTAX_MONEY)+sum(TAX_MONEY)) as SALE_MNY,(sum(NOTAX_MONEY)-sum(COST_MONEY)) as SALE_PRF '+
    'from VIW_SALESDATA a,PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 '+
    ' and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and a.SALES_DATE in ('+YsDay+','+ToDay+','+QtDay+') '+
    'group by a.SALES_DATE ';
  dayRs.Close;
  dayRs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  dayRs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  dayRs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Factor.Open(dayRs);
end;

procedure TWelcome.LoadMths;
var
  CalcUnit,str:string;
begin
  CalcUnit:='(case when isnull(SMALLTO_CALC,0)=0 then 1.0 else cast(SMALLTO_CALC*1.00 as decimal(18,3)) end)';
  //�����������
  str:=                                           
    'select round(a.SALES_DATE / 100) as SALES_DATE,'+
    'a.GODS_ID as GODS_ID,count(*) as SAL_OAMT,'+
    'count(distinct a.GODS_ID) as SAL_GAMT,'+
    'sum(CALC_AMOUNT/'+CalcUnit+') as SAL_AMT,'+
    'sum(NOTAX_MONEY) as NOTAX_MONEY,'+
    '(nvl(sum(NOTAX_MONEY),0)+nvl(sum(TAX_MONEY),0)) as SALE_MNY,'+  
    '(nvl(sum(NOTAX_MONEY),0)-nvl(sum(COST_MONEY),0)) as SALE_PRF,'+
    'sum(case when substring(CREA_DATE,12,2)=''00'' then CALC_AMOUNT else 0 end) as T00_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''01'' then CALC_AMOUNT else 0 end) as T01_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''02'' then CALC_AMOUNT else 0 end) as T02_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''03'' then CALC_AMOUNT else 0 end) as T03_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''04'' then CALC_AMOUNT else 0 end) as T04_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''05'' then CALC_AMOUNT else 0 end) as T05_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''06'' then CALC_AMOUNT else 0 end) as T06_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''07'' then CALC_AMOUNT else 0 end) as T07_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''08'' then CALC_AMOUNT else 0 end) as T08_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''09'' then CALC_AMOUNT else 0 end) as T09_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''10'' then CALC_AMOUNT else 0 end) as T10_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''11'' then CALC_AMOUNT else 0 end) as T11_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''12'' then CALC_AMOUNT else 0 end) as T12_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''13'' then CALC_AMOUNT else 0 end) as T13_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''14'' then CALC_AMOUNT else 0 end) as T14_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''15'' then CALC_AMOUNT else 0 end) as T15_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''16'' then CALC_AMOUNT else 0 end) as T16_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''17'' then CALC_AMOUNT else 0 end) as T17_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''18'' then CALC_AMOUNT else 0 end) as T18_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''19'' then CALC_AMOUNT else 0 end) as T19_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''20'' then CALC_AMOUNT else 0 end) as T20_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''21'' then CALC_AMOUNT else 0 end) as T21_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''22'' then CALC_AMOUNT else 0 end) as T22_AMT,'+
    'sum(case when substring(CREA_DATE,12,2)=''23'' then CALC_AMOUNT else 0 end) as T23_AMT,'+
    'sum(case when a.CLIENT_ID is not null then 1 else 0 end) as CUST_FLAG '+ //�Ƿ��ǻ�ԱFlag
    'from VIW_SALESDATA a,PUB_GOODSINFO b '+
    ' where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001 '+
    ' and a.TENANT_ID=:TENANT_ID and a.SHOP_ID=:SHOP_ID and ((a.SALES_DATE>=:LM_BEGIN_DATE and a.SALES_DATE<=:LM_END_DATE)'+
    ' or (a.SALES_DATE>=:TM_BEGIN_DATE and a.SALES_DATE<=:TM_END_DATE)) '+
    'group by round(a.SALES_DATE / 100),a.GODS_ID';
  MthRs.Close;
  MthRs.SQL.Text:=ParseSQL(Factor.iDbType, Str);
  MthRs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  MthRs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  MthRs.ParamByName('LM_BEGIN_DATE').AsInteger := StrtoInt(FLMonth+'01'); //���µ�һ��
  MthRs.ParamByName('LM_END_DATE').AsInteger :=   StrtoInt(FLMonth+FDay1); //���½���
  MthRs.ParamByName('TM_BEGIN_DATE').AsInteger := StrtoInt(FMonth+'01');  //���µ�һ��
  MthRs.ParamByName('TM_END_DATE').AsInteger :=   StrtoInt(FMonth+FDay2);  //���½���
  Factor.Open(MthRs);

  //ȡ��Ա���:
  CustRs.Close;
  CustRs.SQL.Text:=
    'select count(CUST_ID) as allCount,sum(case when SND_DATE>='''+Copy(FMonth,1,4)+'-'+Copy(FMonth,5,2)+'-01'' and SND_DATE<='''+Copy(FMonth,1,4)+'-'+Copy(FMonth,5,2)+'-'+FDay+''' then 1 else 0 end) as newCount from PUB_CUSTOMER '+
    ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID ';
  CustRs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  CustRs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
  Factor.Open(CustRs);

end;

procedure TWelcome.SetMonth(const Value: string);
var
  CurDate: TDate;
begin
  FMonth := Value;
  //���ݱ��·ݼ����ϸ��·�
  CurDate := FnTime.fnStrtoDate(FMonth+'01');
  FLMonth := FormatDatetime('YYYYMM',incMonth(CurDate,-1));
  if formatdatetime('YYYYMM',date())=Value then //����
     begin
       FDay2:=Copy(FormatDatetime('YYYYMMDD',Date()),7,2);
       if formatDatetime('DD',Date())= formatdatetime('DD',incMonth(CurDate,1)-1) then
          FDay1:= FormatDatetime('DD',incMonth(CurDate)-1);
       else
          FDay1:= Copy(FormatDatetime('YYYYMMDD',Date()),7,2);
     end;
end;



function TWelcome.GetTMCust_MAX_TIME: string;
var
  s1,s2,s3,s4:real;
  t1,t2,t3,t4:integer;
  i:integer;
  list:TStringList;
  b:integer;
  IsFlag: Boolean; //���λ
begin
  s1 := 0;
  s2 := 0;
  s3 := 0;
  s4 := 0;
  for i:=0 to 23 do
     begin
       if (FHotSale[i]>s1) and (FHotSale[i]>0) then
          begin
            s1 := FHotSale[i];
            t1 := i;
          end;
     end;
  for i:=0 to 23 do
     begin
       if (FHotSale[i]>s2) and (FHotSale[i]>0) and (FHotSale[i]<s1) then
          begin
            s2 := FHotSale[i];
            t2 := i;
          end;
     end;
  for i:=0 to 23 do
     begin
       if (FHotSale[i]>s3) and (FHotSale[i]>0) and (FHotSale[i]<s2) then
          begin
            s3 := FHotSale[i];
            t3 := i;
          end;
     end;
  for i:=0 to 23 do
     begin
       if (FHotSale[i]>s4) and (FHotSale[i]>0) and (FHotSale[i]<s3) then
          begin
            s4 := FHotSale[i];
            t4 := i;
          end;
     end;
     
  //��ʼ������ʱ����
  list:=TStringList.Create;
  try
    if s1>0 then list.Add(formatFloat('00',t1));
    if s2>0 then list.Add(formatFloat('00',t2));
    if s3>0 then list.Add(formatFloat('00',t3));
    if s4>0 then list.Add(formatFloat('00',t4));
    list.Sort;
    result := '';
    b := -1;
    IsFlag:=False;
    for i:=0 to list.Count -1 do
    begin
      if b=-1 then
      begin
        if result <> '' then result := result + '��';
        result := result + list[i]+'ʱ';
        b:= strtoint(list[i]);  //xhh add
      end else
      begin
        if (strtoint(list[i])=b+1) and (i<list.Count) then
        begin
          b := strtoint(list[i]);
          IsFlag:=True;
          continue;
        end;
        if b<>strtoint(list[i]) then
        begin
          if IsFlag then
          begin
            result := result + '��'+ list[i-1]+'ʱ��'+list[i]+'ʱ';
            IsFlag:=False;
          end else
          begin
            if result <> '' then result := result + '��';
            result := result + list[i]+'ʱ';
          end;
          b:= strtoint(list[i]);
        end;
      end;
    end;
    if IsFlag then result := result + '��'+ list.Strings[List.Count-1]+'ʱ';
  finally
    list.Free;
  end;
end;

end.
