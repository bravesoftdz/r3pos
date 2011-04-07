unit uCtrlUtil;

interface
uses Windows,Classes,SysUtils,Db,Dialogs,DBGridEh,Forms,Menus,DBGridEhFindDlgs,ZDataSet,ZAbstractRODataset;
type
TClassObject=class of TObject;
TGlobalCtrl=class
  private
    FItems: TStringList;
    procedure SetItems(const Value: TStringList);
  public
    constructor Create;
    destructor  Destroy;override;

    procedure Clear;

    procedure Add(Form:TScrollingWinControl;P:TObject);
    procedure Delete(Form:TScrollingWinControl;P:TObject);
    function Find(Form:TScrollingWinControl;P:TObject):integer;
    procedure FreeMenu(Form:TScrollingWinControl;P:TObject);
    procedure FreePointer(Form:TScrollingWinControl;ClsName:string);

    property Items:TStringList read FItems write SetItems;
  end;
//如果列的Column的 TAG 为 -1 代表不参与排序  
TDbGridEhSort=class
  private
    FDbGrid: TDbGridEh;
    FList: TList;
    SaveTitleClick:TDBGridEhClickEvent;
    SaveDataSetOpenAfter:TDataSetNotifyEvent;
    SaveDataSetOpenBefore:TDataSetNotifyEvent;
    FDataSet: TDataSet;
    FOnAfterSort: TNotifyEvent;
    FLocked: Boolean;
    FADOSort: string;
    procedure DoTitleClick(Column:TColumnEh);
    procedure SetDbGrid(const Value: TDbGridEh);
    procedure ClearSortMarket;

    procedure DoSortZQueryChange(Column:TColumnEh;SortMarket:TSortMarkerEh);
    procedure DoSortMarketChanged(Column: TColumnEh);
    procedure DoAfterOpen(DataSet:TDataSet);
    procedure DoBeforeOpen(DataSet:TDataSet);
    procedure SetDataSet(const Value: TDataSet);
    procedure SetOnAfterSort(const Value: TNotifyEvent);
    procedure SetLocked(const Value: Boolean);
    procedure SetADOSort(const Value: string);
  public
    constructor Create(DbGrid:TDbGridEh;ADataSet:TDataSet=nil);
    destructor  Destroy;override;

    Class procedure InitForm(Form:TForm;Locked:Boolean=false;SortField:string='');
    Class procedure FreeForm(Form:TForm);
    procedure Sort(Column:TColumnEh;SortMarket:TSortMarkerEh);overload;
    procedure Sort(FieldName:string;SortMarket:TSortMarkerEh);overload;
    property Grid:TDbGridEh read FDbGrid write SetDbGrid;
    property DataSet:TDataSet read FDataSet write SetDataSet;
    property OnAfterSort:TNotifyEvent read FOnAfterSort write SetOnAfterSort;
    property Locked:Boolean read FLocked write SetLocked;
    property ADOSort:string read FADOSort write SetADOSort;
  end;
  
//如果列的Column.FieldName 为空时，没有权限查看这个字段，跟字段权限同时应用时可用这一规则
TDbGridEhMark=class
  private
    FDbGrid: TDbGridEh;
    FCurrent: TForm;
    FPopup:TPopupMenu;
    FLoadFormat:boolean;
    procedure SetDbGrid(const Value: TDbGridEh);
    procedure SetCurrent(const Value: TForm);

    procedure AddMenu;
  public
    constructor Create(CurrentForm:TForm;DbGrid:TDbGridEh;LoadFormat:boolean=true);
    destructor  Destroy;override;

    procedure SetupDialog(Sender:TObject);

    procedure LoadFromFile(FileName:string);
    procedure WriteToFile(FileName:string);

    Class procedure InitForm(Form:TForm;LoadFormat:boolean=true);
    Class procedure FreeForm(Form:TForm);

    property DbGrid:TDbGridEh read FDbGrid write SetDbGrid;
    property Current:TForm read FCurrent write SetCurrent;
  end;

//如果列的Column.FieldName 为空时，没有权限查看这个字段，跟字段权限同时应用时可用这一规则
TDbGridEhExport=class
  private
    FDbGrid: TDbGridEh;
    FCurrent: TForm;
    FPopup:TPopupMenu;
    procedure AddMenu;
    procedure SetCurrent(const Value: TForm);
    procedure SetDbGrid(const Value: TDbGridEh);
  public
    procedure ExportToFile(Sender:TObject);
    procedure FindGrid(Sender:TObject);
    constructor Create(CurrentForm:TForm;DbGrid:TDbGridEh);
    destructor  Destroy;override;

    Class procedure InitForm(Form:TForm);
    Class procedure FreeForm(Form:TForm);

    property DbGrid:TDbGridEh read FDbGrid write SetDbGrid;
    property Current:TForm read FCurrent write SetCurrent;
  end;

procedure SortDbGridEh(Grid:TDBGridEh;FieldName:string;SortMarket:TSortMarkerEh;Saved:Boolean=false);
var GlobalCtrl:TGlobalCtrl;

implementation
uses IniFiles,ufrmDbGridEhDialog,DBGridEhImpExp,ufrmBasic;
procedure SortDbGridEh(Grid:TDBGridEh;FieldName:string;SortMarket:TSortMarkerEh;Saved:Boolean=false);
var i:integer;
  Column:TColumnEh;
  S:TSortMarkerEh;
begin
  Column := nil;
  for i:= 0 to Grid.Columns.Count -1 do
    begin
      if Grid.Columns[i].FieldName = FieldName then
         begin
           Column := Grid.Columns[i];
           Break;
         end;
    end;
  S := Column.Title.SortMarker;
  if Column<>nil then
     begin
       Column.Title.SortMarker := SortMarket;
       if Assigned(Grid.OnTitleClick) then
          Grid.OnTitleClick(Column); 
     end;
  if not Saved then
     Column.Title.SortMarker := S;
end;
{ TDbGridEhSort }

constructor TDbGridEhSort.Create(DbGrid: TDbGridEh;ADataSet:TDataSet=nil);
begin
  FDataSet := ADataSet;
  if FDataSet=nil then
     begin
       if DbGrid.DataSource<>nil then
          FDataSet := DbGrid.DataSource.DataSet;
     end;
  SaveTitleClick := DbGrid.OnTitleClick;
  if DataSet<>nil then
     SaveDataSetOpenAfter := DataSet.AfterOpen;
  if DataSet<>nil then
     SaveDataSetOpenBefore := DataSet.BeforeOpen;
  FDbGrid := DbGrid;
  FList := TList.Create;
  inherited Create;
  DbGrid.OnTitleClick := DoTitleClick;
  if DataSet<>nil then
     DataSet.AfterOpen := DoAfterOpen;
  if DataSet<>nil then
     DataSet.BeforeOpen := DoBeforeOpen;
end;

destructor TDbGridEhSort.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TDbGridEhSort.SetDbGrid(const Value: TDbGridEh);
begin
  FDbGrid := Value;
end;

procedure TDbGridEhSort.DoTitleClick(Column: TColumnEh);
begin
  if Grid.DataSource=nil then Exit;
  if Grid.DataSource.DataSet = nil then Exit;
  if Grid.DataSource.DataSet.IsEmpty then Exit;
  if Assigned(SaveTitleClick) then SaveTitleClick(Column);
  if Column.Field = nil then Exit;
  if Column.Tag =-1 then Exit;
  if not Grid.ReadOnly and Locked then Exit;
  case Column.Title.SortMarker of
    smNoneEh: Column.Title.SortMarker := smUpEh;
    smDownEh: Column.Title.SortMarker := smUpEh;
    smUpEh: Column.Title.SortMarker := smDownEh;
  end;
  DoSortMarketChanged(Column);
end;

procedure TDbGridEhSort.DoSortMarketChanged(Column: TColumnEh);
begin
  if DataSet=nil then Exit;
  if DataSet.State in [dsEdit,dsInsert] then DataSet.Post;
  if DataSet Is TZAbstractRODataset then
     DoSortZQueryChange(Column,Column.Title.SortMarker);
  if Assigned(FOnAfterSort) then FOnAfterSort(nil);
end;

class procedure TDbGridEhSort.FreeForm(Form: TForm);
begin
  GlobalCtrl.FreePointer(Form,'TDbGridEhSort');
end;

class procedure TDbGridEhSort.InitForm(Form: TForm;Locked:Boolean=false;SortField:string='');
var
  i:Integer;
  Sort:TDbGridEhSort;
begin
  for i:=0 to Form.ComponentCount -1 do
    begin
      if (Form.Components[i] is TDbGridEh) and (Form.Components[i].Tag = 0) then
         begin
           Sort  := TDbGridEhSort.Create(TDbGridEh(Form.Components[i]));
           Sort.ADOSort := SortField;
           Sort.Locked := Locked;
           GlobalCtrl.Add(Form,Sort);
         end;
    end;
end;

procedure TDbGridEhSort.DoSortZQueryChange(Column:TColumnEh;SortMarket:TSortMarkerEh);
begin
  if Column.Field = nil then Exit;
  case SortMarket of
    smNoneEh:begin
        TZQuery(DataSet).SortedFields  := ADOSort + '';
      end;
    smDownEh:begin
        if ADOSort='' then
           TZQuery(DataSet).SortedFields  := Column.FieldName +' DESC'
        else
           TZQuery(DataSet).SortedFields  := ADOSort + ';' +Column.FieldName +' DESC';
      end;
    smUpEh:begin
        if ADOSort='' then
           TZQuery(DataSet).SortedFields  := Column.FieldName +' DESC'
        else
           TZQuery(DataSet).SortedFields  := ADOSort + ';' +Column.FieldName +' ASC';
      end;
  end;
end;

procedure TDbGridEhSort.ClearSortMarket;
var i:Integer;
begin
  for i:=0 to Grid.Columns.Count -1 do
    begin
      Grid.Columns[i].Title.SortMarker := smNoneEh;
    end;
end;

procedure TDbGridEhSort.DoAfterOpen(DataSet: TDataSet);
begin
  if Assigned(SaveDataSetOpenAfter) then SaveDataSetOpenAfter(DataSet);
  ClearSortMarket;
  if DataSet Is TZAbstractRODataset then
     TZAbstractRODataset(DataSet).SortedFields := '';
end;

procedure TDbGridEhSort.DoBeforeOpen(DataSet: TDataSet);
begin
  if Assigned(SaveDataSetOpenBefore) then SaveDataSetOpenBefore(DataSet);
  if DataSet Is TZAbstractRODataset then
     TZAbstractRODataset(DataSet).SortedFields := '';
end;

procedure TDbGridEhSort.SetDataSet(const Value: TDataSet);
begin
  FDataSet := Value;
end;

procedure TDbGridEhSort.SetOnAfterSort(const Value: TNotifyEvent);
begin
  FOnAfterSort := Value;
end;

procedure TDbGridEhSort.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
end;

procedure TDbGridEhSort.Sort(Column: TColumnEh; SortMarket: TSortMarkerEh);
begin
  Column.Title.SortMarker := SortMarket;
  DoSortMarketChanged(Column);
end;

procedure TDbGridEhSort.Sort(FieldName: string; SortMarket: TSortMarkerEh);
var i:integer;
  Column:TColumnEh;
begin
  Column := nil;
  for i:= 0 to Grid.Columns.Count -1 do
    begin
      if Grid.Columns[i].FieldName = FieldName then
         begin
           Column := Grid.Columns[i];
           Break;
         end;
    end;
  if Column<>nil then Sort(Column,SortMarket);
end;

procedure TDbGridEhSort.SetADOSort(const Value: string);
begin
  FADOSort := Value;
end;

{ TGlobalCtrl }

procedure TGlobalCtrl.Add(Form:TScrollingWinControl;P:TObject);
var v:TList;
    n:Integer;
begin
  n := FItems.IndexOf(Inttostr(Integer(Form)));
  if n>=0 then
    begin
      v := TList(FItems.Objects[n]);
      v.Add(P);
    end
  else
    begin
      v := TList.Create;
      FItems.AddObject(Inttostr(Integer(Form)),v);
      v.Add(P);
    end;
end;

procedure TGlobalCtrl.Clear;
var i,j:Integer;
  v:TList;
begin
  for i:=FItems.Count -1 downto 0 do
    begin
      v := TList(FItems.Objects[i]);
      for j:=0 to v.Count -1 do
        TObject(v.Items[j]).Free;
      v.Free;
    end;
  FItems.Clear;
end;

constructor TGlobalCtrl.Create;
begin
  FItems := TStringList.Create;
  inherited;
end;

procedure TGlobalCtrl.Delete(Form:TScrollingWinControl;P:TObject);
var v:TList;
    n:Integer;
begin
  n := FItems.IndexOf(Inttostr(Integer(Form)));
  if n>=0 then
    begin
      v := TList(FItems.Objects[n]);
      n := v.IndexOf(P);
      if n>=0 then
         v.Delete(n);  
    end;
end;

destructor TGlobalCtrl.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

function TGlobalCtrl.Find(Form: TScrollingWinControl; P: TObject): integer;
var i:Integer;
    v:TList;
    n:Integer;
begin
  result := -1;
  n := FItems.IndexOf(Inttostr(Integer(Form)));
  if n>=0 then
    begin
      v := TList(FItems.Objects[n]);
      for i:= 0 to TList(v).Count-1 do
        begin
          if Pointer(TList(v).Items[i]) = P then
             begin
               result := i;
               break;
             end;
        end;
    end;
end;

procedure TGlobalCtrl.FreeMenu(Form: TScrollingWinControl; P: TObject);
var i:Integer;
    v:TList;
    n:Integer;
begin
  n := FItems.IndexOf(Inttostr(Integer(Form)));
  if n>=0 then
    begin
      v := TList(FItems.Objects[n]);
      for i:= 0 to TList(v).Count-1 do
        begin
          if Pointer(TList(v).Items[i]) = P then
             begin
               TObject(TList(v).Items[i]).Free;
               TList(v).Delete(i);
               break;
             end;
        end;
    end;
end;

procedure TGlobalCtrl.FreePointer(Form:TScrollingWinControl;ClsName:string);
var i:Integer;
    v:TList;
    n:Integer;
begin
  n := FItems.IndexOf(Inttostr(Integer(Form)));
  if n>=0 then
    begin
      v := TList(FItems.Objects[n]);
      i := 0;
      while i<TList(v).Count do
        begin
          if TObject(TList(v).Items[i]).ClassNameIs('TPopupMenu') then
             begin
               TList(v).Delete(i);
             end
          else
          if TObject(TList(v).Items[i]).ClassNameIs(ClsName) then
             begin
               TObject(TList(v).Items[i]).Free;
               TList(v).Delete(i);
             end
          else
             Inc(i);
        end;
    end;
end;

procedure TGlobalCtrl.SetItems(const Value: TStringList);
begin
  FItems := Value;
end;

{ TDbGridEhMark }

procedure TDbGridEhMark.AddMenu;
var p:TPopupMenu;
  Item :TMenuItem;
begin
  p := DbGrid.PopupMenu;
  if p=nil then
     begin
        p := TPopupMenu.Create(Current);
        FPopup := p;
        DbGrid.PopupMenu := p;
     end
  else
     begin
       if GlobalCtrl.Find(FCurrent,P)<0 then
          GlobalCtrl.Add(FCurrent,P) else Exit;
     end;

  Item := TMenuItem.Create(nil);
  Item.Caption := '显示列设置';
  Item.OnClick := SetupDialog;
  p.Items.Add(Item);
end;

constructor TDbGridEhMark.Create(CurrentForm:TForm;DbGrid: TDbGridEh;LoadFormat:boolean=true);
begin
  FLoadFormat := LoadFormat;
  FDbGrid := DbGrid;
  FCurrent := CurrentForm;
  FPopup := nil;
  inherited Create;
  AddMenu;
  if LoadFormat then LoadFromFile(ExtractFilePath(ParamStr(0))+'\Seting.Ini');
end;

destructor TDbGridEhMark.Destroy;
begin
  if FLoadFormat then WriteToFile(ExtractFilePath(ParamStr(0))+'\Seting.Ini');
  if FPopup<>nil then GlobalCtrl.FreeMenu(FCurrent,FPopup);
  inherited;
end;

class procedure TDbGridEhMark.FreeForm(Form: TForm);
begin
  GlobalCtrl.FreePointer(Form,'TDbGridEhMark');
end;

class procedure TDbGridEhMark.InitForm(Form: TForm;LoadFormat:boolean=true);
var
  i:Integer;
  Mark:TDbGridEhMark;
begin
  for i:=0 to Form.ComponentCount -1 do
    begin
      if Form.Components[i] is TDbGridEh then
         begin
           Mark  := TDbGridEhMark.Create(Form,TDbGridEh(Form.Components[i]),LoadFormat);
           GlobalCtrl.Add(Form,Mark);
         end;
    end;
end;

procedure TDbGridEhMark.LoadFromFile(FileName: string);
var F:TIniFile;
  i:Integer;
begin
  if FDbGrid = nil then Raise Exception.Create('DbGrid不能为空。'); 
  F := TIniFile.Create(FileName);
  try
     for i:=0 to DbGrid.Columns.Count -1 do
       begin
         if DbGrid.Columns[i].FieldName<>'' then
            begin
             DbGrid.Columns[i].Visible := F.ReadBool(Current.Name+'.'+DbGrid.Name +'.'+DbGrid.Columns[i].FieldName,'Visible',True);
             if not DbGrid.AutoFitColWidths then
             DbGrid.Columns[i].Width := F.ReadInteger(Current.Name+'.'+DbGrid.Name +'.'+DbGrid.Columns[i].FieldName,'Width',DbGrid.Columns[i].Width);
            end
         else
            DbGrid.Columns[i].Visible := False;
       end;
  finally
     F.Free;
  end; 
end;

procedure TDbGridEhMark.SetCurrent(const Value: TForm);
begin
  FCurrent := Value;
end;

procedure TDbGridEhMark.SetDbGrid(const Value: TDbGridEh);
begin
  FDbGrid := Value;
end;

procedure TDbGridEhMark.SetupDialog(Sender: TObject);
begin
  if TfrmDbGridEhDialog.ShowExecute(DbGrid) then
     WriteToFile(ExtractFilePath(ParamStr(0))+'\Seting.ini');
end;

procedure TDbGridEhMark.WriteToFile(FileName: string);
var F:TIniFile;
  i:Integer;
begin
  if FDbGrid = nil then Raise Exception.Create('DbGrid不能为空。');
  F := TIniFile.Create(FileName);
  try
     for i:=0 to DbGrid.Columns.Count -1 do
       begin
         F.WriteBool(Current.Name+'.'+DbGrid.Name +'.'+DbGrid.Columns[i].FieldName,'Visible',DbGrid.Columns[i].Visible);
         F.WriteInteger(Current.Name+'.'+DbGrid.Name +'.'+DbGrid.Columns[i].FieldName,'Width',DbGrid.Columns[i].Width);
         F.WriteInteger(Current.Name+'.'+DbGrid.Name +'.'+DbGrid.Columns[i].FieldName,'Index',DbGrid.Columns[i].Index);
       end;
  finally
     F.Free;
  end;  
end;

{ TDbGridEhExport }

procedure TDbGridEhExport.AddMenu;
var p:TPopupMenu;
  Item :TMenuItem;
begin
  p := DbGrid.PopupMenu;
  if p=nil then
     begin
        p := TPopupMenu.Create(Current);
        FPopup := p;
        DbGrid.PopupMenu := p;
     end
  else
     begin
       if GlobalCtrl.Find(FCurrent,P)<0 then
          GlobalCtrl.Add(FCurrent,P) else Exit;
     end;

  Item := TMenuItem.Create(nil);
  Item.Caption := '查找  Ctrl+F';
  Item.OnClick := FindGrid;
  p.Items.Add(Item);
  Item := TMenuItem.Create(nil);
  Item.Caption := '导出列表至...';
  Item.OnClick := ExportToFile;
  p.Items.Add(Item);
end;

constructor TDbGridEhExport.Create(CurrentForm: TForm; DbGrid: TDbGridEh);
begin
  FDbGrid := DbGrid;
  FCurrent := CurrentForm;
  FPopup := nil;
  inherited Create;
  AddMenu;
end;

destructor TDbGridEhExport.Destroy;
begin
  if FPopup<>nil then GlobalCtrl.FreeMenu(FCurrent,FPopup);
  inherited;
end;

procedure TDbGridEhExport.ExportToFile(Sender: TObject);
var SaveDialog:TSaveDialog;
    Stream: TMemoryStream;
begin
  if DbGrid.DataSource=nil then Exit;
  if DBGrid.DataSource.DataSet = nil then Exit;
  if DBGrid.DataSource.DataSet.IsEmpty then Exit;
  if not TfrmBasic(Current).CheckCanExport then Raise Exception.Create('你没有此模块的导出权限，请和管理员联系。');
  TfrmBasic(Current).DoBeforeExport;
  SaveDialog := TSaveDialog.Create(Current);
  try
    SaveDialog.DefaultExt := '*.xls';
    SaveDialog.Filter := 'Excel文档(*.xls)|*.xls';
    if SaveDialog.Execute then
       begin
       if FileExists(SaveDialog.FileName) then
          begin
            if MessageBox(Current.Handle,Pchar(SaveDialog.FileName+'存在，是否立即覆盖?'),'友情提示...',MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
            if not DeleteFile(SaveDialog.FileName) then Raise Exception.Create('文件被占用无法完成导出...');
          end;
       end else Exit;
    Stream := TMemoryStream.Create;
    try
      Stream.Position := 0;
   //   with TDBGridEhExportAsXLS.Create do
      with TDBGridEhExportAsHTML.Create do
      begin
        try
          DBGridEh := DbGrid;
          ExportToStream(Stream, True);
        finally
          Free;
        end;
      end;
      Stream.SaveToFile(SaveDialog.FileName);
    finally
      Stream.Free;
    end;
  finally
    SaveDialog.Free;
  end;
end;

procedure TDbGridEhExport.FindGrid(Sender: TObject);
begin
  if DbGrid.DataSource=nil then Exit;
  if DBGrid.DataSource.DataSet = nil then Exit;
  if DBGrid.DataSource.DataSet.IsEmpty then Exit;
  ExcecuteDBGridEhFindDialog(DbGrid, '', '', nil,true);
end;

class procedure TDbGridEhExport.FreeForm(Form: TForm);
begin
  GlobalCtrl.FreePointer(Form,'TDbGridEhExport');
end;

class procedure TDbGridEhExport.InitForm(Form: TForm);
var
  i:Integer;
  Mark:TDbGridEhExport;
begin
  for i:=0 to Form.ComponentCount -1 do
    begin
      if Form.Components[i] is TDbGridEh then
         begin
           if TDbGridEh(Form.Components[i]).DataSource <>nil then
           begin
             Mark  := TDbGridEhExport.Create(Form,TDbGridEh(Form.Components[i]));
             GlobalCtrl.Add(Form,Mark);
           end;
         end;
    end;
end;

procedure TDbGridEhExport.SetCurrent(const Value: TForm);
begin
  FCurrent := Value;
end;

procedure TDbGridEhExport.SetDbGrid(const Value: TDbGridEh);
begin
  FDbGrid := Value;
end;

initialization
  GlobalCtrl:=TGlobalCtrl.Create;
finalization
  GlobalCtrl.Free;
end.
