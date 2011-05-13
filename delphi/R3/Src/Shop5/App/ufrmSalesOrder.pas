unit ufrmSalesOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, ZBase,cxSpinEdit, RzButton, cxListBox,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, DBClient;
const
  WM_PRESENT_MSG=WM_USER+4;
type
  TfrmSalesOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtSALES_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtINVOICE_FLAG: TcxComboBox;
    edtGUIDE_USER: TzrComboBoxList;
    Label6: TLabel;
    edtTAX_RATE: TcxSpinEdit;
    edtRECV_MNY: TcxTextEdit;
    Label19: TLabel;
    edtRECK_MNY: TcxTextEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtCHK_DATE: TcxTextEdit;
    edtCHK_USER_TEXT: TcxTextEdit;
    Label9: TLabel;
    Label10: TLabel;
    fndRECK_MNY: TcxTextEdit;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    Label1: TLabel;
    fndMY_AMOUNT: TcxTextEdit;
    Label12: TLabel;
    edtSEND_ADDR: TcxTextEdit;
    Label15: TLabel;
    edtTELEPHONE: TcxTextEdit;
    edtLINKMAN: TcxTextEdit;
    Label16: TLabel;
    Label17: TLabel;
    edtSALE_STYLE: TzrComboBoxList;
    Label13: TLabel;
    edtPLAN_DATE: TcxDateEdit;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Label11: TLabel;
    Label21: TLabel;
    edtINDE_GLIDE_NO: TcxButtonEdit;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    actCustomer: TAction;
    Label22: TLabel;
    edtADVA_MNY: TcxTextEdit;
    Label4: TLabel;
    edtTAX_MONEY: TcxTextEdit;
    Label3: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    Label14: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns7UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure edtINVOICE_FLAGPropertiesChange(Sender: TObject);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure fndGODS_IDAddClick(Sender: TObject);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure edtCLIENT_IDAddClick(Sender: TObject);
    procedure edtSHOP_IDSaveValue(Sender: TObject);
    procedure edtTableAfterScroll(DataSet: TDataSet);
    procedure edtSALE_STYLEAddClick(Sender: TObject);
    procedure edtCLIENT_IDFindClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure actCustomerExecute(Sender: TObject);
    procedure actIsPressentExecute(Sender: TObject);
    procedure edtFROM_IDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    //��λ����
    CarryRule:integer;
    //����С��λ
    Deci:integer;
    procedure ReadHeader;
    procedure IndeFrom(id:string);
    procedure WMNextRecord(var Message: TMessage);
    function  CheckCanExport: boolean; override;      
  protected
    procedure SetInputFlag(const Value: integer);override;
    procedure SetdbState(const Value: TDataSetState); override;
    function IsKeyPress:boolean;override;

    procedure WMFillData(var Message: TMessage); message WM_FILL_DATA;
    function OpenDialogCustomer(KeyString:string):boolean;
  public
    { Public declarations }
    //������
    TotalFee:Currency;
    //��������
    TotalAmt:Currency;
    //��������
    TotalBarter:integer;
    //Ĭ�Ϸ�Ʊ����
    DefInvFlag:integer;
    //��ͨ˰��
    RtlRate2:Currency;
    //��ֵ˰��
    RtlRate3:Currency;
    //��Ʒ����,
    RtlPSTFlag:integer;
    RtlGDPC_ID:string;
    Dibs,Cash:Currency;
    procedure ShowInfo;
    procedure ShowOweInfo;
    procedure Calc;
    //�����Ա��
    procedure WriteInfo(id:string);override;
    //�����ۿ�
    procedure AgioInfo(id:string);override;
    //�����ۿ�
    procedure AgioToGods(id:string);override;
    //�޸ĵ���
    procedure PriceToGods(id:string);override;
    //����
    procedure PresentToGods;
    //������Ի�
    procedure PresentToCalc(Present:integer);override;

    procedure ReadFrom(DataSet:TDataSet);override;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure UnitToCalc(UNIT_ID:string);override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure AuditOrder;override;
    procedure CancelOrder;override;
    procedure Open(id:string);override;
  end;

implementation
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal,ufrmLogin,ufrmClientInfo,ufrmGoodsInfo,ufrmUsersInfo,ufrmCodeInfo,uframeListDialog
   ,uframeSelectCustomer,ufrmSalIndentOrder,
   ufrmSalRetuOrderList,ufrmSalRetuOrder,ufrmShopMain,ufrmFindOrder;
{$R *.dfm}

procedure TfrmSalesOrder.ReadHeader;
begin
end;
procedure TfrmSalesOrder.CancelOrder;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmSalesOrder.DeleteOrder;
begin
  inherited;
  Saved := false;
  if cdsHeader.IsEmpty then Raise Exception.Create('����ɾ���յ���');
  if IsAudit then Raise Exception.Create('�Ѿ���˵ĵ��ݲ���ɾ��');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ���ɾ��');
  if MessageBox(Handle,'�Ƿ�����ɾ����ǰ����?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TSalesOrder');
    Factor.AddBatch(cdsDetail,'TSalesData');
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
    oid := '';
    gid := AObj.FieldbyName('GLIDE_NO').AsString;
    cid := AObj.FieldbyName('SHOP_ID').asString;
    dbState := dsBrowse;
    ShowOweInfo;
end;

procedure TfrmSalesOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  if IsAudit then Raise Exception.Create('�Ѿ���˵ĵ��ݲ����޸�');
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ����޸�');
  dbState := dsEdit;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;  
  if edtCLIENT_ID.CanFocus then edtCLIENT_ID.SetFocus;
end;

procedure TfrmSalesOrder.FormCreate(Sender: TObject);
begin
  inherited;
  fndMY_AMOUNT.Visible := ShopGlobal.GetChkRight('14500001',1); //�Ƿ��п���ѯȨ��
  Label1.Visible := fndMY_AMOUNT.Visible;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  edtGUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtSALE_STYLE.DataSet := Global.GetZQueryFromName('PUB_SALE_STYLE');
  RtlRate2 := StrtoFloatDef(ShopGlobal.GetParameter('RTL_RATE2'),0.05);
  RtlRate3 := StrtoFloatDef(ShopGlobal.GetParameter('RTL_RATE3'),0.17);
  DefInvFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_INV_FLAG'),1);
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtDEPT_ID.RangeField := 'DEPT_TYPE';
  edtDEPT_ID.RangeValue := '1';

  // 0���ֳ���ȡ 1�Ǻ�̨��ȡ
  RtlPSTFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_PST_FLAG'),0);

  //��λ����
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //����С��λ
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '���۲ֿ�';
      Label6.Caption := 'ҵ��Ա';
    end;
end;

procedure TfrmSalesOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs,bs:TZQuery;
  Params:TftParamList;
  str,OutLevel:string;
begin
  rs := TZQuery.Create(nil);
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('�������ݼ���û�ҵ���ǰ��Ʒ...');  
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('CarryRule').asInteger := CarryRule;
    Params.ParamByName('Deci').asInteger := Deci;
    Params.ParamByName('CLIENT_ID').asString := edtCLIENT_ID.AsString;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := edtSHOP_ID.AsString;
    Params.ParamByName('GODS_ID').asString := GODS_ID;
    if AObj.FieldbyName('PRICE_ID').AsString='' then
    Params.ParamByName('PRICE_ID').asString := '#' else
    Params.ParamByName('PRICE_ID').asString := AObj.FieldbyName('PRICE_ID').AsString;
    Params.ParamByName('UNIT_ID').asString := UNIT_ID;
    Factor.Open(rs,'TGetSalesPrice',Params);
    if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
    edtTable.FieldByName('APRICE').AsFloat := rs.FieldbyName('V_APRICE').AsFloat;
    edtTable.FieldbyName('ORG_PRICE').AsFloat := rs.FieldbyName('V_ORG_PRICE').AsFloat;
    edtTable.FieldbyName('COST_PRICE').AsFloat := GetCostPrice(edtSHOP_ID.AsString,GODS_ID,edtTable.FieldbyName('BATCH_NO').AsString);
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
  finally
    Params.Free;
    rs.Free;
  end;
  ShowInfo;
end;

procedure TfrmSalesOrder.NewOrder;
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
  cid := edtSHOP_ID.AsString;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;

  AObj.FieldbyName('SALES_ID').asString := TSequence.NewId();
  AObj.FieldbyName('UNION_ID').asString := '#';
  AObj.FieldbyName('PRICE_ID').asString := '#';
  oid := AObj.FieldbyName('SALES_ID').asString;
  gid := '..����..';// AObj.FieldbyName('GLIDE_NO').asString;
  edtSALES_DATE.Date := Global.SysDate;

  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select MAX(CLSE_DATE) from ACC_CLOSE_FORDAY where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER';
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    rs.Params.ParamByName('CREA_USER').AsString := Global.UserID;
    Factor.Open(rs);
    if rs.Fields[0].AsString >= formatDatetime('YYYYMMDD',edtSALES_DATE.Date) then
       edtSALES_DATE.Date := fnTime.fnStrtoDate(rs.Fields[0].AsString)+1;
  finally
    rs.Free;
  end;

  edtPLAN_DATE.Date := edtSALES_DATE.Date+1;
  
  edtGUIDE_USER.KeyValue := Global.UserID;
  edtGUIDE_USER.Text := Global.UserName;
  edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',InttoStr(DefInvFlag));
  edtINVOICE_FLAGPropertiesChange(nil);
  if not edtSALE_STYLE.DataSet.IsEmpty then
     begin
       edtSALE_STYLE.KeyValue := edtSALE_STYLE.DataSet.FieldbyName('CODE_ID').AsString;
       edtSALE_STYLE.Text := edtSALE_STYLE.DataSet.FieldbyName('CODE_NAME').AsString;
     end;
  InitRecord;
  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
  TabSheet.Caption := '..�½�..';
end;

procedure TfrmSalesOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := cid;
    Params.ParamByName('SALES_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TSalesOrder',Params);
      Factor.AddBatch(cdsDetail,'TSalesData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  //2011.04.02 �ᵽReadFromObject֮ǰ
    edtSHOP_ID.Properties.ReadOnly := False;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    edtTAX_RATE.Value := AObj.FieldbyName('TAX_RATE').AsFloat*100;
    ReadHeader;
    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := id;
    gid := AObj.FieldbyName('GLIDE_NO').AsString;
    cid := AObj.FieldbyName('SHOP_ID').asString;
    if id<>'' then
       begin
         if trim(edtCLIENT_ID.Text)='' then
            begin
              TabSheet.Caption := gid;
            end;
       end;
    ShowOweInfo;
  finally
    Params.Free;
  end;
end;

procedure TfrmSalesOrder.SaveOrder;
var
  Printed:boolean;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if ShopGlobal.GetParameter('GUIDE_USER')='0' then
  begin
     if edtGUIDE_USER.AsString='' then
        Raise Exception.Create('������ҵ��Ա�ٱ��棡');
  end;

  Saved := false;
  if edtSALES_DATE.EditValue = null then Raise Exception.Create('�������ڲ���Ϊ��');
  if edtINVOICE_FLAG.ItemIndex = -1 then Raise Exception.Create('Ʊ�����Ͳ���Ϊ��');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('�ͻ����Ʋ���Ϊ��');
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('���ܱ���һ�ſյ���...');
  CheckInvaid;
  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cid := edtSHOP_ID.AsString;
  AObj.FieldByName('SALES_TYPE').AsInteger := 1;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  Calc;
  if (AObj.FieldByName('BARTER_INTEGRAL').AsFloat<>0) and (AObj.FieldByName('CLIENT_ID').AsString='') then Raise Exception.Create('���ǻ�Ա���ѣ������л��ֶһ�����Ʒ.'); 
  AObj.FieldByName('SALE_AMT').AsFloat := TotalAmt;
  AObj.FieldByName('SALE_MNY').AsFloat := TotalFee;
  AObj.FieldByName('CASH_MNY').AsFloat := 0;
  AObj.FieldByName('PAY_ZERO').AsFloat := 0;
  AObj.FieldByName('PAY_DIBS').AsFloat := 0;
  AObj.FieldByName('PAY_A').AsFloat := 0;
  AObj.FieldByName('PAY_B').AsFloat := 0;
  AObj.FieldByName('PAY_C').AsFloat := 0;
  AObj.FieldByName('PAY_D').AsFloat := TotalFee;
  AObj.FieldByName('PAY_E').AsFloat := 0;
  AObj.FieldByName('PAY_F').AsFloat := 0;
  AObj.FieldByName('PAY_G').AsFloat := 0;
  AObj.FieldByName('PAY_H').AsFloat := 0;
  AObj.FieldByName('PAY_I').AsFloat := 0;
  AObj.FieldByName('PAY_J').AsFloat := 0;
  AObj.FieldbyName('TAX_RATE').AsFloat := edtTAX_RATE.Value / 100;
  if ShopGlobal.GetParameter('SAL_AUTO_CHK')<>'0' then
     begin
       AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
       AObj.FieldbyName('CHK_USER').AsString := Global.UserID;
     end;
  //����Ի���
  //if not TfrmShowDibs.ShowDibs(self,TotalFee,AObj,Printed,Cash,Dibs) then Exit;
  //end 
  Factor.BeginBatch;
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
    Factor.AddBatch(cdsHeader,'TSalesOrder');
    Factor.AddBatch(cdsDetail,'TSalesData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  Open(oid);
  dbState := dsBrowse;
  Saved := true;
end;

procedure TfrmSalesOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
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
          if abs(r)>999999 then Raise Exception.Create('�������ֵ������Ч');
        except
          Text := TColumnEh(Sender).Field.AsString;
          Value := TColumnEh(Sender).Field.asFloat;
          Raise Exception.Create('������Ч��ֵ��');
        end;
        TColumnEh(Sender).Field.asFloat := r;
        AMountToCalc(r);
     end;
end;

procedure TfrmSalesOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r,op:Currency;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
begin
  //����Ȩ��(����Ȩ��)
  if not ShopGlobal.GetChkRight('12400001',5) then
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',6,Params.UserID);
            if not allow then Raise Exception.Create('��������û�û������Ȩ��...');
          end
       else
          allow := false;
     end else allow := true;
  if allow then
  begin
    try
      if Text='' then
         r := 0
      else
         r := StrtoFloat(Text);
      if abs(r)>999999 then Raise Exception.Create('�������ֵ������Ч');
    except
      on E:Exception do
         begin
           Text := TColumnEh(Sender).Field.AsString;
           Value := TColumnEh(Sender).Field.asFloat;
           MessageBox(Handle,pchar('������Ч��ֵ��,����'+E.Message),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
           Exit;
         end;
    end;
    op := TColumnEh(Sender).Field.asFloat;
    TColumnEh(Sender).Field.asFloat := r;
    PriceToCalc(r);
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

procedure TfrmSalesOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r,op:Currency;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
begin
  if not ShopGlobal.GetChkRight('12400001',5) then
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',6,Params.UserID);
            if not allow then Raise Exception.Create('��������û�û������Ȩ��...');
          end
       else
          allow := false;
     end else allow := true;
  if allow then
  begin
    try
      if Text='' then
         r := 0
      else
         r := StrtoFloat(Text);
      if abs(r)>999999 then Raise Exception.Create('�������ֵ������Ч');
    except
      Text := TColumnEh(Sender).Field.AsString;
      Value := TColumnEh(Sender).Field.asFloat;
      Raise Exception.Create('������Ч��ֵ��');
    end;
    op := TColumnEh(Sender).Field.asFloat;
    TColumnEh(Sender).Field.asFloat := r;
    AMoneyToCalc(r);
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

procedure TfrmSalesOrder.DBGridEh1Columns7UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r:Currency;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
begin
  if not ShopGlobal.GetChkRight('12400001',5) then
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',6,Params.UserID);
            if not allow then Raise Exception.Create('��������û�û������Ȩ��...');
          end
       else
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
    TColumnEh(Sender).Field.asFloat := r;
    edtTable.FieldbyName('POLICY_TYPE').AsInteger := 4;
    AgioToCalc(r);
  end
  else
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('��û���޸����۵��۸��Ȩ��,��͹���Ա��ϵ...'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
end;

procedure TfrmSalesOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;
end;

procedure TfrmSalesOrder.Calc;
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
  ps := Global.GetZQueryFromName('PUB_PRICEGRADE');
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
  if (amt<>0) and (dbState<>dsBrowse) then
     begin
       case t of
       1:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(TotalFee / amt);
       2:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(prf / amt);
       3:AObj.FieldbyName('INTEGRAL').AsInteger := trunc(TotalAmt / amt);
       end;
     end;
  AObj.FieldbyName('BARTER_INTEGRAL').AsInteger := TotalBarter;
//  edtCALC_MONEY.Text := formatFloat('#0.0##',TotalFee);
  edtTAX_MONEY.Text := formatFloat('#0.00',(TotalFee/(1+AObj.FieldbyName('TAX_RATE').AsFloat))*AObj.FieldbyName('TAX_RATE').AsFloat);
  if dbState <> dsBrowse then
     begin
       edtRECK_MNY.Text := formatFloat('#0.0##',TotalFee-StrtoFloatDef(edtRECV_MNY.Text,0));
     end;
end;

procedure TfrmSalesOrder.edtCLIENT_IDSaveValue(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  if (edtCLIENT_ID.AsString='') and edtCLIENT_ID.Focused  and ShopGlobal.GetChkRight('33300001',2) then
     begin
       if MessageBox(Handle,'û�ҵ�������ҵĿͻ��Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       edtCLIENT_ID.OnAddClick(nil);
       Exit;
     end;
   rs := Global.GetZQueryFromName('PUB_CUSTOMER');
   if not rs.Locate('CLIENT_ID',edtCLIENT_ID.AsString,[]) then Raise Exception.Create('ѡ��Ĺ�Ӧ��û�ҵ�,�쳣����.');
   edtTELEPHONE.Text := rs.FieldbyName('TELEPHONE2').AsString;
   edtLINKMAN.Text := rs.FieldbyName('LINKMAN').AsString;
   edtSEND_ADDR.Text := rs.FieldbyName('ADDRESS').AsString;
   AObj.FieldByName('PRICE_ID').AsString := rs.FieldbyName('PRICE_ID').AsString;
   AObj.FieldbyName('UNION_ID').asString := '#';
   if rs.FieldbyName('FLAG').AsInteger = 0 then
      begin
        rs.Close;
        rs.SQL.Text := 'select RECV_ADDR,RECV_LINKMAN,RECV_TELE from PUB_CLIENTINFO where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID';
        rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
        rs.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
        Factor.Open(rs);
        edtTELEPHONE.Text := rs.FieldbyName('RECV_TELE').AsString;
        edtLINKMAN.Text := rs.FieldbyName('RECV_LINKMAN').AsString;
        edtSEND_ADDR.Text := rs.FieldbyName('RECV_ADDR').AsString;
      end;
   Locked := true;
   try
     edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',rs.Fields[0].AsString);
     if edtINVOICE_FLAG.ItemIndex<0 then edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',inttostr(DefInvFlag));
     edtINVOICE_FLAGPropertiesChange(nil);
     Calc;
   finally
      Locked := false;
   end;
   ShowOweInfo;
end;

procedure TfrmSalesOrder.edtINVOICE_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  if Locked then Exit;
  if dbState=dsBrowse then Exit;
  if edtINVOICE_FLAG.ItemIndex < 0 then Exit;
  case TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
  1:AObj.FieldbyName('TAX_RATE').AsFloat := 0;
  2:AObj.FieldbyName('TAX_RATE').AsFloat := RtlRate2;
  3:AObj.FieldbyName('TAX_RATE').AsFloat := RtlRate3;
  end;
  edtTAX_RATE.Value := AObj.FieldbyName('TAX_RATE').AsFloat*100;
  Calc;
end;

procedure TfrmSalesOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('������˿յ���');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ�������');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('ֻ������˲��ܶԵ�ǰ���۵�ִ������');
       if MessageBox(Handle,'ȷ������ǰ���۵���',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ��������');
       if MessageBox(Handle,'ȷ����˵�ǰ���۵���',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('SHOP_ID').asString := edtSHOP_ID.AsString;
      Params.ParamByName('SALES_ID').asString := cdsHeader.FieldbyName('SALES_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TSalesOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TSalesOrderUnAudit',Params) ;
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

procedure TfrmSalesOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmSalesOrder.fndGODS_IDAddClick(Sender: TObject);
var r:TRecord_;
begin
  inherited;
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

procedure TfrmSalesOrder.fndGODS_IDSaveValue(Sender: TObject);
begin
  if (fndGODS_ID.AsString='') and fndGODS_ID.Focused and ShopGlobal.GetChkRight('32600001',2) then
     begin
       if MessageBox(Handle,'û�ҵ�������ҵ���Ʒ�Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       fndStr := fndGODS_ID.Text;
       fndGODS_ID.OnAddClick(nil);
       Exit;
     end;
  inherited;
end;

procedure TfrmSalesOrder.edtCLIENT_IDAddClick(Sender: TObject);
var r:TRecord_;
begin
  inherited;
  r := TRecord_.Create;
  try
    if TfrmClientInfo.AddDialog(self,r) then
       begin
         edtCLIENT_ID.KeyValue := r.FieldbyName('CLIENT_ID').AsString;
         edtCLIENT_ID.Text := r.FieldbyName('CLIENT_NAME').AsString;
         edtCLIENT_ID.OnSaveValue(nil);
       end;
  finally
    r.Free;
  end;
end;

procedure TfrmSalesOrder.AgioInfo(id: string);
begin
  inherited;

end;

procedure TfrmSalesOrder.WriteInfo(id: string);
var
  rs:TZQuery;
  SObj:TRecord_;
begin
  rs := TZQuery.Create(nil);
  SObj := TRecord_.Create;
  try
    if id='' then
    begin
      if not OpenDialogCustomer('') then Exit;
      rs.SQL.Text :=
        'select j.*,c.UNION_NAME from ('+
        'select B.IC_CARDNO,A.CLIENT_NAME,A.CLIENT_SPELL,A.CLIENT_ID,A.CLIENT_CODE,A.INVOICE_FLAG,A.INTEGRAL,B.BALANCE,A.PRICE_ID,B.UNION_ID from VIW_CUSTOMER A left outer join PUB_IC_INFO B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
        'where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.CLIENT_ID='''+AObj.FieldbyName('CLIENT_ID').AsString+''' and A.COMM not in (''02'',''12'') ) j left outer join '+
        '(select UNION_ID,UNION_NAME from PUB_UNION_INFO '+
        ' union all '+
        ' select ''#'' as UNION_ID,''��ҵ�ͻ�'' as UNION_NAME '+
        ') c on j.UNION_ID=c.UNION_ID ';
      Factor.Open(rs);
    end
    else
    begin
      rs.SQL.Text :=
        'select j.*,c.UNION_NAME from ('+
        'select B.IC_CARDNO,A.CLIENT_NAME,A.CLIENT_SPELL,A.CLIENT_ID,A.CLIENT_CODE,A.INVOICE_FLAG,A.INTEGRAL,B.BALANCE,A.PRICE_ID,B.UNION_ID from VIW_CUSTOMER A,PUB_IC_INFO B where A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
        'and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and B.IC_CARDNO='''+id+''' and B.IC_STATUS in (''0'',''1'') and B.COMM not in (''02'',''12'') ) j left outer join '+
        '(select UNION_ID,UNION_NAME from PUB_UNION_INFO '+
        ' union all '+
        ' select ''#'' as UNION_ID,''��ҵ�ͻ�'' as UNION_NAME '+
        ') c on j.UNION_ID=c.UNION_ID ';
      Factor.Open(rs);
      if rs.IsEmpty then
         begin
          rs.Close;
          rs.SQL.Text :=
            'select j.*,c.UNION_NAME from ('+
            'select B.IC_CARDNO,A.CLIENT_NAME,A.CLIENT_SPELL,A.CLIENT_ID,A.CLIENT_CODE,A.INVOICE_FLAG,A.INTEGRAL,B.BALANCE,A.PRICE_ID,B.UNION_ID from VIW_CUSTOMER A left outer join PUB_IC_INFO B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
            'where A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.TELEPHONE2='''+id+''' and A.LICENSE_CODE='''+id+''' and A.COMM not in (''02'',''12'') ) j left outer join '+
            '(select UNION_ID,UNION_NAME from PUB_UNION_INFO '+
            ' union all '+
            ' select ''#'' as UNION_ID,''��ҵ�ͻ�'' as UNION_NAME '+
            ') c on j.UNION_ID=c.UNION_ID ';
          Factor.Open(rs);
         end;
    end;
    if rs.IsEmpty then Raise Exception.Create('û���ҵ��˻�Ա����.'); 
    if rs.RecordCount = 1 then
       SObj.ReadFromDataSet(rs)
    else
    if rs.RecordCount = 2 then
       begin
         rs.First;
         while not rs.Eof do
           begin
             if rs.FieldByName('UNION_ID').AsString <> '#' then
                begin
                  SObj.ReadFromDataSet(rs);
                  break; 
                end;
             rs.Next;
           end;
       end
    else
       if not TframeListDialog.FindDialog(self,rs.SQL.Text,'IC_CARDNO=����,CLIENT_NAME=�ͻ�����,UNION_NAME=����',SObj) then Exit;
    edtCLIENT_ID.KeyValue := SObj.FieldbyName('CLIENT_ID').AsString;
    edtCLIENT_ID.Text := SObj.FieldbyName('CLIENT_NAME').AsString;
    AObj.FieldbyName('UNION_ID').AsString := SObj.FieldbyName('UNION_ID').AsString;
    AObj.FieldbyName('IC_CARDNO').AsString := SObj.FieldbyName('IC_CARDNO').AsString;
    AObj.FieldbyName('CLIENT_ID').AsString := SObj.FieldbyName('CLIENT_ID').AsString;
    AObj.FieldbyName('CLIENT_CODE').AsString := SObj.FieldbyName('CLIENT_CODE').AsString;
    AObj.FieldbyName('CLIENT_ID_TEXT').AsString := SObj.FieldbyName('CLIENT_NAME').AsString;
    AObj.FieldbyName('PRICE_ID').AsString := SObj.FieldbyName('PRICE_ID').AsString;
    AObj.FieldbyName('BALANCE').AsFloat := SObj.FieldbyName('BALANCE').AsFloat;
    AObj.FieldbyName('ACCU_INTEGRAL').AsFloat := SObj.FieldbyName('INTEGRAL').AsFloat;
    Locked := true;
    try
      edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',SObj.FieldbyName('INVOICE_FLAG').AsString);
      if edtINVOICE_FLAG.ItemIndex<0 then edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',inttostr(DefInvFlag));
      edtINVOICE_FLAGPropertiesChange(nil);
      Calc;
    finally
      Locked := false;
    end;
    ShowOweInfo;
  finally
    SObj.Free;
    rs.Free;
  end;
end;

procedure TfrmSalesOrder.AgioToGods(id: string);
var
  r:Currency;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
begin
  if not ShopGlobal.GetChkRight('12400001',5) then
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',6,Params.UserID);
            if not allow then Raise Exception.Create('��������û�û������Ȩ��...');
          end
       else
          allow := false;
     end else allow := true;
  if allow then
  begin
    inherited;
    edtTable.Edit;
    edtTable.FieldbyName('POLICY_TYPE').AsInteger := 4;
  end;
end;

procedure TfrmSalesOrder.PriceToGods(id: string);
var
  r,op:Currency;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
begin
  if not ShopGlobal.GetChkRight('12400001',5) then
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',6,Params.UserID);
            if not allow then Raise Exception.Create('��������û�û������Ȩ��...');
          end
       else
          allow := false;
     end else allow := true;
  if allow then
  begin
    op := edtTable.FieldbyName('APRICE').AsFloat;
    inherited;
    edtTable.Edit;
    edtTable.FieldbyName('POLICY_TYPE').AsInteger := 4;
  end;
end;

procedure TfrmSalesOrder.SetInputFlag(const Value: integer);
begin
  inherited;
end;

function TfrmSalesOrder.IsKeyPress: boolean;
begin
  result := inherited IsKeyPress;
end;

procedure TfrmSalesOrder.PresentToGods;
var
  r:Currency;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
  s:string;
  Field:TField;
begin
  Field := edtTable.FindField('APRICE');
  if Field=nil then Exit;
  if Field.AsFloat <> 0 then
  begin
    if not ShopGlobal.GetChkRight('12400001',5) then
       begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12400001',6,Params.UserID);
            if not allow then Raise Exception.Create('��������û�û������Ȩ��...');
          end
       else
          allow := false;
       end else allow := true;
    if allow then
    begin
      if edtTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('��ѡ����Ʒ����ִ�д˲���');
      edtTable.Edit;
      edtTable.FieldbyName('APRICE').AsFloat := 0;
      edtTable.FieldbyName('POLICY_TYPE').AsInteger := 4;
      PriceToCalc(Field.AsFloat);
    end;
  end
  else
  begin
    InitPrice(edtTable.FieldbyName('GODS_ID').AsString,edtTable.FieldbyName('UNIT_ID').AsString);
    PriceToCalc(edtTable.FieldbyName('APRICE').AsFloat);
  end;
end;

procedure TfrmSalesOrder.ReadFrom(DataSet: TDataSet);
begin
  inherited
end;

procedure TfrmSalesOrder.ShowOweInfo;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select sum(RECK_MNY),sum(case when SALES_ID='''+oid+''' then RECK_MNY else 0 end),sum(case when SALES_ID='''+oid+''' then RECV_MNY else 0 end) from ACC_RECVABLE_INFO where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
       fndRECK_MNY.Text := formatFloat('#0.0##',rs.Fields[0].AsFloat)
    else
       fndRECK_MNY.Text := formatFloat('#0.0##',0);
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

procedure TfrmSalesOrder.ShowInfo;
var
  rs,bs:TZQuery;
begin
  if not fndMY_AMOUNT.Visible then Exit;
  fndMY_AMOUNT.Text := '';
  if edtTable.FieldByName('GODS_ID').AsString = '' then Exit;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO'); 
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('��Ӫ��Ʒ��û�ҵ���'+edtTable.FieldbyName('GODS_NAME').AsString+'��');
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

procedure TfrmSalesOrder.PresentToCalc(Present: integer);
var bs:TZQuery;
begin
  if Present in [0,1] then
     inherited
  else
     begin
       bs := Global.GetZQueryFromName('PUB_GOODSINFO');
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
            PresentToCalc(0);
          end;
      end;
  ShowInfo;
end;

procedure TfrmSalesOrder.UnitToCalc(UNIT_ID: string);
begin
  inherited;
  ShowInfo;
end;

procedure TfrmSalesOrder.edtSHOP_IDSaveValue(Sender: TObject);
begin
  inherited;
  cid := edtSHOP_ID.AsString;
  ShowInfo;

end;

procedure TfrmSalesOrder.edtTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then ShowInfo;

end;

procedure TfrmSalesOrder.edtSALE_STYLEAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  r := TRecord_.Create;
  try
    if TfrmCodeInfo.AddDialog(self,r,2) then
       begin
         edtSALE_STYLE.KeyValue := r.FieldbyName('CODE_ID').AsString;
         edtSALE_STYLE.Text := r.FieldbyName('CODE_NAME').AsString;
       end;
  finally
    r.Free;
  end;
end;

procedure TfrmSalesOrder.edtCLIENT_IDFindClick(Sender: TObject);
begin
  inherited;
  if dbState = dsBrowse then Exit;
  OpenDialogCustomer('');
end;

procedure TfrmSalesOrder.N2Click(Sender: TObject);
var frmSalRetuOrderList:TfrmSalRetuOrderList;
begin
  inherited;
  if dbState <> dsBrowse then Raise Exception.Create('�뱣�浥�ݺ��ٲ�����');
  if not IsAudit then Raise Exception.Create('û����˵��ݣ������˻�..');
  if not frmShopMain.actfrmSalRetuOrderList.Enabled then Exit;
  frmShopMain.actfrmSalRetuOrderList.OnExecute(nil);
  frmSalRetuOrderList := TfrmSalRetuOrderList(frmShopMain.FindChildForm(TfrmSalRetuOrderList));
  PostMessage(frmSalRetuOrderList.Handle,WM_EXEC_ORDER,0,2);
  PostMessage(frmSalRetuOrderList.CurOrder.Handle,WM_FILL_DATA,integer(self),0);
  inherited;
end;

procedure TfrmSalesOrder.N3Click(Sender: TObject);
var frmSalRetuOrderList:TfrmSalRetuOrderList;
begin
  inherited;
  if dbState <> dsBrowse then Raise Exception.Create('�뱣�浥�ݺ��ٲ�����');
  if not IsAudit then Raise Exception.Create('û����˵��ݣ������˻�..');
  if not frmShopMain.actfrmSalRetuOrderList.Enabled then Exit;
  frmShopMain.actfrmSalRetuOrderList.OnExecute(nil);
  frmSalRetuOrderList := TfrmSalRetuOrderList(frmShopMain.FindChildForm(TfrmSalRetuOrderList));
  PostMessage(frmSalRetuOrderList.Handle,WM_EXEC_ORDER,0,2);
  PostMessage(frmSalRetuOrderList.CurOrder.Handle,WM_FILL_DATA,integer(self),1);
  inherited;
end;

procedure TfrmSalesOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;

end;

procedure TfrmSalesOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  edtSHOP_ID.Properties.ReadOnly := (Value<>dsInsert);
  if edtSHOP_ID.Properties.ReadOnly then SetEditStyle(dsBrowse,edtSHOP_ID.Style);
end;

procedure TfrmSalesOrder.actCustomerExecute(Sender: TObject);
begin
  inherited;
  if edtInput.CanFocus and Visible then edtInput.SetFocus;
  InputFlag := 1;

end;

procedure TfrmSalesOrder.WMNextRecord(var Message: TMessage);
begin

end;

procedure TfrmSalesOrder.WMFillData(var Message: TMessage);
var
  frmSalIndentOrder:TfrmSalIndentOrder;
  i:integer;
begin
  if dbState <> dsInsert then Raise Exception.Create('����������״̬������ɲ���');
  frmSalIndentOrder := TfrmSalIndentOrder(Message.WParam);
  with TfrmSalIndentOrder(frmSalIndentOrder) do
    begin
      self.edtCLIENT_ID.KeyValue := edtCLIENT_ID.KeyValue;
      self.edtCLIENT_ID.Text := edtCLIENT_ID.Text;
      self.edtSHOP_ID.KeyValue := edtSHOP_ID.KeyValue;
      self.edtSHOP_ID.Text := edtSHOP_ID.Text;
      self.edtGUIDE_USER.KeyValue := edtGUIDE_USER.KeyValue;
      self.edtGUIDE_USER.Text := edtGUIDE_USER.Text;
      self.edtDEPT_ID.KeyValue := edtDEPT_ID.KeyValue;
      self.edtDEPT_ID.Text := edtDEPT_ID.Text;
      self.edtTELEPHONE.Text := edtTELEPHONE.Text;
      self.edtLINKMAN.Text := edtLINKMAN.Text;
      self.AObj.FieldbyName('FROM_ID').AsString := AObj.FieldbyName('INDE_ID').AsString;
      self.AObj.FieldbyName('TAX_RATE').AsString := AObj.FieldbyName('TAX_RATE').AsString;
      self.AObj.FieldbyName('PRICE_ID').AsString := AObj.FieldbyName('PRICE_ID').AsString;
      self.AObj.FieldbyName('UNION_ID').AsString := AObj.FieldbyName('UNION_ID').AsString;
      self.edtINDE_GLIDE_NO.Text := AObj.FieldbyName('GLIDE_NO').AsString;
      self.edtSALE_STYLE.KeyValue := edtSALE_STYLE.KeyValue;
      self.edtADVA_MNY.Text := edtADVA_MNY.Text;
      self.edtSALE_STYLE.Text := edtSALE_STYLE.Text;
      self.edtSEND_ADDR.Text := edtSEND_ADDR.Text;
      self.edtPLAN_DATE.Date := edtPLAN_DATE.Date;
      self.edtREMARK.Text := edtREMARK.Text;
      self.Locked := true;
      try
        self.edtINVOICE_FLAG.ItemIndex := edtINVOICE_FLAG.ItemIndex;
        self.edtTAX_RATE.Value := edtTAX_RATE.Value;
      finally
        self.Locked := false;
      end;
      case Message.LParam of
      0:IndeFrom(AObj.FieldbyName('INDE_ID').AsString);
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
          self.edtTable.FieldByName('COST_PRICE').AsFloat := GetCostPrice(edtSHOP_ID.AsString,self.edtTable.FieldbyName('GODS_ID').AsString,self.edtTable.FieldbyName('BATCH_NO').AsString);
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
          self.Calc;
        end;
      end;

    end;
  inherited;
end;

function TfrmSalesOrder.OpenDialogCustomer(KeyString: string): boolean;
begin
  result := false;
  if dbState = dsBrowse then Exit;
  with TframeSelectCustomer.Create(self) do
    begin
      try
        edtSearch.Text := KeyString;
        Open('');
        if ShowModal=MROK then
           begin
             edtCLIENT_ID.KeyValue := cdsList.FieldbyName('CLIENT_ID').AsString;
             edtCLIENT_ID.Text := cdsList.FieldbyName('CLIENT_NAME').AsString;
             edtCLIENT_ID.OnSaveValue(edtCLIENT_ID);
             result := true;
           end;
      finally
        free;
      end;
    end;
end;

procedure TfrmSalesOrder.actIsPressentExecute(Sender: TObject);
begin
  case edtTable.FieldbyName('IS_PRESENT').AsInteger of
  0:PresentToCalc(1);
  1:PresentToCalc(2);
  else
     PresentToCalc(0);
  end;
end;

procedure TfrmSalesOrder.edtFROM_IDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var s:string;
begin
  inherited;
  if not IsNull then Raise Exception.Create('�Ѿ�������Ʒ�ˣ����ܵ��붩��.');
  if dbState <> dsInsert then Raise Exception.Create('ֻ�в�������״̬�ĵ��ݲ��ܵ��붩��.');
  s := TfrmFindOrder.FindDialog(self,2,edtCLIENT_ID.asString,edtSHOP_ID.asString);
  if s<>'' then
     begin
       IndeFrom(s);
     end;
end;

function TfrmSalesOrder.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('12400001',10);
end;

procedure TfrmSalesOrder.IndeFrom(id: string);
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
      Params.ParamByName('INDE_ID').asString := id;
      Factor.BeginBatch;
      try
        Factor.AddBatch(h,'TSalIndentOrder',Params);
        Factor.AddBatch(d,'TSalIndentDataForSales',Params);
        Factor.OpenBatch;
        HObj.ReadFromDataSet(h);
        ReadFromObject(HObj,self);
        AObj.FieldbyName('FROM_ID').AsString := HObj.FieldbyName('INDE_ID').AsString;
        AObj.FieldbyName('PRICE_ID').AsString := HObj.FieldbyName('PRICE_ID').AsString;
        AObj.FieldbyName('UNION_ID').AsString := HObj.FieldbyName('UNION_ID').AsString;
        edtINDE_GLIDE_NO.Text := HObj.FieldbyName('GLIDE_NO').AsString;
        edtSALES_DATE.Date := Global.SysDate;
        AObj.FieldbyName('TAX_RATE').AsFloat := HObj.FieldbyName('TAX_RATE').AsFloat;
        edtTAX_RATE.Value := HObj.FieldbyName('TAX_RATE').AsFloat*100;
        //if h.FieldByName('SALBILL_STATUS').AsInteger=0 then
        //   AObj.FieldByName('ADVA_MNY').AsFloat := HObj.FieldByName('ADVA_MNY').AsFloat
        //else
        //   AObj.FieldByName('ADVA_MNY').AsFloat := 0;
        ReadFrom(d);
      except
        Factor.CancelBatch;
        Raise;
      end;
     edtTable.First;
     while not edtTable.Eof do
       begin
         edtTable.Edit;
         edtTable.FieldByName('COST_PRICE').AsFloat := GetCostPrice(edtSHOP_ID.AsString,edtTable.FieldbyName('GODS_ID').AsString,edtTable.FieldbyName('BATCH_NO').AsString);
         edtTable.Post; 
         edtTable.Next;
       end;
     Calc;
   finally
     HObj.Free;
     Params.Free;
     h.Free;
     d.Free;
   end;
end;

end.
