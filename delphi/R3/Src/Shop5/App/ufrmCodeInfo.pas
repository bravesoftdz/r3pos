unit ufrmCodeInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, RzButton, Grids,
  DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmCodeInfo = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsClientSort: TDataSource;
    btnAppend: TRzBitBtn;
    btnDelete: TRzBitBtn;
    PopupMenu1: TPopupMenu;
    CtrlUp: TAction;
    CtrlDown: TAction;
    CtrlHome: TAction;
    CtrlEnd: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    cdsCODE_INFO: TZQuery;
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cdsCODE_INFOBeforePost(DataSet: TDataSet);
    procedure cdsCODE_INFONewRecord(DataSet: TDataSet);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure CtrlUpExecute(Sender: TObject);
    procedure CtrlDownExecute(Sender: TObject);
    procedure CtrlHomeExecute(Sender: TObject);
    procedure CtrlEndExecute(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cdsCODE_INFOBeforeEdit(DataSet: TDataSet);
    procedure cdsCODE_INFOBeforeInsert(DataSet: TDataSet);
  private
    IsCompany:Boolean;
    IsOffline:Boolean;
    FFlag: integer;
    FCode_type: Integer;
    procedure SetFlag(const Value: integer);
    procedure SetCode_type(const Value: Integer);
    procedure SetdbState(const Value: TDataSetState);
  protected
    function CheckCanExport:boolean;    
    { Private declarations }
  public
    procedure RefreshTable;
    procedure Open;
    procedure Save;
    property  Flag:integer read FFlag write SetFlag;  //1:其它窗体调用这个窗体
    class function AddDialog(Owner:TForm;var AObj:TRecord_;CODETYPE:Integer=5):boolean;
    class function ShowDialog(Owner:TForm;CODETYPE:Integer=5):boolean;
    property Code_type: Integer read FCode_type write SetCode_type;
    { Public declarations }
  end;

implementation
uses  uGlobal,uFnUtil,uDsUtil, uShopGlobal;
{$R *.dfm}

procedure TfrmCodeInfo.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  cdsCODE_INFO.FieldByName('CODE_SPELL').AsString:=Fnstring.GetWordSpell(Text,3);
  btnSave.Enabled:=True;  
end;

procedure TfrmCodeInfo.btnAppendClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if cdsCODE_INFO.State in [dsEdit,dsInsert] then cdsCODE_INFO.Post;
  if not cdsCODE_INFO.IsEmpty then
  begin
    cdsCODE_INFO.Last;
    if (cdsCODE_INFO.FieldByName('CODE_NAME').AsString='') and (cdsCODE_INFO.FieldByName('CODE_SPELL').AsString='') and (cdsCODE_INFO.FieldByName('CODE_ID').AsString='') then
      exit;
  end;
  cdsCODE_INFO.DisableControls;
  try
    cdsCODE_INFO.First;
    while not cdsCODE_INFO.Eof do
    begin
      if cdsCODE_INFO.FieldByName('CODE_NAME').AsString='' then
        raise Exception.Create('名称不能为空！');
      if cdsCODE_INFO.FieldByName('CODE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsCODE_INFO.Next;
    end;
  finally
    cdsCODE_INFO.EnableControls;
  end;
  cdsCODE_INFO.Append;
  if Visible then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.Col:=1;
    DBGridEh1.EditorMode := true;
  end;
end;

procedure TfrmCodeInfo.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if MessageBox(Handle,pchar('确认要删除"'+cdsCODE_INFO.FieldbyName('CODE_NAME').AsString+'"吗？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsCODE_INFO.Delete;
  if cdsCODE_INFO.State in [dsEdit,dsInsert] then cdsCODE_INFO.Post;
  //删除后重新排序
  cdsCODE_INFO.DisableControls;
  try
    cdsCODE_INFO.First;
    while not cdsCODE_INFO.Eof do
    begin
      cdsCODE_INFO.Edit;
      cdsCODE_INFO.FieldByName('SEQ_NO').AsString:=IntToStr(cdsCODE_INFO.RecNo);
      cdsCODE_INFO.Post;
      cdsCODE_INFO.Next;
    end;
  finally
    cdsCODE_INFO.EnableControls;
  end;
  btnSave.Enabled:=True;
  //删除记录后，如果没有记录了，删除按钮不能操作
  if cdsCODE_INFO.IsEmpty then
  begin
    btnDelete.Enabled:=False;
    Exit;
  end;
end;

procedure TfrmCodeInfo.btnSaveClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if cdsCODE_INFO.State in [dsInsert,dsEdit] then cdsCODE_INFO.Post;
  if (cdsCODE_INFO.FieldbyName('CODE_NAME').AsString='') and (cdsCODE_INFO.FieldbyName('CODE_SPELL').AsString='') and (cdsCODE_INFO.FieldbyName('CODE_ID').AsString='')then
  begin
    if not cdsCODE_INFO.IsEmpty then
      cdsCODE_INFO.Delete;
  end;
  cdsCODE_INFO.DisableControls;
  try
    cdsCODE_INFO.First;
    while not cdsCODE_INFO.Eof do
    begin
      if cdsCODE_INFO.FieldByName('CODE_NAME').AsString='' then
        raise Exception.Create('名称不能为空！');
      if cdsCODE_INFO.FieldByName('CODE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsCODE_INFO.Next;
    end;
  finally
    cdsCODE_INFO.EnableControls;
  end;  
  Save;
  if Flag=1 then
    ModalResult:=MROK;
  btnSave.Enabled:=False;
  if btnDelete.Enabled=False then
     btnDelete.Enabled:=True;
end;

procedure TfrmCodeInfo.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
  ModalResult := mrOk;  
end;

procedure TfrmCodeInfo.cdsCODE_INFOBeforePost(DataSet: TDataSet);
begin
  inherited;
//  if (DBGridEh1.Row=DBGridEh1.RowCount-1) and  (cdsCODE_INFO.FieldByName('CODE_ID').AsString='') then
//  begin
//    exit;
//  end;
 { if cdsCODE_INFO.FieldByName('CODE_NAME').AsString='' then raise Exception.Create('名称不能为空！');
  if cdsCODE_INFO.FieldByName('CODE_SPELL').AsString='' then raise Exception.Create('拼音码不能为空！');  }

end;

procedure TfrmCodeInfo.cdsCODE_INFONewRecord(DataSet: TDataSet);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  cdsCODE_INFO.FieldByName('SEQ_NO').AsString:=IntToStr(cdsCODE_INFO.RecordCount+1);
  cdsCODE_INFO.FieldByName('CODE_ID').AsString := TSequence.NewId;
  cdsCODE_INFO.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsCODE_INFO.FieldByName('CODE_TYPE').AsInteger := Code_type;
end;

procedure TfrmCodeInfo.Open;
var Params: TftParamList;
begin
  try
    Params := TftParamList.Create(nil);
    Params.ParamByName('CODE_TYPE').AsInteger := Code_type;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsCODE_INFO,'TCodeInfo',Params);
  finally
    Params.Free;
  end;
  if cdsCODE_INFO.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmCodeInfo.Save;
var c:integer;
    i:integer;
begin
  i:=cdsCODE_INFO.RecNo;
  if cdsCODE_INFO.IsEmpty then
    i:=0;
  cdsCODE_INFO.DisableControls;
  try
    c := 0;
    cdsCODE_INFO.First;
    while not cdsCODE_INFO.Eof do
      begin
        inc(c);
        if c = cdsCODE_INFO.FieldByName('SEQ_NO').AsInteger THEN
          begin
            cdsCODE_INFO.Next;
            Continue;
          end;
        cdsCODE_INFO.Edit;
        cdsCODE_INFO.FieldByName('SEQ_NO').AsInteger := c;
        cdsCODE_INFO.Post;
        cdsCODE_INFO.Next;
      end;
  finally
    cdsCODE_INFO.EnableControls;
  end;
  try
    Factor.UpdateBatch(cdsCODE_INFO,'TCodeInfo');
  except
    //cdsCODE_INFO.Close;
    //Open;
    if not cdsCODE_INFO.IsEmpty then
    begin
      if i=0 then i:=1;
      cdsCODE_INFO.RecNo:=i;
    end;
    if cdsCODE_INFO.IsEmpty then
      btnDelete.Enabled:=False;
    btnSave.Enabled:=False;
    raise;    
  end;
  RefreshTable;
  if not cdsCODE_INFO.IsEmpty then
  begin
    if i=0 then i:=1;
    cdsCODE_INFO.RecNo:=i;
  end;
  if cdsCODE_INFO.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmCodeInfo.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmCodeInfo.FormClose(Sender: TObject;
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

procedure TfrmCodeInfo.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmCodeInfo.AddDialog(Owner: TForm;
  var AObj: TRecord_;CODETYPE:Integer): boolean;
begin
   with TfrmCodeInfo.Create(Owner) do
    begin
      try
        Flag:=1;
        Code_type := CODETYPE;
        Open;
        btnSave.Enabled:=False;
        //其它窗体调用此窗体，直接新增记录
        if Flag=1 then
        begin
          btnAppendClick(nil);
        end;
        ShowModal;
        if ModalResult=MROK then
        begin
          AObj.ReadFromDataSet(cdsCODE_INFO);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

procedure TfrmCodeInfo.SetFlag(const Value: integer);
begin
  FFlag := Value;
end;

procedure TfrmCodeInfo.FormCreate(Sender: TObject);
begin
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then
    begin
      IsOffline := True;
      btnAppend.Enabled:=False;
      btnSave.Enabled:=False;
      btnDelete.Enabled:=False;
    end;
end;

procedure TfrmCodeInfo.CtrlUpExecute(Sender: TObject);
var SEQ_NO,CODE_ID,SEQ_NO1,CODE_ID1:string;
begin
  inherited;
  if cdsCODE_INFO.IsEmpty then exit;
  if cdsCODE_INFO.RecordCount=1 then exit;
  if cdsCODE_INFO.RecNo=1 then exit;
  if cdsCODE_INFO.State in [dsEdit,dsInsert] then cdsCODE_INFO.Post;
  if cdsCODE_INFO.RecNo=cdsCODE_INFO.RecordCount then
  begin
    if cdsCODE_INFO.FieldByName('CODE_NAME').AsString='' then
    begin
      cdsCODE_INFO.Delete;
      exit;
    end;
    if cdsCODE_INFO.FieldByName('CODE_SPELL').AsString='' then
    begin
      cdsCODE_INFO.Delete;
      exit;
    end;
  end;
  SEQ_NO:=cdsCODE_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID:=cdsCODE_INFO.FieldByName('CODE_ID').AsString;
  cdsCODE_INFO.Prior;
  SEQ_NO1:=cdsCODE_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID1:=cdsCODE_INFO.FieldByName('CODE_ID').AsString;
  if cdsCODE_INFO.Locate('CODE_ID',CODE_ID1,[]) then
  begin
    cdsCODE_INFO.Edit;
    cdsCODE_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsCODE_INFO.Post;
  end;
  if cdsCODE_INFO.Locate('CODE_ID',CODE_ID,[]) then
  begin
    cdsCODE_INFO.Edit;
    cdsCODE_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsCODE_INFO.Post;
  end;
  cdsCODE_INFO.indexfieldnames:='SEQ_NO';
end;

procedure TfrmCodeInfo.CtrlDownExecute(Sender: TObject);
var SEQ_NO,CODE_ID,SEQ_NO1,CODE_ID1:string;
begin
  inherited;
  if cdsCODE_INFO.IsEmpty then exit;
  if cdsCODE_INFO.RecordCount=1 then exit;
  if cdsCODE_INFO.RecNo=cdsCODE_INFO.RecordCount then exit;
  if cdsCODE_INFO.State in [dsEdit,dsInsert] then cdsCODE_INFO.Post;
  SEQ_NO:=cdsCODE_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID:=cdsCODE_INFO.FieldByName('CODE_ID').AsString;
  cdsCODE_INFO.Next;
  if cdsCODE_INFO.RecNo=cdsCODE_INFO.RecordCount then
  begin
    if cdsCODE_INFO.FieldByName('CODE_NAME').AsString='' then
    begin
      cdsCODE_INFO.Delete;
      exit;
    end;
    if cdsCODE_INFO.FieldByName('CODE_SPELL').AsString='' then
    begin
      cdsCODE_INFO.Delete;
      exit;
    end;
  end;
  SEQ_NO1:=cdsCODE_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID1:=cdsCODE_INFO.FieldByName('CODE_ID').AsString;
  if cdsCODE_INFO.Locate('CODE_ID',CODE_ID1,[]) then
  begin
    cdsCODE_INFO.Edit;
    cdsCODE_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsCODE_INFO.Post;
  end;
  if cdsCODE_INFO.Locate('CODE_ID',CODE_ID,[]) then
  begin
    cdsCODE_INFO.Edit;
    cdsCODE_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsCODE_INFO.Post;
  end;
  cdsCODE_INFO.indexfieldnames:='SEQ_NO';

end;

procedure TfrmCodeInfo.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsCODE_INFO.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmCodeInfo.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  while cdsCODE_INFO.RecNo<cdsCODE_INFO.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmCodeInfo.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
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

class function TfrmCodeInfo.ShowDialog(Owner: TForm;
  CODETYPE: Integer): boolean;
begin
  with TfrmCodeInfo.Create(Owner) do
    begin
      try
        Code_type := CODETYPE;
        Open;
        btnSave.Enabled:=False;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmCodeInfo.SetCode_type(const Value: Integer);
var Tmp:TZQuery;
begin
  FCode_type := Value;
  Tmp := Global.GetZQueryFromName('PUB_PARAMS');
  if Tmp.Locate('TYPE_CODE;CODE_ID',VarArrayOf(['CODE_TYPE',IntToStr(Code_type)]),[]) then
    begin
      Self.Caption := Tmp.Fields[1].AsString+'管理';
      RzPage.Pages[0].Caption := Tmp.Fields[1].AsString + '信息';
    end
  else
    Raise Exception.Create('无效的 CODE_TYPE 值！');
end;

procedure TfrmCodeInfo.FormActivate(Sender: TObject);
begin
  inherited;
  if cdsCODE_INFO.State <> dsBrowse then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.Col:=1;
    DBGridEh1.EditorMode := true;
  end;

end;

procedure TfrmCodeInfo.cdsCODE_INFOBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;

end;

procedure TfrmCodeInfo.cdsCODE_INFOBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
  if cdsCODE_INFO.RecordCount <= 0 then
    btnDelete.Enabled := False
  else
    btnDelete.Enabled := True;
end;

procedure TfrmCodeInfo.RefreshTable;
var Str_Table: String;
begin
  case Code_type of
    1: Str_Table := 'PUB_PAYMENT';
    2: Str_Table := 'PUB_SALE_STYLE';
    3: Str_Table := 'ACC_ITEM_INFO';
    5: Str_Table := 'PUB_CLIENTSORT';
    6: Str_Table := 'PUB_SETTLE_CODE';
    7: Str_Table := 'PUB_BANK_INFO';
    8: Str_Table := 'PUB_REGION_INFO';
    9: Str_Table := 'PUB_SUPPERSORT';
    11: Str_Table := 'PUB_IDNTYPE_INFO';
    12: Str_Table := 'PUB_SHOP_TYPE';
    13: Str_Table := 'PUB_MONTH_PAY_INFO';
    14: Str_Table := 'PUB_DEGREES_INFO';
    15: Str_Table := 'PUB_OCCUPATION_INFO';
    16: Str_Table := 'PUB_TREND_INFO';
  end;
  if Str_Table<>'' then Global.RefreshTable(Str_Table);
end;

procedure TfrmCodeInfo.SetdbState(const Value: TDataSetState);
begin
  if dbState = dsBrowse then
    begin
      DBGridEh1.ReadOnly:=True;
      btnAppend.Enabled:=False;
      btnSave.Enabled:=False;
      btnDelete.Enabled:=False;
    end;
end;

function TfrmCodeInfo.CheckCanExport: boolean;
begin
  Result := True;
end;

end.
