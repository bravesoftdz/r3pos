unit ufrmPwdViewer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  RzButton, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids,
  DBGridEh, cxMaskEdit, cxButtonEdit, zrComboBoxList, cxControls,
  cxContainer, cxEdit, cxTextEdit, StdCtrls, RzLabel;

type
  TfrmPwdViewer = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    btnClose: TRzBitBtn;
    dbGrid: TDBGridEh;
    DsUsersPwd: TDataSource;
    CdsUsersPwd: TZQuery;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel5: TRzLabel;
    edtKey: TcxTextEdit;
    btnSearch: TRzBitBtn;
    edtSHOP_ID: TzrComboBoxList;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure dbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnSearchClick(Sender: TObject);
    procedure CdsUsersPwdAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    IsEnd:Boolean;
    MaxId,Tenant_Id:String;
  public
    { Public declarations }
    function EncodeSql(UserId:String):String;
    procedure Open(UserId:String);
    class function FindDialog(AOwner:TForm;TenantId:String):String;
  end;


implementation
uses uGlobal,uShopGlobal, ufrmBasic, EncDec;
{$R *.dfm}

{ TfrmPwdViewer }

function TfrmPwdViewer.EncodeSql(UserId: String): String;
var Sql_Where:String;
begin
  Result := 'select b.SHOP_NAME,a.USER_ID,a.ACCOUNT,a.USER_NAME,a.USER_SPELL,a.PASS_WRD from VIW_USERS a left join CA_SHOP_INFO b on a.TENANT_ID=b.TENANT_ID and a.SHOP_ID=b.SHOP_ID where a.COMM not in (''02'',''12'') ';
  if Trim(Tenant_Id) = '' then
     Sql_Where := ' and a.Tenant_Id='+IntToStr(Global.TENANT_ID)
  else
     Sql_Where := ' and a.Tenant_Id='+Tenant_Id;
  if Trim(UserId) <> '' then
     Sql_Where := Sql_Where + ' and a.USER_ID>'+QuotedStr(UserId);
  if Trim(edtKey.Text) <> '' then
     Sql_Where := Sql_Where + ' and (a.ACCOUNT like ''%'+edtKey.Text+'%'' or a.USER_NAME like ''%'+edtKey.Text+'%'' or a.USER_SPELL like ''%'+edtKey.Text+'%'' )';
  if edtSHOP_ID.AsString <> '' then
     Sql_Where := Sql_Where + ' and a.SHOP_ID = '+QuotedStr(edtSHOP_ID.AsString);

  Result := Result+Sql_Where;
  case Factor.iDbType of
  0:result := 'select top 100 * from ('+result+') j order by USER_ID';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by USER_ID) where ROWNUM<=100';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by USER_ID) tp fetch first 100  rows only';
  5:result := 'select * from ('+result+') j order by USER_ID limit 100';
  else
    result := 'select * from ('+result+') j order by USER_ID';
  end;

end;

class function TfrmPwdViewer.FindDialog(AOwner: TForm;TenantId:String): String;
begin
  with TfrmPwdViewer.Create(AOwner) do
    begin
      try
        Tenant_Id := TenantId;
        Open('');
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TfrmPwdViewer.Open(UserId: String);
var rs:TZQuery;
    rm:TMemoryStream;
begin
  rs := TZQuery.Create(nil);
  rm := TMemoryStream.Create;
  CdsUsersPwd.DisableControls;
  try
    if Trim(UserId) = '' then CdsUsersPwd.Close;
    rs.Close;
    rs.SQL.Text := EncodeSql(UserId);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('USER_ID').AsString;
    rs.First;
    while not rs.Eof do
    begin
      rs.Edit;
      rs.FieldByName('PASS_WRD').AsString := DecStr(rs.FieldbyName('PASS_WRD').AsString,ENC_KEY);
      rs.Post;
      rs.Next;
    end;
    if Trim(UserId) = '' then
       begin
         rs.SaveToStream(rm);
         CdsUsersPwd.LoadFromStream(rm);
         CdsUsersPwd.IndexFieldNames := 'ACCOUNT';
       end
    else
       begin
         rs.SaveToStream(rm);
         CdsUsersPwd.AddFromStream(rm);
       end;
    if rs.RecordCount < 100 then IsEnd := True else IsEnd := False;
  finally
    CdsUsersPwd.EnableControls;
    rm.Free;
    rs.Free;
  end;

end;

procedure TfrmPwdViewer.FormCreate(Sender: TObject);
begin
  inherited;
  edtSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  
end;

procedure TfrmPwdViewer.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;  
end;

procedure TfrmPwdViewer.dbGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect: TRect;
begin
  inherited;
  if (Rect.Top = dbGrid.CellRect(dbGrid.Col, dbGrid.Row).Top) and (not
    (gdFocused in State) or not dbGrid.Focused) then
  begin
    dbGrid.Canvas.Brush.Color := clAqua;
  end;
  dbGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      dbGrid.canvas.FillRect(ARect);
      DrawText(dbGrid.Canvas.Handle,pchar(Inttostr(CdsUsersPwd.RecNo)),length(Inttostr(CdsUsersPwd.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmPwdViewer.btnSearchClick(Sender: TObject);
begin
  inherited;
  Open('');
end;

procedure TfrmPwdViewer.CdsUsersPwdAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not CdsUsersPwd.Eof then Exit;
  if CdsUsersPwd.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmPwdViewer.FormShow(Sender: TObject);
begin
  inherited;
  if edtKey.CanFocus then edtKey.SetFocus;
end;

end.
