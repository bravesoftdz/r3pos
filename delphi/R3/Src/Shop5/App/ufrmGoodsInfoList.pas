unit ufrmGoodsInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,ADODB,
  cxContainer, cxEdit, cxTextEdit, RzButton, zBase, DB, DBClient, RzTreeVw,
  FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  DBGrids, Buttons;

type
  TfrmGoodsInfoList = class(TframeToolForm)
    RzPanel1: TRzPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    edtKey: TcxTextEdit;
    DataSource1: TDataSource;
    rzTree: TRzTreeView;
    Splitter1: TSplitter;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    btnOk: TRzBitBtn;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    stbPanel: TPanel;
    Label1: TLabel;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    actCopyNew: TAction;
    N7: TMenuItem;
    actPrintBarCode: TAction;
    PrintDBGridEh1: TPrintDBGridEh;
    cdsBrowser: TZQuery;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actFindExecute(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actNewExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure rzTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure ToolButton8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure actCopyNewExecute(Sender: TObject);
    procedure actPrintBarCodeExecute(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1CellClick(Column: TColumnEh);
  private
     edtProperty2,edtProperty1: TZQuery;
     procedure GetNo;
     procedure LoadTree;
     procedure DoTreeChange(Sender: TObject; Node: TTreeNode);  //
  public
    { Public declarations }
    IsEnd,IsChain,IsCompany: boolean;
    MaxId,TENANT_ID:string;
    locked:boolean;
    rcAmt:integer;
    function  CheckRoot:boolean;
    procedure AddRecord(AObj:TRecord_);
    procedure InitGrid;
    function  EncodeSQL(id:string;var Cnd:string):string;
    procedure Open(Id:string);
    function  FindNode(ID: string): TTreeNode;
    function  PropertyEnabled:boolean;
    procedure GetProperty;
    procedure PrintBarcode;
  end;

implementation

uses
  uTreeUtil,uGlobal,ufrmGoodsInfo, uShopGlobal,uCtrlUtil,
  uShopUtil,uFnUtil,ufrmEhLibReport;

{$R *.dfm}
 
procedure TfrmGoodsInfoList.AddRecord(AObj: TRecord_);
var GODS_ID,SORT:string;
begin
  if not cdsBrowser.Active then Exit;  
  if cdsBrowser.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[])
  then
  begin
    GODS_ID:=cdsBrowser.FieldByName('GODS_ID').AsString;
    cdsBrowser.Edit;
    AObj.WriteToDataSet(cdsBrowser,false);
    if cdsBrowser.FieldbyName('NEW_OUTPRICE').AsFloat <> 0 then
       cdsBrowser.FieldByName('PROFIT_RATE').AsString := formatfloat('#0.0',cdsBrowser.FieldbyName('NEW_INPRICE').AsFloat*100/cdsBrowser.FieldbyName('NEW_OUTPRICE').AsFloat)
    else
       cdsBrowser.FieldByName('PROFIT_RATE').Value := null;
    cdsBrowser.FieldByName('selflag').AsBoolean:=False;
    cdsBrowser.Post;
  end else
  begin
    GODS_ID:=AObj.FieldByName('GODS_ID').AsString;
    cdsBrowser.Append;
    AObj.WriteToDataSet(cdsBrowser,false);
    if cdsBrowser.FieldbyName('NEW_OUTPRICE').AsFloat <> 0 then
       cdsBrowser.FieldByName('PROFIT_RATE').AsString := formatfloat('#0.0',cdsBrowser.FieldbyName('NEW_INPRICE').AsFloat*100/cdsBrowser.FieldbyName('NEW_OUTPRICE').AsFloat)
    else
       cdsBrowser.FieldByName('PROFIT_RATE').Value := null;
    cdsBrowser.Post;
  end;
  InitGrid;
  SORT:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString;
  LoadTree;
  if SORT<>'' THEN FindNode(SORT).Selected:=True;
end;

procedure TfrmGoodsInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin

  if (trim(Lowercase(Column.FieldName))='selflag') and
     (trim(DBGridEh1.DataSource.DataSet.FieldByName('RELATION_ID').AsString)<>'0') then
    DBGridEh1.Canvas.Brush.Color:= clGray;


  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBrowser.RecNo)),length(Inttostr(cdsBrowser.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmGoodsInfoList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
//  if Column.FieldName = 'SEQ_NO' then
//     Background := clBtnFace;
end;

function TfrmGoodsInfoList.EncodeSQL(id: string;var Cnd:string): string;
var
  w,vCnd,GoodTab:string;
begin
  vCnd:='';
  GoodTab:=
    '(select J.TENANT_ID as TENANT_ID,J.RELATION_ID as RELATION_ID,J.GODS_ID as GODS_ID,J.SHOP_ID as SHOP_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE else C.NEW_INPRICE end as NEW_INPRICE,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE*J.SMALLTO_CALC else C.NEW_INPRICE1 end as NEW_INPRICE1,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE*J.BIGTO_CALC else C.NEW_INPRICE2 end as NEW_INPRICE2,'+
    ' RTL_OUTPRICE, '+  //标准售价
    ' NEW_LOWPRICE, '+  //最低售价
    ' NEW_OUTPRICE, '+
    ' NEW_OUTPRICE1, '+
    ' NEW_OUTPRICE2, '+
    ' NEW_LOWPRICE,'+
    ' SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,GODS_TYPE,J.COMM as COMM,'+
    ' USING_BARTER,BARTER_INTEGRAL,USING_PRICE,HAS_INTEGRAL,USING_BATCH_NO,REMARK '+#13+
    'from (select * from VIW_GOODSPRICE where COMM not in (''02'',''12'') and POLICY_TYPE=2 and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID '+
    ' union all '+
    ' select A.* from VIW_GOODSPRICE A,VIW_GOODSPRICE B '+
    ' where A.COMM not in (''02'',''12'') and B.POLICY_TYPE=1 and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.SHOP_ID=:SHOP_ID and A.SHOP_ID=:SHOP_ID_ROOT and A.TENANT_ID=:TENANT_ID ) J '+
    ' left join PUB_GOODSINFOEXT C on J.GODS_ID=C.GODS_ID and J.TENANT_ID=C.TENANT_ID )';

  w := 'and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') ';
  if id<>'' then w := w + ' and j.GODS_ID>=:MAXID';

  if (rzTree.Selected<>nil) and (rzTree.Selected.Level>0) then
  begin
    case Factor.iDbType of
     0:
      begin
        w :=w+' and b.LEVEL_ID like :LEVEL_ID +''%'' and b.RELATION_ID=:RELATION_ID ';
        vCnd:=' and b.LEVEL_ID like :LEVEL_ID +''%'' and b.RELATION_ID=:RELATION_ID ';
      end;
     4,5:
      begin
        w :=w+' and b.LEVEL_ID like :LEVEL_ID || ''%'' and b.RELATION_ID=:RELATION_ID ';
        vCnd:=' and b.LEVEL_ID like :LEVEL_ID || ''%'' and b.RELATION_ID=:RELATION_ID ';
      end;
    end;
  end;
  if trim(edtKey.Text)<>'' then
  begin
    case Factor.iDbType of
     0:
      begin
        w := w + ' and ((j.GODS_CODE like ''%''+:KEYVALUE +''%'') or (j.GODS_NAME like ''%''+:KEYVALUE +''%'') or (j.GODS_SPELL like ''%''+:KEYVALUE +''%'') or (BARCODE like ''%''+:KEYVALUE+''%''))';
        vCnd:=vCnd+' and ((j.GODS_CODE like ''%''+:KEYVALUE +''%'') or (j.GODS_NAME like ''%''+:KEYVALUE +''%'') or (j.GODS_SPELL like ''%''+:KEYVALUE +''%'') or (BARCODE like ''%''+:KEYVALUE+''%''))';
      end;
    4,5:
      begin
        w := w + ' and ((j.GODS_CODE like ''%'' || :KEYVALUE || ''%'') or (j.GODS_NAME like ''%'' || :KEYVALUE || ''%'') or (j.GODS_SPELL like ''%'' || :KEYVALUE || ''%'') or (BARCODE like ''%'' || :KEYVALUE || ''%''))';
        vCnd:=vCnd+' and ((j.GODS_CODE like ''%'' || :KEYVALUE || ''%'') or (j.GODS_NAME like ''%'' || :KEYVALUE || ''%'') or (j.GODS_SPELL like ''%'' || :KEYVALUE || ''%'') or (BARCODE like ''%'' || :KEYVALUE || ''%''))';
      end;
    end;
  end;
  Cnd:=vCnd;
  case Factor.iDbType of
  0:
  result := 'select top 600 0 as selflag,case when RELATION_ID=0 then 2 else 1 end as RELATION_FLAG,case when l.NEW_OUTPRICE<>0 then l.NEW_INPRICE*100/l.NEW_OUTPRICE else null end as PROFIT_RATE,l.*,r.AMOUNT as AMOUNT from '+
     ' (select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where b.SORT_TYPE=1 and j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
     'left outer join '+
     '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID group by GODS_ID) r '+
     'on l.GODS_ID=r.GODS_ID order by l.GODS_ID';
  4:
  result := 'select tp.* from ('+
     'select 0 as selflag,,case when RELATION_ID=0 then 2 else 1 end as RELATION_FLAG,case when l.NEW_OUTPRICE<>0 then l.NEW_INPRICE*100/l.NEW_OUTPRICE else null end as PROFIT_RATE,l.*,r.AMOUNT as AMOUNT from '+
     ' (select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where b.SORT_TYPE=1 and j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
     'left outer join '+
     '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID group by GODS_ID) r '+
     ' on l.GODS_ID=r.GODS_ID order by l.GODS_ID) tp fetch first 600  rows only';
  5:
  result := 'select 0 as selflag,case when RELATION_ID=0 then 2 else 1 end as RELATION_FLAG,case when l.NEW_OUTPRICE<>0 then Cast((l.NEW_INPRICE*100/l.NEW_OUTPRICE) as varchar(12)) || ''%'' else null end as PROFIT_RATE,l.*,r.AMOUNT as AMOUNT from '+
     ' (select j.* from '+GoodTab+' j,VIW_GOODSSORT b where b.SORT_TYPE=1 and j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
     'left join '+
     '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID  group by GODS_ID) r '+
     ' on l.GODS_ID=r.GODS_ID order by l.GODS_ID limit 100 ';   
  end;
end;

procedure TfrmGoodsInfoList.Open(Id: string);
var StrmData: TStream;
  Cnd: string; rs:TZQuery;  
  function GetReCount(Cnd: string): integer;
  var str: string; tmpQry:TZQuery;
  begin
    result:=0;
    tmpQry:=TZQuery.Create(nil);
    try
      str:='Select count(*) as RESUM from VIW_GOODSINFO j,VIW_GOODSSORT b where b.SORT_TYPE=1 and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') and '+
           ' j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+Cnd+' ';
      tmpQry.Close;
      tmpQry.SQL.Text:=str;
      if tmpQry.Params.FindParam('TENANT_ID')<>nil then
         tmpQry.Params.ParamByName('TENANT_ID').AsInteger:=SHopGlobal.TENANT_ID;
      if tmpQry.Params.FindParam('KEYVALUE')<>nil then
         tmpQry.Params.ParamByName('KEYVALUE').AsString := trim(edtKey.Text);
      if tmpQry.Params.FindParam('SORT_ID')<>nil then
         tmpQry.Params.ParamByName('SORT_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString;
      if tmpQry.Params.FindParam('LEVEL_ID')<>nil then
         tmpQry.Params.ParamByName('LEVEL_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
      if tmpQry.Params.FindParam('RELATION_ID')<>nil then
         tmpQry.Params.ParamByName('RELATION_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
      Factor.Open(tmpQry);
      Result := tmpQry.Fields[0].AsInteger;
    finally
      FreeAndNil(tmpQry);
    end;
  end;
begin
  if not Visible then Exit;
  if Id='' then cdsBrowser.close;
  rs := TZQuery.Create(nil);
  cdsBrowser.DisableControls;
  try
    StrmData:=TMemoryStream.Create;
    rs.SQL.Text:=EncodeSQL(Id,Cnd);
    if rs.Params.FindParam('TENANT_ID')<>nil then
       rs.Params.ParamByName('TENANT_ID').AsInteger:=SHopGlobal.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then
       rs.Params.ParamByName('SHOP_ID').AsString:=SHopGlobal.SHOP_ID;
    if rs.Params.FindParam('SHOP_ID_ROOT')<>nil then
       rs.Params.ParamByName('SHOP_ID_ROOT').AsString:=InttoStr(SHopGlobal.TENANT_ID)+'0001';
    if rs.Params.FindParam('MAXID')<>nil then
       rs.Params.ParamByName('MAXID').AsString := MaxId;
    if rs.Params.FindParam('KEYVALUE')<>nil then
       rs.Params.ParamByName('KEYVALUE').AsString := trim(edtKey.Text);
    if rs.Params.FindParam('SORT_ID')<>nil then
       rs.Params.ParamByName('SORT_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString;
    if rs.Params.FindParam('LEVEL_ID')<>nil then
       rs.Params.ParamByName('LEVEL_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
    if rs.Params.FindParam('RELATION_ID')<>nil then
       rs.Params.ParamByName('RELATION_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    if Id<>'' then
    begin
      Factor.Open(rs);
      rs.Last;
      rs.IndexFieldNames := 'GODS_CODE';
      MaxId := rs.FieldbyName('GODS_ID').AsString;
      rs.SaveToStream(StrmData);
    end;
    if Id='' then
    begin
      rcAmt:=GetReCount(Cnd);
      //cdsBrowser.LoadFromStream(StrmData);
      cdsBrowser.SQL.Text:=EncodeSQL(Id,Cnd);
      cdsBrowser.Params.AssignValues(rs.Params);
      Factor.Open(cdsBrowser);
      cdsBrowser.Last;
      cdsBrowser.IndexFieldNames := 'GODS_CODE';
      MaxId := cdsBrowser.FieldbyName('GODS_ID').AsString;
      if cdsBrowser.RecordCount <100 then IsEnd := True else IsEnd := false;
    end else
    begin
      cdsBrowser.AddFromStream(StrmData);
      if rs.RecordCount <100 then IsEnd := True else IsEnd := false;
    end;

  finally
    cdsBrowser.EnableControls;
    rs.Free;
  end;
end;

procedure TfrmGoodsInfoList.actFindExecute(Sender: TObject);
begin
  inherited;
  locked:=True;
  try
    if (trim(edtKEY.Text)<>'') and (rzTree.Items.Count>0) then rzTree.TopItem.Selected := true;
    Open('');
  finally
    locked:=False;
  end;
end;

procedure TfrmGoodsInfoList.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  begin
    actFindExecute(nil);
    Key:=#0;
  end;
end;

procedure TfrmGoodsInfoList.InitGrid;
var
  rs: TZQuery;
  Obj  :TRecord_ ;
  P,Root:TTreeNode; 
begin                     
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
  begin
    DBGridEh1.FieldColumns['CALC_UNITS'].KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
    DBGridEh1.FieldColumns['CALC_UNITS'].PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
   {DBGridEh1.FieldColumns['SMALL_UNITS'].KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
    DBGridEh1.FieldColumns['SMALL_UNITS'].PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
    DBGridEh1.FieldColumns['BIG_UNITS'].KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
    DBGridEh1.FieldColumns['BIG_UNITS'].PickList.Add(rs.FieldbyName('UNIT_NAME').AsString); }
    rs.Next;
  end;

  //供货商[生产厂家]
  rs := Global.GetZQueryFromName('PUB_CLIENTINFO');
  rs.First;
  while not rs.Eof do
  begin
    DBGridEh1.FieldColumns['SORT_ID3'].KeyList.Add(rs.FieldbyName('CLIENT_ID').AsString);
    DBGridEh1.FieldColumns['SORT_ID3'].PickList.Add(rs.FieldbyName('CLIENT_NAME').AsString);
    rs.Next;
  end;  

  //商品品牌
  rs:=Global.GetZQueryFromName('PUB_BRAND_INFO');
  if (rs.Active) and (not rs.IsEmpty) then
  begin
    rs.First;
    while not rs.Eof do
    begin
      DBGridEh1.FieldColumns['SORT_ID4'].KeyList.Add(rs.FieldbyName('SORT_ID').AsString);
      DBGridEh1.FieldColumns['SORT_ID4'].PickList.Add(rs.FieldbyName('SORT_NAME').AsString);
      rs.Next;
    end;
  end;
end;

procedure TfrmGoodsInfoList.FormCreate(Sender: TObject);
var
  tmp: TZQuery;
begin
  inherited;
  TENANT_ID:=IntToStr(Global.TENANT_ID);
  InitGrid;
  LoadTree;
  edtProperty1:=TZQuery.Create(nil);
  edtProperty2:=TZQuery.Create(nil);
  //暂关闭Gird表头排序
  //TDbGridEhSort.InitForm(self);
end;

procedure TfrmGoodsInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmGoodsInfoList.actNewExecute(Sender: TObject);
var
  Relation:Integer; 
  CurObj: TRecord_;
  sid,sname:string;
begin
  inherited;
  //if not ShopGlobal.GetChkRight('200036') then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  {
  if rzTree.Selected=nil then Raise Exception.Create(' 请选择Tree的节点！ ');
  CurObj:=TRecord_(rzTree.Selected.Data);
  if CurObj=nil then Raise Exception.Create(' 请选择Tree的节点！ ');
  if CurObj.FieldByName('RELATION_FLAG').AsInteger<>2 then // RELATION_FLAG=2 自主经营
    Raise Exception.Create(' 当前分类的节点是供应链的，只能在“自主经营”下新增商品！ ');

  sid := CurObj.FieldbyName('SORT_ID').AsString;
  sname := CurObj.FieldbyName('SORT_NAME').AsString;
  Relation:= CurObj.FieldbyName('RELATION_FLAG').AsInteger;
  }

  with TfrmGoodsInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Append(Relation,sid,sname,'');
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmGoodsInfoList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active   then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmGoodsInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        Open(cdsBrowser.FieldByName('GODS_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

function TfrmGoodsInfoList.CheckRoot: boolean;
var
   rs:TADODataSet;
begin
   rs := TADODataSet.Create(nil);   
   try
     rs.CommandText := 'select UPCOMP_ID from CA_COMPANY where COMP_ID='''+TENANT_ID+'''';
     Factor.Open(rs);
     result := (rs.Fields[0].AsString = '');
   finally
     rs.Free;
   end;
end;

procedure TfrmGoodsInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  //if not ShopGlobal.GetChkRight('200037') then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');

  if cdsBrowser.FieldByName('GODS_ID').AsString='' then exit;
  with TfrmGoodsInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //得加权限判断的，及是总店可改公司经营商品及门店可改自经营商品，
        Edit(cdsBrowser.FieldByName('GODS_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsInfoList.actDeleteExecute(Sender: TObject);
var
  i,n:integer;
  tmpGlobal: TZQuery;
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  cdsBrowser.Edit;
  cdsBrowser.Post;
  //if not ShopGlobal.GetChkRight('200038') then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');

  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  if i=6 then
  begin
    tmpGlobal := Global.GetZQueryFromName('PUB_GOODSINFO');
    tmpGlobal.Filtered :=false;
    cdsBrowser.DisableControls;
    try
      cdsBrowser.Filtered := false;
      cdsBrowser.Filter := '(selFlag=''1'') and (RELATION_ID=''0'')';
      cdsBrowser.Filtered := true;
      if cdsBrowser.IsEmpty then Raise Exception.Create('请选择要删除的商品...');

      try
        n := 0;
        tmpGlobal.CommitUpdates;
        cdsBrowser.First;
        while not cdsBrowser.Eof do //缓存删除记录
        begin
          if (trim(cdsBrowser.FieldByName('selflag').AsString)='1') and (trim(cdsBrowser.FieldByName('RELATION_ID').AsString)='0') then
          begin
            if tmpGlobal.Locate('GODS_ID',cdsBrowser.FieldByName('GODS_ID').AsString,[]) then
              tmpGlobal.Delete;
            inc(n);
            cdsBrowser.Delete;
          end
          else cdsBrowser.Next;
        end;
        //提交数据保存
        try
          Factor.UpdateBatch(cdsBrowser,'TGoodsInfo');
          rcAmt := rcAmt - n;
          tmpGlobal.CommitUpdates;          
        except
          cdsBrowser.CancelUpdates;
          tmpGlobal.CancelUpdates;
          Raise;
        end;
      finally
        cdsBrowser.EnableControls;
      end;
    finally
      cdsBrowser.Filtered := false;
      cdsBrowser.EnableControls;
    end;
  end;
  GetNo;
  //删除代码别做，要支持批量删除，同时也要删除条码库
end;

procedure TfrmGoodsInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actEditExecute(nil);
end;

procedure TfrmGoodsInfoList.N1Click(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  while not IsEnd do Open(MaxID);   
  cdsBrowser.DisableControls;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
    begin
      cdsBrowser.Edit;
      cdsBrowser.FieldByName('selflag').AsBoolean:=True;
      cdsBrowser.Post;
      cdsBrowser.Next;
    end;
  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmGoodsInfoList.N2Click(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  while not IsEnd do Open(MaxID); 
  cdsBrowser.DisableControls;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
    begin
      cdsBrowser.Edit;
      if cdsBrowser.FieldByName('selflag').AsBoolean=True then
         cdsBrowser.FieldByName('selflag').AsBoolean:=False
      else
         cdsBrowser.FieldByName('selflag').AsBoolean:=True;
      cdsBrowser.Post;
      cdsBrowser.Next;
    end;
  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmGoodsInfoList.N3Click(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  while not IsEnd do Open(MaxID);   
  cdsBrowser.DisableControls;
  try
    cdsBrowser.First;
    while not cdsBrowser.Eof do
    begin
      cdsBrowser.Edit;
      cdsBrowser.FieldByName('selflag').AsBoolean:=False;
      cdsBrowser.Post;
      cdsBrowser.Next;
    end;
  finally
    cdsBrowser.First;
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmGoodsInfoList.rzTreeChanging(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  if locked then exit;
  locked := true;
  try
   if edtKey.Text<>''
        then edtKey.Text:='';
  finally
    locked := false;
  end;
end;

procedure TfrmGoodsInfoList.ToolButton8Click(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('200040') then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
end;

procedure TfrmGoodsInfoList.FormShow(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('400019') then
  begin
    DBGridEh1.FieldColumns['NEW_INPRICE'].Visible:=False;
    DBGridEh1.FieldColumns['PROFIT_RATE'].Visible:=False;
  end;
  if edtKey.CanFocus then
    edtKey.SetFocus;
  if cdsBrowser.Active then cdsBrowser.First;
end;

function TfrmGoodsInfoList.FindNode(ID: string): TTreeNode;
var i:Integer;
begin
  Result := nil;
  for i:=0 to rzTree.Items.Count -1 do
  begin
      if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('SORT_ID').AsString))  then
      begin
        Result := rzTree.Items[i];
        exit;
      end;
  end;
end;
procedure TfrmGoodsInfoList.GetNo;
var str:string;
begin
  inherited;
  if cdsBrowser.IsEmpty then  str:='0'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(rcAmt)+'条';
end;

procedure TfrmGoodsInfoList.FormDestroy(Sender: TObject);
begin
  inherited;
  edtProperty1.Free;
  edtProperty2.Free;
  //暂关闭Gird表头排序
  //TDbGridEhSort.FreeForm(self);
end;

procedure TfrmGoodsInfoList.N4Click(Sender: TObject);
begin
  inherited;
  if not cdsBrowser.Active then exit;
  while not IsEnd do Open(MaxID);
end;

procedure TfrmGoodsInfoList.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if not edtKey.Focused then inherited;
end;

procedure TfrmGoodsInfoList.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then  actEditExecute(nil);
end;

procedure TfrmGoodsInfoList.actCopyNewExecute(Sender: TObject);
begin
  inherited;
  if cdsBrowser.IsEmpty then exit;
  if IsChain then Raise Exception.Create('直营店不能新增商品!');
  if not ShopGlobal.GetChkRight('200036') then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  with TfrmGoodsInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        Append(0,'','',cdsBrowser.FieldByName('GODS_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsInfoList.PrintBarcode;
procedure AddTo(DataSet:TDataSet;ID,P1,P2:string;amt:Integer);
function PubGetBarCode:string;
var rs: TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select BARCODE from PUB_BARCODE where GODS_ID='''+ID+''' and PROPERTY_01='''+P1+''' and PROPERTY_02='''+P2+''' and BATCH_NO=''#''';
    Factor.Open(rs);
    result := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;
var
  rs: TZQuery;
begin
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if rs.Locate('GODS_ID',ID,[]) then
  begin
    DataSet.Append;
    DataSet.FieldByName('A').AsBoolean := true;
    DataSet.FieldByName('GODS_ID').AsString := rs.FieldByName('GODS_ID').AsString;;
    //DataSet.FieldByName('BCODE').AsString := rs.FieldByName('BCODE').AsString;
    DataSet.FieldByName('GODS_NAME').AsString := rs.FieldByName('GODS_NAME').AsString;
    DataSet.FieldByName('GODS_CODE').AsString := rs.FieldByName('GODS_CODE').AsString;;
    DataSet.FieldByName('NEW_OUTPRICE').AsString := rs.FieldByName('NEW_OUTPRICE').AsString;
    DataSet.FieldByName('NEW_CUSTPRICE').AsString := rs.FieldByName('NEW_CUSTPRICE').AsString;
    DataSet.FieldByName('PROPERTY_01').AsString := P1;
    DataSet.FieldByName('PROPERTY_02').AsString := P2;
    //
    DataSet.FieldByName('BARCODE').AsString := PubGetBarCode;
    if (DataSet.FieldByName('BARCODE').AsString='') or fnString.IsCustBarCode(DataSet.FieldByName('BARCODE').AsString) then
       DataSet.FieldByName('BARCODE').AsString := GetBarCode(rs.FieldByName('GODS_CODE').AsString,P1,P2);
    DataSet.FieldByName('AMOUNT').AsInteger := amt;
    DataSet.Post;
  end;
end;
var amt,i,RecNo:integer;
begin
  inherited;
  cdsBrowser.DisableControls;
  try
    // cdsBrowser.MergeChangeLog;
    cdsBrowser.Filtered := false;
    cdsBrowser.Filter := 'selFlag=1';
    cdsBrowser.Filtered := true;
    if cdsBrowser.IsEmpty then Raise Exception.Create('请选择要打印条码的商品...');
    { with TfrmBarCodePrint.Create(self) do
      begin
        try
          adoPrint.Close;
          adoPrint.CreateDataSet;
          cdsBrowser.First;
          while not cdsBrowser.Eof do
            begin
              if PropertyEnabled then
                 begin
                   GetProperty;
                   edtProperty1.First;
                   while not edtProperty1.Eof do
                      begin
                        while not edtProperty2.Eof do
                        begin
                          AddTo(adoPrint,cdsBrowser.FieldbyName('GODS_ID').AsString,edtProperty1.FieldbyName('CODE_ID').AsString,edtProperty2.FieldbyName('CODE_ID').AsString,1);
                          edtProperty2.Next;
                        end;
                        edtProperty1.Next;
                      end;
                 end
              else
                 begin
                   AddTo(adoPrint,cdsBrowser.FieldbyName('GODS_ID').AsString,'#','#',1);
                 end;
              cdsBrowser.Next;
            end;
          ShowModal;
        finally
          free;
        end;
      end;
    }
  finally
    cdsBrowser.Filtered:=False;
    cdsBrowser.EnableControls;
  end;
end;

function TfrmGoodsInfoList.PropertyEnabled: boolean;
var
  rs:TZQuery;
begin
  result := false;
  rs := Global.GetZQueryFromName('BAS_GOODSINFO');
  if rs.Locate('GODS_ID',cdsBrowser.FieldbyName('GODS_ID').AsString,[]) then
  result := not (
       ((rs.FieldbyName('PROPERTY_01').AsString = '') or (rs.FieldbyName('PROPERTY_01').AsString = '#'))
         and
       ((rs.FieldbyName('PROPERTY_02').AsString = '') or (rs.FieldbyName('PROPERTY_02').AsString = '#'))
       );
end;

procedure TfrmGoodsInfoList.GetProperty;
var
  rs: TZQuery;
begin
  rs := Global.GetZQueryFromName('BAS_GOODSINFO');
  if rs.Locate('GODS_ID',cdsBrowser.FieldbyName('GODS_ID').AsString,[]) then
  begin
    if not ((rs.FieldbyName('PROPERTY_01').AsString='#') or (rs.FieldbyName('PROPERTY_01').AsString='')) then
    begin
      edtProperty1.Close;
      if rs.FieldbyName('PROPERTY_01').AsString='G' then //自定义尺码
         edtProperty1.SQL.Text := 'select B.CODE_ID from PUB_PROPERTY A,PUB_CODE_INFO B where A.CODE_ID=B.CODE_ID and A.GODS_ID='''+cdsBrowser.FieldbyName('GODS_ID').AsString+''' and A.CODE_TYPE=2 and B.CODE_TYPE=2 and B.COMM not in (''02'',''12'') order by A.SEQ_NO'
      else
         edtProperty1.SQL.Text := 'select substring(CODE_ID,4,3) as CODE_ID from PUB_CODE_INFO where CODE_ID like '''+rs.FieldbyName('PROPERTY_01').AsString+'%'' and len(CODE_ID)>3 and CODE_TYPE=2 and COMM not in (''02'',''12'') order by SEQ_NO';
      Factor.Open(edtProperty1);
    end else
    begin
      edtProperty1.Close;
      edtProperty1.SQL.Text:='select ''#'' CODE_ID';
      Factor.Open(edtProperty1);
    end;

    if not ((rs.FieldbyName('PROPERTY_02').AsString='#') or (rs.FieldbyName('PROPERTY_02').AsString='')) then
    begin
      edtProperty2.Close;
      if rs.FieldbyName('PROPERTY_02').AsString='G' then //自定义尺码
        edtProperty2.SQL.Text := 'select B.CODE_ID from PUB_PROPERTY A,PUB_CODE_INFO B where A.CODE_ID=B.CODE_ID and A.GODS_ID='''+cdsBrowser.FieldbyName('GODS_ID').AsString+''' and A.CODE_TYPE=4 and B.CODE_TYPE=4 and B.COMM not in (''02'',''12'') order by A.SEQ_NO'
      else
        edtProperty2.SQL.Text := 'select substring(CODE_ID,4,3) as CODE_ID from PUB_CODE_INFO where CODE_ID like '''+rs.FieldbyName('PROPERTY_02').AsString+'%'' and len(CODE_ID)>3 and CODE_TYPE=4  and COMM not in (''02'',''12'') order by SEQ_NO';
      Factor.Open(edtProperty2);
    end else
    begin
      edtProperty2.Close;
      edtProperty2.SQL.Text :='select ''#'' CODE_ID';
      Factor.Open(edtProperty2);
    end;
  end;
end;

procedure TfrmGoodsInfoList.actPrintBarCodeExecute(Sender: TObject);
begin
  inherited;
  PrintBarcode;
end;

procedure TfrmGoodsInfoList.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if Column.FieldName='selflag' then
    N1Click(nil)
  else
  begin
    cdsBrowser.IndexFieldNames := '';
    cdsBrowser.IndexFieldNames := 'GODS_CODE';
  end;
end;

procedure TfrmGoodsInfoList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('200040') then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');  
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  with TfrmEhLibReport.Create(self) do
    begin
      try
        Preview(PrintDBGridEh1);
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsInfoList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('200040') then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');  
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmGoodsInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
begin
  GetNO;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsBrowser.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmGoodsInfoList.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then Exit;
  if trim(LowerCase(Column.FieldName))='selflag' then
  begin
    if trim(cdsBrowser.FieldByName('RELATION_ID').AsString)<>'0' then //非自主经营的不能选择删除
    begin
      cdsBrowser.Edit;
      cdsBrowser.FieldByName('selflag').AsBoolean:=False;
      cdsBrowser.Post;
    end;
  end;
end;

procedure TfrmGoodsInfoList.LoadTree;
var
  vType: TFieldType;
  str: string;
  rs:TZQuery;
  w,i:integer;
  Root,P:TTreeNode;
  AObj,Obj:TRecord_;
begin
  rzTree.OnChange:=nil;
  ClearTree(rzTree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  str:='';
  rs.SortedFields := 'RELATION_ID';
  w := -1;
  rs.First;
  while not rs.Eof do
  begin
    if InttoStr(w)<>rs.FieldByName('RELATION_ID').AsString then
    begin
      AObj := TRecord_.Create;
      AObj.ReadFromDataSet(rs);
      rzTree.Items.AddObject(nil,rs.FieldbyName('RELATION_NAME').AsString,AObj);
      w := rs.FieldByName('RELATION_ID').AsInteger;
    end;
    rs.Next;
  end;
  
  for i:=rzTree.Items.Count-1 downto 0 do
  begin
    rs.Filtered := false;
    rs.filter := 'RELATION_ID='+TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
    rs.Filtered := true;
    rs.SortedFields := 'LEVEL_ID';      //'33333333'
    CreateLevelTree(rs,rzTree,'44444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzTree.Items[i]);
  end;
  rzTree.OnChange:=self.DoTreeChange;

  {Obj:= TRecord_.Create;
  try
    Obj.ReadField(rs);
    Root := rzTree.Items.AddObject(nil,'所有分类',Obj);
    P := Root.getPrevSibling;
    while P<>nil do
    begin
      P.MoveTo(Root,naAddChildFirst);
      P := Root.getPrevSibling;
    end;
    Root.Selected := True;
  finally
  end;}
end;

procedure TfrmGoodsInfoList.DoTreeChange(Sender: TObject; Node: TTreeNode);
begin
  Open('');
end;

end.
