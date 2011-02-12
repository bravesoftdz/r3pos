unit ufrmCode_Info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel, RzButton, Grids,
  DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmCode_Info = class(TframeDialogForm)
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
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure cdsCODE_INFOAfterEdit(DataSet: TDataSet);
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
    FCode_type: Integer;
    procedure SetFlag(const Value: integer);
    procedure SetCode_type(const Value: Integer);
    { Private declarations }
  public
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

procedure TfrmCode_Info.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  cdsCODE_INFO.FieldByName('CODE_SPELL').AsString:=Fnstring.GetWordSpell(Text,3);
  btnSave.Enabled:=True;  
end;

procedure TfrmCode_Info.btnAppendClick(Sender: TObject);
begin
  inherited;
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
        raise Exception.Create('类别名称不能为空！');
      if cdsCODE_INFO.FieldByName('CODE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      cdsCODE_INFO.Next;
    end;
  finally
    cdsCODE_INFO.EnableControls;
  end;
  cdsCODE_INFO.Append;
  cdsCODE_INFO.FieldByName('CODE_ID').AsString := TSequence.NewId;
  cdsCODE_INFO.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsCODE_INFO.FieldByName('CODE_NAME').AsString := '';
  cdsCODE_INFO.Post;
  DBGridEh1.SetFocus;
  DBGridEh1.Col:=1;
  DBGridEh1.EditorMode := true;  
end;

procedure TfrmCode_Info.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,pchar('确认要删除"'+cdsCODE_INFO.FieldbyName('CODE_NAME').AsString+'"单位类别？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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

procedure TfrmCode_Info.btnSaveClick(Sender: TObject);
begin
  inherited;
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
        raise Exception.Create('类别名称不能为空！');
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

procedure TfrmCode_Info.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmCode_Info.cdsCODE_INFOBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (DBGridEh1.Row=DBGridEh1.RowCount-1) and  (cdsCODE_INFO.FieldByName('CODE_ID').AsString='') then
  begin
    exit;
  end;
  if cdsCODE_INFO.FieldByName('CODE_NAME').AsString='' then raise Exception.Create('类别名称不能为空！');
  if cdsCODE_INFO.FieldByName('CODE_SPELL').AsString='' then raise Exception.Create('拼音码不能为空！');

end;

procedure TfrmCode_Info.cdsCODE_INFONewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsCODE_INFO.FieldByName('SEQ_NO').AsString:=IntToStr(cdsCODE_INFO.RecordCount+1);
end;

procedure TfrmCode_Info.Open;
var Params: TftParamList;
begin
  try
    Params := TftParamList.Create(nil);
    Params.ParamByName('CODE_TYPE').AsInteger := Code_type;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsCODE_INFO,'TClientSort',Params);
  finally
    Params.Free;
  end;
  if cdsCODE_INFO.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmCode_Info.Save;
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
    Factor.UpdateBatch(cdsCODE_INFO,'TClientSort');
  except
    cdsCODE_INFO.Close;
    Factor.Open(cdsCODE_INFO,'TClientSort');
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
  //Global.RefreshTable('PUB_ClientSort');
  cdsCODE_INFO.Close;
  Factor.Open(cdsCODE_INFO,'TClientSort');
  if not cdsCODE_INFO.IsEmpty then
  begin
    if i=0 then i:=1;
    cdsCODE_INFO.RecNo:=i;
  end;
  if cdsCODE_INFO.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmCode_Info.FormShow(Sender: TObject);
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
  cdsCODE_INFO.Last;
end;

procedure TfrmCode_Info.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmCode_Info.cdsCODE_INFOAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
end;

procedure TfrmCode_Info.FormClose(Sender: TObject;
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

procedure TfrmCode_Info.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmCode_Info.AddDialog(Owner: TForm;
  var AObj: TRecord_;CODETYPE:Integer): boolean;
begin
   //if (not ShopGlobal.GetIsCompany(Global.UserID))  then raise Exception.Create('不是总店，不能编辑单位分类!');
   //if not ShopGlobal.GetChkRight('400004') then Raise Exception.Create('你没有编辑单位分类的权限,请和管理员联系.');
   with TfrmCODE_INFO.Create(Owner) do
    begin
      try
        Flag:=1;
        Code_type := CODETYPE;
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

procedure TfrmCode_Info.SetFlag(const Value: integer);
begin
  FFlag := Value;
end;

procedure TfrmCode_Info.FormCreate(Sender: TObject);
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

procedure TfrmCode_Info.CtrlUpExecute(Sender: TObject);
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

procedure TfrmCode_Info.CtrlDownExecute(Sender: TObject);
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

procedure TfrmCode_Info.CtrlHomeExecute(Sender: TObject);
begin
  inherited;
  while cdsCODE_INFO.RecNo>1 do
   CtrlUpExecute(nil);
end;

procedure TfrmCode_Info.CtrlEndExecute(Sender: TObject);
begin
  inherited;
  while cdsCODE_INFO.RecNo<cdsCODE_INFO.RecordCount do
  CtrlDownExecute(nil);
end;

procedure TfrmCode_Info.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
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

class function TfrmCode_Info.ShowDialog(Owner: TForm;
  CODETYPE: Integer): boolean;
begin
  with TfrmCode_Info.Create(Owner) do
    begin
      try
        Code_type := CODETYPE;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmCode_Info.SetCode_type(const Value: Integer);
var Tmp:TZQuery;
begin
  FCode_type := Value;
  Tmp := Global.GetZQueryFromName('PUB_PARAMS');
  if Tmp.Locate('TYPE_CODE;CODE_ID',VarArrayOf(['TYPE_CODE',IntToStr(Code_type)]),[]) then
    begin
      Self.Caption := Tmp.Fields[1].AsString+'管理';
      RzPage.Pages[0].Caption := Tmp.Fields[1].AsString + '信息';
    end
  else
    Raise Exception.Create('无效的 CODE_TYPE 值！');
end;

end.
