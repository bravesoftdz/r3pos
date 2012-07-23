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
    labAMOUNT: TLabel;
    labClientId: TLabel;
    LabGlideNo: TLabel;
    LabAmount1: TLabel;
    labNO: TLabel;
    labPRC: TLabel;
    LabPayMny: TLabel;
    LabRecvMny: TLabel;
    LabSumMny: TLabel;
    TabSheet5: TRzTabSheet;
    RzPanel4: TRzPanel;
    DBGridEh1: TDBGridEh;
    CdsVhpayGlide: TZQuery;
    DsVhpay: TDataSource;
    Btn_Update: TRzBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtInputKeyPress(Sender: TObject; var Key: Char);
    procedure Btn_CloseClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure RzPageChange(Sender: TObject);
    procedure Btn_UpdateClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
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
    function GetBalanceVoucherSql:String;
    procedure OpenBalanceVoucher;
  public
    { Public declarations }
    procedure Open;
    procedure Save;
    class function ScanBarcode(Owner:TForm;vFromId:String='';vShopId:String='';vDeptId:String='';vClientId:String='';vPayMny:Currency=0):Currency;
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
  LabPayMny.Caption := '总  计: '+FloatToStr(Value) + ' 元';
  LabRecvMny.Caption := '已  付: 0 元';
  labMNY.Caption := '结  余: 0 元';  
end;

procedure TfrmVhPayGlide.SetPayUser(const Value: String);
begin
  FPayUser := Value;
end;

procedure TfrmVhPayGlide.SetResultAmount(const Value: Integer);
begin
  FResultAmount := Value;
  if RzPageControl1.ActivePageIndex = 0 then
     labAMOUNT.Caption := '张  数: '+IntToStr(Value) + ' 张'
  else
     LabAmount1.Caption := '张  数: '+IntToStr(Value) + ' 张';
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
  vDeptId, vClientId: String; vPayMny: Currency): Currency;
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
      if ShowModal=mrOk then
         Result := SumMoney
      else
         Result := 0;
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
  RzPage.ActivePageIndex := 0;
  Btn_Save.BringToFront;
  Open;
  OpenBalanceVoucher;
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
     SumMoney := SumMoney + rs.FieldByName('VOUCHER_PRC').AsFloat;
     labPRC.Caption := '礼券面值: '+rs.FieldByName('VOUCHER_PRC').AsString+' 元';
     labNO.Caption := '防伪码:'+BarCode;
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
     if (PayMny-SumMoney) > rs.FieldByName('VOUCHER_PRC').AsFloat then
        CdsVhPay.FieldByName('VHPAY_MNY').AsFloat := rs.FieldByName('VOUCHER_PRC').AsInteger
     else
        CdsVhPay.FieldByName('VHPAY_MNY').AsFloat := PayMny-SumMoney;
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
     LabRecvMny.Caption := '已  付: '+FormatFloat('#00.00',SumMoney) + '元';
     labMNY.Caption := '结  余: '+FormatFloat('#00.00',PayMny-SumMoney)+ ' 元';
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
     labNO.Caption := '防伪码:'+BarCode;
     LabPRC.Caption := '礼券面值: '+rs.FieldByName('VOUCHER_PRC').AsString+' 元';
     labClientId.Caption := '客  户:'+rs.FieldByName('CLIENT_NAME').AsString;
     LabGlideNo.Caption := '订单号:'+rs.FieldByName('GLIDE_NO').AsString;
     ResultAmount := ResultAmount + 1;
     LabSumMny.Caption := '总  计: '+FormatFloat('#00.00',SumMoney)+' 元';
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
      Caption := '提货券';
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

procedure TfrmVhPayGlide.RzPageChange(Sender: TObject);
begin
  inherited;
  if RzPage.ActivePageIndex = 0 then
     Btn_Save.BringToFront
  else
     Btn_Update.BringToFront;
end;

function TfrmVhPayGlide.GetBalanceVoucherSql: String;
var Str:String;
begin
  Str := 'select A.BARCODE,A.VOUCHER_TYPE,A.VOUCHER_PRC,A.VOUCHER_STATUS,B.SHOP_ID,B.DEPT_ID,B.VHPAY_ID,'+
  'B.CLIENT_ID,B.VHPAY_USER,B.VHPAY_MNY,B.AGIO_RATE,B.AGIO_MONEY,B.VHPAY_DATE,B.CREA_DATE,B.FROM_ID '+
  ' from SAL_VOUCHERDATA A left join SAL_VHPAY_GLIDE B on A.TENANT_ID=B.TENANT_ID and A.BARCODE=B.BARCODE '+
  ' where A.TENANT_ID=:TENANT_ID and A.VOUCHER_STATUS=''4'' and B.VHPAY_DATE=:VHPAY_DATE and B.CREA_USER=:CREA_USER ';
  Result := Str;
end;

procedure TfrmVhPayGlide.OpenBalanceVoucher;
begin
  if not Visible then Exit;
  CdsVhpayGlide.close;

  CdsVhpayGlide.DisableControls;
  try
    CdsVhpayGlide.SQL.Text := GetBalanceVoucherSql;
    CdsVhpayGlide.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    CdsVhpayGlide.Params.ParamByName('VHPAY_DATE').AsInteger := strtoint(formatdatetime('YYYYMMDD',Date));
    CdsVhpayGlide.Params.ParamByName('CREA_USER').AsString := Global.UserID;

    Factor.Open(CdsVhpayGlide);
  finally
    CdsVhpayGlide.EnableControls;
  end;
end;

procedure TfrmVhPayGlide.Btn_UpdateClick(Sender: TObject);
var Params:TftParamList;
    Msg:String;
begin
  inherited;
  if CdsVhpayGlide.IsEmpty then Exit;
  if MessageBox(Handle,'确认撤消当前提货券？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  try
    Params := TftParamList.Create;
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('VHPAY_ID').AsString := TSequence.NewId;
      Params.ParamByName('BARCODE').AsString := CdsVhpayGlide.FieldByName('BARCODE').AsString;
      Params.ParamByName('SHOP_ID').AsString := CdsVhpayGlide.FieldByName('SHOP_ID').AsString;
      Params.ParamByName('DEPT_ID').AsString := CdsVhpayGlide.FieldByName('DEPT_ID').AsString;
      Params.ParamByName('CLIENT_ID').AsString := CdsVhpayGlide.FieldByName('CLIENT_ID').AsString;
      Params.ParamByName('VHPAY_DATE').AsInteger := CdsVhpayGlide.FieldByName('VHPAY_DATE').AsInteger;
      Params.ParamByName('VHPAY_USER').AsString := CdsVhpayGlide.FieldByName('VHPAY_USER').AsString;
      Params.ParamByName('VOUCHER_PRC').AsInteger := CdsVhpayGlide.FieldByName('VOUCHER_PRC').AsInteger;
      Params.ParamByName('VOUCHER_TYPE').AsString := CdsVhpayGlide.FieldByName('VOUCHER_TYPE').AsString;
      Params.ParamByName('VHPAY_MNY').AsFloat := 0-CdsVhpayGlide.FieldByName('VHPAY_MNY').AsFloat;
      Params.ParamByName('AGIO_RATE').AsFloat := CdsVhpayGlide.FieldByName('AGIO_RATE').AsFloat;
      Params.ParamByName('AGIO_MONEY').AsFloat := CdsVhpayGlide.FieldByName('AGIO_MONEY').AsFloat;
      Params.ParamByName('FROM_ID').AsString := CdsVhpayGlide.FieldByName('FROM_ID').AsString;
      Params.ParamByName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
      Params.ParamByName('CREA_USER').AsString := Global.UserID;
      Params.ParamByName('REMARK').AsString := '撤消<'+CdsVhpayGlide.FieldByName('VHPAY_ID').AsString+'>';
      Msg := Factor.ExecProc('TUpdateVhPayGlide',Params);
      MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    finally
      Params.Free;
    end;
    CdsVhpayGlide.Delete;
  Except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;  
  end;

end;

procedure TfrmVhPayGlide.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    //DBGridEh1.Canvas.Font.Color := clWhite;
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.Brush.Color := $0000F2F2;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(CdsVhpayGlide.RecNo)),length(Inttostr(CdsVhpayGlide.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

end.
