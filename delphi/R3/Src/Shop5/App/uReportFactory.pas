unit uReportFactory;

interface
uses
  Windows, Messages, DB, SysUtils, Variants, Classes, ZDataSet, DBGridEh;
const
  RF_DATA_SOURCE1='GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,SALE_AMT=数量,SALE_MNY=未税金额,SALE_TTL=金额,SALE_TAX=销项税额,SALE_CST=成本,SALE_PRF=毛利';
  RF_DATA_SOURCE2='GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,STOCK_AMT=数量,STOCK_MNY=未税金额,STOCK_TTL=金额,STOCK_TAX=进项税额';
  RF_DATA_SOURCE3='GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,BAL_AMT=库存,BAL_CST=成本,BAL_RTL=销售额';
type

pRCondi=^TRCondi;
TRCondi=record
  Count:integer;
  idx:array [0..30] of integer;
  V:array [0..30] of string;
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
  SumType:integer;
  SumFlag:integer;
  FieldName:string;
  Expr:string;
  Idx:Integer;
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
  subtype,sumFlag:integer;
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
  Condi:TRCondi;
  Level:integer;
  HasChild:boolean;
  Buffer:array [0..255] of RVariant;
  end;

TReportFactory=class
  private
    Cols:TList;
    Rows:TList;
    TLate:TList;
    FDataSet: TDataSet;
    Fields:TStringList;
    procedure SetDataSet(const Value: TDataSet);
  protected
    function CreateIndex(sid: string): TList;
    function Check(V:pRCondi):boolean;
    procedure Init;
    procedure InitCondi(RCondi:pRCondi);
    procedure Load(rid:string);
    procedure PrepareHeader;
    procedure PrepareRows;
    procedure Prepare;
    procedure Calc;
    procedure Fill(rs:TDataSet);
    procedure CreateHeader(Grid:TDBGridEh);
  public
    Footer:array [0..255] of RVariant;
    procedure Open(id:string;Grid:TDBGridEh);
    constructor Create(sourid:string);
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

constructor TReportFactory.Create(sourid:string);
begin
  Cols := TList.Create;
  Rows := TList.Create;
  TLate := TList.Create;
  Fields := TStringList.Create;
  if sourid='1' then Fields.CommaText := RF_DATA_SOURCE1;
  if sourid='2' then Fields.CommaText := RF_DATA_SOURCE2;
  if sourid='3' then Fields.CommaText := RF_DATA_SOURCE3;
end;

destructor TReportFactory.Destroy;
begin
  TLate.Free;
  Cols.Free;
  Rows.Free;
  Fields.Free;
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
        if rs.FieldbyName('SUM_TYPE').AsString='#' then
        node^.subtype := 0 else
        node^.subtype := rs.FieldbyName('SUM_TYPE').AsInteger;
        if rs.FieldbyName('SUB_FLAG').AsString='#' then
        node^.sumFlag := 1 else
        node^.sumFlag := rs.FieldbyName('SUB_FLAG').AsInteger;
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
        if rs.FieldbyName('SUM_TYPE').AsString='#' then
        node^.subtype := 0 else
        node^.subtype := rs.FieldbyName('SUM_TYPE').AsInteger;
        if rs.FieldbyName('SUB_FLAG').AsString='#' then
        node^.sumFlag := 1 else
        node^.sumFlag := rs.FieldbyName('SUB_FLAG').AsInteger;
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
Grid.DataSource.DataSet.DisableControls;
try
  Load(id);
  Prepare;
  CreateHeader(Grid);
  Calc;
  Fill(Grid.DataSource.DataSet);
finally
  Grid.DataSource.DataSet.EnableControls;
end;
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
                node^.id := DataSet.Fields[idx].AsString;
                node^.title := DataSet.Fields[ndx].AsString;
                node^.FieldName := sid;
                result.add(node);
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
           result.add(node);
           rs.Next;
         end;
     end;
end;


procedure TReportFactory.PrepareHeader;
procedure DoCreateHeader(ATree:array of PRTemplate);
procedure DoHeader(idx:integer);
var
  i,j,c:integer;
  Column:PColumnR;
  vList:TStringList;
begin
  if ATree[idx].Data=nil then Exit;
  vList := TStringList.Create;
  try
  if ATree[idx].INDEX_ID = 'TOTAL' then
     begin
       vList.CommaText := ATree[idx].FieldName;
       for c:=0 to vList.Count-1 do
       begin
         new(Column);
         if ATree[idx].INDEX_ID = 'FIELD' then
            Column^.DataType := 0
         else
            Column^.DataType := 1;
         Column^.SumType := ATree[idx].subtype;
         InitCondi(@Column.Condi);
         Column.Condi.alled := true;
         Column^.Title := ATree[j].Title;
         if (vList.Count>1) then
            Column^.Title := Column^.Title+'|'+Fields.Values[vList[c]];
         Column^.FieldName := vList[c];
         if DataSet.FindField(Column^.FieldName)<>nil then
            Column^.Idx := DataSet.FindField(Column^.FieldName).Index
         else
            Column^.Idx := -1;
         Cols.Add(Column);
       end;
     end
  else
  if ATree[idx].INDEX_ID = 'FIELD' then
     begin
       vList.CommaText := ATree[idx].FieldName;
       for c:=0 to vList.Count-1 do
       begin
         new(Column);
         Column^.DataType := 0;
         Column^.SumType := ATree[idx].subtype;
         InitCondi(@Column.Condi);
         Column.Condi.alled := true;
         Column^.Title := Fields.Values[vList[c]];
         Column^.FieldName := vList[c];
         if DataSet.FindField(Column^.FieldName)<>nil then
            Column^.Idx := DataSet.FindField(Column^.FieldName).Index
         else
            Column^.Idx := -1;
         Cols.Add(Column);
       end;
     end
  else
  begin
  //展开列
  for i:=0 to TList(ATree[idx].Data).Count -1 do
    begin
      ATree[idx].curid := PIdxNode(TList(ATree[idx].Data)[i])^.id;
      ATree[idx].curname := PIdxNode(TList(ATree[idx].Data)[i])^.title;
      ATree[idx].curfield := PIdxNode(TList(ATree[idx].Data)[i])^.FieldName;
      if ATree[idx+1]=nil then //到根结点了
         begin
           vList.CommaText := ATree[idx].FieldName;
           for c:=0 to vList.Count-1 do
           begin
             new(Column);
             Column^.DataType := 1;
             Column^.SumType := ATree[idx].subtype;
             InitCondi(@Column.Condi);
             for j:=idx downto 0 do
                begin
                  if Column^.Title<>'' then Column^.Title := '|'+Column^.Title;
                  Column^.Title := ATree[j].curname+Column^.Title;
                  Column^.Condi.V[j] := ATree[j].curid;
                  Column^.Condi.idx[j] := DataSet.FindField(ATree[j].curfield).Index;
                end;
             if (vList.Count>1) then
                Column^.Title := Column^.Title+'|'+Fields.Values[vList[c]];
             Column^.FieldName := vList[c];
             if DataSet.FindField(Column^.FieldName)<>nil then
                Column^.Idx := DataSet.FindField(Column^.FieldName).Index
             else
                Column^.Idx := -1;
             Cols.Add(Column);
           end;
         end
      else
         DoHeader(idx+1);
    end;
  //添加小计
  if ATree[idx].sumFlag=2 then
    begin
       vList.CommaText := ATree[idx].FieldName;
       for c:=0 to vList.Count-1 do
       begin
         new(Column);
         Column^.DataType := 1;
         Column^.SumType := ATree[idx].subtype;
         InitCondi(@Column.Condi);
         Column^.Title := '小计';
         for j:=idx-1 downto 0 do
            begin
              if Column^.Title<>'' then Column^.Title := '|'+Column^.Title;
              Column^.Title := ATree[j].curname+Column^.Title;
              Column^.Condi.V[j] := ATree[j].curid;
              Column^.Condi.idx[j] := DataSet.FindField(ATree[j].curfield).Index;
            end;
         if (vList.Count>1) then
            Column^.Title := Column^.Title+'|'+Fields.Values[vList[c]];
         Column^.FieldName := vList[c];
         if DataSet.FindField(Column^.FieldName)<>nil then
            Column^.Idx := DataSet.FindField(Column^.FieldName).Index
         else
            Column^.Idx := -1;
         Cols.Add(Column);
       end;
    end;
  end;
  finally
    vList.Free;
  end;
end;
var
  i:integer;
begin
  for i:=0 to 30 do
    begin
      if ATree[i]=nil then break;
      ATree[i].Data := CreateIndex(ATree[i].INDEX_ID);
    end;
  if ATree[0]=nil then exit;
  if ATree[0].Data=nil then exit;
  DoHeader(0);
end;
var
  i,j,c:integer;
  ATree:array [0..30] of PRTemplate;
begin
  for i:=0 to 30 do ATree[i] := nil;
  c := -1;
  for i:=0 to TLate.Count -1 do
    begin
      if PRTemplate(TLate[i])^.coltype=2 then continue;
      if c=PRTemplate(TLate[i])^.col then
         begin
           ATree[PRTemplate(TLate[i])^.row-1] := PRTemplate(TLate[i]);
         end
      else
         begin
           if c<>-1 then  DoCreateHeader(ATree);
           for j:=0 to 30 do ATree[j] := nil;
           ATree[PRTemplate(TLate[i])^.row-1] := PRTemplate(TLate[i]);
           c := PRTemplate(TLate[i])^.col;
         end;
    end;
 if c<>-1 then  DoCreateHeader(ATree);
end;

procedure TReportFactory.PrepareRows;
procedure DoCreateRows(ATree:array of PRTemplate);
procedure DoRows(idx:integer);
var
  i,j,c:integer;
  Row:PRowR;
begin
  if ATree[idx].Data=nil then Exit;
  for i:=0 to TList(ATree[idx].Data).Count -1 do
    begin
      ATree[idx].curid := PIdxNode(TList(ATree[idx].Data)[i])^.id;
      ATree[idx].curname := PIdxNode(TList(ATree[idx].Data)[i])^.title;
      ATree[idx].curfield := PIdxNode(TList(ATree[idx].Data)[i])^.FieldName;
      new(Row);
      Row^.DataType := 0;
      Row^.Title := PIdxNode(TList(ATree[idx].Data)[i])^.title;
      InitCondi(@Row.Condi);
      for j:=idx downto 0 do
         begin
           if idx>0 then Row^.Title := '  '+Row^.Title;
           Row^.Condi.V[j] := ATree[j].curid;
           Row^.Condi.idx[j] := DataSet.FindField(ATree[j].curfield).Index;
         end;
      Row^.Level := idx+1;
      Row^.FieldName := ATree[idx].FieldName;
      for c:=0 to 255 do Row^.Buffer[c].Value := null; 
      Rows.Add(Row);
      if ATree[idx+1]<>nil then //到根结点了
         begin
           Row^.HasChild := true;
           DoRows(idx+1);
         end
      else
         begin
           Row^.HasChild := false;
         end;
    end;
end;
var
  i:integer;
begin
  for i:=0 to 30 do
    begin
      if ATree[i]=nil then break;
      ATree[i].Data := CreateIndex(ATree[i].INDEX_ID);
    end;
  if ATree[0]=nil then exit;
  if ATree[0].Data=nil then exit;
  DoRows(0);
end;
var
  i,j,c:integer;
  ATree:array [0..30] of PRTemplate;
begin
  for i:=0 to 30 do ATree[i] := nil;
  c := -1;
  for i:=0 to TLate.Count -1 do
    begin
      if PRTemplate(TLate[i])^.coltype=1 then continue;
      if c=PRTemplate(TLate[i])^.row then
         begin
           ATree[PRTemplate(TLate[i])^.col-1] := PRTemplate(TLate[i]);
         end
      else
         begin
           if c<>-1 then  DoCreateRows(ATree);
           for j:=0 to 30 do ATree[j] := nil;
           ATree[PRTemplate(TLate[i])^.col-1] := PRTemplate(TLate[i]);
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
  Grid.Columns.Clear;
  tb := TZQuery(Grid.DataSource.DataSet);
  tb.Close;
  tb.Fields.Clear;
  tb.FieldDefs.Clear;
  tb.FieldDefs.Add('ROW',ftInteger,0,true);
  tb.FieldDefs.Add('A_IDX',ftString,255,true);
  tb.FieldDefs.Add('LVL',ftInteger,0,true);
  Column := Grid.Columns.Add;
  Column.FieldName := 'A_IDX';
  Column.Title.Caption := '名称';
  Column.Width := 150;
  Column.Footer.ValueType := fvtStaticText;
  Column.Footer.Value := '合计';
  Column.Footer.Alignment := taCenter;
  for i:=0 to Cols.Count-1 do
    begin
      Column := Grid.Columns.Add;
      Column.FieldName := 'A_'+inttostr(i);
      Column.Title.Caption := PColumnR(Cols[i])^.Title;
      if PColumnR(Cols[i])^.DataType = 0 then
      begin
        Column.Width := 100;
        tb.FieldDefs.Add('A_'+inttostr(i),ftString,255,true);
      end
      else
      begin
        tb.FieldDefs.Add('A_'+inttostr(i),ftFloat,0,true);
        Column.Width := 60;
        Column.DisplayFormat := '#0.00';
        Column.Footer.DisplayFormat := '#0.00';
        case PColumnR(Cols[i])^.SumType of
        1:Column.Footer.ValueType := fvtSum;
        2:Column.Footer.ValueType := fvtAvg;
        3:Column.Footer.ValueType := fvtCount;
        end;
        Column.Alignment := taRightJustify;
        Column.Footer.Alignment := taRightJustify;
      end;
    end;
  tb.CreateDataSet;
end;

procedure TReportFactory.Calc;
var i,j:integer;
begin
  for j:=0 to Cols.Count -1 do Footer[j].Value := null;
  DataSet.First;
  while not DataSet.Eof do
    begin
      for j:=0 to Cols.Count -1 do
      begin
        for i:=0 to Rows.Count -1 do
        begin
          if Check(@PRowR(Rows[i])^.Condi) and Check(@PColumnR(Cols[j])^.Condi) and (PColumnR(Cols[j])^.Idx>=0) then
             begin
               if PColumnR(Cols[j])^.DataType = 0 then
                  begin
                    if not PRowR(Rows[i])^.HasChild then
                       PRowR(Rows[i])^.Buffer[j].Value := DataSet.Fields[PColumnR(Cols[j])^.Idx].asString;
                  end
               else
                  begin
                    if VarIsNull(PRowR(Rows[i])^.Buffer[j].Value) then
                       PRowR(Rows[i])^.Buffer[j].Value := DataSet.Fields[PColumnR(Cols[j])^.Idx].asFloat
                    else
                       PRowR(Rows[i])^.Buffer[j].Value := PRowR(Rows[i])^.Buffer[j].Value + DataSet.Fields[PColumnR(Cols[j])^.Idx].asFloat;
                  end;
             end;
        end;
        if (PColumnR(Cols[j])^.DataType = 1) and Check(@PColumnR(Cols[j])^.Condi) and (PColumnR(Cols[j])^.Idx>=0) then
           begin
             if VarIsNull(Footer[j].Value) then
                Footer[j].Value := DataSet.Fields[PColumnR(Cols[j])^.Idx].asFloat
             else
                Footer[j].Value := Footer[j].Value + DataSet.Fields[PColumnR(Cols[j])^.Idx].asFloat;
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
  if V.alled then Exit;
  for i:=0 to 30 do
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
    rs.Fields[0].Value :=  i;
    rs.Fields[1].Value :=  PRowR(Rows[i])^.Title;
    if PRowR(Rows[i])^.HasChild then
       rs.Fields[2].Value :=  PRowR(Rows[i])^.Level
    else
       rs.Fields[2].Value :=  0;
    for j:=0 to Cols.Count -1 do
    begin
      rs.Fields[j+3].Value :=  PRowR(Rows[i])^.Buffer[j].Value;
    end;
    rs.Post;
  end;
end;

procedure TReportFactory.InitCondi(RCondi: pRCondi);
var
  i:integer;
begin
  RCondi^.Count := 0;
  RCondi^.alled := false;
  for i:=0 to 30 do
  begin
    RCondi^.idx[i] := -1;
    RCondi^.V[i] := '';
  end;
end;

end.
