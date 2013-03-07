unit ObjGoodsInfoV60;

interface

uses
  SysUtils, zBase, Classes, ZIntf, ObjCommon, ZDataset, DB;

type

  TGoodsInfoV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TBarCodeV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TGoodsRelationV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TGoodsInfoExtV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

  TGoodsPriceV60=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

implementation

function TGoodsInfoV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsInfoV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsInfoV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TGoodsInfoV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select GODS_ID,TENANT_ID,GODS_CODE,GODS_NAME,GODS_SPELL,GODS_TYPE,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,'+
    '       SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,'+
    '       SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,BARCODE,UNIT_ID,CALC_UNITS,SMALL_UNITS,'+
    '       BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE,USING_PRICE,HAS_INTEGRAL,'+
    '       USING_BATCH_NO,USING_BARTER,USING_LOCUS_NO,BARTER_INTEGRAL,REMARK,SHORT_GODS_NAME,COMM,TIME_STAMP '+
    'from   PUB_GOODSINFO '+
    'where  TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID';

  InsertSQL.Text :=
    'insert into PUB_GOODSINFO '+
    '( '+
    'GODS_ID,TENANT_ID,GODS_CODE,GODS_NAME,GODS_SPELL,GODS_TYPE,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,'+
    'SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,'+
    'SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,BARCODE,UNIT_ID,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,'+
    'BIGTO_CALC,NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE,USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_BARTER,'+
    'USING_LOCUS_NO,BARTER_INTEGRAL,REMARK,SHORT_GODS_NAME,COMM,TIME_STAMP '+
    ') '+
    'values '+
    '( '+
    ':GODS_ID,:TENANT_ID,:GODS_CODE,:GODS_NAME,:GODS_SPELL,:GODS_TYPE,:SORT_ID1,:SORT_ID2,:SORT_ID3,:SORT_ID4,'+
    ':SORT_ID5,:SORT_ID6,:SORT_ID7,:SORT_ID8,:SORT_ID9,:SORT_ID10,:SORT_ID11,:SORT_ID12,:SORT_ID13,:SORT_ID14,'+
    ':SORT_ID15,:SORT_ID16,:SORT_ID17,:SORT_ID18,:SORT_ID19,:SORT_ID20,:BARCODE,:UNIT_ID,:CALC_UNITS,:SMALL_UNITS,'+
    ':BIG_UNITS,:SMALLTO_CALC,:BIGTO_CALC,:NEW_INPRICE,:NEW_OUTPRICE,:NEW_LOWPRICE,:USING_PRICE,:HAS_INTEGRAL,'+
    ':USING_BATCH_NO,:USING_BARTER,:USING_LOCUS_NO,:BARTER_INTEGRAL,:REMARK,:SHORT_GODS_NAME,''00'','+GetTimeStamp(iDbType)+' '+
    ') ';

  UpdateSQL.Text :=
    'update 	PUB_GOODSINFO '+
    'set			GODS_CODE=:GODS_CODE,GODS_NAME=:GODS_NAME,GODS_SPELL=:GODS_SPELL,GODS_TYPE=:GODS_TYPE,SORT_ID1=:SORT_ID1,'+
    '         SORT_ID2=:SORT_ID2,SORT_ID3=:SORT_ID3,SORT_ID4=:SORT_ID4,SORT_ID5=:SORT_ID5,SORT_ID6=:SORT_ID6,'+
    '         SORT_ID7=:SORT_ID7,SORT_ID8=:SORT_ID8,SORT_ID9=:SORT_ID9,SORT_ID10=:SORT_ID10,SORT_ID11=:SORT_ID11,'+
    '         SORT_ID12=:SORT_ID12,SORT_ID13=:SORT_ID13,SORT_ID14=:SORT_ID14,SORT_ID15=:SORT_ID15,SORT_ID16=:SORT_ID16,'+
    '         SORT_ID17=:SORT_ID17,SORT_ID18=:SORT_ID18,SORT_ID19=:SORT_ID19,SORT_ID20=:SORT_ID20,BARCODE=:BARCODE,'+
    '         UNIT_ID=:UNIT_ID,CALC_UNITS=:CALC_UNITS,SMALL_UNITS=:SMALL_UNITS,BIG_UNITS=:BIG_UNITS,SMALLTO_CALC=:SMALLTO_CALC,'+
    '         BIGTO_CALC=:BIGTO_CALC,NEW_INPRICE=:NEW_INPRICE,NEW_OUTPRICE=:NEW_OUTPRICE,NEW_LOWPRICE=:NEW_LOWPRICE,'+
    '         USING_PRICE=:USING_PRICE,HAS_INTEGRAL=:HAS_INTEGRAL,USING_BATCH_NO=:USING_BATCH_NO,USING_BARTER=:USING_BARTER,'+
    '         USING_LOCUS_NO=:USING_LOCUS_NO,BARTER_INTEGRAL=:BARTER_INTEGRAL,REMARK=:REMARK,SHORT_GODS_NAME=:SHORT_GODS_NAME,'+
    '         COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where    TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID';

  DeleteSQL.Text :=
    'update 	PUB_GOODSINFO '+
    'set			COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where    TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID';
end;

function TBarCodeV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TBarCodeV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TBarCodeV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TBarCodeV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE,COMM,TIME_STAMP '+
    'from   PUB_BARCODE '+
    'where  TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID';

  InsertSQL.Text :=
    'insert into PUB_BARCODE '+
    '(ROWS_ID,TENANT_ID,GODS_ID,PROPERTY_01,PROPERTY_02,UNIT_ID,BARCODE_TYPE,BATCH_NO,BARCODE,COMM,TIME_STAMP) '+
    'values '+
    '(:ROWS_ID,:TENANT_ID,:GODS_ID,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:BARCODE_TYPE,:BATCH_NO,:BARCODE,''00'','+GetTimeStamp(iDbType)+')';

  UpdateSQL.Text :=
    'update PUB_BARCODE '+
    'set 		PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,UNIT_ID=:UNIT_ID,BARCODE_TYPE=:BARCODE_TYPE, '+
    '				BATCH_NO=:BATCH_NO,BARCODE=:BARCODE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where	TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and BARCODE_TYPE=:OLD_BARCODE_TYPE';

  DeleteSQL.Text :=
    'update PUB_BARCODE '+
    'set 		COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where	TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and BARCODE_TYPE=:OLD_BARCODE_TYPE';
end;

function TGoodsRelationV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsRelationV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsRelationV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TGoodsRelationV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select ROWS_ID,TENANT_ID,RELATION_ID,GODS_ID,SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,'+
    '       SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,'+
    '       SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,'+
    '       SORT_ID18,SORT_ID19,SORT_ID20,NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE,USING_PRICE,'+
    '       HAS_INTEGRAL,USING_BATCH_NO,USING_BARTER,USING_LOCUS_NO,BARTER_INTEGRAL,COMM,'+
    '       TIME_STAMP,COMM_ID,ZOOM_RATE,SHORT_GODS_NAME '+
    'from   PUB_GOODS_RELATION '+
    'where  TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID and GODS_ID=:GODS_ID ';

  InsertSQL.Text :=
    'insert into PUB_GOODS_RELATION '+
    '('+
    'ROWS_ID,TENANT_ID,RELATION_ID,GODS_ID,SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,SORT_ID1,'+
    'SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,SORT_ID11,'+
    'SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,'+
    'NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE,USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_BARTER,'+
    'USING_LOCUS_NO,BARTER_INTEGRAL,COMM,TIME_STAMP,COMM_ID,ZOOM_RATE'+
    ')'+
    'values '+
    '('+
    ':ROWS_ID,:TENANT_ID,:RELATION_ID,:GODS_ID,:SECOND_ID,:GODS_CODE,:GODS_NAME,:GODS_SPELL,'+
    ':SORT_ID1,:SORT_ID2,:SORT_ID3,:SORT_ID4,:SORT_ID5,:SORT_ID6,:SORT_ID7,:SORT_ID8,:SORT_ID9,'+
    ':SORT_ID10,:SORT_ID11,:SORT_ID12,:SORT_ID13,:SORT_ID14,:SORT_ID15,:SORT_ID16,:SORT_ID17,'+
    ':SORT_ID18,:SORT_ID19,:SORT_ID20,:NEW_INPRICE,:NEW_OUTPRICE,:NEW_LOWPRICE,:USING_PRICE,'+
    ':HAS_INTEGRAL,:USING_BATCH_NO,:USING_BARTER,:USING_LOCUS_NO,:BARTER_INTEGRAL,''00'','+
     GetTimeStamp(iDbType)+',:COMM_ID,:ZOOM_RATE'+
    ')';

  UpdateSQL.Text :=
    'update PUB_GOODS_RELATION '+
    'set '+
    ' SECOND_ID=:SECOND_ID,GODS_CODE=:GODS_CODE,GODS_NAME=:GODS_NAME,GODS_SPELL=:GODS_SPELL, '+
    ' SORT_ID1=:SORT_ID1,SORT_ID2=:SORT_ID2,SORT_ID3=:SORT_ID3,SORT_ID4=:SORT_ID4,SORT_ID5=:SORT_ID5, '+
    ' SORT_ID6=:SORT_ID6,SORT_ID7=:SORT_ID7,SORT_ID8=:SORT_ID8,SORT_ID9=:SORT_ID9,SORT_ID10=:SORT_ID10, '+
    ' SORT_ID11=:SORT_ID11,SORT_ID12=:SORT_ID12,SORT_ID13=:SORT_ID13,SORT_ID14=:SORT_ID14, '+
    ' SORT_ID15=:SORT_ID15,SORT_ID16=:SORT_ID16,SORT_ID17=:SORT_ID17,SORT_ID18=:SORT_ID18, '+
    ' SORT_ID19=:SORT_ID19,SORT_ID20=:SORT_ID20,NEW_INPRICE=:NEW_INPRICE,NEW_OUTPRICE=:NEW_OUTPRICE, '+
    ' NEW_LOWPRICE=:NEW_LOWPRICE,USING_PRICE=:USING_PRICE,HAS_INTEGRAL=:HAS_INTEGRAL, '+
    ' USING_BATCH_NO=:USING_BATCH_NO,USING_BARTER=:USING_BARTER,USING_LOCUS_NO=:USING_LOCUS_NO, '+
    ' BARTER_INTEGRAL=:BARTER_INTEGRAL,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+',COMM_ID=:COMM_ID, '+
    ' ZOOM_RATE=:ZOOM_RATE '+
    'where TENANT_ID=:OLD_TENANT_ID and RELATION_ID=:OLD_RELATION_ID and GODS_ID=:OLD_GODS_ID ';


  DeleteSQL.Text :=
    ' update PUB_GOODS_RELATION set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where TENANT_ID=:OLD_TENANT_ID and RELATION_ID=:OLD_RELATION_ID and GODS_ID=:OLD_GODS_ID ';
end;

{ TGoodsInfoExtV60 }

function TGoodsInfoExtV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsInfoExtV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsInfoExtV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TGoodsInfoExtV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select TENANT_ID,GODS_ID,NEW_INPRICE,NEW_INPRICE1,NEW_INPRICE2,LOWER_AMOUNT,UPPER_AMOUNT,LOWER_RATE,UPPER_RATE,COMM,TIME_STAMP '+
    'from   PUB_GOODSINFOEXT '+
    'where  TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID ';

  InsertSQL.Text :=
    'insert into PUB_GOODSINFOEXT '+
    '('+
    'TENANT_ID,GODS_ID,NEW_INPRICE,NEW_INPRICE1,NEW_INPRICE2,LOWER_AMOUNT,UPPER_AMOUNT,LOWER_RATE,UPPER_RATE,COMM,TIME_STAMP'+
    ')'+
    'values '+
    '('+
    ':TENANT_ID,:GODS_ID,:NEW_INPRICE,:NEW_INPRICE1,:NEW_INPRICE2,:LOWER_AMOUNT,:UPPER_AMOUNT,:LOWER_RATE,:UPPER_RATE,''00'','+
     GetTimeStamp(iDbType)+''+
    ')';

  UpdateSQL.Text :=
    'update PUB_GOODSINFOEXT '+
    'set '+
    ' TENANT_ID=:TENANT_ID,GODS_ID=:GODS_ID,NEW_INPRICE=:NEW_INPRICE,NEW_INPRICE1=:NEW_INPRICE1,NEW_INPRICE2=:NEW+INPRICE2,'+
    ' LOWER_AMOUNT=:LOWER_AMOUNT,UPPER_AMOUNT=:UPPER_AMOUNT,LOWER_RATE=:LOWER_RATE,UPPER_RATE=:UPPER_RATE,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID ';


  DeleteSQL.Text :=
    ' update PUB_GOODSINFOEXT set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where  TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID ';
end;

{ TGoodsPriceV60 }

function TGoodsPriceV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsPriceV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsPriceV60.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TGoodsPriceV60.InitClass;
begin
  inherited;
  SelectSQL.Text :=
    'select TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP '+
    'from   PUB_GOODSPRICE '+
    'where  TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID and SHOP_ID=:SHOP_ID ';

  InsertSQL.Text :=
    'insert into PUB_GOODSPRICE '+
    '('+
    'TENANT_ID,PRICE_ID,SHOP_ID,GODS_ID,PRICE_METHOD,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,COMM,TIME_STAMP'+
    ')'+
    'values '+
    '('+
    ':TENANT_ID,:PRICE_ID,:SHOP_ID,:GODS_ID,:PRICE_METHOD,:NEW_OUTPRICE,:NEW_OUTPRICE1,:NEW_OUTPRICE2,''00'','+
     GetTimeStamp(iDbType)+''+
    ')';

  UpdateSQL.Text :=
    'update PUB_GOODSPRICE '+
    'set '+
    ' TENANT_ID=:TENANT_ID,PRICE_ID=:PRICE_ID,SHOP_ID=:SHOP_ID,GODS_ID=:GODS_ID,PRICE_METHOD=:PRICE_METHOD,NEW_OUTPRICE=:NEW_OUTPRICE,NEW_OUTPRICE1=:NEW_OUTPRICE1,NEW_OUTPRICE2=:NEW_OUTPRICE2,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' '+
    'where TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and SHOP_ID=:OLD_SHOP_ID  ';


  DeleteSQL.Text :=
    ' update PUB_GOODSPRICE set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where  TENANT_ID=:OLD_TENANT_ID and GODS_ID=:OLD_GODS_ID and SHOP_ID=:OLD_SHOP_ID  ';

end;

initialization
  RegisterClass(TGoodsInfoV60);
  RegisterClass(TBarCodeV60);
  RegisterClass(TGoodsRelationV60);
  RegisterClass(TGoodsInfoExtV60);
  RegisterClass(TGoodsPriceV60);
finalization
  UnRegisterClass(TGoodsInfoV60);
  UnRegisterClass(TBarCodeV60);
  UnRegisterClass(TGoodsRelationV60);
  UnRegisterClass(TGoodsInfoExtV60);
  UnRegisterClass(TGoodsPriceV60);
end.




