{ 32600001	0	商品档案	1	查询  2	新增	3	修改	4	删除	5	打印	6	导出    }
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
    AddSortTree: TPopupMenu;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
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
    procedure N8Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
  private
     edtProperty2,edtProperty1: TZQuery;
     procedure GetNo;
     procedure DoTreeChange(Sender: TObject; Node: TTreeNode);  //
     function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
     function  CheckCanExport: boolean; override;
  public
    { Public declarations }
    IsEnd,IsChain,IsCompany: boolean;
    MaxId:string;
    locked:boolean;
    rcAmt:integer;
    procedure LoadTree;  //刷新SortTree树
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
  uShopUtil,uFnUtil,ufrmEhLibReport, ufrmSelectGoodSort,
  ufrmGoodssortTree, ObjCommon;
   

{$R *.dfm}
 
procedure TfrmGoodsInfoList.AddRecord(AObj: TRecord_);
var
  GODS_ID,SORT:string;
  EditObj: TRecord_;
begin
  SORT:='';
  if not cdsBrowser.Active then Exit;
  if cdsBrowser.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then
  begin
    try
      AObj.WriteToDataSet(cdsBrowser,false);
      EditObj:=TRecord_.Create;
      EditObj.ReadFromDataSet(cdsBrowser);
      GODS_ID:=EditObj.FieldByName('GODS_ID').AsString;
      if EditObj.FieldbyName('NEW_OUTPRICE').AsFloat <> 0 then
        EditObj.FieldByName('PROFIT_RATE').AsString := formatfloat('#0.0',EditObj.FieldbyName('NEW_INPRICE').AsFloat*100/EditObj.FieldbyName('NEW_OUTPRICE').AsFloat)
      else
        EditObj.FieldByName('PROFIT_RATE').AsValue := null;
      EditObj.FieldByName('selflag').AsString:='0';
      cdsBrowser.Edit;
      EditObj.WriteToDataSet(cdsBrowser);
      if cdsBrowser.State=dsEdit then
        cdsBrowser.Post;
    finally
      EditObj.Free;
    end;
  end else
  begin
    GODS_ID:=AObj.FieldByName('GODS_ID').AsString;
    cdsBrowser.Append;
    AObj.WriteToDataSet(cdsBrowser,false);
    if not (cdsBrowser.State in [dsInsert,dsEdit]) then cdsBrowser.Edit;
    cdsBrowser.Post;
    try
      EditObj:=TRecord_.Create;
      EditObj.ReadFromDataSet(cdsBrowser);
      EditObj.FieldByName('RELATION_FLAG').AsString:='2'; //新增的商品: 自主经营
      EditObj.FieldByName('RELATION_ID').AsString:='0';   //新增的商品: 自主经营
      EditObj.FieldByName('selflag').AsString:='0';       //标记位
      if EditObj.FieldbyName('NEW_OUTPRICE').AsFloat <> 0 then
        EditObj.FieldByName('PROFIT_RATE').AsString := formatfloat('#0.0',EditObj.FieldbyName('NEW_INPRICE').AsFloat*100/EditObj.FieldbyName('NEW_OUTPRICE').AsFloat)
      else
        EditObj.FieldByName('PROFIT_RATE').AsValue := null;
      EditObj.WriteToDataSet(cdsBrowser);
      if not (cdsBrowser.State in [dsInsert,dsEdit]) then cdsBrowser.Edit;
      cdsBrowser.Post;
    finally
      EditObj.Free;
    end;
  end;

  InitGrid;
  if rzTree.Selected<>nil then
    SORT:=TRecord_(rzTree.Selected.Data).FieldByName('SORT_ID').AsString;
  //进入商品资料修改没有维护到分类，不需刷新Tree
  // LoadTree;
  if SORT<>'' THEN FindNode(SORT).Selected:=True;
end;

procedure TfrmGoodsInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if not DBGridEh1.DataSource.DataSet.active then Exit;  
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
  w,vCnd,GoodTab,OperChar,vLike,LikeCnd:string;
begin
  vCnd:='';
  OperChar:=GetStrJoin(Factor.iDbType); //字符连接操作符
  GoodTab:=
    '(select J.TENANT_ID as TENANT_ID,RELATION_ID,J.GODS_ID as GODS_ID,J.SHOP_ID as SHOP_ID,GODS_CODE,BARCODE,GODS_SPELL,GODS_NAME,CALC_UNITS,SMALL_UNITS,BIG_UNITS,SMALLTO_CALC,BIGTO_CALC,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE else C.NEW_INPRICE end as NEW_INPRICE,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE*J.SMALLTO_CALC else C.NEW_INPRICE1 end as NEW_INPRICE1,'+
    ' case when C.NEW_INPRICE is null then J.NEW_INPRICE*J.BIGTO_CALC else C.NEW_INPRICE2 end as NEW_INPRICE2,'+
    ' RTL_OUTPRICE, '+  //标准售价
    ' NEW_LOWPRICE, '+  //最低售价                                                        
    ' NEW_OUTPRICE, '+
    ' NEW_OUTPRICE1,'+
    ' NEW_OUTPRICE2,'+
    ' SORT_ID1,SORT_ID2,SORT_ID3,SORT_ID4,SORT_ID5,SORT_ID6,SORT_ID7,SORT_ID8,GODS_TYPE,J.COMM as COMM,'+
    ' USING_BARTER,BARTER_INTEGRAL,USING_PRICE,USING_BATCH_NO,HAS_INTEGRAL,REMARK '+#13+ // 
    'from (select * from VIW_GOODSPRICE where COMM not in (''02'',''12'') and POLICY_TYPE=2 and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID '+
    ' union all '+
    ' select A.* from VIW_GOODSPRICE A,VIW_GOODSPRICE B '+
    ' where A.COMM not in (''02'',''12'') and B.POLICY_TYPE=1 and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.SHOP_ID=:SHOP_ID and A.SHOP_ID=:SHOP_ID_ROOT and A.TENANT_ID=:TENANT_ID ) J '+
    ' left join PUB_GOODSINFOEXT C on J.GODS_ID=C.GODS_ID and J.TENANT_ID=C.TENANT_ID)';

  w := ' and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') ';
  if id<>'' then w := w + ' and j.GODS_ID>=:MAXID';

  if rzTree.Selected<>nil then
  begin
    w :=w+' and b.RELATION_ID=:RELATION_ID ';
    vCnd:=' and b.RELATION_ID=:RELATION_ID ';
    if rzTree.Selected.Level>0 then
    begin
      w :=w+' and b.LEVEL_ID like :LEVEL_ID '+OperChar+' ''%'' ';
      vCnd:=' and b.LEVEL_ID like :LEVEL_ID '+OperChar+' ''%'' ';
    end;
  end;

  if trim(edtKey.Text)<>'' then
  begin
    LikeCnd:=GetLikeCnd(Factor.iDbType,'bar.BARCODE',':KEYVALUE','');
    LikeCnd:=' and ('+GetLikeCnd(Factor.iDbType,['j.GODS_CODE','j.GODS_NAME','j.GODS_SPELL','j.BARCODE'],':KEYVALUE','')+' or (exists(select BARCODE from PUB_BARCODE bar where j.GODS_ID=bar.GODS_ID and '+LikeCnd+'))'+
                  ')';
    w := w+LikeCnd;
    vCnd:=vCnd+LikeCnd;
  end;

  Cnd:=vCnd; //返回查询记录数的条件;
  case Factor.iDbType of
  0:
  result := 'select top 600 0 as selflag,RELATION_Flag,case when l.NEW_OUTPRICE<>0 then cast(cast(Round((l.NEW_INPRICE*100.0)/(l.NEW_OUTPRICE*1.0),0) as int) as varchar)+''%'' else null end as PROFIT_RATE,l.*,r.AMOUNT as AMOUNT from '+
     ' (select j.*,RELATION_Flag from '+GoodTab+' j,VIW_GOODSSORT b where b.SORT_TYPE=1 and j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
     'left outer join '+
     '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID group by GODS_ID) r '+
     'on l.GODS_ID=r.GODS_ID order by l.GODS_ID';
  4:
  result := 'select tp.* from ('+
     'select 0 as selflag,RELATION_Flag,case when l.NEW_OUTPRICE<>0 then (l.NEW_INPRICE*100.0)/(l.NEW_OUTPRICE*1.00) else null end as PROFIT_RATE,l.*,r.AMOUNT as AMOUNT from '+
     ' (select j.*,RELATION_Flag from '+GoodTab+' j,VIW_GOODSSORT b where b.SORT_TYPE=1 and j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
     'left outer join '+
     '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID group by GODS_ID) r '+
     ' on l.GODS_ID=r.GODS_ID order by l.GODS_ID) tp fetch first 600 rows only ';
  5:
  result := 'select 0 as selflag,RELATION_Flag,case when l.NEW_OUTPRICE<>0 then Cast(Round((l.NEW_INPRICE*100)/(l.NEW_OUTPRICE*1.00),0) as integer) ||''%'' else null end as PROFIT_RATE,l.*,r.AMOUNT as AMOUNT from '+
     ' (select j.*,RELATION_Flag from '+GoodTab+' j,VIW_GOODSSORT b where b.SORT_TYPE=1 and j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
     'left join '+
     '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID  group by GODS_ID) r '+
     ' on l.GODS_ID=r.GODS_ID order by l.GODS_ID limit 600 ';   
  end;
end;

procedure TfrmGoodsInfoList.Open(Id: string);
var StrmData: TStream;
  Cnd: string; rs:TZQuery;  
  function GetReCount(Cnd: string): integer;
  var str,GoodTab: string; tmpQry:TZQuery;
  begin
    result:=0;
    tmpQry:=TZQuery.Create(nil);
    try
      GoodTab:=
        '(select * from VIW_GOODSPRICE where COMM not in (''02'',''12'') and POLICY_TYPE=2 and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID '+
        ' union all '+
        ' select A.* from VIW_GOODSPRICE A,VIW_GOODSPRICE B '+
        ' where A.COMM not in (''02'',''12'') and B.POLICY_TYPE=1 and A.TENANT_ID=B.TENANT_ID and A.GODS_ID=B.GODS_ID and B.SHOP_ID=:SHOP_ID and A.SHOP_ID=:SHOP_ID_ROOT and A.TENANT_ID=:TENANT_ID)';

      str:='Select count(*) as RESUM from '+GoodTab+' j,VIW_GOODSSORT b '+
           ' where b.SORT_TYPE=1 and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') and j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+Cnd+' ';
      tmpQry.Close;
      tmpQry.SQL.Text:=str;
      if tmpQry.Params.FindParam('TENANT_ID')<>nil then
         tmpQry.Params.ParamByName('TENANT_ID').AsInteger:=SHopGlobal.TENANT_ID;
      if tmpQry.Params.FindParam('SHOP_ID_ROOT')<>nil then
         tmpQry.Params.ParamByName('SHOP_ID_ROOT').AsString:=InttoStr(SHopGlobal.TENANT_ID)+'0001';
      if tmpQry.Params.FindParam('SHOP_ID')<>nil then
         tmpQry.Params.ParamByName('SHOP_ID').AsString:=SHopGlobal.SHOP_ID;
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
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=SHopGlobal.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=SHopGlobal.SHOP_ID;
    if rs.Params.FindParam('SHOP_ID_ROOT')<>nil then rs.ParamByName('SHOP_ID_ROOT').AsString:=InttoStr(SHopGlobal.TENANT_ID)+'0001';
    if rs.Params.FindParam('MAXID')<>nil then rs.ParamByName('MAXID').AsString := MaxId;
    if rs.Params.FindParam('KEYVALUE')<>nil then rs.ParamByName('KEYVALUE').AsString := trim(edtKey.Text);
    if rs.Params.FindParam('SORT_ID')<>nil then rs.ParamByName('SORT_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString;
    if rs.Params.FindParam('LEVEL_ID')<>nil then rs.ParamByName('LEVEL_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
    if rs.Params.FindParam('RELATION_ID')<>nil then rs.ParamByName('RELATION_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('GODS_ID').AsString;
    rs.IndexFieldNames := 'GODS_CODE';
    rs.SortedFields:='GODS_CODE';
    rs.SaveToStream(StrmData);
    if Id='' then
    begin
      rcAmt:=GetReCount(Cnd);
      //  cdsBrowser.Close;
      //  cdsBrowser.SQL.Text:=rs.SQL.Text;
      //  cdsBrowser.Params.AssignValues(rs.Params);
      //  Factor.Open(cdsBrowser);
      cdsBrowser.LoadFromStream(StrmData);
      cdsBrowser.IndexFieldNames := 'GODS_CODE';
      cdsBrowser.SortedFields:='GODS_CODE';
    end else
      cdsBrowser.AddFromStream(StrmData);
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsBrowser.EnableControls;
    StrmData.Free;
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
  SetCol: TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  SetCol:=FindColumn(DBGridEh1,'CALC_UNITS');
  if (SetCol<>nil) and (rs.Active) and (rs.RecordCount>0) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      SetCol.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
     {DBGridEh1.FieldColumns['SMALL_UNITS'].KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      DBGridEh1.FieldColumns['SMALL_UNITS'].PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      DBGridEh1.FieldColumns['BIG_UNITS'].KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      DBGridEh1.FieldColumns['BIG_UNITS'].PickList.Add(rs.FieldbyName('UNIT_NAME').AsString); }
      rs.Next;
    end;
  end;
  
  //供货商[生产厂家]
  rs := Global.GetZQueryFromName('PUB_CLIENTINFO');
  SetCol:=FindColumn(DBGridEh1,'SORT_ID3');
  if (SetCol<>nil) and (rs.Active) and (rs.RecordCount>0) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add(rs.FieldbyName('CLIENT_ID').AsString);
      SetCol.PickList.Add(rs.FieldbyName('CLIENT_NAME').AsString);
      rs.Next;
    end;
  end;
  
  //商品品牌
  rs:=Global.GetZQueryFromName('PUB_BRAND_INFO');
  SetCol:=FindColumn(DBGridEh1,'SORT_ID4');
  if (SetCol<>nil) and (rs.Active) and (not rs.IsEmpty) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.Add(rs.FieldbyName('SORT_ID').AsString);
      SetCol.PickList.Add(rs.FieldbyName('SORT_NAME').AsString);
      rs.Next;
    end;
  end;

  //判断是否有查看成本价权限
  if not ShopGlobal.GetChkRight('14500001',2) then
  begin
    SetCol:=FindColumn(DBGridEh1, 'NEW_INPRICE');
    if SetCol<>nil then SetCol.Free;
    SetCol:=FindColumn(DBGridEh1, 'PROFIT_RATE');
    if SetCol<>nil then SetCol.Free;
  end;
end;

procedure TfrmGoodsInfoList.FormCreate(Sender: TObject);
var
  tmp: TZQuery;
begin
  inherited;
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
  CurObj: TRecord_;
  sid,sname:string;
begin
  inherited;
  if not ShopGlobal.GetChkRight('32600001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  if rzTree.Selected=nil then Raise Exception.Create(' 商品分类没有节点，请先选择分类节点！');
  CurObj:=TRecord_(rzTree.Selected.Data);
  if CurObj=nil then Raise Exception.Create(' 请选择Tree的节点！ ');
  if trim(CurObj.FieldByName('RELATION_ID').AsString)='0' then  // RELATION_FLAG=2 自主经营
  begin
    //Raise Exception.Create(' 当前分类的节点是供应链的，只能在“自主经营”下新增商品！ ');
    sid := CurObj.FieldbyName('SORT_ID').AsString;
    sname := CurObj.FieldbyName('SORT_NAME').AsString;
  end;
  
  with TfrmGoodsInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Append(sid,sname,'');
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
        //OnSave := AddRecord;
        Open(cdsBrowser.FieldByName('GODS_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmGoodsInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then Raise Exception.Create('   没有数据，请先查询！  ');
  if cdsBrowser.FieldByName('GODS_ID').AsString='' then Raise Exception.Create('   没有数据，请先查询！  ');
  if not ShopGlobal.GetChkRight('32600001',3) then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');

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
  if cdsBrowser.State=dsEdit then cdsBrowser.Post;

  if not ShopGlobal.GetChkRight('32600001',4) then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');

  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1+MB_ICONQUESTION);
  if i=6 then
  begin
    tmpGlobal := Global.GetZQueryFromName('PUB_GOODSINFO');
    tmpGlobal.Filtered :=false;
    cdsBrowser.CommitUpdates;
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
          end else cdsBrowser.Next;
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
  actInfoExecute(nil);
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
      cdsBrowser.FieldByName('selflag').AsString:='1';
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
      if trim(cdsBrowser.FieldByName('selflag').AsString)='1' then
         cdsBrowser.FieldByName('selflag').AsString:='0'
      else
         cdsBrowser.FieldByName('selflag').AsString:='1';
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
      cdsBrowser.FieldByName('selflag').AsString:='0';
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
  if not ShopGlobal.GetChkRight('32600001',5) then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
end;

procedure TfrmGoodsInfoList.FormShow(Sender: TObject);
begin
  inherited;
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
  // if IsChain then Raise Exception.Create('直营店不能新增商品!');
  if not ShopGlobal.GetChkRight('32600001',2) then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  with TfrmGoodsInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        Append('','',cdsBrowser.FieldByName('GODS_ID').AsString);
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
  rs := Global.GetZQueryFromName('PUB_BARCODE');
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
    //2011.02.26 Add TZQuery不支持的修改: IndexFieldNames
    //cdsBrowser.IndexFieldNames := '';
    //cdsBrowser.IndexFieldNames := 'GODS_CODE';
  end;
end;

procedure TfrmGoodsInfoList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('32600001',5) then
    Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
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

function TfrmGoodsInfoList.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var i:integer;
begin
  result := nil;
  for i:=0 to DBGrid.Columns.Count - 1 do
  begin
    if DBGrid.Columns[i].FieldName = FieldName then
    begin
      result := DBGrid.Columns[i];
      Exit;
    end;
  end; 
end;

procedure TfrmGoodsInfoList.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('32600001',5) then
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
      cdsBrowser.FieldByName('selflag').AsString:='0';
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
      // 2011.03.12 Add 可选择[供应链节点]的作为查询条件
      AObj.FieldByName('LEVEL_ID').AsString:='';
      AObj.FieldByName('SORT_NAME').AsString:=rs.FieldbyName('RELATION_NAME').AsString;
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
  rzTree.FullExpand; //展开树
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

procedure TfrmGoodsInfoList.N8Click(Sender: TObject);
var CurObj: TRecord_;
begin
  inherited;
  try
    CurObj:=TRecord_.Create;
    if TfrmGoodsSortTree.AddDialog(self,CurObj,1) then
    begin
      LoadTree;
    end;
  finally
    CurObj.Free;
  end;
end;

function TfrmGoodsInfoList.CheckCanExport: boolean;
begin 
  result:=ShopGlobal.GetChkRight('32600001',6);
end;

procedure TfrmGoodsInfoList.N10Click(Sender: TObject);
begin
  inherited;
  LoadTree;
end;

end.
