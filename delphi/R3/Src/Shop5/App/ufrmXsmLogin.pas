unit ufrmXsmLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ExtCtrls, RzPanel, ActnList, Menus, RzButton,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, jpeg, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmXsmLogin = class(TfrmBasic)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    Image1: TImage;
    lblName: TLabel;
    lblPass: TLabel;
    edtPassword: TcxTextEdit;
    edtUsername: TcxTextEdit;
    cxBtnOk: TRzBitBtn;
    cxbtnCancel: TRzBitBtn;
    Label1: TLabel;
    edtUrl: TcxTextEdit;
    cdsUnion: TZQuery;
    procedure cxBtnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxbtnCancelClick(Sender: TObject);
  private
    Fflag: integer;
    procedure Setflag(const Value: integer);
    { Private declarations }
    //xsm_url,xsm_username,xsm_password :string;
  public
    { Public declarations }
    procedure ReadFrom;
    procedure WriteTo;
    procedure SetValue(ID,Value:String);
    class function XsmLogin:Boolean;
    class function XsmRegister:Boolean;
    property flag:integer read Fflag write Setflag;
  end;

implementation
uses ZBase,ufnUtil,ufrmLogo,uGlobal,EncDec,uShopGlobal,uDsUtil,ufrmIEWebForm,ObjCommon,
  ufrmXsmIEBrowser;
{$R *.dfm}

procedure TfrmXsmLogin.ReadFrom;
begin
  case flag of
  0:begin
      xsm_url := ShopGlobal.GetParameter('XSM_URL');
      xsm_username := ShopGlobal.GetParameter('XSM_USERNAME');
      xsm_password := DecStr(ShopGlobal.GetParameter('XSM_PASSWORD'),ENC_KEY);
      cdsUnion.Close;
      cdsUnion.SQL.Text := 'select * from SYS_DEFINE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and DEFINE like ''%_'+Global.SHOP_ID+'''';
      Factor.Open(cdsUnion);
      if cdsUnion.Locate('DEFINE','XSM_URL_'+Global.SHOP_ID,[]) then
        edtUrl.Text := copy(cdsUnion.FieldbyName('VALUE').AsString,8,length(cdsUnion.FieldbyName('VALUE').AsString)-8);
      if cdsUnion.Locate('DEFINE','XSM_USERNAME_'+Global.SHOP_ID,[]) then
        edtUsername.Text := cdsUnion.FieldbyName('VALUE').AsString;
      if cdsUnion.Locate('DEFINE','XSM_PASSWORD_'+Global.SHOP_ID,[]) then
        edtPassword.Text := DecStr(cdsUnion.FieldbyName('VALUE').AsString,ENC_KEY);
    end;
  1:begin
      cdsUnion.Close;
      cdsUnion.SQL.Text := 'select CUST_CODE,PASS_WORD from CA_SHOP_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SHOP_ID='''+Global.SHOP_ID+'''';
      Factor.Open(cdsUnion);
      edtUrl.Text := '新商盟主机';
      edtUrl.Enabled := false;
      xsm_username := cdsUnion.Fields[0].AsString;
      xsm_password := DecStr(cdsUnion.Fields[1].AsString,ENC_KEY);
      edtUsername.Text := cdsUnion.Fields[0].AsString;
    end;
  end;
end;

procedure TfrmXsmLogin.SetValue(ID, Value: String);
begin
  if cdsUnion.Locate('DEFINE',ID,[]) then
    cdsUnion.Edit
  else
    cdsUnion.Append;
  cdsUnion.FieldByName('DEFINE').AsString := ID;
  cdsUnion.FieldByName('TENANT_ID').AsString := IntToStr(Global.TENANT_ID);
  cdsUnion.FieldByName('VALUE').AsString := Value;
  cdsUnion.FieldByName('VALUE_TYPE').AsString := '0';
  cdsUnion.Post;
end;

procedure TfrmXsmLogin.WriteTo;
begin
  case flag of
  0:begin
      SetValue('XSM_URL_'+Global.SHOP_ID,'http://'+Trim(edtUrl.Text)+'/');
      SetValue('XSM_USERNAME_'+Global.SHOP_ID,Trim(edtUsername.Text));
      SetValue('XSM_PASSWORD_'+Global.SHOP_ID,EncStr(Trim(edtPassword.Text),ENC_KEY));
      Factor.UpdateBatch(cdsUnion,'TSysDefine');
    end;
  1:begin
      Factor.ExecSQL('update CA_SHOP_INFO set CUST_CODE='''+Trim(edtUsername.Text)+''',PASS_WORD='''+EncStr(Trim(edtPassword.Text),ENC_KEY)+''',COMM='''+GetCommStr(Factor.idbType)+''',TIME_STAMP='''+GetTimeStamp(Factor.idbType)+''' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+Global.SHOP_ID+'''');
    end;
  end;
end;

procedure TfrmXsmLogin.cxBtnOkClick(Sender: TObject);
begin
  inherited;
  if Trim(edtUrl.Text) = '' then
    begin
       edtUrl.SetFocus;
       Raise Exception.Create('请输入商盟地址。');
    end;
  if Trim(edtUsername.Text) = '' then
    begin
       edtUsername.SetFocus;
       Raise Exception.Create('请输入用户名。');
    end;
  if Trim(edtUsername.Text) = '' then
    begin
       edtUsername.SetFocus;
       Raise Exception.Create('请输入密码。');
    end;
  WriteTo;
  ModalResult := MROK;
end;

class function TfrmXsmLogin.XsmLogin: Boolean;
begin
  with TfrmXsmLogin.Create(nil) do
    begin
      try
        flag := 0;
        if ShowModal = mrOk then
          begin
            xsm_url := 'http://'+Trim(edtUrl.Text)+'/';
            xsm_UserName := Trim(edtUsername.Text);
            xsm_Password := Trim(edtPassword.Text);
            Result := True;
          end
        else 
          Result := False;
      finally
        free;
      end;
    end;
end;

procedure TfrmXsmLogin.FormShow(Sender: TObject);
begin
  inherited;
  ReadFrom;
end;

procedure TfrmXsmLogin.cxbtnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

class function TfrmXsmLogin.XsmRegister: Boolean;
begin
  with TfrmXsmLogin.Create(nil) do
    begin
      try
        flag := 1;
        if ShowModal = mrOk then
          begin
            xsm_url := 'http://'+Trim(edtUrl.Text)+'/';
            xsm_UserName := Trim(edtUsername.Text);
            xsm_Password := Trim(edtPassword.Text);
            Result := True;
          end
        else 
          Result := False;
      finally
        free;
      end;
    end;
end;

procedure TfrmXsmLogin.Setflag(const Value: integer);
begin
  Fflag := Value;
end;

end.
