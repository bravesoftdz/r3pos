unit ufrmStorageTracking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, ExtCtrls, jpeg, RzTabs, RzPanel, Grids, DBGridEh, RzTreeVw, ZBase,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cxMaskEdit,
  cxDropDownEdit, cxButtonEdit, zrComboBoxList;

type
  TfrmStorageTracking = class(TframeToolForm)
    RzPanel1: TRzPanel;
    Splitter1: TSplitter;
    CdsStorage: TZQuery;
    RzPanel7: TRzPanel;
    rzTree: TRzTreeView;
    RzPanel6: TRzPanel;
    Panel1: TPanel;
    stbPanel: TPanel;
    Label1: TLabel;
    Grid: TDBGridEh;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    DsStorage: TDataSource;
    RzPanel9: TRzPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label25: TLabel;
    Label12: TLabel;
    btnOk: TRzBitBtn;
    edtUNIT_ID: TcxComboBox;
    edtGoods_Type: TcxComboBox;
    edtGoods_ID: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtSHOP_VALUE: TzrComboBoxList;
    edtSHOP_TYPE: TcxComboBox;
    Label2: TLabel;
    edtGoodsName: TzrComboBoxList;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSHOP_TYPEPropertiesChange(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure edtGoods_TypePropertiesChange(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure GridGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure CdsStorageAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    IsEnd: boolean;
    MaxId:string;
    procedure GetNo;
    procedure LoadTree;
    procedure InitGrid;
    function FindColumn(DBGrid:TDBGridEh;FieldName:String):TColumnEh;
    function TransUnit(CalcIdx: Integer;AliasTabName: string; AliasFileName: string=''): string;
    function EncodeSql(ID:String):String;
    procedure AddGoodTypeItems(GoodSortList: TcxComboBox; SetFlag: string='01111100000000000000');
    procedure AddGoodsIDItems;
    procedure Open(ID:String);
    procedure Shop_Type_Change;
  public
    { Public declarations }
  end;

var
  frmStorageTracking: TfrmStorageTracking;

implementation
uses uTreeUtil,uGlobal, uShopGlobal,uCtrlUtil,uShopUtil,uFnUtil,ufrmEhLibReport,
  ObjCommon,ufrmBasic, Math;
{$R *.dfm}

{ TfrmStorageTrackingWarning }

function TfrmStorageTracking.FindColumn(DBGrid: TDBGridEh;
  FieldName: String): TColumnEh;
var i:Integer;
begin
  Result := nil;
  for i:=0 to DBGrid.Columns.Count-1 do
    begin
      if DBGrid.Columns.Items[i].FieldName = FieldName then
        begin
          Result := DBGrid.Columns[i];
          Exit;
        end;
    end;
end;

procedure TfrmStorageTracking.InitGrid;
begin
  LoadTree;
end;

procedure TfrmStorageTracking.LoadTree;
var rs:TZQuery;
    i,j:Integer;
    Aobj:TRecord_;
begin
  ClearTree(rzTree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs.SortedFields := 'RELATION_ID';
  j:=-1;
  rs.First;
  while not rs.Eof do
    begin
      if (j <> rs.FieldByName('RELATION_ID').AsInteger) then
        begin
          Aobj := TRecord_.Create;
          Aobj.ReadFromDataSet(rs);
          Aobj.FieldByName('LEVEL_ID').AsString := '';
          Aobj.FieldByName('SORT_NAME').AsString := rs.FieldbyName('RELATION_NAME').AsString;
          rzTree.Items.AddObject(nil,Aobj.FieldbyName('SORT_NAME').AsString,Aobj);
          j := Aobj.FieldbyName('RELATION_ID').AsInteger;
        end;
      rs.Next;
    end;
  for i:=rzTree.Items.Count-1 downto 0 do
    begin
      rs.Filtered := False;
      rs.Filter := 'RELATION_ID='+TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString;
      rs.Filtered := True;
      rs.SortedFields := 'LEVEL_ID';
      CreateLevelTree(rs,rzTree,'44444444','SORT_ID','SORT_NAME','LEVEL_ID',0,0,'',rzTree.Items[i]);
    end;
end;

procedure TfrmStorageTracking.FormCreate(Sender: TObject);
begin
  inherited;
  AddGoodTypeItems(edtGoods_Type);
  TDbGridEhSort.InitForm(Self);
  InitGrid;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtGoodsName.DataSet := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtUNIT_ID.ItemIndex := 0;
  edtGoods_Type.ItemIndex := 0;
  edtSHOP_TYPE.ItemIndex := 0;  
end;

procedure TfrmStorageTracking.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(Self);
end;

function TfrmStorageTracking.EncodeSql(ID: String): String;
var StrSql,StrWhere,StrJoin:String;
    Item_Index:Integer;
begin
  case Factor.iDbType of
    0: StrJoin := '+';
    1,4,5: StrJoin := '||';
  end;
  StrWhere := ' and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and C.COMM not in (''12'',''02'') ';
  if ID <> '' then
    StrWhere := StrWhere + ' and C.GODS_ID>='+QuotedStr(ID);
  if edtSHOP_TYPE.ItemIndex = 0 then
    begin
      if edtSHOP_VALUE.Text <> '' then
        StrWhere := StrWhere + ' and B.REGION_ID='+QuotedStr(edtSHOP_VALUE.AsString);
    end
  else
    begin
      if edtSHOP_VALUE.Text <> '' then
        StrWhere := StrWhere + ' and B.SHOP_TYPE='+QuotedStr(edtSHOP_VALUE.AsString);    
    end;

  if rzTree.Selected <> nil then
    begin
      if rzTree.Selected.Level > 0 then
        StrWhere := StrWhere + ' and C.LEVEL_ID like '+QuotedStr(TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString)+StrJoin+'''%'' and C.RELATION_ID='+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString
      else
        StrWhere := StrWhere + ' and C.RELATION_ID='+TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    end;
  Item_Index := StrToIntDef(Trim(TRecord_(edtGoods_Type.Properties.Items.Objects[edtGoods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
  case Item_Index of
    2:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID2='+QuotedStr(edtGoods_ID.AsString);
    end;
    3:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID3='+QuotedStr(edtGoods_ID.AsString);
    end;
    4:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID4='+QuotedStr(edtGoods_ID.AsString);
    end;
    5:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID5='+QuotedStr(edtGoods_ID.AsString);
    end;
    6:begin
      if edtGoods_ID.Text <> '' then
        StrWhere := StrWhere + ' and C.SORT_ID6='+QuotedStr(edtGoods_ID.AsString);
    end;
  end;
  if edtGoodsName.Text <> '' then
    StrWhere := StrWhere + ' and A.GODS_ID='+QuotedStr(edtGoodsName.AsString);
  StrSql :=
  'SELECT A.TENANT_ID,A.SHOP_ID,A.GODS_ID,A.BATCH_NO,A.PROPERTY_01,A.PROPERTY_02,A.NEAR_INDATE,A.NEAR_OUTDATE,A.AMONEY,A.AMOUNT,A.COST_PRICE, '+
  ' B.SHOP_NAME,C.GODS_CODE,C.GODS_NAME,C.BARCODE,'+TransUnit(edtUNIT_ID.ItemIndex,'C','UNIT_NAME')+',C.SORT_ID1,C.SORT_ID2,C.SORT_ID3,C.SORT_ID4,C.SORT_ID5,C.SORT_ID6,C.LEVEL_ID,C.RELATION_ID'+
  ' from STO_STORAGE A,CA_SHOP_INFO B,VIW_GOODSINFO_SORTEXT C where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+
  ' and A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+StrWhere;

  Result :=
  'select jb.*,b.COLOR_NAME as PROPERTY_02_TEXT from ('+
  'select ja.*,a.SIZE_NAME as PROPERTY_01_TEXT from ('+StrSql+') ja '+
  'left outer join VIW_SIZE_INFO a on ja.TENANT_ID=a.TENANT_ID and ja.PROPERTY_01=a.SIZE_ID) jb '+
  'left outer join VIW_COLOR_INFO b on jb.TENANT_ID=b.TENANT_ID and jb.PROPERTY_02=b.COLOR_ID order by jb.SHOP_ID,jb.BATCH_NO  ';
end;

procedure TfrmStorageTracking.Open(ID: String);
var rs:TZQuery;
    rm:TMemoryStream;
begin
  if not Visible then Exit;
  if ID = '' then CdsStorage.Close;
  CdsStorage.DisableControls;
  rs := TZQuery.Create(nil);
  rm := TMemoryStream.Create;
  try
    rs.SQL.Text := EncodeSql(ID);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('GODS_ID').AsString;
    rs.SaveToStream(rm);
    CdsStorage.AddFromStream(rm);
    if rs.RecordCount > 600 then IsEnd := True else IsEnd := False;
  finally
    CdsStorage.EnableControls;
    rs.Free;
    rm.Free;
  end;
end;

procedure TfrmStorageTracking.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_F5 then
     Open('');
end;

procedure TfrmStorageTracking.edtSHOP_TYPEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  Shop_Type_Change;
end;

procedure TfrmStorageTracking.Shop_Type_Change;
begin
  case edtSHOP_TYPE.ItemIndex of
    0:edtSHOP_VALUE.DataSet := Global.GetZQueryFromName('PUB_REGION_INFO');
    1:edtSHOP_VALUE.DataSet := Global.GetZQueryFromName('PUB_SHOP_TYPE');
  end;
  edtSHOP_VALUE.KeyValue := null;
  edtSHOP_VALUE.Text := '';
end;

procedure TfrmStorageTracking.AddGoodTypeItems(
  GoodSortList: TcxComboBox; SetFlag: string);
 procedure AddItems(Cbx: TcxComboBox; Rs: TZQuery; CodeID: string);
 var CurObj: TRecord_;
 begin
   if (not Rs.Active) or (Rs.IsEmpty) then Exit;
   Rs.First;
   while not Rs.Eof do
   begin
     if trim(Rs.FieldByName('CODE_ID').AsString)=trim(CodeID) then
     begin
       CurObj:=TRecord_.Create;
       CurObj.ReadFromDataSet(Rs);
       Cbx.Properties.Items.AddObject(CurObj.fieldbyName('CODE_NAME').AsString,CurObj);
       break;
     end;
     Rs.Next;
   end;
 end;
var
  rs: TZQuery;
  i,InValue: integer;
begin
  try
    rs:=Global.GetZQueryFromName('PUB_STAT_INFO');
    ClearCbxPickList(GoodSortList);  //����ڵ㼰Object����
    for i:=1 to length(SetFlag) do
    begin
      InValue:=StrtoIntDef(SetFlag[i],0);
      if InValue=1 then
        AddItems(GoodSortList, rs, inttostr(i));
    end;
  finally
    rs.Filtered:=False;
    rs.Filter:='';
  end;
end;

procedure TfrmStorageTracking.AddGoodsIDItems;
var Item_Index:Integer;
begin
  if Trim(edtGoods_ID.Text)<>'' then edtGoods_ID.Text := '';
  Item_Index := StrToIntDef(Trim(TRecord_(edtGoods_Type.Properties.Items.Objects[edtGoods_Type.ItemIndex]).FieldByName('CODE_ID').AsString),0);
  if Item_Index = 3 then
    begin
      edtGoods_ID.Columns[0].FieldName := 'CLIENT_NAME';
      edtGoods_ID.KeyField := 'CLIENT_ID';
      edtGoods_ID.ListField := 'CLIENT_NAME';
      edtGoods_ID.FilterFields := 'CLIENT_ID;CLIENT_NAME;CLIENT_SPELL';
    end
  else
    begin
      edtGoods_ID.Columns[0].FieldName := 'SORT_NAME';
      edtGoods_ID.KeyField := 'SORT_ID';
      edtGoods_ID.ListField := 'SORT_NAME';
      edtGoods_ID.FilterFields := 'SORT_ID;SORT_NAME;SORT_SPELL';
    end;
  case Item_Index of
    2: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_CATE_INFO');    //���[�̲�:һ���̡������̡�������]    
    3: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');   //����Ӧ��
    4: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_BRAND_INFO');   //Ʒ��
    5: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_IMPT_INFO');    //�ص�Ʒ��
    6: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_AREA_INFO');    //ʡ����
    7: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_COLOR_GROUP');  //��ɫ
    8: edtGoods_ID.DataSet:=Global.GetZQueryFromName('PUB_SIZE_GROUP');   //����
  end;
end;

procedure TfrmStorageTracking.rzTreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TfrmStorageTracking.edtGoods_TypePropertiesChange(
  Sender: TObject);
begin
  inherited;
  AddGoodsIDItems;
end;

function TfrmStorageTracking.TransUnit(CalcIdx: Integer;
  AliasTabName, AliasFileName: string): string;
var str,AliasTab,SmallCalc,BigCalc: string;
begin
  AliasTab:='';
  if trim(AliasTabName)<>'' then AliasTab:=AliasTabName+'.';
  SmallCalc:='case when isnull('+AliasTab+'SMALLTO_CALC,0)=0 then 1.0 else '+AliasTab+'SMALLTO_CALC end';
  BigCalc  :='case when isnull('+AliasTab+'BIGTO_CALC,0)=0 then 1.0 else '+AliasTab+'BIGTO_CALC end';

  str:=' case when '+AliasTab+'UNIT_ID='+AliasTab+'CALC_UNITS then 1.0 '+   //Ĭ�ϵ�λΪ ������λ
       ' when '+AliasTab+'UNIT_ID='+AliasTab+'SMALL_UNITS then SMALLTO_CALC '+  //Ĭ�ϵ�λΪ С��λ
       ' when '+AliasTab+'UNIT_ID='+AliasTab+'BIG_UNITS then BIGTO_CALC '+   //Ĭ�ϵ�λΪ ��λ
       ' else 1.0 end ';

  case CalcIdx of
   0: result:=str;       //Ĭ�ϵ�λ
   1: result:=' 1.0 ';   //������λ
   2: result:=SmallCalc; //С��װ��λ
   3: result:=BigCalc;   //���װ��λ
  end;
  if AliasFileName<>'' then
    result:=result+' as '+AliasFileName+' ';
end;

procedure TfrmStorageTracking.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmStorageTracking.GridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = Grid.CellRect(Grid.Col, Grid.Row).Top) and (not
    (gdFocused in State) or not Grid.Focused) then
  begin
    Grid.Canvas.Brush.Color := clAqua;
  end;
  
  Grid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQ_NO' then
    begin
      ARect := Rect;
      Grid.canvas.FillRect(ARect);
      DrawText(Grid.Canvas.Handle,pchar(Inttostr(CdsStorage.RecNo)),length(Inttostr(CdsStorage.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmStorageTracking.GridGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmStorageTracking.CdsStorageAfterScroll(DataSet: TDataSet);
begin
  inherited;
  GetNo;
  if IsEnd or not CdsStorage.Eof then Exit;
  if CdsStorage.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmStorageTracking.GetNo;
var Str:String;
begin
  if CdsStorage.RecordCount <= 0 then
    Str := '0'
  else
    Str := IntToStr(CdsStorage.RecNo);
  stbPanel.Caption := '��'+Str+'��/��'+IntToStr(CdsStorage.RecordCount)+'��';
end;

end.
