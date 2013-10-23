unit ufrmSaleReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmReportForm, StdCtrls, RzLabel, RzButton, RzTabs, ExtCtrls,
  RzPanel, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, RzBmpBtn, RzBckgnd,
  pngimage, PrnDbgeh;

type
  TfrmSaleReport = class(TfrmReportForm)
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
    RzToolbar2: TRzToolbar;
    RzToolButton6: TRzToolButton;
    RzToolButton7: TRzToolButton;
    RzSpacer2: TRzSpacer;
    RzToolButton8: TRzToolButton;
    RzToolButton9: TRzToolButton;
    DBGridEh2: TDBGridEh;
    cdsReport1: TZQuery;
    dsReport1: TDataSource;
    cdsReport2: TZQuery;
    dsReport2: TDataSource;
    rowToolNav2: TRzToolbar;
    linkToStock: TRzToolButton;
    RzPanel4: TRzPanel;
    RzPanel9: TRzPanel;
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
    RzPanel5: TRzPanel;
    RzLabel1: TRzLabel;
    barcode: TRzPanel;
    barcode_input_left: TImage;
    barcode_input_right: TImage;
    barcode_input_line: TImage;
    edtReportType: TcxComboBox;
    edtCLIENT_ID: TzrComboBoxList;
    edtGODS_ID: TzrComboBoxList;
    RzPanel16: TRzPanel;
    edtUSER_ID: TzrComboBoxList;
    procedure dateFlagPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzToolButton5Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure linkToStockClick(Sender: TObject);
    procedure edtCLIENT_IDClearValue(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure cdsReport1BeforeOpen(DataSet: TDataSet);
    procedure cdsReport2BeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtReportTypePropertiesChange(Sender: TObject);
    procedure edtGODS_IDClearValue(Sender: TObject);
    procedure edtUSER_IDClearValue(Sender: TObject);
    procedure edtUSER_IDExit(Sender: TObject);
    procedure edtCLIENT_IDExit(Sender: TObject);
    procedure edtGODS_IDExit(Sender: TObject);
  private
    WTitle1:TStringList;
    WTitle2:TStringList;
    ReportItemIndex:integer;
    procedure DBGridPrint;override;
  public
    procedure CreateGrid1;
    procedure OpenReport1;
    procedure OpenReport2(all:boolean=true);
    procedure showForm;override;
  end;

var frmSaleReport: TfrmSaleReport;

implementation

uses udataFactory,utokenFactory,uFnUtil,udllGlobal,udllShopUtil,ObjCommon;

{$R *.dfm}

procedure TfrmSaleReport.OpenReport1;
begin
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
  cdsReport1.close;
  CreateGrid1;
  WTitle1.Clear;
  WTitle1.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
  ReportItemIndex := edtReportType.ItemIndex;

  if edtReportType.ItemIndex = 0 then
     begin
       WTitle1.add('客户：'+edtCLIENT_ID.Text);
       cdsReport1.SQL.Text :=
         'select TENANT_ID,CLIENT_ID,sum(CALC_AMOUNT) as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY '+
         'from VIW_SALESDATA where TENANT_ID=:TENANT_ID and SALES_DATE>=:D1 and SALES_DATE<=:D2';

       if FnString.TrimRight(token.shopId,4)<>'0001' then
          cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SHOP_ID=:SHOP_ID';

       if edtCLIENT_ID.AsString <> '' then
          begin
            cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and CLIENT_ID=:CLIENT_ID';
          end;
       cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by TENANT_ID,CLIENT_ID';
       cdsReport1.SQL.Text :=
         'select j.*,case when j.CALC_AMOUNT<>0 then cast(j.CALC_MONEY as decimal(18,3)) / cast(j.CALC_AMOUNT as decimal(18,3)) else 0 end as APRICE,b.CLIENT_CODE,ifnull(b.CLIENT_NAME,''零售客户'') CLIENT_NAME from ('+cdsReport1.SQL.Text+') j '+
         'left outer join VIW_CUSTOMER b on j.TENANT_ID=b.TENANT_ID and j.CLIENT_ID=b.CLIENT_ID order by b.CLIENT_CODE';
     end
  else if edtReportType.ItemIndex = 1 then
     begin
       WTitle1.add('商品：'+edtGODS_ID.Text);
       cdsReport1.SQL.Text :=
         'select TENANT_ID,GODS_ID,sum(CALC_AMOUNT) as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY '+
         'from VIW_SALESDATA where TENANT_ID=:TENANT_ID and SALES_DATE>=:D1 and SALES_DATE<=:D2';

       if FnString.TrimRight(token.shopId,4)<>'0001' then
          cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SHOP_ID=:SHOP_ID';

       if edtGODS_ID.AsString <> '' then
          begin
            cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and GODS_ID=:GODS_ID';
          end;
       cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by TENANT_ID,GODS_ID';
       cdsReport1.SQL.Text :=
         'select j.*,case when j.CALC_AMOUNT<>0 then cast(j.CALC_MONEY as decimal(18,3)) / cast(j.CALC_AMOUNT as decimal(18,3)) else 0 end as APRICE,b.GODS_NAME,b.GODS_CODE,b.BARCODE,b.CALC_UNITS as UNIT_ID,b.SORT_ID1 from ('+cdsReport1.SQL.Text+') j '+
         'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS',true)+') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID order by b.GODS_CODE';
     end
  else if edtReportType.ItemIndex = 2 then
     begin
       WTitle1.add('店员：'+edtUSER_ID.Text);
       cdsReport1.SQL.Text :=
         'select TENANT_ID,CREA_USER,sum(CALC_AMOUNT) as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY '+
         'from VIW_SALESDATA where TENANT_ID=:TENANT_ID and SALES_DATE>=:D1 and SALES_DATE<=:D2';

       if FnString.TrimRight(token.shopId,4)<>'0001' then
          cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SHOP_ID=:SHOP_ID';

       if edtUSER_ID.AsString <> '' then
          begin
            cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and CREA_USER=:USER_ID';
          end;
       cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by TENANT_ID,CREA_USER';
       cdsReport1.SQL.Text :=
         'select j.*,case when j.CALC_AMOUNT<>0 then cast(j.CALC_MONEY as decimal(18,3)) / cast(j.CALC_AMOUNT as decimal(18,3)) else 0 end as APRICE,b.ACCOUNT,b.USER_NAME from ('+cdsReport1.SQL.Text+') j '+
         'left outer join VIW_USERS b on j.TENANT_ID=b.TENANT_ID and j.CREA_USER=b.USER_ID order by b.ACCOUNT';
     end;

  cdsReport1.SQL.Text := ParseSQL(dataFactory.iDbType, cdsReport1.SQL.Text);
  cdsReport1.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  cdsReport1.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
  cdsReport1.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  if cdsReport1.Params.FindParam('SHOP_ID')<>nil then cdsReport1.ParamByName('SHOP_ID').AsString := token.shopId;
  if cdsReport1.Params.FindParam('CLIENT_ID')<>nil then cdsReport1.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
  if cdsReport1.Params.FindParam('GODS_ID')<>nil then cdsReport1.ParamByName('GODS_ID').AsString := edtGODS_ID.AsString;
  if cdsReport1.Params.FindParam('USER_ID')<>nil then cdsReport1.ParamByName('USER_ID').AsString := edtUSER_ID.AsString;
  dataFactory.Open(cdsReport1);
end;

procedure TfrmSaleReport.OpenReport2(all:boolean=true);
begin
  PageControl.ActivePageIndex := 1;
  PageControlChange(nil);
  cdsReport2.close;
  WTitle2.Clear;
  WTitle2.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));

  cdsReport2.SQL.Text :=
    'select TENANT_ID,GODS_ID,SALES_DATE,CLIENT_ID,CREA_USER,GLIDE_NO,AMOUNT,APRICE,CALC_MONEY,UNIT_ID '+
    'from VIW_SALESDATA where TENANT_ID=:TENANT_ID and SALES_DATE>=:D1 and SALES_DATE<=:D2';
  if FnString.TrimRight(token.shopId,4)<>'0001' then
     cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and SHOP_ID=:SHOP_ID';

  if not all then
     begin
       if ReportItemIndex = 0 then
          begin
            WTitle2.add('客户：'+cdsReport1.FieldbyName('CLIENT_NAME').AsString);
            if cdsReport1.FieldbyName('CLIENT_ID').AsString = '' then
               begin
                 cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and CLIENT_ID is null'
               end
            else
               begin
                 cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and CLIENT_ID=:CLIENT_ID';
                 cdsReport2.ParamByName('CLIENT_ID').AsString := cdsReport1.FieldbyName('CLIENT_ID').AsString;
               end;
          end
       else if ReportItemIndex = 1 then
          begin
            WTitle2.add('商品：'+cdsReport1.FieldbyName('GODS_NAME').AsString);
            cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and GODS_ID=:GODS_ID';
            cdsReport2.ParamByName('GODS_ID').AsString := cdsReport1.FieldbyName('GODS_ID').AsString;
          end
       else if ReportItemIndex = 2 then
          begin
            WTitle2.add('店员：'+cdsReport1.FieldbyName('USER_NAME').AsString);
            cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and CREA_USER=:USER_ID';
            cdsReport2.ParamByName('USER_ID').AsString := cdsReport1.FieldbyName('CREA_USER').AsString;
          end;
     end
  else
     begin
       if edtReportType.ItemIndex = 0 then
          begin
            WTitle2.add('客户：'+edtCLIENT_ID.Text);
            if edtCLIENT_ID.AsString <> '' then
               begin
                 cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and CLIENT_ID=:CLIENT_ID';
                 cdsReport2.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
               end;
          end
       else if edtReportType.ItemIndex = 1 then
          begin
            WTitle2.add('商品：'+edtGODS_ID.Text);
            if edtGODS_ID.AsString <> '' then
               begin
                 cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and GODS_ID=:GODS_ID';
                 cdsReport2.ParamByName('GODS_ID').AsString := edtGODS_ID.AsString;
               end;
          end
       else if edtReportType.ItemIndex = 2 then
          begin
            WTitle2.add('店员：'+edtUSER_ID.Text);
            if edtUSER_ID.AsString <> '' then
               begin
                 cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and CREA_USER=:USER_ID';
                 cdsReport2.ParamByName('USER_ID').AsString := edtUSER_ID.AsString;
               end;
          end;
     end;

  cdsReport2.SQL.Text := cdsReport2.SQL.Text +' ';
  cdsReport2.SQL.Text :=
    'select j.*,b.GODS_NAME,b.GODS_CODE,b.BARCODE,case when j.CLIENT_ID is null then ''零售客户'' else c.CLIENT_NAME end as CLIENT_NAME,d.USER_NAME from ('+cdsReport2.SQL.Text+') j '+
    'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS',true)+') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
    'left outer join VIW_CUSTOMER c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.CLIENT_ID '+
    'left outer join VIW_USERS d on j.TENANT_ID=d.TENANT_ID and j.CREA_USER=d.USER_ID '+
    'order by j.SALES_DATE,j.GLIDE_NO';
  cdsReport2.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  cdsReport2.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
  cdsReport2.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  if cdsReport2.Params.FindParam('SHOP_ID')<>nil then cdsReport2.ParamByName('SHOP_ID').AsString := token.shopId;

  dataFactory.Open(cdsReport2);

  RzPanel5.Visible := not all;

  if not all then
     begin
      if ReportItemIndex = 0 then
         RzLabel1.Caption := '"'+cdsReport1.FieldbyName('CLIENT_NAME').AsString+'" 客户的销售流水'
      else if ReportItemIndex = 1 then
         RzLabel1.Caption := '"'+cdsReport1.FieldbyName('GODS_NAME').AsString+'" 商品的销售流水'
      else if ReportItemIndex = 2 then
         RzLabel1.Caption := '"'+cdsReport1.FieldbyName('USER_NAME').AsString+'" 店员的销售流水';
     end;

  RzBmpButton4.Caption := '展开明细';
end;

procedure TfrmSaleReport.dateFlagPropertiesChange(Sender: TObject);
begin
  inherited;
  case dateFlag.ItemIndex of
  0:begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
    end;
  1:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYYMM01',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
    end;
  2:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYY0101',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
    end;
  else
    begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
    end;
  end;
end;

procedure TfrmSaleReport.showForm;
var
  rs:TZQuery;
  Column:TColumnEh;
begin
  inherited;
  dateFlag.ItemIndex := 1;
  edtReportType.ItemIndex := 1;
  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CUSTOMER');
  edtGODS_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  edtUSER_ID.DataSet := dllGlobal.GetZQueryFromName('CA_USERS');
  Column := FindColumn(DBGridEh2,'UNIT_ID');
  if Assigned(Column) then
     begin
       rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
       rs.First;
       while not rs.Eof do
         begin
           Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
           Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
           rs.Next;
         end;
     end;
end;

procedure TfrmSaleReport.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmSaleReport.RzToolButton5Click(Sender: TObject);
begin
  inherited;
  OpenReport2(false);
end;

procedure TfrmSaleReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsReport1.IsEmpty then Exit;
  OpenReport2(false);
end;

procedure TfrmSaleReport.DBGridEh2DrawColumnCell(Sender: TObject;
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

procedure TfrmSaleReport.linkToStockClick(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'当前版本不支持此功能','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmSaleReport.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  if D1.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  if D2.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  case PageControl.ActivePageIndex of
  0:OpenReport1;
  1:OpenReport2;
  end;
end;

procedure TfrmSaleReport.PageControlChange(Sender: TObject);
begin
  inherited;
  btnPrior.Visible := PageControl.ActivePageIndex>0;
end;

procedure TfrmSaleReport.btnPriorClick(Sender: TObject);
begin
  inherited;
  if PageControl.ActivePageIndex>0 then PageControl.ActivePageIndex := PageControl.ActivePageIndex - 1;
  PageControlChange(nil);
  edtCLIENT_ID.Properties.ReadOnly := false;
  dateFlag.Properties.ReadOnly := false;
  D1.Properties.ReadOnly := false;
  D2.Properties.ReadOnly := false;
  RzBmpButton4.Caption := '统计';
end;

procedure TfrmSaleReport.cdsReport1BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav.Visible := false;
end;

procedure TfrmSaleReport.cdsReport2BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav2.Visible := false;
end;

procedure TfrmSaleReport.DBGridPrint;
var
  ReStr:string;
begin
  case PageControl.ActivePageIndex of
  0:begin
      PrintDBGridEh1.DBGridEh := DBGridEh1;
      PrintDBGridEh1.PageHeader.CenterText.Text := '销售统计报表';
      ReStr:=FormatReportHead(WTitle1,4);
      DBGridEh1.DBGridTitle := '销售统计报表';
      DBGridEh1.DBGridHeader.Text := FormatExportHead(WTitle1,4);
      DBGridEh1.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    end;
  1:begin
      PrintDBGridEh1.DBGridEh := DBGridEh2;
      PrintDBGridEh1.PageHeader.CenterText.Text := '销售明细报表';
      ReStr:=FormatReportHead(WTitle2,4);
      DBGridEh2.DBGridTitle := '销售明细报表';
      DBGridEh2.DBGridHeader.Text := FormatExportHead(WTitle2,4);
      DBGridEh2.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    end;
  end;
  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+token.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
end;

procedure TfrmSaleReport.FormCreate(Sender: TObject);
begin
  inherited;
  WTitle1 := TStringList.Create;
  WTitle2 := TStringList.Create;
end;

procedure TfrmSaleReport.FormDestroy(Sender: TObject);
begin
  WTitle1.Free;
  WTitle2.Free;
  inherited;
end;

procedure TfrmSaleReport.edtReportTypePropertiesChange(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.Visible := (edtReportType.ItemIndex = 0);
  edtGODS_ID.Visible := (edtReportType.ItemIndex = 1);
  edtUSER_ID.Visible := (edtReportType.ItemIndex = 2);
end;

procedure TfrmSaleReport.edtCLIENT_IDClearValue(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.KeyValue := null;
  edtCLIENT_ID.Text := '所有客户';
end;

procedure TfrmSaleReport.edtCLIENT_IDExit(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)='' then
     begin
       edtCLIENT_ID.KeyValue := null;
       edtCLIENT_ID.Text := '所有客户';
     end;
end;

procedure TfrmSaleReport.edtGODS_IDClearValue(Sender: TObject);
begin
  inherited;
  edtGODS_ID.KeyValue := null;
  edtGODS_ID.Text := '所有商品';
end;

procedure TfrmSaleReport.edtGODS_IDExit(Sender: TObject);
begin
  inherited;
  if trim(edtGODS_ID.Text)='' then
     begin
       edtGODS_ID.KeyValue := null;
       edtGODS_ID.Text := '所有商品';
     end;
end;

procedure TfrmSaleReport.edtUSER_IDClearValue(Sender: TObject);
begin
  inherited;
  edtUSER_ID.KeyValue := null;
  edtUSER_ID.Text := '所有店员';
end;

procedure TfrmSaleReport.edtUSER_IDExit(Sender: TObject);
begin
  inherited;
  if trim(edtUSER_ID.Text)='' then
     begin
       edtUSER_ID.KeyValue := null;
       edtUSER_ID.Text := '所有店员';
     end;
end;

procedure TfrmSaleReport.CreateGrid1;
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
        Column.Width := 50;
        Column.FieldName := 'SORT_ID1';
        Column.Title.Caption := '商品分类';
        Column := DBGridEh1.Columns.Add;
        Column.Width := 27;
        Column.FieldName := 'UNIT_ID';
        Column.Title.Caption := '单位';
      end;
    2:begin
        Column := DBGridEh1.Columns.Add;
        Column.Width := 113;
        Column.FieldName := 'ACCOUNT';
        Column.Title.Caption := '员工账号';
        Column.Footer.Alignment := taCenter;
        Column.Footer.ValueType := fvtStaticText;
        Column.Footer.Value := '合计';
        Column := DBGridEh1.Columns.Add;
        Column.Width := 272;
        Column.FieldName := 'USER_NAME';
        Column.Title.Caption := '员工姓名';
      end;
    end;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 62;
    Column.FieldName := 'CALC_AMOUNT';
    Column.Title.Caption := '销量';
    Column.DisplayFormat := '#0.###';
    Column.Footer.DisplayFormat := '#0.###';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtSum;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 62;
    Column.FieldName := 'APRICE';
    Column.Title.Caption := '均价';
    Column.DisplayFormat := '#0.00#';
    Column.Footer.DisplayFormat := '#0.00#';
    Column.Alignment := taRightJustify;
    Column.Footer.ValueType := fvtStaticText;
    Column.Footer.Alignment := taRightJustify;
    Column := DBGridEh1.Columns.Add;
    Column.Width := 68;
    Column.FieldName := 'CALC_MONEY';
    Column.Title.Caption := '销售金额';
    Column.DisplayFormat := '#0.00';
    Column.Footer.DisplayFormat := '#0.00';
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
  Column := FindColumn(DBGridEh1,'UNIT_ID');
  if Assigned(Column) then
     begin
       rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
       rs.First;
       while not rs.Eof do
         begin
           Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
           Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
           rs.Next;
         end;
     end;
  Column := FindColumn(DBGridEh1,'UNIT_ID');
  if Assigned(Column) then
     begin
       rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
       rs.First;
       while not rs.Eof do
         begin
           Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
           Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
           rs.Next;
         end;
     end;
  Column := FindColumn(DBGridEh1,'SORT_ID1');
  if Assigned(Column) then
     begin
       rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
       rs.First;
       while not rs.Eof do
         begin
           Column.PickList.Add(rs.FieldbyName('SORT_NAME').AsString);
           Column.KeyList.Add(rs.FieldbyName('SORT_ID').AsString);
           rs.Next;
         end;
     end;
end;

initialization
  RegisterClass(TfrmSaleReport);
finalization
  UnRegisterClass(TfrmSaleReport);
end.
