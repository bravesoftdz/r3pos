unit ufrmDemandOrder;

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
  TfrmDemandOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    edtDEMA_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtDEMA_USER: TzrComboBoxList;
    Label6: TLabel;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    actCustomer: TAction;
    Label18: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    Label13: TLabel;
    edtDEMA_TYPE: TcxComboBox;
    N1: TMenuItem;
    N2: TMenuItem;
    Label1: TLabel;
    fndMY_AMOUNT: TcxTextEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtCHK_DATE: TcxTextEdit;
    edtCHK_USER_TEXT: TcxTextEdit;
    Label3: TLabel;
    fndUPPER_AMOUNT: TcxTextEdit;
    Label4: TLabel;
    fndLOWER_AMOUNT: TcxTextEdit;
    Label7: TLabel;
    fndDAY_SALE_AMT: TcxTextEdit;
    Label10: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure fndGODS_IDAddClick(Sender: TObject);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure edtTableAfterScroll(DataSet: TDataSet);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actBatchNoExecute(Sender: TObject);
    procedure edtSHOP_IDPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    //进位法则
    CarryRule:integer;
    //保留小数位
    Deci:integer;
    FDemandType: String;
    procedure ReadHeader;
    function  CheckCanExport: boolean; override;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure SetDemandType(const Value: String);
  protected
    procedure SetInputFlag(const Value: integer);override;
    function IsKeyPress:boolean;override;
    function CheckRepeat(AObj:TRecord_;var pt:boolean):boolean;override;
    procedure AddRecord(AObj:TRecord_;UNIT_ID:string;Located:boolean=false;IsPresent:boolean=false);override;
    function CheckInput:boolean;override;
  public
    { Public declarations }
    //结算金额
    TotalFee:real;
    //结算数量
    TotalAmt:real;

    //赠品处理,
    RtlPSTFlag:integer;
    RtlGDPC_ID:string;
    Dibs,Cash:Currency;
    procedure ShowInfo;
    procedure ShowOweInfo;
    procedure Calc;

    //赠送
    procedure PresentToGods;

    //检测数据合法性
    procedure CheckInvaid;override;
    procedure ReadFrom(DataSet:TDataSet);override;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure UnitToCalc(UNIT_ID:string);override;
    procedure PresentToCalc(Present:integer);override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure AuditOrder;override;
    procedure CancelOrder;override;
    procedure Open(id:string);override;
    property DemandType:String read FDemandType write SetDemandType;
  end;

implementation
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal,ufrmLogin,ufrmClientInfo,ufrmGoodsInfo,ufrmMain,
     ufrmUsersInfo,ufrmCodeInfo,uframeListDialog,uframeSelectCustomer,ufrmSalesOrderList,
     ufrmSalesOrder,ufrmShopMain,ufrmSupplierInfo,ufrmTenantInfo,ufrmChangeOrderList,ufrmDbOrderList;
{$R *.dfm}

procedure TfrmDemandOrder.ReadHeader;
begin
end;
procedure TfrmDemandOrder.CancelOrder;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmDemandOrder.DeleteOrder;
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
    Factor.AddBatch(cdsHeader,'TDemandOrder');
    Factor.AddBatch(cdsDetail,'TDemandData');
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

procedure TfrmDemandOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改');
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;
  if edtSHOP_ID.CanFocus then edtSHOP_ID.SetFocus;
end;

procedure TfrmDemandOrder.FormCreate(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtDEMA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  //进位法则
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //保留小数位
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);
  //fndMY_AMOUNT.Visible := ShopGlobal.GetChkRight('14500001',1); //是否有库存查询权限
  //Label1.Visible := fndMY_AMOUNT.Visible;

  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''DEMA_TYPE'' ';
    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        AObj := TRecord_.Create;
        AObj.ReadFromDataSet(rs);
        edtDEMA_TYPE.Properties.Items.AddObject(rs.Fields[1].AsString,AObj); 
        rs.Next;
      end;
  finally
    rs.Free;
  end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label5.Caption := '仓库名称';
    end;

end;

procedure TfrmDemandOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  bs:TZQuery;
  Params:TftParamList;
  str,OutLevel:string;
begin
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('缓冲数据集中没找到当前商品...');

  if not (edtTable.State in [dsEdit,dsInsert]) then edtTable.Edit;
  if edtTable.FieldByName('UNIT_ID').AsString = bs.FieldByName('CALC_UNITS').AsString then
    begin
      edtTable.FieldByName('APRICE').AsFloat := bs.FieldbyName('NEW_OUTPRICE').AsFloat;
      edtTable.FieldbyName('ORG_PRICE').AsFloat := bs.FieldbyName('NEW_OUTPRICE').AsFloat;
    end
  else if edtTable.FieldByName('UNIT_ID').AsString = bs.FieldByName('SMALL_UNITS').AsString then
    begin
      edtTable.FieldByName('APRICE').AsFloat := bs.FieldbyName('NEW_OUTPRICE1').AsFloat;
      edtTable.FieldbyName('ORG_PRICE').AsFloat := bs.FieldbyName('NEW_OUTPRICE1').AsFloat;
    end
  else if edtTable.FieldByName('UNIT_ID').AsString = bs.FieldByName('BIG_UNITS').AsString then
    begin
      edtTable.FieldByName('APRICE').AsFloat := bs.FieldbyName('NEW_OUTPRICE2').AsFloat;
      edtTable.FieldbyName('ORG_PRICE').AsFloat := bs.FieldbyName('NEW_OUTPRICE2').AsFloat;
    end;

  //看是否换购商品
  if bs.FieldByName('USING_BARTER').AsInteger=3 then
    edtTable.FieldByName('IS_PRESENT').AsInteger := 2
  else
    edtTable.FieldByName('IS_PRESENT').AsInteger := 0;

  ShowInfo;
end;

procedure TfrmDemandOrder.NewOrder;
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
    
  rs := ShopGlobal.GetDeptInfo;
  AObj.FieldbyName('DEMA_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('DEMA_ID').asString;
  gid := '..新增..';// AObj.FieldbyName('GLIDE_NO').asString;
  edtDEMA_DATE.Date := Global.SysDate;
  if edtDEMA_TYPE.Properties.Items.Count > 0 then
     edtDEMA_TYPE.ItemIndex := TdsItems.FindItems(edtDEMA_TYPE.Properties.Items,'CODE_ID',DemandType);
  edtDEMA_USER.KeyValue := Global.UserID;
  edtDEMA_USER.Text := Global.UserName;

  Caption := edtDEMA_TYPE.Text + '单';

  InitRecord;
  if edtSHOP_ID.CanFocus and Visible then edtSHOP_ID.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmDemandOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := cid;
    Params.ParamByName('DEMA_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TDemandOrder',Params);
      Factor.AddBatch(cdsDetail,'TDemandData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  //2011.04.02 提到ReadFromObject之前
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    DemandType := cdsHeader.FieldbyName('DEMA_TYPE').AsString;
    ReadHeader;
    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := id;
    gid := AObj.FieldbyName('GLIDE_NO').AsString;
    cid := AObj.FieldbyName('SHOP_ID').asString;
    {case AObj.FieldByName('SALBILL_STATUS').AsInteger of
    0:Label18.Caption := '状态:待发货';
    1:Label18.Caption := '状态:发货中';
    2:Label18.Caption := '状态:已发货';
    end;}
    if Trim(edtSHOP_ID.Text)<>'' then
       begin
         TabSheet.Caption := edtSHOP_ID.Text;
       end;
    ShowOweInfo;
  finally
    Params.Free;
  end;
end;

procedure TfrmDemandOrder.SaveOrder;
var
  Printed:boolean;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if ShopGlobal.GetParameter('GUIDE_USER')='0' then
  begin
     if edtDEMA_USER.AsString='' then
        Raise Exception.Create('请输入填报人再保存！');
  end;

  Saved := false;
  if edtDEMA_DATE.EditValue = null then Raise Exception.Create('填报日期不能为空');
  if edtDEMA_TYPE.ItemIndex<0 then Raise Exception.Create('请选择单据类型');
  //if edtCLIENT_ID.AsString = '' then Raise Exception.Create('客户名称不能为空');
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('CLIENT_ID').AsString  := IntToStr(Global.TENANT_ID);
  AObj.FieldbyName('SHOP_ID').AsString := Global.SHOP_ID;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  AObj.FieldByName('DEMA_TYPE').AsString := TRecord_(edtDEMA_TYPE.Properties.Items.Objects[edtDEMA_TYPE.ItemIndex]).FieldbyName('CODE_ID').AsString;
  Calc;
  AObj.FieldByName('DEMA_AMT').AsFloat := TotalAmt;
  AObj.FieldByName('DEMA_MNY').AsFloat := TotalFee;
  if ShopGlobal.GetParameter('SAL_AUTO_CHK')<>'0' then
     begin
       AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
       AObj.FieldbyName('CHK_USER').AsString := Global.UserID;
     end;
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
         cdsDetail.FieldByName('DEMA_ID').AsString := cdsHeader.FieldbyName('DEMA_ID').AsString;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    Factor.AddBatch(cdsHeader,'TDemandOrder');
    Factor.AddBatch(cdsDetail,'TDemandData');
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

procedure TfrmDemandOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
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

procedure TfrmDemandOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r,op:real;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
begin
  if not ShopGlobal.GetChkRight('12300001',5) then
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12300001',5,Params.UserID);
            if not allow then Raise Exception.Create('你输入的用户没有调价权限...');
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
  end
  else
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('你没有修改"需求填报"价格的权限,请和管理员联系...'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
  
end;

procedure TfrmDemandOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  r,op:real;
  Params:TLoginParam;
  allow :boolean;
  rs,us:TZQuery;
begin
  if not ShopGlobal.GetChkRight('12300001',5) then
     begin
       if TfrmLogin.doLogin(Params) then
          begin
            allow := ShopGlobal.GetChkRight('12300001',5,Params.UserID);
            if not allow then Raise Exception.Create('你输入的用户没有调价权限...');
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
    except
      Text := TColumnEh(Sender).Field.AsString;
      Value := TColumnEh(Sender).Field.asFloat;
      Raise Exception.Create('输入无效数值型');
    end;
    if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
    op := TColumnEh(Sender).Field.asFloat;
    TColumnEh(Sender).Field.asFloat := r;
    AMoneyToCalc(r);
  end
  else
  begin
    Value := TColumnEh(Sender).Field.asFloat;
    Text := TColumnEh(Sender).Field.AsString;
    MessageBox(Handle,pchar('你没有修改"需求填报"价格的权限,请和管理员联系...'),pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
  end;
end;

procedure TfrmDemandOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;
end;

procedure TfrmDemandOrder.Calc;
var
  r:integer;
  mny:real;
  ps:TZQuery;
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

procedure TfrmDemandOrder.AuditOrder;
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
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前销售订单执行弃审');
       if MessageBox(Handle,'确认弃审当前销售订单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前销售订单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('DEMA_ID').asString := cdsHeader.FieldbyName('DEMA_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      Params.ParamByName('DEMA_TYPE').AsString := DemandType;
      if not IsAudit then
         Msg := Factor.ExecProc('TDemandOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TDemandOrderUnAudit',Params) ;
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

procedure TfrmDemandOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmDemandOrder.fndGODS_IDAddClick(Sender: TObject);
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

procedure TfrmDemandOrder.fndGODS_IDSaveValue(Sender: TObject);
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

procedure TfrmDemandOrder.SetInputFlag(const Value: integer);
begin
  inherited;
end;

function TfrmDemandOrder.IsKeyPress: boolean;
begin
  result := inherited IsKeyPress;
end;

procedure TfrmDemandOrder.ReadFrom(DataSet: TDataSet);
begin
  inherited
end;

procedure TfrmDemandOrder.ShowOweInfo;
var
  rs:TZQuery;
begin
  {rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select sum(RECK_MNY),sum(case when SALES_ID='''+oid+''' then RECK_MNY else 0 end),sum(case when SALES_ID='''+oid+''' then RECV_MNY else 0 end) from ACC_RECVABLE_INFO where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
    Factor.Open(rs);
  finally
    rs.Free;
  end;}
end;

procedure TfrmDemandOrder.ShowInfo;
var
  rs,bs:TZQuery;
  Sql:String;
begin
  if not fndMY_AMOUNT.Visible then Exit;
  fndMY_AMOUNT.Text := '';
  if edtTable.FieldByName('GODS_ID').AsString = '' then Exit;
  bs := Global.GetZQueryFromName('PUB_GOODSINFO'); 
  if not bs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');
  rs := TZQuery.Create(nil);
  try
    Sql :=
    'select A.TENANT_ID,A.SHOP_ID,A.GODS_ID,sum(A.AMOUNT) as AMOUNT '+
    ' from STO_STORAGE A inner join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID inner join VIW_GOODSINFO_SORTEXT C on A.TENANT_ID=C.TENANT_ID and A.GODS_ID=C.GODS_ID '+
    ' and A.TENANT_ID='+IntToStr(Global.TENANT_ID)+' and C.COMM not in (''02'',''12'')  and A.SHOP_ID='+QuotedStr(Global.SHOP_ID)+
    ' and A.GODS_ID='+QuotedStr(edtTable.FieldByName('GODS_ID').AsString)+' and A.BATCH_NO='+QuotedStr(edtTable.FieldByName('BATCH_NO').AsString)+
    ' group by A.TENANT_ID,A.SHOP_ID,A.GODS_ID';
    Sql :=
    'select sum(j1.AMOUNT) as AMOUNT,'+
    'sum(E.LOWER_AMOUNT) as LOWER_AMOUNT,'+
    'sum(E.UPPER_AMOUNT) as UPPER_AMOUNT,'+
    'sum(E.DAY_SALE_AMT) as DAY_SALE_AMT '+
    'from ('+Sql+') j1 '+
    'left outer join PUB_GOODS_INSHOP E on j1.TENANT_ID=E.TENANT_ID and j1.SHOP_ID=E.SHOP_ID and j1.GODS_ID=E.GODS_ID '+
    'group by j1.TENANT_ID,j1.GODS_ID';
    rs.SQL.Text := Sql;

    {rs.SQL.Text := 'select sum(AMOUNT) as AMOUNT from STO_STORAGE A where A.GODS_ID=:GODS_ID and SHOP_ID=:SHOP_ID and TENANT_ID=:TENANT_ID and A.BATCH_NO=:BATCH_NO';
    rs.ParamByName('GODS_ID').AsString := edtTable.FieldByName('GODS_ID').AsString;
    rs.ParamByName('SHOP_ID').AsString := edtSHOP_ID.AsString;
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('BATCH_NO').AsString := edtTable.FieldByName('BATCH_NO').AsString; }
    Factor.Open(rs);
    if not rs.IsEmpty then
       begin
         if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('BIG_UNITS').AsString) and (bs.FieldbyName('BIGTO_CALC').AsFloat<>0) then
         begin
            fndMY_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('BIGTO_CALC').AsFloat);
            fndUPPER_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('UPPER_AMOUNT').AsFloat/bs.FieldbyName('BIGTO_CALC').AsFloat);
            fndLOWER_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('LOWER_AMOUNT').AsFloat/bs.FieldbyName('BIGTO_CALC').AsFloat);
            fndDAY_SALE_AMT.Text := FormatFloat('#0.00',rs.FieldbyName('DAY_SALE_AMT').AsFloat/bs.FieldbyName('BIGTO_CALC').AsFloat);
         end
         else if (edtTable.FieldbyName('UNIT_ID').AsString = bs.FieldbyName('SMALL_UNITS').AsString) and (bs.FieldbyName('SMALLTO_CALC').AsFloat<>0) then
         begin
            fndMY_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('AMOUNT').AsFloat/bs.FieldbyName('SMALLTO_CALC').AsFloat);
            fndUPPER_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('UPPER_AMOUNT').AsFloat/bs.FieldbyName('SMALLTO_CALC').AsFloat);
            fndLOWER_AMOUNT.Text := FormatFloat('#0.00',rs.FieldbyName('LOWER_AMOUNT').AsFloat/bs.FieldbyName('SMALLTO_CALC').AsFloat);
            fndDAY_SALE_AMT.Text := FormatFloat('#0.00',rs.FieldbyName('DAY_SALE_AMT').AsFloat/bs.FieldbyName('SMALLTO_CALC').AsFloat);
         end
         else
         begin
            fndMY_AMOUNT.Text := rs.FieldbyName('AMOUNT').AsString;
            fndUPPER_AMOUNT.Text := rs.FieldbyName('UPPER_AMOUNT').AsString;
            fndLOWER_AMOUNT.Text := rs.FieldbyName('LOWER_AMOUNT').AsString;
            fndDAY_SALE_AMT.Text := rs.FieldbyName('DAY_SALE_AMT').AsString;
         end;
       end
    else
       fndMY_AMOUNT.Text := '0';
  finally
    rs.Free;
  end;
end;

procedure TfrmDemandOrder.UnitToCalc(UNIT_ID: string);
begin
  inherited;
  ShowInfo;
end;

procedure TfrmDemandOrder.edtTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then ShowInfo;

end;

procedure TfrmDemandOrder.CheckInvaid;
begin
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
  //inherited;

end;

function TfrmDemandOrder.CheckCanExport: boolean;
begin
  result:=ShopGlobal.GetChkRight('12300001',10);
end;

procedure TfrmDemandOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  FindColumn('SHIP_AMOUNT').Visible := (Value=dsBrowse);
end;

procedure TfrmDemandOrder.AddRecord(AObj: TRecord_; UNIT_ID: string;
  Located, IsPresent: boolean);
var
  Pt:integer;
  r:boolean;
begin
  if IsPresent then pt := 1 else pt := 0;
  if Located then
     begin
        if not gRepeat then
            begin
              r := edtTable.Locate('GODS_ID;IS_PRESENT',VarArrayOf([AObj.FieldbyName('GODS_ID').AsString,pt]),[]);
              if r then Exit;
            end;
        inc(RowID);
        if (edtTable.FieldbyName('GODS_ID').asString='') and (edtTable.FieldbyName('SEQNO').asString<>'') then
        edtTable.Edit else InitRecord;
        edtTable.FieldbyName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
        edtTable.FieldbyName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
        edtTable.FieldbyName('GODS_CODE').AsString := AObj.FieldbyName('GODS_CODE').AsString;
        edtTable.FieldByName('IS_PRESENT').asInteger := pt;
        if UNIT_ID='' then
           edtTable.FieldbyName('UNIT_ID').AsString := AObj.FieldbyName('UNIT_ID').AsString
        else
           edtTable.FieldbyName('UNIT_ID').AsString := UNIT_ID;
        edtTable.FieldbyName('BATCH_NO').AsString := '#';
     end;
  edtTable.Edit;
  edtTable.FieldbyName('BARCODE').AsString := EncodeBarcode;
  InitPrice(AObj.FieldbyName('GODS_ID').AsString,UNIT_ID);
end;

function TfrmDemandOrder.CheckRepeat(AObj: TRecord_;
  var pt: boolean): boolean;
var
  r,c:integer;
begin
  result := false;
  r := edtTable.FieldbyName('SEQNO').AsInteger;
  edtTable.DisableControls;
  try
    c := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        if
           (edtTable.FieldbyName('GODS_ID').AsString = AObj.FieldbyName('GODS_ID').AsString)
           and
           (edtTable.FieldbyName('IS_PRESENT').AsString = AObj.FieldbyName('IS_PRESENT').AsString)
           and
           (edtTable.FieldbyName('SEQNO').AsInteger <> r)
        then
           begin
             inc(c);
             break;
           end;
        edtTable.Next;
      end;
    pt := false;
    if c>0 then
      begin
        if gRepeat and (MessageBox(Handle,pchar('"'+AObj.FieldbyName('GODS_NAME').asString+'('+AObj.FieldbyName('GODS_CODE').asString+')已经存在，是否继续添加赠品？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)=6) then
           result := false else result := true;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]);
    edtTable.EnableControls;
  end;
end;

function TfrmDemandOrder.CheckInput: boolean;
begin
  result := not (pos(inttostr(InputFlag),'8')>0);
end;

procedure TfrmDemandOrder.PresentToGods;
var
  r:real;
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
      if not ShopGlobal.GetChkRight('12300001',5) then
         begin
         if TfrmLogin.doLogin(Params) then
            begin
              allow := ShopGlobal.GetChkRight('12300001',6,Params.UserID);
              if not allow then Raise Exception.Create('你输入的用户没有赠送权限...');
            end
         else
            allow := false;
         end else allow := true;
      if allow then
      begin
        if edtTable.FieldbyName('GODS_ID').asString='' then Raise Exception.Create('请选择商品后再执行此操作');
        edtTable.Edit;
        edtTable.FieldbyName('APRICE').AsFloat := 0;
        PriceToCalc(Field.AsFloat);
      end;
    end
  else
    begin
      InitPrice(edtTable.FieldbyName('GODS_ID').AsString,edtTable.FieldbyName('UNIT_ID').AsString);
      PriceToCalc(edtTable.FieldbyName('APRICE').AsFloat);
    end;
end;

procedure TfrmDemandOrder.SetDemandType(const Value: String);
begin
  FDemandType := Value;
  if (Value = '1') then
  begin
    edtDEPT_ID.RangeField := 'DEPT_TYPE';
    edtDEPT_ID.RangeValue := '1';
  end;  
  if edtDEMA_TYPE.Properties.Items.Count > 0 then
     edtDEMA_TYPE.ItemIndex := TdsItems.FindItems(edtDEMA_TYPE.Properties.Items,'CODE_ID',DemandType);
  Caption := edtDEMA_TYPE.Text + '单';
end;

procedure TfrmDemandOrder.N1Click(Sender: TObject);
var frmChangeOrderList:TfrmChangeOrderList;
    frmDbOrderList:TfrmDbOrderList;
begin
  inherited;                                                                            
  if dbState <> dsBrowse then Raise Exception.Create('请保存单据后再操作。');
  if not IsAudit then Raise Exception.Create('没有审核的单据不能入库..');
  if DemandType = '1' then
  begin
    if not frmMain.FindAction('actfrmDbOrderList').Enabled then Exit;
    frmMain.FindAction('actfrmDbOrderList').OnExecute(nil);
    frmDbOrderList := TfrmDbOrderList(frmMain.FindChildForm(TfrmDbOrderList));
    SendMessage(frmDbOrderList.Handle,WM_EXEC_ORDER,0,2);
    PostMessage(frmDbOrderList.CurOrder.Handle,WM_FILL_DATA,integer(self),0);
  end
  else if DemandType = '2' then
  begin
    if not frmMain.FindAction('actfrmChangeOrderList2').Enabled then Exit;
    frmMain.FindAction('actfrmChangeOrderList2').OnExecute(nil);
    frmChangeOrderList := TfrmChangeOrderList(frmMain.FindChildForm('frmChangeOrderList2'));
    SendMessage(frmChangeOrderList.Handle,WM_EXEC_ORDER,0,2);
    PostMessage(frmChangeOrderList.CurOrder.Handle,WM_FILL_DATA,integer(self),0);
  end;
  inherited;
end;

procedure TfrmDemandOrder.N2Click(Sender: TObject);
var frmChangeOrderList:TfrmChangeOrderList;
    frmDbOrderList:TfrmDbOrderList;
begin
  inherited;
  if dbState <> dsBrowse then Raise Exception.Create('请保存单据后再操作。');
  if not IsAudit then Raise Exception.Create('没有审核的单据不能入库..');
  if DemandType = '1' then
  begin
    if not frmMain.FindAction('actfrmDbOrderList').Enabled then Exit;
    frmMain.FindAction('actfrmDbOrderList').OnExecute(nil);
    frmDbOrderList := TfrmDbOrderList(frmMain.FindChildForm(TfrmDbOrderList));
    SendMessage(frmDbOrderList.Handle,WM_EXEC_ORDER,0,2);
    PostMessage(frmDbOrderList.CurOrder.Handle,WM_FILL_DATA,integer(self),1);
  end
  else if DemandType = '2' then
  begin
    if not frmMain.FindAction('actfrmChangeOrderList2').Enabled then Exit;
    frmMain.FindAction('actfrmChangeOrderList2').OnExecute(nil);
    frmChangeOrderList := TfrmChangeOrderList(frmMain.FindChildForm('frmChangeOrderList2'));
    SendMessage(frmChangeOrderList.Handle,WM_EXEC_ORDER,0,2);
    PostMessage(frmChangeOrderList.CurOrder.Handle,WM_FILL_DATA,integer(self),1);
  end;
  inherited;
end;

procedure TfrmDemandOrder.FormShow(Sender: TObject);
begin
  inherited;
  PopupMenu1.Items[6].Visible := False;
end;

procedure TfrmDemandOrder.actBatchNoExecute(Sender: TObject);
begin
  //
end;

procedure TfrmDemandOrder.PresentToCalc(Present: integer);
begin
  inherited;
  ShowInfo;
end;

procedure TfrmDemandOrder.edtSHOP_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtSHOP_ID.Text)<>'' then TabSheet.Caption := edtSHOP_ID.Text;
end;

end.
