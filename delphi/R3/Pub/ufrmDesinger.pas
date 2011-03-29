unit ufrmDesinger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ExtCtrls, RzPanel, Grids, RzGrids,
  StdCtrls, RzButton,DB,FR_Class, FR_Desgn,ZDataSet;

type
  TfrmDesigner = class(TfrmBasic)
    RzPanel1: TRzPanel;
    frfGrid: TRzStringGrid;
    Panel1: TPanel;
    Label1: TLabel;
    btnPrint: TRzBitBtn;
    btnPriview: TRzBitBtn;
    btnClose: TRzBitBtn;
    btnDesigner: TRzBitBtn;
    btnDefault: TRzBitBtn;
    frDesigner1: TfrDesigner;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnDesignerClick(Sender: TObject);
    procedure btnPriviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnDefaultClick(Sender: TObject);
    procedure frDesigner1SaveReport(Report: TfrReport;
      var ReportName: String; SaveAs: Boolean; var Saved: Boolean);
  private
    FDataSet: TZQuery;
    FfrReport: TfrReport;
    FForm: TfrmBasic;
    FIndex:Integer;
    procedure SetDataSet(const Value: TZQuery);
    procedure SetfrReport(const Value: TfrReport);
    procedure SetForm(const Value: TfrmBasic);
    procedure Designer(AfrReport: TfrReport; Index: Integer=-1);
    procedure SetDefault(AfrReport: TfrReport; Index: Integer=-1);
    { Private declarations }
  public

    { Public declarations }
    procedure LoadFastFile(frfFileName:string);

    function  ShowExecute(AOwner: TfrReport; Params: string = ''): boolean;
    property  DataSet:TZQuery read FDataSet write SetDataSet;
    property  frReport:TfrReport read FfrReport write SetfrReport;
    property  Form:TfrmBasic read FForm write SetForm;
  end;

implementation
uses ufrmFastReport, uGlobal;
{$R *.dfm}

{ TfrmDesigner }

procedure TfrmDesigner.Designer(AfrReport: TfrReport;Index:Integer=-1);
var
  Temp :TZQuery;
  sm:TMemoryStream;
  s:string;
begin
  if Index<=0 then s := '' else s:=Inttostr(Index);
  if FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+s+'.frf') then
  begin
     frReport.LoadFromFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+s+'.frf') ;
  end
  else
  begin
    temp := TZQuery.Create(nil);
    sm := TMemoryStream.Create;
    try
       Temp.SQL.Text := 'select * from SYS_FASTFILE where frfFileName=:frfFileName and TENANT_ID=:TENANT_ID';
       Temp.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
       Temp.ParamByName('frfFileName').AsString := frReport.Name;
       Factor.Open(Temp);
       if not Temp.IsEmpty then
       begin
         if Index<=0 then
            TBlobField(Temp.FieldByName('frfBlob')).SaveToStream(sm)
         else
            TBlobField(Temp.FieldByName('frfBlob'+inttostr(Index))).SaveToStream(sm);
         sm.Position := 0;
         frReport.LoadFromStream(sm);
       end;
       frReport.FileName := '';
    finally
       Temp.Free;
       sm.Free;
    end;
  end;
  frReport.DesignReport;
end;

procedure TfrmDesigner.SetDefault(AfrReport: TfrReport; Index: Integer);
begin
  Factor.ExecSQL('update SYS_FASTFILE set frfDefault='+Inttostr(Index)+' where frfFileName='''+AfrReport.Name+''' and TENANT_ID='+inttostr(Global.TENANT_ID));
end;
procedure TfrmDesigner.LoadFastFile(frfFileName: string);
begin
  DataSet.Close;
  DataSet.SQL.Text := 'select * from SYS_FASTFILE where frfFileName='''+frfFileName +''' and TENANT_ID='+inttostr(Global.TENANT_ID);
  Factor.Open(DataSet);
  frfGrid.Cells[0,0] := '标准样式';
  if DataSet.FieldByName('frfBlob1').IsNull then
     frfGrid.Cells[0,1] := '自定义一(不可用)'
  else
     frfGrid.Cells[0,1] := '自定义一';
  if DataSet.FieldByName('frfBlob2').IsNull then
     frfGrid.Cells[0,2] := '自定义二(不可用)'
  else
     frfGrid.Cells[0,2] := '自定义二';
  if DataSet.FieldByName('frfBlob3').IsNull then
     frfGrid.Cells[0,3] := '自定义三(不可用)'
  else
     frfGrid.Cells[0,3] := '自定义三';
  if DataSet.FieldByName('frfBlob4').IsNull then
     frfGrid.Cells[0,4] := '自定义四(不可用)'
  else
     frfGrid.Cells[0,4] := '自定义四';
  if DataSet.FieldByName('frfBlob5').IsNull then
     frfGrid.Cells[0,5] := '自定义五(不可用)'
  else
     frfGrid.Cells[0,5] := '自定义五';

  if DataSet.FieldByName('frfDefault').AsInteger >0 then
     begin
        Label1.Caption := '默认样式：'+frfGrid.Cells[0,DataSet.FieldByName('frfDefault').AsInteger];
     end
  else
     begin
        Label1.Caption := '默认样式：'+frfGrid.Cells[0,0]
     end;
//  if FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'.frf') then
//     begin
//       frReport.LoadFromFile(ExtractFilePath(ParamStr(0))+'frf\'+frfFileName+'.frf') ;
//       exit;
//     end;
end;

procedure TfrmDesigner.SetDataSet(const Value: TZQuery);
begin
  FDataSet := Value;
end;

procedure TfrmDesigner.FormCreate(Sender: TObject);
begin
  inherited;
  DataSet := TZQuery.Create(nil);
end;

procedure TfrmDesigner.FormDestroy(Sender: TObject);
begin
  DataSet.Free;
  inherited;

end;

function TfrmDesigner.ShowExecute(AOwner: TfrReport; Params: string): boolean;
begin
  frReport := AOwner;
  LoadFastFile(AOwner.Name);
  ShowModal;
end;

procedure TfrmDesigner.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDesigner.btnDesignerClick(Sender: TObject);
begin
  inherited;
  Designer(frReport,frfGrid.Selection.Top);
end;

procedure TfrmDesigner.SetfrReport(const Value: TfrReport);
begin
  FfrReport := Value;
end;

procedure TfrmDesigner.btnPriviewClick(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Form.actList.ActionCount -1 do
     begin
       if uppercase(Form.actList.Actions[i].Name) = uppercase('actPreview') then
          begin
            GlobalIndex := frfGrid.Selection.Top;
            Close;
            Form.actList.Actions[i].OnExecute(nil);
            Exit;
          end;
     end;

end;

procedure TfrmDesigner.SetForm(const Value: TfrmBasic);
begin
  FForm := Value;
  btnPrint.Enabled := (Value<>nil);
  btnPriview.Enabled := (Value<>nil);
end;

procedure TfrmDesigner.btnPrintClick(Sender: TObject);
var i:Integer;
begin
  for i:=0 to Form.actList.ActionCount -1 do
     begin
       if uppercase(Form.actList.Actions[i].Name) = uppercase('actPrint') then
          begin
            GlobalIndex := frfGrid.Selection.Top;
            Close;
            Form.actList.Actions[i].OnExecute(nil);
            Exit;
          end;
     end;
end;

procedure TfrmDesigner.btnDefaultClick(Sender: TObject);
begin
  inherited;
  SetDefault(frReport,frfGrid.Selection.Top);
  Label1.Caption := '默认样式：'+frfGrid.Cells[0,frfGrid.Selection.Top];

end;

procedure TfrmDesigner.frDesigner1SaveReport(Report: TfrReport;
  var ReportName: String; SaveAs: Boolean; var Saved: Boolean);
var
  Temp :TZQuery;
  sm:TMemoryStream;
  s:string;
begin
  if FIndex=0 then s := '' else s := inttostr(FIndex);
  ForceDirectories(ExtractFilePath(ParamStr(0))+'frf\');
  frReport.SaveToFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+s+'.frf');
  Saved := True;
  s := frfGrid.Cells[0,frfGrid.Selection.Top];
  if Copy(s,length(s)-7,8)='(不可用)' then
     frfGrid.Cells[0,frfGrid.Selection.Top] := Copy(s,1,length(s)-8);
end;

end.
