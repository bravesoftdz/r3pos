unit ufrmPosOutOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmOrderForm, RzButton, RzPanel, cxTextEdit, cxDropDownEdit,
  cxCalendar, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, StdCtrls, RzLabel, ExtCtrls, RzBmpBtn,
  RzBorder, RzTabs, RzStatus, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZBase, Math, Menus, pngimage, RzBckgnd, jpeg, dllApi,objCommon,
  PrnDbgeh,ufrmDBGridPreview;

type
  TfrmPosOutOrder = class(TfrmOrderForm)
    TabSheet2: TRzTabSheet;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    cdsICGlide: TZQuery;
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
    RzPanel19: TRzPanel;
    MarqueeStatus: TRzMarqueeStatus;
    edtBK_CLIENT_ID: TRzPanel;
    RzPanel21: TRzPanel;
    RzBackground1: TRzBackground;
    RzLabel1: TRzLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtVBK_SALES_DATE: TRzPanel;
    RzPanel20: TRzPanel;
    RzBackground2: TRzBackground;
    RzLabel2: TRzLabel;
    edtSALES_DATE: TcxDateEdit;
    edtBK_PAY_TOTAL: TRzPanel;
    RzPanel10: TRzPanel;
    RzBackground6: TRzBackground;
    payment: TRzLabel;
    edtPAY_TOTAL: TcxTextEdit;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
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
    btnFind: TRzBmpButton;
    RzPanel5: TRzPanel;
    Image1: TImage;
    Image6: TImage;
    Image7: TImage;
    serachText: TEdit;
    RzPanel4: TRzPanel;
    Image8: TImage;
    Image9: TImage;
    RzPanel13: TRzPanel;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    RzPanel15: TRzPanel;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    RzPanel16: TRzPanel;
    RzPanel24: TRzPanel;
    btnSave: TRzBmpButton;
    btnNew: TRzBmpButton;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    RzLabel12: TRzLabel;
    RzLabel11: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel13: TRzLabel;
    RzLabel14: TRzLabel;
    RzLabel15: TRzLabel;
    RzPanel25: TRzPanel;
    godsName: TRzLabel;
    godsPrice: TRzLabel;
    godsAmount: TRzLabel;
    edtBK_ACCT_MNY: TRzPanel;
    RzLabel6: TRzLabel;
    RzPanel7: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel4: TRzLabel;
    edtACCT_MNY: TcxTextEdit;
    edtAGIO_RATE: TcxTextEdit;
    RzPanel8: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel5: TRzLabel;
    godsPhotoBk: TRzPanel;
    godsPhoto: TImage;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns8UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure PageControlChange(Sender: TObject);
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
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure edtPAY_TOTALPropertiesChange(Sender: TObject);
    procedure edtACCT_MNYPropertiesChange(Sender: TObject);
    procedure edtAGIO_RATEPropertiesChange(Sender: TObject);
    procedure serachTextEnter(Sender: TObject);
    procedure serachTextExit(Sender: TObject);
    procedure edtTableAfterDelete(DataSet: TDataSet);
    procedure serachTextChange(Sender: TObject);
    procedure helpClick(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure cdsListBeforeOpen(DataSet: TDataSet);
    procedure serachTextKeyPress(Sender: TObject; var Key: Char);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure btnPreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
  private
    { Private declarations }
    AObj:TRecord_;
    //Ĭ�Ϸ�Ʊ����
    DefInvFlag:integer;
    //��ͨ˰��
    RtlRate2:Currency;
    //��ֵ˰��
    RtlRate3:Currency;
    //������
    TotalFee:Currency;
    //��������
    TotalAmt:Currency;
    //��������
    TotalBarter:integer;

    agioLower:Currency;
    //��λ����
    CarryRule:integer;
    //����С��λ
    Deci:integer;
    
    searchTxt:string;
    procedure DBGridPrint;
  protected
    procedure getGodsInfo(godsId:string);
    procedure SetdbState(const Value: TDataSetState);override;
    procedure PresentToCalc(Present:integer);override;
    procedure SetinputFlag(const Value: integer);override;
    function  CheckSale_Limit: Boolean;
    function  checkPayment:boolean;
    function  payCashMny(s:string):boolean;
    procedure DoShowPayment;
    procedure Calc; //2011.06.09�ж��Ƿ�����
    function  CheckNotChangePrice(GodsID: string): Boolean; //2011.06.08�����Ƿ���ҵ����
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    function GetCostPrice(GODS_ID, BATCH_NO: string): real;
    //�ض�������Ʒ�۸�
    procedure CalcPrice;
    function getPaymentTitle(pay:string):string;

    //��ݽ�
    function  doShortCut(s:string):boolean;override;
    procedure DoIsPresent(s:string);
    procedure DoCustId(s:string);
    procedure DoGuideUser(s:string);
    procedure DoNewOrder;
    procedure DoHangUp;
    procedure DoPickUp;
    procedure DoPayZero(s:string);
    procedure DoPayInput(s:string;flag:string);
    procedure DoSaveOrder;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure showForm;override;

    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure Open(id:string);override;

    procedure OpenList;
  end;

var
  frmPosOutOrder: TfrmPosOutOrder;

implementation
uses utokenFactory,udllDsUtil,udllShopUtil,udllFnUtil, udllGlobal, udataFactory, uCacheFactory;
{$R *.dfm}

{ TfrmSaleOrder }

procedure TfrmPosOutOrder.Calc;
var
  r:integer;
  mny:Currency;
  ago:Currency;
  prf:Currency;
  t:integer;
  amt:Currency;
  integral:integer;
  ps:TZQuery;
  orgFee:Currency;
begin
  ps := dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');
  if ps.Locate('PRICE_ID',AObj.FieldbyName('PRICE_ID').AsString,[]) then
     begin
       t := ps.FieldbyName('INTE_TYPE').AsInteger;
       amt := ps.FieldbyName('INTE_AMOUNT').AsFloat;
     end
  else
     begin
       t := 0;
       amt := 0;
     end;
  edtTable.DisableControls;
  try
    r := edtTable.FieldbyName('SEQNO').AsInteger;
    orgFee := TotalFee;
    TotalFee := 0;
    TotalAmt := 0;
    TotalBarter := 0;
    prf := 0;
    mny := 0;
    ago := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        TotalFee := TotalFee + edtTable.FieldbyName('CALC_MONEY').AsFloat;
        TotalAmt := TotalAmt + edtTable.FieldbyName('AMOUNT').AsFloat;
        if (edtTable.FieldbyName('HAS_INTEGRAL').AsInteger =1 ) and (edtTable.FieldbyName('IS_PRESENT').AsInteger=0) then
        begin
        prf := prf + edtTable.FieldbyName('CALC_MONEY').AsFloat-(edtTable.FieldbyName('COST_PRICE').AsFloat*edtTable.FieldbyName('CALC_AMOUNT').AsFloat);
        mny := mny + edtTable.FieldbyName('AMONEY').AsFloat;
        ago := ago + edtTable.FieldbyName('AGIO_MONEY').AsFloat;
        end;
        if edtTable.FieldbyName('IS_PRESENT').AsInteger = 2 then
           TotalBarter := TotalBarter + trunc(edtTable.FieldbyName('CALC_AMOUNT').AsFloat*edtTable.FieldbyName('BARTER_INTEGRAL').AsFloat);
        edtTable.Next;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]);
    edtTable.EnableControls;
  end;
  if (dbState<>dsBrowse) then
  begin
    if (amt<>0) then
       begin
         case t of
         1:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(TotalFee / amt);
         2:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(prf / amt);
         3:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(TotalAmt / amt);
         end;
       end;
       
    AObj.FieldbyName('SALE_AMT').asFloat := TotalAmt;
    AObj.FieldbyName('SALE_MNY').asFloat := TotalFee;
    if orgFee<>TotalFee then
    begin
      AObj.FieldbyName('PAY_ZERO').asFloat := 0;
      AObj.FieldbyName('CASH_MNY').asFloat := TotalFee;
      AObj.FieldbyName('PAY_DIBS').asFloat := 0;
    end;

    edtACCT_MNY.Text := formatFloat('#0.00',TotalFee);
    edtAGIO_RATE.Text := '100.0';
    DoShowPayment;
    AObj.FieldbyName('BARTER_INTEGRAL').AsInteger := TotalBarter;
  end;
end;

procedure TfrmPosOutOrder.CancelOrder;
begin
  if dbState = dsBrowse then Exit;
  if dbState = dsInsert then
     NewOrder
  else
     Open(AObj.FieldbyName('SALES_ID').AsString);
end;

function TfrmPosOutOrder.CheckSale_Limit: Boolean;
var
  CurIdx: integer;
  GodsID, RelationID: string;
  Singe_Litmit,All_Litmit: Real;  //��Ʒ��������������
  RsGods,RsRelation,GodsQry,RelQry: TZQuery;
begin
  result:=False;
  try
    GodsQry:=TZQuery.Create(nil);  //������Ʒ����
    GodsQry.Close;
    GodsQry.FieldDefs.Add('GODS_ID',ftstring,36,true);
    GodsQry.FieldDefs.Add('GODS_NAME',ftstring,50,true);
    GodsQry.FieldDefs.Add('CalcSum',ftFloat,0,true);
    GodsQry.CreateDataSet;
    RelQry:=TZQuery.Create(nil);   //������Ӧ������
    RelQry.Close;
    RelQry.FieldDefs.Add('RELATION_ID',ftInteger,0,true);
    RelQry.FieldDefs.Add('RELATION_NAME',ftstring,50,true);
    RelQry.FieldDefs.Add('CalcSum',ftFloat,0,true);
    RelQry.CreateDataSet;
    RsGods:=dllGlobal.GetZQueryFromName('PUB_GOODSINFO'); //��Ʒ����
    RsRelation:=dllGlobal.GetZQueryFromName('CA_RELATIONS'); //��Ӧ��
    //��ʼѭ��[�ۼƳ�������Ʒ�͹�Ӧ����������]��
    CurIdx:=edtTable.RecNo;  //���浱ǰ���
    edtTable.First;
    while not edtTable.Eof do
    begin
      GodsID:=trim(edtTable.fieldbyName('GODS_ID').AsString);
      //����Ŀ�ۼ�
      if GodsQry.Locate('GODS_ID',GodsID,[]) then //��λ���ۼ�����
      begin
        GodsQry.Edit;
        GodsQry.FieldByName('CalcSum').AsFloat:=GodsQry.FieldByName('CalcSum').AsFloat+edtTable.fieldbyName('CALC_AMOUNT').AsFloat;
        GodsQry.Post;
      end else
      begin
        GodsQry.Append;
        GodsQry.FieldByName('GODS_ID').AsString:=GodsID;
        GodsQry.FieldByName('GODS_NAME').AsString:=trim(edtTable.fieldbyName('GODS_NAME').AsString);
        GodsQry.FieldByName('CalcSum').AsFloat:=edtTable.fieldbyName('CALC_AMOUNT').AsFloat;
        GodsQry.Post;
      end;
      
      if RsGods.Locate('GODS_ID',GodsID,[]) then
      begin
        RelationID:=trim(RsGods.fieldbyName('RELATION_ID').AsString);
        //����Ŀ�ۼ�
        if RelQry.Locate('RELATION_ID',RelationID,[]) then //��λ���ۼ�����
        begin
          RelQry.Edit;
          RelQry.FieldByName('CalcSum').AsFloat:=RelQry.FieldByName('CalcSum').AsFloat+edtTable.fieldbyName('CALC_AMOUNT').AsFloat;
          RelQry.Post;
        end else
        begin
          RelQry.Append;
          RelQry.FieldByName('RELATION_ID').AsString:=RelationID;
          if RsRelation.Locate('RELATION_ID',RelationID,[]) then 
            RelQry.FieldByName('RELATION_NAME').AsString:=trim(RsRelation.fieldbyName('RELATION_NAME').AsString);
          RelQry.FieldByName('CalcSum').AsFloat:=edtTable.fieldbyName('CALC_AMOUNT').AsFloat;
          RelQry.Post;
        end;
      end;
      edtTable.Next;
    end;

    //�жϵ�Ʒ�Ƿ񳬹�
    GodsQry.First;
    while not GodsQry.Eof do
    begin
      GodsID:=trim(GodsQry.fieldbyName('GODS_ID').AsString);
      if RsGods.Locate('GODS_ID',GodsID,[]) then
      begin
        RelationID:=trim(RsGods.fieldbyName('RELATION_ID').AsString);
        if RsRelation.Locate('RELATION_ID',RelationID,[]) then
        begin
          Singe_Litmit:=RsRelation.FieldByName('SINGLE_LIMIT').AsFloat; //��Ʒ����
          if (Singe_Litmit>0) and (GodsQry.FieldByName('CalcSum').AsFloat>Singe_Litmit) then
            Raise Exception.Create('��Ʒ��'+GodsQry.fieldbyName('GODS_NAME').AsString+'������'+FloattoStr(GodsQry.FieldByName('CalcSum').AsFloat)+'��������ֵ'+FloattoStr(Singe_Litmit)+'��');
        end;
      end;
      GodsQry.Next;
    end;

    //�жϹ�Ӧ������������
    RelQry.First;
    while not RelQry.Eof do
    begin
      RelationID:=trim(RelQry.fieldbyName('RELATION_ID').AsString);
      if RsRelation.Locate('RELATION_ID',RelationID,[]) then
      begin
        All_Litmit:=RsRelation.FieldByName('SALE_LIMIT').AsFloat; //��������
        if (All_Litmit>0) and (RelQry.FieldByName('CalcSum').AsFloat>All_Litmit) then
          Raise Exception.Create('��Ӧ����'+RelQry.FieldByName('RELATION_NAME').AsString+'����������'+FloattoStr(RelQry.FieldByName('CalcSum').AsFloat)+' ��������ֵ'+FloattoStr(All_Litmit)+'��');
      end;
      RelQry.Next;
    end;
  finally
    edtTable.RecNo:=CurIdx;
    GodsQry.Free;
    RelQry.Free;
  end;
end;

constructor TfrmPosOutOrder.Create(AOwner: TComponent);
begin
  inherited;
  AObj := TRecord_.Create;
  //��λ����
  CarryRule := StrtoIntDef(dllGlobal.GetParameter('CARRYRULE'),0);
  //����С��λ
  Deci := StrtoIntDef(dllGlobal.GetParameter('POSDIGHT'),2);
end;

procedure TfrmPosOutOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('����ɾ���յ���');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ���ɾ��');
  if MessageBox(Handle,'�Ƿ�����ɾ����ǰ����?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  cdsICGlide.First;
  while not cdsICGlide.Eof do cdsICGlide.Delete;
  dataFactory.BeginBatch;
  try
    dataFactory.AddBatch(cdsHeader,'TSalesOrderV60');
    dataFactory.AddBatch(cdsDetail,'TSalesDataV60');
    dataFactory.AddBatch(cdsICGlide,'TSalesICDataV60');
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    cdsICGlide.CancelUpdates;
    Raise;
  end;
  AObj.ReadFromDataSet(cdsHeader);
  ReadFromObject(AObj,self);
  ReadFrom(cdsDetail);
  dbState := dsBrowse;
end;

destructor TfrmPosOutOrder.Destroy;
begin
  AObj.Free;
  inherited;
end;

procedure TfrmPosOutOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  dbState := dsEdit;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus
  else
  if edtCLIENT_ID.CanFocus and Visible then
     edtCLIENT_ID.SetFocus;
end;

procedure TfrmPosOutOrder.NewOrder;
var
  rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  AObj.FieldbyName('TENANT_ID').AsString := token.tenantId;
  AObj.FieldbyName('SHOP_ID').asString := token.shopId;

  AObj.FieldbyName('DEPT_ID').asString := dllGlobal.getMyDeptId;

  AObj.FieldbyName('SALES_ID').asString := TSequence.NewId();
  AObj.FieldbyName('UNION_ID').asString := '#';
  AObj.FieldbyName('PRICE_ID').asString := '#';
  edtCLIENT_ID.KeyValue := '';
  edtCLIENT_ID.Text := '��ͨ�ͻ�';
  AObj.FieldByName('SALE_AMT').AsFloat := 0;
  AObj.FieldByName('SALE_MNY').AsFloat := 0;
  AObj.FieldByName('CASH_MNY').AsFloat := 0;
  AObj.FieldByName('PAY_ZERO').AsFloat := 0;
  AObj.FieldByName('PAY_DIBS').AsFloat := 0;
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
  AObj.FieldByName('GUIDE_USER').AsString := token.userId;

  edtSALES_DATE.Date := dllGlobal.SysDate;

  AObj.FieldbyName('PLAN_DATE').AsString := formatdatetime('YYYYMMDD',dllGlobal.SysDate);

  AObj.FieldbyName('INVOICE_FLAG').AsInteger := DefInvFlag;
  case DefInvFlag of
  1: AObj.FieldbyName('TAX_RATE').AsFloat := 0;
  2: AObj.FieldbyName('TAX_RATE').AsFloat := RtlRate2;
  3: AObj.FieldbyName('TAX_RATE').AsFloat := RtlRate3;
  end;
  InitRecord;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus;
end;

procedure TfrmPosOutOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    Params.ParamByName('SALES_ID').asString := id;
    Params.ParamByName('VIW_GOODSINFO').AsString := dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE',true);
    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsHeader,'TSalesOrderV60',Params);
      dataFactory.AddBatch(cdsDetail,'TSalesDataV60',Params);
      dataFactory.AddBatch(cdsICGlide,'TSalesICDataV60',Params);
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
    Params.Free;
  end;
end;

procedure TfrmPosOutOrder.SaveOrder;
var
  Printed:boolean;
begin
  if dbState = dsBrowse then Exit;

  if edtSALES_DATE.EditValue = null then Raise Exception.Create('�������ڲ���Ϊ��');
  //2011.06.09 Add �ж��Ƿ�����
  CheckSale_Limit;

  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('���ܱ���һ�ſյ���...');
  CheckInvaid;
  WriteToObject(AObj,self);

  AObj.FieldByName('SALES_TYPE').AsInteger := 4;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := token.userId;
  AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',dllGlobal.SysDate);
  AObj.FieldByName('CHK_USER').AsString := token.userId;
  AObj.FieldByName('LOCUS_STATUS').AsString := '3';
  if not checkPayment then Exit;

  if (AObj.FieldByName('BARTER_INTEGRAL').AsFloat<>0) and (AObj.FieldByName('CLIENT_ID').AsString='') then Raise Exception.Create('���ǻ�Ա���ѣ������л��ֶһ�����Ʒ.');

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
         cdsDetail.FieldByName('SALES_ID').AsString := cdsHeader.FieldbyName('SALES_ID').AsString;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    dataFactory.AddBatch(cdsHeader,'TSalesOrderV60');
    dataFactory.AddBatch(cdsDetail,'TSalesDataV60');
    dataFactory.AddBatch(cdsICGlide,'TSalesICDataV60');
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    cdsICGlide.CancelUpdates;
    Raise;
  end;
  dbState := dsBrowse;
end;

procedure TfrmPosOutOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;

end;

procedure TfrmPosOutOrder.showForm;
begin
  inherited;
  RtlRate2 := StrtoFloatDef(dllGlobal.GetParameter('RTL_RATE2'),0.05);
  RtlRate3 := StrtoFloatDef(dllGlobal.GetParameter('RTL_RATE3'),0.17);
  DefInvFlag := StrtoIntDef(dllGlobal.GetParameter('RTL_INV_FLAG'),1);
  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CUSTOMER');
  NewOrder;
end;

procedure TfrmPosOutOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  fndGODS_ID.Text := edtTable.FieldbyName('GODS_NAME').AsString;
  fndGODS_ID.KeyValue := edtTable.FieldbyName('GODS_ID').AsString;
  fndGODS_ID.SaveStatus;

end;

procedure TfrmPosOutOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;
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
          if abs(r)>999999999 then Raise Exception.Create('�������ֵ������Ч');
        except
          if length(Text)<10 then MessageBox(handle,'�������������Ч��������','������ʾ..',MB_OK+MB_ICONINFORMATION);
          Text := TColumnEh(Sender).Field.AsString;
          Value := TColumnEh(Sender).Field.asFloat;
          Exit;
        end;
        TColumnEh(Sender).Field.asFloat := r;
        AMountToCalc(r);
     end;
end;

procedure TfrmPosOutOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r,op:Currency;
  allow :boolean;
  bs:TZQuery;
begin
   if length(Text)>10 then
      begin
         Text := TColumnEh(Sender).Field.AsString;
         Value := TColumnEh(Sender).Field.asFloat;
         Exit;
      end;
  //2011.06.08 Add ��Ӧ�����Ƹļۣ�
  if CheckNotChangePrice(edtTable.fieldbyName('GODS_ID').AsString) then
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('��Ʒ��'+edtTable.FieldByName('GODS_NAME').AsString+'��ͳһ���ۣ��������޸ĵ��ۣ�'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    Exit;
  end;

  //����Ȩ��(����Ȩ��)
  if not dllGlobal.GetChkRight('12400001',5) then
     begin
       allow := false;
     end else allow := true;

  if allow then
  begin
    try
      if Text='' then
         r := 0
      else
         r := StrtoFloat(Text);
      if abs(r)>999999999 then Raise Exception.Create('�������ֵ������Ч');
    except
      on E:Exception do
         begin
           if length(Text)<10 then  MessageBox(Handle,pchar('������ĵ�����Ч������������'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
           Text := TColumnEh(Sender).Field.AsString;
           Value := TColumnEh(Sender).Field.asFloat;
           Exit;
         end;
    end;
    op := TColumnEh(Sender).Field.asFloat;
    TColumnEh(Sender).Field.asFloat := r;
    PriceToCalc(r);
    if edtTable.FieldbyName('AGIO_RATE').AsFloat < agioLower then
       begin
         edtTable.Edit;
         edtTable.FieldbyName('APRICE').AsFloat := op;
         PriceToCalc(edtTable.FieldbyName('APRICE').AsFloat);
         Text := TColumnEh(Sender).Field.AsString;
         Value := TColumnEh(Sender).Field.asFloat;
         edtTable.Edit;
         MessageBox(Handle,pchar('������Ͳ��ܵ���'+formatFloat('#0.000',agioLower)+'%��'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
         Exit;
       end;
    bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    if bs.Locate('GODS_ID',edtTable.FieldbyName('GODS_ID').AsString,[]) and (edtTable.FieldByName('CALC_AMOUNT').AsCurrency<>0) then
       begin
         if RoundTo(edtTable.FieldByName('CALC_MONEY').AsCurrency/edtTable.FieldByName('CALC_AMOUNT').AsCurrency,-3)<bs.FieldByName('NEW_LOWPRICE').AsCurrency then
         begin
           edtTable.Edit;
           edtTable.FieldbyName('APRICE').AsFloat := op;
           PriceToCalc(op);
           Text := TColumnEh(Sender).Field.AsString;
           Value := TColumnEh(Sender).Field.asFloat;
           edtTable.Edit;
           MessageBox(Handle,pchar('������Ͳ��ܵ���'+formatFloat('#0.000',bs.FieldByName('NEW_LOWPRICE').AsFloat)+'Ԫ'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
           Exit;
         end;
       end;
    edtTable.Edit;
    edtTable.FieldbyName('POLICY_TYPE').AsInteger := 4;
  end
  else
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('��û���޸����۵��۸��Ȩ��,��͹���Ա��ϵ...'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
end;

procedure TfrmPosOutOrder.DBGridEh1Columns8UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r,op:Currency;
  allow :boolean;
  bs:TZQuery;
begin
  //2011.06.08 Add ��Ӧ�����Ƹļۣ�
  if CheckNotChangePrice(edtTable.fieldbyName('GODS_ID').AsString) then
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('��Ʒ��'+edtTable.FieldByName('GODS_NAME').AsString+'��ͳһ���ۣ��������޸��ۿۣ�'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    Exit;
  end;

  if not dllGlobal.GetChkRight('12400001',5) then
     begin
      { if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',5,Params.UserID);
            if not allow then Raise Exception.Create('��������û�û�е���Ȩ��...');
          end
       else     }
       allow := false;
     end else allow := true;
  if allow then
  begin
    try
      if Text='' then
         r := 0
      else
         r := StrtoFloat(Text);
      if abs(r)>100 then Raise Exception.Create('�������ֵ������Ч');
      edtTable.Edit;
    except
      on E:Exception do
         begin
            Text := TColumnEh(Sender).Field.AsString;
            Value := TColumnEh(Sender).Field.asFloat;
            MessageBox(Handle,pchar('������Ч�ۿ���,����'+E.Message),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
            Exit;
         end;
    end;
    op := edtTable.FieldbyName('APRICE').AsFloat;
    TColumnEh(Sender).Field.asFloat := r;
    AgioToCalc(r);

    if edtTable.FieldbyName('AGIO_RATE').AsFloat < agioLower then
       begin
         edtTable.Edit;
         edtTable.FieldbyName('APRICE').AsFloat := op;
         PriceToCalc(edtTable.FieldbyName('APRICE').AsFloat);
         Text := TColumnEh(Sender).Field.AsString;
         Value := TColumnEh(Sender).Field.asFloat;
         edtTable.Edit;
         MessageBox(Handle,pchar('������Ͳ��ܵ���'+formatFloat('#0.000',agioLower)+'%��'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
         Exit;
       end;
    bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    if bs.Locate('GODS_ID',edtTable.FieldbyName('GODS_ID').AsString,[]) and (edtTable.FieldByName('CALC_AMOUNT').AsCurrency<>0) then
       begin
         if RoundTo(edtTable.FieldByName('CALC_MONEY').AsCurrency/edtTable.FieldByName('CALC_AMOUNT').AsCurrency,-3)<bs.FieldByName('NEW_LOWPRICE').AsCurrency then
         begin
           edtTable.Edit;
           edtTable.FieldbyName('APRICE').AsFloat := op;
           PriceToCalc(op);
           Text := TColumnEh(Sender).Field.AsString;
           Value := TColumnEh(Sender).Field.asFloat;
           edtTable.Edit;
           MessageBox(Handle,pchar('������Ͳ��ܵ���'+formatFloat('#0.000',bs.FieldByName('NEW_LOWPRICE').AsFloat)+'Ԫ'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
           Exit;
         end;
       end;
    edtTable.Edit;
    edtTable.FieldbyName('POLICY_TYPE').AsInteger := 4;

  end
  else
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('��û���޸����۵��۸��Ȩ��,��͹���Ա��ϵ...'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
end;

function TfrmPosOutOrder.CheckNotChangePrice(GodsID: string): Boolean;
var
  RelationID: string;
  RsGods,Rs: TZQuery;
begin
  result:=False;
  RsGods:=dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if RsGods.Locate('GODS_ID',trim(GodsID),[]) then
  begin
    RelationID:=trim(RsGods.fieldbyName('RELATION_ID').AsString);
  end;
  Rs:=dllGlobal.GetZQueryFromName('CA_RELATIONS');
  if Rs.Locate('RELATION_ID',RelationID,[]) then
  begin
    result:=(trim(Rs.FieldByName('CHANGE_PRICE').AsString)='2');
  end;
end;

procedure TfrmPosOutOrder.btnSaveClick(Sender: TObject);
begin
  inherited;
  case dbState of
  dsBrowse:begin
      NewOrder;
    end;
  else
    begin
      SaveOrder;
//      if dllGlobal.GetChkRight('12400001',2) and (MessageBox(Handle,'�Ƿ�����������۵���',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
         NewOrder
//      else
//         Open(AObj.FieldbyName('SALES_ID').AsString);
    end;
  end;
end;

function TfrmPosOutOrder.GetCostPrice(GODS_ID,BATCH_NO: string): real;
var
  rs:TZQuery;
  bs:TZQuery;
begin
  rs:=TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select AMONEY,AMOUNT from ('+
      'select sum(AMONEY) as AMONEY,sum(AMOUNT) as AMOUNT from STO_STORAGE where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and GODS_ID=:GODS_ID and BATCH_NO=:BATCH_NO ) j where round(AMOUNT,3)<>0';
    rs.ParamByName('TENANT_ID').AsString := token.tenantId;
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    rs.ParamByName('GODS_ID').AsString := GODS_ID;
    rs.ParamByName('BATCH_NO').AsString := BATCH_NO;
    dataFactory.Open(rs);
    if rs.IsEmpty then
       begin
         bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
         if bs.Locate('GODS_ID',GODS_ID,[]) then
            result := bs.FieldbyName('NEW_INPRICE').AsFloat
         else
            Raise Exception.Create('û�ҵ���Ӫ��Ʒ');
       end
    else
       result := rs.Fields[0].AsFloat/rs.Fields[1].AsFloat;
  finally
    rs.Free;
  end;
end;
procedure TfrmPosOutOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs,bs:TZQuery;
  Params:TftParamList;
  str,OutLevel:string;
begin
  rs := TZQuery.Create(nil);
  bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('�������ݼ���û�ҵ���ǰ��Ʒ...');  
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('CarryRule').asInteger := CarryRule;
    Params.ParamByName('Deci').asInteger := Deci;
    Params.ParamByName('CLIENT_ID').asString := edtCLIENT_ID.AsString;
    Params.ParamByName('TENANT_ID').asString := token.tenantId;
    Params.ParamByName('SHOP_ID').asString := token.shopId;
    Params.ParamByName('GODS_ID').asString := GODS_ID;
    if AObj.FieldbyName('PRICE_ID').AsString='' then
    Params.ParamByName('PRICE_ID').asString := '#' else
    Params.ParamByName('PRICE_ID').asString := AObj.FieldbyName('PRICE_ID').AsString;
    Params.ParamByName('UNIT_ID').asString := UNIT_ID;
    dataFactory.Open(rs,'TGetSalesPrice',Params);
    if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
    edtTable.FieldByName('APRICE').AsFloat := rs.FieldbyName('V_APRICE').AsFloat;
    edtTable.FieldbyName('ORG_PRICE').AsFloat := rs.FieldbyName('V_ORG_PRICE').AsFloat;
    edtTable.FieldbyName('COST_PRICE').AsFloat := GetCostPrice(GODS_ID,edtTable.FieldbyName('BATCH_NO').AsString);
    edtTable.FieldByName('POLICY_TYPE').AsInteger := rs.FieldbyName('V_POLICY_TYPE').AsInteger;
    edtTable.FieldByName('HAS_INTEGRAL').AsInteger := rs.FieldbyName('V_HAS_INTEGRAL').AsInteger;
    //���Ƿ񻻹���Ʒ
    if bs.FieldByName('USING_BARTER').AsInteger=3 then
       begin
         edtTable.FieldByName('IS_PRESENT').AsInteger := 2;
         edtTable.FieldByName('BARTER_INTEGRAL').AsInteger := bs.FieldbyName('BARTER_INTEGRAL').AsInteger;
       end
    else
       begin
         edtTable.FieldByName('IS_PRESENT').AsInteger := 0;
         edtTable.FieldByName('BARTER_INTEGRAL').AsInteger := 0;
       end;
    getGodsInfo(edtTable.FieldbyName('GODS_ID').AsString);
  finally
    Params.Free;
    rs.Free;
  end;
end;

function TfrmPosOutOrder.checkPayment:boolean;
var
  fee,allFee,payZero,salMny:currency;
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
  salMny := AObj.FieldbyName('SALE_MNY').AsFloat;

  case InputFlag of
  13,14:
     begin
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
            Raise Exception.Create('���Ѿ�����֧����,����ȷ�����տ���');
          end;
          
       if fee=0 then
          AObj.FieldbyName('PAY_A').AsFloat := (TotalFee-payZero)-AObj.FieldbyName('PAY_D').AsFloat
       else
          AObj.FieldbyName('PAY_A').AsFloat := (TotalFee-payZero)-fee-AObj.FieldbyName('PAY_D').AsFloat;
       if AObj.FieldbyName('CASH_MNY').AsFloat=0 then AObj.FieldbyName('CASH_MNY').AsFloat := AObj.FieldbyName('PAY_A').AsFloat;

       AObj.FieldbyName('PAY_DIBS').AsFloat := AObj.FieldbyName('CASH_MNY').AsFloat-AObj.FieldbyName('PAY_A').AsFloat;
       
       MarqueeStatus.Caption := 'ʵ��:'+formatFloat('#0.00',AObj.FieldbyName('CASH_MNY').AsFloat)+'  ����:'+formatFloat('#0.0',AObj.FieldbyName('PAY_DIBS').AsFloat);

     end;
  end;
  result := true;
end;

procedure TfrmPosOutOrder.DoShowPayment;
var
  fee,payZero,salMny:currency;
  s,payInfo:string;
  w:integer;
begin
  fee :=
    AObj.FieldbyName('PAY_B').AsFloat+
    AObj.FieldbyName('PAY_C').AsFloat+
//    AObj.FieldbyName('PAY_D').AsFloat+
    AObj.FieldbyName('PAY_E').AsFloat+
    AObj.FieldbyName('PAY_F').AsFloat+
    AObj.FieldbyName('PAY_G').AsFloat+
    AObj.FieldbyName('PAY_H').AsFloat+
    AObj.FieldbyName('PAY_I').AsFloat+
    AObj.FieldbyName('PAY_J').AsFloat;
  payZero := AObj.FieldbyName('PAY_ZERO').AsFloat;
  salMny := AObj.FieldbyName('SALE_MNY').AsFloat;
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
  if AObj.FieldbyName('PAY_A').asFloat<>0 then
     begin
       s[1] := '1';
       payment.Caption := '�ֽ��տ�';
       inc(w);
       payInfo := payInfo +'�ֽ�:'+formatFloat('#0.0#',AObj.FieldbyName('PAY_A').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_B').asFloat<>0 then
     begin
       s[2] := '1';
       payment.Caption := getPaymentTitle('B')+'�տ�';
       inc(w);
       payInfo := payInfo +getPaymentTitle('B')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_B').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_C').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('C')+'�տ�';
       inc(w);
       s[3] := '1';
       payInfo := payInfo +getPaymentTitle('C')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_C').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_D').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('D')+'Ƿ��';
       inc(w);
       s[4] := '0';
       payInfo := payInfo +getPaymentTitle('D')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_D').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_E').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('E')+'�տ�';
       inc(w);
       s[5] := '1';
       payInfo := payInfo +getPaymentTitle('E')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_E').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_F').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('F')+'�տ�';
       inc(w);
       s[6] := '1';
       payInfo := payInfo +getPaymentTitle('F')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_F').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_G').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('G')+'�տ�';
       inc(w);
       s[7] := '1';
       payInfo := payInfo +getPaymentTitle('G')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_G').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_H').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('H')+'�տ�';
       inc(w);
       s[8] := '1';
       payInfo := payInfo +getPaymentTitle('H')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_H').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_I').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('I')+'�տ�';
       inc(w);
       s[9] := '1';
       payInfo := payInfo +getPaymentTitle('I')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_I').asFloat)+ ' ';
     end;
  if AObj.FieldbyName('PAY_J').asFloat<>0 then
     begin
       payment.Caption := getPaymentTitle('J')+'�տ�';
       inc(w);
       s[10] := '1';
       payInfo := payInfo +getPaymentTitle('J')+':'+formatFloat('#0.0#',AObj.FieldbyName('PAY_J').asFloat)+ ' ';
     end;
  if w>1 then payment.Caption := '����տ�';
  if totalAmt<>0 then
     begin
        case inputFlag of
        13: MarqueeStatus.Caption := payInfo;
        else
           begin
            if TotalFee<>0 then
               MarqueeStatus.Caption := '�ϼ�:'+formatFloat('#0.00',(TotalFee-payZero))+'  �ۿ�:'+formatFloat('#0.0',(TotalFee-payZero)*100/TotalFee)+'%'
            else
               MarqueeStatus.Caption := '';
           end;
        end;
     end;
end;

procedure TfrmPosOutOrder.SetinputFlag(const Value: integer);
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
      lblInput.Caption := '��������';
      lblHint.Caption := '"1.�������ۡ�2.������Ʒ��3.���ֶһ�" ������������ź� enter ��';
    end;
  6:begin
      FInputFlag := value;
      lblInput.Caption := '��Ա����';
      lblHint.Caption := '������������"��Ա���Ż��ֻ���"�� enter ��';
    end;
  7:begin
      FInputFlag := value;
      lblInput.Caption := '�� �� Ա';
      lblHint.Caption := '�����뵼��ԱԱ����ź� enter ��';
    end;
  11:begin
      FInputFlag := value;
      lblInput.Caption := 'Ӧ�ս��';
      lblHint.Caption := '��ֱ�������������ۿ���(��95��/95)�� enter ��';
    end;
  13:begin
      FInputFlag := value;
      lblInput.Caption := '������';
      lblHint.Caption := '������֧������"'+getPayment+'"';
    end;
  14:begin
      FInputFlag := value;
      lblInput.Caption := 'ʵ���ֽ�';
      lblHint.Caption := '������ʵ���ֽ�� enter ����+��';
    end;
  end;
end;

procedure TfrmPosOutOrder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F5 then
     begin
       inputMode := 1;
       inputFlag := 5;
       edtInput.SetFocus;
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

procedure TfrmPosOutOrder.DoCustId(s:string);
var
  rs,bs:TZQuery;
begin
  inherited;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
      'select UNION_ID,CLIENT_ID,TENANT_ID from PUB_IC_INFO where TENANT_ID in ('+dllGlobal.GetUnionTenantInWhere+') and IC_CARDNO=:IC_CARDNO and IC_STATUS in (''0'',''1'') and COMM not in (''02'',''12'')';
    rs.ParamByName('IC_CARDNO').AsString := s;
    dllGlobal.OpenSqlite(rs);
    if rs.IsEmpty then
       begin
         if token.online and (dllApplication.mode<>'demo') then
            begin
              rs.Close;
              dllGlobal.OpenRemote(rs);
            end;
       end;
    if rs.IsEmpty then
       begin
         rs.Close;
         rs.SQL.Text :=
           'select ''#'' as UNION_ID,CLIENT_ID,TENANT_ID from PUB_CUSTOMER where TENANT_ID='+token.tenantId+' and (MOVE_TELE='''+s+''' or ID_NUMBER='''+s+''') and COMM not in (''02'',''12'')';
         dllGlobal.OpenSqlite(rs);
         if rs.IsEmpty then
            begin
              if token.online and (dllApplication.mode<>'demo') then
                 begin
                   rs.Close;
                   dllGlobal.OpenRemote(rs);
                 end;
            end;
       end;
    if rs.IsEmpty then Raise Exception.Create('������Ļ�Ա������Ч.');
    if rs.RecordCount > 1 then
       begin
         rs.Locate('UNION_ID','#',[]); 
       end;
    if rs.FieldbyName('TENANT_ID').AsString=token.tenantId then
       begin
         AObj.FieldbyName('UNION_ID').AsString := '#';
         bs := dllGlobal.GetZQueryFromName('PUB_CUSTOMER');
         if bs.Locate('CLIENT_ID',rs.FieldbyName('CLIENT_ID').AsString,[]) then
            begin
               AObj.FieldbyName('CLIENT_ID').AsString := bs.FieldbyName('CLIENT_ID').AsString;
               AObj.FieldbyName('CLIENT_ID_TEXT').AsString := bs.FieldbyName('CLIENT_NAME').AsString;
               AObj.FieldbyName('PRICE_ID').AsString := bs.FieldbyName('PRICE_ID').AsString;
            end;
       end
    else
       begin
         if not token.online then Raise Exception.Create('�ѻ�״̬����ʹ�����˿�');  
         AObj.FieldbyName('UNION_ID').AsString := rs.FieldbyName('UNION_ID').AsString;
         AObj.FieldbyName('PRICE_ID').AsString := rs.FieldbyName('UNION_ID').AsString;
         AObj.FieldbyName('CLIENT_ID').AsString := rs.FieldbyName('CLIENT_ID').AsString;
         rs.Close;
         rs.SQL.Text := 'select CUST_NAME from PUB_CUSTOMER where TENANT_ID in ('+dllGlobal.GetUnionTenantInWhere+') and CUST_ID=:CUST_ID';
         rs.ParamByName('CUST_ID').AsString := AObj.FieldbyName('CLIENT_ID').AsString;
         dllGlobal.OpenRemote(rs);
         AObj.FieldbyName('CLIENT_ID_TEXT').AsString := rs.FieldbyName('CUST_NAME').AsString;
       end;
    edtCLIENT_ID.KeyValue := AObj.FieldbyName('CLIENT_ID').AsString;
    edtCLIENT_ID.Text := AObj.FieldbyName('CLIENT_ID_TEXT').AsString;
    CalcPrice;
  finally
    rs.Free;
  end;
end;

procedure TfrmPosOutOrder.DoGuideUser(s:string);
var
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('CA_USERS');
  if rs.Locate('ACCOUNT',s,[]) then
     begin
       AObj.FieldByName('GUIDE_USER').AsString := rs.FieldbyName('USER_ID').AsString;
     end;
end;

procedure TfrmPosOutOrder.DoHangUp;
var
  s:string;
  mm:TMemoryStream;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if dbState = dsEdit then Raise Exception.Create('�޸ĵ���״̬���ܹҵ�...');
  if TotalAmt=0 then Raise Exception.Create('���ܹ�һ�ſյ���...');
  AObj.FieldbyName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  AObj.FieldbyName('SHOP_ID').AsString := token.shopId;
  AObj.FieldByName('SALES_TYPE').AsInteger := 4;
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
    ForceDirectories(ExtractFilePath(ParamStr(0))+'temp\sales');
    mm := TMemoryStream.Create;
    try
      mm.Clear;
      cdsHeader.SaveToStream(mm);
      mm.Position := 0;
      mm.SaveToFile(ExtractFilePath(ParamStr(0))+'temp\sales\H'+s+'.dat');

      mm.Clear;
      edtTable.SaveToStream(mm);
      mm.Position := 0;
      mm.SaveToFile(ExtractFilePath(ParamStr(0))+'temp\sales\D'+s+'.dat');

      mm.Clear;
      edtProperty.SaveToStream(mm);
      mm.Position := 0;
      mm.SaveToFile(ExtractFilePath(ParamStr(0))+'temp\sales\P'+s+'.dat');
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

procedure TfrmPosOutOrder.DoIsPresent(s:string);
begin
  if s='1' then
     PresentToCalc(0)
  else
  if s='2' then
     PresentToCalc(1)
  else
  if s='3' then
     PresentToCalc(2)
  else
     Raise Exception.Create('��֧�ֵ��������ͣ�������1-3֮����������');
end;

procedure TfrmPosOutOrder.DoNewOrder;
begin
  if MessageBox(Handle,'�Ƿ������ǰ�����������Ʒ?','������ʾ..',MB_YESNO+MB_ICONQUESTION)=6 then
     NewOrder;
end;

procedure TfrmPosOutOrder.DoPayZero(s:string);
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
     if abs(mny)>100 then Raise Exception.Create('������ۿ��ʹ�����ȷ���Ƿ�������ȷ')
  else
     if abs(mny)>totalfee then Raise Exception.Create('����Ľ�������ȷ���Ƿ�������ȷ');
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

procedure TfrmPosOutOrder.DoPickUp;
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
  if FindFirst(ExtractFilePath(ParamStr(0))+'temp\sales\*.dat', FileAttrs, sr) = 0 then
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
  if not edtTable.IsEmpty and (MessageBox(Handle,'�Ƿ���յ�ǰ¼���������Ʒ��','������ʾ',MB_YESNO+MB_ICONQUESTION)<>6) then Exit;
  NewOrder;
  mm := TMemoryStream.Create;
  h := TZQuery.Create(nil);
  try
    mm.LoadFromFile(ExtractFilePath(ParamStr(0))+'temp\sales\H'+s);
    H.LoadFromStream(mm);
    AObj.ReadFromDataSet(H,false); 
    mm.LoadFromFile(ExtractFilePath(ParamStr(0))+'temp\sales\D'+s);
    edtTable.LoadFromStream(mm);
    mm.LoadFromFile(ExtractFilePath(ParamStr(0))+'temp\sales\P'+s);
    edtProperty.LoadFromStream(mm);
  finally
    h.Free;
    mm.Free;
  end;
  edtTable.Last;
  RowId := edtTable.FieldbyName('SEQNO').AsInteger;
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\sales\'+s);
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\sales\D'+s);
  DeleteFile(ExtractFilePath(ParamStr(0))+'temp\sales\P'+s);
  Calc;
end;

procedure TfrmPosOutOrder.DoSaveOrder;
begin
  FInputFlag := 1;
  try
    SaveOrder;
  finally
    FInputFlag := 14;
  end;
  NewOrder;
end;

function TfrmPosOutOrder.doShortCut(s: string): boolean;
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

procedure TfrmPosOutOrder.DoPayInput(s:string;flag:string);
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

procedure TfrmPosOutOrder.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if char(Key) = '*' then
     begin
       key := #0;
//       if dllGlobal.GetParameter('USING_PAYMENT')<>'1' then Raise Exception.Create('û�������տʽ�����ܲ����˹���'); 
       inputMode := 1;
       inputFlag := 13;
       DoShowPayment;
       edtInput.selectAll;
       edtInput.SetFocus;
     end;
  if char(Key) = '+' then
     begin
       key := #0;
       if InputFlag=14 then
          begin
            try
              payCashMny(trim(edtInput.Text));
              DoSaveOrder;
              InputFlag := 1;
              edtInput.Text := '';
            finally
              edtInput.selectAll;
              edtInput.SetFocus;
            end;
          end
       else
          begin
            if dllGlobal.GetParameter('USING_PAYMENT')<>'1' then
               begin
                  try
                    inputMode := 1;
                    inputFlag := 14;
                    checkPayment;
                    payCashMny(trim(edtInput.Text));
                    DoSaveOrder;
                  finally
                    InputFlag := 1;
                    edtInput.Text := '';
                    edtInput.selectAll;
                    edtInput.SetFocus;
                  end;
               end
            else
               begin
                  inputMode := 1;
                  inputFlag := 14;
                  checkPayment;
                  edtInput.selectAll;
                  edtInput.SetFocus;
               end;
          end;
     end;
end;

procedure TfrmPosOutOrder.PresentToCalc(Present: integer);
var bs:TZQuery;
begin
  if Present in [0,1] then
     inherited
  else
  if Present in [2] then
     begin
       bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
       if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('��Ӫ��Ʒ��û�ҵ���'+edtTable.FieldbyName('GODS_NAME').AsString+'��');
       //���Ƿ񻻹���Ʒ
       if bs.FieldByName('USING_BARTER').AsInteger in [2,3] then
          begin
            edtTable.Edit;
            edtTable.FieldByName('IS_PRESENT').AsInteger := 2;
            edtTable.FieldByName('BARTER_INTEGRAL').AsInteger := bs.FieldbyName('BARTER_INTEGRAL').AsInteger;
            if bs.FieldByName('USING_BARTER').AsInteger=2 then
               begin
                 edtTable.FieldByName('APRICE').AsFloat := 0;
                 PriceToCalc(0);
               end;
          end
       else
          begin
            MessageBox(Handle,'����Ʒû�����û��ֻ��������ܽ��жһ�','������ʾ...',MB_OK+MB_ICONINFORMATION);
            Exit;
          end;
     end;

end;

procedure TfrmPosOutOrder.CalcPrice;
var r:integer;
begin
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
  r := edtTable.RecNo;
  edtTable.DisableControls;
  try
    edtTable.First;
    while not edtTable.Eof do
      begin
        if (edtTable.FieldbyName('GODS_ID').AsString <> '') and (edtTable.FieldbyName('BOM_ID').AsString = '') and (edtTable.FieldByName('POLICY_TYPE').AsInteger<>4) then
        begin
          InitPrice(edtTable.FieldbyName('GODS_ID').AsString,edtTable.FieldbyName('UNIT_ID').AsString);
          PriceToCalc(edtTable.FieldbyName('APrice').asFloat);
        end;
        edtTable.Next;
      end;
  finally
    if r>0 then edtTable.RecNo := r;
    edtTable.EnableControls;
  end;
  Calc;
end;

procedure TfrmPosOutOrder.PageControlChange(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
  0:begin
       btnNav.Caption := '��ʷ����';
       lblCaption.Caption := '��Ʒ����';
    end;
  1:begin
       btnNav.Caption := '����';
       lblCaption.Caption := '���۵��б�';
    end;
  end;
end;

procedure TfrmPosOutOrder.btnNavClick(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
  0:PageControl.ActivePageIndex := 1;
  1:PageControl.ActivePageIndex := 0;
  end;
  PageControlChange(nil);
end;

procedure TfrmPosOutOrder.SetdbState(const Value: TDataSetState);
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

procedure TfrmPosOutOrder.OpenList;
begin
  cdsList.Close;
  cdsList.SQL.Text :=
    ParseSQL(dataFactory.iDbType,
    'select A.SALES_ID,A.GLIDE_NO,A.SALES_DATE,isnull(B.CLIENT_NAME,''��ͨ�ͻ�'') as CLIENT_NAME,A.SALE_MNY,A.SALE_MNY-A.PAY_ZERO as ACCT_MNY,PAY_A+PAY_B+PAY_C+PAY_E+PAY_F+PAY_G+PAY_H+PAY_I+PAY_J as RECV_MNY,C.USER_NAME as GUIDE_USER_TEXT,A.REMARK '+
    'from SAL_SALESORDER A '+
    'left outer join VIW_CUSTOMER B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
    'left outer join VIW_USERS C on A.TENANT_ID=C.TENANT_ID and A.GUIDE_USER=C.USER_ID '+
    'where A.TENANT_ID=:TENANT_ID and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2 and A.SALES_TYPE=4 '
    );
  if trim(searchTxt)<>'' then
    cdsList.SQL.Text := 'select j.* from ('+cdsList.SQL.Text+') j where CLIENT_NAME like ''%'+trim(searchTxt)+'%'' or REMARK like ''%'+trim(searchTxt)+'%'' or GLIDE_NO like ''%'+trim(searchTxt)+'%''';
  cdsList.SQL.Text := cdsList.SQL.Text + ' order by SALES_DATE,GLIDE_NO';
  cdsList.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
  cdsList.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
  cdsList.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  dataFactory.Open(cdsList); 
end;

procedure TfrmPosOutOrder.dateFlagPropertiesChange(Sender: TObject);
begin
  inherited;
  case dateFlag.ItemIndex of
  0:begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
      //D1.Properties.ReadOnly := false;
      //D2.Properties.ReadOnly := false;
    end;
  1:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYYMM01',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
      //D1.Properties.ReadOnly := false;
      //D2.Properties.ReadOnly := false;
    end;
  2:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYY0101',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
      //D1.Properties.ReadOnly := false;
      //D2.Properties.ReadOnly := false;
    end;
  else
    begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
      //D1.Properties.ReadOnly := false;
      //D2.Properties.ReadOnly := false;
    end;
  end;
end;

procedure TfrmPosOutOrder.FormCreate(Sender: TObject);
begin
  inherited;
  dateFlag.ItemIndex := 1;
end;

procedure TfrmPosOutOrder.btnFindClick(Sender: TObject);
begin
  inherited;
  OpenList;
end;

procedure TfrmPosOutOrder.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('SALES_ID').AsString);
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmPosOutOrder.DBGridEh2DrawColumnCell(Sender: TObject;
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

function TfrmPosOutOrder.getPaymentTitle(pay: string): string;
var
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('PUB_PAYMENT');
  if rs.Locate('CODE_ID',pay,[]) then
     result := rs.FieldbyName('CODE_NAME').AsString
  else
     Raise Exception.Create('��֧�ֵ��տʽ'); 
end;

procedure TfrmPosOutOrder.RzToolButton2Click(Sender: TObject);
begin
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('SALES_ID').AsString);
  EditOrder;
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmPosOutOrder.RzToolButton3Click(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('SALES_ID').AsString);
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);

end;

procedure TfrmPosOutOrder.RzToolButton1Click(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if messageBox(handle,'�Ƿ�ɾ����ǰ���۵���','������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  open(cdsList.FieldbyName('SALES_ID').AsString);
  DeleteOrder;
  cdsList.Delete;
end;

procedure TfrmPosOutOrder.btnNewClick(Sender: TObject);
begin
  if MessageBox(Handle,pchar('�Ƿ�'+btnNew.Caption+'��ǰ���۵���'),'������ʾ..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  NewOrder;
end;

function TfrmPosOutOrder.payCashMny(s:string): boolean;
var
  r:currency;
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

procedure TfrmPosOutOrder.edtInputKeyPress(Sender: TObject; var Key: Char);
begin
  if (InputFlag = 14) and (Key=#13) then
  begin
    try
      payCashMny(trim(edtInput.Text));
      DoSaveOrder;
      InputFlag := 1;
      edtInput.Text := '';
    finally
      Key := #0;
      edtInput.selectAll;
      edtInput.SetFocus;
    end;
  end
  else
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

procedure TfrmPosOutOrder.edtPAY_TOTALPropertiesChange(Sender: TObject);
var
  r:currency;
begin
  inherited;
  if edtPAY_TOTAL.Focused then
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
       payment.Caption := '�ֽ��տ�';
     end;
end;

procedure TfrmPosOutOrder.edtACCT_MNYPropertiesChange(Sender: TObject);
var
  r,fee:currency;
begin
  inherited;
  if edtACCT_MNY.Focused then
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

procedure TfrmPosOutOrder.edtAGIO_RATEPropertiesChange(Sender: TObject);
var
  r,fee:currency;
begin
  inherited;
  if edtAGIO_RATE.Focused then
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

procedure TfrmPosOutOrder.serachTextEnter(Sender: TObject);
begin
  inherited;
  serachText.Text := searchTxt;
  serachText.SelectAll;


end;

procedure TfrmPosOutOrder.serachTextExit(Sender: TObject);
begin
  inherited;
  if searchTxt='' then serachText.Text := serachText.Hint;

end;

procedure TfrmPosOutOrder.edtTableAfterDelete(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;

end;

procedure TfrmPosOutOrder.serachTextChange(Sender: TObject);
begin
  inherited;
  if serachText.Focused then searchTxt := serachText.Text;

end;

procedure TfrmPosOutOrder.helpClick(Sender: TObject);
begin
  //inherited;
  help.Down := not help.Down;
  helpPanel.Visible := help.Down;
end;

procedure TfrmPosOutOrder.getGodsInfo(godsId: string);
var
  rs:TZQuery;
  SourceScale:real;
begin
  CacheFactory.getGodsPngImage(edtTable.FieldbyName('GODS_ID').AsString,godsPhoto.Picture);
  godsPhoto.Top := 0;
  godsPhoto.Left := (godsPhotoBk.Width-godsPhoto.Width) div 2-1;

  godsName.Caption := 'Ʒ��:'+edtTable.FieldbyName('GODS_NAME').AsString;
  godsPrice.Caption := '�۸�:'+edtTable.FieldbyName('APRICE').AsString;
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Exit;
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('CALC_UNITS').AsString then
     begin
      SourceScale := 1;
     end
  else
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('BIG_UNITS').AsString then
     begin
      SourceScale := rs.FieldByName('BIGTO_CALC').asFloat;
     end
  else
  if edtTable.FieldByName('UNIT_ID').AsString=rs.FieldByName('SMALL_UNITS').AsString then
     begin
      SourceScale := rs.FieldByName('SMALLTO_CALC').asFloat;
     end
  else
     begin
      SourceScale := 1;
     end;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select sum(amount) from STO_STORAGE where TENANT_ID=:TENANT_ID and GODS_ID=:GODS_ID';
    rs.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
    rs.ParamByName('GODS_ID').AsString := godsId;
    dataFactory.Open(rs);
    godsAmount.Caption := '���:'+formatFloat('#0.###',rs.Fields[0].asFloat/SourceScale)+''+TdsFind.GetNameByID(dllGlobal.GetZQueryFromName('PUB_MEAUNITS'),'UNIT_ID','UNIT_NAME',edtTable.FieldByName('UNIT_ID').AsString);
  finally
    rs.Free;
  end;
end;

procedure TfrmPosOutOrder.DBGridEh1CellClick(Column: TColumnEh);
begin
  inherited;
  getGodsInfo(edtTable.FieldbyName('GODS_ID').AsString);

end;

procedure TfrmPosOutOrder.cdsListBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav.Visible := false;
end;

procedure TfrmPosOutOrder.serachTextKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     OpenList;

end;

procedure TfrmPosOutOrder.edtCLIENT_IDSaveValue(Sender: TObject);
var
  bs:TZQuery;
begin
  inherited;
  bs := dllGlobal.GetZQueryFromName('PUB_CUSTOMER');
  if bs.Locate('CLIENT_ID',edtCLIENT_ID.AsString,[]) then
     begin
        AObj.FieldbyName('CLIENT_ID').AsString := bs.FieldbyName('CLIENT_ID').AsString;
        AObj.FieldbyName('CLIENT_ID_TEXT').AsString := bs.FieldbyName('CLIENT_NAME').AsString;
        AObj.FieldbyName('PRICE_ID').AsString := bs.FieldbyName('PRICE_ID').AsString;
     end;
end;

procedure TfrmPosOutOrder.DBGridPrint;
begin
  PrintDBGridEh1.DBGridEh := DBGridEh2;
  PrintDBGridEh1.PageHeader.CenterText.Text := '���۵��б�';
  DBGridEh1.DBGridTitle := '���۵��б�';
  DBGridEh1.DBGridHeader.Text := '����:'+formatDatetime('YYYY-MM-DD',D1.Date)+'��'+formatDatetime('YYYY-MM-DD',D2.Date);
  DBGridEh1.DBGridFooter.Text := ' '+#13+' ����Ա:'+token.UserName+'  ����ʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.AfterGridText.Text := #13+'��ӡ��:'+token.UserName+'  ��ӡʱ��:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', '����:'+formatDatetime('YYYY-MM-DD',D1.Date)+'��'+formatDatetime('YYYY-MM-DD',D2.Date)]);
end;

procedure TfrmPosOutOrder.btnPreviewClick(Sender: TObject);
begin
  inherited;
  DBGridPrint;
  TfrmDBGridPreview.Preview(self,PrintDBGridEh1);

end;

procedure TfrmPosOutOrder.btnPrintClick(Sender: TObject);
begin
  inherited;
  DBGridPrint;
  TfrmDBGridPreview.Print(self,PrintDBGridEh1);

end;

initialization
  RegisterClass(TfrmPosOutOrder);
finalization
  UnRegisterClass(TfrmPosOutOrder);
end.
