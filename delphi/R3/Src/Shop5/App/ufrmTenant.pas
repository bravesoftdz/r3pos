unit ufrmTenant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzTabs, cxControls, cxContainer, ZBase,
  cxEdit, cxTextEdit, StdCtrls, RzButton, RzLabel, cxMaskEdit, uDsUtil,uCaFactory,
  cxButtonEdit, zrComboBoxList, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, jpeg;

type
  TfrmTenant = class(TfrmBasic)
    RzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtLOGIN_NAME: TcxTextEdit;
    edtTENANT_NAME: TcxTextEdit;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtSHORT_TENANT_NAME: TcxTextEdit;
    Label7: TLabel;
    Label8: TLabel;
    edtLEGAL_REPR: TcxTextEdit;
    Label9: TLabel;
    edtLINKMAN: TcxTextEdit;
    Label10: TLabel;
    edtTELEPHONE: TcxTextEdit;
    Label11: TLabel;
    edtFAXES: TcxTextEdit;
    Label12: TLabel;
    edtLICENSE_CODE: TcxTextEdit;
    Label13: TLabel;
    edtADDRESS: TcxTextEdit;
    Label14: TLabel;
    edtPOSTALCODE: TcxTextEdit;
    Label15: TLabel;
    edtPASSWRD: TcxTextEdit;
    Label16: TLabel;
    Label17: TLabel;
    edtPASSWRD1: TcxTextEdit;
    Label18: TLabel;
    btnOk: TRzBitBtn;
    RzLabel1: TRzLabel;
    Panel2: TPanel;
    cxedtPasswrd: TcxTextEdit;
    cxedtLOGIN_NAME: TcxTextEdit;
    lblName: TLabel;
    lblPass: TLabel;
    RzBitBtn1: TRzBitBtn;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtREGION_ID: TzrComboBoxList;
    CdsTable: TZQuery;
    Label22: TLabel;
    TitlePanel: TPanel;
    imgStepIcon: TImage;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    Label23: TLabel;
    RzLabel2: TRzLabel;
    Bevel1: TBevel;
    Label24: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
  protected
    procedure Paint; override;
    { Private declarations }
  public
    { Public declarations }
    Obj: TRecord_;
    TENANT_ID: Integer;
    function Check:boolean;
    class function coRegister(Owner:TForm):boolean;
    function Login_F(NetWork:boolean=true):Boolean;
    procedure Save;
    procedure Open;
  end;

implementation
uses uGlobal, uShopGlobal, Math, uShoputil,ObjCommon,EncDec,uFnUtil;
{$R *.dfm}

class function TfrmTenant.coRegister(Owner: TForm): boolean;
begin
  with TfrmTenant.Create(Owner) do
    begin
      try
        rzPage.ActivePageIndex := 0;
        result := Check;
        if result then
          begin
            //检测网络
            if CAFactory.CheckNetwork then
              begin
                //登录认证
                result := Login_F(true);
                if not result then Label19.Caption := '登录认证失败 ';
              end
            else
              begin
                Login_F(false);
                Exit;
              end;
          end;
        if (not result) then
           result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

procedure TfrmTenant.FormCreate(Sender: TObject);
var i:integer;
begin
  inherited;
  for i:=0 to RzPage.PageCount -1 do
    RzPage.Pages[i].TabVisible := false;
  edtREGION_ID.DataSet := Global.GetZQueryFromName('PUB_REGION_INFO');
  Obj := TRecord_.Create;
end;

procedure TfrmTenant.Save;
var
  Tenant: TCaTenant;
  Login: TCaLogin;
begin
  WriteToObject(Obj,self);
  Obj.FieldByName('PASSWRD').AsString := EncStr(Obj.FieldbyName('PASSWRD').AsString,ENC_KEY);
  Obj.FieldByName('TENANT_SPELL').AsString := FnString.GetWordSpell(edtTENANT_NAME.Text);
  Obj.FieldByName('TENANT_TYPE').AsString := '3';
  Obj.FieldByName('AUDIT_STATUS').AsString := '0';
  Tenant.TENANT_ID := Obj.FieldByName('TENANT_ID').AsInteger;
  Tenant.LOGIN_NAME := Obj.FieldByName('LOGIN_NAME').AsString;
  Tenant.TENANT_NAME := Obj.FieldByName('TENANT_NAME').AsString;
  Tenant.TENANT_TYPE := Obj.FieldByName('TENANT_TYPE').AsInteger;
  Tenant.SHORT_TENANT_NAME := Obj.FieldByName('SHORT_TENANT_NAME').AsString;
  Tenant.TENANT_SPELL := Obj.FieldByName('TENANT_SPELL').AsString;
  Tenant.LEGAL_REPR := Obj.FieldByName('LEGAL_REPR').AsString;
  Tenant.LINKMAN := Obj.FieldByName('LINKMAN').AsString;
  Tenant.TELEPHONE := Obj.FieldByName('TELEPHONE').AsString;
  Tenant.FAXES := Obj.FieldByName('FAXES').AsString;
  Tenant.QQ := Obj.FieldByName('QQ').AsString;
  Tenant.MSN := Obj.FieldByName('MSN').AsString;
  Tenant.LICENSE_CODE := Obj.FieldByName('LICENSE_CODE').AsString;
  Tenant.ADDRESS := Obj.FieldByName('ADDRESS').AsString;
  Tenant.POSTALCODE := Obj.FieldByName('POSTALCODE').AsString;
  Tenant.REMARK := Obj.FieldByName('REMARK').AsString;
  Tenant.PASSWRD := Obj.FieldByName('PASSWRD').AsString;
  Tenant.REGION_ID := Obj.FieldByName('REGION_ID').AsString;
  Tenant.SRVR_ID := Obj.FieldByName('SRVR_ID').AsString;
  Tenant.PROD_ID := Obj.FieldByName('PROD_ID').AsString;
  Tenant.AUDIT_STATUS := Obj.FieldByName('AUDIT_STATUS').AsString;

  Tenant := CaFactory.coRegister(Tenant);
  //
  Obj.FieldByName('TENANT_ID').AsInteger := Tenant.TENANT_ID;
  //以上语句在与远程服务器连接后，从服务器端获取企业ID值

  CdsTable.edit;
  Obj.WriteToDataSet(CdsTable);

  CdsTable.Post;
  Factor.UpdateBatch(CdsTable,'TTenant',nil);
  Global.TENANT_ID := Tenant.TENANT_ID;
  Global.TENANT_NAME := Tenant.TENANT_NAME;
end;

procedure TfrmTenant.RzBitBtn1Click(Sender: TObject);
var
  Tenant: TCaTenant;
  Login: TCaLogin;
begin
  inherited;
  if Trim(cxedtLOGIN_NAME.Text) = '' then
    begin
      cxedtLOGIN_NAME.SetFocus;
      raise Exception.Create('请输入企业帐号！');
    end;
  if Trim(cxedtPasswrd.Text) = '' then
    begin
      cxedtPasswrd.SetFocus;
      raise Exception.Create('请输入登录口令！');
    end;

  Login := CaFactory.coLogin(Trim(cxedtLOGIN_NAME.Text),DecStr(Trim(cxedtPasswrd.Text),ENC_KEY));
  //
  Tenant := CaFactory.coGetList(IntToStr(Login.TENANT_ID));
  if (IntToStr(TENANT_ID) <> '' ) and (TENANT_ID <> Tenant.TENANT_ID) then Exit;
  Open;
  IF CdsTable.Locate('TENANT_ID',Tenant.TENANT_ID,[]) then
    begin
      CdsTable.Edit;
      CdsTable.FieldByName('TENANT_ID').AsInteger := Tenant.TENANT_ID;
      CdsTable.FieldByName('LOGIN_NAME').AsString := Tenant.LOGIN_NAME;
      CdsTable.FieldByName('TENANT_NAME').AsString := Tenant.TENANT_NAME;
      CdsTable.FieldByName('TENANT_TYPE').AsInteger := Tenant.TENANT_TYPE;
      CdsTable.FieldByName('SHORT_TENANT_NAME').AsString := Tenant.SHORT_TENANT_NAME;
      CdsTable.FieldByName('TENANT_SPELL').AsString := Tenant.TENANT_SPELL;
      CdsTable.FieldByName('LEGAL_REPR').AsString := Tenant.LEGAL_REPR;
      CdsTable.FieldByName('LINKMAN').AsString := Tenant.LINKMAN;
      CdsTable.FieldByName('TELEPHONE').AsString := Tenant.TELEPHONE;
      CdsTable.FieldByName('FAXES').AsString := Tenant.FAXES;
      CdsTable.FieldByName('MSN').AsString := Tenant.MSN;
      CdsTable.FieldByName('QQ').AsString := Tenant.QQ;
      CdsTable.FieldByName('LICENSE_CODE').AsString := Tenant.LICENSE_CODE;
      CdsTable.FieldByName('ADDRESS').AsString := Tenant.ADDRESS;
      CdsTable.FieldByName('POSTALCODE').AsString := Tenant.POSTALCODE;
      CdsTable.FieldByName('REMARK').AsString := Tenant.REMARK;
      CdsTable.FieldByName('PASSWRD').AsString := EncStr(Tenant.PASSWRD,ENC_KEY);
      CdsTable.FieldByName('REGION_ID').AsString := Tenant.REGION_ID;
      CdsTable.FieldByName('SRVR_ID').AsString := Tenant.SRVR_ID;
      CdsTable.FieldByName('PROD_ID').AsString := Tenant.PROD_ID;
      CdsTable.FieldByName('AUDIT_STATUS').AsString := Tenant.AUDIT_STATUS;
      CdsTable.Post;
      Factor.UpdateBatch(CdsTable,'TTenant',nil);
    end;
  Global.TENANT_ID := Tenant.TENANT_ID;
  Global.TENANT_NAME := Tenant.TENANT_NAME;

  ModalResult := mrCancel;
end;

procedure TfrmTenant.Label20Click(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 1;
  Open;
  if edtLOGIN_NAME.CanFocus then edtLOGIN_NAME.SetFocus;
end;

procedure TfrmTenant.FormDestroy(Sender: TObject);
begin
  inherited;
  Obj.Free;
end;

procedure TfrmTenant.btnOkClick(Sender: TObject);
begin
  inherited;
  if Trim(edtLOGIN_NAME.Text) = '' then
    begin
      if edtLOGIN_NAME.CanFocus then edtLOGIN_NAME.SetFocus;
      raise Exception.Create('登录名不能为空！');
    end;
  if Trim(edtTENANT_NAME.Text) = '' then
    begin
      If edtTENANT_NAME.CanFocus then edtTENANT_NAME.SetFocus;
      raise Exception.Create('企业名称不能为空！');
    end;
  if Trim(edtSHORT_TENANT_NAME.Text) = '' then
    begin
      if edtSHORT_TENANT_NAME.CanFocus then edtSHORT_TENANT_NAME.SetFocus;
      raise Exception.Create('企业简称不能为空！');
    end;
//  if Trim(edtLEGAL_REPR.Text) = '' then
//    begin
//      if edtLEGAL_REPR.CanFocus then edtLEGAL_REPR.SetFocus;
//      raise Exception.Create('法人代表不能为空！');
//    end;
  if Trim(edtPASSWRD.Text) = '' then
    begin
      if edtPASSWRD.CanFocus then edtPASSWRD.SetFocus;
      raise Exception.Create('密码不能为空！');
    end;
  if Trim(edtPASSWRD1.Text) = '' then
    begin
      if edtPASSWRD1.CanFocus then edtPASSWRD1.SetFocus;
      raise Exception.Create('再次输入密码不能为空！');
    end;
  if Trim(edtPASSWRD.Text) <> Trim(edtPASSWRD1.Text) then
    begin
      edtPASSWRD1.Text := '';
      if edtPASSWRD1.CanFocus then edtPASSWRD1.SetFocus;
      raise Exception.Create('两次密码输入不一致！');
    end;
  //前后检测——以上检测只判断注册界面不允许为空的字段
  Save;
  ModalResult := mrok;
end;

procedure TfrmTenant.Open;
var Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
     Params.ParamByName('TENANT_ID').AsInteger := TENANT_ID;
     Factor.Open(CdsTable,'TTenant',Params);
  finally
    Params.Free;
  end;
  Obj.Clear;
  Obj.ReadFromDataSet(CdsTable);
  ReadFromObject(Obj,Self);
end;

function TfrmTenant.Check: boolean;
var Temp: TZQuery;
begin
  Temp := TZQuery.Create(nil);
  try
    Temp.SQL.Text := 'Select Value from Sys_Define Where Define = ''TENANT_ID'' and TENANT_ID=0 ';
    Factor.Open(Temp);
    result := (Temp.Fields[0].asString<>'');
    // zhangsenrong 20110-01-26
    if result then
       begin
         TENANT_ID := Temp.Fields[0].AsInteger;
         Global.TENANT_ID := Temp.Fields[0].AsInteger;
       end;
    //
  finally
    Temp.free;
  end;
end;

function TfrmTenant.Login_F(NetWork:boolean=true):Boolean;
var
  Temp: TZQuery;
begin
  Result := False;
  try
    Temp := TZQuery.Create(nil);
    Temp.Close;
    Temp.SQL.Text := 'select LOGIN_NAME,PASSWRD,TENANT_ID,TENANT_NAME from CA_TENANT where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(TENANT_ID);
    Factor.Open(Temp);
    if NetWork then CaFactory.coLogin(Temp.FieldByName('LOGIN_NAME').AsString,DecStr(Temp.FieldByName('PASSWRD').AsString,ENC_KEY));
    Result := True;
    Global.TENANT_ID := Temp.FieldByName('TENANT_ID').AsInteger;
    Global.TENANT_NAME := Temp.FieldByName('TENANT_NAME').AsString;
  finally
    Temp.Free;
  end;
end;

procedure TfrmTenant.Paint;
begin
  inherited;

end;

end.
