unit udllDsUtil;

interface

uses Classes,SysUtils,Db,ZBase,ZdbFactory,uFnUtil,ZDataSet,udataFactory;

type
 TdsFind=class
 public
   class function GetNameByID(DataSet:TDataSet;KeyField,NameField:string;KeyValue:string):string;
 end;

 TdsItems=class
 public
   class procedure ClearItems(Items:TStrings);
   class function  FindItems(Items:TStrings;KeyField:string;KeyValue:string):Integer;
   class procedure AddDataSetToItems(DataSet:TDataSet;Items:TStrings;NameField:string);
 end;

 TSequence=class
 public
   class function GetTimeStamp(iDbType:Integer):string;  //根据iDbType返回数据库时间戳函数
   class function GetSequence(SEQU_ID,TENANT_ID,FLAG_TEXT:string;nLen:Integer;Number:Integer=1):string;overload;
   class function TryGetSequence(SEQU_ID,TENANT_ID,FLAG_TEXT:string;nLen:Integer;Number:Integer=1):string;overload;
   class function GetSequence(AFactor:TdbFactory;SEQU_ID,TENANT_ID,FLAG_TEXT:string;nLen:Integer):string;overload;
   class function GetMaxID(FlagText:string;FieldName,TableName:string;nLen:string;CondiStr:string=''):string;overload;
   class function GetIntegerID(Factor:TdbFactory;FieldName,TableName:string;CondiStr:string=''):Integer;
   class function NewId():string;
 end;

 TBatchSQLFactory=class
 private
   RsExeSQL:TZQuery;
   function DoCreateDataSet:Boolean;
   function GetFieldSQL(Sql:string;FieldIdx: integer):string;
 public
   constructor Create;virtual;
   destructor  Destroy;override;
   function DoClearSQL:Boolean;
   function AppendSQL(SQLStr: WideString): Boolean;
   function DoExecSQLComand(vFactor:TdbFactory):Boolean;
 end;

implementation

uses udllGlobal,utokenFactory;

{ TdsFind }

class function TdsFind.GetNameByID(DataSet: TDataSet; KeyField, NameField: string;KeyValue:string): string;
begin
  if DataSet.Filtered then DataSet.Filtered := false;
  if DataSet.Locate(KeyField,KeyValue,[]) then
     result := DataSet.FieldbyName(NameField).AsString
  else
     result := '';
end;

{ TdsItems }

class procedure TdsItems.AddDataSetToItems(DataSet: TDataSet; Items: TStrings;NameField:string);
var AObj:TRecord_;
begin
  ClearItems(Items);
  DataSet.First;
  while not DataSet.Eof do
    begin
      AObj := TRecord_.Create(DataSet);
      AObj.ReadFromDataSet(DataSet);
      Items.AddObject(DataSet.FieldbyName(NameField).AsString ,AObj);
      DataSet.Next;
    end;
end;

class procedure TdsItems.ClearItems(Items:TStrings);
var i:Integer;
begin
  for i:=0 to Items.Count -1 do
    begin
      if (Items.Objects[i]<>nil) and (TObject(Items.Objects[i]) is TRecord_) then
         Items.Objects[i].Free
      else
      if Items.Objects[i]<>nil then
         Dispose(Pointer(Items.Objects[i]));

      Items.Objects[i] := nil;
    end;
  Items.Clear;
end;

class function TdsItems.FindItems(Items: TStrings; KeyField, KeyValue: string): Integer;
var i:Integer;
begin
  result := -1;
  for i:=0 to Items.Count -1 do
    begin
      if Items.Objects[i]=nil then Continue;
      if UpperCase(TRecord_(Items.Objects[i]).FieldByName(KeyField).AsString)=UpperCase(KeyValue) then
        begin
           result := i;
           Exit;
        end;
    end;
end;

{ TSequence }

class function TSequence.GetTimeStamp(iDbType: Integer): string;
begin
  case iDbType of
    0: result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
    1:result := '86400*floor(sysdate - to_date(''20110101'',''yyyymmdd''))+(sysdate - trunc(sysdate))*24*60*60';
    4: result := '86400*(days(current date)-days(date(''2011-01-01'')))+midnight_seconds(current timestamp)';
    5: result := 'strftime(''%s'',''now'',''localtime'')-1293840000';
    else result := 'convert(bigint,(convert(float,getdate())-40542.0)*86400)';
  end;
end;

class function TSequence.GetIntegerID(Factor: TdbFactory; FieldName, TableName, CondiStr: string): Integer;
var DataSet:TZQuery;
begin
  DataSet:=TZQuery.Create(nil);
  try
    with DataSet do
     begin
        Close;
        SQL.Clear;
        SQL.Add('select max('+FieldName+') from '+TableName);
        if CondiStr<>'' then
           SQL.Text := SQL.Text +' where '+CondiStr;

        Factor.Open(DataSet);
        result := DataSet.Fields[0].AsInteger +1;
     end;
  finally
    DataSet.Free;
  end;
end;

class function TSequence.GetMaxID(FlagText: string; FieldName, TableName, nLen, CondiStr: string): string;
var
  ss:string;
  TmpLen:Integer;
  DataSet:TZQuery;
begin
  DataSet:=TZQuery.Create(nil);
  try
    with DataSet Do
      begin
        TmpLen:=Length(FlagText)+Length(nLen);
        Close;
        SQL.Clear;

        case dataFactory.iDbType of
          0,3:SQL.Add('select max('+FieldName+') from '+TableName+' where '+FieldName+' like '''+FlagText+'%'' and Len('+FieldName+')='+Inttostr(TmpLen));
          1,4,5:SQL.Add('select max('+FieldName+') from '+TableName+' where '+FieldName+' like '''+FlagText+'%'' and Length('+FieldName+')='+Inttostr(TmpLen));
        end;

        if CondiStr<>'' then
           SQL.Text := SQL.Text +' and '+CondiStr;

        dataFactory.Open(DataSet);
        if Fields[0].asString='' Then
           result:=FlagText+FormatFloat(nLen,1)
        else
           begin
             TmpLen:=Length(FlagText);
             ss:=Fields[0].asString;
             System.Delete(ss,1,TmpLen);
             result:=FlagText+FnString.IncCode(ss,Length(nLen));
           end;
      end;
  finally
    DataSet.Free;
  end;
end;

class function TSequence.GetSequence(SEQU_ID, TENANT_ID, FLAG_TEXT: string; nLen: Integer;Number:Integer=1): string;
  function GetFormat:string;
  var i:Integer;
    begin
      result := '';
      for i:=1 to nLen do
        result := result +'0';
    end;
var Temp:TZQuery;
    Str,flag:string;
    InTrans:Boolean;
begin
  InTrans := dataFactory.InTransaction;
  Temp := TZQuery.Create(nil);
  try
    if not InTrans then dataFactory.BeginTrans(10);
    try
      case dataFactory.iDbType of
      0:Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE with (UPDLOCK) where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' ';
      1:Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' FOR UPDATE';
      4:Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' FOR UPDATE WITH RS ';
      3,5:
        begin
          dataFactory.ExecSQL('update SYS_SEQUENCE set SEQU_NO=SEQU_NO+1 where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''');
          Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' ';
        end;
      end;
      dataFactory.Open(Temp);
      if Temp.IsEmpty then
         begin
           result := FLAG_TEXT+FormatFloat(GetFormat,1);
           Str := 'insert into SYS_SEQUENCE(TENANT_ID,SEQU_ID,FLAG_TEXT,SEQU_NO,COMM,TIME_STAMP) values('+TENANT_ID+','''+SEQU_ID+''','''+FLAG_TEXT+''','+Inttostr(Number)+',''00'','+TSequence.GetTimeStamp(dataFactory.iDbType)+')';
         end
      else
      if (Temp.FieldbyName('FLAG_TEXT').AsString<FLAG_TEXT) then
         begin
           result := FLAG_TEXT+FormatFloat(GetFormat,1);
           Str := 'update SYS_SEQUENCE set FLAG_TEXT='''+FLAG_TEXT+''',SEQU_NO='+Inttostr(Number)+' where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''';
         end
      else
         begin
           if Temp.FieldbyName('FLAG_TEXT').AsString=FLAG_TEXT then
              flag := FLAG_TEXT
           else
              flag := Temp.FieldbyName('FLAG_TEXT').AsString;
           if (dataFactory.iDbType=3) or (dataFactory.iDbType=5) then
              begin
                result := flag+FormatFloat(GetFormat,Temp.FieldbyName('SEQU_NO').AsInteger);
                Number := 0;
              end
           else
              result := flag+FormatFloat(GetFormat,Temp.FieldbyName('SEQU_NO').AsInteger+1);
           Str := 'update SYS_SEQUENCE set FLAG_TEXT='''+flag+''',SEQU_NO='+Inttostr(Temp.FieldbyName('SEQU_NO').AsInteger+Number)+' where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''';
         end;
      dataFactory.ExecSQL(Str);
      if not InTrans then dataFactory.CommitTrans;
    except
      if not InTrans then dataFactory.RollbackTrans;
      Raise;
    end;
  finally
    Temp.Free;
  end;
end;

class function TSequence.GetSequence(AFactor: TdbFactory; SEQU_ID, TENANT_ID, FLAG_TEXT: string; nLen: Integer): string;
  function GetFormat:string;
  var i:Integer;
  begin
    result := '';
    for i:=1 to nLen do
      result := result +'0';
  end;
var Temp:TZQuery;
    Str,flag:string;
    n:integer;
begin
  Temp := TZQuery.Create(nil);
  try
    AFactor.BeginTrans(10);
    try
      case AFactor.iDbType of
      0: Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE with (UPDLOCK) where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' ';
      1: Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' FOR UPDATE';
      4: Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' FOR UPDATE WITH RS ';
      3,5:
        begin
          AFactor.ExecSQL('update SYS_SEQUENCE set SEQU_NO=SEQU_NO+1 where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''');
          Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' ';
        end;
      end;
      AFactor.Open(Temp);
      if Temp.IsEmpty then
         begin
           result := FLAG_TEXT+FormatFloat(GetFormat,1);
           Str := 'insert into SYS_SEQUENCE(TENANT_ID,SEQU_ID,FLAG_TEXT,SEQU_NO,COMM,TIME_STAMP) values('+TENANT_ID+','''+SEQU_ID+''','''+FLAG_TEXT+''',1,''00'','+TSequence.GetTimeStamp(dataFactory.iDbType)+')';
         end
      else
      if (Temp.FieldbyName('FLAG_TEXT').AsString<FLAG_TEXT) then
         begin
           result := FLAG_TEXT+FormatFloat(GetFormat,1);
           Str := 'update SYS_SEQUENCE set FLAG_TEXT='''+FLAG_TEXT+''',SEQU_NO=1 where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''';
         end
      else
         begin
           if Temp.FieldbyName('FLAG_TEXT').AsString=FLAG_TEXT then
              flag := FLAG_TEXT
           else
              flag := Temp.FieldbyName('FLAG_TEXT').AsString;
           n := 1;
           if (AFactor.iDbType = 3) or (AFactor.iDbType = 5) then
              begin
                result := flag+FormatFloat(GetFormat,Temp.FieldbyName('SEQU_NO').AsInteger);
                n := 0;
              end
           else
              result := flag+FormatFloat(GetFormat,Temp.FieldbyName('SEQU_NO').AsInteger+1);
           Str := 'update SYS_SEQUENCE set FLAG_TEXT='''+flag+''',SEQU_NO='+Inttostr(Temp.FieldbyName('SEQU_NO').AsInteger+n)+' where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''';
         end;
      AFactor.ExecSQL(Str);
      AFactor.CommitTrans;
    except
      AFactor.RollbackTrans;
      Raise;
    end;
  finally
    Temp.Free;
  end;
end;

class function TSequence.NewId: string;
var g:TGuid;
begin
  if CreateGUID(g)=S_OK then
  begin
    result :=trim(GuidToString(g));
    result :=Copy(result,2,length(result)-2);  //去掉"{}"
  end else
    result :=token.shopId+'_'+formatDatetime('YYYYMMDDHHNNSS',now());
end;

class function TSequence.TryGetSequence(SEQU_ID, TENANT_ID, FLAG_TEXT: string; nLen, Number: Integer): string;
  function GetFormat:string;
  var i:Integer;
  begin
    result := '';
    for i:=1 to nLen do
      result := result +'0';
  end;
var Temp:TZQuery;
    Str,flag:string;
    InTrans:Boolean;
begin
  InTrans := dataFactory.InTransaction;
  Temp := TZQuery.Create(nil);
  try
    if not InTrans then dataFactory.BeginTrans(10);
    try
      case dataFactory.iDbType of
      0:Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE with (UPDLOCK) where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' ';
      1:Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' FOR UPDATE';
      4:Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' FOR UPDATE WITH RS ';
      3,5:
        begin
          //Factor.ExecSQL('update SYS_SEQUENCE set SEQU_NO=SEQU_NO+1 where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''');
          Temp.SQL.Text := 'select FLAG_TEXT,SEQU_NO+1 from SYS_SEQUENCE where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+''' ';
        end;
      end;
      dataFactory.Open(Temp);
      if Temp.IsEmpty then
        begin
          result := FLAG_TEXT+FormatFloat(GetFormat,1);
          Str := 'insert into SYS_SEQUENCE(TENANT_ID,SEQU_ID,FLAG_TEXT,SEQU_NO,COMM,TIME_STAMP) values('+TENANT_ID+','''+SEQU_ID+''','''+FLAG_TEXT+''','+Inttostr(Number)+',''00'','+TSequence.GetTimeStamp(dataFactory.iDbType)+')';
        end
      else
      if (Temp.FieldbyName('FLAG_TEXT').AsString<FLAG_TEXT) then
         begin
           result := FLAG_TEXT+FormatFloat(GetFormat,1);
           Str := 'update SYS_SEQUENCE set FLAG_TEXT='''+FLAG_TEXT+''',SEQU_NO='+Inttostr(Number)+' where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''';
         end
      else
         begin
           if Temp.FieldbyName('FLAG_TEXT').AsString=FLAG_TEXT then
              flag := FLAG_TEXT
           else
              flag := Temp.FieldbyName('FLAG_TEXT').AsString;
           if (dataFactory.iDbType=3) or (dataFactory.iDbType=5) then
              begin
                result := flag+FormatFloat(GetFormat,Temp.FieldbyName('SEQU_NO').AsInteger);
                Number := 0;
              end
           else
              result := flag+FormatFloat(GetFormat,Temp.FieldbyName('SEQU_NO').AsInteger+1);
           Str := 'update SYS_SEQUENCE set FLAG_TEXT='''+flag+''',SEQU_NO='+Inttostr(Temp.FieldbyName('SEQU_NO').AsInteger+Number)+' where TENANT_ID='+TENANT_ID+' and SEQU_ID='''+SEQU_ID+'''';
         end;
      //Factor.ExecSQL(Str);
      if not InTrans then dataFactory.CommitTrans;
    except
      if not InTrans then dataFactory.RollbackTrans;
      Raise;
    end;
  finally
    Temp.Free;
  end;
end;

{ TBatchSQLFactory }

constructor TBatchSQLFactory.Create;
begin
  RsExeSQL:=TZQuery.Create(nil);
  DoCreateDataSet;
end;

destructor TBatchSQLFactory.Destroy;
begin
  RsExeSQL.Close;
  RsExeSQL.Free;
  inherited;
end;

function TBatchSQLFactory.AppendSQL(SQLStr: WideString): Boolean;
var
  RecNo:integer;
  Sql:WideString;
begin
  result:=false;
  Sql:=trim(SQLStr);
  RecNo:=RsExeSQL.RecordCount+1;
  RsExeSQL.Append;
  RsExeSQL.FieldByName('SEQ_NO').AsInteger:=RecNo;
  RsExeSQL.FieldByName('SQL01').AsString:=GetFieldSQL(Sql, 1);
  RsExeSQL.FieldByName('SQL02').AsString:=GetFieldSQL(Sql, 2);
  RsExeSQL.FieldByName('SQL03').AsString:=GetFieldSQL(Sql, 3);
  RsExeSQL.FieldByName('SQL04').AsString:=GetFieldSQL(Sql, 4);
  RsExeSQL.FieldByName('SQL05').AsString:=GetFieldSQL(Sql, 5);
  RsExeSQL.FieldByName('SQL06').AsString:=GetFieldSQL(Sql, 6);
  RsExeSQL.FieldByName('SQL07').AsString:=GetFieldSQL(Sql, 7);
  RsExeSQL.FieldByName('SQL08').AsString:=GetFieldSQL(Sql, 8);
  RsExeSQL.FieldByName('SQL09').AsString:=GetFieldSQL(Sql, 9);
  RsExeSQL.FieldByName('SQL10').AsString:=GetFieldSQL(Sql,10);
  RsExeSQL.FieldByName('SQL11').AsString:=GetFieldSQL(Sql,11);
  RsExeSQL.FieldByName('SQL12').AsString:=GetFieldSQL(Sql,12);
  RsExeSQL.FieldByName('SQL13').AsString:=GetFieldSQL(Sql,13);
  RsExeSQL.FieldByName('SQL14').AsString:=GetFieldSQL(Sql,14);
  RsExeSQL.FieldByName('SQL15').AsString:=GetFieldSQL(Sql,15);
  RsExeSQL.FieldByName('SQL16').AsString:=GetFieldSQL(Sql,16);
  RsExeSQL.Post;
  result:=true;
end;

function TBatchSQLFactory.DoClearSQL: Boolean;
begin
  result:=false;
  RsExeSQL.First;
  while not RsExeSQL.Eof do
    begin
      RsExeSQL.Delete;
    end;
  result:=true;
end;

function TBatchSQLFactory.DoCreateDataSet: Boolean;
begin
  result:=false;
  RsExeSQL.Close;
  RsExeSQL.FieldDefs.Add('SEQ_NO',ftInteger,0,true);
  RsExeSQL.FieldDefs.Add('SQL01',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL02',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL03',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL04',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL05',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL06',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL07',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL08',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL09',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL10',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL11',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL12',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL13',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL14',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL15',ftstring,250,true);
  RsExeSQL.FieldDefs.Add('SQL16',ftstring,250,true);
  RsExeSQL.CreateDataSet;
  result:=RsExeSQL.Active;
end;

function TBatchSQLFactory.DoExecSQLComand(vFactor: TdbFactory): Boolean;
begin
  result:=false;
  if RsExeSQL.State in [dsInsert,dsEdit] then RsExeSQL.Post;
  if (RsExeSQL.RecordCount>0) and (vFactor<>nil) and (vFactor.Connected) then
     begin
       result:=vFactor.UpdateBatch(RsExeSQL,'TDoBatchExecSQL');
     end;
end;

function TBatchSQLFactory.GetFieldSQL(Sql: string; FieldIdx: integer): string;
var BegIdx:integer;
begin
  result:='';
  BegIdx:=(FieldIdx-1)*250+1;
  if Length(Sql)>=BegIdx then result := Copy(Sql,BegIdx,250);
end;

end.
