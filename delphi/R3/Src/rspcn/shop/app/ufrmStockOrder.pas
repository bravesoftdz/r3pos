unit ufrmStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmOrderForm, RzButton, RzPanel, cxTextEdit, cxDropDownEdit,
  cxCalendar, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, StdCtrls, RzLabel, ExtCtrls, RzBmpBtn,
  RzBorder, RzTabs, RzStatus, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, ZBase, Math, Menus, pngimage;

type
  TfrmStockOrder = class(TfrmOrderForm)
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    btnSave: TRzBitBtn;
    btnSPrint: TRzBitBtn;
    btnSPreview: TRzBitBtn;
    btnNew: TRzBitBtn;
    TabSheet2: TRzTabSheet;
    edtCLIENT_ID: TzrComboBoxList;
    edtREMARK: TcxTextEdit;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    edtSTOCK_DATE: TcxDateEdit;
    RzPanel8: TRzPanel;
    edtGUIDE_USER: TzrComboBoxList;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    h11: TLabel;
    Label21: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    customerInfo: TLabel;
    RzPanel11: TRzPanel;
    RzPanel13: TRzPanel;
    RzPanel14: TRzPanel;
    zrComboBoxList1: TzrComboBoxList;
    cxComboBox1: TcxComboBox;
    RzPanel15: TRzPanel;
    serachText: TEdit;
    RzPanel16: TRzPanel;
    dateFlag: TcxComboBox;
    Label8: TLabel;
    btnFind: TRzBitBtn;
    DBGridEh2: TDBGridEh;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    Label9: TLabel;
    dsList: TDataSource;
    cdsList: TZQuery;
    rowToolNav: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzToolButton3: TRzToolButton;
    RzSpacer1: TRzSpacer;
    RzToolButton4: TRzToolButton;
    procedure edtTableAfterPost(DataSet: TDataSet);
    procedure DBGridEh1Columns1BeforeShowControl(Sender: TObject);
    procedure DBGridEh1Columns5UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
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
    procedure DBGridEh1Columns8UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
  private
    { Private declarations }
    AObj:TRecord_;
    //默认发票类型
    DefInvFlag:integer;
    //普通税率
    InRate2:Currency;
    //增值税率
    InRate3:Currency;
    //结算金额
    TotalFee:Currency;
    //结算数量
    TotalAmt:Currency;
  protected
    procedure SetdbState(const Value: TDataSetState);override;
    procedure SetinputFlag(const Value: integer);override;
    procedure Calc; //2011.06.09判断是否限量
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;

    //快捷健
    function doShortCut(s:string):boolean;override;
    procedure DoIsPresent(s:string);
    procedure DoCustId(s:string);
    procedure DoGuideUser(s:string);
    procedure DoNewOrder;
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
  frmStockOrder: TfrmStockOrder;

implementation
uses utokenFactory,udllDsUtil,udllShopUtil,udllFnUtil, udllGlobal, udataFactory;
{$R *.dfm}

{ TfrmSaleOrder }

procedure TfrmStockOrder.Calc;
var
  r:integer;
  TotalFee:real;
  TotalAmt:real;
  Controls:boolean;
begin
  Controls := edtTable.ControlsDisabled;
  edtTable.DisableControls;
  try
    r := edtTable.FieldbyName('SEQNO').AsInteger;
    TotalFee := 0;
    edtTable.First;
    while not edtTable.Eof do
      begin
        TotalFee := TotalFee + edtTable.FieldbyName('CALC_MONEY').AsFloat;
        TotalAmt := TotalAmt + edtTable.FieldbyName('AMOUNT').AsFloat;
        edtTable.Next;
      end;
  finally
    edtTable.Locate('SEQNO',r,[]); 
    if not Controls then edtTable.EnableControls;
  end;
end;

procedure TfrmStockOrder.CancelOrder;
begin
  if dbState = dsBrowse then Exit;
  if dbState = dsInsert then
     NewOrder
  else
     Open(AObj.FieldbyName('STOCK_ID').AsString);
end;

constructor TfrmStockOrder.Create(AOwner: TComponent);
begin
  inherited;
  AObj := TRecord_.Create;
end;

procedure TfrmStockOrder.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  dataFactory.BeginBatch;
  try
    dataFactory.AddBatch(cdsHeader,'TStockOrderV60');
    dataFactory.AddBatch(cdsDetail,'TStockDataV60');
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  AObj.ReadFromDataSet(cdsHeader);
  ReadFromObject(AObj,self);
  ReadFrom(cdsDetail);
  dbState := dsBrowse;
end;

destructor TfrmStockOrder.Destroy;
begin
  AObj.Free;
  inherited;
end;

procedure TfrmStockOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if cdsHeader.FieldByName('FROM_ID').AsString<>'' then Raise Exception.Create('当前版本不能处理从进货订单入库的单据。');  
  if cdsHeader.FieldByName('FIG_ID').AsString<>'' then Raise Exception.Create('当前版本不能处理从配货单生成的单据。');  
  dbState := dsEdit;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus
  else
  if edtCLIENT_ID.CanFocus and Visible then
     edtCLIENT_ID.SetFocus;
end;

procedure TfrmStockOrder.NewOrder;
var
  rs:TZQuery;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  AObj.FieldbyName('TENANT_ID').AsString := token.tenantId;
  AObj.FieldbyName('SHOP_ID').asString := token.shopId;

  AObj.FieldbyName('DEPT_ID').asString := dllGlobal.getMyDeptId;

  AObj.FieldbyName('STOCK_ID').asString := TSequence.NewId();
  edtCLIENT_ID.KeyValue := token.tenantId;
  edtCLIENT_ID.Text := token.tenantName;

  AObj.FieldByName('STOCK_AMT').AsFloat := 0;
  AObj.FieldByName('STOCK_MNY').AsFloat := 0;

  edtSTOCK_DATE.Date := dllGlobal.SysDate;

  edtGUIDE_USER.KeyValue := token.userId;
  edtGUIDE_USER.Text := token.username;

  AObj.FieldbyName('INVOICE_FLAG').AsInteger := DefInvFlag;
  case DefInvFlag of
  1: AObj.FieldbyName('TAX_RATE').AsFloat := 0;
  2: AObj.FieldbyName('TAX_RATE').AsFloat := InRate2;
  3: AObj.FieldbyName('TAX_RATE').AsFloat := InRate3;
  end;
  InitRecord;
  if edtInput.CanFocus and Visible then
     edtInput.SetFocus
  else
  if edtCLIENT_ID.CanFocus and Visible then
     edtCLIENT_ID.SetFocus;
end;

procedure TfrmStockOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
    Params.ParamByName('STOCK_ID').asString := id;
    Params.ParamByName('VIW_GOODSINFO').AsString := dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE',true);
    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsHeader,'TStockOrderV60',Params);
      dataFactory.AddBatch(cdsDetail,'TStockDataV60',Params);
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
  finally
    Params.Free;
  end;
end;

procedure TfrmStockOrder.SaveOrder;
var
  Printed:boolean;
begin
  if dbState = dsBrowse then Exit;

  if edtSTOCK_DATE.EditValue = null then Raise Exception.Create('进货日期不能为空');

  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('不能保存一张空单据...');
  CheckInvaid;
  WriteToObject(AObj,self);

  AObj.FieldByName('STOCK_TYPE').AsInteger := 1;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
  AObj.FieldByName('CREA_USER').AsString := token.userId;
  AObj.FieldbyName('CHK_DATE').AsString := formatdatetime('YYYY-MM-DD',date());
  AObj.FieldByName('CHK_USER').AsString := token.userId;
  AObj.FieldByName('LOCUS_STATUS').AsString := '3';

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
         cdsDetail.FieldByName('STOCK_ID').AsString := cdsHeader.FieldbyName('STOCK_ID').AsString;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    dataFactory.AddBatch(cdsHeader,'TStockOrderV60');
    dataFactory.AddBatch(cdsDetail,'TStockDataV60');
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  Open(AObj.FieldbyName('STOCK_ID').AsString);
  dbState := dsBrowse;
end;

procedure TfrmStockOrder.edtTableAfterPost(DataSet: TDataSet);
begin
  inherited;
  if not edtTable.ControlsDisabled then Calc;

end;

procedure TfrmStockOrder.showForm;
begin
  inherited;
  InRate2 := StrtoFloatDef(dllGlobal.GetParameter('IN_RATE2'),0.05);
  InRate3 := StrtoFloatDef(dllGlobal.GetParameter('IN_RATE3'),0.17);
  DefInvFlag := StrtoIntDef(dllGlobal.GetParameter('IN_INV_FLAG'),1);

  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');
  edtGUIDE_USER.DataSet := dllGlobal.GetZQueryFromName('CA_USERS');
  NewOrder;
end;

procedure TfrmStockOrder.DBGridEh1Columns1BeforeShowControl(
  Sender: TObject);
begin
  inherited;
  fndGODS_ID.Text := edtTable.FieldbyName('GODS_NAME').AsString;
  fndGODS_ID.KeyValue := edtTable.FieldbyName('GODS_ID').AsString;
  fndGODS_ID.SaveStatus;

end;

procedure TfrmStockOrder.DBGridEh1Columns5UpdateData(Sender: TObject;
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

procedure TfrmStockOrder.DBGridEh1Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
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
  PriceToCalc(r);
end;

procedure TfrmStockOrder.btnSaveClick(Sender: TObject);
begin
  inherited;
  case dbState of
  dsBrowse:begin
      NewOrder;
    end;
  else
    begin
      SaveOrder;
      if dllGlobal.GetChkRight('12400001',2) and (MessageBox(Handle,'是否继续新增进货单？',pchar(Application.Title),MB_YESNO+MB_ICONINFORMATION)=6) then
         NewOrder;
    end;
  end;
end;

procedure TfrmStockOrder.InitPrice(GODS_ID, UNIT_ID: string);
begin
  edtTable.FieldbyName('APRICE').AsFloat :=dllGlobal.GetNewInPrice(GODS_ID,UNIT_ID);
  edtTable.FieldbyName('ORG_PRICE').AsFloat :=dllGlobal.GetNewOutPrice(GODS_ID,UNIT_ID);
end;

procedure TfrmStockOrder.SetinputFlag(const Value: integer);
begin
  inherited;
  case Value of
  6:begin
      FInputFlag := value;
      lblInput.Caption := '供 应 商';
      lblHint.Caption := '请输入完整的"供应商编码或手机号"后按回车';
    end;
  7:begin
      FInputFlag := value;
      lblInput.Caption := '收 货 员';
      lblHint.Caption := '请输入收货员员工编号后按回车';
    end;
  11:begin
      FInputFlag := value;
      lblInput.Caption := '结算金额';
      lblHint.Caption := '请直接输入结算金额后按回车健';
    end;
  end;
end;

procedure TfrmStockOrder.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F5 then
     begin
       DoIsPresent('2');
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
  if Key = VK_F11 then
     begin
       inputMode := 1;
       inputFlag := 11;
       edtInput.SetFocus;
     end;
end;

procedure TfrmStockOrder.DoCustId(s:string);
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text :=
      'select CLIENT_ID,CLIENT_NAME from VIW_CLIENTINFO where TENANT_ID='+token.tenantId+' and (TELEPHONE2='''+s+''' or CLIENT_CODE='''+s+''') and COMM not in (''02'',''12'')';
    dllGlobal.OpenSqlite(rs);
    if rs.IsEmpty then Raise Exception.Create('你输入的供应商编号无效');  
    edtCLIENT_ID.KeyValue := rs.FieldbyName('CLIENT_ID').AsString;
    edtCLIENT_ID.Text := rs.FieldbyName('CLIENT_NAME').AsString;
  finally
    rs.free;
  end;
end;

procedure TfrmStockOrder.DoGuideUser(s:string);
var
  rs:TZQuery;
begin
  rs := dllGlobal.GetZQueryFromName('CA_USERS');
  if rs.Locate('ACCOUNT',s,[]) then
     begin
       edtGUIDE_USER.KeyValue := rs.FieldbyName('USER_ID').AsString;
       edtGUIDE_USER.Text := rs.FieldbyName('USER_NAME').AsString;
     end;
end;

procedure TfrmStockOrder.DoIsPresent(s:string);
begin
  if s='1' then
     PresentToCalc(0)
  else
  if s='2' then
     PresentToCalc(1)
  else
     Raise Exception.Create('不支持的销售类型，请输入1-3之间的类型序号');
end;

procedure TfrmStockOrder.DoNewOrder;
begin
  if MessageBox(Handle,'是否清除当前输入的所有商品?','友情提示..',MB_YESNO+MB_ICONQUESTION)=6 then
     NewOrder;
end;

procedure TfrmStockOrder.DoSaveOrder;
begin
  SaveOrder;
  NewOrder;
end;

function TfrmStockOrder.doShortCut(s: string): boolean;
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
  else
    result := false;
  end;
end;

procedure TfrmStockOrder.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if char(Key) = '+' then 
     begin
       key := #0;
       DoSaveOrder;
     end;
end;

procedure TfrmStockOrder.btnNavClick(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
  0:PageControl.ActivePageIndex := 1;
  1:PageControl.ActivePageIndex := 0;
  end;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  case Value of
  dsBrowse:begin
       btnSave.Caption := '新增进货单';
       btnNew.Caption := '删除';
     end;
  else
     begin
       btnSave.Caption := '保存并新增';
       btnNew.Caption := '清空';
     end;
  end;
  if not cdsHeader.IsEmpty then
end;

procedure TfrmStockOrder.OpenList;
begin
  cdsList.Close;
  cdsList.SQL.Text := 'select A.STOCK_ID,A.GLIDE_NO,A.STOCK_DATE,B.CLIENT_NAME,A.STOCK_MNY,C.USER_NAME as GUIDE_USER_TEXT,A.REMARK '+
    'from STK_STOCKORDER A '+
    'left outer join VIW_CUSTOMER B on A.TENANT_ID=B.TENANT_ID and A.CLIENT_ID=B.CLIENT_ID '+
    'left outer join VIW_USERS C on A.TENANT_ID=C.TENANT_ID and A.GUIDE_USER=C.USER_ID '+
    'where A.TENANT_ID=:TENANT_ID and A.STOCK_DATE>=:D1 and A.STOCK_DATE<=:D2 and A.STOCK_TYPE=4 ';
  if trim(serachText.Text)<>'' then
    cdsList.SQL.Text := 'select j.* from ('+cdsList.SQL.Text+') j where CLIENT_NAME like ''%'+trim(serachText.Text)+'%'' or REMARK like ''%'+trim(serachText.Text)+'%'' or GLIDE_NO like ''%'+trim(serachText.Text)+'%''';
  cdsList.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
  cdsList.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
  cdsList.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  dataFactory.Open(cdsList); 
end;

procedure TfrmStockOrder.dateFlagPropertiesChange(Sender: TObject);
begin
  inherited;
  case dateFlag.ItemIndex of
  0:begin
      D1.Date := date();
      D2.Date := date();
      D1.Properties.ReadOnly := true;
      D2.Properties.ReadOnly := true;
    end;
  1:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYYMM01',date));
      D2.Date := date();
      D1.Properties.ReadOnly := true;
      D2.Properties.ReadOnly := true;
    end;
  2:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYY0101',date));
      D2.Date := date();
      D1.Properties.ReadOnly := true;
      D2.Properties.ReadOnly := true;
    end;
  else
    begin
      D1.Date := date();
      D2.Date := date();
      D1.Properties.ReadOnly := false;
      D2.Properties.ReadOnly := false;
    end;
  end;
end;

procedure TfrmStockOrder.FormCreate(Sender: TObject);
begin
  inherited;
  dateFlag.ItemIndex := 1;
end;

procedure TfrmStockOrder.btnFindClick(Sender: TObject);
begin
  inherited;
  OpenList;
end;

procedure TfrmStockOrder.DBGridEh2DblClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('STOCK_ID').AsString);
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.DBGridEh2DrawColumnCell(Sender: TObject;
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
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+11,ARect.Top+11,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
       end
    else
       DBGridEh2.Canvas.Brush.Color := clAqua;
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

procedure TfrmStockOrder.RzToolButton2Click(Sender: TObject);
begin
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('STOCK_ID').AsString);
  EditOrder;
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
end;

procedure TfrmStockOrder.RzToolButton3Click(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  open(cdsList.FieldbyName('STOCK_ID').AsString);
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);

end;

procedure TfrmStockOrder.RzToolButton1Click(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if messageBox(handle,'是否删除当前进货单？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  open(cdsList.FieldbyName('STOCK_ID').AsString);
  DeleteOrder;
  
end;

procedure TfrmStockOrder.btnNewClick(Sender: TObject);
begin
  if dbState = dsBrowse then
     begin
        if messageBox(handle,'是否删除当前进货单？','友情提示..',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
        open(cdsList.FieldbyName('STOCK_ID').AsString);
        DeleteOrder;
     end
  else
     begin
        NewOrder;
     end;
     
end;

procedure TfrmStockOrder.DBGridEh1Columns8UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:real;
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
  if abs(r)>100 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
  AgioToCalc(r);
end;

initialization
  RegisterClass(TfrmStockOrder);
finalization
  UnRegisterClass(TfrmStockOrder);
end.
