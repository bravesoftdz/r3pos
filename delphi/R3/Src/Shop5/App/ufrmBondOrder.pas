unit ufrmBondOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxCurrencyEdit, Grids, DBGridEh, zBase, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmBondOrder = class(TframeDialogForm)
    Panel1: TPanel;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label6: TLabel;
    edtBOND_DATE: TcxDateEdit;
    Label7: TLabel;
    edtREMARK: TcxTextEdit;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    Label17: TLabel;
    actAddRecvAbleInfo: TAction;
    RzPanel4: TRzPanel;
    Shape1: TShape;
    lblCaption: TLabel;
    Image1: TImage;
    Label14: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    Label3: TLabel;
    edtBOND_TYPE: TcxComboBox;
    Label40: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    Label1: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    Label2: TLabel;
    edtBOND_USER: TzrComboBoxList;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtACCOUNT_IDPropertiesChange(Sender: TObject);
    procedure edtITEM_IDPropertiesChange(Sender: TObject);
    procedure edtRECV_DATEPropertiesChange(Sender: TObject);
    procedure edtREMARKPropertiesChange(Sender: TObject);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure cdsDetailBeforeEdit(DataSet: TDataSet);
    procedure edtRECV_USERPropertiesChange(Sender: TObject);
    procedure edtBOND_TYPEPropertiesChange(Sender: TObject);
  private
    Fcid: string;
    FisAudit: boolean;
    procedure Setcid(const Value: string);
    procedure SetisAudit(const Value: boolean);
    { Private declarations }
  protected
    procedure SetdbState(const Value: TDataSetState); override;
  public
    { Public declarations }
    AObj:TRecord_;
    locked:Boolean;
    procedure Calc;
    procedure Open(id:string);
    procedure Append;
    procedure Edit(id:string);
    procedure FillData;
    procedure SaveOrder;
    procedure CancelOrder;
    procedure DeleteOrder;
    property cid:string read Fcid write Setcid;
    property isAudit:boolean read FisAudit write SetisAudit;
  end;

implementation
uses uGlobal,ObjCommon,uShopUtil,uFnUtil,uDsUtil,uShopGlobal;
{$R *.dfm}

procedure TfrmBondOrder.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBondOrder.Open(id: string);
var Params:TftParamList;
begin
  locked:=True;
  try
    Params := TftParamList.Create(nil);
    try
      Factor.BeginBatch;
      try
        Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
        Params.ParamByName('BOND_ID').asString := id;
        Factor.AddBatch(cdsHeader,'TBondOrder',Params);
        Factor.AddBatch(cdsDetail,'TBondData',Params);
        Factor.OpenBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;
      dbState := dsBrowse;
      edtSHOP_ID.Properties.ReadOnly := False;
      AObj.ReadFromDataSet(cdsHeader);
      ReadFromObject(AObj,self);
      isAudit := (AObj.FieldByName('CHK_DATE').AsString <> '');
    finally
      Params.Free;
    end;
  finally
    locked:=False;
  end;
end;

procedure TfrmBondOrder.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  cid := Global.SHOP_ID;
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtDEPT_ID.RangeField := 'DEPT_TYPE';
  edtDEPT_ID.RangeValue := '1';
  edtBOND_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label1.Caption := '所属仓库';
    end;
end;

procedure TfrmBondOrder.FormDestroy(Sender: TObject);
begin
  AObj.free;
  inherited;

end;

procedure TfrmBondOrder.Append;
var
  rs:TZQuery;
  i: Integer;
begin
  Open('');
  dbState := dsInsert;
  edtBOND_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;

//  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
//  begin
//    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
//    edtSHOP_ID.Properties.ReadOnly := True;
//  end;
  AObj.FieldbyName('BOND_ID').asString := TSequence.NewId();
  edtBOND_USER.KeyValue := Global.UserID;
  edtBOND_USER.Text := Global.UserName;
  lblCaption.Caption :='单号:..新增..';
  if edtBOND_TYPE.Properties.Items.Count > 0 then
  begin
    i := TdsItems.FindItems(edtBOND_TYPE.Properties.Items,'CODE_ID',ShopGlobal.LoadFormatIni('cache','BOND_TYPE'));
    if i < 0 then
      edtBOND_TYPE.ItemIndex := 0
    else
      edtBOND_TYPE.ItemIndex := i;
  end;
  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
end;

procedure TfrmBondOrder.CancelOrder;
begin

end;

procedure TfrmBondOrder.Edit(id: string);
begin
  Open(id);
  dbState := dsEdit;
  btnOk.Enabled:=False;
  SetEditStyle(dsBrowse,edtBOND_TYPE.Style);
  edtBOND_TYPE.Properties.ReadOnly := True;
//  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
//  begin
//    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
//    edtSHOP_ID.Properties.ReadOnly := True;
//  end;
end;

procedure TfrmBondOrder.SaveOrder;
var
  n:integer;
  rs:TZQuery;
  r:real;
begin
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('请选择缴款门店');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('请选择所属部门');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create('请选择所属门店');
  if edtBOND_TYPE.ItemIndex<0 then Raise Exception.Create('请选择保证金类型不能为空');
  if edtBOND_DATE.EditValue = null then Raise Exception.Create('请选择申请日期');
  WriteToObject(AObj,self);
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  cdsHeader.Edit;
  AObj.WriteToDataSet(cdsHeader);
  cdsHeader.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cdsHeader.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsDetail.DisableControls;
  try
    n := 0;
    r := 0;
    cdsDetail.First;
    while not cdsDetail.Eof do
      begin
        if (cdsDetail.FieldByName('BOND_MNY').AsFloat=0)
        then
           cdsDetail.Next
        else
           begin
            inc(n);
            cdsDetail.Edit;
            cdsDetail.FieldbyName('BOND_TYPE').AsString := AObj.FieldbyName('BOND_TYPE').AsString;
            cdsDetail.FieldbyName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
            cdsDetail.FieldbyName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
            cdsDetail.FieldbyName('SEQNO').AsInteger := n;
            cdsDetail.FieldbyName('BOND_ID').AsString := AObj.FieldbyName('BOND_ID').AsString;
            r := r + cdsDetail.FieldbyName('BOND_MNY').AsFloat;
            cdsDetail.Post;
            cdsDetail.Next;
           end;
      end;
  finally
    cdsDetail.EnableControls;
  end;
  cdsHeader.FieldbyName('BOND_MNY').AsFloat := r;
  cdsHeader.Post;
  if n=0 then Raise Exception.Create('没有申请记录，不能保存...');
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TBondOrder');
    Factor.AddBatch(cdsDetail,'TBondData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
  if Assigned(OnSave) then OnSave(AObj);
end;

procedure TfrmBondOrder.Setcid(const Value: string);
begin
  Fcid := Value;
end;

procedure TfrmBondOrder.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveOrder;
  ShopGlobal.SaveFormatIni('cache','BOND_TYPE',TRecord_(edtBOND_TYPE.Properties.Items.Objects[edtBOND_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString);
  ModalResult := MROK;
end;

procedure TfrmBondOrder.DBGridEh1DrawColumnCell(Sender: TObject;
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsDetail.RecNo)),length(Inttostr(cdsDetail.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmBondOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  DBGridEh1.ReadOnly := (Value=dsBrowse);
  btnOk.Visible:=(dbState<>dsBrowse);
  case Value of
  dsInsert:begin
     Caption := '保证金申领--(新增)';
     Label14.Caption := '状态:新增';
  end;
  dsEdit:begin
     Caption := '保证金申领--(修改)';
     Label14.Caption := '状态:修改';
  end;
  else
      begin
        Caption := '保证金申领';
        Label14.Caption := '状态:查看';
      end;
  end;
end;

procedure TfrmBondOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除一张空单...');
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TBondOrder');
    Factor.AddBatch(cdsDetail,'TBondData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
end;


procedure TfrmBondOrder.DBGridEh1Columns4EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  inherited;
//  RecvFind;
end;

procedure TfrmBondOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
{  TColumnEh(Sender).Field.Value := Value;
  if cdsDetail.FieldByName('REV_ID').AsString ='' then
     begin
       RecvFind;
       Value := TColumnEh(Sender).Field.Value;
       Text := TColumnEh(Sender).Field.Text;
    end;
  Calc;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  cdsDetail.Edit;
  if (cdsDetail.FieldByName('REV_MNY').AsFloat<>0) or (cdsDetail.FieldByName('RECV_MNY').AsFloat<>0) then
     cdsDetail.FieldbyName('A').AsString := '1'
  else
     cdsDetail.FieldbyName('A').AsString := '0';
  if cdsDetail.FieldbyName('RECV_MNY').AsFloat<>0 then
  cdsDetail.FieldbyName('RECV_MNY').AsFloat := cdsDetail.FieldbyName('RECK_MNY').AsFloat-cdsDetail.FieldbyName('REV_MNY').AsFloat;   }
end;

procedure TfrmBondOrder.edtACCOUNT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmBondOrder.edtITEM_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmBondOrder.edtRECV_DATEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmBondOrder.edtREMARKPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmBondOrder.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  TColumnEh(Sender).Field.AsFloat := Value;
  Calc;
  if locked then exit;
  btnOk.Enabled:=True;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  cdsDetail.Edit;
  if (cdsDetail.FieldByName('BOND_MNY').AsFloat<>0) then
     cdsDetail.FieldbyName('A').AsString := '1'
  else
     cdsDetail.FieldbyName('A').AsString := '0'
end;

procedure TfrmBondOrder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  if btnOk.Enabled then
  begin
    try
      i:=MessageBox(Handle,'收款单有修改，是否保存修改信息？',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmBondOrder.FillData;
var
  rs:TZQuery;
begin
  if edtBOND_TYPE.ItemIndex<0 then Exit;
  rs := TZQuery.Create(nil);
  cdsDetail.DisableControls;
  try
    case TRecord_(edtBOND_TYPE.Properties.Items.Objects[edtBOND_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsInteger of
    1:begin
        rs.Close;
        rs.SQL.Text :=
        ParseSQL(Factor.iDbType ,
           'select A.PLAN_ID as FROM_ID,A.TENANT_ID,A.SHOP_ID,A.GLIDE_NO,A.DEPT_ID,B.DEPT_NAME as DEPT_ID_TEXT,A.GLIDE_NO,A.BOND_MNY as ACCT_MNY,A.BOND_RET,isnull(A.BOND_MNY,0)-isnull(A.BOND_RET,0) as RECK_MNY,'+
           'A.PLAN_DATE as ABLE_DATE,C.SHOP_NAME as SHOP_ID_TEXT '+
           'from MKT_PLANORDER A,CA_DEPT_INFO B,CA_SHOP_INFO C where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.DEPT_ID=B.DEPT_ID and '+
           'A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CLIENT_ID='''+edtCLIENT_ID.asString+''' and (isnull(A.BOND_MNY,0)-isnull(A.BOND_RET,0))<>0 order by A.PLAN_DATE');
        Factor.Open(rs);
      end;
    2:begin
        rs.Close;
        rs.SQL.Text :=
        ParseSQL(Factor.iDbType ,
           'select A.INDE_ID as FROM_ID,A.TENANT_ID,A.SHOP_ID,A.GLIDE_NO,A.DEPT_ID,B.DEPT_NAME as DEPT_ID_TEXT,A.GLIDE_NO,A.BOND_MNY as ACCT_MNY,A.BOND_RET,isnull(A.BOND_MNY,0)-isnull(A.BOND_RET,0) as RECK_MNY,'+
           'A.INDE_DATE as ABLE_DATE,C.SHOP_NAME as SHOP_ID_TEXT '+
           'from SAL_INDENTORDER A,CA_DEPT_INFO B,CA_SHOP_INFO C where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.DEPT_ID=B.DEPT_ID and '+
           'A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CLIENT_ID='''+edtCLIENT_ID.asString+''' and (isnull(A.BOND_MNY,0)-isnull(A.BOND_RET,0))<>0 order by A.INDE_DATE');
        Factor.Open(rs);
      end;
    end;
    cdsDetail.First;
    while not cdsDetail.Eof do cdsDetail.Delete;
    rs.first;
    while not rs.eof do                         
      begin
        cdsDetail.Append;
        cdsDetail.FieldByName('A').AsString := '0';
        cdsDetail.FieldByName('FROM_ID').AsString := rs.FieldbyName('FROM_ID').AsString;
        cdsDetail.FieldByName('REMARK').AsString := edtBOND_TYPE.Text+'(订单号:'+rs.FieldbyName('GLIDE_NO').AsString+')';
        cdsDetail.FieldByName('BOND_TYPE').AsString := TRecord_(edtBOND_TYPE.Properties.Items.Objects[edtBOND_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString;
        cdsDetail.FieldByName('ACCT_MNY').asFloat := rs.FieldbyName('ACCT_MNY').asFloat;
        cdsDetail.FieldByName('RECK_MNY').asFloat := rs.FieldbyName('RECK_MNY').asFloat;
        cdsDetail.FieldByName('BOND_MNY').asFloat := 0;
        cdsDetail.FieldByName('BALA_MNY').asFloat := rs.FieldbyName('RECK_MNY').asFloat;
        cdsDetail.FieldByName('ABLE_DATE').AsString := rs.FieldbyName('ABLE_DATE').AsString;
        cdsDetail.FieldByName('DEPT_ID').AsString := rs.FieldbyName('DEPT_ID').AsString;
        cdsDetail.FieldByName('DEPT_ID_TEXT').AsString := rs.FieldbyName('DEPT_ID_TEXT').AsString;
        cdsDetail.FieldByName('SHOP_ID').AsString := rs.FieldbyName('SHOP_ID').AsString;
        cdsDetail.FieldByName('SHOP_ID_TEXT').AsString := rs.FieldbyName('SHOP_ID_TEXT').AsString;
        cdsDetail.Post;
        rs.next;
      end;
    if cdsDetail.IsEmpty then MessageBox(Handle,'当前选择的客户没有可用的保证金余额。','友情提示...',MB_OK+MB_ICONINFORMATION);
  finally
    rs.free;
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmBondOrder.edtCLIENT_IDSaveValue(Sender: TObject);
begin
  inherited;
  FillData;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmBondOrder.Calc;
begin
  cdsDetail.Edit;
  cdsDetail.FieldbyName('BALA_MNY').AsFloat := cdsDetail.FieldbyName('RECK_MNY').AsFloat
                                              -cdsDetail.FieldbyName('BOND_MNY').AsFloat;
end;

procedure TfrmBondOrder.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if Value=0 then
     begin
       cdsDetail.FieldByName('BOND_MNY').AsString := '0';
       cdsDetail.FieldByName('BALA_MNY').AsString := cdsDetail.FieldByName('RECK_MNY').AsString;
     end
  else
     begin
       cdsDetail.FieldByName('BOND_MNY').AsString := cdsDetail.FieldByName('RECK_MNY').AsString;
       cdsDetail.FieldByName('BALA_MNY').AsString := '0';
     end;
end;

procedure TfrmBondOrder.cdsDetailBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;

end;

procedure TfrmBondOrder.edtRECV_USERPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;

end;

procedure TfrmBondOrder.SetisAudit(const Value: boolean);
begin
  FisAudit := Value;
  Image1.Visible := Value;
  if dbState = dsBrowse then
     begin
       if Value then Label14.Caption := '状态:审核' else Label14.Caption := '状态:待审';
     end;
end;

procedure TfrmBondOrder.edtBOND_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  if not Visible then Exit;
  if dbState <> dsBrowse then  edtCLIENT_IDSaveValue(edtCLIENT_ID);
end;

end.
