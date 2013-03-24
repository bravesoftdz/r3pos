unit ufrmDownStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzButton, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, StdCtrls,
  RzLabel, Menus, RzBmpBtn, jpeg;

type
  TfrmDownStockOrder = class(TfrmWebDialogForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    RzPanel4: TRzPanel;
    cdsTable: TZQuery;
    OrderDataSource: TDataSource;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    toolNav: TRzPanel;
    lblCaption: TRzLabel;
    RzPanel5: TRzPanel;
    DBGridEh1: TDBGridEh;
    btnOK: TRzBmpButton;
    RzPanel12: TRzPanel;
    btnPrint: TRzBmpButton;
    btnNav: TRzBmpButton;
    btnPreview: TRzBmpButton;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnOKClick(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Open;
    procedure Save;
    procedure ajustPostion;override;
  end;

implementation

uses uTokenFactory,udllGlobal,udllFnUtil,udataFactory,udllDsUtil;

{$R *.dfm}

procedure TfrmDownStockOrder.Open;
var
  rs: TZQuery;
  useDate,arrDate,whereCnd,orderStatus: string;
  vParam: TftParamList;
begin
  rs := dllGlobal.GetZQueryFromName('SYS_DEFINE');
  if (rs<>nil) and (rs.Active) then
    begin
      if rs.Locate('DEFINE','USING_DATE', []) then
        begin
          useDate := trim(rs.fieldbyName('VALUE').AsString);
          useDate := FormatDateTime('YYYYMMDD', fnTime.fnStrtoDate(useDate));
        end
      else
        useDate := FormatDateTime('YYYYMMDD', Date());
    end;

  vParam:=TftParamList.Create(nil);
  try
    cdsTable.Close;
    vParam.ParamByName('ExeType').AsInteger := 1;
    vParam.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    vParam.ParamByName('SHOP_ID').AsString := token.shopId;
    vParam.ParamByName('USING_DATE').AsString := useDate;
    dataFactory.MoveToRemote;
    try
      dataFactory.Open(cdsTable, 'TDownOrder', vParam);
    finally
      dataFactory.MoveToDefault;
    end;
  finally
    vParam.Free;
  end;

  //根据取出单据号。过滤查询本地库
  if not cdsTable.IsEmpty then
    begin
      cdsTable.DisableControls;
      //单机版过滤本地订单
      if dataFactory.iDbType = 5 then
        begin
          whereCnd:='';
          cdsTable.First;
          while not cdsTable.Eof do
            begin
              if whereCnd = '' then
                whereCnd := '''' + cdsTable.fieldbyName('INDE_ID').AsString + ''' '
              else
                whereCnd := whereCnd + ',''' + cdsTable.FieldByName('INDE_ID').AsString+''' ';
              cdsTable.Next;
            end;

          rs := TZQuery.Create(nil);
          try
            rs.SQL.Text:='select COMM_ID from STK_STOCKORDER where COMM_ID in ('+whereCnd+') ';
            dataFactory.Open(rs);
            rs.First;
            while not rs.Eof do
              begin
                if cdsTable.Locate('INDE_ID',trim(rs.FieldByName('COMM_ID').AsString),[]) then
                   cdsTable.Delete;
                rs.Next;
              end;
          finally
            rs.Free;
          end;
        end;

      //过滤启用日期：
      cdsTable.First;
      while not cdsTable.Eof do
        begin
          arrDate := trim(cdsTable.FieldByName('ARR_DATE').AsString);
          if (arrDate <> '') and (arrDate < useDate) then
            cdsTable.Delete
          else
            cdsTable.Next;
        end;

      //过滤掉状态为:
      cdsTable.First;
      while not cdsTable.Eof do
        begin
          orderStatus := trim(cdsTable.FieldByName('STATUS').AsString);
          if (orderStatus = '05') or (orderStatus = '06') then
            cdsTable.Next 
          else
            cdsTable.Delete;
        end;

      cdsTable.EnableControls;
    end;
  cdsTable.First;
  RzLabel2.Caption := inttostr(cdsTable.RecordCount);
end;

procedure TfrmDownStockOrder.Save;
  procedure AmountToCalc(orderDetail: TZQuery);
  var
    rs:TZQuery;
    SourceScale:Real;
  begin
    rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    if not rs.Locate('GODS_ID',orderDetail.FieldByName('GODS_ID').AsString,[]) then
      Raise Exception.Create('经营商品中没找到“'+orderDetail.FieldbyName('GODS_ID').AsString+'”');

    if not (orderDetail.State in [dsEdit,dsInsert]) then orderDetail.Edit;

    if orderDetail.FieldByName('UNIT_ID').AsString = rs.FieldByName('CALC_UNITS').AsString then
      begin
        SourceScale := 1;
      end
    else
    if orderDetail.FieldByName('UNIT_ID').AsString = rs.FieldByName('BIG_UNITS').AsString then
      begin
        SourceScale := rs.FieldByName('BIGTO_CALC').AsFloat;
      end
    else
    if orderDetail.FieldByName('UNIT_ID').AsString = rs.FieldByName('SMALL_UNITS').AsString then
      begin
        SourceScale := rs.FieldByName('SMALLTO_CALC').AsFloat;
      end
    else
      begin
        SourceScale := 1;
      end;
    orderDetail.FieldByName('CALC_AMOUNT').AsFloat := orderDetail.FieldByName('AMOUNT').AsFloat * SourceScale;
    orderDetail.Post;  
  end;

  procedure InitPrice(orderDetail: TZQuery);
  var rs:TZQuery;
  begin
    rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
    if not rs.Locate('GODS_ID',orderDetail.FieldByName('GODS_ID').AsString,[]) then
      Raise Exception.Create('经营商品中没找到“'+orderDetail.FieldbyName('GODS_ID').AsString+'”');

    if not (orderDetail.State in [dsEdit,dsInsert]) then orderDetail.Edit;

    orderDetail.FieldbyName('APRICE').AsFloat := dllGlobal.GetNewInPrice(orderDetail.FieldbyName('GODS_ID').AsString,orderDetail.FieldbyName('UNIT_ID').AsString);
    orderDetail.FieldbyName('ORG_PRICE').AsFloat := dllGlobal.GetNewOutPrice(orderDetail.FieldbyName('GODS_ID').AsString,orderDetail.FieldbyName('UNIT_ID').AsString);
    orderDetail.FieldbyName('AMONEY').AsString := FormatFloat('#0.00',orderDetail.FieldbyName('APRICE').AsFloat*orderDetail.FieldbyName('AMOUNT').AsFloat);
    orderDetail.FieldbyName('CALC_MONEY').AsString := FormatFloat('#0.00',orderDetail.FieldbyName('AMONEY').AsFloat);
    orderDetail.FieldbyName('AGIO_MONEY').AsString := FormatFloat('#0.00',orderDetail.FieldbyName('ORG_PRICE').AsFloat*orderDetail.FieldbyName('AMOUNT').AsFloat-orderDetail.FieldbyName('CALC_MONEY').AsFloat); //折扣金额(零售金额 - 进货金额)
    if orderDetail.FieldbyName('ORG_PRICE').AsFloat*orderDetail.FieldbyName('AMOUNT').AsFloat <> 0 then  //折扣率
      orderDetail.FieldbyName('AGIO_RATE').AsString := FormatFloat('#0.0',(orderDetail.FieldbyName('AMONEY').AsFloat*100.00)/(orderDetail.FieldbyName('ORG_PRICE').AsFloat*orderDetail.FieldbyName('AMOUNT').AsFloat))
    else
      orderDetail.FieldbyName('AGIO_RATE').AsString := '100';
    orderDetail.Post;
  end;

  procedure CopyDataSet(fromDataSet,toDataSet:TZQuery);
  var tmpObj:TRecord_;
  begin
    if toDataSet.IsEmpty then
      begin
        toDataSet.FieldDefs := fromDataSet.FieldDefs;
        toDataSet.CreateDataSet;
      end;
    tmpObj := TRecord_.Create;
    try
      fromDataSet.First;
      while not fromDataSet.Eof do
        begin
          tmpObj.ReadFromDataSet(fromDataSet);
          toDataSet.Append;
          tmpObj.WriteToDataSet(toDataSet);
          toDataSet.Post;
          fromDataSet.Next;
        end;
     finally
       tmpObj.Free;
     end;
  end;
var
  orderList,orderDetail,cdsData: TZQuery;
  cdsHeader,cdsDetail,rs: TZQuery;
  vParams: TftParamList;
  InVoiceFlag: integer;
  taxRate: Currency;
  deptId: string;
  seqNo: integer;
  sumAmt,sumMny: real;
begin
  inherited;
  orderList := TZQuery.Create(nil);
  orderDetail := TZQuery.Create(nil);
  cdsHeader := TZQuery.Create(nil);
  cdsDetail := TZQuery.Create(nil);
  try
    orderList.Data := cdsTable.Data;
    orderList.Filtered := false;
    orderList.Filter := 'SELFLAG=1';
    orderList.Filtered := true;

    if orderList.RecordCount < 1 then Raise Exception.Create('请选择需要入库的订单...');

    orderList.First;
    while not orderList.Eof do
      begin
        cdsData := TZQuery.Create(nil);
        vParams := TftParamList.Create(nil);
        dataFactory.MoveToRemote;
        try
          vParams.ParamByName('ExeType').AsInteger:=2;
          vParams.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
          vParams.ParamByName('INDE_ID').AsString := orderList.FieldByName('INDE_ID').AsString;
          dataFactory.Open(cdsData, 'TDownIndeData', vParams);
          CopyDataSet(cdsData, orderDetail);
        finally
          dataFactory.MoveToDefault;
          vParams.Free;
          cdsData.Free;
        end;
        orderList.Next;
      end;

    vParams := TftParamList.Create(nil);
    try
      vParams.ParamByName('VIW_GOODSINFO').AsString := dllGlobal.GetViwGoodsInfo('TENANT_ID,GODS_ID,GODS_CODE,GODS_NAME,BARCODE',true);
      vParams.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      vParams.ParamByName('SHOP_ID').AsString := token.shopId;
      vParams.ParamByName('STOCK_ID').AsString := '';
      dataFactory.BeginBatch;
      try
        dataFactory.AddBatch(cdsHeader, 'TStockOrderV60', vParams);
        dataFactory.AddBatch(cdsDetail, 'TStockDataV60', vParams);
        dataFactory.OpenBatch;
      except
        dataFactory.CancelBatch;
        Raise;
      end;
    finally
      vParams.Free;
    end;

    InVoiceFlag := StrtoIntDef(dllGlobal.GetParameter('IN_INV_FLAG'),1);
    case InVoiceFlag of
      1: taxRate := 0;
      2: taxRate := StrtoFloatDef(dllGlobal.GetParameter('IN_RATE2'),0.05);
      3: taxRate := StrtoFloatDef(dllGlobal.GetParameter('IN_RATE3'),0.17);
      else taxRate := 0;
    end;

    rs := dllGlobal.GetZQueryFromName('CA_USERS'); 
    rs.Filtered := false;
    if rs.Locate('USER_ID',token.userId,[]) then
       deptId := rs.FieldbyName('DEPT_ID').AsString;
 
    orderList.First;
    while not orderList.Eof do
      begin
        cdsHeader.Append;
        cdsHeader.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
        cdsHeader.FieldByName('SHOP_ID').AsString := token.shopId;
        cdsHeader.FieldByName('STOCK_ID').AsString := TSequence.NewId;
        cdsHeader.FieldByName('STOCK_TYPE').AsInteger := 1;
        cdsHeader.FieldByName('STOCK_DATE').AsInteger := strtoint(FormatDateTime('YYYYMMDD',now()));
        cdsHeader.FieldByName('GUIDE_USER').AsString := token.userId;
        cdsHeader.FieldByName('CLIENT_ID').AsString := orderList.FieldByName('CLIENT_ID').AsString;
        cdsHeader.FieldbyName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',now());
        cdsHeader.FieldByName('CHK_USER').AsString := token.userId;
        cdsHeader.FieldbyName('ADVA_MNY').AsFloat := 0;
        cdsHeader.FieldByName('INVOICE_FLAG').AsString := inttostr(InVoiceFlag);
        cdsHeader.FieldByName('TAX_RATE').AsFloat := taxRate;
        cdsHeader.FieldByName('REMARK').AsString := '<订单号:'+orderList.FieldByName('INDE_ID').AsString+'><订货日期:'+orderList.FieldByName('INDE_DATE').AsString+'> 需求量:'+orderList.FieldByName('NEED_AMT').AsString+' 审核量:'+orderList.FieldByName('INDE_AMT').AsString;
        cdsHeader.FieldbyName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD HH:NN:SS',now());
        cdsHeader.FieldByName('CREA_USER').AsString := token.userId;
        cdsHeader.FieldByName('COMM_ID').AsString := orderList.FieldByName('INDE_ID').AsString;
        cdsHeader.FieldByName('DEPT_ID').AsString := deptId;

        orderDetail.Filtered := false;
        orderDetail.Filter := 'INDE_ID='''+orderList.FieldByName('INDE_ID').AsString+'''';
        orderDetail.Filtered := true;

        seqNo := 1;
        sumAmt := 0;
        sumMny := 0;
        orderDetail.First;
        while not orderDetail.Eof do
          begin
            cdsDetail.Append;
            cdsDetail.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
            cdsDetail.FieldByName('SHOP_ID').AsString := token.shopId;
            cdsDetail.FieldByName('STOCK_ID').AsString := cdsHeader.FieldByName('STOCK_ID').AsString;
            cdsDetail.FieldByName('SEQNO').AsInteger := seqNo;
            cdsDetail.FieldByName('GODS_ID').AsString := orderDetail.FieldByName('GODS_ID').AsString;
            cdsDetail.FieldByName('PROPERTY_01').AsString := '#';
            cdsDetail.FieldByName('PROPERTY_02').AsString := '#';
            cdsDetail.FieldByName('BATCH_NO').AsString := '#';
            cdsDetail.FieldByName('UNIT_ID').AsString := orderDetail.FieldByName('UNIT_ID').AsString;
            cdsDetail.FieldByName('AMOUNT').AsFloat := orderDetail.FieldByName('AMOUNT').AsFloat;
            cdsDetail.FieldByName('IS_PRESENT').AsInteger := 0;
            cdsDetail.FieldByName('REMARK').AsString := '<订单号:'+orderDetail.FieldByName('INDE_ID').AsString+'> 需求量:'+orderDetail.FieldByName('NEED_AMT').AsString+' 审核量:'+orderDetail.FieldByName('CHK_AMT').AsString;
            cdsDetail.Post;
            AmountToCalc(cdsDetail);
            InitPrice(cdsDetail);
            inc(seqNo);
            sumAmt := sumAmt + cdsDetail.FieldByName('AMOUNT').AsFloat;
            sumMny := sumMny + cdsDetail.FieldByName('CALC_MONEY').AsFloat;
            orderDetail.Next;
          end;

        cdsHeader.FieldbyName('STOCK_AMT').AsFloat := sumAmt;
        cdsHeader.FieldByName('STOCK_MNY').AsFloat := sumMny;
        cdsHeader.FieldByName('PAY_ZERO').AsFloat := 0;
        cdsHeader.FieldByName('PAY_A').AsFloat := cdsHeader.FieldByName('STOCK_MNY').AsFloat;
        cdsHeader.FieldByName('PAY_B').AsFloat := 0;
        cdsHeader.FieldByName('PAY_C').AsFloat := 0;
        cdsHeader.FieldByName('PAY_D').AsFloat := 0;
        cdsHeader.FieldByName('PAY_E').AsFloat := 0;
        cdsHeader.FieldByName('PAY_F').AsFloat := 0;
        cdsHeader.FieldByName('PAY_G').AsFloat := 0;
        cdsHeader.FieldByName('PAY_H').AsFloat := 0;
        cdsHeader.FieldByName('PAY_I').AsFloat := 0;
        cdsHeader.FieldByName('PAY_J').AsFloat := 0;

        cdsHeader.Post;
        orderList.Next;
      end;

    cdsHeader.Filtered := false;
    cdsDetail.Filtered := false;

    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsHeader, 'TStockOrderV60');
      dataFactory.AddBatch(cdsDetail, 'TStockDataV60');
      dataFactory.CommitBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;

    orderList.First;
    while not orderList.Eof do
      begin
        if cdsTable.Locate('INDE_ID',orderList.FieldByName('INDE_ID').AsString,[]) then
          cdsTable.Delete
        else
          orderList.Next;
      end;
    RzLabel2.Caption := inttostr(cdsTable.RecordCount);
  finally
    orderList.Free;
    orderDetail.Free;
    cdsHeader.Free;
    cdsDetail.Free;
  end;
end;

procedure TfrmDownStockOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var ARect:TRect;
begin
  inherited;
  if (Rect.Top = DBGridEh1.CellRect(DBGridEh1.Col, DBGridEh1.Row).Top) and (not
    (gdFocused in State) or not DBGridEh1.Focused) then
  begin
    DBGridEh1.Canvas.Brush.Color := clWhite;
  end;

  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DbGridEh1.canvas.FillRect(ARect);
      DrawText(DbGridEh1.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
end;

procedure TfrmDownStockOrder.btnOKClick(Sender: TObject);
begin
  inherited;
  Save;
  MessageBox(Handle,'卷烟入库成功...','友情提示..',MB_OK);
end;

procedure TfrmDownStockOrder.DBGridEh1TitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.FieldName='SELFLAG' then
    begin
      N1Click(nil);
    end;
end;

procedure TfrmDownStockOrder.FormShow(Sender: TObject);
begin
  inherited;
  Open;
end;

procedure TfrmDownStockOrder.N1Click(Sender: TObject);
begin
  inherited;
  if not cdsTable.Active then Exit;
  if cdsTable.IsEmpty then Exit;
  cdsTable.DisableControls;
  try
    cdsTable.First;
    while not cdsTable.Eof do
      begin
        cdsTable.Edit;
        cdsTable.FieldByName('SELFLAG').AsInteger := 1;
        cdsTable.Post;
        cdsTable.Next;
      end;
  finally
    cdsTable.First;
    cdsTable.EnableControls;
  end;
end;

procedure TfrmDownStockOrder.N2Click(Sender: TObject);
begin
  inherited;
  if not cdsTable.Active then Exit;
  if cdsTable.IsEmpty then Exit;
  cdsTable.DisableControls;
  try
    cdsTable.First;
    while not cdsTable.Eof do
    begin
      cdsTable.Edit;
      if cdsTable.FieldByName('SELFLAG').AsInteger = 1 then
        cdsTable.FieldByName('SELFLAG').AsInteger := 0
      else
        cdsTable.FieldByName('SELFLAG').AsInteger := 1;
      cdsTable.Post;
      cdsTable.Next;
    end;
  finally
    cdsTable.First;
    cdsTable.EnableControls;
  end;
end;

procedure TfrmDownStockOrder.N3Click(Sender: TObject);
begin
  inherited;
  if not cdsTable.Active then Exit;
  if cdsTable.IsEmpty then Exit;
  cdsTable.DisableControls;
  try
    cdsTable.First;
    while not cdsTable.Eof do
      begin
        cdsTable.Edit;
        cdsTable.FieldByName('SELFLAG').AsInteger := 0;
        cdsTable.Post;
        cdsTable.Next;
      end;
  finally
    cdsTable.First;
    cdsTable.EnableControls;
  end;
end;

procedure TfrmDownStockOrder.ajustPostion;
begin
  inherited;
  RzPanel1.Top := (self.ClientHeight - RzPanel1.Height) div 2 - 1;
  RzPanel1.Left := (self.ClientWidth - RzPanel1.Width) div 2 - 1;
end;

initialization
  RegisterClass(TfrmDownStockOrder);
finalization
  UnRegisterClass(TfrmDownStockOrder);
end.

