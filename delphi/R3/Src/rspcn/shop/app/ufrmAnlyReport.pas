unit ufrmAnlyReport;

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
  TfrmAnlyReport = class(TfrmReportForm)
    cdsReport1: TZQuery;
    dsReport1: TDataSource;
    cdsReport2: TZQuery;
    dsReport2: TDataSource;
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
    barcode_input_line: TImage;
    list: TRzBmpButton;
    chart: TRzBmpButton;
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel7: TRzPanel;
    RzToolbar1: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolbar2: TRzToolbar;
    Chart2: TChart;
    BarSeries1: TBarSeries;
    RzPanel21: TRzPanel;
    RzPanel24: TRzPanel;
    RzPanel25: TRzPanel;
    RzBackground3: TRzBackground;
    RzLabel5: TRzLabel;
    cxRadioButton1: TcxRadioButton;
    cxRadioButton2: TcxRadioButton;
    RzPanel26: TRzPanel;
    RzPanel27: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel6: TRzLabel;
    cxComboBox1: TcxComboBox;
    procedure dateFlagPropertiesChange(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure edtGODS_IDClearValue(Sender: TObject);
    procedure edtCLIENT_IDClearValue(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    WTitle1:TStringList;
  public
    { Public declarations }
    procedure OpenReport1;
    procedure showForm;override;
  end;

var
  frmAnlyReport: TfrmAnlyReport;

implementation
uses udataFactory,utokenFactory,uFnUtil,udllGlobal,ufrmStocksCalc,objCommon;
{$R *.dfm}

{ TfrmSaleReport }

procedure TfrmAnlyReport.OpenReport1;
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
end;

procedure TfrmAnlyReport.dateFlagPropertiesChange(Sender: TObject);
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

procedure TfrmAnlyReport.showForm;
begin
  inherited;
  dateFlag.ItemIndex := 1;
  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');
  edtGODS_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');

end;


procedure TfrmAnlyReport.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
  0:OpenReport1;
  end;

end;

procedure TfrmAnlyReport.btnPriorClick(Sender: TObject);
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

procedure TfrmAnlyReport.PageControlChange(Sender: TObject);
begin
  inherited;
  btnPrior.Visible := PageControl.ActivePageIndex>0;

end;

procedure TfrmAnlyReport.edtGODS_IDClearValue(Sender: TObject);
begin
  inherited;
  edtGODS_ID.KeyValue := null;
  edtGODS_ID.Text := '所有商品';
end;

procedure TfrmAnlyReport.edtCLIENT_IDClearValue(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.KeyValue := null;
  edtCLIENT_ID.Text := '所有客户';
end;

procedure TfrmAnlyReport.FormCreate(Sender: TObject);
begin
  inherited;
  WTitle1 := TStringList.Create;

end;

procedure TfrmAnlyReport.FormDestroy(Sender: TObject);
begin
  WTitle1.Free;
  inherited;

end;

initialization
  RegisterClass(TfrmAnlyReport);
finalization
  UnRegisterClass(TfrmAnlyReport);
end.
