unit ObjGoodsInfo;

interface

uses
  SysUtils, zBase, Classes, AdoDb, ZIntf, ObjCommon, ZDataset,uDsUtil;

type
  {== 商品资料 ==}
  TGoodsInfo=class(TZFactory)
  public
    //判断是否是总店: (TENANT_ID+'0001'判断是否是总店)
    function IsRootShop: Boolean;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {== 条码 ==}
  TPUB_BARCODE=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  {== 商品单价 ==}
  TGoodsPrice=class(TZFactory)
  public
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;  
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
    rs.SQL.Text:='select Count(*) as ReSum from STO_STORAGE where AMOUNT<>0 and GODS_ID=:GODS_ID ';
    rs.Params.ParamByName('GODS_ID').AsString:=trim(FieldByName('GODS_ID').AsOldString); 
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger> 0 then
      Raise Exception.Create('"'+FieldbyName('GODS_NAME').AsOldString+'"库存不为0不能删除.');      ;
  finally
    rs.Free;
  end;

  //软件删除商品资料:
  Str:='Update PUB_GOODSINFO Set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID ';
  AGlobal.ExecSQL(Str,self); 
  //删除商品条码:
  Str:='Update PUB_BARCODE Set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
       ' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and BARCODE_TYPE in (''0'',''1'',''2'') ';
  AGlobal.ExecSQL(Str,self);
  //删除商品价格:(不需过滤门店ID)
  Str:='Update PUB_GOODSPRICE Set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID';
  AGlobal.ExecSQL(Str, self);
end;

function TGoodsInfo.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  r:integer;
begin
  result := true;
  Str:='Insert Into PUB_GOODSINFO(GODS_ID,TENANT_ID,GODS_CODE,GODS_NAME,GODS_SPELL,GODS_TYPE,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,'+
    'SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,BARCODE,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,NEW_INPRICE,NEW_OUTPRICE,'+
    'NEW_LOWPRICE,USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_BARTER,BARTER_INTEGRAL,REMARK,COMM,TIME_STAMP)'+
    ' Values (:GODS_ID,:TENANT_ID,:GODS_CODE,:GODS_NAME,:GODS_SPELL,:GODS_TYPE,:SORT_ID1,:SORT_ID2,:SORT_ID3,:SORT_ID4,'+
    ':SORT_ID5,:SORT_ID6,:SORT_ID7,:SORT_ID8,:BARCODE,:CALC_UNITS,:SMALL_UNITS,:BIG_UNITS,:SMALLTO_CALC,:BIGTO_CALC,:NEW_INPRICE,'+
    ':RTL_OUTPRICE,:NEW_LOWPRICE,:USING_PRICE,:HAS_INTEGRAL,:USING_BATCH_NO,:USING_BARTER,:BARTER_INTEGRAL,:REMARK,''00'','+GetTimeStamp(iDbType)+')';
  AGlobal.ExecSQL(Str, self);

  //插入门店单价
  Str:='insert Into PUB_GOODSPRICE(TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP) '+
                         ' Values (:TENANT_ID,''#'',:SHOP_ID,:GODS_ID,''1'',:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+GetTimeStamp(iDbType)+') ';
  AGlobal.ExecSQL(Str, self);
end;

function TGoodsInfo.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  result:=true;
  Str:=
    'Update PUB_GOODSINFO Set GODS_CODE=:GODS_CODE,GODS_NAME=:GODS_NAME,GODS_SPELL=:GODS_SPELL,GODS_TYPE=:GODS_TYPE,SORT_ID1=:SORT_ID1,'+
    'SORT_ID2=:SORT_ID2,SORT_ID3=:SORT_ID3,SORT_ID4=:SORT_ID4,SORT_ID5=:SORT_ID5,SORT_ID6=:SORT_ID6,SORT_ID7=:SORT_ID7,SORT_ID8=:SORT_ID8,'+
    'BARCODE=:BARCODE,USING_PRICE=:USING_PRICE,HAS_INTEGRAL=:HAS_INTEGRAL,USING_BATCH_NO=:USING_BATCH_NO,USING_BARTER=:USING_BARTER,BARTER_INTEGRAL=:BARTER_INTEGRAL,REMARK=:REMARK,'+
    'CALC_UNITS=:CALC_UNITS,SMALL_UNITS=:SMALL_UNITS,BIG_UNITS=:BIG_UNITS,SMALLTO_CALC=:SMALLTO_CALC,BIGTO_CALC=:BIGTO_CALC,'+
    'NEW_INPRICE=:NEW_INPRICE,NEW_OUTPRICE=:RTL_OUTPRICE,NEW_LOWPRICE=:NEW_LOWPRICE,'+
    'COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' Where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID ';
  AGlobal.ExecSQL(Str,self);

  //修改价格日志：
  if (FieldByName('NEW_OUTPRICE').AsFloat<>FieldByName('NEW_OUTPRICE').AsOldFloat) or
     (FieldByName('NEW_OUTPRICE1').AsFloat<>FieldByName('NEW_OUTPRICE1').AsOldFloat) or
     (FieldByName('NEW_OUTPRICE2').AsFloat<>FieldByName('NEW_OUTPRICE2').AsOldFloat) then
  begin
    Params.ParamByName('PRICING_DATE').AsString:=FormatDatetime('YYYYMMDD',Date()); //日志日期
    Params.ParamByName('TENANT_ID').AsString:=FieldByName('TENANT_ID').AsString;    //企业ID
    Params.ParamByName('SHOP_ID').AsString:=FieldByName('SHOP_ID').AsString;        //门店ID
    Params.ParamByName('GODS_ID').AsString:=FieldByName('GODS_ID').AsString;        //商品ID
    Params.ParamByName('PRICE_METHOD').AsString:='1';     //定价方式
    Params.ParamByName('ORG_OUTPRICE').AsFloat:=FieldByName('NEW_OUTPRICE').AsOldFloat;    //门店(原)计量售价
    Params.ParamByName('ORG_OUTPRICE1').AsFloat:=FieldByName('NEW_OUTPRICE1').AsOldFloat;  //门店(原)小包装售价
    Params.ParamByName('ORG_OUTPRICE2').AsFloat:=FieldByName('NEW_OUTPRICE2').AsOldFloat;  //门店(原)大包装售价
    Params.ParamByName('NEW_OUTPRICE').AsFloat:=FieldByName('NEW_OUTPRICE').AsFloat;       //门店(新)计量售价
    Params.ParamByName('NEW_OUTPRICE1').AsFloat:=FieldByName('NEW_OUTPRICE').AsFloat;      //门店(新)小包装售价
    Params.ParamByName('NEW_OUTPRICE2').AsFloat:=FieldByName('NEW_OUTPRICE').AsFloat;      //门店(新)大包装售价

    Str:='Insert Into LOG_PRICING_INFO (ROWS_ID,PRICING_DATE,PRICING_USER,TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,'+
         ' ORG_OUTPRICE,ORG_OUTPRICE1,ORG_OUTPRICE2,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP)'+
         'Values (:ROWS_ID,:PRICING_DATE,:PRICING_USER,:TENANT_ID,''#'',:SHOP_ID,:GODS_ID,:PRICE_METHOD,'+
         ':ORG_OUTPRICE,:ORG_OUTPRICE1,:ORG_OUTPRICE2,:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+GetTimeStamp(iDbType)+')';
    AGlobal.ExecSQL(Str,Params);
  end;
end;

{------------------------------------------------------------------------------
 说明:
   (1)门店销售价格: 计量单位售价\包装1售价\包装2售价
   (2)没有设置销售价的门店的单价默认从总店设置价格取，若总店的没有设置销售单价
     （则直接读取:标准售价）
   (3)(select * from VIW_GOODSPRICE where POLICY_TYPE=2 and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and GODS_ID=:GODS_ID //本店定价
       union all
       select A.* from VIW_GOODSPRICE A,VIW_GOODSPRICE B     //总店定价
       where B.POLICY_TYPE=1 and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.SHOP_ID=:SHOP_ID and A.SHOP_ID=:SHOP_ID_ROOT and A.TENANT_ID=:TENANT_ID and A.GODS_ID=:GODS_ID )  
   备注: VIW_GOODSPRICE为
 ------------------------------------------------------------------------------}

procedure TGoodsInfo.InitClass;
var
  Str: string;
begin
  inherited;
  case iDbType of
   0,5: //此语句在SQLITE下调试通过，MS SQL Server语法一样
    Str:=
      'select RELATION_ID,J.TENANT_ID as TENANT_ID, '+
      ' J.GODS_ID as GODS_ID,J.SHOP_ID as SHOP_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,'+
      ' case when C.NEW_INPRICE is null then J.NEW_INPRICE else C.NEW_INPRICE end as NEW_INPRICE,'+
      ' case when C.NEW_INPRICE is null then J.NEW_INPRICE*J.SMALLTO_CALC else C.NEW_INPRICE1 end as NEW_INPRICE1,'+
      ' case when C.NEW_INPRICE is null then J.NEW_INPRICE*J.BIGTO_CALC else C.NEW_INPRICE2 end as NEW_INPRICE2,'+
      ' RTL_OUTPRICE, '+  //标准售价
      ' NEW_LOWPRICE, '+  //最低售价
      ' NEW_OUTPRICE, '+
      ' NEW_OUTPRICE1, '+
      ' NEW_OUTPRICE2, '+
      ' NEW_LOWPRICE,'+
      ' SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,GODS_TYPE,'+
      ' USING_BARTER,BARTER_INTEGRAL,USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,REMARK,'+
      ' case when NEW_OUTPRICE<>0 then (case when C.NEW_INPRICE is null then J.NEW_INPRICE else C.NEW_INPRICE end)*100.0/(NEW_OUTPRICE*1.0) else null end as PROFIT_RATE '+
      'from (select * from VIW_GOODSPRICE where POLICY_TYPE=2  and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and GODS_ID=:GODS_ID '+
      ' union all '+
      ' select A.* from VIW_GOODSPRICE A,VIW_GOODSPRICE B '+
      ' where B.POLICY_TYPE=1 and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.SHOP_ID=:SHOP_ID and A.SHOP_ID=:SHOP_ID_ROOT and A.TENANT_ID=:TENANT_ID and A.GODS_ID=:GODS_ID ) J '+
      ' left join PUB_GOODSINFOEXT C on J.GODS_ID=C.GODS_ID and J.TENANT_ID=C.TENANT_ID '+
      ' where J.COMM not in (''02'',''12'') order by J.GODS_CODE ';
   1: Str:='';
   4: Str:='';
  end;
  SelectSQL.Text:=Str;
end;

{ TPUB_BARCODE }

function TPUB_BARCODE.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  Str := 'update PUB_BARCODE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and PROPERTY_01=:OLD_PROPERTY_01 and '+
    ' PROPERTY_02=:OLD_PROPERTY_02 and BARCODE_TYPE=:OLD_BARCODE_TYPE and BATCH_NO=:OLD_BATCH_NO ';
  AGlobal.ExecSQL(Str);
end;

function TPUB_BARCODE.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  Str :='update PUB_BARCODE set BATCH_NO=:BATCH_NO,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,UNIT_ID=:UNIT_ID,BARCODE=:BARCODE,COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and BARCODE_TYPE=:OLD_BARCODE_TYPE and GODS_ID=:OLD_GODS_ID and PROPERTY_01=:OLD_PROPERTY_01 and '+
    ' PROPERTY_02=:OLD_PROPERTY_02 and BATCH_NO=:OLD_BATCH_NO ';

  if AGlobal.ExecSQL(Str, self)=0 then 
  begin
    Str:='Insert Into PUB_BARCODE (ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE,COMM,TIME_STAMP)'+
      ' Values (:ROWS_ID,:TENANT_ID,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:BARCODE_TYPE,:BATCH_NO,:BARCODE,''00'','+GetTimeStamp(iDbType)+')';
    AGlobal.ExecSQL(Str,self);
  end;
end;

function TPUB_BARCODE.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

procedure TPUB_BARCODE.InitClass;
var Str: string;
begin
  inherited;
  //条码不是核心资料，可直接物理删除
  SelectSQL.Text :='select ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE from PUB_BARCODE '+
    ' where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and GODS_ID=:GODS_ID and BATCH_NO=''#'' and PROPERTY_01=''#'' and '+
    ' PROPERTY_02=''#'' order by BARCODE';
end;

{ TGoodsPrice }

function TGoodsPrice.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
var
  Str: string;
begin
  if trim(FieldbyName('Flag').AsString)<>'' then //原有记录执行更新语句
  begin
    Str:='update PUB_GOODSPRICE set TENANT_ID=:TENANT_ID,PRICE_ID=:PRICE_ID,SHOP_ID=:SHOP_ID,GODS_ID=:GODS_ID,PRICE_METHOD=:PRICE_METHOD,'+
      ' NEW_OUTPRICE=:NEW_OUTPRICE,NEW_OUTPRICE1=:NEW_OUTPRICE1,NEW_OUTPRICE2=:NEW_OUTPRICE2,'+
      ' COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
      ' where TENANT_ID=:OLD_TENANT_ID and COMM not in (''02'',''12'') and GODS_ID=:OLD_GODS_ID and '+
      ' SHOP_ID=:OLD_SHOP_ID and PRICE_ID=:OLD_PRICE_ID ';
    AGlobal.ExecSQL(Str,self);
  end else
  begin
    Str:='insert Into PUB_GOODSPRICE(TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP) '+
      ' Values (:TENANT_ID,:PRICE_ID,:SHOP_ID,:GODS_ID,:PRICE_METHOD,:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+GetTimeStamp(iDbType)+') ';
    AGlobal.ExecSQL(Str,self);
  end;
end;

procedure TGoodsPrice.InitClass;
var
  OperChar, Str: string;
begin
  inherited;
  OperChar:=GetStrJoin(iDbType);
  SelectSQL.Text:=
    'select PROFIT_RATE,TENANT_ID,TENANT_ID as Flag,A.PRICE_ID as PRICE_ID,A.PRICE_NAME as PRICE_NAME,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2 '+
    ' from (select PRICE_ID,PRICE_NAME from PUB_PRICEGRADE Where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')) A '+
    ' Left Join '+
    ' (select P.*,'+
    '(case when G.NEW_OUTPRICE>0 then cast(round((P.NEW_OUTPRICE*100)/(G.NEW_OUTPRICE*1.0),0) as integer) else null end) as PROFIT_RATE from PUB_GOODSPRICE P,PUB_GOODSINFO G '+
    ' where P.TENANT_ID=G.TENANT_ID and P.GODS_ID=G.GODS_ID and P.TENANT_ID=:TENANT_ID and P.SHOP_ID=:SHOP_ID and P.PRICE_ID<>''#'' and P.COMM not in (''02'',''12'') and P.GODS_ID=:GODS_ID) B '+
    ' On A.PRICE_ID=B.PRICE_ID '+
    ' order by A.PRICE_ID';
end;


initialization
  RegisterClass(TGoodsInfo);
  RegisterClass(TPUB_BARCODE);
  RegisterClass(TGoodsPrice);
finalization
  UnRegisterClass(TGoodsInfo);
  UnRegisterClass(TPUB_BARCODE);
  UnRegisterClass(TGoodsPrice);
end.




