unit ufrmSizeInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, RzButton, Grids,
  DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmSizeInfo = class(TframeDialogForm)
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
    cdsSIZE_INFO: TZQuery;
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cdsSIZE_INFOBeforePost(DataSet: TDataSet);
    procedure cdsSIZE_INFONewRecord(DataSet: TDataSet);
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
    procedure cdsSIZE_INFOBeforeEdit(DataSet: TDataSet);
    procedure cdsSIZE_INFOBeforeInsert(DataSet: TDataSet);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
  private
    IsCompany:Boolean;
    IsOffline:Boolean;
    FFlag: integer;
    FMaxCount: Integer;
    procedure SetFlag(const Value: integer);
    procedure SetdbState(const Value: TDataSetState);
    procedure SetMaxCount(const Value: Integer);
    procedure JudgeBarcodeFlag(BarcodeFlag:String);
    function GetBarcodeFlag:String;    
    procedure FocusNextColumn;
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

procedure TfrmSizeInfo.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if Length(Text) > 10 then
  begin
    cdsSIZE_INFO.FieldByName('SIZE_NAME').AsString:='';
    Raise Exception.Create('尺码名称不能超出15个汉字或30个字符');
  end;
  cdsSIZE_INFO.FieldByName('SIZE_SPELL').AsString:=Fnstring.GetWordSpell(Text,3);
  btnSave.Enabled:=True;  
end;

procedure TfrmSizeInfo.btnAppendClick(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002490',2) then Raise Exception.Create('你没有新增尺码的权限,请和管理员联系.');
  //if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if cdsSIZE_INFO.State in [dsEdit,dsInsert] then cdsSIZE_INFO.Post;
  if not cdsSIZE_INFO.IsEmpty then
  begin
    cdsSIZE_INFO.Last;
    if (cdsSIZE_INFO.FieldByName('SIZE_NAME').AsString='') and (cdsSIZE_INFO.FieldByName('SIZE_SPELL').AsString='') and (cdsSIZE_INFO.FieldByName('SIZE_ID').AsString='') then
      exit;
  end;
  cdsSIZE_INFO.DisableControls;
  try
    cdsSIZE_INFO.First;
    while not cdsSIZE_INFO.Eof do
    begin
      if cdsSIZE_INFO.FieldByName('SIZE_NAME').AsString='' then
        raise Exception.Create('尺码名称不能为空！');
      if cdsSIZE_INFO.FieldByName('SIZE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsSIZE_INFO.Next;
    end;
  finally
    cdsSIZE_INFO.EnableControls;
  end;
  cdsSIZE_INFO.Append;
  if Visible then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.Col:=1;
    DBGridEh1.EditorMode := true;
  end;
end;

procedure TfrmSizeInfo.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if not ShopGlobal.GetChkRight('100002490',4) then Raise Exception.Create('你没有删除尺码的权限,请和管理员联系.');
  //if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if MessageBox(Handle,pchar('确认要删除"'+cdsSIZE_INFO.FieldbyName('SIZE_NAME').AsString+'"吗？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsSIZE_INFO.Delete;
  if cdsSIZE_INFO.State in [dsEdit,dsInsert] then cdsSIZE_INFO.Post;
  //删除后重新排序
  cdsSIZE_INFO.DisableControls;
  try
    cdsSIZE_INFO.First;
    while not cdsSIZE_INFO.Eof do
    begin
      cdsSIZE_INFO.Edit;
      cdsSIZE_INFO.FieldByName('SEQ_NO').AsString:=IntToStr(cdsSIZE_INFO.RecNo);
      cdsSIZE_INFO.Post;
      cdsSIZE_INFO.Next;
    end;
  finally
    cdsSIZE_INFO.EnableControls;
  end;
  btnSave.Enabled:=True;
  //删除记录后，如果没有记录了，删除按钮不能操作
  if cdsSIZE_INFO.IsEmpty then
  begin
    btnDelete.Enabled:=False;
    Exit;
  end;
end;

procedure TfrmSizeInfo.btnSaveClick(Sender: TObject);
begin
  inherited;
  //if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if cdsSIZE_INFO.State in [dsInsert,dsEdit] then cdsSIZE_INFO.Post;
  if (cdsSIZE_INFO.FieldbyName('SIZE_NAME').AsString='') and (cdsSIZE_INFO.FieldbyName('SIZE_SPELL').AsString='') and (cdsSIZE_INFO.FieldbyName('SIZE_ID').AsString='')then
  begin
    if not cdsSIZE_INFO.IsEmpty then
      cdsSIZE_INFO.Delete;
  end;
  cdsSIZE_INFO.DisableControls;
  try
    cdsSIZE_INFO.First;
    while not cdsSIZE_INFO.Eof do
    begin
      if cdsSIZE_INFO.FieldByName('SIZE_NAME').AsString='' then
        raise Exception.Create('尺码名称不能为空！');
      if cdsSIZE_INFO.FieldByName('SIZE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsSIZE_INFO.Next;
    end;
  finally
    cdsSIZE_INFO.EnableControls;
  end;  
  Save;
  Global.RefreshTable('PUB_SIZE_INFO');
  if Flag=1 then
    ModalResult:=MROK;
  btnSave.Enabled:=False;
  if btnDelete.Enabled=False then
     btnDelete.Enabled:=True;
end;

procedure TfrmSizeInfo.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
  ModalResult := mrIgnore;  
end;

procedure TfrmSizeInfo.cdsSIZE_INFOBeforePost(DataSet: TDataSet);
begin
  inherited;
//  if (DBGridEh1.Row=DBGridEh1.RowCount-1) and  (cdsSIZE_INFO.FieldByName('CODE_ID').AsString='') then
//  begin
//    exit;
//  end;
 { if cdsSIZE_INFO.FieldByName('CODE_NAME').AsString='' then raise Exception.Create('名称不能为空！');
  if cdsSIZE_INFO.FieldByName('CODE_SPELL').AsString='' then raise Exception.Create('拼音码不能为空！');  }

end;

procedure TfrmSizeInfo.cdsSIZE_INFONewRecord(DataSet: TDataSet);
begin
  inherited;
  //if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if (FMaxCount>0) and (cdsSIZE_INFO.RecordCount>=FMaxCount) then Raise Exception.Create('  当前已达到限定的记录数据，不能增加...  '); 
  cdsSIZE_INFO.FieldByName('SEQ_NO').AsString:=IntToStr(cdsSIZE_INFO.RecordCount+1);
  cdsSIZE_INFO.FieldByName('SIZE_ID').AsString := TSequence.NewId;
  cdsSIZE_INFO.FieldByName('SORT_ID8S').AsString := '#';
  cdsSIZE_INFO.FieldByName('SORT_ID8_NAMES').AsString := '#';
  cdsSIZE_INFO.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
end;

procedure TfrmSizeInfo.Open;
var Params: TftParamList;
begin
  try
    Params := TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsSIZE_INFO,'TSizeInfo',Params);
  finally
    Params.Free;
  end;
  if cdsSIZE_INFO.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmSizeInfo.Save;
var c:integer;
    i:integer;
begin
  i:=cdsSIZE_INFO.RecNo;
  if cdsSIZE_INFO.IsEmpty then
    i:=0;
  cdsSIZE_INFO.DisableControls;
  try
    c := 0;
    cdsSIZE_INFO.First;
    while not cdsSIZE_INFO.Eof do
      begin
        inc(c);
        if c = cdsSIZE_INFO.FieldByName('SEQ_NO').AsInteger THEN
          begin
            cdsSIZE_INFO.Next;
            Continue;
          end;
        cdsSIZE_INFO.Edit;
        cdsSIZE_INFO.FieldByName('SEQ_NO').AsInteger := c;
        cdsSIZE_INFO.Post;
        cdsSIZE_INFO.Next;
      end;
  finally
    cdsSIZE_INFO.EnableControls;
  end;
  try
    Factor.UpdateBatch(cdsSIZE_INFO,'TSizeInfo');
  except
    //cdsSIZE_INFO.Close;
    //Open;
    if not cdsSIZE_INFO.IsEmpty then
    begin
      if i=0 then i:=1;
      cdsSIZE_INFO.RecNo:=i;
    end;
    if cdsSIZE_INFO.IsEmpty then
      btnDelete.Enabled:=False;
    btnSave.Enabled:=False;
    raise;    
  end;
  if not cdsSIZE_INFO.IsEmpty then
  begin
    if i=0 then i:=1;
    cdsSIZE_INFO.RecNo:=i;
  end;
  if cdsSIZE_INFO.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmSizeInfo.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmSizeInfo.FormClose(Sender: TObject;
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

procedure TfrmSizeInfo.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmSizeInfo.AddDialog(Owner: TForm;
  var AObj: TRecord_): boolean;
begin
   with TfrmSizeInfo.Create(Owner) do
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
          AObj.ReadFromDataSet(cdsSIZE_INFO);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

class function TfrmSizeInfo.ShowDialogMax(Owner: TForm; vMaxCount: Integer): boolean;
begin
  with TfrmSizeInfo.Create(Owner) do
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

procedure TfrmSizeInfo.SetFlag(const Value: integer);
begin
  FFlag := Value;
end;

procedure TfrmSizeInfo.FormCreate(Sender: TObject);
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

procedure TfrmSizeInfo.CtrlUpExecute(Sender: TObject);
var SEQ_NO,CODE_ID,SEQ_NO1,CODE_ID1:string;
begin
  inherited;
  if cdsSIZE_INFO.IsEmpty then exit;
  if cdsSIZE_INFO.RecordCount=1 then exit;
  if cdsSIZE_INFO.RecNo=1 then exit;
  if cdsSIZE_INFO.State in [dsEdit,dsInsert] then cdsSIZE_INFO.Post;
  if cdsSIZE_INFO.RecNo=cdsSIZE_INFO.RecordCount then
  begin
    if cdsSIZE_INFO.FieldByName('SIZE_NAME').AsString='' then
    begin
      cdsSIZE_INFO.Delete;
      exit;
    end;
    if cdsSIZE_INFO.FieldByName('SIZE_SPELL').AsString='' then
    begin
      cdsSIZE_INFO.Delete;
      exit;
    end;
  end;
  SEQ_NO:=cdsSIZE_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID:=cdsSIZE_INFO.FieldByName('SIZE_ID').AsString;
  cdsSIZE_INFO.Prior;
  SEQ_NO1:=cdsSIZE_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID1:=cdsSIZE_INFO.FieldByName('SIZE_ID').AsString;
  if cdsSIZE_INFO.Locate('SIZE_ID',CODE_ID1,[]) then
  begin
    cdsSIZE_INFO.Edit;
    cdsSIZE_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsSIZE_INFO.Post;
  end;
  if cdsSIZE_INFO.Locate('SIZE_ID',CODE_ID,[]) then
  begin
    cdsSIZE_INFO.Edit;
    cdsSIZE_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsSIZE_INFO.Post;
  end;
  cdsSIZE_INFO.indexfieldnames:='SEQ_NO';
end;

procedure TfrmSizeInfo.CtrlDownExecute(Sender: TObject);
var SEQ_NO,CODE_ID,SEQ_NO1,CODE_ID1:string;
begin
  inherited;
  if cdsSIZE_INFO.IsEmpty then exit;
  if cdsSIZE_INFO.RecordCount=1 then exit;
  if cdsSIZE_INFO.RecNo=cdsSIZE_INFO.RecordCount then exit;
  if cdsSIZE_INFO.State in [dsEdit,dsInsert] then cdsSIZE_INFO.Post;
  SEQ_NO:=cdsSIZE_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID:=cdsSIZE_INFO.FieldByName('SIZE_ID').AsString;
  cdsSIZE_INFO.Next;
  if cdsSIZE_INFO.RecNo=cdsSIZE_INFO.RecordCount then
  begin
    if cdsSIZE_INFO.FieldByName('SIZE_NAME').AsString='' then
    begin
      cdsSIZE_INFO.Delete;
      exit;
    end;
    if cdsSIZE_INFO.FieldByName('SIZE_SPELL').AsString='' then
    begin
      cdsSIZE_INFO.Delete;
      exit;
    end;
  end;
  SEQ_NO1:=cdsSIZE_INFO.FieldByName('SEQ_NO').AsString;
  CODE_ID1:=cdsSIZE_INFO.FieldByName('SIZE_ID').AsString;
  if cdsSIZE_INFO.Locate('SIZE_ID',CODE_ID1,[]) then
  begin
    cdsSIZE_INFO.Edit;
    cdsSIZE_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsSIZE_INFO.Post;
  end;
  if cdsSIZE_INFO.Locate('SIZE_ID',CODE_ID,[]) then
  begin
    cdsSIZE_INFO.Edit;
    cdsSIZE_INFO.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsSIZE_INFO.Post;
  end;
  cdsSIZE_INFO.indexfieldnames:='SEQ_NO';

end;

procedure TfrmSizeInfo.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsSIZE_INFO.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmSizeInfo.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  while cdsSIZE_INFO.RecNo<cdsSIZE_INFO.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmSizeInfo.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
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

class function TfrmSizeInfo.ShowDialog(Owner: TForm): boolean;
begin
  with TfrmSizeInfo.Create(Owner) do
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

procedure TfrmSizeInfo.FormActivate(Sender: TObject);
begin
  inherited;
  if cdsSIZE_INFO.State <> dsBrowse then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.Col:=1;
    DBGridEh1.EditorMode := true;
  end;

end;

procedure TfrmSizeInfo.cdsSIZE_INFOBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;

end;

procedure TfrmSizeInfo.cdsSIZE_INFOBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
  if cdsSIZE_INFO.RecordCount <= 0 then
    btnDelete.Enabled := False
  else
    btnDelete.Enabled := True;
end;

procedure TfrmSizeInfo.SetdbState(const Value: TDataSetState);
begin
  if dbState = dsBrowse then
    begin
      DBGridEh1.ReadOnly:=True;
      btnAppend.Enabled:=False;
      btnSave.Enabled:=False;
      btnDelete.Enabled:=False;
    end;
end;

function TfrmSizeInfo.CheckCanExport: boolean;
begin
  Result := True;
end;

procedure TfrmSizeInfo.SetMaxCount(const Value: Integer);
begin
  FMaxCount := Value;
end;


procedure TfrmSizeInfo.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if Trim(Text) = '' then
     Text := GetBarcodeFlag;
  if Length(Text) < 2 then
  begin
    cdsSIZE_INFO.FieldByName('BARCODE_FLAG').AsString:='';
    Raise Exception.Create('条码标号不能少于2个字符');
  end;
  if Length(Text) > 2 then
  begin
    cdsSIZE_INFO.FieldByName('BARCODE_FLAG').AsString:='';
    Raise Exception.Create('条码标号不能超出2个字符');
  end;
  JudgeBarcodeFlag(Text);
  cdsSIZE_INFO.Edit;
end;

procedure TfrmSizeInfo.FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh1.Col;
  Inc(i);
  while True do
    begin
      if i>=DbGridEh1.Columns.Count then i:= 1;
      if (DbGridEh1.Columns[i].ReadOnly or not DbGridEh1.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(cdsSIZE_INFO.FieldbyName('SIZE_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(cdsSIZE_INFO.FieldbyName('SIZE_ID').asString)<>'') then
              begin
                 cdsSIZE_INFO.Next ;
                 if cdsSIZE_INFO.Eof then
                    begin
                      cdsSIZE_INFO.Append;
                    end;
                 DbGridEh1.SetFocus;
                 DbGridEh1.Col := 1 ;
              end
           else
              DbGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmSizeInfo.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
var BarFlag:String;
begin
  inherited;
  if (Key = #13) then
  begin
    Key := #0;
    if (DBGridEh1.SelectedField.FieldName = 'BARCODE_FLAG') and (Trim(DBGridEh1.SelectedField.AsString) = '') then
    begin
      BarFlag := GetBarcodeFlag;
      cdsSIZE_INFO.Edit;
      cdsSIZE_INFO.FieldByName('BARCODE_FLAG').AsString := BarFlag;
      cdsSIZE_INFO.Post;
    end;
    FocusNextColumn;
  end;
end;

function TfrmSizeInfo.GetBarcodeFlag: String;
var i,SeqNo:Integer;
    BarFlag:String;
begin
  cdsSIZE_INFO.DisableControls;
  try
    i := 1;
    SeqNo := cdsSIZE_INFO.RecNo;
    BarFlag := FormatFloat('00',i);
    cdsSIZE_INFO.First;
    while not cdsSIZE_INFO.Eof do
    begin
      BarFlag := FormatFloat('00',i);
      if not cdsSIZE_INFO.Locate('BARCODE_FLAG',BarFlag,[]) then
      Begin
         Result := BarFlag;
         Exit;
      end;
      Inc(i);
      cdsSIZE_INFO.Next;
    end;
    cdsSIZE_INFO.RecNo := SeqNo;
  finally
    cdsSIZE_INFO.EnableControls;
  end;
end;

procedure TfrmSizeInfo.JudgeBarcodeFlag(BarcodeFlag: String);
begin
  if cdsSIZE_INFO.Locate('BARCODE_FLAG',BarcodeFlag,[]) then
     Raise Exception.Create('条码标号"'+BarcodeFlag+'"重复!');
end;

end.
