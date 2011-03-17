unit ufrmPswModify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, cxControls, cxContainer, cxEdit, cxTextEdit,
  ZBase, ExtCtrls,ZDataSet, RzButton, ufrmBasic, jpeg;

type
  TfrmPswModify = class(TfrmBasic)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtACOUNT: TcxTextEdit;
    edtOLDPSW: TcxTextEdit;
    edtNEWPSW: TcxTextEdit;
    edtCOFPSW: TcxTextEdit;
    cxBtnOk: TRzBitBtn;
    cxbtnCancel: TRzBitBtn;
    TitlePanel: TPanel;
    imgStepIcon: TImage;
    labTitle: TLabel;
    Bevel2: TBevel;
    HintL: TLabel;
    Image1: TImage;
    procedure cxbtnCancelClick(Sender: TObject);
    procedure cxBtnOkClick(Sender: TObject);
  private
    { Private declarations }
    FUSERID: string;
    IsAdmin:Boolean;
    AOLDPSW, ANEWPSW, ACOFPSW: string;
    procedure SetUSERID(const Value: string);
  public
    { Public declarations }
    class procedure ShowExecute(USER_ID:string;Account:string);
    property USERID:string read FUSERID write SetUSERID;
  end;

implementation

uses uGlobal,EncDec,ObjCommon;

{$R *.dfm}

class procedure TfrmPswModify.ShowExecute(USER_ID: string;Account:string);
var
  qTemp: TZQuery;
begin
  //������ʾ
  with TfrmPswModify.Create(Application) do
    begin
      try
        USERID := USER_ID;
        qTemp := TZQuery.Create(nil);
        try
          qTemp.Close;
          qTemp.SQL.Text := 'select PASS_WRD,USER_NAME from VIW_USERS where TENANT_ID='+inttostr(Global.TENANT_ID)+' and USER_ID=''' + USERID + '''';
          Factor.Open(qTemp);
          if qTemp.RecordCount > 0 then
            begin
              AOLDPSW := DecStr(qTemp.FieldByName('PASS_WRD').AsString,ENC_KEY);
              if AOLDPSW='1234' then
                 begin
                   HintL.Caption := 'Ϊ��������ݰ�ȫ�����޸�����.';
                   HintL.Font.Color := clRed;
                   edtOLDPSW.Text := '1234';
                 end
              else
                 edtOLDPSW.Text := '';
              edtACOUNT.Text := qTemp.FieldbyName('USER_NAME').AsString;
              edtNEWPSW.Text := '';
              edtCOFPSW.Text := '';
            end
          else
            begin
               Raise Exception.Create('��Ч�û���');
            end;
        finally
          qTemp.Free;
        end;
        ShowModal;
      finally
         Free;
      end;
    end;
end;

procedure TfrmPswModify.SetUSERID(const Value: string);
begin
  FUSERID := Value;
end;

procedure TfrmPswModify.cxbtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPswModify.cxBtnOkClick(Sender: TObject);
var
  sSqlTxt: string;
begin
  //����
  if UpperCase(edtOLDPSW.Text) <> UpperCase(AOLDPSW) then
  begin
    edtOLDPSW.SetFocus;
    raise Exception.Create('ԭ������󣬲����޸ģ�');
  end;
  if trim(edtNEWPSW.Text)='' then
  begin
    edtNEWPSW.SetFocus;
    raise Exception.Create('�������µ����룡');
  end;
  if UpperCase(edtNEWPSW.Text) <> UpperCase(edtCOFPSW.Text) then
  begin
    edtCOFPSW.SetFocus;
    raise Exception.Create('��������ȷ�����벻һ�£�');
  end;

  ANEWPSW := UpperCase(edtNEWPSW.Text);
  if lowercase(userid)<>'admin' then
    sSqlTxt := 'update CA_USERS set PASS_WRD=''' + EncStr(ANEWPSW,ENC_KEY) + ''',COMM=' + GetCommStr(Factor.iDbType) +
  ',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and '
       + 'USER_ID=''' + USERID + ''''
  else
    sSqlTxt := 'update SYS_DEFINE set VALUE=''' + EncStr(ANEWPSW,ENC_KEY) + ''',COMM=' + GetCommStr(Factor.iDbType) +
  ',TIME_STAMP='+GetTimeStamp(Factor.iDbType)+' where TENANT_ID='+inttostr(Global.TENANT_ID)+' and '
       + 'DEFINE=''PASSWRD''';
  try
    Factor.ExecSQL(sSqlTxt);
    Close;
  except           
    raise Exception.Create('����ʧ�ܣ�');
  end;
end;

end.

