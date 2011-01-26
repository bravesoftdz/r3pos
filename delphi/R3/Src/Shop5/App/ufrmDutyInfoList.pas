unit ufrmDutyInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ExtCtrls, ComCtrls, RzTreeVw, Grids, DBGridEh,
  cxControls, cxContainer, cxEdit, cxTextEdit, ActnList, Menus, ToolWin,
  StdCtrls, RzLabel, RzTabs, RzPanel, DB, ADODB, zBase, RzButton,
  jpeg, ZAbstractRODataset, ZAbstractDataset, ZDataset, PrnDbgeh, Buttons,
  DBGrids;

type
  TfrmDutyInfoList = class(TframeToolForm)
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
    procedure Image3Click(Sender: TObject);
    procedure Sort_FirstClick(Sender: TObject);
    procedure Sort_PriorClick(Sender: TObject);
    procedure Sort_NextClick(Sender: TObject);
    procedure Sort_LastClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ftParams: TftParamList;  
    procedure DutyTreeSort(SortType: string); //职务树型排序
  public
    locked, IsCompany : boolean;
    procedure AddRecord(AObj:TRecord_);
    procedure InitGrid;
    procedure CreateTree;
    function  FindNode(ID: string): TTreeNode;
    function  PrintSQL:string;    
    { Public declarations }
  end;

 

implementation

uses uGlobal,ufrmDutyInfo,uTreeUtil,uShopGlobal, ufrmEhLibReport;

{$R *.dfm}

procedure TfrmDutyInfoList.actFindExecute(Sender: TObject);
var
  str,SQL,LEVEL_ID: String;
begin
  inherited;
  str:='';
  SQL:='';
  if (rzTree.Selected <> nil) and (rzTree.Selected.Level > 0 ) then
  begin
    LEVEL_ID:=trim(TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString);
    if LEVEL_ID<>'' then
    begin
      ftParams.ParamByName('LEVEL_ID').AsString:=LEVEL_ID; //设置参数值
      case Factor.iDbType of
       0: str:=str+' and substring(LEVEL_ID,1,'+InttoStr(length(LEVEL_ID))+')=:LEVEL_ID ';
       5: str:=str+' and substr(LEVEL_ID,1,'+InttoStr(length(LEVEL_ID))+')=:LEVEL_ID '
      end;  
    end;
  end;

  if edtKey.Text<>'' then
  begin
    ftParams.ParamByName('KEYVALUE').AsString:='''%'+trim(edtKEY.Text)+'%'''; //设置参数值
    str:=str+' and (DUTY_ID like :KEYVALUE or DUTY_NAME like :KEYVALUE or DUTY_SPELL like :KEYVALUE) ';
  end;
  
  case Factor.iDbType of
   0: SQL:='Select DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,TENANT_ID,REMARK,SubString(LEVEL_ID,1,Len(LEVEL_ID)-3) as UPDUTY_ID '+
           'From CA_DUTY_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+str+' order by DUTY_ID';
   5: SQL:='Select DUTY_ID,DUTY_NAME,LEVEL_ID,DUTY_SPELL,TENANT_ID,REMARK,SubStr(LEVEL_ID,1,Length(LEVEL_ID)-3) as UPDUTY_ID '+
           'From CA_DUTY_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') '+str+' order by DUTY_ID';
  end;
  cdsBrowser.Close;
  cdsBrowser.SQL.Text:=SQL;
  cdsBrowser.Params.AssignValues(ftParams); 
  Factor.Open(cdsBrowser);
end;

procedure TfrmDutyInfoList.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDutyInfoList.actNewExecute(Sender: TObject);
begin
  inherited;
  //if not IsCompany then  raise Exception.Create('不是总店，不能新增职务!');
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有新增职务的权限,请和管理员联系.');
  with TfrmDutyInfo.Create(self) do
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

procedure TfrmDutyInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  //if not ShopGlobal.GetChkRight('100010') then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmDutyInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //要检查权限
        if not IsCompany then
          Open(cdsBrowser.FieldByName('DUTY_ID').AsString)
        else
          Edit(cdsBrowser.FieldByName('DUTY_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmDutyInfoList.actDeleteExecute(Sender: TObject);
procedure UpdateToGlobal(str:string);
var Temp:TZQuery;
begin
  Temp := Global.GetZQueryFromName('CA_DUTY_INFO');
  Temp.Filtered :=false;
  if Temp.Locate('DUTY_ID',str,[]) then
  begin
    Temp.Delete;
    Temp.CommitUpdates;
  end;
end;
var Params:TftParamList;
    i:integer;
    rzNode:TTreeNode;
    tmp:TADODataSet;
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
      Params.ParamByName('DUTY_ID').asString:=cdsBrowser.FieldByName('DUTY_ID').AsString;
      Params.ParamByName('DUTY_NAME').asString:=cdsBrowser.FieldByName('DUTY_NAME').AsString;
      Params.ParamByName('LEVEL_ID').asString:=cdsBrowser.FieldByName('LEVEL_ID').AsString;
      Params.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;
      Factor.ExecProc('TDutyInfoDelete',Params);
    finally
      Params.Free;
    end;
    UpdateToGlobal(cdsBrowser.FieldByName('DUTY_ID').AsString);
    rzNode:=FindNode(cdsBrowser.FieldByName('DUTY_ID').AsString);
    if rzNode<>nil then
    begin
      TRecord_(rzNode.Data).Free;
      rzNode.Delete;
    end;
    cdsBrowser.Delete;
  end;
end;

procedure TfrmDutyInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmDutyInfoList.edtKeyPropertiesChange(Sender: TObject);
begin
  inherited;
  //TZQueyr组件不支持本地模糊查询，Onchange在实时取数据太消耗资源，关闭掉
  {
  locked:=True;
  try
    //关键字参数发生变化时间查询
    if trim(ftParams.ParamByName('KEYVALUE').AsString)<>trim('''%'+trim(edtKEY.Text)+'%''') then
    begin
      if (trim(edtKEY.Text)<>'') and (rzTree.Items.Count>0) then rzTree.TopItem.Selected := true;
      ftParams.ParamByName('KEYVALUE').AsString:='''%'+trim(edtKEY.Text)+'%''';
      cdsBrowser.close;
      cdsBrowser.Params.AssignValues(ftParams);
      Factor.Open(cdsBrowser);      
    end;
  finally
    locked:=False;
  end;
  }

end;

procedure TfrmDutyInfoList.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  actFindExecute(nil);
end;

procedure TfrmDutyInfoList.rzTreeChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
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

procedure TfrmDutyInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmDutyInfoList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmDutyInfoList.FormShow(Sender: TObject);
begin
  inherited;
  actFindExecute(nil);
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmDutyInfoList.actInfoExecute(Sender: TObject);
begin
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmDutyInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //要检查权限
        Open(cdsBrowser.FieldByName('DUTY_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmDutyInfoList.AddRecord(AObj: TRecord_);
var
  str,cdsUPDUTY_ID,AObjUPDUTY_ID,DUTY_ID:string;
begin
  if not cdsBrowser.Active  then exit;
  AObjUPDUTY_ID:=AObj.FieldByName('LEVEL_ID').AsString;
  if cdsBrowser.Locate('DUTY_ID',AObj.FieldByName('DUTY_ID').AsString,[]) then
  begin
     cdsUPDUTY_ID:=cdsBrowser.FieldByName('LEVEL_ID').AsString;
     DUTY_ID:=cdsBrowser.FieldByName('DUTY_ID').AsString;
     cdsBrowser.Edit;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end else
  begin
     cdsUPDUTY_ID:='';
     DUTY_ID:=AObj.FieldByName('DUTY_ID').AsString;
     cdsBrowser.Append;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end;
  InitGrid;
  if (cdsUPDUTY_ID<>AObjUPDUTY_ID) or (AObjUPDUTY_ID='') then
  begin
    if rzTree.Items.Count=1 then
    begin
      CreateTree;
       FindNode(DUTY_ID).Selected:=True;
    end
    else
    begin
      str:='';
      if not rzTree.TopItem.Selected then
        str:=TRecord_(rzTree.Selected.Data).FieldByName('DUTY_ID').AsString;
      CreateTree;
      if str<>'' then
        FindNode(str).Selected:=True;
    end;
  end;
  if cdsBrowser.Locate('DUTY_ID',DUTY_ID,[]) then ;
end;

procedure TfrmDutyInfoList.InitGrid;
var
  tmp:TZQuery;
  P,Root:TTreeNode;
  Obj  :TRecord_ ;
begin
  DBGridEh1.FieldColumns['UPDUTY_ID'].PickList.Clear;
  DBGridEh1.FieldColumns['UPDUTY_ID'].KeyList.Clear;
  tmp := Global.GetZQueryFromName('CA_DUTY_INFO');
  tmp.First;
  while not tmp.Eof do
  begin
    DBGridEh1.FieldColumns['UPDUTY_ID'].KeyList.Add(tmp.FieldByName('LEVEL_ID').asstring);
    DBGridEh1.FieldColumns['UPDUTY_ID'].PickList.Add(tmp.FieldByName('DUTY_NAME').AsString);
    tmp.Next;
  end;
end;

procedure TfrmDutyInfoList.FormCreate(Sender: TObject);
begin
  //创建参数对象:
  ftParams:=TftParamList.Create(nil);
  ftParams.ParamByName('TENANT_ID').AsInteger:=ShopGlobal.TENANT_ID;

  inherited;
  //判断是否为公司总店
  //ShopGlobal.GetIsCompany(Global.UserID);
  IsCompany:=true;
  InitGrid;
  CreateTree;
end;

procedure TfrmDutyInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actEditExecute(nil);
end;

function TfrmDutyInfoList.FindNode(ID: string): TTreeNode;
var
  i:Integer;
begin
  Result := nil;
  for i:=1 to rzTree.Items.Count -1 do
  begin
    if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('DUTY_ID').AsString))  then
    begin
      Result := rzTree.Items[i];
      exit;
    end;
  end;
end;

procedure TfrmDutyInfoList.CreateTree;
var rs:TZQuery;
    Obj:TRecord_;
    Root,P:TTreeNode;
begin
  rs := Global.GetZQueryFromName('CA_DUTY_INFO');
  rs.SortedFields:='LEVEL_ID';
  rs.SortType:=stAscending;
  CreateLevelTree(rs,rzTree,'333333333','Duty_ID','Duty_NAME','LEVEL_ID',1,3,'');
  Obj  := TRecord_.Create;
  try
    Obj.ReadField(rs);
    Root := rzTree.Items.AddObject(nil,'所有职务',Obj);
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

procedure TfrmDutyInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBrowser.RecNo<=0 then  str:='0'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(cdsBrowser.RecordCount)+'条';
end;

function TfrmDutyInfoList.PrintSQL: string;
var str:String;
begin
  inherited;
  if (rzTree.Selected <> nil) and (rzTree.Selected.Level > 0 ) then
     begin
       str := ' and A.LEVEL_ID='''+TRecord_(rzTree.Selected.Data).FieldbyName('DUTY_ID').AsString+''' or A.DUTY_ID='''+TRecord_(rzTree.Selected.Data).FieldbyName('DUTY_ID').AsString+'''';
     end;
  if edtKey.Text<>'' then
     str:=' and (A.DUTY_ID like ''%'+trim(edtKEY.Text)+'%'' or A.DUTY_NAME like ''%'+trim(edtKEY.Text)+'%'' or A.DUTY_SPELL like ''%'+trim(edtKEY.Text)+'%'') ';
  Result:=' select A.DUTY_ID as 职务代码,A.DUTY_NAME as 职务名称,A.DUTY_SPELL as 拼音码,B.DUTY_NAME 上级职务,A.REMARK as 描述'+
          ' from CA_DUTY_INFO A left outer join CA_DUTY_INFO B on A.UPDUTY_ID=B.DUTY_ID  '+
          ' where A.COMM not in (''02'',''12'') '+str+' order by A.DUTY_ID';
end;

procedure TfrmDutyInfoList.actPrintExecute(Sender: TObject);
begin
  //if not ShopGlobal.GetChkRight('100014') then Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;
end;

procedure TfrmDutyInfoList.actPreviewExecute(Sender: TObject);
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

procedure TfrmDutyInfoList.Image3Click(Sender: TObject);
begin
  inherited;
  ShopGlobal.CA_DUTY_INFO.Close;
  Factor.Open(ShopGlobal.CA_DUTY_INFO);
end;

procedure TfrmDutyInfoList.DutyTreeSort(SortType: string);
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
      Factor.ExecProc('TDutyInfoSort',Params);
      if ShopGlobal.RefreshTable('Ca_DUTY_INFO') then
        CreateTree;
    finally
      Params.Free;
    end;
  end; 
end;

procedure TfrmDutyInfoList.Sort_FirstClick(Sender: TObject);
begin
  inherited;
  DutyTreeSort('FIRST');
end;

procedure TfrmDutyInfoList.Sort_PriorClick(Sender: TObject);
begin
  inherited;
  DutyTreeSort('PRIOR');
end;

procedure TfrmDutyInfoList.Sort_NextClick(Sender: TObject);
begin
  inherited;
  DutyTreeSort('NEXT');
end;

procedure TfrmDutyInfoList.Sort_LastClick(Sender: TObject);
begin
  inherited;
  DutyTreeSort('LAST');
end;


procedure TfrmDutyInfoList.FormDestroy(Sender: TObject);
begin
  inherited;
  ftParams.Free;   //释放参数对象  
end;

end.
