unit ufrmSalRetuMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, Grids, RzGrids;

type
  TfrmSalRetuMenu = class(TfrmBasic)
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    rgMenu: TRzStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure rgMenuKeyPress(Sender: TObject; var Key: Char);
    procedure rgMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateMenu;
    class function ShowMenu(Owner:TForm):integer;
  end;
implementation

{$R *.dfm}

{ TfrmPosMenu }

procedure TfrmSalRetuMenu.CreateMenu;
const w=10;
 function space(n:integer):string;
 var i:integer;
 begin
   for i:=1 to n do result := result + ' ';
 end;
begin
  rgMenu.Cells[0,0] := space(4)+ '0.单笔退货';
  rgMenu.Cells[0,1] := space(4)+ '1.整单退货';
end;

procedure TfrmSalRetuMenu.FormCreate(Sender: TObject);
begin
  inherited;
  CreateMenu;
end;

class function TfrmSalRetuMenu.ShowMenu(Owner: TForm): integer;
begin
  with TfrmSalRetuMenu.Create(Owner) do
    begin
      if ShowModal=MROK then
         begin
           result := rgMenu.Row; 
         end
      else
         result := 9999999;
    end;
end;

procedure TfrmSalRetuMenu.rgMenuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key in ['0'..'9',#13] then
     begin
       if Key in ['0'..'9'] then rgMenu.Row := StrtoInt(Key);
       ModalResult := MROK;
     end;
end;

procedure TfrmSalRetuMenu.rgMenuMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ModalResult := mrOk;

end;

end.
