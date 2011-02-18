unit ufrmDibsOption;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, cxControls, cxContainer, cxEdit, cxTextEdit,Math,
  StdCtrls, ExtCtrls, RzPanel, ActnList, Menus, ComCtrls, RzListVw, Grids,
  RzGrids;

type
  TfrmDibsOption = class(TfrmBasic)
    RzPanel1: TRzPanel;
    lblPAY_G: TLabel;
    lblPAY_F: TLabel;
    edtPAY_G: TcxTextEdit;
    edtPAY_F: TcxTextEdit;
    rzGrid: TRzStringGrid;
    RzPanel2: TRzPanel;
    edtPAY_FEE: TcxTextEdit;
    procedure FormCreate(Sender: TObject);
    procedure rzGridKeyPress(Sender: TObject; var Key: Char);
    procedure rzGridDblClick(Sender: TObject);
    procedure edtPAY_FEEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rzGridEnter(Sender: TObject);
    procedure edtPAY_FEEKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    _TotalFee:Currency;
    procedure DoDibs;
    procedure ShowGrid;
    class function ShowDibsOption(Owner:TForm;var TotalFee:Currency):boolean;
  end;

implementation

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

{ TfrmDibsOption }

procedure TfrmDibsOption.ShowGrid;
begin
  rzGrid.RowHeights[0] := rzGrid.Height div 2-1;
  rzGrid.RowHeights[1] := rzGrid.Height div 2-1;
  rzGrid.ColWidths[0] := (rzGrid.Width-3) div 3;
  rzGrid.ColWidths[1] := (rzGrid.Width-3) div 3;
  rzGrid.ColWidths[2] := (rzGrid.Width-3) div 3;
  rzGrid.Cells[0,0] := '元 F1';
  rzGrid.Cells[1,0] := '十 F2';
  rzGrid.Cells[2,0] := '百 F3';
  rzGrid.Cells[0,1] := '角 F4';
  rzGrid.Cells[1,1] := '分 F5';
  rzGrid.Cells[2,1] := '厘 F6';
end;

procedure TfrmDibsOption.FormCreate(Sender: TObject);
begin
  inherited;
  ShowGrid;
end;

class function TfrmDibsOption.ShowDibsOption(Owner: TForm;var TotalFee:Currency): boolean;
begin
  with TfrmDibsOption.Create(Owner) do
    begin
      try
        _TotalFee := TotalFee;
        edtPAY_FEE.Text := floattostr(MyRoundTo(_TotalFee,0));
        edtPAY_FEE.SelectAll;
        if ShowModal=MROK then
           begin
             TotalFee := StrtoFloatDef(edtPAY_FEE.Text,0);
             result := true;
           end
        else
           result := false;
      finally
        free;
      end;
    end;
end;

procedure TfrmDibsOption.rzGridKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then ModalResult := MROK;
end;

procedure TfrmDibsOption.rzGridDblClick(Sender: TObject);
begin
  inherited;
  ModalResult := MROK;

end;

procedure TfrmDibsOption.edtPAY_FEEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key=VK_F1) then
     begin
       rzGrid.Row := 0;
       rzGrid.Col := 0;
       DoDibs;
     end;
  if (Key=VK_F2) then
     begin
       rzGrid.Row := 0;
       rzGrid.Col := 1;
       DoDibs;
     end;
  if (Key=VK_F3) then
     begin
       rzGrid.Row := 0;
       rzGrid.Col := 2;
       DoDibs;
     end;
  if (Key=VK_F4) then
     begin
       rzGrid.Row := 1;
       rzGrid.Col := 0;
       DoDibs;
     end;
  if (Key=VK_F5) then
     begin
       rzGrid.Row := 1;
       rzGrid.Col := 1;
       DoDibs;
     end;
  if (Key=VK_F6) then
     begin
       rzGrid.Row := 1;
       rzGrid.Col := 2;
       DoDibs;
     end;
end;

procedure TfrmDibsOption.rzGridEnter(Sender: TObject);
begin
  inherited;
  edtPAY_FEE.SetFocus;
end;

procedure TfrmDibsOption.edtPAY_FEEKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
     begin
       if StrtoFloatDef(edtPAY_FEE.Text,0)=0 then Raise Exception.Create('请正确输入抹零金额...');
       if StrtoFloatDef(edtPAY_FEE.Text,0)>_TotalFee then Raise Exception.Create('抹零后金额不能大于原金额...');
       self.ModalResult := MROK;
     end;
end;

procedure TfrmDibsOption.DoDibs;
var r:integer;
begin
   if rzGrid.Row =0 then
      begin
        case  rzGrid.Col of
        0:r := 0;
        1:r := 1;
        2:r := 2;
        end;
      end
   else
      begin
        case  rzGrid.Col of
        0:r := -1;
        1:r := -2;
        2:r := -3;
        end;
      end;
  edtPAY_FEE.Text := floattostr(MyRoundTo(_TotalFee,r));
  edtPAY_FEE.SelectAll;
end;

end.
