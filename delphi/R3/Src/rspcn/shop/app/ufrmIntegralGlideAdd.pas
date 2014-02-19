unit ufrmIntegralGlideAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxSpinEdit, cxMemo, ZBase, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmIntegralGlideAdd = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    Bevel4: TBevel;
    RzLabel4: TRzLabel;
    edtBK_IC_CARDNO: TRzPanel;
    RzPanel30: TRzPanel;
    RzLabel2: TRzLabel;
    edtIC_CARDNO: TcxTextEdit;
    edtBK_CLIENT_NAME: TRzPanel;
    RzPanel3: TRzPanel;
    RzLabel3: TRzLabel;
    edtCLIENT_NAME: TcxTextEdit;
    edtBK_INTEGRAL: TRzPanel;
    RzPanel4: TRzPanel;
    RzLabel5: TRzLabel;
    edtINTEGRAL: TcxTextEdit;
    edtBK_ACCU_INTEGRAL: TRzPanel;
    RzPanel6: TRzPanel;
    RzLabel6: TRzLabel;
    edtACCU_INTEGRAL: TcxTextEdit;
    edtBK_INTEGRAL_FLAG: TRzPanel;
    RzPanel8: TRzPanel;
    RzLabel7: TRzLabel;
    edtINTEGRAL_FLAG: TcxComboBox;
    edtBK_FLAG_AMT: TRzPanel;
    RzPanel5: TRzPanel;
    RzLabel8: TRzLabel;
    edtFLAG_AMT: TcxSpinEdit;
    RzLabel9: TRzLabel;
    Bevel1: TBevel;
    btnSave: TRzBmpButton;
    btnCancel: TRzBmpButton;
    cdsTable: TZQuery;
    RzPanel2: TRzPanel;
    edtGLIDE_INFO: TcxMemo;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    AObj:TRecord_;
    procedure Init;
    procedure Open(CUST_ID:string);
    procedure Save;
  public
    class function IntegralGlide(AOwner:TForm;CUST_ID:string;SObj:TRecord_):boolean;
  end;

implementation

uses uTokenFactory,udataFactory,udllShopUtil,udllDsUtil;

{$R *.dfm}

procedure TfrmIntegralGlideAdd.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmIntegralGlideAdd.IntegralGlide(AOwner: TForm; CUST_ID: string; SObj: TRecord_): boolean;
begin
  with TfrmIntegralGlideAdd.Create(AOwner) do
    begin
      try
        Open(CUST_ID);
        edtINTEGRAL_FLAG.ItemIndex := 0;
        edtGLIDE_INFO.Text:='积分赠送';
        result := (ShowModal=MROK);
        if result then SObj.ReadFromDataSet(cdsTable);
      finally
        Free;
      end;
    end;
end;

procedure TfrmIntegralGlideAdd.Open(CUST_ID: string);
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
    ' select j.CLIENT_ID,j.CLIENT_NAME,j.IC_CARDNO,j.ACCU_INTEGRAL,j.RULE_INTEGRAL,j.INTEGRAL,j.BALANCE from VIW_CUSTOMER j '+
    ' where  j.FLAG in (0,2) and j.TENANT_ID=:TENANT_ID and j.CLIENT_ID=:CLIENT_ID ';
    rs.Params.ParamByName('CLIENT_ID').AsString := CUST_ID;
    rs.Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    dataFactory.Open(rs);
    AObj.ReadFromDataSet(rs);
    ReadFromObject(AObj,self);
  finally
    rs.Free;
  end;
end;

procedure TfrmIntegralGlideAdd.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  dbState := dsEdit;
end;

procedure TfrmIntegralGlideAdd.FormDestroy(Sender: TObject);
begin
  AObj.Free;
  FreeForm(self);
  inherited;
end;

procedure TfrmIntegralGlideAdd.btnSaveClick(Sender: TObject);
begin
  inherited;
  Save;
end;

procedure TfrmIntegralGlideAdd.Save;
var
  str:string;
  Params:TftParamList;
begin
  inherited;
  if edtINTEGRAL_FLAG.ItemIndex = -1 then Raise Exception.Create('对换方式不能为空.');
  if edtFLAG_AMT.Value = 0 then Raise Exception.Create('赠送积分不能为零.');
  if edtINTEGRAL.Text='' then str:='0' else str:=edtINTEGRAL.Text;

  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('GLIDE_ID').asString := '';
    Params.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    cdsTable.Close;
    dataFactory.Open(cdsTable,'TIntegralGlideV60',Params);
    cdsTable.Append;
    cdsTable.FieldByName('GLIDE_ID').AsString := TSequence.NewId;
    cdsTable.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    cdsTable.FieldByName('SHOP_ID').AsString := token.shopId;
    cdsTable.FieldByName('IC_CARDNO').AsString := AObj.FieldbyName('IC_CARDNO').AsString;
    cdsTable.FieldByName('CLIENT_ID').AsString := AObj.FieldbyName('CLIENT_ID').AsString;
    cdsTable.FieldByName('CREA_DATE').AsInteger := strtoint(FormatDateTime('YYYYMMDD',Date));
    cdsTable.FieldByName('CREA_USER').AsString := token.userId;
    cdsTable.FieldByName('INTEGRAL_FLAG').AsString := TRecord_(edtINTEGRAL_FLAG.Properties.Items.Objects[edtINTEGRAL_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString;
    cdsTable.FieldByName('GLIDE_INFO').AsString := trim(edtGLIDE_INFO.Text);
    cdsTable.FieldByName('INTEGRAL').AsFloat := StrtoFloatDef(edtFLAG_AMT.Text,0);
    cdsTable.FieldByName('GLIDE_AMT').AsFloat := StrtoFloatDef(edtFLAG_AMT.Text,0);
    cdsTable.Post;
    dataFactory.UpdateBatch(cdsTable,'TIntegralGlideV60',Params);
    ModalResult := MROK;
  finally
    Params.Free;
  end;
end;

procedure TfrmIntegralGlideAdd.FormShow(Sender: TObject);
begin
  inherited;
  Init;
  edtINTEGRAL_FLAG.ItemIndex := 0;
  edtFLAG_AMT.SetFocus;

  edtIC_CARDNO.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtIC_CARDNO.Style);
  edtBK_IC_CARDNO.Color := edtIC_CARDNO.Style.Color;

  edtCLIENT_NAME.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtCLIENT_NAME.Style);
  edtBK_CLIENT_NAME.Color := edtCLIENT_NAME.Style.Color;

  edtINTEGRAL.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtINTEGRAL.Style);
  edtBK_INTEGRAL.Color := edtINTEGRAL.Style.Color;

  edtACCU_INTEGRAL.Properties.ReadOnly := true;
  SetEditStyle(dsBrowse,edtACCU_INTEGRAL.Style);
  edtBK_ACCU_INTEGRAL.Color := edtACCU_INTEGRAL.Style.Color;
end;

procedure TfrmIntegralGlideAdd.Init;
var
  rs:TZQuery;
  AObj_1:TRecord_;
begin
  ClearCbxPickList(edtINTEGRAL_FLAG);
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP from PUB_PARAMS where TYPE_CODE=''INTEGRAL_FLAG'' and CODE_ID=''1'' ';
    dataFactory.sqlite.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        AObj_1 := TRecord_.Create;
        AObj_1.ReadFromDataSet(rs);
        edtINTEGRAL_FLAG.Properties.Items.AddObject(rs.FieldByName('CODE_NAME').AsString,AObj_1);
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

end.
