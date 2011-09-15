unit ufrmFindOrder;
                                                                                          
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeDialogForm, ActnList, Menus, RzTabs, ExtCtrls, RzPanel,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, StdCtrls, RzLabel, Grids, DBGridEh, RzButton, DB,
  cxButtonEdit, zrComboBoxList, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmFindOrder = class(TframeDialogForm)
    RzPanel1: TRzPanel;
    RzLabel2: TRzLabel;
    D1: TcxDateEdit;
    RzLabel3: TRzLabel;
    D2: TcxDateEdit;
    RzLabel5: TRzLabel;
    fndGLIDE_NO: TcxTextEdit;
    Label1: TLabel;
    btnFind: TRzBitBtn;
    DBGridEh1: TDBGridEh;
    btnOK: TRzBitBtn;
    btnExit: TRzBitBtn;
    dsList: TDataSource;
    RzLabel4: TRzLabel;
    Label40: TLabel;
    fndCLIENT_ID: TzrComboBoxList;
    fndSHOP_ID: TzrComboBoxList;
    cdsList: TZQuery;
    procedure cdsListAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    Fflag: integer;
    procedure Setflag(const Value: integer);
    { Private declarations }
  public
    { Public declarations }
    IsEnd: boolean;
    MaxId:string;
    function EncodeSQL(id:string):string;
    procedure Open(Id:string);
    class function FindDialog(AOwner:TForm;oFlag:integer;cid,sid:string):string;
    property flag:integer read Fflag write Setflag;
  end;

implementation

uses uGlobal,uShopUtil, uShopGlobal;

{$R *.dfm}

{ TfrmPosMainList }

function TfrmFindOrder.EncodeSQL(id: string): string;
var w,w1:string;
begin
  case flag of
  1:w := ' where A.TENANT_ID=:TENANT_ID and CHK_DATE is not null and A.INDE_DATE>=:D1 and A.INDE_DATE<=:D2 and STKBILL_STATUS in (0,1)';
  2:w := ' where A.TENANT_ID=:TENANT_ID and CHK_DATE is not null and A.INDE_DATE>=:D1 and A.INDE_DATE<=:D2 and SALBILL_STATUS in (0,1)';
  3:w := ' where A.TENANT_ID=:TENANT_ID and CHK_DATE is not null and STOCK_TYPE=1 and A.STOCK_DATE>=:D1 and A.STOCK_DATE<=:D2';
  4:w := ' where A.TENANT_ID=:TENANT_ID and CHK_DATE is not null and SALES_TYPE=1 and A.SALES_DATE>=:D1 and A.SALES_DATE<=:D2';
  end;
  if fndSHOP_ID.AsString <> '' then
     w := w +' and A.SHOP_ID=:SHOP_ID';
  if fndCLIENT_ID.AsString <> '' then
     w := w +' and A.CLIENT_ID=:CLIENT_ID';
  if trim(fndGLIDE_NO.Text) <> '' then
     w := w +' and A.GLIDE_NO like ''%'+trim(fndGLIDE_NO.Text)+'''';
  if id<>'' then
     begin
       case flag of
       1,2: w := w +' and A.INDE_ID>'''+id+'''';
       3: w := w +' and A.STOCK_ID>'''+id+'''';
       4: w := w +' and A.SALES_ID>'''+id+'''';
       end;
     end;
  case flag of
  1:begin
     result :=
     'select A.TENANT_ID,A.INDE_ID,A.GLIDE_NO,A.INDE_DATE,A.CLIENT_ID,A.INDE_AMT as AMOUNT,A.INDE_MNY as AMONEY,B.SHOP_NAME '+
     'from STK_INDENTORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+w+' ';
     result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left join VIW_CLIENTINFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
    end;
  2:begin
     result :=
     'select A.TENANT_ID,A.INDE_ID,A.GLIDE_NO,A.INDE_DATE,A.CLIENT_ID,A.INDE_AMT as AMOUNT,A.INDE_MNY as AMONEY,B.SHOP_NAME '+
     'from SAL_INDENTORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+w+' ';
     result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
    end;
  3:begin
     result :=
     'select A.TENANT_ID,A.STOCK_ID as INDE_ID,A.GLIDE_NO,A.STOCK_DATE as INDE_DATE,A.CLIENT_ID,A.STOCK_AMT as AMOUNT,A.STOCK_MNY as AMONEY,B.SHOP_NAME '+
     'from STK_STOCKORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+w+' ';
     result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left join VIW_CLIENTINFO a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
    end;
  4:begin
     result :=
     'select A.TENANT_ID,A.SALES_ID AS INDE_ID,A.GLIDE_NO,A.SALES_DATE as INDE_DATE,A.CLIENT_ID,A.SALE_AMT as AMOUNT,A.SALE_MNY as AMONEY,B.SHOP_NAME '+
     'from SAL_SALESORDER A left join CA_SHOP_INFO B on A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID '+w+' ';
     result := 'select ja.*,a.CLIENT_NAME from ('+result+') ja left join VIW_CUSTOMER a on ja.TENANT_ID=a.TENANT_ID and ja.CLIENT_ID=a.CLIENT_ID';
    end;
  end;
  case Factor.iDbType of
  0:result := 'select top 600 * from ('+result+') j order by INDE_ID';
  1:result := 'select * from ('+result+' order by INDE_ID) where ROWNUM<=600';
  4:result :=
       'select * from ('+
       'select * from ('+result+') j order by INDE_ID) tp fetch first 600  rows only';
  5:result := 'select * from ('+result+') j order by INDE_ID limit 600';
  else
    result := 'select * from ('+result+') j order by INDE_ID';
  end;
end;

procedure TfrmFindOrder.Open(Id: string);
var
  rs:TZQuery;
  sm:TMemoryStream;
begin
  if not Visible then Exit;
  if Id='' then cdsList.close;
  rs := TZQuery.Create(nil);
  sm := TMemoryStream.Create;
  cdsList.DisableControls;
  try
    rs.SQL.Text := EncodeSQL(Id);
    rs.Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    rs.Params.ParamByName('D1').AsInteger := strtoint(formatdatetime('YYYYMMDD',D1.Date));
    rs.Params.ParamByName('D2').AsInteger := strtoint(formatdatetime('YYYYMMDD',D2.Date));
    if rs.Params.FindParam('CLIENT_ID')<>nil then rs.Params.FindParam('CLIENT_ID').AsString := fndCLIENT_ID.AsString;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.Params.FindParam('SHOP_ID').AsString := fndSHOP_ID.AsString;
    Factor.Open(rs);
    rs.Last;
    MaxId := rs.FieldbyName('INDE_ID').AsString;
    if Id='' then
    begin
       rs.SaveToStream(sm);
       cdsList.LoadFromStream(sm);  
       cdsList.IndexFieldNames := 'GLIDE_NO';
    end
    else
    begin
       rs.SaveToStream(sm);
       cdsList.AddFromStream(sm);
    end;
    if rs.RecordCount <600 then IsEnd := True else IsEnd := false;
  finally
    cdsList.EnableControls;
    sm.Free;
    rs.Free;
  end;
end;

procedure TfrmFindOrder.cdsListAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if IsEnd or not DataSet.Eof then Exit;
  if cdsList.ControlsDisabled then Exit;
  Open(MaxId);
end;

procedure TfrmFindOrder.FormCreate(Sender: TObject);
begin
  inherited;
  fndSHOP_ID.KeyValue := Global.SHOP_ID;
  fndSHOP_ID.Text := Global.SHOP_NAME;
  fndSHOP_ID.DataSet := Global.GetZQueryFromName('CA_SHOP_INFO');
  fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
  D1.Date := date();
  D2.Date := date();
  if Copy(Global.SHOP_ID,Length(Global.SHOP_ID)-3,Length(Global.SHOP_ID)) <> '0001' then
    begin
      SetEditStyle(dsBrowse,fndSHOP_ID.Style);
      fndSHOP_ID.Properties.ReadOnly := True;
    end;

  if ShopGlobal.GetProdFlag = 'E' then
    begin
      Label40.Caption := '所属仓库';
    end;
end;

procedure TfrmFindOrder.btnFindClick(Sender: TObject);
begin
  inherited;
  Open('');
  DBGridEh1.SetFocus;
end;

procedure TfrmFindOrder.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFindOrder.btnOKClick(Sender: TObject);
begin
  inherited;
  if cdsList.IsEmpty then
     begin
       Raise Exception.Create('没有选中你要查询的单据...');
     end;
  self.ModalResult := MROK;
end;

class function TfrmFindOrder.FindDialog(AOwner: TForm;oFlag:integer;cid,sid:string): string;
begin
  with TfrmFindOrder.Create(AOwner) do
    begin
      try
        flag := oFlag;
        if sid<>'' then
           begin
             if fndSHOP_ID.DataSet.Locate('SHOP_ID',sid,[]) then
                begin
                  fndSHOP_ID.KeyValue := sid;
                  fndSHOP_ID.Text := fndSHOP_ID.DataSet.FieldbyName('SHOP_NAME').AsString;
                end;
           end;
        if cid<>'' then
           begin
             if fndCLIENT_ID.DataSet.Locate('CLIENT_ID',sid,[]) then
                begin
                  fndCLIENT_ID.KeyValue := cid;
                  fndCLIENT_ID.Text := fndCLIENT_ID.DataSet.FieldbyName('CLIENT_NAME').AsString;
                end;
           end;
        Open('');
        if ShowModal=MROK then
           result := cdsList.FieldbyName('INDE_ID').AsString
        else
           result := '';
      finally
        free;
      end;
    end;
end;

procedure TfrmFindOrder.Setflag(const Value: integer);
begin
  Fflag := Value;
  case flag of
  1:begin
      Caption := '进货订单查询';
      RzLabel2.Caption := '订货日期';
      TabSheet1.Caption := '进货订单';
      RzLabel4.Caption := '供 应 商';
      DBGridEh1.Columns[3].Title.Caption := '供应商名称';
      fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
    end;
  2:begin
      Caption := '销售订单查询';
      RzLabel2.Caption := '订货日期';
      TabSheet1.Caption := '销售订单';
      RzLabel4.Caption := '客户名称';
      DBGridEh1.Columns[3].Title.Caption := '客户名称';
      fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
    end;
  3:begin
      Caption := '进货单查询';
      RzLabel2.Caption := '进货日期';
      TabSheet1.Caption := '进货单';
      RzLabel4.Caption := '供 应 商';
      DBGridEh1.Columns[3].Title.Caption := '供应商名称';
      fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CLIENTINFO');
    end;
  4:begin
      Caption := '销售单查询';
      RzLabel2.Caption := '销售日期';
      TabSheet1.Caption := '销售单';
      RzLabel4.Caption := '客户名称';
      DBGridEh1.Columns[3].Title.Caption := '客户名称';
      fndCLIENT_ID.DataSet := Global.GetZQueryFromName('PUB_CUSTOMER');
    end;
  end;
end;

procedure TfrmFindOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := $0000F2F2;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsList.RecNo)),length(Inttostr(cdsList.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmFindOrder.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  btnOKClick(nil);
end;

end.
