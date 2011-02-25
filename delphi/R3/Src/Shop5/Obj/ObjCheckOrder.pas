unit ObjCheckOrder;

interface

uses
  SysUtils,zBase,Classes, AdoDb,zIntf,ObjCommon,DB,zDataSet;

type
  TCheckOrder=class(TZFactory)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    // function AfterUpdateBatch(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  
  TCheckData=class(TZFactory)
  public
    IsZeroOut:Boolean;
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp): Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集修改检测函数，返回值是True 测可以修改当前记录
    function BeforeModifyRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集删除检测函数，返回值是True 测可以删除当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass; override;
  end;
  
  TCheckOrderGetPrior=class(TZFactory)
  public
    procedure InitClass;override;
  end;
  
  TCheckOrderGetNext=class(TZFactory)
  public
    procedure InitClass;override;
  end;
implementation

{ TCheckData }

function TCheckData.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TCheckData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  try
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  Result := True;
  except
    on E:Exception do
      begin
        Result := False;
        Raise;
      end;
  end;
end;

function TCheckData.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
end;

function TCheckData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var Temp: TZQuery;
begin
  Result := true;
  Temp := TZQuery.Create(nil);
  try
    Temp.close;
    Temp.SQL.Text := 'select VALUE from SYS_DEFINE where COMP_ID='''+FieldbyName('COMP_ID').AsString+''' and DEFINE=''ZERO_OUT''';
    AGlobal.Open(Temp);
    IsZeroOut := (trim(Temp.Fields[0].AsString) = '1');
  finally
    Temp.free;
  end;
  case AGlobal.iDbType of
    0:AGlobal.ExecSQL('select count(*) from STO_STORAGE with(UPDLOCK) where COMP_ID=:COMP_ID',self);
  end;

end;

procedure TCheckData.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text:= 'select j.COMP_ID,j.CHECK_ID,j.SEQNO,j.GODS_ID,j.PROPERTY_01,j.PROPERTY_02,j.BATCH_NO,j.UNIT_ID,j.AMOUNT,j.IS_PRESENT,j.CALC_AMOUNT,'+
               'b.GODS_NAME,b.GODS_CODE from STO_CHECKDATA j left outer join VIW_GOODSINFO b on j.COMP_ID=b.COMP_ID and j.GODS_ID=b.GODS_ID where j.COMP_ID=:COMP_ID and j.CHECK_ID=:CHECK_ID '+
               'order by SEQNO';
  IsSQLUpdate := True;
  Str := 'insert into STO_CHECKDATA(COMP_ID,SEQNO,CHECK_ID,GODS_ID,BATCH_NO,PROPERTY_01,PROPERTY_02,UNIT_ID,AMOUNT,IS_PRESENT,CALC_AMOUNT) '
    + 'VALUES(:COMP_ID,:SEQNO,:CHECK_ID,:GODS_ID,:BATCH_NO,:PROPERTY_01,:PROPERTY_02,:UNIT_ID,:AMOUNT,:IS_PRESENT,:CALC_AMOUNT)';
  InsertSQL.Add('', Str);
  Str := 'update STO_CHECKDATA set COMP_ID=:COMP_ID,SEQNO=:SEQNO,CHECK_ID=:CHECK_ID,GODS_ID=:GODS_ID,BATCH_NO=:BATCH_NO,PROPERTY_01=:PROPERTY_01,PROPERTY_02=:PROPERTY_02,UNIT_ID=:UNIT_ID,AMOUNT=:AMOUNT,'+
         'IS_PRESENT=:IS_PRESENT,CALC_AMOUNT=:CALC_AMOUNT '
    + 'where COMP_ID=:OLD_COMP_ID and CHECK_ID=:OLD_CHECK_ID and SEQNO=:OLD_SEQNO';
  UpdateSQL.Add('', Str);
  Str := 'delete from STO_CHECKDATA where COMP_ID=:OLD_COMP_ID and CHECK_ID=:OLD_CHECK_ID and SEQNO=:OLD_SEQNO';
  DeleteSQL.Add('', Str);
end;

{ TCheckOrder }

{function TCheckOrder.AfterUpdateBatch(AGlobal: IdbHelp): Boolean;
var
  d:string;
begin
  d := FieldbyName('CHECK_DATE').AsString;
  d := StringReplace(d,'-','',[rfReplaceAll]);
  AGlobal.ExecSQL('select count(*) from CHK_PRINTDATA with(ROWLOCK) where COMP_ID=:COMP_ID and PRINT_ID='''+d+'''',self);
  AGlobal.ExecSQL('insert into CHK_PRINTDATA(COMP_ID,PRINT_ID,BATCH_NO,STOR_ID,GODS_ID,PROPERTY_01,PROPERTY_02,IS_PRESENT,RCK_AMOUNT,AMOUNT,CHECK_STATUS,COMM) '+
                  'select :COMP_ID,'''+d+''',BATCH_NO,''#'',GODS_ID,PROPERTY_01,PROPERTY_02,0 as IS_PRESENT,0 as RCK_AMOUNT,0 as AMOUNT,1 as CHECK_STATUS,''00'' from STO_CHECKDATA A where COMP_ID=:COMP_ID and CHECK_ID=:CHECK_ID and A.IS_PRESENT=0 '+
                  'and not Exists(select * from CHK_PRINTDATA where COMP_ID=:COMP_ID and PRINT_ID='''+d+''' and GODS_ID=A.GODS_ID and BATCH_NO=A.BATCH_NO and PROPERTY_01=A.PROPERTY_01 and PROPERTY_02=A.PROPERTY_02 and IS_PRESENT=A.IS_PRESENT)',self);
  AGlobal.ExecSQL('update CHK_PRINTDATA set AMOUNT=J.AMOUNT,CHECK_STATUS=''2'' from CHK_PRINTDATA A,'+
                  '(select GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO,0 as IS_PRESENT,sum(B.CALC_AMOUNT) as AMOUNT from STO_CHECKDATA B,STO_CHECKORDER C '+
                  'where B.COMP_ID=C.COMP_ID and B.CHECK_ID=C.CHECK_ID and '+
                  'C.COMP_ID=:COMP_ID and C.CHECK_DATE=:CHECK_DATE group by GODS_ID,PROPERTY_01,PROPERTY_02,BATCH_NO ) J '+
                  'where A.GODS_ID=J.GODS_ID and A.BATCH_NO=J.BATCH_NO and A.PROPERTY_01=J.PROPERTY_01 and A.PROPERTY_02=J.PROPERTY_02 and A.IS_PRESENT=J.IS_PRESENT ',self);
  result := true;
end;
}

function TCheckOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
begin

  result := true;
end;

function TCheckOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
  begin
    if (FieldbyName('GLIDE_NO').AsString='') or (Pos('新增',FieldbyName('GLIDE_NO').AsString)>0) then
     FieldbyName('GLIDE_NO').AsString:=GetSequence(AGlobal,'GNO_9_'+FieldbyName('SHOP_ID').AsString,FieldbyName('TENANT_ID').AsString,formatDatetime('YYMMDD',now()),5);


  end;
  result := true;
end;

function TCheckOrder.BeforeModifyRecord(AGlobal: IdbHelp): Boolean;
begin
  result := BeforeDeleteRecord(AGlobal);
  result := BeforeInsertRecord(AGlobal);
  
end;

function TCheckOrder.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
   if (Params.FindParam('SyncFlag')=nil) or (Params.FindParam('SyncFlag').asInteger=0) then
      begin
//        Result := GetReckOning(AGlobal,FieldbyName('COMP_ID').asString,FieldbyName('CHECK_DATE').AsString);
//        if FieldbyName('CHECK_DATE').AsOldString <> '' then
//           Result := GetReckOning(AGlobal,FieldbyName('COMP_ID').asString,FieldbyName('CHECK_DATE').AsOldString);
        result := true;
      end
   else
      Result := true;
      
end;

procedure TCheckOrder.InitClass;
var
  Str: string;
begin
  inherited;
  SelectSQL.Text:=
    'select jd.*,d.USER_NAME as CHK_USER_TEXT from ('+
    'select jc.*,c.USER_NAME as CHECK_EMPL_TEXT from ('+
    ' select CHECK_ID,COMP_ID,GLIDE_NO,CHECK_DATE,CHECK_EMPL,REMARK,CHK_USER,CHK_DATE,PRINT_ID,COMM_ID,CREA_DATE,OPER_USER,COMM from STO_CHECKORDER where COMP_ID=:COMP_ID and CHECK_ID=:CHECK_ID) jc '+
    ' left outer join VIW_USERS c on jc.CHECK_EMPL=c.USER_ID ) jd '+
    ' left outer join VIW_USERS d on jd.CHK_USER=d.USER_ID';
  
  str:='insert into STO_PRINTORDER(TENANT_ID,SHOP_ID,PRINT_DATE,CHECK_STATUS,CHECK_TYPE,CREA_DATE,CREA_USER,COMM,TIME_STAMP)'+
       ' values (:TENANT_ID,:SHOP_ID,:PRINT_DATE,:CHECK_STATUS,:CHECK_TYPE,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
  InsertSQL.Add(str);

  str:='update STO_PRINTORDER set TENANT_ID=:TENANT_ID,SHOP_ID=:SHOP_ID,PRINT_DATE=:PRINT_DATE,CHECK_STATUS=:CHECK_STATUS,CHECK_TYPE=:CHECK_TYPE,CREA_DATE=:CREA_DATE,'+
       ' CREA_USER=:CREA_USER,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+' where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PRINT_DATE=:OLD_PRINT_DATE ';
  UpdateSQL.Add(Str);
  Str := 'delete from STO_PRINTORDER where TENANT_ID=:OLD_TENANT_ID and SHOP_ID=:OLD_SHOP_ID and PRINT_DATE=:OLD_PRINT_DATE ';
  DeleteSQL.Add(Str);
end;

{ TCheckOrderGetPrior }

procedure TCheckOrderGetPrior.InitClass;
begin
  inherited;
  SelectSQL := 'select top 1 CHECK_ID from STO_CHECKORDER where COMP_ID=:COMP_ID and OPER_USER=:OPER_USER and GLIDE_NO<:GLIDE_NO order by GLIDE_NO desc';
end;

{ TCheckOrderGetNext }

procedure TCheckOrderGetNext.InitClass;
begin
  inherited;
  SelectSQL := 'select top 1 CHECK_ID from STO_CHECKORDER where COMP_ID=:COMP_ID and OPER_USER=:OPER_USER and GLIDE_NO>:GLIDE_NO order by GLIDE_NO';
end;

initialization
  RegisterClass(TCheckOrder);
  RegisterClass(TCheckData);
  RegisterClass(TCheckOrderGetPrior);
  RegisterClass(TCheckOrderGetNext);
finalization
  UnRegisterClass(TCheckOrder);
  UnRegisterClass(TCheckData);
  UnRegisterClass(TCheckOrderGetPrior);
  UnRegisterClass(TCheckOrderGetNext);
end.
