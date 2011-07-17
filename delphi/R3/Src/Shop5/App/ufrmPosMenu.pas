unit ufrmPosMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, Grids, RzGrids;

type
  TfrmPosMenu = class(TfrmBasic)
    RzPanel1: TRzPanel;
    Panel1: TPanel;
    rgMenu: TRzStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure rgMenuKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmPosMenu.CreateMenu;
const w=10;
function space(n:integer):string;
var i:integer;
begin
  for i:=1 to n do result := result + ' ';
end;
begin
  rgMenu.Cells[0,0] := space(10)+ '0.交班结账';
  rgMenu.Cells[0,1] := space(10)+ '1.窗口最小化';
  rgMenu.Cells[0,2] := space(10)+ '2.入会';
  rgMenu.Cells[0,3] := space(10)+ '3.发卡';
  rgMenu.Cells[0,4] := space(10)+ '4.充值';
  rgMenu.Cells[0,5] := space(10)+ '5.退款';
  rgMenu.Cells[0,6] := space(10)+ '6.挂失';
  rgMenu.Cells[0,7] := space(10)+ '7.密码修改';
  rgMenu.Cells[0,8] := space(10)+ '8.挂单';
  rgMenu.Cells[0,9] := space(10)+ '9.取单';
end;

procedure TfrmPosMenu.FormCreate(Sender: TObject);
begin
  inherited;
  CreateMenu;
end;

class function TfrmPosMenu.ShowMenu(Owner: TForm): integer;
begin
  with TfrmPosMenu.Create(Owner) do
    begin
      if ShowModal=MROK then
         begin
           result := rgMenu.Row; 
         end
      else
         result := 9999999;
    end;
end;

procedure TfrmPosMenu.rgMenuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key in ['0'..'9',#13] then
     begin
       if Key in ['0'..'9'] then rgMenu.Row := StrtoInt(Key);
       ModalResult := MROK;
     end;
end;

end.
