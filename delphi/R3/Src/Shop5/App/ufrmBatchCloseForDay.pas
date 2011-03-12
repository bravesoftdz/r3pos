unit ufrmBatchCloseForDay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, RzButton, Grids, DBGridEh, ActnList, Menus,
  RzTabs, ExtCtrls, RzPanel, DB, ZAbstractRODataset, ZAbstractDataset, ZBase,
  ZDataset;

type
  TfrmBatchCloseForDay = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    DBGridEh1: TDBGridEh;
    Btn_Save: TRzBitBtn;
    Btn_Close: TRzBitBtn;
    DbCloseForDay: TZQuery;
    DsCloseForDay: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure Btn_CloseClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    Aobj_A:TRecord_;
  public
    { Public declarations }
    procedure GetAccountsRecord(User_Id,Day_Date:String);
    procedure InitGrid;
    function FindColumn(FieldName:String):TColumnEh;
    procedure Open;
    procedure Save;
    class function EditDialog(Owner:TForm):Boolean;
  end;

var
  frmBatchCloseForDay: TfrmBatchCloseForDay;

implementation

uses uGlobal,uShopGlobal,ufrmBasic;

{$R *.dfm}

{ TfrmBatchCloseForDay }

procedure TfrmBatchCloseForDay.Open;
var Str: String;
begin
  try
    Str :=
    'select 0 as selflag,TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE as CREA_DATE,sum(PAY_A) as SUM_MONEY from SAL_SALESORDER A'+
    ' where SALES_TYPE = 4 and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and SALES_DATE<=:SALES_DATE'+
    ' and not exists('+
    ' select * from ACC_CLOSE_FORDAY  where TENANT_ID=A.TENANT_ID and SHOP_ID=A.SHOP_ID and CREA_USER=A.CREA_USER and CLSE_DATE=A.SALES_DATE'+
    ' )group by TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE';
    DbCloseForDay.SQL.Text := Str;
    DbCloseForDay.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    DbCloseForDay.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    DbCloseForDay.ParamByName('SALES_DATE').AsInteger := StrToInt(FormatDateTime('YYYYMMDD',Date));
    Factor.Open(DbCloseForDay);
    if DbCloseForDay.Fields[1].AsString = '' then
      Btn_Save.Enabled := False;
  finally

  end;
end;

procedure TfrmBatchCloseForDay.FormShow(Sender: TObject);
begin
  inherited;
  Open;
end;

class function TfrmBatchCloseForDay.EditDialog(Owner: TForm): Boolean;
begin
  with TfrmBatchCloseForDay.Create(Owner) do
    begin
      try
        Result := ShowModal = mrOk;
      finally
        Free;
      end;
    end;
end;

function TfrmBatchCloseForDay.FindColumn(FieldName: String): TColumnEh;
var i:Integer;
begin
  for i := 0 to DBGridEh1.Columns.Count - 1 do
    begin
      if DBGridEh1.Columns[i].FieldName = FieldName then
        begin
          Result := DBGridEh1.Columns[i];
          Exit;
        end;
    end;
end;

procedure TfrmBatchCloseForDay.InitGrid;
var rs:TZQuery;
    Column:TColumnEh;
begin
  rs := TZQuery.Create(nil);
  try
    rs.SQL.Text := 'select USER_ID,USER_NAME from VIW_USERS where COMM not in (''12'',''02'')';
    Factor.Open(rs);
    Column := FindColumn('CREA_USER');
    if Column <> nil then
      begin
        rs.First;
        while not rs.Eof do
          begin
            Column.KeyList.Add(rs.FieldbyName('USER_ID').AsString);
            Column.PickList.Add(rs.FieldbyName('USER_NAME').AsString);
            rs.Next;
          end;
      end;
  finally
    rs.Free;
  end;
end;

procedure TfrmBatchCloseForDay.FormCreate(Sender: TObject);
begin
  inherited;
  Aobj_A := TRecord_.Create;
  InitGrid;
end;

procedure TfrmBatchCloseForDay.N1Click(Sender: TObject);
begin
  inherited;
  if (not DbCloseForDay.Active) or DbCloseForDay.IsEmpty then Exit;
  try
    DbCloseForDay.DisableControls;
    DbCloseForDay.First;
    while not DbCloseForDay.Eof do
      begin
        DbCloseForDay.Edit;
        DbCloseForDay.FieldByName('selfalg').AsString := '1';
        DbCloseForDay.Post;
        DbCloseForDay.Next;
      end;
  finally
    DbCloseForDay.EnableControls;
  end;
end;

procedure TfrmBatchCloseForDay.N2Click(Sender: TObject);
begin
  inherited;
  if (not DbCloseForDay.Active) and DbCloseForDay.IsEmpty then Exit;
  try
    DbCloseForDay.DisableControls;
    DbCloseForDay.First;
    while not DbCloseForDay.Eof do
      begin
        if DbCloseForDay.FieldByName('selfalg').AsString = '0' then
          DbCloseForDay.FieldByName('selfalg').AsString := '1'
        else
          DbCloseForDay.FieldByName('selfalg').AsString := '0';
        DbCloseForDay.Next;
      end;
  finally
    DbCloseForDay.EnableControls;
  end;
end;

procedure TfrmBatchCloseForDay.N3Click(Sender: TObject);
begin
  inherited;
  if DbCloseForDay.IsEmpty or (not DbCloseForDay.Active) then Exit;
  try
    DbCloseForDay.DisableControls;
    DbCloseForDay.First;
    while not DbCloseForDay.Eof do
      begin
        DbCloseForDay.Edit;
        DbCloseForDay.FieldByName('selfalg').AsString := '0';
        DbCloseForDay.Post;
        DbCloseForDay.Next;
      end;
  finally
    DbCloseForDay.EnableControls;
  end;
end;

procedure TfrmBatchCloseForDay.GetAccountsRecord(User_Id, Day_Date: String);
var StrSql:String;
    rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try

    StrSql :=
    'select TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE as CLSE_DATE,'+
    'sum(PAY_A) as PAY_A,'+
    'sum(PAY_B) as PAY_B,'+
    'sum(PAY_C) as PAY_C,'+
    'sum(PAY_D) as PAY_D,'+
    'sum(PAY_E) as PAY_E,'+
    'sum(PAY_F) as PAY_F,'+
    'sum(PAY_G) as PAY_G,'+
    'sum(PAY_H) as PAY_H,'+
    'sum(PAY_I) as PAY_I,'+
    'sum(PAY_J) as PAY_J '+
    ' from SAL_SALESORDER A'+
    ' where SALES_TYPE = 4 and TENANT_ID=:TENANT_ID and SHOP_ID=:SHOP_ID and CREA_USER=:CREA_USER and SALES_DATE=:SALES_DATE '+
    '  group by TENANT_ID,SHOP_ID,CREA_USER,SALES_DATE';
    rs.SQL.Text := StrSql;
    rs.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.ParamByName('SHOP_ID').AsString := Global.SHOP_ID;
    rs.ParamByName('CREA_USER').AsString := User_Id;
    rs.ParamByName('SALES_DATE').AsString := Day_Date;
    Factor.Open(rs);
    Aobj_A.ReadFromDataSet(rs);
  finally
    rs.Free;
  end;

end;

procedure TfrmBatchCloseForDay.FormDestroy(Sender: TObject);
begin
  inherited;
  Aobj_A.Free;
end;

procedure TfrmBatchCloseForDay.Save;
var rs:TZQuery;
begin
  rs := TZQuery.Create(nil);
  try
    DbCloseForDay.CommitUpdates;
    DbCloseForDay.Filtered := False;
    DbCloseForDay.Filter := ' selflag=1 ';
    DbCloseForDay.Filtered := True;
    if DbCloseForDay.IsEmpty then Raise Exception.Create('��ѡ��������˼�¼.');
    rs.SQL.Text := 'select TENANT_ID,SHOP_ID,CREA_USER,CLSE_DATE,PAY_A,PAY_B,PAY_C,PAY_D,PAY_E,PAY_F,PAY_G,PAY_H,PAY_I,PAY_J from ACC_CLOSE_FORDAY where 1<>1 ';
    Factor.Open(rs);
    DbCloseForDay.First;
    while not DbCloseForDay.Eof do
      begin
        GetAccountsRecord(DbCloseForDay.FieldbyName('CREA_USER').AsString,DbCloseForDay.FieldbyName('CREA_DATE').AsString);
        rs.Append;
        Aobj_A.WriteToDataSet(rs);
        rs.Post;
        DbCloseForDay.Next;
      end;
  try
    Factor.UpdateBatch(rs,'TCloseForDay');
  Except
    DbCloseForDay.CancelUpdates;
  end;
  finally
    rs.Free;
  end;

end;

procedure TfrmBatchCloseForDay.Btn_SaveClick(Sender: TObject);
begin
  inherited;
  if (not DbCloseForDay.Active) or DbCloseForDay.IsEmpty then Exit;
  Save;
  ModalResult := mrOk;
end;

procedure TfrmBatchCloseForDay.Btn_CloseClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrIgnore;
end;

procedure TfrmBatchCloseForDay.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
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
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(DbCloseForDay.RecNo)),length(Inttostr(DbCloseForDay.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

end.
