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
  //窗体显示
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
                   HintL.Caption := '为了你的数据安全，请修改密码.';
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
               Raise Exception.Create('无效用户。');
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
  //保存
  if UpperCase(edtOLDPSW.Text) <> UpperCase(AOLDPSW) then
  begin
    edtOLDPSW.SetFocus;
    raise Exception.Create('原密码错误，不能修改！');
  end;
  if trim(edtNEWPSW.Text)='' then
  begin
    edtNEWPSW.SetFocus;
    raise Exception.Create('请输入新的密码！');
  end;
  if UpperCase(edtNEWPSW.Text) <> UpperCase(edtCOFPSW.Text) then
  begin
    edtCOFPSW.SetFocus;
    raise Exception.Create('新密码与确认密码不一致！');
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
    raise Exception.Create('保存失败！');
  end;
end;

end.

