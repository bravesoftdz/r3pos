unit ObjSyncFactory;

interface
uses Dialogs,SysUtils,zBase,Variants,Classes,DB,ZIntf,ZDataset,ObjCommon,ZDbcCache,ZDbcIntfs,Math;
type
  //0 synFlag
  TSyncSingleTable=class(TZFactory)
  private
    InsertQuery:TZQuery;
    UpdateQuery:TZQuery;
    COMMIdx:integer;
    TIME_STAMPIdx:integer;
    Init:boolean;
    FMaxCol: integer;
    procedure SetMaxCol(const Value: integer);
  protected
    procedure InitSQL(AGlobal: IdbHelp);virtual;
    function GetRowAccessor: TZRowAccessor;
    procedure FillParams(ZQuery: TZQuery);virtual;
  public
    function CheckUnique(s:string):boolean;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //初始化
    procedure InitClass;override;
    property RowAccessor:TZRowAccessor read GetRowAccessor;
    property MaxCol:integer read FMaxCol write SetMaxCol;
  end;
  //1 synFlag
  TSyncCaRelations=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //2 synFlag
  TSyncCaRelationInfo=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //3 synFlag
  TSyncPubBarcode=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //4 synFlag
  TSyncPubIcInfo=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //5 synFlag
  TSyncStockOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncStockOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncStockData=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //6 synFlag
  TSyncSalesOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSalesOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSalesData=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //7 synFlag
  TSyncChangeOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncChangeOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncChangeData=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //8 synFlag
  TSyncStkIndentOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncStkIndentOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncStkIndentData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //9 synFlag
  TSyncSalIndentOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSalIndentOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncSalIndentData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  //10 synFlag
  TSyncAccountInfo=class(TSyncSingleTable)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  //11 synFlag
  TSyncIoroOrderList=class(TZFactory)
  public
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncIoroOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  TSyncIoroData=class(TSyncSingleTable)
  public
    //当使用此事件,Applied 返回true 时，以上三个检测函数无效，所有更数据库逻辑都由此函数完成。
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
     //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
  end;
  //12 synFlag
  TSyncTransOrder=class(TSyncSingleTable)
  public
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    //记录行集新增检测函数，返回值是True 测可以新增当前记录
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    //读取SelectSQL之前，通常用于处理 SelectSQL
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;
implementation

{ TSyncSingleTable }

function TSyncSingleTable.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP'),Params);
end;

procedure TSyncSingleTable.FillParams(ZQuery:TZQuery);
var
  i:integer;
  WasNull:boolean;
  Comm:string;
begin
  if MaxCol=0 then MaxCol := RowAccessor.ColumnCount;
  for i:= 0 to MaxCol-1 do
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
function TSyncSingleTable.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
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
    (pos('primary',lowercase(s))>0)
    or
    (pos('sql0803',lowercase(s))>0)
    or
    (pos('主健',s)>0)
    or
    (pos('唯一约束',s)>0);
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
  if MaxCol=0 then MaxCol := RowAccessor.ColumnCount;
  for i:=1 to MaxCol do
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

procedure TSyncSingleTable.SetMaxCol(const Value: integer);
begin
  FMaxCol := Value;
end;

{ TSyncCaRelations }

function TSyncCaRelations.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where (TENANT_ID=:TENANT_ID or RELATI_ID=:TENANT_ID) and TIME_STAMP>:TIME_STAMP'),Params);
end;

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

function TSyncCaRelationInfo.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where (TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID) or TENANT_ID=:TENANT_ID) and TIME_STAMP>:TIME_STAMP'),Params);
end;

function TSyncCaRelationInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where (TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID) or TENANT_ID=:TENANT_ID) and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncPubBarcode }

function TSyncPubBarcode.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) '+
    'where (('+
    '(TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID)) and Exists(select * from PUB_GOODS_RELATION where TENANT_ID='+Params.ParambyName('TABLE_NAME').AsString+'.TENANT_ID and GODS_ID='+Params.ParambyName('TABLE_NAME').AsString+'.GODS_ID) '+
    ')or TENANT_ID=:TENANT_ID) and TIME_STAMP>:TIME_STAMP'),Params);
end;

function TSyncPubBarcode.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' b where (('+
  '(TENANT_ID in (select j.TENANT_ID from CA_RELATION j,CA_RELATIONS s where j.RELATION_ID=s.RELATION_ID and s.RELATI_ID=:TENANT_ID)) and Exists(select * from PUB_GOODS_RELATION where TENANT_ID=b.TENANT_ID and GODS_ID=b.GODS_ID) '+
  ' ) or TENANT_ID=:TENANT_ID) and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncPubIcInfo }

function TSyncPubIcInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select CLIENT_ID,TENANT_ID,UNION_ID,IC_CARDNO,CREA_DATE,END_DATE,CREA_USER,IC_INFO,IC_STATUS,IC_TYPE,PASSWRD,USING_DATE,COMM,TIME_STAMP from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncStockOrder }

function TSyncStockOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID'),self);
end;

function TSyncStockOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAbleInfo;
var rs:TZQuery;
begin
   if (FieldbyName('STOCK_MNY').AsFloat <> 0) and (FieldbyName('STOCK_TYPE').asInteger in [1,3]) then
   begin
     if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text :=
         'insert into ACC_PAYABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,ABLE_TYPE,ACCT_MNY,PAYM_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,STOCK_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES(:ABLE_ID,:TENANT_ID,:SHOP_ID,:CLIENT_ID,:ACCT_INFO,:ABLE_TYPE,:STOCK_MNY,0,:ADVA_MNY,:RECK_MNY,:STOCK_DATE,:STOCK_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
       CopyToParams(rs.Params);
       if FieldbyName('STOCK_TYPE').asString='1' then
          begin
            rs.ParambyName('ABLE_TYPE').AsString := '4';
            rs.ParambyName('ACCT_INFO').AsString := '进货货款【单号'+FieldbyName('GLIDE_NO').AsString+'】';
          end
       else
       if FieldbyName('STOCK_TYPE').asString='3' then
          begin
            rs.ParambyName('ABLE_TYPE').AsString := '5';
            rs.ParambyName('ACCT_INFO').AsString := '进货退款【单号'+FieldbyName('GLIDE_NO').AsString+'】';
          end;
       rs.ParambyName('ABLE_ID').AsString := newid(FieldbyName('SHOP_ID').asString);
       rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('STOCK_MNY').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
       AGlobal.ExecQuery(rs);
     finally
       rs.Free;
     end;
   end;
end;
procedure UpdateAbleInfo;
var rs:TZQuery;
begin
   if (FieldbyName('STOCK_TYPE').asInteger in [1,3]) then
   begin
     if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text :=
         'update ACC_PAYABLE_INFO set ACCT_MNY=:STOCK_MNY,REVE_MNY=:ADVA_MNY,RECK_MNY=:RECK_MNY-PAYM_MNY,SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:STOCK_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '
       + 'where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID';
       CopyToParams(rs.Params);
//       rs.ParambyName('ABLE_ID').AsString := newid(FieldbyName('SHOP_ID').asString);
       rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('STOCK_MNY').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
       AGlobal.ExecQuery(rs);
     finally
       rs.Free;
     end;
   end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_STOCKORDER';
     end;
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if Comm='00' then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                   UpdateAbleInfo;
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
       if r<>0 then UpdateAbleInfo;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
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

function TSyncStockOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from STK_STOCKORDER where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID';
  SelectSQL.Text := Str;
end;

{ TSyncStockData }

function TSyncStockData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertStorageInfo;
begin
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             FieldbyName('CALC_MONEY').asFloat-roundto(FieldbyName('CALC_MONEY').asFloat/(1+FieldbyName('TAX_RATE').AsFloat)*FieldbyName('TAX_RATE').AsFloat,-2),1);
end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_STOCKDATA';
       MaxCol := RowAccessor.ColumnCount-1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertStorageInfo;
end;

function TSyncStockData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.*,b.TAX_RATE as TAX_RATE from STK_STOCKDATA a,STK_STOCKORDER b where a.TENANT_ID=b.TENANT_ID and a.STOCK_ID=b.STOCK_ID and a.TENANT_ID=:TENANT_ID and a.STOCK_ID=:STOCK_ID';
  SelectSQL.Text := Str;
end;

function TSyncStockData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,a.SHOP_ID,a.GODS_ID,a.PROPERTY_01,a.PROPERTY_02,a.BATCH_NO,a.CALC_AMOUNT,a.CALC_MONEY,b.TAX_RATE as TAX_RATE '+
       'from STK_STOCKDATA a,STK_STOCKORDER b where a.TENANT_ID=b.TENANT_ID and a.STOCK_ID=b.STOCK_ID and a.TENANT_ID=:TENANT_ID and a.STOCK_ID=:STOCK_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        DecStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                   rs.FieldbyName('GODS_ID').asString,
                   rs.FieldbyName('PROPERTY_01').asString,
                   rs.FieldbyName('PROPERTY_02').asString,
                   rs.FieldbyName('BATCH_NO').asString,
                   rs.FieldbyName('CALC_AMOUNT').asFloat,
                   rs.FieldbyName('CALC_MONEY').asFloat-roundto(rs.FieldbyName('CALC_MONEY').asFloat/(1+rs.FieldbyName('TAX_RATE').asFloat)*rs.FieldbyName('TAX_RATE').asFloat,-2),3);
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from STK_STOCKDATA where TENANT_ID=:TENANT_ID and STOCK_ID=:STOCK_ID',Params);
  finally
    rs.Free;
  end;
end;

{ TSyncSalesOrder }

function TSyncSalesOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID'),self);
end;

function TSyncSalesOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAbleInfo;
var rs:TZQuery;
begin
   if (FieldbyName('PAY_D').AsFloat <> 0) and (FieldbyName('SALES_TYPE').AsInteger in [1,3,4]) then
   begin
     if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text :=
         'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES(:ABLE_ID,:TENANT_ID,:SHOP_ID,:CLIENT_ID,:ACCT_INFO,:RECV_TYPE,:PAY_D,0,:ADVA_MNY,:RECK_MNY,:SALES_DATE,:SALES_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')';
       CopyToParams(rs.Params);
       case FieldbyName('SALES_TYPE').AsInteger of
       1,4: begin
            rs.ParambyName('RECV_TYPE').AsString := '1';
            rs.ParambyName('ACCT_INFO').AsString := '销售货款【单号'+FieldbyName('GLIDE_NO').AsString+'】';
          end;
       3:   begin
            rs.ParambyName('RECV_TYPE').AsString := '2';
            rs.ParambyName('ACCT_INFO').AsString := '销售退款【单号'+FieldbyName('GLIDE_NO').AsString+'】';
          end;
       end;
       rs.ParambyName('ABLE_ID').AsString := newid(FieldbyName('SHOP_ID').asString);
       rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
       AGlobal.ExecQuery(rs);
     finally
       rs.Free;
     end;
   end;
end;
procedure InsertIntegralInfo;
var rs:TZQuery;
begin
  //更新积分
  if length(FieldbyName('CLIENT_ID').AsString)>0 then
  begin
     if (FieldbyName('BARTER_INTEGRAL').AsInteger<>0) or (FieldbyName('INTEGRAL').AsInteger<>0) then //扣减换购积分
     begin
      rs := TZQuery.Create(nil);
      try
        rs.SQL.Text :=
        ParseSQL(idbType,
        'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) + :RULE_INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) + :ACCU_INTEGRAL  '+
        ' where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID');
        rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
        rs.ParamByName('CLIENT_ID').AsString := FieldbyName('CLIENT_ID').AsString;
        rs.ParamByName('INTEGRAL').AsInteger := FieldbyName('BARTER_INTEGRAL').AsInteger-FieldbyName('INTEGRAL').AsInteger;
        rs.ParamByName('ACCU_INTEGRAL').AsInteger := FieldbyName('INTEGRAL').AsInteger;
        rs.ParamByName('RULE_INTEGRAL').AsInteger := FieldbyName('BARTER_INTEGRAL').AsInteger;
        AGlobal.ExecQuery(rs);
      finally
        rs.Free;
      end;
     end;
  end;
end;
procedure UpdateAbleInfo;
var rs:TZQuery;
begin
   if (FieldbyName('PAY_D').AsFloat <> 0) and (FieldbyName('SALES_TYPE').AsInteger in [1,3,4]) then
   begin
     if FieldbyName('ADVA_MNY').AsString = '' then FieldbyName('ADVA_MNY').AsFloat := 0;
     rs := TZQuery.Create(nil);
     try
       rs.SQL.Text :=
         'update ACC_RECVABLE_INFO set ACCT_MNY=:PAY_D,REVE_MNY=:ADVA_MNY,RECK_MNY=:RECK_MNY-RECV_MNY,SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:SALES_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '
       + 'where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
       CopyToParams(rs.Params);
//       rs.ParambyName('ABLE_ID').AsString := newid(FieldbyName('SHOP_ID').asString);
       rs.ParambyName('RECK_MNY').AsFloat := FieldbyName('PAY_D').AsFloat-FieldbyName('ADVA_MNY').AsFloat;
       AGlobal.ExecQuery(rs);
     finally
       rs.Free;
     end;
   end;
end;
function UpdateIntegralInfo:boolean;
var
  rs:TZQuery;
  Params:TftParamList;
begin
  rs := TZQuery.Create(nil);
  Params := TftParamList.Create(nil);
  try
    rs.SQL.Text := 'select INTEGRAL,BARTER_INTEGRAL,CLIENT_ID,SALES_TYPE from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
    rs.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
    rs.ParamByName('SALES_ID').AsString := FieldbyName('SALES_ID').AsString;
    AGlobal.Open(rs);
    result := not rs.IsEmpty;
    if result and (rs.FieldByName('SALES_TYPE').AsInteger in [1,3,4]) then
    begin
      if (rs.Fields[0].AsInteger <> 0) or (rs.Fields[1].AsInteger <> 0) then
         begin
           Params.ParamByName('TENANT_ID').AsInteger := FieldbyName('TENANT_ID').AsInteger;
           Params.ParamByName('CLIENT_ID').AsString := rs.FieldbyName('CLIENT_ID').AsString;
           Params.ParamByName('INTEGRAL').AsInteger := rs.FieldbyName('INTEGRAL').AsInteger-rs.FieldbyName('BARTER_INTEGRAL').AsInteger;
           Params.ParamByName('ACCU_INTEGRAL').AsInteger := rs.FieldbyName('INTEGRAL').AsInteger;
           Params.ParamByName('RULE_INTEGRAL').AsInteger := rs.FieldbyName('BARTER_INTEGRAL').AsInteger;
           AGlobal.ExecSQL(
             'update PUB_IC_INFO set INTEGRAL=IsNull(INTEGRAL,0)- :INTEGRAL,RULE_INTEGRAL=IsNull(RULE_INTEGRAL,0) - :RULE_INTEGRAL,ACCU_INTEGRAL=IsNull(ACCU_INTEGRAL,0) - :ACCU_INTEGRAL  '+
             'where TENANT_ID=:TENANT_ID and UNION_ID=''#'' and CLIENT_ID=:CLIENT_ID',Params);
         end;
      //更新积分
      InsertIntegralInfo;
    end;
  finally
    Params.Free;
    rs.Free;
  end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_SALESORDER';
     end;
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if Comm='00' then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
         InsertIntegralInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if UpdateIntegralInfo then
                      begin
                        UpdateAbleInfo;
                        FillParams(UpdateQuery);
                        AGlobal.ExecQuery(UpdateQuery);
                      end
                   else
                      Raise;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       if UpdateIntegralInfo then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
         if r<>0 then UpdateAbleInfo;
       end
       else
         r := 0;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
              InsertIntegralInfo;
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

function TSyncSalesOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SAL_SALESORDER where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
  SelectSQL.Text := Str;
end;

{ TSyncSalesData }

function TSyncSalesData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertStorageInfo;
begin
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('COST_PRICE').asFloat*FieldbyName('CALC_AMOUNT').asFloat,-2),2);

end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_SALESDATA';
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertStorageInfo;
end;

function TSyncSalesData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SAL_SALESDATA where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID';
  SelectSQL.Text := Str;
end;

function TSyncSalesData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,a.SHOP_ID,a.GODS_ID,a.PROPERTY_01,a.PROPERTY_02,a.BATCH_NO,a.CALC_AMOUNT,a.COST_PRICE '+
       'from SAL_SALESDATA a where a.TENANT_ID=:TENANT_ID and a.SALES_ID=:SALES_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        IncStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                   rs.FieldbyName('GODS_ID').asString,
                   rs.FieldbyName('PROPERTY_01').asString,
                   rs.FieldbyName('PROPERTY_02').asString,
                   rs.FieldbyName('BATCH_NO').asString,
                   rs.FieldbyName('CALC_AMOUNT').asFloat,
                   roundto(rs.FieldbyName('COST_PRICE').asFloat*rs.FieldbyName('CALC_AMOUNT').asFloat,2),3);
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from SAL_SALESDATA where TENANT_ID=:TENANT_ID and SALES_ID=:SALES_ID',Params);
  finally
    rs.Free;
  end;
end;

{ TSyncChangeOrder }

function TSyncChangeOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID'),self);
end;

function TSyncChangeOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_CHANGEORDER';
     end;
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if Comm='00' then
     begin
       try
         FillParams(InsertQuery);
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
            try
              FillParams(InsertQuery);
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

function TSyncChangeOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID';
  SelectSQL.Text := Str;
end;

{ TSyncChangeData }

function TSyncChangeData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertStorageInfo;
begin
  if FieldbyName('BATCH_NO').asString='' then FieldbyName('BATCH_NO').asString := '#';
  if FieldbyName('CHANGE_TYPE').AsString = '1' then
  IncStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,2),1)
  else
  DecStorage(AGlobal,FieldbyName('TENANT_ID').asString,FieldbyName('SHOP_ID').asString,
             FieldbyName('GODS_ID').asString,
             FieldbyName('PROPERTY_01').asString,
             FieldbyName('PROPERTY_02').asString,
             FieldbyName('BATCH_NO').asString,
             FieldbyName('CALC_AMOUNT').asFloat,
             roundto(FieldbyName('CALC_AMOUNT').asFloat*FieldbyName('COST_PRICE').AsFloat,2),1);
end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STO_CHANGEDATA';
       MaxCol := RowAccessor.ColumnCount-1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertStorageInfo;
end;

function TSyncChangeData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.*,b.CHANGE_TYPE as CHANGE_TYPE from STO_CHANGESDATA a,STO_CHANGESORDER b where a.TENANT_ID=b.TENANT_ID and a.CHANGE_ID=b.CHANGE_ID and a.TENANT_ID=:TENANT_ID and a.CHANGE_ID=:CHANGE_ID';
  SelectSQL.Text := Str;
end;

function TSyncChangeData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,a.SHOP_ID,a.GODS_ID,a.PROPERTY_01,a.PROPERTY_02,a.BATCH_NO,a.CALC_AMOUNT,a.COST_PRICE,b.CHANGE_TYPE as CHANGE_TYPE from STO_CHANGESDATA a,STO_CHANGESORDER b where a.TENANT_ID=b.TENANT_ID and a.CHANGE_ID=b.CHANGE_ID '+
       'where a.TENANT_ID=:TENANT_ID and a.CHANGE_ID=:CHANGE_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        if FieldbyName('CHANGE_TYPE').AsString = '1' then
        DecStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                   rs.FieldbyName('GODS_ID').asString,
                   rs.FieldbyName('PROPERTY_01').asString,
                   rs.FieldbyName('PROPERTY_02').asString,
                   rs.FieldbyName('BATCH_NO').asString,
                   rs.FieldbyName('CALC_AMOUNT').asFloat,
                   roundto(rs.FieldbyName('CALC_AMOUNT').asFloat*rs.FieldbyName('COST_PRICE').asFloat,2),3)
        else
        IncStorage(AGlobal,rs.FieldbyName('TENANT_ID').asString,rs.FieldbyName('SHOP_ID').asString,
                   rs.FieldbyName('GODS_ID').asString,
                   rs.FieldbyName('PROPERTY_01').asString,
                   rs.FieldbyName('PROPERTY_02').asString,
                   rs.FieldbyName('BATCH_NO').asString,
                   rs.FieldbyName('CALC_AMOUNT').asFloat,
                   roundto(rs.FieldbyName('CALC_AMOUNT').asFloat*rs.FieldbyName('COST_PRICE').asFloat,2),3);
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from STO_CHANGESDATA where TENANT_ID=:TENANT_ID and CHANGE_ID=:CHANGE_ID',Params);
  finally
    rs.Free;
  end;
end;

{ TSyncStkIndentOrder }

function TSyncStkIndentOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID'),self);
end;

function TSyncStkIndentOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAbleInfo;
begin
   if (FieldbyName('ADVA_MNY').AsFloat <> 0) then
   begin
     AGlobal.ExecSQL(
         'insert into ACC_PAYABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,ABLE_TYPE,ACCT_MNY,PAYM_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,STOCK_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES('''+newid(FieldbyName('SHOP_ID').AsString)+''',:TENANT_ID,:SHOP_ID,:CLIENT_ID,'''+'预付款【订单号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''6'',:ADVA_MNY,0,0,:ADVA_MNY,:INDE_DATE,:INDE_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
    ,self);
   end;
end;
procedure UpdateAbleInfo;
var
   rs:TZQuery;
begin
   rs := TZQuery.Create(nil);
   try
     rs.SQL.Text :=
       'update ACC_PAYABLE_INFO set ACCT_MNY=:ADVA_MNY,RECK_MNY=:ADVA_MNY-PAYM_MNY,SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:INDE_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '
     + 'where TENANT_ID=:TENANT_ID and STOCK_ID=:INDE_ID';
     CopyToParams(rs.Params);
     AGlobal.ExecQuery(rs);
   finally
     rs.Free;
   end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_INDENTORDER';
     end;
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if Comm='00' then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                   UpdateAbleInfo;
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
       if r <>0 then UpdateAbleInfo;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
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

function TSyncStkIndentOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from STK_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID';
  SelectSQL.Text := Str;
end;

{ TSyncStkIndentData }

function TSyncStkIndentData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_INDENTDATA';
       MaxCol := RowAccessor.ColumnCount-1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncStkIndentData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.* from STK_INDENTDATA a where a.TENANT_ID=:TENANT_ID and a.INDE_ID=:INDE_ID';
  SelectSQL.Text := Str;
end;

function TSyncStkIndentData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from STK_INDENTDATA where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID',Params);
end;

{ TSyncStockOrderList }

function TSyncStockOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncSalesOrderList }

function TSyncSalesOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and (SHOP_ID=:SHOP_ID or CLIENT_ID=:SHOP_ID) and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncChangeOrderList }

function TSyncChangeOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncStkIndentOrderList }

function TSyncStkIndentOrderList.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncSalIndentOrderList }

function TSyncSalIndentOrderList.BeforeOpenRecord(
  AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncSalIndentOrder }

function TSyncSalIndentOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID'),self);
end;

function TSyncSalIndentOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAbleInfo;
begin
   if (FieldbyName('ADVA_MNY').AsFloat <> 0) then
   begin
     AGlobal.ExecSQL(
         'insert into ACC_RECVABLE_INFO(ABLE_ID,TENANT_ID,SHOP_ID,CLIENT_ID,ACCT_INFO,RECV_TYPE,ACCT_MNY,RECV_MNY,REVE_MNY,RECK_MNY,ABLE_DATE,SALES_ID,CREA_DATE,CREA_USER,COMM,TIME_STAMP) '
       + 'VALUES('''+newid(FieldbyName('SHOP_ID').AsString)+''',:TENANT_ID,:SHOP_ID,:CLIENT_ID,'''+'预收款【订单号'+FieldbyName('GLIDE_NO').AsString+'】'+''',''3'',:ADVA_MNY,0,0,:ADVA_MNY,:INDE_DATE,:INDE_ID,:CREA_DATE,:CREA_USER,''00'','+GetTimeStamp(iDbType)+')'
    ,self);
   end;
end;
procedure UpdateAbleInfo;
var
   rs:TZQuery;
begin
   rs := TZQuery.Create(nil);
   try
     rs.SQL.Text :=
       'update ACC_RECVABLE_INFO set ACCT_MNY=:ADVA_MNY,RECK_MNY=:ADVA_MNY-PAYM_MNY,SHOP_ID=:SHOP_ID,CLIENT_ID=:CLIENT_ID,ABLE_DATE=:INDE_DATE,COMM='+GetCommStr(AGlobal.iDbType)+',TIME_STAMP='+GetTimeStamp(AGlobal.iDbType)+'  '
     + 'where TENANT_ID=:TENANT_ID and SALES_ID=:INDE_ID';
     CopyToParams(rs.Params);
     AGlobal.ExecQuery(rs);
   finally
     rs.Free;
   end;
end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'STK_INDENTORDER';
     end;
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if Comm='00' then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAbleInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   FillParams(UpdateQuery);
                   AGlobal.ExecQuery(UpdateQuery);
                   UpdateAbleInfo;
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
       if r <>0 then UpdateAbleInfo;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAbleInfo;
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

function TSyncSalIndentOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from SAL_INDENTORDER where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID';
  SelectSQL.Text := Str;
end;

{ TSyncSalIndentData }

function TSyncSalIndentData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'SAL_INDENTDATA';
       MaxCol := RowAccessor.ColumnCount-1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncSalIndentData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select a.* from SAL_INDENTDATA a where a.TENANT_ID=:TENANT_ID and a.INDE_ID=:INDE_ID';
  SelectSQL.Text := Str;
end;

function TSyncSalIndentData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from SAL_INDENTDATA where TENANT_ID=:TENANT_ID and INDE_ID=:INDE_ID',Params);
end;

{ TSyncAccountInfo }

function TSyncAccountInfo.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select TENANT_ID,ACCOUNT_ID,SHOP_ID,ACCT_NAME,ACCT_SPELL,PAYM_ID,COMM,TIME_STAMP from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncIoroOrderList }

function TSyncIoroOrderList.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

{ TSyncIoroOrder }

function TSyncIoroOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and IORO_ID=:IORO_ID'),self);
end;

function TSyncIoroOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_IOROORDER';
     end;
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if Comm='00' then
     begin
       try
         FillParams(InsertQuery);
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
            try
              FillParams(InsertQuery);
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

function TSyncIoroOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str := 'select * from ACC_IOROORDER where TENANT_ID=:TENANT_ID and IORO_ID=:IORO_ID';
  SelectSQL.Text := Str;
end;

{ TSyncIoroData }

function TSyncIoroData.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAccountInfo;
begin
  case FieldbyName('IORO_TYPE').AsInteger of
  1:
  AGlobal.ExecSQL(
        ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set IN_MNY=isnull(IN_MNY,0)+:IORO_MNY,BALANCE=isnull(BALANCE,0)+:IORO_MNY,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),self);
  2:
  AGlobal.ExecSQL(
        ParseSQL(AGlobal.iDbType,
        'update ACC_ACCOUNT_INFO set OUT_MNY=isnull(OUT_MNY,0)+:IORO_MNY,BALANCE=isnull(BALANCE,0)-:IORO_MNY,'
      + 'COMM=' + GetCommStr(iDbType) + ','
      + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
      + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),self);
  end;
end;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_IORODATA';
       MaxCol := RowAccessor.ColumnCount - 1;
     end;
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
  InsertAccountInfo;
end;

function TSyncIoroData.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
       'select a.*,b.IORO_TYPE '+
       'from ACC_IORODATA a,b.ACC_IOROORDER b where a.TENANT_ID=b.TENANT_ID and a.IORO_ID=b.IORO_ID and a.TENANT_ID=:TENANT_ID and a.IORO_ID=:IORO_ID';
  SelectSQL.Text := Str;
end;

function TSyncIoroData.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
var
  rs:TZQuery;
  ftParams:TftParamList;
begin
  rs := TZQuery.Create(nil);
  ftParams := TftParamList.Create(nil);
  try
    rs.SQL.Text :=
       'select a.TENANT_ID,a.ACCOUNT_ID,a.IORO_MNY,b.IORO_TYPE '+
       'from ACC_IORODATA a,b.ACC_IOROORDER b where a.TENANT_ID=b.TENANT_ID and a.IORO_ID=b.IORO_ID and a.TENANT_ID=:TENANT_ID and a.IORO_ID=:IORO_ID';
    rs.Params.AssignValues(Params); 
    AGlobal.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        ftParams.ParamByName('TENANT_ID').AsInteger := rs.FieldbyName('TENANT_ID').AsInteger;
        ftParams.ParamByName('ACCOUNT_ID').AsString := rs.FieldbyName('ACCOUNT_ID').AsString;
        ftParams.ParamByName('IORO_MNY').AsFloat    := rs.FieldbyName('IORO_MNY').AsFloat;
        case rs.FieldbyName('IORO_TYPE').AsInteger of
        1:
        AGlobal.ExecSQL(
              ParseSQL(AGlobal.iDbType,
              'update ACC_ACCOUNT_INFO set IN_MNY=isnull(IN_MNY,0)-:IORO_MNY,BALANCE=isnull(BALANCE,0)-:IORO_MNY,'
            + 'COMM=' + GetCommStr(iDbType) + ','
            + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
            + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),ftParams);
        2:
        AGlobal.ExecSQL(
              ParseSQL(AGlobal.iDbType,
              'update ACC_ACCOUNT_INFO set OUT_MNY=isnull(OUT_MNY,0)-:IORO_MNY,BALANCE=isnull(BALANCE,0)+:IORO_MNY,'
            + 'COMM=' + GetCommStr(iDbType) + ','
            + 'TIME_STAMP='+GetTimeStamp(iDbType)+' '
            + 'where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:ACCOUNT_ID'),ftParams);
        end;
        rs.Next;
      end;
    AGlobal.ExecSQL('delete from ACC_IORODATA where TENANT_ID=:TENANT_ID and IORO_ID=:IORO_ID',Params);
  finally
    ftParams.Free;
    rs.Free;
  end;
end;

{ TSyncTransOrder}

function TSyncTransOrder.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and IORO_ID=:IORO_ID'),self);
end;

function TSyncTransOrder.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
procedure InsertAccountInfo;
var Str:string;
begin
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=:TRANS_MNY+ifnull(IN_MNY,0),BALANCE=:TRANS_MNY+ifnull(BALANCE,0),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:IN_ACCOUNT_ID  ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  Str := 'update ACC_ACCOUNT_INFO set OUT_MNY=:TRANS_MNY+ifnull(OUT_MNY,0),BALANCE=ifnull(BALANCE,0)-:TRANS_MNY,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:OUT_ACCOUNT_ID ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

end;
function UpdateAccountInfo:boolean;
var Str:string;
begin
  Str := 'update ACC_ACCOUNT_INFO set IN_MNY=:TRANS_MNY+ifnull(IN_MNY,0),BALANCE=:TRANS_MNY+ifnull(BALANCE,0),COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:IN_ACCOUNT_ID  ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

  Str := 'update ACC_ACCOUNT_INFO set OUT_MNY=:TRANS_MNY+ifnull(OUT_MNY,0),BALANCE=ifnull(BALANCE,0)-:TRANS_MNY,COMM='+GetCommStr(iDbType)+',TIME_STAMP='+GetTimeStamp(iDbType)+
  ' where TENANT_ID=:TENANT_ID and ACCOUNT_ID=:OUT_ACCOUNT_ID ';
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,Str),Self);

end;
var
  r:integer;
  WasNull:boolean;
  Comm:string;
begin
  if not Init then
     begin
       Params.ParamByName('TABLE_NAME').AsString := 'ACC_TRANSORDER';
     end;
  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if Comm='00' then
     begin
       try
         FillParams(InsertQuery);
         AGlobal.ExecQuery(InsertQuery);
         InsertAccountInfo;
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if UpdateAccountInfo then
                   begin
                     FillParams(UpdateQuery);
                     AGlobal.ExecQuery(UpdateQuery);
                   end
                   else
                     Raise;
                 end
              else
                 Raise;
            end;
       end;
     end
  else
     begin
       if UpdateAccountInfo then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
       end
       else
         r := 0;
       if r=0 then
          begin
            try
              FillParams(InsertQuery);
              AGlobal.ExecQuery(InsertQuery);
              InsertAccountInfo;
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

function TSyncTransOrder.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
begin
  Str :=
  'select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and TIME_STAMP>:TIME_STAMP';
  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str;
end;

initialization
  RegisterClass(TSyncSingleTable);
  RegisterClass(TSyncCaRelationInfo);
  RegisterClass(TSyncCaRelations);
  RegisterClass(TSyncPubBarcode);
  RegisterClass(TSyncPubIcInfo);
  RegisterClass(TSyncStockOrderList);
  RegisterClass(TSyncStockOrder);
  RegisterClass(TSyncStockData);
  RegisterClass(TSyncSalesOrderList);
  RegisterClass(TSyncSalesOrder);
  RegisterClass(TSyncSalesData);
  RegisterClass(TSyncChangeOrderList);
  RegisterClass(TSyncChangeOrder);
  RegisterClass(TSyncChangeData);
  RegisterClass(TSyncStkIndentOrderList);
  RegisterClass(TSyncStkIndentOrder);
  RegisterClass(TSyncStkIndentData);
  RegisterClass(TSyncSalIndentOrderList);
  RegisterClass(TSyncSalIndentOrder);
  RegisterClass(TSyncSalIndentData);
  RegisterClass(TSyncAccountInfo);
  RegisterClass(TSyncIoroOrderList);
  RegisterClass(TSyncIoroOrder);
  RegisterClass(TSyncIoroData);
  RegisterClass(TSyncTransOrder);
finalization
  UnRegisterClass(TSyncSingleTable);
  UnRegisterClass(TSyncCaRelationInfo);
  UnRegisterClass(TSyncCaRelations);
  UnRegisterClass(TSyncPubBarcode);
  UnRegisterClass(TSyncPubIcInfo);
  UnRegisterClass(TSyncStockOrderList);
  UnRegisterClass(TSyncStockOrder);
  UnRegisterClass(TSyncStockData);
  UnRegisterClass(TSyncSalesOrderList);
  UnRegisterClass(TSyncSalesOrder);
  UnRegisterClass(TSyncSalesData);
  UnRegisterClass(TSyncChangeOrderList);
  UnRegisterClass(TSyncChangeOrder);
  UnRegisterClass(TSyncChangeData);
  UnRegisterClass(TSyncStkIndentOrderList);
  UnRegisterClass(TSyncStkIndentOrder);
  UnRegisterClass(TSyncStkIndentData);
  UnRegisterClass(TSyncSalIndentOrderList);
  UnRegisterClass(TSyncSalIndentOrder);
  UnRegisterClass(TSyncSalIndentData);
  UnRegisterClass(TSyncAccountInfo);
  UnRegisterClass(TSyncIoroOrderList);
  UnRegisterClass(TSyncIoroOrder);
  UnRegisterClass(TSyncIoroData);
  UnRegisterClass(TSyncTransOrder);
end.
