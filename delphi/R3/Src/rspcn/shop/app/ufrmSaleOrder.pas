unit ufrmSaleOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmOrderForm, RzButton, RzPanel, cxTextEdit, cxDropDownEdit,
  cxCalendar, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, StdCtrls, RzLabel, ExtCtrls, RzBmpBtn,
  RzBorder, RzTabs, RzStatus, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZBase, Math, Menus;

type
  TfrmSaleOrder = class(TfrmOrderForm)
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn3: TRzBitBtn;
    RzBitBtn4: TRzBitBtn;
    RzBitBtn6: TRzBitBtn;
    TabSheet2: TRzTabSheet;
    edtCLIENT_ID: TzrComboBoxList;
    edtREMARK: TcxTextEdit;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    edtSALES_DATE: TcxDateEdit;
    RzPanel8: TRzPanel;
    edtGUIDE_USER: TzrComboBoxList;
    RzPanel9: TRzPanel;
    edtACCT_MNY: TcxTextEdit;
    RzPanel10: TRzPanel;
    edtAGIO_RATE: TcxTextEdit;
    payment: TRzPanel;
    edtPAY_TOTAL: TcxTextEdit;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    cdsICGlide: TZQuery;
    RzLabel5: TRzLabel;
    Label1: TLabel;
    h2: TLabel;
    h6: TLabel;
    h5: TLabel;
    h11: TLabel;
    h12: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label11: TLabel;
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns8UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure RzBitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    AObj:TRecord_;
    //默认发票类型
    DefInvFlag:integer;
    //普通税率
    RtlRate2:Currency;
    //增值税率
    RtlRate3:Currency;
    //结算金额
    TotalFee:Currency;
    //结算数量
    TotalAmt:Currency;
    //换购积分
    TotalBarter:integer;

    agioLower:Currency;
    //进位法则
    CarryRule:integer;
    //保留小数位
    Deci:integer;

    function  CheckSale_Limit: Boolean;
    procedure checkPayment;
    procedure DoPayment;
    procedure Calc; //2011.06.09判断是否限量
    function  CheckNotChangePrice(GodsID: string): Boolean; //2011.06.08返回是否企业定价
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    function GetCostPrice(GODS_ID, BATCH_NO: string): real;
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
  end;

var
  frmSaleOrder: TfrmSaleOrder;

implementation
uses utokenFactory,udllDsUtil,udllShopUtil,udllFnUtil, udllGlobal, udataFactory;
{$R *.dfm}

{ TfrmSaleOrder }

procedure TfrmSaleOrder.Calc;
var
  r:integer;
  mny:Currency;
  ago:Currency;
  prf:Currency;
  t:integer;
  amt:Currency;
  integral:integer;
  ps:TZQuery;
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
    AObj.FieldbyName('PAY_ZERO').asFloat := 0;
    AObj.FieldbyName('CASH_MNY').asFloat := TotalFee;
    AObj.FieldbyName('PAY_DIBS').asFloat := 0;

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
    edtACCT_MNY.Text := formatFloat('#0.00',TotalFee);
    edtAGIO_RATE.Text := '100.0';
    DoPayment;
    AObj.FieldbyName('BARTER_INTEGRAL').AsInteger := TotalBarter;
  end;
end;

procedure TfrmSaleOrder.CancelOrder;
begin
  if dbState = dsBrowse then Exit;
  if dbState = dsInsert then
     NewOrder
  else
     Open(AObj.FieldbyName('SALES_ID').AsString);
end;

function TfrmSaleOrder.CheckSale_Limit: Boolean;
var
  CurIdx: integer;
  GodsID, RelationID: string;
  Singe_Litmit,All_Litmit: Real;  //单品限量，本单限量
  RsGods,RsRelation,GodsQry,RelQry: TZQuery;
begin
  result:=False;
  try
    GodsQry:=TZQuery.Create(nil);  //本单商品汇总
    GodsQry.Close;
    GodsQry.FieldDefs.Add('GODS_ID',ftstring,36,true);
    GodsQry.FieldDefs.Add('GODS_NAME',ftstring,50,true);
    GodsQry.FieldDefs.Add('CalcSum',ftFloat,0,true);
    GodsQry.CreateDataSet;
    RelQry:=TZQuery.Create(nil);   //本单供应链汇总
    RelQry.Close;
    RelQry.FieldDefs.Add('RELATION_ID',ftInteger,0,true);
    RelQry.FieldDefs.Add('RELATION_NAME',ftstring,50,true);
    RelQry.FieldDefs.Add('CalcSum',ftFloat,0,true);
    RelQry.CreateDataSet;
    RsGods:=dllGlobal.GetZQueryFromName('PUB_GOODSINFO'); //商品档案
    RsRelation:=dllGlobal.GetZQueryFromName('CA_RELATIONS'); //供应链
    //开始循环[累计出本单单品和供应链汇总数据]：
    CurIdx:=edtTable.RecNo;  //保存当前序号
    edtTable.First;
    while not edtTable.Eof do
    begin
      GodsID:=trim(edtTable.fieldbyName('GODS_ID').AsString);
      //单项目累计
      if GodsQry.Locate('GODS_ID',GodsID,[]) then //定位则累计数量
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
        //单项目累计
        if RelQry.Locate('RELATION_ID',RelationID,[]) then //定位则累计数量
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

    //判断单品是否超过
    GodsQry.First;
    while not GodsQry.Eof do
    begin
      GodsID:=trim(GodsQry.fieldbyName('GODS_ID').AsString);
      if RsGods.Locate('GODS_ID',GodsID,[]) then
      begin
        RelationID:=trim(RsGods.fieldbyName('RELATION_ID').AsString);
        if RsRelation.Locate('RELATION_ID',RelationID,[]) then
        begin
          Singe_Litmit:=RsRelation.FieldByName('SINGLE_LIMIT').AsFloat; //单品限量
          if (Singe_Litmit>0) and (GodsQry.FieldByName('CalcSum').AsFloat>Singe_Litmit) then
            Raise Exception.Create('商品〖'+GodsQry.fieldbyName('GODS_NAME').AsString+'〗数量'+FloattoStr(GodsQry.FieldByName('CalcSum').AsFloat)+'超过限量值'+FloattoStr(Singe_Litmit)+'！');
        end;
      end;
      GodsQry.Next;
    end;

    //判断供应链本单限量：
    RelQry.First;
    while not RelQry.Eof do
    begin
      RelationID:=trim(RelQry.fieldbyName('RELATION_ID').AsString);
      if RsRelation.Locate('RELATION_ID',RelationID,[]) then
      begin
        All_Litmit:=RsRelation.FieldByName('SALE_LIMIT').AsFloat; //本单限量
        if (All_Litmit>0) and (RelQry.FieldByName('CalcSum').AsFloat>All_Litmit) then
          Raise Exception.Create('供应链〖'+RelQry.FieldByName('RELATION_NAME').AsString+'〗本单总量'+FloattoStr(RelQry.FieldByName('CalcSum').AsFloat)+' 超过限量值'+FloattoStr(All_Litmit)+'！');
      end;
      RelQry.Next;
    end;
  finally
    edtTable.RecNo:=CurIdx;
    GodsQry.Free;
    RelQry.Free;
  end;
end;

constructor TfrmSaleOrder.Create(AOwner: TComponent);
begin
  inherited;
  AObj := TRecord_.Create;
  //进位法则
  CarryRule := StrtoIntDef(dllGlobal.GetParameter('CARRYRULE'),0);
  //保留小数位
  Deci := StrtoIntDef(dllGlobal.GetParameter('POSDIGHT'),2);
end;

procedure TfrmSaleOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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

destructor TfrmSaleOrder.Destroy;
begin
  AObj.Free;
  inherited;
end;

procedure TfrmSaleOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  dbState := dsEdit;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus
  else
  if edtCLIENT_ID.CanFocus and Visible then
     edtCLIENT_ID.SetFocus;
end;

procedure TfrmSaleOrder.NewOrder;
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
  
  edtSALES_DATE.Date := dllGlobal.SysDate;

  AObj.FieldbyName('PLAN_DATE').AsString := formatdatetime('YYYYMMDD',date());

  edtGUIDE_USER.KeyValue := token.userId;
  edtGUIDE_USER.Text := token.username;

  AObj.FieldbyName('INVOICE_FLAG').AsInteger := DefInvFlag;
  case DefInvFlag of
  1: AObj.FieldbyName('TAX_TATE').AsFloat := 0;
  2: AObj.FieldbyName('TAX_TATE').AsFloat := RtlRate2;
  3: AObj.FieldbyName('TAX_TATE').AsFloat := RtlRate3;
  end;
  InitRecord;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus
  else
  if edtCLIENT_ID.CanFocus and Visible then
     edtCLIENT_ID.SetFocus;
end;

procedure TfrmSaleOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    Params.ParamByName('SALES_ID').asString := id;
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
  finally
    Params.Free;
  end;
end;

procedure TfrmSaleOrder.SaveOrder;
var
  Printed:boolean;
  acctMny:real;
begin
  if dbState = dsBrowse then Exit;
  if dllGlobal.GetParameter('GUIDE_USER')='0' then
  begin
     if edtGUIDE_USER.AsString='' then
        Raise Exception.Create('请输入业务员再保存！');
  end;

  if edtSALES_DATE.EditValue = null then Raise Exception.Create('销售日期不能为空');
  try
    acctMny := StrtoFloat(edtACCT_MNY.Text);
  except
    Raise Exception.Create('结算金额输入有误，请正确输入保存'); 
  end;
  //2011.06.09 Add 判断是否限量
  CheckSale_Limit;

  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  WriteToObject(AObj,self);

  AObj.FieldByName('SALES_TYPE').AsInteger := 4;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := token.userId;
  AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
  AObj.FieldByName('CHK_USER').AsString := token.userId;
  AObj.FieldByName('LOCUS_STATUS').AsString := '3';
  AObj.FieldByName('PAY_ZERO').AsFloat := TotalFee-acctMny;

  checkPayment;

  if (AObj.FieldByName('BARTER_INTEGRAL').AsFloat<>0) and (AObj.FieldByName('CLIENT_ID').AsString='') then Raise Exception.Create('不是会员消费，不能有积分兑换对商品.');

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
  Open(AObj.FieldbyName('SALES_ID').AsString);
  dbState := dsBrowse;
end;

procedure TfrmSaleOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;

end;

procedure TfrmSaleOrder.showForm;
begin
  inherited;
  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CUSTOMER');
  edtGUIDE_USER.DataSet := dllGlobal.GetZQueryFromName('CA_USERS');
  NewOrder;
end;

procedure TfrmSaleOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  fndGODS_ID.Text := edtTable.FieldbyName('GODS_NAME').AsString;
  fndGODS_ID.KeyValue := edtTable.FieldbyName('GODS_ID').AsString;
  fndGODS_ID.SaveStatus;

end;

procedure TfrmSaleOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;
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

procedure TfrmSaleOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r,op:Currency;
  allow :boolean;
  bs:TZQuery;
begin
  //2011.06.08 Add 供应链限制改价：
  if CheckNotChangePrice(edtTable.fieldbyName('GODS_ID').AsString) then
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('商品〖'+edtTable.FieldByName('GODS_NAME').AsString+'〗统一定价，不允许修改单价！'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    Exit;
  end;

  //调价权限(调价权限)
  if not dllGlobal.GetChkRight('12400001',5) then
     begin
{       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',5,Params.UserID);
            if not allow then Raise Exception.Create('你输入的用户没有调价权限...');
          end
       else                  }
          allow := false;
     end else allow := true;

  if allow then
  begin
    try
      if Text='' then
         r := 0
      else
         r := StrtoFloat(Text);
    except
      on E:Exception do
         begin
           Text := TColumnEh(Sender).Field.AsString;
           Value := TColumnEh(Sender).Field.asFloat;
           MessageBox(Handle,pchar('输入无效数值型,错误：'+E.Message),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
           Exit;
         end;
    end;
    if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
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
         MessageBox(Handle,pchar('调价最低不能低于'+formatFloat('#0.000',agioLower)+'%折'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
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
           MessageBox(Handle,pchar('调价最低不能低于'+formatFloat('#0.000',bs.FieldByName('NEW_LOWPRICE').AsFloat)+'元'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
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
    MessageBox(Handle,pchar('你没有修改销售单价格的权限,请和管理员联系...'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
end;

procedure TfrmSaleOrder.DBGridEh1Columns8UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r,op:Currency;
  allow :boolean;
  bs:TZQuery;
begin
  //2011.06.08 Add 供应链限制改价：
  if CheckNotChangePrice(edtTable.fieldbyName('GODS_ID').AsString) then
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('商品〖'+edtTable.FieldByName('GODS_NAME').AsString+'〗统一定价，不允许修改折扣！'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    Exit;
  end;

  if not dllGlobal.GetChkRight('12400001',5) then
     begin
      { if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',5,Params.UserID);
            if not allow then Raise Exception.Create('你输入的用户没有调价权限...');
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
      if abs(r)>100 then Raise Exception.Create('输入的数值过大，无效');
      edtTable.Edit;
    except
      on E:Exception do
         begin
            Text := TColumnEh(Sender).Field.AsString;
            Value := TColumnEh(Sender).Field.asFloat;
            MessageBox(Handle,pchar('输入无效折扣率,错误：'+E.Message),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
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
         MessageBox(Handle,pchar('调价最低不能低于'+formatFloat('#0.000',agioLower)+'%折'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
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
           MessageBox(Handle,pchar('调价最低不能低于'+formatFloat('#0.000',bs.FieldByName('NEW_LOWPRICE').AsFloat)+'元'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
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
    MessageBox(Handle,pchar('你没有修改销售单价格的权限,请和管理员联系...'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
end;

function TfrmSaleOrder.CheckNotChangePrice(GodsID: string): Boolean;
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

procedure TfrmSaleOrder.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  SaveOrder;
  if dllGlobal.GetChkRight('12400001',2) and (MessageBox(Handle,'是否继续新增销售单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
     NewOrder;
end;

function TfrmSaleOrder.GetCostPrice(GODS_ID,BATCH_NO: string): real;
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
            Raise Exception.Create('没找到经营商品');
       end
    else
       result := rs.Fields[0].AsFloat/rs.Fields[1].AsFloat;
  finally
    rs.Free;
  end;
end;
procedure TfrmSaleOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs,bs:TZQuery;
  Params:TftParamList;
  str,OutLevel:string;
begin
  rs := TZQuery.Create(nil);
  bs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('缓冲数据集中没找到当前商品...');  
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
    //看是否换购商品
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
  finally
    Params.Free;
    rs.Free;
  end;
end;

procedure TfrmSaleOrder.checkPayment;
var
  fee,payZero,salMny:currency;
begin
  fee :=
    AObj.FieldbyName('PAY_A').AsFloat+
    AObj.FieldbyName('PAY_B').AsFloat+
    AObj.FieldbyName('PAY_C').AsFloat+
    AObj.FieldbyName('PAY_D').AsFloat+
    AObj.FieldbyName('PAY_E').AsFloat+
    AObj.FieldbyName('PAY_F').AsFloat+
    AObj.FieldbyName('PAY_G').AsFloat+
    AObj.FieldbyName('PAY_H').AsFloat+
    AObj.FieldbyName('PAY_I').AsFloat+
    AObj.FieldbyName('PAY_J').AsFloat;
  payZero := AObj.FieldbyName('PAY_ZERO').AsFloat;
  salMny := AObj.FieldbyName('SAL_MNY').AsFloat;
  if fee<>(TotalFee-payZero) then Raise Exception.Create('支付金额与结算金额相同，请正确输入支付金额');
end;

procedure TfrmSaleOrder.DoPayment;
var
  fee,payZero,salMny:currency;
begin
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
  payZero := AObj.FieldbyName('PAY_ZERO').AsFloat;
  salMny := AObj.FieldbyName('SALE_MNY').AsFloat;
  if fee<>0 then
     edtPAY_TOTAL.Text := formatFloat('#0.00',fee)
  else
     edtPAY_TOTAL.Text := formatFloat('#0.00',(TotalFee-payZero));
end;

initialization
  RegisterClass(TfrmSaleOrder);
finalization
  UnRegisterClass(TfrmSaleOrder);
end.
