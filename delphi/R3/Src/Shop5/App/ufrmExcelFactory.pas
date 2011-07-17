unit ufrmExcelFactory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmBasic, ActnList, Menus, StdCtrls, RzBckgnd, RzTabs,
  ExtCtrls, RzPanel, Grids, DBGridEh, DB, RzButton, ActiveX, ComObj,
  RzPrgres, RzStatus, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, DBClient, RzLabel, Mask, RzEdit, RzBtnEdt,
  RzSpnEdt, cxSpinEdit, cxButtonEdit, jpeg;

type
  TExeclFactoryCheck=function(Source,Dest:TDataSet;SFieldName:string;DFieldName:string):Boolean;
  TExeclFactorySave=function(CdsTable:TDataSet):Boolean;
  TExeclFactoryFindColumn=function(CdsCol:TDataSet):Boolean;
  TfrmExcelFactory = class(TfrmBasic)
    RzPage: TRzPageControl;
    TabSheet1: TRzTabSheet;
    RzPanel6: TRzPanel;
    dsExcel: TDataSource;
    OpenDialog1: TOpenDialog;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    DBGridEh1: TDBGridEh;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    DBGridEh2: TDBGridEh;
    dsColumn: TDataSource;
    cdsDropColumn: TcxComboBox;
    N4: TMenuItem;
    N5: TMenuItem;
    cdsColumn: TZQuery;
    cdsExcel: TZQuery;
    Panel1: TPanel;
    RzBitBtn2: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    TabSheet3: TRzTabSheet;
    RzPanel2: TRzPanel;
    TabSheet4: TRzTabSheet;
    TabSheet5: TRzTabSheet;
    chkHeader: TcxCheckBox;
    RzLabel1: TRzLabel;
    RzPanel3: TRzPanel;
    RzPanel4: TRzPanel;
    DBGridEh3: TDBGridEh;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    edtNum: TcxSpinEdit;
    labImportInfo: TRzLabel;
    chkignore: TcxCheckBox;
    edtFileName: TcxButtonEdit;
    RzStatus: TRzStatusPane;
    RzLabel4: TRzLabel;
    Image1: TImage;
    RzStatus1: TRzStatusPane;
    RzLabel5: TRzLabel;
    Image2: TImage;
    RzLabel6: TRzLabel;
    procedure RzBitBtn2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure cdsDropColumnPropertiesChange(Sender: TObject);
    procedure DBGridEh2Columns2BeforeShowControl(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNumClick(Sender: TObject);
    procedure chkignorePropertiesChange(Sender: TObject);
    procedure edtFileNameClick(Sender: TObject);
  private
    FDataSet: TDataSet;
    FStartRow: Integer;
    { Private declarations }
    procedure ClearConfig;
    procedure CreateColumn;
    procedure IsHeader;
    procedure DecodeFields(s:string);
    procedure DecodeFormats(s:string);
    procedure SetDataSet(const Value: TDataSet);
    procedure WriteToDataSet(DataSet:TDataSet);
    procedure SetStartRow(const Value: Integer);
  public
    { Public declarations }
    Proc:TExeclFactoryCheck;
    Save:TExeclFactorySave;
    FindCdsColumn:TExeclFactoryFindColumn;
    vList:TStringList;
    mxCol,ErrorSum:Integer;
    FilePath: String;
    function Execute(DataSet:TDataSet):Boolean;virtual;
    procedure OpenExecl(FileName:string);
    class function ExcelFactory(_DataSet:TDataSet;Fields:string;CheckProc:TExeclFactoryCheck=nil;SaveFun:TExeclFactorySave=nil;FindC:TExeclFactoryFindColumn=nil;Formats:string='';vStartRow:Integer=1):Boolean;
    property DataSet:TDataSet read FDataSet write SetDataSet;
    property StartRow:Integer read FStartRow write SetStartRow;
  end;

implementation

{$R *.dfm}

class function TfrmExcelFactory.ExcelFactory(_DataSet: TDataSet;Fields:string;CheckProc:TExeclFactoryCheck=nil;SaveFun:TExeclFactorySave=nil;FindC:TExeclFactoryFindColumn=nil;Formats:string='';vStartRow:Integer=1): Boolean;
begin
  with TfrmExcelFactory.Create(Application.MainForm) do
    begin
      try
        FDataSet := _DataSet;
        StartRow := vStartRow;
        Proc := CheckProc;
        Save := SaveFun;
        FindCdsColumn := FindC;
        DecodeFields(Fields);
        DecodeFormats(Formats);
        result := (ShowModal=MROK);
      finally
        free;
      end;
    end;
end;

function TfrmExcelFactory.Execute(DataSet: TDataSet):Boolean;
var HasError:Boolean;
begin
  result := false;
  ErrorSum := 0;
  cdsColumn.DisableControls;
  cdsExcel.DisableControls;
  try
    try
    HasError := false;
    cdsExcel.First;
    while not cdsExcel.Eof do
      begin
        try
          RzStatus1.Caption := '执行:'+InttoStr(cdsExcel.RecNo)+'/'+InttoStr(cdsExcel.RecordCount);
          RzStatus1.Update;
          DataSet.Append;
          WriteToDataSet(DataSet);
          Proc(nil,DataSet,'','');
          DataSet.Post;
          cdsExcel.Edit;
          cdsExcel.FieldByName('STATE').AsInteger := 0;
          cdsExcel.FieldByName('Msg').AsString := '';
          cdsExcel.Post;
        except
          on E:Exception do
          begin
            cdsExcel.Edit;
            cdsExcel.FieldByName('STATE').AsInteger := 1;
            cdsExcel.FieldByName('Msg').AsString := E.Message;
            cdsExcel.Post;
            DataSet.Delete;
            HasError := true;
            inc(ErrorSum);
          end;
        end;
        cdsExcel.Next;
      end;
    except
      //RzBitBtn3.Visible := False;
      //rzPage.OnChange(nil);
      {if UpperCase(DataSet.ClassName)='TCLIENTDATASET' then
         TClientDataSet(DataSet).CancelUpdates
      else
         TZQuery(DataSet).CancelUpdates;}
      HasError := true;
      Raise;
    end;
    if HasError then
      begin
        MessageBox(Handle,'执行过程发现数据异常，请核对正确后再导入','友情提示...',MB_OK+MB_ICONWARNING);
        rzPage.ActivePageIndex := 3;
        RzBitBtn1.Caption := '下一步';
        //RzBitBtn3.Visible := False;
        //rzPage.OnChange(nil);
        {if UpperCase(DataSet.ClassName)='TCLIENTDATASET' then
           TClientDataSet(DataSet).CancelUpdates
        else
           TZQuery(DataSet).CancelUpdates;}
      end
    else
      result := true;
  finally
    cdsColumn.EnableControls;
    cdsExcel.EnableControls;
    labImportInfo.Caption :=
    '从文件中导入 '+IntToStr(cdsExcel.RecordCount)+' 条数据'+#13#10+
    '有效数据 '+IntToStr(cdsExcel.RecordCount-ErrorSum)+' 条'+#13#10+
    '错误数据 '+IntToStr(ErrorSum)+' 条';
    cdsExcel.Filtered := False;
    cdsExcel.Filter := ' STATE=1 ';
    cdsExcel.Filtered := True;
  end;
end;

procedure TfrmExcelFactory.OpenExecl(FileName: string);
function CheckNull(V:array of string):Boolean;
var i:integer;
begin
  result := true;
  for i:=0 to 3 do
    result := result and (trim(V[i])='');
end;
var Excel: Variant;
  r,n,i:Integer;
  V:array [1..50] of string;
begin
  cdsExcel.Close;
  cdsExcel.CreateDataSet;
  cdsExcel.DisableControls;
  try
  RzStatus.Caption := '正在打开Excel';
  RzStatus.Update;
  Excel := CreateOleObject('Excel.Application');
  Excel.WorkBooks.open(FileName);
    try
      r := 0;
      n := 0;
      while True do
        begin
          inc(r);
          if r<StartRow then Continue;
          if (r mod 10)=0 then
          begin
            RzStatus.Caption := '打开'+inttostr(r)+'行...';
            RzStatus.Update;
          end;
          for i:= 1 to mxCol do
            V[I] := Excel.Cells.Item[r, i].Value;
          if CheckNull(v) then
             begin
               inc(n);
               if n>=1 then Exit;
               Continue;
             end;
          cdsExcel.Append;
          cdsExcel.FieldByName('ID').AsInteger := r;
          for i:=1 to mxCol do
            cdsExcel.Fields[i].AsString := trim(V[i]);
          cdsExcel.Post;
        end;
    finally
      Excel.Quit;
    end;
  finally
    cdsExcel.First;
    cdsExcel.EnableControls;
  end;
end;

procedure TfrmExcelFactory.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  if rzPage.ActivePageIndex = 4 then
     begin
       if ErrorSum = 0 then
         begin
           rzPage.ActivePageIndex := 2;
           RzBitBtn1.Caption := '立即执行';
           RzBitBtn1.Enabled := True;
         end
       else
         begin
           rzPage.ActivePageIndex := 3;
           RzBitBtn1.Caption := '下一步';
           RzBitBtn1.Enabled := True;
         end;
     end
  else if rzPage.ActivePageIndex = 3 then
     begin
       RzStatus1.Caption := '';
       RzStatus1.Update;
       rzPage.ActivePageIndex := 2;
       RzBitBtn1.Caption := '立即执行';
       cdsExcel.Filtered := False;
     end
  else if rzPage.ActivePageIndex = 2 then
     begin
       rzPage.ActivePageIndex := 1;
       RzBitBtn1.Caption := '下一步';
       cdsExcel.Filtered := False;
     end
  else if rzPage.ActivePageIndex = 1 then
     begin
       rzPage.ActivePageIndex := 0;
       RzStatus.Caption := '';
       RzStatus.Update;
       RzStatus1.Caption := '';
       RzStatus1.Update;
       RzBitBtn1.Visible := True;
       RzBitBtn2.Visible := False;
       RzBitBtn1.Caption := '开始';
     end;
end;

procedure TfrmExcelFactory.N1Click(Sender: TObject);
var r:Integer;
begin
  inherited;
  cdsExcel.DisableControls;
  try
     r := cdsExcel.FieldbyName('ID').AsInteger;
     cdsExcel.First;
     while (cdsExcel.FieldByName('ID').AsInteger<r) and not cdsExcel.Eof do
        cdsExcel.Delete;
  finally
     cdsExcel.First;
     cdsExcel.EnableControls;
  end;
end;

procedure TfrmExcelFactory.N2Click(Sender: TObject);
var r:Integer;
begin
  inherited;
  cdsExcel.DisableControls;
  try
     r := cdsExcel.FieldbyName('ID').AsInteger;
     cdsExcel.First;
     while (cdsExcel.FieldByName('ID').AsInteger>r) and not cdsExcel.Eof do
        cdsExcel.Delete;
  finally
     cdsExcel.Last;
     cdsExcel.EnableControls;
  end;
end;

procedure TfrmExcelFactory.N3Click(Sender: TObject);
begin
  inherited;
  if not cdsExcel.IsEmpty then cdsExcel.Delete; 
end;

procedure TfrmExcelFactory.ClearConfig;
var i:integer;
begin
  for i:=0 to DBGridEh1.Columns.Count -1 do
    DBGridEh1.Columns[i].Tag := 0; 
end;

procedure TfrmExcelFactory.FormCreate(Sender: TObject);
var i:integer;
begin
  inherited;
  vList := TStringList.Create;
  RzPage.ActivePageIndex := 0;
  ErrorSum := 0;
  for i:=0 to RzPage.PageCount -1 do
    RzPage.Pages[i].TabVisible := false;
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
           cdsColumn.FieldByName('Title').AsString := DBGridEh1.Columns[i+1].Title.Caption;
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
                             cdsColumn.FieldByName('DestTitleName').AsString := cdsDropColumn.Properties.Items[n];
                             Break;
                           end;
                      end;
                  end;
              end
             else
              begin
                for n := 0 to cdsDropColumn.Properties.Items.Count - 1 do
                  begin
                    if cdsColumn.FieldByName('Title').AsString = cdsDropColumn.Properties.Items[n] then
                      begin
                        cdsDropColumn.ItemIndex := n;
                        cdsColumn.FieldByName('FieldName').AsString := DataSet.Fields[Integer(cdsDropColumn.Properties.Items.Objects[cdsDropColumn.ItemIndex])].FieldName;
                        cdsColumn.FieldByName('DestTitleName').AsString := cdsDropColumn.Text;
                        Break;
                      end;
                  end;
              end;
           cdsColumn.Post;  
         end;
    end;
  cdsColumn.First;
end;

procedure TfrmExcelFactory.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
   if rzPage.ActivePageIndex = 0 then
    begin
      OpenExecl(FilePath);
      IsHeader;
      rzPage.ActivePageIndex := 1;
      RzBitBtn2.Visible := True;
      RzBitBtn1.Caption := '下一步';
    end
  else if rzPage.ActivePageIndex = 1 then
    begin
      CreateColumn;
      rzPage.ActivePageIndex := 2;
      RzBitBtn1.Caption := '立即执行';
    end
  else if rzPage.ActivePageIndex = 2 then
    begin
      if not DataSet.Active then Exit;
      if not Execute(DataSet) then Exit;
      if ErrorSum = 0 then
        begin
          RzBitBtn1.Caption := '提交';
          rzPage.ActivePageIndex := 4;
          chkignore.Visible := False;
        end
      else
        begin
          RzBitBtn1.Caption := '下一步';
          rzPage.ActivePageIndex := 3;
        end;
    end
  else if rzPage.ActivePageIndex = 3 then
    begin
      rzPage.ActivePageIndex := 4;
      RzBitBtn1.Caption := '提交';
      if ErrorSum > 0 then
        begin
          RzBitBtn1.Enabled := chkignore.Checked;
        end
      else
        begin
          RzBitBtn1.Enabled := True;
          chkignore.Visible := False;
        end;
    end
  else if RzPage.ActivePageIndex = 4 then
    begin
      if Assigned(FindCdsColumn) then
      begin
        if FindCdsColumn(cdsColumn) then
        begin
          if Assigned(Save) then
          begin
            Screen.Cursor := crSQLWait;
            try
              if Save(DataSet) then
                begin
                  MessageBox(Handle,'数据已经导入数据库中！','友情提示...',MB_OK+MB_ICONINFORMATION);
                  ModalResult := mrOk;
                end
              else
                MessageBox(Handle,'数据导入失败！','友情提示...',MB_OK+MB_ICONWARNING);
            finally
              Screen.Cursor := crDefault;
            end;
          end;
        end;
      end;
    end;
  //RzPageChange(nil);
end;

procedure TfrmExcelFactory.DecodeFields(s: string);
var vList:TStringList;
  i:integer;
  Field:TField;
begin
  if s='' then Raise Exception.Create('没有定义要导入的字段');
  vList := TStringList.Create;
  try
    vList.CommaText := s;
    cdsDropColumn.Properties.Items.Clear;
    for i:=0 to vList.Count -1 do
      begin
        Field := DataSet.FindField(vList.Names[i]);
        if Field=nil then Raise Exception.Create(vList.Names[i]+'字段名无效...');
        cdsDropColumn.Properties.Items.AddObject(vList.ValueFromIndex[i],Pointer(Field.Index));
      end;
  finally
    vList.Free;
  end;
end;

procedure TfrmExcelFactory.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
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
         cdsColumn.FieldByName('DestTitleName').AsString := cdsDropColumn.Text;
         cdsColumn.Post;
       end
       else
       begin
         cdsColumn.Edit;
         cdsColumn.FieldByName('FieldName').AsString := '';
         cdsColumn.FieldByName('DestTitleName').AsString := '';
         cdsColumn.Post;
       end;
     end;
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

procedure TfrmExcelFactory.WriteToDataSet(DataSet: TDataSet);
begin
  cdsColumn.First;
  while not cdsColumn.Eof do
    begin
        if cdsColumn.FieldbyName('FieldName').AsString <> '' then
        begin
          if not Proc(cdsExcel,DataSet,cdsExcel.Fields[cdsColumn.FieldbyName('ID').AsInteger].FieldName,cdsColumn.FieldbyName('FieldName').AsString) then
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

procedure TfrmExcelFactory.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if cdsExcel.FieldByName('STATE').AsInteger = 1 then
     Background := clYellow;
end;

procedure TfrmExcelFactory.FormClose(Sender: TObject;
  var Action: TCloseAction);
var i:integer;
begin
  for i:=0 to cdsDropColumn.Properties.Items.Count -1 do
    cdsDropColumn.Properties.Items.Objects[i] := nil;
  inherited;
end;

procedure TfrmExcelFactory.DecodeFormats(s: string);
begin
  vList.CommaText := s;
  if s<>'' then
     mxCol := StrtoInt(vList.Names[vList.Count-1])+1
  else
     mxCol := 27;
end;

procedure TfrmExcelFactory.FormDestroy(Sender: TObject);
begin
  vList.Free;
  inherited;

end;

procedure TfrmExcelFactory.SetStartRow(const Value: Integer);
begin
  FStartRow := Value;
  //Label1.Caption := '数据格式要求:第 '+inttostr(Value)+' 行 开始为有效数据行';
end;

procedure TfrmExcelFactory.N5Click(Sender: TObject);
begin
  inherited;
  cdsExcel.DisableControls;
  try
     cdsExcel.First;
     while not cdsExcel.Eof do
        begin
          if cdsExcel.FieldByName('STATE').AsInteger=1 then
             cdsExcel.Delete
          else
             cdsExcel.Next;
        end;
  finally
     cdsExcel.Last;
     cdsExcel.EnableControls;
  end;
end;

procedure TfrmExcelFactory.IsHeader;
var i:integer;
begin
  inherited;
  cdsExcel.First;
  if not chkHeader.Checked then
  begin
    cdsExcel.Filtered := false;
    for i:=1 to 26 do
      begin
        DBGridEh1.Columns[i].Title.Caption := Char(64+i);
      end;
  end
  else
  begin
    if cdsExcel.IsEmpty then Exit;
    for i:=1 to 26 do
      begin
        DBGridEh1.Columns[i].Title.Caption := cdsExcel.FieldbyName(Char(64+i)).AsString;
      end;
  end;
  cdsExcel.Delete;
end;

procedure TfrmExcelFactory.FormShow(Sender: TObject);
begin
  inherited;
  RzBitBtn1.Caption := '开始';
  RzBitBtn2.Visible := False;
end;

procedure TfrmExcelFactory.edtNumClick(Sender: TObject);
begin
  inherited;
  StartRow := edtNum.Value;
end;

procedure TfrmExcelFactory.chkignorePropertiesChange(Sender: TObject);
begin
  inherited;
  RzBitBtn1.Enabled := chkignore.Checked;
end;

procedure TfrmExcelFactory.edtFileNameClick(Sender: TObject);
begin
  inherited;
  OpenDialog1.Execute;
  edtFileName.Text := OpenDialog1.FileName;
  FilePath := Trim(edtFileName.Text);
end;

end.
