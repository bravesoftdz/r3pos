unit ufrmSalInvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxDropDownEdit, cxTextEdit, cxCalendar, cxControls, ZBase,
  cxContainer, cxEdit, cxMaskEdit, cxButtonEdit, zrComboBoxList, StdCtrls,
  Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxCheckBox, RzLabel;

type
  TfrmSalInvoice = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    cdsDetail: TZQuery;
    cdsHeader: TZQuery;
    CdsInvoice: TZQuery;
    RzPanel4: TRzPanel;
    Image1: TImage;
    Label14: TLabel;
    RzPanel1: TRzPanel;
    Label7: TLabel;
    Label17: TLabel;
    edtREMARK: TcxTextEdit;
    edtCLIENT_ID: TzrComboBoxList;
    RzPanel3: TRzPanel;
    RzLabel1: TRzLabel;
    Label6: TLabel;
    edtCREA_DATE: TcxDateEdit;
    RzLabel2: TRzLabel;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel7: TRzPanel;
    edtINVOICE_MNY: TcxTextEdit;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    RzPanel8: TRzPanel;
    RzLabel3: TRzLabel;
    edtCREA_USER: TzrComboBoxList;
    Label3: TLabel;
    edtINVOICE_FLAG: TcxComboBox;
    RzPanel9: TRzPanel;
    Label1: TLabel;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    fndGODS_ID: TzrComboBoxList;
    Label40: TLabel;
    edtSHOP_ID: TzrComboBoxList;
    Label5: TLabel;
    edtDEPT_ID: TzrComboBoxList;
    Label8: TLabel;
    edtADDR_NAME: TcxTextEdit;
    Label9: TLabel;
    edtINVO_NAME: TcxTextEdit;
    Label2: TLabel;
    edtINVH_ID: TzrComboBoxList;
    edtINVOICE_NO: TcxTextEdit;
    Label4: TLabel;
    edtIfDuplicate: TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edtCLIENT_IDSaveValue(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure edtINVH_IDSaveValue(Sender: TObject);
    procedure fndGODS_IDEnter(Sender: TObject);
    procedure fndGODS_IDExit(Sender: TObject);
    procedure fndGODS_IDFindClick(Sender: TObject);
    procedure fndGODS_IDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fndGODS_IDKeyPress(Sender: TObject; var Key: Char);
    procedure fndGODS_IDSaveValue(Sender: TObject);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1Columns4UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure edtINVOICE_FLAGPropertiesChange(Sender: TObject);
  private
    FisAudit: boolean;
    Fcid: string;
    FInvoiceMny: Real;
    FClientId: String;
    FInvoiceId: String;
    FIvioType: String;
    Tax_Rate:Currency;
    InputType:Integer;
    { Private declarations }
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Setcid(const Value: string);
    procedure SetisAudit(const Value: boolean);
    procedure SetClientId(const Value: String);
    procedure SetInvoiceMny(const Value: Real);
    procedure SetInvoiceId(const Value: String);
    function ReadInvoiceNo(Flag:String):String;
    function ReadInvoiceId:String;
    procedure WriteInvoiceNo(Flag,InvoiceNo:String);
    procedure WriteInvoiceId(InvoiceId:String);
    function IncInvoiceNo(InvoiceNo:String):String;
    procedure SetIvioType(const Value: String);
    procedure FocusNextColumn;
    procedure InitRecord;
    procedure OpenDialogGoods;
    procedure AddFromDialog(AObj:TRecord_);
    procedure EraseRecord;
    procedure AddRecord(AObj:TRecord_;UNIT_ID:string;Located:boolean=false;IsPresent:boolean=false);
    procedure UpdateRecord(AObj:TRecord_;UNIT_ID:string;pt:boolean=false);
    function CheckRepeat(AObj:TRecord_;var pt:boolean):boolean;
    function InitPrice(GODS_ID,UNIT_ID:string):Currency;
    procedure AMountToCalc(Amount:Real);
    procedure CalcTaxMny;
  public
    { Public declarations }
    AObj:TRecord_;
    locked:Boolean;
    RowID:integer;
    procedure Open(id:string);
    procedure Append;
    procedure Edit(id:string);
    procedure SaveOrder;
    procedure CancelOrder;
    procedure DeleteOrder;
    property cid:string read Fcid write Setcid;
    property ClientId:String read FClientId write SetClientId;
    property InvoiceId:String read FInvoiceId write SetInvoiceId;
    property InvoiceMny:Real read FInvoiceMny write SetInvoiceMny;
    property isAudit:boolean read FisAudit write SetisAudit;
    property IvioType:String read FIvioType write SetIvioType;
  end;

implementation
uses uGlobal,uShopUtil,uFnUtil,uDsUtil,uShopGlobal, IniFiles, ufrmBasic, uXDictFactory,
  Math, uframeSelectGoods;
{$R *.dfm}

{ TfrmSalInvoice }

procedure TfrmSalInvoice.Append;
var
  rs:TZQuery;
  i: Integer;
  Invoice_Id:String;
begin
  Open('');
  dbState := dsInsert;
  edtCREA_DATE.Date := Global.SysDate;
  edtSHOP_ID.KeyValue := Global.SHOP_ID;
  edtSHOP_ID.Text := Global.SHOP_NAME;
  rs := ShopGlobal.GetDeptInfo;
  edtDEPT_ID.KeyValue := rs.FieldbyName('DEPT_ID').AsString;
  edtDEPT_ID.Text := rs.FieldbyName('DEPT_NAME').AsString;
  rs := Global.GetZQueryFromName('PUB_CUSTOMER');
  if rs.Locate('CLIENT_ID',ClientId,[]) then
  begin
     edtCLIENT_ID.KeyValue := rs.FieldByName('CLIENT_ID').AsString;
     edtCLIENT_ID.Text := rs.FieldByName('CLIENT_NAME').AsString;
  end;
  if (edtINVOICE_FLAG.ItemIndex<0) and (InvoiceId <> '') then
  begin
     edtINVOICE_FLAG.ItemIndex := TdsItems.FindItems(edtINVOICE_FLAG.Properties.Items,'CODE_ID',InvoiceId);
      if InvoiceId='1' then
         Tax_Rate := 0
      else if InvoiceId = '2' then
         Tax_Rate := StrToFloatDef(ShopGlobal.GetParameter('RTL_RATE2'),0.05)
      else if InvoiceId = '3' then
         Tax_Rate := StrToFloatDef(ShopGlobal.GetParameter('RTL_RATE3'),0.17);
  end;
  edtCREA_USER.KeyValue := Global.UserID;
  edtCREA_USER.Text := Global.UserName;
  edtINVOICE_MNY.Text := FormatFloat('#0.00',InvoiceMny);
  AObj.FieldbyName('INVD_ID').asString := TSequence.NewId();
  AObj.FieldByName('INVOICE_STATUS').AsString := '1';
  AObj.FieldByName('EXPORT_STATUS').AsString := '1';
  edtCLIENT_IDSaveValue(nil);
  Invoice_Id := ReadInvoiceId;
  if (Invoice_Id <> '') and not CdsInvoice.IsEmpty then
  begin
     if CdsInvoice.Locate('INVH_ID',Invoice_Id,[]) then
     begin
        edtINVH_ID.KeyValue := CdsInvoice.FieldByName('INVH_ID').AsString;
        edtINVH_ID.Text := CdsInvoice.FieldByName('INVH_NO').AsString;
        edtINVH_IDSaveValue(nil);
     end;
  end;
  {if edtINVOICE_FLAG.ItemIndex >= 0 then
     edtINVOICE_NO.Text := ReadInvoiceNo(TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsString)
  else
     edtINVOICE_FLAG.Enabled := True;}
  if edtINVOICE_FLAG.ItemIndex < 0 then edtINVOICE_FLAG.Enabled := True;

  if edtCLIENT_ID.CanFocus and Visible then edtCLIENT_ID.SetFocus;
end;

procedure TfrmSalInvoice.CancelOrder;
begin

end;

procedure TfrmSalInvoice.DeleteOrder;
begin
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除一张空单...');
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TInvoiceOrder');
    Factor.AddBatch(cdsDetail,'TInvoiceData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  dbState := dsBrowse;
end;

procedure TfrmSalInvoice.Edit(id: string);
begin
  Open(id);
  dbState := dsEdit;
  //btnOk.Enabled:=False;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
  begin
    SetEditStyle(dsBrowse,edtSHOP_ID.Style);
    edtSHOP_ID.Properties.ReadOnly := True;
  end;
end;

procedure TfrmSalInvoice.Open(id: string);
var Params:TftParamList;
begin
  locked:=True;
  try
    Params := TftParamList.Create(nil);
    try
      Factor.BeginBatch;
      try
        Params.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
        Params.ParamByName('INVD_ID').asString := id;
        Factor.AddBatch(cdsHeader,'TInvoiceOrder',Params);
        Factor.AddBatch(cdsDetail,'TInvoiceData',Params);
        Factor.OpenBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;
      //edtSHOP_ID.Properties.ReadOnly := False;
      AObj.ReadFromDataSet(cdsHeader);
      ReadFromObject(AObj,self);
      if (Length(Trim(edtINVOICE_NO.Text))<8) and (Trim(edtINVOICE_NO.Text)<>'') then
         edtINVOICE_NO.Text := FnString.FormatStringEx(Trim(edtINVOICE_NO.Text),8);
      edtCLIENT_ID.Text := AObj.FieldbyName('INVO_NAME').AsString;
      dbState := dsBrowse;
      //isAudit := (AObj.FieldByName('CHK_DATE').AsString <> '');
    finally
      Params.Free;
    end;
  finally
    locked:=False;
  end;
end;

procedure TfrmSalInvoice.SaveOrder;
var Params:TftParamList;
    rs:TZQuery;
    n:Integer;
    r:real;
begin
  if edtCLIENT_ID.AsString = '' then Raise Exception.Create('请选择开票客户');
  if Trim(edtINVOICE_NO.Text) = '' then Raise Exception.Create('发票号不能为空');
  if edtCREA_DATE.EditValue = null then Raise Exception.Create('请选择开票日期');
  if edtCREA_USER.AsString = '' then Raise Exception.Create('开票人不能为空');
  if edtDEPT_ID.AsString = '' then Raise Exception.Create('开票部门不能为空');
  if edtSHOP_ID.AsString = '' then Raise Exception.Create('开票门店不能为空');
  if not edtIfDuplicate.Checked then
  begin
    rs := TZQuery.Create(nil);
    try
      rs.Close;
      rs.SQL.Text :=
      ' select INVD_ID from SAL_INVOICE_INFO where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID and INVOICE_NO=:INVOICE_NO ';
      rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      rs.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
      rs.ParamByName('INVOICE_NO').AsString := Trim(edtINVOICE_NO.Text);
      Factor.Open(rs);
      if not rs.IsEmpty then
      begin
         if dbState = dsInsert then
            Raise Exception.Create('发票号"'+Trim(edtINVOICE_NO.Text)+'"已经存在!');
         if dbState = dsEdit then
         begin
            rs.First;
            while not rs.Eof do
            begin
              if rs.FieldByName('INVD_ID').AsString <> AObj.FieldByName('INVD_ID').AsString then
                 Raise Exception.Create('发票号"'+Trim(edtINVOICE_NO.Text)+'"已经存在!');
              rs.Next;
            end;
         end;
      end;
    finally
      rs.Free;
    end;
  end;
  WriteToObject(AObj,self);
  if AObj.FieldByName('ADDR_NAME').AsString = '' then AObj.FieldByName('ADDR_NAME').AsString := '无';
  cdsHeader.Edit;
  AObj.WriteToDataSet(cdsHeader);
  cdsHeader.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  if dbState = dsInsert then
     cdsHeader.FieldByName('IVIO_TYPE').AsString := IvioType;
  cdsHeader.Post;
  n := 1;
  cdsDetail.First;
  while not cdsDetail.Eof do
  begin
    cdsDetail.Edit;
    cdsDetail.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsDetail.FieldByName('INVD_ID').AsString := cdsHeader.FieldByName('INVD_ID').AsString;
    cdsDetail.FieldByName('SEQNO').AsInteger := n;
    Inc(n);
    cdsDetail.Post;
    cdsDetail.Next;
  end;

  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TInvoiceOrder');
    Factor.AddBatch(cdsDetail,'TInvoiceData');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
  WriteInvoiceId(edtINVH_ID.AsString);
  WriteInvoiceNo(TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsString,edtINVOICE_NO.Text);
  dbState := dsBrowse;
  if Assigned(OnSave) then OnSave(AObj);
end;

procedure TfrmSalInvoice.Setcid(const Value: string);
begin
  Fcid := Value;
end;

procedure TfrmSalInvoice.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnOk.Visible:=(dbState<>dsBrowse);
  //DBGridEh1.Readonly := (dbState=dsBrowse);
  case Value of
  dsInsert:begin
     Caption := '销项发票--(新增)';
     Label14.Caption := '状态:新增';
  end;
  dsEdit:begin
     Caption := '销项发票--(修改)';
     Label14.Caption := '状态:修改';
     edtINVH_ID.Enabled := False;
     edtINVOICE_NO.Enabled := False;
  end;
  else
      begin
        Caption := '销项发票';
        Label14.Caption := '状态:查看';
        btnOk.Visible := False;
      end;
  end;
end;

procedure TfrmSalInvoice.SetisAudit(const Value: boolean);
begin
  FisAudit := Value;
end;

procedure TfrmSalInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  InputType := 1;
  edtCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
  fndGODS_ID.DataSet := Global.GetZQueryFromName('PUB_GOODSINFO');
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  edtDEPT_ID.DataSet := Global.GetZQueryFromName('CA_DEPT_INFO');
  edtCREA_USER.DataSet := Global.GetZQueryFromName('CA_USERS');
  CdsInvoice.Close;
  CdsInvoice.SQL.Text := ' select INVH_ID,INVH_NO,INVOICE_FLAG,BEGIN_NO,ENDED_NO,CURRENT_NO from SAL_INVOICE_BOOK '+
  ' where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and CREA_USER=:CREA_USER and BALANCE>0 order by INVH_NO ';
  CdsInvoice.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  CdsInvoice.ParamByName('CREA_USER').AsString := Global.UserID;
  Factor.Open(CdsInvoice);

end;

procedure TfrmSalInvoice.edtCLIENT_IDSaveValue(Sender: TObject);
var rs:TZQuery;
begin
  inherited;
  if edtCLIENT_ID.AsString = '' then Exit;
  rs := Global.GetZQueryFromName('PUB_CUSTOMER');
  if not rs.Locate('CLIENT_ID',edtCLIENT_ID.AsString,[]) then Raise Exception.Create('选择的客户没找到,异常错误.');
  AObj.FieldByName('INVO_NAME').AsString := rs.FieldByName('CLIENT_NAME').AsString;
  AObj.FieldByName('ADDR_NAME').AsString := rs.FieldByName('ADDRESS').AsString;
  edtINVO_NAME.Text := rs.FieldByName('CLIENT_NAME').AsString;
  edtADDR_NAME.Text := rs.FieldByName('ADDRESS').AsString;

end;

procedure TfrmSalInvoice.SetClientId(const Value: String);
begin
  FClientId := Value;
end;

procedure TfrmSalInvoice.SetInvoiceMny(const Value: Real);
begin
  FInvoiceMny := Value;
end;

procedure TfrmSalInvoice.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSalInvoice.btnOkClick(Sender: TObject);
begin
  inherited;
  SaveOrder;
  ModalResult := MROK;
end;

procedure TfrmSalInvoice.SetInvoiceId(const Value: String);
begin
  FInvoiceId := Value;
end;

procedure TfrmSalInvoice.FormShow(Sender: TObject);
begin
  inherited;
  if edtINVH_ID.CanFocus then edtINVH_ID.SetFocus;
  cdsDetail.First;
  while not cdsDetail.Eof do
  begin
    cdsDetail.Edit;
    cdsDetail.FieldByName('NOTAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat/(1+Tax_Rate);
    cdsDetail.FieldByName('TAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat-cdsDetail.FieldByName('NOTAX_MNY').AsFloat;
    cdsDetail.Post;
    cdsDetail.Next;
  end;

  if cdsDetail.FieldByName('FROM_TYPE').AsString = '0' then
  begin
     DBGridEh1.ReadOnly := False;
     edtINVOICE_FLAG.Enabled := True;
  end
  else
     DBGridEh1.ReadOnly := True;
  if TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsString <> '3' then
     DBGridEh1.Columns[6].Visible := False;

end;

function TfrmSalInvoice.ReadInvoiceNo(Flag: String): String;
var F:TIniFile;
    L,InvoiceNo:Integer;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.ini');
  try
    Result := F.ReadString('INVOICE','NO'+Flag+'_'+Global.UserID,'');
    L := length(Result);
    if Trim(Result) <> '' then
    begin
       InvoiceNo := StrToIntDef(Result,0)+1;
       if L < 8 then
          Result := FnString.FormatStringEx(IntToStr(InvoiceNo),8,'0')
       else
          Result := IntToStr(InvoiceNo);
    end;
  finally
    F.Free;
  end;
end;

procedure TfrmSalInvoice.WriteInvoiceNo(Flag, InvoiceNo: String);
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.ini');
  try
    F.WriteString('INVOICE','NO'+Flag+'_'+Global.UserID,InvoiceNo);
  finally
    F.Free;
  end;
end;

function TfrmSalInvoice.IncInvoiceNo(InvoiceNo: String): String;
var
  Number: string;
  vNo,i,vLen,vLen1: integer;
begin
  result:='';
  Number:=trim(InvoiceNo);
  vLen:=8;
  vNo:=strtoInt(Number)+1;
  i:=Length(inttoStr(vNo));
  if i<8 then
     result:=FnString.FormatStringEx(IntToStr(vNo),8);
end;

procedure TfrmSalInvoice.SetIvioType(const Value: String);
begin
  FIvioType := Value;
end;

function TfrmSalInvoice.ReadInvoiceId: String;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.ini');
  try
    Result := F.ReadString('INVOICE',Global.UserID,'');
  finally
    F.Free;
  end;
end;

procedure TfrmSalInvoice.WriteInvoiceId(InvoiceId: String);
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.ini');
  try
    F.WriteString('INVOICE',Global.UserID,InvoiceId);
  finally
    F.Free;
  end;

end;

procedure TfrmSalInvoice.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsDetail.RecNo)),length(Inttostr(cdsDetail.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  //DBGridEh1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  with (Sender as TDBGridEh).Canvas do
  begin
    Pen.Color := clGreen;
    MoveTo(Rect.Left,Rect.Bottom);
    LineTo(Rect.Right,Rect.Bottom);
    MoveTo(Rect.Right,Rect.Top);
    LineTo(Rect.Right,Rect.Bottom);
  end;
end;

procedure TfrmSalInvoice.edtINVH_IDSaveValue(Sender: TObject);
begin
  inherited;
  if not CdsInvoice.Active then Exit;
  if not CdsInvoice.Locate('INVH_NO',Trim(edtINVH_ID.Text),[]) then
  begin
     edtINVH_ID.Text := '';
     edtINVH_ID.SetFocus;
     Raise Exception.Create('选择或输入的发票本号不存在!');
  end;
  if Trim(edtINVH_ID.DataSet.FieldByName('CURRENT_NO').AsString) = '' then
     edtINVOICE_NO.Text := FnString.FormatStringEx(edtINVH_ID.DataSet.FieldByName('BEGIN_NO').AsString,8)
  else
     edtINVOICE_NO.Text := IncInvoiceNo(edtINVH_ID.DataSet.FieldByName('CURRENT_NO').AsString);
end;

procedure TfrmSalInvoice.fndGODS_IDEnter(Sender: TObject);
begin
  inherited;
  fndGODS_ID.Text := cdsDetail.FieldByName('GODS_NAME').AsString;
  fndGODS_ID.KeyValue := cdsDetail.FieldByName('GODS_ID').AsString;
  fndGODS_ID.Properties.ReadOnly := DBGridEh1.ReadOnly;
end;

procedure TfrmSalInvoice.fndGODS_IDExit(Sender: TObject);
begin
  inherited;
  if not fndGODS_ID.DropListed then fndGODS_ID.Visible := false;
end;

procedure TfrmSalInvoice.fndGODS_IDFindClick(Sender: TObject);
begin
  inherited;
  fndGODS_ID.CloseList;
  fndGODS_ID.Visible := false;
  OpenDialogGoods;
end;

procedure TfrmSalInvoice.fndGODS_IDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_RIGHT) and not fndGODS_ID.Edited then
     begin
       DBGridEh1.SetFocus;
       fndGODS_ID.Visible := false;
       FocusNextColumn;
     end;
  if (Key=VK_UP) and not fndGODS_ID.DropListed then
     begin
       DBGridEh1.SetFocus;
       fndGODS_ID.Visible := false;
       cdsDetail.Prior;
     end;
  if (Key=VK_DOWN) and (Shift=[]) and not fndGODS_ID.DropListed then
     begin
       if (cdsDetail.FieldByName('SEQNO').AsString<>'') and (cdsDetail.FieldByName('GODS_ID').AsString='') then
         fndGODS_ID.DropList
       else
       begin
         DBGridEh1.SetFocus;
         fndGODS_ID.Visible := false;
         cdsDetail.Next;
         if cdsDetail.Eof then
            InitRecord;
            //PostMessage(Handle,WM_INIT_RECORD,0,0);
         if cdsDetail.FieldByName('GODS_ID').AsString <> '' then
            Key := 0
       end;
     end;
  inherited;
end;

procedure TfrmSalInvoice.fndGODS_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       Key := #0;

       if (fndGODS_ID.AsString = '') and (InputType=1) then
          begin
            InitRecord;
            Exit;
          end;
       if cdsDetail.FieldbyName('GODS_ID').AsString = '' then
          begin
            fndGODS_ID.DropList;
            Exit;
          end;
       DBGridEh1.SetFocus;
       FocusNextColumn;
       InputType := 1;
     end;
end;

procedure TfrmSalInvoice.fndGODS_IDSaveValue(Sender: TObject);
var AObj:TRecord_;
  rs:TZQuery;
  pt:boolean;
begin
  inherited;
  if not cdsDetail.Active then Exit;
  if (fndGODS_ID.AsString = '') and (Trim(fndGODS_ID.Text) <> '') then
  begin
    if cdsDetail.Locate('GODS_NAME',Trim(fndGODS_ID.Text),[]) then
       Raise Exception.Create('"'+Trim(fndGODS_ID.Text)+'"商品名已经存在!');
    InputType := 2;
    InitRecord;
    //InputType := 1;
    Exit;
  end;
  if cdsDetail.FieldbyName('GODS_ID').AsString=fndGODS_ID.AsString then exit;
  cdsDetail.DisableControls;
  try
    if cdsDetail.FieldbyName('GODS_ID').AsString <> '' then
       begin
         if MessageBox(Handle,pchar('是否把当前选中商品修改为"'+fndGODS_ID.Text+'('+fndGODS_ID.DataSet.FieldbyName('GODS_CODE').AsString+')"？'),'友情提示',MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2)<>6 then
            begin
              fndGODS_ID.Text := cdsDetail.FieldbyName('GODS_NAME').AsString;
              fndGODS_ID.KeyValue := cdsDetail.FieldbyName('GODS_ID').AsString;
              Exit;
            end;
       end;


    if VarIsNull(fndGODS_ID.KeyValue) then
    begin
      EraseRecord;
    end
    else
    begin
      AObj := TRecord_.Create;
      try
        rs := Global.GetZQueryFromName('PUB_GOODSINFO');
        if rs.Locate('GODS_ID',fndGODS_ID.AsString,[]) then
        begin
          AObj.ReadField(cdsDetail);
          AObj.ReadFromDataSet(rs,false);
          //AObj.FieldbyName('UNIT_ID').AsString := rs.FieldbyName('UNIT_ID').AsString;

          pt := false;

          if CheckRepeat(AObj,pt) then
             begin
               fndGODS_ID.Text := cdsDetail.FieldbyName('GODS_NAME').AsString;
               fndGODS_ID.KeyValue := cdsDetail.FieldbyName('GODS_ID').AsString;
               Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.GoodsRepeat','"%s"货品重复录入,请核对输入是否正确.',[cdsDetail.FieldbyName('GODS_NAME').AsString]));
             end;
          UpdateRecord(AObj,rs.FieldByName('UNIT_ID').AsString,pt);
        end
        else
          Raise Exception.Create(XDictFactory.GetMsgStringFmt('frame.NoFindGoodsInfo','在经营品牌中没找到"%s"',[fndGODS_ID.Text]));
      finally
        AObj.Free;
      end;

    end;
  finally
    if DBGridEh1.CanFocus then DBGridEh1.SetFocus;
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmSalInvoice.FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh1.Col;
  if cdsDetail.RecordCount>cdsDetail.RecNo then
     begin
       cdsDetail.Next;
       Exit;
     end;
  Inc(i);
  while True do
    begin
      if i>=DbGridEh1.Columns.Count then i:= 1;
      if (DbGridEh1.Columns[i].ReadOnly or not DbGridEh1.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(cdsDetail.FieldbyName('GODS_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(cdsDetail.FieldbyName('GODS_ID').asString)<>'') then
              begin
                 cdsDetail.Next ;
                 if cdsDetail.Eof then
                    begin
                      InitRecord;
                    end;
                 DbGridEh1.SetFocus;
                 DbGridEh1.Col := 1 ;
              end
           else
              DbGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmSalInvoice.InitRecord;
begin
  if dbState = dsBrowse then Exit;
  if cdsDetail.State in [dsEdit,dsInsert] then cdsDetail.Post;
  fndGODS_ID.Visible := false;
  cdsDetail.DisableControls;
  try
  cdsDetail.Last;
  if InputType = 1 then
  begin
    if cdsDetail.IsEmpty or (cdsDetail.FieldbyName('GODS_ID').AsString <>'') then
      begin
        inc(RowID);
        cdsDetail.Append;
        cdsDetail.FieldByName('GODS_ID').Value := null;
        cdsDetail.FieldByName('FROM_TYPE').AsString := '0';
        if cdsDetail.FindField('SEQNO')<> nil then
           cdsDetail.FindField('SEQNO').asInteger := RowID;
        cdsDetail.Post;
      end;
  end
  else
  begin
    //Inc(RowID);
    if cdsDetail.FieldByName('SEQNO').AsString <> '' then
    begin
    cdsDetail.Edit;
    cdsDetail.FieldbyName('GODS_ID').AsString := '#';
    cdsDetail.FieldbyName('GODS_NAME').AsString := Trim(fndGODS_ID.Text);
    cdsDetail.FieldByName('AMOUNT').AsFloat := 1;
    cdsDetail.Post;
    end;
  end;
    DbGridEh1.Col := 1 ;
    if DBGridEh1.CanFocus and Visible and (dbState <> dsBrowse) then DBGridEh1.SetFocus;
  finally
    cdsDetail.EnableControls;
    cdsDetail.Edit;
  end;
end;

procedure TfrmSalInvoice.OpenDialogGoods;
var
  AObj:TRecord_;

begin
  try
  with TframeSelectGoods.Create(self) do
    begin
      try
        MultiSelect := false;
        OnSave := AddFromDialog;
        if ShowModal=MROK then
           begin
             cdsList.first;
             while not cdsList.eof do
               begin
                 AObj := TRecord_.Create;
                 try
                   AObj.ReadFromDataSet(cdsList);
                   AddFromDialog(AObj);
                 finally
                   AObj.Free;
                 end;
                 cdsList.Next;
               end;
           end;
      finally
        free;
      end;
    end;
  finally
    DBGridEh1.SetFocus;
  end;
end;

procedure TfrmSalInvoice.AddFromDialog(AObj: TRecord_);
var basInfo:TZQuery;
begin
  basInfo := Global.GetZQueryFromName('PUB_GOODSINFO');
  if not basInfo.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]) then Raise Exception.Create('经营商品中没找到"'+AObj.FieldbyName('GODS_NAME').AsString+'"');
  AddRecord(AObj,basInfo.FieldbyName('UNIT_ID').AsString,True);

end;

procedure TfrmSalInvoice.AddRecord(AObj: TRecord_; UNIT_ID: string;
  Located, IsPresent: boolean);
var
  Pt:integer;
  r:boolean;
  rs:TZQuery;
begin
  if IsPresent then pt := 1 else pt := 0;
  if Located then
     begin
        r := cdsDetail.Locate('GODS_ID',AObj.FieldbyName('GODS_ID').AsString,[]);
        if r then Exit;

        //inc(RowID);
        if (cdsDetail.FieldbyName('GODS_ID').asString='') and (cdsDetail.FieldbyName('SEQNO').asString<>'') then
        cdsDetail.Edit else InitRecord;
        cdsDetail.FieldbyName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
        cdsDetail.FieldbyName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
        cdsDetail.FieldByName('AMOUNT').AsFloat := 1;
        cdsDetail.FieldByName('APRICE').AsFloat := InitPrice(cdsDetail.FieldbyName('GODS_ID').AsString,UNIT_ID);
        cdsDetail.FieldByName('NOTAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat/(1+Tax_Rate);
        cdsDetail.FieldByName('TAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat-cdsDetail.FieldByName('NOTAX_MNY').AsFloat;

        if UNIT_ID='' then
           cdsDetail.FieldbyName('UNIT_NAME').AsString := ''
        else
           begin
             rs := ShopGlobal.GetZQueryFromName('PUB_MEAUNITS');
             if rs.Locate('UNIT_ID',UNIT_ID,[]) then
                cdsDetail.FieldbyName('UNIT_NAME').AsString := rs.FieldByName('UNIT_NAME').AsString
             else
                cdsDetail.FieldByName('UNIT_NAME').AsString := '';
           end;

     end;
  cdsDetail.Edit;

end;

procedure TfrmSalInvoice.EraseRecord;
var i:integer;
begin
  if cdsDetail.State = dsBrowse then cdsDetail.Edit;
  for i:=1 to cdsDetail.Fields.Count -1 do cdsDetail.Fields[i].Value := null;
  fndGODS_ID.Text := '';
  fndGODS_ID.KeyValue := null;
end;

function TfrmSalInvoice.CheckRepeat(AObj: TRecord_;
  var pt: boolean): boolean;
var
  r,c:integer;
begin
  result := false;
  r := cdsDetail.FieldbyName('SEQNO').AsInteger;
  cdsDetail.DisableControls;
  try
    c := 0;
    cdsDetail.First;
    while not cdsDetail.Eof do
      begin
        if
           (cdsDetail.FieldbyName('GODS_ID').AsString = AObj.FieldbyName('GODS_ID').AsString)
           and
           (cdsDetail.FieldbyName('SEQNO').AsInteger <> r)
        then
           begin
             inc(c);
             break;
           end;
        cdsDetail.Next;
      end;
    pt := false;
    if c>0 then
      begin
        if (MessageBox(Handle,pchar('"'+AObj.FieldbyName('GODS_NAME').asString+'('+AObj.FieldbyName('GODS_CODE').asString+')已经存在，是否继续添加赠品？'),'友情提示...',MB_YESNO+MB_ICONQUESTION)=6) then
           result := false else result := true;
      end;
  finally
    cdsDetail.Locate('SEQNO',r,[]);
    cdsDetail.EnableControls;
  end;
end;

procedure TfrmSalInvoice.UpdateRecord(AObj: TRecord_; UNIT_ID: string;
  pt: boolean);
var Field:TField;
    rs:TZQuery;
begin
  if cdsDetail.State = dsBrowse then
     begin
       if cdsDetail.FieldbyName('SEQNO').asString='' then
          InitRecord else cdsDetail.Edit;
     end;
  cdsDetail.FieldByName('GODS_ID').AsString := AObj.FieldbyName('GODS_ID').AsString;
  cdsDetail.FieldByName('GODS_NAME').AsString := AObj.FieldbyName('GODS_NAME').AsString;
  cdsDetail.FieldByName('AMOUNT').AsFloat := 1;
  cdsDetail.FieldByName('APRICE').AsFloat := InitPrice(cdsDetail.FieldbyName('GODS_ID').AsString,UNIT_ID);
  cdsDetail.FieldByName('NOTAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat/(1+Tax_Rate);
  cdsDetail.FieldByName('TAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat-cdsDetail.FieldByName('NOTAX_MNY').AsFloat;

  if UNIT_ID='' then
     cdsDetail.FieldbyName('UNIT_NAME').AsString := ''
  else
     begin
       rs := ShopGlobal.GetZQueryFromName('PUB_MEAUNITS');
       if rs.Locate('UNIT_ID',UNIT_ID,[]) then
          cdsDetail.FieldbyName('UNIT_NAME').AsString := rs.FieldByName('UNIT_NAME').AsString
       else
          cdsDetail.FieldByName('UNIT_NAME').AsString := '';
     end;
  cdsDetail.Edit;

end;

function TfrmSalInvoice.InitPrice(GODS_ID, UNIT_ID: string): Currency;
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
    Params.ParamByName('CarryRule').asInteger := 0;
    Params.ParamByName('Deci').asInteger := 2;
    Params.ParamByName('CLIENT_ID').asString := edtCLIENT_ID.AsString;
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('SHOP_ID').asString := edtSHOP_ID.AsString;
    Params.ParamByName('GODS_ID').asString := GODS_ID;
    Params.ParamByName('PRICE_ID').asString := '#';
    Params.ParamByName('UNIT_ID').asString := UNIT_ID;
    Factor.Open(rs,'TGetSalesPrice',Params);
    Result := rs.FieldbyName('V_APRICE').AsFloat;

  finally
    Params.Free;
    rs.Free;
  end;
end;

procedure TfrmSalInvoice.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;
begin
  if cdsDetail.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;

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

procedure TfrmSalInvoice.AMountToCalc(Amount: Real);
begin
  if locked then Exit;
  locked := True;
  try
    if not (cdsDetail.State in [dsEdit,dsInsert]) then cdsDetail.Edit;
    cdsDetail.FieldByName('NOTAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat/(1+Tax_Rate);
    cdsDetail.FieldByName('TAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat-cdsDetail.FieldByName('NOTAX_MNY').AsFloat;
    cdsDetail.Edit;
  finally
    locked := False;
  end;
end;

procedure TfrmSalInvoice.DBGridEh1Columns4UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Currency;
begin
  if cdsDetail.FieldbyName('GODS_ID').AsString = '' then
     begin
       Text := '';
       Value := null;
       FocusNextColumn;
       Exit;
     end;

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

procedure TfrmSalInvoice.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key=#13) then
     begin
       FocusNextColumn;
       Key := #0;
     end;
end;

procedure TfrmSalInvoice.edtINVOICE_FLAGPropertiesChange(Sender: TObject);
begin
  inherited;
  case TRecord_(edtINVOICE_FLAG.Properties.Items.Objects[edtINVOICE_FLAG.ItemIndex]).FieldByName('CODE_ID').AsInteger of
    1:begin
    Tax_Rate := 0;
    DBGridEh1.Columns[6].Visible := False;
    end;
    2:begin
    Tax_Rate := StrToFloatDef(ShopGlobal.GetParameter('RTL_RATE2'),0.05);
    DBGridEh1.Columns[6].Visible := False;
    end;
    3:begin
    Tax_Rate := StrToFloatDef(ShopGlobal.GetParameter('RTL_RATE3'),0.17);
    DBGridEh1.Columns[6].Visible := True;
    end;
  end;
  CalcTaxMny;
end;

procedure TfrmSalInvoice.CalcTaxMny;
var SeqNo,i:Integer;
begin
  i := DBGridEh1.Col;
  SeqNo := cdsDetail.FieldByName('SEQNO').AsInteger;
  cdsDetail.DisableControls;
  try
    cdsDetail.First;
    while not cdsDetail.Eof do
    begin
      cdsDetail.Edit;
      cdsDetail.FieldByName('NOTAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat/(1+Tax_Rate);
      cdsDetail.FieldByName('TAX_MNY').AsFloat := cdsDetail.FieldByName('AMOUNT').AsFloat*cdsDetail.FieldByName('APRICE').AsFloat-cdsDetail.FieldByName('NOTAX_MNY').AsFloat;
      cdsDetail.Post;
      cdsDetail.Next;
    end;
    DBGridEh1.Col := i;
    cdsDetail.Locate('SEQNO',SeqNo,[]);
  finally
    cdsDetail.EnableControls;
  end;
end;

end.
