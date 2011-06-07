unit objSyncRelation;

interface

uses
  Forms,SysUtils,Classes,Dialogs,ZBase,zIntf;

{=== ������� ===}
type
  TInf_Goods_Relation=class(TZFactory)
  private
    function GetUpdateTime: string;
    //�����м��[INF_GOODS_RELATION]���¹�ϵ��[PUB_GOODS_RELATION]
    function DoUpdateRelation_MSSQL(AGlobal:IdbHelp): Integer;
    function DoUpdateRelation_DB2_Oracle(AGlobal:IdbHelp): Integer;
  public
    procedure InitClass; override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean; override;      //���м�¼������Ϻ�,�����ύ��ǰִ�С�
  end;

{=== ǰ̨Obj���� ===}
type
  TSynchronGood_Relation=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;

implementation

uses ZPlugIn, ObjCommon;

{ TSynchronGood_Relation }

function TSynchronGood_Relation.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  PlugIn: TPlugIn;
  InParams,TENANT_ID,Str: string;
  UpdateMode: integer;
  vData: oleVariant;
begin
  result:=False;
  //��Ӧ������ͬ�����ID: 1001
  PlugIn := PlugInList.Find(1001);
  try
    TENANT_ID:=InttoStr(Params.ParamByName('TENANT_ID').AsInteger);
    UpdateMode:=Params.ParamByName('UPDATE_MODE').AsInteger;

    //��һ��: �ӵ�������ͼ ��  R3�Ķ��չ�ϵ��;
    InParams:=Params.Encode(Params);
    PlugIn.DLLDoExecute(InParams, vData);

    //�ڶ����������ֹ�����:[]
    case AGlobal.iDbType of
     1:
       Str:=' update INF_GOODS_RELATION A set UPDATE_FLAG=1 where A.TENANT_ID='+TENANT_ID+' and A.UPDATE_FLAG in (0,4) and '+
             ' exists(select 1 from PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and INSTR(B.COMM_ID,'','' || A.SECOND_ID || '','', 1, 1)>0)';
     4:
       Str:=' update INF_GOODS_RELATION A set UPDATE_FLAG=1 where A.TENANT_ID='+TENANT_ID+' and A.UPDATE_FLAG in (0,4) and '+
             ' exists(select 1 from PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and locate('','' || A.SECOND_ID || '','',B.COMM_ID)>0)';
    end;
    AGlobal.ExecSQL(Str);


    //�����������ز�ѯ���:
    case UpdateMode of
     1:
      begin
        Str:=  //B.SORT_NAME as SORT_NAME2,C.SORT_NAME as SORT_NAME6,
          'select 0 as flag,SECOND_ID,GODS_CODE,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG,SORT_ID2,SORT_ID6,'+
          '(case when UPDATE_FLAG=0 then ''δ����'' when UPDATE_FLAG in (1,2) then ''�Ѷ���'' when UPDATE_FLAG=4 then ''�����ظ�'' else ''δ֪״̬'' end) as UpdateCase '+
          ' from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' Order by GODS_CODE';
      end;
     2:
      begin
        Str:=
          'select 0 as flag,SECOND_ID,GODS_CODE,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG,SORT_ID2,SORT_ID6,'+
          '(case when UPDATE_FLAG=0 then ''δ����'' when UPDATE_FLAG=2 then ''�¶���''  when UPDATE_FLAG=4 then ''�����ظ�''  else ''δ֪״̬'' end) as UpdateCase '+
          ' from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' and UPDATE_FLAG<>1 Order by GODS_CODE';
      end;
     3:
      begin
        Str:=
          'select GODS_CODE,SECOND_ID,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG, '+
          '(case when UPDATE_FLAG=0 then ''δ����'' when UPDATE_FLAG=3 then ''��ˢ��''  when UPDATE_FLAG=4 then ''�����ظ�'' else ''δ֪״̬'' end) as UpdateCase '+
          ' from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' and UPDATE_FLAG=3 Order by GODS_CODE';
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

{ TInf_Goods_Relation }


function TInf_Goods_Relation.DoUpdateRelation_DB2_Oracle(AGlobal: IdbHelp): Integer;
var
  UpdateMode,iRet: integer;
  TENANT_ID, Str: string;
  Comm, TimeStp: string;
  UpStr, UpSQL, InFields, UpFields: WideString;
begin
  result:=-1;
  iRet:=0;
  TENANT_ID:=FieldbyName('TENANT_ID').AsString;     //�����ݼ���������ÿһ����¼��һ��
  UpdateMode:=FieldbyName('UpdateMode').AsInteger;  //�����ݼ���������ÿһ����¼��һ��
  if (UpdateMode<0) or (UpdateMode>3) then UpdateMode:=1;  //Ĭ��Ϊ1

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
        ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') and '+
        ' exists(select 1 from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=1) ';
        iRet:=AGlobal.ExecSQL(UpSQL);

      //�����¼�¼:
      UpSQL:=
        'insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
        'select '+InFields+',''00'','+TimeStp+' from INF_GOODS_RELATION A where A.TENANT_ID='+TENANT_ID+' and A.UPDATE_FLAG=2 and  '+
        ' not exists(select 1 from PUB_GOODS_RELATION B where B.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID) ';
      iRet:=iRet+AGlobal.ExecSQL(UpSQL);
    end;
   2: //ˢ����Ʒ:
    begin
      //���벻���ڣ�
      UpSQL:='insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
             'select '+InFields+',''00'','+TimeStp+' from INF_GOODS_RELATION A where A.TENANT_ID='+TENANT_ID+' and UPDATE_FLAG=2';
      iRet:=AGlobal.ExecSQL(UpSQL);
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
        ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') and '+
        ' exists(select 1 from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=3 and B.TENANT_ID='+TENANT_ID+')';

      iRet:=AGlobal.ExecSQL(UpSQL);
    end;
  end;
  result:=iRet;
end;

function TInf_Goods_Relation.DoUpdateRelation_MSSQL(AGlobal: IdbHelp): Integer;
var
  UpdateMode,iRet: integer;
  TENANT_ID: string;
  InComm,UpComm: string;
  UpSQL, InFields, UpFields: WideString;
begin
  result:=-1;
  iRet:=0;
  UpdateMode:=1;  //Ĭ��Ϊ1
  TENANT_ID:=FieldbyName('TENANT_ID').AsString;     //�����ݼ���������ÿһ����¼��һ��
  UpdateMode:=FieldbyName('UpdateMode').AsInteger;  //�����ݼ���������ÿһ����¼��һ��

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
             ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') and A.GODS_ID=B.GODS_ID and UPDATE_FLAG=1 ';
      iRet:=AGlobal.ExecSQL(UpSQL);
      //���벻���ڣ�
      UpSQL:=
        'insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
        'select '+InFields+InComm+' from INF_GOODS_RELATION A where A.TENANT_ID='''+TENANT_ID+''' and UPDATE_FLAG=2 and '+
        ' not exists(select 1 from PUB_GOODS_RELATION B where B.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID) ';
      iRet:=iRet+AGlobal.ExecSQL(UpSQL);
    end;
   2: //ˢ����Ʒ:
    begin
      //���벻���ڣ�
      UpSQL:='insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
             'select '+InFields+InComm+' from INF_GOODS_RELATION A where A.TENANT_ID='''+TENANT_ID+''' and UPDATE_FLAG=2';
      iRet:=AGlobal.ExecSQL(UpSQL);
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
             ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=3 ';
      iRet:=AGlobal.ExecSQL(UpSQL);
    end;
  end;
  result:=iRet;
end;

function TInf_Goods_Relation.BeforeCommitRecord(AGlobal: IdbHelp): Boolean;
var
  iRet: integer;
  myFile,
  LogText: string;
  LogFile: TextFile;
begin
  case AGlobal.iDbType of
    0: iRet:=DoUpdateRelation_MSSQL(AGlobal);
    1,4: iRet:=DoUpdateRelation_DB2_Oracle(AGlobal);
  end;

  //��ΪRsp��������д��־
  if (FindField('FLAG')<>nil) and (FindField('FLAG').AsInteger<>3) then  //�����ݼ���������ÿһ����¼��һ��
  begin
    try
      case FieldbyName('UpdateMode').AsInteger of
       1: LogText:='------------- RSP���ȶ��վ�������  <'+GetUpdateTime+'> �������ͣ�<����ȫ��>  ���¼�¼����<'+inttostr(iRet)+'��> ---------------';
       2: LogText:='------------- RSP���ȶ��վ�������  <'+GetUpdateTime+'> �������ͣ�<������Ʒ>  ���¼�¼����<'+inttostr(iRet)+'��> ---------------';
       3: LogText:='------------- RSP���ȶ��վ�������  <'+GetUpdateTime+'> �������ͣ�<ˢ�¼۸�>  ���¼�¼����<'+inttostr(iRet)+'��> ---------------';
      end;
      myFile:=ExtractShortPathName(ExtractFilePath(Application.ExeName))+'log\REPORT'+FormatDatetime('YYYYMMDD',Date())+'.log';
      AssignFile(LogFile,myFile);
      if FileExists(myFile) then Append(LogFile) else rewrite(LogFile);
      Writeln(LogFile, '   ');
      Writeln(LogFile, LogText);
    finally
      CloseFile(LogFile);
    end;
  end;
end;

procedure TInf_Goods_Relation.InitClass;
var
  Str: string;
begin
  inherited;
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

function TInf_Goods_Relation.GetUpdateTime: string;
var
  vYear,vMonth,vDay,vHour,vMin, vSec,vMSec: Word;
begin
  DecodeDate(Date(), vYear, vMonth,vDay);
  result:=FormatFloat('0000',vYear)+FormatFloat('00',vMonth)+FormatFloat('00',vDay);
  DecodeTime(Time(), vHour, vMin, vSec, vMSec);
  result:=result+'_'+FormatFloat('00',vHour)+':'+FormatFloat('00',vMin)+':'+FormatFloat('00',vSec);
end;

initialization
  RegisterClass(TInf_Goods_Relation);
  RegisterClass(TSynchronGood_Relation); 

finalization
  UnRegisterClass(TInf_Goods_Relation);
  UnRegisterClass(TSynchronGood_Relation);

end.
