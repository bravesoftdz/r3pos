unit ufrmStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmOrderForm, RzButton, RzPanel, cxTextEdit, cxDropDownEdit,
  cxCalendar, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, StdCtrls, RzLabel, ExtCtrls, RzBmpBtn,
  RzBorder, RzTabs, RzStatus, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZBase, Math, Menus, pngimage, RzBckgnd, jpeg, PrnDbgeh,ufrmDBGridPreview,
  ComCtrls, ToolWin, ImgList, FR_Class, MPlayer;

type
  TfrmStockOrder = class(TfrmOrderForm)
    TabSheet2: TRzTabSheet;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
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
    RzLabel6: TRzLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtBK_SALES_DATE: TRzPanel;
    RzPanel20: TRzPanel;
    RzLabel7: TRzLabel;
    edtSTOCK_DATE: TcxDateEdit;
    Image2: TImage;
    edtBK_GUIDE_USER: TRzPanel;
    RzPanel4: TRzPanel;
    RzLabel8: TRzLabel;
    edtGUIDE_USER: TzrComboBoxList;
    edtREMARK: TcxTextEdit;
    edtBK_ACCT_MNY: TRzPanel;
    RzLabel9: TRzLabel;
    RzPanel7: TRzPanel;
    RzLabel10: TRzLabel;
    edtACCT_MNY: TcxTextEdit;
    edtAGIO_RATE: TcxTextEdit;
    RzPanel8: TRzPanel;
    RzLabel11: TRzLabel;
    edtBK_PAY_TOTAL: TRzPanel;
    RzPanel10: TRzPanel;
    payment: TRzLabel;
    edtPAY_TOTAL: TcxTextEdit;
    RzPanel3: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel9: TRzPanel;
    RzLabel17: TRzLabel;
    dateFlag: TcxComboBox;
    D1: TcxDateEdit;
    RzPanel23: TRzPanel;
    RzPanel22: TRzPanel;
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
    RzToolButton4: TRzToolButton;
    btnSave: TRzBmpButton;
    btnNew: TRzBmpButton;
    btnImport: TRzBmpButton;
    RzPanel13: TRzPanel;
    godsAmount: TRzPanel;
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
    procedure RzToolButton4Click(Sender: TObject);
    procedure edtAGIO_RATEExit(Sender: TObject);
    procedure edtCLIENT_IDAddClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure DBGridEh1Columns10UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure edtCLIENT_IDDblClick(Sender: TObject);
  private
    AObj:TRecord_;
    //Ĭ�Ϸ�Ʊ����
    DefInvFlag:integer;
    //��ͨ˰��
    InRate2:Currency;
    //��ֵ˰��
    InRate3:Currency;
    //������
    TotalFee:Currency;
    //��������
    TotalAmt:Currency;

    searchTxt:string;
    procedure DBGridPrint;
  protected
    procedure SetdbState(const Value: TDataSetState);override;
    procedure SetinputFlag(const Value: integer);override;
    procedure getGodsInfo(godsId:string);
    function  checkPayment:boolean;
    function  payCashMny(s:string):boolean;
    procedure DoShowPayment;
    procedure Calc;override; //2011.06.09�ж��Ƿ�����
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    function  getPaymentTitle(pay:string):string;

    //��ݼ�
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
     ufrmOrderPreview,ufrmSaveDesigner,ufrmSupplierDialog,ufrmHangUpFile;

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
    r := edtTable.FieldByName('SEQNO').AsInteger;
    orgFee := TotalFee;
    TotalFee := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        TotalFee := TotalFee + edtTable.FieldByName('CALC_MONEY').AsFloat;
        TotalAmt := TotalAmt + edtTable.FieldByName('AMOUNT').AsFloat;
        edtTable.Next;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]); 
    if not Controls then edtTable.EnableControls;
  end;
  if (dbState<>dsBrowse) then
  begin
    AObj.FieldByName('STOCK_AMT').AsFloat := TotalAmt;
    AObj.FieldByName('STOCK_MNY').AsFloat := TotalFee;
    if orgFee<>TotalFee then
       AObj.FieldByName('PAY_ZERO').AsFloat := 0;

    edtACCT_MNY.Text := FormatFloat('#0.00',TotalFee);
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
     Open(AObj.FieldByName('STOCK_ID').AsString);
end;

constructor TfrmStockOrder.Create(AOwner: TComponent);
begin
  inherited;
  AObj := TRecord_.Create;
end;

procedure TfrmStockOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('����ɾ���յ���');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ���ɾ��');
  if MessageBox(Handle,'�Ƿ�����ɾ����ǰ����?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
  cdsList.Delete;
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
  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  if cdsHeader.FieldByName('FROM_ID').AsString<>'' then Raise Exception.Create('��ǰ�汾���ܴ���ӽ����������ĵ��ݡ�');  
  if cdsHeader.FieldByName('FIG_ID').AsString<>'' then Raise Exception.Create('��ǰ�汾���ܴ������������ɵĵ��ݡ�');  
  dbState := dsEdit;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus
  else
  if edtCLIENT_ID.CanFocus and Visible then
     edtCLIENT_ID.SetFocus;
end;

procedure TfrmStockOrder.NewOrder;
begin
  inherited;
  godsAmount.Caption := godsAmount.Hint;
  Open('');
  dbState := dsInsert;
  AObj.FieldByName('TENANT_ID').AsString := token.tenantId;
  AObj.FieldByName('SHOP_ID').AsString := token.shopId;

  AObj.FieldByName('DEPT_ID').AsString := dllGlobal.getMyDeptId;

  AObj.FieldByName('STOCK_ID').AsString := TSequence.NewId();
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

  AObj.FieldByName('INVOICE_FLAG').AsInteger := DefInvFlag;
  case DefInvFlag of
  1: AObj.FieldByName('TAX_RATE').AsFloat := 0;
  2: AObj.FieldByName('TAX_RATE').AsFloat := InRate2;
  3: AObj.FieldByName('TAX_RATE').AsFloat := InRate3;
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
//  if id='' then dataFactory.MoveToSqlite else dataFactory.MoveToDefault;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    Params.ParamByName('STOCK_ID').AsString := id;
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
    DoShowPayment;
  finally
    dataFactory.MoveToDefault;
    Params.Free;
  end;
end;

procedure TfrmStockOrder.SaveOrder;
begin
  if dbState = dsBrowse then Exit;

  if edtSTOCK_DATE.EditValue = null then Raise Exception.Create('�������ڲ���Ϊ��');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('��Ӧ�̲���Ϊ��');

  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('���ܱ���һ�ſյ���...');
  CheckInvaid;
  WriteToObject(AObj,self);

  AObj.FieldByName('STOCK_TYPE').AsInteger := 1;
  AObj.FieldByName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := token.userId;
  AObj.FieldByName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',dllGlobal.SysDate);
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
         cdsDetail.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldByName('TENANT_ID').AsInteger;
         cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldByName('SHOP_ID').AsString;
         cdsDetail.FieldByName('STOCK_ID').AsString := cdsHeader.FieldByName('STOCK_ID').AsString;
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
  fndGODS_ID.Text := edtTable.FieldByName('GODS_NAME').AsString;
  fndGODS_ID.KeyValue := edtTable.FieldByName('GODS_ID').AsString;
  fndGODS_ID.SaveStatus;
end;

procedure TfrmStockOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if length(Text)>10 then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.AsFloat;
       Exit;
     end;

  if edtTable.FieldByName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;

  if PropertyEnabled then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.AsFloat;
     end
  else
     begin
        try
          if Text='' then
             r := 0
          else
             r := StrtoFloat(Text);
          if abs(r)>999999 then Raise Exception.Create('�������ֵ������Ч');
        except
          if length(Text)<10 then MessageBox(handle,'�������������Ч������������','������ʾ..',MB_OK+MB_ICONINFORMATION);
          Text := TColumnEh(Sender).Field.AsString;
          Value := TColumnEh(Sender).Field.AsFloat;
          Exit;
        end;
        TColumnEh(Sender).Field.AsFloat := r;
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
       Value := TColumnEh(Sender).Field.AsFloat;
       Exit;
     end;

  if edtTable.FieldByName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;

  if edtTable.FieldByName('IS_PRESENT').AsInteger = 1 then
     begin
       Value := TColumnEh(Sender).Field.AsFloat;
       Text := TColumnEh(Sender).Field.AsString;
       MessageBox(Handle,pchar('��Ʒ��'+edtTable.FieldByName('GODS_NAME').AsString+'���Ѿ����ͣ��������޸ĵ��ۣ�'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
       Exit;
     end;

  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
    if abs(r)>999999 then Raise Exception.Create('�������ֵ������Ч');
  except
    if length(Text)<10 then MessageBox(handle,'������ĵ�����Ч������������','������ʾ..',MB_OK+MB_ICONINFORMATION);
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.AsFloat;
    Exit;
  end;
  TColumnEh(Sender).Field.AsFloat := r;
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
      if dllGlobal.GetChkRight('12400001',2) and (MessageBox(Handle,'�Ƿ����������������',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
         NewOrder
      else
         Open(AObj.FieldByName('STOCK_ID').AsString);
    end;
  end;
end;

procedure TfrmStockOrder.InitPrice(GODS_ID, UNIT_ID: string);
begin
  if edtTable.State = dsBrowse then edtTable.Edit;
  edtTable.FieldByName('APRICE').AsFloat :=dllGlobal.GetNewInPrice(GODS_ID,UNIT_ID);
  edtTable.FieldByName('ORG_PRICE').AsFloat :=dllGlobal.GetNewOutPrice(GODS_ID,UNIT_ID);
  case DefInvFlag of
  1: edtTable.FieldByName('TAX_RATE').AsFloat := 0;
  2: edtTable.FieldByName('TAX_RATE').AsFloat := InRate2;
  3: edtTable.FieldByName('TAX_RATE').AsFloat := InRate3;
  end;
  getGodsInfo(edtTable.FieldByName('GODS_ID').AsString);
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
      result := result +rs.FieldByName('CODE_ID').AsString+'.'+rs.FieldByName('CODE_NAME').AsString;
      rs.Next;
    end;
end;
begin
  inherited;
  case Value of
  5:begin
      FInputFlag := value;
      lblInput.Caption := '��������';
      lblHint.Caption := '"1.����������2.������Ʒ" ������������ź� Enter ��';
    end;
  6:begin
      FInputFlag := value;
      lblInput.Caption := '�� Ӧ ��';
      lblHint.Caption := '������������"��Ӧ�̱�����ֻ���"�� Enter ��';
    end;
  7:begin
      FInputFlag := value;
      lblInput.Caption := '�� �� Ա';
      lblHint.Caption := '�������ջ�ԱԱ����ź� Enter ��';
    end;
  11:begin
      FInputFlag := value;
      lblInput.Caption := 'Ӧ�����';
      lblHint.Caption := '��ֱ�������������ۿ���(��95��/95)�� Enter ��';
    end;
  13:begin
      FInputFlag := value;
      lblInput.Caption := '������';
      lblHint.Caption := '������֧������"'+getPayment+'"';
    end;
  14:begin
      FInputFlag := value;
      lblInput.Caption := 'ʵ���ֽ�';
      lblHint.Caption := '������ʵ���ֽ�� Enter ����+��';
    end;
  end;
end;

procedure TfrmStockOrder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if PageControl.ActivePageIndex <> 0 then Exit;
  if Key = VK_F5 then
     begin
       if edtTable.FieldByName('IS_PRESENT').AsString = '0' then
          DoIsPresent('2')
       else
          DoIsPresent('1');
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
    if rs.IsEmpty then Raise Exception.Create('������Ĺ�Ӧ�̱����Ч');  
    edtCLIENT_ID.KeyValue := rs.FieldByName('CLIENT_ID').AsString;
    edtCLIENT_ID.Text := rs.FieldByName('CLIENT_NAME').AsString;
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
       edtGUIDE_USER.KeyValue := rs.FieldByName('USER_ID').AsString;
       edtGUIDE_USER.Text := rs.FieldByName('USER_NAME').AsString;
     end;
end;

procedure TfrmStockOrder.DoIsPresent(s:string);
begin
  if edtTable.FieldByName('GODS_ID').AsString = '' then Exit;
  if s='1' then
     PresentToCalc(0)
  else
  if s='2' then
     PresentToCalc(1)
  else
     Raise Exception.Create('��֧�ֵ��������ͣ�������1-3֮����������');
end;

procedure TfrmStockOrder.DoNewOrder;
begin
  if MessageBox(Handle,'�Ƿ������ǰ�����������Ʒ?','������ʾ..',MB_YESNO+MB_ICONQUESTION)=6 then
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
  if result then Exit;
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
       if edtInput.CanFocus then edtInput.SetFocus;
       if CheckNoData then raise Exception.Create('����û��������Ʒ���������˲�����');
       if TfrmPayMent.payment(self,totalFee-AObj.FieldByName('PAY_ZERO').AsFloat,AObj) then
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
       Key := #0;
     end;
  if (char(Key) = '+') or (char(Key) = ' ') then
     begin
        key := #0;
        try
          if CheckNoData then raise Exception.Create('����û��������Ʒ���������˲�����');
          DoSaveOrder;
          edtInput.Text := '';
        finally
          InputFlag := 1;
          edtInput.selectAll;
          edtInput.SetFocus;
        end;
     end;
  if (Key = #27) and (PageControl.ActivePageIndex = 1) then
     begin
       PageControl.ActivePageIndex := 0;
       PageControlChange(nil);
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
       btnNew.Caption := '����';
     end;
  else
     begin
       btnNew.Caption := '���';
     end;
  end;
end;

procedure TfrmStockOrder.OpenList;
begin
  if D1.EditValue = null then
     begin
       if D1.CanFocus then D1.SetFocus;
       Raise Exception.Create('��ʼ���ڲ���Ϊ�գ�');
     end;
  if D2.EditValue = null then
     begin
       if D2.CanFocus then D2.SetFocus;
       Raise Exception.Create('������������Ϊ�գ�');
     end;
  cdsList.Close;
  cdsList.SQL.Text := 'select A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,B.CLIENT_NAME,A.STOCK_MNY,A.STOCK_MNY-A.PAY_ZERO as ACCT_MNY,PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J as RECV_MNY,C.USER_NAME as GUIDE_USER_TEXT,A.REMARK,A.COMM_ID,A.CREA_DATE '+
    'from STK_STOCKORDER A '+
    'left outer join VIW_CLIENTINFO B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
    'left outer join VIW_USERS C on A.TENANT_ID=C.TENANT_ID and A.GUIDE_USER=C.USER_ID '+
    'where A.TENANT_ID=:TENANT_ID and A.STOCK_DATE>=:D1 and A.STOCK_DATE<=:D2 and A.STOCK_TYPE in (1,3) ';
  if trim(searchTxt)<>'' then
     cdsList.SQL.Text := 'select j.* from ('+cdsList.SQL.Text+') j where CLIENT_NAME like ''%'+trim(searchTxt)+'%'' or REMARK like ''%'+trim(searchTxt)+'%'' or GLIDE_NO like ''%'+trim(searchTxt)+'%''';
  cdsList.SQL.Text := cdsList.SQL.Text + ' order by STOCK_DATE desc,GLIDE_NO desc';
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
    end;
  1:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYYMM01',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
    end;
  2:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYY0101',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
    end;
  else
    begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
    end;
  end;
end;

procedure TfrmStockOrder.FormCreate(Sender: TObject);
begin
  inherited;
  dateFlag.ItemIndex := 0;
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
  open(cdsList.FieldByName('STOCK_ID').AsString);
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
  if cdsList.FieldByName('COMM_ID').AsString <> '' then Raise Exception.Create('���̶����������޸�...');
  open(cdsList.FieldByName('STOCK_ID').AsString);
  EditOrder;
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.RzToolButton3Click(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldByName('STOCK_ID').AsString);
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.RzToolButton1Click(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldByName('STOCK_ID').AsString);
  DeleteOrder;
  NewOrder;
end;

procedure TfrmStockOrder.btnNewClick(Sender: TObject);
begin
  if MessageBox(Handle,pchar('�Ƿ�'+btnNew.Caption+'��ǰ��������'),'������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  NewOrder;
end;

procedure TfrmStockOrder.DBGridEh1Columns8UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin
  if length(Text)>10 then
     begin
       Text := TColumnEh(Sender).Field.AsString;
       Value := TColumnEh(Sender).Field.AsFloat;
       Exit;
     end;

  if edtTable.FieldByName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;

  if edtTable.FieldByName('IS_PRESENT').AsInteger = 1 then
     begin
       Value := TColumnEh(Sender).Field.AsFloat;
       Text := TColumnEh(Sender).Field.AsString;
       MessageBox(Handle,pchar('��Ʒ��'+edtTable.FieldByName('GODS_NAME').AsString+'���Ѿ����ͣ��������޸ĵ��ۣ�'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
       Exit;
     end;

  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.AsFloat;
    Raise Exception.Create('������Ч��ֵ��');
  end;
  if abs(r)>100 then Raise Exception.Create('�������ֵ������Ч');
  TColumnEh(Sender).Field.AsFloat := r;
  AgioToCalc(r);
end;

function TfrmStockOrder.checkPayment: boolean;
var fee,allFee,payZero,stockMny:currency;
begin
  fee :=
    AObj.FieldByName('PAY_B').AsFloat+
    AObj.FieldByName('PAY_C').AsFloat+
    AObj.FieldByName('PAY_E').AsFloat+
    AObj.FieldByName('PAY_F').AsFloat+
    AObj.FieldByName('PAY_G').AsFloat+
    AObj.FieldByName('PAY_H').AsFloat+
    AObj.FieldByName('PAY_I').AsFloat+
    AObj.FieldByName('PAY_J').AsFloat;
  payZero := AObj.FieldByName('PAY_ZERO').AsFloat;
  stockMny := AObj.FieldByName('STOCK_MNY').AsFloat;
  case InputFlag of
  13,14:begin
       if (TotalFee-payZero)-fee=0 then
       edtInput.Text := '' else
       edtInput.Text := FormatFloat('#0.00',(TotalFee-payZero)-fee);
     end
  else
     begin
{
        if dbState = dsInsert then
           allFee := fee
        else
           allFee := fee + AObj.FieldByName('PAY_A').AsFloat;
}
        allFee := fee;

        if abs(allFee)>abs(TotalFee-payZero) then
           begin
             Raise Exception.Create('���Ѿ�����֧����,����ȷ���븶����');
           end;

        if fee=0 then
           AObj.FieldByName('PAY_A').AsFloat := (TotalFee-payZero)-AObj.FieldByName('PAY_D').AsFloat
        else
           AObj.FieldByName('PAY_A').AsFloat := (TotalFee-payZero)-fee-AObj.FieldByName('PAY_D').AsFloat;
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
    AObj.FieldByName('PAY_B').AsFloat+
    AObj.FieldByName('PAY_C').AsFloat+
    // AObj.FieldByName('PAY_D').AsFloat+
    AObj.FieldByName('PAY_E').AsFloat+
    AObj.FieldByName('PAY_F').AsFloat+
    AObj.FieldByName('PAY_G').AsFloat+
    AObj.FieldByName('PAY_H').AsFloat+
    AObj.FieldByName('PAY_I').AsFloat+
    AObj.FieldByName('PAY_J').AsFloat;
  payZero := AObj.FieldByName('PAY_ZERO').AsFloat;
  salMny := AObj.FieldByName('STOCK_MNY').AsFloat;
  case dbState of
  dsBrowse:begin
      edtPAY_TOTAL.Text := FormatFloat('#0.00',fee+AObj.FieldByName('PAY_A').AsFloat);
      edtACCT_MNY.Text := FormatFloat('#0.00',(TotalFee-payZero));
      if TotalFee<>0 then
         edtAGIO_RATE.Text := FormatFloat('#0.0',(TotalFee-payZero)*100/TotalFee)
      else
         edtAGIO_RATE.Text := '';
    end;
  else
    begin
      if (fee=0) and (fnNumber.CompareFloat(AObj.FieldByName('PAY_A').AsFloat,0)=0) then
         begin
           edtPAY_TOTAL.Text := FormatFloat('#0.00',(TotalFee-payZero)-AObj.FieldByName('PAY_D').AsFloat);
         end
      else
         edtPAY_TOTAL.Text := FormatFloat('#0.00',fee+AObj.FieldByName('PAY_A').AsFloat);
      edtACCT_MNY.Text := FormatFloat('#0.00',(TotalFee-payZero));
      if TotalFee<>0 then
         edtAGIO_RATE.Text := FormatFloat('#0.0',(TotalFee-payZero)*100/TotalFee)
      else
         edtAGIO_RATE.Text := '';
      if inputFlag in [13,14] then
         edtInput.Text := FormatFloat('#0.00#',(TotalFee-payZero)-(fee+AObj.FieldByName('PAY_A').AsFloat));
    end;
  end;
  s := '0000000000';
  w := 0;
  payInfo := '';
  payment.Caption := '���θ���';
  if AObj.FieldByName('PAY_A').AsFloat<>0 then
     begin
       s[1] := '1';
       payment.Caption := '�ֽ𸶿�';
       inc(w);
       payInfo := payInfo +'�ֽ�:'+FormatFloat('#0.0#',AObj.FieldByName('PAY_A').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_B').AsFloat<>0 then
     begin
       s[2] := '1';
       payment.Caption := getPaymentTitle('B')+'����';
       inc(w);
       payInfo := payInfo +getPaymentTitle('B')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_B').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_C').AsFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('C')+'����';
       inc(w);
       s[3] := '1';
       payInfo := payInfo +getPaymentTitle('C')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_C').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_D').AsFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('D')+'Ƿ��';
       inc(w);
       s[4] := '0';
       payInfo := payInfo +getPaymentTitle('D')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_D').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_E').AsFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('E')+'����';
       inc(w);
       s[5] := '1';
       payInfo := payInfo +getPaymentTitle('E')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_E').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_F').AsFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('F')+'����';
       inc(w);
       s[6] := '1';
       payInfo := payInfo +getPaymentTitle('F')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_F').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_G').AsFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('G')+'����';
       inc(w);
       s[7] := '1';
       payInfo := payInfo +getPaymentTitle('G')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_G').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_H').AsFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('H')+'����';
       inc(w);
       s[8] := '1';
       payInfo := payInfo +getPaymentTitle('H')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_H').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_I').AsFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('I')+'����';
       inc(w);
       s[9] := '1';
       payInfo := payInfo +getPaymentTitle('I')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_I').AsFloat)+ ' ';
     end;
  if AObj.FieldByName('PAY_J').AsFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('J')+'����';
       inc(w);
       s[10] := '1';
       payInfo := payInfo +getPaymentTitle('J')+':'+FormatFloat('#0.0#',AObj.FieldByName('PAY_J').AsFloat)+ ' ';
     end;
  if w>1 then payment.Caption := '��ϸ���';
  case inputFlag of
  13: MarqueeStatus.Caption := payInfo;
  else
     begin
      if TotalFee<>0 then
         MarqueeStatus.Caption := '�ϼ�:'+FormatFloat('#0.00',(TotalFee-payZero))+'  �ۿ�:'+FormatFloat('#0.0',(TotalFee-payZero)*100/TotalFee)+'%'
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
    Raise Exception.Create('�������ʵ���ֽ���ȷ������������');
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
  if dbState = dsEdit then Raise Exception.Create('�޸ĵ���״̬���ܹҵ�...');
  if TotalAmt=0 then Raise Exception.Create('���ܹ�һ�ſյ���...');
  WriteToObject(AObj,self);
  AObj.FieldByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  AObj.FieldByName('SHOP_ID').AsString := token.shopId;
  AObj.FieldByName('STOCK_TYPE').AsInteger := 1;
  AObj.FieldByName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := token.UserID;
  AObj.FieldByName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',dllGlobal.SysDate);
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
  MessageBox(Handle,'�ҵ��ɹ���ȡ���밴F10��',pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
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
    Raise Exception.Create('�������֧������ȷ������������'); 
  end;
  rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
  flag := uppercase(flag);
  if not rs.Locate('CODE_ID',flag,[]) then Raise Exception.Create('�������֧����ʽ����ȷ,����������');
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
    Raise Exception.create('���������ֵ��Ч��Ч');
  end;
  if IsAgio then
     begin
       if abs(mny)>100 then Raise Exception.Create('������ۿ��ʹ�����ȷ���Ƿ�������ȷ');
     end
  else
     begin
       if abs(mny)>totalfee then Raise Exception.Create('����Ľ�������ȷ���Ƿ�������ȷ');
     end;
  if not IsAgio then
     begin
       AObj.FieldByName('PAY_ZERO').AsFloat := totalFee-mny;
       edtACCT_MNY.Text := FormatFloat('#0.00',mny);
     end
  else
     begin
       AObj.FieldByName('PAY_ZERO').AsString := FormatFloat('#0.00',totalfee-(totalFee*mny/100));
       edtACCT_MNY.Text := FormatFloat('#0.00',totalfee-AObj.FieldByName('PAY_ZERO').AsFloat);
     end;
  if TotalFee<>0 then
     edtAGIO_RATE.Text := FormatFloat('#0.0',(TotalFee-AObj.FieldByName('PAY_ZERO').AsFloat)*100/TotalFee)
  else
     edtAGIO_RATE.Text := '';
  DoShowPayment;
end;

procedure TfrmStockOrder.DoPickUp;
var
  s:string;
  h:TZQuery;
  mm:TMemoryStream;
  PayZero:real;
begin
  ClearInvaid;
  if not edtTable.IsEmpty and (MessageBox(Handle,'�Ƿ���յ�ǰ¼���������Ʒ��','������ʾ',MB_YESNO+MB_ICONQUESTION)<>6) then Exit;
  with TfrmHangUpFile.Create(self) do
    begin
      try
        LoadFile('H','temp\stock\');
        if cdsTable.RecordCount = 0 then
           begin
             MessageBox(self.Handle,pchar('δ��⵽�ҵ���¼..'),'������ʾ..',MB_OK);
             Exit;
           end
        else if cdsTable.RecordCount = 1 then
           s := cdsTable.FieldByName('FILENAME').AsString
        else
           begin
             if ShowModal=MROK then
                begin
                  s := cdsTable.FieldByName('FILENAME').AsString
                end
             else
                Exit;
           end;
      finally
        Free;
      end;
    end;
  s := copy(s,2,255);
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
  RowId := edtTable.FieldByName('SEQNO').AsInteger;
  PayZero := AObj.FieldByName('PAY_ZERO').AsFloat;
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\stock\H'+s);
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\stock\D'+s);
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\stock\P'+s);
  Calc;
  if AObj.FieldByName('CLIENT_ID').AsString <> '' then
     begin
       edtCLIENT_ID.KeyValue := AObj.FieldByName('CLIENT_ID').AsString;
       edtCLIENT_ID.Text := AObj.FieldByName('CLIENT_ID_TEXT').AsString;
     end;
  if PayZero <> 0 then
     begin
       DoPayZero(FloatToStr(TotalFee-PayZero));
     end;
end;

function TfrmStockOrder.getPaymentTitle(pay: string): string;
var
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
  if rs.Locate('CODE_ID',pay,[]) then
     result := rs.FieldByName('CODE_NAME').AsString
  else
     Raise Exception.Create('��֧�ֵ��տʽ'); 
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
       btnNav.Caption := '��ʷ����';
       lblCaption.Caption := '������';
    end;
  1:begin
       btnNav.Caption := '����';
       lblCaption.Caption := '�������б�';
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
  PrintDBGridEh1.PageHeader.CenterText.Text := '�������б�';
  DBGridEh2.DBGridTitle := '�������б�';
  DBGridEh2.DBGridHeader.Text := '����:'+formatDatetime('YYYY-MM-DD',D1.Date)+'��'+formatDatetime('YYYY-MM-DD',D2.Date);
  DBGridEh2.DBGridFooter.Text := ' '+#13+' ����Ա:'+token.UserName+'  ����ʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+token.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', '����:'+formatDatetime('YYYY-MM-DD',D1.Date)+'��'+formatDatetime('YYYY-MM-DD',D2.Date)]);
end;

procedure TfrmStockOrder.paymentClick(Sender: TObject);
begin
  inherited;
  if TfrmPayment.payment(self,totalFee-AObj.FieldByName('PAY_ZERO').AsFloat,AObj) then
     DoShowPayment;
end;

procedure TfrmStockOrder.PrintOrder;
var tid,oid:string;
begin
  inherited;
  if dbState <> dsBrowse then Raise Exception.Create('������ʷ�����д�ӡ...');
  if AObj.FieldByName('STOCK_ID').AsString = '' then Exit;
  tid := token.tenantId;
  oid := AObj.FieldByName('STOCK_ID').AsString;
  TfrmOrderPreview.PrintReport(self,0,frfStockOrder,tid,oid);
end;

procedure TfrmStockOrder.PreviewOrder;
var
  r:integer;
  tid,oid:string;
begin
  inherited;
  if dbState <> dsBrowse then Raise Exception.Create('������ʷ������Ԥ��...');
  if AObj.FieldByName('STOCK_ID').AsString = '' then Exit;
  r := TfrmSaveDesigner.ShowDialog(self,'frfStockOrder',nil);
  if r < 0 then Exit;
  GlobalIndex := r;
  tid := token.tenantId;
  oid := AObj.FieldByName('STOCK_ID').AsString;
  TfrmOrderPreview.ShowReport(self,0,frfStockOrder,tid,oid,'������');
end;

procedure TfrmStockOrder.frfStockOrderGetValue(const ParName: String;
  var ParValue: Variant);
begin
  inherited;
  if ParName='��ҵ����' then ParValue := token.tenantName;
  if ParName='��ӡ��' then ParValue := token.username;
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

procedure TfrmStockOrder.edtACCT_MNYKeyPress(Sender: TObject; var Key: Char);
var r,fee:currency;
begin
  inherited;
  if Key=#13 then
     begin
       if abs(StrtoFloatDef(edtACCT_MNY.Text,0))>TotalFee then edtACCT_MNY.Text := FloatToStr(TotalFee);
       r := StrtoFloatDef(edtACCT_MNY.Text,0);
       AObj.FieldByName('PAY_ZERO').AsFloat := TotalFee-r;
       if TotalFee<>0 then
          edtAGIO_RATE.Text := FormatFloat('#0.0',r*100/TotalFee)
       else
          edtAGIO_RATE.Text := '';
       fee :=
        AObj.FieldByName('PAY_B').AsFloat+
        AObj.FieldByName('PAY_C').AsFloat+
        AObj.FieldByName('PAY_D').AsFloat+
        AObj.FieldByName('PAY_E').AsFloat+
        AObj.FieldByName('PAY_F').AsFloat+
        AObj.FieldByName('PAY_G').AsFloat+
        AObj.FieldByName('PAY_H').AsFloat+
        AObj.FieldByName('PAY_I').AsFloat+
        AObj.FieldByName('PAY_J').AsFloat;
       if fee=0 then
          edtPAY_TOTAL.Text := FormatFloat('#0.00',r)
       else
          edtPAY_TOTAL.Text := FormatFloat('#0.00',fee+AObj.FieldByName('PAY_A').AsFloat);
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
       AObj.FieldByName('PAY_ZERO').AsFloat := TotalFee-roundTo(TotalFee*r/100,-2);
       edtACCT_MNY.Text := FormatFloat('#0.00',TotalFee-AObj.FieldByName('PAY_ZERO').AsFloat);
       fee :=
        AObj.FieldByName('PAY_B').AsFloat+
        AObj.FieldByName('PAY_C').AsFloat+
        AObj.FieldByName('PAY_D').AsFloat+
        AObj.FieldByName('PAY_E').AsFloat+
        AObj.FieldByName('PAY_F').AsFloat+
        AObj.FieldByName('PAY_G').AsFloat+
        AObj.FieldByName('PAY_H').AsFloat+
        AObj.FieldByName('PAY_I').AsFloat+
        AObj.FieldByName('PAY_J').AsFloat;
       if fee=0 then
          edtPAY_TOTAL.Text := FormatFloat('#0.00',r)
       else
          edtPAY_TOTAL.Text := FormatFloat('#0.00',fee+AObj.FieldByName('PAY_A').AsFloat);
     end;
end;

procedure TfrmStockOrder.edtAGIO_RATEExit(Sender: TObject);
var Key:Char;
begin
  inherited;
  Key := #13;
  edtAGIO_RATEKeyPress(nil,Key);
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
       AObj.FieldByName('PAY_A').AsFloat := r;
       AObj.FieldByName('PAY_B').AsFloat := 0;
       AObj.FieldByName('PAY_C').AsFloat := 0;
       // AObj.FieldByName('PAY_D').AsFloat := (totalFee-AObj.FieldByName('PAY_ZERO').AsFloat)-r;
       AObj.FieldByName('PAY_D').AsFloat := 0;
       AObj.FieldByName('PAY_E').AsFloat := 0;
       AObj.FieldByName('PAY_F').AsFloat := 0;
       AObj.FieldByName('PAY_G').AsFloat := 0;
       AObj.FieldByName('PAY_H').AsFloat := 0;
       AObj.FieldByName('PAY_I').AsFloat := 0;
       AObj.FieldByName('PAY_J').AsFloat := 0;
       payment.Caption := '�ֽ��տ�';
     end;
end;

procedure TfrmStockOrder.RzToolButton4Click(Sender: TObject);
var
   _obj,hdr:TRecord_;
   rs,edt:TZQuery;
begin
   inherited;
   Open(cdsList.FieldByName('STOCK_ID').AsString);
   if (MessageBox(Handle,pchar('�Ƿ�����˻��򻻻�������'),pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6) then Exit;
   _obj := TRecord_.Create;
   rs := TZQuery.Create(nil);
   hdr := TRecord_.Create;
   edt := TZQuery.Create(nil);
   try
     _obj.ReadFromDataSet(edtTable);
     AObj.CopyTo(hdr);
     rs.Data := edtProperty.Data;
     edt.Data := edtTable.Data;
     NewOrder;
     edtTable.First;
     while not edtTable.Eof do edtTable.Delete;
     AObj.FieldByName('CLIENT_ID').AsString := hdr.FieldByName('CLIENT_ID').AsString;
     AObj.FieldByName('CLIENT_ID_TEXT').AsString := hdr.FieldByName('CLIENT_ID_TEXT').AsString;
     AObj.FieldByName('PAY_ZERO').AsString := hdr.FieldByName('PAY_ZERO').AsString;
     edtCLIENT_ID.Text := AObj.FieldByName('CLIENT_ID_TEXT').AsString;
     edtCLIENT_ID.KeyValue := AObj.FieldByName('CLIENT_ID').AsString;
     edt.First;
     while not edt.Eof do
        begin
         edtTable.Append;
         _obj.Clear;
         _obj.ReadFromDataSet(edt); 
         _obj.WriteToDataSet(edtTable,false);
         inc(ROWID);
         edtTable.FieldByName('SEQNO').AsInteger := ROWID;
         edtTable.FieldByName('AMOUNT').AsFloat := - edt.FieldByName('AMOUNT').AsFloat;
         AmountToCalc(edtTable.FieldByName('AMOUNT').AsFloat);
         edtTable.Post;
         rs.Filtered := false;
         rs.Filter := 'SEQNO='+_obj.FieldByName('SEQNO').AsString;
         rs.Filtered := true;
         _obj.Clear;
         rs.First;
         while not rs.Eof do
           begin
             edtProperty.Append;
             _obj.ReadFromDataSet(rs);
             _obj.WriteToDataSet(edtProperty,false);
             edtProperty.FieldByName('AMOUNT').AsFloat := - edtProperty.FieldByName('AMOUNT').AsFloat;
             edtProperty.FieldByName('CALC_AMOUNT').AsFloat := - edtProperty.FieldByName('CALC_AMOUNT').AsFloat;
             edtProperty.Post;
             rs.Next;
           end;
        edt.Next;
     end;
     InitRecord;
     Calc;
     AObj.FieldByName('PAY_ZERO').AsFloat := -hdr.FieldByName('PAY_ZERO').AsFloat;
     DoShowPayment;
   finally
     rs.Free;
     _obj.Free;
     edt.Free;
     hdr.Free;
   end;
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.edtCLIENT_IDAddClick(Sender: TObject);
var
  _Obj:TRecord_;
begin
  inherited;
  _Obj := TRecord_.Create;
  try
     if TfrmSupplierDialog.ShowDialog(self,'',_Obj) then
        begin
          edtCLIENT_ID.KeyValue := _Obj.FieldByName('CLIENT_ID').AsString;
          edtCLIENT_ID.Text := _Obj.FieldByName('CLIENT_NAME').AsString;
        end;
  finally
     _Obj.Free;
  end;
end;

procedure TfrmStockOrder.btnImportClick(Sender: TObject);
begin
  inherited;
  ImportExcelClick(nil);

end;

procedure TfrmStockOrder.DBGridEh1Columns10UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
begin
  inherited;
  if edtTable.FieldByName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       Exit;
     end;
end;

procedure TfrmStockOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var CurPrice,OrgPrice:real;
begin
  inherited;
  try
    if not edtTable.Active then Exit;
    if edtTable.FieldByName('GODS_ID').AsString = '' then Exit;
    if Column.FieldName = 'APRICE' then
       begin
         if edtTable.FieldByName('IS_PRESENT').AsInteger = 0 then
            begin
              CurPrice := edtTable.FieldByName('APRICE').AsFloat;
              OrgPrice := edtTable.FieldByName('ORG_PRICE').AsFloat;
              if (FnNumber.CompareFloat(CurPrice, OrgPrice) > 0)
                 or
                 (FnNumber.CompareFloat(CurPrice, OrgPrice * 0.3) < 0) then
                 begin
                   DBGridEh1.Canvas.Brush.Color := clRed;
                   DBGridEh1.Canvas.Font.Color := clwhite;
                   DBGridEh1.Canvas.Font.Style := [fsBold];
                 end;
              DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
            end;
       end;
  except
  end;
end;

procedure TfrmStockOrder.getGodsInfo(godsId: string);
var
  rs:TZQuery;
  SourceScale:real;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Exit;
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('CALC_UNITS').AsString then
     begin
       SourceScale := 1;
     end
  else
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('BIG_UNITS').AsString then
     begin
       SourceScale := rs.FieldByName('BIGTO_CALC').AsFloat;
     end
  else
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('SMALL_UNITS').AsString then
     begin
       SourceScale := rs.FieldByName('SMALLTO_CALC').AsFloat;
     end
  else
     begin
       SourceScale := 1;
     end;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select sum(amount) from STO_STORAGE where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID';
    rs.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
    rs.ParamByName('GODS_ID').AsString := edtTable.FieldByName('GODS_ID').AsString;
    dataFactory.Open(rs);
    godsAmount.Caption := ' '+edtTable.FieldByName('GODS_NAME').AsString+' ���:'+FormatFloat('#0.###',rs.Fields[0].AsFloat/SourceScale)+''+TdsFind.GetNameByID(dllGlobal.GetZQueryFromName('PUB_MEAUNITS'),'UNIT_ID','UNIT_NAME',edtTable.FieldByName('UNIT_ID').AsString);
  finally
    rs.Free;
  end;
end;

procedure TfrmStockOrder.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  getGodsInfo(edtTable.FieldByName('GODS_ID').AsString);
end;

procedure TfrmStockOrder.edtCLIENT_IDDblClick(Sender: TObject);
var
  rs:TZQuery;
  SObj:TRecord_;
begin
  inherited;
  if edtCLIENT_ID.AsString = '' then Exit;
  rs := dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');
  if rs.Locate('CLIENT_ID', edtCLIENT_ID.AsString, []) then
     begin
       if rs.FieldByName('FLAG').AsString = '0' then
          begin
            SObj := TRecord_.Create;
            try
              if TfrmSupplierDialog.ShowDialog(self, edtCLIENT_ID.AsString, SObj) then
                 begin
                   edtCLIENT_ID.KeyValue := SObj.FieldByName('CLIENT_ID').AsString;
                   edtCLIENT_ID.Text := SObj.FieldByName('CLIENT_NAME').AsString;
                   AObj.FieldByName('CLIENT_ID').AsString := SObj.FieldByName('CLIENT_ID').AsString;
                 end;
            finally
              SObj.Free;
            end;
          end;
     end;
end;

initialization
  RegisterClass(TfrmStockOrder);
finalization
  UnRegisterClass(TfrmStockOrder);
end.
