unit ufrmCardNoInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, StdCtrls, cxControls, cxContainer,ZBase,
  cxEdit, cxTextEdit, ExtCtrls, RzPanel, cxMaskEdit, cxDropDownEdit, ZDataSet;

type
  TCardNoReset=record
    ret:boolean;
    CardNo:string;
    PassWrd:string;
    BankId:string;
  end;
  TfrmCardNoInput = class(TfrmBasic)
    RzPanel1: TRzPanel;
    edtCardNo: TcxTextEdit;
    Label3: TLabel;
    procedure edtCardNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    Fflag: integer;
    { Private declarations }
    procedure InitBank;
    function GetCheckNo:string;
    procedure Setflag(const Value: integer);
  public
    { Public declarations }
    class function GetCardNo(Owner:TForm):TCardNoReset;
    class function GetPassWrd(Owner:TForm):TCardNoReset;
    class function GetBank(Owner:TForm):TCardNoReset;
    property flag:integer read Fflag write Setflag;
  end;

implementation
uses uGlobal,uDsUtil,uFnUtil;
{$R *.dfm}

{ TfrmCardNoInput }

class function TfrmCardNoInput.GetCardNo(Owner:TForm): TCardNoReset;
begin
  with TfrmCardNoInput.Create(Owner) do
    begin
      try
        Label3.Caption := '请输入你的卡号';
        flag := 0;
        if ShowModal=MROK then
           begin
             result.ret := true;
             result.CardNo := edtCardNo.Text;
           end
        else
           result.ret := false;
      finally
        free;
      end;
    end;
end;

procedure TfrmCardNoInput.edtCardNoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key=#13) then
     begin
       edtCardNo.Text := GetCheckNo;
       ModalResult := MROK;
     end;
end;

class function TfrmCardNoInput.GetPassWrd(Owner: TForm): TCardNoReset;
begin
  with TfrmCardNoInput.Create(Owner) do
    begin
      try
        Label3.Caption := '请输入你的密码';
        flag := 1;
        edtCardNo.Properties.EchoMode := eemPassword;
        if ShowModal=MROK then
           begin
             result.ret := true;
             result.PassWrd := edtCardNo.Text;
           end
        else
           result.ret := false;
      finally
        free;
      end;
    end;
end;

class function TfrmCardNoInput.GetBank(Owner: TForm): TCardNoReset;
begin
  with TfrmCardNoInput.Create(Owner) do
    begin
      try
        Label3.Caption := '请输入银行卡号';
        flag := 2;
        InitBank;
        if ShowModal=MROK then
           begin
             result.ret := true;
             result.CardNo := edtCardNo.Text;
             //if BANK_ID.ItemIndex<0 then Raise Exception.Create('请选择刷卡银行..');
             //result.BankId := TRecord_(BANK_ID.Properties.Items.Objects[BANK_ID.ItemIndex]).FieldbyName('CODE_ID').asString;
           end
        else
           result.ret := false;
      finally
        free;
      end;
    end;
end;

procedure TfrmCardNoInput.InitBank;
var
  rs:TZQuery;
begin
//  rs := Global.GetZQueryFromName('PUB_BANK_INFO');
//  TdsItems.AddDataSetToItems(rs,BANK_ID.Properties.Items,'CODE_NAME');
//  Height := 185;
end;

procedure TfrmCardNoInput.FormDestroy(Sender: TObject);
begin
//  TdsItems.ClearItems(BANK_ID.Properties.Items);
  inherited;

end;

function TfrmCardNoInput.GetCheckNo: string;
begin
  result := trim(edtCardNo.Text);
  if edtCardNo.Properties.EchoMode <> eemPassword then
     begin
       if pos('=',result)>0 then
          begin
            result := copy(result,1,pos('=',result)-1);
          end;
     end;
  if flag=2 then
     begin
       if not FnString.CheckBankCode(result) then
          begin
            edtCardNo.SetFocus;
            Raise Exception.Create('请输入银行卡号无效，请重新刷卡...'); 
          end;
     end;
end;

procedure TfrmCardNoInput.Setflag(const Value: integer);
begin
  Fflag := Value;
end;

end.
