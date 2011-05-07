
unit ufrmPriceOrder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uframeOrderForm, DB, ADODB, ActnList, Menus, StdCtrls, Buttons,
  cxTextEdit, cxControls, cxContainer, cxEdit, cxMaskEdit, cxButtonEdit,
  zrComboBoxList, Grids, DBGridEh, ExtCtrls, RzPanel, cxDropDownEdit,
  cxCalendar, zBase, DBClient, RzButton, cxSpinEdit, cxTimeEdit, RzLabel,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmPriceOrder = class(TframeOrderForm)
    lblSTOCK_DATE: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    edtCHK_DATE: TcxTextEdit;
    Label9: TLabel;
    edtCHK_USER_TEXT: TcxTextEdit;
    edtREMARK: TcxTextEdit;
    edtBEGIN_DATE: TcxDateEdit;
    Label3: TLabel;
    edtEND_DATE: TcxDateEdit;
    edtBEGIN_TIME: TcxTimeEdit;
    edtEND_TIME: TcxTimeEdit;
    RzLabel1: TRzLabel;
    edtPRICE_ID: TcxComboBox;
    Btn_AddShop: TRzBitBtn;
    Btn_BatchPrice: TRzBitBtn;
    cdsHeader: TZQuery;
    cdsDetail: TZQuery;
    cdsShopList: TZQuery;
    Btn_View: TRzBitBtn;
    Label19: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure actImportFromPrintExecute(Sender: TObject);
    procedure DBGridEh1Columns3UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure Btn_AddShopClick(Sender: TObject);
    procedure Btn_BatchPriceClick(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1Columns10UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure Btn_ViewClick(Sender: TObject);
  private
    { Private declarations }
    w:integer;
    function CheckInput:boolean;override;
    function  GetColIdx(ColName: string): integer;
    procedure InitShopInfo(CdsShop: TDataSet; ShopID: string);
    procedure SetdbState(const Value: TDataSetState); override;
    procedure CheckPrice_Rate;  //判断明细数据的单价是否为0，指定折扣率：不为0
    procedure WriteAmount(UNIT_ID,PROPERTY_01,PROPERTY_02:string;Amt:real;Appended:boolean=false);override;
    procedure BulkAmount(UNIT_ID:string;Amt,Pri,mny:real;Appended:boolean=false);override;
  public
    { Public declarations }
    procedure CheckInvaid;override;
    procedure ReadFrom(DataSet:TDataSet);override;
    procedure WriteTo(DataSet:TDataSet);override;
    procedure InitPrice(GODS_ID,UNIT_ID:string);override;
    procedure NewOrder;override;
    procedure EditOrder;override;
    procedure DeleteOrder;override;
    procedure SaveOrder;override;
    procedure CancelOrder;override;
    procedure AuditOrder;override;
    procedure Open(id:string);override;
  end;

implementation
       // ufrmCheckTree,
uses
 uGlobal,uShopUtil,uFnUtil,uDsUtil, uShopGlobal,ufrmPrcCompList,ufrmBatchPmdPrice;

{$R *.dfm}

procedure TfrmPriceOrder.CancelOrder;
begin
  inherited;
  if dbState = dsInsert then
     NewOrder
  else
     Open(oid);
end;

procedure TfrmPriceOrder.DeleteOrder;
begin
  inherited;
  Saved := false;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能删除空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能删除');
  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能删除');
  if MessageBox(Handle,'是否真想删除当前单据?',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  cdsHeader.Delete;
  cdsDetail.First;
  while not cdsDetail.Eof do cdsDetail.Delete;
  cdsShopList.First;
  while not cdsShopList.Eof do cdsShopList.Delete;
  Factor.BeginBatch;
  try
    Factor.AddBatch(cdsHeader,'TPriceOrder', nil);
    Factor.AddBatch(cdsDetail,'TPriceData', nil);
    Factor.AddBatch(cdsShopList,'TPriceShopList', nil);
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
end;

procedure TfrmPriceOrder.EditOrder;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能修改空单据');
  if IsAudit then Raise Exception.Create('已经审核的单据不能修改'); 
//  if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能修改');
  dbState := dsEdit;
end;

procedure TfrmPriceOrder.FormCreate(Sender: TObject);
var
  rs: TZQuery;
  AObj:TRecord_;
  Column:TColumnEh;
begin
  inherited;
  dbState := dsBrowse;
  try
    edtPRICE_ID.Properties.Items.Clear;
    rs:=Global.GetZQueryFromName('PUB_PRICEGRADE'); 
    if rs.Active then
    begin
      AObj := TRecord_.Create;
      AObj.ReadFromDataSet(rs);
      AObj.FieldByName('PRICE_ID').AsString:='#';
      AObj.FieldByName('PRICE_NAME').AsString:='所有客户';
      AObj.FieldByName('PRICE_ID').FieldName := 'CODE_ID';
      AObj.FieldByName('PRICE_NAME').FieldName := 'CODE_NAME'; 
      edtPRICE_ID.Properties.Items.AddObject(AObj.FieldbyName('CODE_NAME').AsString,AObj);
      rs.First;
      while not rs.Eof do
      begin
        AObj := TRecord_.Create;
        AObj.ReadFromDataSet(rs);
        AObj.FieldByName('PRICE_ID').FieldName := 'CODE_ID';
        AObj.FieldByName('PRICE_NAME').FieldName := 'CODE_NAME';
        edtPRICE_ID.Properties.Items.AddObject(AObj.FieldbyName('CODE_NAME').AsString,AObj);
        rs.Next;
      end;
    end;
  finally
  end;
  rs := Global.GetZQueryFromName('PUB_MEAUNITS');
  Column := FindColumn('CALC_UNITS');
  if Column<>nil then
  begin
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
  Column := FindColumn('SMALL_UNITS');
  if Column<>nil then
  begin
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
  Column := FindColumn('BIG_UNITS');
  if Column<>nil then
  begin
  rs.First;
  while not rs.Eof do
    begin
      Column.KeyList.Add(rs.FieldbyName('UNIT_ID').AsString);
      Column.PickList.Add(rs.FieldbyName('UNIT_NAME').AsString);
      rs.Next;
    end;
  end;
end;

procedure TfrmPriceOrder.InitPrice(GODS_ID, UNIT_ID: string);
var
  rs: TZQuery;
begin
  edtTable.Edit;
  rs := TZQuery.Create(nil);
  try
     rs.SQL.Text:='select NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,SMALL_UNITS,CALC_UNITS,BIG_UNITS from VIW_GOODSPRICE '+
       ' where GODS_ID='''+GODS_ID+''' and TENANT_ID='+InttoStr(Global.TENANT_ID);
       // ' and GODS_FLAG=2 or (GODS_FLAG=1 and PRICE_FLAG=2)';
     Factor.Open(rs);
     {== 关闭下面代码: 现已没区分Pub_GoodsInfo和Bas_GoodsInfo:
     if rs.IsEmpty then
     begin
       rs.Close;
       rs.SQL.Text:='select NEW_OUTPRICE,NEW_OUTPRICE1,NEW_OUTPRICE2,SMALL_UNITS,CALC_UNITS,BIG_UNITS from VIW_GOODSPRICE where GODS_ID='''+GODS_ID+'''';
       Factor.Open(rs);
     end; }
     edtTable.FieldbyName('NEW_OUTPRICE').AsFloat := rs.FieldbyName('NEW_OUTPRICE').AsFloat;
     edtTable.FieldbyName('OUT_PRICE').AsFloat := rs.FieldbyName('NEW_OUTPRICE').AsFloat;
     edtTable.FieldbyName('OUT_PRICE1').AsFloat := rs.FieldbyName('NEW_OUTPRICE1').AsFloat;
     edtTable.FieldbyName('OUT_PRICE2').AsFloat := rs.FieldbyName('NEW_OUTPRICE2').AsFloat;
     edtTable.FieldbyName('SMALL_UNITS').AsString := rs.FieldbyName('SMALL_UNITS').AsString;
     edtTable.FieldbyName('BIG_UNITS').AsString := rs.FieldbyName('BIG_UNITS').AsString;
     edtTable.FieldbyName('CALC_UNITS').AsString := rs.FieldbyName('CALC_UNITS').AsString;
  finally
     rs.Free;
  end;
  edtTable.FieldbyName('ISINTEGRAL').AsInteger := 1;
  edtTable.FieldbyName('RATE_OFF').AsInteger := 0;
  edtTable.FieldbyName('BATCH_NO').asString := '#';
  edtTable.FieldbyName('UNIT_ID').asString := UNIT_ID;
  edtTable.FieldbyName('IS_PRESENT').AsInteger := 0;
end;

procedure TfrmPriceOrder.NewOrder;
begin
  inherited;
  Open('');
  dbState := dsInsert;
  edtPRICE_ID.ItemIndex:=0; //新单默认: 所有客户
  AObj.FieldbyName('PROM_ID').asString := TSequence.NewId();
  oid := AObj.FieldbyName('PROM_ID').asString;
  gid := '..新增..';//AObj.FieldbyName('GLIDE_NO').asString;
  edtBEGIN_DATE.Date := date();
  edtEND_DATE.Date := date()+7;
  edtBEGIN_TIME.Text:='00:00:00';
  edtEND_TIME.Text:='23:59:59';
  InitRecord;
  TabSheet.Caption := '..新建..';
  //促销门店默认为:当前登录门店
  InitShopInfo(cdsShopList,Global.SHOP_ID);
end;

procedure TfrmPriceOrder.Open(id: string);
var
  Params:TftParamList;
begin
  inherited;
  Params := TftParamList.Create(nil);
  try
    Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
    Params.ParamByName('PROM_ID').asString := id;
    Factor.BeginBatch;
    try
      Factor.AddBatch(cdsHeader,'TPriceOrder',Params);
      Factor.AddBatch(cdsDetail,'TPriceData',Params);
      Factor.AddBatch(cdsShopList,'TPriceShopList',Params);
      Factor.OpenBatch;
    except
      Factor.CancelBatch;
      Raise;
    end;
    AObj.ReadFromDataSet(cdsHeader);
    ReadFromObject(AObj,self);
    ReadFrom(cdsDetail);
    IsAudit := (AObj.FieldbyName('CHK_DATE').AsString<>'');
    oid := AObj.FieldbyName('PROM_ID').asString;
    gid := AObj.FieldbyName('GLIDE_NO').asString;
    dbState := dsBrowse;
  finally
    Params.Free;
  end;
end;

procedure TfrmPriceOrder.SaveOrder;
begin
  inherited;
  Saved := false;
  if edtBEGIN_DATE.EditValue = null then Raise Exception.Create('促销日期不能为空');
  if edtEND_DATE.EditValue = null then Raise Exception.Create('有效日期不能为空');
  if (edtPRICE_ID.ItemIndex=-1) or
     (TRecord_(edtPRICE_ID.Properties.Items.Objects[edtPRICE_ID.ItemIndex]).FieldByName('CODE_ID').AsString='') then
    Raise Exception.Create('  促销范围不能为空！  ');    
  ClearInvaid;
  if edtTable.IsEmpty then Raise Exception.Create('     不能保存一张空单据...     ');
  if cdsShopList.IsEmpty then Raise Exception.Create('    不能保存没有促销门店的单据，请重新选择促销门店...    ');
  CheckPrice_Rate; //判断价格、折扣率输入是否为空

  CheckInvaid;
  WriteToObject(AObj,self);
  AObj.FieldbyName('BEGIN_DATE').AsString := formatdatetime('YYYY-MM-DD',edtBEGIN_DATE.Date)+' '+edtBEGIN_TIME.TEXT;
  AObj.FieldbyName('END_DATE').AsString := formatdatetime('YYYY-MM-DD',edtEND_DATE.Date)+' '+edtEND_TIME.TEXT;
  AObj.FieldbyName('CREA_DATE').AsString := formatdatetime('YYYYMMDD',Date());
  AObj.FieldByName('CREA_USER').AsString := Global.UserID;
  AObj.FieldByName('SHOP_ID').AsString := Global.SHOP_ID;
  //AObj.FieldByName('BATCH_NO').AsString := AObj.FieldByName('PROM_ID').AsString;
  AObj.FieldbyName('TENANT_ID').AsInteger := Global.TENANT_ID;
  Factor.BeginBatch;
  try
    cdsHeader.Edit;
    AObj.WriteToDataSet(cdsHeader);
    cdsHeader.Post;
    WriteTo(cdsDetail);
    cdsDetail.First;
    while not cdsDetail.Eof do
       begin
         cdsDetail.Edit;
         cdsDetail.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
         cdsDetail.FieldByName('PROM_ID').AsString := cdsHeader.FieldbyName('PROM_ID').AsString;
         cdsDetail.Post;
         cdsDetail.Next;
       end;
    //促销门店写入企业ID和单号
    cdsShopList.First;
    while not cdsShopList.Eof do
    begin
      cdsShopList.Edit;
      cdsShopList.FieldByName('TENANT_ID').AsInteger := cdsHeader.FieldbyName('TENANT_ID').AsInteger;
      cdsShopList.FieldByName('PROM_ID').AsString := cdsHeader.FieldbyName('PROM_ID').AsString;
      cdsShopList.Post;
      cdsShopList.Next;
    end;
    //打包提交
    Factor.AddBatch(cdsHeader,'TPriceOrder',nil);
    Factor.AddBatch(cdsDetail,'TPriceData',nil);
    Factor.AddBatch(cdsShopList,'TPriceShopList',nil);
    Factor.CommitBatch;
    Saved := true;
  except
    Factor.CancelBatch;
    cdsHeader.CancelUpdates;
    cdsDetail.CancelUpdates;
    Raise;
  end;
  open(oid);
  dbState := dsBrowse;
end;

procedure TfrmPriceOrder.AuditOrder;
var
  Msg :string;
  Params:TftParamList;
begin
  inherited;
  if cdsHeader.IsEmpty then Raise Exception.Create('不能审核空单据');
  if dbState <> dsBrowse then SaveOrder;
  if IsAudit then
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能弃审');
       if cdsHeader.FieldByName('CHK_USER').AsString<>Global.UserID then Raise Exception.Create('只有审核人才能对当前促销单执行弃审');
       if MessageBox(Handle,'确认弃审当前促销单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end
  else
     begin
//       if copy(cdsHeader.FieldByName('COMM').AsString,1,1)= '1' then Raise Exception.Create('已经同步的数据不能再审核');
       if MessageBox(Handle,'确认审核当前促销单？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
     end;
  try
    Params := TftParamList.Create(nil);
    try
      Params.ParamByName('TENANT_ID').AsInteger := Global.TENANT_ID;
      Params.ParamByName('PROM_ID').asString := cdsHeader.FieldbyName('PROM_ID').AsString;
      Params.ParamByName('CHK_DATE').asString := FormatDatetime('YYYY-MM-DD',Global.SysDate);
      Params.ParamByName('CHK_USER').asString := Global.UserID;
      if not IsAudit then
         Msg := Factor.ExecProc('TPriceOrderAudit',Params)
      else
         Msg := Factor.ExecProc('TPriceOrderUnAudit',Params) ;
    finally
       Params.free;
    end;
    MessageBox(Handle,Pchar(Msg),Pchar(Application.Title),MB_OK+MB_ICONINFORMATION);
    IsAudit := not IsAudit;
    if IsAudit then
       begin
         edtCHK_DATE.Text := FormatDatetime('YYYY-MM-DD',Global.SysDate);
         edtCHK_USER_TEXT.Text := Global.UserName;
         AObj.FieldByName('CHK_DATE').AsString :=FormatDatetime('YYYY-MM-DD',Global.SysDate);
         AObj.FieldByName('CHK_USER').AsString :=Global.UserID;
       end
    else
       begin
         edtCHK_DATE.Text := '';
         edtCHK_USER_TEXT.Text := '';
         AObj.FieldByName('CHK_DATE').AsString := '';
         AObj.FieldByName('CHK_USER').AsString := '';
       end;
    cdsHeader.Edit;
    cdsHeader.FieldByName('CHK_DATE').AsString := AObj.FieldByName('CHK_DATE').AsString;
    cdsHeader.FieldByName('CHK_USER').AsString := AObj.FieldByName('CHK_USER').AsString;
    cdsHeader.Post;
    //cdsHeader.MergeChangeLog;
  except
    on E:Exception do
       begin
         Raise Exception.Create(E.Message);
       end;
  end;
end;

procedure TfrmPriceOrder.actImportFromPrintExecute(Sender: TObject);
var
  i:integer;
  s:string;
  rs:TRecordList;
  tmp:TZQuery;
begin
  inherited;
 { if dbState = dsBrowse then Exit;
  if not IsNull then
     if MessageBox(Handle,'已经有数据了是否清空并导入新的数据？',pchar(Application.Title),MB_YESNO+MB_ICONQUESTION)<>6 then Exit;
  rs := TRecordList.Create;
  try
    if TfrmCheckTree.ShowExecute(Global.GetZQueryFromName('PUB_GOODSSORT'),'SORT_ID','SORT_NAME','LEVEL_ID','33333333',rs) then
       begin
         s := '';
         for i:=0 to rs.Count -1 do
           begin
             if s <> '' then s := s + ',';
             s := s + ''''+rs.Records[i].FieldbyName('SORT_ID').AsString+'''';
           end;
         if s<>'' then s := ' and B.SORT_ID in ('+s+')';
         tmp := TZQuery.Create(nil);
         try
         finally
           tmp.Free;
         end;
       end;
  finally
    rs.Free;
  end; }
end;

procedure TfrmPriceOrder.ReadFrom(DataSet: TDataSet);
var
  i:integer;
begin
  edtTable.DisableControls;
  try
  edtProperty.Close;
  edtTable.Close;
  edtProperty.CreateDataSet;
  edtTable.CreateDataSet;
  RowID := 0;
  DataSet.First;
  while not DataSet.Eof do
    begin
      edtTable.Append;
      for i:=0 to edtTable.Fields.Count -1 do
        begin
          if DataSet.FindField(edtTable.Fields[i].FieldName)<>nil then
             edtTable.Fields[i].Value := DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value;
        end;
      inc(RowID);
      edtTable.FieldbyName('SEQNO').AsInteger := RowID;
      edtTable.FieldbyName('BARCODE').AsString := EnCodeBarcode;
      edtTable.Post;
      DataSet.Next;
    end;
  finally
    edtTable.EnableControls;
  end;
end;

procedure TfrmPriceOrder.WriteTo(DataSet: TDataSet);
var
  i,r:integer;
begin
  if DataSet.State in [dsEdit,dsInsert] then DataSet.Post;
  edtTable.DisableControls;
  try
  DataSet.First;
  while not DataSet.Eof do DataSet.Delete;
  edtTable.First;
  while not edtTable.Eof do
    begin
      DataSet.Append;
      inc(r);
      for i:=0 to edtTable.Fields.Count -1 do
        begin
          if DataSet.FindField(edtTable.Fields[i].FieldName)<>nil then
             DataSet.FieldbyName(edtTable.Fields[i].FieldName).Value := edtTable.Fields[i].Value;
        end;
      DataSet.FieldbyName('SEQNO').AsInteger := r;
      DataSet.Post;
      edtTable.Next;
    end;
  finally
    edtTable.EnableControls;
  end;
end;

procedure TfrmPriceOrder.DBGridEh1Columns3UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  rs: TZQuery;
  r:real;
begin
  inherited;
  try
    r := StrtoFloat(Text);
    if edtTable.FieldbyName('GODS_ID').AsString='' then Raise Exception.Create('没有选择商品不能输售价...'); 
    rs := TZQuery.Create(nil);
    try
       rs.SQL.Text := 'select BIGTO_CALC,SMALLTO_CALC from VIW_GOODSINFO where GODS_ID='''+edtTable.FieldbyName('GODS_ID').AsString+''' and TENANT_ID='+InttoStr(Global.TENANT_ID)+'';
       Factor.Open(rs);
       edtTable.FieldbyName('OUT_PRICE1').AsFloat := r * rs.FieldbyName('SMALLTO_CALC').AsFloat;
       edtTable.FieldbyName('OUT_PRICE2').AsFloat := r * rs.FieldbyName('BIGTO_CALC').AsFloat;
    finally
       rs.Free;
    end;
  except
    Value := null;
    Text := '';
    Raise;
  end;
end;

procedure TfrmPriceOrder.CheckInvaid;
begin
  inherited;

end;

procedure TfrmPriceOrder.Btn_AddShopClick(Sender: TObject);
begin
  inherited;
  //if dbState <> dsBrowse then Raise Exception.Create('请先保存促销单后，再发布生效门店...');
  TfrmPrcCompList.PrcCompList(self,cdsShopList,oid,self.dbState);
end;

procedure TfrmPriceOrder.Btn_BatchPriceClick(Sender: TObject);
begin
  inherited;
  TfrmBatchPmdPrice.BatchPrice(edtTable);
end;

procedure TfrmPriceOrder.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
var ColIdx: integer; ColName: string;
begin
  ColIdx:=GetColIdx('AGIO_RATE');
  if Key='-' then
  begin
    ColName:=trim(DBGridEh1.Columns[DBGridEh1.col].FieldName);
    if (ColName='OUT_PRICE') or (ColName='OUT_PRICE1') or (ColName='OUT_PRICE2') or (ColName='AGIO_RATE') then
      Key:=#0;
  end;
  {== 0:不打折; 1:再打折; 2:指定折(可输入再折扣率); ==}
  if (DBGridEh1.Col=ColIdx) and (DBGridEh1.DataSource.DataSet.Active) and
     (DBGridEh1.DataSource.DataSet.FieldByName('RATE_OFF').AsInteger<>2) then
  begin
    Key:=#0;
    if not (DBGridEh1.DataSource.DataSet.State in [dsInsert,dsEdit]) then
      DBGridEh1.DataSource.DataSet.Edit;
    DBGridEh1.DataSource.DataSet.FieldByName('AGIO_RATE').AsString:='';
  end;
  inherited;
end;

function TfrmPriceOrder.GetColIdx(ColName: string): integer;
var i: integer; CurName: string;
begin
  result:=-1;
  for i:=0 to DBGridEh1.Columns.Count-1 do
  begin
    CurName:=trim(LowerCase(DBGridEh1.Columns[i].FieldName));
    if CurName=trim(LowerCase(ColName)) then
      result:=i;
  end;
end;

procedure TfrmPriceOrder.InitShopInfo(CdsShop: TDataSet; ShopID: string);
var rs: TZQuery; str: string;
begin
  try
    CdsShop.Edit;
    CdsShop.FieldByName('ROWS_ID').AsString:=TSequence.NewId(); //单号码
    CdsShop.FieldByName('SHOP_ID').AsString:=ShopID;              //门号店
    //根据SHOP_ID取门店资料;
    rs:=TZQuery.Create(nil);
    rs.SQL.Text:='select 0 as A,SHOP_ID,SHOP_NAME,SHOP_SPELL,SHOP_TYPE,TENANT_ID,REGION_ID,LINKMAN,TELEPHONE,FAXES,ADDRESS,POSTALCODE,'+
      'REMARK,SEQ_NO from CA_SHOP_INFO where TENANT_ID=:TENANT_ID and COMM not in (''02'',''12'') and SHOP_ID=:SHOP_ID ';
    if rs.Params.FindParam('TENANT_ID')<>nil then rs.ParamByName('TENANT_ID').AsInteger:=Global.TENANT_ID;
    if rs.Params.FindParam('SHOP_ID')<>nil then rs.ParamByName('SHOP_ID').AsString:=ShopID;
    Factor.Open(rs);
    if rs.RecordCount=1 then
    begin
      CdsShop.FieldByName('SHOP_NAME').AsString:=rs.FieldByName('SHOP_NAME').AsString;
      CdsShop.FieldByName('SHOP_SPELL').AsString:=rs.FieldByName('SHOP_SPELL').AsString;
      CdsShop.FieldByName('SHOP_TYPE').AsString:=rs.FieldByName('SHOP_TYPE').AsString;
      CdsShop.FieldByName('REGION_ID').AsString:=rs.FieldByName('REGION_ID').AsString;
      CdsShop.FieldByName('LINKMAN').AsString:=rs.FieldByName('LINKMAN').AsString;
      CdsShop.FieldByName('TELEPHONE').AsString:=rs.FieldByName('TELEPHONE').AsString;
      CdsShop.FieldByName('FAXES').AsString:=rs.FieldByName('ADDRESS').AsString;
      CdsShop.FieldByName('POSTALCODE').AsString:=rs.FieldByName('POSTALCODE').AsString;
      CdsShop.FieldByName('REMARK').AsString:=rs.FieldByName('REMARK').AsString;
      CdsShop.FieldByName('SEQ_NO').AsString:=rs.FieldByName('SEQ_NO').AsString;
      CdsShop.Post;
    end else
      Raise Exception.Create('没找到门店档案...');
  finally
    rs.Free;
  end;
end;

{
var
  ColIdx: integer;
begin
  ColIdx:=GetColIdx('RATE_OFF');
  if (DBGridEh1.Col=ColIdx) and (DBGridEh1.DataSource.DataSet.Active) and
     (DBGridEh1.DataSource.DataSet.FieldByName('RATE_OFF').AsInteger=2) then
  begin
    if DBGridEh1.DataSource.DataSet.FieldByName('AGIO_RATE').AsFloat=0 then
    begin
      if not (DBGridEh1.DataSource.DataSet.State in [dsInsert,dsEdit]) then
        DBGridEh1.DataSource.DataSet.Edit;
      DBGridEh1.DataSource.DataSet.FieldByName('AGIO_RATE').AsFloat:=100;
      DBGridEh1.DataSource.DataSet.Post;
    end;
  end;
}

procedure TfrmPriceOrder.DBGridEh1Columns10UpdateData(Sender: TObject;
  var Text: String; var Value: Variant; var UseText, Handled: Boolean);
var
  IsEdit: Boolean;
begin
  if (DBGridEh1.DataSource.DataSet.Active) and (Value='2') then
  begin
    if DBGridEh1.DataSource.DataSet.FieldByName('AGIO_RATE').AsFloat=0 then
    begin
      IsEdit:=(DBGridEh1.DataSource.DataSet.State=dsEdit);
      if not (DBGridEh1.DataSource.DataSet.State in [dsInsert,dsEdit]) then
        DBGridEh1.DataSource.DataSet.Edit;
      DBGridEh1.DataSource.DataSet.FieldByName('AGIO_RATE').AsFloat:=100;
      DBGridEh1.DataSource.DataSet.Post;
      if (IsEdit) and (DBGridEh1.DataSource.DataSet.State<>dsEdit) then
        DBGridEh1.DataSource.DataSet.Edit;
    end;
  end else
  if (DBGridEh1.DataSource.DataSet.Active) and (Value<>'2') then
  begin
    if DBGridEh1.DataSource.DataSet.FieldByName('AGIO_RATE').AsFloat<>0 then
    begin
      IsEdit:=(DBGridEh1.DataSource.DataSet.State=dsEdit);
      if not (DBGridEh1.DataSource.DataSet.State in [dsInsert,dsEdit]) then
        DBGridEh1.DataSource.DataSet.Edit;
      DBGridEh1.DataSource.DataSet.FieldByName('AGIO_RATE').AsFloat:=0;
      DBGridEh1.DataSource.DataSet.Post;
      if (IsEdit) and (DBGridEh1.DataSource.DataSet.State<>dsEdit) then
        DBGridEh1.DataSource.DataSet.Edit;
    end;
  end;
end;

function TfrmPriceOrder.CheckInput: boolean;
begin
  result:=not (pos(inttostr(InputFlag),'1')>0);
end;

procedure TfrmPriceOrder.Btn_ViewClick(Sender: TObject);
begin
  inherited;
  TfrmPrcCompList.PrcCompList(self,cdsShopList,oid,dsBrowse);
end;

procedure TfrmPriceOrder.SetdbState(const Value: TDataSetState);
begin
  inherited;
  Btn_BatchPrice.Enabled:=(dbState<>dsBrowse);
  Btn_AddShop.Enabled:=(dbState<>dsBrowse);
end;

procedure TfrmPriceOrder.CheckPrice_Rate;
begin
  if not edtTable.Active then Exit;
  edtTable.First;
  while not edtTable.Eof do
  begin
    if (trim(edtTable.fieldbyName('CALC_UNITS').AsString)<>'') and (edtTable.fieldbyName('OUT_PRICE').AsFloat=0) then
      Raise Exception.Create(' 促销商品：'+edtTable.fieldbyName('GODS_NAME').AsString+'  计量单价不能为 0！  ');
    if (trim(edtTable.fieldbyName('SMALL_UNITS').AsString)<>'') and (edtTable.fieldbyName('OUT_PRICE1').AsFloat=0) then
      Raise Exception.Create(' 促销商品：'+edtTable.fieldbyName('GODS_NAME').AsString+'  包装1单价不能为 0！  ');
    if (trim(edtTable.fieldbyName('BIG_UNITS').AsString)<>'') and (edtTable.fieldbyName('OUT_PRICE2').AsFloat=0) then
      Raise Exception.Create(' 促销商品：'+edtTable.fieldbyName('GODS_NAME').AsString+'  包装2单价不能为 0！  ');
    if (trim(edtTable.fieldbyName('RATE_OFF').AsString)='2') and (edtTable.fieldbyName('AGIO_RATE').AsFloat=0) then
      Raise Exception.Create(' 促销商品：'+edtTable.fieldbyName('GODS_NAME').AsString+'  再折率不能为0！  ');
    edtTable.Next;
  end;
end;

procedure TfrmPriceOrder.BulkAmount(UNIT_ID: string; Amt, Pri, mny: real; Appended: boolean);
begin
  //条码输入数量覆盖掉原方法  
end;

procedure TfrmPriceOrder.WriteAmount(UNIT_ID, PROPERTY_01, PROPERTY_02: string; Amt: real; Appended: boolean);
begin
  //条码输入数量覆盖掉原方法  
end;

end.
