unit ufrmRecvPosOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxCurrencyEdit, Grids, DBGridEh, zBase, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmRecvPosOrder = class(TframeDialogForm)
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
    actAddRecvAbleInfo: TAction;
    RzPanel4: TRzPanel;
    Shape1: TShape;
    lblCaption: TLabel;
    Image1: TImage;
    Label14: TLabel;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    Label3: TLabel;
    edtPAYM_ID: TcxComboBox;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    Label4: TLabel;
    edtBILL_NO: TcxTextEdit;
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
    procedure edtSHOP_IDSaveValue(Sender: TObject);
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
    procedure ClearPayment;
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
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,ufrmCodeInfo,ufrmAccountInfo,//ufrmFindReveAbleList,ufrmItemInfo,ufrmRecvAbleInfo,
  uShopGlobal;
{$R *.dfm}

procedure TfrmRecvPosOrder.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRecvPosOrder.Open(id: string);
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
        Factor.AddBatch(cdsHeader,'TRecvOrder',Params);
        Factor.AddBatch(cdsDetail,'TRecvData',Params);
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

procedure TfrmRecvPosOrder.FormCreate(Sender: TObject);
var idx:Integer;
begin
  inherited;
  AObj := TRecord_.Create;
  cid := Global.SHOP_ID;
  edtACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  edtITEM_ID.DataSet := Global.GetZQueryFromName('ACC_ITEM_INFO');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
//  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  TdsItems.AddDataSetToItems(Global.GetZQueryFromName('PUB_PAYMENT'),edtPAYM_ID.Properties.Items,'CODE_NAME');
  idx := TdsItems.FindItems(edtPAYM_ID.Properties.Items,'CODE_ID','C');
  if idx<>-1 then
  begin
    edtPAYM_ID.Properties.Items.Objects[idx].Free;
    edtPAYM_ID.Properties.Items.Delete(idx);
  end;
  idx := TdsItems.FindItems(edtPAYM_ID.Properties.Items,'CODE_ID','D');
  if idx<>-1 then
  begin
    edtPAYM_ID.Properties.Items.Objects[idx].Free;
    edtPAYM_ID.Properties.Items.Delete(idx);
  end;
  idx := TdsItems.FindItems(edtPAYM_ID.Properties.Items,'CODE_ID','G');
  if idx<>-1 then
  begin
    edtPAYM_ID.Properties.Items.Objects[idx].Free;
    edtPAYM_ID.Properties.Items.Delete(idx);
  end;
//  TdsItems.AddDataSetToItems(Global.GetZQueryFromName('PUB_BANK_INFO'),edtBANK_ID.Properties.Items,'CODE_NAME');
end;

procedure TfrmRecvPosOrder.FormDestroy(Sender: TObject);
begin
  AObj.free;
  inherited;

end;

procedure TfrmRecvPosOrder.Append;
var
  rs:TZQuery;
  i: Integer;
begin
  Open('');
  dbState := dsInsert;
  edtRECV_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;

  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;
  AObj.FieldbyName('RECV_ID').asString := TSequence.NewId();
  lblCaption.Caption :='����:..����..';
  if edtPAYM_ID.Properties.Items.Count > 0 then
  begin
    i := TdsItems.FindItems(edtPAYM_ID.Properties.Items,'CODE_ID',ShopGlobal.LoadFormatIni('cache','PAYM_ID'));
    if i < 0 then
      edtPAYM_ID.ItemIndex := 0
    else
      edtPAYM_ID.ItemIndex := i;
  end;
  edtACCOUNT_ID.KeyValue := edtACCOUNT_ID.DataSet.FieldbyName('ACCOUNT_ID').asString;
  edtACCOUNT_ID.Text := edtACCOUNT_ID.DataSet.FieldbyName('ACCT_NAME').asString;
  edtITEM_ID.DataSet.Locate('CODE_ID','1',[]); 
  edtITEM_ID.KeyValue := edtITEM_ID.DataSet.FieldbyName('CODE_ID').asString;
  edtITEM_ID.Text := edtITEM_ID.DataSet.FieldbyName('CODE_NAME').asString;
  if edtSHOP_ID.CanFocus and Visible then edtSHOP_ID.SetFocus;
end;

procedure TfrmRecvPosOrder.CancelOrder;
begin

end;

procedure TfrmRecvPosOrder.Edit(id: string);
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

procedure TfrmRecvPosOrder.SaveOrder;
var
  n:integer;
  rs:TZQuery;
  r:real;
begin
  if edtSHOP_ID.AsString = '' then Raise Exception.Create('��ѡ��ɿ��ŵ�');
  if edtACCOUNT_ID.AsString = '' then Raise Exception.Create('��ѡ���ʻ�����');
  if edtPAYM_ID.ItemIndex < 0 then Raise Exception.Create('��ѡ��ɿʽ����');
  if edtITEM_ID.AsString = '' then Raise Exception.Create('��ѡ����֧��Ŀ����');
  if edtRECV_DATE.EditValue = null then Raise Exception.Create('��ѡ��ɿ�����');
  WriteToObject(AObj,self);
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  AObj.FieldByName('RECV_USER').AsString := Global.UserID;
  AObj.FieldByName('RECV_FLAG').AsString := '1';
  AObj.FieldByName('CLIENT_ID').AsString := inttostr(Global.TENANT_ID);
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
  if n=0 then Raise Exception.Create('û�нɿ��¼�����ܱ���...');
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TRecvOrder');
    Factor.AddBatch(cdsDetail,'TRecvData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
  if Assigned(OnSave) then OnSave(AObj);
end;

procedure TfrmRecvPosOrder.Setcid(const Value: string);
begin
  Fcid := Value;
end;

procedure TfrmRecvPosOrder.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveOrder;
  ShopGlobal.SaveFormatIni('cache','PAYM_ID',TRecord_(edtPAYM_ID.Properties.Items.Objects[edtPAYM_ID.ItemIndex]).FieldbyName('CODE_ID').AsString);
  ModalResult := MROK;
end;

procedure TfrmRecvPosOrder.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmRecvPosOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  DBGridEh1.ReadOnly := (Value=dsBrowse);
  btnOk.Visible:=(dbState<>dsBrowse);
  case Value of
  dsInsert:begin
     Caption := '�ɿ--(����)';
     Label14.Caption := '״̬:����';
  end;
  dsEdit:begin
     Caption := '�ɿ--(�޸�)';
     Label14.Caption := '״̬:�޸�';
  end;
  else
      begin
        Caption := '�ɿ';
        Label14.Caption := '״̬:�鿴';
      end;
  end;
end;

procedure TfrmRecvPosOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('����ɾ��һ�ſյ�...');
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TRecvOrder');
    Factor.AddBatch(cdsDetail,'TRecvData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
end;


procedure TfrmRecvPosOrder.DBGridEh1Columns4EditButtonClick(
  Sender: TObject; var Handled: Boolean);
begin
  inherited;
//  RecvFind;
end;

procedure TfrmRecvPosOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
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

procedure TfrmRecvPosOrder.edtACCOUNT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvPosOrder.edtITEM_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvPosOrder.edtRECV_DATEPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvPosOrder.edtREMARKPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvPosOrder.DBGridEh1Columns3UpdateData(Sender: TObject;
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

procedure TfrmRecvPosOrder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var i:integer;
begin
  inherited;
  if dbState=dsBrowse then exit;
  if btnOk.Enabled then
  begin
    try
      i:=MessageBox(Handle,'�ɿ���޸ģ��Ƿ񱣴��޸���Ϣ��',pchar(Application.Title),MB_YESNOCANCEL+MB_DEFBUTTON1+MB_ICONINFORMATION);
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

procedure TfrmRecvPosOrder.edtITEM_IDAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21200001',2) then Raise Exception.Create('��û��������Ŀ��Ȩ��,��͹���Ա��ϵ.');
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

procedure TfrmRecvPosOrder.edtACCOUNT_IDAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21100001',2) then Raise Exception.Create('��û�������˻���Ȩ��,��͹���Ա��ϵ.');
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

procedure TfrmRecvPosOrder.FillData;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  cdsDetail.DisableControls;
  try
    rs.Close;
    rs.SQL.Text :=
       'select A.ABLE_ID,A.TENANT_ID,A.SHOP_ID,A.CLIENT_ID,B.CLIENT_NAME as CLIENT_ID_TEXT,A.ACCT_INFO,A.RECV_TYPE,A.ACCT_MNY,A.RECV_MNY,A.RECK_MNY,A.ABLE_DATE,A.NEAR_DATE,C.SHOP_NAME as SHOP_ID_TEXT '+
       'from ACC_RECVABLE_INFO A,VIW_CUSTOMER B,CA_SHOP_INFO C where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=C.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CLIENT_ID='''+inttostr(Global.TENANT_ID)+''' and A.SHOP_ID='''+edtSHOP_ID.AsString+''' and A.RECK_MNY<>0 and A.RECV_TYPE=''4'' order by ABLE_ID';
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
    if cdsDetail.IsEmpty then MessageBox(Handle,'��ǰѡ��Ŀͻ�û�д����˿','������ʾ...',MB_OK+MB_ICONINFORMATION);
  finally
    rs.free;
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmRecvPosOrder.edtCLIENT_IDSaveValue(Sender: TObject);
begin
  inherited;
  FillData;
  if locked then exit;
  btnOk.Enabled:=True;
end;

procedure TfrmRecvPosOrder.Calc;
begin
  cdsDetail.Edit;
  cdsDetail.FieldbyName('BALA_MNY').AsFloat := cdsDetail.FieldbyName('RECK_MNY').AsFloat
                                              -cdsDetail.FieldbyName('RECV_MNY').AsFloat;
end;

procedure TfrmRecvPosOrder.DBGridEh1Columns1UpdateData(Sender: TObject;
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

procedure TfrmRecvPosOrder.cdsDetailBeforeEdit(DataSet: TDataSet);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;

end;

procedure TfrmRecvPosOrder.edtRECV_USERPropertiesChange(Sender: TObject);
begin
  inherited;
  if locked then exit;
  btnOk.Enabled:=True;

end;

procedure TfrmRecvPosOrder.SetisAudit(const Value: boolean);
begin
  FisAudit := Value;
  Image1.Visible := Value;
  if dbState = dsBrowse then
     begin
       if Value then Label14.Caption := '״̬:���' else Label14.Caption := '״̬:����';
     end;
end;

procedure TfrmRecvPosOrder.ClearPayment;
var
  i:integer;
begin
//  for i:=edtPAYM_ID.Properties.Items.Count downto 0 do
//    begin
//      if TRecord_().FieldbyName('CODE_ID').AsString = '
//    end;
end;

procedure TfrmRecvPosOrder.edtSHOP_IDSaveValue(Sender: TObject);
begin
  inherited;
  FillData;
  if locked then exit;
  btnOk.Enabled:=True;
end;

end.
