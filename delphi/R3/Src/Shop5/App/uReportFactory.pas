unit uReportFactory;

interface
uses
  Windows, Messages, DB, SysUtils, Variants, Classes, ZDataSet, DBGridEh;
const
  RF_DATA_SOURCE1='SALE_AMT=数量,SALE_MNY=未税金额,SALE_TTL=金额,SALE_TAX=销项税额,SALE_CST=成本,SALE_PRF=毛利';
  RF_DATA_SOURCE2='STOCK_AMT=数量,STOCK_MNY=未税金额,STOCK_TTL=金额,STOCK_TAX=进项税额';
  RF_DATA_SOURCE3='BAL_AMT=库存,BAL_CST=成本,BAL_RTL=销售额';
type

pRCondi=^TRCondi;
TRCondi=record
  Count:integer;
  idx:array [1..30] of integer;
  V:array [1..30] of string;
  alled:boolean;
  end;

pRVariant=^RVariant;
RVariant=record
  Value:Variant;
  end;
  
PColumnR=^TColumnR;
TColumnR=record
  //0 字符型 1 数据值
  DataType:integer;
  FieldName:string;
  Title:string;
  Condi:TRCondi;
  end;

PRTemplate=^TRTemplate;
TRTemplate=record
  //0 字符型 1 数据值
  row,col,coltype:integer;
  FieldName:string;
  Title:string;
  INDEX_ID:string;
  subtype:integer;
  Data:Pointer;
  curid:string;
  curname:string;
  curfield:string;
  end;

PRowR=^TRowR;
TRowR=record
  //0 字符型 1 数据值
  DataType:integer;
  FieldName:string;
  Title:string;
  Condi:pRCondi;
  Buffer:array [0..255] of RVariant;
  end;

TReportFactory=class
  private
    Cols:TList;
    Rows:TList;
    TLate:TList;
    FDataSet: TDataSet;
    procedure SetDataSet(const Value: TDataSet);
  protected
    function CreateIndex(sid: string): TList;
    function Check(V:pRCondi):boolean;
    procedure Init;
    procedure Load(rid:string);
    procedure PrepareHeader;
    procedure PrepareRows;
    procedure Prepare;
    procedure Calc;
    procedure Fill(rs:TDataSet);
    procedure CreateHeader(Grid:TDBGridEh);
  public
    procedure Open(id:string;Grid:TDBGridEh);
    constructor Create;
    destructor Destroy;override;
    property DataSet:TDataSet read FDataSet write SetDataSet;
  end;

implementation
uses uGlobal;
{ TReportFactory }
type
  PIdxNode=^TIdxNode;
  TIdxNode=record
    id:string;
    title:string;
    FieldName:string;
    end;

constructor TReportFactory.Create;
begin
  Cols := TList.Create;
  Rows := TList.Create;
  TLate := TList.Create;
end;

destructor TReportFactory.Destroy;
begin
  TLate.Free;
  Cols.Free;
  Rows.Free;
  inherited;
end;

procedure TReportFactory.Init;
var
  i:integer;
begin
  for i:=0 to TLate.Count -1 do
    begin
      dispose(TLate[i]);
    end;
  TLate.Clear;
  for i:=0 to Cols.Count -1 do
    begin
      dispose(Cols[i]);
    end;
  Cols.Clear;
  for i:=0 to Rows.Count -1 do
    begin
      dispose(Rows[i]);
    end;
  Rows.Clear;
end;

procedure TReportFactory.Load(rid: string);
var
  rs:TZQuery;
  node:PRTemplate;
begin
  Init;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select * from SYS_REPORT_TEMPLATE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_ID='''+rid+''' and CELL_TYPE=''1'' order by col,row';
    Factor.Open(rs);
    rs.first;
    while not rs.Eof do
      begin
        new(node);
        node^.row := rs.FieldbyName('ROW').AsInteger;
        node^.col := rs.FieldbyName('COL').AsInteger;
        node^.coltype := rs.FieldbyName('CELL_TYPE').AsInteger;
        node^.subtype := rs.FieldbyName('SUM_TYPE').AsInteger;
        node^.Title := rs.FieldbyName('DISPLAY_NAME').AsString;
        node^.FieldName := rs.FieldbyName('FIELD_NAME').AsString;
        node^.INDEX_ID := rs.FieldbyName('INDEX_ID').AsString;
        TLate.Add(node);
        rs.next;
      end;
    rs.Close;
    rs.SQL.Text := 'select * from SYS_REPORT_TEMPLATE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_ID='''+rid+''' and CELL_TYPE=''2'' order by row,col';
    Factor.Open(rs);
    rs.first;
    while not rs.Eof do
      begin
        new(node);
        node^.row := rs.FieldbyName('ROW').AsInteger;
        node^.col := rs.FieldbyName('COL').AsInteger;
        node^.coltype := rs.FieldbyName('CELL_TYPE').AsInteger;
        node^.subtype := rs.FieldbyName('SUM_TYPE').AsInteger;
        node^.Title := rs.FieldbyName('DISPLAY_NAME').AsString;
        node^.FieldName := rs.FieldbyName('FIELD_NAME').AsString;
        node^.INDEX_ID := rs.FieldbyName('INDEX_ID').AsString;
        TLate.Add(node);
        rs.next;
      end;
  finally
    rs.free;
  end;
end;

procedure TReportFactory.Open(id:string;Grid:TDBGridEh);
begin
  Load(id);
  Prepare;
  Calc;
  CreateHeader(Grid);
  Fill(Grid.DataSource.DataSet);
end;

procedure TReportFactory.Prepare;
begin
  PrepareHeader;
  PrepareRows;
end;
function TReportFactory.CreateIndex(sid:string):TList;
var
  rs:TZQuery;
  node:PIdxNode;
  id:string;
  idx,ndx:integer;
begin
  result := TList.Create;
  if (sid='DEPT_ID')
     or
     (sid='GUIDE_USER')
     or
     (sid='CLIENT_ID')
     or
     (sid='GODS_ID')
     or
     (sid='SHOP_ID')
     or
     (sid='CREGION_ID')
     or
     (sid='SREGION_ID')
  then
     begin
       id := '';
       idx := DataSet.FindField(sid).Index;
       ndx := DataSet.FindField(sid+'_TEXT').Index;
       DataSet.First;
       while not DataSet.Eof do
         begin
           if id<>DataSet.Fields[idx].AsString then
              begin
                new(node);
                node^.id := rs.Fields[idx].AsString;
                node^.title := rs.Fields[ndx].AsString;
                node^.FieldName := sid;
                id := DataSet.Fields[idx].AsString;
              end;
           DataSet.Next;
         end;
     end
  else
     begin
       rs := Global.GetZQueryFromName('PUB_GOODS_INDEXS');
       rs.Filtered := false;
       rs.Filter := 'SORT_TYPE='''+sid+'''';
       rs.Filtered := true;
       rs.First;
       while not rs.Eof do
         begin
           new(node);
           node^.id := rs.FieldbyName('SORT_ID').AsString;
           node^.title := rs.FieldbyName('SORT_NAME').AsString;
           node^.FieldName := 'SORT_ID'+sid;
           rs.Next;
         end;
     end;
end;


procedure TReportFactory.PrepareHeader;
procedure DoCreateHeader(ATree:array of PRTemplate);
procedure DoHeader(idx:integer);
var
  i,j:integer;
  Column:PColumnR;
begin
  if ATree[idx].Data=nil then Exit;
  for i:=0 to TList(ATree[idx].Data).Count -1 do
    begin
      ATree[idx].curid := PIdxNode(TList(ATree[idx].Data)[i])^.id;
      ATree[idx].curname := PIdxNode(TList(ATree[idx].Data)[i])^.title;
      ATree[idx].curfield := PIdxNode(TList(ATree[idx].Data)[i])^.FieldName;
      if ATree[idx+1].Data=nil then //到根结点了
         begin
           new(Column);
           Column^.DataType := 0;
           for j:=1 to 30 do Column.Condi.idx[j] := -1;
           for j:=idx downto 1 do
              begin
                Column^.Title := ATree[j].curname+'|'+Column^.Title;
                Column^.Condi.V[idx] := ATree[j].curid;
                Column^.Condi.idx[idx] := DataSet.FindField(ATree[j].curfield).Index;
              end;
           Column^.FieldName := ATree[idx].FieldName;
         end
      else
         DoHeader(idx+1);
    end;
end;
var
  i:integer;
begin
  for i:=1 to 30 do
    begin
      if ATree[i]=nil then break;
      ATree[i].Data := CreateIndex(ATree[i].INDEX_ID);
    end;
  if ATree[1]=nil then exit;
  if ATree[1].Data=nil then exit;
  for i:=0 to TList(ATree[1].Data).Count -1 do
    begin
      ATree[1].curid := PIdxNode(TList(ATree[1].Data)[i])^.id;
      ATree[1].curname := PIdxNode(TList(ATree[1].Data)[i])^.title;
      ATree[1].curfield := PIdxNode(TList(ATree[1].Data)[i])^.FieldName;
      DoHeader(1);
    end;
end;
var
  i,j,c:integer;
  ATree:array [1..30] of PRTemplate;
begin
  for i:=1 to 30 do ATree[i] := nil;
  c := -1;
  for i:=0 to TLate.Count -1 do
    begin
      if PRTemplate(TLate[i])^.coltype=1 then continue;
      if c=PRTemplate(TLate[i])^.col then
         begin
           ATree[PRTemplate(TLate[i])^.row] := PRTemplate(TLate[i]);
         end
      else
         begin
           if c<>-1 then  DoCreateHeader(ATree);
           for j:=1 to 30 do ATree[j] := nil;
           ATree[PRTemplate(TLate[i])^.row] := PRTemplate(TLate[i]);
           c := PRTemplate(TLate[i])^.col;
         end;
    end;
 if c<>-1 then  DoCreateHeader(ATree);
end;

procedure TReportFactory.PrepareRows;
procedure DoCreateRows(ATree:array of PRTemplate);
procedure DoRows(idx:integer);
var
  i,j:integer;
  Row:PRowR;
begin
  if ATree[idx].Data=nil then Exit;
  for i:=0 to TList(ATree[idx].Data).Count -1 do
    begin
      ATree[idx].curid := PIdxNode(TList(ATree[idx].Data)[i])^.id;
      ATree[idx].curname := PIdxNode(TList(ATree[idx].Data)[i])^.title;
      ATree[idx].curfield := PIdxNode(TList(ATree[idx].Data)[i])^.FieldName;
      if ATree[idx+1].Data=nil then //到根结点了
         begin
           new(Row);
           Row^.DataType := 0;
           Row^.Title := PIdxNode(TList(ATree[idx].Data)[i])^.title;
           for j:=1 to 30 do Row.Condi.idx[j] := -1;
           for j:=idx downto 1 do
              begin
                Row^.Title := '  '+Row^.Title;
                Row^.Condi.V[idx] := ATree[j].curid;
                Row^.Condi.idx[idx] := DataSet.FindField(ATree[j].curfield).Index;
              end;
           Row^.FieldName := ATree[idx].FieldName;
         end
      else
         DoRows(idx+1);
    end;
end;
var
  i:integer;
begin
  for i:=1 to 30 do
    begin
      if ATree[i]=nil then break;
      ATree[i].Data := CreateIndex(ATree[i].INDEX_ID);
    end;
  if ATree[1]=nil then exit;
  if ATree[1].Data=nil then exit;
  for i:=0 to TList(ATree[1].Data).Count -1 do
    begin
      ATree[1].curid := PIdxNode(TList(ATree[1].Data)[i])^.id;
      ATree[1].curname := PIdxNode(TList(ATree[1].Data)[i])^.title;
      ATree[1].curfield := PIdxNode(TList(ATree[1].Data)[i])^.FieldName;
      DoRows(1);
    end;
end;
var
  i,j,c:integer;
  ATree:array [1..30] of PRTemplate;
begin
  for i:=1 to 30 do ATree[i] := nil;
  c := -1;
  for i:=0 to TLate.Count -1 do
    begin
      if PRTemplate(TLate[i])^.coltype=2 then continue;
      if c=PRTemplate(TLate[i])^.row then
         begin
           ATree[PRTemplate(TLate[i])^.col] := PRTemplate(TLate[i]);
         end
      else
         begin
           if c<>-1 then  DoCreateRows(ATree);
           for j:=1 to 30 do ATree[j] := nil;
           ATree[PRTemplate(TLate[i])^.col] := PRTemplate(TLate[i]);
           c := PRTemplate(TLate[i])^.row;
         end;
    end;
 if c<>-1 then  DoCreateRows(ATree);
end;

procedure TReportFactory.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
end;

procedure TReportFactory.CreateHeader(Grid: TDBGridEh);
var
  i:integer;
  Column:TColumnEh;
  tb:TZQuery;
begin
  tb := TZQuery(Grid.DataSource.DataSet);
  tb.Close;
  tb.FieldDefs.Clear;
  tb.FieldDefs.Add('A_IDX',ftString,255,true);
  for i:=0 to Cols.Count-1 do
    begin
      Column := Grid.Columns.Add;
      Column.FieldName := 'A_'+inttostr(i);
      Column.Title.Caption := PColumnR(Cols[i])^.Title;
      tb.FieldDefs.Add('A_'+inttostr(i),ftFloat,0,true);
    end;
  tb.CreateDataSet;
end;

procedure TReportFactory.Calc;
var i,j:integer;
begin
  DataSet.First;
  while not DataSet.Eof do
    begin
      for i:=0 to Rows.Count -1 do
      for j:=0 to Cols.Count -1 do
        begin
          if Check(@PRowR(Rows[i])^.Condi) and Check(@PColumnR(Cols[i])^.Condi) then
             begin
               PRowR(Rows[i])^.Buffer[j].Value := PRowR(Rows[i])^.Buffer[j].Value + DataSet.FieldbyName(PColumnR(Cols[i])^.FieldName).asFloat;
             end;
        end;
      DataSet.Next;
    end;
end;

function TReportFactory.Check(V: pRCondi): boolean;
var
  i:integer;
begin
  result := true;
  for i:=1 to 30 do
    begin
      if V.idx[I]<0 then break;
      result := (DataSet.Fields[V.idx[I]].AsString=V.V[I]);
      if not result then break;
    end;
end;

procedure TReportFactory.Fill(rs:TDataSet);
var
  i,j:integer;
begin
  for i:=0 to Rows.Count -1 do
  begin
    rs.Append;
    for j:=0 to Cols.Count -1 do
    begin
      rs.Fields[j+1].Value :=  PRowR(Rows[i])^.Buffer[j].Value;
    end;
    rs.Post;
  end;
end;

end.
