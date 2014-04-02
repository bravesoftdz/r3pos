unit ufrmAnlyReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmReportForm, StdCtrls, RzLabel, RzButton, RzTabs, ExtCtrls,
  RzPanel, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,ZBase,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, TeeProcs, TeEngine,
  Chart, Series, cxRadioGroup, RzBmpBtn, RzBckgnd, pngimage, udllShopUtil,
  PrnDbgeh, Clipbrd;

type
  TfrmAnlyReport = class(TfrmReportForm)
    cdsReport1: TZQuery;
    dsReport1: TDataSource;
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
    edtReportType: TcxComboBox;
    edtCLIENT_ID: TzrComboBoxList;
    edtGODS_ID: TzrComboBoxList;
    RzPanel16: TRzPanel;
    barcode_input_line: TImage;
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
    RzPanel1: TRzPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    sortDrop: TcxButtonEdit;
    procedure dateFlagPropertiesChange(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
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
    procedure sortDropExit(Sender: TObject);
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private
    FSortId:string;
    WTitle1:TStringList;
  public
    procedure OpenReport1;
    procedure showForm;override;
    procedure CreateChart;
    procedure CreateChartText;
    procedure OpenChart;
    procedure CalcWeek(var rs:TZQuery);
    function  IsProfit:Boolean;
  end;

const
  weekList: Array[0..6] of string=('星期天','星期一','星期二','星期三','星期四','星期五','星期六');

var frmAnlyReport: TfrmAnlyReport;

implementation

uses udataFactory,uTokenFactory,uFnUtil,udllGlobal,ufrmStocksCalc,ObjCommon,printers,
     ufrmSortDropFrom;

{$R *.dfm}

function TfrmAnlyReport.IsProfit:Boolean;
begin
  result:=false;
  if edtDataSource.ItemIndex=3 then result := true;
end;

procedure TfrmAnlyReport.OpenReport1;
begin
  if D1.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  if D2.EditValue = null then Raise Exception.Create('日期条件不能为空!');

  if IsProfit then if not TfrmStocksCalc.Calc(self,D2.Date) then Exit;

  cdsReport1.Close;

  if edtChar1Type.Checked then
     begin
       if IsProfit then
          cdsReport1.SQL.Text :=
            ' select substr(a.CREA_DATE,12,2) as HOUR,a.TENANT_ID,a.SHOP_ID,sum(b.SALE_MONEY-b.OUT_MONEY) as SALE_PRF '+
            ' from   SAL_SALESORDER a,RCK_STOCKS_DATA b '+
            ' where  a.TENANT_ID=b.TENANT_ID and a.SALES_ID=b.BILL_ID and a.SALES_DATE=b.BILL_DATE '+
            '        and a.SALES_TYPE in (1,3,4) and b.BILL_TYPE in (21,23,24) '+
            '        and a.TENANT_ID=:TENANT_ID '+
            '        and a.SALES_DATE>=:D1 and a.SALES_DATE<=:D2 '
       else
          cdsReport1.SQL.Text :=
            ' select substr(a.CREA_DATE,12,2) as HOUR,a.TENANT_ID,a.SHOP_ID,count(distinct a.SALES_ID) as CLIENT_NUM,sum(a.CALC_AMOUNT) as SALE_AMOUNT,sum(a.CALC_MONEY) as SALE_MONEY '+
            ' from   VIW_SALESDATA a '+
            ' where  a.TENANT_ID=:TENANT_ID '+
            '        and a.SALES_DATE>=:D1 and a.SALES_DATE<=:D2 ';
     end
  else
     begin
       if IsProfit then
          cdsReport1.SQL.Text :=
            ' select a.SALES_DATE as WEEK,a.TENANT_ID,a.SHOP_ID,sum(b.SALE_MONEY-b.OUT_MONEY) as SALE_PRF '+
            ' from   SAL_SALESORDER a,RCK_STOCKS_DATA b '+
            ' where  a.TENANT_ID=b.TENANT_ID and a.SALES_ID=b.BILL_ID and a.SALES_DATE=b.BILL_DATE '+
            '        and a.SALES_TYPE in (1,3,4) and b.BILL_TYPE in (21,23,24) '+
            '        and a.TENANT_ID=:TENANT_ID '+
            '        and a.SALES_DATE>=:D1 and a.SALES_DATE<=:D2 '
       else
          cdsReport1.SQL.Text :=
            ' select a.SALES_DATE as WEEK,a.TENANT_ID,a.SHOP_ID,count(distinct a.SALES_ID) as CLIENT_NUM,sum(a.CALC_AMOUNT) as SALE_AMOUNT,sum(a.CALC_MONEY) as SALE_MONEY '+
            ' from   VIW_SALESDATA a '+
            ' where  a.TENANT_ID=:TENANT_ID '+
            '        and a.SALES_DATE>=:D1 and a.SALES_DATE<=:D2 ';
     end;

  if FnString.TrimRight(token.shopId,4)<>'0001' then
     cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and a.SHOP_ID=:SHOP_ID ';

  case edtReportType.ItemIndex of
    0:begin
        WTitle1.Clear;
        WTitle1.add('日期：'+FormatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+FormatDatetime('YYYY-MM-DD',D2.Date));
        WTitle1.add(edtReportType.Text+'：'+edtCLIENT_ID.Text);
        if edtCLIENT_ID.AsString <> '' then
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and a.CLIENT_ID=:CLIENT_ID ';
      end;
    1:begin
        WTitle1.Clear;
        WTitle1.add('日期：'+FormatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+FormatDatetime('YYYY-MM-DD',D2.Date));
        WTitle1.add(edtReportType.Text+'：'+edtGODS_ID.Text);
        if edtGODS_ID.AsString <> '' then
           cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and GODS_ID=:GODS_ID ';
      end;
  end;

  if edtChar1Type.Checked then
     begin
       cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by a.TENANT_ID,a.SHOP_ID,substr(a.CREA_DATE,12,2) ';
     end
  else
     begin
       cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by a.TENANT_ID,a.SHOP_ID,a.SALES_DATE ';
     end;

  cdsReport1.SQL.Text := ParseSQL(dataFactory.iDbType, cdsReport1.SQL.Text);
  cdsReport1.ParamByName('TENANT_ID').AsInteger := StrtoInt(token.tenantId);
  cdsReport1.ParamByName('D1').AsInteger := StrtoInt(FormatDatetime('YYYYMMDD',D1.Date));
  cdsReport1.ParamByName('D2').AsInteger := StrtoInt(FormatDatetime('YYYYMMDD',D2.Date));
  if cdsReport1.Params.FindParam('SHOP_ID')<>nil then cdsReport1.ParamByName('SHOP_ID').AsString := token.shopId;
  if cdsReport1.Params.FindParam('CLIENT_ID')<>nil then cdsReport1.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
  if cdsReport1.Params.FindParam('GODS_ID')<>nil then cdsReport1.ParamByName('GODS_ID').AsString := edtGODS_ID.AsString;

  dataFactory.Open(cdsReport1);
end;

procedure TfrmAnlyReport.dateFlagPropertiesChange(Sender: TObject);
begin
  inherited;
  case dateFlag.ItemIndex of
  0:begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
    end;
  1:begin
      D1.Date := fnTime.fnStrtoDate(FormatDatetime('YYYYMM01',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
    end;
  2:begin
      D1.Date := fnTime.fnStrtoDate(FormatDatetime('YYYY0101',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
    end;
  else
    begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
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
  RzPanel11.Visible := true;
  edtCLIENT_ID.Properties.ReadOnly := false;
  edtGODS_ID.Properties.ReadOnly := false;
  dateFlag.Properties.ReadOnly := false;
  edtReportType.Properties.ReadOnly := false;
  D1.Properties.ReadOnly := false;
  D2.Properties.ReadOnly := false;
  RzBmpButton4.Caption := '统计';
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
  edtDataSource.Properties.Items.Clear;
  edtDataSource.Properties.Items.Add('客流量');
  edtDataSource.Properties.Items.Add('销售量');
  edtDataSource.Properties.Items.Add('销售额');
  edtDataSource.Properties.Items.Add('毛利');
  edtDataSource.ItemIndex := 0;
end;

procedure TfrmAnlyReport.FormDestroy(Sender: TObject);
begin
  WTitle1.Free;
  inherited;
end;

procedure TfrmAnlyReport.CreateChartText;
begin
  if edtChar1Type.Checked then
     begin
       Chart2.BottomAxis.Title.Caption:='时点(小时)';
       case edtDataSource.ItemIndex of
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
         3:begin
             Chart2.Title.Text.Text:='时段毛利分析表';
             Chart2.LeftAxis.Title.Caption:='毛利';
           end;
       end;
     end
  else
     begin
       Chart2.BottomAxis.Title.Caption:='';
       case edtDataSource.ItemIndex of
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
         3:begin
             Chart2.Title.Text.Text:='周毛利分析表';
             Chart2.LeftAxis.Title.Caption:='毛利';
           end;
       end;
    end;
end;

procedure TfrmAnlyReport.CreateChart;
  procedure doCreate(rs:TZQuery);
  var i:integer;
  begin
    rs.First;
    while not rs.Eof do
      begin
         if edtChar1Type.Checked then
            begin
               case edtDataSource.ItemIndex of
                 0:Chart2.Series[0].Add(rs.FieldbyName('CLIENT_NUM').AsFloat,rs.FieldbyName('HOUR').AsString);
                 1:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,rs.FieldbyName('HOUR').AsString);
                 2:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,rs.FieldbyName('HOUR').AsString);
                 3:Chart2.Series[0].Add(rs.FieldbyName('SALE_PRF').AsFloat,rs.FieldbyName('HOUR').AsString);
               end;
             end
          else
             begin
               i := rs.FieldbyName('WEEK').AsInteger;
               case edtDataSource.ItemIndex of
                 0:Chart2.Series[0].Add(rs.FieldbyName('CLIENT_NUM').AsFloat,weekList[i-1]);
                 1:Chart2.Series[0].Add(rs.FieldbyName('SALE_AMOUNT').AsFloat,weekList[i-1]);
                 2:Chart2.Series[0].Add(rs.FieldbyName('SALE_MONEY').AsFloat,weekList[i-1]);
                 3:Chart2.Series[0].Add(rs.FieldbyName('SALE_PRF').AsFloat,weekList[i-1]);
               end;
             end;
        rs.Next;
      end;
  end;
var
  rs:TZQuery;
begin
  Chart2.Series[0].Clear;

  if cdsReport1.IsEmpty then Exit;

  CreateChartText;

  if edtChar2Type.Checked then
     begin
       rs := TZQuery.Create(nil);
       try
         CalcWeek(rs);
         doCreate(rs);
       finally
         rs.Free;
       end;
     end
  else
     begin
       doCreate(cdsReport1);
     end;
end;

procedure TfrmAnlyReport.edtReportTypePropertiesChange(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.Visible := (edtReportType.ItemIndex=0);
  edtGODS_ID.Visible := (edtReportType.ItemIndex>0);
end;

procedure TfrmAnlyReport.chartClick(Sender: TObject);
begin
  inherited;
  OpenChart;
end;

procedure TfrmAnlyReport.OpenChart;
begin
  OpenReport1;
  CreateChart;
end;

procedure TfrmAnlyReport.CalcWeek(var rs:TZQuery);
var
  i:integer;
  SObj:TRecord_;
begin
  SObj := TRecord_.Create;
  try
    rs.FieldDefs.Assign(cdsReport1.FieldDefs);
    rs.CreateDataSet;
    cdsReport1.First;
    while not cdsReport1.Eof do
      begin
        i := DayofWeek(FnTime.fnStrtoDate(cdsReport1.FieldbyName('WEEK').AsString));
        if not rs.Locate('WEEK', i, []) then
           begin
             rs.Append;
             SObj.ReadFromDataSet(cdsReport1);
             SObj.FieldByName('WEEK').AsInteger := i;
             SObj.WriteToDataSet(rs);
             rs.Post;
           end
        else
           begin
             rs.Edit;
             if IsProfit then
                rs.FieldByName('SALE_PRF').AsFloat := rs.FieldByName('SALE_PRF').AsFloat + cdsReport1.FieldByName('SALE_PRF').AsFloat
             else
                begin
                  rs.FieldByName('SALE_AMOUNT').AsFloat := rs.FieldByName('SALE_AMOUNT').AsFloat + cdsReport1.FieldByName('SALE_AMOUNT').AsFloat;
                  rs.FieldByName('SALE_MONEY').AsFloat := rs.FieldByName('SALE_MONEY').AsFloat + cdsReport1.FieldByName('SALE_MONEY').AsFloat;
                  rs.FieldByName('CLIENT_NUM').AsFloat := rs.FieldByName('CLIENT_NUM').AsFloat + cdsReport1.FieldByName('CLIENT_NUM').AsFloat;
                end;
             rs.Post;
          end;
        cdsReport1.Next;
      end;
  finally
    SObj.Free;
  end;
end;

procedure TfrmAnlyReport.RzBmpButton2Click(Sender: TObject);
var
  formImage:TBitmap;
  myImage:TImage;
begin
  inherited;
  saveDialog1.DefaultExt:='*.bmp';
  saveDialog1.Filter:='图片格式(*.bmp)';
  if saveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    begin
      if MessageBox(Handle, Pchar(SaveDialog1.FileName + '已经存在，是否覆盖它？'), Pchar(Application.Title), MB_YESNO + MB_ICONQUESTION) <> 6 then
        Exit;
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

procedure TfrmAnlyReport.sortDropExit(Sender: TObject);
begin
  inherited;
  if trim(sortDrop.Text)='' then
     begin
       FSortId := '';
       sortDrop.Text := '全部分类';
     end;
end;

procedure TfrmAnlyReport.sortDropPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var Obj:TRecord_;
begin
  inherited;
  Obj := TRecord_.Create;
  try
    frmSortDropFrom.SelectRootOrLeaf := true;
    if frmSortDropFrom.DropForm(sortDrop,Obj) then
    begin
      if Obj.Count>0 then
         begin
           FSortId := Obj.FieldbyName('SORT_ID').AsString;
           sortDrop.Text := Obj.FieldbyName('SORT_NAME').AsString;
         end
      else
         begin
           FSortId := '';
           sortDrop.Text := '全部分类';
         end;
    end;
  finally
    Obj.Free;
  end;
end;

initialization
  RegisterClass(TfrmAnlyReport);
finalization
  UnRegisterClass(TfrmAnlyReport);
end.
