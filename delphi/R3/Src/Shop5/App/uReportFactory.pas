unit uReportFactory;

interface
uses
  Windows, Messages, DB, SysUtils, Variants, Classes, ZDataSet, DBGridEh;
const
  RF_DATA_SOURCE1='CLIENT_CODE=客户编码,ACCOUNT=登录账号,GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,SALE_AMT=数量,SALE_MNY=未税金额,SALE_TTL=金额,SALE_TAX=销项税额,SALE_CST=成本,SALE_PRF=毛利';
  RF_DATA_SOURCE2='ACCOUNT=登录账号,GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,STOCK_AMT=数量,STOCK_MNY=未税金额,STOCK_TTL=金额,STOCK_TAX=进项税额';
  RF_DATA_SOURCE3='ACCOUNT=登录账号,GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,BAL_AMT=库存,BAL_CST=成本,BAL_RTL=销售额';
  RF_DATA_SOURCE4=
     'GODS_CODE=货号,BARCODE=条码,UNIT_NAME=单位,STOCK_AMT=进货数量,STOCK_AMT_RATE=进货占比,STOCK_MNY=进货金额,STOCK_TAX=进项税额,STOCK_TTL=进货总额,STOCK_TTL_RATE=进货金额占比,'+
     'YEAR_STOCK_AMT=进货数量(同期),YEAR_STOCK_AMT_DIFF=进货数量(同期差),YEAR_STOCK_MNY=进货金额(同期),YEAR_STOCK_TAX=进项税额(同期),YEAR_STOCK_TTL=进货总额(同期),YEAR_STOCK_TTL_DIFF=进货总额(同期差),'+
     'PRIOR_STOCK_AMT=进货数量(上期),PRIOR_STOCK_AMT_DIFF=进货数量(上期差),PRIOR_STOCK_MNY=进货金额(上期),PRIOR_STOCK_TAX=进项税额(上期),PRIOR_STOCK_TTL=进货总额(上期),PRIOR_STOCK_TTL_DIFF=进货总额(上期差),'+
     'SALE_AMT=销量,SALE_AMT_RATE=销量(占比),SALE_MNY=销售金额,SALE_TTL=销售总额,SALE_TTL_RATE=销售总额(占比),SALE_TAX=销项税额,SALE_CST=成本,SALE_CST_RATE=成本(占比),SALE_PRF=毛利,SALE_PRF_RATE=毛利(占比),'+
     'PRIOR_YEAR_AMT=销量(同期),PRIOR_YEAR_AMT_DIFF=销量(同期差),PRIOR_YEAR_MNY=销售金额(同期),PRIOR_YEAR_TTL=销售总额(同期),PRIOR_YEAR_TTL_DIFF=销售总额(同期差),PRIOR_YEAR_TAX=销项税额(同期),PRIOR_YEAR_CST=成本(同期),'+
     'PRIOR_YEAR_CST_DIFF=成本(同期差),PRIOR_YEAR_PRF=毛利(同期),PRIOR_YEAR_PRF_DIFF=毛利(同期差),'+
     'PRIOR_MONTH_AMT=销量(上期),PRIOR_MONTH_AMT_DIFF=销量(上期差),PRIOR_MONTH_MNY=销售金额(上期),PRIOR_MONTH_TTL=销售总额(上期),PRIOR_MONTH_TTL_DIFF=销售总额(上期差),PRIOR_MONTH_TAX=销项税额(上期),PRIOR_MONTH_CST=成本(上期),'+
     'PRIOR_MONTH_CST_DIFF=成本(上期差),PRIOR_MONTH_PRF=毛利(上期),PRIOR_MONTH_PRF_DIFF=毛利(上期差),'+
     'ORG_AMT=期初数量,ORG_CST=期初成本,BAL_AMT=结存数量,BAL_CST=结存成本,DAYS_AMT=销售周期,AVG_SALE_AMT=日均销量,'+
     'CURR_SALE_PRF_RATE=毛利率,YEAR_SALE_PRF_RATE=毛利率(同期),PRIOR_SALE_PRF_RATE=毛利率(上期),YEAR_SALE_PRF_DIFF_RATE=毛利率(同期差),PRIOR_SALE_PRF_DIFF_RATE=毛利率(上期差),HINT_DAYS_AMT=库存建议';
     
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
  width:integer;
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
  width:integer;
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
    Func:TStringList;
    FSafeDay: integer;
    procedure SetDataSet(const Value: TDataSet);
    procedure SetSafeDay(const Value: integer);
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
    procedure AddFunc(fn:string;idx:integer);
    procedure Fill(rs:TDataSet);
    procedure CreateHeader(Grid:TDBGridEh);
    function CalcFunc(fn:string;vRows:array of RVariant):Variant;
  public
    Footer:array [0..8000] of RVariant;
    procedure Open(id:string;Grid:TDBGridEh);
    constructor Create(sourid:string);
    destructor Destroy;override;
    property DataSet:TDataSet read FDataSet write SetDataSet;
    property SafeDay:integer read FSafeDay write SetSafeDay;
  end;

implementation
uses uGlobal,ufrmPrgBar,uShopGlobal;
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
     result := -1
  else
     result := 0;
end;

constructor TReportFactory.Create(sourid:string);
begin
  Cols := TList.Create;
  Rows := TList.Create;
  TLate := TList.Create;
  Fields := TStringList.Create;
  Func := TStringList.Create;
  DataSet := TZQuery.Create(nil);
  if sourid='1' then Fields.CommaText := RF_DATA_SOURCE1;
  if sourid='2' then Fields.CommaText := RF_DATA_SOURCE2;
  if sourid='3' then Fields.CommaText := RF_DATA_SOURCE3;
  if sourid='4' then Fields.CommaText := RF_DATA_SOURCE4;

  safeDay := StrtoIntDef(ShopGlobal.GetParameter('SAFE_DAY'),7);
end;

destructor TReportFactory.Destroy;
begin
  DataSet.Free;
  TLate.Free;
  Cols.Free;
  Rows.Free;
  Fields.Free;
  Func.Free;
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
        if pos('=',node^.FieldName)=0 then node^.FieldName := stringreplace(node^.FieldName,',','=,',[rfReplaceAll])+'='; 
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
        if rs.FindField('CELL_WIDTH')<>nil then
           node^.width := rs.FindField('CELL_WIDTH').AsInteger
        else
           node^.width := 0;
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
        if pos('=',node^.FieldName)=0 then node^.FieldName := stringreplace(node^.FieldName,',','=,',[rfReplaceAll])+'='; 
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
         node^.title := defaultRelatin;
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
         Column^.Title := ATree[idx].Title;
         Column^.width := ATree[idx].width;
         if (vList.Count>1) then
            begin
              if vList.ValueFromIndex[c]='' then
                 Column^.Title := Column^.Title+'|'+Fields.Values[vList.Names[c]]
              else
                 Column^.Title := Column^.Title+'|'+vList.ValueFromIndex[c];
            end;
         Column^.FieldName := vList.Names[c];
         if DataSet.FindField(Column^.FieldName)<>nil then
            Column^.Idx := DataSet.FindField(Column^.FieldName).Index
         else
            Column^.Idx := -1;
         Cols.Add(Column);
         AddFunc(Column^.FieldName,Cols.Count-1);
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
         Column^.width := ATree[idx].width;
         if vList.ValueFromIndex[c]='' then
            Column^.Title := Fields.Values[vList.Names[c]]
         else
            Column^.Title := vList.ValueFromIndex[c];
         Column^.FieldName := vList.Names[c];
         if DataSet.FindField(Column^.FieldName)<>nil then
            Column^.Idx := DataSet.FindField(Column^.FieldName).Index
         else
            Column^.Idx := -1;
         Cols.Add(Column);
         AddFunc(Column^.FieldName,Cols.Count-1);
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
             Column^.width := ATree[idx].width;
             InitCondi(@Column.Condi);
             for j:=idx downto 0 do
                begin
                  if Column^.Title<>'' then Column^.Title := '|'+Column^.Title;
                  Column^.Title := ATree[j].curname+Column^.Title;
                  Column^.Condi.V[j] := ATree[j].curid;
                  Column^.Condi.idx[j] := DataSet.FindField(ATree[j].curfield).Index;
                end;
             if (vList.Count>1) then
                begin
                  if vList.ValueFromIndex[c]='' then
                     Column^.Title := Column^.Title+'|'+Fields.Values[vList.Names[c]]
                  else
                     Column^.Title := Column^.Title+'|'+vList.ValueFromIndex[c];
                end;
             Column^.FieldName := vList.Names[c];
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
         Column^.width := ATree[idx].width;
         for j:=idx-1 downto 0 do
            begin
              if Column^.Title<>'' then Column^.Title := '|'+Column^.Title;
              Column^.Title := ATree[j].curname+Column^.Title;
              Column^.Condi.V[j] := ATree[j].curid;
              Column^.Condi.idx[j] := DataSet.FindField(ATree[j].curfield).Index;
            end;
         if (vList.Count>1) then
            begin
              if vList.ValueFromIndex[c]='' then
                 Column^.Title := Column^.Title+'|'+Fields.Values[vList.Names[c]]
              else
                 Column^.Title := Column^.Title+'|'+Fields.ValueFromIndex[c];
            end;
         Column^.FieldName := vList.Names[c];
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
        if PColumnR(Cols[i])^.width <> 0 then
           Column.Width := PColumnR(Cols[i])^.width;
      end
      else
      begin
        tb.FieldDefs.Add('A_'+inttostr(i),ftFloat,0,true);
        Column.Width := 60;
        if pos('_RATE',PColumnR(Cols[i])^.FieldName)=0 then
        begin
          Column.DisplayFormat := '#0.00';
          Column.Footer.DisplayFormat := '#0.00';
        end
        else
        begin
          Column.DisplayFormat := '#0.00%';
          Column.Footer.DisplayFormat := '#0.00%';
        end;
        case PColumnR(Cols[i])^.SumType of
        1:Column.Footer.ValueType := fvtSum;
        2:Column.Footer.ValueType := fvtAvg;
        3:Column.Footer.ValueType := fvtCount;
        end;
        if PColumnR(Cols[i])^.width <> 0 then
           Column.Width := PColumnR(Cols[i])^.width;
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
var i,j,w:integer;
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
                    if VarIsNull(PRowR(Rows[i])^.Buffer[j].Value) or VarIsClear(PRowR(Rows[i])^.Buffer[j].Value) then
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
  if Func.Count > 0 then //有计算公式
    begin
      for i:=0 to Rows.Count -1 do
      begin
        for j:=0 to Func.Count -1 do
        begin
          w := Integer(Func.Objects[j]);
          if w>=0 then
             PRowR(Rows[i])^.Buffer[w].Value := CalcFunc(Func[j],PRowR(Rows[i])^.Buffer);
        end;
      end;
      for j:=0 to Func.Count -1 do
      begin
        w := Integer(Func.Objects[j]);
        if (w>=0) then
           begin
             Footer[w].Value := CalcFunc(Func[j],Footer);
             if Footer[w].Value=0 then Footer[w].Value := null;
           end;
      end;
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
      rs.Fields[j+3].Value := PRowR(Rows[i])^.Buffer[j].Value;
      if VarIsNumeric(rs.Fields[j+3].Value) and (rs.Fields[j+3].AsFloat=0) then
         rs.Fields[j+3].Value := null;
    end;
    rs.Post;
  end;
  rs.First;
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
     or
     (sid='SHOP_TYPE')
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
  dept,users,region,sort,shpType:TZQuery;
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
  shpType := Global.GetZQueryFromName('PUB_SHOP_TYPE');
  DataSet.First;
  while not DataSet.Eof do
    begin
      for i:=0 to TLate.Count-1 do
        begin
          if IsDSIndex(PRTemplate(TLate[i])^.INDEX_ID) and (PRTemplate(TLate[i])^.Data=nil) then PRTemplate(TLate[i])^.Data := TList.Create;
          //商品指标
          if not IsDSIndex(PRTemplate(TLate[i])^.INDEX_ID) and (PRTemplate(TLate[i])^.FieldIndex>=0) and not CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
             begin
               DataSet.Edit;
               DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString := '#';
               DataSet.Post;
               if not CheckExists(DataSet.Fields[PRTemplate(TLate[i])^.FieldIndex].AsString,TList(PRTemplate(TLate[i])^.Data)) then
                  begin
                     new(node);
                     node^.id := '#';
                     node^.title := '无定义';
                     node^.FieldName := 'SORT_ID'+PRTemplate(TLate[i])^.INDEX_ID;
                     for j:=0 to 30 do node^.Relation[j] := nil;
                     TList(PRTemplate(TLate[i])^.Data).add(node);
                  end;
             end;
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
                  if PRTemplate(TLate[i])^.INDEX_ID='SHOP_TYPE' then
                     begin
                       if shpType.Locate('CODE_ID',node^.id,[]) then
                          node^.title := shpType.FieldbyName('CODE_NAME').AsString
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
     (sid='SHOP_TYPE')
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

function TReportFactory.CalcFunc(fn: string;vRows:array of RVariant): Variant;
function GetFuncData(FieldName:string):integer;
var
  i:integer;
begin
  result := -1;
  for i:=0 to Cols.Count -1 do
    begin
      if (PColumnR(Cols[i])^.FieldName=FieldName) then
         begin
           result := i;
           break;
         end;
    end;
end;
var
  v1,v2:real;
  w,w1,w2:integer;
begin
  result := 0;
  if fn='AVG_SALE_AMT' then
     begin
       w1 := GetFuncData('SALE_AMT');
       w2 := GetFuncData('DAYS_AMT');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       if vRows[w2].Value<>0 then
          result := vRows[w1].Value/vRows[w2].Value;
     end
  else
  if fn='STOCK_AMT_RATE' then
     begin
       w := GetFuncData('STOCK_AMT');
       if w<0 then Exit;
       if VarIsNull(Footer[w].Value) then Exit;
       if VarIsNull(vRows[w].Value) then Exit;
       if Footer[w].Value=0 then Exit;
       result := vRows[w].Value/Footer[w].Value*100;
     end
  else
  if fn='YEAR_STOCK_AMT_DIFF' then
     begin
       w1 := GetFuncData('STOCK_AMT');
       w2 := GetFuncData('YEAR_STOCK_AMT');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='PRIOR_STOCK_AMT_DIFF' then
     begin
       w1 := GetFuncData('STOCK_AMT');
       w2 := GetFuncData('PRIOR_STOCK_AMT');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='STOCK_TTL_RATE' then
     begin
       w := GetFuncData('STOCK_TTL');
       if w<0 then Exit;
       if VarIsNull(Footer[w].Value) then Exit;
       if VarIsNull(vRows[w].Value) then Exit;
       if Footer[w].Value=0 then Exit;
       result := vRows[w].Value/Footer[w].Value*100;
     end
  else
  if fn='YEAR_STOCK_TTL_DIFF' then
     begin
       w1 := GetFuncData('STOCK_TTL');
       w2 := GetFuncData('YEAR_STOCK_TTL');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='PRIOR_STOCK_TTL_DIFF' then
     begin
       w1 := GetFuncData('STOCK_TTL');
       w2 := GetFuncData('PRIOR_STOCK_TTL');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='SALE_AMT_RATE' then
     begin
       w := GetFuncData('SALE_AMT');
       if w<0 then Exit;
       if VarIsNull(Footer[w].Value) then Exit;
       if VarIsNull(vRows[w].Value) then Exit;
       if Footer[w].Value=0 then Exit;
       result := vRows[w].Value/Footer[w].Value*100;
     end
  else
  if fn='PRIOR_YEAR_AMT_DIFF' then
     begin
       w1 := GetFuncData('SALE_AMT');
       w2 := GetFuncData('PRIOR_YEAR_AMT');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='PRIOR_MONTH_AMT_DIFF' then
     begin
       w1 := GetFuncData('SALE_AMT');
       w2 := GetFuncData('PRIOR_MONTH_AMT');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='SALE_TTL_RATE' then
     begin
       w := GetFuncData('SALE_TTL');
       if w<0 then Exit;
       if VarIsNull(vRows[w].Value) then Exit;
       if VarIsNull(Footer[w].Value) then Exit;
       if Footer[w].Value=0 then Exit;
       result := vRows[w].Value/Footer[w].Value*100;
     end
  else
  if fn='PRIOR_YEAR_TTL_DIFF' then
     begin
       w1 := GetFuncData('SALE_TTL');
       w2 := GetFuncData('PRIOR_YEAR_TTL');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='PRIOR_MONTH_TTL_DIFF' then
     begin
       w1 := GetFuncData('SALE_TTL');
       w2 := GetFuncData('PRIOR_MONTH_TTL');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='SALE_CST_RATE' then
     begin
       w := GetFuncData('SALE_CST');
       if w<0 then Exit;
       if VarIsNull(Footer[w].Value) then Exit;
       if VarIsNull(vRows[w].Value) then Exit;
       if Footer[w].Value=0 then Exit;
       result := vRows[w].Value/Footer[w].Value*100;
     end
  else
  if fn='PRIOR_YEAR_CST_DIFF' then
     begin
       w1 := GetFuncData('SALE_CST');
       w2 := GetFuncData('PRIOR_YEAR_CST');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='PRIOR_MONTH_CST_DIFF' then
     begin
       w1 := GetFuncData('SALE_CST');
       w2 := GetFuncData('PRIOR_MONTH_CST');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='SALE_PRF_RATE' then
     begin
       w := GetFuncData('SALE_PRF');
       if w<0 then Exit;
       if VarIsNull(Footer[w].Value) then Exit;
       if VarIsNull(vRows[w].Value) then Exit;
       if Footer[w].Value=0 then Exit;
       result := vRows[w].Value/Footer[w].Value*100;
     end
  else
  if fn='PRIOR_YEAR_PRF_DIFF' then
     begin
       w1 := GetFuncData('SALE_PRF');
       w2 := GetFuncData('PRIOR_YEAR_PRF');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='PRIOR_MONTH_PRF_DIFF' then
     begin
       w1 := GetFuncData('SALE_PRF');
       w2 := GetFuncData('PRIOR_MONTH_PRF');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='CURR_SALE_PRF_RATE' then
     begin
       w1 := GetFuncData('SALE_PRF');
       w2 := GetFuncData('SALE_MNY');
       if w1<0 then Exit;
       if w2<0 then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       if vRows[w2].Value=0 then Exit;
       result := vRows[w1].Value/vRows[w2].Value*100;
     end
  else
  if fn='YEAR_SALE_PRF_RATE' then
     begin
       w1 := GetFuncData('PRIOR_YEAR_PRF');
       w2 := GetFuncData('PRIOR_YEAR_MNY');
       if w1<0 then Exit;
       if w2<0 then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       if vRows[w2].Value=0 then Exit;
       result := vRows[w1].Value/vRows[w2].Value*100;
     end
  else
  if fn='PRIOR_SALE_PRF_RATE' then
     begin
       w1 := GetFuncData('PRIOR_MONTH_PRF');
       w2 := GetFuncData('PRIOR_MONTH_MNY');
       if w1<0 then Exit;
       if w2<0 then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       if vRows[w2].Value=0 then Exit;
       result := vRows[w1].Value/vRows[w2].Value*100;
     end
  else
  if fn='YEAR_SALE_PRF_DIFF_RATE' then
     begin
       w1 := GetFuncData('CURR_SALE_PRF_RATE');
       w2 := GetFuncData('YEAR_SALE_PRF_RATE');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='PRIOR_SALE_PRF_DIFF_RATE' then
     begin
       w1 := GetFuncData('CURR_SALE_PRF_RATE');
       w2 := GetFuncData('PRIOR_SALE_PRF_RATE');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       result := vRows[w1].Value-vRows[w2].Value;
     end
  else
  if fn='HINT_DAYS_AMT' then
     begin
       w1 := GetFuncData('BAL_AMT');
       w2 := GetFuncData('AVG_SALE_AMT');
       if (w1<0) or (w2<0) then Exit;
       if VarIsNull(vRows[w1].Value) or VarIsClear(vRows[w1].Value) then Exit;
       if VarIsNull(vRows[w2].Value) or VarIsClear(vRows[w2].Value) then Exit;
       if vRows[w2].Value=0 then result := null
       else
          begin
            if (vRows[w1].Value/vRows[w2].Value)<SafeDay then
               result := '建议补货'
            else
            if (vRows[w1].Value/vRows[w2].Value)>SafeDay then
               result := '加强促销';
          end;
     end;


end;

procedure TReportFactory.AddFunc(fn: string;idx:integer);
begin
  if Func.IndexOfObject(TObject(idx))>=0 then Exit;
  if fn='AVG_SALE_AMT' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='STOCK_AMT_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='YEAR_STOCK_AMT_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_STOCK_AMT_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='STOCK_TTL_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='YEAR_STOCK_TTL_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_STOCK_TTL_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='SALE_AMT_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_YEAR_AMT_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_MONTH_AMT_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='SALE_TTL_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_YEAR_TTL_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_MONTH_TTL_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='SALE_CST_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_YEAR_CST_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_MONTH_CST_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='SALE_PRF_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_YEAR_PRF_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_MONTH_PRF_DIFF' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='CURR_SALE_PRF_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='YEAR_SALE_PRF_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_SALE_PRF_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='SALE_PRF_DIFF_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='YEAR_SALE_PRF_DIFF_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='PRIOR_SALE_PRF_DIFF_RATE' then
     Func.AddObject(fn,TObject(idx))
  else
  if fn='HINT_DAYS_AMT' then
     Func.AddObject(fn,TObject(idx));



end;

procedure TReportFactory.SetSafeDay(const Value: integer);
begin
  FSafeDay := Value;
end;

end.
