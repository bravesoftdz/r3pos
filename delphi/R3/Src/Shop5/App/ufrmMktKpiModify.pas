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
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh2Columns8UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure DBGridEh2Columns6UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
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
    procedure WriteToData(var SurData,ObjData:TZQuery;flag:integer);
    procedure SetClientName(const Value: String);
    procedure InitUnit;
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
      Factor.AddBatch(cdsList,'TMktKpiNotModify',Params);
      Factor.AddBatch(cdsList2,'TMktKpiModify',Params);
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
end;

procedure TfrmMktKpiModify.actToModifyExecute(Sender: TObject);
//var tmp:TZQuery;
begin
  inherited;
  if (not cdsList.Active) or (cdsList.IsEmpty) then Exit;
  if cdsList.State in [dsInsert,dsEdit] then cdsList.Post;
  if cdsList2.State in [dsInsert,dsEdit] then cdsList2.Post;
  cdsList.DisableControls;
  cdsList2.DisableControls;
//  tmp := TZQuery.Create(nil);
  try
    cdsList2.Filtered := False;
    cdsList.Filtered := False;
    cdsList.Filter := 'A=1';
    cdsList.Filtered := True;
    if cdsList.IsEmpty then Raise Exception.Create('请选择要返利的商品...');
    WriteToData(cdsList,cdsList2,0);
    cdsList.Filtered := False;
    cdsList.First;
    while not cdsList.Eof do
       begin
         if cdsList.FieldByName('A').AsString='1' then
            cdsList.Delete else cdsList.Next;
       end;
  finally
//    tmp.Free;
    cdsList.Filtered := False;
    cdsList2.Filtered := False;
    cdsList.EnableControls;
    cdsList2.EnableControls;
    //cdsList.Refresh;
  end;
end;

procedure TfrmMktKpiModify.actToNotModifyExecute(Sender: TObject);
begin
  inherited;
  if (not cdsList2.Active) or (cdsList2.IsEmpty) then Exit;
  if cdsList.State in [dsInsert,dsEdit] then cdsList.Post;
  if cdsList2.State in [dsInsert,dsEdit] then cdsList2.Post;
  cdsList.DisableControls;
  cdsList2.DisableControls;
  try
    cdsList.Filtered := False;
    cdsList2.Filtered := False;
    cdsList2.Filter := 'A=1';
    cdsList2.Filtered := True;
    if cdsList2.IsEmpty then Raise Exception.Create('请选择要非返利的商品...');
    WriteToData(cdsList2,cdsList,1);
    cdsList2.Filtered := False;
    cdsList2.First;
    while not cdsList2.Eof do
       begin
         if cdsList2.FieldByName('A').AsString='1' then
            cdsList2.Delete else cdsList2.Next;
       end;
  finally
    cdsList.Filtered := False;
    cdsList2.Filtered := False;
    cdsList.EnableControls;
    cdsList2.EnableControls;
    //cdsList2.Refresh;
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

procedure TfrmMktKpiModify.WriteToData(var SurData, ObjData: TZQuery;flag:integer);
var i:Integer;
begin
  SurData.First;
  while not SurData.Eof do
  begin
    if ObjData.Locate('TENANT_ID,SALES_ID,SEQNO',varArrayOf([SurData.FieldbyName('TENANT_ID').AsInteger,SurData.FieldbyName('SALES_ID').AsString,SurData.FieldbyName('SEQNO').AsInteger]),[]) then
    ObjData.Edit else 
    ObjData.Append;
    for i:=0 to SurData.Fields.Count - 1 do
    begin
      if (ObjData.FindField(SurData.Fields[i].FieldName) <> nil) and (SurData.Fields[i].FieldName<>'A') then
         ObjData.FindField(SurData.Fields[i].FieldName).Value := SurData.Fields[i].Value;
    end;
    ObjData.FieldByName('A').AsInteger := 0;
    ObjData.FieldByName('KPI_YEAR').AsInteger := KpiYear;
    ObjData.FieldByName('MODIFY_ID').AsString := TSequence.NewId;
    case flag of
    0:begin //设为反利
        if ObjData.FieldbyName('IS_PRESENT').asInteger=0 then
           begin
             ObjData.FieldByName('MODI_AMOUNT').AsFloat := 0;
             ObjData.FieldByName('MODI_MONEY').AsFloat := 0;
           end
        else
           begin
             ObjData.FieldByName('MODI_AMOUNT').AsFloat := ObjData.FieldByName('ORG_AMOUNT').AsFloat;
             ObjData.FieldByName('MODI_MONEY').AsFloat := ObjData.FieldByName('ORG_MONEY').AsFloat;
           end;
      end;
    1:begin //设为不反利
        if ObjData.FieldbyName('IS_PRESENT').asInteger=0 then
           begin
             ObjData.FieldByName('MODI_AMOUNT').AsFloat := -ObjData.FieldByName('ORG_AMOUNT').AsFloat;
             ObjData.FieldByName('MODI_MONEY').AsFloat := -ObjData.FieldByName('ORG_MONEY').AsFloat;
           end
        else
           begin
             ObjData.FieldByName('MODI_AMOUNT').AsFloat := 0;
             ObjData.FieldByName('MODI_MONEY').AsFloat := 0;
           end;
      end;
    end;
    ObjData.FieldByName('CALC_AMOUNT').AsFloat := ObjData.FieldByName('ORG_AMOUNT').AsFloat;
    ObjData.FieldByName('CALC_MONEY').AsFloat := ObjData.FieldByName('ORG_MONEY').AsFloat;
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

procedure TfrmMktKpiModify.FormCreate(Sender: TObject);
begin
  InitUnit;
  inherited;
  InitGridPickList(DBGridEh1);
  InitGridPickList(DBGridEh2);
end;

procedure TfrmMktKpiModify.DBGridEh2Columns8UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
  cdsList2.FieldByName('KPI_YEAR').AsInteger := KpiYear;
  cdsList2.FieldByName('MODIFY_ID').AsString := TSequence.NewId;
  case cdsList2.FieldByName('IS_PRESENT').AsInteger of
  0:begin
      cdsList2.FieldByName('MODI_AMOUNT').AsFloat := cdsList2.FieldByName('CALC_AMOUNT').AsFloat-cdsList2.FieldByName('ORG_AMOUNT').AsFloat;
      cdsList2.FieldByName('MODI_MONEY').AsFloat := cdsList2.FieldByName('CALC_MONEY').AsFloat-cdsList2.FieldByName('ORG_MONEY').AsFloat;
    end;
  else
    begin
      cdsList2.FieldByName('MODI_AMOUNT').AsFloat := cdsList2.FieldByName('CALC_AMOUNT').AsFloat;
      cdsList2.FieldByName('MODI_MONEY').AsFloat := cdsList2.FieldByName('CALC_MONEY').AsFloat;
    end;
  end;
end;

procedure TfrmMktKpiModify.DBGridEh2Columns6UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var r:Real;
begin
  try
    if Text='' then
       r := 0
    else
       r := StrtoFloat(Text);
  except
    Text := TColumnEh(Sender).Field.AsString;
    Value := TColumnEh(Sender).Field.asFloat;
    Raise Exception.Create('输入无效数值型');
  end;
  if abs(r)>999999999 then Raise Exception.Create('输入的数值过大，无效');
  TColumnEh(Sender).Field.asFloat := r;
  cdsList2.FieldByName('KPI_YEAR').AsInteger := KpiYear;
  cdsList2.FieldByName('MODIFY_ID').AsString := TSequence.NewId;
  cdsList2.FieldByName('CALC_MONEY').AsString := formatFloat('#0.00',cdsList2.FieldByName('CALC_AMOUNT').AsFloat*cdsList2.FieldByName('APRICE').AsFloat);
  case cdsList2.FieldByName('IS_PRESENT').AsInteger of
  0:begin
      cdsList2.FieldByName('MODI_AMOUNT').AsFloat := cdsList2.FieldByName('CALC_AMOUNT').AsFloat-cdsList2.FieldByName('ORG_AMOUNT').AsFloat;
      cdsList2.FieldByName('MODI_MONEY').AsFloat := cdsList2.FieldByName('CALC_MONEY').AsFloat-cdsList2.FieldByName('ORG_MONEY').AsFloat;
    end;
  else
    begin
      cdsList2.FieldByName('MODI_AMOUNT').AsFloat := cdsList2.FieldByName('CALC_AMOUNT').AsFloat;
      cdsList2.FieldByName('MODI_MONEY').AsFloat := cdsList2.FieldByName('CALC_MONEY').AsFloat;
    end;
  end;
end;

procedure TfrmMktKpiModify.InitUnit;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  DBGridEh1.Columns[5].KeyList.Clear;
  DBGridEh1.Columns[5].PickList.Clear;
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh1.Columns[5].KeyList.add(rs.FieldbyName('UNIT_ID').asString);
      DBGridEh1.Columns[5].PickList.add(rs.FieldbyName('UNIT_NAME').asString);
      rs.Next;
    end;
  DBGridEh2.Columns[5].KeyList.Clear;
  DBGridEh2.Columns[5].PickList.Clear;
  rs.First;
  while not rs.Eof do
    begin
      DBGridEh2.Columns[5].KeyList.add(rs.FieldbyName('UNIT_ID').asString);
      DBGridEh2.Columns[5].PickList.add(rs.FieldbyName('UNIT_NAME').asString);
      rs.Next;
    end;
end;

end.
