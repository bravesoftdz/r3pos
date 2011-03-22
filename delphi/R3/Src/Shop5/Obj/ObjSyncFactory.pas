unit ObjSyncFactory;

interface
uses Dialogs,SysUtils,zBase,Variants,Classes,DB,ZIntf,ZDataset,ObjCommon,ZDbcCache,ZDbcIntfs;
type
  //0 synFlag
  TSyncSingleTable=class(TZFactory)
  private
    InsertQuery:TZQuery;
    UpdateQuery:TZQuery;
    COMMIdx:integer;
    TIME_STAMPIdx:integer;
    Init:boolean;
    procedure InitSQL(AGlobal: IdbHelp);
    function GetRowAccessor: TZRowAccessor;
  public
    function CheckUnique(s:string):boolean;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //初始化
    procedure InitClass;override;
    property RowAccessor:TZRowAccessor read GetRowAccessor;
  end;
  //1 synFlag
  TSyncCaRelations=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //2 synFlag
  TSyncCaRelationInfo=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //3 synFlag
  TSyncPubBarcode=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation

{ TSyncSingleTable }

{ TSyncSingleTable }

function TSyncSingleTable.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure FillParams(ZQuery:TZQuery);
var
  i:integer;
  WasNull:boolean;
  Comm:string;
begin
  for i:= 0 to RowAccessor.ColumnCount-1 do
    begin
      case RowAccessor.GetColumnType(i+1) of
      stBoolean:
        begin
          ZQuery.Params[i].AsBoolean := RowAccessor.GetBoolean(i+1,WasNull);
        end;
      stShort,stByte:
        begin
          ZQuery.Params[i].AsSmallInt := RowAccessor.GetShort(i+1,WasNull);
        end;
      stInteger:
        begin
          ZQuery.Params[i].AsInteger := RowAccessor.GetInt(i+1,WasNull);
        end;
      stLong:
        begin
          ZQuery.Params[i].Value := RowAccessor.GetLong(i+1,WasNull);
        end;
      stFloat,stDouble,stBigDecimal:
        begin
          ZQuery.Params[i].AsFloat := RowAccessor.GetBigDecimal(i+1,WasNull);
        end;
      stString:
        begin
          ZQuery.Params[i].AsString := RowAccessor.GetString(i+1,WasNull);
        end;
      stUnicodeString,stUnicodeStream:
        begin
          ZQuery.Params[i].AsString := RowAccessor.GetUnicodeString(i+1,WasNull);
        end;
      stBytes:
        begin
          ZQuery.Params[i].AsString := RowAccessor.GetString(i+1,WasNull);
        end;
      stDate,stTime,stTimestamp:
        begin
          ZQuery.Params[i].AsDateTime := RowAccessor.GetTimestamp(i+1,WasNull);
        end;
      stAsciiStream,stBinaryStream:
        begin
          ZQuery.Params[i].AsBlob := RowAccessor.GetString(i+1,WasNull);
        end
      else
        Raise Exception.Create('不支持的数据类型');
      end;
      if i=(COMMIdx-1) then //把通讯标志位改为 1
         begin
           Comm := ZQuery.Params[i].AsString;
           Comm[1] := '1';
           ZQuery.Params[i].AsString := Comm;
         end;
      if WasNull then ZQuery.Params[i].Value := null;
    end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if Comm='00' then
     begin
       FillParams(InsertQuery);
       try
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       FillParams(UpdateQuery);
       r := AGlobal.ExecQuery(UpdateQuery);
       if r=0 then
          begin
            FillParams(InsertQuery);
            try
              AGlobal.ExecQuery(InsertQuery);
            except
               on E:Exception do
                  begin
                    if not CheckUnique(E.Message) then
                       Raise;
                  end;
            end;
          end;
     end;

end;

function TSyncSingleTable.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

function TSyncSingleTable.CheckUnique(s: string): boolean;
begin
  result :=
    (pos('unique',lowercase(s))>0)
    or
    (pos('primary',lowercase(s))>0);
end;

function TSyncSingleTable.GetRowAccessor: TZRowAccessor;
begin
  if assigned(DataSet) and assigned(TZQuery(DataSet).UpdateObject) then
     result := TZQuery(DataSet).UpdateObject.ZNewRowAccessor
  else
     Raise Exception.Create('没有指定同步对像，不能完成同步操作.');
end;

procedure TSyncSingleTable.InitClass;
begin
  inherited;
  Init := false;
  InsertQuery := nil;
  UpdateQuery := nil;
end;

procedure TSyncSingleTable.InitSQL(AGlobal: IdbHelp);
var
  i:integer;
  InsertFld,UpdateFld,ValueFld,WhereStr:string;
  KeyFields:TStringList;
begin
  if Init then Exit;
  for i:=1 to RowAccessor.ColumnCount do
    begin
      if InsertFld<>'' then InsertFld := InsertFld + ',';
      InsertFld := InsertFld+RowAccessor.GetColumnName(i);
      if ValueFld<>'' then ValueFld := ValueFld + ',';
      ValueFld := ValueFld+':'+RowAccessor.GetColumnName(i);
      if UpdateFld<>'' then UpdateFld := UpdateFld + ',';
      UpdateFld := UpdateFld+RowAccessor.GetColumnName(i)+'=:'+RowAccessor.GetColumnName(i);
      if RowAccessor.GetColumnName(i)='COMM' then
         COMMIdx := i;
      if RowAccessor.GetColumnName(i)='TIME_STAMP' then
         TIME_STAMPIdx := i;
    end;
  KeyFields:=TStringList.Create;
  try
    KeyFields.Delimiter := ';';
    KeyFields.DelimitedText := Params.ParambyName('KEY_FIELDS').AsString;
    for i:=0 to KeyFields.Count -1 do
      begin
        if WhereStr<>'' then WhereStr := WhereStr + ' and ';
        WhereStr := WhereStr+KeyFields[i]+'=:'+KeyFields[i];
      end;
  finally
    KeyFields.Free;
  end;

  InsertQuery := TZQuery.Create(nil);
  InsertQuery.SQL.Text := 'insert into '+Params.ParambyName('TABLE_NAME').AsString+'('+InsertFld+') values('+ValueFld+')';
  UpdateQuery := TZQuery.Create(nil);
  UpdateQuery.SQL.Text := 'update '+Params.ParambyName('TABLE_NAME').AsString+' set '+UpdateFld+' where '+WhereStr+' and TIME_STAMP<=:TIME_STAMP';

  Init := true;
end;

{ TSyncCaRelations }

function TSyncCaRelations.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where (TENANT_ID=:TENANT_ID or RELATI_ID=:TENANT_ID) and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncCaRelation }

function TSyncCaRelationInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select j.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' j,CA_RELATION b where j.TENANT_ID=b.TENANT_ID and b.RELATION_ID in (select RELATION_ID from CA_RELATIONS where RELATI_ID=:TENANT_ID) and j.TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(j.COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncPubBarcode }

function TSyncPubBarcode.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select j.* from '+Params.ParambyName('TABLE_NAME').AsString+ ' j,PUB_GOODS_RELATION b where j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID and b.RELATION_ID in (select RELATION_ID from CA_RELATIONS where RELATI_ID=:TENANT_ID) and j.TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(j.COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

initialization
  RegisterClass(TSyncSingleTable);
  RegisterClass(TSyncCaRelationInfo);
  RegisterClass(TSyncCaRelations);
  RegisterClass(TSyncPubBarcode);
finalization
  UnRegisterClass(TSyncSingleTable);
  UnRegisterClass(TSyncCaRelationInfo);
  UnRegisterClass(TSyncCaRelations);
  UnRegisterClass(TSyncPubBarcode);
end.
