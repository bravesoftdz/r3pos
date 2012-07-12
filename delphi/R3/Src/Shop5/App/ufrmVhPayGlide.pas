unit ufrmVhPayGlide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGridEh, ObjCommon,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, ZBase;

type
  TVoucherCheckInfoEvent = procedure(_Aobj:TRecord_) of object;
  TfrmVhPayGlide = class(TframeDialogForm)
    CdsVhPay: TZQuery;
    Btn_Close: TRzBitBtn;
    Btn_Save: TRzBitBtn;
    RzPanel1: TRzPanel;
    lblInput: TLabel;
    edtInput: TcxTextEdit;
    RzPanel3: TRzPanel;
    RzPageControl1: TRzPageControl;
    TabSheet2: TRzTabSheet;
    TabSheet3: TRzTabSheet;
    labMNY: TLabel;
    labPRC: TLabel;
    labAMOUNT: TLabel;
    labNO: TLabel;
    labClientId: TLabel;
    LabPRC1: TLabel;
    LabGlideNo: TLabel;
    LabAmount1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
  private
    { Private declarations }
    SumMoney:Currency;
    FFromId: string;
    FPayMny: Currency;
    FResultVoucherTtl: Currency;
    FResultAmount: Integer;
    FClientId: String;
    FShopId: String;
    FDeptId: String;
    FPayUser: String;
    FOnVoucherCheckInfo: TVoucherCheckInfoEvent;
    procedure SetFromId(const Value: string);
    procedure SetPayMny(const Value: Currency);
    procedure SetResultAmount(const Value: Integer);
    procedure SetResultVoucherTtl(const Value: Currency);
    procedure SetClientId(const Value: String);
    procedure SetDeptId(const Value: String);
    procedure SetPayUser(const Value: String);
    procedure SetShopId(const Value: String);
    procedure AnalysisBarcode;
    procedure AnalysisSalesBarcode;
    procedure SetOnVoucherCheckInfo(const Value: TVoucherCheckInfoEvent);
  public
    { Public declarations }
    procedure Open;
    procedure Save;
    class function ScanBarcode(Owner:TForm;vFromId:String='';vShopId:String='';vDeptId:String='';vClientId:String='';vPayMny:Currency=0):Boolean;
    class function ScanSalesBarcode(Owner:TForm;vFromId:String='';CheckInfo:TVoucherCheckInfoEvent=nil):Boolean;
    property FromId:string read FFromId write SetFromId;
    property PayMny:Currency read FPayMny write SetPayMny;
    property ShopId:String read FShopId write SetShopId;
    property DeptId:String read FDeptId write SetDeptId;
    property ClientId:String read FClientId write SetClientId;
    property PayUser:String read FPayUser write SetPayUser;
    property ResultAmount:Integer read FResultAmount write SetResultAmount;
    property ResultVoucherTtl:Currency read FResultVoucherTtl write SetResultVoucherTtl;
    property OnVoucherCheckInfo:TVoucherCheckInfoEvent read FOnVoucherCheckInfo write SetOnVoucherCheckInfo;
  end;

implementation
uses uGlobal, uFnUtil, uDsUtil, uShopGlobal, ufrmBasic;
{$R *.dfm}

{ TfrmVhPayGlide }

procedure TfrmVhPayGlide.SetClientId(const Value: String);
begin
  FClientId := Value;
end;

procedure TfrmVhPayGlide.SetDeptId(const Value: String);
begin
  FDeptId := Value;
end;

procedure TfrmVhPayGlide.SetFromId(const Value: string);
begin
  FFromId := Value;
end;

procedure TfrmVhPayGlide.SetPayMny(const Value: Currency);
begin
  FPayMny := Value;
  labMNY.Caption := '剩余金额:'+FloatToStr(Value);
end;

procedure TfrmVhPayGlide.SetPayUser(const Value: String);
begin
  FPayUser := Value;
end;

procedure TfrmVhPayGlide.SetResultAmount(const Value: Integer);
begin
  FResultAmount := Value;
  if RzPageControl1.ActivePageIndex = 0 then
     labAMOUNT.Caption := '礼券数:'+IntToStr(Value)
  else
     LabAmount1.Caption := '礼券数:'+IntToStr(Value);
end;

procedure TfrmVhPayGlide.SetResultVoucherTtl(const Value: Currency);
begin
  FResultVoucherTtl := Value;
end;

procedure TfrmVhPayGlide.SetShopId(const Value: String);
begin
  FShopId := Value;
end;

procedure TfrmVhPayGlide.FormCreate(Sender: TObject);
begin
  inherited;
  PayMny := 0;
  ResultAmount := 0;
  ResultVoucherTtl := 0;
end;

class function TfrmVhPayGlide.ScanBarcode(Owner: TForm; vFromId, vShopId,
  vDeptId, vClientId: String; vPayMny: Currency): Boolean;
begin
  with TfrmVhPayGlide.Create(Owner) do
  begin
    try
      FromId := vFromId;
      ShopId := vShopId;
      DeptId := vDeptId;
      ClientId := vClientId;
      PayMny := vPayMny;
      RzPageControl1.ActivePageIndex := 0;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure TfrmVhPayGlide.Open;
begin
  Factor.Open(CdsVhPay,'TVhPayGlide');
end;

procedure TfrmVhPayGlide.Save;
begin
  CdsVhPay.First;
  while not CdsVhPay.Eof do
  begin
    FResultVoucherTtl := FResultVoucherTtl + CdsVhPay.FieldByName('VHPAY_MNY').AsFloat;
    CdsVhPay.Next;
  end;
  try
    Factor.UpdateBatch(CdsVhPay,'TVhPayGlide');
  except
    Raise;
  end;
  ModalResult := mrOk;
end;

procedure TfrmVhPayGlide.FormShow(Sender: TObject);
begin
  inherited;
  TabSheet2.TabVisible := False;
  TabSheet3.TabVisible := False;
  Open;
  edtInput.SetFocus;
end;

procedure TfrmVhPayGlide.edtInputKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
     try
       if RzPageControl1.ActivePageIndex = 0 then
          AnalysisBarcode
       else
          AnalysisSalesBarcode;
     finally
       Key := #0;
     end;
  end;
end;

procedure TfrmVhPayGlide.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrIgnore;
end;

procedure TfrmVhPayGlide.Btn_SaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmVhPayGlide.AnalysisBarcode;
var rs:TZQuery;
    BarCode:String;
begin
   BarCode := Trim(edtInput.Text);
   if BarCode = '' then Exit;
   rs := TZQuery.Create(nil);
   try
     if PayMny <= 0 then Raise Exception.Create(labMNY.Caption+',已完毕!');
     if CdsVhPay.Locate('BARCODE',BarCode,[]) then Raise Exception.Create('"'+BarCode+'"礼券已使用,请确认!');
     rs.SQL.Text := 'select BARCODE,VOUCHER_PRC,VOUCHER_STATUS,VOUCHER_TYPE,CLIENT_ID from SAL_VOUCHERDATA where TENANT_ID=:TENANT_ID and BARCODE=:BARCODE ';
     rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     rs.Params.ParamByName('BARCODE').AsString := BarCode;
     Factor.Open(rs);
     if rs.IsEmpty then Raise Exception.Create('"'+Trim(edtInput.Text)+'"礼券不存在,请核对真实!');
     if rs.FieldByName('VOUCHER_STATUS').AsString = '4' then Raise Exception.Create('"'+Trim(edtInput.Text)+'"礼券已经结算,请核对真实!');
     if (rs.FieldByName('VOUCHER_TYPE').AsString = '3') and (rs.FieldByName('CLIENT_ID').AsString <> ClientId) then Raise Exception.Create('"'+Trim(edtInput.Text)+'"为记名礼券,只能本人使用');
     CdsVhPay.Append;
     CdsVhPay.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     CdsVhPay.FieldByName('VHPAY_ID').AsString := TSequence.NewId;
     CdsVhPay.FieldByName('VHPAY_DATE').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',Global.SysDate));
     CdsVhPay.FieldByName('VOUCHER_PRC').AsInteger := rs.FieldByName('VOUCHER_PRC').AsInteger;
     labPRC.Caption := '礼券面值:'+rs.FieldByName('VOUCHER_PRC').AsString;
     labNO.Caption := '礼券号:'+BarCode;
     CdsVhPay.FieldByName('BARCODE').AsString := rs.FieldByName('BARCODE').AsString;
     CdsVhPay.FieldByName('VOUCHER_TYPE').AsString := rs.FieldByName('VOUCHER_TYPE').AsString;
     if ClientId = '' then
        CdsVhPay.FieldByName('CLIENT_ID').AsString := '#'
     else
        CdsVhPay.FieldByName('CLIENT_ID').AsString := ClientId;
     if ShopId = '' then
        CdsVhPay.FieldByName('SHOP_ID').AsString := Global.SHOP_ID
     else
        CdsVhPay.FieldByName('SHOP_ID').AsString := ShopId;
     if DeptId = '' then
        CdsVhPay.FieldByName('DEPT_ID').AsString := TZQuery(ShopGlobal.GetDeptInfo).FieldByName('DEPT_ID').AsString
     else
        CdsVhPay.FieldByName('DEPT_ID').AsString := DeptId;
     if PayUser = '' then
        CdsVhPay.FieldByName('VHPAY_USER').AsString := Global.UserID
     else
        CdsVhPay.FieldByName('VHPAY_USER').AsString := PayUser;
     if PayMny > rs.FieldByName('VOUCHER_PRC').AsFloat then
        CdsVhPay.FieldByName('VHPAY_MNY').AsFloat := rs.FieldByName('VOUCHER_PRC').AsInteger
     else
        CdsVhPay.FieldByName('VHPAY_MNY').AsFloat := PayMny;
     PayMny := PayMny - rs.FieldByName('VOUCHER_PRC').AsInteger;
     CdsVhPay.FieldByName('AGIO_MONEY').AsFloat := CdsVhPay.FieldByName('VOUCHER_PRC').AsFloat - CdsVhPay.FieldByName('VHPAY_MNY').AsFloat;
     if CdsVhPay.FieldByName('VOUCHER_PRC').AsFloat = 0 then
        CdsVhPay.FieldByName('AGIO_RATE').AsFloat := 0
     else
        CdsVhPay.FieldByName('AGIO_RATE').AsFloat := CdsVhPay.FieldByName('VHPAY_MNY').AsFloat/CdsVhPay.FieldByName('VOUCHER_PRC').AsFloat;
     CdsVhPay.FieldByName('FROM_ID').AsString := FromId;
     CdsVhPay.FieldByName('CREA_USER').AsString := Global.UserID;
     CdsVhPay.FieldByName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
     CdsVhPay.Post;
     ResultAmount := ResultAmount + 1;
   finally
     edtInput.Text := '';
     edtInput.SetFocus;
     rs.Free;
   end;

end;

procedure TfrmVhPayGlide.AnalysisSalesBarcode;
var rs,rs1:TZQuery;
    BarCode:String;
    sId:String;
    Aobj_1:TRecord_;
begin
   BarCode := Trim(edtInput.Text);
   if BarCode = '' then Exit;
   //if (sId <> '') and (Copy(BarCode,1,36)<>sId) then Raise Exception.Create('本张"提货券"与前张"提货券"出于不同订单,请确认!');
   rs := TZQuery.Create(nil);
   rs1 := TZQuery.Create(nil);
   Aobj_1 := TRecord_.Create;
   try
     if CdsVhPay.Locate('BARCODE',BarCode,[]) then Raise Exception.Create('"'+BarCode+'"提货券已使用,请确认!');

     rs.SQL.Text :=
     ' select A.INDE_ID,A.GLIDE_NO,A.CLIENT_ID,B.CLIENT_NAME,A.DEPT_ID,C.DEPT_NAME,A.SHOP_ID,D.SHOP_NAME,A.ADVA_MNY,'+
     ' E.BARCODE,E.VOUCHER_PRC,E.VOUCHER_STATUS,E.VOUCHER_TYPE,E.CLIENT_ID as CLIENT_ID_1 '+
     ' from SAL_INDENTORDER A inner join SAL_VOUCHERDATA E on A.TENANT_ID=E.TENANT_ID and A.INDE_ID=E.VOUCHER_ID '+
     ' left join VIW_CUSTOMER B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
     ' left join CA_DEPT_INFO C on A.TENANT_ID=C.TENANT_ID and A.DEPT_ID=C.DEPT_ID '+
     ' left join CA_SHOP_INFO D on A.TENANT_ID=D.TENANT_ID and A.SHOP_ID=D.SHOP_ID '+
     ' where E.TENANT_ID=:TENANT_ID and E.BARCODE=:BARCODE ';
     rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     rs.Params.ParamByName('BARCODE').AsString := BarCode;
     Factor.Open(rs);
     if rs.IsEmpty then Raise Exception.Create('"'+Trim(edtInput.Text)+'"礼券不存在,请核对真实!');
     if rs.FieldByName('VOUCHER_STATUS').AsString = '4' then Raise Exception.Create('"'+Trim(edtInput.Text)+'"礼券已经结算,请核对真实!');

     if not rs.IsEmpty then
     begin
        Aobj_1.ReadFromDataSet(rs);
        OnVoucherCheckInfo(Aobj_1);
     end;

     CdsVhPay.Append;
     CdsVhPay.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     CdsVhPay.FieldByName('VHPAY_ID').AsString := TSequence.NewId;
     CdsVhPay.FieldByName('VHPAY_DATE').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',Global.SysDate));
     CdsVhPay.FieldByName('VOUCHER_PRC').AsInteger := rs.FieldByName('VOUCHER_PRC').AsInteger;
     CdsVhPay.FieldByName('BARCODE').AsString := BarCode;
     CdsVhPay.FieldByName('VOUCHER_TYPE').AsString := rs.FieldByName('VOUCHER_TYPE').AsString;
     CdsVhPay.FieldByName('CLIENT_ID').AsString := rs.FieldByName('CLIENT_ID_1').AsString;
     CdsVhPay.FieldByName('SHOP_ID').AsString := rs.FieldByName('SHOP_ID').AsString;
     CdsVhPay.FieldByName('DEPT_ID').AsString := rs.FieldByName('DEPT_ID').AsString;
     CdsVhPay.FieldByName('VHPAY_USER').AsString := Global.UserID;
     CdsVhPay.FieldByName('VHPAY_MNY').AsFloat := rs.FieldByName('VOUCHER_PRC').AsFloat;
     SumMoney := SumMoney + rs.FieldByName('VOUCHER_PRC').AsFloat;

     CdsVhPay.FieldByName('AGIO_MONEY').AsFloat := CdsVhPay.FieldByName('VOUCHER_PRC').AsFloat - CdsVhPay.FieldByName('VHPAY_MNY').AsFloat;
     if CdsVhPay.FieldByName('VOUCHER_PRC').AsFloat = 0 then
        CdsVhPay.FieldByName('AGIO_RATE').AsFloat := 0
     else
        CdsVhPay.FieldByName('AGIO_RATE').AsFloat := CdsVhPay.FieldByName('VHPAY_MNY').AsFloat/CdsVhPay.FieldByName('VOUCHER_PRC').AsFloat;
     CdsVhPay.FieldByName('FROM_ID').AsString := FromId;
     CdsVhPay.FieldByName('CREA_USER').AsString := Global.UserID;
     CdsVhPay.FieldByName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
     CdsVhPay.Post;
     
     LabPRC1.Caption := '礼券面值:'+rs.FieldByName('VOUCHER_PRC').AsString;
     labClientId.Caption := '客户名称:'+rs.FieldByName('CLIENT_NAME').AsString;
     LabGlideNo.Caption := '订单号:'+rs.FieldByName('GLIDE_NO').AsString;
     ResultAmount := ResultAmount + 1;
   finally
     edtInput.Text := '';
     edtInput.SetFocus;
     rs.Free;
     rs1.Free;
     Aobj_1.Free;
   end;
end;

class function TfrmVhPayGlide.ScanSalesBarcode(Owner: TForm;
  vFromId: String;CheckInfo:TVoucherCheckInfoEvent): Boolean;
begin
  with TfrmVhPayGlide.Create(Owner) do
  begin
    Try
      FromId := vFromId;
      OnVoucherCheckInfo := CheckInfo;
      RzPageControl1.ActivePageIndex := 1;
      if ShowModal = mrOk then
         Result := True
      else
         Result := False;
    finally
      Free;
    end;
  end;
end;

procedure TfrmVhPayGlide.SetOnVoucherCheckInfo(
  const Value: TVoucherCheckInfoEvent);
begin
  FOnVoucherCheckInfo := Value;
end;

end.
