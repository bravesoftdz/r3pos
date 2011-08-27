{------------2011.02.24  盘点表：查看或导入未录入盘点数量  --------------}

unit ufrmSelectCheckGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, ComCtrls, RzTreeVw, Grids, DBGridEh, cxControls, cxContainer,
  cxEdit, cxTextEdit, StdCtrls, cxRadioGroup, DB, zBase, cxMaskEdit,
  cxDropDownEdit, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmSelectCheckGoods = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzPanel3: TRzPanel;
    RzTree: TRzTreeView;
    RzPanel4: TRzPanel;
    DBGridEh1: TDBGridEh;
    fndPanel: TPanel;
    RzPanel5: TRzPanel;
    Label8: TLabel;
    edtSearch: TcxTextEdit;
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    btnFilter: TRzBitBtn;
    dsList: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Label2: TLabel;
    fndGODS_FLAG1: TcxComboBox;
    cdsList: TZQuery;
    chkMultSelect: TCheckBox;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure btnFilterClick(Sender: TObject);
    procedure RzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzTreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Rb1Click(Sender: TObject);
    procedure Rb2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure chkMultSelectClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure fndGODS_FLAGPropertiesChange(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    IsEnd: boolean;
    MaxId:string;
    FMultiSelect: boolean;
    FPRINT_DATE: string;
    FSHOP_ID: string;
    procedure LoadTree;
    procedure LoadList;
    procedure LoadProv;
    function  EncodeSQL(id:string):string;
    procedure Open(Id:string);
    procedure SetMultiSelect(const Value: boolean);
    procedure SetPRINT_DATE(const Value: string);
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    procedure SetSHOP_ID(const Value: string);
  public
    { Public declarations }
    procedure InitGrid(PRINT_ID,InSHOP_ID: string);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    property MultiSelect:boolean read FMultiSelect write SetMultiSelect;
    property PRINT_DATE: string read FPRINT_DATE write SetPRINT_DATE;    //传入盘点单号
    property SHOP_ID: string read FSHOP_ID write SetSHOP_ID; //传入门店ID
  end;

implementation
uses uCtrlUtil, uGlobal, uTreeUtil, uShopGlobal, uDsUtil;
{$R *.dfm}

{ TframeSelectGoods }

constructor TfrmSelectCheckGoods.Create(AOwner: TComponent);
begin
  inherited;
  MultiSelect := false;
  TDbGridEhSort.InitForm(self);
end;

destructor TfrmSelectCheckGoods.Destroy;
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TfrmSelectCheckGoods.InitGrid(PRINT_ID,InSHOP_ID: string);
var
  rs: TZQuery;
  SetCol: TColumnEh;
begin
  inherited;
  PRINT_DATE:=PRINT_ID;
  SHOP_ID:=InSHOP_ID;
  SetCol:=FindColumn(self.DBGridEh1,'UNIT_ID');
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  if (SetCol<>nil) and (rs.Active) then
  begin
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.add(rs.Fieldbyname('UNIT_ID').asstring);
      SetCol.PickList.add(rs.Fieldbyname('UNIT_NAME').asstring);
      rs.Next;
    end;
  end;
  
  rs := Global.GetZQueryFromName('PUB_STAT_INFO');
  TdsItems.AddDataSetToItems(rs,fndGODS_FLAG1.Properties.Items,'CODE_NAME');
  fndGODS_FLAG1.ItemIndex := 0;
  LoadTree;
  rzTree.FullExpand; //展开树
end;

function TfrmSelectCheckGoods.EncodeSQL(id: string): string;
var
  CodeID: integer;
  w:string;
  sc:string;
begin
  case Factor.iDbType of
  0:sc := '+';
  1,4,5: sc := '||';
  end;
  w := 'and j.TENANT_ID=:TENANT_ID and j.SHOP_ID=:SHOP_ID and j.COMM not in (''02'',''12'') ';
  if id<>'' then
     begin
      if w<>'' then w := w + ' and ';
      w := w + 'j.GODS_ID>:MAXID';
     end;

  CodeID:=TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger;

  if (CodeID<>1) and (rzTree.Selected<>nil) and (rzTree.Selected.Level>0) then
  begin
    if w<>'' then w := w + ' and ';
     w := w + 'j.SORT_ID'+TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsString+' = :SORT_ID ';
  end;

  if (CodeID=1) and (rzTree.Selected<>nil) then
  begin
    if w<>'' then w := w + ' and ';
    w := w + ' b.RELATION_ID=:RELATION_ID ';
    if rzTree.Selected.Level>0 then
    begin
      if w<>'' then w := w + ' and ';
      w := w + ' b.LEVEL_ID like :LEVEL_ID '+sc+'''%'' ';
    end;
  end;

  if trim(edtSearch.Text)<>'' then
     begin
      if w<>'' then w := w + ' and ';
      w := w + '(j.GODS_CODE like ''%'''+sc+':KEYVALUE '+sc+'''%'' or j.GODS_NAME like ''%'''+sc+':KEYVALUE '+sc+'''%'' or j.GODS_SPELL like ''%'''+sc+':KEYVALUE '+sc+'''%'' or BARCODE like ''%'''+sc+':KEYVALUE )';
     end;
  case Factor.iDbType of
  0,3:
   result :=
     'select top 600 0 as A,l.*,r.BATCH_NO as BATCH_NO,r.AMOUNT as AMOUNT from '+
     ' (select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,J.NEW_INPRICE from VIW_GOODSPRICE j,VIW_GOODSSORT b '+
     '  where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l, '+
     '(select GODS_ID,BATCH_NO,RCK_AMOUNT as AMOUNT from STO_PRINTDATA s,STO_PRINTORDER m '+
     ' where s.TENANT_ID=m.TENANT_ID and s.SHOP_ID=m.SHOP_ID and s.PRINT_DATE=m.PRINT_DATE and m.COMM not in (''02'',''12'') and '+
     ' s.TENANT_ID=:TENANT_ID and s.SHOP_ID=:SHOP_ID and s.PRINT_DATE=:PRINT_DATE) r '+
     ' where l.GODS_ID=r.GODS_ID '+
     ' order by l.GODS_ID';
  1:
   result :=
     'select * from '+
     '(select 0 as A,l.*,r.BATCH_NO as BATCH_NO,r.AMOUNT as AMOUNT from '+
     ' (select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,J.NEW_INPRICE from VIW_GOODSPRICE j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l, '+
     '(select GODS_ID,BATCH_NO,RCK_AMOUNT as AMOUNT from STO_PRINTDATA s,STO_PRINTORDER m where s.TENANT_ID=m.TENANT_ID and s.SHOP_ID=m.SHOP_ID and s.PRINT_DATE=m.PRINT_DATE and m.COMM not in (''02'',''12'') and '+
     ' s.TENANT_ID=:TENANT_ID and s.SHOP_ID=:SHOP_ID and s.PRINT_DATE=:PRINT_DATE) r '+
     ' where l.GODS_ID=r.GODS_ID '+
     ' order by l.GODS_ID) where ROWNUM<=600 order by ROWNUM';
  4:
  result :=
     'select tp.* from ('+
     'select 0 as A,l.*,r.BATCH_NO as BATCH_NO,r.AMOUNT as AMOUNT from '+
     ' (select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,J.NEW_INPRICE from VIW_GOODSPRICE j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l, '+
     '(select GODS_ID,BATCH_NO,RCK_AMOUNT as AMOUNT from STO_PRINTDATA s,STO_PRINTORDER m where s.TENANT_ID=m.TENANT_ID and s.SHOP_ID=m.SHOP_ID and s.PRINT_DATE=m.PRINT_DATE and m.COMM not in (''02'',''12'') and '+
     ' s.TENANT_ID=:TENANT_ID and s.SHOP_ID=:SHOP_ID and s.PRINT_DATE=:PRINT_DATE) r '+
     ' where l.GODS_ID=r.GODS_ID order by l.GODS_ID) tp fetch first 600  rows only';
  5:
  result :=
     'select 0 as A,l.*,r.BATCH_NO as BATCH_NO,r.AMOUNT as AMOUNT from '+
     '(select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,J.NEW_INPRICE '+
     ' from VIW_GOODSPRICE j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l,'+
     '(select GODS_ID,BATCH_NO,RCK_AMOUNT as AMOUNT from STO_PRINTDATA s,STO_PRINTORDER m '+
     ' where s.TENANT_ID=m.TENANT_ID and s.SHOP_ID=m.SHOP_ID and s.PRINT_DATE=m.PRINT_DATE and m.COMM not in (''02'',''12'') and '+
     ' s.TENANT_ID=:TENANT_ID and s.SHOP_ID=:SHOP_ID and s.PRINT_DATE=:PRINT_DATE) r '+
     ' where l.GODS_ID=r.GODS_ID '+
     ' order by l.GODS_ID limit 600 ';
  end;
end;

procedure TfrmSelectCheckGoods.Open(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  cdsList.DisableControls;
  sm := TMemoryStream.Create;
  try
    rs.SQL.Text := EncodeSQL(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('SHOP_ID').asString := SHOP_ID; //传入门店
    if rs.Params.FindParam('MAXID')<>nil then
       rs.Params.ParamByName('MAXID').AsString := MaxId;
    if rs.Params.FindParam('KEYVALUE')<>nil then
       rs.Params.ParamByName('KEYVALUE').AsString := trim(edtSearch.Text);

    if TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger = 3 then
      begin
        if rs.Params.FindParam('SORT_ID')<>nil then
           rs.Params.ParamByName('SORT_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('CLIENT_ID').AsString;
      end
    else
      begin
        if rs.Params.FindParam('SORT_ID')<>nil then
           rs.Params.ParamByName('SORT_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('SORT_ID').AsString;
      end;

    if rs.Params.FindParam('LEVEL_ID')<>nil then
       rs.Params.ParamByName('LEVEL_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
    if rs.Params.FindParam('RELATION_ID')<>nil then
       rs.Params.ParamByName('RELATION_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    if rs.Params.FindParam('PRINT_DATE')<>nil then
       rs.Params.ParamByName('PRINT_DATE').AsString := PRINT_DATE;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('GODS_ID').AsString;
    rs.SaveToStream(sm);
    cdsList.AddFromStream(sm);
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmSelectCheckGoods.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmSelectCheckGoods.btnFilterClick(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmSelectCheckGoods.RzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TfrmSelectCheckGoods.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSelectCheckGoods.btnOkClick(Sender: TObject);
procedure SetCurrent;
begin
  if cdsList.IsEmpty then Exit;
  cdsList.Edit;
  cdsList.FieldByName('A').AsInteger :=1 ;
  cdsList.Post;
end;
var 
  i:integer;
begin
  inherited;
  cdsList.DisableControls;
  try
    if not MultiSelect then SetCurrent;
    cdsList.Edit;
    cdsList.Post;
    cdsList.Filtered := false;
    cdsList.Filter := 'A=1';
    cdsList.Filtered := true;
    if cdsList.IsEmpty then
       begin
         Raise Exception.Create('请选择货品,在选择栏打勾');
       end;
  except
    cdsList.Filtered := false;
    cdsList.EnableControls;
    Raise;
  end;
  ModalResult := MROK;
end;

procedure TfrmSelectCheckGoods.SetMultiSelect(const Value: boolean);
begin
  FMultiSelect := Value;
  DBGridEh1.Columns[0].Visible := Value;
  N2.Enabled:=Value;
  N3.Enabled:=Value;
  N4.Enabled:=Value;
end;

procedure TfrmSelectCheckGoods.DBGridEh1DblClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if Assigned(OnSave) then
     begin
       AObj := TRecord_.Create;
       try
         AObj.ReadFromDataSet(cdsList);
         OnSave(AObj); 
       finally
         AObj.Free;
       end;
     end
  else
     begin
       if not cdsList.IsEmpty then
          btnOkClick(nil)
       else
          edtSearch.SetFocus;
     end;
end;

procedure TfrmSelectCheckGoods.FormShow(Sender: TObject);
var SetCol: TColumnEh;
begin
  inherited;
  Open('');

  //判断是否有查询库存权限
  SetCol:=FindColumn(DBGridEh1,'NEW_INPRICE');
  if SetCol<>nil then
    SetCol.Visible:=ShopGlobal.GetChkRight('14500001',2);
  SetCol:=self.FindColumn(DBGridEh1,'NEW_OUTPRICE');
  if SetCol<>nil then
    SetCol.Visible:=ShopGlobal.GetChkRight('14500001',2);
  //判断软件版本：[服装版需颜色条码和尺寸条码]
  
end;

procedure TfrmSelectCheckGoods.edtSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   if Key=VK_RETURN then
     begin
       Open('');
       DBGridEh1.SetFocus;
     end;

end;

procedure TfrmSelectCheckGoods.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=13 then
     begin
       if cdsList.IsEmpty then Exit;
       cdsList.Edit;
       cdsList.FieldbyName('A').AsInteger := 1;
       cdsList.Post;
       Key := 0;
       btnOkClick(nil);
     end;
  if Key=VK_SPACE then
     begin
       if MultiSelect then
          begin
            if cdsList.IsEmpty then Exit;
            cdsList.Edit;
            cdsList.FieldbyName('A').AsInteger := 1;
            cdsList.Post;
          end
       else
          DBGridEh1DblClick(nil);
     end;
end;

procedure TfrmSelectCheckGoods.RzTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=13 then DBGridEh1.SetFocus;
end;

procedure TfrmSelectCheckGoods.Rb1Click(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmSelectCheckGoods.Rb2Click(Sender: TObject);
begin
  inherited;
  Open('');

end;

procedure TfrmSelectCheckGoods.N1Click(Sender: TObject);
begin
  inherited;
  while not IsEnd do Open(MaxID);
end;

procedure TfrmSelectCheckGoods.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key<>VK_RETURN) and (Key<>VK_ESCAPE) and (Key<>VK_TAB) and (Key<>VK_SPACE) and (KEY<>VK_DOWN) and (KEY<>VK_UP) and (KEY<>VK_LEFT) and (KEY<>VK_RIGHT) and (Key<>0) AND (KEY<>VK_CONTROL) then
     edtSearch.SetFocus;
  inherited;
  if Key = VK_F5 then
     Open('');
end;

procedure TfrmSelectCheckGoods.FormCreate(Sender: TObject);
begin
  inherited;
  N2.Enabled:=False;
  N3.Enabled:=False;
  N4.Enabled:=False;
  if not ShopGlobal.GetChkRight('14500001',2) then
     begin
       DBGridEh1.Columns[6].Free;
     end;
end;

procedure TfrmSelectCheckGoods.chkMultSelectClick(Sender: TObject);
begin
  inherited;
  MultiSelect := chkMultSelect.Checked;
  N2.Visible := chkMultSelect.Checked;
  N3.Visible := chkMultSelect.Checked;
  N4.Visible := chkMultSelect.Checked;
end;

procedure TfrmSelectCheckGoods.N2Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        cdsList.FieldbyName('A').AsInteger := 1;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TfrmSelectCheckGoods.N3Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        if cdsList.FieldbyName('A').AsInteger = 0 then
           cdsList.FieldbyName('A').AsInteger := 1
        else
           cdsList.FieldbyName('A').AsInteger := 0    ;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TfrmSelectCheckGoods.N4Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        cdsList.FieldbyName('A').AsInteger := 0;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TfrmSelectCheckGoods.fndGODS_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  if not Visible then Exit;
  case TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  1:LoadTree;
  3:LoadProv;                       
  else LoadList;
  end;
end;

procedure TfrmSelectCheckGoods.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='A' then
    N2Click(nil);
end;

procedure TfrmSelectCheckGoods.LoadList;
var
  rs:TZQuery;
  AObj:TRecord_;
begin
  ClearTree(rzTree);
  case TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  2:rs := Global.GetZQueryFromName('PUB_CATE_INFO');
  4:rs := Global.GetZQueryFromName('PUB_BRAND_INFO');
  5:rs := Global.GetZQueryFromName('PUB_IMPT_INFO');
  6:rs := Global.GetZQueryFromName('PUB_AREA_INFO');
  7:rs := Global.GetZQueryFromName('PUB_COLOR_INFO');
  8:rs := Global.GetZQueryFromName('PUB_SIZE_INFO');
  end;
  if (rs<>nil) and (rs.Active) then
  begin
    rs.First;
    while not rs.Eof do
      begin
        AObj := TRecord_.Create(rs);
        AObj.ReadFromDataSet(rs);
        rzTree.Items.AddObject(nil,rs.FieldbyName('SORT_NAME').AsString,AObj);
        rs.Next;
      end;
    AddRoot(rzTree,'全部商品');
    if rzTree.Items.Count>0 then rzTree.Items[0].Selected:=true;
  end;
end;

procedure TfrmSelectCheckGoods.LoadProv;
var
  rs:TZQuery;
  AObj:TRecord_;
begin
  ClearTree(RzTree);
  rs := Global.GetZQueryFromName('PUB_CLIENTINFO'); 
  rs.First;
  while not rs.Eof do
    begin
      AObj := TRecord_.Create(rs);
      AObj.ReadFromDataSet(rs);
      rzTree.Items.AddObject(nil,rs.FieldbyName('CLIENT_NAME').AsString,AObj); 
      rs.Next;
    end;
  AddRoot(rzTree,'全部商品');
  if rzTree.Items.Count>0 then rzTree.Items[0].Selected:=true;
end;

procedure TfrmSelectCheckGoods.LoadTree;
var
  IsRoot: Boolean;
  rs:TZQuery;
  w,i:integer;
  AObj,CurObj:TRecord_;
begin
  IsRoot:=False;
  ClearTree(rzTree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  //rs.SortedFields := 'RELATION_ID';  //2011.08.27 排序错乱关闭
  w := -1;
  rs.First;
  while not rs.Eof do
  begin
    if InttoStr(w)<>rs.FieldByName('RELATION_ID').AsString then
    begin
      if trim(rs.FieldByName('RELATION_ID').AsString)='0' then  //自主经营
      begin
        CurObj:=TRecord_.Create;
        CurObj.ReadFromDataSet(rs);
        // 2011.03.12 Add 可选择[供应链节点]的作为查询条件
        CurObj.FieldByName('LEVEL_ID').AsString:='';
        CurObj.FieldByName('SORT_NAME').AsString:=rs.FieldbyName('RELATION_NAME').AsString;
        IsRoot:=true;
      end else
      begin
        AObj := TRecord_.Create;
        AObj.ReadFromDataSet(rs);
        // 2011.03.12 Add 可选择[供应链节点]的作为查询条件
        AObj.FieldByName('LEVEL_ID').AsString:='';
        AObj.FieldByName('SORT_NAME').AsString:=rs.FieldbyName('RELATION_NAME').AsString;
        rzTree.Items.AddObject(nil,rs.FieldbyName('RELATION_NAME').AsString,AObj);
      end;
      w := rs.FieldByName('RELATION_ID').AsInteger;
    end;
    rs.Next;
  end;
  if (IsRoot) and (CurObj<>nil) and (CurObj.FindField('SORT_NAME')<>nil) then
    rzTree.Items.AddObject(nil,CurObj.FieldbyName('SORT_NAME').AsString,CurObj);

  for i:=rzTree.Items.Count-1 downto 0 do
    begin
      rs.Filtered := false;
      rs.filter := 'RELATION_ID='+TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
      rs.Filtered := true;
      //rs.SortedFields := 'LEVEL_ID';  //2011.08.27 排序错乱关闭
      CreateLevelTree(rs,rzTree,'4444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzTree.Items[i]);
    end;
end;

procedure TfrmSelectCheckGoods.SetPRINT_DATE(const Value: string);
begin
  FPRINT_DATE := Value;
end;

function TfrmSelectCheckGoods.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
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

procedure TfrmSelectCheckGoods.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmSelectCheckGoods.SetSHOP_ID(const Value: string);
begin
  FSHOP_ID := Value;
end;

end.
