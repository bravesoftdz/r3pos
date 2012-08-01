unit ufrmColorInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, RzButton, Grids,
  DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmColorInfo = class(TframeDialogForm)
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
    cdsCOLOR_INFO: TZQuery;
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cdsCOLOR_INFOBeforePost(DataSet: TDataSet);
    procedure cdsCOLOR_INFONewRecord(DataSet: TDataSet);
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
    procedure cdsCOLOR_INFOBeforeEdit(DataSet: TDataSet);
    procedure cdsCOLOR_INFOBeforeInsert(DataSet: TDataSet);
  private
    IsCompany:Boolean;
    IsOffline:Boolean;
    FFlag: integer;
    FMaxCount: Integer;
    procedure SetFlag(const Value: integer);
    procedure SetdbState(const Value: TDataSetState);
    procedure SetMaxCount(const Value: Integer);
  protected
    function CheckCanExport:boolean;
    { Private declarations }
  public
    procedure Open;
    procedure Save;
    property  Flag:integer read FFlag write SetFlag;  //1:其它窗体调用这个窗体
    class function AddDialog(Owner:TForm;var AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm):boolean;
    class function ShowDialogMax(Owner:TForm;vMaxCount: integer):boolean;
    property MaxCount: Integer read FMaxCount write SetMaxCount; //最大记录数据
  end;

implementation
uses  uGlobal,uFnUtil,uDsUtil, uShopGlobal;
{$R *.dfm}

procedure TfrmColorInfo.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if Length(Text) > 10 then
  begin
    cdsCOLOR_INFO.FieldByName('COLOR_NAME').AsString:='';
    Raise Exception.Create('颜色名称不能超出15个汉字或30个字符');
  end;
  cdsCOLOR_INFO.FieldByName('COLOR_SPELL').AsString:=Fnstring.GetWordSpell(Text,3);
  btnSave.Enabled:=True;  
end;

procedure TfrmColorInfo.btnAppendClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if cdsCOLOR_INFO.State in [dsEdit,dsInsert] then cdsCOLOR_INFO.Post;
  if not cdsCOLOR_INFO.IsEmpty then
  begin
    cdsCOLOR_INFO.Last;
    if (cdsCOLOR_INFO.FieldByName('COLOR_NAME').AsString='') and (cdsCOLOR_INFO.FieldByName('COLOR_SPELL').AsString='') and (cdsCOLOR_INFO.FieldByName('COLOR_ID').AsString='') then
      exit;
  end;
  cdsCOLOR_INFO.DisableControls;
  try
    cdsCOLOR_INFO.First;
    while not cdsCOLOR_INFO.Eof do
    begin
      if cdsCOLOR_INFO.FieldByName('COLOR_NAME').AsString='' then
        raise Exception.Create('颜色名称不能为空！');
      if cdsCOLOR_INFO.FieldByName('COLOR_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsCOLOR_INFO.Next;
    end;
  finally
    cdsCOLOR_INFO.EnableControls;
  end;
  cdsCOLOR_INFO.Append;
  if Visible then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.Col:=1;
    DBGridEh1.EditorMode := true;
  end;
end;

procedure TfrmColorInfo.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if MessageBox(Handle,pchar('确认要删除"'+cdsCOLOR_INFO.FieldbyName('COLOR_NAME').AsString+'"吗？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsCOLOR_INFO.Delete;
  if cdsCOLOR_INFO.State in [dsEdit,dsInsert] then cdsCOLOR_INFO.Post;
  //删除后重新排序
  cdsCOLOR_INFO.DisableControls;
  try
    cdsCOLOR_INFO.First;
    while not cdsCOLOR_INFO.Eof do
    begin
      cdsCOLOR_INFO.Edit;
      cdsCOLOR_INFO.FieldByName('SEQ_NO').AsString:=IntToStr(cdsCOLOR_INFO.RecNo);
      cdsCOLOR_INFO.Post;
      cdsCOLOR_INFO.Next;
    end;
  finally
    cdsCOLOR_INFO.EnableControls;
  end;
  btnSave.Enabled:=True;
  //删除记录后，如果没有记录了，删除按钮不能操作
  if cdsCOLOR_INFO.IsEmpty then
  begin
    btnDelete.Enabled:=False;
    Exit;
  end;
end;

procedure TfrmColorInfo.btnSaveClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if cdsCOLOR_INFO.State in [dsInsert,dsEdit] then cdsCOLOR_INFO.Post;
  if (cdsCOLOR_INFO.FieldbyName('COLOR_NAME').AsString='') and (cdsCOLOR_INFO.FieldbyName('COLOR_SPELL').AsString='') and (cdsCOLOR_INFO.FieldbyName('COLOR_ID').AsString='')then
  begin
    if not cdsCOLOR_INFO.IsEmpty then
      cdsCOLOR_INFO.Delete;
  end;
  cdsCOLOR_INFO.DisableControls;
  try
    cdsCOLOR_INFO.First;
    while not cdsCOLOR_INFO.Eof do
    begin
      if cdsCOLOR_INFO.FieldByName('COLOR_NAME').AsString='' then
        raise Exception.Create('颜色名称不能为空！');
      if cdsCOLOR_INFO.FieldByName('COLOR_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsCOLOR_INFO.Next;
    end;
  finally
    cdsCOLOR_INFO.EnableControls;
  end;  
  Save;
  if Flag=1 then
    ModalResult:=MROK;
  btnSave.Enabled:=False;
  if btnDelete.Enabled=False then
     btnDelete.Enabled:=True;
end;

procedure TfrmColorInfo.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
  ModalResult := mrOk;  
end;

procedure TfrmColorInfo.cdsCOLOR_INFOBeforePost(DataSet: TDataSet);
begin
  inherited;
//  if (DBGridEh1.Row=DBGridEh1.RowCount-1) and  (cdsCOLOR_INFO.FieldByName('CODE_ID').AsString='') then
//  begin
//    exit;
//  end;
 { if cdsCOLOR_INFO.FieldByName('CODE_NAME').AsString='' then raise Exception.Create('名称不能为空！');
  if cdsCOLOR_INFO.FieldByName('CODE_SPELL').AsString='' then raise Exception.Create('拼音码不能为空！');  }

end;

procedure TfrmColorInfo.cdsCOLOR_INFONewRecord(DataSet: TDataSet);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if (FMaxCount>0) and (cdsCOLOR_INFO.RecordCount>=FMaxCount) then Raise Exception.Create('  当前已达到限定的记录数据，不能增加...  '); 
  cdsCOLOR_INFO.FieldByName('SEQ_NO').AsString:=IntToStr(cdsCOLOR_INFO.RecordCount+1);
  cdsCOLOR_INFO.FieldByName('COLOR_ID').AsString := TSequence.NewId;
  cdsCOLOR_INFO.FieldByName('SORT_ID7S').AsString := '#';
  cdsCOLOR_INFO.FieldByName('SORT_ID7_NAMES').AsString := '#';
  cdsCOLOR_INFO.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
end;

procedure TfrmColorInfo.Open;
var Params: TftParamList;
begin
  try
    Params := TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsCOLOR_INFO,'TColorInfo',Params);
  finally
    Params.Free;
  end;
  if cdsCOLOR_INFO.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmColorInfo.Save;
var c:integer;
    i:integer;
begin
  i:=cdsCOLOR_INFO.RecNo;
  if cdsCOLOR_INFO.IsEmpty then
    i:=0;
  cdsCOLOR_INFO.DisableControls;
  try
    c := 0;
    cdsCOLOR_INFO.First;
    while not cdsCOLOR_INFO.Eof do
      begin
        inc(c);
        if c = cdsCOLOR_INFO.FieldByName('SEQ_NO').AsInteger THEN
          begin
            cdsCOLOR_INFO.Next;
            Continue;
          end;
        cdsCOLOR_INFO.Edit;
        cdsCOLOR_INFO.FieldByName('SEQ_NO').AsInteger := c;
        cdsCOLOR_INFO.Post;
        cdsCOLOR_INFO.Next;
      end;
  finally
    cdsCOLOR_INFO.EnableControls;
  end;
  try
    Factor.UpdateBatch(cdsCOLOR_INFO,'TColorInfo');
  except
    //cdsCOLOR_INFO.Close;
    //Open;
    if not cdsCOLOR_INFO.IsEmpty then
    begin
      if i=0 then i:=1;
      cdsCOLOR_INFO.RecNo:=i;
    end;
    if cdsCOLOR_INFO.IsEmpty then
      btnDelete.Enabled:=False;
    btnSave.Enabled:=False;
    raise;    
  end;
  if not cdsCOLOR_INFO.IsEmpty then
  begin
    if i=0 then i:=1;
    cdsCOLOR_INFO.RecNo:=i;
  end;
  if cdsCOLOR_INFO.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmColorInfo.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmColorInfo.FormClose(Sender: TObject;
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

procedure TfrmColorInfo.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmColorInfo.AddDialog(Owner: TForm;
  var AObj: TRecord_): boolean;
begin
   with TfrmColorInfo.Create(Owner) do
    begin
      try
        Flag:=1;
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
          AObj.ReadFromDataSet(cdsCOLOR_INFO);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

class function TfrmColorInfo.ShowDialogMax(Owner: TForm; vMaxCount: integer): boolean;
begin
  with TfrmColorInfo.Create(Owner) do
  begin
    try
      MaxCount := vMaxCount;
      Open;
      btnSave.Enabled:=False;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmColorInfo.SetFlag(const Value: integer);
begin
  FFlag := Value;
end;

procedure TfrmColorInfo.FormCreate(Sender: TObject);
begin
  FMaxCount:=0;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then
    begin
      IsOffline := True;
      btnAppend.Enabled:=False;
      btnSave.Enabled:=False;
      btnDelete.Enabled:=False;
    end;
end;

procedure TfrmColorInfo.CtrlUpExecute(Sender: TObject);
var SEQ_NO,CODE_ID,SEQ_NO1,CODE_ID1:string;
begin
  inherited;
  if cdsCOLOR_INFO.IsEmpty then exit;
  if cdsCOLOR_INFO.RecordCount=1 then exit;
  if cdsCOLOR_INFO.RecNo=1 then exit;
  if cdsCOLOR_INFO.State in [dsEdit,dsInsert] then cdsCOLOR_INFO.Post;
  if cdsCOLOR_INFO.RecNo=cdsCOLOR_INFO.RecordCount then
  begin
    if cdsCOLOR_INFO.FieldByName('COLOR_NAME').AsString='' then
    begin
      cdsCOLOR_INFO.Delete;
      exit;
    end;
    if cdsCOLOR_INFO.FieldByName('COLOR_SPELL').AsString='' then
    begin
      cdsCOLOR_INFO.Delete;
      exit;
    end;
  end;
  SEQ_NO:=cdsCOLOR_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID:=cdsCOLOR_INFO.FieldByName('COLOR_ID').AsString;
  cdsCOLOR_INFO.Prior;
  SEQ_NO1:=cdsCOLOR_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID1:=cdsCOLOR_INFO.FieldByName('COLOR_ID').AsString;
  if cdsCOLOR_INFO.Locate('COLOR_ID',CODE_ID1,[]) then
  begin
    cdsCOLOR_INFO.Edit;
    cdsCOLOR_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsCOLOR_INFO.Post;
  end;
  if cdsCOLOR_INFO.Locate('CODE_ID',CODE_ID,[]) then
  begin
    cdsCOLOR_INFO.Edit;
    cdsCOLOR_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsCOLOR_INFO.Post;
  end;
  cdsCOLOR_INFO.indexfieldnames:='SEQ_NO';
end;

procedure TfrmColorInfo.CtrlDownExecute(Sender: TObject);
var SEQ_NO,CODE_ID,SEQ_NO1,CODE_ID1:string;
begin
  inherited;
  if cdsCOLOR_INFO.IsEmpty then exit;
  if cdsCOLOR_INFO.RecordCount=1 then exit;
  if cdsCOLOR_INFO.RecNo=cdsCOLOR_INFO.RecordCount then exit;
  if cdsCOLOR_INFO.State in [dsEdit,dsInsert] then cdsCOLOR_INFO.Post;
  SEQ_NO:=cdsCOLOR_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID:=cdsCOLOR_INFO.FieldByName('COLOR_ID').AsString;
  cdsCOLOR_INFO.Next;
  if cdsCOLOR_INFO.RecNo=cdsCOLOR_INFO.RecordCount then
  begin
    if cdsCOLOR_INFO.FieldByName('COLOR_NAME').AsString='' then
    begin
      cdsCOLOR_INFO.Delete;
      exit;
    end;
    if cdsCOLOR_INFO.FieldByName('COLOR_SPELL').AsString='' then
    begin
      cdsCOLOR_INFO.Delete;
      exit;
    end;
  end;
  SEQ_NO1:=cdsCOLOR_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID1:=cdsCOLOR_INFO.FieldByName('COLOR_ID').AsString;
  if cdsCOLOR_INFO.Locate('COLOR_ID',CODE_ID1,[]) then
  begin
    cdsCOLOR_INFO.Edit;
    cdsCOLOR_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsCOLOR_INFO.Post;
  end;
  if cdsCOLOR_INFO.Locate('COLOR_ID',CODE_ID,[]) then
  begin
    cdsCOLOR_INFO.Edit;
    cdsCOLOR_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsCOLOR_INFO.Post;
  end;
  cdsCOLOR_INFO.indexfieldnames:='SEQ_NO';

end;

procedure TfrmColorInfo.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsCOLOR_INFO.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmColorInfo.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  while cdsCOLOR_INFO.RecNo<cdsCOLOR_INFO.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmColorInfo.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
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

class function TfrmColorInfo.ShowDialog(Owner: TForm): boolean;
begin
  with TfrmColorInfo.Create(Owner) do
    begin
      try
        Open;
        btnSave.Enabled:=False;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmColorInfo.FormActivate(Sender: TObject);
begin
  inherited;
  if cdsCOLOR_INFO.State <> dsBrowse then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.Col:=1;
    DBGridEh1.EditorMode := true;
  end;

end;

procedure TfrmColorInfo.cdsCOLOR_INFOBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;

end;

procedure TfrmColorInfo.cdsCOLOR_INFOBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
  if cdsCOLOR_INFO.RecordCount <= 0 then
    btnDelete.Enabled := False
  else
    btnDelete.Enabled := True;
end;

procedure TfrmColorInfo.SetdbState(const Value: TDataSetState);
begin
  if dbState = dsBrowse then
    begin
      DBGridEh1.ReadOnly:=True;
      btnAppend.Enabled:=False;
      btnSave.Enabled:=False;
      btnDelete.Enabled:=False;
    end;
end;

function TfrmColorInfo.CheckCanExport: boolean;
begin
  Result := True;
end;

procedure TfrmColorInfo.SetMaxCount(const Value: Integer);
begin
  FMaxCount := Value;
end;


end.
