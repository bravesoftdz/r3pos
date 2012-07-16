unit ufrmFilterUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel,
  cxMaskEdit, cxButtonEdit, zrComboBoxList, ZBase, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, ObjCommon;

type
  TGetUserInfo = procedure(_Aobj:TRecord_) of object;
  TfrmFilterUser = class(TframeDialogForm)
    btnOK: TRzBitBtn;
    btnExit: TRzBitBtn;
    Bevel1: TBevel;
    lab_CLIENT_CODE: TRzLabel;
    edtCLIENT_CODE: TcxTextEdit;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    lab_LINKMAN: TRzLabel;
    lab_TELEPHONE: TRzLabel;
    Bevel2: TBevel;
    fndCODE_NAME: TzrComboBoxList;
    fndROAD_NAME: TzrComboBoxList;
    fndCOMMUNITY: TzrComboBoxList;
    fndMANSION: TzrComboBoxList;
    cdsCODE_NAME: TZQuery;
    cdsROAD_NAME: TZQuery;
    cdsCOMMUNITY: TZQuery;
    cdsMANSION: TZQuery;
    RzLabel5: TRzLabel;
    fndHouseNumber: TzrComboBoxList;
    cdsHouseNumber: TZQuery;
    procedure edtCLIENT_CODEKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure fndCODE_NAMESaveValue(Sender: TObject);
    procedure fndROAD_NAMESaveValue(Sender: TObject);
    procedure fndCOMMUNITYSaveValue(Sender: TObject);
    procedure fndMANSIONSaveValue(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fndHouseNumberSaveValue(Sender: TObject);
  private
    { Private declarations }
    Aobj:TRecord_;
    FOnGetUserInfo: TGetUserInfo;
    procedure SetOnGetUserInfo(const Value: TGetUserInfo);
  public
    { Public declarations }
    property OnGetUserInfo:TGetUserInfo read FOnGetUserInfo write SetOnGetUserInfo;
  end;

implementation
uses uShopUtil,uDsUtil,ufrmBasic,Math,uGlobal,uFnUtil,uShopGlobal;
{$R *.dfm}

procedure TfrmFilterUser.edtCLIENT_CODEKeyPress(Sender: TObject;
  var Key: Char);
var rs:TZQuery;
begin
  inherited;
  if Key = #13 then
  begin
    rs := TZQuery.Create(nil);
    try
      Aobj.ReadFromDataSet(rs);
      fndCODE_NAME.KeyValue := '';
      fndCODE_NAME.Text := '';
      cdsROAD_NAME.Close;
      fndROAD_NAME.KeyValue := '';
      fndROAD_NAME.Text := '';
      cdsCOMMUNITY.Close;
      fndCOMMUNITY.KeyValue := '';
      fndCOMMUNITY.Text := '';
      cdsMANSION.Close;
      fndMANSION.KeyValue := '';
      fndMANSION.Text := '';
      cdsHouseNumber.Close;
      fndHouseNumber.KeyValue := '';
      fndHouseNumber.Text := '';
      lab_LINKMAN.Caption := '联系人:';
      lab_TELEPHONE.Caption := '联系电话:';
      rs.SQL.Text := 'select YQDZ_USERID_OLD,YQDZ_HZ_MC,YQDZ_LXDH,YQDZ_SM from YONGQIDIZHI where YQDZ_USERID_OLD='''+Trim(edtCLIENT_CODE.Text)+''' ';
      Factor.Open(rs);
      if not rs.IsEmpty then
      begin
         lab_LINKMAN.Caption := '联系人:'+rs.FieldByName('YQDZ_HZ_MC').AsString;
         lab_TELEPHONE.Caption := '联系电话:'+rs.FieldByName('YQDZ_LXDH').AsString;
      end;
    finally
      rs.Free;
    end;
  end;
end;

procedure TfrmFilterUser.FormCreate(Sender: TObject);
var str:String;
begin
  inherited;
  Aobj := TRecord_.Create;
  str := ' select YQBM_YQDZ_ID,YQBM_YQDZ_MS from YONGQIDIZHI_BIANMA where len(YQBM_YQDZ_ID)=2 ';
  cdsCODE_NAME.SQL.Text := ParseSQL(Factor.iDbType,str);
  Factor.Open(cdsCODE_NAME);
  
end;

procedure TfrmFilterUser.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj.Free;
end;

procedure TfrmFilterUser.SetOnGetUserInfo(const Value: TGetUserInfo);
begin
  FOnGetUserInfo := Value;
end;

procedure TfrmFilterUser.btnExitClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrIgnore;
end;

procedure TfrmFilterUser.btnOKClick(Sender: TObject);
begin
  inherited;
  if Assigned(OnGetUserInfo) then OnGetUserInfo(Aobj);
  ModalResult := mrOk;
end;

procedure TfrmFilterUser.fndCODE_NAMESaveValue(Sender: TObject);
var str:String;
begin
  inherited;
  cdsROAD_NAME.Close;
  str := ' select YQBM_YQDZ_ID,YQBM_YQDZ_MS from YONGQIDIZHI_BIANMA where len(YQBM_YQDZ_ID)=5 and substring(YQBM_YQDZ_ID,1,2)='+QuotedStr(Trim(fndCODE_NAME.AsString));
  cdsROAD_NAME.SQL.Text := ParseSQL(Factor.iDbType,str);
  Factor.Open(cdsROAD_NAME);
  fndROAD_NAME.KeyValue := '';
  fndROAD_NAME.Text := '';

  cdsCOMMUNITY.Close;
  fndCOMMUNITY.KeyValue := '';
  fndCOMMUNITY.Text := '';
  cdsMANSION.Close;
  fndMANSION.KeyValue := '';
  fndMANSION.Text := '';
  cdsHouseNumber.Close;
  fndHouseNumber.KeyValue := '';
  fndHouseNumber.Text := '';
  lab_LINKMAN.Caption := '联系人:';
  lab_TELEPHONE.Caption := '联系电话:';
end;

procedure TfrmFilterUser.fndROAD_NAMESaveValue(Sender: TObject);
var str:String;
begin
  inherited;
  cdsCOMMUNITY.Close;
  str := ' select YQBM_YQDZ_ID,YQBM_YQDZ_MS from YONGQIDIZHI_BIANMA where len(YQBM_YQDZ_ID)=8 and substring(YQBM_YQDZ_ID,1,5)='+QuotedStr(Trim(fndROAD_NAME.AsString));
  cdsCOMMUNITY.SQL.Text := ParseSQL(Factor.iDbType,str);
  Factor.Open(cdsCOMMUNITY);

  cdsMANSION.Close;
  str := ' select YQBM_YQDZ_ID,YQBM_YQDZ_MS from YONGQIDIZHI_BIANMA where len(YQBM_YQDZ_ID)=11 and substring(YQBM_YQDZ_ID,1,5)='+QuotedStr(Trim(fndROAD_NAME.AsString));
  cdsMANSION.SQL.Text := ParseSQL(Factor.iDbType,str);
  Factor.Open(cdsMANSION);

  fndCOMMUNITY.KeyValue := '';
  fndCOMMUNITY.Text := '';
  fndMANSION.KeyValue := '';
  fndMANSION.Text := '';
  cdsHouseNumber.Close;
  fndHouseNumber.KeyValue := '';
  fndHouseNumber.Text := '';
end;

procedure TfrmFilterUser.fndCOMMUNITYSaveValue(Sender: TObject);
var str:String;
begin
  inherited;
  if fndCOMMUNITY.AsString = '' then Exit;
  cdsMANSION.Close;
  str := ' select YQBM_YQDZ_ID,YQBM_YQDZ_MS from YONGQIDIZHI_BIANMA where len(YQBM_YQDZ_ID)=11 and substring(YQBM_YQDZ_ID,1,8)='+QuotedStr(Trim(fndCOMMUNITY.AsString));
  cdsMANSION.SQL.Text := ParseSQL(Factor.iDbType,str);
  Factor.Open(cdsMANSION);

  fndMANSION.KeyValue := '';
  fndMANSION.Text := '';
  cdsHouseNumber.Close;
  fndHouseNumber.KeyValue := '';
  fndHouseNumber.Text := '';
end;

procedure TfrmFilterUser.fndMANSIONSaveValue(Sender: TObject);
var str:String;
begin
  inherited;
  if fndMANSION.AsString = '' then Exit;
  cdsHouseNumber.Close;
  str := ' select YQDZ_ID,YQDZ_MIAOSHU from YONGQIDIZHI where Substring(YQDZ_YQDZM_ID,1,11)='+QuotedStr(Trim(fndMANSION.AsString));
  cdsHouseNumber.SQL.Text := ParseSQL(Factor.iDbType,str);
  Factor.Open(cdsHouseNumber);

  fndHouseNumber.KeyValue := '';
  fndHouseNumber.Text := '';
end;

procedure TfrmFilterUser.FormShow(Sender: TObject);
begin
  inherited;
  if edtCLIENT_CODE.CanFocus then edtCLIENT_CODE.SetFocus;
end;

procedure TfrmFilterUser.fndHouseNumberSaveValue(Sender: TObject);
var rs:TZQuery;
    str:String;
begin
  inherited;
  rs := TZQuery.Create(nil);
  try
    //str := 'select A.YQDZ_USERID_OLD,A.YQDZ_HZ_MC,A.YQDZ_LXDH,A.YQDZ_SM from YONGQIDIZHI A inner join YONGQIDIZHI_BIANMA B on Substring(A.YQDZ_YQDZM_ID,1,11)=B.YQBM_YQDZ_ID where B.YQBM_YQDZ_ID='''+Trim(fndMANSION.AsString)+''' ';
    str := 'select YQDZ_USERID_OLD,YQDZ_HZ_MC,YQDZ_LXDH,YQDZ_SM from YONGQIDIZHI where YQDZ_ID='''+Trim(fndHouseNumber.AsString)+''' ';
    rs.SQL.Text := ParseSQL(Factor.iDbType,str);
    Factor.Open(rs);
    if not rs.IsEmpty then
    begin
       lab_LINKMAN.Caption := '联系人:'+rs.FieldByName('YQDZ_HZ_MC').AsString;
       lab_TELEPHONE.Caption := '联系电话:'+rs.FieldByName('YQDZ_LXDH').AsString;
       edtCLIENT_CODE.Text := rs.FieldByName('YQDZ_USERID_OLD').AsString;
    end;
    Aobj.ReadFromDataSet(rs);
  finally
    rs.Free;
  end;
end;

end.
