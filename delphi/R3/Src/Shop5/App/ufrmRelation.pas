unit ufrmRelation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,ADODB,
  cxContainer, cxEdit, cxTextEdit, RzButton, zBase, DB, DBClient, RzTreeVw,
  FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  DBGrids, Buttons;

type
  TfrmRelation = class(TframeToolForm)
    RzPanel1: TRzPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    edtKey: TcxTextEdit;
    Ds_RelationAndGoods: TDataSource;
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
    AllSelect: TMenuItem;
    InverserSelect: TMenuItem;
    NotSelect: TMenuItem;
    btnOk: TRzBitBtn;
    Panel1: TPanel;
    stbPanel: TPanel;
    Label1: TLabel;
    ShowAll: TMenuItem;
    actCopyNew: TAction;
    actPrintBarCode: TAction;
    PrintDBGridEh1: TPrintDBGridEh;
    Cds_RelationAndGoods: TZQuery;
    AddSortTree: TPopupMenu;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Grid_RelationAndGoods: TDBGridEh;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    procedure actFindExecute(Sender: TObject);
    procedure ShowAllClick(Sender: TObject);
    procedure Cds_RelationAndGoodsAfterScroll(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rzTreeChange(Sender: TObject;
      Node: TTreeNode);
    procedure AllSelectClick(Sender: TObject);
    procedure NotSelectClick(Sender: TObject);
    procedure InverserSelectClick(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
  private
    { Private declarations }

    IsEnd: boolean;
    MaxId:string;
    FIsRel: Boolean;
    RNAME,RID:string;
    procedure Prepare;
    procedure LoadTree;
    procedure InitGrid;
    function IsRelation:Boolean;
    function EncodeSql(Id:String):String;
    procedure Open(Id:String);
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    procedure SetIsRel(const Value: Boolean);
  public
    { Public declarations }
    property IsRel:Boolean read FIsRel write SetIsRel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
  end;

implementation

uses
  uTreeUtil,uGlobal,ufrmGoodsInfo, uShopGlobal,uCtrlUtil,uShopUtil,uFnUtil,ufrmRelationInfo,
  ufrmEhLibReport,ufrmSelectGoodSort,ufrmGoodssortTree, ObjCommon, ufrmJoinRelation,
  ufrmBasic, Math;
   

{$R *.dfm}
{ TfrmRelationAndGoods }

constructor TfrmRelation.Create(AOwner: TComponent);
begin
  inherited;
  InitGrid;
  TDbGridEhSort.InitForm(Self);
end;

destructor TfrmRelation.Destroy;
begin
  TDbGridEhSort.FreeForm(Self);
  inherited;
end;

function TfrmRelation.EncodeSql(Id: String): String;
var
  w:string;
  sc:string;
begin
  case Factor.iDbType of
  0:sc := '+';
  1,4,5: sc := '||';
  end;
  w := 'and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') ';
  if Id<>'' then
     begin
      if w<>'' then w := w + ' and ';
      w := w + 'j.GODS_ID>=:MAXID';
     end;
  if (rzTree.Selected<>nil) then
     begin
      if w<>'' then w := w + ' and ';
      if (rzTree.Selected.Level>0) then
         w := w + 'b.LEVEL_ID like :LEVEL_ID '+sc+'''%'' and b.RELATION_ID=:RELATION_ID '
      else
         w := w + 'b.RELATION_ID=:RELATION_ID ';
     end;
  if trim(edtKey.Text)<>'' then
     begin
      if w<>'' then w := w + ' and ';
      w := w + '(j.GODS_CODE like ''%'''+sc+':KEYVALUE '+sc+'''%'' or j.GODS_NAME like ''%'''+sc+':KEYVALUE '+sc+'''%'' or j.GODS_SPELL like ''%'''+sc+':KEYVALUE '+sc+'''%'' or BARCODE like ''%'''+sc+':KEYVALUE )';
     end;
  case Factor.iDbType of
  0:
  result := 'select top 600 0 as A,l.*,r.AMOUNT from(select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,j.NEW_INPRICE,j.NEW_LOWPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
            'left outer join '+
            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID';
  4:
  result := 'select tp.* from ('+
            'select 0 as A,l.*,r.AMOUNT from(select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,j.NEW_INPRICE,j.NEW_LOWPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
            'left outer join '+
            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID) tp fetch first 600  rows only';
  5:
  result := 'select 0 as A,l.*,r.AMOUNT from(select j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,j.NEW_INPRICE,j.NEW_LOWPRICE from VIW_GOODSINFO j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w+') l '+
            'left outer join '+
            '(select GODS_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID group by GODS_ID) r '+
            'on l.GODS_ID=r.GODS_ID order by l.GODS_ID limit 600';
  end;
end;

function TfrmRelation.FindColumn(DBGrid: TDBGridEh;
  FieldName: string): TColumnEh;
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

procedure TfrmRelation.InitGrid;
var rs: TZQuery;
begin
  inherited;
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      Grid_RelationAndGoods.Columns[5].KeyList.add(rs.Fieldbyname('UNIT_ID').asstring);
      Grid_RelationAndGoods.Columns[5].PickList.add(rs.Fieldbyname('UNIT_NAME').asstring);
      rs.Next;
    end;

  LoadTree;
end;

procedure TfrmRelation.LoadTree;
var
  rs:TZQuery;
  w,i:integer;
  AObj:TRecord_;
begin
  ClearTree(rzTree);
  rs := Global.GetZQueryFromName('PUB_GOODSSORT');
  rs.SortedFields := 'RELATION_ID';
  w := -1;
  rs.First;
  while not rs.Eof do
    begin
      if (w<>rs.FieldByName('RELATION_ID').AsInteger) and not((rs.FieldbyName('RELATION_ID').AsInteger=0) and (RNAME='')) then
         begin
           AObj := TRecord_.Create;
           AObj.ReadFromDataSet(rs);
           AObj.FieldByName('LEVEL_ID').AsString:='';
           if rs.FieldbyName('RELATION_ID').AsInteger=0 then
           AObj.FieldByName('SORT_NAME').AsString:= RNAME else
           AObj.FieldByName('SORT_NAME').AsString:=rs.FieldbyName('RELATION_NAME').AsString;
           rzTree.Items.AddObject(nil,AObj.FieldByName('SORT_NAME').AsString,AObj);
           w := rs.FieldByName('RELATION_ID').AsInteger;
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

procedure TfrmRelation.Open(Id: String);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then Cds_RelationAndGoods.close;
  rs := TZQuery.Create(nil);
  Cds_RelationAndGoods.DisableControls;
  sm := TMemoryStream.Create;
  try
    rs.SQL.Text := EncodeSQL(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('SHOP_ID').asString := Global.SHOP_ID;
    if rs.Params.FindParam('MAXID')<>nil then
       rs.Params.ParamByName('MAXID').AsString := MaxId;
    if rs.Params.FindParam('KEYVALUE')<>nil then
       rs.Params.ParamByName('KEYVALUE').AsString := trim(edtKey.Text);
    if rs.Params.FindParam('LEVEL_ID')<>nil then
       rs.Params.ParamByName('LEVEL_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
    if rs.Params.FindParam('RELATION_ID')<>nil then
       rs.Params.ParamByName('RELATION_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('GODS_ID').AsString;
    rs.SaveToStream(sm);
    Cds_RelationAndGoods.AddFromStream(sm);
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    Cds_RelationAndGoods.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmRelation.actFindExecute(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmRelation.ShowAllClick(Sender: TObject);
begin
  inherited;
  while not IsEnd do Open(MaxID);
end;

procedure TfrmRelation.Cds_RelationAndGoodsAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if Cds_RelationAndGoods.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmRelation.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key<>VK_RETURN) and (Key<>VK_ESCAPE) and (Key<>VK_TAB) and (Key<>VK_SPACE) and (KEY<>VK_DOWN) and (KEY<>VK_UP) and (KEY<>VK_LEFT) and (KEY<>VK_RIGHT) and (Key<>0) AND (KEY<>VK_CONTROL) then
     edtKey.SetFocus;
  inherited;
  if Key = VK_F5 then
     Open('');
end;

procedure TfrmRelation.rzTreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  Open('');
end;

procedure TfrmRelation.AllSelectClick(Sender: TObject);
var r:integer;
begin
  inherited;
  r := Cds_RelationAndGoods.RecNo;
  Cds_RelationAndGoods.DisableControls;
  try
    Cds_RelationAndGoods.First;
    while not Cds_RelationAndGoods.Eof do
      begin
        Cds_RelationAndGoods.Edit;
        Cds_RelationAndGoods.FieldbyName('A').AsInteger := 1;
        Cds_RelationAndGoods.Post;
        Cds_RelationAndGoods.Next;
      end;
  finally
    if r>0 then Cds_RelationAndGoods.RecNo := r;
    Cds_RelationAndGoods.EnableControls;
  end;
end;

procedure TfrmRelation.NotSelectClick(Sender: TObject);
var r:integer;
begin
  inherited;
  r := Cds_RelationAndGoods.RecNo;
  Cds_RelationAndGoods.DisableControls;
  try
    Cds_RelationAndGoods.First;
    while not Cds_RelationAndGoods.Eof do
      begin
        Cds_RelationAndGoods.Edit;
        Cds_RelationAndGoods.FieldbyName('A').AsInteger := 0;
        Cds_RelationAndGoods.Post;
        Cds_RelationAndGoods.Next;
      end;
  finally
    if r>0 then Cds_RelationAndGoods.RecNo := r;
    Cds_RelationAndGoods.EnableControls;
  end;
end;

procedure TfrmRelation.InverserSelectClick(Sender: TObject);
var r:integer;
begin
  inherited;
  r := Cds_RelationAndGoods.RecNo;
  Cds_RelationAndGoods.DisableControls;
  try
    Cds_RelationAndGoods.First;
    while not Cds_RelationAndGoods.Eof do
      begin
        Cds_RelationAndGoods.Edit;
        if Cds_RelationAndGoods.FieldbyName('A').AsInteger = 0 then
           Cds_RelationAndGoods.FieldbyName('A').AsInteger := 1
        else
           Cds_RelationAndGoods.FieldbyName('A').AsInteger := 0    ;
        Cds_RelationAndGoods.Post;
        Cds_RelationAndGoods.Next;
      end;
  finally
    if r>0 then Cds_RelationAndGoods.RecNo := r;
    Cds_RelationAndGoods.EnableControls;
  end;
end;

procedure TfrmRelation.actNewExecute(Sender: TObject);
begin
  inherited;
  if TfrmJoinRelation.AddDialog(Self) then
     begin
     end;
end;

procedure TfrmRelation.actEditExecute(Sender: TObject);
var Aobj1:TRecord_;
    i:Integer;
begin
  inherited;
  Aobj1 := TRecord_.Create;
  try
    if ToolButton4.Tag = 1 then
      begin
        if TfrmRelationInfo.EditDialog(Self,RID,Aobj1) then
          begin
            for i:=rzTree.Items.Count-1 downto 0 do
              begin
                if (TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString = '0') then
                  begin
                    Prepare;
                    LoadTree;
                    Break;
                  end;
              end;
            RID := Aobj1.FieldByName('RELATION_ID').AsString;
            RNAME := Aobj1.FieldByName('RELATION_NAME').AsString;
          end;
      end
    else
      begin
        if TfrmRelationInfo.AddDialog(Self,Aobj1) then
          begin
            for i:=rzTree.Items.Count-1 downto 0 do
              begin
                if (TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString = '0') then
                  begin
                    Prepare;
                    LoadTree;
                    Break;
                  end;
              end;
            RID := Aobj1.FieldByName('RELATION_ID').AsString;
            RNAME := Aobj1.FieldByName('RELATION_NAME').AsString;
            IsRel := True;
          end;
      end;
  finally
    Aobj1.Free;
  end;
end;

procedure TfrmRelation.actInfoExecute(Sender: TObject);
begin
  inherited;
  if rzTree.Selected <> nil then
     begin
       if TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString='0' then
          TfrmRelationInfo.ShowDialog(Self,RID)
       else
          TfrmRelationInfo.ShowDialog(Self,TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString);
     end
  else
     MessageBox(Handle,'请选择供应链名称，再查询详细资料','友情提示..',MB_OK+MB_ICONINFORMATION);

end;

procedure TfrmRelation.actDeleteExecute(Sender: TObject);
var
  i:Integer;
  cid:string;
begin
  inherited;
  if rzTree.Selected <> nil then
     begin
       if TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString='0' then
          cid := RID
       else
          cid := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
     end
  else
     MessageBox(Handle,'请选择供应链名称，再执行删除操作','友情提示..',MB_OK+MB_ICONINFORMATION);
  if TfrmRelationInfo.DeleteDialog(Self,cid) then
    begin
      for i:=rzTree.Items.Count-1 downto 0 do
        begin
          if (TRecord_(rzTree.Items[i].Data).FieldbyName('RELATION_ID').AsString = '0') then
            begin
              Prepare;
              LoadTree;
              Break;
            end;
        end;
      IsRel := False;
     end
  else
     MessageBox(Handle,'请选择供应链名称，删除供应链','友情提示..',MB_OK+MB_ICONINFORMATION);
    
end;

function TfrmRelation.IsRelation: Boolean;
begin
  Prepare;
  result := RID<>'';
end;

procedure TfrmRelation.FormCreate(Sender: TObject);
begin
  inherited;
  IsRel := IsRelation;
end;

procedure TfrmRelation.SetIsRel(const Value: Boolean);
begin
  FIsRel := Value;
  if Value then
    begin
      ToolButton4.Tag := 1;
      ToolButton4.Caption := '更名';
    end
  else
    begin
      ToolButton4.Caption := '创建';
      ToolButton4.Tag := 0;
    end;
end;

procedure TfrmRelation.actSaveExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmRelation.actCancelExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmRelation.actPrintExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmRelation.actPreviewExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TfrmRelation.Prepare;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select * from CA_RELATION where TENANT_ID=:TENANT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs);
    RName := rs.FieldbyName('RELATION_NAME').AsString;
    RID := rs.FieldbyName('RELATION_ID').AsString;
    if rs.IsEmpty then
       begin
         ToolButton4.Tag := 1;
         actEdit.Caption := '修改';
       end
    else
       begin
         ToolButton4.Tag := 0;
         actEdit.Caption := '创建';
       end;
  finally
    rs.Free;
  end;
end;

end.
