unit ufrmPosMainList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, StdCtrls, RzLabel, RzButton, cxButtonEdit, zrComboBoxList,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGridEh;

type
  TfrmPosMainList = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    D1: TcxDateEdit;
    D2: TcxDateEdit;
    RzLabel4: TRzLabel;
    edtSALES_ID: TcxTextEdit;
    btnSearch: TRzBitBtn;
    btnClose: TRzBitBtn;
    RzBitBtn1: TRzBitBtn;
    dbGrid: TDBGridEh;
    CdsSales: TZQuery;
    DsSales: TDataSource;
    RzLabel5: TRzLabel;
    edtCustomerID: TzrComboBoxList;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure CdsSalesAfterScroll(DataSet: TDataSet);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure dbGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    IsEnd:Boolean;
    MaxId:String;
    function EncodeSql(Id:String):String;
    procedure Open(Id:String);
    class function FindDialog(AOwner:TForm):String;
  end;

implementation
uses uGlobal,uShopGlobal, ufrmBasic;
{$R *.dfm}

procedure TfrmPosMainList.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmPosMainList.EncodeSql(Id: String): String;
var Sql_Str,Whe_Str:String;
begin
  Whe_Str := ' where TENANT_ID='+IntToStr(Global.TENANT_ID)+' and SALES_DATE>='+FormatDateTime('YYYYMMDD',D1.Date)+' and SALES_DATE<='+FormatDateTime('YYYYMMDD',D2.Date)+' and SALES_TYPE=4 ';
  if Trim(edtSALES_ID.Text) <> '' then
    Whe_Str := Whe_Str + ' and GLIDE_NO like ''%'+edtSALES_ID.Text+'''';
  if Trim(edtCustomerID.Text) <> '' then
    Whe_Str := Whe_Str + ' and CLIENT_ID='+QuotedStr(edtCustomerID.AsString);
  if Trim(Id) <> '' then
    Whe_Str := Whe_Str + ' and SALES_ID>'+Id;
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    Whe_Str := Whe_Str + ' and SHOP_ID='+QuotedStr(Global.SHOP_ID);

  Sql_Str := ' select TENANT_ID,SALES_ID,GLIDE_NO,SALES_DATE,CLIENT_ID,SALE_AMT,SALE_MNY,CASH_MNY,PAY_ZERO,CREA_USER from SAL_SALESORDER '+Whe_Str;
  Result := 'select ja.*,a.CLIENT_NAME as CLIENT_ID_TEXT from ('+Sql_Str+') ja left join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID ';
  Result := 'select jb.*,b.USER_NAME as CREA_USER_TEXT from ('+Result+') jb left join VIW_USERS b on jb.TENANT_ID=b.TENANT_ID and jb.CREA_USER=b.USER_ID ';
  case Factor.iDbType of
  0:result := 'select top 100 * from ('+result+') j order by GLIDE_NO';
  1:result :=
       'select * from ('+
       'select * from ('+result+') j order by GLIDE_NO) where ROWNUM<=100';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by GLIDE_NO) tp fetch first 100  rows only';
  5:result := 'select * from ('+result+') j order by GLIDE_NO limit 100';
  else
    result := 'select * from ('+result+') j order by GLIDE_NO';
  end;
end;

class function TfrmPosMainList.FindDialog(AOwner: TForm): String;
begin
  with TfrmPosMainList.Create(AOwner) do
    begin
      try
        Open('');
        if ShowModal = mrOk then
          Result := CdsSales.FieldByName('SALES_ID').AsString
        else
          Result := '';
      finally
        Free;
      end;
    end;

end;

procedure TfrmPosMainList.Open(Id: String);
var rs:TZQuery;
    rm:TMemoryStream;
begin
  rs := TZQuery.Create(nil);
  rm := TMemoryStream.Create;
  CdsSales.DisableControls;
  try
    if Trim(Id) = '' then CdsSales.Close;
    rs.Close;
    rs.SQL.Text := EncodeSql(Id);
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldByName('SALES_ID').AsString;
    if Trim(Id) = '' then
      begin
        rs.SaveToStream(rm);
        CdsSales.LoadFromStream(rm);
        CdsSales.IndexFieldNames := 'GLIDE_NO';
      end
    else
      begin
        rs.SaveToStream(rm);
        CdsSales.AddFromStream(rm);
      end;
    if rs.RecordCount < 100 then IsEnd := True else IsEnd := False;
  finally
    CdsSales.EnableControls;
    rs.Free;
    rm.Free;
  end;

end;

procedure TfrmPosMainList.FormCreate(Sender: TObject);
begin
  inherited;
  D1.Date := Date();
  D2.Date := Date();
  edtCustomerID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
end;

procedure TfrmPosMainList.btnSearchClick(Sender: TObject);
begin
  inherited;
  Open('');
  dbGrid.SetFocus;
end;

procedure TfrmPosMainList.CdsSalesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or DataSet.Eof then Exit;
  if CdsSales.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmPosMainList.RzBitBtn1Click(Sender: TObject);
begin
  inherited;
  if CdsSales.IsEmpty then
     begin
       Raise Exception.Create('没有选中你要查询的单据...');
     end;
  self.ModalResult := MROK;
end;

procedure TfrmPosMainList.dbGridDrawColumnCell(Sender: TObject;
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
      DrawText(dbGrid.Canvas.Handle,pchar(Inttostr(CdsSales.RecNo)),length(Inttostr(CdsSales.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmPosMainList.FormShow(Sender: TObject);
begin
  inherited;
  if not D1.Focused then D1.SetFocus;
end;

procedure TfrmPosMainList.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    begin
      if dbGrid.Focused then
        begin
          if CdsSales.RecordCount = 0 then
            btnClose.SetFocus
          else
            RzBitBtn1Click(Sender);
        end;
    end;
end;

end.
