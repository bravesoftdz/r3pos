unit ObjGoodsRelation;

interface

uses
  SysUtils, zBase, Classes, ZIntf, ObjCommon, ZDataset, DB;

type

  TGoodsRelation=class(TZFactory)
  public
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

implementation

function TGoodsRelation.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsRelation.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TGoodsRelation.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin

end;

procedure TGoodsRelation.InitClass;
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
    'where TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID and GODS_ID=:GODS_ID ';


  DeleteSQL.Text :=
    ' update PUB_GOODS_RELATION set COMM=''02'',TIME_STAMP='+GetTimeStamp(iDbType)+
    ' where  COMM not in (''02'',''12'') and TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID and GODS_ID=:GODS_ID ';
end;

initialization
  RegisterClass(TGoodsRelation);
finalization
  UnRegisterClass(TGoodsRelation);
end.




