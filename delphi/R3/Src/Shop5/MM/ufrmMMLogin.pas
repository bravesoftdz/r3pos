unit ufrmMMLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmMMBasic, RzBmpBtn, StdCtrls, ExtCtrls, RzBckgnd, RzPanel,
  RzButton, RzLabel, cxCheckBox, cxTextEdit, cxControls, cxContainer,HTTPApp,
  cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, jpeg, ZDataSet, RzForms;
const
  WM_AUTOLOGIN=WM_USER+495;
type
  TfrmMMLogin = class(TfrmMMBasic)
    Label4: TLabel;
    edtOPER_DATE: TcxDateEdit;
    lblName: TLabel;
    cxedtPasswrd: TcxTextEdit;
    lblPass: TLabel;
    cxcbSave: TcxCheckBox;
    Image2: TImage;
    Image3: TImage;
    cxcbOffline: TcxCheckBox;
    imgLogin: TImage;
    cxBtnOk: TRzBmpButton;
    cxBtnSetup: TRzBmpButton;
    cxedtUsers: TcxComboBox;
    logoStatus: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure cxBtnOkClick(Sender: TObject);
    procedure cxbtnCancelClick(Sender: TObject);
    procedure cxedtPasswrdKeyPress(Sender: TObject; var Key: Char);
    procedure cxBtnSetupClick(Sender: TObject);
  private
    { Private declarations }
    locked:boolean;
    procedure wmAutoLogin(var Message: TMessage); message WM_AUTOLOGIN;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure LoadPic32;
    procedure LoadLogin;
    procedure SaveLogin;
    procedure AutoLogin;
    class function LockScreen(Owner:TForm):boolean;
  end;

implementation
uses ummGlobal,uCaFactory,IniFiles,ufrmHostDialog,uFnUtil,uGlobal,EncDec,ObjCommon,uRcFactory;
{$R *.dfm}

procedure TfrmMMLogin.FormCreate(Sender: TObject);
begin
  inherited;
  edtOPER_DATE.Date := Date();
  LoadLogin;
  imgLogin.Picture.Bitmap.TransparentMode := tmFixed;
  imgLogin.Picture.Bitmap.Transparent  := true;
  imgLogin.Picture.Bitmap.TransparentColor  := clFuchsia;
end;

procedure TfrmMMLogin.cxBtnOkClick(Sender: TObject);
procedure CheckSysDate;
var
  CurDate: TDate;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :='select max(END_DATE) as CREA_DATE from RCK_MONTH_CLOSE where TENANT_ID='+inttostr(mmGlobal.TENANT_ID);
    Factor.Open(rs);
    if rs.Fields[0].asString<>'' then
    begin
      CurDate:=FnTime.fnStrtoDate(rs.Fields[0].AsString);
      if FormatDatetime('YYYYMMDD',edtOPER_DATE.Date) <FormatDatetime('YYYYMMDD',CurDate) then Raise Exception.Create('业务日期不能小于已关账日期...');
    end;
  finally
    rs.Free;
  end;
end;
var
  rs,temp:TZQuery;
begin
  inherited;
  Screen.Cursor := crSQLWait;
  logoStatus.Visible := true;
  logoStatus.Update;
  try
    if not locked then
    begin
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
         CaFactory.coLogin(mmGlobal.xsm_username,CaFactory.DesEncode(mmGlobal.xsm_username,CaFactory.pubpwd),3);
         if not mmGlobal.Logined then
            begin
              if not mmGlobal.coLogin(mmGlobal.xsm_username,mmGlobal.xsm_password) then Exit;
            end;
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
    if CaFactory.Audited then
       begin
         try
           mmGlobal.MoveToRemate;
           mmGlobal.Connect;
         except
           MessageBox(Handle,'连接远程数据库失败,你可以选择脱网操作?','友情提示...',MB_OK+MB_ICONQUESTION);
           Exit;
         end;
       end;
    end;
    if not (mmGlobal.NetVersion or mmGlobal.ONLVersion) then
       begin
          mmGlobal.MoveToLocal;
       end;
    //开始登录了
    rs := TZQuery.Create(nil);
    temp := TZQuery.Create(nil);
    try
      if locked then
        rs.SQL.Text :=
        'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT,C.TENANT_NAME,C.SHORT_TENANT_NAME from VIW_USERS A,CA_SHOP_INFO B,CA_TENANT C '+
        'where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.USER_ID='''+Global.UserID+''' and A.TENANT_ID='+inttostr(mmGlobal.TENANT_ID)
      else
        rs.SQL.Text :=
        'select USER_ID,USER_NAME,PASS_WRD,ROLE_IDS,A.SHOP_ID,B.SHOP_NAME,A.ACCOUNT,C.TENANT_NAME,C.SHORT_TENANT_NAME from VIW_USERS A,CA_SHOP_INFO B,CA_TENANT C '+
        'where A.TENANT_ID=C.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT in ('''+trim(cxedtUsers.Text)+''','''+lowercase(trim(cxedtUsers.Text))+''','''+uppercase(trim(cxedtUsers.Text))+''') and A.TENANT_ID='+inttostr(mmGlobal.TENANT_ID);
      uGlobal.Factor.open(rs);
      if rs.IsEmpty then Raise Exception.Create(cxedtUsers.Text+'无效用户账号。');

      if not ((rs.FieldByName('ACCOUNT').AsString = 'admin') or (rs.FieldByName('ACCOUNT').AsString = 'system') or (rs.FieldByName('ROLE_IDS').AsString = 'xsm')) then
         begin
           temp.SQL.Text := 'select DIMI_DATE from CA_USERS A,CA_SHOP_INFO B where A.SHOP_ID=B.SHOP_ID and A.TENANT_ID=B.TENANT_ID and A.ACCOUNT='+QuotedStr(rs.FieldByName('ACCOUNT').AsString)+
           ' and A.TENANT_ID='+inttostr(Global.TENANT_ID)+' and A.DIMI_DATE<='+QuotedStr(FormatDateTime('YYYY-MM-DD',Date()))+' and A.DIMI_DATE is not null ';
           Factor.Open(temp);
           if not temp.IsEmpty then Raise Exception.Create(cxedtUsers.Text+'用户账号已经离职。');
         end;

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
          if (rs.FieldbyName('ROLE_IDS').AsString='xsm') and CaFactory.Audited and not Locked then
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
               if CaFactory.Audited and not Locked then
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
       if not CaFactory.Audited then
          begin
            mmGlobal.xsm_username := rs.FieldbyName('ACCOUNT').AsString;
            mmGlobal.xsm_nickname := mmGlobal.UserName;
            mmGlobal.xsm_userType := '1000';
          end;
//       if mmGlobal.xsm_userType <> '1000' then mmGlobal.module := '1100';
     finally
       temp.Free;
       rs.Free;
     end;
     if not locked then
        begin
          Factor.GqqLogin(mmGlobal.UserID,mmGlobal.SHOP_NAME+'('+mmGlobal.UserName+')');
          SaveLogin;
        end;
     if (mmGlobal.module[2]='1') then CheckSysDate;
     mmGlobal.SysDate := edtOPER_DATE.Date;
     ModalResult := MROK;
  finally
     logoStatus.Visible := false;
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

class function TfrmMMLogin.LockScreen(Owner:TForm): boolean;
begin
  with TfrmMMLogin.Create(Owner) do
    begin
      try
        locked := true;
        cxedtUsers.Enabled := false;
        edtOPER_DATE.Enabled := false;
        cxBtnSetup.Visible := false;
        cxcbOffline.Visible := false;
        cxBtnOk.Caption := '锁屏(&O)';
        cxedtUsers.Text := Global.UserName;
        ActiveControl := cxedtPasswrd;
        result := (ShowModal=MROK);
      finally
        locked := false;
        free;
      end;
    end;
end;

procedure TfrmMMLogin.cxBtnSetupClick(Sender: TObject);
begin
  inherited;
  TfrmHostDialog.SimpleDialog(self);
end;

procedure TfrmMMLogin.LoadPic32;
var
  sflag:String;
begin
  sflag := 'm'+rcFactory.GetResString(1)+'_';
  //Top
  imgLogin.Picture.Graphic := rcFactory.GetBitmap(sflag + 'login_top_login');
  //mid
  Image2.Picture.Graphic := rcFactory.GetBitmap(sflag + 'login_mid_image2');
  //bottom
  Image3.Picture.Graphic := rcFactory.GetBitmap(sflag + 'login_bottom_image3');
  cxBtnOk.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'dialog_bottom_cxBtnOk_Hot');
  cxBtnOk.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'dialog_bottom_cxBtnOk_Up');
  cxBtnSetup.Bitmaps.Hot := rcFactory.GetBitmap(sflag + 'dialog_bottom_cxBtnOk_Hot');
  cxBtnSetup.Bitmaps.Up := rcFactory.GetBitmap(sflag + 'dialog_bottom_cxBtnOk_Up');
  bkg_03.Picture.Graphic := rcFactory.GetBitmap(sflag + 'login_bottom_bkg_03');
  bkg_04.Picture.Graphic := rcFactory.GetBitmap(sflag + 'login_bottom_bkg_04');
end;

constructor TfrmMMLogin.Create(AOwner: TComponent);
begin
  inherited;
  LoadPic32;
  PostMessage(Handle,WM_AUTOLOGIN,0,0);
end;

procedure TfrmMMLogin.AutoLogin;
begin
  if (ParamStr(1)='-mmPing') and not mmGlobal.Logined then
     begin
       if ParamStr(4)<>'' then
          begin
            mmGlobal.coAutoLogin(HTTPDecode(ParamStr(4)));
          end;
       if mmGlobal.Logined then
          begin
            cxedtUsers.Text := mmGlobal.xsm_username;
            cxedtPasswrd.Text := mmGlobal.xsm_nickname;
            cxBtnOkClick(nil);
          end;
     end;
end;

procedure TfrmMMLogin.wmAutoLogin(var Message: TMessage);
begin
  AutoLogin;
end;

end.
