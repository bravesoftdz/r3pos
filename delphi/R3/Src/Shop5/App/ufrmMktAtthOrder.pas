unit ufrmMktAtthOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ZAbstractRODataset, ZAbstractDataset, ZBase,
  ZDataset, Menus, ActnList, cxDropDownEdit, cxTextEdit, cxControls, RzTabs,
  RzButton, cxCalendar, cxContainer, cxEdit, cxMaskEdit, ObjCommon, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, StdCtrls, RzPanel, RzLabel;

type
  TfrmMktAtthOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label40: TLabel;
    Label3: TLabel;
    edtCLIENT_ID: TzrComboBoxList;
    edtREQU_DATE: TcxDateEdit;
    edtREMARK: TcxTextEdit;
    edtREQU_TYPE: TcxComboBox;
    edtREQU_USER: TzrComboBoxList;
    edtSHOP_ID: TzrComboBoxList;
    edtDEPT_ID: TzrComboBoxList;
    RzBitBtn1: TRzBitBtn;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    Label8: TLabel;
    edtCHK_DATE: TcxTextEdit;
    Label9: TLabel;
    edtCHK_USER_TEXT: TcxTextEdit;
    N3: TMenuItem;
    N4: TMenuItem;
    RzLabel3: TRzLabel;
    edtSUM_MNY: TcxTextEdit;
    edtREQU_ID_TEXT: TcxButtonEdit;
    Label21: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    edtKPI_MNY: TcxTextEdit;
    edtBUDG_MNY: TcxTextEdit;
    edtAGIO_MNY: TcxTextEdit;
    edtOTHR_MNY: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCLIENT_IDPropertiesChange(Sender: TObject);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns7UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns8UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns9UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure N4Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtREQU_ID_TEXTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    { Private declarations }
    SKpiMny,SBudgMny,SAgioMny,SOthrMny:Real;
    DKpiMny,DBudgMny,DAgioMny,DOthrMny:Real;    
    FromId:String;
    //进位法则
    CarryRule:integer;
    //保留小数位
    Deci:integer;    
    AddRow:Boolean;
    procedure SetdbState(const Value: TDataSetState);override;
    function GetIsNull: boolean;
  protected
    procedure WMFillData(var Message: TMessage); message WM_FILL_DATA;
  public
    { Public declarations }
    locked:boolean;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure AuditOrder;override;
    procedure Open(id:string);override;
  end;

implementation
uses uGlobal, uCtrlUtil,uShopGlobal, uShopUtil, uFnUtil, ufrmBasic, ufrmMain,
uDsUtil, uXDictFactory, ufrmGoodsInfo, ufrmFindRequOrder, ufrmSalIndentOrderList,
ufrmSalIndentOrder;

{$R *.dfm}

{ TfrmMktRequOrder1 }

procedure TfrmMktAtthOrder.AuditOrder;
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
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前费用申领单执行弃审');
       if MessageBox(Handle,'确认弃审当前费用申领单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前费用申领单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('ATTH_ID').asString := cdsHeader.FieldbyName('ATTH_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TMktAtthOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TMktAtthOrderUnAudit',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);

  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
  Open(oid);
end;

procedure TfrmMktAtthOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmMktAtthOrder.DeleteOrder;
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
    Factor.AddBatch(cdsHeader,'TMktAtthOrder');
    Factor.AddBatch(cdsDetail,'TMktAtthData');
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
    //ReadHeader;

    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('ATTH_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    dbState := dsBrowse;
end;

procedure TfrmMktAtthOrder.EditOrder;
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

function TfrmMktAtthOrder.GetIsNull: boolean;
begin
  ClearInvaid;
  Result := cdsDetail.IsEmpty;
end;

procedure TfrmMktAtthOrder.NewOrder;
var rs:TZQuery;
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
  cid := edtSHOP_ID.KeyValue;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  AObj.FieldbyName('ATTH_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('ATTH_ID').asString;
  gid := '..新增..';
  edtREQU_DATE.Date := Global.SysDate;
  edtREQU_USER.KeyValue := Global.UserID;
  edtREQU_USER.Text := Global.UserName;
  if edtREQU_TYPE.Properties.Items.Count>0 then
  begin
    edtREQU_TYPE.ItemIndex := 0;
    edtREQU_TYPE.Enabled := False;
  end;

  InitRecord;
  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmMktAtthOrder.Open(id: string);
var
  Params:TftParamList;
  SumMny:Real;
begin
  inherited;
  Params := TftParamList.Create(nil);
  locked := true;
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('ATTH_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TMktAtthOrder',Params);
      Factor.AddBatch(cdsDetail,'TMktAtthData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  
    AObj.ReadFromDataSet(cdsHeader);
    SumMny := AObj.FieldByName('KPI_MNY').AsFloat+AObj.FieldByName('BUDG_MNY').AsFloat+AObj.FieldByName('AGIO_MNY').AsFloat+AObj.FieldByName('OTHR_MNY').AsFloat;
    edtSUM_MNY.EditValue := SumMny;
    ReadFromObject(AObj,self);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('ATTH_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    RowID := cdsDetail.RecordCount;

    locked := false;
    ReadFrom(cdsDetail);
  finally
    Params.Free;
  end;
end;

procedure TfrmMktAtthOrder.SaveOrder;
var i:integer;
begin
  inherited;
  Saved := false;
  if edtREQU_DATE.EditValue = null then Raise Exception.Create('填报日期不能为空');
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('供应商不能为空');
  if edtREQU_TYPE.ItemIndex = -1 then Raise Exception.Create('返还类型不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('所属部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create(Label40.Caption+'不能为空');
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  DKpiMny := 0;
  DBudgMny := 0;
  DAgioMny := 0;
  DOthrMny := 0;
  cdsDetail.First;
  while not cdsDetail.Eof do
  begin
    DKpiMny := DKpiMny+cdsDetail.FieldbyName('KPI_MNY').AsFloat;
    DBudgMny := DBudgMny + cdsDetail.FieldbyName('BUDG_MNY').AsFloat;
    DAgioMny := DAgioMny + cdsDetail.FieldbyName('AGIO_MNY').AsFloat;
    DOthrMny := DOthrMny + cdsDetail.FieldbyName('OTHR_MNY').AsFloat;
    cdsDetail.Next;
  end;
  if DKpiMny > SKpiMny then Raise Exception.Create('销售返利分摊金额大于销售返利申领金额!');
  if DBudgMny > SBudgMny then Raise Exception.Create('市场费分摊总金额大于市场费申领金额!');
  if DAgioMny > SAgioMny then Raise Exception.Create('价格支持分摊总金额大于价格支持申领金额!');
  if DOthrMny > SOthrMny then Raise Exception.Create('其它费用分摊总金额大于其它费用申领金额!');

  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := edtSHOP_ID.AsString;
  AObj.FieldByName('REQU_ID').AsString := FromId;
  cid := edtSHOP_ID.asString;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;

  Factor.BeginBatch;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    WriteTo(cdsDetail);
    i := 0;
    cdsDetail.First;
    while not cdsDetail.Eof do
      begin
        Inc(i);
        cdsDetail.Edit;
        cdsDetail.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
        cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
        cdsDetail.FieldByName('ATTH_ID').AsString := cdsHeader.FieldbyName('ATTH_ID').AsString;
        cdsDetail.FieldByName('SEQNO').AsInteger := i;
        cdsDetail.Post;
        cdsDetail.Next;
      end;

    Factor.AddBatch(cdsHeader,'TMktAtthOrder');
    Factor.AddBatch(cdsDetail,'TMktAtthData');
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  Open(oid);
  dbState := dsBrowse;
end;

procedure TfrmMktAtthOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;

end;

procedure TfrmMktAtthOrder.FormCreate(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  //edtCLIENT_ID.RangeField := 'FLAG';
  //edtCLIENT_ID.RangeValue := '3';
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtDEPT_ID.RangeField := 'DEPT_TYPE';
  edtDEPT_ID.RangeValue := '1';
  edtREQU_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  AddCbxPickList(edtREQU_TYPE);
  //进位法则
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //保留小数位
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);  
  AddRow := True;

end;

procedure TfrmMktAtthOrder.FormDestroy(Sender: TObject);
begin
  ClearCbxPickList(edtREQU_TYPE);
  inherited;
end;

procedure TfrmMktAtthOrder.edtCLIENT_IDPropertiesChange(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)<>'' then TabSheet.Caption := edtCLIENT_ID.Text;
end;

procedure TfrmMktAtthOrder.fndGODS_IDSaveValue(Sender: TObject);
begin
  if edtCLIENT_ID.AsString = '' then
     begin
       MessageBox(Handle,'请先选择客户后再录单。','友情提示...',MB_OK+MB_ICONINFORMATION);
       edtCLIENT_ID.SetFocus;
       Exit;
     end;
  if (fndGODS_ID.AsString='') and fndGODS_ID.Focused and ShopGlobal.GetChkRight('32600001',2) then
     begin
       if MessageBox(Handle,'没找到你想查找的商品是否新增一个？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
       fndStr := fndGODS_ID.Text;
       fndGODS_ID.OnAddClick(nil);
       Exit;
     end;
  inherited;
end;

procedure TfrmMktAtthOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
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
     end;
end;

procedure TfrmMktAtthOrder.DBGridEh1Columns7UpdateData(Sender: TObject;
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
     end;
end;

procedure TfrmMktAtthOrder.DBGridEh1Columns8UpdateData(Sender: TObject;
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
     end;
end;

procedure TfrmMktAtthOrder.DBGridEh1Columns9UpdateData(Sender: TObject;
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
     end;
end;

procedure TfrmMktAtthOrder.N4Click(Sender: TObject);
 function CheckRequOrderID: Boolean;
 var Rs: TZQuery;
 begin
   result:=False;
   try
     Rs:=TZQuery.Create(nil);
     Rs.SQL.Text:='select count(*) as ReSum from SAL_INDENTORDER where ATTH_ID='''+'REQ'+AObj.FieldByName('ATTH_ID').AsString+''' ';
     Factor.Open(Rs);
     if Rs.Active and (Rs.FieldByName('ReSum').AsInteger>0) then
       Result:=True;
   finally
     Rs.Free;
   end;
 end;
var
  frmSalIndentOrderList: TfrmSalIndentOrderList;
begin
  if dbState <> dsBrowse then Raise Exception.Create('   请保存单据后再操作。   ');
  if not IsAudit then Raise Exception.Create('  没有审核的单据不能生成销售订单...  ');
  if CheckRequOrderID then Raise Exception.Create('  本单据已经生成，不能重复生成...  ');
  if not frmMain.FindAction('actfrmSalIndentOrderList').Enabled then Exit;
  frmMain.FindAction('actfrmSalIndentOrderList').OnExecute(nil);
  frmSalIndentOrderList := TfrmSalIndentOrderList(frmMain.FindChildForm(TfrmSalIndentOrderList));
  SendMessage(frmSalIndentOrderList.Handle,WM_EXEC_ORDER,0,2);
  PostMessage(frmSalIndentOrderList.CurOrder.Handle,WM_FILL_DATA,integer(self),0);
end;

procedure TfrmMktAtthOrder.PopupMenu1Popup(Sender: TObject);
begin
  inherited;
  N4.Enabled:=(dbState=dsBrowse);
end;

procedure TfrmMktAtthOrder.WMFillData(var Message: TMessage);
var frmSalIndetOrder:TfrmSalIndentOrder;
begin
  //if dbState <> dsBrowse then Raise Exception.Create('不是在浏览状态不能完成操作');
  frmSalIndetOrder := TfrmSalIndentOrder(Message.WParam);

  Open(copy(frmSalIndetOrder.AObj.FieldByName('ATTH_ID').AsString,4,36));

end;

procedure TfrmMktAtthOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
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

procedure TfrmMktAtthOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs,bs:TZQuery;
  Params:TftParamList;
  str,OutLevel:string;
begin
  rs := TZQuery.Create(nil);
  bs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not bs.Locate('GODS_ID',GODS_ID,[]) then Raise Exception.Create('缓冲数据集中没找到当前商品...');  
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
    //edtTable.FieldbyName('ORG_PRICE').AsFloat := rs.FieldbyName('V_ORG_PRICE').AsFloat;
    //edtTable.FieldbyName('COST_PRICE').AsFloat := GetCostPrice(edtSHOP_ID.AsString,GODS_ID,edtTable.FieldbyName('BATCH_NO').AsString);
    //edtTable.FieldByName('POLICY_TYPE').AsInteger := rs.FieldbyName('V_POLICY_TYPE').AsInteger;
    //edtTable.FieldByName('HAS_INTEGRAL').AsInteger := rs.FieldbyName('V_HAS_INTEGRAL').AsInteger;
    //看是否换购商品
    if bs.FieldByName('USING_BARTER').AsInteger=3 then
       begin
         edtTable.FieldByName('IS_PRESENT').AsInteger := 2;
         //edtTable.FieldByName('BARTER_INTEGRAL').AsInteger := bs.FieldbyName('BARTER_INTEGRAL').AsInteger;
       end
    else
       begin
         edtTable.FieldByName('IS_PRESENT').AsInteger := 0;
         //edtTable.FieldByName('BARTER_INTEGRAL').AsInteger := 0;
       end;
  finally
    Params.Free;
    rs.Free;
  end;
end;

procedure TfrmMktAtthOrder.edtREQU_ID_TEXTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var g,uid,utext:string;
    rs:TZQuery;
begin
  if dbState = dsBrowse then Exit;
  if edtCLIENT_ID.AsString = '' then
     begin
       MessageBox(Handle,'请先选择经销商后再录单.','友情提示...',MB_OK+MB_ICONINFORMATION);
       edtCLIENT_ID.SetFocus;
       Exit;
     end;
  inherited;
  FromId := TfrmFindRequOrder.FindDialog(self,edtCLIENT_ID.asString,g,uid,utext);
  if FromId<>'' then
     begin
       rs := TZQuery.Create(nil);
       try
         rs.Close;
         rs.SQL.Text := 'select KPI_MNY,BUDG_VRF,AGIO_MNY,OTHR_MNY from MKT_REQUORDER where TENANT_ID=:TENANT_ID and REQU_ID=:REQU_ID ';
         rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
         rs.ParamByName('REQU_ID').AsString := FromId;
         Factor.Open(rs);
         SKpiMny := rs.FieldByName('KPI_MNY').AsFloat;
         edtKPI_MNY.EditValue := SKpiMny;
         SBudgMny := rs.FieldByName('BUDG_VRF').AsFloat;
         edtBUDG_MNY.EditValue := SBudgMny;
         SAgioMny := rs.FieldByName('AGIO_MNY').AsFloat;
         edtAGIO_MNY.EditValue := SAgioMny;
         SOthrMny := rs.FieldByName('OTHR_MNY').AsFloat;
         edtOTHR_MNY.EditValue := SOthrMny;
         edtSUM_MNY.EditValue := SKpiMny+SBudgMny+SAgioMny+SOthrMny;
         edtREQU_ID_TEXT.Text := g;
         edtREQU_USER.KeyValue := uid;
         edtREQU_USER.Text := utext;
       finally
         rs.Free;
       end;
     end;

end;

end.
