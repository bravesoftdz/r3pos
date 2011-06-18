unit uReportFactory;

interface
uses
  Windows, Messages, DB, SysUtils, Variants, Classes, ZDataSet, DBGridEh;
const
  RF_DATA_SOURCE1='CLIENT_CODE=客户编码,ACCOUNT=登录账号,GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,SALE_AMT=数量,SALE_MNY=未税金额,SALE_TTL=金额,SALE_TAX=销项税额,SALE_CST=成本,SALE_PRF=毛利';
  RF_DATA_SOURCE2='ACCOUNT=登录账号,GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,STOCK_AMT=数量,STOCK_MNY=未税金额,STOCK_TTL=金额,STOCK_TAX=进项税额';
  RF_DATA_SOURCE3='ACCOUNT=登录账号,GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,BAL_AMT=库存,BAL_CST=成本,BAL_RTL=销售额';
  RF_DATA_SOURCE4='GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,SALE_AMT=数量,SALE_MNY=未税金额,SALE_TTL=金额,SALE_TAX=销项税额,SALE_CST=成本,SALE_PRF=毛利';
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
  idx:integer;
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
  idxflag:integer;
  FieldIndex:integer;
  FieldNIdx:integer;
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
  Buffer:array [0..8000] of RVariant;
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
    function IsDSIndex(sid:string):boolean;
    function GetIndexFieldName(sid:string):integer;
    function CreateIndex(sid: string): TList;
    function Check(V:pRCondi):boolean;
    procedure Init;
    procedure InitCondi(RCondi:pRCondi);
    procedure Load(rid:string);
    function CheckIndex(ATree:array of PRTemplate;idx,CurIdx:integer):boolean;
    procedure PrepareIndex;
    procedure PrepareHeader;
    procedure PrepareRows;
    procedure Prepare;
    procedure Calc;
    procedure Fill(rs:TDataSet);
    procedure CreateHeader(Grid:TDBGridEh);
  public
    Footer:array [0..8000] of RVariant;
    procedure Open(id:string;Grid:TDBGridEh);
    constructor Create(sourid:string);
    destructor Destroy;override;
    property DataSet:TDataSet read FDataSet write SetDataSet;
  end;

implementation
uses uGlobal,ufrmPrgBar;
{ TReportFactory }
type
  PIdxNode=^TIdxNode;
  TIdxNode=record
    id:string;
    title:string;
    seqid:string;
    FieldName:string;
    Relation:array [0..30] of TStringList;
    end;

function IdxNodeCompare(Item1, Item2: Pointer): Integer;
begin
  if PIdxNode(Item1)^.seqid>PIdxNode(Item2)^.seqid then
     result := 1
  else
  if PIdxNode(Item1)^.seqid<PIdxNode(Item2)^.seqid then
     result := 2
  else
     result := 0;
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
  i,j,c:integer;
begin
  for i:=0 to TLate.Count -1 do
    begin
      if PRTemplate(TLate[i])^.Data <> nil then
         begin
           for j:=0 to TList(PRTemplate(TLate[i])^.Data).Count -1 do
               begin
                 for c:=0 to 30 do
                   begin
                     if PIdxNode(TList(PRTemplate(TLate[i])^.Data)[j])^.Relation[c]<>nil then PIdxNode(TList(PRTemplate(TLate[i])^.Data)[j])^.Relation[c].Free;
                   end;
                 dispose(TList(PRTemplate(TLate[i])^.Data)[j]);
               end;
           TList(PRTemplate(TLate[i])^.Data).Free;
         end;
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
    rs.SQL.Text := 'select * from SYS_REPORT_TEMPLATE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_ID='''+rid+''' and CELL_TYPE=''1'' order by cell_col,cell_row';
    Factor.Open(rs);
    rs.first;
    while not rs.Eof do
      begin
        new(node);
        node^.row := rs.FieldbyName('CELL_ROW').AsInteger;
        node^.col := rs.FieldbyName('CELL_COL').AsInteger;
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
        node^.idxflag := rs.FieldbyName('INDEX_FLAG').AsInteger;
        node^.FieldIndex := GetIndexFieldName(node^.INDEX_ID);
        if DataSet.FindField(node^.INDEX_ID+'_TEXT')<>nil then
           node^.FieldNIdx :=  DataSet.FindField(node^.INDEX_ID+'_TEXT').Index
        else
           node^.FieldNIdx := -1;
        node^.Data := nil;
        node^.idx := TLate.Count;
        TLate.Add(node);
        rs.next;
      end;
    rs.Close;
    rs.SQL.Text := 'select * from SYS_REPORT_TEMPLATE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and REPORT_ID='''+rid+''' and CELL_TYPE=''2'' order by cell_row,cell_col';
    Factor.Open(rs);
    rs.first;
    while not rs.Eof do
      begin
        new(node);
        node^.row := rs.FieldbyName('CELL_ROW').AsInteger;
        node^.col := rs.FieldbyName('CELL_COL').AsInteger;
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
        node^.idxflag := rs.FieldbyName('INDEX_FLAG').AsInteger;
        node^.FieldIndex := GetIndexFieldName(node^.INDEX_ID);
        if DataSet.FindField(node^.INDEX_ID+'_TEXT')<>nil then
           node^.FieldNIdx :=  DataSet.FindField(node^.INDEX_ID+'_TEXT').Index
        else
           node^.FieldNIdx := -1;
        node^.Data := nil;
        node^.idx := TLate.Count;
        TLate.Add(node);
        rs.next;
      end;
  finally
    rs.free;
  end;
  if TLate.Count >30 then Raise Exception.Create('报表表样太复杂，最多只能定义30个指标'); 
end;

procedure TReportFactory.Open(id:string;Grid:TDBGridEh);
begin
Grid.DataSource.DataSet.DisableControls;
frmPrgBar.Show;
frmPrgBar.Update;
try
  frmPrgBar.WaitHint := '装载报表格式...';
  frmPrgBar.Precent := 10;
  Load(id);
  frmPrgBar.Precent := 15;
  Prepare;
  frmPrgBar.WaitHint := '准备显示表格';
  CreateHeader(Grid);
  frmPrgBar.Precent := 60;
  frmPrgBar.WaitHint := '计算数据...';
  Calc;
  frmPrgBar.Precent := 75;
  frmPrgBar.WaitHint := '填充显示数据...';
  Fill(Grid.DataSource.DataSet);
  frmPrgBar.Precent := 95;
finally
  Grid.DataSource.DataSet.EnableControls;
  frmPrgBar.Close;
end;
end;

procedure TReportFactory.Prepare;
begin
  frmPrgBar.WaitHint := '准备动态指标...';
  PrepareIndex;
  frmPrgBar.Precent := 20;
  frmPrgBar.WaitHint := '准备表头行...';
  PrepareHeader;
  frmPrgBar.Precent := 30;
  frmPrgBar.WaitHint := '准备数据行...';
  PrepareRows;
  frmPrgBar.Precent := 40;
end;
function TReportFactory.CreateIndex(sid:string):TList;
function CheckExists(id:string;vList:TList):boolean;
var
  i:integer;
begin
  result := false;
  for i:=vList.Count -1 downto 0 do
    begin
      if PIdxNode(vList[i])^.id=id then
         begin
           result := true;
           Exit;
         end;
    end;
end;
var
  rs:TZQuery;
  node:PIdxNode;
  id:string;
  idx,ndx,i:integer;
begin
  result := TList.Create;
  if sid='24' then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select RELATION_ID,RELATION_NAME from CA_RELATION where COMM not in (''02'',''12'') and RELATION_ID in (select RELATION_ID from CA_RELATIONS where RELATI_ID='+inttostr(Global.TENANT_ID)+') order by RELATION_ID';
         Factor.Open(rs);
         rs.First;
         while not rs.Eof do
           begin
             new(node);
             node^.id := rs.FieldbyName('RELATION_ID').AsString;
             node^.title := rs.FieldbyName('RELATION_NAME').AsString;
             node^.FieldName := 'SORT_ID'+sid;
             for i:=0 to 30 do node^.Relation[i] := nil;
             result.add(node);
             rs.Next;
           end;
         new(node);
         node^.id := '0';
         node^.title := '自主经营';
         node^.FieldName := 'SORT_ID'+sid;
         for i:=0 to 30 do node^.Relation[i] := nil;
         result.add(node);
       finally
         rs.Free;
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
           for i:=0 to 30 do node^.Relation[i] := nil;
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
  Created:boolean;
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
  Created := false;
  //展开列
  for i:=0 to TList(ATree[idx].Data).Count -1 do
    begin
      ATree[idx].curid := PIdxNode(TList(ATree[idx].Data)[i])^.id;
      ATree[idx].curname := PIdxNode(TList(ATree[idx].Data)[i])^.title;
      ATree[idx].curfield := PIdxNode(TList(ATree[idx].Data)[i])^.FieldName;
      if ATree[idx+1]=nil then //到根结点了
         begin
           if not CheckIndex(ATree,idx,i) then continue;
           vList.CommaText := ATree[idx].FieldName;
           for c:=0 to vList.Count-1 do
           begin
             Created := true;
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
  if (ATree[idx].sumFlag=2) and Created then
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
      if not CheckIndex(ATree,idx,i) then continue;
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
      for c:=0 to Cols.Count do Row^.Buffer[c].Value := null; 
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
  Grid.Columns.BeginUpdate;
  try
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
  finally
    Grid.Columns.EndUpdate;
  end;
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

function TReportFactory.CheckIndex(ATree: array of PRTemplate;idx,CurIdx:integer): boolean;
var
  i,Index:integer;
  IdxNode:PIdxNode;
begin
  result := true;
  if ATree[idx].idxflag <> 2 then Exit;
  if idx=0 then Exit;
  result := true;
  IdxNode := PIdxNode(TList(ATree[idx].Data)[CurIdx]);
  for i:=0 to idx-1 do
    begin
      if (IdxNode^.Relation[ATree[i].idx]<>nil) and IdxNode^.Relation[ATree[i].idx].Find(ATree[i].curid,Index) then
         continue
      else
         begin
           result := false;
           break;
         end;
    end;
end;

function TReportFactory.GetIndexFieldName(sid: string): integer;
begin
  result := -1;
  try
  if (sid='FIELD') or (sid='TOTAL') then Exit;
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
     or
     (sid='CREGION_ID1')
     or
     (sid='SREGION_ID1')
     or
     (sid='CREGION_ID2')
     or
     (sid='SREGION_ID2')
  then
     result := DataSet.FindField(sid).Index
  else
     result := DataSet.FindField('SORT_ID'+sid).Index;
  except
     Raise Exception.Create('数据源不支持'+sid+'指标');
  end;
end;

procedure TReportFactory.PrepareIndex;
procedure AddRelation(DataSet:TDataSet);
var
  i,j,c:integer;
  IdxNode:PIdxNode;
begin
  for i:=0 to TLate.Count-1 do
    begin
      if PRTemplate(TLate[i])^.Data=nil then Continue;
      if PRTemplate(TLate[i])^.FieldIndex<0 then Continue;
      for j:=0 to TList(PRTemplate(TLate[i])^.Data).Count -1 do
      begin
        IdxNode := PIdxNode(TList(PRTemplate(TLate[i])^.Data)[j]);
        if DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString=IdxNode^.id then //当数据源的ID为当前ID时,加入其他指标id关系
           begin
              for c:=0 to TLate.Count-1 do
              begin
                if c=i then continue;
                if PRTemplate(TLate[c])^.FieldIndex<0 then Continue;
                if IdxNode.Relation[c]=nil then
                   begin
                     IdxNode.Relation[c] := TStringList.Create;
                     IdxNode.Relation[c].Duplicates := dupIgnore;
                     IdxNode.Relation[c].Sorted := true;
                   end;
                IdxNode.Relation[c].Add(DataSet.Fields[PRTemplate(TLate[c])^.FieldIndex].AsString);
              end;
           end;
      end;
    end;
end;
function CheckExists(id:string;vList:TList):boolean;
var
  i:integer;
begin
  result := false;
  for i:=vList.Count -1 downto 0 do
    begin
      if PIdxNode(vList[i])^.id=id then
         begin
           result := true;
           Exit;
         end;
    end;
end;
var
  i,j:integer;
  node:PIdxNode;
  dept,users,region,sort:TZQuery;
begin
  for i:=0 to TLate.Count-1 do
  begin
    if not IsDSIndex(PRTemplate(TLate[i])^.INDEX_ID) then
       begin
         PRTemplate(TLate[i])^.Data := CreateIndex(PRTemplate(TLate[i])^.INDEX_ID);
       end;
  end;
  dept := Global.GetZQueryFromName('CA_DEPT_INFO');
  users := Global.GetZQueryFromName('CA_USERS');
  region := Global.GetZQueryFromName('PUB_REGION_INFO');
  sort := Global.GetZQueryFromName('PUB_GOODSSORT');
  DataSet.First;
  while not DataSet.Eof do
    begin
      for i:=0 to TLate.Count-1 do
        begin
          if IsDSIndex(PRTemplate(TLate[i])^.INDEX_ID) and (PRTemplate(TLate[i])^.Data=nil) then PRTemplate(TLate[i])^.Data := TList.Create;
          if IsDSIndex(PRTemplate(TLate[i])^.INDEX_ID) and not CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
             begin
                new(node);
                node^.id := DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString;
                node^.seqid := node^.id;
                node^.FieldName := PRTemplate(TLate[i])^.INDEX_ID;
                for j:=0 to 30 do node^.Relation[j] := nil;
                if PRTemplate(TLate[i])^.FieldNIdx>=0 then
                   begin
                     node^.title := DataSet.Fields[PRTemplate(TLate[i])^.FieldNIdx].AsString;
                     if PRTemplate(TLate[i])^.INDEX_ID='CLIENT_ID' then
                        node^.seqid := DataSet.FieldbyName('CLIENT_CODE').AsString
                     else
                     if PRTemplate(TLate[i])^.INDEX_ID='GODS_ID' then
                        node^.seqid := DataSet.FieldbyName('GODS_CODE').AsString;
                   end
                else
                begin
                  if PRTemplate(TLate[i])^.INDEX_ID='DEPT_ID' then
                     begin
                       if dept.Locate('DEPT_ID',node^.id,[]) then
                          node^.title := dept.FieldbyName('DEPT_NAME').AsString
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '@';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '未知名称';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='GUIDE_USER' then
                     begin
                       if users.Locate('USER_ID',node^.id,[]) then
                          begin
                            node^.title := users.FieldbyName('USER_NAME').AsString;
                            node^.seqid := users.FieldbyName('ACCOUNT').AsString;
                          end
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '@';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '未知名称';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='CREGION_ID' then
                     begin
                       if (node^.id<>'#') and region.Locate('CODE_ID',node^.id,[]) then
                          node^.title := region.FieldbyName('CODE_NAME').AsString
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='SREGION_ID' then
                     begin
                       if (node^.id<>'#') and region.Locate('CODE_ID',node^.id,[]) then
                          node^.title := region.FieldbyName('CODE_NAME').AsString
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='SREGION_ID1' then
                     begin
                       if (node^.id<>'#') then node^.id := copy(node^.id,1,2)+'0000';
                       if (node^.id<>'#') and region.Locate('CODE_ID',node^.id,[]) then
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := node^.id;
                            DataSet.Post;
                            node^.title := region.FieldbyName('CODE_NAME').AsString;
                            if CheckExists(node^.id,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                          end
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='SREGION_ID2' then
                     begin
                       if (node^.id<>'#') then
                       begin
                       node^.id := copy(node^.id,1,4)+'00';
                       if not region.Locate('CODE_ID',node^.id,[]) then
                          node^.id := copy(node^.id,1,2)+'0000';
                       end;
                       if (node^.id<>'#') and region.Locate('CODE_ID',node^.id,[]) then
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := node^.id;
                            DataSet.Post;
                            node^.title := region.FieldbyName('CODE_NAME').AsString;
                            if CheckExists(node^.id,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                          end
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='CREGION_ID1' then
                     begin
                       if (node^.id<>'#') then node^.id := copy(node^.id,1,2)+'0000';
                       if (node^.id<>'#') and region.Locate('CODE_ID',node^.id,[]) then
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := node^.id;
                            DataSet.Post;
                            node^.title := region.FieldbyName('CODE_NAME').AsString;
                            if CheckExists(node^.id,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                          end
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='CREGION_ID2' then
                     begin
                       if (node^.id<>'#') then
                       begin
                       node^.id := copy(node^.id,1,4)+'00';
                       if not region.Locate('CODE_ID',node^.id,[]) then
                          node^.id := copy(node^.id,1,2)+'0000';
                       end;
                       if (node^.id<>'#') and region.Locate('CODE_ID',node^.id,[]) then
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := node^.id;
                            DataSet.Post;
                            node^.title := region.FieldbyName('CODE_NAME').AsString;
                            if CheckExists(node^.id,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                          end
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='21' then
                     begin
                       node^.FieldName := 'SORT_ID'+PRTemplate(TLate[i])^.INDEX_ID;
                       if (node^.id<>'#') and sort.Locate('SORT_ID',node^.id,[]) then
                          begin
                            if sort.locate('RELATION_ID;LEVEL_ID',VarArrayOf([sort.FieldbyName('RELATION_ID').AsString,copy(sort.FieldbyName('LEVEL_ID').AsString,1,4)]),[]) then
                            begin
                               node^.id := sort.FieldbyName('SORT_ID').AsString;
                               node^.title := sort.FieldbyName('SORT_NAME').AsString;
                               node^.seqid := sort.FieldbyName('RELATION_ID').asString +'#'+sort.FieldbyName('LEVEL_ID').asString;
                               DataSet.Edit;
                               DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := node^.id;
                               DataSet.Post;
                               if CheckExists(node^.id,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            end
                            else
                            begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                            end;
                          end
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='22' then
                     begin
                       node^.FieldName := 'SORT_ID'+PRTemplate(TLate[i])^.INDEX_ID;
                       if (node^.id<>'#') and sort.Locate('SORT_ID',node^.id,[]) then
                          begin
                            if sort.locate('RELATION_ID;LEVEL_ID',VarArrayOf([sort.FieldbyName('RELATION_ID').AsString,copy(sort.FieldbyName('LEVEL_ID').AsString,1,8)]),[]) then
                            begin
                               node^.id := sort.FieldbyName('SORT_ID').AsString;
                               node^.title := sort.FieldbyName('SORT_NAME').AsString;
                               node^.seqid := sort.FieldbyName('RELATION_ID').asString +'#'+sort.FieldbyName('LEVEL_ID').asString;
                               DataSet.Edit;
                               DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := node^.id;
                               DataSet.Post;
                               if CheckExists(node^.id,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            end
                            else
                            begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                            end;
                          end
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                  if PRTemplate(TLate[i])^.INDEX_ID='23' then
                     begin
                       node^.FieldName := 'SORT_ID'+PRTemplate(TLate[i])^.INDEX_ID;
                       if (node^.id<>'#') and sort.Locate('SORT_ID',node^.id,[]) then
                          begin
                            if sort.locate('RELATION_ID;LEVEL_ID',VarArrayOf([sort.FieldbyName('RELATION_ID').AsString,copy(sort.FieldbyName('LEVEL_ID').AsString,1,12)]),[]) then
                            begin
                               node^.id := sort.FieldbyName('SORT_ID').AsString;
                               node^.title := sort.FieldbyName('SORT_NAME').AsString;
                               node^.seqid := sort.FieldbyName('RELATION_ID').asString +'#'+sort.FieldbyName('LEVEL_ID').asString;
                               DataSet.Edit;
                               DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := node^.id;
                               DataSet.Post;
                               if CheckExists(node^.id,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            end
                            else
                            begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                            end;
                          end
                       else
                          begin
                            DataSet.Edit;
                            DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
                            DataSet.Post;
                            if CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                               begin
                                 dispose(node);
                                 continue;
                               end;
                            node^.title := '无';
                          end;
                     end;
                end;
                TList(PRTemplate(TLate[i])^.Data).add(node);
             end;
        end;
      //准备指标关系
      AddRelation(DataSet);
      DataSet.Next;
    end;
  for i:=0 to TLate.Count-1 do
  begin
    if IsDSIndex(PRTemplate(TLate[i])^.INDEX_ID) and (PRTemplate(TLate[i])^.Data<>nil) then
       begin
         TList(PRTemplate(TLate[i])^.Data).Sort(@IdxNodeCompare); 
       end;
  end;
end;

function TReportFactory.IsDSIndex(sid: string): boolean;
begin
  result :=
     (sid='21')
     or
     (sid='22')
     or
     (sid='23')
     or
     (sid='DEPT_ID')
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
     or
     (sid='CREGION_ID1')
     or
     (sid='SREGION_ID1')
     or
     (sid='CREGION_ID2')
     or
     (sid='SREGION_ID2');
end;

end.
