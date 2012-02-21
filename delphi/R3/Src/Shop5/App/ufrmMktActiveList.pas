unit ufrmMktActiveList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,RzButton,
  Grids, DBGridEh, DB, zBase, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList;

  
type
  TfrmMktActiveList = class(TframeDialogForm)
    DBGridEh1: TDBGridEh;
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsActive: TDataSource;
    btnAppend: TRzBitBtn;
    btnDelete: TRzBitBtn;
    cdsActive: TZQuery;
    edtACTIVE_GROUP: TzrComboBoxList;
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnAppendClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsActiveAfterEdit(DataSet: TDataSet);
    procedure edtACTIVE_GROUPSaveValue(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtACTIVE_GROUPEnter(Sender: TObject);
    procedure edtACTIVE_GROUPExit(Sender: TObject);
    procedure edtACTIVE_GROUPKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure edtACTIVE_GROUPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FFlag: integer;
    IsOffline:Boolean;
    procedure SetFlag(const Value: integer);
    { Private declarations }
  protected
    procedure SetdbState(const Value: TDataSetState);
    function CheckCanExport:boolean;
  public
    procedure Open;
    procedure Save;
    procedure FocusNextColumn;
    procedure InitRecord;
    { Public declarations }
    class function AddDialog(Owner:TForm;var AObj:TRecord_):boolean;
    class function ShowDialog(Owner:TForm):boolean;
    property Flag:integer read FFlag write SetFlag; //1:其它窗体调用这个窗体
  end;

implementation
uses  uGlobal,uFnUtil,uDsUtil,uShopUtil, uShopGlobal, ufrmBasic, Math;
{$R *.dfm}

procedure TfrmMktActiveList.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if Length(Text) > 50 then
    begin
      cdsActive.FieldByName('ACTIVE_NAME').AsString:='';
      Raise Exception.Create('市场活动名称不能超出25个汉字或50个字符');
    end;
  cdsActive.FieldByName('ACTIVE_SPELL').AsString:=Fnstring.GetWordSpell(Text,3);
  btnSave.Enabled:=True;
end;

procedure TfrmMktActiveList.btnAppendClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if not (ShopGlobal.GetChkRight('100002257',2) or ShopGlobal.GetChkRight('100002257',3)) then Raise Exception.Create('你没有编辑市场活动的权限,请和管理员联系.');
  if cdsActive.State in [dsEdit,dsInsert] then cdsActive.Post;
  if not cdsActive.IsEmpty then
  begin
    cdsActive.Last;
    if (cdsActive.FieldByName('ACTIVE_NAME').AsString='') and (cdsActive.FieldByName('ACTIVE_SPELL').AsString='')
    and (cdsActive.FieldByName('ACTIVE_GROUP').AsString='') and (cdsActive.FieldbyName('ACTIVE_ID').AsString='') then
      exit;
  end;
  
  cdsActive.DisableControls;
  try
    cdsActive.First;
    while not cdsActive.Eof do
    begin
      if cdsActive.FieldByName('ACTIVE_NAME').AsString='' then
        raise Exception.Create('活动名称不能为空！');
      if cdsActive.FieldByName('ACTIVE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      if cdsActive.FieldByName('ACTIVE_GROUP').AsString='' then
        raise Exception.Create('活动分组不能为空！');
      cdsActive.Next;
    end;
  finally
    cdsActive.EnableControls;
  end;
  cdsActive.Append;

  DBGridEh1.SetFocus;
  DBGridEh1.Col:=1;
  DBGridEh1.EditorMode := true;
end;

procedure TfrmMktActiveList.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if not ShopGlobal.GetChkRight('100002257',4) then Raise Exception.Create('你没有删除市场活动的权限,请和管理员联系.');
  if MessageBox(Handle,pchar('确认要删除"'+cdsActive.FieldbyName('ACTIVE_NAME').AsString+'"活动？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsActive.Delete;
  if cdsActive.State in [dsEdit,dsInsert] then cdsActive.Post;

  btnSave.Enabled:=True;
  //如果删除后没有记录，删除按钮不能操作
  if cdsActive.IsEmpty then
  begin
    btnDelete.Enabled:=False;
    Exit;
  end;
end;

procedure TfrmMktActiveList.btnSaveClick(Sender: TObject);
begin
  inherited;
  if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
  if cdsActive.State in [dsInsert,dsEdit] then cdsActive.Post;
  if (cdsActive.FieldbyName('ACTIVE_NAME').AsString='') and (cdsActive.FieldbyName('ACTIVE_SPELL').AsString='')
  and (cdsActive.FieldbyName('ACTIVE_GROUP').AsString='') and (cdsActive.FieldbyName('ACTIVE_ID').AsString='') then
  begin
    if not cdsActive.IsEmpty then
      cdsActive.Delete;
  end;
  cdsActive.DisableControls;
  try
    cdsActive.First;
    while not cdsActive.Eof do
    begin
      if cdsActive.FieldByName('ACTIVE_NAME').AsString='' then
        raise Exception.Create('活动名称不能为空！');
      if cdsActive.FieldByName('ACTIVE_SPELL').AsString='' then
        raise Exception.Create('拼音码不能为空！');
      if cdsActive.FieldByName('ACTIVE_GROUP').AsString='' then
        raise Exception.Create('活动分组不能为空！');
      cdsActive.Next;
    end;
  finally
    cdsActive.EnableControls;
  end;
  Save;
  //别的窗体调用此窗体
  if Flag=1 then
    ModalResult:=MROK;
  btnSave.Enabled:=False;
  if btnDelete.Enabled=False then
     btnDelete.Enabled:=True;
end;

procedure TfrmMktActiveList.btnExitClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmMktActiveList.Open;
var
  Param: TftParamList;
begin
  Param := TftParamList.Create;
  try
    Param.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsActive,'TMktActiveList',Param);
  finally
    Param.Free;
  end;
  if cdsActive.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmMktActiveList.Save;
begin
  try
    Factor.UpdateBatch(cdsActive,'TMktActiveList');
  except
    btnSave.Enabled:=False;
    if cdsActive.IsEmpty then btnDelete.Enabled:=False;
    raise;    
  end;
  //Global.RefreshTable('PUB_MEAUNITS');

  if cdsActive.IsEmpty then btnDelete.Enabled:=False;
end;

procedure TfrmMktActiveList.FormShow(Sender: TObject);
begin
  inherited;
  Open;
  btnSave.Enabled:=False;
  DBGridEh1.SetFocus;
  //别的窗体调用此窗体，直接新增
  if Flag=1 then
  begin
    btnAppendClick(nil);
  end;
  if (ShopGlobal.NetVersion) and (ShopGlobal.offline) then
    begin
      IsOffline := True;
      btnAppend.Enabled:=False;
      btnSave.Enabled:=False;
      btnDelete.Enabled:=False;
    end;  
end;

procedure TfrmMktActiveList.DBGridEh1DrawColumnCell(Sender: TObject;
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
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsActive.RecNo)),length(Inttostr(cdsActive.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmMktActiveList.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  inherited;
  if btnSave.Enabled=True  then
  begin
    i:=MessageBox(Handle,Pchar('市场活动信息有修改,是否要保存吗?'),Pchar(Caption),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONQUESTION);
    if i=2 then
      abort
    else if i=6 then
      btnSaveClick(nil);
  end;
end;

procedure TfrmMktActiveList.cdsActiveAfterEdit(DataSet: TDataSet);
begin
  inherited;
  btnSave.Enabled:=True;
end;

class function TfrmMktActiveList.AddDialog(Owner: TForm;
  var AObj: TRecord_): boolean;
begin
   if not ShopGlobal.GetChkRight('100002257',2) then Raise Exception.Create('你没有编辑市场活动的权限,请和管理员联系.');
   with TfrmMktActiveList.Create(Owner) do
    begin
      try
        Flag:=1;
        ShowModal;
        if ModalResult=MROK then
        begin
          AObj.ReadFromDataSet(cdsActive);
          result :=True;
        end
        else
          result :=False;
      finally
        free;
      end;
    end;
end;


procedure TfrmMktActiveList.SetFlag(const Value: integer);
begin
  FFlag := Value;
end;

class function TfrmMktActiveList.ShowDialog(Owner: TForm): boolean;
begin
  if not ShopGlobal.GetChkRight('100002257',1) then Raise Exception.Create('你没有查看市场活动的权限,请和管理员联系.');
  with TfrmMktActiveList.Create(Owner) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;

end;

procedure TfrmMktActiveList.SetdbState(const Value: TDataSetState);
begin
  if dbstate = dsBrowse then
    begin
      DBGridEh1.ReadOnly:=True;
      btnAppend.Enabled:=False;
      btnSave.Enabled:=False;
      btnDelete.Enabled:=False;
    end;
end;

function TfrmMktActiveList.CheckCanExport: boolean;
begin
  Result := ShopGlobal.GetChkRight('100002257',6);
end;

procedure TfrmMktActiveList.edtACTIVE_GROUPSaveValue(Sender: TObject);
procedure EraseRecord;
var i:integer;
begin
  if cdsActive.State = dsBrowse then cdsActive.Edit;
  for i:=1 to cdsActive.Fields.Count -1 do cdsActive.Fields[i].Value := null;
  edtACTIVE_GROUP.Text := '';
  edtACTIVE_GROUP.KeyValue := null;
end;
begin
  inherited;
  if not cdsActive.Active then Exit;

  if (edtACTIVE_GROUP.AsString='') and edtACTIVE_GROUP.Focused and ShopGlobal.GetChkRight('100002257',2) then   //
     Raise Exception.Create('没找到你想查找的活动分组？');

  cdsActive.DisableControls;
  try
    if VarIsNull(edtACTIVE_GROUP.KeyValue) then
    begin
      EraseRecord;
    end
    else
    begin
      cdsActive.Edit;
      cdsActive.FieldByName('ACTIVE_GROUP').AsString := edtACTIVE_GROUP.AsString;
      cdsActive.FieldByName('ACTIVE_GROUP_TEXT').AsString := edtACTIVE_GROUP.Text;
      cdsActive.Post;
    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsActive.EnableControls;
    cdsActive.Edit;
  end;
end;

procedure TfrmMktActiveList.FormCreate(Sender: TObject);
begin
  inherited;
  edtACTIVE_GROUP.DataSet := ShopGlobal.GetZQueryFromName('MKT_ACTIVE_INFO');
end;

procedure TfrmMktActiveList.edtACTIVE_GROUPEnter(Sender: TObject);
begin
  inherited;
  edtACTIVE_GROUP.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmMktActiveList.edtACTIVE_GROUPExit(Sender: TObject);
begin
  inherited;
  if not edtACTIVE_GROUP.DropListed then edtACTIVE_GROUP.Visible := False; 
end;

procedure TfrmMktActiveList.edtACTIVE_GROUPKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       if cdsActive.FieldbyName('ACTIVE_GROUP').AsString = '' then
          begin
            edtACTIVE_GROUP.DropList;
            Exit;
          end;
       DBGridEh1.SetFocus;
       FocusNextColumn;
     end;
end;

procedure TfrmMktActiveList.FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh1.Col;
  if cdsActive.RecordCount>cdsActive.RecNo then
     begin
       cdsActive.Next;
       Exit;
     end;
  Inc(i);
  while True do
    begin
      if i>=3 then i:= 1;
      if (DbGridEh1.Columns[i].ReadOnly or not DbGridEh1.Columns[i].Visible) then  // and (i<>1)
         inc(i)
      else
         begin
           if Trim(cdsActive.FieldbyName('ACTIVE_GROUP').asString)='' then
              i := 1;
           if (i=1) and (Trim(cdsActive.FieldbyName('ACTIVE_GROUP').asString)<>'') then
              begin
                 cdsActive.Next ;
                 if cdsActive.Eof then
                    begin
                      InitRecord;
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

procedure TfrmMktActiveList.InitRecord;
begin
  if dbState = dsBrowse then Exit;
  if cdsActive.State in [dsEdit,dsInsert] then cdsActive.Post;
  edtACTIVE_GROUP.Visible := false;
  cdsActive.DisableControls;
  try
  cdsActive.Last;
  if cdsActive.IsEmpty or ((cdsActive.FieldbyName('ACTIVE_GROUP').AsString <> '')
  and (cdsActive.FieldbyName('ACTIVE_NAME').AsString <> '')) then
    begin
      if IsOffline then Raise Exception.Create('连锁版不允许离线操作!');
      cdsActive.Append;
      cdsActive.FieldByName('ACTIVE_ID').AsString := TSequence.NewId;
      cdsActive.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      cdsActive.Post;
      btnSave.Enabled:=True;
    end;
    DbGridEh1.Col := 1 ;
    if DBGridEh1.CanFocus and Visible and (dbState <> dsBrowse) then DBGridEh1.SetFocus;
  finally
    cdsActive.EnableControls;
    cdsActive.Edit;
  end;
end;

procedure TfrmMktActiveList.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key=#13) then
     begin
       FocusNextColumn;
       Key := #0;
     end;
  inherited;
end;

procedure TfrmMktActiveList.edtACTIVE_GROUPKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_RIGHT) and not edtACTIVE_GROUP.Edited then
     begin
       DBGridEh1.SetFocus;
       edtACTIVE_GROUP.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not edtACTIVE_GROUP.DropListed then
     begin
       DBGridEh1.SetFocus;
       edtACTIVE_GROUP.Visible := false;
       edtTable.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtACTIVE_GROUP.DropListed then
     begin
       if (cdsActive.FieldByName('ACTIVE_GROUP').AsString='') and (cdsActive.FieldByName('ACTIVE_ID').AsString<>'')
       and (cdsActive.FieldByName('ACTIVE_NAME').AsString<>'') then
          edtACTIVE_GROUP.DropList
       else
       begin
         DBGridEh1.SetFocus;
         edtACTIVE_GROUP.Visible := false;
         if cdsActive.FieldByName('ACTIVE_ID').AsString <> '' then
            Key := 0
       end;
     end;
  inherited;
end;

end.
