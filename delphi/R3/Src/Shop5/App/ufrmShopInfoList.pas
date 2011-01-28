unit ufrmShopInfoList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeToolForm, ActnList, Menus, ComCtrls, ToolWin, ExtCtrls,
  RzPanel, Grids, DBGridEh, RzTabs, StdCtrls, RzLabel, cxControls,
  cxContainer, ADODB,cxEdit, cxTextEdit, RzButton, ZBase, DB, DBClient,
  RzTreeVw, FR_Class, jpeg, PrnDbgeh, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmShopInfoList = class(TframeToolForm)
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    dsBrowser: TDataSource;
    ToolButton3: TToolButton;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    rzTree: TRzTreeView;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Label1: TLabel;
    edtKey: TcxTextEdit;
    btnOk: TRzBitBtn;
    Panel3: TPanel;
    DBGridEh1: TDBGridEh;
    stbPanel: TPanel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    actIntoShop: TAction;
    PrintDBGridEh1: TPrintDBGridEh;
    cdsBrowser: TZQuery;
    procedure actNewExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actInfoExecute(Sender: TObject);
    procedure edtKeyKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtKeyPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure actEditExecute(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure rzTreeChange(Sender: TObject; Node: TTreeNode);
    procedure rzTreeChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cdsBrowserAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure actIntoShopExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
  private
    { Private declarations }
    ccid:string;
    locked,IsToShop:Boolean;
  public
    { Public declarations }
    procedure InitGrid;
    procedure CreateTree;
    procedure AddRecord(AObj:TRecord_);
    function  FindNode(ID: string): TTreeNode;
    procedure EditNode(ID: string;Name:string);
    function  PrintSQL:string;
  end;

implementation
uses ufrmShopInfo, uGlobal,uTreeUtil,uShopGlobal,uCtrlUtil,ufrmShopMain;//,ufrmEhLibReport
{$R *.dfm}

procedure TfrmShopInfoList.AddRecord(AObj: TRecord_);
var str,cdsUPCOMP_ID,AObjUPCOMP_ID,SHOP_ID:string;
begin
  if not cdsBrowser.Active  then exit;
  AObjUPCOMP_ID:=AObj.FieldByName('UPCOMP_ID').AsString;
  if cdsBrowser.Locate('SHOP_ID',AObj.FieldByName('SHOP_ID').AsString,[]) then
  begin
     cdsUPCOMP_ID:=cdsBrowser.FieldByName('UPCOMP_ID').AsString;
     SHOP_ID:=cdsBrowser.FieldByName('SHOP_ID').AsString;
     cdsBrowser.Edit;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end
  else
  begin
     cdsUPCOMP_ID:='';
     SHOP_ID:=AObj.FieldByName('SHOP_ID').AsString;
     cdsBrowser.Append;
     AObj.WriteToDataSet(cdsBrowser,false);
     cdsBrowser.Post;
  end;
  InitGrid;
  if (cdsUPCOMP_ID<>AObjUPCOMP_ID) or (AObjUPCOMP_ID='') then
  begin
    if rzTree.Items.Count=0 then
    begin
        CreateTree;
        FindNode(SHOP_ID).Selected:=True;
    end
    else
    begin
        str:=TRecord_(rzTree.Selected.Data).FieldByName('SHOP_ID').AsString;
        CreateTree;
        FindNode(str).Selected:=True;
    end;
  end;
  EditNode(SHOP_ID,AObj.FieldByName('SHOP_NAME').AsString);
  if cdsBrowser.Locate('SHOP_ID',SHOP_ID,[]) then ;
end;

procedure TfrmShopInfoList.actNewExecute(Sender: TObject);
begin
  inherited;
  if IsToShop then
  begin
    if MessageBox(Handle,pchar('门店结构发生变化需要注销，是否要注销?'),pchar(Application.Title),MB_YESNO)=6 then
       frmShopMain.Logined:=frmShopMain.Login(False)
    else
      Abort;
  end;
  if not ShopGlobal.GetChkRight('100004') then Raise Exception.Create('你没有新增'+Caption+'的权限,请和管理员联系.');
  with TfrmShopInfo.Create(self) do
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

procedure TfrmShopInfoList.actDeleteExecute(Sender: TObject);
  procedure UpdateToGlobal(str:string);
  var Temp:TZQuery;
  begin
    Temp := Global.GetZQueryFromName('CA_COMPANY');
    Temp.Filtered :=false;
    if Temp.Locate('SHOP_ID',str,[]) then
    begin
      Temp.Delete;
      Temp.UpdateRecord;//此句是否符合
      //Temp.UpdateBatch(arAll);
    end;
  end;
var Params:TftParamList;
    i:integer;
    rzNode:TTreeNode;
begin
  inherited;
  if IsToShop then
  begin
    if MessageBox(Handle,pchar('门店结构发生变化需要注销，是否要注销?'),pchar(Application.Title),MB_YESNO)=6 then
       frmShopMain.Logined:=frmShopMain.Login(False)
    else
      Abort;
  end;  
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  if not ShopGlobal.GetChkRight('100006') then Raise Exception.Create('你没有删除'+Caption+'的权限,请和管理员联系.');
  i:=MessageBox(Handle,Pchar('是否要删除吗?'),Pchar(Caption),MB_YESNO+MB_DEFBUTTON1);
  if i=6 then
  begin
    if cdsBrowser.FieldbyName('UPCOMP_ID').AsString = '' then Raise Exception.Create('总店不能删除');
    if cdsBrowser.FieldbyName('SHOP_ID').AsInteger = Global.SHOP_ID then Raise Exception.Create('不能删当前登录的门店资料');
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('SHOP_ID').asString:=cdsBrowser.FieldByName('SHOP_ID').AsString;
      Params.ParamByName('SHOP_NAME').asString:=cdsBrowser.FieldByName('SHOP_NAME').AsString;
      Factor.ExecProc('TSHOPDelete',Params);
    finally
      Params.Free;
    end;
    UpdateToGlobal(cdsBrowser.FieldByName('SHOP_ID').AsString);
    rzNode:=FindNode(cdsBrowser.FieldByName('SHOP_ID').AsString);
    if rzNode<>nil then
    begin
      TRecord_(rzNode.Data).Free;
      rzNode.Delete;
    end;
    cdsBrowser.Delete;
  end;
end;

procedure TfrmShopInfoList.actFindExecute(Sender: TObject);
var str:String;
begin
  inherited;
  if (rzTree.Selected <> nil) and (rzTree.Selected.Level > 0 ) then
     begin
       str := ' and LEVEL_ID like '''+TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString+'%''';
     end;
  if edtKey.Text<>'' then
     str:= ' and (SHOP_ID like ''%'+trim(edtKEY.Text)+'%'' or SHOP_NAME like ''%'+trim(edtKEY.Text)+'%'' or SHOP_SPELL like ''%'+trim(edtKEY.Text)+'%'' )';
  cdsBrowser.Close;
  cdsBrowser.SQL.Text:='select SHOP_ID,SHOP_NAME,SHOP_SPELL,SHOP_TYPE,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,REMARK,LEVEL_ID '+
                          'from CA_SHOP_INFO where COMM not in (''02'',''12'') '+str+' order by SEQ_NO';
  Factor.Open(cdsBrowser);
end;

procedure TfrmShopInfoList.InitGrid;
var tmp,tmp1:TZQuery;
begin
  DBGridEh1.FieldColumns['UPCOMP_ID'].PickList.Clear;
  DBGridEh1.FieldColumns['UPCOMP_ID'].KeyList.Clear;
  tmp:=TZQuery.Create(nil);
  try
    tmp.Close;
    tmp.SQL.Text:='select SHOP_ID,SHOP_NAME FROM CA_SHOP_INFO WHERE COMM NOT IN (''02'',''12'')';
    Factor.Open(tmp);
    tmp.First;
    while not tmp.Eof do
    begin
      DBGridEh1.FieldColumns['UPCOMP_ID'].KeyList.Add(tmp.Fields[0].asstring);
      DBGridEh1.FieldColumns['UPCOMP_ID'].PickList.Add(tmp.Fields[1].asstring);
      tmp.Next;
    end;
  finally
    tmp.Free;
  end;

  DBGridEh1.FieldColumns['GROUP_NAME'].PickList.Clear;
  DBGridEh1.FieldColumns['GROUP_NAME'].KeyList.Clear;
  tmp1 := Global.GetZQueryFromName('PUB_REGION_INFO');
  tmp1.First;
  while not tmp1.Eof do
  begin
    DBGridEh1.FieldColumns['GROUP_NAME'].KeyList.Add(tmp1.Fields[0].asstring);
    DBGridEh1.FieldColumns['GROUP_NAME'].PickList.Add(tmp1.Fields[1].asstring);
    tmp1.Next;
  end;
end;

procedure TfrmShopInfoList.FormShow(Sender: TObject);
begin
  inherited;
  if edtKey.CanFocus then
    edtKey.SetFocus;
end;

procedure TfrmShopInfoList.actInfoExecute(Sender: TObject);
begin
  inherited;
  if IsToShop then
  begin
    if MessageBox(Handle,pchar('门店结构发生变化需要注销，是否要注销?'),pchar(Application.Title),MB_YESNO)=6 then
       frmShopMain.Logined:=frmShopMain.Login(False)
    else
      Abort;
  end;  
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmShopInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //要检查权限
        Open(cdsBrowser.FieldByName('SHOP_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmShopInfoList.edtKeyKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DOWN then
     cdsBrowser.Next;
  if Key=VK_UP then
     cdsBrowser.Prior;
end;

procedure TfrmShopInfoList.edtKeyPropertiesChange(Sender: TObject);
begin
  inherited;
  locked:=True;
  try
    if (trim(edtKEY.Text)<>'') and (rzTree.Items.Count>0) then rzTree.TopItem.Selected := true;
    cdsBrowser.Filtered := false;
    cdsBrowser.Filter := 'SHOP_ID like ''%'+trim(edtKEY.Text)+'%'' or SHOP_NAME like ''%'+trim(edtKEY.Text)+'%'' or SHOP_SPELL like ''%'+trim(edtKEY.Text)+'%'' ';
    cdsBrowser.Filtered := (trim(edtKEY.Text)<>'');
  finally
    locked:=False;
  end;
end;
procedure TfrmShopInfoList.DBGridEh1DrawColumnCell(Sender: TObject;
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

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsBrowser.RecNo)),length(Inttostr(cdsBrowser.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmShopInfoList.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if Column.FieldName = 'SEQ_NO' then
     Background := clBtnFace;
end;

procedure TfrmShopInfoList.actEditExecute(Sender: TObject);
begin
  inherited;
  if IsToShop then
  begin
    if MessageBox(Handle,pchar('门店结构发生变化需要注销，是否要注销?'),pchar(Application.Title),MB_YESNO)=6 then
       frmShopMain.Logined:=frmShopMain.Login(False)
    else
      Abort;
  end;  
  if not ShopGlobal.GetChkRight('100005') then Raise Exception.Create('你没有修改'+Caption+'的权限,请和管理员联系.');
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  with TfrmShopInfo.Create(self) do
    begin
      try
        OnSave := AddRecord;
        //要检查权限
        //Open(cdsBrowser.FieldByName('COMP_ID').AsString);
        Edit(cdsBrowser.FieldByName('SHOP_ID').AsString);
        ShowModal;
      finally
        free;
      end;
    end;
end;

procedure TfrmShopInfoList.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  actEditExecute(nil);
end;

procedure TfrmShopInfoList.actExitExecute(Sender: TObject);
begin
  inherited;
  close;
end;

function TfrmShopInfoList.FindNode(ID: string): TTreeNode;
var i:Integer;
begin
  Result := nil;
  for i:=0 to rzTree.Items.Count -1 do
  begin
      if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('COMP_ID').AsString))  then
      begin
        Result := rzTree.Items[i];
        exit;
      end;
  end;
end;

procedure TfrmShopInfoList.rzTreeChange(Sender: TObject; Node: TTreeNode);
begin
  inherited;
  actFindExecute(nil);
end;

procedure TfrmShopInfoList.rzTreeChanging(Sender: TObject; Node: TTreeNode;
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

procedure TfrmShopInfoList.CreateTree;
var tmp:TZQuery;
begin
  tmp:=TZQuery.Create(nil);
  try
    tmp.SQL.Text := 'select SHOP_ID,SHOP_NAME,LEVEL_ID from CA_SHOP_INFO where COMM<>''02'' and COMM<>''12'' order by LEVEL_ID';
    Factor.Open(tmp);
    CreateLevelTree(tmp,rzTree,'333333','SHOP_ID','SHOP_NAME','LEVEL_ID');
  finally
    tmp.Free;
  end;
end;

procedure TfrmShopInfoList.FormCreate(Sender: TObject);
begin
  inherited;
  InitGrid;
  CreateTree;
  TDbGridEhSort.InitForm(self);    
end;

procedure TfrmShopInfoList.cdsBrowserAfterScroll(DataSet: TDataSet);
var str:string;
begin
  inherited;
  if cdsBrowser.RecNo<=0 then  str:='1'
  else str:=IntToStr(cdsBrowser.RecNo);
  stbPanel.Caption:='第'+str+'条/共'+inttostr(cdsBrowser.RecordCount)+'条';
  if cdsBrowser.RecordCount>0 then
  begin
    if cdsBrowser.FieldByName('UPCOMP_ID').AsString='' then
      actDelete.Enabled:=False
    else
      actDelete.Enabled:=True;
  end;
end;

procedure TfrmShopInfoList.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then actEditExecute(nil);
end;

procedure TfrmShopInfoList.FormDestroy(Sender: TObject);
begin
  inherited;
  TDbGridEhSort.FreeForm(self);
end;

procedure TfrmShopInfoList.EditNode(ID, Name: string);
var i:Integer;
begin
  for i:=0 to rzTree.Items.Count -1 do
  begin
      if (UpperCase(ID)=UpperCase(TRecord_(rzTree.Items[i].Data).FieldByName('COMP_ID').AsString))  then
      begin
        rzTree.Items[i].Text:=NAME;
      end;
  end;
end;

procedure TfrmShopInfoList.actIntoShopExecute(Sender: TObject);
var Params:TftParamList;
    tmp:TZQuery;
begin
  inherited;
  if not cdsBrowser.Active then exit;
  if cdsBrowser.IsEmpty then exit;
  if cdsBrowser.FieldByName('UPCOMP_ID').AsString='' then Raise Exception.Create('此门店已经是总店了,不需要再转换!');
  if (cdsBrowser.FieldByName('SHOP_TYPE').AsString<>'2') or (cdsBrowser.FieldByName('UPCOMP_ID').AsString<>TRecord_(rzTree.TopItem.Data).FieldByName('COMP_ID').AsString) then
  Raise Exception.Create('不是总店的下级直营店不能转换!');
  if MessageBox(Handle,pchar('是否确认要转换?'),pchar(Application.Title),MB_YESNO)=6 then
  begin
    tmp:=TZQuery.Create(nil);
    tmp.Close;
    tmp.SQL.Text := ' select SHOP_ID from CA_SHOP_INFO where UPCOMP_ID is null';
    Factor.Open(tmp);
    Params:=TftParamList.Create(nil);
    try
      Params.ParamByName('COMP_ID1').asString:=tmp.FieldByName('SHOP_ID').AsString;
      Params.ParamByName('COMP_ID2').asString:=cdsBrowser.FieldByName('SHOP_ID').AsString;
      Params.ParamByName('LEVEL_ID').asString:=cdsBrowser.FieldByName('LEVEL_ID').AsString;
      Factor.ExecProc('TIntoShop',Params);
      Global.RefreshTable('CA_COMPANY');       //
      Global.RefreshTable('CA_COMPANY_SELF');  //此两行需要修改
      CreateTree;
      rzTree.TopItem.Selected:=True;
      IsToShop:=True;
    finally
      tmp.Free;
      Params.Free;
    end;
  end;
end;

procedure TfrmShopInfoList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if IsToShop then
  begin
    if MessageBox(Handle,pchar('门店结构发生变化需要注销，是否要注销?'),pchar(Application.Title),MB_YESNO)=6 then
    begin
      frmShopMain.Logined:=frmShopMain.Login(False);
      IsToShop:=False;
    end
    else
      Abort;
  end;
end;

procedure TfrmShopInfoList.actPreviewExecute(Sender: TObject);
begin
  inherited;
  {if not ShopGlobal.GetChkRight('100007') then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  with TfrmEhLibReport.Create(self) do
    begin
      try
        Preview(PrintDBGridEh1);
      finally
        free;
      end;
    end;  }
end;

function TfrmShopInfoList.PrintSQL: string;
var str:String;
begin
  if (rzTree.Selected <> nil) and (rzTree.Selected.Level > 0 ) then
     begin
       str := ' and a.LEVEL_ID like '''+TRecord_(rzTree.Selected.Data).FieldbyName('LEVEL_ID').AsString+'%''';
     end;

  // 以下带SQL需要重新设计
  if edtKey.Text<>'' then
     str:= ' and (A.SHOP_ID like ''%'+trim(edtKEY.Text)+'%'' or A.SHOP_NAME like ''%'+trim(edtKEY.Text)+'%'' or A.SHOP_SPELL like ''%'+trim(edtKEY.Text)+'%'' )';
  Result:='select A.SHOP_ID as 门店代码,A.SHOP_NAME as 门店名称,A.SHOP_SPELL as 拼音码,D.SHOE_NAME as 门店类型,B.SHOP_NAME as 隶属经销商, '+
  ' C.SHOE_NAME as 地区,A.TELEPHONE as 电话 from CA_COMPANY A  '+
  ' left outer join  CA_COMPANY B on A.UPCOMP_ID=B.COMP_ID  '+
  ' left outer join  PUB_CODE_INFO C on (A.GROUP_NAME=C.CODE_ID and C.CODE_TYPE=8) '+
  ' left outer join  (select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''COMP_TYPE'') D on A.COMP_TYPE=D.CODE_ID '+
  ' where A.COMM not in (''02'',''12'') '+STR+' order by A.SEQ_NO';
end;

procedure TfrmShopInfoList.actPrintExecute(Sender: TObject);
begin
  inherited;
  {if not ShopGlobal.GetChkRight('100007') then
    Raise Exception.Create('你没有打印'+Caption+'的权限,请和管理员联系.');
  PrintDBGridEh1.DBGridEh := DBGridEh1;
  PrintDBGridEh1.Print;  }
end;

end.
