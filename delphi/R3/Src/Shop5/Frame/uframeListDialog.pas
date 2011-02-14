unit uframeListDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, ComCtrls, RzTreeVw, Grids, DBGridEh, cxControls, cxContainer,
  cxEdit, cxTextEdit, StdCtrls, cxRadioGroup, DB, ZDataSet,ZBase,
  ZAbstractRODataset, ZAbstractDataset;

type
  TframeListDialog = class(TframeDialogForm)
    btnOk: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    RzPanel4: TRzPanel;
    DBGridEh1: TDBGridEh;
    fndPanel: TPanel;
    RzPanel5: TRzPanel;
    Label8: TLabel;
    edtSearch: TcxTextEdit;
    dsList: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    RzBitBtn1: TRzBitBtn;
    cdsList: TZQuery;
    procedure RzBitBtn2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtSearchKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RzTreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsListFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure edtSearchPropertiesChange(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
  private
    { Private declarations }
    FMultiSelect: boolean;
    procedure InitGrid;
    procedure SetMultiSelect(const Value: boolean);
  public
    { Public declarations }
    procedure ParserField(ListField:String);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    //多选对话框
    
    class function FindMDialog(AOwner:TForm;SQL:string;Fields:string;vList:TRecordList):boolean;
    //单选对话框
    class function FindDialog(AOwner:TForm;SQL:string;Fields:string;AObj: TRecord_):boolean;
    property MultiSelect:boolean read FMultiSelect write SetMultiSelect;
  end;

implementation
uses uCtrlUtil, uGlobal, uShopUtil;
{$R *.dfm}

{ TframeSelectGoods }

constructor TframeListDialog.Create(AOwner: TComponent);
begin
  inherited;
  MultiSelect := false;
  InitGrid;
  TDbGridEhSort.InitForm(self);
end;

destructor TframeListDialog.Destroy;
begin
  TDbGridEhSort.FreeForm(self);
  inherited;
end;

procedure TframeListDialog.InitGrid;
begin
  inherited;
  InitGridPickList(DBGridEh1);
end;

procedure TframeListDialog.RzBitBtn2Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TframeListDialog.btnOkClick(Sender: TObject);
procedure SetCurrent;
begin
  cdsList.Edit;
  cdsList.FieldByName('A').AsInteger :=1 ;
  cdsList.Post;
end;
var 
  i:integer;
begin
  inherited;
  cdsList.DisableControls;
  try
    if MultiSelect then
      begin
        cdsList.Filtered := false;
        cdsList.Filter := 'A=1';
        cdsList.Filtered := true;
      end;
    if cdsList.IsEmpty then
       begin
         if MultiSelect then
            cdsList.Filtered := false;
         Raise Exception.Create('请选择货品,在选择栏打勾');
       end;
  finally
    if MultiSelect then
       cdsList.Filtered := false;
    cdsList.EnableControls;
  end;
  ModalResult := MROK;
end;

procedure TframeListDialog.SetMultiSelect(const Value: boolean);
begin
  FMultiSelect := Value;
  DBGridEh1.Columns[0].Visible := Value;
  N1.Enabled:=Value;
  N2.Enabled:=Value;
  N3.Enabled:=Value;
end;

procedure TframeListDialog.DBGridEh1DblClick(Sender: TObject);
var AObj:TRecord_;
begin
  inherited;
  if cdsList.IsEmpty then Exit;
  if Assigned(OnSave) then
     begin
       AObj := TRecord_.Create;
       try
         AObj.ReadFromDataSet(cdsList);
         OnSave(AObj); 
       finally
         AObj.Free;
       end;
     end
  else
     begin
       if not cdsList.IsEmpty then
          begin
            cdsList.Edit;
            cdsList.FieldByName('A').AsInteger :=1 ;
            cdsList.Post;
            btnOkClick(nil);
          end
       else
          edtSearch.SetFocus;
     end;
end;

procedure TframeListDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key<>VK_RETURN) and (Key<>VK_ESCAPE) and (Key<>VK_TAB) and (Key<>VK_SPACE) and (KEY<>VK_DOWN) and (KEY<>VK_UP) and (KEY<>VK_LEFT) and (KEY<>VK_RIGHT) and (Key<>0) then
     edtSearch.SetFocus
  else
     inherited;

end;

procedure TframeListDialog.edtSearchKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=VK_UP then cdsList.Prior;
  if Key=VK_DOWN then cdsList.Next;
  if Key=VK_RETURN then DBGridEh1.SetFocus;
end;

procedure TframeListDialog.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=13 then
     begin
       Key := 0;
       btnOkClick(nil);
     end;
  if Key=VK_SPACE then
     begin
       if MultiSelect then
          begin
            cdsList.Edit;
            cdsList.FieldbyName('A').AsInteger := 1;
            cdsList.Post;
          end
       else
          DBGridEh1DblClick(nil);
     end;
end;

procedure TframeListDialog.RzTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=13 then DBGridEh1.SetFocus;
end;

procedure TframeListDialog.ParserField(ListField: String);
var List:TStrings;
    Column:TColumnEh;
    i:Integer;
begin
  List := TStringList.create;
  try
    List.CommaText := ListField;
    for i:= DBGridEh1.Columns.Count -1 downto 1 do
        DBGridEh1.Columns[i];
    for i:=0 to List.Count -1 do
       begin
          if List.Count > 4 then
             DBGridEh1.AutoFitColWidths := false;
          Column := DbGridEh1.Columns.Add;
          if pos('=',List[i])=0 then
             Column.FieldName := List[i]
          else
            begin
              Column.FieldName := List.Names[i];
              Column.Title.Caption := List.ValueFromIndex[i];
            end;
          Column.ReadOnly := True;
          Column.Width := 100;
       end;
  finally
    List.Free;
  end;
end;

class function TframeListDialog.FindMDialog(AOwner:TForm;SQL, Fields: string;
  vList: TRecordList): boolean;
var rs:TRecord_;
begin
  with TframeListDialog.Create(AOwner) do
    begin
      try
        MultiSelect := True;
        ParserField(Fields);
        cdsList.Close;
        cdsList.SQL.Text := SQL;
        Factor.Open(cdsList);
        result := (ShowModal=MROK);
        if result then
           begin
             cdsList.First;
             while not cdsList.Eof do
               begin
                 rs := TRecord_.Create;
                 rs.ReadFromDataSet(cdsList);
                 vList.AddRecord(rs);
                 cdsList.Next;
               end;
           end;
      finally
        free;
      end;
    end;
end;

class function TframeListDialog.FindDialog(AOwner: TForm; SQL,
  Fields: string; AObj: TRecord_): boolean;
begin
  with TframeListDialog.Create(AOwner) do
    begin
      try
        MultiSelect := false;
        ParserField(Fields);
        cdsList.Close;
        cdsList.SQL.Text := SQL;
        Factor.Open(cdsList);
        result := (ShowModal=MROK);
        if result then
           begin
             AObj.ReadFromDataSet(cdsList);
           end;
      finally
        free;
      end;
    end;
end;

procedure TframeListDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close;
//  inherited;

end;

procedure TframeListDialog.N1Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        cdsList.FieldbyName('A').AsInteger := 1;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TframeListDialog.N2Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        if cdsList.FieldbyName('A').AsInteger = 0 then
           cdsList.FieldbyName('A').AsInteger := 1
        else
           cdsList.FieldbyName('A').AsInteger := 0;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TframeListDialog.N3Click(Sender: TObject);
var r:integer;
begin
  inherited;
  r := cdsList.RecNo;
  cdsList.DisableControls;
  try
    cdsList.First;
    while not cdsList.Eof do
      begin
        cdsList.Edit;
        cdsList.FieldbyName('A').AsInteger := 0;
        cdsList.Post;
        cdsList.Next;
      end;
  finally
    if r>0 then cdsList.RecNo := r;
    cdsList.EnableControls;
  end;
end;

procedure TframeListDialog.FormCreate(Sender: TObject);
begin
  inherited;
  N1.Enabled:=False;
  N2.Enabled:=False;
  N3.Enabled:=False;
end;

procedure TframeListDialog.cdsListFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if trim(edtSearch.Text)='' then Exit;
  Accept:=False;
  if (pos(trim(edtSearch.Text),DataSet[DBGridEh1.Columns[1].FieldName])>0) or (pos(uppercase(trim(edtSearch.Text)),DataSet[DBGridEh1.Columns[1].FieldName])>0)
          or (pos(trim(edtSearch.Text),DataSet[DBGridEh1.Columns[2].FieldName])>0) or (pos(uppercase(trim(edtSearch.Text)),DataSet[DBGridEh1.Columns[2].FieldName])>0)
          or (pos(trim(edtSearch.Text),DataSet[DBGridEh1.Columns[3].FieldName])>0) or (pos(uppercase(trim(edtSearch.Text)),DataSet[DBGridEh1.Columns[3].FieldName])>0) then
     Accept:=True
  else
    Accept:=False;
end;

procedure TframeListDialog.edtSearchPropertiesChange(Sender: TObject);
begin
  inherited;
  cdsList.Filtered:=False;  
  cdsList.Filtered:=True;
end;

procedure TframeListDialog.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='A' then
    N1Click(nil);
end;

end.
