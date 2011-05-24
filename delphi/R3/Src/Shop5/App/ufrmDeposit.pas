unit ufrmDeposit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxMemo, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls,
  RzLabel, DB, ZBase, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxMaskEdit, cxDropDownEdit;

type
  TfrmDeposit = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    btnClose: TRzBitBtn;
    edt: TRzLabel;
    edtBALANCE: TcxTextEdit;
    RzLabel2: TRzLabel;
    edtGLIDE_INFO: TcxMemo;
    RzLabel1: TRzLabel;
    edtIC_AMONEY: TcxTextEdit;
    RzLabel3: TRzLabel;
    edtNewBALANCE: TcxTextEdit;
    RzLabel4: TRzLabel;
    edtCUST_CODE: TcxTextEdit;
    RzLabel5: TRzLabel;
    edtCUST_NAME: TcxTextEdit;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    edtPAY: TcxTextEdit;
    cdsTable1: TZQuery;
    cdsTable: TZQuery;
    edtPAY_CASH: TcxComboBox;
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtIC_AMONEYExit(Sender: TObject);
    procedure edtIC_AMONEYPropertiesChange(Sender: TObject);
    procedure edtPAY_CASHEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPAY_CASHPropertiesChange(Sender: TObject);
    procedure edtPAYPropertiesChange(Sender: TObject);
  private
    cid:string;
    { Private declarations }
  public
    procedure InitCmb;
    class function Open(CUST_ID:string;var NEW_BALANCE:string):Boolean;
    { Public declarations }
  end;

implementation
uses uGlobal,uDsUtil,uFnUtil, uShopUtil, ufrmBasic;
{$R *.dfm}

{ TfrmDeposit }

class function TfrmDeposit.Open(CUST_ID:string;var NEW_BALANCE:string):Boolean;
var  Params,Params1:TftParamList;
begin
  with TfrmDeposit.Create(nil) do
    begin
      try
        Params:=TftParamList.Create(nil);
        try
          cid:=CUST_ID;
          Params.ParamByName('CLIENT_ID').asString := CUST_ID;
          Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
          Params.ParamByName('UNION_ID').asString := '#';
          cdsTable.Close;
          Factor.Open(cdsTable,'TNewCard',Params);
          edtCUST_CODE.Text := cdsTable.FieldByName('IC_CARDNO').AsString;
          edtCUST_NAME.Text := cdsTable.FieldByName('CLIENT_NAME').AsString;
          edtBALANCE.Text := cdsTable.FieldByName('BALANCE').AsString;

          if (cdsTable.FieldByName('IC_STATUS').AsInteger in [0,1]) and (cdsTable.FieldbyName('IC_CARDNO').AsString <> '') then
            btnOk.Enabled := True
          else
            btnOk.Enabled := False;

          edtNewBALANCE.Text:=edtBALANCE.Text;
          Params1:=TftParamlist.Create(nil);
          try
            Params1.ParamByName('GLIDE_ID').asString := '';
            Params1.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            Factor.Open(cdsTable1,'TDeposit',Params1);
          finally
            Params1.Free;
          end;
        finally
          Params.Free;
        end;
        dbState:=dsEdit;
        result := (ShowModal=MROK);
        if result then
          NEW_BALANCE:=edtNewBALANCE.Text;
      finally
        free;
      end;
    end;
end;

procedure TfrmDeposit.btnOkClick(Sender: TObject);
var Str_Pay:String;
begin
  inherited;
  if Trim(edtIC_AMONEY.Text)='' then
  begin
    if edtIC_AMONEY.CanFocus then edtIC_AMONEY.SetFocus;
    Raise Exception.Create('充值金额不能为空!');
  end;
  try
    StrToFloat(Trim(edtIC_AMONEY.Text));
  except
    if edtIC_AMONEY.CanFocus then edtIC_AMONEY.SetFocus;
    Raise Exception.Create('充值金额不是有效的数字!');
  end;
  if StrToFloat(Trim(edtIC_AMONEY.Text))<0 then
  begin
    if edtIC_AMONEY.CanFocus then edtIC_AMONEY.SetFocus;
    Raise Exception.Create('充值金额不能小于0!');
  end;

  edtPAY.Text:= FloatToStr(StrToFloatDef(Trim(edtPAY.Text),0));
  if StrToFloat(Trim(edtPAY.Text))<0 then
  begin
    if edtPAY.CanFocus then edtPAY_CASH.SetFocus;
    Raise Exception.Create('支付不能小于0!');
  end;

  if StrToFloat(edtPAY.Text)>StrToFloat(edtIC_AMONEY.Text) then
  begin
    if edtPAY.CanFocus then edtPAY.SetFocus;
    Raise Exception.Create('支付现金不能大于充值金额!');
  end;

  if Trim(edtGLIDE_INFO.Text)='' then
  begin
    edtGLIDE_INFO.Text:='充值';
  end;
  Str_Pay := 'PAY_'+TRecord_(edtPAY_CASH.Properties.Items.Objects[edtPAY_CASH.ItemIndex]).FieldbyName('CODE_ID').AsString;
  cdsTable1.Append;
  cdsTable1.FieldByName('GLIDE_ID').AsString :=TSequence.NewId;
  cdsTable1.FieldByName('IC_CARDNO').AsString :=edtCUST_CODE.Text;
  cdsTable1.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsTable1.FieldByName('SHOP_ID').AsString :=Global.SHOP_ID;
  cdsTable1.FieldByName('CLIENT_ID').AsString :=cid;
  cdsTable1.FieldByName('SALES_ID').AsString :='';
  cdsTable1.FieldByName('CREA_USER').AsString :=Global.UserID;
  cdsTable1.FieldByName('CREA_DATE').AsInteger :=StrToInt(FormatDateTime('YYYYMMDD',Date));
  cdsTable1.FieldByName('IC_GLIDE_TYPE').AsString:='1';
  cdsTable1.FieldByName('GLIDE_MNY').AsFloat :=StrToFloat(edtIC_AMONEY.Text);
  cdsTable1.FieldByName('GLIDE_INFO').AsString :=Trim(edtGLIDE_INFO.Text);
  cdsTable1.FieldByName(Str_Pay).AsFloat :=StrToFloatDef(edtPAY.Text,0);
  cdsTable1.Post;
  if Factor.UpdateBatch(cdsTable1,'TDeposit',nil) then
  begin
    MessageBox(Handle,pchar('充值成功!'),pchar(Application.Title),MB_OK);
  end;
  ModalResult:=MROK;
end;

procedure TfrmDeposit.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDeposit.FormShow(Sender: TObject);
begin
  inherited;
  InitCmb;
  edtPAY_CASH.ItemIndex := 0;
  if edtIC_AMONEY.CanFocus then edtIC_AMONEY.SetFocus;
end;

procedure TfrmDeposit.edtIC_AMONEYExit(Sender: TObject);
begin
  inherited;
  edtIC_AMONEY.Text:=FloatToStr(StrToFloatDef(edtIC_AMONEY.Text,0));
  edtNewBALANCE.Text:=FloatToStr(StrToFloatDef(edtBALANCE.Text,0)+StrToFloatDef(edtIC_AMONEY.Text,0));
end;

procedure TfrmDeposit.edtIC_AMONEYPropertiesChange(Sender: TObject);
begin
  inherited;
  edtNewBALANCE.Text:=FloatToStr(StrToFloatDef(edtBALANCE.Text,0)+StrToFloatDef(edtIC_AMONEY.Text,0));
  
  if (StrToFloatDef(edtPAY.Text,0)>0) and (StrToFloatDef(edtIC_AMONEY.Text,0)>0) then
    edtGLIDE_INFO.Text := RzLabel3.Caption+' '+edtIC_AMONEY.Text+'元 '+edtPAY_CASH.Text+'支付 '+edtPAY.Text+'元 优惠金额 '+
    FloatToStr(StrToFloatDef(edtIC_AMONEY.Text,0)-StrToFloatDef(edtPAY.Text,0));
end;

procedure TfrmDeposit.edtPAY_CASHEnter(Sender: TObject);
begin
  inherited;
  if edtIC_AMONEY.Text<>'' then edtPAY_CASH.Text:=edtIC_AMONEY.Text;
end;

procedure TfrmDeposit.InitCmb;
var rs:TZQuery;
    Aobj_Pay:TRecord_;
begin
  rs := Global.GetZQueryFromName('PUB_PAYMENT');

  rs.First;
  while not rs.Eof do
    begin
      if (rs.FieldByName('CODE_ID').AsString = 'C') or (rs.FieldByName('CODE_ID').AsString = 'D') or (rs.FieldByName('CODE_ID').AsString = 'G') then
        begin
          rs.Next;
          Continue;
        end;
      Aobj_Pay := TRecord_.Create;
      Aobj_Pay.ReadFromDataSet(rs);
      edtPAY_CASH.Properties.Items.AddObject(rs.FieldbyName('CODE_NAME').AsString,Aobj_Pay);
      rs.Next;
    end;
end;

procedure TfrmDeposit.FormDestroy(Sender: TObject);
begin
  inherited;
  Freeform(Self);
end;

procedure TfrmDeposit.edtPAY_CASHPropertiesChange(Sender: TObject);
begin
  inherited;
  edtGLIDE_INFO.Text := edtPAY_CASH.Text;

  edtPAYPropertiesChange(Sender);
end;

procedure TfrmDeposit.edtPAYPropertiesChange(Sender: TObject);
begin
  inherited;
  if StrToFloatDef(edtPAY.Text,0)<0 then
     edtPAY.Text := '0';

  if StrToFloatDef(edtPAY.Text,0) > StrToFloatDef(edtIC_AMONEY.Text,0) then
    Raise Exception.Create('支付现金不允许大于充值金额');

  if (StrToFloatDef(edtPAY.Text,0)>0) and (StrToFloatDef(edtIC_AMONEY.Text,0)>0) then
    edtGLIDE_INFO.Text := RzLabel3.Caption+' '+edtIC_AMONEY.Text+'元 '+edtPAY_CASH.Text+'支付 '+edtPAY.Text+'元 优惠金额 '+
    FloatToStr(StrToFloatDef(edtIC_AMONEY.Text,0)-StrToFloatDef(edtPAY.Text,0));

end;                           

end.
