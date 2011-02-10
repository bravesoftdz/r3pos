unit ufrmFastReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, ComCtrls, ToolWin, ExtCtrls,ObjBase,
  FR_View, FR_Class, FR_DSet, FR_DBSet, DB,
  FR_E_RTF, FR_E_HTM, FR_E_TXT, FR_E_CSV,DbClient, FR_E_PDF, FR_Desgn,
  ZAbstractRODataset, ZDataset;
type
  TFilterEvent=procedure(Var SQL:string) of Object;
type
  TfrmFastReport = class(TfrmBasic)
    CoolBar1: TCoolBar;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton16: TToolButton;
    ToolButton6: TToolButton;
    ToolButton5: TToolButton;
    ToolButton7: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton9: TToolButton;
    actPrint: TAction;
    actExit: TAction;
    actPrintSetup: TAction;
    actPrior: TAction;
    actNext: TAction;
    actZoom: TAction;
    actOnePage: TAction;
    actPageWidth: TAction;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    frReport1: TfrReport;
    F1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    E1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    F2: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    frTable: TfrDBDataSet;
    frCSVExport1: TfrCSVExport;
    frHTMExport1: TfrHTMExport;
    frTextExport1: TfrTextExport;
    frRTFExport1: TfrRTFExport;
    PopupMenu1: TPopupMenu;
    HTML1: TMenuItem;
    CSV1: TMenuItem;
    N3: TMenuItem;
    RTF1: TMenuItem;
    SaveDialog1: TSaveDialog;
    PageControl1: TPageControl;
    tabPrev: TTabSheet;
    frPreview1: TfrPreview;
    ToolBar1: TToolBar;
    ToolButton8: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    PDF1: TMenuItem;
    frPDFExport1: TfrPDFExport;
    frDesigner1: TfrDesigner;
    ToolButton4: TToolButton;
    actFormer: TAction;
    adoTable: TZReadOnlyQuery;
    procedure actOnePageExecute(Sender: TObject);
    procedure actPageWidthExecute(Sender: TObject);
    procedure actZoomExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actPrintSetupExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure HTML1Click(Sender: TObject);
    procedure CSV1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure RTF1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PDF1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure frDesigner1SaveReport(Report: TfrReport;
      var ReportName: String; SaveAs: Boolean; var Saved: Boolean);
    procedure actFormerExecute(Sender: TObject);
    procedure frReport1UserFunction(const Name: String; p1, p2,
      p3: Variant; var Val: Variant);
  private
    FFilterRecord: TRecord_;
    FfrReport: TfrReport;
    FFilterText: string;
    FSelectSQL: string;
    FIsCanFilter: Boolean;
    FOnFilterEvent: TFilterEvent;
    FIsFree :Boolean;
    Desgn:boolean;
    procedure SetfrReport(const Value: TfrReport);
    procedure SetFilterText(const Value: string);
    procedure SetSelectSQL(const Value: string);
    procedure SetIsCanFilter(const Value: Boolean);
    procedure SetOnFilterEvent(const Value: TFilterEvent);
    { Private declarations }
  protected
    procedure OpenReport(SQL:string);
    procedure DoFormer;

    property frReport:TfrReport read FfrReport write SetfrReport;
    property FilterText:string read FFilterText write SetFilterText;
    property SelectSQL:string read FSelectSQL write SetSelectSQL;
    //设置Child方式显示时的窗体类型
    procedure SetChildDisplay(MainForm:TForm);
    procedure OpenFile(frReport:TfrReport;Index:Integer=-1);

  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;

    procedure LoaddbReport(frReport:TfrReport;Index:Integer=-1);
    function ShowReport(CommandText:string;AfrReport:TfrReport;AFilterRecord:TRecord_=nil;IsShowModal:Boolean=True): Boolean;overload;
    function PrintReport(CommandText:string;AfrReport:TfrReport): Boolean;overload;
    function ShowReport(CommandText:string;FileName:string;AFilterRecord:TRecord_=nil;IsShowModal:Boolean=True): Boolean;overload;
    function PrintReport(CommandText:string;FileName:string): Boolean;overload;

    procedure Preview(AfrReport:TfrReport);
    procedure Print(AfrReport:TfrReport);
    function ExportFile(CommandText:string;AfrReport:TfrReport;FileName:string):Boolean;

    property IsCanFilter:Boolean read FIsCanFilter write SetIsCanFilter;
    property OnFilterEvent:TFilterEvent read FOnFilterEvent write SetOnFilterEvent;
  end;
var GlobalIndex:Integer=-1;
    Language:Integer=0;
implementation
{$R *.dfm}
uses RzSplit,udmIcon,FR_PrDlg,ufrmSaveDesigner,ufrmSelectFormer,uGlobal;
{ TfrmFastReport }
var SaveIndex:Integer=-1;
procedure TfrmFastReport.DoFormer;
var
  s:string;
  Temp :TZQuery;
  sm:TFileStream;
  r:integer;
begin
  s := TfrmSelectFormer.SelectFormer(self,frReport.Name);
  if s='' then Exit;
  r := TfrmSaveDesigner.SaveDialog(self,frReport.Name);
  sm := TFileStream.Create(ExtractFilePath(ParamStr(0))+'frf\'+s,fmOpenRead);
  Temp := TZQuery.Create(nil);
  try
     Temp.SQL.Text := 'select * from REP_FASTFILE where frfFileName=:frfFileName and TENANT_ID=:TENANT_ID';
     Temp.ParamByName('frfFileName').AsString := frReport.Name;
     Temp.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     Factor.Open(Temp);
     Temp.Edit;
     Temp.FieldByName('frfFileName').AsString := frReport.Name;
     Temp.FieldByName('frfFileTitle').AsString := frReport.Name;
     sm.Position := 0;
     if r<0 then Exit;
     if r=0 then s := '' else s := inttostr(r);
     TBlobField(Temp.FieldByName('frfBlob'+s)).LoadFromStream(sm);
     Temp.Post;
     Factor.UpdateBatch(Temp);
     sm.Position := 0;
     frReport.LoadFromStream(sm);
     if r<=0 then
        frReport.SaveToFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+'.frf');
     SaveIndex := r;
  finally
     sm.Free;
     Temp.Free;
  end;
end;
function TfrmFastReport.PrintReport(CommandText: string;
  AfrReport: TfrReport): Boolean;
var
  Pages: String;
begin
  if AfrReport=nil then
     Raise Exception.Create('AfrReport参数没有Create');
  try
    FfrReport := AfrReport;
    OpenFile(AfrReport,GlobalIndex);
    frReport.Dataset := frTable;
    frReport.Preview := frPreview1;
    SelectSQL := CommandText;
    adoTable.Close;
    adoTable.SQL.Text := CommandText;
    Factor.Open(adoTable);
    if frReport.PrepareReport then
       begin
          if (frReport.EMFPages = nil) then Exit;
          with TfrPrintForm.Create(Application) do
          begin
            E1.Text := IntToStr(frReport.DefaultCopies);
            CollateCB.Checked := frReport.DefaultCollate;
            if not frReport.ShowPrintDialog or (ShowModal = mrOk) then
            begin
              if RB1.Checked then
                Pages := ''
              else if RB2.Checked then
                Pages := IntToStr(1)
              else
                Pages := E2.Text;
              //ConnectBack;
              frReport.PrintPreparedReport(Pages, StrToInt(E1.Text),
                CollateCB.Checked, TfrPrintPages(CB2.ItemIndex));
              //Connect(frReport);
              //RedrawAll(False);
            end;
            Free;
          end;
         //frReport.PrintPreparedReport('', 1, True, frAll);
       end;
  except
    on E:Exception do
      begin
         Raise Exception.Create('生成报表出错:'+E.Message);
      end;
  end;
end;

function TfrmFastReport.ShowReport(CommandText: string;
  AfrReport: TfrReport; AFilterRecord: TRecord_=nil;IsShowModal:Boolean=True): Boolean;
begin
  if AfrReport=nil then
     Raise Exception.Create('AfrReport参数没有Create');
  try
    FfrReport := AfrReport;
    OpenFile(AfrReport,GlobalIndex);
    frReport.Dataset := frTable;
    frReport.Preview := frPreview1;
    SelectSQL := CommandText;
    OpenReport(CommandText);
    if IsShowModal or (Application.MainForm.FormStyle <> fsMDIForm) then
       begin
         Visible := false;
         ShowModal;
       end
    else
       SetChildDisplay(Application.MainForm);
  except
    on E:Exception do
      begin
         Raise Exception.Create('生成报表出错:'+E.Message);
      end;
  end;
end;

procedure TfrmFastReport.actOnePageExecute(Sender: TObject);
begin
  frPreview1.OnePage;
  
end;

procedure TfrmFastReport.actPageWidthExecute(Sender: TObject);
begin
  frPreview1.PageWidth;

end;

procedure TfrmFastReport.actZoomExecute(Sender: TObject);
begin
  frPreview1.Zoom := 100;

end;

procedure TfrmFastReport.actNextExecute(Sender: TObject);
begin
  frPreview1.Next;

end;

procedure TfrmFastReport.actPriorExecute(Sender: TObject);
begin
  frPreview1.Prev;

end;

procedure TfrmFastReport.actPrintSetupExecute(Sender: TObject);
var
  i:Integer;
  Temp :TZQuery;
  sm:TMemoryStream;
  s:string;
begin
  if frReport=nil then Exit;
  Desgn := true;
  try
  if FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+'.frf') and (SaveIndex<=0) then
     begin
       frReport.LoadFromFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+'.frf') ;
     end
  else
  begin
  temp := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  try
     Temp.SQL.Text := 'select * from REP_FASTFILE where frfFileName=:frfFileName and TENANT_ID=:TENANT_ID';
     Temp.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     Temp.ParamByName('frfFileName').AsString := frReport.Name;
     Factor.Open(Temp);
     if not Temp.IsEmpty then
     begin
       if SaveIndex<=0 then
          TBlobField(Temp.FieldByName('frfBlob')).SaveToStream(sm)
       else
          TBlobField(Temp.FieldByName('frfBlob'+inttostr(SaveIndex))).SaveToStream(sm);
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
  frReport.PrepareReport;
  frReport.ShowPreparedReport;
  finally
    Desgn := false;
  end;
end;

constructor TfrmFastReport.Create(AOwner: TComponent);
begin
  inherited;
  frReport := frReport1;
  IsCanFilter := true;
  OnFilterEvent := nil;
  Desgn := false;
end;

destructor TfrmFastReport.Destroy;
begin

  inherited;
end;

function TfrmFastReport.PrintReport(CommandText, FileName: string): Boolean;
var
  Pages: String;
begin
  try
    frReport := frReport1;
    if not FileExists(FileName) then
       Raise Exception.Create(FileName+'文件没找到。');
    frReport.LoadFromFile(FileName);
    frReport.Dataset := frTable;
    frReport.Preview := frPreview1;
    SelectSQL := CommandText;
    adoTable.Close;
    adoTable.SQL.Text := CommandText;
    Factor.Open(adoTable);
    if frReport.PrepareReport then
       begin
          if (frReport.EMFPages = nil) then Exit;
          with TfrPrintForm.Create(Application) do
          begin
            E1.Text := IntToStr(frReport.DefaultCopies);
            CollateCB.Checked := frReport.DefaultCollate;
            if not frReport.ShowPrintDialog or (ShowModal = mrOk) then
            begin
              if RB1.Checked then
                Pages := ''
              else if RB2.Checked then
                Pages := IntToStr(1)
              else
                Pages := E2.Text;
              //ConnectBack;
              frReport.PrintPreparedReport(Pages, StrToInt(E1.Text),
                CollateCB.Checked, TfrPrintPages(CB2.ItemIndex));
              //Connect(frReport);
              //RedrawAll(False);
            end;
            Free;
          end;
         //frReport.PrintPreparedReport('', 1, True, frAll);
       end;
  except
    on E:Exception do
      begin
         Raise Exception.Create('生成报表出错:'+E.Message);
      end;
  end;
end;

procedure TfrmFastReport.SetfrReport(const Value: TfrReport);
begin
  FfrReport := Value;
end;

function TfrmFastReport.ShowReport(CommandText, FileName: string;
  AFilterRecord: TRecord_=nil;IsShowModal:Boolean=True): Boolean;
begin
  try
    frReport := frReport1;
    if not FileExists(FileName) then
       Raise Exception.Create(FileName+'文件没找到。');
    frReport.LoadFromFile(FileName);
    frReport.Dataset := frTable;
    frReport.Preview := frPreview1;
    SelectSQL := CommandText;
    OpenReport(CommandText);
    if IsShowModal or (Application.MainForm.FormStyle <> fsMDIForm) then
       begin
         Visible := false;
         ShowModal;
       end
    else
       SetChildDisplay(Application.MainForm);
  except
    on E:Exception do
      begin
         Raise Exception.Create('生成报表出错:'+E.Message);
      end;
  end;
end;

procedure TfrmFastReport.actExitExecute(Sender: TObject);
begin
  close;
end;

procedure TfrmFastReport.actPrintExecute(Sender: TObject);
begin
  frPreview1.Print;

end;

procedure TfrmFastReport.SetFilterText(const Value: string);
begin
  FFilterText := Value;
end;

procedure TfrmFastReport.SetSelectSQL(const Value: string);
begin
  FSelectSQL := Value;
end;

procedure TfrmFastReport.SetIsCanFilter(const Value: Boolean);
begin
  FIsCanFilter := Value;
end;

procedure TfrmFastReport.SetOnFilterEvent(const Value: TFilterEvent);
begin
  FOnFilterEvent := Value;
end;

procedure TfrmFastReport.OpenReport(SQL: string);
begin
  adoTable.Close;
  adoTable.SQL.Text := SQL;
  Factor.Open(adoTable);
  frReport.ShowReport;
end;

procedure TfrmFastReport.HTML1Click(Sender: TObject);
begin
  SaveDialog1.DefaultExt := '*.htm';
  SaveDialog1.Filter := '超文本格式|*.htm';
  if SaveDialog1.Execute then
     begin
       if FileExists(SaveDialog1.FileName) then
          begin
            if MessageBox(Handle,Pchar(SaveDialog1.FileName+'文件已经存在，是否覆盖它？'),PChar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            if not DeleteFile(SaveDialog1.FileName) then
               Raise Exception.CreateFmt('%s文件可能被其他用使用，无法覆盖。',[SaveDialog1.FileName]);
          end;
       frReport.ExportTo(frHTMExport1,SaveDialog1.FileName);
     end;
end;

procedure TfrmFastReport.CSV1Click(Sender: TObject);
begin
  SaveDialog1.DefaultExt := '*.csv';
  SaveDialog1.Filter := 'Excel格式|*.csv';
  if SaveDialog1.Execute then
     begin
       if FileExists(SaveDialog1.FileName) then
          begin
            if MessageBox(Handle,Pchar(SaveDialog1.FileName+'文件已经存在，是否覆盖它？'),PChar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            if not DeleteFile(SaveDialog1.FileName) then
               Raise Exception.CreateFmt('%s文件可能被其他用使用，无法覆盖。',[SaveDialog1.FileName]);
          end;
       frReport.ExportTo(frCSVExport1,SaveDialog1.FileName);
     end;

end;

procedure TfrmFastReport.N3Click(Sender: TObject);
begin
  SaveDialog1.DefaultExt := '*.txt';
  SaveDialog1.Filter := '纯文本格式|*.txt';
  if SaveDialog1.Execute then
     begin
       if FileExists(SaveDialog1.FileName) then
          begin
            if MessageBox(Handle,Pchar(SaveDialog1.FileName+'文件已经存在，是否覆盖它？'),PChar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            if not DeleteFile(SaveDialog1.FileName) then
               Raise Exception.CreateFmt('%s文件可能被其他用使用，无法覆盖。',[SaveDialog1.FileName]);
          end;
       frReport.ExportTo(frTextExport1,SaveDialog1.FileName);
     end;
end;

procedure TfrmFastReport.RTF1Click(Sender: TObject);
begin
  SaveDialog1.DefaultExt := '*.rtf';
  SaveDialog1.Filter := 'Word格式|*.rtf';
  if SaveDialog1.Execute then
     begin
       if FileExists(SaveDialog1.FileName) then
          begin
            if MessageBox(Handle,Pchar(SaveDialog1.FileName+'文件已经存在，是否覆盖它？'),PChar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            if not DeleteFile(SaveDialog1.FileName) then
               Raise Exception.CreateFmt('%s文件可能被其他用使用，无法覆盖。',[SaveDialog1.FileName]);
          end;
       frReport.ExportTo(frRTFExport1,SaveDialog1.FileName);
     end;
end;

procedure TfrmFastReport.Preview(AfrReport: TfrReport);
begin
  try
    frReport := AfrReport;
    FFilterRecord := nil;
    OpenFile(frReport,GlobalIndex);
    frReport.Preview := frPreview1;
    frReport.ShowReport;
    ShowModal;
  except
    on E:Exception do
      begin
         Raise Exception.Create('预览报表出错:'+E.Message);
      end;
  end;
end;

procedure TfrmFastReport.SetChildDisplay(MainForm: TForm);
  procedure SetTools;
    var Tmp:TComponent;
        i:Integer;
    begin
      Tmp := nil;
      for i:= 0 to MainForm.ComponentCount -1 do
        begin
          if UpperCase(MainForm.Components[i].Name)='RZPANEL' then
             begin
               Tmp := MainForm.Components[i];
               Break;
             end;
        end;
      if Tmp<>nil then
         TrzSizePanel(Tmp).CloseHotSpot;
    end;
var
  wRect: TRect;
begin
  BorderIcons :=  [];
  BorderStyle := bsNone;
  FormStyle := fsMDIChild;
  GetWindowRect(MainForm.ClientHandle, wRect);
//  SetBounds(0, 0, Width, Height);
  if Width > (wRect.Right - wRect.Left-2) then
     SetTools;
  WindowState := wsMaximized;
//  SetBounds(0, 0, wRect.Right - wRect.Left-2, wRect.Bottom -
//     wRect.Top-2);
  FIsFree := True;
end;

procedure TfrmFastReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if FIsFree then Action := caFree;

end;

procedure TfrmFastReport.OpenFile(frReport: TfrReport;Index:Integer=-1);
var Temp :TClientDataSet;
    sm:TStream;
    s:string;
    Field:TField;
begin
  if Index<=0 then s := '' else s:=Inttostr(Index);
  if FileExists(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+'.frf') and (Index<=0) then
     begin
       frReport.LoadFromFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+'.frf') ;
       exit;
     end;
  Temp := TClientDataSet.Create(nil);
  sm := TMemoryStream.Create;
  try
     Temp.CommandText := 'select * from REP_FASTFILE where frfFileName='''+frReport.Name +'''';
     Factor.Open(Temp);
     if Temp.IsEmpty and frReport.StoreInDFM then
        begin
           frReport.SaveToStream(sm);
           Temp.Append;
           Temp.FieldByName('frfFileName').AsString := frReport.Name;
           Temp.FieldByName('frfFileTitle').AsString := frReport.Name;
           sm.Position := 0;
           TBlobField(Temp.FieldByName('frfBlob'+s)).LoadFromStream(sm);
           Temp.Post;
           Factor.UpdateBatch(Temp);
        end
     else
        begin
           if (Index=-1) then
              begin
                Field := Temp.FindField('frfDefault');
                if (Field<>nil) and (Field.AsInteger >0) then
                   s := Inttostr(Field.AsInteger)
                else
                   s := '';
              end;
           if not Temp.FieldByName('frfBlob'+s).IsNull then
           begin
           TBlobField(Temp.FieldByName('frfBlob'+s)).SaveToStream(sm);
           sm.Position := 0;
           frReport.LoadFromStream(sm);
           end;
        end;
  finally
     Temp.Free;
     sm.Free;
     SaveIndex := GlobalIndex;
     GlobalIndex := -1;
  end;
end;


procedure TfrmFastReport.Print(AfrReport: TfrReport);
var
  Pages: String;
begin
  try
    frReport := AfrReport;
    FFilterRecord := nil;
    frReport.Preview := frPreview1;
    OpenFile(frReport,GlobalIndex);
    if frReport.PrepareReport then
       begin
          if (frReport.EMFPages = nil) then Exit;
          with TfrPrintForm.Create(Application) do
          begin
            E1.Text := IntToStr(frReport.DefaultCopies);
            CollateCB.Checked := frReport.DefaultCollate;
            if not frReport.ShowPrintDialog or (ShowModal = mrOk) then
            begin
              if RB1.Checked then
                Pages := ''
              else if RB2.Checked then
                Pages := IntToStr(1)
              else
                Pages := E2.Text;
              //ConnectBack;
              frReport.PrintPreparedReport(Pages, StrToInt(E1.Text),
                CollateCB.Checked, TfrPrintPages(CB2.ItemIndex));
              //Connect(frReport);
              //RedrawAll(False);
            end;
            Free;
          end;
         //frReport.PrintPreparedReport('', 1, True, frAll);
       end;
  except
    on E:Exception do
      begin
         Raise Exception.Create('预览报表出错:'+E.Message);
      end;
  end;
end;

procedure TfrmFastReport.LoaddbReport(frReport: TfrReport; Index: Integer);
begin
  OpenFile(frReport,Index);
end;

function TfrmFastReport.ExportFile(CommandText: string;
  AfrReport: TfrReport; FileName: string): Boolean;
var Ext:string;
begin
  if AfrReport=nil then
     Raise Exception.Create('AfrReport参数没有Create');
  try
    FfrReport := AfrReport;
    OpenFile(AfrReport,GlobalIndex);
    frReport.Dataset := frTable;
    frReport.Preview := frPreview1;
    SelectSQL := CommandText;
    adoTable.Close;
    adoTable.SQL.Text := CommandText;
    Factor.Open(adoTable);
  if frReport.PrepareReport then
     begin
       Ext := uppercase(ExtractFileExt(FileName));
       if Ext='.PDF' then
          frReport.ExportTo(frPDFExport1,FileName);
     end;
  except
    on E:Exception do
      begin
         Raise Exception.Create('生成报表出错:'+E.Message);
      end;
  end;
end;

procedure TfrmFastReport.PDF1Click(Sender: TObject);
begin
  inherited;
  SaveDialog1.DefaultExt := '*.pdf';
  SaveDialog1.Filter := 'PDF文件|*.pdf';
  if SaveDialog1.Execute then
     begin
       if FileExists(SaveDialog1.FileName) then
          begin
            if MessageBox(Handle,Pchar(SaveDialog1.FileName+'文件已经存在，是否覆盖它？'),PChar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            if not DeleteFile(SaveDialog1.FileName) then
               Raise Exception.CreateFmt('%s文件可能被其他用使用，无法覆盖。',[SaveDialog1.FileName]);
          end;
       frReport.ExportTo(frPDFExport1,SaveDialog1.FileName);
     end;
end;

procedure TfrmFastReport.FormActivate(Sender: TObject);
begin
  inherited;
  if FormStyle = fsMDIChild then
     WindowState := wsMaximized;
end;

procedure TfrmFastReport.frDesigner1SaveReport(Report: TfrReport;
  var ReportName: String; SaveAs: Boolean; var Saved: Boolean);
var
  Temp :TZQuery;
  sm:TMemoryStream;
  s:string;
  r:integer;
begin
  if frReport=nil then Exit;
  if not Desgn then Exit;
  if SaveAs then
     begin
      SaveDialog1.DefaultExt := '*.frf';
      SaveDialog1.Filter := '报表模版|*.frf';
      if SaveDialog1.Execute then
         begin
           if FileExists(SaveDialog1.FileName) then
              begin
                if MessageBox(Handle,Pchar(SaveDialog1.FileName+'文件已经存在，是否覆盖它？'),PChar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
                if not DeleteFile(SaveDialog1.FileName) then
                   Raise Exception.CreateFmt('%s文件可能被其他用使用，无法覆盖。',[SaveDialog1.FileName]);
              end;
           frReport.SaveToFile(SaveDialog1.FileName);
         end;
       Exit;
     end;
  r := TfrmSaveDesigner.SaveDialog(self,frReport.Name);
  if r<0 then Exit;
  if r=0 then s := '' else s := inttostr(r);
  Temp := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  try
     Temp.SQL.Text := 'select * from REP_FASTFILE where frfFileName=:frfFileName and TENANT_ID=:TENANT_ID';
     Temp.ParamByName('frfFileName').AsString := frReport.Name;
     Temp.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
     Factor.Open(Temp);
     sm.Clear;
     frReport.SaveToStream(sm);
     Temp.Edit;
     Temp.FieldByName('frfFileName').AsString := frReport.Name;
     Temp.FieldByName('frfFileTitle').AsString := frReport.Name;
     sm.Position := 0;
     TBlobField(Temp.FieldByName('frfBlob'+s)).LoadFromStream(sm);
     Temp.Post;
     Factor.UpdateBatch(Temp);
     if r=0 then
     begin
       ForceDirectories(ExtractFilePath(ParamStr(0))+'frf\');
       frReport.SaveToFile(ExtractFilePath(ParamStr(0))+'frf\'+frReport.Name+'.frf');
     end;
     SaveIndex := r;
  finally
     sm.Free;
     Temp.Free;
  end;
  Saved := True;
end;

procedure TfrmFastReport.actFormerExecute(Sender: TObject);
begin
  inherited;
  Desgn := true;
  try
  DoFormer;
  frReport.PrepareReport;
  frReport.ShowPreparedReport;
  finally
    Desgn := false;
  end;
end;

procedure TfrmFastReport.frReport1UserFunction(const Name: String; p1, p2,
  p3: Variant; var Val: Variant);
begin
  inherited;
  if Name='next' then adoTable.Next;
end;

end.
