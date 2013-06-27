unit ufrmExcelFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzTabs, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzButton, DB, ZBase,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, udataFactory, cxMaskEdit,
  cxButtonEdit, zrComboBoxList, cxCheckBox, cxMemo, cxDropDownEdit,
  cxRadioGroup, cxSpinEdit, cxCalendar, RzLabel, Buttons, pngimage,
  RzBckgnd, RzBorder, RzBmpBtn, Math, msxml, ufrmWebDialog, jpeg, RzForms,
  Grids, DBGridEh, RzEdit, RzStatus,ComObj,IniFiles,DBGridEhImpExp, Menus;

type
  TfrmExcelFactory = class(TfrmWebDialog)
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    rzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzBackground1: TRzBackground;
    RzLabel2: TRzLabel;
    TabSheet2: TRzTabSheet;
    RzBackground2: TRzBackground;
    TabSheet3: TRzTabSheet;
    RzBackground3: TRzBackground;
    RzPanel4: TRzPanel;
    btnNext: TRzBmpButton;
    btnPrev: TRzBmpButton;
    cdsGoodsPrice: TZQuery;
    cdsGoodsInfo: TZQuery;
    cdsGoodsRelation: TZQuery;
    cdsBarCode: TZQuery;
    edtTable: TZQuery;
    RzLabel26: TRzLabel;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    RzBackground6: TRzBackground;
    RzBackground7: TRzBackground;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    RzLabel6: TRzLabel;
    OpenDialog1: TOpenDialog;
    dsExcel: TDataSource;
    cdsColumn: TZQuery;
    dsColumn: TDataSource;
    RzPanel8: TRzPanel;
    DBGridEh1: TDBGridEh;
    RzPanel9: TRzPanel;
    RzPanel10: TRzPanel;
    RzPanel11: TRzPanel;
    DBGridEh2: TDBGridEh;
    cdsDropColumn: TcxComboBox;
    TabSheet6: TRzTabSheet;
    RzPanel6: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel9: TRzLabel;
    RzLabel10: TRzLabel;
    RzLabel12: TRzLabel;
    DBGridEh3: TDBGridEh;
    cdsExcel: TZQuery;
    RzStatus1: TRzStatusPane;
    RzStatus2: TRzStatusPane;
    SaveDialog1: TSaveDialog;
    chkignore: TcxCheckBox;
    btnExport: TRzBmpButton;
    RzPanel12: TRzPanel;
    edtBK_Input: TRzPanel;
    RzPanel24: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel11: TRzLabel;
    edtFileName: TcxButtonEdit;
    RzPanel5: TRzPanel;
    RzLabel8: TRzLabel;
    edtNum: TcxSpinEdit;
    chkHeader: TcxCheckBox;
    RzPanel7: TRzPanel;
    Image4: TImage;
    RzLabel7: TRzLabel;
    RzStatus: TRzStatusPane;
    RzPanel13: TRzPanel;
    RzLabel13: TRzLabel;
    Image5: TImage;
    labResult: TRzLabel;
    PopupMenu1: TPopupMenu;
    Excel1: TMenuItem;
    N1: TMenuItem;
    procedure edtFileNameClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cdsDropColumnPropertiesChange(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh3GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2Columns2BeforeShowControl(Sender: TObject);
    procedure chkignoreClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    FDataSet: TZQuery;
    FStartRow: Integer;
    FSumCount,FExceptCount,FSumCol:integer;
    FSelfCheck,isFirstCheck: Boolean;
    procedure CreateColumn;
    procedure CreateDbGridEhTitle;
    procedure OpenExecl(FileName: string);
    procedure WriteToDataSet(DataSet: TDataSet);
    procedure SetStartRow(value:integer);
    procedure SetSelfCheck(value:Boolean);
    procedure SetDataSet(value:TZQuery);
    procedure IsHeader;
    function CheckExcute:Boolean;
    procedure DisplayResult;
 protected
    procedure DecodeFields(s: string);
    procedure DecodeFormats(s: string);
    procedure CreateUseDataSet;virtual;
    procedure CreateParams;virtual;
    function FindColumn(vStr:string):Boolean;virtual;
    function SelfCheckExcute:Boolean;virtual;
    function Check(columnIndex:integer):Boolean;virtual;
    function SaveExcel(dsExcel:TZQuery):Boolean;virtual;
  public
    vList:TStringList;
    mxCol,ErrorSum:Integer;
    FilePath: String;
    class function ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:Boolean=false):Boolean;virtual;
    property DataSet:TZQuery read FDataSet write SetDataSet;
    property StartRow:integer read FStartRow write SetStartRow;
    property SelfCheck:Boolean read FSelfCheck write SetSelfCheck;
  end;

implementation

uses uRspFactory,udllDsUtil,uFnUtil,udllShopUtil,uTokenFactory,udllGlobal,ufrmSortDropFrom,
     uCacheFactory,uSyncFactory,uRspSyncFactory,dllApi,ufrmMeaUnits;

{$R *.dfm}

procedure TfrmExcelFactory.CreateUseDataSet;
begin 

end;

procedure TfrmExcelFactory.DecodeFields(s: string);
var vList1:TStringList;
  i:integer;
  Field:TField;
begin
  if s='' then Raise Exception.Create('û�ж���Ҫ������ֶ�');
  vList1 := TStringList.Create;
  try
    vList1.CommaText := s;
    cdsDropColumn.Properties.Items.Clear;
    for i:=0 to vList1.Count -1 do
      begin
        Field := DataSet.FindField(vList1.Names[i]);
        if Field=nil then Raise Exception.Create(vList1.Names[i]+'�ֶ�����Ч...');
        cdsDropColumn.Properties.Items.AddObject(vList1.ValueFromIndex[i],Pointer(Field.Index));
      end;
  finally
    vList1.Free;
  end;
end;

procedure TfrmExcelFactory.DecodeFormats(s: string);
begin
  if s='' then Raise Exception.Create('û�ж���Ҫ������ֶ�');  
  vList.CommaText := s;
  if s<>'' then
     mxCol := StrtoInt(vList.Names[vList.Count-1])+1
  else
     mxCol := 27;
end;

procedure TfrmExcelFactory.WriteToDataSet(DataSet: TDataSet);
begin
  cdsColumn.First;
  while not cdsColumn.Eof do
    begin
        if cdsColumn.FieldbyName('FieldName').AsString <> '' then
        begin
          if Check(cdsColumn.FieldbyName('ID').AsInteger) then
          begin
           if DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).DataType in [ftString,ftWideString,ftFixedChar] then
              DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).Value := trim(cdsExcel.Fields[cdsColumn.FieldbyName('ID').AsInteger].AsString)
           else
              DataSet.FieldbyName(cdsColumn.FieldbyName('FieldName').AsString).Value := StrtoFloatDef(trim(cdsExcel.Fields[cdsColumn.FieldbyName('ID').AsInteger].asString),0);
         end;
        end;
      cdsColumn.Next;
    end;
end;

procedure TfrmExcelFactory.SetStartRow(value:integer);
begin
  FStartRow:=value;
end;

procedure TfrmExcelFactory.OpenExecl(FileName: string);
var Excel,excelWorkBook: Variant;
  r,n,i:Integer;
  excelRow,excelCol:integer;
  V:array [1..50] of string;
begin
  cdsExcel.Close;
  cdsExcel.CreateDataSet;
  cdsExcel.DisableControls;
  try
  RzStatus.Caption := '���ڴ�Excel';
  RzStatus.Update;
    try
      Excel := CreateOleObject('Excel.Application');
    except
      MessageBox(Handle, Pchar('��鿴�Ƿ�װExcelӦ�ó���'), Pchar(Application.Title), MB_OK + MB_ICONQUESTION);
    end;
    try
      excelWorkBook:=Excel.WorkBooks.open(FileName);
      Excel.Visible := false;
      excelRow:=excelWorkBook.WorkSheets[1].UsedRange.Rows.Count;
      FSumCol:=excelWorkBook.WorkSheets[1].UsedRange.Columns.Count;
      r := 0;
      while r< excelRow do
      begin
        inc(r);
        if r<StartRow then Continue;
        if (r mod 10)=0 then
        begin
          RzStatus.Caption := '��'+inttostr(r)+'��...';
          RzStatus.Update;
        end;

        cdsExcel.Append;
        cdsExcel.FieldByName('ID').AsInteger := r;
        for i:= 1 to mxCol do
          cdsExcel.Fields[i].AsString := Excel.Cells[r,i].Value;
        cdsExcel.Post;
      end;

    finally
      excelWorkBook.close;
      Excel.quit;
    end;
  finally
    cdsExcel.First;
    cdsExcel.EnableControls;
  end;
end;

procedure TfrmExcelFactory.IsHeader;
var i:integer;
    Column: TColumnEh;
begin
  inherited;
  cdsExcel.First;
  if not chkHeader.Checked then
  begin
    cdsExcel.Filtered := false;
    for i:=1 to mxCol do
      begin
        DBGridEh1.Columns[i].Title.Caption := Char(64+i);
      end;
  end
  else
  begin
    if cdsExcel.IsEmpty then Exit;
    for i:=1 to mxCol do
      begin
        DBGridEh1.Columns[i].Title.Caption := cdsExcel.FieldbyName(Char(64+i)).AsString;
      end;
    cdsExcel.Delete;
  end;
  FSumCount:=cdsExcel.RecordCount;
end;

class function TfrmExcelFactory.ExcelFactory(Owner: TForm;vDataSet:TZQuery;Fields,Formats:string;isSelfCheck:Boolean=false): Boolean;
begin

end;

function TfrmExcelFactory.SaveExcel(dsExcel:TZQuery):Boolean;
begin

end;

function TfrmExcelFactory.FindColumn(vStr:string):Boolean;
begin

end;

procedure TfrmExcelFactory.edtFileNameClick(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  edtFileName.Text := OpenDialog1.FileName;
  FilePath := Trim(edtFileName.Text);
  isFirstCheck:=true;
end;

procedure TfrmExcelFactory.FormCreate(Sender: TObject);
begin
  inherited;
  vList := TStringList.Create;
  StartRow := 1;
end;

procedure TfrmExcelFactory.btnNextClick(Sender: TObject);
begin
  inherited;
  btnNext.Enabled:=true;
  btnExport.Visible:=false;
  chkignore.Visible:=false;
  if rzPage.ActivePageIndex=5 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='��һ��';
    rzPage.ActivePageIndex:=0;
  end
  else if rzPage.ActivePageIndex=0 then
  begin
    //��Excel
    if FilePath='' then raise Exception.Create('��ѡ�����Excel�ļ�');
    StartRow:=edtNum.Value;
    OpenExecl(FilePath);
    IsHeader;
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='��һ��';
    rzPage.ActivePageIndex:=1;
  end
  else if rzPage.ActivePageIndex=1 then
  begin
    CreateColumn;
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='���';
    rzPage.ActivePageIndex:=2;
  end
  else if rzPage.ActivePageIndex=2 then
  begin
    CheckExcute;
    CreateDbGridEhTitle;
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='ִ��';
    if FExceptCount>0 then
    begin
      if FSumCount=FExceptCount then
      begin
        btnNext.Caption:='��һ��';
        chkignore.Visible:=False;
      end else
      begin
        chkignore.Visible:=true;
      end;
      if btnNext.Caption='ִ��' then
        if not chkignore.Checked then
          btnNext.Enabled:=false
        else
          btnNext.Enabled:=true;
      btnExport.Visible:=true;
    end;
    rzPage.ActivePageIndex:=3;
  end
  else if rzPage.ActivePageIndex=3 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='���';
    rzPage.ActivePageIndex:=4;
    SaveExcel(FDataSet);
    DisplayResult;
  end
  else if rzPage.ActivePageIndex=4 then
  begin
    Close;
  end;
end;

procedure TfrmExcelFactory.btnPrevClick(Sender: TObject);
begin
  inherited;
  btnNext.Enabled:=true;
  btnExport.Visible:=false;
  chkignore.Visible:=false;
  if rzPage.ActivePageIndex=5 then
  begin
  end
  else if rzPage.ActivePageIndex=4 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='ִ��';
    if FExceptCount>0 then
    begin
      if FSumCount=FExceptCount then
      begin
        btnNext.Caption:='��һ��';
        chkignore.Visible:=False;
      end else
      begin
        chkignore.Visible:=true;
      end;
      if btnNext.Caption='ִ��' then
        if not chkignore.Checked then
          btnNext.Enabled:=false
        else
          btnNext.Enabled:=true;
      btnExport.Visible:=true;
    end;
    rzPage.ActivePageIndex:=3;
  end
  else if rzPage.ActivePageIndex=3 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='���';
    rzPage.ActivePageIndex:=2;
  end
  else if rzPage.ActivePageIndex=2 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='��һ��';
    rzPage.ActivePageIndex:=1;
  end
  else if rzpage.ActivePageIndex=1 then
  begin
    btnPrev.Visible:=True;
    btnPrev.Caption:='��һ��';
    btnNext.Visible:=True;
    btnNext.Caption:='��һ��';
    rzPage.ActivePageIndex:=0;
  end
  else if rzPage.ActivePageIndex=0 then
  begin
    btnPrev.Visible:=False;
    btnNext.Visible:=True;
    btnNext.Caption:='��ʼ';
    rzPage.ActivePageIndex:=5;
  end;
end;

procedure TfrmExcelFactory.FormShow(Sender: TObject);
begin
  inherited;
  rzPage.ActivePageIndex:=5;
  btnPrev.Visible:=False;
  btnNext.Visible:=True;
  btnNext.Caption:='��ʼ';
end;

procedure TfrmExcelFactory.CreateColumn;
var i,n,index:integer;
  FieldName:string;
begin
  cdsColumn.Close;
  cdsColumn.CreateDataSet;
  for i:=0 to DBGridEh1.Columns.Count -3 do
    begin
      if DBGridEh1.Columns[i+1].Visible then
         begin
           cdsColumn.Append;
           cdsColumn.FieldByName('ID').AsInteger := i+1;
           cdsColumn.FieldByName('FileTitle').AsString := DBGridEh1.Columns[i+1].Title.Caption;
           cdsColumn.FieldByName('FileName').AsString:=DBGridEh1.Columns[i+1].FieldName;
           if not chkHeader.Checked then
             begin
               if vList.IndexOfName(inttostr(i))>=0 then
                  begin
                    cdsColumn.FieldByName('FieldName').AsString := vList.Values[inttostr(i)];
                    index := DataSet.FieldByName(cdsColumn.FieldByName('FieldName').AsString).Index;
                    for n:= 0 to cdsDropColumn.Properties.Items.Count -1 do
                      begin
                        if Integer(cdsDropColumn.Properties.Items.Objects[n])=index then
                           begin
                             cdsColumn.FieldByName('DestTitle').AsString := cdsDropColumn.Properties.Items[n];
                             Break;
                           end;
                      end;
                  end;
              end
             else
              begin
                for n := 0 to cdsDropColumn.Properties.Items.Count - 1 do
                  begin
                    if cdsColumn.FieldByName('FileTitle').AsString = cdsDropColumn.Properties.Items[n] then
                      begin
                        cdsDropColumn.ItemIndex := n;
                        cdsColumn.FieldByName('FieldName').AsString := DataSet.Fields[Integer(cdsDropColumn.Properties.Items.Objects[cdsDropColumn.ItemIndex])].FieldName;
                        cdsColumn.FieldByName('DestTitle').AsString := cdsDropColumn.Text;
                        Break;
                      end;
                  end;
              end;
           cdsColumn.Post;
         end;
    end;
  cdsColumn.First;
end; 

procedure TfrmExcelFactory.cdsDropColumnPropertiesChange(Sender: TObject);
begin
  inherited;
  if cdsDropColumn.Visible and cdsDropColumn.Focused then
     begin
       if cdsDropColumn.ItemIndex >=0 then
       begin
         cdsColumn.Edit;
         cdsColumn.FieldByName('FieldName').AsString := DataSet.Fields[Integer(cdsDropColumn.Properties.Items.Objects[cdsDropColumn.ItemIndex])].FieldName;
         cdsColumn.FieldByName('DestTitle').AsString := cdsDropColumn.Text;
         cdsColumn.Post;
       end
       else
       begin
         cdsColumn.Edit;
         cdsColumn.FieldByName('FieldName').AsString := '';
         cdsColumn.FieldByName('DestTitle').AsString := '';
         cdsColumn.Post;
       end;
     end;
end;


procedure TfrmExcelFactory.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='A' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmExcelFactory.DBGridEh3GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if Column.FieldName='Msg' then Text := '�ϼ�:'+Text+'��';
end;

procedure TfrmExcelFactory.CreateParams;
begin
  
end;

function TfrmExcelFactory.CheckExcute: Boolean;
begin
  cdsColumn.DisableControls;
  cdsExcel.DisableControls;

  if not isFirstCheck then
  begin
    cdsExcel.First;
    while not cdsExcel.Eof do
    begin
      cdsExcel.Edit;
      cdsExcel.FieldByName('Msg').AsString:='';
      cdsExcel.FieldByName('STATE').AsString:='0';
      cdsExcel.Post;
      cdsExcel.Next;
    end;
  end;

  if selfCheck then
     SelfCheckExcute;
  FDataSet.EmptyDataSet;

  cdsExcel.First;
  while not cdsExcel.Eof do
  begin
    cdsExcel.Edit;
    RzStatus1.Caption := '���ݼ��:'+InttoStr(cdsExcel.RecNo)+'/'+InttoStr(cdsExcel.RecordCount);
    RzStatus1.Update;
    DataSet.Append;
    WriteToDataSet(DataSet);
    if cdsExcel.FieldByName('Msg').AsString<>'' then
    begin
      cdsExcel.FieldByName('STATE').AsString:='1';
      DataSet.Delete;
    end else
    begin
      cdsExcel.FieldByName('STATE').AsString:='0';
      DataSet.Post;
    end;
    cdsExcel.Post;
    cdsExcel.Next;
  end;

  cdsColumn.EnableControls;
  cdsExcel.EnableControls;

  cdsExcel.Filtered:=False;
  cdsExcel.Filter:='STATE=''1''';
  cdsExcel.Filtered:=True;
  FExceptCount:=cdsExcel.RecordCount;
  RzStatus2.Caption := '�쳣����:'+inttostr(FExceptCount)+'��    ������:'+inttostr(FSumCount)+'��';
  RzStatus2.Update;
  cdsExcel.Filtered:=False;
  isFirstCheck:=false;
end;

procedure TfrmExcelFactory.CreateDbGridEhTitle;
var i:integer;
    FieldName:string;
begin
  for i:=1 to DBGridEh1.Columns.Count-1 do
  begin
    DBGridEh3.Columns[i+1].Title:=DBGridEh1.Columns[i].Title;
  end;
end;

procedure TfrmExcelFactory.SetSelfCheck(value: Boolean);
begin
  FSelfCheck:=value;
end;

procedure TfrmExcelFactory.SetDataSet(value: TZQuery);
begin
  FDataSet:=value;
end;

procedure TfrmExcelFactory.DBGridEh2Columns2BeforeShowControl(
  Sender: TObject);
var i:integer;
begin
  inherited;
  if cdsColumn.FieldByName('FieldName').AsString = '' then
     begin
       cdsDropColumn.ItemIndex := -1;
     end
  else
     begin
       for i:=0 to cdsDropColumn.Properties.Items.Count -1 do
         begin
           if Integer(cdsDropColumn.Properties.Items.Objects[i])=DataSet.FieldbyName(cdsColumn.FieldByName('FieldName').AsString).Index then
             begin
              cdsDropColumn.ItemIndex := i;
              Exit;
             end;
         end;
     end;
end;

function TfrmExcelFactory.Check(columnIndex:integer): Boolean;
begin

end;

function TfrmExcelFactory.SelfCheckExcute: Boolean;
begin
  
end;

procedure TfrmExcelFactory.chkignoreClick(Sender: TObject);
begin
  inherited;
  if FExceptCount>0 then
  begin
    if chkignore.Checked then
      btnNext.Enabled:=true
    else if not chkignore.Checked then
      btnNext.Enabled:=false;
  end;
end; 

procedure TfrmExcelFactory.btnExportClick(Sender: TObject);
var Stream: TMemoryStream;
begin
  inherited;
  saveDialog1.DefaultExt:='*.xls';
  saveDialog1.Filter:='Excel�ĵ�(*.xls)|*.xls';
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '�Ѿ����ڣ��Ƿ񸲸�����'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        exit;
      DeleteFile(SaveDialog1.FileName);
    end;

    Stream := TMemoryStream.Create;
    try
      Stream.Position := 0;
      if ExtractFileExt(SaveDialog1.FileName)='.xls' then
      begin
        with TDBGridEhExportAsXLS.Create do
        begin
          try
            DBGridEh := DBGridEh3;
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
            DBGridEh := DBGridEh3;
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

procedure TfrmExcelFactory.DisplayResult;
var str:string;
begin
  str:='���ļ��е�������������'+inttostr(FSumCount)+' ����'+#13+
       '       ��Ч����������'+inttostr(FSumCount-FExceptCount)+' ����'+#13+
       '       �쳣����������'+inttostr(FExceptCount)+' ����'+#13#10;

  labResult.Caption:=str;

end;

procedure TfrmExcelFactory.N1Click(Sender: TObject);
begin
  inherited;
  cdsExcel.DisableControls;
  cdsExcel.Filtered:=false;
  cdsExcel.Filter:='STATE=''0''';          
  cdsExcel.Filtered:=true;
  cdsExcel.EnableControls;
end;

end.