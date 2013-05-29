unit ufrmStockReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmReportForm, StdCtrls, RzLabel, RzButton, RzTabs, ExtCtrls,
  RzPanel, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, RzBmpBtn, RzBckgnd,
  pngimage, PrnDbgeh;

type
  TfrmStockReport = class(TfrmReportForm)
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
    RzToolbar3: TRzToolbar;
    RzToolButton10: TRzToolButton;
    cdsReport1: TZQuery;
    dsReport1: TDataSource;
    cdsReport2: TZQuery;
    dsReport2: TDataSource;
    rowToolNav2: TRzToolbar;
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
    barcode: TRzPanel;
    barcode_input_left: TImage;
    barcode_input_right: TImage;
    barcode_input_line: TImage;
    edtCLIENT_ID: TzrComboBoxList;
    btnPrior: TRzBmpButton;
    linkToStock: TRzToolButton;
    RzPanel5: TRzPanel;
    RzLabel1: TRzLabel;
    procedure dateFlagPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzToolButton5Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure edtCLIENT_IDClearValue(Sender: TObject);
    procedure linkToStockClick(Sender: TObject);
    procedure edtCLIENT_IDExit(Sender: TObject);
    procedure cdsReport1BeforeOpen(DataSet: TDataSet);
    procedure cdsReport2BeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    WTitle1:TStringList;
    WTitle2:TStringList;
    procedure DBGridPrint;override;
  public
    { Public declarations }
    procedure OpenReport1;
    procedure OpenReport2(all:boolean=true);
    procedure showForm;override;
  end;

var
  frmStockReport: TfrmStockReport;

implementation
uses udataFactory,utokenFactory,uFnUtil, udllGlobal;
{$R *.dfm}

{ TfrmSaleReport }

procedure TfrmStockReport.OpenReport1;
begin
  PageControl.ActivePageIndex := 0;
  PageControlChange(nil);
  cdsReport1.close;
  WTitle1.Clear;
  WTitle1.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
  WTitle1.add('供应商：'+edtCLIENT_ID.Text);
  cdsReport1.SQL.Text :=
     'select TENANT_ID,GODS_ID,sum(CALC_AMOUNT) as CALC_AMOUNT,sum(CALC_MONEY) as CALC_MONEY '+
     'from VIW_STOCKDATA where TENANT_ID=:TENANT_ID and STOCK_DATE>=:D1 and STOCK_DATE<=:D2';
  if FnString.TrimRight(token.shopId,4)<>'0001' then
     cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SHOP_ID=:SHOP_ID';
  if edtCLIENT_ID.AsString <> '' then
     begin
       cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and CLIENT_ID=:CLIENT_ID';
     end;
  cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by TENANT_ID,GODS_ID';
  cdsReport1.SQL.Text :=
     'select j.*,case when j.CALC_AMOUNT<>0 then cast(j.CALC_MONEY as decimal(18,3)) / cast(j.CALC_AMOUNT as decimal(18,3)) else 0 end as APRICE,b.GODS_NAME,b.GODS_CODE,b.BARCODE,b.CALC_UNITS as UNIT_ID,b.SORT_ID1 from ('+cdsReport1.SQL.Text+') j '+
     'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS',true)+') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID order by b.GODS_CODE';
  cdsReport1.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  cdsReport1.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
  cdsReport1.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  if cdsReport1.Params.FindParam('SHOP_ID')<>nil then cdsReport1.ParamByName('SHOP_ID').AsString := token.shopId;
  if cdsReport1.Params.FindParam('CLIENT_ID')<>nil then cdsReport1.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
  dataFactory.Open(cdsReport1);

end;

procedure TfrmStockReport.OpenReport2(all:boolean=true);
begin
  PageControl.ActivePageIndex := 1;
  PageControlChange(nil);
  cdsReport2.close;
  WTitle2.Clear;
  WTitle2.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
  WTitle2.add('供应商：'+edtCLIENT_ID.Text);
  cdsReport2.SQL.Text :=
     'select TENANT_ID,GODS_ID,STOCK_DATE,CLIENT_ID,GLIDE_NO,AMOUNT,APRICE,CALC_MONEY,UNIT_ID '+
     'from VIW_STOCKDATA where TENANT_ID=:TENANT_ID and STOCK_DATE>=:D1 and STOCK_DATE<=:D2';
  if FnString.TrimRight(token.shopId,4)<>'0001' then
     cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and SHOP_ID=:SHOP_ID';
  if edtCLIENT_ID.AsString <> '' then
     begin
       cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and CLIENT_ID=:CLIENT_ID';
     end;
  if not all then
     cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and GODS_ID=:GODS_ID';
  cdsReport2.SQL.Text := cdsReport2.SQL.Text +' ';
  cdsReport2.SQL.Text :=
     'select j.*,b.GODS_NAME,b.GODS_CODE,b.BARCODE,c.CLIENT_NAME from ('+cdsReport2.SQL.Text+') j '+
     'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,SORT_ID1,CALC_UNITS',true)+') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID '+
     'left outer join VIW_CLIENTINFO c on j.TENANT_ID=c.TENANT_ID and j.CLIENT_ID=c.CLIENT_ID order by j.STOCK_DATE,j.GLIDE_NO';
  cdsReport2.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  cdsReport2.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
  cdsReport2.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  if cdsReport2.Params.FindParam('SHOP_ID')<>nil then cdsReport2.ParamByName('SHOP_ID').AsString := token.shopId;
  if cdsReport2.Params.FindParam('CLIENT_ID')<>nil then cdsReport2.ParamByName('CLIENT_ID').AsString := edtCLIENT_ID.AsString;
  if cdsReport2.Params.FindParam('GODS_ID')<>nil then cdsReport2.ParamByName('GODS_ID').AsString := cdsReport1.FieldbyName('GODS_ID').AsString;
  dataFactory.Open(cdsReport2);

  RzPanel5.Visible := not all;
  RzLabel1.Caption := '"'+cdsReport1.FieldbyName('GODS_NAME').AsString+'" 商品的进货流水';
  edtCLIENT_ID.Properties.ReadOnly := not all;
  dateFlag.Properties.ReadOnly := not all;
  D1.Properties.ReadOnly := not all;
  D2.Properties.ReadOnly := not all;
  RzBmpButton4.Caption := '展开明细';
  
end;

procedure TfrmStockReport.dateFlagPropertiesChange(Sender: TObject);
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

procedure TfrmStockReport.showForm;
var
  Column:TColumnEh;
  rs:TZQuery;
begin
  inherited;
  dateFlag.ItemIndex := 1;
  edtCLIENT_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_CLIENTINFO');
  
  rs := dllGlobal.GetZQueryFromName('PUB_GOODSSORT');
  Column := FindColumn(DBGridEH1,'SORT_ID1');
  rs.First;
  while not rs.Eof do
    begin
      Column.PickList.Add(rs.FieldbyName('SORT_NAME').AsString);
      Column.KeyList.Add(rs.FieldbyName('SORT_ID').AsString);
      rs.Next;
    end;

  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(DBGridEH1,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      rs.Next;
    end;
    
  Column := FindColumn(DBGridEH2,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      rs.Next;
    end;
    
end;

procedure TfrmStockReport.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmStockReport.RzToolButton5Click(Sender: TObject);
begin
  inherited;
  OpenReport2(false);
end;

procedure TfrmStockReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsReport1.IsEmpty then exit;
  OpenReport2(false);
end;

procedure TfrmStockReport.DBGridEh2DrawColumnCell(Sender: TObject;
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

procedure TfrmStockReport.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  if D1.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  if D2.EditValue = null then Raise Exception.Create('日期条件不能为空!');
  case PageControl.ActivePageIndex of
  0:OpenReport1;
  1:OpenReport2;
  end;

end;

procedure TfrmStockReport.PageControlChange(Sender: TObject);
begin
  inherited;
  btnPrior.Visible := PageControl.ActivePageIndex>0;
end;

procedure TfrmStockReport.btnPriorClick(Sender: TObject);
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

procedure TfrmStockReport.edtCLIENT_IDClearValue(Sender: TObject);
begin
  inherited;
  edtCLIENT_ID.KeyValue := null;
  edtCLIENT_ID.Text := '全部供应商';
end;

procedure TfrmStockReport.linkToStockClick(Sender: TObject);
begin
  inherited;
  MessageBox(Handle,'当前版本不支持此功能','友情提示..',MB_OK+MB_ICONINFORMATION);
end;

procedure TfrmStockReport.edtCLIENT_IDExit(Sender: TObject);
begin
  inherited;
  if trim(edtCLIENT_ID.Text)='' then
     begin
       edtCLIENT_ID.KeyValue := null;
       edtCLIENT_ID.Text := '全部供应商';
     end;

end;

procedure TfrmStockReport.cdsReport1BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav.Visible := false;

end;

procedure TfrmStockReport.cdsReport2BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav2.Visible := false;

end;

procedure TfrmStockReport.DBGridPrint;
var
  ReStr:string;
begin
  case PageControl.ActivePageIndex of
  0:begin
      PrintDBGridEh1.DBGridEh := DBGridEh1;
      PrintDBGridEh1.PageHeader.CenterText.Text := '进货统计报表';
      ReStr:=FormatReportHead(WTitle1,4);
      DBGridEh1.DBGridTitle := '进货统计报表';
      DBGridEh1.DBGridHeader.Text := FormatExportHead(WTitle1,4);
      DBGridEh1.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    end;
  1:begin
      PrintDBGridEh1.DBGridEh := DBGridEh2;
      PrintDBGridEh1.PageHeader.CenterText.Text := '进货明细报表';
      ReStr:=FormatReportHead(WTitle2,4);
      DBGridEh2.DBGridTitle := '进货明细报表';
      DBGridEh2.DBGridHeader.Text := FormatExportHead(WTitle2,4);
      DBGridEh2.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    end;
  end;
  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+token.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
end;

procedure TfrmStockReport.FormCreate(Sender: TObject);
begin
  inherited;
  WTitle1 := TStringList.Create;
  WTitle2 := TStringList.Create;

end;

procedure TfrmStockReport.FormDestroy(Sender: TObject);
begin
  WTitle1.Free;
  WTitle2.Free;
  inherited;

end;

initialization
  RegisterClass(TfrmStockReport);
finalization
  UnRegisterClass(TfrmStockReport);
end.
