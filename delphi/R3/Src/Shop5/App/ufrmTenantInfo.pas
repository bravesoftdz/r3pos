unit ufrmTenantInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, cxControls, cxContainer, ZBase,
  cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmTenantInfo = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    edtLOGIN_NAME: TcxTextEdit;
    edtTENANT_NAME: TcxTextEdit;
    edtSHORT_TENANT_NAME: TcxTextEdit;
    edtLICENSE_CODE: TcxTextEdit;
    edtPASSWRD: TcxTextEdit;
    edtPASSWRD1: TcxTextEdit;
    edtREGION_ID: TzrComboBoxList;
    Label7: TLabel;
    Label11: TLabel;
    edtLEGAL_REPR: TcxTextEdit;
    edtFAXES: TcxTextEdit;
    Label9: TLabel;
    Label10: TLabel;
    edtLINKMAN: TcxTextEdit;
    edtTELEPHONE: TcxTextEdit;
    Label13: TLabel;
    Label14: TLabel;
    edtADDRESS: TcxTextEdit;
    edtPOSTALCODE: TcxTextEdit;
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    CdsTable: TZQuery;
    Label20: TLabel;
    edtHOMEPAGE: TcxTextEdit;
    Label24: TLabel;
    Label25: TLabel;
    edtTENANT_SPELL: TcxTextEdit;
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtTENANT_NAMEPropertiesChange(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Aobj:TRecord_;
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Open(Code:Integer);
    procedure Edit(Code:Integer);
    procedure Save;
    class function EditDialog(Ower:TForm;Id:Integer):Boolean;
    class function ShowDialog(Ower:TForm;Id:Integer):Boolean;
  end;

implementation
uses uShopUtil, uDsUtil, uFnUtil, EncDec, uGlobal, uShopGlobal,ufrmShopMain, ufrmBasic;
{$R *.dfm}

procedure TfrmTenantInfo.btnOkClick(Sender: TObject);
begin
  inherited;
  if Trim(edtLOGIN_NAME.Text) = '' then
    begin
      if edtLOGIN_NAME.CanFocus then edtLOGIN_NAME.SetFocus;
      raise Exception.Create('注册帐号不能为空!');
    end;
  if Trim(edtTENANT_NAME.Text) = '' then
    begin
      if edtTENANT_NAME.CanFocus then edtTENANT_NAME.SetFocus;
      raise Exception.Create('企业名称不能为空!');
    end;
  if Trim(edtTENANT_SPELL.Text) = '' then
    begin
      if edtTENANT_SPELL.CanFocus then edtTENANT_SPELL.SetFocus;
      raise Exception.Create('拼音码不能为空!');
    end;
  if Trim(edtSHORT_TENANT_NAME.Text) = '' then
    begin
      if edtSHORT_TENANT_NAME.CanFocus then edtSHORT_TENANT_NAME.SetFocus;
      raise Exception.Create('企业简称不能为空!');
    end;
  if Trim(edtLICENSE_CODE.Text) = '' then
    begin
      if edtLICENSE_CODE.CanFocus then edtLICENSE_CODE.SetFocus;
      raise Exception.Create('经营许可证号不能为空!');
    end;
  if Trim(edtREGION_ID.Text) = '' then
    begin
      if edtREGION_ID.CanFocus then edtREGION_ID.SetFocus;
      raise Exception.Create('所属地区不能为空!');
    end;
  if Trim(edtPASSWRD.Text) = '' then
    begin
      if edtPASSWRD.CanFocus then edtPASSWRD.SetFocus;
      raise Exception.Create('注册密码不能为空!');
    end;
  if Trim(edtPASSWRD1.Text) = '' then
    begin
      if edtPASSWRD1.CanFocus then edtPASSWRD1.SetFocus;
      raise Exception.Create('再次输入密码不能为空!');
    end;
  if Trim(edtPASSWRD1.Text) <> Trim(edtPASSWRD.Text) then
    begin
      edtPASSWRD1.Text := '';
      if edtPASSWRD1.CanFocus then edtPASSWRD1.SetFocus;
      raise Exception.Create('两次密码输入不一致!');
    end;

  Save;
end;

procedure TfrmTenantInfo.Edit(Code: Integer);
begin
  Open(Code);
  dbState := dsEdit;
end;

class function TfrmTenantInfo.EditDialog(Ower: TForm; Id: Integer): Boolean;
begin
  with TfrmTenantInfo.Create(Ower) do
    begin
      try
        Edit(Id);
        Result := (ShowModal = mrOk);
      finally
        Free;
      end;
    end;
end;

procedure TfrmTenantInfo.Open(Code: Integer);
var Params:TftParamList;
begin
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Code;
    Factor.Open(CdsTable,'TTenant',Params);
    Aobj.ReadFromDataSet(CdsTable);
    ReadFromObject(Aobj,Self);
    edtPASSWRD.Text := DecStr(Aobj.FieldByName('PASSWRD').AsString,ENC_KEY);
    edtPASSWRD1.Text := edtPASSWRD.Text;
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmTenantInfo.Save;
begin
  WriteToObject(Aobj,Self);
  Aobj.FieldByName('PASSWRD').AsString := EncStr(edtPASSWRD.Text,ENC_KEY);
  CdsTable.Edit;
  Aobj.WriteToDataSet(CdsTable);
  CdsTable.Post;
  if Factor.UpdateBatch(CdsTable,'TTenant',nil) then
    ModalResult := mrOk;
end;

procedure TfrmTenantInfo.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnOk.Visible := (Value <> dsBrowse);
  if Value = dsBrowse then
    begin
      Self.Caption := '企业信息';
      Label17.Visible := False;
      Label18.Visible := False;
      edtPASSWRD1.Visible := False;
    end
  else if Value = dsEdit then
    begin
      Self.Caption := '企业信息--(修改)';
      Label17.Visible := True;
      Label18.Visible := True;
      edtPASSWRD1.Visible := True;
    end

end;

class function TfrmTenantInfo.ShowDialog(Ower: TForm; Id: Integer): Boolean;
begin
  with TfrmTenantInfo.Create(Ower) do
    begin
      try
        Open(Id);
        Result := (ShowModal = mrOk);
      finally
        Free;
      end;
    end;
end;

procedure TfrmTenantInfo.FormCreate(Sender: TObject);
begin
  inherited;
  Aobj := TRecord_.Create;
  edtREGION_ID.DataSet := Global.GetZQueryFromName('PUB_REGION_INFO');
end;

procedure TfrmTenantInfo.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
end;

procedure TfrmTenantInfo.edtTENANT_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  If dbState <> dsBrowse Then
     edtTENANT_SPELL.Text := FnString.GetWordSpell(edtTENANT_NAME.Text);
end;

procedure TfrmTenantInfo.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
