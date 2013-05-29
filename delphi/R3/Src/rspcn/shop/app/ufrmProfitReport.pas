unit ufrmProfitReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmReportForm, StdCtrls, RzLabel, RzButton, RzTabs, ExtCtrls,
  RzPanel, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, TeeProcs, TeEngine,
  Chart, Series, cxRadioGroup, RzBmpBtn, RzBckgnd, pngimage,udllShopUtil,
  PrnDbgeh;

type
  TfrmProfitReport = class(TfrmReportForm)
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel7: TRzPanel;
    DBGridEh1: TDBGridEh;
    rowToolNav: TRzToolbar;
    RzToolButton5: TRzToolButton;
    TabSheet2: TRzTabSheet;
    RzPanel1: TRzPanel;
    RzPanel6: TRzPanel;
    RzPanel8: TRzPanel;
    cdsReport1: TZQuery;
    dsReport1: TDataSource;
    cdsReport2: TZQuery;
    dsReport2: TDataSource;
    rowToolNav2: TRzToolbar;
    TabSheet3: TRzTabSheet;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel9: TRzPanel;
    RzPanel10: TRzPanel;
    RzToolbar4: TRzToolbar;
    RzToolButton11: TRzToolButton;
    RzToolbar5: TRzToolbar;
    Chart1: TChart;
    Series1: TBarSeries;
    DBGridEh2: TDBGridEh;
    barcode: TRzPanel;
    barcode_input_left: TImage;
    barcode_input_right: TImage;
    RzPanel14: TRzPanel;
    RzPanel15: TRzPanel;
    RzBackground7: TRzBackground;
    RzLabel17: TRzLabel;
    dateFlag: TcxComboBox;
    D1: TcxDateEdit;
    RzPanel23: TRzPanel;
    RzPanel22: TRzPanel;
    RzBackground8: TRzBackground;
    RzLabel16: TRzLabel;
    D2: TcxDateEdit;
    btnPrior: TRzBmpButton;
    edtReportType: TcxComboBox;
    edtCLIENT_ID: TzrComboBoxList;
    edtGODS_ID: TzrComboBoxList;
    RzPanel16: TRzPanel;
    edtBK_CALC_UNITS: TRzPanel;
    RzPanel32: TRzPanel;
    RzBackground5: TRzBackground;
    RzLabel4: TRzLabel;
    edtChar1Type: TcxRadioButton;
    edtChar2Type: TcxRadioButton;
    RzPanel17: TRzPanel;
    RzPanel18: TRzPanel;
    RzBackground1: TRzBackground;
    RzLabel1: TRzLabel;
    edtTopNum: TcxComboBox;
    RzPanel19: TRzPanel;
    RzBackground2: TRzBackground;
    RzLabel2: TRzLabel;
    barcode_input_line: TImage;
    RzPanel20: TRzPanel;
    RzLabel3: TRzLabel;
    list: TRzBmpButton;
    chart: TRzBmpButton;
    linkToStock: TRzToolButton;
    procedure dateFlagPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzToolButton5Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure edtReportTypePropertiesChange(Sender: TObject);
    procedure edtChar1TypeClick(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure cdsReport1BeforeOpen(DataSet: TDataSet);
    procedure cdsReport2BeforeOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtGODS_IDClearValue(Sender: TObject);
    procedure edtCLIENT_IDClearValue(Sender: TObject);
    procedure listClick(Sender: TObject);
    procedure chartClick(Sender: TObject);
    procedure DBGridEh1GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure DBGridEh2GetFooterParams(Sender: TObject; DataCol,
      Row: Integer; Column: TColumnEh; AFont: TFont;
      var Background: TColor; var Alignment: TAlignment;
      State: TGridDrawState; var Text: String);
    procedure linkToStockClick(Sender: TObject);
  private
    SumMny,SumPrf:real;
    WTitle1:TStringList;
    WTitle2:TStringList;
    procedure DBGridPrint;override;
  public
    procedure CreateChart;
    procedure CreateGrid1;
    procedure CreateGrid2;
    procedure OpenReport1;
    procedure OpenReport2(all:boolean=true);
    procedure OpenChart;
    procedure showForm;override;
  end;

var frmProfitReport: TfrmProfitReport;

implementation

uses udataFactory,utokenFactory,uFnUtil,udllGlobal,ufrmStocksCalc,objCommon;

{$R *.dfm}

procedure TfrmProfitReport.OpenReport1;
var
  vBegDate,            //查询开始日期
  vEndDate: integer;   //查询结束日期
  RckMaxDate: integer; //台帐最大日期
begin
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',D2.Date));  //结束日期
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);   //取日结帐最大日期:

//  if RckMaxDate < vEndDate then
//     begin
       //没有计算，需重计算流水
       if not TfrmStocksCalc.Calc(self,D2.Date) then Exit;
//     end;
  cdsReport1.close;
  CreateGrid1;
  case edtReportType.ItemIndex of
  0:begin
      WTitle1.Clear;
      WTitle1.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
      WTitle1.add(edtReportType.Text+'：'+edtCLIENT_ID.Text);
      cdsReport1.SQL.Text :=
         'select TENANT_ID,CLIENT_ID,sum(SALE_MONEY) as SALE_MONEY,sum(SALE_TAX) as SALE_TAX,sum(OUT_MONEY) as OUT_MONEY,sum(SALE_MONEY-OUT_MONEY) as SALE_PRF '+
         'from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and BILL_DATE>=:D1 and BILL_DATE<=:D2 and BILL_TYPE in (21,23,24)';
      if FnString.TrimRight(token.shopId,4)<>'0001' then
         cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SHOP_ID=:SHOP_ID';
      if edtCLIENT_ID.AsString <> '' then
         begin
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and CLIENT_ID=:CLIENT_ID';
         end;
      cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by TENANT_ID,CLIENT_ID';

      cdsReport1.SQL.Text :=
         ParseSQL(dataFactory.iDbType,
         'select j.*,1 as flag,case when j.SALE_MONEY<>0 then cast(j.SALE_PRF as decimal(18,3)) *100.00 / cast(j.SALE_MONEY as decimal(18,3)) else 0 end as PRF_RATE,ifnull(b.CLIENT_NAME,''零售客户'') as CLIENT_NAME,b.CLIENT_CODE from ('+cdsReport1.SQL.Text+') j '+
         'left outer join VIW_CUSTOMER b on j.TENANT_ID=b.TENANT_ID and j.CLIENT_ID=b.CLIENT_ID order by b.CLIENT_CODE'
         );
      cdsReport1.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
      cdsReport1.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
      cdsReport1.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
      if cdsReport1.Params.FindParam('SHOP_ID')<>nil then cdsReport1.ParamByName('SHOP_ID').AsString := token.shopId;
      if cdsReport1.Params.FindParam('CLIENT_ID')<>nil then cdsReport1.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
    end;
  1:begin
      WTitle1.Clear;
      WTitle1.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
      WTitle1.add(edtReportType.Text+'：'+edtGODS_ID.Text);
      cdsReport1.SQL.Text :=
         'select TENANT_ID,GODS_ID,sum(OUT_AMOUNT) as SALE_AMOUNT,sum(SALE_MONEY) as SALE_MONEY,sum(SALE_TAX) as SALE_TAX,sum(OUT_MONEY) as OUT_MONEY,sum(SALE_MONEY-OUT_MONEY) as SALE_PRF '+
         'from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and BILL_DATE>=:D1 and BILL_DATE<=:D2 and BILL_TYPE in (21,23,24)';
      if FnString.TrimRight(token.shopId,4)<>'0001' then
         cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SHOP_ID=:SHOP_ID';
      if edtGODS_ID.AsString <> '' then
         begin
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and GODS_ID=:GODS_ID';
         end;
      cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by TENANT_ID,GODS_ID';

      cdsReport1.SQL.Text :=
         ParseSQL(dataFactory.iDbType,
         'select j.*,1 as flag,case when j.SALE_MONEY<>0 then cast(j.SALE_PRF as decimal(18,3)) *100.00 / cast(j.SALE_MONEY as decimal(18,3)) else 0 end as PRF_RATE,b.GODS_NAME,b.GODS_CODE,b.BARCODE,b.CALC_UNITS as UNIT_ID from ('+cdsReport1.SQL.Text+') j '+
         'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS',true)+') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID order by b.GODS_CODE'
         );
      cdsReport1.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
      cdsReport1.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
      cdsReport1.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
      if cdsReport1.Params.FindParam('SHOP_ID')<>nil then cdsReport1.ParamByName('SHOP_ID').AsString := token.shopId;
      if cdsReport1.Params.FindParam('GODS_ID')<>nil then cdsReport1.ParamByName('GODS_ID').AsString := edtGODS_ID.AsString;
    end;
  end;
  dataFactory.Open(cdsReport1);
  cdsReport1.DisableControls;
  try
    SumMny := 0;
    SumPrf := 0;
    cdsReport1.First;
    while not cdsReport1.Eof do
    begin
      SumMny := SumMny + cdsReport1.FieldByName('SALE_MONEY').AsFloat;
      SumPrf := SumPrf + cdsReport1.FieldByName('SALE_PRF').AsFloat;
      cdsReport1.Next;
    end;
  finally
    cdsReport1.First;
    cdsReport1.EnableControls;
  end;
end;

procedure TfrmProfitReport.OpenReport2(all:boolean=true);
begin
  PageControl.ActivePageIndex := 1;
  PageControlChange(nil);
  cdsReport2.close;
  CreateGrid2;
  case edtReportType.ItemIndex of
  0:begin
      WTitle2.Clear;
      WTitle2.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
      WTitle2.add(edtReportType.Text+'：'+edtCLIENT_ID.Text);
      cdsReport2.SQL.Text :=
         'select TENANT_ID,CLIENT_ID,GODS_ID,sum(OUT_AMOUNT) as SALE_AMOUNT,sum(SALE_MONEY) as SALE_MONEY,sum(SALE_TAX) as SALE_TAX,sum(OUT_MONEY) as OUT_MONEY,sum(SALE_MONEY-OUT_MONEY) as SALE_PRF '+
         'from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and BILL_DATE>=:D1 and BILL_DATE<=:D2 and BILL_TYPE in (21,23,24)';
      if FnString.TrimRight(token.shopId,4)<>'0001' then
         cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and SHOP_ID=:SHOP_ID';
      if edtCLIENT_ID.AsString <> '' then
         begin
           cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and CLIENT_ID=:CLIENT_ID';
         end;
      cdsReport2.SQL.Text := cdsReport2.SQL.Text +' group by TENANT_ID,CLIENT_ID,GODS_ID';

      cdsReport2.SQL.Text :=
         'select j.*,1 as flag,case when j.SALE_MONEY<>0 then cast(j.SALE_PRF as decimal(18,3)) *100.00 / cast(j.SALE_MONEY as decimal(18,3)) else 0 end as PRF_RATE,b.GODS_NAME,b.GODS_CODE,b.BARCODE,b.CALC_UNITS as UNIT_ID from ('+cdsReport2.SQL.Text+') j '+
         'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS',true)+') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID order by j.CLIENT_ID,b.GODS_CODE';
      cdsReport2.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
      cdsReport2.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
      cdsReport2.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
      if cdsReport2.Params.FindParam('SHOP_ID')<>nil then cdsReport2.ParamByName('SHOP_ID').AsString := token.shopId;
      if cdsReport2.Params.FindParam('CLIENT_ID')<>nil then cdsReport2.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
    end;
  1:begin
      WTitle2.Clear;
      WTitle2.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
      WTitle2.add(edtReportType.Text+'：'+edtGODS_ID.Text);
      cdsReport2.SQL.Text :=
         'select TENANT_ID,GODS_ID,CLIENT_ID,sum(OUT_AMOUNT) as SALE_AMOUNT,sum(SALE_MONEY) as SALE_MONEY,sum(SALE_TAX) as SALE_TAX,sum(OUT_MONEY) as OUT_MONEY,sum(SALE_MONEY-OUT_MONEY) as SALE_PRF '+
         'from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and BILL_DATE>=:D1 and BILL_DATE<=:D2 and BILL_TYPE in (21,23,24)';
      if FnString.TrimRight(token.shopId,4)<>'0001' then
         cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and SHOP_ID=:SHOP_ID';
      if edtGODS_ID.AsString <> '' then
         begin
           cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and GODS_ID=:GODS_ID';
         end;
      cdsReport2.SQL.Text := cdsReport2.SQL.Text +' group by TENANT_ID,GODS_ID,CLIENT_ID';

      cdsReport2.SQL.Text :=
         'select j.*,1 as flag,case when j.SALE_MONEY<>0 then cast(j.SALE_PRF as decimal(18,3)) *100.00 / cast(j.SALE_MONEY as decimal(18,3)) else 0 end as PRF_RATE,'+
         'case when j.CLIENT_ID is null or j.CLIENT_ID = ''#'' then ''零售客户'' else b.CLIENT_NAME end as CLIENT_NAME,b.CLIENT_CODE from ('+cdsReport2.SQL.Text+') j '+
         'left outer join VIW_CUSTOMER b on j.TENANT_ID=b.TENANT_ID and j.CLIENT_ID=b.CLIENT_ID  order by j.GODS_ID,b.CLIENT_CODE';
      cdsReport2.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
      cdsReport2.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
      cdsReport2.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
      if cdsReport2.Params.FindParam('SHOP_ID')<>nil then cdsReport2.ParamByName('SHOP_ID').AsString := token.shopId;
      if cdsReport2.Params.FindParam('GODS_ID')<>nil then cdsReport2.ParamByName('GODS_ID').AsString := edtGODS_ID.AsString;
    end;
  end;
  dataFactory.Open(cdsReport2);
  RzPanel20.Visible := not all;
  case edtReportType.ItemIndex of
  0:RzLabel3.Caption := '"'+cdsReport1.FieldbyName('CLIENT_NAME').AsString+'" 客户的各商品盈利明细';
  1:RzLabel3.Caption := '"'+cdsReport1.FieldbyName('GODS_NAME').AsString+'" 商品的各客户盈利明细';
  end;
  RzPanel11.Visible := false;
  edtCLIENT_ID.Properties.ReadOnly := not all;
  edtGODS_ID.Properties.ReadOnly := not all;
  dateFlag.Properties.ReadOnly := not all;
  edtReportType.Properties.ReadOnly := not all;
  D1.Properties.ReadOnly := not all;
  D2.Properties.ReadOnly := not all;
  RzBmpButton4.Caption := '展开明细';
  cdsReport2.DisableControls;
  try
    SumMny := 0;
    SumPrf := 0;
    cdsReport2.First;
    while not cdsReport2.Eof do
    begin
      SumMny := SumMny + cdsReport2.FieldByName('SALE_MONEY').AsFloat;
      SumPrf := SumPrf + cdsReport2.FieldByName('SALE_PRF').AsFloat;
      cdsReport2.Next;
    end;
  finally
    cdsReport2.First;
    cdsReport2.EnableControls;
  end;
end;

procedure TfrmProfitReport.dateFlagPropertiesChange(Sender: TObject);
begin
  inherited;
  case dateFlag.ItemIndex of
  0:begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
      //D1.Properties.ReadOnly := true;
      //D2.Properties.ReadOnly := true;
    end;
  1:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYYMM01',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
      //D1.Properties.ReadOnly := true;
      //D2.Properties.ReadOnly := true;
    end;
  2:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYY0101',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
      //D1.Properties.ReadOnly := true;
      //D2.Properties.ReadOnly := true;
    end;
  else
    begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
      //D1.Properties.ReadOnly := false;
      //D2.Properties.ReadOnly := false;
    end;
  end;

end;

procedure TfrmProfitReport.showForm;
begin
  inherited;
  dateFlag.ItemIndex := 1;
  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CUSTOMER');
  edtGODS_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  edtReportType.ItemIndex := 1;

end;

procedure TfrmProfitReport.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  rowToolNav.Visible := not cdsReport1.IsEmpty;
  br := TBrush.Create;
  br.Assign(DBGridEh1.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh1.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused or (Column.FieldName = 'TOOL_NAV')) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav.Visible := true;
         rowToolNav.SetBounds(ARect.Left+1,ARect.Top+1,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
       end
    else
       begin
         DBGridEh1.Canvas.Font.Color := clBlack;
         DBGridEh1.Canvas.Brush.Color := clWhite;
       end;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh1.canvas.Brush.Color := DBGridEh1.FixedColor;
      DBGridEh1.canvas.FillRect(ARect);
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsReport1.RecNo)),length(Inttostr(cdsReport1.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmProfitReport.RzToolButton5Click(Sender: TObject);
begin
  inherited;
  OpenReport2(false);
end;

procedure TfrmProfitReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsReport1.isEmpty then exit;
  case edtReportType.ItemIndex of
  0:begin
      edtCLIENT_ID.KeyValue := cdsReport1.FieldByName('CLIENT_ID').AsString;
      edtCLIENT_ID.Text := cdsReport1.FieldByName('CLIENT_NAME').AsString;
    end;
  1:begin
      edtGODS_ID.KeyValue := cdsReport1.FieldByName('GODS_ID').AsString;
      edtGODS_ID.Text := cdsReport1.FieldByName('GODS_NAME').AsString;
    end;
  end;
  OpenReport2(false);
end;

procedure TfrmProfitReport.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
  b,s:string;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh2.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh2.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused or (Column.FieldName = 'TOOL_NAV')) then
  begin
    if Column.FieldName = 'TOOL_NAV' then
       begin
         ARect := Rect;
         rowToolNav2.Visible := true;
         rowToolNav2.SetBounds(ARect.Left+1,ARect.Top+1,ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
       end
    else
       begin
         DBGridEh2.Canvas.Font.Color := clBlack;
         DBGridEh2.Canvas.Brush.Color := clWhite;
       end;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.Brush.Color := DBGridEh2.FixedColor;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsReport2.RecNo)),length(Inttostr(cdsReport2.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh2.Canvas.Brush.Assign(br);
    DBGridEh2.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmProfitReport.edtReportTypePropertiesChange(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.Visible := (edtReportType.ItemIndex=0);
  edtGODS_ID.Visible := (edtReportType.ItemIndex>0);
  if edtReportType.ItemIndex=0 then
     RzLabel2.Caption := '的客户'
  else
     RzLabel2.Caption := '的商品';
end;

procedure TfrmProfitReport.CreateGrid1;
var
  Column:TColumnEh;
  rs:TZQuery;
  i:integer;
begin
  DBGridEh1.Columns.BeginUpdate;
  DBGridEh1.FrozenCols := 0;
  try
    DBGridEh1.Columns.Clear;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 28;
    Column.FieldName := 'SEQNO';
    Column.Title.Caption := '序号';
    case edtReportType.ItemIndex of
    0:begin
        Column := DBGridEh1.Columns.Add;
        Column.Width := 272;
        Column.FieldName := 'CLIENT_NAME';
        Column.Title.Caption := '客户名称';
        Column.Footer.Alignment := taCenter;
        Column.Footer.ValueType := fvtStaticText;
        Column.Footer.Value := '合计';
        Column := DBGridEh1.Columns.Add;
        Column.Width := 113;
        Column.FieldName := 'CLIENT_CODE';
        Column.Title.Caption := '客户编码';
      end;
    1:begin
        Column := DBGridEh1.Columns.Add;
        Column.Width := 159;
        Column.FieldName := 'GODS_NAME';
        Column.Title.Caption := '商品名称';
        Column.Footer.Alignment := taCenter;
        Column.Footer.ValueType := fvtStaticText;
        Column.Footer.Value := '合计';
        Column := DBGridEh1.Columns.Add;
        Column.Width := 70;
        Column.FieldName := 'GODS_CODE';
        Column.Title.Caption := '商品货号';
        Column := DBGridEh1.Columns.Add;
        Column.Width := 104;
        Column.FieldName := 'BARCODE';
        Column.Title.Caption := '条型码';
        Column := DBGridEh1.Columns.Add;
        Column.Width := 27;
        Column.FieldName := 'UNIT_ID';
        Column.Title.Caption := '单位';
        Column := DBGridEh1.Columns.Add;
        Column.Width := 62;
        Column.FieldName := 'SALE_AMOUNT';
        Column.Title.Caption := '销量';
        Column.DisplayFormat := '#0.###';
        Column.Footer.DisplayFormat := '#0.###';
        Column.Alignment := taRightJustify;
        Column.Footer.ValueType := fvtSum;
        Column.Footer.Alignment := taRightJustify;
      end;
    end;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'SALE_MONEY';
    Column.Title.Caption := '销售金额';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'SALE_TAX';
    Column.Title.Caption := '销项税额';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'OUT_MONEY';
    Column.Title.Caption := '成本';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'SALE_PRF';
    Column.Title.Caption := '毛利';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 55;
    Column.FieldName := 'PRF_RATE';
    Column.Title.Caption := '毛利率';
    Column.DisplayFormat := '#0.0%';
    Column.Footer.DisplayFormat := '#0.0%';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 38;
    Column.FieldName := 'TOOL_NAV';
    Column.Title.Caption := '操作';
    for i:=0 to DBGridEh1.Columns.Count-1 do
      DBGridEh1.Columns[i].Title.Color := ColumnTitleColor;
  finally
    DBGridEh1.FrozenCols := 1;
    DBGridEh1.Columns.EndUpdate;
  end;
  Column := FindColumn(DBGridEH1,'UNIT_ID');
  if not Assigned(Column) then Exit;
  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      rs.Next;
    end;
end;

procedure TfrmProfitReport.CreateGrid2;
var
  Column:TColumnEh;
  rs:TZQuery;
  i:integer;
begin
  DBGridEh2.Columns.BeginUpdate;
  DBGridEh2.FrozenCols := 0;
  try
    DBGridEh2.Columns.Clear;
    Column := DBGridEh2.Columns.Add;
    Column.Width := 28;
    Column.FieldName := 'SEQNO';
    Column.Title.Caption := '序号';
    case edtReportType.ItemIndex of
    0:begin
        Column := DBGridEh2.Columns.Add;
        Column.Width := 159;
        Column.FieldName := 'GODS_NAME';
        Column.Title.Caption := '商品名称';
        Column.Footer.ValueType := fvtStaticText;
        Column.Footer.Alignment := taCenter;
        Column.Footer.Value := '合计';
        Column := DBGridEh2.Columns.Add;
        Column.Width := 70;
        Column.FieldName := 'GODS_CODE';
        Column.Title.Caption := '商品货号';
        Column := DBGridEh2.Columns.Add;
        Column.Width := 104;
        Column.FieldName := 'BARCODE';
        Column.Title.Caption := '条型码';
        Column := DBGridEh2.Columns.Add;
        Column.Width := 27;
        Column.FieldName := 'UNIT_ID';
        Column.Title.Caption := '单位';
      end;
    1:begin
        Column := DBGridEh2.Columns.Add;
        Column.Width := 272;
        Column.FieldName := 'CLIENT_NAME';
        Column.Title.Caption := '客户名称';
        Column.Footer.ValueType := fvtStaticText;
        Column.Footer.Alignment := taCenter;
        Column.Footer.Value := '合计';
        Column := DBGridEh2.Columns.Add;
        Column.Width := 113;
        Column.FieldName := 'CLIENT_CODE';
        Column.Title.Caption := '客户编码';
      end;
    end;
    Column := DBGridEh2.Columns.Add;
    Column.Width := 62;
    Column.FieldName := 'SALE_AMOUNT';
    Column.Title.Caption := '销量';
    Column.DisplayFormat := '#0.###';
    Column.Footer.DisplayFormat := '#0.###';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh2.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'SALE_MONEY';
    Column.Title.Caption := '销售金额';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh2.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'SALE_TAX';
    Column.Title.Caption := '销项税额';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh2.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'OUT_MONEY';
    Column.Title.Caption := '成本';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh2.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'SALE_PRF';
    Column.Title.Caption := '毛利';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh2.Columns.Add;
    Column.Width := 55;
    Column.FieldName := 'PRF_RATE';
    Column.Title.Caption := '毛利率';
    Column.DisplayFormat := '#0.0%';
    Column.Footer.DisplayFormat := '#0.0%';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh2.Columns.Add;
    Column.Width := 38;
    Column.FieldName := 'TOOL_NAV';
    Column.Title.Caption := '操作';
    for i:=0 to DBGridEh1.Columns.Count-1 do
      DBGridEh1.Columns[i].Title.Color := ColumnTitleColor;
  finally
    DBGridEh2.FrozenCols := 1;
    DBGridEh2.Columns.EndUpdate;
  end;
  Column := FindColumn(DBGridEH2,'UNIT_ID');
  if not Assigned(Column) then Exit;
  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  rs.First;
  while not rs.Eof do
    begin
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      rs.Next;
    end;
end;

procedure TfrmProfitReport.OpenChart;
begin
  openReport1;
  PageControl.ActivePageIndex := 2;
  PageControlChange(nil);
  CreateChart
end;

procedure TfrmProfitReport.CreateChart;
var
  rs:TZQuery;
  recNo:integer;
begin
  rs := TZQuery.Create(nil);
  try
    rs.Data := cdsReport1.Data;
    if not edtChar1Type.Checked then
       rs.SortedFields := 'SALE_MONEY desc'
    else
       rs.SortedFields := 'SALE_PRF desc';
    recNo := 0;
    Chart1.Series[0].Clear;
    rs.First;
    while not rs.Eof do
      begin
        inc(recNo);
        if recNo > (edtTopNum.ItemIndex+5) then break;
        case edtReportType.ItemIndex of
        0:begin
            if not edtChar1Type.Checked then
               Chart1.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,rs.FieldbyName('CLIENT_NAME').AsString)
            else
               Chart1.Series[0].Add(rs.FieldbyName('SALE_PRF').AsFloat,rs.FieldbyName('CLIENT_NAME').AsString);
          end;
        1:begin
            if not edtChar1Type.Checked then
               Chart1.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,rs.FieldbyName('GODS_NAME').AsString)
            else
               Chart1.Series[0].Add(rs.FieldbyName('SALE_PRF').AsFloat,rs.FieldbyName('GODS_NAME').AsString);
          end;
        end;
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

procedure TfrmProfitReport.edtChar1TypeClick(Sender: TObject);
begin
  inherited;
  if edtChar1Type.Checked then
     begin
       Chart1.Title.Text.Text := '盈利排行榜';
       RzLabel1.Caption := '盈利前';
     end
  else
     begin
       Chart1.Title.Text.Text := '销售排行榜';
       RzLabel1.Caption := '销售前';
     end;
end;

procedure TfrmProfitReport.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  if D1.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  if D2.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  case PageControl.ActivePageIndex of
  0:OpenReport1;
  1:OpenReport2;
  2:OpenChart;
  end;
end;

procedure TfrmProfitReport.btnPriorClick(Sender: TObject);
begin
  inherited;
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
  list.Down := (PageControl.ActivePageIndex<>1);
  RzPanel11.Visible := true;
  edtCLIENT_ID.Properties.ReadOnly := false;
  edtGODS_ID.Properties.ReadOnly := false;
  dateFlag.Properties.ReadOnly := false;
  edtReportType.Properties.ReadOnly := false;
  D1.Properties.ReadOnly := false;
  D2.Properties.ReadOnly := false;
  RzBmpButton4.Caption := '统计';

end;

procedure TfrmProfitReport.PageControlChange(Sender: TObject);
begin
  inherited;
  btnPrior.Visible := PageControl.ActivePageIndex>0;

end;

procedure TfrmProfitReport.cdsReport1BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav.Visible := false;

end;

procedure TfrmProfitReport.cdsReport2BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav2.Visible := false;

end;

procedure TfrmProfitReport.FormDestroy(Sender: TObject);
begin
  WTitle1.Free;
  WTitle2.Free;
  inherited;

end;

procedure TfrmProfitReport.FormCreate(Sender: TObject);
begin
  inherited;
  WTitle1 := TStringList.Create;
  WTitle2 := TStringList.Create;

end;

procedure TfrmProfitReport.DBGridPrint;
var
  ReStr:string;
begin
  case PageControl.ActivePageIndex of
  0,2:begin
      PrintDBGridEh1.DBGridEh := DBGridEh1;
      PrintDBGridEh1.PageHeader.CenterText.Text := '盈利分析报表';
      ReStr:=FormatReportHead(WTitle1,4);
      DBGridEh1.DBGridTitle := '盈利分析报表';
      DBGridEh1.DBGridHeader.Text := FormatExportHead(WTitle1,4);
      DBGridEh1.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    end;
  1:begin
      PrintDBGridEh1.DBGridEh := DBGridEh2;
      PrintDBGridEh1.PageHeader.CenterText.Text := '盈利分析报表';
      ReStr:=FormatReportHead(WTitle2,4);
      DBGridEh2.DBGridTitle := '盈利分析报表';
      DBGridEh2.DBGridHeader.Text := FormatExportHead(WTitle2,4);
      DBGridEh2.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    end;
  end;
  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+token.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
end;

procedure TfrmProfitReport.edtGODS_IDClearValue(Sender: TObject);
begin
  inherited;
  edtGODS_ID.KeyValue := null;
  edtGODS_ID.Text := '所有商品';
end;

procedure TfrmProfitReport.edtCLIENT_IDClearValue(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.KeyValue := null;
  edtCLIENT_ID.Text := '所有客户';
end;

procedure TfrmProfitReport.listClick(Sender: TObject);
begin
  inherited;
  PageControl.ActivePageIndex := 0;
  OpenReport1;
end;

procedure TfrmProfitReport.chartClick(Sender: TObject);
begin
  inherited;
  PageControl.ActivePageIndex := 2;
  OpenChart;
end;

procedure TfrmProfitReport.DBGridEh1GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if trim(UpperCase(Column.FieldName)) = 'PRF_RATE' then
     begin
       if Column.Footer.ValueType<>fvtStaticText then Column.Footer.ValueType:=fvtStaticText;
       if SumMny <> 0 then
          Text:=FormatFloat(Column.DisplayFormat,SumPrf*100/SumMny)
       else
          Text:=FormatFloat(Column.DisplayFormat,0);
     end;
end;

procedure TfrmProfitReport.DBGridEh2GetFooterParams(Sender: TObject;
  DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
  var Background: TColor; var Alignment: TAlignment; State: TGridDrawState;
  var Text: String);
begin
  inherited;
  if trim(UpperCase(Column.FieldName)) = 'PRF_RATE' then
     begin
       if Column.Footer.ValueType<>fvtStaticText then Column.Footer.ValueType:=fvtStaticText;
       if SumMny <> 0 then
          Text:=FormatFloat(Column.DisplayFormat,SumPrf*100/SumMny)
       else
          Text:=FormatFloat(Column.DisplayFormat,0);
     end;
end;

procedure TfrmProfitReport.linkToStockClick(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'当前版本不支持此功能','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

initialization
  RegisterClass(TfrmProfitReport);
finalization
  UnRegisterClass(TfrmProfitReport);
end.
