unit ufrmGoodssort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, RzButton,
  Grids, DBGridEh, DB, ZBase, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmGoodssort = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsUnit: TDataSource;
    btnAppend: TRzBitBtn;
    btnDelete: TRzBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    CtrlUp: TAction;
    CtrlDown: TAction;
    CtrlHome: TAction;
    CtrlEnd: TAction;
    cdsGoodsSort: TZQuery;
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cdsGoodsSortBeforePost(DataSet: TDataSet);
    procedure cdsGoodsSortNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsGoodsSortAfterEdit(DataSet: TDataSet);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure CtrlUpExecute(Sender: TObject);
    procedure CtrlDownExecute(Sender: TObject);
    procedure CtrlHomeExecute(Sender: TObject);
    procedure CtrlEndExecute(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure cdsGoodsSortBeforeInsert(DataSet: TDataSet);
  private
    FFlag: integer;
    FSort_Type: integer;
    procedure SetFlag(const Value: integer);
    procedure SetSort_Type(const Value: integer);
    { Private declarations }
  protected
    procedure SetdbState(const Value: TDataSetState);
    function CheckCanExport:boolean;
  public
    procedure RefreshTable;
    procedure Open;
    procedure Save;
    { Public declarations }
    class function AddDialog(Owner:TForm;var AObj:TRecord_;SORTTYPE: Integer=1):boolean;
    class function ShowDialog(Owner:TForm;SORTTYPE: Integer=1):boolean;
    property Flag:integer read FFlag write SetFlag; //1:其它窗体调用这个窗体
    property Sort_Type:integer read FSort_Type write SetSort_Type;
  end;

implementation
uses  uGlobal,uFnUtil,uDsUtil,uShopUtil, uShopGlobal, ufrmBasic, Math;
{$R *.dfm}

procedure TfrmGoodssort.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  cdsGoodsSort.FieldByName('SORT_SPELL').AsString:=Fnstring.GetWordSpell(Text,3);
  btnSave.Enabled:=True;
end;

procedure TfrmGoodssort.btnAppendClick(Sender: TObject);
begin
  inherited;
  if cdsGoodsSort.State in [dsEdit,dsInsert] then cdsGoodsSort.Post;
  if not cdsGoodsSort.IsEmpty then
  begin
    cdsGoodsSort.Last;
    if (cdsGoodsSort.FieldByName('SORT_NAME').AsString='') and (cdsGoodsSort.FieldByName('SORT_SPELL').AsString='') and (cdsGoodsSort.FieldByName('SORT_ID').AsString='') then
      exit;
  end;
  cdsGoodsSort.DisableControls;
  try
    cdsGoodsSort.First;
    while not cdsGoodsSort.Eof do
    begin
      if cdsGoodsSort.FieldByName('SORT_NAME').AsString='' then
        raise Exception.Create('名称不能为空！');
      if cdsGoodsSort.FieldByName('SORT_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsGoodsSort.Next;
    end;
  finally
    cdsGoodsSort.EnableControls;
  end;
  cdsGoodsSort.Append;
  if Visible then
    begin
      DBGridEh1.SetFocus;
      DBGridEh1.Col:=1;
      DBGridEh1.EditorMode := true;
    end;
end;

procedure TfrmGoodssort.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('确认要删除"'+cdsGoodsSort.FieldbyName('SORT_NAME').AsString+'"吗？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsGoodsSort.Delete;
  if cdsGoodsSort.State in [dsEdit,dsInsert] then cdsGoodsSort.Post;
  //删除后重新排序
  cdsGoodsSort.DisableControls;
  try
    cdsGoodsSort.First;
    while not cdsGoodsSort.Eof do
    begin
      cdsGoodsSort.Edit;
      cdsGoodsSort.FieldByName('SEQ_NO').AsString:=IntToStr(cdsGoodsSort.RecNo);
      cdsGoodsSort.Post;
      cdsGoodsSort.Next;
    end;
  finally
    cdsGoodsSort.EnableControls;
  end;
  btnSave.Enabled:=True;
  //如果删除后没有记录，删除按钮不能操作
  if cdsGoodsSort.IsEmpty then
  begin
    btnDelete.Enabled:=False;
    Exit;
  end;
end;

procedure TfrmGoodssort.btnSaveClick(Sender: TObject);
begin
  inherited;
  if cdsGoodsSort.State in [dsInsert,dsEdit] then cdsGoodsSort.Post;
  if (cdsGoodsSort.FieldbyName('SORT_NAME').AsString='') and (cdsGoodsSort.FieldbyName('SORT_SPELL').AsString='') and (cdsGoodsSort.FieldbyName('SORT_ID').AsString='')then
  begin
    if not cdsGoodsSort.IsEmpty then
      cdsGoodsSort.Delete;
  end;
  cdsGoodsSort.DisableControls;
  try
    cdsGoodsSort.First;
    while not cdsGoodsSort.Eof do
    begin
      if cdsGoodsSort.FieldByName('SORT_NAME').AsString='' then
        raise Exception.Create('名称不能为空！');
      if cdsGoodsSort.FieldByName('SORT_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsGoodsSort.Next;
    end;
  finally
    cdsGoodsSort.EnableControls;
  end;
  Save;
  //别的窗体调用此窗体
  if Flag=1 then
    ModalResult:=MROK;
  btnSave.Enabled:=False;
  if btnDelete.Enabled=False then
     btnDelete.Enabled:=True;
end;

procedure TfrmGoodssort.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmGoodssort.Open;
var Params: TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('SORT_TYPE').asInteger := Sort_Type;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsGoodsSort,'TGoodsSort',Params);
  finally
    Params.Free;
  end;
  if cdsGoodsSort.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmGoodssort.Save;
var c:integer;
    i:integer;
begin
  i:=cdsGoodsSort.RecNo;
  if cdsGoodsSort.IsEmpty then
    i:=0;
  cdsGoodsSort.DisableControls;
  try
    c := 0;
    cdsGoodsSort.First;
    while not cdsGoodsSort.Eof do
      begin
        inc(c);
        if c = cdsGoodsSort.FieldByName('SEQ_NO').AsInteger THEN
          begin
            cdsGoodsSort.Next;
            Continue;
          end;
        cdsGoodsSort.Edit;
        cdsGoodsSort.FieldByName('SEQ_NO').AsInteger := c;
        cdsGoodsSort.Post;
        cdsGoodsSort.Next;  
      end;
  finally
    cdsGoodsSort.EnableControls;
  end;
  try
    Factor.UpdateBatch(cdsGoodsSort,'TGoodsSort');
  except
    cdsGoodsSort.Close;
    Open;
    if not cdsGoodsSort.IsEmpty then
    begin
      if i=0 then i:=1;
      cdsGoodsSort.RecNo:=i;
    end;
    if cdsGoodsSort.IsEmpty then btnDelete.Enabled:=False;
    btnSave.Enabled:=False;
    raise;    
  end;
  RefreshTable;
  if not cdsGoodsSort.IsEmpty then
  begin
    if i=0 then i:=1;
    cdsGoodsSort.RecNo:=i;
  end;
  if cdsGoodsSort.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmGoodssort.cdsGoodsSortBeforePost(DataSet: TDataSet);
begin
  inherited;
  {if (DBGridEh1.Row=DBGridEh1.RowCount-1) and (cdsGoodsSort.FieldByName('SORT_ID').AsString='') then
  begin
    exit;
  end;
  if cdsGoodsSort.FieldByName('SORT_NAME').AsString='' then raise Exception.Create('分类名称不能为空！');
  if cdsGoodsSort.FieldByName('SORT_SPELL').AsString='' then raise Exception.Create('拼音码不能为空！'); }
end;

procedure TfrmGoodssort.cdsGoodsSortNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsGoodsSort.FieldByName('SEQ_NO').AsString:=IntToStr(cdsGoodsSort.RecordCount+1);
  cdsGoodsSort.FieldByName('SORT_ID').AsString := TSequence.NewId;
  cdsGoodsSort.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsGoodsSort.FieldByName('SORT_TYPE').AsInteger := Sort_Type;
end;

procedure TfrmGoodssort.FormShow(Sender: TObject);
begin
  inherited;

  Open;
  btnSave.Enabled:=False;
  //DBGridEh1.SetFocus;
  //别的窗体调用此窗体，直接新增
  if Flag=1 then
  begin
    btnAppendClick(nil);
    btnAppend.Enabled:=False;
    btnDelete.Enabled:=False;
  end;
end;

procedure TfrmGoodssort.DBGridEh1DrawColumnCell(Sender: TObject;
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

end;

procedure TfrmGoodssort.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  inherited;
  if btnSave.Enabled=True  then
  begin
    i:=MessageBox(Handle,Pchar('记录有修改,是否要保存吗?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
      abort
    else if i=6 then
      btnSaveClick(nil);
  end;
end;

procedure TfrmGoodssort.cdsGoodsSortAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmGoodssort.AddDialog(Owner: TForm;
  var AObj: TRecord_;SORTTYPE:Integer): boolean;
begin
   with TfrmGoodsSort.Create(Owner) do
    begin
      try
        Flag:=1;
        Sort_Type := SORTTYPE;
        if not ShopGlobal.GetChkRight('32300001',2) then Raise Exception.Create('你没有编辑'+Caption+'的权限,请和管理员联系.');
        ShowModal;
        if ModalResult=MROK then
        begin
          AObj.ReadFromDataSet(cdsGoodsSort);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;


procedure TfrmGoodssort.SetFlag(const Value: integer);
begin
  FFlag := Value;
end;

procedure TfrmGoodssort.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

procedure TfrmGoodssort.CtrlUpExecute(Sender: TObject);
var SEQ_NO,UNIT_ID,SEQ_NO1,UNIT_ID1:string;
begin
  inherited;
  if cdsGoodsSort.IsEmpty then exit;
  if cdsGoodsSort.RecordCount=1 then exit;
  if cdsGoodsSort.RecNo=1 then exit;
  if cdsGoodsSort.State in [dsEdit,dsInsert] then cdsGoodsSort.Post;
  if cdsGoodsSort.RecNo=cdsGoodsSort.RecordCount then
  begin
    if cdsGoodsSort.FieldByName('SORT_NAME').AsString='' then
    begin
      cdsGoodsSort.Delete;
      exit;
    end;
    if cdsGoodsSort.FieldByName('SORT_SPELL').AsString='' then
    begin
      cdsGoodsSort.Delete;
      exit;
    end;
  end;
  SEQ_NO:=cdsGoodsSort.FieldByName('SEQ_NO').AsString;
  UNIT_ID:=cdsGoodsSort.FieldByName('SORT_ID').AsString;
  cdsGoodsSort.Prior;
  SEQ_NO1:=cdsGoodsSort.FieldByName('SEQ_NO').AsString;
  UNIT_ID1:=cdsGoodsSort.FieldByName('SORT_ID').AsString;
  if cdsGoodsSort.Locate('SORT_ID',UNIT_ID1,[]) then
  begin
    cdsGoodsSort.Edit;
    cdsGoodsSort.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsGoodsSort.Post;
  end;
  if cdsGoodsSort.Locate('SORT_ID',UNIT_ID,[]) then
  begin
    cdsGoodsSort.Edit;
    cdsGoodsSort.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsGoodsSort.Post;
  end;
  cdsGoodsSort.indexfieldnames:='SEQ_NO';
end;

procedure TfrmGoodssort.CtrlDownExecute(Sender: TObject);
var SEQ_NO,UNIT_ID,SEQ_NO1,UNIT_ID1:string;
begin
  inherited;
  if cdsGoodsSort.IsEmpty then exit;
  if cdsGoodsSort.RecordCount=1 then exit;
  if cdsGoodsSort.RecNo=cdsGoodsSort.RecordCount then exit;
  if cdsGoodsSort.State in [dsEdit,dsInsert] then cdsGoodsSort.Post;
  if cdsGoodsSort.RecNo=cdsGoodsSort.RecordCount then
  begin
    if cdsGoodsSort.FieldByName('SORT_NAME').AsString='' then
    begin
      cdsGoodsSort.Delete;
      exit;
    end;
    if cdsGoodsSort.FieldByName('SORT_SPELL').AsString='' then
    begin
      cdsGoodsSort.Delete;
      exit;
    end;
  end;
  SEQ_NO:=cdsGoodsSort.FieldByName('SEQ_NO').AsString;
  UNIT_ID:=cdsGoodsSort.FieldByName('SORT_ID').AsString;
  cdsGoodsSort.Next;
  SEQ_NO1:=cdsGoodsSort.FieldByName('SEQ_NO').AsString;
  UNIT_ID1:=cdsGoodsSort.FieldByName('SORT_ID').AsString;
  if cdsGoodsSort.Locate('SORT_ID',UNIT_ID1,[]) then
  begin
    cdsGoodsSort.Edit;
    cdsGoodsSort.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsGoodsSort.Post;
  end;
  if cdsGoodsSort.Locate('SORT_ID',UNIT_ID,[]) then
  begin
    cdsGoodsSort.Edit;
    cdsGoodsSort.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsGoodsSort.Post;
  end;
  cdsGoodsSort.indexfieldnames:='SEQ_NO';
end;

procedure TfrmGoodssort.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsGoodsSort.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmGoodssort.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  while cdsGoodsSort.RecNo<cdsGoodsSort.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmGoodssort.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and  (Key=VK_UP) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
    CtrlUpExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_DOWN) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
    CtrlDownExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_HOME) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
    CtrlHomeExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_END) then
  begin
    Key:=0;
    if dbState = dsBrowse then exit;
    CtrlEndExecute(nil);
  end;
end;

procedure TfrmGoodssort.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmGoodssort.ShowDialog(Owner: TForm;
  SORTTYPE: Integer): boolean;
begin

  with TfrmGoodssort.Create(Owner) do
    begin
      try
        Sort_Type := SORTTYPE;
        if not ShopGlobal.GetChkRight('32300001',1) then  Raise Exception.Create('你没有查看'+Caption+'的权限,请和管理员联系.');
        dbState := dsBrowse;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmGoodssort.SetSort_Type(const Value: integer);
var
  Tmp:TZQuery;
begin
  FSort_Type := Value;
  Tmp := Global.GetZQueryFromName('PUB_PARAMS');
  if Tmp.Locate('TYPE_CODE;CODE_ID',VarArrayOf(['SORT_TYPE',IntToStr(Sort_Type)]),[]) then
    begin
      Self.Caption :=  Tmp.Fields[1].AsString+'管理';
      RzPage.Pages[0].Caption :=  Tmp.Fields[1].AsString+'信息';
    end
  else
    Raise Exception.Create('无效的SORT_TYPE值！');

end;

procedure TfrmGoodssort.cdsGoodsSortBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled := True;
end;

procedure TfrmGoodssort.RefreshTable;
var Str_Table: String;
begin
  case Sort_Type of
    1: Str_Table := 'PUB_GOODSSORT';
    2: Str_Table := 'PUB_CATE_INFO';
    3: Str_Table := '';
    4: Str_Table := 'PUB_BRAND_INFO';
    5: Str_Table := 'PUB_IMPT_INFO';
    6: Str_Table := 'PUB_AREA_INFO';
    7: Str_Table := 'PUB_COLOR_GROUP';
    8: Str_Table := 'PUB_SIZE_GROUP';
  end;
  if Str_Table <> '' then
    Global.RefreshTable(Str_Table);
end;

procedure TfrmGoodssort.SetdbState(const Value: TDataSetState);
begin
  inherited;
  if dbState = dsBrowse then
    begin
      DBGridEh1.ReadOnly:=True;
      btnAppend.Enabled:=False;
      btnSave.Enabled:=False;
      btnDelete.Enabled:=False;
    end;
end;

function TfrmGoodssort.CheckCanExport: boolean;
begin
  Result := ShopGlobal.GetChkRight('32300001',6);
end;

end.
