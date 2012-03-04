unit objSyncRelation;

interface

uses
  Forms,SysUtils,Classes,Dialogs,ZBase,zIntf;

{=== 插件调用 ===}
type
  TInf_Goods_Relation=class(TZFactory)
  private
    function GetUpdateTime: string;
    //Rim到R3单位换算和手工对照
    function DoChangeUnit_DB2_Oracle(AGlobal:IdbHelp): Integer;

    //根据中间表[INF_GOODS_RELATION]更新关系表[PUB_GOODS_RELATION]
    function DoUpdateRelation_MSSQL(AGlobal:IdbHelp): Integer;
    function DoUpdateRelation_DB2_Oracle(AGlobal:IdbHelp): Integer;
  public
    procedure InitClass; override;
    function BeforeCommitRecord(AGlobal:IdbHelp):Boolean; override;      //所有记录处理完毕后,事务提交以前执行。
  end;

{=== 前台Obj调用 ===}
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
  InParams,TENANT_ID,Str,Sort_ID5: string;
  UpdateMode: integer;
  vData: oleVariant;
begin
  result:=False;
  //供应链对照同步组件ID: 1001
  PlugIn := PlugInList.Find(1001);
  try
    TENANT_ID:=InttoStr(Params.ParamByName('TENANT_ID').AsInteger);
    UpdateMode:=Params.ParamByName('UPDATE_MODE').AsInteger;

    //第一步: 从第三方视图 到  R3的对照关系表;
    InParams:=Params.Encode(Params);
    PlugIn.DLLDoExecute(InParams, vData);
    //是否重点品牌
    Sort_ID5:='(case when SORT_ID4=''1'' then ''01072169-2F03-42C1-9EAB-541D031647AF'''+
                   ' else ''15CD1495-B3C7-42C7-8709-5376FC061305'' end) as SORT_ID5 ';


    //第二步：返回查询结果:
    case UpdateMode of
     1:
      begin
        Str:=  //B.SORT_NAME as SORT_NAME2,C.SORT_NAME as SORT_NAME6,
          'select 0 as flag,SECOND_ID,GODS_CODE,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG,SORT_ID2,'+Sort_ID5+',SORT_ID6,'+
          '(case when UPDATE_FLAG=0 then ''未对上'' when UPDATE_FLAG in (1,2) then ''已对照'' when UPDATE_FLAG=4 then ''条码重复'' when UPDATE_FLAG=5 then ''手工对照'' else ''未知状态'' end) as UpdateCase '+
          ' from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' Order by GODS_CODE';
      end;
     2:
      begin
        Str:=
          'select 0 as flag,SECOND_ID,GODS_CODE,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG,SORT_ID2,'+Sort_ID5+',SORT_ID6,'+
          '(case when UPDATE_FLAG=0 then ''未对上'' when UPDATE_FLAG=2 then ''新对照''  when UPDATE_FLAG=4 then ''条码重复'' when UPDATE_FLAG=5 then ''手工对照''  else ''未知状态'' end) as UpdateCase '+
          ' from INF_GOODS_RELATION where TENANT_ID='+TENANT_ID+' and UPDATE_FLAG<>1 Order by GODS_CODE';
      end;
     3:
      begin
        Str:=
          'select GODS_CODE,SECOND_ID,GODS_NAME,NEW_INPRICE,NEW_OUTPRICE,PACK_BARCODE,UPDATE_FLAG, '+
          '(case when UPDATE_FLAG=0 then ''未对上'' when UPDATE_FLAG=3 then ''已刷新''  when UPDATE_FLAG=4 then ''条码重复'' else ''未知状态'' end) as UpdateCase '+
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
  UpStr, UpSQL, ExeSQL, InFields, UpFields: WideString;
begin
  result:=-1;
  iRet:=0;
  TENANT_ID:=FieldbyName('TENANT_ID').AsString;     //从数据集传过来，每一条记录都一样
  UpdateMode:=FieldbyName('UpdateMode').AsInteger;  //从数据集传过来，每一条记录都一样
  if (UpdateMode<0) or (UpdateMode>3) then UpdateMode:=1;  //默认为1

  //单位换算和手工对照更新
  DoChangeUnit_DB2_Oracle(AGlobal);

  Comm:=GetCommStr(AGlobal.iDbType);
  TimeStp:=GetTimeStamp(AGlobal.iDbType);
  InFields:=
    'ROWS_ID,TENANT_ID,RELATION_ID,GODS_ID,SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4, SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,'+
    'SORT_ID10,SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE ';
  UpFields:=
    'SECOND_ID,GODS_CODE,GODS_NAME,GODS_SPELL,SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,SORT_ID9,SORT_ID10,'+
    'SORT_ID11,SORT_ID12,SORT_ID13,SORT_ID14,SORT_ID15,SORT_ID16,SORT_ID17,SORT_ID18,SORT_ID19,SORT_ID20,NEW_INPRICE,NEW_OUTPRICE,NEW_LOWPRICE ';

  //2012.03.04上午处理(Rsp上修改条码后根据条码新对照出的记录处理归属到原对照)
  ExeSQL:=
    'update INF_GOODS_RELATION A set A.UPDATE_FLAG=1 '+
    ' where A.UPDATE_FLAG=2 and '+
    ' exists(select 1 from PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.COMM not in (''02'',''12'')) ';
  AGlobal.ExecSQL(ExeSQL);

  case UpdateMode of
   1: //刷新所有条件:
    begin
      //更新存在记录:
      UpSQL:=
        'update PUB_GOODS_RELATION A set ('+UpFields+',COMM,TIME_STAMP)= '+
        ' (select '+UpFields+','+Comm+','+TimeStp+' from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=1 and A.TENANT_ID='+TENANT_ID+')'+
        ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') and '+
        ' exists(select 1 from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=1) ';
        iRet:=AGlobal.ExecSQL(UpSQL);

      //插入新记录:
      UpSQL:=
        'insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
        'select '+InFields+',''00'','+TimeStp+' from INF_GOODS_RELATION A where A.TENANT_ID='+TENANT_ID+' and A.UPDATE_FLAG=2 and  '+
        ' not exists(select 1 from PUB_GOODS_RELATION B where B.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID) ';
      iRet:=iRet+AGlobal.ExecSQL(UpSQL);

      //2011.08.18更新手工对照：
      UpSQL:=
         'update PUB_GOODS_RELATION A set ('+UpFields+',COMM,TIME_STAMP)= '+
         ' (select '+UpFields+','+Comm+','+TimeStp+' from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and a.SECOND_ID=b.SECOND_ID and B.UPDATE_FLAG=5 and A.TENANT_ID='+TENANT_ID+')'+
         ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') and nvl(A.COMM_ID,'''')<>'''' and '+
         ' exists(select 1 from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SECOND_ID=B.SECOND_ID and B.UPDATE_FLAG=5)';
      UpSQL:=ParseSQL(AGlobal.iDbType,UpSQL);
      iRet:=AGlobal.ExecSQL(UpSQL);
    end;
   2: //刷新新品:
    begin
      //插入不存在：
      UpSQL:='insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
             'select '+InFields+',''00'','+TimeStp+' from INF_GOODS_RELATION A where A.TENANT_ID='+TENANT_ID+' and UPDATE_FLAG=2';
      iRet:=AGlobal.ExecSQL(UpSQL);
    end;
   3://刷新价格:
    begin
      //将符合插入新品标记位修改为3;
      UpSQL:='update INF_GOODS_RELATION A set UPDATE_FLAG=3 where UPDATE_FLAG=1 and TENANT_ID='+TENANT_ID+' and '+
             ' exists(select GODS_ID from PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID) ';
      AGlobal.ExecSQL(UpSQL);

      //更新字段:
      UpSQL:=
        'update PUB_GOODS_RELATION A '+
        ' set (NEW_INPRICE,NEW_OUTPRICE,COMM,TIME_STAMP)= '+
        ' (select NEW_INPRICE,NEW_OUTPRICE,'+Comm+','+TimeStp+' from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=3 and B.TENANT_ID='+TENANT_ID+') '+
        ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') an '+
        ' exists(select 1 from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.UPDATE_FLAG=3 and B.TENANT_ID='+TENANT_ID+')';
      iRet:=AGlobal.ExecSQL(UpSQL);

      //2011.08.18更新手工对照：
      UpSQL:=
        'update PUB_GOODS_RELATION A '+
        ' set (NEW_INPRICE,NEW_OUTPRICE,COMM,TIME_STAMP)= '+
        ' (select NEW_INPRICE,NEW_OUTPRICE,'+Comm+','+TimeStp+' from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SECOND_ID=B.SECOND_ID and B.UPDATE_FLAG=5 and B.TENANT_ID='+TENANT_ID+') '+
        ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') and nvl(A.COMM_ID,'''')<>'''' and  '+
        ' exists(select 1 from INF_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.SECOND_ID=B.SECOND_ID and B.UPDATE_FLAG=5 and B.TENANT_ID='+TENANT_ID+')';
      UpSQL:=ParseSQL(AGlobal.iDbType,UpSQL);
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
  UpdateMode:=1;  //默认为1
  TENANT_ID:=FieldbyName('TENANT_ID').AsString;     //从数据集传过来，每一条记录都一样
  UpdateMode:=FieldbyName('UpdateMode').AsInteger;  //从数据集传过来，每一条记录都一样

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

  //2012.03.04上午处理(Rsp上修改条码后根据条码新对照出的记录处理归属到原对照)
  ExeSQL:=
    'update INF_GOODS_RELATION A set A.UPDATE_FLAG=1 '+
    ' where A.UPDATE_FLAG=2 and '+
    ' exists(select 1 from PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.COMM not in (''02'',''12'')) ';
  AGlobal.ExecSQL(ExeSQL);

  case UpdateMode of
   1: //刷新所有:
    begin
      //更新已对应:
      UpSQL:='update A Set '+UpFields+UpComm+' from PUB_GOODS_RELATION A,INF_GOODS_RELATION B '+
             ' where A.TENANT_ID='+TENANT_ID+' and A.COMM not in (''02'',''12'') and A.GODS_ID=B.GODS_ID and UPDATE_FLAG=1 ';
      iRet:=AGlobal.ExecSQL(UpSQL);
      //插入不存在：
      UpSQL:=
        'insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
        'select '+InFields+InComm+' from INF_GOODS_RELATION A where A.TENANT_ID='''+TENANT_ID+''' and UPDATE_FLAG=2 and '+
        ' not exists(select 1 from PUB_GOODS_RELATION B where B.TENANT_ID='+TENANT_ID+' and A.GODS_ID=B.GODS_ID) ';
      iRet:=iRet+AGlobal.ExecSQL(UpSQL);
    end;
   2: //刷新新品:
    begin
      //插入不存在：
      UpSQL:='insert into PUB_GOODS_RELATION ('+InFields+',COMM,TIME_STAMP) '+
             'select '+InFields+InComm+' from INF_GOODS_RELATION A where A.TENANT_ID='''+TENANT_ID+''' and UPDATE_FLAG=2';
      iRet:=AGlobal.ExecSQL(UpSQL);
    end;
   3://刷新价格
    begin
      //将符合插入新品标记位修改为3;
      UpSQL:='update A set A.UPDATE_FLAG=3 from INF_GOODS_RELATION A,PUB_GOODS_RELATION B '+
             ' where A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and A.UPDATE_FLAG=1 and A.TENANT_ID='+TENANT_ID+' ';
      AGlobal.ExecSQL(UpSQL);
      
      //更新字段:
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

  //若为Rsp调度运行写日志
  if (FindField('FLAG')<>nil) and (FindField('FLAG').AsInteger<>3) then  //从数据集传过来，每一条记录都一样
  begin
    try
      case FieldbyName('UpdateMode').AsInteger of
       1: LogText:='------------- RSP调度对照卷烟资料  <'+GetUpdateTime+'> 对照类型：<对照全部>  更新记录数：<'+inttostr(iRet)+'笔> ---------------';
       2: LogText:='------------- RSP调度对照卷烟资料  <'+GetUpdateTime+'> 对照类型：<对照新品>  更新记录数：<'+inttostr(iRet)+'笔> ---------------';
       3: LogText:='------------- RSP调度对照卷烟资料  <'+GetUpdateTime+'> 对照类型：<刷新价格>  更新记录数：<'+inttostr(iRet)+'笔> ---------------';
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
  //初始化查询
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

function TInf_Goods_Relation.DoChangeUnit_DB2_Oracle(AGlobal: IdbHelp): Integer;
var
  iRet: integer;
  UpSQL: string;
  TENANT_ID: string;
begin
  result:=-1;
  iRet:=0;
  TENANT_ID:=FieldbyName('TENANT_ID').AsString;     //从数据集传过来，每一条记录都一样

  //2011.06. 29 Add 单位换算：
  UpSQL:=
    'update INF_GOODS_RELATION a set '+
    ' (a.NEW_INPRICE,a.NEW_OUTPRICE)='+
    ' (select (case when b.SMALLTO_CALC>0 then (a.NEW_INPRICE*1.00)/(b.SMALLTO_CALC*1.0) else a.NEW_INPRICE end) as NEW_INPRICE,'+
    ' (case when b.SMALLTO_CALC>0 then (a.NEW_OUTPRICE*1.00)/(b.SMALLTO_CALC*1.0) else a.NEW_OUTPRICE end) as NEW_OUTPRICE '+
    ' from PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001) '+
    ' where exists(select GODS_ID from PUB_GOODSINFO b where a.GODS_ID=b.GODS_ID and b.TENANT_ID=110000001) ';
  iRet:=AGlobal.ExecSQL(UpSQL);

  //2011.08.16 调整位置；
  case AGlobal.iDbType of
   1:
    UpSQL:=' update INF_GOODS_RELATION A set UPDATE_FLAG=5 where A.TENANT_ID='+TENANT_ID+' and A.UPDATE_FLAG in (0,4) and '+
           ' exists(select 1 from PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and INSTR(B.COMM_ID,'','' || A.SECOND_ID || '','', 1, 1)>0)';
   4:
    UpSQL:=' update INF_GOODS_RELATION A set UPDATE_FLAG=5 where A.TENANT_ID='+TENANT_ID+' and A.UPDATE_FLAG in (0,4) and '+
           ' exists(select 1 from PUB_GOODS_RELATION B where A.TENANT_ID=B.TENANT_ID and locate('','' || A.SECOND_ID || '','',B.COMM_ID)>0)';
  end;
  AGlobal.ExecSQL(UpSQL);
  result:=iRet;
end;

initialization
  RegisterClass(TInf_Goods_Relation);
  RegisterClass(TSynchronGood_Relation); 

finalization
  UnRegisterClass(TInf_Goods_Relation);
  UnRegisterClass(TSynchronGood_Relation);

end.
