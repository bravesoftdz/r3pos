unit ufrmIntegralGlide_Add;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, StdCtrls, RzButton,
  cxMaskEdit, cxDropDownEdit, DB, cxSpinEdit, ZAbstractRODataset, ZBase,
  ZAbstractDataset, ZDataset;

type
  TfrmIntegralGlide_Add = class(TframeDialogForm)
    Label1: TLabel;
    Bevel1: TBevel;
    edtGLIDE_INFO: TcxMemo;
    Label2: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    edtIC_CARDNO: TcxTextEdit;
    edtCLIENT_NAME: TcxTextEdit;
    Label5: TLabel;
    edtINTEGRAL: TcxTextEdit;
    Label6: TLabel;
    edtACCU_INTEGRAL: TcxTextEdit;
    Label7: TLabel;
    edtPRICE_NAME: TcxTextEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtINTEGRAL_FLAG: TcxComboBox;
    btnOK: TRzBitBtn;
    btnCancel: TRzBitBtn;
    edtFLAG_AMT: TcxSpinEdit;
    cdsTable: TZQuery;
    labUnit: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtFLAG_AMTPropertiesChange(Sender: TObject);
    procedure edtINTEGRAL_FLAGPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cid:string;
    AObj:TRecord_;
    procedure InitCmb;
    procedure Open(CUST_ID:string);
    class function IntegralGlide(AOwner:TForm;CUST_ID:string;_AObj:TRecord_):boolean;
  end;

implementation
uses uGlobal,uShopUtil,uDsUtil,ufrmBasic;
{$R *.dfm}

procedure TfrmIntegralGlide_Add.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmIntegralGlide_Add.IntegralGlide(AOwner: TForm;
  CUST_ID: string;_AObj:TRecord_): boolean;
begin
  with TfrmIntegralGlide_Add.Create(AOwner) do
    begin
      try
        Open(CUST_ID);
        edtINTEGRAL_FLAG.ItemIndex := 0;
        edtGLIDE_INFO.Text:='积分兑换';
        result := (ShowModal=MROK);
        if result then
           _AObj.ReadFromDataSet(cdsTable); 
      finally
        free;
      end;
    end;
end;

procedure TfrmIntegralGlide_Add.Open(CUST_ID: string);
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :=
    'select j.CLIENT_ID,j.CLIENT_NAME,j.IC_CARDNO,j.ACCU_INTEGRAL,j.RULE_INTEGRAL,j.INTEGRAL,j.BALANCE,p.PRICE_NAME from VIW_CUSTOMER j '+
    'left outer join PUB_PRICEGRADE p on j.PRICE_ID=p.PRICE_ID and j.TENANT_ID=p.TENANT_ID where j.FLAG in (0,2) and j.TENANT_ID=:TENANT_ID and j.CLIENT_ID=:CLIENT_ID ';
    rs.Params.ParamByName('CLIENT_ID').AsString := CUST_ID;
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(rs);
    AObj.ReadFromDataSet(rs);
    ReadFromObject(AObj,self);
  finally
    rs.Free;
  end;
end;

procedure TfrmIntegralGlide_Add.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
  dbState := dsEdit;
end;

procedure TfrmIntegralGlide_Add.FormDestroy(Sender: TObject);
begin
  AObj.Free;
  Freeform(Self);
  inherited;
end;

procedure TfrmIntegralGlide_Add.btnOKClick(Sender: TObject);
var
  Params:TftParamList;
  str:string;
begin
  inherited;
  if edtINTEGRAL_FLAG.ItemIndex = -1 then Raise Exception.Create('对换方式不能为空.');
  if edtFLAG_AMT.Value = 0 then Raise Exception.Create('对换数量不能为零.');
  if trim(edtGLIDE_INFO.Text) = '' then Raise Exception.Create('摘要不能为空.');
  if edtINTEGRAL.Text='' then str:='0'
  else str:=edtINTEGRAL.Text;
//  if StrToFloat(str)<StrToFloat(edtUSING_INTEGRAL.Text) then Raise Exception.Create('兑换积分不能大于可用积分!');
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('GLIDE_ID').asString := '';
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.Close;
    Factor.Open(cdsTable,'TIntegralGlide',Params);
    cdsTable.Append;
    cdsTable.FieldByName('GLIDE_ID').AsString := TSequence.NewId;;
    cdsTable.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsTable.FieldByName('SHOP_ID').AsString := Global.SHOP_ID;
    cdsTable.FieldByName('IC_CARDNO').AsString := AObj.FieldbyName('IC_CARDNO').AsString;
    cdsTable.FieldByName('CLIENT_ID').AsString := AObj.FieldbyName('CLIENT_ID').AsString;
    cdsTable.FieldByName('CREA_DATE').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',Date));
    cdsTable.FieldByName('CREA_USER').AsString := Global.UserID;
    cdsTable.FieldByName('INTEGRAL_FLAG').AsString := TRecord_(edtINTEGRAL_FLAG.Properties.Items.Objects[edtINTEGRAL_FLAG.ItemIndex]).FieldbyName('CODE_ID').AsString;
    cdsTable.FieldByName('GLIDE_INFO').AsString := Trim(edtGLIDE_INFO.Text);
    cdsTable.FieldByName('INTEGRAL').AsFloat := StrtoFloatDef(edtFLAG_AMT.Text,0);
    cdsTable.FieldByName('GLIDE_AMT').AsFloat := StrtoFloatDef(edtFLAG_AMT.Text,0);
    cdsTable.Post;
    Factor.UpdateBatch(cdsTable,'TIntegralGlide',Params);
//    Factor.ExecSQL('UPDATE BAS_CUSTOMER set INTEGRAL=ISNULL(INTEGRAL,0)-'+FloatToStr(StrtoFloatDef(edtUSING_INTEGRAL.Text,0))+' WHERE CUST_ID='+QuotedStr(AObj.FieldbyName('CUST_ID').AsString));
    self.ModalResult := MROK;
  finally
    Params.Free;
  end;
end;

procedure TfrmIntegralGlide_Add.FormShow(Sender: TObject);
begin
  inherited;
  edtINTEGRAL_FLAG.SetFocus;
  InitCmb;
  edtINTEGRAL_FLAG.ItemIndex := 0;
end;

procedure TfrmIntegralGlide_Add.edtFLAG_AMTPropertiesChange(Sender: TObject);
begin
  inherited;
  if StrToFloatDef(edtFLAG_AMT.Value,0)<0 then
    edtFLAG_AMT.EditValue:='0';

  if  (StrToFloatDef(edtFLAG_AMT.Value,0)>0) then
    edtGLIDE_INFO.Text := ' 赠送积分：'+edtFLAG_AMT.Text+' 分';
end;

procedure TfrmIntegralGlide_Add.InitCmb;
var rs:TZQuery;
    Aobj_1:TRecord_;
begin
  ClearCbxPickList(edtINTEGRAL_FLAG);
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select CODE_ID,CODE_NAME,TYPE_CODE,COMM,TIME_STAMP from PUB_PARAMS where TYPE_CODE=''INTEGRAL_FLAG'' and CODE_ID=''1'' ';
    Factor.Open(rs);
    rs.First;
    while not rs.Eof do
      begin
        Aobj_1 := TRecord_.Create;
        Aobj_1.ReadFromDataSet(rs);
        edtINTEGRAL_FLAG.Properties.Items.AddObject(rs.FieldByName('CODE_NAME').AsString,Aobj_1);
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

procedure TfrmIntegralGlide_Add.edtINTEGRAL_FLAGPropertiesChange(
  Sender: TObject);
begin
  inherited;
  edtGLIDE_INFO.Text := edtINTEGRAL_FLAG.Text;
end;

end.
