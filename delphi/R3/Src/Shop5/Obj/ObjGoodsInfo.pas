unit ObjGoodsInfo;

interface

uses
  SysUtils, zBase, Classes, ZIntf, ObjCommon, ZDataset, DB;

type
  {== ��Ʒ���� ==}
  TGoodsInfo=class(TZFactory)
  public
    //�ж��Ƿ����ܵ�: (TENANT_ID+'0001'�ж��Ƿ����ܵ�)
    function IsRootShop: Boolean;
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯TZFactory��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {== ���� ==}
  TPUB_BARCODE=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {== �������� ==}
  TEXT_BARCODE=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  {==��װ�汾��������ʹ��(��ӡ���û������)==}
  TEXT_BARCODEForStock=class(TZFactory)
  public
    //��¼�м�������⺯��������ֵ��True �����������ǰ��¼
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  {== ��Ʒ���� ==}
  TGoodsPrice=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м��޸ļ�⺯��������ֵ��True ������޸ĵ�ǰ��¼
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //��¼�м�ɾ����⺯��������ֵ��True �����ɾ����ǰ��¼
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;


implementation
 { TGoodsInfo }

function TGoodsInfo.IsRootShop: Boolean;
var CurShop_ID: string;
begin
  result:=False;
  CurShop_ID:=trim(FieldbyName('SHOP_ID').AsString);
  CurShop_ID:=Copy(CurShop_ID,length(CurShop_ID)-3,4);
  result:=(CurShop_ID='0001');
end;

function TGoodsInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  rs: TZQuery;
begin
  result := true;
  try
    rs:=TZQuery.Create(nil);
    rs.SQL.Text:='select Count(*) as ReSum from STO_STORAGE where TENANT_ID=:TENANT_ID and round(AMOUNT,3)<>0 and GODS_ID=:GODS_ID ';
    rs.Params.ParamByName('TENANT_ID').AsInteger:=FieldByName('TENANT_ID').AsInteger;
    rs.Params.ParamByName('GODS_ID').AsString:=trim(FieldByName('GODS_ID').AsOldString);
    AGlobal.Open(rs);
    if rs.Fields[0].asInteger> 0 then
       Raise Exception.Create('"'+FieldbyName('GODS_NAME').AsOldString+'"��治Ϊ0����ɾ��.');      ;
  finally
    rs.Free;
  end;

  //���ɾ����Ʒ����:
  Str:='Update PUB_GOODSINFO Set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID ';
  AGlobal.ExecSQL(Str,self); 
  //ɾ����Ʒ����:
  Str:='Update PUB_BARCODE Set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
       ' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and BARCODE_TYPE in (''0'',''1'',''2'') ';
  AGlobal.ExecSQL(Str,self);
  //ɾ����Ʒ�۸�:(��������ŵ�ID)
  Str:='Update PUB_GOODSPRICE Set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID';
  AGlobal.ExecSQL(Str, self);
  //ɾ����Ʒ�۸�:(��������ŵ�ID)
  Str:='Update PUB_GOODSINFOEXT Set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID';
  AGlobal.ExecSQL(Str, self);  
end;

function TGoodsInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  i,r:integer;
  s,Str:string;
  vType: TFieldType;
  vParam: TftParamList;
begin
  result := true;
  Str:='Insert Into PUB_GOODSINFO(GODS_ID,TENANT_ID,GODS_CODE,GODS_NAME,SHORT_GODS_NAME,GODS_SPELL,GODS_TYPE,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,'+
    'SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,'+
    'SORT_ID18,SORT_ID19,SORT_ID20,BARCODE,CALC_UNITS,UNIT_ID,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,NEW_INPRICE,NEW_OUTPRICE,'+
    'NEW_LOWPRICE,USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_LOCUS_NO,USING_BARTER,BARTER_INTEGRAL,REMARK,COMM,TIME_STAMP)'+
    ' Values (:GODS_ID,:TENANT_ID,:GODS_CODE,:GODS_NAME,:SHORT_GODS_NAME,:GODS_SPELL,:GODS_TYPE,:SORT_ID1,:SORT_ID2,:SORT_ID3,:SORT_ID4,'+
    ':SORT_ID5,:SORT_ID6,:SORT_ID7,:SORT_ID8,:SORT_ID9,:SORT_ID10,:SORT_ID11,:SORT_ID12,:SORT_ID13,:SORT_ID14,:SORT_ID15,:SORT_ID16,:SORT_ID17,'+
    ':SORT_ID18,:SORT_ID19,:SORT_ID20,:BARCODE,:CALC_UNITS,:UNIT_ID,:SMALL_UNITS,:BIG_UNITS,:SMALLTO_CALC,:BIGTO_CALC,:NEW_INPRICE,'+
    ':RTL_OUTPRICE,:NEW_LOWPRICE,:USING_PRICE,:HAS_INTEGRAL,:USING_BATCH_NO,:USING_LOCUS_NO,:USING_BARTER,:BARTER_INTEGRAL,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  AGlobal.ExecSQL(Str, self);

  //�����ŵ굥��
  Str:='insert Into PUB_GOODSPRICE(TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP) '+
                         ' Values (:TENANT_ID,''#'',:SHOP_ID,:GODS_ID,''1'',:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+GetTimeStamp(iDbType)+') ';
  AGlobal.ExecSQL(Str, self);

  //�����������չ��:
  try
    vParam :=TftParamList.Create(nil);
    vParam.ParamByName('TENANT_ID').AsString:=FieldbyName('TENANT_ID').AsString;
    vParam.ParamByName('GODS_ID').AsString:=FieldbyName('GODS_ID').AsString;
    vParam.ParamByName('NEW_INPRICE').AsFloat:=FieldbyName('NEW_INPRICE').AsFloat;
    vParam.ParamByName('NEW_INPRICE1').AsFloat:=FieldbyName('NEW_INPRICE').AsFloat * FieldbyName('SMALLTO_CALC').AsFloat;
    vParam.ParamByName('NEW_INPRICE2').AsFloat:=FieldbyName('NEW_INPRICE').AsFloat * FieldbyName('BIGTO_CALC').AsFloat;     
    Str:='insert Into PUB_GOODSINFOEXT(TENANT_ID,GODS_ID,NEW_INPRICE,NEW_INPRICE1,NEW_INPRICE2,LOWER_AMOUNT,UPPER_AMOUNT,LOWER_RATE,UPPER_RATE,COMM,TIME_STAMP) '+
                             ' Values (:TENANT_ID,:GODS_ID,:NEW_INPRICE,:NEW_INPRICE1,:NEW_INPRICE2,0,0,0,0,''00'','+GetTimeStamp(iDbType)+') ';
    AGlobal.ExecSQL(Str, vParam);
  finally
    vParam.Free;    
  end;
end;

function TGoodsInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
  vParam : TftParamList; 
begin
  result:=true;
  if trim(FieldByName('RELATION_ID').AsString)='0' then //��������������Ʒ��ͼ�
  begin
    Str:=
      'Update PUB_GOODSINFO '+
      ' Set GODS_CODE=:GODS_CODE,GODS_NAME=:GODS_NAME,SHORT_GODS_NAME=:SHORT_GODS_NAME,GODS_SPELL=:GODS_SPELL,GODS_TYPE=:GODS_TYPE,SORT_ID1=:SORT_ID1,'+
      ' SORT_ID2=:SORT_ID2,SORT_ID3=:SORT_ID3,SORT_ID4=:SORT_ID4,SORT_ID5=:SORT_ID5,SORT_ID6=:SORT_ID6,SORT_ID7=:SORT_ID7,SORT_ID8=:SORT_ID8,'+
      ' SORT_ID9=:SORT_ID9,SORT_ID10=:SORT_ID10,SORT_ID11=:SORT_ID11,SORT_ID12=:SORT_ID12,SORT_ID13=:SORT_ID13,SORT_ID14=:SORT_ID14,'+
      ' SORT_ID15=:SORT_ID15,SORT_ID16=:SORT_ID16,SORT_ID17=:SORT_ID17,SORT_ID18=:SORT_ID18,SORT_ID19=:SORT_ID19,SORT_ID20=:SORT_ID20,'+
      ' BARCODE=:BARCODE,USING_PRICE=:USING_PRICE,HAS_INTEGRAL=:HAS_INTEGRAL,USING_BATCH_NO=:USING_BATCH_NO,USING_BARTER=:USING_BARTER,'+
      ' BARTER_INTEGRAL=:BARTER_INTEGRAL,REMARK=:REMARK,USING_LOCUS_NO=:USING_LOCUS_NO,'+
      ' CALC_UNITS=:CALC_UNITS,UNIT_ID=:UNIT_ID,SMALL_UNITS=:SMALL_UNITS,BIG_UNITS=:BIG_UNITS,SMALLTO_CALC=:SMALLTO_CALC,BIGTO_CALC=:BIGTO_CALC,'+
      ' NEW_INPRICE=:NEW_INPRICE,NEW_OUTPRICE=:RTL_OUTPRICE,NEW_LOWPRICE=:NEW_LOWPRICE,'+
      ' COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
      ' Where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID ';
    AGlobal.ExecSQL(Str,self);
  end else  //2011.12.06���˾�Ӫ����¼��˶��ձ�: PUB_GOODS_RELATION
  begin
    //���±��궨��:
    Str:='update PUB_GOODS_RELATION set NEW_LOWPRICE=:NEW_LOWPRICE,COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' Where TENANT_ID=:OLD_TENANT_ID and RELATION_ID=:OLD_RELATION_ID and GODS_ID=:OLD_GODS_ID ';
    AGlobal.ExecSQL(Str,self);
  end;


  //�������½����б仯ʱ�����µ���Ʒ��չ��
  if FieldbyName('NEW_INPRICE').AsFloat<>FieldbyName('NEW_INPRICE').AsOldFloat then
  begin
    //�����������չ��:
    try
      vParam :=TftParamList.Create(nil);
      vParam.ParamByName('TENANT_ID').AsString:=FieldbyName('TENANT_ID').AsOldString;
      vParam.ParamByName('GODS_ID').AsString:=FieldbyName('GODS_ID').AsOldString;
      vParam.ParamByName('NEW_INPRICE').AsFloat:=FieldbyName('NEW_INPRICE').AsFloat;
      vParam.ParamByName('NEW_INPRICE1').AsFloat:=FieldbyName('NEW_INPRICE').AsFloat * FieldbyName('SMALLTO_CALC').AsFloat;
      vParam.ParamByName('NEW_INPRICE2').AsFloat:=FieldbyName('NEW_INPRICE').AsFloat * FieldbyName('BIGTO_CALC').AsFloat;     
      Str:='update PUB_GOODSINFOEXT set NEW_INPRICE=:NEW_INPRICE,NEW_INPRICE1=:NEW_INPRICE1,NEW_INPRICE2=:NEW_INPRICE2,COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
           ' Where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID ';
      if AGlobal.ExecSQL(Str, vParam)=0 then
      begin
        Str:='insert Into PUB_GOODSINFOEXT(TENANT_ID,GODS_ID,NEW_INPRICE,NEW_INPRICE1,NEW_INPRICE2,LOWER_AMOUNT,UPPER_AMOUNT,LOWER_RATE,UPPER_RATE,COMM,TIME_STAMP) '+
                                 ' Values (:TENANT_ID,:GODS_ID,:NEW_INPRICE,:NEW_INPRICE1,:NEW_INPRICE2,0,0,0,0,''00'','+GetTimeStamp(iDbType)+') ';
        AGlobal.ExecSQL(Str, vParam);
      end;
    finally
      vParam.Free;
    end;
  end;

  //�޸ļ۸���־��
  if (FieldByName('NEW_OUTPRICE').AsFloat<>FieldByName('NEW_OUTPRICE').AsOldFloat) or
     (FieldByName('NEW_OUTPRICE1').AsFloat<>FieldByName('NEW_OUTPRICE1').AsOldFloat) or
     (FieldByName('NEW_OUTPRICE2').AsFloat<>FieldByName('NEW_OUTPRICE2').AsOldFloat) then
  begin
    //���±��궨��:
    Str:='update PUB_GOODSPRICE set NEW_OUTPRICE=:NEW_OUTPRICE,NEW_OUTPRICE1=:NEW_OUTPRICE1,NEW_OUTPRICE2=:NEW_OUTPRICE2,'+
         ' COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
         ' Where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and SHOP_ID=:OLD_SHOP_ID and PRICE_ID=''#'' ';
    if AGlobal.ExecSQL(Str,self)=0 then //�Ǵ�������Ʒ���ŵ�[���²�����Ʒ�����������¼�¼]
    begin
      Str:='insert Into PUB_GOODSPRICE(TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP) '+
                             ' Values (:TENANT_ID,''#'',:SHOP_ID,:GODS_ID,''1'',:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+GetTimeStamp(iDbType)+') ';
      AGlobal.ExecSQL(Str, self);
    end;
    //�޸ļ۸���־:
    Params.ParamByName('ROWS_ID').AsString:=NewId(''); //��־����
    Params.ParamByName('PRICING_DATE').AsString:=FormatDatetime('YYYYMMDD',Date()); //��־����
    Params.ParamByName('TENANT_ID').AsString:=FieldByName('TENANT_ID').AsString;    //��ҵID
    Params.ParamByName('SHOP_ID').AsString:=FieldByName('SHOP_ID').AsString;        //�ŵ�ID
    Params.ParamByName('GODS_ID').AsString:=FieldByName('GODS_ID').AsString;        //��ƷID
    Params.ParamByName('PRICE_METHOD').AsString:='1';     //���۷�ʽ
    Params.ParamByName('ORG_OUTPRICE').AsFloat:=FieldByName('NEW_OUTPRICE').AsOldFloat;    //�ŵ�(ԭ)�����ۼ�
    Params.ParamByName('ORG_OUTPRICE1').AsFloat:=FieldByName('NEW_OUTPRICE1').AsOldFloat;  //�ŵ�(ԭ)С��װ�ۼ�
    Params.ParamByName('ORG_OUTPRICE2').AsFloat:=FieldByName('NEW_OUTPRICE2').AsOldFloat;  //�ŵ�(ԭ)���װ�ۼ�
    Params.ParamByName('NEW_OUTPRICE').AsFloat:=FieldByName('NEW_OUTPRICE').AsFloat;       //�ŵ�(��)�����ۼ�
    Params.ParamByName('NEW_OUTPRICE1').AsFloat:=FieldByName('NEW_OUTPRICE1').AsFloat;      //�ŵ�(��)С��װ�ۼ�
    Params.ParamByName('NEW_OUTPRICE2').AsFloat:=FieldByName('NEW_OUTPRICE2').AsFloat;      //�ŵ�(��)���װ�ۼ�

    Str:='Insert Into LOG_PRICING_INFO (ROWS_ID,PRICING_DATE,PRICING_USER,TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,'+
         ' ORG_OUTPRICE,ORG_OUTPRICE1,ORG_OUTPRICE2,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP)'+
         'Values (:ROWS_ID,:PRICING_DATE,:PRICING_USER,:TENANT_ID,''#'',:SHOP_ID,:GODS_ID,:PRICE_METHOD,'+
         ':ORG_OUTPRICE,:ORG_OUTPRICE1,:ORG_OUTPRICE2,:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+GetTimeStamp(iDbType)+')';
    AGlobal.ExecSQL(Str,Params);
  end;
end;

{------------------------------------------------------------------------------
 ˵��:
   (1)�ŵ����ۼ۸�: ������λ�ۼ�\��װ1�ۼ�\��װ2�ۼ�
   (2)û���������ۼ۵��ŵ�ĵ���Ĭ�ϴ��ܵ����ü۸�ȡ�����ܵ��û���������۵���
     ����ֱ�Ӷ�ȡ:��׼�ۼۣ�
   (3)(select * from VIW_GOODSPRICE where POLICY_TYPE=2 and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and GODS_ID=:GODS_ID //���궨��
       union all
       select A.* from VIW_GOODSPRICE A,VIW_GOODSPRICE B     //�ܵ궨��
       where B.POLICY_TYPE=1 and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.SHOP_ID=:SHOP_ID and A.SHOP_ID=:SHOP_ID_ROOT and A.TENANT_ID=:TENANT_ID and A.GODS_ID=:GODS_ID )  
   ��ע: VIW_GOODSPRICEΪ
 ------------------------------------------------------------------------------}
  {
   (select * from VIW_GOODSPRICE where POLICY_TYPE=2  and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and GODS_ID=:GODS_ID '+
      ' union all '+
      ' select A.* from VIW_GOODSPRICE A,VIW_GOODSPRICE B '+
      ' where B.POLICY_TYPE=1 and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.SHOP_ID=:SHOP_ID and A.SHOP_ID=:SHOP_ID_ROOT and A.TENANT_ID=:TENANT_ID and A.GODS_ID=:GODS_ID)
  }
  
procedure TGoodsInfo.InitClass;
var
  Str: string;
begin

  inherited;
  {case iDbType of
   0,1,4,5: //�������SQLITE�µ���ͨ����MS SQL Server�﷨һ��
  end;}
  Str:=
    'select RELATION_ID,J.TENANT_ID as TENANT_ID, '+
    ' J.GODS_ID as GODS_ID,J.SHOP_ID as SHOP_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,SHORT_GODS_NAME,UNIT_ID,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE else C.NEW_INPRICE end as NEW_INPRICE,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE*J.SMALLTO_CALC else C.NEW_INPRICE1 end as NEW_INPRICE1,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE*J.BIGTO_CALC else C.NEW_INPRICE2 end as NEW_INPRICE2,'+
    ' RTL_OUTPRICE, '+  //��׼�ۼ�
    ' NEW_LOWPRICE, '+  //����ۼ�
    ' NEW_OUTPRICE, '+
    ' NEW_OUTPRICE1, '+
    ' NEW_OUTPRICE2, '+
    ' SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,'+
    ' SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,GODS_TYPE,'+
    ' USING_BARTER,BARTER_INTEGRAL,USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_LOCUS_NO,REMARK,'+
    ' case when NEW_OUTPRICE<>0 then (case when C.NEW_INPRICE is null then J.NEW_INPRICE else C.NEW_INPRICE end)*100.000/(NEW_OUTPRICE*1.000) else null end as PROFIT_RATE '+
    'from VIW_GOODSPRICE J '+
    ' left join PUB_GOODSINFOEXT C on J.GODS_ID=C.GODS_ID and J.TENANT_ID=C.TENANT_ID '+
    ' where J.COMM not in (''02'',''12'') and J.TENANT_ID=:TENANT_ID and J.SHOP_ID=:SHOP_ID and J.GODS_ID=:GODS_ID order by J.GODS_CODE ';
  SelectSQL.Text:=Str;
end;

{ TPUB_BARCODE }

function TPUB_BARCODE.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  if trim(FieldbyName('RELATION_FLAG').AsString)<>'1' then //ֻ����������Ӫ�����޸ı༭
  begin
    //2012.02.23��ɾ����UNIT_ID��Ϊ32��0;
    Str :=
      'update PUB_BARCODE set UNIT_ID=''00000000000000000000000000000000'',COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
      ' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and PROPERTY_01=:OLD_PROPERTY_01 and '+
      ' PROPERTY_02=:OLD_PROPERTY_02 and BARCODE_TYPE=:OLD_BARCODE_TYPE and BATCH_NO=:OLD_BATCH_NO ';
    AGlobal.ExecSQL(Str,self);
  end;
end;

function TPUB_BARCODE.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  if trim(FieldbyName('RELATION_FLAG').AsString)<>'1' then //ֻ����������Ӫ�����޸ı༭
  begin
    Str :='update PUB_BARCODE set BATCH_NO=:BATCH_NO,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,UNIT_ID=:UNIT_ID,BARCODE=:BARCODE,COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
      ' where TENANT_ID=:TENANT_ID and BARCODE_TYPE=:BARCODE_TYPE and GODS_ID=:GODS_ID and PROPERTY_01=:PROPERTY_01 and '+
      ' PROPERTY_02=:PROPERTY_02 and BATCH_NO=:BATCH_NO ';
    if AGlobal.ExecSQL(Str, self)=0 then
    begin
      Str:='Insert Into PUB_BARCODE (ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE,COMM,TIME_STAMP)'+
           ' Values (:ROWS_ID,:TENANT_ID,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:BARCODE_TYPE,:BATCH_NO,:BARCODE,''00'','+GetTimeStamp(iDbType)+')';
      AGlobal.ExecSQL(Str,self);
    end;
  end;
end;

function TPUB_BARCODE.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if trim(FieldbyName('RELATION_FLAG').AsString)<>'1' then //ֻ����������Ӫ�����޸ı༭
  begin
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  end;
end;

procedure TPUB_BARCODE.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select RELATION_FLAG,ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE from VIW_BARCODE '+
    ' where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and BARCODE_TYPE in (''0'',''1'',''2'',''3'') and GODS_ID=:GODS_ID and BATCH_NO=''#'' and PROPERTY_01=''#'' and PROPERTY_02=''#'' order by BARCODE ';
end;


{ TEXT_BARCODE }


function TEXT_BARCODE.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  if trim(FieldbyName('RELATION_FLAG').AsString)<>'1' then //ֻ����������Ӫ�����޸ı༭
  begin
    Str :='update PUB_BARCODE set BATCH_NO=:BATCH_NO,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BARCODE=:BARCODE,COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
      ' where TENANT_ID=:TENANT_ID and BARCODE_TYPE=:BARCODE_TYPE and UNIT_ID=:UNIT_ID and GODS_ID=:GODS_ID and PROPERTY_01=:PROPERTY_01 and '+
      ' PROPERTY_02=:PROPERTY_02 and BARCODE=:BARCODE ';
    if AGlobal.ExecSQL(Str, self)=0 then
    begin
      Str:='Insert Into PUB_BARCODE (ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE,COMM,TIME_STAMP)'+
           ' Values (:ROWS_ID,:TENANT_ID,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:BARCODE_TYPE,:BATCH_NO,:BARCODE,''00'','+GetTimeStamp(iDbType)+')';
      AGlobal.ExecSQL(Str,self);
    end;
  end;
end;

function TEXT_BARCODE.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  if trim(FieldbyName('RELATION_FLAG').AsString)<>'1' then //ֻ����������Ӫ�����޸ı༭
  begin
    Str := 'update PUB_BARCODE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
      ' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and UNIT_ID=:OLD_UNIT_ID and PROPERTY_01=:OLD_PROPERTY_01 and '+
      ' PROPERTY_02=:OLD_PROPERTY_02 and BARCODE_TYPE=:OLD_BARCODE_TYPE and BARCODE=:OLD_BARCODE ';
    AGlobal.ExecSQL(Str,self);
  end;
end;

function TEXT_BARCODE.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  if trim(FieldbyName('RELATION_FLAG').AsString)<>'1' then //ֻ����������Ӫ�����޸ı༭
  begin
    result := BeforeDeleteRecord(AGlobal);
    result := BeforeInsertRecord(AGlobal);
  end;
end;

procedure TEXT_BARCODE.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select 0 as SEQNO,RELATION_FLAG,ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE from VIW_BARCODE '+
    ' where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and BARCODE_TYPE=''3'' and GODS_ID=:GODS_ID order by BARCODE ';
end;   

{ TGoodsPrice }

function TGoodsPrice.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  str: string;
begin
  result:=false;
  str:='update PUB_GOODSPRICE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
       ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and GODS_ID=:OLD_GODS_ID and PRICE_ID=:OLD_PRICE_ID ';
  result:=AGlobal.ExecSQL(Str,self)>0;
end;

function TGoodsPrice.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  Str:='update PUB_GOODSPRICE set TENANT_ID=:TENANT_ID,PRICE_ID=:PRICE_ID,SHOP_ID=:SHOP_ID,GODS_ID=:GODS_ID,PRICE_METHOD=:PRICE_METHOD,'+
    ' NEW_OUTPRICE=:NEW_OUTPRICE,NEW_OUTPRICE1=:NEW_OUTPRICE1,NEW_OUTPRICE2=:NEW_OUTPRICE2,'+
    ' COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and GODS_ID=:OLD_GODS_ID and PRICE_ID=:OLD_PRICE_ID ';
  if AGlobal.ExecSQL(Str,self)=0 then
  begin
    Str:='insert Into PUB_GOODSPRICE(TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP) '+
      ' Values (:TENANT_ID,:PRICE_ID,:SHOP_ID,:GODS_ID,:PRICE_METHOD,:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+GetTimeStamp(iDbType)+') ';
    AGlobal.ExecSQL(Str,self);
  end;

  if FieldbyName('PRICE_ID').AsString='#' then
  begin
    Params.ParamByName('ROWS_ID').AsString:=NewId('');
    Params.ParamByName('PRICING_DATE').AsString:=FormatDatetime('YYYYMMDD',Date());
    Params.ParamByName('TENANT_ID').AsString:=FieldByName('TENANT_ID').AsString;
    Params.ParamByName('SHOP_ID').AsString:=FieldByName('SHOP_ID').AsString;
    Params.ParamByName('GODS_ID').AsString:=FieldByName('GODS_ID').AsString;
    Params.ParamByName('PRICE_METHOD').AsString:='1';
    Params.ParamByName('ORG_OUTPRICE').AsFloat:=FieldByName('NEW_OUTPRICE').AsOldFloat;
    Params.ParamByName('ORG_OUTPRICE1').AsFloat:=FieldByName('NEW_OUTPRICE1').AsOldFloat;
    Params.ParamByName('ORG_OUTPRICE2').AsFloat:=FieldByName('NEW_OUTPRICE2').AsOldFloat;
    Params.ParamByName('NEW_OUTPRICE').AsFloat:=FieldByName('NEW_OUTPRICE').AsFloat;
    Params.ParamByName('NEW_OUTPRICE1').AsFloat:=FieldByName('NEW_OUTPRICE1').AsFloat;
    Params.ParamByName('NEW_OUTPRICE2').AsFloat:=FieldByName('NEW_OUTPRICE2').AsFloat;

    Str:='Insert Into LOG_PRICING_INFO (ROWS_ID,PRICING_DATE,PRICING_USER,TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,'+
         ' ORG_OUTPRICE,ORG_OUTPRICE1,ORG_OUTPRICE2,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP)'+
         'Values (:ROWS_ID,:PRICING_DATE,:PRICING_USER,:TENANT_ID,''#'',:SHOP_ID,:GODS_ID,:PRICE_METHOD,'+
         ':ORG_OUTPRICE,:ORG_OUTPRICE1,:ORG_OUTPRICE2,:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+GetTimeStamp(iDbType)+')';
    AGlobal.ExecSQL(Str,Params);
  end;
end;

function TGoodsPrice.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

procedure TGoodsPrice.InitClass;
var
  OperChar, Str: string;
begin
  inherited;
  OperChar:=GetStrJoin(iDbType);
  SelectSQL.Text:=
    'select PROFIT_RATE,TENANT_ID,A.PRICE_ID as PRICE_ID,A.PRICE_NAME as PRICE_NAME,SHOP_ID,GODS_ID,PRICE_METHOD,'+
    ' NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2 '+
    ' from (select PRICE_ID,PRICE_NAME from PUB_PRICEGRADE Where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')) A '+
    ' Left Join '+
    ' (select P.*,'+
    '(case when G.NEW_OUTPRICE>0 then cast(round((P.NEW_OUTPRICE*100.000)/(G.NEW_OUTPRICE*1.000),0) as integer) else null end) as PROFIT_RATE from PUB_GOODSPRICE P,VIW_GOODSINFO G '+
    ' where P.TENANT_ID=G.TENANT_ID and P.GODS_ID=G.GODS_ID and P.TENANT_ID=:TENANT_ID and P.SHOP_ID=:SHOP_ID and P.PRICE_ID<>''#'' and P.COMM not in (''02'',''12'') and P.GODS_ID=:GODS_ID) B '+
    ' On A.PRICE_ID=B.PRICE_ID '+
    ' order by A.PRICE_ID';
end;


{ TEXT_BARCODEForStock }

function TEXT_BARCODEForStock.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  Str :=
    'update PUB_BARCODE set BATCH_NO=:BATCH_NO,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,BARCODE=:BARCODE,COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:TENANT_ID and BARCODE_TYPE=:BARCODE_TYPE and UNIT_ID=:UNIT_ID and GODS_ID=:GODS_ID and PROPERTY_01=:PROPERTY_01 and '+
    ' PROPERTY_02=:PROPERTY_02';
  if AGlobal.ExecSQL(Str, self)=0 then
  begin
    Str:='Insert Into PUB_BARCODE (ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE,COMM,TIME_STAMP)'+
         ' Values (:ROWS_ID,:TENANT_ID,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:BARCODE_TYPE,:BATCH_NO,:BARCODE,''00'','+GetTimeStamp(iDbType)+')';
    AGlobal.ExecSQL(Str,self);
  end;
end;

initialization
  RegisterClass(TGoodsInfo);
  RegisterClass(TPUB_BARCODE);
  RegisterClass(TEXT_BARCODE);
  RegisterClass(TGoodsPrice);
  RegisterClass(TEXT_BARCODEForStock);

finalization
  UnRegisterClass(TGoodsInfo);
  UnRegisterClass(TPUB_BARCODE);
  UnRegisterClass(TEXT_BARCODE);
  UnRegisterClass(TGoodsPrice);
  UnRegisterClass(TEXT_BARCODEForStock);
  
end.




