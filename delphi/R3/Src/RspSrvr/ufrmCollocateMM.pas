unit ufrmCollocateMM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, StdCtrls, cxControls, cxContainer, cxEdit,
  cxTextEdit, ActnList, Menus, RzButton, ExtCtrls, RzPanel, DB,ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmCollocateMM = class(TfrmBasic)
    edtURL: TcxTextEdit;
    edtUSERNAME: TcxTextEdit;
    edtPASSWORD: TcxTextEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    btnOK: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    Label4: TLabel;
    cdsMM: TZQuery;
    Label5: TLabel;
    edtPASSWORD1: TcxTextEdit;
    procedure btnOKClick(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetValue(DefineName,Value:String);
    procedure ReadFromData;
  end;


implementation

uses uGlobal,Math,EncDec;

{$R *.dfm}

procedure TfrmCollocateMM.btnOKClick(Sender: TObject);
var Str: String;
begin
  inherited;
  if Trim(edtPASSWORD1.Text) <> Trim(edtPASSWORD.Text) then
    begin
      Raise Exception.Create('两次密码输入不一致,请重新输入..');
      if edtPASSWORD1.CanFocus then edtPASSWORD1.SetFocus;
    end;
  if Trim(edtURL.Text) = '' then
    begin
      Raise Exception.Create('请输入服务地址..');
      if edtURL.CanFocus then edtURL.SetFocus;
    end
  else
    SetValue('XSM_Url',Trim(edtURL.Text));
  if Trim(edtUSERNAME.Text) = '' then
    begin
      Raise Exception.Create('请输入登录名..');
      if edtUSERNAME.CanFocus then edtUSERNAME.SetFocus;
    end
  else
    SetValue('XSM_UserName',Trim(edtUSERNAME.Text));
  if Trim(edtPASSWORD.Text) = '' then
    begin
      Raise Exception.Create('请输入密码..');
      if edtPASSWORD.CanFocus then edtPASSWORD.SetFocus;
    end
  else
    begin
      SetValue('XSM_Password',EncStr(Trim(edtPASSWORD.Text),ENC_KEY));
    end;

  if Factor.UpdateBatch(cdsMM,'TSysDefine') then
    begin
      Global.RefreshTable('SYS_DEFINE');
      close;
    end;

end;

procedure TfrmCollocateMM.SetValue(DefineName, Value: String);
begin
  if cdsMM.Locate('DEFINE',DefineName,[]) then
    cdsMM.Edit
  else
    cdsMM.Append;

  cdsMM.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
  cdsMM.FieldByName('DEFINE').AsString := DefineName;
  cdsMM.FieldByName('VALUE').AsString := Value;
  cdsMM.FieldByName('VALUE_TYPE').AsInteger := 0;
  cdsMM.Post;

end;

procedure TfrmCollocateMM.ReadFromData;
var Params: TftParamList;
    Str_Define,Str_Value:String;
begin
  try
    Params := TftParamList.Create(nil);
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Factor.Open(cdsMM,'TSysDefine',Params);

    if cdsMM.IsEmpty then Exit;

    cdsMM.First;
    while not cdsMM.Eof do
      begin
        Str_Define := cdsMM.FieldByName('DEFINE').AsString;
        Str_Value := cdsMM.FieldByName('VALUE').AsString;

        if Str_Define = 'XSM_UserName' then
          edtUSERNAME.Text := Str_Value;
        if Str_Define = 'XSM_Password' then
          begin
            edtPASSWORD.Text := DecStr(Str_Value,ENC_KEY);
            edtPASSWORD1.Text := edtPASSWORD.Text;
          end;
        if Str_Define = 'XSM_Url' then
          edtURL.Text := Str_Value;
        cdsMM.Next;
      end;

  finally
    Params.Free;
  end;
end;

procedure TfrmCollocateMM.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCollocateMM.FormShow(Sender: TObject);
begin
  inherited;
  ReadFromData;
end;

end.
