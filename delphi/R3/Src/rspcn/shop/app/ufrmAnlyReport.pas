unit ufrmAnlyReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmReportForm, StdCtrls, RzLabel, RzButton, RzTabs, ExtCtrls,
  RzPanel, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,ZBase,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, TeeProcs, TeEngine,
  Chart, Series, cxRadioGroup, RzBmpBtn, RzBckgnd, pngimage,udllShopUtil,
  PrnDbgeh,Clipbrd;

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
    edtChar1Type: TcxRadioButton;
    edtChar2Type: TcxRadioButton;
    RzPanel26: TRzPanel;
    RzPanel27: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel6: TRzLabel;
    edtDataSource: TcxComboBox;
    PrintDialog1: TPrintDialog;
    procedure dateFlagPropertiesChange(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure edtGODS_IDClearValue(Sender: TObject);
    procedure edtCLIENT_IDClearValue(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtReportTypePropertiesChange(Sender: TObject);
    procedure chartClick(Sender: TObject);
    procedure RzBmpButton2Click(Sender: TObject);
    procedure RzBmpButton3Click(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure edtChar1TypeClick(Sender: TObject);
    procedure edtChar2TypeClick(Sender: TObject);
    procedure edtDataSourcePropertiesChange(Sender: TObject);
  private
    WTitle1:TStringList;
  public
    procedure OpenReport1;
    procedure showForm;override;
    procedure CreateChart;
    procedure CreateChartText;
    procedure OpenChart;
    procedure CalcClientNum(var rs:TZQuery;filterStr:string);
    procedure CalcWeek(var rs:TZQuery;filterStr:string);
    function IsProfit:Boolean;
  end;

const
  weekList: Array[0..6] of string=('星期天','星期一','星期二','星期三','星期四','星期五','星期六');

var frmAnlyReport: TfrmAnlyReport;

implementation

uses udataFactory,utokenFactory,uFnUtil,udllGlobal,ufrmStocksCalc,objCommon,printers;

{$R *.dfm}

function TfrmAnlyReport.IsProfit:Boolean;
begin
  result:=false;
  if ((edtReportType.ItemIndex=0) and (edtDataSource.ItemIndex=2)) or ((edtReportType.ItemIndex=1) and (edtDataSource.ItemIndex=3)) then
     result:=true;
end;

procedure TfrmAnlyReport.OpenReport1;
var
  vBegDate,            //查询开始日期
  vEndDate: integer;   //查询结束日期
  RckMaxDate: integer; //台帐最大日期
  vStr:string;
begin
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);

  if D1.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  if D2.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',D2.Date));  //结束日期

  if IsProfit then
  begin
    RckMaxDate:=CheckAccDate(vBegDate,vEndDate);   //取日结帐最大日期:
    //if RckMaxDate < vEndDate then
    //   begin
         //没有计算，需重计算流水
         if not TfrmStocksCalc.Calc(self,D2.Date) then Exit;
    //   end;
  end;
  cdsReport1.close;
  case edtReportType.ItemIndex of
  0:begin
      WTitle1.Clear;
      WTitle1.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
      WTitle1.add(edtReportType.Text+'：'+edtCLIENT_ID.Text);
      if edtChar1Type.Checked then
      begin
        if IsProfit then
        cdsReport1.SQL.Text :=
           'SELECT SUBSTR(CREA_DATE,12,2) as HOUR,'''' as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,'''' AS SALES_DATE,'+
           'SUM(RS.SALE_MONEY-RS.OUT_MONEY) as SALE_PRF '+
           'FROM SAL_SALESORDER SO,RCK_STOCKS_DATA RS '+
           'WHERE SO.TENANT_ID=RS.TENANT_ID AND SO.SHOP_ID=RS.SHOP_ID AND SO.SALES_ID=RS.BILL_ID AND RS.BILL_TYPE in (21,23,24) '+
           'AND SO.TENANT_ID=:TENANT_ID AND SO.SALES_DATE>=:D1 AND SO.SALES_DATE<=:D2 and RS.TENANT_ID=:TENANT_ID and RS.BILL_DATE>=:D1 and RS.BILL_DATE<=:D2 '
        else
        cdsReport1.SQL.Text :=
           'SELECT SUBSTR(CREA_DATE,12,2) as HOUR,'''' as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,'''' AS SALES_DATE,'+
           'SUM(CALC_AMOUNT) AS SALE_AMOUNT,SUM(CALC_MONEY) AS SALE_MONEY '+
           'FROM SAL_SALESORDER SO,SAL_SALESDATA SD '+
           'WHERE SO.TENANT_ID=SD.TENANT_ID AND SO.SHOP_ID=SD.SHOP_ID AND SO.SALES_ID=SD.SALES_ID AND SO.SALES_TYPE=4 '+
           'AND SO.TENANT_ID=:TENANT_ID AND SO.SALES_DATE>=:D1 AND SO.SALES_DATE<=:D2 ';

        if FnString.TrimRight(token.shopId,4)<>'0001' then
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SO.SHOP_ID=:SHOP_ID ';
        if edtCLIENT_ID.AsString <> '' then
           begin
             cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SO.CLIENT_ID=:CLIENT_ID ';
           end;
        cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by SO.TENANT_ID,SO.SHOP_ID,SUBSTR(CREA_DATE,12,2) ';
      end else
      begin
        if IsProfit then
        cdsReport1.SQL.Text :=
         'SELECT '''' as HOUR,'''' as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,'+
         'SUM(RS.SALE_MONEY-RS.OUT_MONEY) as SALE_PRF '+
         'FROM SAL_SALESORDER SO,RCK_STOCKS_DATA RS '+
         'WHERE SO.TENANT_ID=RS.TENANT_ID AND SO.SHOP_ID=RS.SHOP_ID AND SO.SALES_ID=RS.BILL_ID AND RS.BILL_TYPE in (21,23,24) '+
         'AND SO.TENANT_ID=:TENANT_ID AND SO.SALES_DATE>=:D1 AND SO.SALES_DATE<=:D2 and RS.TENANT_ID=:TENANT_ID and RS.BILL_DATE>=:D1 and RS.BILL_DATE<=:D2 '
        else
        cdsReport1.SQL.Text :=
         'SELECT '''' as HOUR,'''' as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,'+
         'SUM(CALC_AMOUNT) AS SALE_AMOUNT,SUM(CALC_MONEY) AS SALE_MONEY '+
         'FROM SAL_SALESORDER SO,SAL_SALESDATA SD '+
         'WHERE SO.TENANT_ID=SD.TENANT_ID AND SO.SHOP_ID=SD.SHOP_ID AND SO.SALES_ID=SD.SALES_ID AND SO.SALES_TYPE=4 '+
         'AND SO.TENANT_ID=:TENANT_ID AND SO.SALES_DATE>=:D1 AND SO.SALES_DATE<=:D2 ';

        if FnString.TrimRight(token.shopId,4)<>'0001' then
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SO.SHOP_ID=:SHOP_ID ';
        if edtCLIENT_ID.AsString <> '' then
           begin
             cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SO.CLIENT_ID=:CLIENT_ID ';
           end;
        cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by SO.TENANT_ID,SO.SHOP_ID,SALES_DATE ';
      end;

      cdsReport1.SQL.Text :=ParseSQL(dataFactory.iDbType,cdsReport1.SQL.Text);
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
      if edtDataSource.ItemIndex=0 then
        vStr:=',SO.SALES_ID,SO.CLIENT_ID '
      else
        vStr:='';

      if edtChar1Type.Checked then
      begin
      if IsProfit then
      cdsReport1.SQL.Text :=
         'SELECT SUBSTR(CREA_DATE,12,2) as HOUR,'''' as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,'''' AS SALES_DATE,'+
         'SUM(RS.SALE_MONEY-RS.OUT_MONEY) as SALE_PRF '+
         'FROM SAL_SALESORDER SO,RCK_STOCKS_DATA RS '+
         'WHERE SO.TENANT_ID=RS.TENANT_ID AND SO.SHOP_ID=RS.SHOP_ID AND SO.SALES_ID=RS.BILL_ID AND RS.BILL_TYPE in (21,23,24) '+
         'AND SO.TENANT_ID=:TENANT_ID AND SO.SALES_DATE>=:D1 AND SO.SALES_DATE<=:D2 AND RS.TENANT_ID=:TENANT_ID AND RS.BILL_DATE>=:D1 AND RS.BILL_DATE<=:D2 '
      else
      cdsReport1.SQL.Text :=
         'SELECT SUBSTR(CREA_DATE,12,2) as HOUR,'''' as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,'''' AS SALES_DATE,'+
         'SUM(CALC_AMOUNT) AS SALE_AMOUNT,SUM(CALC_MONEY) AS SALE_MONEY '+ vStr+
         'FROM SAL_SALESORDER SO,SAL_SALESDATA SD '+
         'WHERE SO.TENANT_ID=SD.TENANT_ID AND SO.SHOP_ID=SD.SHOP_ID AND SO.SALES_ID=SD.SALES_ID AND SO.SALES_TYPE=4 '+
         'AND SO.TENANT_ID=:TENANT_ID AND SO.SALES_DATE>=:D1 AND SO.SALES_DATE<=:D2 ';

      if FnString.TrimRight(token.shopId,4)<>'0001' then
         cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SD.SHOP_ID=:SHOP_ID ';
      if edtGODS_ID.AsString <> '' then
         begin
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and GODS_ID=:GODS_ID ';
         end;
      cdsReport1.SQL.Text := cdsReport1.SQL.Text +'GROUP BY SO.TENANT_ID,SO.SHOP_ID,SUBSTR(CREA_DATE,12,2)'+vStr+' ORDER BY SUBSTR(CREA_DATE,12,2) ';
      end else
      begin
        if IsProfit then
        cdsReport1.SQL.Text :=
         'SELECT '''' as HOUR,'''' as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,'+
         'SUM(RS.SALE_MONEY-RS.OUT_MONEY) as SALE_PRF '+
         'FROM SAL_SALESORDER SO,RCK_STOCKS_DATA RS '+
         'WHERE SO.TENANT_ID=RS.TENANT_ID AND SO.SHOP_ID=RS.SHOP_ID AND SO.SALES_ID=RS.BILL_ID AND RS.BILL_TYPE in (21,23,24) '+
         'AND SO.TENANT_ID=:TENANT_ID and SO.SALES_DATE>=:D1 and SO.SALES_DATE<=:D2 and RS.TENANT_ID=:TENANT_ID and RS.BILL_DATE>=:D1 and RS.BILL_DATE<=:D2  '
        else
        cdsReport1.SQL.Text :=
         'SELECT '''' as HOUR,'''' as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,'+
         'SUM(CALC_AMOUNT) AS SALE_AMOUNT,SUM(CALC_MONEY) AS SALE_MONEY '+vStr+
         'FROM SAL_SALESORDER SO,SAL_SALESDATA SD '+
         'WHERE SO.TENANT_ID=SD.TENANT_ID AND SO.SHOP_ID=SD.SHOP_ID AND SO.SALES_ID=SD.SALES_ID AND SO.SALES_TYPE=4 '+
         'AND SO.TENANT_ID=:TENANT_ID and SO.SALES_DATE>=:D1 and SO.SALES_DATE<=:D2 ';

      if FnString.TrimRight(token.shopId,4)<>'0001' then
         cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SD.SHOP_ID=:SHOP_ID ';
      if edtGODS_ID.AsString <> '' then
         begin
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and GODS_ID=:GODS_ID ';
         end;
      cdsReport1.SQL.Text := cdsReport1.SQL.Text +'GROUP BY SO.TENANT_ID,SO.SHOP_ID,SO.SALES_DATE'+vStr+' ORDER BY SO.SALES_DATE ';
      end;

      cdsReport1.SQL.Text :=ParseSQL(dataFactory.iDbType,cdsReport1.SQL.Text);

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
  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CUSTOMER');
  edtGODS_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  edtReportType.ItemIndex := 1; 
end;

procedure TfrmAnlyReport.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
  0:OpenChart;
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

procedure TfrmAnlyReport.CreateChartText;
var i:integer;
begin
  if edtReportType.ItemIndex= 0 then
     i:=1
  else
     i:=0;

  if edtChar1Type.Checked then
    begin
       Chart2.BottomAxis.Title.Caption:='时点(小时)';
       case edtDataSource.ItemIndex+i of
         0:begin
           Chart2.Title.Text.Text:='时段客流量分析表';
           Chart2.LeftAxis.Title.Caption:='客流量';
           end;
         1:begin
           Chart2.Title.Text.Text:='时段销售量分析表';
           Chart2.LeftAxis.Title.Caption:='销售量';
           end;
         2:begin
           Chart2.Title.Text.Text:='时段销售额分析表';
           Chart2.LeftAxis.Title.Caption:='销售额';
           end;
       end;
    end
    else
    begin
       Chart2.BottomAxis.Title.Caption:='';
       case edtDataSource.ItemIndex+i of
         0:begin
           Chart2.Title.Text.Text:='周客流量分析表';
           Chart2.LeftAxis.Title.Caption:='客流量';
           end;
         1:begin
           Chart2.Title.Text.Text:='周销售量分析表';
           Chart2.LeftAxis.Title.Caption:='销售量';
           end;
         2:begin
           Chart2.Title.Text.Text:='周销售额分析表';
           Chart2.LeftAxis.Title.Caption:='销售额';
           end;
       end;
    end;
end;

procedure TfrmAnlyReport.CreateChart;
var
  rs:TZQuery;
  recNo:integer;
  i:integer;
begin
  rs := TZQuery.Create(nil);
  try
    Chart2.Series[0].Clear;
    if cdsReport1.RecordCOunt=0 then exit;

    rs.Data := cdsReport1.Data;
    if edtChar1Type.Checked then
       rs.SortedFields := 'HOUR'
    else
       rs.SortedFields := 'SALES_DATE';

    if (edtReportType.ItemIndex=1) and (edtDataSource.ItemIndex=0) then
       CalcClientNum(rs,rs.SortedFields);

    if edtChar2Type.Checked then
    begin
       CalcWeek(rs,rs.SortedFields);
    end;

    CreateChartText;
    rs.First;
    while not rs.Eof do
      begin
        case edtReportType.ItemIndex of
          1:
          if edtChar1Type.Checked then
          begin
             case edtDataSource.ItemIndex of
               0:Chart2.Series[0].Add(rs.FieldbyName('CLIENTNUM').AsFloat,rs.FieldbyName('HOUR').AsString);
               1:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,rs.FieldbyName('HOUR').AsString);
               2:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,rs.FieldbyName('HOUR').AsString);
               3:Chart2.Series[0].Add(rs.FieldbyName('SALE_PRF').AsFloat,rs.FieldbyName('HOUR').AsString);
             end;
          end
          else
          begin
             i:=rs.FieldbyName('WEEK').AsInteger;
             case edtDataSource.ItemIndex of
               0:Chart2.Series[0].Add(rs.FieldbyName('CLIENTNUM').AsFloat,weekList[i-1]);
               1:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,weekList[i-1]);
               2:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,weekList[i-1]);
               3:Chart2.Series[0].Add(rs.FieldbyName('SALE_PRF').AsFloat,weekList[i-1]);
             end;
          end;
          0:
          if edtChar1Type.Checked then
          begin
             case edtDataSource.ItemIndex of
               0:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,rs.FieldbyName('HOUR').AsString);
               1:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,rs.FieldbyName('HOUR').AsString);
               2:Chart2.Series[0].Add(rs.FieldbyName('SALE_PRF').AsFloat,rs.FieldbyName('HOUR').AsString);
             end;
          end
          else
          begin
             //i:=DayofWeek(FnTime.fnStrtoDate(rs.FieldbyName('SALES_DATE').AsString));
             i:=rs.FieldbyName('WEEK').AsInteger;
             case edtDataSource.ItemIndex of
               0:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,weekList[i-1]);
               1:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,weekList[i-1]);
               2:Chart2.Series[0].Add(rs.FieldbyName('SALE_PRF').AsFloat,weekList[i-1]);
             end;
          end;
        end;
        rs.Next;
      end;
  finally
    rs.Free;
  end;
end;

procedure TfrmAnlyReport.edtReportTypePropertiesChange(Sender: TObject);
var index:integer;
begin
  inherited;
  edtCLIENT_ID.Visible := (edtReportType.ItemIndex=0);
  edtGODS_ID.Visible := (edtReportType.ItemIndex>0);
  edtDataSource.Properties.Items.Clear;
  if edtReportType.ItemIndex=1 then
    edtDataSource.Properties.Items.Add('客流量');
  edtDataSource.Properties.Items.Add('销售量');
  edtDataSource.Properties.Items.Add('销售额');
  edtDataSource.Properties.Items.Add('毛利');
  edtDataSource.ItemIndex:=0;
end;

procedure TfrmAnlyReport.chartClick(Sender: TObject);
begin
  inherited;
  OpenChart;
end;

procedure TfrmAnlyReport.OpenChart;
begin
  openReport1;
  CreateChart;
end;

procedure TfrmAnlyReport.CalcClientNum(var rs: TZQuery;filterStr:string);
var
  ss:TZQuery;
  item:TRecord_;
begin
  if cdsReport1.IsEmpty then exit;
  ss:=TZQuery.Create(nil);
  ss.SQL.Text:='SELECT 0 as HOUR,0 as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,'+
         '0 AS SALE_AMOUNT,0 AS SALE_MONEY '+
         'FROM SAL_SALESORDER SO '+
         'WHERE  1=2 ';
  dataFactory.Open(ss);

  cdsReport1.First;
  while not cdsReport1.Eof do
  begin
    rs.Filtered:=False;
    rs.Filter:=filterStr+ '='''+cdsReport1.fieldByName(filterStr).AsString+'''';
    rs.Filtered:=True;

    if (ss.IsEmpty) or (not ss.Locate(filterStr,cdsReport1.fieldByName(filterStr).AsString,[])) then
    begin
      ss.Append;
      item:=TRecord_.Create;
      item.ReadFromDataSet(cdsReport1);
      item.FieldByName('CLIENTNUM').AsString:=inttostr(rs.RecordCount);
      item.WriteToDataSet(ss);
      ss.Post;
    end;
    cdsReport1.Next;
  end;
  rs.Filtered:=False;
  
  rs.Close;
  rs.Data:=ss.Data;
  ss.Free;
end;

procedure TfrmAnlyReport.CalcWeek(var rs: TZQuery; filterStr: string);
var
  ss:TZQuery;
  item:TRecord_;
  i:integer;
begin
  ss:=TZQuery.Create(nil);
  ss.SQL.Text:='SELECT 0 as HOUR,0 as WEEK,SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,';

  if IsProfit then
    ss.SQL.Text:=ss.SQL.Text+'0 AS SALE_PRF '
  else
    ss.SQL.Text:=ss.SQL.Text+'0 AS SALE_AMOUNT,0 AS SALE_MONEY ';

  ss.SQL.Text:=ss.SQL.Text+
         'FROM SAL_SALESORDER SO '+
         'WHERE  1=2 ';
  dataFactory.Open(ss);

  rs.First;
  while not rs.Eof do
  begin
    i:=DayofWeek(FnTime.fnStrtoDate(rs.FieldbyName('SALES_DATE').AsString));
    if (ss.IsEmpty) or (not ss.Locate('WEEK',i,[])) then
    begin
      ss.Append;
      item:=TRecord_.Create;
      item.ReadFromDataSet(rs);
      item.FieldByName('WEEK').AsString:=inttostr(i);
      item.WriteToDataSet(ss);
      ss.Post;
    end
    else
    begin
      ss.Edit;
      if IsProfit then
        ss.FieldByName('SALE_PRF').AsFloat:=ss.FieldByName('SALE_PRF').AsFloat+rs.FieldByName('SALE_PRF').AsFloat
      else begin
        ss.FieldByName('SALE_AMOUNT').AsFloat:=ss.FieldByName('SALE_AMOUNT').AsFloat+rs.FieldByName('SALE_AMOUNT').AsFloat;
        ss.FieldByName('SALE_MONEY').AsFloat:=ss.FieldByName('SALE_MONEY').AsFloat+rs.FieldByName('SALE_MONEY').AsFloat;
        ss.FieldByName('CLIENTNUM').AsFloat:=ss.FieldByName('CLIENTNUM').AsFloat+rs.FieldByName('CLIENTNUM').AsFloat;
      end;
      ss.Post;
    end;
    rs.Next;
  end;
  rs.Close;
  ss.SortedFields:='WEEK';
  rs.Data:=ss.Data;
  ss.Free;
end;

procedure TfrmAnlyReport.RzBmpButton2Click(Sender: TObject);
var
  formImage:TBitmap;
  myImage:TImage;
  saveDialog:TSaveDialog;
begin
  //inherited;
  saveDialog1.DefaultExt:='*.bmp';
  saveDialog1.Filter:='图片格式(*.bmp)';
  if saveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '已经存在，是否覆盖它？'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        exit;
      DeleteFile(SaveDialog1.FileName);
    end;
  end;
  formImage:=GetFormImage;
  myImage:=TImage.Create(nil);
  try
    Clipboard.Assign(formImage);
    myImage.Picture.Assign(Clipboard);
    myImage.Picture.SaveToFile(SaveDialog1.FileName);
  finally
    formImage.Free;
    myImage.Free;
  end;
end;

procedure TfrmAnlyReport.RzBmpButton3Click(Sender: TObject);
var
  formImage:TBitmap;
  myImage:TImage;
begin
  //inherited;
  formImage:=GetFormImage;
  myImage:=TImage.Create(nil);
  try
    Clipboard.Assign(formImage);
    myImage.Picture.Assign(Clipboard);
    myImage.Picture.SaveToFile(ExtractFilePath(ParamStr(0))+'built-in\images\exportImage.bmp');
    WinExec(Pchar('rundll32.exe C:\WINDOWS\system32\shimgvw.dll,ImageView_Fullscreen   '+ExtractFilePath(ParamStr(0))+'built-in\images\exportImage.bmp'),SW_NORMAL);
  finally
    formImage.Free;
    myImage.Free;
  end;
end;

procedure TfrmAnlyReport.RzBmpButton1Click(Sender: TObject);
var
  formImage:TBitmap;
  myImage:TImage;
  strect:Trect; //定义打印输出矩形框的大小
  temhi,temwd:integer;
begin
  //inherited;
  formImage:=GetFormImage;
  myImage:=TImage.Create(nil);
  try
    Clipboard.Assign(formImage);
    myImage.Picture.Assign(Clipboard);
    myImage.Picture.SaveToFile(ExtractFilePath(ParamStr(0))+'built-in\images\exportImage.bmp');
    if PrintDialog1.Execute then
    begin
      temhi:=myImage.picture.height;
      temwd:=myImage.picture.width;
      while (temhi<printer.pageheight div 2) and  (temwd<printer.pagewidth div 2) do
      begin
        temhi:=temhi+temhi+temhi;
        temwd:=temwd+temwd+temwd;
      end;
      with strect do //定义图形在页面上的中心位置输出
      begin
        left:=(printer.pagewidth -temwd) div 2;
        top:=(printer.pageheight-temhi) div 2;
        right:=left+temwd;
        bottom:=top+temhi;
      end;
      printer.BeginDoc;
      printer.canvas.StretchDraw(strect,myImage.picture.graphic);
      printer.EndDoc;
    end;
  finally
    formImage.Free;
    myImage.Free;
  end;
end;

procedure TfrmAnlyReport.edtChar1TypeClick(Sender: TObject);
begin
  inherited;
  if cdsReport1.Active then OpenChart;
end;

procedure TfrmAnlyReport.edtChar2TypeClick(Sender: TObject);
begin
  inherited;
  if cdsReport1.Active then OpenChart;
end;

procedure TfrmAnlyReport.edtDataSourcePropertiesChange(Sender: TObject);
begin
  inherited;
  if cdsReport1.Active then OpenChart;
end;

initialization
  RegisterClass(TfrmAnlyReport);
finalization
  UnRegisterClass(TfrmAnlyReport);
end.
