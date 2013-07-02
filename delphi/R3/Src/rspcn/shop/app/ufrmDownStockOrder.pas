unit ufrmDownStockOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufrmWebDialogForm, ExtCtrls, RzPanel, RzButton, Grids, DBGridEh,
  DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, ZBase, StdCtrls,
  RzLabel, Menus, RzBmpBtn, jpeg, RzBckgnd, IniFiles, RzTabs;

type
  TfrmDownStockOrder = class(TfrmWebDialogForm)
    RzPanel1: TRzPanel;
    RzPanel2: TRzPanel;
    cdsTable: TZQuery;
    OrderDataSource: TDataSource;
    Image2: TImage;
    Image1: TImage;
    Image3: TImage;
    toolNav: TRzPanel;
    lblCaption: TRzLabel;
    cdsDetail: TZQuery;
    RzPageControl: TRzPageControl;
    TabSheet1: TRzTabSheet;
    TabSheet2: TRzTabSheet;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    DBGridEh1: TDBGridEh;
    rowToolNav: TRzToolbar;
    toolDetail: TRzToolButton;
    toolSave: TRzToolButton;
    toolSpacer: TRzSpacer;
    RzPanel3: TRzPanel;
    RzPanel6: TRzPanel;
    DBGridEh2: TDBGridEh;
    RzToolbar1: TRzToolbar;
    RzToolButton1: TRzToolButton;
    RzToolButton2: TRzToolButton;
    RzSpacer1: TRzSpacer;
    DetailDataSource: TDataSource;
    btnOk: TRzBmpButton;
    btnReturn: TRzBmpButton;
    RzLabel1: TRzLabel;
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure toolSaveClick(Sender: TObject);
    procedure cdsTableAfterDelete(DataSet: TDataSet);
    procedure toolDetailClick(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnReturnClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    licenseCode,shopName,comId,custId,rimUrl,downOrderMode:string;
    procedure ShowHeader;
    function GetDownOrderMode: string;
    function GetRimUrl: string;
  public
    procedure Open;
    procedure Save;
    procedure showForm;override;
    procedure ajustPostion;override;
  end;

implementation

uses uTokenFactory,udllGlobal,uFnUtil,udataFactory,udllDsUtil,uDownOrderFactory;

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
        useDate := FormatDateTime('YYYYMMDD', dllGlobal.SysDate);
    end;

  vParam:=TftParamList.Create(nil);
  try
    cdsTable.Close;
    vParam.ParamByName('ExeType').AsInteger := 1;
    vParam.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    vParam.ParamByName('SHOP_ID').AsString := token.shopId;
    vParam.ParamByName('USING_DATE').AsString := useDate;
    if downOrderMode = '1' then
       begin
         vParam.ParamByName('rimUrl').AsString := rimUrl;
         vParam.ParamByName('comId').AsString := comId;
         vParam.ParamByName('custId').AsString := custId;
         TDownOrderFactory.getOrderInfo(cdsTable,vParam);
       end
    else
       begin
         dataFactory.MoveToRemote;
         try
           dataFactory.Open(cdsTable, 'TDownOrder', vParam);
         finally
           dataFactory.MoveToDefault;
         end;
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
  rowToolNav.Visible := not cdsTable.IsEmpty;
  RzPageControl.ActivePageIndex := 0;
  ShowHeader;
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
  orderDetail,cdsData: TZQuery;
  cdsHeader,cdsDetail,rs: TZQuery;
  vParams: TftParamList;
  InVoiceFlag: integer;
  taxRate: Currency;
  deptId: string;
  seqNo: integer;
  sumAmt,sumMny: real;
begin
  inherited;
  orderDetail := TZQuery.Create(nil);
  cdsHeader := TZQuery.Create(nil);
  cdsDetail := TZQuery.Create(nil);
  try
    cdsData := TZQuery.Create(nil);
    vParams := TftParamList.Create(nil);
    try
      vParams.ParamByName('ExeType').AsInteger:=2;
      vParams.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
      vParams.ParamByName('INDE_ID').AsString := cdsTable.FieldByName('INDE_ID').AsString;
      if downOrderMode = '1' then
         begin
           vParams.ParamByName('rimUrl').AsString := rimUrl;
           vParams.ParamByName('comId').AsString := comId;
           vParams.ParamByName('custId').AsString := custId;
           TDownOrderFactory.getOrderDetail(cdsData,vParams);
         end
      else
         begin
           dataFactory.MoveToRemote;
           try
             dataFactory.Open(cdsData, 'TDownIndeData', vParams);
           finally
             dataFactory.MoveToDefault;
           end;
         end;
      CopyDataSet(cdsData, orderDetail);
    finally
      vParams.Free;
      cdsData.Free;
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
 
    cdsHeader.Append;
    cdsHeader.FieldByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    cdsHeader.FieldByName('SHOP_ID').AsString := token.shopId;
    cdsHeader.FieldByName('STOCK_ID').AsString := TSequence.NewId;
    cdsHeader.FieldByName('STOCK_TYPE').AsInteger := 1;
    cdsHeader.FieldByName('STOCK_DATE').AsInteger := strtoint(FormatDateTime('YYYYMMDD',now()));
    cdsHeader.FieldByName('GUIDE_USER').AsString := token.userId;
    cdsHeader.FieldByName('CLIENT_ID').AsString := cdsTable.FieldByName('CLIENT_ID').AsString;
    cdsHeader.FieldbyName('CHK_DATE').AsString := FormatDateTime('YYYY-MM-DD',now());
    cdsHeader.FieldByName('CHK_USER').AsString := token.userId;
    cdsHeader.FieldbyName('ADVA_MNY').AsFloat := 0;
    cdsHeader.FieldByName('INVOICE_FLAG').AsString := inttostr(InVoiceFlag);
    cdsHeader.FieldByName('TAX_RATE').AsFloat := taxRate;
    cdsHeader.FieldByName('REMARK').AsString := '<订单号:'+cdsTable.FieldByName('INDE_ID').AsString+'><订货日期:'+cdsTable.FieldByName('INDE_DATE').AsString+'> 需求量:'+cdsTable.FieldByName('NEED_AMT').AsString+' 审核量:'+cdsTable.FieldByName('INDE_AMT').AsString;
    cdsHeader.FieldbyName('CREA_DATE').AsString := FormatDateTime('YYYY-MM-DD HH:NN:SS',now());
    cdsHeader.FieldByName('CREA_USER').AsString := token.userId;
    cdsHeader.FieldByName('COMM_ID').AsString := cdsTable.FieldByName('INDE_ID').AsString;
    cdsHeader.FieldByName('DEPT_ID').AsString := deptId;

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
        cdsDetail.FieldByName('TAX_RATE').AsFloat := taxRate;
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

    dataFactory.BeginBatch;
    try
      dataFactory.AddBatch(cdsHeader, 'TStockOrderV60');
      dataFactory.AddBatch(cdsDetail, 'TStockDataV60');
      dataFactory.CommitBatch;
    except
      dataFactory.CancelBatch;
      Raise;
    end;

    cdsTable.Delete;
    ShowHeader;
  finally
    orderDetail.Free;
    cdsHeader.Free;
    cdsDetail.Free;
  end;
end;

procedure TfrmDownStockOrder.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
begin
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
      DrawText(DBGridEh1.Canvas.Handle,pchar(Inttostr(cdsTable.RecNo)),length(Inttostr(cdsTable.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh1.Canvas.Brush.Assign(br);
    DBGridEh1.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmDownStockOrder.ajustPostion;
begin
  inherited;
  RzPanel1.Top := (self.ClientHeight - RzPanel1.Height) div 2 - 1;
  RzPanel1.Left := (self.ClientWidth - RzPanel1.Width) div 2 - 1;
end;

procedure TfrmDownStockOrder.showForm;
var rs,ss:TZQuery;
begin
  inherited;
  ss := dllGlobal.GetZQueryFromName('CA_SHOP_INFO');
  licenseCode := ss.FieldByName('LICENSE_CODE').AsString;
  shopName := ss.FieldByName('SHOP_NAME').AsString;
  ShowHeader;
  downOrderMode := GetDownOrderMode;
  if downOrderMode = '1' then
     begin
       rimUrl := GetRimUrl;
       rs := TZQuery.Create(nil);
       try
         rs.SQL.Text := 'select COM_ID,CUST_ID from RM_CUST a,CA_SHOP_INFO b where a.LICENSE_CODE = b.LICENSE_CODE and b.SHOP_ID = :SHOP_ID';
         rs.ParamByName('SHOP_ID').AsString := token.shopId;
         dataFactory.MoveToRemote;
         try
           dataFactory.Open(rs);
         finally
           dataFactory.MoveToDefault;
         end;
         if rs.IsEmpty then Raise Exception.Create('rim中找不到对应零售户...');
         comId := rs.FieldByName('COM_ID').AsString;
         custId := rs.FieldByName('CUST_ID').AsString;
       finally
         rs.Free;
       end;
     end;
  Open;
end;

function TfrmDownStockOrder.GetDownOrderMode: string;
var F:TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'r3.cfg');
  try
    result := F.ReadString('soft','downOrderMode','0');
  finally
    try
      F.Free;
    except
    end;
  end;
end;

function TfrmDownStockOrder.GetRimUrl: string;
var
  F:TIniFile;
  List:TStringList;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0))+'db.cfg');
  List := TStringList.Create;
  try
    result := f.ReadString('H_'+f.ReadString('db','srvrId','default'),'srvrPath','');
    List.CommaText := result;
    result := List.Values['rim'];
    if result<>'' then
       begin
         if result[Length(result)]<>'/' then result := result+'/';
       end;
  finally
    List.free;
    try
      F.Free;
    except
    end;
  end;
end;

procedure TfrmDownStockOrder.toolSaveClick(Sender: TObject);
begin
  inherited;
  if not cdsTable.Active then Exit;
  Save;
  MessageBox(Handle,'卷烟入库成功...','友情提示..',MB_OK);
end;

procedure TfrmDownStockOrder.cdsTableAfterDelete(DataSet: TDataSet);
begin
  inherited;
  rowToolNav.Visible := not cdsTable.IsEmpty;
end;

procedure TfrmDownStockOrder.toolDetailClick(Sender: TObject);
var
  rs,us:TZQuery;
  cdsData:TZQuery;
  GodsId,UnitId:string;
  vParams:TftParamList;
begin
  inherited;
  cdsDetail.Close;
  cdsDetail.FieldDefs.Clear;
  cdsDetail.FieldDefs.Add('GODS_NAME',ftstring,36,true);
  cdsDetail.FieldDefs.Add('UNIT_NAME',ftstring,36,true);
  cdsDetail.FieldDefs.Add('AMOUNT',ftFloat,0,true);
  cdsDetail.FieldDefs.Add('APRICE',ftFloat,0,true);
  cdsDetail.FieldDefs.Add('AMONEY',ftFloat,0,true);
  cdsDetail.CreateDataSet;

  rs := dllGlobal.GetZQueryFromName('PUB_GOODSINFO');
  us := dllGlobal.GetZQueryFromName('PUB_MEAUNITS');
  cdsData := TZQuery.Create(nil);
  vParams := TftParamList.Create(nil);
  cdsDetail.DisableControls;
  try
    vParams.ParamByName('ExeType').AsInteger:=2;
    vParams.ParamByName('TENANT_ID').AsInteger := strtoint(token.tenantId);
    vParams.ParamByName('INDE_ID').AsString := cdsTable.FieldByName('INDE_ID').AsString;
    if downOrderMode = '1' then
       begin
         vParams.ParamByName('rimUrl').AsString := rimUrl;
         vParams.ParamByName('comId').AsString := comId;
         vParams.ParamByName('custId').AsString := custId;
         TDownOrderFactory.getOrderDetail(cdsData,vParams);
       end
    else
       begin
         dataFactory.MoveToRemote;
         try
           dataFactory.Open(cdsData, 'TDownIndeData', vParams);
         finally
           dataFactory.MoveToDefault;
         end;
       end;
    cdsData.First;
    while not cdsData.Eof do
      begin
        cdsDetail.Append;
        GodsId := cdsData.FieldByName('GODS_ID').AsString;
        UnitId := cdsData.FieldByName('UNIT_ID').AsString;
        if rs.Locate('GODS_ID',GodsId,[]) then
           cdsDetail.FieldByName('GODS_NAME').AsString := rs.FieldByName('GODS_NAME').AsString
        else
           Raise Exception.Create('订单中存在未经营的卷烟...');
        if us.Locate('UNIT_ID',UnitId,[]) then
           cdsDetail.FieldByName('UNIT_NAME').AsString := us.FieldByName('UNIT_NAME').AsString;
        cdsDetail.FieldByName('AMOUNT').AsFloat := cdsData.FieldByName('AMOUNT').AsFloat;
        cdsDetail.FieldByName('APRICE').AsFloat := cdsData.FieldByName('APRICE').AsFloat;
        cdsDetail.FieldByName('AMONEY').AsFloat := cdsData.FieldByName('AMONEY').AsFloat;
        cdsData.Next;
      end;
  finally
    cdsDetail.First;
    cdsDetail.EnableControls;
    cdsData.Free;
    vParams.Free;
  end;
  RzPageControl.ActivePageIndex := 1;
  ShowHeader;
end;

procedure TfrmDownStockOrder.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ARect:TRect;
  br:TBrush;
  pn:TPen;
begin
  br := TBrush.Create;
  br.Assign(DBGridEh2.Canvas.Brush);
  pn := TPen.Create;
  pn.Assign(DBGridEh2.Canvas.Pen);
  try
  if (Rect.Top = DBGridEh2.CellRect(DBGridEh2.Col, DBGridEh2.Row).Top) and (not
    (gdFocused in State) or not DBGridEh2.Focused or (Column.FieldName = 'TOOL_NAV')) then
  begin
    DBGridEh2.Canvas.Font.Color := clBlack;
    DBGridEh2.Canvas.Brush.Color := clWhite;
  end;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  if Column.FieldName = 'SEQNO' then
    begin
      ARect := Rect;
      DBGridEh2.canvas.Brush.Color := DBGridEh2.FixedColor;
      DBGridEh2.canvas.FillRect(ARect);
      DrawText(DBGridEh2.Canvas.Handle,pchar(Inttostr(cdsDetail.RecNo)),length(Inttostr(cdsDetail.RecNo)),ARect,DT_NOCLIP or DT_SINGLELINE or DT_CENTER or DT_VCENTER);
    end;
  finally
    DBGridEh2.Canvas.Brush.Assign(br);
    DBGridEh2.Canvas.Pen.Assign(pn);
    br.Free;
    pn.Free;
  end;
end;

procedure TfrmDownStockOrder.btnReturnClick(Sender: TObject);
begin
  inherited;
  RzPageControl.ActivePageIndex := 0;
  ShowHeader;
end;

procedure TfrmDownStockOrder.btnOkClick(Sender: TObject);
begin
  inherited;
  if not cdsTable.Active then Exit;
  Save;
  MessageBox(Handle,'卷烟入库成功...','友情提示..',MB_OK);
  RzPageControl.ActivePageIndex := 0;
  ShowHeader;
end;

procedure TfrmDownStockOrder.ShowHeader;
begin
  if RzPageControl.ActivePageIndex = 0 then
     begin
       if cdsTable.Active then
          RzLabel1.Caption := '许可证号：'+licenseCode+'，当前有 '+inttostr(cdsTable.RecordCount)+' 张订单'
       else
          RzLabel1.Caption := '许可证号：'+licenseCode+'，当前有 0 张订单';
     end
  else
     begin
       if cdsTable.Active then
          RzLabel1.Caption := '订货日期：'+cdsTable.FieldByName('INDE_DATE').AsString+'，送达日期：'+cdsTable.FieldByName('ARR_DATE').AsString
       else
          RzLabel1.Caption := '订单明细';
     end;
end;

procedure TfrmDownStockOrder.DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if cdsTable.IsEmpty then Exit;
  toolDetailClick(nil);
end;

initialization
  RegisterClass(TfrmDownStockOrder);
finalization
  UnRegisterClass(TfrmDownStockOrder);
end.

