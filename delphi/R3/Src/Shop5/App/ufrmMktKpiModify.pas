unit ufrmMktKpiModify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxButtonEdit, zrComboBoxList, RzButton, cxTextEdit, cxControls, ObjCommon,
  cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, StdCtrls, ZDataset,
  RzLabel, Grids, DBGridEh, DB, ZAbstractRODataset, ZAbstractDataset;

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
    { Private declarations }
  public
    { Public declarations }
    function EncodeSQL(id:string):string;
    function EncodeSQL2(id:string):string;
    procedure Open(Id:string);
    procedure Open2(Id:string);
    procedure Save;
    property ClientId:String read FClientId write SetClientId;
    property KpiId:String read FKpiId write SetKpiId;
    property KpiYear:Integer read FKpiYear write SetKpiYear;
    property KpiName:String write SetKpiName;
  end;

implementation

uses ufrmBasic,uGlobal,uFnUtil,uShopUtil, uDsUtil, Math;

{$R *.dfm}

{ TfrmMktKpiModify }

function TfrmMktKpiModify.EncodeSQL(id: string): string;
var w,sql:string;
begin
  w := ' and B.TENANT_ID=:TENANT_ID and B.CHK_DATE is not null and B.SALES_DATE>=:D1 and B.SALES_DATE<=:D2 '+
       ' and B.CLIENT_ID=:CLIENT_ID and A.GODS_ID in (select GODS_ID from MKT_KPI_RATIO where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID) '+
       ' and ((not exists (select * from MKT_KPI_MODIFY M where M.TENANT_ID=A.TENANT_ID and M.SALES_ID=A.SALES_ID and M.GODS_ID=A.GODS_ID) and A.IS_PRESENT in (1,2))'+
       ' or (exists (select * from MKT_KPI_MODIFY M where M.TENANT_ID=A.TENANT_ID and M.SALES_ID=A.SALES_ID and M.GODS_ID=A.GODS_ID) and A.IS_PRESENT = 0))';

  sql := 'select 0 as A,C.GLIDE_NO,C.SALES_DATE,H.CODE_NAME,E.GODS_NAME,E.GODS_CODE,F.CLIENT_NAME,C.TENANT_ID,C.SHOP_ID,C.SALES_ID,'+
         'C.GODS_ID,C.BATCH_NO,C.LOCUS_NO,G.UNIT_NAME,C.AMOUNT,C.IS_PRESENT,C.APRICE,C.AMONEY,C.REMARK,D.KPI_YEAR,D.SEQNO,D.MODIFY_ID,D.KPI_YEAR,'+
         'C.AMOUNT+isnull(D.MODI_AMOUNT,0) as COPY_MODI_AMOUNT,isnull(D.MODI_AMOUNT,0) as MODI_AMOUNT,isnull(D.MODI_MONEY,0) as MODI_MONEY from ('+
         'select B.GLIDE_NO,B.CLIENT_ID,B.SALES_TYPE,B.SALES_DATE,A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GODS_ID,A.BATCH_NO,'+
         'A.LOCUS_NO,A.UNIT_ID,A.AMOUNT,A.IS_PRESENT,A.APRICE,A.AMONEY,A.REMARK '+
         ' from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID '+ w +' order by B.SALES_ID '+
         ') C left join MKT_KPI_MODIFY D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID and C.GODS_ID=D.GODS_ID '+
         ' left join VIW_GOODSINFO E on C.TENANT_ID=E.TENANT_ID and C.GODS_ID=E.GODS_ID '+
         ' left join VIW_CUSTOMER F on C.TENANT_ID=F.TENANT_ID and C.CLIENT_ID=F.CLIENT_ID '+
         ' left join VIW_MEAUNITS G on C.TENANT_ID=G.TENANT_ID and C.UNIT_ID=G.UNIT_ID '+
         ' left join PUB_PARAMS H on C.SALES_TYPE=H.CODE_ID where H.TYPE_CODE=''SALES_TYPE'' ';
  Result := ParseSQL(Factor.iDbType,sql);
end;

procedure TfrmMktKpiModify.Open(Id: string);
begin
  if not Visible then Exit;
  if Trim(Id) = '' then cdsList.Close;
  cdsList.DisableControls;
  try
    cdsList.SQL.Text := EncodeSQL(Id);
    cdsList.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsList.Params.ParamByName('D1').AsInteger := D1;
    cdsList.Params.ParamByName('D2').AsInteger := D2;
    cdsList.Params.ParamByName('CLIENT_ID').AsString := ClientId;
    cdsList.Params.ParamByName('KPI_ID').AsString := KpiId;
    Factor.Open(cdsList);
    cdsList.IndexFieldNames := 'GLIDE_NO';
  finally
    cdsList.EnableControls;
  end;
end;

function TfrmMktKpiModify.EncodeSQL2(id: string): string;
var w,sql:string;
begin
  w := ' and B.TENANT_ID=:TENANT_ID and B.CHK_DATE is not null and B.SALES_DATE>=:D1 and B.SALES_DATE<=:D2 '+
       ' and B.CLIENT_ID=:CLIENT_ID and A.GODS_ID in (select GODS_ID from MKT_KPI_RATIO where TENANT_ID=:TENANT_ID and KPI_ID=:KPI_ID) '+
       ' and ((exists (select * from MKT_KPI_MODIFY M where M.TENANT_ID=A.TENANT_ID and M.SALES_ID=A.SALES_ID and M.GODS_ID=A.GODS_ID) and A.IS_PRESENT in (1,2))'+
       ' or (not exists (select * from MKT_KPI_MODIFY M where M.TENANT_ID=A.TENANT_ID and M.SALES_ID=A.SALES_ID and M.GODS_ID=A.GODS_ID) and A.IS_PRESENT = 0))';

  sql := 'select 0 as A,C.GLIDE_NO,C.SALES_DATE,H.CODE_NAME,E.GODS_NAME,E.GODS_CODE,F.CLIENT_NAME,C.TENANT_ID,C.SHOP_ID,C.SALES_ID,'+
         'C.GODS_ID,C.BATCH_NO,C.LOCUS_NO,G.UNIT_NAME,C.AMOUNT,C.IS_PRESENT,C.APRICE,C.AMONEY,C.REMARK,D.KPI_YEAR,D.SEQNO,D.MODIFY_ID,D.KPI_YEAR,'+
         'C.AMOUNT+isnull(D.MODI_AMOUNT,0) as COPY_MODI_AMOUNT,isnull(D.MODI_AMOUNT,0) as MODI_AMOUNT,isnull(D.MODI_MONEY,0) as MODI_MONEY from ('+
         'select B.GLIDE_NO,B.CLIENT_ID,B.SALES_TYPE,B.SALES_DATE,A.TENANT_ID,A.SHOP_ID,A.SALES_ID,A.GODS_ID,A.BATCH_NO,'+
         'A.LOCUS_NO,A.UNIT_ID,A.AMOUNT,A.IS_PRESENT,A.APRICE,A.AMONEY,A.REMARK '+
         ' from SAL_SALESDATA A,SAL_SALESORDER B where A.TENANT_ID=B.TENANT_ID and A.SALES_ID=B.SALES_ID '+ w + ' order by B.SALES_ID '+
         ') C left join MKT_KPI_MODIFY D on C.TENANT_ID=D.TENANT_ID and C.SALES_ID=D.SALES_ID and C.GODS_ID=D.GODS_ID '+
         ' left join VIW_GOODSINFO E on C.TENANT_ID=E.TENANT_ID and C.GODS_ID=E.GODS_ID '+
         ' left join VIW_CUSTOMER F on C.TENANT_ID=F.TENANT_ID and C.CLIENT_ID=F.CLIENT_ID '+
         ' left join VIW_MEAUNITS G on C.TENANT_ID=G.TENANT_ID and C.UNIT_ID=G.UNIT_ID '+
         ' left join PUB_PARAMS H on C.SALES_TYPE=H.CODE_ID where H.TYPE_CODE=''SALES_TYPE'' ';
  Result := ParseSQL(Factor.iDbType,sql);
end;

procedure TfrmMktKpiModify.Open2(Id: string);
begin
  if not Visible then Exit;
  if Trim(Id) = '' then cdsList2.Close;

  cdsList2.DisableControls;
  try
    cdsList2.SQL.Text := EncodeSQL2(Id);
    cdsList2.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    cdsList2.Params.ParamByName('D1').AsInteger := D1;
    cdsList2.Params.ParamByName('D2').AsInteger := D2;
    cdsList2.Params.ParamByName('CLIENT_ID').AsString := ClientId;
    cdsList2.Params.ParamByName('KPI_ID').AsString := KpiId;
    Factor.Open(cdsList2);
    cdsList2.IndexFieldNames := 'GLIDE_NO';
  finally
    cdsList2.EnableControls;
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
begin
  FKpiYear := Value;
  {D1.Date := FnTime.fnStrtoDate(FormatDateTime(IntToStr(Value)+'-01-01',Date));
  D2.Date := FnTime.fnStrtoDate(FormatDateTime(IntToStr(Value)+'-12-31',Date));}
  D1 := Value*10000+101;
  D2 := Value*10000+1231;
  edtKPI_YEAR.EditValue := Value;
  edtKPI_YEAR.Properties.ReadOnly := True;
end;

procedure TfrmMktKpiModify.FormShow(Sender: TObject);
begin
  inherited;
  Open('');
  Open2('');
  RzPage.ActivePage := TabSheet1;
end;

procedure TfrmMktKpiModify.actToModifyExecute(Sender: TObject);
begin
  inherited;
  if (not cdsList.Active) or (cdsList.IsEmpty) then Exit;
  if cdsList.State in [dsInsert,dsEdit] then cdsList.Post;
  cdsList.DisableControls;
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
  end;
end;

procedure TfrmMktKpiModify.actToNotModifyExecute(Sender: TObject);
begin
  inherited;
  if (not cdsList2.Active) or (cdsList2.IsEmpty) then Exit;
  if cdsList2.State in [dsInsert,dsEdit] then cdsList2.Post;
  cdsList2.DisableControls;
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
    if ObjData.FieldByName('MODIFY_ID').AsString = '' then
       ObjData.FieldByName('MODIFY_ID').AsString := TSequence.NewId;
       
    ObjData.Post;
    SurData.Next;
  end;
end;

end.
