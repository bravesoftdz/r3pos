unit ufrmUnLockGuide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialog, RzBmpBtn, RzForms, StdCtrls, RzLabel, ExtCtrls,
  RzPanel, cxControls, cxContainer, cxEdit, cxTextEdit, DB, ZDataSet;

type
  TfrmUnLockGuide = class(TfrmWebDialog)
    RzLabel26: TRzLabel;
    edtBK_XSM_CODE: TRzPanel;
    RzPanel86: TRzPanel;
    RzLabel56: TRzLabel;
    edtXSM_CODE: TcxTextEdit;
    edtBK_XSM_PSWD: TRzPanel;
    RzPanel84: TRzPanel;
    RzLabel55: TRzLabel;
    edtXSM_PSWD: TcxTextEdit;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzLabel2: TRzLabel;
    edtLICENSE_CODE: TcxTextEdit;
    Save: TRzBmpButton;
    Cancel: TRzBmpButton;
    RzLabel3: TRzLabel;
    procedure CancelClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function DoUnLock:boolean;
  public
    class function ShowDialog(AOwner:TForm):boolean;
  end;

implementation

uses uTokenFactory,udataFactory,EncDec;

{$R *.dfm}

procedure TfrmUnLockGuide.CancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmUnLockGuide.SaveClick(Sender: TObject);
begin
  inherited;
  DoUnLock;
end;

function TfrmUnLockGuide.DoUnLock: boolean;
var
  rs:TZQuery;
  ShopName,LicenseCode,XsmCode,XsmPswd:string;
begin
  result := false;
  LicenseCode := trim(edtLICENSE_CODE.Text);
  XsmCode := trim(edtXSM_CODE.Text);
  XsmPswd := trim(edtXSM_PSWD.Text);
  if LicenseCode = '' then
     begin
        MessageBox(Handle,pchar('请输入经营许可证...'),'友情提示..',MB_OK);
        if edtLICENSE_CODE.CanFocus then edtLICENSE_CODE.SetFocus;
        Exit;
     end;
  if XsmCode = '' then
     begin
        MessageBox(Handle,pchar('请输入新商盟账号...'),'友情提示..',MB_OK);
        if edtXSM_CODE.CanFocus then edtXSM_CODE.SetFocus;
        Exit;
     end;
  if XsmPswd = '' then
     begin
        MessageBox(Handle,pchar('请输入新商盟密码...'),'友情提示..',MB_OK);
        if edtXSM_PSWD.CanFocus then edtXSM_PSWD.SetFocus;
        Exit;
     end;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select LICENSE_CODE,SHOP_NAME,XSM_CODE,XSM_PSWD from CA_SHOP_INFO where TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID';
    rs.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    rs.ParamByName('SHOP_ID').AsString := token.shopId;
    dataFactory.Open(rs);
    ShopName := rs.FieldByName('SHOP_NAME').AsString;
    if LicenseCode <> rs.Fields[0].AsString then
       begin
         MessageBox(Handle,pchar('经营许可证验证失败，无法解锁...'),'友情提示..',MB_OK);
         Exit;
       end; 
    if not ((XsmCode = rs.FieldByName('XSM_CODE').AsString) and (XsmPswd = DecStr(rs.FieldByName('XSM_PSWD').AsString,ENC_KEY))) then
       begin
         MessageBox(Handle,pchar('新商盟账号密码验证失败，无法解锁...'),'友情提示..',MB_OK);
         Exit;
       end;
    if MessageBox(Handle,pchar('确认要解除门店【'+ShopName+'】的锁定状态?'),'友情提醒',MB_YESNO+MB_ICONQUESTION) <> 6 then
       begin
         Close;
         Exit;
       end;
    dataFactory.MoveToRemote;
    try
      dataFactory.ExecSQL('delete from SYS_DEFINE where TENANT_ID='+token.tenantId+' and DEFINE=''DBKEY_'+token.shopId+'''');
      MessageBox(Handle,pchar('解锁成功...'),'友情提示..',MB_OK);
      result := true;
      ModalResult := MROK;
    finally
      dataFactory.MoveToDefault;
    end;
  finally
    rs.Free;
  end;
end;

class function TfrmUnLockGuide.ShowDialog(AOwner: TForm): boolean;
begin
  with TfrmUnLockGuide.Create(AOwner) do
    begin
      try
        result := (ShowModal = MROK);
      finally
        Free;
      end;
    end;
end;

procedure TfrmUnLockGuide.FormCreate(Sender: TObject);
begin
  inherited;
  dbState := dsInsert;
end;

end.
