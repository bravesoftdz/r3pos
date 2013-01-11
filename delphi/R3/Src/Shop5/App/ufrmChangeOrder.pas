unit ufrmChangeOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, zBase, ZDataSet, ZAbstractRODataset,
  ZAbstractDataset;

type
  TfrmChangeOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    edtCHK_DATE: TcxTextEdit;
    Label9: TLabel;
    edtCHK_USER_TEXT: TcxTextEdit;
    edtCHANGE_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtDUTY_USER: TzrComboBoxList;
    edtCHANGE_CODE: TcxComboBox;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    Label3: TLabel;
    fndMY_AMOUNT: TcxTextEdit;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    Label4: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    Label12: TLabel;
    Label15: TLabel;
    edtSEND_ADDR: TcxTextEdit;
    edtTELEPHONE: TcxTextEdit;
    Label16: TLabel;
    edtLINKMAN: TcxTextEdit;
    Label5: TLabel;
    edtDEMA_GLIDE_NO: TcxButtonEdit;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns7UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure edtDUTY_USERSaveValue(Sender: TObject);
    procedure edtCHANGE_CODEPropertiesChange(Sender: TObject);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure fndGODS_IDAddClick(Sender: TObject);
    procedure edtDUTY_USERAddClick(Sender: TObject);
    procedure edtTableAfterScroll(DataSet: TDataSet);
    procedure edtSHOP_IDSaveValue(Sender: TObject);
    procedure edtDEMA_GLIDE_NOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    w:integer;
    FCodeId: string;
    procedure SetCodeId(const Value: string);
    procedure ShowInfo;
    procedure SetdbState(const Value: TDataSetState); override;
  protected
    procedure WMFillData(var Message: TMessage); message WM_FILL_DATA;
    procedure DemaFrom(id:String);
    function GetShopId:string;override;
  public
    { Public declarations }
    function CheckInput:boolean;override;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure AmountToCalc(Amount:Real);override;
    procedure UnitToCalc(UNIT_ID:string);override;
    procedure PresentToCalc(Present:integer);override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure AuditOrder;override;
    procedure AutoAudit;
    procedure Open(id:string);override;
    property CodeId:string read FCodeId write SetCodeId;
  end;

implementation
uses uGlobal,uShopUtil,uDsUtil, uShopGlobal, ufrmGoodsInfo, ufrmUsersInfo, ufrmDemandOrder,
     ufrmChangeOrderList,ufrmFindOrder, Math;
{$R *.dfm}

procedure TfrmChangeOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmChangeOrder.ShowInfo;
var
  rs,bs:TZQuery;
begin
  if not fndMY_AMOUNT.Visible then Exit;
  fndMY_AMOUNT.Text := '';
  if edtTable.FieldByName('GODS_ID').AsString = '' then Exit;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO'); 
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select sum(AMOUNT) as AMOUNT from STO_STORAGE A where A.GODS_ID=:GODS_ID and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID and A.BATCH_NO=:BATCH_NO';
    rs.ParamByName('GODS_ID').AsString := edtTable.FieldByName('GODS_ID').AsString;
    rs.ParamByName('SHOP_ID').AsString := edtSHOP_ID.AsString;
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('BATCH_NO').AsString := edtTable.FieldByName('BATCH_NO').AsString;
    Factor.Open(rs);
    if rs.FieldbyName('AMOUNT').asString<>'' then
       begin
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('BIG_UNITS').AsString) and (bs.FieldbyName('BIGTO_CALC').AsFloat<>0) then
            fndMY_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('BIGTO_CALC').AsFloat)
         else
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('SMALL_UNITS').AsString) and (bs.FieldbyName('SMALLTO_CALC').AsFloat<>0) then
            fndMY_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('SMALLTO_CALC').AsFloat)
         else
            fndMY_AMOUNT.Text := rs.FieldbyName('AMOUNT').AsString;
       end
    else
       fndMY_AMOUNT.Text := '0';
  finally
    rs.Free;
  end;
end;

procedure TfrmChangeOrder.DeleteOrder;
begin
  inherited;
  Saved := false;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能删除');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if cdsHeader.FieldByName('FROM_ID').AsString<>'' then Raise Exception.Create('盘点任务生成的单据不能在此操作,请到盘点模块使用此功能...');
  if MessageBox(Handle,'是否真想删除当前单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TChangeOrder');
    Factor.AddBatch(cdsDetail,'TChangeData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('CHANGE_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').asString;
    dbState := dsBrowse;
end;

procedure TfrmChangeOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改');
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  if cdsHeader.FieldByName('FROM_ID').AsString<>'' then Raise Exception.Create('盘点任务生成的单据不能在此操作,请到盘点模块使用此功能...');
  dbState := dsEdit;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      SetEditStyle(dsBrowse,edtSHOP_ID.Style);
      edtSHOP_ID.Properties.ReadOnly := True;
    end;

  if edtCHANGE_DATE.CanFocus then edtCHANGE_DATE.SetFocus;
end;

procedure TfrmChangeOrder.FormCreate(Sender: TObject);
var
  rs:TZQuery;
  AObj:TRecord_;
begin
  inherited;
  fndMY_AMOUNT.Visible := ShopGlobal.GetChkRight('14500001',1); //是否有库存查询权限
  Label3.Visible := fndMY_AMOUNT.Visible;
  edtSHOP_ID.DataSet := Global.GeTZQueryFromName('CA_SHOP_INFO');
  edtDEPT_ID.DataSet := Global.GeTZQueryFromName('CA_DEPT_INFO');
  dbState := dsBrowse;
  w := 0;
  edtDUTY_USER.DataSet := Global.GeTZQueryFromName('CA_USERS');
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select CHANGE_CODE as CODE_ID,CHANGE_NAME as CODE_NAME,CHANGE_TYPE from STO_CHANGECODE where TENANT_ID in (0,'+inttostr(Global.TENANT_ID)+') and COMM not in (''02'',''12'') order by CHANGE_CODE';
    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        AObj := TRecord_.Create;
        AObj.ReadFromDataSet(rs);
        edtCHANGE_CODE.Properties.Items.AddObject(rs.Fields[1].AsString,AObj);
        rs.Next;
      end;
  finally
    rs.Free;
  end;
//  if not ShopGlobal.GetChkRight('14500001',2) then
//     begin
//       DBGridEh1.Columns[7].Free;
//       DBGridEh1.Columns[6].Free;
//     end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '仓库名称';
    end;

end;

procedure TfrmChangeOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs:TZQuery;
  str,InLevel:string;
begin
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');
  edtTable.Edit;
  if UNIT_ID=rs.FieldbyName('SMALL_UNITS').AsString then
  begin
     edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE1').AsFloat;
  end
  else
  if UNIT_ID=rs.FieldbyName('BIG_UNITS').AsString then
  begin
     edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE2').AsFloat;
  end
  else
  begin
     edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE').AsFloat;
  end;
  edtTable.FieldbyName('COST_PRICE').AsFloat := GetCostPrice(edtSHOP_ID.AsString,GODS_ID,edtTable.FieldbyName('BATCH_NO').AsString);
  ShowInfo;
end;

procedure TfrmChangeOrder.NewOrder;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  edtSHOP_ID.Properties.ReadOnly := False;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      SetEditStyle(dsBrowse,edtSHOP_ID.Style);
      edtSHOP_ID.Properties.ReadOnly := True;
    end;
  cid := edtSHOP_ID.AsString;
  AObj.FieldbyName('CHANGE_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('CHANGE_ID').asString;
  gid := '..新增..';//AObj.FieldbyName('GLIDE_NO').asString;
  edtCHANGE_DATE.Date := Global.SysDate;
  edtDUTY_USER.KeyValue := Global.UserID;
  edtDUTY_USER.Text := Global.UserName;
  if edtCHANGE_CODE.Properties.Items.Count > 0 then
     edtCHANGE_CODE.ItemIndex := TdsItems.FindItems(edtCHANGE_CODE.Properties.Items,'CODE_ID',CodeId);
  Caption := edtCHANGE_CODE.Text + '单';
  edtDEPT_ID.KeyValue := edtDEPT_ID.DataSet.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := edtDEPT_ID.DataSet.FieldbyName('DEPT_NAME').AsString;
  InitRecord;

  if edtDEPT_ID.CanFocus then edtDEPT_ID.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmChangeOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := cid;
    Params.ParamByName('CHANGE_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TChangeOrder',Params);
      Factor.AddBatch(cdsDetail,'TChangeData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    edtSHOP_ID.Properties.ReadOnly := False;
    AObj.ReadFromDataSet(cdsHeader);
    dbState := dsBrowse;  //2011.04.02 提到ReadFromObject之前
    ReadFromObject(AObj,self);
    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('CHANGE_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').asString;
    if edtCHANGE_CODE.ItemIndex = 0 then
    begin
      Label5.Visible := False;
      edtDEMA_GLIDE_NO.Visible := False;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmChangeOrder.SaveOrder;
var mny,amt:real;
begin
  inherited;
  Saved := false;
  if edtCHANGE_DATE.EditValue = null then Raise Exception.Create('开单日期不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create('门店不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('部门不能为空');
  if edtDUTY_USER.AsString = '' then Raise Exception.Create('责任人不能为空');
  if edtCHANGE_CODE.ItemIndex<0 then Raise Exception.Create('请选择单据类型');
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  WriteToObject(AObj,self);
  AObj.FieldByName('CHANGE_TYPE').AsString := TRecord_(edtCHANGE_CODE.Properties.Items.Objects[edtCHANGE_CODE.ItemIndex]).FieldbyName('CHANGE_TYPE').AsString;
  AObj.FieldbyName('TENANT_ID').AsInteger :=Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cid := edtSHOP_ID.AsString;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
//  if ((CodeId = '1') and (ShopGlobal.GetParameter('STO_AUTO_CHK')<>'0') and ShopGlobal.GetChkRight('14300001',5))
//     or
//     ((CodeId = '2') and (ShopGlobal.GetParameter('STO_AUTO_CHK')<>'0') and ShopGlobal.GetChkRight('14200001',5))
//  then
//     begin
//       AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
//       AObj.FieldbyName('CHK_USER').AsString := Global.UserID;
//     end;
  Factor.BeginBatch;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    WriteTo(cdsDetail);
    mny := 0;
    amt := 0;
    cdsDetail.First;
    while not cdsDetail.Eof do
       begin
         cdsDetail.Edit;
         cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
         cdsDetail.FieldByName('TENANT_ID').AsString := cdsHeader.FieldbyName('TENANT_ID').AsString;
         cdsDetail.FieldByName('CHANGE_ID').AsString := cdsHeader.FieldbyName('CHANGE_ID').AsString;
         cdsDetail.FieldByName('CHANGE_TYPE').AsString := cdsHeader.FieldbyName('CHANGE_TYPE').AsString;
         cdsDetail.Post;
         mny := mny + StrtoFloat(formatFloat('#0.00',cdsDetail.FieldbyName('COST_PRICE').asFloat*cdsDetail.FieldbyName('CALC_AMOUNT').asFloat));
         amt := amt + cdsDetail.FieldbyName('AMOUNT').asFloat;
         cdsDetail.Next;
       end;
    cdsHeader.Edit;
    cdsHeader.FieldbyName('CHANGE_MNY').asFloat := mny;
    cdsHeader.FieldbyName('CHANGE_AMT').asFloat := amt;
    cdsHeader.Post;
    Factor.AddBatch(cdsHeader,'TChangeOrder');
    Factor.AddBatch(cdsDetail,'TChangeData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  open(oid);
  dbState := dsBrowse;

  if ((CodeId = '1') and (ShopGlobal.GetParameter('STO_AUTO_CHK')<>'0') and ShopGlobal.GetChkRight('14300001',5))
     or
     ((CodeId = '2') and (ShopGlobal.GetParameter('STO_AUTO_CHK')<>'0') and ShopGlobal.GetChkRight('14200001',5))
  then
     begin
       AutoAudit;
     end;

end;

procedure TfrmChangeOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if edtTable.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;
  if PropertyEnabled then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.asFloat;
     end
  else
     begin
        try
          if Text='' then
             r := 0
          else
             r := StrtoFloat(Text);
        except
          Text := TColumnEh(Sender).Field.AsString;
          Value := TColumnEh(Sender).Field.asFloat;
          Raise Exception.Create('输入无效数值型');
        end;
        if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
        TColumnEh(Sender).Field.asFloat := r;
        AMountToCalc(r);
     end;
end;

procedure TfrmChangeOrder.DBGridEh1Columns7UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:integer;
begin
  try
    if Text='' then
       r := 0
    else
       r := StrtoInt(Text);
    if abs(r)>1 then Raise Exception.Create('输入的数值过大，无效');
  except
    Text := '';
    Value := null;
    Raise Exception.Create('输入无效数值'+Text);
  end;
  TColumnEh(Sender).Field.asFloat := r;
  PresentToCalc(r);
end;

procedure TfrmChangeOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := '';
    Value := null;
    Raise Exception.Create('输入无效数值型');
  end;
  if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
  AMoneyToCalc(r);
end;

procedure TfrmChangeOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := '';
    Value := null;
    Raise Exception.Create('输入无效数值型');
  end;
  if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
  PriceToCalc(r);
end;

procedure TfrmChangeOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmChangeOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.FieldByName('FROM_ID').AsString<>'' then Raise Exception.Create('盘点任务生成的损益单不能在此操作,请到盘点模块使用此功能...');
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前单据执行弃审');
       if MessageBox(Handle,'确认弃审当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前单据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').asString := edtSHOP_ID.AsString;
      Params.ParamByName('CHANGE_ID').asString := cdsHeader.FieldbyName('CHANGE_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TChangeOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TChangeOrderUnAudit',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
{    IsAudit := not IsAudit;
    if IsAudit then
       begin
         edtCHK_DATE.Text := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         edtCHK_USER_TEXT.Text := Global.UserName;
         AObj.FieldByName('CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         AObj.FieldByName('CHK_USER').AsString := Global.UserID;
       end
    else
       begin
         edtCHK_DATE.Text := '';
         edtCHK_USER_TEXT.Text := '';
         AObj.FieldByName('CHK_DATE').AsString := '';
         AObj.FieldByName('CHK_USER').AsString := '';
       end;
    cdsHeader.Edit;
    cdsHeader.FieldByName('CHK_DATE').AsString := AObj.FieldByName('CHK_DATE').AsString;
    cdsHeader.FieldByName('CHK_USER').AsString := AObj.FieldByName('CHK_USER').AsString;
    cdsHeader.Post;
    cdsHeader.CommitUpdates;
}
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
  Open(oid);
end;

procedure TfrmChangeOrder.edtDUTY_USERSaveValue(Sender: TObject);
var
  us:TZQuery;
begin
  inherited;
  if edtDUTY_USER.Text<>'' then TabSheet.Caption := edtDUTY_USER.Text;
  us := Global.GetZQueryFromName('CA_USERS');
  edtDEPT_ID.KeyValue := us.FieldbyName('DEPT_ID').AsString;
  if edtDEPT_ID.DataSet.Locate('DEPT_ID',edtDEPT_ID.AsString,[]) then
     edtDEPT_ID.Text := edtDEPT_ID.DataSet.FieldbyName('DEPT_NAME').AsString;
  
end;

procedure TfrmChangeOrder.edtCHANGE_CODEPropertiesChange(Sender: TObject);
begin
  inherited;
  if dbState = dsBrowse then w := edtCHANGE_CODE.ItemIndex;
end;

procedure TfrmChangeOrder.SetCodeId(const Value: string);
begin
  FCodeId := Value;
  if edtCHANGE_CODE.Properties.Items.Count > 0 then
     edtCHANGE_CODE.ItemIndex := TdsItems.FindItems(edtCHANGE_CODE.Properties.Items,'CODE_ID',CodeId);
  Caption := edtCHANGE_CODE.Text + '单';
  if Value='2' then
     begin
       Label1.Caption := '领用人';
       Label4.Caption := '领用部门';
     end
  else
     begin
       Label1.Caption := '经手人';
       Label4.Caption := '损益部门';
       edtDEMA_GLIDE_NO.Visible := False;
       Label5.Visible := False;
     end;
end;

procedure TfrmChangeOrder.fndGODS_IDSaveValue(Sender: TObject);
begin
  if (fndGODS_ID.AsString='') and fndGODS_ID.Focused and ShopGlobal.GetChkRight('32600001',2) then
     begin
       if MessageBox(Handle,'没找到你想查找的商品是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       fndStr := fndGODS_ID.Text;
       fndGODS_ID.OnAddClick(nil);
       Exit;
     end;
  inherited;
end;

procedure TfrmChangeOrder.fndGODS_IDAddClick(Sender: TObject);
var r:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('32600001',2) then Exit;
  r := TRecord_.Create;
  try
    if TfrmGoodsInfo.AddDialog(self,r,fndStr) then
       begin
         AddRecord(r,r.FieldbyName('CALC_UNITS').AsString,true);
         if (edtTable.FindField('AMOUNT')<>nil) and (edtTable.FindField('AMOUNT').AsFloat=0) then
           begin
             if not PropertyEnabled then
                begin
                  edtTable.FieldbyName('AMOUNT').AsFloat := 1;
                  AMountToCalc(1);
                end
             else
                PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,0);
           end;
       end; 
    DBGridEh1.SetFocus;
  finally
    r.Free;
  end;  
end;

procedure TfrmChangeOrder.edtDUTY_USERAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  r := TRecord_.Create;
  try
    if TfrmUsersInfo.AddDialog(self,r) then
       begin
         edtDUTY_USER.KeyValue := r.FieldbyName('USER_ID').AsString;
         edtDUTY_USER.Text := r.FieldbyName('USER_NAME').AsString;
       end;
  finally
    r.Free;
  end; 
end;

procedure TfrmChangeOrder.PresentToCalc(Present: integer);
begin
  inherited;
  ShowInfo;
end;

procedure TfrmChangeOrder.UnitToCalc(UNIT_ID: string);
begin
  inherited;
  ShowInfo;
end;

procedure TfrmChangeOrder.edtTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then ShowInfo;

end;

procedure TfrmChangeOrder.edtSHOP_IDSaveValue(Sender: TObject);
begin
  inherited;
  cid := edtSHOP_ID.asString;
  ShowInfo;

end;

procedure TfrmChangeOrder.AmountToCalc(Amount: Real);
begin
  inherited;
  edtTable.Edit;
  edtTable.FieldbyName('COST_MONEY').AsFloat := edtTable.FieldbyName('CALC_AMOUNT').AsFloat*edtTable.FieldbyName('COST_PRICE').AsFloat;
  if edtTable.FieldbyName('AMOUNT').AsFloat<>0 then
     begin
       edtTable.FieldbyName('COST_APRICE').AsString :=formatFloat('#0.000',edtTable.FieldbyName('COST_MONEY').AsFloat/edtTable.FieldbyName('AMOUNT').AsFloat);
     end;

end;

function TfrmChangeOrder.CheckInput: boolean;
begin
  result := pos(inttostr(InputFlag),'0789')>0;
end;

procedure TfrmChangeOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  if cdsHeader.Active and (Value=dsBrowse) then
  begin
    if AObj.FieldbyName('LOCUS_STATUS').AsString='3' then
       lblState.Caption := lblState.Caption + ' / 已发货'
    else
       lblState.Caption := lblState.Caption + ' / 未发货';
  end;

end;

procedure TfrmChangeOrder.WMFillData(var Message: TMessage);
var
  frmDemandOrder:TfrmDemandOrder;
  i:integer;
begin
  if dbState <> dsInsert then Raise Exception.Create('不是在新增状态不能完成操作');
  frmDemandOrder := TfrmDemandOrder(Message.WParam);
  with TfrmDemandOrder(frmDemandOrder) do
    begin
      self.edtSHOP_ID.KeyValue := edtSHOP_ID.KeyValue;
      self.edtSHOP_ID.Text := edtSHOP_ID.Text;
      //self.edtSHOP_ID.KeyValue := edtSHOP_ID.KeyValue;
      //self.edtSHOP_ID.Text := edtSHOP_ID.Text;
      //self.edtSTOCK_USER.KeyValue := edtDEMA_USER.KeyValue;
      //self.edtSTOCK_USER.Text := edtDEMA_USER.Text;
      self.edtDEPT_ID.KeyValue := edtDEPT_ID.KeyValue;
      self.edtDEPT_ID.Text := edtDEPT_ID.Text;
      self.AObj.FieldbyName('FIG_ID').AsString := AObj.FieldbyName('DEMA_ID').AsString;
      //self.AObj.FieldbyName('TAX_RATE').AsString := AObj.FieldbyName('TAX_RATE').AsString;
      self.edtDEMA_GLIDE_NO.Text := AObj.FieldbyName('GLIDE_NO').AsString;
      //self.edtADVA_MNY.Text := edtADVA_MNY.Text;
      self.edtREMARK.Text := edtREMARK.Text;
      self.Locked := False;

      case Message.LParam of
      0:DemaFrom(AObj.FieldbyName('DEMA_ID').AsString);
      1:
        begin
          self.edtTable.DisableControls;
          try
          self.edtProperty.Close;
          self.edtTable.Close;
          self.edtProperty.CreateDataSet;
          self.edtTable.CreateDataSet;
          self.RowID := 0;
          self.edtTable.Append;
          for i:=0 to self.edtTable.Fields.Count -1 do
            begin
               if edtTable.FindField(self.edtTable.Fields[i].FieldName)<>nil then
                  self.edtTable.Fields[i].Value := edtTable.FieldbyName(self.edtTable.Fields[i].FieldName).Value;
            end;
          inc(self.RowID);
          self.edtTable.FieldbyName('SEQNO').AsInteger := self.RowID;
          self.edtTable.FieldbyName('BARCODE').AsString := self.EnCodeBarcode;
          self.edtTable.Post;

          edtProperty.Filtered := false;
          edtProperty.Filter := 'SEQNO='+edtTable.FieldbyName('SEQNO').AsString;
          edtProperty.Filtered := true;

          edtProperty.First;
          while not edtProperty.Eof do
            begin
              self.edtProperty.Append;
              for i:=0 to self.edtProperty.Fields.Count -1 do
                self.edtProperty.Fields[i].Value := edtProperty.FieldbyName(self.edtProperty.Fields[i].FieldName).Value;
              self.edtProperty.FieldByName('SEQNO').AsInteger := self.edtTable.FieldbyName('SEQNO').AsInteger;
              self.edtProperty.Post;

              edtProperty.Next;
            end;
          InitPrice(edtTable.FieldbyName('GODS_ID').AsString,edtTable.FieldbyName('UNIT_ID').AsString);
          AmountToCalc(edtTable.FieldbyName('AMOUNT').AsCurrency);            
          finally
            self.edtTable.EnableControls;
          end;
          //self.Calc;
        end;
      end;
    end;
  inherited;
end;

procedure TfrmChangeOrder.DemaFrom(id: String);
var
  h,d:TZQuery;
  Params:TftParamList;
  HObj:TRecord_;
begin
   h := TZQuery.Create(nil);
   d := TZQuery.Create(nil);
   Params := TftParamList.Create(nil);
   HObj := TRecord_.Create;
   try
      Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
      Params.ParamByName('DEMA_ID').asString := id;
      Factor.BeginBatch;
      try
        Factor.AddBatch(h,'TDemandOrderForDb',Params);
        Factor.AddBatch(d,'TDemandDataForDb',Params);
        Factor.OpenBatch;
        HObj.ReadFromDataSet(h);
        ReadFromObject(HObj,self);
        AObj.FieldbyName('FIG_ID').AsString := HObj.FieldbyName('DEMA_ID').AsString;
        edtDEMA_GLIDE_NO.Text := HObj.FieldbyName('GLIDE_NO').AsString;
        edtCHANGE_DATE.Date := Global.SysDate;
        //AObj.FieldbyName('TAX_RATE').AsFloat := HObj.FieldbyName('TAX_RATE').AsFloat;
        //edtTAX_RATE.Value := HObj.FieldbyName('TAX_RATE').AsFloat*100;
        edtCHK_DATE.Text := '';
        edtCHK_USER_TEXT.Text := '';
        //if h.FieldByName('STKBILL_STATUS').AsInteger=0 then
        //   AObj.FieldByName('ADVA_MNY').AsFloat := HObj.FieldByName('ADVA_MNY').AsFloat
        //else
        //   AObj.FieldByName('ADVA_MNY').AsFloat := 0;
        ReadFrom(d);
        edtTable.First;
        while not edtTable.Eof do
        begin
          InitPrice(edtTable.FieldbyName('GODS_ID').AsString,edtTable.FieldbyName('UNIT_ID').AsString);
          AmountToCalc(edtTable.FieldbyName('AMOUNT').AsCurrency);
          edtTable.Next;          
        end;
        //Calc;
      except
        Factor.CancelBatch;
        Raise;
      end;
   finally
     HObj.Free;
     Params.Free;
     h.Free;
     d.Free;
   end;
end;

procedure TfrmChangeOrder.edtDEMA_GLIDE_NOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  s:string;
begin
  inherited;
  if not IsNull then Raise Exception.Create('已经输入商品了，不能导入订单.');
  if dbState <> dsInsert then Raise Exception.Create('只有不是新增状态的单据不能导入订单.');  
  s := TfrmFindOrder.FindDialog(self,6,edtSHOP_ID.asString,'');
  if s<>'' then
     begin
       DemaFrom(s);
     end;
end;

function TfrmChangeOrder.GetShopId: string;
begin
  result := edtSHOP_ID.AsString;
end;

procedure TfrmChangeOrder.AutoAudit;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.FieldByName('FROM_ID').AsString<>'' then Raise Exception.Create('盘点任务生成的损益单不能在此操作,请到盘点模块使用此功能...');
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').asString := edtSHOP_ID.AsString;
      Params.ParamByName('CHANGE_ID').asString := cdsHeader.FieldbyName('CHANGE_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TChangeOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TChangeOrderUnAudit',Params) ;
    finally
       Params.free;
    end;
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
  Open(oid);
end;

end.
