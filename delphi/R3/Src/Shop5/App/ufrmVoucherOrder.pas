unit ufrmVoucherOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeContractForm, DB, ZAbstractRODataset, ZAbstractDataset, ZBase,
  ZDataset, ActnList, Menus, Grids, DBGridEh, ExtCtrls, StdCtrls, RzPanel,
  cxDropDownEdit, cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, zrComboBoxList;

type
  TfrmVoucherOrder = class(TframeContractForm)
    edtDEPT_ID: TzrComboBoxList;
    Label3: TLabel;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    edtINTO_DATE: TcxDateEdit;
    lblSTOCK_DATE: TLabel;
    edtINTO_USER: TzrComboBoxList;
    Label9: TLabel;
    edtVOUCHER_TYPE: TcxComboBox;
    Label1: TLabel;
    Label7: TLabel;
    edtREMARK: TcxTextEdit;
    edtInput: TcxTextEdit;
    lblInput: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Label4: TLabel;
    Label5: TLabel;
    edtVAILD_DATE: TcxDateEdit;
    edtVUCH_NAME: TcxTextEdit;
    edtVOUCHER_PRC: TcxTextEdit;
    Label8: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure edtVOUCHER_PRCPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    //procedure FocusNextColumn;
    RowId:Integer;
    procedure SetdbState(const Value: TDataSetState);override;
  public
    { Public declarations }
    procedure ClearInvaid;override;
    procedure InitRecord;override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure Open(id:string);override;
  end;


implementation
uses uGlobal, uCtrlUtil,uShopGlobal, uShopUtil, uFnUtil, ufrmBasic, ufrmMain, uDsUtil,
  uXDictFactory, DateUtils;
{$R *.dfm}

{ TfrmVoucherOrder }

procedure TfrmVoucherOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmVoucherOrder.ClearInvaid;
begin
  inherited;

end;

procedure TfrmVoucherOrder.DeleteOrder;
begin
  inherited;
  Saved := false;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空礼券');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前礼券?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;

  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TVoucherOrder');
    Factor.AddBatch(cdsDetail,'TVoucherData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  Open(oid);
  oid := '';
  gid := '';
  cid := AObj.FieldbyName('SHOP_ID').AsString;
  dbState := dsBrowse;
end;

procedure TfrmVoucherOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');

  dbState := dsEdit;
  if edtSHOP_ID.CanFocus then edtSHOP_ID.SetFocus;
end;

procedure TfrmVoucherOrder.InitRecord;
var tmp:TZQuery;
begin
  if dbState = dsBrowse then Exit;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;

  //if DBGridEh1.CanFocus and Visible then DBGridEh1.SetFocus;
  cdsDetail.DisableControls;
  try
  cdsDetail.Last;
  if cdsDetail.IsEmpty or (cdsDetail.FieldbyName('BARCODE').AsString <>'') then
    begin
      Inc(RowId);
      cdsDetail.Append;
      cdsDetail.FieldByName('BARCODE').AsString := Trim(edtInput.Text);
      cdsDetail.FieldByName('VOUCHER_TYPE').AsString := TRecord_(edtVOUCHER_TYPE.Properties.Items.Objects[edtVOUCHER_TYPE.ItemIndex]).FieldByName('CODE_ID').AsString;
      cdsDetail.FieldByName('VOUCHER_PRC').AsInteger := StrToInt(Trim(edtVOUCHER_PRC.Text));
      cdsDetail.FieldByName('VAILD_DATE').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',edtVAILD_DATE.Date));
      cdsDetail.FieldByName('CLIENT_ID').AsString := '#';
      cdsDetail.FieldByName('VOUCHER_STATUS').AsString := '1';
      cdsDetail.FieldByName('SEQNO').asInteger := RowID;
      cdsDetail.Post;
    end;
  //DbGridEh1.Col := 1 ;
  finally
    cdsDetail.EnableControls;
    cdsDetail.Edit;
  end;
end;

procedure TfrmVoucherOrder.NewOrder;
var rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  edtINTO_DATE.Date := Global.SysDate;

  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  edtVAILD_DATE.Date := EncodeDate(2099,12,31);
  edtINTO_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  edtVOUCHER_TYPE.ItemIndex := TdsItems.FindItems(edtVOUCHER_TYPE.Properties.Items,'CODE_ID','1');
  edtINTO_USER.KeyValue := Global.UserID;
  edtINTO_USER.Text := Global.UserName;
  AObj.FieldbyName('VOUCHER_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('VOUCHER_ID').asString;
  gid := '..新增..';

  //InitRecord;
  if edtSHOP_ID.CanFocus and Visible then edtSHOP_ID.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmVoucherOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('VOUCHER_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TVoucherOrder',Params);
      Factor.AddBatch(cdsDetail,'TVoucherData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    RowId := cdsDetail.RecordCount;
    dbState := dsBrowse;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    if cdsDetail.FieldByName('VAILD_DATE').AsInteger > 0 then
       edtVAILD_DATE.Date := EncodeDate(cdsDetail.FieldByName('VAILD_DATE').AsInteger div 10000,cdsDetail.FieldByName('VAILD_DATE').AsInteger mod 10000 div 100,cdsDetail.FieldByName('VAILD_DATE').AsInteger mod 100);
    edtVOUCHER_PRC.Text := cdsDetail.FieldByName('VOUCHER_PRC').AsString;
    oid := AObj.FieldbyName('VOUCHER_ID').asString;
    gid := '';
    cid := AObj.FieldbyName('SHOP_ID').AsString;
  finally
    Params.Free;
  end;
end;

procedure TfrmVoucherOrder.SaveOrder;
begin
  inherited;
  Saved := false;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  if edtINTO_DATE.EditValue = null then Raise Exception.Create('入库日期不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('入库部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create(Label40.Caption+'不能为空');
  if cdsDetail.IsEmpty then Raise Exception.Create('不能保存一张空礼券...');
  //ClearInvaid;
  cdsDetail.DisableControls;
  try
    WriteToObject(AObj,self);
    AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cid := edtSHOP_ID.asString;
    AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    AObj.FieldByName('CREA_USER').AsString := Global.UserID;

    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    cdsDetail.First;
    while not cdsDetail.Eof do
    begin
      cdsDetail.Edit;
      cdsDetail.FieldByName('TENANT_ID').AsString := cdsHeader.FieldbyName('TENANT_ID').AsString;
      cdsDetail.FieldByName('VOUCHER_ID').AsString := cdsHeader.FieldbyName('VOUCHER_ID').AsString;
      cdsDetail.Post;
      cdsDetail.Next;
    end;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TVoucherOrder');
      Factor.AddBatch(cdsDetail,'TVoucherData');
      Factor.CommitBatch;
      Saved := true;
    except
      Factor.CancelBatch;
      cdsHeader.CancelUpdates;
      Raise;
    end;
  finally
    cdsDetail.EnableControls;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmVoucherOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;

end;

procedure TfrmVoucherOrder.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '入库仓库';
    end;
  AddCbxPickList(edtVOUCHER_TYPE);
  InitGridPickList(DBGridEh1);
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  //edtDEPT_ID.RangeField := 'DEPT_TYPE';
  //edtDEPT_ID.RangeValue := '1';
  edtINTO_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  
end;

procedure TfrmVoucherOrder.FormDestroy(Sender: TObject);
begin
  ClearCbxPickList(edtVOUCHER_TYPE);
  //Freeform(Self);
  inherited;
end;

procedure TfrmVoucherOrder.N1Click(Sender: TObject);
begin
  inherited;
  if DBGridEh1.ReadOnly then Exit;
  if dbState = dsBrowse then Exit;
  if cdsDetail.IsEmpty then Exit;
  if MessageBox(Handle,pchar('确认删除"'+cdsDetail.FieldbyName('BARCODE').AsString+'"礼券吗？'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)=6 then
  begin
     cdsDetail.Delete;
     DBGridEh1.SetFocus;
  end;
end;

procedure TfrmVoucherOrder.edtInputKeyPress(Sender: TObject;
  var Key: Char);
var s:String;
begin
  inherited;
  try
    if dbState = dsBrowse then Exit;
    if Key = #13 then
    begin
       s := Trim(edtInput.Text);
       Key := #0;
       if edtVOUCHER_TYPE.ItemIndex < 0 then Raise Exception.Create('请选择礼券类型!');
       if edtINTO_DATE.EditValue = null then Raise Exception.Create('有效日期不能为空!');
       if Trim(edtVOUCHER_PRC.Text) = '' then Raise Exception.Create('礼券面值不能为空!');
       if Trim(s) = '' then Exit;
       try
         if s[1] = '-' then
         begin
            if MessageBox(Handle,pchar('是否删除当前礼券"'+cdsDetail.FieldbyName('BARCODE').asString+'"'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            N1Click(Sender);
         end;
         if FnString.IsNumberChar(Trim(s)) then
         begin
            if cdsDetail.Locate('BARCODE',s,[]) then Raise Exception.Create('"'+cdsDetail.FieldbyName('BARCODE').asString+'"礼券号已经存在!');
            InitRecord;
         end;
       except
         Raise;
       end;
       edtInput.Text := '';
    end;
  finally
    if edtInput.CanFocus and not edtInput.Focused then edtInput.SetFocus;
  end;

end;

procedure TfrmVoucherOrder.edtVOUCHER_PRCPropertiesChange(Sender: TObject);
begin
  inherited;
  StrToInt64Def(Trim(edtVOUCHER_PRC.Text),0);
end;

end.
