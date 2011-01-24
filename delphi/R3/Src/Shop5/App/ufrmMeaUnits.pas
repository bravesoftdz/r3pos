unit ufrmMeaUnits;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, Grids, DBGridEh, DB, DBClient,objBase,ADODB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmMeaUnits = class(TframeDialogForm)
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
    cdsUnit: TZQuery;
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cdsUnitBeforePost(DataSet: TDataSet);
    procedure cdsUnitNewRecord(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsUnitAfterEdit(DataSet: TDataSet);
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
    FFlag: integer;
    procedure SetFlag(const Value: integer);
    { Private declarations }
  public
    procedure Open;
    procedure Save;
    { Public declarations }
    class function AddDialog(Owner:TForm;var AObj:TRecord_):boolean;
    property Flag:integer read FFlag write SetFlag; //1:其它窗体调用这个窗体
  end;

implementation
uses  uGlobal,uFnUtil,uDsUtil,uShopUtil, uShopGlobal, ufrmBasic, Math;
{$R *.dfm}

procedure TfrmMeaUnits.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  cdsUnit.FieldByName('UNIT_SPELL').AsString:=Fnstring.GetWordSpell(Text,3);
  btnSave.Enabled:=True;
end;

procedure TfrmMeaUnits.btnAppendClick(Sender: TObject);
begin
  inherited;
  if cdsUnit.State in [dsEdit,dsInsert] then cdsUnit.Post;
  if not cdsUnit.IsEmpty then
  begin
    cdsUnit.Last;
    if (cdsUnit.FieldByName('UNIT_NAME').AsString='') and (cdsUnit.FieldByName('UNIT_SPELL').AsString='') and (cdsUnit.FieldByName('UNIT_ID').AsString='') then
      exit;
  end;
  cdsUnit.DisableControls;
  try
    cdsUnit.First;
    while not cdsUnit.Eof do
    begin
      if cdsUnit.FieldByName('UNIT_NAME').AsString='' then
        raise Exception.Create('单位名称不能为空！');
      if cdsUnit.FieldByName('UNIT_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsUnit.Next;
    end;
  finally
    cdsUnit.EnableControls;
  end;
  cdsUnit.Append;
  cdsUnit.FieldByName('UNIT_ID').AsString := TSequence.NewId;
  cdsUnit.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsUnit.FieldByName('UNIT_NAME').AsString := '';
  cdsUnit.Post;
  DBGridEh1.SetFocus;
  DBGridEh1.Col:=1;
  DBGridEh1.EditorMode := true;
end;

procedure TfrmMeaUnits.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('确认要删除"'+cdsUnit.FieldbyName('UNIT_NAME').AsString+'"单位？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsUnit.Delete;
  if cdsUnit.State in [dsEdit,dsInsert] then cdsUnit.Post;
  //删除后重新排序
  cdsUnit.DisableControls;
  try
    cdsUnit.First;
    while not cdsUnit.Eof do
    begin
      cdsUnit.Edit;
      cdsUnit.FieldByName('SEQ_NO').AsString:=IntToStr(cdsUnit.RecNo);
      cdsUnit.Post;
      cdsUnit.Next;
    end;
  finally
    cdsUnit.EnableControls;
  end;
  btnSave.Enabled:=True;
  //如果删除后没有记录，删除按钮不能操作
  if cdsUnit.IsEmpty then
  begin
    btnDelete.Enabled:=False;
    Exit;
  end;
end;

procedure TfrmMeaUnits.btnSaveClick(Sender: TObject);
begin
  inherited;
  if cdsUnit.State in [dsInsert,dsEdit] then cdsUnit.Post;
  if (cdsUnit.FieldbyName('UNIT_NAME').AsString='') and (cdsUnit.FieldbyName('Unit_SPELL').AsString='') and (cdsUnit.FieldbyName('UNIT_ID').AsString='')then
  begin
    if not cdsUnit.IsEmpty then
      cdsUnit.Delete;
  end;
  cdsUnit.DisableControls;
  try
    cdsUnit.First;
    while not cdsUnit.Eof do
    begin
      if cdsUnit.FieldByName('UNIT_NAME').AsString='' then
        raise Exception.Create('单位名称不能为空！');
      if cdsUnit.FieldByName('UNIT_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsUnit.Next;
    end;
  finally
    cdsUnit.EnableControls;
  end;
  Save;
  //别的窗体调用此窗体
  if Flag=1 then
    ModalResult:=MROK;
  btnSave.Enabled:=False;
  if btnDelete.Enabled=False then
     btnDelete.Enabled:=True;
end;

procedure TfrmMeaUnits.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmMeaUnits.Open;
begin
    Factor.Open(cdsUnit,'TMeaUnits');

  if cdsUnit.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmMeaUnits.Save;
var c:integer;
    i:integer;
begin
  i:=cdsUnit.RecNo;
  if cdsUnit.IsEmpty then
    i:=0;
  cdsUnit.DisableControls;
  try
    c := 0;
    cdsUnit.First;
    while not cdsUnit.Eof do
      begin
        inc(c);
        if c = cdsUnit.FieldByName('SEQ_NO').AsInteger THEN
          begin
            cdsUnit.Next;
            Continue;
          end;
        cdsUnit.Edit;
        cdsUnit.FieldByName('SEQ_NO').AsInteger := c;
        cdsUnit.Post;
        cdsUnit.Next;
      end;
  finally
    cdsUnit.EnableControls;
  end;
  try
    Factor.UpdateBatch(cdsUnit,'TMeaUnits');
  except
    cdsUnit.Close;
    Factor.Open(cdsUnit,'TMeaUnits');
    if not cdsUnit.IsEmpty then
    begin
      if i=0 then i:=1;
      cdsUnit.RecNo:=i;
    end;
    if cdsUnit.IsEmpty then btnDelete.Enabled:=False;
    btnSave.Enabled:=False;
    raise;    
  end;
  Global.RefreshTable('PUB_MEAUNITS');
  cdsUnit.Close;
  Factor.Open(cdsUnit,'TMeaUnits');
  if not cdsUnit.IsEmpty then
  begin
    if i=0 then i:=1;
    cdsUnit.RecNo:=i;
  end;
  if cdsUnit.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmMeaUnits.cdsUnitBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (DBGridEh1.Row=DBGridEh1.RowCount-1) and (cdsUnit.FieldByName('UNIT_ID').AsString='') then
  begin
    exit;
  end;
  if cdsUnit.FieldByName('UNIT_NAME').AsString='' then raise Exception.Create('单位名称不能为空！');
  if cdsUnit.FieldByName('UNIT_SPELL').AsString='' then raise Exception.Create('拼音码不能为空！');
end;

procedure TfrmMeaUnits.cdsUnitNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsUnit.FieldByName('SEQ_NO').AsString:=IntToStr(cdsUnit.RecordCount+1);
end;

procedure TfrmMeaUnits.FormShow(Sender: TObject);
begin
  inherited;
  Open;
  btnSave.Enabled:=False;
  DBGridEh1.SetFocus;
  //别的窗体调用此窗体，直接新增
  if Flag=1 then
  begin
    btnAppendClick(nil);
    btnAppend.Enabled:=False;
    btnDelete.Enabled:=False;
  end;
  cdsUnit.Last;
end;

procedure TfrmMeaUnits.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmMeaUnits.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  inherited;
  if btnSave.Enabled=True  then
  begin
    i:=MessageBox(Handle,Pchar('商品单位档案有修改,是否要保存吗?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
      abort
    else if i=6 then
      btnSaveClick(nil);
  end;
end;

procedure TfrmMeaUnits.cdsUnitAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
end;
class function TfrmMeaUnits.AddDialog(Owner: TForm;
  var AObj: TRecord_): boolean;
begin
   //if not ShopGlobal.GetChkRight('200043') then Raise Exception.Create('你没有编辑计量单位的权限,请和管理员联系.');
   with TfrmMeaUnits.Create(Owner) do
    begin
      try
        Flag:=1;
        ShowModal;
        if ModalResult=MROK then
        begin
          AObj.ReadFromDataSet(cdsUnit);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;


procedure TfrmMeaUnits.SetFlag(const Value: integer);
begin
  FFlag := Value;
end;

procedure TfrmMeaUnits.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

procedure TfrmMeaUnits.FormCreate(Sender: TObject);
begin
  {if not ShopGlobal.GetChkRight('200043') then
  begin
    DBGridEh1.ReadOnly:=True;
    btnAppend.Enabled:=False;
    btnSave.Enabled:=False;
    btnDelete.Enabled:=False;
  end;  }
end;

procedure TfrmMeaUnits.CtrlUpExecute(Sender: TObject);
var SEQ_NO,UNIT_ID,SEQ_NO1,UNIT_ID1:string;
begin
  inherited;
  if cdsUnit.IsEmpty then exit;
  if cdsUnit.RecordCount=1 then exit;
  if cdsUnit.RecNo=1 then exit;
  if cdsUnit.State in [dsEdit,dsInsert] then cdsUnit.Post;
  if cdsUnit.RecNo=cdsUnit.RecordCount then
  begin
    if cdsUnit.FieldByName('UNIT_NAME').AsString='' then
    begin
      cdsUnit.Delete;
      exit;
    end;
    if cdsUnit.FieldByName('UNIT_SPELL').AsString='' then
    begin
      cdsUnit.Delete;
      exit;
    end;
  end;
  SEQ_NO:=cdsUnit.FieldByName('SEQ_NO').AsString;
  UNIT_ID:=cdsUnit.FieldByName('UNIT_ID').AsString;
  cdsUnit.Prior;
  SEQ_NO1:=cdsUnit.FieldByName('SEQ_NO').AsString;
  UNIT_ID1:=cdsUnit.FieldByName('UNIT_ID').AsString;
  if cdsUnit.Locate('UNIT_ID',UNIT_ID1,[]) then
  begin
    cdsUnit.Edit;
    cdsUnit.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsUnit.Post;
  end;
  if cdsUnit.Locate('UNIT_ID',UNIT_ID,[]) then
  begin
    cdsUnit.Edit;
    cdsUnit.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsUnit.Post;
  end;
  cdsUnit.indexfieldnames:='SEQ_NO';
end;

procedure TfrmMeaUnits.CtrlDownExecute(Sender: TObject);
var SEQ_NO,UNIT_ID,SEQ_NO1,UNIT_ID1:string;
begin
  inherited;
  if cdsUnit.IsEmpty then exit;
  if cdsUnit.RecordCount=1 then exit;
  if cdsUnit.RecNo=cdsUnit.RecordCount then exit;
  if cdsUnit.State in [dsEdit,dsInsert] then cdsUnit.Post;
  if cdsUnit.RecNo=cdsUnit.RecordCount then
  begin
    if cdsUnit.FieldByName('UNIT_NAME').AsString='' then
    begin
      cdsUnit.Delete;
      exit;
    end;
    if cdsUnit.FieldByName('UNIT_SPELL').AsString='' then
    begin
      cdsUnit.Delete;
      exit;
    end;
  end;
  SEQ_NO:=cdsUnit.FieldByName('SEQ_NO').AsString;
  UNIT_ID:=cdsUnit.FieldByName('UNIT_ID').AsString;
  cdsUnit.Next;
  SEQ_NO1:=cdsUnit.FieldByName('SEQ_NO').AsString;
  UNIT_ID1:=cdsUnit.FieldByName('UNIT_ID').AsString;
  if cdsUnit.Locate('UNIT_ID',UNIT_ID1,[]) then
  begin
    cdsUnit.Edit;
    cdsUnit.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO);
    cdsUnit.Post;
  end;
  if cdsUnit.Locate('UNIT_ID',UNIT_ID,[]) then
  begin
    cdsUnit.Edit;
    cdsUnit.FieldByName('SEQ_NO').AsInteger:=StrToInt(SEQ_NO1);
    cdsUnit.Post;
  end;
  cdsUnit.indexfieldnames:='SEQ_NO';
end;

procedure TfrmMeaUnits.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsUnit.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmMeaUnits.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  while cdsUnit.RecNo<cdsUnit.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmMeaUnits.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (ssCtrl in Shift) and  (Key=VK_UP) then
  begin
    Key:=0;
    if (not ShopGlobal.GetChkRight('200043')) then exit;
    CtrlUpExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_DOWN) then
  begin
    Key:=0;
    if (not ShopGlobal.GetChkRight('200043')) then exit;
    CtrlDownExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_HOME) then
  begin
    Key:=0;
    if (not ShopGlobal.GetChkRight('200043')) then exit;
    CtrlHomeExecute(nil);
  end;
  if (ssCtrl in Shift) and  (Key=VK_END) then
  begin
    Key:=0;
    if (not ShopGlobal.GetChkRight('200043')) then exit;
    CtrlEndExecute(nil);
  end;
end;

end.
