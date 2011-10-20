unit ufrmRimConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit;

type
  TfrmRimConfig = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    chkTWO_PHASE_COMMIT: TCheckBox;
    GroupBox2: TGroupBox;
    CB_VipUpload: TCheckBox;
    CB_USE_SM_CARD: TCheckBox;
    Label3: TLabel;
    Edt_VipStatus: TcxComboBox;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
implementation
uses IniFiles;
{$R *.dfm}

procedure TfrmRimConfig.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmRimConfig.Button1Click(Sender: TObject);
var
  F:TIniFile;
  SetValue: string; //保存值  
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'PlugIn.cfg');
  try
    F.WriteString('rim','url',Edit1.Text);
    //启用分布式事务:
    if chkTWO_PHASE_COMMIT.Checked then SetValue:='1' else SetValue:='0';
    F.WriteString('PARAMS','TWO_PHASE_COMMIT',SetValue);
    //禁用上报R3终端消费者:
    if CB_VipUpload.Checked then SetValue:='0' else SetValue:='1';
    F.WriteString('PARAMS','VipUpload',SetValue);
    //启用消费者上报【商盟卡】
    F.WriteBool('PARAMS','USE_SM_CARD',CB_USE_SM_CARD.Checked);
    if trim(Edt_VipStatus.Text)<>'' then
      F.WriteString('PARAMS','UP_CUST_STATUS',Edt_VipStatus.Text);
  finally
    F.free;
  end;
  close;
end;

procedure TfrmRimConfig.FormCreate(Sender: TObject);
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'PlugIn.cfg');
  try
    Edit1.Text := F.ReadString('rim','url','');
    if F.ReadString('PARAMS','TWO_PHASE_COMMIT','1')='1' then
       chkTWO_PHASE_COMMIT.Checked :=true
    else
       chkTWO_PHASE_COMMIT.Checked :=False;

    if F.ReadString('PARAMS','VipUpload','1')='0' then CB_VipUpload.Checked:=true else CB_VipUpload.Checked:=false;
    CB_USE_SM_CARD.Checked:=F.ReadBool('PARAMS','USE_SM_CARD',False);
    Edt_VipStatus.Text:=F.ReadString('PARAMS','UP_CUST_STATUS','03');
  finally
    F.free;
  end;
end;

end.
