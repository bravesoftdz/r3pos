unit ufrmSaveDesigner;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, FR_Class, RzGrids, RzPanel,DB,ZDataSet, RzButton;

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
    MyfrReport:TfrReport;
    procedure SetfrfFileName(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    procedure Load;
    property frfFileName:string read FfrfFileName write SetfrfFileName;
    class function SaveDialog(Owner:TForm;fname:string;frReport:TfrReport):integer;
  end;
implementation
uses uGlobal,IniFiles,uDsUtil;
{$R *.dfm}

class function TfrmSaveDesigner.SaveDialog(Owner: TForm;
  fname: string;frReport:TfrReport): integer;
begin
  with TfrmSaveDesigner.Create(Owner) do
    begin
      try
        frfFileName := fname;
        MyfrReport := frReport;
        RzBitBtn1.Visible := (frReport<>nil);
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
  s:string;
begin
  if frfGrid.Selection.Top>1 then
     begin
       s := frfGrid.Cells[0,frfGrid.Selection.Top];
       if InputQuery('打印表样...','请输入单据表样名称:',s) then
          begin
             frfGrid.Cells[0,frfGrid.Selection.Top] := s;
          end;
     end;
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'frf\frfFile.cfg');
  try
    if (pos('自定义',frfGrid.Cells[0,1])=0) then
       F.WriteString('s1_'+frfFileName,'name',frfGrid.Cells[0,1]);
    if (pos('自定义',frfGrid.Cells[0,2])=0) then
       F.WriteString('s2_'+frfFileName,'name',frfGrid.Cells[0,2]);
    if (pos('自定义',frfGrid.Cells[0,3])=0) then
       F.WriteString('s3_'+frfFileName,'name',frfGrid.Cells[0,3]);
    if (pos('自定义',frfGrid.Cells[0,4])=0) then
       F.WriteString('s4_'+frfFileName,'name',frfGrid.Cells[0,4]);
    if (pos('自定义',frfGrid.Cells[0,5])=0) then
       F.WriteString('s5_'+frfFileName,'name',frfGrid.Cells[0,5]);
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
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'1.frf') then
     frfGrid.Cells[0,1] := '自定义一(空置)'
  else
     frfGrid.Cells[0,1] := F.ReadString('s1_'+frfFileName,'name','自定义一');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'2.frf') then
     frfGrid.Cells[0,2] := '自定义二(空置)'
  else
     frfGrid.Cells[0,2] := F.ReadString('s2_'+frfFileName,'name','自定义二');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'3.frf') then
     frfGrid.Cells[0,3] := '自定义三(空置)'
  else
     frfGrid.Cells[0,3] := F.ReadString('s3_'+frfFileName,'name','自定义三');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'4.frf') then
     frfGrid.Cells[0,4] := '自定义四(空置)'
  else
     frfGrid.Cells[0,4] := F.ReadString('s4_'+frfFileName,'name','自定义四');
  if not FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'5.frf') then
     frfGrid.Cells[0,5] := '自定义五(空置)'
  else
     frfGrid.Cells[0,5] := F.ReadString('s5_'+frfFileName,'name','自定义五');
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
       Global.RemoteFactory.Open(rs);
       if rs.IsEmpty then
          begin
            rs.Append;
            rs.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            rs.FieldByName('frfFileName').AsString := TSequence.GetMaxID(frfFileName,Global.RemoteFactory,'frfFileName','SYS_FASTFILE','0000','TENANT_ID='+inttostr(Global.TENANT_ID));
          end
       else
          rs.Edit;
       rs.FieldByName('frfFileTitle').AsString := s;
       rs.FieldByName('frfDefault').AsInteger := 0;
       MyfrReport.SaveToBlobField(TBlobField(rs.FieldByName('frfBlob')));
       rs.Post;
       Global.RemoteFactory.UpdateBatch(rs,'TSysFastFile');
       MessageBox(Handle,'保存模版成功..','友情提示..',MB_OK+MB_ICONINFORMATION);
     end;
  finally
    rs.Free;
  end;
end;

end.
