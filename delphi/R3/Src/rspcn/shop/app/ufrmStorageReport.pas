unit ufrmStorageReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmReportForm, StdCtrls, RzLabel, RzButton, RzTabs, ExtCtrls,
  RzPanel, cxButtonEdit, zrComboBoxList, cxDropDownEdit, cxCalendar,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, TeeProcs, TeEngine,
  Chart, Series, cxRadioGroup, RzBmpBtn, RzBckgnd, pngimage,ZBase, PrnDbgeh;

type
  TfrmStorageReport = class(TfrmReportForm)
    RzPanel2: TRzPanel;
    RzPanel3: TRzPanel;
    RzPanel7: TRzPanel;
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
    DBGridEh2: TDBGridEh;
    DBGridEh1: TDBGridEh;
    btnPrior: TRzBmpButton;
    barcode: TRzPanel;
    barcode_input_left: TImage;
    barcode_input_right: TImage;
    barcode_input_line: TImage;
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
    edtGODS_ID: TzrComboBoxList;
    RzPanel5: TRzPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    sortDrop: TcxButtonEdit;
    RzPanel10: TRzPanel;
    RzLabel1: TRzLabel;
    procedure dateFlagPropertiesChange(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RzToolButton5Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure edtGODS_IDExit(Sender: TObject);
    procedure edtGODS_IDClearValue(Sender: TObject);
    procedure sortDropExit(Sender: TObject);
    procedure sortDropPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnPriorClick(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure RzBmpButton4Click(Sender: TObject);
    procedure cdsReport1BeforeOpen(DataSet: TDataSet);
    procedure cdsReport2BeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FSortId:string;
    WTitle1:TStringList;
    WTitle2:TStringList;
    procedure DBGridPrint;override;
  public
    procedure OpenReport1;
    procedure OpenReport2(gid,bno:string);
    procedure showForm;override;
  end;

var frmStorageReport: TfrmStorageReport;

implementation

uses udataFactory,utokenFactory,uFnUtil,udllGlobal,ufrmStocksCalc,ObjCommon,
     ufrmSortDropFrom;

{$R *.dfm}

procedure TfrmStorageReport.OpenReport1;
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
  // if RckMaxDate < vEndDate then
     begin
       //没有计算，需重计算流水
       if not TfrmStocksCalc.Calc(self,D2.Date) then Exit;
     end;
  cdsReport1.close;
  WTitle1.Clear;
  WTitle1.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
  WTitle1.add('分类：'+sortDrop.Text);
  WTitle1.add('商品：'+edtGODS_ID.Text);
  cdsReport1.SQL.Text :=
     'select TENANT_ID,GODS_ID,BATCH_NO,'+
     'sum(case when BILL_DATE<='+formatDatetime('YYYYMMDD',D1.Date)+' and BILL_TYPE in (0,1) then BAL_AMOUNT when BILL_DATE<'+formatDatetime('YYYYMMDD',D1.Date)+' then IN_AMOUNT-OUT_AMOUNT else 0 end) as BEG_AMOUNT,'+
     'sum(case when BILL_DATE<='+formatDatetime('YYYYMMDD',D1.Date)+' and BILL_TYPE in (0,1) then BAL_MONEY when BILL_DATE<'+formatDatetime('YYYYMMDD',D1.Date)+' then IN_MONEY-OUT_MONEY else 0 end) as BEG_MONEY,'+
     'sum(case when BILL_DATE>='+formatDatetime('YYYYMMDD',D1.Date)+' then IN_AMOUNT else 0 end) as IN_AMOUNT,'+
     'sum(case when BILL_DATE>='+formatDatetime('YYYYMMDD',D1.Date)+' then IN_MONEY else 0 end) as IN_MONEY,'+
     'sum(case when BILL_DATE>='+formatDatetime('YYYYMMDD',D1.Date)+' then OUT_AMOUNT else 0 end) as OUT_AMOUNT,'+
     'sum(case when BILL_DATE>='+formatDatetime('YYYYMMDD',D1.Date)+' then OUT_MONEY else 0 end) as OUT_MONEY '+
     'from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and BILL_DATE>=:D1 and BILL_DATE<=:D2 ';
  if FnString.TrimRight(token.shopId,4)<>'0001' then
     cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and SHOP_ID=:SHOP_ID';
  if edtGODS_ID.AsString <> '' then
     begin
       cdsReport1.SQL.Text := cdsReport1.SQL.Text + ' and GODS_ID=:GODS_ID';
     end;
  cdsReport1.SQL.Text := cdsReport1.SQL.Text +' group by TENANT_ID,GODS_ID,BATCH_NO';

  if FSortId = '' then
     cdsReport1.SQL.Text :=
        ParseSQL(dataFactory.iDbType,
        'select j.*,1 as flag,'+
        'j.BEG_AMOUNT+j.IN_AMOUNT-j.OUT_AMOUNT as BAL_AMOUNT,'+
        'j.BEG_MONEY+j.IN_MONEY-j.OUT_MONEY as BAL_MONEY,'+
        'b.GODS_NAME,b.GODS_CODE,b.BARCODE,b.CALC_UNITS as UNIT_ID from ('+cdsReport1.SQL.Text+') j '+
        'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,CALC_UNITS',true)+
        ') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID order by b.GODS_CODE'
        )
  else
     cdsReport1.SQL.Text :=
        ParseSQL(dataFactory.iDbType,
        'select j.*,1 as flag,'+
        'j.BEG_AMOUNT+j.IN_AMOUNT-j.OUT_AMOUNT as BAL_AMOUNT,'+
        'j.BEG_MONEY+j.IN_MONEY-j.OUT_MONEY as BAL_MONEY,'+
        'b.GODS_NAME,b.GODS_CODE,b.BARCODE,b.CALC_UNITS as UNIT_ID from ('+cdsReport1.SQL.Text+') j '+
        'left outer join ('+dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE,CALC_UNITS,SORT_ID1',true)+
        ') b on j.TENANT_ID=b.TENANT_ID and j.GODS_ID=b.GODS_ID where b.SORT_ID1=:SORT_ID1 order by b.GODS_CODE'
        );
  cdsReport1.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  cdsReport1.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMM01',D1.Date));
  cdsReport1.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  if cdsReport1.Params.FindParam('SORT_ID1')<>nil then cdsReport1.ParamByName('SORT_ID1').AsString := FSortId;
  if cdsReport1.Params.FindParam('SHOP_ID')<>nil then cdsReport1.ParamByName('SHOP_ID').AsString := token.shopId;
  if cdsReport1.Params.FindParam('GODS_ID')<>nil then cdsReport1.ParamByName('GODS_ID').AsString := edtGODS_ID.AsString;
  dataFactory.Open(cdsReport1);
end;

procedure TfrmStorageReport.OpenReport2(gid,bno:string);
var
  vBegDate,            //查询开始日期
  vEndDate: integer;   //查询结束日期
  RckMaxDate: integer; //台帐最大日期
begin
  PageControl.ActivePageIndex := 1;
  PageControlChange(nil);
  vBegDate:=strtoInt(formatDatetime('YYYYMMDD',D1.Date));  //开始日期
  vEndDate:=strtoInt(formatDatetime('YYYYMMDD',D2.Date));  //结束日期
  RckMaxDate:=CheckAccDate(vBegDate,vEndDate);   //取日结帐最大日期:
  // if RckMaxDate < vEndDate then
  //   begin
       // 没有计算，需重计算流水
       // if not TfrmStocksCalc.Calc(self,D2.Date) then Exit;
  //   end;
  cdsReport2.close;
  WTitle2.Clear;
  WTitle2.add('日期：'+formatDatetime('YYYY-MM-DD',D1.Date)+' 至 '+formatDatetime('YYYY-MM-DD',D2.Date));
  WTitle2.add('分类：'+sortDrop.Text);
  WTitle2.add('商品：'+edtGODS_ID.Text);
  cdsReport2.SQL.Text :=
     'select A.TENANT_ID,A.SHOP_ID,''期初'' as BILL_O_NAME,null as BILL_DATE,''期初结存'' as CLIENT_NAME,0 as SEQNO,2 as flag,BAL_AMOUNT as IN_AMOUNT,BAL_PRICE as IN_PRICE,BAL_MONEY as IN_MONEY,null as OUT_AMOUNT,null as OUT_PRICE,null as OUT_MONEY,'+
     'null as BAL_AMOUNT,null as BAL_PRICE,null as BAL_MONEY '+
     'from RCK_STOCKS_DATA A,(select TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO,max(SEQNO) as SEQNO '+
     'from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and BILL_DATE>='+formatDatetime('YYYYMM01',D1.Date)+' and BILL_DATE<:D1 and GODS_ID=:GODS_ID '+
     'group by TENANT_ID,SHOP_ID,GODS_ID,BATCH_NO) B where A.TENANT_ID=B.TENANT_ID and A.SHOP_ID=B.SHOP_ID and A.GODS_ID=B.GODS_ID and A.BATCH_NO=B.BATCH_NO and A.SEQNO=B.SEQNO ';
  if FnString.TrimRight(token.shopId,4)<>'0001' then
     cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and A.SHOP_ID=:SHOP_ID ';
  cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and A.GODS_ID=:GODS_ID';
  cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and A.BATCH_NO=:BATCH_NO';

  cdsReport2.SQL.Text := cdsReport2.SQL.Text +' union all ';
  cdsReport2.SQL.Text := cdsReport2.SQL.Text +
     'select TENANT_ID,SHOP_ID,BILL_NAME as BILL_O_NAME,BILL_DATE,CLIENT_NAME,SEQNO,1 as flag,'+
     'case when BILL_TYPE in (11,12,13) then IN_AMOUNT else null end as IN_AMOUNT,'+
     'case when BILL_TYPE in (11,12,13) then IN_PRICE else null end as IN_PRICE,'+
     'case when BILL_TYPE in (11,12,13) then IN_MONEY else null end as IN_MONEY,'+
     'case when BILL_TYPE in (11,12,13) then null else OUT_AMOUNT end as OUT_AMOUNT,'+
     'case when BILL_TYPE in (11,12,13) then null else OUT_PRICE end as OUT_PRICE,'+
     'case when BILL_TYPE in (11,12,13) then null else OUT_MONEY end as OUT_MONEY,'+
     'BAL_AMOUNT,BAL_PRICE,BAL_MONEY '+
     'from RCK_STOCKS_DATA where TENANT_ID=:TENANT_ID and BILL_DATE>=:D1 and BILL_DATE<=:D2 and BILL_TYPE not in (1) ';
     
  if FnString.TrimRight(token.shopId,4)<>'0001' then
     cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and SHOP_ID=:SHOP_ID';
  cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and GODS_ID=:GODS_ID';
  cdsReport2.SQL.Text := cdsReport2.SQL.Text + ' and BATCH_NO=:BATCH_NO';
  
  cdsReport2.SQL.Text :=
     ParseSQL(dataFactory.iDbType,
     'select j.*,b.SHOP_NAME from ('+cdsReport2.SQL.Text+') j '+
     'left outer join CA_SHOP_INFO b on j.TENANT_ID=b.TENANT_ID and j.SHOP_ID=b.SHOP_ID '+
     'order by j.SHOP_ID,j.SHOP_ID,j.SEQNO'
     );
  cdsReport2.ParamByName('TENANT_ID').AsInteger := strtoInt(token.tenantId);
  cdsReport2.ParamByName('D1').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D1.Date));
  cdsReport2.ParamByName('D2').AsInteger := StrtoInt(formatDatetime('YYYYMMDD',D2.Date));
  if cdsReport2.Params.FindParam('SHOP_ID')<>nil then cdsReport2.ParamByName('SHOP_ID').AsString := token.shopId;
  cdsReport2.ParamByName('GODS_ID').AsString := gid;
  cdsReport2.ParamByName('BATCH_NO').AsString := bno;
  dataFactory.Open(cdsReport2);
  RzPanel5.Visible := true;
  RzLabel1.Caption := '"'+cdsReport1.FieldbyName('GODS_NAME').AsString+'" 商品的进出存流水';
  RzPanel11.Visible := false;
end;

procedure TfrmStorageReport.dateFlagPropertiesChange(Sender: TObject);
begin
  inherited;
  case dateFlag.ItemIndex of
  0:begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
      // D1.Properties.ReadOnly := true;
      // D2.Properties.ReadOnly := true;
    end;
  1:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYYMM01',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate;
      // D1.Properties.ReadOnly := true;
      // D2.Properties.ReadOnly := true;
    end;
  2:begin
      D1.Date := fnTime.fnStrtoDate(formatDatetime('YYYY0101',dllGlobal.SysDate));
      D2.Date := dllGlobal.SysDate();
      // D1.Properties.ReadOnly := true;
      // D2.Properties.ReadOnly := true;
    end;
  else
    begin
      D1.Date := dllGlobal.SysDate;
      D2.Date := dllGlobal.SysDate;
      // D1.Properties.ReadOnly := false;
      // D2.Properties.ReadOnly := false;
    end;
  end;
end;

procedure TfrmStorageReport.showForm;
var
  Column:TColumnEh;
  rs:TZQuery;
begin
  inherited;
  dateFlag.ItemIndex := 1;
  edtGODS_ID.DataSet := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');

  rs := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn(DBGridEH1,'UNIT_ID');
  rs.First;
  while not rs.Eof do
    begin
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      rs.Next;
    end;
end;

procedure TfrmStorageReport.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TfrmStorageReport.RzToolButton5Click(Sender: TObject);
begin
  inherited;
  OpenReport2(cdsReport1.FieldbyName('GODS_ID').AsString,cdsReport1.FieldbyName('BATCH_NO').AsString);
end;

procedure TfrmStorageReport.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsReport1.IsEmpty then Exit;
  OpenReport2(cdsReport1.FieldbyName('GODS_ID').AsString,cdsReport1.FieldbyName('BATCH_NO').AsString);
end;

procedure TfrmStorageReport.DBGridEh2DrawColumnCell(Sender: TObject;
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

procedure TfrmStorageReport.edtGODS_IDExit(Sender: TObject);
begin
  inherited;
  if trim(edtGODS_ID.Text)='' then
     begin
       edtGODS_ID.KeyValue := null;
       edtGODS_ID.Text := '全部商品';
     end;
end;

procedure TfrmStorageReport.edtGODS_IDClearValue(Sender: TObject);
begin
  inherited;
  edtGODS_ID.KeyValue := null;
  edtGODS_ID.Text := '全部商品';
end;

procedure TfrmStorageReport.sortDropExit(Sender: TObject);
begin
  inherited;
  if trim(sortDrop.Text)='' then
     begin
       FSortId := '';
       sortDrop.Text := '全部分类';
     end;
end;

procedure TfrmStorageReport.sortDropPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var Obj:TRecord_;
begin
  inherited;
  Obj := TRecord_.Create;
  try
    if frmSortDropFrom.DropForm(sortDrop,obj) then
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

procedure TfrmStorageReport.btnPriorClick(Sender: TObject);
begin
  inherited;
  if PageControl.ActivePageIndex>0 then PageControl.ActivePageIndex := PageControl.ActivePageIndex - 1;
  PageControlChange(nil);
  RzPanel11.Visible := true;  
end;

procedure TfrmStorageReport.PageControlChange(Sender: TObject);
begin
  inherited;
  btnPrior.Visible := PageControl.ActivePageIndex>0;
end;

procedure TfrmStorageReport.RzBmpButton4Click(Sender: TObject);
begin
  inherited;
  case PageControl.ActivePageIndex of
  0:OpenReport1;
  1:OpenReport2(cdsReport1.FieldbyName('GODS_ID').AsString,cdsReport1.FieldbyName('BATCH_NO').AsString);
  end;
end;

procedure TfrmStorageReport.cdsReport1BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav.Visible := false;
end;

procedure TfrmStorageReport.cdsReport2BeforeOpen(DataSet: TDataSet);
begin
  inherited;
  rowToolNav2.Visible := false;
end;

procedure TfrmStorageReport.DBGridPrint;
var
  ReStr:string;
begin
  case PageControl.ActivePageIndex of
  0:begin
      PrintDBGridEh1.DBGridEh := DBGridEh1;
      PrintDBGridEh1.PageHeader.CenterText.Text := '库存统计报表';
      ReStr:=FormatReportHead(WTitle1,4);
      DBGridEh1.DBGridTitle := '库存统计报表';
      DBGridEh1.DBGridHeader.Text := FormatExportHead(WTitle1,4);
      DBGridEh1.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    end;
  1:begin
      PrintDBGridEh1.DBGridEh := DBGridEh2;
      PrintDBGridEh1.PageHeader.CenterText.Text := '库存明细报表';
      ReStr:=FormatReportHead(WTitle2,4);
      DBGridEh2.DBGridTitle := '库存明细报表';
      DBGridEh2.DBGridHeader.Text := FormatExportHead(WTitle2,4);
      DBGridEh2.DBGridFooter.Text := ' '+#13+' 操作员:'+token.UserName+'  导出时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
    end;
  end;
  PrintDBGridEh1.AfterGridText.Text := #13+'打印人:'+token.UserName+'  打印时间:'+formatDatetime('YYYY-MM-DD HH:NN:SS',now());
  PrintDBGridEh1.SetSubstitutes(['%[whr]', ReStr]);
end;

procedure TfrmStorageReport.FormCreate(Sender: TObject);
begin
  inherited;
  WTitle1 := TStringList.Create;
  WTitle2 := TStringList.Create;
end;

procedure TfrmStorageReport.FormDestroy(Sender: TObject);
begin
  WTitle1.Free;
  WTitle2.Free;
  inherited;
end;

initialization
  RegisterClass(TfrmStorageReport);
finalization
  UnRegisterClass(TfrmStorageReport);
end.
