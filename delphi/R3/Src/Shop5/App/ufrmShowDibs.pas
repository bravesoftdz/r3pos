unit ufrmShowDibs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, RzButton, ExtCtrls, RzPanel,Math,
  StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,ZBase, ZDataSet;

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
  private
    { Private declarations }
    Digit:integer;
    MainRecord:TRecord_;
    TotalFee:Currency;
    PayKey:string;
    procedure ShowFee;
    function Calc:Currency;
    procedure InitForm;
    function DoPayB(mny:Currency):boolean;
    procedure DoPayC(mny:Currency);
  public
    { Public declarations }
    class function ShowDibs(Owner:TForm;_TotalFee:Currency;_MainRecord:TRecord_;var Printed:boolean;var Cash:Currency;var Dibs:Currency):Boolean;
  end;

implementation
uses uGlobal,ufnUtil,uExpression,ufrmDibsOption,uShopGlobal,ufrmLogin,ufrmCardNoInput,EncDec;
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

class function TfrmShowDibs.ShowDibs(Owner:TForm;_TotalFee:Currency;_MainRecord:TRecord_;var Printed:boolean;var Cash:Currency;var Dibs:Currency): Boolean;
var r:Currency;
begin
  with TfrmShowDibs.Create(Owner) do
    begin
      try
        r := MyRoundTo(_TotalFee,Digit);
        MainRecord := _MainRecord;
        if MainRecord.FieldByName('PAY_DIBS').AsString = '' then
           MainRecord.FieldByName('PAY_DIBS').asFloat := (_TotalFee-r);
        if MainRecord.FieldByName('PAY_A').AsString = '' then
           MainRecord.FieldByName('PAY_A').AsFloat := 0;
        if MainRecord.FieldByName('PAY_B').AsString = '' then
           MainRecord.FieldByName('PAY_B').AsFloat := 0;
        if MainRecord.FieldByName('PAY_C').AsString = '' then
           MainRecord.FieldByName('PAY_C').AsFloat := 0;
        if MainRecord.FieldByName('PAY_D').AsString = '' then
           MainRecord.FieldByName('PAY_D').AsFloat := 0;
        if MainRecord.FieldByName('PAY_E').AsString = '' then
           MainRecord.FieldByName('PAY_E').AsFloat := 0;
        if MainRecord.FieldByName('PAY_F').AsString = '' then
           MainRecord.FieldByName('PAY_F').AsFloat := 0;
        if MainRecord.FieldByName('PAY_G').AsString = '' then
           MainRecord.FieldByName('PAY_G').AsFloat := 0;
        if MainRecord.FieldByName('PAY_H').AsString = '' then
           MainRecord.FieldByName('PAY_H').AsFloat := 0;
        if MainRecord.FieldByName('PAY_I').AsString = '' then
           MainRecord.FieldByName('PAY_I').AsFloat := 0;
        if MainRecord.FieldByName('PAY_J').AsString = '' then
           MainRecord.FieldByName('PAY_J').AsFloat := 0;
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
    Raise Exception.Create('输入无效表达式:'+s); 
  end;
end;
var r:Currency;
    AObj:TRecord_;
begin
  if (Key=#13) or (Key in ['+']) then
     begin
       if (edtTakeFee.Text = '') then
          begin
             if TotalFee>=0 then
                r :=  Calc-(TotalFee)
             else
                r :=  (TotalFee) - Calc;
             if r<0 then Raise Exception.Create('输入的实收金额不能小于应收总额');
             if StrtoFloatDef(edtDIBS.Text,0)<0 then Raise Exception.Create('找零金额不能是负数');
             if abs(MainRecord.FieldByName('CASH_MNY').AsFloat)<abs(StrtoFloatDef(edtDIBS.Text,0)) then Raise Exception.Create('找零金额不能大于实收现金');

             if TotalFee>0 then
             begin
               if ((r-MainRecord.FieldByName('CASH_MNY').AsFloat)>0) then Raise Exception.Create('支付金额不能大于应收总额');
             end
             else
             begin
               if ((r+MainRecord.FieldByName('CASH_MNY').AsFloat)>0) then Raise Exception.Create('支付金额不能大于应收总额');
             end;

             ModalResult := MROK;
             Exit;
          end;
       MainRecord.FieldByName('CASH_MNY').AsFloat := GetFee(edtTakeFee.Text);
       MainRecord.FieldByName('PAY_A').AsFloat := MainRecord.FieldByName('CASH_MNY').AsFloat;
       r :=  Calc-(TotalFee);
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if pos(uppercase(Key),uppercase(PayKey))>0 then
  begin
  if Key in ['A','a'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       MainRecord.FieldByName('CASH_MNY').AsFloat := GetFee(edtTakeFee.Text);
       MainRecord.FieldByName('PAY_A').AsFloat := MainRecord.FieldByName('CASH_MNY').AsFloat;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['B','b'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       if not DoPayB(GetFee(edtTakeFee.Text)) then Exit;
       MainRecord.FieldByName('PAY_B').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_B').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_B').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['C','c'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       DoPayC(GetFee(edtTakeFee.Text));
       //MainRecord.FieldByName('PAY_CASH').AsFloat := 0;
       MainRecord.FieldByName('PAY_C').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_C').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_C').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['D','d'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       if MainRecord.FieldByName('CLIENT_ID').AsString = '' then Raise Exception.Create('不是会员购买不能记账...');
       if ShopGlobal.offline then Raise Exception.Create('脱机操作不能记账...');
       //MainRecord.FieldByName('PAY_CASH').AsFloat := 0;
       MainRecord.FieldByName('PAY_D').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_D').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_D').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['E','e'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       //MainRecord.FieldByName('PAY_CASH').AsFloat := 0;
       MainRecord.FieldByName('PAY_E').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_E').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_E').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['F','f'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       //MainRecord.FieldByName('PAY_CASH').AsFloat := 0;
       MainRecord.FieldByName('PAY_F').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_F').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_F').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['G','g'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       //MainRecord.FieldByName('PAY_CASH').AsFloat := 0;
       MainRecord.FieldByName('PAY_G').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_G').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_G').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['H','h'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       //MainRecord.FieldByName('PAY_CASH').AsFloat := 0;
       MainRecord.FieldByName('PAY_H').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_H').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_H').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['I','i'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       //MainRecord.FieldByName('PAY_CASH').AsFloat := 0;
       MainRecord.FieldByName('PAY_I').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_I').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_I').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  if Key in ['J','j'] then
     begin
       if (edtTakeFee.Text = '') then Exit;
       //MainRecord.FieldByName('PAY_CASH').AsFloat := 0;
       MainRecord.FieldByName('PAY_J').AsFloat := GetFee(edtTakeFee.Text);
       if MainRecord.FieldByName('PAY_J').AsFloat<0 then
          begin
            MessageBox(handle,'此支持方式不能退款.','友情提示..',MB_OK+MB_ICONINFORMATION);
            MainRecord.FieldByName('PAY_J').AsFloat := 0;
          end;
       ShowFee;
       edtTakeFee.Text := '';
     end;
  end;
  if Key=#27 then Close ;
  if not (Key in ['1','2','3','4','5','6','7','8','9','0','-','.','*']) and ((Key in ['a'..'z']) or (Key in ['A'..'Z'])) then
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
  if n>10 then Raise Exception.Create('同时最多支持10种支付方式');
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
           if length(lblPAY_A.Caption)=4 then lblPAY_A.Caption := lblPAY_A.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'B' then
         begin
           lblPAY_B.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_B.Caption)=4 then lblPAY_B.Caption := lblPAY_B.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'C' then
         begin
           lblPAY_C.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_C.Caption)=4 then lblPAY_C.Caption := lblPAY_C.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'D' then
         begin
           lblPAY_D.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_D.Caption)=4 then lblPAY_D.Caption := lblPAY_D.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'E' then
         begin
           lblPAY_E.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_E.Caption)=4 then lblPAY_E.Caption := lblPAY_E.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'F' then
         begin
           lblPAY_F.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_F.Caption)=4 then lblPAY_F.Caption := lblPAY_F.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'G' then
         begin
           lblPAY_G.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_G.Caption)=4 then lblPAY_G.Caption := lblPAY_G.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'H' then
         begin
           lblPAY_H.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_H.Caption)=4 then lblPAY_H.Caption := lblPAY_H.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'I' then
         begin
           lblPAY_I.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_I.Caption)=4 then lblPAY_I.Caption := lblPAY_I.Caption + '支付';
         end;
      if rs.FieldByName('CODE_ID').AsString = 'J' then
         begin
           lblPAY_J.Caption := rs.FieldbyName('CODE_NAME').AsString;
           if length(lblPAY_J.Caption)=4 then lblPAY_J.Caption := lblPAY_J.Caption + '支付';
         end;
      rs.Next;
    end;
  Label6.Caption := '输入金额后按：'+s;
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
  if Key=VK_F5 then
     begin
       if not ShopGlobal.GetChkRight('500057') then
          begin
            if TfrmLogin.doLogin(Params) then
               begin
                 allow := ShopGlobal.GetChkRight('500057',1,Params.UserID);
                 if not allow then Exception.Create('你输入的用户没有抹零权限...'); 
               end
            else
              allow := false;
          end else allow := true;
       if allow then
       begin
        w := TotalFee;
        if TfrmDibsOption.ShowDibsOption(self,w) then
        begin
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

procedure TfrmShowDibs.DoPayC(mny:Currency);
var
  s,cardno,pwd:string;
  bal:real;
  rs:TZQuery;
begin
  Raise Exception.Create('对不起，您没有开通储值卡支付功能...');
{  if ShopGlobal.offline then Raise Exception.Create('脱机状态不能使用储值卡支付...');
  if MainRecord.FieldByName('CLIENT_ID').AsString = '' then
     begin
       s := TfrmCardNoInput.GetCardNo(self);
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select IC_CARDNO,PASSWRD,BALANCE,IC_STATUS from PUB_IC_INFO where TENANT_ID=:TENANT_ID and IC_CARDNO='''+s+''' and UNION_ID=''#'' and COMM not in (''02'',''12'')';
         Factor.Open(rs);
         if rs.IsEmpty then Raise Exception.Create('你输入的会员卡号无效...');
         case rs.FieldbyName('IC_STATUS').asInteger of
         2:Raise Exception.Create('当前会员卡号在挂失状态,无法完成支付...');
         9:Raise Exception.Create('当前会员卡号在注销状态,无法完成支付...');
         end;
         MainRecord.FieldByName('CLIENT_ID').AsString := rs.FieldbyName('CLIENT_ID').AsString;
         MainRecord.FieldByName('CLIENT_ID_TEXT').AsString := rs.FieldbyName('CLIENT_ID_TEXT').AsString;
         cardno := rs.FieldbyName('IC_CARDNO').AsString;
         pwd := rs.FieldbyName('PASSWRD').AsString;
         bal := rs.FieldbyName('BALANCE').asFloat;
       finally
         rs.Free;
       end;
     end
  else
     begin
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select IC_CARDNO,PASSWRD,BALANCE from VIW_CUSTOMER where TENANT_ID='+inttostr(Global.TENANT_ID)+' and CLIENT_ID='''+MainRecord.FieldByName('CLIENT_ID').AsString+'''';
         Factor.Open(rs);
         cardno := rs.FieldbyName('IC_CARDNO').AsString;
         pwd := rs.FieldbyName('PASSWRD').AsString;
         bal := rs.FieldbyName('BALANCE').asFloat;
       finally
         rs.Free;
       end;
     end;
  if cardno<>'' then
     begin
       s := TfrmCardNoInput.GetPassWrd(self);
       if EncStr(s,ENC_KEY)<>pwd then Raise Exception.Create('你输入的密码无效...');
       if bal<mny then Raise Exception.Create('储值卡余额为'+formatFloat('#0.0##',rs.Fields[1].AsFloat)+',余额不足不能完成支付');
     end;
}     
end;

function TfrmShowDibs.DoPayB(mny: Currency):boolean;
var
  CardNoReset:TCardNoReset;
begin
  if mny=0 then Raise Exception.Create('请输入刷卡金额后再按B健..');
  if ShopGlobal.GetParameter('BANK_CODE')<>'1' then Exit; 
  CardNoReset := TfrmCardNoInput.GetBank(self);
  if CardNoReset.ret then
     begin
       MainRecord.FieldbyName('BANK_CODE').AsString := CardNoReset.CardNo;
       MainRecord.FieldByName('BANK_ID').AsString := CardNoReset.BankId;
     end;
  result := CardNoReset.ret;
end;

end.
