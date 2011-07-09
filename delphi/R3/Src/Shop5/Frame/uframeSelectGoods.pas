unit uframeSelectGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, ComCtrls, RzTreeVw, Grids, DBGridEh, cxControls, cxContainer,
  cxEdit, cxTextEdit, StdCtrls, cxRadioGroup, DB, zBase,
  cxMaskEdit, cxDropDownEdit, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TframeSelectGoods = class(TframeDialogForm)
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
    IsEnd,Lock: boolean;
    MaxId:string;
    FMultiSelect: boolean;
    procedure InitGrid;
    procedure LoadTree;
    procedure LoadList;
    procedure LoadProv;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    procedure SetMultiSelect(const Value: boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    property MultiSelect:boolean read FMultiSelect write SetMultiSelect;
  end;

implementation
uses uCtrlUtil, uGlobal, uTreeUtil, uShopGlobal, uDsUtil;
{$R *.dfm}

{ TframeSelectGoods }

constructor TframeSelectGoods.Create(AOwner: TComponent);
begin
  inherited;
  MultiSelect := false;
  InitGrid;
  TDbGridEhSort.InitForm(self);
end;

destructor TframeSelectGoods.Destroy;
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TframeSelectGoods.InitGrid;
var rs: TZQuery;
begin
  inherited;
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[5].KeyList.add(rs.Fieldbyname('UNIT_ID').asstring);
      DBGridEh1.Columns[5].PickList.add(rs.Fieldbyname('UNIT_NAME').asstring);
      rs.Next;
    end;
  rs := Global.GetZQueryFromName('PUB_STAT_INFO');
  TdsItems.AddDataSetToItems(rs,fndGODS_FLAG1.Properties.Items,'CODE_NAME');
  fndGODS_FLAG1.ItemIndex := 0;
  LoadTree;
end;

procedure TframeSelectGoods.Open(Id: string);
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
    rs.Params.ParamByName('SHOP_ID').asString := Global.SHOP_ID;
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

function TframeSelectGoods.EncodeSQL(id: string): string;
var
  w,sc:string;
begin
  case Factor.iDbType of
   0: sc := '+';
   1,4,5: sc := '||';
  end;
  w := 'and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') ';
  if id<>'' then
  begin
    if w<>'' then w := w + ' and ';
    w := w + 'j.GODS_ID>:MAXID';
  end;
  if (rzTree.Selected<>nil) and (rzTree.Selected.Data<>nil) then //and (rzTree.Selected.Level>0) 
     begin
      if w<>'' then w := w + ' and ';
      case TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger of
      1:begin
          if rzTree.Selected.Level>0 then
             w := w + 'b.LEVEL_ID like :LEVEL_ID '+sc+'''%'' and b.RELATION_ID=:RELATION_ID '
          else
             w := w + 'b.RELATION_ID=:RELATION_ID ';
        end;
      else
        w := w + 'j.SORT_ID'+TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsString+' = :SORT_ID ';
      end;
     end;
  if trim(edtSearch.Text)<>'' then
     begin
      if w<>'' then w := w + ' and ';
      w := w + '(j.GODS_CODE like ''%'''+sc+':KEYVALUE '+sc+'''%'' or j.GODS_NAME like ''%'''+sc+':KEYVALUE '+sc+'''%'' or j.GODS_SPELL like ''%'''+sc+':KEYVALUE '+sc+'''%'' or (Exists(select GODS_ID from VIW_BARCODE br where br.TENANT_ID=j.TENANT_ID and br.GODS_ID=j.GODS_ID and br.BARCODE like ''%'''+sc+':KEYVALUE )) )';
     end;
  case Factor.iDbType of
   0:
     result := 'select top 600 0 as A,l.*,r.AMOUNT from(select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
            'left outer join '+
            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID';
   1:
     result := 'select * from ('+
            'select 0 as A,l.*,r.AMOUNT from(select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
            'left outer join '+
            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID) where ROWNUM<=600';
   4:
     result := 'select tp.* from ('+
            'select 0 as A,l.*,r.AMOUNT from(select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
            'left outer join '+
            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID) tp fetch first 600  rows only';
   5:
     result := 'select 0 as A,l.*,r.AMOUNT from(select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
            'left outer join '+
            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID limit 600';
  end;
end;

procedure TframeSelectGoods.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TframeSelectGoods.btnFilterClick(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TframeSelectGoods.RzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  if Lock then Exit;
  Open('');
end;

procedure TframeSelectGoods.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TframeSelectGoods.btnOkClick(Sender: TObject);
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

procedure TframeSelectGoods.SetMultiSelect(const Value: boolean);
begin
  FMultiSelect := Value;
  DBGridEh1.Columns[0].Visible := Value;
  N2.Enabled:=Value;
  N3.Enabled:=Value;
  N4.Enabled:=Value;
end;

procedure TframeSelectGoods.DBGridEh1DblClick(Sender: TObject);
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

procedure TframeSelectGoods.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  edtSearch.SetFocus;
end;

procedure TframeSelectGoods.edtSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   if Key=VK_RETURN then
     begin
       Open('');
       DBGridEh1.SetFocus;
     end;

end;

procedure TframeSelectGoods.DBGridEh1KeyDown(Sender: TObject;
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

procedure TframeSelectGoods.RzTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=13 then DBGridEh1.SetFocus;
end;

procedure TframeSelectGoods.Rb1Click(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TframeSelectGoods.Rb2Click(Sender: TObject);
begin
  inherited;
  Open('');

end;

procedure TframeSelectGoods.N1Click(Sender: TObject);
begin
  inherited;
  while not IsEnd do Open(MaxID);
end;

procedure TframeSelectGoods.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key<>VK_RETURN) and (Key<>VK_ESCAPE) and (Key<>VK_TAB) and (Key<>VK_SPACE) and (KEY<>VK_DOWN) and (KEY<>VK_UP) and (KEY<>VK_LEFT) and (KEY<>VK_RIGHT) and (Key<>0) AND (KEY<>VK_CONTROL) then
     edtSearch.SetFocus;
  inherited;
  if Key = VK_F5 then
     Open('');
end;

procedure TframeSelectGoods.FormCreate(Sender: TObject);
begin
  inherited;
  Lock := false;
  N2.Enabled:=False;
  N3.Enabled:=False;
  N4.Enabled:=False;
  // 判断是否有查询库存权限
  if not ShopGlobal.GetChkRight('14500001',1) then
     DBGridEh1.Columns[3].Free;
end;

procedure TframeSelectGoods.chkMultSelectClick(Sender: TObject);
begin
  inherited;
  MultiSelect := chkMultSelect.Checked;
  N2.Visible := chkMultSelect.Checked;
  N3.Visible := chkMultSelect.Checked;
  N4.Visible := chkMultSelect.Checked;
end;

procedure TframeSelectGoods.N2Click(Sender: TObject);
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

procedure TframeSelectGoods.N3Click(Sender: TObject);
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

procedure TframeSelectGoods.N4Click(Sender: TObject);
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

procedure TframeSelectGoods.fndGODS_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  if not Visible then Exit;
  Lock := true;
  try
    case TRecord_(fndGODS_FLAG1.Properties.Items.Objects[fndGODS_FLAG1.ItemIndex]).FieldByName('CODE_ID').AsInteger of
    1:LoadTree;
    3:LoadProv;
    else LoadList;
    end;
  finally
    Lock := false;
  end;
end;

procedure TframeSelectGoods.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='A' then
    N2Click(nil);
end;

procedure TframeSelectGoods.LoadList;
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

procedure TframeSelectGoods.LoadProv;
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

procedure TframeSelectGoods.LoadTree;
var
  rs:TZQuery;
  w,i:integer;
  AObj,CurObj:TRecord_;
begin
  ClearTree(rzTree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs.SortedFields := 'RELATION_ID';
  w := -1;
  rs.First;
  while not rs.Eof do
  begin
    if InttoStr(w)<>rs.FieldByName('RELATION_ID').AsString then
    begin
      if trim(rs.FieldByName('RELATION_ID').AsString)='0' then //自主经营
      begin
        CurObj:=TRecord_.Create;
        CurObj.ReadFromDataSet(rs);
        // 2011.03.12 Add 可选择[供应链节点]的作为查询条件
        CurObj.FieldByName('LEVEL_ID').AsString:='';
        CurObj.FieldByName('SORT_NAME').AsString:=rs.FieldbyName('RELATION_NAME').AsString;
      end else
      begin
        AObj := TRecord_.Create;
        AObj.ReadFromDataSet(rs);
        // 2011.03.12 Add 可选择[供应链节点]的作为查询条件
        AObj.FieldByName('LEVEL_ID').AsString:='';
        AObj.FieldByName('SORT_NAME').AsString:=rs.FieldbyName('RELATION_NAME').AsString;
        rzTree.Items.AddObject(nil,rs.FieldbyName('RELATION_NAME').AsString,AObj);
        w := rs.FieldByName('RELATION_ID').AsInteger;
      end;
    end;
    rs.Next;
  end;

  for i:=rzTree.Items.Count-1 downto 0 do
    begin
      rs.Filtered := false;
      rs.filter := 'RELATION_ID='+TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
      rs.Filtered := true;
      rs.SortedFields := 'LEVEL_ID';
      CreateLevelTree(rs,rzTree,'4444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzTree.Items[i]);
    end;
end;

procedure TframeSelectGoods.DBGridEh1DrawColumnCell(Sender: TObject;
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

end.
