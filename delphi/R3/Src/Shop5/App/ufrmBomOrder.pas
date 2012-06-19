unit ufrmBomOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, zBase, cxSpinEdit, RzButton, cxListBox,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, RzLabel, DBGrids;

type
  TfrmBomOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    lblCLIENT_ID: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    edtBOM_DATE: TcxDateEdit;
    edtBARCODE: TcxTextEdit;
    actPrintBarcode: TAction;
    N1: TMenuItem;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    N2: TMenuItem;
    Label3: TLabel;
    edtGIFT_CODE: TcxTextEdit;
    edtGIFT_NAME: TcxTextEdit;
    edtBOM_USER: TzrComboBoxList;
    Label1: TLabel;
    edtREMARK: TcxTextEdit;
    Label8: TLabel;
    edtSALS_AMOUNT: TcxTextEdit;
    Label4: TLabel;
    edtRCK_AMOUNT: TcxTextEdit;
    edtCHK_USER_TEXT: TcxTextEdit;
    Label7: TLabel;
    Label10: TLabel;
    edtCHK_DATE: TcxTextEdit;
    edtSHOP_ID: TzrComboBoxList;
    Label40: TLabel;
    RzLabel4: TRzLabel;
    edtBOM_TYPE: TcxComboBox;
    RzLabel1: TRzLabel;
    edtBOM_STATUS: TcxComboBox;
    edtBOM_AMOUNT: TcxTextEdit;
    edtRTL_PRICE: TcxTextEdit;
    Label6: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    edtGODS_IDS: TzrComboBoxList;
    LabelBOM_STATUS: TLabel;
    Label12: TLabel;
    edtHAS_INTEGRAL: TcxComboBox;
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns7UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure actPrintBarcodeExecute(Sender: TObject);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure fndGODS_IDAddClick(Sender: TObject);
    procedure edtBOM_USERAddClick(Sender: TObject);
    procedure edtTableAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure edtBOM_AMOUNTPropertiesChange(Sender: TObject);
    procedure edtBOM_TYPEPropertiesChange(Sender: TObject);
    procedure edtGODS_IDSSaveValue(Sender: TObject);
    procedure edtBOM_STATUSPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    //结算金额
    TotalFee:real;
    //默认发票类型
    DefInvFlag:integer;
    //普通税率
    InRate2:real;
    //增值税率
    InRate3:real;
    procedure ReadHeader;
    function CheckInput:boolean;override;
    function  CheckCanExport: boolean; override;
    function  IsChinese(str:string):Boolean;
  public
    { Public declarations }
    procedure CheckInvaid;override;
    procedure ShowInfo;
    procedure ShowOweInfo;
    function  Calc:real;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure AmountToCalc(Amount:Real);override;
    procedure PriceToCalc(APrice:Real);override;
    procedure AMoneyToCalc(AMoney:Real);override;
    procedure AgioToCalc(Agio:Real);override;
    procedure UnitToCalc(UNIT_ID:string);override;
    procedure PresentToCalc(Present:integer);override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure AuditOrder;override;
    procedure Open(id:string);override;
    //JP_add
    procedure RTLMoneyToSumPrice;

  end;

implementation
uses uGlobal,uShopUtil,uDsUtil,uFnUtil,uShopGlobal,ufrmSupplierInfo, ufrmGoodsInfo, ufrmUsersInfo,ufrmStockOrderList
  ;
{$R *.dfm}

procedure TfrmBomOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmBomOrder.DeleteOrder;
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
    Factor.AddBatch(cdsHeader,'TBomOrder');
    Factor.AddBatch(cdsDetail,'TBomData');
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
    oid := AObj.FieldbyName('BOM_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    dbState := dsBrowse;
    ShowOweInfo;
end;

procedure TfrmBomOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改'); 
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;
  //JP_???修改数量
  //edtBOM_AMOUNT.Properties.ReadOnly :=false;
end;

procedure TfrmBomOrder.FormCreate(Sender: TObject);
begin
  inherited;
  CanAppend := true;
  edtGODS_IDS.DataSet := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtBOM_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  //JP_???
  edtDEPT_ID.RangeField := 'DEPT_TYPE';
  edtDEPT_ID.RangeValue := '1';
end;

procedure TfrmBomOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs:TZQuery;
  str,InLevel:string;
begin
  rs := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not rs.Locate('GODS_ID',edtTable.FieldByName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到“'+edtTable.FieldbyName('GODS_NAME').AsString+'”');
  edtTable.Edit;
  if UNIT_ID=rs.FieldbyName('SMALL_UNITS').AsString then
  begin
     //edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_INPRICE1').AsFloat;
     edtTable.FieldbyName('RTL_PRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE1').AsFloat;
  end
  else
  if UNIT_ID=rs.FieldbyName('BIG_UNITS').AsString then
  begin
     //edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_INPRICE2').AsFloat;
     edtTable.FieldbyName('RTL_PRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE2').AsFloat;
  end
  else
  begin
     //edtTable.FieldbyName('APRICE').AsFloat :=rs.FieldbyName('NEW_INPRICE').AsFloat;
     edtTable.FieldbyName('RTL_PRICE').AsFloat :=rs.FieldbyName('NEW_OUTPRICE').AsFloat;
  end;
  edtTable.FieldbyName('IS_PRESENT').AsInteger := 0;
  //edtTable.FieldbyName('AMOUNT').AsFloat := 1;
  ShowInfo;
end;

procedure TfrmBomOrder.NewOrder;
var
  rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  AObj.FieldbyName('BOM_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('BOM_ID').asString;
  gid := '..新增..';
  edtBOM_DATE.Date := Global.SysDate;
  edtBOM_USER.KeyValue := Global.UserID;
  edtBOM_USER.Text := Global.UserName;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  edtBOM_TYPE.ItemIndex := 0;
  //edtBOM_STATUS.Caption:='启用';
  edtBOM_STATUS.Properties.ReadOnly := false;
  edtBOM_STATUS.ItemIndex := 0;
  edtBOM_STATUS.Properties.ReadOnly := true;
  edtBOM_AMOUNT.Text :='1';
  edtRCK_AMOUNT.Text :='1';
  edtBARCODE.Text :='自编条码';
  edtGIFT_CODE.Text :='自动编号';
  edtHAS_INTEGRAL.ItemIndex := 1;
  //
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;

  InitRecord;
  TabSheet.Caption := '..新建..';
end;

procedure TfrmBomOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').AsString := cid;
    Params.ParamByName('BOM_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TBomOrder',Params);
      Factor.AddBatch(cdsDetail,'TBomData',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    dbState := dsBrowse;  //2011.04.02 提到ReadFromObject之前
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    ReadHeader;

    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('BOM_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    cid := AObj.FieldbyName('SHOP_ID').AsString;
    ShowOweInfo;
  finally
    Params.Free;
  end;
end;

procedure TfrmBomOrder.SaveOrder;
var mny,amt:real;
    BARCODE_ID:string;
begin
  inherited;
  Saved := false;
  if edtBOM_DATE.EditValue = null then Raise Exception.Create('包装日期不能为空');
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  if trim(edtDEPT_ID.AsString) = '' then Raise Exception.Create('所属部门不能为空');
  if trim(edtGIFT_NAME.text) = '' then Raise Exception.Create('礼盒名称不能为空');
  if edtBOM_TYPE.ItemIndex<0 then Raise Exception.Create('礼盒类型不能为空'); 
  if TRecord_(edtBOM_TYPE.Properties.Items.Objects[edtBOM_TYPE.ItemIndex]).FieldByName('CODE_ID').AsString='2' then Raise Exception.Create('暂不支持整装礼盒'); 
  //JP_Add
  if dbState = dsInsert then
  begin
    if (trim(edtGIFT_CODE.Text)='自动编号') or (trim(edtGIFT_CODE.Text)='') or (IsChinese(trim(edtGIFT_CODE.Text))) then
    begin
      edtGIFT_CODE.Text:=TSequence.GetSequence('GODS_CODE',InttoStr(ShopGlobal.TENANT_ID),'',6);  //企业内码ID
      AObj.FieldbyName('GIFT_CODE').AsString :=edtGIFT_CODE.Text;  //企业内码ID
    end else
      AObj.FieldbyName('GIFT_CODE').AsString:=trim(edtGIFT_CODE.Text);

    if (edtBARCODE.Text = '自编条码') or (trim(edtBARCODE.Text)='') or (IsChinese(trim(edtBARCODE.Text))) then
    begin
      BARCODE_ID:=TSequence.GetSequence('BARCODE_ID',InttoStr(ShopGlobal.TENANT_ID),'',6);
      edtBARCODE.Text := GetBarCode(BARCODE_ID,'#','#');
      AObj.FieldbyName('BARCODE').AsString :=edtBARCODE.Text;
    end else
      AObj.FieldbyName('BARCODE').AsString:=trim(edtBARCODE.Text);

  end;



  WriteToObject(AObj,self);
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  AObj.FieldbyName('SHOP_ID').AsString := Global.SHOP_ID;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  Calc;
  Factor.BeginBatch;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    WriteTo(cdsDetail);
    mny := 0;
    amt := 0;
    cdsDetail.First;
    while not cdsDetail.Eof do
       begin
         cdsDetail.Edit;
         cdsDetail.FieldByName('TENANT_ID').AsString := cdsHeader.FieldbyName('TENANT_ID').AsString;
         cdsDetail.FieldByName('SHOP_ID').AsString := cdsHeader.FieldbyName('SHOP_ID').AsString;
         cdsDetail.FieldByName('BOM_ID').AsString := cdsHeader.FieldbyName('BOM_ID').AsString;
         mny := mny + cdsDetail.FieldbyName('RTL_MONEY').asFloat;
         amt := amt + cdsDetail.FieldbyName('AMOUNT').asFloat;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    Factor.AddBatch(cdsHeader,'TBomOrder');
    Factor.AddBatch(cdsDetail,'TBomData');
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

procedure TfrmBomOrder.DBGridEh1Columns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  if edtTable.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;    //JP_???   PropertyEnabled
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
          if abs(r)>999999 then Raise Exception.Create('输入的数值过大，无效');
        except
          Text := TColumnEh(Sender).Field.AsString;
          Value := TColumnEh(Sender).Field.asFloat;
          Raise Exception.Create('输入无效数值型');
        end;
        TColumnEh(Sender).Field.asFloat := r;
        AMountToCalc(r);
     end;
end;

procedure TfrmBomOrder.DBGridEh1Columns7UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:integer;
begin

end;

procedure TfrmBomOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin

  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
    if abs(r)>999999 then Raise Exception.Create('输入的数值过大，无效');
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  TColumnEh(Sender).Field.asFloat := r;
  //AMoneyToCalc(r);
  RTLMoneyToSumPrice;

end;

procedure TfrmBomOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
begin

end;

function TfrmBomOrder.Calc:real;
var
  r:integer;
  TotalFee:real;
  TotalAmt:real;
begin
  edtTable.DisableControls;
  try
    r := edtTable.FieldbyName('SEQNO').AsInteger;
    TotalAmt :=0;
    TotalFee := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        TotalFee := TotalFee + edtTable.FieldbyName('RTL_MONEY').AsFloat;
        TotalAmt := TotalAmt + edtTable.FieldbyName('AMOUNT').AsFloat;
        edtTable.Next;
      end;
    result := TotalFee;
  finally
    edtTable.Locate('SEQNO',r,[]);
    edtTable.EnableControls;
  end;
end;

procedure TfrmBomOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  Calc;

end;

procedure TfrmBomOrder.DBGridEh1Columns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  inherited;
  //JP_????   尺码颜色
  //PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,1);
end;

procedure TfrmBomOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前礼盒执行弃审');
       if MessageBox(Handle,'确认弃审当前礼盒单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前礼盒单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('BOM_ID').asString := cdsHeader.FieldbyName('BOM_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TBomOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TBomOrderUnAudit',Params) ;
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

procedure TfrmBomOrder.actPrintBarcodeExecute(Sender: TObject);
begin
  inherited;
  if IsNull then Raise Exception.Create('请输入商品后，再打印条码');

end;

procedure TfrmBomOrder.fndGODS_IDSaveValue(Sender: TObject);
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

procedure TfrmBomOrder.fndGODS_IDAddClick(Sender: TObject);
var r:TRecord_;
begin
  if not ShopGlobal.GetChkRight('32600001',2) then Exit;
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
                  //edtTable.FieldByName('NEW_OUTAMONEY').AsString:=formatfloat('#0.000',edtTable.FieldbyName('NEW_OUTPRICE').AsFloat*edtTable.FieldbyName('CALC_AMOUNT').AsFloat);
                end
             else    //JP_???
                PostMessage(Handle,WM_DIALOG_PULL,PROPERTY_DIALOG,0);
           end;
       end;
    DBGridEh1.SetFocus;
  finally
    r.Free;
  end;
  
end;

procedure TfrmBomOrder.edtBOM_USERAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;

  r := TRecord_.Create;
  try
    if TfrmUsersInfo.AddDialog(self,r) then
       begin
         edtBom_USER.KeyValue := r.FieldbyName('USER_ID').AsString;
         edtBom_USER.Text := r.FieldbyName('USER_NAME').AsString;
       end;
  finally
    r.Free;
  end;
  
end;

procedure TfrmBomOrder.ReadHeader;
var rcks,boms,sals : Integer;
begin
   if (Trim(edtRCK_AMOUNT.Text) = '' ) then
   begin
      edtRCK_AMOUNT.Text:= edtBOM_AMOUNT.Text;
      edtSALS_AMOUNT.Text:='0';
      exit;
   end;
   try
      if (Trim(edtBOM_AMOUNT.Text) <> '' ) then
      begin
           boms:= StrToInt(Trim(edtBOM_AMOUNT.Text)) ;
           rcks:= StrToInt(Trim(edtRCK_AMOUNT.Text)) ;
           if boms <  rcks then  rcks :=boms;
           edtSALS_AMOUNT.Text:=IntToStr(boms-rcks);
      end;
   finally
   end;

end;

//显示最新库存(Bom单只组合不需要显示库存)
procedure TfrmBomOrder.ShowOweInfo;
begin

end;

//显示最新库存(Bom单只组合不需要显示库存)
procedure TfrmBomOrder.ShowInfo;
begin

end;

procedure TfrmBomOrder.PresentToCalc(Present: integer);
begin
  inherited;
  ShowInfo;

end;

procedure TfrmBomOrder.UnitToCalc(UNIT_ID: string);
var AMount,SourceScale:Real;
    Field:TField;
    rs:TZQuery;
    u:integer;
begin
  inherited;
  if Locked then Exit;
  Locked := True;
  try
     if edtTable.FindField('RTL_PRICE')<>nil then
        begin
           InitPrice(edtTable.FieldByName('GODS_ID').asString,UNIT_ID);
           AMountToCalc(AMount);
        end;
  finally
     Locked := false;
  end;
  ShowInfo;

end;

procedure TfrmBomOrder.edtTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then ShowInfo;

end;

procedure TfrmBomOrder.DBGridEh1CellClick(Column: TColumnEh);
//var  AdoGradePrice:TADODataSet;
//     str:string;
//     Rect:TRect;
begin
  inherited;
{  if dbState=dsBrowse then exit;
  if not edtTable.Active then exit;
  if edtTable.FieldByName('GODS_ID').AsString='' then exit;
  if  (UpperCase(Trim(Column.FieldName)) = 'APRICE')  then
  begin
    cxlGradePrice.Items.Clear;
    AdoGradePrice:=TADODataSet.Create(nil);
    try
      AdoGradePrice.Close;
      str:='select top 1 APRICE from STK_STOCKORDER A,STK_STOCKDATA B '+
      ' where A.INDE_ID=B.INDE_ID and A.STOCK_TYPE=''1'' '+
      ' AND B.GODS_ID='+QuotedStr(edtTable.FieldByName('GODS_ID').AsString)+
      ' AND A.COMP_ID='+QuotedStr(Global.CompanyID)+
      ' AND B.UNIT_ID='+QuotedStr(edtTable.FieldByName('UNIT_ID').AsString);
      if edtCLIENT_ID.AsString<>'' then str:=str+' AND A.CLIENT_ID='+QuotedStr(edtCLIENT_ID.AsString);
      str:=str+' order by  A.STOCK_DATE DESC,A.GLIDE_NO DESC';
      AdoGradePrice.CommandText:=str;
      Factor.Open(AdoGradePrice);
      if not AdoGradePrice.IsEmpty then
        cxlGradePrice.Items.Add('最新进价:'+FloatToStr(strtoFloatdef(AdoGradePrice.Fields[0].AsString,0)));
      AdoGradePrice.Close;
      AdoGradePrice.CommandText:=' select A.CALC_UNITS,A.BIG_UNITS,A.SMALL_UNITS, isnull(B.NEW_INPRICE,0) as NEW_INPRICE,  '+
      ' case when isnull(B.PRICE_FLAG,''1'')=''1'' then A.NEW_OUTPRICE else B.NEW_OUTPRICE end as NEW_OUTPRICE,   '+
      ' case when isnull(B.PRICE_FLAG,''1'')=''1'' then A.NEW_OUTPRICE1 else B.NEW_OUTPRICE1 end as NEW_OUTPRICE1,  '+
      ' case when isnull(B.PRICE_FLAG,''1'')=''1'' then A.NEW_OUTPRICE2 else B.NEW_OUTPRICE2 end as NEW_OUTPRICE2  '+
      ' from PUB_GOODSINFO A   left outer join   '+
      ' (select GODS_ID,NEW_INPRICE,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,PRICE_FLAG '+
      ' from BAS_GOODSINFO where COMP_ID='+QuotedStr(Global.CompanyID)+' and GODS_FLAG=''1'') B on A.GODS_ID=B.GODS_ID '+
      ' where A.GODS_ID= '+QuotedStr(edtTable.FieldByName('GODS_ID').AsString)+
      ' union all '+
      ' select CALC_UNITS,BIG_UNITS,SMALL_UNITS,NEW_INPRICE,NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2'+
      ' from BAS_GOODSINFO where COMP_ID='+QuotedStr(Global.CompanyID)+' and GODS_ID='+QuotedStr(edtTable.FieldByName('GODS_ID').AsString)+' and GODS_FLAG=''2''';
      Factor.Open(AdoGradePrice);
      if not AdoGradePrice.IsEmpty then
      begin
        cxlGradePrice.Items.Add('参考进价:'+FloatToStr(StrToFloatdef(AdoGradePrice.FieldByName('NEW_INPRICE').AsString,0)));
        if edtTable.FieldByName('UNIT_ID').AsString=AdoGradePrice.FieldByName('CALC_UNITS').AsString then
          cxlGradePrice.Items.Add('零售价:'+FloatToStr(StrToFloatdef(AdoGradePrice.FieldByName('NEW_OUTPRICE').AsString,0)));
        if edtTable.FieldByName('UNIT_ID').AsString=AdoGradePrice.FieldByName('BIG_UNITS').AsString then
          cxlGradePrice.Items.Add('零售价:'+FloatToStr(StrToFloatdef(AdoGradePrice.FieldByName('NEW_OUTPRICE2').AsString,0)));
        if edtTable.FieldByName('UNIT_ID').AsString=AdoGradePrice.FieldByName('SMALL_UNITS').AsString then
          cxlGradePrice.Items.Add('零售价:'+FloatToStr(StrToFloatdef(AdoGradePrice.FieldByName('NEW_OUTPRICE1').AsString,0)));
      end;
      if cxlGradePrice.Items.Count>1 then
      begin
        Rect :=DBGridEh1.CellRect(DbGridEh1.Col,DbGridEh1.Row);
        cxlGradePrice.Left := DBGridEh1.Left + Rect.Left;
        cxlGradePrice.Top := DBGridEh1.Top + Rect.Top +16;
        cxlGradePrice.Visible := True;
      end;
    finally
      AdoGradePrice.Free;
    end;
  end
  else       cxlGradePrice.Visible := False;
}
end;

procedure TfrmBomOrder.AmountToCalc(Amount: Real);
begin
  inherited;
  edtTable.Edit;
  edtTable.FieldbyName('RTL_MONEY').AsFloat := edtTable.FieldbyName('AMOUNT').AsFloat*edtTable.FieldbyName('RTL_PRICE').AsFloat;
  RTLMoneyToSumPrice;
end;

procedure TfrmBomOrder.AgioToCalc(Agio: Real);
begin
  inherited;
end;

procedure TfrmBomOrder.AMoneyToCalc(AMoney: Real);
begin
  inherited;
end;

procedure TfrmBomOrder.PriceToCalc(APrice: Real);
begin
  inherited;
end;

procedure TfrmBomOrder.CheckInvaid;
begin
  if edtTable.State in [dsEdit,dsInsert] then edtTable.Post;
//  inherited;

end;

function TfrmBomOrder.CheckInput: boolean;  //JP_???
begin
  result := not (pos(inttostr(InputFlag),'124')>0);
end;

function TfrmBomOrder.CheckCanExport: boolean;
begin   //JP_???
  result:=ShopGlobal.GetChkRight('100002306',7);
end;

procedure TfrmBomOrder.RTLMoneyToSumPrice;
var tmp: TZQuery;
    c:real;
begin
  try
    tmp:=TZQuery.Create(nil);
    tmp.Data:=edtTable.Data;
    c := 0;
    tmp.First;
    while not tmp.Eof do
      begin
        if tmp.FindField('RTL_MONEY')<>nil then
        begin
           c := c +tmp.FieldByName('RTL_MONEY').asFloat;
        end;
        tmp.Next;
      end;
      edtRTL_PRICE.Text := FormatFloat('#0.00',c);
  finally
    tmp.Free;
  end;
  edtTable.Edit;
end;

procedure TfrmBomOrder.edtBOM_AMOUNTPropertiesChange(Sender: TObject);
var rcks,boms,sals : Integer;
begin
  inherited;
  //dbstate     dsEdit dsBrowse  dsInsert
  if not (edtBOM_AMOUNT.Focused) THEN exit;
  try
      if dbstate in [dsEdit, dsInsert] then
      begin
         if (Trim(edtBOM_AMOUNT.Text) <> '' ) then
             boms:= StrToInt(Trim(edtBOM_AMOUNT.Text))
         else
             boms:= 0 ;
         sals:= StrToInt(Trim(edtSALS_AMOUNT.Text)) ;
         if boms <  sals then  raise Exception.CreateFmt('礼盒数量不能低于%d。',[sals]);;
         edtRCK_AMOUNT.Text:=IntToStr(boms-sals);
      end;
  finally
  end;
end;
function TfrmBomOrder.IsChinese(str:string):Boolean;
var i:integer;
begin
  Result:=False;
  for i:=0 to length(str)-1 do
  begin
    if str[i] in LeadBytes then
    begin
      Result:=True;
      Break;
    end;
  end;
end;
procedure TfrmBomOrder.edtBOM_TYPEPropertiesChange(Sender: TObject);
begin
  inherited;
  // 0 '散装礼盒'
  if edtBOM_TYPE.ItemIndex=0 then
  begin
  edtGODS_IDS.Visible := false ;
  edtGIFT_NAME.Visible := true;
  end
  else
  begin
  edtGIFT_NAME.Visible := false;
  edtGODS_IDS.Visible := true;
  end;
  //dbstate
  //
  //showmessage(edtBOM_TYPE.Text+':'+inttostr(edtBOM_TYPE.ItemIndex));
  //fndGODS_ID.AsString
  //fndGODS_ID.Text
  //fndGODS_ID

end;

procedure TfrmBomOrder.edtGODS_IDSSaveValue(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  //showmessage(edtGODS_IDS.Text+':'+edtGODS_IDS.AsString);
  edtGIFT_NAME.Text := edtGODS_IDS.Text;
  try
      rs := Global.GetZQueryFromName('PUB_GOODSINFO');
      if rs.Locate('GODS_ID',edtGODS_IDS.AsString,[]) then
      begin
        edtGIFT_CODE.Text := rs.FieldbyName('GODS_CODE').AsString;
        edtBARCODE.Text := rs.FieldbyName('BARCODE').AsString;
      end;
  finally
  end;
end;

procedure TfrmBomOrder.edtBOM_STATUSPropertiesChange(Sender: TObject);
begin
  inherited;
  LabelBOM_STATUS.Caption :='礼盒状态：'+ edtBOM_STATUS.Text;
  
end;

end.
