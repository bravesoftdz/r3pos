unit ufrmReportForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebToolForm, ExtCtrls, RzPanel, StdCtrls, RzLabel, Grids,
  DBGridEh, RzButton, cxRadioGroup, RzBmpBtn, RzBorder, TeEngine, Series,
  TeeProcs, Chart, cxButtonEdit, zrComboBoxList, cxDropDownEdit,ZDataSet,
  cxCalendar, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  RzTabs, PrnDbgeh,DBGridEhImpExp;

type
  TfrmReportForm = class(TfrmWebToolForm)
    PageControl: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPanel11: TRzPanel;
    RzPanel13: TRzPanel;
    btnNav: TRzBitBtn;
    RzPanel12: TRzPanel;
    RzBmpButton1: TRzBmpButton;
    RzBmpButton3: TRzBmpButton;
    lblCaption: TRzLabel;
    RzBmpButton2: TRzBmpButton;
    RzBmpButton4: TRzBmpButton;
    SaveDialog1: TSaveDialog;
    PrintDBGridEh1: TPrintDBGridEh;
    procedure RzBmpButton1Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
  private
    { Private declarations }
  protected
    function CheckAccDate(BegDate, EndDate: integer): integer;
    function  FindColumn(grid:TDBGridEh;FieldName:string):TColumnEh;
    function FormatReportHead(TitleList: TStringList;Cols: integer): string;
    function FormatExportHead(TitleList: TStringList;Cols:integer):string;
    procedure DBGridPrint;virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation
uses udataFactory,utokenFactory,uCtrlUtil, ufrmDBGridPreview;
{$R *.dfm}

{ TfrmReportForm }

constructor TfrmReportForm.Create(AOwner: TComponent);
var
  i:integer;
begin
  inherited;
  for i:=0 to PageControl.PageCount - 1 do PageControl.Pages[i].TabVisible := false;
  PageControl.ActivePageIndex := 0;
  if assigned(PageControl.OnChange) then PageControl.OnChange(PageControl);
  TDbGridEhSort.InitForm(self);
end;

destructor TfrmReportForm.Destroy;
begin
  TDbGridEhSort.FreeForm(self); 
  inherited;
end;

//宽度: 80个字节 最后一列不加格式，尽量靠右对齐
function TfrmReportForm.FormatReportHead(TitleList: TStringList; Cols: integer): string;
var
  spaceStr,str1: string;
  i,j: integer;
begin
  //中间间隔4个空格:
  result:='';
  for i:=0 to TitleList.Count-1 do
  begin
    if i mod Cols=0 then
    begin
      j:=i;
      if j<=TitleList.Count-1 then str1:=trim(TitleList.Strings[j]);    //1
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //2
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //3
      inc(j);
      if j<=TitleList.Count-1 then str1:=str1+trim(TitleList.Strings[j]); //4
      case length(str1) of
        1.. 50:  spaceStr:='                         ';
        51..60:  spaceStr:='                  ';
        61..75:  spaceStr:='            ';
        76..90:  spaceStr:='      ';
        else     spaceStr:=' ';
      end;
    end;
    if result='' then result:=trim(TitleList.Strings[i])
    else
    begin
      if (i mod Cols=0) and (i>=Cols) then
        result:=result+#13+trim(TitleList.Strings[i])
      else
        result:=result+spaceStr+trim(TitleList.Strings[i]);
    end;
  end;
end;
function TfrmReportForm.CheckAccDate(BegDate, EndDate: integer): integer;
var
  rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text :='select max(CREA_DATE) as CREA_DATE from RCK_DAYS_CLOSE where TENANT_ID=:TENANT_ID and CREA_DATE>=:CREA_DATE ';
    rs.ParamByName('TENANT_ID').AsInteger :=  strtoInt(token.tenantId);
    if rs.Params.FindParam('CREA_DATE')<>nil then rs.ParamByName('CREA_DATE').AsInteger :=BegDate;
    dataFactory.Open(rs);
    if trim(rs.Fields[0].AsString)='' then
      result := BegDate-1
    else
      result := rs.Fields[0].AsInteger;
  finally
    rs.Free;
  end;
end;

function TfrmReportForm.FindColumn(grid: TDBGridEh;
  FieldName: string): TColumnEh;
var
  i:integer;
begin
  Result := nil;
  for i:=0 to grid.Columns.Count -1 do
    begin
      if UpperCase(grid.Columns[i].FieldName)=UpperCase(FieldName) then
         begin
           Result := grid.Columns[i];
           Exit;
         end;
    end;
end;

function TfrmReportForm.FormatExportHead(TitleList: TStringList;
  Cols: integer): string;
var
  curStr,Str:string;
  i:integer;
begin
  for i:=0 to TitleList.Count-1 do
  begin
    CurStr:=trim(TitleList.Strings[i]);
    if (i>0) and (i mod Cols=0) then  //4个条件换一行
      Str:=Str+#13+CurStr
    else
    begin
      if i=0 then
        Str:=CurStr
      else
        Str:=Str+'      '+CurStr;
    end;
  end;
  result := str;
end;

procedure TfrmReportForm.RzBmpButton1Click(Sender: TObject);
begin
  inherited;
  DBGridPrint;
  TfrmDBGridPreview.Print(self,PrintDBGridEh1);

end;

procedure TfrmReportForm.RzBmpButton3Click(Sender: TObject);
begin
  DBGridPrint;
  TfrmDBGridPreview.Preview(self,PrintDBGridEh1);

end;

procedure TfrmReportForm.DBGridPrint;
begin

end;

procedure TfrmReportForm.RzBmpButton2Click(Sender: TObject);
var Stream: TMemoryStream;
begin
  inherited;
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '已经存在，是否覆盖它？'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        exit;
      DeleteFile(SaveDialog1.FileName);
    end;
    DBGridPrint;
    Stream := TMemoryStream.Create;
    try
      Stream.Position := 0;
      if ExtractFileExt(SaveDialog1.FileName)='.xls' then
      begin
        with TDBGridEhExportAsXLS.Create do
        begin
          try
            DBGridEh := PrintDBGridEh1.DBGridEh;
            ExportToStream(Stream, True);
          finally
            Free;
          end;
        end;
      end
      else
      begin
        with TDBGridEhExportAsHTML.Create do
        begin
          try
            DBGridEh := PrintDBGridEh1.DBGridEh;
            ExportToStream(Stream, True);
          finally
            Free;
          end;
        end;
      end;
      Stream.SaveToFile(SaveDialog1.FileName);
    finally
      Stream.Free;
    end;
  end;
end;

end.
