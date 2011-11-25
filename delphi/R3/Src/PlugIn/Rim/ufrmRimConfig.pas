unit ufrmRimConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, ComCtrls;

type
  TfrmRimConfig = class(TForm)
    PageControl1: TPageControl;
    tabStock: TTabSheet;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GB_ITEM: TGroupBox;
    CB_1: TCheckBox;
    CB_2: TCheckBox;
    CB_3: TCheckBox;
    CB_4: TCheckBox;
    CB_5: TCheckBox;
    CB_6: TCheckBox;
    GroupBox3: TGroupBox;
    chkCUST_PSWD: TCheckBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    CB_VipUpload: TCheckBox;
    CB_USE_SM_CARD: TCheckBox;
    Edt_VipStatus: TcxComboBox;
    Panel4: TPanel;
    Panel2: TPanel;
    BtnOk: TButton;
    BtnClose: TButton;
    GroupBox4: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox5: TGroupBox;
    CB_AUTO_DOWN_ORDER: TCheckBox;
    GroupBox7: TGroupBox;
    CB_USE_CALC_RCKDAY: TCheckBox;
    CB_AUTO_DOWN_BASEINFO: TCheckBox;
    CB_7: TCheckBox;
    GroupBox1: TGroupBox;
    chkTWO_PHASE_COMMIT: TCheckBox;
    CB_8: TCheckBox;
    GB_liushui: TGroupBox;
    CB_9: TCheckBox;
    CB_10: TCheckBox;
    CB_11: TCheckBox;
    CB_12: TCheckBox;
    CB_13: TCheckBox;
    CB_14: TCheckBox;
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
implementation
uses IniFiles;
{$R *.dfm}

procedure TfrmRimConfig.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRimConfig.BtnOkClick(Sender: TObject);
var
  F:TIniFile;
  SetValue: string; //����ֵ  
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'PlugIn.cfg');
  try
    F.WriteString('rim','url',Edit1.Text);
    //���ÿͻ����룺
    F.WriteBool('rim','USING_CUST_PSWD',chkCUST_PSWD.Checked);
 
    //���÷ֲ�ʽ����:
    if chkTWO_PHASE_COMMIT.Checked then SetValue:='1' else SetValue:='0';
    F.WriteString('PARAMS','TWO_PHASE_COMMIT',SetValue);
    //�����ϱ�R3�ն�������:
    if CB_VipUpload.Checked then SetValue:='0' else SetValue:='1';
    F.WriteString('PARAMS','VipUpload',SetValue);
    //�����������ϱ������˿���
    F.WriteBool('PARAMS','USE_SM_CARD',CB_USE_SM_CARD.Checked);
    if trim(Edt_VipStatus.Text)<>'' then F.WriteString('PARAMS','UP_CUST_STATUS',Edt_VipStatus.Text);

    //�����Զ�����ȷ�ϣ�
    F.WriteBool('PARAMS','AUTO_DOWN_ORDER',CB_AUTO_DOWN_ORDER.Checked);
    //�����ϱ�̨��ǰ������:
    F.WriteBool('PARAMS','USE_CALC_RCKDAY',CB_USE_CALC_RCKDAY.Checked);
    //���ö���ǰ�Զ�����Rsp�������ϣ�
    F.WriteBool('PARAMS','AUTO_DOWN_BASEINFO',CB_AUTO_DOWN_BASEINFO.Checked);

    //�ϱ�ѡ�
    SetValue:='';
    if CB_1.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_2.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_3.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_4.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_5.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_6.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_7.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_8.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_9.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_10.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_11.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_12.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';                    
    if CB_13.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';
    if CB_14.Checked then SetValue:=SetValue+'1' else SetValue:=SetValue+'0';   
    F.WriteString('PARAMS','PlugInID',SetValue);
  finally
    F.free;
  end;
  close;
end;

procedure TfrmRimConfig.FormCreate(Sender: TObject);
var
  F:TIniFile;
  tmpValue: string;
begin
  PageControl1.ActivePageIndex:=0;
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
    chkCUST_PSWD.Checked := F.ReadBool('rim','USING_CUST_PSWD',false);

    //�����Զ�����ȷ�ϣ�
    chkCUST_PSWD.Checked:=F.ReadBool('rim','AUTO_DOWN_ORDER',False);
    //�����ϱ�̨��ǰ������:
    CB_USE_CALC_RCKDAY.Checked:=F.ReadBool('PARAMS','USE_CALC_RCKDAY',False);
    //���ö���ǰ�Զ�����Rsp�������ϣ�
    CB_AUTO_DOWN_BASEINFO.Checked:=F.ReadBool('PARAMS','AUTO_DOWN_BASEINFO',False);

    //�ϱ�ѡ�
    tmpValue:=F.ReadString('PARAMS','PlugInID','00000000000000000000000000000');
    CB_1.Checked:=(Copy(tmpValue,1,1)='1');
    CB_2.Checked:=(Copy(tmpValue,2,1)='1');
    CB_3.Checked:=(Copy(tmpValue,3,1)='1');
    CB_4.Checked:=(Copy(tmpValue,4,1)='1');
    CB_5.Checked:=(Copy(tmpValue,5,1)='1');
    CB_6.Checked:=(Copy(tmpValue,6,1)='1');    
    CB_7.Checked:=(Copy(tmpValue,7,1)='1');
    CB_8.Checked:=(Copy(tmpValue,8,1)='1');
    CB_9.Checked:=(Copy(tmpValue,9,1)='1');
    CB_10.Checked:=(Copy(tmpValue,10,1)='1');
    CB_11.Checked:=(Copy(tmpValue,11,1)='1');
    CB_12.Checked:=(Copy(tmpValue,12,1)='1');
    CB_13.Checked:=(Copy(tmpValue,13,1)='1');
    CB_14.Checked:=(Copy(tmpValue,14,1)='1');
  finally
    F.free;
  end;
end;

end.
