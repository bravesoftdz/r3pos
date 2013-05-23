unit ufrmAnlyReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmReportForm, StdCtrls, RzLabel, RzButton, RzTabs, ExtCtrls,
  RzPanel, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,ZBase,
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
    edtChar1Type: TcxRadioButton;
    edtChar2Type: TcxRadioButton;
    RzPanel26: TRzPanel;
    RzPanel27: TRzPanel;
    RzBackground4: TRzBackground;
    RzLabel6: TRzLabel;
    edtDataSource: TcxComboBox;
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
  private
    { Private declarations }
    WTitle1:TStringList;
  public
    { Public declarations }
    procedure OpenReport1;
    procedure showForm;override;
    procedure CreateChart;
    procedure OpenChart;
    procedure CalcClientNum(var rs:TZQuery;filterStr:string);
  end;

  const
    weekList: Array[0..6] of string=('星期天','星期一','星期二','星期三','星期四','星期五','星期六');
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
  vStr:string;
begin
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);

  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',D2.Date));  //结束日期
  //RckMaxDate:=CheckAccDate(vBegDate,vEndDate);   //取日结帐最大日期:

//  if RckMaxDate < vEndDate then
//     begin
       //没有计算，需重计算流水
       //if not TfrmStocksCalc.Calc(self,D2.Date) then Exit;
//     end;
  cdsReport1.close;
  case edtReportType.ItemIndex of
  0:begin
      WTitle1.Clear;
      WTitle1.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
      WTitle1.add(edtReportType.Text+'：'+edtCLIENT_ID.Text);
      if edtChar1Type.Checked then
      begin
        cdsReport1.SQL.Text :=
           'SELECT SUBSTR(CREA_DATE,12,2) as HOUR, SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,'''' AS SALES_DATE,'+
           'SUM(CALC_AMOUNT) AS SALE_AMOUNT,SUM(CALC_MONEY) AS SALE_MONEY '+
           'FROM SAL_SALESORDER SO,SAL_SALESDATA SD '+
           'WHERE SO.TENANT_ID=SD.TENANT_ID AND SO.SHOP_ID=SD.SHOP_ID AND SO.SALES_ID=SD.SALES_ID AND SO.SALES_TYPE=''4'' '+
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
        cdsReport1.SQL.Text :=
         'SELECT '''' as HOUR, SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,'+
         'SUM(CALC_AMOUNT) AS SALE_AMOUNT,SUM(CALC_MONEY) AS SALE_MONEY '+
         'FROM SAL_SALESORDER SO,SAL_SALESDATA SD '+
         'WHERE SO.TENANT_ID=SD.TENANT_ID AND SO.SHOP_ID=SD.SHOP_ID AND SO.SALES_ID=SD.SALES_ID AND SO.SALES_TYPE=''4'' '+
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
      cdsReport1.SQL.Text :=
         'SELECT SUBSTR(CREA_DATE,12,2) as HOUR, SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,'''' AS SALES_DATE,'+
         'SUM(CALC_AMOUNT) AS SALE_AMOUNT,SUM(CALC_MONEY) AS SALE_MONEY '+ vStr+
         'FROM SAL_SALESORDER SO,SAL_SALESDATA SD '+
         'WHERE SO.TENANT_ID=SD.TENANT_ID AND SO.SHOP_ID=SD.SHOP_ID AND SO.SALES_ID=SD.SALES_ID AND SO.SALES_TYPE=''4'' '+
         'AND SO.TENANT_ID=:TENANT_ID AND SO.SALES_DATE>=:D1 AND SO.SALES_DATE<=:D2 ';

      if FnString.TrimRight(token.shopId,4)<>'0001' then
         cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SD.SHOP_ID=:SHOP_ID ';
      if edtGODS_ID.AsString <> '' then
         begin
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SD.GODS_ID=:GODS_ID ';
         end;
      cdsReport1.SQL.Text := cdsReport1.SQL.Text +'GROUP BY SO.TENANT_ID,SO.SHOP_ID,SUBSTR(CREA_DATE,12,2)'+vStr+' ORDER BY SUBSTR(CREA_DATE,12,2) ';
      end else
      begin
        cdsReport1.SQL.Text :=
         'SELECT '''' as HOUR, SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,'+
         'SUM(CALC_AMOUNT) AS SALE_AMOUNT,SUM(CALC_MONEY) AS SALE_MONEY '+vStr+
         'FROM SAL_SALESORDER SO,SAL_SALESDATA SD '+
         'WHERE SO.TENANT_ID=SD.TENANT_ID AND SO.SHOP_ID=SD.SHOP_ID AND SO.SALES_ID=SD.SALES_ID AND SO.SALES_TYPE=''4'' '+
         'AND SO.TENANT_ID=:TENANT_ID AND SO.SALES_DATE>=:D1 AND SO.SALES_DATE<=:D2 ';

      if FnString.TrimRight(token.shopId,4)<>'0001' then
         cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SD.SHOP_ID=:SHOP_ID ';
      if edtGODS_ID.AsString <> '' then
         begin
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SD.GODS_ID=:GODS_ID ';
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
  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');
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
             end;
          end
          else
          begin
             i:=DayofWeek(FnTime.fnStrtoDate(rs.FieldbyName('SALES_DATE').AsString));
             case edtDataSource.ItemIndex of
               0:Chart2.Series[0].Add(rs.FieldbyName('CLIENTNUM').AsFloat,weekList[i-1]);
               1:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,weekList[i-1]);
               2:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,weekList[i-1]);
             end;
          end;
          0:
          if edtChar1Type.Checked then
          begin
             case edtDataSource.ItemIndex of
               0:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,rs.FieldbyName('HOUR').AsString);
               1:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,rs.FieldbyName('HOUR').AsString);
             end;
          end
          else
          begin
             i:=DayofWeek(FnTime.fnStrtoDate(rs.FieldbyName('SALES_DATE').AsString));
             case edtDataSource.ItemIndex of
               0:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,weekList[i-1]);
               1:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,weekList[i-1]);
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
var ss:TZQuery;
    item:TRecord_;
begin
  
  if cdsReport1.IsEmpty then exit;
  ss:=TZQuery.Create(nil);
  ss.SQL.Text:='SELECT '''' as HOUR, SO.TENANT_ID,SO.SHOP_ID,0 AS CLIENTNUM,SO.SALES_DATE,'+
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

initialization
  RegisterClass(TfrmAnlyReport);
finalization
  UnRegisterClass(TfrmAnlyReport);
end.
