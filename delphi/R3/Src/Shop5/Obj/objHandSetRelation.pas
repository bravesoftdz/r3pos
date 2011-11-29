unit objHandSetRelation;

interface

uses SysUtils,ZBase,Classes, ZIntf,ObjCommon,ZDataset;

type
  THandSetRelation = class(TZFactory)
  private
    function GetLocateStr(iDBType: integer; SecID: string): string;
    //记录行集新增检测函数，返回值是True 则可以新增当前记录
    function BeforeInsertRecord(AGlobal: IdbHelp):Boolean;override;
    procedure InitClass;override;
  end;

implementation

{ TTenant }

function THandSetRelation.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  Idx: integer;
  Rs: TZQuery;
  Str,SecID: string;
begin
  Str:=trim(FieldbyName('COMM_ID').AsString);
  Str:=copy(Str,1,length(Str)-2); //去掉前后两个“,”
  try
    Rs:=TZQuery.Create(nil);
    while Length(Str)>0 do
    begin
      Idx:=Pos(',',Str);
      if Idx>0 then
      begin
        SecID:=Copy(Str,1,Idx-1);//复制单号
        delete(Str,1,Idx);       //删除前缀
      end else
      begin
        SecID:=trim(Str);
        Str:='';
      end;
      Rs.Close;
      Rs.SQL.Text:='select GODS_CODE,GODS_NAME from PUB_GOODS_RELATION where TENANT_ID='+FieldbyName('TENANT_ID').AsString+' '+GetLocateStr(AGlobal.iDbType, SecID);
      AGlobal.Open(Rs);
      if Rs.FieldByName('GODS_CODE').AsString<>'' then
        Raise Exception.Create('Rim商品内码（'+SecID+'）已存在（'+Rs.FieldByName('GODS_CODE').AsString+'-'+Rs.FieldByName('GODS_NAME').AsString+'）对应关系中！');
    end;
  finally
    Rs.Free;
  end;
end;

function THandSetRelation.GetLocateStr(iDBType: integer; SecID: string): string;
begin
  case iDBType of
   0: result:=' and CHARINDEX('''+SecID+''',COMM_ID)>0 ';
   1: result:=' and INSTR(COMM_ID,'''+SecID+''',1,1)>0 ';
   4: result:=' and locate('''+SecID+''',COMM_ID)>0 ';
   5: result:='  ';  //SQLITE不支持此函数
  end;
end;

procedure THandSetRelation.InitClass;
var
  Str: String;
begin
  inherited;
  SelectSQL.Text:='select * from PUB_GOODS_RELATION where TENANT_ID=:TENANT_ID and RELATION_ID=:RELATION_ID and GODS_ID=:GODS_ID ';
  Str:='insert into PUB_GOODS_RELATION'+
    '(ROWS_ID,TENANT_ID,RELATION_ID,GODS_ID,SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,'+
    'SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,'+
    'NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE,USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,USING_BARTER,USING_LOCUS_NO,BARTER_INTEGRAL,COMM_ID,COMM,TIME_STAMP,ZOOM_RATE)'+
    'values(:ROWS_ID,:TENANT_ID,:RELATION_ID,:GODS_ID,:SECOND_ID,:GODS_CODE,:GODS_NAME,:GODS_SPELL,:SORT_ID1,:SORT_ID2,:SORT_ID3,:SORT_ID4,:SORT_ID5,:SORT_ID6,'+
    ':SORT_ID7,:SORT_ID8,:SORT_ID9,:SORT_ID10,:SORT_ID11,:SORT_ID12,:SORT_ID13,:SORT_ID14,:SORT_ID15,:SORT_ID16,:SORT_ID17,:SORT_ID18,:SORT_ID19,:SORT_ID20,'+
    ':NEW_INPRICE,:NEW_OUTPRICE,:NEW_LOWPRICE,:USING_PRICE,:HAS_INTEGRAL,:USING_BATCH_NO,:USING_BARTER,:USING_LOCUS_NO,:BARTER_INTEGRAL,:COMM_ID,''00'','+GetTimeStamp(iDbType)+',:ZOOM_RATE)';
  InsertSQL.Add(Str);
  str:='update PUB_GOODS_RELATION set '+
       ' TENANT_ID=:TENANT_ID,'+
       ' RELATION_ID=:RELATION_ID,'+
       ' GODS_ID=:GODS_ID,'+
       ' SECOND_ID=:SECOND_ID,'+
       ' GODS_CODE=:GODS_CODE,'+
       ' GODS_NAME=:GODS_NAME,'+
       ' GODS_SPELL=:GODS_SPELL,'+
       ' SORT_ID1=:SORT_ID1,'+
       ' SORT_ID2=:SORT_ID2,'+
       ' SORT_ID3=:SORT_ID3,'+
       ' SORT_ID4=:SORT_ID4,'+
       ' SORT_ID5=:SORT_ID5,'+
       ' SORT_ID6=:SORT_ID6,'+
       ' SORT_ID7=:SORT_ID7,'+
       ' SORT_ID8=:SORT_ID8,'+
       ' SORT_ID9=:SORT_ID9,'+
       ' SORT_ID10=:SORT_ID10,'+
       ' SORT_ID11=:SORT_ID11,'+
       ' SORT_ID12=:SORT_ID12,'+
       ' SORT_ID13=:SORT_ID13,'+
       ' SORT_ID14=:SORT_ID14,'+
       ' SORT_ID15=:SORT_ID15,'+
       ' SORT_ID16=:SORT_ID16,'+
       ' SORT_ID17=:SORT_ID17,'+
       ' SORT_ID18=:SORT_ID18,'+
       ' SORT_ID19=:SORT_ID19,'+
       ' SORT_ID20=:SORT_ID20,'+
       ' NEW_INPRICE=:NEW_INPRICE,'+
       ' NEW_OUTPRICE=:NEW_OUTPRICE,'+
       ' NEW_LOWPRICE=:NEW_LOWPRICE,'+
       ' USING_PRICE=:USING_PRICE,'+
       ' HAS_INTEGRAL=:HAS_INTEGRAL,'+
       ' USING_BATCH_NO=:USING_BATCH_NO,'+
       ' USING_BARTER=:USING_BARTER,'+
       ' USING_LOCUS_NO=:USING_LOCUS_NO,'+
       ' BARTER_INTEGRAL=:BARTER_INTEGRAL,'+
       ' COMM_ID=:COMM_ID,'+
       ' COMM='+GetCommStr(iDbType)+','+
       ' TIME_STAMP='+GetTimeStamp(iDbType)+','+
       ' ZOOM_RATE=:ZOOM_RATE '+
       ' where ROWS_ID=:OLD_ROWS_ID and TENANT_ID=:OLD_TENANT_ID and RELATION_ID=:OLD_RELATION_ID and GODS_ID=:OLD_GODS_ID ';
  UpdateSQL.Add(Str);
end;


initialization
  RegisterClass(THandSetRelation);

finalization
  UnRegisterClass(THandSetRelation);

end.
