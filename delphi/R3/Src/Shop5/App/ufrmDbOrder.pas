unit ufrmDbOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, ZBase,cxSpinEdit, RzButton, cxListBox,math,
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
    Label12: TLabel;
    Label15: TLabel;
    edtSEND_ADDR: TcxTextEdit;
    edtTELEPHONE: TcxTextEdit;
    Label16: TLabel;
    edtLINKMAN: TcxTextEdit;
    edtDEMA_GLIDE_NO: TcxButtonEdit;
    Label5: TLabel;
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
    procedure edtDEMA_GLIDE_NOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    //进位法则
    CarryRule:integer;
    //保留小数位
    Deci:integer;
    procedure ReadHeader;
    procedure WMNextRecord(var Message: TMessage);
  protected
    procedure SetInputFlag(const Value: integer);override;
    procedure SetdbState(const Value: TDataSetState); override;
    function IsKeyPress:boolean;override;

    procedure WMFillData(var Message: TMessage); message WM_FILL_DATA;
    procedure DemaFrom(id:String);
    function CheckInput:boolean;override;
    function GetShopId:string;override;
  public
    { Public declarations }
    //结算金额
    TotalFee:real;
    //成本金额
    StockFee:real;
    //结算数量
    TotalAmt:real;
    //默认发票类型
    DefInvFlag:integer;
    //普通税率
    RtlRate2:real;
    //增值税率
    RtlRate3:real;
    //赠品处理,
    RtlPSTFlag:integer;

    //只做到货确认
    OK_DIALOG:boolean;
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
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal,ufrmLogin,ufrmGoodsInfo,ufrmUsersInfo,
     ufrmCodeInfo,uframeListDialog,ufrmDbOkDialog,ufrmDemandOrder,ufrmFindOrder;
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
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能删除');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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

procedure TfrmDbOrder.FormCreate(Sender: TObject);
begin
  inherited;
  fndMY_AMOUNT.Visible := ShopGlobal.GetChkRight('14500001',1);  //是否有库存查询权限
  fndMY1_AMOUNT.Visible := ShopGlobal.GetChkRight('14500001',1); //是否有库存查询权限
  Label1.Visible := fndMY_AMOUNT.Visible;
  Label4.Visible := fndMY1_AMOUNT.Visible;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtGUIDE_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtSTOCK_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  RtlRate2 := StrtoFloatDef(ShopGlobal.GetParameter('RTL_RATE2'),0.05);
  RtlRate3 := StrtoFloatDef(ShopGlobal.GetParameter('RTL_RATE3'),0.17);
  DefInvFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_INV_FLAG'),1);

  // 0是现场领取 1是后台领取
  RtlPSTFlag := StrtoIntDef(ShopGlobal.GetParameter('RTL_PST_FLAG'),0);

  //进位法则
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //保留小数位
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);
//  if not ShopGlobal.GetChkRight('14500001',2) then
//     begin
//       DBGridEh1.Columns[7].Free;
//       DBGridEh1.Columns[6].Free;
//     end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      lblCLIENT_ID.Caption := '调入仓库';
      Label40.Caption := '调出仓库';
    end;
end;

procedure TfrmDbOrder.InitPrice(GODS_ID, UNIT_ID: string);
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

procedure TfrmDbOrder.NewOrder;
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
  AObj.FieldbyName('SALES_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('SALES_ID').asString;
  gid := '..新增..';// AObj.FieldbyName('GLIDE_NO').asString;
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
  TabSheet.Caption := '..新建..';
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
    edtSHOP_ID.Properties.ReadOnly := False;
    AObj.ReadFromDataSet(cdsHeader);
    dbState := dsBrowse;  //2011.04.02 提到ReadFromObject之前
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
    OK_DIALOG := false;
  finally
    Params.Free;
  end;
end;

procedure TfrmDbOrder.SaveOrder;
var
  Printed:boolean;
  Params:TftParamList;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  Saved := false;
  if edtSALES_DATE.EditValue = null then Raise Exception.Create('调拨日期不能为空');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('调入门店不能为空');
  if edtCLIENT_ID.AsString = edtSHOP_ID.AsString then Raise Exception.Create('调入门店和调出门店不能相同');
  if (edtPLAN_DATE.EditValue <> null) and (edtSALES_DATE.Date>edtPLAN_DATE.Date) then Raise Exception.Create('到货日期不能小于调出日期');
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      if (edtSHOP_ID.AsString <> Global.SHOP_ID) and (edtCLIENT_ID.AsString <> Global.SHOP_ID) then
         Raise Exception.Create('只能操作本门店的调拨单...'); 
    end;
  if edtPLAN_DATE.EditValue <> null then
     begin
       if edtSTOCK_USER.AsString = '' then Raise Exception.Create('请选择收货人'); 
     end;
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
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
  AObj.FieldByName('STOCK_MNY').AsFloat := StockFee;

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
  if (ShopGlobal.GetParameter('STO_AUTO_CHK')<>'0') and (AObj.FieldbyName('PLAN_DATE').asString<>'') and ShopGlobal.GetChkRight('14100001',7) then
     begin
       AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
       AObj.FieldbyName('CHK_USER').AsString := Global.UserID;
     end;
  //结算对话框
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
    if OK_DIALOG then
       begin
         Params := TftParamList.Create;
         Params.ParamByName('OK_DIALOG').AsInteger := 1; 
       end
    else
       Params := nil;
    Factor.AddBatch(cdsHeader,'TDbOrder',Params);
    Factor.AddBatch(cdsDetail,'TDbData',Params);
    if Params<>nil then Params.Free;
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
    StockFee := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        StockFee := StockFee + roundto(edtTable.FieldbyName('CALC_AMOUNT').AsFloat*edtTable.FieldbyName('COST_PRICE').AsFloat,-2);
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
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前调拨单执行弃审');
       if MessageBox(Handle,'确认弃审当前调拨单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前调拨单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
  if (fndGODS_ID.AsString='') and fndGODS_ID.Focused and ShopGlobal.GetChkRight('32600001',2) then
     begin
       if MessageBox(Handle,'没找到你想查找的商品是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
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
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');
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
            fndMY_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('BIGTO_CALC').AsFloat)
         else
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('SMALL_UNITS').AsString) and (bs.FieldbyName('SMALLTO_CALC').AsFloat<>0) then
            fndMY_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('SMALLTO_CALC').AsFloat)
         else
            fndMY_AMOUNT.Text := rs.FieldbyName('AMOUNT').AsString;
       end
    else
       fndMY_AMOUNT.Text := '0';
    if not rs.IsEmpty and rs.Locate('SHOP_ID',edtCLIENT_ID.AsString,[]) then
       begin
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('BIG_UNITS').AsString) and (bs.FieldbyName('BIGTO_CALC').AsFloat<>0) then
            fndMY1_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('BIGTO_CALC').AsFloat)
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
  if cdsHeader.Active and (Value=dsBrowse) then
  begin
    if AObj.FieldbyName('LOCUS_STATUS').AsString='3' then
       lblState.Caption := lblState.Caption + ' / 已发货'
    else
       lblState.Caption := lblState.Caption + ' / 未发货';
  end;
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
var
  frmDemandOrder:TfrmDemandOrder;
  i:integer;
begin
  if dbState <> dsInsert then Raise Exception.Create('不是在新增状态不能完成操作');
  frmDemandOrder := TfrmDemandOrder(Message.WParam);
  with TfrmDemandOrder(frmDemandOrder) do
    begin
      self.edtCLIENT_ID.KeyValue := edtSHOP_ID.KeyValue;
      self.edtCLIENT_ID.Text := edtSHOP_ID.Text;
      //self.edtSHOP_ID.KeyValue := edtSHOP_ID.KeyValue;
      //self.edtSHOP_ID.Text := edtSHOP_ID.Text;
      self.edtSTOCK_USER.KeyValue := edtDEMA_USER.KeyValue;
      self.edtSTOCK_USER.Text := edtDEMA_USER.Text;
      //self.edtDEPT_ID.KeyValue := edtDEPT_ID.KeyValue;
      //self.edtDEPT_ID.Text := edtDEPT_ID.Text;
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
          self.Calc;
        end;
      end;
    end;
  inherited;
end;

procedure TfrmDbOrder.edtCLIENT_IDSaveValue(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  ShowInfo;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select ADDRESS,LINKMAN,TELEPHONE from CA_SHOP_INFO where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+edtCLIENT_ID.AsString+'''';
    Factor.Open(rs);
    edtSEND_ADDR.Text := rs.FieldbyName('ADDRESS').AsString;
    edtLINKMAN.Text := rs.FieldbyName('LINKMAN').AsString;
    edtTELEPHONE.Text := rs.FieldbyName('TELEPHONE').AsString;
  finally
    rs.Free;
  end;
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
  if edtTable.IsEmpty then Raise Exception.Create('不能对一张空单进行到货确认'); 
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      if (edtCLIENT_ID.AsString <> Global.SHOP_ID) then
         Raise Exception.Create('只能操作调入至本门店的调拨单...');
    end;
  OkDate := Date();
  OkUser := Global.UserId;
  if TfrmDbOkDialog.DBOkDialog(self,OkDate,OkUser) then
     begin
       edtPLAN_DATE.Date := OkDate;
       edtSTOCK_USER.KeyValue := OkUser;
       edtSTOCK_USER.Text := TdsFind.GetNameByID(Global.GetZQueryFromName('CA_USERS'),'USER_ID','USER_NAME',OkUser);
       if dbState = dsBrowse then
          begin
            dbState := dsEdit;
            OK_DIALOG := true;
            try
               SaveOrder;
            finally
               OK_DIALOG := false;
            end;
            if Saved then MessageBox(Handle,'到货确认完毕','友情提示..',MB_OK+MB_ICONINFORMATION);
          end;
     end;
end;

procedure TfrmDbOrder.DemaFrom(id: String);
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
        edtSALES_DATE.Date := Global.SysDate;
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
        Calc;
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

procedure TfrmDbOrder.edtDEMA_GLIDE_NOPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  s:string;
begin
  inherited;
  if not IsNull then Raise Exception.Create('已经输入商品了，不能导入订单.');
  if dbState <> dsInsert then Raise Exception.Create('只有不是新增状态的单据不能导入订单.');  
  s := TfrmFindOrder.FindDialog(self,5,edtSHOP_ID.asString,'');
  if s<>'' then
     begin
       DemaFrom(s);
     end;
end;

function TfrmDbOrder.GetShopId: string;
begin
  result := edtSHOP_ID.asString;
end;

end.
