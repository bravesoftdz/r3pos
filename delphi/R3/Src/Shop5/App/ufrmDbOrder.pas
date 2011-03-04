unit ufrmDbOrder;

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
  TfrmDbOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    edtSALES_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtGUIDE_USER: TzrComboBoxList;
    Label6: TLabel;
    Label8: TLabel;
    edtCHK_DATE: TcxTextEdit;
    edtCHK_USER_TEXT: TcxTextEdit;
    Label9: TLabel;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    Label1: TLabel;
    fndMY_AMOUNT: TcxTextEdit;
    Label13: TLabel;
    edtPLAN_DATE: TcxDateEdit;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    actCustomer: TAction;
    Label3: TLabel;
    edtSTOCK_USER: TzrComboBoxList;
    Label4: TLabel;
    fndMY1_AMOUNT: TcxTextEdit;
    edtCLIENT_ID: TzrComboBoxList;
    btnOk: TRzBitBtn;
    actOK: TAction;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure fndGODS_IDAddClick(Sender: TObject);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure edtSHOP_IDSaveValue(Sender: TObject);
    procedure edtTableAfterScroll(DataSet: TDataSet);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure actCustomerExecute(Sender: TObject);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure actOKExecute(Sender: TObject);
  private
    { Private declarations }
    //��λ����
    CarryRule:integer;
    //����С��λ
    Deci:integer;
    procedure ReadHeader;
    procedure WMNextRecord(var Message: TMessage);
  protected
    procedure SetInputFlag(const Value: integer);override;
    procedure SetdbState(const Value: TDataSetState); override;
    function IsKeyPress:boolean;override;

    procedure WMFillData(var Message: TMessage); message WM_FILL_DATA;
    function CheckInput:boolean;override;
  public
    { Public declarations }
    //������
    TotalFee:real;
    //��������
    TotalAmt:real;
    //Ĭ�Ϸ�Ʊ����
    DefInvFlag:integer;
    //��ͨ˰��
    RtlRate2:real;
    //��ֵ˰��
    RtlRate3:real;
    //��Ʒ����,
    RtlPSTFlag:integer;
    RtlGDPC_ID:string;
    Dibs,Cash:Currency;
    procedure ShowInfo;
    procedure Calc;

    procedure ReadFrom(DataSet:TDataSet);override;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure AmountToCalc(Amount:Real);override;
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
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal,ufrmLogin,ufrmGoodsInfo,ufrmUsersInfo,ufrmCodeInfo,uframeListDialog,ufrmDbOkDialog;
{$R *.dfm}

procedure TfrmDbOrder.ReadHeader;
begin
end;
procedure TfrmDbOrder.CancelOrder;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmDbOrder.DeleteOrder;
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
    Factor.AddBatch(cdsHeader,'TDbOrder');
    Factor.AddBatch(cdsDetail,'TDbData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
end;

procedure TfrmDbOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('�����޸Ŀյ���');
  if IsAudit then Raise Exception.Create('�Ѿ���˵ĵ��ݲ����޸�');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ����޸�');
  dbState := dsEdit;
  if edtCLIENT_ID.CanFocus then edtCLIENT_ID.SetFocus;
end;

procedure TfrmDbOrder.FormCreate(Sender: TObject);
begin
  inherited;
  fndMY_AMOUNT.Visible := ShopGlobal.GetChkRight('600041');
  fndMY1_AMOUNT.Visible := ShopGlobal.GetChkRight('600041');
  Label1.Visible := fndMY_AMOUNT.Visible;
  Label4.Visible := fndMY1_AMOUNT.Visible;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtGUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtSTOCK_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  RtlRate2 := StrtoFloatDef(ShopGlobal.GetParameter('RTL_RATE2'),0.05);
  RtlRate3 := StrtoFloatDef(ShopGlobal.GetParameter('RTL_RATE3'),0.17);
  DefInvFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_INV_FLAG'),1);

  // 0���ֳ���ȡ 1�Ǻ�̨��ȡ
  RtlPSTFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_PST_FLAG'),0);

  //��λ����
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //����С��λ
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);

end;

procedure TfrmDbOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs:TZQuery;
  str,InLevel:string;
begin
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('��Ӫ��Ʒ��û�ҵ���'+edtTable.FieldbyName('GODS_NAME').AsString+'��');
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

procedure TfrmDbOrder.NewOrder;
var
  rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  cid := edtSHOP_ID.AsString;
  AObj.FieldbyName('SALES_ID').asString := TSequence.NewId();
//  AObj.FieldbyName('GLIDE_NO').asString := TSequence.GetSequence('GNO_SALES'+formatDatetime('YYYYMMDD',now()),Global.CompanyId,formatDatetime('YYYYMMDD',now()),6);
  oid := AObj.FieldbyName('SALES_ID').asString;
  gid := '..����..';// AObj.FieldbyName('GLIDE_NO').asString;
  edtSALES_DATE.Date := Global.SysDate;

  if ShopGlobal.GetParameter('DB_AUTO_OK')<>'0' then
     begin
       edtPLAN_DATE.Date := edtSALES_DATE.Date;
       edtSTOCK_USER.KeyValue := Global.UserID;
       edtSTOCK_USER.Text := Global.UserName;
     end;
  edtGUIDE_USER.KeyValue := Global.UserID;
  edtGUIDE_USER.Text := Global.UserName;
  InitRecord;
  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
  TabSheet.Caption := '..�½�..';
end;

procedure TfrmDbOrder.Open(id: string);
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
      Factor.AddBatch(cdsHeader,'TDbOrder',Params);
      Factor.AddBatch(cdsDetail,'TDbData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
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
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmDbOrder.SaveOrder;
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
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('�����ŵ겻��Ϊ��');
  if edtCLIENT_ID.AsString = edtSHOP_ID.AsString then Raise Exception.Create('�����ŵ�͵����ŵ겻����ͬ');
  if (edtPLAN_DATE.EditValue <> null) and (edtSALES_DATE.Date>edtPLAN_DATE.Date) then Raise Exception.Create('�������ڲ���С�ڵ�������');
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('���ܱ���һ�ſյ���...');
  CheckInvaid;
  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  cid := edtSHOP_ID.AsString;
  AObj.FieldByName('SALES_TYPE').AsInteger := 2;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  Calc;
  AObj.FieldByName('SALE_AMT').AsFloat := TotalAmt;
  AObj.FieldByName('SALE_MNY').AsFloat := TotalFee;
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
         cdsDetail.FieldByName('PLAN_DATE').AsString := cdsHeader.FieldbyName('PLAN_DATE').AsString;
         cdsDetail.FieldByName('CLIENT_ID').AsString := cdsHeader.FieldbyName('CLIENT_ID').AsString;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    Factor.AddBatch(cdsHeader,'TDbOrder');
    Factor.AddBatch(cdsDetail,'TDbData');
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

procedure TfrmDbOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
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

procedure TfrmDbOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  Calc;
end;

procedure TfrmDbOrder.Calc;
var
  r:integer;
begin
  edtTable.DisableControls;
  try
    r := edtTable.FieldbyName('SEQNO').AsInteger;
    TotalFee := 0;
    TotalAmt := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        TotalFee := TotalFee + edtTable.FieldbyName('CALC_MONEY').AsFloat;
        TotalAmt := TotalAmt + edtTable.FieldbyName('AMOUNT').AsFloat;
        edtTable.Next;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]); 
    edtTable.EnableControls;
  end;
end;

procedure TfrmDbOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('������˿յ���');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ�������');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('ֻ������˲��ܶԵ�ǰ������ִ������');
       if MessageBox(Handle,'ȷ������ǰ��������',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('�Ѿ�ͬ�������ݲ��������');
       if MessageBox(Handle,'ȷ����˵�ǰ��������',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
         Msg := Factor.ExecProc('TDbOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TDbOrderUnAudit',Params) ;
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

procedure TfrmDbOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmDbOrder.fndGODS_IDAddClick(Sender: TObject);
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

procedure TfrmDbOrder.fndGODS_IDSaveValue(Sender: TObject);
begin
  if (fndGODS_ID.AsString='') and fndGODS_ID.Focused and ShopGlobal.GetChkRight('200036') then
     begin
       if MessageBox(Handle,'û�ҵ�������ҵ���Ʒ�Ƿ�����һ����',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       fndStr := fndGODS_ID.Text;
       fndGODS_ID.OnAddClick(nil);
       Exit;
     end;
  inherited;
end;

procedure TfrmDbOrder.SetInputFlag(const Value: integer);
begin
  inherited;
end;

function TfrmDbOrder.IsKeyPress: boolean;
begin
  result := inherited IsKeyPress;
end;

procedure TfrmDbOrder.ReadFrom(DataSet: TDataSet);
begin
  inherited
end;

procedure TfrmDbOrder.ShowInfo;
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
    rs.SQL.Text := 'select SHOP_ID,sum(AMOUNT) as AMOUNT from STO_STORAGE A where A.GODS_ID=:GODS_ID and SHOP_ID in (:SHOP_ID,:CLIENT_ID) and TENANT_ID=:TENANT_ID and A.BATCH_NO=:BATCH_NO group by SHOP_ID';
    rs.ParamByName('GODS_ID').AsString := edtTable.FieldByName('GODS_ID').AsString;
    rs.ParamByName('SHOP_ID').AsString := edtSHOP_ID.AsString;
    rs.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('BATCH_NO').AsString := edtTable.FieldByName('BATCH_NO').AsString;
    Factor.Open(rs);
    if not rs.IsEmpty and rs.Locate('SHOP_ID',edtSHOP_ID.AsString,[]) then
       begin
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('BIG_UNITS').AsString) and (bs.FieldbyName('BIGTO_CALC').AsFloat<>0) then
            fndMY_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/rs.FieldbyName('BIGTO_CALC').AsFloat)
         else
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('SMALL_UNITS').AsString) and (bs.FieldbyName('SMALLTO_CALC').AsFloat<>0) then
            fndMY_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('SMALLTO_CALC').AsFloat)
         else
            fndMY_AMOUNT.Text := rs.FieldbyName('AMOUNT').AsString;
       end
    else
       fndMY_AMOUNT.Text := '0';
    if not rs.IsEmpty and rs.Locate('SHOP_ID',edtSHOP_ID.AsString,[]) then
       begin
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('BIG_UNITS').AsString) and (bs.FieldbyName('BIGTO_CALC').AsFloat<>0) then
            fndMY1_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/rs.FieldbyName('BIGTO_CALC').AsFloat)
         else
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('SMALL_UNITS').AsString) and (bs.FieldbyName('SMALLTO_CALC').AsFloat<>0) then
            fndMY1_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('SMALLTO_CALC').AsFloat)
         else
            fndMY1_AMOUNT.Text := rs.FieldbyName('AMOUNT').AsString;
       end
    else
       fndMY1_AMOUNT.Text := '0';
  finally
    rs.Free;
  end;
end;

procedure TfrmDbOrder.edtSHOP_IDSaveValue(Sender: TObject);
begin
  inherited;
  ShowInfo;

end;

procedure TfrmDbOrder.edtTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then ShowInfo;

end;

procedure TfrmDbOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;

end;

procedure TfrmDbOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  actOK.Visible := (Value = dsBrowse) and cdsHeader.Active and (cdsHeader.FieldByName('PLAN_DATE').AsString = ''); 
end;

procedure TfrmDbOrder.actCustomerExecute(Sender: TObject);
begin
  inherited;
  if edtInput.CanFocus and Visible then edtInput.SetFocus;
  InputFlag := 1;

end;

procedure TfrmDbOrder.WMNextRecord(var Message: TMessage);
begin

end;

procedure TfrmDbOrder.WMFillData(var Message: TMessage);
begin
end;

procedure TfrmDbOrder.edtCLIENT_IDSaveValue(Sender: TObject);
begin
  inherited;
  ShowInfo;

end;

procedure TfrmDbOrder.UnitToCalc(UNIT_ID: string);
begin
  inherited;
  ShowInfo;
end;

procedure TfrmDbOrder.AmountToCalc(Amount: Real);
begin
  inherited;
  edtTable.Edit;
  edtTable.FieldbyName('COST_MONEY').AsFloat := edtTable.FieldbyName('CALC_AMOUNT').AsFloat*edtTable.FieldbyName('COST_PRICE').AsFloat;
  if edtTable.FieldbyName('AMOUNT').AsFloat<>0 then
     begin
       edtTable.FieldbyName('COST_APRICE').AsString :=formatFloat('#0.000',edtTable.FieldbyName('COST_MONEY').AsFloat/edtTable.FieldbyName('AMOUNT').AsFloat);
     end;

end;

function TfrmDbOrder.CheckInput: boolean;
begin
  result := pos(inttostr(InputFlag),'0789')>0;
end;

procedure TfrmDbOrder.actOKExecute(Sender: TObject);
var
  OkDate:TDate;
  OkUser:string;
begin
  inherited;
  if edtTable.IsEmpty then Raise Exception.Create('���ܶ�һ�ſյ����е���ȷ��'); 
  if TfrmDbOkDialog.DBOkDialog(self,OkDate,OkUser) then
     begin
       edtPLAN_DATE.Date := OkDate;
       edtSTOCK_USER.KeyValue := OkUser;
       edtSTOCK_USER.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',OkUser);
       if dbState = dsBrowse then
          begin
            dbState := dsEdit;
            SaveOrder;
            if Saved then MessageBox(Handle,'����ȷ�����','������ʾ..',MB_OK+MB_ICONINFORMATION);
          end;
     end;
end;

end.
