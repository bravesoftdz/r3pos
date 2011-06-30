unit ufrmTenant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzTabs, cxControls, cxContainer, ZBase,
  cxEdit, cxTextEdit, StdCtrls, RzButton, RzLabel, cxMaskEdit, uDsUtil,uCaFactory,
  cxButtonEdit, zrComboBoxList, ExtCtrls, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, jpeg, ZdbFactory;

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
    procedure SaveParams;
    class function coAutoRegister(id:string):boolean;
    class function coRegister(Owner:TForm):boolean;
    class function coNewRegister(Owner:TForm):boolean;
    function Login_F(NetWork:boolean=true):Boolean;
    procedure Save;
    procedure Open(id:integer);
  end;

implementation
uses uGlobal,ufrmLogo, uShopGlobal, Math, uShoputil,ObjCommon,EncDec,uFnUtil;
{$R *.dfm}

class function TfrmTenant.coRegister(Owner: TForm): boolean;
begin
  with TfrmTenant.Create(Owner) do
    begin
      try
        frmLogo.Show;
        try
        frmLogo.Label1.Caption := '正在获取企业证书...';
        frmLogo.Label1.Update;
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

            Label24.Enabled := false;
            Label20.Enabled := false;
          end;
        finally
          frmLogo.Close;
        end;
        if (not result) then
           result := (ShowModal=MROK);
      finally
        frmLogo.Label1.Caption := '获取企业证书完毕...';
        frmLogo.Label1.Update;
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

  if not Global.LocalFactory.Connected then
     begin
       Global.MoveToLocal;
       Global.Connect;
     end;
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
  Tenant.PASSWRD := DecStr(Obj.FieldByName('PASSWRD').AsString,ENC_KEY);
  Tenant.REGION_ID := Obj.FieldByName('REGION_ID').AsString;
  Tenant.SRVR_ID := Obj.FieldByName('SRVR_ID').AsString;
  Tenant.PROD_ID := Obj.FieldByName('PROD_ID').AsString;
  Tenant.AUDIT_STATUS := Obj.FieldByName('AUDIT_STATUS').AsString;

  Tenant := CaFactory.coRegister(Tenant);
  //
  Obj.FieldByName('TENANT_ID').AsInteger := Tenant.TENANT_ID;
  //以上语句在与远程服务器连接后，从服务器端获取企业ID值
  if cdsTable.Locate('TENANT_ID',Tenant.TENANT_ID,[]) then
     CdsTable.Edit else CdsTable.append;
  Obj.WriteToDataSet(CdsTable);

  CdsTable.Post;
  Global.LocalFactory.UpdateBatch(CdsTable,'TTenant',nil);
  Global.TENANT_ID := Tenant.TENANT_ID;
  Global.TENANT_NAME := Obj.FieldByName('TENANT_NAME').AsString;
  TENANT_ID := Tenant.TENANT_ID;
  SaveParams;
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

  Login := CaFactory.coLogin(Trim(cxedtLOGIN_NAME.Text),Trim(cxedtPasswrd.Text));
  //
  Tenant := CaFactory.coGetList(IntToStr(Login.TENANT_ID));
// 改成允许注册多个企业  
//  if (TENANT_ID>0) and (TENANT_ID <> Tenant.TENANT_ID) then
//     begin
//       MessageBox(Handle,'当前注册的企业跟系统内现有企业不相符，请输入原企业账号及密码进行注册。','友情提示...',MB_OK+MB_ICONINFORMATION);
//       Exit;
//     end;
  Open(Tenant.TENANT_ID);
//兄弟不能有这句，晕呼  zhangsenrong 修改
//  if CdsTable.Locate('TENANT_ID',Tenant.TENANT_ID,[]) then
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
      CdsTable.FieldByName('PASSWRD').AsString := EncStr(Trim(cxedtPasswrd.Text),ENC_KEY);
      CdsTable.FieldByName('REGION_ID').AsString := Tenant.REGION_ID;
      CdsTable.FieldByName('SRVR_ID').AsString := Tenant.SRVR_ID;
      CdsTable.FieldByName('PROD_ID').AsString := Tenant.PROD_ID;
      CdsTable.FieldByName('AUDIT_STATUS').AsString := Tenant.AUDIT_STATUS;
      CdsTable.Post;
      Global.LocalFactory.UpdateBatch(CdsTable,'TTenant',nil);
    end;
  Global.TENANT_ID := Tenant.TENANT_ID;
  Global.TENANT_NAME := Tenant.TENANT_NAME;
//  if TENANT_ID=0 then
     begin
       TENANT_ID := Tenant.TENANT_ID;
       SaveParams;
     end;
  ModalResult := mrok;
end;

procedure TfrmTenant.Label20Click(Sender: TObject);
begin
  inherited;
  if Global.TENANT_ID>0 then Raise Exception.Create('当前账套已经注册企业了，不能注册新的企业，请输入原企业登录名及密码进行认证');
  RzPage.ActivePageIndex := 1;
  Open(TENANT_ID);
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
  MessageBox(Handle,'注册过程大约需要1分钟时间，请稍候...','友情提示...',MB_OK+MB_ICONINFORMATION);
  Screen.Cursor := crSQLWait;
  try
    Save;
  finally
    Screen.Cursor := crDefault;
  end;
  ModalResult := mrok;
end;

procedure TfrmTenant.Open(id:integer);
var Params:TftParamList;
begin
  Params := TftParamList.Create;
  try
     Params.ParamByName('TENANT_ID').AsInteger := id;
     Global.LocalFactory.Open(CdsTable,'TTenant',Params);
  finally
    Params.Free;
  end;
  Obj.Clear;
  Obj.ReadFromDataSet(CdsTable);
  ReadFromObject(Obj,Self);
end;

function TfrmTenant.Check: boolean;
var
  Temp: TZQuery;
  dbFactory:TdbFactory;
begin
  Temp := TZQuery.Create(nil);
  try
    Temp.SQL.Text := 'select Value from SYS_DEFINE Where Define = ''TENANT_ID'' and TENANT_ID=0 ';
    if Factor.iDbType = 5 then
       Factor.Open(Temp)
    else
       begin
         dbFactory := TdbFactory.Create;
         try
           dbFactory.Initialize('Provider=sqlite-3;DatabaseName='+Global.InstallPath+'data\R3.db');
           try
              dbFactory.Connect;
           except
              Raise Exception.Create('软件没有正确安装，请联系客服人员');
           end;
           dbFactory.Open(Temp);
         finally
           dbFactory.Free;
         end;
       end;
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
  login:TCaLogin;
begin
  Result := False;
  Temp := TZQuery.Create(nil);
  try
    Temp.Close;
    Temp.SQL.Text := 'select LOGIN_NAME,PASSWRD,TENANT_ID,TENANT_NAME,SHORT_TENANT_NAME from CA_TENANT where COMM not in (''02'',''12'') and TENANT_ID='+IntToStr(TENANT_ID);
    Global.LocalFactory.Open(Temp);
    if NetWork then
       begin
         try
            login := CaFactory.coLogin(Temp.FieldByName('LOGIN_NAME').AsString,DecStr(Temp.FieldByName('PASSWRD').AsString,ENC_KEY));
         except
           on E:Exception do
              begin
                if StrtoIntDef(login.RET,0) in [2,3] then
                   begin
                     MessageBox(Handle,pchar('企业认证失败？错误原因:'+E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
                     Global.LocalFactory.ExecSQL('delete from SYS_DEFINE where TENANT_ID=0 and DEFINE=''TENANT_ID''');
                     Global.LocalFactory.ExecSQL('delete from SYS_DEFINE where TENANT_ID='+inttostr(TENANT_ID)+' and DEFINE=''TENANT_ID''');
                     result := false;
                     Exit;
                   end
                else
                   begin
                     if Temp.IsEmpty then
                        begin
                          //MessageBox(Handle,pchar('企业认证失败？错误原因:'+E.Message),'友情提示...',MB_OK+MB_ICONINFORMATION);
                          Raise;
                        end;
                   end;
              end;
         end;
       end;
    Global.TENANT_ID := Temp.FieldByName('TENANT_ID').AsInteger;
    Global.TENANT_NAME := Temp.FieldByName('TENANT_NAME').AsString;
    Global.SHORT_TENANT_NAME := Temp.FieldByName('SHORT_TENANT_NAME').AsString;
    Result := True;
  finally
    Temp.Free;
  end;
end;

procedure TfrmTenant.Paint;
begin
  inherited;

end;

procedure TfrmTenant.SaveParams;
var dbFactory:TdbFactory;
begin
   dbFactory := TdbFactory.Create;
   try
     dbFactory.Initialize('Provider=sqlite-3;DatabaseName='+Global.InstallPath+'data\R3.db');
     try
        dbFactory.Connect;
     except
        Raise Exception.Create('软件没有正确安装，请联系客服人员');
     end;
     if dbFactory.ExecSQL('update SYS_DEFINE set VALUE='''+inttostr(TENANT_ID)+''' where TENANT_ID=0 and DEFINE=''TENANT_ID''')=0 then
        dbFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values(0,''TENANT_ID'','''+inttostr(TENANT_ID)+''',0,''00'',5497000)');
     if dbFactory.ExecSQL('update SYS_DEFINE set VALUE='''+inttostr(TENANT_ID)+''' where TENANT_ID='+inttostr(TENANT_ID)+' and DEFINE=''TENANT_ID''')=0 then
        dbFactory.ExecSQL('insert into SYS_DEFINE (TENANT_ID,DEFINE,VALUE,VALUE_TYPE,COMM,TIME_STAMP) values('+inttostr(TENANT_ID)+',''TENANT_ID'','''+inttostr(TENANT_ID)+''',0,''00'',5497000)');
   finally
     dbFactory.Free;
   end;
end;

class function TfrmTenant.coNewRegister(Owner: TForm): boolean;
begin
  if not CAFactory.CheckNetwork then Raise Exception.Create('对不起请检查网络是否正常连接...'); 
  with TfrmTenant.Create(Owner) do
    begin
      try
        frmLogo.Label1.Caption := '正在获取企业证书...';
        frmLogo.Label1.Update;
        rzPage.ActivePageIndex := 0;
        TENANT_ID := 0;
        Global.TENANT_ID := 0;
        result := (ShowModal=MROK);
       finally
        free;
      end;
    end;
end;

class function TfrmTenant.coAutoRegister(id: string): boolean;
var
  Tenant: TCaTenant;
  Login: TCaLogin;
begin
  result := false;
  Login := CaFactory.coLogin(id,copy(id,length(id)-5,6));
  //
  Tenant := CaFactory.coGetList(IntToStr(Login.TENANT_ID));
  with TfrmTenant.Create(nil) do
  begin
    try
      Open(Tenant.TENANT_ID);
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
      CdsTable.FieldByName('PASSWRD').AsString := EncStr(copy(id,length(id)-5,6),ENC_KEY);
      CdsTable.FieldByName('REGION_ID').AsString := Tenant.REGION_ID;
      CdsTable.FieldByName('SRVR_ID').AsString := Tenant.SRVR_ID;
      CdsTable.FieldByName('PROD_ID').AsString := Tenant.PROD_ID;
      CdsTable.FieldByName('AUDIT_STATUS').AsString := Tenant.AUDIT_STATUS;
      CdsTable.Post;
      Global.LocalFactory.UpdateBatch(CdsTable,'TTenant',nil);
      Global.TENANT_ID := Tenant.TENANT_ID;
      Global.TENANT_NAME := Tenant.TENANT_NAME;
      TENANT_ID := Tenant.TENANT_ID;
      SaveParams;
      result := true;
    finally
      free;
    end;
  end;
end;

end.
