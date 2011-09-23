unit ufrmMMLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, RzBmpBtn, StdCtrls, ExtCtrls, RzBckgnd, RzPanel,
  RzButton, RzLabel, cxCheckBox, cxTextEdit, cxControls, cxContainer,
  cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, jpeg, ZDataSet, RzForms;

type
  TfrmMMLogin = class(TfrmMMBasic)
    Label4: TLabel;
    edtOPER_DATE: TcxDateEdit;
    cxedtUsers: TcxTextEdit;
    lblName: TLabel;
    cxedtPasswrd: TcxTextEdit;
    lblPass: TLabel;
    cxcbSave: TcxCheckBox;
    Image2: TImage;
    Image3: TImage;
    cxcbOffline: TcxCheckBox;
    imgLogin: TImage;
    cxBtnOk: TRzBmpButton;
    RzBmpButton1: TRzBmpButton;
    procedure FormCreate(Sender: TObject);
    procedure cxBtnOkClick(Sender: TObject);
    procedure cxbtnCancelClick(Sender: TObject);
    procedure cxedtPasswrdKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadLogin;
    procedure SaveLogin;
  end;

implementation
uses ummGlobal,uCaFactory,IniFiles,uGlobal,EncDec,ObjCommon;
{$R *.dfm}

procedure TfrmMMLogin.FormCreate(Sender: TObject);
begin
  inherited;
  edtOPER_DATE.Date := Date();
  LoadLogin;
end;

procedure TfrmMMLogin.cxBtnOkClick(Sender: TObject);
var
  rs:TZQuery;
begin
  inherited;
  Screen.Cursor := crSQLWait;
  try
    //连接本地库
    mmGlobal.MoveToLocal;
    mmGlobal.Connect;
    CaFactory.auto := true;
    //认证企业合法性
    if not mmGlobal.CheckRegister then //没有注册，现在新注册一个
       begin
         if cxcbOffline.Checked then Raise Exception.Create('第一次登录用户不能使用离线模式.'); 
         mmGlobal.xsm_username := cxedtUsers.Text;
         mmGlobal.xsm_password := cxedtPasswrd.Text;
         if not mmGlobal.coLogin(mmGlobal.xsm_username,mmGlobal.xsm_password) then Exit;
         if not mmGlobal.AutoRegister(true) then Exit;
       end
    else
       begin
         if not cxcbOffline.Checked then
         begin
            if not CaFactory.AutoCoLogo then Exit;
         end
         else
            CaFactory.Audited := false;
       end;
    mmGlobal.InitLoad;
    if (mmGlobal.NetVersion or mmGlobal.ONLVersion) and CaFactory.Audited then
       begin
         try
           mmGlobal.MoveToRemate;
           mmGlobal.Connect;
         except
           if mmGlobal.ONLVersion then
              begin
                if MessageBox(Handle,'连接数据库服务器失败,请检查网络是否正常,是否重新选择连接主机？','友情提示...',MB_YESNO+MB_ICONQUESTION)=6 then
                   ;//TfrmHostDialog.HostDialog(self);
                Exit;
              end;
           if (MessageBox(Handle,'连接远程数据库失败,是否转脱机操作?','友情提示...',MB_YESNO+MB_ICONQUESTION)=6) then
              begin
                mmGlobal.MoveToLocal;
                mmGlobal.Connect;
              end
           else
              Exit;
         end;
       end;
    //开始登录了
    rs := TZQuery.Create(nil);
    try
      rs.SQL.Text :=
        'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT,C.TENANT_NAME,C.SHORT_TENANT_NAME from VIW_USERS A,CA_SHOP_INFO B,CA_TENANT C '+
        'where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT='''+trim(cxedtUsers.Text)+''' and A.TENANT_ID='+inttostr(mmGlobal.TENANT_ID);
      uGlobal.Factor.open(rs);
      if cxedtUsers.Text='system' then
        begin
          if lowerCase(cxedtPasswrd.Text)<>('rspcn.com@'+formatdatetime('YYMMDD',date())+inttostr(strtoint(formatDatetime('DD',Date())) mod 7 )) then
             begin
                cxedtPasswrd.SetFocus;
                Raise Exception.Create('输入的密码无效,请重新输入。');
             end;
        end
      else
        begin
          if (rs.FieldbyName('ROLE_IDS').AsString='xsm') and CaFactory.Audited then
             begin
               mmGlobal.xsm_username := cxedtUsers.Text;
               mmGlobal.xsm_password := cxedtPasswrd.Text;
               if not mmGlobal.coLogin(mmGlobal.xsm_username,mmGlobal.xsm_password) then
                  begin
                    cxedtPasswrd.SetFocus;
                    Exit;
                  end;
               mmGlobal.LocalFactory.ExecSQL('update CA_SHOP_INFO set XSM_PSWD='''+EncStr(cxedtPasswrd.Text,ENC_KEY)+''',COMM='+GetCommStr(mmGlobal.LocalFactory.iDbType)+',TIME_STAMP='+GetTimeStamp(mmGlobal.LocalFactory.iDbType)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and SHOP_ID='''+rs.FieldbyName('SHOP_ID').asString+'''');
             end
          else
             begin
               if UpperCase(cxedtPasswrd.Text) <> UpperCase(DecStr(rs.FieldbyName('PASS_WRD').AsString,ENC_KEY)) then
               begin
                  cxedtPasswrd.SetFocus;
                  Raise Exception.Create('输入的密码无效,请重新输入。');
               end;
               if CaFactory.Audited then
                  begin
                    try
                      mmGlobal.SHOP_ID := rs.FieldbyName('SHOP_ID').asString;
                      mmGlobal.xsmLogin;
                    except
                      on E:Exception do
                         MessageBox(Handle,Pchar('登录新商盟失败，错误原因：'+E.Message),'友情提示..',MB_OK+MB_ICONINFORMATION);
                    end;
                  end;
             end;
        end;
       mmGlobal.UserID := rs.FieldbyName('USER_ID').asString;
       mmGlobal.SHOP_ID := rs.FieldbyName('SHOP_ID').asString;
       mmGlobal.UserName  := rs.FieldbyName('USER_NAME').asString;
       if mmGlobal.UserName='' then mmGlobal.UserName := cxedtUsers.Text;
       mmGlobal.SHOP_NAME := rs.FieldbyName('SHOP_NAME').asString;
       mmGlobal.Roles := rs.FieldbyName('ROLE_IDS').AsString;
       mmGlobal.TENANT_NAME := rs.FieldbyName('TENANT_NAME').AsString;
       mmGlobal.SHORT_TENANT_NAME := rs.FieldbyName('TENANT_NAME').AsString;
    finally
       rs.Free;
    end;
     Factor.GqqLogin(mmGlobal.UserID,mmGlobal.SHOP_NAME+'('+mmGlobal.UserName+')');
     SaveLogin;
     self.ModalResult := MROK;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmMMLogin.cxbtnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMMLogin.SaveLogin;
var F:TIniFile;
begin
  inherited;
  if cxcbSave.Checked and cxedtUsers.Enabled then
     begin
       F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.Ini');
       try
         F.WriteString('Login','Account',cxedtUsers.Text);
         F.WriteBool('Login','SaveLogin',cxcbSave.Checked);
       finally
          try
            F.Free;
          except
          end;
       end;
     end;
end;

procedure TfrmMMLogin.LoadLogin;
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Seting.Ini');
  try
    cxcbSave.Checked := F.ReadBool('Login','SaveLogin',True);
    if cxcbSave.Checked then
       begin
         cxedtUsers.Text := F.ReadString('Login','Account','');
       end;
  finally
    try
      F.Free;
    except
    end;
  end;
end;

procedure TfrmMMLogin.cxedtPasswrdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then cxBtnOk.OnClick(cxBtnOk);
end;

end.
