unit ufrmSaveDesigner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, RzGrids, RzPanel,ADODB, RzButton;

type
  TfrmSaveDesigner = class(TForm)
    RzPanel1: TRzPanel;
    frfGrid: TRzStringGrid;
    btnPrint: TRzBitBtn;
    btnPriview: TRzBitBtn;
    procedure btnPrintClick(Sender: TObject);
    procedure btnPriviewClick(Sender: TObject);
  private
    FfrfFileName: string;
    procedure SetfrfFileName(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    procedure Load;
    property frfFileName:string read FfrfFileName write SetfrfFileName;
    class function SaveDialog(Owner:TForm;fname:string):integer;
  end;
implementation
uses uGlobal;
{$R *.dfm}

class function TfrmSaveDesigner.SaveDialog(Owner: TForm;
  fname: string): integer;
begin
  with TfrmSaveDesigner.Create(Owner) do
    begin
      try
        frfFileName := fname;
        Load;
        if ShowModal=MROK then
           begin
             result := frfGrid.Selection.Top;
           end
        else
           result := -1;
      finally
        free;
      end;
    end;
end;

procedure TfrmSaveDesigner.SetfrfFileName(const Value: string);
begin
  FfrfFileName := Value;
end;

procedure TfrmSaveDesigner.btnPrintClick(Sender: TObject);
begin
  self.ModalResult := MROK;
end;

procedure TfrmSaveDesigner.btnPriviewClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSaveDesigner.Load;
var rs:TADODataSet;
begin
  rs := TADODataSet.Create(nil);
  try
  rs.Close;
  rs.CommandText := 'select * from REP_FASTFILE where frfFileName='''+frfFileName +'''';
  Factor.Open(rs);
  if rs.FieldByName('frfBlob').IsNull then
     frfGrid.Cells[0,0] := '默认表样(空置)'
  else
     frfGrid.Cells[0,0] := '默认表样';
  if rs.FieldByName('frfBlob1').IsNull then
     frfGrid.Cells[0,1] := '自定义一(空置)'
  else
     frfGrid.Cells[0,1] := '自定义一';
  if rs.FieldByName('frfBlob2').IsNull then
     frfGrid.Cells[0,2] := '自定义二(空置)'
  else
     frfGrid.Cells[0,2] := '自定义二';
  if rs.FieldByName('frfBlob3').IsNull then
     frfGrid.Cells[0,3] := '自定义三(空置)'
  else
     frfGrid.Cells[0,3] := '自定义三';
  if rs.FieldByName('frfBlob4').IsNull then
     frfGrid.Cells[0,4] := '自定义四(空置)'
  else
     frfGrid.Cells[0,4] := '自定义四';
  if rs.FieldByName('frfBlob5').IsNull then
     frfGrid.Cells[0,5] := '自定义五(空置)'
  else
     frfGrid.Cells[0,5] := '自定义五';
  finally
    rs.Free;
  end;
end;

end.
