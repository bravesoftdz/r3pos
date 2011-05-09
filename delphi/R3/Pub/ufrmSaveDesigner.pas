unit ufrmSaveDesigner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, RzGrids, RzPanel,ZDataSet, RzButton;

type
  TfrmSaveDesigner = class(TForm)
    RzPanel1: TRzPanel;
    frfGrid: TRzStringGrid;
    btnPrint: TRzBitBtn;
    btnPriview: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    procedure btnPrintClick(Sender: TObject);
    procedure btnPriviewClick(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
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
uses uGlobal,IniFiles;
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
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frf\frfFile.cfg');
  try
    F.WriteString('s1','name',frfGrid.Cells[0,1]);
    F.WriteString('s2','name',frfGrid.Cells[0,2]);
    F.WriteString('s3','name',frfGrid.Cells[0,3]);
    F.WriteString('s4','name',frfGrid.Cells[0,4]);
    F.WriteString('s5','name',frfGrid.Cells[0,5]);
  finally
    F.Free;
  end;
  self.ModalResult := MROK;
end;

procedure TfrmSaveDesigner.btnPriviewClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSaveDesigner.Load;
var
  F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frf\frfFile.cfg');
  try
  frfGrid.Cells[0,0] := '默认表样';
  if not FileExists(ExtractFilePath(ParamStr(0))+frfFileName+'1.frf') then
     frfGrid.Cells[0,1] := '自定义一(空置)'
  else
     frfGrid.Cells[0,1] := F.ReadString('s1','name','自定义一');
  if not FileExists(ExtractFilePath(ParamStr(0))+frfFileName+'2.frf') then
     frfGrid.Cells[0,2] := '自定义二(空置)'
  else
     frfGrid.Cells[0,2] := F.ReadString('s2','name','自定义二');
  if not FileExists(ExtractFilePath(ParamStr(0))+frfFileName+'3.frf') then
     frfGrid.Cells[0,3] := '自定义三(空置)'
  else
     frfGrid.Cells[0,3] := F.ReadString('s3','name','自定义三');
  if not FileExists(ExtractFilePath(ParamStr(0))+frfFileName+'4.frf') then
     frfGrid.Cells[0,4] := '自定义四(空置)'
  else
     frfGrid.Cells[0,4] := F.ReadString('s4','name','自定义四');
  if not FileExists(ExtractFilePath(ParamStr(0))+frfFileName+'5.frf') then
     frfGrid.Cells[0,5] := '自定义五(空置)'
  else
     frfGrid.Cells[0,5] := F.ReadString('s5','name','自定义五');
  finally
    F.Free;
  end;
end;

procedure TfrmSaveDesigner.RzBitBtn1Click(Sender: TObject);
var
  s:string;
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
     if InputQuery('模版管理','请输入模版名称：',s) then
     begin
       rs.Close;
       rs.SQL.Text := 'select * from SYS_FASTFILE where TENANT_ID='+inttostr(Global.TENANT_ID)+' and frfFileName like '''+frfFileName+'%'' and frfFileTitle='''+s+'''';
       Factor.Open(rs);
       if rs.IsEmpty then
          begin
            rs.Append;
            rs.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            rs.FieldByName('frfFileName').AsString :=
          end
       else
          rs.Edit;
     end;
  finally
    rs.Free;
  end;
end;

end.
