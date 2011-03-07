{  31200001	0	部门档案	1	查询 	2	新增  3	修改  4	删除  5	打印  6	导出  }

unit ufrmDeptInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ExtCtrls, ComCtrls, RzTreeVw, Grids, DBGridEh,
  cxControls, cxContainer, cxEdit, cxTextEdit, ActnList, Menus, ToolWin,
  StdCtrls, RzLabel, RzTabs, RzPanel, DB, zBase, RzButton,
  jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset, PrnDbgeh, Buttons,
  DBGrids;

type
  TfrmDeptInfoList = class(TframeToolForm)
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    rzTree: TRzTreeView;
    Splitter1: TSplitter;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    DataSource1: TDataSource;
    actRIGHTS: TAction;
    PopupMenu2: TPopupMenu;
    N2: TMenuItem;
    actRIGHTS1: TAction;
    btnOk: TRzBitBtn;
    Panel3: TPanel;
    DBGridEh1: TDBGridEh;
    stbPanel: TPanel;
    Label2: TLabel;
    cdsBrowser: TZQuery;
    PrintDBGridEh1: TPrintDBGridEh;
    pmSort: TPopupMenu;
    Sort_First: TMenuItem;
    Sort_Prior: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Sort_Next: TMenuItem;
    N7: TMenuItem;
    Sort_Last: TMenuItem;
    procedure actFindExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtKeyPropertiesChange(Sender: TObject);
    procedure rzTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure actPrintExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure Sort_FirstClick(Sender: TObject);
    procedure Sort_PriorClick(Sender: TObject);
    procedure Sort_NextClick(Sender: TObject);
    procedure Sort_LastClick(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
  private
    procedure SetRecNo;  //设置记录序号
    function  FindNode(ID: string): TTreeNode;
    procedure DeptTreeSort(SortType: string); //职务树型排序
    function  FindColumn(DBGrid:TDBGridEh;FieldName:string):TColumnEh;
    function  CheckCanExport:boolean; override;
  public
    procedure DoOnTreeChange(Sender: TObject; Node: TTreeNode);
    procedure AddRecord(AObj:TRecord_);
    procedure InitGrid;
    procedure CreateTree;
    procedure Open;
  end;

 

implementation

uses uGlobal,ufrmDeptInfo,uTreeUtil,uShopGlobal, ufrmEhLibReport,
  ObjCommon;

{$R *.dfm}

{ TfrmDeptInfoList }

procedure TfrmDeptInfoList.actFindExecute(Sender: TObject);
begin
  self.Open;
end;

procedure TfrmDeptInfoList.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDeptInfoList.actNewExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31200001',2) then Raise Exception.Create('你没有新增部门的权限,请和管理员联系.');
  with TfrmDeptInfo.Create(self) do
  begin
    try
      OnSave := AddRecord;
      Append;
      ShowModal;
    finally
      free;
    end;
  end;
end;

procedure TfrmDeptInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('31200001',3)  then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  if not cdsBrowser.Active then Raise Exception.Create('没有数据！');
  if cdsBrowser.IsEmpty then Raise Exception.Create('没有数据！');
  with TfrmDeptInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //要检查权限
        // if not IsCompany then Open(cdsBrowser.FieldByName('DEPT_ID').AsString)
        //else
        Edit(cdsBrowser.FieldByName('DEPT_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmDeptInfoList.actDeleteExecute(Sender: TObject);
 procedure UpdateToGlobal(str:string);
 var Temp:TZQuery;
 begin
   Temp := Global.GetZQueryFromName('CA_DEPT_INFO');
   Temp.Filtered :=false;
   if Temp.Locate('DEPT_ID',str,[]) then
   begin
     Temp.Delete;
     Temp.CommitUpdates;
   end;
 end;
var
  i:integer;
  rzNode:TTreeNode;
  Params:TftParamList;
begin
  inherited;
  if not ShopGlobal.GetChkRight('31200001',4)  then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  if not cdsBrowser.Active then Raise Exception.Create('没有数据！');
  if cdsBrowser.IsEmpty then Raise Exception.Create('没有数据！');
  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('DEPT_ID').asString:=cdsBrowser.FieldByName('DEPT_ID').AsString;
      Params.ParamByName('DEPT_NAME').asString:=cdsBrowser.FieldByName('DEPT_NAME').AsString;
      Params.ParamByName('LEVEL_ID').asString:=cdsBrowser.FieldByName('LEVEL_ID').AsString;
      Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Factor.ExecProc('TDeptInfoDelete',Params);
    finally
      Params.Free;
    end;
    UpdateToGlobal(cdsBrowser.FieldByName('DEPT_ID').AsString);
    rzNode:=FindNode(cdsBrowser.FieldByName('DEPT_ID').AsString);
    if rzNode<>nil then
    begin
      TRecord_(rzNode.Data).Free;
      rzNode.Delete;
    end;
    cdsBrowser.Delete;
  end;
end;

procedure TfrmDeptInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmDeptInfoList.edtKeyPropertiesChange(Sender: TObject);
begin
  inherited;
  //TZQueyr组件不支持缓存模糊过滤（Filter），Onchange在实时取数据太消耗资源，关闭掉
 {locked:=True;
  try
    //前后两次参数值不一样时间才重新刷新
    if trim(cdsBrowser.Params.ParamByName('KEYVALUE').AsString)<>trim('''%'+trim(edtKEY.Text)+'%''') then
    begin
      if (trim(edtKEY.Text)<>'') and (rzTree.Items.Count>0) then rzTree.TopItem.Selected := true;
      cdsBrowser.Close;
      cdsBrowser.Params.ParamByName('KEYVALUE').AsString:='''%'+trim(edtKEY.Text)+'%'' '; //关键字的查询参数值
      Factor.Open(cdsBrowser);
    end;
  finally
    locked:=False;
  end; }
end;

procedure TfrmDeptInfoList.rzTreeChanging(Sender: TObject; Node: TTreeNode; var AllowChange: Boolean);
begin
  inherited;
  {
  if locked then exit;
  locked := true;
  try
  finally
    locked := false;
  end;
  }
  if edtKey.Text<>'' then edtKey.Text:='';
end;

procedure TfrmDeptInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var ARect:TRect;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQ_NO' then
  begin
    ARect := Rect;
    DbGridEh1.canvas.FillRect(ARect);
    DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBrowser.RecNo)),length(Inttostr(cdsBrowser.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
  end;
end;

procedure TfrmDeptInfoList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
    Background := clBtnFace;
end;

procedure TfrmDeptInfoList.FormShow(Sender: TObject);
begin
  inherited;
  //进入窗体显示数据：
  if not cdsBrowser.Active then Open;
  if edtKey.CanFocus then edtKey.SetFocus;
end;

procedure TfrmDeptInfoList.actInfoExecute(Sender: TObject);
begin
  if not cdsBrowser.Active then Raise Exception.Create('没有数据！');
  if cdsBrowser.IsEmpty then Raise Exception.Create('没有数据！');
  with TfrmDeptInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //要检查权限
        Open(cdsBrowser.FieldByName('DEPT_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmDeptInfoList.AddRecord(AObj: TRecord_);
var
  i: integer;                          
  CurID,CurName: string;
  IsCreate: Boolean;
  str,cdsUPDEPT_ID,AObjUPDEPT_ID,DEPT_ID:string;
begin
  if not cdsBrowser.Active  then exit;
  AObjUPDEPT_ID:=AObj.FieldByName('LEVEL_ID').AsString;
  if cdsBrowser.Locate('DEPT_ID',AObj.FieldByName('DEPT_ID').AsString,[]) then
  begin
     //2011.02.26 Add 判断是否修改树节点名称:
     if trim(AObj.FieldByName('DEPT_NAME').AsString)<> trim(cdsBrowser.FieldByName('DEPT_NAME').AsString) then
     begin
       CurID:=trim(AObj.FieldByName('DEPT_ID').AsString);
       CurNAME:=trim(AObj.FieldByName('DEPT_NAME').AsString);
     end;
  
     cdsUPDEPT_ID:=cdsBrowser.FieldByName('LEVEL_ID').AsString;
     DEPT_ID:=cdsBrowser.FieldByName('DEPT_ID').AsString;
     cdsBrowser.Edit;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end else
  begin
     cdsUPDEPT_ID:='';
     DEPT_ID:=AObj.FieldByName('DEPT_ID').AsString;
     cdsBrowser.Append;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end;
  InitGrid;
  if (cdsUPDEPT_ID<>AObjUPDEPT_ID) or (AObjUPDEPT_ID='') then
  begin
    if rzTree.Items.Count=1 then
    begin
      CreateTree;
      IsCreate:=true;
      FindNode(DEPT_ID).Selected:=True;
    end else
    begin
      str:='';
      if not rzTree.TopItem.Selected then
        str:=TRecord_(rzTree.Selected.Data).FieldByName('DEPT_ID').AsString;
      CreateTree;
      IsCreate:=true;
      if str<>'' then FindNode(str).Selected:=True;
    end;
  end;

  //2011.02.26 Add  修改节点名称但树没有重新创建
  if (not IsCreate) and (CurID<>'') and (CurName<>'') then
  begin
    for i:=0 to rzTree.Items.Count-1 do
    begin
      if trim(TRecord_(rzTree.Items[i].Data).FieldByName('DEPT_ID').AsString)=CurID then
      begin
        TRecord_(rzTree.Items[i].Data).FieldByName('DEPT_NAME').AsString:=CurNAME;
        rzTree.Items[i].Text:=CurNAME;
      end;
    end;
  end;
  
  cdsBrowser.Locate('DEPT_ID',DEPT_ID,[]);
end;

procedure TfrmDeptInfoList.InitGrid;
var
  tmp: TZQuery;
  GridCol: TColumnEh;  
begin
  tmp := Global.GetZQueryFromName('CA_DEPT_INFO');
  if not tmp.Active then exit;
  GridCol:=FindColumn(DBGridEh1,'UPDEPT_ID');
  if GridCol=nil then exit;
  GridCol.KeyList.Clear;
  GridCol.PickList.Clear;
  tmp.First;
  while not tmp.Eof do
  begin
    GridCol.KeyList.Add(tmp.FieldByName('LEVEL_ID').asstring);
    GridCol.PickList.Add(tmp.FieldByName('DEPT_NAME').AsString);
    tmp.Next;
  end;
end;

procedure TfrmDeptInfoList.FormCreate(Sender: TObject);
begin
  inherited;
  //判断是否为公司总店
  //ShopGlobal.GetIsCompany(Global.UserID);
  // IsCompany:=true;
  InitGrid;
  CreateTree;
end;

procedure TfrmDeptInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actInfoExecute(nil);
end;

function TfrmDeptInfoList.FindNode(ID: string): TTreeNode;
var
  i:Integer;
begin
  Result := nil;
  for i:=1 to rzTree.Items.Count -1 do
  begin
    if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('DEPT_ID').AsString))  then
    begin
      Result := rzTree.Items[i];
      exit;
    end;
  end;
end;

procedure TfrmDeptInfoList.CreateTree;
var
  rs:TZQuery;
  Obj:TRecord_;
  Root,P:TTreeNode;
begin
  RzTree.OnChange:=nil;
  rs := Global.GetZQueryFromName('CA_DEPT_INFO');
  rs.SortedFields:='LEVEL_ID';
  rs.SortType:=stAscending;
  CreateLevelTree(rs,rzTree,'333333333','DEPT_ID','DEPT_NAME','LEVEL_ID',1,3,'');
  Obj  := TRecord_.Create;
  try
    Obj.ReadField(rs);
    Root := rzTree.Items.AddObject(nil,'所有部门',Obj);
    P := Root.getPrevSibling;
    while P<>nil do
    begin
      P.MoveTo(Root,naAddChildFirst);
      P := Root.getPrevSibling;
    end;
    Root.Selected := True;
  finally
  end;
  RzTree.OnChange:=DoOnTreeChange; 
end;

procedure TfrmDeptInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBrowser.RecNo<=0 then  str:='0'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(cdsBrowser.RecordCount)+'条';
end;

procedure TfrmDeptInfoList.actPrintExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('31200001',5) then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  SetRecNo;  //设置记录序号
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmDeptInfoList.actPreviewExecute(Sender: TObject);
begin
  if not ShopGlobal.GetChkRight('31200001',5) then Raise Exception.Create('你没有报表预览'+Caption+'的权限,请和管理员联系.');
  SetRecNo;  //设置记录序号
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

procedure TfrmDeptInfoList.DeptTreeSort(SortType: string);
var
  CurObj: TRecord_;
  Params: TftParamList;
begin
  if rzTree.Selected=nil then Exit;
  if rzTree.Selected.Level=0 then Exit;
  CurObj:=TRecord_(rzTree.Selected.Data);
  if CurObj=nil then Exit;
  if MessageBox(Handle,Pchar('  真的要进行排序吗?   '),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1)=6 then
  begin
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('MoveKind').AsString:=SortType;
      Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Params.ParamByName('LEVEL_ID').asString:=trim(CurObj.fieldbyName('LEVEL_ID').AsString);
      Factor.ExecProc('TDeptInfoSort',Params);
      ShopGlobal.RefreshTable('Ca_DEPT_INFO');
      CreateTree;
      InitGrid;
    finally
      Params.Free;
    end;
  end; 
end;

procedure TfrmDeptInfoList.Sort_FirstClick(Sender: TObject);
begin
  inherited;
  DeptTreeSort('FIRST');
end;

procedure TfrmDeptInfoList.Sort_PriorClick(Sender: TObject);
begin
  inherited;
  DeptTreeSort('PRIOR');
end;

procedure TfrmDeptInfoList.Sort_NextClick(Sender: TObject);
begin
  inherited;
  DeptTreeSort('NEXT');
end;

procedure TfrmDeptInfoList.Sort_LastClick(Sender: TObject);
begin
  inherited;
  DeptTreeSort('LAST');
end;

procedure TfrmDeptInfoList.Open;
var
  vLen: integer;
  str,SQL,Cnd: String;
begin
  inherited;
  Cnd:='';
  try
    if (rzTree.Selected <> nil) and (rzTree.Selected.Level > 0 ) then
    begin
      vLen:=Length(TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString);
      if vLen>0 then Cnd:=' and substring(LEVEL_ID,1,'+InttoStr(vLen)+')=:LEVEL_ID ';
    end;

    if edtKey.Text<>'' then
      Cnd:=Cnd+GetLikeCnd(Factor.iDbType,['DEPT_ID','DEPT_NAME','DEPT_SPELL'],':KEYVALUE','and');

    SQL:='Select 1 as SEQ_NO,DEPT_ID,DEPT_NAME,LEVEL_ID,DEPT_SPELL,TENANT_ID,TELEPHONE,LINKMAN,FAXES,REMARK,SubString(LEVEL_ID,1,Len(LEVEL_ID)-3) as UPDEPT_ID '+
         'From CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+Cnd+' order by DEPT_ID';
    SQL:=ParseSQL(Factor.iDbType,SQL); //函数匹配转换

    cdsBrowser.Close;
    cdsBrowser.SQL.Text:=SQL;
    if cdsBrowser.Params.FindParam('TENANT_ID')<>nil then
      cdsBrowser.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if cdsBrowser.Params.FindParam('LEVEL_ID')<>nil then
      cdsBrowser.ParamByName('LEVEL_ID').AsString:=TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString;
    if cdsBrowser.Params.FindParam('KEYVALUE')<>nil then
      cdsBrowser.ParamByName('KEYVALUE').AsString:=edtKey.Text;
    Factor.Open(cdsBrowser);
  finally
  end;
end;

function TfrmDeptInfoList.FindColumn(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var
  i:integer;
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

procedure TfrmDeptInfoList.SetRecNo;
begin
  //设置数据字段对应序号，打印GridElh需要用到
  if (not cdsBrowser.Active) or (cdsBrowser.IsEmpty) then exit;
  try
    cdsBrowser.DisableControls;
    cdsBrowser.First;
    while not cdsBrowser.eof do
    begin
      if cdsBrowser.FieldByName('SEQ_NO').AsInteger<>cdsBrowser.RecNo then
      begin
        cdsBrowser.Edit;
        cdsBrowser.FieldByName('SEQ_NO').AsString:=InttoStr(cdsBrowser.RecNo);
        cdsBrowser.Post;
      end;
      cdsBrowser.Next;
    end;
  finally
    cdsBrowser.EnableControls;
  end;
end;

procedure TfrmDeptInfoList.DoOnTreeChange(Sender: TObject; Node: TTreeNode);
begin
  self.Open;
end;

procedure TfrmDeptInfoList.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key=#13 then self.Open;
end;

function TfrmDeptInfoList.CheckCanExport: boolean;
begin                             
  result:=ShopGlobal.GetChkRight('31200001',6);
end;

end.
