unit ufrmClientSort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, RzButton, Grids,
  DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmClientSort = class(TframeDialogForm)
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
    cdsClientSort: TZQuery;
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cdsClientSortBeforePost(DataSet: TDataSet);
    procedure cdsClientSortNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure cdsClientSortAfterEdit(DataSet: TDataSet);
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
  private
    IsCompany:Boolean;
    FFlag: integer;
    procedure SetFlag(const Value: integer);
    { Private declarations }
  public
    procedure Open;
    procedure Save;
    property  Flag:integer read FFlag write SetFlag;  //1:其它窗体调用这个窗体
    class function AddDialog(Owner:TForm;var AObj:TRecord_):boolean;
    { Public declarations }
  end;

implementation
uses  uGlobal,uFnUtil,uDsUtil, uShopGlobal;
{$R *.dfm}

procedure TfrmClientSort.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if Length(Text) > 10 then
  begin
    cdsClientSort.FieldByName('CODE_SPELL').AsString:='';
    Raise Exception.Create('类别名称不能超出5个汉字或10个字符');
  end;
  cdsClientSort.FieldByName('CODE_SPELL').AsString:=Fnstring.GetWordSpell(Text,3);
  btnSave.Enabled:=True;  
end;

procedure TfrmClientSort.btnAppendClick(Sender: TObject);
begin
  inherited;
  if cdsClientSort.State in [dsEdit,dsInsert] then cdsClientSort.Post;
  if not cdsClientSort.IsEmpty then
  begin
    cdsClientSort.Last;
    if (cdsClientSort.FieldByName('CODE_NAME').AsString='') and (cdsClientSort.FieldByName('CODE_SPELL').AsString='') and (cdsClientSort.FieldByName('CODE_ID').AsString='') then
      exit;
  end;
  cdsClientSort.DisableControls;
  try
    cdsClientSort.First;
    while not cdsClientSort.Eof do
    begin
      if cdsClientSort.FieldByName('CODE_NAME').AsString='' then
        raise Exception.Create('类别名称不能为空！');
      if cdsClientSort.FieldByName('CODE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsClientSort.Next;
    end;
  finally
    cdsClientSort.EnableControls;
  end;
  cdsClientSort.Append;
  cdsClientSort.FieldByName('CODE_ID').AsString := TSequence.NewId;
  cdsClientSort.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsClientSort.FieldByName('CODE_NAME').AsString := '';
  cdsClientSort.Post;
  DBGridEh1.SetFocus;
  DBGridEh1.Col:=1;
  DBGridEh1.EditorMode := true;  
end;

procedure TfrmClientSort.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('确认要删除"'+cdsClientSort.FieldbyName('CODE_NAME').AsString+'"单位类别？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsClientSort.Delete;
  if cdsClientSort.State in [dsEdit,dsInsert] then cdsClientSort.Post;
  //删除后重新排序
  cdsClientSort.DisableControls;
  try
    cdsClientSort.First;
    while not cdsClientSort.Eof do
    begin
      cdsClientSort.Edit;
      cdsClientSort.FieldByName('SEQ_NO').AsString:=IntToStr(cdsClientSort.RecNo);
      cdsClientSort.Post;
      cdsClientSort.Next;
    end;
  finally
    cdsClientSort.EnableControls;
  end;
  btnSave.Enabled:=True;
  //删除记录后，如果没有记录了，删除按钮不能操作
  if cdsClientSort.IsEmpty then
  begin
    btnDelete.Enabled:=False;
    Exit;
  end;
end;

procedure TfrmClientSort.btnSaveClick(Sender: TObject);
begin
  inherited;
  if cdsClientSort.State in [dsInsert,dsEdit] then cdsClientSort.Post;
  if (cdsClientSort.FieldbyName('CODE_NAME').AsString='') and (cdsClientSort.FieldbyName('CODE_SPELL').AsString='') and (cdsClientSort.FieldbyName('CODE_ID').AsString='')then
  begin
    if not cdsClientSort.IsEmpty then
      cdsClientSort.Delete;
  end;
  cdsClientSort.DisableControls;
  try
    cdsClientSort.First;
    while not cdsClientSort.Eof do
    begin
      if cdsClientSort.FieldByName('CODE_NAME').AsString='' then
        raise Exception.Create('类别名称不能为空！');
      if cdsClientSort.FieldByName('CODE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsClientSort.Next;
    end;
  finally
    cdsClientSort.EnableControls;
  end;  
  Save;
  if Flag=1 then
    ModalResult:=MROK;
  btnSave.Enabled:=False;
  if btnDelete.Enabled=False then
     btnDelete.Enabled:=True;
end;

procedure TfrmClientSort.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmClientSort.cdsClientSortBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (DBGridEh1.Row=DBGridEh1.RowCount-1) and  (cdsClientSort.FieldByName('CODE_ID').AsString='') then
  begin
    exit;
  end;
  if cdsClientSort.FieldByName('CODE_NAME').AsString='' then raise Exception.Create('类别名称不能为空！');
  if cdsClientSort.FieldByName('CODE_SPELL').AsString='' then raise Exception.Create('拼音码不能为空！');

end;

procedure TfrmClientSort.cdsClientSortNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsClientSort.FieldByName('SEQ_NO').AsString:=IntToStr(cdsClientSort.RecordCount+1);
end;

procedure TfrmClientSort.Open;
var Param: TftParamList;
begin
  try
    Param := TftParamList.Create(nil);
    Param.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsClientSort,'TClientSort',Param);
  finally
    Param.Free;
  end;
  if cdsClientSort.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmClientSort.Save;
var c:integer;
    i:integer;
begin
  i:=cdsClientSort.RecNo;
  if cdsClientSort.IsEmpty then
    i:=0;
  cdsClientSort.DisableControls;
  try
    c := 0;
    cdsClientSort.First;
    while not cdsClientSort.Eof do
      begin
        inc(c);
        if c = cdsClientSort.FieldByName('SEQ_NO').AsInteger THEN
          begin
            cdsClientSort.Next;
            Continue;
          end;
        cdsClientSort.Edit;
        cdsClientSort.FieldByName('SEQ_NO').AsInteger := c;
        cdsClientSort.Post;
        cdsClientSort.Next;
      end;
  finally
    cdsClientSort.EnableControls;
  end;
  try
    Factor.UpdateBatch(cdsClientSort,'TClientSort');
  except
    cdsClientSort.Close;
    Factor.Open(cdsClientSort,'TClientSort');
    if not cdsClientSort.IsEmpty then
    begin
      if i=0 then i:=1;
      cdsClientSort.RecNo:=i;
    end;
    if cdsClientSort.IsEmpty then
      btnDelete.Enabled:=False;
    btnSave.Enabled:=False;
    raise;    
  end;
  //Global.RefreshTable('PUB_ClientSort');
  cdsClientSort.Close;
  Factor.Open(cdsClientSort,'TClientSort');
  if not cdsClientSort.IsEmpty then
  begin
    if i=0 then i:=1;
    cdsClientSort.RecNo:=i;
  end;
  if cdsClientSort.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmClientSort.FormShow(Sender: TObject);
begin
  inherited;
  Open;
  btnSave.Enabled:=False;
  DBGridEh1.SetFocus;
  //其它窗体调用此窗体，直接新增记录
  if Flag=1 then
  begin
    btnAppendClick(nil);
    btnAppend.Enabled:=False;
    btnDelete.Enabled:=False;
  end;
  cdsClientSort.Last;
end;

procedure TfrmClientSort.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmClientSort.cdsClientSortAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
end;

procedure TfrmClientSort.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  inherited;
  if btnSave.Enabled=True  then
  begin
    i:=MessageBox(Handle,Pchar('单位类别有修改,是否要保存吗?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
      abort
    else if i=6 then
      btnSaveClick(nil);
  end;

end;

procedure TfrmClientSort.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmClientSort.AddDialog(Owner: TForm;
  var AObj: TRecord_): boolean;
begin
   //if (not ShopGlobal.GetIsCompany(Global.UserID))  then raise Exception.Create('不是总店，不能编辑单位分类!');
   //if not ShopGlobal.GetChkRight('400004') then Raise Exception.Create('你没有编辑单位分类的权限,请和管理员联系.');
   with TfrmClientSort.Create(Owner) do
    begin
      try
        Flag:=1;
        ShowModal;
        if ModalResult=MROK then
        begin
          AObj.ReadFromDataSet(cdsClientSort);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;

procedure TfrmClientSort.SetFlag(const Value: integer);
begin
  FFlag := Value;
end;

procedure TfrmClientSort.FormCreate(Sender: TObject);
begin
  //IsCompany:=ShopGlobal.GetIsCompany(Global.UserID);
  {if not IsCompany then
  begin
    DBGridEh1.ReadOnly:=True;
    btnAppend.Enabled:=False;
    btnSave.Enabled:=False;
    btnDelete.Enabled:=False;
  end;
  if not ShopGlobal.GetChkRight('400004') then
  begin
    DBGridEh1.ReadOnly:=True;
    btnAppend.Enabled:=False;
    btnSave.Enabled:=False;
    btnDelete.Enabled:=False;
  end;}
end;

procedure TfrmClientSort.CtrlUpExecute(Sender: TObject);
var SEQ_NO,CODE_ID,SEQ_NO1,CODE_ID1:string;
begin
  inherited;
  if cdsClientSort.IsEmpty then exit;
  if cdsClientSort.RecordCount=1 then exit;
  if cdsClientSort.RecNo=1 then exit;
  if cdsClientSort.State in [dsEdit,dsInsert] then cdsClientSort.Post;
  if cdsClientSort.RecNo=cdsClientSort.RecordCount then
  begin
    if cdsClientSort.FieldByName('CODE_NAME').AsString='' then
    begin
      cdsClientSort.Delete;
      exit;
    end;
    if cdsClientSort.FieldByName('CODE_SPELL').AsString='' then
    begin
      cdsClientSort.Delete;
      exit;
    end;
  end;
  SEQ_NO:=cdsClientSort.FieldByName('SEQ_NO').AsString;
  CODE_ID:=cdsClientSort.FieldByName('CODE_ID').AsString;
  cdsClientSort.Prior;
  SEQ_NO1:=cdsClientSort.FieldByName('SEQ_NO').AsString;
  CODE_ID1:=cdsClientSort.FieldByName('CODE_ID').AsString;
  if cdsClientSort.Locate('CODE_ID',CODE_ID1,[]) then
  begin
    cdsClientSort.Edit;
    cdsClientSort.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsClientSort.Post;
  end;
  if cdsClientSort.Locate('CODE_ID',CODE_ID,[]) then
  begin
    cdsClientSort.Edit;
    cdsClientSort.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsClientSort.Post;
  end;
  cdsClientSort.indexfieldnames:='SEQ_NO';
end;

procedure TfrmClientSort.CtrlDownExecute(Sender: TObject);
var SEQ_NO,CODE_ID,SEQ_NO1,CODE_ID1:string;
begin
  inherited;
  if cdsClientSort.IsEmpty then exit;
  if cdsClientSort.RecordCount=1 then exit;
  if cdsClientSort.RecNo=cdsClientSort.RecordCount then exit;
  if cdsClientSort.State in [dsEdit,dsInsert] then cdsClientSort.Post;
  SEQ_NO:=cdsClientSort.FieldByName('SEQ_NO').AsString;
  CODE_ID:=cdsClientSort.FieldByName('CODE_ID').AsString;
  cdsClientSort.Next;
  if cdsClientSort.RecNo=cdsClientSort.RecordCount then
  begin
    if cdsClientSort.FieldByName('CODE_NAME').AsString='' then
    begin
      cdsClientSort.Delete;
      exit;
    end;
    if cdsClientSort.FieldByName('CODE_SPELL').AsString='' then
    begin
      cdsClientSort.Delete;
      exit;
    end;
  end;
  SEQ_NO1:=cdsClientSort.FieldByName('SEQ_NO').AsString;
  CODE_ID1:=cdsClientSort.FieldByName('CODE_ID').AsString;
  if cdsClientSort.Locate('CODE_ID',CODE_ID1,[]) then
  begin
    cdsClientSort.Edit;
    cdsClientSort.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsClientSort.Post;
  end;
  if cdsClientSort.Locate('CODE_ID',CODE_ID,[]) then
  begin
    cdsClientSort.Edit;
    cdsClientSort.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsClientSort.Post;
  end;
  cdsClientSort.indexfieldnames:='SEQ_NO';

end;

procedure TfrmClientSort.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsClientSort.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmClientSort.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  while cdsClientSort.RecNo<cdsClientSort.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmClientSort.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and  (Key=VK_UP) then
  begin
    Key:=0;
    if (not IsCompany) or (not ShopGlobal.GetChkRight('400004')) then exit;
    CtrlUpExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_DOWN) then
  begin
    Key:=0;
    if (not IsCompany) or (not ShopGlobal.GetChkRight('400004')) then exit;
    CtrlDownExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_HOME) then
  begin
    Key:=0;
    if (not IsCompany) or (not ShopGlobal.GetChkRight('400004')) then exit;
    CtrlHomeExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_END) then
  begin
    Key:=0;
    if (not IsCompany) or (not ShopGlobal.GetChkRight('400004')) then exit;
    CtrlEndExecute(nil);
  end;
end;

end.
