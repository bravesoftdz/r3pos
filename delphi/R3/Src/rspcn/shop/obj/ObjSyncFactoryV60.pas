unit ObjSyncFactoryV60;

interface

uses Dialogs,SysUtils,zBase,Variants,Classes,DB,ZIntf,ZDataset,ObjCommon,ZDbcCache,ZDbcIntfs,Math;

type
  TSyncSingleTableV60=class(TZFactory)
  private
    FMaxCol: integer;
    procedure SetMaxCol(const Value: integer);
  protected
    Init:boolean;
    COMMIdx:integer;
    TIME_STAMPIdx:integer;
    InsertQuery:TZQuery;
    UpdateQuery:TZQuery;
    procedure InitSQL(AGlobal: IdbHelp;TimeStamp:boolean=true);virtual;
    function  GetRowAccessor: TZRowAccessor;
    procedure FillParams(ZQuery: TZQuery);virtual;
  public
    function CheckUnique(s:string):boolean;
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    procedure InitClass;override;
    destructor Destroy;override;
    property RowAccessor:TZRowAccessor read GetRowAccessor;
    property MaxCol:integer read FMaxCol write SetMaxCol;
  end;

  // 功能模块同步
  TSyncCaModuleV60=class(TSyncSingleTableV60)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  // 台账同步
  TSyncRckDaysCloseListV60=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TSyncRckDaysCloseV60=class(TSyncSingleTableV60)
  public
    function BeforeDeleteRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  TSyncRckStocksDataV60=class(TSyncSingleTableV60)
  public
    function BeforeUpdateRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeInsertRecord(AGlobal:IdbHelp):Boolean;override;
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  // 删除台账
  TSyncDeleteRckCloseV60=class(TZProcFactory)
  public
    function Execute(AGlobal:IdbHelp;Params:TftParamList):Boolean;override;
  end;

  // 销售单同步
  TSyncSalesOrderListV60=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  // 进货单同步
  TSyncStockOrderListV60=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

  // 调整单同步
  TSyncChangeOrderListV60=class(TZFactory)
  public
    function BeforeOpenRecord(AGlobal:IdbHelp):Boolean;override;
  end;

implementation

function TSyncSingleTableV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and TIME_STAMP>:TIME_STAMP'),Params);
end;

procedure TSyncSingleTableV60.FillParams(ZQuery:TZQuery);
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
      if (i=(COMMIdx-1)) and (Params.FindParam('COMM_LOCK')=nil) then //把通讯标志位改为 1
         begin
           Comm := ZQuery.Params[i].AsString;
           Comm[1] := '1';
           ZQuery.Params[i].AsString := Comm;
         end;
      if (i=(TIME_STAMPIdx-1)) then
         begin
           if ZQuery.Params[i].Value>2808566734 then
              ZQuery.Params[i].Value := 5497000;
           if (Params.FindParam('TIME_STAMP_NOCHG')<>nil) and (Params.ParamByName('TIME_STAMP_NOCHG').AsInteger = 0) and (ZQuery.Params[i].Value < Params.ParamByName('TIME_STAMP').Value) then
              ZQuery.Params[i].Value := Params.ParamByName('TIME_STAMP').Value;
         end;
      if WasNull then ZQuery.Params[i].Value := null;
    end;
  if ZQuery.Params.FindParam('LAST_TIME_STAMP') <> nil then
     ZQuery.Params.FindParam('LAST_TIME_STAMP').Value := ZQuery.Params[TIME_STAMPIdx-1].Value;
end;

function TSyncSingleTableV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
{
  procedure CheckUsingDate(AGlobal: IdbHelp);
  var rs:TZQuery;
  begin
    if Params.ParamByName('TABLE_NAME').AsString = 'SYS_DEFINE' then
    begin
      if (FindField('DEFINE') <> nil) and (FieldbyName('DEFINE').AsString='USING_DATE') then
         begin
           rs := TZQuery.Create(nil);
           try
             rs.SQL.Text := 'select * from SYS_DEFINE where TENANT_ID=:TENANT_ID and DEFINE=:DEFINE';
             rs.Params[0].AsInteger := FieldbyName('TENANT_ID').AsInteger;
             rs.Params[1].AsString := FieldbyName('DEFINE').AsString;
             AGlobal.Open(rs);
             if not rs.IsEmpty then
                begin
                  if rs.FieldByName('VALUE').AsString<>FieldbyName('VALUE').AsString then
                     begin
                       InsertQuery.ParamByName('TIME_STAMP').Value := StrtoInt64(Params.ParambyName('TIME_STAMP').AsString);
                       UpdateQuery.ParamByName('TIME_STAMP').Value := StrtoInt64(Params.ParambyName('TIME_STAMP').AsString);
                     end;
                  if rs.FieldByName('VALUE').AsString<FieldbyName('VALUE').AsString then
                     begin
                       InsertQuery.ParamByName('VALUE').AsString := rs.FieldByName('VALUE').AsString;
                       UpdateQuery.ParamByName('VALUE').AsString := rs.FieldByName('VALUE').AsString;
                     end;
                end;
           finally
             rs.Free;
           end;
         end
    end;
  end;
}
var
  r:integer;
  WasNull:boolean;
  Comm:string;
  rs:TZQuery;
begin
  if Params.ParamByName('TABLE_NAME').AsString = 'SYS_SEQUENCE' then
  begin
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text := 'select * from SYS_SEQUENCE where TENANT_ID=:TENANT_ID and SEQU_ID=:SEQU_ID';
      rs.Params[0].AsInteger := FieldbyName('TENANT_ID').AsInteger;
      rs.Params[1].AsString := FieldbyName('SEQU_ID').AsString;
      AGlobal.Open(rs);
      if rs.FieldByName('FLAG_TEXT').AsString > FieldByName('FLAG_TEXT').AsString then Exit;
      if rs.FieldByName('SEQU_NO').AsInteger > FieldByName('SEQU_NO').AsInteger then Exit;
    finally
      rs.Free;
    end;
  end;

  if Params.ParamByName('TABLE_NAME').AsString = 'SYS_DEFINE' then
  begin
    if (FindField('DEFINE') <> nil) and (FieldByName('DEFINE').AsString='USING_DATE') then Exit;
  end;

  InitSQL(AGlobal);
  Comm := RowAccessor.GetString(COMMIdx,WasNull);
  if (Comm='00') and (Params.ParamByName('KEY_FLAG').AsInteger in [0,2]) then
     begin
       FillParams(InsertQuery);
       try
         AGlobal.ExecQuery(InsertQuery);
       except
         on E:Exception do
            begin
              if CheckUnique(E.Message) then
                 begin
                   if Params.ParamByName('KEY_FLAG').AsInteger=2 then Exit;
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
       if (Params.ParamByName('KEY_FLAG').AsInteger in [0,1]) then
       begin
         FillParams(UpdateQuery);
         r := AGlobal.ExecQuery(UpdateQuery);
       end else r := 0;
       if r=0 then
          begin
            if (Comm='02') or (Comm='12') then Exit;
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

function TSyncSingleTableV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var Str:string;
begin
  if (Params.FindParam('TABLE_FIELDS') <> nil) and (trim(Params.ParamByName('TABLE_FIELDS').AsString) <> '') then
    Str := 'select '+Params.ParamByName('TABLE_FIELDS').AsString+' from '+Params.ParambyName('TABLE_NAME').AsString
  else
    Str := 'select * from '+Params.ParamByName('TABLE_NAME').AsString;

  if (Params.FindParam('WHERE_STR') <> nil) and (trim(Params.ParamByName('WHERE_STR').AsString) <> '') then
    Str := Str + ' where ' + Params.ParamByName('WHERE_STR').AsString
  else
    Str := Str + ' where TENANT_ID = :TENANT_ID and TIME_STAMP > :TIME_STAMP';

  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str + ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := Str + ' order by TIME_STAMP asc';
end;

function TSyncSingleTableV60.CheckUnique(s: string): boolean;
begin
  result :=
    (pos('unique',lowercase(s))>0)
    or
    (pos('primary',lowercase(s))>0)
    or                                                      
    (pos('sql0803',lowercase(s))>0)
    or
    (pos('主键',s)>0)
    or
    (pos('关键字',s)>0)
    or
    (pos('重复键',s)>0)
    or
    (pos('唯一约束',s)>0);
end;

function TSyncSingleTableV60.GetRowAccessor: TZRowAccessor;
begin
  if assigned(DataSet) and assigned(TZQuery(DataSet).UpdateObject) then
     result := TZQuery(DataSet).UpdateObject.ZNewRowAccessor
  else
     Raise Exception.Create('没有指定同步对像，不能完成同步操作.');
end;

procedure TSyncSingleTableV60.InitClass;
begin
  inherited;
  Init := false;
  InsertQuery := nil;
  UpdateQuery := nil;
end;

procedure TSyncSingleTableV60.InitSQL(AGlobal: IdbHelp;TimeStamp:boolean=true);
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
  if Assigned(InsertQuery) then freeandnil(InsertQuery);
  InsertQuery := TZQuery.Create(nil);
  InsertQuery.SQL.Text := 'insert into '+Params.ParambyName('TABLE_NAME').AsString+'('+InsertFld+') values('+ValueFld+')';
  if Assigned(UpdateQuery) then freeandnil(UpdateQuery);
  UpdateQuery := TZQuery.Create(nil);
  if TimeStamp and (Params.ParambyName('KEY_FLAG').AsInteger=0) then
     begin
       if Params.FindParam('LAST_TIME_STAMP') <> nil then
         begin
           if WhereStr <> '' then WhereStr := WhereStr + ' and ';
           WhereStr :=WhereStr+' TIME_STAMP <= :LAST_TIME_STAMP';
         end;
     end;
  UpdateQuery.SQL.Text := 'update '+Params.ParambyName('TABLE_NAME').AsString+' set '+UpdateFld+' where '+WhereStr;

  Init := true;
end;

procedure TSyncSingleTableV60.SetMaxCol(const Value: integer);
begin
  FMaxCol := Value;
end;

destructor TSyncSingleTableV60.Destroy;
begin
  if InsertQuery<>nil then InsertQuery.Free;
  if UpdateQuery<>nil then UpdateQuery.Free;
  inherited;
end;

{ TSyncCaModuleV60 }

function TSyncCaModuleV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update '+Params.ParambyName('TABLE_NAME').AsString+' set COMM=''1'''+js+'substring(COMM,2,1) where PROD_ID=:PROD_ID'),Params);
end;

function TSyncCaModuleV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
   InitSQL(AGlobal);
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
end;

function TSyncCaModuleV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var
  Str:string;
  rs :TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    Str := 'select count(*) from '+Params.ParambyName('TABLE_NAME').AsString+ ' where PROD_ID='''+Params.ParambyName('PROD_ID').AsString+''' and TIME_STAMP>'+Params.ParambyName('TIME_STAMP').AsString;
    if Params.ParamByName('SYN_COMM').AsBoolean then
       Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');
    rs.SQL.Text := Str;
    AGlobal.Open(rs);
    if rs.Fields[0].AsInteger=0 then
       Str :='select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where TIME_STAMP=0 and PROD_ID='''+Params.ParambyName('PROD_ID').AsString+''''
    else
       Str :='select * from '+Params.ParambyName('TABLE_NAME').AsString+ ' where PROD_ID='''+Params.ParambyName('PROD_ID').AsString+'''';
    SelectSQL.Text := Str;
  finally
    rs.Free;
  end;
end;

function TSyncCaModuleV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from CA_MODULE where PROD_ID=:PROD_ID',Params);
  result := true;
end;

{ TSyncRckDaysCloseListV60 }

function TSyncRckDaysCloseListV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var str:string;
begin
  str := 'select TENANT_ID,SHOP_ID,CREA_DATE from '+Params.ParambyName('TABLE_NAME').AsString+' where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';

  if Params.FindParam('BEGIN_DATE') = nil then
     str := str + ' and TIME_STAMP>:TIME_STAMP'
  else
     str := str + ' and CREA_DATE>=:BEGIN_DATE';

  if Params.ParamByName('SYN_COMM').AsBoolean then
     str := str + ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := str + ' order by TIME_STAMP asc';
end;

{ TSyncRckDaysCloseV60 }

function TSyncRckDaysCloseV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select '+Params.ParamByName('TABLE_FIELDS').AsString+' from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE';
end;

function TSyncRckDaysCloseV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  AGlobal.ExecSQL('delete from RCK_DAYS_CLOSE  where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE',Params);
  AGlobal.ExecSQL('delete from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and BILL_DATE=:CREA_DATE',Params);
  if not Init then Params.ParamByName('TABLE_NAME').AsString := 'RCK_DAYS_CLOSE';
  InitSQL(AGlobal,false);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

function TSyncRckDaysCloseV60.BeforeDeleteRecord(AGlobal: IdbHelp): Boolean;
var js:string;
begin
  case AGlobal.iDbType of
  0:js := '+';
  1,4,5:js := '||';
  end;
  AGlobal.ExecSQL(ParseSQL(AGlobal.iDbType,'update RCK_DAYS_CLOSE set COMM=''1'''+js+'substring(COMM,2,1) where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_DATE=:CREA_DATE'),self);
end;

{ TSyncRckStocksDataV60 }

function TSyncRckStocksDataV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
begin
  SelectSQL.Text := 'select '+Params.ParamByName('TABLE_FIELDS').AsString+' from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and BILL_DATE=:CREA_DATE';
end;

function TSyncRckStocksDataV60.BeforeUpdateRecord(AGlobal: IdbHelp): Boolean;
begin

end;

function TSyncRckStocksDataV60.BeforeInsertRecord(AGlobal: IdbHelp): Boolean;
begin
  if not Init then Params.ParamByName('TABLE_NAME').AsString := 'RCK_STOCKS_DATA';
  InitSQL(AGlobal);
  FillParams(InsertQuery);
  AGlobal.ExecQuery(InsertQuery);
end;

{ TSyncSalesOrderListV60 }

function TSyncSalesOrderListV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var str:string;
begin
  str := 'select TENANT_ID,SHOP_ID,SALES_ID,SALES_DATE from SAL_SALESORDER where TENANT_ID=:TENANT_ID and (SHOP_ID=:SHOP_ID or CLIENT_ID=:SHOP_ID)';

  if Params.FindParam('BEGIN_DATE') = nil then
     str := str + ' and TIME_STAMP>:TIME_STAMP'
  else
     str := str + ' and SALES_DATE>=:BEGIN_DATE';

  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := str + ' order by TIME_STAMP asc';
end;

{ TSyncStockOrderListV60 }

function TSyncStockOrderListV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var str:string;
begin
  str := 'select TENANT_ID,SHOP_ID,STOCK_ID,STOCK_DATE from STK_STOCKORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';

  if Params.FindParam('BEGIN_DATE') = nil then
     str := str + ' and TIME_STAMP>:TIME_STAMP'
  else
     str := str + ' and STOCK_DATE>=:BEGIN_DATE';

  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := str + ' order by TIME_STAMP asc';
end;

{ TSyncChangeOrderListV60 }

function TSyncChangeOrderListV60.BeforeOpenRecord(AGlobal: IdbHelp): Boolean;
var str:string;
begin
  str := 'select TENANT_ID,SHOP_ID,CHANGE_ID,CHANGE_DATE from STO_CHANGEORDER where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';

  if Params.FindParam('BEGIN_DATE') = nil then
     str := str + ' and TIME_STAMP>:TIME_STAMP'
  else
     str := str + ' and CHANGE_DATE>=:BEGIN_DATE';

  if Params.ParamByName('SYN_COMM').AsBoolean then
     Str := Str +ParseSQL(AGlobal.iDbType,' and substring(COMM,1,1)<>''1''');

  SelectSQL.Text := str + ' order by TIME_STAMP asc';
end;

{ TSyncDeleteRckCloseV60 }

function TSyncDeleteRckCloseV60.Execute(AGlobal: IdbHelp; Params: TftParamList): Boolean;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    AGlobal.BeginTrans;
    try
      AGlobal.ExecSQL('delete from RCK_DAYS_CLOSE  where TENANT_ID=:TENANT_ID and CREA_DATE>=:CLSE_DATE',Params);
      AGlobal.ExecSQL('delete from RCK_MONTH_CLOSE where TENANT_ID=:TENANT_ID and END_DATE>=:MOTH_DATE',Params);
      AGlobal.CommitTrans;
      result := true;
    except
      on E:Exception do
         begin
           AGlobal.RollbackTrans;
           Msg := E.Message;
           result := false;
           Raise;
         end;
    end;
  finally
    rs.Free;
  end;
end;

initialization
  RegisterClass(TSyncSingleTableV60);
  RegisterClass(TSyncCaModuleV60);
  RegisterClass(TSyncRckDaysCloseListV60);
  RegisterClass(TSyncRckDaysCloseV60);
  RegisterClass(TSyncRckStocksDataV60);
  RegisterClass(TSyncSalesOrderListV60);
  RegisterClass(TSyncStockOrderListV60);
  RegisterClass(TSyncChangeOrderListV60);
  RegisterClass(TSyncDeleteRckCloseV60);
finalization
  UnRegisterClass(TSyncSingleTableV60);
  UnRegisterClass(TSyncCaModuleV60);
  UnRegisterClass(TSyncRckDaysCloseListV60);
  UnRegisterClass(TSyncRckDaysCloseV60);
  UnRegisterClass(TSyncRckStocksDataV60);
  UnRegisterClass(TSyncSalesOrderListV60);
  UnRegisterClass(TSyncStockOrderListV60);
  UnRegisterClass(TSyncChangeOrderListV60);
  UnRegisterClass(TSyncDeleteRckCloseV60);
end.
