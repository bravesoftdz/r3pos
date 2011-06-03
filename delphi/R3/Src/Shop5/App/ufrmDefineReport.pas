unit ufrmDefineReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGridEh, ZBase,
  RzButton, cxMaskEdit, cxDropDownEdit, cxControls, cxContainer, cxEdit,
  cxTextEdit, StdCtrls, RzLabel;

type
  TfrmDefineReport = class(TframeDialogForm)
    RzPanel3: TRzPanel;
    Label7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtREPORT_NAME: TcxTextEdit;
    edtREPORT_SPELL: TcxTextEdit;
    edtREPORT_TYPE: TcxComboBox;
    edtREPORT_SOURCE: TcxComboBox;
    btnSave: TRzBitBtn;
    btnExit: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    DsReport: TZQuery;
    DsReportTemplate: TZQuery;
    CdsReportTemplate: TDataSource;
    TabSheet2: TRzTabSheet;
    RzPanel5: TRzPanel;
    RzPanel1: TRzPanel;
    BtnAdd: TRzBitBtn;
    BtnDelete: TRzBitBtn;
    BtnUpRow: TRzBitBtn;
    BtnNextRow: TRzBitBtn;
    RzPanel4: TRzPanel;
    BtnAdd1: TRzBitBtn;
    BtnDelete1: TRzBitBtn;
    RzLabel7: TRzLabel;
    RzLabel1: TRzLabel;
    BtnRightRow: TRzBitBtn;
    BtnLeftRow: TRzBitBtn;
    DsReportTemplate1: TZQuery;
    CdsReportTemplate1: TDataSource;
    BtnUpRow1: TRzBitBtn;
    BtnDownRow1: TRzBitBtn;
    BtnRightRow1: TRzBitBtn;
    BtnLeftRow1: TRzBitBtn;
    DBGridEh2: TDBGridEh;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnExitClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtREPORT_NAMEPropertiesChange(Sender: TObject);
    procedure BtnUpRowClick(Sender: TObject);
    procedure BtnLeftRowClick(Sender: TObject);
    procedure BtnRightRowClick(Sender: TObject);
    procedure BtnNextRowClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure DBGridEh2DblClick(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh2Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure BtnAdd1Click(Sender: TObject);
    procedure BtnDelete1Click(Sender: TObject);
    procedure BtnUpRow1Click(Sender: TObject);
    procedure BtnDownRow1Click(Sender: TObject);
    procedure BtnLeftRow1Click(Sender: TObject);
    procedure BtnRightRow1Click(Sender: TObject);
    procedure DBGridEh1Columns2EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure DsReportTemplateAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    AObj:TRecord_;
    FColumnNum: Integer;
    FSQL: String;
    FRowNum: Integer;
    function ReturnSpace(Num:Integer):String;
    procedure SetColumnNum(const Value: Integer);
    procedure DbGridEh1FocusNextColumn;
    procedure DbGridEh2FocusNextColumn;
    function AnalysisField(FieldStr:String):String;
    procedure SetSQL(const Value: String);
    function FindColumn(Grid:TDBGridEh;FieldName:String):TColumnEh;
    procedure InitGrid;
    procedure SetRowNum(const Value: Integer);
    procedure SetColumn(Ds:TDataSet;C:Integer);
    procedure SetRow(Ds:TDataSet;R:Integer);
    procedure AnalysisData(Ds:TDataSet);
  public
    { Public declarations }
    procedure SetdbState(const Value: TDataSetState); override;
    procedure Append;
    procedure Open(Report_Id:String);
    procedure Edit(Report_Id:String);
    procedure Save;
    class function AddReport(Owner:TForm;Field_Name,Type_Id,Source_Id:String):Boolean;
    class function EditReport(Owner:TForm;Id,Field_Name:String):Boolean;
    class function DeleteReport(Owner:TForm;Id,Field_Name:String):Boolean;
    property ColumnNum:Integer read FColumnNum write SetColumnNum;
    property RowNum:Integer read FRowNum write SetRowNum;
    property SQL:String  read FSQL write SetSQL;
  end;

implementation
uses uShopUtil, uDsUtil, uFnUtil, uGlobal, uShopGlobal, uframeListDialog, ufrmBasic;
{$R *.dfm}

procedure TfrmDefineReport.Append;
begin
  Open('');
  dbState := dsInsert;
end;

procedure TfrmDefineReport.Edit(Report_Id: String);
begin
  Open(Report_Id);
  dbState := dsEdit;
end;

procedure TfrmDefineReport.Open(Report_Id: String);
var
  Params,Params1:TftParamList;
begin
  Params := TftParamList.Create(nil);
  Params1 := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('REPORT_ID').AsString := Report_Id;
    Params.ParamByName('CELL_TYPE').AsString := '1';

    Params1.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params1.ParamByName('REPORT_ID').AsString := Report_Id;
    Params1.ParamByName('CELL_TYPE').AsString := '2';
    Factor.BeginBatch;
    try
      Factor.AddBatch(DsReport,'TR3Report',Params);
      Factor.AddBatch(DsReportTemplate,'TReportTemplate',Params);
      Factor.AddBatch(DsReportTemplate1,'TReportTemplate',Params1);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    AObj.ReadFromDataSet(DsReport);
    ReadFromObject(AObj,Self);

    AnalysisData(DsReportTemplate);
    AnalysisData(DsReportTemplate1);

    if not DsReportTemplate.IsEmpty then
      begin
        DsReportTemplate.Last;
        ColumnNum := DsReportTemplate.FieldByName('COL').AsInteger;
      end;
    if not DsReportTemplate1.IsEmpty then
      begin
        DsReportTemplate1.Last;
        RowNum := DsReportTemplate.FieldByName('ROW').AsInteger;
      end;
  finally
    Params.Free;
    Params1.Free;
  end;
  dbState := dsBrowse;
end;

procedure TfrmDefineReport.Save;
begin
  WriteToObject(AObj,Self);
  AObj.WriteToDataSet(DsReport);

  if dbState = dsInsert then
    begin
      DsReport.Edit;
      DsReport.FieldByName('REPORT_ID').AsString := TSequence.NewId;
      DsReport.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      DsReport.Post;
    end;

  DsReportTemplate.DisableControls;
  DsReportTemplate1.DisableControls;
  try
    DsReportTemplate.First;
    while not DsReportTemplate.Eof do
      begin
        DsReportTemplate.Edit;
        DsReportTemplate.FieldByName('REPORT_ID').AsString := DsReport.FieldByName('REPORT_ID').AsString;
        DsReportTemplate.Post;
        DsReportTemplate.Next;
      end;

    DsReportTemplate1.First;
    while not DsReportTemplate1.Eof do
      begin
        DsReportTemplate1.Edit;
        DsReportTemplate1.FieldByName('REPORT_ID').AsString := DsReport.FieldByName('REPORT_ID').AsString;
        DsReportTemplate1.Post;
        DsReportTemplate1.Next;
      end;
  finally
    DsReportTemplate.EnableControls;
    DsReportTemplate1.EnableControls;
  end;

  Factor.BeginBatch;
  try
    Factor.AddBatch(DsReport,'TR3Report');
    Factor.AddBatch(DsReportTemplate,'TReportTemplate');
    Factor.AddBatch(DsReportTemplate1,'TReportTemplate');
    Factor.CommitBatch;
  except
    Factor.CancelBatch;
    Raise;
  end;
end;

procedure TfrmDefineReport.FormCreate(Sender: TObject);
begin
  inherited;
  AObj := TRecord_.Create;
end;

procedure TfrmDefineReport.FormDestroy(Sender: TObject);
begin
  inherited;
  AObj.Free;
end;

procedure TfrmDefineReport.RzBitBtn1Click(Sender: TObject);
var
  RecordList:TRecordList;
  Str_Sql,Str_Field:String;
begin
  inherited;
  RecordList := TRecordList.Create;
  Str_Sql := ' select 0 as A,CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''INDEX_TYPE'' ';
  Str_Field := '';
  try
    if TframeListDialog.FindMDialog(Self,Str_Sql,'CODE_NAME=DKJFDK',RecordList) then
      begin

      end;
  finally
    RecordList.Free;
  end;
end;

procedure TfrmDefineReport.BtnAddClick(Sender: TObject);
var
  RecordList:TRecordList;
  Record_1:TRecord_;
  Str_Sql: String;
  i,r,c:integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  RecordList := TRecordList.Create;
  Record_1 := TRecord_.Create;
  Str_Sql :=
  ' select 0 as A,CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''INDEX_TYPE'' '+
  ' union all '+
  ' select 0 as A,''TOTAL'' as CODE_ID,''合计'' as CODE_NAME '+
  ' union all '+
  ' select 0 as A,''FIELD'' as CODE_ID,''数据字段'' as CODE_NAME '+
  ' union all '+
  ' select * from ('+
  ' select 0 as A,CODE_ID,CODE_NAME from ( '+
  ' select j.CODE_ID,case when b.CODE_NAME is null then j.CODE_NAME else b.CODE_NAME end as CODE_NAME,case when b.SEQ_NO is null then 0 else b.SEQ_NO end as SEQ_NO from PUB_PARAMS j left outer join '+
  ' (select CODE_ID,CODE_NAME,SEQ_NO from  PUB_CODE_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and CODE_TYPE=''16'' ) b on j.CODE_ID=b.CODE_ID '+
  ' where j.TYPE_CODE=''SORT_TYPE'') '+
  ' g where not(CODE_NAME like ''自定义%'') order by SEQ_NO, cast(CODE_ID as int) '+
  ' ) ';
  try
    if TframeListDialog.FindMDialog(Self,Str_Sql,'CODE_NAME=指标名称',RecordList) then
      begin
        r := 0;
        c := ColumnNum + 1;
        ColumnNum := ColumnNum + 1;
        for i:=0 to RecordList.Count -1 do
          begin
            DsReportTemplate.Append;
            DsReportTemplate.FieldByName('ROWS_ID').AsString := TSequence.NewId;
            DsReportTemplate.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            DsReportTemplate.FieldByName('CELL_TYPE').AsString := '1';
            DsReportTemplate.FieldByName('SUM_TYPE').AsString := '1';
            if RecordList.Records[i].FieldByName('CODE_ID').AsString = 'TOTAL' then
              begin
                ColumnNum := ColumnNum + 1;
                DsReportTemplate.FieldByName('INDEX_FLAG').AsString := '5';
                DsReportTemplate.FieldByName('COL').AsInteger := ColumnNum;
                DsReportTemplate.FieldByName('ROW').AsInteger := 1;
                DsReportTemplate.FieldByName('SUB_FLAG').AsString := '1';
              end
            else if RecordList.Records[i].FieldByName('CODE_ID').AsString = 'FIELD' then
              begin
                ColumnNum := ColumnNum + 1;
                DsReportTemplate.FieldByName('INDEX_FLAG').AsString := '4';
                DsReportTemplate.FieldByName('COL').AsInteger := ColumnNum;
                DsReportTemplate.FieldByName('ROW').AsInteger := 1;
                DsReportTemplate.FieldByName('SUB_FLAG').AsString := '1';
              end
            else
              begin
                inc(r);
                DsReportTemplate.FieldByName('INDEX_FLAG').AsString := '2';
                DsReportTemplate.FieldByName('COL').AsInteger := c;
                DsReportTemplate.FieldByName('ROW').AsInteger := r;
                DsReportTemplate.FieldByName('SUB_FLAG').AsString := '2';
              end;
            DsReportTemplate.FieldByName('INDEX_ID').AsString := RecordList.Records[i].FieldbyName('CODE_ID').AsString;
            DsReportTemplate.FieldByName('DISPLAY_NAME').AsString := RecordList.Records[i].FieldbyName('CODE_NAME').AsString;
            DsReportTemplate.Post;
          end;
      end;
  finally
    RecordList.Free;
    Record_1.Free;
  end;
  if not DsReportTemplate.IsEmpty then BtnDelete.Enabled := True;
end;

class function TfrmDefineReport.AddReport(Owner: TForm;Field_Name,Type_Id,Source_Id:String): Boolean;
begin
  with TfrmDefineReport.Create(Owner) do
    begin
      try
        SQL := Field_Name;
        Append;
        edtREPORT_TYPE.ItemIndex := TdsItems.FindItems(edtREPORT_TYPE.Properties.Items,'CODE_ID',Type_Id);
        edtREPORT_SOURCE.ItemIndex := TdsItems.FindItems(edtREPORT_SOURCE.Properties.Items,'CODE_ID',Source_Id);
        Result := ShowModal = mrOk;
      finally
        Free;
      end;
    end;
end;

procedure TfrmDefineReport.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
    StrPlace:String;
begin
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(DsReportTemplate.RecNo)),length(Inttostr(DsReportTemplate.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;

  if Column.FieldName = 'DISPLAY_NAME' then
    begin
      if DsReportTemplate.FieldByName('ROW').AsInteger <> 0 then
      begin
        ARect :=  Rect;
        StrPlace := ReturnSpace(DsReportTemplate.FieldbyName('ROW').AsInteger)+DsReportTemplate.FieldbyName('DISPLAY_NAME').AsString;
        DbGridEh1.canvas.FillRect(ARect);
        DrawText(DbGridEh1.Canvas.Handle,pchar(StrPlace),length(StrPlace),ARect,DT_NOCLIP or DT_SINGLELINE or DT_LEFT or DT_LEFT);
      end;
    end;
end;

function TfrmDefineReport.ReturnSpace(Num: Integer): String;
var i:Integer;
begin
  for i := 0 to (Num-1)*4 do
    begin
      Result := Result + ' ';
    end;
end;

procedure TfrmDefineReport.SetColumnNum(const Value: Integer);
begin
  FColumnNum := Value;
end;

procedure TfrmDefineReport.btnExitClick(Sender: TObject);
begin
  inherited;
  if btnExit.Tag = 0 then
    Close
  else if btnExit.Tag = 1 then
    begin
      if DsReport.IsEmpty then Exit;
      DsReport.Delete;

      DsReportTemplate.First;
      while not DsReportTemplate.Eof do DsReportTemplate.Delete;

      DsReportTemplate1.First;
      while not DsReportTemplate1.Eof do DsReportTemplate1.Delete;

      Factor.BeginBatch;
      try
        Factor.AddBatch(DsReport,'TR3Report');
        Factor.AddBatch(DsReportTemplate,'TReportTemplate');
        Factor.AddBatch(DsReportTemplate1,'TReportTemplate');
        Factor.CommitBatch;
      except
        Factor.CancelBatch;
        Raise;
      end;
      ModalResult := mrOk;
    end;
end;

procedure TfrmDefineReport.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Trim(edtREPORT_NAME.Text) = '' then
    begin
      if edtREPORT_NAME.CanFocus then edtREPORT_NAME.SetFocus;
      Raise Exception.Create('报表名称不能为空!');
    end;

  if Trim(edtREPORT_SPELL.Text) = '' then
    begin
      if edtREPORT_SPELL.CanFocus then edtREPORT_SPELL.SetFocus;
      Raise Exception.Create('拼音码不能为空!');
    end;

  DsReportTemplate.First;
  while not DsReportTemplate.Eof do
    begin
      if DsReportTemplate.FieldByName('DISPLAY_NAME').AsString = '' then
        begin
          Raise Exception.Create('在"表头行"页中显示名不能为空!');
        end;
      if DsReportTemplate.FieldByName('FIELD_NAME').AsString = '' then
        begin
          Raise Exception.Create('在"表头行"页中数据字段不能为空!');
        end;
      if DsReportTemplate.FieldByName('INDEX_ID').AsString = '' then
        begin
          Raise Exception.Create('在"表头行"页中指标名不能为空!');
        end;
      if DsReportTemplate.FieldByName('SUM_TYPE').AsString = '' then
        begin
          Raise Exception.Create('在"表头行"页中汇总类型不能为空!');
        end;
      if DsReportTemplate.FieldByName('INDEX_FLAG').AsString = '' then
        begin
          Raise Exception.Create('在"表头行"页中指标类型不能为空!');
        end;
      DsReportTemplate.Next;
    end;

  DsReportTemplate1.First;
  while not DsReportTemplate1.Eof do
    begin
      if DsReportTemplate1.FieldByName('DISPLAY_NAME').AsString = '' then
        begin
          Raise Exception.Create('在"数据行"页中显示名不能为空!');
        end;
      if DsReportTemplate1.FieldByName('INDEX_FLAG').AsString = '' then
        begin
          Raise Exception.Create('在"数据行"页中指标类型不能为空!');
        end;
      DsReportTemplate1.Next;
    end;
  Save;
  ModalResult := mrOk;
end;

procedure TfrmDefineReport.DbGridEh1FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh1.Col;
  Inc(i);
  while True do
    begin
      if i>=DbGridEh1.Columns.Count then i:= 1;
      if (DbGridEh1.Columns[i].ReadOnly or not DbGridEh1.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(DsReportTemplate.FieldbyName('ROWS_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(DsReportTemplate.FieldbyName('ROWS_ID').asString)<>'') then
              begin
                 DsReportTemplate.Next ;
                 {if DsReportTemplate.Eof then
                    begin
                      InitRecord;
                    end;}
                 DbGridEh1.SetFocus;
                 DbGridEh1.Col := 1 ;
              end
           else
              DbGridEh1.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmDefineReport.DbGridEh2FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh2.Col;
  Inc(i);
  while True do
    begin
      if i>=DbGridEh2.Columns.Count then i:= 1;
      if (DbGridEh2.Columns[i].ReadOnly or not DbGridEh2.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if Trim(DsReportTemplate.FieldbyName('ROWS_ID').asString)='' then
              i := 1;
           if (i=1) and (Trim(DsReportTemplate.FieldbyName('ROWS_ID').asString)<>'') then
              begin
                 DsReportTemplate.Next ;
                 {if DsReportTemplate.Eof then
                    begin
                      InitRecord;
                    end;}
                 DbGridEh2.SetFocus;
                 DbGridEh2.Col := 1 ;
              end
           else
              DbGridEh2.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmDefineReport.SetdbState(const Value: TDataSetState);
begin
  inherited;
  btnSave.Visible := (Value<>dsBrowse);
  case Value of
    dsInsert:Caption := '自定义报表--(新增)';
    dsEdit:Caption := '自定义报表--(修改)';
  else
    Caption := '自定义报表';
  end;
end;

class function TfrmDefineReport.EditReport(Owner: TForm; Id,
  Field_Name: String): Boolean;
begin
  with TfrmDefineReport.Create(Owner) do
    begin
      try
        SQL := Field_Name;
        Edit(Id);
        Result := ShowModal = mrOk;
      finally
        Free;
      end;
    end;
end;

function TfrmDefineReport.AnalysisField(FieldStr: String): String;
var VList:TStringList;
    i:Integer;
    Sql_Str:String;
begin
  if Trim(FieldStr) = '' then
  begin
    Result := '';
    Exit;
  end;
  Sql_Str := '';
  VList := TStringList.Create;
  try
    VList.CommaText := FieldStr;
    for i := 0 to VList.Count - 1 do
      begin
        if Sql_Str = '' then
          begin
            Sql_Str := ' select 0 as A,'''+VList.Names[i]+''' as CODE_ID,'''+VList.ValueFromIndex[i]+''' as CODE_NAME ';
          end
        else
          begin
            Sql_Str := Sql_Str + ' union all select 0 as A,'''+VList.Names[i]+''' as CODE_ID,'''+VList.ValueFromIndex[i]+''' as CODE_NAME ';
          end;
      end;
  finally
    VList.Free;
  end;
  Result := Sql_Str;
end;

procedure TfrmDefineReport.SetSQL(const Value: String);
begin
  //FSQL := Value;
  FSQL := AnalysisField(Value);
end;

procedure TfrmDefineReport.edtREPORT_NAMEPropertiesChange(Sender: TObject);
begin
  inherited;
  edtREPORT_SPELL.Text := FnString.GetWordSpell(edtREPORT_NAME.Text);
end;

procedure TfrmDefineReport.BtnUpRowClick(Sender: TObject);
var
  ROWS_ID,ROWS_ID1:String;
  CURCOL,MINCOL,COL1:Integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;  
  if DsReportTemplate.IsEmpty then Exit;
  if DsReportTemplate.RecordCount = 1 then Exit;
  if DsReportTemplate.RecNo = 1 then Exit;
  if DsReportTemplate.FieldByName('COL').AsInteger = 1 then Exit;
  
  CURCOL := DsReportTemplate.FieldByName('COL').AsInteger;
  MINCOL := 1;
  if DsReportTemplate.State in [dsEdit,dsInsert] then DsReportTemplate.Post;

  DsReportTemplate.DisableControls;
  DsReportTemplate.SortedFields := 'ROWS_ID';
  try
  if CURCOL > MINCOL then
    Begin
    DsReportTemplate.First;
    while not DsReportTemplate.Eof do
      begin
        if DsReportTemplate.FieldByName('COL').AsInteger = CURCOL then
          begin
            DsReportTemplate.Edit;
            DsReportTemplate.FieldByName('COL').AsInteger := 0;
            DsReportTemplate.Post;
          end;
        DsReportTemplate.Next;
      end;

    DsReportTemplate.First;
    while not DsReportTemplate.Eof do
      begin
        if DsReportTemplate.FieldByName('COL').AsInteger = CURCOL-1 then
          begin
            DsReportTemplate.Edit;
            DsReportTemplate.FieldByName('COL').AsInteger := CURCOL;
            DsReportTemplate.Post;
          end;
        DsReportTemplate.Next;
      end;

    DsReportTemplate.First;
    while not DsReportTemplate.Eof do
      begin
        if DsReportTemplate.FieldByName('COL').AsInteger = 0 then
          begin
            DsReportTemplate.Edit;
            DsReportTemplate.FieldByName('COL').AsInteger := CURCOL-1;
            DsReportTemplate.Post;
          end;
        DsReportTemplate.Next;
      end;
    end
  else
    Exit;
  finally
    DsReportTemplate.SortedFields := 'COL;ROW';
    DsReportTemplate.EnableControls;
  end;
end;

procedure TfrmDefineReport.BtnLeftRowClick(Sender: TObject);
var
  ROWS_ID,ROWS_ID1:String;
  ROW,ROW1,COL,COL1:Integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if DsReportTemplate.IsEmpty then Exit;
  if DsReportTemplate.RecordCount = 1 then Exit;
  if DsReportTemplate.RecNo = 1 then Exit;
  if DsReportTemplate.FieldByName('ROW').AsInteger = 1 then Exit;
  if DsReportTemplate.State in [dsEdit,dsInsert] then DsReportTemplate.Post;

  ROW := DsReportTemplate.FieldByName('ROW').AsInteger;
  ROWS_ID := DsReportTemplate.FieldByName('ROWS_ID').AsString;
  DsReportTemplate.Prior;
  ROW1 := DsReportTemplate.FieldByName('ROW').AsInteger;
  ROWS_ID1 := DsReportTemplate.FieldByName('ROWS_ID').AsString;

  if DsReportTemplate.Locate('ROWS_ID',ROWS_ID1,[]) then
    begin
      DsReportTemplate.Edit;
      DsReportTemplate.FieldByName('ROW').AsInteger := ROW;
      DsReportTemplate.Post;
    end;
  if DsReportTemplate.Locate('ROWS_ID',ROWS_ID,[]) then
    begin
      DsReportTemplate.Edit;
      DsReportTemplate.FieldByName('ROW').AsInteger := ROW1;
      DsReportTemplate.Post;
    end;
  //DsReportTemplate.IndexFieldNames := 'DISPLAY_NAME';
end;

procedure TfrmDefineReport.BtnRightRowClick(Sender: TObject);
var
  ROWS_ID,ROWS_ID1:String;
  ROW,ROW1,COL,COL1:Integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if DsReportTemplate.IsEmpty then Exit;
  if DsReportTemplate.RecordCount = 1 then Exit;

  DsReportTemplate.DisableControls;
  try
    COL := DsReportTemplate.FieldByName('COL').AsInteger;
    ROW := DsReportTemplate.FieldByName('ROW').AsInteger;
    ROWS_ID := DsReportTemplate.FieldByName('ROWS_ID').AsString;

    DsReportTemplate.Next;
    COL1 := DsReportTemplate.FieldByName('COL').AsInteger;
    ROW1 := DsReportTemplate.FieldByName('ROW').AsInteger;
    ROWS_ID1 := DsReportTemplate.FieldByName('ROWS_ID').AsString;

    if COL <> COL1 then
      begin
        DsReportTemplate.Locate('ROWS_ID',ROWS_ID,[]);
        Exit;
      end;
    if DsReportTemplate.State in [dsEdit,dsInsert] then DsReportTemplate.Post;

    if DsReportTemplate.Locate('ROWS_ID',ROWS_ID1,[]) then
      begin
        DsReportTemplate.Edit;
        DsReportTemplate.FieldByName('ROW').AsInteger := ROW;
        DsReportTemplate.Post;
      end;
    if DsReportTemplate.Locate('ROWS_ID',ROWS_ID,[]) then
      begin
        DsReportTemplate.Edit;
        DsReportTemplate.FieldByName('ROW').AsInteger := ROW1;
        DsReportTemplate.Post;
      end;
  finally
    DsReportTemplate.EnableControls;
  end;
  //DsReportTemplate.IndexFieldNames := 'DISPLAY_NAME';
end;

procedure TfrmDefineReport.BtnNextRowClick(Sender: TObject);
var
  ROWS_ID,ROWS_ID1:String;
  CURCOL,MAXCOL,COL1:Integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if DsReportTemplate.IsEmpty then Exit;
  //if DsReportTemplate.RecordCount = DsReportTemplate.RecNo then Exit;

  if DsReportTemplate.State in [dsEdit,dsInsert] then DsReportTemplate.Post;

  CURCOL := DsReportTemplate.FieldByName('COL').AsInteger;
  DsReportTemplate.Last;
  MAXCOL := DsReportTemplate.FieldByName('COL').AsInteger;

  DsReportTemplate.DisableControls;
  DsReportTemplate.SortedFields := 'ROWS_ID';
  try
    if CURCOL < MAXCOL then
      Begin
        DsReportTemplate.First;
        while not DsReportTemplate.Eof do
          begin
            if DsReportTemplate.FieldByName('COL').AsInteger = CURCOL then
              begin
                DsReportTemplate.Edit;
                DsReportTemplate.FieldByName('COL').AsInteger := 0;
                DsReportTemplate.Post;
              end;
            DsReportTemplate.Next;
          end;

        DsReportTemplate.First;
        while not DsReportTemplate.Eof do
          begin
            if DsReportTemplate.FieldByName('COL').AsInteger = CURCOL + 1 then
              begin
                DsReportTemplate.Edit;
                DsReportTemplate.FieldByName('COL').AsInteger := CURCOL;
                DsReportTemplate.Post;
              end;
            DsReportTemplate.Next;
          end;

        DsReportTemplate.First;
        while not DsReportTemplate.Eof do
          begin
            if DsReportTemplate.FieldByName('COL').AsInteger = 0 then
              begin
                DsReportTemplate.Edit;
                DsReportTemplate.FieldByName('COL').AsInteger := CURCOL+1;
                DsReportTemplate.Post;
              end;
            DsReportTemplate.Next;
          end;
      end
    else
      Exit;
  finally
    DsReportTemplate.SortedFields := 'COL;ROW';    
    DsReportTemplate.EnableControls;
  end;
end;

procedure TfrmDefineReport.BtnDeleteClick(Sender: TObject);
var CurRow,CurCol:Integer;
    IsExist:Boolean;
begin
  inherited;
  if DsReportTemplate.IsEmpty then Exit;
  if dbState = dsBrowse then Exit;
  if MessageBox(Handle,pchar('确认要删除"'+DsReportTemplate.FieldbyName('DISPLAY_NAME').AsString+'"吗？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  CurRow := DsReportTemplate.FieldByName('ROW').AsInteger;
  CurCol := DsReportTemplate.FieldByName('COL').AsInteger;
  DsReportTemplate.Delete;
  if DsReportTemplate.State in [dsEdit,dsInsert] then DsReportTemplate.Post;
  //删除后重新排序
  DsReportTemplate.DisableControls;
  DsReportTemplate.SortedFields := 'ROWS_ID';
  try
    IsExist := True;
    DsReportTemplate.First;
    while not DsReportTemplate.Eof do
    begin
      if (DsReportTemplate.FieldByName('COL').AsInteger = CurCol) and (DsReportTemplate.FieldByName('ROW').AsInteger > CurRow) then
        begin
          DsReportTemplate.Edit;
          DsReportTemplate.FieldByName('ROW').AsInteger := DsReportTemplate.FieldByName('ROW').AsInteger-1;
          DsReportTemplate.Post;
        end;
      DsReportTemplate.Next;
    end;
    DsReportTemplate.Filtered := False;
    DsReportTemplate.Filter := ' COL='+IntToStr(CurCol);
    DsReportTemplate.Filtered := True;
    if DsReportTemplate.RecordCount > 0 then IsExist := False;
    DsReportTemplate.Filtered := False;
    if IsExist and (not DsReportTemplate.IsEmpty) then
      SetColumn(DsReportTemplate,CurCol);
  finally
    DsReportTemplate.EnableControls;
    DsReportTemplate.SortedFields := 'COL;ROW';
  end;
  //btnSave.Enabled:=True;
  //删除记录后，如果没有记录了，删除按钮不能操作
  if DsReportTemplate.IsEmpty then
  begin
    BtnDelete.Enabled := False;
    ColumnNum := 0;
  end;
end;

procedure TfrmDefineReport.DBGridEh2DblClick(Sender: TObject);
var
  RecordList:TRecordList;
  Str_Sql: String;
  i,r:integer;
begin
  inherited;
  if DsReportTemplate1.IsEmpty then Exit;
  RecordList := TRecordList.Create;
  Str_Sql := SQL;
  try
    if TframeListDialog.FindMDialog(Self,Str_Sql,'CODE_NAME=数据字段名',RecordList) then
      begin
        Str_Sql := '';
        for i:=0 to RecordList.Count -1 do
          begin
            if Str_Sql = '' then
              Str_Sql := RecordList.Records[i].FieldByName('CODE_NAME').AsString
            else
              Str_Sql := Str_Sql + ',' + RecordList.Records[i].FieldByName('CODE_NAME').AsString;
          end;
        DsReportTemplate1.Edit;
        DsReportTemplate1.FieldByName('FIELD_NAME').AsString := Str_Sql;
        DsReportTemplate1.Post;
      end;
  finally
    RecordList.Free;
  end;
end;

procedure TfrmDefineReport.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
    StrPlace:String;
begin
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(DsReportTemplate1.RecNo)),length(Inttostr(DsReportTemplate1.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;

  if Column.FieldName = 'DISPLAY_NAME' then
    begin
      if DsReportTemplate1.FieldByName('COL').AsInteger <> 0 then
      begin
        ARect :=  Rect;
        StrPlace := ReturnSpace(DsReportTemplate1.FieldbyName('COL').AsInteger)+DsReportTemplate1.FieldbyName('DISPLAY_NAME').AsString;
        DBGridEh2.canvas.FillRect(ARect);
        DrawText(DBGridEh2.Canvas.Handle,pchar(StrPlace),length(StrPlace),ARect,DT_NOCLIP or DT_SINGLELINE or DT_LEFT or DT_LEFT);
      end;
    end;
end;

procedure TfrmDefineReport.FormShow(Sender: TObject);
begin
  inherited;
  InitGrid;
  RzPage.ActivePageIndex := 0;
end;

function TfrmDefineReport.FindColumn(Grid: TDBGridEh;
  FieldName: String): TColumnEh;
var i:Integer;
begin
  for i := 0 to Grid.Columns.Count - 1 do
    begin
      if Grid.Columns[i].FieldName = FieldName then
        begin
          Result := Grid.Columns[i];
          Exit;
        end;
    end;
end;

procedure TfrmDefineReport.InitGrid;
var Col:TColumnEh;
    rs:TZQuery;
begin
  rs := Global.GetZQueryFromName('PUB_PARAMS');

  Col := FindColumn(DBGridEh1,'SUM_TYPE');
  if Col <> nil then
  begin
    rs.Filtered := False;
    rs.Filter := ' TYPE_CODE=''SUM_TYPE'' ';
    rs.Filtered := True;
    
    Col.KeyList.Clear;
    Col.PickList.Clear;
    rs.First;
    while not rs.Eof do
      begin
        Col.KeyList.Add(rs.FieldbyName('CODE_ID').AsString);
        Col.PickList.Add(rs.FieldByName('CODE_NAME').AsString);
        rs.Next;
      end;
  end;

  Col := FindColumn(DBGridEh1,'INDEX_FLAG');
  if Col <> nil then
    begin
      rs.Filtered := False;
      rs.Filter := ' TYPE_CODE=''INDEX_FLAG'' ';
      rs.Filtered := True;

      Col.KeyList.Clear;
      Col.PickList.Clear;
      rs.First;
      while not rs.Eof do
        begin
          Col.KeyList.Add(rs.FieldByName('CODE_ID').AsString);
          Col.PickList.Add(rs.FieldByName('CODE_NAME').AsString);
          rs.Next;
        end;
    end;

  Col := FindColumn(DBGridEh1,'SUB_FLAG');
  if Col <> nil then
    begin
      Col.KeyList.Clear;
      Col.PickList.Clear;
      Col.KeyList.Add('2');
      Col.KeyList.Add('1');
    end;
end;

procedure TfrmDefineReport.DBGridEh2CellClick(Column: TColumnEh);
var
  RecordList:TRecordList;
  Str_Sql: String;
  i,r:integer;
begin
  inherited;
  if DsReportTemplate1.IsEmpty then Exit;
  if Column.FieldName <> 'FIELD_NAME' then Exit; 
  RecordList := TRecordList.Create;
  Str_Sql := SQL;
  try
    if TframeListDialog.FindMDialog(Self,Str_Sql,'CODE_NAME=数据字段名',RecordList) then
      begin
        Str_Sql := '';
        for i:=0 to RecordList.Count -1 do
          begin
            if Str_Sql = '' then
              Str_Sql := RecordList.Records[i].FieldByName('CODE_NAME').AsString
            else
              Str_Sql := Str_Sql + ',' + RecordList.Records[i].FieldByName('CODE_NAME').AsString;
          end;
        DsReportTemplate1.Edit;
        DsReportTemplate1.FieldByName('FIELD_NAME').AsString := Str_Sql;
        DsReportTemplate1.Post;
      end;
  finally
    RecordList.Free;
  end;
end;

procedure TfrmDefineReport.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var ROWS_ID,SUMTYPE:String;
    COL:Integer;
begin
  inherited;
  ROWS_ID := DsReportTemplate.FieldByName('ROWS_ID').AsString;
  COL := DsReportTemplate.FieldByName('COL').AsInteger;
  SUMTYPE := Value;
  DsReportTemplate.First;
  while not DsReportTemplate.Eof do
    begin
      if DsReportTemplate.FieldByName('COL').AsInteger = COL then
        begin
          DsReportTemplate.Edit;
          DsReportTemplate.FieldByName('SUM_TYPE').AsString := SUMTYPE;
          DsReportTemplate.Post;
        end;
      DsReportTemplate.Next;
    end;
  if DsReportTemplate.Locate('ROWS_ID',ROWS_ID,[]) then DsReportTemplate.Edit;
end;

procedure TfrmDefineReport.DBGridEh2Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var ROWS_ID,SUMTYPE:String;
    COL:Integer;
begin
  inherited;
  ROWS_ID := DsReportTemplate1.FieldByName('ROWS_ID').AsString;
  COL := DsReportTemplate1.FieldByName('COL').AsInteger;
  SUMTYPE := Value;
  DsReportTemplate1.First;
  while not DsReportTemplate1.Eof do
    begin
      if DsReportTemplate1.FieldByName('COL').AsInteger = COL then
        begin
          DsReportTemplate1.Edit;
          DsReportTemplate1.FieldByName('SUM_TYPE').AsString := SUMTYPE;
          DsReportTemplate1.Post;
        end;
      DsReportTemplate1.Next;
    end;
  if DsReportTemplate1.Locate('ROWS_ID',ROWS_ID,[]) then DsReportTemplate1.Edit;
end;

procedure TfrmDefineReport.BtnAdd1Click(Sender: TObject);
var
  RecordList:TRecordList;
  Str_Sql: String;
  i,c:integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  RecordList := TRecordList.Create;
  Str_Sql :=
  ' select 0 as A,CODE_ID,CODE_NAME from PUB_PARAMS where TYPE_CODE=''INDEX_TYPE'' '+
  ' union all '+
  ' select * from ('+
  ' select 0 as A,CODE_ID,CODE_NAME from ( '+
  ' select j.CODE_ID,case when b.CODE_NAME is null then j.CODE_NAME else b.CODE_NAME end as CODE_NAME,case when b.SEQ_NO is null then 0 else b.SEQ_NO end as SEQ_NO from PUB_PARAMS j left outer join '+
  ' (select CODE_ID,CODE_NAME,SEQ_NO from  PUB_CODE_INFO where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and CODE_TYPE=''16'' ) b on j.CODE_ID=b.CODE_ID '+
  ' where j.TYPE_CODE=''SORT_TYPE'') '+
  ' g where not(CODE_NAME like ''自定义%'') order by SEQ_NO, cast(CODE_ID as int) '+
  ' ) ';
  try
    if TframeListDialog.FindMDialog(Self,Str_Sql,'CODE_NAME=指标名称',RecordList) then
      begin
        c := 0;
        RowNum := RowNum + 1;
        for i:=0 to RecordList.Count -1 do
          begin
            inc(c);
            DsReportTemplate1.Append;
            DsReportTemplate1.FieldByName('ROWS_ID').AsString := TSequence.NewId;
            DsReportTemplate1.FieldByName('TENANT_ID').AsInteger := Global.TENANT_ID;
            DsReportTemplate1.FieldByName('CELL_TYPE').AsString := '2';
            DsReportTemplate1.FieldByName('COL').AsInteger := c;
            DsReportTemplate1.FieldByName('ROW').AsInteger := RowNum;
            DsReportTemplate1.FieldByName('SUM_TYPE').AsString := '#';   
            DsReportTemplate1.FieldByName('FIELD_NAME').AsString := '#';
            DsReportTemplate1.FieldByName('INDEX_FLAG').AsString := '2';
            DsReportTemplate1.FieldByName('INDEX_ID').AsString := RecordList.Records[i].FieldbyName('CODE_ID').AsString;
            DsReportTemplate1.FieldByName('DISPLAY_NAME').AsString := RecordList.Records[i].FieldbyName('CODE_NAME').AsString;
            DsReportTemplate1.Post;
          end;
      end;
  finally
    RecordList.Free;
  end;
  if not DsReportTemplate1.IsEmpty then BtnDelete1.Enabled := True;
end;

procedure TfrmDefineReport.SetRowNum(const Value: Integer);
begin
  FRowNum := Value;
end;

procedure TfrmDefineReport.BtnDelete1Click(Sender: TObject);
var CurRow,CurCol:Integer;
    IsExist:Boolean;
begin
  inherited;
  if DsReportTemplate1.IsEmpty then Exit;
  if dbState = dsBrowse then Exit;
  if MessageBox(Handle,pchar('确认要删除"'+DsReportTemplate.FieldbyName('DISPLAY_NAME').AsString+'"吗？'),pchar(application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  CurRow := DsReportTemplate1.FieldByName('ROW').AsInteger;
  CurCol := DsReportTemplate1.FieldByName('COL').AsInteger;
  DsReportTemplate1.Delete;
  if DsReportTemplate1.State in [dsEdit,dsInsert] then DsReportTemplate1.Post;
  //删除后重新排序
  DsReportTemplate1.DisableControls;
  DsReportTemplate1.SortedFields := 'ROWS_ID';
  try
    IsExist := True;
    DsReportTemplate1.First;
    while not DsReportTemplate1.Eof do
    begin
      if (DsReportTemplate1.FieldByName('COL').AsInteger > CurCol) and (DsReportTemplate1.FieldByName('ROW').AsInteger = CurRow) then
        begin
          DsReportTemplate1.Edit;
          DsReportTemplate1.FieldByName('COL').AsInteger := DsReportTemplate1.FieldByName('COL').AsInteger-1;
          DsReportTemplate1.Post;
        end;
      DsReportTemplate1.Next;
    end;
    DsReportTemplate1.Filtered := False;
    DsReportTemplate1.Filter := ' ROW='+IntToStr(CurRow);
    DsReportTemplate1.Filtered := True;
    if DsReportTemplate1.RecordCount > 0 then IsExist := False;
    DsReportTemplate1.Filtered := False;
    if IsExist and (not DsReportTemplate1.IsEmpty) then
      SetRow(DsReportTemplate1,CurRow);
  finally
    DsReportTemplate1.EnableControls;
    DsReportTemplate1.SortedFields := 'ROW;COL';
  end;
  //btnSave.Enabled:=True;
  //删除记录后，如果没有记录了，删除按钮不能操作
  if DsReportTemplate1.IsEmpty then
  begin
    BtnDelete1.Enabled := False;
  end;
end;

procedure TfrmDefineReport.BtnUpRow1Click(Sender: TObject);
var
  ROWS_ID,ROWS_ID1:String;
  CURROW,MINROW,ROW1:Integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if DsReportTemplate1.IsEmpty then Exit;
  if DsReportTemplate1.RecordCount = 1 then Exit;
  if DsReportTemplate1.RecNo = 1 then Exit;
  if DsReportTemplate1.FieldByName('ROW').AsInteger = 1 then Exit;
  CURROW := DsReportTemplate1.FieldByName('ROW').AsInteger;
  MINROW := 1;
  if DsReportTemplate1.State in [dsEdit,dsInsert] then DsReportTemplate1.Post;

  DsReportTemplate1.DisableControls;
  DsReportTemplate1.SortedFields := 'ROWS_ID';
  try
  if CURROW > MINROW then
    Begin
    DsReportTemplate1.First;
    while not DsReportTemplate1.Eof do
      begin
        if DsReportTemplate1.FieldByName('ROW').AsInteger = CURROW then
          begin
            DsReportTemplate1.Edit;
            DsReportTemplate1.FieldByName('ROW').AsInteger := 0;
            DsReportTemplate1.Post;
          end;
        DsReportTemplate1.Next;
      end;

    DsReportTemplate1.First;
    while not DsReportTemplate1.Eof do
      begin
        if DsReportTemplate1.FieldByName('ROW').AsInteger = CURROW-1 then
          begin
            DsReportTemplate1.Edit;
            DsReportTemplate1.FieldByName('ROW').AsInteger := CURROW;
            DsReportTemplate1.Post;
          end;
        DsReportTemplate1.Next;
      end;

    DsReportTemplate1.First;
    while not DsReportTemplate1.Eof do
      begin
        if DsReportTemplate1.FieldByName('ROW').AsInteger = 0 then
          begin
            DsReportTemplate1.Edit;
            DsReportTemplate1.FieldByName('ROW').AsInteger := CURROW-1;
            DsReportTemplate1.Post;
          end;
        DsReportTemplate1.Next;
      end;
    end
  else
    Exit;
  finally
    DsReportTemplate1.SortedFields := 'ROW;COL';
    DsReportTemplate1.EnableControls;
  end;
end;

procedure TfrmDefineReport.BtnDownRow1Click(Sender: TObject);
var
  ROWS_ID,ROWS_ID1:String;
  CURROW,MAXROW,ROW1:Integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if DsReportTemplate1.IsEmpty then Exit;
  //if DsReportTemplate.RecordCount = DsReportTemplate.RecNo then Exit;

  if DsReportTemplate1.State in [dsEdit,dsInsert] then DsReportTemplate1.Post;

  CURROW := DsReportTemplate1.FieldByName('ROW').AsInteger;
  DsReportTemplate1.Last;
  MAXROW := DsReportTemplate1.FieldByName('ROW').AsInteger;

  DsReportTemplate1.DisableControls;
  DsReportTemplate1.SortedFields := 'ROWS_ID';
  try
    if CURROW < MAXROW then
      Begin
        DsReportTemplate1.First;
        while not DsReportTemplate1.Eof do
          begin
            if DsReportTemplate1.FieldByName('ROW').AsInteger = CURROW then
              begin
                DsReportTemplate1.Edit;
                DsReportTemplate1.FieldByName('ROW').AsInteger := 0;
                DsReportTemplate1.Post;
              end;
            DsReportTemplate1.Next;
          end;

        DsReportTemplate1.First;
        while not DsReportTemplate1.Eof do
          begin
            if DsReportTemplate1.FieldByName('ROW').AsInteger = CURROW + 1 then
              begin
                DsReportTemplate1.Edit;
                DsReportTemplate1.FieldByName('ROW').AsInteger := CURROW;
                DsReportTemplate1.Post;
              end;
            DsReportTemplate1.Next;
          end;

        DsReportTemplate1.First;
        while not DsReportTemplate1.Eof do
          begin
            if DsReportTemplate1.FieldByName('ROW').AsInteger = 0 then
              begin
                DsReportTemplate1.Edit;
                DsReportTemplate1.FieldByName('ROW').AsInteger := CURROW+1;
                DsReportTemplate1.Post;
              end;
            DsReportTemplate1.Next;
          end;
      end
    else
      Exit;
  finally
    DsReportTemplate1.SortedFields := 'ROW;COL';
    DsReportTemplate1.EnableControls;
  end;
end;

procedure TfrmDefineReport.BtnLeftRow1Click(Sender: TObject);
var
  ROWS_ID,ROWS_ID1:String;
  ROW,ROW1,COL,COL1:Integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if DsReportTemplate1.IsEmpty then Exit;
  if DsReportTemplate1.RecordCount = 1 then Exit;
  if DsReportTemplate1.RecNo = 1 then Exit;
  if DsReportTemplate1.FieldByName('COL').AsInteger = 1 then Exit;
  if DsReportTemplate1.State in [dsEdit,dsInsert] then DsReportTemplate1.Post;

  COL := DsReportTemplate1.FieldByName('COL').AsInteger;
  ROW := DsReportTemplate1.FieldByName('ROW').AsInteger;
  ROWS_ID := DsReportTemplate1.FieldByName('ROWS_ID').AsString;
  DsReportTemplate1.Prior;
  COL1 := DsReportTemplate1.FieldByName('COL').AsInteger;
  ROW1 := DsReportTemplate1.FieldByName('ROW').AsInteger;
  ROWS_ID1 := DsReportTemplate1.FieldByName('ROWS_ID').AsString;

  if ROW <> ROW1 then
    begin
      DsReportTemplate1.Locate('ROWS_ID',ROWS_ID,[]);
      Exit;
    end;

  if DsReportTemplate1.Locate('ROWS_ID',ROWS_ID1,[]) then
    begin
      DsReportTemplate1.Edit;
      DsReportTemplate1.FieldByName('COL').AsInteger := COL;
      DsReportTemplate1.Post;
    end;
    
  if DsReportTemplate1.Locate('ROWS_ID',ROWS_ID,[]) then
    begin
      DsReportTemplate1.Edit;
      DsReportTemplate1.FieldByName('COL').AsInteger := COL1;
      DsReportTemplate1.Post;
    end;
end;

procedure TfrmDefineReport.BtnRightRow1Click(Sender: TObject);
var
  ROWS_ID,ROWS_ID1:String;
  ROW,ROW1,COL,COL1:Integer;
begin
  inherited;
  if dbState = dsBrowse then Exit;
  if DsReportTemplate1.IsEmpty then Exit;
  if DsReportTemplate1.RecordCount = 1 then Exit;

  DsReportTemplate1.DisableControls;
  try
    COL := DsReportTemplate1.FieldByName('COL').AsInteger;
    ROW := DsReportTemplate1.FieldByName('ROW').AsInteger;
    ROWS_ID := DsReportTemplate1.FieldByName('ROWS_ID').AsString;

    DsReportTemplate1.Next;
    COL1 := DsReportTemplate1.FieldByName('COL').AsInteger;
    ROW1 := DsReportTemplate1.FieldByName('ROW').AsInteger;
    ROWS_ID1 := DsReportTemplate1.FieldByName('ROWS_ID').AsString;

    if ROW <> ROW1 then
      begin
        DsReportTemplate1.Locate('ROWS_ID',ROWS_ID,[]);
        Exit;
      end;
    if DsReportTemplate1.State in [dsEdit,dsInsert] then DsReportTemplate1.Post;

    if DsReportTemplate1.Locate('ROWS_ID',ROWS_ID1,[]) then
      begin
        DsReportTemplate1.Edit;
        DsReportTemplate1.FieldByName('COL').AsInteger := COL;
        DsReportTemplate1.Post;
      end;
    if DsReportTemplate1.Locate('ROWS_ID',ROWS_ID,[]) then
      begin
        DsReportTemplate1.Edit;
        DsReportTemplate1.FieldByName('COL').AsInteger := COL1;
        DsReportTemplate1.Post;
      end;
  finally
    DsReportTemplate1.EnableControls;
  end;
end;

class function TfrmDefineReport.DeleteReport(Owner: TForm;
  Id,Field_Name: String): Boolean;
begin
  with TfrmDefineReport.Create(Owner) do
    begin
      try
        SQL := Field_Name;
        Open(Id);
        btnExit.Caption := '删除(&D)';
        btnExit.Tag := 1;
        Result := ShowModal = mrOk;
      finally
        Free;
      end;
    end;
end;

procedure TfrmDefineReport.DBGridEh1Columns2EditButtonClick(
  Sender: TObject; var Handled: Boolean);
var
  RecordList:TRecordList;
  Str_Sql,ROWS_ID,Str_Field: String;
  i,r,COL:integer;
begin
  inherited;
  if DsReportTemplate.IsEmpty then Exit;
  COL := DsReportTemplate.FieldByName('COL').AsInteger;
  ROWS_ID := DsReportTemplate.FieldByName('ROWS_ID').AsString;

  RecordList := TRecordList.Create;
  Str_Sql := SQL;
  try
    if TframeListDialog.FindMDialog(Self,Str_Sql,'CODE_NAME=数据字段名',RecordList) then
      begin
        Str_Sql := '';
        for i:=0 to RecordList.Count -1 do
          begin
            if Str_Sql = '' then
              begin
              Str_Sql := RecordList.Records[i].FieldByName('CODE_ID').AsString;
              Str_Field := RecordList.Records[i].FieldByName('CODE_NAME').AsString;
              end
            else
              begin
                Str_Sql := Str_Sql + ',' + RecordList.Records[i].FieldByName('CODE_ID').AsString;
                Str_Field := Str_Field + ',' + RecordList.Records[i].FieldByName('CODE_NAME').AsString;
              end;
          end;
        DsReportTemplate.First;
        while not DsReportTemplate.Eof do
          begin
            if DsReportTemplate.FieldByName('COL').AsInteger = COL then
              begin
                DsReportTemplate.Edit;
                DsReportTemplate.FieldByName('FIELD_NAME').AsString := Str_Sql;
                DsReportTemplate.FieldByName('FIELD_NAME_TEXT').AsString := Str_Field;
                DsReportTemplate.Post;
              end;
            DsReportTemplate.Next;
          end;
      end;
  finally
    RecordList.Free;
  end;
end;

procedure TfrmDefineReport.DsReportTemplateAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (DsReportTemplate.FieldByName('INDEX_FLAG').AsString = '4') or (DsReportTemplate.FieldByName('INDEX_FLAG').AsString = '5') then
    begin
      DBGridEh1.Columns[4].ReadOnly := True;
      DBGridEh1.Columns[5].ReadOnly := True;
    end
  else
    begin
      DBGridEh1.Columns[4].ReadOnly := False;
      DBGridEh1.Columns[5].ReadOnly := False;
    end;
end;

procedure TfrmDefineReport.SetColumn(Ds: TDataSet; C: Integer);
begin
  Ds.First;
  while not Ds.Eof do
    begin
      if Ds.FieldByName('COL').AsInteger > C then
        begin
          Ds.Edit;
          Ds.FieldByName('COL').AsInteger := Ds.FieldByName('COL').AsInteger - 1;
          Ds.Post;
        end;
      Ds.Next;
    end;
  ColumnNum := ColumnNum - 1;
end;

procedure TfrmDefineReport.SetRow(Ds: TDataSet; R: Integer);
begin
  Ds.First;
  while not Ds.Eof do
    begin
      if Ds.FieldByName('ROW').AsInteger > R then
        begin
          Ds.Edit;
          Ds.FieldByName('ROW').AsInteger := Ds.FieldByName('ROW').AsInteger - 1;
          Ds.Post;
        end;
      Ds.Next;
    end;
  RowNum := RowNum - 1;
end;

procedure TfrmDefineReport.AnalysisData(Ds: TDataSet);
var i:Integer;
    Str_Field:String;
    rs:TZQuery;
    VList:TStringList;
begin
  if Ds.IsEmpty then Exit;

  VList := TStringList.Create;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := SQL;
    Factor.Open(rs);

    Ds.First;
    while not Ds.Eof do
      begin
        if Ds.FieldByName('FIELD_NAME').AsString <> '' then
          begin
            VList.CommaText := Ds.FieldByName('FIELD_NAME').AsString;
            for i := 0 to VList.Count - 1 do
              begin
                if rs.Locate('CODE_ID',VList[i],[]) then
                  begin
                    if Str_Field = '' then
                      Str_Field := rs.FieldByName('CODE_NAME').AsString
                    else
                      Str_Field := Str_Field + ','+rs.FieldByName('CODE_NAME').AsString;
                  end;
              end;
            Ds.Edit;
            Ds.FieldByName('FIELD_NAME_TEXT').AsString := Str_Field;
            Ds.Post;
            Str_Field := '';
          end;
        Ds.Next;
      end;
  finally
    VList.Free;
    rs.Free;
  end;
end;

end.
