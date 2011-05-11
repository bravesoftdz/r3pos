unit ufrmUnoinLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ExtCtrls, RzPanel, ActnList, Menus, RzButton,
  cxControls, cxContainer, cxEdit, cxTextEdit, StdCtrls, jpeg, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmUnoinLogin = class(TfrmBasic)
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
    procedure FormCreate(Sender: TObject);
    procedure cxBtnOkClick(Sender: TObject);
  private
    { Private declarations }
    //xsm_url,xsm_username,xsm_password :string;
  public
    { Public declarations }
    procedure ReadFrom;
    procedure WriteTo;
    procedure SetValue(ID,Value:String);
    class function ShowUnoinLogin(var Url,UserName,Password:String):Boolean;
  end;

implementation
uses ZBase,ufnUtil,ufrmLogo,uGlobal,EncDec,uShopGlobal,uDsUtil,ufrmIEWebForm;
{$R *.dfm}

procedure TfrmUnoinLogin.FormCreate(Sender: TObject);
begin
  inherited;
  xsm_url := ShopGlobal.GetParameter('XSM_URL');
  if xsm_url='' then xsm_url := 'http://test.xinshangmeng.com/';
  xsm_username := ShopGlobal.GetParameter('XSM_USERNAME');
  if xsm_username='' then xsm_username := 'testcusta20';
  xsm_password := DecStr(ShopGlobal.GetParameter('XSM_PASSWORD'),ENC_KEY);
  if xsm_password='' then xsm_password := 'admin';
end;

procedure TfrmUnoinLogin.ReadFrom;
begin
  cdsUnion.Close;
  cdsUnion.SQL.Text := 'select * from SYS_DEFINE where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and DEFINE like ''%_'+Global.SHOP_ID+'''';
  Factor.Open(cdsUnion);
end;

procedure TfrmUnoinLogin.SetValue(ID, Value: String);
begin
  if cdsUnion.Locate(ID,Value,[]) then
    cdsUnion.Edit
  else
    cdsUnion.Append;
  cdsUnion.FieldByName('DEFINE').AsString := ID;
  cdsUnion.FieldByName('TENANT_ID').AsString := IntToStr(Global.TENANT_ID);
  cdsUnion.FieldByName('VALUE').AsString := Value;
  cdsUnion.FieldByName('VALUE_TYPE').AsString := '0';
  cdsUnion.Post;
end;

procedure TfrmUnoinLogin.WriteTo;
begin
  SetValue('XSM_URL_'+Global.SHOP_ID,'http://'+Trim(edtUrl.Text)+'/');
  SetValue('XSM_USERNAME_'+Global.SHOP_ID,Trim(edtUsername.Text));
  SetValue('XSM_PASSWORD_'+Global.SHOP_ID,EncStr(Trim(edtPassword.Text),ENC_KEY));
end;

procedure TfrmUnoinLogin.cxBtnOkClick(Sender: TObject);
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
  ReadFrom;
  WriteTo;
  Factor.UpdateBatch(cdsUnion,'TSysDefine');
end;

class function TfrmUnoinLogin.ShowUnoinLogin(var Url, UserName,
  Password: String): Boolean;
begin
  with TfrmUnoinLogin.Create(nil) do
    begin
      try
        if ShowModal = mrOk then
          begin
            Url := 'http://'+Trim(edtUrl.Text)+'/';
            UserName := Trim(edtUsername.Text);
            Password := EncStr(Trim(edtPassword.Text),ENC_KEY);
            Result := True;
          end
        else ShowModal = mrIgnore then
          Result := False;
      finally
      end;
    end;
end;

end.
