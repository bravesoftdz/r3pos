unit ufrmShowDibs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, ExtCtrls, RzPanel,Math,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,ZBase, ZDataSet;

const
  //��λ����
  WM_LVL_PRICE=WM_USER+4;
  //��λ�������
  WM_LVL_PRICE_OVER=WM_USER+5;

type
  TfrmShowDibs = class(TfrmBasic)
    RzPanel1: TRzPanel;
    Label1: TLabel;
    lblPAY_A: TLabel;
    lblPAY_B: TLabel;
    edtTotalFee: TcxTextEdit;
    edtPAY_A: TcxTextEdit;
    Panel1: TPanel;
    Label6: TLabel;
    edtPAY_B: TcxTextEdit;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    edtTakeFee: TcxTextEdit;
    edtDIBS: TcxTextEdit;
    Label3: TLabel;
    lblPAY_C: TLabel;
    edtPAY_C: TcxTextEdit;
    lblPAY_D: TLabel;
    edtPAY_D: TcxTextEdit;
    edtPAY_E: TcxTextEdit;
    lblPAY_E: TLabel;
    Label2: TLabel;
    edtPAY_WAIT: TcxTextEdit;
    edtPrintTicket: TCheckBox;
    lblPAY_G: TLabel;
    lblPAY_F: TLabel;
    edtPAY_G: TcxTextEdit;
    edtPAY_F: TcxTextEdit;
    lblPAY_H: TLabel;
    edtPAY_H: TcxTextEdit;
    lblPAY_I: TLabel;
    edtPAY_I: TcxTextEdit;
    lblPAY_J: TLabel;
    edtPAY_J: TcxTextEdit;
    Label4: TLabel;
    procedure edtTakeFeeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtTotalFeeEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTakeFeeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtTakeFeeEnter(Sender: TObject);
  private
    { Private declarations }
    FHandle : Hwnd;
    Digit:integer;
    MainRecord:TRecord_;
    TotalFee:Currency;
    PayKey:string;
    PayDs:TZQuery;
    procedure ShowFee;
    function Calc:Currency;
    procedure InitForm;
    function DoPayB(mny:Currency):boolean;
    function DoPayC(mny:Currency):boolean;
    procedure WMLvlPriceOver(var Message: TMessage); message WM_LVL_PRICE_OVER;
  public
    { Public declarations }
    class function ShowDibs(Owner:TForm;_TotalFee:Currency;_MainRecord:TRecord_;var Printed:boolean;var Cash:Currency;var Dibs:Currency;var zPayDs:TZQuery; vHandle : Hwnd=0):Boolean;
  end;

implementation
uses uGlobal,uDevFactory,ufnUtil,uDsUtil,uExpression,ufrmDibsOption,uShopGlobal,ufrmLogin,ufrmCardNoInput,EncDec,uMsgBox;
{$R *.dfm}

function MyRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Currency;
var
  LFactor: Currency;
  MyValue: Currency;
begin
  LFactor := IntPower(10, ADigit);
  MyValue := (AValue / LFactor);
  Result := Trunc(MyValue) * LFactor;
end;
{ TfrmShowDibs }

class function TfrmShowDibs.ShowDibs(Owner:TForm;_TotalFee:Currency;_MainRecord:TRecord_;var Printed:boolean;var Cash:Currency;var Dibs:Currency;var zPayDs:TZQuery; vHandle : Hwnd): Boolean;
var r:Currency;
begin
  with TfrmShowDibs.Create(Owner) do
    begin
      try
        FHandle := vHandle;
        PayDs := zPayDs;
        r := MyRoundTo(_TotalFee,Digit);
        //2012.04.10�ڹ���������ʾ�ܼ�(Ĩ0֮����):
        TDevFactory.ShowATotal(r);
        MainRecord := _MainRecord;
        //2011-07-25 Ϊ�򵥲�����ȥ�������տ����ݹ��� zhangsr
        //if MainRecord.FieldByName('PAY_DIBS').AsString = '' then
           MainRecord.FieldByName('PAY_DIBS').asFloat := (_TotalFee-r-MainRecord.FieldByName('PAY_DIBS').AsFloat); //2012.02.11Ĩ����
        //if MainRecord.FieldByName('PAY_A').AsString = '' then
           MainRecord.FieldByName('PAY_A').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_B').AsString = '' then
           MainRecord.FieldByName('PAY_B').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_C').AsString = '' then
           MainRecord.FieldByName('PAY_C').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_D').AsString = '' then
           MainRecord.FieldByName('PAY_D').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_E').AsString = '' then
           MainRecord.FieldByName('PAY_E').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_F').AsString = '' then
           MainRecord.FieldByName('PAY_F').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_G').AsString = '' then
           MainRecord.FieldByName('PAY_G').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_H').AsString = '' then
           MainRecord.FieldByName('PAY_H').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_I').AsString = '' then
           MainRecord.FieldByName('PAY_I').AsFloat := 0;
        //if MainRecord.FieldByName('PAY_J').AsString = '' then
           MainRecord.FieldByName('PAY_J').AsFloat := 0;

        //��λ
           MainRecord.FieldByName('CASH_MNY').AsFloat := 0;
           MainRecord.FieldByName('PAY_ZERO').AsFloat := 0;
        TotalFee := _TotalFee;
        ShowFee;
        edtTakeFee.Text := edtPAY_WAIT.Text;
        edtPrintTicket.Checked := Printed;
        result := (ShowModal=MROK);
        if result then
           begin
             Printed := edtPrintTicket.Checked;
             MainRecord.FieldByName('PAY_ZERO').AsFloat := StrtoFloat(edtDIBS.Text);
             MainRecord.FieldByName('PAY_A').AsFloat :=
                MainRecord.FieldByName('CASH_MNY').AsFloat-MainRecord.FieldByName('PAY_ZERO').AsFloat;
             //2012.04.10�ڹ���������ʾ����:
             TDevFactory.ShowDibs(MainRecord.FieldByName('PAY_ZERO').AsFloat);
           end;
      finally
        free;
      end;
    end;
end;

procedure TfrmShowDibs.edtTakeFeeKeyPress(Sender: TObject; var Key: Char);
function GetFee(s:string):Currency;
begin
  result := 0;
  try
  if s='' then exit;
  if FnString.IsNumberChar(s) then
     result := StrtoFloatDef(s,0)
  else
     result := GetExpressionValue(edtTotalFee.Text+s,nil);
  result := MyRoundTo(result,Digit);
  except
    Raise Exception.Create('������Ч���ʽ:'+s); 
  end;
end;
var r:Currency;
    AObj:TRecord_;
begin
  if (Key=#13) or (Key in ['+']) then
     begin
       Key := #0;
       if (edtTakeFee.Text = '') then
          begin
             if TotalFee>=0 then
                r :=  Calc-(TotalFee)
             else
                r :=  (TotalFee) - Calc;
             if r<0 then Raise Exception.Create('�����ʵ�ս���С��Ӧ���ܶ�');
             if StrtoFloatDef(edtDIBS.Text,0)<0 then Raise Exception.Create('��������Ǹ���');
             if r>=100 then Raise Exception.Create('������տ��������ȷ���Ƿ�����ˡ�'); 
             if abs(MainRecord.FieldByName('CASH_MNY').AsFloat)<abs(StrtoFloatDef(edtDIBS.Text,0)) then Raise Exception.Create('������ܴ���ʵ���ֽ�');

             if TotalFee>0 then
             begin
               if ((r-MainRecord.FieldByName('CASH_MNY').AsFloat)>0) then Raise Exception.Create('֧�����ܴ���Ӧ���ܶ�');
             end
             else
             begin
               if ((r+MainRecord.FieldByName('CASH_MNY').AsFloat)>0) then Raise Exception.Create('֧�����ܴ���Ӧ���ܶ�');
             end;

             ModalResult := MROK;
             Exit;
          end;
       MainRecord.FieldByName('CASH_MNY').AsFloat := GetFee(edtTakeFee.Text);
       MainRecord.FieldByName('PAY_A').AsFloat := MainRecord.FieldByName('CASH_MNY').AsFloat;
       //2012.04.10����������ʾʵ���ֽ�:
       TDevFactory.ShowAMoney(MainRecord.FieldByName('PAY_A').AsFloat);
       if edtTakeFee.CanFocus and not edtTakeFee.Focused then edtTakeFee.SetFocus;
       r :=  Calc-(TotalFee);
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if (pos(uppercase(Key),uppercase(PayKey))>0) and (trim(edtTakeFee.Text) <> '') then
  begin
  if Key in ['A','a'] then
     begin
       MainRecord.FieldByName('CASH_MNY').AsFloat := GetFee(edtTakeFee.Text);
       MainRecord.FieldByName('PAY_A').AsFloat := MainRecord.FieldByName('CASH_MNY').AsFloat;
       //2012.04.10����������ʾʵ���ֽ�:
       TDevFactory.ShowAMoney(MainRecord.FieldByName('PAY_A').AsFloat);
       if edtTakeFee.CanFocus and not edtTakeFee.Focused then edtTakeFee.SetFocus;    
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['B','b'] then
     begin
       DoPayB(GetFee(edtTakeFee.Text));
       MainRecord.FieldByName('PAY_B').AsFloat := GetFee(edtTakeFee.Text);
       //if MainRecord.FieldByName('PAY_B').AsFloat<0 then
       //   begin
       //     MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       //     MainRecord.FieldByName('PAY_B').AsFloat := 0;
       //   end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['C','c'] then
     begin
       DoPayC(GetFee(edtTakeFee.Text));
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['D','d'] then
     begin
       if MainRecord.FieldByName('CLIENT_ID').AsString = '' then Raise Exception.Create('���ǻ�Ա�����ܼ���...');
       MainRecord.FieldByName('PAY_D').AsFloat := GetFee(edtTakeFee.Text);
       //if MainRecord.FieldByName('PAY_D').AsFloat<0 then
       //   begin
       //     MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       //     MainRecord.FieldByName('PAY_D').AsFloat := 0;
       //   end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['E','e'] then
     begin
       MainRecord.FieldByName('PAY_E').AsFloat := GetFee(edtTakeFee.Text);
       //if MainRecord.FieldByName('PAY_E').AsFloat<0 then
       //   begin
       //     MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       //     MainRecord.FieldByName('PAY_E').AsFloat := 0;
       //   end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['F','f'] then
     begin
       MainRecord.FieldByName('PAY_F').AsFloat := GetFee(edtTakeFee.Text);
       //if MainRecord.FieldByName('PAY_F').AsFloat<0 then
       //   begin
       //     MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       //     MainRecord.FieldByName('PAY_F').AsFloat := 0;
       //   end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['G','g'] then
     begin
       MainRecord.FieldByName('PAY_G').AsFloat := GetFee(edtTakeFee.Text);
       //if MainRecord.FieldByName('PAY_G').AsFloat<0 then
       //   begin
       //     MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       //     MainRecord.FieldByName('PAY_G').AsFloat := 0;
       //   end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['H','h'] then
     begin
       MainRecord.FieldByName('PAY_H').AsFloat := GetFee(edtTakeFee.Text);
       //if MainRecord.FieldByName('PAY_H').AsFloat<0 then
       //   begin
       //     MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       //     MainRecord.FieldByName('PAY_H').AsFloat := 0;
       //   end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['I','i'] then
     begin
       MainRecord.FieldByName('PAY_I').AsFloat := GetFee(edtTakeFee.Text);
       //if MainRecord.FieldByName('PAY_I').AsFloat<0 then
       //   begin
       //     MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       //     MainRecord.FieldByName('PAY_I').AsFloat := 0;
       //   end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['J','j'] then
     begin
       MainRecord.FieldByName('PAY_J').AsFloat := GetFee(edtTakeFee.Text);
       //if MainRecord.FieldByName('PAY_J').AsFloat<0 then
       //   begin
       //     MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       //     MainRecord.FieldByName('PAY_J').AsFloat := 0;
       //   end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  end;
  if Key=#27 then Close ;
  if not (Key in ['1','2','3','4','5','6','7','8','9','0','-','.','*',#8]) then
     Key := #0;
end;

procedure TfrmShowDibs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;
  if Key=VK_F12 then  edtPrintTicket.Checked := not edtPrintTicket.Checked;

end;

procedure TfrmShowDibs.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;

end;

procedure TfrmShowDibs.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close;
//  inherited;

end;

procedure TfrmShowDibs.edtTotalFeeEnter(Sender: TObject);
begin
  inherited;
  edtTakeFee.SetFocus;
end;

procedure TfrmShowDibs.ShowFee;
procedure ShowInfo(n:integer;cname:string;value:Currency);
begin
  case n of
  1:begin
      edtPAY_A.Text := formatfloat('#0.0##',value);
      lblPAY_A.Visible := true;
      edtPAY_A.Visible := true;
    end;
  2:begin
      edtPAY_B.Text := formatfloat('#0.0##',value);
      lblPAY_B.Visible := true;
      edtPAY_B.Visible := true;
    end;
  3:begin
      edtPAY_C.Text := formatfloat('#0.0##',value);
      lblPAY_C.Visible := true;
      edtPAY_C.Visible := true;
    end;
  4:begin
      edtPAY_D.Text := formatfloat('#0.0##',value);
      lblPAY_D.Visible := true;
      edtPAY_D.Visible := true;
    end;
  5:begin
      edtPAY_E.Text := formatfloat('#0.0##',value);
      lblPAY_E.Visible := true;
      edtPAY_E.Visible := true;
    end;
  6:begin
      edtPAY_F.Text := formatfloat('#0.0##',value);
      lblPAY_F.Visible := true;
      edtPAY_F.Visible := true;
    end;
  7:begin
      edtPAY_G.Text := formatfloat('#0.0##',value);
      lblPAY_G.Visible := true;
      edtPAY_G.Visible := true;
    end;
  8:begin
      edtPAY_H.Text := formatfloat('#0.0##',value);
      lblPAY_H.Visible := true;
      edtPAY_H.Visible := true;
    end;
  9:begin
      edtPAY_I.Text := formatfloat('#0.0##',value);
      lblPAY_I.Visible := true;
      edtPAY_I.Visible := true;
    end;
  10:begin
      edtPAY_J.Text := formatfloat('#0.0##',value);
      lblPAY_J.Visible := true;
      edtPAY_J.Visible := true;
    end;
  end;
  if n>10 then Raise Exception.Create('ͬʱ���֧��10��֧����ʽ');
end;
var
  row:integer;
  r:Currency;
begin
  lblPAY_A.Visible := false;
  edtPAY_A.Visible := false;
  lblPAY_B.Visible := false;
  edtPAY_B.Visible := false;
  lblPAY_C.Visible := false;
  edtPAY_C.Visible := false;
  lblPAY_D.Visible := false;
  edtPAY_D.Visible := false;
  lblPAY_E.Visible := false;
  edtPAY_E.Visible := false;
  lblPAY_F.Visible := false;
  edtPAY_F.Visible := false;
  lblPAY_G.Visible := false;
  edtPAY_G.Visible := false;
  lblPAY_H.Visible := false;
  edtPAY_H.Visible := false;
  lblPAY_I.Visible := false;
  edtPAY_I.Visible := false;
  lblPAY_J.Visible := false;
  edtPAY_J.Visible := false;
  row := -1;
  if MainRecord.FieldByName('PAY_A').AsFloat <> 0 then
     begin
       ShowInfo(1,'',MainRecord.FieldByName('PAY_A').AsFloat);
       inc(row);
       edtPAY_A.Top := 164+row*45-44;
       lblPAY_A.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_B').AsFloat <> 0 then
     begin
       ShowInfo(2,'',MainRecord.FieldByName('PAY_B').AsFloat);
       inc(row);
       edtPAY_B.Top := 164+row*45-44;
       lblPAY_B.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_C').AsFloat <> 0 then
     begin
       ShowInfo(3,'',MainRecord.FieldByName('PAY_C').AsFloat);
       inc(row);
       edtPAY_C.Top := 164+row*45-44;
       lblPAY_C.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_D').AsFloat <> 0 then
     begin
       ShowInfo(4,'',MainRecord.FieldByName('PAY_D').AsFloat);
       inc(row);
       edtPAY_D.Top := 164+row*45-44;
       lblPAY_D.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_E').AsFloat <> 0 then
     begin
       ShowInfo(5,'',MainRecord.FieldByName('PAY_E').AsFloat);
       inc(row);
       edtPAY_E.Top := 164+row*45-44;
       lblPAY_E.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_F').AsFloat <> 0 then
     begin
       ShowInfo(6,'',MainRecord.FieldByName('PAY_F').AsFloat);
       inc(row);
       edtPAY_F.Top := 164+row*45-44;
       lblPAY_F.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_G').AsFloat <> 0 then
     begin
       ShowInfo(7,'',MainRecord.FieldByName('PAY_G').AsFloat);
       inc(row);
       edtPAY_G.Top := 164+row*45-44;
       lblPAY_G.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_H').AsFloat <> 0 then
     begin
       ShowInfo(7,'',MainRecord.FieldByName('PAY_H').AsFloat);
       inc(row);
       edtPAY_H.Top := 164+row*45-44;
       lblPAY_H.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_I').AsFloat <> 0 then
     begin
       ShowInfo(7,'',MainRecord.FieldByName('PAY_I').AsFloat);
       inc(row);
       edtPAY_I.Top := 164+row*45-44;
       lblPAY_I.Top := 168+row*45-44;
     end;
  if MainRecord.FieldByName('PAY_J').AsFloat <> 0 then
     begin
       ShowInfo(7,'',MainRecord.FieldByName('PAY_J').AsFloat);
       inc(row);
       edtPAY_J.Top := 164+row*45-44;
       lblPAY_J.Top := 168+row*45-44;
     end;
  Height := 288+(row+1)*46;
  if TotalFee>=0 then
  begin
    r := Calc-(TotalFee);
    if r<0 then r := 0;
    edtDibs.Text := formatfloat('#0.0##',r);
    edtTotalFee.Text := formatfloat('#0.0##',TotalFee);

    r := (TotalFee) - Calc;
    if r<0 then r := 0;
    edtPAY_WAIT.Text := formatfloat('#0.0##',r);
  end
  else
  begin
    r := (TotalFee)- Calc;
    if r<0 then r := 0;
    edtDibs.Text := formatfloat('#0.0##',r);
    edtTotalFee.Text := formatfloat('#0.0##',TotalFee);

    r := (TotalFee) - Calc;
    if r>0 then r := 0;
    edtPAY_WAIT.Text := formatfloat('#0.0##',r);
  end;
end;
function TfrmShowDibs.Calc:Currency;
begin
  result :=
     MainRecord.FieldByName('PAY_A').AsFloat+
     MainRecord.FieldByName('PAY_B').AsFloat+
     MainRecord.FieldByName('PAY_C').AsFloat+
     MainRecord.FieldByName('PAY_D').AsFloat+
     MainRecord.FieldByName('PAY_E').AsFloat+
     MainRecord.FieldByName('PAY_F').AsFloat+
     MainRecord.FieldByName('PAY_G').AsFloat+
     MainRecord.FieldByName('PAY_H').AsFloat+
     MainRecord.FieldByName('PAY_I').AsFloat+
     MainRecord.FieldByName('PAY_J').AsFloat+
     MainRecord.FieldByName('PAY_DIBS').AsFloat;
end;

procedure TfrmShowDibs.InitForm;
var
  rs:TZQuery;
  s:string;
begin
  rs := Global.GeTZQueryFromName('PUB_PAYMENT');
  rs.First;
  PayKey := '';
  while not rs.eof do
    begin
      if s<>'' then s := s +'  ';
      PayKey := PayKey + rs.FieldbyName('CODE_ID').AsString;
      s := s + rs.FieldbyName('CODE_ID').AsString+'.'+rs.FieldbyName('CODE_NAME').AsString;
      if rs.FieldByName('CODE_ID').AsString = 'A' then
         begin
           lblPAY_A.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_A.Caption)=4 then lblPAY_A.Caption := lblPAY_A.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'B' then
         begin
           lblPAY_B.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_B.Caption)=4 then lblPAY_B.Caption := lblPAY_B.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'C' then
         begin
           lblPAY_C.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_C.Caption)=4 then lblPAY_C.Caption := lblPAY_C.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'D' then
         begin
           lblPAY_D.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_D.Caption)=4 then lblPAY_D.Caption := lblPAY_D.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'E' then
         begin
           lblPAY_E.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_E.Caption)=4 then lblPAY_E.Caption := lblPAY_E.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'F' then
         begin
           lblPAY_F.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_F.Caption)=4 then lblPAY_F.Caption := lblPAY_F.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'G' then
         begin
           lblPAY_G.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_G.Caption)=4 then lblPAY_G.Caption := lblPAY_G.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'H' then
         begin
           lblPAY_H.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_H.Caption)=4 then lblPAY_H.Caption := lblPAY_H.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'I' then
         begin
           lblPAY_I.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_I.Caption)=4 then lblPAY_I.Caption := lblPAY_I.Caption + '֧��';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'J' then
         begin
           lblPAY_J.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_J.Caption)=4 then lblPAY_J.Caption := lblPAY_J.Caption + '֧��';
         end;
      rs.Next;
    end;
  Label6.Caption := '������󰴣�'+s;
end;

procedure TfrmShowDibs.FormCreate(Sender: TObject);
begin
  inherited;
  InitForm;
  Digit := StrtoIntDef(ShopGlobal.GetParameter('POSCALCDIGHT'),-2);
end;

procedure TfrmShowDibs.edtTakeFeeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  w:Currency;
  Params:TLoginParam;
  allow :boolean;
begin
  inherited;
  if Key=VK_F9 then
    begin
      if MessageBox(Handle,'�Ƿ����õ�λ����?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
      PostMessage(FHandle, WM_LVL_PRICE, self.Handle, 0);
      // Close;
    end;
  if Key=VK_F5 then
     begin
       if not ShopGlobal.GetChkRight('13100001',7) then
          begin
            if TfrmLogin.doLogin(Params) then
               begin
                 allow := ShopGlobal.GetChkRight('13100001',7,Params.UserID);
                 if not allow then Exception.Create('��������û�û��Ĩ��Ȩ��...'); 
               end
            else
              allow := false;
          end else allow := true;
       if allow then
       begin
        w := TotalFee;
        if TfrmDibsOption.ShowDibsOption(self,w) then
        begin
          MainRecord.FieldByName('CASH_MNY').AsFloat := 0;
          MainRecord.FieldByName('PAY_A').AsFloat := 0;
          MainRecord.FieldByName('PAY_B').AsFloat := 0;
          MainRecord.FieldByName('PAY_C').AsFloat := 0;
          MainRecord.FieldByName('PAY_D').AsFloat := 0;
          MainRecord.FieldByName('PAY_E').AsFloat := 0;
          MainRecord.FieldByName('PAY_F').AsFloat := 0;
          MainRecord.FieldByName('PAY_G').AsFloat := 0;
          MainRecord.FieldByName('PAY_H').AsFloat := 0;
          MainRecord.FieldByName('PAY_I').AsFloat := 0;
          MainRecord.FieldByName('PAY_J').AsFloat := 0;
          MainRecord.FieldbyName('PAY_DIBS').asString := formatFloat('#0.000',TotalFee-w);
          ShowFee;
          edtTakeFee.Text := edtPAY_WAIT.Text;
          edtTakeFee.SelectAll;
        end;
       end;
  end;
end;

function TfrmShowDibs.DoPayC(mny:Currency):boolean;
var
  s,cardno,pwd,csid:string;
  bal,payc:currency;
  rs:TZQuery;
  cr:TCardNoReset;
begin
  if PayDs=nil then Raise Exception.Create('�Բ�����û�п�ͨ��ֵ��֧������...');
  if mny<0 then
     begin
       MessageBox(handle,'��֧�ַ�ʽ�����˿�.','������ʾ..',MB_OK+MB_ICONINFORMATION);
       Exit;
     end;
  result := false;
  if mny=0 then //�����ֵ��֧��
     begin
       PayDs.First;
       while not PayDs.Eof do PayDs.Delete;
       MainRecord.FieldByName('PAY_C').AsFloat := 0;
       Exit;
     end;
  if (ShopGlobal.NetVersion or ShopGlobal.ONLVersion) and ShopGlobal.offline then Raise Exception.Create('�ѻ�״̬����ʹ�ô�ֵ��֧��...');
  cr := TfrmCardNoInput.GetCardNo(self);
  if not cr.ret then Exit;
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select IC_CARDNO,PASSWRD,BALANCE,IC_STATUS,CLIENT_ID,IC_TYPE from PUB_IC_INFO where TENANT_ID=:TENANT_ID and IC_CARDNO=:IC_CARDNO and UNION_ID=''#'' and IC_TYPE in (''0'',''2'') and COMM not in (''02'',''12'')';
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('IC_CARDNO').AsString := cr.CardNo;
    Factor.Open(rs);
    if rs.IsEmpty then Raise Exception.Create('������Ļ�Ա������Ч...');
    case rs.FieldbyName('IC_STATUS').asInteger of
    2:Raise Exception.Create('��ǰ�����ڹ�ʧ״̬,�޷����֧��...');
    9:Raise Exception.Create('��ǰ������ע��״̬,�޷����֧��...');
    end;
    cardno := rs.FieldbyName('IC_CARDNO').AsString;
    pwd := rs.FieldbyName('PASSWRD').AsString;
    bal := rs.FieldbyName('BALANCE').asFloat;
    csid := rs.FieldbyName('CLIENT_ID').AsString;
    if rs.FieldbyName('IC_TYPE').AsString='0' then
       begin
         cr := TfrmCardNoInput.GetPassWrd(self);
         if not cr.ret then Exit;
         if (EncStr(cr.PassWrd,ENC_KEY)<>pwd) then Raise Exception.Create('�������������Ч...');
       end;
    if bal<mny then Raise Exception.Create('��ֵ�����Ϊ'+formatFloat('#0.0##',bal)+',���㲻�����֧��');
  finally
    rs.Free;
  end;
  if PayDs.Locate('IC_CARDNO',cardno,[]) then
     PayDs.edit else
  begin
    PayDs.Append;
    PayDs.FieldbyName('GLIDE_ID').AsString := TSequence.NewId();
    PayDs.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
    PayDs.FieldbyName('SHOP_ID').AsString := Global.SHOP_ID;
    PayDs.FieldbyName('CLIENT_ID').AsString := csid;
    PayDs.FieldbyName('IC_GLIDE_TYPE').AsString := '2';
    PayDs.FieldbyName('GLIDE_INFO').AsString := 'ˢ��֧��';
    PayDs.FieldbyName('CREA_USER').AsString := Global.UserID;
  end;
  PayDs.FieldbyName('IC_CARDNO').AsString := cardno;
  PayDs.FieldbyName('PAY_C').asFloat := mny;
  PayDs.FieldbyName('GLIDE_MNY').asFloat := mny;
  PayDs.Post;
  payc := 0;
  PayDs.first;
  while not PayDs.eof do
    begin
      payc := payc + PayDs.FieldbyName('PAY_C').asFloat;
      PayDs.Next;
    end;
  MainRecord.FieldByName('PAY_C').AsFloat := payc;
  result := true;
end;

function TfrmShowDibs.DoPayB(mny: Currency):boolean;
var
  CardNoReset:TCardNoReset;
begin
  if mny=0 then
     begin
       result := true;
       Exit;
     end;
  if ShopGlobal.GetParameter('BANK_CODE')<>'1' then Exit; 
  CardNoReset := TfrmCardNoInput.GetBank(self);
  if CardNoReset.ret then
     begin
       MainRecord.FieldbyName('BANK_CODE').AsString := CardNoReset.CardNo;
       MainRecord.FieldByName('BANK_ID').AsString := CardNoReset.BankId;
     end;
  result := CardNoReset.ret;
end;

procedure TfrmShowDibs.edtTakeFeeEnter(Sender: TObject);
begin
  inherited;
  if myHKL>0 then
  ActivateKeyBoardLayOut(myHKL,KLF_ACTIVATE);
end;

procedure TfrmShowDibs.WMLvlPriceOver(var Message: TMessage);
var r : currency;
var _TotalFee : currency;
begin
  _TotalFee := Message.WParam / 1000;
	r := MyRoundTo(_TotalFee,Digit);
	
	MainRecord.FieldByName('PAY_DIBS').asFloat := (_TotalFee-r-MainRecord.FieldByName('PAY_DIBS').AsFloat); //2012.02.11Ĩ����      
	MainRecord.FieldByName('PAY_A').AsFloat := 0;      
	MainRecord.FieldByName('PAY_B').AsFloat := 0;      
	MainRecord.FieldByName('PAY_C').AsFloat := 0;      
	MainRecord.FieldByName('PAY_D').AsFloat := 0;      
	MainRecord.FieldByName('PAY_E').AsFloat := 0;      
	MainRecord.FieldByName('PAY_F').AsFloat := 0;      
	MainRecord.FieldByName('PAY_G').AsFloat := 0;      
	MainRecord.FieldByName('PAY_H').AsFloat := 0;      
	MainRecord.FieldByName('PAY_I').AsFloat := 0;      
	MainRecord.FieldByName('PAY_J').AsFloat := 0;      
	MainRecord.FieldByName('CASH_MNY').AsFloat := 0;
	MainRecord.FieldByName('PAY_ZERO').AsFloat := 0;
	
	TotalFee := _TotalFee;
	ShowFee;
	edtTakeFee.Text := edtPAY_WAIT.Text;
  //2012.04.10����������ʾ�ܼ�:
  TDevFactory.ShowATotal(r);
  if edtTakeFee.CanFocus and not edtTakeFee.Focused then edtTakeFee.SetFocus;
end;

end.
