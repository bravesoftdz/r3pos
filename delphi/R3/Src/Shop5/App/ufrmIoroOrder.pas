unit ufrmIoroOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar, Grids,
  DBGridEh, zBase, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset;

const
  WM_INIT_RECORD=WM_USER+4;
  WM_DIALOG_PULL=WM_USER+1;
  WM_ADD_ITEMINFO=WM_USER+2;
type
  TfrmIoroOrder = class(TframeDialogForm)
    Panel1: TPanel;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edtIORO_DATE: TcxDateEdit;
    edtIORO_USER: TzrComboBoxList;
    Label7: TLabel;
    edtREMARK: TcxTextEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    DBGridEh1: TDBGridEh;
    edtITEM_ID: TzrComboBoxList;
    edtACCOUNT_ID: TzrComboBoxList;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    RzPanel4: TRzPanel;
    Shape1: TShape;
    lblCaption: TLabel;
    Image1: TImage;
    Label14: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure cdsDetailNewRecord(DataSet: TDataSet);
    procedure DBGridEh1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtCLIENT_IDAddClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N1Click(Sender: TObject);
    procedure edtACCOUNT_IDAddClick(Sender: TObject);
    procedure edtACCOUNT_IDSaveValue(Sender: TObject);
    procedure edtACCOUNT_IDExit(Sender: TObject);
    procedure edtACCOUNT_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtACCOUNT_IDEnter(Sender: TObject);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure edtITEM_IDSaveValue(Sender: TObject);
    procedure edtREMARKPropertiesChange(Sender: TObject);
    procedure edtIORO_USERSaveValue(Sender: TObject);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns2UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtIORO_DATEPropertiesChange(Sender: TObject);
    procedure edtACCOUNT_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtITEM_IDAddClick(Sender: TObject);
    procedure edtIORO_USERAddClick(Sender: TObject);
  private
    Fcid: string;
    FIoroType: integer;
    FisAudit: boolean;
    procedure Setcid(const Value: string);
    procedure FocusNextColumn;
    procedure SetIoroType(const Value: integer);
    procedure SetisAudit(const Value: boolean);
    { Private declarations }
  protected
    procedure SetdbState(const Value: TDataSetState); override;
    procedure WMInitRecord(var Message: TMessage); message WM_INIT_RECORD;
  public
    { Public declarations }
    AObj:TRecord_;
    RowID:Integer;
    locked:Boolean;
    procedure InitRecord;virtual;
    procedure Open(id:string);
    procedure Append;
    procedure Edit(id:string);
    procedure Check;
    procedure SaveOrder;
    procedure CancelOrder;
    procedure DeleteOrder;
    property cid:string read Fcid write Setcid;
    property IoroType:integer read FIoroType write SetIoroType;
    property isAudit:boolean read FisAudit write SetisAudit;
  end;

implementation
uses uGlobal,uShopUtil,uDsUtil,ufrmClientInfo,ufrmAccountInfo,ufrmCodeInfo,ufrmUsersInfo,
  uShopGlobal;
{$R *.dfm}

procedure TfrmIoroOrder.FocusNextColumn;
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
           if Trim(cdsDetail.FieldbyName('ACCOUNT_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(cdsDetail.FieldbyName('ACCOUNT_ID').asString)<>'') then
              begin
                 cdsDetail.Next ;
                 if cdsDetail.Eof then
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

procedure TfrmIoroOrder.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmIoroOrder.Open(id: string);
var
  Params:TftParamList;
begin
  locked:=True;
  try
  Params := TftParamList.Create(nil);
  try
    Factor.BeginBatch;
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('IORO_ID').asString := id;
      Params.ParamByName('IORO_TYPE').AsInteger := IoroType;
      Factor.AddBatch(cdsHeader,'TIoroOrder',Params);
      Factor.AddBatch(cdsDetail,'TIoroData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    cid := AObj.FieldbyName('GLIDE_NO').AsString;
    cdsDetail.DisableControls;
    try
       cdsDetail.Last;
       rowid := cdsDetail.FieldByName('SEQNO').AsInteger;
       cdsDetail.First;
    finally
       cdsDetail.EnableControls;
    end;
    isAudit := (AObj.FieldByName('CHK_DATE').AsString<>''); 
    dbState := dsBrowse;
    btnOk.Enabled := false;
  finally
    Params.Free;
  end;
  finally
    locked:=False;
  end;
end;

procedure TfrmIoroOrder.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  cid := Global.SHOP_ID;
  edtACCOUNT_ID.DataSet := Global.GeTZQueryFromName('ACC_ACCOUNT_INFO');
  edtITEM_ID.DataSet := Global.GeTZQueryFromName('ACC_ITEM_INFO');
  edtIORO_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');

end;

procedure TfrmIoroOrder.FormDestroy(Sender: TObject);
begin
  AObj.free;
  inherited;

end;

procedure TfrmIoroOrder.Append;
begin
  Open('');
  edtIORO_DATE.Date := date();
  edtIORO_USER.KeyValue := Global.UserId;
  edtIORO_USER.Text := Global.UserName;
  AObj.FieldbyName('IORO_ID').asString := TSequence.NewId();
  lblCaption.Caption :='单号:..新增..';
  edtITEM_ID.DataSet.Locate('CODE_ID',inttostr(IoroType),[]);
  edtITEM_ID.KeyValue := edtITEM_ID.DataSet.FieldbyName('CODE_ID').asString;
  edtITEM_ID.Text := edtITEM_ID.DataSet.FieldbyName('CODE_NAME').asString;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  dbState := dsInsert;
  InitRecord;
end;

procedure TfrmIoroOrder.CancelOrder;
begin

end;

procedure TfrmIoroOrder.Edit(id: string);
begin
  Open(id);
  dbState := dsEdit;
  InitRecord;
end;

procedure TfrmIoroOrder.SaveOrder;
var
  n:integer;
  totalfee:real;
begin
  if edtITEM_ID.AsString = '' then Raise Exception.Create('请选择科目名称');
  if edtIORO_DATE.EditValue = null then Raise Exception.Create('请选择日期');
  if edtIORO_USER.AsString = '' then Raise Exception.Create('负责人不能为空');
  Check;
  WriteToObject(AObj,self);
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  cdsHeader.Edit;
  AObj.WriteToDataSet(cdsHeader);
  cdsHeader.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsHeader.FieldbyName('IORO_TYPE').AsInteger := IoroType;
  cdsDetail.DisableControls;
  try
    n := 0;
    totalfee := 0;
    cdsDetail.First;
    while not cdsDetail.Eof do
      begin
        inc(n);
        cdsDetail.Edit;
        cdsDetail.FieldbyName('SHOP_ID').AsString :=  AObj.FieldbyName('SHOP_ID').AsString;
        cdsDetail.FieldbyName('IORO_TYPE').AsInteger := IoroType;
        cdsDetail.FieldbyName('SEQNO').AsInteger := n;
        cdsDetail.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
        cdsDetail.FieldbyName('IORO_ID').AsString := AObj.FieldbyName('IORO_ID').AsString;
        totalfee := totalfee + cdsDetail.FieldbyName('IORO_MNY').AsFloat;
        cdsDetail.Post;
        cdsDetail.Next;
      end;
  cdsHeader.FieldbyName('IORO_MNY').AsFloat := totalfee;
  cdsHeader.Post;
  finally
    cdsDetail.EnableControls;
  end;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TIoroOrder');
    Factor.AddBatch(cdsDetail,'TIoroData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
end;

procedure TfrmIoroOrder.Setcid(const Value: string);
begin
  Fcid := Value;
end;

procedure TfrmIoroOrder.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveOrder;
  OnSave(AObj);
  ModalResult := MROK;
end;

procedure TfrmIoroOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
begin
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsDetail.RecNo)),length(Inttostr(cdsDetail.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmIoroOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  DBGridEh1.ReadOnly := (Value=dsBrowse);
  btnOk.Visible := (Value<>dsBrowse);
  N1.Enabled:=(Value<>dsBrowse);
end;

procedure TfrmIoroOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除一张空单...');
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TIoroOrder');
    Factor.AddBatch(cdsDetail,'TIoroData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  dbState := dsBrowse;
end;

procedure TfrmIoroOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  edtACCOUNT_ID.Text := cdsDetail.FieldbyName('ACCOUNT_ID_TEXT').AsString;
  edtACCOUNT_ID.KeyValue := cdsDetail.FieldbyName('ACCOUNT_ID').AsString;

end;

procedure TfrmIoroOrder.WMInitRecord(var Message: TMessage);
begin
  InitRecord;
end;

procedure TfrmIoroOrder.InitRecord;
begin
  if dbState = dsBrowse then Exit;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  edtACCOUNT_ID.Visible := false;
  if DBGridEh1.CanFocus and Visible then DBGridEh1.SetFocus;
  cdsDetail.DisableControls;
  try
  cdsDetail.Last;
  if cdsDetail.IsEmpty or (cdsDetail.FieldbyName('ACCOUNT_ID').AsString <>'') then
    begin
      inc(RowID);
      cdsDetail.Append;
      cdsDetail.FieldByName('ACCOUNT_ID').Value := null;
      if cdsDetail.FindField('SEQNO')<> nil then
         cdsDetail.FindField('SEQNO').asInteger := RowID;
      cdsDetail.Post;
      cdsDetail.Edit;
    end;
  DbGridEh1.Col := 1 ;
  finally
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmIoroOrder.Check;
begin
  cdsDetail.DisableControls;
  try
    cdsDetail.First;
    while not cdsDetail.Eof do
      begin
        if cdsDetail.FieldbyName('ACCOUNT_ID').AsString = '' then cdsDetail.Delete 
        else
        begin
          if cdsDetail.FieldByName('IORO_INFO').AsString='' then Raise Exception.Create('摘要不能为空!');
          if (cdsDetail.FieldByName('IORO_MNY').AsString='0') then Raise Exception.Create('金额不能为0');
          cdsDetail.Next;
        end;
      end;
    if cdsDetail.IsEmpty then Raise Exception.Create('不能保存一张空单，请选择对应的账户名称'); 
  finally
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmIoroOrder.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       FocusNextColumn;
       Key := #0;
     end;
end;

procedure TfrmIoroOrder.cdsDetailNewRecord(DataSet: TDataSet);
begin
  inherited;
  if not cdsDetail.ControlsDisabled then InitRecord;
end;

procedure TfrmIoroOrder.DBGridEh1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Cell: TGridCoord;
begin
  inherited;
  Cell := DBGridEh1.MouseCoord(X,Y);
  if Cell.Y > DBGridEh1.VisibleRowCount-2 then
     InitRecord;
end;

procedure TfrmIoroOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if locked then exit;
end;

procedure TfrmIoroOrder.edtCLIENT_IDAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  AObj := TRecord_.Create;
  try
    if TfrmClientInfo.AddDialog(self,AObj) then
       begin
         edtCLIENT_ID.KeyValue :=AObj.FieldbyName('CLIENT_ID').AsString;
         edtCLIENT_ID.Text := AObj.FieldbyName('CLIENT_NAME').asString;
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmIoroOrder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  if btnOk.Enabled then
  begin
    try
      i:=MessageBox(Handle,pchar(Caption+'有修改，是否保存修改信息？'),pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
      if i=6 then
         begin
            SaveOrder;
            OnSave(AObj);
            ModalResult := MROK;
         end;
      if i=7 then ModalResult := MROK;
      if i=2 then abort;
    except
      CanClose := false;
      Raise;
    end;
  end;
end;

procedure TfrmIoroOrder.N1Click(Sender: TObject);
begin
  inherited;
  if cdsDetail.IsEmpty then exit;
  if cdsDetail.FieldByName('ACCOUNT_ID').AsString='' then exit;
  cdsDetail.Delete;
end;

procedure TfrmIoroOrder.edtACCOUNT_IDAddClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21100001',2) then Raise Exception.Create('你没有新增账户的权限,请和管理员联系.');
  AObj := TRecord_.Create;
  try
    if TfrmAccountInfo.AddDialog(self,AObj) then
       begin
         edtACCOUNT_ID.KeyValue :=AObj.FieldbyName('ACCOUNT_ID').AsString;
         edtACCOUNT_ID.Text := AObj.FieldbyName('ACCT_NAME').asString;
         edtACCOUNT_ID.OnSaveValue(nil);
       end;
  finally
    AObj.Free;
  end;
end;

procedure TfrmIoroOrder.SetIoroType(const Value: integer);
begin
  FIoroType := Value;
  case Value of
  1:begin
     edtCLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CUSTOMER');
     Label2.Caption := '客户名称';
     Caption := '其他收入';
    end;
  2:begin
     edtCLIENT_ID.DataSet:=Global.GetZQueryFromName('PUB_CLIENTINFO');
     Label2.Caption := '供应商名称';
     Caption := '其他支出';
    end;
  end;
end;

procedure TfrmIoroOrder.edtACCOUNT_IDSaveValue(Sender: TObject);
procedure EraseRecord;
var i:integer;
begin
  if cdsDetail.State = dsBrowse then cdsDetail.Edit;
  for i:=1 to cdsDetail.Fields.Count -1 do cdsDetail.Fields[i].Value := null;
  edtACCOUNT_ID.Text := '';
  edtACCOUNT_ID.KeyValue := null;
end;
var tmp:TZQuery;
begin
  inherited;
  if not cdsDetail.Active then Exit;
  if VarIsNull(edtACCOUNT_ID.KeyValue) then
  begin
    EraseRecord;
  end
  else
  begin
    cdsDetail.Edit;
    cdsDetail.FieldByName('ACCOUNT_ID').AsString := edtACCOUNT_ID.AsString;
    cdsDetail.FieldByName('ACCOUNT_ID_TEXT').AsString := edtACCOUNT_ID.Text;
    cdsDetail.FieldByName('IORO_MNY').AsString:='0';
  end;
  if not locked then   BtnOk.Enabled := true;
end;

procedure TfrmIoroOrder.edtACCOUNT_IDExit(Sender: TObject);
begin
  inherited;
  if not edtACCOUNT_ID.DropListed then edtACCOUNT_ID.Visible := false;

end;

procedure TfrmIoroOrder.edtACCOUNT_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;
       if cdsDetail.FieldbyName('ACCOUNT_ID').AsString = '' then
          begin
            edtACCOUNT_ID.DropList;
            Exit;
          end;
       FocusNextColumn;
       DBGridEh1.SetFocus;
     end;
end;

procedure TfrmIoroOrder.edtACCOUNT_IDEnter(Sender: TObject);
begin
  inherited;
  edtACCOUNT_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;

end;

procedure TfrmIoroOrder.edtCLIENT_IDSaveValue(Sender: TObject);
begin
  inherited;
  BtnOk.Enabled := true;
end;

procedure TfrmIoroOrder.edtITEM_IDSaveValue(Sender: TObject);
begin
  inherited;
  BtnOk.Enabled := true;

end;

procedure TfrmIoroOrder.edtREMARKPropertiesChange(Sender: TObject);
begin
  inherited;
  if not locked then   BtnOk.Enabled := true;

end;

procedure TfrmIoroOrder.edtIORO_USERSaveValue(Sender: TObject);
begin
  inherited;
  if not locked then   BtnOk.Enabled := true;

end;

procedure TfrmIoroOrder.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if not locked then   BtnOk.Enabled := true;

end;

procedure TfrmIoroOrder.DBGridEh1Columns2UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if not locked then   BtnOk.Enabled := true;

end;

procedure TfrmIoroOrder.edtIORO_DATEPropertiesChange(Sender: TObject);
begin
  inherited;
  if not locked then   BtnOk.Enabled := true;

end;

procedure TfrmIoroOrder.SetisAudit(const Value: boolean);
begin
  FisAudit := Value;
  Image1.Visible := Value;
  if dbState = dsBrowse then
     begin
       if Value then Label14.Caption := '状态:审核' else Label14.Caption := '状态:待审';
     end;
end;

procedure TfrmIoroOrder.edtACCOUNT_IDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key=VK_RIGHT) and not edtACCOUNT_ID.Edited then
     begin
       DBGridEh1.SetFocus;
       edtACCOUNT_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not edtACCOUNT_ID.DropListed then
     begin
       DBGridEh1.SetFocus;
       edtACCOUNT_ID.Visible := false;
       cdsDetail.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not edtACCOUNT_ID.DropListed then
     begin
       if (cdsDetail.FieldByName('SEQNO').AsString<>'') and (cdsDetail.FieldByName('ITEM_ID').AsString='') then
         edtACCOUNT_ID.DropList
       else
       begin
         DBGridEh1.SetFocus;
         edtACCOUNT_ID.Visible := false;
         cdsDetail.Next;
         if cdsDetail.Eof then
            PostMessage(Handle,WM_INIT_RECORD,0,0);
         if (cdsDetail.FieldByName('ITEM_ID').AsString <> '') then
            Key := 0;
       end;
     end;
  inherited;

end;

procedure TfrmIoroOrder.edtITEM_IDAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21200001',2) then Raise Exception.Create('你没有新增科目的权限,请和管理员联系.');
  r := TRecord_.Create;
  try
    if TfrmCodeInfo.AddDialog(self,r,3) then
       begin
         edtITEM_ID.KeyValue := r.FieldbyName('CODE_ID').AsString;
         edtITEM_ID.Text := r.FieldbyName('CODE_NAME').AsString;
       end;
  finally
    r.Free;
  end;
end;

procedure TfrmIoroOrder.edtIORO_USERAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('31500001',2) then Raise Exception.Create('你没有新增用户的权限,请和管理员联系.');
  r := TRecord_.Create;
  try
    if TfrmUsersInfo.AddDialog(self,r) then
       begin
         edtIORO_USER.KeyValue := r.FieldbyName('USER_ID').AsString;
         edtIORO_USER.Text := r.FieldbyName('USER_NAME').AsString;
       end;
  finally
    r.Free;
  end;
end;

end.
