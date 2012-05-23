unit ufrmMktKpiModify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxButtonEdit, zrComboBoxList, RzButton, cxTextEdit, cxControls, ObjCommon,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, ZDataset,
  RzLabel, Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset, ZBase,
  RzBmpBtn;

type
  TfrmMktKpiModify = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    btnOK: TRzBitBtn;
    btnExit: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    cdsList: TZQuery;
    dsList: TDataSource;
    TabSheet2: TRzTabSheet;
    RzPanel3: TRzPanel;
    cdsList2: TZQuery;
    dsList2: TDataSource;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    actToModify: TAction;
    actToNotModify: TAction;
    actQuery: TAction;
    lab_KPI_NAME: TRzLabel;
    RzLabel10: TRzLabel;
    edtKPI_NAME: TcxTextEdit;
    edtKPI_YEAR: TcxTextEdit;
    DBGridEh2: TDBGridEh;
    RzLabel1: TRzLabel;
    edtCLIENT_ID: TcxTextEdit;
    edtRightTranBtn: TRzBmpButton;
    edtLeftTranBtn: TRzBmpButton;
    procedure FormShow(Sender: TObject);
    procedure actToModifyExecute(Sender: TObject);
    procedure actToNotModifyExecute(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh2KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure DBGridEh2DrawFooterCell(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; Rect: TRect; State: TGridDrawState);
    procedure RzPageChange(Sender: TObject);
  private
    FClientId: String;
    FKpiId: String;
    FKpiYear: Integer;
    D1,D2:Integer;
    procedure SetClientId(const Value: String);
    procedure SetKpiId(const Value: String);
    procedure SetKpiYear(const Value: Integer);
    procedure FocusNextColumn;
    procedure FocusNextColumn2;
    procedure SetKpiName(const Value: String);
    procedure WriteToData(var SurData,ObjData:TZQuery);
    procedure SetClientName(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    procedure Open(Id:string);
    procedure Save;
    property ClientId:String read FClientId write SetClientId;
    property KpiId:String read FKpiId write SetKpiId;
    property KpiYear:Integer read FKpiYear write SetKpiYear;
    property KpiName:String write SetKpiName;
    property ClientName:String write SetClientName;
  end;

implementation

uses ufrmBasic,uGlobal,uFnUtil,uShopUtil, uDsUtil, Math, uXDictFactory;

{$R *.dfm}

{ TfrmMktKpiModify }

procedure TfrmMktKpiModify.Open(Id: string);
var Params:TftParamList;
begin
  if not Visible then Exit;
  Params := TftParamList.Create;
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('D1').AsInteger := D1;
    Params.ParamByName('D2').AsInteger := D2;
    Params.ParamByName('CLIENT_ID').AsString := ClientId;
    Params.ParamByName('KPI_ID').AsString := KpiId;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsList,'TMktKpiModify',Params);
      Factor.AddBatch(cdsList2,'TMktKpiNotModify',Params);
      Factor.OpenBatch;
    Except
      Factor.CancelBatch;
    end;
  finally
    FreeAndNil(Params);
  end;

end;

procedure TfrmMktKpiModify.SetClientId(const Value: String);
begin
  FClientId := Value;
end;

procedure TfrmMktKpiModify.SetKpiId(const Value: String);
begin
  FKpiId := Value;
end;

procedure TfrmMktKpiModify.SetKpiYear(const Value: Integer);
var rs:TZQuery;
begin
  FKpiYear := Value;
  rs := TZQuery.Create(nil);
  try
    rs.Close;
    rs.SQL.Text := 'select BEGIN_DATE,END_DATE from MKT_PLANORDER where TENANT_ID=:TENANT_ID and CLIENT_ID=:CLIENT_ID and KPI_YEAR=:KPI_YEAR ';
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('CLIENT_ID').AsString := ClientId;
    rs.Params.ParamByName('KPI_YEAR').AsInteger := KpiYear;
    Factor.Open(rs);
    D1 := StrToInt(FormatDateTime('YYYYMMDD',FnTime.fnStrtoDate(rs.FieldByName('BEGIN_DATE').AsString)));
    D2 := StrToInt(FormatDateTime('YYYYMMDD',FnTime.fnStrtoDate(rs.FieldByName('END_DATE').AsString)));
  finally
    rs.Free;
  end;
  edtKPI_YEAR.EditValue := Value;
  edtKPI_YEAR.Properties.ReadOnly := True;
end;

procedure TfrmMktKpiModify.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  RzPage.ActivePage := TabSheet1;
  RzPageChange(Sender);
end;

procedure TfrmMktKpiModify.actToModifyExecute(Sender: TObject);
begin
  inherited;
  if (not cdsList.Active) or (cdsList.IsEmpty) then Exit;
  if cdsList.State in [dsInsert,dsEdit] then cdsList.Post;
  cdsList.DisableControls;
  Self.dsList.DataSet := nil;
  Self.dsList2.DataSet := nil;
  try
    cdsList.Filtered := False;
    cdsList.Filter := 'A=1';
    cdsList.Filtered := True;
    if cdsList.IsEmpty then Raise Exception.Create('请选择要返利的商品...');
    WriteToData(cdsList,cdsList2);
    cdsList.First;
    while not cdsList.Eof do cdsList.Delete;
    RzPage.ActivePageIndex := TabSheet2.PageIndex;
    
  finally
    cdsList.Filtered := False;
    cdsList.EnableControls;
    Self.dsList2.DataSet := cdsList2;
    Self.dsList.DataSet := cdsList;
  end;
end;

procedure TfrmMktKpiModify.actToNotModifyExecute(Sender: TObject);
begin
  inherited;
  if (not cdsList2.Active) or (cdsList2.IsEmpty) then Exit;
  if cdsList2.State in [dsInsert,dsEdit] then cdsList2.Post;
  cdsList2.DisableControls;
  Self.dsList.DataSet := nil;
  Self.dsList2.DataSet := nil;
  try
    cdsList2.Filtered := False;
    cdsList2.Filter := 'A=1';
    cdsList2.Filtered := True;
    if cdsList2.IsEmpty then Raise Exception.Create('请选择要非返利的商品...');
    WriteToData(cdsList2,cdsList);
    cdsList2.First;
    while not cdsList2.Eof do cdsList2.Delete;
    RzPage.ActivePageIndex := TabSheet1.PageIndex;
  finally
    cdsList2.Filtered := False;
    cdsList2.EnableControls;
    Self.dsList2.DataSet := cdsList2;
    Self.dsList.DataSet := cdsList;
  end;
end;

procedure TfrmMktKpiModify.btnOKClick(Sender: TObject);
begin
  inherited;
  Save;
  Close;
end;

procedure TfrmMktKpiModify.Save;
begin
  if cdsList.State in [dsInsert,dsEdit] then cdsList.Post;
  if cdsList2.State in [dsInsert,dsEdit] then cdsList2.Post;
  cdsList.DisableControls;
  cdsList2.DisableControls;
  try
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsList,'TMktKpiNotModify');
      Factor.AddBatch(cdsList2,'TMktKpiModify');
      Factor.CommitBatch;
    except
      Factor.CancelBatch;
      Raise Exception.Create('调整量提交失败!');
    end;
  finally
    cdsList2.EnableControls;
    cdsList.EnableControls;
  end;

end;

procedure TfrmMktKpiModify.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMktKpiModify.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmMktKpiModify.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused) then
  begin
    DBGridEh2.Canvas.Brush.Color := clAqua;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.Brush.Color := $0000F2F2;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsList2.RecNo)),length(Inttostr(cdsList2.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmMktKpiModify.FocusNextColumn;
var i:Integer;
begin
  i:=DbGridEh2.Col;
  {if cdsList2.RecordCount>cdsList2.RecNo then
     begin
       cdsList2.Next;
       Exit;
     end; }
  Inc(i);
  while True do
    begin
      if i>=DbGridEh2.Columns.Count then i:= 1;
      if (DbGridEh2.Columns[i].ReadOnly or not DbGridEh2.Columns[i].Visible) and (i<>1) then
         inc(i)
      else
         begin
           if cdsList2.FieldbyName('MODI_AMOUNT').AsInteger = 0 then
              i := 1;
           if (i=1) and (cdsList2.FieldbyName('MODI_AMOUNT').AsInteger <> 0) then
              begin

                 DbGridEh2.SetFocus;
                 DbGridEh2.Col := 1 ;
              end
           else
              DbGridEh2.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmMktKpiModify.DBGridEh2KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key=#13) then
  begin
     FocusNextColumn;
     Key := #0;
  end;
  inherited;
end;

procedure TfrmMktKpiModify.SetKpiName(const Value: String);
begin
  edtKPI_NAME.Text := Value;
  edtKPI_NAME.Properties.ReadOnly := True;
end;

procedure TfrmMktKpiModify.FocusNextColumn2;
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
           DbGridEh2.Col := i;
           Exit;
         end;
    end;
end;

procedure TfrmMktKpiModify.DBGridEh1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key=#13) then
  begin
     FocusNextColumn2;
     Key := #0;
  end;
  inherited;
end;

procedure TfrmMktKpiModify.WriteToData(var SurData, ObjData: TZQuery);
var i:Integer;
begin
  SurData.First;
  while not SurData.Eof do
  begin
    ObjData.Append;
    for i:=0 to SurData.Fields.Count - 1 do
    begin
      if ObjData.FindField(SurData.Fields[i].FieldName) <> nil then
         ObjData.FindField(SurData.Fields[i].FieldName).Value := SurData.Fields[i].Value;
    end;
    ObjData.FieldByName('A').AsInteger := 0;
    ObjData.FieldByName('KPI_YEAR').AsInteger := KpiYear;
    ObjData.FieldByName('MODIFY_ID').AsString := TSequence.NewId;
       
    ObjData.Post;
    SurData.Next;
  end;
end;

procedure TfrmMktKpiModify.SetClientName(const Value: String);
begin
  edtCLIENT_ID.Text := Value;
  edtCLIENT_ID.Properties.ReadOnly := True;
end;

procedure TfrmMktKpiModify.DBGridEh1DrawFooterCell(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; Rect: TRect;
  State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;

       DBGridEh1.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s个',[Inttostr(cdsList.RecordCount)]);
       DBGridEh1.Canvas.Font.Style := [fsBold];
       DBGridEh1.Canvas.TextRect(R,(Rect.Right) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmMktKpiModify.DBGridEh2DrawFooterCell(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; Rect: TRect;
  State: TGridDrawState);
var R:TRect;
  s:string;
begin
  inherited;
  if Column.FieldName = 'GODS_NAME' then
     begin
       R.Left := Rect.Left;
       R.Top := Rect.Top ;
       R.Bottom := Rect.Bottom;

       DBGridEh2.Canvas.FillRect(R);
       s := XDictFactory.GetMsgStringFmt('frame.OrderFooterLabel','合 计 共%s个',[Inttostr(cdsList2.RecordCount)]);
       DBGridEh2.Canvas.Font.Style := [fsBold];
       DBGridEh2.Canvas.TextRect(R,(Rect.Right) div 2,Rect.Top+2,s);
     end;
end;

procedure TfrmMktKpiModify.RzPageChange(Sender: TObject);
begin
  inherited;
  if RzPage.ActivePageIndex = 0 then
  begin
     edtRightTranBtn.Enabled := True;
     edtLeftTranBtn.Enabled := False;
  end
  else
  begin
     edtRightTranBtn.Enabled := False;
     edtLeftTranBtn.Enabled := True;
  end;
end;

end.
