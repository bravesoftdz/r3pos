unit ufrmSupplierDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxTextEdit, cxRadioGroup,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxButtonEdit, zrComboBoxList, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, pngimage, RzBckgnd;

type
  TfrmSupplierDialog = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    cdsSupplier: TZQuery;
    RzPanel5: TRzPanel;
    btnSave: TRzBmpButton;
    btnCancel: TRzBmpButton;
    RzPanel7: TRzPanel;
    RzPanel10: TRzPanel;
    Image4: TImage;
    RzPanel9: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel17: TRzLabel;
    RzPanel2: TRzPanel;
    edtBK_CLIENT_CODE: TRzPanel;
    RzPanel30: TRzPanel;
    RzLabel2: TRzLabel;
    edtCLIENT_CODE: TcxTextEdit;
    edtBK_CLIENT_NAME: TRzPanel;
    RzPanel3: TRzPanel;
    RzLabel3: TRzLabel;
    RzPanel8: TRzPanel;
    RzLabel9: TRzLabel;
    edtBK_REGION_ID: TRzPanel;
    RzPanel29: TRzPanel;
    RzLabel4: TRzLabel;
    edtBK_LINKMAN: TRzPanel;
    RzPanel16: TRzPanel;
    RzLabel5: TRzLabel;
    edtLINKMAN: TcxTextEdit;
    edtBK_TELEPHONE2: TRzPanel;
    RzPanel4: TRzPanel;
    RzLabel7: TRzLabel;
    edtTELEPHONE2: TcxTextEdit;
    edtBK_ADDRESS: TRzPanel;
    RzPanel32: TRzPanel;
    RzLabel6: TRzLabel;
    edtADDRESS: TcxTextEdit;
    RzPanel6: TRzPanel;
    RzLabel8: TRzLabel;
    edtPOSTALCODE: TcxTextEdit;
    Label2: TLabel;
    Label1: TLabel;
    red1: TLabel;
    edtCLIENT_NAME: TcxTextEdit;
    edtCLIENT_SPELL: TcxTextEdit;
    edtREGION_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtCLIENT_CODEKeyPress(Sender: TObject; var Key: Char);
    procedure edtCLIENT_NAMEKeyPress(Sender: TObject; var Key: Char);
    procedure edtREGION_IDKeyPress(Sender: TObject; var Key: Char);
    procedure edtCLIENT_CODEExit(Sender: TObject);
    procedure edtCLIENT_NAMEPropertiesChange(Sender: TObject);
    procedure RzLabel17Click(Sender: TObject);
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

class function TfrmSupplierDialog.ShowDialog(Owner: TForm; id: string; var SObj: TRecord_): boolean;
begin
  with TfrmSupplierDialog.Create(Owner) do
    begin
      try
        Open(id);
        ReadInfo;
        result := (ShowModal = MROK);
        if result then SObj.ReadFromDataSet(cdsSupplier);
      finally
        Free;
      end;
    end;
end;

procedure TfrmSupplierDialog.Open(id: string);
var Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
    dataFactory.BeginBatch;
    try
      Params.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
      Params.ParamByName('CLIENT_ID').AsString := id;
      dataFactory.AddBatch(cdsSupplier,'TSupplierV60',Params);
      dataFactory.OpenBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;
  finally
    Params.Free;
  end;
end;

procedure TfrmSupplierDialog.ReadInfo;
begin
  AObj.ReadFromDataSet(cdsSupplier);
  if cdsSupplier.IsEmpty then
     begin
       dbState := dsInsert;
     end
  else
     begin
       dbState := dsEdit;
       ReadFromObject(AObj,self);
     end;
end;

procedure TfrmSupplierDialog.WriteInfo;
begin
  WriteToObject(AObj,self);

  AObj.FieldbyName('TENANT_ID').AsInteger := strtoint(token.tenantId);
  AObj.FieldbyName('CLIENT_TYPE').AsString := '1';
  if AObj.FieldbyName('CLIENT_ID').AsString = '' then AObj.FieldbyName('CLIENT_ID').AsString := TSequence.NewId();
  if AObj.FieldbyName('SHOP_ID').AsString = '' then AObj.FieldbyName('SHOP_ID').AsString := token.shopId;
  if AObj.FieldbyName('REGION_ID').AsString='' then AObj.FieldbyName('REGION_ID').AsString:='#';
  if AObj.FieldByName('CLIENT_SPELL').AsString = '' then AObj.FieldByName('CLIENT_SPELL').AsString := fnString.GetWordSpell(AObj.FieldByName('CLIENT_NAME').AsString,3);
  if AObj.FieldbyName('SORT_ID').AsString = '' then AObj.FieldbyName('SORT_ID').AsString :='#';
  if AObj.FieldbyName('SETTLE_CODE').AsString = '' then AObj.FieldbyName('SETTLE_CODE').AsString :='#';
  
  cdsSupplier.Edit;
  AObj.WriteToDataSet(cdsSupplier);
  cdsSupplier.Post;
end;

procedure TfrmSupplierDialog.SaveInfo;
var rs:TZQuery;
begin
  rs:=dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');

  if trim(edtCLIENT_CODE.Text) = '' then
  begin
    if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
    Raise Exception.Create('供应商编号不能为空！');
  end else
  begin
    if rs.Locate('FLAG;SHOP_ID;CLIENT_CODE',VarArrayof(['0',token.shopId,Trim(edtCLIENT_CODE.Text)]),[]) then
    begin
      if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
      raise  Exception.Create('供应商编号已经存在，不能重复！');
    end;
  end;

  if trim(edtCLIENT_NAME.Text) = '' then
  begin
    if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
    Raise Exception.Create('供应商名称不能为空！');
  end else
  begin
    if rs.Locate('FLAG;SHOP_ID;CLIENT_NAME',VarArrayof(['0',token.shopId,Trim(edtCLIENT_NAME.Text)]),[]) then
    begin
      if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
      raise  Exception.Create('供应商名称已经存在，不能重复！');
    end;
  end;

  if trim(edtREGION_ID.AsString) = '' then
     begin
       if edtREGION_ID.CanFocus then edtREGION_ID.SetFocus;
       Raise Exception.Create('地区不能为空！');
     end;

  WriteInfo;

  dataFactory.BeginBatch;
  try
    dataFactory.AddBatch(cdsSupplier,'TSupplierV60',nil);
    dataFactory.CommitBatch;
  except
    dataFactory.CancelBatch;
    Raise;
  end;

  SaveLocalInfo;

  dllGlobal.Refresh('PUB_CLIENTINFO');

  ModalResult := MROK;
end;

procedure TfrmSupplierDialog.SaveLocalInfo;
var
  Params:TftParamList;
  tmpQuery:TZQuery;
  tmpObj:TRecord_;
begin
  if dataFactory.iDbType <> 5 then
  begin
    tmpObj := TRecord_.Create;
    tmpQuery := TZQuery.Create(nil);
    Params := TftParamList.Create;
    dataFactory.MoveToSqlite;
    try
      dataFactory.BeginBatch;
      try
        Params.ParamByName('TENANT_ID').AsInteger := cdsSupplier.FieldByName('TENANT_ID').AsInteger;
        Params.ParamByName('CLIENT_ID').AsString := cdsSupplier.FieldByName('CLIENT_ID').AsString;;
        dataFactory.AddBatch(tmpQuery,'TSupplierV60',Params);
        dataFactory.OpenBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
      if tmpQuery.IsEmpty then tmpQuery.Append else tmpQuery.Edit;
      tmpObj.ReadFromDataSet(cdsSupplier);
      tmpObj.WriteToDataSet(tmpQuery);
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(tmpQuery,'TSupplierV60',nil);
        dataFactory.CommitBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      dataFactory.MoveToDefault;
      Params.Free;
      tmpQuery.Free;
      tmpObj.Free;
    end;
  end;
end;

procedure TfrmSupplierDialog.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  edtREGION_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_REGION_INFO');
end;

procedure TfrmSupplierDialog.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmSupplierDialog.btnSaveClick(Sender: TObject);
begin
  inherited;
  SaveInfo;
end;

procedure TfrmSupplierDialog.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSupplierDialog.InitTele;
begin

end;

procedure TfrmSupplierDialog.edtCLIENT_CODEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(edtCLIENT_CODE.Text) = '' then
          begin
            if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
            Key := #0;
          end;
     end;
end;

procedure TfrmSupplierDialog.edtCLIENT_NAMEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(edtCLIENT_NAME.Text) = '' then
          begin
            if edtCLIENT_NAME.CanFocus then edtCLIENT_NAME.SetFocus;
            Key := #0;
          end;
     end;
end;

procedure TfrmSupplierDialog.edtREGION_IDKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     begin
       if trim(edtREGION_ID.AsString) = '' then
          begin
            if edtREGION_ID.CanFocus then edtREGION_ID.SetFocus;
            Key := #0;
          end;
     end;
end;

procedure TfrmSupplierDialog.edtCLIENT_CODEExit(Sender: TObject);
begin
  inherited;
  InitTele;
end;

procedure TfrmSupplierDialog.edtCLIENT_NAMEPropertiesChange(
  Sender: TObject);
begin
  inherited;
  if edtCLIENT_NAME.Focused then edtCLIENT_SPELL.Text := FnString.GetWordSpell(edtCLIENT_NAME.Text,3) ;
end;

procedure TfrmSupplierDialog.RzLabel17Click(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'当前功能还没有开通，敬请期待','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

end.
