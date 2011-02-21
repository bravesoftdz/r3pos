unit ufrmDeptInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ExtCtrls, ComCtrls, RzTreeVw, Grids, DBGridEh,
  cxControls, cxContainer, cxEdit, cxTextEdit, ActnList, Menus, ToolWin,
  StdCtrls, RzLabel, RzTabs, RzPanel, DB, ADODB, zBase, RzButton,
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
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
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
  private
    locked, IsCompany : boolean;
    procedure DeptTreeSort(SortType: string); //职务树型排序
  public
    procedure AddRecord(AObj:TRecord_);
    procedure InitGrid;
    procedure CreateTree;
    function  FindNode(ID: string): TTreeNode;
  end;

 

implementation

uses uGlobal,ufrmDeptInfo,uTreeUtil,uShopGlobal, ufrmEhLibReport;

{$R *.dfm}

{ TfrmDeptInfoList }

procedure TfrmDeptInfoList.actFindExecute(Sender: TObject);
var
  vLen: integer;
  str,SQL: String;
begin
  inherited;
  try
    if (rzTree.Selected <> nil) and (rzTree.Selected.Level > 0 ) then
    begin
      vLen:=Length(TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString);
      if vLen>0 then
      begin
        case Factor.iDbType of
         0:   str:=' and substring(LEVEL_ID,1,'+InttoStr(vLen)+')=:LEVEL_ID ';
         4,5: str:=' and substr(LEVEL_ID,1,'+InttoStr(vLen)+')=:LEVEL_ID ';
        end;
      end;
    end;

    if edtKey.Text<>'' then
    begin
      case Factor.iDbType of
       0:   str:=' and (DEPT_ID like ''%''+:KEYVALUE+''%'' or DEPT_NAME like ''%''+:KEYVALUE+''%'' or DEPT_SPELL like ''%''+:KEYVALUE+''%'') ';
       4,5: str:=' and (DEPT_ID like ''%''||:KEYVALUE||''%'' or DEPT_NAME like ''%''||:KEYVALUE||''%'' or DEPT_SPELL like ''%''||:KEYVALUE||''%'') ';
      end;
    end;

    case Factor.iDbType of
     0:   SQL:='Select DEPT_ID,DEPT_NAME,LEVEL_ID,DEPT_SPELL,TENANT_ID,TELEPHONE,LINKMAN,FAXES,REMARK,SubString(LEVEL_ID,1,Len(LEVEL_ID)-3) as UPDEPT_ID '+
                'From CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+str+' order by DEPT_ID';
     4,5: SQL:='Select DEPT_ID,DEPT_NAME,LEVEL_ID,DEPT_SPELL,TENANT_ID,TELEPHONE,LINKMAN,FAXES,REMARK,SubStr(LEVEL_ID,1,Length(LEVEL_ID)-3) as UPDEPT_ID '+
                'From CA_DEPT_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+str+' order by DEPT_ID';
    end;
    cdsBrowser.Close;
    cdsBrowser.SQL.Text:=SQL;
    //设置参数:
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

procedure TfrmDeptInfoList.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDeptInfoList.actNewExecute(Sender: TObject);
begin
  inherited;
  //if not IsCompany then  raise Exception.Create('不是总店，不能新增职务!');
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有新增职务的权限,请和管理员联系.');
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
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmDeptInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //要检查权限
        if not IsCompany then
          Open(cdsBrowser.FieldByName('DEPT_ID').AsString)
        else
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
var Params:TftParamList;
    i:integer;
    rzNode:TTreeNode;
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  //if not IsCompany then raise Exception.Create('不是总店，不能删除职务!');
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
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

procedure TfrmDeptInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
  end;
  }
end;

procedure TfrmDeptInfoList.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  actFindExecute(nil);
end;

procedure TfrmDeptInfoList.rzTreeChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  inherited;
  if locked then exit;
  locked := true;
  try
   if edtKey.Text<>'' then edtKey.Text:='';
  finally
    locked := false;
  end;
end;

procedure TfrmDeptInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
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
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmDeptInfoList.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmDeptInfoList.actInfoExecute(Sender: TObject);
begin
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
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
  str,cdsUPDEPT_ID,AObjUPDEPT_ID,DEPT_ID:string;
begin
  if not cdsBrowser.Active  then exit;
  AObjUPDEPT_ID:=AObj.FieldByName('LEVEL_ID').AsString;
  if cdsBrowser.Locate('DEPT_ID',AObj.FieldByName('DEPT_ID').AsString,[]) then
  begin
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
       FindNode(DEPT_ID).Selected:=True;
    end
    else
    begin
      str:='';
      if not rzTree.TopItem.Selected then
        str:=TRecord_(rzTree.Selected.Data).FieldByName('DEPT_ID').AsString;
      CreateTree;
      if str<>'' then
        FindNode(str).Selected:=True;
    end;
  end;
  if cdsBrowser.Locate('DEPT_ID',DEPT_ID,[]) then ;
end;

procedure TfrmDeptInfoList.InitGrid;
var
  tmp: TZQuery;
begin
  DBGridEh1.FieldColumns['UPDEPT_ID'].PickList.Clear;
  DBGridEh1.FieldColumns['UPDEPT_ID'].KeyList.Clear;
  tmp := Global.GetZQueryFromName('CA_DEPT_INFO');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['UPDEPT_ID'].KeyList.Add(tmp.FieldByName('LEVEL_ID').asstring);
    DBGridEh1.FieldColumns['UPDEPT_ID'].PickList.Add(tmp.FieldByName('DEPT_NAME').AsString);
    tmp.Next;
  end;
end;

procedure TfrmDeptInfoList.FormCreate(Sender: TObject);
begin
  inherited;
  //判断是否为公司总店
  //ShopGlobal.GetIsCompany(Global.UserID);
  IsCompany:=true;
  InitGrid;
  CreateTree;
end;

procedure TfrmDeptInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actEditExecute(nil);
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
  //if not ShopGlobal.GetChkRight('100014') then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmDeptInfoList.actPreviewExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('100014') then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
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
      Params.ParamByName('OLD_TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Params.ParamByName('LEVEL_ID').asString:='_'+CurObj.fieldbyName('LEVEL_ID').AsString;
      Params.ParamByName('OLD_LEVEL_ID').asString:=CurObj.fieldbyName('LEVEL_ID').AsString;
      Factor.ExecProc('TDeptInfoSort',Params);
      if ShopGlobal.RefreshTable('Ca_DEPT_INFO') then
        CreateTree;
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

end.
