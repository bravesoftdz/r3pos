unit ufrmStkRetuOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, zBase, cxSpinEdit, RzButton, cxListBox,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmStkRetuOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    edtSTOCK_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtGUIDE_USER: TzrComboBoxList;
    edtINVOICE_FLAG: TcxComboBox;
    actPrintBarcode: TAction;
    N1: TMenuItem;
    edtTAX_RATE: TcxSpinEdit;
    edtCLIENT_ID: TzrComboBoxList;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    Label12: TLabel;
    Label14: TLabel;
    edtSTK_GLIDE_NO: TcxButtonEdit;
    Label19: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    edtRECV_MNY: TcxTextEdit;
    edtRECK_MNY: TcxTextEdit;
    edtCHK_DATE: TcxTextEdit;
    edtCHK_USER_TEXT: TcxTextEdit;
    fndRECK_MNY: TcxTextEdit;
    fndMY_AMOUNT: TcxTextEdit;
    Label4: TLabel;
    edtTAX_MONEY: TcxTextEdit;
    Label3: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns7UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtINVOICE_FLAGPropertiesChange(Sender: TObject);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure actPrintBarcodeExecute(Sender: TObject);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure fndGODS_IDAddClick(Sender: TObject);
    procedure edtCLIENT_IDAddClick(Sender: TObject);
    procedure edtGUIDE_USERAddClick(Sender: TObject);
    procedure edtSHOP_IDSaveValue(Sender: TObject);
    procedure edtTableAfterScroll(DataSet: TDataSet);
    procedure edtSTK_GLIDE_NOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    //结算金额
    TotalFee:real;
    //默认发票类型
    DefInvFlag:integer;
    //普通税率
    InRate2:real;
    //增值税率
    InRate3:real;
    function  CheckCanExport: boolean; override;    
  protected
    procedure ReadHeader;
    procedure WMFillData(var Message: TMessage); message WM_FILL_DATA;
    function CheckInput:boolean;override;
  public
    { Public declarations }
    procedure ShowInfo;
    procedure ShowOweInfo;
    function  Calc:real;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure AmountToCalc(Amount:Real);override;
    procedure PriceToCalc(APrice:Real);override;
    procedure AMoneyToCalc(AMoney:Real);override;
    procedure AgioToCalc(Agio:Real);override;
    procedure UnitToCalc(UNIT_ID:string);override;
    procedure PresentToCalc(Present:integer);override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure AuditOrder;override;
    procedure Open(id:string);override;
    procedure PrintBarcode;
  end;

implementation
uses uGlobal,uShopUtil,uDsUtil,uFnUtil,uShopGlobal,ufrmSupplierInfo, ufrmGoodsInfo, ufrmUsersInfo,ufrmStockOrder,ufrmFindOrder
  ;
{$R *.dfm}

procedure TfrmStkRetuOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmStkRetuOrder.DeleteOrder;
begin
  inherited;
  Saved := false;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能删除');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TStkRetuOrder');
    Factor.AddBatch(cdsDetail,'TStkRetuData');
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
    ReadHeader;

    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('STOCK_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    dbState := dsBrowse;
    ShowOweInfo;
end;

procedure TfrmStkRetuOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改'); 
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;
  if edtCLIENT_ID.CanFocus then edtCLIENT_ID.SetFocus;
end;

procedure TfrmStkRetuOrder.FormCreate(Sender: TObject);
begin
  inherited;
  CanAppend := true;
  fndMY_AMOUNT.Visible := ShopGlobal.GetChkRight('14500001',1); //是否有库存查询权限
  Label6.Visible := fndMY_AMOUNT.Visible;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
  edtGUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtDEPT_ID.RangeField := 'DEPT_TYPE';
  edtDEPT_ID.RangeValue := '1'; 
  InRate2 := StrtoFloatDef(ShopGlobal.GetParameter('IN_RATE2'),0.05);
  InRate3 := StrtoFloatDef(ShopGlobal.GetParameter('IN_RATE3'),0.17);
  DefInvFlag := StrtoIntDef(ShopGlobal.GetParameter('IN_INV_FLAG'),1);
  if not ShopGlobal.GetChkRight('14500001',2) then
     begin
       DBGridEh1.Columns[12].Free;
       DBGridEh1.Columns[11].Free;
       DBGridEh1.Columns[7].Free;
       DBGridEh1.Columns[6].Free;
     end;
end;

procedure TfrmStkRetuOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs:TZQuery;
  str,InLevel:string;
begin
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');
  edtTable.Edit;
  if UNIT_ID=rs.FieldbyName('SMALL_UNITS').AsString then
  begin
     edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_INPRICE1').AsFloat;
     edtTable.FieldbyName('ORG_PRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE1').AsFloat;
  end
  else
  if UNIT_ID=rs.FieldbyName('BIG_UNITS').AsString then
  begin
     edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_INPRICE2').AsFloat;
     edtTable.FieldbyName('ORG_PRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE2').AsFloat;
  end
  else
  begin
     edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_INPRICE').AsFloat;
     edtTable.FieldbyName('ORG_PRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE').AsFloat;
  end;
  ShowInfo;
end;

procedure TfrmStkRetuOrder.NewOrder;
var
  rs:TZQuery;
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
  cid := edtSHOP_ID.KeyValue;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  AObj.FieldbyName('STOCK_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('STOCK_ID').asString;
  gid := '..新增..';
  edtSTOCK_DATE.Date := Global.SysDate;
  edtGUIDE_USER.KeyValue := Global.UserID;
  edtGUIDE_USER.Text := Global.UserName;
  edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',InttoStr(DefInvFlag));
  edtINVOICE_FLAGPropertiesChange(nil);
  InitRecord;
  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmStkRetuOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := cid;
    Params.ParamByName('STOCK_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TStkRetuOrder',Params);
      Factor.AddBatch(cdsDetail,'TStkRetuData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  //2011.04.02 提到ReadFromObject之前
    edtSHOP_ID.Properties.ReadOnly := True;  
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    edtTAX_RATE.Value := AObj.FieldbyName('TAX_RATE').AsFloat*100;
    ReadHeader;

    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('STOCK_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    ShowOweInfo;
  finally
    Params.Free;
  end;
end;

procedure TfrmStkRetuOrder.SaveOrder;
var mny,amt:real;
begin
  inherited;
  Saved := false;
  if edtSTOCK_DATE.EditValue = null then Raise Exception.Create('入库日期不能为空');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('供应商不能为空');
  if edtINVOICE_FLAG.ItemIndex = -1 then Raise Exception.Create('票据类型不能为空');
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cid := edtSHOP_ID.asString;
  AObj.FieldByName('ADVA_MNY').AsFloat := 0;
  AObj.FieldByName('STOCK_TYPE').AsInteger := 3;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  AObj.FieldbyName('TAX_RATE').AsFloat := edtTAX_RATE.Value / 100;
  Calc;
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
         cdsDetail.FieldByName('TENANT_ID').AsString := cdsHeader.FieldbyName('TENANT_ID').AsString;
         cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
         cdsDetail.FieldByName('STOCK_ID').AsString := cdsHeader.FieldbyName('STOCK_ID').AsString;
         cdsDetail.FieldByName('TAX_RATE').AsFloat := cdsHeader.FieldbyName('TAX_RATE').AsFloat;
         mny := mny + cdsDetail.FieldbyName('CALC_MONEY').asFloat;
         amt := amt + cdsDetail.FieldbyName('AMOUNT').asFloat;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    cdsHeader.Edit;
    cdsHeader.FieldbyName('STOCK_MNY').asFloat := mny;
    cdsHeader.FieldbyName('STOCK_AMT').asFloat := amt;
    cdsHeader.Post;
    Factor.AddBatch(cdsHeader,'TStkRetuOrder');
    Factor.AddBatch(cdsDetail,'TStkRetuData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmStkRetuOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
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
          if abs(r)>999999 then Raise Exception.Create('输入的数值过大，无效');
        except
          Text := TColumnEh(Sender).Field.AsString;
          Value := TColumnEh(Sender).Field.asFloat;
          Raise Exception.Create('输入无效数值型');
        end;
        TColumnEh(Sender).Field.asFloat := r;
        AMountToCalc(r);
     end;
end;

procedure TfrmStkRetuOrder.DBGridEh1Columns7UpdateData(Sender: TObject;
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

procedure TfrmStkRetuOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
    if abs(r)>999999 then Raise Exception.Create('输入的数值过大，无效');
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  TColumnEh(Sender).Field.asFloat := r;
  AMoneyToCalc(r);
end;

procedure TfrmStkRetuOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
    if abs(r)>999999 then Raise Exception.Create('输入的数值过大，无效');
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  TColumnEh(Sender).Field.asFloat := r;
  PriceToCalc(r);
end;

procedure TfrmStkRetuOrder.edtINVOICE_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  if Locked then Exit;
  if dbState=dsBrowse then Exit;
  if edtINVOICE_FLAG.ItemIndex < 0 then Exit;
  case TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  1:AObj.FieldbyName('TAX_RATE').AsFloat := 0;
  2:AObj.FieldbyName('TAX_RATE').AsFloat := InRate2;
  3:AObj.FieldbyName('TAX_RATE').AsFloat := InRate3;
  end;
  edtTAX_RATE.Value := AObj.FieldbyName('TAX_RATE').AsFloat*100;
//  edtTAX_RATE.Visible := (TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger<>1);
  Calc;
end;

procedure TfrmStkRetuOrder.edtCLIENT_IDSaveValue(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  if (edtCLIENT_ID.AsString='') and edtCLIENT_ID.Focused and ShopGlobal.GetChkRight('33100001',2) then
     begin
       if MessageBox(Handle,'没找到你想查找的供应商是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       edtCLIENT_ID.OnAddClick(nil);
       Exit;
     end;
   rs := Global.GetZQueryFromName('PUB_CLIENTINFO');
   if not rs.Locate('CLIENT_ID',edtCLIENT_ID.AsString,[]) then Raise Exception.Create('选择的供应商没找到,异常错误.');
   Locked := true;
   try
     if rs.FieldbyName('INVOICE_FLAG').AsInteger > 0 then
        begin
          AObj.FieldbyName('TAX_RATE').AsFloat := rs.FieldbyName('TAX_RATE').AsFloat;
          edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',rs.FieldbyName('INVOICE_FLAG').AsString);
          edtTAX_RATE.Value := AObj.FieldbyName('TAX_RATE').AsFloat;
        end;
     Calc;
   finally
     Locked := false;
   end;
  ShowOweInfo;
end;

function TfrmStkRetuOrder.Calc:real;
var
  r:integer;
  TotalFee:real;
  TotalAmt:real;
begin
  edtTable.DisableControls;
  try
    r := edtTable.FieldbyName('SEQNO').AsInteger;
    TotalFee := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        TotalFee := TotalFee + edtTable.FieldbyName('CALC_MONEY').AsFloat;
        TotalAmt := TotalAmt + edtTable.FieldbyName('AMOUNT').AsFloat;
        edtTable.Next;
      end;
    result := TotalFee;
  finally
    edtTable.Locate('SEQNO',r,[]); 
    edtTable.EnableControls;
  end;
//  edtCALC_MONEY.Text := formatFloat('#0.00',TotalFee);
  edtTAX_MONEY.Text := formatFloat('#0.00',(TotalFee/(1+AObj.FieldbyName('TAX_RATE').AsFloat))*AObj.FieldbyName('TAX_RATE').AsFloat);
  if dbState <> dsBrowse then
     begin
       edtRECK_MNY.Text := formatFloat('#0.0##',TotalFee-StrtoFloatDef(edtRECV_MNY.Text,0));
     end;
end;

procedure TfrmStkRetuOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  Calc;

end;

procedure TfrmStkRetuOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmStkRetuOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前退货单执行弃审');
       if MessageBox(Handle,'确认弃审当前退货单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前退货单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('STOCK_ID').asString := cdsHeader.FieldbyName('STOCK_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TStkRetuOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TStkRetuOrderUnAudit',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    IsAudit := not IsAudit;
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
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
end;

procedure TfrmStkRetuOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;

end;

procedure TfrmStkRetuOrder.PrintBarcode;
{
procedure AddTo(DataSet:TDataSet;ID,P1,P2:string;amt:Integer);
function PubGetBarCode:string;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
    rs.CommandText := 'select BARCODE from PUB_BARCODE where GODS_ID='''+ID+''' and PROPERTY_01='''+P1+''' and PROPERTY_02='''+P2+''' and BATCH_NO=''#''';
    Factor.Open(rs);
    result := rs.Fields[0].AsString;
  finally
    rs.Free;
  end;
end;
var
  rs:TADODataSet;
begin
  rs := Global.GetADODataSetFromName('BAS_GOODSINFO');
  if rs.Locate('GODS_ID',ID,[]) then
  begin
    DataSet.Append;
    DataSet.FieldByName('A').AsBoolean := true;
    DataSet.FieldByName('GODS_ID').AsString := rs.FieldByName('GODS_ID').AsString;;
    DataSet.FieldByName('BCODE').AsString := rs.FieldByName('BCODE').AsString;
    DataSet.FieldByName('GODS_NAME').AsString := rs.FieldByName('GODS_NAME').AsString;
    DataSet.FieldByName('GODS_CODE').AsString := rs.FieldByName('GODS_CODE').AsString;;
    DataSet.FieldByName('NEW_OUTPRICE').AsString := rs.FieldByName('NEW_OUTPRICE').AsString;
    DataSet.FieldByName('NEW_CUSTPRICE').AsString := rs.FieldByName('NEW_CUSTPRICE').AsString;
    DataSet.FieldByName('PROPERTY_01').AsString := P1;
    DataSet.FieldByName('PROPERTY_02').AsString := P2;
    //
    DataSet.FieldByName('BARCODE').AsString := PubGetBarCode;
    if (DataSet.FieldByName('BARCODE').AsString='') or fnString.IsCustBarCode(DataSet.FieldByName('BARCODE').AsString) then
       DataSet.FieldByName('BARCODE').AsString := GetBarCode(rs.FieldByName('BCODE').AsString,
         P1,P2);
    DataSet.FieldByName('AMOUNT').AsInteger := amt;
    DataSet.Post;
  end;
end;
var amt,i,RecNo:integer;
}
begin
  inherited;
  {
  RecNo := edtTable.RecNo;
  edtTable.DisableControls;
  try
  with TfrmBarCodePrint.Create(self) do
    begin
      try
        adoPrint.Close;
        adoPrint.CreateDataSet;
        edtTable.First;
        while not edtTable.Eof do
          begin
            if PropertyEnabled then
               begin
                 edtProperty.Filtered := false;
                 edtProperty.Filter := 'SEQNO='+edtTable.FieldbyName('SEQNO').AsString;
                 edtProperty.Filtered := true;
                 edtProperty.First;
                 while not edtProperty.Eof do
                    begin
                      AddTo(adoPrint,edtProperty.FieldbyName('GODS_ID').AsString,edtProperty.FieldbyName('PROPERTY_01').AsString,edtProperty.FieldbyName('PROPERTY_02').AsString,trunc(edtProperty.FieldbyName('CALC_AMOUNT').AsFloat));
                      edtProperty.Next;
                    end;
               end
            else
               begin
                 AddTo(adoPrint,edtTable.FieldbyName('GODS_ID').AsString,'#','#',trunc(edtTable.FieldbyName('CALC_AMOUNT').AsFloat));
               end;
            edtTable.Next;
          end;
        ShowModal;
      finally
        free;
      end;
    end;
  finally
    if RecNo>0 then edtTable.RecNo := RecNo;
    edtTable.EnableControls;
  end;
  }
end;

procedure TfrmStkRetuOrder.actPrintBarcodeExecute(Sender: TObject);
begin
  inherited;
  if IsNull then Raise Exception.Create('请输入商品后，再打印条码'); 
  PrintBarcode;
end;

procedure TfrmStkRetuOrder.fndGODS_IDSaveValue(Sender: TObject);
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

procedure TfrmStkRetuOrder.fndGODS_IDAddClick(Sender: TObject);
var r:TRecord_;
begin

//  if not ShopGlobal.GetChkRight('200036') then Exit;
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
                  edtTable.FieldByName('NEW_OUTAMONEY').AsString:=formatfloat('#0.000',edtTable.FieldbyName('NEW_OUTPRICE').AsFloat*edtTable.FieldbyName('CALC_AMOUNT').AsFloat);
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

procedure TfrmStkRetuOrder.edtCLIENT_IDAddClick(Sender: TObject);
var r:TRecord_;
begin
  inherited;
  r := TRecord_.Create;
  try
    if TfrmSupplierInfo.AddDialog(self,r) then
       begin
         edtCLIENT_ID.KeyValue := r.FieldbyName('CLIENT_ID').AsString;
         edtCLIENT_ID.Text := r.FieldbyName('CLIENT_NAME').AsString;
         edtCLIENT_ID.OnSaveValue(nil);
       end;
  finally
    r.Free;
  end;

end;

procedure TfrmStkRetuOrder.edtGUIDE_USERAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;

  r := TRecord_.Create;
  try
    if TfrmUsersInfo.AddDialog(self,r) then
       begin
         edtGUIDE_USER.KeyValue := r.FieldbyName('USER_ID').AsString;
         edtGUIDE_USER.Text := r.FieldbyName('USER_NAME').AsString;
       end;
  finally
    r.Free;
  end;
  
end;

procedure TfrmStkRetuOrder.ReadHeader;
begin
end;

procedure TfrmStkRetuOrder.ShowOweInfo;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select sum(RECK_MNY),-sum(case when STOCK_ID='''+oid+''' then RECK_MNY else 0 end),-sum(case when STOCK_ID='''+oid+''' then PAYM_MNY else 0 end) from ACC_PAYABLE_INFO where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
    Factor.Open(rs);
    if rs.Fields[0].AsString<>'' then
       fndRECK_MNY.Text := formatFloat('#0.00',rs.Fields[0].AsFloat)
    else
       fndRECK_MNY.Text := formatFloat('#0.00',0);
    if rs.Fields[1].asString<>'' then
       edtRECK_MNY.Text := formatFloat('#0.0##',rs.Fields[1].AsFloat)
    else
       edtRECK_MNY.Text := formatFloat('#0.0##',0);
    if rs.Fields[2].asString<>'' then
       edtRECV_MNY.Text := formatFloat('#0.0##',rs.Fields[2].AsFloat)
    else
       edtRECV_MNY.Text := formatFloat('#0.0##',0);
  finally
    rs.Free;
  end;
end;

procedure TfrmStkRetuOrder.ShowInfo;
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

procedure TfrmStkRetuOrder.edtSHOP_IDSaveValue(Sender: TObject);
begin
  inherited;
  cid := edtSHOP_ID.asString;
  ShowInfo;
end;

procedure TfrmStkRetuOrder.PresentToCalc(Present: integer);
begin
  inherited;
  ShowInfo;

end;

procedure TfrmStkRetuOrder.UnitToCalc(UNIT_ID: string);
begin
  inherited;
  ShowInfo;

end;

procedure TfrmStkRetuOrder.edtTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then ShowInfo;

end;

procedure TfrmStkRetuOrder.AmountToCalc(Amount: Real);
begin
  inherited;
  edtTable.Edit;
  edtTable.FieldbyName('RTL_MONEY').AsFloat := edtTable.FieldbyName('AMOUNT').AsFloat*edtTable.FieldbyName('ORG_PRICE').AsFloat;
end;

procedure TfrmStkRetuOrder.AgioToCalc(Agio: Real);
begin
  inherited;
end;

procedure TfrmStkRetuOrder.AMoneyToCalc(AMoney: Real);
begin
  inherited;
end;

procedure TfrmStkRetuOrder.PriceToCalc(APrice: Real);
begin
  inherited;
end;

procedure TfrmStkRetuOrder.WMFillData(var Message: TMessage);
var
  frmStockOrder:TfrmStockOrder;
  i:integer;
begin
  if dbState <> dsInsert then Raise Exception.Create('不是在新增状态不能完成操作');
  frmStockOrder := TfrmStockOrder(Message.WParam);
  with TfrmStockOrder(frmStockOrder) do
    begin
      self.edtCLIENT_ID.KeyValue := edtCLIENT_ID.KeyValue;
      self.edtCLIENT_ID.Text := edtCLIENT_ID.Text;
      self.edtSHOP_ID.KeyValue := edtSHOP_ID.KeyValue;
      self.edtSHOP_ID.Text := edtSHOP_ID.Text;
      self.edtGUIDE_USER.KeyValue := edtGUIDE_USER.KeyValue;
      self.edtGUIDE_USER.Text := edtGUIDE_USER.Text;
      self.edtDEPT_ID.KeyValue := edtDEPT_ID.KeyValue;
      self.edtDEPT_ID.Text := edtDEPT_ID.Text;
      self.AObj.FieldbyName('FROM_ID').AsString := AObj.FieldbyName('STOCK_ID').AsString;
      self.edtSTK_GLIDE_NO.Text := AObj.FieldbyName('GLIDE_NO').AsString;
      self.edtREMARK.Text := edtREMARK.Text;
      self.Locked := true;
      try
        self.edtINVOICE_FLAG.ItemIndex := edtINVOICE_FLAG.ItemIndex;
        self.edtTAX_RATE.Value := edtTAX_RATE.Value;
      finally
        self.Locked := false;
      end;
      case Message.LParam of
      0:self.ReadFrom(cdsDetail);
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
          finally
            self.edtTable.EnableControls;
          end;
        end;
      end;

    end;
  inherited;
end;

function TfrmStkRetuOrder.CheckInput: boolean;
begin
  result := not (pos(inttostr(InputFlag),'124')>0);
end;

procedure TfrmStkRetuOrder.edtSTK_GLIDE_NOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  s:string;
  h,d:TZQuery;
  Params:TftParamList;
  HObj:TRecord_;
begin
  inherited;
  if not IsNull then Raise Exception.Create('已经输入商品了，不能导入销售单.');
  if dbState <> dsInsert then Raise Exception.Create('只有不是新增状态的单据不能导入销售单.');  
  s := TfrmFindOrder.FindDialog(self,3,edtCLIENT_ID.asString,edtSHOP_ID.asString);
  if s<>'' then
     begin
       h := TZQuery.Create(nil);
       d := TZQuery.Create(nil);
       Params := TftParamList.Create(nil);
       HObj := TRecord_.Create;
       try
          Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
          Params.ParamByName('STOCK_ID').asString := s;
          Factor.BeginBatch;
          try
            Factor.AddBatch(h,'TStockOrder',Params);
            Factor.AddBatch(d,'TStockData',Params);
            Factor.OpenBatch;
            HObj.ReadFromDataSet(h);
            ReadFromObject(HObj,self);
            AObj.FieldbyName('FROM_ID').AsString := HObj.FieldbyName('STOCK_ID').AsString;
            edtSTK_GLIDE_NO.Text := HObj.FieldbyName('GLIDE_NO').AsString;
            edtSTOCK_DATE.Date := Global.SysDate;
            ReadFrom(d);
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
end;

function TfrmStkRetuOrder.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('11300001',7);
end;

end.
