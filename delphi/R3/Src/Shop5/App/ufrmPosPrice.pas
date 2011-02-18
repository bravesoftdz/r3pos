unit ufrmPosPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls;

type
  TfrmPosPrice = class(TfrmBasic)
    RzPanel1: TRzPanel;
    Label18: TLabel;
    edtORG_PRICE: TcxTextEdit;
    edtAGIO_RATE: TcxTextEdit;
    Label14: TLabel;
    Label1: TLabel;
    edtAPRICE: TcxTextEdit;
    Label2: TLabel;
    procedure edtAGIO_RATEPropertiesChange(Sender: TObject);
    procedure edtAPRICEPropertiesChange(Sender: TObject);
    procedure edtAPRICEKeyPress(Sender: TObject; var Key: Char);
    procedure edtAGIO_RATEKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    //进位法则
    CarryRule:integer;
    //保留小数位
    Deci:integer;
    Locked:boolean;
  public
    { Public declarations }
    class function PosPrice(AOwner:TForm;dight:integer;orgPrice,agoRate,aPrice:real):real;
  end;

implementation

uses uShopGlobal,uFnUtil;

{$R *.dfm}

{ TfrmPosPrice }

class function TfrmPosPrice.PosPrice(AOwner:TForm;dight: integer;orgPrice,agoRate,aPrice:real): real;
begin
  with TfrmPosPrice.Create(AOwner) do
    begin
      try
        edtORG_PRICE.Text := FloattoStr(orgPrice);
        edtAGIO_RATE.Text := FloattoStr(agoRate);
        edtAPRICE.Text := FloattoStr(aPrice);
        if ShowModal=MROK then
           begin
             result := StrtoFloatDef(edtAPRICE.Text,0);
           end
        else
           result := -1;
      finally
        free;
      end;
    end;
end;

procedure TfrmPosPrice.edtAGIO_RATEPropertiesChange(Sender: TObject);
var
  rate,v:Currency;
begin
  inherited;
  if Visible and not Locked then
     begin
       Locked := true;
       try
         rate := StrtoFloatDef(edtAGIO_RATE.Text,100);
         if rate < 10 then rate := rate *10;
         v := StrtoFloatDef(edtORG_PRICE.Text,0)*Rate/100;
         v := FnNumber.ConvertToFight(v,CarryRule,Deci);
         edtAPRICE.Text := Floattostr(v);
       finally
         Locked := false;
       end;
     end;
end;

procedure TfrmPosPrice.edtAPRICEPropertiesChange(Sender: TObject);
var
  rate,v,r:Currency;
  s:string;
begin
  inherited;
  if Visible and not Locked then
     begin
       Locked := true;
       try
         v := StrtoFloatDef(edtAPRICE.Text,0);
         r := StrtoFloatDef(edtORG_PRICE.Text,0);
         if r<>0 then
            rate := v / r * 100
         else
            rate := 0;
         edtAGIO_RATE.Text := formatfloat('#0.0',rate);
       finally
         Locked := false;
       end;
     end;
end;

procedure TfrmPosPrice.edtAPRICEKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       if trim(edtAPRICE.Text)<>'' then
          begin
            self.ModalResult := MROK;
            Exit;
          end;
     end
  else
  if not(Key in ['0'..'9','.',#13,#27,#46,#8]) then Key := #0;
end;

procedure TfrmPosPrice.edtAGIO_RATEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not(Key in ['0'..'9','.',#13,#27,#46,#8]) then Key := #0;

end;

procedure TfrmPosPrice.FormCreate(Sender: TObject);
begin
  inherited;
  //进位法则
  CarryRule := StrtoIntDef(ShopGlobal.GetParameter('CARRYRULE'),0);
  //保留小数位
  Deci := StrtoIntDef(ShopGlobal.GetParameter('POSDIGHT'),2);
end;

end.
 