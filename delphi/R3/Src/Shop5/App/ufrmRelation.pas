{  32700001 供应链管理  1 查询  2	申请  3	创建 4	删除 5	维护 6	导出 7	打印 }

unit ufrmRelation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, StdCtrls,
  RzLabel, RzTabs, ExtCtrls, RzPanel, Grids, DBGridEh, cxControls,ADODB,
  cxContainer, cxEdit, cxTextEdit, RzButton, zBase, DB, DBClient, RzTreeVw,
  FR_Class, PrnDbgeh, jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  DBGrids, Buttons, cxRadioGroup;

type
  TfrmRelation = class(TframeToolForm)
    RzPanel1: TRzPanel;
    Panel3: TPanel;
    Panel4: TPanel;
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
    Panel1: TPanel;
    stbPanel: TPanel;
    Label1: TLabel;
    ShowAll: TMenuItem;
    PrintDBGridEh1: TPrintDBGridEh;
    Cds_RelationAndGoods: TZQuery;
    AddSortTree: TPopupMenu;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Grid_RelationAndGoods: TDBGridEh;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    rb1: TcxRadioButton;
    rb2: TcxRadioButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    actModify: TAction;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    procedure actFindExecute(Sender: TObject);
    procedure ShowAllClick(Sender: TObject);
    procedure Cds_RelationAndGoodsAfterScroll(DataSet: TDataSet);
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
    procedure rb1Click(Sender: TObject);
    procedure rb2Click(Sender: TObject);
    procedure Grid_RelationAndGoodsDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure actAuditExecute(Sender: TObject);
  private
    IsEnd: boolean;
    MaxId:string;
    FIsRel: Boolean;
    RNAME,RID:string;
    procedure Prepare;
    procedure LoadTree;
    procedure InitGrid;
    procedure ChangeButton;
    function IsRelation:Boolean;
    function EncodeSql(Id:String):String;
    procedure Open(Id:String);
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    procedure SetIsRel(const Value: Boolean);
    function  getflag: integer;
    function  CheckCanExport:Boolean;
    function  GetParentTENANT_ID: integer;  //2011.06.08 返回当前市级的企业ID（卷烟供应链）
  public
    property IsRel:Boolean read FIsRel write SetIsRel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    property flag:integer read getflag;
  end;

implementation

uses
  uTreeUtil,uGlobal,ufrmGoodsInfo, uShopGlobal,uCtrlUtil,uShopUtil,uFnUtil,ufrmRelationInfo,
  ufrmEhLibReport,ufrmSelectGoodSort,ufrmGoodssortTree, ObjCommon, ufrmJoinRelation,
  ufrmBasic, Math ,uCaFactory, ufrmRelationUpdateMode;
   

{$R *.dfm}
{ TfrmRelationAndGoods }

constructor TfrmRelation.Create(AOwner: TComponent);
begin
  inherited;
  TDbGridEhSort.InitForm(Self);
  InitGrid;
  LoadTree;
end;

destructor TfrmRelation.Destroy;
begin
  TDbGridEhSort.FreeForm(Self);
  inherited;
end;

function TfrmRelation.EncodeSql(Id: String): String;
var
  w,Sqlrid:string;
  sc:string;
begin
  case Factor.iDbType of
  0:sc := '+';
  1,4,5: sc := '||';
  end;
  Sqlrid := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').asString;
  if Sqlrid = '0' then Sqlrid := RID;;
  case flag of
  0:begin
      w := 'and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') ';
      if Id<>'' then
         begin
          if w<>'' then w := w + ' and ';
          w := w + 'j.GODS_ID>:MAXID';
         end;
      if (rzTree.Selected<>nil) then
         begin
          if (rzTree.Selected.Level>0) then
             w := w + ' and b.LEVEL_ID like :LEVEL_ID '+sc+'''%'' '
         end;
      result :=
         'select 0 as A,'+Sqlrid+' as RELATION_ID,j.TENANT_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,j.NEW_INPRICE,j.NEW_LOWPRICE,c.SECOND_ID,c.GODS_CODE as SECOND_CODE '+
         'from PUB_GOODSINFO j,PUB_GOODSSORT b,PUB_GOODS_RELATION c where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID and j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID and c.RELATION_ID=:RELATION_ID and c.COMM not in (''02'',''12'') '+w;
    end;
  1:begin
      w := 'and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') ';
      if Id<>'' then
         begin
          if w<>'' then w := w + ' and ';
          w := w + 'j.GODS_ID>:MAXID';
         end;
      if (rzTree.Selected<>nil) then
         begin
          if (rzTree.Selected.Level>0) then
             w := w + 'and b.LEVEL_ID like :LEVEL_ID '+sc+'''%'' '
         end;
      result :=
         'select 0 as A,'+Sqlrid+' as RELATION_ID,j.TENANT_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,j.NEW_INPRICE,j.NEW_LOWPRICE,j.GODS_ID as SECOND_ID,j.GODS_CODE as SECOND_CODE '+
         'from PUB_GOODSINFO j,PUB_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID and not Exists(select * from PUB_GOODS_RELATION where TENANT_ID=j.TENANT_ID and GODS_ID=j.GODS_ID and RELATION_ID=:RELATION_ID and COMM not in (''02'',''12'')) '+w;
    end;
  2:begin
      w := 'and j.TENANT_ID=:TENANT_ID and j.COMM not in (''02'',''12'') ';
      if Id<>'' then
         begin
          if w<>'' then w := w + ' and ';
          w := w + 'j.GODS_ID>:MAXID';
         end;
      if (rzTree.Selected<>nil) then
         begin
          if w<>'' then w := w + ' and ';
          if (rzTree.Selected.Level>0) then
             w := w + 'b.LEVEL_ID like :LEVEL_ID '+sc+'''%'' and b.RELATION_ID=:RELATION_ID '
          else
             w := w + 'b.RELATION_ID=:RELATION_ID ';
         end;
      result :=
         'select 0 as A,'+Sqlrid+' as RELATION_ID,j.TENANT_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,j.NEW_INPRICE,j.NEW_LOWPRICE,j.SECOND_ID,j.SECOND_CODE '+
         'from VIW_GOODSINFO j,VIW_GOODSSORT b where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID '+w;
    end;
  3:begin
      w := 'and j.TENANT_ID=:P_TENANT_ID and j.COMM not in (''02'',''12'') ';
      if Id<>'' then
         begin
          if w<>'' then w := w + ' and ';
          w := w + 'j.GODS_ID>:MAXID';
         end;
      if (rzTree.Selected<>nil) then
         begin
          if w<>'' then w := w + ' and ';
          if (rzTree.Selected.Level>0) then
             w := w + 'b.LEVEL_ID like :LEVEL_ID '+sc+'''%'' and c.RELATION_ID=:RELATION_ID '
          else
             w := w + 'c.RELATION_ID=:RELATION_ID ';
         end;
      result :=
        'select 0 as A,'+Sqlrid+' as RELATION_ID,'+inttostr(Global.TENANT_ID)+' as TENANT_ID,j.GODS_ID,j.GODS_CODE,j.GODS_NAME,j.BARCODE,j.CALC_UNITS as UNIT_ID,j.NEW_OUTPRICE,j.NEW_INPRICE,j.NEW_LOWPRICE,j.SECOND_ID,j.SECOND_CODE '+
        'from VIW_GOODSINFO j,VIW_GOODSSORT b,PUB_GOODS_RELATION c where j.SORT_ID1=b.SORT_ID and j.TENANT_ID=b.TENANT_ID and j.TENANT_ID=c.TENANT_ID and j.GODS_ID=c.GODS_ID and c.RELATION_ID=:RELATION_ID and c.COMM not in (''02'',''12'') '+w+
        ' and not Exists(select * from PUB_GOODS_RELATION where TENANT_ID=:TENANT_ID and GODS_ID=j.GODS_ID and RELATION_ID=:RELATION_ID and COMM not in (''02'',''12''))';
    end;
  end;
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by GODS_ID';
  1:result := 'select * from ('+result+' order by GODS_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by GODS_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by GODS_ID limit 600';
  else
    result := 'select * from ('+result+') j order by GODS_ID';
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
var
  rs: TZQuery;
  SetCol: TColumnEh;
begin
  inherited;
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  SetCol:=FindColumn(Grid_RelationAndGoods,'UNIT_ID');
  if (SetCol<>nil) and (rs.Active) and (rs.RecordCount>0) then
  begin
    SetCol.KeyList.Clear;
    SetCol.PickList.Clear;
    rs.First;
    while not rs.Eof do
    begin
      SetCol.KeyList.add(rs.Fieldbyname('UNIT_ID').asstring);
      SetCol.PickList.add(rs.Fieldbyname('UNIT_NAME').asstring);
      rs.Next;
    end;
  end;
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
  if rzTree.TopItem<>nil then rzTree.TopItem.Selected := true;
end;

procedure TfrmRelation.Open(Id: String);
function GetRelationPid:integer;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select TENANT_ID from CA_RELATIONS where RELATI_ID=:TENANT_ID and RELATION_ID=:RELATION_ID';
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    if rs.Params.FindParam('RELATION_ID')<>nil then
       rs.Params.ParamByName('RELATION_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString;
    Factor.open(rs);
    result := rs.Fields[0].asInteger;
  finally
    rs.free;
  end;
end;
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if rzTree.Selected=nil then Exit;
  if Id='' then Cds_RelationAndGoods.close;
  rs := TZQuery.Create(nil);
  Cds_RelationAndGoods.DisableControls;
  sm := TMemoryStream.Create;
  try
    rs.SQL.Text := EncodeSQL(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    if rs.Params.FindParam('P_TENANT_ID')<>nil then
       rs.Params.ParamByName('P_TENANT_ID').AsInteger := GetRelationPid;
    if rs.Params.FindParam('MAXID')<>nil then
       rs.Params.ParamByName('MAXID').AsString := MaxId;
    if rs.Params.FindParam('LEVEL_ID')<>nil then
       rs.Params.ParamByName('LEVEL_ID').AsString := TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
    if rs.Params.FindParam('RELATION_ID')<>nil then
       begin
         rs.Params.ParamByName('RELATION_ID').AsInteger := TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsInteger;
         if rs.Params.ParamByName('RELATION_ID').AsInteger = 0 then rs.Params.ParamByName('RELATION_ID').AsInteger := strtoint(RID);
       end;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('GODS_ID').AsString;
    rs.IndexFieldNames:='GODS_CODE';
    rs.SortedFields:='GODS_CODE';
    rs.SaveToStream(sm);
    if trim(Id)='' then //新查询
    begin
      Cds_RelationAndGoods.LoadFromStream(sm);
      Cds_RelationAndGoods.IndexFieldNames:='GODS_CODE';
      Cds_RelationAndGoods.SortedFields:='GODS_CODE';
    end else
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

procedure TfrmRelation.rzTreeChange(Sender: TObject;
  Node: TTreeNode);
begin
  inherited;
  if rzTree.Selected = nil then Exit;
  if rzTree.Selected.Data = nil then Exit;
  Open('');
  ChangeButton;
end;

procedure TfrmRelation.AllSelectClick(Sender: TObject);
var r:integer;
begin
  inherited;
  r := Cds_RelationAndGoods.RecNo;
  while not IsEnd do Open(MaxID);  //全选之前先全部查询
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
  if TfrmJoinRelation.AddDialog(Self) then
     begin
       Global.LoadBasic;
       Prepare;
       LoadTree;
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
        if not ShopGlobal.GetChkRight('32700001',5) then Raise Exception.Create('你没有维护'+Caption+'的权限,请和管理员联系.');
        if TfrmRelationInfo.EditDialog(Self,RID,Aobj1) then
          begin
            Prepare;
            LoadTree;
            RID := Aobj1.FieldByName('RELATION_ID').AsString;
            RNAME := Aobj1.FieldByName('RELATION_NAME').AsString;
          end;
      end
    else
      begin
        if not ShopGlobal.GetChkRight('32700001',3) then Raise Exception.Create('你没有创建'+Caption+'的权限,请和管理员联系.');
        if TfrmRelationInfo.AddDialog(Self,Aobj1) then
          begin
            Prepare;
            LoadTree;
            RID := Aobj1.FieldByName('RELATION_ID').AsString;
            RNAME := Aobj1.FieldByName('RELATION_NAME').AsString;
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
  if not ShopGlobal.GetChkRight('32700001',4) then Raise Exception.Create('你没有维护'+Caption+'的权限,请和管理员联系.');
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
      Prepare;
      LoadTree;
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
      actEdit.Caption := '更名';
    end
  else
    begin
      actEdit.Caption := '创建';
      ToolButton4.Tag := 0;
    end;
end;

procedure TfrmRelation.actSaveExecute(Sender: TObject);
var Params:TftParamList;
begin
  inherited;
  if not Cds_RelationAndGoods.Active then Exit;
  if not ShopGlobal.GetChkRight('32700001',5) then Raise Exception.Create('你没有维护'+Caption+'的权限,请和管理员联系.');
  Cds_RelationAndGoods.CommitUpdates;
  Cds_RelationAndGoods.DisableControls;
  Params := TftParamList.Create(nil);
  try
    Cds_RelationAndGoods.Filtered := false;
    Cds_RelationAndGoods.Filter := 'A=1';
    Cds_RelationAndGoods.Filtered := true;
    try
      Cds_RelationAndGoods.First;
      while not Cds_RelationAndGoods.Eof do Cds_RelationAndGoods.Delete;
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
      case flag of
      0,2:Factor.UpdateBatch(Cds_RelationAndGoods,'TDelFromRelation',Params);
      1,3:Factor.UpdateBatch(Cds_RelationAndGoods,'TAddToRelation',Params);
      end;
    except
      Cds_RelationAndGoods.CancelUpdates;
      Raise;
    end;
  finally
    Params.Free;
    Cds_RelationAndGoods.Filtered := false;
    Cds_RelationAndGoods.EnableControls;
  end;
//
end;

procedure TfrmRelation.actCancelExecute(Sender: TObject);
var
  CurTen_ID,pTen_ID: Integer;  //当前登陆TENANT_ID
begin
  inherited;
  if not ShopGlobal.GetChkRight('32700001',5) then Raise Exception.Create('你没有维护'+Caption+'的权限,请和管理员联系.');

  {
  //2011.06.08 Add增加自动对照:
  pTen_ID:=GetParentTENANT_ID;  //返回省级烟草公司ID
  if pTen_ID>0 then
  begin
    CurTen_ID:=Global.TENANT_ID; //当前Tenant_ID存储临时 CurTen_ID
    Global.TENANT_ID:=pTen_ID;   //省级ID 赋入 Global.TENANT_ID
    CaFactory.SyncAll(1);        //执行省公司
    Global.TENANT_ID:=CurTen_ID; //替换回原TENANT_ID
  end;
  }
  
  //原来
  CaFactory.SyncAll(1);
  Global.LoadBasic;
  InitGrid;
  Prepare;
  LoadTree;
end;

procedure TfrmRelation.actPrintExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('32700001',7) then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  PrintDBGridEh1.DBGridEh := Grid_RelationAndGoods;
  PrintDBGridEh1.Print;
//
end;

procedure TfrmRelation.actPreviewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('32700001',7) then
    Raise Exception.Create('你没有预览'+Caption+'的权限,请和管理员联系.');
  PrintDBGridEh1.DBGridEh := Grid_RelationAndGoods;
  with TfrmEhLibReport.Create(self) do
  begin
    try
      Preview(PrintDBGridEh1);
    finally
      free;
    end;
  end;
//
end;

procedure TfrmRelation.Prepare;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select * from CA_RELATION where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'')';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs);
    RName := rs.FieldbyName('RELATION_NAME').AsString;
    RID := rs.FieldbyName('RELATION_ID').AsString;
    IsRel := not rs.IsEmpty;
  finally
    rs.Free;
  end;
end;

procedure TfrmRelation.ChangeButton;
begin
  case flag of
  0:actSave.Caption := '撤消';
  1:actSave.Caption := '发布';
  2:actSave.Caption := '禁用';
  3:actSave.Caption := '启用';
  end;
end;

procedure TfrmRelation.rb1Click(Sender: TObject);
begin
  inherited;
  Open('');
  ChangeButton;
end;

procedure TfrmRelation.rb2Click(Sender: TObject);
begin
  inherited;
  Open('');
  ChangeButton;
end;

function TfrmRelation.getflag: integer;
begin
  result := 0;
  if rzTree.Selected=nil then Exit;
  if TRecord_(rzTree.Selected.Data).FieldbyName('RELATION_ID').AsString='0' then
     begin
       if rb1.Checked then
          result := 0
       else
          result := 1;
     end
  else
     begin
       if rb1.Checked then
          result := 2
       else
          result := 3;
     end;
end;

procedure TfrmRelation.Grid_RelationAndGoodsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  ARect:TRect;
begin
  inherited;
  if (Rect.Top = Grid_RelationAndGoods.CellRect(Grid_RelationAndGoods.Col, Grid_RelationAndGoods.Row).Top) and (not
     (gdFocused in State) or not Grid_RelationAndGoods.Focused) then
  begin
    Grid_RelationAndGoods.Canvas.Brush.Color := rowSelectColor;
  end;
  Grid_RelationAndGoods.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
  begin
    ARect := Rect;
    Grid_RelationAndGoods.canvas.FillRect(ARect);
    DrawText(Grid_RelationAndGoods.Canvas.Handle,pchar(Inttostr(Cds_RelationAndGoods.RecNo)),length(Inttostr(Cds_RelationAndGoods.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

function TfrmRelation.CheckCanExport: Boolean;
begin
  Result := ShopGlobal.GetChkRight('32700001',6);
end;

{ 对照: 000000000000138  000000000230014  000000000231197 }
procedure TfrmRelation.actAuditExecute(Sender: TObject);
var
  ReValue: Boolean; //执行后返回结果
  UpdateMode: integer;
begin                                        
  inherited;
  if not ShopGlobal.GetChkRight('32700001',5) then Raise Exception.Create('你没有维护"'+Caption+'"权限,请和管理员联系.');
  TfrmRelationUpdateMode.FrmShow;
end;


//2011.06.08 返回当前市级的企业ID（卷烟供应链）
function TfrmRelation.GetParentTENANT_ID: integer;
var
  Qry: TZQuery;
begin
  try
    Qry:=TZQuery.Create(nil);
    Qry.SQL.Text:='select TENANT_ID from CA_RELATIONS where RELATION_ID=1000006 and RELATI_ID='+InttoStr(Global.TENANT_ID);
    Factor.Open(Qry);
    if Qry.Active then
      result:=Qry.fieldbyName('TENANT_ID').AsInteger;
  finally
    Qry.Free;
  end;
end;

end.
