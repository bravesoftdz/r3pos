unit ufrmTenant;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzTabs, cxControls, cxContainer, ZBase,
  cxEdit, cxTextEdit, StdCtrls, RzButton, RzLabel, cxMaskEdit, uDsUtil,
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
    edtHOMEPAGE: TcxTextEdit;
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
    procedure FormCreate(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure Label20Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Obj: TRecord_;
    class function coRegister(Owner:TForm):boolean;
    procedure Save;
    procedure Open;
  end;

implementation
uses uGlobal, Math, uShoputil,ObjCommon,EncDec;
{$R *.dfm}

class function TfrmTenant.coRegister(Owner: TForm): boolean;
begin
  with TfrmTenant.Create(Owner) do
    begin
      try
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
  procedure UpdateToGlobal(obj:TRecord_);
  var Tmp: TZQuery;
    begin
      Tmp := Global.GetZQueryFromName('CA_TENANT');
      Tmp.Filtered := False;
      if Tmp.Locate('TENANT_ID',obj.FieldbyName('TENANT_ID').AsString,[]) then
        Tmp.Edit
      else
        Tmp.Append;
      obj.WriteToDataSet(Tmp,false);
      Tmp.Post;
    end;
var Temp: TZQuery;
begin
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
  if Trim(edtLEGAL_REPR.Text) = '' then
    begin
      if edtLEGAL_REPR.CanFocus then edtLEGAL_REPR.SetFocus;
      raise Exception.Create('法人代表不能为空！');
    end;
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

  {Temp := Global.GetZQueryFromName('CA_TENANT');
  if Temp.Locate('LOGIN_NAME',Trim(edtLOGIN_NAME.Text),[]) then
    begin
      raise Exception.Create('登录帐号“' + Trim(edtLOGIN_NAME.Text) + '”已存在，请重新输入！');
      edtLOGIN_NAME.Text := '';
      if edtLOGIN_NAME.CanFocus then edtLOGIN_NAME.SetFocus;
    end;}
  //后台检测——以上检测判断登录帐号是否已经存在

  {
    此处为与远程服务器连接代码
   }
  WriteToObject(Obj,self);
  Obj.FieldByName('PASSWRD').AsString := EncStr(Obj.FieldbyName('PASSWRD').AsString,ENC_KEY);
  if CdsTable.RecordCount = 0 then
    Obj.FieldByName('TENANT_ID').AsInteger := 1
  else
    Obj.FieldByName('TENANT_ID').AsInteger := Obj.FieldByName('TENANT_ID').AsInteger;
  //以上语句在与远程服务器连接后，从服务器端赋值
  CdsTable.edit;
  Obj.WriteToDataSet(CdsTable);
  CdsTable.Post;
  if Factor.UpdateBatch(CdsTable,'TTenant',nil) then
    UpdateToGlobal(Obj);
end;

procedure TfrmTenant.RzBitBtn1Click(Sender: TObject);
var Temp: TZQuery;
begin
  inherited;
  if Trim(cxedtLOGIN_NAME.Text) = '' then
    begin
      cxedtLOGIN_NAME.SetFocus;
      raise Exception.Create('请输入登录名！');
    end;
  if Trim(cxedtPasswrd.Text) = '' then
    begin
      cxedtPasswrd.SetFocus;
      raise Exception.Create('请输入密码！');
    end;
  Temp := TZQuery.Create(nil);
  try
    Temp.SQL.Text := 'Select LOGIN_NAME,PASSWRD from CA_TANENT where LOGIN_NAME='''+Trim(cxedtLOGIN_NAME.Text)+'''';
    Factor.Open(Temp);
    if Temp.IsEmpty then raise Exception.Create(cxedtLOGIN_NAME.Text+'登录名无效！');
    if UpperCase(cxedtPasswrd.Text) <> UpperCase(DecStr(Temp.FieldbyName('PASSWRD').AsString,ENC_KEY)) then
      begin
        cxedtPasswrd.SetFocus;
        raise Exception.Create('无效密码,请重新输入！');
      end;
  finally
    Temp.Free;
  end;
end;

procedure TfrmTenant.Label20Click(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 1;
  Open;
end;

procedure TfrmTenant.FormDestroy(Sender: TObject);
begin
  inherited;
  Obj.Free;
end;

procedure TfrmTenant.btnOkClick(Sender: TObject);
var Tmp: TZQuery;
begin
  inherited;
  Save;
  Tmp := Global.GetZQueryFromName('CA_TENANT');
  RzPage.ActivePageIndex := 0;   
  if Tmp.RecordCount = 1 then
    begin
      cxedtLOGIN_NAME.Text := Tmp.FieldbyName('LOGIN_NAME').AsString;
      cxedtPasswrd.SetFocus;
      Label20.Caption := '更新注册';
    end
    else
    begin
      cxedtLOGIN_NAME.SetFocus;
    end;
end;

procedure TfrmTenant.Open;
begin
  Factor.Open(CdsTable,'TTenant',nil);

  if RzPage.ActivePageIndex = 0 then
    begin
      if CdsTable.RecordCount = 1 then
        begin
          Label20.Caption := '更新注册';
          cxedtLOGIN_NAME.Text := CdsTable.FieldbyName('LOGIN_NAME').AsString;
          cxedtPasswrd.SetFocus;
        end;
    end
    else
    begin
      Obj.ReadFromDataSet(CdsTable);
      ReadFromObject(Obj,self);
      edtPASSWRD.Text := DecStr(Obj.FieldbyName('PASSWRD').AsString,ENC_KEY);
      edtPASSWRD1.Text := edtPASSWRD.Text;
      btnOk.Caption := '保存(&s)';
    end;
end;

procedure TfrmTenant.FormShow(Sender: TObject);
begin
  inherited;
  RzPage.ActivePageIndex := 0;
  Open;
end;

end.
