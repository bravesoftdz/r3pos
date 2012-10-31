unit ufrmRecvOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxCurrencyEdit, Grids, DBGridEh, zBase, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmRecvOrder = class(TframeDialogForm)
    Panel1: TPanel;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    edtACCOUNT_ID: TzrComboBoxList;
    edtITEM_ID: TzrComboBoxList;
    Label6: TLabel;
    edtRECV_DATE: TcxDateEdit;
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
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    edtCLIENT_ID: TzrComboBoxList;
    Label3: TLabel;
    edtPAYM_ID: TcxComboBox;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    Label8: TLabel;
    edtBANK_CODE: TcxTextEdit;
    Label5: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    Label9: TLabel;
    edtBILL_NO: TcxTextEdit;
    BtnVoucher: TRzBitBtn;
    Label4: TLabel;
    cdsICGlide: TZQuery;
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
    procedure edtITEM_IDAddClick(Sender: TObject);
    procedure edtACCOUNT_IDAddClick(Sender: TObject);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure DBGridEh1Columns1UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure cdsDetailBeforeEdit(DataSet: TDataSet);
    procedure edtRECV_USERPropertiesChange(Sender: TObject);
    procedure edtPAYM_IDPropertiesChange(Sender: TObject);
    procedure edtBANK_CODEExit(Sender: TObject);
    procedure BtnVoucherClick(Sender: TObject);
    procedure edtACCOUNT_IDSaveValue(Sender: TObject);
  private
    Fcid: string;
    FisAudit: boolean;
    VoucherMny:Currency;
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
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,ufrmCodeInfo,ufrmAccountInfo,ufrmVhPayGlide,//ufrmFindReveAbleList,ufrmItemInfo,ufrmRecvAbleInfo,
  uShopGlobal;
{$R *.dfm}

procedure TfrmRecvOrder.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRecvOrder.Open(id: string);
var Params:TftParamList;
begin
  locked:=True;
  try
    Params := TftParamList.Create(nil);
    try
      Factor.BeginBatch;
      try
        Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
        Params.ParamByName('RECV_ID').asString := id;
        Params.ParamByName('SALES_ID').asString := id;
        Factor.AddBatch(cdsHeader,'TRecvOrder',Params);
        Factor.AddBatch(cdsDetail,'TRecvData',Params);
        Factor.AddBatch(cdsIcGlide,'TSalesICData',Params);
        Factor.OpenBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;
      edtSHOP_ID.Properties.ReadOnly := False;
      AObj.ReadFromDataSet(cdsHeader);
      ReadFromObject(AObj,self);
      dbState := dsBrowse;
      isAudit := (AObj.FieldByName('CHK_DATE').AsString <> ''); 
    finally
      Params.Free;
    end;
  finally
    locked:=False;
  end;
end;

procedure TfrmRecvOrder.FormCreate(Sender: TObject);
var
  idx:integer;
begin
  inherited;
  AObj := TRecord_.Create;
  cid := Global.SHOP_ID;
  edtACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  edtITEM_ID.DataSet := Global.GetZQueryFromName('ACC_ITEM_INFO');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  TdsItems.AddDataSetToItems(Global.GetZQueryFromName('PUB_PAYMENT'),edtPAYM_ID.Properties.Items,'CODE_NAME');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtDEPT_ID.RangeField := 'DEPT_TYPE';
  edtDEPT_ID.RangeValue := '1';
  idx := TdsItems.FindItems(edtPAYM_ID.Properties.Items,'CODE_ID','D');
  if idx<>-1 then
  begin
    edtPAYM_ID.Properties.Items.Objects[idx].Free;
    edtPAYM_ID.Properties.Items.Delete(idx);
  end;
//  TdsItems.AddDataSetToItems(Global.GetZQueryFromName('PUB_BANK_INFO'),edtBANK_ID.Properties.Items,'CODE_NAME');

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '收款仓库';
    end;
  VoucherMny := 0;
end;

procedure TfrmRecvOrder.FormDestroy(Sender: TObject);
begin
  AObj.free;
  inherited;

end;

procedure TfrmRecvOrder.Append;
var
  rs:TZQuery;
  i: Integer;
begin
  Open('');
  dbState := dsInsert;
  edtRECV_DATE.Date := Global.SysDate;
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
  AObj.FieldbyName('RECV_ID').asString := TSequence.NewId();
  lblCaption.Caption :='单号:..新增..';
  edtACCOUNT_ID.DataSet.Locate('ACCOUNT_ID',ShopGlobal.LoadFormatIni('cache','ACCOUNT_ID'),[]);
  edtACCOUNT_ID.KeyValue := edtACCOUNT_ID.DataSet.FieldbyName('ACCOUNT_ID').asString;
  edtACCOUNT_ID.Text := edtACCOUNT_ID.DataSet.FieldbyName('ACCT_NAME').asString;
  if edtPAYM_ID.Properties.Items.Count > 0 then
  begin
    i := TdsItems.FindItems(edtPAYM_ID.Properties.Items,'CODE_ID',edtACCOUNT_ID.DataSet.FieldbyName('PAYM_ID').asString);
    if i < 0 then
      edtPAYM_ID.ItemIndex := 0
    else
      edtPAYM_ID.ItemIndex := i;
  end;
  edtITEM_ID.DataSet.Locate('CODE_ID','1',[]);
  edtITEM_ID.KeyValue := edtITEM_ID.DataSet.FieldbyName('CODE_ID').asString;
  edtITEM_ID.Text := edtITEM_ID.DataSet.FieldbyName('CODE_NAME').asString;
  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
end;

procedure TfrmRecvOrder.CancelOrder;
begin

end;

procedure TfrmRecvOrder.Edit(id: string);
begin
  Open(id);
  dbState := dsEdit;
  btnOk.Enabled:=False;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;  
end;

procedure TfrmRecvOrder.SaveOrder;
var
  n:integer;
  rs:TZQuery;
  r:currency;
begin
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('请选择缴款门店');
  if edtACCOUNT_ID.AsString = '' then Raise Exception.Create('请选择帐户名称');
  if edtPAYM_ID.ItemIndex<0 then Raise Exception.Create('请选择收款方式名称');
  if edtITEM_ID.AsString = '' then Raise Exception.Create('请选择收支科目名称');
  if edtRECV_DATE.EditValue = null then Raise Exception.Create('请选择收款日期');
  if edtBANK_CODE.Visible and (ShopGlobal.GetParameter('BANK_CODE')='1') then
     begin
       if trim(edtBANK_CODE.Text) = '' then Raise Exception.Create('请选择输入银行卡号');
     end;
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('所属部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create(Label40.Caption+'不能为空');
  WriteToObject(AObj,self);
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  AObj.FieldByName('RECV_USER').AsString := Global.UserID;
  AObj.FieldByName('RECV_FLAG').AsString := '0';
  cdsHeader.Edit;
  AObj.WriteToDataSet(cdsHeader);
  cdsHeader.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cdsHeader.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  if (cdsHeader.FieldbyName('PAYM_ID').asString='C') and (ShopGlobal.NetVersion or ShopGlobal.ONLVersion) and ShopGlobal.offline then Raise Exception.Create('脱机状态不能使用储值卡支付...');
  cdsDetail.DisableControls;
  try
    n := 0;
    r := 0;
    cdsDetail.First;
    while not cdsDetail.Eof do
      begin
        if (cdsDetail.FieldByName('RECV_MNY').AsFloat=0)
        then
           cdsDetail.Next
        else
           begin
            inc(n);
            cdsDetail.Edit;
            cdsDetail.FieldbyName('ACCOUNT_ID').AsString := AObj.FieldbyName('ACCOUNT_ID').AsString;
            cdsDetail.FieldbyName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
            cdsDetail.FieldbyName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
            cdsDetail.FieldbyName('SEQNO').AsInteger := n;
            cdsDetail.FieldbyName('RECV_ID').AsString := AObj.FieldbyName('RECV_ID').AsString;
            r := r + cdsDetail.FieldbyName('RECV_MNY').AsFloat;
            cdsDetail.Post;
            cdsDetail.Next;
           end;
      end;
  finally
    cdsDetail.EnableControls;
  end;
  cdsHeader.FieldbyName('RECV_MNY').AsFloat := r;
  cdsHeader.Post;
  cdsIcGlide.first;
  while not cdsIcGlide.eof do cdsIcGlide.delete;
  if cdsHeader.FieldbyName('PAYM_ID').asString='C' then
     begin
       cdsIcGlide.Append;
       cdsIcGlide.FieldbyName('GLIDE_ID').AsString := TSequence.NewId();
       cdsIcGlide.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
       cdsIcGlide.FieldbyName('SALES_ID').asString := cdsHeader.FieldbyName('RECV_ID').asString;
       cdsICGlide.FieldByName('CREA_DATE').asInteger := cdsHeader.FieldbyName('RECV_DATE').asInteger;
       cdsIcGlide.FieldbyName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').asString;
       cdsIcGlide.FieldbyName('CLIENT_ID').AsString := cdsHeader.FieldbyName('CLIENT_ID').asString;
       cdsIcGlide.FieldbyName('IC_GLIDE_TYPE').AsString := '2';
       cdsIcGlide.FieldbyName('GLIDE_INFO').AsString := '储值卡支付-批发';
       cdsIcGlide.FieldbyName('CREA_USER').AsString := Global.UserID;
       rs := Global.GetZQueryFromName('PUB_CUSTOMER');
       if rs.Locate('CLIENT_ID',cdsHeader.FieldbyName('CLIENT_ID').asString,[]) then
          cdsIcGlide.FieldbyName('IC_CARDNO').AsString := rs.FieldbyName('CLIENT_CODE').AsString
       else
          Raise Exception.Create('没有找到当前客户的储值卡,无法支付'); 
       cdsIcGlide.FieldbyName('PAY_C').asFloat := cdsHeader.FieldbyName('RECV_MNY').AsFloat;
       cdsIcGlide.FieldbyName('GLIDE_MNY').asFloat := cdsHeader.FieldbyName('RECV_MNY').AsFloat;
       cdsIcGlide.Post;
     end;
  //if (cdsHeader.FieldbyName('PAYM_ID').AsString='G') and (r > VoucherMny) and (r<>0) then
  //begin
  //   if MessageBox(Handle,'收款总额与礼券总额不相等,是否保存!',pchar(Application.Title),MB_YESNOCANCEL+MB_ICONINFORMATION) <> 6 then Exit;
  //end;
  if n=0 then Raise Exception.Create('没有收款记录，不能保存...');
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TRecvOrder');
    Factor.AddBatch(cdsDetail,'TRecvData');
    Factor.AddBatch(cdsIcGlide,'TSalesICData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
  if Assigned(OnSave) then OnSave(AObj);
end;

procedure TfrmRecvOrder.Setcid(const Value: string);
begin
  Fcid := Value;
end;

procedure TfrmRecvOrder.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveOrder;
  //ShopGlobal.SaveFormatIni('cache','PAYM_ID',TRecord_(edtPAYM_ID.Properties.Items.Objects[edtPAYM_ID.ItemIndex]).FieldbyName('CODE_ID').AsString);
  ShopGlobal.SaveFormatIni('cache','ACCOUNT_ID',edtACCOUNT_ID.DataSet.FieldByName('ACCOUNT_ID').AsString);
  ModalResult := MROK;
end;

procedure TfrmRecvOrder.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmRecvOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  DBGridEh1.ReadOnly := (Value=dsBrowse);
  btnOk.Visible:=(dbState<>dsBrowse);
  case Value of
  dsInsert:begin
     Caption := '收款单--(新增)';
     Label14.Caption := '状态:新增';
  end;
  dsEdit:begin
     Caption := '收款单--(修改)';
     Label14.Caption := '状态:修改';
  end;
  else
      begin
        Caption := '收款单';
        Label14.Caption := '状态:查看';
      end;
  end;
end;

procedure TfrmRecvOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除一张空单...');
  if (cdsHeader.FieldbyName('PAYM_ID').asString='C') and (ShopGlobal.NetVersion or ShopGlobal.ONLVersion) and ShopGlobal.offline then Raise Exception.Create('脱机状态不能删除储值卡支付的单据...');
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  cdsIcGlide.first;
  while not cdsIcGlide.eof do cdsIcGlide.delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TRecvOrder');
    Factor.AddBatch(cdsDetail,'TRecvData');
    Factor.AddBatch(cdsIcGlide,'TSalesICData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
end;


procedure TfrmRecvOrder.DBGridEh1Columns4EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  inherited;
//  RecvFind;
end;

procedure TfrmRecvOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
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

procedure TfrmRecvOrder.edtACCOUNT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvOrder.edtITEM_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvOrder.edtRECV_DATEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvOrder.edtREMARKPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvOrder.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  TColumnEh(Sender).Field.AsFloat := Value;
  Calc;
  if locked then exit;
  btnOk.Enabled:=True;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  cdsDetail.Edit;
  if (cdsDetail.FieldByName('RECV_MNY').AsFloat<>0) then
     cdsDetail.FieldbyName('A').AsString := '1'
  else
     cdsDetail.FieldbyName('A').AsString := '0'
end;

procedure TfrmRecvOrder.FormCloseQuery(Sender: TObject;
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

procedure TfrmRecvOrder.edtITEM_IDAddClick(Sender: TObject);
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

procedure TfrmRecvOrder.edtACCOUNT_IDAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21100001',2) then Raise Exception.Create('你没有新增账户的权限,请和管理员联系.');
  r := TRecord_.Create;
  try
    if TfrmAccountInfo.AddDialog(self,r) then
       begin
         edtACCOUNT_ID.KeyValue := r.FieldbyName('ACCOUNT_ID').AsString;
         edtACCOUNT_ID.Text := r.FieldbyName('ACCT_NAME').AsString;
       end;
  finally
    r.Free;
  end;  
end;

procedure TfrmRecvOrder.FillData;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  cdsDetail.DisableControls;
  try
    rs.Close;
    rs.SQL.Text :=
       'select A.ABLE_ID,A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,B.CLIENT_NAME as CLIENT_ID_TEXT,A.ACCT_INFO,A.RECV_TYPE,A.ACCT_MNY,A.RECV_MNY,A.RECK_MNY,A.ABLE_DATE,A.NEAR_DATE,C.SHOP_NAME as SHOP_ID_TEXT '+
       'from ACC_RECVABLE_INFO A,VIW_CUSTOMER B,CA_SHOP_INFO C where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CLIENT_ID='''+edtCLIENT_ID.asString+''' and A.RECK_MNY<>0 and A.RECV_TYPE<>''4'' order by ABLE_ID';
    Factor.Open(rs);
    cdsDetail.First;
    while not cdsDetail.Eof do cdsDetail.Delete;
    rs.first;
    while not rs.eof do
      begin
        cdsDetail.Append;
        cdsDetail.FieldByName('A').AsString := '0';
        cdsDetail.FieldByName('ABLE_ID').AsString := rs.FieldbyName('ABLE_ID').AsString;
        cdsDetail.FieldByName('ACCT_INFO').AsString := rs.FieldbyName('ACCT_INFO').AsString;
        cdsDetail.FieldByName('RECV_TYPE').AsString := rs.FieldbyName('RECV_TYPE').AsString;
        cdsDetail.FieldByName('ACCT_MNY').asFloat := rs.FieldbyName('ACCT_MNY').asFloat;
        cdsDetail.FieldByName('RECK_MNY').asFloat := rs.FieldbyName('RECK_MNY').asFloat;
        cdsDetail.FieldByName('RECV_MNY').asFloat := 0;
        cdsDetail.FieldByName('BALA_MNY').asFloat := rs.FieldbyName('RECK_MNY').asFloat;
        cdsDetail.FieldByName('ABLE_DATE').AsString := rs.FieldbyName('ABLE_DATE').AsString;
        cdsDetail.FieldByName('CLIENT_ID').AsString := rs.FieldbyName('CLIENT_ID').AsString;
        cdsDetail.FieldByName('CLIENT_ID_TEXT').AsString := rs.FieldbyName('CLIENT_ID_TEXT').AsString;
        cdsDetail.FieldByName('SHOP_ID').AsString := rs.FieldbyName('SHOP_ID').AsString;
        cdsDetail.FieldByName('SHOP_ID_TEXT').AsString := rs.FieldbyName('SHOP_ID_TEXT').AsString;
        cdsDetail.Post;
        rs.next;
      end;
    if cdsDetail.IsEmpty then MessageBox(Handle,'当前选择的客户没有待付账款。','友情提示...',MB_OK+MB_ICONINFORMATION);
  finally
    rs.free;
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmRecvOrder.edtCLIENT_IDSaveValue(Sender: TObject);
begin
  inherited;
  FillData;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvOrder.Calc;
begin
  cdsDetail.Edit;
  cdsDetail.FieldbyName('BALA_MNY').AsFloat := cdsDetail.FieldbyName('RECK_MNY').AsFloat
                                              -cdsDetail.FieldbyName('RECV_MNY').AsFloat;
end;

procedure TfrmRecvOrder.DBGridEh1Columns1UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if Value=0 then
     begin
       cdsDetail.FieldByName('RECV_MNY').AsString := '0';
       cdsDetail.FieldByName('BALA_MNY').AsString := cdsDetail.FieldByName('RECK_MNY').AsString;
     end
  else
     begin
       cdsDetail.FieldByName('RECV_MNY').AsString := cdsDetail.FieldByName('RECK_MNY').AsString;
       cdsDetail.FieldByName('BALA_MNY').AsString := '0';
     end;
end;

procedure TfrmRecvOrder.cdsDetailBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;

end;

procedure TfrmRecvOrder.edtRECV_USERPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;

end;

procedure TfrmRecvOrder.SetisAudit(const Value: boolean);
begin
  FisAudit := Value;
  Image1.Visible := Value;
  if dbState = dsBrowse then
     begin
       if Value then Label14.Caption := '状态:审核' else Label14.Caption := '状态:待审';
     end;
end;

procedure TfrmRecvOrder.edtPAYM_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if edtPAYM_ID.ItemIndex<0 then Exit;
//  edtBANK_ID.Visible := (TRecord_(edtPAYM_ID.Properties.Items.Objects[edtPAYM_ID.ItemIndex]).FieldByName('CODE_ID').AsString = 'B');
  edtBANK_CODE.Visible := (TRecord_(edtPAYM_ID.Properties.Items.Objects[edtPAYM_ID.ItemIndex]).FieldByName('CODE_ID').AsString = 'B');
//  Label5.Visible := (TRecord_(edtPAYM_ID.Properties.Items.Objects[edtPAYM_ID.ItemIndex]).FieldByName('CODE_ID').AsString = 'B');
  Label8.Visible := (TRecord_(edtPAYM_ID.Properties.Items.Objects[edtPAYM_ID.ItemIndex]).FieldByName('CODE_ID').AsString = 'B');

  BtnVoucher.Visible := (TRecord_(edtPAYM_ID.Properties.Items.Objects[edtPAYM_ID.ItemIndex]).FieldByName('CODE_ID').AsString = 'G');
  Label4.Visible := (TRecord_(edtPAYM_ID.Properties.Items.Objects[edtPAYM_ID.ItemIndex]).FieldByName('CODE_ID').AsString = 'G');

end;

procedure TfrmRecvOrder.edtBANK_CODEExit(Sender: TObject);
function GetCheckNo: string;
begin
  result := trim(edtBANK_CODE.Text);
       if pos('=',result)>0 then
          begin
            result := copy(result,1,pos('=',result)-1);
          end;
       if not FnString.CheckBankCode(result) then
          begin
            edtBANK_CODE.SetFocus;
            Raise Exception.Create('请输入银行卡号无效，请重新刷卡...');
          end;
end;
begin
  inherited;
  if trim(edtBANK_CODE.Text)='' then Exit;
  edtBANK_CODE.Text := GetCheckNo;
end;

procedure TfrmRecvOrder.BtnVoucherClick(Sender: TObject);
var SumMny:Currency;
begin
  inherited;
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('客户名称不能为空!');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create('门店不能为空!');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('部门不能为空!');
  SumMny := 0;
  cdsDetail.DisableControls;
  try
    cdsDetail.First;
    while not cdsDetail.Eof do
    begin
      SumMny := SumMny + cdsDetail.FieldByName('ACCT_MNY').AsFloat;
      cdsDetail.Next;
    end;
  finally
    cdsDetail.EnableControls;
  end;
  VoucherMny := VoucherMny + TfrmVhPayGlide.ScanBarcode(Self,AObj.FieldbyName('RECV_ID').asString,edtSHOP_ID.AsString,edtDEPT_ID.AsString,edtCLIENT_ID.AsString,SumMny);
  Label4.Caption := '金额:'+FloatToStr(VoucherMny);
end;

procedure TfrmRecvOrder.edtACCOUNT_IDSaveValue(Sender: TObject);
begin
  inherited;
  if edtACCOUNT_ID.AsString = '' then Exit; 
  edtPAYM_ID.ItemIndex := TdsItems.FindItems(edtPAYM_ID.Properties.Items,'CODE_ID',edtACCOUNT_ID.DataSet.FieldByName('PAYM_ID').AsString);

end;

end.
