unit ufrmStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmOrderForm, RzButton, RzPanel, cxTextEdit, cxDropDownEdit,
  cxCalendar, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, StdCtrls, RzLabel, ExtCtrls, RzBmpBtn,
  RzBorder, RzTabs, RzStatus, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZBase, Math, Menus, pngimage, RzBckgnd, jpeg, PrnDbgeh,ufrmDBGridPreview,
  ComCtrls, ToolWin, ImgList, FR_Class;

type
  TfrmStockOrder = class(TfrmOrderForm)
    TabSheet2: TRzTabSheet;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    customerInfo: TLabel;
    RzPanel11: TRzPanel;
    RzPanel14: TRzPanel;
    zrComboBoxList1: TzrComboBoxList;
    cxComboBox1: TcxComboBox;
    DBGridEh2: TDBGridEh;
    dsList: TDataSource;
    cdsList: TZQuery;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzToolButton3: TRzToolButton;
    RzSpacer1: TRzSpacer;
    edtBK_CLIENT_ID: TRzPanel;
    RzPanel21: TRzPanel;
    RzBackground1: TRzBackground;
    RzLabel6: TRzLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtBK_SALES_DATE: TRzPanel;
    RzPanel20: TRzPanel;
    RzBackground2: TRzBackground;
    RzLabel7: TRzLabel;
    edtSTOCK_DATE: TcxDateEdit;
    Image2: TImage;
    edtBK_GUIDE_USER: TRzPanel;
    RzPanel4: TRzPanel;
    RzBackground3: TRzBackground;
    RzLabel8: TRzLabel;
    edtGUIDE_USER: TzrComboBoxList;
    edtREMARK: TcxTextEdit;
    edtBK_ACCT_MNY: TRzPanel;
    RzLabel9: TRzLabel;
    RzPanel7: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel10: TRzLabel;
    edtACCT_MNY: TcxTextEdit;
    edtAGIO_RATE: TcxTextEdit;
    RzPanel8: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel11: TRzLabel;
    edtBK_PAY_TOTAL: TRzPanel;
    RzPanel10: TRzPanel;
    RzBackground6: TRzBackground;
    payment: TRzLabel;
    edtPAY_TOTAL: TcxTextEdit;
    RzPanel3: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel9: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel17: TRzLabel;
    dateFlag: TcxComboBox;
    D1: TcxDateEdit;
    RzPanel23: TRzPanel;
    RzPanel22: TRzPanel;
    RzBackground8: TRzBackground;
    RzLabel16: TRzLabel;
    D2: TcxDateEdit;
    RzPanel5: TRzPanel;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;
    serachText: TEdit;
    btnFind: TRzBmpButton;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel12: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    RzPanel19: TRzPanel;
    Image5: TImage;
    MarqueeStatus: TRzMarqueeStatus;
    Image6: TImage;
    Image7: TImage;
    PrintDBGridEh1: TPrintDBGridEh;
    frfStockOrder: TfrReport;
    btnSave: TRzBmpButton;
    btnNew: TRzBmpButton;
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnNavClick(Sender: TObject);
    procedure dateFlagPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzToolButton2Click(Sender: TObject);
    procedure RzToolButton3Click(Sender: TObject);
    procedure RzToolButton1Click(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure DBGridEh1Columns8UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure PageControlChange(Sender: TObject);
    procedure serachTextEnter(Sender: TObject);
    procedure serachTextExit(Sender: TObject);
    procedure edtTableAfterDelete(DataSet: TDataSet);
    procedure serachTextChange(Sender: TObject);
    procedure cdsListBeforeOpen(DataSet: TDataSet);
    procedure serachTextKeyPress(Sender: TObject; var Key: Char);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure paymentClick(Sender: TObject);
    procedure frfStockOrderGetValue(const ParName: String;
      var ParValue: Variant);
    procedure frfStockOrderUserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
    procedure edtACCT_MNYKeyPress(Sender: TObject; var Key: Char);
    procedure edtAGIO_RATEKeyPress(Sender: TObject; var Key: Char);
    procedure edtPAY_TOTALKeyPress(Sender: TObject; var Key: Char);
  private
    AObj:TRecord_;
    //默认发票类型
    DefInvFlag:integer;
    //普通税率
    InRate2:Currency;
    //增值税率
    InRate3:Currency;
    //结算金额
    TotalFee:Currency;
    //结算数量
    TotalAmt:Currency;

    searchTxt:string;
    procedure DBGridPrint;
  protected
    procedure SetdbState(const Value: TDataSetState);override;
    procedure SetinputFlag(const Value: integer);override;
    function  checkPayment:boolean;
    function  payCashMny(s:string):boolean;
    procedure DoShowPayment;
    procedure Calc; //2011.06.09判断是否限量
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    function  getPaymentTitle(pay:string):string;

    //快捷健
    function  doShortCut(s:string):boolean;override;
    procedure DoIsPresent(s:string);
    procedure DoCustId(s:string);override;
    procedure DoGuideUser(s:string);
    procedure DoNewOrder;
    procedure DoSaveOrder;
    procedure DoHangUp;
    procedure DoPickUp;
    procedure DoPayZero(s:string);
    procedure DoPayInput(s:string;flag:string);

    procedure BarcodeInput(_Buf:string);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure showForm;override;

    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure Open(id:string);override;

    procedure PrintOrder;override;
    procedure PreviewOrder;override;

    procedure OpenList;
  end;

var frmStockOrder: TfrmStockOrder;

implementation

uses utokenFactory,udllDsUtil,udllShopUtil,uFnUtil,udllGlobal,udataFactory,ufrmPayment,
     ufrmOrderPreview,ufrmSaveDesigner;

{$R *.dfm}

{ TfrmStockOrder }

procedure TfrmStockOrder.Calc;
var
  r:integer;
  Controls:boolean;
  orgFee:Currency;
begin
  Controls := edtTable.ControlsDisabled;
  edtTable.DisableControls;
  try
    r := edtTable.FieldbyName('SEQNO').AsInteger;
    orgFee := TotalFee;
    TotalFee := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        TotalFee := TotalFee + edtTable.FieldbyName('CALC_MONEY').AsFloat;
        TotalAmt := TotalAmt + edtTable.FieldbyName('AMOUNT').AsFloat;
        edtTable.Next;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]); 
    if not Controls then edtTable.EnableControls;
  end;
  if (dbState<>dsBrowse) then
  begin
    AObj.FieldbyName('STOCK_AMT').asFloat := TotalAmt;
    AObj.FieldbyName('STOCK_MNY').asFloat := TotalFee;
    if orgFee<>TotalFee then
       AObj.FieldbyName('PAY_ZERO').asFloat := 0;

    edtACCT_MNY.Text := formatFloat('#0.00',TotalFee);
    edtAGIO_RATE.Text := '100.0';
    DoShowPayment;
  end;
end;

procedure TfrmStockOrder.CancelOrder;
begin
  if dbState = dsBrowse then Exit;
  if dbState = dsInsert then
     NewOrder
  else
     Open(AObj.FieldbyName('STOCK_ID').AsString);
end;

constructor TfrmStockOrder.Create(AOwner: TComponent);
begin
  inherited;
  AObj := TRecord_.Create;
end;

procedure TfrmStockOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  dataFactory.BeginBatch;
  try
    dataFactory.AddBatch(cdsHeader,'TStockOrderV60');
    dataFactory.AddBatch(cdsDetail,'TStockDataV60');
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  AObj.ReadFromDataSet(cdsHeader);
  ReadFromObject(AObj,self);
  ReadFrom(cdsDetail);
  dbState := dsBrowse;
end;

destructor TfrmStockOrder.Destroy;
begin
  AObj.Free;
  inherited;
end;

procedure TfrmStockOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if cdsHeader.FieldByName('FROM_ID').AsString<>'' then Raise Exception.Create('当前版本不能处理从进货订单入库的单据。');  
  if cdsHeader.FieldByName('FIG_ID').AsString<>'' then Raise Exception.Create('当前版本不能处理从配货单生成的单据。');  
  dbState := dsEdit;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus
  else
  if edtCLIENT_ID.CanFocus and Visible then
     edtCLIENT_ID.SetFocus;
end;

procedure TfrmStockOrder.NewOrder;
var rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  AObj.FieldbyName('TENANT_ID').AsString := token.tenantId;
  AObj.FieldbyName('SHOP_ID').asString := token.shopId;

  AObj.FieldbyName('DEPT_ID').asString := dllGlobal.getMyDeptId;

  AObj.FieldbyName('STOCK_ID').asString := TSequence.NewId();
  edtCLIENT_ID.KeyValue := token.tenantId;
  edtCLIENT_ID.Text := token.tenantName;

  AObj.FieldByName('STOCK_AMT').AsFloat := 0;
  AObj.FieldByName('STOCK_MNY').AsFloat := 0;
  AObj.FieldByName('PAY_ZERO').AsFloat := 0;
  AObj.FieldByName('PAY_A').AsFloat := 0;
  AObj.FieldByName('PAY_B').AsFloat := 0;
  AObj.FieldByName('PAY_C').AsFloat := 0;
  AObj.FieldByName('PAY_D').AsFloat := 0;
  AObj.FieldByName('PAY_E').AsFloat := 0;
  AObj.FieldByName('PAY_F').AsFloat := 0;
  AObj.FieldByName('PAY_G').AsFloat := 0;
  AObj.FieldByName('PAY_H').AsFloat := 0;
  AObj.FieldByName('PAY_I').AsFloat := 0;
  AObj.FieldByName('PAY_J').AsFloat := 0;

  edtSTOCK_DATE.Date := dllGlobal.SysDate;

  edtGUIDE_USER.KeyValue := token.userId;
  edtGUIDE_USER.Text := token.username;

  AObj.FieldbyName('INVOICE_FLAG').AsInteger := DefInvFlag;
  case DefInvFlag of
  1: AObj.FieldbyName('TAX_RATE').AsFloat := 0;
  2: AObj.FieldbyName('TAX_RATE').AsFloat := InRate2;
  3: AObj.FieldbyName('TAX_RATE').AsFloat := InRate3;
  end;
  InitRecord;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus
  else
  if edtCLIENT_ID.CanFocus and Visible then
     edtCLIENT_ID.SetFocus;
end;

procedure TfrmStockOrder.Open(id: string);
var Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    Params.ParamByName('STOCK_ID').asString := id;
    Params.ParamByName('VIW_GOODSINFO').AsString := dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE',true);
    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsHeader,'TStockOrderV60',Params);
      dataFactory.AddBatch(cdsDetail,'TStockDataV60',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
    AObj.ReadFromDataSet(cdsHeader);
    dbState := dsBrowse; 
    ReadFromObject(AObj,self);
    ReadFrom(cdsDetail);
    Calc;
  finally
    Params.Free;
  end;
end;

procedure TfrmStockOrder.SaveOrder;
var Printed:boolean;
begin
  if dbState = dsBrowse then Exit;

  if edtSTOCK_DATE.EditValue = null then Raise Exception.Create('进货日期不能为空');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('供应商不能为空');

  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  WriteToObject(AObj,self);

  AObj.FieldByName('STOCK_TYPE').AsInteger := 1;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := token.userId;
  AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',dllGlobal.SysDate);
  AObj.FieldByName('CHK_USER').AsString := token.userId;
  AObj.FieldByName('LOCUS_STATUS').AsString := '3';
  if not checkPayment then Exit;
  dataFactory.BeginBatch;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    WriteTo(cdsDetail);
    cdsDetail.First;
    while not cdsDetail.Eof do
       begin
         cdsDetail.Edit;
         cdsDetail.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
         cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
         cdsDetail.FieldByName('STOCK_ID').AsString := cdsHeader.FieldbyName('STOCK_ID').AsString;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    dataFactory.AddBatch(cdsHeader,'TStockOrderV60');
    dataFactory.AddBatch(cdsDetail,'TStockDataV60');
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  dbState := dsBrowse;
end;

procedure TfrmStockOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;
end;

procedure TfrmStockOrder.showForm;
begin
  inherited;
  InRate2 := StrtoFloatDef(dllGlobal.GetParameter('IN_RATE2'),0.05);
  InRate3 := StrtoFloatDef(dllGlobal.GetParameter('IN_RATE3'),0.17);
  DefInvFlag := StrtoIntDef(dllGlobal.GetParameter('IN_INV_FLAG'),1);

  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');
  edtGUIDE_USER.DataSet := dllGlobal.GetZQueryFromName('CA_USERS');
  NewOrder;
end;

procedure TfrmStockOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  fndGODS_ID.Text := edtTable.FieldbyName('GODS_NAME').AsString;
  fndGODS_ID.KeyValue := edtTable.FieldbyName('GODS_ID').AsString;
  fndGODS_ID.SaveStatus;
end;

procedure TfrmStockOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
   if length(Text)>10 then
      begin
         Text := TColumnEh(Sender).Field.AsString;
         Value := TColumnEh(Sender).Field.asFloat;
         Exit;
      end;
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

procedure TfrmStockOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin
   if length(Text)>10 then
      begin
         Text := TColumnEh(Sender).Field.AsString;
         Value := TColumnEh(Sender).Field.asFloat;
         Exit;
      end;
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
  PriceToCalc(r);
end;

procedure TfrmStockOrder.btnSaveClick(Sender: TObject);
begin
  inherited;
  case dbState of
  dsBrowse:begin
      NewOrder;
    end;
  else
    begin
      SaveOrder;
      if dllGlobal.GetChkRight('12400001',2) and (MessageBox(Handle,'是否继续新增进货单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
         NewOrder
      else
         Open(AObj.FieldbyName('STOCK_ID').AsString);
    end;
  end;
end;

procedure TfrmStockOrder.InitPrice(GODS_ID, UNIT_ID: string);
begin
  if edtTable.State = dsBrowse then edtTable.Edit;
  edtTable.FieldbyName('APRICE').AsFloat :=dllGlobal.GetNewInPrice(GODS_ID,UNIT_ID);
  edtTable.FieldbyName('ORG_PRICE').AsFloat :=dllGlobal.GetNewOutPrice(GODS_ID,UNIT_ID);
  case DefInvFlag of
  1: edtTable.FieldbyName('TAX_RATE').AsFloat := 0;
  2: edtTable.FieldbyName('TAX_RATE').AsFloat := InRate2;
  3: edtTable.FieldbyName('TAX_RATE').AsFloat := InRate3;
  end;
end;

procedure TfrmStockOrder.SetinputFlag(const Value: integer);
function getPayment:string;
var
  rs:TZQuery;
begin
  result := '';
  rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
  rs.First;
  while not rs.Eof do
    begin
      if result <> '' then result := result+' ';
      result := result +rs.FieldbyName('CODE_ID').asString+'.'+rs.FieldbyName('CODE_NAME').AsString;
      rs.Next;
    end;
end;
begin
  inherited;
  case Value of
  5:begin
      FInputFlag := value;
      lblInput.Caption := '进货类型';
      lblHint.Caption := '"1.正常进货、2.赠送商品" 请输入类型序号后按 enter 健';
    end;
  6:begin
      FInputFlag := value;
      lblInput.Caption := '供 应 商';
      lblHint.Caption := '请输入完整的"供应商编码或手机号"后按 enter 健';
    end;
  7:begin
      FInputFlag := value;
      lblInput.Caption := '收 货 员';
      lblHint.Caption := '请输入收货员员工编号后按 enter 健';
    end;
  11:begin
      FInputFlag := value;
      lblInput.Caption := '应付金额';
      lblHint.Caption := '请直接输入结算金额或折扣率(如95折/95)后按 enter 健';
    end;
  13:begin
      FInputFlag := value;
      lblInput.Caption := '输入金额';
      lblHint.Caption := '请输入支付金额后按"'+getPayment+'"';
    end;
  14:begin
      FInputFlag := value;
      lblInput.Caption := '实收现金';
      lblHint.Caption := '请输入实收现金后按 enter 健或+健';
    end;
  end;
end;

procedure TfrmStockOrder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F5 then
     begin
       if edtTable.FieldbyName('IS_PRESENT').AsString = '1' then
          DoIsPresent('1')
       else
          DoIsPresent('2');
     end;
  if Key = VK_F6 then
     begin
       inputMode := 1;
       inputFlag := 6;
       edtInput.SetFocus;
     end;
  if Key = VK_F7 then
     begin
       inputMode := 1;
       inputFlag := 7;
       edtInput.SetFocus;
     end;
  if Key = VK_F8 then
     begin
       DoNewOrder;
     end;
  if Key = VK_F9 then
     begin
       DoHangUp;
     end;
  if Key = VK_F10 then
     begin
       DoPickUp;
     end;
  if Key = VK_F11 then
     begin
       inputMode := 1;
       inputFlag := 11;
       edtInput.SetFocus;
     end;
end;

procedure TfrmStockOrder.DoCustId(s:string);
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
      'select CLIENT_ID,CLIENT_NAME from VIW_CLIENTINFO where TENANT_ID='+token.tenantId+' and (TELEPHONE2='''+s+''' or CLIENT_CODE='''+s+''') and COMM not in (''02'',''12'')';
    dllGlobal.OpenSqlite(rs);
    if rs.IsEmpty then Raise Exception.Create('你输入的供应商编号无效');  
    edtCLIENT_ID.KeyValue := rs.FieldbyName('CLIENT_ID').AsString;
    edtCLIENT_ID.Text := rs.FieldbyName('CLIENT_NAME').AsString;
  finally
    rs.free;
  end;
end;

procedure TfrmStockOrder.DoGuideUser(s:string);
var rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('CA_USERS');
  if rs.Locate('ACCOUNT',s,[]) then
     begin
       edtGUIDE_USER.KeyValue := rs.FieldbyName('USER_ID').AsString;
       edtGUIDE_USER.Text := rs.FieldbyName('USER_NAME').AsString;
     end;
end;

procedure TfrmStockOrder.DoIsPresent(s:string);
begin
  if s='1' then
     PresentToCalc(0)
  else
  if s='2' then
     PresentToCalc(1)
  else
     Raise Exception.Create('不支持的销售类型，请输入1-3之间的类型序号');
end;

procedure TfrmStockOrder.DoNewOrder;
begin
  if MessageBox(Handle,'是否清除当前输入的所有商品?','友情提示..',MB_YESNO+MB_ICONQUESTION)=6 then
     NewOrder;
end;

procedure TfrmStockOrder.DoSaveOrder;
begin
  SaveOrder;
  NewOrder;
end;

function TfrmStockOrder.doShortCut(s: string): boolean;
begin
  result := inherited doShortCut(s);
  if result then exit;
  result := true;
  case InputFlag of
  5:begin
      if s<>'' then DoIsPresent(s);
    end;
  6:begin
      if s<>'' then DoCustId(s);
    end;
  7:begin
      if s<>'' then DoGuideUser(s);
    end;
  11:begin
      if s<>'' then DoPayZero(s);
    end;
  else
    result := false;
  end;
end;

procedure TfrmStockOrder.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if char(Key) = '*' then
     begin
       if TfrmPayMent.payment(self,totalFee-AObj.FieldbyName('PAY_ZERO').AsFloat,AObj) then
          begin
            inputFlag := 13;
            try
              DoShowPayment;
            finally
              edtInput.Text := '';
              if edtInput.CanFocus then edtInput.SetFocus;
              inputFlag := 0;
            end;
          end;
       key := #0;
//       if dllGlobal.GetParameter('USING_PAYMENT')<>'1' then Raise Exception.Create('没有启用收款方式，不能操作此功能'); 
{       inputMode := 1;
       inputFlag := 13;
       DoShowPayment;
       edtInput.selectAll;
       edtInput.SetFocus;  }
     end;
  if char(Key) = '+' then
     begin
        key := #0;
        try
          DoSaveOrder;
          edtInput.Text := '';
        finally
          InputFlag := 1;
          edtInput.selectAll;
          edtInput.SetFocus;
        end;
     end;
end;

procedure TfrmStockOrder.btnNavClick(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
  0:PageControl.ActivePageIndex := 1;
  1:PageControl.ActivePageIndex := 0;
  end;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  case Value of
  dsBrowse:begin
       btnNew.Caption := '新增';
     end;
  else
     begin
       btnNew.Caption := '清空';
     end;
  end;
end;

procedure TfrmStockOrder.OpenList;
begin
  cdsList.Close;
  cdsList.SQL.Text := 'select A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,B.CLIENT_NAME,A.STOCK_MNY,A.STOCK_MNY-A.PAY_ZERO as ACCT_MNY,PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J as RECV_MNY,C.USER_NAME as GUIDE_USER_TEXT,A.REMARK '+
    'from STK_STOCKORDER A '+
    'left outer join VIW_CLIENTINFO B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
    'left outer join VIW_USERS C on A.TENANT_ID=C.TENANT_ID and A.GUIDE_USER=C.USER_ID '+
    'where A.TENANT_ID=:TENANT_ID and A.STOCK_DATE>=:D1 and A.STOCK_DATE<=:D2 and A.STOCK_TYPE in (1,3) ';
  if trim(searchTxt)<>'' then
    cdsList.SQL.Text := 'select j.* from ('+cdsList.SQL.Text+') j where CLIENT_NAME like ''%'+trim(searchTxt)+'%'' or REMARK like ''%'+trim(searchTxt)+'%'' or GLIDE_NO like ''%'+trim(searchTxt)+'%''';
  cdsList.SQL.Text := cdsList.SQL.Text + ' order by STOCK_DATE,GLIDE_NO';
  cdsList.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
  cdsList.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
  cdsList.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  dataFactory.Open(cdsList); 
end;

procedure TfrmStockOrder.dateFlagPropertiesChange(Sender: TObject);
begin
  inherited;
  case dateFlag.ItemIndex of
  0:begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
      // D1.Properties.ReadOnly := true;
      // D2.Properties.ReadOnly := true;
    end;
  1:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYYMM01',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
      // D1.Properties.ReadOnly := true;
      // D2.Properties.ReadOnly := true;
    end;
  2:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYY0101',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
      // D1.Properties.ReadOnly := true;
      // D2.Properties.ReadOnly := true;
    end;
  else
    begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
      // D1.Properties.ReadOnly := false;
      // D2.Properties.ReadOnly := false;
    end;
  end;
end;

procedure TfrmStockOrder.FormCreate(Sender: TObject);
begin
  inherited;
  dateFlag.ItemIndex := 1;
end;

procedure TfrmStockOrder.btnFindClick(Sender: TObject);
begin
  inherited;
  OpenList;
end;

procedure TfrmStockOrder.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('STOCK_ID').AsString);
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  rowToolNav.Visible := not cdsList.IsEmpty;
  br := TBrush.Create;
  br.Assign(DBGridEh2.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh2.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused or (Column.FieldName = 'TOOL_NAV')) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+11,ARect.Top+11,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
       end
    else
       begin
         DBGridEh2.Canvas.Font.Color := clBlack;
         DBGridEh2.Canvas.Brush.Color := clWhite;
       end;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.Brush.Color := DBGridEh2.FixedColor;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh2.Canvas.Brush.Assign(br);
    DBGridEh2.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmStockOrder.RzToolButton2Click(Sender: TObject);
begin
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('STOCK_ID').AsString);
  EditOrder;
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.RzToolButton3Click(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('STOCK_ID').AsString);
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.RzToolButton1Click(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if messageBox(handle,'是否删除当前进货单？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  open(cdsList.FieldbyName('STOCK_ID').AsString);
  DeleteOrder;
  cdsList.Delete;
end;

procedure TfrmStockOrder.btnNewClick(Sender: TObject);
begin
  if MessageBox(Handle,pchar('是否'+btnNew.Caption+'当前销售单？'),'友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  NewOrder;
end;

procedure TfrmStockOrder.DBGridEh1Columns8UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin
   if length(Text)>10 then
      begin
         Text := TColumnEh(Sender).Field.AsString;
         Value := TColumnEh(Sender).Field.asFloat;
         Exit;
      end;
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
  if abs(r)>100 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
  AgioToCalc(r);
end;

function TfrmStockOrder.checkPayment: boolean;
var fee,allFee,payZero,stockMny:currency;
begin
  fee :=
    AObj.FieldbyName('PAY_B').AsFloat+
    AObj.FieldbyName('PAY_C').AsFloat+
    AObj.FieldbyName('PAY_E').AsFloat+
    AObj.FieldbyName('PAY_F').AsFloat+
    AObj.FieldbyName('PAY_G').AsFloat+
    AObj.FieldbyName('PAY_H').AsFloat+
    AObj.FieldbyName('PAY_I').AsFloat+
    AObj.FieldbyName('PAY_J').AsFloat;
  payZero := AObj.FieldbyName('PAY_ZERO').AsFloat;
  stockMny := AObj.FieldbyName('STOCK_MNY').AsFloat;
  case InputFlag of
  13,14:begin
       if (TotalFee-payZero)-fee=0 then
       edtInput.Text := '' else
       edtInput.Text := formatFloat('#0.00',(TotalFee-payZero)-fee);
     end
  else
     begin
        if dbState = dsInsert then
           allFee := fee
        else
           allFee := fee + AObj.FieldbyName('PAY_A').AsFloat;
        if abs(allFee)>abs(TotalFee-payZero) then
           begin
             Raise Exception.Create('你已经超额支付了,请正确输入付款金额');
           end;
        if fee=0 then
          AObj.FieldbyName('PAY_A').AsFloat := (TotalFee-payZero)-AObj.FieldbyName('PAY_D').AsFloat
        else
          AObj.FieldbyName('PAY_A').AsFloat := (TotalFee-payZero)-fee-AObj.FieldbyName('PAY_D').AsFloat;
     end;
  end;
  result := true;
end;

procedure TfrmStockOrder.DoShowPayment;
var
  fee,payZero,salMny:currency;
  s,payInfo:string;
  w:integer;
begin
  fee :=
    AObj.FieldbyName('PAY_B').AsFloat+
    AObj.FieldbyName('PAY_C').AsFloat+
    // AObj.FieldbyName('PAY_D').AsFloat+
    AObj.FieldbyName('PAY_E').AsFloat+
    AObj.FieldbyName('PAY_F').AsFloat+
    AObj.FieldbyName('PAY_G').AsFloat+
    AObj.FieldbyName('PAY_H').AsFloat+
    AObj.FieldbyName('PAY_I').AsFloat+
    AObj.FieldbyName('PAY_J').AsFloat;
  payZero := AObj.FieldbyName('PAY_ZERO').AsFloat;
  salMny := AObj.FieldbyName('STOCK_MNY').AsFloat;
  case dbState of
  dsBrowse:begin
      edtPAY_TOTAL.Text := formatFloat('#0.00',fee+AObj.FieldbyName('PAY_A').AsFloat);
      edtACCT_MNY.Text := formatFloat('#0.00',(TotalFee-payZero));
      if TotalFee<>0 then
         edtAGIO_RATE.Text := formatFloat('#0.0',(TotalFee-payZero)*100/TotalFee)
      else
         edtAGIO_RATE.Text := '';
    end;
  else
    begin
      if (fee=0) and (fnNumber.CompareFloat(AObj.FieldbyName('PAY_A').AsFloat,0)=0) then
         begin
           edtPAY_TOTAL.Text := formatFloat('#0.00',(TotalFee-payZero)-AObj.FieldbyName('PAY_D').AsFloat);
         end
      else
         edtPAY_TOTAL.Text := formatFloat('#0.00',fee+AObj.FieldbyName('PAY_A').AsFloat);
      edtACCT_MNY.Text := formatFloat('#0.00',(TotalFee-payZero));
      if TotalFee<>0 then
         edtAGIO_RATE.Text := formatFloat('#0.0',(TotalFee-payZero)*100/TotalFee)
      else
         edtAGIO_RATE.Text := '';
      if inputFlag in [13,14] then
         edtInput.Text := formatFloat('#0.00#',(TotalFee-payZero)-(fee+AObj.FieldbyName('PAY_A').AsFloat));
    end;
  end;
  s := '0000000000';
  w := 0;
  payInfo := '';
  payment.Caption := '本次付款';
  if AObj.FieldbyName('PAY_A').asFloat<>0 then
     begin
       s[1] := '1';
       payment.Caption := '现金付款';
       inc(w);
       payInfo := payInfo +'现金:'+formatFloat('#0.0#',AObj.FieldbyName('PAY_A').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_B').asFloat<>0 then
     begin
       s[2] := '1';
       payment.Caption := getPaymentTitle('B')+'付款';
       inc(w);
       payInfo := payInfo +getPaymentTitle('B')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_B').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_C').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('C')+'付款';
       inc(w);
       s[3] := '1';
       payInfo := payInfo +getPaymentTitle('C')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_C').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_D').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('D')+'欠款';
       inc(w);
       s[4] := '0';
       payInfo := payInfo +getPaymentTitle('D')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_D').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_E').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('E')+'付款';
       inc(w);
       s[5] := '1';
       payInfo := payInfo +getPaymentTitle('E')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_E').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_F').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('F')+'付款';
       inc(w);
       s[6] := '1';
       payInfo := payInfo +getPaymentTitle('F')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_F').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_G').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('G')+'付款';
       inc(w);
       s[7] := '1';
       payInfo := payInfo +getPaymentTitle('G')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_G').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_H').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('H')+'付款';
       inc(w);
       s[8] := '1';
       payInfo := payInfo +getPaymentTitle('H')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_H').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_I').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('I')+'付款';
       inc(w);
       s[9] := '1';
       payInfo := payInfo +getPaymentTitle('I')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_I').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_J').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('J')+'付款';
       inc(w);
       s[10] := '1';
       payInfo := payInfo +getPaymentTitle('J')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_J').asFloat)+ ' ';
     end;
  if w>1 then payment.Caption := '组合付款';
  case inputFlag of
  13: MarqueeStatus.Caption := payInfo;
  else
     begin
      if TotalFee<>0 then
         MarqueeStatus.Caption := '合计:'+formatFloat('#0.00',(TotalFee-payZero))+'  折扣:'+formatFloat('#0.0',(TotalFee-payZero)*100/TotalFee)+'%'
      else
         MarqueeStatus.Caption := '';
     end;
  end;
end;

function TfrmStockOrder.payCashMny(s: string): boolean;
var r:currency;
begin
  try
    r := strtoFloat(s);
  except
    Raise Exception.Create('你输入的实收现金不正确，请重新输入');
  end;
  AObj.FieldByName('CASH_MNY').AsFloat := r;
  FInputFlag :=1;
  try
    checkPayment;
  finally
    FInputFlag := 14;
  end;
end;

procedure TfrmStockOrder.DoHangUp;
var
  s:string;
  mm:TMemoryStream;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if dbState = dsEdit then Raise Exception.Create('修改单据状态不能挂单...');
  if TotalAmt=0 then Raise Exception.Create('不能挂一张空单据...');
  AObj.FieldbyName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  AObj.FieldbyName('SHOP_ID').AsString := token.shopId;
  AObj.FieldByName('STOCK_TYPE').AsInteger := 1;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := token.UserID;
  AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',dllGlobal.SysDate);
  AObj.FieldByName('CHK_USER').AsString := token.userId;
  AObj.FieldByName('LOCUS_STATUS').AsString := '3';
  edtTable.DisableControls;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    s := formatDatetime('YYYYMMDD_HHNNSS',now());
    ForceDirectories(ExtractFilePath(ParamStr(0))+'temp\stock');
    mm := TMemoryStream.Create;
    try
      mm.Clear;
      cdsHeader.SaveToStream(mm);
      mm.Position := 0;
      mm.SaveToFile(ExtractFilePath(ParamStr(0))+'temp\stock\H'+s+'.dat');

      mm.Clear;
      edtTable.SaveToStream(mm);
      mm.Position := 0;
      mm.SaveToFile(ExtractFilePath(ParamStr(0))+'temp\stock\D'+s+'.dat');

      mm.Clear;
      edtProperty.SaveToStream(mm);
      mm.Position := 0;
      mm.SaveToFile(ExtractFilePath(ParamStr(0))+'temp\stock\P'+s+'.dat');
    finally
      mm.Free;
    end;
    edtTable.EnableControls;
  except
    edtTable.EnableControls;
    Raise;
  end;
  dbState := dsBrowse;
  MessageBox(Handle,'挂单成功，取单请按F10键',pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  NewOrder;
end;

procedure TfrmStockOrder.DoPayInput(s, flag: string);
var
  r:currency;
  rs:TZQuery;
begin
  try
    r := strtoFloat(s);
  except
    Raise Exception.Create('你输入的支付金额不正确，请重新输入'); 
  end;
  rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
  flag := uppercase(flag);
  if not rs.Locate('CODE_ID',flag,[]) then Raise Exception.Create('您输入的支付方式不正确,请重新输入');
  AObj.FieldByName('PAY_'+flag).AsFloat := r;
  DoShowPayment; 
end;

procedure TfrmStockOrder.DoPayZero(s: string);
var
  mny:currency;
  IsAgio:boolean;
begin
  s := trim(s);
  IsAgio := (s[1]='/');
  if IsAgio then delete(s,1,1);
  s := trim(s);
  try
    mny := StrtoFloat(s);
  except
    Raise Exception.create('你输入的数值无效无效');
  end;
  if IsAgio then
     begin
       if abs(mny)>100 then Raise Exception.Create('输入的折扣率过大，请确认是否输入正确');
     end
  else
     begin
       if abs(mny)>totalfee then Raise Exception.Create('输入的金额过大，请确认是否输入正确');
     end;
  if not IsAgio then
     begin
       AObj.FieldbyName('PAY_ZERO').asFloat := totalFee-mny;
       edtACCT_MNY.Text := formatFloat('#0.00',mny);
     end
  else
     begin
       AObj.FieldbyName('PAY_ZERO').AsString := formatFloat('#0.00',totalfee-(totalFee*mny/100));
       edtACCT_MNY.Text := formatFloat('#0.00',totalfee-AObj.FieldbyName('PAY_ZERO').asFloat);
     end;
  if TotalFee<>0 then
     edtAGIO_RATE.Text := formatFloat('#0.0',(TotalFee-AObj.FieldbyName('PAY_ZERO').asFloat)*100/TotalFee)
  else
     edtAGIO_RATE.Text := '';
  DoShowPayment;
end;

procedure TfrmStockOrder.DoPickUp;
var
  sr: TSearchRec;
  FileAttrs: Integer;
  s,tmp:string;
  h:TZQuery;
  mm:TMemoryStream;
begin
  FileAttrs := 0;
  FileAttrs := FileAttrs + faAnyFile;
  s:= '';
  if FindFirst(ExtractFilePath(ParamStr(0))+'temp\stock\*.dat', FileAttrs, sr) = 0 then
    begin
      repeat
        if (sr.Attr and FileAttrs) = sr.Attr then
        begin
        if (copy(sr.Name,1,1)='H') then
           begin
             tmp := extractFileName(sr.Name);
             delete(tmp,1,1);
             if tmp>s then s := tmp;
           end;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  if not edtTable.IsEmpty and (MessageBox(Handle,'是否清空当前录入的所有商品？','友情提示',MB_YESNO+MB_ICONQUESTION)<>6) then Exit;
  NewOrder;
  mm := TMemoryStream.Create;
  h := TZQuery.Create(nil);
  try
    mm.LoadFromFile(ExtractFilePath(ParamStr(0))+'temp\stock\H'+s);
    H.LoadFromStream(mm);
    AObj.ReadFromDataSet(H,false); 
    mm.LoadFromFile(ExtractFilePath(ParamStr(0))+'temp\stock\D'+s);
    edtTable.LoadFromStream(mm);
    mm.LoadFromFile(ExtractFilePath(ParamStr(0))+'temp\stock\P'+s);
    edtProperty.LoadFromStream(mm);
  finally
    h.Free;
    mm.Free;
  end;
  edtTable.Last;
  RowId := edtTable.FieldbyName('SEQNO').AsInteger;
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\stock\'+s);
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\stock\D'+s);
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\stock\P'+s);
  Calc;
end;

function TfrmStockOrder.getPaymentTitle(pay: string): string;
var
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
  if rs.Locate('CODE_ID',pay,[]) then
     result := rs.FieldbyName('CODE_NAME').AsString
  else
     Raise Exception.Create('不支持的收款方式'); 
end;

procedure TfrmStockOrder.edtInputKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if InputFlag = 13 then
  begin
    case Key of
    'A','B','C','D','E','F','G','H','I','J','a','b','c','d','e','f','g','h','i','j':begin
           try
             DoPayInput(trim(edtInput.Text),Key);
           finally
             edtInput.selectAll;
             Key := #0;
             edtInput.SetFocus;
           end;
         end;
    end;
  end;
end;

procedure TfrmStockOrder.PageControlChange(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
  0:begin
       btnNav.Caption := '历史单据';
       lblCaption.Caption := '进货单';
    end;
  1:begin
       btnNav.Caption := '返回';
       lblCaption.Caption := '进货单列表';
    end;
  end;
end;

procedure TfrmStockOrder.serachTextEnter(Sender: TObject);
begin
  inherited;
  serachText.Text := searchTxt;
  serachText.SelectAll;
end;

procedure TfrmStockOrder.serachTextExit(Sender: TObject);
begin
  inherited;
  if searchTxt='' then serachText.Text := serachText.Hint;
end;

procedure TfrmStockOrder.edtTableAfterDelete(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;
end;

procedure TfrmStockOrder.serachTextChange(Sender: TObject);
begin
  inherited;
  if serachText.Focused then searchTxt := serachText.Text;
end;

procedure TfrmStockOrder.cdsListBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav.Visible := false;
end;

procedure TfrmStockOrder.serachTextKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     OpenList;
end;

procedure TfrmStockOrder.btnPrintClick(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
    0:
      begin
        PrintOrder;
      end;
    1:
      begin
        DBGridPrint;
        TfrmDBGridPreview.Print(self,PrintDBGridEh1);
      end;
  end;
end;

procedure TfrmStockOrder.btnPreviewClick(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
    0:
      begin
        PreviewOrder;
      end;
    1:
      begin
        DBGridPrint;
        TfrmDBGridPreview.Preview(self,PrintDBGridEh1);
      end;
  end;
end;

procedure TfrmStockOrder.DBGridPrint;
begin
  inherited;
  PrintDBGridEh1.DBGridEh := DBGridEh2;
  PrintDBGridEh1.PageHeader.CenterText.Text := '进货单列表';
  DBGridEh1.DBGridTitle := '进货单列表';
  DBGridEh1.DBGridHeader.Text := '日期:'+formatDatetime('YYYY-MM-DD',D1.Date)+'至'+formatDatetime('YYYY-MM-DD',D2.Date);
  DBGridEh1.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+token.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', '日期:'+formatDatetime('YYYY-MM-DD',D1.Date)+'至'+formatDatetime('YYYY-MM-DD',D2.Date)]);
end;

procedure TfrmStockOrder.paymentClick(Sender: TObject);
begin
  inherited;
  if TfrmPayment.payment(self,totalFee-AObj.FieldbyName('PAY_ZERO').AsFloat,AObj) then
     DoShowPayment;
end;

procedure TfrmStockOrder.PrintOrder;
var tid,oid:string;
begin
  inherited;
  if dbState <> dsBrowse then Raise Exception.Create('请保存后再打印...');
  if AObj.FieldbyName('STOCK_ID').AsString = '' then Exit;
  tid := token.tenantId;
  oid := AObj.FieldbyName('STOCK_ID').AsString;
  TfrmOrderPreview.PrintReport(self,0,frfStockOrder,tid,oid);
end;

procedure TfrmStockOrder.PreviewOrder;
var
  r:integer;
  tid,oid:string;
begin
  inherited;
  if dbState <> dsBrowse then Raise Exception.Create('请保存后再预览...');
  if AObj.FieldbyName('STOCK_ID').AsString = '' then Exit;
  r := TfrmSaveDesigner.ShowDialog(self,'frfStockOrder',nil);
  if r < 0 then Exit;
  GlobalIndex := r;
  tid := token.tenantId;
  oid := AObj.FieldbyName('STOCK_ID').AsString;
  TfrmOrderPreview.ShowReport(self,0,frfStockOrder,tid,oid,'进货单');
end;

procedure TfrmStockOrder.frfStockOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='企业名称' then ParValue := token.tenantName;
  if ParName='打印人' then ParValue := token.username;
end;

procedure TfrmStockOrder.frfStockOrderUserFunction(const Name: String; p1,
  p2, p3: Variant; var Val: Variant);
var small:real;
begin
  inherited;
  if UPPERCASE(Name)='SMALLTOBIG' then
     begin
       small := frParser.Calc(p1);
       Val := FnNumber.SmallTOBig(small);
     end;
end;

procedure TfrmStockOrder.BarcodeInput(_Buf: string);
begin
  inherited;

end;

procedure TfrmStockOrder.edtACCT_MNYKeyPress(Sender: TObject;
  var Key: Char);
var r,fee:currency;
begin
  inherited;
  if Key=#13 then
     begin
       r := StrtoFloatDef(edtACCT_MNY.Text,0);
       AObj.FieldbyName('PAY_ZERO').AsFloat := TotalFee-r;
       if TotalFee<>0 then
          edtAGIO_RATE.Text := formatFloat('#0.0',r*100/TotalFee)
       else
          edtAGIO_RATE.Text := '';
       fee :=
        AObj.FieldbyName('PAY_B').AsFloat+
        AObj.FieldbyName('PAY_C').AsFloat+
        AObj.FieldbyName('PAY_D').AsFloat+
        AObj.FieldbyName('PAY_E').AsFloat+
        AObj.FieldbyName('PAY_F').AsFloat+
        AObj.FieldbyName('PAY_G').AsFloat+
        AObj.FieldbyName('PAY_H').AsFloat+
        AObj.FieldbyName('PAY_I').AsFloat+
        AObj.FieldbyName('PAY_J').AsFloat;
       if fee=0 then
          edtPAY_TOTAL.Text := formatFloat('#0.00',r)
       else
          edtPAY_TOTAL.Text := formatFloat('#0.00',fee+AObj.FieldbyName('PAY_A').AsFloat);
     end;
end;

procedure TfrmStockOrder.edtAGIO_RATEKeyPress(Sender: TObject;
  var Key: Char);
var r,fee:currency;
begin
  inherited;
  if Key=#13 then
     begin
       r := StrtoFloatDef(edtAGIO_RATE.Text,0);
       AObj.FieldbyName('PAY_ZERO').AsFloat := TotalFee-roundTo(TotalFee*r/100,-2);
       edtACCT_MNY.Text := formatFloat('#0.00',TotalFee-AObj.FieldbyName('PAY_ZERO').AsFloat);
       fee :=
        AObj.FieldbyName('PAY_B').AsFloat+
        AObj.FieldbyName('PAY_C').AsFloat+
        AObj.FieldbyName('PAY_D').AsFloat+
        AObj.FieldbyName('PAY_E').AsFloat+
        AObj.FieldbyName('PAY_F').AsFloat+
        AObj.FieldbyName('PAY_G').AsFloat+
        AObj.FieldbyName('PAY_H').AsFloat+
        AObj.FieldbyName('PAY_I').AsFloat+
        AObj.FieldbyName('PAY_J').AsFloat;
       if fee=0 then
          edtPAY_TOTAL.Text := formatFloat('#0.00',r)
       else
          edtPAY_TOTAL.Text := formatFloat('#0.00',fee+AObj.FieldbyName('PAY_A').AsFloat);
     end;
end;

procedure TfrmStockOrder.edtPAY_TOTALKeyPress(Sender: TObject;
  var Key: Char);
var
  r:currency;
begin
  inherited;
  if Key=#13 then
     begin
       r := StrtoFloatDef(edtPAY_TOTAL.Text,0);
       AObj.FieldbyName('PAY_A').AsFloat := r;
       AObj.FieldbyName('PAY_B').AsFloat := 0;
       AObj.FieldbyName('PAY_C').AsFloat := 0;
       AObj.FieldbyName('PAY_D').AsFloat := (totalFee-AObj.FieldbyName('PAY_ZERO').AsFloat)-r;
       AObj.FieldbyName('PAY_E').AsFloat := 0;
       AObj.FieldbyName('PAY_F').AsFloat := 0;
       AObj.FieldbyName('PAY_G').AsFloat := 0;
       AObj.FieldbyName('PAY_H').AsFloat := 0;
       AObj.FieldbyName('PAY_I').AsFloat := 0;
       AObj.FieldbyName('PAY_J').AsFloat := 0;
       payment.Caption := '现金收款';
     end;
end;

initialization
  RegisterClass(TfrmStockOrder);
finalization
  UnRegisterClass(TfrmStockOrder);
end.
