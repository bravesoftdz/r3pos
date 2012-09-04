unit ufrmDeposit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxMemo, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls,
  RzLabel, DB, ZBase, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  cxMaskEdit, cxDropDownEdit, cxButtonEdit, zrComboBoxList;

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
    Label1: TLabel;
    edtACCOUNT_ID: TzrComboBoxList;
    Label2: TLabel;
    edtITEM_ID: TzrComboBoxList;
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtIC_AMONEYExit(Sender: TObject);
    procedure edtIC_AMONEYPropertiesChange(Sender: TObject);
    procedure edtPAY_CASHEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPAY_CASHPropertiesChange(Sender: TObject);
    procedure edtPAYPropertiesChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtACCOUNT_IDAddClick(Sender: TObject);
    procedure edtACCOUNT_IDSaveValue(Sender: TObject);
    procedure edtITEM_IDAddClick(Sender: TObject);
  private
    cid:string;
    { Private declarations }
  public
    procedure InitCmb;
    class function Open(CUST_ID:string;var NEW_BALANCE:string):Boolean;
    { Public declarations }
  end;

implementation
uses uGlobal,uShopGlobal,uDsUtil,uFnUtil, uShopUtil, ufrmBasic, ufrmAccountInfo, ufrmCodeInfo;
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
    Params,Params1:TftParamList;
    rs1,rs2,rs3:TZQuery;
begin
  inherited;
  if edtACCOUNT_ID.AsString = '' then
  begin
     if edtACCOUNT_ID.CanFocus then edtACCOUNT_ID.SetFocus;
     Raise Exception.Create('请选择帐户名称');
  end;
  if edtITEM_ID.AsString = '' then
  begin
     if edtITEM_ID.CanFocus then edtITEM_ID.SetFocus;
     Raise Exception.Create('请选择收支科目名称');
  end;
  if Trim(edtIC_AMONEY.Text)='' then
  begin
    if edtIC_AMONEY.CanFocus then edtIC_AMONEY.SetFocus;
    Raise Exception.Create('充值金额不能为空!');
  end
  else
  begin
    try
      StrToFloat(Trim(edtIC_AMONEY.Text));
    except
      if edtIC_AMONEY.CanFocus then edtIC_AMONEY.SetFocus;
      Raise Exception.Create('充值金额不是有效的数字!');
    end;
  end;
  if StrToFloat(Trim(edtIC_AMONEY.Text))=0 then
  begin
    if edtIC_AMONEY.CanFocus then edtIC_AMONEY.SetFocus;
    Raise Exception.Create('充值金额不能为0!');
  end;
  if Trim(edtPAY.Text)='' then
  begin
    if edtPAY.CanFocus then edtPAY.SetFocus;
    Raise Exception.Create('支付现金不能为空!');
  end;
  edtPAY.Text:= FloatToStr(StrToFloatDef(Trim(edtPAY.Text),0));
  if StrToFloat(Trim(edtPAY.Text))=0 then
  begin
    if edtPAY.CanFocus then edtPAY_CASH.SetFocus;
    Raise Exception.Create('支付不能为0!');
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
  cdsTable1.FieldByName('PAY_A').AsFloat :=0;
  cdsTable1.FieldByName('PAY_B').AsFloat :=0;
  cdsTable1.FieldByName('PAY_C').AsFloat :=0;
  cdsTable1.FieldByName('PAY_D').AsFloat :=0;
  cdsTable1.FieldByName('PAY_E').AsFloat :=0;
  cdsTable1.FieldByName('PAY_F').AsFloat :=0;
  cdsTable1.FieldByName('PAY_G').AsFloat :=0;
  cdsTable1.FieldByName('PAY_H').AsFloat :=0;
  cdsTable1.FieldByName('PAY_I').AsFloat :=0;
  cdsTable1.FieldByName('PAY_J').AsFloat :=0;
  cdsTable1.FieldByName(Str_Pay).AsFloat :=StrToFloatDef(edtPAY.Text,0);
  cdsTable1.Post;
  Params1 := TftParamList.Create;
  Params := TftParamList.Create;
  rs1 := TZQuery.Create(nil);
  rs2 := TZQuery.Create(nil);
  try
    Params.ParamByName('RECV_MNY').AsFloat := cdsTable1.FieldByName(Str_Pay).AsFloat;
    Factor.BeginBatch;
    try
      Params1.ParamByName('TENANT_ID').asInteger := Global.TENANT_ID;
      Params1.ParamByName('RECV_ID').asString := '';
      Factor.AddBatch(rs1,'TRecvOrder',Params1);
      Factor.AddBatch(rs2,'TRecvData',Params1);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    rs3 := ShopGlobal.GetDeptInfo;
    Params.ParamByName('DEPT_ID').AsString := rs3.FieldbyName('DEPT_ID').AsString;
    rs1.Append;
    rs1.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs1.FieldbyName('SHOP_ID').AsString := ShopGlobal.SHOP_ID;
    rs1.FieldbyName('RECV_ID').AsString := TSequence.NewId;
    rs1.FieldbyName('DEPT_ID').AsString := Params.ParamByName('DEPT_ID').AsString;
    rs1.FieldbyName('RECV_FLAG').AsString := '0';
    rs1.FieldbyName('ACCOUNT_ID').AsString := edtACCOUNT_ID.AsString;
    rs1.FieldbyName('PAYM_ID').AsString := TRecord_(edtPAY_CASH.Properties.Items.Objects[edtPAY_CASH.ItemIndex]).FieldbyName('CODE_ID').AsString;
    Params.ParamByName('PAYM_ID').AsString := rs1.FieldbyName('PAYM_ID').AsString;
    rs1.FieldbyName('RECV_MNY').AsFloat := StrToFloatDef(edtPAY.Text,0);
    rs1.FieldbyName('CLIENT_ID').AsString := cid;
    rs1.FieldbyName('ITEM_ID').AsString := edtITEM_ID.AsString;
    rs1.FieldbyName('RECV_DATE').AsInteger := StrToInt(FormatDatetime('YYYYMMDD',date()));
    rs1.FieldbyName('RECV_USER').AsString := Global.UserID;
    rs1.FieldbyName('CHK_DATE').AsString := FormatDatetime('YYYY-MM-DD',date());
    rs1.FieldbyName('CHK_USER').AsString := Global.UserID;
    rs1.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYY-MM-DD HH:NN:SS',now());
    rs1.FieldbyName('CREA_USER').AsString := Global.UserID;
    rs1.FieldbyName('REMARK').AsString := '储值卡充值';
    rs1.Post;
    rs2.Append;
    rs2.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs2.FieldbyName('SHOP_ID').AsString := rs1.FieldbyName('SHOP_ID').AsString;
    rs2.FieldbyName('RECV_ID').AsString := rs1.FieldbyName('RECV_ID').AsString;
    rs2.FieldbyName('SEQNO').AsInteger := 1;
    rs2.FieldbyName('ABLE_ID').AsString := cdsTable1.FieldByName('GLIDE_ID').AsString;
    rs2.FieldbyName('RECV_TYPE').AsString := '5';
    rs2.FieldbyName('RECV_MNY').AsFloat := rs1.FieldbyName('RECV_MNY').AsFloat;
    rs2.Post;
    Params.ParamByName('PAYM_ID').AsString := TRecord_(edtPAY_CASH.Properties.Items.Objects[edtPAY_CASH.ItemIndex]).FieldbyName('CODE_ID').AsString;
    Params.ParamByName('ACCT_MNY').AsFloat := StrToFloatDef(edtPAY.Text,0);
    Params.ParamByName('RECV_TYPE').AsString := '5';
    Params.ParamByName('ACCT_INFO').AsString := '储值卡充值';
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsTable1,'TDeposit',Params);
      Factor.AddBatch(rs1,'TRecvOrder');
      Factor.AddBatch(rs2,'TRecvData');
      Factor.CommitBatch;
      ShopGlobal.SaveFormatIni('cache','ACCOUNT_ID',edtACCOUNT_ID.DataSet.FieldByName('ACCOUNT_ID').AsString);
      MessageBox(Handle,pchar('充值成功!'),pchar(Application.Title),MB_OK);
    except
      Factor.CancelBatch;
      raise;
    end;
  finally
    Params1.Free;
    Params.Free;
    rs1.Free;
    rs2.Free;
  end;
  ModalResult:=MROK;
end;

procedure TfrmDeposit.btnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmDeposit.FormShow(Sender: TObject);
var i:Integer;
begin
  inherited;
  InitCmb;
  edtACCOUNT_ID.DataSet.Locate('ACCOUNT_ID',ShopGlobal.LoadFormatIni('cache','ACCOUNT_ID'),[]);
  edtACCOUNT_ID.KeyValue := edtACCOUNT_ID.DataSet.FieldbyName('ACCOUNT_ID').asString;
  edtACCOUNT_ID.Text := edtACCOUNT_ID.DataSet.FieldbyName('ACCT_NAME').asString;
  if edtPAY_CASH.Properties.Items.Count > 0 then
  begin
    i := TdsItems.FindItems(edtPAY_CASH.Properties.Items,'CODE_ID',edtACCOUNT_ID.DataSet.FieldbyName('PAYM_ID').asString);
    if i < 0 then
      edtPAY_CASH.ItemIndex := 0
    else
      edtPAY_CASH.ItemIndex := i;
  end;
  edtITEM_ID.DataSet.Locate('CODE_ID','1',[]);
  edtITEM_ID.KeyValue := edtITEM_ID.DataSet.FieldbyName('CODE_ID').asString;
  edtITEM_ID.Text := edtITEM_ID.DataSet.FieldbyName('CODE_NAME').asString;
    
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

procedure TfrmDeposit.FormCreate(Sender: TObject);
begin
  inherited;
  edtACCOUNT_ID.DataSet := Global.GetZQueryFromName('ACC_ACCOUNT_INFO');
  edtITEM_ID.DataSet := Global.GetZQueryFromName('ACC_ITEM_INFO');
end;

procedure TfrmDeposit.edtACCOUNT_IDAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21100001',2) then Raise Exception.Create('你没有新增账户的权限,请和管理员联系.');
  r := TRecord_.Create;
  try
    if TfrmAccountInfo.AddDialog(self,r) then
       begin
         edtACCOUNT_ID.KeyValue := r.FieldbyName('ACCOUNT_ID').AsString;
         edtACCOUNT_ID.Text := r.FieldbyName('ACCT_NAME').AsString;
       end;
  finally
    r.Free;
  end;  
end;

procedure TfrmDeposit.edtACCOUNT_IDSaveValue(Sender: TObject);
begin
  inherited;
  if edtACCOUNT_ID.AsString = '' then Exit;
  edtPAY_CASH.ItemIndex := TdsItems.FindItems(edtPAY_CASH.Properties.Items,'CODE_ID',edtACCOUNT_ID.DataSet.FieldByName('PAYM_ID').AsString);

end;

procedure TfrmDeposit.edtITEM_IDAddClick(Sender: TObject);
var
  r:TRecord_;
begin
  inherited;
  if not ShopGlobal.GetChkRight('21200001',2) then Raise Exception.Create('你没有新增科目的权限,请和管理员联系.');
  r := TRecord_.Create;
  try
    if TfrmCodeInfo.AddDialog(self,r,3) then
       begin
         edtITEM_ID.KeyValue := r.FieldbyName('CODE_ID').AsString;
         edtITEM_ID.Text := r.FieldbyName('CODE_NAME').AsString;
       end;
  finally
    r.Free;
  end;
end;

end.
