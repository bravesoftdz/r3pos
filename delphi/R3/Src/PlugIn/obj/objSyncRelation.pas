unit objSyncRelation;

interface

uses
  SysUtils,Classes,Dialogs,ZBase,zIntf;

type
  TInf_Goods_Relation=class(TZFactory)
  public
    procedure InitClass; override;
  end;

  TSynchronGood_Relation=class(TZFactory)
  private
    //2011.04.08 Add ���м����µ���ϵ��[INF_GOODS_RELATION]==>[PUB_GOODS_RELATION]
    function DoUpdateRelation_MSSQL(AGlobal:IdbHelp; TENANT_ID: string; UpdateMode: integer): Boolean;
    function DoUpdateRelation_DB2_Oracle(AGlobal:IdbHelp; TENANT_ID: string; UpdateMode: integer): Boolean;
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

implementation

uses ZPlugIn, ObjCommon;

{ TSynchronGood_Relation }


function TSynchronGood_Relation.DoUpdateRelation_MSSQL(AGlobal: IdbHelp; TENANT_ID: string; UpdateMode: integer): Boolean;
var
  InComm,UpComm: string;
  UpSQL, InFields, UpFields: WideString;
begin
  result:=False;
  InComm:=',''00'','+GetTimeStamp(AGlobal.iDbType)+' ';
  UpComm:=',COMM='+ GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' ';
  InFields:=
    'ROWS_ID,TENANT_ID,RELATION_ID,GODS_ID,SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4, SORT_ID5,SORT_ID6,SORT_ID7,'+
    'SORT_ID8,SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,NEW_INPRICE,'+
    'NEW_OUTPRICE,NEW_LOWPRICE ';
  UpFields:=
    ' A.GODS_CODE=B.GODS_CODE'+
    ',A.GODS_CODE=B.GODS_CODE'+
    ',A.GODS_NAME=B.GODS_NAME'+
    ',A.GODS_SPELL=B.GODS_SPELL'+
    ',A.SORT_ID1=B.SORT_ID1'+
    ',A.SORT_ID2=B.SORT_ID2'+
    ',A.SORT_ID3=B.SORT_ID3'+
    ',A.SORT_ID4=B.SORT_ID4'+
    ',A.SORT_ID5=B.SORT_ID5'+
    ',A.SORT_ID6=B.SORT_ID6'+
    ',A.SORT_ID7=B.SORT_ID7'+
    ',A.SORT_ID8=B.SORT_ID8'+
    ',A.SORT_ID9=B.SORT_ID9'+
    ',A.SORT_ID10=B.SORT_ID10'+
    ',A.SORT_ID11=B.SORT_ID11'+
    ',A.SORT_ID12=B.SORT_ID12'+
    ',A.SORT_ID13=B.SORT_ID13'+
    ',A.SORT_ID14=B.SORT_ID14'+
    ',A.SORT_ID15=B.SORT_ID15'+
    ',A.SORT_ID16=B.SORT_ID16'+
    ',A.SORT_ID17=B.SORT_ID17'+
    ',A.SORT_ID18=B.SORT_ID18'+
    ',A.SORT_ID19=B.SORT_ID19'+
    ',A.SORT_ID20=B.SORT_ID20'+
    ',A.NEW_INPRICE=B.NEW_INPRICE'+
    ',A.NEW_OUTPRICE=B.NEW_OUTPRICE';       
  case UpdateMode of
   1: //ˢ������:
    begin
      //�����Ѷ�Ӧ:
      UpSQL:='update A Set '+UpFields+UpComm+' from PUB_GOODS_RELATION A,INF_GOODS_RELATION B '+
             ' where A.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID and UPDATE_FLAG=1 ';
      AGlobal.ExecSQL(UpSQL);
      //���벻���ڣ�
      UpSQL:=
        'insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
        'select '+InFields+InComm+' from INF_GOODS_RELATION A where A.TENANT_ID='''+TENANT_ID+''' and UPDATE_FLAG=2 and '+
        ' not exists(select 1 from PUB_GOODS_RELATION B where B.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID) ';
      AGlobal.ExecSQL(UpSQL);
    end;
   2: //ˢ����Ʒ:
    begin
      //���벻���ڣ�
      UpSQL:='insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
             'select '+InFields+InComm+' from INF_GOODS_RELATION A where A.TENANT_ID='''+TENANT_ID+''' and UPDATE_FLAG=2';
      AGlobal.ExecSQL(UpSQL);
    end;
   3://ˢ�¼۸�
    begin
      //�����ϲ�����Ʒ���λ�޸�Ϊ3;
      UpSQL:='update A set A.UPDATE_FLAG=3 from INF_GOODS_RELATION A,PUB_GOODS_RELATION B '+
             ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.UPDATE_FLAG=1 and A.TENANT_ID='+TENANT_ID+' ';
      AGlobal.ExecSQL(UpSQL);
      
      //�����ֶ�:
      UpSQL:='update A set A.NEW_INPRICE=B.NEW_INPRICE,A.NEW_OUTPRICE=B.NEW_OUTPRICE '+UpComm+' '+
             ' from PUB_GOODS_RELATION A,INF_GOODS_RELATION B '+
             ' where A.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=3 ';
      AGlobal.ExecSQL(UpSQL);
    end;
  end;
  result:=true;
end;

function TSynchronGood_Relation.DoUpdateRelation_DB2_Oracle(AGlobal:IdbHelp; TENANT_ID: string; UpdateMode: integer): Boolean;
var
  Comm,TimeStp: string;
  UpStr, UpSQL, InFields, UpFields: WideString;
begin
  result:=False;
  Comm:=GetCommStr(AGlobal.iDbType);
  TimeStp:=GetTimeStamp(AGlobal.iDbType);
  InFields:=
    'ROWS_ID,TENANT_ID,RELATION_ID,GODS_ID,SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4, SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,'+
    'SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE ';
  UpFields:=
    'SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,'+
    'SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE ';
  case UpdateMode of
   1: //ˢ����������:
    begin
      //���´��ڼ�¼:                                           
      UpSQL:=
        'update PUB_GOODS_RELATION A set ('+UpFields+',COMM,TIME_STAMP)= '+
        ' (select '+UpFields+','+Comm+','+TimeStp+' from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=1 and A.TENANT_ID='+TENANT_ID+')'+
        ' where A.TENANT_ID='+TENANT_ID+' and exists(select 1 from INF_GOODS_RELATION B where A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=1) ';
      AGlobal.ExecSQL(UpSQL);

      //�����¼�¼:
      UpSQL:=
        'insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
        'select '+InFields+',''00'','+TimeStp+' from INF_GOODS_RELATION A where A.TENANT_ID='+TENANT_ID+' and A.UPDATE_FLAG=2 and  '+
        ' not exists(select 1 from PUB_GOODS_RELATION B where B.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID) ';
      AGlobal.ExecSQL(UpSQL);
    end;
   2: //ˢ����Ʒ:
    begin
      //���벻���ڣ�
      UpSQL:='insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
             'select '+InFields+',''00'','+TimeStp+' from INF_GOODS_RELATION A where A.TENANT_ID='+TENANT_ID+' and UPDATE_FLAG=2';
      AGlobal.ExecSQL(UpSQL);
    end;
   3://ˢ�¼۸�: 
    begin
      //�����ϲ�����Ʒ���λ�޸�Ϊ3;
      UpSQL:='update INF_GOODS_RELATION A set UPDATE_FLAG=3 where UPDATE_FLAG=1 and TENANT_ID='+TENANT_ID+' and '+
             ' exists(select GODS_ID from PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID) ';
      AGlobal.ExecSQL(UpSQL);

      //�����ֶ�:
      UpSQL:=
        'update PUB_GOODS_RELATION A '+
        ' set (NEW_INPRICE,NEW_OUTPRICE,COMM,TIME_STAMP)= '+
        ' (select NEW_INPRICE,NEW_OUTPRICE,'+Comm+','+TimeStp+' from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=3 and B.TENANT_ID='+TENANT_ID+') '+
        ' where A.TENANT_ID='+TENANT_ID+' and exists(select 1 from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=3 and B.TENANT_ID='+TENANT_ID+')';

      AGlobal.ExecSQL(UpSQL);
     end;
  end;
  result:=true;
end;

function TSynchronGood_Relation.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  PlugIn: TPlugIn;
  TENANT_ID,Str: string;
  UpdateMode: integer;
  vData: oleVariant;
begin
  result:=False;
  //��Ӧ������ͬ�����ID: 1001
  PlugIn := PlugInList.Find(1001);
  try
    TENANT_ID:=InttoStr(Params.ParamByName('TENANT_ID').AsInteger);
    UpdateMode:=Params.ParamByName('UPDATE_MODE').AsInteger;
    //��һ��: �ӵ�������ͼ �� RSP�м��;
    PlugIn.DLLDoExecute(TENANT_ID, vData);
    //�ڶ���: ��RSP�м�� �� RSP�Ĺ�ϵ��;
    case AGlobal.iDbType of
     0: DoUpdateRelation_MSSQL(AGlobal,TENANT_ID,UpdateMode);
     1,4: DoUpdateRelation_DB2_Oracle(AGlobal, TENANT_ID,UpdateMode);
    end;
    //������: ����SQL���
    case UpdateMode of
     1:
      begin
        Str:=  //B.SORT_NAME as SORT_NAME2,C.SORT_NAME as SORT_NAME6,
          'select GODS_CODE,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG,(case when UPDATE_FLAG=0 then ''δ����'' when UPDATE_FLAG in (1,2) then ''�Ѷ���'' else ''δ֪״̬'' end) as UpdateCase '+
          ' from INF_GOODS_RELATION Order by GODS_CODE';
      end;
     2:
      begin
        Str:=
          'select GODS_CODE,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG,(case when UPDATE_FLAG=0 then ''δ����'' when UPDATE_FLAG=2 then ''�¶���'' else ''δ֪״̬'' end) as UpdateCase '+
          ' from INF_GOODS_RELATION where UPDATE_FLAG in (0,2) Order by GODS_CODE';
      end;
     3:
      begin
        Str:=
          'select GODS_CODE,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG,(case when UPDATE_FLAG=0 then ''δ����'' when UPDATE_FLAG=1 then ''�Ѷ���'' else ''δ֪״̬'' end) as UpdateCase '+
          ' from INF_GOODS_RELATION where UPDATE_FLAG in (0,1) Order by GODS_CODE';
      end;
    end;
    SelectSQL.Text:=Str;
    result:=true;
  except
    Raise Exception.Create(PlugIn.DLLGetLastError);
  end;
end;

procedure TSynchronGood_Relation.InitClass;
begin
  inherited;

end;

{ TINF_GOODS_RELATION }

procedure TInf_Goods_Relation.InitClass;
var
  Str:string;
begin
  //��ʼ����ѯ
  SelectSQL.Text:='select * from INF_GOODS_RELATION where ROWS_ID=:ROWS_ID ';
  
  Str :='insert into INF_GOODS_RELATION '+
     '(ROWS_ID,TENANT_ID,RELATION_ID,GODS_ID,SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,SORT_ID1,SORT_ID2,SORT_ID3,'+
      'SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,'+
      'SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE,USING_PRICE,'+
      'HAS_INTEGRAL,USING_BATCH_NO,USING_BARTER,USING_LOCUS_NO,BARTER_INTEGRAL,UPDATE_FLAG,PACK_BARCODE) values '+
     '(:ROWS_ID,:TENANT_ID,:RELATION_ID,:GODS_ID,:SECOND_ID,:GODS_CODE,:GODS_NAME,:GODS_SPELL,:SORT_ID1,:SORT_ID2,:SORT_ID3,'+
      ':SORT_ID4,:SORT_ID5,:SORT_ID6,:SORT_ID7,:SORT_ID8,:SORT_ID9,:SORT_ID10,:SORT_ID11,:SORT_ID12,:SORT_ID13,:SORT_ID14,'+
      ':SORT_ID15,:SORT_ID16,:SORT_ID17,:SORT_ID18,:SORT_ID19,:SORT_ID20,:NEW_INPRICE,:NEW_OUTPRICE,:NEW_LOWPRICE,:USING_PRICE,'+
      ':HAS_INTEGRAL,:USING_BATCH_NO,:USING_BARTER,:USING_LOCUS_NO,:BARTER_INTEGRAL,:UPDATE_FLAG,:PACK_BARCODE)';
  InsertSQL.Add(Str);
end;

initialization
  RegisterClass(TInf_Goods_Relation);
  RegisterClass(TSynchronGood_Relation);


finalization
  UnRegisterClass(TInf_Goods_Relation);
  UnRegisterClass(TSynchronGood_Relation);

end.
