unit ufrmCustomerDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxTextEdit, cxRadioGroup,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxButtonEdit, zrComboBoxList, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, pngimage;

type
  TfrmCustomerDialog = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    edtBK_CUST_CODE: TRzPanel;
    RzPanel30: TRzPanel;
    RzLabel2: TRzLabel;
    edtCUST_CODE: TcxTextEdit;
    red1: TLabel;
    edtBK_CUST_NAME: TRzPanel;
    RzPanel3: TRzPanel;
    RzLabel3: TRzLabel;
    edtCUST_NAME: TcxTextEdit;
    Label1: TLabel;
    edtBK_SEX: TRzPanel;
    RzPanel36: TRzPanel;
    RzLabel14: TRzLabel;
    edtSEX1: TcxRadioButton;
    edtSEX3: TcxRadioButton;
    edtSEX2: TcxRadioButton;
    edtBK_BIRTHDAY: TRzPanel;
    RzPanel16: TRzPanel;
    RzLabel5: TRzLabel;
    cmbBIRTHDAY: TcxDateEdit;
    edtBK_PRICE_ID: TRzPanel;
    RzPanel29: TRzPanel;
    RzLabel4: TRzLabel;
    cmbPRICE_ID: TzrComboBoxList;
    edtBK_MOVE_TELE: TRzPanel;
    RzPanel32: TRzPanel;
    RzLabel6: TRzLabel;
    edtMOVE_TELE: TcxTextEdit;
    Label2: TLabel;
    cdsCustomer: TZQuery;
    RzPanel10: TRzPanel;
    Image4: TImage;
    RzPanel2: TRzPanel;
    btnSave: TRzBmpButton;
    btnCancel: TRzBmpButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtCUST_CODEKeyPress(Sender: TObject; var Key: Char);
    procedure edtCUST_NAMEKeyPress(Sender: TObject; var Key: Char);
    procedure cmbPRICE_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtCUST_CODEExit(Sender: TObject);
  private
    AObj:TRecord_;
    procedure Open(id:string);
    procedure WriteInfo;
    procedure ReadInfo;
    procedure SaveInfo;
    procedure SaveLocalInfo;
    procedure InitTele;
  public
    class function ShowDialog(Owner:TForm;id:string;var SObj:TRecord_):boolean;
  end;

implementation

uses udllGlobal,udataFactory,uTokenFactory,udllShopUtil,udllDsUtil,uFnUtil;

{$R *.dfm}

class function TfrmCustomerDialog.ShowDialog(Owner: TForm; id: string; var SObj: TRecord_): boolean;
begin
  with TfrmCustomerDialog.Create(Owner) do
    begin
      try
        Open(id);
        ReadInfo;
        result := (ShowModal = MROK);
        if result then SObj.ReadFromDataSet(cdsCustomer);
      finally
        Free;
      end;
    end;
end;

procedure TfrmCustomerDialog.Open(id: string);
var Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
    dataFactory.BeginBatch;
    try
      Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
      Params.ParamByName('CUST_ID').AsString := id;
      dataFactory.AddBatch(cdsCustomer,'TCustomerV60',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmCustomerDialog.ReadInfo;
begin
  AObj.ReadFromDataSet(cdsCustomer);
  if cdsCustomer.IsEmpty then
     begin
       dbState := dsInsert;
       edtSEX2.Checked := true;
       cmbPRICE_ID.KeyValue := cmbPRICE_ID.DataSet.FieldByName('PRICE_ID').AsString;
       cmbPRICE_ID.Text := cmbPRICE_ID.DataSet.FieldByName('PRICE_NAME').AsString;
     end
  else
     begin
       dbState := dsEdit;
       ReadFromObject(AObj,self);
       case AObj.FieldbyName('SEX').AsInteger of
         1:edtSEX1.Checked := true;
         2:edtSEX2.Checked := true;
         else edtSEX3.Checked := true;
       end;
     end;
end;

procedure TfrmCustomerDialog.WriteInfo;
var rs:TZQuery;
begin
  WriteToObject(AObj,self);
  if edtSEX1.Checked then AObj.FieldbyName('SEX').AsInteger := 1;
  if edtSEX2.Checked then AObj.FieldbyName('SEX').AsInteger := 2;
  if edtSEX3.Checked then AObj.FieldbyName('SEX').AsInteger := 3;
  AObj.FieldbyName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  if AObj.FieldbyName('REGION_ID').AsString='' then
     begin
       rs := dllGlobal.GetZQueryFromName('CA_SHOP_INFO');
       if rs.Locate('SHOP_ID',token.shopId,[]) then
          AObj.FieldbyName('REGION_ID').AsString := rs.FieldbyName('REGION_ID').AsString;
     end;
  if AObj.FieldbyName('REGION_ID').AsString='' then AObj.FieldbyName('REGION_ID').AsString := '999999';
  if AObj.FieldbyName('SHOP_ID').AsString = '' then AObj.FieldbyName('SHOP_ID').AsString := token.shopId;
  if AObj.FieldbyName('CUST_ID').AsString = '' then AObj.FieldbyName('CUST_ID').AsString := TSequence.NewId();
  if AObj.FieldbyName('CREA_USER').AsString = '' then AObj.FieldbyName('CREA_USER').AsString := token.userId;
  if AObj.FieldbyName('CREA_DATE').AsString = '' then AObj.FieldbyName('CREA_DATE').AsString := formatDatetime('YYYY-MM-DD',now());
  if AObj.FieldByName('CUST_SPELL').AsString = '' then AObj.FieldByName('CUST_SPELL').AsString := fnString.GetWordSpell(AObj.FieldByName('CUST_NAME').AsString,3);
  cdsCustomer.Edit;
  AObj.WriteToDataSet(cdsCustomer);
  cdsCustomer.Post;
end;

procedure TfrmCustomerDialog.SaveInfo;
begin
  if trim(edtCUST_CODE.Text) = '' then
     begin
       if edtCUST_CODE.CanFocus then edtCUST_CODE.SetFocus;
       Raise Exception.Create('会员卡号不能为空...');
     end;
  if trim(edtCUST_NAME.Text) = '' then
     begin
       if edtCUST_NAME.CanFocus then edtCUST_NAME.SetFocus;
       Raise Exception.Create('会员名称不能为空...');
     end;
  if trim(cmbPRICE_ID.AsString) = '' then
     begin
       if cmbPRICE_ID.CanFocus then cmbPRICE_ID.SetFocus;
       Raise Exception.Create('会员等级不能为空...');
     end;

  WriteInfo;

  dataFactory.BeginBatch;
  try
    dataFactory.AddBatch(cdsCustomer,'TCustomerV60',nil);
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    Raise;
  end;

  SaveLocalInfo;

  dllGlobal.Refresh('PUB_CUSTOMER');

  ModalResult := MROK;
end;

procedure TfrmCustomerDialog.SaveLocalInfo;
var
  Params:TftParamList;
  tmpCustomer:TZQuery;
  tmpObj:TRecord_;
begin
  if dataFactory.iDbType <> 5 then
  begin
    tmpObj := TRecord_.Create;
    tmpCustomer := TZQuery.Create(nil);
    Params := TftParamList.Create;
    dataFactory.MoveToSqlite;
    try
      dataFactory.BeginBatch;
      try
        Params.ParamByName('TENANT_ID').AsInteger := cdsCustomer.FieldByName('TENANT_ID').AsInteger;
        Params.ParamByName('CUST_ID').AsString := cdsCustomer.FieldByName('CUST_ID').AsString;;
        dataFactory.AddBatch(tmpCustomer,'TCustomerV60',Params);
        dataFactory.OpenBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
      if tmpCustomer.IsEmpty then tmpCustomer.Append else tmpCustomer.Edit;
      tmpObj.ReadFromDataSet(cdsCustomer);
      tmpObj.WriteToDataSet(tmpCustomer);
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpCustomer,'TCustomerV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      dataFactory.MoveToDefault;
      Params.Free;
      tmpCustomer.Free;
      tmpObj.Free;
    end;
  end;
end;

procedure TfrmCustomerDialog.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  cmbPRICE_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_PRICEGRADE');
end;

procedure TfrmCustomerDialog.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmCustomerDialog.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveInfo;
end;

procedure TfrmCustomerDialog.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCustomerDialog.InitTele;
begin
  if edtMOVE_TELE.Text <> '' then Exit;
  if Length(trim(edtCUST_CODE.Text)) <> 11 then Exit;
  if (Copy(edtCUST_CODE.Text,1,2) = '13')  or
     (Copy(edtCUST_CODE.Text,1,2) = '15')  or
     (Copy(edtCUST_CODE.Text,1,2) = '18')  or
     (Copy(edtCUST_CODE.Text,1,3) = '145') or
     (Copy(edtCUST_CODE.Text,1,3) = '147') then
  edtMOVE_TELE.Text := edtCUST_CODE.Text;
end;

procedure TfrmCustomerDialog.edtCUST_CODEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(edtCUST_CODE.Text) = '' then
          begin
            if edtCUST_CODE.CanFocus then edtCUST_CODE.SetFocus;
            Key := #0;
          end;
     end;
end;

procedure TfrmCustomerDialog.edtCUST_NAMEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(edtCUST_NAME.Text) = '' then
          begin
            if edtCUST_NAME.CanFocus then edtCUST_NAME.SetFocus;
            Key := #0;
          end;
     end;
end;

procedure TfrmCustomerDialog.cmbPRICE_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(cmbPRICE_ID.AsString) = '' then
          begin
            if cmbPRICE_ID.CanFocus then cmbPRICE_ID.SetFocus;
            Key := #0;
          end;
     end;
end;

procedure TfrmCustomerDialog.edtCUST_CODEExit(Sender: TObject);
begin
  inherited;
  InitTele;
end;

end.
